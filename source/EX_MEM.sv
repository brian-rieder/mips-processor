// interface 
`include "EX_MEM_if.vh"
`include "cpu_types_pkg.vh"

module EX_MEM ( 
	input logic CLK, nRST, 
	EX_MEM_if.ex_mem exmemif
); 

	import cpu_types_pkg::*; 
	

always_ff @(posedge CLK, negedge nRST) begin 
	if (!nRST) begin  
		exmemif.dREN_out      <= '0;
		exmemif.dWEN_out      <= '0;
		exmemif.dmemstore_out <= '0;  
		exmemif.RegWr_out     <= '0;
		exmemif.MemToReg_out  <= '0; 
		exmemif.halt_out      <= '0;
		exmemif.portO_out     <= '0;
		exmemif.luiValue_out  <= '0; 
		exmemif.pcp4_out      <= '0; 
		exmemif.wsel_out      <= '0;
		exmemif.op_mem        <= RTYPE;
	end 
	else begin 
	
		if(exmemif.ihit || exmemif.dhit )  begin 
			exmemif.dREN_out      <= exmemif.dREN_in; 
			exmemif.dWEN_out      <= exmemif.dWEN_in;
			exmemif.dmemstore_out <= exmemif.dmemstore_in;  
			exmemif.RegWr_out     <= exmemif.RegWr_in;
			exmemif.MemToReg_out  <= exmemif.MemToReg_in; 
			exmemif.halt_out      <= exmemif.halt_in;
			exmemif.portO_out     <= exmemif.portO_in;
			exmemif.luiValue_out  <= exmemif.luiValue_in;  
			exmemif.pcp4_out      <= exmemif.pcp4_in; 
			exmemif.wsel_out      <= exmemif.wsel_in;
			exmemif.op_mem        <= exmemif.op_ex;
		end   
	end
	
end

endmodule
