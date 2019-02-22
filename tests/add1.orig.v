module add1 (
  input  [63:0] A,
  input  [63:0] B,
  input  signed [63:0] C,
  input  signed [63:0] D,
  output signed [63:0] Z
);

  // reg signed [63:0] C = -2;
  // reg signed [63:0] D = 4;
  // reg signed [63:0] D = 1;
  wire [63:0] W,X,Y;

  assign U = A + B; // uns + uns
  assign W = A + C; // uns + sig
  assign X = D + B; // sig + uns
  assign Y = C + D; // sig + sig

  assign Z = U + W + X + Y;
  //
  // assign Z = A + B;
  // assign Z = A + D;
  // assign Y = A + B;

  // assign Z = C + D;


endmodule