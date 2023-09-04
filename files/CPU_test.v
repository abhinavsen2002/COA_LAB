`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:37:34 11/04/2022
// Design Name:   CPU
// Module Name:   C:/Material/sem5/COA Lab/6/kgp-risc/KGP-RISC/CPU_test.v
// Project Name:  KGP-RISC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CPU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module CPU_test;

	// Inputs
	reg clk;
	reg rst;

	// Instantiate the Unit Under Test (UUT)
	CPU uut (
		.clk(clk), 
		.rst(rst)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#1;
		rst = 0;
		#1;
		#5000;
		$finish;
		// Add stimulus here
	end
	
	always @(*) begin
		$display("%d %d %d", $signed(uut.RFile.R[29]), $signed(uut.RFile.R[4]), $signed(uut.RFile.R[5]));
		if(uut.RFile.R[1] == 1) $finish;
	end
	
	always
	#2 clk = ~clk;
      
endmodule

