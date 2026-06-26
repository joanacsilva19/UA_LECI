#include <detpic32.h>

volatile unsigned int temperature_bcd;

unsigned int to_bcd(unsigned int number){
	return ((number / 10) << 4) | (number % 10);
}

void delay(unsigned int ms){
	resetCoreTimer();
	while(readCoreTimer() < ms);
}

void _int_(12) isr_adc(void){
	unsigned int flag = 0;
	unsigned int dl,dh;
	display7scodes[]={};
	dl = temperature_bcd & 0x0F;
	dh = (temperature_bcd >> 4) & 0x0F;
	
	if(flag=0){
	LATD = (LATD & 0xFF9F) | 0x0020;
	LATB = (LATB & 0x80FF) | (display7scodes[temperature_bcd] >> 4);
	flag=1;
	}
	else{
	LATD = (LATD & 0xFF9F) | 0x0040;
	LATB = (LATB & 0x80FF) | (display7scodes[temperature_bcd] >> 4);
	flag = 0;
	IFS0bits.T3IF = 0; 
	}
}

int main(void){
	//variaveis usadas
	unsigned int N = 2;
	unsigned int voltage;
	int *p;
	int media = 0;
	
	//config portos
	TRISD &= 0xFF9F; // ativar rd5 e rd6 para ambos os displays
	TRISB = (TRISB & 0x80FF) | 0x0010; // ativar rb8 ate rb14 e tambem rb4(potenciometro)
	
	//config timer3
	T3CONbits.TCKPS = 5; // 1:32 prescaler (i.e Fout_presc = 625 KHz)
	PR3 = 62499; 
	TMR3 = 0; 
	T3CONbits.TON = 1; 
	
	//config interrupçao
	IPC3bits.T3IP = 2; 
	IEC0bits.T3IE = 1; 
	IFS0bits.T3IF = 0; 
	EnableInterrupts();
	
	//config AD
	TRISBbits.TRISB4 = 1; 
	AD1PCFGbits.PCFG4= 0; 
	AD1CON1bits.SSRC = 7;
	AD1CON1bits.CLRASAM = 1; 
	AD1CON3bits.SAMC = 16; 
	AD1CON2bits.SMPI = N-1; 
	AD1CHSbits.CH0SA = 4; 
	AD1CON1bits.ON = 1; 
	
	while(1){
	AD1CON1bits.ASAM = 1; // Start conversion
	while( IFS1bits.AD1IF == 0 ); // Wait while conversion not done
	IFS1bits.AD1IF = 0;
	
	for(int i = 0;i < N;i++){
		media+=p[i*4];
	}
	media /= N;
	voltage = (((media * 65)+511)/1023)+10;
	temperature_bcd = to_bcd(voltage);
	delay(5000000); // 20mhz/5
	}
	return 0;
}
