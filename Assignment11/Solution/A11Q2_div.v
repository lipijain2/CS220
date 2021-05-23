module div (dvdnd, dvsr, dvdnd_len, dvsr_len, inpt_sgnl, clk, qtnt, rmndr, add_no, sub_no, done);

    input [31:0] dvdnd;
    input [31:0] dvsr;
    input signed [6:0] dvdnd_len;
    input signed [6:0] dvsr_len;
    input inpt_sgnl;
    input clk;

    output reg [31:0] qtnt = 0;
    output reg signed [31:0] rmndr; 
    output reg [4:0] add_no = 0; 
    output reg [4:0] sub_no = 0;
    output reg done = 1;

    reg [31:0] algnd_dvsr;
    reg [5:0] itrtns = 0;
    reg frst_cycle = 1; 

  always @(posedge clk) begin
      if (dvdnd_len - dvsr_len < 0) begin
        done <= 1;
      end

      else if (frst_cycle == 1) begin
          algnd_dvsr <= dvsr << (dvdnd_len - dvsr_len);
          frst_cycle <= 0;
      end

      else begin  

          if (rmndr < 0) begin
            rmndr <= rmndr + algnd_dvsr;
            qtnt <= qtnt ^ 1;
            add_no <= add_no + 1;
          end

          else begin
            rmndr <= rmndr - algnd_dvsr;
            sub_no <= sub_no + 1;
          end
          #1
          
          qtnt <= (qtnt << 1) | 1;
          algnd_dvsr <= algnd_dvsr >> 1;
          itrtns <= itrtns + 1;
          #1

          if (itrtns == dvdnd_len - dvsr_len + 1) begin

              if (rmndr < 0) begin
                rmndr <= rmndr + dvsr;
                qtnt <= qtnt - 1;
                add_no <= add_no + 1;
              end

              #1
              done <= 1;
          end
      end
  end

  always @(posedge inpt_sgnl) begin
        qtnt <= 32'b0;
        rmndr <= dvdnd;
        add_no <= 0;
        sub_no <= 0;
        done <= 0;
        itrtns <= 0;
        frst_cycle <= 1;
    end 


endmodule
