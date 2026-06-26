#include <detpic32.h>

int main(void)
{
  // Configure Timer T3 (2 Hz with interrupts disabled)
  T3CONbits.TCKPS = 7;   // 1:256 prescaler
  PR3 = 39061;           // 2 Hz
  TMR3 = 0;
  T3CONbits.TON = 1;

  while(1)
  {
    // Wait while T3IF = 0
    while(IFS0bits.T3IF == 0);
    
    // Reset T3IF
    IFS0bits.T3IF = 0;
    
    putChar('.');
  }
return 0;
}
