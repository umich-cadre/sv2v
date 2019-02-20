module dff1 (d, clk, reset, q, qb);
  input d, clk, reset;
  output q, qb;

  reg q;
  assign qb = ~q;

always @(posedge clk or negedge reset)
  if (~reset)
    q <= 1'b0;
  else
    q <= d;
endmodule

