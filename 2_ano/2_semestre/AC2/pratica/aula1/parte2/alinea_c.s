#mapa de registos
# value = $t0


	.data
	
str1:	.asciiz "\nIntroduza um inteiro (sinal e módulo): "
str2:	.asciiz "\nValor em base 10 (signed): "
str3:	.asciiz "\nValor em base 2: "	
str4:	.asciiz "\nValor em base 2, formatado: "	
str5:	.asciiz "\nValor em base 16: "
str6:	.asciiz "\nValor em base 10 (unsigned): "
str7:	.asciiz "\nValor em base 10 (unsigned), formatado: "

	.equ readInt10, 5
	.equ printInt10, 7
	.equ printInt, 6
	.equ printStr, 8

	.text
	.globl main
	
main:

while:
	la $a0, str1
	li $v0, printStr
    syscall             #printStr(str1)
    
    li $v0, readInt10
    syscall
    
    move $t0, $v0       #value = readInt10()
    

    la $a0, str2
    li $v0, printStr
    syscall             #printStr(str2)
    
    move $a0, $t0
    li $v0, printInt10
    syscall             #printInt10(value)
    
    la $a0, str3
    li $v0, printStr
    syscall             #printStr(str3)
    
    move $a0, $t0
    li $a1, 2
    li $v0, printInt
    syscall             #printInt(value, 2)
    
    la $a0, str4
    li $v0, printStr
    syscall             #printStr(str4)
    
    move $a0, $t0
    li $a1, 0x00200002
    li $v0, printInt
    syscall             #printInt(value, 2 | 32 << 16)
    
    la $a0, str5
    li $v0, printStr
    syscall             #printStr(str5)
    
    move $a0, $t0
    li $a1, 16
    li $v0, printInt
    syscall             #printInt(value, 16)
    
    la $a0, str6
    li $v0, printStr
    syscall             #printStr(str6)
    
    move $a0, $t0
    li $a1, 10
    li $v0, printInt
    syscall             #printInt(value, 10)
    
    la $a0, str7
    li $v0, printStr
    syscall             #printStr(str7)
    
    move $a0, $t0
    li $a1, 0x0005000A
    li $v0, printInt
    syscall             #printInt(value, 10 | 5 << 16)
     
    j while
    
    move $v0, $0

	jr $ra
