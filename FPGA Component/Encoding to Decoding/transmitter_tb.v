module transmitter_tb();
  reg [15:0] symb_in;
  reg clk, reset;
  wire [15:0] symb_out;
  wire read_ready;

  transmitter transmitter(symb_in, symb_out, clk, reset, read_ready);

  initial begin
    reset = 1; #10;
    reset = 0; symb_in = 16'b0001011010100001; #10;
    symb_in = 0; #10;
    #400; $stop;
  end

  always begin
    clk = 0; #5; clk = 1; #5;
  end
endmodule
