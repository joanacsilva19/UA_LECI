#include <detpic32.h>

volatile int voltage;

void delay(int ms) {
    for(; ms>0; ms--) {
	    resetCoreTimer();
	    while(readCoreTimer() < 20000);
    }
}

void send2displays(unsigned char value)
{
	static int displayFlag =0;
	static const char display7Scodes [] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71}; 
	
	unsigned char dh = value >> 4;
	unsigned char dl = value & 0x0F;
	
	dh = display7Scodes[dh];
	dl = display7Scodes[dl];
	
	if(displayFlag == 0)
	{
		LATD = (LATD & 0xFF9F) | 0x0040;
		LATB = (LATB & 0x80FF) |((unsigned int)(dh)) << 8; 
	}else {
		LATD = (LATD & 0xFF9F) | 0x0020;
		LATB = (LATB & 0x80FF) |((unsigned int)(dl)) << 8; 
			
	}
	displayFlag = !displayFlag;	
}

unsigned char toBcd( unsigned char value) {
	return (((value/10) << 4) + (value % 10));
}

void _int_(8) isr_T2(void) {
	send2displays(toBcd(voltage));		// 120 Hz -> freq de refrescamento
	IFS0bits.T2IF = 0; 
}

int main(void) {

	TRISB &= 0x80FF;
	TRISD &= 0xFF9F;

//configurar ADC
	TRISBbits.TRISB4 = 1; 
	AD1PCFGbits.PCFG4= 0; 
	AD1CON1bits.SSRC = 7; 
	AD1CON1bits.CLRASAM = 1; 
	AD1CON3bits.SAMC = 16; 
	AD1CON2bits.SMPI = 2-1; 
	AD1CHSbits.CH0SA = 4; 
	AD1CON1bits.ON = 1; 
	
//configurar T2 -> 120Hz
	T2CONbits.TCKPS = 2; 
	PR2 = 41665; 
	TMR2 = 0; 
	T2CONbits.TON = 1; 
	
	IPC2bits.T2IP = 2; 
	IEC0bits.T2IE = 1; 
	IFS0bits.T2IF = 0; 
	
	EnableInterrupts();

	int mean = 0;
	while(1) {
		AD1CON1bits.ASAM = 1; // Start conversion
		while( IFS1bits.AD1IF == 0 ); // Wait while conversion not done
		IFS1bits.AD1IF = 0;
		
		mean = (ADC1BUF0 + ADC1BUF1)/2;
		voltage = 15 + (mean*50 + 511)/1023;
				
		delay(100);		// 10Hz -> freq de ADC
	}
return 0;
}
