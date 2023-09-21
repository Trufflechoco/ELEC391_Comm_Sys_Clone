module hamming_tb();

  reg [0:3] data_in;

  wire [0:6] data_to_decoder;
  wire [0:3] data_out;
  wire parity, error_1bit, error_2bit;

  hamming_encoder hamming_encoder(.in(data_in),.out(data_to_decoder),.parity(parity));
  hamming_decoder hamming_decoder(.in(data_to_decoder),.out(data_out),.error_1bit(error_1bit),.error_2bit(error_2bit),.in_parity(parity));

  initial begin
    data_in = 0; #2;
    if (data_out == 0);
    else $display("error, data_out != 0"); #3;
    data_in = 1; #2;
    if (data_out == 1);
    else $display("error, data_out != 1"); #3;
    data_in = 2; #2;
    if (data_out == 2);
    else $display("error, data_out != 2"); #3;
    data_in = 3; #2;
    if (data_out == 3);
    else $display("error, data_out != 3"); #3;
    
    $stop;
  end
endmodule
