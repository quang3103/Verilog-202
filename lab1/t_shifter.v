module t_shifter();

	wire [15:0]out;
	wire [4:0]position;
	reg en, clk, inc;
	
	shifter test_shifter (.out(out), .position(position), .enable(en), .clk(clk), .increase(inc));
	
	initial $monitor("Time: %t: en = %b | inc = %b | position = %d | led = %b\n", $time, en, inc, position, out);
	
	initial begin
		clk = 1;
		forever #5 clk = ~clk;
	end
	
	initial begin
		#25 en = 1'b1;
		inc = 1'b1;
		#160 inc = 1'b0;
		#150 $stop; // at 50 ns – stops simulation
	end

	
endmodule 
	
	