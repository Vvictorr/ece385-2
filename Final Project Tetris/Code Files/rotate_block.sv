module rotate_block(input Clk, Reset,
						  input keypress,
						  input [7:0] keycode, 
						  input new_shape,
						  input [9:0] X_Pos, Y_Pos,
						  input [5:0] block_size_x, block_size_y,
						  output [2:0] rot_sel	//goes to choose_block.sv
						  );
						  
//4 possible rotated shapes for each shape so need 4 rotate states						  
enum logic [3:0] {Rotate_0, Rotate_0_wait, Rotate_1, Rotate_1_wait, Rotate_2, Rotate_2_wait, Rotate_3, Rotate_3_wait} current_state, next_state;

always_ff @(posedge Clk) begin
	if (Reset || new_shape) begin	//return to starting horizontal position if reset or new shape is generated
		current_state <= Rotate_0;
	end
	else begin
		current_state <= next_state;
	end
end

always_comb begin
	//set default state
	next_state = current_state;
	
	unique case (current_state) 
		Rotate_0 :										//horizontal
		begin
			if ((keypress == 1'b1) && (keycode == 8'h1d)) begin
				if (Y_Pos + block_size_x > 333 + 1)			//check if beyond boundary: if yes, stay horizontal and don't allow rotation
					next_state = Rotate_0;
				else
					next_state = Rotate_0_wait;
			end
		end
		Rotate_0_wait :
		begin
			if (keypress == 1'b0)
				next_state = Rotate_1;
		end			
		Rotate_1 :										//vertical
		begin
			if ((keypress == 1'b1) && (keycode == 8'h1d)) begin
				if (X_Pos + block_size_y > 369 + 1)			//check if beyond boundary: if yes, stay vertical and don't allow rotation
					next_state = Rotate_1;
				else
					next_state = Rotate_1_wait;
			end
		end
		Rotate_1_wait :
		begin
			if (keypress == 1'b0)
				next_state = Rotate_2;
		end			
		Rotate_2 :										//horizontal
		begin
			if ((keypress == 1'b1) && (keycode == 8'h1d)) begin
				if (Y_Pos + block_size_x > 333 + 1)			//check if beyond boundary: if yes, stay horizontal and don't allow rotation
					next_state = Rotate_2;
				else
					next_state = Rotate_2_wait;
			end
		end
		Rotate_2_wait :
		begin
			if (keypress == 1'b0)
				next_state = Rotate_3;
		end
		Rotate_3 :										//vertical
		begin
			if ((keypress == 1'b1) && (keycode == 8'h1d)) begin
				if (X_Pos + block_size_y > 369 + 1)			//check if beyond boundary: if yes, stay vertical and don't allow rotation
					next_state = Rotate_3;
				else
					next_state = Rotate_3_wait;
			end
		end
		Rotate_3_wait :
		begin
			if (keypress == 1'b0)
				next_state = Rotate_0;
		end
	endcase

	case (current_state)
		Rotate_0 :
			rot_sel = 2'd0;
		Rotate_1 :
			rot_sel = 2'd1;	
		Rotate_2 :
			rot_sel = 2'd2;	
		Rotate_3 :
			rot_sel = 2'd3;
		default :
			rot_sel = 2'd0;
	endcase
end
endmodule
		
	
	