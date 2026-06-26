.equ ADDR_BASE_HI, 0xBF88
.equ TRISE, 0x6100
.equ PORTE, 0x6110
.equ LATE, 0x6120

.equ resetCoreTimer, 12
.equ readCoreTimer, 11
.equ putChar, 3
.equ printInt, 6

.data
.text
.globl main

# mapa registos:
# $t1 --> ADDR_BASE_HI
# $s0 --> counter
# $t4 --> freq

main:
#----------------------- prologo
addiu $sp, $sp, -8
sw $ra, 0($sp)
sw $s0, 4($sp)

#----------------------- main

lui $t1, ADDR_BASE_HI
lw $t2, TRISE($t1)
andi $t2, $t2, 0xFF83		# 1111 1111 1000 0011 --> outputs(0)
sw $t2, TRISE($t1)

li $s0, 0					# counter = 0;

li $t4, 4347826				# 20000000/4.6 = 4347826.087 (aproximadamente 4347826)

li $t6, 24

while:						# while(1)

move $a0, $t4				
jal delay					# delay(freq);

lui $t1, ADDR_BASE_HI
lw $t2, LATE($t1)
andi $t2, $t2, 0xFF83
sll $t5, $s0, 2
or $t2, $t2, $t5				
sw $t2, LATE($t1)			# LATE = LATE & 0xFF83 | counter << 2;

move $a0, $s0
li $a1, 5
sll $a1, $a1, 16
ori $a1, $a1, 2

li $v0, printInt	
syscall						# printInt( counter, 2 | 5 << 16);

li $a0, '\r'
li $v0, putChar
syscall						# putChar('\r');

if:
	bne $s0, $0, else		# if counter == 0
	li $s0, 24				# counter = 24;
	j while
else:
	addi $s0, $s0, -1		# else{counter = counter - 1;}
j while

#----------------------- epilogo
lw $s0, 4($sp)
lw $ra, 0($sp)
addiu $sp, $sp, 8

jr $ra


#----------------------- delay
delay:

li $v0, resetCoreTimer
syscall					# resetCoreTimer();

while2:

li $v0, readCoreTimer	# readCoreTimer();
syscall


blt $v0, $a0, while2		# while(readCoreTimer() < ms);

jr $ra


