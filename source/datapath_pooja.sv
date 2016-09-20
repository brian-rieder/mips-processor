/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"
`include "control_unit_if.vh"
`include "register_file_if.vh"
`include "alu_interface.vh"
`include "request_unit_if.vh"
`include "program_counter_if.vh"


// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
  import cpu_types_pkg::*;

//interfaces

control_unit_if cuif (); 
register_file_if rfif (); 
alu_interface aluif (); 
request_unit_if ruif (); 
program_counter_if pcif (); 


control_unit CU (cuif);
alu ALU (aluif);
register_file RF (CLK, nRST, rfif);
request_unit RU (CLK, nRST, ruif);
program_counter PC (CLK, nRST, pcif); 

logic [31:0] imm_ext; 
logic branch;
logic [31:0] npc; 

assign npc = pcif.pcOUT + 4;
assign rfif.rsel1 = cuif.rs; 
assign rfif.rsel2 = cuif.rt; 
assign rfif.WEN = cuif.regWr & (dpif.ihit | dpif.dhit);

//request unit 
assign ruif.ihit = dpif.ihit;
assign ruif.dhit = dpif.dhit;
assign ruif.dWEN = cuif.dWEN; 
assign ruif.dREN = cuif.dREN; 

assign aluif.portA = rfif.rdat1;
assign aluif.opcode = cuif.ALUOP;

//assign cuif.porto  = aluif.porto;
assign cuif.zero_flag  = aluif.zero;
assign cuif.instr  = dpif.imemload;
//assign dpif.imemload = 
//assign cuif.rdat2  = rfif.rdat2;

//datapath
//assign dpif.halt = cuif.halt;

always_ff @(posedge CLK, negedge nRST) begin 
	if(nRST == 1'b0) begin 
		dpif.halt <= 1'b0; 	
	end
	else begin 
		dpif.halt <= cuif.halt;	
	end
end 

assign dpif.imemREN = cuif.immemREN;
assign dpif.dmemREN = ruif.dmemREN;
assign dpif.dmemWEN = ruif.dmemWEN;
assign dpif.dmemstore = rfif.rdat2; 
assign dpif.imemaddr = pcif.pcOUT; 
assign dpif.dmemaddr = aluif.outputPort; 

assign pcif.pcEN = ruif.pcEN;

always_comb begin 
// zero_extended and sign extended 
	if(cuif.extOp == 1'b0) begin 
		imm_ext = {16'b0, cuif.imm16}; 
	end
	else begin 
		if(cuif.imm16[15] == 1'b0) 
			imm_ext = {16'b0, cuif.imm16}; 
		else 
			imm_ext = {16'b1111111111111111, cuif.imm16}; 
	end 
	

// wsel 
	if(cuif.regDest == 2'b00)  
		rfif.wsel = cuif.rt; 
	else if (cuif.regDest == 2'b01)  
		rfif.wsel = cuif.rd; 	
	else if (cuif.regDest == 2'b10) 
		rfif.wsel = 5'd31;
	else
		rfif.wsel = cuif.rt;
//wdata
	if (cuif.memToReg == 2'b00) begin 
		rfif.wdat = aluif.outputPort;	
	end 
	else if(cuif.memToReg == 2'b01) begin 
		rfif.wdat = dpif.dmemload;	
	end 
	else if (cuif.memToReg == 2'b10) begin 
		rfif.wdat = pcif.pcOUT + 4; 	
	end 
	else begin 
		rfif.wdat = {cuif.imm16, 16'h0000};
	end 

//aluSrc 
	if (cuif.aluSrc == 2'b00) begin 
		aluif.portB = rfif.rdat2;
	end 
	else if(cuif.aluSrc == 2'b01) begin 
		aluif.portB = imm_ext;	
	end 
	else if (cuif.aluSrc == 2'b10) begin 
		aluif.portB = imm_ext;	
	end 
	else begin 
		aluif.portB = cuif.shamt;	
	end 

// jumpSel 
	if (cuif.jumpSel == 2'b00) begin 
		pcif.pcNEXT = npc; 
	end 
	//BNE and BEQ
	else if(cuif.jumpSel == 2'b10) begin 
		if (cuif.BNE == 1'b0) begin //BEQ 
			if(cuif.zero_flag == 1'b1) 
				pcif.pcNEXT = (imm_ext << 2) + npc; 	 
			else 
				pcif.pcNEXT = npc;
		end	 
		else begin 
			if(cuif.zero_flag == 1'b0) 
				pcif.pcNEXT = (imm_ext << 2) + npc; 	 
			else 
				pcif.pcNEXT = npc;
		end
	end  
	else if (cuif.jumpSel == 2'b01) begin 
		pcif.pcNEXT =  {npc[31:28], cuif.imm26, 2'b00}; 
	end 
	else begin 
		pcif.pcNEXT = rfif.rdat1; 
	end 
end

// check ihit to change pcOut 



  // pc init
  parameter PC_INIT = 0;

endmodule
