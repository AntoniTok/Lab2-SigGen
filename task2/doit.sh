#!/bin/sh

~/Documents/iac/lab0-devtools/tools/attach_usb.sh

#cleanup
rm -rf obj_dir
rm -f sinegen.vcd


# Run Verilator to translate Verilog into C++, including C++ testbench
verilator -Wall --cc --trace sinegen.sv rom.sv counter.sv --exe sinegen_tb.cpp

# Build C++ project via make automatically generated by Verilator
make -j -C obj_dir/ -f Vsinegen.mk Vsinegen

# Run executable simulation file
obj_dir/Vsinegen