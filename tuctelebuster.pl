%% FILE tuctelebuster.pl
%% SYSTEM BUSTER
%% CREATED   TA-051007
%% REVISED   TA-060208

%:- ensure_loaded( user:'declare' ). %% RS-111213 General (semantic) Operators
:- use_module( declare, [ (:=)/2, (=:)/2, set/2, value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .

%% UNIX Version

%% Compiles all  the necessary files.
%% Same function as the file tucbus.



%%?-prolog_flag(unknown,_,fail). %% (Don't?) crash on undefined predicates

%:- compile( 'tucbuster.pl' ).   %% :-[tuctele]. %%% // Tele things %% TA-051018
:- use_module( 'tucbuster.pl', [ ] ).   %% :-[tuctele]. %%% // Tele things %% TA-051018

:- (duallangflag :=true). %% telebuster is not  speech based

?- (telebusterflag := true). %% Permanent 

?- (teleflag := true).       %% Volatile %% Ad Hoc 

?- (windowsflag := false).


%% Emergency procedure to avoid segmentation violation %% TA-060208


/**********

% sicstus
?-[telebuster].
?-debug.  %% Bloody hack
?-save_program(telebuster).
?-halt.

*******/

