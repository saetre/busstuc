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
%?- (main:duallangflag := false).      %% speech based
%
%?- (main:telebusterflag := false). %% Permanent
%
%?- (main:daterflag := true).       %% Permanent %% TA-061130
%
%?- (main:teleflag := true).       %% Volatile %% Ad Hoc 
%
%?- (main:busflag := false).       
%
%?- (main:windowsflag := false).
