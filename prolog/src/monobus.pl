%% FILE monobus.pl
%% SYSTEM TUC
%% CREATED TA-031114
%% REVISED TA-110727

% Compiles the bus files

 :-prolog_flag(redefine_warnings,_,off). %% Avoiding conflicts (buslog/monobus etc.)

%% annoying when recompiling files by soft links 

%% :- compile('db/discrepancies.pl').  %% NB Ad Hoc Swap routeplan data

:- use_module( 'app/busans', [] ).      %% Module ans:
:- use_module( 'app/busanshp', [] ).    %%
:- use_module( 'app/buslog', [] ).  %% Compile LAST, undetected ERROR(?)
:- use_module( 'app/bustrans', [] ).    %% 
:- use_module( 'app/dmeq', [] ).        %%
:- use_module( 'app/interapp', [] ).
:- use_module( 'app/negans', [] ).      %%
:- use_module( 'app/pragma', [] ).

%:- compile(   'db/busdat').    %% split, Trondheim
:- use_module( 'db/busdat').  %% RS-111120, Module busdat
:- use_module( 'db/teledat2').   %% Mandatory
:- use_module( 'db/timedat'). %% TA-110407, Module timedat

%:- compile(   'db/places').
:- use_module( 'db/places', [] ).
:- use_module( 'db/auxtables', [] ).
%:- consult(   'db/namehashtable'). %% compile is too expensive  
:- use_module( 'db/namehashtable', [] ). %% compile is too expensive  
%:- consult(    'db/statcoord2').
:- use_module( 'db/statcoord2', [] ).    %% TA-110317


%%%%%%% THE END %%%%%%%%%%%%%%%%%%%%%%%%%

%:-['../interfaceroute'].       %% RS-111111 Moved "up" from buslog -> 
%:- use_module( interfaceroute, []). %%Buslog conflict?
