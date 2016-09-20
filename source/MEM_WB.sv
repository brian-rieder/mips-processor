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
		memwbif.regDest_out <= '0; 
		memwbif.dmemload_out <= '0;  
		memwbif.regWr_out <= '0;
        memwbif.wsel_out <= '0; 
		memwbif.memToReg_out <= '0; 
		memwbif.halt_out <= '0;
		memwbif.portO_out <= '0;
		memwbif.luiValue_out <= '0; 
		memwbif.pc4_out <= '0; 
		memwbif.op_wb <= '0;
	end 
	else begin 
		if (memwbif.ihit || memwbif.dhit)  begin 
			memwbif.regDest_out <= memwbif.regDest_in; 
			memwbif.dmemload_out <= memwbif.dmemload_in;  
			memwbif.regWr_out <= memwbif.regWr_in;
	        memwbif.wsel_out <= memwbif.wsel_in; 
			memwbif.memToReg_out <= memwbif.memToReg_in; 
			memwbif.halt_out <= memwbif.halt_in;
			memwbif.portO_out <= memwbif.portO_in;
			memwbif.luiValue_out <= memwbif.luiValue_in; 
			memwbif.pc4_out <= memwbif.pc4_in; 
			memwbif.op_wb <= memwbif.op_mem;
		end   
	end
	
end

endmodule
