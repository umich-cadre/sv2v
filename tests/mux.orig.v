// Code your design here
module mux ( input [31:0] a,                 // 4-bit input called a
                       input [31:0] b,                 // 4-bit input called b
                       input [31:0] c,                 // 4-bit input called c
                       input [31:0] d,                 // 4-bit input called d
                       input [1:0] sel,               // input sel used to select between a,b,c,d
                       output reg [31:0] out);             // 4-bit output based on input sel

   // This always block gets executed whenever a/b/c/d/sel changes value
   // When that happens, based on value in sel, output is assigned to either a/b/c/d
   always @ (a or b or c or d or sel) begin
      case (sel) // synopsys infer_mux
         2'b00 : out <= a;
         2'b01 : out <= b;
         2'b10 : out <= c;
         2'b11 : out <= d;
      endcase
   end
endmodule