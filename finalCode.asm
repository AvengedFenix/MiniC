		.data
_msg1: 	.asciiz "El resultado es: %d"

		.text
		.globl main

main:
li $t0, 4
li $t2, 2
add $t1, $t2, $t0
