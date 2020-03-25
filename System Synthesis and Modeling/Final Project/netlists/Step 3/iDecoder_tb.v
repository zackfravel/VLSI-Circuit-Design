// Zack Fravel
// System Synthesis and Modeling
// Final Project (Step 3)

`timescale 1ns/1ns
module iDecoder_tb();

	// Inputs/Outputs
	reg[15:0] instruction; reg clk; reg reset; reg enable;
	wire[3:0] opcode; wire[5:0] A; wire[5:0] B; wire FSM1; wire FSM2; wire FSM3; wire FSM4; wire FSM5; wire FSM6;

	// Declare Module
	iDecoder test(clk, reset, enable, instruction, opcode, FSM1, FSM2, FSM3, FSM4, FSM5, FSM6, A, B);

	initial
	begin
		clk = 0; enable = 0;
		instruction = 16'h0000;	
		reset = 0;	    // Blank
		#200;
		reset = 1;
		#200;
		reset = 0;
		#200;
		instruction = 16'b0001111000000111; // Add
		#200; enable = 1; #200; enable = 0;
		#800; 
		instruction = 16'b0010111000000111; // Sub
		#200; enable = 1; #200; enable = 0;
		#800;
		instruction = 16'b0011111000000111; // Not
		#200; enable = 1; #200; enable = 0;
		#800; 
		instruction = 16'b0100111000010001; // And
		#200; enable = 1; #200; enable = 0;
		#800;
		instruction = 16'b0101011001100111; // Or
		#200; enable = 1; #200; enable = 0;
		#800;
		instruction = 16'b0110111001100111; // Xor
		#200; enable = 1; #200; enable = 0;
		#800;
		instruction = 16'b0111111001100111; // Xnor 
		#200; enable = 1; #200; enable = 0;
		#800; 
		instruction = 16'b1000111001100111; // Addi
		#200; enable = 1; #200; enable = 0;
		#800; 
		instruction = 16'b1001111001100111; // Subi
		#200; enable = 1; #200; enable = 0;
		#800; 
		instruction = 16'b1010111001100111; // Mov
		#200; enable = 1; #200; enable = 0;
		#800; 
		instruction = 16'b1011111001100111; // Movi
		#200; enable = 1; #200; enable = 0;
		#800; 
		instruction = 16'b1100111001100111; // Load
		#200; enable = 1; #200; enable = 0;
		#800;
		instruction = 16'b1101111001100111; // Store
		#200; enable = 1; #200; enable = 0;
		#800;
		instruction = 16'b0000111001100111; // Blank
		#200; enable = 1; #200; enable = 0;

	
	end

	always #100 clk = ~clk;

endmodule
