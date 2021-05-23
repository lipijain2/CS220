module top;

reg clk;
reg in;
wire out ;

fsm my_fsm(in, clk, out);

always @(posedge clk) 
begin
	$display("Time=%d output=%b",$time,out);
end

initial 
begin
	forever begin
		clk=0;
		#5
		clk=1;
		#5
		clk=0;
	end
end

initial
begin
        #3
        in=0;
        #10
        in=1;
        #10
        in=0;
        #10
        in=1;
        #10
        in=0;
        #10
        in=1;
        #10
        in=1;
        #10
        in=1;
        #10
        in=0;
        #10
        in=1;
	#10
        $finish;

end
endmodule
