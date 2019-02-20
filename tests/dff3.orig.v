module dff3 (d, clk, reset, q, qb);
  input d, clk, reset;
  output q, qb;
  reg q;
  assign qb = ~q;

always @(posedge clk)
    q <= d;

endmodule

