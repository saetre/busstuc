%% FILE tucastt.pl 
%% SYSTEM TUC
%% CREATED TA-010127
%% REVISED TA-010327

%% Makefile for BussTUC/ASTT file
%?-prolog_flag(unknown,_,fail).  %% Don't crash on undefined predicates

:- ensure_loaded( declare ).

%?-compile(tucbuses).
?-use_module( tucbuses, [] ).   % Common File for tucbus  (english) and    tucbuss (norwegian)


?- user:(unix_language := eng),  %% Standard for IDI/NTNU UNIX Solaris )
   user:(language := norsk),     %% Initial default user language  
   user:(duallangflag := true),  %% Also try English if unknown words
   user:(noparentflag := true),  %% Ignore content of parentheses
   user:(tramflag := false),     %% They don't like A/S Gråkallen
   user:(parsetime_limit := 10000).  %% 333 Mhz

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
