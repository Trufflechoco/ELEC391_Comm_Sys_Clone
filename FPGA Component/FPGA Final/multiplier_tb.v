module multiplier_tb();
  reg [15:0] in1, in2;
  wire [15:0] out1, out2;

  multiplier multiplier(.in1(in1), .in2(in2), .out(out1));
  multiplierv2 multiplierv2(.in1(in1), .in2(in2), .out(out2));

  initial begin
    in1 = 16'b0001011010100001; in2 = 16'b0001011010100001; #5; 
    in1 = 16'b1110100101011111; in2 = 16'b1110100101011111; #5; 
    in1 = 16'b1110100101011111; in2 = 16'b0001011010100001; #5; 
    in1 = 16'b0001011010100001; in2 = 16'b1110100101011111; #5; 
    in1 = 16'b1111111101110101; in2 = 16'b1111111101110101; #5;
    in1 = 16'b0000000011010000; in2 = 16'b1111111101110101; #5; 
    in1 = 16'b1111111101110101; in2 = 16'b0000000011010000;  #5;$stop;
  end
endmodule
