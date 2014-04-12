/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE tucbuses.pl
%% SYSTEM TUC
%% CREATED  TA-970726    %% REVISED TA-110303
%% REVISED  RS-140101 modularized

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Common File for tucbus  (english) and
%                 tucbuss (norwegian)
%
%EXECUTES:
%        ?-compile_english.
%        ?-compile_norsk.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%:-meta_predicate        prompt(+).     %% RS-140208    What's this for?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% For main.pl, dict_e, dict_n, ...? moved to declare.pl
:-module( tucbuses, [ backslash/1, compile_english/0, compile_norsk/0, dagrun_file/2, dcg_file/1, dcg_file/2, dcg_module/1, dcg_module/2, %% RS-131223 For metacomp.pl
        dict_file/2,    dict_module/1,  dict_module/2, gram_file/2,  gram_module/1,    gram_module/2,           makegram/0,   %% RS-131225 For lex.pl
        morph_file/2,   morph_module/1, language/1,    legal_language/1,       prompt/1, readfile_extension/1,  script_file/1 %% For readin.pl
] ).

backslash('\\').        %% For main.pl, dict_n.pl (noiseword?) RS-131230 Moved to declare...?!
%% :-prolog_flag(discontiguous_warnings,_,off).  %%   RS-130330, or dcg_e.pl gets noisy!

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RS-131227    UNIT: / (FIRST!)
:- ensure_loaded( user:'declare' ). %% RS-111213  General (semantic) Operators

:- user:( airbusflag := false ). %% NEW FLAG %% TA-090331

:- user:( tramflag := false ).   %% Trams are NOT included ( Route 1 )
%:- user:( tramflag := true ).   %% Trams are included ( Route 1 )      %% RS-131228

:- user:( busflag := true ).     %% Full Bus Application
:- user:( queryflag := true ).   %% Statements are implicit queries
:- user:( semantest := false ).  %% No distinction between syntactic/semantic error
:- user:( spellcheck := 1 ).

%%  :- (single_sentence := true).
%% DIS-Allow several sentences on a line

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%UNIT: utility   %% RS-111213
%% :-use_module( 'utility/utility', [ value/2  ]).       %RS-131223 Value == TROUBLE!   (And for(X,Y) is trouble too!)
:-use_module( 'utility/library.pl' ). %%,  [ ] ).   %RS-131225  [ for/2 ] ). %% ,  value/2  ]). %RS-131223 And for(X,Y) is trouble too!)
:-use_module( 'utility/datecalc.pl' ). %%, [ ] ).    %?-compile('utility/datecalc.pl').

%% :-use_module( 'utility/extracut.pl', [ create_regcut/1 ] ).  %% TA-080201 %%% ?-compile('utility/extractreg.pl'). %% SUSPENDED %% RS-140411
:-use_module( 'makeauxtables.pl' ). %%, [ ] ).

%%%  ?-compile('sicstuc.pl').
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                 %
%% Compile the TUC System        %%
%% Moved up, Category dependent
%% ?-
%%   compile(version),           % Version and Date
%%   compile(main),              % main program , starts

%UNIT: /tuc/
%?- ensure_loaded('tuc/readin.pl').       % reads text to a list
% MISERY! :- use_module('tuc/readin.pl').       % reads text to a list
%?- compile('tuc/lex.pl').          % lexical analysis        %%RS-131223
:-  use_module('tuc/lex.pl').          % lexical analysis        %%RS-131223

%%%%  compile('tuc/proxytagger'),    % disambiguator        %% TA-101010
%%%%  compile('tuc/proxytagrules'),   % disambiguate rules  %% -> lex/proxyclean

?- use_module('tuc/translat.pl').     % code generation
%?-  compile('tuc/evaluate.pl').     % translate and evaluate
:- use_module( 'tuc/evaluate' ). %   , [ instant/2 ] ).       %%% Evaluate was formerly inger?
%%%%   compile('tuc/inger.pl'),        % intelligent resolution
?- use_module('tuc/anaphors.pl').     % anaphoric resolution

:- use_module('tuc/facts.pl').     % static facts (moved from database)
%%?-  compile('tuc/fernando.pl').     % semantic interface        %%RS-131223
:-  use_module('tuc/fernando.pl').     % semantic interface       %%RS-131223

%%?-compile('tuc/names.pl').        % general names and synonyms  (moved from database)
:- use_module('tuc/names.pl').     % general names and synonyms  (moved from database) %% RS-131223

%% :-  use_module( 'tuc/semantic.pl', [ ako/2 ] ).     % the semantic net (moved from database)    %RS-131225

%%   compile('tuc/world0.pl').       % empty world predicates %% TA-110301
%%%   compile('tuc/slash.pl').        % slash facts / %% Irrelevant

%%%%%% RS-131229    When to do this?
%% Compile both languages  %% TA-000529
%% RS-131229. Includes gram_e, gram_n, dcg_e, dcg_n, ...
%% makegram(DAGFILE,DICTFILE,DCGFILE,DCGMODULE,GRAMMODULE):-
%%?-  compile('tuc/metacomp.pl').     % compiles the grammar %%RS-131223
:- use_module('tuc/metacomp.pl', [ makegram/5 ] ).    %%RS-131223
%

?-  use_module( dcg_e:'tuc/dagrun_e.pl' ).      % module dcg_e. split into English and
?-  use_module( dcg_n:'tuc/dagrun_n.pl' ).      % module dcg_n.  Norwegian clones
%?-  ensure_loaded( dcg_e:'tuc/dagrun_e.pl' ).      % split into English and
%?-  ensure_loaded( dcg_n:'tuc/dagrun_n.pl' ).      % Norwegian clones

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:-use_module('ptbwrite'). %% TA-061030 %% 'utility/drucke_baum' Is included in PennTreeBankWriter %% RS-111218

%% :- use_module( 'db/busdat', [ clock_delay/3 ] ). 
%% :- use_module( 'db/timedat', [ named_date/2 ]).       %%  EASTER DATES AND OTHERS %% RS-131225

legal_language(english).
legal_language(norsk). %% NB not 'norwegian'

language(L) :- user:value( language, L ). %% value(language,X) should have been set dynamically by now!


dict_module(D) :- language(L),dict_module(L,D).

morph_module(D) :- language(L),morph_module(L,D).

gram_module(D) :- language(L),gram_module(L,D).

dcg_module(U) :- language(L),dcg_module(L,U).

dcg_file(U) :-language(L),dcg_file(L,U).


script_file(S):-
    language(L),script_file(L,S).

prompt(' '):-
   user:value(norsource,true). %% TA-110207

prompt(P):-
    language(L),
    prompt2(L,P),
    !.

prompt('?: '). % Undefined Prompt.


readfile_extension(X):-
    language(L),
    readfile_extension(L,X).


%%% THESE ARE NOW CALLED FROM MAIN DIRECTORY

dagrun_file(english,   'tuc/dagrun_e.pl').
dagrun_file(norsk,     'tuc/dagrun_n.pl').

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%compile_english :-
%    dict_file(english,DICTFILE),        compile(DICTFILE),      % dictionary for E
%    morph_file(english,MORPHFILE),      compile(MORPHFILE),     % morphology for E
%    gram_file(english,GRAMFILE),        compile(GRAMFILE),      % grammar for E
%    gram_module(english,GRAMMODULE),                            % 'dcg_e'
%
%    dagrun_file(english,DAGFILE),   %% RS-131228 Moved up to customize the dcg.pl as either norsk or english!
%    dcg_file(english,DCGFILE),  dcg_module(english,DCGMODULE),
%    makegram(DAGFILE, DICTFILE, DCGFILE, DCGMODULE, GRAMMODULE).
%
%compile_norsk:-        %    makegram(norsk).
%    dict_file(norsk,DICTFILE),  compile(DICTFILE),      % dictionary for N
%    morph_file(norsk,MORPHFILE),compile(MORPHFILE),   % morphology for N
%    gram_file(norsk,GRAMFILE),  compile(GRAMFILE),      % grammar for N
%    gram_module(norsk,GRAMMODULE),
%
%    dagrun_file(norsk,DAGFILE),   %% RS-131228 Moved up to customize the dcg.pl as either norsk or english!
%    dcg_file(norsk,DCGFILE),  dcg_module(norsk,DCGMODULE),
%    makegram(DAGFILE, DICTFILE, DCGFILE, DCGMODULE, GRAMMODULE).
%% RS-131230
compile_english :-
    dict_file(english,DICTFILE),        use_module(DICTFILE, [ ] ),      % dictionary for E
    morph_file(english,MORPHFILE),      use_module(MORPHFILE, [ ] ),     % morphology for E
    gram_file(english,GRAMFILE),        use_module(GRAMFILE, [ ] ),      % grammar for E
    gram_module(english,GRAMMODULE),                            % 'dcg_e'

    dagrun_file(english,DAGFILE),   %% RS-131228 Moved up to customize the dcg.pl as either norsk or english!
    dcg_file(english,DCGFILE),  dcg_module(english,DCGMODULE),
    makegram(DAGFILE, DICTFILE, DCGFILE, DCGMODULE, GRAMMODULE).

compile_norsk:-        %    makegram(norsk).
    dict_file(norsk,DICTFILE),          use_module(DICTFILE, [ ] ),      % dictionary for N
    morph_file(norsk,MORPHFILE),        use_module(MORPHFILE, [ ] ),   % morphology for N
    gram_file(norsk,GRAMFILE),          use_module(GRAMFILE, [ ] ),      % grammar for N
    gram_module(norsk,GRAMMODULE),

    dagrun_file(norsk,DAGFILE),   %% RS-131228 Moved up to customize the dcg.pl as either norsk or english!
    dcg_file(norsk,DCGFILE),    dcg_module(norsk,DCGMODULE),
    makegram(DAGFILE, DICTFILE, DCGFILE, DCGMODULE, GRAMMODULE).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% RS-131227 Makegram is used IN tucbuses!  %% Avoid circles!
makegram :-
        compile_english,
        compile_norsk.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- makegram.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
