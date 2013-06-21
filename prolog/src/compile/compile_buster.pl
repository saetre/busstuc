%% FILE compile_buster.pl
%% SYSTEM BUSSTUC
%% CREATED TA-040615
%% REVISED TA-070811

% Compiles the RUTH system for NTNU server.

?-compile('../buster.pl'), %% TA-070811
  save_program(buster),
  halt.

