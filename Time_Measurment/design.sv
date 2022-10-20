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

module ms_cnt(
  input clk, rst,
  output [15:0] cnt_ms
);
  
  reg [15:0] cnt_reg, cnt_nxt;
  wire ms_passed;
  wire [15:0] cnt_clk;
  
  ms_msr ms_msr_1(
    .clk(clk),
    .rst(rst),
    .ms_passed(ms_passed),
    .cnt_clk(cnt_clk)
  );
  
  always @(*) begin
    cnt_nxt = cnt_reg;
    
    if(ms_passed) begin
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
  
  assign cnt_ms = cnt_reg;
endmodule