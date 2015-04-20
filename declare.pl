%% FILE declare.pl                   
%% SYSTEM TUC
%% CREATED TA-940118
%% REVISED TA-090514
%% REVISED RS-141105 Modularized

%% Declarations used by TUC
%% USAGE:
%:- use_module( declare, [ (:=)/2, (=:)/2, set/2, value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .

:- module( declare, [ (:=)/2, ( =: )/2, forget/1, language/1, remember/1, set/2, track/2, trackprog/2, value/2 ] ).

:- meta_predicate  remember(0) .        %% RS-140928 Remember the facts IN THE MODULE THAT CALLS REMEMBER! Use  :  or  0
%:-use_module( 'utility/writeout', [ out/1, output/1 ] ).       %% Avoid ANY Loops from declare import X, X use_module( declare ). !!!  RS-141108


%%%%%%%%%%%%%%%%%%%%%%  SPECIAL (non-volatile) SECTION. Stored with save_program  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%value( X, Y ) :- main:value( X, Y ).
%:- meta_predicate  value( ?, ? ).
%:-volatile
%          value/2.      %% RS-130630. NOT VOLATILE!!! These values HAVE to be stored in the compiled save_program!!!
:-dynamic
          value/2.      %% RS-130630. declare:value is modified by the  :=  predicate, and checked by the =: predicate
%

language(L) :- value( language, L ). %% value(language,X) should have been set dynamically by now! Moved to utility...?

set( Counter, Value ) :- 
    retractall( value( Counter, _ ) ),
    assert( value( Counter, Value ) ).

%% "MEMORY" SECTION
%forget/1, remember/1, % moved to main from declare.pl
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
forget(X) :- retractall(X).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
remember( Module:F ) :- Module:F, ! ; assert( Module:F ). %, out( 'remember' ),output(Module:F).        %% Add F it is does not already exist.
% remember( Setting ) :- out( 'utility:remember/1 => Something went wrong with:'), output( Setting ), output( call( Setting ) ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RS-141026 For gram_n and gram_e
:- op(1150,xfx, ---> ).
:- op(1150,xfx, ( ---> ) ).

% Operatorer for Pragma-regler (bustrans, busans, teleans, negans, etc.)
% "is"-operator is prefixed with rule RuleID

:- op( 1150, xfy, rule ). %% Moved to declare.pl ?  % RS-140617
:- op( 1120,  fy, is ).   %% "is" is a prolog operator!?? RS-141006
:- op( 1110, xfy, id ).
:- op( 1110, xfy, ip ).

%% Some Prologs don't like LISTS OF OPERATORS
:- op( 999,fx,listall ).   %% TA-030504
:- op( 800,fx,  def ).
%:-op( 731,xfy, ::: ).    %% sentence tag  %% TA-090514 For main, tuc/ [ translat gram_x evaluate dcg_x anaphors ], app/ [ busanshp bustrans interapp ], dialog/d_dialogue
%% RS-150414.   ::: is also a kind of lambda? which(A):::car(A).
:- op( 730,xfy, :: ).     %% lambda infix  %% RS-141026 For      tuc/ [ translat gram_x fernando  dcg_x anaphors ], app/interapp, dialog/ [checkitem/2 d_context d_dialogue frames/2 makeframe/2 parseres virtuals relax update2 usesstate2]
:- op( 729,xfx, : ).      %% variable type
:- op( 727,xfy, => ).     %% for main.pl and translat.pl "rules?"
:- op( 727,yfx, if ). 
:- op( 726,xfx, then ).   
:- op( 725,xfy, or ).
:- op( 725, fy,addcon ).     %% add if not already present 
:- op( 720,xfy, and ).
:- op( 720,xfy, & ).
:- op( 719,yfx, butnot ).
:- op( 715, fy, not ).   %% :- op( 715, fy,not).  % Already defined in TUC

:- op( 715, fy, addfront ).   %% (for messages etc) 
:- op( 715, fy, context ).    %% similar to present, but doesn't mark as seen 

:- op( 715, fy, no ).
:- op( 715, fy, remove ).
:- op( 715, fy, removeall ).  %% remove all of a list
:- op( 715, fy, removeif ).   %% remove all if any , always succeed 

:- op( 715, fy, replaceall ). %% replace iteratively all elements 
:- op( 715, fy, replaceif ).  %% replace if occuring. 
:- op( 715, fy, replacelast ).
%%  :- op( 715,xfy,append).

%For busans.pl
:- op( 715, fy, add ).
:- op( 715, fy, exactly ). 
:- op( 715, fy, present ).
:- op( 715, fy, replace ).
:- op( 715,xfy, with ).

%For pragma.pl
:- op( 715, fy, assume ). %operator in pragma, but looks like assume(predicate) in bustrans... ? meta_predicate setting?
:- op( 714,xfy, seq ).     %% directly sequence 

:- op( 714,xfy, cond ).    %% new   not X isa place cond bound(X)
:- op( 714,xfy, when ).    %% same as cond %% TA-081106
:- op( 712, fy, seen ). % Lower than "not", higher than "isa"
:- op( 710,xfx, ako ).
:- op( 710,xfx, apo ).
:- op( 710,xfx, isa ).  % Move to tuc/facts
:- op( 710,xfx, has_a ).
:- op( 710,xfx, is_the ).

:- op( 500,xfy, \  ).
:- op( 500,xfy, -... ). %% same as \
:- op( 500,xfy, -. ).   %% same as -

:- op( 714,xfx, := ).
:- op( 713,xfx, =: ). 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RS-141105
X := Y  :-      %% RS-131228    :=/2    X set to Y's value
    set(X,Y).
X =: Y  :-      %% RS-141024    =:/2    Y is set to X's value
    value(X,Y). % ->  true ; ( out(X), output(' not set!'), fail ).   % ; ( out(X), output(' not set!'), fail ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- meta_predicate  track( +, 0 ) .
track( N, P ) :- 
    value( trace, M ),  number(M), M >= N, 
    !,
    call(P)   %% TA-110130
;
    true.
%///
:- meta_predicate  trackprog( +, 0 ) . %% Moved to declare!  %% RS-150111
trackprog( N, P ) :-
    value( traceprog, M ), number(M), M >= N,
    !,
    ( nl, call(P) )    %% TA-110130
        ;
    true. %% Finally, succeed anyway
%///
