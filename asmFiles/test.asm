  org 0x0000
  ori   $1,$zero,0xD269
  ori   $2,$zero,0x37F1

  ori   $21,$zero,0x80
  ori   $22,$zero,0xF0

# Now running all R type instructions
  or    $3,$1,$2
# Store them to verify the results
  sw    $3,0($21)
  
  halt
