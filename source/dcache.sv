// File name:   dcache.sv
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
    datapath_cache_if.dcache dcif,
    caches_if.dcache cif
); 

    import cpu_types_pkg::*; 

    typedef struct packed {
        logic valid;
        logic dirty;
        logic [DTAG_W-1:0] tag;
        word_t [1:0] data;
    } dcacheentry_t;

    typedef struct packed {
        dcacheblock_t [1:0] 
    } dcacheset_t;

endmodule
