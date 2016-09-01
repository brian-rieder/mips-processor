// File name:   alu_tb.sv
// Updated:     29 August 2016
// Author:      Brian Rieder 
// Description: Testbench for processor computational unit
//              Implemented testing is required to include, but is not limited to:
//                - Each operation within the ALU
//                - Each flag bit for proper flagging

// mapped needs this
`include "alu_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module alu_tb;

  parameter PERIOD = 10;

  logic CLK = 0;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  alu_if aluif ();
  // test program
  test PROG (CLK, aluif.tb);
  // DUT
`ifndef MAPPED
  alu DUT(aluif);
`else
  alu DUT(
    .\aluif.port_a (aluif.port_a),
    .\aluif.port_b (aluif.port_b),
    .\aluif.port_o (aluif.port_o),
    .\aluif.alu_op (aluif.alu_op),
    .\aluif.v_flag (aluif.v_flag),
    .\aluif.n_flag (aluif.n_flag),
    .\aluif.z_flag (aluif.z_flag)
  );
`endif

endmodule

program test(input logic clk, alu_if.tb alutb);

  // Test Data Setup
  int test_num = 0;
  logic [31:0] test_data = 32'hFFFFFFFF;
  parameter PERIOD = 10; // copied from above, not recognized otherwise

  initial begin

    // ********** Test Initialization ******************************
    import cpu_types_pkg::*; // for aluop_t
    #(PERIOD);

    // ********** Test 1: Shift Left Logic *************************
    test_num += 1;
    alutb.port_a = 32'h1;
    alutb.port_b = 32'h8;
    alutb.alu_op = ALU_SLL;
    #(PERIOD * 2); // expected value: 100

    // ********** Test 2: Shift Right Logic ************************
    test_num += 1;
    alutb.port_a = 32'h10000000;
    alutb.port_b = 32'h10;
    alutb.alu_op = ALU_SRL;
    #(PERIOD * 2); // expected value: 1000

    // ********** Test 3: Logical AND ******************************
    test_num += 1;
    alutb.port_a = 32'hF0F000F0;
    alutb.port_b = 32'hF0F0F0F0;
    alutb.alu_op = ALU_AND;
    #(PERIOD * 2); // expected value: F0F000F0

    // ********** Test 4: Logical OR *******************************
    test_num += 1;
    alutb.port_a = 32'h10101010;
    alutb.port_b = 32'h01010101;
    alutb.alu_op = ALU_OR;
    #(PERIOD * 2); // expected value: 11111111

    // ********** Test 5: Logical XOR ******************************
    test_num += 1;
    alutb.port_a = 32'h1010;
    alutb.port_b = 32'h1001;
    alutb.alu_op = ALU_XOR;
    #(PERIOD * 2); // expected value: 11

    // ********** Test 6: Logical NOR ******************************
    test_num += 1;
    alutb.port_a = 32'hFF001111;
    alutb.port_b = 32'hFF00FFFF;
    alutb.alu_op = ALU_NOR; 
    #(PERIOD * 2); // expected value: FF0000

    // ********** Test 7: Signed Less Than *************************
    test_num += 1;
    alutb.alu_op = ALU_SLT; 
    // A < B -- output: 1
    alutb.port_a = 32'h80000001;
    alutb.port_b = 32'h00000001;
    #(PERIOD);
    // A > B -- output: 0
    alutb.port_a = 32'h00000001;
    alutb.port_b = 32'hFF00FFFF;
    #(PERIOD);
    // A = B -- output 0
    alutb.port_a = 32'h10101010;
    alutb.port_b = 32'h10101010;
    #(PERIOD);

    // ********** Test 8: Unsigned Less Than ***********************
    test_num += 1;
    alutb.alu_op = ALU_SLTU;
    // A < B -- output: 1
    alutb.port_a = 32'h00000001;
    alutb.port_b = 32'hFF00FFFF;
    #(PERIOD);
    // A > B -- output: 0
    alutb.port_a = 32'h80000001;
    alutb.port_b = 32'h00000001;
    #(PERIOD);
    // A = B -- output 0
    alutb.port_a = 32'h10101010;
    alutb.port_b = 32'h10101010;
    #(PERIOD);

    // ********** Test 9: Signed Addition **************************
    test_num += 1;
    alutb.alu_op = ALU_ADD;
    // Operands: Mixed -- output: 0
    alutb.port_a = 32'hFFFFFFD6; // -42
    alutb.port_b = 32'h0000002A; // 42
    #(PERIOD);
    // Operands: Positive, No Overflow -- output: 01111111
    alutb.port_a = 32'h01010101;
    alutb.port_b = 32'h00101010;
    #(PERIOD);
    // Operands: Positive, Overflow
    alutb.port_a = 32'h7FFFFFFF;
    alutb.port_b = 32'h00101010;
    #(PERIOD);
    // Operands: Negative, No Overflow -- output: -3074 FFFFF400
    alutb.port_a = 32'hFFFFFC00; // -1024
    alutb.port_b = 32'hFFFFF800; // -2048
    #(PERIOD);
    // Operands: Negative, Overflow
    alutb.port_a = 32'h80000000;
    alutb.port_b = 32'hFFFFFFFF; // -2056
    #(PERIOD);

    // ********** Test 10: Signed Subtraction **********************
    test_num += 1;
    alutb.alu_op = ALU_SUB;
    // Operands: Mixed, Negative First -- output: -84 FFFFFFAC
    alutb.port_a = 32'hFFFFFFD6; // -42
    alutb.port_b = 32'h0000002A; // 42
    #(PERIOD);
    // Operands: Mixed, Negative Second -- output: 84 00000054
    alutb.port_a = 32'h0000002A; // 42
    alutb.port_b = 32'hFFFFFFD6; // -42
    #(PERIOD);
    // Operands: Positive, No Overflow -- output: 0
    alutb.port_a = 32'h11261984;
    alutb.port_b = 32'h11261984;
    #(PERIOD);
    // Operands: Positive, Overflow
    alutb.port_a = 32'h00000001;
    alutb.port_b = 32'h00000010;
    #(PERIOD);
    // Operands: Negative, No Overflow -- output: 0
    alutb.port_a = 32'hFFFFFFD5;
    alutb.port_b = 32'hFFFFFFD6;
    #(PERIOD);
    // Operands: Negative, Overflow
    alutb.port_a = 32'hFFFFFFFF;
    alutb.port_b = 32'h80000001;
    #(PERIOD);

    // ********** Test 11: Standalone Zero/Negative Flag Checks ****
    test_num += 1;
    alutb.alu_op = ALU_SUB;
    // Zero Flag
    alutb.port_a = 32'h11261984;
    alutb.port_b = 32'h11261984;
    #(PERIOD);
    // Negative Flag
    alutb.port_a = 32'hFFFFFFD6; // -42
    alutb.port_b = 32'h0000002A; // 42
    #(PERIOD);

  end

endprogram
