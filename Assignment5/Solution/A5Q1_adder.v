module one_bit_full_adder (x,y,carry_in,sum,carry_out);

input x,y,carry_in;
output sum,carry_out;
wire sum,carry_out;

assign carry_out=((x&y) | (y&carry_in) | (x&carry_in));
assign sum=x^y^carry_in;

endmodule

module four_bit_adder (x,y,carry_in,sum,carry_out);

input [3:0] x,y;
input carry_in;

output [3:0] sum;
output carry_out;
wire [2:0] intermediate_carry;
wire [3:0] sum;
wire carry_out;

one_bit_full_adder fadd0 (x[0],y[0],carry_in,sum[0],intermediate_carry[0]);
one_bit_full_adder fadd1 (x[1],y[1],intermediate_carry[0],sum[1],intermediate_carry[1]);
one_bit_full_adder fadd2 (x[2],y[2],intermediate_carry[1],sum[2],intermediate_carry[2]);
one_bit_full_adder fadd3 (x[3],y[3],intermediate_carry[2],sum[3],carry_out);

endmodule
