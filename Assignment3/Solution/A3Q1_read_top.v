module top;

reg [3:0] rn;
reg clk;
reg input_valid;
wire output_valid;

wire [31:0] result;
wire [3:0] orow;

read uut(clk, rn, input_valid, result, orow, out_valid);

always @ (posedge out_valid) begin
    $display ("time=%d, result=%d",$time, result); 
end
initial begin
	input_valid=0;
	#3
		input_valid=1;
		rn=15;
	#5
		input_valid=0;
	#25
		input_valid=1;
		rn=14;
	#5
		input_valid=0;
	#25
		input_valid=1;
		rn=8;
	#5
		input_valid=0;
	#25
		input_valid=1;
		rn=8;
	#5
		input_valid=0;
	#25
		input_valid=1;
		rn=8;
	#5
		input_valid=0;
	#25
		input_valid=1;
		rn=8;
		
	#5
		input_valid=0;
	#25
		input_valid=1;
		rn=3;
		
	#5
		input_valid=0;
	#25
		input_valid=1;
		rn=7;
		
	#5
		input_valid=0;
	#25
		input_valid=1;
		rn=7;
		
	#5
		input_valid=0;
	#25
		input_valid=1;
		rn=6;
	#30	
	
	$finish;
end
//clk
initial begin
   forever begin
      clk=0;
      #5
      clk=1;
      #5
      clk=0;
   end
end


//
initial begin
  #310 $finish;
end
endmodule