// File name:   request_unit_if.vh
// Updated:     9 September 2016
// Author:      Brian Rieder 
// Description: Interface file for Request Unit

`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface request_unit_if;
  // import types
  import cpu_types_pkg::*;

  logic halt, dWEN, dREN, ihit, dhit,
        dmemWEN, dmemREN, imemREN, pcWEN;

  // request unit ports
  modport ru (
           // from control unit
    input  halt, dWEN, dREN, 
           // from caches
           ihit, dhit,
           // to caches
    output dmemWEN, dmemREN, imemREN,
           // to program counter
           pcWEN
  );
  // request unit tb
  modport tb (
           // to caches
    input  dmemWEN, dmemREN, imemREN,
           // to program counter
           pcWEN,
           // from control unit
    output halt, dWEN, dREN, 
           // from caches
           ihit, dhit
  );
endinterface

`endif //REQUEST_UNIT_IF_VH
  