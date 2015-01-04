/* -*- Mode:Prolog; coding:utf-8; -*- */
% FILE main.pl
%% SYSTEM TUC
%% CREATED TA-930531
%% REVISED TA-110207
%% REVISED RS-131225    Modularized

%% Main program for BussTUC

%%% RS-131225, UNIT: /
%% USAGE?: :- use_module(  '../main' , [ traceprint/2, track/2 ] ). %%RS-141025

% c = compile % (::)/2 is used in inger and update2.pl! How does it work? %% RS-140208 %Extra? crash/0 is used a test of SPIDER etc.
%%% RS-131225, UNIT: /
:-module( main, [ abortword/1, assert_default_origins/1, backslash/1, begin/0, break/1, c/1, check/0, create_taggercall/2, dialog/0, difact/2,
        english/0, exetuc/1, fact0/1, gps_origin/2, haltword/1, idiotpoint/0,  logrun/0, norsk/0, ns/1,   % listxt/0, gorg/0, %% For debugging... (removed) %% RS-140928
        clearport/0, closefile/1, reset_period/0,  getfromport/1, gorg/0, % To writeout: indentprint/2 . For Dialog / Buster . %processorwait_d/1
        hei/0, hi/0, ho/0, run/0, jettyrun/1, language/1, mtrprocess/1, %Remove mtrprocessweb/1,         %RUN-predicates, with (very slow debugging!) and without debug.   % printparse/1,
        processorwait/1,  progtrace/2, r/1, readday/0, readscript/0, restart/0, reset/0, reset_origins/0,  run/1,  
        scanfile/2, (sp)/1, spyg/1, spyr/1, status/0, testgram/0, traceprog/2, translate2/2, tuc/0, update_compnames/1,
        % to utility/writeout.pl: track/2, statistics/1 (in bustermain2)
        value/1, version_date/1,
        webrun_english/0, webrun_norsk/0, webrun_tele/0, write_taggercall/1, writepid/0  % verify_empty_origins/0,  value/2
] ).

%% DYNAMIC SECTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:-volatile
         difact/2,    %% Dynamic,  context dependent  %% TA-980301
         fact0/1.     %% Semi permanent, in evaluate.pl
          

:-dynamic
         difact/2,    %% Dynamic,  context dependent  %% TA-980301
         fact0/1.     %% Semi permanent, in evaluate.pl

%% META-PREDICATES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%:- meta_predicate  for(0,0). % for/2. Stay inside the CALLING module? %% RS-141029
:- meta_predicate  sp(0).
%:- meta_predicate  track(+,0) .        %% RS-141026  Moved to utility/writeout.pl
%:- meta_predicate  trackprog(+,0) .

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% UNIT: / AND /utility/

:- use_module( declare, [ (:=)/2, (=:)/2, remember/1, set/2, value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .

:- use_module( 'utility/writeout', [ doubt/2, out/1, output/1, prettyprint/1, print_parse_tree/1, printdots/0, track/2 ] ).%% RS-140912

%Utility-functions %RS-141019 Moved to main.pl (To be accessable for the scripts.n)
%set( Key, Value ).


backslash('\\').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for/2. Stay inside the CALLING module? %% RS-141029
%for( P, Q ) :- %% For all P, do Q (with part of P). Finally succeed
%  P, Q, false ; true.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%:- meta_predicate  remember(0) .        %% RS-140928 Remember the facts IN THE MODULE THAT CALLS REMEMBER! Use  :  or  0
%remember( Module:F ) :- Module:F, ! ; assert( Module:F ).        %% Add F it is does not already exist.
%remember( Setting ) :- out( 'main:remember/1 => Something went wrong with:'), output( Setting ), output( call( Setting ) ).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % % % % % % % % % 

%% RS-1401019   Import predicates that are used ONLY in the batch test files, to avoid error warnings....
batchfile_predicates( 'utility/utility', [ startbatch/0, starttimebatch/0, stoptimebatch/0 ] ).  % pront/1, taketime/0, 
:- batchfile_predicates( File, PredList ), use_module( File, PredList ), fail ; true.
%% RS-140210. SAFER to include EVERYTHING, since starttimebatch/0 IS called from \r tests/batch.n for example
% starttimebatch/0,  %% RS-131225, reverse/2. Moved to lex.pl interactive: language/1, transfix/2,  % for/2,

%% RS-131225, UNIT: utility/
:- use_module( 'utility/utility', [ append_atomlist/2, append_atoms/3, for/2, makestring/2, psl/2, purge/3, shell_copyfile/2, starttime/0, writelist/1 ] ).  % pront/1, taketime/0, for/2, remember/1, %% LOOPS! RS-141029 
:- use_module( 'utility/library', [ reverse/2, shell/1 ] ).%% RS-131225
:- use_module( 'utility/ptbwrite', [ drucke_baum/1 ] ). %% drucke_baum_list/1, , ptbwrite/1, shrink_tree/2, indentprint/2 
:- use_module( 'utility/writeout', [ track/2, trackprog/2 ] ).
 
%% UNIT: EXTERNAL LIBRARIES
%:- use_module( library( aggregate ), [ foral/2 ] ).   %% RS-141029  for-all/2 Does NOT work like utility:for/2

:- use_module( library( process ), [ process_id/1 ] ).
:- use_module( library( system ), [ sleep/1 ] ).
:- use_module( library( timeout ), [ time_out/3 ] ). %% RS-140210. % :-prolog_flag(gc_trace,_,verbose).
 
%From BusterMain2, evaluate-modules (Use them instead?)
%% COMMON CO-VERSION: BUSS & TELE    difact/2, %% Dynamic,context dependent   fact0/1,Semi permanent, in evaluate.pl  %% TA-980301
%        quit/0,%        receive_tags/1,%        send_taggercall/1,     %% From getphonedir!

%% RS-131227    UNIT: /
:- ensure_loaded( version ).       %% RS-131227    With version_date/1

:- use_module( getphonedir, [ create_tags/1 ]).        %% RS-131227    send_taggercall/1, etc.
:- use_module( interfaceroute, [  reset_period/0 ] ).   % Interface procedures for handling interface to route modules
%:- use_module( sicstus4compatibility, [ tab/1 ] ).  %% Compatible with sicstus4, get0/1 etc.
:- use_module( tucbuses, [ legal_language/1, readfile_extension/1, script_file/1 ] ). % , language/1, %  Common File for tucbus  (english) and  tucbuss (norwegian)
%:-use_module( xmlparser, [ xmltaggerparse/2 ] ). %% RS-140102  For getphonedir.pl etc...

%% RS-131227    UNIT: db/
%% File containing TELEDAT %% co-existing with BUSDAT
:- use_module( 'db/teledat2', [ teledbrowfile/1 ] ). %% RS-131231 , teledbtagfile/1
%% Time data for bus routes in general
:- use_module( 'db/timedat', [ create_named_dates/0 ]).

%% RS-131227    UNIT: dialog/
%:- use_module( 'dialog/checkitem2', [ trackprog/2 ] ).  %% RS-130329 dialogrun0/0 
:- use_module( 'dialog/d_dialogue', [ dialogrun0/0 ] ).  %% RS-130329 dialogrun0/0 

%% RS-131227    UNIT: tuc/      dcg_module %% RS-141122
%% RS-130329 Make sure (gram/lang) modules are available: 1: gram_n -> ( 2: metacomp ) -> 3: dcg_n   (The same for English)
:- use_module( 'tuc/metacomp' ,[ dcg_module/1, sentence/7 ]). % makegram/0, language/1 %  Common File for tucbus  (english) and  tucbuss ("norwegian"/norsk)

:- use_module( 'tuc/anaphors' , [ resolve/2 ] ).       %% RS-131227
:- use_module( 'tuc/evaluate', [ evaluateq/1, evaluateq2/1 ] ). %% RS-131224      fact0/1 and difact/2 are is DANGEROUS? Dynimic in user:declare...
        %% Moved to lex? ctxt/3, txt/3, maxl/1 %% RS-131225
        %% Semi-tagger (quasi multitagger)
:-use_module( 'tuc/lex', [ decide_domain/0, lexproc3/3, maxl/1, mix/2, no_unprotected_verb/0, spread/1, unknown_words/2 ] ).


:-use_module( 'tuc/readin' ). %%, [  ask_file/1, ask_user/1, read_in/1, words/3  ]). %%  Read a sentence into a list of symbols
:-use_module( 'tuc/translat', [  (=>)/2, transfix1/2  ] ).        %% RS-131227 -141026 clausifyq/2, clausifystm/1 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Main program

%% RS-141015 Import gps_origin from where it is defined! Or get it from the user... E.g utility:gps_origin (stored in user:)?
:-volatile  gps_origin/2 . %% TA-110127   %% Set by user input: Station +minutes
:-dynamic   gps_origin/2 . %% TA-110127

%       webstat/3.  % webstat(date(2009,04,21),#sms,#tot). %% Where is this counted?
%       (::)/2,        %% RS-131228 For inger.pl ,         %% How does it work?

:-op( 1150, fx, spyg). %% spy grammar rule
:-op( 1150, fx, spyr). %% spy pragma rule
:-op( 1150, fx, sp).   %% spy X,X
:-op( 1150, fx, c).    %% consult file  %% TA-110106 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% from declare.pl %progtrace(X,Y) :- user:traceprog(X,Y).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% same as traceprog
progtrace( N, P ) :-
    value(traceprog,M), number(M), M >= N, 
    !,
    write(P),nl
;
    true.

gorg :- listing( main:gps_origin ). %% debug %% TA-110128

break(_). %% dummy for breakpoints


% c(File) :- consult(File). %% TA-110106 %% Moved down 


%crash :- tore_amble_is_a_genious.  %% test on undefined predicate

spyg X :- dcg_module(L), 
          parsetime_limit := 100000, %%  ONLY FOR DEBUGGING
          spy L:X. %% utility

spyr X :- ( debugrule := X ),
          spy pragma:spy_me.

sp Module:X :- functor(X,F,_), spy F, Module:X.  %% call X with spy on X


%% Strategy for switching language

% Presume there is an assumed language from the start
% e.g. the WEB  server is for a specific language (bustuc/busstuc)

% Try lexproc in the current language
% If unknown words, try the other language
% If the other language results in fewer unknown words, 
%  select this language TEMPORARILY (for this question)
% even if there are unknown (but fewer) words

%% SYSTEM COMMANDS

%% Menagerie of Start commands in decreasing order of severity

readscript:-
    script_file(X) -> 
       readscript1(X);
       true.

readscript1(X):- 
%%%%%%%%%%%%%%%%%%%%	 assert(lastday(-1,noday)),
    trace := 0,
    erase,  
    readfrom(X),
    trace := 1.


% Default settings. May be redefined

initiate :-   %% called at compiletime !  RS-131227
    trace:=1,      
    maxdepth:=3,   
    error_phase:=0,
    context_id := 1.

%%%    parsetime_limit := 10000. %% Max 10 seconds for parsing
                              %% 45/ MegaLIPS is appropriate

tuc:-        
    initiate, 
    start.      

start:-
    tuc_version,     
    erase,
    clear1,
    run.

restart:-  
    erase,
    clear, 
    run.

erase:-
    retractall( fact0(_) ),  % Semipermanent facts
    skolemax := 0,  
    skolocon := 0, 
    reset.

clear:- 
    nodebug,  % somewhat ugly
    nospyall, % messages
    clear1.

clear1 :-
    dialog := 0, 
 %% Only complete queries, with defaults ( should be true/false ?)
    trace :=1,  
    traceprog :=1, 
    traceans := 1,
%%    queryflag := true, 
%%    textflag := false,
    spellcheck := 1,   %% restored after debug 
    closereadfile,       
    parsetime_limit := 10000, %%% <--- Same as initially// Slower server
    reset.  

begin :-
    reset,
    permanence := 1,
    nl.

reset:-  
    dialog := 0, % moved up
%    textflag := false, 
    retractall( difact(_,_) ),   %% Only Dynamic (DIscourse) Facts
    retractall( (_ => _) ),
    lemmas_proved := 0,  %%
    interp := 0,         %%
    (skolemax =: SZ -> skolocon := SZ; skolocon := 0), 
    const := 0. 


norsk   :- 
    (origlanguage := norsk), % permanently 
    (language := norsk). 


english :- 
    (origlanguage := english), % permanently 
    (language := english).  
 
run(L):- 
   language := L,
   run.
    

run :- 
    nl,
    (seen),              %% evt. read-files
    dialog:=0, 

    reset_period,   

    create_named_dates, %% TA-100105 



    go.


logrun :- 
    nl,
    (seen),
    golog.

webrun_english :-
    language:= english,
    dialog := 0, 
    webrun ; true . % (Never gets to this point from endless loop in webrun)


webrun_norsk :-
    language :=norsk,
    dialog   := 0,  
    
    traceprog := 3, %% EXPERIMENT DEBUG

    webrun ; true . % (Never gets to this point from endless loop in webrun)



webrun_tele :-
    language :=norsk,
    dialog   := 0,  

	 writepid, 
    set_prolog_flag(fileerrors,off),

    repeat,
       world := real, 
    
       getfromport(L),
	    processorwait(L),
	    fail,
         ! ; true.     %% Never reaches this point!

webrun :-
	 writepid,
         %%write("Executing webrun"),
    set_prolog_flag(fileerrors,off),
    busflag:= true,    %%  Bustuc Application Program
	 queryflag := true, %% Statements are implicit queries
    create_named_dates, %% TA-110615
    repeat,
       world := real, 
       reset_period,       %%   ---> topreg.pl

 %%%       reset_origins,  %% reset GPS origins %% TA-110206

	    getfromport(L),
	    processorwait(L),

       fail,    % Never succeed, endless loop
	 ! ; true.     %% Never reaches this point!


dialog :-  
	 nl,
	 (seen),
	 permanence := 0, 
	 dialog := 1,   
%    queryflag := true,       %% (Statements are implicit queries)
    closereadfile,   
    dialogrun0.         % dialog/d_dialogue.pl   



hi :- % language := english,
    create_named_dates, 
%    debug,
     trace,
    go.


hei :- % language:= norsk,
    reset_period,   

     create_named_dates, 
     debug,
%     trace,
    go.


ho:-
    create_named_dates, 
    clear,
    go.

go :-
    bad_language,  % exit if undefined LANGUAGE
    !.

go:-
    permanence := 0, 
    restoreworld,
	 closereadfile,  

    repeat, 
       nl,

       reset_period,  %% interface_route.pl necessary here for restarts
       
 %%      reset_origins, %% reset GPS origins

       origlanguage =: Lang, 
       language := Lang,

       doask_user(L),
       process(L).



% Added by MTR 2004-08-04.  This predicate is called (repeatedly) from
% the TUC Transfer Protocol Daemon (TTPD).
mtrprocess(S) :-
        smsflag := true,  
        permanence := 0, 
        create_named_dates, %% TA-110408 ad hoc 
        restoreworld,
        closereadfile,  
        reset_period,    
        origlanguage =: Lang, 
        language := Lang,
        words(L, S, []),        %%      RS-130331
        process(L).             %% NB: process ALWAYS FAILS!

%mtrprocessweb(S) :- 
%        smsflag := false,  
%        permanence := 0, 
%        restoreworld,
%        create_named_dates, %% TA-110408  ad hoc
%        closereadfile,  
%        reset_period,    
%        origlanguage =: Lang, 
%        language := Lang,
%        words(L, S, []),  %% RS-130331    "String" to tokens, straight
%        process(L).


jettyrun(S)  :- %% This was gone so I reimplemented it. %% TE-120207
%%      psl(S,L),         %% RS-130331    String to tokens, via file, calls words.
%%	OR "String" to Words directly
        words(L, S, []),  %% RS-130331    String to tokens, straight?
        L = [File|L1],  %% RS-130331    Get (optional) Filename
        open(File,write,Stream,[encoding('UTF-8')]),   %% RS-130504
%%        open(File,write,Stream,[encoding('ISO-8859-1')]),   %% RS-121121
%%RS-130621 Make a separate isorun for this, to avoid conflicts between atb and busstuc.idi
        set_output(Stream),

        permanence := 0, 
        restoreworld,
        create_named_dates, %% TA-110408  ad hoc
        closereadfile,  
        reset_period,    
        origlanguage =: Lang, 
        language := Lang,
        %%words(L, S, []),  %% RS-130331    "String" to tokens, straight

        smsflag := false, %% RS-130401, possibly re-set in the next line!
        splitlang(L1,L2),       %% RS-130504, handle " nor / eng " (followed by) " sms "
        (process(L2);true), % Process always fails...
        %% flush_output,        %% RS-130401 Called from the client-side! TTPD
        told.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Added by MTR 2004-08-04.  This predicate is called (repeatedly) from
% the TUC Transfer Protocol Daemon (TTPD).
%mtrprocess(S) :-
%        smsflag := true,  
%        permanence := 0, 
%        create_named_dates, %% TA-110408 ad hoc 
%        restoreworld,
%        closereadfile,  
%        reset_period,    
%        origlanguage =: Lang, 
%        language := Lang,
%        words(L, S, []),
%        !,
%        process(L).     %% NB: process ALWAYS FAILS!


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

language(L) :- value( language, L ). %% value(language,X) should have been set dynamically by now! In tucbuses?

restoreworld :- 
    (world =: _W_) -> true;
    world := real.

golog:-
	 closereadfile,  

    repeat, 
    nl,
	 reset_period, 
  
%%     reset_origins, %% reset GPS origins %% TA-110204
  
    doask_user(L),
    writelog(L),
    process(L).

end :-  
    (seen),
    permanence:=0,
    world := real.

bad_language :- 
    \+ language(_),
    !,
    nl,out(' *** No defined  language! REMEMBER: compile(busstuc).'),output(' ***').

bad_language :-
    language(L),
    \+ legal_language(L),
    !,
    nl,out(' *** Undefined  language:  '),out(L),output(' ***').


%%%%%%%%%%%%%%%%% Other Commands

tuc_version:-
    version_date(V),     %% version.pl
    nl,nl,               %%
    output(V).        

check:- % Check consistency
     evaluateq(explain:::false). 

status:- 
   nl,output('Rules:'),nl,
   for( A => B ,   prettyprint( A => B) ),
   nl,output('Facts:'),nl,
   for( fact0(X),   prettyprint(X)), 
   for( difact(UID,X),   prettyprint(UID:X)),   
   track( 2, ( nl, output('Flags:'), nl, listing(value/2) ) ).

testgram :- 
%    dcg_module(DCG),
%    spy(DCG:sentence/6),
%    spy(DCG:statreal/6),     
%    spy(DCG:do_phrase/10),  
    spy(sentence/6),
    spy(statreal/6),     
    spy(do_phrase/10),

    spy(evaluate:qev/1),       
    trace := 3,
%%     spellcheck :=0, %% debug makes it slow // not any longer 
    parsetime_limit := 100000.  %% ONLY DEBUGGING



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


writepid :-
        process_id(Pid), %sicstus4
%sicstus4        pid(Pid),
        open('.serverpid',write,Port),
        write(Port,Pid),
        close(Port).
writepid.


writelog(L) :-  
	 open('tuclog.txt',append,Stream) ->
	 writets(L,Stream) ;
	 writeiofail.

writets(Tokens,Stream) :-
	 writets1(Tokens,Stream),
	 close(Stream).

writets1([],Stream) :-
	 write(Stream,'\n').
writets1([Token|Rest],Stream) :-
	 write(Stream,Token),
	 write(Stream,' '),
	 writets1(Rest,Stream).

writeiofail :-
	 write('Warning: Could not write to logfile tuclog.txt'),nl.

%  

getfromport(L) :-
	 open('.port',read,Port),
	 ( read(Port,query(L)) ; L = [] ), 
        

	 close(Port),
	 !.
getfromport([]).  % Else. 


processorwait([]) :-
	 sleep(1),
	 !.

processorwait(S) :-
	 psl(S,L),
    splitlang(L,L1),  

    redirecttoans, %% <-------------- 

    (process(L1);true),          % Process always fails...
 

 
   redirectfromans,

    clearport,
    !.



redirecttoans:- 
    value(teleflag,true), \+value(busflag,true), 
    !. %% Not Yet

redirecttoans:- 
   trytellans. 


redirectfromans:-
   value(teleflag,true), \+value(busflag,true),
   !,

   teledbrowfile(Rowsample0), 

   shell_copyfile(Rowsample0,'.ans').


redirectfromans:-
   told,
   !.
 
  

%% From Web

%  Perl script will always add a language prefix
%  SMSFLAG is set dynamically !

splitlang(L,Netto2):- %%   If not prefix nor,eng assume no prefix
 
    ( L= [eng|Netto] -> (  language := english); 
 
        L= [nor|Netto] -> (language := norsk);
 
            ( Netto=L,     language := norsk )
    ),
    splitsms(Netto, Netto2) . 

%%RS-130627 Separate LANG and SMS codes! Inclusive OR
%%( ENG -> english ; 
        %% OR NOR -> norwegian
                %% OR just norwegian (default)
%% Same check for SMS -> sms OR default NO sms

splitsms(S,Netto):- %%   If not prefix sms assume no sms
 
   S= [sms|Netto] -> ( smsflag := true ) ; ( Netto=S , smsflag := false ). 



trytellans :- 
        %%tell('.ans')   %% RS-121121
        open( '.ans', write, Stream, [encoding('UTF-8')] ),
        set_output(Stream).

trytellans :-
    sleep(1),
    trytellans.                       % Redo above instance until it succeeds
 
clearport :-
	 open('.port',write,Port),
	 write(Port,'query([]).'), 
	 close(Port).
clearport :-       
    sleep(1),
	 clearport.                             % Redo above instance until it succeeds

readday:-  
   write('weekday ='),nl,
   read(Today),
   (today := Today).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

c(F) :- consult(F). 
r(F) :- readfrom(F).
ns(F) :- readfrom(F). %% TA-110207  %% RS-141019 What is NorSource ?

norsource(F) :- %% TA-110207
    set( norsource, true ),
    readfrom(F),
    set( norsource, false ).


closereadfile :-   % if interrupted 
    (readfile =: OLD -> closefile(OLD);true),
    (seen).

closefile(F):-
    absolute_file_name(F,FS),
    current_stream(FS,_,X),close(X),!;true.

% Flags may not be reset if readfrom is interrupted !

readfrom(F):- 
    closereadfile, 
    end_of_file := false, 
    readfile_extension(X),
    append_atoms(F,X,FE), 
    permanence := 1,

    trace =: OldTrace, %% NB =:  
    trace := 0,


%     textflag := true,        %  Read from text, don't skip to new Line
%                              %  destroys  kl. 1720 in batch queries
%    queryflag =: Oldqueryflag,%  destroys setting in startupfile
%    queryflag := false,       %  Statements are not implicit queries 

    readfile := FE,   
    see(FE),
        repeat,
            reset_period,  
            
 
       ask_file(L),    % readin.pl
            process(L),     

      
    !,
    (seen),

    trace := OldTrace, %% TA-090203

    permanence := 0.

%%    textflag := false,       %  Read from text, don't skip to new Line 
%%    queryflag :=   Oldqueryflag. % destroys setting in startupfile



scanfile(F,L):- %%  DESTROYS  web writing
    see(F),     
    read_in(L),
    (seen).   

 
doask_user(L):-
    interp := 0,  
    ask_user(L).        %% readin.pl


process(_):-
    bad_language,
    !.


/************************************ 
process([GWB|_]):- %% Provoked Abortion
    abortword(GWB),
    !,
    abort.    

process([GWB|_]):- %% Provoked Halt
    haltword(GWB),
    !,
    halt.
*******************************/



%¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

%% NEW  %% OMNITUC !

%process_forel(FOL):-
%    transfix(FOL,TQL),
%    prettyprint(TQL),
%
%    exetuc(TQL).
 

%¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤



process(L):-           %% Process is under a repeat loop
    error_phase := 0,
    language     =: O1, 
    origlanguage := O1,

    printdots, %% TA-110204

    translate2(L,TQL),
    nl,

    ( value( textflag, true ) -> 

        copy_term( TQL, TQLNV ), %% dont bind variables
        drucke_baum(TQLNV)
          
               ; true),
   
%%     user:track(2,gorg), %% listing gps-origins %% TA-110223

    exetuc(TQL),       %% Always succeed (command may change origlanguage)
    
    norsource_postfix, 

    origlanguage =: O2,
    language :=     O2, % 

   
  
    (TQL=end;  
     TQL=stop).        %% Succeeds and  exit when stop command.


abortword( georgewarrenbush ). %% <- Top Secret
haltword( johnforbeskerry ).   %% <- Top Secret


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% translate2

      %% Produces a TQL expression from a List
      %% If a stop command appears, TQL = stop
      %% If an end command appears, TQL = end
      %% If an error occured,       TQL = error
      %% Otherwise,                 TQL = command(P).


translate2(L,TQL):-  
    track(1,nl),
 
    new_origin := false,  %% ugly reset explicit  new_origin flag %% TA-110206

    analyse2(L,TQL).



analyse2(L,Stop):- 
    stopcommand(L,Stop),
    !.

analyse2(L,command(Rosenborg)):- 
    othercommand(L,Rosenborg),
    !.

analyse2(L1,TQL):-      

    \+ value(teleflag,true),
    !,


    lexproc3(L1,AssumedLanguage,L2),

    language := AssumedLanguage,

 track( 4, utility:pront(L2) ), %% TA-110218

    error_phase:= 0, 


    layout2(L2,TQL), 
    print_tql(TQL), %% TA-110207

    !.


analyse2(L1,TQL):-      

    value(teleflag,true), \+ value(busflag,true),
    !,

    create_tags(L1),  %%%   _TAGS) , 

    !,   

    lexproc3(L1,AssumedLanguage,L2),

    language := AssumedLanguage,
     
    error_phase:= 0, 

    starttime,    

    layout2(L2,TQL), 
    present(1,TQL),

    !.

analyse2(_,error).


print_tql(TQL):- %% TA-110207
   value(norsource,true),
   output('<tql> '),
   !,
   prettyprint(TQL),
   output('</tql>').

print_tql(TQL):-
   present(1,TQL).


startteleerror :-
    value(teleflag,true), \+ value(busflag,true), 
    !,
    teledbrowfile(TDBR),
    %%tell(TDBR)   %% RS-121121
    open( TDBR, write, Stream, [encoding('UTF-8')] ),
    set_output(Stream).

startteleerror :-!.


stopteleerror :-
     value(teleflag,true),\+ value(busflag,true), 
     !,
     told.

stopteleerror :-!.

grammar2(L,error) :-     
    value(notimeoutflag,true),
    length(L,M),M > 21, %% Temporary Emergency 
    !,
    startteleerror,
       nl, 
       doubt('- - - Sentence is too long and complicated - - -  ', 
             '- - - Setningen er for lang og vanskelig - - - '),
       nl,
    stopteleerror.




grammar2(L,error):-                % Failed with type check,
    unknown_words(L,Z), 
    \+ (Z == []),  
    !,                             % => Incomprehensible (therefore)
 
    startteleerror,

       nl, 
       doubt('- - - Incomprehensible words: ', %% '-'  means No Pay 
             '- - - Uforståelige ord    '), %% Freak test AtB drops list of words
                                         %% after : ????
                                         %% TA-101201

       writelist(Z),nl, nl, %% avoid [ ] which are rendered as blank e on some mobile
    stopteleerror.



grammar2(_,FOL):-   
    cursor := 0,
    maxl(N),

    parse_sentence(P,N,Success),  %% RS-141122  ( ProgramGenerated, NumberOfWords?, OK-flag )

    (Success == success -> true; 

     (    startteleerror,
             nl,   
             doubt('- - - Sentence is too difficult - - -',   %%  vague on 
                   '- - - Setningen er for vanskelig - - -'),    %%  purpose
             nl,
          stopteleerror)
     ),

    !,                         %% <------- One solution   


    present(4,P), 

    resolve(P,Q),            %%  (Short Circuit Scopes)
    !, 

    present(3,Q),  

    Q = FOL.



grammar2(L,error):-
    value(semantest,true), 
    error_phase := 1,                % Reset Type check
    value(cursor,Attempt1),
    maxl(N),
    cursor := 0,                     % Failed with type check, but
    parse_sentence(_,N,success),
    !,                               % => Meaningless (semantically)

    startteleerror,

       nl,                             
       doubt('- - - Meaningless at * - - -',
             '- - - Meningsløst ved * - - -'),
       mix(Attempt1,L),

   stopteleerror.


grammar2(L,error):-                  % Incomplete sentence 
    \+ value(teleflag,true),            % not actual for tele
    no_verb(L),                      % no verbs
    !,

    startteleerror,

       nl,                              
       doubt('- - - Please use a complete sentence - - -',
             '- - - Vennligst bruk en fullstendig setning - - -'),
       nl,

    stopteleerror.

grammar2(L,error):-                  % Failed also with type check
    value(cursor,Attempt2),          % =>  Ungrammatical (according to gram),
    nl,                              

    startteleerror,

        doubt('- - - Incomprehensible at  * - - -',
              '- - - Uforståelig ved * - - -'), 
        mix(Attempt2,L),

     stopteleerror.


% % % % % % % % % % % % % % % % % % %
%% Uses dcg_n or dcg_e (Generated from gram_n or gram_e).


parse_sentence( P, N, Success ) :-  %% Parse With TimeLimit
    dcg_module(G),      %   use_module( G, [ sentence/6 ] ),
    value(parsetime_limit,Limit),   

    time_out(   %%  library(timeout) contains time_out/3. RS-140210 

        sentence( G, P, Parse, [], [], 0, N ),    %% RS-141122 (dcg-Language, TQL-Program, ParseTree, StackIn, StackOut, Start-index, Stop-index)
        Limit,
        Success),

   ( Success == success -> Parse1=Parse;Parse1=time_out),

    print_parse_tree(Parse1). %% TA-110207

%print_parse_tree(Parse1):- %% TA-110207
%   value(norsource,true),
%   !,
%   shrink_tree(Parse1,Pa1),
%
%   output('<tree> '),   prettyprint(Pa1),  output('</tree>'),nl.

   
%print_parse_tree(Parse1):- %% TA-110207
%   track(4, printparse(Parse1) ), %%  print proper parsetree
%   track(2, writeout:output('*** Simplified parse tree ***') ),
%   track(1, ptbwrite:ptbwrite(Parse1) ), %% -> ptbwrite.pl
%   track(2, (writeout:output('*****************************'),nl) ).

no_verb(_L) :-!, no_unprotected_verb. %% TA-090529


no_verb(L) :- \+ verbed_sentence(L).  %% no_unprotected_verb

verbed_sentence(L):- 
    member(W,L), 
    W = w(R,ListV),
    R \== når,                % = nå = now (doesn' count)
    R \== nå,  
    R \== så,  
    (member(verb(_,_,_),ListV);
     member([skal],ListV); 
     member([vil],ListV);   %%
     member([må],ListV)),   %%
   !.

present(_,nil):-!.      % code printed by side effect 
present(_,[nil]):-!.    % code printed by side effect 
present(_,[nil|_]):-!.  % code printed by side effect 
present(_,error):-!. %% NB NB NB 

present(N,P):- 
    copy_term(P,Q),
    track( N, writeout:prettyprint(Q) ),
    track( N, nl). 

%%%%%%%%%%%%%%%%%%%%%%%%


value(X):-
    value(X,Y),
    out(X),out('='),writeout:output(Y),nl.


    




%% Layout Text as TUC Query Language code

layout2(L,TQL):- 
    spread(L),

%%%     proxytag, %% TA-101027 -> lex/proxyclean

    track( 2, (nl, writeout:output('*** Word graph ***'),nl)), 
    %user:track( 2,  listxt ), 
    track( 2,  listing( lex:txt ) ),
    track( 2, nl ),  
    track( 2, ( write('******************'),nl,nl)),

    decide_domain, %%  which part of country

 
    cursor := 0,
 
    starttime,  

    grammar2(L,FOL),

    track( 2, (nl, utility:taketime, nl) ),    %% Get time even if timeout

    reset_origins,  %% TA-110206  HERE RESET_ORIGINS

    transfix(FOL,TQL).


% listxt :- listing( lex:txt ). %% RS-140615 Modularized (not in main, but in lex(?) )


%%  Execute command

exetuc(C):-
  exetuc1(C).

  
exetuc1(error) :- !.   % executed as side effect
exetuc1(stop) :- !.    % executed by loop exit
exetuc1(end) :- !,end. % executed by end command
exetuc1(new) :- !.     % ad hoc

exetuc1( command(P) ) :-
    !,
    anash(P).           % Analyze (Execute) \ "slash" (shell or prolog) command

exetuc1( _TQL ) :-
    value(noevalflag,true),!. %% New Flag  : No TUC-evaluation

exetuc1(TQL):- 
    trackprog( 2, listing( gps_origin ) ), %% gps_origin stasjon+1, stasjon+4 etc. %% TA-110130 %% RS-140615
    evaluateq2( TQL ). %% evaluate.pl




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


stopcommand([BS],stop):- 
     backslash(BS),
     !.

stopcommand([BS,end|_],end):- 
    backslash(BS).         %% \ , prolog Dependent 


othercommand([BS|R],Rosenborg):- 
    backslash(BS),
    !,
    anaslash(R,Rosenborg).        %% utility.pl

anaslash(C,D):-
    anaclean(C,D),
    !.

anaclean([],[]). 

anaclean([X],[]):-     %% drop last punctuation
    member(X,['.','!','?']),
    !.
anaclean([U|V],[U1|V1]):-
   anac1(U,U1),
   anaclean(V,V1).

anac1(quote(X),X):-!.
anac1(X,X).



% Analyse slash commands

anash( [] ) :- !.  

anash( [c,P] ) :- !, 
    consult(P).

anash( [c,Dir, '/' ,P] ) :- !,   %% \c app/negans 
    
%%     prolog_flag(redefine_warnings,_,off), 
    
    appfilename(Dir,P,Q),
    consult(Q).

anash( [compile,P] ) :- !, 
    compile(P).

anash( [compile,Dir, '/' ,P] ) :- !,  
    appfilename(Dir,P,Q),
    compile(Q).

anash( [u|U] ) :-!,  
    makestring(U,V),  
    shell(V). 

anash( [r,F] ) :-!,
    readfrom(F).

anash( [r,Dir, '/' ,P] ) :- !,  %% \r tests/kristin 
    appfilename(Dir,P,Q),
    readfrom(Q) ; ( !, output(' Could NOT read file !!! ') ).


anash( [ns,F] ) :-!, %% TA-110207
    norsource(F).

anash( [ns,Dir, '/' ,P] ) :- !,  %% TA-110207
    appfilename(Dir,P,Q),
    norsource(Q).


anash( [spy,Module,:,Plist] ) :-
    %Callp =.. Plist,
    !, call( spy Module:Plist ). % ! to Avoid crash on "catch-all anash" at the bottom below.

anash( [spy,Plist] ) :-
    %Callp =.. Plist,
    !, call( spy _:Plist ). % ! to spy on the given Predicate list in ANY module?!


anash( [listing,Module,:,Plist] ) :-
    %Callp =.. Plist,
    !, call( listing( Module:Plist ) ). % ! to Avoid crash on "catch-all anash" below.

anash( Plist ) :-
    Callp =.. Plist,
    call( Callp ).


appfilename(Dir,P,DirP):- 
    append_atoms(Dir,'/',Dir1),
    append_atoms(Dir1,P,DirP).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


update_compnames(Compnames) :-                  %% MTK 021018
    ( compnames := Compnames ).





idiotpoint. %% 
 
%send_taggercall(Taggercall):-  %% CRITICAL
%     write_taggercall(Taggercall).

%receive_tags(Struct):- 
%
%    teledbtagfile(Tagsample),    
%
%    xmltaggerparse(Tagsample,Struct),
%
%
%    nl,nl,
%    output(Struct).


   


%update_tags(K):-  
%
%   tags := K.


create_taggercall(L2,PAT):-
    listtoplus(L2,P2),
    plustoatom(P2,PAT).

 

write_taggercall(Taggercall) :-
    nl,
    write('TAGGING:   '),output(Taggercall),
    nl,nl.

listtoplus(L2,P2):- %% tricky  + is left assoc
    reverse(L2,R2),
    
    skipmarks(R2,R3),

    ltoplus(R3,P2).

skipmarks(R2,R3):-
   purge(['.','?','!'],R2,R3).

ltoplus([Z,Y|X], ( UY+Z)):-
    !,
    ltoplus([Y|X],UY).

ltoplus([X],X).

plustoatom(A+B,AB):- !,%% jævla hack
    plustoatom(A,A1),
    plustoatom(B,B1),
    append_atomlist([A1,'+',B1],AB).
plustoatom(X,X).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FOR DEBUGGING
%%  trace traceprog -> write
%%  track trackprog -> call
%%  trace/track vs. write/call       %% RS-141025

%trace( N, P ) :- 
%    value( trace, M ), number(M), M >= N, 
%    !,
%    write(P),nl
%;
%    true.

traceprog( N, P ) :- 
    value( traceprog, M ), number(M), M >= N, 
    !,
    write(P),nl
;
    true.

% MOVED to dialog/checkitem2.pl
%trackprog( N, P ) :-
%    value( traceprog, M ), number(M), M >= N,
%    !,
%    ( nl, call(P) )    %% TA-110130
%        ;
%    true. %% Finally, succeed anyway
%
% % % % % % % % %




%%% FOR GPS %%%


%% Control Section

assert_default_origins( X ) :-
        output( 'GPS locations: '), out( X ), nl,nl,
        remember( gps_origin( 'Gløshaugen syd', 3 ) ). %% RS-141026    NOT properly implemented yet!!!

transfix( [gpsflag:::Orgy | Rest], U ) :-!,

    %%( Orgy \== [] -> smartdepflag := true ; smartdepflag := true ), %% if gps, special output
     (smartdepflag := true), %% Quickfix to allow json output to all queries. %% TE-120206

    for( member( gps_origin(X,Y), Orgy ),
           remember( gps_origin(X,Y) ) ),       % remeber( main:gps_origin(X,Y) )
       transfix(Rest,U).


%% Several statements 
transfix([[]],[replyq('?')]):-!.  %% Avoid empty answers (by synonym)

transfix([X|Y],[X1|Y1]):- 
    !,
    transfix1(X,X1),
    transfix(Y,Y1).
transfix([],[]):-!.

transfix(P,Q):-transfix1(P,Q). %% PANIC

    

 
reset_origins :- %% TA-110128
    retractall( gps_origin(_,_) ),
 
%%%    traceprog( 3,reset_origins),
    trackprog( 3, verify_empty_origins ). %% TA-110206

verify_empty_origins :- %% all gps_origin should be gone !!!!!!
    gps_origin(X,Y) -> 
        ( write('***'),write( gps_origin(X,Y) ) )
         ;
         true.

%%% OLD %%%
   %% RS-140928 Keep in declare: track/2, ?


%%%%%%%%%%%  THE END %%%%%%%%%%%%%%%%%%%%%%

%:- makegram.    %% RS-140921    %?-compile_english.     %?-compile_norsk.
:- initiate.

