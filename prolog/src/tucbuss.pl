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
%:- ensure_loaded( 'declare' ). %% RS-111213  Operators % AND sequence_member/2 is used in tucbuss -> monobuss -> negans.pl
:- use_module( declare, [ (:=)/2, (=:)/2, set/2, value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .

%:- compile('tucbuses.pl'). %% Sicstus 4 requires *.pl extension
:- use_module( 'tucbuses.pl', [] ). %% Sets the busflag:=true etc...

% :- ensure_loaded( version ).       %% RS-131227    With version_date/1, used in monobus -> teledat2.pl  %% RS-150104 Moved to main!

:- use_module( main, [ hei/0, hi/0, jettyrun/1, r/1, run/0, spyr/1, status/0 ] ). %% RS-140209    %?-compile('main.pl'). (:=)/2,  %dialog/0,  


:- compile( monobus ). %% // after main.pl, to avoid  Unknown error?

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

%   (tramflag := false),         %% A/S Gråkallen not OK at TEAM, OK at NTNU
   (tramflag := true),         %% A/S Gråkallen not OK at TEAM, OK at NTNU      %% RS-131228

   (tmnflag := false),         %%
%   (tmnflag := true),         %% RS-141115  Try to give information about ALL routes!
   (mapflag  := false),         %% (don't) show MAP trace

   (parsetime_limit := 10000).  %% slower server %%  benchmark
%  (parsetime_limit := 100000).  %% slower server %%  benchmark

%%%  (notimeoutflag := true),     %% AD HOC !!!!!!!!!!!
%%%       (disablenightbus := true).   %% AD HOC !!!!!!!!!!!

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


/*   COMPILE FILE OVERVIEW
 create_busstuc  (Unix command)
     compile_busstuc.pl
        busstuc.pl
           utility/utility.pl
           tucbuss.pl
               tucbuses.pl
                   user:declare.pl      (in module user:)
                   utility/ *.pl
                                   (sicstuc.pl)
                   tuc/ *.pl
                   tuc/gram_n.pl
                      ?-compile_norsk.
                   tuc/gram_e.pl
                      ?-compile_english.                  
%                  ?-makegram. (Moved into gram_n/gram_e.pl)
               main.pl        %% RS-140101
               monobus.pl
                   app/...pl
                   database/...pl
           busroute.pl
*/   
