	.data
	.eqv gray,7
	.text
	.globl main
main:	ori $t0,$0,gray
	ori $t1,$0,gray #num = gray
	srl $t3,$t1,4
	srl $t4,$t1,2
	srl $t5,$t1,1
	xor $t1,$t1,$t3 #num = num ^ (num >> 4);
	xor $t1,$t1,$t4 #num = num ^ (num >> 2);
	xor $t1,$t1,$t5 #num = num ^ (num >> 1);
	or $t2,$0,$t1 #bin = num E usa se OR pq o ultimo registo não é uma constante imediata.
	jr $ra