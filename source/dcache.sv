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

    typedef enum logic [3:0] {
        IDLE, CACHE_WRITE, CACHE_LOAD1, CACHE_LOAD2,
        WRITEBACK1, WRITEBACK2, 
        FLUSH_WB1, FLUSH_WB2, HALT
    } dcache_state;

    dcache_state current_state, next_state;

    typedef struct packed {
        logic valid;
        logic dirty;
        logic [DTAG_W-1:0] tag;
        word_t [1:0] data;
    } dcacheframe_t;

    typedef struct packed {
        dcacheframe_t [1:0] dcacheset;
    } dcacheset_t;

    // create the cache table
    dcacheset_t [15:0] dcachetable;

    // cast the instruction as a struct to slice up
    dcachef_t dcf_imemaddr;
    assign dcf_imemaddr = dcachef_t'(dcif.dmemaddr);

    // next state logic
    always_comb begin
        casez(state) 
            CACHE_WRITE: begin

            end
            CACHE_LOAD1: begin

            end
            CACHE_LOAD2: begin

            end
            WRITEBACK1: begin

            end
            WRITEBACK2: begin

            end
            FLUSH_WB1: begin

            end
            FLUSH_WB2: begin

            end
            HALT: begin

            end
            default: begin
                next_state = IDLE;
            end
        end
    end

    always_ff @ (posedge CLK, negedge nRST) begin
        if(!nRST) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end


endmodule
