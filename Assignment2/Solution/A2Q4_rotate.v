module blink(clk,result);

input clk;
output [3:0] result;
reg [3:0] result;
reg [18:0] ccnt;

always @(negedge clk) begin
        ccnt=ccnt+1;
        if(ccnt==25000) begin
                ccnt<=0;
		result[0]<= result[3];
                result[1]<= result[0];
		result[2]<= result[1];
		result[3]<= result[2];

	end
end

initial begin
        ccnt=-1;
        result=4'b1000;
end

endmodule

