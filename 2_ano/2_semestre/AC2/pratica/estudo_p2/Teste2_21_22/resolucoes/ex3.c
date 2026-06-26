#include <detpic32.h>
#define fpblick 20000000

void putc(char byte2send) {
	while(U2STAbits.UTXBF == 1);
	U2TXREG = byte2send;
} 

void putstr( char *s) {
	while( *s != '\0') {
		putc(*s++);
	}
}

int main(void){

	TRISE &= 0xFF1E;

	int baudrate = 9600; 
	int counter = 15;
	
	// Configure UART2:
// 1 - Configure BaudRate Generator
	U2BRG =(fpblick + 8*baudrate)/(16*baudrate)-1;
// 2 – Configure number of data bits, parity and number of stop bits
// (see U2MODE register)
	U2MODEbits.BRGH = 0;		//fator de divisão de relógio 16
	U2MODEbits.PDSEL = 2;		//paridade ímpar
	U2MODEbits.STSEL = 1;		//2 stop bit
// 3 – Enable the trasmitter and receiver modules (see register U2STA)
	U2STAbits.UTXEN = 1;		//Transmitter enable
	U2STAbits.URXEN = 1;		//Reciever enable
// 4 – Enable UART2 (see register U2MODE)
	U2MODEbits.ON = 1;		//Enable UART1

	// Configurar interrupções UART2
	IPC2bits.T2IP = 2; // Interrupt priority (must be in range [1..6])
	IEC0bits.T2IE = 1; // Enable timer T2 interrupts
	IFS0bits.T2IF = 0; // Reset timer T2 interrupt flag
	
	IPC8bits.U2IP = 1;		//prioridade
	U2STAbits.URXISEL = 0;
	EnableInterrupts();

	while(1) {
		LATE = (LATE & 0xFFE1) | counter << 1;
	}
	return 0;
}

void _int_(32) isr_UART2(void) {
	char c, counter = 0;
	if (IFS1bits.U2RXIF == 1){
		c = U2RXREG;
		putc(c);
		putc('\n');
		if (c == 'U') {
			counter++;
			putstr("U\n");		
			if (counter > 15) {
				counter = 0;
			}
		} else if (c == 'R'){
			counter = 0;
			putstr("RESET\n");
		}
	}
	IFS1bits.U2RXIF = 0; // Reset timer U2 interrupt flag
}
