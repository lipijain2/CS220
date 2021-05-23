module blink(clk,result);

input clk;
output result;
reg result;
reg [14:0] ccnt;

always @(negedge clk) begin
	ccnt=ccnt+1;
	if(ccnt==25000) begin
		ccnt<=0;
		result<=~result;
	end
end

initial begin
	ccnt=-1;
	result=0;
end

endmodule


