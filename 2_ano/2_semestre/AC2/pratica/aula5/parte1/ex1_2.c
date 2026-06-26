#include <detpic32.h>

void delay(unsigned int ms)
{
  resetCoreTimer();
  while(readCoreTimer() < 20000 * ms);
}

void send2displays(unsigned char value)
{
	static const char disp7Scodes[] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F};
	int dh, dl;
	// select display high
	LATD = (LATD & 0X9F) | 0X20;
	// send digit_high (dh) to display:
	dh = value >> 4;
	LATB = (LATB & 0X80FF) | (disp7Scodes[dh] << 8);
	// select display low
	LATD = (LATD & 0X9F) | 0x40;
	// send digit_low (dl) to display:
	dl = (value & 0x0F);
	LATB = (LATB & 0XFF00) | disp7Scodes[dl];
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



