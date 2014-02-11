%% FILE declare.pl                   
%% SYSTEM TUC
%% CREATED TA-940118
%% REVISED TA-090514
%% REVISED  RS-140101 modularized

%% Declarations used by TUC
%% USAGE:
%% :- ensure_loaded( user:'../declare' ). %% RS-120403 RS-131224 (:=)/2, forget/1, remember/1  moved from utility!

%% Some Prologs don't like LISTS OF OPERATORS
:-op(1150,xfx, ---> ). 
% :-op( 997, fx, rule ). %% proxy , NOW a pragma operator
:-op( 999,fx,listall).   %% TA-030504
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
:-op( 714,xfx, := ).
:-op( 713,xfx, =: ). 
:-op( 710,xfx, ako ).
:-op( 710,xfx, apo ).  
:-op( 710,xfx, isa ).
:-op( 710,xfx, has_a ).
:-op( 710,xfx, is_the ).

:-op( 500,xfy, \  ).

:-op( 500,xfy,-...). %% same as \
:-op( 500,xfy,-.).   %% same as -

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%  SPECIAL (non-volatile) SECTION. Stored with save_program  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%:-volatile
%          value/2.      %% RS-130630. BIG DANGER!!! These values have to be stored in the compiled save_program!!!
:-dynamic
          value/2.      %% RS-130630.
%

%% DYNAMIC SECTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:-volatile  (=>)/2,        % asserted in translate.pl
        (::)/2,         %% RS-131228 For inger.pl 
%        ctxt/3,     % composite words 
         difact/2,    %% Dynamic,  context dependent  %% TA-980301
         fact0/1.     %% Semi permanent, in evaluate.pl
%        fact1/2,     %% Dynamic  
%        maxl/1,     % number  of words
%        txt/3.      % elementary words %% RS-131225    MOVED to tuc/lex.pl
          

:-dynamic  (=>)/2,        % asserted in translate.pl
        (::)/2,         %% RS-131228 For inger.pl 
%        ctxt/3,     % composite words 
         difact/2,    %% Dynamic,  context dependent  %% TA-980301
         fact0/1.     %% Semi permanent, in evaluate.pl
%        fact1/2,     %% Dynamic  
%        maxl/1,     % number  of words
%        txt/3.      % elementary words %% RS-131225    MOVED to tuc/lex.pl
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% "MEMORY" SECTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
forget(X) :- retractall(X).

:-meta_predicate
          remember(:) .
remember(F) :- F, ! ; assert(F).        %% Moved before use_module(metacomp)!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(Counter,Value) :- 
    retractall( value(Counter,_) ),
    assert( value(Counter,Value) ).

X := Y :-       %% RS-131228    :=/2
    set(X,Y).
X =: Y :-  
    value(X,Y). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

backslash('\\').
