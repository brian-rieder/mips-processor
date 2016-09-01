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
  parameter CPUS = 1;

  // load/store signals
  assign ccif.iload = ccif.ramload;
  assign ccif.dload = ccif.ramload;
  assign ccif.dstore = ccif.ramstore;

  // read/write enable signals
  assign ccif.ramWEN = ccif.dWEN;
  assign ccif.ramREN = ccif.dREN | ccif.iREN;

  // addr and wait signals
  always_comb begin
    if (ccif.dREN | ccif.dWEN) begin
      ccif.ramaddr = ccif.daddr;
    end
    else begin
      ccif.ramaddr = ccif.iaddr;
    end
    casez(ccif.ramstate) begin
      FREE: begin
        ccif.iwait = 1;
        ccif.dwait = 1;
      end
      BUSY: begin
        ccif.iwait = 1;
        ccif.dwait = 1;
      end
      ACCESS: begin
        if (ccif.dREN | ccif.dWEN) begin
          ccif.iwait = 1;
          ccif.dwait = 0;
        end else if (ccif.iREN) begin
          ccif.iwait = 0;
          ccif.dwait = 1;
        end
      end
      ERROR: begin
        ccif.iwait = 1;
        ccif.dwait = 1;
      end
      default: begin
        ccif.iwait = 1;
        ccif.dwait = 1;
      end
    endcase
  end

endmodule

// Inputs
// Cache
// [x] iREN
// [x] dREN
// [x] dWEN
// [x] dstore        ccif.dwait = 1;
        ccif.iwait = 1;

// [x] iaddr
// [x] daddr
// RAM 
// [x] ramload 
// [x] ramstate 

// Outputs
// Cache
// [x] iwait -- opposite of ihit
// [x] dwait -- opposite of dhit
// [x] iload 
// [x] dload
// RAM
// [x] ramstore 
// [x] ramaddr 
// [ ] ramWEN 
// [ ] ramREN