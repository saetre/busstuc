%% FILE tucbuster.pl
%% SYSTEM BUSTER
%% CREATED ØF-000101
%% REVISED TA-090828

%% Compiles all  the necessary files.
%% Based on  database/busroute.pl is compiled

%%%%%% ?-prolog_flag(unknown,_,fail). %% Don't crash on undefined predicates %% TA-031106

:-volatile lastday/2 . %% TA-050723
:-dynamic lastday/2 . %% TA-050723

%?-compile('tucbuses.pl').
?-use_module( tucbuses, [] ).   % Common File for tucbus  (english) and    tucbuss (norwegian)

?-compile('busterversion.pl'). 
?-compile('diabus.pl'). 
?-use_module( bustermain2 ). %% NEW, TELE COMPATIBLE  
?-compile('tele2.pl'). %% specific tele programs %% TA-051116

%%%%   :-compile('dialog/d_call.pl').
%%%%

?- ( main:smspermanentflag := true), 
   ( main:smsflag := true),
   ( main:unix_language := eng),     %% Standard for IDI/NTNU UNIX Solaris )
      
   ( main:language := norsk),        %% Initial default user language  
%%    ( main:duallangflag := false),    %% // NOT DEVELOPED YET// Also try English if unknown words
%%                                 %% defined in resp. compile file
   (main:duallangflag := true), %% speech based, 
                          %% but SR will never(?) produce english words.

   ( main:noparentflag := true),     %% Ignore content of parentheses
   ( main:single_sentence := false), %%  Multiple sentences, 
%%%%    ( main:nodotflag := true),       %%  Interm. dots are  removed. %% TA-080928
   ( main:tramflag := false),        %% A/S Gråkallen not OK at TEAM
   ( main:parsetime_limit := 7000), %% TA-041218
   ( main:movieflag := false ),     %% TA-030406
   ( main:wozflag := true),         %% Not into TABUSS modus
   ( main:notimeoutflag := false),  %% OK Sicstus 3.10
   ( main:useexternal := true).     %% for the combine  %% TA-051017
%%%    ( main:disablenightbus := true).  %% TA-061129  %% AD HOC
