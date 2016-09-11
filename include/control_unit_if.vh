// File name:   control_unit.vh
// Updated:     9 September 2016
// Author:      Brian Rieder 
// Description: Interface file for Control Unit

`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface control_unit_if;
  // import types
  import cpu_types_pkg::*;

  word_t      imemload, shamt;
  aluop_t     alu_op;
  logic [1:0] ALUsrc, RegDst, JumpSel;
  logic       MemToReg, halt, dWEN, dREN, RegWr,
              BNE, JAL, LUI, PCsrc, ExtOp;
  regbits_t   Rs, Rt, Rd;
  logic [IMM_W-1:0] imm16;

  // control unit ports
  modport cu (
    input   imemload,
            // ALU logic outputs
    output  alu_op, ALUsrc, MemToReg, imm16,
            // Request Unit logic outputs
            halt, dWEN, dREN,
            // Register File logic outputs
            Rs, Rt, Rd, RegDst, RegWr, JAL, LUI, shamt,
            // PC logic outputs
            JumpSel, PCsrc, BNE,
            // Datapath logic outputs
            ExtOp
  );
  // control unit tb
  // modport tb (
  // );
endinterface

`endif //CONTROL_UNIT_IF_VH
  