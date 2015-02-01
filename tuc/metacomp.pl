/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE metacomp.pl  EXPERIMENTAL
%% SYSTEM TUC
%% CREATED TA-940128   %% REVISED  TA-090521
%% REVISED RS-140921  re-modularized

%% metacomp.pl (english and norsk). Compile all the necessary grammar files...
%
% gram_n.pl (sentence/3) ---> dcg_n.pl (sentence/6)
% gram_e.pl ---> dcg_e.pl
%

%% SYSTEM TUC
:-module( metacomp, [ compile_english/1,  compile_norsk/1,  dcg_module/1, gram_file/2,    gram_module/1,  gram_module/2,  %% RS-140921 % dict_file/2, makegram/1,  
        morph_file/2, sentence/7, virtf/2, virtx/1 ] ).

%% RS-140920.   What about dict/lex-files? Moved to tuc/lex.pl: dict_module/1, dict_module/2, morph_module/1,
%% RS-131227 loop?!: language/1  -> Moved to main %:-use_module( '../utility/writeout', [ language/1 ] ). %% RS-140920
%% RS-131227    UNIT: tuc/      dcg_module %% RS-141122
%% RS-130329 Make sure (gram/lang) modules are available: 1: gram_n -> ( 2: metacomp ) -> 3: dcg_n   (The same for English). Moved after :- makegram.

%%:- use_module( tucbuses:'../tucbuses', [  dagrun_file/2,  dcg_file/2, dcg_module/2,  dict_file/2, morph_file/2, gram_file/2, gram_module/2, style_check/1  ] ).
%% What is norsource? E.g.: segram/0, regram/0, are "bloody hacks?" What about %  genvirt/1, optiprod/1, %
%% OLD: makegram/1, e.g. makegram(norsk).

%% RS-131225 Experiment, failed, removed: make_predname_argscount/2, write_protected_preds/1,
%% ?-prolog_flag(unknown,_,fail). %% Don't crash on undefined predicates        %% RS-131227 Removed?

%% RS-131227, UNIT: EXTERNAL LIBRARY
:- use_module( library(varnumbers), [ numbervars/1 ] ). %% RS-140210.
%:- use_module( library(lists3), [ remove_duplicates/2 ] ). %% RS-131223
%:- use_module( library(file_systems), [ file_properties/3 ] ). %% RS-141122 Why? To check whether gram_n or gram_e have changed -> then recreate dcg_n or dcg_e!


%% RS-131223   % UNIT: /     Get dynamic definition for value/2
:- use_module( '../declare', [ remember/1, value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .
%:- use_module( '../main', [ language/1 ] ). %% RS-140209    %?-compile('main.pl'). ( := )/2 
:- use_module( '../sicstuc', [ language/1 ] ). %% RS-140209    %?-compile('main.pl'). ( := )/2 
:- use_module( '../makeauxtables', [ verify_files_exist/2 ] ).

%% RS-131223   % UNIT: /utility/*.pl
:- use_module( '../utility/utility', [ for/2, test/1 ] ). %, variant/2 ] ). %% test(X):- \+ ( \+ ( X)).  % :- meta_predicate test(0) . %% RS-140211
:- use_module( '../utility/datecalc', [ datetime/6 ] ). %% RS-140921 For the file headings


%%% SMOKETEST    virtuals are added last

%% VIRTUAL PRODUCTIONS MUST COME FIRST

%%  dcg_x.pl = virtuals.pl + dcg.pl

:- volatile
           virtf/2, virtx/1, optiprod/1. %%, predheads/1. %% RS-140914

:- dynamic virtf/2,     %% the virtual functor
           virtx/1,     %% the virtual expression
           optiprod/1.  %% meta clause   (meta(P))
           %%predheads/1. %% Collection of all predicate definitions found (for module header)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A / B     means   " A using all of B before success
% A - B     means   " A using (all of) B some time "
% A \ B     means   " A using (all of) B from the beginning " 
% A = B     means   " A using exactly B ( intentionally )

% Runtime routines are placed in utility.pl

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

variant(X,Y):-   
    subsumes(X,Y),
    subsumes(Y,X).

subsumes(X,Y):-   % X at least as general
     test( subsum1(X,Y) ).

subsum1(X,Y):-
     numbervars(Y),
     X=Y.

%% Moved from tucbuses.pl
%% RS-131227 compile_english and compile_norsk are used IN tucbuses!  %% Avoid circles!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RS-140920 Keep all the META-PREDICATES internal in this file?!
% OLD :- meta_predicate  for(:, + ). %% RS-140101 from utility ( : means this module, + means source module )?
% :- meta_predicate  for( 0, 0 ). %% RS-140920 from utility ( : means this module, + means source module, 0 means this module? with no extra arguments? )
%for( P, Q ) :- %% For all P, do Q (with part of P)
%  P, Q,
%  false;true.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% RS-131228  %% Removed RS-141130
%segram:- %% short %% norsource facilities %% TA-100207
%    nodebug, 
%    ( norsource := true ),
%    consult(gramn),
%    makegram( './' ).
%
%regram:- %% short 
%    nodebug, 
%    consult(gramn),
%    makegram( './' ).


%%% THESE ARE NOW CALLED FROM TUC (MAIN) DIRECTORY

%dagrun_file(english,   '../tuc/dagrun_e.pl').
%dagrun_file(norsk,     '../tuc/dagrun_n.pl').
dagrun_file( english,   dagrun_e ).
dagrun_file( norsk,     dagrun_n ).

%dict_file(english,   'dict_e.pl').
%dict_file(norsk,     'dict_n.pl').
dict_module( english,   dict_e ).
dict_module( norsk,     dict_n ).

gram_file(english, 'gram_e.pl'). %% TA-000118
gram_file(norsk,   'gram_n.pl'). %% TA-000118
%gram_file( english, gram_e ). %% TA-000118
%gram_file( norsk,   gram_n ). %% TA-000118

gram_module( english, gram_e ).
gram_module( norsk,   gram_n ).

%morph_file(english, 'tuc/morph_e.pl').
%morph_file(norsk,   'tuc/morph_n.pl').
morph_file( english, morph_e ).
morph_file( norsk,   morph_n ).

gram_module( D ) :- language(L), gram_module(L,D).

dcg_module( U ) :- language(L), dcg_module(L,U).
%dcg_module( U ) :- language(L), dcg_file(L,U).


%dcg_module( english, 'dcg_e.pl' ).
%dcg_module( norsk,   'dcg_n.pl' ).
dcg_module( english, dcg_e ).
dcg_module( norsk,   dcg_n ).

%dcg_file(U) :-language(L),dcg_file(L,U).      %% RS-140920 Unused?
%dcg_file( english, 'tuc/dcg_e.pl' ). %% MAIN
%dcg_file( norsk,   'tuc/dcg_n.pl' ). %% MAIN



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%DEBUG
%%gram_module(norsk,   gram_n).
%%dcg_file(norsk,   'dcg_n.pl'). %% MAIN -> tucbuses

%% RS-131227 makegram/0 /1 /5 is used IN tucbuses!  %% Avoid circles!?   % makegram :- ...
%makegram :-
%    nodebug, %% TA-001027      %% RS-131227 Verify that this work, and TURN OFF AGAIN!
%    language(Lang), %% RS-131228 NOT working when compiling just metacomp.pl (with makegram.)!
%    % (language(Lang) -> true ; Lang==norsk),
%    makegram(Lang).

%% RS-131227 Makegram is used IN tucbuses!  %% Avoid circles!?
makegram( PATH ) :-  %% Moved into gram_e/gram_n.pl
%        current_directory( _, '/eclipse/workspace/busstuc' ),
        compile_english( PATH ),
        compile_norsk( PATH ). % , current_directory( _, OldDir ).

%% ENGLISH GENERATION 

writeheader( DAGFILE, DCGFILE, DCGMODULE, DICTMODULE, 'gram_e' ) :- 
        write('%% FILE '),write(DCGFILE),nl,
        write('%% Automatically created by tuc/metacomp.pl, based on dict and tuc/gram_...'),nl, nl,
        write(':-module( '),write(DCGMODULE),write(', '),write( [ sentence/6, anorder/7, as0/5, atom/6, atomlist/6, be_modal/6, begin/5, bus_number/6, clock_number/6, colon0/5,
                descend00/9, each/5, either0/5, end/5, from/5, in0/5, kl0/5, latest/5, nameq3/7, nounp/7, nounp1/8, npy/8, nr0/5,
                ones/5, or1/5, others/5, pointNO/5, prep0/6, qtrailer/5, road_number/6, statemenreal/6, statics/6, streetno/5,
                superlative/7, that_verb/11, that0/5, that0/6, this1/7, trans_verbs/10, very/5, year0/6  ] ),write(' ).'),nl,nl,

%        write(':- meta_predicate  '),nl,
        write(':- meta_predicate  adjunct1(?,?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  andor(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  adverb(?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  clausal_phrase(?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  command( ?, ?, ?, -, ?, - ).'),nl,
        write(':- meta_predicate  date(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  dendagen(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  determiner0(?,?,?,?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  do(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  do0(?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  howadj(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  howadjq(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  howq(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  lexv(?,?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  namep(?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  nameq1(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  negation0(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  noun(-,?,?,?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  np_head(?,?,?,?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  np_head1(?,?,?,?,?,-,?,?,-,?,-).'),nl,
        write(':- meta_predicate  number(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  passive(?,?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  person_name(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  ppq( ?, ?, ?, -, ?, - ).'),nl,
        write(':- meta_predicate  preadj1(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  quit(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  rel_clause(?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  sentence1( ?, ?, ?, -, ?, - ).'),nl,
        write(':- meta_predicate  statemens0( ?, ?, ?, ?, ?, -, ?, - ).'),nl,
        write(':- meta_predicate  timeq12(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  whatq(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  whichq(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  whenq(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  wherefromq(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  whereq(?,?,?,-,?,-).'),nl,

        nl,     %        write(':- meta_predicate  '),nl,
        write(':- use_module( ''../declare'', [ value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .'), nl,
        write(':- use_module( ''../utility/utility'', [ testmember/2 ] ).  %% test/1, RS-140914'),nl, nl,
        write(':- use_module( ''../utility/writeout'', [ traceprint/2 ] ).  %% Module util track/2,  , prettyprint/1, output/1, RS-140914'),nl, nl,

        write('%:- ensure_loaded( '''), write(DCGMODULE),write(':'''),write(DAGFILE),write(''' ). %%, [ cc/5, w6 ] ). %% RS-140209 What is DAG?'), nl,
        write(':- use_module( '''),write( DAGFILE ),write(''', '),write( [ cc/5,  check_stop/5, end_of_line/5, lock/5, look_ahead/6, not_look_ahead/6,
                pushstack/7, skip_rest/5, unlock/4, virtual/6, w/6 ] ),write(' ). %% RS-111213 What is DAG? '),nl,

        write(':- use_module( '''),write( DICTMODULE ),write(''', '),write( [ noun/1, preposition/1, pronoun/2 ] ), write('). %% RS-111213 What is DAG? '),nl,
        write(':- prolog_flag(discontiguous_warnings,_,off).'),nl,nl,
        
        write(':- use_module( ''../utility/datecalc'', [ addtotime/3, this_year/1, todaysdate/1 ] ).  %% RS-131228, add_days/3, datetime/6, days_between/3, easterdate/2, subfromtime/3, timenow/1, today/1, '),nl,
        write(':- use_module( ''../db/timedat'', [ named_date/2 ] ). %% dedicated_date/1, RS-131228' ),nl,
        %write(':- use_module( '''), write(DICTFILE), write(''' , [] ). %%, [ preposition/1 ] ). %% RS-111213 Dictionary lookups'),nl,

        write(':- use_module( fernando, [ adjnamecomp_template/3, adjnoun_template/4, adjname_template/4, adjust_year/3,' ), nl,
        write('         adj_template/5, adv_compl/6, align/5, align_measure/5, align_noun_name/5, atom_templ/2, bealign/5,' ), nl,
        write('         compare/5,      compatvar/2, compoundtest/4, constrain/2, constrainit/2, dayname/1, dtv_template/6,' ), nl,
        write('         has_template/3, it_template/1, iv_template/4, latin/4, monthnumber/2, negate/3, noun_adverb/4, noun_compl/4, pluralis/2, preadjs_template/4,' ), nl,
        write('         rv_template/7, setvartype/2, tv_template/5, type/2, vartypeid/2, verb_compl/6, verbtype/2 ] ). %% RS-140921 value_world/1, vartype/3, which_thing/2, whodunnit/2' ),nl,

        write(':- use_module( semantic, [ a_compl/4, gradv_templ/2, measureclass/1, particle/3, post_adjective/1, pvi_templ/2, stanprep/2, subclass0/2, tv_templ/3, v_compl/4 ] ). %% RS-131227' ),nl,
        write(':- use_module( lex, [ no_unprotected_verb/0 ] ). %% txt/3, unprotected_verb/0, maxl/1, RS-140209' ),nl,nl.

%% NORSK GENERATION

writeheader( DAGFILE, DCGFILE, DCGMODULE, DICTFILE, 'gram_n' ) :- 
        write('%% FILE '),write(DCGFILE),nl,
        write('%% Automatically created by tuc/metacomp.pl, based on dict and tuc/gram_...'),nl, nl,
        write(':-module( '''),write(DCGMODULE),write(''', '),write( [ sentence/6, (\)/7, addressat0/5, altsogå/5, andor0/6, andwhere0/5, anorder/7, areyou/5, as0/5, assemble_stop_locations/6, at0/5, atom/6, atomlist/6, aux0/7, auxs/5, 
                be_modal/6, be_there_modal/6, be_truefalse_that/6, be0/5, begin/5, both0/5, bus_number/6, check_stop_locations/5, clock_number/6, clock_time/6, colon0/5, commas0/5, complement1_accept/8,
                denbussen/5, dendet0/5, detå/5, (do)/6, each/5, either0/5, end/5, endofline1/5, erdetdet/5, everything/5,
                faa0/5, faaverb/6, fast/5, flnpproper/6, fordent0/6, forto0/5, from/5, førnår/5, gadd/5, grums/5, halfhour/5, has0/5, hashad0/5, herefrom/5, 
                ifra/5, iman/5, imp_phrase/6, in_order_to/7, it/5, itrailer/5, iyou/6, kan/5,
                latest/5, let/5, longadj/5, look_ahead_conjuction/5, look_ahead_endofline/5, look_ahead_pron/5, look_ahead_timeclause/5, menbare/5, mineyour0/5, minutes0/5, 
                name_compound/8, namenb/6, nearest/5, next0/5, no_phrase/7, not_adjective_only/5, not_look_ahead_day/5, not_look_ahead_noun/5, not_look_ahead_pron/5, not_look_ahead_time/5, not_look_ahead_vehicle/5,
                not_one_of_lit/6, notify/5, notrel/5, notwithstanding/5, np_question/6, number0/5, nr0/5,
                object2hnn/8, om0/5, ompa/5, or1/5, others/5, out0/5, overat/5, paadeg/5, panic/6, pointNO/5, prep0/6, qtrailer/5, quant00/6, 
                redundantsx0/5, relneg/6, relwhat/6, rep_modifiers0/10, road_number/6, same/5, sentence01/6, setlist/5, smallhours/6, some/5, someonex/5, soredundant0/5, 
                statics/6, streetno/5, subjectverb/8, superlative/7, team/5, termchar0/5, terminatore0/5, thatto0/8, that0/5, 
                themost/5, then0/5, theonly0/5, there_be_modal/6, thereitN/5, this/6, thousand0/5, tilsiden/5, timenexp/6, today0/5,
                trafikk/5, trans_verbs/10, verb0/6, when0/5, when10/5, where1/5, whose_noun/7, year0/6 ] ),write(' ).'),nl,
        write(' %% RS-141122 OBSOLETE?: adj_conjunction0/5, '), nl, nl,

%        write(':- meta_predicate  '),nl,
        write(':- meta_predicate  adj1s(?,?,?,-,?,?,-,?,-).'),nl,
        write(':- meta_predicate  adjunct1(?,?,?,?,?,-,?,-).'),nl,       %english  adjunct1/9
        write(':- meta_predicate  adverb(?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  andor(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  aux1(?,?,?,?,?,?,-).'),nl,
        write(':- meta_predicate  ampm0(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  aname_phrase(?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  art0(-,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  adverbial3(-,-,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  adverbx(?,?,-,?,?,?,?,-).'),nl,
        write(':- meta_predicate  adverbial1(?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  adverbix(?,?,?,?,?,?,?,-).'),nl,
        write(':- meta_predicate  be_noun(?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  colemin(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  clock_kernel(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  flnp(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  art(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  bus_head(-,-,-,?,-,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  do_phrase(?,?,?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  clock_sequel(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  command( ?, ?, ?, -, ?, - ).'),nl,
        write(':- meta_predicate  date(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  dendagen(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  determiner0(-,?,?,-,?,?,?,-,?,-).'),nl,       %English:  determiner0/11  (vs. /10)
        write(':- meta_predicate  complement_nil(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  do(?,?,?,-,?,-).'),nl,       %english  do0/8
        write(':- meta_predicate  determiner00(?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  missingprep(?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  hours100(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  howadj(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  howadjq(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  howmuchq(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  howq(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  hlexv(?,-,?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  itstatem(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  lexv(?,?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  gradverb(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  nameq2(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  namep(?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  noun_complex(?,?,-,?,?,-,?,-).'),nl,
        write(':- meta_predicate  np_head(?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  nameq1(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  negation( ?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  negation0(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  negation2(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  noun(-,?,?,?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  noun2(-,-,?,?,-,?,?,-,?,-).'),nl,
        write(':- meta_predicate  noun_phrases0(?,?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  np_kernel(?,?,?,?,?,-,?,-).'),nl,       %english:  np_head/11, np_head1/11
        write(':- meta_predicate  np0_accept(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  np1(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  npa(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  np_head1(?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  np0(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  noun_phrase1(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  noun_phrases2(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  name1g(?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  name_phrase(?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  noun_mod(?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  number(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  object2(?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  obviousclock1(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  obviousdate1(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  orwill(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  partday(?,?,-,?,?,?,?,-).'),nl,
        write(':- meta_predicate  particle(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  person_name(?,?,-,?,?,-,?,-).'),nl,
        write(':- meta_predicate  personal(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  pp(?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  plausibledate1(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  plausibleclock(-,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  plausibleclock1(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  prep1(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  prep2(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  pronoun(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  ppq( ?, ?, ?, -, ?, - ).'),nl,
        write(':- meta_predicate  quant_pron(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  preadj1(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  question1(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  quit(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  qverb_phrase(?,?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  rel_clause(?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  rvp_kernel(?,?,?,?,-,?,?,-,?,-).'),nl,
        write(':- meta_predicate  rvpk(?,?,?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  rep_v(?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  sentence1( ?, ?, ?, -, ?, - ).'),nl,
        write(':- meta_predicate  statem(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  substate(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  subjunction(?,-,-,?,?,-,?,-).'),nl,
        write(':- meta_predicate  statemens0( ?, ?, ?, ?, ?, -, ?, - ).'),nl,
        write(':- meta_predicate  time1(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  time012(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  timeq1(?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  verb_phrases0(?,?,?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  verb_mod1(?,?,?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  verb_phrase1(?,?,?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  vp_kernel(?,?,?,?,-,?,?,-,?,-).'),nl,
        write(':- meta_predicate  whatq(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  when_adverbial(?,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  whx_phrase(-,?,?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  whichq(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  whenq(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  wherefromq(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  whereq(?,?,?,-,?,-).'),nl,
        write(':- meta_predicate  wnameg(?,?,?,?,?,-,?,-).'),nl,

        nl,     %        write(':- meta_predicate  '),nl,
        write(':- use_module( ''../declare'', [ (:=)/2, value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .'), nl,
        write(':- use_module( ''../utility/gps'', [ assert_default_origins/1  ] ). %%RS-140209 , ( := )/2, traceprint/2, value/2'),nl,
        write(':- use_module( ''../utility/utility\', [ test/1, testmember/2 ] ).  %% RS-140914'),nl, nl,
        write(':- use_module( ''../utility/datecalc'', [ add_days/3, datetime/6, easterdate/2, subfromtime/3, this_year/1, timenow/1, today/1, todaysdate/1  ] ).  %% RS-131228, addtotime/3, days_between/3, '),nl,
        write(':- use_module( ''../utility/writeout'', [ traceprint/2 ] ).  %% Module util track/2,  , prettyprint/1, output/1, RS-140914'),nl, nl,

        write(':- use_module( '''),write( DAGFILE ),write(''', '),write( [ cc/5,  check_stop/5, end_of_line/5, end_of_line0/5, lock/5, look_ahead/6, not_look_ahead/6,
                pushstack/7, skip_rest/5, unlock/4, virtual/6, w/6 ] ), write('). %% RS-111213 What is DAG? '),nl,
        write(':- use_module( '''),write( DICTFILE ),write(''', '),write( [  ] ), write('). %% RS-111213 What is DAG? '),nl,
        write(':- prolog_flag(discontiguous_warnings,_,off). %% RS-140921 Does this actually work?'),nl,nl,
        
        write(':- use_module( ''../db/timedat'', [ dedicated_date/1, named_date/2 ] ). %% RS-131228' ),nl,
        %write(':- use_module( '''), write(DICTFILE), write(''' , [] ). %%, [ preposition/1 ] ). %% RS-111213 Dictionary lookups'),nl,

        write(':- use_module( fernando, [ adj_compl/6, adjnamecomp_template/3, adjnoun_template/4, adjustprep/3, adjust_year/3, % ] ).  %% adjname_template2/3, adjname_template/4, ' ), nl,
        write('         adj_template/5, adjustprepv/3, adv_compl/6, align_measure/5, align_noun_name/5, atom_templ/2, alignable/2, atv_template/6, bealign/5, bigno/3, %  cat_templ/5, align/5, ' ), nl,
        write('         compare/5, clock_test/1, co_template/6, comparad/5, compatvar/2, compliancetest2/3, %% compliancetest/2,  ' ), nl,
        write('         compoundtest/4, constrain/2, constrainit/2,     %%  constrain0/2, constrain2/3,  ctype/2,' ), nl,
        write('         dayname/1, decide_adjective/3, decide_quantifier/4, dtv_template/6, % defact/3, event/4,' ), nl,
        write('         has_template/3, it_template/1, iv_template/4, % hour_test/1, idvarx/3, isfaktor/1, issiffer/1, issifre/1,' ), nl,
        write('         joinclass/3,  joinclasses/2, latin/4, monthnumber/2, negate/3, % meetclass/3,' ), nl,
        write('         norpart/3, numberdate/2,  noun_adverb/4, noun_compl/4, plausible_busno/1, plausibleclocktest/3, % nil_noun_compl/1, ' ), nl,
        write('         preadjs_template/4, % rep_verb/1, pluralis/2, ' ), nl, 
        write('         setvartype/2, subject_object_test/3, subtype0/2, testconstraint/2, thenwhat/3, tv_template/5, type/2, % subclass/2, subclass0/2, screenmeasure/2, rv_template/7, ' ), nl,
        write('         vartype/3, vartypeid/2, verb_compl/6, verbtype/2, which_thing/2 ] ). %% RS-140921 value_world/1, whodunnit/2' ),nl, %% fernando and dcg_n overlaps!
        write(':- use_module( lex, [ no_unprotected_verb/0, unprotected_verb/0 ] ). %% txt/3, maxl/1, RS-140209' ),nl,
        write(':- use_module( semantic, [ a_compl/4, abnormalverb/2, adjname_templ/2, ako/2, measureclass/1, % ] ). %% RS-140921 adj_templ/2, adjnamecomp_templ/3, adjnoun_templ/2, adjnouncomp_templ/3, (has_a)/2, iv_templ/2, jako/2, align1/2, aligen2/2,' ),nl,
        write('         particle/3, post_adjective/1, pvi_templ/2, subclass/2, subclass0/2, tv_templ/3, v_compl/4, %  coher_class/3, dtv_templ/4, gradv_templ/2, stanprep/2,'),nl,
        write('         rv_templ/2 ] ). % RS-131227 measureclass/1, particle/3, post_adjective/1, pvi_templ/2, stanprep/2, tv_templ/3, v_compl/4, vako/2, testclass/1, n_compl/3, pai_templ/2,'),nl,
        nl.

makegram( DAGFILE, DCGMODULE, DICTMODULE, GRAMMODULE, PATH ) :- % DICTFILE,
    atom_concat( PATH, DCGMODULE, DCGPATH),    atom_concat( DCGPATH, '.pl', DCGFILE),
    retractall( virtf(_,_) ),
    retractall( virtx(_) ),
    retractall( optiprod(_) ), 
    %%retractall(predheads(_) ),

    told,       %% Close all current output streams
    %% If dcg_x is newer than gram_x AND newer than 'this file' (metacomp.pl), then SKIP recreation.
    ( ( verify_files_exist( DCGFILE, 'metacomp.pl' ) , verify_files_exist( DCGFILE, GRAMMODULE ) ) ;   (
            write('%    .....tuc/metacomp.pl~404: making file.....: '), write(DCGFILE),nl,

            %% In other prologs than Sicstus: open is the same as  tell('dcg.pl'), plus UTF-8 encoding  %% RS-121121
            open( DCGFILE, write, DcgStream, [encoding('UTF-8')] ),
        %   open('dcg.pl', write, DcgStream, [encoding('UTF-8')] ),
            set_output(DcgStream),
                writeheader,
                writeheader( DAGFILE, DCGFILE, DCGMODULE, DICTMODULE, GRAMMODULE ),
                for( ( GRAMMODULE: (X ---> Y) ), genprod(X,Y) ),       %% RS-140101 meta_predicate for/2
                write('%%% optionals'), nl,
        
        %    open( 'virtuals.pl', write, VirtualStream, [encoding('UTF-8')] ),  set_output(VirtualStream),
                %% RS-131228 Moved up to customize the virtuals.pl as either norsk or english!
                for( metacomp:optiprod(MP), metacomp:genprod(optional(MP),(MP,!)) ), %% RS-140921 Should not be any optiprod (because it aborts before assert)?
                prite((optional(_,[],X,X) -->[])), 
                write('%%% virtuals'), nl,
                for( metacomp:virtx(B),    metacomp:genvirt(B) ),
            told  % vs. close(VirtualStream), ?   %% RS-121121  appendfiles('dcg.pl','virtuals.pl',DCGFILE),
                                                  %% OLD STUFF: RS-140921   appendfiles('virtuals.pl','dcg.pl',DCG), %%% <--- NO! %%SEQUENCE MATTERS! below...
    ) ),  %% Only compile when MISSING or if gram_n is newer than dcg_n, OR gram_e NEWER THAN dcg_e
    compile( DCGMODULE:DCGFILE ),       %% RS-150105. ALWAYS compile the DCG-files!
    style_check(+singleton). %% SWI only

%%%%%%%%%%%%%%%%%%%%%
style_check(_).         %% Cheat for Sicstus Prolog (only used for SWI Prolog)
%%%%%%%%%%%%%%%%%%%%%

%% RS-131227 Copied from makeauxtables!
writeheader:-
    datetime(A,B,C,D,E,F),
    write('/* -*- Mode:Prolog; coding:utf-8; -*- */'),        %% Make this work with open/4 and encoding %% RS-121118
    nl,
    write('% Grammar files transformed to dcg_e.pl or dcg_n.pl '),
    nl,
    write('%%from writeheader in tuc/metacomp.pl'),
    nl, write('%% '), write(datetime(A,B,C,D,E,F)),
    nl,nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END makegram(Lang) %%%%%%%%%%%%%%%%%%%%%%%%%
%% MODULE CONSTRUCTION OF HEADERS %% RS-130101 Experiment, abandoned, reprogrammed as separete _e and _n procedures
%make_predname_argscount(X, Pred) :-
%        phrase_head_body(X,H,_Body),
%        Pred = (H)/x. %%Length.
%
%% This is clever: =.. is called the 'univ' predicate, to translate between list and predicate notation.
%phrase_head_body(P,H,B) :-
%        P =.. [H|B].
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

genprod(X,Y):-
    prod(X,Y,C),
    prite(C).
  

genvirt(A):-
    genprod(A,virtual(A)).

prod(X,Y,(MAX  --> YL)):-
    expandmetahead(X,T,A,Z,MAX),
    expandlist(Y,T,A,Z,YL).

expandlist((Y1,Y2),[H|T],A,Z,(MAX,YL)):-
    !,
    expandmeta(Y1,H,A,B,MAX),
    expandlist(Y2,T,B,Z,YL).

expandlist(Y,[H],A,Z,MAX):-
    expandmeta(Y,H,A,Z,MAX).



%% See http://www.cse.unsw.edu.au/~billw/prologdict.html#univ

expandmetahead( X, T, A, Z, MAX ) :-
    X =..[H|LIST],
    Parse=[H|T],
    append([H|LIST],[Parse,A,Z],YLIST),
    MAX =.. YLIST.


%% META-SECTION
%% em1( Symbol, Appearence, StackIn, StackOut, Code)
:- meta_predicate  em1( ?, ?, ?, -, ? ) .
:- meta_predicate  em0( ?, ?, ?, -, ? ) .
:- meta_predicate  em2( ?, ?, ?, -, ? ) . %% not implemented yet


expandmeta( X, P, Y, Z, MAX ) :-
    findmetavirts( X ),
    em1( X, P, Y, Z, MAX ).



em1( A-B, P, X, Y, (pushstack(free ,B,nil,X,BX),MAX)) :-  
   !,
   expandmeta(A,P,BX,Y,MAX).

em1(A\B,P,X,Y,(pushstack(first ,B,nil,X,BX),MAX)):-
   !,
   expandmeta(A,P,BX,Y,MAX).

em1(A / B,P,X,Y,(  

   lock(last,X,X1),
   pushstack(last ,B,nil,X1,X2),
   MAX,
   unlock(X3,Y))):-  
   !,
   expandmeta(A,P,X2,X3,MAX).


em1(A = B,P,X,Y,(

   lock(exact,X,X1),
   pushstack(exact ,B,nil,X1,X2),
   MAX,
   unlock(X3,Y))):-  
   !,
   expandmeta(A,P,X2,X3,MAX).


%% em1( Symbol, Appearence, StackIn, StackOut, Code)

em1(Symbol, Appearence, StackIn, StackOut, Code) :-
    value(norsource,true),
    !,
    em2(Symbol, Appearence, StackIn, StackOut, Code).

em1(Symbol, Appearence, StackIn, StackOut, Code) :-

    em0(Symbol, Appearence, StackIn, StackOut, Code).


em0(!,!,X,X,!):-!.  %% Standard rendering
em0([],[],X,X,[]):-!.
em0([U],lit(U),X,Y,cc(U,X,Y)):-!.    %%  lit(jeg) 
em0({M:P},{},X,X,{M:P}):-!. 
em0({P},{},X,X,{P}):-!.  %%     NB NB write   {P,Q} as {P},{Q}

em0(X,Free,A,Z,MAX):-
    X =..[H|LIST],
    append([H|LIST],[Free,A,Z],YLIST),
    MAX =.. YLIST.


%% not implemented yet
em2(!,!,X,X,!):-!. %% Rendering with whistles
em2([],[],X,X,[]):-!.
em2([U],lit(U),X,Y,cc(U,X,Y)):-!.    %%  lit(jeg) 
em2({M:P},{},X,X,{M:P}):-!. 
em2({P},{},X,X,{P}):-!.  

em2(X,Free,A,Z,MAX):- %% e.g. noun(bus,sin,u,n) 
    X =..[H|LIST],
    append([H|LIST],[Free,A,Z],YLIST),
    MAX =.. YLIST.
%%%




findmetavirts( _ / Z):-
    !,
    findvirtuals(Z).

findmetavirts( _ \ Z):-
    !,
    findvirtuals(Z).

findmetavirts( _ - Z):-
    !,
    findvirtuals(Z).

findmetavirts( _  = Z):-
    !,
    findvirtuals(Z).

findmetavirts(C):- 
    findmeta(C).


findmeta(optional(X)):-!,foundmeta(X).
findmeta(_).


foundmeta(X):-  %% TA-100114
    var(X),
    !,
    told, %% make message appear online
    nl,
    tell(user),
    write('¤¤¤ CATASTROPHIC ERROR ¤¤¤'),nl,
    write('*** Attempt to make a Variable Meta Production ***'),nl,

    told,       %% RS-140920 don't cut the error message before printing
    abort.      %% would (have) cut the error message before printing?

foundmeta(X):-
    assert( optiprod(X) ).
  
%--

findvirtuals((X,Y)):-
    !,
    findvirtual(X),
    findvirtuals(Y).

findvirtuals(X):-
    findvirtual(X).
    

findvirtual(X):- 
    var(X),
    !,
    told, %% make message appear online
    nl,
    tell(user),
    write('%%% CATASTROPHIC ERROR %%%'),nl,
    write('*** Attempt to make a Variable Virtual Production ***'),nl,

    told,

    abort.  %% will cut the error message before printing

    
findvirtual(X):-
   (X=[_];
    X=[];
    X={_};
    X=w(_)),
    !.

findvirtual( A ) :- 
    remembervirtx( A ), %% Must not get variable binding !!!!!
    functor( A, F, N),
%   remember( metacomp:virtf(F,N) ) % RS-140928
    remember( virtf(F,N) ).  %% RS-131230  virtual functors stored as  X --> virtual/6 later? 
    %remember( metacomp:virtf(F,N) ).  %% RS-131230 From declare.pl

remembervirtx(A) :-
    virtx(B),
    %utility:variant(A,B),      %% RS-131230 from utility.pl
    variant(A,B),               %% RS-140914 from utility.pl
    !;
    assert(virtx(A)).
    




prite((X-->Y)):-
    writeq(X),write(' --> '),nl,
    prist(Y).

prist(Y):- var(Y),!,
    write(' *** Fatal error : variable right side ***'),nl,
    plink.

prist((X,Y)) :-
    !,
    write('    '),writeq(X),write(','),nl,
    prist(Y).

prist(X):-
    write('    '),writeq(X),write('.'),
    nl,nl.

% In a module system, runtime system is user.


%% DEBUG prist
plink :- trace.


% http://stackoverflow.com/questions/16898156/how-to-concatenate-two-atoms-strings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    morph_file(english, MORPHFILE), %  use_module( MORPHFILE, [ ] ),     % morphology for E
%    atom_concat( PATH, MORPHFILE, MORPHURL ),
%    use_module( MORPHURL, [ ] ), % use_module( MORPHFILE, [ ] ),
%    morph_file( norsk, MORPHFILE ),   % morphology for N

%% RS-131230    Empty [ ] avoids colliding predicates from N and E.

compile_english( PATH ) :- %Prefix
    %dict_file( english, DICTFILE ), 
    dict_module( english, DICTMODULE ),
    atom_concat( PATH, DICTMODULE, URL ),
    use_module( URL, [ ] ),      % "COMPILE" dictionary for E
    gram_file(english, GRAMFILE),  atom_concat( PATH, GRAMFILE, GRAMURL ), use_module( GRAMURL, [ ] ),      % COMPILE grammar for E
    gram_module( english, GRAMMODULE ),                            % 'dcg_e'

    dagrun_file( english, DAGFILE ),   %% RS-131228 Moved up to customize the dcg.pl as either norsk or english!
    dcg_module( english, DCGMODULE ),   % dcg_file( english, DCGFILE),
    makegram( DAGFILE, DCGMODULE, DICTMODULE, GRAMMODULE, PATH ). % DICTFILE,

compile_norsk( PATH ) :-        %    makegram(norsk).
    %dict_file( norsk, DICTFILE ),
    dict_module( english, DICTMODULE ),
    atom_concat( PATH, DICTMODULE, URL ),    use_module( URL, [ ] ),    % dictionary for N

    gram_file( norsk, GRAMFILE ),  atom_concat( PATH, GRAMFILE, GRAMURL ), use_module( GRAMURL, [ ] ),     % grammar for N
    gram_module( norsk, GRAMMODULE ),

    dagrun_file( norsk, DAGFILE ),   %% RS-131228 Moved up to customize the dcg.pl as either norsk or english!
    dcg_module( norsk, DCGMODULE ),     %dcg_file( norsk, DCGFILE ),
    makegram( DAGFILE, DCGMODULE, DICTMODULE, GRAMMODULE, PATH ). % DICTFILE,

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%:- dcg_e:use_module( dcg_e, [ sentence/6 ]). % makegram/0, language/1 %  Common File for tucbus  (english) and  tucbuss ("norwegian"/norsk)
%:- dcg_n:use_module( dcg_n, [ sentence/6 ]). % makegram/0, language/1 %  Common File for tucbus  (english) and  tucbuss ("norwegian"/norsk)

sentence(DCG, A,B,C,D,E,F) :-
        DCG:sentence(A,B,C,D,E,F). %dcg_module(DCG),  use_module( DCG, [ sentence/6 ] ),  %% RS-150105. Does this take much extra time?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% metacomp:makegram -> library:for -> metacomp:genprod -> ??
%:- use_module( '../tuc/metacomp' ).     % [ genprod/2 ] (etc.?) is called in the for-predicate (etc.) %% RS-131117
                %% Used for calling      genprod(wx(adj2(_123,_124)),w(adj2(_124,_123))) (From gram_e or gram_n)!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RS-131229    When to do this?        HAS TO BE DONE FROM TUCBUSES!?
%:- makegram( RelPath ).    %% RS-140921    %?-compile_english.     %?-compile_norsk.

:- makegram( './' ). %% RS-141130 Move into gram_e/gram_n.pl??

