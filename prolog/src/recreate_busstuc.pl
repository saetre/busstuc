%% FILE recompile_busstuc.pl
%% SYSTEM BUSSTUC
%% CREATED TA-090321
%% REVISED TA-090321

% Compiles the BussTUC system for NTNU server.

%% based on a stored version of busroute.sav


 
?- ['tucbuss.pl'].
?-  save_program(busestuc).
?-  halt.

