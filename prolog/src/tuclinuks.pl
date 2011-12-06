%% FILE tuclinuks.pl 
%% SYSTEM TUC
%% CREATED   TA-981212
%% REVISED   TA-981212

% Initiation file for BusstUC on Linux 

%% Operators used by TUC
%% RS-111205, UNIT: /
:- ensure_loaded( 'declare' ).
:- use_module( main, [   (:=)/2, myflags/2, set/2  ] ).

?-use_module( tucbuses, [] ).   % Common File for tucbus  (english) and    tucbuss (norwegian)

%?-compile(tucbuses). % Both languages are compiled

    :-  (unix_language := nor).    %% Installation language for  unix
    :-  (language := norsk).       %% Initial default user language  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


