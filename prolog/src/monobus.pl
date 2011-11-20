%% FILE monobus.pl
%% SYSTEM TUC
%% CREATED TA-031114
%% REVISED TA-110727

% Compiles the bus files

 :-prolog_flag(redefine_warnings,_,off). 

%% annoying when recompiling files by soft links 



%% :- compile('db/discrepancies.pl').  %% NB Ad Hoc Swap routeplan data


:- compile('app/pragma.pl').
:- compile('app/interapp.pl').
:- compile('app/bustrans.pl').    %% 
:- compile('app/dmeq.pl').        %% 
:- compile('app/busans.pl').      %%
:- compile('app/negans.pl').      %%
:- compile('app/busanshp.pl').    %%

:- compile('db/timedat.pl').  %% TA-110407
:- compile('db/teledat2.pl'). %% Mandatory
:- compile('db/busdat.pl').   %% split, Trondheim

:- compile('db/places.pl').  
:- compile('db/auxtables.pl').  
:- consult('db/namehashtable.pl'). %% compile is too expensive  
:- consult('db/statcoord2.pl').

:- compile('app/buslog.pl').  %% Compile LAST, undetected ERROR(?)



%%%%%%% THE END %%%%%%%%%%%%%%%%%%%%%%%%%
