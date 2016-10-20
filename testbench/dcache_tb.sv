// File name:   dcache_tb.sv
// Updated:     19 October 2016
// Authors:     Brian Rieder 
//              Pooja Kale
// Description: Testbench for dcache
//              Implemented testing:
//                - 

// mapped needs this
`include "datapath_cache_if.vh"
`include "caches_if.vh"
`include "cpu_types_pkg.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module dcache_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  datapath_cache_if dcif ();
  caches_if cif ();
  // test program
  test PROG (CLK, nRST, cif.dcache_tb, dcif.dcache_tb);
  // DUT
`ifndef MAPPED
  dcache DUT(CLK, nRST, dcif, cif);
`endif

endmodule

program test(input logic CLK, output logic nRST, caches_if.dcache_tb cif, datapath_cache_if.dcache_tb dcif);

  // Test Data Setup
  int test_num = 0;
  parameter PERIOD = 10; // copied from above, not recognized otherwise

  initial begin

    // ********** Test Initialization ******************************
    import cpu_types_pkg::*; // for data types
    dcachef_t dmemsliced;
    dmemsliced.bytoff = 0;
    // Zero Initialization
    dcif.halt = 0;
    dcif.dmemREN = 0;
    dcif.dmemWEN = 0;
    dcif.dmemstore = '0;
    dcif.dmemaddr = '0;
    cif.dwait = 0;
    cif.dload = '0;
    // Reset
    nRST = 0;
    @(posedge CLK);
    nRST = 1;
    @(posedge CLK);

    // ********** Test 1: Compulsory Write Miss 
    test_num += 1;
    dmemsliced.tag = 26'hBEEF;
    dmemsliced.idx = 3'b001;
    dmemsliced.blkoff = 0;
    dcif.dmemaddr = dmemsliced;
    dcif.dmemWEN = 1;
    dcif.dmemstore = 32'hDEADBABE;
    cif.dwait = 1;
    @(posedge CLK);
    cif.dwait = 0;
    cif.dload = 32'h11261984;
    @(posedge CLK);
    cif.dwait = 1;
    @(posedge CLK);
    cif.dwait = 0;
    cif.dload = 32'h07131995;
    @(posedge CLK);
    @(posedge CLK);
    dcif.dmemWEN = 0;
    if(dcif.dhit) 
        $display("Test Case 1 Passed: Compulsory Write Miss");
    else
        $display("Test Case 1 Failed: Compulsory Write Miss");
    @(posedge CLK);

    // ********** Test 2: Immediate Read Hit
    test_num += 1;
    dmemsliced.tag = 26'hBEEF;
    dmemsliced.idx = 3'b001;
    dmemsliced.blkoff = 0;
    dcif.dmemaddr = dmemsliced;
    cif.dload = '0;
    dcif.dmemREN = 1;
    @(posedge CLK);
    if(dcif.dhit && dcif.dmemload == 32'hDEADBABE)
        $display("Test Case 2 Passed: Immediate Read Hit");
    else
        $display("Test Case 2 Failed: Immediate Read Hit");
    dcif.dmemREN = 0;
    @(posedge CLK);

    // ********** Test 3: Compulsory Read Miss
    test_num += 1;
    dmemsliced.tag = 26'hBEAD;
    dmemsliced.idx = 3'b010;
    dmemsliced.blkoff = 1;
    dcif.dmemaddr = dmemsliced;
    dcif.dmemREN = 1;
    cif.dwait = 1;
    @(posedge CLK);
    cif.dwait = 0;
    cif.dload = 32'hABCDEFAB;
    @(posedge CLK);
    cif.dwait = 1;
    @(posedge CLK);
    cif.dwait = 0;
    cif.dload = 32'h12345678;
    @(posedge CLK);
    @(posedge CLK);
    dcif.dmemREN = 0;
    if(dcif.dhit && dcif.dmemload == 32'h12345678) 
        $display("Test Case 3 Passed: Compulsory Read Miss");
    else
        $display("Test Case 3 Failed: Compulsory Read Miss");
    @(posedge CLK);

    // ********** Test 4: Immediate Write Hit
    test_num += 1;
    dmemsliced.tag = 26'hBEAD;
    dmemsliced.idx = 3'b010;
    dmemsliced.blkoff = 1;
    dcif.dmemaddr = dmemsliced;
    cif.dload = '0;
    dcif.dmemWEN = 1;
    dcif.dmemstore = 32'hBEDDAEEE;
    @(posedge CLK);
    if(dcif.dhit)
        $display("Test Case 4 Passed: Immediate Write Hit");
    else
        $display("Test Case 4 Failed: Immediate Write Hit");
    dcif.dmemREN = 0;
    @(posedge CLK);

    // ********** Test 5: Write Miss to LRU
    test_num += 1;
    dmemsliced.tag = 26'h501D;
    dmemsliced.idx = 3'b001;
    dmemsliced.blkoff = 0;
    dcif.dmemaddr = dmemsliced;
    dcif.dmemWEN = 1;
    dcif.dmemstore = 32'hCAFEA55E;
    cif.dwait = 1;
    @(posedge CLK);
    cif.dwait = 0;
    cif.dload = 32'h1A2B3C4D;
    @(posedge CLK);
    cif.dwait = 1;
    @(posedge CLK);
    cif.dwait = 0;
    cif.dload = 32'h5E6F7890;
    @(posedge CLK);
    @(posedge CLK);
    dcif.dmemWEN = 0;
    if(dcif.dhit) 
        $display("Test Case 5 Passed: Write Miss to LRU");
    else
        $display("Test Case 5 Failed: Write Miss to LRU");
    @(posedge CLK);

    // ********** Test 6: Read Hit from Write for LRU Shift
    test_num += 1;
    dmemsliced.tag = 26'hBEEF;
    dmemsliced.idx = 3'b001;
    dmemsliced.blkoff = 1;
    dcif.dmemaddr = dmemsliced;
    cif.dload = '0;
    dcif.dmemREN = 1;
    @(posedge CLK);
    if(dcif.dhit && dcif.dmemload == 32'h07131995)
        $display("Test Case 6 Passed: Read Hit from Write for LRU Shift");
    else
        $display("Test Case 6 Failed: Read Hit from Write for LRU Shift");
    dcif.dmemREN = 0;
    @(posedge CLK);

    // ********** Test 7: Write Miss with Writeback Dirty Entry
    test_num += 1;
    dmemsliced.tag = 26'hDEAF;
    dmemsliced.idx = 3'b001;
    dmemsliced.blkoff = 0;
    dcif.dmemaddr = dmemsliced;
    dcif.dmemWEN = 1;
    dcif.dmemstore = 32'hAAAAAAAA;
    cif.dwait = 1;
    @(posedge CLK); // WB1
    cif.dwait = 0;
    @(posedge CLK); // WB2
    cif.dwait = 1;
    @(posedge CLK); // WB2
    cif.dwait = 0;
    @(posedge CLK); // LD1
    cif.dwait = 0;
    cif.dload = 32'hBBBBBBBB;
    @(posedge CLK); // LD2
    cif.dwait = 1;
    @(posedge CLK); // LD2
    cif.dwait = 0;
    cif.dload = 32'hCCCCCCCC;
    @(posedge CLK); // IDLE
    @(posedge CLK);
    dcif.dmemWEN = 0;
    if(dcif.dhit) 
        $display("Test Case 7 Passed: Write Miss with Writeback Dirty Entry");
    else
        $display("Test Case 7 Failed: Write Miss with Writeback Dirty Entry");
    @(posedge CLK);

    // ********** Test 8: Flush the Cache
    test_num += 1;
    dcif.halt = 1;
    dcif.dmemaddr = '0;
    @(posedge dcif.flushed);
    $display("Test Case 8 Passed: Flush the Cache");
    @(posedge CLK);




  end

endprogram
