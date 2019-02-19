// Testbench
module test;

  reg clk;
  reg reset;
  reg d;
  wire q;
  wire qb;

  // Instantiate design under test
  dff DFF(.clk(clk), .reset(reset),
          .d(d), .q(q), .qb(qb));

  initial begin
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1);
    $monitor("%d d:%0h, q:%0h, qb:%0h",$time, d, q, qb);
  end

  initial begin
    $display("Reset flop.");
    clk = 0;
    reset = 1;
    d = 1'bx;
    // display;
    #1;

    $display("Release reset.");
    d = 1;
    reset = 0;
    // display;
    #1;

    $display("Toggle clk.");
    clk = 1;
    // display;
    #1;

    $display("Toggle clk.");
    clk = 1;
    // display;
    #1;

    $display("Reset flop.");
    clk = 0;
    reset = 1;
    d = 1'bx;
    // display;
    #1;

    $display("Toggle clk.");
    clk = 1;
    // display;
    #1;

  end



endmodule