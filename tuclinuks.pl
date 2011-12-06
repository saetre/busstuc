%% FILE tuclinuks.pl 
%% SYSTEM TUC
%% CREATED   TA-981212
%% REVISED   TA-981212

% Initiation file for BusstUC on Linux 

%% Operators used by TUC
:- ensure_loaded( 'declare' ).
?-use_module( tucbuses, [] ).   % Common File for tucbus  (english) and    tucbuss (norwegian)

%?-compile(tucbuses). % Both languages are compiled

    :-  (user:unix_language := nor).    %% Installation language for  unix
    :-  (user:language := norsk).       %% Initial default user language  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


