onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /request_unit_tb/PROG/test_num
add wave -noupdate /request_unit_tb/CLK
add wave -noupdate /request_unit_tb/nRST
add wave -noupdate -divider {TB Assertions}
add wave -noupdate /request_unit_tb/ruif/halt
add wave -noupdate /request_unit_tb/ruif/dWEN
add wave -noupdate /request_unit_tb/ruif/dREN
add wave -noupdate /request_unit_tb/ruif/ihit
add wave -noupdate /request_unit_tb/ruif/dhit
add wave -noupdate -divider {RU Outputs}
add wave -noupdate /request_unit_tb/ruif/dmemWEN
add wave -noupdate /request_unit_tb/ruif/dmemREN
add wave -noupdate /request_unit_tb/ruif/imemREN
add wave -noupdate /request_unit_tb/ruif/pcWEN
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10 ns} 0}
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
WaveRestoreZoom {0 ns} {32 ns}
