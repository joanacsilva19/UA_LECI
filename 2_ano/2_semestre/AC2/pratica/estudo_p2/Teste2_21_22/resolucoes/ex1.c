#include <detpic32.h>

void setPWM(unsigned int dutyCycle) {
	if(dutyCycle >= 0 && dutyCycle <= 100) // duty_cycle must be in the range [0, 100]
		OC2RS = ((PR2 + 1) * dutyCycle) / 100; // Determine OC1RS as a function of "dutyCycle"
}


int main(void){

	// Configurar as entradas
	
	TRISBbits.TRISB0 = 1;
	TRISBbits.TRISB3 = 1;
	
	// PWM 
	T2CONbits.TCKPS = 2; 	// 1:32 prescaler (i.e Fout_presc = 625 KHz)
	PR2 = 33333; 		// Fout = 20MHz / (32 * (62499 + 1)) = 10 Hz
	TMR2 = 0; 		// Reset timer T2 count register
	T2CONbits.TON = 1; 	// Enable timer T2 (must be the last command of the
				// timer configuration sequence)
	OC2CONbits.OCM = 6; 	// PWM mode on OCx; fault pin disabled
	OC2CONbits.OCTSEL =0;	// Use timer T2 as the time base for PWM generation
	OC2CONbits.ON = 1; 	// Enable OC1 module
	
	while(1) {
	
		if( PORTBbits.RB0 == 1 && PORTBbits.RB3 == 0){
			setPWM(25);
			//putChar('0'); 
		} else if( PORTBbits.RB0 == 0 && PORTBbits.RB3 == 1) {
			setPWM(70);
			//putChar('1');
		}
	}
	return 0;
}
