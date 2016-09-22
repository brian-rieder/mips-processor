// File name:   hazard_unit.sv
// Updated:     22 September 2016
// Authors:     Brian Rieder 
//              Pooja Kale
// Description: Notifies system of structural or data hazards for stalling/forwarding

// interface 
`include "hazard_unit_if.vh"
`include "cpu_types_pkg.vh"

module hazard_unit ( 
	input logic CLK, nRST, 
	hazard_unit_if.hu huif
); 

	import cpu_types_pkg::*; 

	

endmodule
