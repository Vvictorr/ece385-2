//MAR takes in address stored in PC
module  MAR_module(input logic Clk, Reset, Load,
						 input logic [15:0] reg_bus,
						 output logic [15:0] MAR
						 );
						 
 always_ff @(posedge Clk) begin
	if (Reset) begin
		MAR <= 16'd0;
	end
	else if (Load) begin
		MAR <= reg_bus;
	end 
 end

endmodule

 
						  