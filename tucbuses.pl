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

%% For main.pl, dict_e, dict_n, ...? moved to declare.pl
:-module( tucbuses, [ ] ). % , readfile_extension/1, legal_language/1
%% For readin.pl language/1, prompt/1, script_file/1

% backslash/1, %% makegram/0,  compile_english/0, compile_norsk/0,   %% RS-140920 Moved back to metacomp
%dagrun_file/2,  dcg_file/2,     dcg_module/1, dcg_module/2, %% RS-131223 For metacomp.pl % UNUSED?: dcg_file/1,     
%dict_file/2,    dict_module/1,  dict_module/2, gram_file/2,     gram_module/1,  gram_module/2,   %% RS-131225 For lex.pl
%morph_file/2,   morph_module/1, %% RS-140920 For lex.pl?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%:- use_module( 'main.pl', [ language/1 ] ). %(:=)/2, value/2 

%% :-prolog_flag(discontiguous_warnings,_,off).  %%   RS-130330, or dcg_e.pl gets noisy!

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RS-131227    UNIT: / (FIRST!)
%:- ensure_loaded( user:'declare' ). %% RS-111213  General (semantic) Operators   := /2
%% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .
%:- use_module( declare, [ (:=)/2, value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .
:- use_module( declare, [ (:=)/2 ] ).   % , value/2

:- ( airbusflag := false ). %% NEW FLAG %% TA-090331  %%  RS-151219 Should ALWAYS be FALSE initially! See bustrans.pl for set(airbusflag,true)

%:- ( tramflag := false ).  %% Trams are NOT included ( Route 1 )       %% RS-141130
:- ( tramflag := true ).   %% Trams are included ( Route 1 )           %% RS-131228

:- ( busflag := true ).     %% Full Bus Application
:- ( queryflag := true ).   %% Statements are implicit queries
:- ( semantest := false ).  %% No distinction between syntactic/semantic error
:- ( spellcheck := 1 ).

%%  :- (single_sentence := true).
%% DIS-Allow several sentences on a line



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%UNIT: utility   %% RS-111213
%:-use_module( 'utility/utility', [ ] ). % variant/2 ] ).       %RS-131223 Value == TROUBLE! value/2    (And for(X,Y) is trouble too!)
%:-use_module( 'utility/library.pl',  [ ] ).  % ). %% %% RS-131225  [ for/2 ] ). %% ,  value/2  ]). %RS-131223 And for(X,Y) is trouble too!)
%:-use_module( 'utility/datecalc.pl', [ ] ).  %  ). %% ?-compile('utility/datecalc.pl').
%:-use_module( 'utility/writeout', [ ]).       %RS-131223 Value == TROUBLE! value/2    (And for(X,Y) is trouble too!)

%% :-use_module( 'utility/extracut.pl', [ create_regcut/1 ] ).  %% TA-080201 %%% ?-compile('utility/extractreg.pl'). %% SUSPENDED %% RS-140411
%% :-use_module( 'makeauxtables.pl', [ ] ).

%backslash('\\').        %% For main.pl, dict_n.pl (noiseword?) RS-131230 Moved to declare.pl !

%%%  ?-compile('sicstuc.pl').
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                 %
%% Compile the TUC System        %%
%% Moved up, Category dependent
%% ?-
%%   compile(version),           % Version and Date
%%   compile(main),              % main program , starts

%UNIT: /tuc/
% MISERY! :- use_module('tuc/readin.pl', [] ).       % reads text to a list     %?- ensure_loaded('tuc/readin.pl').

%:-  use_module( 'tuc/lex.pl', [ language/1 ] ).     % lexical analysis         %%RS-140920 %?- compile('tuc/lex.pl').

%%%%  compile('tuc/proxytagger'),    % disambiguator        %% TA-101010
%%%%  compile('tuc/proxytagrules'),   % disambiguate rules  %% -> lex/proxyclean

%?- use_module( 'tuc/translat.pl', [ ] ).     % code generation
%:- use_module( 'tuc/evaluate', [ ] ). %   , [ instant/2 ] ).       %%% Evaluate was formerly inger?
%%%%   compile( 'tuc/inger.pl'),        % intelligent resolution
%?- use_module( 'tuc/anaphors.pl', [ ]).     % anaphoric resolution

%:- use_module( 'tuc/facts.pl', [ ] ).     % static facts (moved from database)
%:- use_module( 'tuc/fernando.pl', [ ] ).     % semantic interface       %%RS-131223
%:- use_module( 'tuc/names.pl', [ ] ).     % general names and synonyms  (moved from database) %% RS-131223
%% :-  use_module( 'tuc/semantic.pl', [ ako/2 ] ).     % the semantic net (moved from database)    %RS-131225


:- use_module( 'tuc/gram_e.pl', [ ] ).     % general names and synonyms  (moved from database) %% RS-131223
:- use_module( 'tuc/gram_n.pl', [ ] ).     % general names and synonyms  (moved from database) %% RS-131223


%%   compile('tuc/world0.pl').       % empty world predicates %% TA-110301
%%%   compile('tuc/slash.pl').        % slash facts / %% Irrelevant

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%% RS-131229    When to do this?
%% Compile both languages  %% TA-000529
%% RS-131229. Includes gram_e, gram_n, dcg_e, dcg_n, ...
%% makegram(DAGFILE,DICTFILE,DCGFILE,DCGMODULE,GRAMMODULE):-

%:- use_module( 'tuc/metacomp.pl', [ makegram/0 ] ).     %%?-  compile('tuc/metacomp.pl').     % compiles the grammar %%RS-131223
%:- makegram.    %%RS-131223      % RS-140920      Use compile after all? Try bottom of the file?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%:-use_module( 'ptbwrite', [ ] ). %% TA-061030 %% 'utility/drucke_baum' Is included in PennTreeBankWriter %% RS-111218

%% :- use_module( 'db/busdat', [ clock_delay/3 ] ). 
%% :- use_module( 'db/timedat', [ named_date/2 ]).       %%  EASTER DATES AND OTHERS %% RS-131225


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%:- makegram.  %% RS-140920. When and HOW to do this? compile?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
