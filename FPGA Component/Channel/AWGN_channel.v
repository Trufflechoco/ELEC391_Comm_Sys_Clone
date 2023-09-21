module AWGN_channel (
  input wire clk,
  input wire reset,
  input wire [15:0] signal_in,
  output reg [15:0] signal_out
);

  wire [15:0] noise;

  // Instantiate AWGN_state module
  AWGN_state awgn_state (
    .clk(clk),
    .reset(reset),
    .noise(noise)
  );

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      signal_out <= 16'd0;
    end else begin
      signal_out <= signal_in + noise;
    end
  end

endmodule
