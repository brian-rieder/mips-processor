// File name:   alu.sv
// Updated:     29 August 2016
// Author:      Brian Rieder 
// Description: Computational unit for processor

`include "alu_if.vh"
import cpu_types_pkg::*;

module alu
(
  alu_if.alu aluif
);

  // Flag Logic (Overflow occurs in comb block)
  assign aluif.z_flag = aluif.port_o ? 0 : 1;
  assign aluif.n_flag = aluif.port_o[WORD_W-1];

  always_comb begin
    casez(aluif.alu_op)
      ALU_SLL: begin // Shift Left Logical
        aluif.port_o = aluif.port_a << aluif.port_b;
        aluif.v_flag = 0;
      end
      ALU_SRL: begin // Shift Right Logical
        aluif.port_o = aluif.port_a >> aluif.port_b;
        aluif.v_flag = 0;
      end
      ALU_ADD: begin // Signed Addition
        aluif.port_o = $signed(aluif.port_a) + $signed(aluif.port_b);
        // Overflow Flag Determination
        if(!(aluif.port_a[WORD_W-1] ^ aluif.port_b[WORD_W-1])) begin // check only same input
          if(aluif.port_a[WORD_W-1] ^ aluif.port_o[WORD_W-1]) begin // check mismatch
            // if mismatch, then overflow
            aluif.v_flag = 1;
          end 
          else begin
            // no mismatch
            aluif.v_flag = 0;
          end
        end
        else begin
          // sign bits different on operands
          aluif.v_flag = 0;
        end
      end
      ALU_SUB: begin // Signed Subtraction
        aluif.port_o = $signed(aluif.port_a) - $signed(aluif.port_b);
        // Overflow Flag Determination
        if(!(aluif.port_a[WORD_W-1] ^ aluif.port_b[WORD_W-1])) begin // check only same input
          if(aluif.port_a[WORD_W-1] ^ aluif.port_o[WORD_W-1]) begin // check mismatch
            // if mismatch, then overflow
            aluif.v_flag = 1;
          end 
          else begin
            // no mismatch
            aluif.v_flag = 0;
          end
        end
        else begin
          // sign bits different on operands
          aluif.v_flag = 0;
        end
      end
      ALU_AND: begin // Logical AND
        aluif.port_o = aluif.port_a & aluif.port_b;
        aluif.v_flag = 0;
      end
      ALU_OR: begin // Logical OR
        aluif.port_o = aluif.port_a | aluif.port_b;
        aluif.v_flag = 0;
      end
      ALU_XOR: begin // Logical XOR
        aluif.port_o = aluif.port_a ^ aluif.port_b;
        aluif.v_flag = 0;
      end
      ALU_NOR: begin // Logical NOR
        aluif.port_o = ~(aluif.port_a | aluif.port_b);
        aluif.v_flag = 0;
      end
      ALU_SLT: begin // Signed Less Than
        aluif.port_o = $signed(aluif.port_a) < $signed(aluif.port_b);
        aluif.v_flag = 0;
      end
      ALU_SLTU: begin // Unsigned Less Than
        aluif.port_o = aluif.port_a < aluif.port_b;
        aluif.v_flag = 0;
      end
      default: begin
        // effectively a nop
      end
    endcase
  end

endmodule