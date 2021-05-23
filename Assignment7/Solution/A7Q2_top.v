module top;
	reg clk;
	wire [7:0]result_val;
    wire flag;
    res uut(clk,result_val,flag);

    
	initial begin
		forever begin
			clk=0;
			#5
			clk=1;
			#5
			clk=0;
		end
	end
	always @(posedge clk) begin
        if (flag==1) begin
		$display("e has value = %d",result_val);
		$finish;
        end
	end
endmodule