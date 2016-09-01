// File name:   memory_control.sv
// Updated:     1 September 2016
// Author:      Brian Rieder 
// Description: Controller to interface between caches and RAM

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 2;

endmodule
