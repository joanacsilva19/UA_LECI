#include <detpic32.h>








void conf_uart(void){
U2MODEbits.BRGH = 0;
U2BRG = 520;
// U2BRG = (20000000 + 8*2400)/(16*2400)-1 = 520.33 ⁼ 520
U2MODEbits.PDSEL = 1;
U2MODEbits.STSEL = 1;

U2STAbits.UT2EN = 1;
U2STAbits.URXEN = 1;

U2MODEbits.ON = 1;

U2STAbits.UTXISEL = 0;
U2STAbits.URXISEL = 0;

IEC1bits.U2RXIE = 
// ns, vou na fé.

}









int main(void){

conf_uart();




}


