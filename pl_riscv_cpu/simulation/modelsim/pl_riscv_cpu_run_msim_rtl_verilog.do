transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 3/pipleine_riscv/pl_riscv_cpu/code {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 3/pipleine_riscv/pl_riscv_cpu/code/pl_riscv_cpu.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 3/pipleine_riscv/pl_riscv_cpu/code {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 3/pipleine_riscv/pl_riscv_cpu/code/riscv_cpu.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 3/pipleine_riscv/pl_riscv_cpu/code {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 3/pipleine_riscv/pl_riscv_cpu/code/data_mem.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 3/pipleine_riscv/pl_riscv_cpu/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 3/pipleine_riscv/pl_riscv_cpu/code/components/pl_reg_fd.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 3/pipleine_riscv/pl_riscv_cpu/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 3/pipleine_riscv/pl_riscv_cpu/code/components/branching_unit.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 3/pipleine_riscv/pl_riscv_cpu/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 3/pipleine_riscv/pl_riscv_cpu/code/components/reset_ff.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 3/pipleine_riscv/pl_riscv_cpu/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 3/pipleine_riscv/pl_riscv_cpu/code/components/reg_file.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 3/pipleine_riscv/pl_riscv_cpu/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 3/pipleine_riscv/pl_riscv_cpu/code/components/mux4.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 3/pipleine_riscv/pl_riscv_cpu/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 3/pipleine_riscv/pl_riscv_cpu/code/components/mux2.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 3/pipleine_riscv/pl_riscv_cpu/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 3/pipleine_riscv/pl_riscv_cpu/code/components/main_decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 3/pipleine_riscv/pl_riscv_cpu/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 3/pipleine_riscv/pl_riscv_cpu/code/components/imm_extend.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 3/pipleine_riscv/pl_riscv_cpu/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 3/pipleine_riscv/pl_riscv_cpu/code/components/datapath.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 3/pipleine_riscv/pl_riscv_cpu/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 3/pipleine_riscv/pl_riscv_cpu/code/components/controller.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 3/pipleine_riscv/pl_riscv_cpu/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 3/pipleine_riscv/pl_riscv_cpu/code/components/alu_decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 3/pipleine_riscv/pl_riscv_cpu/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 3/pipleine_riscv/pl_riscv_cpu/code/components/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 3/pipleine_riscv/pl_riscv_cpu/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 3/pipleine_riscv/pl_riscv_cpu/code/components/adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 3/pipleine_riscv/pl_riscv_cpu/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 3/pipleine_riscv/pl_riscv_cpu/code/components/pl_reg_de.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 3/pipleine_riscv/pl_riscv_cpu/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 3/pipleine_riscv/pl_riscv_cpu/code/components/pl_reg_em.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 3/pipleine_riscv/pl_riscv_cpu/code/components {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 3/pipleine_riscv/pl_riscv_cpu/code/components/pl_reg_mw.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 3/pipleine_riscv/pl_riscv_cpu/code {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 3/pipleine_riscv/pl_riscv_cpu/code/instr_mem.v}

vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra\ task\ 3/pipleine_riscv/pl_riscv_cpu/.test {C:/Users/nawaz/OneDrive/Desktop/programing/verilog/eyantra task 3/pipleine_riscv/pl_riscv_cpu/.test/tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb

add wave *
view structure
view signals
run 5000 ns