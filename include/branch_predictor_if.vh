// File name:   branch_predictor_if.vh
// Updated:     4 October 2016
// Authors:     Brian Rieder 
//              Pooja Kale
// Description: Interface file for Branch Predictor

`ifndef BRANCH_PREDICTOR_IF
`define BRANCH_PREDICTOR_IF

// all types
`include "cpu_types_pkg.vh"

// Struct for each branch table entry
typedef struct packed {
   logic valid;        // T/F - will need to be two bits (state indicator) with two bit saturating
   logic [1:0] idx;    // Lower order two bits of WORD value of instruction
   logic [27:0] tag;   // bits {31:4} of the PC
   logic [31:0] value; // Predicted PC
} branchentry_t;

interface branch_predictor_if;
  // import types
  import cpu_types_pkg::*;

  // Inputs
  word_t curr_pc;    // PC from PC block
  word_t update_pc;  // PC from EX stage (only relevant with branches in EX)
  logic  invalidate; // asserted when flushing on a branch

  // Outputs
  word_t bp_pc;

  // control unit ports
  modport bp (
    input  curr_pc, update_pc,
    output bp_pc
  );
    // modport tb (
  // );

endinterface

`endif //BRANCH_PREDICTOR_IF
  
