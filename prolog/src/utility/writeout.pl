/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE readin.pl
%% SYSTEM TUC
%% CREATED  TA-910531   %% REVISED  TA-110725
%% REVISED  RS-140101 modularized

%%%% OUTPUT     %% RS-140921 To split utility.pl into managable modules

:-module( writeout, [ doubt/2, language/1, out/1, output/1, prettyprint/1, roundwrite/1, sequence_write/1, track/2, writepred/1 ] ).

%% RS-141026    UNIT: /
:- use_module( '../main.pl', [ value/2 ] ). %MISERY?!
%% RS-131225, UNIT: /   and /utility/
%:- ensure_loaded( user:'../declare' ).  %% RS-140102 (:=)/2, user:value/2 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% META_PREDICATES SECTION, %% RS-140927 meta_predicates    : means use source module       + means use this (utility) module  for expansion %% RS-131231 %From utility.pl
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:-meta_predicate  output( + ).   %% RS-100101 ?  %% NEW PREDICATE
%:-meta_predicate  output( 0 ).   %% RS-140928 ?  %% NOT META PREDICATE: write/1
:- meta_predicate  track(+,0) .

out(P) :- write(P), tab(1).
output(P) :- write(P), nl.

track( N, P ) :- 
    value( trace, M ),  number(M), M >= N, 
    !,
    call(P)   %% TA-110130
;
    true.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- use_module( '../sicstus4compatibility', [ tab/1 ] ).  %% Compatible with sicstus4, get0/1 etc.
:- use_module( library(varnumbers), [ numbervars/1 ] ). %% RS-140210.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

doubt(A,B) :-
    language( english ) -> out( A );
    language( norsk ) -> out( B );
    out(A).

language(L) :- value( language, L ). %% value(language,X) should have been set dynamically by now! In tucbuses

%numbervars(F) :-
%    numbervars( F, 0, _ ).

writepred(P) :- writeq(P),write('.'),nl. 

prettyprint( P ) :-
    numbervars( P ),
    writeq( P ),nl,
    false; % release bindings
    true.

roundwrite( nil ) :-!. %% catches var
roundwrite( (X,Y) ) :-!, out(X),roundwrite(Y).
roundwrite( X ) :- !, out(X).

sequence_write(X) :- roundwrite(X). %% New name, more standard

