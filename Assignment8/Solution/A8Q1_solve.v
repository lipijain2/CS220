`define OUTPUT_REG 2
`define MAX_PC 14

module solve(clk,done);
 input clk;
 output done;
 reg [31:0] memory[0:13];
 reg signed [7:0] arr[0:10];
 reg signed [7:0] regfile[0:31];
 reg [7:0] PC;
 reg [2:0] state;
 reg [31:0] instruction;
 reg [5:0] opcode;
 reg [5:0] func;
 reg [4:0] rs;
 reg [4:0] rt;
 reg [4:0] rd;
 reg [4:0] dest;
 reg signed [15:0] immediate;
 reg [25:0] jtarget;
 reg [7:0] source1;
 reg [7:0] source2;
 reg [7:0] tobewritten;
 reg [4:0] loadadd;
 reg invalid;
 reg done=0;

 initial begin
  memory[0]=32'b001001_00000_00010_0000000000000000;// addiu $2, $0, 0
  memory[1]=32'b001001_00000_00011_0000000000000000;// addiu $3, $0, 0
  memory[2]=32'b000000_00011_00001_00100_00000_101010;// slt $4, $3, $1
  memory[3]=32'b000100_00100_00000_0000000000001000;// beq $4, $0, exit
  memory[4]=32'b001001_00000_00101_0000000000001010;// addiu $5, $0, 10
  memory[5]=32'b000100_00011_00101_0000000000000110;// beq $3, $5, exit 
  memory[6]=32'b100011_00011_00110_0000000000000000;// lw $6, 0($3)
  memory[7]=32'b000000_00010_00110_00010_00000_100001;// addu $2, $2, $6
  memory[8]=32'b001001_00011_00011_0000000000000001;// addiu $3, $3, 1
  memory[9]=32'b000000_00011_00001_00100_00000_101010;// slt $4, $3, $1
  memory[10]=32'b000101_00100_00000_11111111_11111011;// bne $4, $0, loop
  memory[11]=32'b000000_11111_00000_00000_00000_001000;//  jr $31
  memory[12]=32'b100011_00000_00001_0000000000001010;// lw $1, 10($0)
  memory[13]=32'b000011_00000000000000000000000000;//  jal Sum
  regfile[0]=8'b00000000;
  regfile[1]=8'b00000000;
  regfile[2]=8'b00000000;
  regfile[3]=8'b00000000;
  regfile[4]=8'b00000000;
  regfile[5]=8'b00000000;
  regfile[6]=8'b00000000;
  regfile[7]=8'b00000000;
  regfile[8]=8'b00000000;
  regfile[9]=8'b00000000;
  regfile[10]=8'b00000000;
  regfile[11]=8'b00000000;
  regfile[12]=8'b00000000;
  regfile[13]=8'b00000000;
  regfile[14]=8'b00000000;
  regfile[15]=8'b00000000;
  regfile[16]=8'b00000000;
  regfile[17]=8'b00000000;
  regfile[18]=8'b00000000;
  regfile[19]=8'b00000000;
  regfile[20]=8'b00000000;
  regfile[21]=8'b00000000;
  regfile[22]=8'b00000000;
  regfile[23]=8'b00000000;
  regfile[24]=8'b00000000;
  regfile[25]=8'b00000000;
  regfile[26]=8'b00000000;
  regfile[27]=8'b00000000;
  regfile[28]=8'b00000000;
  regfile[29]=8'b00000000;
  regfile[30]=8'b00000000;
  regfile[31]=8'b00000000;
  arr[0]=-10;
  arr[1]=-25;
  arr[2]=8;
  arr[3]=-20;
  arr[4]=5;
  arr[5]=15;
  arr[6]=-30;
  arr[7]=45;
  arr[8]=1;
  arr[9]=6;
  arr[10]=12;
  PC=8'b00001100;
  state=3'b000;
  loadadd=5'b00000;
  invalid=0;
  arr[10] <= arr[10] > 10? 10:arr[10];
 end

 always @(posedge clk) begin
  if(state==3'b000)begin
   instruction<=#1 memory[PC];
   state<=#1 3'b001;
  end

  else if (state==3'b001) begin
   opcode<=#1 instruction[31:26];
   func<=#1 instruction[5:0];
   jtarget<=#1 instruction[25:0];
   rs<=#1 instruction[25:21];
   rt<=#1 instruction[20:16];
   rd<=#1 instruction[15:11];
   immediate<=#1 instruction[15:0];
   state<=#1 3'b010;
  end

  else if (state==3'b010) begin
   source1<=#1 regfile[rs];
   source2<=#1 regfile[rt];
   state<=#1 3'b011;
  end

  else if (state==3'b011) begin
   if (opcode==6'b100011) begin
    //lw
    loadadd<=#1 immediate[7:0] + source1;
    dest=rt;
    PC<=PC+1;
   end
   else if (opcode==6'b001001) begin
    //addiu
    tobewritten<=#1 immediate[7:0] + source1;
    PC<=PC+1;
    dest=rt;
   end
   else if (opcode==6'b0 && func==6'b101010) begin
    //slt
    tobewritten<=#1 ($signed(source1) < $signed(source2))?1:0;
    PC<=PC+1;
    dest=rd;
   end
   else if (opcode==6'b000100)begin
    //beq
    PC<=#1 (source1==source2)?PC+immediate[7:0]:PC+1;
   end
   else if (opcode==6'b000000 && func==6'b100001) begin
    //addu
    tobewritten<=#1 (source1 + source2);
    PC<=PC+1;
    dest<=rd;
   end
   else if (opcode==6'b000101) begin
    //bne
    PC<=#1 (source1!=source2)?PC+immediate[7:0]:PC+1;
   end
   else if (opcode==6'b0 && func==6'b001000) begin
    //jr
    PC<=#1 source1;
   end
   else if (opcode==6'b000011) begin
    //jal
    PC<=#1 jtarget[7:0];
    regfile[31]<=PC+1;
   end
   else begin
    invalid=1'b1;
   end
   state<= #1 3'b100;
  end
  else if(state==3'b100)begin
   if(opcode==6'b100011)begin
    tobewritten<= #1 arr[loadadd];
   end
   state<= #1 3'b101;
  end
  else if(state==3'b101)begin
   if(invalid==1'b0 && dest!=5'b00000)begin
    regfile[dest]<=#1 tobewritten;
   end
   if(PC<`MAX_PC)begin
    state<=#1 0;
   end
   else begin
    state<=#1 3'b110;
   end
  end
  
  else if(state==3'b110)begin
   $display("time : %d, Output : %d", $time, regfile[`OUTPUT_REG]);
   done <= 1;
  end
 end
endmodule
