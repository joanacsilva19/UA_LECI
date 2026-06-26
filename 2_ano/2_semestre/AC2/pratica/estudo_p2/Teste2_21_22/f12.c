#include <detpic32.h>

volatile int voltage;

char tobcd(char val){
    return (val / 10 << 4) | val % 10;
}

void send2displays(unsigned char value)
{
        TRISD = TRISD & 0xFF9F;
        TRISB = TRISB & 0x80FF;

	static int displayFlag = 0;
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

int delay(unsigned int ms){
    resetCoreTimer();
    while(readCoreTimer() < ms);
}

void _int_(8) isr_T2(void) {
	send2displays(tobcd(voltage));		// 120 Hz -> freq de refrescamento
	IFS0bits.T2IF = 0; 
}

int main(void){

    TRISBbits.TRISB4 = 1; // RBx digital output disconnected
    AD1PCFGbits.PCFG4 = 0; // RBx configured as analog input
    AD1CON1bits.SSRC = 7; // Conversion trigger selection bits: in this
    AD1CON1bits.CLRASAM = 1;
    AD1CON3bits.SAMC = 16; // Sample time is 16 TAD (TAD = 100 ns)
    AD1CON2bits.SMPI = 2-1; // Interrupt is generated after N = 2 samples
    AD1CHSbits.CH0SA = 4; // replace x by the desired input
    AD1CON1bits.ON = 1;
    
    unsigned int freq = 20000000/120;
    
    // configurar o timer t2
    
    // k_prescaler = ceiling(20000000/((65535+1)*f_out)) = ceiling(20000000/((65535 + 1)*120))
    // = ceiling(3.54) = 4 // prescaler = 4
    // PR2 = (20000000/4)/120 - 1 = 41665.67 = 41666;
    
    T2CONbits.TCKPS = 2; // 1:4 prescaler
    PR2 = 41666;
    TMR2 = 0; // Reset timer T2 count register
    T2CONbits.TON = 1;
    
    IPC2bits.T2IP = 2; // Interrupt priority (must be in range [1..6])
    IEC0bits.T2IE = 1; // Enable timer T2 interrupts
    IFS0bits.T2IF = 0;
    
    EnableInterrupts();
    
    int mean = 0;
    while(1){
        AD1CON1bits.ASAM = 1; // Start conversion
        while( IFS1bits.AD1IF == 0 ); // Wait while conversion not done
        IFS1bits.AD1IF = 0;
        
        mean = (ADC1BUF0 + ADC1BUF1)/2;
        voltage = 15 + (mean*50 + 511)/1023;
        
        delay(freq);
    }
    return 0;


}


