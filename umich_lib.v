module UMICH_SEQGEN (
  input  clear       ,
  input  preset      ,
  input  next_state  ,
  input  clocked_on  ,
  input  data_in     ,
  input  enable      ,
  input  synch_clear ,
  input  synch_preset,
  input  synch_toggle,
  input  synch_enable,
  output Q
);

  wire Q_latch;
  reg  Q_reg  ;
  assign Q       = synch_enable ? Q_reg : enable ? Q_latch : 0;
  assign Q_latch = (~clear) ? data_in : preset;

  always @(posedge clocked_on or negedge clear) begin
    if(synch_clear)
      Q_reg <= synch_preset;
    else if (~synch_toggle)
      Q_reg <= next_state;
  end
endmodule


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

module UMICH_mux (
  input  DATA1   ,
  input  DATA2   ,
  input  DATA3   ,
  input  CONTROL1,
  input  CONTROL2,
  input  CONTROL3,
  output Z
);

  assign Z = CONTROL1 ? DATA1 : CONTROL2 ? DATA2 : DATA3;

endmodule

module UMICH_BUF (
  input  A,
  output Z
);
  assign Z = A;
endmodule

module SELECT_OP (
  input  DATA1   ,
  input  DATA2   ,
  input  DATA3   ,
  input  DATA4   ,
  input  DATA5   ,
  input  CONTROL1,
  input  CONTROL2,
  input  CONTROL3,
  input  CONTROL4,
  input  CONTROL5,
  output Z
);

  assign Z = CONTROL1 ? DATA1 : CONTROL2 ? DATA2 : DATA3;
endmodule




















