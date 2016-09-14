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
add wave -noupdate -expand -group {Register File} /system_tb/DUT/CPU/DP/RF/registers
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/op
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
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/JAL
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/LUI
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/PCsrc
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/ExtOp
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/Rs
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/Rt
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/Rd
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/CU/cuif/imm16
add wave -noupdate -expand -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/pc_next
add wave -noupdate -expand -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/pc_out
add wave -noupdate -expand -group {Program Counter} /system_tb/DUT/CPU/DP/PC/pcif/pcWEN
add wave -noupdate -expand -group {Request Unit} /system_tb/DUT/CPU/DP/RU/ruif/dWEN
add wave -noupdate -expand -group {Request Unit} /system_tb/DUT/CPU/DP/RU/ruif/dREN
add wave -noupdate -expand -group {Request Unit} /system_tb/DUT/CPU/DP/RU/ruif/ihit
add wave -noupdate -expand -group {Request Unit} /system_tb/DUT/CPU/DP/RU/ruif/dhit
add wave -noupdate -expand -group {Request Unit} /system_tb/DUT/CPU/DP/RU/ruif/dmemWEN
add wave -noupdate -expand -group {Request Unit} /system_tb/DUT/CPU/DP/RU/ruif/dmemREN
add wave -noupdate -expand -group {Request Unit} /system_tb/DUT/CPU/DP/RU/ruif/imemREN
add wave -noupdate -expand -group {Request Unit} /system_tb/DUT/CPU/DP/RU/ruif/pcWEN
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/port_a
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/port_b
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/port_o
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/alu_op
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/ALU/aluif/z_flag
add wave -noupdate -expand -group Datapath /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate -expand -group Datapath /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate -expand -group Datapath /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate -expand -group Datapath /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -expand -group Datapath /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate -expand -group Datapath /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate -expand -group Datapath /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate -expand -group Datapath /system_tb/DUT/CPU/DP/dpif/dmemaddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1306779095 ps} 0}
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
WaveRestoreZoom {0 ps} {5837231 ps}
