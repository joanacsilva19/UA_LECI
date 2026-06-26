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
# $t3 --> 0b10000

main:
#----------------------- prologo
addiu $sp, $sp, -8
sw $ra, 0($sp)
sw $s0, 4($sp)

#----------------------- main

lui $t1, ADDR_BASE_HI
lw $t2, TRISE($t1)
andi $t2, $t2, 0xFFC1		# 1111 1111 1100 0001 outputs(0)
sw $t2, TRISE($t1)			# TRISE = TRISE & 0xFFC1;

li $s0, 0b00001				# counter = 0b00001;
li $t3, 0b10000

while:

li $a0, 8695652				# freq = 20000000/2.3 = 8695652.17 (aproximadamente 8695652)
jal delay					# delay(freq);

lui $t1, ADDR_BASE_HI
lw $t2, LATE($t1)
andi $t2, $t2, 0xFFC1
sll $t4, $s0, 1
or $t2, $t4, $t2
sw $t2, LATE($t1)			# LATE = (LATE & 0xFFC1) | counter << 1;

move $a0, $s0
li $a1, 5
sll $a1, $a1, 16
ori $a1, $a1, 2
li $v0, printInt
syscall						# printInt(counter, 2 | 5 << 16);

li $a0, '\r'
li $v0, putChar
syscall						# putChar('\r');

if:							# if (counter == 0b10000)
	bne $s0, $t3, else		
	li $s0, 0b00001			# counter = 0b00001;
	j while
else:						# else{ counter << 1 }
	sll $s0, $s0, 1	
	
j while

#----------------------- epilogo
lw $s0, 4($sp)
lw $ra, 0($sp)
addiu $sp, $sp, 8

jr $ra

#----------------------- delay
delay:

li $v0, resetCoreTimer
syscall						# resetCoreTimer();

while2:
li $v0, readCoreTimer
syscall

blt $v0, $a0, while2			# while(readCoreTimer() < ms);

jr $ra


