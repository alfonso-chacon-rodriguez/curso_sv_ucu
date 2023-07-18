worklib :
	vlib ./target/sim_static/work

compile :
	vlog -sv  -work ./target/sim_static/work -l ./target/log/compile.log \
	./src/test_FIFO.sv

compile_rf :
	vlog -sv  -work ./target/sim_static/work -l ./target/log/compile.log \
	./src/test_RF.sv

optimize :
	vopt +acc -work ./target/sim_static/work test_FIFO -o test_FIFO_opt

optimize_rf :
	vopt +acc -work ./target/sim_static/work test_RF -o test_RF_opt

sim :
	vsim -c -do sim.do -work ./target/sim_static/work test_FIFO_opt \
	-wlf ./target/sim_static/test_FIFO_opt.wlf -logfile ./target/log/simulation.log

sim_rf :
	vsim -c -do sim.do -work ./target/sim_static/work test_RF_opt \
	-wlf ./target/sim_static/test_RF_opt.wlf -logfile ./target/log/simulation.log

all : setup_sim worklib compile optimize sim

all_rf: compile_rf optimize_rf sim_rf

gui :
	vsim -view ./target/sim_static/test_FIFO_opt.wlf

gui_rf:
	vsim -view ./target/sim_static/test_RF_opt.wlf	

clean :
	rm -rf ./target

setup_sim :
	mkdir -p target/log
	mkdir -p target/sim_static
	. ./setup.sh
