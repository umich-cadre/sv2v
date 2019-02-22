// Testbench
module test;

  reg  clk, a;
  wire out1, out2;

  // Instantiate device under test
  fsm FSM(.clk(clk),
          .a(a),
          .out1(out1),
          .out2(out2));

  initial begin
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1, test);

    $display("time,\ta,\tout1,\tout2");
    $monitor("@@@ [%0d],\t%b,\t%b,\t%b",$time,a,out1,out2);


    clk = 0;
    a = 0;

    toggle_clk;

    a = 1;
    toggle_clk;

    toggle_clk;

    toggle_clk;

    a = 0;
    toggle_clk;
  end

  task toggle_clk;
    begin
      #10 clk = ~clk;
      #10 clk = ~clk;
    end
  endtask

endmodule