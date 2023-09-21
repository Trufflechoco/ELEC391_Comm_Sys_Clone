module multiplierv2(in1, in2, out);

  input signed [15:0] in1, in2;
  reg signed [31:0] store;
  output reg signed [15:0] out;

  always @(*) begin
    store = in1*in2 >>> 13;
    out = store[15:0];
  end
endmodule
