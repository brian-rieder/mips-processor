onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/halt
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/ihit
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/imemREN
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/imemload
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/imemaddr
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dhit
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/datomic
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dmemREN
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dmemWEN
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/flushed
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dmemload
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dmemstore
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dmemaddr
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/halt
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/ihit
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/imemREN
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/imemload
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/imemaddr
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dhit
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/datomic
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemREN
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemWEN
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/flushed
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemload
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemstore
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemaddr
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/iwait
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/dwait
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/iREN
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/dREN
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/dWEN
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/iload
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/dload
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/dstore
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/iaddr
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/daddr
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/ccwait
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/ccinv
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/ccwrite
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/cctrans
add wave -noupdate -group cif0 /system_tb/DUT/CPU/cif0/ccsnoopaddr
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/iwait
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/dwait
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/iREN
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/dREN
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/dWEN
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/iload
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/dload
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/dstore
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/iaddr
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/daddr
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/ccwait
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/ccinv
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/ccwrite
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/cctrans
add wave -noupdate -group cif1 /system_tb/DUT/CPU/cif1/ccsnoopaddr
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/iwait
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/dwait
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/iREN
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/dREN
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/dWEN
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/iload
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/dload
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/dstore
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/iaddr
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/daddr
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ccwait
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ccinv
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ccwrite
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/cctrans
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ccsnoopaddr
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramWEN
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramREN
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramstate
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramaddr
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramstore
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramload
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/CLK
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/nRST
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/extImm
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/pcplus4
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/jumpdest
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/luiValue
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/flush
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/fwd_portB
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/mem_wdat
add wave -noupdate -group DP0 /system_tb/DUT/CPU/DP0/wb_wdat
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/CLK
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/nRST
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/extImm
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/pcplus4
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/jumpdest
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/luiValue
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/flush
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/fwd_portB
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/mem_wdat
add wave -noupdate -group DP1 /system_tb/DUT/CPU/DP1/wb_wdat
add wave -noupdate -group CC /system_tb/DUT/CPU/CC/CLK
add wave -noupdate -group CC /system_tb/DUT/CPU/CC/nRST
add wave -noupdate -group CC /system_tb/DUT/CPU/CC/state
add wave -noupdate -group CC /system_tb/DUT/CPU/CC/next_state
add wave -noupdate -group CC /system_tb/DUT/CPU/CC/service_cache
add wave -noupdate -group CC /system_tb/DUT/CPU/CC/next_service_cache
add wave -noupdate -group CC /system_tb/DUT/CPU/CC/instr_service
add wave -noupdate -group CC /system_tb/DUT/CPU/CC/next_instr_service
add wave -noupdate -group ICACHE0 /system_tb/DUT/CPU/CM0/ICACHE/CLK
add wave -noupdate -group ICACHE0 /system_tb/DUT/CPU/CM0/ICACHE/nRST
add wave -noupdate -group ICACHE0 /system_tb/DUT/CPU/CM0/ICACHE/icachetable
add wave -noupdate -group ICACHE0 /system_tb/DUT/CPU/CM0/ICACHE/icf_imemaddr
add wave -noupdate -group ICACHE0 /system_tb/DUT/CPU/CM0/ICACHE/selected_block
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/CLK
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/nRST
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/current_state
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/next_state
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/dcachetable
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/dcf_dmemaddr
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/snoopaddr
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/selected_set
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/snoop_set
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/ismatch0
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/ismatch1
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/snoopmatch0
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/snoopmatch1
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/snoopdirty0
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/snoopdirty1
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/flushidx
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/next_flushidx
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/dhit_counter
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/next_dhit_counter
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/miss_counter
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/next_miss_counter
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/cache_WEN
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/next_valid
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/next_dirty
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/next_lru
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/next_tag
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/next_data0
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/next_data1
add wave -noupdate -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/write_idx
add wave -noupdate -group ICACHE1 /system_tb/DUT/CPU/CM1/ICACHE/CLK
add wave -noupdate -group ICACHE1 /system_tb/DUT/CPU/CM1/ICACHE/nRST
add wave -noupdate -group ICACHE1 /system_tb/DUT/CPU/CM1/ICACHE/icachetable
add wave -noupdate -group ICACHE1 /system_tb/DUT/CPU/CM1/ICACHE/icf_imemaddr
add wave -noupdate -group ICACHE1 /system_tb/DUT/CPU/CM1/ICACHE/selected_block
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/CLK
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/nRST
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/current_state
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_state
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/dcachetable
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/dcf_dmemaddr
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/snoopaddr
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/selected_set
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/snoop_set
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/ismatch0
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/ismatch1
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/snoopmatch0
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/snoopmatch1
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/snoopdirty0
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/snoopdirty1
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/flushidx
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_flushidx
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/dhit_counter
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_dhit_counter
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/miss_counter
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_miss_counter
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/cache_WEN
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_valid
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_dirty
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_lru
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_tag
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_data0
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_data1
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/write_idx
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
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {29400179422 ps} 0}
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
WaveRestoreZoom {17992420131 ps} {17992672625 ps}
