
default : all

all :
	iverilog -t vvp -o test_bench.vvp reg_file.v mux_2_1.v mux_2_1_5bit.v adder.v sign_ext.v program_counter.v ALU.v test_bench.v dmem.v imem.v alu_decoder.v main_decoder.v control_unit.v CPU.v
	vvp test_bench.vvp

clean :
	rm -f *.vcd *.vvp
