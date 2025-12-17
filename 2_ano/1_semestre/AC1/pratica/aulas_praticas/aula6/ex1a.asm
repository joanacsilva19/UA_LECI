	.data
	.eqv size, 3
	.eqv print_string, 4
	.eqv print_char, 11
	
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "ponteiros"
	
arr:	.word str1, str2, str3

	.text
	.globl main
	
#mapa de registos
# i > $t0, size > $t2	, &array[0] > $t1
	
main:
	ori $t0, $t0, 0 #i = 0
	ori $t2, $0, size
	la $t1, arr # endereço inicial do array
	
for:
	beq $t0, $t2, endfor
	bgt $t0, $t2, endfor
	
	sll $t3, $t0, 2 #multiplicar por 4 o endereço do array = sll por 2
	addu $t4, $t1, $t3 #&arr[i]
	
	lw $a0, 0($t4) #$a0 = valor do endereço de memoria de $t4 + 0
	li $v0, print_string
	syscall #print_string(arr[i])
	
	li $a0, '\n'
	li $v0, print_char
	syscall #print_char('\n')

	addi $t0, $t0, 1 #i++
	
	j for

endfor:
	jr $ra
	 