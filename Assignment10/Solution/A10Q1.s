         	.data
array:	 	.space 48
msg1:    	.asciiz "Found element at index "
msg2:    	.asciiz "Element was not found"
         	.text
         	.globl main

main:	    li $v0,5
		    syscall
		    add $t0,$v0,$0
			add $s0,$v0,$0
			la $t1,array

scan:		li $v0,5
			syscall
			sw,$v0,0($t1)
			addi $t1,$t1,4
			addi $t0,$t0,-1
			bne $t0,$0,scan
			li $v0,5
			syscall

			add $s1,$v0,$0
			addi $sp,$sp,-4
			sw $ra,0($sp)
			la $a0,array
			add $a1,$0,$0
			addi $a2,$s0,-1
			addi $a3,$s1,0
			jal binsrch1
			lw $ra,0($sp)
			addi $sp,$sp,4
			add $a0,$v0,$0
			slt $t0,$v0,$0
			beq $t0,$0,found
			li $v0,4
			la $a0,msg2
			syscall
			jr $ra

found:		add $s0,$v0,$0
			li $v0,4
			la $a0,msg1
			syscall
			li $v0,1
			add $a0,$s0,$0
			syscall
			jr $ra

binsrch1:	slt $t0,$a2,$a1
			beq $t0,$0,binsrch2
			addi $v0,$0,-1
			jr $ra

binsrch2:	add $t0,$a1,$a2
			srl $t0,$t0,1
			add $t1,$a0,$0
			sll $t2,$t0,2
			add $t2,$t2,$t1
			lw $t2,0($t2)
			bne $t2,$a3,binsrch3
			add $v0,$t0,$0
			jr $ra

binsrch3:	slt $t3,$t2,$a3
			beq $t3,$0,binsrch4
			addi $sp,$sp,-4
			sw $ra,0($sp)
			addi $a1,$t0,1
			jal binsrch1
			lw $ra,0($sp)
			addi $sp,$sp,4
			jr $ra

binsrch4:   addi $sp,$sp,-4
			sw $ra,0($sp)
			addi $a2,$t0,-1
			jal binsrch1
			lw $ra,0($sp)
			addi $sp,$sp,4
			jr $ra

		


