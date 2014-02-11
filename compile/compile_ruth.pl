%% FILE compile_ruth.pl
%% SYSTEM BUSSTUC
%% CREATED TA-040615
%% REVISED TA-071026

% Compiles the RUTH system for NTNU server.
% same program as Buster

%?-compile('../tucbuster.pl').  %%
:- use_module( '../tucbuster.pl', [ ] ).   %% :-[tuctele]. %%% // Tele things %% TA-051018

%?-['../busroute.pl']. %% TA-070811
?-use_module( '../busroute.pl', [] ). %% RS-140207

?- save_program(ruth).
?- halt.

