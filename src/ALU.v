`timescale 1ns/100ps 
// UC Berkeley CS152
// Lab 3, Fall 2014
// Module: ALU.v
// Desc:   32-bit ALU for the MIPS150 Processor
// Inputs: 
//    A: 32-bit value
//    B: 32-bit value
//    ALUop: Selects the ALU's operation 
// 						
// Outputs:
//    Out: The chosen function mapped to A and B.

`include "Opcode.vh"
`include "ALUop.vh"



module ALU(
    input [31:0] A,B,
    input [3:0] ALUop,
    output reg [31:0] out
);

wire signed [31:0] A_signed, B_signed;
assign A_signed = A;
assign B_signed = B;

    always @* begin
    	//$display("A_signed and A are",A_signed, A);
    	//$display("B_signed and B are",B_signed, B);

	case (ALUop)
		`ALU_ADD:	out <= A + B; 	 
		`ALU_SUB:	out <= A - B;
		`ALU_AND:	out <= A & B;
		`ALU_OR:	out = A | B;
		`ALU_XOR:	out = A ^ B;
		`ALU_SLT:	out = (A_signed < B_signed) ? 32'd1 : 32'd0;
		`ALU_SLTU:  out = (A < B) ? 32'd1 : 32'd0;
		`ALU_SLL:	out = A << B;
		`ALU_SRA:	out = A_signed >> B;	// Do we have to count for the case if B is negative.
		`ALU_SRL:	out = A >> B;
		`ALU_COPY_B: out = B;
		`ALU_XXX:	out = out;

		default out = out;
		endcase

	end
endmodule
