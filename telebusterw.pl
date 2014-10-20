%% FILE telebusterw.pl
%% SYSTEM BUSTER
%% CREATED   TA-051007
%% REVISED   TA-071130

%% WINDOWS  Version

%% Compiles all  the necessary files.



%%?- prolog_flag(unknown,_,fail). %% (Don't?) crash on undefined predicates

?- compile('tucbuster.pl'). %% TA-070811
%:- use_module( 'tucbuster.pl', [ ] ).   %% :-[tuctele]. %%% // Tele things %% TA-051018

%?- compile('busroute.pl'). %% TA-060126
:- use_module( busroute, [  ] ). %% RS-131227 Avoid loop?




?- (duallangflag :=true). %% telebuster is not  speech based

?- (telebusterflag := true). %% Permanent 

?- (teleflag := true).       %% Volatile %% Ad Hoc 

?- (windowsflag := true).


%% Emergency procedure to avoid segmentation violation

/*

% sicstus
?-[telebusterw].
?-run.
N: hei.
N: \
?-save_program(telebusterw).
?-halt.

*/

