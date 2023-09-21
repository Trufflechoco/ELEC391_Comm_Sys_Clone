module part1 (CLOCK_50, CLOCK2_50, KEY, FPGA_I2C_SCLK, FPGA_I2C_SDAT, AUD_XCK, 
		        AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK, AUD_ADCDAT, AUD_DACDAT);

	input CLOCK_50, CLOCK2_50;
	input [0:0] KEY;
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
        wire [3:0] buffer_left, buffer_right, decoder_out_left, decoder_out_right;
	wire [6:0] encoder_out_left, encoder_out_right, demodulator_out_left, demodulator_out_right;
	wire parity_left, parity_right, error_1bit_left, error_1bit_right, error_2bit_left, error_2bit_right;
	wire [15:0] f1, f2, f3, f4, f5, f6, f7, f8, f9, f10,
		    f11, f12, f13, f14, f15, f16;
	wire [15:0] g1, g2, g3, g4, g5, g6, g7, g8, g9, g10,
		    g11, g12, g13, g14, g15, g16;
	wire [15:0] h1, h2, h3, h4, h5, h6, h7, h8, h9, h10,
		    h11, h12, h13, h14, h15, h16;
	wire [15:0] i1, i2, i3, i4, i5, i6, i7, i8, i9, i10,
		    i11, i12, i13, i14, i15, i16;
	wire reset = ~KEY[0];
  
        reg [7:0] count_1, count_2;
        reg clk_288k;
        reg clk_864k, clk_864k_1;
	reg reg1, reg2;

	always @(posedge CLOCK_50) begin
                if (read) begin
              		count_1 <= 0;
			clk_288k <= 0;
                end
		if (count_1 == 94) begin
			// If we've counted up to 94, reset the counter and toggle the 288 kHz clock
			count_1 <= 0;
			clk_288k <= ~clk_288k;
		end else begin
			// Otherwise, just increment the counter
			count_1 <= count_1 + 8'b1;
			clk_288k <= clk_288k;
		end
	end

	always @(posedge CLOCK_50) begin
                if (clk_288k) begin
              		count_2 <= 0;
			clk_864k <= 0;
                end
		if (count_2 == 31) begin
			// If we've counted up to 31, reset the counter and toggle the 864 kHz clock
			count_2 <= 0;
			clk_864k <= ~clk_864k;
		end else begin
			// Otherwise, just increment the counter
			count_2 <= count_2 + 8'b1;
			clk_864k <= clk_864k;
		end
	end

        buffer bufferL(.in(readdata_left),.out(buffer_left),.clk(clk_288k),.reset(reset),.enable(read));
        buffer bufferR(.in(readdata_right),.out(buffer_right),.clk(clk_288k),.reset(reset),.enable(read));

	hamming_encoder eL(.in(buffer_left),.out(encoder_out_left),.parity(parity_left));
	hamming_encoder eR(.in(buffer_right),.out(encoder_out_right),.parity(parity_right));

	QPSK_Modulator QPSKML(.in(encoder_out_left),.symb_real_1(f1),.symb_imag_1(f2),
  			.symb_real_2(f3),.symb_imag_2(f4),.symb_real_3(f5),.symb_imag_3(f6),
  			.symb_real_4(f7),.symb_imag_4(f8));
	QPSK_Modulator QPSKMR(.in(encoder_out_right),.symb_real_1(f9),.symb_imag_1(f10),
  			.symb_real_2(f11),.symb_imag_2(f12),.symb_real_3(f13),.symb_imag_3(f14),
  			.symb_real_4(f15),.symb_imag_4(f16));

	transmitter t1(.symb_in(f1),.symb_out(g1),.clk(clk_864k),.reset(reset),.read_ready(clk_288k));
	transmitter t2(.symb_in(f2),.symb_out(g2),.clk(clk_864k),.reset(reset),.read_ready(clk_288k));
	transmitter t3(.symb_in(f3),.symb_out(g3),.clk(clk_864k),.reset(reset),.read_ready(clk_288k));
	transmitter t4(.symb_in(f4),.symb_out(g4),.clk(clk_864k),.reset(reset),.read_ready(clk_288k));
	transmitter t5(.symb_in(f5),.symb_out(g5),.clk(clk_864k),.reset(reset),.read_ready(clk_288k));
	transmitter t6(.symb_in(f6),.symb_out(g6),.clk(clk_864k),.reset(reset),.read_ready(clk_288k));
	transmitter t7(.symb_in(f7),.symb_out(g7),.clk(clk_864k),.reset(reset),.read_ready(clk_288k));
	transmitter t8(.symb_in(f8),.symb_out(g8),.clk(clk_864k),.reset(reset),.read_ready(clk_288k));
	transmitter t9(.symb_in(f9),.symb_out(g9),.clk(clk_864k),.reset(reset),.read_ready(clk_288k));
	transmitter t10(.symb_in(f10),.symb_out(g10),.clk(clk_864k),.reset(reset),.read_ready(clk_288k));
	transmitter t11(.symb_in(f11),.symb_out(g11),.clk(clk_864k),.reset(reset),.read_ready(clk_288k));
	transmitter t12(.symb_in(f12),.symb_out(g12),.clk(clk_864k),.reset(reset),.read_ready(clk_288k));
	transmitter t13(.symb_in(f13),.symb_out(g13),.clk(clk_864k),.reset(reset),.read_ready(clk_288k));
	transmitter t14(.symb_in(f14),.symb_out(g14),.clk(clk_864k),.reset(reset),.read_ready(clk_288k));
	transmitter t15(.symb_in(f15),.symb_out(g15),.clk(clk_864k),.reset(reset),.read_ready(clk_288k));
	transmitter t16(.symb_in(f16),.symb_out(g16),.clk(clk_864k),.reset(reset),.read_ready(clk_288k));

	reciever r1(.symb_in(g1),.symb_out(h1),.clk(clk_864k),.reset(reset));
	reciever r2(.symb_in(g2),.symb_out(h2),.clk(clk_864k),.reset(reset));
	reciever r3(.symb_in(g3),.symb_out(h3),.clk(clk_864k),.reset(reset));
	reciever r4(.symb_in(g4),.symb_out(h4),.clk(clk_864k),.reset(reset));
	reciever r5(.symb_in(g5),.symb_out(h5),.clk(clk_864k),.reset(reset));
	reciever r6(.symb_in(g6),.symb_out(h6),.clk(clk_864k),.reset(reset));
	reciever r7(.symb_in(g7),.symb_out(h7),.clk(clk_864k),.reset(reset));
	reciever r8(.symb_in(g8),.symb_out(h8),.clk(clk_864k),.reset(reset));
	reciever r9(.symb_in(g9),.symb_out(h9),.clk(clk_864k),.reset(reset));
	reciever r10(.symb_in(g10),.symb_out(h10),.clk(clk_864k),.reset(reset));
	reciever r11(.symb_in(g11),.symb_out(h11),.clk(clk_864k),.reset(reset));
	reciever r12(.symb_in(g12),.symb_out(h12),.clk(clk_864k),.reset(reset));
	reciever r13(.symb_in(g13),.symb_out(h13),.clk(clk_864k),.reset(reset));
	reciever r14(.symb_in(g14),.symb_out(h14),.clk(clk_864k),.reset(reset));
	reciever r15(.symb_in(g15),.symb_out(h15),.clk(clk_864k),.reset(reset));
	reciever r16(.symb_in(g16),.symb_out(h16),.clk(clk_864k),.reset(reset));

	downsampler d1(.in(h1),.out(i1),.clk(clk_864k),.reset(reset));
	downsampler d2(.in(h2),.out(i2),.clk(clk_864k),.reset(reset));
	downsampler d3(.in(h3),.out(i3),.clk(clk_864k),.reset(reset));
	downsampler d4(.in(h4),.out(i4),.clk(clk_864k),.reset(reset));
	downsampler d5(.in(h5),.out(i5),.clk(clk_864k),.reset(reset));
	downsampler d6(.in(h6),.out(i6),.clk(clk_864k),.reset(reset));
	downsampler d7(.in(h7),.out(i7),.clk(clk_864k),.reset(reset));
	downsampler d8(.in(h8),.out(i8),.clk(clk_864k),.reset(reset));
	downsampler d9(.in(h9),.out(i9),.clk(clk_864k),.reset(reset));
	downsampler d10(.in(h10),.out(i10),.clk(clk_864k),.reset(reset));
	downsampler d11(.in(h11),.out(i11),.clk(clk_864k),.reset(reset));
	downsampler d12(.in(h12),.out(i12),.clk(clk_864k),.reset(reset));
	downsampler d13(.in(h13),.out(i13),.clk(clk_864k),.reset(reset));
	downsampler d14(.in(h14),.out(i14),.clk(clk_864k),.reset(reset));
	downsampler d15(.in(h15),.out(i15),.clk(clk_864k),.reset(reset));
	downsampler d16(.in(h16),.out(i16),.clk(clk_864k),.reset(reset));

	QPSK_Demodulator QPSKDL(.out(demodulator_out_left),.symb_real_1(i1),.symb_imag_1(i2),
  			.symb_real_2(i3),.symb_imag_2(i4),.symb_real_3(i5),.symb_imag_3(i6),
  			.symb_real_4(i7),.symb_imag_4(i8));
	QPSK_Demodulator QPSKDR(.out(demodulator_out_right),.symb_real_1(i9),.symb_imag_1(i10),
  			.symb_real_2(i11),.symb_imag_2(i12),.symb_real_3(i13),.symb_imag_3(i14),
  			.symb_real_4(i15),.symb_imag_4(i16));

	hamming_decoder dL(.in(demodulator_out_left),.out(decoder_out_left),.error_1bit(error_1bit_left),
			.error_2bit(error_2bit_left),.in_parity(parity_left));
	hamming_decoder dR(.in(demodulator_out_right),.out(decoder_out_right),.error_1bit(error_1bit_right),
			.error_2bit(error_2bit_right),.in_parity(parity_right));

        unbuffer unbufferL(.in(decoder_out_left),.out(writedata_left),.clk(clk_288k),.reset(reset), .enable(read));
        unbuffer unbufferR(.in(decoder_out_right),.out(writedata_right),.clk(clk_288k),.reset(reset), .enable(read));

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


