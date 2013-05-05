%% FILE bus.pl
%% SYSTEM TUC
%% AUTHOR J.Bratseth
%% CREATED JB-960713
%% REVISED JB-961212 TA-010502

% Compiles the bus files

:-prolog_flag(redefine_warnings,_,off).

% :- compile(busroute). % Precompiled as busbase

%RS-120503

:- compile('app/pragma.pl').
:- compile('app/interapp.pl').
:- compile('app/buslog').      %% TA-000529
:- compile('app/bustrans').    %%
:- compile('app/busans').      %%
:- compile('app/negans').      %%
:- compile('app/busanshp').    %%

:- compile('database/busdat.pl').

:- compile('database/auxtables.pl').

% :- createhash.  ( run  separately because of mix)

:- consult('database/namehashtable.pl'). %% compile is too expensive

%RS-120503

%%% busroute is compiled separately into a
%%% savestate  busbase


%%%%%%% THE END %%%%%%%%%%%%%%%%%%%%%%%%%
