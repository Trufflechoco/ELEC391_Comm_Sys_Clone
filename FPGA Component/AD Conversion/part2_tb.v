`timescale 1ns / 1ps
module part2_tb;
    // parameters
    parameter CLK_PERIOD = 20; // Corresponds to a 50 MHz clock

    // reg declarations
    reg CLOCK_50;
    reg CLOCK2_50;
    reg KEY;
    reg SWITCH;
    reg FPGA_I2C_SCLK;
    reg FPGA_I2C_SDAT;
    reg AUD_XCK;
    reg AUD_ADCDAT;

    // wire declarations
    wire read_ready;
    wire write_ready;
    wire read;
    wire write;
    wire [23:0] readdata_left;
    wire [23:0] readdata_right;
    wire [23:0] writedata_left;
    wire [23:0] writedata_right;
    wire AUD_DACLRCK;
    wire AUD_ADCLRCK;
    wire AUD_BCLK;
    wire AUD_DACDAT;

    // instantiate DUT
    part2 DUT (
        .CLOCK_50(CLOCK_50),
        .CLOCK2_50(CLOCK2_50),
        .KEY(KEY),
        .SWITCH(SWITCH),
        .FPGA_I2C_SCLK(FPGA_I2C_SCLK),
        .FPGA_I2C_SDAT(FPGA_I2C_SDAT),
        .AUD_XCK(AUD_XCK),
        .AUD_DACLRCK(AUD_DACLRCK),
        .AUD_ADCLRCK(AUD_ADCLRCK),
        .AUD_BCLK(AUD_BCLK),
        .AUD_ADCDAT(AUD_ADCDAT),
        .AUD_DACDAT(AUD_DACDAT),
        .read_ready(read_ready),
        .write_ready(write_ready),
        .read(read),
        .write(write),
        .readdata_left(readdata_left),
        .readdata_right(readdata_right),
        .writedata_left(writedata_left),
        .writedata_right(writedata_right)
    );

    // Clock generation
    always #CLK_PERIOD CLOCK_50 = ~CLOCK_50;

    initial begin
        // Initial settings
        CLOCK_50 = 0;
        KEY = 1;  // not pressed
        SWITCH = 0;

        #200; // delay
        KEY = 0; // press key

        #200; // delay
        KEY = 1; // release key

        // Add more test vectors here...

        #100 $finish; // End of test
    end

    initial begin
        $monitor("At time %d, addr = %b, read_ready = %b, write_ready = %b", $time, DUT.addr, read_ready, write_ready);
    end

endmodule

