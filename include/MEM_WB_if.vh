/*
  Eric Villasenor
  evillase@gmail.com

  register file interface
*/
`ifndef MEM_WB_IF_VH
`define MEM_WB_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface MEM_WB_if;
  // import types
  import cpu_types_pkg::*;
	

	logic [1:0]	 RegDst_in,  RegDst_out; 
	logic [31:0] dmemload_in, dmemload_out;
	logic 		 RegWr_in,    RegWr_out;
	regbits_t    wsel_in,     wsel_out;
	logic [1:0]	 MemToReg_in, MemToReg_out;
	logic 		 halt_in,     halt_out;
	logic [31:0] portO_in,    portO_out;
	logic [31:0] luiValue_in, luiValue_out;
	logic		 ihit,        dhit;
  	logic [31:0] pcp4_in,      pcp4_out;
    opcode_t     op_mem,      op_wb;


  // control unit ports
  modport mem_wb (
    input  RegDst_in, 
		   dmemload_in,
		   RegWr_in, 
		   wsel_in,
		   MemToReg_in, 
		   halt_in, 
		   portO_in, 
		   luiValue_in, 
		   ihit, 
		   dhit, 
		   pcp4_in,	
           op_mem,
		
    output RegDst_out, 
		   dmemload_out, 
		   RegWr_out, 	
		   wsel_out,
		   MemToReg_out, 
		   halt_out, 
		   portO_out, 
		   luiValue_out, 
		   pcp4_out,
           op_wb
  );
  // MEM WB tb
  modport tb (
    input  RegDst_in, 
		   dmemload_in,
		   RegWr_in, 
		   wsel_in,
		   MemToReg_in, 
		   halt_in, 
		   portO_in, 
		   luiValue_in, 
		   ihit, 
		   dhit, 
		   pcp4_in,	
		
    output RegDst_out, 
		   dmemload_out, 
		   RegWr_out, 	
		   wsel_out,
		   MemToReg_out, 
		   halt_out, 
		   portO_out, 
		   luiValue_out, 
		   pcp4_out
  );
endinterface

`endif //MEM_WB_IF_VH

