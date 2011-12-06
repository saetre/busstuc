%% FILE tucsms.pl 
%% SYSTEM TUC
%% CREATED  TA-020125
%% REVISED  TA-090401


%% Makefile for SMSTUC   server, Incrementally
%?-prolog_flag(unknown,_,fail). %% Don't crash on undefined predicates

%% Operators used by TUC
:- ensure_loaded( 'declare' ).

?-use_module( tucbuses, [] ).   % Common File for tucbus  (english) and    tucbuss (norwegian)

%% RS-111206
:- use_module( version, [ version_date/1 ] ).
%?-compile('version.pl').

?-compile('monobus.pl').

%?-compile('main.pl').  %?-ensure_loaded( 'main.pl' ).
?-use_module( 'main.pl', [ (:=)/2 ] ).

?- (internal_aitbusflag := false), %% NB May change <--- ???
%%%%   (smspermanentflag := true),  %% SUSPENDED/NOT USED %% 
%%%%   (smsflag := true), %% ONLY IF PROPER SMS %% TA-110407
   (unix_language := eng),     %% Standard for IDI/NTNU UNIX Solaris )
   (origlanguage := norsk),    %%
   (language := norsk),        %% Initial default user language  
   (duallangflag := true),     %% Also try English if unknown words
   (noparentflag := true),     %% Ignore content of parentheses
   (nodotflag := false),       %% Interm. dots are  retained 
   (tramflag := false),        %% A/S Gråkallen not OK at TEAM
   (parsetime_limit := 3000),  %% Fast server
   (trace := 0).               %% avoid syntax trees 
%%%%   (disablenightbus := true).  %% AD HOC %% TA-040809
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
