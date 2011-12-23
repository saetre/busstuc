%% FILE tuctelebuster.pl
%% SYSTEM BUSTER
%% CREATED   TA-051007
%% REVISED   TA-060208

:- ensure_loaded('declare'). %% RS-111213 General (semantic) Operators

%% UNIX Version

%% Compiles all  the necessary files.
%% Same function as the file tucbus.



?-prolog_flag(unknown,_,fail). %% Don't crash on undefined predicates

g:-['tucbuster.pl'].   %% :-[tuctele]. %%% // Tele things %% TA-051018

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

