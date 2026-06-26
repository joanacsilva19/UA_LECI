#include <detpic32.h>

void delay(unsigned int ms){
  resetCoreTimer();
  while(readCoreTimer() < ms);
}

int main(void){

  unsigned int freq;
  int counter = 0;

  TRISE = TRISE & 0xFFC3; // 1111 1111 1100 0011
  TRISBbits.TRISB2 = 1; //configurar porto do sw DS3 como input (1)

  while(1){

    if(PORTBbits.RB2 == 0){   // se ds3 estiver off
      freq = 20000000/2.3;
    }
    else{     // se ds3 estiver on
      freq = 20000000/5.5;
    }
    
    delay(freq);
    
    // LATE = (LATE & 0xFFC3) | counter << 2;

    printInt(counter, 10 | 2 << 16);
    putChar('\r');
    
    if(counter == 0){
      counter = 11;
    }
    else{
      counter = counter - 1;
    }

  }
  return 0;
}


