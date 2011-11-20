Copied from ~toreamb/tele/buster

#HOW TO COMPILE AND RUN (Norwegian mode)
[satre@furu ~/BUSSTUC/buster]$ ./create_busstuc
[satre@furu ~/BUSSTUC/buster]$ busestuc.sav
| ?- run.

N: \set trace 1
	% eller
traceprog  := 1..6   % trace of pragmatic rule application
traceans   := 1..6   % trace of bus answer rule  application


Oppdater(es/t)
 places -> db/places.pl
 bustrans -> app/bustrans.pl
 app/dmeq.pl
 teledat2.pl
 
 
 
 