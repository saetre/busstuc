%% FILE tuclinuks.pl 
%% SYSTEM TUC
%% CREATED   TA-981212
%% REVISED   TA-981212

% Initiation file for BusstUC on Linux 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RS-131227    UNIT: / (FIRST!)
:- ensure_loaded( user:'declare' ). %% RS-111213  General (semantic) Operators

:-use_module( tucbuses ). % Both languages are compiled
:- use_module( main, [ ( := )/2 ] ). %% RS-131227 Avoid loop?

:-  (unix_language := nor).    %% Installation language for  unix

:-  (language := norsk).       %% Initial default user language  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


