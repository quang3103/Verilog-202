module bound_flasher(led, flick, clk, max, min, isFlick);
	output [15:0] led;
	output [4:0] max, min;
	output [1:0] isFlick;
	
	input flick, clk;
	wire enable, increaseWire;
	wire [4:0]position;

	
	processor p0(.enable(enable), .increase(increaseWire), .position(position), .flick(flick), .out_max(max), .out_min(min), .out_state(isFlick));
	shifter s0(.out(led), .position(position), .enable(enable), .increase(increaseWire), .clk(clk));
	
endmodule 