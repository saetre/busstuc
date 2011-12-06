%% FILE diabus.pl
%% SYSTEM BUSTER
%% CREATED  TA-031114
%% REVISED  TA-110727

% Compiles the bus files for BUSTER

:- use_module( 'db/discrepancies.pl', [] ).  %% NB Ad Hoc Swap routeplan data

:- use_module( 'app/pragma.pl', [] ).
:- use_module( 'app/interapp.pl', [] ).
:- use_module( 'app/bustrans.pl', [] ).    %% 
:- use_module( 'app/dmeq.pl', []).        %% 
:- use_module( 'app/busans.pl', [] ).      %%
:- use_module( 'app/busanshp.pl', [] ).    %%
:- use_module( 'app/negans.pl', [] ).      %%

:- use_module( 'db/timedat.pl').  %% TA-110407
:- use_module( 'db/teledat2.pl'). %% Mandatory
:- use_module( 'db/busdat.pl').   %% split, Trondheim
:- use_module( 'db/places.pl').  
:- use_module( 'db/auxtables.pl').
%:- consult(    'db/namehashtable.pl'). %% compile is too expensive  
:- use_module( 'db/namehashtable.pl', [] ). %% compile is too expensive  
:- use_module( 'db/statcoord2.pl', [] ).    %% TA-110317

:- use_module('app/buslog.pl').  %% Compile LAST, undetected ERROR(?)



%%%%%%% THE END %%%%%%%%%%%%%%%%%%%%%%%%%
