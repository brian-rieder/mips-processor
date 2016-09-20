// File name:   IF_ID.sv
// Updated:     19 September 2016
// Authors:     Brian Rieder 
//              Pooja Kale
// Description: Instruction Fetch/Instruction Decode latch

// interface 
`include "IF_ID_if.vh"
`include "cpu_types_pkg.vh"

module IF_ID ( 
	input logic CLK, nRST, 
	IF_ID_if.if_id ifidif
); 

	import cpu_types_pkg::*; 
	

always_ff @(posedge CLK, negedge nRST) begin 
	if (!nRST) begin  
		ifidif.imemload_out <= 32'h0000;
		ifidif.pcp4_out <= 32'h0000; 
	end 
	else begin 
		if (ifidif.ihit)  begin 
			if(ifidif.flush) begin
				ifidif.imemload_out <= 32'h0000;
				ifidif.pcp4_out <= 32'h0000;
			end else begin
				ifidif.imemload_out <= ifidif.imemload_in;
				ifidif.pcp4_out <= ifidif.pcp4_in;
			end
		end   
	end
end

endmodule
