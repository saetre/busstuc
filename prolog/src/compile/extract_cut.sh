#!/bin/bash
cd /home/busstuc/busstuc
echo "Make Regcut.pl"
#echo "compile(busstuc),create_regcut($1),halt." | sicstus
echo " use_module( 'compileroute.pl', [ compile_route_set/1 ] ), compile_route_set($1),
       use_module( 'utility/extracut.pl', [ create_regcut/1 ] ), create_regcut($1), halt." | /home/busstuc/busstuc/busestuc4.sav

#compile busstuc
echo "compile(busstuc),save_program(busestuc4),halt." | sicstus
