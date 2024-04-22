import sys, os


if __name__ == "__main__":

  command = "rm src/tiny_cpu.smt2 src/tiny_cpu.rkt"
  print("[command to run]: ", command)
  os.system(command)

  command = "yosys -s scripts/command.ys"
  print("[command to run]: ", command)
  os.system(command)

  command  = "echo '#lang yosys' > src/tiny_cpu.rkt && cat src/tiny_cpu.smt2 >> src/tiny_cpu.rkt"
  print("[command to run]: ", command)
  os.system(command)

  # command = "rm src/tiny_cpu.smt2"
  # print("[command to run]: ", command)
  # os.system(command)

