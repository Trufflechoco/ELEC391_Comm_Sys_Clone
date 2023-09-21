module unbuffer(in, out, clk, reset, enable);
  input [3:0] in;
  input reset, clk, enable;
  output reg [23:0] out;
  integer i;

  reg [2:0] ptr;
  reg [2:0] next_ptr;
  reg [3:0] store [5:0];

  always @(posedge clk) begin
    if (reset) begin
      out <= 0;
      ptr <= 5;
      for (i = 0; i < 5; i = i + 1) begin
        store[i] <= '0;
      end
    end else if (enable) begin
      out[23:20] <= store[5];
      out[19:16] <= store[4];
      out[15:12] <= store[3];
      out[11:8] <= store[2];
      out[7:4] <= store[1];
      out[3:0] <= store[0];
      ptr <= 5;
    end else begin
      store[ptr] <= in;
      ptr <= next_ptr;
    end
  end

  always @(*) begin
    case (ptr)
      3'd5 : begin next_ptr = 3'd4; end
      3'd4 : begin next_ptr = 3'd3; end
      3'd3 : begin next_ptr = 3'd2; end
      3'd2 : begin next_ptr = 3'd1; end
      3'd1 : begin next_ptr = 3'd0; end
      3'd0 : begin next_ptr = 3'd0; end
      default : begin next_ptr = next_ptr; end
    endcase
  end

endmodule
