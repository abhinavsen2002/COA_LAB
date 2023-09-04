`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:13:34 11/01/2022 
// Design Name: 
// Module Name:    PC 
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
module PC(
    input [31:0] inp,
	 input clk,
	 input rst,
	 output reg [31:0] out
    );
	 
	 always @(posedge clk or posedge rst) begin
	    if (rst) out <= -32'd4;
		 else out <= inp;
	 end

endmodule