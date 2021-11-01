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
% COPYRIGHT  (C) 2001 - 2012  Tore Amble (LingIT)     %
% COPYRIGHT  (C) 2012 - 2019  Rune Sætre (NTNU)       %
%  Group of Logic and Language Technology             %
%  Department of Computer and Information Science     %
%  The Norwegian University of Science and Technology %
%                                                     %
%  satre@idi.ntnu.no                                  %
%                                                     %
% Documentation: TUC_manual Version   Version   21.4  %
%                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ?-prolog_flag(unknown,_,fail). %% Don't? crash on undefined predicates// Testing

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%:- ensure_loaded( user:'declare' ). %% RS-111213  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) :- X := Y .
:- use_module( main, [ hei/0, hi/0, jettyrun/1, r/1, run/0, spyr/1, status/0 ] ). %% RS-140209    %?-compile('main.pl'). % dialog/0, 


%% RS-141107    UNIT: /tuc/
%:- use_module( 'tuc/metacomp.pl', [ makegram/1 ] ). %% RS-141024


%% RS-140210 :- load_files(busroute, [load_type(source),compilation_mode(compile)])  Slow compilation -> Fast runtime?!
%% RS-150104 Busroute is already compiled from  tucbuss -> monobus -> makeauxtables -> busroute? 'busroute.pl', Compiles database db/tables/*
:- use_module( busroute, [] ).
%?- [ 'db/discrepancies.pl' ].  %% Must be updated before winter %% TA -> RS-120805 Se e-post korrespondansen til Tore

%:- use_module( 'utility/utility.pl', [  ] ).     %%RS-141015    Make sure all the  :-meta_predicates  are declared


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%:- makegram( 'tuc/' ). %% RS-150104 Done by metacomp.pl?

%:-use_module( 'tucbuss.pl', [ hei/0, run/0 ] ).   %% Compiles tucbuses (norsk and english)
:- compile( tucbuss ). %%, [ hei/0, run/0, etc. ] ). RS-130329 Make sure (gram/lang) modules are available: dcg_module, 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DB Section (1. first create auxiliary db-files)
%%
%% RS-150103 This must be done before tucbuss -> facts.pl is compiled (because facts.pl needs unproperstation/1 etc.)
%:- use_module( 'utility/extracut.pl', [ create_regcut/1 ] ).  %% RS-140511 This file is needed when using BusTUC to recompile regcut.pl files
:- use_module( makeauxtables, [ createhash/0, makeauxtables/0, verify_consistency/0 ] ).  %% No longer runs makeauxtables/0 !?! See below...

:- notrace.      %% RS-131225   == nodebug, ...because it is SLOW (1 minute!)
:- write('%busstuc.pl~62  (Turn of DEBUG and Skipping?) consistency check and creation of db/ auxtable(s) and (name-)hashtable, etc...'),nl.

% Copied back into makeauxtables.pl... Verify that it works! Only (first) one should execute!
:- makeauxtables. %% RS-130330       May take a minute...         %%Skip if not needed...  makeauxtables.pl:makeauxtables/0
%:- told.            %% RS-20211031 Reset all output-streams first...
:- createhash.    %% RS-130330       May takes another minute...   %% Produce the db/namehashtable  makeauxtables:xxx, if needed
:- told.            %% RS-140208 Reset all output-streams first...
%:- verify_consistency. %% RS-140420  Between current and previous period?     

%% Bootstrapping for compilation         %% RS-150111  Moved to busroute? No! Done twice? Maybe! Moved to bottom of makeauxtables?
%:- use_module( 'compileroute.pl', [ consultbase/1 ] ). %% Interface modules
%:- consultbase(tt). %% <-------------- %% TA-110302   %% Bootstrapped for compilation, Already called from makeauxtables!

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
