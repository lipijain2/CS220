module top;

wire signed [63:0] PRODUCT;
wire done; 
wire [4:0]addcnt, subcnt;

reg [3:0] test_no = 0;

reg signed [31:0] Multiplicand, Multiplier;
reg clk, input_bit=0;

booth BOOTH(Multiplicand, Multiplier, clk, input_bit, PRODUCT, done, addcnt, subcnt);

always @(negedge clk)  begin
    if (done == 1) begin
        if (test_no > 0) begin
            $display("Multiplicand=%d, Multiplier=%d, PRODUCT=%d, addcnt=%d, subcnt=%d", Multiplicand, Multiplier, PRODUCT, addcnt, subcnt);
        end
        if (Multiplier == 0 || Multiplier == -1) begin
          input_bit = 0;
        end
        if (test_no == 0) begin
            Multiplicand = 20; Multiplier = -9; input_bit = 1;
        end
        else if (test_no == 1) begin
            Multiplicand = 100; Multiplier = 1; input_bit = 1;
        end
        else if (test_no == 2) begin 
            Multiplicand = 46293 ; Multiplier = -3; input_bit = 1;
        end
        else if (test_no == 3) begin 
            Multiplicand = -13476; Multiplier = -1; input_bit = 1;
        end
        else if (test_no == 4) begin 
            Multiplicand = 500; Multiplier = -5; input_bit = 1;
        end
        else if (test_no == 5) begin 
            Multiplicand = 135; Multiplier = -95; input_bit = 1;
        end
        else if (test_no == 6) begin 
            Multiplicand = 1342; Multiplier = 0; input_bit = 1;
        end
        else if (test_no == 7) begin 
            Multiplicand = 0; Multiplier = -15; input_bit = 1;
        end
        else if (test_no == 8) begin
            Multiplicand = -1; Multiplier = 765; input_bit = 1;
        end
        else if (test_no == 9) begin
            Multiplicand = 1; Multiplier = -6; input_bit = 1;
        end
        else begin
          $finish;
        end
        test_no <= test_no + 1;
    end
    else begin
        input_bit = 0;
    end
end

initial begin
    forever begin
        clk <= 1;
        #5
        clk <= 0;
        #5
        clk <= 1;
    end
end

endmodule