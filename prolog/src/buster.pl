%% FILE buster.pl
%% SYSTEM BUSTER
%% CREATED TA-040823
%% REVISED TA-071026


:- module( buster,  [ dialog/0, run/0 ] ).
%% Creates the whole Buster system from scratch


/*

BUSTER  is built upon the BUSTUC  system, and share a set of files.

These files are Headed by SYSTEM BUSTER

All others are labeled BUSSTUC (or TUC)

The unique files of BUSTER are

             busterversion.pl       %

             bustermain.pl

             diabus.pl

             dialog/ *               Whole  catalog

*/


%?-compile( tucbuster ). %% TA-071026
:-use_module( 'tucbuster.pl', [ dialog/0, run/0 ] ).   %% :-[tuctele]. %%% // Tele things %% TA-051018

%?-use_module('busroute.pl').    %% RS-140102. Import all predicates from this module!
?-use_module('busroute.pl').    %% RS-140102. Import all predicates from this module!



