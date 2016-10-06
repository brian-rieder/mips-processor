// File name:   branch_predictor.sv
// Updated:     4 October 2016
// Authors:     Brian Rieder 
//              Pooja Kale
// Description: Four-entry branch table to determine NPC upon a branch
//              - Current design: Always taken branch predictor

// interface 
`include "branch_predictor_if.vh"
`include "cpu_types_pkg.vh"

module branch_predictor ( 
	input logic CLK, nRST,
	branch_predictor_if.bp bpif
); 

	import cpu_types_pkg::*; 

	// Local variables
	logic [1:0] curr_idx;
	logic [1:0] ex_idx;
	logic [27:0] curr_tag;
	branchentry_t branch_table [3:0];

	assign curr_idx     = bpif.curr_pc[3:2];
	assign curr_tag     = bpif.curr_pc[31:4];
	assign bpif.bp_pc   = branch_table[curr_idx].value;
	assign bpif.btb_hit = branch_table[curr_idx].valid & (branch_table[curr_idx].tag == curr_tag);
	assign ex_idx       = bpif.update_pc[3:2];

	// always_comb begin
	always_ff @ (posedge CLK, negedge nRST) begin
		if (!nRST) begin
			branch_table[0] = '0;
			branch_table[1] = '0;
			branch_table[2] = '0;
			branch_table[3] = '0;
		end
		else if(bpif.branch_flush) begin
			branch_table[ex_idx].valid = 1;
			branch_table[ex_idx].tag   = bpif.update_pc[31:4];
			branch_table[ex_idx].value = bpif.branch_target;
		end
	end

	// no resets

endmodule
