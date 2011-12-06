%% FILE dater.pl
%% SYSTEM BUSTER
%% CREATED   TA-051007
%% REVISED   TA-060306

%% UNIX Version

%% Compiles all  the necessary files.
%% Same function as the file tucbus.



%?-prolog_flag(unknown,_,fail). %% Don't crash on undefined predicates
%
%:-compile('tucbuster.pl').  
%
%?- (user:duallangflag := false).      %% speech based
%
%?- (user:telebusterflag := false). %% Permanent
%
%?- (user:daterflag := true).       %% Permanent %% TA-061130
%
%?- (user:teleflag := true).       %% Volatile %% Ad Hoc 
%
%?- (user:busflag := false).       
%
%?- (user:windowsflag := false).
