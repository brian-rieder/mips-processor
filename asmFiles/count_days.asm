# File name:   count_days.asm
# Updated:     31 August 2016
# Author:      Brian Rieder 
# Description: Roughly calculate number of days since the year 2000.
#              - Days = CurrentDay + (30 * (CurrentMonth - 1)) + 365 * (CurrentYear - 2000)

org 0x0000 # initialize execution to 0
ori $29, $0, 0xFFFC # stack pointer

ori $4, $0, 0x0001 # CurrentDay
ori $5, $0, 0x0009 # CurrentMonth
ori $6, $0, 0x07E0 # CurrentYear

# 30 * (CurrentMonth - 1) -> $10
ori $7, $0, 0x0001 # 1
subu $5, $5, $7 # CurrentMonth - 1
push $5
ori $7, $0, 0x001E # 30
push $7
jal MULTIPLY
pop $10

# 365 * (CurrentYear - 2000) -> $11
ori $7, $0, 0x07D0 # 2000
subu $6, $6, $7 # CurrentYear - 2000
push $6
ori $7, $0, 0x016D # 365
push $7
jal MULTIPLY
pop $11

# Summation of values -> $1 = $4 + $10 + $11
addu $1, $4, $10
addu $1, $1, $11
j FINISH

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
  jr $31

FINISH:
halt
