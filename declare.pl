%% FILE declare.pl                   
%% SYSTEM TUC
%% CREATED TA-940118
%% REVISED TA-090514

%% Declarations used by TUC

%% Some Prologs don't like lists of operators


:-op(1150,xfx, ---> ). 
% :-op( 997, fx, rule ). %% proxy , NOW a pragma operator

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
:-op( 710,xfx, ako ).
:-op( 710,xfx, apo ).  
:-op( 710,xfx, isa ).
:-op( 710,xfx, has_a ).
:-op( 710,xfx, is_the ).


:-op( 500,xfy, \  ).

:-op( 500,xfy,-...). %% same as \
:-op( 500,xfy,-.).   %% same as -

:-dynamic (=>)/2,
          dynoatt/2,
          dynotype/2,
          fact0/1,     %% Semi permanent 
%          fact1/2,     %% Dynamic  
          difact/2,     %% Dynamic,  context dependent  %% TA-980301
          value/2.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


