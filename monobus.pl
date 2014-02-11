/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE monobus.pl
%% SYSTEM TUC
%% CREATED  TA-031114    %% REVISED TA-110727
%% REVISED  RS-140101 modularized

% Compiles the bus files

%% annoying when recompiling files by soft links?  % :-prolog_flag(redefine_warnings,_,off).

%%:- compile('db/discrepancies.pl').    %% Already included in buslog!
%% NB Ad Hoc Swap routeplan data (Must be done every summer/winter/etc!).

% UNIT: /app/
%:- use_module( 'app/busans.pl', [ ] ). %%:- compile('app/busans.pl').      %% rule/2 conflict with bustrans
:- use_module( 'app/busanshp.pl', [ i_or_a_bus/3 ] ).
%:- compile('app/buslog.pl').  %% Compile LAST, undetected ERROR(?)
:- use_module( 'app/buslog' , [ bus/1, message/1, station/1 ] ).    %% RS-131228   Used in negans.pl!
:- use_module( 'app/bustrans.pl', [ ] ).  %% RS-131225 Don't get too much! %% rule/2 conflicts with busans, use interapp:execute_program?
:- use_module( 'app/pragma.pl' ). %% pragma->telelog    %%RS-140101  see interapp.pl,   Loads pragma !!
:- use_module( 'app/negans.pl' ).  %% [ ] ).     %%
%:- use_module( 'app/telelog.pl', [ bound/1, unbound/1 ]).  %% RS-131228   Used in negans.pl! bustrans-rules, etc. DON'T use tele here?

% UNIT: /db/
:- use_module( 'db/timedat.pl' ).  %% TA-110407   %:- compile('db/timedat.pl').  %% TA-110407
:- use_module( 'db/teledat2.pl' ). %% Mandatory   %% RS-131225
:- use_module( 'db/busdat.pl' ).   %% split, Trondheim: bus details %%:- compile('db/busdat.pl').
%:- use_module( 'db/places.pl' ).  %:- compile('db/places.pl').    %% Included in busroute?!  

%% Compile the tables!  %% RS-131225    %% MakeAuxTables relies on busroute
:-use_module( 'makeauxtables.pl' ).   %% RS-130330    Slow! Takes a couple of minutes...

%%%%%%% THE END %%%%%%%%%%%%%%%%%%%%%%%%%
