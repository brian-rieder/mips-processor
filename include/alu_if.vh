// File name:   alu_if.vh
// Updated:     29 August 2016
// Author:      Brian Rieder 
// Description: Interface file for ALU

`ifndef ALU_IF_VH
`define ALU_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface alu_if;
  // import types
  import cpu_types_pkg::*;

  word_t    port_a, port_b, port_o;
  aluop_t   alu_op;
  logic     v_flag, n_flag, z_flag;

  // alu ports
  modport alu (
    input   port_a, port_b, alu_op,
    output  port_o, v_flag, n_flag, z_flag
  );
  // register file tb
  modport tb (
    input   port_o, v_flag, n_flag, z_flag,
    output  port_a, port_b, alu_op
  );
endinterface

`endif //ALU_IF_VH
  