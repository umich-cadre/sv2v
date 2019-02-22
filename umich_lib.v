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
  input  clear       ,
  input  preset      ,
  input  next_state  ,
  input  clocked_on  ,
  input  data_in     ,
  input  enable      ,
  input  synch_clear , // TODO ? - unused
  input  synch_preset, // TODO ? - unused
  input  synch_toggle, // TODO ? - unused
  input  synch_enable,
  output Q
);

  reg Q_latch;
  reg Q_reg  ;
  assign Q = ~synch_enable ? Q_latch :
    clear ? 1'b0 :
    preset ? 1'b1 :
    Q_reg;

  // Latch Behavioral
  always @(enable or preset or clear or data_in) begin
    if(enable) begin
      if(preset)
        Q_latch = 1'b1;
      else if(clear)
        Q_latch = 1'b0;
      else
        Q_latch = data_in;
    end
  end

  // Flop Behavioral
  always @(posedge clocked_on or posedge synch_clear or posedge synch_preset) begin
    if(synch_clear) begin
      Q_reg <= synch_preset;
    end else if (synch_enable) begin
      if(synch_toggle) begin
        Q_reg <= ~Q_reg;
      end else begin
        Q_reg <= next_state;
      end
    end
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
  input  CONTROL1 ,
  input  CONTROL2 ,
  input  CONTROL3 ,
  input  CONTROL4 ,
  input  CONTROL5 ,
  input  CONTROL6 ,
  input  CONTROL7 ,
  input  CONTROL8 ,
  input  CONTROL9 ,
  input  CONTROL10,
  input  CONTROL11,
  input  CONTROL12,
  input  CONTROL13,
  input  CONTROL14,
  input  CONTROL15,
  input  CONTROL16,
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
    64'b0;
endmodule

module UMICH_MUX_OP (
  input  [31:0] D0 ,
  input  [31:0] D1 ,
  input  [31:0] D2 ,
  input  [31:0] D3 ,
  input  [31:0] D4 ,
  input  [31:0] D5 ,
  input  [31:0] D6 ,
  input  [31:0] D7 ,
  input  [31:0] D8 ,
  input  [31:0] D9 ,
  input  [31:0] D10,
  input  [31:0] D11,
  input  [31:0] D12,
  input  [31:0] D13,
  input  [31:0] D14,
  input  [31:0] D15,
  input  [31:0] D16,
  input  [31:0] D17,
  input  [31:0] D18,
  input  [31:0] D19,
  input  [31:0] D20,
  input  [31:0] D21,
  input  [31:0] D22,
  input  [31:0] D23,
  input  [31:0] D24,
  input  [31:0] D25,
  input  [31:0] D26,
  input  [31:0] D27,
  input  [31:0] D28,
  input  [31:0] D29,
  input  [31:0] D30,
  input  [31:0] D31,
  input         S0 ,
  input         S1 ,
  input         S2 ,
  input         S3 ,
  input         S4 ,
  output reg [31:0] Z
);

  always @(*) begin
    case({S4,S3,S2,S1,S0})
      5'd0  : Z = D0;
      5'd1  : Z = D1;
      5'd2  : Z = D2;
      5'd3  : Z = D3;
      5'd4  : Z = D4;
      5'd5  : Z = D5;
      5'd6  : Z = D6;
      5'd7  : Z = D7;
      5'd8  : Z = D8;
      5'd9  : Z = D9;
      5'd10 : Z = D10;
      5'd11 : Z = D11;
      5'd12 : Z = D12;
      5'd13 : Z = D13;
      5'd14 : Z = D14;
      5'd15 : Z = D15;
      5'd16 : Z = D16;
      5'd17 : Z = D17;
      5'd18 : Z = D18;
      5'd19 : Z = D19;
      5'd20 : Z = D20;
      5'd21 : Z = D21;
      5'd22 : Z = D22;
      5'd23 : Z = D23;
      5'd24 : Z = D24;
      5'd25 : Z = D25;
      5'd26 : Z = D26;
      5'd27 : Z = D27;
      5'd28 : Z = D28;
      5'd29 : Z = D29;
      5'd30 : Z = D30;
      5'd31 : Z = D31;
    endcase // {S4,S3,S2,S1,S0}
  end

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











