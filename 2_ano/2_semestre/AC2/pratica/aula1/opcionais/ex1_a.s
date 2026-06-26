# mapa de registos:
# down = $s0
# up = $s1
# state = $s2
# cnt = $s3
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
	bne $t0, '+', elseif1
	move $s2, $s1			#state = up
	j if2

elseif1:	
	bne $t0, '-', if2
	move $s2, $s0			#state = down
	
if2:
	bne $s2, $s1, else2
	addi $s3, $s3, 1			#cnt = cnt + 1
	andi $s3, $s3, 0xFF
	j while
	
else2:
	addi $s3, $s3, -1			#cnt = cnt - 1
	andi $s3, $s3, 0xFF

while:
    bne $t0, 'q', do        # while(c != 'q')

#___________________________________________________epilogo
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
