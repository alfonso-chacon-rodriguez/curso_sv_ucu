worklib:
    vlib work

compile: test.sv
    vlog test.sv -dpiheader dpi_types.h

foreign: foreign.c
    gcc -I$(QUESTA_HOME)/include -shared -g -o foreign.so foreign.c

optimize:
vopt +acc test -o opt_test

sim:
    vsim opt_test test -sv_lib foreign

all:
    worklib compile foreign optimize sim

clean :
		rm -rf ./target

setup_sim_static :
		mkdir -p target/log
		mkdir -p target/sim_static