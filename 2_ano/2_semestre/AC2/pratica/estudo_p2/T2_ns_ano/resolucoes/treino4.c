#include <detpic32.h>

void setPwm(unsigned int y);

void delay();

int main (void){

	//config portos
	TRISB |= 0X0005;
	//config T3
	T3CONbits.TCKPS = 2; // 1:4 prescaler (i.e Fout_presc = 625 KHz)			k=20MHZ/f		65536*120			
	PR3 = 41665; // Fout = 20MHz / (32 * (62499 + 1)) = 10 Hz				5mhz			(5mhz/120)-1
	TMR3 = 0; // Reset timer T2 count register
	T3CONbits.TON = 1; // Enable timer T2 (must be the last command of the
	// timer configuration sequence)
	OC2CONbits.OCM = 6; // PWM mode on OCx; fault pin disabled
	OC2CONbits.OCTSEL =1;// Use timer T2 as the time base for PWM generation
	OC2RS = 31249; // Ton constant
	OC2CONbits.ON = 1; // Enable OC1 module
	
	unsigned int x = 75;
	
	while(1){
	if(PORTBbits.RB2 == 0 && PORTBbits.RB0 == 0){
		x = 30;
	}
	if(PORTBbits.RB2 == 1 && PORTBbits.RB0 == 1){
		x = 55;
	}
	setPwm(x);
	delay();
	}
	return 0;
}

void setPwm(unsigned int y){
	OC2RS = (PR3*y)/100;
}

void delay(){
	resetCoreTimer();
	while(readCoreTimer < 7200);									// 1/20000000
}
