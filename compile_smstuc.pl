%% FILE compile_smstuc.pl
%% SYSTEM BUSSTUC
%% CREATED TA-020304
%% REVISED TA-021121

% Compiles the BussTUC system for NTNU server.

?-compile('smstuc.pl'), % incudes busroute
  save_program(busestuc),
  halt.

