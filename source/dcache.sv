// File name:   dcache.sv
// Updated:     10 November 2016
// Authors:     Brian Rieder 
//              Pooja Kale
// Description: Data Cache

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
        IDLE, WRITEBACK1, WRITEBACK2,
        WAIT, SNOOP_WB1, SNOOP_WB2, UPDATE_CACHE,
        CACHE_LOAD1, CACHE_LOAD2,
        CHECK_DIRTY, FLUSH_WB1, FLUSH_WB2, 
        HALT //, WRITE_COUNT
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

    typedef struct packed {
        logic valid;
        word_t link_addr;
    } link_register_t;

    // assign load or store with datomic and dWEN and dREN 
    logic ll_flag, sc_flag; 
    assign ll_flag = dcif.datomic & dcif.dmemREN; 
    assign sc_flag = dcif.datomic & dcif.dmemWEN; 

    // create the cache table
    dcacheset_t [7:0] dcachetable;

    // cast the instruction as a struct to slice up
    dcachef_t dcf_dmemaddr;
    assign dcf_dmemaddr = dcachef_t'(dcif.dmemaddr);

    dcachef_t snoopaddr; 
    assign snoopaddr = dcachef_t'(cif.ccsnoopaddr); 

    // simplicity's sake: set selected by dmemaddr idx
    dcacheset_t selected_set;
    assign selected_set = dcachetable[dcf_dmemaddr.idx];

    dcacheset_t snoop_set; 
    assign snoop_set = dcachetable[snoopaddr.idx]; 

    // match signals for sanity
    logic ismatch0, ismatch1, isdirty0, isdirty1, snoopmatch0, snoopmatch1, 
          snoopdirty0, snoopdirty1, snoop_next_valid, snoop_next_dirty;
    assign ismatch0 = selected_set.dcacheframe[0].valid 
                    & (dcf_dmemaddr.tag == selected_set.dcacheframe[0].tag);
    assign ismatch1 = selected_set.dcacheframe[1].valid 
                    & (dcf_dmemaddr.tag == selected_set.dcacheframe[1].tag);
    assign isdirty0 = selected_set.dcacheframe[0].dirty;
    assign isdirty1 = selected_set.dcacheframe[1].dirty;

    assign snoopmatch0 = snoop_set.dcacheframe[0].valid 
                       & (snoopaddr.tag == snoop_set.dcacheframe[0].tag);
    assign snoopmatch1 = snoop_set.dcacheframe[1].valid 
                       & (snoopaddr.tag == snoop_set.dcacheframe[1].tag);

    assign snoopdirty0 = snoop_set.dcacheframe[0].dirty;
    assign snoopdirty1 = snoop_set.dcacheframe[1].dirty;

    // synchronization link register
    link_register_t link_reg, next_link_reg;

    // dmemWEN and cache hit => overwrite in cache and set dirty bit, dont go to memory // modifed, invalidate the other one 
    // need to change dhit
    // assign dcif.dhit = (ismatch0 | ismatch1) 
    //                  & (dcif.dmemREN | dcif.dmemWEN) 
    //                  & (current_state == IDLE);
    // assign dcif.dhit = ((ismatch0 || ismatch1) && (dcif.dmemREN)) 
    //                 || (ismatch0 && selected_set.dcacheframe[0].dirty && dcif.dmemWEN)
    //                 || (ismatch1 && selected_set.dcacheframe[1].dirty && dcif.dmemWEN);


    // miscellaneous signals
    logic [4:0] flushidx, next_flushidx; // four bits: ABCD, A: which frame, BCD: which set
    word_t dhit_counter, next_dhit_counter;
    word_t miss_counter, next_miss_counter;
    logic cache_WEN;
    logic next_valid, next_dirty, next_lru;
    logic [DTAG_W-1:0] next_tag;
    word_t next_data0, next_data1;
    logic write_idx, snoop_write_idx;

    // next state logic
    always_comb begin
        next_state = current_state;
        next_flushidx = flushidx;
        casez(current_state) 
            IDLE: begin
                if (cif.ccwait) begin
                    next_state = WAIT;
                end else if (dcif.halt) begin
                    next_state = CHECK_DIRTY;
                end else if (!(dcif.dmemREN || dcif.dmemWEN)) begin
                    next_state = IDLE;
                end else if (!ismatch0 & !ismatch1) begin
                    if(selected_set.dcacheframe[selected_set.lru].dirty) begin
                        next_state = WRITEBACK1;
                    end else begin
                        next_state = CACHE_LOAD1;
                    end
                // added with Nick
                end else if ((ismatch0 & dcif.dmemWEN & !isdirty0) 
                          || (ismatch1 & dcif.dmemWEN & !isdirty1)) begin
                    next_state = CACHE_LOAD1;
                end else begin
                    next_state = IDLE;
                end
            end
            WAIT: begin
                if ((snoopmatch0 && snoopdirty0) || (snoopmatch1 && snoopdirty1))
                    next_state = SNOOP_WB1;
                else if(!cif.ccwait)
                    next_state = IDLE;
                else
                    next_state = WAIT;
            end
            SNOOP_WB1: begin
                if(!cif.ccwait)
                    next_state = IDLE;
                else if(!cif.dwait)
                    next_state = SNOOP_WB2;
                else
                    next_state = SNOOP_WB1;
            end
            SNOOP_WB2: begin
                if(!cif.dwait)
                    next_state = IDLE;
                else
                    next_state = SNOOP_WB2;
            end
            UPDATE_CACHE: begin
                next_state = IDLE;
            end
            WRITEBACK1: begin
                if(cif.ccwait)
                    next_state = WAIT;
                else if(!cif.dwait)
                    next_state = WRITEBACK2;
                else
                    next_state = WRITEBACK1;
            end
            WRITEBACK2:  next_state = cif.dwait ? WRITEBACK2  : CACHE_LOAD1;
            CACHE_LOAD1: begin
                if(cif.ccwait)
                    next_state = WAIT;
                else if(cif.dwait)
                    next_state = CACHE_LOAD1;
                else
                    next_state = CACHE_LOAD2;
            end
            CACHE_LOAD2: begin
                if (!cif.dwait & dcif.dmemWEN) 
                    next_state = UPDATE_CACHE;
                else if (!cif.dwait) 
                    next_state = IDLE;
                else 
                    next_state = CACHE_LOAD2;
            end
            CHECK_DIRTY: begin
                if (cif.ccwait)
                    next_state = WAIT;
                else if (flushidx > 5'b1111) begin
                    next_state = HALT;
                end else if (dcachetable[flushidx[2:0]].dcacheframe[flushidx[3]].dirty) begin
                    next_state = FLUSH_WB1;
                end else begin
                    next_flushidx = flushidx + 1;
                    next_state = CHECK_DIRTY;
                end
            end
            FLUSH_WB1: begin
                if (cif.ccwait)
                    next_state = WAIT;
                else if(cif.dwait)
                    next_state = FLUSH_WB1;
                else
                    next_state = FLUSH_WB2;
            end
            FLUSH_WB2: begin
                next_state = cif.dwait ? FLUSH_WB2 : CHECK_DIRTY;
                next_flushidx = cif.dwait ? flushidx : flushidx + 1;
            end
            // WRITE_COUNT: next_state = cif.dwait ? WRITE_COUNT : HALT;
            HALT: next_state = HALT;
            default: next_state = IDLE;
        endcase
    end

    assign snoop_write_idx = snoopmatch0 ? 0 : snoopmatch1 ? 1 : 0;
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

// assign cif.ccwrite = cif.dWEN && !cif.ccwait;
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
        next_link_reg = link_reg;
        // Default values to zero
        cif.dREN      =  0;
        cif.dWEN      =  0;
        cif.daddr     = '0;
        cif.dstore    = '0;
        dcif.dmemload = '0;
        dcif.flushed  =  0;
        cache_WEN     =  0;
        dcif.dhit     =  0;
        snoop_next_valid = 0;
        snoop_next_dirty = 0;
        // Cache coherency signals
        cif.ccwrite   =  0;
        cif.cctrans   =  0;
        casez(current_state) 
            IDLE: begin
                if(ismatch0 && dcif.dmemREN) begin
                    cache_WEN     = 1;
                    next_lru      = 1;
                    dcif.dmemload = selected_set.dcacheframe[0].data[dcf_dmemaddr.blkoff];
                    dcif.dhit     = 1;
                    if(dcif.datomic) begin
                        next_link_reg.valid = 1;
                        next_link_reg.link_addr = dcif.dmemaddr;
                    end
                end else if (ismatch1 && dcif.dmemREN) begin
                    cache_WEN     = 1;
                    next_lru      = 0;
                    dcif.dmemload = selected_set.dcacheframe[1].data[dcf_dmemaddr.blkoff];
                    dcif.dhit     = 1;
                    if(dcif.datomic) begin
                        next_link_reg.valid = 1;
                        next_link_reg.link_addr = dcif.dmemaddr;
                    end
                end else if (ismatch0 && dcif.dmemWEN && isdirty0) begin
                    dcif.dhit = 1;
                    if(dcif.datomic) begin
                        if((dcif.dmemaddr == link_reg.link_addr) && link_reg.valid) begin
                            // rt = 1, invalidate link reg
                            dcif.dmemload = 1;
                            next_link_reg.valid = 0;

                            // normal store
                            cache_WEN  = 1;
                            next_lru   = 1; // used to be 1
                            next_valid = 1;
                            next_dirty = 1;
                            if (dcf_dmemaddr.blkoff == 0)
                                next_data0 = dcif.dmemstore;
                            else
                                next_data1 = dcif.dmemstore;
                        end
                        else begin
                            // rt = 0, don't do the store
                            dcif.dmemload = 0;
                        end
                    end
                    else begin
                        // normal store
                        if(link_reg.link_addr == dcif.dmemaddr)
                            next_link_reg.valid = 0;
                        cache_WEN  = 1;
                        next_lru   = 1; // used to be 1
                        next_valid = 1;
                        next_dirty = 1;
                        if (dcf_dmemaddr.blkoff == 0)
                            next_data0 = dcif.dmemstore;
                        else
                            next_data1 = dcif.dmemstore;
                    end
                end
                else if (ismatch1 && dcif.dmemWEN && isdirty1) begin
                    dcif.dhit = 1;
                    if(dcif.datomic) begin
                        if((dcif.dmemaddr == link_reg.link_addr) && link_reg.valid) begin
                            // rt = 1, invalidate link reg
                            dcif.dmemload = 1;
                            next_link_reg.valid = 0;
                            
                            // normal store
                            cache_WEN  = 1;
                            next_lru   = 0; // used to be 0
                            next_valid = 1;
                            next_dirty = 1;
                            if (dcf_dmemaddr.blkoff == 0)
                                next_data0 = dcif.dmemstore;
                            else
                                next_data1 = dcif.dmemstore;
                        end
                        else begin
                            // rt = 0, don't do the store
                            dcif.dmemload = 0;
                        end
                    end
                    else begin
                        // normal store
                        if(link_reg.link_addr == dcif.dmemaddr)
                            next_link_reg.valid = 0;
                        cache_WEN  = 1;
                        next_lru   = 0; // used to be 0
                        next_valid = 1;
                        next_dirty = 1;
                        if (dcf_dmemaddr.blkoff == 0)
                            next_data0 = dcif.dmemstore;
                        else
                            next_data1 = dcif.dmemstore;
                    end
                end
                else if (ismatch0 && dcif.dmemWEN) begin
                    if(dcif.datomic) begin
                        if((dcif.dmemaddr == link_reg.link_addr) && link_reg.valid) begin
                            // rt = 1, invalidate link reg
                            dcif.dmemload = 1;
                            next_link_reg.valid = 0;

                            // normal store
                            cache_WEN  = 1;
                            next_lru   = 1; // used to be 1
                            next_valid = 1;
                            next_dirty = 1;
                            if (dcf_dmemaddr.blkoff == 0)
                                next_data0 = dcif.dmemstore;
                            else
                                next_data1 = dcif.dmemstore;
                        end
                        else begin
                            // rt = 0, don't do the store
                            dcif.dmemload = 0;
                        end
                    end
                    // else begin
                    //     // normal store
                    //     if(link_reg.link_addr == dcif.dmemaddr)
                    //         next_link_reg.valid = 0;
                    //     cache_WEN  = 1;
                    //     next_lru   = 1; // used to be 1
                    //     next_valid = 1;
                    //     next_dirty = 1;
                    //     if (dcf_dmemaddr.blkoff == 0)
                    //         next_data0 = dcif.dmemstore;
                    //     else
                    //         next_data1 = dcif.dmemstore;
                    // end
                end else if (ismatch1 && dcif.dmemWEN) begin
                    if(dcif.datomic) begin
                        if((dcif.dmemaddr == link_reg.link_addr) && link_reg.valid) begin
                            // rt = 1, invalidate link reg
                            dcif.dmemload = 1;
                            next_link_reg.valid = 0;
                            
                            // normal store
                            cache_WEN  = 1;
                            next_lru   = 0; // used to be 0
                            next_valid = 1;
                            next_dirty = 1;
                            if (dcf_dmemaddr.blkoff == 0)
                                next_data0 = dcif.dmemstore;
                            else
                                next_data1 = dcif.dmemstore;
                        end
                        else begin
                            // rt = 0, don't do the store
                            dcif.dmemload = 0;
                        end
                    end
                    // else begin
                    //     // normal store
                    //     if(link_reg.link_addr == dcif.dmemaddr)
                    //         next_link_reg.valid = 0;
                    //     cache_WEN  = 1;
                    //     next_lru   = 0; // used to be 0
                    //     next_valid = 1;
                    //     next_dirty = 1;
                    //     if (dcf_dmemaddr.blkoff == 0)
                    //         next_data0 = dcif.dmemstore;
                    //     else
                    //         next_data1 = dcif.dmemstore;
                    // end
                end else begin
                    cache_WEN = 0;
                end
            end
            WAIT: begin
                snoop_next_dirty = snoop_set.dcacheframe[snoop_write_idx].dirty; 
                cif.cctrans = 1;
                cif.ccwrite = 0;
                if ((snoopmatch0 && snoopdirty0) || (snoopmatch1 && snoopdirty1)) begin
                    cif.ccwrite = 1;
                    cif.cctrans = 1;
                    snoop_next_valid = 0;
                end
                if (cif.ccinv & !(snoopdirty0 | snoopdirty1)) begin
                    cache_WEN = 1;
                    snoop_next_valid = 0;
                end 
            end
            SNOOP_WB1: begin
                cif.dWEN = 1;
                // cache_WEN = 1;
                // next_dirty = 0;
                cif.ccwrite = dcif.dmemWEN; 
                cif.daddr = { cif.ccsnoopaddr[31:3], 3'b000 };
                if(snoopdirty0) begin
                    cache_WEN = 1;
                    next_dirty = 0;
                    cif.dstore = snoop_set.dcacheframe[0].data[0];
                end else if(snoopdirty1) begin
                    cache_WEN = 1;
                    next_dirty = 0;
                    cif.dstore = snoop_set.dcacheframe[1].data[0];
                end
                // else
                //     cif.dstore = 32'hBAD7BAD7;
                // cif.cctrans = 1;
            end
            SNOOP_WB2: begin
                cif.dWEN = 1;
                // cache_WEN = 1;
                // next_dirty = 0;
                cif.ccwrite = dcif.dmemWEN; 
                cif.daddr = { cif.ccsnoopaddr[31:3], 3'b100 };
                if(snoopdirty0) begin
                    cache_WEN = 1;
                    next_dirty = 0;
                    cif.dstore = snoop_set.dcacheframe[0].data[1];
                end else if(snoopdirty1) begin
                    cache_WEN = 1;
                    next_dirty = 0;
                    cif.dstore = snoop_set.dcacheframe[1].data[1];
                end
                if(!cif.dwait && !cif.ccinv) begin
                    if(snoopmatch0)
                        snoop_next_valid = snoop_set.dcacheframe[0].valid;
                    else if(snoopmatch1)
                        snoop_next_valid = snoop_set.dcacheframe[1].valid;
                end
                // else
                // cif.cctrans = 1;
            end
            UPDATE_CACHE: begin
                dcif.dhit = 1;
                if(link_reg.link_addr == dcif.dmemaddr)
                    next_link_reg.valid = 0;
                cache_WEN  = 1;
                next_valid = 1;
                next_dirty = 1;
                if (dcf_dmemaddr.blkoff == 0)
                    next_data0 = dcif.dmemstore;
                else
                    next_data1 = dcif.dmemstore;
                if(ismatch0)
                    next_lru = 0;
                else if(ismatch1)
                    next_lru = 1;
            end
            WRITEBACK1: begin
                cif.dWEN   = 1;
                cif.daddr  = {selected_set.dcacheframe[selected_set.lru].tag,
                             dcf_dmemaddr.idx, 3'b000};
                cif.dstore = selected_set.dcacheframe[selected_set.lru].data[0];
                cif.cctrans = 1;
            end
            WRITEBACK2: begin
                cif.dWEN   = 1;
                cif.daddr  = {selected_set.dcacheframe[selected_set.lru].tag,
                             dcf_dmemaddr.idx, 3'b100};
                cif.dstore = selected_set.dcacheframe[selected_set.lru].data[1];
                cif.cctrans = 1;
            end
            CACHE_LOAD1: begin
                cif.dREN = 1;
                cif.daddr  = {dcf_dmemaddr.tag, dcf_dmemaddr.idx, 3'b000};
                cif.cctrans = 1;
                if(dcif.dmemWEN)
                    cif.ccwrite = 1;
                if(!cif.dwait) begin
                    cache_WEN = 1;
                    next_valid = 0;
                    next_dirty = 0;
                    next_tag   = dcf_dmemaddr.tag;
                    next_data0 = cif.dload;
                    // write_idx = selected_set.lru;
                end
                if(dcif.dmemWEN)
                    cif.ccwrite = 1;
                if(ismatch0)
                    next_lru = 0;
                else if(ismatch1)
                    next_lru = 1;
            end
            CACHE_LOAD2: begin
                cif.dREN = 1;
                cif.daddr  = {dcf_dmemaddr.tag, dcf_dmemaddr.idx, 3'b100};
                cif.cctrans = 1;
                if(dcif.dmemWEN)
                    cif.ccwrite = 1;
                if(!cif.dwait) begin 
                    cache_WEN = 1;
                    next_valid = 1;
                    next_dirty = 0;
                    next_tag   = dcf_dmemaddr.tag;
                    next_data1 = cif.dload;
                    // write_idx = selected_set.lru;
                    next_miss_counter = miss_counter + 1;
                end
                if(dcif.dmemWEN)
                    cif.ccwrite = 1;
            end
            CHECK_DIRTY: begin
                // nuttin but state shiz
            end
            FLUSH_WB1: begin
                cif.dWEN   = 1;
                cif.daddr  = {dcachetable[flushidx[2:0]].dcacheframe[flushidx[3]].tag,
                              flushidx[2:0], 3'b000};
                cif.dstore = dcachetable[flushidx[2:0]].dcacheframe[flushidx[3]].data[0];
                cif.cctrans = 1;
            end
            FLUSH_WB2: begin
                cif.dWEN   = 1;
                cif.daddr  = {dcachetable[flushidx[2:0]].dcacheframe[flushidx[3]].tag,
                              flushidx[2:0], 3'b100};
                cif.dstore = dcachetable[flushidx[2:0]].dcacheframe[flushidx[3]].data[1];
                cif.cctrans = 1;
                next_dirty = 0;
                next_valid = 0;
                cache_WEN = 1;
            end
            // WRITE_COUNT: begin
            //     cif.dWEN   = 1;
            //     cif.daddr  = 32'h3100; 
            //     cif.dstore = dhit_counter - miss_counter;
            // end
            HALT: begin
                dcif.flushed = 1; 
                if(cif.ccwait)
                    cif.cctrans = 1;
                else
                    cif.cctrans = 0;
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
            link_reg <= '{default: '0};
        end else begin
            current_state <= next_state;
            flushidx <= next_flushidx;
            miss_counter <= next_miss_counter;
            link_reg.valid <= next_link_reg.valid;
            link_reg.link_addr <= next_link_reg.link_addr;
            if(cache_WEN) begin
                if(current_state == WAIT || current_state == SNOOP_WB2 && !cif.ccwrite) begin
                    dcachetable[snoopaddr.idx].dcacheframe[snoop_write_idx].valid   <= snoop_next_valid;
                    dcachetable[snoopaddr.idx].dcacheframe[snoop_write_idx].dirty   <= snoop_next_dirty;
                    /*dcachetable[snoopaddr.idx].dcacheframe[snoop_write_idx].tag     <= next_tag;
                    dcachetable[snoopaddr.idx].dcacheframe[snoop_write_idx].data[0] <= next_data0;
                    dcachetable[snoopaddr.idx].dcacheframe[snoop_write_idx].data[1] <= next_data1;
                    dcachetable[snoopaddr.idx].lru <= next_lru;*/
                end else begin
                    dcachetable[dcf_dmemaddr.idx].dcacheframe[write_idx].valid   <= next_valid;
                    dcachetable[dcf_dmemaddr.idx].dcacheframe[write_idx].dirty   <= next_dirty;
                    dcachetable[dcf_dmemaddr.idx].dcacheframe[write_idx].tag     <= next_tag;
                    dcachetable[dcf_dmemaddr.idx].dcacheframe[write_idx].data[0] <= next_data0;
                    dcachetable[dcf_dmemaddr.idx].dcacheframe[write_idx].data[1] <= next_data1;
                    dcachetable[dcf_dmemaddr.idx].lru <= next_lru;
                end
            end
        end
    end

endmodule
