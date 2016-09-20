// interface 
`include "MEM_WB_if.vh"
`include "cpu_types_pkg.vh"

module MEM_WB ( 
	input logic CLK, nRST, 
	MEM_WB_if.ex_mem exmemif
); 

	import cpu_types_pkg::*; 
	

always_ff @(posedge CLK, negedge nRST) begin 
	if (nRST == 1'b0) begin  
		regDest_out <= '0; 
		dmemload_out <= '0;  
		regWr_out <= '0;
        wsel_out <= '0; 
		memToReg_out <= '0; 
		halt_out <= '0;
		portO_out <= '0;
		luiValue_out <= '0; 
		pc4_out <= '0; 
	end 
	else begin 
	
	if(exmemif.ihit == 1'b1 || exmemif.dhit == 1'b1 )  begin 
		regDest_out <= regDest_in; 
		dmemload_out <= dmemload_in;  
		regWr_out <= regWr_in;
        wsel_out <= wsel_in; 
		memToReg_out <= memToReg_in; 
		halt_out <= halt_in;
		portO_out <= portO_in;
		luiValue_out <= luiValue_in; 
		pc4_out <= pc4_in; 
			 			
		end   
	end
	
end

endmodule
