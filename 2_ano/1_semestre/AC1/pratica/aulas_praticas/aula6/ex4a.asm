	.data
	
	.eqv print_string, 4
	.eqv print_int, 1
	
str1:	.asciiz "Nr de parametros: "
str2:	.asciiz "\nP"
str3:	.asciiz ": "
		
	.text
	.globl main
	
#mapa de registtos:
# i > $t0
# argv[i] > $t1
# argc > $t2

	
main:

	li $t0, 0 #i = 0
	move $t1, $a1
	move $t2, $a0

	la $a0, str1
	li $v0, print_string
	syscall #print_string(str1)
	
	move $a0, $t2
	li $v0, print_int
	syscall #print_int(argc)
	
for:
	bge $t0, $t2, endfor
	
	la $a0, str2
	li $v0, print_string
	syscall #print_string(str2)
	
	move $a0, $t0
	li $v0, print_int
	syscall #print_int(i)
	
	la $a0, str3
	li $v0, print_string
	syscall #print_string(str3)
	
	lw $t3, 0($t1)
	
	move $a0, $t3 #preparar a1
	li $v0, print_string #// os args são tratados como strings, por isso usar o código para imprimir strings
	syscall #print_int(argv[i])
	
	addi $t0,$t0, 1 # i++
	addi $t1,$t1, 4
	
	j for
	
endfor:

	jr $ra
