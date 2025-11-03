	.data
	.eqv size, 4
arr:	.word 7692, 23, 5, 234
	.eqv print_int10, 1

	.text
	.globl main

# mapa de registos
# p > $t0, pultimo > $t1, *p > $t2, *pultimo > $t3, soma > $t4, size > $t5

main:
	or $t4, $0, $t4 #soma = 0
	la $t0, arr #p = array[0]
	li $t5, size
	li $t6, 1 # \\carregar o valor 1 para subtrair a 'size'
	sub $t7, $t5, $t6 #size - 1
	mult $t5, $t7 #multiplicar o size - 1 por 4 (1 inteiro ocupa 4 bits)	\\ armazena resultado em LO
	mflo $t7 #mover do LO o resultado da multiplicação de size-1 por 4
	add $t3, $t0, $t7  #pultimo = array + size-1
	
while:
	bgt $t0, $t3, endw #while (p <= pultimo)
	lw $t8, 0($t0)  # \\t8 = memory[t0 + 0]
	add $t4, $t4, $t8 #soma = soma + *p
	addi $t0, $t0, 4 #p++
	j while
endw:
	move $a0, $t4
	li $v0, print_int10
	syscall #print_int10(soma)

	jr $ra
