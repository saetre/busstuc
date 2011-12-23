%% FILE tucastt.pl 
%% SYSTEM TUC
%% CREATED TA-010127
%% REVISED TA-010327

%% Makefile for BussTUC/ASTT file

?-prolog_flag(unknown,_,fail). %% Don't crash on undefined predicates


?-compile(tucbuses). 


?- (unix_language := eng),  %% Standard for IDI/NTNU UNIX Solaris )
       
   (language := norsk),     %% Initial default user language  

   (duallangflag := true),  %% Also try English if unknown words

   (noparentflag := true),  %% Ignore content of parentheses

   (tramflag := false),     %% They don't like A/S Gråkallen

   (parsetime_limit := 10000).  %% 333 Mhz


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


