%% FILE create_busestuc.pl
%% SYSTEM BUSSTUC
%% CREATED TA-000621


% Compiles the BusstUC system and creates a save-state busestuc

%?-compile('../busroute').
?-use_module( '../busroute.pl', [] ). %% RS-140207
?-compile('../tucbuss').
?-save_program(busestuc).
?-halt.

