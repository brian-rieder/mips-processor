onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -divider Datapath
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/WEN
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/wsel
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rsel1
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rsel2
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/wdat
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rdat1
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rdat2
add wave -noupdate -group {Register File} /system_tb/DUT/CPU/DP/RF/registers
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/opcode
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/CU/funct
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/imemload
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/shamt
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/alu_op
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/ALUsrc
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/RegDst
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/JumpSel
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/MemToReg
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/halt
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/dWEN
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/dREN
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/RegWr
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/BNE
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/jumpFlush
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/PCsrc
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/ExtOp
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/Rs
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/Rt
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/Rd
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/imm16
add wave -noupdate -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/j25
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/pc_next
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/pc_out
add wave -noupdate -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/pcWEN
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/port_a
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/port_b
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/port_o
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/alu_op
add wave -noupdate -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/z_flag
add wave -noupdate -group {IF/ID Latch} /system_tb/DUT/CPU/DP/IFID/ifidif/imemload_in
add wave -noupdate -group {IF/ID Latch} /system_tb/DUT/CPU/DP/IFID/ifidif/imemload_out
add wave -noupdate -group {IF/ID Latch} /system_tb/DUT/CPU/DP/IFID/ifidif/pcp4_in
add wave -noupdate -group {IF/ID Latch} /system_tb/DUT/CPU/DP/IFID/ifidif/pcp4_out
add wave -noupdate -group {IF/ID Latch} /system_tb/DUT/CPU/DP/IFID/ifidif/flush
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/op_id
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/ALUop_in
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/pcp4_in
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/rdat1_in
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/rdat2_in
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/extImm_in
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/shamt_in
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/ALUsrc_in
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/JumpSel_in
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/MemToReg_in
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/dREN_in
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/dWEN_in
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/halt_in
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/jumpFlush_in
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/PCsrc_in
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/RegWr_in
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/BNE_in
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/flush
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/wsel_in
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/j25_in
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/op_ex
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/ALUop_out
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/pcp4_out
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/rdat1_out
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/rdat2_out
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/extImm_out
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/shamt_out
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/ALUsrc_out
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/JumpSel_out
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/MemToReg_out
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/PCsrc_out
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/dREN_out
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/dWEN_out
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/halt_out
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/jumpFlush_out
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/RegWr_out
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/BNE_out
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/wsel_out
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/j25_out
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/idexif/Rs_in
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/idexif/Rt_in
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/idexif/Rs_out
add wave -noupdate -group {ID/EX Latch} /system_tb/DUT/CPU/DP/idexif/Rt_out
add wave -noupdate -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/dREN_in
add wave -noupdate -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/dWEN_in
add wave -noupdate -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/dmemREN_out
add wave -noupdate -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/dmemWEN_out
add wave -noupdate -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/dmemstore_in
add wave -noupdate -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/dmemstore_out
add wave -noupdate -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/RegWr_in
add wave -noupdate -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/RegWr_out
add wave -noupdate -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/MemToReg_in
add wave -noupdate -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/MemToReg_out
add wave -noupdate -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/halt_in
add wave -noupdate -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/halt_out
add wave -noupdate -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/portO_in
add wave -noupdate -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/portO_out
add wave -noupdate -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/luiValue_in
add wave -noupdate -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/luiValue_out
add wave -noupdate -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/pcp4_in
add wave -noupdate -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/pcp4_out
add wave -noupdate -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/wsel_in
add wave -noupdate -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/wsel_out
add wave -noupdate -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/op_ex
add wave -noupdate -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/op_mem
add wave -noupdate -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/dmemload_in
add wave -noupdate -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/dmemload_out
add wave -noupdate -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/RegWr_in
add wave -noupdate -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/RegWr_out
add wave -noupdate -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/wsel_in
add wave -noupdate -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/wsel_out
add wave -noupdate -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/MemToReg_in
add wave -noupdate -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/MemToReg_out
add wave -noupdate -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/halt_in
add wave -noupdate -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/halt_out
add wave -noupdate -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/portO_in
add wave -noupdate -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/portO_out
add wave -noupdate -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/luiValue_in
add wave -noupdate -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/luiValue_out
add wave -noupdate -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/pcp4_in
add wave -noupdate -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/pcp4_out
add wave -noupdate -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/op_mem
add wave -noupdate -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/op_wb
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/ihit
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/dhit
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/BranchFlush
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/JumpFlush
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/MEMWB_RegWr
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/EXMEM_RegWr
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/IDEX_Rs
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/IDEX_Rt
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/ex_op
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/mem_op
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/forwardA
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/forwardB
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/EXMEM_wsel
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/MEMWB_wsel
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/pcWEN
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/IFID_enable
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/IFID_flush
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/IDEX_enable
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/IDEX_flush
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/EXMEM_enable
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/EXMEM_flush
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/huif/MEMWB_enable
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/HU/ihit_pause
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/dpif/dmemaddr
add wave -noupdate -divider Caches
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/dcif/ihit
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/dcif/imemload
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/dcif/imemaddr
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/cif/iwait
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/cif/iREN
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/cif/iload
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/cif/iaddr
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/dcif/imemREN
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/ICACHE/icachetable
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/ICACHE/icf_imemaddr
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/ICACHE/selected_block
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/current_state
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/next_state
add wave -noupdate -group dcache -expand -subitemconfig {{/system_tb/DUT/CPU/CM/DCACHE/dcachetable[1]} -expand} /system_tb/DUT/CPU/CM/DCACHE/dcachetable
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/dcf_dmemaddr
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/selected_set
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/ismatch0
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/ismatch1
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/flushidx
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/next_flushidx
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/dhit_counter
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/miss_counter
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/cache_WEN
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/next_valid
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/next_dirty
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/next_lru
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/next_tag
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/next_data0
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/next_data1
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHE/write_idx
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/dcif/halt
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/dcif/dhit
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/dcif/datomic
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/dcif/dmemREN
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/dcif/dmemWEN
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/dcif/flushed
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/cif/dwait
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/cif/dREN
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/cif/dWEN
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/cif/daddr
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/cif/dload
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/cif/dstore
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/dcif/dmemload
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/dcif/dmemstore
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/dcif/dmemaddr
add wave -noupdate -divider {Memory Interface}
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/memREN
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/memWEN
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/memaddr
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/memstore
add wave -noupdate -group {Memory Control} /system_tb/DUT/CPU/CC/ccif/iwait
add wave -noupdate -group {Memory Control} /system_tb/DUT/CPU/CC/ccif/dwait
add wave -noupdate -group {Memory Control} /system_tb/DUT/CPU/CC/ccif/iload
add wave -noupdate -group {Memory Control} /system_tb/DUT/CPU/CC/ccif/dload
add wave -noupdate -group {Memory Control} /system_tb/DUT/CPU/CC/ccif/ramWEN
add wave -noupdate -group {Memory Control} /system_tb/DUT/CPU/CC/ccif/ramREN
add wave -noupdate -group {Memory Control} /system_tb/DUT/CPU/CC/ccif/ramaddr
add wave -noupdate -group {Memory Control} /system_tb/DUT/CPU/CC/ccif/ramstore
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3290221 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {3227689 ps} {4170088 ps}
