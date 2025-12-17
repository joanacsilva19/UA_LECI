	.data
str1:	.asciiz "\nConteudo do array:\n"
str2:	.asciiz "; "
lista:	.word 8, -4, 3, 5, 124, -15, 87, 9, 27, 15
	.eqv SIZE, 40 #10 * 4 bytes
	
	.text
	.globl main
	
# p > $t0
#*p > $t1
#lista+Size > $t2
#Size > $t3

main:	
	li $v0, 4
	la $a0, str1
	syscall #print_string(str1)
	
	# px = address of x
	# *px = the value of x (stored at address p)
	
	la $t0, lista # p = &lista //endereço do primeiro elemento do array (ponteiro)
	addi $t2, $t0, SIZE #lista + SIZE

for:	
	bge $t0, $t2, endfor
	
	lw $t1, 0($t0) #*p = valor armazenado no endereço para que p aponta
	
	li $v0, 1
	move $a0, $t1
	syscall #print_int10(*p)
	
	li $v0, 4
	la $a0, str2
	syscall #print_string(str2)
	
	addi $t0, $t0, 4 #p++
	
	j for
	
endfor:
	jr $ra #jump (to) register 31	
	
	
	
	
	

	


