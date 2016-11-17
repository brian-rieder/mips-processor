// File name:   control_unit.vh
// Updated:     12 September 2016
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
  opcode_t    opcode;
  aluop_t     alu_op;
  logic [1:0] ALUsrc, RegDst, JumpSel, MemToReg;
  logic       halt, dWEN, dREN, RegWr, jumpFlush,
              BNE, JAL, LUI, PCsrc, ExtOp, imemREN;
  logic       datomic;
  regbits_t   Rs, Rt, Rd;
  logic [IMM_W-1:0] imm16;
  logic [ADDR_W-1:0] j25;

  // control unit ports
  modport cu (
            // Instruction
    input   imemload,
            // ALU logic outputs
    output  alu_op, ALUsrc, MemToReg, imm16,
            // Memory interaction outputs
            halt, dWEN, dREN,
            // Register File logic outputs
            Rs, Rt, Rd, RegDst, RegWr, shamt,
            // PC logic outputs
            JumpSel, PCsrc, BNE, j25,
            // Datapath logic outputs
            ExtOp, jumpFlush, opcode,
            // Synchronization outputs
            datomic
  );
  // control unit tb
  modport tb (
            // ALU logic outputs
    input   alu_op, ALUsrc, MemToReg, imm16,
            // Memory interaction outputs
            halt, dWEN, dREN,
            // Register File logic outputs
            Rs, Rt, Rd, RegDst, RegWr, shamt,
            // PC logic outputs
            JumpSel, PCsrc, BNE, j25,
            // Datapath logic outputs
            ExtOp, jumpFlush,
            // Instruction
    output   imemload
  );
endinterface

`endif //CONTROL_UNIT_IF_VH
  