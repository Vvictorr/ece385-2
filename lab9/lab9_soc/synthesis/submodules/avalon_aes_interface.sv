/************************************************************************
Avalon-MM Interface for AES Decryption IP Core

Dong Kai Wang, Fall 2017

For use with ECE 385 Experiment 9
University of Illinois ECE Department

Register Map:

 0-3 : 4x 32bit AES Key
 4-7 : 4x 32bit AES Encrypted Message
 8-11: 4x 32bit AES Decrypted Message
   12: Not Used
	13: Not Used
   14: 32bit Start Register
   15: 32bit Done Register

************************************************************************/

module avalon_aes_interface (
	// Avalon Clock Input
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read; high when read operation
	input  logic AVL_WRITE,					// Avalon-MM Write; high when write operation
	input  logic AVL_CS,						// Avalon-MM Chip Select; high when read/write operation
	input  logic [3:0] AVL_BYTE_EN,		// Avalon-MM Byte Enable; active high signal to identify which bytes are being written
	input  logic [3:0] AVL_ADDR,			// Avalon-MM Address; address of read/write operation
	input  logic [31:0] AVL_WRITEDATA,	// Avalon-MM Write Data; data to be written
	output logic [31:0] AVL_READDATA,	// Avalon-MM Read Data; data to be read
	
	// Exported Conduit
	output logic [31:0] EXPORT_DATA		// Exported Conduit Signal to LEDs
);

//avalon bus is byte addressable with 4-bit address; convert to 16, 32-bit words (address units)
//RESET AND CONTROL SIGNALS ARE ACTIVE HIGH

logic [31:0] reg_file[16];	//create 16, 32-bit registers
int n;

//AES key is 128-bit; sending 32-bits at a time (NIOS II is 32-bit processor) so must send 4 times
 always_ff @(posedge CLK) begin
	if (RESET) begin
		for (n = 0; n < 16; n++) begin
			reg_file[n] <= 32'd0;
		end
	end
	else if (AVL_WRITE && AVL_CS) begin
		if (AVL_BYTE_EN[3]) begin	//write byte 3
			reg_file[AVL_ADDR][31:24] <= AVL_WRITEDATA[31:24];
		end
		if (AVL_BYTE_EN[2]) begin	//write byte 2
			reg_file[AVL_ADDR][23:16] <= AVL_WRITEDATA[23:16];
		end
		if (AVL_BYTE_EN[1]) begin	//write byte 1
			reg_file[AVL_ADDR][15:8] <= AVL_WRITEDATA[15:8];
		end
		if (AVL_BYTE_EN[0]) begin	//write byte 0
			reg_file[AVL_ADDR][7:0] <= AVL_WRITEDATA[7:0];
		end
	end
 end
 
 assign AVL_READDATA = (AVL_READ && AVL_CS) ? reg_file[AVL_ADDR] : 32'd0;
 
 //EXPORT_DATA should be assigned to the first 2 and last 2 bytes of the Encrypted Message
 //???????????????? ask ta
// assign EXPORT_DATA = (reg_file[4] && AVL_BYTE_EN[5]) ? reg_file[AVL_ADDR] : 32'd0;
 assign EXPORT_DATA = {reg_file[4][31:16], reg_file[7][15:0]};
 
endmodule






