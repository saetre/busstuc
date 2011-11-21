%% FILE declare.pl                   
%% SYSTEM TUC
%% CREATED TA-940118
%% REVISED TA-090514 %% RS-111118

:- module( main, [ myflags/2, set/2, ':='/2 ] ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Declarations of operators and hashmap for flags, used by TUC
%% Don't make this a module, user:space is easier ;-)
%% %% That's why the for loop is here %% RS-111120

%% Hash-table for all sorts of values (in main user: module)

:- dynamic myflags/2.
myflags(origlanguage, norsk).

%    :=/2      %    =:/2

%% Declarations of operators used by TUC

%% Some Prologs don't like lists of operators
% :- ['../declare.pl'].   %% For importing into other .pl files
:-op(1150,xfx, ---> ). 

:-op( 999,fx,listall). %% TA-030504
:-op( 800,fx,  def ).
:-op( 731,xfy, ::: ).    %% sentence tag  %% TA-090514 
:-op( 730,xfy, :: ).     %% lambda infix
:-op( 729,xfx, : ).      %% variable type
:-op( 727,xfy, => ).
:-op( 727,yfx, if ). 
:-op( 726,xfx, then ).   
:-op( 725,xfy, or ).
:-op( 720,xfy, and ).
:-op( 720,xfy, & ).
:-op( 719,yfx, butnot ).
:-op( 715, fy, not ).
:-op( 714,xfx, := ).
:-op( 713,xfx, =: ).
:-op( 710,xfx, ako ).  %% Can interfere with ako/Man/Me etc. in bustrans! RS-111121
:-op( 710,xfx, apo ).  
:-op( 710,xfx, isa ).
:-op( 710,xfx, has_a ).
:-op( 710,xfx, is_the ).

:-op( 500,xfy, \  ).

:-op( 500,xfy,-...). %% same as \
:-op( 500,xfy,-.).   %% same as -


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Declarations of operators and hashmap for flags, used by TUC
%% remove_duplicates  Standard  -> library
set(Key,Value) :-
    retractall( myflags(Key,_) ),
    assert( myflags(Key, Value) ).

X := Y :-       %% Set value X to Y
    set(X,Y).

%X =: Y :-       %% Set value Y from X          %% Difficult to make, difficult to understand :-/
%    myflags(X,Y).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
