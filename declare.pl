%% FILE declare.pl                   
%% SYSTEM TUC
%% CREATED TA-940118
%% REVISED TA-090514
%% REVISED  RS-140101 modularized

%% Declarations used by TUC
%% USAGE:
%% :- ensure_loaded( user:'../declare' ). %% RS-120403 RS-131224 (:=)/2, forget/1, remember/1  moved from utility!

% Operatorer for Pragma-regler
% is operator prefixed with rule RuleID

:- op(1150,xfy,rule).  
:-  op(1150,xfx, ---> ).
:-  op(1150,xfx, ( ---> ) ).

:- op(1120, fy,is).     %% is is a prolog operator!?? RS-141006
:- op(1110,xfy,id).
:- op(1110,xfy,ip).

%% Some Prologs don't like LISTS OF OPERATORS
:-op( 999,fx,listall).   %% TA-030504
%:-op( 997, fx, rule ). %% proxy , NOW a pragma operator
:-op( 800,fx,  def ).
:-op( 731,xfy, ::: ).    %% sentence tag  %% TA-090514 
:-op( 730,xfy, :: ).     %% lambda infix      %% RS-131229 For dialog/frames2 and /virtuals (autofile)
:-op( 729,xfx, : ).      %% variable type
:-op( 727,xfy, => ).     %% for main.pl and translat.pl "rules?"
:-op( 727,yfx, if ). 
:-op( 726,xfx, then ).   
:-op( 725,xfy, or ).
:-op( 720,xfy, and ).
:-op( 720,xfy, & ).
:-op( 719,yfx, butnot ).
:-op( 715, fy, not ).

%For pragma.pl
:- op( 715, fy, assume). %operator in pragma, but looks like assume(predicate) in bustrans... ? meta_predicate setting?
:- op( 714,xfy,seq).     %% directly sequence 

:-op( 714,xfx, := ).
:-op( 713,xfx, =: ). 
:-op( 710,xfx, ako ).
:-op( 710,xfx, apo ).
:-op( 710,xfx, isa ).  % Move to tuc/facts
:-op( 710,xfx, has_a ).
:-op( 710,xfx, is_the ).

:-op( 500,xfy, \  ).

:-op( 500,xfy,-...). %% same as \
:-op( 500,xfy,-.).   %% same as -

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%  SPECIAL (non-volatile) SECTION. Stored with save_program  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%:-volatile
%          value/2.      %% RS-130630. NOT VOLATILE!!! These values HAVE to be stored in the compiled save_program!!!
:-dynamic
          value/2.      %% RS-130630.
%

%% DYNAMIC SECTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:-volatile
        (=>)/2,        % asserted in translate.pl
        (::)/2,         %% RS-131228 For inger.pl 
         difact/2,    %% Dynamic,  context dependent  %% TA-980301
         fact0/1.     %% Semi permanent, in evaluate.pl
          

:-dynamic
        (=>)/2,        % asserted in translate.pl
        (::)/2,         %% RS-131228 For inger.pl 
         difact/2,    %% Dynamic,  context dependent  %% TA-980301
         fact0/1.     %% Semi permanent, in evaluate.pl

%        fact1/2,     %% Dynamic  . Moved somewhere?

%        ctxt/3,     % composite words , moved to lex.pl module
%        maxl/1,     % number  of words
%        txt/3.      % elementary words %% RS-131225    MOVED to tuc/lex.pl
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set( Counter, Value ) :- 
    retractall( value( Counter, _ ) ),
    assert( value( Counter, Value ) ).

X := Y  :-      %% RS-131228    :=/2    X set to Y's value
    user:set(X,Y).
X =: Y  :-      %% RS-141024    =:/2    Y is set to X's value
    user:value(X,Y).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

backslash('\\').

%% META-PREDICATES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:-meta_predicate  track(+,0) .
track(N,P):- 
    user:value(trace,M),  number(M), M >= N, 
    !,
    call(P)   %% TA-110130
;
    true.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:-meta_predicate  trackprog(+,0) .
trackprog( N, P ) :-
    user:value( traceprog, M ), number(M), M >= N,
    !,
    ( nl, call(P) )    %% TA-110130
        ;
    true. %% Finally, succeed anyway
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  trace traceprog -> write
%%  track trackprog -> call

trace(N,P):- 
    user:value(trace,M), number(M), M >= N, 
    !,
    write(P),nl
;
    true.

traceprog(N,P):- 
    user:value(traceprog,M), number(M), M >= N, 
    !,
    write(P),nl
;
    true.

% % % % % % % % %
