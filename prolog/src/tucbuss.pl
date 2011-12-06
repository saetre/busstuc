%% FILE tucbuss.pl
%% SYSTEM BussTUC  DOMAIN TT
%% CREATED  TA-020125
%% REVISED  TA-110301

%% Makefile for BussTUC  server NTNU, Norwegian version


%% ?-prolog_flag(unknown,_,fail). %% Don't crash on undefined predicates// Testing

:- ensure_loaded( 'declare' ).

?-use_module( tucbuses, [] ).   % Common File for tucbus  (english) and    tucbuss (norwegian)

?-use_module( 'version.pl', [] ).

?-use_module( 'main.pl', [ run/0 ] ).
%?-ensure_loaded( 'main.pl' ).

?-compile('monobus.pl'). %% // after main.pl  Unknown error

?-((main:gpsflag := true),          %% NB TEST VERSION, NTNU Server
  (main:smsflag := false),          %%  NB NTNU server
%%(main:internal_airbusflag := true), %% TA-101101 // No. Included pro forma
  (main:origlanguage := norsk),     %%
  (main:language := norsk),         %% Initial default user language
  (main:actual_domain := tt),       %% TA-110301
  (main:smspermanentflag := false), %% only web
  (main:unix_language := eng),      %% Standard for IDI/NTNU UNIX Solaris )
  (main:duallangflag := true),      %% Also try English if unknown words
  (main:noparentflag := true),      %% Ignore content of parentheses
  (main:nodotflag := false),        %% Intermediate dots are retained
%%(main:nodotflag := true),         %% Interm. dots are  removed
  (main:tramflag := false),         %% A/S Gråkallen not OK at TEAM, OK at NTNU
  (main:mapflag := false),         %% dont show MAP trace
  (main:parsetime_limit := 10000)).  %% slower server %%  benchmark
%%(main:disablenightbus := true).   %% AD HOC !!!!!!!!!!!
%%(main:notimeoutflag := true),


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


