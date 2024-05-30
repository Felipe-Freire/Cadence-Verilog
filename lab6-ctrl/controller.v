module controller
(
  input  wire       zero,
  input  wire [2:0] phase,
  input  wire [2:0] opcode,
  output reg        sel,
  output reg        rd,
  output reg        ld_ir,
  output reg        halt,
  output reg        inc_pc,
  output reg        ld_ac,
  output reg        wr,
  output reg        ld_pc,
  output reg        data_e
);

  localparam HLT=0, SKZ=1, ADD=2, AND=3, XOR=4, LDA=5, STO=6, JMP=7;
  localparam INST_ADDR=0, INST_FETCH=1, INST_LOAD=2, IDLE=3, OP_ADDR=4, OP_FETCH=5, ALU_OP=6, STORE=7;

  reg INTER_ALUOP, INTER_HALT, INTER_JMP, INTER_SKZ, INTER_STO;

  always @*
    begin
      INTER_ALUOP = ( opcode == ADD || opcode == AND || opcode == XOR || opcode == LDA );
      INTER_HALT  = ( opcode == HLT );
      INTER_SKZ   = ( opcode == SKZ && zero );
      INTER_JMP   = ( opcode == JMP );
      INTER_STO   = ( opcode == STO );
      case ( phase )
        INST_ADDR  : begin sel=1; rd=0; ld_ir=0; halt=0; inc_pc=0; ld_ac=0; ld_pc=0; wr=0; data_e=0; end
        INST_FETCH : begin sel=1; rd=1; ld_ir=0; halt=0; inc_pc=0; ld_ac=0; ld_pc=0; wr=0; data_e=0; end
        INST_LOAD  : begin sel=1; rd=1; ld_ir=1; halt=0; inc_pc=0; ld_ac=0; ld_pc=0; wr=0; data_e=0; end
        IDLE       : begin sel=1; rd=1; ld_ir=1; halt=0; inc_pc=0; ld_ac=0; ld_pc=0; wr=0; data_e=0; end
        OP_ADDR    : begin sel=0; rd=0; ld_ir=0; halt=INTER_HALT; inc_pc=1; ld_ac=0; ld_pc=0; wr=0; data_e=0; end
        OP_FETCH   : begin sel=0; rd=INTER_ALUOP; ld_ir=0; halt=0; inc_pc=0; ld_ac=0; ld_pc=0; wr=0; data_e=0; end
        ALU_OP     : begin sel=0; rd=INTER_ALUOP; ld_ir=0; halt=0; inc_pc=INTER_SKZ; ld_ac=0; ld_pc=INTER_JMP; wr=0; data_e=INTER_STO; end
        STORE      : begin sel=0; rd=INTER_ALUOP; ld_ir=0; halt=0; inc_pc=0; ld_ac=INTER_ALUOP; ld_pc=INTER_JMP; wr=INTER_STO; data_e=INTER_STO; end
      endcase
    end
endmodule
