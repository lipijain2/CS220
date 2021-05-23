module smallest(a,b,c,d,index);
input [2:0] a,b,c,d;
output wire [2:0] index;
wire [2:0] out1;
wire [2:0] out2;
wire [2:0] num;

wire [2:0] index1,index2,index3;
comparator C1(a,b,out1);
comparator C2(c,out1,out2);
comparator C3(d,out2,num);

assign index1=0;
assign index2=(num^b)?index1:1;
assign index3=(num^c)?index2:2;
assign index=(num^d)?index3:3;

endmodule


