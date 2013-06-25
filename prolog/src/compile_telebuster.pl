%% FILE compile_telebuster.pl
%% SYSTEM BUSSTUC
%% CREATED  TA-051001
%% REVISED  TA-060126

% Compiles the BusstUC system and creates a save-state telebuster.sav

%%%  compile('database/busroute'). %% -> telebuster.pl %% TA-060126

?-compile('telebuster.pl').
?-save_program('telebuster.sav').
?-halt.


