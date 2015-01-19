/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE tucbuster.pl
%% SYSTEM BUSTER
%% CREATED ØF-000101
%% REVISED TA-090828


%% Compiles all  the necessary files for

%% BUSTER Dialog Versjon
:-module( tucbuster, [ dialog/0, run/0 ] ). %% Not module! Compile in "user:" module?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Based on:  database/busroute.pl is compiled

%%% ?-prolog_flag(unknown,_,fail). %% (Don't?) crash on undefined predicates %% TA-031106

:- use_module( declare, [ ( := )/2 ] ). %% RS-131227 Avoid loop?
%?-compile('bustermain2.pl'). %% NEW, TELE COMPATIBLE  
:- use_module( bustermain2, [ dialog/0, run/0 ] ). %% NEW, TELE COMPATIBLE
%:- use_module( main, [ dialog/0, run/0 ] ). %% RS-131227 Avoid loop?


%:-volatile lastday/2 . %% RS-130331
%:-dynamic lastday/2 . %% TA-050723

%:-compile( 'tucbuses.pl' ). %% OR compile ( 'dialog/d_call' ). ?? RS-141002
:- use_module( tucbuses, [  ] ). %% RS-131227 Avoid loop?

%?-compile('busterversion.pl'). 
?-use_module( 'busterversion.pl', [ ] ).

%?-compile('tele2.pl'). %% specific tele programs %% TA-051116
?-use_module( 'tele2.pl', [ ] ). %% specific tele programs %% TA-051116

%?-compile( 'diabus.pl' ). 
:-use_module( diabus, [ ] ).    %% RS-150119

:-compile( 'dialog/d_call.pl' ). %% diolog/0, etc.?
%:-ensure_loaded( 'dialog/d_call.pl' ). %% create_splitacts/x, etc.?


?- ( smspermanentflag := true), 

   ( smsflag := true),

   ( unix_language := eng),     %% Standard for IDI/NTNU UNIX Solaris )
       
   ( language := norsk),        %% Initial default user language  

%%    ( duallangflag := false),    %% // NOT DEVELOPED YET// Also try English if unknown words
%%                                 %% defined in resp. compile file

   (duallangflag := true), %% speech based, 
                          %% but SR will never(?) produce english words.


   ( noparentflag := true),     %% Ignore content of parentheses

   ( single_sentence := false), %%  Multiple sentences, 

%%%%    ( nodotflag := true),       %%  Interm. dots are  removed. %% TA-080928

   ( tramflag := false),        %% A/S Gråkallen not OK at TEAM

   ( parsetime_limit := 7000), %% TA-041218

   ( movieflag := false ),     %% TA-030406

   ( wozflag := true),         %% Not into TABUSS modus

   ( notimeoutflag := false),  %% OK Sicstus 3.10

   ( useexternal := true).     %% for the combine  %% TA-051017

%%%    ( disablenightbus := true).  %% TA-061129  %% AD HOC
