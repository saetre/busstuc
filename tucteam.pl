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


?- (unix_language := eng),      %% Standard for IDI/NTNU UNIX Solaris 
   (origlanguage := norsk),     %% TA-040626 
   (language := norsk),         %% Initial default user language  
   (duallangflag := true),      %% Also try English if unknown words
   (noparentflag := true),      %% Ignore content of parentheses
   (tramflag := false),         %% They don't like A/S Gr�kallen
   (nodotflag := true),         %% Readymade Q: N�r g�r bussen fra ....
   (parsetime_limit := 10000),  %% 333 Mhz
   (trace := 0).                %% avoid syntax trees
%%    (disablenightbus := true).  %% AD HOC %% TA-040809

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
