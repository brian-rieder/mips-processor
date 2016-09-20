/*
  Eric Villasenor
  evillase@gmail.com

  register file interface
*/
`ifndef MEMORY_WRITEBACK_IF_VH
`define MEMORY_WRITEBACK_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface memory_writeback_if;
  // import types
  import cpu_types_pkg::*;
	

	logic [1:0]	regDest_in, regDest_out; 
	logic [31:0]	dmemload_in_in, dmemload_out, 
	logic 		regWr_in, regWr_out, 
	logic 		wsel_in, wsel_out,
	logic [1:0]	memToReg_in, memToReg_out, 
	logic 		halt_in, halt_out, 
	logic [31:0]	portO_in, portO_out, 
	logic [31:0]	luiValue_in, luiValue_out,
	logic		ihit,dhit 
  	logic [31:0]	pc4_in, pc4_out	


  // control unit ports
  modport memwb (
    input   	regDest_in, 
		dmemload_in,
		regWr_in, 
		wsel_in,
		memToReg_in, 
		halt_in, 
		portO_in, 
		luiValue_in, 
		ihit, 
		dhit, 
		pc4_in,	
		
    output  	regDest_out, 
		dmemload_out, 
		regWr_out, 	
		wsel_in,
		memToReg_out, 
		halt_out, 
		portO_out, 
		luiValue_out, 
		pc4_out
  );
  // control unit tb
  modport tb (
    input   	regDest_in, 
		dmemload_in,
		regWr_in, 
		wsel_in,
		memToReg_in, 
		halt_in, 
		portO_in, 
		luiValue_in, 
		ihit, 
		dhit, 
		pc4_in,	
		
    output  	regDest_out, 
		dmemload_out, 
		regWr_out, 	
		wsel_in,
		memToReg_out, 
		halt_out, 
		portO_out, 
		luiValue_out, 
		pc4_out
  );
endinterface

`endif //EXECUTE_MEMORY_IF_VH

