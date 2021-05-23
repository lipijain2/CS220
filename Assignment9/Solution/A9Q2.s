            .data
A:          .space 60
B:          .space 60

            .text
            .globl main
main:       li $v0 5
            syscall
            move $t0 $v0
            li $t1 0
            la $s1 A

    inputA: li $v0 6
            syscall
            s.s $f0 ($s1)
            addi $s1 $s1 4
            addi $t1 $t1 1
            bne $t1 $t0 inputA

            xor $t1 $t1 $t1
            la $s2 B

    inputB: li $v0 6
            syscall
            s.s $f0 ($s2)
            addi $s2 $s2 4
            addi $t1 $t1 1
            bne $t1 $t0 inputB

            xor $v0 $v0 $v0
            mtc1 $v0 $f12
            la $s1 A
            la $s2 B
            li $t1 0

    output: l.s $f1 ($s1)
            l.s $f2 ($s2)
            mul.s $f3 $f1 $f2
            add.s $f12 $f12 $f3
            addi $s1 $s1 4
            addi $s2 $s2 4
            addi $t1 $t1 1

            bne $t1 $t0 output
            li $v0 2
            syscall
            jr $ra

