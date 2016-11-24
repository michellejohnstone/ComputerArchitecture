module mux4Variable(Control, A, B, C, D, Y);
  parameter WIDTH = 2;
  input [1:0] Control;
  input [WIDTH-1:0] A;
  input [WIDTH-1:0] B;
  input [WIDTH-1:0] C;
  input [WIDTH-1:0] D;
  output [WIDTH-1:0] Y;
  
  wire [1:0] muxABout;
  wire [1:0] muxCDout;
  
  mux2Variable #(.WIDTH(WIDTH)) muxAB(Control[0], A, B, muxABout);
  mux2Variable #(.WIDTH(WIDTH)) muxCD(Control[0], C, D, muxCDout);
  mux2Variable #(.WIDTH(WIDTH)) muxOut(Control[1], muxABout, muxCDout, Y);
endmodule
