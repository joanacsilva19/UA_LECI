	.data
str1:	.asciiz "\n"
	.eqv print_string,4 #printar string
	.text
	.globl main
main:	ori $v0,$0,5 #introduzir número
	syscall
	
	or $t0,$0,$v0
	ori $t2,$0,8
	add $t1,$t0,$t0 #x+x = x*x
	sub $t1,$t1,$t2
	
	or $a0,$0,$t1
	ori $v0,$0, 1 #codigo para imprimir numero inteiro signed
	syscall
	
	la $a0,str1
	ori $v0,$0, print_string
	syscall
	
	#alinea c
	ori $v0,$0,34 #codigo para imprimir numero inteiro UNSIGNED em base 16
	syscall
	
	la $a0,str1
	ori $v0,$0, print_string
	syscall
	
	#alinea d
	ori $v0,$0,36 #codigo para imprimir numero inteiro UNSIGNED em base 10
	syscall
	
	jr $ra
