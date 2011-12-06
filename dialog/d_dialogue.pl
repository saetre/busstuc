%% FILE   d_dialogue.pl
%% SYSTEM BUSTER
%% CREATED AM-980218
%% REVISED TA-060706

:- module( d_dialog, [ confused/1,    %evalline_multi/2,
    last_answer/2,     linecounter/1, %processinput/1, quit_dialog/0, reset_conns/0,
    subst_tql/4,       varmember/2
   ] ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- volatile confused/1, last_answer/2, linecounter/1.
:- dynamic confused/1, last_answer/2, linecounter/1.

:- assert( linecounter(1) ).
:- assert( confused(noone) ). %-)

:- ensure_loaded( '../declare' ).
%:-use_module( '../declare' ).

%% Dialogue manager.


%dialog :- 
%   user:dialog := 1, 
%   reset_period,
%   reset_context,
%   dialog2.
%
%run:-dialog.  
%
%hi:-debug, run. 
%
%processinput(Q) :-                     %%AM-980301
%	
%   user:dialog := 1,
%	user:error_phase := 0,
%   user:nightbusflag := false,   %% ad hoc, must be reset %% TA-060706
%	translate2(Q,TQL),
%	nl,
%
%   user:myflags(contextid,Cid),
%   setcurrent(Cid),
%
%  (user:myflags(topic,BT) -> 
%      xframe_setvalue(topic,BT) % put topic into the context frame  %% TA-060426
%      ;true),
%
%  (user:myflags(language,Lan) -> 
%      xframe_setvalue(language,Lan) % put language into the context frame  %% TA-060426
%      ;true),
%
%
%	linecounter(X),
%	NewX is X + 1,
%	retractall(linecounter(_)),
%	assert(linecounter(NewX)),
%	dialogline(TQL),
%
%   printcontext, %% (conditionally) 
%
%   told,   %% postponed if directflag, harmless if not 
%
%	clearold,
%	!.
%
%
%
%% processinput(_).  %% To avoid server stop... %% Moved to the web-interface
%
%dialogline(nil). %% e.g. time_out, just accept %%% TA-031111 <---
%
%dialogline(error) :-
%	evalline(error, error).
%
%dialogline(stop) :-             %%AM-980311
%    !,
%    false.
%
%
%dialogline(command(C)) :-     %%AM-980311
%	exetuc(command(C)),!.
%
%
%dialogline([TQL]) :- %% Single question
%        copy_term(TQL,TQL1),
%        nocols(TQL1,TQL2),
%        flatround(TQL2,FQL),
%        konstantify(FQL),       
%	!,                        % look only at first try
%	trackprog(3, (write(FQL), nl)), 
%	timeout( 
%		evalline(TQL1, FQL),
%		15000,       %% 15 sec   timeout %%  TA-070419 (Slow server)
%		Result),
%	((Result = time_out) -> write('Timeout'), nl ; true).
%
%% Handle commands
%
%dialogline([TQL]) :- %% TA-970523
%	(TQL=stop;TQL=end),
%	!.
%
%dialogline([TQL | Rest]) :- %% Multiple questions
%        copy_term(TQL,TQL1),
%        nocols(TQL1,TQL2),
%        flatround(TQL2,FQL),
%        konstantify(FQL),       
%	!,                        % look only at first try
%	trackprog(3,(write(FQL), nl)), 
%	timeout( 
%		evalline_multi(TQL1, FQL),
%		25000,       %% 25 sec timeout %% TA-070419 (Slow server)
%		Result),
%	((Result = time_out) -> write('Timeout'), nl ; true),
%	dialogline(Rest).
%
%
%%reset_dialog(Reason):- %%  // bye/error
%%   retractall(confused(_)),  
%%   retractall(last_answer(_,_)), 
%%   getcurrent(Cid),   
%%	newcontext(Cid),
%%   Fql=(doit,quit(Reason)),
%%	pragma(trans,Fql,Program),
%%        
%%   makeanswer(true,Fql, Program ,AnswerOut), 
%%   waves, 
%% 
%%   xwriteanswer(Fql,AnswerOut). %% -> dir_file?%% TA-070419 
%%
%%
%%reset_dialog:- 
%%   retractall(confused(_)), 
%%   retractall(last_answer(_,_)), 
%%   getcurrent(Cid),   
%%	newcontext(Cid),
%%   Fql=(doit,quit(bye)),
%%	pragma(trans,Fql,Program),
%%        
%%   makeanswer(true,Fql, Program ,AnswerOut),
%%   waves, 
%%
%%   xwriteanswer(Fql,AnswerOut). %% -> dir_file?%% TA-070419 
%%
%
%quit_dialog:- %% TA-030630
%   retractall(confused(_)),      %% TA-041005
%   retractall(last_answer(_,_)), %%
%   getcurrent(Cid),   
%	newcontext(Cid).
%
%
%
%reset_conns :-				%% TLF-030523
%	user:myflags(teleflag,true),
%	reset_ldapcon.
%
%reset_conns.		%% TLF-030523 Should never fail!!
%
%
%
%%evalline(doit:::quit(error),(doit,quit(error))) :- %% TA-090617
%%	!,
%%   reset_dialog(error).
%%
%%
%%
%%%% TA-051005
%%evalline(doit:::replyq(Reply),(doit,replyq(Reply))) :-	%% TLF-030509 %% TA-090617
%%	!,
%%	write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),
%%	write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),nl,
%%	write(Reply),nl.
%%
%%evalline(doit::reply(Reply),(doit,reply(Reply))) :-	%% TLF-030509
%%	!,
%%	write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),
%%	write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),nl,
%%	write(Reply),nl.
%%
%%
%%
%%
%%evalline(doit:::quit(_),(doit,quit(bye))) :- %% TA-090617
%%	!,
%%   reset_dialog.
%%
%%
%%
%evalline(error, _) :- 
%	getcurrent(Cid),
%	\+ confused(Cid),
%	assert(confused(Cid)),
%
%   waves, %% TA-050809
%
%	write('Jeg forstår ikke.'), nl.
%
%
%
%evalline(error, _) :- %% TA-070201
%   getcurrent(Cid),	
%   confused(Cid),
%   !,
%
%   waves, %% TA-050809
%
%	write('Jeg forstår fortsatt ikke'), nl.  %%% og må desverre avbryte samtalen
%%%    reset_dialog.
%
%
%
%evalline(error, _) :-
%	\+ user:myflags(teleflag,true),
%        getcontext(Cid, context(Tql, Prog, TempRefer, [node(TopName,_, TopFocus, TopRem) | NodeStack])),
%
%	ExtraStack = [node(tb_start2,_, TopFocus, 
%           [item(say(tbs_userhelp)), sub(tb_from)]) | [node(TopName,_, TopFocus, TopRem) | NodeStack]],
%
%	setcontext(Cid, context(Tql, Prog, TempRefer, ExtraStack)),
%	false.
%
%
%
%evalline(error, _) :- 
%        getcontext(Cid, context(Tql, Prog, TempRefer, [node(TopName,  _  , TopFocus, TopRem) | NodeStack])),
%	ExtraStack = [node(tb_start2,  _  , TopFocus, [item(say(tbs_userhelp)), sub(tb_from)]) | 
%                [node(TopName,  _  , TopFocus, TopRem) | NodeStack]],
%	setcontext(Cid, context(Tql, Prog, TempRefer, ExtraStack)),
%	false.
%
%evalline(_, Tql) :-
%   trackprog(3, output(' *evalline 1* ')), %% TA-030108
%	retractall(confused(Cid)),
%	getcurrent(Cid),
%	getcontext(Cid, context(_Tql, _Prog, TempRefer, NodeStack)),
%
%	setcontext(Cid, context(Tql, [], TempRefer, NodeStack)),
%	g_execute1(NodeStack, NewNodeStack, false),
%	\+ NewNodeStack = [], 
%	!, 
%	getcontext(Cid, context(NewTql, NewProg, NewTempRefer, _)),
%	setcontext(Cid, context(NewTql, NewProg, NewTempRefer, NewNodeStack)).
%
%evalline(_, Tql) :- 
%	\+ user:myflags(teleflag,true),
%   trackprog(3, output(' *evalline 2*  ')), %% TA-030108
%   \+ user:myflags(wozflag,true),                     %% TA-031017
%	getcurrent(Cid),
%	getcontext(Cid, context(_Tql, _Prog, TempRefer, [node(TopName,  _  , TopFocus, TopRem) | NodeStack])),
%	ExtraStack = [node(tb_start2,  _  , TopFocus, [item(say(tbs_userhelp)), sub(tb_from)]) | [node(TopName,  _  , TopFocus, TopRem) | NodeStack]],
%	setcontext(Cid, context(Tql, [], TempRefer, ExtraStack)),
%	g_execute1(ExtraStack, NewNodeStack, false),
%	\+ NewNodeStack = [], 
%	!, 
%	getcontext(Cid, context(NewTql, NewProg, NewTempRefer, _)),
%	setcontext(Cid, context(NewTql, NewProg, NewTempRefer, NewNodeStack)).
%
%evalline(_, _) :-
%        waves, %% TA-050809
%
%        writeanswer((startmark,bcpbc(dialogerror),period)).
%
%%% Handle one TQL that appears in a sequence
%
%evalline_multi( confirm::_,_) :-!. %% Yes/No,,..., (in a context) is ignored
%
%
%evalline_multi(_, Tql) :-
%	getcurrent(Cid),
%	getcontext(Cid, context(_Tql, _Prog, TempRefer, NodeStack)),
%	setcontext(Cid, context(Tql, [], TempRefer, NodeStack)),
%	NodeStack = [node(OldType,  _  , _, OldRem) | OldRest],
%	g_execute1( 
%		NodeStack, 
%		[node(_,   _  ,NewFocus, _) | _], true),
%	NewNodeStack = [node(OldType,  _  , NewFocus, OldRem) | OldRest],
%	getcontext(Cid, context(NewTql, NewProg, NewTempRefer, _)),
%	setcontext(Cid, context(NewTql, NewProg, NewTempRefer, NewNodeStack)).
%	
%g_execute1(A,B,C):- %% avoid recursion through files
%   g_execute(A,B,C).
%

varmember(X, [Y | _]) :-
	X == Y.

varmember(X, [_ | Rest]) :-
	varmember(X, Rest).


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
	

