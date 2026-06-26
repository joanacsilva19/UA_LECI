#include <detpic32.h>

int main(void){
  char ch;

  TRISD = TRISD & 0xFF9F; //RD5 e RD& como outputs
  TRISB = TRISB & 0x80FF; // RB14 a RB8 como outputs

  // ativa o display menos significativo 
  //LATDbits.LATD5=1;
  //LATDbits.LATD6=0;

  // ativa o display mais significativo
  LATDbits.LATD5=0;
  LATDbits.LATD6=1;

  while(1){

    ch = getChar();

    if(ch == 'a') LATB = (LATB & 0x80FF) | (1 << 8);
    if(ch == 'b') LATB = (LATB & 0x80FF) | (1 << 9);
    if(ch == 'c') LATB = (LATB & 0x80FF) | (1 << 10);
    if(ch == 'd') LATB = (LATB & 0x80FF) | (1 << 11);
    if(ch == 'e') LATB = (LATB & 0x80FF) | (1 << 12);
    if(ch == 'f') LATB = (LATB & 0x80FF) | (1 << 13);
    if(ch == 'g') LATB = (LATB & 0x80FF) | (1 << 14);

  }

}

//FF 9 F - TRISD 5 E 6
// 8 0 FF - TRISB 8 A 14
// OUTPUT - 0; INPUT - 1
