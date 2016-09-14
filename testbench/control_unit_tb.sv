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
    j_t j_inst;
    i_t i_inst;
    r_t r_inst;
    j_inst = 32'h0;
    i_inst = 32'h0;
    r_inst = 32'h0;

    // ********** Test 1: R-type: SLL ******************************
    test_num += 1;
    r_inst.opcode = RTYPE;
    r_inst.rs = 10;
    r_inst.rt = 11;
    r_inst.rd = 12;
    r_inst.shamt = 5'b01100;
    r_inst.funct = SLL;
    cutb.imemload = r_inst;
    #(PERIOD * 2); 

    // ********** Test 2: R-type: SRL ******************************
    test_num += 1;
    r_inst.opcode = RTYPE;
    r_inst.rs = 10;
    r_inst.rt = 11;
    r_inst.rd = 12;
    r_inst.shamt = 5'b00011;
    r_inst.funct = SRL;
    cutb.imemload = r_inst;
    #(PERIOD * 2);

    // ********** Test 3: R-type: JR *******************************
    test_num += 1;
    r_inst.opcode = RTYPE;
    r_inst.rs = 23;
    r_inst.rt = 11;
    r_inst.rd = 12;
    r_inst.shamt = 5'b00000;
    r_inst.funct = JR;
    cutb.imemload = r_inst;
    #(PERIOD * 2);

    // ********** Test 4: R-type: ADD ******************************
    test_num += 1;
    r_inst.opcode = RTYPE;
    r_inst.rs = 1;
    r_inst.rt = 2;
    r_inst.rd = 3;
    r_inst.shamt = 5'b00000;
    r_inst.funct = ADD;
    cutb.imemload = r_inst;
    #(PERIOD * 2);

    // ********** Test 5: R-type: ADDU *****************************
    test_num += 1;
    r_inst.opcode = RTYPE;
    r_inst.rs = 1;
    r_inst.rt = 2;
    r_inst.rd = 3;
    r_inst.shamt = 5'b00000;
    r_inst.funct = ADDU;
    cutb.imemload = r_inst;
    #(PERIOD * 2);

    // ********** Test 6: R-type: SUB ******************************
    test_num += 1;
    r_inst.opcode = RTYPE;
    r_inst.rs = 2;
    r_inst.rt = 3;
    r_inst.rd = 4;
    r_inst.shamt = 5'b00000;
    r_inst.funct = SUB;
    cutb.imemload = r_inst;
    #(PERIOD * 2);

    // ********** Test 7: R-type: SUBU *****************************
    test_num += 1;
    r_inst.opcode = RTYPE;
    r_inst.rs = 2;
    r_inst.rt = 3;
    r_inst.rd = 4;
    r_inst.shamt = 5'b00000;
    r_inst.funct = SUBU;
    cutb.imemload = r_inst;
    #(PERIOD * 2);

    // ********** Test 8: R-type: AND ******************************
    test_num += 1;
    r_inst.opcode = RTYPE;
    r_inst.rs = 2;
    r_inst.rt = 3;
    r_inst.rd = 4;
    r_inst.shamt = 5'b00000;
    r_inst.funct = SUBU;
    cutb.imemload = r_inst;

    #(PERIOD * 2);

    // ********** Test 9: R-type: OR *******************************
    test_num += 1;
    r_inst.opcode = RTYPE;
    r_inst.rs = 2;
    r_inst.rt = 3;
    r_inst.rd = 4;
    r_inst.shamt = 5'b00000;
    r_inst.funct = OR;
    cutb.imemload = r_inst;
    #(PERIOD * 2);

    // ********** Test 10: R-type: XOR ******************************
    test_num += 1;
    r_inst.opcode = RTYPE;
    r_inst.rs = 2;
    r_inst.rt = 3;
    r_inst.rd = 4;
    r_inst.shamt = 5'b00000;
    r_inst.funct = XOR;
    cutb.imemload = r_inst;

    #(PERIOD * 2);

    // ********** Test 11: R-type: NOR ******************************
    test_num += 1;
    r_inst.opcode = RTYPE;
    r_inst.rs = 2;
    r_inst.rt = 3;
    r_inst.rd = 4;
    r_inst.shamt = 5'b00000;
    r_inst.funct = NOR;
    cutb.imemload = r_inst;
    #(PERIOD * 2);

    // ********** Test 12: R-type: SLT ******************************
    test_num += 1;
    r_inst.opcode = RTYPE;
    r_inst.rs = 2;
    r_inst.rt = 3;
    r_inst.rd = 4;
    r_inst.shamt = 5'b00000;
    r_inst.funct = SLT;
    cutb.imemload = r_inst;
    #(PERIOD * 2);

    // ********** Test 13: R-type: SLTU *****************************
    test_num += 1;
    r_inst.opcode = RTYPE;
    r_inst.rs = 2;
    r_inst.rt = 3;
    r_inst.rd = 4;
    r_inst.shamt = 5'b00000;
    r_inst.funct = SLTU;
    cutb.imemload = r_inst;
    #(PERIOD * 2);
    r_inst = 32'h0;

    // ********** Test 14: J-type: J ********************************
    test_num += 1;
    j_inst.opcode = J;
    j_inst.addr = 26'b00010010001101000101011001; 
    cutb.imemload = j_inst;
    #(PERIOD * 2);

    // ********** Test 15: J-type: JAL ******************************
    test_num += 1;
    j_inst.opcode = JAL;
    j_inst.addr = 26'b00010010001101000101011001; 
    cutb.imemload = j_inst;
    #(PERIOD * 2);
    j_inst = 32'h0;

    // ********** Test 16: I-type: BEQ ******************************
    test_num += 1;
    i_inst.opcode = BEQ;
    i_inst.rs = 4;
    i_inst.rt = 5;
    i_inst.imm = 16'hDEAD;
    cutb.imemload = i_inst;
    #(PERIOD * 2);

    // ********** Test 17: I-type: BNE ******************************
    test_num += 1;
    i_inst.opcode = BNE;
    i_inst.rs = 4;
    i_inst.rt = 5;
    i_inst.imm = 16'hBEEF;
    cutb.imemload = i_inst;
    #(PERIOD * 2);

    // ********** Test 18: I-type: ADDI *****************************
    test_num += 1;
    i_inst.opcode = ADDI;
    i_inst.rs = 6;
    i_inst.rt = 7;
    i_inst.imm = 16'hBABE;
    cutb.imemload = i_inst;
    #(PERIOD * 2);

    // ********** Test 19: I-type: ADDIU ****************************
    test_num += 1;
    i_inst.opcode = ADDIU;
    i_inst.rs = 8;
    i_inst.rt = 9;
    i_inst.imm = 16'hCAFE;
    cutb.imemload = i_inst;
    #(PERIOD * 2);

    // ********** Test 20: I-type: SLTI *****************************
    test_num += 1;
    i_inst.opcode = SLTI;
    i_inst.rs = 10;
    i_inst.rt = 11;
    i_inst.imm = 16'hBEEB;
    cutb.imemload = i_inst;
    #(PERIOD * 2);

    // ********** Test 21: I-type: SLTIU ****************************
    test_num += 1;
    i_inst.opcode = SLTIU;
    i_inst.rs = 11;
    i_inst.rt = 12;
    i_inst.imm = 16'hFEFE;
    cutb.imemload = i_inst;
    #(PERIOD * 2);

    // ********** Test 22: I-type: ANDI *****************************
    test_num += 1;
    i_inst.opcode = ANDI;
    i_inst.rs = 12;
    i_inst.rt = 13;
    i_inst.imm = 16'hFEFE;
    cutb.imemload = i_inst;
    #(PERIOD * 2);

    // ********** Test 23: I-type: ORI ******************************
    test_num += 1;
    i_inst.opcode = ORI;
    i_inst.rs = 13;
    i_inst.rt = 14;
    i_inst.imm = 16'hFEFE;
    cutb.imemload = i_inst;
    #(PERIOD * 2);

    // ********** Test 24: I-type: XORI *****************************
    test_num += 1;
    i_inst.opcode = XORI;
    i_inst.rs = 14;
    i_inst.rt = 15;
    i_inst.imm = 16'hFEFE;
    cutb.imemload = i_inst;
    #(PERIOD * 2);

    // ********** Test 25: I-type: LUI ******************************
    test_num += 1;
    i_inst.opcode = LUI;
    i_inst.rs = 15;
    i_inst.rt = 16;
    i_inst.imm = 16'hFEED;
    cutb.imemload = i_inst;
    #(PERIOD * 2);

    // ********** Test 26: I-type: LW *******************************
    test_num += 1;
    i_inst.opcode = LW;
    i_inst.rs = 16;
    i_inst.rt = 17;
    i_inst.imm = 16'hDEED;
    cutb.imemload = i_inst;
    #(PERIOD * 2);

    // ********** Test 27: I-type: SW *******************************
    test_num += 1;
    i_inst.opcode = SW;
    i_inst.rs = 17;
    i_inst.rt = 18;
    i_inst.imm = 16'hFACE;
    cutb.imemload = i_inst;
    #(PERIOD * 2);

    // ********** Test 28: I-type: HALT ******************************
    test_num += 1;
    i_inst.opcode = HALT;
    i_inst.rs = 18;
    i_inst.rt = 19;
    i_inst.imm = 16'hACED;
    cutb.imemload = i_inst;
    #(PERIOD * 2);

  end

endprogram
