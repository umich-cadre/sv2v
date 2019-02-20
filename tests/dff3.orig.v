// This version does not support reset

module dff3 (
  input  d    ,
  input  clk  ,
  input  reset,
  output q    ,
  output qb
);

  reg q;

  assign qb = ~q;

  always @(posedge clk)
      q <= d;

endmodule

