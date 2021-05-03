transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Quang/202/Verilog/lab1 {D:/Quang/202/Verilog/lab1/shifter.v}
vlog -vlog01compat -work work +incdir+D:/Quang/202/Verilog/lab1 {D:/Quang/202/Verilog/lab1/processor.v}
vlog -vlog01compat -work work +incdir+D:/Quang/202/Verilog/lab1 {D:/Quang/202/Verilog/lab1/bound_flasher.v}

vlog -vlog01compat -work work +incdir+D:/Quang/202/Verilog/lab1 {D:/Quang/202/Verilog/lab1/t_bound_flasher.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiv_hssi_ver -L cycloneiv_pcie_hip_ver -L cycloneiv_ver -L rtl_work -L work -voptargs="+acc"  test_bound_flasher

add wave *
view structure
view signals
run -all
