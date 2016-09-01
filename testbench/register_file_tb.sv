// File name:   register_file_tb.sv
// Updated:     25 August 2016
// Author:      Brian Rieder 
// Description: Testbench for central storage of the processor. 
//              Implemented testing is required to include, but is not limited to:
//                - Asynchronous reset of registers
//                - Writing to register 0
//                - Writing and reading to registers

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  register_file_if rfif ();
  // test program
  test PROG (CLK, nRST, rfif.tb);
  // DUT
`ifndef MAPPED
  register_file DUT(CLK, nRST, rfif);
`else
  register_file DUT(
    .\clk (CLK),
    .\nRST (nRST),
    .\rfif.rdat2 (rfif.rdat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN)
  );
`endif

endmodule

program test(input logic clk, output logic nRST, register_file_if.tb rftb);

  // Test Data Setup
  int test_num = 0;
  logic [31:0] test_data = 32'hFFFFFFFF;
  parameter PERIOD = 10; // copied from above, not recognized otherwise

  initial begin

    // ********** Test Initialization ******************************
    rftb.WEN = 0;
    rftb.rsel1 = 0;
    rftb.rsel2 = 0;
    rftb.wsel = 0;
    rftb.wdat = '0;
    nRST = 1;

    // ********** Pre-test: Asynchronous Reset of Registers ********
    #(PERIOD);
    nRST = 0;
    #(PERIOD);
    nRST = 1;
    #(PERIOD);

    // ********** Test 1: Writing to Register 0 ********************
    test_num += 1;
    rftb.WEN = 1;
    rftb.wsel = 0;
    rftb.wdat = test_data; // all 1's
    #(PERIOD * 1);
    rftb.WEN = 0;
    #(PERIOD * 2);

    // ********** Test 2: Writing and Reading to Registers *********
    test_num += 1;
    rftb.WEN = 1;
    rftb.wsel = 12;
    rftb.rsel1 = 12;
    test_data = 32'h10101010;
    rftb.wdat = test_data;
    #(PERIOD);
    rftb.WEN = 0;
    test_data = 32'hFFFFFFFF; // ensure rdat1 doesn't change
    rftb.wdat = test_data;
    #(PERIOD);
    rftb.WEN = 1;
    rftb.wsel = 31;
    rftb.rsel2 = 31;
    test_data = 32'h02020202;
    rftb.wdat = test_data;
    #(PERIOD);
    rftb.WEN = 0;
    #(PERIOD);
    rftb.WEN = 1; // will stay up with changed wsel
    rftb.wsel = 1;
    rftb.rsel1 = 1;
    rftb.rsel2 = 8;
    test_data = 32'hDEADBEA7;
    rftb.wdat = test_data;
    #(PERIOD);
    rftb.wsel = 8;
    test_data = 32'hCA55E77E;
    rftb.wdat = test_data;
    #(PERIOD);
    rftb.WEN = 0;
    #(PERIOD * 2);

    // ********** Test 3: Asynchronous Reset of Registers **********
    test_num += 1;
    nRST = 0;
    #(PERIOD);
    rftb.WEN = 1;
    #(PERIOD);
    rftb.WEN = 0;
    nRST = 1;
    #(PERIOD * 2);

  end

endprogram
