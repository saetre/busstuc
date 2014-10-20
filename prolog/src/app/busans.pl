/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE busans.pl
%% SYSTEM BUSTUC
%% CREATED JB-970220
%% REVISED TA-100908 added MAP parameter
%% REVISED RS-140101 modularized

% Lager svarene til BussTUC - 
% Produksjonesregler, predikater som lager fraser og 
% relasjoner mellom konsepter og ord på hvert språk

%% RS-140927. rule/2 is "executed" by pragma.pl:itr/5 (but so is TELETRANS:rule, bustrans:rule, tele:rule or teletrans:rule, frames:rule, etc...

%UNIT: app/
:- module( busans, [ rule/2, tracevalue/1 ] ). %%  Different for busans and bustrans 

:- ensure_loaded( user:'../declare' ). %% RS-111213 General (semantic) Operators
tracevalue(L) :- user:value(traceans,L).  % Trace level 1-4

%% Rule format

%   RuleID rule
%   is IS
%   id ID
%   ip IP.
%:- ensure_loaded('../app/pragma'). %% RS-111213 Pragmatic (rule) Operators
:- op(1150,xfy,rule).  

:- op(1120, fy,is).
:- op(1110,xfy,id).
:- op(1110,xfy,ip).

:- op( 715, fy,replace).
:- op( 715,xfy,with).
:- op( 715, fy,exactly). 
:- op( 715, fy,add).
:- op( 715, fy,present).

:- op( 712, fy,seen). % Lower than "not", higher than "isa"

%:- meta_predicate rule( +, 0 ) .   %% How can we get SPIDER to help us check that all predicates are imported correctly?
%:- meta_predicate is( 0 ) .   %% How can we get SPIDER to help us check that all predicates are imported correctly?
%:- meta_predicate id( +, 0 ) .   %% How can we get SPIDER to help us check that all predicates are imported correctly?
%:- meta_predicate ip( ?, ? ) .   %% How can we get SPIDER to help us check that all predicates are imported correctly?


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% USE_MODULE DEPENDENCIES       %% RS-141019

module_dependencies :-
        dep_module( Module, PredList ),
        use_module( Module, PredList ),
        fail ; true .   %% Get all use_modules, then succeed...

%UNIT: /utility/  and  /
%dep_module( '../utility/utility', [ bound/1, testmember/2, unbound/1 ] ). %% RS-131225    %:-volatile value/2.  %% RS-130630 This caused BIG TROUBLE!  value/2 
%dep_module( '../utility/datecalc', [ add_days/3, addtotime/3, before_date1/2, daysucc/2, difftime/3, isday/1, sub_days/3, subfromtime/3, timenow/1, timenow2/2, today/1, todaysdate/1, weekday/2 ] ).

dep_module( '../interfaceroute', [ decide_period/2 ] ). %% RS-141015 

%UNIT: /app/
%%% RS-131225, UNIT: app/
dep_module( busanshp, [ outdeplist/6, outfromtocorr/6 ]).     %% RS-140102 Dangerous to get all? tracevalue/1

:- module_dependencies.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%:-meta_predicate  rule(+,:).
%:-meta_predicate  is(0). %% RS-140929 Wouldn't it be nice if this worked?! I guess we need to build a debug-predicate to test all rules instead...

wakeup rule %%  Varsle meg kl 7 i morgen  
is  notification(date(YYYY,MM,DD),HHMM),   %% NEW BUSLOG Predicate
    clear 
id  clear,
    add  printmessage(notification(date(YYYY,MM,DD),HHMM))
ip	 [].


ticketprice2 rule % hva er prisen for en tur
is  ticketprice2(Type,Price)
id	 add (bcpbc(theprice),bcp(ofatrip),bcp(with),bcp(Type),
			bcp(is),bwrprices(Price),period) 
ip	 [].

/* TA-110215 Made superfluous
coupled_connections rule
is  replace connections(A1,A2,A3,From,A5,A6,Seq,A7,A8,A9)
    with        coupled(A1,A2,A3,From,A5,A6,Seq,A7,A8,A9) 
id  []
ip  [].
*/


truerule rule  %% Program succeded
is  true % ,clear
id       % clear,
    add (bcpbc(yes),nl)
ip  [].



%% Notify about relaxations in the query ØF-991005
relaxroute rule
is relax(selectroute)
id add (bcpbc(not), bcp(withthat), bcp(arrivaltime), period) 
ip [].	     

relaxtime rule
is relax(time(X, Y, Time))
id add (bcpbc(notpossible), bcp(with), bcp(X), bcp(Y), bcp(attime), 
       bwt(Time), period) 
ip [].


testanswer  rule   %% Program succeded
is  testanswer(_,YN) 
id  add (bcpbc(YN),period)
ip  [].

messy rule       %% Messages are independent of the susscess of Bus programs !
is  message(X)    %% This rule obsoletes the other message rules
id	 add (printmessage(X),endline) %% 
ip	 [].


streetconn1  rule %% Extract nearest_station Info %% TA-100227
is present  message(nearest_station(start,Y9,NS))
id not      outstreetconn(start,Y9,NS),
   add      outstreetconn(start,Y9,NS)
ip [].

streetconn2  rule %% Extract nearest_station Info %% TA-100227
is present  message(nearest_station(stop,Y9,NS))
id not      outstreetconn(stop,Y9,NS),
   add      outstreetconn(stop,Y9,NS)
ip [].



% General message


reply rule
is reply(P)
id add (%% nopay, 
       bwr(P),  
         nl) 
ip [].

replyq rule 
is replyq(P)
id add (%% nopay,
         bwq(P), 
         nl) 
ip [].


messans rule
is message(answer(P))
id add (P,nl) 
ip [].


%% Day after/before tomorrow or yesterday 

dayafterday rule 
is  exactly (today(_),daysucc(_,_),daysucc(_,_),atday(B))
id	 add (bcp(B),period) 
ip	 [].


%% Day tomorrow or yesterday 

dayafter rule 
is  exactly (today(_),daysucc(_,_),atday(B))
id	 add (bcp(B),period) 
ip	 [].



%%% Number of Object

timeout rule 
is  connections(_,_,_,_From_,_,_,_,_,_,[timeout]),clear
id	 clear,add (nopay,printmessage(timeout)) 
ip	 [].

nofdepsfrom rule 
is  passevent(_,_,Place,_,_,_),
    numberof(departures,_,Number),
    keepto(hovedterminalen,_,_)
id	 add (bcp(there),bcp(are),bwr(Number),bcp(departures), 
			bcp(past),bwr(Place),
         write(' i retning mot sentrum'),
         period)
ip	 number(Number), %% -1 means irrelevant due to transfer
    Number > 0. %% [].

nofdepsto rule  %%  i retning fra sentrum
is  passevent(_,_,Place,_,_,_),
    numberof(departures,_,Number),
    keepfrom(hovedterminalen,_,_)   
id	 add (bcp(there),bcp(are),bwr(Number),bcp(departures),
			bcp(past),bwr(Place), 
         write(' i retning fra sentrum'),
         period)
ip	 number(Number), %% -1 means irrelevant due to transfer
    Number > 0. %% [].


nof rule 
is  numberof(Object,_,Number)     
id	 add (bcp(there),bcp(are),bwr(Number), %% bcp(more),
                                   bcp(Object),period)
ip	 number(Number), Number > 0. %% -1 means transfer, only one SHOWED 

stationsat0 rule %% before twonotrans %% TA-110215
is  stationsat(Place,Station,Stations) %% in Trondheim 
id	 add printmessage(stationsat(Place,Station,Stations))
ip  [].

% Two stations, no transfer (one bus)
twonotrans  rule 
is  connections(_,_,_Bus,_From_,ToPlace,Day,_Dayseqno,FLN,Deps,[])

id	 add (google(MAP),Out) %% <------- %% TA-100227
 
ip	 outdeplist(Deps,Day,FLN,ToPlace,Out,MAP). %% TA-100223

% Two stations with transfer (two buses)

twowithtrans rule 
is  connections(_,_,_,_From_,_,_,_,Opts,Dep,MidList)

id	 add ( google(MAP),OutDep,OutCorr)  %% <-------  %% TA-110511

ip	 outfromtocorr(Opts,Dep,OutDep,MidList,OutCorr,MAP). %%  TA-110511


takestime  rule 
is  takestime(Diff,Station1,Station2)
id	 add (bcpbc(thatmeans),bcp(going),bcp(from),bwr(Station1),bcp(to),
			bwr(Station2),bcp(cantake),bwr(Diff), 
			bcp(minutes),period)
ip	 \+ value(smsflag,true). 

keepfrom rule 
is  keepfrom(Place,_,_),passevent(Deps,_,_,Opts,Day,_)
id	 add (google(MAP),Out)
ip	 Place == hovedterminalen, 
    outdeplist(Deps,Day,Opts,from(Place),Out,MAP).

direction rule 
is  keepto(Place,_,_),passevent(Deps,_,_,Opts,Day,_)
id	 add (google(MAP),Out)
ip	 %% Place == hovedterminalen, %%  skriv ut retning !
    outdeplist(Deps,Day,Opts,to(Place),Out,MAP).

% Denne matcher bare en gang, av en eller annen merkelig grunn
coming rule 
is  present keepto(Place,_,_),seen passevent(_,_,_,_,_,_) % både from og to
id	 replace (bcp(coming),bcp(from),bwr(FP),period)
	 with    (bcp(coming),bcp(from),bwr(FP),bcp(to),bwr(Place),period)
ip	 [].


bussespass rule 
is  passesstations(Buses,_,Stations,_)
id	 add (bcp(both),bwr(Buses),bcp(passes),
			bcp(thestations),nl, 
         bwr(Stations),period)
ip	 buslog:islist(Buses).

neutral rule 
is  passesstations(Bus,_,Stations,_)
id	 add (bwr2bc(Bus), %%  Trikk 1/ Buss 2
			bcp(goesto), %% more neutral wrt end stations
         bcp(thestations),nl, 
         bwr(Stations),period)
ip	 [].



timeis rule 
is  timeis(A)
id	 add (bcpbc(thetime),bcp(is),bcp(now),bwt(A),period) 
ip	 [].                         %% TA-100908


listofall0 rule %% empty list
is  listofall(_Dom,[]),
    not present numberof(_,_,_) 
id  []
ip  [].  


listofall rule %% listall is OPERATOR !!!!
is  listofall(Dom,List),
    not present numberof(_,_,_) 
id  add (write(Doms),space,bcp(are),nl,bcw(Dom,List), 
       period) 
ip  theplural(Dom,Doms).    



properstation rule 
is  properstation(Station)
id	 add (bwr(Station),bcp(is),bcp(a),bcp(station),period)
ip	 [].


tramstation rule 
is  tramstations(Stations)
id	 add (bcp(thestations),bcp(are),bwr(Stations),period)
ip	 [].


%% stationsat %%%%%%%%%%%%%%%%

/* moved before twonotrans %% TA-110215
stationsat0 rule 
is  stationsat(Place,Station,Stations) %% in Trondheim 
id	 add printmessage(stationsat(Place,Station,Stations))
ip  [].
*/



200 rule 
    is  endstations(Bus,Stations)
id  add (bcp(end_stations),bcp(for),bwr(Bus),bcp(is),bwr(Stations),period)
ip  [].

%%%% Tidsfiltrering sammen med passeringtider


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nth/N next/N first/N last etc.


% One place...

last2048 rule 
is  present passevent(_,_,_,Ord,_,_)
id	 replace (bcp(bus),bwr(Bus))
	 with		(bcp(the),bcp(nth(N)),bcp(last),bcp(bus_det),comma,bwr(Bus))
ip	 member(nth(N),Ord),member(last(_),Ord). 

nthbus rule 
is  present passevent(_,_,_,Ord,_,_)
id	 replace (bcp(bus),bwr(Bus))
	 with		(bcp(the),bcp(nth(N)),bcp(bus_det),comma,bwr(Bus))
ip	 member(nth(N),Ord).

first1bus rule 
is  present passevent(_,_,_,Ord,_,_)
id	 replace (bcp(nth(N)),bcp(bus))
	 with		(bcp(nth(N)),bcp(first),bcp(bus_det))
ip	 member(first(1),Ord).


next1bus rule 
is  present passevent(_,_,_,Ord,_,_)
id	 replace (bcp(nth(N)),bcp(bus))
	 with		(bcp(nth(N)),bcp(next),bcp(bus_det))
ip	 member(next(1),Ord).


last1bus rule 
is  present passevent(_,_,_,Ord,_,_)
id	 replace (bcp(nth(N)),bcp(bus))
	 with 	(bcp(nth(N)),bcp(last),bcp(bus_det))
ip  member(last(1),Ord).

next1busspasses rule 
is  present passevent(_,_,_,Ord,_,_)
id	 replace (bcp(bus),bwr(Bus),bcp(passes))
	 with 	(bcp(thenext),bcp(bus),comma,bwr(Bus),bcp(passes))
ip	 member(next(1),Ord).

first1busspasses rule 
is  present passevent(_,_,_,Ord,_,_)
id	 replace (bcp(bus),bwr(Bus),bcp(passes))
	 with 	(bcp(thefirst),bcp(bus),comma,bwr(Bus),bcp(passes))
ip  member(first(1),Ord).

last1busspasses  rule 
is  present passevent(_,_,_,Ord,_,_) %.
id	 replace (bcp(bus),bwr(Bus),bcp(passes))
	 with 	(bcp(thelast),bcp(bus),comma,bwr(Bus),bcp(passes))
ip  member(last(1),Ord).


% Two places....

nthlastcoupled rule 
is   present connections(_,_,_,_,_,_,_,Ord,_,[]) % NOT for transfer
id	  not bcp(nth(N)),  not bcpbc(nth(N)), 
     replace (bcp(bus),bwr(Bus))
	  with		(bcp(the),bcp(nth(N)),bcp(last),bcp(bus_det),comma,bwr(Bus))
ip   member(nth(N),Ord),member(last(_),Ord). 


nthfirstcoupled rule 
is   present connections(_,_,_,_From_,_,_,_,Ord,_,[]) % % NOT for transfer 
id	  not bcp(nth(N)),  not bcpbc(nth(N)), 
    replace (bcp(bus),bwr(Bus))
	 with		(bcp(the),bcp(nth(N)),bcp(bus_det),comma,bwr(Bus))
ip  member(nth(N),Ord).

first1coupled rule 
is  present connections(_,_,_,_From_,_,_,_,Ord,_,_)
id	  not bcp(first),  not bcpbc(first), 
    replace (bcp(nth(N)),bcp(bus))
	 with    (bcp(nth(N)),bcp(first),bcp(bus_det))
ip	 member(first(1),Ord).

next1coupled rule 
is   present connections(_,_,_,_From_,_,_,_,Ord,_,_) %
id	  not bcp(next),  not bcpbc(next), 
    replace (bcp(nth(N)),bcp(bus))
	 with    (bcp(nth(N)),bcp(next),bcp(bus_det))
ip  member(next(1),Ord).

last1coupled rule 
is   present connections(_,_,_,_From_,_,_,_,Ord,_,_) %
id	  not bcp(last),  not bcpbc(last), 
    replace (bcp(nth(N)),bcp(bus))
	 with 	(bcp(nth(N)),bcp(last),bcp(bus_det))
ip	 member(last(1),Ord).

next1coupled rule 
is   present connections(_,_,_,_From_,_,_,_,Ord,_,_) %
id	  not bcp(thenext),  not bcpbc(thenext), 
    not bcp(thenext),  not bcpbc(thenext),       % mentioned already 
    replace (bcp(bus),bwr(Bus),bcp(passes))
	 with    (bcp(thenext),bcp(bus),comma,bwr(Bus),bcp(passes))
ip	 member(next(1),Ord).

first1coupled rule 
is   present connections(_,_,_,_From_,_,_,_,Ord,_,_) %
id	  not bcp(thefirst),  not bcpbc(thefirst), 
    replace (bcp(bus),bwr(Bus),bcp(passes))
	 with    (bcp(thefirst),bcp(bus),comma,bwr(Bus),bcp(passes))
ip	 member(first(1),Ord).

thelast1coupled rule 
is  present connections(_,_,_,_From_,_,_,_,Ord,_,_) %.
id	  not bcp(thelast),  not bcpbc(thelast), 
    replace (bcp(bus),bwr(Bus),bcp(passes))
	 with 	(bcp(thelast),bcp(bus),comma,bwr(Bus),bcp(passes))
ip	 member(last(1),Ord).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Messages



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generelle rettelser

% Buss (Var) --> the bus 
thebus rule 
is  []
id  replace (bcp(bus_det),bwr(Bus))
    with    (bcp(thebus))
ip  unbound(Bus).


% Buss (Var) --> the bus 
busn rule 
is  []
id  replace (bcp(bus_det),bwr(Bus))
    with    (bcp(bus),bwr(Bus)) 
ip  bound(Bus).



% Buss (Var) --> a bus
abus rule 
is  []
id  replace (bcp(bus),bwr(Bus))
    with    (bcp(abus))
ip  unbound(Bus).

% Buss (Var) --> a bus
bussencomma rule 
is  []
id  replace (bcp(bus_det),comma,bwr(Bus))
    with    bcp(bus_det)
ip  unbound(Bus).

% Buss (Var) --> a bus
buscomma rule 
is  []
id  replace (bcp(bus),comma,bwr(Bus))
    with    bcp(bus_det)
ip  unbound(Bus).

% stations Nardo --> station Nardo
stationsname rule 
is  []
id  replace (bcp(thestations),bwr(Station))
    with    (bcp(thestation),bwr(Station))
ip  atomic(Station).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Språkavhengige regler. Skal være nest sist

% På Dag,  buss passerer --> På Dag passerer buss
thereare rule 
is  []
id  not bcp(there),  %% not there are 1 departure. ... passes ... 
    replace bcp(passes) with space, 
    replace (bcp(on),outday(Day),comma)            %% at -> on
    with    (bcp(on),outday(Day),bcp(passes))   %%
ip  isday(Day),language(norsk).



% Dag det er --> Dag er det
dagerdet rule 
is  []
id	 replace (bcp(on),outday(Day),comma,bcp(there),bcp(are))  %% at -> on
	 with    (bcp(on),outday(Day),bcp(are),bcp(there))        %%
ip  isday(Day),language(norsk).

% Dag abus goes --> Dag goes abus
dagenbussgår rule 
is  []
id	 replace (bcp(on),outday(Day),comma,bcp(abus),bcp(goes)) %% at -> on
	 with    (bcp(on),outday(Day),bcp(goes),bcp(abus))       %%
ip  isday(Day),language(norsk).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Formatering. Skal være sist  

% Lager stor bokstav etter punktum etc.
periodB rule 
is  [] 
id	 replace (Sentenceend,bcp(A)) with (Sentenceend,bcpbc(A))
ip	 busanshp:sentenceend(Sentenceend).

% Tar bort evt. punktum etc. i starten av en setning
nopoint rule 
is  []
id	 replace (startmark,Sentenceend) with startmark
ip	 busanshp:sentenceend(Sentenceend).

% Lager stor bokstav først i svaret
bigstart rule 
is  []
id  replace (startmark,bcp(A)) with (startmark,bcpbc(A))      % Beginning of Common Phrase (Big Caps)
ip	 [].

nobusmystery rule 
is  connections(_,_,_,_From_,_,_,_,_,[],_),clear
id	 clear,add printmessage(nobuses)
ip	 [].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
