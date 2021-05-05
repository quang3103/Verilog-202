module shifter(out, position, enable, increase, clk);
	input enable, increase, clk;
	output reg [15:0]out;
	output reg [4:0]position;
	
	initial 
	begin
			position = 5'd0;
	end
	
	always @(posedge clk) 
	begin
		if (enable == 1'b1)
		begin
			if (increase == 1'b1)
			begin
				position <= position + 1;
				out <= {out[14:0], 1'b1};
			end
			else
			begin
				position <= position - 1;
				out <= {1'b0, out[15:1]};
			end
		end
		else 
		begin
			out <= 16'd0;
			position <= 4'd0;
		end
	end
endmodule 
