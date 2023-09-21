module AWGN_state (
  input wire clk,
  input wire reset,
  output wire [15:0] noise
);

  // Instantiate RandomIntegerGenerator module
  wire [6:0] random_integer;
  RandomIntegerGenerator rng (
    .clk(clk),
    .reset(reset),
    .random_integer(random_integer)
  );

  // Instantiate StateMachine module
  wire [7:0] output_signal;
  StateMachine sm (
    .clk(clk),
    .reset(reset),
    .input_signal(random_integer),
    .output_signal(output_signal)
  );

  // Instantiate AWGN_21dB_LUT module
  wire [15:0] noise21;
  AWGN_21dB_LUT awgn21 (
    .clk(clk),
    .noise21(noise21)
  );

  // Instantiate AWGN_9dB_LUT module
  wire [15:0] noise9;
  AWGN_9dB_LUT awgn9 (
    .clk(clk),
    .noise9(noise9)
  );

  assign noise = (output_signal == 8'd21) ? noise21 : noise9;

endmodule
