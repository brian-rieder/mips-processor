// File name:   datapath_tb.sv
// Updated:     11 September 2016
// Author:      Brian Rieder 
// Description: Testbench for datapath
//              Implemented testing:
//                - 

// mapped needs this
`include "datapath_tb.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module request_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  request_unit_if ruif ();
  // test program
  test PROG (CLK, ruif.tb);
  // DUT
`ifndef MAPPED
  request_unit DUT(CLK, nRST, ruif);
`endif

endmodule

program test(input logic clk, request_unit_if.tb rutb);

  // Test Data Setup
  int test_num = 0;
  parameter PERIOD = 10; // copied from above, not recognized otherwise

  initial begin

    // ********** Test Initialization ******************************
    import cpu_types_pkg::*; // for data types
    ruif.halt = 0;
    ruif.dWEN = 0;
    ruif.dREN = 0;
    ruif.ihit = 0;
    ruif.dhit = 0;
    #(PERIOD);

    // ********** Test 1: Halt interaction**************************
    test_num += 1;
    #(PERIOD * 2); // expected value: imemREN = 0


  end

endprogram
