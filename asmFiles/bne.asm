org   0x0000
ori $1, $zero, 666
ori $2, $zero, 6969
nop
nop
nop
nop
nop
bne $1, $2, haltlabel
ori $1, $zero, 1234
haltlabel: halt

