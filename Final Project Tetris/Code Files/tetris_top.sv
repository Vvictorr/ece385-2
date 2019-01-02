
module tetris_top(input               CLOCK_50,
						input        [3:0]  KEY,          //bit 0 is set up as Reset
						output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
						//PS/2
						input PS2_CLK,
						input PS2_DAT,
						// VGA Interface 
						output logic [7:0]  VGA_R,        //VGA Red
												  VGA_G,        //VGA Green
												  VGA_B,        //VGA Blue
						output logic        VGA_CLK,      //VGA Clock
												  VGA_SYNC_N,   //VGA Sync signal
												  VGA_BLANK_N,  //VGA Blank signal
												  VGA_VS,       //VGA vertical sync signal
												  VGA_HS        //VGA horizontal sync signal						
						);
    
    logic Reset_h, Clk;
    logic [7:0] keycode;
	 logic keypress;
    
    assign Clk = CLOCK_50;
    always_ff @ (posedge Clk) begin
        Reset_h <= ~(KEY[0]);        // The push buttons are active low
    end
	 
	 logic [9:0] DrawX, DrawY;
	 
	 keyboard keyboard_inst(.Clk(Clk), 
									.psClk(PS2_CLK),
									.psData(PS2_DAT),
									.reset(Reset_h),
									
									.keyCode(keycode),
									.press(keypress));
    
    vga_clk vga_clk_instance(.inclk0(Clk),
									  
									  .c0(VGA_CLK));
    
    VGA_controller vga_controller_instance(.Clk(Clk),
														 .Reset(Reset_h),
														 .VGA_CLK(VGA_CLK),
														
														 .VGA_HS(VGA_HS),
														 .VGA_VS(VGA_VS),
														 .VGA_BLANK_N(VGA_BLANK_N),
														 .VGA_SYNC_N(VGA_SYNC_N),
														 .DrawX(DrawX),
                                           .DrawY(DrawY));
						
	logic [7:0] LFSR_out;
	LFSR LFSR_inst(.Clk,
						.Reset(Reset_h),
						
						.LFSR_out);
	
	logic [2:0] rot_sel;
	rotate_block rotate_block_inst(.Clk,
											 .Reset(Reset_h),
											 .keypress,
											 .keycode,
											 .new_shape,
											 .X_Pos, .Y_Pos,
											 .block_size_x, .block_size_y,
											 
											 .rot_sel(rot_sel));
	
	logic new_shape;
	logic choose_O, 
			choose_I_horiz, choose_I_vert,
			choose_Z_horiz, choose_Z_vert,
		   choose_S_horiz, choose_S_vert,	
			choose_J_left, choose_J_up, choose_J_right, choose_J_down, 
			choose_L_left, choose_L_up, choose_L_right, choose_L_down,
			choose_T_left, choose_T_up, choose_T_right, choose_T_down;
	logic [2:0] block_sel;	//view on hex
	logic [5:0] block_size_x, block_size_y;
	choose_block choose_block_inst(.Clk,
											 .Reset(Reset_h),
											 .LFSR_out,
											 .rot_sel(rot_sel),
											 .at_bottom,
											 
											 .new_shape,
											 .block_sel(block_sel),
											 .choose_O, 
											 .choose_I_horiz, .choose_I_vert,
											 .choose_Z_horiz, .choose_Z_vert,
											 .choose_S_horiz, .choose_S_vert, 
											 .choose_J_left, .choose_J_up, .choose_J_right, .choose_J_down,	
											 .choose_L_left, .choose_L_up, .choose_L_right, .choose_L_down,
											 .choose_T_left, .choose_T_up, .choose_T_right, .choose_T_down,
											 .block_size_x, .block_size_y);
											 
	logic at_bottom;												 
	logic [9:0] X_Pos, Y_Pos;
	block_motion block_motion_inst(.Clk,
											 .Reset(Reset_h),
											 .frame_clk(VGA_VS),
											 .DrawX, .DrawY,
											 .keycode,
											 .keypress,
											 .block_size_x, .block_size_y,
											 .choose_O, 
											 .choose_I_horiz, .choose_I_vert,
											 .choose_Z_horiz, .choose_Z_vert,
											 .choose_S_horiz, .choose_S_vert, 
											 .choose_J_left, .choose_J_up, .choose_J_right, .choose_J_down, 
											 .choose_L_left, .choose_L_up, .choose_L_right, .choose_L_down,
											 .choose_T_left, .choose_T_up, .choose_T_right, .choose_T_down,
											 .board,
											 
											 .at_bottom,
											 .X_Pos, .Y_Pos);
	
	logic [15:0] score;
	logic [21:0][10:0][3:0] board;														 
	board board_inst(.Clk,
						  .Reset(Reset_h),
						  .at_bottom,
						  .choose_O, 
						  .choose_I_horiz, .choose_I_vert,
						  .choose_Z_horiz, .choose_Z_vert,
						  .choose_S_horiz, .choose_S_vert, 
						  .choose_J_left, .choose_J_up, .choose_J_right, .choose_J_down, 
						  .choose_L_left, .choose_L_up, .choose_L_right, .choose_L_down,
						  .choose_T_left, .choose_T_up, .choose_T_right, .choose_T_down,
						  .X_Pos, .Y_Pos,
						  
						  .score,
						  .board);
	
	logic [3:0] tetris_block_data,
					score_data,
					O_block_data,
					I_vert_block_data, I_horiz_block_data,
					Z_vert_block_data, Z_horiz_block_data,
					S_vert_block_data, S_horiz_block_data,
					J_up_block_data, J_right_block_data, J_left_block_data, J_down_block_data, 
					L_up_block_data, L_right_block_data, L_left_block_data, L_down_block_data,
					T_up_block_data, T_right_block_data, T_left_block_data, T_down_block_data,
					score_0_digit_data, score_1_digit_data, score_2_digit_data, score_3_digit_data,
					score_4_digit_data, score_5_digit_data, score_6_digit_data, score_7_digit_data,
					score_8_digit_data, score_9_digit_data;
	logic [18:0] address;
	color_mapper color_instance(.DrawX(DrawX),		
                               .DrawY(DrawY),
										 .tetris_block_data,
										 .score_data,
										 .O_block_data, 
										 .I_vert_block_data, .I_horiz_block_data,
										 .Z_vert_block_data, .Z_horiz_block_data,
									    .S_vert_block_data, .S_horiz_block_data,	 
										 .J_up_block_data, .J_right_block_data, .J_left_block_data, .J_down_block_data, 
										 .L_up_block_data, .L_right_block_data, .L_left_block_data, .L_down_block_data,
										 .T_up_block_data, .T_right_block_data, .T_left_block_data, .T_down_block_data,
										 .score_0_digit_data, .score_1_digit_data, .score_2_digit_data, .score_3_digit_data,
										 .score_4_digit_data, .score_5_digit_data, .score_6_digit_data, .score_7_digit_data,
										 .score_8_digit_data, .score_9_digit_data,
										 .choose_O, 
										 .choose_I_horiz, .choose_I_vert,
										 .choose_Z_horiz, .choose_Z_vert,
										 .choose_S_horiz, .choose_S_vert, 
										 .choose_J_left, .choose_J_up, .choose_J_right, .choose_J_down, 
										 .choose_L_left, .choose_L_up, .choose_L_right, .choose_L_down,
										 .choose_T_left, .choose_T_up, .choose_T_right, .choose_T_down,
										 .X_Pos, .Y_Pos,
										 .block_size_x, .block_size_y,
										 .board,
										 .score,
										  
										 .VGA_R(VGA_R), //puts out RGB signals to monitor
                               .VGA_G(VGA_G),	
                               .VGA_B(VGA_B),
										 .address(address));
										  
	O_block O_block_inst(.Clk,
								.addr(address),
								.data(O_block_data));
								 
	I_vert_block I_vert_block_inst(.Clk,
											 .addr(address),
											 .data(I_vert_block_data));
											  
	I_horiz_block I_horiz_block_inst(.Clk,
												.addr(address),
												.data(I_horiz_block_data));
												
	J_up_block J_up_block_inst(.Clk,
										.addr(address),
										.data(J_up_block_data));
	
	J_right_block J_right_block_inst(.Clk,
												.addr(address),
												.data(J_right_block_data));
	
	J_left_block J_left_block_inst(.Clk,
											 .addr(address),
											 .data(J_left_block_data));
	
	J_down_block J_down_block_inst(.Clk,
											 .addr(address),
											 .data(J_down_block_data));
											 
	L_up_block L_up_block_inst(.Clk,
										.addr(address),
										.data(L_up_block_data));
	
	L_right_block L_right_block_inst(.Clk,
												.addr(address),
												.data(L_right_block_data));
	
	L_left_block L_left_block_inst(.Clk,
											 .addr(address),
											 .data(L_left_block_data));
	
	L_down_block L_down_block_inst(.Clk,
											 .addr(address),
											 .data(L_down_block_data));									 
											 
	T_up_block T_up_block_inst(.Clk,
										.addr(address),
										.data(T_up_block_data));
	
	T_right_block T_right_block_inst(.Clk,
												.addr(address),
												.data(T_right_block_data));
	
	T_left_block T_left_block_inst(.Clk,
											 .addr(address),
											 .data(T_left_block_data));
	
	T_down_block T_down_block_inst(.Clk,
											 .addr(address),
											 .data(T_down_block_data));
	
	Z_vert_block Z_vert_block_inst(.Clk,
											 .addr(address),
											 .data(Z_vert_block_data));
											  
	Z_horiz_block Z_horiz_block_inst(.Clk,
												.addr(address),
												.data(Z_horiz_block_data));
	
	S_vert_block S_vert_block_inst(.Clk,
											 .addr(address),
											 .data(S_vert_block_data));
											  
	S_horiz_block S_horiz_block_inst(.Clk,
												.addr(address),
												.data(S_horiz_block_data));																			
												
	tetris_logo tetris_logo_inst(.Clk,
										  .addr(address),
										  .data(tetris_block_data));
												
	score score_inst(.Clk,
						  .addr(address),
						  .data(score_data));
	
	score_0_digit score_0_digit_inst(.Clk,
						  .addr(address),
						  .data(score_0_digit_data));

	score_1_digit score_1_digit_inst(.Clk,
						  .addr(address),
						  .data(score_1_digit_data));
	
	score_2_digit score_2_digit_inst(.Clk,
						  .addr(address),
						  .data(score_2_digit_data));

	score_3_digit score_3_digit_inst(.Clk,
						  .addr(address),
						  .data(score_3_digit_data));
	
	score_4_digit score_4_digit_inst(.Clk,
						  .addr(address),
						  .data(score_4_digit_data));
	
	score_5_digit score_5_digit_inst(.Clk,
						  .addr(address),
						  .data(score_5_digit_data));
	
	score_6_digit score_6_digit_inst(.Clk,
						  .addr(address),
						  .data(score_6_digit_data));
	
	score_7_digit score_7_digit_inst(.Clk,
						  .addr(address),
						  .data(score_7_digit_data));

	score_8_digit score_8_digit_inst(.Clk,
						  .addr(address),
						  .data(score_8_digit_data));
	
	score_9_digit score_9_digit_inst(.Clk,
						  .addr(address),
						  .data(score_9_digit_data));						  
    
    // Display keycode on hex display
    HexDriver hex_inst_0 (score[3:0], HEX0);
    HexDriver hex_inst_1 (score[7:4], HEX1);
	 HexDriver hex_inst_2 (score[11:8], HEX2);
	 HexDriver hex_inst_3 (score[15:12], HEX3);
	 HexDriver hex_inst_4 (block_sel, HEX4);
    HexDriver hex_inst_5 (rot_sel, HEX5);
endmodule
