// Zack Fravel
// System Synthesis and Modeling
// Final Project (Step 1)

`timescale 1ns/1ns
module final_alu_tb;

// Inputs
	reg CLK; reg RESET; reg[15:0] BUS_in; 
	reg R1EN; reg R2EN; reg ROEN;
	reg[2:0] OPERATION; reg ENTRIOUT;
// Outputs
	wire [15:0] BUS_out; 
// Declare ALU
	final_alu test (CLK, RESET, BUS_in, R1EN, R2EN, ROEN, OPERATION, ENTRIOUT, BUS_out);

// Testbench
	
	always #10 CLK = ~CLK;		// 20 ns clock cycle (50 MHz)

	initial
	   begin
		CLK = 0;
		RESET = 0;
		BUS_in = 16'h0000;
		R1EN = 0; R2EN = 0; ROEN = 0;
		OPERATION = 3'b000; ENTRIOUT = 0; // Do nothing
	     #20;
		RESET = 1;
	     #20;
		RESET = 0;
	     #40;
		BUS_in = 16'h0001;
		R1EN = 1; R2EN = 0; ROEN = 0;
		OPERATION = 3'b000; ENTRIOUT = 0; // Read 1 into reg 1
	     #18;
		BUS_in = 16'h0001;
		R1EN = 0; #20; R2EN = 1; ROEN = 0;
		OPERATION = 3'b000; ENTRIOUT = 0; // Read 1 into reg 2
	     #20;
		BUS_in = 16'h1111;
		R1EN = 0; R2EN = 0; #20; ROEN = 1;
		OPERATION = 3'b000; ENTRIOUT = 0; // Add reg 1 and reg 2
	     #20;
		BUS_in = 16'h1001;
		R1EN = 0; R2EN = 0; ROEN = 0; #20; // also shows that changing data_in doesn't change anything at this stage
		OPERATION = 3'b000; ENTRIOUT = 1;  // Output Result
	     #20;
		BUS_in = 16'h1011;
		R1EN = 1; R2EN = 0; ROEN = 0;
		OPERATION = 3'b000; ENTRIOUT = 0; // read into reg 1
	     #20;
		BUS_in = 16'h1101;
		R1EN = 0; #20; R2EN = 1; ROEN = 0;
		OPERATION = 3'b001; ENTRIOUT = 0; // read into reg 2
	     #20;
		BUS_in = 16'h1101;
		R1EN = 0; R2EN = 0; #20; ROEN = 1;
		OPERATION = 3'b001; ENTRIOUT = 0; // SUB
	     #20;
		BUS_in = 16'h0000;
		R1EN = 0; R2EN = 0; ROEN = 0; #20;
		OPERATION = 3'b001; ENTRIOUT = 1; // Output	
	     #20;
		OPERATION = 3'b010; ENTRIOUT = 0; ROEN = 1; // NOT
	     #20;
		ENTRIOUT = 1; ROEN = 0;			// Output
	     #20;
		OPERATION = 3'b011; ENTRIOUT = 0; ROEN = 1; // AND
	     #20;
		ENTRIOUT = 1; ROEN = 0;			// Output
	     #20;
		OPERATION = 3'b100; ENTRIOUT = 0; ROEN = 1; // OR
	     #20;
		ENTRIOUT = 1; ROEN = 0;			// Output
	     #20;
		OPERATION = 3'b101; ENTRIOUT = 0; ROEN = 1; // XOR
	     #20;
		ENTRIOUT = 1; ROEN = 0;			// Output
	     #20;
		OPERATION = 3'b110; ENTRIOUT = 0; ROEN = 1; // XNOR
	     #20;
		ENTRIOUT = 1; ROEN = 0;			// Output
	     #20;
		ENTRIOUT = 0; 		// Reset
	     #40;
	        RESET = 1;
	     #20;
		RESET = 0;
	   end

endmodule
