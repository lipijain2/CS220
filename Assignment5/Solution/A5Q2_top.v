module top;

reg [2:0] a,b,c,d;
wire [2:0] index;

smallest AA(a,b,c,d,index);

always @(a or b or c or d )
begin
	
	$monitor("Time=%d a=%b b=%b c=%b d=%b index=%d", $time,a,b,c,d,index);
end

initial begin
	#1
	a=111;b=111;c=011;d=010;
	#1
	a=001;b=001;c=011;d=010;
        #1
        a=010;b=110;c=011;d=111;
        #1
        a=101;b=110;c=000;d=001;
        #1
        a=100;b=101;c=111;d=010;
        #1
        a=101;b=111;c=011;d=010;
        #1
        a=111;b=001;c=011;d=100;
        #1
        a=000;b=101;c=011;d=010;
        #1
        a=111;b=100;c=011;d=100;
        #1
        a=001;b=110;c=011;d=001;
	$finish;
end 
endmodule
