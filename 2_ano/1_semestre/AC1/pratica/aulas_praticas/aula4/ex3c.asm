	.data
arr:	.word 7692, 23, 5, 234
	
	.text
	.globl main

#mapa de registos:
#arr > $t0
#arr[i] > $t2
#i > $t3
#soma > $t4

main:
	la $t0, arr #carregar o endereço de arr[0]
	li $t4, 0 #soma = 0
	li $t3, 0 #i = 0
	li $t5, 4 #aux = 4
	
while:
	bge $t3, $t5, endw # while (i < 4)
	lw $t2, 0($t0) #arr[i]
	add $t4, $t4, $t2 #soma = soma + arr[i]
	
	addiu $t0,$t0, 4 #arr + i
	addi $t3, $t3, 1 #i++
	
	j while
endw:
	
	move $a0,$t4
	li $v0, 1
	syscall #print_int10(soma)
	
	jr $ra