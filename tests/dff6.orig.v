module dff6 (
  input  d    ,
  input  clk  ,
  input  reset,
  output q    ,
  output qb
);

  reg q;

  assign qb = ~q;

  always @(posedge clk)
    if (~reset)
      q <= 1'b0; // Active low-reset
    else
      q <= d;

endmodule

