// File name:   datapath.sv
// Updated:     16 September 2016
// Author:      Brian Rieder 
// Description: Glue unit that contains register file, control unit, 
//              program counter, ALU, request unit, and glue logic

// data path interface
`include "datapath_cache_if.vh"
`include "alu_if.vh"
`include "register_file_if.vh"
`include "control_unit_if.vh"
`include "program_counter_if.vh"
`include "request_unit_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);

  import cpu_types_pkg::*; // import data types

  // Program Counter initialization
  parameter PC_INIT = 0;

  // Interface instantiation
  alu_if aluif ();
  register_file_if rfif ();
  control_unit_if cuif ();
  program_counter_if pcif ();
  request_unit_if ruif ();

  // Component instantiation
  alu ALU (aluif.alu);
  register_file RF (CLK, nRST, rfif.rf);
  control_unit CU (cuif.cu);
  program_counter PC (CLK, nRST, pcif.pc);
  request_unit RU (CLK, nRST, ruif.ru);

  // Misc. Datapath Internal Signals
  logic  branch_mode;
  word_t extended_imm, pcplus4, jumpdest;
  assign pcplus4 = pcif.pc_out + 4;

  // Immediate Extension
  always_comb begin
    // Zero Extension
    if (cuif.ExtOp == 0) begin
      extended_imm = {16'h0000, cuif.imm16};
    end
    // Signed Extension
    else begin 
      // extended[15:0] <= { {8{extend[7]}}, extend[7:0] };
      extended_imm = $signed(cuif.imm16);
    end
  end

  // Datapath input assignment
  //assign dpif.halt      = cuif.halt;
  assign dpif.imemREN   = cuif.imemREN;
  assign dpif.imemaddr  = pcif.pc_out;
  assign dpif.dmemREN   = ruif.dmemREN;
  assign dpif.dmemWEN   = ruif.dmemWEN;
  // assign datomic        = 0; // related to pipeline
  assign dpif.dmemstore = rfif.rdat2;
  assign dpif.dmemaddr  = aluif.port_o;
  always_ff @ (posedge CLK, negedge nRST) begin
    if (nRST) begin
      dpif.halt <= 0;
    end
    dpif.halt <= cuif.halt;
  end

  // Request Unit input assignment
  assign ruif.dWEN      = cuif.dWEN;
  assign ruif.dREN      = cuif.dREN;
  assign ruif.ihit      = dpif.ihit;
  assign ruif.dhit      = dpif.dhit;

  // Control Unit input assignment
  assign cuif.imemload  = dpif.imemload;

  // ALU input assignment
  assign aluif.port_a   = rfif.rdat1;
  assign aluif.alu_op   = cuif.alu_op;
  always_comb begin
    aluif.port_b = '0;
    if (cuif.ALUsrc == 2'b00) begin
      aluif.port_b = extended_imm;
    end
    else if (cuif.ALUsrc == 2'b01) begin
      aluif.port_b = rfif.rdat2;
    end
    else if (cuif.ALUsrc == 2'b10) begin
      aluif.port_b = cuif.shamt;
    end
  end

  // Register File input assignment
  assign rfif.rsel1     = cuif.Rs;
  assign rfif.rsel2     = cuif.Rt;
  always_comb begin
    rfif.wsel = '0;
    rfif.wdat = '0;
    // Write Enable
    if(cuif.dREN) begin
      rfif.WEN = (cuif.RegWr && dpif.dhit) ? 1 : 0;
    end
    else begin
      rfif.WEN = (cuif.RegWr && dpif.ihit) ? 1 : 0;
    end
    // Write Select assignment
    // Rt
    if (cuif.RegDst == 2'b00) begin
      rfif.wsel = cuif.Rt;
    end
    // Rd
    else if (cuif.RegDst == 2'b01) begin
      rfif.wsel = cuif.Rd;
    end
    // Register 31 (JAL)
    else if (cuif.RegDst == 2'b10) begin
      rfif.wsel = 32'h0000001F;
    end
    // wdat
    if      (cuif.JAL == 0 & cuif.LUI == 0) begin
      rfif.wdat = (cuif.MemToReg) ? dpif.dmemload : aluif.port_o;
    end
    else if (cuif.JAL == 0 & cuif.LUI == 1) begin
      rfif.wdat = {cuif.imm16, 16'h0000};
    end
    else if (cuif.JAL == 1 & cuif.LUI == 0) begin
      rfif.wdat = pcplus4;
    end
  end

  // Program Counter input assignment
  assign pcif.pcWEN     = ruif.pcWEN;
  // always_comb begin
  //   if (cuif.halt) begin
  //     pcif.pcWEN        = 0;
  //   end else begin
  //     pcif.pcWEN        = ruif.pcWEN;
  //   end
  // end
  always_comb begin
    pcif.pc_next = '0;
    branch_mode = 0;
    jumpdest = '0;
    // Branch/PC + 4
    if (cuif.JumpSel == 2'b00) begin
      branch_mode = cuif.BNE ? ~(aluif.z_flag) : aluif.z_flag;
      // Branch
      if (cuif.PCsrc & branch_mode) begin
        pcif.pc_next = (extended_imm << 2) + pcplus4;
      end
      // PC + 4
      else begin
        pcif.pc_next = pcplus4;
      end
    end
    // JR Instruction
    else if (cuif.JumpSel == 2'b01) begin
      pcif.pc_next = rfif.rdat1;
    end
    // Jump Instruction
    else if (cuif.JumpSel == 2'b10) begin
      jumpdest = {pcplus4[31:28], dpif.imemload[25:0], 2'b00};
      pcif.pc_next = jumpdest;
    end
  end

endmodule
