	
	.data
str:	.space 12
	.align 2 #expoente de base 2, ou seja, 2² = 4
a: 	.space 48
	.text
	.globl main

#i >> $t0
#tmp1 >> $t1
#tmp2 >> $t2
#ps >> $t3
#pi >> $t4
#psf >> $t5
#pif >> $t6

main:
	li $t0, 0 #i=0
	
for1:	
	bge $t0, 12, endfor1 #while (i < 12)
	
	la $t3, str #ps = &str[0]
	addu $t3,$t3,$t0 #ps = ps + i
	lb $t2, 0($t3) #tmp2 = str[i]
	
	la $t4, a #pi = a
	sll $t9, $t0, 2 # ttt= i * 4
	addu $t4, $t4, $t9 #pi = 6a[i]
	
	addi $t0, $t0, 1 #i++
	j for1

endfor1:
	la $t3, str #ps = str
	addiu $t5, $t3, 12 #psf = str + 12

for2:	bgeu $t3, $t5, endfor2 # while (ps < psf)
	lb $t2, 0($t3) # tmp2 = *ps

	addiu $t3, $t3, 1 #ps++
	j for2

endfor2:
	la $t4, a #pi = a
	addiu $t6,$t4, 48 #pif = a + 12
for3:
	bgeu $t4, $t6, endfor3 #while (pi < pif)
	lw $t1, 0($t1) #tmp1 = *pi
	
	addiu $t4,$t4, 4 #pi ++
	j for3
	
endfor3:
	
	
	
	
	
	
	
	
