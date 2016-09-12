// File name:   control_unit_tb.sv
// Updated:     12 September 2016
// Author:      Brian Rieder 
// Description: Testbench for program counter
//              Implemented testing:
//                - Proper control signals based on all instructions

// mapped needs this
`include "control_unit_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module control_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  control_unit_if cuif ();
  // test program
  test PROG (CLK, cuif.tb);
  // DUT
`ifndef MAPPED
  control_unit DUT(cuif);
`endif

endmodule

program test(input logic clk, control_unit_if.tb cutb);

  // Test Data Setup
  int test_num = 0;
  parameter PERIOD = 10; // copied from above, not recognized otherwise

  initial begin

    // ********** Test Initialization ******************************
    import cpu_types_pkg::*; // for data types
    #(PERIOD);

    // ********** Test 1: Halt interaction *************************
    test_num += 1;
    #(PERIOD * 2); // expected value: imemREN = 0



  end

endprogram
