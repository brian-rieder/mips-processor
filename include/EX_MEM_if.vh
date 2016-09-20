/*
  Eric Villasenor
  evillase@gmail.com

  register file interface
*/
`ifndef EX_MEM_IF_VH
`define EX_MEM_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface EX_MEM_if;
  // import types
  import cpu_types_pkg::*;
	

	logic [1:0]	 regDest_in,   regDest_out; 
	logic 		 dREN_in,      dREN_out, dWEN_in, dWEN_out;
	logic [31:0] dmemstore_in, dmemstore_out;
	logic 		 regWr_in,     regWr_out;
	logic [1:0]	 MemToReg_in,  MemToReg_out;
	logic        halt_in,      halt_out;
	logic [31:0] portO_in,     portO_out;
	logic [31:0] luiValue_in,  luiValue_out;
	logic        ihit,         dhit;
  	logic [31:0] pcp4_in,       pcp4_out;
    regbits_t    wsel_in,      wsel_out;
    opcode_t     op_ex,        op_mem;


  // control unit ports
  modport ex_mem (
    input   	
        regDest_in, 
		dREN_in, 
		dWEN_in, 
		dmemstore_in, 
		regWr_in, 
		MemToReg_in, 
		halt_in, 
		portO_in, 
		luiValue_in, 
		ihit, 
		dhit, 
		pcp4_in,	
        wsel_in,
        op_ex,
		
    output  	
        regDest_out, 
		dREN_out, 
		dWEN_out, 
		dmemstore_out, 
		regWr_out, 
		MemToReg_out, 
		halt_out, 
		portO_out, 
		luiValue_out, 
		pcp4_out,
        wsel_out,
        op_mem
  );
  // control unit tb
  modport tb (
    output   	
        regDest_in, 
		dREN_in, 
		dWEN_in, 
		dmemstore_in, 
		regWr_in, 
		MemToReg_in, 
		halt_in, 
		portO_in, 
		luiValue_in, 
		ihit, 
		dhit, 
        wsel_in,
		pcp4_in,	
		
    input  	
        regDest_out, 
		dREN_out, 
		dWEN_out, 
		dmemstore_out, 
		regWr_out, 
		MemToReg_out, 
		halt_out, 
		portO_out, 
		luiValue_out, 
        wsel_out,
		pcp4_out
  );

endinterface

`endif //MEMORY_WRITEBACK_IF_VH

