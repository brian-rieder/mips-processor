org 0x0000

  xor $29, $29, $29
  ori $29, $0, 0xFFFC

  lui $1, 0x7FFF
  or  $2, $0, $1

  // Test hazards
  and $2, $2, $2
  and $2, $2, $2
  and $2, $2, $2
  and $2, $2, $2

  ori $3, $0, storing

  // Test write to 0 register
  addi $0, $2, 0x4444
  push $1
  pop $0

  push $1
  pop $1
  push $1
  pop $1
  push $1
  pop $1
  push $1
  pop $1

  beq $0, $0, end

  org 0x200
  halt

  org 0x300

start:

  j label1

label1:
  ori $5, $0, 4
  ori $6, $0, 10

top:
  addu $7, $3, $5
  lw $8, 0($7)
  sw $8, 4($7)

  addi $6, $6, 0xFFFF

  bne $6, $0, top

  jal next

  lw $8, 0($7)
  add $1, $1, $1
  xor $1, $1, $1
  xor $2, $2, $2
  xor $3, $3, $3
  halt

next:
  lw $8, 0($7)
  lw $8, 0($7)
  lw $8, 0($7)
  lw $8, 0($7)
  lw $8, 0($7)
  lw $8, 0($7)
  sw $8, 0($7)
  sw $8, 0($7)
  sw $8, 0($7)
  sw $8, 0($7)
  sw $8, 0($7)
  sw $8, 0($7)

  jr $31
  lw $8, 0($7)
  sw $8, 0($7)
  halt

end:
  beq $0, $0, end2
  push $1
  pop $1

end3:
  jal start
  halt
  lw $0, 0($1)
  xor $1, $1, $1

end2:
  beq $0, $0, end3
  jr $1
  jal start
  j end2

  org 0x5000
  storing:
  cfw 12
  cfw 9
  cfw 14
  cfw 8
  cfw 4
  cfw 69
  cfw 23
  cfw 16
  cfw 23
  cfw 23
