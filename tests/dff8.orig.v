module dff8 (
  input  d    ,
  input  clk  ,
  input  reset,
  output q    ,
  output qb
);

  reg q;

  assign qb = ~q;

  always @(posedge clk)
    if (reset)
      q <= 1'b1; // Active high-reset
    else
      q <= d;

endmodule

