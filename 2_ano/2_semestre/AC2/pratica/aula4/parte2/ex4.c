#include <detpic32.h>

void delay(unsigned int ms)
{
  resetCoreTimer();
  while(readCoreTimer() < 20000 * ms);
}

int main(void){
  unsigned int i;
  unsigned char segment;
  
  TRISD = TRISD & 0xFF9F;// configure RD5-RD6 as outputs
  
  TRISB = TRISB & 0x80FF;// configure RB8-RB14 as outputs
  
  LATD = (LATD & 0xFF9F) | 0x40;// enable display low (RD5) and disable display high (RD6)
  while(1)
  {
    segment = 0x01;
    for(i=0; i < 7; i++)
    {
      LATB = (LATB & 0x80FF) | (segment << 8);// send "segment" value to display
      
      delay(500); // wait 0.5 second
      segment = segment << 1;
    }
    LATD = LATD ^ 0x0060;// toggle display selection 
  }
  return 0;
}

//K=20*10⁶*t
//t é o valor do atraso em segundos
// K = 20*10⁶*ms, 1ms = 0.001 s
//K = 20000000*0.001 = 20 000 (ms)


