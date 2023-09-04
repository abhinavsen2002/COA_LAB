
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:48:22 10/25/2022 
// Design Name: 
// Module Name:    BranchController 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module BranchController(
    input [5:0] opcode,
	 input fZero,
	 input fSign,
	 input fCarry,
	 output out
    );
	 
	 wire b, bZero, bNZero, bSign, bCarry, bNCarry;
	 
	 assign b = (opcode == 6'b101011) |(opcode == 6'b101000) | (opcode == 6'b100000); 
	 assign bZero = (opcode == 6'b110001) & fZero;
	 assign bNZero = (opcode == 6'b110010) & ~fZero;
	 assign bSign = (opcode == 6'b110000) & fSign;
	 assign bCarry = (opcode == 6'b101001) & fCarry;
	 assign bNCarry = (opcode == 6'b101010) & ~fCarry;
	 
	 assign out = b | bZero | bNZero | bSign | bCarry | bNCarry;	 
	 
endmodule