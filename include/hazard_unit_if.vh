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
  logic BranchFlush; // from datapath
  logic JumpFlush; // from ID/EX latch
  logic MEMWB_RegWr, EXMEM_RegWr; // from latches
  regbits_t CU_Rs, CU_Rt; // rs and rt from CU
  regbits_t IDEX_Rs, IDEX_Rt; // rs and rt from idex
  opcode_t ex_op;
  opcode_t mem_op; // from control unit for optimization

  //forwarding logic 
  logic [1:0] forwardA; 
  logic [1:0] forwardB; 
  regbits_t EXMEM_wsel; 
  regbits_t MEMWB_wsel; 



  // Outputs
  logic pcWEN; // to program counter
  logic IFID_enable,  IFID_flush;
  logic IDEX_enable,  IDEX_flush;
  logic EXMEM_enable, EXMEM_flush;
  logic MEMWB_enable;


  // control unit ports
  modport hu (
    input  ihit,  dhit,
           JumpFlush,    BranchFlush,
           EXMEM_RegWr,  MEMWB_RegWr,
           CU_Rs,        CU_Rt,
           IDEX_Rs,      IDEX_Rt,
           EXMEM_wsel,   MEMWB_wsel,
           mem_op,       ex_op,
    output pcWEN,
           IFID_enable,  IFID_flush,
           IDEX_enable,  IDEX_flush,
           EXMEM_enable, EXMEM_flush,
           MEMWB_enable, 
           forwardA,     forwardB

  );
    modport tb (
    output ihit,  dhit,
           JumpFlush,    BranchFlush,
           EXMEM_RegWr,  MEMWB_RegWr,
           CU_Rs,        CU_Rt,
           IDEX_Rs,      IDEX_Rt,
           EXMEM_wsel,   MEMWB_wsel,
           mem_op,       ex_op,
    input  pcWEN,
           IFID_enable,  IFID_flush,
           IDEX_enable,  IDEX_flush,
           EXMEM_enable, EXMEM_flush,
           MEMWB_enable, 
           forwardA,     forwardB

  );

endinterface

`endif //HAZARD_UNIT_IF_VH
  
