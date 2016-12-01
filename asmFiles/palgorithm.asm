#------------------------------------------
# Originally Test and Set example by Eric Villasenor
# Modified to be LL and SC example by Yue Du
#------------------------------------------

#----------------------------------------------------------
# First Processor
#----------------------------------------------------------
  org   0x0000              # first processor p0
  #ori   $sp, $zero, 0x3ffc  # stack
  ori   $s0, $zero, 0x550       # index of head 
  ori   $s6, $zero, 0x550   # index of next head 
  ori   $s2, $zero, 256     # number of random nums generated 
  ori   $s4, $zero, 2       #seed 
  ori   $s1, $zero, 0x554       # index of tail

  jal   mainp0              # go to program
  halt

# pass in an address to lock function in argument register 0
# returns when lock is available
lock:
aquire:
  ll    $t0, 0($a0)         # load lock location
  bne   $t0, $0, aquire     # wait on lock to be open
  addiu $t0, $t0, 1
  sc    $t0, 0($a0)
  beq   $t0, $0, lock       # if sc failed retry
  jr    $ra


# pass in an address to unlock function in argument register 0
# returns when lock is free
unlock:
  sw    $0, 0($a0)
  jr    $ra

# main function does something ugly but demonstrates beautifully
mainp0:
  push  $ra                 # save return address

  # critical code segment
  #ori   $sp, $zero, 0x3ffc  # stack
  #ori   $s0, $zero, 0       # index of head 
  #ori   $s6, $zero, 0x550       # index of next head 
  #ori   $s1, $zero, 0       # index of tail
  #ori   $s5, $zero, 0x554       # index of next tail
  #ori   $s2, $zero, 256     # number of random nums generated 
  #ori   $s4, $zero, 0       #seed 
generateNumbers: 
  #update head and check if max is reached 
  ori   $a0, $s4, 0      #change seed to last generated random number
  jal   crc32
  ori   $s4, $v0, 0 # loading random number to $s4
gen: 
  ori   $a0, $zero, l1      # move lock to arguement register
  jal lock

  lw $s0, 0x550($zero)
  lw $s1, 0x554($zero)

  addi  $s6, $s0, 4 # next = head + 1
  ori   $t3, $zero, 0x528 # if condition 
  bne   $s6,  $t3, resetChecked # = 0 
  ori   $s6, $zero, 0x500 

resetChecked:
  bne   $s6,  $s1, tailChecked # if (next_head == tail) => unlock 
  ori   $a0, $zero, l1      # move lock to arguement register
  jal   unlock              # release the lock
  j     gen
tailChecked:
# generate number 
  #ori   $t3, $zero, 0x550 # store head address to temp reg
  #lw    $s0, 0x550($zero) # load head of buffer address to s0 
 
  # store value to bufer and move head 
  sw    $s4, 0($s0)         #store value at where head points
  #ori   $t3, $zero, 0x550   # store head address to temp reg
  sw    $s6, 0x550($zero)   # update head to next head

  ori   $a0, $zero, l1      # move lock to arguement register
  jal   unlock              # release the lock
# decrement counter 
  #ori   $t4, $zero, 1 
  #sub  $s2, $s2, $t4
  addi  $s2, $s2, -1 
  bne   $s2, $zero, generateNumbers
  # critical code segment
  pop   $ra                 # get return address
  jr    $ra                 # return to caller
l1:
  cfw 0x0

#----------------------------------------------------------
# Second Processor
#----------------------------------------------------------
  org   0x200               # second processor p1
  ori   $sp, $zero, 0x7ffc  # stack
  jal   mainp1              # go to program
  halt

# main function does something ugly but demonstrates beautifully
mainp1:
  push  $ra                 # save return address
  ori   $a0, $zero, l1      # move lock to arguement register
  ori   $s0, $zero, 0x500       # index of head 
  ori   $s1, $zero, 0x500       # index of tail
  ori   $s5, $zero, 0x500       # index of next tail
  ori   $s2, $zero, 256           # number of random nums generated 
  ori   $s7, $zero, 0xFFFF # minumum number 
  ori   $s3, $zero, 0x0000 # maximum number
  ori   $s4, $zero, 2       #seed 
  ori   $s6, $zero, 0       # average 

checkNumbers: 
gen2:
  ori   $a0, $zero, l1      # move lock to arguement register
  jal lock
  lw   $t4,  0x550($zero)   # load buffer address from head address
  lw   $t5,  0x554($zero)   # load buffer address from tail address 
  bne   $t4,  $t5, tailChecked2 # if (head == tail) => unlock 
  ori   $a0, $zero, l1      # move lock to arguement register
  jal   unlock              # release the lock
  j     gen2
tailChecked2:
  # store data from tail 
  #ori   $t4, $zero, 0x554 # load tail adress to temp reg 
  lw    $s1, 0x554($zero)  # load tail pointer at buffer from tail address 

  lw    $s4, 0($s1)       # load data at tail pointer to s4
  andi  $s4, $s4, 0x0000FFFF 
  sw    $zero, 0($s1)     # resets data to zero 

  addi  $s5, $s1, 4 #next tail
  ori   $t3, $zero, 0x528
  bne   $s5,  $t3, resetChecked2
  ori   $s5, $zero, 0x500 
  resetChecked2:
  #ori   $s1,  $s5, 0      # updating tail 
  sw    $s5, 0x554($zero) 
#unlock
  ori   $a0, $zero, l1      # move lock to arguement register
  jal unlock

  # maximum
  ori   $a0, $s4, 0 
  ori   $a1, $s3, 0 
  jal   max
  ori   $s3, $v0, 0 

  #minimum
  ori   $a0, $s4, 0 
  ori   $a1, $s7, 0 
  jal   min
  ori   $s7, $v0, 0 

  add  $s6, $s6, $s4 
  #decrement
  addi  $s2, $s2, -1 
  bne   $s2, $zero, checkNumbers

# divide sum by number of nums to find average 
  ori $a0, $s6, 0 
  ori $a1, $zero, 256
  jal divide 
  ori $s6, $v0, 0 


  
  pop   $ra                 # get return address
  jr    $ra                 # return to caller

reset2: 
  ori    $s5, $zero, 0x500 

res:
  cfw 0x0                   # end result should be 3

#------------------------------------------------------
# $v0 = crc32($a0)
crc32:
  lui $t1, 0x04C1 #jump and link crc32
  ori $t1, $t1, 0x1DB7
  or $t2, $0, $0
  ori $t3, $0, 32

looparoo1:
  slt $t4, $t2, $t3
  beq $t4, $zero, l2

  srl $t4, $a0, 31
  sll $a0, $a0, 1
  beq $t4, $0, l3
  xor $a0, $a0, $t1
l3:
  addiu $t2, $t2, 1
  j looparoo1
l2:
  or $v0, $a0, $0
  jr $ra
#------------------------------------------------------

#-divide(N=$a0,D=$a1) returns (Q=$v0,R=$v1)--------
divide:               # setup frame
  push  $ra           # saved return address
  push  $a0           # saved register
  push  $a1           # saved register
  or    $v0, $0, $0   # Quotient v0=0
  or    $v1, $0, $a0  # Remainder t2=N=a0
  beq   $0, $a1, divrtn # test zero D
  slt   $t0, $a1, $0  # test neg D
  bne   $t0, $0, divdneg
  slt   $t0, $a0, $0  # test neg N
  bne   $t0, $0, divnneg
divloop:
  slt   $t0, $v1, $a1 # while R >= D
  bne   $t0, $0, divrtn
  addiu $v0, $v0, 1   # Q = Q + 1
  subu  $v1, $v1, $a1 # R = R - D
  j     divloop
divnneg:
  subu  $a0, $0, $a0  # negate N
  jal   divide        # call divide
  subu  $v0, $0, $v0  # negate Q
  beq   $v1, $0, divrtn
  addiu $v0, $v0, -1  # return -Q-1
  j     divrtn
divdneg:
  subu  $a0, $0, $a1  # negate D
  jal   divide        # call divide
  subu  $v0, $0, $v0  # negate Q
divrtn:
  pop $a1
  pop $a0
  pop $ra
  jr  $ra
#-divide--------------------------------------------


#-max (a0=a,a1=b) returns v0=max(a,b)--------------
max:
  push  $ra
  push  $a0
  push  $a1
  or    $v0, $0, $a0
  slt   $t0, $a0, $a1
  beq   $t0, $0, maxrtn
  or    $v0, $0, $a1
maxrtn:
  pop   $a1
  pop   $a0
  pop   $ra
  jr    $ra
#--------------------------------------------------

#-min (a0=a,a1=b) returns v0=min(a,b)--------------
min:
  push  $ra
  push  $a0
  push  $a1
  or    $v0, $0, $a0
  slt   $t0, $a1, $a0
  beq   $t0, $0, minrtn
  or    $v0, $0, $a1
minrtn:
  pop   $a1
  pop   $a0
  pop   $ra
  jr    $ra
#--------------------------------------------------




org 0x500
cfw 0x0 # 0x500
cfw 0x0 # 0x504
cfw 0x0 # 0x508
cfw 0x0 # 0x50C
cfw 0x0 # 0x510
cfw 0x0 # 0x514
cfw 0x0 # 0x518
cfw 0x0 # 0x51C 
cfw 0x0 # 0x520
cfw 0x0 # 0x524

org 0x550 
cfw 0x500 #head #write to memory of head  750
cfw 0x500 #tail 554

#read from buffer then write 0 to it to "remove"
