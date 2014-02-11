%% FILE sicstuc.pl   
%% SYSTEM TUC
%% AUTHOR T.Amble
%% CREATED TA-940819
%% REVISED TA-980115

:- ensure_loaded( user:'declare' ). %% RS-111213 General (semantic) Operators

%% Generic SICSTUS  version of TUC 

%% Common to UNIX Sicstus and DOS Sicstus

%% Calls tuc.pl  

%% Compatibility Predicates

%numbervars(F):-
%    numbervars(F,0,_).
%
%startbatch :- 
%    statistics(runtime,[T,_]),
%    batchstart := T.
%
%takebatch :-
%   statistics(runtime,[T2,_]),
%   batchstart =: T1,
%   Elapse is (T2-T1),
%   out('Total: '),out(Elapse),output(ms). %% TA-980115
%
%starttime :-  
%    statistics(runtime,_).
%
%taketime :- 
%   statistics(runtime,[_,T]), 
%   out(T),output(ms).

?-compile('old/tuc'). %% TA-980115

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
