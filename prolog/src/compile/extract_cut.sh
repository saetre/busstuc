#!/bin/bash
cd /home/busstuc/busstuc

#echo "compile(busstuc),create_regcut($1),halt." | sicstus
echo "compile_route_set($1), use_module( 'utility/extracut.pl', [ create_regcut/1 ] ), create_regcut($1), halt." | busstuc

#compile busstuc
echo "compile(busstuc),save_program(busestuc4),halt." | sicstus
