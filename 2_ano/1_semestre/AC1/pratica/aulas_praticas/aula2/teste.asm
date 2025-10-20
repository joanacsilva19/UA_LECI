	.data
string:	.asciiz "Olá mundoooo"

	.text
	.globl main
main:	ori $v0, $0, 4 #codigo do print string
	la $a0, string #la -> load address: carregar o endereço do inicio da string
	syscall
	jr $ra