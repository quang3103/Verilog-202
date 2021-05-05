module DE2i_run(LEDR, LEDG, KEY, CLOCK_50, HEX7, HEX6, HEX5, HEX4);
	input [1:0]KEY;
	input CLOCK_50;
	output [15:0]LEDR;
	output [1:0]LEDG;
	output [6:0] HEX7, HEX6, HEX5, HEX4;
	
	
	wire clock1s;
	wire [5:0]max, min;
	wire [1:0]state;
	wire [3:0] max1, max0, min1, min0;
	
	assign LEDG[1:0] = state;
	
	dec5toBCD dec5_0(.data_in(max), .out1(max1), .out0(max0));
	dec5toBCD dec5_1(.data_in(min), .out1(min1), .out0(min0));
	
	BCD_to_HEX hex_0(.data_in(max1), .data_out(HEX7));
	BCD_to_HEX hex_1(.data_in(max0), .data_out(HEX6));
	BCD_to_HEX hex_2(.data_in(min1), .data_out(HEX5));
	BCD_to_HEX hex_3(.data_in(min0), .data_out(HEX4));
	
	clock_div clk1(.clock50(CLOCK_50), .clock(clock1s));
	bound_flasher bf1(.led(LEDR), .flick(~KEY[0]), .clk(clock1s), .max(max), .min(min), .isFlick(state));
	
endmodule 