`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:05:52 10/25/2022 
// Design Name: 
// Module Name:    Xor32 
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
module Xor32(
	input [31:0] a,
	input [31:0] b,
	output [31:0] out
    );

	assign out = a ^ b;
	
endmodule
