%% FILE tuc.pl                   
%% SYSTEM TUC
%% AUTHOR T.Amble
%% CREATED TA-921125
%% REVISED TA-000529

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                     %
% TUC - The Understanding Computer                    %
%                                                     %
%                                                     %
% A General Natural Language                          %
%     Understanding System                            %
%                                                     %
%                                                     %
% COPYRIGHT  (C) 2001                                 %
%                                                     %
%  Tore Amble                                         %
%  Knowledge Systems Group                            %
%  Department of Computer and Information Science     %
%  The Norwegian University of Science and Technology %
%                                                     %
%  amble@idi.ntnu.no                                  %
%                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                     %
% Documentation: TUC_manual Version 11.5              %
%                                                     %
%                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Moved back to sicstuc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%legal_language(english).
%legal_language(norsk). %% NB not 'norwegian'
%
%language(L) :- value(language,L). %% Set dynamically
%
%
%dict_module(D):-language(L),dict_module(L,D).
%
%morph_module(D):-language(L),morph_module(L,D).
%
%gram_module(D):-language(L),gram_module(L,D).
%
%dcg_module(U):- language(L),dcg_module(L,U).
%
%dcg_file(U) :-language(L),dcg_file(L,U).
%
%
%script_file(S):-
%    language(L),script_file(L,S).
%
%prompt(P):-
%    language(L),
%    prompt2(L,P),
%    !. 
%
%prompt('?: '). % Undefined Prompt.
%
%
%readfile_extension(X):-
%    language(L),
%    readfile_extension(L,X).
%
%%%% THESE ARE NOW CALLED FROM MAIN DIRECTORY
%
%dict_file(english,   'tuc/dict_e.pl').
%dict_file(norsk,     'tuc/dict_n.pl').
%
%dict_module(english, dict_e).
%dict_module(norsk,   dict_n).
%
%
%
%gram_file(english, 'tuc/gram_e.pl'). %% TA-000118
%gram_file(norsk,   'tuc/gram_n.pl'). %% TA-000118
%
%gram_module(english, gram_e).
%gram_module(norsk,   gram_n).
%
%
%
%morph_file(english, 'tuc/morph_e.pl').
%morph_file(norsk,   'tuc/morph_n.pl').
%
%morph_module(english, morph_e).
%morph_module(norsk,   morph_n).
%
%
%dcg_file(english, 'dcg_e.pl'). %% MAIN
%dcg_file(norsk,   'dcg_n.pl'). %% MAIN
%
%dcg_module(english, dcg_e).
%dcg_module(norsk,   dcg_n).
%
%
%script_file(english,facts_e).
%script_file(norsk,  facts_n). 
%
%readfile_extension(english, '.e').
%readfile_extension(norsk,   '.n'). 
%
%
%prompt2(english,'E: ').
%prompt2(norsk,'N: ').
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Compile the TUC System         %% 

                                              

?-compile('../version').           % Version and Date

%?-compile('../main').              % main program , starts
%:- use_module('../main.pl'). %% RS-130630 With all value(X,Y) (or X := Y ), e.g. lang:=norsk.

:-use_module('../tuc/readin', [ ] ).     % reads text to a list
%:-compile('../tuc/readin').       % reads text to a list
%?-compile('../tuc/lex').          % lexical analysis
:-use_module('../tuc/lex', [ ] ).          % lexical analysis        %% RS-131223
:-use_module('../tuc/translat', [ ] ).     % code generation 
%?-compile('../tuc/evaluate').     % translate and evaluate
:-use_module( '../tuc/evaluate', [ ] ). %   , [ instant/2 ] ).       %%%
%?-compile('../tuc/inger').        % intelligent resolution
?-use_module('../tuc/inger', [ ] ).        % intelligent resolution
?-use_module('../tuc/anaphors', [ ] ).     % anaphoric resolution
  
?-use_module('../tuc/facts.pl', [ ] ).        % static facts  / ?-compile(nofacts)     %% RS-131223
?-use_module('../tuc/fernando', [ ] ).     % semantic interface        %% RS-131223
?-use_module('../tuc/metacomp.pl', [ ] ).  % compiles the grammar %% TA-000529        %% RS-131223
?-use_module('../tuc/slash', [ ] ).        % slash facts /
%?-compile('../tuc/world0').       % empty world predicates     %% RS-131225    OLD! 

%?-compile(dcg_e:'../tuc/dagrun_e').      % split into English and %% TA-000117
%?-compile(dcg_n:'../tuc/dagrun_n').      % Norwegian clones       %% TA-000117
?-use_module(dcg_e:'../tuc/dagrun_e', [ ] ).      % split into English and %% TA-000117
?-use_module(dcg_n:'../tuc/dagrun_n', [ ] ).      % Norwegian clones       %% TA-000117

%?-compile('../tuc/semantic.pl').     % the semantic net
:-use_module( '../tuc/semantic.pl', [ ] ).     % the semantic net

%%% ?-compile(turbo).          % environment DOS/UNIX %% old 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

