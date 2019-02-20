// Testbench
module test ();

  reg  clk  ;
  reg  reset;
  reg  d    ;
  wire q    ;
  wire qb   ;

  reg [5:0] delay;
  integer i;

  // Instantiate design under test
  dff1 DFF (
    .clk  (clk  ),
    .reset(reset),
    .d    (d    ),
    .q    (q    ),
    .qb   (qb   )
  );

  initial begin
    $monitor ("@@@ [%0t] clk:%0b reset:%0b d:%0b, q:%0b, qb:%0b",$time,clk, reset, d, q, qb);
  end

  always
    #5 clk = ! clk;

  initial begin
    clk = 0;

    delay = $random; #(delay);

    $display("Reset flop.");
    reset = 1;
    d = 1'bx;
    delay = $random; #(delay);

    $display("Release reset.");
    d = 1;
    reset = 0;
    delay = $random; #(delay);


    $display("Reset flop.");
    reset = 1;
    delay = $random; #(delay);

    $display("Release reset.");
    reset = 0;
    delay = $random; #(delay);



    for (i = 0; i < 5; i=i+1) begin
      delay = $random;
      #(delay) d <= i;
    end

    $display("End.");
    $finish;

  end



endmodule