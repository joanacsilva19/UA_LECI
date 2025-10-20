	.data
str1:	.asciiz "Introduza um numero: "
str2:	.asciiz "\nO valor em binario e': "
	.eqv print_string, 4
	.eqv print_int, 1
	.eqv bits, 32 #numero de bits
	.eqv print_char, 11
	
	.text
	.globl main
	# $t0 --> value; $t1 --> bit; $t2 --> i;
main:	
	li $v0, print_string
	la $a0, str1 #carregar $a0 com o valor da string
	syscall #print(introduza um numero)
	
	li $v0, 5 #codigo para ler inteiro
	syscall #read_int()
	move $t0, $v0 # value = read_int()
	
	li $v0, print_string
	la $a0, str2
	syscall #print(o valor em binario é: )		
	
	li $t2,0 # i = 0;
	li $t3, 0x80000000 #load do numero só com o bit mais significativo a 1
L1:
	beq $t2, bits, endw #while i = 32
	bgt $t2, bits, endw #while i > 32
	
	remu $t4, $t2, 4 #i % 4
	bne $t4, 0, if #if (i % 4 == 0)
	li $v0, print_char
	li $a0, ' '
	syscall #print_char(' ')
		
if:
	and $t1, $t0, $t3  #bit = value & 0x80000000
	beq $t1, 0, else #if bit != 0
	li $v0, print_int
	li $a0, 1
	syscall #print_char ('1')
	j endif
else:
	li $v0, print_int
	li $a0, 0
	syscall #print_char ('0')
endif:
	addi $t2, $t2, 1 # i++
	sll $t0, $t0, 1 # value = value << 1
	j L1
endw:	
	jr $ra

