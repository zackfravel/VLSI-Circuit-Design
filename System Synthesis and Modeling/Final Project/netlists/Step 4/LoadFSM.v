// Zack Fravel
// System Synthesis and Modeling
// Final Project (Step 4)

module Load_FSM(clk, reset, start, MFC, PCinc, Ri1Out, Ri2Out, Ri3Out, Ri4Out, MARin, MDRread, 
		memEn, memOp, MDRout, Rj1In, Rj2In, Rj3In, Rj4In, p1, p2, finish);

// Port Declartaion

input clk; input reset; input start; input MFC; input[5:0] p1; input[5:0] p2;

output reg PCinc; output reg MARin; output reg MDRread; 
output reg Ri1Out; output reg Ri2Out; output reg Ri3Out; output reg Ri4Out; 
output reg memEn; output reg memOp; output reg MDRout; 
output reg Rj1In; output reg Rj2In; output reg Rj3In; output reg Rj4In; output reg finish;

reg[2:0] current_state, next_state;			

// Set Parameters for State Signals

parameter init = 4'b0000, one = 4'b0001, two = 4'b0010, three = 4'b0011, 
	four = 4'b0100, five = 4'b0101, six = 4'b0110, 	
	seven = 4'b0111, eight = 4'b1000, nine = 4'b1001, ten = 4'b1010;


// Architecture

always @(posedge clk or posedge reset)			// Current State Transition
begin
   if(reset)
	current_state <= init;
   else
	current_state <= next_state;
end


always @(current_state or start or MFC)			// Next State Logic
begin

   case(current_state)

   init: begin
	 	if(start)
	   		next_state <= one;
		else
			next_state <= init;
         end

   one:    begin next_state <= two; end
   two:    begin 
		if(MFC)
			next_state <= three;
		else 
			next_state <= two; 
	   end
   three:  begin next_state <= four; end
   four:   begin next_state <= five; end
   five:   begin next_state <= six; end
   six:    begin next_state <= init; end
   default:begin next_state <= init; end

   endcase
end


always @(current_state)					// Output Logic
begin

   case (current_state)

   init:  begin 
		PCinc = 0; MARin = 0; Ri1Out = 0; Ri2Out = 0; Ri3Out = 0; Ri4Out = 0; 
		MDRread = 0; memEn = 0; memOp = 0; MDRout = 0; 
		Rj1In = 0; Rj2In = 0; Rj3In = 0; Rj4In = 0; finish = 0;
	  end
   one:   begin  
		PCinc = 1; MARin = 1; 
		case (p1)
			6'b000001: begin Ri1Out = 1; Ri2Out = 0; Ri3Out = 0; Ri4Out = 0; end
			6'b000010: begin Ri2Out = 1; Ri1Out = 0; Ri3Out = 0; Ri4Out = 0; end
			6'b000011: begin Ri3Out = 1; Ri2Out = 0; Ri1Out = 0; Ri4Out = 0; end
			default  : begin Ri4Out = 1; Ri2Out = 0; Ri3Out = 0; Ri1Out = 0; end
		endcase 
		MDRread = 0; memEn = 0; memOp = 0; MDRout = 0; 
		Rj1In = 0; Rj2In = 0; Rj3In = 0; Rj4In = 0; finish = 0;
	  end
   two:   begin 
		memEn = 1; memOp = 1;
		case (p1)
			6'b000001: begin Ri1Out = 0; Ri2Out = 0; Ri3Out = 0; Ri4Out = 0; end
			6'b000010: begin Ri2Out = 0; Ri1Out = 0; Ri3Out = 0; Ri4Out = 0; end
			6'b000011: begin Ri3Out = 0; Ri2Out = 0; Ri1Out = 0; Ri4Out = 0; end
			default  : begin Ri4Out = 0; Ri2Out = 0; Ri3Out = 0; Ri1Out = 0; end
		endcase 
		PCinc = 0; MARin = 0; 
		MDRread = 0; MDRout = 0; 
		Rj1In = 0; Rj2In = 0; Rj3In = 0; Rj4In = 0; finish = 0;
	  end
   three: begin 
		MDRread = 1;
		PCinc = 0; MARin = 0; Ri1Out = 0; Ri2Out = 0; Ri3Out = 0; Ri4Out = 0; 
		memEn = 1; memOp = 1; MDRout = 0; 
		Rj1In = 0; Rj2In = 0; Rj3In = 0; Rj4In = 0; finish = 0;
	  end
   four:  begin  
		MDRout = 1; 
		case(p2)
			6'b000001: begin Rj1In = 1; Rj2In = 0; Rj3In = 0; Rj4In = 0; end
			6'b000010: begin Rj2In = 1; Rj1In = 0; Rj3In = 0; Rj4In = 0; end
			6'b000011: begin Rj3In = 1; Rj2In = 0; Rj1In = 0; Rj4In = 0; end
			default  : begin Rj4In = 1; Rj2In = 0; Rj3In = 0; Rj1In = 0; end
		endcase
		PCinc = 0; MARin = 0; Ri1Out = 0; Ri2Out = 0; Ri3Out = 0; Ri4Out = 0; 
		MDRread = 0; memEn = 0; memOp = 0;
		finish = 0;
	  end
   five:  begin  
		finish = 1;
		case(p2)
			6'b000001: begin Rj1In = 0; Rj2In = 0; Rj3In = 0; Rj4In = 0; end
			6'b000010: begin Rj2In = 0; Rj1In = 0; Rj3In = 0; Rj4In = 0; end
			6'b000011: begin Rj3In = 0; Rj2In = 0; Rj1In = 0; Rj4In = 0; end
			default  : begin Rj4In = 0; Rj2In = 0; Rj3In = 0; Rj1In = 0; end
		endcase
		PCinc = 0; MARin = 0; Ri1Out = 0; Ri2Out = 0; Ri3Out = 0; Ri4Out = 0; 
		MDRread = 0; memEn = 0; memOp = 0; MDRout = 0; 
	  end
   six:   begin  
		PCinc = 0; MARin = 0; Ri1Out = 0; Ri2Out = 0; Ri3Out = 0; Ri4Out = 0; 
		MDRread = 0; memEn = 0; memOp = 0; MDRout = 0; 
		Rj1In = 0; Rj2In = 0; Rj3In = 0; Rj4In = 0; finish = 0;
	  end

   endcase

end

endmodule
