//load each result from 8 possible instructions (LD, LDI, LDR, LEA, ADD, AND, NOT) into 16-bit general purpose register
module reg_file(input logic Clk, Reset,		
					 input logic [15:0] R,			//16-bit 2's complement result is stored into register R
					 output logic n, z, p
					);
 
 //must assign conditions codes n (negative), z (zero), p (positive) 
 always_comb @(posedge Clk) begin
	if (R == 16'd0) begin			//check if result is zero
		n <= 0;
		z <= 1;
		p <= 0;
	end
	else if (R[15] == 1) begin		//check if result is negative
		n <= 1;
		z <= 0;
		p <= 0;
	end
	else begin							//if result not zero or negative, must be positive
		n <= 0;
		z <= 0;
		p <= 1;
	end
 end

endmodule
 
