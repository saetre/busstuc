/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE busstuc.pl 
%% SYSTEM TUC
%% CREATED  TA-020125   %% REVISED  TA-110804 RS-120803
%% REVISED  RS-140101 modularized

%% Makefile for BussTUC  server NTNU , Norwegian


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                     %
% TUC - The Understanding Computer                    %
%                                                     %
% A General Natural Language                          %
%     Understanding System                            %
%                                                     %
% COPYRIGHT  (C) 2001 - 2012  Tore Amble              %
% COPYRIGHT  (C) 2012 -       Rune Sætre              %
%  Group of Logic and Language Technology             %
%  Department of Computer and Information Science     %
%  The Norwegian University of Science and Technology %
%                                                     %
%  satre@idi.ntnu.no                                  %
%                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                     %
% Documentation: TUC_manual Version   Version   21.4  %
%                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ?-prolog_flag(unknown,_,fail). %% (Don't?) crash on undefined predicates// Testing

%:- ensure_loaded( user:'declare' ). %% RS-111213  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) :- X := Y .

:- use_module( main, [ dialog/0, hei/0, hi/0, jettyrun/1, r/1, run/0, spyr/1, status/0 ] ). %% RS-140209    %?-compile('main.pl').

:- use_module( makeauxtables, [ createhash/0, makeauxtables/0, verify_consistency/0 ] ).  %% No longer runs makeauxtables/0 !?!

%:-use_module( 'tucbuss.pl', [ hei/0, run/0 ] ).   %% Compiles tucbuses (norsk and english)

%% RS-141107    UNIT: /tuc/
%:- use_module( 'tuc/metacomp.pl', [ makegram/1 ] ). %% RS-141024


%Busroute is already compiled from  monobus -> makeauxtables -> busroute?
%:-use_module('busroute.pl', [] ).   %% Compiles database/* %   'busroute.pl', %% Compiles database/
%:- load_files('busroute.pl', [ load_type(source), compilation_mode(compile) ]). %:-compile('busroute.pl'). %% Compiles database/* % 

%Utility
%:- use_module( 'utility/utility.pl', [  ] ).     %%RS-141015    Make sure all the  :-meta_predicates  are declared
:- use_module( 'utility/extracut.pl', [ create_regcut/1 ] ).     %%RS-140511 This file is imported INTO THE busroute.pl-module


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%:- makegram( 'tuc/' ).

:- compile( tucbuss ). %%, [ hei/0, run/0, etc. ] ). RS-130329 Make sure (gram/lang) modules are available: dcg_module, 

:- notrace.      %% RS-131225   == nodebug, ...because it is SLOW (1 minute!)
:- write('%busstuc.pl~60  (Turn of DEBUG and Skipping?) consistency check and creation of db/ auxtable(s) and (name-)hashtable, etc...'),nl.

:- verify_consistency. %% RS-140420  Between current and previous period?     
:- makeauxtables. %% RS-130330       Takes a minute...         %%Skip for now...  makeauxtables:
:- createhash.    %% RS-130330       Takes another minute...   %% Produce the db/namehashtable  makeauxtables:
:- told.            %% RS-140208 Reset all output-streams first...

%% Already compiled by tucbuss -> monobuss! %?- [ 'db/discrepancies.pl' ].  %% Must be updated before winter %% TA -> RS-120805 Se e-post korrespondansen til Tore
%:- load_files('busroute.pl', [load_type(source),compilation_mode(compile)]).    %% RS-140210    Bootstrapping for fast compilation!

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
