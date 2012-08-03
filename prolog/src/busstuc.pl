/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE busstuc.pl 
%% SYSTEM TUC
%% CREATED  TA-020125
%% REVISED  TA-110804 RS-120803

%% Makefile for BussTUC  server NTNU , Norwegian


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                     %
% TUC - The Understanding Computer                    %
%                                                     %
%                                                     %
% A General Natural Language                          %
%     Understanding System                            %
%                                                     %
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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                     %
% Documentation: TUC_manual Version   Version   21.4  %
%                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ?-prolog_flag(unknown,_,fail). %% Don't crash on undefined predicates// Testing

?- %% [sicstus4compatibility], loaded in drucke_baum

   ['tucbuss.pl'],

   ['busroute.pl'], %% Compiles database/

   ['db/discrepancies.pl']. %% Must be updated before winter


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


