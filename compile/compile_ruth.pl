%% FILE compile_ruth.pl
%% SYSTEM BUSSTUC
%% CREATED TA-040615
%% REVISED TA-071026

% Compiles the RUTH system for NTNU server.
% same program as Buster

?-compile('../tucbuster.pl').  %%
?-['../busroute.pl']. %% TA-070811

?- save_program(ruth).
?- halt.

