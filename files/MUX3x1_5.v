

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:23:38 11/01/2022 
// Design Name: 
// Module Name:    MUX3x1_5 
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
module MUX3x1_5(
	 input [4:0] inp1,
	 input [4:0] inp2,
	 input [4:0] inp3,
	 input [1:0]sel,
	 output reg [4:0] out
    );
	 
	 always @(*) begin
	    if (sel == 2'b00)
		     out = inp1;
		 else if (sel == 2'b01)
		     out = inp2;
		 else
		     out = inp3;
	 end

endmodule