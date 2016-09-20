// File name:   ID_EX_if.vh
// Updated:     19 September 2016
// Authors:     Brian Rieder 
//              Pooja Kale
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
    input  pcp4_in,       // PC+4 from Control Unit
           rdat1_in,      // rdat1 from Register File
           rdat2_in,      // rdat2 from Register File
           extImm_in,     // Extended Immediate from Extender/Control Unit
           shamt_in,      // shamt from Control Unit
           op_id,         // Operation in the Instruction Decode stage
           alu_op_in,     // ALU operation from Control Unit
           ALUsrc_in,     // ALU source (rdat2/shamt/extImm) from Control Unit
           RegDst_in,     // Register Destination from Control Unit
           JumpSel_in,    // Jump Select (PC+4/jumpAddr/branchaddr/rdat1) from Control Unit
           MemToReg_in,   // MemToReg (dmemload/portO/LUIval/pcp4) from Control Unit
           dREN_in,       // dREN from Control Unit
           dWEN_in,       // dWEN from Control Unit
           halt_in,       // halt from Control Unit
           jumpFlush_in,  // Jump Flush Enable from Control Unit
           PCsrc_in,      // PCsrc (PC+4/branchaddr) from Control Unit
           RegWr_in,      // Reg Write Enable from Control Unit
           BNE_in,        // BNE from Control Unit
           wsel_in,       // wsel (Rd/Rt/31) from Control Unit
           j25_in,        // j-inst address from Control Unit
    output pcp4_out,      // PC+4 to EX/MEM and jumpAddr computation
           rdat1_out,     // rdat1 to ALU port A and jumpSel mux
           rdat2_out,     // rdat2 to ALUsrc mux
           extImm_out,    // Extended Imm to ALUsrc mux and LUIval
           shamt_out,     // shamt to ALUsrc mux
           op_ex,         // Operation in the Execute Stage
           alu_op_out,    // ALU operation to ALU
           ALUsrc_out,    // ALU source (rdat2/shamt/extImm) to ALUsrc mux
           RegDst_out,    // Register Destination to EX/MEM
           JumpSel_out,   // Jump Select (PC+4/jumpAddr/branchaddr/rdat1) to jumpSel mux
           MemToReg_out,  // MemToReg (dmemload/portO/LUIval/pcp4) to EX/MEM
           PCsrc_out,     // PCsrc (PC+4/branchaddr) to branch/PC+4 AND gate
           dREN_out,      // dREN to EX/MEM
           dWEN_out,      // dWEN to EX/MEM
           halt_out,      // halt to EX/MEM
           jumpFlush_out, // Jump Flush Enable to Datapath
           RegWr_out,     // Reg Write Enable to EX/MEM
           BNE_out,       // BNE to BNE mux
           wsel_out,      // wsel to EX/MEM
           j25_out        // j25 to jumpAddr computation
  );

endinterface

`endif //ID_EX_IF_VH
  