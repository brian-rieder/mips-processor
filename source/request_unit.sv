// File name:   request_unit.sv
// Updated:     14 September 2016
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

  // assign ruif.imemREN = ~(ruif.halt);
  // assign ruif.imemREN = 1;
  assign ruif.pcWEN   = ruif.ihit;

  always_ff @ (posedge CLK, negedge nRST) begin
    if(!nRST) begin
      ruif.dmemREN <= 0;
      ruif.dmemWEN <= 0;
    end 
    else begin
      if(ruif.dhit) begin
        ruif.dmemREN <= 0;
        ruif.dmemWEN <= 0;
      end
      else if(ruif.ihit && ruif.dWEN) begin
        ruif.dmemWEN <= 1;
      end
      else if(ruif.ihit && ruif.dREN) begin
        ruif.dmemREN <= 1;
      end
    end
  end

endmodule
