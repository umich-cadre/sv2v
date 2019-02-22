module sub (
  input         [63:0] A,
  input         [63:0] B,
  input  signed [63:0] C,
  input  signed [63:0] D,
  output signed [63:0] Z
);

  wire [63:0] U,W,X,Y;

  assign U = A - B; // uns + uns
  assign W = A - C; // uns + sig
  assign X = D - B; // sig + uns
  assign Y = C - D; // sig + sig

  assign Z = U - W - X - Y;



endmodule