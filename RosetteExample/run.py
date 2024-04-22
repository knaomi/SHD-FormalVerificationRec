import sys, os


if __name__ == "__main__":

  command = "racket example.rkt"
  print("[command to run]: ", command)
  os.system(command)

