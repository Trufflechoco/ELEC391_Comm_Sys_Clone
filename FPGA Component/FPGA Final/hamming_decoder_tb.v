module hamming_decoder_tb;

  //test cases
  reg [6:0] data_in;
  reg parity;
  wire [3:0] data_out;
  wire error_1bit, error_2bit;

  hamming_decoder hamming_decoder(.in(data_in[6:0]),.out(data_out),.error_1bit(error_1bit),.error_2bit(error_2bit),.in_parity(parity));

  initial begin
    //everything below has a one bit error
    data_in = 7'b0100111; parity = 1'b1;  #2;
    if (data_out == 4'b0001);
    else $display("error, data_out != 1"); #3;
    data_in = 7'b0101011; parity = 1'b0; #2;
    if (data_out == 4'b0100);
    else $display("error, data_out != 4"); #3;
    data_in = 7'b0111000; parity = 1'b1; #2;
    if (data_out == 4'b1110);
    else $display("error, data_out != 14"); #3;

    $stop;
  end

endmodule
