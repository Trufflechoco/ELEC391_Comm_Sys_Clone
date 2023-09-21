module transmitter_reciever_tb();
  reg [15:0] symb_in;
  reg clk, reset;
  wire [15:0] symb_out;
  wire [15:0] out;
  wire read_ready_t, read_ready_r;

  transmitter transmitter(symb_in, symb_out, clk, reset, read_ready_t);
  reciever reciever(symb_out, out, clk, reset, read_ready_r);

  initial begin
    reset = 1; #10;
    reset = 0; symb_in = 16'b0001011010100001; #10;
    symb_in = 0; #10;
    /* #10; $stop;
    #10; $stop;
    #10; $stop;
    #10; $stop;
    #10; $stop;
    #10; $stop;*/
    #400; $stop;
  end

  always begin
    clk = 0; #5; clk = 1; #5;
  end
endmodule
