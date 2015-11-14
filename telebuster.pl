%% FILE telebuster.pl
%% SYSTEM BUSTER
%% CREATED   TA-051007
%% REVISED   TA-081113

%% UNIX Version

%% Compiles all  the necessary files.
%% Same function as the file tucbus.


%% Emergency procedure to avoid segmentation violation (on Sun Solaris)

:- use_module( declare, [ (:=)/2, (=:)/2, set/2, value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .

/*

If you will avoid  

! segmentation violation
% Execution aborted

you should start the dialog with

N: hei.


*/



%%?- prolog_flag(unknown,_,fail). %% (Don't?) crash on undefined predicates

%?- compile('tucbuster.pl'). %% TA-070811
:- use_module( 'tucbuster.pl', [ ] ).   %% :-[tuctele]. %%% // Tele things %% TA-051018

%?- compile('busroute.pl').  %% TA-071026
%:- use_module( busroute, [  ] ). %% RS-131227 Avoid loop?


?- (duallangflag := true). %% telebuster is not  speech based

?- (telebusterflag := true). %% Permanent 

?- (teleflag := true).       %% Volatile %% Ad Hoc 

?- (windowsflag := false).

