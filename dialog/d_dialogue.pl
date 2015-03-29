/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE   d_dialogue.pl
%% SYSTEM BUSTER
%% CREATED AM-980218
%% REVISED TA-060706

%% RS-140914,   UNIT: /dialog/
%% Dialogue manager.

%% RS-140910   Make a module here... It should keep track of it's own linecounter variables etc.  !!! See newcontext2 and frames2 !!!
:- module( d_dialogue, [ dialog/0, last_answer/2, linecounter/1, processinput/1, run/0, quit_dialog/0, reset_conns/0,
                       subst_tql/4, varmember/2 ] ). % dialog/0, evalline_multi/2, last_answer/2, linecounter/1, processinput/1, quit_dialog/0, reset_conns/0, run/0, subst_tql/4, varmember/2 ] ). %hi/0, dialogrun0/0,  

%% META-PREDICATES
:- meta_predicate  g_execute1( ?, ?, 0).

:- volatile
           confused/1,
           linecounter/1,
           last_answer/2.  %% last_answer is problematic ???

:- dynamic
           confused/1,
           linecounter/1,
           last_answer/2.  %% last_answer is problematic ???


:- assert( linecounter(1) ).
:- assert( confused(noone) ). %-)


%:- use_module( library(varnumbers), [ numbervars/1 ] ). %% RS-141026.

%% RS-140914  UNIT: /
:- use_module( '../declare', [ (:=)/2, trackprog/2, value/2 ] ). %% RS-111213 General (semantic) Operators, e.g.  :: , trackprog/2        %Helper
:- use_module( '../utility/meta_preds', [ writeanswer/1, xwriteanswer/2 ] ).  %% Compatible with sicstus4, get0/1 etc.

%% RS-140914  UNIT: /utility/
:- use_module( '../utility/utility', [ flatround/2, timeout/3 ] ).         %% RS-140102 AVOID LOOPS PLEASE!! %trackprog(X, Y) :- user:trackprog(X, Y) .
:- use_module( '../utility/writeout', [ bcpbc/1, period/0, startmark/0, waves/0 ] ).%% RS-141105   writeanswer/1,  , xwriteanswer/2,
:- use_module( '../main', [ exetuc/1, translate2/2 ] ). % dialog/0, 
:- use_module( '../getphonedir', [  reset_ldapcon/0  ]).%% RS-131227    For ...main.pl, extra: create_tags/1,  
:- use_module( '../interfaceroute', [  reset_period/0 ] ).

%%% RS-140914, UNIT: /app/
:- use_module( '../app/busanshp', [  ] ).
%:- use_module( '../app/buslog', [ timeout/3 ] ).
:- use_module( '../app/pragma', [ pragma/3 ] ).        %% RS-140102, ipragmaor0/0, set/2
:- use_module( '../app/interapp', [ konstantify/1, makeanswer/4, nocols/2 ] ). %% RS-141026 traceanswer/1, writeanswer/1 localized

%% RS-140914,   UNIT: /dialog/
%% Dialogue manager.
%:- use_module( checkitem2, [ writeanswer/1 ] ). %% MOVED TO DIALOG. Localized   trackprog/2, 
:- use_module( d_main, [  dialog2/0  ] ). %% [ quit_dialog/0, dialogrun0/0, etc. ] ).
:- use_module( exegram, [  g_execute/3  ] ).  %% RS-140914 Modularized %% Dialog Grammar execution 
:- use_module( newcontext2, [ clearold/0, getcontext/2, getcurrent/1, newcontext/1, reset_context/0, setcontext/2, setcurrent/1 ] ).
                %%, setframe/2, setquery/2, topic_subclass/3 ] ). %% RS-140101
:- use_module( frames2, [ xframe_setvalue/2 ] ).
%:- use_module( parseres, [ xwriteanswer/2 ] ).
:- use_module( portraycontext, [ printcontext/0 ] ).


dialog :-      %% RS-131228  
%dialogrun0 :-  
   ( dialog := 1 ), 
   reset_period,
   reset_context,
   dialog2.

run :-  dialog.         %% RS-131228   Moved to /bustermain2.pl  

%hi:-debug, run. 

%trackprog( N, P ) :-
%    value( traceprog, M ), number(M), M >= N,
%    !,
%    ( nl, call(P) )    %% TA-110130
%        ;
%    true. %% Finally, succeed anyway

processinput(Q) :-                     %%AM-980301
	
   ( dialog := 1 ),
	( error_phase := 0 ),
   ( nightbusflag := false ),   %% ad hoc, must be reset %% TA-060706
	translate2(Q,TQL),
	nl,

   value(contextid,Cid),
   setcurrent(Cid),

  ( value(topic,BT) -> 
      xframe_setvalue(topic,BT) % put topic into the context frame  %% TA-060426
      ;true),

  (value(language,Lan) -> 
      xframe_setvalue(language,Lan) % put language into the context frame  %% TA-060426
      ;true),


	linecounter(X),
	NewX is X + 1,
	retractall(linecounter(_)),
	assert(linecounter(NewX)),
	dialogline(TQL),

   printcontext, %% (conditionally) 

   told,   %% postponed if directflag, harmless if not 

	clearold,
	!.



% processinput(_).  %% To avoid server stop... %% Moved to the web-interface

dialogline(nil). %% e.g. time_out, just accept %%% TA-031111 <---

dialogline(error) :-
	evalline(error, error).

dialogline(stop) :-             %%AM-980311
    !,
    false.


dialogline( command(C) ) :-     %%AM-980311
	exetuc( command(C) ),!.


dialogline([TQL]) :- %% Single question
        copy_term(TQL,TQL1),
        interapp:nocols(TQL1,TQL2),
        flatround(TQL2,FQL),
        interapp:konstantify(FQL),       
	!,                        % look only at first try
	trackprog(3, ( write(FQL), nl) ), 
	timeout( 
		evalline(TQL1, FQL),
		15000,       %% 15 sec   timeout %%  TA-070419 (Slow server)
		Result),
	((Result = time_out) -> write('Timeout'), nl ; true).

% Handle commands

dialogline([TQL]) :- %% TA-970523
	(TQL=stop;TQL=end),
	!.

dialogline([TQL | Rest]) :- %% Multiple questions
        copy_term(TQL,TQL1),
        interapp:nocols(TQL1,TQL2),
        flatround(TQL2,FQL),
        interapp:konstantify(FQL),       
	!,                        % look only at first try
	trackprog(3,(write(FQL), nl)), 
	timeout( 
		evalline_multi(TQL1, FQL),
		25000,       %% 25 sec timeout %% TA-070419 (Slow server)
		Result),
	((Result = time_out) -> write('Timeout'), nl ; true),
	dialogline(Rest).


reset_dialog(Reason):- %%  // bye/error
   retractall(confused(_)),  
   retractall(last_answer(_,_)), 
   getcurrent(Cid),   
	newcontext(Cid),
   Fql=((do),quit(Reason)),
	pragma( trans, Fql, Program),
        
   makeanswer(true,Fql, Program ,AnswerOut), 
   waves, 

   xwriteanswer( Fql, AnswerOut ). %% -> dir_file?%% TA-070419 


reset_dialog:- 
   retractall(confused(_)), 
   retractall(last_answer(_,_)), 
   getcurrent(Cid),   
	newcontext(Cid),
   Fql=((do),quit(bye)),
	pragma(trans,Fql,Program),
        
   makeanswer(true,Fql, Program ,AnswerOut),
   waves, 

   xwriteanswer(Fql,AnswerOut). %% -> dir_file?%% TA-070419 


quit_dialog:- %% TA-030630
   retractall(confused(_)),      %% TA-041005
   retractall(last_answer(_,_)), %%
   getcurrent(Cid),   
	newcontext(Cid).



reset_conns :-				%% TLF-030523
	value(teleflag,true),
	reset_ldapcon.

reset_conns.		%% TLF-030523 Should never fail!!



evalline(doit:::quit(error),((do),quit(error))) :- %% TA-090617
	!,
   reset_dialog(error).



%% TA-051005
evalline(doit:::replyq(Reply),((do),replyq(Reply))) :-	%% TLF-030509 %% TA-090617
	!,
	write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),
	write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),nl,
	write(Reply),nl.

evalline(doit::reply(Reply),((do),reply(Reply))) :-	%% TLF-030509
	!,
	write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),
	write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),nl,
	write(Reply),nl.




evalline(doit:::quit(_),((do),quit(bye))) :- %% TA-090617
	!,
   reset_dialog.



evalline(error, _) :- 
	getcurrent(Cid),
	\+ confused(Cid),
	assert(confused(Cid)),

   waves, %% TA-050809

	write('Jeg forstår ikke.'), nl.



evalline(error, _) :- %% TA-070201
   getcurrent(Cid),	
   confused(Cid),
   !,

   waves, %% TA-050809

	write('Jeg forstår fortsatt ikke'), nl.  %%% og må desverre avbryte samtalen
%%    reset_dialog.



evalline(error, _) :-
	\+ value(teleflag,true),
        getcontext(Cid, context(Tql, Prog, TempRefer, [node(TopName,_, TopFocus, TopRem) | NodeStack])),

	ExtraStack = [node(tb_start2,_, TopFocus, 
           [item(say(tbs_userhelp)), sub(tb_from)]) | [node(TopName,_, TopFocus, TopRem) | NodeStack]],

	setcontext(Cid, context(Tql, Prog, TempRefer, ExtraStack)),
	false.



evalline(error, _) :- 
        getcontext(Cid, context(Tql, Prog, TempRefer, [node(TopName,  _  , TopFocus, TopRem) | NodeStack])),
	ExtraStack = [node(tb_start2,  _  , TopFocus, [item(say(tbs_userhelp)), sub(tb_from)]) | 
                [node(TopName,  _  , TopFocus, TopRem) | NodeStack]],
	setcontext(Cid, context(Tql, Prog, TempRefer, ExtraStack)),
	false.

evalline(_, Tql) :-
   trackprog(3, writeout:output(' *evalline 1* ')), %% TA-030108
	retractall(confused(Cid)),
	getcurrent(Cid),
	getcontext(Cid, context(_Tql, _Prog, TempRefer, NodeStack)),

	setcontext(Cid, context(Tql, [], TempRefer, NodeStack)),
	g_execute1(NodeStack, NewNodeStack, false),
	\+ NewNodeStack = [], 
	!, 
	getcontext(Cid, context(NewTql, NewProg, NewTempRefer, _)),
	setcontext(Cid, context(NewTql, NewProg, NewTempRefer, NewNodeStack)).

evalline(_, Tql) :- 
	\+ value(teleflag,true),
   trackprog(3, writeout:output(' *evalline 2*  ')), %% TA-030108
   \+ value(wozflag,true),                     %% TA-031017
	getcurrent(Cid),
	getcontext(Cid, context(_Tql, _Prog, TempRefer, [node(TopName,  _  , TopFocus, TopRem) | NodeStack])),
	ExtraStack = [node(tb_start2,  _  , TopFocus, [item(say(tbs_userhelp)), sub(tb_from)]) | [node(TopName,  _  , TopFocus, TopRem) | NodeStack]],
	setcontext(Cid, context(Tql, [], TempRefer, ExtraStack)),
	g_execute1(ExtraStack, NewNodeStack, false),
	\+ NewNodeStack = [], 
	!, 
	getcontext(Cid, context(NewTql, NewProg, NewTempRefer, _)),
	setcontext(Cid, context(NewTql, NewProg, NewTempRefer, NewNodeStack)).

evalline(_, _) :-
        waves, %% TA-050809
        writeanswer( ( startmark, bcpbc(dialogerror), period ) ).     % uses the busanshp: module 

%% Handle one TQL that appears in a sequence

evalline_multi( confirm::_,_) :-!. %% Yes/No,,..., (in a context) is ignored


evalline_multi(_, Tql) :-
	getcurrent(Cid),
	getcontext(Cid, context(_Tql, _Prog, TempRefer, NodeStack)),
	setcontext(Cid, context(Tql, [], TempRefer, NodeStack)),
	NodeStack = [node(OldType,  _  , _, OldRem) | OldRest],
	g_execute1( 
		NodeStack, 
		[node(_,   _  ,NewFocus, _) | _], true),
	NewNodeStack = [node(OldType,  _  , NewFocus, OldRem) | OldRest],
	getcontext(Cid, context(NewTql, NewProg, NewTempRefer, _)),
	setcontext(Cid, context(NewTql, NewProg, NewTempRefer, NewNodeStack)).
	
g_execute1( A, B, Multi ):- %% avoid recursion through files
   g_execute( A, B, Multi ).


varmember(X, [Y | _]) :-
	X == Y.

varmember(X, [_ | Rest]) :-
	varmember(X, Rest).


% Used in checkitem[2] RS-140913
subst_tql(_, _, Item, Item) :-
	var(Item), !.

subst_tql(OldItem, NewItem, (First, Rest), (NewFirst, NewRest)) :-
	subst_tql(OldItem, NewItem, First, NewFirst),
	subst_tql(OldItem, NewItem, Rest, NewRest), !.
	
subst_tql(OldItem, NewItem, Rest/Last, NewRest/NewLast) :-
	subst_tql(OldItem, NewItem, Last, NewLast),
	subst_tql(OldItem, NewItem, Rest, NewRest), !.

subst_tql(OldItem, NewItem, OldItem isa Type, NewItem isa Type) :- !.
subst_tql(OldItem, NewItem, which(OldItem), which(NewItem)) :- !.


subst_tql(OldItem, NewItem, OldItem, NewItem) :- !.
subst_tql(_, _, Item, Item) :- !.
	


%% ¤¤¤¤¤¤¤¤¤¤¤¤
%:- meta_predicate  traceanswer(0).
%traceanswer( _:Panswer ) :- 
%         value(traceans,L),
%         L>1,
%    !,
%         copy_term( Panswer, Pwr ),
%         numbervars(Pwr),         % utility.pl?
%         prettypr('Application answer program',Pwr),nl. 
%traceanswer(_). %% Otherwise
%
%% ¤¤¤¤¤¤¤¤¤¤¤¤
%writeanswer( Panswer ) :- 
%    traceanswer( Panswer ),
%    Panswer,
%    !. 

%% sant
