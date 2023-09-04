`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:45:47 10/25/2022 
// Design Name: 
// Module Name:    RegFile 
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
module RegFile(
	input write,
	input [4:0] rs,
	input [4:0] rt,
	input [4:0] rd,
	input [31:0] data,
	input clk,
	input rst,
	output [31:0] rsData,
	output [31:0] rtData
    );
	
	reg [31:0] R[31:0];
	
	assign rsData = R[rs];
	assign rtData = R[rt];
	
	integer c;
	always@(posedge rst or posedge clk) begin
		if(rst) begin
			for(c=0; c<32; c=c+1) R[c] <= 0;
		end
		else if(write) begin
			R[rd] = data;
		end
	end
	
endmodule
