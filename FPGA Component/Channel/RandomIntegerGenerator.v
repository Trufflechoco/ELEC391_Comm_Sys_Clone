
module RandomIntegerGenerator (
  input wire clk,
  input wire reset,
  output reg [6:0] random_integer
);

  reg [6:0] lfsr;
  reg [6:0] feedback;

  always @(posedge clk) begin
    if (reset) begin
      lfsr <= 7'b1000011; // Set initial seed to 67
      feedback <= 7'b1000010;
      random_integer <= 0;
    end else begin
      feedback[6:1] <= lfsr[5:0];
      feedback[0] <= lfsr[6];
      lfsr <= {lfsr[5:0], feedback[6] ^ feedback[2]};
      random_integer <= (lfsr % 100) + 1; // Perform modulo operation and add 1
    end
  end

endmodule
