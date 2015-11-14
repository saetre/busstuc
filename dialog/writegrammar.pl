%% FILE writegrammar.pl
%% SYSTEM BUSTER
%% CREATED TA-070101
%% REVISED TA-081113

:- module( writegrammar, [ write_dialogue_grammar/0 ] ).

%%% RS-131228, UNIT: utility/
%:- ensure_loaded( user:'../declare' ).  %% META: user:for/2, foralltest/2, set_of/3, user:set_ops/3, test/1
%:- use_module( '../main.pl', [ language/1 ] ). %% RS-140209 [ (=>)/2, reset/0, traceprint/2 ] Why is => in translat.pl ?! RS-140927

:- use_module( '../utility/utility', [ set_of/3  ]).     %% RS-140102 
%:- use_module( '../utility/writeout', [ doubt/2, out/1, output/1, prettyprint/1 ] ).%% RS-140912

%%% RS-111205, UNIT: app/
%:-use_module( '../app/busanshp', [ bigcap/2 ] ).
:-use_module( '../utility/writeout', [ bigcap/2 ] ).

%%% RS-111205, UNIT: dialog/
:-use_module( '../dialog/grammar', [ gram/3 ] ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
