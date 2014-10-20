/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE telelog.pl
%% UNIT app
%% REVISED RS-140101 time-preds "moved back"? to app/buslog

%% USAGE: :- use_module( '../app/telelog', [ bound/1 ] ).    %% RS-131225


% Hjelpepredikater for tele, USAGE: (Probably not needed, as long as utility/* are there...?
:- module( telelog, [ ] ). %% bound/1, unbound/1 ] ). %% RS-131231

% :- use_module( buslog, [  internalkonst/1   ]).     %% RS-131225    For telelog.pl 'sk(_).'

% These predicates are only to preserve information, no filtering: atday/1, atdate/1, timeis/1, dateis/4, message/1, takestime/3, passesstations/4
%%:-module(telelog, [ bound/1, unbound/1, atday/1, atdate/1, timeis/1, dateis/4, message/1, takestime/3, passesstations/4 ] ).

% Hjelpepredikat
%bound(X) :- \+ unbound(X).
%
%unbound(X) :- var(X),!.
%unbound(free(_)):-!.
%unbound(X) :- internalkonst(X).


% These predicates are only to preserve information, no filtering..
%atday(_).
%atdate(_).
%timeis(_).
%dateis(_,_,_,_).
%message(_).
%
%takestime(_,_,_).
%passesstations(_,_,_,_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Keep utility/* in user:module...
%% RS-131225 For app/buslog, (telelog), etc? import in pragma? NO! Do all of this in user:monobuss->app or tucbuses->tuc
%:-use_module( '../utility/datecalc', [ addtotime/3,  datetime/6 ]).

