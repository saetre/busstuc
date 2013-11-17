%% FILE busroute.pl
%% SYSTEM BusTUC  DOMAIN TT
%% CREATED TA-050112
%% REVISED TA-110302

%% The main file for the route database


%% :-prolog_flag(discontiguous_warnings,_,off). 

:- ensure_loaded( compileroute ).
%From Compileroute %% RS-111224
%consultbase(TT):- %% TA-110301
%   ta_for(compilerouteaux(TT,Z), 
%          compile(Z)), %% TA-110302
%   ta_for(routedomain(X), 
%          consult_periodset(X)).



?-compile('interfaceroute.pl'). %% Interface modules

?-compile('compileroute.pl').   %% Bootstrapping for compilation
    
?-compile('db/statcoord2.pl').  %% RS-120802 

?-compile('db/topreg.pl').      %% Main Table for Route Modules
    

%%% COMPILE ALL THE BUS ROUTES NOW %%% RS-111224
:- consultbase(tt). %% <-------------- %% TA-110302

