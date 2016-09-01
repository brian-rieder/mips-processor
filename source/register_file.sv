// File name:   register_file.sv
// Updated:     25 August 2016
// Author:      Brian Rieder 
// Description: Central storage of the processor

`include "register_file_if.vh"
import cpu_types_pkg::*;

module register_file
(
  input logic clk,
  input logic nRST,
  register_file_if.rf rfif
);

  word_t [31:0] registers;

  assign rfif.rdat1 = registers[rfif.rsel1];
  assign rfif.rdat2 = registers[rfif.rsel2];

  always_ff @ (posedge clk, negedge nRST) begin
    if (!nRST) begin
      // registers <= '{default:0};
      registers <= '0;
    end
    else begin
      if(rfif.WEN && (rfif.wsel != 0)) begin
        registers[rfif.wsel] <= rfif.wdat;
      end
    end
  end

endmodule