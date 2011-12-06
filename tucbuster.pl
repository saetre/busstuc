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
?-compile('bustermain2.pl'). %% NEW, TELE COMPATIBLE  
?-compile('tele2.pl'). %% specific tele programs %% TA-051116

%%%%   :-compile('dialog/d_call.pl').
%%%%

?- ( user:smspermanentflag := true), 
   ( user:smsflag := true),
   ( user:unix_language := eng),     %% Standard for IDI/NTNU UNIX Solaris )
      
   ( user:language := norsk),        %% Initial default user language  
%%    ( user:duallangflag := false),    %% // NOT DEVELOPED YET// Also try English if unknown words
%%                                 %% defined in resp. compile file
   (user:duallangflag := true), %% speech based, 
                          %% but SR will never(?) produce english words.

   ( user:noparentflag := true),     %% Ignore content of parentheses
   ( user:single_sentence := false), %%  Multiple sentences, 
%%%%    ( user:nodotflag := true),       %%  Interm. dots are  removed. %% TA-080928
   ( user:tramflag := false),        %% A/S Gråkallen not OK at TEAM
   ( user:parsetime_limit := 7000), %% TA-041218
   ( user:movieflag := false ),     %% TA-030406
   ( user:wozflag := true),         %% Not into TABUSS modus
   ( user:notimeoutflag := false),  %% OK Sicstus 3.10
   ( user:useexternal := true).     %% for the combine  %% TA-051017
%%%    ( user:disablenightbus := true).  %% TA-061129  %% AD HOC
