/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE   update2.pl
%% SYSTEM BUSTER
%% CREATED ØF-000101
%% REVISED TLF-030402 TA-060705

%%% Predicates for updating and using the context frames


%%  updateframe(teleprocess([],_,[],_),_,_) :- !, fail. %% TLF 030611 - bad solution, but stops some stupid behaviour
%%  Revoked %% TA-051030  e.g. %% N: Kan du gjenta ?

%% UNIT: /app/
:-use_module( '../app/busanshp', [ paraphrase_tele/2, paraphrase/1, paraphrase3/3 ] ). %% extra: paraph2/1, paraphrase_changes1/1, 

updateframe(teleprocess(Fields,Table,[],X), OldFrame, NewFrame) :-   %% TLF 030204
	!,
    trackprog(3, (output('Updateframe: Before '), writeprog(OldFrame))),
	(	%% make sure frame is initilalized
		var(OldFrame)->
		frametemplate(telebuster,EmptyFrame), %% Unnec ?
		OldFrame=EmptyFrame
		;
		true
	),

    frametolist(OldFrame,  FrameList),
    pragma_aux(makeframe, teleprocess(Fields,Table,[],X), FrameList, Changes),

    exec_changes(Changes, OldFrame, TmpFrame),

    paraphrase_tele(_Program,Changes), %% TA-060831

    (frame_getvalue_rec(TmpFrame, itemsfound::itemcount,_,_) -> NewFrame=TmpFrame;
    	frame_setvalue_rec(TmpFrame,itemsfound::itemcount, 10000, NewFrame)
    ),
    trackprog(3, (output('Updateframe: After '),writeprog(NewFrame))).




updateframe(teleprocess(Fields,Table,WhereList,X), OldFrame, NewFrame) :-   %% TLF 030204
	!,
    trackprog(3, (output('Updateframe: Before '), writeprog(OldFrame))),
	
	( %% make sure frame is initialized
		var(OldFrame)->
		frametemplate(telebuster,EmptyFrame), %% Unnec ?
		OldFrame=EmptyFrame
		;
		true
	),

    frametolist(OldFrame,  FrameList),
    pragma_aux(makeframe, teleprocess(Fields,Table,WhereList,X), FrameList, Changes),

    exec_changes(Changes, OldFrame, TmpFrame),

    paraphrase_tele(_Program,Changes),  %% TA-060831


    saturate(TmpFrame, teleprocess(Fields,Table,WhereList,X), teleprocess(_,NTable,WhereListTmp,_)),

    fixnameproblem(TmpFrame,WhereListTmp, WhereList, NWhereList, TmpFrame1),

	teleprocessdirect([], NTable, NWhereList, Data),

	updateframe_data(TmpFrame1, Data, TmpFrame2),
	remove_knowflags(TmpFrame2, NewFrame),

    trackprog(3, (output('Updateframe: After '),writeprog(NewFrame))).

%%%% ======= EXPERIMENT


updateframe( BINGO , OldFrame, NewFrame) :-   %% TA-060212

     BINGO= (TeleP, RestP),

    TeleP= teleprocess(_Fields,_Table,_WhereList,_X),
    !,
 
    trackprog(3, (output(' Updateframe Double Program '),write(BINGO))),
   

    updateframe( TeleP, OldFrame, MiddleFrame),

    updateframe( RestP, MiddleFrame, NewFrame) .



updateframe(Program, OldFrame, NewFrame) :-
    trackprog(3, (output('Updateframe: Before '),writeprog(OldFrame))),   %% TA-021201

    frametolist(OldFrame, FrameList),
    pragma_aux(makeframe, Program, FrameList, Changes),

    exec_changes(Changes, OldFrame, NewFrame),

   !, %% TA-030110

   (value(directflag,true) ->
        trackprog(2,output('*** ANSWER ***')); true),  %% TA-060825

   paraphrase2(Program,Changes), %% TA-051109 (Both Important messages and Para)
   trackprog(3, (output('Updateframe: After '),writeprog(NewFrame))).   %% TA-021201




updateframe_checkanswer(Program, Slot, OldFrame, NewFrame) :- %% moved up %% TA-030219

   trackprog(3, (output('Updateframe_checkanswer: Before '),writeprog(OldFrame))),  %% TA-021201

    pragma(makeframe, Program, Changes),

   trackprog(4, (output('Slot:'),write(Slot),nl, output('Changes: '),write(Changes))), %% TA-030219

    roundmember(frame_setvalue(SubSlot, _), Changes),

    is_subframe(SubSlot, Slot),

   (value(directflag,true) -> %% TA-060607
        output('*** ANSWER ***'); true),



   paraphrase2(Program,Changes), %% TA-060116

    exec_changes(Changes, OldFrame, NewFrame),

   !, %% TA-030219
   trackprog(3, (output('Updateframe: After '),writeprog(NewFrame))).   %% TA-030219





fixnameproblem(F, WL, W, WL, F) :-
	\+ member(pname=_,W),
	\+ member(firstname=_,W),
	\+ member(lastname=_,W).

fixnameproblem(OldFrame, OldWhereList, WhereList, NewWhereList, NewFrame) :-
	member(pname=_,WhereList),
	frame_setvalue_rec(OldFrame, attributes::givenname, ?, TmpFrame),
	removefromlist(OldWhereList, firstname=_, TmpWhereList),
	frame_setvalue_rec(TmpFrame, attributes::sn, ?, NewFrame),
	removefromlist(TmpWhereList, lastname=_, NewWhereList).

fixnameproblem(OldFrame, OldWhereList, WhereList, NewWhereList, NewFrame) :-
	( member(firstname=_,WhereList);
	  member(lastname=_,WhereList) ),

	frame_setvalue_rec(OldFrame, attributes::cn, ?, NewFrame),
	removefromlist(OldWhereList, pname=_,NewWhereList).


updateitems(OldFrame, NewFrame) :-
	saturate(OldFrame, teleprocess([],_,[],_), teleprocess(_,_,WhereList,_)),

	teleprocessdirect([], katnavn, WhereList, Data),
	updateframe_data(OldFrame, Data, NewFrame).

updateframe_data(OldFrame, Data, NewFrame) :-
	parseresultdata(Data, Results),!,
	frame_setvalue_rec(OldFrame,itemsfound::items, Results, TmpFrame1),
    recordcount(Results, Count),
    frame_setvalue_rec(TmpFrame1,itemsfound::itemcount, Count, NewFrame).


updateframe_data(OldFrame, Data, NewFrame) :-
	parseresultdatacount(Data,Count),!,
	frame_setvalue_rec(OldFrame,itemsfound::items, ?, TmpFrame),
	frame_setvalue_rec(TmpFrame,itemsfound::itemcount, Count, NewFrame).



exec_changes((framevalue(_, _), Rest), OldFrame, NewFrame) :-
    exec_changes(Rest, OldFrame, NewFrame).

exec_changes(framevalue(_, _), Frame, Frame).

exec_changes((frame_setvalue(Slot, Value), Rest), OldFrame, NewFrame) :-
    frame_setvalue_rec(OldFrame, Slot, Value, TempFrame),
    exec_changes(Rest, TempFrame, NewFrame).

exec_changes(frame_setvalue(Slot, Value), OldFrame, NewFrame) :-
    frame_setvalue_rec(OldFrame, Slot, Value, NewFrame).

exec_changes([], Frame, Frame).

saturate(Frame, Program, NewProgram) :-

   trackprog(3,output('Saturate query: Before ')),
   trackprog(4,writeprog(Program)), 

   frametolist(Frame, FrameList),
   pragma_aux(usestate, (frame(Frame), FrameList), Program, NewProgram),

   trackprog(3,output('Saturate query: After ')),
   trackprog(4,writeprog(NewProgram)). %% TA-061009



saturatemod(Frame, Program, NewProgram) :-

   trackprog(4,(output('Saturatemod: Before '),writeprog(Program))), %% TA-030219

    frametolist(Frame, FrameList),
    pragma_aux(usestate,(modify, FrameList), Program, NewProgram),

   trackprog(4,(output('Saturatemod: After '),writeprog(Program))).   %% TA-030219



remove_knowflags(OldFrame,NewFrame) :-
	set_of(A, (frame_getvalue_rec(OldFrame,A, KnowFlag, _),knowFlag(KnowFlag)),L),
	remove_fields(L,OldFrame, NewFrame).


remove_fields([],F,F).
remove_fields([A|B],OldFrame,NewFrame) :-
	frame_setvalue_rec(OldFrame,A,?,TmpFrame),
	remove_fields(B,TmpFrame,NewFrame).


knowFlag(doknow).
knowFlag(dontknow).

telerelax(OldFrame, NewFrame,teleprocess(_,_,Where,_)) :-
   saturate(OldFrame, teleprocess([],katnavn,[],_), teleprocess(_,_,WhereList,_)),
 
   set_of(A,(member(A,Where), \+ member(A,WhereList)),Removed), %% TA-061214

%%  set_of(A,(member(A,WhereList), \+ member(A,Where)),Removed),

	\+ Removed = [],!,
	removefromframe(OldFrame, Removed, TmpFrame),
	teleprocessdirect([], katnavn, WhereList, Data), %% TA-061214
	updateframe_data(TmpFrame, Data, NewFrame),
	frame_getvalue_rec(NewFrame, itemsfound::itemcount, C, _),!,
	C > 0.

removefromframe(F, [], F).
removefromframe(OF, [Field=_|R], NF) :-
	tuctoldap(Field,  F),
	frame_setvalue_rec(OF, attributes::F, ?, TF),
	removefromframe(TF, R, NF).



dorelax(OldProg, NewProg, Results) :-
    dorelax1n(OldProg, NewProg, [], Results). %% TA-060705

%
 
dorelax1n(OldProg, NewProg, OldResults, NewResults) :- %% TA-060705
    pragma_complete(relax, OldProg, MiddleProg, [], Results),
    !,
    Results \== [],
    dorelax0n(MiddleProg, NewProg, (Results, OldResults), NewResults).

dorelax0n(Prog, Prog, Results, Results) :- %% TA-060705
     copy_term(Prog, TmpProg),
     execute_program(TmpProg),  %% checkitem2.pl
     !.

dorelax0n(Prog, Prog, Results, Results) :- %% TA-060705
    dorelax1n(Prog, Prog, Results, Results).





%%% Predicates for updating the refer structure

getuserrefer(Cid, (Item isa Type, Rest)) :-
    addref(Cid, Item, Type),
    getuserrefer(Cid, Rest).

getuserrefer(Cid, (_, Rest)) :-
    getuserrefer(Cid, Rest).

getuserrefer(_, _).


frametolist([],[]):- !,  trackprog(2, output('Empty frametolist')).   %% TA-030108

frametolist(Frame, FrameList) :-
    set_of(framevalue(Name, Value), frame_getvalue_rec(Frame, Name, Value, _), TmpList),
    make_proglist(TmpList, FrameList).


framevalue(_, _). %% So we can execute these as well...

make_proglist([Head | Rest], (Head, ProgRest)) :-
    make_proglist(Rest, ProgRest).

make_proglist([], []).

istype(Item, Type) :-
        Item isa ItemType,
        issubclass(ItemType, Type).


issubclass(SubType, SuperType) :-  %% TA-060309 More efficient
    subclass0(SubType, SuperType).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
