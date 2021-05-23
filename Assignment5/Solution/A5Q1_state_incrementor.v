module state_incrementor(present_state,next_state);

input [3:0] present_state;
output [3:0] next_state;
wire carry_out;
wire [3:0] next_state;

four_bit_adder uut(present_state, 4'b0001, 1'b0, next_state, carry_out);

endmodule
