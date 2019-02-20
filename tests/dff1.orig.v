// This version appears to connect reset to the clear input pin of the SEQGEN
// based on the reset being active-low

module dff1 (
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
      q <= 1'b0; // Active low-reset
    else
      q <= d;

endmodule

