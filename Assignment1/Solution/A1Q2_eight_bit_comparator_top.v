module eight_bit_comparator_top;
reg [7:0]A;
reg [7:0]B;
wire A_less_B,A_equal_B,A_greater_B;
eight_bit_comparator COMPARATOR(A,B,A_less_B,A_equal_B,A_greater_B);

always @(A or B or A_less_B or A_equal_B or A_greater_B)
begin
	$display("Time:%d  A=%d B=%d A_less_B=%b A_equal_B=%b A_greater_B=%b",$time,A,B,A_less_B,A_equal_B,A_greater_B);
end
initial begin
	A=8;B=80;
	#1
	$display("\n");
	A=180;B=180;
	#1
	$display("\n");
	A=250;B=245;
	#1
	$display("\n");
	A=216;B=216;
	#1
	$display("\n");
	A=45;B=44;
	#1
	$display("\n");
	A=100;B=200;
	#1
	$display("\n");
	A=5;B=7;
	#1
	$display("\n");
	A=152;B=152;
	#1
	$display("\n");
	A=164;B=264;
        #1
	$display("\n");
        A=131;B=131;
	#1
	$finish;
end
endmodule
