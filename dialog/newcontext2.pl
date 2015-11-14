/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE newcontext2.pl
%% SYSTEM BUSTER
%% CREATED ØF-000101
%% REVISED TA-080110    %% RS-140101

%% FOR busanshp.pl AND checkitem2.pl 

%% RS-140101. UNIT: /dialog/
:-module( newcontext2, [ addref/3, clearold/0, commitref/1, commitref/3, current_context/1, current_frame_getvalue/2, dialog_resolve/2, getcontext/2,
        getcurrent/1, getframe/2, getquery/2, newcontext/1, reset_context/0, saved_context/3, setcontext/2, setcurrent/1, setframe/2, setquery/2,
        topic_subclass/3, rc/0 ] ). %% RS-140901

%% Move to frames2 ?!? RS-140914
:- volatile
           current_context/1,
           saved_context/3.
:- dynamic 
           current_context/1,
           saved_context/3.

%% UNIT: EXTERNAL
:- use_module( library(system), [ datime/1 ] ).
%:- use_module( library(lists) ). %% delete/3 is also loaded from utility/library.pl !!

%% UNIT: / and /utility/
:- use_module( '../declare', [ value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .
%:- use_module( '../main', [ value/2 ] ). %% RS-141015        Set variable-values,  in the user:module !

:- use_module( '../utility/utility', [ set_difference/3, set_of/3 ] ).       %% RS-131223 includes declare.pl
:- use_module( '../utility/library', [ delete/3 ] ).%% RS-131225 , reverse/2 for busanshp?

%% RS-140101. UNIT: /app/
:- use_module( '../app/pragma', [ roundmember/2 ] ).

%% RS-140101. UNIT: /dialog/
%MISERY LOOP?
:- use_module( frames2, [ frame_getvalue_rec/4, frametemplate/2 ] ).  %% RS-131117   frames2->newcontext2.pl is loaded from frames2 !!
%% UNIT /dialog/
:- use_module( checkitem2, [ current_frame/1 ] ).

 

%UNIT: /tuc/
%:- use_module( '../tuc/fernando', [ subclass0/2 ] ).
:- use_module( '../tuc/semantic', [ subclass0/2 ] ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prologs setof is baroque %% 
%:- meta_predicate set_of(+,0,-) .
%
%set_of(X,Y,Z):-           %%
%    setof(X,Y^Y,Z),!;     %% Trick to avoid alternatives
%    Z=[].                 %% What is wrong with empty sets ?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% current is the id of the current context
setcurrent(Cid) :-
	saved_context(Cid, _, _), !, 
	retractall(current_context(_)),
	assert(current_context(Cid)).

setcurrent(Cid) :-
	newcontext(Cid),
	setcurrent(Cid).

getcurrent(Cid) :-
	current_context(Cid).



reset_context:- %% TA-021029
	getcurrent(Cid),
	newcontext(Cid).


setcontext(Cid, X) :-	
	clearcontext(Cid),
	datime(CurDate),
	assert(saved_context(Cid, CurDate, X)).
	
clearcontext(Cid) :-
	retractall(saved_context(Cid, _, _)).

getcontext(Cid, X) :-
  	saved_context(Cid, _, X).


newcontext(Cid):-		%% TLF 030402 %% unnec
	value(teleflag, true), !,
	frametemplate(telebuster, NewFrame), %% TA-051018      % frames2.pl
	setcontext(Cid,
                   context([], [], [],
                           [node(dialog, _ ,
		                focus(NewFrame, [], []),
			        [sub(userQs), item(dialogerror), sub(dialog)]
		                )
                           ]
                          )
                  ).

newcontext(Cid) :-
	frametemplate(telebuster, NewFrame),  %% TA-051018     % frames2.pl
	setcontext(Cid, 
                   context([], [], [], 
                           [node(dialog,  _  , 
		                focus(NewFrame, [], []), 
			        [sub(userQs), item(dialogerror), sub(dialog)]
		                )
                           ] 
                          )
                  ).


clearold :-
	saved_context(Cid, datime(_, _, _, OldHour, _, _), _),
	datime(datime(_, _, _, NewHour, _, _)),
	Diff is NewHour - OldHour,
	(Diff > 1 ; Diff < -1),
	clearcontext(Cid),
	false.

clearold.


%%% Accessing the domain context frame


%% Used by bustrans %% TA-080110
current_frame_getvalue(Slot,Value) :- %% Shorthand
    current_frame(Frame),
    frame_getvalue_rec(Frame, Slot, Value, _).
        


getframe(Cid, Frame) :-	
	getcontext(Cid, context(_Tql, _Prog, _TempRefer, 
                        [node(_Name,  _  , focus(Frame, _Refer, _Query), _Rem) | _Rest])),
	getcontext(Cid, context(_, _, _, [node(_,  _  , focus(Frame, _, _), _) | _])).

setframe(Cid, Frame) :-
	getcontext(Cid, context(Tql, Prog, TempRefer, 
                        [node(Name,  _  , focus(_Frame, Refer, Query), Rem) | Rest])),
	setcontext(Cid, context(Tql, Prog, TempRefer, 
                        [node(Name,  _  , focus(Frame, Refer, Query), Rem) | Rest])).

%% Accessing the last user query answered
getquery(Cid, QueryCopy) :-	
	getcontext(Cid, context(_Tql, _Prog, _TempRefer, 
                        [node(_Name,  _  , focus(_Frame, _Refer, Query), _Rem) | _Rest])),
	copy_term(Query, QueryCopy).

setquery(Cid, Query) :-
	copy_term(Query, QueryCopy),
	getcontext(Cid, context(Tql, Prog, TempRefer, 
                        [node(Name,  _  , focus(Frame, Refer, _Query), Rem) | Rest])),
	setcontext(Cid, context(Tql, Prog, TempRefer, 
                        [node(Name,  _  , focus(Frame, Refer, QueryCopy), Rem) | Rest])).

%% Accessing the list of last referenced objects

%% addref adds an item  to the global temporary list of objects
%% mentioned in the discource. No old items are overwritten. 
%% commitref copies this list to the *active* list of objects 
%% mentioned. In this process, old items of the same type is 
%% overwritten. The active list is checked when external anaphors
%% are resolved. This rather complicated procedure ensure that in
%% dialogs like this: 
%%
%%  S: The bus passes NTH and Lade.
%%  U: Where is that?
%%
%% .."that" is resolved to both NTH and Lade, and a clarification
%% question is needed.  Whereas in: 
%%
%%  S: The bus passes NTH.
%%  S: The bus passes Lade.
%%  U: Where is that?
%%
%% .."that" is only resolved to Lade
%%
addref(_, free(_), _) :-
	!, false.
addref(_, whichref(_), _) :-
	!, false.

addref(Cid, X, Type) :-
	getcontext(Cid, context(Tql, Prog, TempRefer, NodeStack )),
	member([Type, List], TempRefer),

 (
	member(X, List) -> (TempRefer2 = TempRefer) %% TA-050103
 ;
	delete(TempRefer, [Type, List], TempRefer1),
	TempRefer2 = [[Type, [X | List]] | TempRefer1]
 ),

	setcontext(Cid, context(Tql, Prog, TempRefer2, NodeStack )).
	
addref(Cid, X, Type) :-
	getcontext(Cid, context(Tql, Prog, TempRefer, NodeStack)),
	TempRefer2 = [[Type, [X]] | TempRefer],
	setcontext(Cid, context(Tql, Prog, TempRefer2, NodeStack)).

getref(Cid, X, Type) :-
	getcontext(Cid, context(_Tql, _Prog, _TempRefer, 
                        [node(_Name,  _  , focus(_Frame, Refer, _Query), _Rem) | _Rest])),

   gettopic(Topic), %% bus/tele/nil

   preselect_features(Topic,Type,Refer,Prefer),

	member(SubType,Prefer),
   member([SubType, X], Refer).    


%% This is a pre-semantic anaphor resoution
%% Topic is not yet in the frame

gettopic(Topic) :- 
    value(topic,Hopic) -> 
         Topic=Hopic
       ; Topic = nil.

	

                                              
preselect_features(Topic,Type,Refer,Prefer) :-
    set_of( SubType, (member([SubType, _X_],Refer),subclass0(SubType,Type)),    Z),

    prescreen(Topic,Type,Z,Prefer).

prescreen(bus,place,Z1,Z2):- 
    !,
    set_difference(Z1,[room,place],Z2).

prescreen(tele,place,Z1,Z2):- 
   !,
   set_difference(Z1,[address,place],Z2).

prescreen(_Topic,_Type,Z,Z). %% ad hoc



topic_subclass(bus,SubType,Type) :- 
    subclass0(SubType, Type),

    \+ (Type==place,SubType=room).  %% Ad Hoc   %% Magne Johnsen  reise dit -> address
                                    %%                gå dit    -> room

topic_subclass(_Topic,SubType, Type) :- 
    subclass0(SubType, Type). 


	
commitref(Cid) :-
	getcontext(Cid, context(Tql, Prog, TempRefer, 
                        [node(Name,  _  , focus(Frame, Refer, Query), Rem) | Rest])),
	commitref_rec(Refer, TempRefer, NewRefer),
	setcontext(Cid, context(Tql, Prog, [], 
                        [node(Name,  _  , focus(Frame, NewRefer, Query), Rem) | Rest])).

commitref(Cid, OldRefer, NewRefer) :-
	getcontext(Cid, context(Tql, Prog, TempRefer, Stack)),
	commitref_rec(OldRefer, TempRefer, NewRefer),
	setcontext(Cid, context(Tql, Prog, [], Stack)).

commitref_rec(Refer, [[Type, List] | Rest], NewRefer) :-
	member([Type, OldList], Refer), !, 
	delete(Refer, [Type, OldList], Refer1),
	commitref_rec([[Type, List] | Refer1], Rest, NewRefer).

commitref_rec(Refer, [[Type, List] | Rest], NewRefer) :-
	commitref_rec([[Type, List] | Refer], Rest, NewRefer).

commitref_rec(NewRefer, [], NewRefer).

dialog_resolve(X, Q) :-
	roundmember(Y isa Type, Q),
	X == Y,
	getcurrent(Cid),
	getref(Cid, [X], Type).

dialog_resolve(whichref(Type, List), whichref(Type, List) isa Type) :-
	getcurrent(Cid),
	getref(Cid, List, Type).



	
%%% Preliminary
rc :-
	retractall(saved_context(_, _, _)),
	retractall(current_context(_)),
	datime(CurDate),
	assert(saved_context(id, CurDate, [])),
	newcontext(id),
	assert(current_context(id)).

:- rc. %% RS-140914   When to do this? When you set up the first dialog context!

