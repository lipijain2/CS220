.data
msg: .asciiz ","

.text
.globl main
main: li $v0,5        
  syscall          
  move $s1 $v0      
  li $s0 0      
  blez $s1,exit      
print: addi $sp,$sp,-4    
  sw $ra,0($sp)      
  add $a0,$s0,$0      
  jal fib          
  add $a0,$v0,$0       
  li $v0,1
  syscall
  lw $ra,0($sp)
  addi $sp,$sp,4
  addi $s0,$s0,1
  beq $s0,$s1,exit
  li $v0,4
  la $a0,msg
  syscall
  slt $t0,$s0,$s1
  bne $t0,$0,print
exit: jr $ra
fib: slti $t0,$a0,2      
  beq $t0,$0,loop    
  addi $v0,$0,1      
  jr $ra           
loop: addi $sp,$sp,-4     
  sw $ra,0($sp)      
  addi $sp,$sp,-4
  sw $a0,0($sp)
  addi $a0,$a0,-1      
  
  jal fib

  add $t0,$v0,$0
  lw $a0,0($sp)
  addi $sp,$sp,-4
  sw $t0,0($sp)
  addi $a0,$a0,-2
  
  jal fib

  lw $t0,0($sp)
  addi $sp,$sp,8
  lw $ra,0($sp)
  addi $sp,$sp,4
  add $v0,$t0,$v0
  jr $ra
