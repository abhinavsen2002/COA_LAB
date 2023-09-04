`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:43:54 10/25/2022 
// Design Name: 
// Module Name:    Complement2s 
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
module Complement2s(
	input [31:0] in,
	output [31:0] out
    );
	
	assign out = ~in + 1;

endmodule
