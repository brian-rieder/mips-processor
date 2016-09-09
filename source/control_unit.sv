// File name:   control_unit.sv
// Updated:     8 September 2016
// Author:      Brian Rieder 
// Description: Brains of the system

// interface include
`include "control_unit_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  control_unit_if.cu cuif
);

  output logic [AOP_W-1:0]  alu_op,
  output logic LUI,
  output logic dWEN,
  output logic dREN,
  output logic ExtOp,
  output logic [1:0] JAL,
  output logic [1:0] RegDst,
  output logic RegWr,
  output logic JumpInstr,
  output logic PCsrc,
  output logic MemToReg,
  output logic [1:0] ALUsrc

  // Instruction Deconstruction
  opcode_t opcode;
  regbits_t rs;
  regbits_t rt;
  regbits_t rd;
  logic [IMM_W-1:0] imm16;
  logic [SHAM_W-1:0] shamt;
  logic [ADDR_W-1:0] jaddr;

  // Request Unit
  always_comb begin

  end

endmodule
