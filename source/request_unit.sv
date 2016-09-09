// File name:   request_unit.sv
// Updated:     8 September 2016
// Author:      Brian Rieder 
// Description: Unit to determine when to request instructions and enable data read/write

// interface include
`include "request_unit_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module request_unit (
  input logic CLK, nRST,
  request_unit_if.ru ruif
);

  assign ruif.imemREN = ~(ruif.halt);
  assign ruif.pcWEN   = ruif.ihit;

  always_ff @ (posedge CLK, negedge nRST) begin
    ruif.dmemREN <= 0;
    ruif.dmemWEN <= 0;
    if(ruif.dhit) begin
      ruif.dmemREN <= 0;
      ruif.dmemWEN <= 0;
    end
    else if(ruif.dhit == 0 && ruif.dWEN == 1) begin
      ruif.dmemWEN <= 1;
    end
    else if(ruif.dhit == 0 && ruif.dREN == 1) begin
      ruif.dmemREN <= 1;
    end
  end

endmodule
