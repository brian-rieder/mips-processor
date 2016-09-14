// File name:   control_unit.sv
// Updated:     11 September 2016
// Author:      Brian Rieder 
// Description: Brains of the system

// interface include
`include "control_unit_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module control_unit (
  control_unit_if.cu cuif
);
  import cpu_types_pkg::*;
  
  // Internal Values
  opcode_t op; 
  assign op = opcode_t'(cuif.imemload[31:26]);
  funct_t funct;
  assign funct = funct_t'(cuif.imemload[5:0]);

  // Non-logic dependent Outputs
  assign cuif.Rs = cuif.imemload[25:21];
  assign cuif.Rt = cuif.imemload[20:16];
  assign cuif.Rd = cuif.imemload[15:11];
  assign cuif.imm16 = cuif.imemload[15:0];
  assign cuif.shamt = {27'b0, cuif.imemload[10:6]};

  // Instruction Decoding
  always_comb begin
    casez (op)
      RTYPE: begin
        casez(funct)
          SLL: begin
            cuif.RegDst = 2'b01; // Rd
            cuif.RegWr = 1; // Write to registers
            cuif.ExtOp  = 0; // Don't care
            cuif.ALUsrc = 2'b10; // shamt
            cuif.alu_op = ALU_SLL;
            cuif.MemToReg = 0; // ALU output
            cuif.JAL = 0; // Not JAL
            cuif.LUI = 0; // Not LUI
            cuif.BNE = 0; // Don't care 
            cuif.PCsrc = 0; // PC + 4
            cuif.JumpSel = 2'b00; // PC + 4/Branch mux
          end
          SRL: begin
            cuif.RegDst = 2'b01; // Rd
            cuif.RegWr = 1; // Write to registers
            cuif.ExtOp  = 0; // Don't care
            cuif.ALUsrc = 2'b10; // shamt
            cuif.alu_op = ALU_SRL;
            cuif.MemToReg = 0; // ALU output
            cuif.JAL = 0; // Not JAL
            cuif.LUI = 0; // Not LUI
            cuif.BNE = 0; // Don't care 
            cuif.PCsrc = 0; // PC + 4
            cuif.JumpSel = 2'b00; // PC + 4/Branch mux
          end
          JR: begin
            cuif.RegDst = 2'b00; // Don't care
            cuif.RegWr = 0; // Don't write to registers
            cuif.ExtOp  = 0; // Don't care
            cuif.ALUsrc = 2'b00; // Don't care
            cuif.alu_op = ALU_SLL; // Don't care
            cuif.MemToReg = 0; // Don't care
            cuif.JAL = 0; // Not JAL
            cuif.LUI = 0; // Not LUI
            cuif.BNE = 0; // Don't care 
            cuif.PCsrc = 0; // Don't care
            cuif.JumpSel = 2'b01; // rdat1 for JR
          end
          ADD: begin
            cuif.RegDst = 2'b01; // Rd
            cuif.RegWr = 1; // Write to registers
            cuif.ExtOp  = 0; // Don't care
            cuif.ALUsrc = 2'b01; // rdat2
            cuif.alu_op = ALU_ADD;
            cuif.MemToReg = 0; // ALU output
            cuif.JAL = 0; // Not JAL
            cuif.LUI = 0; // Not LUI
            cuif.BNE = 0; // Don't care 
            cuif.PCsrc = 0; // PC + 4
            cuif.JumpSel = 2'b00; // PC + 4/Branch mux
          end
          ADDU: begin
            cuif.RegDst = 2'b01; // Rd
            cuif.RegWr = 1; // Write to registers
            cuif.ExtOp  = 0; // Don't care
            cuif.ALUsrc = 2'b01; // rdat2
            cuif.alu_op = ALU_ADD;
            cuif.MemToReg = 0; // ALU output
            cuif.JAL = 0; // Not JAL
            cuif.LUI = 0; // Not LUI
            cuif.BNE = 0; // Don't care 
            cuif.PCsrc = 0; // PC + 4
            cuif.JumpSel = 2'b00; // PC + 4/Branch mux
          end
          SUB: begin
            cuif.RegDst = 2'b01; // Rd
            cuif.RegWr = 1; // Write to registers
            cuif.ExtOp  = 0; // Don't care
            cuif.ALUsrc = 2'b01; // rdat2
            cuif.alu_op = ALU_SUB;
            cuif.MemToReg = 0; // ALU output
            cuif.JAL = 0; // Not JAL
            cuif.LUI = 0; // Not LUI
            cuif.BNE = 0; // Don't care 
            cuif.PCsrc = 0; // PC + 4
            cuif.JumpSel = 2'b00; // PC + 4/Branch mux
          end
          SUBU: begin
            cuif.RegDst = 2'b01; // Rd
            cuif.RegWr = 1; // Write to registers
            cuif.ExtOp  = 0; // Don't care
            cuif.ALUsrc = 2'b01; // rdat2
            cuif.alu_op = ALU_SUB;
            cuif.MemToReg = 0; // ALU output
            cuif.JAL = 0; // Not JAL
            cuif.LUI = 0; // Not LUI
            cuif.BNE = 0; // Don't care 
            cuif.PCsrc = 0; // PC + 4
            cuif.JumpSel = 2'b00; // PC + 4/Branch mux
          end
          AND: begin
            cuif.RegDst = 2'b01; // Rd
            cuif.RegWr = 1; // Write to registers
            cuif.ExtOp  = 0; // Don't care
            cuif.ALUsrc = 2'b01; // rdat2
            cuif.alu_op = ALU_AND;
            cuif.MemToReg = 0; // ALU output
            cuif.JAL = 0; // Not JAL
            cuif.LUI = 0; // Not LUI
            cuif.BNE = 0; // Don't care 
            cuif.PCsrc = 0; // PC + 4
            cuif.JumpSel = 2'b00; // PC + 4/Branch mux
          end
          OR: begin
            cuif.RegDst = 2'b01; // Rd
            cuif.RegWr = 1; // Write to registers
            cuif.ExtOp  = 0; // Don't care
            cuif.ALUsrc = 2'b01; // rdat2
            cuif.alu_op = ALU_OR;
            cuif.MemToReg = 0; // ALU output
            cuif.JAL = 0; // Not JAL
            cuif.LUI = 0; // Not LUI
            cuif.BNE = 0; // Don't care 
            cuif.PCsrc = 0; // PC + 4
            cuif.JumpSel = 2'b00; // PC + 4/Branch mux
          end
          XOR: begin
            cuif.RegDst = 2'b01; // Rd
            cuif.RegWr = 1; // Write to registers
            cuif.ExtOp  = 0; // Don't care
            cuif.ALUsrc = 2'b01; // rdat2
            cuif.alu_op = ALU_XOR;
            cuif.MemToReg = 0; // ALU output
            cuif.JAL = 0; // Not JAL
            cuif.LUI = 0; // Not LUI
            cuif.BNE = 0; // Don't care 
            cuif.PCsrc = 0; // PC + 4
            cuif.JumpSel = 2'b00; // PC + 4/Branch mux
          end
          NOR: begin
            cuif.RegDst = 2'b01; // Rd
            cuif.RegWr = 1; // Write to registers
            cuif.ExtOp  = 0; // Don't care
            cuif.ALUsrc = 2'b01; // rdat2
            cuif.alu_op = ALU_NOR;
            cuif.MemToReg = 0; // ALU output
            cuif.JAL = 0; // Not JAL
            cuif.LUI = 0; // Not LUI
            cuif.BNE = 0; // Don't care 
            cuif.PCsrc = 0; // PC + 4
            cuif.JumpSel = 2'b00; // PC + 4/Branch mux
          end
          SLT: begin
            cuif.RegDst = 2'b01; // Rd
            cuif.RegWr = 1; // Write to registers
            cuif.ExtOp  = 0; // Don't care
            cuif.ALUsrc = 2'b01; // rdat2
            cuif.alu_op = ALU_SLT;
            cuif.MemToReg = 0; // ALU output
            cuif.JAL = 0; // Not JAL
            cuif.LUI = 0; // Not LUI
            cuif.BNE = 0; // Don't care 
            cuif.PCsrc = 0; // PC + 4
            cuif.JumpSel = 2'b00; // PC + 4/Branch mux
          end
          SLTU: begin
            cuif.RegDst = 2'b01; // Rd
            cuif.RegWr = 1; // Write to registers
            cuif.ExtOp  = 0; // Don't care
            cuif.ALUsrc = 2'b01; // rdat2
            cuif.alu_op = ALU_SLTU;
            cuif.MemToReg = 0; // ALU output
            cuif.JAL = 0; // Not JAL
            cuif.LUI = 0; // Not LUI
            cuif.BNE = 0; // Don't care 
            cuif.PCsrc = 0; // PC + 4
            cuif.JumpSel = 2'b00; // PC + 4/Branch mux
          end
        endcase
        // To Request Unit
        cuif.imemREN = 1;
        cuif.halt = 0;
        cuif.dWEN = 0;
        cuif.dREN = 0;
      end
      J: begin
        cuif.RegDst = 2'b00; // Don't care
        cuif.RegWr = 0; // No write
        cuif.ExtOp  = 0; // Don't care
        cuif.ALUsrc = 2'b00; // Don't care
        cuif.alu_op = ALU_XOR; // Don't care
        cuif.MemToReg = 0; // Don't care
        cuif.JAL = 0; // Not JAL
        cuif.LUI = 0; // Not LUI
        cuif.BNE = 0; // Don't care 
        cuif.PCsrc = 0; // Don't care
        cuif.JumpSel = 2'b10; // Jump mux
        // To Request Unit
        cuif.imemREN = 1;
        cuif.halt = 0;
        cuif.dWEN = 0;
        cuif.dREN = 0;
      end
      JAL: begin
        cuif.RegDst = 2'b10; // Write to Reg 31
        cuif.RegWr = 1; // Writing to register
        cuif.ExtOp  = 0; // Don't care
        cuif.ALUsrc = 2'b00; // Don't care
        cuif.alu_op = ALU_XOR; // Don't care
        cuif.MemToReg = 0; // Don't care
        cuif.JAL = 1; // JAL
        cuif.LUI = 0; // Not LUI
        cuif.BNE = 0; // Don't care 
        cuif.PCsrc = 0; // Don't care
        cuif.JumpSel = 2'b10; // Jump mux
        // To Request Unit
        cuif.imemREN = 1;
        cuif.halt = 0;
        cuif.dWEN = 0;
        cuif.dREN = 0;
      end
      BEQ: begin
        cuif.RegDst = 2'b00; // Don't care
        cuif.RegWr = 0; // Not writing
        cuif.ExtOp  = 0; // Zero Extension
        cuif.ALUsrc = 2'b01; // rdat2 R[rt]
        cuif.alu_op = ALU_SUB; // Subtraction to find if equal
        cuif.MemToReg = 0; // Don't care - zero flag
        cuif.JAL = 0; // Not JAL
        cuif.LUI = 0; // Not LUI
        cuif.BNE = 0; // Choose Zero flag
        cuif.PCsrc = 1; // Branch addition
        cuif.JumpSel = 2'b00; // Branch/PC+4 mux
        // To Request Unit
        cuif.imemREN = 1;
        cuif.halt = 0;
        cuif.dWEN = 0;
        cuif.dREN = 0;
      end
      BNE: begin
        cuif.RegDst = 2'b00; // Don't care
        cuif.RegWr = 0; // Not writing
        cuif.ExtOp  = 0; // Zero Extension
        cuif.ALUsrc = 2'b01; // rdat2 R[rt]
        cuif.alu_op = ALU_SUB; // Subtraction to find if equal
        cuif.MemToReg = 0; // Don't care - zero flag
        cuif.JAL = 0; // Not JAL
        cuif.LUI = 0; // Not LUI
        cuif.BNE = 1; // Not Zero flag
        cuif.PCsrc = 1; // Branch addition
        cuif.JumpSel = 2'b00; // Branch/PC+4 mux
        // To Request Unit
        cuif.imemREN = 1;
        cuif.halt = 0;
        cuif.dWEN = 0;
        cuif.dREN = 0;
      end
      ADDI: begin
        cuif.RegDst = 2'b00; // Rt
        cuif.RegWr = 1; // Writing to register
        cuif.ExtOp  = 1; // Signed Extension
        cuif.ALUsrc = 2'b00; // Immediate
        cuif.alu_op = ALU_ADD;
        cuif.MemToReg = 0; // ALU output
        cuif.JAL = 0; // Not JAL
        cuif.LUI = 0; // Not LUI
        cuif.BNE = 0; // Don't care 
        cuif.PCsrc = 0; // PC+4
        cuif.JumpSel = 2'b00; // Branch/PC+4 mux
        // To Request Unit
        cuif.imemREN = 1;
        cuif.halt = 0;
        cuif.dWEN = 0;
        cuif.dREN = 0;
      end
      ADDIU: begin
        cuif.RegDst = 2'b00; // Rt
        cuif.RegWr = 1; // Writing to register
        cuif.ExtOp  = 1; // Signed Extension
        cuif.ALUsrc = 2'b00; // Immediate
        cuif.alu_op = ALU_ADD;
        cuif.MemToReg = 2'b00; // ALU output
        cuif.JAL = 0; // Not JAL
        cuif.LUI = 0; // Not LUI
        cuif.BNE = 0; // Don't care 
        cuif.PCsrc = 0; // PC+4
        cuif.JumpSel = 0; // Branch/PC+4 mux
        // To Request Unit
        cuif.imemREN = 1;
        cuif.halt = 0;
        cuif.dWEN = 0;
        cuif.dREN = 0;
      end
      SLTI: begin
        cuif.RegDst = 2'b00; // Rt
        cuif.RegWr = 1; // Writing to register
        cuif.ExtOp  = 1; // Signed Extension
        cuif.ALUsrc = 2'b00; // Immediate
        cuif.alu_op = ALU_SLT;
        cuif.MemToReg = 2'b00; // ALU output
        cuif.JAL = 0; // Not JAL
        cuif.LUI = 0; // Not LUI
        cuif.BNE = 0; // Don't care 
        cuif.PCsrc = 0; // PC+4
        cuif.JumpSel = 0; // Branch/PC+4 mux
        // To Request Unit
        cuif.imemREN = 1;
        cuif.halt = 0;
        cuif.dWEN = 0;
        cuif.dREN = 0;
      end
      SLTIU: begin
        cuif.RegDst = 2'b00; // Rt
        cuif.RegWr = 1; // Writing to register
        cuif.ExtOp  = 1; // Signed Extension
        cuif.ALUsrc = 2'b00; // Immediate
        cuif.alu_op = ALU_SLTU;
        cuif.MemToReg = 2'b00; // ALU output
        cuif.JAL = 0; // Not JAL
        cuif.LUI = 0; // Not LUI
        cuif.BNE = 0; // Don't care 
        cuif.PCsrc = 0; // PC+4
        cuif.JumpSel = 0; // Branch/PC+4 mux
        // To Request Unit
        cuif.imemREN = 1;
        cuif.halt = 0;
        cuif.dWEN = 0;
        cuif.dREN = 0;
      end
      ANDI: begin
        cuif.RegDst = 2'b00; // Rt
        cuif.RegWr = 1; // Writing to register
        cuif.ExtOp  = 0; // Zero Extension
        cuif.ALUsrc = 2'b00; // Immediate
        cuif.alu_op = ALU_AND;
        cuif.MemToReg = 0; // ALU output
        cuif.JAL = 0; // Not JAL
        cuif.LUI = 0; // Not LUI
        cuif.BNE = 0; // Don't care 
        cuif.PCsrc = 0; // PC+4
        cuif.JumpSel = 2'b00; // Branch/PC+4 mux
        // To Request Unit
        cuif.imemREN = 1;
        cuif.halt = 0;
        cuif.dWEN = 0;
        cuif.dREN = 0;
      end
      ORI: begin
        cuif.RegDst = 2'b00; // Rt
        cuif.RegWr = 1; // Writing to register
        cuif.ExtOp  = 0; // Zero Extension
        cuif.ALUsrc = 2'b00; // Immediate
        cuif.alu_op = ALU_OR;
        cuif.MemToReg = 0; // ALU output
        cuif.JAL = 0; // Not JAL
        cuif.LUI = 0; // Not LUI
        cuif.BNE = 0; // Don't care 
        cuif.PCsrc = 0; // PC+4
        cuif.JumpSel = 2'b00; // Branch/PC+4 mux
        // To Request Unit
        cuif.imemREN = 1;
        cuif.halt = 0;
        cuif.dWEN = 0;
        cuif.dREN = 0;
      end
      XORI: begin
        cuif.RegDst = 2'b00; // Rt
        cuif.RegWr = 1; // Writing to register
        cuif.ExtOp  = 0; // Zero Extension
        cuif.ALUsrc = 2'b00; // Immediate
        cuif.alu_op = ALU_XOR;
        cuif.MemToReg = 0; // ALU output
        cuif.JAL = 0; // Not JAL
        cuif.LUI = 0; // Not LUI
        cuif.BNE = 0; // Don't care 
        cuif.PCsrc = 0; // PC+4
        cuif.JumpSel = 2'b00; // Branch/PC+4 mux
        // To Request Unit
        cuif.imemREN = 1;
        cuif.halt = 0;
        cuif.dWEN = 0;
        cuif.dREN = 0;
      end
      LUI: begin
        cuif.RegDst = 2'b00; // Rt
        cuif.RegWr = 1; // Writing to register
        cuif.ExtOp  = 0; // Don't care
        cuif.ALUsrc = 2'b00; // Don't care
        cuif.alu_op = ALU_SLL; // Don't care
        cuif.MemToReg = 0; // Don't care
        cuif.JAL = 0; // Not JAL
        cuif.LUI = 1; // LUI
        cuif.BNE = 0; // Don't care 
        cuif.PCsrc = 0; // PC+4
        cuif.JumpSel = 2'b00; // Branch/PC+4 mux
        // To Request Unit
        cuif.imemREN = 1;
        cuif.halt = 0;
        cuif.dWEN = 0;
        cuif.dREN = 0;
      end
      LW: begin
        cuif.RegDst = 2'b00; // Rt
        cuif.RegWr = 1; // Writing to register
        cuif.ExtOp  = 1; // Signed Extension
        cuif.ALUsrc = 2'b00; // Immediate
        cuif.alu_op = ALU_ADD; // Calculate memory offset
        cuif.MemToReg = 1; // dmemload
        cuif.JAL = 0; // Not JAL
        cuif.LUI = 0; // Not LUI
        cuif.BNE = 0; // Don't care 
        cuif.PCsrc = 0; // PC+4
        cuif.JumpSel = 2'b00; // Branch/PC+4 mux
        // To Request Unit
        cuif.imemREN = 1;
        cuif.halt = 0;
        cuif.dWEN = 0;
        cuif.dREN = 1;
      end
      SW: begin
        cuif.RegDst = 2'b00; // Rt
        cuif.RegWr = 0; // Not writing to register
        cuif.ExtOp  = 1; // Signed Extension
        cuif.ALUsrc = 2'b00; // Immediate
        cuif.alu_op = ALU_ADD; // Calculate memory offset
        cuif.MemToReg = 0; // Don't care
        cuif.JAL = 0; // Not JAL
        cuif.LUI = 0; // Not LUI
        cuif.BNE = 0; // Don't care 
        cuif.PCsrc = 0; // PC+4
        cuif.JumpSel = 2'b00; // Branch/PC+4 mux
        // To Request Unit
        cuif.imemREN = 1;
        cuif.halt = 0;
        cuif.dWEN = 1;
        cuif.dREN = 0;
      end
      LL: begin
        cuif.RegDst = 2'b00; // Rt
        cuif.RegWr = 1; // Writing to register
        cuif.ExtOp  = 1; // Signed Extension
        cuif.ALUsrc = 2'b00; // Immediate
        cuif.alu_op = ALU_ADD; // Calculate memory offset
        cuif.MemToReg = 1; // dmemload
        cuif.JAL = 0; // Not JAL
        cuif.LUI = 0; // Not LUI
        cuif.BNE = 0; // Don't care 
        cuif.PCsrc = 0; // PC+4
        cuif.JumpSel = 2'b00; // Branch/PC+4 mux
        // To Request Unit
        cuif.imemREN = 1;
        cuif.halt = 0;
        cuif.dWEN = 0;
        cuif.dREN = 1;
      end
      SC: begin
        cuif.RegDst = 2'b00; // Rt
        cuif.RegWr = 0; // Not writing to register
        cuif.ExtOp  = 1; // Signed Extension
        cuif.ALUsrc = 2'b00; // Immediate
        cuif.alu_op = ALU_ADD; // Calculate memory offset
        cuif.MemToReg = 0; // Don't care
        cuif.JAL = 0; // Not JAL
        cuif.LUI = 0; // Not LUI
        cuif.BNE = 0; // Don't care 
        cuif.PCsrc = 0; // PC+4
        cuif.JumpSel = 2'b00; // Branch/PC+4 mux
        // To Request Unit
        cuif.imemREN = 1;
        cuif.halt = 0;
        cuif.dWEN = 1;
        cuif.dREN = 0;
      end
      HALT: begin
        cuif.RegWr = 0; // Not writing to register -- this one is needed
        cuif.RegDst = 2'b00; // Don't care
        cuif.ExtOp  = 0; // Don't care
        cuif.ALUsrc = 2'b00; // Don't care
        cuif.alu_op = ALU_ADD; // Don't care
        cuif.MemToReg = 0; // Don't care
        cuif.JAL = 0; // Don't care
        cuif.LUI = 0; // Don't care
        cuif.BNE = 0; // Don't care 
        cuif.PCsrc = 0; // PC+4
        cuif.JumpSel = 2'b00; // Branch/PC+4 mux
        // To Request Unit
        cuif.imemREN = 1;
        cuif.halt = 1;
        cuif.dWEN = 0;
        cuif.dREN = 0;
      end
      default: begin
        cuif.RegWr = 0; // Not writing to register -- this one is needed
        cuif.RegDst = 2'b00; // Don't care
        cuif.ExtOp  = 0; // Don't care
        cuif.ALUsrc = 2'b00; // Don't care
        cuif.alu_op = ALU_ADD; // Don't care
        cuif.MemToReg = 0; // Don't care
        cuif.JAL = 0; // Don't care
        cuif.LUI = 0; // Don't care
        cuif.BNE = 0; // Don't care 
        cuif.PCsrc = 0; // PC+4
        cuif.JumpSel = 2'b00; // Branch/PC+4 mux
        // To Request Unit
        cuif.imemREN = 1;
        cuif.halt = 0;
        cuif.dWEN = 0;
        cuif.dREN = 0;
      end
    endcase
  end


endmodule
