	.data
str:	.asciiz "\n Introduza um numero: "
	.align 2 #expoente de base 2 que iguala o numero que quero
lista:	.space 20 # 5 * 4
	.text
	.globl main
	
# i > $t0; &(lista[0]) > $t1; (lista[i]) > $t2
	
main:
	li $t0, 0 #i = 0
	
while:
	bge $t0, 5, endw #while (i < 5)
	li $v0, 4
	la $a0, str
	syscall #print_string(str)
	
	li $v0, 5
	syscall # 	// $v0 = read_int() ($v0 é o registo que armazena o retorno de funções)
	
	la $t1, lista
	sll $t2, $t0, 2
	addu $t2, $t1, $t2 # 	// $t2 = &lista[i] (endereço lista[i])
				#// addu - soma unsigned pq estamos a somar enderços
	sw $v0, 0($t2) # lista[i] = read_int()
		
	addi $t0, $t0, 1 #i++
	j while
endw:
	jr $ra