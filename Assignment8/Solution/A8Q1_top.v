module top;
    reg clk;
    wire done;
    solve uut(clk, done);
    always @(posedge clk) begin
        #2
        if (done == 1) begin
            $finish;
        end
    end
    initial begin
        forever begin
            clk = 0;
            #5;
            clk = 1;
            #5;
            clk = 0;
        end
    end
endmodule