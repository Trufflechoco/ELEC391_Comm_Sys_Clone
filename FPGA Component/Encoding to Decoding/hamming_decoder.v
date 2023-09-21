module hamming_decoder(in, out, error_1bit, error_2bit, in_parity);

  //Hamming(7,4), decodes a 7-bit keyword into a 4-bit output
  //input keyword
  input [6:0] in;
  //parity bit showing whether encoded message is even or odd
  input in_parity;
  //decoded message
  output [3:0] out;
  //1-bit errors can be corrected, 2-bit errors cannot, use these outputs
  //for BER calculation
  output error_1bit, error_2bit;

  reg p1, p2, p4;
  reg [6:0] onehot;
  wire [6:0] decoded_data;
  wire parity;

  //parity bit decoding
  always @(*) begin
    p1 = in[0] ^ in[2] ^ in[4] ^ in[6];
    p2 = in[1] ^ in[2] ^ in[5] ^ in[6];
    p4 = in[3] ^ in[4] ^ in[5] ^ in[6];
  end

  //generates onehot code for decoding from parity bit
  always @(*) begin
    case ({p4, p2, p1})
      3'd1 : onehot = 7'b0000001;
      3'd2 : onehot = 7'b0000010;
      3'd3 : onehot = 7'b0000100;
      3'd4 : onehot = 7'b0001000;
      3'd5 : onehot = 7'b0010000;
      3'd6 : onehot = 7'b0100000;
      3'd7 : onehot = 7'b1000000;
      default : onehot = 7'b0000000;
    endcase
  end

  //decoded data
  assign decoded_data = onehot ^ in;

  //parity bit isn't going into modulator but will be used for error detection
  //when used with error_1bit and error_2bit
  assign parity = ^in;
  assign error_1bit = |{p4,p2,p1};
  assign error_2bit = {in_parity == parity} & error_1bit;

  //input:  d7 d6 d5 p4 d3 p2 p1
  //output: d3 d2 d1    d0
  assign out = {decoded_data[6:4],decoded_data[2]};
endmodule
