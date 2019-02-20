// This version appears to connect reset to the preset input pin of the SEQGEN
// (instead of the clear) based on the reset being active-high

module dff2 (
  input  d    ,
  input  clk  ,
  input  reset,
  output q    ,
  output qb
);

  reg q;

  assign qb = ~q;

  always @(posedge clk or negedge reset)
    if (~reset)
      q <= 1'b1; // Active high-reset
    else
      q <= d;

endmodule

