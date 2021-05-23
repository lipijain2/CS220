module blink_top;

reg clk;
wire [3:0] result;

reg [18:0] cycle_cnt;

blink uut(clk,result);

always @(result) begin
        if (cycle_cnt>310000)begin
                $finish;
        end
        $display("Time=%d, cycle_cnt=%d,  result=%b",$time, cycle_cnt, result);
end


initial begin
        cycle_cnt=0;
end

initial begin
        forever begin
                clk=0;
                #5
                clk=1;
                #5
                cycle_cnt = cycle_cnt+1;
                clk=0;
        end
end
endmodule

