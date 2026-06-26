#include <detpic32.h>

int main(void){
  int step = 1;
  TRISE = TRISE & 0xFF87; //configure pins RE3, RE4, RE5, and RE6 as Outputs
  int counter = 0;
  int valor = (FREQ/2)/2700000; //ou PBCLK / 2700000
  
  //printf("valor = %d", valor); // dá 7 (o esperado)
  
  while(1){
    LATE = (LATE & 0xFF87) | counter << 3; //registar o valor do counter nos outputs
    resetCoreTimer();
    while(readCoreTimer() < valor);
    counter = (counter - step + 10) % 10;
  }
  return 0;
}


//valor = (FREQ/2)/2700000; //ou PBCLK / 2700000
// PBCLK = 20 000 000 Hz

