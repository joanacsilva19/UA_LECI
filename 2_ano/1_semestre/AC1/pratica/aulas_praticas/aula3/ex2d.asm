	.data
str1:	.asciiz "Introduza um numero: "
str2:	.asciiz "\nO valor em binario e': "
	.eqv print_string, 4
	.eqv print_int, 1
	.eqv read_int, 5
	.eqv bits, 32 #numero de bits
	.eqv print_char, 11
	
	.text
	.globl main
	# $t0 --> value; $t1 --> bit; $t2 --> i; $t5 --> flag
main:	
	li $v0, print_string
	la $a0, str1 #carregar $a0 com o valor da string
	syscall #print(introduza um numero)
	
	li $v0, read_int
	syscall #read_int()
	move $t0, $v0 # value = read_int()
	
	li $v0, print_string
	la $a0, str2
	syscall #print(o valor em binario é: )		
	
	li $t2,0 # i = 0;
	li $t5,0 # flag = 0
	
	ori $t6,$0, 0
	ori $t7,$0, 1
L1:
	beq $t2, bits, endw #while i = 32
	bgt $t2, bits, endw #while i > 32
	
	srl $t1, $t0, 31 #bit = value >> 31
	
if1:
    	beq $t5, $0, check_flag   # if flag == 0, maybe set it
    	j if2               # if flag == 1, go print

check_flag:
    	beq $t1, $0, endif1       # bit = 0 → still leading zero → skip printing
    	li $t5, 1                 # first 1 found → set flag

	#WTF IS GOING ON FUCKING HELL
	#check conditions cuz that aint right or the ending part of loops
	
	ori $t5, $t5, 1  #flag = 1

if2:
	remu $t4, $t2, 4 #i % 4
	bne $t4, 0, endif2 #if (i % 4 == 0)
	li $v0, print_char
	li $a0, ' '
	syscall #print_char(' ')

endif2:	
	addi $t3, $t1, 0x30 #0x30 + bit
	li $v0, print_char
	move $a0, $t3
	syscall #print_char(0x30 + bit)
	
endif1:
	addi $t2, $t2, 1 # i++
	sll $t0, $t0, 1 # value = value << 1
	j L1
endw:	
	jr $ra
