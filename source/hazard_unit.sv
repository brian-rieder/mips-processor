// File name:   hazard_unit.sv
// Updated:     22 September 2016
// Authors:     Brian Rieder 
//              Pooja Kale
// Description: Notifies system of structural or data hazards for stalling/forwarding

// interface 
`include "hazard_unit_if.vh"
`include "cpu_types_pkg.vh"

module hazard_unit ( 
	hazard_unit_if.hu huif
); 

	import cpu_types_pkg::*; 

	logic memstall, hazard;
	assign memstall = (!huif.dhit & (huif.mem_op == LW | huif.mem_op == SW));

	// always_comb begin
	// 	if (huif.BranchFlush || huif.JumpFlush) begin
	// 		huif.IFID_enable = huif.ihit;
	// 		huif.IFID_flush  = 1;
	// 	end else if (memstall) begin
	// 		huif.IFID_enable = 0;
	// 		huif.IFID_flush  = 0;
	// 	end else if (hazard) begin
	// 		huif.IFID_enable = 0;
	// 		huif.IFID_flush  = 0;
	// 	end else begin
	// 		huif.IFID_enable = huif.ihit;
	// 		huif.IFID_flush  = 0;
	// 	end
	// end
	// assign huif.IFID_enable  = (huif.ihit & !memstall);
	assign huif.IFID_enable  = huif.ihit;
	assign huif.IFID_flush   = (huif.BranchFlush | huif.JumpFlush);

	// assign huif.IDEX_enable  = (huif.ihit & !memstall);
	assign huif.IDEX_enable  = huif.ihit;
	assign huif.IDEX_flush   = (huif.BranchFlush | huif.JumpFlush);

	// assign huif.EXMEM_enable = (huif.ihit & !memstall);
	assign huif.EXMEM_enable = (huif.ihit | huif.dhit);
	assign huif.EXMEM_flush  = huif.dhit;

	assign huif.MEMWB_enable = (huif.ihit | huif.dhit);
	// assign huif.pcWEN        = (huif.ihit & !memstall);
	assign huif.pcWEN        = huif.ihit;

	// RAW Hazards
	// always_comb begin
	// 	if (huif.id_op == RTYPE) begin
	// 		// RTYPE in ID hazard
	// 		if (((huif.Rs == huif.idex_wsel)  & huif.idex_regWr) || 
	// 			((huif.Rs == huif.exmem_wsel) & huif.exmem_regWr) ||
	// 		    ((huif.Rt == huif.idex_wsel)  & huif.idex_regWr) || 
	// 		    ((huif.Rt == huif.exmem_wsel) & huif.exmem_regWr)) begin
	// 			hazard = 1;
	// 		end
	// 	end else if (huif.id_op == JAL || huif.id_op == J || huif.id_op == HALT) begin
	// 		// No RAW hazard
	// 		hazard = 0;
	// 	end else begin
	// 		// ITYPE in ID hazard
	// 		if (((huif.Rs == huif.idex_wsel)  & huif.idex_regWr) || 
	// 			((huif.Rs == huif.exmem_wsel) & huif.exmem_regWr)) begin
	// 			// We have a hazard
	// 			hazard = 1;
	// 		end
	// 	end
	// 	// No hazard
	// end




endmodule
