module dff4 (d, clk, reset, q, qb);
  input d, clk, reset;
  output q, qb;
  reg q;
  assign qb = ~q;

always @(posedge clk or posedge reset)
  if (reset)
    q <= 1'b1;
  else
    q <= d;
endmodule

