// This version appears to connect reset to the clear input pin of the SEQGEN
// (instead of the clear) based on the reset being active-low

module dff5 (
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
      q <= 1'b0; // Active low-reset
    else
      q <= d;

endmodule

