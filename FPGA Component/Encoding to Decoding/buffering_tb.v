module buffering_tb ();
  reg clk, reset, write;
  reg [23:0] in;
  wire [23:0] out;
  wire [3:0] buffer_wire;
  wire [2:0] state_1, state_2;
  wire enable;

  buffer buffer(in, buffer_wire, clk, reset, write, enable);
  unbuffer unbuffer(buffer_wire, out, clk, reset, enable);

  assign state_1 = buffer.state;
  assign state_2 = buffer.state;

  initial begin
    in = 0; reset = 1; write = 0; #10;
    reset = 0; #10;

    write = 1; in = 24'b1011_1001_1000_1110_1010_0001; #10;
    write = 0; #50;

    in = 0; write = 1; #10;
    write = 0; #50;

    write = 1; in = 24'b1011_1001_1000_1110_1010_0001; #10;
    write = 0; #50;

    in = 0; write = 1; #10;
    write = 0; #50;

    write = 1; in = 24'b1011_1001_1000_1110_1010_0001; #10;
    write = 0; #100; $stop; 

  end
  always begin
    clk = 0; #5; clk = 1; #5;
  end
endmodule
