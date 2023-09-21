
`define Goodstate 2'b00
`define Badstate 2'b01

module StateMachine (
  input wire clk,
  input wire reset,
  input wire [6:0] input_signal,
  output reg [7:0] output_signal
);

  // Define the state register and initialize it to Goodstate
  reg [1:0] currentState;
  reg [1:0] nextState;
  initial currentState = `Goodstate;

  // Define the output values for each state
  always @ (*)
    case (currentState)
      `Goodstate: output_signal = 8'd21; // Output value for Goodstate is 21
      `Badstate: output_signal = 8'd9; // Output value for Badstate is 9
      default: output_signal = 8'd9;
    endcase

  // Define the next state logic
  always @ (*)
    case (currentState)
      `Goodstate:
        // Transition based on inputSignal
        if (input_signal >= 8'd97) begin
          nextState = `Badstate;
        end 
        else begin
          nextState = `Goodstate;
        end

      `Badstate:
        // Transition based on inputSignal
        if (input_signal >= 8'd75) begin
          nextState = `Goodstate;
        end
        else begin
          nextState = `Badstate;
        end

      default: 
        nextState = `Goodstate;
    endcase

  always @ (posedge clk or posedge reset)
    if (reset)
      currentState <= `Goodstate; // Reset the state to Goodstate
    else begin
      currentState <= nextState; 
    end

endmodule
