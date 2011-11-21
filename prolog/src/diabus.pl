%% FILE diabus.pl
%% SYSTEM BUSTER
%% CREATED  TA-031114
%% REVISED  TA-110727

% Compiles the bus files for BUSTER

:- compile('db/discrepancies.pl').  %% NB Ad Hoc Swap routeplan data

:- compile('app/pragma.pl').
:- compile('app/interapp.pl').
:- use_module('app/bustrans.pl').    %% 
:- compile('app/dmeq.pl').        %% 
:- use_module('app/busans.pl').      %%
:- compile('app/negans.pl').      %%
:- use_module('app/busanshp.pl').    %%

:- use_module('db/timedat.pl').  %% TA-110407
:- compile('db/teledat2.pl'). %% Mandatory
:- use_module('db/busdat.pl').   %% split, Trondheim
:- use_module('db/places.pl').  
:- compile('db/auxtables.pl').  
:- consult('db/namehashtable.pl'). %% compile is too expensive  
:- consult('db/statcoord2.pl').    %% TA-110317

:- use_module('app/buslog.pl').  %% Compile LAST, undetected ERROR(?)



%%%%%%% THE END %%%%%%%%%%%%%%%%%%%%%%%%%
