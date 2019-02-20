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
  assign Q       = ~synch_enable ? Q_latch :
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
  always @(posedge clocked_on or posedge clear or posedge preset) begin
    if(clear)
      Q_reg <= 1'b0;
    else if(preset)
      Q_reg <= 1'b1;
    else
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
module SELECT_OP (
  input  DATA1    ,
  input  DATA2    ,
  input  DATA3    ,
  input  DATA4    ,
  input  DATA5    ,
  input  DATA6    ,
  input  DATA7    ,
  input  DATA8    ,
  input  DATA9    ,
  input  DATA10   ,
  input  DATA11   ,
  input  DATA12   ,
  input  DATA13   ,
  input  DATA14   ,
  input  DATA15   ,
  input  DATA16   ,
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
  output Z
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
             1'b0;
endmodule




















