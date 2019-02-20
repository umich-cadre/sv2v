module tb_latch;
  // Declare variables that can be used to drive values to the design
  reg d;
  reg en;
  reg rstn;
  reg [2:0] delay;
  reg [1:0] delay2;
  integer i;

  // Instantiate design and connect design ports with TB signals
  dlatch1  dl0 ( .d (d),
    .en (en),
    .rstn (rstn),
    .q (q));

  // This initial block forms the stimulus to test the design
  initial begin
    $monitor ("@@@ [%0t] en=%0b d=%0b q=%0b", $time, en, d, q);

    #10

      // 1. Initialize testbench variables
      d <= 0;
    en <= 0;
    rstn <= 0;

    // 2. Release reset
    #10 rstn <= 1;

    // 3. Randomly change d and enable
    for (i = 0; i < 5; i=i+1) begin
      delay = $random;
      delay2 = $random;
      #(delay2) en <= ~en;
      #(delay) d <= i;
    end
  end
endmodule