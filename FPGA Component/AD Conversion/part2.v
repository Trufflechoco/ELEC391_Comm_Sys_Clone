module part2 (CLOCK_50, CLOCK2_50, KEY, SW,FPGA_I2C_SCLK, FPGA_I2C_SDAT, AUD_XCK, 
		        AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK, AUD_ADCDAT, AUD_DACDAT);

	input CLOCK_50, CLOCK2_50;
	input [0:0] KEY;
	input [9:0] SW; // Going to use this to change between the mic and audio file input
	// I2C Audio/Video config interface
	output FPGA_I2C_SCLK;
	inout FPGA_I2C_SDAT;
	// Audio CODEC
	output AUD_XCK;
	input AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK;
	input AUD_ADCDAT;
	output AUD_DACDAT;
	
	// Local wires.
	wire read_ready, write_ready, read, write;
	wire [23:0] readdata_left, readdata_right;
	wire [23:0] writedata_left, writedata_right;
	wire [23:0] data_left, data_right;
	wire reset = ~KEY[0];
	wire enable = 1'b1;

	// Instantiating the ROM where the audio file is stored
	reg [15:0] addr; // This will be the input for our ROM
	wire [15:0] file_data;// Will carry the ROM output
	reg clk_40k;
	reg [13:0] count;
	localparam  DIVIDE_BY = 1250;
	localparam  ROM_SIZE = 52612;



	always @(posedge CLOCK_50) begin
		if(count == DIVIDE_BY - 1) begin
			// If we've counted up to 5000, reset the counter and toggle the 10 kHz clock
			count <= 0;
			clk_40k <= ~clk_40k;
		end else begin
			// Otherwise, just increment the counter
			count <= count + 14'b1;
		end
	end

	audio_rom rom1(
		.address(addr),
		.clock(CLOCK_50),
		.q(file_data)
	);

	always @(posedge clk_40k) begin
        if (reset) begin
            addr <= 0; // Initialize the addr to 0 when the reset signal is high
        end else begin
			addr <= addr + 16'b1;
		end
	end

	// Initiating the InputSelect module
	InputSelect Input_MUX (.clk(CLOCK_50),.reset(reset),.input_select(SW[1]),
							.readdata_left(readdata_left),.readdata_right(readdata_right),.data_left(data_left),
							.data_right(data_right),.file_data(file_data)
	);

	assign writedata_left = data_left;
	assign writedata_right = data_right;
	assign read = read_ready;
	assign write = write_ready;


/////////////////////////////////////////////////////////////////////////////////
// Audio CODEC interface. 
//
// The interface consists of the following wires:
// read_ready, write_ready - CODEC ready for read/write operation 
// readdata_left, readdata_right - left and right channel data from the CODEC
// read - send data from the CODEC (both channels)
// writedata_left, writedata_right - left and right channel data to the CODEC
// write - send data to the CODEC (both channels)
// AUD_* - should connect to top-level entity I/O of the same name.
//         These signals go directly to the Audio CODEC
// I2C_* - should connect to top-level entity I/O of the same name.
//         These signals go directly to the Audio/Video Config module
/////////////////////////////////////////////////////////////////////////////////
	clock_generator my_clock_gen(
		// inputs
		CLOCK2_50,
		reset,

		// outputs
		AUD_XCK
	);

	audio_and_video_config cfg(
		// Inputs
		CLOCK_50,
		reset,

		// Bidirectionals
		FPGA_I2C_SDAT,
		FPGA_I2C_SCLK
	);

	audio_codec codec(
		// Inputs
		CLOCK_50,
		reset,

		read,	write,
		writedata_left, writedata_right,

		AUD_ADCDAT,

		// Bidirectionals
		AUD_BCLK,
		AUD_ADCLRCK,
		AUD_DACLRCK,

		// Outputs
		read_ready, write_ready,
		readdata_left, readdata_right,
		AUD_DACDAT
	);

endmodule

// This is the MUX which bounces between mic input and audio file input depending on the value of the switch 
module InputSelect(clk, reset, input_select, readdata_left, readdata_right, data_left, data_right, file_data);
	input wire clk, input_select, reset;
	input wire [15:0] file_data;
	input wire [23:0] readdata_left, readdata_right;
	output reg [23:0] data_left, data_right;

	// assign data_left = (input_select) ? readdata_left : file_data;
	// assign data_right = (input_select) ? readdata_right : file_data;

	always@ (clk) begin
		if (reset) begin
			data_left <= 24'b0;
			data_right <= 24'b0;
		end
		else begin
			if (input_select) begin
				// Using the audio file data here
				data_left <= file_data;
				data_right <= file_data;
			end
			else begin
				// Using the microphone data
				data_left <= readdata_left;
				data_right <= readdata_right;
			end
		end
	end
endmodule

