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


 Character Encoding in Eclipse and Windows
-------------------------------------------
To use utf8 encoding on Windows, with SPIDER, the "environment varible" (Computer->Properties->Advanced->e.v.)
 must be set to "euc" before starting Eclipse




 About SVN and Eclipse:
======================
Subversive w/JavaHL or SVNKit (latest version) REALLY SUCKS, and kills my computer.

Subversion w/Subclipse seems to working almost ok...

Cheers,
Rune


 