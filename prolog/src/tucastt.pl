%% FILE tucastt.pl 
%% SYSTEM TUC
%% CREATED TA-010127
%% REVISED TA-010327

%% Makefile for BussTUC/ASTT file
%?-prolog_flag(unknown,_,fail).  %% Don't crash on undefined predicates

%% RS-111205, UNIT: /
:- ensure_loaded( declare ).
:- use_module( interfaceroute, [  current_period/4,  decide_period/2,  default_period/3  ] ).
:- use_module( main, [   (:=)/2, dmeq/2,  myflags/2,  progtrace/2,  set/2  ] ).
:- use_module( tucbuses, [  dict_module/1  ] ).

%?-compile(tucbuses).
?-use_module( tucbuses, [] ).   % Common File for tucbus  (english) and    tucbuss (norwegian)


?- (unix_language := eng),  %% Standard for IDI/NTNU UNIX Solaris )
   (language := norsk),     %% Initial default user language  
   (duallangflag := true),  %% Also try English if unknown words
   (noparentflag := true),  %% Ignore content of parentheses
   (tramflag := false),     %% They don't like A/S Gråkallen
   (parsetime_limit := 10000).  %% 333 Mhz

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
