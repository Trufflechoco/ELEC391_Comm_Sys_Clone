module hamming_encoder(in, out, parity);

  //Hamming(7,4), encodes a 4-bit input when a  7-bit keyword
  input [3:0] in;
  //encoded message
  output [6:0] out;
  //parity bit showing whether encoded message is even or odd
  output parity;
  //registers for storing parity bits
  reg p1, p2, p4;

  //parity bit generation
  always @(*) begin
    p1 = in[0] ^ in[1] ^ in[2];
    p2 = in[0] ^ in[2] ^ in[3];
    p4 = in[1] ^ in[2] ^ in[3];
  end

  //input:   d3 d2 d1    d0
  //output:  d7 d6 d5 p4 d3 p2 p1
  assign out = {in[3:1],p4,in[0],p2,p1};

  //this parity bit tells whether input is even or odd
  assign parity = ^in;
endmodule
