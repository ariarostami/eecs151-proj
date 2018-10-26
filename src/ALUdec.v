// UC Berkeley CS150
// Lab 3, Fall 2014
// Module: ALUdecoder
// Desc:   Sets the ALU operation
// Inputs: opcode: the top 7 bits of the instruction
//         funct: the funct, in the case of r-type instructions
//         add_rshift_type: selects whether an ADD vs SUB, or an SRA vs SRL
// Outputs: ALUop: Selects the ALU's operation
//

`include "Opcode.vh"
`include "ALUop.vh"

module ALUdec(
  input [6:0]       opcode,
  input [2:0]       funct,			//Techniqually func3
  input             add_rshift_type,//func7 but only one bit, don't worry about it
  output reg [3:0]  ALUop
);

  // Implement your ALU decoder here, then delete this comment

  // So the outpuot should be a 4-bit number choosing which operation of ALU
  // needs to be done. (ALUop)
// Special immediate instructions

always @(*) begin
	case (opcode)

		// R-type
		`OPC_ARI_RTYPE: case (funct)
			3'b000: ALUop = (add_rshift_type) ? `ALU_SUB : `ALU_ADD;
			3'b001: ALUop = `ALU_SLL;
			3'b010: ALUop = `ALU_SLT;
			3'b011: ALUop = `ALU_SLTU;
			3'b100: ALUop = `ALU_XOR;
			3'b101: ALUop = (add_rshift_type) ? `ALU_SRA : `ALU_SRL;
			3'b110: ALUop = `ALU_OR;
			3'b111: ALUop = `ALU_AND;
		endcase 

		// I-type
		`OPC_ARI_ITYPE: case (funct)
			3'b000: ALUop = `ALU_ADD; 
			3'b001: ALUop = `ALU_SLL;
			3'b010: ALUop = `ALU_SLT;
			3'b011: ALUop = `ALU_SLTU;
			3'b100: ALUop = `ALU_XOR;
			3'b101: ALUop = (add_rshift_type) ? `ALU_SRA : `ALU_SRL;
			3'b110: ALUop = `ALU_OR;
			3'b111: ALUop = `ALU_AND;
		endcase 

		// Load
		`OPC_LOAD: case (funct)
			3'b000: ALUop = `ALU_ADD;	// lb
			3'b001: ALUop = `ALU_ADD;	// lh
			3'b010: ALUop = `ALU_ADD;	// lw
			3'b100: ALUop = `ALU_ADD;	// lbu
			3'b101: ALUop = `ALU_ADD;	// lhu
		endcase

		// Branch 
		`OPC_BRANCH: case (funct)
			3'b000: ALUop = `ALU_ADD;	// beq
			3'b001: ALUop = `ALU_ADD; 	// bne
			3'b100: ALUop = `ALU_ADD; 	// blt
			3'b101: ALUop = `ALU_ADD; 	// bge
			3'b110: ALUop = `ALU_ADD; 	// bltu
			3'b111: ALUop = `ALU_ADD; 	// bgeu
		endcase 

		// Store 
		`OPC_STORE: case (funct)
			3'b000: ALUop = `ALU_ADD;	// sb
			3'b001: ALUop = `ALU_ADD;	// sh
			3'b010: ALUop = `ALU_ADD;	// sw
		endcase

		// 
		`OPC_JALR: case (funct)
			3'b000: ALUop = `ALU_ADD;	// jalr
		endcase 

		// 
		`OPC_JAL: ALUop = `ALU_ADD;	// jal

		//
		`OPC_AUIPC: ALUop = `ALU_ADD;	// auipc

		//
		`OPC_LUI: ALUop = `ALU_COPY_B; 	// lui, load upper immidiate!?!

		//
		7'b1110011: case (funct)
			3'b001: ALUop = `ALU_ADD;	// CSRRW
			3'b101: ALUop = `ALU_ADD;	// CSRRWI
		endcase 

		default: ALUop = `ALU_XXX;

	endcase 

end 

endmodule
