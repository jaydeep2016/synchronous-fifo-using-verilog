vlib work
vlog fifo.v
vlog fifotest.v
vsim -voptargs="+acc" work.tb
add wave -r *
run -all

