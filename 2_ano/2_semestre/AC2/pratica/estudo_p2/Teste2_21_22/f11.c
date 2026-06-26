#include <detpic32.h>

void setPWM(unsigned int dutyCycle)
{
  // duty_cycle must be in the range [0, 100]
  if(dutyCycle >= 0 && dutyCycle <=100){
      // Determine OC2RS as a function of "dutyCycle"
      OC2RS = ((33332 + 1) * dutyCycle)/100; 
  }
}

void delay(unsigned int ps){
    resetCoreTimer();
    while(readCoreTimer() < (ps*1000)); // ps*1000 (ms)
}

int main(void){
    // PBCLK = 20*10⁶ Hz
    // f_out = 150 Hz
    // K_prescaler = ceiling(PBCLK/((65535 + 1) * f_out)) = ceiling(2.034) = 3; prescaler = 4
    // PR2 = ((PBCLK/4)/f_out)-1 = 33332.33
    
    T2CONbits.TCKPS = 2; // 1:4 prescaler
    PR2 = 33332;
    TMR2 = 0; // Reset timer T2 count register
    T2CONbits.TON = 1; // Enable timer T2 (must be the last command of the
    // timer configuration sequence)
    OC2CONbits.OCM = 6; // PWM mode on OCx; fault pin disabled
    OC2CONbits.OCTSEL = 0;// Use timer T2 as the time base for PWM generation
    OC2CONbits.ON = 1; // Enable OC2 module
    
    TRISBbits.TRISB0 = 1;
    TRISBbits.TRISB3 = 1; // configurar switches como inputs;
    setPWM(25); // configuracao inicial do duty cycle
    putChar('a');
    
    while(1){
        if(PORTBbits.RB0 == 1 && PORTBbits.RB3 == 0){
            setPWM(25);
            putChar('0');
        }else if(PORTBbits.RB0 == 0 && PORTBbits.RB3 == 1){
            setPWM(70);
            putChar('1');
        }else{putChar('2');}
        // 250 ps
        delay(250);
    }
    return 0;
}


