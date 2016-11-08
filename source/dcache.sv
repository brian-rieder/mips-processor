// File name:   dcache.sv
// Updated:     15 October 2016
// Authors:     Brian Rieder 
//              Pooja Kale
// Description: Instruction Cache

// interface 
`include "datapath_cache_if.vh"
`include "cache_control_if.vh"
`include "cpu_types_pkg.vh"

module dcache ( 
    input CLK, nRST,
    datapath_cache_if.dcache dcif,
    caches_if.dcache cif
); 

    import cpu_types_pkg::*; 

    typedef enum logic [3:0] {
        IDLE, SNOOP, COHERENCE1, COHERENCE2, WRITEBACK1, WRITEBACK2,
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

    dcachef_t snoopaddr; 
    assign snoopaddr = dcache_t'(cif.ccsnoopaddr); 

    // simplicity's sake: set selected by dmemaddr idx
    dcacheset_t selected_set;
    assign selected_set = dcachetable[dcf_dmemaddr.idx];

    dcacheset_t snoop_set; 
    assign snoop_set = dcachetable[snoopaddr.idx]; 

    // match signals for sanity
    logic ismatch0, ismatch1, snoopmatch0, snoopmatch1;
    assign ismatch0 = selected_set.dcacheframe[0].valid 
                    & (dcf_dmemaddr.tag == selected_set.dcacheframe[0].tag);
    assign ismatch1 = selected_set.dcacheframe[1].valid 
                    & (dcf_dmemaddr.tag == selected_set.dcacheframe[1].tag);

    assign snoopmatch0 = snoopset.dcacheframe[0].valid 
                    & (dcf_dmemaddr.tag == snoopset.dcacheframe[0].tag);
    assign snoopmatch1 = snoopset.dcacheframe[1].valid 
                    & (dcf_dmemaddr.tag == snoopset.dcacheframe[1].tag);
    // assign dhit

    // dmemWEN and cache hit => overwrite in cache and set dirty bit, dont go to memory // modifed, invalidate the other one 
    // need to change dhit
    assign dcif.dhit = (ismatch0 | ismatch1) 
                     & (dcif.dmemREN | dcif.dmemWEN) 
                     & (current_state == IDLE);


    // miscellaneous signals
    logic [4:0] flushidx, next_flushidx; // four bits: ABCD, A: which frame, BCD: which set
    word_t dhit_counter, next_dhit_counter;
    word_t miss_counter, next_miss_counter;
    logic cache_WEN;
    logic next_valid, next_dirty, next_lru;
    logic [DTAG_W-1:0] next_tag;
    word_t next_data0, next_data1;
    logic write_idx;

    // next state logic
    always_comb begin
        next_state = current_state;
        next_flushidx = flushidx;
        casez(current_state) 
            IDLE: begin
                if (dcif.halt) begin
                    next_state = CHECK_DIRTY;
                end else if (!(dcif.dmemREN || dcif.dmemWEN)) begin
                    next_state = IDLE;
                end else if (!ismatch0 & !ismatch1) begin
                    if(selected_set.dcacheframe[selected_set.lru].dirty) begin
                        next_state = WRITEBACK1;
                    end else begin
                        next_state = CACHE_LOAD1;
                    end
                end else begin
                    next_state = IDLE;
                end
            end
            SNOOP: begin 
                
            end 
            COHERENCE1: begin 
            
            end 
            COHERENCE2: begin 
            
            end 
            WRITEBACK1:  next_state = cif.dwait ? WRITEBACK1  : WRITEBACK2;
            WRITEBACK2:  next_state = cif.dwait ? WRITEBACK2  : CACHE_LOAD1;
            CACHE_LOAD1: next_state = cif.dwait ? CACHE_LOAD1 : CACHE_LOAD2;
            CACHE_LOAD2: next_state = cif.dwait ? CACHE_LOAD2 : IDLE;
            CHECK_DIRTY: begin
                if (flushidx > 5'b1111) begin
                    next_state = WRITE_COUNT;
                end else if (dcachetable[flushidx[2:0]].dcacheframe[flushidx[3]].dirty) begin
                    next_state = FLUSH_WB1;
                end else begin
                    next_flushidx = flushidx + 1;
                    next_state = CHECK_DIRTY;
                end
            end
            FLUSH_WB1:   next_state = cif.dwait ? FLUSH_WB1   : FLUSH_WB2;
            FLUSH_WB2: begin
                next_state = cif.dwait ? FLUSH_WB2 : CHECK_DIRTY;
                next_flushidx = cif.dwait ? flushidx : flushidx + 1;
            end
            WRITE_COUNT: next_state = cif.dwait ? WRITE_COUNT : HALT;
            HALT: next_state = HALT;
            default: next_state = IDLE;
        endcase
    end

    always_comb begin
        if(ismatch0 && dcif.dmemREN) begin
            write_idx = 0;
        end else if (ismatch1 && dcif.dmemREN) begin
            write_idx = 1;
        end else if (ismatch0 && dcif.dmemWEN) begin
            write_idx = 0;
        end else if (ismatch1 && dcif.dmemWEN) begin
            write_idx = 1;
        end else begin
            write_idx = selected_set.lru;
        end
    end

    // cache output combinational logic
    always_comb begin
        // Defaults for next values
        next_valid =  selected_set.dcacheframe[write_idx].valid;
        next_dirty =  selected_set.dcacheframe[write_idx].dirty; 
        next_lru   =  selected_set.lru;
        next_tag   =  selected_set.dcacheframe[write_idx].tag;
        next_data0 =  selected_set.dcacheframe[write_idx].data[0];
        next_data1 =  selected_set.dcacheframe[write_idx].data[1];
        next_miss_counter = miss_counter;
        // Default values to zero
        cif.dREN      =  0;
        cif.dWEN      =  0;
        cif.daddr     = '0;
        cif.dstore    = '0;
        dcif.dmemload = '0;
        dcif.flushed  =  0;
        cache_WEN     =  0;
        // Cache coherency signals
        cif.ccwrite   =  0;
        cif.cctrans   =  0;
        casez(current_state) 
            IDLE: begin
                if(ismatch0 && dcif.dmemREN) begin
                    cache_WEN     = 1;
                    next_lru      = 1;
                    dcif.dmemload = selected_set.dcacheframe[0].data[dcf_dmemaddr.blkoff];
                    // write_idx = 0;
                end else if (ismatch1 && dcif.dmemREN) begin
                    cache_WEN     = 1;
                    next_lru      = 0;
                    dcif.dmemload = selected_set.dcacheframe[1].data[dcf_dmemaddr.blkoff];
                    // write_idx = 1;
                end else if (ismatch0 && dcif.dmemWEN) begin
                    cache_WEN  = 1;
                    next_lru   = 1;
                    next_valid = 1;
                    next_dirty = 1;
                    if (dcf_dmemaddr.blkoff == 0)
                        next_data0 = dcif.dmemstore;
                    else
                        next_data1 = dcif.dmemstore;
                    // write_idx = 0;
                end else if (ismatch1 && dcif.dmemWEN) begin
                    cache_WEN  = 1;
                    next_lru   = 0;
                    next_valid = 1;
                    next_dirty = 1;
                    if (dcf_dmemaddr.blkoff == 0)
                        next_data0 = dcif.dmemstore;
                    else
                        next_data1 = dcif.dmemstore;
                    // write_idx = 1;
                end else begin
                    cache_WEN = 0;
                    // write_idx = 0;
                end
            end

            SNOOP: begin 

            end 
            COHERENCE1: begin 
                
            end 
            COHERENCE2: begin 
            
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
                cif.daddr  = {dcf_dmemaddr.tag, dcf_dmemaddr.idx, 3'b000};
                if(!cif.dwait) begin
                    cache_WEN = 1;
                    next_valid = 0;
                    next_dirty = 0;
                    next_tag   = dcf_dmemaddr.tag;
                    next_data0 = cif.dload;
                    // write_idx = selected_set.lru;
                end
            end
            CACHE_LOAD2: begin
                cif.dREN = 1;
                cif.daddr  = {dcf_dmemaddr.tag, dcf_dmemaddr.idx, 3'b100};
                if(!cif.dwait) begin 
                    cache_WEN = 1;
                    next_valid = 1;
                    next_dirty = 0;
                    next_tag   = dcf_dmemaddr.tag;
                    next_data1 = cif.dload;
                    // write_idx = selected_set.lru;
                    next_miss_counter = miss_counter + 1;
                end
            end
            CHECK_DIRTY: begin
                // nuttin but state shiz
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
        if(!nRST)
            dhit_counter <= 0;
        else
            if(dcif.dhit)
                dhit_counter <= dhit_counter + 1;
    end

    always_ff @ (posedge CLK, negedge nRST) begin
        if(!nRST) begin
            current_state <= IDLE;
            flushidx <= 0;
            dcachetable <= '{default: '0};
            miss_counter <= 0;
        end else begin
            current_state <= next_state;
            flushidx <= next_flushidx;
            miss_counter <= next_miss_counter;
            if(cache_WEN) begin
                dcachetable[dcf_dmemaddr.idx].dcacheframe[write_idx].valid   <= next_valid;
                dcachetable[dcf_dmemaddr.idx].dcacheframe[write_idx].dirty   <= next_dirty;
                dcachetable[dcf_dmemaddr.idx].dcacheframe[write_idx].tag     <= next_tag;
                dcachetable[dcf_dmemaddr.idx].dcacheframe[write_idx].data[0] <= next_data0;
                dcachetable[dcf_dmemaddr.idx].dcacheframe[write_idx].data[1] <= next_data1;
                dcachetable[dcf_dmemaddr.idx].lru <= next_lru;
            end
        end
    end

endmodule
