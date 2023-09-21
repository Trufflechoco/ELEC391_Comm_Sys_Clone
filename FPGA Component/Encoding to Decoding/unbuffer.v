module unbuffer(in, out, clk, reset, enable);
  input [3:0] in;
  input reset, clk, enable;
  output reg [23:0] out;

  reg [23:0] store;
  reg [2:0] state;

  always @(posedge clk) begin
    if (reset) begin
      store <= 0;
      out <= 0;
      state <= 0;
    end else if (enable) begin
      state <= 6;
      store[23:20] <= in;
      out <= store;
    end else if (state) begin
      case (state)
        3'd6 : begin state <= state - 1; store[19:16] <= in; out <= out; end
        3'd5 : begin state <= state - 1; store[15:12] <= in; out <= out; end
        3'd4 : begin state <= state - 1; store[11:8] <= in; out <= out; end
        3'd3 : begin state <= state - 1; store[7:4] <= in; out <= out; end
        3'd2 : begin state <= state - 1; store[3:0] <= in; out <= out; end
        3'd1 : begin state <= state - 1; store <= store; out <= store; end
        default : begin state <= state; store <= store; out <= out; end
      endcase
    end
  end
endmodule
