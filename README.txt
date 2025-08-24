A live demo of this system is currently running here: http://busstuc2.idi.ntnu.no/

HOW TO CHANGE THE CURRENT WORKING DIRECTORY, aka cd, pwd, change folder, etc.
=============================================================================

| ?- use_module(library(file_systems)), current_directory(OldDir,'..').

REMAINING BUGS
===============
regtopp-automaten:
Følgende mangler for at svn skal fungere etter en autoopplasting av nye ruter:

satre@vm-6114:/lhome/busstuc/busstuc/db/tables/r1612_130617$ cd /lhome/busstuc/busstuc/db/tables/r1612_130617/
satre@vm-6114:/lhome/busstuc/busstuc/db/tables/r1612_130617$ sudo chgrp busstuc *
satre@vm-6114:/lhome/busstuc/busstuc/db/tables/r1612_130617$ sudo chgrp busstuc .
satre@vm-6114:/lhome/busstuc/busstuc/db/tables/r1612_130617$ sudo chmod g+w *
satre@vm-6114:/lhome/busstuc/busstuc/db/tables/r1612_130617$ sudo chmod g+w .

---------------------
Don't remove to many / . , from the query!
lade søndag 30/6
lade søndag 30.6

=============================================================================================


Copied from ~toreamb/tele/buster

See Wiki entries on
https://www.ntnu.no/wiki/display/FUIROS/

#HOW TO COMPILE AND RUN (Norwegian mode)

[satre@furu ~/BUSSTUC/buster]$ ./create_busstuc
[satre@furu ~/BUSSTUC/buster]$ busestuc.sav
| ?- run.

N: \set trace 1
	% eller
traceprog  := 1..6   % trace of pragmatic rule application
traceans   := 1..6   % trace of bus answer rule  application

N: Hva er din versjon?

#OLD ! RESTART SERVER AFTER NEW FILE IS COMPILED ABOVE ! OLD#
cd ~tagore/public_html/cgi-bin/busstuc
[tagore@furu ~/public_html/cgi-bin/busstuc] ./stopbuss
[tagore@furu ~/public_html/cgi-bin/busstuc] ./startbuss
...REPLACED BY: See Wiki entries on
https://www.ntnu.no/wiki/display/FUIROS/


Oppdater(es/t)
 places -> db/places.pl
 bustrans -> app/bustrans.pl
 app/dmeq.pl
 teledat2.pl
 
 
 
 About SVN and Eclipse:
======================
Subversive w/JavaHL or SVNKit (latest version) REALLY SUCKS, and kills my computer.

Subversion w/Subclipse seems to working almost ok...

Cheers,
Rune


 
