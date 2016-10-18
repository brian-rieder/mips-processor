onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /icache_tb/CLK
add wave -noupdate /icache_tb/nRST
add wave -noupdate -expand -group DCIF /icache_tb/DUT/dcif/ihit
add wave -noupdate -expand -group DCIF /icache_tb/DUT/dcif/imemREN
add wave -noupdate -expand -group DCIF /icache_tb/DUT/dcif/imemload
add wave -noupdate -expand -group DCIF /icache_tb/DUT/dcif/imemaddr
add wave -noupdate -expand -group CIF /icache_tb/DUT/cif/iwait
add wave -noupdate -expand -group CIF /icache_tb/DUT/cif/iREN
add wave -noupdate -expand -group CIF /icache_tb/DUT/cif/iload
add wave -noupdate -expand -group CIF /icache_tb/DUT/cif/iaddr
add wave -noupdate -expand -group {Icache Signals} /icache_tb/DUT/icachetable
add wave -noupdate -expand -group {Icache Signals} /icache_tb/DUT/selected_block
add wave -noupdate -expand -group {Icache Signals} /icache_tb/DUT/icf_imemaddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {0 ns} {172 ns}
