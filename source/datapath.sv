// File name:   datapath.sv
// Updated:     20 September 2016
// Authors:     Brian Rieder 
//              Pooja Kale
// Description: Glue unit that contains register file, control unit, 
//              program counter, ALU, request unit, and glue logic

// data path interface
`include "datapath_cache_if.vh"
`include "alu_if.vh"
`include "register_file_if.vh"
`include "control_unit_if.vh"
`include "program_counter_if.vh"
`include "if_id_if.vh"
`include "id_ex_if.vh"
`include "ex_mem_if.vh"
`include "mem_wb_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
    input logic CLK, nRST,
    datapath_cache_if.dp dpif
);

    import cpu_types_pkg::*; // import data types

    // Program Counter initialization
    parameter PC_INIT = 0;

    // Interface instantiation
    alu_if aluif ();
    register_file_if rfif ();
    control_unit_if cuif ();
    program_counter_if pcif ();
    IF_ID_if ifidif ();
    ID_EX_if idexif ();
    EX_MEM_if exmemif ();
    MEM_WB_if memwbif ();

    // Component instantiation
    alu ALU (aluif.alu);
    register_file RF (CLK, nRST, rfif.rf);
    control_unit CU (cuif.cu);
    program_counter PC (CLK, nRST, pcif.pc);
    IF_ID IFID (CLK, nRST, ifidif.if_id);
    ID_EX IDEX (CLK, nRST, idexif.id_ex);
    EX_MEM EXMEM (CLK, nRST, exmemif.ex_mem);
    MEM_WB MEMWB (CLK, nRST, memwbif.mem_wb);


    // Misc. Datapath Internal Signals
    // logic branch_mode;
    word_t extImm, pcplus4, jumpdest, LUIval;
    assign pcplus4 = pcif.pc_out + 4;
    logic flush;

    // Immediate Extension
    always_comb begin
        // Zero Extension
        if (cuif.ExtOp == 0) begin
            extImm = {16'h0000, cuif.imm16};
        end
        // Signed Extension
        else begin 
            // extended[15:0] <= { {8{extend[7]}}, extend[7:0] };
            extImm = $signed(cuif.imm16);
        end
    end


    // Datapath input assignment
    // assign dpif.halt      = memwbif.halt_out;
    assign dpif.imemREN   = 1; // always tied high
    assign dpif.imemaddr  = pcif.pc_out;
    assign dpif.dmemREN   = exmemif.dREN;
    assign dpif.dmemWEN   = exmemif.dWEN;
    assign dpif.dmemstore = exmemif.dmemstore_out;
    assign dpif.dmemaddr  = exmemif.portO_out;
    
    always_ff @ (posedge CLK, negedge nRST) begin
        if (!nRST) begin
            dpif.halt <= 0;
        end else begin
            dpif.halt <= memwbif.halt_out;
        end
    end

    // Control Unit input assignment
    assign cuif.imemload  = ifidif.imemload_out;

    // ALU input assignment
    assign aluif.port_a   = idexif.rdat1_out;
    assign aluif.alu_op   = idexif.ALUop_out;
    always_comb begin
        aluif.port_b = '0;
        if (cuif.ALUsrc == 2'b00) begin
            aluif.port_b = idexif.rdat2_out;
        end
        else if (cuif.ALUsrc == 2'b01) begin
            aluif.port_b = idexif.shamt_out;
        end
        else if (cuif.ALUsrc == 2'b10) begin
            aluif.port_b = idexif.extImm_out;
        end
    end

    // Register File input assignment
    assign rfif.rsel1     = cuif.Rs;
    assign rfif.rsel2     = cuif.Rt;
    assign rfif.wsel      = memwbif.wsel_out;
    // wdat mux
    always_comb begin
        if (memwbif.memToReg_out == 2'b00) begin 
            rfif.wdat = memwbif.dmemload_out;  
        end 
        else if(memwbif.memToReg_out == 2'b01) begin 
            rfif.wdat = memwbif.portO_out;   
        end 
        else if (memwbif.memToReg_out == 2'b10) begin 
            rfif.wdat = memwbif.LUIval;
        end 
        else begin 
            rfif.wdat = memwbif.pc4_out;
        end 
    end
    assign rfif.WEN = memwbif.regWr_out; // AND with dhit | ihit because of latch?

    // Program Counter input assignment
    assign pcif.pcWEN     = dpif.ihit;
    // JumpSel 
    always_comb
        // PC + 4
        if (idexif.JumpSel_out == 2'b00) begin 
            pcif.pc_next = pcplus4; 
            flush = 0;
        end 
        // Jump
        else if (idexif.JumpSel_out == 2'b01) begin 
            pcif.pc_next =  {idexif.pcp4_out[31:28], idexif.j25_out, 2'b00}; // which PC+4?
            flush = 1;
        end 
        // BNE and BEQ
        else if(idexif.JumpSel_out == 2'b10) begin 
            if (cuif.BNE == 1'b0) begin //BEQ 
                if(aluif.z_flag) begin
                    pcif.pc_next = (idexif.extImm_out << 2) + idexif.pcp4_out; // PC+4 confusion again
                    flush = 1;
                end
                else begin
                    pcif.pc_next = idexif.pcp4_out;
                    flush = 0;
                end
            end  
            else begin 
                if(!aluif.z_flag) begin
                    pcif.pc_next = (idexif.extImm_out << 2) + idexif.pcp4_out;      
                    flush = 1;
                end
                else begin
                    pcif.pc_next = idexif.pcp4_out;
                    flush = 0;
                end
            end
        end  
        else begin 
            pcif.pc_next = idexif.rdat1_out; 
            flush = 1;
        end 
    end


    // **************** GOOD TO HERE ****************

    // IF/ID Latch input assignment
    assign ifidif.imemload_in  = dpif.imemload;
    assign ifidif.pcp4_in      = pcplus4;
    assign ifidif.flush        = flush;
    assign ifidif.ihit         = dpif.ihit;

    // ID/EX Latch input assignment
    assign idexif.jumpFlush_in = cuif.jumpFlush;
    assign idexif.RegDst_in    = cuif.RegDst;
    assign idexif.JumpSel_in   = cuif.JumpSel;
    assign idexif.dREN_in      = cuif.dREN;
    assign idexif.dWEN_in      = cuif.dWEN;
    assign idexif.j25_in       = cuif.j25;
    assign idexif.BNE          = cuif.BNE;
    assign idexif.RegWr_in     = cuif.RegWr;
    assign idexif.MemToReg_in  = cuif.MemToReg;
    assign idexif.ALUsrc_in    = cuif.ALUsrc;
    assign idexif.ALUop_in     = cuif.alu_op;
    assign idexif.halt_in      = cuif.halt;
    assign idexif.shamt_in     = cuif.shamt;
    assign idexif.extImm_in    = extImm;
    assign idexif.rdat1_in     = rfif.rdat1;
    assign idexif.rdat2_in     = rfif.rdat2;
    assign idexif.pcp4_in      = ifidif.pcp4_out;
    // wsel
    always_comb begin
        if(memwbif.regDest_out == 2'b00)  
            idexif.wsel_in = cuif.Rt; 
        else if (memwbif.regDest_out == 2'b01)  
            idexif.wsel_in = cuif.Rd;    
        else if (memwbif.regDest_out == 2'b10) 
            idexif.wsel_in = 5'd31;
        else
            idexif.wsel_in = cuif.Rt;
    end
    assign idexif.flush         = flush;
    assign idexif.ihit          = dpif.ihit;
    assign idexif.op_id         = cuif.opcode;

    // EX/MEM Latch input assignment
    assign exmemif.regDest_in   = idexif.regDest_out;
    assign exmemif.dREN_in      = idexif.dREN_out;
    assign exmemif.dWEN_in      = idexif.dWEN_out;
    assign exmemif.dmemstore_in = idexif.rdat2_out;
    assign exmemif.regWr_in     = idexif.regWr_out;
    assign exmemif.memToReg_in  = idexif.memToReg_out;
    assign exmemif.halt_in      = idexif.halt_out;
    assign exmemif.portO_in     = aluif.port_o;
    assign exmemif.luiValue_in  = {idexif.extImm_out, 16'h0000};
    assign exmemif.pc4_in       = idexif.pcp4_out;
    assign exmemif.ihit         = dpif.ihit;
    assign exmemif.dhit         = dpif.dhit;
    assign exmemif.op_ex        = idexif.op_ex;

    // MEM/WB Latch input assignment
    assign memwbif.regDest_in   = exmemif.regDest_out;
    assign memwbif.dmemload_in  = dpif.dmemload;
    assign memwbif.regWr_in     = exmemif.regWr_out;
    assign memwbif.wsel_in      = exmemif.wsel_out;
    assign memwbif.memToReg_in  = exmemif.memToReg_out;
    assign memwbif.halt_in      = exmemif.halt_out;
    assign memwbif.portO_in     = exmemif.portO_out
    assign memwbif.luiValue_in  = exmemif.luiValue_out;
    assign memwbif.ihit         = dpif.ihit;
    assign memwbif.dhit         = dpif.ihit;
    assign memwbif.pc4_in       = exmemif.pc4_out;
    assign memwbif.op_mem       = exmemif.op_mem;


endmodule
