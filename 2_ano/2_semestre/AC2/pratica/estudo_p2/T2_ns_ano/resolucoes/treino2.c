#include <detpic32.h>

unsigned char counter = 15;

void _int_(32) isr_adc(void);

void putc(char c);

void sendstring(char *string2send);

int main(void){
	//conf UART
	IEC1bits.U2TXIE = 0;//Transmit Interrupt Enable Control Bit
	IFS1bits.U2TXIF = 0;//Transmit Interrupt Flag Status Bit
	IEC1bits.U2RXIE = 0;//Receive Interrupt Enable Control Bit
	IFS1bits.U2RXIF = 0;//Receive Interrupt Flag Status Bit
	//IEC1bits.U2EIE = 1; //Error Interrupt Enable Control Bit
	IPC8bits.U2IP = 2;//Interrupt Priority Control Bits
	
	U2BRG = ((PBCLK + 8*9600)/16*9600)-1;
	U2MODEbits.BRGH = 0;
	U2MODEbits.PDSEL = 2;
	U2MODEbits.STSEL = 1;
	
	U2STAbits.URXEN = 1;
	U2STAbits.UTXEN = 1;
	U2STAbits.URXISEL = 0;
	U2STAbits.UTXISEL = 0;
	U2MODEbits.ON = 1;
	
	//conf switch
	TRISE &= 0xFFE1;
	LATE = (LATE & 0xFFE1) | 0x001E;  
	
	while(1);
	EnableInterrupts();
	return 0;
}

void _int_(32) isr_adc(void){
	if(IFS1bits.U2RXIF){
        	char c = U2RXREG;
		if(c == 'U'){
			counter = (counter+1) % 16;
			LATE = (((LATE >> 1) & 0xFFF0 )| counter )<< 1;
		}
		if(c == 'R'){
			counter = 0;
			LATE = (((LATE >> 1) & 0xFFF0 )| counter )<< 1;
			sendstring("RESET\n");
		}
		IFS1bits.AD1IF = 0; // Reset AD1IF flag
		IFS1bits.U2RXIF = 0; // Receive Interrupt Flag Status Bit
	}
}

void putc(char c){
	while(U2STAbits.UTXBF);
	U2TXREG = c;
}

void sendstring(char *string2send){
    int i = 0;
    while(string2send[i] != '\0'){
    putc(string2send[i]);
    i++;
    }
}	
