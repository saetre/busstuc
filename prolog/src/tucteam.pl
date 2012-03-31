/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE tucteam.pl 
%% SYSTEM TUC
%% CREATED TA-010127
%% REVISED TA-061117

%% %% Makefile for TEAMTUC   server, Incrementally


?-prolog_flag(unknown,_,fail). %% Don't crash on undefined predicates

?-compile('tucbuses.pl'). 

?-compile('version.pl'). %% TA-031117

?-compile('monobus.pl'). %% TA-031115

?-compile('main.pl').    %% TA-031115




?- (unix_language := eng),      %% Standard for IDI/NTNU UNIX Solaris 
       
   (origlanguage := norsk),     %% TA-040626 

   (language := norsk),         %% Initial default user language  

   (duallangflag := true),      %% Also try English if unknown words

   (noparentflag := true),      %% Ignore content of parentheses

   (tramflag := false),         %% They don't like A/S Gråkallen

   (nodotflag := true),         %% Readymade Q: Når går bussen fra ....

   (parsetime_limit := 10000),  %% 333 Mhz

   (trace := 0).                %% avoid syntax trees

%%    (disablenightbus := true).  %% AD HOC %% TA-040809


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


