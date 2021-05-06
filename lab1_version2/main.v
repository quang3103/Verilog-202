module main(LEDR, LEDG, KEY, CLOCK_50, HEX7, HEX6, HEX5, HEX4, HEX3, HEX2);
	input [1:0]KEY;
	input CLOCK_50;
	output [15:0]LEDR;
	output [8:0]LEDG;
	output [6:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2;
	
	wire clock;
	
	wire [4:0] max, min, position;
	
	wire [3:0] max1, max0, min1, min0, pos1, pos0;
	
	dec5toBCD dec_0(.data_in(max), .out1(max1), .out0(max0));
	dec5toBCD dec_1(.data_in(min), .out1(min1), .out0(min0));
	dec5toBCD dec_2(.data_in(position), .out1(pos1), .out0(pos0));
	
	BCD_to_HEX hex_0(.data_in(max1), .data_out(HEX7));
	BCD_to_HEX hex_1(.data_in(max0), .data_out(HEX6));
	BCD_to_HEX hex_2(.data_in(min1), .data_out(HEX5));
	BCD_to_HEX hex_3(.data_in(min0), .data_out(HEX4));
	BCD_to_HEX hex_4(.data_in(pos1), .data_out(HEX3));
	BCD_to_HEX hex_5(.data_in(pos0), .data_out(HEX2));
	
	
	clock_div clock_0(.clock50(CLOCK_50), .clock(clock));
	
	bound_flasher bound_flasher_0(.lamp(LEDR[15:0]), .clk(clock), .flick(~KEY[0]), .max(max), .min(min), .position(position), .state(LEDG[1:0]), .enable(LEDG[7]), .increase(LEDG[8]));
	
endmodule 