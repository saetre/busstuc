/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE busanshp.pl     hovedprogram?
%% SYSTEM BUSTUC/BUSTER
%% CREATED  JB-970220   REVISED  EH-031120 TA-110503 RS-111025 RS-120402 RS-131224 RS-140928
%% REVISED  RS-140101 modularized

%%%%%%%%% COMMON VERSION BUSTER/BUSTUC  %%%%%%%%%%%%%%%

%% This is called from busans (answer generator)
%% There are two main entries:

%% outdeplist      Connection without transfer
%% outfromtocorr   Connection with transfer

% Hjelpepredikat for ans-pragmaregler
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predikater som returnerer fraser.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% UNIT: /app/
%  colon/0, comma/0,  endline/0,      punkt/0,        period/0,     question/0, space/0,       space0/0,                   
:-module( busanshp, [   %% bcw: bcpbc = basic common phrase big cap     
        busleave/9,     busleaveset/6,  busman/2, %% For bustrans->interapp->pragma "x-WRiters"
        comptimeflag/2, comptimeflag/3, convifpossible/2,       corresporder/3,
        db_reply/3,     doublyprinted/1, empty_sms_message/1,           %% RS-140922 description/2,
        evening_time/2, evening_time0/2, evening_time24/3,              earliesttimes/0,
        find_last_departure/2,          findsetoftimes/2,               firstRID/2,     getlastarrival/3,
        gootrace/1,     google/1,       i_or_a_bus/3,   mixopt/3,       memberids/3, %% For utility.pl
        nibcp/1,        notatnight/2,   numberofnextbuses/1,            numberofnextbuses2/2,
        ondate/1,       ondays/1,       outandarrives2/2, outdeplist/6, outdummy/2,     outfromtocorr/6, %ordinal2/3,
        outstreetconn/3,                paraph2/1,      paraphrase_changes1/1,          paraphrase_tele/2,
        paraphrase/1,   paraphrase2/2,  paraphrase3/3,  pen0/1,         plural/3, prent0/1, primeoutput/1,
        printmessage/1, print_paraphrase_message/1,     printmessageunconditionally/1,   %% pmu/1 REMOVED EVERYTHING! RS-xxxxxx
        relevant_message/1,             reply/1,        ridof/2,
        select/2,       sentenceend/1,  setopt/3,       setopts/3,      smart_time_options/1,           sorttimes/4,
        special_day/1,   standnight/1,  stationlistorand/3, % specname0/2,
        theplural/2,    time_options/1, warningtime/2,  writetimes/2,
        %FOR DIALOG
        addrefdialog/2 ] ). % , writevaluelist2/2 in parseres.pl  %% RS-140927

%% META-PREDICATES
:- meta_predicate  outdeplist1( ?, ?, ?, ?, ?, -, ? ) .         %% RS-140927 %%% OUTDEPLIST1 %%%%%%%


%%% OUTDEPLISTTIME %% TIME %%%%%
:- meta_predicate  outdeplisttime(  ?, ?, ?, ?, ?, -, ? ) .         %% RS-140927
:- meta_predicate  outdeplisttime1( ?, ?, ?, ?, ?, -, - ) .         %% RS-140927

:- meta_predicate  bollepling( 0, ? ) .         %% RS-140927

%% bingo(G) :- nl,out('<'),output(G),call(G),out(G),output('>').
%% TA-110801

%:-meta_predicate  sentenceend( 0 ) .  %% Only the first in the setof... %% RS-140927
:-meta_predicate  setoffirst( ?, 0, ? ) .  %% Only the first in the setof... %% RS-140927
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% "local" META-PREDICATES (copied from utility.pl)
%:- meta_predicate  test(0).
%test(X):- \+ ( \+ ( X)).        %% Calls test(nostation(Y)), test("X ako Y"), among other things, so: make it local in metacomp-> dcg_?.pl
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Version Based On the principle that the GoogleMapInfo is printed out

%:- use_module( library( aggregate ), [ foral/2 ] ) .  %% RS-141029  for-all Does NOT work like utility:for/2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RS-131225    UNIT: / and /utility/
%:- ensure_loaded( user:'../declare' ). %% RS-111213 General (semantic) Operators
:- use_module( '../declare', [ (:=)/2, set/2, value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .

:- use_module( '../sicstus4compatibility', [ out/1, output/1, traceprog/2 ] ).  %% Compatible with sicstus4, get0/1 etc.

%:- use_module( telelog , [  bound/1,  unbound/1 ]). --> utility.pl
:- use_module( '../utility/utility', [ append_atomlist/2, bound/1, delete1/3, deleteall/3, firstmem/2, fnuttify2/2, for/2, lastmem/2, % language/1, 
        maximum/2, maxval/3, members/3, minimum/2, minval/3, nth/3, number_to_string/2, occ/2, % doubt/2, out/1, output/1, roundwrite/1, % writeout 
        set_filter/4, set_of/3, set_ops/3, set_union/3, split/4, test/1, testmember/2, unbound/1 ] ). %%, [ ] ). %, [ := /2, for/2,  nth/3, etc. ] ). %% RS-140914 test/1, & set_of set_ops/3(LOOP?),
                        % follow_sequence/3, once1/1, roundmember/2, occ/2, sequence_member/2,
:-use_module( '../utility/datecalc', [ add_days/3, addtotime/3, before_date1/2, difftime/3, sub_days/3, subfromtime/3, timenow/1, timenow2/2, today/1, todaysdate/1 ] ).
:-use_module( '../utility/library', [ reverse/2 ] ).         %% RS-131225 nth/3 moved to utility

:- DependsOn = [ bcw/2, bigcap/2, bw1/1, bwc/2,  bwq/1, bwr2bc/1, bwrbus/2, bwrbusbc/2, bwrprices/1, bwstat2/2, bwt2/1,
                 bwtimes2/1, endline/0, punkt/0, question/0, space0/0, startmark/0 ], use_module( '../utility/writeout', DependsOn ).
%:- DependsOn = [  ], use_module( '../utility/writeout', DependsOn ).  %% Moved back to main: language/1. Where?: roundwrite/1
:-use_module( '../utility/writeout', [
    bcp/1,      bcpbc/1,        bwr/1,  bwr2/2, bwrbc/1, bwrstreet/1,   bwt/1,  
    colon/0,    comma/0,        cwc/2,  dot/0,  doubt/2, getphrase0/2,  languagenr/1, nopay/0,
    outcap/1,   pay1/0,     period/0,       period0/0,      space/0, % startmark/0, 
    writedate/1, writefields/1,  writename/1, writesimplelist/1 ] ). %% RS-141105 Moved to main: language/1,
%% Moved back to main: language/1. Where?: roundwrite/1


%% RS-140921 To split utility.pl into managable modules: , prettyprint/1, sequence_write/1, writepred/1
%% occ/2, once1/1, sequence_member/2,  moved to interapp --> With append_atoms/3, station_trace/4, 
 

%%UNIT: /
:- use_module( '../sicstuc', [ language/1 ] ).  %% RS-141026 backslash/1,  , (:=)/2, set/2, value/2 
%:- use_module( '../main', [ traceprog/2 ] ).  %% RS-141026 backslash/1,  , (:=)/2, set/2, value/2 
%:- use_module( '../tucbuses', [ dict_module/1 ] ). % , language/1

%% RS-131225    UNIT: /app/
:- use_module( buslog, [ airbus_module/1, busorfree/1, ensure_removed/3, keepafter/3, nextdep/3,
                         passeq/6, passMOD/7, rid_to_direction/3, ridtobusname/2, ridtobusnr/2, veh_mod/1 ] ).
:- use_module( dmeq, [  dmeq/2 ]). %% RS-131231
:- use_module( pragma, [  roundmember/2 ] ).
:- use_module( interapp, [  newfree/1 ] ).

%% RS-131225    UNIT: / and /db/               %% RS-120816 statcoord? corr/2, ?
:- use_module( '../interfaceroute', [ current_period/4, decide_period/2 ] ). %% RS-140210 from topreg.pl

:- use_module( '../db/busdat', [ cutloop_station/2, home_town/1, maxnumberofindividualdepartures/1, vehicletype/2 ] ).
:- use_module( '../db/places',  [ corr/2 ] ). %% RS-131231, , specname/2
:- use_module( '../db/timedat', [ defaultprewarningtime/1, kindofday/2, morning_break/1 ] ). %% RS-131226-140928
:- use_module( '../db/topreg', [ default_message/3, default_period/3, period_message/2 ] ). %% RS-131226 

%% RS-131225    UNIT: tuc/
%:- use_module( '../tuc/dict_n', [ ] ).         %% RS-131223 sequence_member etc.?
%:- use_module( '../tuc/evaluate', [ ] ).          %% RS-131225
:- use_module( '../tuc/facts', [ neighbourhood/1 ]). %% RS-131225 fact/1, isa/2,  
%:- use_module( '../tuc/fernando', [  ] ). % subclass0/2
%:- use_module( '../tuc/lex', [ dict_module/1, known_name/1 ] ).  %  TUCs  Lexical Knowledge Base.
:- use_module( '../tuc/semantic', [ subclass0/2 ] ).  %  TUCs  Lexical Semantic Knowledge Base

%% RS-131225    UNIT: dialog/
:- use_module( '../dialog/frames2', [ frame_getvalue_rec/4 ] ). %% RS-131223 etc? getcurrent/1, sequence_member/2
:- use_module( '../dialog/newcontext2', [ addref/3, getcurrent/1 ] ). %% RS-131223 INCLUDED IN FRAMES2!!
%:- use_module( '../dialog/parseres', [ ldaptotuc/2 ] ).    %% RS-131223  ldaptotuc/2


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

gootrace(B2) :-
    (value(mapflag,true) -> output(B2);true). %% RS-131230 Fra utility.pl


%
google(_B) :- true. %% Just executable mark in busans

outstreetconn(_STARTSTOP,_INTSTREET,_INTSTAT). %% Just marker in busans code
%


selectmap( nil, [] ) :- !.      %% was var (not assigned)
selectmap( [ Dep | _ ], Dep ) :- !. %% only first of the printed versions
selectmap( X, X ).  %%


select(corr(A,B),corr(A,B)):-!.
select(dir(A,B),dir(A,B)):-!.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% RS-141109 TF: True/False?

outdeplist( Deps, Day, Opts, DirPlace, TF, MAP ) :-
    outdeplist00( Deps, Day, Opts, DirPlace, TF, MAP0, SmartDeps ),
   (\+ value(smsflag,true)  ->  Transfer = direct, print_smartdeps( SmartDeps, Opts, Transfer ) ; true ),  %% MW-121008
    selectmap(MAP0,MAP).



%¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

outfromtocorr(Opts,Dep,OutDep,Mid01,OutAns,MAP):- %% TA-110511
   outfromtocorr0(Opts,Dep,OutDep,Mid01,OutAns,MAP0,SmartDeps),
   (value(smsflag,false) -> Transfer = transfer,
                            print_smartdeps(SmartDeps,Opts,Transfer);true), %% MW-121008
   selectmap(MAP0,MAP).


% % % %


%%%  OUTDEPLIST1 mm.

%% RS-120402 Problematic BusApp: twonotrans <breaks here on "til lade"> twowithtrans
outdeplist00(Deps,_Day,_Opts,_DirPlace,true,_,_SmartDeps) :-   %% Pre-caution
    var(Deps),
    write('*** No departures ***'),nl,
    !.

outdeplist00( Deps, Day, Opts, DirPlace, Out, MAP, SmartDeps ) :-
    sort_deps_deptime(Deps,Deps1),
    outdeplist01( Deps1, Day, Opts, DirPlace, Out, MAP, SmartDeps ),
    ! %% must not backtrack into busans
    ;
    Out = (bcp(nolonger),period). %% some kind of fail
                                  %% maybe irrelevant because connections failed
                                  %% -> negans

outdeplist01(Deps,Day,Opts,DirPlace,Out,MAP,SmartDeps) :-   % neste =< N avganger etter tidspunkt
         delete1(nextaftertime(N),Opts,Opts1),   %% nextaftertime(1) is default (unspecified), sms-dependent
         !,
    traceprog(4,case11),
    decide_actual_noid3(N,Opts,NActual), %% if nth(4), Nactual>=4 %% TA-101022
         memberids0(NActual,Deps,NextDeps),
    setopt(timeset,Opts1,Opts2),
    outdeplist01(NextDeps,Day,Opts2,DirPlace,Out,MAP,SmartDeps).


outdeplist01( Deps, Day, Opts, DirPlace, Out, MAP, SmartDeps ) :-
    outdeplist02(Deps,Day,Opts,DirPlace, Out, MAP, SmartDeps ).


outdeplisttime( [], _Day, _Opts, _DirPlace, true, _MAP, [] ) :- !.

outdeplisttime( Deps, Day, Opts, DirPlace, OutDep, MAP, SmartDeps ) :-
    traceprog(3,Deps), %% trace , %% 3  Temp %% RS-120814   %% DEBUG %%
    firstdepnotices(Deps),      %% Warn if first dep has already left!
    outdeplisttime1( Deps, Day, Opts, DirPlace, OutDep, MAP, SmartDeps ).        %% MW-120829 %% Maybe good place to add JSON?



outdeponly(Dep,DirPlace,
                                (bwrbusbc(Bus,BusN),bcp(passes),
                                 bwr(Station),bcp(attime),bwt(Time9),OutArr,period),dir(Dep,FINAL),Smartdep_entry) :-

         Dep = depnode(_Time0,Time9,_DelArr,DelDep,BegTime,Rid,BusN,_,Station),
         ridtobusname(Rid,BusN),   %% 
    vehicletype(BusN,Bus),
         (\+ value(dialog, 1),!
          ;
          getcurrent(Cid),
          addref(Cid, Rid,lastrid)
    ),

    outandarrivesonly(Station,Time9,DirPlace,Rid,BegTime,DelDep,ARRIVALTIME,OutArr,FINAL),

    %% Duration is ARRIVALTIME-Time9, %%zip, %% MW-120906 first and last JSON format
    difftime(ARRIVALTIME, Time9, Duration), %% MW-121003 %% Correct duration time
    create_smartdep_entry2(Station,Time9,Duration,Rid, DirPlace ,  Smartdep_entry). %% TA-110505

    %% print_smartdep_entry(Smartdep_entry). %% MW-120917 %% print out in outdeplist02, avoid side effects


outdeplisttime1( [Dep], _Day, _, DirPlace, OutDep, MAP, [SmartDeps] ) :-
         !,
    nonvar( Dep ), %% Security Check, serious error
    outdeponly( Dep, DirPlace, OutDep, MAP, SmartDeps ).


outdeplisttime1( Deps, _Day, Opts, DirPlace, (OutNext,OutLast), MAP, _SmartDeps) :-
    value(nightbusflag,true),
    value(smsflag,true),
    timenow(MN), MN < 400,   %% Next nightbus RELEVANT
    !,
    outdepnext(Deps,Opts,_TimeF,TimeL,DirPlace,OutNext, MAP,_Smartdep_entry_next),  %% .. no first?

         outdeplast(Deps,DirPlace,TimeL,OutLast,_Smartdep_entry_last).


outdeplisttime1(Deps,_Day,Opts,DirPlace,Out,MAP,_SmartDeps) :-
    value(nightbusflag,true),
    value(smsflag,true),     %% Next nightbus IRRELEVANT
    !,
    maxnumberofindividualdepartures(MNID), %% Extra check
    memberids(MNID,Deps,Deps4), %% there may be many if unrestricted
    justoutputthelist0(Deps4,DirPlace,Out,Opts,MAP,_Smartdeps).
    %%print_smartdep_entries(SmartDeps)
    %% Few anyway, dont miss any
                                              %% 0  no warning

%% RS-141109 Moved down (after nightbus & smsflags)
outdeplisttime1( Deps, _Day, Opts, DirPlace, (OutFirst, OutNext, OutLast ), MAP, SmartDeps ) :-
    value(nightbusflag,true),
    !,
         outdepfirst(Deps,DirPlace,TimeF,OutFirst, MAP,Smartdep_entry_first),

         outdeplast(Deps,DirPlace,TimeL,OutLast,Smartdep_entry_last),
    outdepnext( Deps, Opts, TimeF, TimeL, DirPlace, OutNext, _NAP, Smartdep_entry_next ), %%  - Day
    ( Smartdep_entry_next \== []  ->
      SmartDeps = [Smartdep_entry_first,Smartdep_entry_next,Smartdep_entry_last]
    ; SmartDeps = [Smartdep_entry_first,Smartdep_entry_last] ).  % true ),


outdeplisttime1(Deps,_Day,_Opts,DirPlace,(OutFirst,OutLast), MAP,_SmartDeps) :-
    value(smsflag,true),
 \+ value(nightbusflag,true),
         outdepfirst(Deps,DirPlace,_TimeF,OutFirst,MAP,_Smartdep_entry_first),
         outdeplast(Deps,DirPlace,_TimeL,OutLast,_Smartdep_entry_last).

%% Only TWO deps (Past departures ignored)
outdeplisttime1(Deps,Day,Opts,DirPlace,(OutNext,OutLast),MAP,SmartDeps) :-
 \+ value(smsflag,true),
 \+ value(nightbusflag,true),
 \+ anotherday(Day),
    !,
    outdepnext(Deps,Opts,_,TimeL,DirPlace,OutNext,MAP,Smartdep_entry_next), %% <--- NEI, ikke 9999
         outdeplast(Deps,DirPlace,TimeL,OutLast,Smartdep_entry_last),
         SmartDeps = [Smartdep_entry_next,Smartdep_entry_last].


outdeplisttime1(Deps,Day,Opts,DirPlace,(OutFirst,OutNext,OutLast), MAP,SmartDeps) :-
 \+ value(smsflag,true),
 \+ value(nightbusflag,true),
    outdepfirst(Deps,DirPlace,TimeF,OutFirst,MAP,Smartdep_entry_first),      %% MW-120917    %% Insert SmartDeps
                                                                        %% MW-120829
         outdeplast(Deps,DirPlace,TimeL,OutLast,Smartdep_entry_last),
         SmartDeps = [Smartdep_entry_first,Smartdep_entry_last],
         (\+ anotherday(Day) -> %% Next departure is irrelevant if not today !!! %%RS-120813
          outdepnext(Deps,Opts,TimeF,TimeL,DirPlace,OutNext,_NAP,Smartdep_entry_next),    %%  -Day
          SmartDeps = [Smartdep_entry_first,Smartdep_entry_next,Smartdep_entry_last];      %% MW-121003
          OutNext=true).

%outdeplisttime1(Deps,_Day,Opts,DirPlace,(OutFirst,OutNext,OutLast), MAP) :-
% \+ value(smsflag,true),
% \+ value(nightbusflag,true),
%    outdepfirst(Deps,DirPlace,TimeF,OutFirst,MAP),
%         outdeplast(Deps,DirPlace,TimeL,OutLast),
% %%      (\+ anotherday(Day) -> %% Next departure is irrelevant if not today !!! %%RS-120813
%          outdepnext(Deps,Opts,TimeF,TimeL,DirPlace,OutNext,_NAP)   .  %%  ; %%  -Day
% %%         OutNext=true).



%%


outdeplist02( Deps, Day, Opts, DirPlace, Out, MAP, SmartDeps ) :-
    outdeplist1(Deps,Day,Opts, DirPlace, Out, MAP, SmartDeps ).


%%% OUTDEPLIST1 %%%%%%%

outdeplist1(Deps,Day,Opts,DirPlace,Out,MAP,SmartDeps) :-
    delete1( direct, Opts, Opts1 ),   %% utility:delete1.       %% RS-141109  User specifically ASKED FOR a direct route
    !, % direct is no longer relevant                           %% RS-141109  E.g. both direct and transfer are handled below
    outdeplist1(Deps,Day,Opts1,DirPlace,Out,MAP,SmartDeps).


%% NO Direction nor time
outdeplist1(Deps,_Day,Opts,_Place,Out1Out2,  [Dep1,Dep2],_SmartDeps) :-
    value(smsflag,true),
    Opts = [],    % no direction
    !,
    traceprog(4,case1),
         timenow(Tid),               %% should be part of bustrans?
    keepafter(Tid,Deps,AfterDeps),
    firsttostation(AfterDeps,Dep1),   % from HT
    firstfromstation(AfterDeps,Dep2), % to HT
    outdepnexttostation(Dep1,Out1),
    outdepnextfromstation(Dep2,Out2),
    saysomething(Out1,Out2,Out1Out2).


%%%%% outdeplisttime  first/next/last (where adequate) %%%%%%%%%%%%
%%%%% E.g. "next bus after now" is not applicable if not today?? %% RS-120813
%%%%%                 ---------------                  %%%%%%%%%%%%

outdeplist1( Deps, Day, Opts, DirPlace, ( ( Out, earliesttimes ) ), MAP, SmartDeps ) :-   % Nte siste avgang
         member(nth(N),Opts),
         member(last(1),Opts),
    !,
    traceprog(4,case3),
         reverse(Deps,RevDeps),
         nth(N,RevDeps,Dep),
         outdeplisttime([Dep],Day,Opts,DirPlace,Out,MAP,SmartDeps).


outdeplist1(Deps,Day,Opts,DirPlace,Out,MAP,SmartDeps) :-   % siste N avganger
         delete1(last(N),Opts,Opts1),
    !,
    traceprog(4,case4),
         reverse(Deps,RevDeps),
         memberids0(N,RevDeps,LastRev), %% if 0, keep all
         reverse(LastRev,LastDeps),
    deleteall(lastcorr,Opts1,Opts2),         %% from utility.pl
    outdeplist1(LastDeps,Day,[time|Opts2],DirPlace,Out,MAP,SmartDeps).


% moved up, last takes priority
outdeplist1(Deps,Day,Opts,DirPlace,((Out,earliesttimes)),MAP,SmartDeps) :-   % siste avgang
         member(last(1),Opts),
    !,
    traceprog(4,case5),
         lastmem(Deps,Dep),     
         outdeplisttime([Dep],Day,Opts,DirPlace,Out,MAP,SmartDeps).

% moved up, last takes priority
outdeplist1(Deps,Day,Opts,DirPlace,((Out,earliesttimes)),MAP,SmartDeps) :-   % ankomst FØR == siste ankomst
    member(lastcorr,Opts),
    !,
    traceprog(4,case6),
    find_last_arrival(Deps,Dep),
         outdeplisttime([Dep],Day,Opts,DirPlace,Out,MAP,SmartDeps).



outdeplist1(Deps,Day,Opts,DirPlace,((Out,earliesttimes)),MAP,SmartDeps) :-   % Nte første avgang
         member(nth(N),Opts),
%%%%     member(first(1),Opts), %% TA-101022 ??
    !,
    traceprog(4,case7),
         nth(N,Deps,Dep),
         outdeplisttime([Dep],Day,Opts,DirPlace,Out,MAP,SmartDeps).


outdeplist1(Deps,Day,Opts,DirPlace,(Out, earliesttimes),MAP,SmartDeps) :-   % Nte  avgang
         member(next(N1),Opts),
    N1 < 0, N is -N1, %%
    !,
    traceprog(4,case8),
    nth(N,Deps,Dep),
         outdeplisttime([Dep],Day,Opts,DirPlace,Out,MAP,SmartDeps).


outdeplist1(Deps,Day,Opts,DirPlace,((Out,earliesttimes)),MAP,SmartDeps) :-   % Nte neste avgang
         member(nth(N),Opts),
         member(next(1),Opts),
    !,
    traceprog(4,case9),

    nth(N,Deps,Dep),
         outdeplisttime([Dep],Day,Opts,DirPlace,Out,MAP,SmartDeps).


outdeplist1(Deps,Day,Opts,DirPlace,((Out,earliesttimes)),MAP,SmartDeps) :-   % Nte neste avgang
         member(nth(N),Opts),
         member(nextaftertime(1),Opts),
    !,
    traceprog(4,case10),
         nth(N,Deps,Dep),
         outdeplisttime([Dep],Day,Opts,DirPlace,Out,MAP,SmartDeps).



outdeplist1(Deps,_Day,Opts,DirPlace,(Out,earliesttimes),MAP,SmartDeps) :-   % neste =< N avganger
         member(next(_N),Opts),

    !,
    traceprog(4,case12),

    justoutputtheliststar(Deps,DirPlace,Out,Opts,MAP,SmartDeps).




%% SMS Check if first / first(1) is really EARLY (ANOTHER DAY)
outdeplist1(Deps0,Day,Opts,DirPlace,(OutFirst), MAP,_SmartDeps) :- % første/neste avgang
    value(smsflag,true),
     anotherday(Day),
        test(
     (member(firstcorr,Opts);
      member(first,Opts);       % unspecified first
      member(first(1),Opts)) ),    % ambiguous, get both !
    !,
    traceprog(4,case13),
(
    member(nightbus,Opts) ->
    Deps0=Deps
    ;
    morning_break(T0430),
    keepafter(T0430,Deps0,Deps)), %% Night routes are excluded !!!
         firstdepnotices(Deps),
         memberids( 1, Deps, FirstDeps1 ),

    outdepfirst(FirstDeps1,DirPlace,_TimeF,OutFirst, MAP,_Smartdep_entry_first).


            %% SMS first means only next
outdeplist1(Deps,Day,Opts,DirPlace,(OutNext,earliesttimes),MAP,SmartDeps) :- % første/neste avgang
    value(smsflag,true),
    \+ member(firstcorr,Opts),
    \+ member(time,Opts),      % time means a clock has been set
         (member(first,Opts);       % unspecified first
     member(first(1),Opts);    % ambiguous, get both !
     member(next(1),Opts)),
    !,
    traceprog(4,case14),
    timenow(NOW),
    keepafter(NOW,Deps,AfterDeps),
         memberids(1,AfterDeps,NextDeps),
    outdeplisttime(NextDeps,Day,Opts,DirPlace,OutNext,MAP,SmartDeps).



%% SMS flag, Nightbus, no destination ==> summary of departures !!!


%% Avoid Night to saturday if saturday is just daycode !!!

outdeplist1(Deps0,Day,Opts,DirPlace,(OutFirst,OutNext,earliesttimes), MAP,_SmartDeps) :- % første/neste avgang
   \+ value(smsflag,true), %% NONSMS -> FIRST/LAST
   \+ member(firstcorr,Opts),
   \+ member(time,Opts),       % time means a clock has been set
   (  member(first,Opts) ;       % unspecified first
      member(first(1),Opts) ;    % ambiguous, get both !
      member(next(1),Opts) 
   ),
    \+ anotherday(Day),
    !,
    traceprog(4,case15),
         timenow(Tid),               %% should be part of bustrans?
   (
    member(nightbus,Opts) ->
     Deps0=Deps
    ;
     keepafter(Tid,Deps0,Deps)),   %% after now

         memberids(1,Deps0,FirstDeps),
    keepafter(Tid,Deps,AfterDeps),
         memberids(1,AfterDeps,NextDeps),
         outdepfirst(FirstDeps,DirPlace,TimeF,OutFirst, MAP,_Smartdep_entry_first),  %% MW-121003 %% case where smartdeps should be added?

    outdepnext(NextDeps,Opts,TimeF,_TimeL,DirPlace,OutNext, _NAP,_Smartdep_entry_next). %% NB calls timenow again!

outdeplist1( Deps, Day, Opts, DirPlace, Out, MAP, SmartDeps ) :-   % første N avganger
         delete1( first(N), Opts, Opts1 ),
    !,
    traceprog(4,case16),
    deleteall( first, Opts1, Opts2 ),           % just a flag
         memberids0( N, Deps, FirstDeps ),
    outdeplist1( FirstDeps, Day, [time|Opts2], DirPlace, Out, MAP, SmartDeps).


outdeplist1(Deps,Day,Opts,DirPlace,((Out,earliesttimes)),MAP,SmartDeps) :-   % n'te avgang
         member(nth(N),Opts),                                   % samme dag
    \+ anotherday(Day), %%
    !,
    traceprog(4,case17),
    timenow(NOW),
    keepafter(NOW,Deps,Deps1),

    nth(N,Deps1,Dep),
         outdeplisttime([Dep],Day,Opts,DirPlace,Out,MAP,SmartDeps).


outdeplist1(Deps,Day,Opts,DirPlace,((Out,earliesttimes)),MAP,SmartDeps) :-   % neste avgang
         member(next(1),Opts),
    !,
    traceprog(4,case19),
         timenow(Tid),
         nextdep(Tid,Dep,Deps), %% DepTime >= Tid  buslog.pl
         outdeplisttime([Dep],Day,Opts,DirPlace,Out,MAP,SmartDeps).

outdeplist1(Deps,Day,Opts,DirPlace, ((Out,earliesttimes)),dir(Dep1,DirPlace),SmartDeps) :-   % første avgang
         (member(first(1),Opts)   ;     member(firstcorr,Opts)),

         member(Dep,Deps),
    !,
    traceprog(4,case20),
    first_dep(Deps,Dep1),
         outdeplisttime([Dep],Day,Opts,DirPlace,Out,_MAP,SmartDeps).


% Number of departures

outdeplist1(_Deps,_,Opts,_DirPlace,space0,_MAP,_SmartDeps) :-
         member(number,Opts),
    !,
    traceprog(4,case21).

%%   departure/departures Taken care of in busans


outdeplist1(Deps,Day,Opts,DirPlace,((Out,earliesttimes)),MAP,SmartDeps) :-   % Nte avgang
         member(nth(N),Opts),
    !,
    traceprog(4,case22),

         length(Deps,LDS), %% TA-101021
    minval(N,LDS,N1), %% check, nth(N) =< # list   % from utility.pl

    nth(N1,Deps,Dep),

         outdeplisttime([Dep],Day,Opts,DirPlace,Out,MAP,SmartDeps).


% Få eller alle avganger
outdeplist1(Deps,_,Opts,DirPlace,((Out,earliesttimes)),MAP,SmartDeps) :-
    (testmember(time,Opts)  ;  testmember(timeset,Opts)),   %% from utility.pl

    length(Deps,DepsLengde),
    maxnumberofindividualdepartures(MaxInd),
    DepsLengde=< MaxInd,
         !,
    traceprog(4,case23),

    justoutputthelist(Deps,DirPlace,Out,Opts,MAP,SmartDeps).
    %%print_smartdep_entries(SmartDeps). %% star only for sms and afternow




% Find next 2 if SMS %%   Default

outdeplist1(Deps,Day,Opts,DirPlace,((Out,earliesttimes)),MAP,SmartDeps) :-

    value(smsflag,true),
 \+ value(nightbusflag,true),
 \+ time_options(Opts),
 \+ member(timeset,Opts),
 \+ anotherday(Day),

    timenow2(1,NOW), %% at 17:45, timenow is past
    keepafter(NOW,Deps,Deps1),                    %% star takes after now
%%%%%%%%%%    Deps1 \== [], %% EMPTY /// ---> Needs warning, TIME not tomorrow

    !,
    traceprog(4,case24),

    justoutputtheliststar(Deps1,DirPlace,Out,Opts,MAP,SmartDeps).
    %%print_smartdep_entries(SmartDeps).


% Mange avganger

outdeplist1([],Day,Opts,DirPlace,Out,MAP,SmartDeps) :- %% not earliesttimes
    !,
    traceprog(4,case25),
    outdeplisttime([],Day,Opts,DirPlace,Out,MAP,SmartDeps). %% whatever you get


outdeplist1(Deps,_Day,Opts,DirPlace,((Out,earliesttimes)),DESTMAP,SmartDeps) :- %% from A to B
    testmember(time,Opts),  %% then not afternow %% TA-100630
%%    \+ anotherday(Day),     %% RS-120813 Maybe this should work for any day?
    \+ value(dialog,1),
    !,
    traceprog(4,case26na),

%%%%%    outdeplisttime(Deps,Day,Opts,DirPlace,Out,MAP). %% same as \
    justoutputthelistnotafternow(Deps,DirPlace,Out,Opts,DESTMAP,SmartDeps). %% %% then not afternow
    %%print_smartdep_entries(SmartDeps).


outdeplist1(Deps,Day,Opts,DirPlace,((Out,earliesttimes)),MAP,SmartDeps) :- %% from A to B (today, after now)
    \+ anotherday(Day),
    \+ value(dialog,1),

    !,
    traceprog(4,case26),
    justoutputtheliststar(Deps,DirPlace,Out,Opts,MAP,SmartDeps).
    %%print_smartdep_entries(SmartDeps).


outdeplist1( Deps, Day, Opts, DirPlace, ( (Out,earliesttimes) ), MAP, SmartDeps ) :-       %% RS-120813 case27: Last resort? Default? Catch all... (Nightbus?)
    !,
    traceprog(4,case27),
    outdeplisttime( Deps, Day, Opts, DirPlace, Out, MAP, SmartDeps ). %% Next/Last



first_dep([D|_],D):-!.
first_dep(_,[]).

%% END OUTDEPLIST1  %%%%%



print_smart_init(Opts) :-
    value(smartdepflag,true),
    !,
    comptimeflag(Opts,Trans,TF),

    write('{"transfer":'),out(Trans),output(','),       % out/1 is from utility.pl
    write('"timeset":'),out(TF),output(','),

    output('"departures" : [').

print_smart_init(_Opts).


comptimeflag(Opts,Trans,Timeset):-

    bollepling( member(transfer,Opts), Trans ),
    bollepling( smart_time_options(Opts), Timeset ).

comptimeflag(_Opts,'"false"').

bollepling( Test, Trans ) :-
    call( Test ),
    !,
    Trans='"true"'.

bollepling(_Test,'"false"').


smart_time_options(Opts):-
    member(Opt,Opts),
    smart_time_option(Opt),
    !.

smart_time_option(timeset).
smart_time_option(time).  %% Means that a time has been set, avoid default after now
smart_time_option(last(_)).
smart_time_option(prev(_)).
smart_time_option(lastcorr).
smart_time_option(nextaftertime(_)).

smart_time_option(nth(N)) :-N >1. %% første = nth(1) innocent   %% nth/1 is from utility.pl

%%  smart_time_option(first(_)).
%%  smart_time_option(next(_)).
%%  smart_time_option(first).



print_smart_trail:- value(smartdepflag,true) ->  output(']}');true.




decide_actual_noid3(N,Opts,NActual) :- %% ad hoc %% TA-101022
     member(nth(M),Opts),  %% in nth (M)>N, may need M
     !,
     maxval(M,N,K),        % utility.pl
     decide_actual_noid(K,NActual).

decide_actual_noid3(N,_Opts,NActual) :- %% TA-101022
    decide_actual_noid(N,NActual).



sort_deps_deptime(L,L1):-
     set_of(  pair(DEP,depnode(ARR,DEP,DA,DD,STT,RID,BUS,SEQNO,STA)),
            member(    depnode(ARR,DEP,DA,DD,STT,RID,BUS,SEQNO,STA), L),
            Z),
     transdeplist(Z,L1).

transdeplist([pair(_,E)|L],[E|L1]):-
    transdeplist(L,L1).
transdeplist([],[]).



firsttostation(Deps,Dep ):-
    member(Dep,Deps),
    Dep = depnode(_Time,_Time9,_DelArr,_DelDep,_BegTime,Rid,_,_,Station),
    rid_to_direction(Rid,to,Station),
    !.

firsttostation(_,nil).


firstfromstation(Deps,Dep ):-
    member(Dep,Deps),
    Dep = depnode(_Time,_Time9,_DelArr,_DelDep,_BegTime,Rid,_,_,Station),
    rid_to_direction(Rid,from,Station),
    !.

firstfromstation(_,nil).


outdepnexttostation(Dep,
          (  bwrbusbc(Tram,BusN),
        bcp(passes),
                  bwr(Station),bcp(attime),bwt(Time),
             bcp(coming),bcp(from),bwr(hovedterminalen),period))
      :-
      Dep = depnode(Time,_Time9,_DelArr,_DelDep,_BegTime,Rid,BusN,_,Station),
      ridtobusnr(Rid,BusN),
      vehicletype(BusN,Tram),
     !.


outdepnexttostation(_Dep,space0).

outdepnextfromstation(Dep,
                                (
             bwr2bc(BusN),  %% (Tram,
             bcp(passes),
                                 bwr(Station),bcp(attime),bwt(Time),
             bcp(indirection),bwr(hovedterminalen),period)):-

      Dep = depnode(Time,_Time9,_DelArr,_DelDep,_BegTime,Rid,BusN,_,Station),
      ridtobusnr(Rid,BusN),
%%       vehicletype(BusN,Tram),
      !.

outdepnextfromstation(_Dep,space0).



find_last_arrival(Deps,DepL1):-
    set_of(
        argh(Arr,  depnode(Arr,Dep,DelArr,DelDep,BegTime,Rid,Bus,SeqNo,Station)),
        (   member(depnode(Arr,Dep,DelArr,DelDep,BegTime,Rid,Bus,SeqNo,Station),Deps)),
        Z),
    lastmem(Z,argh(_,DepL1)).


find_last_departure(Deps,DepL1):-
    set_of(
        argh(Dep,     depnode(Arr,Dep,DelArr,DelDep,BegTime,Rid,Bus,SeqNo,Station)),
        ( member(depnode(Arr,Dep,DelArr,DelDep,BegTime,Rid,Bus,SeqNo,Station),Deps),Dep \== 9999),
        Z),
    lastmem(Z,argh(_,DepL1)).



decide_actual_noid(_N,NActual):-  %% TA-110502
    value(smartdepflag,true),
    !,
    NActual = 6.  %% <---- ????????????????????



decide_actual_noid(N,NActual):-
    value(smsflag,true), %% not for web %% TA-101117
    N =< 1, % unspecified,
    !,
    NActual = 1.


decide_actual_noid(N,NActual):-
    N =< 1, % unspecified, %% 0 or 1
    !,
    maxnumberofindividualdepartures(MaxInd), %% busdat
    NActual= MaxInd.

decide_actual_noid(N,NActual):-
    N > 1, % specified,
    maxnumberofindividualdepartures(MaxInd), %% busdat
    N =< MaxInd,
    !,
    NActual = N.

decide_actual_noid(N,NActual):-
    N > 1, % specified,
    maxnumberofindividualdepartures(MaxInd), %% busdat
    N  > MaxInd,
    !,
    NActual = MaxInd.


decide_actual_noid7(_Opts,NActual):-
    value(smartdepflag,true),!,NActual= 6. %%% <---- ??????

decide_actual_noid7(Opts,MAX):-
    maxnumberofindividualdepartures(MNID),

  ( (member(next(N),Opts), N > 0) -> minval(N,MNID,MAX); MAX=MNID ).



earliesttimes :-
    \+ value(smsflag,true),
    \+ value(dialog,1),
    !,
    printmess1(earliesttimes).
earliesttimes.

%%%%%%%%%% END OUTDEPLIST %%%%%%%%%%%%%%%%%%%%%


saysomething(space0,space0,space0):-!. %%%%%% printmessage(mustknow(place))):-!.

saysomething(Out1,Out2,((Out1,Out2))).


%%%%%%


justoutputthelistnotafternow(Deps,DirPlace,Out,Opts,DESTMAP,SmartDeps):-
    traceprog(7,Deps),

    maxnumberofindividualdepartures(MNID), %% Extra check

    ( (member(next(N),Opts), N > 0) -> minval(N,MNID,MAX);MAX=MNID), %% MAX is N; MAX is MNID),

    traceprog(5,just(MAX)),

    memberids(MAX,Deps,Deps5),

    justoutputthelist(Deps5,DirPlace,Out,Opts,DESTMAP,SmartDeps).



%% justoutputtheliststar // filter all but first within 5 minutes or same RID

% Purpose is to not let the second (of the originals) dep shadow for next after 5 minutes
% However, same rid makes it complicated

justoutputtheliststar(Deps,DirPlace,Out,Opts,MAP,SmartDeps):-
    value(dialog,1),
    !,
    split(1,Deps,[Dep1],_Deps1),        % split/4 is from utility.pl
    justoutputthelist([Dep1],DirPlace,Out,Opts,MAP,SmartDeps).


justoutputtheliststar(Deps,DirPlace,Out,Opts,MAP,SmartDeps):-
    traceprog(7,Deps),


    decide_actual_noid7(Opts,NActual),

    traceprog(5,just(NActual)),

    split(1,Deps,[Dep1],Deps1),

%%%%%%%%%   ridof(Dep1,RID1),

    avoidsamerid2(Dep1,Deps1,Deps2), %% avoid Gløs N/Gløs S same time / same RID
                                     %% if smartdep, cut all subsequent RIDS ??
                                     %% TA-110503
    timenow2(5,NOW5),
    keepafter(NOW5,Deps2,Deps3),
    append([Dep1],Deps3,Deps4),

    memberids(NActual,Deps4,Deps5),

    justoutputthelist(Deps5,DirPlace,Out,Opts,MAP,SmartDeps).

% % % %

justoutputthelist(Deps,DirPlace,Out,Opts,DESTMAP,SmartDeps):-
    traceprog(4,Deps),
    firstdepnotices(Deps),
    Deps = [Dep|_], %% safe ????

    getdeptime(Dep,Firstdeparturetime),
    addrefdialog(firstdeparturetime,Firstdeparturetime),
    ( firstdeparturetime := Firstdeparturetime ), %% Moved to firstdepnotice

    justoutputthelist0(Deps,DirPlace,Out,Opts,DESTMAP,SmartDeps). %% no warning

justoutputthelist0(Deps,DirPlace,Out,Opts, dir(Dep1,Bingo),SmartDeps):-  %% no warning

  set_of( x3(TimeDurations,BusN1,Station1), %% TimeDurations first=>sorted on time!

      busleaveset(BusN1,Station1,Deps,DirPlace,Opts,   TimeDurations),
      BusDeps),

    outsmalldeps(BusDeps,DirPlace,Out,Opts,SmartDeps),

    first_dep(Deps,Dep1),   ridof(Dep1, RID),

    dest_station(BusDeps, RID,  Bingo).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 dest_station( X3LIST, RID,   DEST):-
     member(X3,X3LIST),
     X3 = x3(TDLIST,_Busno,_Orig),
     member( td(_, RID , _,DEST),TDLIST),
     !.

 dest_station( _X3LIST,_RID,nil).

%%  dest_station([x3([td(1507,bus_5_251,21,dragvoll),td(1515,bus_5_252,21,dragvoll),td(1527,bus_5_253,21,dragvoll)],5,dronningens_gate_d3)],bus_5_251,_159176) ?

%% NB   -> nopay !!!
outdummy(_Deps,printmessage(cannotanswer)). %% Avoid Double messages

ridof(    depnode(_,_,_,_,_,RIDN1,_,_,_),RIDN1).

stationof(depnode(_,_,_,_,_,_,_,_,STA),STA).


firstRID(RIDN1,[depnode(_,_,_,_,_,RIDN1,_,_,_)|_]).

avoidsamerid2(_Dep,Deps1,Deps1):- %% DUMMY TEST
    value(smartdepflag,true),
    !.


avoidsamerid2(Dep,Deps1,Deps2):- %% REMOVE all (succeeding) deps with same RID and Station
    value(smartdepflag,true),    %% TA-110503
    !,
    ridof(Dep,RID),
    stationof(Dep,STAT),
    set_filter(X, (ridof(X,R),R \== RID,stationof(X,S),S \==STAT),Deps1,Deps2). % set_filter is from utility.pl



avoidsamerid2(Dep,Deps1,Deps2):- %% maybe relax = station ? %% TA-110503
    ridof(Dep,RID),
%%     stationof(Dep,STAT),
    set_filter(X, (ridof(X,R),R \== RID
    %%%%   ,stationof(X,S),S \==STAT
    ),Deps1,Deps2).



/* obsolete %% TA-110503
avoidsamerid(_,L,L):-value(smartdepflag,true),!.  %% Acually,test both RID and Station !!!!
                                             %% TA-110502
avoidsamerid(RID,L1,L2):-
    set_filter(X,(ridof(X,R),R \== RID),L1,L2).
*/



findsetoftimes(Deps,Times):-
    set_of(DT, member(depnode(_,DT,_,_,_,_,_,_,_),Deps),Times).

writetimes( Times, (bwr2(Times,departure),period) ).

%% NEW PREDICATE
memberids0(N,Deps1,Deps1):-
    N=<0,
    !.

memberids0( N, Deps1, Deps2 ) :-
    members( N, Deps1, Deps2 ).

memberids( N, Deps1, Deps2 ) :-
    members( N, Deps1, Deps2 ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


stationlistorand(Buses,Stations, BWRSTATIONS):- %% For et slit
    length(Buses,NB),
    length(Stations,NS),
    NB > 1,
    NS > 1,
    !,
    BWRSTATIONS =bwrsingleorlist(Stations). %% many buses, not all stations

stationlistorand(_Buses,Stations, BWRSTATIONS):-
    BWRSTATIONS =bwrsinglelist(Stations).



convifpossible(X,hovedterminalen):-
    corr(X,hovedterminalen),!.
convifpossible(X,X).


firstdepnotices(Deps):-
    Deps=[Dep|_],
    !,
    firstdepnotice(Dep).

firstdepnotices(Dep):-
   firstdepnotice(Dep).


warningtime(Date,Time):- %% super Ad Hoc %% TA-110202
    printdatetimetoalarmstring2(Date,Time).

firstdepnotice(Dep):-
    traceprog(4,Dep), %% 3  Temp %% TA-110204

    getdeptime(Dep,Firstdeparturetime),
    addrefdialog(firstdeparturetime,Firstdeparturetime),
    ( firstdeparturetime := Firstdeparturetime ),

    ((value(warningflag,true),value(smsflag,true)) ->
        (deptimeofwarning(Dep,Date,Time),

   set(warningtime , notification(Date,Time)),     %% declare.pl

   printdatetimetoalarmstring)
     ;
   true).

firstdepnotice(_).



futuretime(Date2,_Time2):-
    todaysdate(Date1),
    before_date1(Date1,Date2),
    !.

futuretime(Date2,Time2):-
    todaysdate(Date1),
    Date1=Date2,
    timenow(Time1),
    Time1 < Time2,
    !.



printdatetimetoalarmstring:-
   value(warningtime, notification(Date,Time)),
   futuretime(Date,Time),
   !,
   printdatetimetoalarmstring2(Date,Time).

printdatetimetoalarmstring:-
   pay1,
   printmess1(toolate).


printdatetimetoalarmstring2(Date,Time):-
   adjust2400(Date,Time,Date1,Time1), %% 20040830240000 -> 2004083100000

%    Date1=date(YYYY,MM,DD),

   makedatetimetoalarmstring(Date1,Time1,WS),
   write(WS),nl.


adjust2400(Date,Time,Date1,Time1):- %%  20040830240000 -> 2004083100000
    Time=2400,
    !,
    Time1 = 0,
    add_days(Date,1,Date1).
adjust2400(Date,Time,Date,Time).

makedatetimetoalarmstring(Date,Time,WS):-
    datetimestring(Date,Time,AS),
    append_atomlist(['! ', AS],WS).

datetimestring(date(YYYY,MM,DD),TIME,AS):-
    YYYY >= 2000,
    X is (YYYY*10000 + MM*100+ DD)*1000000+TIME*100+00, %%
    number_to_string(X,AS). %% utility.pl



deptimeofwarning(X,Date,PTime):-
    getfirstdeparture(X,Date0,Time0),
    getprewarning(PreMin),
    computewarningtime(Date0,Time0,PreMin,Date,PTime).


getfirstdeparture(X,Date,Time):-
    getdepdate(Date),
    getdeptime(X,Time).


getlastarrival(X,Date,Time):-
    getdepdate(Date),
    getdeptime(X,Time).



getdepdate(Date):-
    value(actualdate,Date).

getdeptime(depnode(_,Time,_,_,_,_,_,_,_),Time).
getdeptime(depans(_,_,Time,_,_,_,_,_,_,_),Time). %% /8
getdeptime(td(Time,_RID_,_Dur_,_,_,_), Time).


getprewarning(PreMin):- %% may be negative, i.e. warning after
    value(prewarningtime,PreMin), %% specified by user
    number(PreMin), %% Precaution
    !.

getprewarning(DPWT):- %% Default
    defaultprewarningtime(DPWT).



computewarningtime(Date0,Time0,PreMin,Date0,Warningtime):-
   Time0 > 2400, %% means reference to day before
   subfromtime(Time0,PreMin,Rawtime),
   Rawtime =< 2400, %% date moved back
   Rawtime >= 0,
   !,
   Warningtime=Rawtime.


computewarningtime(Date0,Time0,PreMin,Date1,Warningtime):-
   Time0 > 2400, %% means reference to day before
   subfromtime(Time0,PreMin,Rawtime),
   Rawtime > 2400, %% next day
   !,
   add_days(Date0,1,Date1),
   Warningtime is Rawtime - 2400. %%  correct ?


computewarningtime(Date0,Time0,PreMin,Date0,Warningtime):-
   Time0 =< 2400,
   subfromtime(Time0,PreMin,Rawtime),
   Rawtime >= 0,
   !,
   Warningtime = Rawtime.


computewarningtime(Date0,Time0,PreMin,Date1,Warningtime):-
   Time0 =< 2400,
   subfromtime(Time0,PreMin,Rawtime),
   Rawtime < 0,
   !,
   sub_days(Date0,1,Date1),
   Warningtime is  Rawtime+ 2400. %% correct ?


computewarningtime(Date0,Time0,_PreMin,Date0,Time0). %% Ad Hoc



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setoffirst( X, P, Z ) :- !, setof( X, P, Z ).  %%  63 Skansen DG-19 Asbjgt DG-50


%% If to but not from in Options , means arrival time

busleaveset(BusN1,Station1,Deps,DirPlace,Opts,   TimeDurations) :-

    (  (testmember(to,Opts), \+ testmember(from,Opts), DirPlace \== nil)
            -> Xopt=to;
        Xopt=from),

    setoffirst(td(Time1, RID, Duration,ToStation), % one set for each BusN1, %% setof  NB!!!
          busleave(Xopt,Time1, RID, BusN1,Station1,Duration,Deps,DirPlace,ToStation),
          TimeDurations).
%%%     !.  // busleavset bactracks for each N1 !!!

%% Default

%%                                                                 added late arrival
/* Cuts all after 1.

%% Hack   Setof, but only keep first
setoffirst(X,P,[Z1]) :- setof(X,P,Z),  firstmem(Z,Z1).

  %% same RID and correlating  destination, avoid the loop arrival

  %% [td(2058,bus_0063_0090,3,dronningens_gate_19),td(2058,bus_0063_0090,33,dronningens_gate_50)]) ?
  %%                          ***                                           ***
  %%                                                                        drop

*/


busleave( Xopt, Time09, Rid1, BusN1, Station1, Duration, Deps, DirPlace, ToStation ) :-

        member( depnode(Time0,Time9,_DelArr1,DelDep1,_,Rid1,BusN1,_,Station1), Deps ),

   (Xopt == to -> Time09=Time0; Time09=Time9),

        ridtobusname(Rid1,BusN1),
        firstarrive(Rid1,DirPlace,ToStation,DelArr2,_),
   DelArr2 \== 999, %% spurious cut dep
   DelArr2 >= DelDep1, %% spurious arrival  %%  buss 63 fra asbjørnsens gt til m
        Duration is DelArr2-DelDep1.



firstarrive(Rid,Place,Station,   DelArr2,DelDep):-
         veh_mod(TTP), %% ad hoc
    passMOD(TTP,Rid,Place,_STATNO,Station,DelArr2,DelDep2),

    DelDep2 > 0, %% Ad Hoc   bus36   M4 -> Jakobsli -> M4
                 %%                  NO                YES

    adjust999(DelArr2,DelDep2,DelDep).

%%%%%%%%    !.  %% NB  Gløs -> D2 CUT D2 -> Buenget
                              %%

outsmalldeps( [],_Sentrum,_,_Opts, []):- %% Empty ( <= error ?)
    !,
    nl,
    output('*** Jeg finner ingen forbindelser ***'). %% error alarm


outsmalldeps( [   x3([],_,_)    ],_Sentrum,_,_Opts, []):- %% Empty ( <= error ?)%%
    !,
    nl,
    output('***  Jeg finner ingen forbindelse ***'). %% error alarm



outsmalldeps([   x3([TimesDuration],BusN,Station)   ],DirPlace, %% only 1
                                 (bwrbusbc(Bus,BusN),
              bcp(passes),bwr(Station),bcp(attime),
                                  OutDeps2,period),Opts,[Smartdep_entry]) :-
         !,
    vehicletype(BusN,Bus),
    outsmalldeps2(arrivaltime,Station,[TimesDuration],DirPlace,OutDeps2,Opts,Smartdep_entry).


outsmalldeps(A,B,C,Opts,D):- %% D-liste med smartdep_entry for JSON %% MW-120906
    outsmalldeps0(A,B,C,Opts,D).
    %%print_smartdep_entries(D).


outsmalldeps0([],_,[],_Opts, []). %% , [] ).%% RS-120829 %% empty Smartdep_entries, terminate Recursion

outsmalldeps0([ x3(TimesDuration,BusN,Station)|BusDeps],DirPlace, %% TimesDuration FIRST!!!!
                                 (bwrbusbc(Bus,BusN),
             bcp(Passes),     bwr(Station),

    OutDeps2,period,OutDeps),Opts, [Smartdep_entry|Smartdep_entries]) :- %% RS-120829 %%

     %%   write( 'BusDeps: '),
     %%   write(BusDeps),

    vehicletype(BusN,Bus),

    code_passes(Opts,Passes),

         outsmalldeps2(duration,Station,TimesDuration,DirPlace,OutDeps2,Opts,Smartdep_entry), %% RS-120829
         ensure_removed([BusN,Station,TimesDuration],BusDeps,BusDeps2),
         outsmalldeps0(BusDeps2,DirPlace,OutDeps,Opts,Smartdep_entries). 


code_passes(Opts,goesto):-   member(to,Opts),  \+ member(from,Opts),!.
code_passes(Opts,goesfrom):- member(from,Opts),\+ member(to,Opts),!.
code_passes(_,passes):-!.


outsmalldeps2(arrivaltime,Station,[TimesDuration],DirPlace, (bwt(Time),OutArr),_Opts,Smartdep_entry ) :-  %% MW-120906
         faenta([TimesDuration],Times,Duration,SetOfDest), % Duration =  Short - Long
    Times = [Time],  %% assumption: only one time
    addtotime(Time,Duration,Arrival),
    set(firstdeparturetime,Time),  %% for reference
    set(lastarrivaltime,Arrival),  %% OBSOLETE

         (\+  value(dialog, 1),!
      ;
    getcurrent(Cid),
      addref(Cid,Time,firstdeparturetime),
      addref(Cid,Arrival,lastarrivaltime)
    ),

   (SetOfDest=[M4] -> UT=M4;UT=DirPlace),
         outandarrives3(UT,arrival(Arrival),OutArr),
    create_smartdep_entry(Station,[TimesDuration], DirPlace,Smartdep_entry).     %% MW-120926

outsmalldeps2(duration,Station,TimesDurations,DirPlace,(bwtimes2(Times),OutArr),_Opts,Smartdep_entry) :- %% RS-120829 %% Avoid sideeffects like printing 
         faenta(TimesDurations,Times,Duration,SetofStations),
    outandarrivesset(Station,DirPlace,SetofStations,duration(Duration),OutArr),
    create_smartdep_entry(Station,TimesDurations,   DirPlace,Smartdep_entry). %% TA-110405


faenta(TDlist,Times,Durations,SetofStations):-
    set_of(Time,    member(td(Time, _, _,  _),      TDlist), Times),
    set_of(Dur,     member(td(_,_,   Dur,_),      TDlist), TD),
    set_of(Station, member(td(_,_,   _,  Station),TDlist), SetofStations),

    minimum(TD,M1),    %% utility.pl
    maximum(TD,M2),    %% utility.pl
(
    M1 = M2 -> Durations = M1 ;
               Durations = M1 - M2 %% NB =, not is
) .


out_comma(_) :- %% Printing comma if smartdepflag is set %% TE-120406
    value(smartdepflag,true) ->
    output(',');true.

create_smartdep_entry(_,_,_,_) :- \+  value(smartdepflag,true),!.

create_smartdep_entry(Intstation1,TimesDurations, DirPlace, Create_smartdep_entry):- %% TA-110405 %%RS-120402 -120727
    value(smartdepflag,true),
    %firstmem(TimesDurations,td(Time,RID,Duration,_Intstation2)),
     firstmem(TimesDurations,td(Time,RID,Duration, _Instation)),

    ridtobusnr(RID,BusNo),
    localstatno(RID,Intstation1,Fullstatname1,Localstatno1),

        Create_smartdep_entry = smartdepentry(Fullstatname1,Localstatno1,BusNo,Time,Duration,DirPlace),
%%      Create_smartdep_entry = smartdepentry(Fullstatname1,Localstatno1,BusNo,Time,Duration,_Instation2),

    !.

create_smartdep_entry2(_,_,_,_,_,_) :-
    \+ value(smartdepflag,true),
    !.


create_smartdep_entry2(Station,Time,Duration,Rid, DirPlace, Smartdep_entry) :-
    value(smartdepflag,true),
    !,
    ridtobusnr(Rid,BusNo),
    localstatno(Rid,Station,Fullstatname1,Localstatno1),
    Smartdep_entry = smartdepentry(Fullstatname1,Localstatno1,BusNo,Time,Duration,DirPlace).


create_smartdep_entry3(_Station,_Time,_Duration,_BusNo, _DirPlace, _Smartdep_entry) :-
    \+value(smartdepflag,true),
    !.

create_smartdep_entry3(Station,Time,Duration,BusNo, DirPlace, Smartdep_entry) :-
    value(smartdepflag,true),
    !,
    fullstatname(Localstatno1,Station,Fullstatname), %% TA-110530

   %% veh_mod(TTP),
   %% TTP:hpl(Localstatno1,Station,_,Fullstatname),

    Smartdep_entry = smartdepentry(Fullstatname,Localstatno1,BusNo,Time,Duration,DirPlace).



localstatno(RID,Intstation,Fullstatname,Localstatno):-
    passeq(RID,STATNO,Intstation,_Seq,_DelArr,_DelDep), %% buslog.pl
    fullstatname(Localstatno,Intstation,Fullstatname),        %% TA-110530
    Localstatno = STATNO.

fullstatname(_Localstatno,hovedterminalen,'Sentrumsterminalen'):-!. %% TA-110530
%% detailed station name (M3) hard to find

fullstatname(_Localstatno,Neighbourhood,Neighbourhood):- %% RS-120803 AD-HOC!
%% detailed station name (M3) hard to find
        neighbourhood(Neighbourhood).

fullstatname(Localstatno,Station,Fullstatname) :- %% official station name
    veh_mod(TTP),                     %% not Sentrumsterminalen but Munkegata - M3
    TTP:hpl(Localstatno,Station,_,Fullstatname).

print_smartdeps( SmartDeps, Opts, Transfer ) :-
    print_smart_init([Transfer|Opts]),
    print_smartdep_entries(SmartDeps),
    print_smart_trail.



print_smartdep_entry(_):-

     \+ value(smartdepflag,true),
     !.

print_smartdep_entry(smartdepentry(Fullstatname1,Localstatno1,BusNo,Time,Duration,DirPlace)):-
     value(smartdepflag,true),
     !,

%%     Frame={'"departures"' : [ ItemList]}, %% Printed beforehand

    ItemList = {'"busstopname"':FFullstatname1,
                '"busstopnumber"':Localstatno1,
                '"busnumber"':BusNo,
                '"time"':Time,
                '"duration"':Duration,
                '"destination"':FDestination},

   fullstatname(_Localstatno,DirPlace,Destination), %% TA-110530

            %% bwstat2(DirPlace,Destination),  %% detailed station name (M3) hard to find

   fnuttify2(Fullstatname1,FFullstatname1),
   fnuttify2(Destination,FDestination),

   !,
   out(ItemList).


%% MW-120906
print_smartdep_entries([]).

 print_smartdep_entries([Smartdep_entry|Smartdep_entries]):-
         print_smartdep_entry(Smartdep_entry),
          ( Smartdep_entries \== [] -> out_comma(_) ; true ), %%Comma between list elements %%TE-120406
         print_smartdep_entries(Smartdep_entries).
        



outdepfirst(Deps,DirPlace,Time9,
                                (  bwrbusbc(Bus,BusN), %% bcpbc(Bus),bwr(BusN),

                                 bcp(Verb), % passes/arrives/departs
                                 bwr(Station),bcp(attime),bwt(Time9),OutArr,period),dir(Dep1,FINAL),_SmartDeps) :-
    value(smsflag,true),
    !,
    member(depnode(_Time0,Time9,_DelArr1,_DelDep1,BegTime,Rid,BusN,_,Station),Deps),
         ridtobusname(Rid,BusN),
    vehicletype(BusN,Bus),
    first_dep(Deps,Dep1),
    outandarrives6(Time9,Station,DirPlace,Rid,BegTime,OutArr,Verb,FINAL,_Arrival).

outdepfirst(Deps,DirPlace,Time9,
                                (bcpbc(thefirst),bcp(Bus),comma,
             bwrbus(number,BusN),
                                 bcp(Verb), % passes/arrives/departs
                                 bwr(Station),bcp(attime),bwt(Time9),OutArr,period),
                                dir(Dep1,FINAL),Smartdep_entry) :-

    first_dep(Deps,Dep1),

         member(depnode(_Time0,Time9,_DelArr1,_DelDep1,BegTime,Rid,BusN,_,Station),Deps),
         ridtobusname(Rid,BusN),
    vehicletype(BusN,Bus),

         (\+  value(dialog, 1),!
      ;
    getcurrent(Cid),

     addref(Cid, Rid, lastrid),
     addref(Cid, Time9, firstdeparturetime)
    ),
         outandarrives6(Time9,Station,DirPlace,Rid,BegTime,OutArr,Verb,FINAL,Arrival),
         difftime(Arrival,Time9,Duration), %% MW-121008
         create_smartdep_entry2(Station,Time9,Duration,Rid, DirPlace ,  Smartdep_entry). %% TA-110505.
         
         
%%         create_and_print_smartdep_entry here!!!. %% RS-120816 TODO!!

%% RS-131233 Verify this!!!!!!!!!!!!!!!!!!!!!!!!!!!!
outdeplast(Deps,DirPlace,Time9,
                          (output('...'),
            bwrbusbc(Bus,BusN),
                                bcp(Verb), % passes/arrives/departs
                                bwr(Station),bcp(attime),bwt(Time9),OutArr,period),_SmartDeps) :-
    value(smsflag,true),
    !,

         lastmem(Deps,Dep1), Dep1=depnode(_,Time9,_DelArr1,_DelDep1,BegTime,Rid,BusN,_,Station),
         ridtobusname(Rid,BusN),
    vehicletype(BusN,Bus),

         (\+  value(dialog, 1),!
      ;
    getcurrent(Cid),

     addref(Cid, Rid, lastrid),
     addref(Cid, Time9, lastarrival)
    ),

         outandarrives6(Time9,Station,DirPlace,Rid,BegTime,OutArr,Verb,_,_).

outdeplast(Deps,DirPlace,Time9,
                          (bcpbc(thelast),bcp(Bus),comma,bwrbus(number,BusN),
                                bcp(Verb), % passes/arrives/departs
                                bwr(Station),bcp(attime),bwt(Time9),OutArr,period),Smartdep_entry) :-

         lastmem(Deps,depnode(_,Time9,_DelArr1,_DelDep1,BegTime,Rid,BusN,_,Station)),
         ridtobusname(Rid,BusN),
    vehicletype(BusN,Bus),

         (\+  value(dialog, 1),!
      ;
    getcurrent(Cid),

     addref(Cid, Rid, lastrid),
     addref(Cid, Time9, lastarrival)
    ),

         outandarrives6(Time9,Station,DirPlace,Rid,BegTime,OutArr,Verb,_,Arrival),
         difftime(Arrival,Time9,Duration), %% MW-121008
         create_smartdep_entry2(Station,Time9,Duration,Rid, DirPlace , Smartdep_entry).


%% As part of triple FNL departure

%% Print next time only if later than TimeF

outdepnext(Deps,Opts,TimeF,TimeL,DirPlace,Out, MAP,Smartdep_entry) :- %% - Day
         timenow(Tid), %% NB  called again
    Dep1=depnode(_,Time9,DelArr1,_DelDep1,BegTime,Rid,BusN,_,Station),
    nextdep(Tid, Dep1,Deps),
         ridtobusname(Rid,BusN),
    ( \+  value(dialog, 1), !
      ;
      getcurrent(Cid),
      addref(Cid, Rid, lastrid)
    ),
         outdepnext2(Opts,TimeF,TimeL,Time9,DelArr1,BegTime,Rid,BusN, Station,DirPlace,Out, MAP),
    ( Out = []  ->  Smartdep_entry = []   ;
         difftime(DelArr1,Time9,Duration), %% MW-121008
         create_smartdep_entry2(Station,Time9,Duration,Rid, DirPlace , Smartdep_entry)
    ).


outdepnext(_,_,_,_,_,[],_NAP,[]).  %%


outdepnext2(_,TimeSame1,_,TimeSame2,_,_,_,_,_,_,[],nil):-
    TimeSame1==TimeSame2,
    !.

outdepnext2(_,_,TimeSame1,TimeSame2,_,_,_,_,_,_,[],nil):-
    TimeSame1==TimeSame2,
    !.

outdepnext2(Opts,_,_,Time,_Delay,BegTime,Rid,BusN,Station,DirPlace,
                                (bcpbc(Thenext),bcp(Bus),
                                 comma,
             bwrbus(number,BusN),
             bcp(Verb), % passes/arrives/departs
                                 bwr(Station),bcp(attime),bwt(Time),OutArr,period),MAP) :-

    nextornot(Opts,Thenext), %% if time option, not thenext

    vehicletype(BusN,Bus),
         outandarrives6(Time,Station,DirPlace,Rid,BegTime,OutArr,Verb,MAP,_).


nextornot(Opts,first):- testmember(time,Opts),!. %% Hairy
nextornot(_Opts,thenext).

outandarrives2(nil,[]):-!.
outandarrives2(from(Place),(bcp(coming),bcp(from),bwr(Place))).
outandarrives2(to(Place),  (bcp(indirection),bwr(Place))).
outandarrives2(DirPlace,    (bcp(and),space,bwr(DirPlace))).

outandarrivesset(Station,_Station,[Station],_,space0):-!.   % Same station, som error

outandarrivesset(_Fromstation,_Toplace,[Station],A,B):-  % Single station
    !,
    outandarrives3(Station,A,B).

outandarrivesset(_Fromstation,Toplace,_,A,B):- %%  NB Cheat, only neighbourhood
    !,
    outandarrives3(Toplace,A,B).



outandarrives3(nil,_,[]).
outandarrives3(from(Place),_,(bcp(coming),bcp(from),bwr(Place))).
outandarrives3(to(Place),_,  (bcp(indirection),bwr(Place))).

outandarrives3(DirPlace,duration(Durations),
    (nl,bcp(and),bcp(arrivesat),bwr(DirPlace), %% space0,
    comma,       %% ankommer Strandvegen, 22 -26...
    Minuteslater)):-

    minuteslater(Durations,Minuteslater).

outandarrives3(DirPlace,arrival(Arrival),
    (nl,bcp(and),bcp(arrivesat),
          bwr(DirPlace),bcp(attime),
          bwt(Arrival))).


minuteslater(0 , bcp(thereafter)):-!. %%  %% avoid 0 minutes afterwards
                                                   %%  if due to sloppy passtimes


minuteslater(Durations , (bw1(Durations),bcp(minutes),bcp(later))):- %% bw1 doesnt
%%%    Durations > 0, // may be 11-12                %% add refs
    !.


%% hovedterminalen   esp.

%% Problem: When destination = Direction,
%  we dont't really know if it starts or stops at the station,
%  this is a "feature" of the keepto/keepfrom predicate.

%% MW-120917 %% Added Arrival for smartdep_entry


outandarrives6(_,_Station1,nil,_,_,_,passes,_FINAL,_Arrival):-!. %% destination nil

outandarrives6(_,Station1,Station2,_,_,[],passes,_FINAL,_Arrival):- %% SAME station
(
    (Station1==hovedterminalen , corr(Station2,hovedterminalen));
    (Station2==hovedterminalen , corr(Station1,hovedterminalen))
),
 !. %% Genialt hvis  ..ankommer m1 0738 og går fra m1 0745

outandarrives6(_,Station,from(Place),_,_,[],passes,_FINAL,_Arrival):- %% arrivesat) :-
    Station == Place,
    !.

outandarrives6(_,Station,to(Place),_,_,[],passes,_FINAL,_Arrival):- %% leaves) :-
    Station == Place,
    !.

outandarrives6(Time,Station,DirPlace,Rid,BegTime,Ans,passes,FINAL,Arrival) :-
    Station \== DirPlace,
    !,
    outandarrives4(Time,DirPlace,Rid,BegTime,Ans,FINAL,Arrival).

outandarrives6(Time,_Station,DirPlace,Rid,BegTime,Ans,passes,FINAL,Arrival) :-
    outandarrives4(Time,DirPlace,Rid,BegTime,Ans,FINAL,Arrival). %%  <--- Same As Above !!!


outandarrives4(DepTime,DirPlace,Rid,BegTime, Out, ToStation,Arrival) :-
         veh_mod(TTP), %% ad hoc
    passMOD(TTP,Rid,DirPlace,_STATNO,ToStation,DelArr2,_),
    DelArr2 \== 999, DelArr2  >     0,  %% no false arrival
         addtotime(BegTime,DelArr2,Arrival),
    Arrival >= DepTime, %%%%%%%%% <---- Avoid Tour hit if Retour

(   DepTime = Arrival  ->
     Out=  (nl,bcp(and),bcp(arrivesat), bwr(ToStation),bcp(thereafter))
   ;
     Out = (nl,bcp(and),bcp(arrivesat), bwr(ToStation),bcp(attime), bwt(Arrival))).



outandarrivesonly(FromPlace,FromTime,DirPlace,Rid,BegTime,DelDep1,ArrivalTime,Out, ToStation):-
         veh_mod(TTP), %% ad hoc
         passMOD(TTP,Rid,DirPlace,_STATNO, ToStation,DelArr2,DelDep2),
    adjust999(DelArr2,DelDep2,DelArr),

    FromPlace \== ToStation,
                                       %% avoid arrival =999 appears as after departure
    DelArr >=  DelDep1,  %% should have seq?   %%  buss 63  fra singsaker til TS  før 15.25
         addtotime(BegTime,DelArr,ArrivalTime),

    !,

    set(firstdeparturetime,FromTime),
    set(lastarrivaltime,ArrivalTime),  %% OBSOLETE

         (\+  value(dialog, 1),!
      ;
    getcurrent(Cid),
      addref(Cid,FromTime,firstdeparturetime),
      addref(Cid,ArrivalTime,lastarrivaltime)
    ),

(
  (ArrivalTime = FromTime) ->

   Out = (nl,bcp(and),bcp(arrivesat), bwr(ToStation),bcp(thereafter))
  ;
   Out  = (nl,bcp(and),bcp(arrivesat), bwr(ToStation),bcp(attime), bwt(ArrivalTime))
).

outandarrivesonly(_FromPlace,_FromTime,_DirPlace,_Rid,_BegTime,_DelDep,_ARRIVALTIME,space0,_).

% adhust999  delarr deldep = deltime
adjust999(X,Y,Z) :- X=999,!,Z=Y.
adjust999(X,Y,Z) :- Y=999,!,Z=X.
adjust999(X,_,X).

addrefdialog(SLOT,VALUE):-
         (\+  value(dialog, 1),!
      ;
    getcurrent(Cid),
      addref(Cid,VALUE,SLOT)
    ).



outfromtocorr0(Opts,Dep,OutDep,Mid01,OutAns,MAP,SmartDeps):-
  %% (print_smart_init([transfer|Opts]),                            %% TA-110406
  ( outfromtocorr1(Opts,Dep,OutDep,Mid01,OutAns,MAP,SmartDeps)),
 %%  print_smart_trail),                           %% TA-110406
   !  %% must not backtrack into busans
  ;
   OutAns= (bcpbc(nolonger),period). %% some kind of fail //
                                     %% maybe irrelevant because connections failed
                                     %% -> negans

%%% OUTFROMTOCORR1


outfromtocorr1(_Opts,Dep,_OutDep,Mid01,OutAns,MAP,_SmartDeps):-
    dummy_transfer(Mid01),
    !,
    traceprog(4,case30),
    outfromtodirect(Dep,OutAns,MAP),
    !. %% unnec



outfromtocorr1(_Opts,Dep,OutDep,Mid01,(OutCorr,earliesttimes), corr(Dep,Mid01),_SmartDeps):-
    cutloop(Mid01,TF),
    TF=true,
    !,
    traceprog(4,case31),
    outfromto(TF,Dep,OutDep),
    outcorr(TF,Mid01,OutCorr).


%% NOT CUTLOOP Station
outfromtocorr1(_Opts,Dep,OutDep1,Mid01,(OutDep2,earliesttimes),corr(Dep,Mid01),SmartDeps):-  %% roles changed slightly for OutDep1,2

    Dep   =  depans(StartBusN,Rid1,StartTime,StartStation,EndBusN,_Rid2,EndTime,EndStation),
    Mid01 =  midans(StartBusN,OffTime,OffStation,EndBusN,OnTime,OnStation),
    !,
    firstdepnotice(Dep),
    traceprog(4,case32),

    OutDep1 = ( bwrbusbc(Bust1,StartBusN),
           bcp(goesfrom),
                          bwr(StartStation),bcp(attime),bwt(StartTime),
                          bcp(to), bwr(OffStation), bcp(attime),bwt(OffTime),nl),

    OutDep2 = ( bcp(and), bwrbus(Bust2,EndBusN),
           bcp(goesfrom),
                          bwr(OnStation),bcp(attime),bwt(OnTime),
                          bcp(to), bwr(EndStation),

       ArrNext, %% bcp(attime),bwt(EndTime),

       period),

    shorttrip(OnTime,EndTime,ArrNext),


    vehicletype(StartBusN,Bust1),
    vehicletype(EndBusN,Bust2),

   ( firstdeparturetime := StartTime ), %% AD HOC
   ( lastarrivaltime := EndTime ),

   difftime( OffTime,StartTime,Duration1),


   create_smartdep_entry2(StartStation,StartTime,Duration1,Rid1, OffStation,Smartdep_entry1),
                                            %% TA-110406
   %% print_smartdep_entry(Smartdep_entry1),

   %% out_comma(_), %% Comma between list elements %%TE-120406

   difftime( EndTime,OnTime,Duration2),

   create_smartdep_entry3(OnStation,OnTime,Duration2,EndBusN, EndStation,Smartdep_entry2),

  %% print_smartdep_entry(Smartdep_entry2),
   SmartDeps = [Smartdep_entry1,Smartdep_entry2], %% MW-121008

         (\+  value(dialog, 1),!
      ;
    getcurrent(Cid),
      addref(Cid,StartTime,firstdeparturetime),
      addref(Cid,EndTime,lastarrivaltime)
    ).

dummy_transfer([]).
dummy_transfer(midans(_,0,nil,_,9999,nil)).

outfromtodirect(Dep,
                         (bwrbusbc(Bust1,StartBusN),
           bcp(passes),
                          bwr(StartStation),bcp(attime),bwt(StartTime),
                          nl,bcp(and),
                          bwr(EndStation),bcp(attime),bwt(EndTime),period ,earliesttimes), corr(Dep,nil)):-        % [Dep]):-
                Dep=depans(StartBusN,_Rid1,StartTime,StartStation,EndBusN,_Rid2,EndTime,EndStation),
           firstdepnotice(Dep),

           StartBusN=EndBusN,
           !,
           vehicletype(StartBusN,Bust1).




shorttrip(OnTime,EndTime,bcp(thereafter)) :- OnTime = EndTime,!.
shorttrip(_OnTime,EndTime,(bcp(attime),bwt(EndTime)) ) .


/* %% TA-110520
%%%%%%%%%%% SUSPECT   Not applicable %%%%%
outfromtocorr1(_Opts,Dep,OutDep,Mid01, ((OutCorr,earliesttimes)), corr(Dep,Mid01)):-
    TF=false, %% cutloop
    traceprog(4,case33),
    outfromto(TF,Dep,OutDep),
    outcorr(TF,Mid01,OutCorr).
*/



cutloop(midans(StrBusN,OffTime,OffStation,EndBusN,OnTime,OnStation),true):-
       OffStation = OnStation,
       StrBusN=EndBusN,
       cutloop_station(StrBusN,OffStation),
       OffTime =< OnTime,
       %  addtotime(OffTime,10,Tired), Tired > Ontime,
       !.

cutloop(_,false).


% Same Bus No, Identical bus

outfromto(true,depans(StartBusN,_Rid1,StartTime,StartStation,EndBusN,_Rid2,EndTime,EndStation),
                         (bwrbusbc(Bust1,StartBusN), %%  bc
           bcp(passes),
                          bwr(StartStation),bcp(attime),bwt(StartTime),
                          nl,bcp(and),
                          bwr(EndStation),bcp(attime),bwt(EndTime),period)
             ):-

           StartBusN=EndBusN,
           !,
           vehicletype(StartBusN,Bust1).


% Same Bus No, Different Bus

outfromto(false,depans(StartBusN,_Rid1,StartTime,StartStation,EndBusN,_Rid2,EndTime,EndStation),
                         (bwrbus(Bust1,StartBusN),
           bcp(passes),
                          bwr(StartStation),bcp(attime),bwt(StartTime),
                          nl,bcp(and),
           bwrbus(Bust2,EndBusN),   %% subtle, repeat bus no, because not identical bus
           bcp(passes),
                          bwr(EndStation),bcp(attime),bwt(EndTime),period)

            ):-
           StartBusN=EndBusN,
           !,
           vehicletype(StartBusN,Bust1),
           vehicletype(EndBusN,Bust2).


% Change bus

outfromto(_,depans(StartBusN,_Rid1,StartTime,StartStation,EndBusN,_Rid2,EndTime,EndStation),
                         (bwr(Bust1,StartBusN),
           bcp(passes),
                          bwr(StartStation),bcp(attime),bwt(StartTime),
                          nl,bcp(and),
                          bwr(Bust2,EndBusN),
           bcp(passes),
                          bwr(EndStation),bcp(attime),bwt(EndTime),period)

):-

           vehicletype(StartBusN,Bust1),
           vehicletype(EndBusN,Bust2).

%% Same bus, STAY ON !

outcorr(true,_,true):-!. % Stay on

%% Same bus, STAY ON ? (dont know, vague on purpose)

outcorr(false,midans(StrBusN,OffTime,OffStation,EndBusN,OnTime,OnStation),
                  (bcp(thebus),bcp(goes),bcp(via),bwr(OffStation),nl)

        ):-
        OffStation = OnStation,
        StrBusN=EndBusN,
        OnTime = OffTime,
        !.

%% Different bus, change?

%% Shorter text (SMS)

outcorr(false,midans(_StrBusN,OffTime,OffStation,_EndBusN,OnTime,OnStation),

          (bcpbc(changeorder),bcp(at),
        bwr(OffStation), bcp(between),bwt(OffTime),bcp(and),
        bwt(OnTime),
        period)

):-

    value(smsflag,true),
    OffStation == OnStation,
    !.


outcorr(false,midans(_StrBusN,OffTime,OffStation,_EndBusN,OnTime,OnStation),

          (bcp(changeorder),bcp(from),
        bwr(OffStation), bcp(attime),bwt(OffTime),bcp(to),
        bwr(OnStation), bcp(attime),bwt(OnTime),
        period)

):-

    value(smsflag,true),
    !.



outcorr(false,midans(StrBusN,OffTime,OffStation,EndBusN,OnTime,OnStation),

          (bcp(you),bcp(can),bcp(change),
       bcp(from),  bcp(_bust1),
       bwr(StrBusN),bcp(atstation),bwr(OffStation),bcp(attime),bwt(OffTime),
       nl,
       bcp(to), bcp(_bust2),
       bwr(EndBusN),bcp(atstation),bwr(OnStation),bcp(attime),bwt(OnTime),
       period)


):-

    \+ value(smsflag,true),
    !,

    vehicletype(StrBusN,_bust1),
    vehicletype(EndBusN,_bust2).





time_options(List):-
    member(X,List),
    time_option(X),
    !.

time_option(time).  %% Means that a time has been set, avoid default after now
time_option(last(_)).
   time_option(first(_)).
   time_option(next(_)).
time_option(prev(_)).
time_option(nth(_)).
   time_option(first).
time_option(lastcorr).
time_option(nextaftertime(_)).


sentenceend( writeout:period ).
sentenceend( writeout:question ).
sentenceend( writeout:endline ). %% no written '.'

reply(_X_) :-!. %% Just marker (Debugging)


db_reply(Subject,Attribute,Value) :- %% TA-110111
    testmember(Attribute,[webaddress,mailaddress]), %% TA-110120
    !,
    writename(Subject),bcp(has),bcp(Attribute),
    nl,write('  '),
    writesimplelist(Value). %% not Http


db_reply(Subject,Attribute,Value) :-
    writename(Subject),bcp(has),bcp(Attribute),write('   '),
    writename(Value).



% This is special because no nl if empty message.

% Print message

% Only "vital"  messages if SMS

% NB It is important that something is printed
%
%utility predicate for doubt between Norsk and English alternatives
%doubt(A,B) :- doubt(A,B).  %% RS-131231 utility.pl

print_paraphrase_message(nearest_station(_sTARTSTOP,A,B)):- % e.g. Holdeplassen nærmest A er B
    !,
    printmessageunconditionally(nearest_station(_sTARTSTOP,A,B)).


print_paraphrase_message(nearest_station(_sTARTSTOP,A,B)):- % e.g. Holdeplassen nærmest A er B
    !,
    printmessageunconditionally(nearest_station(_sTARTSTOP,A,B)).

print_paraphrase_message(X):- % e.g. NOT 27. Aug. 2005 er en  lørdag.
   printmessage(X).


printmessageunconditionally(X):-
   printmess1(X),
   !.

printmessageunconditionally(X):-
   pmess(X),
   nl,
   !.

printmessageunconditionally(X):-
    bcpbc(X),  %% Catchall in case of forgetfulness
    nl.


%% PRINTMESSAGE  --> for definition, use printmess1


printmessage( notification(Date,Clock) ):-
    write('bing '),bwr(Date),bwr(Clock),nl. %% AD HOC

printmessage(assumetomorrow) :-
    pmess(assumetomorrow).


printmessage(X):-
   printmess(X), %% First set of messages
   !.

printmessage(M):-
    pmess(M),    %% Second  set of messages
    nl,          %% with new line %% <---
    !.

printmessage(X):-
    bcpbc(X),  %% Catchall in case of forgetfulness
    nl.

%-

printmess(Message):-
   value(smsflag,true),
   empty_sms_message(Message),
   !,
   emptymessage.


printmess(Message):-
   printmess1(Message).

%% empty_sms_message(sameplace(_,_)).
empty_sms_message(howtuchelp):-value(dialog,1). %% <----

empty_sms_message(date_isa_day(_,_)). %% TA-110411

empty_sms_message(nearest_station(_STARTSTOP,_,_)).

%%    value(dialog,1). %%  avoid ('+') %% TA-110411
%% omit if dialog since this information is already printed
%% omit if proper sms message (too long)

empty_sms_message(assumetomorrow).      %% TA-100506
empty_sms_message(otherperiod(_Date)).
empty_sms_message(date_day_route(_,_)). %% Too long for some connections %%!
empty_sms_message(toomanyplaces).

%% Print 1 message

printmess1(smsprice(NN)) :-
    write('En SMS til bussoraklet koster kr '),write(NN),out(',-'),period. %% ad hoc


printmess1(date_isa_week(Date,WN)) :-
    writedate(Date), bcp(is), bcp(in), bcp(week), bwr(WN),period.


printmess1(time(Then,T1556)) :- %%  then/now
    bcpbc(thetime),bcp(is),bcp(Then),bwr(T1556),period. %% TA-101104


printmess1(webstatistics) :-
    value(smsflag,true),
    !.

printmess1(webstatistics) :-
    nl,
    %listing(webstat).

    output('DATE            SMS  TOTAL'),
    nl,
    for( interapp:webstat( date(Year,Month,Day),SMS,TOT ),     %% RS-131230 See utility.pl for/2
       ( write(Year),write('-'),write(Month),write('-'),write(Day),out('      '),out(SMS),out('  '),out(TOT),nl ) ),
    nl.




printmess1( numberof(N,day) ) :-
     out(N), doubt(days,dager),period.             %% RS-131230 See utility.pl doubt/2


printmess1(route_period(_TT,_TT07,Date1,_Date2)):-
     writedate(Date1),nl.


printmess1(neverpasses(Nine,Lade1)):-
          vehicletype(Nine,Bus),
     bcpbc(Bus),bcp(Nine),bcp(neverpasses),bwr(Lade1),period.



printmess1(notification(Date,Time)):-
    !,

 ( (value(warningflag,true),value(smsflag,true)) ->

   (printdatetimetoalarmstring,
    bcpbc(youarenotified), bwt(Time), bcp(ondate), writedate(Date),
    nl)
   ;
   (nopay,printmess1(sorrycannot))).


printmess1(unknown_street(X-Y)):-
    !,
    bcpbc(unknown),bcp(streetaddress),colon,
    bwrstreet(X-Y),
    nl.


printmess1(unknown_street(X)):-
    !,
    bcpbc(unknown),bcp(street),colon,
    bwrstreet(X),
    nl.


printmess1(cannot_connect(X)):-
    !,
    bcpbc(cannotconnectto),
    bwrstreet(X),
    nl.

printmess1(earliesttimes):-
    !,
    nl,
    bcpbc(earliesttimes),
    nl.

printmess1(toolate):-
    !,
    bcpbc(toolate),
    nl.

%% too long text
printmess1(nearest_station(_STARTSTOP,X,_)) :-
    value(smsflag,true),
    obvious_station(X),
    !,
    emptymessage.


printmess1(nearest_station(_,Street,Station)) :-
    bcpbc(theneareststationto),bwrstreet(Street),
    bcp(is),space,
(Station = '' -> %% (in case empty station)
    doubt(unknown,ukjent);         %% utility.pl
    bwr(Station)),
    period,
    !.

printmess1(dateis(Year,Month,DayNr,Day)) :-
     writedate(date(Year,Month,DayNr)),
     bcp(isa), outday(Day),
         period.


printmess1( otherperiod(_Date) ) :-
    value( airbusflag, true ),
    !,
    airbus_module(FB),
    write_mess_off(FB).


printmess1(otherperiod(Date)) :-
    decide_period(Date,Period),    % from topreg.pl
    TT=tt,                          %% Default  Ad Hoc
    current_period(TT,CP,_,_),
    Period == CP,             %% Same period as today
    default_period(TT,_Sum_win,CP),  %% and it is standard
    !.

printmess1(otherperiod(Date)) :- %% If not, print message
    decide_period(Date,Period),
    !,
    write_mess_off(Period).

printmess1(winterishere):-
    default_message(tt,winter,[MessN,MessE]),
    doubt(MessN,MessE),
    nl.

printmess1(summerishere):-
    default_message(tt,summer,[MessN,MessE]),
    doubt(MessN,MessE),
    nl.


printmess1(yes):-
    doubt('Yes.','Ja.'),
    nl.

printmess1(no):-
    doubt('No.','Nei.'),
    nl.

printmess1(ICT):-
   getphrase0(ICT,Phrase),
   output(Phrase).




%-------------------------------

emptymessage:-!.

write_mess_off(NextPeriod):-
    language(norsk),
    period_message(NextPeriod,[_E,N]), %% topreg.pl
    !,
    write('For denne dato gjelder '),
    write(N),write('.'),nl.

write_mess_off(NextPeriod):-
    language(english),
    period_message(NextPeriod,[E,_N]), %% topreg.pl
    !,
    write('For this date, '), %%  "routes for" part of routename
    out(E),write(apply),write('.'),nl.

write_mess_off(   _      ):-! . %% assume message has been written already



%------------------------------------------

obvious_station(sentrum).

%% obvious_station(munkegata).           %%  Skal vi møtes på D.g.
%% obvious_station(dronningens_gate).    %%



%% Pmess   Print message macro %%%%%%%%%%%%%%%%%%%%%%%

%% Unconditional print

pmess(answer(P)):- P.

pmess(place_resolve(Hageby,List)):-
   bcpbc(theplace), bwr(Hageby), bcp(ismanyvalued),period,
   bcpbc(precize),nl,
   bcpbc(possalternatives),bwr2(List,station),period0.


pmess(nightbuson(_Day)):- %% saturday/sunday is confusing around christmas.
    todaysdate(date(_YYYY,MM,DD)),
    ((MM=12, DD >= 20)
    ;
    (MM=01, DD =< 3)),
    !,
    prent0(nightbusdeparturesshort),  % no day
    output(':').


pmess(nightbusondate(Date)):-
    prent0(nightbusdepartures),
    writedate(Date),
    output(':').


pmess(nightbuson(Day)):-
    prent0(nightbusdepartures),
    primeout(Day),
    output(':').


pmess(donotknow):- (bcpbc(i),bcp(donotknow)).

pmess(foreign(_)):- home_town(Trondheim),
        (bcpbc(i),bcp(have),bcp(only),bcp(routes),bcp(for),
                        bcp(buses),bcp(in),bwr(Trondheim),period0). %% no CR

pmess(foreign(Trysil)):- \+ home_town(_), %% TA-110223
        (bcpbc(i),bcp(have),bcp(none),bcp(routes),bcp(for),
                        bcp(buses),bcp(to),bwr(Trysil),period0).



pmess(onlybusesforhometown):- home_town(Trondheim),
        (bcpbc(i),bcp(have),bcp(only),bcp(routes),bcp(for),
                        bcp(buses),bcp(in),bwr(Trondheim),period0). %% no CR


pmess(start):-(bcpbc(hello)).

pmess(quit(error)):- (bcpbc(error_restart)).

pmess(quit(Message)):- (bcpbc(Message)).

pmess(quit):-(bcpbc(bye)).


pmess(howtuchelp):- home_town(Trondheim),
         doubt('I can answer questions about bus departures in',
              'Jeg kan svare på spørsmål om bussavganger i'),
                    bwr(Trondheim),period0.


pmess(irrelevant(colour(_Bus))) :-
    (bcpbc(thecolour),bcp(ofabus),bcp(is),bcp(irrelevant)).

pmess(irrelevant(speed(bus))) :-
    (bcpbc(thespeed),bcp(ofabus),bcp(is),bcp(irrelevant)).

pmess(irrelevant(weather)):-(bcpbc(theweather),bcp(is),bcp(irrelevant)).

pmess(is(Class,Object)):- (bcpbc(it),bcp(is),bcp(Class),bwr(Object)).


pmess(mustknowanother(place)):-(bcpbc(you),bcp(must),bcp(specify),bcp(anotherplace),
         bcp(in),bcp(such),bcp(questions)),dot. %.

%% mustknow

pmess(mustknow(thing)):-(bcpbc(you),bcp(must),bcp(specify),bcp(athing),
         bcp(in),bcp(such),bcp(questions)),dot.

pmess(mustknow(place)):-(bcpbc(you),bcp(must),bcp(specify),bcp(aplace),
         bcp(in),bcp(such),bcp(questions)),dot.

pmess(mustknow(time)):-(bcpbc(you),bcp(must),bcp(specify),bcp(atime),
         bcp(in),bcp(such),bcp(questions)),dot.

pmess(mustknow(tram)):- (bcpbc(you),bcp(must),bcp(specify),bcp(atram),
                         bcp(in),bcp(such),bcp(questions)),dot. %.

pmess(mustknow(bus)):- (bcpbc(you),bcp(must),bcp(specify),bcp(abus),
                        bcp(in),bcp(such),bcp(questions)),dot.

pmess(mustknow(route)):-(bcpbc(you),bcp(must),bcp(specify),bcp(aroute),
         bcp(in),bcp(such),bcp(questions)),dot.

pmess(mustknow(vehicle)):- (bcpbc(you),bcp(must),bcp(specify),bcp(avehicle),
                            bcp(in),bcp(such),bcp(questions)),dot. %.

pmess(mustknow(station)):- (bcpbc(you),bcp(must),bcp(specify),
                            bcp(astation),bcp(in),bcp(such),
                                           bcp(questions)),dot. %.

pmess(mustknow(date)):- (bcpbc(you),bcp(must),bcp(specify),
                            bcp(adate),bcp(in),bcp(such),
                                           bcp(questions)),dot. %.

pmess(mustknow(day)):-
     bcpbc(you),bcp(must),bcp(specify),
      bcp(aday),bcp(in),bcp(such),
           bcp(questions),dot. %.


pmess(unrecognized_street(BIV,KJV)):-    %%  actually a staff warning
    bcpbc(unknown),bcp(connection),bwr(BIV),comma,bwr(KJV),dot.


pmess(date_day_route(date(Y2000,Y5,Y29),Monday)):-
    bcpbc(the_routes_on),writedate(date(Y2000,Y5,Y29)),
    bcp(are_the_same_as),outdays(Monday),dot.

pmess(date_isa_day(date(Y2000,Y5,Y29),Monday)):-
    writedate(date(Y2000,Y5,Y29)),
    bcp(isa),bcp(Monday),dot.

pmess(noinfoaboutname(Helsestasjon)):-
     bcpbc(noinformation),
     bwr(Helsestasjon),period0.

pmess(noinfo_error_report):-
     bcpbc(noinformation),
     bcp(error),period,
     bcp(error_reports_sent),period0.





pmess(nodates):-
    (bcpbc(noinformation),bcp(specificdays)).

pmess(noinfoabout(Delays)):-
    (bcpbc(noinformation),bcp(Delays)),period0.

pmess(noroutesfor(Tram)):-
    (bcpbc(i),bcp(have),bcp(notany),bcp(routes),bcp(for),
          bcp(Tram),period0).

pmess(noroutesonday(X)):-
    (bcpbc(i),bcp(have),bcp(notany),bcp(routes),bcp(for),
                bwr(X), bcp(onthisday)).

pmess(noroutesto(Place)):-
    (bcpbc(i),bcp(have),bcp(notany),bcp(routes),bcp(for),
          bcp(buses),bcp(to),bwr(Place),period0).

pmess(not(Class,Object)):-
    (bcpbc(there),bcp(is),bcp(notany),bcp(Class),
                        bcp(called),bwr(Object),period0).

pmess(illegal(Class,Object)):-
    (bcpbc(this),bcp(Class),bcp(Object),bcp(is),bcp(illegal),period0).


pmess(notinperiod(Class,Object)):-
    (bcpbc(therearenodeparturesfor),bcp(Class),bcp(Object),
                bcp(inthisperiod),period0).


pmess(sameplace(Place1,Place2)):-
    (bwrbc(Place1),bcp(and),
     bwr(Place2),bcp(is),
     bcp(thesame),bcp(place),period0). %% no nl


pmess(sorryno(Map)) :-
    (bcpbc(sorryno),bcp(Map)).


pmess(strikeison):-
    bcpbc(strikeison),nl.

pmess(timeout):-
    bcpbc(timeout),nl.


pmess(underspecified_place(P)):-
    bcpbc(theplace), bwr(P), bcp(ismanyvalued),
    dot,nl,bcpbc(precize).



pmess(nobuses):- bcpbc(none),nl.

pmess(nearest_station(_STARTSTOP,Street,Station)):-
    bcpbc(theneareststationto),bwrstreet(Street),
    bcp(is),space,bwr(Station),period,
    !.






%% nightbus 400 deps cancelled

%% General Nightbus message ( following weekend is normal )     %% RS-130630 Only for summer routes!!! Update this in June 2014
%pmess(generalnightbusmessage):-
%    pen(['Nightbus goes every hour in the summer from O.Tryggvasons gt. at 0100,0200,0300 am night to Saturday and Sunday.',
%         'Nattbuss går hver time om sommeren fra O.Tryggvasons gt. kl 0100,0200 og 0300 natt til lørdag og søndag.']).

%% General Nightbus message ( following weekend is normal )
pmess(generalnightbusmessage):-
    pen(['Nightbus goes every 30 min from O.Tryggvasons gt. at 0100,0130,0200,0230,0300 am night to Saturday and Sunday. Nighttram every hour from 0115.',
         'Nattbuss går hver halvtime fra  O.Tryggvasons gt. kl 0100,0130,0200,0230 og 0300 natt til lørdag og søndag. Nattrikk hver time fra 0115.']). %0030,

%% 400 deps cancelled

%% Påske-nattbuss

pmess(generalnightbuseaster):- %% Sjekk hvert år ! %% TA-110426
    pen(['At easter, the nightbus only goes night to  Easter Sunday from O.Tryggvasons gt. at 0100,0200 and 0300  am.',
         'I påsken går nattbuss  bare natt til 1. påskedag fra O.Tryggvasons gt. kl 0100,0200 og 0300. ']).


/* %% TA-110426
pmess(generalnightbuseaster):-
    pen(['Nightbus goes night to  Easter Sunday from O.Tryggvasons gt. at  0100,0200 and 0300  am.',
         'Nattbuss går natt til 1. påskedag fra O.Tryggvasons gt. kl 0100,0200 og 0300. ']).
*/


%% Jule-nattbuss  %% Must be rechecked

pmess(generalnightbusxmas):-
    pen( ['There are No nightbus in Xmas/NewY except night to Dec. 24., 27. 30. and 31.',
          'Det er ingen nattbuss i julehelgen unntatt natt til 27.12, 30.12  og 31.12. ']).

pmess(nonightbusesthen):- %% dont propose Saturday/Sunday if these are disallowed
    pen( ['There are no nightbuses.',
          'Det er ingen nattbusser.']).





pmess(stationsat(_,Station,Places)):-
    bound(Station), Places == [],
    !,
    bcp(idonotknowanyplacesnear),bwr(Station).


pmess(stationsat(Place,Station,Places)):-   %% subsumed ????
    bound(Place), unbound(Station),Places == [],
    !,
    bcp(idonotknowanystationsnear),bwr(Place),period.


pmess(stationsat(Place,_,Stations)):-
    nonvar(Place),
    home_town(Place), %%  == trondheim,
    !,
    dec_bongo(station,Stations,Thestations),
    dec_bongo(be,Stations,Is),

    bcpbc(Thestations),bcp(at),bwr(Place),bcp(Is),bwr(Stations),period.



pmess(stationsat(_,Station,Places)):-
    bound(Station),
    !,
    bcpbc(station),bwr(Station),bcp(is),bcp(at),bwr(Places),period.

pmess(stationsat(Place,_,Stations)):-

    dec_bongo(station,Stations,Thestations),
    dec_bongo(be,Stations,Is),

    bcpbc(Thestations),bcp(at),bwr(Place),bcp(Is),bwr(Stations),period.




pmess(none):- nl.

%%%% --------------------


de_sinplu([],nil):-!.
de_sinplu([_],sin):-!.
de_sinplu([_,_|_],plu):-!.
de_sinplu(_,sin):-!.        %% atom

dec_bingo(nil,A,_,_,A).
dec_bingo(sin,_,A,_,A).
dec_bingo(plu,_,_,A,A).

dec_bongo(Station,List,Outword):-
   de_sinplu(List,SP),
   dec_lookup(Station,Nostation,TheStation,TheStations),
   dec_bingo(SP,Nostation,TheStation,TheStations,Outword).

dec_lookup(station,nostation,thestation,thestations).
dec_lookup(be,isnt,is,are).


%.......................................

%% NEW PREDICATE

doublyprinted(assumetomorrow). %% Ad Hoc <-- will be printed both in
doublyprinted(answer(db_reply(tuc,version,_))). %% maybe generalise



primeoutput(P) :-
    primeout(P),  %% Print cwc message with nl.
    nl.


primeout(C):- %% Print cwc message without nl.
   cwc(C,List),
   pen(List).


pen([A,B]):- %% write the /N alternative of a list
   languagenr(LN),
   nth(LN,[A,B],Phrase),
   %% space, %%
   write(Phrase).




prent0(C):- %% no space
   cwc(C,List),
   languagenr(LN),
   nth(LN,List,Phrase),
   write(Phrase).

pen0([A,B]):- %% write the /N alternative of a list
   languagenr(LN),
   nth(LN,[A,B],Phrase),
   write(Phrase),
   period.


nibcp(Day):-
    value(nightbusflag,true),!,
    pen(['night to ','natt til ']), %% night to ..day
    bcp(Day). %%  For nightbus, day is special (on holidays)

nibcp(Day):- bcp(on), bcp(Day).
             %%     for is more neutral %% NO %%
             %% in case the day is a alias day (KRHF)

%% Standard Nightbus Information Message

standnight(easterhol):- %% Standnight  påsken
    value(nightbusflag,true),
    pmess(generalnightbuseaster),nl.




/*   %% Stand night   Christmas
standnight(D):-
    value(nightbusflag,true),
    kindofday(D,workday),

(    value(language,norsk)->
(
    output('Nattbussen går ikke mellomjula,unntatt natt til tredje juledag.'),

    output('Ellers går nattbuss bare natt til lørdag og natt til søndag') %% <160 nattbuss[en]
);(

    output('There are no nightbus during Christmas holidays except night to Dec. 27'),
    output('Otherwise, only night to Saturdays and night to Sundays')
)).

*/



standnight(D):-
    value(nightbusflag,true),
    kindofday(D,workday),

(    value(language,norsk)->

(
                                                        %% unntatt i påskehelgen'
    output('Nattbussen går bare natt til lørdag og søndag.') %% <160 nattbuss[en]
);(                                               % natt til %% <160
                                                              %%  except Easter holiday
    output('The Nightbus only goes night to Saturdays and Sundays.')
)).


standnight(_).

ondate(_Date):- %% TA-110301
    bcp(on),
    doubt('this','denne'),
    doubt('date','datoen').





ondays(Day):-
    bcp(on),
    dayplural(Day,Days),
    bcp(Days).



outday(X):- bcp(X).
outdays(may17):- bcp(may17). %% TA-110518 Ad Hoc special
outdays(X):- dayplural(X,Y),!,bcp(Y).
outdays(X):- bcp(X). %% easterhol


theplural(Dom,X):-
     genplural(Dom,DD),
     languagenr(Nth),
     nth(Nth,DD,X),
     !.
theplural(Dom,Dom).  %% default (ugly)


genplural(bus,        ['The buses',       'Bussene']).
genplural(nightbus,   ['The nightbuses',  'Nattbussene']).
genplural(route,      ['The routes',      'Rutene']).
genplural(station,    ['The stations',    'Holdeplassene']).
genplural(tram,       ['The trams',       'Trikkene']).
genplural(tramstation,['The tramstations','Trikkeholdpeplassene']).

dayplural(Monday,Mondays):- %% no backtrack
    dayplu(Monday,Mondays),
   !.
dayplural(X,X).

dayplu(monday,mondays).
dayplu(tuesday,tuesdays).
dayplu(wednesday,wednesdays).
dayplu(thursday,thursdays).
dayplu(friday,fridays).
dayplu(saturday,saturdays).
dayplu(sunday,sundays).



plural(N,departure,departure):- number(N), N is 1,!.
plural(_,departure,departures).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






% HELP Predicates in user for bustrans


special_day(holiday).
special_day(easterhol).
special_day(eastereve).
special_day(may17).


numberofnextbuses2(_,2):-    %% neste -> neste 2 SMS
     value(smsflag,true),!.
numberofnextbuses2(Default,Default).


%% obsol
numberofnextbuses(2):- value(smsflag,true),!.
numberofnextbuses(1).


sorttimes(T1,T2,T2,T1):-
    number(T1),
    number(T2),
    T1 > T2,
    !.
sorttimes(T1,T2,T1,T2).



%%  A free bus or person

busman(X,bus):-  busorfree(X).
busman(_X,P):- subclass0(P,agent).

corresporder(next,N,next(N)). % => keepafter
corresporder(first,N,first(N)).

corresporder(last,N,last(N)).  % => keepbefore
corresporder(previous,N,previous(N)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

evening_time0(X,Y):-  %% Inclusive
    \+ value(nightbusflag,true),
    number(X),
 (  X <  0100 -> Y is X + 1200;   %% halv ett -> 1230
    X =< 1200 -> Y is X + 1200; %% NO default here
                 Y is X).

evening_time0(X,Y):-
    value(nightbusflag,true),    %% Inclusive
    number(X),
 (  X <  0100 -> Y is X + 2400;  %% night at 1
    X =< 1200 -> Y is X + 1200; %% NO default here
                 Y is X).

evening_time(X,Y):-
    \+ value(nightbusflag,true), %% Exclusive (fail if evening)
    number(X),
 (  X <  0100 -> Y is X + 1200;   %% halv ett -> 1230
    X =< 1200 -> Y is X + 1200). %% NO default here

evening_time(X,Y):-
    value(nightbusflag,true),    %%  Exclusive (fail if evening)
    number(X),
 (  X <  0100 -> Y is X + 2400;  %% night at 1
    X =< 1200 -> Y is X + 1200). %% NO default here


evening_time24(NOW,X,Y):-
    \+ value(nightbusflag,true), %% Exclusive (fail if evening)
    number(X),
 (  NOW =< 1200, X > 0, X <60 -> Y is X + 1200; %% 0900: halv ett (0030) -> 1230
    X <  0100 -> Y is X + 2400;   %% halv ett -> 2430
    X =< 1200 -> Y is X + 1200). %% NO default here



notatnight(X,Y):-
    number(X),
    morning_break(T0430),
(   X  < 0100 -> Y is X + 2400;
    (X >= 100, X =< T0430) -> Y is X + 1200). %% NO default here



i_or_a_bus(tuc,_Self,Bus):- %%  du = tuc
     newfree(Bus),
     !.

i_or_a_bus(_I,Self,Bus):-
     (Self == agent
      ;                     %% man (interface << system << agent )
     testmember(Self,[person,self])), %% subclass0(Self,person)),
     !,                              %% hvordan er min mor
     newfree(Bus),
     !.

i_or_a_bus(B52,Bus,B52):-
    bound(B52),
    !,
     (subclass0(Bus,vehicle) %% not station
          ; Bus=route_plan
          ; Bus=number),
    !.

i_or_a_bus(Bus,_bus,Bus):-
    dmeq(vehicle,_bus),   %%  _bus ikke station  hpl på huseby.
    unbound(Bus),
    !.



%% Set Option in a List

setopts([X|Y],L,L1):-
    !,
    setopts(Y,L,L0),
    setopt(X,L0,L1).
setopts([],L,L).

setopt(Flag,L,L):-
    member(Flag,L),!.
setopt(Flag,L,[Flag|L]).


%% Take Union of options

mixopt(Opts1,Opts2,Opts):- %% union
    set_union(Opts1,Opts2,Opts).


anotherday(Day):-
    today(X),
    X \== Day,
    \+ value(samedayflag,true),
    !.

anotherday(_Day):-
    todaysdate(D0), %% datecalc
    value(actualdate,D1),
    \+ (D0=D1),
    !.




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% PARAPHRASE


paraphrase(L):-
        value(teleflag,true),
   !,
        teleparaph(L).

paraphrase(L):-
    paraphrase_changes(L).


paraphrase3(tele,Prog,_Frame) :- %% Search criteria, diff from Frame
    Prog= teleprocess(_,_,FL,_),
    doubt('Search for record where','Søker etter post hvor'),
    teleparaph1(FL),
    nl,nl.


paraphrase3(trans,Prog,Frame) :-
   paraphrase2(Prog,Frame).


paraphrase2(Prog,L):-         %%  Both Important messages and Paraphrase
   \+ value(directflag,true),
   write_relevant_messages(Prog),
   paraphrase_changes(L),
   nl.

paraphrase2(Prog,L):-      %% Both Important messages and Paraphrase
   value(directflag,true),
   !,
   value(directoutputfile,Newans),
   tell(Newans),
   output('*** Paraphrase ***'), %%%%%%%%%%% <-
   nl,
   write_relevant_messages(Prog),
   paraphrase_changes(L),
   nl,nl.

%%   told. %% Keep it open



paraphrase_tele(_Prog,_L):-
   \+ value(directflag,true),
   !,
   true.        %% Pro forma

paraphrase_tele(_Prog,_L):-    %% Pro forma, open dir outout file
   value(directflag,true),
   !,
   value(directoutputfile,Newans),
   tell(Newans),
   output('*** Paraphrase ***'), %%%%%%%%%%% <-
   nl.

%%   told. %% Keep it open





write_relevant_messages( Prog ):-
    for(
        roundmember( message(X), Prog ),
       ( relevant_message(X) -> printmessageunconditionally(X) ; true )
    ).

relevant_message(nearest_station(_,_,_)). %% this before .. You will go

relevant_message(illegaldate).
relevant_message(noinfoabout(_)).        %%  noinfoabout(nightbus) appears twice
relevant_message(howtuchelp).            %%
relevant_message(nonightbus).            %%  buster

relevant_message(foreign(_)).
relevant_message(noroutesto(_)).




paraphrase_changes([]):-!.

paraphrase_changes(X):-
    \+ roundmember(frames2:frame_setvalue(_,_),X),         %% utility.pl?
    !.


paraphrase_changes(L):-
    paraphrase_dual_topics(L).

paraphrase_dual_topics(L):-

   set_ops( X, (occ(X,L),     X=frame_setvalue(attributes::_,_)),Z1),

   set_ops( Y, (occ(Y,L),  ( (Y=frame_setvalue(_,_)),

                          \+ (Y=frame_setvalue(attributes::_,_)))),Z2),

   paraph_list(data,Z1),

   paraph_list(event,Z2).






paraph_list(data,L):-
    L=[]->true
;
    nl,
    doubt('Search for ','Søker etter '),
    paraph_list1(L),
    out('.').


paraph_list(event,L):-
    L=[]->true
;
    nl,
    doubt('You want to go','Du vil dra'),
    paraph_list1(L),
    out('.').


paraph_list1([]):-!.

paraph_list1([X]):-
    !,
    paraph1(X).

paraph_list1([X|L]):-
    paraph1(X),
    for( member(Y,L), paraph2(Y) ).



paraphrase_changes1(L):-
    nl,
    doubt('You want to go','Du vil dra'),
    paraphs(L),
    !,          %% Mysterious
    period,
    nl,nl.


paraphs((A,B)):-
    !,
    paraph1(A),
    paraphs(B).


paraphs(X):-paraph1(X).


paraph2(X) :- out(' '), paraph1(X).



paraph1([]):-!. % some error

paraph1(frame_setvalue(attributes::Givenname,Magne)) :-
    !,
    primeout(Givenname),
    outcap(Magne).






paraph1(frame_setvalue(_,'?')):-!. %% some error

paraph1(framevalue(_,_)):-!. %% some error

paraph1(frame_setvalue(where::departure,NTH)):-
    !,
    doubt(' from ',' fra'),bwr(NTH).

paraph1(frame_setvalue(where::arrival,NTH)):-
   !,
   doubt(' to',' til'),bwr(NTH).


paraph1(frame_setvalue(where::unknown,NTH)):-
   !,
   doubt(' to or from',' til eller fra'),bwr(NTH).  %%  (confusion)


% DEP AFTER

paraph1(frame_setvalue((when)::departure::after,T)):-
    morning_break(T0430),
    T==T0430, % most probably a soft constraint
    !,
    doubt(' with the first bus',' med første buss').


paraph1(frame_setvalue((when)::arrival::after,T)):-
    morning_break(T0430),
   T==T0430, % most probably a soft constraint
   !,
   doubt(' with the first bus',' med første buss').



paraph1(frame_setvalue((when)::departure::after,T)):-
   !,
   doubt(' after ',' etter klokken  '),bwt(T). %%  Talsmann   kl. 1840 to be spoken out.



% DEP BEFORE


paraph1(frame_setvalue((when)::departure::before,T)):-
   T==2500,
   !,  %% SOFT CONSTRAINT, Not Verified
   doubt(' with the last bus',' med siste buss').

paraph1(frame_setvalue((when)::departure::before,T)):-
   !,
   doubt(' before','  før klokken '),bwt(T).

% ARR  AFTER

paraph1(frame_setvalue((when)::arrival::after,T)):-
   !,
   doubt(' after ',' etter klokken '),bwt(T).  %% Talsmann

% ARR BEFORE

paraph1(frame_setvalue((when)::arrival::before,T)):-
   T==2500,
   !,  %% SOFT CONSTRAINT, Not Verified
   doubt(' with the last bus',' med siste buss.').


paraph1(frame_setvalue((when)::arrival::before,T)):-
   !,
   doubt(' before ',' før klokken '),bwt(T). %% Talsmann


%%%%%%%%

paraph1(frame_setvalue(day,T)):-
   !,
   doubt(' on',' på '),bcp(T).

paraph1(frame_setvalue((when)::day,T)):- % old, kept
   !,
   doubt(' on ',' på '),bcp(T).



paraph1(frame_setvalue(date,T)):- %% moved out
   !,
   doubt(' on ',' den '),writedate(T).


paraph1(frame_setvalue((when)::date,T)):-     %%  old, kept
   !,
   doubt(' on ',' den '),writedate(T).




paraph1(frame_setvalue(bus,Nine)):-
   !,
   doubt(' with bus',' med buss'),
   bcp(Nine).



paraph1(X):- % Default , missing
   !,
   out('<<< '),out(X),  out('>>>').


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  From telebuster/app/busanshp.pl

teleparaph([]) :-!.

teleparaph(F) :-
  %% seq pres
        set_ops(A=B, (frame_getvalue_rec(F, attributes::A, B, _),\+B=dontknow,\+B=doknow), L),
        \+ L = [],!,
        doubt('Search for','Søker etter'),
        (frame_getvalue_rec(F, return, R, _) -> writefields(R); doubt('record','post')),
        doubt(' where',' hvor'),
        teleparaph1(L),
   write('.'),
        nl,nl.

teleparaph(F) :-
  %% seq pres
        set_ops(A=B, (frame_getvalue_rec(F, attributes::A, B, _),\+B=dontknow,\+B=doknow), L),
        L = [],!,
                doubt('Search for','Søker etter'),
        (frame_getvalue_rec(F, return, R, _) -> writefields(R);doubt('record','post')),
        nl,nl.

teleparaph1([]).

teleparaph1([Field=Value|R]) :-
        bcp(the(Field)),
        doubt(' is ',' er '),
        bwrbc(Value),
        (R = [] -> true; bcp(and)),
        teleparaph1(R).





%%%% 4969 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Extra utility/utility.pl predicates information
%
%                    delete1/3,         deleteall/3,            doubt/2,
%                    firstmem/2,        fnuttify2/2,
%                    lastmem/2,         lastmems/3,
%                    maximum/2,         maxval/3,
%                    minimum/2,         minval/3,
%                    number_to_string/2,
%                    once1/1,      out/1,                  output/1,
%                    roundmember/2,     roundwrite/1,
%                    sequence_member/2, set/2,                  set_of/3,       (set_ops)/3,  set_filter/4,  set_union/3,  split/4,
%                    test/1,            testmember/2,           value/2,        (:=)/2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% where?            addref/1,          for/3,
