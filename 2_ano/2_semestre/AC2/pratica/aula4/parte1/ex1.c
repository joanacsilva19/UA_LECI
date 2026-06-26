#include <detpic32.h>

void delay(unsigned int ms){
  resetCoreTimer();
  while(readCoreTimer() < 20000 * ms);
}

int main(void)
{
  // Configure port RC14 as output
  TRISCbits.TRISC14 = 0;
  
  while(1)
  {
    // Wait 0.5s
    delay(500);
    LATC = LATC ^ 0x4000; // Toggle RC14 port value
  }
return 0;
}
