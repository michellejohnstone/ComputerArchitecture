module control_unit(
	input [3:0] Op, 
	output RegWrite, output [1:0] AluSrc, output [1:0] AluOp, 
	output Branch, output Continue
	);

	assign RegWrite = ~(Op[3]); 
	assign AluSrc = (Op[3:2] == 3? 2 : Op[3:2]); 
	assign AluOp = Op[1:0]; 
	assign Branch = (Op[3:2] == 2? 1 : 0); 
	assign Continue = (Op[3:2] == 3? 0 : 1);
	
endmodule
