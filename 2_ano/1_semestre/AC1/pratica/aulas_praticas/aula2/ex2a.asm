	.data
	.eqv const,4 #quando encontra a string "const" substitui pelo valor desejado
	.text
	.globl main
main:	li $t0,0x862A5C1B
	sll $t2,$t0,const #const é a variável que traduz o número de bits que serão deslocados
	srl $t3,$t0,const
	sra $t4,$t0,const
	
	jr $ra
	