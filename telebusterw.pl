%% FILE telebusterw.pl
%% SYSTEM BUSTER
%% CREATED   TA-051007
%% REVISED   TA-071130

%% WINDOWS  Version

%% Compiles all  the necessary files.



?- prolog_flag(unknown,_,fail). %% Don't crash on undefined predicates

?- compile('tucbuster.pl'). %% TA-070811

?- compile('busroute.pl'). %% TA-060126




?- (main:duallangflag := true). %% telebuster is not  speech based

?- (main:telebusterflag := true). %% Permanent 

?- (main:teleflag := true).       %% Volatile %% Ad Hoc 

?- (main:windowsflag := true).


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

