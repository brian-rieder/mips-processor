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
        IDLE, WRITEBACK1, WRITEBACK2,
        CACHE_LOAD1, CACHE_LOAD2,
        CHECK_DIRTY, FLUSH_WB1, FLUSH_WB2, 
        WRITE_COUNT, HALT
    } dcache_state;

    dcache_state current_state, next_state;

    typedef struct packed {
        logic valid;
        logic dirty;
        logic [DTAG_W-1:0] tag;
        word_t [1:0] data;
    } dcacheframe_t;

    typedef struct packed {
        dcacheframe_t [1:0] dcacheframe;
        logic lru;
    } dcacheset_t;

    // create the cache table
    dcacheset_t [7:0] dcachetable;

    // cast the instruction as a struct to slice up
    dcachef_t dcf_dmemaddr;
    assign dcf_dmemaddr = dcachef_t'(dcif.dmemaddr);

    // simplicity's sake: set selected by dmemaddr idx
    dcacheset_t selected_set;
    assign selected_set = dcachetable[dcf_dmemaddr.idx];

    // match signals for sanity
    logic ismatch0, ismatch1;
    assign ismatch0 = selected_set.dcacheframe[0].valid 
                    & (dcf_dmemaddr.tag == selected_set.dcacheframe[0].tag);
    assign ismatch1 = selected_set.dcacheframe[1].valid 
                    & (dcf_dmemaddr.tag == selected_set.dcacheframe[1].tag);

    // other signals
    logic [3:0] flushidx; // four bits: ABCD, A: which frame, BCD: which set
    word_t dhit_counter, miss_counter;

    // next state logic
    always_comb begin
        next_state = current_state;
        casez(current_state) 
            IDLE: begin
                flushidx = 0;
                if (!(dcif.dmemREN || dcif.dmemWEN)) begin
                    next_state = IDLE;
                end else if (!ismatch0 & !ismatch1) begin
                    if(selected_set.dcacheframe[selected_set.lru].dirty) begin
                        next_state = WRITEBACK1;
                    end else begin
                        next_state = CACHE_LOAD1;
                    end
                end else if (dcif.halt) begin
                    next_state = CHECK_DIRTY;
                end else begin
                    next_state = IDLE;
                end
            end
            WRITEBACK1:  next_state = cif.dwait ? WRITEBACK1  : WRITEBACK2;
            WRITEBACK2:  next_state = cif.dwait ? WRITEBACK2  : CACHE_LOAD1;
            CACHE_LOAD1: next_state = cif.dwait ? CACHE_LOAD1 : CACHE_LOAD2;
            CACHE_LOAD2: next_state = cif.dwait ? CACHE_LOAD2 : IDLE;
            CHECK_DIRTY: begin
                if (flushidx == 4'b1111) begin
                    next_state = WRITE_COUNT;
                end else if (dcachetable[flushidx[2:0]].dcacheframe[flushidx[3]].dirty) begin
                    next_state = FLUSH_WB1;
                end else begin
                    flushidx = flushidx + 1;
                    next_state = CHECK_DIRTY;
                end
            end
            FLUSH_WB1:   next_state = cif.dwait ? FLUSH_WB1   : FLUSH_WB2;
            FLUSH_WB2:   next_state = cif.dwait ? FLUSH_WB2   : CHECK_DIRTY;
            WRITE_COUNT: next_state = cif.dwait ? WRITE_COUNT : HALT;
            HALT: next_state = HALT;
            default: next_state = IDLE;
        endcase
    end

    // output combinational logic
    always_comb begin
        // Default values to zero
        cif.dREN      =  0;
        cif.dWEN      =  0;
        cif.daddr     = '0;
        cif.dstore    = '0;
        dcif.dhit     =  0;
        dcif.dmemload = '0;
        dcif.flushed  =  0;
        // Cache coherency signals
        cif.ccwrite   =  0;
        cif.cctrans   =  0;
        casez(current_state) begin
            IDLE: begin
            
            end
            WRITEBACK1: begin
                cif.dWEN   = 1;
                cif.daddr  = {selected_set.dcacheframe[selected_set.lru].tag,
                             dcf_dmemaddr.idx, 3'b000};
                cif.dstore = selected_set.dcacheframe[selected_set.lru].data[0];
            end
            WRITEBACK2: begin
                cif.dWEN   = 1;
                cif.daddr  = {selected_set.dcacheframe[selected_set.lru].tag,
                             dcf_dmemaddr.idx, 3'b100};
                cif.dstore = selected_set.dcacheframe[selected_set.lru].data[1];
            end
            CACHE_LOAD1: begin
                cif.dREN = 1;
                cif.daddr = dcif.dmemaddr;
            end
            CACHE_LOAD2: begin
                cif.dREN = 1;
                cif.daddr = dcif.dmemaddr + 4;
            end
            CHECK_DIRTY: begin
            
            end
            FLUSH_WB1: begin
                cif.dWEN   = 1;
                cif.daddr  = {dcachetable[flushidx[2:0]].dcacheframe[flushidx[3]].tag,
                              flushidx[2:0], 3'b000};
                cif.dstore = dcachetable[flushidx[2:0]].dcacheframe[flushidx[3]].data[0];
            end
            FLUSH_WB2: begin
                cif.dWEN   = 1;
                cif.daddr  = {dcachetable[flushidx[2:0]].dcacheframe[flushidx[3]].tag,
                              flushidx[2:0], 3'b100};
                cif.dstore = dcachetable[flushidx[2:0]].dcacheframe[flushidx[3]].data[1];
            end
            WRITE_COUNT: begin
                cif.dWEN   = 1;
                cif.daddr  = 32'h3100; 
                cif.dstore = dhit_counter - miss_counter;
            end
            HALT: begin
                dcif.flushed = 1; 
            end
        endcase
    end

    always_ff @ (posedge CLK, negedge nRST) begin
        if(!nRST) begin
            current_state <= IDLE;
            dcachetable <= '{default: '0};
        end else begin
            current_state <= next_state;
        end
    end

endmodule
