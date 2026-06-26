#include <detpic32.h>

int main(void)
{
  volatile int aux; // See note on page 6
  unsigned int tempo;
  TRISDbits.TRISD11 = 0;
  AD1PCFGbits.PCFG11 = 1;
  AD1CON1bits.SSRC = 7; // Configure A/D module; configure RD11 as a digital output port

  AD1CON1bits.CLRASAM = 1;
  
  AD1CON3bits.SAMC = 16;
  AD1CON2bits.SMPI = 0;
  
  AD1CHSbits.CH0SA = 4;
  
  AD1CON1bits.ON = 1;

  while(1)
  {
    // Start conversion
    AD1CON1bits.ASAM = 1;
    // Set LATD11 (LATD11=1)
    LATDbits.LATD11 = 1;
    // Wait while conversion not done (AD1IF == 0)
    resetCoreTimer();
    while(IFS1bits.AD1IF == 0);
    tempo = readCoreTimer();
    printInt(tempo, 16 | 3 << 16);
    // Reset LATD11 (LATD11=0)
    LATDbits.LATD11 = 0;
    // Read conversion result (ADC1BUF0) to "aux" variable
    aux = ADC1BUF0;
    putChar('\r');
    // Reset AD1IF (should be done after reading the conversion result)
    IFS1bits.AD1IF = 0;
  }
  return 0;
}
