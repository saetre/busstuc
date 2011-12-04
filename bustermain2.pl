%% FILE bustermain2.pl
%% SYSTEM BUSTER
%% CREATED TA-930531
%% REVISED TA-090617

%% COMMON CO-VERSION BUSS TELE
%:- module( bustermain, [ ] ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Imports
:- use_module( library(timeout) ). %% timeout WITHOUT " _ "
:- use_module( library(process) ).

%% Operators used by TUC
:- ensure_loaded( 'declare' ).
:- use_module( main, [   user:(:=)/2,  user:(=:)/2, 
        closereadfile/0, dmeq/2,
        user:myflags/2,  progtrace/2,  readfrom/1,  run/0, user:set/2  ] ).

:- compile( monobus ). %% // after main.pl  Unknown error
:- use_module( ptbwrite ).           %% Module PennTreeBank

:- use_module( 'db/timedat' ).           %% Module db

:- use_module( 'dialog/d_dialogue', [ quit_dialog/0, reset_conns/0,
    subst_tql/4,    varmember/2   ] ).

:- use_module( 'utility/utility', [
        append_atomlist/2,      append_atoms/3, doubt/2,        for/2,
        makestring/2,           out/1,          output/1,       prettyprint/1,
        psl/2,                  purge/3,        reverse/2,      set_ops/3,
        shell_copyfile/2,       starttime/0,    tab/1,          writelist/1
   ] ).  %% Module utility

:- use_module( 'tuc/evaluate',[ evaluateq2/1 ]).
:- use_module( 'tuc/readin', [  ask_user/1, ask_file/1 ] ). %%reads text to a list

:-use_module( tucbuses, [  dcg_module/1,  backslash/1,
        language/1,     legal_language/1, script_file/1  ] ).

:- dynamic difact/2, fact0/1.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

timeout(     S, _L, success):-  %% If timeout doesn't work
    user:myflags(notimeoutflag,true), 
    !,
    call(S).


timeout(     S, L, Success):- 
    time_out(     S, L, Success).


   
% ?-prolog_flag(gc_trace,_,verbose).

break(_). %% dummy for breakpoints


%% Main program


:-dynamic txt/3,      % elementary words
          ctxt/3,     % composite words 
          maxl/1.


?-op(1150,fx,spyg). %% spy grammar rule
?-op(1150,fx,spyr). %% spy pragma rule
?-op(1150,fx,sp).   %% spy X,X


%crash :- tore_amble_is_a_genious.  %% test on undefined predicate

spyg X :- dcg_module(L), 
          parsetime_limit := 100000, %%  ONLY FOR DEBUGGING
          spy L:X. %% utility

spyr X :- debugrule := X,
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

    trace:=0,
    erase,  

    readfrom(X),

    skolocon  =: SM, skolemax :=  SM,   

    trace := 1.


% Default settings. May be redefined

initiate :-   %% called at compiletime !  
    trace:= 0,   %% Dialog 
    maxdepth:=3,   
    error_phase:=0,
    context_id := 1,

    parsetime_limit := 10000. %% TA-071026


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
    retractall(fact0(_)),  % Semipermanent facts
    skolemax := 0,  
    reset.

clear:- 
    nodebug,  % somewhat ugly
    nospyall, % messages
    clear1.

clear1 :-
    dialog := 0, 
 %% Only complete queries, with defaults ( should be true/false ?)
    trace :=0,  %% Dialog
    traceprog :=1, 
    traceans := 1,
%%    queryflag := true, 
%%    textflag := false,
    spellcheck := 1,   %% restored after debug 
    closereadfile,       
    reset.

begin :-
    reset,
    permanence := 1,
    nl.

quit:- 
    user:myflags(dialog,1),
    !,
    retractall(difact(_,_)),   %% Only Dynamic Facts 
%    retractall((_ => _)),
    lemmas_proved := 0,  %%
    interp := 0,         %%
    (skolemax =: SZ -> skolocon := SZ; skolocon := 0), 
    const := 0,
    quit_dialog. %% <----  without reply

reset:-  
    retractall(difact(_,_)),   %% Only Dynamic Facts 
%    retractall((_ => _)),
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
    

%run :- 
%    nl,
%    seen,              %% evt. read-files
%    dialog:=0, 
%    go.
%
%
%logrun :- 
%    nl,
%    seen,
%    golog.
%
webrun_english :-
    language:= english,
    dialog := 0, 
    webrun.


webrun_norsk :-
    language :=norsk,
    dialog   := 0,  
    webrun.

webrun_tele :-
    language :=norsk,
    dialog   := 0,  

	 writepid, 
    nofileerrors,
	 %%% TA-060426 %% remember(lastday(-1,noday)), 

    repeat,
       world := real, 
	    getfromport(L),
	    processorwait(L),
	    fail,
	 !.

/***
webrun_dialog :-  --> d_main.pl %% TA-050722
***/


webrun :-      
	 writepid, 
    nofileerrors,
	 %%% TA-060426 %% remember(lastday(-1,noday)), 
    busflag:= true,    %%  Bustuc Application Program
	 queryflag := true, %% Statements are implicit queries
    warningflag := false, %% if applicable
    repeat,
       world := real, 
      %%%   resetsmsflag,  %% TA-081218
       reset_period,       %%   ---> topreg.pl
	    getfromport(L),
	    processorwait(L),
	    fail,
	 !.

/* %% TA-081218

resetsmsflag :- 
   (user:myflags(smspermanentflag,true) -> 
        smsflag := true;
        smsflag := false).
*/


%dialog :-  
%	 nl,
%	 seen,
%	 permanence := 0, 
%	 dialog := 1,   
%%    queryflag := true,       %% (Statements are implicit queries)
%    closereadfile,   
%    %%% TA-060426 %% remember(lastday(-1,noday)), 
%    dialogrun0.   
%


hi :-% language := english, 
    debug,
    go.


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
    permanence := 0, 
    restoreworld, 
	 closereadfile,  
    %%% TA-060426 %% remember(lastday(-1,noday)), 
    repeat, 
    nl,
    reset_period, 
    doask_user(L),
    process(L).

restoreworld :- 
    (world =: _W_) -> true;
    world := real.

golog:-
	 closereadfile,  
    %%% TA-060426 %% remember(lastday(-1,noday)), 
    repeat, 
    nl,
	 reset_period,  
    doask_user(L),
    writelog(L),
    process(L).

%end :-  
%    seen,
%    permanence:=0,
%    world := real.
%
bad_language :- 
    \+ language(_),
    !,
    nl,out(' *** No definied  language  '),output(' ***').

bad_language :-
    language(L),
    \+ legal_language(L),
    !,
    nl,out(' *** Undefinied  language:  '),out(L),output(' ***').


%%%%%%%%%%%%%%%%% Other Commands



tuc_version:-   
    version_date(V),     %% version.pl
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
   track(2,(nl,output('Flags:'),listing(value/2))).  

testgram:- 
    dcg_module(DCG),
    spy(DCG:sentence/6),
    spy(DCG:st/9),        
    spy(DCG:do_phrase/9),
    spy(qev/1),       
    trace := 3,
    spellcheck :=0, %% debug makes it slow 
    parsetime_limit := 100000.  %% ONLY DEBUGGING



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


writepid :-
         pid(Pid),
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
    user:myflags(teleflag,true),
    !. %% Not Yet

redirecttoans:- 
  trytellans. 


redirectfromans:-
   user:myflags(teleflag,true),
   !,

   teledbrowfile(Rowsample0), 

   shell_copyfile(Rowsample0,'.ans').


redirectfromans:-
   told,
   !.
 
  

%% From Web

%  Perl script will always add a language prefix 
 
splitlang(L,Netto):- %%   If not prefix nor,eng assume no prefix
 
   L= [eng|Netto] -> language :=english; 
 
   L= [nor|Netto] -> language :=norsk;
 
   L= [sms|Netto] -> language :=norsk; 
 
  ( Netto=L, language := norsk).



trytellans :- 
	 tell('.ans').

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

c(F):-consult(F). 
r(F):-readfrom(F).

% Flags may not be reset if readfrom is interrupted !

%% RS-111204    Import from main instead!
%readfrom(F):- 
%    closereadfile, 
%    end_of_file := false, 
%    readfile_extension(X),
%    append_atoms(F,X,FE), 
%    permanence := 1,
%
%    
%
%     textflag := true,        %  Read from text, don't skip to new Line
%                              %  destroys  kl. 1720 in batch queries
%    queryflag =: Oldqueryflag,%  destroys setting in startupfile
%    queryflag := false,       %  Statements are not implicit queries 
%
%    readfile := FE,   
%    see(FE),
%        repeat,
%            reset_period,  
%            ask_file(L),    % readin.pl
%            process(L),     
%            !,
%    seen,
%    permanence := 0.


scanfile(F,L):- 

    see(F),     
    read_in(L),
    seen.  


 
doask_user(L):-
   interp := 0,  
    
   pcontext,  

   ask_user(L).   %% readin.pl


process(_):-
    bad_language,
    !.

process(L):-           %% Process is under a repeat loop
    error_phase := 0,
    language     =: O1, 
    origlanguage := O1,

    translate2(L,TQL),
    nl,
    exetuc(TQL),       %% Always succeed (command may change origlanguage)
    origlanguage =: O2,
    language :=     O2, % 

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


dotline(''):-user:myflags(smsflag,true),!.
dotline('........................................................................').
   

analyse2(L,Stop):- 
    stopcommand(L,Stop),
    !.

analyse2(L,command(Rosenborg)):- 
    othercommand(L,Rosenborg),
    !.




analyse2(L1,TQL):-      

    user:myflags(telebusterflag,true),
    !,
    set(busflag,true),  %% Dynamic
    set(teleflag,true), %%  TA-060208

    create_tags(L1), %% , _TAGS) , %% TA-060613
    !,   

    lexproc3(L1,AssumedLanguage,L2),

    language := AssumedLanguage,

    track(3,pront(L2)),  %% TA-060420     

    error_phase:= 0, 
    starttime,    

    layout2(L2,TQL), 
    present(1,TQL),

    !.


analyse2(L1,TQL):-      
    user:myflags(teleflag,true),
    user:myflags(busflag,true),
    !,
    create_tags(L1), %%%  , _TAGS) , %% TA-060613
    !,   
    lexproc3(L1,AssumedLanguage,L2),
    language := AssumedLanguage,

    track(3,pront(L2)),  %% TA-060420

    error_phase:= 0, 
    starttime,    
    layout2(L2,TQL), 
    present(1,TQL),

    !.




analyse2(L1,TQL):-      
    user:myflags(busflag,true),
    \+ user:myflags(teleflag,true),
    !,

    lexproc3(L1,AssumedLanguage,L2),

    language := AssumedLanguage,

    track(3,pront(L2)),  

    error_phase:= 0, 
    starttime,    

    layout2(L2,TQL), 

    writeTQL(TQL),   %% TA-051104

%%     present(1,TQL),

    !.


analyse2(L1,TQL):-      

    user:myflags(teleflag,true),
    \+ user:myflags(busflag,true), %% TA-060107
    !,


    create_tags(L1), %%% , _TAGS) , %% TA-060613

    !, 

    lexproc3(L1,AssumedLanguage,L2),

    language := AssumedLanguage,
     
    error_phase:= 0, 
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
    cursor := 0,
    grammar2(L,FOL), %% let teleflag be on %% TA-060208
    transfix(FOL,TQL).


%% AD HOC
manipulate_teleflag :-
    user:myflags(telebusterflag,true),
    !,
    (
    user:myflags(topic,bus) -> 
        (set(busflag,true), %% TA-061107
         set(teleflag,false));
     

    user:myflags(topic,tele)-> 
        (set(teleflag,true),
         set(busflag,false));  %% TA-061107

    user:myflags(topic,nil) -> 
       (set(busflag,false),    %% TA-061107
        set(teleflag,false)),  %% <--- or teleflag=true default?

    true).

manipulate_teleflag.







listxt :- listing(txt). %% TA-051101


startteleerror :-
    user:myflags(teleflag,true),
    !,
    teledbrowfile(TDBR),
    tell(TDBR).

startteleerror :-!.


stopteleerror :-
     user:myflags(teleflag,true),
     !,
     told.

stopteleerror :-!.

grammar2(L,error):-     
    user:myflags(notimeoutflag,true),
    length(L,M),M > 21, 
    !,
    startteleerror,
       nl, 
       doubt('- - - Sentence is too long and complicated  ', 
             '- - - Setningen er for lang og vanskelig '),
    stopteleerror.




grammar2(L,error):-                % Failed with type check,
    \+ user:myflags(teleflag,true),  %% TA-051116 ?
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
    cursor := 0,
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
    user:myflags(semantest,true), 
    error_phase := 1,                % Reset Type check
    user:myflags(cursor,Attempt1),
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
    \+ user:myflags(teleflag,true),            % not actual for tele
    no_verb(L),                      % no verbs
    !,

    startteleerror,

       nl,                              
       doubt('- - - Please use a complete sentence - - -',
             '- - - Vennligst bruk en fullstendig setning - - -'),
       nl,

    stopteleerror.

grammar2(L,error):-                  % Failed also with type check
    user:myflags(cursor,Attempt2),          % =>  Ungrammatical (according to gram),
    nl,                              

    startteleerror,

        doubt('- - - Incomprehensible at  * - - -',
              '- - - Uforståelig ved * - - -'), 
        mix(Attempt2,L),

     stopteleerror.


% % % % % % % 


parse_sentence(P,N,Success):-  %% Parse With TimeLimit
    dcg_module(G),
    user:myflags(parsetime_limit,Limit),   

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
    user:myflags(trace,M), number(M), M >= N, 
    !,
    write(P),nl
;
    true.

track(N,P):- 
    user:myflags(trace,M),  number(M), M >= N, 
    !,
    P
;
    true.
 
trackprog(N,P):- 
    user:myflags(traceprog,M), number(M), M >= N, 
    !,
    (nl,P)
;
    true.

%user:myflags(X):-   %% Defined in utility/utility.pl
%    user:myflags(X,Y),
%    out(X),out('='),output(Y),nl.
%

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

transfix(nil,nil):- user:myflags(dialog,1),!. 

transfix([[]],[replyq('?')]):-!.  %% Avoid empty answers (by synonym)

transfix([X|Y],[X1|Y1]):- 
    !,
    transfix1(X,X1),
    transfix(Y,Y1).
transfix([],[]):-!.

transfix(P,Q):-transfix1(P,Q). %% PANIC

transfix1(error,error):-!. 

transfix1(new:::P,nil):-   %%  ==> causes an extra [nil]
   
 user:myflags(textflag,true), %%%%%%% <--- %% TA-070122

  \+ user:myflags(teleflag,true),
  \+ user:myflags(busflag,true)

, %% Set by Bustuc Application Program

    !,
    clausifystm(P),   %% translat.pl
    !. 

transfix1(new:::P,nil):-
	 user:myflags(queryflag,false), 
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
    user:myflags(noevalflag,true),!. %% New Flag  : No TUC-evaluation

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
    compnames := Compnames.


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

