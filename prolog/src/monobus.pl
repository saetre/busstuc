%% FILE monobus.pl
%% SYSTEM TUC
%% CREATED TA-031114
%% REVISED TA-110727

% Compiles the bus files

 :-prolog_flag(redefine_warnings,_,off). %% Avoiding conflicts (buslog/monobus etc.)

%% annoying when recompiling files by soft links 

%% :- compile('db/discrepancies.pl').  %% NB Ad Hoc Swap routeplan data

:- use_module( 'app/busans', [] ).      %% Module ans:
:- use_module( 'app/busanshp.pl', [] ).    %%
:- use_module( 'app/buslog.pl', [] ).  %% Compile LAST, undetected ERROR(?)
:- use_module( 'app/bustrans.pl', [] ).    %% 
:- compile(    'app/dmeq.pl').        %%
:- use_module( 'app/interapp.pl', [] ).
:- use_module( 'app/negans.pl', [] ).      %%
:- use_module( 'app/pragma.pl', [] ).

%:- compile(   'db/busdat.pl').    %% split, Trondheim
:- use_module( 'db/busdat.pl').  %% RS-111120, Module busdat
:- use_module( 'db/teledat2.pl').   %% Mandatory
:- use_module( 'db/timedat.pl'). %% TA-110407, Module timedat

%:- compile(   'db/places.pl').
:- use_module( 'db/places.pl', [] ).
:- use_module( 'db/auxtables.pl', [] ).
%:- consult(   'db/namehashtable.pl'). %% compile is too expensive  
:- use_module( 'db/namehashtable.pl', [] ). %% compile is too expensive  
%:- consult(    'db/statcoord2.pl').
:- use_module( 'db/statcoord2.pl', [] ).    %% TA-110317


%%%%%%% THE END %%%%%%%%%%%%%%%%%%%%%%%%%

%:-['../interfaceroute'].       %% RS-111111 Moved "up" from buslog -> 
%:- use_module( interfaceroute, []). %%Buslog conflict?
