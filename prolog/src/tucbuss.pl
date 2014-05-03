/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE tucbuss.pl 
%% SYSTEM BussTUC  DOMAIN TT
%% CREATED  TA-020125
%% REVISED  TA-110301 

%% Makefile for BussTUC  server NTNU, Norwegian version
%:- module( tucbuss, [ hei/0,  run/0 ] ).
% Get from declare!       remember/1,     %% RS-131228    Clever?

%% ?-prolog_flag(unknown,_,fail). %% (Don't?) crash on undefined predicates// Testing

%% RS-131227    UNIT: /
:- ensure_loaded( user:'declare' ). %% RS-111213  General (semantic) Operators
%:-ensure_loaded(user:declare). %%, [ remember/1 ] ). %% for gram_n??, [ output/1, sequence_member/2, value/2  ]).
%% sequence_member/2 is used in tucbuss -> monobuss -> negans.pl
%% RS-131223 Value means TROUBLE! (And for(X,Y) is troublesome too!)


?-  (gpsflag := true), %% NB TEST VERSION, NTNU Server

    (smsflag := false),  %%  NB NTNU server
%   (smsflag := true),  %%  NB NTNU server %% Testing missing neighbourhood mapping for "til lade"

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
%%   (tramflag := true),         %% A/S Gråkallen not OK at TEAM, OK at NTNU      %% RS-131228

   (tmnflag := false),         %%

   (mapflag  := false),         %% (don't) show MAP trace

   (parsetime_limit := 10000),  %% slower server %%  benchmark
   (parsetime_limit := 100000).  %% slower server %%  benchmark

%%%  (notimeoutflag := true),     %% AD HOC !!!!!!!!!!!
%%%       (disablenightbus := true).   %% AD HOC !!!!!!!!!!!

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%:-compile('tucbuses.pl'). %% Sicstus 4 requires *.pl extension
:-use_module('tucbuses.pl', [ makegram/0 ] ). %% Sicstus 4 requires extension

%:-ensure_loaded( version ).       %% RS-131227    With version_date/1, used in monobus -> teledat2.pl
:- ensure_loaded( user:version ).       %% RS-131227    With version_date/1, used in monobus -> teledat2.pl

:- use_module('main.pl', [  hei/0,   hi/0,      run/0 ] ). %% RS-140209    %?-compile('main.pl').  
:-user:use_module( main, [ jettyrun/1 ] ).      %% RS-140331    % Import into user: ("main") module.

?-compile('monobus.pl'). %% // after main.pl  Unknown error 

/*   COMPILE FILE OVERVIEW
 create_busstuc  (Unix command)
     compile_busstuc.pl
        busstuc.pl
           tucbuss.pl
               tucbuses.pl
                   user:declare.pl      (in module user:)
                   utility/ *.pl
                                   (sicstuc.pl)
                   tuc/ *.pl
                   tuc/gram_n.pl
                   tuc/gram_e.pl
                      ?-compile_english.                  
                      ?-compile_norsk.
               main.pl        %% RS-140101
               monobus.pl
                   app/...pl
                   database/...pl
           busroute.pl
*/   
