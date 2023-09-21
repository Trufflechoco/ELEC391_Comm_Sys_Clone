module buffer(in, out, clk, reset, enable, trig);
  input [23:0] in;
  input enable;
  input clk, reset;
  output reg [3:0] out;
  output reg trig;

  reg [23:0] store;
  reg [2:0] state; 

  always @(posedge clk) begin
    if (reset) begin
      store <= 0;
      out <= 0;
      state <= 0;
      trig <= 0;
    end else if (enable) begin
      store <= in;
      out <= in[23:20];
      state <= 6;
      trig <= 1;
    end else if (state) begin
      case (state) 
        3'd6 : begin state <= state - 1; out <= in[19:16]; trig <= 0; end
        3'd5 : begin state <= state - 1; out <= in[15:12]; trig <= 0; end
        3'd4 : begin state <= state - 1; out <= in[11:8]; trig <= 0; end
        3'd3 : begin state <= state - 1; out <= in[7:4]; trig <= 0; end
        3'd2 : begin state <= state - 1; out <= in[3:0]; trig <= 0; end
        3'd1 : begin state <= state - 1; out <= 0; trig <= 0; end
        default : begin state <= state; out <= out; trig <= 0; end
      endcase
    end
  end
endmodule
