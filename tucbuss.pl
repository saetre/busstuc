/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE tucbuss.pl 
%% SYSTEM BussTUC  DOMAIN TT
%% CREATED  TA-020125
%% REVISED  TA-110301 

%% Makefile for BussTUC  server NTNU, Norwegian version


%% ?-prolog_flag(unknown,_,fail). %% Don't crash on undefined predicates// Testing



?-compile('tucbuses.pl'). %% Sicstus 4 requires extension

?-compile('version.pl').

?-compile('main.pl').  

?-compile('monobus.pl'). %% // after main.pl  Unknown error 

?-  (gpsflag := true), %% NB TEST VERSION, NTNU Server

    (smsflag := false),  %%  NB NTNU server
%%    (smsflag := true),  %%  NB NTNU server %% Testing missing neighbourhood mapping for "til lade"

 %%  (internal_airbusflag := true), %% TA-101101 // No. Included pro forma

   (origlanguage := norsk),     %% 

   (language := norsk),         %% Initial default user language  

   (actual_domain := tt),       %% TA-110301

   (smspermanentflag := false), %% only web

   (unix_language := eng),      %% Standard for IDI/NTNU UNIX Solaris )
       
   (duallangflag := true),      %% Also try English if unknown words

   (noparentflag := true),      %% Ignore content of parentheses

   (nodotflag := false),        %% Intermediate dots are retained

%%%%%%%   (nodotflag := true),         %% Interm. dots are  removed

   (tramflag := false),         %% A/S Gråkallen not OK at TEAM, OK at NTNU

   (tmnflag := false),         %%

   (mapflag  := false),         %% (don't) show MAP trace

   (parsetime_limit := 10000),  %% slower server %%  benchmark
   (parsetime_limit := 100000).  %% slower server %%  benchmark

%%%  (notimeoutflag := true),     %% AD HOC !!!!!!!!!!!

%%%       (disablenightbus := true).   %% AD HOC !!!!!!!!!!!


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


