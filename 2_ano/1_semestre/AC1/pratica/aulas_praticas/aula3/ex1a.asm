	.data
str1:	.asciiz "Introduza um numero: "
str2:	.asciiz "Valor ignorado\n"
str3:	.asciiz "A soma dos positivos e': "
	.text
	.globl main
#	soma > $t0; value > $t2; i > $t1
main:	
	li $t0,0 #soma	li -> instrução virtual (load immediate)
	li $t1,0 #i
L1:	
	bge $t1, 5, endw # while i < 5;
	li $v0, 4 #codigo do print string
	la $a0, str1 #load address da string 
	# iniciar parametros antes do syscall ($a0)
	syscall		# print_string(str1); Introduza um numero
	
	li $v0, 5 #codigo read_int();
	syscall
	move $t2, $v0 # value = read_int()	mover o valor para o registo $t2, o valor de $v0 ($t2 = $v0)
	
if:
	ble $t2, $0, else # if (value > 0)
	add $t0,$t0,$t2 # soma = soma + value;	
	j endif # then	salta para endif, para tornar if e else mutualmente exclusivo
else:
	li $v0, 4 #codigo do print string
	la $a0, str2 #load address da string 
	# iniciar parametros antes do syscall ($a0)
	syscall		# print_string(str1); Valor ignorado

endif:
	addi $t1, $t1, 1 # i++;
	j L1 # fecho com jumping condicional para o inicio	(se faltar o codigo não volta para cima)
endw:
	li $v0, 4 #codigo do print string
	la $a0, str3 #load address da string 
	# iniciar parametros antes do syscall ($a0)
	syscall		# print_string(str1); A soma dos inteiros e'
	
	li $v0, 1 #codigo print_int()
	move $a0, $t0 #mover valor de $t0 para $a0 ($a0 = $t0)
	syscall # print(soma)