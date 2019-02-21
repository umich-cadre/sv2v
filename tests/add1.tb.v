module add1_tb (
  );

reg [63:0] A;
reg [63:0] B;
wire [63:0] Z;

add1 i_add1 (
 .A(A),
 .B(B),
 .Z(Z));

initial begin
  $monitor ("@@@ [%0t] A:%0b B:%0b Z:%0b",$time,A, B, Z);
end

initial begin
 # 1;
 A = 5;
 B = 10;
 # 1;
 # 1;
 A = -5;
 B = 10;

 # 1;
 # 1;
 A = -5;
 B = 10;

 # 1;
 # 1;
 A = {64{1'b1}};
 B = 10;

 # 1;
 # 1;

end


endmodule