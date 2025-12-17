	.data
	.eqv size, 3
	.eqv print_string, 4
	.eqv print_char, 11
	
	.align 2 #2² = 4 
	#make sure the addresses are multiplos de 4 
	
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "ponteiros"
	
arr:	.word str1, str2, str3

	.text
	.globl main
	
#mapa de registos
# p > $t0, &array[0] > $t1, pultimo >$t2
	
main:
	la $t1, arr # endereço inicial do array
	lw $t2, 8($t1) #ultimo elemento do array
			
for:
	beq $t0, $t2, endfor
	bgt $t0, $t2, endfor
	
	lw $t0, 0($t1) #$t0 = p
	
	move $a0, $t0
	li $v0, 4
	syscall #print_string()
	
	li $a0, '\n'
	li $v0, print_char
	syscall #print_char('\n')

	addi $t1, $t1, 4 #p = p + 1
	
	j for

endfor:
	jr $ra
	 
