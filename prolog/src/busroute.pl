%% FILE busroute.pl
%% SYSTEM BusTUC  DOMAIN TT
%% CREATED TA-050112
%% REVISED TA-110302

%% The main file for the route database



:-prolog_flag(discontiguous_warnings,_,off). 


?- use_module( interfaceroute, [] ). %% Interface modules

?-compile('compileroute.pl').   %% Bootstrapping for compilation
    
%?-compile('db/statcoord.pl').   %% 
?-use_module( 'db/statcoord.pl', [] ).   %% 

?-use_module( 'db/topreg.pl', [] ).      %% Main Table for Route Modules
    
    :- consultbase(tt). %% <-------------- %% TA-110302







