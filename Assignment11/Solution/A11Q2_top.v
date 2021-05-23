module top;

reg [31:0] dvdnd;
reg [31:0] dvsr;
reg signed [6:0] dvdnd_len;
reg signed [6:0] dvsr_len;
reg inpt_sgnl = 0;
reg clk;

wire [31:0] qtnt;
wire signed [31:0] rmndr; 
wire [4:0] add_no;
wire [4:0] sub_no;
wire done;

reg [3:0] test_no = 0;

div M1(dvdnd, dvsr, dvdnd_len, dvsr_len, inpt_sgnl, clk, qtnt, rmndr, add_no, sub_no, done);

always @(negedge clk) begin
    if (done == 1) begin
    
        if (dvdnd_len - dvsr_len < 0 ) begin
          inpt_sgnl = 0;
        end
        if (test_no > 0) begin
            $display("dividend: %d, divisor: %d, quotient: %d, remainder: %d, No. of additions: %d, No. of subtractions: %d", dvdnd, dvsr, qtnt, rmndr, add_no, sub_no);
        end
        if (test_no == 0) begin
            dvdnd = 222; dvsr = 20; dvdnd_len = 8; dvsr_len = 5; inpt_sgnl = 1;
        end
        else if (test_no == 1) begin
            dvdnd = 15; dvsr = 2; dvdnd_len = 4; dvsr_len = 2; inpt_sgnl = 1;
        end
        else if (test_no == 2) begin 
            dvdnd = 140; dvsr = 4; dvdnd_len = 8; dvsr_len = 3; inpt_sgnl = 1;
        end
        else if (test_no == 3) begin
            dvdnd = 9; dvsr = 1; dvdnd_len = 4; dvsr_len = 1; inpt_sgnl = 1;
        end
        else if (test_no == 4) begin 
            dvdnd = 100; dvsr = 7; dvdnd_len = 7; dvsr_len = 3; inpt_sgnl = 1;
        end
        else if (test_no == 5) begin 
            dvdnd = 1; dvsr = 100; dvdnd_len = 1; dvsr_len = 7; inpt_sgnl = 1;
        end
        else if (test_no == 6) begin 
            dvdnd = 55; dvsr = 56; dvdnd_len = 6; dvsr_len = 6; inpt_sgnl = 1;
        end
        else if (test_no == 7) begin 
            dvdnd = 505; dvsr = 505; dvdnd_len = 9; dvsr_len = 9; inpt_sgnl = 1;
        end
        else if (test_no == 8) begin
            dvdnd = 1124; dvsr = 2; dvdnd_len = 11; dvsr_len = 2; inpt_sgnl = 1;
        end
        else if (test_no == 9) begin
            dvdnd = 2222; dvsr = 1; dvdnd_len = 12; dvsr_len = 1; inpt_sgnl = 1;
        end
        else begin
          $finish;
        end
        test_no <= test_no + 1;
    end
    else begin
        inpt_sgnl = 0;
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
