module tester_tb();
  reg [15:0] in1, in2;
  wire [15:0] out1;
  
  multiplier multiplier(in1, in2, out1);

  initial begin
    in1 = 16'b0000110111001000;
    in2 = 16'b0000110111001000; #5; 
    in1 = 16'b0001011000001110; #5;
    in1 = 16'b1111000000011010; #5; 
    in2 = 16'b1111000000011010; #5; $stop;
  end

endmodule
