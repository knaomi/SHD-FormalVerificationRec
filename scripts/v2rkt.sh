#!/bin/bash

# STEP1: Clean up old files
rm generated_src/tiny_cpu.smt2 generated_src/tiny_cpu.rkt


# STEP2: Generate SMT2 file from verilog
yosys -s scripts/yosys_command.ys
# rm generated_src/tiny_cpu.v


# STEP3: Generate Rosette file from SMT2
echo "#lang yosys" > generated_src/tiny_cpu.rkt
cat generated_src/tiny_cpu.smt2 >> generated_src/tiny_cpu.rkt
# rm generated_src/tiny_cpu.smt2

