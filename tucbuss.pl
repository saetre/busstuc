%% FILE tucbuss.pl
%% SYSTEM BussTUC  DOMAIN TT
%% CREATED  TA-020125
%% REVISED  TA-110301

%% Makefile for BussTUC  server NTNU, Norwegian version


%% ?-prolog_flag(unknown,_,fail). %% Don't crash on undefined predicates// Testing

:- ensure_loaded( 'declare' ).

?-use_module( tucbuses, [] ).   % Common File for tucbus  (english) and    tucbuss (norwegian)

?-use_module( 'version.pl', [] ).

?-use_module( 'main.pl', [ (:=)/2, run/0 ] ).
%?-ensure_loaded( 'main.pl' ).

?-compile('monobus.pl'). %% // after main.pl  Unknown error

?- (gpsflag := true),          %% NB TEST VERSION, NTNU Server
   (smsflag := false),          %%  NB NTNU server
%% (internal_airbusflag := true), %% TA-101101 // No. Included pro forma
   (origlanguage := norsk),     %%
   (language := norsk),         %% Initial default user language
   (actual_domain := tt),       %% TA-110301
   (smspermanentflag := false), %% only web
   (unix_language := eng),      %% Standard for IDI/NTNU UNIX Solaris )
   (duallangflag := true),      %% Also try English if unknown words
   (noparentflag := true),      %% Ignore content of parentheses
   (nodotflag := false),        %% Intermediate dots are retained
%% (nodotflag := true),         %% Interm. dots are  removed
   (tramflag := false),         %% A/S Gråkallen not OK at TEAM, OK at NTNU
   (mapflag := false),         %% dont show MAP trace
   (parsetime_limit := 10000).  %% slower server %%  benchmark
%% (disablenightbus := true).   %% AD HOC !!!!!!!!!!!
%% (notimeoutflag := true),


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


