module ms_msr(
  input clk, rst,
  output ms_passed,
  output [15:0] cnt_clk
);
  reg [15:0] cnt_reg, cnt_nxt;
  
  always @(*) begin
    cnt_nxt = cnt_reg;
    
    if(cnt_reg == 5000) begin
      cnt_nxt = 0;
    end
    else begin
      cnt_nxt = cnt_reg + 1;
    end
  end 
  
  always @(negedge clk or posedge rst) begin
    if(rst == 1) begin
      cnt_reg <= 0;
    end
    else begin
      cnt_reg = cnt_nxt;
    end
  end
  
  assign ms_passed = (cnt_reg == 5000);
  assign cnt_clk = cnt_reg;
endmodule