#mapa de registos
# num: $t0
# i: $t1
# str: $t2
#str + i: $t3
#str[i]: $t4	
	
	.data
	.eqv size, 20
	.eqv read_string, 8
	.eqv print_int10, 1
str:	.space 21 # reservar 21 espaços na memoria para o array str sem inicializar \\ contar com o terminador, por isso é que é 21
	.text
	.globl main
	
main:	
	la $a0, str #carregar endereço inicial do array
	
	li $a1,size #length da string
	li $v0, read_string
	syscall #ler string

	li $t0, 0 # num = 0
	li $t1, 0 # i = 0
	
while:
	addu $t3, $a0, $t1 #str + i \\ soma de endereços (unsigned)
	lb $t4, 0($t3) # str[i] \\ extrair o valor no determinado endereço
	
	beq $t4, '\0', endw #while str[i] != '\0'
	
if:		
	blt $t4, '0', endif
	bgt $t4, '9', endif # if (str >= '0') && (str <= '9')
	
	addi $t0,$t0,1 #num ++
	
	
endif:
	addi $t1, $t1, 1 #i++
	j while
endw:
	or $a0,$0,$t0
	li $v0, print_int10
	syscall #print_int10(num)
				
	jr $ra
