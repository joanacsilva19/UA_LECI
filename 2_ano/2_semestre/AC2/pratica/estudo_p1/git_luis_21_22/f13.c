#include <detpic32.h>

void delay(unsigned int ms){
  resetCoreTimer();
  while(readCoreTimer() < ms);
}

int main(void){

  // configurar os portos RE4 a RE1 como outputs (0 - AND)
  TRISE = TRISE & 0xFFE1;
  
  unsigned int freq = 20000000/7;
  int counter;

  while(1){

    counter = 0b1001;
    LATE = (LATE & 0xFFE1) | counter << 1;
    printInt(counter, 2 | 4 << 16);
    putChar('\r');
    delay(freq);
    
    counter = 0b0110;
    LATE = (LATE & 0xFFE1) | counter << 1;
    printInt(counter, 2 | 4 << 16);
    putChar('\r');
    delay(freq);

  }
}

