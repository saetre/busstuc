/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE smstuc.pl 
%% SYSTEM TUC
%% CREATED  TA-020125
%% REVISED  RS-120416

%% Makefile for SMSTUC   server, Whole

?-prolog_flag(unknown,_,fail).

?-nodebug.      %% RS-120416, To speed up things

%% ?-[sicstus4compatibility],   %% Only used in drucke_baum

?-   ['tucsms.pl'].
?-   ['busroute.pl'].
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

