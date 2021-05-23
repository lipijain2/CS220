module top;
reg [2:0] A;
wire [7:0] dec_out;
wire [2:0] out;
decode DEC(A,dec_out);
encode ENC(dec_out,out);
always @(A or dec_out or out)
begin
	$display("Time=%d , A = %b , out = %b",$time,A,out);
end
initial begin
	A=3'b000;
        $display("\n");
	#1;
        A=3'b001;
        $display("\n");
        #1;
        A=3'b010;
        $display("\n");
        #1;
        A=3'b011;
        $display("\n");
        #1;
        A=3'b100;
        $display("\n");
        #1;
        A=3'b101;
        $display("\n");
        #1;
        A=3'b110;
        $display("\n");
        #1;
        A=3'b111;
        $display("\n");
        #1;


	$finish;
end
endmodule

