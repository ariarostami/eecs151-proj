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

//`include "Opcode.vh"
//`include "ALUop.vh"

module ALU(
    input [31:0] A,B,
    input [3:0] ALUop,
    output reg [31:0] out
);

    always @* begin
	case (ALUop)
		4'b0000: begin
			out = A + B;
		end
		default out = 0;
		endcase
	end
endmodule
