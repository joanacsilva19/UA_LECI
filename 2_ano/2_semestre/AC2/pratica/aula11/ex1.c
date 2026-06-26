#include <detpic32.h>

void putc(char c) {
    while(U2STAbits.UTXBF == 1);
    U2TXREG = c;
}

void puts(char *s) {
    while(*s != '\0') {
        putc(*s);
        s++;
    }
}

void _int_(32) isr_uart2(void) {
    if (IFS1bits.U2RXIF == 1) {
        char c = U2RXREG;

        if (c == '?') {
            puts("AC2-Guião 11");
        } else {
            putc(c);
        }
        IFS1bits.U2RXIF = 0;
    }
}

int main(void) {
    // Configuração da UART2: 115200, N, 8, 1
    U2BRG = 10;
    U2MODEbits.BRGH = 0;
    U2MODEbits.PDSEL = 0;
    U2MODEbits.STSEL = 0;

    // Habilita Transmissor e Receptor
    U2STAbits.UTXEN = 0; 
    U2STAbits.URXEN = 1;
    U2MODEbits.ON = 1;

    // Configuração de interrupções
    IEC1bits.U2RXIE = 1;
    IEC1bits.U2TXIE = 0;
    IPC8bits.U2IP = 1;
    IFS1bits.U2RXIF = 0;

    // URXISEL: Interrupção quando o buffer não está vazio
    U2STAbits.URXISEL = 0;

    EnableInterrupts();

    while(1) {
        IdleMode();
    }
    return 0;
}
