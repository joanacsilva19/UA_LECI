	.data
	.eqv bin,6 #a variavel bin tem o valor desejado (em decimal)
	.text
	.globl main
main:	ori $t0,$0, bin
	srl $t2,$t0,1
	xor $t1,$t0,$t2 #t1 é o codigo gray
	
	jr $ra