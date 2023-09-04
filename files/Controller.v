`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:49:19 10/25/2022 
// Design Name: 
// Module Name:    Controller 
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
module Controller(
    input  [5:0] opcode,
	 output reg memRead,
	 output reg memWrite,
	 output reg regWrite,
	 output reg [1:0] regDst,
	 output reg [1:0] mem2Reg,
	 output reg aluSrc,
	 output reg lblSel,
	 output reg jmpSel
    );
	 
	 
	 always@(*) begin
		jmpSel <= ~opcode[4] & ~opcode[3];
		lblSel <= opcode[5] & opcode[4];
		mem2Reg <= opcode[5:4];
		memWrite <= (opcode == 6'b011000);
		memRead <= (opcode == 6'b010000);
		aluSrc <= opcode[4] | opcode[3];	 
		regWrite <= (~opcode[5] & ~opcode[4]) | (~opcode[5] & ~opcode[3]) | ( opcode[1] &  opcode[0]);						
		regDst[0] <= opcode[4];
		regDst[1] <= opcode[5];
	 end

endmodule