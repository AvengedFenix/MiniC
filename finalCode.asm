		.data

		.text
		.globl main

main:
li $t0, 6
sw $t0, -4($fp)
li $t1, 4
sw $t1, -8($fp)
li $t3, 2
add $t2, $t3, $t1
sw $t2, -12($fp)
li $t5, 1
add $t4, $t0, $t5
sw $t4, -4($fp)
li $t7, 2
add $t6, $t2, $t7
sw $t6, -8($fp)
	li $v0, 10
	syscall
