module eight_bit_adder_top;
reg [7:0] A;
reg [7:0] B;
reg Cin;

wire [7:0] Sum;
wire Cout;

eight_bit_adder ADDER (A,B,Cin,Sum,Cout);

always @(A or B or Cin or Sum or Cout)
begin
        $display("Time = %d, A=%d, B=%d, Cin=%d, Sum=%d, Cout=%d", $time, A, B, Cin, Sum, Cout);
end

initial begin
	#20;
	$finish;
end

initial begin
      A = 10; B = 100; Cin = 1;
      #1
      $display("\n");
      A = 90; B = 70; Cin = 0;
      #1
      $display("\n");
      A = 190; B = 25; Cin = 0;
      #1
      $display("\n");
      A = 150; B = 89; Cin = 1;
      #1
      $display("\n");
      A = 60; B = 20; Cin = 0;
      #1
      $display("\n");
      A = 20; B = 34; Cin = 1;
      #1
      $display("\n");
      A = 110; B = 65; Cin = 1;
      #1
      $display("\n");
      A = 40; B = 12; Cin = 0;
      #1
      $display("\n");
      A = 19; B = 78; Cin = 1;
      #1
      $display("\n");
      A = 204; B = 15; Cin = 0;
end


endmodule

