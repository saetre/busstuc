%% FILE writegrammar.pl
%% SYSTEM BUSTER
%% CREATED TA-070101
%% REVISED TA-081113

write_dialogue_grammar :-
	set_of(A:B,(gram(A,B,_),dontstartwith(A,'tb_')),L),
	write_dialogue_grammar(L),nl.

dontstartwith(A,B):-
	atom_chars(A,AL),
	atom_chars(B,BL),
	\+startwith(AL,BL).

startwith(_,[]):-!.
startwith([AF|AR],[AF|BR]):-
	startwith(AR,BR).

write_dialogue_grammar([]).
write_dialogue_grammar([Sub:List|Rest]):-
	write_dialogue_grammar2(Sub, List),
	nl,
	write_dialogue_grammar(Rest).


write_dialogue_grammar2(Start, GList) :-
	!,
	bigcap(Start,BC),
	write(BC),
	spaceright(BC,15),
	write('-->  '),
	writesublist(GList).



spaceright(A,No) :-!,
	atom_chars(A,B),
	spaceelements(B,No).

spaceelements(_,0):-!.
spaceelements([_A|B],No):-!,
	NNo is No - 1,
	spaceelements(B,NNo).
spaceelements([],No):-!,
	write(' '),
	NNo is No - 1,
	spaceelements([],NNo).

writesublist([]):-!,
	nl.
writesublist([First|Rest]):-
	writesublist1(First),
	(	\+Rest=[]->
		nl,
		spaceelements([],16),
		write('|   ');true
	),
	writesublist(Rest).

writesublist1([]):-
	write('[nil]').
writesublist1([sub(A)|B]):-!,
	bigcap(A,BC),
	write(BC),
	writesublist2(B).
writesublist1([item(A)|B]):-!,
	write(A),
	writesublist2(B).

writesublist2([]):-!.
writesublist2([sub(A)|B]):-!,
	write(', '),
	bigcap(A,BC),
	write(BC),
	writesublist2(B).
writesublist2([item(A)|B]):-!,
	write(', '),
	write(A),
	writesublist2(B).



/* Result:

Askfor         -->  sqt, UserQs, SqtRepl

Askfors        -->  Askfor, Askfors
                |   [nil]

Askref         -->  sqd, SqdRepl

Askrefs        -->  Askref, Askrefs
                |   [nil]

Dialog         -->  UserQs, dialogerror, Dialog

Modify         -->  uim, UiqRepl
                |   [nil]

RelRepl        -->  UiqRepl

Reset_dialog   -->  nil

SqdRepl        -->  uadi
                |   uadm
                |   uadn
                |   uadq

SqtRepl        -->  uati
                |   uatc
                |   uatm
                |   uatn
                |   uatg
                |   uatf

UiqRepl        -->  sant
                |   Askrefs, Askfors, UiqRepl2

UiqRepl2       -->  sat, Modify
                |   sal, Modify
                |   relax, RelRepl, Modify
                |   saf

UserQ          -->  uin, UiqRepl
                |   uiq, UiqRepl

UserQs         -->  UserQ, UserQs
                |   [nil]

*/
