// =============================================================================
//   _____ ______ ____   _____ ______ _   _
//  / ____|  ____/ __ \ / ____|  ____| \ | |
// | (___ | |__ | |  | | |  __| |__  |  \| |
//  \___ \|  __|| |  | | | |_ |  __| | . ` |
//  ____) | |___| |__| | |__| | |____| |\  |
// |_____/|______\___\_\\_____|______|_| \_|
//
// =============================================================================


module UMICH_SEQGEN (
  input      clear       ,
  input      preset      ,
  input      next_state  ,
  input      clocked_on  ,
  input      data_in     ,
  input      enable      ,
  input      synch_clear , // TODO ? - unused
  input      synch_preset, // TODO ? - unused
  input      synch_toggle, // TODO ? - unused
  input      synch_enable,
  output reg Q
);

  reg Q_latch;
  reg Q_reg  ;

  always @(*) begin
    if(clear)
      Q = 1'b0;
    else if(preset)
      Q = 1'b1;
    else if(synch_enable)
      Q = Q_reg;
    else if(enable)
      Q = data_in;
  end

  // // Latch Behavioral
  // always @(enable or preset or clear or data_in) begin
  //   if(enable) begin
  //     if(preset)
  //       Q_latch = 1'b1;
  //     else if(clear)
  //       Q_latch = 1'b0;
  //     else
  //       Q_latch = data_in;
  //   end
  // end

  // Flop Behavioral
  always @(posedge clocked_on or posedge clear or posedge preset) begin
    if(clear)
      Q_reg <= 1'b0;
    else if(preset)
      Q_reg <= 1'b1;
    else if(synch_enable)
      Q_reg <= next_state;
  end

endmodule

// =============================================================================
//  ____           _____ _____ _____
// |  _ \   /\    / ____|_   _/ ____|
// | |_) | /  \  | (___   | || |
// |  _ < / /\ \  \___ \  | || |
// | |_) / ____ \ ____) |_| || |____
// |____/_/    \_\_____/|_____\_____|
//
// =============================================================================


module UMICH_NOT (
  input  A,
  output Z
);
  assign Z = ~A;
endmodule

module UMICH_AND2 (
  input  A,
  input  B,
  output Z
);
  assign Z = A & B;
endmodule

module UMICH_AND3 (
  input  A,
  input  B,
  input  C,
  output Z
);
  assign Z = A & B & C;
endmodule

module UMICH_AND4 (
  input  A,
  input  B,
  input  C,
  input  D,
  output Z
);
  assign Z = A & B & C & D;
endmodule

module UMICH_AND5 (
  input  A,
  input  B,
  input  C,
  input  D,
  input  E,
  output Z
);
  assign Z = A & B & C & D & E;
endmodule

module UMICH_OR2 (
  input  A,
  input  B,
  output Z
);
  assign Z = A | B;
endmodule

module UMICH_OR3 (
  input  A,
  input  B,
  input  C,
  output Z
);
  assign Z = A | B | C;
endmodule

module UMICH_OR4 (
  input  A,
  input  B,
  input  C,
  input  D,
  output Z
);
  assign Z = A | B | C | D;
endmodule

module UMICH_XOR2 (
  input  A,
  input  B,
  output Z
);
  assign Z = A ^ B;
endmodule

module UMICH_mux (
  input  DATA1   ,
  input  DATA2   ,
  input  DATA3   ,
  input  CONTROL1,
  input  CONTROL2,
  input  CONTROL3,
  output Z
);

  assign Z = CONTROL1 ? DATA1 :
    CONTROL2 ? DATA2 :
    CONTROL3 ? DATA3 :
    1'b0;

endmodule

module UMICH_BUF (
  input  A,
  output Z
);
  assign Z = A;
endmodule

// Arbitrarily supporting up to 16 for now...
module UMICH_SELECT_OP (
  input  [63:0] DATA1    ,
  input  [63:0] DATA2    ,
  input  [63:0] DATA3    ,
  input  [63:0] DATA4    ,
  input  [63:0] DATA5    ,
  input  [63:0] DATA6    ,
  input  [63:0] DATA7    ,
  input  [63:0] DATA8    ,
  input  [63:0] DATA9    ,
  input  [63:0] DATA10   ,
  input  [63:0] DATA11   ,
  input  [63:0] DATA12   ,
  input  [63:0] DATA13   ,
  input  [63:0] DATA14   ,
  input  [63:0] DATA15   ,
  input  [63:0] DATA16   ,
  input  [63:0] DATA17   ,
  input  [63:0] DATA18   ,
  input  [63:0] DATA19   ,
  input  [63:0] DATA20   ,
  input  [63:0] DATA21   ,
  input  [63:0] DATA22   ,
  input  [63:0] DATA23   ,
  input  [63:0] DATA24   ,
  input  [63:0] DATA25   ,
  input  [63:0] DATA26   ,
  input  [63:0] DATA27   ,
  input  [63:0] DATA28   ,
  input  [63:0] DATA29   ,
  input  [63:0] DATA30   ,
  input  [63:0] DATA31   ,
  input  [63:0] DATA32   ,
  input         CONTROL1 ,
  input         CONTROL2 ,
  input         CONTROL3 ,
  input         CONTROL4 ,
  input         CONTROL5 ,
  input         CONTROL6 ,
  input         CONTROL7 ,
  input         CONTROL8 ,
  input         CONTROL9 ,
  input         CONTROL10,
  input         CONTROL11,
  input         CONTROL12,
  input         CONTROL13,
  input         CONTROL14,
  input         CONTROL15,
  input         CONTROL16,
  input         CONTROL17,
  input         CONTROL18,
  input         CONTROL19,
  input         CONTROL20,
  input         CONTROL21,
  input         CONTROL22,
  input         CONTROL23,
  input         CONTROL24,
  input         CONTROL25,
  input         CONTROL26,
  input         CONTROL27,
  input         CONTROL28,
  input         CONTROL29,
  input         CONTROL30,
  input         CONTROL31,
  input         CONTROL32,
  output [63:0] Z
);

  assign Z = CONTROL1 ? DATA1 :
    CONTROL2 ? DATA2 :
    CONTROL3 ? DATA3 :
    CONTROL4 ? DATA4 :
    CONTROL5 ? DATA5 :
    CONTROL6 ? DATA6 :
    CONTROL7 ? DATA7 :
    CONTROL8 ? DATA8 :
    CONTROL9 ? DATA9 :
    CONTROL10 ? DATA10 :
    CONTROL11 ? DATA11 :
    CONTROL12 ? DATA12 :
    CONTROL13 ? DATA13 :
    CONTROL14 ? DATA14 :
    CONTROL15 ? DATA15 :
    CONTROL16 ? DATA16 :
    CONTROL17 ? DATA17 :
    CONTROL18 ? DATA18 :
    CONTROL19 ? DATA19 :
    CONTROL20 ? DATA20 :
    CONTROL21 ? DATA21 :
    CONTROL22 ? DATA22 :
    CONTROL23 ? DATA23 :
    CONTROL24 ? DATA24 :
    CONTROL25 ? DATA25 :
    CONTROL26 ? DATA26 :
    CONTROL27 ? DATA27 :
    CONTROL28 ? DATA28 :
    CONTROL29 ? DATA29 :
    CONTROL30 ? DATA30 :
    CONTROL31 ? DATA31 :
    CONTROL32 ? DATA31 :
    64'b0;
endmodule

// TODO: MUX implementation does not work. Working around the issue by
//       forcing dc_shell to no use muxes (it will use select_op instead).
module UMICH_MUX_OP (
  input      [31:0] D0 ,
  input      [31:0] D1 ,
  input      [31:0] D2 ,
  input      [31:0] D3 ,
  input      [31:0] D4 ,
  input      [31:0] D5 ,
  input      [31:0] D6 ,
  input      [31:0] D7 ,
  input      [31:0] D8 ,
  input      [31:0] D9 ,
  input      [31:0] D10,
  input      [31:0] D11,
  input      [31:0] D12,
  input      [31:0] D13,
  input      [31:0] D14,
  input      [31:0] D15,
  input      [31:0] D16,
  input      [31:0] D17,
  input      [31:0] D18,
  input      [31:0] D19,
  input      [31:0] D20,
  input      [31:0] D21,
  input      [31:0] D22,
  input      [31:0] D23,
  input      [31:0] D24,
  input      [31:0] D25,
  input      [31:0] D26,
  input      [31:0] D27,
  input      [31:0] D28,
  input      [31:0] D29,
  input      [31:0] D30,
  input      [31:0] D31,
  input             S0 ,
  input             S1 ,
  input             S2 ,
  input             S3 ,
  input             S4 ,
  output reg [31:0] Z
);

  assign Z =
    (S4 &  S3 &  S2 &  S1 &  S0) ? D31 :
    (S4 &  S3 &  S2 &  S1 & ~S0) ? D30 :
    (S4 &  S3 &  S2 & ~S1 &  S0) ? D29 :
    (S4 &  S3 &  S2 & ~S1 & ~S0) ? D28 :
    (S4 &  S3 & ~S2 &  S1 &  S0) ? D27 :
    (S4 &  S3 & ~S2 &  S1 & ~S0) ? D26 :
    (S4 &  S3 & ~S2 & ~S1 &  S0) ? D25 :
    (S4 &  S3 & ~S2 & ~S1 & ~S0) ? D24 :
    (S4 & ~S3 &  S2 &  S1 &  S0) ? D23 :
    (S4 & ~S3 &  S2 &  S1 & ~S0) ? D22 :
    (S4 & ~S3 &  S2 & ~S1 &  S0) ? D21 :
    (S4 & ~S3 &  S2 & ~S1 & ~S0) ? D20 :
    (S4 & ~S3 & ~S2 &  S1 &  S0) ? D19 :
    (S4 & ~S3 & ~S2 &  S1 & ~S0) ? D18 :
    (S4 & ~S3 & ~S2 & ~S1 &  S0) ? D17 :
    (S4 & ~S3 & ~S2 & ~S1 & ~S0) ? D16 :
    (S3 &  S2 &  S1 &  S0) ? D15 :
    (S3 &  S2 &  S1 & ~S0) ? D14 :
    (S3 &  S2 & ~S1 &  S0) ? D13 :
    (S3 &  S2 & ~S1 & ~S0) ? D12 :
    (S3 & ~S2 &  S1 &  S0) ? D11 :
    (S3 & ~S2 &  S1 & ~S0) ? D10 :
    (S3 & ~S2 & ~S1 &  S0) ? D9 :
    (S3 & ~S2 & ~S1 & ~S0) ? D8 :
    (S2 &  S1 &  S0) ? D7 :
    (S2 &  S1 & ~S0) ? D6 :
    (S2 & ~S1 &  S0) ? D5 :
    (S2 & ~S1 & ~S0) ? D4 :
    (S1 &  S0) ? D3 :
    (S1 & ~S0) ? D2 :
    (S0) ? D1 :
    D0;

endmodule

// =============================================================================
//   _______     ___   _ _______ _    _ ______ _______ _____ _____
//  / ____\ \   / / \ | |__   __| |  | |  ____|__   __|_   _/ ____|
// | (___  \ \_/ /|  \| |  | |  | |__| | |__     | |    | || |
//  \___ \  \   / | . ` |  | |  |  __  |  __|    | |    | || |
//  ____) |  | |  | |\  |  | |  | |  | | |____   | |   _| || |____
// |_____/   |_|  |_| \_|  |_|  |_|  |_|______|  |_|  |_____\_____|
//
// =============================================================================

module UMICH_LT_UNS_OP (
  input  unsigned [63:0] A,
  input  unsigned [63:0] B,
  output unsigned [63:0] Z
);
  assign Z = A < B;
endmodule

module UMICH_LT_TC_OP (
  input  signed [63:0] A,
  input  signed [63:0] B,
  output signed [63:0] Z
);
  assign Z = A < B;
endmodule

module UMICH_LEQ_UNS_OP (
  input  unsigned [63:0] A,
  input  unsigned [63:0] B,
  output unsigned [63:0] Z
);
  assign Z = A <= B;
endmodule

module UMICH_LEQ_TC_OP (
  input  signed [63:0] A,
  input  signed [63:0] B,
  output signed [63:0] Z
);
  assign Z = A <= B;
endmodule

module UMICH_GT_UNS_OP (
  input  unsigned [63:0] A,
  input  unsigned [63:0] B,
  output unsigned [63:0] Z
);
  assign Z = A > B;
endmodule

module UMICH_GT_TC_OP (
  input  signed [63:0] A,
  input  signed [63:0] B,
  output signed [63:0] Z
);
  assign Z = A > B;
endmodule

module UMICH_GEQ_UNS_OP (
  input  unsigned [63:0] A,
  input  unsigned [63:0] B,
  output unsigned [63:0] Z
);
  assign Z = A >= B;
endmodule

module UMICH_GEQ_TC_OP (
  input  signed [63:0] A,
  input  signed [63:0] B,
  output signed [63:0] Z
);
  assign Z = A >= B;
endmodule

module UMICH_EQ_UNS_OP (
  input  unsigned [63:0] A,
  input  unsigned [63:0] B,
  output unsigned        Z
);
  assign Z = (A == B);
endmodule

module UMICH_EQ_TC_OP (
  input  signed [63:0] A,
  input  signed [63:0] B,
  output signed        Z
);
  assign Z = (A == B);
endmodule

module UMICH_NE_UNS_OP (
  input  unsigned [63:0] A,
  input  unsigned [63:0] B,
  output unsigned        Z
);
  assign Z = (A != B);
endmodule

module UMICH_NE_TC_OP (
  input  signed [63:0] A,
  input  signed [63:0] B,
  output signed        Z
);
  assign Z = (A != B);
endmodule

module UMICH_ADD_UNS_OP (
  input  unsigned [63:0] A,
  input  unsigned [63:0] B,
  output unsigned [63:0] Z
);
  assign Z = A + B;
endmodule

module UMICH_ADD_TC_OP (
  input  signed [63:0] A,
  input  signed [63:0] B,
  output signed [63:0] Z
);
  assign Z = A + B;
endmodule

module UMICH_SUB_UNS_OP (
  input  unsigned [63:0] A,
  input  unsigned [63:0] B,
  output unsigned [63:0] Z
);
  assign Z = A - B;
endmodule

module UMICH_SUB_TC_OP (
  input  signed [63:0] A,
  input  signed [63:0] B,
  output signed [63:0] Z
);
  assign Z = A - B;
endmodule

module UMICH_MULT_UNS_OP (
  input  unsigned [63:0] A,
  input  unsigned [63:0] B,
  output unsigned [63:0] Z
);
  assign Z = A * B;
endmodule

module UMICH_MULT_TC_OP (
  input  signed [63:0] A,
  input  signed [63:0] B,
  output signed [63:0] Z
);
  assign Z = A * B;
endmodule

// Arithmetic shift unsigned unsigned op
module UMICH_ASH_UNS_UNS_OP (
  input  unsigned [63:0] A ,
  input  unsigned [63:0] SH,
  output unsigned [63:0] Z
);
  assign Z = A << SH;
endmodule











