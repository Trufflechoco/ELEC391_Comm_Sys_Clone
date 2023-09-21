module clock_delay(clk, reset, delayed_clk);
  input clk, reset;
  output reg delayed_clk;

  reg prev_clk;

  always @(posedge clk, negedge clk, posedge reset) begin
    if (reset) begin
      delayed_clk <= 1'b0;
      prev_clk <= 1'b0;
    end else begin
      prev_clk <= clk;
      delayed_clk <= prev_clk;
    end
  end
endmodule
