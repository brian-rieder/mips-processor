// interface 
`include "EX_MEM_if.vh"
`include "cpu_types_pkg.vh"

module EX_MEM ( 
	input logic CLK, nRST, 
	EX_MEM_if.ex_mem exmemif
); 

	import cpu_types_pkg::*; 
	

always_ff @(posedge CLK, negedge nRST) begin 
	if (nRST == 1'b0) begin  
		regDest_out <= '0; 
		dREN_out <= '0;
		dWEN_out <= '0;
		dmemstore_out <= '0;  
		regWr_out <= '0;
		memToReg_out <= '0; 
		halt_out <= '0;
		portO_out <= '0;
		luiValue_out <= '0; 
		pc4_out <= '0; 
	end 
	else begin 
	
	if(exmemif.ihit == 1'b1 || exmemif.dhit == 1'b1 )  begin 
		exmemif.regDest_out <= exmemif.regDest_in; 
		exmemif.dREN_out <= exmemif.dREN_in; 
		exmemif.dWEN_out <= exmemif.dWEN_in;
		exmemif.dmemstore_out <= exmemif.dmemstore_in;  
		exmemif.regWr_out <= exmemif.regWr_in;
		exmemif.memToReg_out <= exmemif.memToReg_in; 
		exmemif.halt_out <= exmemif.halt_in;
		exmemif.portO_out <= exmemif.portO_in;
		exmemif.luiValue_out <= exmemif.luiValue_in;  
		exmemif.pc4_out <= exmemif.pc4_in; 
			 			
		end   
	end
	
end

endmodule
