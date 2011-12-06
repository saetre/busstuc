%% FILE tucbuss.pl
%% SYSTEM BussTUC  DOMAIN TT
%% CREATED  TA-020125
%% REVISED  TA-110301

%% Makefile for BussTUC  server NTNU, Norwegian version


%% ?-prolog_flag(unknown,_,fail). %% Don't crash on undefined predicates// Testing

:- ensure_loaded( 'declare' ).
%?-use_module('declare.pl').

?-use_module( tucbuses, [] ).   % Common File for tucbus  (english) and    tucbuss (norwegian)

?-compile('version.pl').

?-use_module( 'main.pl', [] ).
%?-ensure_loaded( 'main.pl' ).

?-compile('monobus.pl'). %% // after main.pl  Unknown error

?-((user:gpsflag := true),          %% NB TEST VERSION, NTNU Server
  (user:smsflag := false),          %%  NB NTNU server
%%(user:internal_airbusflag := true), %% TA-101101 // No. Included pro forma
  (user:origlanguage := norsk),     %%
  (user:language := norsk),         %% Initial default user language
  (user:actual_domain := tt),       %% TA-110301
  (user:smspermanentflag := false), %% only web
  (user:unix_language := eng),      %% Standard for IDI/NTNU UNIX Solaris )
  (user:duallangflag := true),      %% Also try English if unknown words
  (user:noparentflag := true),      %% Ignore content of parentheses
  (user:nodotflag := false),        %% Intermediate dots are retained
%%(user:nodotflag := true),         %% Interm. dots are  removed
  (user:tramflag := false),         %% A/S Gråkallen not OK at TEAM, OK at NTNU
  (user:mapflag := false),         %% dont show MAP trace
  (user:parsetime_limit := 10000)).  %% slower server %%  benchmark
%%(user:disablenightbus := true).   %% AD HOC !!!!!!!!!!!
%%(user:notimeoutflag := true),


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


