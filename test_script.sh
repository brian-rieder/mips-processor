#!/bin/bash

MODULE=system
ASMDIR=asmFiles
TARGETS=$ASMDIR/*

if [[ $# -eq 0 ]]
then
  make clean

  # Source (No latency)
  echo "Source (No Latency)"
  testasm

  # Source (Latency)
  echo "Source (Latency)"
  sed -i.bak 's/LAT = 0/LAT = 7/' source/ram.sv
  testasm

  # Mapped (No Latency)
  echo "Mapped (No Latency)"
  sed -i.bak 's/LAT = 7/LAT = 0/' source/ram.sv
  testasm -s

  # Mapped (Latency)
  echo "Mapped (Latency)"
  sed -i.bak 's/LAT = 0/LAT = 7/' source/ram.sv
  testasm -s

  # Revert ram.sv back to zero latency
  sed -i.bak 's/LAT = 7/LAT = 0/' source/ram.sv


  # FPGA
  echo "FPGA(No Latency)"

  files="asmFiles/*"
  count=$(echo $files | wc -w)
  index=1

  for i in asmFiles/*
  do
    textOutput="procesing file $i ($index of $count)"
    echo -n $textOutput

    size=$(resize | grep COLUMN - | cut -f2 -d"'")
    outputSize=$(echo $textOutput | wc -c)
    ((padding=size-outputSize-7))
    ((index=index+1))

    asm $i > /dev/null
    sim -t > /dev/null
    synthesize -m -d system_fpga > /dev/null

    printf "%-$(echo $padding)s"
    diff memsim.hex memfpga.hex > /dev/null

    if [[ $? -ne 0 ]]
    then
      echo -e "[\e[31m\e[1mFAILED\e[21m\e[0m]"
    else
      echo -e "[\e[92m\e[1mPASSED\e[21m\e[0m]"
    fi
  done

  make clean

  # ram.sv back to higher latency
  sed -i.bak 's/LAT = 0/LAT = 7/' source/ram.sv

   echo "FPGA(Latency)"

  files="asmFiles/*"
  count=$(echo $files | wc -w)
  index=1

  for i in asmFiles/*
  do
    textOutput="procesing file $i ($index of $count)"
    echo -n $textOutput

    size=$(resize | grep COLUMN - | cut -f2 -d"'")
    outputSize=$(echo $textOutput | wc -c)
    ((padding=size-outputSize-7))
    ((index=index+1))

    asm $i > /dev/null
    sim -t > /dev/null
    synthesize -m -d system_fpga > /dev/null

    printf "%-$(echo $padding)s"
    diff memsim.hex memfpga.hex > /dev/null

    if [[ $? -ne 0 ]]
    then
      echo -e "[\e[31m\e[1mFAILED\e[21m\e[0m]"
    else
      echo -e "[\e[92m\e[1mPASSED\e[21m\e[0m]"
    fi
  done

  rm source/ram.sv.bak

  exit
fi

