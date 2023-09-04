`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:29:03 10/26/2022 
// Design Name: 
// Module Name:    DFF 
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
module DFF(
	input in,
	input clk, 
	input rst,
	output reg out
    );

	always@(posedge clk or posedge rst) begin
		if(rst == 1) out <= 1'b0;
		else out <= in;
	end

endmodule
