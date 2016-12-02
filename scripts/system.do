onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/halt
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/ihit
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/imemREN
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/imemload
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/imemaddr
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/dhit
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/datomic
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/dmemREN
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/dmemWEN
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/flushed
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/dmemload
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/dmemstore
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/dmemaddr
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
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/cif0/iwait
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/cif0/dwait
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/cif0/iREN
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/cif0/dREN
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/cif0/dWEN
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/cif0/iload
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/cif0/dload
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/cif0/dstore
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/cif0/iaddr
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/cif0/daddr
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/cif0/ccwait
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/cif0/ccinv
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/cif0/ccwrite
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/cif0/cctrans
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/cif0/ccsnoopaddr
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
add wave -noupdate -expand -group CC /system_tb/DUT/CPU/CC/CLK
add wave -noupdate -expand -group CC /system_tb/DUT/CPU/CC/nRST
add wave -noupdate -expand -group CC /system_tb/DUT/CPU/CC/state
add wave -noupdate -expand -group CC /system_tb/DUT/CPU/CC/next_state
add wave -noupdate -expand -group CC /system_tb/DUT/CPU/CC/service_cache
add wave -noupdate -expand -group CC /system_tb/DUT/CPU/CC/instr_service
add wave -noupdate -group ICACHE0 /system_tb/DUT/CPU/CM0/ICACHE/CLK
add wave -noupdate -group ICACHE0 /system_tb/DUT/CPU/CM0/ICACHE/nRST
add wave -noupdate -group ICACHE0 /system_tb/DUT/CPU/CM0/ICACHE/icachetable
add wave -noupdate -group ICACHE0 /system_tb/DUT/CPU/CM0/ICACHE/icf_imemaddr
add wave -noupdate -group ICACHE0 /system_tb/DUT/CPU/CM0/ICACHE/selected_block
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/CLK
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/nRST
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/current_state
add wave -noupdate -expand -group DCACHE0 -expand -subitemconfig {{/system_tb/DUT/CPU/CM0/DCACHE/dcachetable[7]} -expand {/system_tb/DUT/CPU/CM0/DCACHE/dcachetable[7].dcacheframe} -expand {/system_tb/DUT/CPU/CM0/DCACHE/dcachetable[7].dcacheframe[0]} -expand {/system_tb/DUT/CPU/CM0/DCACHE/dcachetable[0]} -expand} /system_tb/DUT/CPU/CM0/DCACHE/dcachetable
add wave -noupdate -expand -group DCACHE0 -radix hexadecimal -childformat {{/system_tb/DUT/CPU/CM0/DCACHE/dcf_dmemaddr.tag -radix hexadecimal} {/system_tb/DUT/CPU/CM0/DCACHE/dcf_dmemaddr.idx -radix hexadecimal} {/system_tb/DUT/CPU/CM0/DCACHE/dcf_dmemaddr.blkoff -radix hexadecimal} {/system_tb/DUT/CPU/CM0/DCACHE/dcf_dmemaddr.bytoff -radix hexadecimal}} -expand -subitemconfig {/system_tb/DUT/CPU/CM0/DCACHE/dcf_dmemaddr.tag {-height 17 -radix hexadecimal} /system_tb/DUT/CPU/CM0/DCACHE/dcf_dmemaddr.idx {-height 17 -radix hexadecimal} /system_tb/DUT/CPU/CM0/DCACHE/dcf_dmemaddr.blkoff {-height 17 -radix hexadecimal} /system_tb/DUT/CPU/CM0/DCACHE/dcf_dmemaddr.bytoff {-height 17 -radix hexadecimal}} /system_tb/DUT/CPU/CM0/DCACHE/dcf_dmemaddr
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/snoopaddr
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/selected_set
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/snoop_set
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/ismatch0
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/ismatch1
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/snoopmatch0
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/snoopmatch1
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/snoopdirty0
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/snoopdirty1
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/flushidx
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/next_flushidx
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/cache_WEN
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/next_valid
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/next_dirty
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/next_lru
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/next_tag
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/next_data0
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/next_data1
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/write_idx
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/link_reg
add wave -noupdate -expand -group DP0_exmem /system_tb/DUT/CPU/DP0/exmemif/dREN_in
add wave -noupdate -expand -group DP0_exmem /system_tb/DUT/CPU/DP0/exmemif/dmemREN_out
add wave -noupdate -expand -group DP0_exmem /system_tb/DUT/CPU/DP0/exmemif/dWEN_in
add wave -noupdate -expand -group DP0_exmem /system_tb/DUT/CPU/DP0/exmemif/dmemWEN_out
add wave -noupdate -expand -group DP0_exmem /system_tb/DUT/CPU/DP0/exmemif/dmemstore_in
add wave -noupdate -expand -group DP0_exmem /system_tb/DUT/CPU/DP0/exmemif/dmemstore_out
add wave -noupdate -expand -group DP0_exmem /system_tb/DUT/CPU/DP0/exmemif/RegWr_in
add wave -noupdate -expand -group DP0_exmem /system_tb/DUT/CPU/DP0/exmemif/RegWr_out
add wave -noupdate -expand -group DP0_exmem /system_tb/DUT/CPU/DP0/exmemif/MemToReg_in
add wave -noupdate -expand -group DP0_exmem /system_tb/DUT/CPU/DP0/exmemif/MemToReg_out
add wave -noupdate -expand -group DP0_exmem /system_tb/DUT/CPU/DP0/exmemif/halt_in
add wave -noupdate -expand -group DP0_exmem /system_tb/DUT/CPU/DP0/exmemif/halt_out
add wave -noupdate -expand -group DP0_exmem /system_tb/DUT/CPU/DP0/exmemif/portO_in
add wave -noupdate -expand -group DP0_exmem /system_tb/DUT/CPU/DP0/exmemif/portO_out
add wave -noupdate -expand -group DP0_exmem /system_tb/DUT/CPU/DP0/exmemif/luiValue_in
add wave -noupdate -expand -group DP0_exmem /system_tb/DUT/CPU/DP0/exmemif/luiValue_out
add wave -noupdate -expand -group DP0_exmem /system_tb/DUT/CPU/DP0/exmemif/enable
add wave -noupdate -expand -group DP0_exmem /system_tb/DUT/CPU/DP0/exmemif/pcp4_out
add wave -noupdate -expand -group DP0_exmem /system_tb/DUT/CPU/DP0/exmemif/wsel_in
add wave -noupdate -expand -group DP0_exmem /system_tb/DUT/CPU/DP0/exmemif/wsel_out
add wave -noupdate -expand -group DP0_exmem /system_tb/DUT/CPU/DP0/exmemif/op_mem
add wave -noupdate -expand -group DP0_exmem /system_tb/DUT/CPU/DP0/exmemif/flush
add wave -noupdate -expand -group DP0_exmem /system_tb/DUT/CPU/DP0/exmemif/datomic_in
add wave -noupdate -expand -group DP0_exmem /system_tb/DUT/CPU/DP0/exmemif/datomic_out
add wave -noupdate -group ICACHE1 /system_tb/DUT/CPU/CM1/ICACHE/CLK
add wave -noupdate -group ICACHE1 /system_tb/DUT/CPU/CM1/ICACHE/nRST
add wave -noupdate -group ICACHE1 /system_tb/DUT/CPU/CM1/ICACHE/icachetable
add wave -noupdate -group ICACHE1 /system_tb/DUT/CPU/CM1/ICACHE/icf_imemaddr
add wave -noupdate -group ICACHE1 /system_tb/DUT/CPU/CM1/ICACHE/selected_block
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/CLK
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/nRST
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/current_state
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_state
add wave -noupdate -expand -group DCACHE1 -subitemconfig {{/system_tb/DUT/CPU/CM1/DCACHE/dcachetable[7]} -expand {/system_tb/DUT/CPU/CM1/DCACHE/dcachetable[1]} -expand {/system_tb/DUT/CPU/CM1/DCACHE/dcachetable[0]} -expand} /system_tb/DUT/CPU/CM1/DCACHE/dcachetable
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/dcf_dmemaddr
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/snoopaddr
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/selected_set
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/snoop_set
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/ismatch0
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/ismatch1
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/snoopmatch0
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/snoopmatch1
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/snoopdirty0
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/snoopdirty1
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/flushidx
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_flushidx
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/dhit_counter
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/miss_counter
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_miss_counter
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/cache_WEN
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_valid
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_dirty
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_lru
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_tag
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_data0
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_data1
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/write_idx
add wave -noupdate -expand -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/link_reg
add wave -noupdate -group DP1_exmem /system_tb/DUT/CPU/DP1/EXMEM/exmemif/dREN_in
add wave -noupdate -group DP1_exmem /system_tb/DUT/CPU/DP1/EXMEM/exmemif/dmemREN_out
add wave -noupdate -group DP1_exmem /system_tb/DUT/CPU/DP1/EXMEM/exmemif/dWEN_in
add wave -noupdate -group DP1_exmem /system_tb/DUT/CPU/DP1/EXMEM/exmemif/dmemWEN_out
add wave -noupdate -group DP1_exmem /system_tb/DUT/CPU/DP1/EXMEM/exmemif/dmemstore_in
add wave -noupdate -group DP1_exmem /system_tb/DUT/CPU/DP1/EXMEM/exmemif/dmemstore_out
add wave -noupdate -group DP1_exmem /system_tb/DUT/CPU/DP1/EXMEM/exmemif/RegWr_in
add wave -noupdate -group DP1_exmem /system_tb/DUT/CPU/DP1/EXMEM/exmemif/RegWr_out
add wave -noupdate -group DP1_exmem /system_tb/DUT/CPU/DP1/EXMEM/exmemif/MemToReg_in
add wave -noupdate -group DP1_exmem /system_tb/DUT/CPU/DP1/EXMEM/exmemif/MemToReg_out
add wave -noupdate -group DP1_exmem /system_tb/DUT/CPU/DP1/EXMEM/exmemif/halt_in
add wave -noupdate -group DP1_exmem /system_tb/DUT/CPU/DP1/EXMEM/exmemif/halt_out
add wave -noupdate -group DP1_exmem /system_tb/DUT/CPU/DP1/EXMEM/exmemif/portO_in
add wave -noupdate -group DP1_exmem /system_tb/DUT/CPU/DP1/EXMEM/exmemif/portO_out
add wave -noupdate -group DP1_exmem /system_tb/DUT/CPU/DP1/EXMEM/exmemif/luiValue_in
add wave -noupdate -group DP1_exmem /system_tb/DUT/CPU/DP1/EXMEM/exmemif/luiValue_out
add wave -noupdate -group DP1_exmem /system_tb/DUT/CPU/DP1/EXMEM/exmemif/enable
add wave -noupdate -group DP1_exmem /system_tb/DUT/CPU/DP1/EXMEM/exmemif/pcp4_in
add wave -noupdate -group DP1_exmem /system_tb/DUT/CPU/DP1/EXMEM/exmemif/pcp4_out
add wave -noupdate -group DP1_exmem /system_tb/DUT/CPU/DP1/EXMEM/exmemif/wsel_in
add wave -noupdate -group DP1_exmem /system_tb/DUT/CPU/DP1/EXMEM/exmemif/wsel_out
add wave -noupdate -group DP1_exmem /system_tb/DUT/CPU/DP1/EXMEM/exmemif/op_ex
add wave -noupdate -group DP1_exmem /system_tb/DUT/CPU/DP1/EXMEM/exmemif/op_mem
add wave -noupdate -group DP1_exmem /system_tb/DUT/CPU/DP1/EXMEM/exmemif/flush
add wave -noupdate -group DP1_exmem /system_tb/DUT/CPU/DP1/EXMEM/exmemif/datomic_in
add wave -noupdate -group DP1_exmem /system_tb/DUT/CPU/DP1/EXMEM/exmemif/datomic_out
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/memREN
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/memWEN
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/memaddr
add wave -noupdate -expand -group RAM /system_tb/DUT/RAM/ramif/memstore
add wave -noupdate -label {Cache 0 Registers} -expand /system_tb/DUT/CPU/DP0/RF/registers
add wave -noupdate -label {Cache 1 Registers} /system_tb/DUT/CPU/DP1/RF/registers
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Loop Start} {4639893 ps} 1} {{Cursor 2} {7398179 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 188
configure wave -valuecolwidth 134
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
WaveRestoreZoom {6643813 ps} {9337977 ps}
