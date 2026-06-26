#include <detpic32.h>

void delay(unsigned int ms)
{
  resetCoreTimer();
  while(readCoreTimer() < 20000 * ms);
}


void send2displays(unsigned char value)
{
  static const char disp7Scodes[] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F};
  static char displayFlag = 0; // static variable: doesn't loose its
  // value between calls to function
  int digit_low = value & 0x0F;
  int digit_high = value >> 4;
  // if "displayFlag" is 0 then send "digit_low" to display_low
  // else send "digit_high" to display_high
  if(displayFlag == 0){
    LATDbits.LATD5 = 1;
    LATDbits.LATD6 = 0;
    LATB = (LATB & 0XFF80) | disp7Scodes[digit_low];
  }else{
    LATDbits.LATD5 = 0;
    LATDbits.LATD6 = 1;
    LATB = (LATB & 0XFF80) | (disp7Scodes[digit_high]);
  }

  // toggle "displayFlag" variable
  displayFlag = !displayFlag;
  
}

int main(void)
{
  // configure RB8-RB14 as outputs
  TRISB = TRISB & 0X00FF;
  // configure RD5-RD6 as outputs
  TRISD = TRISD & 0XFF9F;
  while(1)
  {
    send2displays(0x15);
    // wait 0.2s
    delay(200);
  }
}
