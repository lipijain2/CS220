`define LENGTH 32

 module booth(Multiplicand, Multiplier, clk, input_bit, PRODUCT, done, addcnt, subcnt);

    input signed [31:0] Multiplicand, Multiplier;
    input clk, input_bit;
    reg [4:0] present_index = 0;
    reg previous_bit = 0;
    reg current_bit;
    reg signed [31:0] multiplier_shifted;
    output reg signed [63:0] PRODUCT = 64'b0;
    output reg [4:0] addcnt = 0, subcnt = 0;
    output reg done = 1;

    always @(posedge input_bit) begin
        addcnt <= 0;
        subcnt <= 0;
        present_index <= 0;
        previous_bit <= 0;
        done <= 0;
        PRODUCT <= 64'b0;
    end

    always @(posedge clk) begin
        current_bit <= Multiplier[present_index];
        #1
        if (current_bit != previous_bit) begin
            if (current_bit == 1) begin
                PRODUCT <= PRODUCT - (Multiplicand << present_index);
                subcnt <= subcnt + 1;
            end
            else begin
                PRODUCT <= PRODUCT + (Multiplicand << present_index);
                addcnt <= addcnt + 1;
            end
        end
        multiplier_shifted <= Multiplier >>> (present_index + 1);
        #2
        if (present_index == `LENGTH - 1) begin
            done <= 1;
        end 
        if (current_bit == 0) begin
            if (multiplier_shifted == 0) begin
                done <= 1;
            end
        end
        else begin
            if(multiplier_shifted == -1) begin
                done <= 1;
            end
        end
        present_index <= present_index + 1;
        previous_bit <= current_bit;
    end

endmodule
