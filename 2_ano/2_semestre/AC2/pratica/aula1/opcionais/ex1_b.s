# mapa de registos:
# down = $s0
# up = $s1
# state = $s2
# cnt = $s3
#  stop = $s4
#  reset = $s5
# c = $t0
# i = $t1
# ts = $t2

.data
    .equ putChar, 3
    .equ printInt, 6
    .equ inkey, 1 
    
    .text
    .globl main

main:
#____________________________________________________prologo
    addiu $sp, $sp, -4
    sw $ra, 0($sp)
    
    li $s0, 0               # down = 0
    li $s1, 1               # up = 1
    move $s2, $s1           # state = UP
    li $s3, 0               # cnt = 0
    
    li $s4, 2               # stop = 2
    li $s5, 3               # reset = 3

do:
    li $v0, putChar
    li $a0, '\r'
    syscall                 # putChar('\r')

    move $a0, $s3
    li $a1, 0x0003000A      # 3 algarismos, base 10
    li $v0, printInt
    syscall 
    
    li $v0, putChar
    li $a0, '\t'
    syscall 

    move $a0, $s3
    li $a1, 0x00080002      # 8 algarismos, base 2
    li $v0, printInt
    syscall

    li $a0, 5
    jal wait 

    li $v0, inkey
    syscall
    move $t0, $v0           # c = inkey()
    
if1:
	bne $t0, '+', down1
	move $s2, $s1			#state = up
	j if2

down1:	
	bne $t0, '-', stop1
	move $s2, $s0			#state = down
	j if2
	
stop1:
    bne $t0, 'S', reset1
    move $s2, $s4           #state = stop
	j if2
	
reset1:
    bne $t0, 'R', if2
    move $s2, $s5           #state = reset
	
if2:
	bne $s2, $s1, down2
	addi $s3, $s3, 1			#cnt = cnt + 1
	andi $s3, $s3, 0xFF
	j while
	
down2:
    bne $s2, $s0, stop2
	addi $s3, $s3, -1			#cnt = cnt - 1
	andi $s3, $s3, 0xFF
	
stop2:
    bne $s2, $s4, reset2
    j epilogo
    
reset2:
    bne $s2, $s5, while
    li $s3, 0
    move $s2, $s1           #state = up 
    
while:
    bne $t0, 'q', do        # while(c != 'q')

#___________________________________________________epilogo
epilogo:
    
    li $v0, 0
    lw $ra, 0($sp)
    addiu $sp, $sp, 4
    jr $ra

#___________________________________________________wait function
wait:
    li $t2, 515000
    multu $t2, $a0
    mflo $t2

    li $t1, 0               # i = 0
for:
    bgeu $t1, $t2, endfor   #i < 515000
    
    addi $t1, $t1, 1        # i++
    j for

endfor:
    jr $ra
