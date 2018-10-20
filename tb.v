`timescale 1ns/100ps 

module tb2();
	//initialize
	reg clk;
	wire [31:0] A; 
	wire [31:0] B;
	wire [31:0] out_test;
	reg  [3:0] ALUop;

	ALU dut(.A(A), .B(B), .ALUop(ALUop), .out(out_test));


	//parser 
	parameter SIZE = 2'd1;

	reg [0:SIZE] index; 
	initial index = 0;
	reg  [31:0] out_correct_array [SIZE:0];
	wire [31:0] out_correct;
	reg  [31:0] a_array [SIZE:0];
	reg  [31:0] b_array [SIZE:0];

	initial begin
    $readmemb("ref.txt", out_correct_array);
    $readmemb("A.txt", a_array);
    $readmemb("B.txt", b_array);
	end

	//clock gen
	initial clk = 0;
	always 
		#1 clk <= !clk;


	//input loading 
	assign A = a_array[index];
	assign B = b_array[index];
	assign out_correct = out_correct_array[index];

	//execution 
	initial begin
	//$vcdpluson;
	@(posedge  clk)  begin
		ALUop <= 4'b0000;
		end
	repeat (SIZE+1) @(posedge clk);
	//vcdplusoff;
	$finish;
	end

	always @(negedge clk) begin
    $display($time, ": Out should be %d, got %d", out_correct, out_test);
    index <= index + 1;
	end
endmodule