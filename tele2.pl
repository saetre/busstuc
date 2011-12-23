%% FILE tele2.pl 
%% SYSTEM TUC
%% AUTHOR T.Amble
%% CREATED TA-020605
%% REVISED TA-080818

%% Compile files specific for TELE

% Compiles the tele files

?-compile('xmlparser.pl').  

?-compile('getphonedir.pl').

%%  ?- compile('app/teletrans.pl').  <-- compiled by diabus.pl %% TA-080818

?- compile('tagger/tagger.pl').




%%%%%%% THE END %%%%%%%%%%%%%%%%%%%%%%%%%
