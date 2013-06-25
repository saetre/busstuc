%% FILE diabus.pl
%% SYSTEM BUSTER
%% CREATED  TA-031114
%% REVISED  TA-110727

% Compiles the bus files for BUSTER

:- compile('db/discrepancies.pl').  %% NB Ad Hoc Swap routeplan data

:- compile('app/pragma.pl').
:- compile('app/interapp.pl').
%%:- compile('app/bustrans.pl').    %% 
:- use_module('app/bustrans.pl').    %% 
:- compile('app/dmeq.pl').        %% 
:- use_module('app/busans.pl').      %% RS-130624
:- compile('app/negans.pl').      %%
:- compile('app/busanshp.pl').    %%

:- compile('db/timedat.pl').  %% TA-110407
:- compile('db/teledat2.pl'). %% Mandatory
:- use_module('db/busdat.pl').   %% split, Trondheim. use_module %% RS-130624
:- compile('db/places.pl').  
:- compile('db/auxtables.pl').  
:- consult('db/namehashtable.pl'). %% compile is too expensive  
:- consult('db/statcoord2.pl').    %% TA-110317

:- compile('app/buslog.pl').  %% Compile LAST, undetected ERROR(?)



%%%%%%% THE END %%%%%%%%%%%%%%%%%%%%%%%%%
