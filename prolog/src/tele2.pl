%% FILE tele2.pl 
%% SYSTEM TUC
%% AUTHOR T.Amble
%% CREATED  TA-020605
%% REVISED  TA-080818
%% REVISED  RS-140101 modularized

%% Compile files specific for TELE

%USAGE:
%:-ensure_loaded( user:'../tele2.pl' ).
% Compiles the tele files

?-use_module('xmlparser.pl').   %% RS-140102  

?-use_module(getphonedir, [ ] ).

%%  ?- compile('app/teletrans.pl').  <-- compiled by diabus.pl %% TA-080818

?- compile('tagger/tagger.pl').




%%%%%%% THE END %%%%%%%%%%%%%%%%%%%%%%%%%
