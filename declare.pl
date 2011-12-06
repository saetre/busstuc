%% FILE declare.pl                   
%% SYSTEM TUC
%% CREATED TA-940118
%% REVISED TA-090514 %% RS-111118

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Declarations of operators and hashmap for flags, used by TUC
%% Don't make this a module, user:space is easier ;-)

%% Declarations of operators used by TUC

%% Some Prologs don't like lists of operators

:-op(1150,xfx, ---> ). %% from gram_

:-op( 999,fx,listall). %% TA-030504
:-op( 800,fx,  def ).
:-op( 731,xfy, ::: ).   %% sentence tag  :::/2  %% TA-090514 %% from gram_
:-op( 730,xfy, :: ).    %% lambda infix  ::/2   %% from gram_
:-op( 729,xfx, : ).     %% variable type
:-op( 727,xfy, => ).    %% from gram_
:-op( 727,yfx, if ). 
:-op( 726,xfx, then ).   
:-op( 725,xfy, or ).    %% from gram_
:-op( 720,xfy, and ).   %% from gram_
:-op( 720,xfy, & ).
:-op( 719,yfx, butnot ).
:-op( 715, fy, not ).   %% from gram_
:-op( 714,xfx, := ).
:-op( 713,xfx, =: ).
:-op( 710,xfx, ako ).   %% from gram_ %% RS-111121
:-op( 710,xfx, apo ).  
:-op( 710,xfx, isa ).   %% from gram_
:-op( 710,xfx, has_a ).
:-op( 710,xfx, is_the ).

:-op( 500,xfy, \  ).

:-op( 500,xfy,-...). %% same as \
:-op( 500,xfy,-.).   %% same as -

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Declarations of hashmap for flags, used by TUC       %user:myflags(origlanguage, norsk).
%% made available through  module main: , as a user:module)
%    :=/2      %    =:/2
:-volatile  user:myflags/2.
:-dynamic   user:myflags/2.

%% :- use_module( main, [ set/2 ] ) .   RECURSIVE! Don't loop!
%% remove_duplicates  Standard  -> library
set(Key,Value) :-
    retractall( user:myflags(Key,_) ),
    assert( user:myflags(Key, Value) ).


user:(X := Y) :-       %% Set value X to Y, :=/2 or (:=)/2
    set(X,Y).

%% Difficult to make, difficult to understand :-/
user:(X =: Y) :-       %% Set value Y from X, =:/2 or (=:)/2     
    user:myflags(X,Y).

