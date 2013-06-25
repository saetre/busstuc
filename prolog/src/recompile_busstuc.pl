%% FILE recompile_busstuc.pl
%% SYSTEM BUSSTUC
%% CREATED TA-090321
%% REVISED TA-090321

% Compiles the BussTUC system for NTNU server.

?-compile('busstuc.pl').
?-save_program(busestuc).
?-halt.

