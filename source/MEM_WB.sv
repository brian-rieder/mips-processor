// interface 
`include "MEM_WB_if.vh"
`include "cpu_types_pkg.vh"

module MEM_WB ( 
	input logic CLK, nRST, 
	MEM_WB_if.mem_wb memwbif
); 

	import cpu_types_pkg::*; 
	

always_ff @(posedge CLK, negedge nRST) begin 
	if (!nRST) begin  
		memwbif.dmemload_out <= '0;  
		memwbif.RegWr_out    <= '0;
        memwbif.wsel_out     <= '0; 
		memwbif.MemToReg_out <= '0; 
		memwbif.halt_out     <= '0;
		memwbif.portO_out    <= '0;
		memwbif.luiValue_out <= '0; 
		memwbif.pcp4_out     <= '0; 
		memwbif.op_wb        <= RTYPE;
	end 
	else begin 
		if (memwbif.ihit || memwbif.dhit)  begin 
			memwbif.dmemload_out <= memwbif.dmemload_in;  
			memwbif.RegWr_out    <= memwbif.RegWr_in;
	        memwbif.wsel_out     <= memwbif.wsel_in; 
			memwbif.MemToReg_out <= memwbif.MemToReg_in; 
			memwbif.halt_out     <= memwbif.halt_in;
			memwbif.portO_out    <= memwbif.portO_in;
			memwbif.luiValue_out <= memwbif.luiValue_in; 
			memwbif.pcp4_out     <= memwbif.pcp4_in; 
			memwbif.op_wb        <= memwbif.op_mem;
		end   
	end
	
end

endmodule
