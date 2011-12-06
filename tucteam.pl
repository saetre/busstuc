%% FILE tucteam.pl 
%% SYSTEM TUC
%% CREATED TA-010127
%% REVISED TA-061117

%% %% Makefile for TEAMTUC   server, Incrementally
%?-prolog_flag(unknown,_,fail). %% Don't crash on undefined predicates

%% Operators used by TUC
:- ensure_loaded( 'declare' ).

?-use_module( tucbuses, [] ).   % Common File for tucbus  (english) and    tucbuss (norwegian)

%% RS-111206
:- use_module( version, [ version_date/1 ] ).
%?-compile('version.pl'). %% TA-031117

?-compile('monobus.pl'). %% TA-031115

%?-compile('main.pl').    %% TA-031115
?-use_module( 'main.pl', [ (:=)/2 ] ).
%?-ensure_loaded( 'main.pl' ).


?- (main:unix_language := eng),      %% Standard for IDI/NTNU UNIX Solaris 
   (main:origlanguage := norsk),     %% TA-040626 
   (main:language := norsk),         %% Initial default user language  
   (main:duallangflag := true),      %% Also try English if unknown words
   (main:noparentflag := true),      %% Ignore content of parentheses
   (main:tramflag := false),         %% They don't like A/S Gråkallen
   (main:nodotflag := true),         %% Readymade Q: Når går bussen fra ....
   (main:parsetime_limit := 10000),  %% 333 Mhz
   (trace := 0).                %% avoid syntax trees
%%    (main:disablenightbus := true).  %% AD HOC %% TA-040809

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
