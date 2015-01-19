%% FILE sicstuc.pl   
%% SYSTEM TUC
%% AUTHOR T.Amble
%% CREATED TA-940819
%% REVISED TA-980115

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
%  toreamb@idi.ntnu.no 
                               %
%                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:-module( sicstuc, [ legal_language/1, language/1, readfile_extension/1, script_file/1 ] ). %% prompt/1, %% RS-150119

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                     %
% Documentation: TUC_manual Version   Version   21.4  %
%                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%:- ensure_loaded( user:'declare' ). %% RS-111213 General (semantic) Operators
:-use_module( declare, [ language/1 ] ). %% RS-111213 General (semantic) Operators

%% Generic SICSTUS  version of TUC 

%% Common to UNIX Sicstus and DOS Sicstus

%% Calls tuc.pl  

legal_language(english).
legal_language(norsk). %% NB not 'norwegian'

%language(L) :- value( language, L ). %% value(language,X) should have been set dynamically by now! Moved to utility...?

script_file(S):-
    language(L),script_file(L,S).

script_file(english,facts_e).
script_file(norsk,  facts_n).

readfile_extension(english, '.e').
readfile_extension(norsk,   '.n').



readfile_extension(X) :-
    language(L),
    readfile_extension(L,X).

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

%?-compile('old/tuc'). %% TA-980115

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
