main:
	xor $29, $29 # sp = 0
	xor $1, $1   # flag set to 0
	xor $4, $4   # n = 6
    xor $5, $5
	addi $4, 6
    addi $5, 1
    shrl $4, 1
    shll $4, 1
    shrlv $4, $5
    shllv $4, $5
    shra $4, 1
    shrav $4, $5

    compi $3, -2

	addi $1, 1   # flag set to 1 on completion
