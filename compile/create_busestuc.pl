%% FILE create_busestuc.pl
%% SYSTEM BUSSTUC
%% CREATED TA-000621


% Compiles the BusstUC system and creates a save-state busestuc

?-compile('database/busroute'),
  compile(tucbuss),
  save_program(busestuc),
  halt.

