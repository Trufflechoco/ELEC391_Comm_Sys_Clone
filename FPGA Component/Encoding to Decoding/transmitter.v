module transmitter(symb_in, symb_out, clk, reset, read_ready);

  input clk, reset;

  output reg read_ready;

  input [15:0] symb_in;

  output reg [15:0] symb_out;

  reg [30:0] symb_reg; 
  reg [1:0] counter;

  wire [15:0] out1, out2, out3, out4, out5, out6, out7, out8,
  out9, out10, out11, out12, out13, out14, out15, out16, out17, out18,
  out19, out20, out21, out22, out23, out24 ,out25, out26, out27, out28,
  out29, out30, out31;

  impulse_response imp(out1, out2, out3, out4, out5, out6, out7, out8,
  out9, out10, out11, out12, out13, out14, out15, out16, out17, out18,
  out19, out20, out21, out22, out23, out24 ,out25, out26, out27, out28,
  out29, out30, out31);

  always @(posedge clk) begin
    if (reset) begin
      read_ready = 1;
      counter = 2;
      symb_reg = 0;
      symb_out = 0;
    end else begin //symb_reg will be either 1 or -1 depending on symbol
      if (read_ready == 1) begin
        symb_reg[0] <= 1;
      end else begin
        symb_reg[0] <= 0;
      end
      symb_reg[1] <= symb_reg[0]; symb_reg[2] <= symb_reg[1];
      symb_reg[3] <= symb_reg[2]; symb_reg[4] <= symb_reg[3];
      symb_reg[5] <= symb_reg[4]; symb_reg[6] <= symb_reg[5];
      symb_reg[7] <= symb_reg[6]; symb_reg[8] <= symb_reg[7];
      symb_reg[9] <= symb_reg[8]; symb_reg[10] <= symb_reg[9];
      symb_reg[11] <= symb_reg[10]; symb_reg[12] <= symb_reg[11];
      symb_reg[13] <= symb_reg[12]; symb_reg[14] <= symb_reg[13];
      symb_reg[15] <= symb_reg[14]; symb_reg[16] <= symb_reg[15];
      symb_reg[17] <= symb_reg[16]; symb_reg[18] <= symb_reg[17];
      symb_reg[19] <= symb_reg[18]; symb_reg[20] <= symb_reg[19];
      symb_reg[21] <= symb_reg[20]; symb_reg[22] <= symb_reg[21];
      symb_reg[23] <= symb_reg[22]; symb_reg[24] <= symb_reg[23];
      symb_reg[25] <= symb_reg[24]; symb_reg[26] <= symb_reg[25];
      symb_reg[27] <= symb_reg[26]; symb_reg[28] <= symb_reg[27];
      symb_reg[29] <= symb_reg[28]; symb_reg[30] <= symb_reg[29];
      symb_out <= symb_reg[0] * out1 + symb_reg[1] *  out2 +
                  symb_reg[2] * out3 + symb_reg[3] *  out4 +
                  symb_reg[4] * out5 + symb_reg[5] *  out6 +
                  symb_reg[6] * out7 + symb_reg[7] *  out8 +
                  symb_reg[8] * out9 + symb_reg[9] *  out10 +
                  symb_reg[10] * out11 + symb_reg[11] *  out12 +
                  symb_reg[12] * out13 + symb_reg[13] *  out14 +
                  symb_reg[14] * out15 + symb_reg[15] *  out16 +
                  symb_reg[16] * out17 + symb_reg[17] *  out18 +
                  symb_reg[18] * out19 + symb_reg[19] *  out20 +
                  symb_reg[20] * out21 + symb_reg[21] *  out22 +
                  symb_reg[22] * out23 + symb_reg[23] *  out24 +
                  symb_reg[24] * out25 + symb_reg[25] *  out26 +
                  symb_reg[26] * out27 + symb_reg[27] *  out28 +
                  symb_reg[28] * out29 + symb_reg[29] *  out30 +
                  symb_reg[30] * out31;
    end
    if (counter == 2) begin
      read_ready = 1;
      counter = 0;
    end else begin
      read_ready = 0;
      counter = counter;
    end
  end
endmodule
