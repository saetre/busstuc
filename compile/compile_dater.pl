%% FILE compile_dater.pl
%% SYSTEM BUSSTUC
%% CREATED  TA-060109
%% REVISED  TA-080818

% Compiles the BusstUC system and creates a save-state telebuster.sav

?- compile('../dater.pl').

%?- compile('../busroute.pl'). %% TA-080818
?- use_module( '../busroute.pl', [] ). %% TA-080818

?- save_program(dater).
?- halt.

