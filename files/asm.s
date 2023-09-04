main:
	xor $29, $29 # sp = 0
	xor $1, $1   # flag set to 0
	xor $4, $4   # n = 6
	addi $4, 6
	bl fib
	addi $1, 1   # flag set to 1 on completion
fib:
	addi $29, 12      # (sp -> sp + 12 : make space for stack)
    sw $31, -12($29)  # store ra on stack
	sw $4, -8($29)    # store n onto stack
	compi $10, 2 # t2 = -2
	add $10, $4  # t2 = n-2
	bltz $10, endfib # if n-2 < 0: jump to endfib
	addi $4, -1  # n-1
	bl fib
	sw $2, -4($29) # store fib(n-1) in memory

	lw $4, -8($29) # load n from memory into $4
	addi $4, -2
	bl fib
	lw $8, -4($29) # load fib(n-1) into $8
	add $2, $8     # $2  = fib(n-1) + fib(n-2)
	b end
endfib:
	xor $2, $2 # v0 = 0
	add $2, $4 # v0 = n (if n == 0 || n == 1)
end:
	lw $31 -12($29)
	addi $29, -12   # move stack pointer back to original place
	br $31