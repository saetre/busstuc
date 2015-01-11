/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE   update2.pl
%% SYSTEM BUSTER
%% CREATED ØF-000101
%% REVISED TLF-030402 TA-060705

%%% Predicates for updating and using the context frames

%%  updateframe(teleprocess([],_,[],_),_,_) :- !, fail. %% TLF 030611 - bad solution, but stops some stupid behaviour
%%  Revoked %% TA-051030  e.g. %% N: Kan du gjenta ?

%% UNIT: /dialog/
:-module( update2, [ dorelax/3, fixnameproblem/5, framevalue/2, getuserrefer/2, issubclass/2, istype/2, knowFlag/1, remove_fields/3, remove_knowflags/2,
                     saturate/3, saturatemod/3, telerelax/3, updateframe/3, updateframe_checkanswer/4, updateitems/2 ] ).


%:- meta_predicate  execute_program( 0 ).  %% Stay inside interapp? %% RS-140619
%:- meta_predicate  trackprog(+,0).  %% Stay inside the calling module (for the second argument)!  %% RS-140922
%///
%trackprog( N, P ) :-
%    value( traceprog, M ), number(M), M >= N,
%    !,
%    ( nl, call(P) )    %% TA-110130
%        ;
%    true. %% Finally, succeed anyway

%///

%% UNIT: /
%:- ensure_loaded( '../declare' ). %% RS-111213 General (semantic) Operators, e.g.  :: , trackprog/2        %Helper
%% RS-150111  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y . %:- use_module( '../main', [ ] ). % trackprog/2, value/2 
:- use_module( '../declare', [ trackprog/2, value/2 ] ). 

%% RS-131225    UNIT: / and /utility/
:- use_module( '../utility/utility', [ set_of/3 ] ). %% LOOP?
:- use_module( '../utility/writeout', [ output/1, writeprog/1 ] ). %% Contains declare? trackprog/2, 

%% RS-140914    UNIT: /app/
:-use_module( '../app/busanshp', [ paraphrase2/2, paraphrase_tele/2 ] ). %% extra: paraph2/1, paraphrase/1, paraphrase3/3, paraphrase_changes1/1,
:-use_module( '../app/pragma', [ pragma/3, pragma_aux/3, pragma_complete/5, roundmember/2 ] ). % (old:4), %% RS-140102, ipragmaor0/0, set/2
:-use_module( '../app/interapp', [ execute_program/1 ] ). % 

%% RS-140914    UNIT: /db/
:-use_module( '../db/teledat2', [ teleprocessdirect/4 ] ).

%% RS-140914    UNIT: /dialog/
%:- use_module( checkitem2, [ execute_program/1 ] ). % , writeprog/1
:- use_module( frames2, [ frame_getvalue_rec/4, frame_setvalue_rec/4,   frametemplate/2, is_subframe/2 ] ).
:- use_module( newcontext2, [ addref/3 ] ). %% RS-140101
:- use_module( parseres, [ parseresultdata/2, parseresultdatacount/2, recordcount/2, removefromlist/3, tuctoldap/2 ] ).

% UNIT: /tuc/
:- use_module( '../tuc/facts', [ isa/2 ] ).
%:- use_module( '../tuc/fernando', [ ] ).
:- use_module( '../tuc/semantic', [ subclass0/2 ] ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

updateframe(teleprocess(Fields,Table,[],X), OldFrame, NewFrame) :-   %% TLF 030204
	!,
%%  trackprog(3, ( output('Updateframe: Before '), interapp:writeprog(OldFrame)) ),
    trackprog(3, ( output('Updateframe: Before '), writeprog(OldFrame) ) ),
	(	%% make sure frame is initilalized
		var(OldFrame)->
		frametemplate(telebuster,EmptyFrame), %% Unnec ?
		OldFrame=EmptyFrame
		;
		true
	),

    frametolist(OldFrame,  FrameList),
    pragma_aux( makeframe: teleprocess(Fields,Table,[],X), FrameList, Changes),

    exec_changes(Changes, OldFrame, TmpFrame),

    paraphrase_tele(_Program,Changes), %% TA-060831

    (frame_getvalue_rec(TmpFrame, itemsfound::itemcount,_,_) -> NewFrame=TmpFrame;
    	frame_setvalue_rec(TmpFrame,itemsfound::itemcount, 10000, NewFrame)
    ),
%    user:trackprog(3, (output('Updateframe: After '),interapp:writeprog(NewFrame))).
    trackprog(3, (output('Updateframe: After '), writeprog(NewFrame) )).




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
    pragma_aux( makeframe: teleprocess(Fields,Table,WhereList,X), FrameList, Changes),

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
    pragma_aux( makeframe: Program, FrameList, Changes),

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

    roundmember(frames2:frame_setvalue(SubSlot, _), Changes),

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
   pragma_aux( usestate: (frame(Frame), FrameList), Program, NewProgram),

   trackprog(3,output('Saturate query: After ')),
   trackprog(4,writeprog(NewProgram)). %% TA-061009



saturatemod(Frame, Program, NewProgram) :-

   trackprog(4,(output('Saturatemod: Before '),writeprog(Program))), %% TA-030219

    frametolist(Frame, FrameList),
    pragma_aux( usestate: (modify, FrameList), Program, NewProgram),

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

dorelax0n( Prog, Prog, Results, Results ) :- %% TA-060705
     copy_term( Prog, TmpProg ),
     execute_program( TmpProg ),  %% checkitem2.pl
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MOVED BACK FROM  interapp.pl. Localized in checkitem2, interapp and update2, to avoid meta_predicate ordering conflicts. %% RS-141026
%execute_program( Prog ) :-
%
%    trackprog(2, output('BEGIN  program')), 
%(   call( Prog ) ->
%           trackprog(2, output('END  program'));
%           trackprog(2, output('FAIL  program')),
%           fail ).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
