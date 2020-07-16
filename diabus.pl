%% FILE diabus.pl
%% SYSTEM BUSTER
%% CREATED  TA-031114
%% REVISED  TA-110727

:-module( diabus, [ ] ).

% Compiles the BUS files for BUSTER

%% :- compile( 'db/discrepancies.pl').  %% NB Ad Hoc Swap routeplan data

:- use_module( 'app/pragma.pl', [] ).
%%:- compile( 'app/bustrans.pl', [] ).    %% 
%:- use_module( 'app/bustrans.pl', [] ).  %% RS-131225 Don't get too much! , RS-140210 
%:-compile( 'app/dmeq.pl', [] ).        %% 
:- use_module( 'app/dmeq.pl', [] ).    %% RS-140102. Import all predicates from this module!
:- use_module( 'app/busans.pl', [] ).      %% RS-130624
:- use_module( 'app/negans.pl', [] ).      %%
%:- use_module( 'app/busanshp.pl', [] ).    %%RS-131225, 140210

%:- use_module( 'app/interapp.pl', [] ).

:- use_module( 'db/timedat.pl', [] ).  %% TA-110407
:- use_module( 'db/teledat2.pl', [] ). %% Mandatory
:- use_module( 'db/busdat.pl', [] ).   %% split, Trondheim. use_module %% RS-130624
:- use_module( 'db/places.pl', [] ).  
:- use_module( 'db/auxtables.pl', [] ). 
%:- use_module( 'db/namehashtable.pl', [toredef/3] ). %% compile is too expensive?
:- use_module( 'db/statcoord3.pl', [] ).    %% [ statcoord ] TA-110317 %% RS-131225

%:- use_module( 'app/buslog.pl', [] ).  %% Compile LAST, undetected ERROR(?)


%%%%%%% THE END %%%%%%%%%%%%%%%%%%%%%%%%%
