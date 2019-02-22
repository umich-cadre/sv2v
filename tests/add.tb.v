module add_tb ();

  reg         [63:0] A;
  reg         [63:0] B;
  reg  signed [63:0] C;
  reg  signed [63:0] D;
  wire signed [63:0] Z;

  add i_add (
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .Z(Z)
  );

  initial begin
    $monitor ("@@@ [%0t] A:%0d B:%0d C:%0d D:%0d Z:%0d",$time,A, B, C, D, Z);
  end

  initial begin
    # 1;

    for (int i = 0; i < 20; i++) begin
      A = $random;
      B = $random;
      C = $random;
      D = $random;
      # 1;
    end

    A = {64{1'b1}};
    C = {64{1'b1}};
    # 1;

  end


endmodule