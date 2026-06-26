#include <detpic32.h>

void delay(unsigned int ms){
resetCoreTimer();
while(readCoreTimer() < ms);
}

int main(void){

  TRISEbits.TRISE1 = 0; // configurar o led como output(0)
  TRISDbits.TRISD5 = 0; // ativar lsd (como output)
  TRISB = TRISB & 0x80FF;  // 1000 0000 1111 1111
  
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
  };
  
  TRISBbits.TRISB4 = 1; // RBx digital output disconnected
  AD1PCFGbits.PCFG4 = 0; // RBx configured as analog input
  AD1CON1bits.SSRC = 7; // Conversion trigger selection bits: in this
  // mode an internal counter ends sampling and
  // starts conversion
  AD1CON1bits.CLRASAM = 1; // Stop conversions when the 1st A/D converter
  // interrupt is generated. At the same time,
  // hardware clears the ASAM bit
  AD1CON3bits.SAMC = 16; // Sample time is 16 TAD (TAD = 100 ns)
  AD1CON2bits.SMPI = 2-1; // Interrupt is generated after N=2 samples
  // (replace N by the desired number of
  // consecutive samples)
  AD1CHSbits.CH0SA = 4; // replace x by the desired input
  // analog channel (0 to 15)
  AD1CON1bits.ON = 1; // Enable A/D converter
  // This must the last command of the A/D
  // configuration sequence
  
  unsigned int freq = 20000000/6;
  
  LATEbits.LATE1 = 0;
  
  while(1){
  
    AD1CON1bits.ASAM = 1;
    
    while( IFS1bits.AD1IF == 0 );
    IFS1bits.AD1IF = 0;
    
    delay(freq);
    
    int media = (ADC1BUF0 + ADC1BUF1)/2;
    
    int valor_display = (media*9)/1023;
    
    LATDbits.LATD5 = 1;
    LATB = (LATB & 0x80FF) | disp7Scodes[valor_display] << 8;
    
    LATEbits.LATE1 = !LATEbits.LATE1;

    printInt(media, 16 | 3 << 16);
    putChar('\r');

  }

}







