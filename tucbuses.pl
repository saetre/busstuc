%% FILE tucbuses.pl 
%% SYSTEM TUC
%% CREATED TA-970726
%% REVISED TA-110303

% Common File for tucbus  (english) and
%                 tucbuss (norwegian)

:-use_module(library(system)). 

?- use_module('ptbwrite.pl').%% TA-061030
?- use_module('utility/utility.pl').
?- use_module('utility/library').

:-prolog_flag(discontiguous_warnings,_,off). 

backslash('\\'). 
style_check(_).

%?- compile('declare.pl').  %% Loaded in respective modules: app, db, dialog, tagger, tuc, utility, etc.?
%?-compile('utility/drucke_baum.pl'). %% TA-061030
%?- compile('utility/datecalc.pl').  %% Kalles fra utility module
%?- compile('utility/makeauxtables.pl'). %% From utility
?- compile('utility/extracut.pl').  %% TA-080201

:- (airbusflag := false). %% NEW FLAG %% TA-090331

:- (busflag := true).     %% Full Bus Application 
:- (queryflag := true).   %% Statements are implicit queries 
:- (semantest := false).  %% No distinction between syntactic/semantic error
:- (spellcheck := 1).

  %?-compile('utility/extractreg.pl'). %% SUSPENDED
  %:-(tramflag := true).   %% Trams are included ( Route 1 )

  %%  :- (single_sentence := true). 
  %% DIS-Allow several sentences on a line

legal_language(english).
legal_language(norsk). %% NB not 'norwegian'

:- dynamic language/1.
language(L) :- language := L. %% Set dynamically

dict_module(D):-language(L),dict_module(L,D).

morph_module(D):-language(L),morph_module(L,D).

gram_module(D):-language(L),gram_module(L,D).

dcg_module(U):- language(L),dcg_module(L,U).

dcg_file(U) :-language(L),dcg_file(L,U).


script_file(S):-
    language(L),script_file(L,S).

%prompt(' ') :-
%   norsource := true. %% TA-110207
%
prompt(P) :-
    language(L),
    prompt2(L,P),
    !. 

prompt('?: '). % Undefined Prompt.


readfile_extension(X):-
    language(L),
    readfile_extension(L,X).

%%% THESE ARE NOW CALLED FROM MAIN DIRECTORY

dict_file(english,   'tuc/dict_e.pl').
dict_file(norsk,     'tuc/dict_n.pl').

dict_module(english, dict_e).
dict_module(norsk,   dict_n).



gram_file(english, 'tuc/gram_e.pl'). %% TA-000118
gram_file(norsk,   'tuc/gram_n.pl'). %% TA-000118

gram_module(english, gram_e).
gram_module(norsk,   gram_n).



morph_file(english, 'tuc/morph_e.pl').
morph_file(norsk,   'tuc/morph_n.pl').

morph_module(english, morph_e).
morph_module(norsk,   morph_n).


dcg_file(english, 'dcg_e.pl'). %% MAIN
dcg_file(norsk,   'dcg_n.pl'). %% MAIN

dcg_module(english, dcg_e).
dcg_module(norsk,   dcg_n).


script_file(english,facts_e).
script_file(norsk,  facts_n). 

readfile_extension(english, '.e').
readfile_extension(norsk,   '.n'). 


prompt2(english,'E: ').
prompt2(norsk,'N: ').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Compile the TUC System         %% 

                                              
%% Moved up, Category dependent
%% ?-
%%   compile(version),           % Version and Date
%%   compile(main),              % main program , starts

?-
  compile('tuc/readin.pl'),       % reads text to a list
  compile('tuc/lex.pl'),          % lexical analysis

%  compile('tuc/proxytagger'),    % disambiguator        %% TA-101010
%  compile('tuc/proxytagrules'),   % disambiguate rules  %% -> lex/proxyclean

  compile('tuc/translat.pl'),     % code generation 
  compile('tuc/evaluate.pl'),     % translate and evaluate
%   compile('tuc/inger.pl'),        % intelligent resolution 
  compile('tuc/anaphors.pl'),     % anaphoric resolution  
%  compile('tuc/metacomp.pl'),     % compiles the grammar       %% RS-111119 "imported" below instead
  compile('tuc/fernando.pl'),     % semantic interface
%   compile('tuc/world0.pl'),       % empty world predicates %% TA-110301
%   compile('tuc/slash.pl'),        % slash facts / %% Irrelevant

  compile(dcg_e:'tuc/dagrun_e.pl'),      % split into English and 
  compile(dcg_n:'tuc/dagrun_n.pl'),      % Norwegian clones 

  compile('tuc/semantic.pl'),     % the semantic net (moved from database)    
  compile('tuc/names.pl'),        % general names and synonyms  (moved from database) 
  compile('tuc/facts.pl').        % static facts (moved from database) 


%% Moved from tucbuses.pl 

%% Compile both languages  %% TA-000529

:- ['tuc/metacomp.pl'].     % RS-1111119 compiles the grammar (with makegram predicate)

compile_english :-
    dict_file(english,L),compile(L),       % dictionary for E 
    morph_file(english,M),compile(M),      % morphology for E 

    gram_file(english,G),compile(G),         % grammar for E 
    makegram(english).

compile_norsk:-
    dict_file(norsk,L),compile(L),         % dictionary for N
    morph_file(norsk,M),compile(M),        % morphology for N

    gram_file(norsk,G),compile(G),         % grammar for N
  
    makegram(norsk).

%?- compile_english.

%?- compile_norsk.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




