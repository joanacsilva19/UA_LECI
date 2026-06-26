#include <detpic32.h>

void putc(char byte2send) {
	while(U2STAbits.UTXBF == 1);
	U2TXREG = byte2send;
} 

void putstr( char *s) {
	while( *s!= '\0') {
		putc(*s++);
	}
}
volatile int count = 15;

int main(void) {
	TRISE &= 0xFFE1;
// configurar Uart2
	int baudrate = 9600;
	U2BRG = ((( 20000000 + (8*baudrate))/(16*baudrate)) -1);
	U2MODEbits.BRGH = 0;
	U2MODEbits.PDSEL = 2;
	U2MODEbits.STSEL = 1;
	U2STAbits.URXEN = 1;
	U2STAbits.UTXEN = 1;
	U2MODEbits.ON = 1;

//configurar interrupçoes da Uart2

	IEC1bits.U2RXIE = 1;		//rececao por interrupt
	IEC1bits.U2TXIE = 0;		//transmissão por polling
	IPC8bits.U2IP = 1;		//prioridade
	U2STAbits.URXISEL = 0;
	EnableInterrupts();
	while(1)
	{	
		LATE = (LATE & 0xFFE1) | count << 1;
	}
return 0;	
}


void _int_(32) isr_UART2(void) {
	char c;
	if (IFS1bits.U2RXIF == 1){
		c = U2RXREG;
		putc(c);
		putc('\n');
	
		if (c == 'U'){
			count++;
			if (count > 15) {
				count = 0;
			}
		} else if (c == 'R'){
			count = 0;
			putstr("RESET\n");
		}
	}
	IFS1bits.U2RXIF = 0; // Reset timer U2 interrupt flag
}




