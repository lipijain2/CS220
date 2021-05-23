module one_bit (a,b,cin,sum,carry);
input a,b,cin;
output sum, carry;
wire sum, carry;
assign sum = a^b^cin; 
assign carry = ((a&b) | (b&cin) | (cin&a));
endmodule

module five_bit(a,b,opcode,sum,cout);
input [4:0] a;
input [4:0] b;
input opcode;
output [4:0] sum;
output cout;
wire [4:0] sum;
wire cout;
wire [3:0] intermediate_carry;
one_bit FA1(a[0], b[0]^opcode, opcode, sum[0], intermediate_carry[0]);
one_bit FA2(a[1], b[1]^opcode, intermediate_carry[0], sum[1], intermediate_carry[1]);
one_bit F32(a[2], b[2]^opcode, intermediate_carry[1], sum[2], intermediate_carry[2]);
one_bit FA4(a[3], b[3]^opcode, intermediate_carry[2], sum[3], intermediate_carry[3]);
one_bit FA5(a[4], b[4]^opcode, intermediate_carry[3], sum[4], cout);
endmodule

module grid(direction,steps,clk,x,y);
input [1:0]direction;
input [1:0]steps;
input clk;
output [4:0]x;
output [4:0]y;
reg[4:0]x;
reg[4:0]y;
wire[4:0] x_add_steps;
wire[4:0] y_add_steps;
wire[4:0] x_subtract_steps;
wire[4:0] y_subtract_steps;
wire [4:0] step;
wire c_out;
assign step[0] = steps[0];
assign step[1] = steps[1];
assign step[2] = 0;
assign step[3] = 0;
assign step[4] = 0;

five_bit AX (x,step,1'b0,x_add_steps,c_out);
five_bit AY (y,step,1'b0,y_add_steps,c_out);
five_bit SX (x,step,1'b1,x_subtract_steps,c_out);
five_bit SY (y,step,1'b1,y_subtract_steps,c_out);

always @(posedge clk)
begin

  if (direction==0)begin
    x <=#1 x_add_steps;
    #2
    if(x_add_steps[4]==1)begin
     x_add_steps[4]=0;
     x_add_steps[3]=1;
     x_add_steps[2]=1;
     x_add_steps[1]=1;
     x_add_steps[0]=1;
    end
  end

  else if(direction==1)begin
    x <=#1 x_subtract_steps;
    #2
    if(x_subtract_steps[4]==1) begin
     x_subtract_steps[3]=0;
     x_subtract_steps[2]=0;
     x_subtract_steps[1]=0;
     x_subtract_steps[4]=0;
     x_subtract_steps[0]=0;
    end

  end

  else if(direction==2)begin
    y <=#1 y_add_steps;
    #2
    if(y_add_steps[4]==1)begin
    y_add_steps[4]=0;
     y_add_steps[3]=1;
     y_add_steps[2]=1;
     y_add_steps[1]=1;
     y_add_steps[0]=1;

    end

  end

  else if(direction==3)begin
    y <=#1 y_subtract_steps;
    #2
    if(y_subtract_steps[4]==1)begin
    y_subtract_steps[4]=0;
     y_subtract_steps[3]=0;
     y_subtract_steps[2]=0;
     y_subtract_steps[1]=0;
     y_subtract_steps[0]=0;

    end

  end
  
end

initial 
begin
  x=5'b00000;
  y=5'b00000;
end

endmodule
