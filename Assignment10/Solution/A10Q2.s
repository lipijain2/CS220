        .data
A:      .space 60
msg1:   .asciiz "Answer: "
        .text
        .globl main

main:   li $v0 5
        syscall
        add $t0 $0 $v0
        xor $t1 $t1 $t1
        la $s1 A

scan:   li $v0 6
        syscall
        s.s $f0 ($s1)
        addi $t1 $t1 1
        addi $s1 $s1 4
        bne $t1 $t0 scan
        xor $v0 $v0 $v0
        mtc1 $v0 $f12
        la $s1 A
        xor $t1 $t1 $t1
        xor $t2 $t2 $t2
        li $t2 2

func:   l.s $f1 ($s1)
        div $t1 $t2
        xor $t3 $t3 $t3
        mfhi $t3
        bne $t3 $0 minus
        add.s $f12 $f12 $f1
        j next

minus:  sub.s $f12 $f12 $f1

next:   addi $t1 $t1 1
        addi $s1 $s1 4
        bne $t1 $t0 func
        li $v0 4
        la $a0 msg1
        syscall
        li $v0 2
        syscall
        jr $ra
