`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:20:17 11/01/2022
// Design Name:   ALU
// Module Name:   C:/Material/sem5/COA Lab/6/kgp-risc/KGP-RISC/ALU_test.v
// Project Name:  KGP-RISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALU_test;

	// Inputs
	reg [31:0] a;
	reg [31:0] b;
	reg [3:0] op;
	reg [4:0] shamt;

	// Outputs
	wire [31:0] result;
	wire fZero;
	wire fSign;
	wire fCarry;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.a(a), 
		.b(b), 
		.op(op), 
		.shamt(shamt), 
		.result(result), 
		.fZero(fZero), 
		.fSign(fSign), 
		.fCarry(fCarry)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;
		op = 0;
		shamt = 0;

		#50;
		a = 32'd12; b = 32'd 10; op = 4'b0001; #50; // add
		b = 32'd10; op = 4'b0101; #50 // complement
		a = 32'd8; b = 32'd8; op = 4'b0011; #50; //xor
		op = 4'b0010; #50; //and
		a = 32'd4; op = 4'b1100; shamt = 5'd2; #50; // shift-left-logical 1 by 2 bits
      a = 32'd8; op = 4'b1110; shamt = 5'd2; #50; // shift-right-logical 8 by 2 bits
		a = 32'd4; op = 4'b1000; shamt = 5'd16; b = 32'd2; #50; // shift-left-variable 1 by 2 bits
		a = -32'd2147483648; op = 4'b1010; shamt = 5'd16; b = 32'd2; #50; // shift-right-logical-variable 8 by 2 bits
		a = 32'd8; op = 4'b1111; shamt = 5'd2;  b = 32'd50; #50; // shift-right-arithmatic 8 by 2 bits
		a = -32'd2147483648; op = 4'b1011; shamt = 5'd16;  b = 32'd2; #50; // shift-right-arithmatic-variable 8 by 2 bits

	end
      
endmodule

