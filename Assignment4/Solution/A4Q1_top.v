module top;
reg signed [7:0] A;
reg signed[7:0] B;
reg opcode;

wire signed[7:0] Sum;
wire Cout;
wire overflow;

eight_bit AS(A,B,opcode,Sum,Cout,overflow);

always @(A or B or opcode or Sum or Cout or overflow)
begin
        $display("Time=%d A=%d B=%d opcode=%b sum=%d carry_out=%b overflow=%b", $time, A, B, opcode, Sum, Cout, overflow);
end

initial begin
	#20;
	$finish;
end

initial begin
      A = 54; B = 64; opcode = 1;
      #1
      $display("\n");
      A = 120; B = 7; opcode = 0;
      #1
      $display("\n");
      A = 88; B = 40; opcode = 1;
      #1
      $display("\n");
      A = 39; B = 70; opcode = 0;
      #1
      $display("\n");
      A = -16; B = 98; opcode = 1;
      #1
      $display("\n");
      A = 80; B = 50; opcode = 0;
      #1
      $display("\n");
      A = -66; B = 74; opcode = 1;
      #1
      $display("\n");
      A = -49; B = -80; opcode = 0;
      #1
      $display("\n");
      A = 66; B = 88; opcode = 1;
      #1
      $display("\n");
      A = 1; B = 30; opcode = 0;

end


endmodule

