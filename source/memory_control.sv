// File name:   memory_control.sv
// Updated:     1 September 2016
// Author:      Brian Rieder 
// Description: Controller to interface between caches and RAM

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
    input CLK, nRST,
    cache_control_if.cc ccif
);
    // type import
    import cpu_types_pkg::*;

    // number of cpus for cc
    parameter CPUS = 2;

    // state enum
    typedef enum logic [3:0] {
    IDLE, ARBITRATION, SNOOP,
    WRITEBACK1, WRITEBACK2,
    RAMREAD1, RAMREAD2,
    RAMWRITE1, RAMWRITE2
    } cc_state;
    cc_state state, next_state;

    // next state logic
    always_comb begin
        casez(state)
            IDLE: begin
                if(ccif.cctrans[0] || ccif.cctrans[1])
                    next_state = ARBITRATION;
                else
                    next_state = IDLE; 
            end
            ARBITRATION: begin
                if(ccif.dREN)
                    next_state = SNOOP;
                else if (ccif.dWEN)
                    next_state = WRITEBACK1; 
                else
                    next_state = ARBITRATION;
            end
            SNOOP: begin
                if(ccif.ccwrite) // WHICH CCWRITE??????
                    next_state = RAMWRITE1;
                else if(!ccif.ccwrite)
                    next_state = RAMREAD1;
                else
                    next_state = SNOOP;
            end
            RAMREAD1: begin
                if(ccif.ramstate == ACCESS)
                    next_state = RAMREAD2;
                else
                    next_state = RAMREAD1;
            end
            RAMREAD2: begin
                if(ccif.ramstate == ACCESS)
                    next_state = IDLE;
                else
                    next_state = RAMREAD2;
            end
            RAMWRITE1: begin
                if(ccif.ramstate == ACCESS)
                    next_state = RAMWRITE2;
                else
                    next_state = RAMWRITE1;
            end
            RAMWRITE2: begin
                if(ccif.ramstate == ACCESS)
                    next_state = IDLE;
                else
                    next_state = RAMWRITE2;
            end
            WRITEBACK1: begin
                if(ccif.ramstate == ACCESS)
                    next_state = WRITEBACK2;
                else
                    next_state = WRITEBACK1;
            end
            WRITEBACK2: begin
                if(ccif.ramstate == ACCESS)
                    next_state = IDLE;
                else
                    next_state = WRITEBACK2;
            end
        endcase
    end

    always_ff @ (posedge CLK, negedge nRST) begin
        if(!nRST) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // load/store signals
    assign ccif.iload = ccif.ramload;
    assign ccif.dload = ccif.ramload;
    assign ccif.ramstore = ccif.dstore;

    // read/write enable signals
    assign ccif.ramWEN = ccif.dWEN;
    assign ccif.ramREN = ccif.dREN | ccif.iREN;

    // addr and wait signals
    always_comb begin
        if (ccif.dREN | ccif.dWEN) begin
            ccif.ramaddr = ccif.daddr;
        end
        else begin
            ccif.ramaddr = ccif.iaddr;
        end
        casez(ccif.ramstate) 
            FREE: begin
                ccif.iwait = 1;
                ccif.dwait = 1;
            end
            BUSY: begin
                ccif.iwait = 1;
                ccif.dwait = 1;
            end
            ACCESS: begin
                if (ccif.dREN | ccif.dWEN) begin
                    ccif.iwait = 1;
                    ccif.dwait = 0;
                end else if (ccif.iREN) begin
                    ccif.iwait = 0;
                    ccif.dwait = 1;
                end else begin
                    ccif.iwait = 1;
                    ccif.dwait = 1;
                end
            end
            ERROR: begin
                ccif.iwait = 1;
                ccif.dwait = 1;
            end
            default: begin
                ccif.iwait = 1;
                ccif.dwait = 1;
            end
        endcase
    end
endmodule