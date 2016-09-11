// File name:   program_counter_tb.sv
// Updated:     11 September 2016
// Author:      Brian Rieder 
// Description: Testbench for program counter
//              Implemented testing:
//                - Writing when pcWEN is high
//                - Writing when pcWEN is low

// mapped needs this
`include "program_counter_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module program_counter_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  program_counter_if pcif ();
  // test program
  test PROG (CLK, pcif.tb);
  // DUT
`ifndef MAPPED
  program_counter DUT(CLK, nRST, pcif);
`endif

endmodule

program test(input logic clk, program_counter_if.tb pctb);

  // Test Data Setup
  int test_num = 0;
  parameter PERIOD = 10; // copied from above, not recognized otherwise

  initial begin

    // ********** Test Initialization ******************************
    import cpu_types_pkg::*; // for data types
    #(PERIOD);

    // ********** Test 1: Writing with pcWEN = 1 *******************
    test_num += 1;
    pctb.pc_next = 32'h12345678;
    pctb.pcWEN = 1;
    #(PERIOD * 2); // expected value: PC = 12345678

    // ********** Test 1: Writing with pcWEN = 0 *******************
    test_num += 1;
    pctb.pc_next = 32'h00000000;
    pctb.pcWEN = 0;
    #(PERIOD * 2); // expected value: PC = 12345678
    
    // ********** Test 2: Writing with pcWEN = 1 *******************
    test_num += 1;
    pctb.pc_next = 32'h00000000;
    pctb.pcWEN = 1;
    #(PERIOD * 2); // expected value: PC = 12345678

  end

endprogram
