#include <detpic32.h>

void delay(unsigned int ms){
resetCoreTimer();
while(readCoreTimer() < ms);
}

int main(void){

  static const char disp7Scodes[] = {
      0x3F, // 0 (abcdef)
      0x06, // 1 (bc)
      0x5B, // 2 (abdeg)
      0x4F, // 3 (abcdg)
      0x66, // 4 (bcfg)
      0x6D, // 5 (acdfg)
      0x7D, // 6 (acdefg)
      0x07, // 7 (abc)
      0x7F, // 8 (abcdefg)
      0x6F, // 9 (abcdfg)
      0x77, // A (abcefg)
      0x7C, // b (cdefg)
      0x39, // C (adef)
      0x5E, // d (bcdeg)
      0x79, // E (adefg)
      0x71  // F (aefg)
  };
  
  TRISEbits.TRISE4 = 0;      // configurar led e1 como output
  TRISB = TRISB & 0x80FF;    // 1000 0000 1111 1111;   configurar os segmentos como outputs(0)
  TRISD = TRISD & 0xFF9F;    // 1111 1111 1001 1111;    configurar os portos como SAIDAS. OUTPUTS(0)
  TRISBbits.TRISB1 = 1;      // configurar o porto RB1 (switch ds3) como input(1)

  TRISBbits.TRISB4 = 1; // RB4 digital output disconnected
  AD1PCFGbits.PCFG4 = 0; // RB4 configured as analog input
  AD1CON1bits.SSRC = 7; // Conversion trigger selection bits: in this
  // mode an internal counter ends sampling and
  // starts conversion
  AD1CON1bits.CLRASAM = 1; // Stop conversions when the 1st A/D converter
  // interrupt is generated. At the same time,
  // hardware clears the ASAM bit
  AD1CON3bits.SAMC = 16; // Sample time is 16 TAD (TAD = 100 ns)
  AD1CON2bits.SMPI = 4-1; // Interrupt is generated after N=4 samples
  // (replace N by the desired number of
  // consecutive samples)
  AD1CHSbits.CH0SA = 4; // replace x by the desired input
  // analog channel (0 to 15)
  AD1CON1bits.ON = 1; // Enable A/D converter
  // This must the last command of the A/D
  // configuration sequence

  unsigned int freq = 20000000/12;
  
  LATEbits.LATE4 = 0;   // configurar o valor inicial do led e1
  
  while(1){
    AD1CON1bits.ASAM = 1;

    while( IFS1bits.AD1IF == 0 );
    IFS1bits.AD1IF = 0;

    delay(freq);
    
    int media = (ADC1BUF0 + ADC1BUF1 + ADC1BUF2 + ADC1BUF3)/4;
    
    int valor_display = media*9/1023;
    
    if(PORTBbits.RB1 == 1){
      LATDbits.LATD6 = 1;
      LATDbits.LATD5 = 0;
    }
    else if(PORTBbits.RB1 == 0){
      LATDbits.LATD5 = 1;
      LATDbits.LATD6 = 0;
    }
    
    LATB = (LATB & 0x80FF) | disp7Scodes[valor_display + 3] << 8;
    
    LATEbits.LATE4 = !LATEbits.LATE4;
    
    printInt(media, 2 | 10 << 16);
    putChar('\r');

  }
}


