/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE telelog.pl
% Hjelpepredikat for tele


unbound(free(_)):-!.
unbound(X) :- internalkonst(X).
bound(X) :- \+ unbound(X).

atday(_).
atdate(_).
timeis(_).
dateis(_,_,_,_).
message(_).

takestime(_,_,_).
passesstations(_,_,_,_).


%timenow(1200).

timenow(Tid) :-  % Tiden akkurat nå
	 datetime(_,_,_,Hour,Min,_),
	 Tid is Hour*100+Min.


timenow2(Delay,Tid2):- %% TA-011108
    timenow(Tid),
    addtotime(Tid,Delay,Tid2).
