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

  word_t      imemload_in, imemload_out, pcp4_in, pcp4_out;

  // latch ports
  modport if_id (
    input   imemload_in,  // Instruction - From Datapath (Caches)
            pcp4_in,      // PC+4 for RS - From Program Counter
            flush,        // From Datapath
    output  imemload_out, // Instruction - To Control Unit
            pcp4_out      // PC+4 for RS - To ID/EX Latch
  );

endinterface

`endif //IF_ID_IF_VH
  