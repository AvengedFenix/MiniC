		.data

		.text
		.globl main

main:
	li $t0, 6
	sw $t0, -4($fp)
	li $t0, 4
	sw $t0, -8($fp)
	li $t0, 2
	lw $t1, -8($fp)
	add $t2, $t0, $t1
	sw $t2, -12($fp)
	li $t0, 0
	sw $t0, -16($fp)

_ETIQ1:
	lw $t0, -16($fp)
	lw $t1, -12($fp)
	blt $t0, $t1, _ETIQ2
	b _ETIQ3

_ETIQ4:
	lw $t2, -16($fp)
	li $t3, 1
	add $t4, $t0, $t3
	sw $t4, -16($fp)
	b _ETIQ1

_ETIQ2:
	b _ETIQ4

_ETIQ3:
	li $v0, 10
	syscall
