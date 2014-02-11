%% FILE busroute.pl
%% SYSTEM BusTUC  DOMAIN TT
%% CREATED TA-050112
%% REVISED TA-110302

%% The main file for the route database
%%:-module( busroute, [  compile_route_set/1,  consult_periodset/1 ] ).   %% RS-131227    From compileroute
:- module( busroute, [  consult_periodset/1  ] ).   %% RS-131227    From compileroute


%% Ny linje
%:-ensure_loaded('db/route_period').        

%% :-prolog_flag(discontiguous_warnings,_,off). 

:- ensure_loaded( compileroute ). %% RS-111213  for  consultbase(tt). ?
?-compile('compileroute.pl').   %% Bootstrapping for compilation, faster than "ensure loaded"?!

?-use_module( 'interfaceroute.pl' ). %%, [ domain_module/2 ] ). %% Interface modules

%% UNIT: /db/
?-use_module('db/statcoord2.pl').  %% RS-120802 %% [ statcoord ] 

%% Main Table for Route Modules %% RS-140210 Loaded from interfaceroutes / busroute
:-use_module( 'db/topreg.pl' ). %%, [ compilerouteaux/2, route_period/4 ] ). %%, default_message/3,   default_period/3,   routedomain/1 ]).

%%% COMPILE ALL THE BUS ROUTES NOW %%% RS-111224
:- consultbase(tt). %% <-------------- %% TA-110302     Called from compileroute?

