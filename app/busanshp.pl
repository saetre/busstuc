%% FILE busanshp.pl
%% SYSTEM BUSTUC/BUSTER
%% CREATED  JB-970220 
%% REVISED  EH-031120 TA-110503 RS-111025

%% RS-111121 Module App
%:- module( app, [
%        description/2,
%        gootrace/1,
%        google/1,         %% Just executable mark in busans    
%        outstreetconn/3, %(_STARTSTOP,_INTSTREET,_INTSTAT).
%        make_total_google/2 
%
%    ]).

:- module( busanshp, [
    bcw/2, busleave/9, busleaveset/6,  busman/2, bwr2bc/1, bwc/2, bwq/1, bw1/1, 
    bwrbus/2, bwrbusbc/2, bwrprices/1, bwstat2/2, bwtimes2/1, bwt2/1, 
    comma/0,    convifpossible/2,           corresporder/3,
    colon/0, comptimeflag/2,
    db_reply/3, description/2, dot/0, doublyprinted/1,
    earliesttimes/0, endline/0, evening_time0/2,        evening_time/2, evening_time24/3,
    find_last_departure/2,      findsetoftimes/2,       firstarrive/5,  firstRID/2,
    genplural/2,    getlastarrival/3,   gootrace/1,     google/1, %% Just executable mark in busans    

i_or_a_bus/3,
languagenr/1,
make_total_google/2,
mixopt/3,
nibcp/1,
nopay/0,
nopay1/0,
notatnight/2,
numberofnextbuses/1,
numberofnextbuses2/2,
ondate/1,
ondays/1,
outandarrives2/2,       %(_STARTSTOP,_INTSTREET,_INTSTAT)
outdeplist/6,
outdeplist00/6,
outdummy/2,
outfromtocorr/6,
outstreetconn/3,
paraph2/1,
paraphrase/1,
paraphrase_changes1/1,
paraphrase_tele/2,
paraphrase2/2,
paraphrase3/3,
paraphs/1,
pay/0,
pay1/0,
pen0/1,
period/0,
period0/0,
plural/3,
primeout/1,
primeoutput/1,
print_paraphrase_message/1,
punkt/0,
question/0,
relevant_message/1,
reply/1,         %% Just marker 
select/2,
selectmap/2,      %% was var (not assigned)
sentenceend/1,
setoffirst/3,
setopts/3,
smart_time_option/1,
smart_time_options/1,
sorttimes/4,
space/0,
space0/0,
special_day/1,
specname0/2,
standnight/1,
startmark/0,
stationlistorand/3,
theplural/2,
warningtime/2, %% super Ad Hoc %% TA-110202
writename/1,
writetimes/2

   ]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%:- use_module( main:'../declare.pl', [ myflags/2, set/2, ':='/2 ] ).
:- use_module( main:'../declare.pl' ).
%:- use_module( tuc:'../tuc/evaluate', [ ako/2, fact/1 ] ).

%:- use_module( tuc:'../tuc/semantic', [] ).
:- ensure_loaded( tuc:'../tuc/semantic' ).
:- use_module( '../declare.pl' ).

%%%%%%%%% COMMON VERSION BUSTER/BUSTUC  %%%%%%%%%%%%%%%

% Hjelpepredikat for ans-pragmaregler

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predikater som returnerer fraser.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% This is called from busans (answer generator)
%% There are two main entries:

%% outdeplist      Connection without transfer
%% outfromtocorr   Connection with transfer


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Version Based On the principle that the GoogleMapInfo is printed out



gootrace(B2) :-
    (myflags(mapflag,true) -> output(B2);true).



%
google(_B):-true. %% Just executable mark in busans    

outstreetconn(_STARTSTOP,_INTSTREET,_INTSTAT). %% Just marker in busans code
%



make_total_google(AnswerOut,  TOTAL):-

    extractbing(outstreetconn(start,Y9,_ND),AnswerOut, Y9,START),   %% street coord unk

    extractbing(outstreetconn(stop,STAD,_RSK),AnswerOut,STAD,STOP), %% street coord unk

    extractbing(google(U),AnswerOut,U,Bang), %% google is just an executable mark in busans

    googlemaptrace( Bang,  BusTrace),

    convert_int_street(START,EY9),
    convert_int_street(STOP,ESTAD),

    makelement('"streetaddress"','"start"',st(0,EY9),START1),
   
    makelement('"streetaddress"','"stop"',st(0,ESTAD),STOP1),

    append([START1],BusTrace,SBANG),
    append(SBANG,[STOP1],TOTAL),

    (myflags(mapflag,true) ->totaljsonprint(TOTAL,AnswerOut);true).
 
totaljsonprint(TOTAL,AnswerOut):-
    write('{'),nl,
    write('"route" :'),nl,
    prettyjsonprint(TOTAL),
    write(','),nl,
    write('"busstuc" :'),nl,
    write('"'),
    call(AnswerOut),
      write('"'),
    nl, 
    write('}'),nl.
  

googlemaptrace(nil,[]):-!. %% no route


googlemaptrace(W,Bingo):-
     maptrace(W,dual(List1,List2)),
     enterexit(List1,Bing1),
     enterexit(List2,Bing2),

     append(Bing1,Bing2,Bingo),
     !.




 
extractbing(U,V,X,W) :- sequence_member(U,V),!,W=X.
extractbing(_U,_V, nil,nil).


prettyjsonprint(Bingo):-
    write('['),nl,
    jsonbody(Bingo),
    write(']'),nl.


jsonbody([X]):- !,write(X),nl. %% last
jsonbody([X|Y]):- !,write(X),write(','),nl, %% last
    jsonbody(Y).



enterexit([],[]):-!. %% direct

enterexit([X|Rest],[B1|Brest]):-!,
    makelement('"busstop"','"enter"',X,B1),
    enterexit1(Rest,Brest).


 enterexit1([X],[B1]):-
    !,
    makelement('"busstop"','"exit"',X,B1).
  

enterexit1([X|Rest],[B1|Bingrest]):-
    !,
    makelement('"busstop"','"pass"',X,B1),
    enterexit1(Rest,Bingrest).
 
enterexit1([],[]):-!. %% abnormal


makelement(Type,Role,st(STATNO,Intname),{'"name"':NExtname2,'"type"':Type,'"role"':Role,'"xcoord"':NXcoord,'"ycoord"':NYcoord}):-
 
    xstatcoord(STATNO, Intname,Extname, Xcoord,Ycoord), 

   
    nullify(Extname,NExtname),
    nullify(Xcoord,NXcoord),
    nullify(Ycoord,NYcoord),
      
    !,
    fnuttify2(NExtname,NExtname2). %% utility

nullify(0,'"null"'):-!.
nullify(nil,null):-!. %% will be fnuttified
nullify(X,X):-!.




xstatcoord(STATNO, _Intname,Extname, Xcoord,Ycoord):-
    statcoord(STATNO,Extname, Xcoord,Ycoord),
    !.


xstatcoord(_STATNO, Intname,Extname, Xcoord,Ycoord):- %% NB Missing station in direction,
    veh_mod(CurrMod),                            %% try other side of street
    CurrMod:hpl(STATNO,Intname,_,Extname),        %% e.g Bjarne Næss veg
    statcoord(STATNO,_Extname, Xcoord,Ycoord),
    !.


xstatcoord(_0, Intname,Intname, 0,0). %% NB Missing station in direction, 
    


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

maptrace( dir(depnode(_,_,_,_,_,Rid,_,_,Gløshaugen_syd),Nardosenteret),dual(LIST,[])):-
    !,
    xstation_trace(Rid,Gløshaugen_syd,Nardosenteret,LIST).


maptrace( corr(depans(_,Rid1,_,Prinsen_kinosenter,_,_Rid2,_,Gløshaugen_nord), %% Special, dummy corr-> direct
               nil),dual(List1,[])):-
    !,
    xstation_trace(Rid1,Prinsen_kinosenter,Gløshaugen_nord,List1). %% TA-110323


maptrace( corr(depans(_,Rid1,_,Prinsen_kinosenter,_,Rid2,_,Gløshaugen_nord),
               midans(_,_,Studentersamfundet_1,_,_,Studentersamfundet_2)),dual(List1,List2)):-

    xstation_trace(Rid1,Prinsen_kinosenter,   Studentersamfundet_1, List1), %% TA-110323
    xstation_trace(Rid2,Studentersamfundet_2, Gløshaugen_nord,      List2). %%


xstation_trace(Rid,Gløshaugen_syd,Nardosenteret,LIST):-
    station_trace(Rid,Gløshaugen_syd,Nardosenteret,LIST),!.

xstation_trace(_Rid,_Gløshaugen_syd,_Nardosenteret,[]). %% error berg_studentby-> lerchendal_gård



selectmap(nil,[]):-!.      %% was var (not assigned)
selectmap([Dep|_],Dep):-!. %% only first of the printed versions
selectmap(X,X).  %% 


select(corr(A,B),corr(A,B)):-!.
select(dir(A,B),dir(A,B)):-!.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



outdeplist(Deps,Day,Opts,DirPlace,TF,MAP):-
    outdeplist00(Deps,Day,Opts,DirPlace,TF,MAP0),
    selectmap(MAP0,MAP).

 

%¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

outfromtocorr(Opts,Dep,OutDep,Mid01,OutAns,MAP):- %% TA-110511
   outfromtocorr0(Opts,Dep,OutDep,Mid01,OutAns,MAP0),
   selectmap(MAP0,MAP).


% % % %



%%%  OUTDEPLIST1
 

outdeplist00(Deps,Day,Opts,DirPlace,Out,MAP) :-   
    sort_deps_deptime(Deps,Deps1),
    outdeplist01(Deps1,Day,Opts,DirPlace,Out,MAP),
    ! %% must not backtrack into busans
    ;
    Out = (bcp(nolonger),period). %% some kind of fail
                                  %% maybe irrelevant because connections failed
                                  %% -> negans
 
outdeplist00(Deps,_Day,_Opts,_DirPlace,true,_) :-   %% Pre caution
    var(Deps),                                 
    write('*** No departures ***'),nl,
    !.



outdeplist01(Deps,Day,Opts,DirPlace,Out,MAP) :-   % neste =< N avganger etter tidspunkt
	 delete1(nextaftertime(N),Opts,Opts1),   %% nextaftertime(1) is default (unspecified), sms-dependent
	 !,
    progtrace(4,case11), 
    decide_actual_noid3(N,Opts,NActual), %% if nth(4), Nactual>=4 %% TA-101022
	 memberids0(NActual,Deps,NextDeps),  
    setopt(timeset,Opts1,Opts2),   
    outdeplist01(NextDeps,Day,Opts2,DirPlace,Out,MAP). 

outdeplist01(Deps,Day,Opts,DirPlace,Out,MAP) :-
    outdeplist02(Deps,Day,Opts,DirPlace,Out,MAP).


outdeplist02(Deps,Day,Opts,DirPlace,Out,MAP) :-
    print_smart_init([direct|Opts]), %% "departures" : [  %% Ad Hoc
    outdeplist1(Deps,Day,Opts,DirPlace,Out,MAP),
    print_smart_trail. %% ]}


print_smart_init(Opts) :- 
    myflags(smartdepflag,true),
    !,
    comptimeflag(Opts,Trans,TF),

    write('{"transfer":'),out(Trans),output(','),
    write('"timeset":'),out(TF),output(','),

    output('"departures" : [').

print_smart_init(_Opts).

  
comptimeflag(Opts,Trans,Timeset):-
 
    bollepling(member(transfer,Opts),Trans),
    bollepling(smart_time_options(Opts),Timeset).
    
comptimeflag(_Opts,'"false"').


bollepling(Test,Trans) :-
    call(Test),
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

smart_time_option(nth(N)) :-N >1. %% første = nth(1) innocent

%%  smart_time_option(first(_)). 
%%  smart_time_option(next(_)).   
%%  smart_time_option(first). 



print_smart_trail:- myflags(smartdepflag,true) ->  output(']}');true.




decide_actual_noid3(N,Opts,NActual) :- %% ad hoc %% TA-101022
     member(nth(M),Opts),  %% in nth (M)>N, may need M
     !,
     maxval(M,N,K),
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
    

%%% OUTDEPLIST1 %%%%%%%


outdeplist1(Deps,Day,Opts,DirPlace,Out,MAP) :-
    delete1(direct,Opts,Opts1),
    !, % direct is no longer relevant
    outdeplist1(Deps,Day,Opts1,DirPlace,Out,MAP).  


%% NO Direction nor time
outdeplist1(Deps,_Day,Opts,_Place,Out1Out2,  [Dep1,Dep2]) :-  
    myflags(smsflag,true),
    Opts = [],    % no direction
    !,    
    progtrace(4,case1), 
	 timenow(Tid),               %% should be part of bustrans?
    keepafter(Tid,Deps,AfterDeps),
    firsttostation(AfterDeps,Dep1),   % from HT
    firstfromstation(AfterDeps,Dep2), % to HT
    outdepnexttostation(Dep1,Out1),
    outdepnextfromstation(Dep2,Out2),
    saysomething(Out1,Out2,Out1Out2). 



outdeplist1(Deps,Day,Opts,DirPlace,((Out,earliesttimes)),MAP) :-   % Nte siste avgang
	 member(nth(N),Opts),
	 member(last(1),Opts),
    !,
    progtrace(4,case3), 
	 reverse(Deps,RevDeps),
	 nth(N,RevDeps,Dep),
	 outdeplisttime([Dep],Day,Opts,DirPlace,Out,MAP). 


outdeplist1(Deps,Day,Opts,DirPlace,Out,MAP) :-   % siste N avganger
	 delete1(last(N),Opts,Opts1),  
    !,
    progtrace(4,case4), 
	 reverse(Deps,RevDeps),
	 memberids0(N,RevDeps,LastRev), %% if 0, keep all
	 reverse(LastRev,LastDeps),
    deleteall(lastcorr,Opts1,Opts2), 
    outdeplist1(LastDeps,Day,[time|Opts2],DirPlace,Out,MAP).


% moved up, last takes priority 
outdeplist1(Deps,Day,Opts,DirPlace,((Out,earliesttimes)),MAP) :-   % siste avgang
	 member(last(1),Opts),
    !, 
    progtrace(4,case5), 
	 lastmem(Deps,Dep),
	 outdeplisttime([Dep],Day,Opts,DirPlace,Out,MAP). 

% moved up, last takes priority 
outdeplist1(Deps,Day,Opts,DirPlace,((Out,earliesttimes)),MAP) :-   % ankomst FØR == siste ankomst
    member(lastcorr,Opts), 
    !, 
    progtrace(4,case6), 
    find_last_arrival(Deps,Dep), 
	 outdeplisttime([Dep],Day,Opts,DirPlace,Out,MAP).

 

outdeplist1(Deps,Day,Opts,DirPlace,((Out,earliesttimes)),MAP) :-   % Nte første avgang
	 member(nth(N),Opts),
%%%%   	 member(first(1),Opts), %% TA-101022 ??
    !,
    progtrace(4,case7), 
	 nth(N,Deps,Dep),
	 outdeplisttime([Dep],Day,Opts,DirPlace,Out,MAP). 
 

outdeplist1(Deps,Day,Opts,DirPlace,(Out, earliesttimes),MAP) :-   % Nte  avgang
	 member(next(N1),Opts),
    N1 < 0, N is -N1, %% 
    !,
    progtrace(4,case8), 
    nth(N,Deps,Dep),
	 outdeplisttime([Dep],Day,Opts,DirPlace,Out,MAP).  


outdeplist1(Deps,Day,Opts,DirPlace,((Out,earliesttimes)),MAP) :-   % Nte neste avgang
	 member(nth(N),Opts),
	 member(next(1),Opts),
    !,
    progtrace(4,case9), 

    nth(N,Deps,Dep),
	 outdeplisttime([Dep],Day,Opts,DirPlace,Out,MAP).  


outdeplist1(Deps,Day,Opts,DirPlace,((Out,earliesttimes)),MAP) :-   % Nte neste avgang
	 member(nth(N),Opts),
	 member(nextaftertime(1),Opts),  
    !,
    progtrace(4,case10), 
	 nth(N,Deps,Dep),
	 outdeplisttime([Dep],Day,Opts,DirPlace,Out,MAP).  



outdeplist1(Deps,_Day,Opts,DirPlace,(Out,earliesttimes),MAP) :-   % neste =< N avganger
	 member(next(_N),Opts),   
 
    !,
    progtrace(4,case12), 
 
    justoutputtheliststar(Deps,DirPlace,Out,Opts,MAP).
 



%% SMS Check if first / first(1) is really EARLY (ANOTHER DAY)
outdeplist1(Deps0,Day,Opts,DirPlace,(OutFirst), MAP) :- % første/neste avgang 
    myflags(smsflag,true),
     anotherday(Day), 
	test(  
     (member(firstcorr,Opts);  
      member(first,Opts);       % unspecified first
      member(first(1),Opts)) ),    % ambiguous, get both ! 
    !,    
    progtrace(4,case13), 
(
    member(nightbus,Opts) -> 
    Deps0=Deps
    ;
    morning_break(T0430),
    keepafter(T0430,Deps0,Deps)), %% Night routes are excluded !!! 
	 firstdepnotices(Deps),   
	 memberids(1,Deps,FirstDeps1),

    outdepfirst(FirstDeps1,DirPlace,_TimeF,OutFirst, MAP).


            %% SMS first means only next
outdeplist1(Deps,Day,Opts,DirPlace,(OutNext,earliesttimes),MAP) :- % første/neste avgang 
    myflags(smsflag,true),
    \+ member(firstcorr,Opts), 
    \+ member(time,Opts),      % time means a clock has been set
	 (member(first,Opts);       % unspecified first
     member(first(1),Opts);    % ambiguous, get both ! 
     member(next(1),Opts)),
    !,    
    progtrace(4,case14), 
    timenow(NOW),
    keepafter(NOW,Deps,AfterDeps),  
	 memberids(1,AfterDeps,NextDeps),
    outdeplisttime(NextDeps,Day,Opts,DirPlace,OutNext,MAP). 



%% SMS flag, Nightbus, no destination ==> summary of departures !!!


%% Avoid Night to saturday if saturday is just daycode !!!

outdeplist1(Deps0,Day,Opts,DirPlace,(OutFirst,OutNext,earliesttimes), MAP) :- % første/neste avgang 
   \+ myflags(smsflag,true), %% NONSMS -> FIRST/LAST
   \+ member(firstcorr,Opts), 
   \+ member(time,Opts),       % time means a clock has been set 
	(  member(first,Opts);       % unspecified first
      member(first(1),Opts);    % ambiguous, get both ! 
      member(next(1),Opts)),
    \+ anotherday(Day),  
    !,    
    progtrace(4,case15),
	 timenow(Tid),               %% should be part of bustrans?
   (
    member(nightbus,Opts) ->  
     Deps0=Deps
    ;
     keepafter(Tid,Deps0,Deps)),   %% after now

	 memberids(1,Deps0,FirstDeps), 
    keepafter(Tid,Deps,AfterDeps),
	 memberids(1,AfterDeps,NextDeps),
	 outdepfirst(FirstDeps,DirPlace,TimeF,OutFirst, MAP),

    outdepnext(NextDeps,Opts,TimeF,_TimeL,DirPlace,OutNext, _NAP). %% NB calls timenow again!


outdeplist1(Deps,Day,Opts,DirPlace,Out,MAP) :-   % første N avganger 
	 delete1(first(N),Opts,Opts1), 
    !, 
    progtrace(4,case16), 
    deleteall(first,Opts1,Opts2),           % just a flag 
	 memberids0(N,Deps,FirstDeps),   
    outdeplist1(FirstDeps,Day,[time|Opts2],DirPlace,Out,MAP).


outdeplist1(Deps,Day,Opts,DirPlace,((Out,earliesttimes)),MAP) :-   % n'te avgang
	 member(nth(N),Opts),                                   % samme dag
    \+ anotherday(Day), %% 
    !, 
    progtrace(4,case17), 
    timenow(NOW),
    keepafter(NOW,Deps,Deps1),

    nth(N,Deps1,Dep),
	 outdeplisttime([Dep],Day,Opts,DirPlace,Out,MAP).


outdeplist1(Deps,Day,Opts,DirPlace,((Out,earliesttimes)),MAP) :-   % neste avgang
	 member(next(1),Opts),
    !, 
    progtrace(4,case19), 
	 timenow(Tid),                          
	 nextdep(Tid,Dep,Deps), %% DepTime >= Tid  buslog.pl
	 outdeplisttime([Dep],Day,Opts,DirPlace,Out,MAP).

outdeplist1(Deps,Day,Opts,DirPlace, ((Out,earliesttimes)),dir(Dep1,DirPlace)) :-   % første avgang
	 (member(first(1),Opts)   ;  
     member(firstcorr,Opts)),   
	 member(Dep,Deps),
    !, 
    progtrace(4,case20),
    first_dep(Deps,Dep1), 
	 outdeplisttime([Dep],Day,Opts,DirPlace,Out,_MAP).


% Number of departures 
 
outdeplist1(_Deps,_,Opts,_DirPlace,space0,_MAP) :- 
	 member(number,Opts),
    !,
    progtrace(4,case21). 

%%   departure/departures Taken care of in busans

   
outdeplist1(Deps,Day,Opts,DirPlace,((Out,earliesttimes)),MAP) :-   % Nte avgang
	 member(nth(N),Opts),
    !,
    progtrace(4,case22), 

	 length(Deps,LDS), %% TA-101021
    minval(N,LDS,N1), %% check, nth(N) =< # list
   
    nth(N1,Deps,Dep),
 
	 outdeplisttime([Dep],Day,Opts,DirPlace,Out,MAP).



% Få eller alle avganger 
outdeplist1(Deps,_,Opts,DirPlace,((Out,earliesttimes)),MAP) :- 
    (testmember(time,Opts);testmember(timeset,Opts)), 
  
    length(Deps,DepsLengde), 
    maxnumberofindividualdepartures(MaxInd),   
    DepsLengde=< MaxInd,    
	 !, 
    progtrace(4,case23), 

    justoutputthelist(Deps,DirPlace,Out,Opts,MAP). %% star only for sms and afternow




% Find next 2 if SMS %%   Default

outdeplist1(Deps,Day,Opts,DirPlace,((Out,earliesttimes)),MAP) :-

    myflags(smsflag,true),  
 \+ myflags(nightbusflag,true),
 \+ time_options(Opts), 
 \+ member(timeset,Opts), 
 \+ anotherday(Day), 

    timenow2(1,NOW), %% at 17:45, timenow is past 
    keepafter(NOW,Deps,Deps1),                    %% star takes after now
%%%%%%%%%%    Deps1 \== [], %% EMPTY /// ---> Needs warning, TIME not tomorrow
    
    !,   
    progtrace(4,case24), 
 
    justoutputtheliststar(Deps1,DirPlace,Out,Opts,MAP). 


% Mange avganger

outdeplist1([],Day,Opts,DirPlace,Out,MAP) :- %% not earliesttimes 
    !,
    progtrace(4,case25), 
    outdeplisttime([],Day,Opts,DirPlace,Out,MAP). %% whatever you get


outdeplist1(Deps,Day,Opts,DirPlace,((Out,earliesttimes)),DESTMAP) :- %% from A to B
    testmember(time,Opts),  %% then not afternow %% TA-100630
    \+ anotherday(Day),                            
    \+ myflags(dialog,1),
    !,
    progtrace(4,case26na), 

%%%%%    outdeplisttime(Deps,Day,Opts,DirPlace,Out,MAP). %% same as \
    justoutputthelistnotafternow(Deps,DirPlace,Out,Opts,DESTMAP). %% %% then not afternow


outdeplist1(Deps,Day,Opts,DirPlace,((Out,earliesttimes)),MAP) :- %% from A to B
    \+ anotherday(Day),                            
    \+ myflags(dialog,1),
    
    !,
    progtrace(4,case26), 
    justoutputtheliststar(Deps,DirPlace,Out,Opts,MAP).


outdeplist1(Deps,Day,Opts,DirPlace,((Out,earliesttimes)), MAP) :-
    !,
    progtrace(4,case27), 
    outdeplisttime(Deps,Day,Opts,DirPlace,Out,MAP). %% Next/Last



first_dep([D|_],D):-!.
first_dep(_,[]). 

%% END OUTDEPLIST1  %%%%%

 

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
    myflags(smartdepflag,true), 
    !,
    NActual = 6.  %% <---- ????????????????????



decide_actual_noid(N,NActual):-  
    myflags(smsflag,true), %% not for web %% TA-101117
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
    myflags(smartdepflag,true),!,NActual= 6. %%% <---- ??????

decide_actual_noid7(Opts,MAX):-   
    maxnumberofindividualdepartures(MNID), 

  ( (member(next(N),Opts), N > 0) -> minval(N,MNID,MAX); MAX=MNID ). 






earliesttimes :- 
    \+ myflags(smsflag,true),
    \+ myflags(dialog,1),
    !,
    printmess1(earliesttimes). 
earliesttimes.

%%%%%%%%%% END OUTDEPLIST %%%%%%%%%%%%%%%%%%%%%


saysomething(space0,space0,space0):-!. %%%%%% printmessage(mustknow(place))):-!.

saysomething(Out1,Out2,((Out1,Out2))).


%%%%%%


justoutputthelistnotafternow(Deps,DirPlace,Out,Opts,DESTMAP):- 
    progtrace(7,Deps),  

    maxnumberofindividualdepartures(MNID), %% Extra check

    ( (member(next(N),Opts), N > 0) -> minval(N,MNID,MAX);MAX=MNID), %% MAX is N; MAX is MNID), 

    progtrace(5,just(MAX)),  
 
    memberids(MAX,Deps,Deps5),

    justoutputthelist(Deps5,DirPlace,Out,Opts,DESTMAP). 


%% justoutputtheliststar // filter all but first within 5 minutes or same RID

% Purpose is to not let the second (of the originals) dep shadow for next after 5 minutes
% However, same rid makes it complicated


justoutputtheliststar(Deps,DirPlace,Out,Opts,MAP):- 
    myflags(dialog,1),
    !,
    split(1,Deps,[Dep1],_Deps1), 
    justoutputthelist([Dep1],DirPlace,Out,Opts,MAP). 


justoutputtheliststar(Deps,DirPlace,Out,Opts,MAP):- 
    progtrace(7,Deps),  

     
    decide_actual_noid7(Opts,NActual),

    progtrace(5,just(NActual)),  

    split(1,Deps,[Dep1],Deps1), 
 
%%%%%%%%%   ridof(Dep1,RID1),           

    avoidsamerid2(Dep1,Deps1,Deps2), %% avoid Gløs N/Gløs S same time / same RID
                                     %% if smartdep, cut all subsequent RIDS ??
                                     %% TA-110503
    timenow2(5,NOW5), 
    keepafter(NOW5,Deps2,Deps3),
    append([Dep1],Deps3,Deps4),

    memberids(NActual,Deps4,Deps5),

    justoutputthelist(Deps5,DirPlace,Out,Opts,MAP). 

% % % %

justoutputthelist(Deps,DirPlace,Out,Opts,DESTMAP):- 
    progtrace(4,Deps), 
    firstdepnotices(Deps),
    Deps = [Dep|_], %% safe ????

    getdeptime(Dep,Firstdeparturetime),
    addrefdialog(firstdeparturetime,Firstdeparturetime),
    firstdeparturetime := Firstdeparturetime, %% Moved to firstdepnotice

    justoutputthelist0(Deps,DirPlace,Out,Opts,DESTMAP). %% no warning 

justoutputthelist0(Deps,DirPlace,Out,Opts, dir(Dep1,Bingo)):-  %% no warning 

  set_of( x3(TimeDurations,BusN1,Station1), %% TimeDurations first=>sorted on time!

      busleaveset(BusN1,Station1,Deps,DirPlace,Opts,   TimeDurations), 
      BusDeps),

 

    outsmalldeps(BusDeps,DirPlace,Out,Opts),

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
    myflags(smartdepflag,true),
    !.  


avoidsamerid2(Dep,Deps1,Deps2):- %% REMOVE all (succeeding) deps with same RID and Station
    myflags(smartdepflag,true),    %% TA-110503
    !,
    ridof(Dep,RID),
    stationof(Dep,STAT),
    set_filter(X, (ridof(X,R),R \== RID,stationof(X,S),S \==STAT),Deps1,Deps2).



avoidsamerid2(Dep,Deps1,Deps2):- %% maybe relax = station ? %% TA-110503
    ridof(Dep,RID),
%%     stationof(Dep,STAT),
    set_filter(X, (ridof(X,R),R \== RID
    %%%%   ,stationof(X,S),S \==STAT
    ),Deps1,Deps2).



/* obsolete %% TA-110503
avoidsamerid(_,L,L):-myflags(smartdepflag,true),!.  %% Acually,test both RID and Station !!!!
                                             %% TA-110502
avoidsamerid(RID,L1,L2):-
    set_filter(X,(ridof(X,R),R \== RID),L1,L2). 
*/



findsetoftimes(Deps,Times):-
    set_of(DT, member(depnode(_,DT,_,_,_,_,_,_,_),Deps),Times).

writetimes(Times,(bwr2(Times,departure),period)). 

%% NEW PREDICATE
memberids0(N,Deps1,Deps1):-
    N=<0,
    !. 

memberids0(N,Deps1,Deps2):-
    members(N,Deps1,Deps2).

memberids(N,Deps1,Deps2):-
    members(N,Deps1,Deps2).


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
    progtrace(4,Dep), %% 3  Temp %% TA-110204

    getdeptime(Dep,Firstdeparturetime), 
    addrefdialog(firstdeparturetime,Firstdeparturetime),
    firstdeparturetime := Firstdeparturetime, 

    ((myflags(warningflag,true),myflags(smsflag,true)) ->
        (deptimeofwarning(Dep,Date,Time),
   
   set(warningtime , notification(Date,Time)),          

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
   myflags(warningtime, notification(Date,Time)),
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
    myflags(actualdate,Date).

getdeptime(depnode(_,Time,_,_,_,_,_,_,_),Time).
getdeptime(depans(_,_,Time,_,_,_,_,_,_,_),Time). %% /8
getdeptime(td(Time,_RID_,_Dur_,_,_,_), Time).


getprewarning(PreMin):- %% may be negative, i.e. warning after 
    myflags(prewarningtime,PreMin), %% specified by user
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




%%%%% outdeplisttime  first/next/last (where adequate) %%%%%%%%%%%%
%%%%%                 ---------------                  %%%%%%%%%%%%

outdeplisttime([],_Day,_Opts,_DirPlace,true,_MAP) :- !. 

outdeplisttime(Deps,Day,Opts,DirPlace,OutDep,MAP):- 
    firstdepnotices(Deps),
    outdeplisttime1(Deps,Day,Opts,DirPlace,OutDep,MAP).



outdeplisttime1([Dep],_Day,_,DirPlace,OutDep,MAP):- 
	 !,
    nonvar(Dep), %% Security Check, serious error
    outdeponly(Dep,DirPlace,OutDep,MAP).


outdeplisttime1(Deps,_Day,Opts,DirPlace,(OutFirst,OutNext,OutLast), MAP) :- 
    myflags(nightbusflag,true),
    !,
	 outdepfirst(Deps,DirPlace,TimeF,OutFirst, MAP),

	 outdeplast(Deps,DirPlace,TimeL,OutLast),
    outdepnext(Deps,Opts,TimeF,TimeL,DirPlace,OutNext, _NAP). %%  - Day


outdeplisttime1(Deps,_Day,Opts,DirPlace,(OutNext,OutLast), MAP) :- 
    myflags(nightbusflag,true),
    myflags(smsflag,true),
    timenow(MN), MN < 400,   %% Next nightbus RELEVANT
    !,
    outdepnext(Deps,Opts,_TimeF,TimeL,DirPlace,OutNext, MAP),  %% .. no first?

	 outdeplast(Deps,DirPlace,TimeL,OutLast).  


outdeplisttime1(Deps,_Day,_Opts,DirPlace,Out,MAP) :- 
    myflags(nightbusflag,true),
    myflags(smsflag,true),     %% Next nightbus IRRELEVANT
    !,
    maxnumberofindividualdepartures(MNID), %% Extra check 
    memberids(MNID,Deps,Deps4), %% there may be many if unrestricted
    justoutputthelist0(Deps4,DirPlace,Out,MAP). %% Few anyway, dont miss any
                                              %% 0  no warning

outdeplisttime1(Deps,_Day,_Opts,DirPlace,(OutFirst,OutLast), MAP) :-
    myflags(smsflag,true),
 \+ myflags(nightbusflag,true),
	 outdepfirst(Deps,DirPlace,_TimeF,OutFirst,MAP), 
	 outdeplast(Deps,DirPlace,_TimeL,OutLast).

%% Only TWO deps (Past departures ignored) 
outdeplisttime1(Deps,Day,Opts,DirPlace,(OutNext,OutLast),MAP) :-
 \+ myflags(smsflag,true), 
 \+ myflags(nightbusflag,true),
 \+ anotherday(Day),
    !, 
    outdepnext(Deps,Opts,_,TimeL,DirPlace,OutNext,MAP), %% <--- NEI, ikke 9999 
	 outdeplast(Deps,DirPlace,TimeL,OutLast).


outdeplisttime1(Deps,Day,Opts,DirPlace,(OutFirst,OutNext,OutLast), MAP) :-
 \+ myflags(smsflag,true), 
 \+ myflags(nightbusflag,true),
    outdepfirst(Deps,DirPlace,TimeF,OutFirst,MAP), 
	 outdeplast(Deps,DirPlace,TimeL,OutLast),
	 (\+ anotherday(Day) -> %% Next departure is irrelevant if not today !!! 
          outdepnext(Deps,Opts,TimeF,TimeL,DirPlace,OutNext,_NAP); %%  -Day
          OutNext=true).



%%


outdeponly(Dep,DirPlace,
				(bwrbusbc(Bus,BusN),bcp(passes), 
				 bwr(Station),bcp(attime),bwt(Time9),OutArr,period),dir(Dep,FINAL)) :-

	 Dep = depnode(_Time0,Time9,_DelArr,DelDep,BegTime,Rid,BusN,_,Station),
	 ridtobusname(Rid,BusN),
    vehicletype(BusN,Bus),
	 (\+ user:myflags(dialog, 1),! 
          ; 
          getcurrent(Cid), 
          addref(Cid, Rid,lastrid)      
    ),

  

    outandarrivesonly(Station,Time9,DirPlace,Rid,BegTime,DelDep,ARRIVALTIME,OutArr,FINAL), 

    Duration is ARRIVALTIME-Time9,

    create_smartdep_entry2(Station,Time9,Duration,Rid, DirPlace ,  Smartdep_entry), %% TA-110505
 
    print_smartdep_entry(Smartdep_entry).
   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% bingo(G) :- nl,out('<'),output(G),call(G),out(G),output('>').


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

%% TA-110801

setoffirst(X,P,Z):-!,setof(X,P,Z).  %%  63 Skansen DG-19 Asbjgt DG-50

%%                                                                 added late arrival
/* Cuts all after 1.

%% Hack   Setof, but only keep first
setoffirst(X,P,[Z1]) :- setof(X,P,Z),  firstmem(Z,Z1).

  %% same RID and correlating  destination, avoid the loop arrival

  %% [td(2058,bus_0063_0090,3,dronningens_gate_19),td(2058,bus_0063_0090,33,dronningens_gate_50)]) ? 
  %%                          ***                                           ***
  %%                                                                        drop

*/


busleave(Xopt,Time09, Rid1, BusN1,Station1,Duration,Deps,DirPlace,ToStation) :- 

	member(depnode(Time0,Time9,_DelArr1,DelDep1,_,Rid1,BusN1,_,Station1),Deps), 

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
 
outsmalldeps( [],_Sentrum,_,_Opts):- %% Empty ( <= error ?) 
    !,
    nl,
    output('*** Jeg finner ingen forbindelser ***'). %% error alarm

 
outsmalldeps( [   x3([],_,_)    ],_Sentrum,_,_Opts):- %% Empty ( <= error ?)%%
    !,
    nl,
    output('***  Jeg finner ingen forbindelse ***'). %% error alarm



outsmalldeps([   x3([TimesDuration],BusN,Station)   ],DirPlace, %% only 1
				 (bwrbusbc(Bus,BusN),  
              bcp(passes),bwr(Station),bcp(attime),
				  OutDeps2,period),Opts) :-
	 !,
    vehicletype(BusN,Bus),
    outsmalldeps2(arrivaltime,Station,[TimesDuration],DirPlace,OutDeps2,Opts). 


outsmalldeps(A,B,C,Opts):-
    outsmalldeps0(A,B,C,Opts).


outsmalldeps0([],_,[],_Opts).

outsmalldeps0([ x3(TimesDuration,BusN,Station)|BusDeps],DirPlace, %% TimesDuration FIRST!!!!
				 (bwrbusbc(Bus,BusN), 
             bcp(Passes),     bwr(Station), 
    			  
    OutDeps2,period,OutDeps),Opts) :-

    vehicletype(BusN,Bus),

    code_passes(Opts,Passes),

	 outsmalldeps2(duration,Station,TimesDuration,DirPlace,OutDeps2,Opts),  
	 ensure_removed([BusN,Station,TimesDuration],BusDeps,BusDeps2),
	 outsmalldeps0(BusDeps2,DirPlace,OutDeps,Opts).


code_passes(Opts,goesto):-   member(to,Opts),  \+ member(from,Opts),!.
code_passes(Opts,goesfrom):- member(from,Opts),\+ member(to,Opts),!. 
code_passes(_,passes):-!.


outsmalldeps2(arrivaltime,_Station,[TimesDuration],DirPlace, (bwt(Time),OutArr),_Opts ) :- 
	 faenta([TimesDuration],Times,Duration,SetOfDest), % Duration =  Short - Long
    Times = [Time],  %% assumption: only one time 
    
    addtotime(Time,Duration,Arrival),

    set(firstdeparturetime,Time),  %% for reference
    set(lastarrivaltime,Arrival),  %% OBSOLETE

	 (\+ user: myflags(dialog, 1),!   
      ; 
    getcurrent(Cid), 
      addref(Cid,Time,firstdeparturetime),
      addref(Cid,Arrival,lastarrivaltime)
    ),

   (SetOfDest=[M4] -> UT=M4;UT=DirPlace),

	 outandarrives3(UT,arrival(Arrival),OutArr).

outsmalldeps2(duration,Station,TimesDurations,DirPlace,(bwtimes2(Times),OutArr),_Opts ) :- 

    create_smartdep_entry(Station,TimesDurations,   DirPlace,Smartdep_entry), %% TA-110405

    print_smartdep_entry(Smartdep_entry),

	 faenta(TimesDurations,Times,Duration,SetofStations),
    outandarrivesset(Station,DirPlace,SetofStations,duration(Duration),OutArr).


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




create_smartdep_entry(_,_,_,_) :- \+  myflags(smartdepflag,true),!.
  
create_smartdep_entry(Intstation1,TimesDurations,DirPlace,Create_smartdep_entry):- %% TA-110405
    myflags(smartdepflag,true),
    firstmem(TimesDurations,td(Time,RID,Duration,_Intstation2)),

    ridtobusnr(RID,BusNo),
    localstatno(RID,Intstation1,Fullstatname1,Localstatno1),


    Create_smartdep_entry = smartdepentry(Fullstatname1,Localstatno1,BusNo,Time,Duration,DirPlace),

    !.



create_smartdep_entry2(_,_,_,_,_,_) :-
    \+ myflags(smartdepflag,true),
    !.


create_smartdep_entry2(Station,Time,Duration,Rid, DirPlace, Smartdep_entry) :-
    myflags(smartdepflag,true),
    !,
    ridtobusnr(Rid,BusNo),
    localstatno(Rid,Station,Fullstatname1,Localstatno1),
    Smartdep_entry = smartdepentry(Fullstatname1,Localstatno1,BusNo,Time,Duration,DirPlace).


create_smartdep_entry3(_Station,_Time,_Duration,_BusNo, _DirPlace, _Smartdep_entry) :-
    \+myflags(smartdepflag,true),
    !.

create_smartdep_entry3(Station,Time,Duration,BusNo, DirPlace, Smartdep_entry) :-
    myflags(smartdepflag,true),
    !,
    fullstatname(Localstatno1,Station,Fullstatname), %% TA-110530

   %% veh_mod(TTP),
   %% TTP:hpl(Localstatno1,Station,_,Fullstatname),

    Smartdep_entry = smartdepentry(Fullstatname,Localstatno1,BusNo,Time,Duration,DirPlace).



localstatno(RID,Intstation,Fullstatname,Localstatno):-
    passeq(RID,STATNO,Intstation,_Seq,_DelArr,_DelDep), %% buslog.pl 
    fullstatname(Localstatno,Intstation,Fullstatname),        %% TA-110530
    Localstatno = STATNO.    

fullstatname(_Localstatno,hovedterminalen,'Sentrumsterninalen'):-!. %% TA-110530
%% detailed station name (M3) hard to find
 
fullstatname(Localstatno,Station,Fullstatname) :- %% official station name
    veh_mod(TTP),                     %% not Sentrumsterminalen but Munkegata - M3
    TTP:hpl(Localstatno,Station,_,Fullstatname).   




    
print_smartdep_entry(_):-
     \+ myflags(smartdepflag,true),
     !.

print_smartdep_entry(smartdepentry(Fullstatname1,Localstatno1,BusNo,Time,Duration,DirPlace)):-
     myflags(smartdepflag,true),
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
   output(ItemList).


  




outdepfirst(Deps,DirPlace,Time9,
				(  bwrbusbc(Bus,BusN), %% bcpbc(Bus),bwr(BusN), 
             
				 bcp(Verb), % passes/arrives/departs
				 bwr(Station),bcp(attime),bwt(Time9),OutArr,period),dir(Dep1,FINAL)) :-
    myflags(smsflag,true),
    !,
    member(depnode(_Time0,Time9,_DelArr1,_DelDep1,BegTime,Rid,BusN,_,Station),Deps),
	 ridtobusname(Rid,BusN), 
    vehicletype(BusN,Bus),
    first_dep(Deps,Dep1),	 
    outandarrives6(Time9,Station,DirPlace,Rid,BegTime,OutArr,Verb,FINAL). 

outdepfirst(Deps,DirPlace,Time9,
				(bcpbc(thefirst),bcp(Bus),comma,
             bwrbus(number,BusN),
				 bcp(Verb), % passes/arrives/departs
				 bwr(Station),bcp(attime),bwt(Time9),OutArr,period),dir(Dep1,FINAL)) :-
    
    first_dep(Deps,Dep1),

	 member(depnode(_Time0,Time9,_DelArr1,_DelDep1,BegTime,Rid,BusN,_,Station),Deps),
	 ridtobusname(Rid,BusN), 
    vehicletype(BusN,Bus),

	 (\+ user: myflags(dialog, 1),!
      ; 
    getcurrent(Cid), 

     addref(Cid, Rid, lastrid),
     addref(Cid, Time9, firstdeparturetime) 
    ),
	 outandarrives6(Time9,Station,DirPlace,Rid,BegTime,OutArr,Verb,FINAL).


outdeplast(Deps,DirPlace,Time9, 
			  (output('...'),  
            bwrbusbc(Bus,BusN), 
				bcp(Verb), % passes/arrives/departs
				bwr(Station),bcp(attime),bwt(Time9),OutArr,period)) :-
    myflags(smsflag,true),
    !,

	 lastmem(Deps,Dep1), Dep1=depnode(_,Time9,_DelArr1,_DelDep1,BegTime,Rid,BusN,_,Station),
	 ridtobusname(Rid,BusN), 
    vehicletype(BusN,Bus),

	 (\+ user: myflags(dialog, 1),!
      ; 
    getcurrent(Cid), 

     addref(Cid, Rid, lastrid),
     addref(Cid, Time9, lastarrival)   
    ),

	 outandarrives6(Time9,Station,DirPlace,Rid,BegTime,OutArr,Verb,_).

outdeplast(Deps,DirPlace,Time9,
			  (bcpbc(thelast),bcp(Bus),comma,bwrbus(number,BusN), 
				bcp(Verb), % passes/arrives/departs
				bwr(Station),bcp(attime),bwt(Time9),OutArr,period)) :-

	 lastmem(Deps,depnode(_,Time9,_DelArr1,_DelDep1,BegTime,Rid,BusN,_,Station)),
	 ridtobusname(Rid,BusN), 
    vehicletype(BusN,Bus),

	 (\+ user: myflags(dialog, 1),!
      ; 
    getcurrent(Cid), 

     addref(Cid, Rid, lastrid),
     addref(Cid, Time9, lastarrival)   
    ),

	 outandarrives6(Time9,Station,DirPlace,Rid,BegTime,OutArr,Verb,_).



%% As part of triple FNL departure

%% Print next time only if later than TimeF

outdepnext(Deps,Opts,TimeF,TimeL,DirPlace,Out, MAP) :- %% - Day 
	 timenow(Tid), %% NB  called again
    Dep1=depnode(_,Time9,DelArr1,_DelDep1,BegTime,Rid,BusN,_,Station),
    nextdep(Tid, Dep1,Deps),
	 ridtobusname(Rid,BusN),
	 (\+ user: myflags(dialog, 1),!
      ; 
    getcurrent(Cid), 
    addref(Cid, Rid, lastrid)
    ),
	 outdepnext2(Opts,TimeF,TimeL,Time9,DelArr1,BegTime,Rid,BusN,
					 Station,DirPlace,Out, MAP).


outdepnext(_,_,_,_,_,[],_NAP).  %% 


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
	 outandarrives6(Time,Station,DirPlace,Rid,BegTime,OutArr,Verb,MAP). 


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

outandarrives6(_,_Station1,nil,_,_,_,passes,_FINAL):-!. %% destination nil

outandarrives6(_,Station1,Station2,_,_,[],passes,_FINAL):- %% SAME station
(
    (Station1==hovedterminalen , corr(Station2,hovedterminalen));
    (Station2==hovedterminalen , corr(Station1,hovedterminalen))
),
 !. %% Genialt hvis  ..ankommer m1 0738 og går fra m1 0745  

outandarrives6(_,Station,from(Place),_,_,[],passes,_FINAL):- %% arrivesat) :-
    Station == Place,
    !.

outandarrives6(_,Station,to(Place),_,_,[],passes,_FINAL):- %% leaves) :- 
    Station == Place,
    !.
   
outandarrives6(Time,Station,DirPlace,Rid,BegTime,Ans,passes,FINAL) :- 
    Station \== DirPlace,
    !,
    outandarrives4(Time,DirPlace,Rid,BegTime,Ans,FINAL). 
    
outandarrives6(Time,_Station,DirPlace,Rid,BegTime,Ans,passes,FINAL) :- 
    outandarrives4(Time,DirPlace,Rid,BegTime,Ans,FINAL). %%  <--- Same As Above !!!


outandarrives4(DepTime,DirPlace,Rid,BegTime, Out, ToStation) :- 
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

	 (\+ user: myflags(dialog, 1),!  
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
	 (\+ user: myflags(dialog, 1),!  
      ; 
    getcurrent(Cid), 
      addref(Cid,VALUE,SLOT)
    ).



outfromtocorr0(Opts,Dep,OutDep,Mid01,OutAns,MAP):- 
  (print_smart_init([transfer|Opts]),                            %% TA-110406
   outfromtocorr1(Opts,Dep,OutDep,Mid01,OutAns,MAP),
   print_smart_trail),                           %% TA-110406
   !  %% must not backtrack into busans
  ;
   OutAns= (bcpbc(nolonger),period). %% some kind of fail //
                                     %% maybe irrelevant because connections failed
                                     %% -> negans

%%% OUTFROMTOCORR1


outfromtocorr1(_Opts,Dep,_OutDep,Mid01,OutAns,MAP):- 
    dummy_transfer(Mid01),
    !,
    progtrace(4,case30), 
    outfromtodirect(Dep,OutAns,MAP),
    !. %% unnec



outfromtocorr1(_Opts,Dep,OutDep,Mid01,(OutCorr,earliesttimes), corr(Dep,Mid01)):- 
    cutloop(Mid01,TF), 
    TF=true,
    !,
    progtrace(4,case31), 
    outfromto(TF,Dep,OutDep), 
    outcorr(TF,Mid01,OutCorr).


%% NOT CUTLOOP Station
outfromtocorr1(_Opts,Dep,OutDep1,Mid01,(OutDep2,earliesttimes),corr(Dep,Mid01)):-  %% roles changed slightly for OutDep1,2

    Dep   =  depans(StartBusN,Rid1,StartTime,StartStation,EndBusN,_Rid2,EndTime,EndStation),
    Mid01 =  midans(StartBusN,OffTime,OffStation,EndBusN,OnTime,OnStation),
    !, 
    firstdepnotice(Dep), 
    progtrace(4,case32), 

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

   firstdeparturetime := StartTime, %% AD HOC
   lastarrivaltime := EndTime,

   difftime( OffTime,StartTime,Duration1),

 
   create_smartdep_entry2(StartStation,StartTime,Duration1,Rid1, OffStation,Smartdep_entry1), 
                                            %% TA-110406
   print_smartdep_entry(Smartdep_entry1),


   difftime( EndTime,OnTime,Duration2),

   create_smartdep_entry3(OnStation,OnTime,Duration2,EndBusN, EndStation,Smartdep_entry2),

   print_smartdep_entry(Smartdep_entry2), 


	 (\+ user: myflags(dialog, 1),! 
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
    progtrace(4,case33),
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

    myflags(smsflag,true),
    OffStation == OnStation,
    !.


outcorr(false,midans(_StrBusN,OffTime,OffStation,_EndBusN,OnTime,OnStation),

	  (bcp(changeorder),bcp(from),
        bwr(OffStation), bcp(attime),bwt(OffTime),bcp(to),
        bwr(OnStation), bcp(attime),bwt(OnTime),
        period)
          
):-

    myflags(smsflag,true),
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

    \+ myflags(smsflag,true),
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


sentenceend(period).
sentenceend(question).
sentenceend(endline). %% no written '.'

languagenr(1) :- language(english).
languagenr(2) :- language(norsk).

reply(_X_) :-!. %% Just marker 


db_reply(Subject,Attribute,Value):- %% TA-110111
    testmember(Attribute,[webaddress,mailaddress]), %% TA-110120
    !,
    writename(Subject),bcp(has),bcp(Attribute),
    nl,write('  '),
    writesimplelist(Value). %% not Http


db_reply(Subject,Attribute,Value):- 
    writename(Subject),bcp(has),bcp(Attribute),write('   '),
    writename(Value). 


writename(TA):- var(TA),!,write('???'). 

writename(TA):- 
    specname(TA,TTAA),
    !,
    roundwrite(TTAA).

writename((F,G)):-!, 
    writename(F),
    roundwrite(G).

writename(TA):-bwrbc(TA). 
   

% This is special because no nl if empty message. 

% Print message


% Only "vital"  messages if SMS

% NB It is important that something is printed
% 


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


printmessage(notification(Date,Clock)):- 
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
   myflags(smsflag,true),
   empty_sms_message(Message),
   !,
   emptymessage.  


printmess(Message):- 
   printmess1(Message). 

%% empty_sms_message(sameplace(_,_)). 
empty_sms_message(howtuchelp):-myflags(dialog,1). %% <----

empty_sms_message(date_isa_day(_,_)). %% TA-110411

empty_sms_message(nearest_station(_STARTSTOP,_,_)).

%%    myflags(dialog,1). %%  avoid ('+') %% TA-110411
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
    myflags(smsflag,true),
    !.

printmess1(webstatistics) :-
    nl,
    %listing(webstat).
    
    output('DATE            SMS  TOTAL'),
    nl,
    for(webstat(date(Year,Month,Day),SMS,TOT), 
       (write(Year),write('-'),write(Month),write('-'),write(Day),out('      '),out(SMS),out('  '),out(TOT),nl)),
    nl.




printmess1(numberof(N,day)) :- 
     out(N), doubt(days,dager),period.


printmess1(route_period(_Tt,_Tt07,Date1,_Date2)):-
     writedate(Date1),nl.


printmess1(neverpasses(Nine,Lade1)):-
	  vehicletype(Nine,Bus),
     bcpbc(Bus),bcp(Nine),bcp(neverpasses),bwr(Lade1),period.
    


printmess1(notification(Date,Time)):- 
    !,

 ( (myflags(warningflag,true),myflags(smsflag,true)) ->

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
printmess1(nearest_station(_STARTSTOP,X,_)):- 
    myflags(smsflag,true),  
    obvious_station(X),
    !,
    emptymessage. 


printmess1(nearest_station(_,Street,Station)):- 
    bcpbc(theneareststationto),bwrstreet(Street),
    bcp(is),space,
(Station = '' -> %% (in case empty station)
    doubt(unknown,ukjent);
    bwr(Station)),
    period,
    !. 

printmess1(dateis(Year,Month,DayNr,Day)):- 
     writedate(date(Year,Month,DayNr)),
     bcp(isa), outday(Day),
         period.


%printmess1(otherperiod(_Date)):- 
%    myflags(airbusflag,true),
%    !,
%    airbus_module(FB),
%    write_mess_off(FB).
%

printmess1(otherperiod(Date)):-
    decide_period(Date,Period),
    TT=tt,                          %% Default  Ad Hoc 
    current_period(TT,CP,_,_),     
    Period == CP,             %% Same period as today
    default_period(TT,_S_w,CP),  %% and it is standard 
    !.

printmess1(otherperiod(Date)):- %% If not, print message
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



writedate(date(Y2000,M11,D12)) :- 
    language(norsk),
    !,
    monthshort(M11,_,Nov),
    write(D12),write('. '),write(Nov),write(' '),write(Y2000),write(' '). 


writedate(date(Y2000,M11,D12)) :- 
    language(english),
    !,
    monthshort(M11,Nov,_),
    write(Nov),write(' '),write(D12),write(', '),write(Y2000),write(' '). 



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

%% General Nightbus message ( following weekend is normal )
pmess(generalnightbusmessage):- 
    pen(['Nightbus goes from O.Tryggvasons gt. at  0100,0200,0300  am night to Saturday and Sunday.',
         'Nattbuss går  fra O.Tryggvasons gt. kl 0100,0200 og 0300 natt til lørdag og søndag.']).

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




getphrase0(C,Phrase):- 
   cwc(C,List),
   languagenr(LN),    
   nth(LN,List,Phrase).

    

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
    myflags(nightbusflag,true),!,
    pen(['night to ','natt til ']), %% night to ..day 
    bcp(Day). %%  For nightbus, day is special (on holidays)

nibcp(Day):- bcp(on), bcp(Day). 
             %%     for is more neutral %% NO %% 
             %% in case the day is a alias day (KRHF)

%% Standard Nightbus Information Message

standnight(easterhol):- %% Standnight  påsken 
    myflags(nightbusflag,true),
    pmess(generalnightbuseaster),nl. 




/*   %% Stand night   Christmas
standnight(D):-
    myflags(nightbusflag,true),
    kindofday(D,workday),

(    myflags(language,norsk)->
(
    output('Nattbussen går ikke mellomjula,unntatt natt til tredje juledag.'),
 
    output('Ellers går nattbuss bare natt til lørdag og natt til søndag') %% <160 nattbuss[en]
);(

    output('There are no nightbus during Christmas holidays except night to Dec. 27'),
    output('Otherwise, only night to Saturdays and night to Sundays')
)).

*/



standnight(D):-
    myflags(nightbusflag,true),
    kindofday(D,workday),

(    myflags(language,norsk)->

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mapping fra konsept til ord på hvert språk


cwc(quote(S),[S,S]).

cwc(a,['a','en']).
cwc(about,['about','om']).
cwc(abus,['a bus','en buss']).
cwc(acomputer,['a computer','en datamaskin']).
cwc(after,['after','etter']).
cwc(airbuses,[airbuses,flybusser]). 
cwc(and,['and ','og ']).
cwc(adate,['a date','en dato']).
cwc(aday,['a day','en dag']).
cwc(anotherplace,['another place','et sted til']).
cwc(aplace,['a place','et sted']).
cwc(atime,['a time','et tidspunkt']). 
cwc(are,['are','er']).
cwc(are_the_same_as,['are the same as on','er de samme som på']).
cwc(aroute,['a route','en rute']).
cwc(arrivesat,['','']):- myflags(smsflag,true),!.
cwc(arrivesat,['arrives at ','kommer til ']).
cwc(arrival,['arrival', 'ankomst']).
cwc(arrivaltime,['arrival time', 'ankomsttid']). 

cwc(andsoon,[',...',',...']). %%  ( Realspeak ?)
%% cwc(andsoon,['and so on','og så videre']). 


cwc(as,['as','som']).
cwc(astation,['a station','en holdeplass']). 


cwc(assumetomorrow,['I assume you want routes for tomorrow.',    %% TA-110201
                    'Jeg antar du ønsker ruter for i morgen.']). %%


% cwc(assumetomorrow,['I assume you mean routes the day after.',
%                    'Jeg antar du mener ruter for dagen etter.']).


cwc(assumeyesterdepartures,['I assume you mean departures tonight.', 
                            'Jeg antar du mener avganger fra ikveld.']).


cwc(atram,['a tram','en trikk']). 
cwc(at,['at','ved']).
cwc(atday,['at','på']).
cwc(atstation,['at ','ved ']). %% 'på'  ved mer nøytralt  ( "Hovedterminalen er på Trondheim")

cwc(attime,['at','klokken']):- myflags(dialog,1),!. 
cwc(attime,['at','kl.']).  % otherwise

cwc(athing,['a thing','en ting']). %% hva koster det

cwc(avehicle,['a vehicle','et kjøretøy']). 

cwc(before,['before','før']).
cwc(between,['between','mellom']).
cwc(both,['both','både']).
cwc(bus,['bus','buss']).
cwc(buses,['buses','busser']).
cwc(bus_det,['bus','bussen']).      % den siste bussen/the last bus          % Bestemt form
cwc(bus_ana_comes,['it comes','kommer den']). % Buss anaforisert kommer
cwc(busdepartures,['bus departures','bussavganger']).
cwc(busroutes,['bus routes','bussruter']).
cwc(bustuc,['BusTUC','BussTUC']). 
cwc(by,['by','ved']).
cwc(bye,['Good bye','Ha det bra']). 

cwc(called,['called','som kalles']).
cwc(can,['can','kan']).
cwc(cannot,['can not','kan ikke']).

cwc(change,['route changes','ruteendringer']). 


cwc(self,[self,selv]). 

cwc(smshelp,['Prefix question with RUTE , and send to 2027.', %% TA-100924
             'Begynn meldingen med RUTE , og send til 2027.']).

cwc(so_on,['...','...']).
%% cwc(so_on,['so on','så videre']). 



cwc(sorrycannot,['I''m afraid I can''t do that.', %% HAL :-)
                 'Jeg kan dessverre ikke gjøre det.']). %%   //Actions

cwc(sorrynot,['No, I don''t. ',   %%  Non action (kjenne/like)
              'Nei, desverre']).  


cwc(sorrydont,['No, I don''t. ',   %%  Non action (kjenne/like)
               'Jeg  gjør dessverre ikke det.']).  

cwc(cannotanswer,['I can not answer that.','Jeg kan ikke svare på det.']). 

cwc(cannotanswermyself,['I can not answer that on my own.', %% self judgment
                        'Jeg kan ikke svare på det selv.']). 

cwc(cannotanswersuchquestions,['I can not answer such questions.', %% slutte å...
                        'Jeg kan ikke svare på slike spørsmål.']). 

cwc(cannotfindanyroutes,['I cannot find any connections ',  
                         'Jeg kan ikke finne noen ruteforbindelser']). 

cwc(cannotconnectto,['I can not find connections to', 
                     'Jeg kan ikke finne noen forbindelse til ']).  

cwc(cantake,['may take','kan ta']).

cwc(change,['change','bytte']).
cwc(changeorder,['change','bytt']). 

cwc(comes,['comes','kommer']).
cwc(coming,['coming','på vei']).
cwc(company,[company,selskap]). 
cwc(completesentence,['Please use a complete sentence',
                       'Vennligst bruk en fullstendig setning']).
cwc(congratulations,['Congratulations!','Gratulerer!']).

cwc(dateof,['of','']). 

cwc(day8,['New years eve','nyttårsaften']). %% Ad Hoc for X,mas routes 24.12--31.1
cwc(day9,['New years day','nyttårsdag']).  

cwc(delays,[delays,forsinkelser]).
cwc(departure,['departure','avgang']).
cwc(departures,['departures','avganger']).
cwc(departuretime,['departure time','avgangstid']). 
cwc(direction,['direction','retning']). 
cwc(donotknow,['don''t know','vet ikke']).


cwc(idonotknowanyplacesnear,['I do not know any places near', 
                            'Jeg kjenner ingen steder nær']).
cwc(idonotknowanystationsnear,['I do not know any stops near', 
                              'Jeg kjenner ingen holdeplasser nær']).

%% cwc(drink,['drink','drikk']). 

cwc(earliesttimes,[ 'The hours indicate the earliest passing times.', 
                    'Tidene angir tidligste passeringer av holdeplassene.']).

cwc(easterday2,['2. Easter day','2. påskedag']).   
 
cwc(eastereve,['Easter eve','påskeaften']). 
cwc(easterhol,['Easter holiday','påskehelligdag']). 
cwc(each,['each','hvert']).
cwc(end_stations,['the end stations','endestasjonene']).
cwc(entering,['entering','å gå på']).

cwc(error_reports_sent,        %% TA-101206
       ['Error reports will be forwarded to the administrator',
        'Feilrapporter vil bli videresendt administrator']). 

cwc(error_restart,['OK, where do you want to go?',
                   'OK, hvor vil du reise ?']). 

cwc(every,['every','hver']).

cwc(flybussen,['The Aiport bus','Flybussen']).
cwc(for,['for','for']).
cwc(friday,['Friday','fredag']).
cwc(fridays,['Fridays','fredager']). 
cwc(from,['from','fra']).
cwc(first,['first','første']).

/* %% TA-110426
cwc(generalnightbuseaster, %% also pmess !
         ['Nightbus goes night to  Easter Sunday from O.Tryggvasons gt. at  0100,0200 and 300 am.',
          'Nattbuss går natt til 1. påskedag fra O.Tryggvasons gt. kl 0100,0200 og 0300.']).
*/


cwc(godknows,['God knows.','Gud vet.']). %% :-)

cwc(goes,['goes','går']).
cwc(goesfrom, ['goes from','går fra']). 
cwc(goesto,  ['goes to','går til']). 
cwc(going,['going','å dra']).
cwc(happy_new_year,['Happy New Year','Godt Nyttår']).
cwc(endure,['Endure!','Hold ut!']). 
cwc(holiday,['route holiday','rutehelligdag']). 
cwc(have,['have','har']).
cwc(has,['has','har']). 
cwc(hello,['hello','hallo']).
cwc(hereafter,['after now','etter nå']). %% heretter can mean "after the above" 
cwc(hi,['Hi','Hei']).  

cwc(i,['I','jeg']).

cwc(iamhere,['I am here','Jeg er her']). %% obnoxious ?

cwc(icannot,['I am sorry I cannot do that','Det kan jeg dessverre ikke']). 
%% (but you  can)


cwc(icannotanswer,['I am not able to answer that.',
                  'Jeg kan ikke svare på det.']).

cwc(icannotfind,['I am sorry I cannot answer that.', 
                 'Det kan jeg dessverre ikke svare på.']). 

cwc(idonotknow,['I don''t know.','Jeg vet ikke.']). 

%% cwc(idonotknow,['I am not able to answer that.', 
%%                'Jeg kan ikke svare på det.']).

cwc(idonotunderstand,['I don''t understand that', %%  (  Avoid I want to die ==> OK)
                      'Jeg forstår ikke det']).

cwc(idkwhether,['I don''t know whether', 
                'Jeg vet ikke om']).

cwc(isillegal,['is invalid.',  
               'er ugyldig.']).

cwc(illegaldate,['This  date is invalid.', 
                 'Den datoen er ugyldig.']).

cwc(unknownfield,['uknknown field',  
                  'ukjent felt']). 

cwc(unknowndate,['This  date is unknown.',  
                 'Den datoen er ukjent.']). 

cwc(inconsistenttimes, ['This  time interval is not possible.',
                        'Dette tidsintervallet er ikke mulig.']).

cwc(inconsistentduration, ['This duration  is too large.', 
                           'Jeg kan ikke svare for så store tidsintervaller.']).

cwc(may17,['May 17.','17. mai']). %% TA-110518

cwc(mustknowfood,['You must specify food in such questions', 
                  'Du må spesifisere mat i slike spørsmål']).

cwc(new_years_eve,['New years eve','nyttårsaften']).
cwc(new_years_day,['New years day','nyttårsdag']).  

cwc(nofoodonbus,
     ['It is not allowed to  eat sausages, chips,  icecream  etc on the bus.',  %% :-)
      'Det er ikke tillatt å spise pølser, chips, is  o.l. ombord i bussen.']).

%  cwc(nofoodonbus, %% plakat i bussen
%    ['Please don''t eat sausages, chips,  icecream etc on the bus.', 
%     'Vennligst ikke spis pølser, is, chips o.l. ombord i bussen.']).

cwc(nodrinkonbus,
    ['It is not allowed to drink alcoholic beverages in the bus.', 
     'Det er ikke tillatt å nyte alkoholholdige drikker på bussen.']).


cwc(noneedtoanswer,['I don''t need to answer that.',
                    'Jeg trenger ikke å svare på det.']).

cwc(nosenseofhumour,   %% TA-110125
     ['I have no sense of humour.',
      'Jeg har ingen sans for humor.']).

cwc(nosmokeonbus,        
    ['It is not allowed to smoke in the bus.', 
     'Røyking er forbudt i bussene.']).

cwc(nonightbus,['I have no routes for the nightbus', 
                'Jeg har for tiden ingen ruter for nattbussen']).
                              

cwc(noroutesforthisdate,['I have no routes for this date.', 
                         'Jeg har ingen ruter for denne datoen.']).
cwc(in,['in','i']).


cwc(indirection,['in direction','i retning']):-
    myflags(smsflag,true),!.

cwc(indirection,['in direction','i retning']).


cwc(indirectiontowards,['towards',  'mot']):- 
    myflags(smsflag,true),
    !.

cwc(indirectiontowards,['in direction towards',  'i retning mot']).


cwc(indirectionfrom,['from', '  fra']):- 
   myflags(smsflag,true),
   !.

cwc(indirectionfrom,['in direction from', 
                        ' i retning fra']).
cwc(inthisperiod,['in this route period','i denne ruteperioden']).
                                                %% dont mix with time period
cwc(invitemore,['If you want more information, you may ask now, or end the conversation.',
                'Ønsker du flere opplysninger kan du spørre nå, eller avslutte samtalen.']).
                                                                    

cwc(irregularity,['changes in schedules',  
                  'ruteendringer']). 
cwc(irrelevant,['irrelevant','irrelevant']).
cwc(is,['is','er']).
cwc(isa,['is a ','er en ']). 

cwc(ismanyvalued,['is not unique','er flertydig']). 
cwc(it,['it','det']).


cwc(knownostations, 
     ['I have no information about its neighbour stations',
     'Jeg vet ikke om noen stasjoner i nærheten']). 
cwc(kroner,['NOK','kr']).

cwc(last,['last','siste']).
cwc(later,['later','senere']).
cwc(leaves,['leaves',forlater]).
cwc(leaving,['leaving','å gå av']).
cwc(length,[lengths,lengder]). %% nb plu  
cwc(luggage,['luggage or lost property', 
             'bagasje eller hittegods']). 

cwc(mayor,[mayor,burgermester]). %% :-)
cwc(map,[map,kart]). 
cwc(merry_christmas,['Merry Christmas','God jul']). 
cwc(meta,[text,tekst]). %% Technical
cwc(minute,['minute','minutt']).

cwc(minutes,['min.','min.']):- 
    myflags(smsflag,true),
 \+ myflags(dialog,1),!.  %% Talsmann 
cwc(minutes,['minutes','minutter']).

cwc(monday,['Monday','mandag']).
cwc(mondays,['Mondays','mandager']).

cwc(more,[more,flere]).  

cwc(must,['must','må']).

cwc(nopassages,['There are none passing then.','Det er ingen som passererer da.']).
cwc(notthestation, ['This route does not pass the station.', 
                    'Denne ruten passerer ikke stasjonen.']).

cwc(near,['near','nær']).

cwc(never,['never','aldri']).
cwc(neverpasses,['never passes ','passerer aldri ']). 
cwc(next,['next','neste']).

cwc(nocorresponse,['I cannot answer the request for correspondance',
                   'Jeg kan ikke besvare forespørsel om korrespondering']). 

cwc(nodatesX,[ 'Route data for this date is not available yet', 
               'Rutedata for denne dato er ikke tilgjengelig ennå']). 

cwc(nodirectroutes,['There are no direct routes ', 'Det er ingen direkteruter']).

cwc(nightbus,[' Nightbus', 'Nattbuss ']).   %% * nattbussen 106

cwc(nightbus0,[' night bus', 'nattbuss ']). %% -> the nightbus

cwc(no,['No.','Nei.']).
 


/*
cwc(misfjordeaster,
     ['Nightbus goes night to  Easter Sunday from O.Tryggvasons gt. at  0100,0200 and 0300  am.',
      'Nattbuss går natt til 1. påskedag fra O.Tryggvasons gt. kl 0100,0200 og 0300. ']). 


cwc(misfjordxmas, ['Nightbus goes from O.Tryggvasons gt.: 0100, 0200 and 0300 am.',
  'Nattbussen har følgende avganger 27.12 fra O.Tryggvasons gt.: 0100, 0200 og  0300. ']).


cwc(misfjordmessage, ['Nightbus goes from O.Tryggvasons gt.: 0100, 0200 and   0300 am.',
  'Nattbussen har følgende avganger 27.12 fra O.Tryggvasons gt.: 0100, 0200 og 300.']).

*/



cwc(nonightbusdepartures,['No nightbus on this date in holidays',
                'Det er ingen nattbusser på denne dato i helgen.']).
                   %%       'Det er ingen nattbusser på denne dato i helgen. (Bare natt til 27.12)']).
                        

cwc(nightbusdepartures,['The nightbus has the following departures from the center on the night to ',
                        'Nattbussen har følgende avganger fra O.Tryggvasons gt. natt til ']).


cwc(nightbusdeparturesshort,['The nightbus has the following departures from O.Tryggvasons gt.',
                        'Nattbussen har følgende avganger fra O.Tryggvasons gt.']).

                                                         
cwc(nobodyisperfect,['Nobody is perfect','Ingen er feilfri']).
cwc(noinformation,
     ['I have no information about',
      'Jeg har ingen informasjon om']).

%% cwc(nolonger,['There are no more','Det er ingen flere']). 

cwc(nolonger,['I cannot find any more connections',  
              'Jeg kan ikke finne flere ruteforbindelser']). %% .. på tirsdag.

cwc(nolongerperiod,['I cannot find any more connections.',
                    'Jeg kan ikke finne flere ruteforbindelser.']). %% .


cwc(nomark,['No,','Nei,']).
cwc(nomoreon,['There are no more on ', 'Det er ingen flere på ']). 
cwc(none,['none','ingen']).

cwc(nonightbusesthen, 
         ['There are no nightbuses.',
          'Det er ingen nattbusser.']).



cwc(noplaces,['No known stations','Ingen kjente stasjoner']).  
cwc(normally,['normally','vanligvis']).

cwc(noroutes,['I cannot find any connections','Jeg finner ingen ruteforbindelser']). 
 
cwc(nostation,['No bus stations','Ingen busstasjoner']). 
cwc(not,[not,ikke]).  

%% cwc(notpossible,['not possible','umulig']). % ? 

cwc(thatisagoodquestion,['That was a good question.', %%  :-) 
                         'Det var et godt spørsmål.']). %% det er et g.s.  :-)


cwc(thatisnotgood,['That is not good', 
                   'Det er ikke bra']).
cwc(notpossible,['That is not possible', 
                   'Det er ikke mulig']).

cwc(notpossibleon,['That is not possible on', 
                   'Det er ikke mulig på']).

cwc(notany,['no','ingen']). 
cwc(now,['now','nå']).
cwc(nowhere,['nowhere','ingen steder']).
cwc(nth(N),[Ord,Ord]) :- ordinal2(Ord,_,N).

cwc(number,['number','nr.']):- myflags(smsflag,true),!. %% // avoid No. 
cwc(number,['number','nummer']).

cwc(of,['of','i']).
cwc(ofa,['of a','til en']). 
cwc(ofabus,['of a vehicle','til et kjøretøy']). %%  (tram ?)
cwc(ofmonth,['a month','i måneden']). 
cwc(ofatrip,['of a trip','på en tur']).
cwc(ok,['OK','OK']).  
cwc(on,['on','på']).  
cwc(ondate,[' on ',' den ']). 
cwc(once,[once,'en gang']).
cwc(only,['only','bare']).

cwc(onlyonedestination,
    ['I can only answer for one destination at a time.', 
     'Jeg kan bare svare for ett reisemål av gangen.']). 

cwc(onlyonebus,['I can only answer for one  bus at a time.', 
                'Jeg kan bare svare for en buss av gangen.']).  %% ad?

cwc(onlyoneday,['I can only answer for one day at a time.', 
                'Jeg kan bare svare for  en dag av gangen. ']). %% ad? %% TA-110111

cwc(onlyoneplace,['I can only answer for one place at a time.', 
                  'Jeg kan bare svare for ett sted av gangen.']). %% ad?


cwc(onlyonething,['I can only answer one thing at a time.',  
                  'Jeg kan bare svare på en ting av gangen.']). %% ad?

cwc(onlyonesentence,['I can only answer one sentence at a time.', 
                     'Jeg kan bare svare på en setning av gangen.']). %% ad?

cwc(onthecontrary,['No, on the contrary.', 'Nei, tvertimot.']). %%  :-)


cwc(onthisday,['on this day','på denne dagen']). 

cwc(picture,[picture,bilde]).

cwc(put,[placement,plassering]). %% T-100308 the verb as action

cwc(the_routes_on,['The routes on ','Rutene ']).  

cwc(theneareststationto,['The station nearest to', 
                         'Holdeplassen nærmest']). 

cwc(todayis,['Todays day: ','Dagen idag: ']). 

cwc(toolate,['Time of notification has already passed.',  
             'Tidspunkt for varsling er allerede passert.']).

cwc(toomanyplaces,['I can not handle so many places at a time !', 
                   'Jeg kan ikke svare for så mange steder av gangen !']). 

cwc(or,['or','eller']).

cwc(otherbus, ['other route company. ',   
               'andre ruteselskap enn AtB ']).   
cwc(passes,['passes by ','passerer ']). 
cwc(passing,['passing','passerer']).
cwc(past,[past,forbi]).           %% not past time 
cwc(phonehelp,['Bustuc has phone number  73511348.','Busstuc har telefon 73511348.']). 
cwc(ping,[ping,ping]).            %%  :-)
cwc(pong,[pong,pong]).            %%  :-)
cwc(possalternatives,  
    ['Possible alternatives are:', 'Mulige alternativer er:']).
cwc(place,['place','sted']).
cwc(precize,['Please use a more specific name.',  
             'Vennligst bruk et mer presist navn.']). 

cwc(probably,['probably','sannsynligvis']).
cwc(questions,['questions','spørsmål']).
cwc(routes,['routes','ruter']).

cwc(ruteopplysningen,['Route Information','Ruteopplysningen']). 
cwc(saturday,['Saturday','lørdag']).
cwc(saturdays,['Saturdays','lørdager']).

cwc(say,['say','si']).
cwc(size,[size,størrelse]).
cwc(sorryno, ['Unfortunately, I can not show you any',
              'Jeg kan dessverre ikke vise noe']).

cwc(spacename,[spacename, 'navn på område' ]). %% utgang/toalett/ etc 

cwc(special_ticket,['special tickets','spesielle billetter']).

cwc(specificdays,['routes on this date', 
                  'ruter på denne datoen']). 
cwc(specify,['specify','oppgi']).


%% except Easter holiday
cwc(standnight,['The Nightbus goes only  night to Saturdays and  Sundays.',
                'Nattbussen går  bare natt til lørdag og søndag. ']).
                                              %% unntatt i påskehelgen

cwc(station,['station','holdeplass']). 
cwc(stations,['stations','holdeplasser']).

cwc(strikeison,['The bus drivers are now on strike', 
                'Bussjåførene er for tiden i streik']). %%

cwc(submarines,['submarines','ubåter']).
cwc(such,['such','slike']).


cwc(sunday,['Sunday','søndag']).
cwc(sundays,['Sundays','søndager']). 
cwc(swim,['swim','svømme']).

cwc(takes,['takes','tar']).
cwc(tao,[unkown,ukjent]). 

cwc(team,['Team traffic','Team trafikk']). 

cwc(tell,['tell','fortelle']).
cwc(thanks,['Thanks.','Takk.']). 
cwc(that,['that','det']).
cwc(thatisimpossible,['That is not possible.','Det er ikke mulig.']). 
cwc(thatisunclear,['That is unclear.','Det er uklart.']). 
cwc(thatmeans,['that means','det betyr at']).
cwc(the,['the','den']).
cwc(thereafter,[thereafter,'like etterpå']). 
cwc(therearenodeparturesfor,['There are no departures for','Det er ingen avganger for']). 
cwc(thebus,['the bus','bussen']). 
cwc(thebuses,['the buses','bussene']).
cwc(thenightbus,['the nightbus','nattbussen']). 
cwc(thenightbuses,['the nightbuses','nattbussene']). 
cwc(thecolour,['the colour','fargen']).
cwc(thedate,['the date','datoen']).
cwc(thefirst,['the first','første']).
cwc(thelast,['the last','siste']).
cwc(thenext,['the next','neste']).
cwc(theprice,['the price','prisen']).
cwc(therearenone,['there are no departures','det er ingen avganger']). 
cwc(thesame,['the same','samme']).
cwc(thespeed,['the speed','hastigheten']).
cwc(there,['there','det']).
cwc(thestation,['the station','holdeplassen']).  
cwc(thestations,['the stations ','holdeplassene ']). 
cwc(theweather,['the weather','været']).
cwc(theplace,['The place','Stedet']). 
cwc(thetime,['the time','klokka']).
cwc(this,['this','dette']).
cwc(thisdate,['this date','denne dato']).
cwc(thursday,['Thursday','torsdag']).
cwc(thursdays,['Thursdays','torsdager']).
cwc(timeout,['I could not find any connections in time',
             'Jeg klarte ikke å finne noen forbindelser i tide']).
             
cwc(to,['to','til']).
cwc(tram,['tram','trikk']). 
cwc(trams,['trams','trikker']).
cwc(tramstation,['tramstation',trikkestasjon]).
cwc(tuesday,['Tuesday','tirsdag']).
cwc(tuesdays,['Tuesdays','tirsdager']).
cwc(unknown,['unknown','ukjent']).
cwc(user,[user,bruker]). 
cwc(bag,[bag,veske]).  
cwc(via,[via,via]).
cwc(yes,['Yes.','Ja.']). 
cwc(yesmark,['Yes,','Ja,']).
cwc(you,['you','du']).
cwc(you_acc,['you','deg']).
cwc(you_are_welcome,['You are welcome.','Vær så god.']). 
cwc(youarenotified,['Notification at','Varsel kl']). 
cwc(youknow,['you know','vet du']).

cwc(waddyathink,['I suppose so','Jeg antar det']).
cwc(walking_distance,['walking distance','gangavstand']). 
cwc(wednesday,['Wednesday','onsdag']).
cwc(wednesdays,['Wednesdays','onsdager']).
cwc(when,['when','når']).
cwc(why,['Why  ?','Hvorfor ?']).   
cwc(whynot,['Why not ?','Hvorfor ikke ?']). 
cwc(with,['with','med']). 
cwc(withthat,['with this','med denne']). 
cwc(wonderful,['Wonderful','Flott']). 
cwc(work,[work,arbeide]).  %% verb/noun? 
cwc(would,['would','ville']).

%% ? for Talsmann Prosody

% EH-031015 RealSpeak tilpasninger er gjort nedenfor: "ønsker du" --> "vil du ha"

cwc(askfor(when),['When do you wish to travel ?', 'Når ønsker du å dra ?']).  %%  Talsmann ...
cwc(askfor(when),['When do you wish to travel ?', 'Når vil du dra?']).		%% EH-031014 RealSpeak...
cwc(askfor(whenis::departure),['What time of departure do you wish ?', 'Når vil du ha avgang?']).		%% EH-031014 RealSpeak...
cwc(askfor(whenis::arrival),['When do you wish to arrive ?', 'Når vil du ankomme ?']).
cwc(askfor(whenis::day),['Which day do you want to travel ?', 'Hvilken dag vil du dra ?']).
cwc(askfor(where::direction), ['In what direction do you wish to travel ?', 
                               'I hvilken retning vil du dra ?']).

cwc(askfor(bus),['What bus do you want to take ?',
             'Hvilken buss vil du bruke ?']).


cwc(askfor(where),['Where do you want to travel ?',
             'Hvor vil du reise ?']).
cwc(askfor(where::arrival),['Where do you want to go to ?',
             'Hvor vil du reise til ?']).
cwc(askfor(where::departure),['Where do you want to travel from ?',
             'Hvor vil du reise fra ?']).

/* %% EH-030115

cwc(askfor(when),['When do you wish to travel ?', 'Når ønsker du å dra ?']).
cwc(askfor(whenis::departure),['What time of departure do you wish ?', 'Når ønsker du avgangstid ?']).
cwc(askfor(whenis::arrival),['When do you wish to arrive ?', 'Når ønsker du å ankomme ?']).
cwc(askfor(whenis::day),['Which day do you want to travel ?', 'Hvilken dag ønsker du å dra ?']).
cwc(askfor(where::direction), ['In what direction do you wish to travel ?', 
                               'I hvilken retning ønsker du å dra ?']).

cwc(askfor(bus),['What bus do you want to take ?',
             'Hvilken buss ønsker du å bruke ?']).


cwc(askfor(where),['Where do you want to travel ?',
             'Hvor ønsker du å reise ?']).
cwc(askfor(where::arrival),['Where do you want to go to ?',
             'Hvor ønsker du å reise til ?']).
cwc(askfor(where::departure),['Where do you want to travel from ?',
             'Hvor ønsker du å reise fra ?']).
*/



%% START TELEBUSTER

cwc(norecordsfound, ['Could not find any matching records','Kan ikke finne noen som svarer til søket']).




cwc(tellnumber(No), L) :-
	cwc(numrecords(No),L),
   nl. 

cwc(numrecords(10000), ['cannot find that number', 'kan ikke finne det antallet']):-!.
cwc(numrecords(Count),[Eng, Nor]) :-
	append_atomlist(['there are ', Count, ' records that matches the query'],Eng),
	append_atomlist(['jeg finner ', Count, ' poster som svarer til søket'],Nor).

cwc(tomanytolist, ['Cannot list so many records', 'Kan ikke liste så mange poster']).

cwc(telebuster,['Telebuster', 'Telebuster']).


%% Fieldnames:
cwc(field(attributes::Slot),L) :- cwc(field(Slot),L).



cwc(cn,['name','navn']).
cwc(sn,['family name','etternavn']).
cwc(givenname,['first name','fornavn']).
cwc(telephonenumber,['telephone number', 'telefonnummer']).
cwc(ou,['department','avdeling']).
cwc(mail,['e-mail', 'e-post']).
cwc(mailaddress,['e-mail', 'e-post']). %% NEC ??? 
cwc(title,['title', 'tittel']).
cwc(roomnumber,['room number','romnummer']).
cwc(street,['street','gate']).      %%  (-> streetaddress)
cwc(streetaddress,['street address','gateadresse']). %%
cwc(count,['number of posts','antall poster']).
cwc(unknown,['unknown field','ukjent felt']).


cwc(field(cn),['name','navn']).
cwc(field(sn),['family name','etternavn']).
cwc(field(givenname),['first name','fornavn']).
cwc(field(telephonenumber),['telephone number', 'telefonnummer']).
cwc(field(ou),['department','avdeling']).
cwc(field(mail),['e-mail', 'e-post']).
cwc(field(mailaddress),['e-mail', 'e-post']). %%  NEC ??? 
cwc(field(title),['title', 'tittel']).
cwc(field(roomnumber),['room number','romnummer']).
cwc(field(street),['street address','gateadresse']).
cwc(field(count),['number of posts','antall poster']).
cwc(field(unknown),['unknown field','ukjent felt']).




cwc(unknownfield,['I don\'t have the answer to that question','Jeg har ikke svaret på det spørsmålet']).

% alternative fieldnames
cwc(field(pname),L) :- cwc(field(cn),L).
cwc(field(lastname),L) :- cwc(field(sn),L).
cwc(field(firstname),L) :- cwc(field(givenname),L).
cwc(field(department),L) :- cwc(field(ou),L).
cwc(field(telephone),L) :- cwc(field(telephonenumber),L).





%% the  (attribute in determined form)

cwc(the(attributes::Slot),L) :- cwc(the(Slot),L),!.


cwc(the(spacename),['the space name','navnet på stedet']). %% toalettet

cwc(the(cn),['the name','navnet']).
cwc(the(sn),['the family name','etternavnet']).
cwc(the(givenname),['the first name','fornavnet']).
cwc(the(telephonenumber),['the telephone number', 'telefonnummeret']).
cwc(the(ou),['the department','avdelingen']).
cwc(the(mail),['the e-mail', 'e-postadressen']).
cwc(the(title),['the title', 'tittelen']).
cwc(the(roomnumber),['the room number','romnummeret']).
cwc(the(street),['the street address','gateadressen']).
cwc(the(unknown),['the unknown field','det ukjente feltet']).

cwc(the(pname),L) :- cwc(the(cn),L).
cwc(the(lastname),L) :- cwc(the(sn),L).
cwc(the(firstname),L) :- cwc(the(givenname),L).
cwc(the(department),L):-cwc(the(ou),L).
cwc(the(telephone),L) :- cwc(the(telephonenumber),L).


cwc(then,[then,da]). 

cwc(doyouknow,['do you know','vet du']).
cwc(please_state,['please state','vennligst oppgi']).

cwc(searchingfor(Field),[Eng, Nor]) :-
	cwc(the(Field),[EngTheField, NorTheField]),
	append_atomlist(['searching for ', EngTheField,' of the person with: '],Eng),
	append_atomlist(['leter etter ', NorTheField, ' til personen med:  '], Nor).



cwc(cantfind, ['can\'t find anyone with','finner ingen med']).
cwc(butitis, ['but there is','men det er']).
cwc(matchingrecords, ['records that matches','poster som svarer til']).
cwc(ison, ['is on', 'er på']).

%% END TELEBUSTER


cwc(dialogerror,['I don\'t understand',
             'Jeg skjønner ikke']).

cwc(which,['Which', 'Hvilken']).

cwc(tbs_welcomegreeting, ['Welcome to the Tabor-project bus route information.',
                          'Velkommen til Tabor-prosjektets ruteopplysning.']).
cwc(tbs_welcomequestion,['Do you know how the system works?','Vet du hvordan systemet virker?']).
cwc(tbs_userhelp, ['Please try to express yourself in simple sentences',
                   'Forsøk å uttrykk deg så enkelt som mulig']).
cwc(tbs_whentotravel, ['Please state a time.', 'Vennligst angi tidspunkt.']).
cwc(tbs_deporarr, ['do you wish depature or arrival at', 'ønsker du avgang eller ankomst kl']).
       	
cwc(tbs_askref_from, ['do you wish to travel from', 'ønsker du å dra fra']).
cwc(tbs_askref_to, ['do you wish to arrive at', 'ønsker du å ankomme']).
cwc(tbs_askref_day, ['do you wish to travel on', 'ønsker du å dra på']).
cwc(tbs_asknewtime, ['do you wish to state a new time', 'ønsker du å oppgi et nytt tidspunkt?']).
cwc(tbs_asknewbusconnection, ['Do you wish more information about a new bus connections?', 
                               'ønsker du opplysninger om en ny bussforbindelse?']).
cwc(tbs_endmsg, ['can I help you with something else?', 'kan jeg hjelpe deg med noe annet?']).
cwc(tbs_whichday, ['Which day do you wish to travel?', 'Hvilken dag ønsker du å reise?']).
cwc(tbs_wishtime, ['Do you want timeinformation?', 'Ønsker du opplysninger om tiden?']).
cwc(tbs_askref_day, ['Do you wish to travel on', 'Ønsker du å dra på']).
cwc(tbs_fromwhere, ['where do you wish to travel from?', 'hvor ønsker du å dra fra?']).
cwc(tbs_towhere, ['where do you wish to travel to?', 'hvor ønsker du å dra til?']).


%% Last after explicit defs 

cwc(G,[G,N]):- 
    dict_n:noun2(N,G).

cwc(G,[G,N]):- 
    dict_n:noun3(N,G,_). %% hjul 



cwc(N,[N,N]):-number(N). 
cwc(M,[N,N]):-known_name(M),specname(M,N). 



% Skriver feilmelding dersom mapping mangler
cwcerror(Con,[Con,'???']) :-
    !.

% % % % % % % % % % % % 

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



monthshort(1, 'Jan.', 'Jan.').
monthshort(2, 'Feb.', 'Feb.').
monthshort(3, 'Mar.', 'Mar.').
monthshort(4, 'Apr.', 'Apr.').
monthshort(5, 'May.', 'Mai'). %% TA-110202 not short
monthshort(6, 'Jun.', 'Jun.').
monthshort(7, 'Jul.', 'Jul.').
monthshort(8, 'Aug.', 'Aug.').
monthshort(9, 'Sep.', 'Sep.').
monthshort(10,'Oct.', 'Okt.').
monthshort(11,'Nov.', 'Nov.').
monthshort(12,'Dec.', 'Des.').


streetspecname(X,N):-streetstat(X,N,_,_,_),!.  %% NB NOT FIRST ORDER NORMAL FORM 

xspecname(XXXX,XX):-  
    myflags(dialog,1), 
    specname(XXXX,XX).
 


xspecname(XXXX,XX):-  %% NB ??????????
    \+ myflags(dialog,1), 
    myflags(smsflag,true),
    short_specname(XXXX,XX).
 


xspecname(TMN_S,S):-
    specname(TMN_S,S),
    !.

xspecname(TMN_S,S):-
%%    routedomain(D), 

   myflags(actual_period, M),

%%    route_period(D,M,_,_), %% NO, current route domain!!!!

   M \== nil,  
   M:hpl(_,_S0,TMN_S,S),
   !.



specname0(S0,S):- specname(S0,S),!.
specname0(S0,S):- bigcap(S0,S).  

ordinal2(X,Y,Z):-dict_module(D),D:ordinal2(X,Y,Z).


description(thing,tao):-!. 

description(date(_,_,_),date):-!.

description(X,Z):-
    X ako Z,
    !.

description(X,Z):-
    fact(X isa Z),
    !.

description(_,unknown). 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






% HELP Predicates in user for bustrans


special_day(holiday).
special_day(easterhol).
special_day(eastereve).


numberofnextbuses2(_,2):-    %% neste -> neste 2 SMS
     myflags(smsflag,true),!. 
numberofnextbuses2(Default,Default).


%% obsol
numberofnextbuses(2):- myflags(smsflag,true),!.
numberofnextbuses(1).


sorttimes(T1,T2,T2,T1):- 
    number(T1),
    number(T2),
    T1 > T2,
    !.
sorttimes(T1,T2,T1,T2).



%%  A free bus or person  

busman(X,bus):-  user:busorfree(X).
busman(_X,P):- user:subclass0(P,agent).

corresporder(next,N,next(N)). % => keepafter
corresporder(first,N,first(N)). 

corresporder(last,N,last(N)).  % => keepbefore
corresporder(previous,N,previous(N)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

evening_time0(X,Y):-  %% Inclusive
    \+ myflags(nightbusflag,true), 
    number(X),
 (  X <  0100 -> Y is X + 1200;   %% halv ett -> 1230
    X =< 1200 -> Y is X + 1200; %% NO default here
                 Y is X).

evening_time0(X,Y):- 
    myflags(nightbusflag,true),    %% Inclusive 
    number(X),
 (  X <  0100 -> Y is X + 2400;  %% night at 1
    X =< 1200 -> Y is X + 1200; %% NO default here
                 Y is X).

evening_time(X,Y):- 
    \+ myflags(nightbusflag,true), %% Exclusive (fail if evening) 
    number(X),
 (  X <  0100 -> Y is X + 1200;   %% halv ett -> 1230
    X =< 1200 -> Y is X + 1200). %% NO default here

evening_time(X,Y):- 
    myflags(nightbusflag,true),    %%  Exclusive (fail if evening)
    number(X),
 (  X <  0100 -> Y is X + 2400;  %% night at 1
    X =< 1200 -> Y is X + 1200). %% NO default here


evening_time24(NOW,X,Y):-  
    \+ myflags(nightbusflag,true), %% Exclusive (fail if evening) 
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
     user:newfree(Bus),
     !. 

i_or_a_bus(_I,Self,Bus):-
     (Self == agent    
      ;                     %% man (interface << system << agent )  
     testmember(Self,[person,self])), %% subclass0(Self,person)),
     !,                              %% hvordan er min mor
     newfree(Bus),
     !. 

i_or_a_bus(B52,Bus,B52):- 
    user:bound(B52),
    !,
     (user:subclass0(Bus,vehicle) %% not station 
          ; Bus=route_plan
          ; Bus=number),  
    !.

i_or_a_bus(Bus,_bus,Bus):- 
    dmeq(vehicle,_bus),   %%  _Bus ikke station  hpl på huseby 
    user:unbound(Bus),
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
    \+ myflags(samedayflag,true),
    !.

anotherday(_Day):- 
    todaysdate(D0), %% datecalc
    myflags(actualdate,D1),
    \+ (D0=D1),
    !.




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% PARAPHRASE


paraphrase(L):- 
	myflags(teleflag,true),
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
   \+ myflags(directflag,true),
   write_relevant_messages(Prog),
   paraphrase_changes(L),
   nl. 

paraphrase2(Prog,L):-      %% Both Important messages and Paraphrase
   myflags(directflag,true), 
   !,
   myflags(directoutputfile,Newans),
   tell(Newans),
   output('*** Paraphrase ***'), %%%%%%%%%%% <-
   nl,
   write_relevant_messages(Prog),
   paraphrase_changes(L),
   nl,nl.  

%%   told. %% Keep it open



paraphrase_tele(_Prog,_L):-  
   \+ myflags(directflag,true),
   !,
   true.        %% Pro forma   

paraphrase_tele(_Prog,_L):-    %% Pro forma, open dir outout file   
   myflags(directflag,true), 
   !,
   myflags(directoutputfile,Newans),
   tell(Newans),
   output('*** Paraphrase ***'), %%%%%%%%%%% <-
   nl.

%%   told. %% Keep it open





write_relevant_messages(Prog):-
    for(
        roundmember(message(X),Prog),
       (relevant_message(X) -> printmessageunconditionally(X)
                             ; true)).

relevant_message(nearest_station(_,_,_)). %% this before .. You will go
                                        
relevant_message(illegaldate).  
relevant_message(noinfoabout(_)).        %%  noinfoabout(nightbus) appears twice
relevant_message(howtuchelp).            %%
relevant_message(nonightbus).            %%  buster

relevant_message(foreign(_)). 
relevant_message(noroutesto(_)).  




paraphrase_changes([]):-!.

paraphrase_changes(X):- 
    \+ roundmember(frame_setvalue(_,_),X),
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
    for( member(Y,L),paraph2(Y)).



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

paraph1(frame_setvalue(whenis::departure::after,T)):- 
    morning_break(T0430), 
    T==T0430, % most probably a soft constraint
    !,
    doubt(' with the first bus',' med første buss').


paraph1(frame_setvalue(whenis::arrival::after,T)):-  
    morning_break(T0430),
   T==T0430, % most probably a soft constraint
   !,
   doubt(' with the first bus',' med første buss'). 



paraph1(frame_setvalue(whenis::departure::after,T)):-
   !,
   doubt(' after ',' etter klokken  '),bwt(T). %%  Talsmann   kl. 1840 to be spoken out.



% DEP BEFORE

%%%%%% RS-111118

paraph1(frame_setvalue(whenis::departure::before,T)):- 
   T==2500,
   !,  %% SOFT CONSTRAINT, Not Verified
   doubt(' with the last bus',' med siste buss'). 

paraph1(frame_setvalue(whenis::departure::before,T)):- 
   !,
   doubt(' before','  før klokken '),bwt(T).

% ARR  AFTER

paraph1(frame_setvalue(whenis::arrival::after,T)):-
   !,
   doubt(' after ',' etter klokken '),bwt(T).  %% Talsmann 

% ARR BEFORE

paraph1(frame_setvalue(whenis::arrival::before,T)):-
   T==2500,
   !,  %% SOFT CONSTRAINT, Not Verified
   doubt(' with the last bus',' med siste buss.'). 


paraph1(frame_setvalue(whenis::arrival::before,T)):-
   !,
   doubt(' before ',' før klokken '),bwt(T). %% Talsmann 


%%%%%% RS-111118

paraph1(frame_setvalue(day,T)):- 
   !,
   doubt(' on',' på '),bcp(T). 

paraph1(frame_setvalue(whenis::day,T)):- % old, kept
   !,
   doubt(' on ',' på '),bcp(T). 



paraph1(frame_setvalue(date,T)):- %% moved out
   !,
   doubt(' on ',' den '),writedate(T). 


paraph1(frame_setvalue(whenis::date,T)):-     %%  old, kept
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




%% dialog/parseres ???


writefields(F):- var(F),!,write('¤ variable ¤').
 

writefields([F]):-   % telf
   !,
   writefield1(F). 

writefields([F,G]):-  % telf og email
   !,
   writefield1(F),
   bcp(and),write(' '), 
   writefield1(G). 

writefields([F,G|H]):- % telf, email and room
   writefield1(F),   
   !,
   write(', '),
   writefields([G|H]).

writefields([]):-!.

writefields(_):- write(' ??? '). %% catchall

writefield1(unknown):-
    !, 
    bcp(unknownfield).

writefield1(F):- 
    ldaptotuc(F,G),!, 
    bcp(G),write(' '),!.

writefield1(F):- bcp(F),write(' '),!. %% bcp(field(F))

writefield1(_):- write(' ??? '). %% catchall

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SECTION    BASIC WRITE %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predikat som skriver ut navn og tall etc.  bwr*


bwrprices([Ad,Ch]):-
    moneyunit(nok), % both languages
    !,
    bwr(Ad),bcp(or),bwr(Ch),bcp(kroner).

bwrprices([Ad,Ch]):-
    moneyunit(usd), % both languages
    !,
    bwr(Ad),write('$'),bcp(or),bwr(Ch),write('$').

bwrprices([Ad]):- %% Unit Price 
    moneyunit(nok), % both languages
    !,
    bwr(Ad),bcp(kroner).

bwrprices([Ad]):-  %% Unit Price 
    moneyunit(usd), % both languages
    !,
    bwr(Ad),write('$').

bwrprices(Price):-  bwr(or(Price)).





%
% Round lists

bwrsinglelist(Elem) :-
        atomic(Elem),bwr(Elem).


bwrsinglelist((Elem1,Elem2)) :- % Round lists...
        atomic(Elem2),bwr(Elem1),
        %%%  bcp(and), %% (tore,amble) \#-> Tore and Amble 
        bwr(Elem2).


bwrsinglelist((Elem,List)) :-
        bwr(Elem),comma,bwrsinglelist(List).

% Square lists  % a,  b, c and d

bwrsinglelist([Elem1,Elem2|List]) :- %% Max 12 with SMS
     myflags(smsflag,true),
     length(List,Leng),Leng > 10,
     !,
     bwr(Elem1),comma,
     bwr(Elem2), write(' ,...,'), 
     lastmems(2,List,LX),  
     bwr(LX).

bwrsinglelist(E):-
    portionlist(E).


bwrsinglelist([Elem]) :-
    !,
    bwr(Elem).

bwrsinglelist([Elem1,Elem2]) :-
    !,
    bwr(Elem1),bcp(and),bwr(Elem2).

bwrsinglelist([Elem|List]) :-
    !,
    portionlist([Elem|List]).

%% writesimplelist %% TA-110110

writesimplelist([Elem1,Elem2|List]) :-!,
        write(Elem1),out(','),writesimplelist([Elem2|List]).
writesimplelist([Elem1]):-write(Elem1),!,nl.
writesimplelist([]):-!.

writesimplelist(E) :-write(E),nl.

% Square or lists

bwrsingleorlist([Elem]) :-
        bwr(Elem).
bwrsingleorlist([Elem1,Elem2]) :-
        bwr(Elem1), bcp(or), %% bcp(and), ØF-990908
        bwr(Elem2).
bwrsingleorlist([Elem|List]) :-
        bwr(Elem),comma,bwrsingleorlist(List).

% Round or lists

bwrsingleorlist(Elem) :-
        atomic(Elem),
        !,
        bwr(Elem).
bwrsingleorlist((Elem1,Elem2)) :- % Round lists...
        atomic(Elem2),bwr(Elem1),  bcp(or), %% bcp(and), ØF-990908
        bwr(Elem2).
bwrsingleorlist((Elem,List)) :-
        bwr(Elem),comma,bwrsingleorlist(List).



bwrbus(_Bus_,One):-  
     exbusname(One,Klaburuta),
     !,
     bwr(Klaburuta).   

bwrbus(number,One):- 
    exbusname(One,Klaburuten),
    !,
    bwr(Klaburuten).   

bwrbus(Bus,One):- 
    bcp(Bus),
    bwrbusno(One).


bwrbusbc(_Bus_,One):- 
     exbusname(One,Klaburuta),
     !,
     bwr(Klaburuta).   

bwrbusbc(number,One):- 
    bcpbc(number), 
    bwrbusno(One).

bwrbusbc(Bus,One):- 
    bcpbc(Bus),
    bwrbusno(One).

bwrbusno(One):- 
    xbusname0(One,Klaburuta),
    bwr(Klaburuta).             

xbusname0(One,Klaburuta):-
    exbusname(One,Klaburuta),
    !.%% -> busdat.pl
xbusname0(One,One).

%% exbusname(254,'Klæburuta'). %% -> busdat.pl



                   
bwr2bc(One):-vehicletype(One,Bus), !,bcpbc(Bus),bcp(One),!. 
bwr2bc(One):-bcpbc(One).


% No leading blank 


bwrbc(X)     :- xspecname(X,N),!, bigcap(N,NN),  out(NN). %% TA-110103
bwrbc(X)     :- cname(X,N),!,         out(N). 
bwrbc(X)     :- streetspecname(X,N),!,out(N).

bwrbc(X)     :- %%  'kofod petersen' -> Kofod Petersen
    atom(X),  %% ** tempe_street-11 %% TA-101102
    splitdoublename(X,Y),
    !,
    out(Y). 
 
bwrbc(X):-bwr(X). %% TA-101102
 
bwrbc(X)     :- bigcap(X,N),!,    out(N). %% Default    

 


% Øyvind Krøvel-Velle Standal.
% Øyvind Krøvel velle -> Øyvind Krøvel Velle
  


splitdoublename(X,Y):- 
    name(X,List),
    testmember(32,List), %% blank %% short test
    !,
    splatom(List,List2),
    name(Y,List2).


%% New,   List with Class, small caps 

bwr2([],Class):- !,bcpbc(notany),bcp(Class).

bwr2([X],buses) :- !, %% Trikk 1 / Buss 2
    busortram(X,BT),bcp(BT),bwr(X).

bwr2(List,departure):- !,bwtimes(List),space. 

bwr2(List,_):- bwrsinglelist(List),space.





%% ...................


realspeak_comma:- myflags(dialog,1),write(', '). %% For better prosody/ pause
realspeak_comma.


/*
splatom(L,L1,L2) :- %% Expensive
     append(U,L2,L),
     append(L1,[32],U).
*/


splatom([K|L],[K1|L1]) :-
    uppercase0(K,K1),  
    splat(L,L1).

splat([32,K|L],[32,K1|L1]):-
    K \== 32,
    uppercase0(K,K1),
    splat(L,L1).  

splat([32,K|L],[K|L1]):-
    K == 32,
    splat(L,L1).


splat([K|L],[K|L1]):-
    K \== 32,
    !,
    splat(L,L1).  

splat(L,L). %% default includes []



uppercase0(K,K1):-
    uppercase(K,K1),
    !.
uppercase0(K,K).

uppercase(K,K1):-
    K >=97,K =< 122,!, K1 is K -32.
uppercase(198,230).
uppercase(248,216).
uppercase(229,197).


%%% bwrstreet(yggdrasil_street-9) ?   -> Yggdrasilvegen 9 

convert_int_street(Y-N,EY9) :- 
    
    once1(streetstat(Y,YY,_,_,_)),
    !,
    append_atoms(YY,' ',YYB), %% NB   append_atoms ' ' + 9 = 9
    append_atoms(YYB,N,EY9).


convert_int_street(Y-N,EY9):- %% Unknown
    !,
    append_atoms(Y,' ',YYB),
    append_atoms(YYB,N,EY9).

convert_int_street(Y,YY):- %% No Number 
    once1(streetstat(Y,YY,_,_,_)),
    !.


convert_int_street(_,nil):- %% Missing/Unknown
    !.




bwrstreet(X-N) :- bwr(X),write(N),space,!. 
bwrstreet(X)   :- bwr(X). 


%% BCP   Basic Common Words

outcap(X):-
    bigcap(X,Y),
    write(' '),
    out(Y). 
 
bcpbc(Con) :- 
	 (cwc(Con,Phrases);cwcerror(Con,Phrases)),
	 languagenr(LN), 
	 nth(LN,Phrases,Phrase),
	 bigcap(Phrase,BCPhrase),
	 out(BCPhrase), 
    !.   % Write once

bcpbc(_) :-  write(' *** '). 


bcp(Con) :-
	 (cwc(Con,Phrases);cwcerror(Con,Phrases)),
	 languagenr(LN),
	 nth(LN,Phrases,Phrase),
%%%%%    space,  %% Space first  Experiment %% Jeg--har ingen ruter 
	 write(Phrase),
    space,  
	 !.   % Write once

bcp(_):- write(' ** '). 




% New  List with Class, Big caps

bwc([],Class):- !,bcpbc(notany),bcp(Class).
bwc([X],buses) :- !, %% Trikk 1 / Buss 2
    busortram(X,BT),bcpbc(BT),bwr(X).

bwc(List,buses):- !,portionlist(List),space.  

bwc(List,_):- bwrsinglelist(List),space. 


bcw(bus,List):-!,portionlist(List),space. 
bcw(route,List):-!,portionlist(List),space. 
bcw(station,List):-!,portionlist(List),space.

bcw(_,List):- \+ myflags(smsflag,true),!,portionlist(List),space. 
bcw(_,List):- bwrsinglelist(List),space. 


%% bwstat2(Intname,Offname) %% TA-110505

bwstat2(X,N)     :- xspecname(X,N),!.
bwstat2(X,N)     :- cname(X,N),!.   
bwstat2(X,N)     :- bigcap(X,N),!.
  


%% bwr    %% 


bwr(V):- var(V),!,write('X? '). %% capture loop  error 

bwr(_TT_:X):-!,bwr(X). %% TMN

bwr(date(Year,Month,DayNr)) :- %% TA-110519
    writedate(date(Year,Month,DayNr)).

bwr(unknown) :-!,bcp(unknown). 


%% Update reference for all relevant items that are printed
bwr(X) :- user:myflags(dialog, 1), 
          atomic(X), 
          X isa Type, 
          \+  Type=number, %% uninteresting as reference 
          getcurrent(Cid), addref(Cid, X, Type),
          false.  %% it is meant to backtrack

bwr(X)     :- X=STOG-N,streetstat(STOG,_,_,_,_),
              !,
              bwr(STOG),write(N),space, realspeak_comma.  

bwr(X-Y)   :- !,  bwr(X),bwr(-),bwr(Y).

bwr([nostation]):-!, bcp(nostation).    

bwr(X)     :- internalkonst(X),!,bcp(that),space.  
bwr(or(X)) :- !,bwrsingleorlist(X),space.
bwr(X)     :- islist(X),!, %% compound(X),!, %% built-in 
              portionlist(X). %%  bwrsinglelist(X). 



bwr(X)     :- streetspecname(X,N),!,write(N),space,realspeak_comma. 

bwr(X)     :- compound(X),!, write('***'),nl. 

% ',' for better Realspeak Prosody


bwr(X)     :- X==so_on,!,getphrase0(X,N),write(N),space. %% Special:  så videre,  lowercase 
bwr(X)     :- xspecname(X,N),!,    write(N), space,realspeak_comma. %% Holdeplassnavn 
bwr(X)     :- cname(X,N),!,        write(N), space,realspeak_comma.


bwr(X)     :- bigcap(X,N),!,   %%  space, 
               write(N),space, realspeak_comma. 




bwr(X)     :- %% space,  
              write(X).  %% DEFAULT

%%

bwq(X) :- write(X). %% no space  


bw1(X-Y) :- myflags(dialog,1),write(X),bcp(to),space,write(Y). %% RealSpeak

bw1(X)     :- space,write(X),space.  %% NEW Predicate No add ref

%%%

busortram(X,tram):-vehicletype(X,tram),!. 
busortram(_,bus).

%% Print times including clock (kl.). %% For pronounciation 


bwtimes2([Elem]) :- 
        bwt2(Elem).

bwtimes2([Elem1,Elem2]) :-
        bwt2(Elem1),space,bcp(and), bwt2(Elem2).
bwtimes2([Elem|List]) :-
        bwt2(Elem),comma,bwtimes2(List).

bwt2(nil):-write('***'),!. %% Error 
bwt2(T):-bcp(attime),bwt(T).



%% Print out Time HHMM

bwtimes([Elem]) :-
        bwt(Elem).
bwtimes([Elem1,Elem2]) :-
        bwt(Elem1),bcp(and),bwt(Elem2).
bwtimes([Elem|List]) :-
        bwt(Elem),comma,bwtimes(List).


bwt(nil):-write('***'),!.

bwt(T) :- \+ number(T),!,write(T).

bwt(T) :-
    T >= 2500,
    !,
    write(T). %% 9999, not 399

bwt(T) :- 
     T > 2400, 
     !, %% changed from 2359 
     NewT is T - 2400,
     bwt(NewT). %  0002 til

bwt(T) :- bwt1(T),space.


bwt1(T0) :- 
    language(norsk), 
    myflags(dialog,1), %% 14:00 format for speech synthesis
    !,
%%%%%%%%%%%%    space,  kl.  1530 %% TA-101110

   ( T0 > 2400 ->  T is T0 - 2400; T is T0),

     HH is T//100,
     MM is mod(T,100),
 
%%    bwt00(HH),write(':'), bwt00(MM), realspeak_comma.  %% EH-031015 Bedre syntese.
    bwt00(HH), write('.'), bwt00(MM), realspeak_comma.  %% RS-111025 IKKE! Bedre syntese.

bwt1(T0)     :-  
    language(norsk), 
%%%%%    space, ,  kl.  1530 %% TA-101110

   ( T0 > 2400 ->  T is T0 - 2400; T is T0),
 
   ( T <   10 -> write('000'),write(T);
     T <  100 -> write('00'), write(T);
     T < 1000 -> write('0'),  write(T);
                              write(T)
    ).

/*

 English:       0000 -> 00:00 am
                1159 -> 11:59 am
                1200 -> 12:00 pm
                1201 -> 12:01 pm
                1259 -> 12:59 pm
                1300 ->  1:00 pm
                2359 -> 11:59 pm
                2400 ->  0:00 am

*/


bwt1(T0)     :-  
    language(english), 
    space, 

  ( T0 >= 2400 ->  T is T0 - 2400; T is T0),

    H is T//100,
    M is mod(T,100),

    Aft is H//12,
    L is mod(H,12),
    (L==0,Aft>0 -> L12=12;L12=L), 
 
    write(L12),
    write('.'),     %% RS-111025 Caused problems for AtB's Web-server script, which strips from colon...

    (M < 10 ->  write('0');true),
    write(M),
    (Aft >0 -> write(' pm');write(' am')).



bwt00(NN):-  %% write a number with exactly 2 digits
    NN = 0 ->  write('00');
    NN <10 ->  write('0'),write(NN);
               write(NN).    


%% Portion 

portionlist([N]):- !,bwr(N).  

portionlist(List):- 
    split(5,List,FirstN,Rest),
    Rest = [_,_|_], % at least two more
    !,
    ramses(FirstN),
    nl,
    portionlist(Rest).

portionlist(List):- 
    splitlast2(List,Body,[Y,Z]),
    ramses(Body),
    bwr(Y),
    write(', '), %%  bcp(and), 
    bwr(Z). 

ramses(List):-
   for(member(E,List),(bwr(E),write(', '))). 



splitlast2(List,Body,[Y,Z]):-
    append(Body,[Y,Z],List).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predikat som skriver ut ord    bcp*

bigcap(In,Out) :-
	 atomic(In),            %% SAFEGUARD 
    name(In,[SC|R]),
	 SC>96,SC<123,     % a-z
	 !,
	 BC is SC-32,
	 name(Out,[BC|R]).

bigcap(In,Out) :-
	 atomic(In),            %% SAFEGUARD 
	 name(In,[SC|R]),
	 SC>223,SC<256,    % à-ÿ, some exceptions not covered, i guess
	 !,
	 BC is SC-32,
	 name(Out,[BC|R]).

bigcap(P,P).          % Else, already big or bigcapping do not apply

period0  :- write('.'). 
period   :- write('.'),nl.
comma    :- write(', '). 
space    :- write(' ').
space0.                 %% nothing 
dot      :- write('.').  %% No Space 
punkt    :- write('. '). %%  Space
question :- write('?'),nl.
colon    :- write(': ').
endline.                       %% marker, nl

%% Important:  Empty output gives a strange warning message

pay1   :-  write('+ '),nl.
nopay1 :-  write('- '),nl. 

pay :-  myflags(smsflag,true),
      \+ myflags(dialog,1), 
      \+ myflags(warningflag,true),
      !, 
      write('+ '),nl. 

pay :-  myflags(smsflag,true),
      \+ myflags(dialog,1), 
      myflags(warningflag,true),   
      \+ myflags(warningtime,_),  
      !, 
      write('- '),nl. %% warning but no time

pay.

nopay :- myflags(smsflag,true),
%%%%% \+ myflags(warningflag,true), %% always
      \+ myflags(dialog,1), 
         !,  
         write('- '),nl.  
nopay.


startmark :- myflags(smsflag,true),
             \+ myflags(dialog,1),
             !. 

startmark :- nl.


%%%% 4827 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
