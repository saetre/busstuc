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
?-use_module( 'main.pl', [ (:=)/2 ] ).

?- (main:internal_aitbusflag := false), %% NB May change <--- ???
%%%%   (main:smspermanentflag := true),  %% SUSPENDED/NOT USED %% 
%%%%   (main:smsflag := true), %% ONLY IF PROPER SMS %% TA-110407
   (main:unix_language := eng),     %% Standard for IDI/NTNU UNIX Solaris )
   (main:origlanguage := norsk),    %%
   (main:language := norsk),        %% Initial default user language  
   (main:duallangflag := true),     %% Also try English if unknown words
   (main:noparentflag := true),     %% Ignore content of parentheses
   (main:nodotflag := false),       %% Interm. dots are  retained 
   (main:tramflag := false),        %% A/S Gråkallen not OK at TEAM
   (main:parsetime_limit := 3000),  %% Fast server
   (main:trace := 0).               %% avoid syntax trees 
%%%%   (main:disablenightbus := true).  %% AD HOC %% TA-040809
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
