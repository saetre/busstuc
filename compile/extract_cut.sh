#!/bin/bash
cd /home/busstuc/busstuc

echo "/home/busstuc/busstuc/compile/extract_cut.sh ... Make Regcut.pl" >&2
echo " create_regcut($1), halt." | /home/busstuc/busstuc/busestuc4.sav
#OLD:
#echo "compile(busstuc),create_regcut($1),halt." | sicstus
#echo " use_module( 'compileroute.pl', [ compile_route_set/1 ] ), compile_route_set($1), #Doesn't work... Asks for the regcut being created: $1 
#echo "  use_module( 'utility/extracut.pl', [ create_regcut/1 ] ), create_regcut($1), halt." | /home/busstuc/busstuc/busestuc4.sav

#re-compile busstuc
echo "compile(busstuc), save_program(busestuc4), halt." | sicstus
