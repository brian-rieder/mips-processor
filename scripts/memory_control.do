onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /memory_control_tb/PROG/test_num
add wave -noupdate /memory_control_tb/CLK
add wave -noupdate /memory_control_tb/nRST
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/dwait
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/dREN
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/dWEN
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/dload
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/dstore
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/iaddr
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/daddr
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/ccwait
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/ccinv
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/ccwrite
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/cctrans
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/ccsnoopaddr
add wave -noupdate -divider ramif
add wave -noupdate /memory_control_tb/ramif/ramREN
add wave -noupdate /memory_control_tb/ramif/ramWEN
add wave -noupdate /memory_control_tb/ramif/ramaddr
add wave -noupdate /memory_control_tb/ramif/ramstore
add wave -noupdate /memory_control_tb/ramif/ramload
add wave -noupdate /memory_control_tb/ramif/ramstate
add wave -noupdate /memory_control_tb/ccif/ramstate
add wave -noupdate -expand -group memory_control_tb /memory_control_tb/DUT/state
add wave -noupdate -expand -group memory_control_tb /memory_control_tb/DUT/service_cache
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {19590 ps} 0}
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
WaveRestoreZoom {0 ps} {105 ns}
