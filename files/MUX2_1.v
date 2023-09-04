`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:21:39 11/01/2022 
// Design Name: 
// Module Name:    MUX2_1 
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
module MUX2_1(
	 input [31:0] inp1,
	 input [31:0] inp2,
	 input sel,
	 output [31:0] out
    );
	 
	 assign out = sel ? inp2 : inp1;

endmodule