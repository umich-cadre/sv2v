module compare (
  input         [63:0] A,
  input         [63:0] B,
  input  signed [63:0] C,
  input  signed [63:0] D,
  output signed [63:0] Z
);

  wire U1,U2,U3,U4,U5,U6;
  wire W1,W2,W3,W4,W5,W6;
  wire X1,X2,X3,X4,X5,X6;
  wire Y1,Y2,Y3,Y4,Y5,Y6;


  assign U1 = A < B; // uns + uns
  assign W1 = A < C; // uns + sig
  assign X1 = D < B; // sig + uns
  assign Y1 = C < D; // sig + sig

  assign U2 = A <= B; // uns + uns
  assign W2 = A <= C; // uns + sig
  assign X2 = D <= B; // sig + uns
  assign Y2 = C <= D; // sig + sig

  assign U3 = A > B; // uns + uns
  assign W3 = A > C; // uns + sig
  assign X3 = D > B; // sig + uns
  assign Y3 = C > D; // sig + sig

  assign U4 = A >= B; // uns + uns
  assign W4 = A >= C; // uns + sig
  assign X4 = D >= B; // sig + uns
  assign Y4 = C >= D; // sig + sig

  assign U5 = A == B; // uns + uns
  assign W5 = A == C; // uns + sig
  assign X5 = D == B; // sig + uns
  assign Y5 = C == D; // sig + sig

  assign U6 = A != B; // uns + uns
  assign W6 = A != C; // uns + sig
  assign X6 = D != B; // sig + uns
  assign Y6 = C != D; // sig + sig

  assign Z = {U1 , U2 , U3 , U4 , U5 , U6,
    W1 , W2 , W3 , W4 , W5 , W6,
    X1 , X2 , X3 , X4 , X5 , X6,
    Y1 , Y2 , Y3 , Y4 , Y5 , Y6};



endmodule