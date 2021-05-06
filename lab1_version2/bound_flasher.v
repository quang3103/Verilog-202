module bound_flasher(lamp, clk, flick, max, min, position, state, enable, increase);
	input clk, flick;
	output reg [15:0]lamp;
	reg [1:0] pre_state, next_state;
	reg isEnd, next_direction, isFlick;
	
	output reg enable, increase;
	output reg [1:0] state;
	output reg [4:0] max, min;
	output reg [4:0] position;
	reg [15:0] max16bit, min16bit;
	
	parameter max0 = 16'b0000_0000_0011_1111, 
				min0 = 16'b0000_0000_0000_0000,
				max1 = 16'b0000_0111_1111_1111,
				min1 = 16'b0000_0000_0001_1111,
				max2 = 16'b1111_1111_1111_1111,
				min2 = 16'b0000_0000_0000_0000;
				
	initial begin
		increase = 1'b0;
		enable = 1'b0;
		//isEnd = 1'b0;
	end

	
	//--------------------------------------
	
	always @(posedge flick)
	begin
		if (flick == 1'b1)
		begin
			enable <= 1'b1;
		end
		else
		begin
			enable <= 1'b0;
		end
	end
	
	//--------------------------------------
	
	always @(posedge clk)
	begin
		if (enable == 1'b1)
		begin
			if (increase == 1'b0)
			begin
				lamp <= {lamp[14:0], 1'b1};
				position <= position + 5'b0_0001;
			end
			else
			begin 
				lamp <= {1'b0, lamp[15:1]};
				position <= position - 5'b0_0001;
			end
		end
		else
		begin
			lamp <= min0;
			position <= 5'd0;
		end
	end 
	
	//---------------------------------------
	
	always @(next_state)
	begin
		//pre_state = state;
		state = next_state;
	end 
	
	//---------------------------------------
	
	always @(state) //enable
	begin
		case (state)
			2'b00:
				begin
					max = 5'd6;
					min = 5'd0;
					max16bit = max0;
					min16bit = min0;
				end
			2'b01:
				begin
					max = 5'd11;
					min = 5'd5;
					max16bit = max1;
					min16bit = min1;
				end
			2'b10:
				begin
					max = 5'd16;
					min = 5'd0;
					max16bit = max2;
					min16bit = min2;
				end
			default:
				begin
					max = 5'd6;
					min = 5'd0;
					max16bit = max0;
					min16bit = min0;
				end
		endcase
	end 
	
	always @(negedge increase)
	begin
		if (increase == 1'b0)
		begin
			case (state)
				2'b00: 
					begin
						next_state <= 2'b01;
						//isEnd <= 1'b0;
					end
				2'b01: 
					begin
						next_state <= 2'b10;
						//isEnd <= 1'b0;
					end
				2'b10: 
					begin
						next_state <= 2'b00;
						//isEnd <= 1'b1;
					end
				default:
					begin
						next_state <= 2'b00;
					end
			endcase
		end
	end
	
	//---------------------------------------
	
	always @(negedge clk)
	begin
		if (enable == 1'b1)
		begin
			if (increase == 1'b0)
			begin
				if ((lamp==max16bit))
				begin
					next_direction = ~next_direction;
				end
			end
			if (increase == 1'b1)
			begin
				if ((lamp==min16bit))
				begin
					next_direction = ~next_direction;
				end
			end
		end
	end 
	
	always @(next_direction)
	begin
		increase = next_direction;
	end
	 
endmodule 