#mapa de registos:
# c = $t0
# cnt = $t1
# i = $t2
# ts = $t3

	
	.data
	
	.equ inkey, 1
	.equ printInt, 6
	.equ putChar, 3
	
	.text
	.globl main

main:
#____________________________________________________epilogo

	addiu $sp, $sp, -8
	sw $ra, 0($sp) #guardar $ra em $sp
	
#____________________________________________________main
	
    or $t1, $t1, $0         # cnt  = 0

while:
    
    li $v0, inkey
    syscall
    
    move $t0, $v0           # c = inkey()
    
if:
    bne $t0, 'R', endif     # if(c == 'R')
    move $t1, $0            # cnt = 0
        
endif:
    
    li $v0, putChar
    li $a0, '\r'
    syscall                 #putChar('\r')
    
    move $a0,$t1
    li $a1,0x0003000A       # (10 | 3 << 16)
    li $v0,printInt
    syscall                 # printInt(cnt, 10 | 3 << 16)
    
    addi $t1,$t1, 1         # cnt + 1
    andi $t1, $t1, 0xFF     # cnt = (cnt + 1) & 0xFF
    
    li $a0, 4
    jal wait                # wait(4)

	j while
	
	or $v0, $v0, $0        #return 0
	
	
#___________________________________________________prologo

	lw $ra, 0($sp)
	addiu $sp, $sp, 8
	
	jr $ra

#___________________________________________________wait function
wait:
    or $t2, $t2, $0        # i = 0
    move $t3, $a0           #ts = 4
for:
    mul $t3, $t3, 515000
    bge $t2, $t3, endfor
    
    addi $t2, $t2, 1        #i++
    j wait
endfor:
    jr $ra
