%% FILE telebuster.pl
%% SYSTEM BUSTER
%% CREATED   TA-051007
%% REVISED   TA-081113

%% UNIX Version

%% Compiles all  the necessary files.
%% Same function as the file tucbus.


%% Emergency procedure to avoid segmentation violation (on Sun Solaris)

/*

If you will avoid  

! segmentation violation
% Execution aborted

you should start the dialog with

N: hei.


*/



?- prolog_flag(unknown,_,fail). %% Don't crash on undefined predicates

?- compile('tucbuster.pl'). %% TA-070811

?- compile('busroute.pl').  %% TA-071026


?- (user:duallangflag := true). %% telebuster is not  speech based

?- (user:telebusterflag := true). %% Permanent 

?- (user:teleflag := true).       %% Volatile %% Ad Hoc 

?- (user:windowsflag := false).

