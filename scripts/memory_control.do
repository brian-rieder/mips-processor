onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /memory_control_tb/PROG/test_num
add wave -noupdate /memory_control_tb/CLK
add wave -noupdate /memory_control_tb/nRST
add wave -noupdate /memory_control_tb/ccif/iREN
add wave -noupdate /memory_control_tb/ccif/dREN
add wave -noupdate /memory_control_tb/ccif/dWEN
add wave -noupdate /memory_control_tb/ccif/daddr
add wave -noupdate /memory_control_tb/ccif/dstore
add wave -noupdate /memory_control_tb/ccif/iaddr
add wave -noupdate -divider ramif
add wave -noupdate /memory_control_tb/ramif/ramREN
add wave -noupdate /memory_control_tb/ramif/ramWEN
add wave -noupdate /memory_control_tb/ramif/ramaddr
add wave -noupdate /memory_control_tb/ramif/ramstore
add wave -noupdate /memory_control_tb/ramif/ramload
add wave -noupdate /memory_control_tb/ramif/ramstate
add wave -noupdate /memory_control_tb/ramif/memREN
add wave -noupdate /memory_control_tb/ramif/memWEN
add wave -noupdate /memory_control_tb/ramif/memaddr
add wave -noupdate /memory_control_tb/ramif/memstore
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {13208 ps} 0}
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
WaveRestoreZoom {0 ps} {37549 ps}
