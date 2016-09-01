# File name:   mult_procedure.asm
# Updated:     31 August 2016
# Author:      Brian Rieder 
# Description: Multiply procedure

org 0x0000 # initialize execution to 0
ori $29, $0, 0xFFFC # stack pointer

# testing
ori $11, $0, 0x0001
ori $12, $0, 0x0002
ori $13, $0, 0x0003
ori $14, $0, 0x0004
ori $15, $0, 0x0005
ori $16, $0, 0x0006
push $11
push $12
push $13
push $14
push $15
push $16

# beq $29, $1, FINISH # nothing on stack, do nothing

MULTIPLY:
  pop $3 # multiplier
  pop $2 # multiplicand
  ori $1, $0, 0x0000 # result
  beq $3, $0, MULLOOPFINISH # skip any looping if 0
  MULLOOP:
    addu $1, $1, $2 # result = result + multiplicand
    addiu $3, $3, 0xFFFF # subtract 1
    bne $3, $0, MULLOOP
  MULLOOPFINISH:
    push $1
    ori $1, $0, 0xFFF8 # stack pointer duplicate + 4 for comparison
    bne $29, $1, MULTIPLY

FINISH:
pop $1
halt
