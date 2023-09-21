module inverse_impulse_response(out1, out2, out3, out4, out5, out6, out7, out8,
  out9, out10, out11, out12, out13, out14, out15, out16, out17, out18,
  out19, out20, out21, out22, out23, out24 ,out25, out26, out27, out28,
  out29, out30, out31);
  output [15:0] out1, out2, out3, out4, out5, out6, out7, out8,
  out9, out10, out11, out12, out13, out14, out15, out16, out17, out18,
  out19, out20, out21, out22, out23, out24 ,out25, out26, out27, out28,
  out29, out30, out31;

  //                                 sign integer decimal
  //fixed point 16-bit represetation 0____00______0000000000000
  assign out1 = 16'b1111111111010010; ////
  assign out2 = 16'b1111111111111010;
  assign out3 = 16'b0000000001000101;
  assign out4 = 16'b0000000001001011; ////
  assign out5 = 16'b1111111111011101;
  assign out6 = 16'b1111111101101001;
  assign out7 = 16'b1111111110011001; ////
  assign out8 = 16'b0000000001111001;
  assign out9 = 16'b0000000100011111;
  assign out10 = 16'b0000000001111111; ////
  assign out11 = 16'b1111111011000111;
  assign out12 = 16'b1111110111000000;
  assign out13 = 16'b1111111101110000; ////
  assign out14 = 16'b0000010000000010;
  assign out15 = 16'b0000100100001110;
  assign out16 = 16'b0000101101000000; ////////
  assign out17 = 16'b0000100100001110;
  assign out18 = 16'b0000010000000010;
  assign out19 = 16'b1111111101110000; ////
  assign out20 = 16'b1111110111000000;
  assign out21 = 16'b1111111011000111;
  assign out22 = 16'b0000000001111111;  ////
  assign out23 = 16'b0000000100011111;
  assign out24 = 16'b0000000101101011;
  assign out25 = 16'b1111111110011001; ////
  assign out26 = 16'b1111111101101001;
  assign out27 = 16'b1111111111011101;
  assign out28 = 16'b0000000001001011; ////
  assign out29 = 16'b0000000001000101;
  assign out30 = 16'b1111111111111010;
  assign out31 = 16'b1111111111010010; ////
  
endmodule
