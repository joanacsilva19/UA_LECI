	.data
	.text
	.globl main
main:	ori $t0,$0,0xE543
	xori $t1,$t0,0xFFFF #xor é para registos, oxri é para constantes!!!!!
	jr $ra