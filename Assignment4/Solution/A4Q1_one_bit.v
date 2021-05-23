module one_bit(a,b,cin,opcode,sum,cout);
input a,b,cin,opcode;
output sum,cout;
wire sum,cout;


assign sum=a^(b^opcode)^cin;
assign cout=(a&(b^opcode)) | ((b^opcode)&cin) | (a&cin);

endmodule
