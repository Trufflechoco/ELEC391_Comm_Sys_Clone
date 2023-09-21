
`define Goodstate 2'b00
`define Badstate 2'b01

module StateMachine_10kHz (
  input wire clk,
  input wire reset,
  input wire [6:0] input_signal,
  output reg [7:0] output_signal
);

  reg clk_10k;
  reg [13:0] count;
  localparam  DIVIDE_BY = 2500;

  always @(posedge clk) begin
    if (reset) begin
        count <= 0; 
        clk_10k <= 0;
    end
    else if(count == DIVIDE_BY - 1) begin
	// If we've counted up to 2500, reset the counter and toggle the 10 kHz clock
	count <= 0;
	clk_10k <= ~clk_10k;
    end else begin
    	// Otherwise, just increment the counter
	count <= count + 14'b1;
    end
  end

  // Define the state register and initialize it to Goodstate
  reg [1:0] currentState;
  reg [1:0] nextState;
  initial currentState = `Goodstate;

  // Define the output values for each state
  always @ (*)
    case (currentState)
      `Goodstate: output_signal = 8'd21; // Output value for Goodstate is 21
      `Badstate: output_signal = 8'd9; // Output value for goodstate is 9
      default: output_signal = 8'd9;
    endcase

  // Define the next state logic
  always @ (*)
    case (currentState)
      `Goodstate:
        // Transition based on inputSignal
        if (input_signal >= 7'd97) begin
          nextState = `Badstate;
        end 
        else begin
          nextState = `Goodstate;
        end

      `Badstate:
        // Transition based on inputSignal
        if (input_signal >= 7'd75) begin
          nextState = `Goodstate;
        end
        else begin
          nextState = `Badstate;
        end

      default: 
        nextState = `Goodstate;
    endcase

  always @ (posedge clk_10k or posedge reset)
    if (reset)
      currentState <= `Goodstate; // Reset the state to Goodstate
    else begin
      currentState <= nextState; 
    end

endmodule
