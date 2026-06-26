#include <detpic32.h>

unsigned int temperature_bcd = 0;

/* funcion de delay */

void delay(unsigned int divider) {
	resetCoreTimer();
	while(readCoreTimer() < divider);
}

/* transformar valor he'x to decimal */
/* func "toBdcd()" 					*/

unsigned int toBcd(unsigned int number) { // apresentar valor decimal nos displays
	return (((number / 10) << 4) | (number % 10));	// primeros 4 bits son digit low, siguientes 4 bits son digit high 
}

/* creacion de rutina de interrupcion */

void _int_(12) isr_t3(void) {
	
	static unsigned int flag = 1;
	static unsigned char displayseg [] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x67, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71};
	unsigned int dh, dl; // digit high y digit low
	
	dl = (temperature_bcd & 0x0F);// solo necesitamos de los primeros 4 bits
	dh = ((temperature_bcd >> 4) & 0x0F);

	if (flag == 0) {
		LATD = (LATD & 0xFF9F) | (0x0020); // selecionar para lo display menos significativo, RD5
		LATB = (LATB & 0x80FF) | (displayseg[dl] << 8);// empieza en el bit 8
		
		flag = 1;
	} else {
		LATD = (LATD & 0xFF9F) | (0x0040); // selecionar para lo display más significativo, RD6
		LATB = (LATB & 0x80FF) | (displayseg[dh] << 8);
		
		flag = 0;
		IFS0bits.T3IF = 0;	// reset flag
}
}

int main(void) {

	/* declaracion de variables */
	
	unsigned int media = 0;
	unsigned int N = 2;
	unsigned int voltage;
	unsigned int temperature = 0;
	int i;
	int *p = (int *)(&ADC1BUF0);
	
	/* configuracion de bits entrada o salida */
	
	TRISD = (TRISD & 0xFF9F);	// bits 5 y 6 como salida
	TRISB = (TRISB & 0x80FF) | 0x0010;	// bits 14 hasta 8 como salida y ativamos la salida RB4
	
	/* configuracion Timer T3 */
	
	T3CONbits.TCKPS = 2;	// prescaler 4
	PR3 = 35713; 			// 140 Hz
	TMR3 = 0; 				// reset timer T3
	T3CONbits.TON = 1; 		// enable Timer T3
	
	/* interrupciones Timer T3 */
	
	IFS0bits.T3IF = 0;	// reset flag
	IEC0bits.T3IE = 1;	// enable T3e
	IPC3bits.T3IP = 2;	// prioridad de timer3
	
	/* configuracion ADC */
	
	TRISBbits.TRISB4 = 1; 
	AD1PCFGbits.PCFG4= 0; 
	AD1CON1bits.SSRC = 7;
	AD1CON1bits.CLRASAM = 1;
	AD1CON3bits.SAMC = 16; 
	AD1CON2bits.SMPI = N-1;
	AD1CHSbits.CH0SA = 4; 
	AD1CON1bits.ON = 1;
	
	/* fin de configuracion ADC */
	
	EnableInterrupts();
	
	while(1) {
		media = 0;
		
		AD1CON1bits.ASAM = 1;		// comienza conversion
		while(IFS1bits.AD1IF == 0);	// hasta acabar las conversiones
		
		IFS1bits.AD1IF = 0;
		
		for (i = 0; i < 2; i++) {
			media += p[i*4];
		}
		media /= N;
		
		voltage = ((media * 33) + 511) / 1023; // calcula el valor de la voltage
		temperature = (((voltage * 65 + 15) / 33)) + 10;	// regla de 3 para calcular temperatura de salida
		temperature_bcd = toBcd(temperature);
		delay(2000000); //20000000/10
	}
	return 0;
}
