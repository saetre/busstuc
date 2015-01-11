%% FILE busroute.pl
%% SYSTEM BusTUC  DOMAIN TT
%% CREATED TA-050112
%% REVISED TA-110302

%% OBSOLETE? RS-150104   Handled by makeauxtables?

%% The (main?) TT file for the route database
%%:-module( busroute, [  compile_route_set/1,  consult_periodset/1 ] ).   %% RS-131227    From compileroute
%:- module( busroute, [  consult_periodset/1  ] ).   %% RS-131227    From compileroute
:- module( busroute, [ ] ). %%create_regcut/1 ] ).   %% RS-140511    From compileroute

%% UNIT: /db/
%% Ny linje %:- ensure_loaded('db/route_period').        

%:- use_module('db/statcoord2.pl', [ statcoord/4 ] ). %% RS-120802

%:- prolog_flag(discontiguous_warnings,_,off). 

%:- use_module( 'interfaceroute.pl', [ domain_module/2 ] ). %% Interface modules


%%% COMPILE ALL(?) THE BUS ROUTES NOW %%% RS-111224
%:- compile('compileroute.pl').   %% Bootstrapping for compilation, faster than "ensure loaded"?!
%:- use_module( 'compileroute.pl', [ consultbase/1 ] ). %% Interface modules.  %% RS-111213  for  consultbase(tt). ?  Moved (back) to makeauxtables?
:- use_module( 'compileroute.pl', [ ] ). %% Interface modules.  %% RS-111213  for  consultbase(tt). ?  Moved (back) to makeauxtables?

%:- consultbase(tt). %% <-------------- %% TA-110302   %% Bootstrapped for compilation, Already called from makeauxtables!

