//correct functionality for a timescale of 1ns/<precision>
module test;
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, test);
  end
  
  reg clk, rst;
  wire [15:0] cnt_ms;
  parameter period = 200; //200ns periods correspond to 5 MHz
  
  ms_cnt ms_cnt_1(
    .clk(clk),
    .rst(rst),
    .cnt_ms(cnt_ms)
  );
    
  initial begin
    rst = 1;
    clk = 0;
    #10 rst = 0;
  end
  
  initial begin
    repeat(45000)
      #(period/2) clk = ~clk;
  end
endmodule