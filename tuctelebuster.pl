%% FILE tuctelebuster.pl
%% SYSTEM BUSTER
%% CREATED   TA-051007
%% REVISED   TA-060208

%% UNIX Version

%% Compiles all  the necessary files.
%% Same function as the file tucbus.

%%% %%%%%%%% RS-111118
:- ensure_loaded( 'declare' ).
:- use_module( main, [   (:=)/2, myflags/2, set/2  ] ).



?-prolog_flag(unknown,_,fail). %% Don't crash on undefined predicates

g:-['tucbuster.pl'].   %% :-[tuctele]. %%% // Tele things %% TA-051018

:- (main:duallangflag := true). %% telebuster is not  speech based

?- (main:telebusterflag := true). %% Permanent 

?- (main:teleflag := true).       %% Volatile %% Ad Hoc 

?- (main:windowsflag := false).


%% Emergency procedure to avoid segmentation violation %% TA-060208


/**********

% sicstus
?-[telebuster].
?-debug.  %% Bloody hack
?-save_program(telebuster).
?-halt.

*******/

