#include <detpic32.h>

volatile int numero;

void delay(unsigned int ms){
  resetCoreTimer();
  while(readCoreTimer() < ms);
}

unsigned int to_bcd(unsigned int number){
  return ((number / 10) << 4) | (number % 10);
}

void sendtodisplay(unsigned char value) {

    TRISD = (TRISD & 0x0000) | 0xFF9F;
    TRISB = (TRISB & 0x0000) | 0x80FF; 

    static const char disp7Scodes[] = {
        0x3F, 0x06, 0x5B, 0x4F,
        0x66, 0x6D, 0x7D, 0x07,
        0x7F, 0x6F, 0x77, 0x7C,
        0x39, 0x5E, 0x79, 0x71
    };
    static char displayFlag = 1; // 1 for HI-D, 0 for LO-D

    if (displayFlag) {
        LATD = ( LATD & 0x0000 ) | 0x0040; // Activate HI-D, disable LO-D
        LATB = ( LATB & 0x0000 ) | disp7Scodes[value >> 4] << 8; // Write the values of RB8-RB14
        displayFlag = 0;
    } else {
        LATD = ( LATD & 0x0000 ) | 0x0020; // Disable HI-D, activate LO-D
        LATB = ( LATB & 0x0000 ) | disp7Scodes[value & 0x0F] << 8; // Write the values of RB8-RB14
        displayFlag = 1;
    }
}

void conf_T3(){
  // prescaler = ceiling(20000000/(65535+1)*140) = ceiling(2.17) = 3
  // prescaler = 4
  // PR3 = (20000000/4/140)-1 = 35713.28 = 35713

  T3CONbits.TCKPS = 2; // 1:4 prescaler (i.e. fout_presc = 625 KHz)
  PR3 = 35713; // Fout = 20MHz / (32 * (62499 + 1)) = 10 Hz
  TMR3 = 0; // Clear timer T2 count register
  T3CONbits.TON = 1;
  
  IPC3bits.T3IP = 2; // Interrupt priority (must be in range [1..6])
  IEC0bits.T3IE = 1; // Enable timer T2 interrupts
}
  
void _int_(12) isr_t3(void){
  sendtodisplay(to_bcd(numero));
  IFS0bits.T3IF = 0; // Reset timer T2 interrupt flag
}

void conf_AD(){
  TRISBbits.TRISB4 = 1;
  AD1PCFGbits.PCFG4 = 0;
  AD1CON1bits.SSRC = 7;
  AD1CON1bits.CLRASAM = 1;
  AD1CON3bits.SAMC = 16;
  AD1CON2bits.SMPI = 2-1;
  AD1CHSbits.CH0SA = 4; 
  AD1CON1bits.ON = 1;
  
}  

int main(void){
  conf_AD();
  conf_T3();
  EnableInterrupts();

  int media = 0;
  while(1){
    AD1CON1bits.ASAM = 1;
    while(IFS1bits.AD1IF == 0);
  
    media = (ADC1BUF0 + ADC1BUF1)/2;

    numero =(((media*65) + 511)/1023) + 10; 
    
    IFS1bits.AD1IF = 0;
    delay(200); //1/5 = 0.2 s = 200 ms
  }
}

