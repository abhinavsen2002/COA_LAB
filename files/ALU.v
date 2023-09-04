`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:39:40 10/25/2022 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] a,
	 input [31:0] b,
	 input [3:0]  op,
	 input [4:0] shamt,
	 output reg [31:0] result,
	 output fZero,
	 output fSign,
	 output reg fCarry
    );
	 
	 wire [31:0] rA, rAdd, rAnd, rXor, rShift, rDiff; // results for different operations
	 
	 // used for complement
	 wire [31:0] bInv, selB; 
	 assign bInv = ~b;
	 assign selB = op[2] ? bInv : b;
	 wire [31:0] const1, selA;
	 assign const1 = 32'd1;
	 assign selA = op[2] ? const1 : a;
	 
	 wire [4:0] shiftIn; // shift-register input b/w shamt or b
	 assign shiftIn = op[2] ? shamt : b[4:0]; // if op[2] == 1 shiftInput = shamt else b[4:0]
	 
	 assign rA = a;                                 // forward a itself
	 Adder32 A1(selA, selB, rAdd, cOut);              // adder / complement
	 And32 An1(a, b, rAnd);                      // and-op
	 Xor32 X1(a, b, rXor);                          // xor-op
	 Shifter S(shiftIn, a, op[1], op[0], rShift);   // shift-op
	 diff d(a, b, rDiff);
	
	 always @(*) begin 
	     if (op[3] == 1)
		     result = rShift;
		  else if (op == 4'b0010)
		     result = rAnd;
		  else if (op == 4'b0011)
		     result = rXor;
		  else if (op == 4'b0001) begin
		     result = rAdd;
			  fCarry = cOut;
		  end
		  else if (op == 4'b0101)
			  result = rAdd;
		  else if (op == 4'b0110)
				result = rDiff;
		  else
		     result = rA;
	 end
	 
	assign fZero = (result == 32'b0);
	assign fSign = result[31];

endmodule