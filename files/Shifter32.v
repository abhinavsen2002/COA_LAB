`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:09:57 10/25/2022 
// Design Name: 
// Module Name:    Shifter32 
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
module Shifter(
	 input [4:0] shamt,
	 input [31:0] a,
	 input dir, // 0-> left, 1-> right
	 input type,  // 0->logical, 1->arithmatic
	 output [31:0] out
    );
	 
	 reg [31:0] shifted;
	 
	 always @(*) begin
        if (dir == 0&& type == 0) begin //left-shift
		      assign shifted = a << shamt;
		  end
		  else if(dir == 1&& type == 1) begin
		      assign shifted = a >>> shamt;
		  end
		  else if(dir == 1&& type == 0) begin
				assign shifted = a >> shamt;
		  end
	 end
    
	 assign out = shifted;
	 
endmodule
