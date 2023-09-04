`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:36:57 10/25/2022 
// Design Name: 
// Module Name:    ALUController 
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
module ALUController(
	 input [5:0] opcode,
	 input [5:0] funct,
    output reg [3:0] aluC
    );
	
	always@(*) begin
		 if (opcode[5] == 1)
		     aluC = 4'b0;
		 else if (opcode == 6'b0)
		     aluC = funct[3:0];
		 else if (opcode == 6'b001000 || opcode[5:4] == 2'b01)
		     aluC = 4'b0001;
		 else if (opcode == 6'b001001)
		     aluC = 4'b0101;
       else 
           aluC = 4'b0000;		 
	 end

endmodule
