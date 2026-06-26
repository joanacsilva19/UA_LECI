#include <detpic32.h>

int main(void)
{
    // Configure Timer T3 with interrupts enabled
    T3CONbits.TCKPS = 7;   // 1:256 prescaler
    PR3 = 39061;           // 2 Hz
    TMR3 = 0;
    T3CONbits.TON = 1;
    EnableInterrupts();
    
    while(1)
    {
      IdleMode(); // CPU enters Idle mode3 (CPU is halted, but peripherals continue to operate)
    }
    return 0;
}
  
void _int_(12) isr_T3(void) // Replace VECTOR by the timer T3 vector number
{
  putChar('.');
  // Reset T3 interrupt flag
  IFS0bits.T3IF = 0;
}
