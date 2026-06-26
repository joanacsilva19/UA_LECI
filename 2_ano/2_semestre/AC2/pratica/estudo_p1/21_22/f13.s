.equ ADDR_BASE_HI, 0xBF88
.equ TRISE, 0x6100
.equ PORTE, 0x6110
.equ LATE, 0x6120

.equ putChar, 3
.equ printInt, 6
.equ readCoreTimer, 11
.equ resetCoreTimer, 12

.data
.text
.globl main

# mapa registos:
# ADDR_BASE_HI --> $t1
# TRISE --> $t2
# LATE --> $t3
# ms --> $t4

main:
#--------------------------------------------- prologo
addiu $sp, $sp, -8
sw $ra, 0($sp)
sw $s0, 4($sp)

#--------------------------------------------- main
lui $t1, ADDR_BASE_HI
lw $t2, TRISE($t1)
andi $t2, $t2, 0xFFE1		# 1111 1111 1110 0001
sw $t2, TRISE($t1)			# TRISE = TRISE & 0xFFE1

li $s0, 0b1001				# padrao = 0b1001

while:						# while(1){

sll $t0, $s0, 1
lw $t2, LATE($t1)
andi $t2, $t2, 0xFFE1
or $t2, $t2, $t0
sw $t2, LATE($t1)			# LATE = LATE & 0xFFE1 | padrao << 1

li $v0, printInt
move $a0, $s0
li $a1, 4
sll $a1, 16
ori $a1, $a1, 2
syscall						# printInt(padrao, 2 | (4 << 16))

li $v0, putChar
li $a0, '\r'
syscall						# putChar('\r')

not $s0, $s0
andi $s0, $s0, 0x000F		# padrao = !padrao & 0x000F

li $a0, 2857143				# freq = 20000000/7 = 2857142,85 (aprox 2857143)
jal delay

j while						# }

#--------------------------------------------- epilogo
lw $s0, 4($sp)
lw $ra, 0($sp)
addiu $sp, $sp, 8

jr $ra

#--------------------------------------------- delay

delay:
move $t4, $a0

li $v0, resetCoreTimer
syscall

while2:
li $v0, readCoreTimer
syscall

move $t5, $v0
blt $t5, $t4, while2

jr $ra

