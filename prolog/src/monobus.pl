%% FILE monobus.pl
%% SYSTEM TUC
%% CREATED TA-031114
%% REVISED TA-110727

% Compiles the bus files

 :-prolog_flag(redefine_warnings,_,off). %% Avoiding conflicts (buslog/monobus etc.)

%% annoying when recompiling files by soft links 

%% :- compile('db/discrepancies.pl').  %% NB Ad Hoc Swap routeplan data

:- compile('app/pragma.pl').
:- compile('app/interapp.pl').
:- use_module('app/bustrans.pl').    %% 
:- compile('app/dmeq.pl').        %% 
:- use_module('app/busans').      %% Module ans:
:- compile('app/negans.pl').      %%
:- use_module('app/busanshp.pl').    %%

:- use_module('db/timedat.pl'). %% TA-110407, Module timedat
:- ensure_loaded('db/teledat2.pl').   %% Mandatory
%:- compile('db/busdat.pl').    %% split, Trondheim
:- use_module('db/busdat.pl').  %% RS-111120, Module busdat

%:- compile('db/places.pl').
:- use_module('db/places.pl').
:- compile('db/auxtables.pl').
:- consult('db/namehashtable.pl'). %% compile is too expensive  
:- consult('db/statcoord2.pl').

:- ['interfaceroute']. %%Buslog conflict?
:- use_module('app/buslog.pl').  %% Compile LAST, undetected ERROR(?)



%%%%%%% THE END %%%%%%%%%%%%%%%%%%%%%%%%%
