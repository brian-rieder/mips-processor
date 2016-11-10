// File name:   program_counter.sv
// Updated:     9 September 2016
// Author:      Brian Rieder 
// Description: Unit to determine when to request instructions and enable data read/write

// interface include
`include "program_counter_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module program_counter (
  input logic CLK, nRST,
  program_counter_if.pc pcif
);

  parameter PC_INIT = 0;

  always_ff @ (posedge CLK, negedge nRST) begin
    if(!nRST) begin
      pcif.pc_out <= PC_INIT;
    end
    else if(pcif.pcWEN) begin
      pcif.pc_out <= pcif.pc_next;
    end
  end 

endmodule
