module choose_block(input at_bottom,
						  input Clk, Reset, 
						  input [7:0] LFSR_out,
						  input [1:0] rot_sel,	//from rotate_block.sv
						  
						  output new_shape, 
						  output [2:0] block_sel,	//this register is internal but output to view on hex driver
						  output choose_O, 
									choose_I_horiz, choose_I_vert,
									choose_Z_horiz, choose_Z_vert,
									choose_S_horiz, choose_S_vert,
									choose_J_left, choose_J_up, choose_J_right, choose_J_down,
									choose_L_left, choose_L_up, choose_L_right, choose_L_down,
									choose_T_left, choose_T_up, choose_T_right, choose_T_down,
						  output [5:0] block_size_x, block_size_y				//goes to block_motion.sv
						 );

always_ff @(posedge Clk) begin
	if (Reset || at_bottom) begin	//get new shape if reset or current block hits bottom
		new_shape = 1'b1;
	end
	else if (new_shape) begin
		block_sel <= (LFSR_out % 7);		
		new_shape = 1'b0;
	end
end

//assign block_sel = 3'd1;	//FOR TESTING ONLY

always_comb begin	
	block_size_x = 6'd0;
	block_size_y = 6'd0;
	
	choose_O = 1'd0;
	
	choose_I_horiz = 1'd0;
	choose_I_vert = 1'd0;
	
	choose_Z_horiz = 1'd0;
	choose_Z_vert = 1'd0;
	
	choose_S_horiz = 1'd0;
	choose_S_vert = 1'd0;
	
	choose_J_left = 1'd0; 
	choose_J_up = 1'd0;
	choose_J_right = 1'd0;
	choose_J_down = 1'd0;
	
	choose_L_left = 1'd0; 
	choose_L_up = 1'd0;
	choose_L_right = 1'd0;
	choose_L_down = 1'd0;
	
	choose_T_left = 1'd0; 
	choose_T_up = 1'd0;
	choose_T_right = 1'd0;
	choose_T_down = 1'd0;
	
	case (block_sel)
		3'd0 :	//choose O block; 19x19
		begin
			if (rot_sel == 2'd0 || rot_sel == 2'd1 || rot_sel == 2'd2 || rot_sel == 2'd3) begin
				block_size_x = 6'd19;
				block_size_y = 6'd19;
				choose_O = 1'd1;
			end
		end
		
		3'd1 :	//choose Z block 19x28
		begin	
			if (rot_sel == 2'd0 || rot_sel == 2'd2) begin		//choose horizontal Z block
				block_size_x = 6'd28;
				block_size_y = 6'd19;
				choose_Z_horiz = 1'd1;
			end
			else if (rot_sel == 2'd1 || rot_sel == 2'd3) begin	//choose vertical Z block
				block_size_x = 6'd19;
				block_size_y = 6'd28;
				choose_Z_vert = 1'd1;
			end
		end	
		
		3'd2 :	//choose S block 19X28
		begin
			if (rot_sel == 2'd0 || rot_sel == 2'd2) begin		//choose horizontal S block
				block_size_x = 6'd28;
				block_size_y = 6'd19;
				choose_S_horiz = 1'd1;
			end
			else if (rot_sel == 2'd1 || rot_sel == 2'd3) begin	//choose vertical S block
				block_size_x = 6'd19;
				block_size_y = 6'd28;
				choose_S_vert = 1'd1;
			end
		end
		
		3'd3 :	//choose I block; 10x37
		begin
			if (rot_sel == 2'd0 || rot_sel == 2'd2) begin		//choose horizontal I block
				block_size_x = 6'd37;
				block_size_y = 6'd10;
				choose_I_horiz = 1'd1;
			end
			else if (rot_sel == 2'd1 || rot_sel == 2'd3) begin	//choose vertical I block
				block_size_x = 6'd10;
				block_size_y = 6'd37;
				choose_I_vert = 1'd1;
			end
		end
		
		3'd4 :	//choose L block 19X28
		begin	
			if (rot_sel == 2'd0) begin			//choose horizontal (right)
				block_size_x = 6'd28;
				block_size_y = 6'd19;
				choose_L_right = 1'd1;
			end
			else if (rot_sel == 2'd1) begin	//choose vertical (down)
				block_size_x = 6'd19;
				block_size_y = 6'd28;
				choose_L_down = 1'd1;
			end
			else if (rot_sel == 2'd2) begin	//choose horizontal (left)
				block_size_x = 6'd28;
				block_size_y = 6'd19;
				choose_L_left = 1'd1;
			end
			else if (rot_sel == 2'd3) begin	//choose vertical (up)
				block_size_x = 6'd19;
				block_size_y = 6'd28;
				choose_L_up = 1'd1;
			end
		end
		
		3'd5 :	//choose J block 19x28
		begin
			if (rot_sel == 2'd0) begin			//choose horizontal (left)
				block_size_x = 6'd28;
				block_size_y = 6'd19;
				choose_J_left = 1'd1;
			end
			else if (rot_sel == 2'd1) begin	//choose vertical (up)
				block_size_x = 6'd19;
				block_size_y = 6'd28;
				choose_J_up = 1'd1;
			end
			else if (rot_sel == 2'd2) begin	//choose horizontal (right)
				block_size_x = 6'd28;
				block_size_y = 6'd19;
				choose_J_right = 1'd1;
			end
			else if (rot_sel == 2'd3) begin	//choose vertical (down)
				block_size_x = 6'd19;
				block_size_y = 6'd28;
				choose_J_down = 1'd1;
			end
		end
		
		3'd6 :	//choose T block 19x28
		begin
			begin
			if (rot_sel == 2'd0) begin			//choose horizontal (down)
				block_size_x = 6'd28;
				block_size_y = 6'd19;
				choose_T_down = 1'd1;
			end
			else if (rot_sel == 2'd1) begin	//choose vertical (left)
				block_size_x = 6'd19;
				block_size_y = 6'd28;
				choose_T_left = 1'd1;
			end
			else if (rot_sel == 2'd2) begin	//choose horizontal (up)
				block_size_x = 6'd28;
				block_size_y = 6'd19;
				choose_T_up = 1'd1;
			end
			else if (rot_sel == 2'd3) begin	//choose vertical (right)
				block_size_x = 6'd19;
				block_size_y = 6'd28;
				choose_T_right = 1'd1;
			end
		end
		end
	endcase
end

endmodule

