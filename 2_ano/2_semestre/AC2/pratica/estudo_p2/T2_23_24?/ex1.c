#include <detpic32.h>

void conf_T3(void){
  // prescaler = ceiling(20000000/((65535+1)*130)) = ceiling(2.34) = 3
  // prescaler = 4
  // PR3 = (20000000/4/130)-1 = 38460.53 = 38461

  T3CONbits.TCKPS = 2; // 1:4 prescaler (i.e Fout_presc = 625 KHz)
  PR3 = 38461; // Fout = 20MHz / (32 * (62499 + 1)) = 10 Hz
  TMR2 = 0; // Reset timer T2 count register
  T3CONbits.TON = 1; // Enable timer T2 (must be the last command of the
  // timer configuration sequence)
}

void set_PWM(unsigned int dutyCycle){
  if(dutyCycle > 0 && dutyCycle <= 100){
    OC4RS = ((38461 + 1) * dutyCycle)/ 100;
  }
}

int delay(unsigned int ms){
  resetCoreTimer();
  while(readCoreTimer() < ms);
}
  
int main(void){

TRISBbits.TRISB1 = 1;

OC4CONbits.OCM = 6; // PWM mode on OCx; fault pin disabled
OC4CONbits.OCTSEL =0;// Use timer T2 as the time base for PWM generation
OC4CONbits.ON = 1; // Enable OC1 module

conf_T3();
set_PWM(50); // dutyCycle inicial = 50;

while(1){

  if(PORTBbits.RB1 == 0){
    set_PWM(25);
    putChar('s');
    delay(1300);
    set_PWM(75);
    delay(1300);
  } else {
  putChar('t');
  }
}
}







