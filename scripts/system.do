onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -divider Datapath
add wave -noupdate -expand -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/WEN
add wave -noupdate -expand -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/wsel
add wave -noupdate -expand -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rsel1
add wave -noupdate -expand -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rsel2
add wave -noupdate -expand -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/wdat
add wave -noupdate -expand -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rdat1
add wave -noupdate -expand -group {Register File} /system_tb/DUT/CPU/DP/RF/rfif/rdat2
add wave -noupdate -expand -group {Register File} -expand /system_tb/DUT/CPU/DP/RF/registers
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/opcode
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/funct
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/imemload
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/shamt
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/alu_op
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/ALUsrc
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/RegDst
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/JumpSel
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/MemToReg
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/halt
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/dWEN
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/dREN
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/RegWr
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/BNE
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/jumpFlush
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/PCsrc
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/ExtOp
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/Rs
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/Rt
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/Rd
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/imm16
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/j25
add wave -noupdate -expand -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/pc_next
add wave -noupdate -expand -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/pc_out
add wave -noupdate -expand -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/pcWEN
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/port_a
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/port_b
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/port_o
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/alu_op
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/z_flag
add wave -noupdate -expand -group {IF/ID Latch} /system_tb/DUT/CPU/DP/IFID/ifidif/imemload_in
add wave -noupdate -expand -group {IF/ID Latch} /system_tb/DUT/CPU/DP/IFID/ifidif/imemload_out
add wave -noupdate -expand -group {IF/ID Latch} /system_tb/DUT/CPU/DP/IFID/ifidif/pcp4_in
add wave -noupdate -expand -group {IF/ID Latch} /system_tb/DUT/CPU/DP/IFID/ifidif/pcp4_out
add wave -noupdate -expand -group {IF/ID Latch} /system_tb/DUT/CPU/DP/IFID/ifidif/ihit
add wave -noupdate -expand -group {IF/ID Latch} /system_tb/DUT/CPU/DP/IFID/ifidif/flush
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/op_id
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/ALUop_in
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/pcp4_in
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/rdat1_in
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/rdat2_in
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/extImm_in
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/shamt_in
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/ALUsrc_in
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/JumpSel_in
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/MemToReg_in
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/dREN_in
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/dWEN_in
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/halt_in
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/jumpFlush_in
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/PCsrc_in
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/RegWr_in
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/BNE_in
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/ihit
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/flush
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/wsel_in
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/j25_in
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/op_ex
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/ALUop_out
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/pcp4_out
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/rdat1_out
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/rdat2_out
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/extImm_out
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/shamt_out
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/ALUsrc_out
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/JumpSel_out
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/MemToReg_out
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/PCsrc_out
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/dREN_out
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/dWEN_out
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/halt_out
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/jumpFlush_out
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/RegWr_out
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/BNE_out
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/wsel_out
add wave -noupdate -expand -group {ID/EX Latch} /system_tb/DUT/CPU/DP/IDEX/idexif/j25_out
add wave -noupdate -expand -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/dREN_in
add wave -noupdate -expand -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/dWEN_in
add wave -noupdate -expand -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/dmemREN_out
add wave -noupdate -expand -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/dmemWEN_out
add wave -noupdate -expand -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/dmemstore_in
add wave -noupdate -expand -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/dmemstore_out
add wave -noupdate -expand -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/RegWr_in
add wave -noupdate -expand -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/RegWr_out
add wave -noupdate -expand -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/MemToReg_in
add wave -noupdate -expand -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/MemToReg_out
add wave -noupdate -expand -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/halt_in
add wave -noupdate -expand -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/halt_out
add wave -noupdate -expand -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/portO_in
add wave -noupdate -expand -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/portO_out
add wave -noupdate -expand -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/luiValue_in
add wave -noupdate -expand -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/luiValue_out
add wave -noupdate -expand -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/ihit
add wave -noupdate -expand -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/dhit
add wave -noupdate -expand -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/pcp4_in
add wave -noupdate -expand -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/pcp4_out
add wave -noupdate -expand -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/wsel_in
add wave -noupdate -expand -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/wsel_out
add wave -noupdate -expand -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/op_ex
add wave -noupdate -expand -group {EX/MEM Latch} /system_tb/DUT/CPU/DP/EXMEM/exmemif/op_mem
add wave -noupdate -expand -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/dmemload_in
add wave -noupdate -expand -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/dmemload_out
add wave -noupdate -expand -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/RegWr_in
add wave -noupdate -expand -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/RegWr_out
add wave -noupdate -expand -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/wsel_in
add wave -noupdate -expand -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/wsel_out
add wave -noupdate -expand -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/MemToReg_in
add wave -noupdate -expand -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/MemToReg_out
add wave -noupdate -expand -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/halt_in
add wave -noupdate -expand -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/halt_out
add wave -noupdate -expand -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/portO_in
add wave -noupdate -expand -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/portO_out
add wave -noupdate -expand -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/luiValue_in
add wave -noupdate -expand -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/luiValue_out
add wave -noupdate -expand -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/ihit
add wave -noupdate -expand -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/dhit
add wave -noupdate -expand -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/pcp4_in
add wave -noupdate -expand -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/pcp4_out
add wave -noupdate -expand -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/op_mem
add wave -noupdate -expand -group {MEM/WB Latch} /system_tb/DUT/CPU/DP/MEMWB/memwbif/op_wb
add wave -noupdate -expand -group Datapath /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate -expand -group Datapath /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate -expand -group Datapath /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate -expand -group Datapath /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -expand -group Datapath /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate -expand -group Datapath /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate -expand -group Datapath /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate -expand -group Datapath /system_tb/DUT/CPU/DP/dpif/dmemaddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {664315 ps} 0}
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
WaveRestoreZoom {0 ps} {1882 ns}
