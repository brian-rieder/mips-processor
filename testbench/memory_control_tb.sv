// File name:   memory_control_tb.sv
// Updated:     8 September 2016
// Author:      Brian Rieder 
// Description: Testbench for control unit between RAM and caches
//              Implemented testing is required to include, but is not limited to:
//                - Testing signal combinations to simulate memory usage
//                - Ability to read/write from RAM and dump memory contents to file

// mapped needs this
`include "cache_control_if.vh"
`include "cpu_ram_if.vh"
`include "caches_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module memory_control_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  caches_if cif0 ();
  caches_if cif1 ();
  cache_control_if ccif (cif0, cif1);
  cpu_ram_if ramif ();
  // test program
  test PROG (CLK, nRST, cif0, ramif);
  // DUT
`ifndef MAPPED
  memory_control DUT (CLK, nRST, ccif);
  ram RAM (CLK, nRST, ramif);
// `else
  // alu dut(
  //   .\aluif.port_a (aluif.port_a),
  //   .\aluif.port_b (aluif.port_b),
  //   .\aluif.port_o (aluif.port_o),
  //   .\aluif.alu_op (aluif.alu_op),
  //   .\aluif.v_flag (aluif.v_flag),
  //   .\aluif.n_flag (aluif.n_flag),
  //   .\aluif.z_flag (aluif.z_flag)
  // );
`endif

  assign ramif.ramREN = ccif.ramREN;
  assign ramif.ramWEN = ccif.ramWEN;
  assign ramif.ramaddr = ccif.ramaddr;
  assign ramif.ramstore = ccif.ramstore;
  assign ccif.ramstate = ramif.ramstate;
  assign ccif.ramload = ramif.ramload;

endmodule

program test(input logic CLK, output logic nRST, caches_if.caches ccif_tb, cpu_ram_if.tb ramif_tb);

  // Test Data Setup
  int test_num = 0;
  logic [31:0] test_data = 32'hFFFFFFFF;
  parameter PERIOD = 10; // copied from above, not recognized otherwise

  // Interfacing Setup

  initial begin

    // ********** Test Initialization ******************************
    import cpu_types_pkg::*; // for aluop_t
    nRST = 0;
    ccif_tb.dstore = '0;
    ccif_tb.iaddr = '0;
    ccif_tb.daddr = '0;
    ccif_tb.dWEN = 0;
    ccif_tb.dREN = 0;
    ccif_tb.iREN = 0;
    #(PERIOD);

    nRST = 1;
    // ********** Test 1: Data Write into Memory ********************
    test_num += 1;
    ccif_tb.dWEN = 1; // enable the write
    ccif_tb.daddr = 32'h1; // write to address 1
    ccif_tb.dstore = 32'hBABABABA; // data to write
    #(PERIOD * 2); 
    ccif_tb.dWEN = 0; // disable the write
    #(PERIOD * 2); 
    ccif_tb.dREN = 1; // read -- check data here
    #(PERIOD * 2); 
    ccif_tb.dREN = 0; // should be good here
    #(PERIOD * 2); 

    // ********** Test 1: Data Write into Memory ********************
    test_num += 1;
    #(PERIOD * 2);

    dump_memory();
    #(PERIOD * 4);
  end

  task automatic dump_memory();
    string filename = "memcpu.hex";
    int memfd;

    // cif0.tbCTRL = 1;
    cif0.daddr = 0;
    cif0.dWEN = 0;
    cif0.dREN = 0;

    memfd = $fopen(filename,"w");
    if (memfd)
      $display("Starting memory dump.");
    else
      begin $display("Failed to open %s.",filename); $finish; end

    for (int unsigned i = 0; memfd && i < 16384; i++)
    begin
      int chksum = 0;
      bit [7:0][7:0] values;
      string ihex;

      cif0.daddr = i << 2;
      cif0.dREN = 1;
      repeat (4) @(posedge CLK);
      if (cif0.dload === 0)
        continue;
      values = {8'h04,16'(i),8'h00,cif0.dload};
      foreach (values[j])
        chksum += values[j];
      chksum = 16'h100 - chksum;
      ihex = $sformatf(":04%h00%h%h",16'(i),cif0.dload,8'(chksum));
      $fdisplay(memfd,"%s",ihex.toupper());
    end //for
    if (memfd)
    begin
      // cif0.tbCTRL = 0;
      cif0.dREN = 0;
      $fdisplay(memfd,":00000001FF");
      $fclose(memfd);
      $display("Finished memory dump.");
    end
  endtask

endprogram
