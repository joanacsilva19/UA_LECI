#include <detpic32.h>

void delay(unsigned int ms);

void _int_(12) isr_adc(void);

void send2displays(unsigned char value, unsigned int enable );

unsigned char toBcd(unsigned char value);

int main(void){

	//config portos
	TRISBbits.RB4=1; //ativar potenciometro
	AD1PCFGbits.PCFG4 = 0; // RB4 configured as analog input (AN4)
	
	//config ADC
	TRISBbits.TRISB4 = 1; // RBx digital output disconnected
	AD1PCFGbits.PCFGx= 0; // RBx configured as analog input
	AD1CON1bits.SSRC = 7; // Conversion trigger selection bits: in this
	// mode an internal counter ends sampling and
	// starts conversion
	AD1CON1bits.CLRASAM = 1; // Stop conversions when the 1st A/D converter
	// interrupt is generated. At the same time,
	// hardware clears the ASAM bit
	AD1CON3bits.SAMC = 16; // Sample time is 16 TAD (TAD = 100 ns)
	AD1CON2bits.SMPI = 2-1; // Interrupt is generated after N samples
	// (replace N by the desired number of
	// consecutive samples)
	AD1CHSbits.CH0SA = 4; // replace x by the desired input
	// analog channel (0 to 15)
	AD1CON1bits.ON = 1; // Enable A/D converter
	// This must the last command of the A/D
	// configuration sequence
	
	//config t3
	T3CONbits.TCKPS = 2; // 1:4 prescaler (i.e Fout_presc = 625 KHz)                k=20Mhz/fout=2.17~=4  		140*65536=9175040
	PR3 = 35713; // Fout = 20MHz / (32 * (62499 + 1)) = 10 Hz
	TMR3 = 0; // Reset timer T3 count register
	T3CONbits.TON = 1; // Enable timer T3 (must be the last command of the
	// timer configuration sequence)
	
	//config interruption
	EnableInterrupts();
	IPC2bits.T3IP = 2; // Interrupt priority (must be in range [1..6])
	IEC0bits.T3IE = 1; // Enable timer T3 interrupts
	IFS0bits.T3IF = 0; // Reset timer T3 interrupt flag

	while(1){
		AD1CON1bits.ASAM = 1; 	// flag para começar a conversao
		while( IFS1bits.AD1IF == 0 ); // Wait while conversion not done
		unsigned int buffervalue = 0;
		unsigned int i;
		int *p = (int*) (&ADC1BUF0);
		for (i= 0 ; i<2; i++){
		    buffervalue += p[i*4];
		}
		buffervalue = (((buffervalue/2)*51)/1023)+15; //entender porque disto
		temp = toBcd(buffervalue);			//entender porque disto
		IFS1bits.AD1IF = 0;	//reset
		delay(100);		//1/100hz
	}
}

void delay(unsigned int ms){
	ms *= (unsigned int)(PBCLK / 1000);
	resetCoreTimer();
	while(setCoreTimer<PBCLK);
}

void send2displays(unsigned char value, unsigned int enable ){
    if (enable){
        static int displayFlag = 0;
        static const char display7Scodes[] = { 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x67, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71};
        if(displayFlag){  
            LATDbits.LATD5 = 1;
            LATDbits.LATD6 = 0;
            LATB = (LATB & 0x80FF) + (display7Scodes[value & 0xF] << 8);
        } else{
            LATDbits.LATD5 = 0;
            LATDbits.LATD6 = 1;
            LATB = (LATB & 0x80FF) + (display7Scodes[value >> 4] << 8);
        }
        displayFlag = !displayFlag;
    } else{
        LATDbits.LATD5 = 0;
        LATDbits.LATD6 = 0;
    }
}

void _int_(12) isr_adc(void){
 send2displays(temp, 1);
 IFS0bits.T2IF = 0;		// Reset timer T2 interrupt flag
}
unsigned char toBcd(unsigned char value){ 
   return ((value / 10) << 4) + (value % 10); 
  } 
