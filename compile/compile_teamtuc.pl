%% FILE create_teamtuc.pl
%% SYSTEM BUSSTUC
%% CREATED TA-000621
%% REVISED TA-021121

% Compiles the BusstUC system for A/S TEAM Trafikk  and creates a save-state busestuc

?-compile('teamtuc.pl'), % incuding busroute
  save_program(busestuc),
  halt.

