	.data
	
arr:	.space 40 #int arr[10]; 10 * 4 bytes
	
	.eqv size, 10
	.eqv true, 1
	.eqv false, 0
	.align 2
	
	.eqv read_int, 5
	.eqv print_int10, 1
	
	.text
	.globl main

#mapa de registos:
#houve_troca > $t0
#i > $t1
#aux > $t2
#*arr> $t3
#size * 4 > $t5
#arr + size > $t6
#size > $t7
#arr[i] > $t8
#arr[i+1] > $t9


main:
#ponteiros
	li $t1, 0 #i = 0
	la $t3, arr #arr[0]
	li $t5, 40 #$t5 = size * 4
	addu $t6, $t3, $t5 #*arr + size*4
for:
	bge $t3, $t6, endfor #for(arr < *arr + size)
	
	li $v0, read_int
	syscall #read_int10
	
	sw $v0, 0($t3) #adicionar o numero lido ao array
	
	addiu $t3,$t3, 4 #*arr++
	
	j for
endfor:
#indexação
	li $t7, size
	addi $t7,$t7, -1 #size-1
	la $t3, arr 
do:
	la $t3, arr
	li $t1, 0 #i = 0 
	li $t0, false #houve_troca = FALSE
for2:
	bge $t1, $t7, endfor2 #for (i < SIZE-1)
	
	lw $t8, 0($t3) #arr[i]
	
	lw $t9, 4($t3) #arr[i+1]
	
if:
	ble $t8,$t9, endif #if (arr [i] > arr [i+1])
	
	move $t2, $t8 #aux = arr[i];
	sw $t9, 0($t3) #arr[i] = arr[i+1];
	sw $t2, 4($t3) #arr[i+1] = aux;
	
	li $t0, true #houveTroca = TRUE;

endif:
	addiu $t3,$t3, 4 
	addi $t1,$t1, 1 #i++
	j for2
endfor2:
	
while:
	beq $t0, false, endw #while(houve_troca == TRUE)
	j do
endw:

# inserir aqui o código de impressão do conteúdo do array
	la $t3, arr 
	li $t1, 0    # i = 0
for3:
	bge $t1, size, endfor3  # for (i < size)
	
	sll $t4, $t1, 2         # $t4 = i * 4 
	addu $t5, $t3, $t4      
	lw $a0, 0($t5)          
	
	li $v0, print_int10
	syscall                 # print(arr[i])
	
	li $v0, 11
	li $a0, ' '
	syscall
	
	addiu $t1, $t1, 1       # i++
	
	j for3
	
endfor3:
	
	jr $ra