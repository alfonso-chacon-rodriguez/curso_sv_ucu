worklib :
	vlib ./target/sim_static/work

compile :
	vlog -sv  -work ./target/sim_static/work -l ./target/log/compile.log \
	./src/test/fifo_tb.sv

optimize :
	vopt +acc -work ./target/sim_static/work fifo_tb -o fifo_tb_opt

sim :
	vsim -c -do sim.do -work ./target/sim_static/work fifo_tb \
	-wlf ./target/sim_static/fifo_tb.wlf -logfile ./target/log/simulation.log

gui :
	vsim -view ./target/sim_static/fifo_tb_opt.wlf

all : setup_sim worklib compile optimize sim
	

clean :
	rm -rf ./target

setup_sim :
	mkdir -p target/log
	mkdir -p target/sim_static
