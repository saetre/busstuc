/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE bustermain2.pl
%% SYSTEM BUSTER
%% CREATED  TA-930531
%% REVISED  TA-090617
%% REVISED  RS-140101 modularized

%% Try to use JUST main.pl INSTEAD?

%% COMMON CO-VERSION: BUSS & TELE
%        difact/2,       %% Dynamic,  context dependent  %% TA-980301
%        fact0/1,        %% Semi permanent, in evaluate.pl
        %Compilation predicates?
:-module( bustermain2, [ begin/0,        break/1,       c/1,            check/0,       crash/0,        create_taggercall/2,
        dialog/0,      dialogrun0/0,   english/0,      hei/0,         ho/0,      %% hi/0,         See d_dialogue
        indentprintlist/2,     listxt/0,      logrun/0,        norsk/0,        plustoatom/2,  printparse/1,   %%        progtrace/2,
        quit/0,        r/1,           readday/0,      readscript/0,   restart/0,      run/1,
        scanfile/2,    (sp)/1,         spyg/1,         spyr/1,         statistics/1,   status/0,
        testgram/0,    trackprog/2,    tuc/0,        update_compnames/1, %, user:value/1, (from declare.pl)
        webrun_english/0,      webrun_norsk/0, webrun_tele/0,  write_taggercall/1
] ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%:- volatile
%        ( => )/2,    %% See declare.pl (dynamic) & translat.pl (assert)
%        difact/2,    %% Dynamic,  context dependent  %% TA-980301
%        fact0/1.     %% Semi permanent, in evaluate.pl

%:- dynamic
%        ( => )/2,    %% See translat.pl
%        difact/2,    %% Dynamic,  context dependent  %% TA-980301
%        fact0/1.     %% Semi permanent, in evaluate.pl

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RS-131225, UNIT: /   %% RS-131225, UNIT: utility/
:- ensure_loaded( user:'declare.pl' ). %% RS-131228 "new syntax" defs, META-preds: for/2, remember/1, value/2, :=/2, =;/2
:- use_module('utility/utility'). %% RS-120816 sequence_member, etc.

:- use_module(library(timeout)). 
:- use_module( 'utility/library' ).  %% RS-131225
%:-use_module( 'utility/datecalc', [ datetime/6 ]).%% RS-131225    For app/buslog, telelog, etc?

%% RS-131227, UNIT: EXTERNAL LIBRARY
:- use_module( library(process) ). %% , [exec/1,shell/1]). RS-131227 Investigate this ;-)

%% RS-131224  calls the for-predicate  %% Used in FOR from makeauxtables
:- use_module( getphonedir, [ create_tags/1 ]).        %% RS-131227    send_taggercall/1, etc.
%:- use_module( interfaceroute, [  reset_period/0  ]).     % Interface procedures for handling interface to route modules
:- use_module( sicstus4compatibility ). %, [ get0/1, tab/1 ] ).  %% Compatible with sicstus4, get0/1 etc.

%% RS-130329 Make sure (gram/lang) modules are available: dcg_module, 
:- use_module(tucbuses,[ backslash/1, dcg_module/1, language/1, legal_language/1, readfile_extension/1, script_file/1 ]). %% RS-140211
:-use_module( interfaceroute, [  reset_period/0 ] ).

%% RS-111205, UNIT: app/
:- use_module( 'app/buslog' ). % , [ station/1 ] ).  %% RS-130210 called in for-predicate     bound/1, bus/1,

%% RS-111205, UNIT: db/
:- use_module( 'db/places' ). %% [ corr/2, foreign/1, isat/2, placestat/2 ] ).
:- use_module( 'db/regstr' ). %% , [   streetstat/5 ] ). %% RS-131225  makeauxtables uses a for-loop with streetstat in it!!
:- use_module( 'db/teledat2', [  teledbrowfile/1  ]). %% File containing TELEDAT %% co-existing with BUSDAT
:-use_module( 'db/timedat' ). %% , [ orig_named_date/2 ]). Called from main!       %% Time data for bus routes in general 

%% RS-111205, UNIT: dialog/
:- ensure_loaded( 'dialog/d_dialogue.pl' ). %% [ quit_dialog/0, dialogrun0, etc. ] ).
:- ensure_loaded( 'dialog/portraycontext.pl' ). %% [ corr/2, foreign/1, isat/2, placestat/2 ] ).
               
%% RS-131227    UNIT: tuc/
:- use_module( 'tuc/anaphors' , [  resolve/2 ] ).       %% RS-131227
:- use_module( 'tuc/evaluate' ). %%, [ evaluateq/1 ] ). %% RS-131224      fact0/1 etc. is DANGEROUS?
:- use_module( 'tuc/fernando' ).     % GRUF == Grammar Utility File %% RS-131117
%:- use_module( 'tuc/lex' ).          % lcode1/2  is called in the for-predicate (etc.) %% RS-131225
:- use_module( 'tuc/lex', [ decide_topic/0, lexproc3/3, maxl/1, mix/2, spread/1, unknown_words/2 ] ).
:- use_module( 'tuc/metacomp' ).     % genprod is called in the for-predicate (etc.) %% RS-131117
%%  Read a sentence into a list of symbols
:- use_module( 'tuc/readin', [  ask_file/1, ask_user/1, read_in/1 ]). %%  Read a sentence into a list of symbols
%%ensure_loaded( 'tuc/torehash' ).   % RS-131224 OBSOLETE! Moved to utility/makeauxtables!
:- use_module( 'tuc/translat', [ clausifystm/1, clausifyq/2  ] ).        %% RS-131227    UNIT: tuc/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% local copy of META-PREDICATES from utility.pl
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for(P,Q):-
%  P,Q,
%  false;true.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   
% ?-prolog_flag(gc_trace,_,verbose).

break(_). %% dummy for breakpoints


%% Main program


%:-dynamic txt/3,      % elementary words       %% RS-131225    Moved to lex?
%          ctxt/3,     % composite words 
%          maxl/1.


?-op(1150,fx,spyg). %% spy grammar rule
?-op(1150,fx,spyr). %% spy pragma rule
?-op(1150,fx,sp).   %% spy X,X


%% ?-prolog_flag(unknown,_,fail). %% (Don't?) crash on undefined predicates
crash :- tore_amble_is_a_genious.  %% test on undefined predicate

spyg X :- dcg_module(L), 
          user:( parsetime_limit := 100000 ), %%  ONLY FOR DEBUGGING
          spy L:X. %% utility

spyr X :- user:( debugrule := X ),
          spy spy_me.

sp X :- functor(X,F,_),spy F,X.  %% call X with spy on X 

statistics(G) :- 
               statistics(G,K),
               output(K).


%% Strategy for switching language

% Presume there is an assumed language from the start
% e.g. the WEB  server is for a specific language (bustuc/busstuc)

% Try lexproc in the current language
% If unknown words, try the other language
% If the other language results in fewer unknown words, 
%  select this language TEMPORARILY (for this question)


%% SYSTEM COMMANDS

%% Menagerie of Start commands in decreasing order of severity

readscript:-
    script_file(X) -> 
       readscript1(X);
       true.

readscript1(X):- 

    user:( trace:=0 ),
    erase,  

    readfrom(X),

    user:( skolocon  =: SM ), user:( skolemax :=  SM ),   

    user:( trace := 1 ).


% Default settings. May be redefined

initiate :-   %% called at compiletime !  
    user:( trace := 0 ),   %% Dialog 
    user:( maxdepth:=3 ),   
    user:( error_phase:=0 ),
    user:( context_id := 1 ),

    user:( parsetime_limit := 10000 ). %% TA-071026


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
    retractall( user:fact0(_) ),  % Semipermanent facts
    user:( skolemax := 0 ),  
    reset.

clear:- 
    nodebug,  % somewhat ugly
    nospyall, % messages
    clear1.

clear1 :-
    user:( dialog := 0 ), 
 %% Only complete queries, with defaults ( should be true/false ?)
    user:( trace := 0 ),  %% Dialog
    user:( traceprog := 1 ), 
    user:( traceans := 1 ),
%%    queryflag := true, 
%%    textflag := false,
    user:( spellcheck := 1 ),   %% restored after debug 
    closereadfile,       
    reset.

begin :-
    reset,
    user:( permanence := 1 ),
    nl.

quit:- 
    user:value(dialog,1),
    !,
    retractall( user:difact(_,_) ),   %% Only Dynamic Facts 
    retractall( user:( _ => _ ) ),
    user:( lemmas_proved := 0 ),  %%
    user:( interp := 0 ),         %%
    ( user:(skolemax =: SZ) -> user:(skolocon := SZ ) ; user:(skolocon := 0) ), 
    user:( const := 0 ),
    quit_dialog. %% <----  without reply

reset:-  
    retractall( user:difact(_,_) ),   %% Only Dynamic Facts 
    retractall( user:(_ => _) ),
    user:( lemmas_proved := 0 ),  %%
    user:( interp := 0 ),         %%
    ( user:(skolemax =: SZ) -> user:(skolocon := SZ ) ; user:(skolocon := 0) ), 
    user:( const := 0 ). 


norsk   :- 
    user:( origlanguage := norsk ), % permanently 
    user:( language := norsk ). 


english :- 
    user:( origlanguage := english ), % permanently 
    user:( language := english ).  
 
run(L):- 
   user:( language := L ),
   run.

%run :-         %% RS-131228    Normal mode
%    nl,
%    (seen),              %% evt. read-files
%    dialog:=0, 
%    go.

run :-
    dialog.    %% RS-131228    Dialog mode?


logrun :- 
    nl,
    (seen),
    golog.

webrun_english :-
    user:( language:= english ),
    user:( dialog := 0 ), 
    webrun.


webrun_norsk :-
    user:( language :=norsk ),
    user:( dialog   := 0 ),  
    webrun.

webrun_tele :-
    user:( language :=norsk ),
    user:( dialog   := 0 ),  

	 writepid, 
    set_prolog_flag(fileerrors,off),
	 %%% TA-060426 %% remember(lastday(-1,noday)), 

    repeat,
       user:( world := real ), 
	    getfromport(L),
	    processorwait(L),
	    fail,
	 !.

/***
webrun_dialog :-  --> d_main.pl %% TA-050722
***/


webrun :-      
	 writepid, 
    set_prolog_flag(fileerrors,off),
	 %%% TA-060426 %% remember(lastday(-1,noday)), 
    user:( busflag:= true ),    %%  Bustuc Application Program
	 user:( queryflag := true ), %% Statements are implicit queries
    user:( warningflag := false ), %% if applicable
    repeat,
       user:( world := real ), 
      %%%   resetsmsflag,  %% TA-081218
       reset_period,       %%   ---> topreg.pl
	    getfromport(L),
	    processorwait(L),
	    fail,
	 !.

/* %% TA-081218

resetsmsflag :- 
   (user:value(smspermanentflag,true) -> 
        smsflag := true;
        smsflag := false).
*/


dialog :-      %% RS-131228  
	 nl,
	 (seen),
	 user:( permanence := 0 ), 
	 user:( dialog := 1 ),   
%    queryflag := true,       %% (Statements are implicit queries)
    closereadfile,   
    %%% TA-060426 %% remember(lastday(-1,noday)), 
    dialogrun0.   



%hi :-% language := english,    %% RS-131228    See dialog/d_dialogue 
%    debug,
%    go.


hei:-% language:= norsk, 
    debug,
    go.


ho:-
    clear,
    go.

go :-
    bad_language,  % exit if undefined LANGUAGE
    !.

go:-
    user:( permanence := 0 ), 
    restoreworld, 
	 closereadfile,  
    %%% TA-060426 %% remember(lastday(-1,noday)), 
    repeat, 
    nl,
    reset_period, 
    doask_user(L),
    process(L).

restoreworld :- 
    user:( world =: _W_ ) -> true;
    user:( world := real ).

golog:-
	 closereadfile,  
    %%% TA-060426 %% remember(lastday(-1,noday)), 
    repeat, 
    nl,
	 reset_period,  
    doask_user(L),
    writelog(L),
    process(L).

end :-  
    (seen),
    user:( permanence:=0 ),
    user:( world := real ).

bad_language :- 
    \+ language(_),
    !,
    nl,out(' *** No definied  language  compile(buster).'),output(' ***').

bad_language :-
    language(L),
    \+ legal_language(L),
    !,
    nl,out(' *** Undefinied  language:  '),out(L),output(' ***').


%%%%%%%%%%%%%%%%% Other Commands


%:-ensure_loaded( version ).       %% RS-131227    With version_date/1, used in monobus -> teledat2.pl
:- use_module( busterversion ).       %% RS-131227    With version_date/1, used in monobus -> teledat2.pl

tuc_version:-   
    %version_date(V),     %% version.pl
    version_date_buster(V),     %% version.pl
    nl,nl,               %%
    output(V).        

check:- % Check consistency
     evaluateq(explain:::false). 

status:- 
 
   nl,output('Rules:'),nl,
   for( A => B ,   prettyprint( A => B)),
   nl,output('Facts:'),nl,
   for( fact0(X),   prettyprint(X)), 
   for( difact(UID,X),   prettyprint(UID:X)),   
   track(2,(nl,output('Flags:'),listing(user:value/2))).  

testgram:- 
    dcg_module(DCG),
    spy(DCG:sentence/6),
    spy(DCG:st/9),        
    spy(DCG:do_phrase/9),
    spy(qev/1),       
    user:( trace := 3 ),
    user:( spellcheck :=0 ), %% debug makes it slow 
    user:( parsetime_limit := 100000 ).  %% ONLY DEBUGGING



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


writepid :-
         process_id(Pid),
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

    redirecttoans, 

    (process(L1);true),          % Process always fails...

    redirectfromans,

    clearport,
    !.



redirecttoans:- 
    user:value(teleflag,true),
    !. %% Not Yet

redirecttoans:- 
  trytellans. 


redirectfromans:-
   user:value(teleflag,true),
   !,

   teledbrowfile(Rowsample0), 

   shell_copyfile(Rowsample0,'.ans').


redirectfromans:-
   told,
   !.
 
  

%% From Web

%  Perl script will always add a language prefix 
 
splitlang(L,Netto):- %%   If not prefix nor,eng assume no prefix
 
   L= [eng|Netto] -> user:( language :=english ); 
 
   L= [nor|Netto] -> user:( language :=norsk );
 
   L= [sms|Netto] -> user:( language :=norsk ); 
 
  ( Netto=L, user:( language := norsk ) ).



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
   user:( today := Today ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

c(F):-consult(F). 
r(F):-readfrom(F).

closereadfile :-   % if interrupted 
    ( user:( readfile =: OLD ) -> closefile(OLD);true),
    (seen). 

closefile(F):-
    absolute_file_name(F,FS),
    current_stream(FS,_,X),close(X),!;true.

% Flags may not be reset if readfrom is interrupted !

readfrom(F):- 
    closereadfile, 
    user:( end_of_file := false ), 
    readfile_extension(X),
    append_atoms(F,X,FE), 
    user:( permanence := 1 ),

%     textflag := true,        %  Read from text, don't skip to new Line
%                              %  destroys  kl. 1720 in batch queries
%    queryflag =: Oldqueryflag,%  destroys setting in startupfile
%    queryflag := false,       %  Statements are not implicit queries 

    user:( readfile := FE ),   
    see(FE),
        repeat,
            reset_period,  
            ask_file(L),    % readin.pl
            process(L),     
            !,
    (seen),
    user:( permanence := 0 ).

%%    textflag := false,       %  Read from text, don't skip to new Line 
%%    queryflag :=   Oldqueryflag. % destroys setting in startupfile



scanfile(F,L):- 

    see(F),     
    read_in(L),
    (seen).  


 
doask_user(L):-
   user:( interp := 0 ),  
    
   pcontext,  

   ask_user(L).   %% readin.pl


process(_):-
    bad_language,
    !.

process(L):-           %% Process is under a repeat loop
    user:( error_phase := 0 ),
    user:( language     =: O1 ), 
    user:( origlanguage := O1 ),

    translate2(L,TQL),
    nl,
    exetuc(TQL),       %% Always succeed (command may change origlanguage)
    user:( origlanguage =: O2 ),
    user:( language :=     O2 ), % 

    (TQL=end;  
     TQL=stop).        %% Succeeds and  exit when stop command.




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% translate2

      %% Produces a TQL expression from a List
      %% If a stop command appears, TQL = stop
      %% If an end command appears, TQL = end
      %% If an error occured,       TQL = error
      %% Otherwise,                 TQL = command(P).



translate2(L,TQL):-  
    track(1,nl),
    dotline(DOTS),
    traceprint(1,DOTS),

    analyse2(L,TQL),

    traceprint(1,DOTS),

    track(1,nl),
    track(2,taketime). 


dotline(''):-user:value(smsflag,true),!.
dotline('........................................................................').
   

analyse2(L,Stop):- 
    stopcommand(L,Stop),
    !.

analyse2(L,command(Rosenborg)):- 
    othercommand(L,Rosenborg),
    !.




analyse2(L1,TQL):-      

    user:value(telebusterflag,true),
    !,
    user:set(busflag,true),  %% Dynamic
    user:set(teleflag,true), %%  TA-060208

    create_tags(L1), %% , _TAGS) , %% TA-060613
    !,   

    lexproc3(L1,AssumedLanguage,L2),

    user:( language := AssumedLanguage ),

    track(3,pront(L2)),  %% TA-060420     

    user:( error_phase:= 0 ), 
    starttime,    

    layout2(L2,TQL), 
    present(1,TQL),

    !.


analyse2(L1,TQL):-      
    user:value(teleflag,true),
    user:value(busflag,true),
    !,
    create_tags(L1), %%%  , _TAGS) , %% TA-060613
    !,   
    lexproc3(L1,AssumedLanguage,L2),
    user:( language := AssumedLanguage ),

    track(3,pront(L2)),  %% TA-060420

    user:( error_phase:= 0 ), 
    starttime,    
    layout2(L2,TQL), 
    present(1,TQL),

    !.




analyse2(L1,TQL):-      
    user:value(busflag,true),
    \+ user:value(teleflag,true),
    !,

    lexproc3(L1,AssumedLanguage,L2),

    user:( language := AssumedLanguage ),

    track(3,pront(L2)),  

    user:( error_phase:= 0 ), 
    starttime,    

    layout2(L2,TQL), 

    writeTQL(TQL),   %% TA-051104

%%     present(1,TQL),

    !.


analyse2(L1,TQL):-      

    user:value(teleflag,true),
    \+ user:value(busflag,true), %% TA-060107
    !,


    create_tags(L1), %%% , _TAGS) , %% TA-060613

    !, 

    lexproc3(L1,AssumedLanguage,L2),

    user:( language := AssumedLanguage ),
     
    user:( error_phase:= 0 ), 
    starttime,    

    layout2(L2,TQL), 
    present(1,TQL),

    !.




analyse2(_,error).



writeTQL(TQL):-  
    present(1,TQL).


layout2(L,TQL):- 
    spread(L),

    decide_topic,  %% TA-060107    tuc/lex.pl                  

    manipulate_teleflag, %% until after gram %% TA-060208



    track(2,listing(txt)),
    track(2,nl),  
    user:( cursor := 0 ),
    grammar2(L,FOL), %% let teleflag be on %% TA-060208
    transfix(FOL,TQL).


%% AD HOC
manipulate_teleflag :-
    user:value(telebusterflag,true),
    !,
    (
    user:value(topic,bus) -> 
        (user:set(busflag,true), %% TA-061107
         user:set(teleflag,false));
     

    user:value(topic,tele)-> 
        (user:set(teleflag,true),
         user:set(busflag,false));  %% TA-061107

    user:value(topic,nil) -> 
       (user:set(busflag,false),    %% TA-061107
        user:set(teleflag,false)),  %% <--- or teleflag=true default?

    true).

manipulate_teleflag.







listxt :- listing(txt). %% TA-051101


startteleerror :-
    user:value(teleflag,true),
    !,
    teledbrowfile(TDBR),
    %%tell(TDBR)   %% RS-121121
    open( TDBR, write, Stream, [encoding('UTF-8')] ),
    set_output(Stream).

startteleerror :-!.


stopteleerror :-
     user:value(teleflag,true),
     !,
     told.

stopteleerror :-!.

grammar2(L,error):-     
    user:value(notimeoutflag,true),
    length(L,M),M > 21, 
    !,
    startteleerror,
       nl, 
       doubt('- - - Sentence is too long and complicated  ', 
             '- - - Setningen er for lang og vanskelig '),
    stopteleerror.




grammar2(L,error):-                % Failed with type check,
    \+ user:value(teleflag,true),  %% TA-051116 ?
    unknown_words(L,Z), 
    \+ (Z == []),  
    !,                             % => Incomprehensible (therefore)
 
%%       startteleerror,   %% TA-051116

       nl, 
       doubt('- - - Incomprehensible words: ', %% '-'  means No Pay 
             '- - - Uforståelige ord: '),
       nl,                                     %% TA-050810
       writeq(Z),nl, nl.

%%%      stopteleerror.  %% TA-051116



grammar2(_,FOL):-   
    user:( cursor := 0 ),
    maxl(N),

    parse_sentence(P,N,Success), 

    (Success == success -> true; 

     (    startteleerror,
             nl,   
             doubt('- - - Sentence is too difficult - - -',   %%  vague on 
                   '- - - Setningen er for vanskelig - - -'),    %%  purpose
             nl,
          stopteleerror)
     ),

    !,                         %% <------- One solution   


    present(3,P), 

    resolve(P,Q),            %%  (Short Circuit Scopes)
    !, 

    present(2,Q),

    Q = FOL.



grammar2(L,error):-
    user:value(semantest,true), 
    user:( error_phase := 1 ),                % Reset Type check
    user:value(cursor,Attempt1),
    maxl(N),
    user:( cursor := 0 ),                     % Failed with type check, but
    parse_sentence(_,N,success),
    !,                               % => Meaningless (semantically)

    startteleerror,

       nl,                             
       doubt('- - - Meaningless at * - - -',
             '- - - Meningsløst ved * - - -'),
       mix(Attempt1,L),

   stopteleerror.


grammar2(L,error):-                  % Incomplete sentence 
    \+ user:value(teleflag,true),            % not actual for tele
    no_verb(L),                      % no verbs
    !,

    startteleerror,

       nl,                              
       doubt('- - - Please use a complete sentence - - -',
             '- - - Vennligst bruk en fullstendig setning - - -'),
       nl,

    stopteleerror.

grammar2(L,error):-                  % Failed also with type check
    user:value(cursor,Attempt2),          % =>  Ungrammatical (according to gram),
    nl,                              

    startteleerror,

        doubt('- - - Incomprehensible at  * - - -',
              '- - - Uforståelig ved * - - -'), 
        mix(Attempt2,L),

     stopteleerror.


% % % % % % % 


parse_sentence(P,N,Success):-  %% Parse With TimeLimit
    dcg_module(G),
    user:value(parsetime_limit,Limit),   

%%%% output('trace1'),


    timeout(

        G:sentence(P,Parse,[],[],0,N), 
        Limit,
        Success),
    
%%%% output('trace2'),

    ( Success == success -> Parse1=Parse;Parse1=time_out),

     track(3,printparse(Parse1)), %%  print proper parsetree

%% TA-090617

     track(2, output('*** Simplified parse tree ***')), %% TA-060906
     track(2, ptbwrite(Parse1)),
     track(2, (output('*****************************'),nl)).

%%  TA-090617






no_verb(L) :- \+ verbed_sentence(L). 

verbed_sentence(L):- 
    member(W,L), 
    W = w(R,ListV),
    R \== når,                % = nå = now (doesn' count)
    R \== nå,  
    R \== så, 
    (member(verb(_,_,_),ListV);
     member([skal],ListV); 
     member([vil],ListV); 
     member([må],ListV)), 
   !.

present(_,nil):-!.      % code printed by side effect 
present(_,[nil]):-!.    % code printed by side effect 
present(_,[nil|_]):-!.  % code printed by side effect 
present(_,error):-!.    %

present(N,P):- 
    copy_term(P,Q),
    track(N,prettyprint(Q)),
    track(N,nl). 



traceprint(N,P):- 
    user:value(trace,M), number(M), M >= N, 
    !,
    write(P),nl
;
    true.

track(N,P):- 
    user:value(trace,M),  number(M), M >= N, 
    !,
    P
;
    true.
 
trackprog(N,P):- 
    user:value(traceprog,M), number(M), M >= N, 
    !,
    (nl,P)
;
    true.

user:value(X):-
    user:value(X,Y),
    out(X),out('='),output(Y),nl.


printparse(X):- 
    write('*** Parse Tree ***'),nl,nl,
    indentprint(0,X),nl,
    write('******************'),nl,nl.

indentprint(N,O):-
     var(O),
     !,
     tab(N),write(O),nl.
    
indentprint(N,[H|T]):-
    !,
    tab(N),write(H),nl,
    M is N+2,
    for(member(X,T),indentprint(M,X)).

indentprint(N,O):-
     tab(N),write(O),nl.
    

indentprintlist(N,O):-
     var(O),
     !,
     tab(N),write(O),nl.
    
indentprintlist(N,[H|T]):-
    !,
    M is N+2,
    for(member(X,[H|T]),indentprintlist(M,X)).

indentprintlist(N,O):-
    tab(N),write(O),nl.
    


%% Control Section


%% Several statements 

transfix(nil,nil):- user:value(dialog,1),!. 

transfix([[]],[replyq('?')]):-!.  %% Avoid empty answers (by synonym)

transfix([X|Y],[X1|Y1]):- 
    !,
    transfix1(X,X1),
    transfix(Y,Y1).
transfix([],[]):-!.

transfix(P,Q):-transfix1(P,Q). %% PANIC

transfix1(error,error):-!. 

transfix1(new:::P,nil):-   %%  ==> causes an extra [nil]
   
 user:value(textflag,true), %%%%%%% <--- %% TA-070122

  \+ user:value(teleflag,true),
  \+ user:value(busflag,true)

, %% Set by Bustuc Application Program

    !,
    clausifystm(P),   %% translat.pl
    !. 

transfix1(new:::P,nil):-
	 user:value(queryflag,false), 
	 !,           
    clausifystm(P).   %% translat.pl


transfix1(QX:::P,R):- 
     clausifyq(QX:::P,R). %% translat.pl


%%  Execute command

exetuc(error):-!.   % executed as side effect
exetuc(stop):-!.    % executed by loop exit
exetuc(end):-!,end. % executed by end command 
exetuc(new):-!.     % ad hoc

exetuc(command(P)):-
    !,
    anash(P).

exetuc(_TQL):-
    user:value(noevalflag,true),!. %% New Flag  : No TUC-evaluation

exetuc(TQL):- evaluateq2(TQL). %% evaluate.pl




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% stopcommand(['.'|_],stop). 

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



% slash commands

anash([c,P]):- !, 
    consult(P).

anash([c,Dir, '/' ,P]):- !,   %% \c app/negans 
    appfilename(Dir,P,Q),
    consult(Q).

anash([compile,P]):- !, 
    compile(P).

anash([compile,Dir, '/' ,P]):- !,  
    appfilename(Dir,P,Q),
    compile(Q).

anash([u|U]):-!,  
    makestring(U,V),  
    shell(V). 


anash([r,F]):-!,
    readfrom(F).

anash([r,Dir, '/' ,P]):- !,  %% \r tests/kristin 
    appfilename(Dir,P,Q),
    readfrom(Q).

anash(Plist):-
    Callp =.. Plist,
    call(Callp).


appfilename(Dir,P,DirP):- 
    append_atoms(Dir,'/',Dir1),
    append_atoms(Dir1,P,DirP).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



update_compnames(Compnames) :-                  %% MTK 021018
    user:( compnames := Compnames ).


create_taggercall(L2,PAT):-

    append_synnames(L2,L3), %% add synnames (torbjorn=torbjørn)
                            %% BEFORE taggercall
    
    remove_hasardousnames(L3,L4), %% hvilken tittel har  per borgesen

    listtoplus(L4,P2),
    plustoatom1(P2,PAT).

append_synnames(L2,L3):- %% TA-050920 
    set_ops(Y,(member(X,L2),synname(X,Y)),Z), %% sequence preserving %% TA-051028
    append(L2,Z,L3).

remove_hasardousnames(L3,L4):-
   set_ops(X,( member(X,L3), \+ hazardous_tagname(X)),L4).   %% sequence preserving %% TA-051028


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
ltoplus([],[]). %% empty %% TA-051015

plustoatom(A+B,AB):- !,%% jævla hack %% TA-020619
    plustoatom(A,A1),
    plustoatom(B,B1),
    append_atomlist([A1,'+',B1],AB).
plustoatom(X,X).

plustoatom1(A+B,AB):- !,%% uses spaces instead of plus %% TLF-030218
    plustoatom1(A,A1),
    plustoatom1(B,B1),
    append_atomlist([A1,' ',B1],AB).
plustoatom1(X,X).


%%%%%%%%%%%  THE END %%%%%%%%%%%%%%%%%%%%%%


  :- initiate.

