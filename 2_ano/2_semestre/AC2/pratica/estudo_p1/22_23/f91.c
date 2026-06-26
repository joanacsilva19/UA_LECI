#include <detpic32.h>
void delay(unsigned int ms){
  resetCoreTimer();
  while(readCoreTimer() < ms);
}


int main(void){

  unsigned int freq = 20000000/7.3;
  int counter = 0b110000;
  
  TRISB = TRISB | 0x0005; // 0000 0000 0000 0101
  TRISE = TRISE & 0xFF03;
  
  // 

  
  while(1){
    
    if(PORTBbits.RB2 == 0 && PORTBbits.RB0 == 0){
      freq = 20000000/7.3;
    }
    else if(PORTBbits.RB2 == 1 && PORTBbits.RB0 == 1){
      freq = 20000000/4.6;
    }
      LATE = (LATE & 0xFF03) | (counter << 2);
      delay(freq);
    if (counter == 0b000011){
      counter = 0b110000;
    }
    else{
      counter = counter >> 1;
    }
    
  }

}


