worklib :
	vlib ./target/sim_static/work

compile :
	vlog -sv  -work ./target/sim_static/work -l ./target/log/compile.log ./src/counter_ud.sv ./src/counter_ud_tb.sv

optimize :
	vopt +acc -work ./target/sim_static/work counter_ud_tb -o counter_ud_tb_opt

sim :
	vsim -c -do sim.do -work ./target/sim_static/work counter_ud_tb_opt \
	-wlf ./target/sim_static/counter_ud_tb_opt.wlf -logfile ./target/log/simulation.log

gui :
	vsim -view ./target/sim_static/tb_opt.wlf

all : setup_sim worklib compile optimize sim
	

clean :
	rm -rf ./target

setup_sim :
	mkdir -p target/log
	mkdir -p target/sim_static
