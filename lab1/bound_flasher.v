module bound_flasher(led, flick, clk);
	output [15:0] led;
	
	input flick, clk;
	wire enable, increaseWire;
	wire [4:0]position;
		
	processor p0(.enable(enable), .increase(increaseWire), .position(position), .flick(flick));
	shifter s0(.out(led), .position(position), .enable(enable), .increase(increaseWire), .clk(clk));
	
endmodule 