# File name:   mult.asm
# Updated:     29 August 2016
# Author:      Brian Rieder 
# Description: Multiply algorithm

org 0x0000 # initialize execution to 0

ori $29, $0, 0xFFFC # stack pointer

# testing
# ori $12, $0, 0x0010
# ori $13, $0, 0x0F00
# push $13
# push $12

pop $3 # multiplier
pop $2 # multiplicand
ori $1, $0, 0x0000 # result

beq $3, $0, finish # skip any looping if 0

loop:
addu $1, $1, $2 # result = result + multiplicand
addiu $3, $3, 0xFFFF # subtract 1
bne $3, $0, loop

finish:
push $1
halt
