module top;
reg [7:0] A;
wire [2:0] B;

priority_encoder PE(A,B);
always @(A or B)
begin
	$display("time=%d , A = %b , B = %b ", $time,A,B);
end

initial begin
	A=8'b11010011;
	$display("\n");
	#1
        A=8'b10010010;
        $display("\n");
        #1
	A=8'b10000100;
        $display("\n");
        #1
        A=8'b00011000;
        $display("\n");
        #1
        A=8'b00010000;
        $display("\n");
        #1
        A=8'b11100000;
        $display("\n");
        #1
        A=8'b11000000;
        $display("\n");
        #1
        A=8'b10000000;
        $display("\n");
        #1
        A=8'b00011110;
        $display("\n");
        #1
        A=8'b10010000;
        $display("\n");
        #1
        $finish;
end
endmodule


