// File name:   hazard_unit_tb.sv
// Updated:     11 September 2016
// Author:      Brian Rieder/ Pooja Kale 
// Description: Testbench for hazard unit
//              Implemented testing:
//                - Setting imemREN high when halted
//                - Alignment of ihit and pcWEN
//                - Interaction of dhit, dmemREN, and dmemWEN

// mapped needs this
`include "hazard_unit_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module hazard_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  hazard_unit_if huif ();
  // test program
  test PROG (CLK, huif.tb);
  // DUT
`ifndef MAPPED
  hazard_unit DUT(huif);
`endif

endmodule

program test(input logic clk, hazard_unit_if.tb hutb);

  // Test Data Setup
  int test_num = 0;
  parameter PERIOD = 10; // copied from above, not recognized otherwise

  initial begin

    // ********** Test Initialization ******************************
    import cpu_types_pkg::*; // for data types
    // ruif.halt = 0;
    huif.EXMEM_RegWr = 1;
    huif.IDEX_Rt = 0; 
    huif.IDEX_Rs = 10; 
    huif.EXMEM_wsel = 10; 
    if(huif.forwardA == 2'b10) begin 
        $display("Testcase passed");      
    end  
    #(PERIOD);

    // ********** Test 1:  *************************
    huif.EXMEM_RegWr = 1;
    huif.IDEX_Rt = 0; 
    huif.IDEX_Rs = 10; 
    huif.MEMWB_wsel = 10; 
    if(huif.forwardA == 2'b00) begin 
        $display("Testcase passed");      
    end  
    #(PERIOD * 2); 


    // ********** Test 2:  *************************
    huif.EXMEM_RegWr = 1;
    huif.IDEX_Rt = 10; 
    huif.IDEX_Rs = 0; 
    huif.MEMWB_wsel = 10; 
    if(huif.forwardA == 2'b10) begin 
        $display("Testcase passed");      
    end  
    #(PERIOD * 2); 


    // ********** Test 3: ********************************
    huif.EXMEM_RegWr = 1;
    huif.IDEX_Rt = 10; 
    huif.IDEX_Rs = 0; 
    huif.MEMWB_wsel = 10; 
    if(huif.forwardA == 2'b01) begin 
        $display("Testcase passed");      
    end  
    #(PERIOD * 2); 

  

  end

endprogram
