	.data
	.text
	.globl main

main:	ori $t0,$0, 0x5C1B #o valor de a será armazenado em &$t0 pois o ori efetua OR entre $0(que é sempre 0) e a [X OR 0 = X]
	ori $t1,$0, 0xA3E4
	
	and $t2,$t0,$t1
	or $t3,$t0,$t1
	nor $t4,$t0,$t1
	xor $t5,$t0,$t1
	
	jr $ra