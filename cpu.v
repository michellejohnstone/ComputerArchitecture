module cpu(input [9:0] SW, output [9:0] LEDR);
  wire [7:0] pc_in;	// input to PC, output of PC ALU
  wire [7:0] pc_out;	// output of PC, input to instruction_memory
  wire [7:0] alu_result;	// result of main ALU
	wire [15:0] inst; // output of instruction_memory, input to control unit, write reg, read reg 1, read reg 2 & sign extender
	wire [7:0] data1; //outputs register Read1 value, input to main ALU
	wire [7:0] data2; //outputs register Read2 value, input to mux3
	wire [7:0] sign_extender_output; //output of Sign Extender, inputs to mux 3 and mux 2
	wire [7:0] mux3_output; //output of mux3, input to main ALU
	wire [7:0] mux2_output; //output of mux2, input B to ALU_pc

  // Control bits
  wire RegWrite;
  wire [1:0] AluSrc;
  wire Branch;
  wire [1:0] AluOp;
  wire Continue;
  wire Zero;

  wire Mux2_Control;

  // LED outputs
  assign LEDR[3:0] = pc_out[3:0];
  assign LEDR[8:4] = alu_result[4:0];
  assign LEDR[9] = Continue;


	pc (pc_in, SW[9], Continue, pc_out);

	instruction_memory (pc_out, inst);

	control_unit (inst[15:12], RegWrite, AluSrc, AluOp, Branch, Continue);

	register_file (inst[7:4], inst[3:0], inst[11:8], alu_result,
			SW[9], RegWrite, data1, data2);

	sign_extender (inst[3:0], sign_extender_output);

	alu (AluOp, data1, mux3_output, alu_result, Zero); 	//Main ALU

	mux2 (Branch & Zero, 1, sign_extender_output, mux2_output);

	alu (0, pc_out, mux2_output, pc_in, dummy_output); 	//PC ALU

endmodule
