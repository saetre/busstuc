%% FILE tucteam.pl 
%% SYSTEM TUC
%% CREATED TA-010127
%% REVISED TA-061117

%% %% Makefile for TEAMTUC   server, Incrementally
%?-prolog_flag(unknown,_,fail). %% Don't crash on undefined predicates

%% Operators used by TUC
:- ensure_loaded( 'declare' ).

?-use_module( tucbuses, [] ).   % Common File for tucbus  (english) and    tucbuss (norwegian)

?-compile('version.pl'). %% TA-031117

?-compile('monobus.pl'). %% TA-031115

%?-compile('main.pl').    %% TA-031115
?-use_module( 'main.pl', [ user:(:=)/2 ] ).
%?-ensure_loaded( 'main.pl' ).


?- (user:unix_language := eng),      %% Standard for IDI/NTNU UNIX Solaris 
   (user:origlanguage := norsk),     %% TA-040626 
   (user:language := norsk),         %% Initial default user language  
   (user:duallangflag := true),      %% Also try English if unknown words
   (user:noparentflag := true),      %% Ignore content of parentheses
   (user:tramflag := false),         %% They don't like A/S Gråkallen
   (user:nodotflag := true),         %% Readymade Q: Når går bussen fra ....
   (user:parsetime_limit := 10000),  %% 333 Mhz
   (user:trace := 0).                %% avoid syntax trees
%%    (user:disablenightbus := true).  %% AD HOC %% TA-040809

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
