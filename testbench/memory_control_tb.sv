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
    test PROG (CLK, nRST, cif0, cif1, ramif);
    // DUT
`ifndef MAPPED
    memory_control DUT (CLK, nRST, ccif);
    ram RAM (CLK, nRST, ramif);
`endif

    assign ramif.ramREN = ccif.ramREN;
    assign ramif.ramWEN = ccif.ramWEN;
    assign ramif.ramaddr = ccif.ramaddr;
    assign ramif.ramstore = ccif.ramstore;
    assign ccif.ramstate = ramif.ramstate;
    assign ccif.ramload = ramif.ramload;

endmodule

program test(input logic CLK, output logic nRST, caches_if.caches cif0_tb, caches_if.caches cif1_tb, cpu_ram_if.tb ramif_tb);

    // Test Data Setup
    int test_num = 0;
    logic [31:0] test_data = 32'hFFFFFFFF;
    parameter PERIOD = 10; // copied from above, not recognized otherwise

    // Interfacing Setup

    initial begin

        // ********** Test Initialization ******************************
        import cpu_types_pkg::*; 
        nRST = 0;
        cif0_tb.dstore = '{default: '0};
        cif1_tb.dstore = '0;
        cif0_tb.daddr = '0;
        cif1_tb.daddr = '0;
        cif0_tb.dWEN = 0;
        cif1_tb.dWEN = 0;
        cif0_tb.dREN = 0;
        cif1_tb.dREN = 0;
        cif0_tb.ccwrite = 0;
        cif1_tb.ccwrite = 0;
        cif0_tb.cctrans = 0;
        cif1_tb.cctrans = 0;
        // Irrelevant for cache coherence
        cif0_tb.iaddr = '0;
        cif1_tb.iaddr = '0;
        cif0_tb.iREN = 0;
        cif1_tb.iREN = 0;
        @(posedge CLK);

        nRST = 1;
        // ********** Test 1: Transition to Arbitration with C0 cctrans
        test_num += 1;
        @(posedge CLK);
        cif0_tb.cctrans = 1;
        @(posedge CLK);
        cif0_tb.dWEN = 1; 
        cif1_tb.dWEN = 0; 
        @(posedge CLK);
        @(posedge CLK);
        @(posedge CLK);

        if(cif0_tb.ccwait == 1'b0)  
            $display("Test Case 1 Passed: CCwait is set low after WB1 and WB2");
         else
            $display("Test Case 1 Failed: CCwait is not set low after WB1 and WB2");
 // ********** Test 2: Transition to Arbitration with C0 cctrans
        test_num += 1;
        @(posedge CLK);
        cif0_tb.cctrans = 1;
        cif0_tb.dWEN = 0;
        cif1_tb.dWEN = 0;
        cif0_tb.dREN = 1; 
        cif1_tb.dREN = 0; 
        cif0_tb.ccwrite = 1'b1; 
        cif0_tb.daddr = 32'hABCDEF12;
        @(posedge CLK);
        if(cif1_tb.ccinv == 1'b1)  
            $display("Test Case 2 Passed: CCINV is set high in snoop");
        else
            $display("Test Case 2 Failed: CCwait is not set high in snoop");

 // ********** Test 3: Transition to Arbitration with C0 cctrans
        test_num += 1; 
        if(cif1_tb.ccsnoopaddr == 32'hABCDEF12)  
            $display("Test Case 3 Passed: Snoop Address is set in Snoop");
        else
            $display("Test Case 3 Failed: Snoop Address is not set in Snoop");

 // ********** Test 4: ramREN in RAMREAD
        test_num += 1; 
        @(posedge CLK);
        cif0_tb.ccwrite = 0; 
        // ramif_tb.ramload = 32'h98888123;
        @(posedge CLK);
        if(ramif_tb.ramREN == 1'b1)
            $display("Test Case 4 Passed: RamREN is Set High in RAMREAD");
        else 
            $display("Test Case 4 Failed: RamREN is Not Set High in RAMREAD");

 // ********** Test 5: dload in RAMREAD
        test_num += 1;
        if(cif0_tb.dload == ramif_tb.ramload)
            $display("Test Case 5 Passed: dload is set to ramload in RAMREAD1");
        else 
            $display("Test Case 5 Failed: dload is not set to ramload in RAMREAD1");

 // ********** Reel it into IDLE
        cif0_tb.cctrans = 0;
        cif0_tb.dWEN = 0;
        cif1_tb.dWEN = 0;
        cif0_tb.dREN = 0; 
        cif1_tb.dREN = 0; 
        @(posedge CLK);
        @(posedge CLK);

 // ********** Test: RAMWRITE
        test_num += 1;
        // IDLE
        cif1_tb.cctrans = 1;
        @(posedge CLK);
        // ARBITRATION
        cif1.dREN = 1;
        @(posedge CLK);
        // SNOOP
        cif1_tb.daddr = 32'hBABABABA;
        cif0_tb.dstore = 32'hDCDCDCDC;
        cif0_tb.ccwrite = 1;
        @(posedge CLK);
        // RAMWRITE1
        if(ramif_tb.ramWEN == 1'b1)
            $display("Test Case 6 Passed: RamWEN is Set High in RAMWRITE");
        else 
            $display("Test Case 6 Failed: RamWEN is Not Set High in RAMWRITE");
        if(ramif_tb.ramaddr == cif1_tb.daddr)
            $display("Test Case 7 Passed: ramaddr is set to serviced daddr");
        else 
            $display("Test Case 7 Failed: ramaddr is not set to serviced daddr");
        if(ramif_tb.ramstore == cif0_tb.dstore)
            $display("Test Case 8 Passed: ramstore is set to not serviced daddr");
        else 
            $display("Test Case 8 Failed: ramstore is not set to not serviced daddr");
        if(cif1_tb.dload == cif0_tb.dstore)
            $display("Test Case 9 Passed: dload is set to serviced dstore");
        else 
            $display("Test Case 9 Failed: dload is not set to serviced dstore");

 // ********** Reel it into IDLE
        cif0_tb.cctrans = 0;
        cif1_tb.cctrans = 0;
        cif0_tb.daddr = '0;
        cif1_tb.daddr = '0;
        cif0_tb.dstore = '0;
        cif1_tb.dstore = '0;
        cif0_tb.dWEN = 0;
        cif1_tb.dWEN = 0;
        cif0_tb.dREN = 0; 
        cif1_tb.dREN = 0; 
        cif0_tb.ccwrite = 0;
        cif1_tb.ccwrite = 0;
        @(posedge CLK);
        @(posedge CLK);

 // ********** Test: Precedence
        test_num = 11;
        // IDLE
        cif0_tb.cctrans = 1;
        cif1_tb.cctrans = 1;
        @(posedge CLK);
        // ARBITRATION
        cif0_tb.dREN = 1; 
        cif1_tb.dWEN = 1;
        @(posedge CLK);
        // SNOOP
        if(cif1_tb.ccwait)
            $display("Test Case 10 Passed: Cache 0 given priority over Cache 1");
        else 
            $display("Test Case 10 Failed: Cache 0 not given priority over Cache 1");
        cif1_tb.ccwrite = 1;
        @(posedge CLK);
        // RAMWRITE1
        if(ramif_tb.ramWEN == 1'b1)
            $display("Test Case 11 Passed: RamWEN is Set High in RAMWRITE");
        else 
            $display("Test Case 11 Failed: RamWEN is Not Set High in RAMWRITE");
        if(ramif_tb.ramaddr == cif1_tb.daddr)
            $display("Test Case 12 Passed: ramaddr is set to serviced daddr");
        else 
            $display("Test Case 12 Failed: ramaddr is not set to serviced daddr");
        if(ramif_tb.ramstore == cif0_tb.dstore)
            $display("Test Case 13 Passed: ramstore is set to not serviced daddr");
        else 
            $display("Test Case 13 Failed: ramstore is not set to not serviced daddr");
        if(cif1_tb.dload == cif0_tb.dstore)
            $display("Test Case 14 Passed: dload is set to serviced dstore");
        else 
            $display("Test Case 14 Failed: dload is not set to serviced dstore");



        // dump_memory();
        @(posedge CLK);
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
