// File name:   IF_ID.sv
// Updated:     19 September 2016
// Authors:     Brian Rieder 
//              Pooja Kale
// Description: Instruction Decode/Execute latch

// interface 
`include "ID_EX_if.vh"
`include "cpu_types_pkg.vh"

module ID_EX ( 
	input logic CLK, nRST, 
	ID_EX_if.id_ex idexif
); 

	import cpu_types_pkg::*; 
	

always_ff @(posedge CLK, negedge nRST) begin 
	if (!nRST) begin  
		idexif.pcp4_out      <= '0;
		idexif.rdat1_out     <= '0;
		idexif.rdat2_out     <= '0;
		idexif.extImm_out    <= '0;
		idexif.shamt_out     <= '0;
		idexif.op_ex         <= '0;
		idexif.ALUop_out    <= ALU_SLL;
		idexif.ALUsrc_out    <= 2'b00; // Don't care (rdat2)
		idexif.RegDst_out    <= 2'b00; // Don't care (Rt)
		idexif.JumpSel_out   <= 2'b00; // Don't care (PC+4)
		idexif.MemToReg_out  <= 2'b00; // Don't care (dmemload)
		idexif.PCsrc_out     <= 0;
		idexif.dREN_out 	 <= 0; // Don't read
		idexif.dWEN_out 	 <= 0; // Don't write
		idexif.halt_out 	 <= 0; // Don't halt
		idexif.jumpFlush_out <= 0; // Don't flush
		idexif.RegWr_out     <= 0; // Don't write
		idexif.BNE_out       <= 0;
		idexif.wsel_out      <= '0;
		idexif.j25_out       <= '0;
	end 
	else begin 
		if (ifidif.ihit)  begin 
			if(ifidif.flush) begin
				idexif.pcp4_out      <= '0;
				idexif.rdat1_out     <= '0;
				idexif.rdat2_out     <= '0;
				idexif.extImm_out    <= '0;
				idexif.shamt_out     <= '0;
				idexif.op_ex         <= '0;
				idexif.ALUop_out    <= ALU_SLL;
				idexif.ALUsrc_out    <= 2'b00; // Don't care (rdat2)
				idexif.RegDst_out    <= 2'b00; // Don't care (Rt)
				idexif.JumpSel_out   <= 2'b00; // Don't care (PC+4)
				idexif.MemToReg_out  <= 2'b00; // Don't care (dmemload)
				idexif.PCsrc_out     <= 0;
				idexif.dREN_out 	 <= 0; // Don't read
				idexif.dWEN_out 	 <= 0; // Don't write
				idexif.halt_out 	 <= 0; // Don't halt
				idexif.jumpFlush_out <= 0; // Don't flush
				idexif.RegWr_out     <= 0; // Don't write
				idexif.BNE_out       <= 0;
				idexif.wsel_out      <= '0;
				idexif.j25_out       <= '0;
			end else begin
				idexif.pcp4_out      <= idexif.pcp4_in;
				idexif.rdat1_out     <= idexif.rdat1_in;
				idexif.rdat2_out     <= idexif.rdat2_in;
				idexif.extImm_out    <= idexif.extImm_in;
				idexif.shamt_out     <= idexif.shamt_in;
				idexif.op_ex         <= idexif.op_id;
				idexif.ALUop_out    <= idexif.alu_op_in;
				idexif.ALUsrc_out    <= idexif.ALUsrc_in; 
				idexif.RegDst_out    <= idexif.RegDst_in;
				idexif.JumpSel_out   <= idexif.JumpSel_in;
				idexif.MemToReg_out  <= idexif.MemToReg_in; 
				idexif.PCsrc_out     <= idexif.PCsrc_in;
				idexif.dREN_out 	 <= idexif.dREN_in; 
				idexif.dWEN_out 	 <= idexif.dWEN_in;
				idexif.halt_out 	 <= idexif.halt_in; 
				idexif.jumpFlush_out <= idexif.jumpFlush_in;
				idexif.RegWr_out     <= idexif.RegWr_in;
				idexif.BNE_out       <= idexif.BNE_in;
				idexif.wsel_out      <= idexif.wsel_in;
				idexif.j25_out       <= idexif.j25_in;
			end
		end   
	end
end

endmodule
