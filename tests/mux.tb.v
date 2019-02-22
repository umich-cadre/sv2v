// Code your testbench here
// or browse Examples
module tb_4to1_mux;

   // Declare internal reg variables to drive design inputs
   // Declare wire signals to collect design output
   // Declare other internal variables used in testbench
   reg [31:0] a;
   reg [31:0] b;
   reg [31:0] c;
   reg [31:0] d;
   wire [31:0] out;
   reg [1:0] sel;
   integer i;

   // Instantiate one of the designs, in this case, we have used the design with case statement
   // Connect testbench variables declared above with those in the design
   mux_4to1_case  mux0 (   .a (a),
                           .b (b),
                           .c (c),
                           .d (d),
                           .sel (sel),
                           .out (out));

   // This initial block is the stimulus
   initial begin
     $monitor ("@@@ [%0t] sel=0x%0h a=0x%0h b=0x%0h c=0x%0h d=0x%0h out=0x%0h", $time, sel, a, b, c, d, out);

      // 1. At time 0, drive random values to a/b/c/d and keep sel = 0
      sel <= 0;
      a <= $random;
      b <= $random;
      c <= $random;
      d <= $random;

      // 2. Change the value of sel after every 5ns
      for (i = 1; i < 20; i=i+1) begin
         sel <= $random;
         #1;
      end

      // 3. After Step2 is over, wait for 5ns and finish simulation
      #5 $finish;
   end
   initial begin
     $dumpvars;
     $dumpfile("dump.vcd");
   end
endmodule