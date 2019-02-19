// D flip-flop (w/ asynchronous reset)
module dff (clk, reset,
  d, q, qb);
  input  clk  ;
  input  reset;
  input  d    ;
  output q    ;
  output qb   ;

  reg        q;

  assign qb = ~q;

  always @(posedge clk or negedge reset)
    if (~reset)
      q <= 1'b1;
    else
      q <= d;

endmodule