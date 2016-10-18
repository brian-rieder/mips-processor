// File name:   icache_tb.sv
// Updated:     15 October 2016
// Author:      Brian Rieder Pooja Kale 
// Description: Testbench for icache
//              Implemented testing:
//                - Proper control signals based on all instructions

// mapped needs this
`include "datapath_cache_if.vh"
`include "caches_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module icache_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
 datapath_cache_if dcif ();
 caches_if cif();

  // test program
  test PROG (CLK, nRST, cif.icache_tb, dcif.icache_tb);
  // DUT
`ifndef MAPPED
 icache DUT(CLK, nRST, dcif, cif);
`endif

endmodule

program test(input logic clk, output logic nRST, caches_if.icache_tb cif, datapath_cache_if.icache_tb dcif);

  // Test Data Setup
  parameter PERIOD = 10; // copied from above, not recognized otherwise

  initial begin

    // ********** Test Initialization ******************************
    import cpu_types_pkg::*; // for data types
    nRST = 0;
    #(PERIOD)
    nRST = 1;
    #(PERIOD)
    dcif.imemaddr = 32'b000000000; 
    dcif.imemREN = 1'b1; 
    cif.iwait = 1'b0; 


    // ********** Test Case 1 ******************************

    #(PERIOD)
    dcif.imemaddr = 32'b00000000000000000000101011000100; 
    cif.iwait = 1'b1;
    //dcif.imemREN = 1'b1; 
    #(PERIOD)
    //cif.iwait = 1'b0; 
    //cif.iload = 32'b110001; 
    //dcif.imemaddr = 32'b10001111100000111111010101; 
    if(cif.iREN == 1'b1)  
        $display("Test Case 1 Passed"); 
    else 
        $display("Test Case 1 Failed");
    #(PERIOD)
    cif.iwait = 0; 
    cif.iload = 32'hDEADBEEF;
    #(PERIOD) 

    if(dcif.ihit == 1'b1) begin 
        $display("Test Case 2 Passed");
    end 
    else begin 
        $display("Test Case 2 Failed"); 
    end 

    #(PERIOD) 
    cif.iwait = 1'b0; 
    cif.iload = 32'hBADBAD10; 
    #(PERIOD)
    if(dcif.ihit == 1'b1) begin 
        $display("Test Case 3 Passed");
    end 
    else begin 
        $display("Test Case 3 Failed"); 
    end 
    
    #(PERIOD)
    dcif.imemaddr = 32'b110101010101010101010101010; 
    cif.iwait = 1'b1;
    #(PERIOD)
    cif.iwait = 1'b1; 
    cif.iload = 32'b110001; 
    //dcif.imemaddr = 32'b110101010101010101010101010; 
    #(PERIOD)
    if(dcif.ihit == 1'b0) begin 
        $display("Test Case 4 Passed");
    end 
    else begin 
        $display("Test Case 4 Failed"); 
    end  

     #(PERIOD)
    dcif.imemaddr = 32'b110101010101010101010101010; 
    cif.iwait = 1'b1;
    #(PERIOD)
    cif.iwait = 1'b1; 
    cif.iload = 32'b110001; 
    //dcif.imemaddr = 32'b110101010101010101010101010;     
    #(PERIOD)
    if(dcif.ihit == 1'b0) begin 
        $display("Test Case 5 Passed");
    end 
    else begin 
        $display("Test Case 5 Failed"); 
    end 
    #(PERIOD)
    #(PERIOD)
    #(PERIOD)
    #(PERIOD)
    if(dcif.ihit == 1'b0) begin 
        $display("Test Case 6 Passed");
    end 
    else begin 
        $display("Test Case 6 Failed"); 
    end
    #(PERIOD)
    cif.iwait = 1'b0;
    #(PERIOD)
    if(dcif.ihit == 1'b1) begin 
        $display("Test Case 7 Passed");
    end 
    else begin 
        $display("Test Case 7 Failed"); 
    end  

/*
    #(PERIOD)
    dcif.imemaddr = 32'b110101010101010101010101010; 
    cif.iwait = 1'b1;
    dcif.imemREN = 1'b1; 
    #(PERIOD)
    cif.iwait = 1'b0; 
    cif.iload = 32'b110002; 
    dcif.imemaddr = 32'b110101010101010101010101010; 

    if(dcif.ihit == 1'b1) begin 
        $("Test Case Passed");
    end 
    else begin 
        $("Test Case Failed"); 
    end 

        #(PERIOD)
    dcif.imemaddr = 32'b10001111100000111111010101; 
    cif.iwait = 1'b1;
    dcif.imemREN = 1'b1; 
    #(PERIOD)
    cif.iwait = 1'b0; 
    cif.iload = 32'b110002; 
    dcif.imemaddr = 32'b10001111100000111111010100; // different address

    if(dcif.ihit == 1'b0) begin 
        $("Test Case Passed");
    end 
    else begin 
        $("Test Case Failed"); 
    end 
    */


  end

endprogram
