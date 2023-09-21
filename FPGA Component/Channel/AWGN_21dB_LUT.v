
module AWGN_21dB_LUT (
  input wire clk,
  output reg [15:0] noise21
);
  
  reg [5:0] index;
  reg [15:0] lookup_table21 [0:50];

  initial begin
    lookup_table21[0]  = 16'h0088; // Entry 0 0.0166
    lookup_table21[1]  = 16'h05c7; // Entry 1 0.1806
    lookup_table21[2]  = 16'h01dc; // Entry 2 0.0581
    lookup_table21[3]  = 16'hfdd1; // Entry 3 -0.0682
    lookup_table21[4]  = 16'hfaa5; // Entry 4 -0.1674
    lookup_table21[5]  = 16'hff6d; // Entry 5 -0.0179 
    lookup_table21[6]  = 16'hfca8; // Entry 6 -0.1045
    lookup_table21[7]  = 16'h0671; // Entry 7 0.2013
    lookup_table21[8]  = 16'h02dc; // Entry 8 0.0893
    lookup_table21[9]  = 16'hfbf6; // Entry 9 -0.1262
    lookup_table21[10] = 16'h01c7; // Entry 10 0.0556
    lookup_table21[11] = 16'h00c7; // Entry 11 0.0243
    lookup_table21[12] = 16'hfebd; // Entry 12 -0.0394
    lookup_table21[13] = 16'hfe53; // Entry 13 -0.0524
    lookup_table21[14] = 16'hfd02; // Entry 14 -0.0935
    lookup_table21[15] = 16'hfcaa; // Entry 15 -0.1043
    lookup_table21[16] = 16'hfd2b; // Entry 16 -0.0885
    lookup_table21[17] = 16'hfca5; // Entry 17 -0.1049
    lookup_table21[18] = 16'hff7a; // Entry 18 -0.0164
    lookup_table21[19] = 16'hfedc; // Entry 19 -0.0357
    lookup_table21[20] = 16'hfafa; // Entry 20 -0.1570
    lookup_table21[21] = 16'h03e1; // Entry 21 0.1212
    lookup_table21[22] = 16'hfef4; // Entry 22 -0.0327
    lookup_table21[23] = 16'h0050; // Entry 23 0.0098
    lookup_table21[24] = 16'hfe86; // Entry 24 -0.0462
    lookup_table21[25] = 16'hfe2c; // Entry 25 -0.0571
    lookup_table21[26] = 16'h0073; // Entry 26 0.0140
    lookup_table21[27] = 16'h0159; // Entry 27 0.0421
    lookup_table21[28] = 16'h0350; // Entry 28 0.1035
    lookup_table21[29] = 16'h005c; // Entry 29 0.0112
    lookup_table21[30] = 16'hfeca; // Entry 30 -0.0378
    lookup_table21[31] = 16'hfd55; // Entry 31 -0.0834
    lookup_table21[32] = 16'h0468; // Entry 32 0.1377 
    lookup_table21[33] = 16'hff23; // Entry 33 -0.0270
    lookup_table21[34] = 16'h0051; // Entry 34 0.0099
    lookup_table21[35] = 16'h06ca; // Entry 35 0.2121
    lookup_table21[36] = 16'hff02; // Entry 36 -0.0310
    lookup_table21[37] = 16'h0293; // Entry 37 0.0805
    lookup_table21[38] = 16'h0242; // Entry 38 0.0705
    lookup_table21[39] = 16'hfe17; // Entry 39 -0.0597
    lookup_table21[40] = 16'h066a; // Entry 40 0.2005
    lookup_table21[41] = 16'hfedf; // Entry 41 -0.0353
    lookup_table21[42] = 16'h0196; // Entry 42 0.0495
    lookup_table21[43] = 16'hfe3f; // Entry 43 -0.0548
    lookup_table21[44] = 16'hfd01; // Entry 44 -0.0936
    lookup_table21[45] = 16'hfcee; // Entry 45 -0.0960
    lookup_table21[46] = 16'hfd0c; // Entry 46 -0.0923
    lookup_table21[47] = 16'h033a; // Entry 47 0.1008
    lookup_table21[48] = 16'hfaaa; // Entry 48 -0.1667
    lookup_table21[49] = 16'h0524; // Entry 49 0.1607
    lookup_table21[50] = 16'hfefb; // Entry 50 -0.0318

    index = 6'b000000;
  end

  always @(posedge clk) begin
    index <= index + 1; // Increment index by 1 at each clock cycle

    if (index >= 50) // Check if index exceeds 50
      index <= 0; // Reset index to 0
  end

  always @(index) begin
    noise21 <= lookup_table21[index]; // Assign the corresponding lookup_table value to noise21
  end

endmodule
