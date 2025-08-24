%% FILE bus.pl
%% SYSTEM TUC
%% AUTHOR J.Bratseth
%% CREATED JB-960713
%% REVISED JB-961212 TA-010502

% Compiles the bus files

:-prolog_flag(redefine_warnings,_,off).

% :- compile(busroute). % Precompiled as busbase

%RS-120503

%:- compile('../app/pragma.pl').
%:- compile('../app/interapp.pl').
%:- compile('../app/buslog').      %% TA-000529

%%:- compile( '../app/bustrans').    %%
:- use_module( '../app/bustrans').    %%
%%:- compile( '../app/busans').      %%
%:- use_module( '../app/busans').      %% RS-130624
:- use_module( '../app/negans', [ makenegative/3, trytofool/3 ] ).       %% RS-140208

%:- compile('../app/busanshp').    %%

%%:- compile('../db/busdat.pl').
:- use_module('../db/busdat.pl').

%:- compile('../db/auxtables.pl').
:- use_module('../db/auxtables.pl').

% :- createhash.  ( run  separately because of mix)

%:- consult('../db/namehashtable.pl'). %% compile is too expensive

%RS-120503

%%% busroute is compiled separately into a
%%% savestate  busbase


%%%%%%% THE END %%%%%%%%%%%%%%%%%%%%%%%%%
