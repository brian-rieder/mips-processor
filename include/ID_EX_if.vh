// File name:   ID_EX_if.vh
// Updated:     19 September 2016
// Author:      Brian Rieder 
// Description: Interface file for Instruction Decode/Execute Latch

`ifndef ID_EX_IF_VH
`define ID_EX_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface ID_EX_if;
  // import types
  import cpu_types_pkg::*;

  // Inputs
  word_t      pcp4_in,
  rdat1_in, rdat2_in, extImm_in, shamt_in;
  opcode_t    op_id;
  aluop_t     alu_op_in;
  logic [1:0] ALUsrc_in, RegDst_in, JumpSel_in, MemToReg_in;
  logic       dREN_in, dWEN_in, halt_in, jumpFlush_in, PCsrc_in, RegWr_in, BNE_in;
  regbits_t   wsel_in;
  logic [ADDR_W-1:0] j25_in;

  // Outputs
  word_t      pcp4_out, rdat1_out, rdat2_out, extImm_out, shamt_out;
  opcode_t    op_ex;
  aluop_t     alu_op_out;
  logic [1:0] ALUsrc_out, RegDst_out, JumpSel_out, MemToReg_out, PCsrc_out;
  logic       dREN_out, dWEN_out, halt_out, jumpFlush_out, RegWr_out, BNE_out;
  regbits_t   wsel_out;
  logic [ADDR_W-1:0] j25_out;

  // control unit ports
  modport id_ex (
    input  pcp4_in, // PC+4 from 
           rdat1_in, 
           rdat2_in,
           extImm_in,
           shamt_in,
           op_id,
           alu_op_in,
           ALUsrc_in,
           RegDst_in,
           JumpSel_in,
           MemToReg_in,
           dREN_in,
           dWEN_in,
           halt_in,
           jumpFlush_in,
           PCsrc_in,
           RegWr_in,
           BNE_in,
           wsel_in,
           j25_in,
    output pcp4_out, 
           rdat1_out, 
           rdat2_out, 
           extImm_out, 
           shamt_out, 
           op_ex, 
           alu_op_out, 
           ALUsrc_out, 
           RegDst_out, 
           JumpSel_out, 
           MemToReg_out, 
           PCsrc_out, 
           dREN_out, 
           dWEN_out, 
           halt_out, 
           jumpFlush_out, 
           RegWr_out, 
           BNE_out, 
           wsel_out, 
           j25_out
  );

endinterface

`endif //ID_EX_IF_VH
  