module QPSK_tb;

  reg [6:0] in;

  wire [15:0] symb_real_1, symb_imag_1;
  wire [15:0] symb_real_2, symb_imag_2;
  wire [15:0] symb_real_3, symb_imag_3;
  wire [15:0] symb_real_4, symb_imag_4;

  wire [6:0] out;

  QPSK_Modulator QPSK_Modulator(in, symb_real_1, symb_imag_1,
  symb_real_2, symb_imag_2, symb_real_3, symb_imag_3,
  symb_real_4, symb_imag_4);

  QPSK_Demodulator QPSK_Demodulator(out, symb_real_1, symb_imag_1,
  symb_real_2, symb_imag_2, symb_real_3, symb_imag_3,
  symb_real_4, symb_imag_4);

  initial begin
    in = 7'b1100110; #5;
    in = 7'b1010011; #5;
    in = 7'b0110001; #5;
    in = 7'b0001110; #5;
    $stop;
  end
endmodule
