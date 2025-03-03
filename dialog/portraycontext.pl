%% FILE portraycontext.pl %% TA-041007
%% SYSTEM BUSTER
%% CREATED TA-050701
%% REVISED TA-051115

%% All sorts of portraying the context information

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% UNIT: /dialog/
:-module( portraycontext, [ dumpcontext/0, dumpstack/1, dumptopframe/0, lcon/0, pcon/0, pcontext/0, printcontext/0, printdialogtreenode/1, printslot/2 ] ).

%%% RS-131225, UNIT: /
:- use_module( '../declare', [ value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .
:- use_module( '../sicstus4compatibility', [ out/1, output/1 ] ).  %% Compatible with sicstus4, get0/1 etc.

%:- use_module( '../main', [ value/2 ] ).
:- use_module( '../utility/ptbwrite', [ tab/1 ] ). %% RS-140914

%% RS-140101. UNIT: /utility
:- use_module( '../utility/utility', [ for/2 ] ). %% RS-140101 for/2 ?!
:- use_module( '../utility/writeout', [ indentprint/2 ] ). %% RS-140101 for/2 ?!

%% RS-140101. UNIT: Prolog Library
%:-use_module( library(aggregate), [ foral/2 ] ).   %% RS-141029  for-all Does NOT work like utility:for/2
:-use_module( library(lists), [ reverse/2 ] ).

%% RS-140101. UNIT: /dialog/
:- use_module( newcontext2, [ current_context/1, getcontext/2, getcurrent/1, saved_context/3 ] ). %% RS-140101

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lcon :- listing(saved_context).       %% ad hoc utility 


pcon :- saved_context( _Cid, _Cur, X),   %% ad hoc utility %% TA-041007
        portraycontext(X).

pcon0 :- saved_context(Cid,_Cur,X),  %% ad hoc utility %% TA-041215
         portraycontext0(Cid,X).          %% Readable context dump
 

printcontext :-               %% TA-060126
    value(contextflag,true),
    !,
    printcontext1
 ;
    true.


printcontext1 :- 
     current_context(Cid), %% saved_context(Cid,_Cur,_X),%% TA-060126 
     printcontext(Cid).


printcontext(Cid) :-
   saved_context(Cid,_Cur,X), 
   portraycontext0(Cid,X),
   !.
printcontext(_).



%% Readable Portray of context

portraycontext0(Cid, context(_TQL,_List1,_List2,Nodelist)):-
    nl,  %% TA-050810
    write('*** Context '),write(Cid),output(' ***'),nl,
 
    portraynodelist0(Nodelist),

    printdialogtree(Nodelist). %% TA-050809



portraycontext( context(TQL,List1,List2,Nodelist)):-
    output(TQL),nl,
    output(List1),
    output(List2),
    nl,
    portraynodelist(Nodelist).

portraynodelist0([Node|_Rest]):-
    portraynode0(Node).


portraynodelist([Node|Rest]):- %% Reverse the printout
    portraynodelist(Rest),     %% TA-0411202
    !,
    portraynode(Node),
    nl.


portraynodelist([]).  %% TA-0411202




portraynode0(node(GramHead,Curacit,focus(NewFrame,Flist2,Slot), _GramBody)) :-
    write('focus:  '),writedslot(Slot),
    write('frame:  '),nl,  %% TA-041216     
           outputslots(4,NewFrame),
    write('referents: '),      output(Flist2), %% TA-050810
    write('dialognodes: '),  out(GramHead),  outconst(Curacit), %%%% ,   output(GramBody),
    nl.


writedslot(slot(XY)):- !,output(XY).
writedslot(_):- output([]).

writedslot(X):-write('focus: '),output(X).



portraynode(node(GramHead,Curacit,focus(NewFrame,Flist2,Flist3), GramBody)) :-
    write('node('), output(GramHead),
    write('    focus('),output(NewFrame),
    nl,
    write('           '), output(Flist2), 
    write('           '), outputp(Flist3),
    output('         )'), 
    write('    '),outconst(Curacit),output(GramBody),
    output('    )'),     
    nl.

outconst(Curacit):-var(Curacit),!;out(Curacit).

outputp( [TQL,BUSLOG] ):-
    !,
    nl,
    write('           '),output(TQL),nl,
    write('           '),output(BUSLOG).


outputp(OOO):-  output(OOO),write(' ').

outputslots(_N,List):- %% TA-050914
    var(List),
    !,
    output('* [] *').

outputslots(N,List):-
%    for(member(X,List),printslot(N,X)).
    for( member(X,List), printslot(N,X) ). %% RS-140914


printslot(N,X):-
    X = [Slotname,[U|V],_,_], % if slotvalue a list, indent
    !,
    indentprint(N,Slotname),
    N1 is N+4,
    for(member(K,[U|V]),printslot(N1,K)).

printslot(N,X):-
    X = [Slotname,Q,_,_], % if slotvalue a list, indent
    !,
    tab(N),out(Slotname),output(Q).


printslot(N,X):-
    tab(N),
    output(X).


%% TA-041215

pcontext :-
    value(contextflag,true),
    !,
    pcon0,
    !
 ;
    true.

	
printdialogtree(L):-
    value(traceprog,N),N > 1, %% TA-051005
    !,
    nl,
    output('*** Dialog tree *** '),nl,
    reverse(L,L1),
    for(member(X,L1), printdialogtreenode(X) ).

printdialogtree(_):- nl.



printdialogtreenode( node(Type,_,_,Acts+PrevActs)):- 
    reverse(PrevActs,RP),
    output((Type --> RP+Acts)).

   

%%%%%%%%%%%  THE END %%%%%%%%%%%%%%%%%%%%%%


%% Moved from dialog/newcontext2
%% 
	
dumptopframe :-
	getcurrent(Cid), 
	getcontext(Cid, context(_, _, _, [node(_,   _  ,focus(Frame, _, _), _) | _])),
	dumpframe(Frame).

dumpcontext :-
	getcurrent(Cid), 
	dumpcontext(Cid).

dumpcontext(Cid) :-
	getcontext(Cid, context(Tql, Prog, TempRefer, NodeStack)),
	write('Tql: '),
	write(Tql), nl,
	write('Prog: '),
	write(Prog), nl,
	write('TempRefer: '),
	dumprefer(TempRefer), nl,
	write('NodeStack: '), nl,
	dumpnodestack(NodeStack).

dumpnodestack( [node(Name,  _  , focus(Frame, Refer, Query), Rem) | Rest] ) :-
	write(' Node: '), write(Name), nl,
	write('  Frame: '), nl,
	dumpframe(Frame, 2),
	write('  Refer: '), nl,
	dumprefer(Refer, 2), 
	write('  Query: '), write(Query), nl,
	write('  Remainder: '), write(Rem), nl, nl,
	dumpnodestack(Rest).

dumpnodestack( [] ).

dumpframe(Frame) :-
	dumpframe(Frame, 0).

dumpframe(?, Depth) :-
	write_indent(Depth), write('empty'), nl.

dumpframe([[Name, SubFrame, subframe(_), EP] | Rest], Depth) :-
	write_indent(Depth), write(Name), write(' - ep='), write(EP), write(':'), nl,
	NewDepth is Depth + 1,
	dumpframe(SubFrame, NewDepth),
	dumpframe(Rest, Depth).

dumpframe([[Name, Value, class(_), Count] | Rest], Depth) :-
	write_indent(Depth), write(Name), write(' = '), write(Value), write('   ('), write(Count), write(')'), nl,
	dumpframe(Rest, Depth).

dumpframe([], _).
	

dumprefer( List ) :-
	dumprefer(List, 0).

dumprefer( [] ).
dumprefer( [], _ ). %% RS-141105 Was missing " , 0 "

dumprefer( [ Head | Rest ], Depth ) :-
	write_indent( Depth ),
	write( Head ), nl, 
	dumprefer( Rest, Depth ).

write_indent( Depth ) :-
	Depth > 0,
	write(' '),
	NewDepth is Depth - 1,
	write_indent( NewDepth ).

write_indent(_).


dumpstack([node(Name,  _  , _, Rem) | Rest]) :-
	write(Name), write(': '), write(Rem), nl,
	dumpstack(Rest).
	
dumpstack([]).



