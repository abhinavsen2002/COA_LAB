`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:14:29 11/01/2022 
// Design Name: 
// Module Name:    CPU 
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
module CPU(
    input clk,
    input rst
    );

	wire [31:0] nxtInstrAddr, instrAddr;		//Instruction addresses
	PC pc(nxtInstrAddr, clk, rst, instrAddr);  	//Program counter
	
	wire [31:0] instruct;						//Current instruction
	
	//Instruction memory (IM[i], i = PC/4)
	rom IM(clk, {2'b0,nxtInstrAddr[9:2]}, instruct); 
	 
	// Control lines from controller
	wire fZero, fNegative, fCarry; // flags from ALU
	wire aluSrc;                   // ALU source
	wire fMemRead, fMemWrite;      // memory access flags
	wire lblSel, jmpSel;           // label-select and jump-select
	wire [1:0] regDst, memToReg;   // register destination and memory-to-register destination
	wire regWrite;                 // register write flag
 
	//Instruction decode
	wire [5:0] opcode ,funcode;
	wire [4:0] shamt, rs, rt;       
	wire [15:0] imm;
	assign opcode  = instruct[31:26];
	assign funcode = instruct[10:5];
	assign shamt   = instruct[15:11];
	assign rs      = instruct[25:21];
	assign rt      = instruct[20:16];
	assign imm     = instruct[15:0];

	// Register-file 32-bit wide 32 registers	
	wire [4:0] writeAddr;
	wire [31:0] writeData, readData1, readData2;
	wire [4:0] ra;
	assign ra = 5'b11111;
	
	//RegToDst 3-1 Multiplexer for choosing b/w rs, rt, $ra
	MUX3x1_5 mRegDst(rs, rt, ra, regDst, writeAddr);
	RegFile RFile(regWrite, rs, rt, writeAddr, writeData, clk, rst, readData1, readData2);

	// Controller
	Controller ctrl(opcode, fMemRead, fMemWrite, regWrite, regDst, memToReg, aluSrc, lblSel, jmpSel);

	// ALU-controller to provide ALU control lines (alucode)
	wire [3:0] alucode;
	ALUController  aluControl(opcode, funcode, alucode);

	// Sign-extend the immediate value
	wire [31:0] extendImm;
   SignExtend signExtend(imm, extendImm);	

	// 2-1 MUX to select between the two read data sources (readData2, extended immediate)
	wire [31:0] aluInp2;
	MUX2_1 aluMux(readData2, extendImm, aluSrc, aluInp2);

	wire [31:0] aluResult;
	wire carryOut;
	// ALU
	ALU alu(readData1, aluInp2, alucode, shamt, aluResult, fZero, fNegative, carryOut);
	
	DFF Carry(carryOut, clk, rst, fCarry); // Store current carry value in DFF
	
	// Branch-controller to provide if it is valid to branch
	wire fBranch;				   	// branch flag
	BranchController bContrl(opcode, fZero, fNegative, fCarry, fBranch);

	// Data memory
	// 32-bit wide 1024-word memory
	// ena set to 1 when fMemRead or fMemWrite is set
	wire ena;
	wire [31:0] memData;
	assign ena = fMemRead | fMemWrite;
	bram dataMem(
		~clk,					 // Datamem read synchronous to clock so negedge used
		ena,
		fMemWrite,
		{2'b00, aluResult[9:2]}, // indexing / 4
		readData2,
		memData
	);
	wire [31:0] pc4, jmpLabel, jmpImmLabel;
   
	// ** PC-LOGIC ** 
	assign pc4 = instrAddr + 32'd4;
	assign jmpLabel = {pc4[31:28], {instruct[25:0], 2'b00}};	// 26-bit Jump Label
	assign jmpImmLabel = pc4 + {extendImm[29:0], 2'b00};        // 16-bit Jump Label
	// ** PC-LOGIC ** 
	
	wire [31:0] lblSelOut, jmpSelOut;
	MUX2_1 mLblSel(jmpLabel, jmpImmLabel, lblSel, lblSelOut);   // Select jump label
	MUX2_1 mJmpSel(lblSelOut, readData1, jmpSel, jmpSelOut);    // Select label-type jump or register-value type jump
	MUX2_1 mBrnchSel(pc4, jmpSelOut, fBranch, nxtInstrAddr);	// Select to branch or not

	MUX3_1 mMemToReg(aluResult, memData, pc4, memToReg, writeData); // Mux for writeData for regfile

endmodule