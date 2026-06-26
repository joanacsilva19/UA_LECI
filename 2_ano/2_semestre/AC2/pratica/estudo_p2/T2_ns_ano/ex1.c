#include <detpic32.h>

void setPWM(unsigned int dutyCycle){
  if(dutyCycle > 0 && dutyCycle <= 100){
    OC2RS = ((41666 + 1)* dutyCycle)/100;
  }
}

void delay(unsigned int ps){
  resetCoreTimer();
  while(readCoreTimer() < ps*1000);

}

void conf_T3(){
  // k_Prescaler = ceiling(20000000/((65535+1)*120)) = ceiling(2.54) = 3
  // prescaler = 4
  // PR2 = (20000000/4/120) - 1 = 41665.67

  T3CONbits.TCKPS = 2;
  PR3 = 41666;
  TMR3 = 0;
  T3CONbits.TON = 1;

}

int main(void){
  // configurar switches como inputs
  TRISBbits.TRISB0 = 1;
  TRISBbits.TRISB2 = 1;

  OC2CONbits.OCM = 6;
  OC2CONbits.OCTSEL = 0;

  conf_T3();
  
  unsigned int dutyCycle = 70;
  unsigned int ps = 360;
  
  while(1){
    if(PORTBbits.RB0 == 0 && PORTBbits.RB2 == 0){
      dutyCycle = 30;
      //putChar('0');
    }else if(PORTBbits.RB0 == 1 && PORTBbits.RB2 == 1){
      dutyCycle = 55;
    //putChar('1');
    }
    delay(ps);
    //putChar('2');
  
  }
  return 0;
}


