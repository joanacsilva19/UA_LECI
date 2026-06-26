#----------------------------------------------------------------------
#mapa de registos:
# c = $t0
# cnt = $t1
# '\n' = $t2
# aux = $t3

  .data
  
  .equ getChar, 2
  .equ putChar, 3
  
  .text
  .globl main
main:

#______________________________________________prologo
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
#______________________________________________main
	
	li $t1, 0               #int cnt = 0
	li $t2, 10              # codigo ascii para \n

do:       
        
	li $v0, getChar
	syscall                 # getChar()
	
	move $t0, $v0           # c = getChar()
	
	move $a0, $t0 		# arg = c
	
	#--------------------------------- experimentar com c+1
	
	#addi $t0, $t0, 1 #c = c+1
	
	#---------------------------------
	
	move $a0, $t0 		# arg = c
	
	li $v0, putChar
	syscall 			# putChar(c)
	
	addi $t1, $t1, 1		# cnt++
	
while:

	bne $t0, $t2, do
	nop
	
	move $a0, $t1
	li $a1, 10
	li $v0, 6
	syscall			# printInt(cnt, 10)
	
	li $v0, 0               # return 0

#_____________________________________________epilogo
	lw $ra, 0($sp)
	addiu $sp, $sp, 8
	
	jr $ra

