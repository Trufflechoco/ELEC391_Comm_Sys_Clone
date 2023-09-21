module transmitter_reciever_tb();
  reg [15:0] symb_in;
  reg clk, reset;
  wire [15:0] symb_out;
  wire [15:0] out;
  wire [15:0] downsampled_out;
  wire clk_1, clk_2, clk_3, clk_4, clk_5;
  reg read;

  transmitter transmitter(symb_in, symb_out, clk, reset, read);
  reciever reciever(symb_out, out, clk, reset);
  downsampler downsampler(.in(out), .out(downsampled_out), .clk(clk), .reset(reset));

  initial begin
    reset = 1; #10;
    reset = 0; read = 1; symb_in = 16'b0001011010100001; #10;
    read = 0; #20;
    read = 1; symb_in = 16'b1110100101011111; #10;
    read = 0; #20;
    read = 1; symb_in = 0; #10;
    read = 0; #20;
    read = 1; symb_in = 16'b1110100101011111; #10;
    read = 0; #20;
    read = 1; symb_in = 16'b0001011010100001; #10;
    read = 0; #20;
    read = 1; symb_in = 0; #10;
    read = 0; #20;
    #400; $stop;
  end

  always begin
    clk = 0; #5; clk = 1; #5;
  end
endmodule
