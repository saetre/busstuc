%% FILE tucsms.pl 
%% SYSTEM TUC
%% CREATED  TA-020125
%% REVISED  TA-090401


%% Makefile for SMSTUC   server, Incrementally
%?-prolog_flag(unknown,_,fail). %% Don't crash on undefined predicates

%% Operators used by TUC
:- ensure_loaded( 'declare' ).

?-use_module( tucbuses, [] ).   % Common File for tucbus  (english) and    tucbuss (norwegian)

?-compile('version.pl').

?-compile('monobus.pl').

%?-compile('main.pl').  %?-ensure_loaded( 'main.pl' ).
?-use_module( 'main.pl', [ user:(:=)/2 ] ).

?- (user:internal_aitbusflag := false), %% NB May change <--- ???
%%%%   (user:smspermanentflag := true),  %% SUSPENDED/NOT USED %% 
%%%%   (user:smsflag := true), %% ONLY IF PROPER SMS %% TA-110407
   (user:unix_language := eng),     %% Standard for IDI/NTNU UNIX Solaris )
   (user:origlanguage := norsk),    %%
   (user:language := norsk),        %% Initial default user language  
   (user:duallangflag := true),     %% Also try English if unknown words
   (user:noparentflag := true),     %% Ignore content of parentheses
   (user:nodotflag := false),       %% Interm. dots are  retained 
   (user:tramflag := false),        %% A/S Gråkallen not OK at TEAM
   (user:parsetime_limit := 3000),  %% Fast server
   (user:trace := 0).               %% avoid syntax trees 
%%%%   (user:disablenightbus := true).  %% AD HOC %% TA-040809
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
