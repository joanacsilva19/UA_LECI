# include <detpic32.h>

int delay (unsigned int ms){
  resetCoreTimer();
  while(readCoreTimer() < ms);
}

int main (void){
  // definir os portos RE5 a RE0 como outputs (0 - AND)
  TRISE = TRISE & 0xFFC0;
  // definir o switch DS3 como input (1 - OR)
  TRISB = TRISB | 0x0008;
  unsigned int freq;
  int counter;
  
  while(1){
  
    if(PORTBbits.RB2 == 1){ // ON
      freq = 20000000/7;
    }
    else if(PORTBbits.RB2 == 0){ //OFF
      freq = 20000000/3;
    }
    counter = 0b000001;
    
    // atribuir aos portos RE5 a RE0 os vadelay(freq);lores do counter
    LATE = (LATE & 0xFFC0) | counter;
    delay(freq);
    
    while(counter <= 0b100000){
    
      if(PORTBbits.RB2 == 1){ // ON
      freq = 20000000/7;
      }
      else if(PORTBbits.RB2 == 0){ //OFF
        freq = 20000000/3;
      }
      
      LATE = (LATE & 0xFFC0) | counter << 1;
      counter = counter << 1;
      delay(freq);
    }
  }
}

