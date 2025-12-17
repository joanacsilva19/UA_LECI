	.data
	
	.eqv size, 3
	.eqv print_string, 4
	.eqv print_char, 11
	.eqv print_int, 1
	
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "ponteiros"
str4: .asciiz "\nString #"
str5: .asciiz ": "
	
arr:	.word str1, str2, str3
	
	.text
	.globl main
	
#mapa de registos:
# size > $t0
# i > $t1
# j > $t2
# arr[0][0] > $t3
# arr[i] > $t4
# arr[i][j] > $t5
	
main:
	li $t0, size #$t0 = size
	li $t1, 0 #i = 0
	
	la $t3, arr #&arr[0]

for:
	bge $t1, $t0, endfor #for(i < size)
	
	la $a0, str4
	li $v0, print_string
	syscall #print_string(str4)
	
	move $a0, $t1
	li $v0, print_int
	syscall #print_int(i)
	
	la $a0, str5
	li $v0, print_string
	syscall #print_string(str5)
	
	li $t2, 0 #j = 0
	lw $t4, 0($t3)
	
while:

	lb $t5, 0($t4) #arr[i][j]
	
	beq $t5, '\0', endw #while(arr[i][j] != '\0')
	
	move $a0, $t5
	li $v0, print_char
	syscall #print_char(arr[i][j])

	li $a0, '-'
	li $v0, print_char
	syscall #print_char('-')
	
	addiu $t4, $t4, 1 #j++
	
	j while

endw:

	addiu $t1, $t1, 1 #i++
	addiu $t3, $t3, 4
	j for

endfor:

	jr $ra
