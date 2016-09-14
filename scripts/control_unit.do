onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /control_unit_tb/PROG/test_num
add wave -noupdate /control_unit_tb/CLK
add wave -noupdate -divider Inputs
add wave -noupdate /control_unit_tb/PROG/#ublk#502948#43/j_inst
add wave -noupdate /control_unit_tb/PROG/#ublk#502948#43/i_inst
add wave -noupdate /control_unit_tb/PROG/#ublk#502948#43/r_inst
add wave -noupdate /control_unit_tb/cuif/imemload
add wave -noupdate -divider {Control Unit Out}
add wave -noupdate /control_unit_tb/cuif/ALUsrc
add wave -noupdate /control_unit_tb/cuif/RegDst
add wave -noupdate /control_unit_tb/cuif/JumpSel
add wave -noupdate /control_unit_tb/cuif/MemToReg
add wave -noupdate /control_unit_tb/cuif/dWEN
add wave -noupdate /control_unit_tb/cuif/dREN
add wave -noupdate /control_unit_tb/cuif/RegWr
add wave -noupdate /control_unit_tb/cuif/BNE
add wave -noupdate /control_unit_tb/cuif/JAL
add wave -noupdate /control_unit_tb/cuif/LUI
add wave -noupdate /control_unit_tb/cuif/PCsrc
add wave -noupdate /control_unit_tb/cuif/ExtOp
add wave -noupdate /control_unit_tb/cuif/alu_op
add wave -noupdate /control_unit_tb/cuif/Rs
add wave -noupdate /control_unit_tb/cuif/Rt
add wave -noupdate /control_unit_tb/cuif/Rd
add wave -noupdate /control_unit_tb/cuif/imm16
add wave -noupdate /control_unit_tb/cuif/shamt
add wave -noupdate /control_unit_tb/cuif/halt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {158 ns} 0}
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
WaveRestoreZoom {0 ns} {630 ns}
