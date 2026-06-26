#include <detpic32.h>

int main(void){
  int step = 1;
  TRISE = TRISE & 0xFF87; //configure pins RE3, RE4, RE5, and RE6 as Outputs
  int counter = 0;
  
  while(1){
    LATE = (LATE & 0xFF87) | counter << 3; //registar o valor do counter nos outputs
    resetCoreTimer();
    while(readCoreTimer() < 4347826);
    counter = (counter + step) % 10;
  }
  return 0;
}

// freq = 40000000 //CPU corre a 40MHz
// pbclk = freq/2 //periféricos correm a 20MHz

// para obter frequencia de 4.6 MHz de atualização:
// valor = freq/4.6*10⁶ (Hz)


