		ORG 0x0000
		LUI $29, 0xFFFC
		SRL $29, $29, 0x00000010
		ORI $6, $6, 0xA #decimal 10
		ORI $7, $7, 0xA #decimal 10
		PUSH $6
		PUSH $7
		LUI $2, 0x1 #one for subtraction
		LUI $3, 0x0 #Place to store the answer
		POP $4 #get the first operand 
		POP $5 #get the second operand
loop:
		ADDU $3, $3, $5 #do the stuff
		ADDI $4, $4, -1 #subtract 1
		BNE $4, $0, loop
	 	PUSH $3
		HALT

