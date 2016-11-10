// File name:   memory_control.sv
// Updated:     10 November 2016
// Author:      Brian Rieder 
//              Pooja Kale
// Description: Controller to interface between caches and RAM.
//              As of November 1, also services as a coherence controller and arbiter

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
        IDLE, SNOOP,
        INSTRUCTION_SERVICE,
        ARBITRATION,
        WRITEBACK1, WRITEBACK2,
        RAMREAD1, RAMREAD2,
        RAMWRITE1, RAMWRITE2
    } cc_state;
    cc_state state, next_state;

    logic service_cache, next_service_cache;
    logic instr_service, next_instr_service;

    // next state logic
    always_comb begin
        next_state = state;
        casez(state)
            IDLE: begin
                if(ccif.cctrans[0] || ccif.cctrans[1])
                    next_state = ARBITRATION;
                else if (ccif.iREN[0] || ccif.iREN[1])
                    next_state = INSTRUCTION_SERVICE;
                else
                    next_state = IDLE; 
            end
            ARBITRATION: begin
                // if(!ccif.ccwrite[!service_cache] && ccif.cctrans[!service_cache]) // BusRd
                //     next_state = RAMREAD1;
                // else if(ccif.ccwrite[!service_cache] && !ccif.cctrans[!service_cache]) // BusRdx
                //     next_state = RAMWRITE1;
                if(ccif.dREN)
                    next_state = SNOOP;
                else if(ccif.dWEN) // this used to be !cctrans as well
                    next_state = WRITEBACK1;
                else
                    next_state = ARBITRATION;
            end
            INSTRUCTION_SERVICE: begin
                if(ccif.ramstate == ACCESS)
                    next_state = IDLE;
                else
                    next_state = INSTRUCTION_SERVICE;
            end
            SNOOP: begin
                // if(ccif.ccwrite[!service_cache]) 
                if(ccif.ccwrite[!service_cache] && ccif.cctrans[!service_cache]) 
                    next_state = RAMWRITE1;
                else if(!ccif.ccwrite[!service_cache] && ccif.cctrans[!service_cache])
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

    assign ccif.ccsnoopaddr[0] = ccif.daddr[1];
    assign ccif.ccsnoopaddr[1] = ccif.daddr[0];

    // output logic
    always_comb begin
        ccif.ccwait = 0;
        // ccif.ccsnoopaddr = 0;
        ccif.ccinv = 0;
        ccif.ramWEN = 0;
        ccif.ramREN = 0;
        ccif.ramaddr = 0;
        ccif.ramstore = 0;
        ccif.dload = 0;
        ccif.dwait = '1;
        ccif.iwait = '1;
        next_instr_service = instr_service;
        casez(state)
            IDLE: begin
                // setting the next cache to service
                if(ccif.cctrans[0])
                    next_service_cache = 0;
                else if(ccif.cctrans[1])
                    next_service_cache = 1;
                else
                    next_service_cache = 0;
            end
            ARBITRATION: begin
                // if(ccif.cctrans[service_cache] && ccif.ccwrite[service_cache]) begin // BusRdX
                //     ccif.ccwait[!service_cache] = 1;
                //     ccif.ccinv[!service_cache] = 1;
                // end else if (ccif.dREN[service_cache]) begin
                //     ccif.ccwait[!service_cache] = 1;
                //     ccif.ccinv[!service_cache] = 0;
                // end else begin
                //     ccif.ccwait[!service_cache] = 0;
                //     ccif.ccinv[!service_cache] = 0;
                // end
            end
            INSTRUCTION_SERVICE: begin
                if(ccif.iREN[0] && ccif.iREN[1]) begin
                    // load signals
                    ccif.iload[ instr_service] = ccif.ramload;
                    ccif.iload[!instr_service] = 0;
                    // ram control
                    ccif.ramREN = 1;
                    ccif.ramaddr = ccif.iaddr[instr_service];
                    // wait signal
                    if(ccif.ramstate == ACCESS)
                        ccif.iwait[instr_service] = 0;
                    next_instr_service = !instr_service;
                end else if (ccif.iREN[0]) begin
                    // load signals
                    ccif.iload[0] = ccif.ramload;
                    ccif.iload[1] = 0;
                    // ram control
                    ccif.ramREN = 1;
                    ccif.ramaddr = ccif.iaddr[0];
                    // wait signal
                    if(ccif.ramstate == ACCESS)
                        ccif.iwait[0] = 0;
                end else begin // ccif.iREN[1]
                    // load signals
                    ccif.iload[1] = ccif.ramload;
                    ccif.iload[0] = 0;
                    // ram control
                    ccif.ramREN = 1;
                    ccif.ramaddr = ccif.iaddr[1];
                    // wait signal
                    if(ccif.ramstate == ACCESS)
                        ccif.iwait[1] = 0;
                    next_instr_service = !instr_service;
                end
            end
            SNOOP: begin
                ccif.ccwait[!service_cache] = 1;
                // ccif.ccsnoopaddr[!service_cache] = ccif.daddr[service_cache];
                // ccwrite is high if service cache has a hit and dWEN 
                // or if there is a snoop hit (this logic is in dcache)
                ccif.ccinv[!service_cache] = 1;//ccif.ccwrite[service_cache];
            end
            RAMREAD1: begin 
                ccif.ccwait[!service_cache] = 1;
                // ccsnoopaddr[!service_cache] = ccif.daddr[service_cache];
                ccif.ramREN = 1;
                ccif.ramaddr = ccif.daddr[service_cache];
                ccif.dload[service_cache] = ccif.ramload;
                ccif.ccinv[!service_cache] = 0;
                if(ccif.ramstate == ACCESS)
                    ccif.dwait[service_cache] = 0;
            end
            RAMREAD2: begin
                ccif.ccwait[!service_cache] = 1;
                // ccsnoopaddr[!service_cache] = ccif.daddr[service_cache];
                ccif.ramREN = 1;
                ccif.ramaddr = ccif.daddr[service_cache];
                ccif.dload[service_cache] = ccif.ramload;
                ccif.ccinv[!service_cache] = 0;
                if(ccif.ramstate == ACCESS) begin
                    ccif.dwait[service_cache] = 0;
                    ccif.ccwait[!service_cache] = 0;
                end
            end
            RAMWRITE1: begin
                ccif.ccwait[!service_cache] = 1;
                // ccsnoopaddr[!service_cache] = ccif.daddr[service_cache];
                ccif.ramWEN = 1;
                ccif.ramaddr = ccif.daddr[service_cache];
                ccif.ramstore = ccif.dstore[!service_cache];
                ccif.dload[service_cache] = ccif.dstore[!service_cache];
                // ccif.ccinv[!service_cache] = ccif.ccwrite[service_cache];
                if(ccif.ramstate == ACCESS)
                    ccif.dwait = '0;
            end
            RAMWRITE2: begin
                ccif.ccwait[!service_cache] = 1;
                // ccsnoopaddr[!service_cache] = ccif.daddr[service_cache];
                ccif.ramWEN = 1;
                ccif.ramaddr = ccif.daddr[service_cache];
                ccif.ramstore = ccif.dstore[!service_cache];
                ccif.dload[service_cache] = ccif.dstore[!service_cache];
                // ccif.ccinv[!service_cache] = ccif.ccwrite[service_cache];
                if(ccif.ramstate == ACCESS) begin
                    ccif.dwait = '0;
                    ccif.ccwait[!service_cache] = 0;
                end
            end
            WRITEBACK1: begin
                ccif.ramWEN = 1;
                ccif.ramaddr = ccif.daddr[service_cache];
                ccif.ramstore = ccif.dstore[service_cache];
                if(ccif.ramstate == ACCESS)
                    ccif.dwait[service_cache] = 0;
            end
            WRITEBACK2: begin
                ccif.ramWEN = 1;
                ccif.ramaddr = ccif.daddr[service_cache];
                ccif.ramstore = ccif.dstore[service_cache];
                if(ccif.ramstate == ACCESS)
                    ccif.dwait[service_cache] = 0;
            end
        endcase
    end

    always_ff @ (posedge CLK, negedge nRST) begin
        if(!nRST) begin
            state <= IDLE;
            service_cache <= 0;
            instr_service <= 0;
        end else begin
            state <= next_state;
            service_cache <= next_service_cache;
            if(!ccif.iwait[0] || !ccif.iwait[1])
                instr_service <= next_instr_service;
        end
    end

endmodule