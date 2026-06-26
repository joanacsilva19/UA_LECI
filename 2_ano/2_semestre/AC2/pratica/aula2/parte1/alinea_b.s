	.equ READ_CORE_TIMER,11
	.equ RESET_CORE_TIMER,12
	.equ PUT_CHAR,3
	.equ PRINT_INT,6
	.data
	.text
	.globl main
	
main: li $t0,0 				# counter=0
while: # while (1) {

#......................................complete
	la $a0, '\r'
	li $v0, PUT_CHAR
	syscall					#putChar('/r')
	
	move $a0, $t0
	
	li $t1, 4
	sll $t1, $t1, 16
	ori $t1, $t1, 10 		#10 | 4 << 16
	
	move $a1, $t1
	li $v0, PRINT_INT
	syscall 					#print_int(counter, 10 | 4 << 16)
	
#......................................
	li $v0,RESET_CORE_TIMER
	syscall 					# resetCoreTimer()
	
#......................................complete
while2:
	
	li $v0, READ_CORE_TIMER
	syscall 					#read_core_timer()
	
	move $t2, $v0
		
	blt $t2, 20000000, while2
	
	addi $t0,$t0, 1			#counter++
	
endw2:
#.......................................
	j while # }
	
	li $v0, 0				#return 0
	
	jr $ra #
	
#.......................................NOTA
#20 000 000 Hz ---> 15 s
#2 000 000 Hz ---> 0.15 s
#200 000 Hz ---> 0.01 s
