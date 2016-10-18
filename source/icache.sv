// File name:   icache.sv
// Updated:     15 October 2016
// Authors:     Brian Rieder 
//              Pooja Kale
// Description: Instruction Cache

// interface 
`include "datapath_cache_if.vh"
`include "cache_control_if.vh"
`include "cpu_types_pkg.vh"

module icache ( 
    input CLK, nRST,
    datapath_cache_if.icache dcif,
    caches_if.icache cif
); 

    import cpu_types_pkg::*; 

    typedef struct packed {
        logic valid;
        logic [ITAG_W-1:0] tag;
        word_t data;
    } icacheentry_t;

    // create the cache table
    icacheentry_t [15:0] icachetable;

    // cast the instruction as a struct to slice up
    icachef_t icf_imemaddr;
    assign icf_imemaddr = icachef_t'(dcif.imemaddr);

    // simplicity's sake: block selected by imemaddr idx
    icacheentry_t selected_block; 
    assign selected_block = icachetable[icf_imemaddr.idx];

    // operate on the cache table
    always_ff @ (posedge CLK, negedge nRST) begin
        if(!nRST) begin
            for(integer i = 0; i < 16; i = i + 1) begin
                icachetable[i].valid <= 0;
                icachetable[i].tag   <= 0;
                icachetable[i].data  <= 0;
            end
        end else begin
            if(dcif.imemREN & !cif.iwait) begin
                icachetable[icf_imemaddr.idx].valid <= 1;
                icachetable[icf_imemaddr.idx].tag   <= icf_imemaddr.tag;
                icachetable[icf_imemaddr.idx].data <= cif.iload;
            end
        end
    end

    // output from the cache table
    assign dcif.ihit     = selected_block.valid
                         & (selected_block.tag == icf_imemaddr.tag) 
                         & dcif.imemREN;
    assign dcif.imemload = selected_block.data;
    assign cif.iaddr     = dcif.imemaddr;
    assign cif.iREN      = !(selected_block.valid
                         &  (selected_block.tag == icf_imemaddr.tag))
                         & dcif.imemREN;

endmodule