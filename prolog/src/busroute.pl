%% FILE busroute.pl
%% SYSTEM BusTUC  DOMAIN TT
%% CREATED TA-050112
%% REVISED TA-110302

%% The main file for the route database



:-prolog_flag(discontiguous_warnings,_,off). 


?-compile('interfaceroute.pl'). %% Interface modules

?-compile('compileroute.pl').   %% Bootstrapping for compilation
    
?-compile('db/statcoord.pl').   %% 

?-compile('db/topreg.pl').      %% Main Table for Route Modules
    
    :- consultbase(tt). %% <-------------- %% TA-110302







