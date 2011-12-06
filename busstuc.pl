%% FILE busstuc.pl 
%% SYSTEM TUC
%% CREATED  TA-020125
%% REVISED  TA-110804

%% Makefile for BussTUC  server NTNU , Norwegian

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                     %
% TUC - The Understanding Computer                    %
%                                                     %
% A General Natural Language                          %
%     Understanding System                            %
%                                                     %
% COPYRIGHT  (C) 2001 -                               %
%                                                     %
%  Tore Amble                                         %
%  Group of Logic and Language Texhnology             %
%  Department of Computer and Information Science     %
%  The Norwegian University of Science and Technology %
%                                                     %
%  toreamb@idi.ntnu.no                                %
%                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:-use_module( library(system), [ environ/2 ] ). 
:-use_module( library(file_systems), [] ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                     %
% Documentation: TUC_manual Version   Version   21.4  %
%                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

?-prolog_flag(unknown,_,fail). %% Don't crash on undefined predicates// Testing

?- %working_directory(Dir,Dir), write(Dir),nl,          %% Sicstus <= 4.1 way
   %% Sicstus >= 4.2 way
   environ('SP_STARTUP_DIR',Dir), write('starting dir: '), write(Dir),nl,
   [sicstus4compatibility],     %% Compatible with sicstus4, new predicates etc.
   ['tucbuss.pl'],              %% Compiles tuc/ etc.
   ['busroute.pl'],             %% Compiles database/
   ['db/discrepancies.pl'].     %% Must be updated before winter

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
