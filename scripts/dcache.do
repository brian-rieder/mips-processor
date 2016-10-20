onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /dcache_tb/PROG/test_num
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/nRST
add wave -noupdate -divider Inputs
add wave -noupdate /dcache_tb/dcif/dmemREN
add wave -noupdate /dcache_tb/dcif/dmemWEN
add wave -noupdate /dcache_tb/dcif/dmemstore
add wave -noupdate /dcache_tb/dcif/dmemaddr
add wave -noupdate /dcache_tb/dcif/dhit
add wave -noupdate /dcache_tb/cif/dwait
add wave -noupdate /dcache_tb/cif/dload
add wave -noupdate -divider Outputs
add wave -noupdate /dcache_tb/dcif/dmemload
add wave -noupdate /dcache_tb/dcif/halt
add wave -noupdate /dcache_tb/dcif/flushed
add wave -noupdate /dcache_tb/cif/dREN
add wave -noupdate /dcache_tb/cif/dWEN
add wave -noupdate /dcache_tb/cif/daddr
add wave -noupdate /dcache_tb/cif/dstore
add wave -noupdate -divider {Internal Signals}
add wave -noupdate /dcache_tb/DUT/current_state
add wave -noupdate /dcache_tb/DUT/dcf_dmemaddr
add wave -noupdate /dcache_tb/DUT/cache_WEN
add wave -noupdate /dcache_tb/DUT/selected_set
add wave -noupdate -expand -subitemconfig {{/dcache_tb/DUT/dcachetable[1]} -expand} /dcache_tb/DUT/dcachetable
add wave -noupdate /dcache_tb/DUT/dhit_counter
add wave -noupdate /dcache_tb/DUT/miss_counter
add wave -noupdate -group {Next Values} /dcache_tb/DUT/next_state
add wave -noupdate -group {Next Values} /dcache_tb/DUT/next_valid
add wave -noupdate -group {Next Values} /dcache_tb/DUT/next_dirty
add wave -noupdate -group {Next Values} /dcache_tb/DUT/next_lru
add wave -noupdate -group {Next Values} /dcache_tb/DUT/next_tag
add wave -noupdate -group {Next Values} /dcache_tb/DUT/next_data0
add wave -noupdate -group {Next Values} /dcache_tb/DUT/next_data1
add wave -noupdate /dcache_tb/DUT/ismatch0
add wave -noupdate /dcache_tb/DUT/ismatch1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {17 ns} 0}
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
WaveRestoreZoom {0 ns} {205 ns}
