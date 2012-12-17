#!/bin/bash
cd /home/busstuc/busstuc
echo "compile(busstuc),create_regcut($1),halt." | sicstus

#compile busstuc
echo "compile(busstuc),save_program(busestuc4),halt." | sicstus
