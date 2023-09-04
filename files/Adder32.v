`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:42:55 10/25/2022 
// Design Name: 
// Module Name:    Adder32 
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
module Adder32(
	input [31:0] a,
	input [31:0] b,
	output [31:0] out,
	output carryOut
    );

	assign {carryOut, out} = a + b;
	
endmodule
