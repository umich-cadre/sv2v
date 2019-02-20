// This version appears to connect reset to the clear input pin of the SEQGEN
// based on the reset being active-high

module dff4 (
  input  d    ,
  input  clk  ,
  input  reset,
  output q    ,
  output qb
);

  reg q;

  assign qb = ~q;

  always @(posedge clk or posedge reset)
    if (reset)
      q <= 1'b1; // Active high-reset
    else
      q <= d;

endmodule

