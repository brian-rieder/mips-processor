// File name:   IF_ID_if.vh
// Updated:     19 September 2016
// Author:      Brian Rieder 
// Description: Interface file for Instruction Fetch/Instruction Decode latch

`ifndef IF_ID_IF_VH
`define IF_ID_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface IF_ID_if;
  // import types
  import cpu_types_pkg::*;

  word_t      imemload_in, imemload_out, pcp4_in, pcp4_out, 
              inst_pc_if, inst_pc_id, predicted_pc_in, predicted_pc_out;
  logic       enable,      flush;

  // latch ports
  modport if_id (
    input   enable,
            imemload_in,  // Instruction - From Datapath (Caches)
            pcp4_in,      // PC+4 for RS - From Program Counter
            inst_pc_if,
            flush,        // From Datapath
            predicted_pc_in,
    output  imemload_out, // Instruction - To Control Unit
            inst_pc_id,
            pcp4_out,     // PC+4 for RS - To ID/EX Latch
            predicted_pc_out
  );

endinterface

`endif //IF_ID_IF_VH
  