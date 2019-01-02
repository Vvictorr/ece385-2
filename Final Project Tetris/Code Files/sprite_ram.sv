module O_block(input Clk,
					input [18:0] addr,
					output [3:0] data
				  );
 logic [3:0] OCM[361];	//361 addresses

 initial begin
	$readmemh("sprite_bytes/O_block.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule


module I_vert_block(input Clk,
						  input [18:0] addr,
						  output [3:0] data
						 );
 logic [3:0] OCM[370];	//370 addresses

 initial begin
	$readmemh("sprite_bytes/I_vert_block.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule

module I_horiz_block(input Clk,
							input [18:0] addr,
							output [3:0] data
						  );
 logic [3:0] OCM[370];	//370 addresses

 initial begin
	$readmemh("sprite_bytes/I_horiz_block.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule


module J_up_block(input Clk,
							input [18:0] addr,
							output [3:0] data
						  );
 logic [3:0] OCM[532];	//532 addresses

 initial begin
	$readmemh("sprite_bytes/J_block_up.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule

module J_right_block(input Clk,
							input [18:0] addr,
							output [3:0] data
						  );
 logic [3:0] OCM[532];	//532 addresses

 initial begin
	$readmemh("sprite_bytes/J_block_right.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule

module J_left_block(input Clk,
						  input [18:0] addr,
						  output [3:0] data
						  );
 logic [3:0] OCM[532];	//532 addresses

 initial begin
	$readmemh("sprite_bytes/J_block_left.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule

module J_down_block(input Clk,
						  input [18:0] addr,
						  output [3:0] data
						  );
 logic [3:0] OCM[532];	//532 addresses

 initial begin
	$readmemh("sprite_bytes/J_block_down.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule


module L_up_block(input Clk,
							input [18:0] addr,
							output [3:0] data
						  );
 logic [3:0] OCM[532];	//532 addresses

 initial begin
	$readmemh("sprite_bytes/L_block_up.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule

module L_right_block(input Clk,
							input [18:0] addr,
							output [3:0] data
						  );
 logic [3:0] OCM[532];	//532 addresses

 initial begin
	$readmemh("sprite_bytes/L_block_right.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule

module L_left_block(input Clk,
						  input [18:0] addr,
						  output [3:0] data
						  );
 logic [3:0] OCM[532];	//532 addresses

 initial begin
	$readmemh("sprite_bytes/L_block_left.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule

module L_down_block(input Clk,
						  input [18:0] addr,
						  output [3:0] data
						  );
 logic [3:0] OCM[532];	//532 addresses

 initial begin
	$readmemh("sprite_bytes/L_block_down.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule


module T_up_block(input Clk,
							input [18:0] addr,
							output [3:0] data
						  );
 logic [3:0] OCM[532];	//532 addresses

 initial begin
	$readmemh("sprite_bytes/T_block_up.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule

module T_right_block(input Clk,
							input [18:0] addr,
							output [3:0] data
						  );
 logic [3:0] OCM[532];	//532 addresses

 initial begin
	$readmemh("sprite_bytes/T_block_right.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule

module T_left_block(input Clk,
						  input [18:0] addr,
						  output [3:0] data
						  );
 logic [3:0] OCM[532];	//532 addresses

 initial begin
	$readmemh("sprite_bytes/T_block_left.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule

module T_down_block(input Clk,
						  input [18:0] addr,
						  output [3:0] data
						  );
 logic [3:0] OCM[532];	//532 addresses

 initial begin
	$readmemh("sprite_bytes/T_block_down.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule


module Z_vert_block(input Clk,
						  input [18:0] addr,
						  output [3:0] data
						 );
 logic [3:0] OCM[532];	//532 addresses

 initial begin
	$readmemh("sprite_bytes/Z_vert_block.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule

module Z_horiz_block(input Clk,
							input [18:0] addr,
							output [3:0] data
						  );
 logic [3:0] OCM[532];	//532 addresses

 initial begin
	$readmemh("sprite_bytes/Z_horiz_block.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule


module S_vert_block(input Clk,
						  input [18:0] addr,
						  output [3:0] data
						 );
 logic [3:0] OCM[532];	//532 addresses

 initial begin
	$readmemh("sprite_bytes/S_vert_block.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule

module S_horiz_block(input Clk,
							input [18:0] addr,
							output [3:0] data
						  );
 logic [3:0] OCM[532];	//532 addresses

 initial begin
	$readmemh("sprite_bytes/S_horiz_block.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule


module tetris_logo(input Clk,
							input [18:0] addr,
							output [3:0] data
						  );
 logic [3:0] OCM[6250];	//6250 addresses

 initial begin
	$readmemh("sprite_bytes/tetris.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule

module score(input Clk,
				 input [18:0] addr,
				 output [3:0] data
						  );
 logic [3:0] OCM[600];	//600 addresses

 initial begin
	$readmemh("sprite_bytes/score.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule

module score_0_digit(input Clk,
				 input [18:0] addr,
				 output [3:0] data
						  );
 logic [3:0] OCM[120];	//120 addresses

 initial begin
	$readmemh("sprite_bytes/zero.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule

module score_1_digit(input Clk,
				 input [18:0] addr,
				 output [3:0] data
						  );
 logic [3:0] OCM[120];	//120 addresses

 initial begin
	$readmemh("sprite_bytes/one.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule

module score_2_digit(input Clk,
				 input [18:0] addr,
				 output [3:0] data
						  );
 logic [3:0] OCM[120];	//120 addresses

 initial begin
	$readmemh("sprite_bytes/two.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule

module score_3_digit(input Clk,
				 input [18:0] addr,
				 output [3:0] data
						  );
 logic [3:0] OCM[120];	//120 addresses

 initial begin
	$readmemh("sprite_bytes/three.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule

module score_4_digit(input Clk,
				 input [18:0] addr,
				 output [3:0] data
						  );
 logic [3:0] OCM[120];	//120 addresses

 initial begin
	$readmemh("sprite_bytes/four.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule

module score_5_digit(input Clk,
				 input [18:0] addr,
				 output [3:0] data
						  );
 logic [3:0] OCM[120];	//120 addresses

 initial begin
	$readmemh("sprite_bytes/five.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule

module score_6_digit(input Clk,
				 input [18:0] addr,
				 output [3:0] data
						  );
 logic [3:0] OCM[120];	//120 addresses

 initial begin
	$readmemh("sprite_bytes/six.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule

module score_7_digit(input Clk,
				 input [18:0] addr,
				 output [3:0] data
						  );
 logic [3:0] OCM[120];	//120 addresses

 initial begin
	$readmemh("sprite_bytes/seven.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule

module score_8_digit(input Clk,
				 input [18:0] addr,
				 output [3:0] data
						  );
 logic [3:0] OCM[120];	//120 addresses

 initial begin
	$readmemh("sprite_bytes/eight.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule

module score_9_digit(input Clk,
				 input [18:0] addr,
				 output [3:0] data
						  );
 logic [3:0] OCM[120];	//120 addresses

 initial begin
	$readmemh("sprite_bytes/nine.txt", OCM);
 end
 always_ff @(posedge Clk) begin
	data <= OCM[addr];
 end
endmodule