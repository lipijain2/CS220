module top;
	reg clk;
	

	wire [3:0]I;
	wire [3:0]J;
	wire [3:0]R;
	wire [3:0]cnt3;
	wire [3:0]cnt4;
	wire [3:0]cnt5;
	wire [3:0]cnt6;

    solve uut(clk,R,J,I,cnt3,cnt4,cnt5,cnt6);

    
	initial begin
		forever begin
			clk=0;
			#5
			clk=1;
			#5
			clk=0;
		end
	end
	initial begin
		#80
		$display("I instructions count= %d\nJ instructions count= %d\nR instructions count=%d\nNumber of insructions written to $3=%d,$4=%d,$5=%d,$6=%d",I,J,R,cnt3,cnt4,cnt5,cnt6);
		#5
		$finish;
	end
endmodule