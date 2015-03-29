/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE readin.pl
%% SYSTEM TUC
%% CREATED  TA-910531   %% REVISED  TA-110725
%% REVISED  RS-140101 modularized

%%%% OUTPUT     %% RS-140921 To split utility.pl into managable modules

:-module( meta_preds, [ writeanswer/1,  xwriteanswer/2 ] ).      %% RS-150329 Moved to main?: language/1,

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% META_PREDICATES SECTION, %% RS-140927 meta_predicates    : means use source module       + means use this (utility) module  for expansion %% RS-131231 %From utility.pl
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%:- meta_predicate  busanswer_sat( ?, 0, ? ) . %% RS-141105
%:- meta_predicate  track( +, 0 ) .     %% Moved to declare!  %% RS-150111
%:- meta_predicate  trackprog( +, 0 ) . %% Moved to declare!  %% RS-150111
:- meta_predicate  traceanswer( 0 ) .
:- meta_predicate  writeanswer( 0 ) .

%:- meta_predicate  writetelebusteranswer_rep( 0 ) .
%:- meta_predicate  writetelebusteranswer1( 0 ) .
%:- meta_predicate  writetelebusteranswer_saf( ?, 0 ) .
%:- meta_predicate  listall( 0 ) .
%:- meta_predicate  teleanswer_sat( +, 0 ) .
:- meta_predicate  xwriteanswer( ?, 0 ) .

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- use_module( '../declare', [ value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .
:- use_module( '../sicstus4compatibility', [ output/1, prettypr/2 ] ). % , writeanswer/1 ] ).  %% Compatible with sicstus4, get0/1 etc.

:- use_module( library(varnumbers), [ numbervars/1 ] ). %% RS-140210.

%% RS-131225, UNIT: /utility/
%% RS-141026    UNIT: /dialog/
%% RS-131225    UNIT: tuc/

%out(P) :- write(P), tab(1). %% Moved to sicstus4compatibility!
%output(P) :- write(P), nl.
%language(L) :- value( language, L ). %% value(language,X) should have been set dynamically by now! In tucbuses
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%MOVED

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%% ¤¤¤¤¤¤¤¤¤¤¤¤
traceanswer( _:Panswer ) :- 
         value(traceans,L),
         L>1,
    !,
         copy_term( Panswer, Pwr ),
         numbervars(Pwr),         % utility.pl?
         prettypr('Application answer program',Pwr),nl. 

traceanswer( _ ). %% Always Succeeds (Otherwise)


writeanswer( Panswer ) :- 
    traceanswer( Panswer ),
    Panswer,
    !. 


%% Handle QUIT commands %% TA-070419 ?? RS-150328
xwriteanswer( Fql, AnswerOut ) :-
    value(directflag,true),
    !,
    value(directoutputfile,Newans), 
    tell(Newans), 
       nl,

        output('*** TQL  ***'),nl,
        output(Fql),nl,

        output('*** Answer ***'),nl,
        output(' '),nl,

        call(AnswerOut),nl,

     told.


xwriteanswer( _Fql, AnswerOut ) :- %% TA-070608
   writeanswer( AnswerOut ).

