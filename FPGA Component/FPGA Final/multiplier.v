/*module multiplier(in1, in2, out);

  input signed [15:0] in1, in2;
  reg signed [31:0] store;
  output reg signed [15:0] out;

  always @(*) begin
    store = in1*in2 >>> 13;
    out = store[15:0];
  end
endmodule*/

module multiplier(in1, in2, out);

  input [15:0] in1, in2;
  reg [31:0] add [14:0];
  reg [31:0] final;
  integer i;
  output reg [15:0] out;

  always @(*) begin
    for (i = 15; i > 0; i = i - 1) begin
      if ((in1[15] == 1'b0) && (in2[15] == 1'b0)) 
        add[i-1] = ((in1 & {16{in2[i-1]}}) << ((i-1) & {16{in2[i-1]}}));
      else if ((in1[15] == 1'b0) && (in2[15] == 1'b1)) 
        add[i-1] = ((in1 & {16{~in2[i-1]}}) << ((i-1) & {16{~in2[i-1]}}));
      else if ((in1[15] == 1'b1) && (in2[15] == 1'b0)) 
        add[i-1] = ((~in1 & {16{in2[i-1]}}) << ((i-1) & {16{in2[i-1]}}));
      else if ((in1[15] == 1'b1) && (in2[15] == 1'b1)) 
        add[i-1] = ((~in1 & {16{~in2[i-1]}}) << ((i-1) & {16{~in2[i-1]}}));
      else
        add[i-1] = 32'b000000000000000000000000000000;
    end

    final = ((add[14] + add[13] + add[12] + add[11] + add[10]
          +  add[9]  + add[8]  + add[7]  + add[6]  + add[5]  + add[4]
          +  add[3]  + add[2]  + add[1]  + add[0])) >>> 13;

    out = (in1[15]^in2[14]) ? {1'b1,~final[14:0]} : {1'b0,final[14:0]};
  end
endmodule
