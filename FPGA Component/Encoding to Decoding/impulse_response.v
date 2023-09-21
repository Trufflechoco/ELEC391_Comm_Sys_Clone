module impulse_response(out1, out2, out3, out4, out5, out6, out7, out8,
  out9, out10, out11, out12, out13, out14, out15, out16, out17, out18,
  out19, out20, out21, out22, out23, out24 ,out25, out26, out27, out28,
  out29, out30, out31);
  output [15:0] out1, out2, out3, out4, out5, out6, out7, out8,
  out9, out10, out11, out12, out13, out14, out15, out16, out17, out18,
  out19, out20, out21, out22, out23, out24 ,out25, out26, out27, out28,
  out29, out30, out31;

  //                                 sign integer decimal
  //fixed point 16-bit represetation 0____00______0000000000000
  assign out1 = 16'b1111111101110101; ////
  assign out2 = 16'b1111111111101110;
  assign out3 = 16'b0000000011010000;
  assign out4 = 16'b0000000011100000; ////
  assign out5 = 16'b1111111110011000;
  assign out6 = 16'b1111111000111100;
  assign out7 = 16'b1111111011001011; ////
  assign out8 = 16'b0000000101101011;
  assign out9 = 16'b0000001101011110;
  assign out10 = 16'b0000000101111110; ////
  assign out11 = 16'b1111110001010100;
  assign out12 = 16'b1111100101000000;
  assign out13 = 16'b1111111001010001; ////
  assign out14 = 16'b0000110000000110;
  assign out15 = 16'b0001101100101010;
  assign out16 = 16'b0010000111000001; ////////
  assign out17 = 16'b0001101100101010;
  assign out18 = 16'b0000110000000110;
  assign out19 = 16'b1111111001010001; ////
  assign out20 = 16'b1111100101000000;
  assign out21 = 16'b1111110001010100;
  assign out22 = 16'b0000000101111110;  ////
  assign out23 = 16'b0000001101011110;
  assign out24 = 16'b0000000101101011;
  assign out25 = 16'b1111111011001011; ////
  assign out26 = 16'b1111111000111100;
  assign out27 = 16'b1111111110011000;
  assign out28 = 16'b0000000011100000; ////
  assign out29 = 16'b0000000011010000;
  assign out30 = 16'b1111111111101110;
  assign out31 = 16'b1111111101110101; ////
  
endmodule
