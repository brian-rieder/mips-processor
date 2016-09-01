onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /alu_tb/PROG/clk
add wave -noupdate -radix decimal /alu_tb/PROG/test_num
add wave -noupdate -divider Operation
add wave -noupdate /alu_tb/aluif/alu_op
add wave -noupdate /alu_tb/aluif/port_a
add wave -noupdate /alu_tb/aluif/port_b
add wave -noupdate /alu_tb/aluif/port_o
add wave -noupdate -divider {Output Flags}
add wave -noupdate /alu_tb/aluif/v_flag
add wave -noupdate /alu_tb/aluif/n_flag
add wave -noupdate /alu_tb/aluif/z_flag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {29 ns} 0}
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
WaveRestoreZoom {0 ns} {221 ns}
