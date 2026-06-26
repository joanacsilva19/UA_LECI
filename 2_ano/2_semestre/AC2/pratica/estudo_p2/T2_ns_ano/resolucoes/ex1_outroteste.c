#include <detpic32.h>

void delay(unsigned int micros);			//k=20mhz/fout			fout=120*65536    K=2.5	20mhz/4=5mhz  (5mhz/120)-1

void setPwm(unsigned int x);

int main(void){
	//config portos
	TRISB |= 0x0005; //0101 LIGAR RB2 E RB0
	
	//config T3
	T3CONbits.TCKPS = 2; // 1:4 prescaler (i.e. fout_presc = 625 KHz)
	PR2 = 41665; // Fout = 20MHz / (32 * (62499 + 1)) = 10 Hz
	TMR3 = 0; // Clear timer T2 count register
	T3CONbits.TON = 1; // Enable timer T2 (must be the last command of the timer configuration sequence)
	OC3CONbits.OCM = 6; // PWM mode on OCx; fault pin disabled
	OC3CONbits.OCTSEL =0;// Use timer T3 as the time base for PWM generation
	OC3RS = 8333; // Ton constant
	OC3CONbits.ON = 1; // Enable OC3 module
	
	unsigned int x=75;
	
	while(1){
	if(PORTBbits.RB2==0 && PORTBbits.RB0==0){
		x=30;
	}
	if(PORTBbits.RB2==1 && PORTBbits.RB0==1){
		x=55;
	}
	delay(360);
	setPwm(x);
	}
}

void delay(unsigned int us){
	resetCoreTimer();
	while(PBCLK<(us*20));
}

void setPwm(unsigned int x){
	OC3RS=(PR3*x)/100;
}
