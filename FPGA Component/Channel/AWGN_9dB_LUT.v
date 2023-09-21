
module AWGN_9dB_LUT (
  input wire clk,
  output reg [15:0] noise9
);
  
  reg [5:0] index;
  reg [15:0] lookup_table9 [0:50];

  initial begin
    lookup_table9[0]  = 16'h021e; // Entry 0 0.0662
    lookup_table9[1]  = 16'h1701; // Entry 1 0.7189
    lookup_table9[2]  = 16'h0768; // Entry 2 0.2314
    lookup_table9[3]  = 16'hf750; // Entry 3 -0.2715
    lookup_table9[4]  = 16'heaac; // Entry 4 -0.6665
    lookup_table9[5]  = 16'hfdb9; // Entry 5 -0.0712
    lookup_table9[6]  = 16'hf2ae; // Entry 6 -0.4162
    lookup_table9[7]  = 16'h19a4; // Entry 7 0.8013
    lookup_table9[8]  = 16'h0b5f; // Entry 8 0.3554
    lookup_table9[9]  = 16'hefec; // Entry 9 -0.5024
    lookup_table9[10] = 16'h0715; // Entry 10 0.2213
    lookup_table9[11] = 16'h0317; // Entry 11 0.0966
    lookup_table9[12] = 16'hfafb; // Entry 12 -0.1569
    lookup_table9[13] = 16'hf953; // Entry 13 -0.2086
    lookup_table9[14] = 16'hf415; // Entry 14 -0.3724
    lookup_table9[15] = 16'hf2b5; // Entry 15 -0.4154
    lookup_table9[16] = 16'hf4bb; // Entry 16 -0.3522
    lookup_table9[17] = 16'hf2a1; // Entry 17 -0.4178
    lookup_table9[18] = 16'hfde8; // Entry 18 -0.0654
    lookup_table9[19] = 16'hfb72; // Entry 19 -0.1423
    lookup_table9[20] = 16'hec00; // Entry 20 -0.6250
    lookup_table9[21] = 16'h0f72; // Entry 21 0.4827
    lookup_table9[22] = 16'hfbd6; // Entry 22 -0.1301
    lookup_table9[23] = 16'h0141; // Entry 23 0.0392
    lookup_table9[24] = 16'hfa1d; // Entry 24 -0.1840
    lookup_table9[25] = 16'hf8b9; // Entry 25 -0.2274
    lookup_table9[26] = 16'h01ca; // Entry 26 0.0559
    lookup_table9[27] = 16'h1574; // Entry 27 0.1676
    lookup_table9[28] = 16'h055d; // Entry 28 0.4119
    lookup_table9[29] = 16'h016d; // Entry 29 0.0446
    lookup_table9[30] = 16'hfb31; // Entry 30 -0.1503
    lookup_table9[31] = 16'hf560; // Entry 31 -0.3320
    lookup_table9[32] = 16'h118c; // Entry 32 0.5483
    lookup_table9[33] = 16'hfc8f; // Entry 33 -0.1076
    lookup_table9[34] = 16'h0143; // Entry 34 0.0394
    lookup_table9[35] = 16'h1b04; // Entry 35 0.8442
    lookup_table9[36] = 16'hfc0d; // Entry 36 -0.1234
    lookup_table9[37] = 16'h0a41; // Entry 37 0.3204
    lookup_table9[38] = 16'h08fb; // Entry 38 0.2806
    lookup_table9[39] = 16'hf866; // Entry 39 -0.2375
    lookup_table9[40] = 16'h198c; // Entry 40 0.7983
    lookup_table9[41] = 16'hfb82; // Entry 41 -0.1404
    lookup_table9[42] = 16'h064d; // Entry 42 0.1969
    lookup_table9[43] = 16'hf904; // Entry 43 -0.2183
    lookup_table9[44] = 16'hf412; // Entry 44 -0.3728
    lookup_table9[45] = 16'hf3c6; // Entry 45 -0.3821
    lookup_table9[46] = 16'hf43d; // Entry 46 -0.3676
    lookup_table9[47] = 16'h0cd7; // Entry 47 0.4013
    lookup_table9[48] = 16'heac2; // Entry 48 -0.6638
    lookup_table9[49] = 16'h1478; // Entry 49 0.6396
    lookup_table9[50] = 16'hfbf2; // Entry 50 -0.1267

    index = 6'b000000;
  end

  always @(posedge clk) begin
    index <= index + 1; // Increment index by 1 at each clock cycle

    if (index >= 50) // Check if index exceeds 50
      index <= 0; // Reset index to 0
  end

  always @(index) begin
    noise9 <= lookup_table9[index]; // Assign the corresponding lookup_table value to noise21
  end

endmodule

  end
endmodule
*/
