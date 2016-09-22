// File name:   hazard_unit_if.vh
// Updated:     21 September 2016
// Authors:     Brian Rieder 
//              Pooja Kale
// Description: Interface file for Hazard Unit

`ifndef HAZARD_UNIT_IF_VH
`define HAZARD_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface hazard_unit_if;
  // import types
  import cpu_types_pkg::*;

  // Inputs
  logic ihit, dhit; // from datapath
  regbits_t Rs, Rd; // from control unit
  regbits_t idex_wsel, exmem_wsel; // from latches
  logic memop_flag; // from latches
  opcode_t id_op; // from control unit for optimization

  // Outputs
  logic pcWEN; // to program counter
  logic IFID_enable,  IFID_flush;
  logic IDEX_enable,  IDEX_flush;
  logic EXMEM_enable, EXMEM_flush;
  logic MEMWB_enable;

  // control unit ports
  modport hazard_unit (
    input  ihit,      dhit,
           Rs,        Rd,
           idex_wsel, exmem_wsel,
           memop_flag,
           id_op,
    output pcWEN,
           IFID_enable,  IFID_flush,
           IDEX_enable,  IDEX_flush,
           EXMEM_enable, EXMEM_flush,
           MEMWB_enable
  );

endinterface

`endif //HAZARD_UNIT_IF_VH
  