	.data
	.eqv size, 20
str:	.space 21 #espaço reservado na memoria para armazenar a string + terminador
	.eqv read_string, 8
	.eqv print_int10, 1	
	
	.text
	.globl main
	
#num > $t0, p > $t1, *p > $t2
	
main:
	li $t0, 0 #num = 0
	
	li $a1, size #definir tamanho maximo da string + terminador
	la $a0, str #dar um endereço onde armazenar a string
	li $v0, read_string
	syscall #read_string(str, size)
	
	la $t1, str #endereço inicial da string (p)
	
	lb $t2, 0($t1) #*p -> valor do endereço para que p aponta \\ dereference p
	
while:
	beq $t2, '\0', endw	
	
if:
	blt $t2, '0', endif
	bgt $t2, '9', endif
	
	addi $t0,$t0, 1 #num ++ 
	
endif:
	addi $t1, $t1, 1 #p++
	lb $t2, 0($t1) #dereference p incrementado
	j while
	
endw:
	or $a0, $0, $t0
	li $v0, print_int10
	syscall #print_int10(num)
	
	jr $ra