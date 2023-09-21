module QPSK_Demodulator(out, symb_real_1, symb_imag_1,
  symb_real_2, symb_imag_2, symb_real_3, symb_imag_3,
  symb_real_4, symb_imag_4);

  input [15:0] symb_real_1, symb_imag_1;
  input [15:0] symb_real_2, symb_imag_2;
  input [15:0] symb_real_3, symb_imag_3;
  input [15:0] symb_real_4, symb_imag_4;

  output reg [6:0] out;

  always @(*) begin
    case ({symb_real_1[15], symb_imag_1[15]})
      2'b00 : out[6:5] = 2'b00;
      2'b10 : out[6:5] = 2'b01;
      2'b01 : out[6:5] = 2'b10;
      2'b11 : out[6:5] = 2'b11;
      default : out[6:5] = 2'b00;
    endcase
    case ({symb_real_2[15], symb_imag_2[15]})
      2'b00 : out[4:3] = 2'b00;
      2'b10 : out[4:3] = 2'b01;
      2'b01 : out[4:3] = 2'b10;
      2'b11 : out[4:3] = 2'b11;
      default : out[4:3] = 2'b00;
    endcase
    case ({symb_real_3[15], symb_imag_3[15]})
      2'b00 : out[2:1] = 2'b00;
      2'b10 : out[2:1] = 2'b01;
      2'b01 : out[2:1] = 2'b10;
      2'b11 : out[2:1] = 2'b11;
      default : out[2:1] = 2'b00;
    endcase
    case ({symb_real_4[15], symb_imag_4[15]})
      2'b00 : out[0] = 1'b0;
      2'b10 : out[0] = 1'b0;
      2'b01 : out[0] = 1'b1;
      2'b11 : out[0] = 1'b1;
      default : out[0] = 1'b0;
    endcase
  end

endmodule
