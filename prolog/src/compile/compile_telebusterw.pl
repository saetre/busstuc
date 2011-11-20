%% FILE compile_telebusterw.pl
%% SYSTEM BUSSTUC
%% CREATED  TA-051001
%% REVISED  TA-071026

% Compiles the BusstUC system and creates a save-state telebuster.sav

?-
  compile('telebusterw.pl'),

  compile('busroute.pl'),
  save_program(telebuster),
  halt. 

