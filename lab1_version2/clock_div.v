module clock_div(clock50, clock);
	
	input clock50;
	output reg clock;
	
	reg [30:0] counter;
	initial 
	begin 
		counter = 30'b0; 
		clock = 1'b0;
	end
	
	always @(posedge clock50)
   begin
		if (counter == 24999999) 
		begin
			clock <= ~clock;
			counter <= 30'b0;
		end
		else 
		begin
			clock <= clock;
			counter <= counter + 1;
		end
   end
	
endmodule 