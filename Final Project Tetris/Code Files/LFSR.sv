//this module is 8-bit LFSR (external bit LFSR)
//creates pseudo-random number generator for tetris block generation

/////////////////	MUST RESET BOARD BEFORE PLAYING BECAUSE LFSR GENERATES VALUES UPON RESET ///////////////////////
module LFSR(input Clk, Reset,
				output [7:0] LFSR_out
				);
				
 logic feedback;
 assign feedback = (LFSR_out[4] ^ LFSR_out[2]);	//choose taps
 
 always @(posedge Clk) begin
	if (Reset) begin
		LFSR_out <= 8'hff;
	end
	else begin
		LFSR_out <= {LFSR_out[6:0], feedback};
	end
 end
endmodule
