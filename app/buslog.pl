/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE buslog.pl
%% SYSTEM BUSSTUC
%% AUTHOR  Jon S Bratseth
%% CREATED JB-970312    %% REVISED TA-110824
%% REVISED RS-140101 modularized
%% REVISED EWEH-150601 Erling Wishman Eek-Henriksen

%%%%%%%%%%%%%%%% ALL ROUTE INTERFACE PREDICATES %%%%%%%%%%%%%%%%%%

%%% RS-111205, UNIT: /app/
% Some predicates (like addcontext/0) are only to preserve information, no filtering..
:-module( buslog, [ addcontext/0, askref/2, atdate/1, atdate2/2, atday/1, avoidbus/3, before/2, boundstreet/1, bugdep1/2, bugdep2/4, bus_place_station/3,
   bus_mod/1, busorfree/1, bustorid/2, cname/2, connections/10, corrstats/3, dateis/4, dayModSeqNo/2, departure/4, % UNUSED? bustorid/3, %% RS-150103
   departureday/4, departuredayMOD/5, depset/2,     diffdep4/4, direct_connection/3, endstations1/1, ensure_removed/3, findstations/3, firstactualdeparturetime/4,
   flag/1,        %% For using flag( X ) from program (from busanshp for example)
   frame_remember/2, hpl/3, irrelevantdirect/4, islist/1, isnear/2,
   keepafterstrict/3, keepafterwalking/2, keeparound/3, keepat/3, keepbefore1/3, keepbeforerev/3,
   keepbetweenstat/5, keepbus/3, keepdepafter/3, keepuntil/4, keepwithin/4, listofall/2,
   maybestation/3, message/1, mod_day_in_set/5,
   neverarrives/2, neverdeparts/2, neverpasses/2, %% For negans.pl
   new_cutloop_extend/4, new_cutset_test/8, nextdep/3, nocontext/0, not/1, notaclock/1, notification/2, numberof/3, occurs_before/3, pass_after/2, pass_before/2,
   passes44/6,    passesstations/4, passevent/6, passMOD/7, popframe/0, proper_end_station/2, pushframe/0, relax/1, replyq/1,  %% For negans.pl
   rid_to_direction/3, searchforlaterendhpl/4, ridstobuses/2, samefplace/2, %% RS-140929 for bustrans.pl rules 
   selectroute/3, seqno_day/4, standardizeemit/2, station_trace/4, stationsat/3, statorplace/1, takestime/3, testanswer/2,
   ticketprice2/2, timeis/1, transferXYZ/3, trytransbuslist/4, withinslack/2,

   airbus_module/1, keepafter/3, passeq/6, ridtobusname/2, ridtobusnr/2, veh_mod/1, %% RS-140927 For busanshp.pl, moved to utility.pl: internalkonst/1, 
   stationD/2, properstation/1,    %% RS-131225 for makeauxtables
   station/1,  street_station/2,   %% RS-140927 For facts.pl     %% RS-131225 %% RS-140101 For pragma.pl, Necessary in bustrans etc.
   bus/1, place_station/2          %% RS-140927 For negans.pl
] ).

:-op( 715, fy, not ).   %% :- op( 715, fy,not).  % Already defined in TUC

%% META-PREDICATES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- meta_predicate  not(0).     % not/1,
%:- meta_predicate seqno_day(?,+,-,-).
:- meta_predicate  set_eliminate(+,0,-,-).
:- meta_predicate  set_filter(+,0,-,-).
:- meta_predicate  test(0) .  %% RS-140615  %% test/1 is a meta-predicate ( just passing on the incoming X-predicate )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%% not/1 or (not)/1 is a predicate, and not can be written (also) a prefix operator (see operator-list in declare.pl)
not X :- \+ X.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%UNUSED?
%passtimeMOD/8, 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- use_module( '../declare', [ (:=)/2, trackprog/2, value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .
:- use_module( '../sicstus4compatibility', [ output/1, remove_duplicates1/2, traceprog/2 ] ).         %% RS-141207-150119  progtrace/2, 

%:- ensure_loaded('../db/discrepancies.pl' ). %% RS-131230 alias_station2/3, etc.
:- use_module( '../db/discrepancies.pl', [ alias_station2/3 ] ). %% RS-150814

%%% RS-140101, UNIT: /  and  /utility/
:-use_module( '../utility/utility', [ bag_of/3, bound/1, charno/3, firstmem/2, lastmem/2, maximum/2, maxval/3, members/3, minimum/2, minval/3, once1/1,
        testmember/2, set_difference/3, set_of/3, set_ops/3, starttime/0, taketime/0, timeout/3, unbound/1 ] ). %test/1, testmember/2 %  ]). %% Made local: set_eliminate/4, set_filter/4, 
%% locale meta-predicates: once1/1, test/1,  %% RS-131117 includes declare.pl

:- use_module( '../utility/datecalc', [ add_days/3, before_date0/2, days_between/3, addtotime/3, dayno/2, difftime/3, subfromtime/3, timenow/1, timenow2/2, today/1, todaysdate/1 ] ).
        %% datetime/6, finddate/2, getdaynew/1, timenow/1,
:- use_module( '../utility/library', [ delete/3, reverse/2 ] ). %% RS-131225  For app/buslog, telelog, etc? remove_duplicates/2, 

%:- use_module( '../utility/writeout', [ output/1 ] ).  %% RS-140912  out/1, 
%:- use_module( '../utility/writeout', [ trackprog/2 ] ).%% RS-141105

%%% RS-140101, UNIT: /
:- use_module( '../utility/gps', [ gps_origin/2 ] ).  %% RS-140209 ( := )/2, value/2, progtrace/2, traceprog/2
:- use_module('../interfaceroute' , [ decide_period/2, domain_module/2 ]). % Interface procedures for handling interface to route modules, with topreg

%%% RS-140210, UNIT: app/
:- use_module( '../app/busanshp.pl', [ ridof/2, time_options/1  ] ).  %% RS-130210 called in for-predicate     bound/1, bus/1,  , warningtime/2
%:- use_module( '../app/telelog.pl' , [  bound/1,  unbound/1 ]). %% To utility.pl
%:- ensure_loaded( x ). %% RS-121223   %% Why?

%%% RS-111205, UNIT: dialog/
%:- use_module( '../dialog/checkitem2', [ trackprog/2 ] ). %% RS-131223 etc? getcurrent/1, sequence_member/2
%:- use_module( '../dialog/frames2', [ frame_getvalue_rec/4 ] ). %% RS-131223 etc? getcurrent/1, sequence_member/2  %% LOOPS? RECURSION? COMPILE-PROBLEM? %% RS-140927

%% RS-111205, UNIT: db/
:- use_module( '../db/route_period', [ route_period/4 ]).
:- use_module( '../db/busdat', [ vehicletype/2, endneighbourhood/2, tramstation/1 ] ). % NOT USED!?!   
:- use_module( '../db/foreign_places', [ foreign/1 ] ). % (PLACE) -> places.pl
:- use_module( '../db/places', [ alias_station/2, corr/2, isat/2, nostation/1, placestat/2, underspecified_place/1 ] ). % (PLACE) -> places.pl
:- use_module( '../db/regbusall', [ nightbus/1, regbus/1 ] ).  %% RS-141024 % NOT USED!?!   % regbus(Bus)
:- use_module( '../db/regstr', [ streetstat/5 ] ).      %% RS-131224 Obsolete?
:- use_module( '../db/timedat', [ aroundmargin/1, buslogtimeout/1, delay_margin/1, maxarrivalslack/1, maxtraveltime/1, softime/3 ] ).

%%% RS-111205, UNIT: tuc/
:- use_module( '../tuc/facts', [ isa/2,  neighbourhood/1  ] ).  %% RS-111204    isa/2 from facts.pl

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% statbus/busstat are pertinent to (created from?) the current module of the makeauxtables creation date !
%% RS-140210.   LAST IMPORT! MUST BE GENERATED FIRST! %% Should be called AFTER makeauxtables in db!
%% RS-140210. Autogenerated from monobuss -> makeauxtables.
:- use_module( '../db/auxtables.pl', [ busstat/2, statbus/2, transbuslist/3 ] ). %% Should be called AFTER makeauxtables in db! statbus/2, 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sequence preserving setof, ( first occurrence stays first)
%set_ops(X,Y,Z):-
%    findall(X,Y,Z1),
%    remove_duplicates(Z1,Z). %% order-preserving

set_eliminate( X, Predicate, List1, List2 ) :- 
    set_ops( X, ( member(X,List1), \+ Predicate ), List2 ).

set_filter( X, Predicate, List1, List2 ) :-
    set_ops( X, ( member(X,List1), Predicate ), List2 ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test(X):- \+ ( \+ ( X ) ).        %% Calls test(nostation(Y)) among other things, so: import nostation/1  Move to pragma.pl ?

%trackprog( N, P ) :-
%    value( traceprog, M ), number(M), M >= N,
%    !,
%    ( nl, call(P) )    %% TA-110130
%        ;
%    true. %% Finally, succeed anyway


%%%%%%%%%%%%%%%% ALL ROUTE INTERFACE PREDICATES %%%%%%%%%%%%%%%%%%

%% Days are represented as Kind Of Day (Kay) in departureday
%% Days are accesses by actual day  Day
%% There is a membership_predicate day_in_set(Day,Kay).

%% official codes for daysets are

%% dMTWTFSS e.g.  d0000001 sunday, d1000000 monday, d0100000 tueday


%% day_in_set(DayX,DayCode)

% Day is monday .. sunday,

% DayCode is DayCode as in regdko.pl

/*

dkodate(081224, 3). // Means Routes are created wednesday

*/

%% What is the date' s sequence number in the current module
dayModSeqNo( Date, DaySeqNo ) :- %% TA-090618

    decide_period(Date,TTP), %%%%  <----- !!! %% TA-091207 veh_mod(TTP),   %% from topreg.pl

    TTP \== nil,  %% TA-091209

    route_period( _, TTP,  Date1, _ ),   %% from topreg.pl

%%  1. day of route_period
%%  They must be equal to emitday anyhow

    days_between(Date1,Date,DaySeqN),
    DaySeqNo is DaySeqN+1.


%% EmitDATE is written as  90615   in 2009 %% only valid to 2099 !-)
%% MayBe                  100615   in 2010

standardizeemit(D90615,date(Y2009,M06,D15)):-
    Y2009 is D90615//10000 + 2000,
    MD0615  is mod(D90615,10000),
    M06 is   MD0615 //100,
    D15 is mod( MD0615,100).



%% Default mapping to special days if not specific schedule
%% NEVER APPLIES TO nightbus    %% TA-100412

%% Example Variables: May 1st is the 160 th day in route period r1612_091123
%% It has S(un)day  routes (EmitDay / SDay)
seqno_day( TTP, K160, May1, XN ) :-     %% XN relative nr of FIRST Sday in Route Module %% TA-100108
    \+ value(nightbusflag,true),        %% TA-100412
    route_period( _, TTP,  Date1, _ ),     %% topreg.pl

%%  1. day of route_period
%%  They must be equal to emitday anyhow

    TTP:dkodate(_EmitDATE,EMITDAY),

    K159 is K160-1,
    add_days(Date1,K159,May1),
    busdat:date_day_map(May1,SDay),
    dayxnumber(EMITDAY,SDay,XN). %% relative number of FIRST SDay in DayCode


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RS-150103
%% Check if DayX (eg 35) contains '1' in the DayCode (eg 3) string (eg 00000110000011...)
%% ...Or if DayX-1 (eg 34) contains '1' in the DayCode (eg 3) string AND Time>2400 (nightbus?)
%
%% timenow(NOW), %% 150328
%

%% ONLY if MAP Date to day is applied,
mod_day_in_set( TTP, DayX, DayCode, Time, Time ) :- %% example, May 1=sunday route
    number(DayX),                   %% not separate module
    number(DayCode),
    seqno_day( TTP, DayX, _May1, XN ),  %% NOT for nightbus, see below    %% TA-100412
%%    !, 
%% SDay route !   %%RS-130327, Try new (backup? / nightbus?) Regime below?
    TTP:dko( DayCode, _, _, _, _, _, _, MASK ),
    atom(MASK), %% string of zeros and ones '0100' for whole period
    charno( XN, MASK, '1' ). %% utility.pl

% For nightbuses (only?): Changes the potential BigTimes (e.g. 2530), to 24-hour clock (0130) TodayTime
mod_day_in_set( TTP, DayX, DayCode, BigTime, TodayTime ) :-
    number(DayX),
    number(DayCode),
    !,
    TTP:dko( DayCode, _, _, _, _, _, _, MASK ),
    atom( MASK ), %% string of zeros and ones '0100' for whole period
    
    DayBefore is DayX-1,
    ( BigTime > 2359  -> % if %% utility:charno before or after midnight
      TodayTime is BigTime-2400, charno( DayBefore, MASK, '1' )  ;  % then
      TodayTime=BigTime, charno( DayX, MASK, '1' ) ). % else


%% Day from query is coded as symbols
%% When a day in the following week has a different daycode as
%% that of the day in the first week, it is coded as day8,... etc

%% dayxnumber ( monday .. sunday) is day relative to EMITDAY


dayxnumber(EMITDAY,Monday,XN) :-
    dayno(Monday,DN), %% datecalc.pl %%
    !,
    S is DN-EMITDAY+1,

    (S < 1  -> XN is S+7
               ;
               XN is S).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Period Module section

:- volatile airbus_module/1.    %% RS-121223 No airbusmodules currently implemented
:- dynamic airbus_module/1.

veh_mod(TTP):-
     value(airbusflag,true),
     !,
     airbus_module(TTP).

veh_mod(TTP):-
     bus_mod(TTP).


bus_mod(TTP):-
    value( actual_period, TTP ),
    !, TTP \== nil.  %% Dynamic !


%% ///////////////////////////////


%% PERIOD INDEPENDENT
%% regbuss from regbussall. %% RS-140413, Experiment.

%regbus(X):- %% TA-110308
%   veh_mod(TTP),TTP:regbus(X), number(X),
%   X  < 10000. %%   e.g. buss 777



%% PERIOD DEPENDENT


bus(X):-
    veh_mod(TTP),TTP:regbus(X), number(X), % TTP = T... T... Period?
    X  < 10000. %%   e.g. buss 777

xroute( X, Y, Z ) :-            %% TA-090331
    value( airbusflag, true ),
    !,
    airbus_module( TTP ), %% ad hoc if several airbus modules (change)
    TTP:route(X,Y,Z).


xroute( X, Y, Z ) :-
    veh_mod(TTP), TTP:route(X,Y,Z).

%BACKUP %% RS-141018
%xroute( _X, _Y, _Z ) :-
    %    output('Airbus not activated (yet?)') .%,
    %airbus:route(X,Y,Z).



xdepartureday( Rid, A, B, Kay ) :- %% not redundant
    veh_mod( TTP ), TTP: ex_departureday( Rid, A, B, Kay ). %% TA-090812



departuredayMOD(TTP,Rid,A,B,Kay):-
    TTP: ex_departureday(Rid,A,B,Kay).  %% TA-090812


xpasses4(Trace,STATNO,Station,Seq,DelArr,DelDep) :-
    veh_mod(TTP),
    TTP:ex_passes4(Trace,STATNO,Station,Seq,DelArr,DelDep). %% TA-090812

% Extends tour by cutloop extension
% Assumes tours that corresponds are unique


new_cutloop_extend( TTP, XStation, Trace1, Trace2 ) :-
    TTP:cutloop_trace( XStation, Trace1, Trace2 ).


new_cutset_test(TTP,XStation,Trace1,Trace2,Rid1,Rid2,Delta,W) :-
     TTP:cutloop_rid(XStation,Rid1,Trace1,Rid2,Trace2,Delta,W).


%%%%%%%%%%%%%%%%%%%%

xpasses5( TTP, _Rid1, Trace1, STATNO, Station, Seq, DelArr, DelDep ) :- %% TA-090812
     TTP: ex_passes4( Trace1, STATNO, Station, Seq, DelArr, DelDep ).



before(X,Y) :- %% <-- bustrans
    number(X),
    number(Y),
    X < Y.


maxseqtour(Trace,N):-
    veh_mod(TTP),
    TTP:ex_ntourstops(Trace,N),!. %% Precomputed %% TA-090812

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Interface section    topreg ?   %

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

station( hovedterminalen ).  %% Proforma station
%% station(m0).   %% (default streetstat) %% TA-100120

station(X) :- %% TA-110415
    veh_mod(TTP),
    modstat(TTP,X).

%% RS-150815. Experiment. Check all (future) modules. Try to implement some automatic compl(station,[names]) here!
station(X) :-
   todaysdate( Today  ), %% NOT free( date(Y,M,D) )    %% actualdate
   route_period( _Company, TTPeriod, FromDate, _ToDate ),
   before_date0( Today, FromDate ),  %% Today < FromDate (Future module)
   modstat(TTPeriod,X).

/*
 %% NB  station names may vary between route periods
r1611_100823:hpl(16010369,persauneveien,persauneveien,'Persauneveien')
r1618_110517:hpl(16010369,persaunevegen,persaunevegen,'Persaunevegen').
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SOME OLD STUFF... STILL USEFUL? RS-140927
station(X):- %% additonal airbus stations %% Ad Hoc !
    value(airbusflag,true),
    user:airbusstation(X). %% busdat

station(X):-
    \+ value(tmnflag,true),
    current_period(tt,TTP,_,_),  
    modstat(TTP,X).   

station(X):-
    value(tmnflag,true), 
    domain_module(_D,TTP),
    TTP \== nil, 
    modstat(TTP,X).    
*/
%% stationD(X,D):- 
%   domain_module(D,TTP),
%   TTP \== nil,
%   modstat(TTP,X).

stationD(X,D) :-
   domain_module(D,TTP),
   TTP \== nil,
   modstat(TTP,X).


modstat(TTP,X):-  %% 1  X nonvar
    nonvar(TTP),
    nonvar(X),
    TTP: hpl(_,_,X,_), %% X appears 2 // what is nardosenteret
    !.

modstat(TTP,X):-  %% 2  X var
    nonvar(TTP),
    var(X),
    TTP: hpl(_,_,X,_). %% X appears 2 // what is nadsosenteret




cname(X,Y):-
    veh_mod(TTP),
   (TTP:hpl(_,X,_,Y);
    TTP:hpl(_,_,X,Y)).




%% Needed for makeauxtables , inconsistent

% route(A,B,C) :-          bus_mod(TTP), TTP:route(A,B,C).   %% RS-141026 true to Remove warnings because of TTP-modules not visible

hpl(A,B,C) :-            bus_mod(TTP),TTP:hpl(A,_,B,C).

% composite_stat(A,B,C) :- bus_mod(TTP), TTP:composite_stat(A,B,C).   %% RS-141026 true to Remove warnings because of TTP-modules not visible

departureday(A,B,C,D) :- bus_mod(TTP),TTP:ex_departureday(A,B,C,D).   %% RS-151114 Re-instate?

passes44(A,STATNO,B,C,D,E) :-   bus_mod(TTP),TTP:ex_passes4(A,STATNO,B,C,D,E).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%% NEW Predicate

% rid_to_direction(Rid,Station,X). %% to hovedterminalen

% X = to   ( hovedterminalen to Station)
% X = from ( to hovedterminalen from Station

rid_to_direction(_RID,Nil,Station):-
    busdat:corresp0(Station,hovedterminalen),
    !,
    Nil=nil. %% classic trap

rid_to_direction(RID,Y,Station):-

    passeq(RID,_,Station,Seq1,_,_),
    passeq(RID,_,City,Seq2,_,_),
    busdat:corresp0(City,hovedterminalen),

    (Seq1 < Seq2  -> X = from;
     Seq2 < Seq1  -> X = to;
     true         -> X = nil),
     Y = X.

%% NEW FORMAT %% TA-110323
% depnode(TimeArr,TimeDep,DelayArr,DelayDep,BegTime,Rid,Bus,SeqNo,Station)
% depnode(TimeArr,TimeDep,DelayArr,DelayDep,BegTime,Rid,Station) //old



%% TIME PARAMETERS %% Moved to busdat.pl -> timedat.pl
/*
%% Max Delay 60 minutes for correspondance
%% MAX 60 minutes hour Arrival Slack
%% Min 5 minutes for bus transfer
%% AroundMargin    Around a clock means clock +- AroundMargin

%% Max 10 seconds computing time

buslogtimeout(10000). %% 10 seconds
aroundmargin(15).     %%  Bus around 2300  , don't miss 2245 if that is the last

delay_margin(5). %% 5 minutes normally, 0 for  announced scheduled transfer
*/


%% Compensate for late arrival 47 to city syd østre

compute_delay_margin(Bus1,Bus2,OffStation,_OnStation,Marg):-
    busdat:preferred_transfer(Bus1,Bus2,_Orig1,_Orig2,OffStation),
    !,
    Marg= - 2. %%  (O. Misfjord  100830 ) NB Negative, error in Bus Tables



compute_delay_margin(_,_,_,_,Marg) :-
    delay_margin(Marg).



notaclock(NNNN) :-  \+ number(NNNN),!.

notaclock(NNNN) :-

      %% NNNN <100,NNNN>=25; %% kl 26 %% TA-101029 %% Night BUS kvart på ett.
      NNNN =< 0; % <- ?
      NNNN >= 2500;

     ( Y is mod(NNNN,100),Y>=60).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Bussrute-logikk
% Regler og hjelpepredikat for busslogikk


% test whether Station is the last station of the RID.

% Ad Hoc implementation // Could precompute  maxseq(Trace,max)

proper_end_station(RID,Station1):-
     xdepartureday(RID,Trace,_,_),
     xpasses4(Trace,_,Station1,Seq1,_,_),
     \+ (xpasses4(Trace,_,_Station2,Seq2,_,_),Seq2>Seq1),
     !.



properstation(X):-
    station(X),
    \+ nostation(X), %% ad hoc when abandoned
    X \== '',   %%  reghpl
    \+ foreign(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



station_trace(Rid,Station1,Station2,UtStats):- %% TA-100214


    passeq(Rid,_,Station1,FromSeq,_,_),
    passeq(Rid,_,Station2,ToSeq,_,_),

    ToSeq > FromSeq, %%% <- NB   bus_63_1722, rosenborg_sk,jonsvannsveien,

    findall( st(STATNO,UtStat), ( passeq(Rid,STATNO,UtStat,Seq,_,_),Seq >= FromSeq,Seq =< ToSeq), UtStats ).

    %xfindall(st(STATNO,UtStat),( passeq(Rid,STATNO,UtStat,Seq,_,_),Seq >= FromSeq,Seq =< ToSeq),UtStats).

%xfindall( El, Pred, List ):-
%   findall( El, Pred, List ).



%% NB  MUST be stations here

%% Find one RID, which is representative

%% Bloody Pragmatic
keepbetweenstat(Bus,hovedterminalen,ToPlace,InnStats,UtStats) :-
    !,              %%%%%%%%%%%%%%%
    xxxstateplace(ToStat,ToPlace),
    passeq(Rid,_,ToStat,ToSeq,_,_),
    ridtobusnr(Rid,Bus),
    xxxstateplace(FromStat,hovedterminalen),
    passeq(Rid,_,FromStat,FromSeq,_,_),
    !,
         keepbetweenstat2(Rid,FromSeq,ToSeq,InnStats,UtStats).



keepbetweenstat(Bus,FromPlace,ToPlace,InnStats,UtStats) :-
    xxxstateplace(FromStat,FromPlace),
    passeq(Rid,_,FromStat,FromSeq,_,_),
         ridtobusnr(Rid,Bus),
    xxxstateplace(ToStat,ToPlace),
    passeq(Rid,_,ToStat,ToSeq,_,_),
    !,
         keepbetweenstat2(Rid,FromSeq,ToSeq,InnStats,UtStats).


% in increasing sequence
keepbetweenstat2(Rid,FromSeq,ToSeq,_InnStats,UtStats) :-
         FromSeq =< ToSeq,  %% IN CASES SAME STATION
    !,
    findall(UtStat,( passeq(Rid,_,UtStat,Seq,_,_),Seq >= FromSeq,Seq =< ToSeq),UtStats).

% in decreasing sequence
keepbetweenstat2(Rid,FromSeq,ToSeq,_InnStats,UtStats) :-
         ToSeq<FromSeq,
    !,
    findall(UtStat,( passeq(Rid,_,UtStat,Seq,_,_),Seq >= ToSeq,Seq =< FromSeq),UtStats1),
    reverse(UtStats1,UtStats).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% 1: There is a street with matching numbers and legal Station
%% Hplno=0 is hovedterminalen in general,
%% but it is also M0 (accidentally), but that is ignored.


streetstation2(St_olavs_street,_,St_olavs_gate):-
%streetstation2(St_olavs_street,_,st_olavs_gate):-
    value(tramflag,true), %% TA-100120
    busdat:thetramstreetstation(St_olavs_street,St_olavs_gate), %% SPECIAL  busdat.pl
%   busdat:thetramstreetstation(St_olavs_street,st_olavs_gate), %% SPECIAL  busdat.pl
    !.

streetstation2(Ident,Num,Station2):- %% Station name in streetstat
    streetstat(Ident,_,Low,High,Station),

    optional_alias2(Station,Station2), %% in case of period renameing
                                       %% TA-110803
    number(Low),
    number(High),
    Num =< High, Low =< Num,
    !.

%% 2: There is a street, but no matching legal station

streetstation2(Ident,_,unknown):-
    streetstat(Ident,_,_,_,_),
    !.

optional_alias2(Station,Station2):-     %% in case of period renameing
    alias_station2(_,Station,Station2), %% TA-110803
    !; Station=Station2.



%% 3: % Not registered as street, not applicable.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


stationsat( IdentNum, Instation, Station ) :-
         nonvar(IdentNum),
    IdentNum=Ident-Num, %% vollabakken 1
         !,
    unbound(Instation),
    streetstation2(Ident,Num,Station).


stationsat( Place, Instation, Stations ) :-
         set_of(S,stathelp(Place,Instation,S),Stations),
         Stations \== [],
    !.

stationsat( Place, InStation, Stations ) :-
         unbound(InStation),
         !,
    set_of(Station,  (place_station1(Place,Station); %% NB place_station1  Must be a station
                      isat(Station,Place)),
           IsatStations),
    Stations=IsatStations.

stationsat( _Place, Neigh, Stations ) :- % Special case, Neigh is also a neighbourhood
         bound(Neigh),
    neighbourhood(Neigh), %% e.g  Migosenteret , \+  Nardosenteret
    !,
         set_of( Station, %% RS140614 setof/3 is 4x SLOWER than set_of/3
                bingbong(Neigh,Station), %% (place_station(Neigh,Station); isat(Station,Neigh)), %% RS-140614 Module Problem?
           IsatStations ),
    Stations=IsatStations.

stationsat( _, Station, Places1 ) :- %% Nardosenteret
         bound(Station),
    !,
    set_of(Place,(place_station(Place,Station) ,Place \==Station),Places),
    (    (Places == [], station(Station))  ->
             Places1=[] %%%  [Station] % GDMØ dont know
           ; Places1=Places). %%

%% something rotten (wrotten?) Debug stationsat above the above: (4 times slower than usual?!?)
bingbong(Neigh,Station) :- ( place_station(Neigh,Station) ; isat(Station,Neigh) ). %% RS-120816 To Debug Above Predicate



stathelp(Ident,Instation,Station):-
         bound(Ident),
         unbound(Instation),
         streetstat(Ident,_,_,_,Station).


maybestation(Place,OutStations0,[Place]):-
     OutStations0==[],
     station(Place),
     !.

maybestation(Place,OutStations0,[Place|OutStations0]):-   %% special case (City-Syd)
    station(Place),                                       %% both neighb and st
    neighbourhood(Place),
    \+ member(Place,OutStations0),
    !.

maybestation(_,OutStations,OutStations).



isnear(Place1,Place2) :-
         ((station(Place1),Station1=Place1);isat(Station1,Place1)),
         ((station(Place2),Station2=Place2);isat(Station2,Place2)),
         busdat:corresponds(Station1,Station2),
         Station1\==Station2.

isnear(Place1,Place2) :-
         isat(Place1,Place2),
         Place1\==Place2.

isnear(Place2,Place1) :-
         isat(Place1,Place2),
         Place1\==Place2.

isnear(Place1,Place2):-
   (placestat(Place1,Place2);
    placestat(Place1,Place2)),
    Place1 \== Place2.


corrstats([],_,[]).
corrstats([Stat1|Stats1],Stats2,[Stat1|CorrStats]) :-
         busdat:corresponds(Stat1,Stat2),
         delete(Stat2,Stats2,NewStats2),
         !,
         corrstats(Stats1,NewStats2,CorrStats).
corrstats([_|Stats1],Stats2,CorrStats) :- % Else
         corrstats(Stats1,Stats2,CorrStats).




% Avgangssett
% keepcorr(StartDeps,EndDeps,BothStartDeps)

% Copy all StartDeps that occur afterwards in EndDeps

% keepcorr(StartDeps,EndDeps,BothStartDeps).

keepcorr(StartDeps,EndDeps,BothStartDeps) :-
     set_filter( X, occurs_afterwards( X, EndDeps ), StartDeps, BothStartDeps ).



occurs_afterwards( depnode( _A1, D1, _, _, BegTime, Rid, Bus, SeqNo1, Stat1 ), EndDeps ) :-

     D1 \== 9999, %% non existing departure time

     member( depnode( _A2, _D2, _X2, _Y2, BegTime, Rid, Bus, SeqNo2, Stat2 ), EndDeps ),

%%%%%%%%%%%%%%%     Y2 > 0, %% then never after (Bus 36 M4 -> Jakobsli -> M4) %% TA-110323

     Stat1 \== Stat2, %% berg_studentby -> lerkendal_gård * //same time,reverse direction

     SeqNo2 > SeqNo1,

     !.





%%%%%%%%%%%%%%%%%%%%%%%%%%%

nextdep(Tid,Depnode,Deps):-
   Depnode=depnode(_,Time9,_,_,_,_,_,_,_),   %% <- next DEPARTURE
%%      Time9 \== 9999,  %%  Unnecessary, Time9 is unbound
   member(Depnode,Deps),
   Tid =< Time9,
   !.



%%% Constrain Set Predicates


keepbetween(LowTime,HighTime,Deps1,Deps2):-
    nonvar(Deps1), %%% Fatal security guard
    set_filter(Dep,pass_between(Dep,LowTime,HighTime),Deps1,Deps2).

%%  Sequence preserving

%%    set_of(Dep, (member(Dep,Deps1),
%%                 pass_between(Dep,LowTime,HighTime)),Deps2).



keeparrbetween(LowTime,HighTime,Deps1,Deps2):-
    nonvar(Deps1), %%%
    set_filter(Dep,arr_between(Dep,LowTime,HighTime),Deps1,Deps2).


keepdepbetween(LowTime,HighTime,Deps1,Deps2):-
    nonvar(Deps1),
    set_filter(Dep,dep_between(Dep,LowTime,HighTime),Deps1,Deps2).


avoidarrbetween(LowTime,HighTime,Deps1,Deps2):-
    nonvar(Deps1), %%%
    set_filter(Dep,not_arr_between(Dep,LowTime,HighTime),Deps1,Deps2).


avoiddepbetween(LowTime,HighTime,Deps1,Deps2):-
    nonvar(Deps1),
    set_filter(Dep,not_dep_between(Dep,LowTime,HighTime),Deps1,Deps2).




%% Inclusive
%                    0620     9999                  1810    1840 %% NO!
%                    1553     9999                  1500    1600 %% YES!

%                    9999     1500                  1440    1520 %% YES!

pass_between(depnode(ArrTime,DepTime,_,_,_,_,_,_,_),LowTime,HighTime):-

    (ArrTime=9999 -> ArrTime1=DepTime;ArrTime1=ArrTime), %% TA-110531

    ArrTime1 >= LowTime,
    ArrTime1 =< HighTime.


arr_between(depnode(Time0,_Time9,_,_,_,_,_,_,_),LowTime,HighTime):-
    LowTime =< Time0,
    Time0 =< HighTime.

dep_between(depnode(_Time0,Time9,_,_,_,_,_,_,_),LowTime,HighTime):-
    LowTime =< Time9,
    Time9 =< HighTime.


not_arr_between(depnode(Time0,_Time9,_,_,_,_,_,_,_),LowTime,HighTime):- %% TA-110322
    LowTime > Time0
    ;
    Time0 > HighTime.

not_dep_between(depnode(_Time0,Time9,_,_,_,_,_,_,_),LowTime,HighTime):- %% TA-110322
    LowTime > Time9
    ;
    Time9 > HighTime.


%%%  Keep before  : acceptability test: < 1 hour before

keepbefore(X,Y,Z) :-keepbefore0(X,Y,Z).  %%  WITHOUT  arrival time acceptability


keepbefore0(LimTime,Deps1,Deps2):-       %% Without Arrival time constraint
    nonvar(Deps1), %%% Fatal security guard

    set_filter(Dep,arrdep_before(Dep,LimTime),Deps1,Deps2). %% TA-110308


keepbefore1(LimTime,Deps1,Deps2):-          %%  With   Arrival time constraint
    nonvar(Deps1), %%% %%% Fatal security guard
    maxarrivalslack(DieTime),
    subfromtime(LimTime,DieTime,EarliestAcceptableTime),

    set_filter(Dep,pass_between(Dep,EarliestAcceptableTime,LimTime),Deps1,Deps2).
%% SEQUENCE PRESERVING

%%   set_of(Dep, (member(Dep,Deps1),
%%                 pass_between(Dep,EarliestAcceptableTime,LimTime)),Deps2).

%%%

%% Pass before means ARRIVE before. NO!!! %% TA-110308

pass_before(depnode(Time0,_,_,_,_,_,_,_,_),LimTime):-
         Time0 =< LimTime.


% pass_before(depnode(_,Time9,_,_,_,_,_,_,_),LimTime):-
%        Time9 =< LimTime.

keepbeforerev(T,X,Z):- %% .. helps find last departure before ..
    keepbefore(T,X,Y),
    reverse(Y,Z).


%%%% debug_prune(Deps1,Deps2):-keepbefore(800,Deps1,Deps2),!. %% panic debug

debug_prune(Deps,Deps).




keepafter(LimTime,Deps1,Deps2):-
    nonvar(Deps1), %% Fatal security guard

    set_filter(Dep,arrdep_after(Dep,LimTime),Deps1,Deps2). %% Sequence Preserving

keepafterwalking(Deps,Deps). %% TA-110511
%% Smartphone takes care of walking/delays


/* OBSOLETE if Real time system%% TA-110706
*/
keepafterwalking(Deps1,Deps2):- %% add individual walkingtimes %% TA-110418
    set_eliminate(X,depbeforestationwalk(X),Deps1,Deps2).

depbeforestationwalk( X ) :-
    X = depnode(_,DepTime,_,_,_,_RID,_Bus8,_Seq,Dybdals_veg),
    timenow(NOW),
    gps_origin(Dybdals_veg, Walking),
    NOW + Walking > DepTime. %% too late for departure (unless DELAY !!)
/* OBSOLETE if Real time system%% TA-110706
*/




%% NB Sometimes, keepafter means arrival after (Buster).

pass_after(depnode(_,Time9,_,_,_,_,_,_,_),LimTime):-

%%
%%     Time9 \== 9999, %% non existing dep time
%%     1500:  buss 46 fra torvmyra til okstad ø .

    Time9 >= LimTime.


keeparrafter(LimTime,Deps1,Deps2):-  %% Technical, internal
    nonvar(Deps1),
    set_filter(Dep,arr_after(Dep,LimTime),Deps1,Deps2).

keepdepafter(LimTime,Deps1,Deps2):-
    nonvar(Deps1),
    set_filter(Dep,dep_after(Dep,LimTime),Deps1,Deps2).


arr_after(depnode(ArrTime,_,_,_,_,_,_,_,_),LimTime):-
    ArrTime  >= LimTime.



dep_after(depnode(_,DepTime,_,_,_,_,_,_,_),LimTime):-
    DepTime  >= LimTime.


arrdep_before(depnode(ArrTime,DepTime,_,_,_,_,_,_,_),LimTime):-   %% TA-110308
   ( ArrTime = 9999 -> DT=DepTime;DT=ArrTime ),               %% ad hoc arrival before time,
    DT  =< LimTime.



arrdep_after(depnode(ArrTime,DepTime,_,_,_,_,_,_,_),LimTime):-
   ( DepTime = 9999 -> DT=ArrTime;DT=DepTime ),               %% ad hoc arrival after time,
    DT  >= LimTime.




keepafterstrict(LimTime,Deps1,Deps2):-
    nonvar(Deps1), %% Fatal security guard
    set_filter(Dep, pass_after_strict(Dep,LimTime),Deps1,Deps2).


pass_after_strict(depnode(_,Time9,_,_,_,_,_,_,_),LimTime):-
    Time9 \== 9999, %% non existing dep time
         Time9 > LimTime.


keepat(Time,Deps1,Deps2):-
    nonvar(Deps1), %% Fatal sec
    set_filter(Dep,pass_at(Dep,Time),Deps1,Deps2).

%%    set_of(Dep, (member(Dep,Deps1),pass_at(Dep,Time)),Deps2).

pass_at(depnode(Time,_,_,_,_,_,_,_,_),LimTime):-
    Time=LimTime.


keepbus(Bus,Deps1,Deps2):-
    nonvar(Deps1),

    set_filter(Dep,pass_bus(Dep,Bus),Deps1,Deps2).

%    set_of(Dep, (member(Dep,Deps1),pass_bus(Dep,Bus)),Deps2).

avoidbus(Bus,Deps1,Deps2):-
    set_filter(Dep, (pass_bus(Dep,Bus1),Bus1\==Bus),Deps1,Deps2).

%     set_of(Dep, (member(Dep,Deps1),pass_bus(Dep,Bus1),Bus1\==Bus),Deps2).

pass_bus( depnode(_,_,_,_,_,Rid,_,_,_), Bus ) :-
    ridtobusnr(Rid,Bus).



keeparound(Time,R,Rny):-
    aroundmargin(T14),
    subfromtime(Time,T14,LowTime),  %% 15 minutes may be the next departure
    addtotime(Time,T14,HighTime),
    keepbetween(LowTime,HighTime,R,Rny).


keepwithin(Time,Mins,R,Rny):-
    addtotime(Time,Mins,NewTime),
    keepbetween(Time,NewTime,R,Rny).


keepuntil(Time,Mins,R,Rny):-
    subfromtime(Time,Mins,NewTime),
    keepbetween(NewTime,Time,R,Rny).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Enkel resonnering over data i bussdatabasen

listofall( route,[] ) :- %% TA-090210
    value(smsflag,true),
    !.
listofall( route,Buses ) :- %% ad hoc
    allbuses( Buses ).     %% trams/ferrys etc


listofall( bus,[] ) :- %% TA-090210
    value(smsflag,true), %%Skip big list
    !.
listofall( bus,Buses ) :- %%
    allbuses(Buses).


listofall(nightbus,Buses):-
    allnightbuses(Buses).

listofall(station,S):-
    \+ value(smsflag,true),
    allstations(S).

listofall(station,S2):-
    value(smsflag,true),
    allstations(S),
    members(5,S,S1),

    append(S1,[so_on],S2).      %% (and) so on



listofall(tram,S):-
    set_of(X,X isa tram,S).

listofall(tramstation,S):-
    tramstations(S).

%% New Predicate


endstations1(Stations):-
    set_of(S, (regbus(Bus), endstation(Bus,Z),member(S,Z)), Stations).


endstations(Bus,Stations):-
    endstation(Bus,Stations1),
    bag_of(S,endneighbourhood(Bus,S),FullStationslist), %% EWEH-150209
    remove_duplicates1(FullStationslist,Stations2), %% EWEH-150209
    append(Stations1,Stations2,Stations).


% endstation(+Bus,-StationList).

endstation(Bus,Stations) :-
         bag_of(Rid,bustorid(Bus,Rid),Rids), %% EWEH-150312
         ridtoendhpl(Rids,RawStations),
         remove_duplicates1(RawStations,Stations),
    !.


% Samle alle Bus fra regbus( Bus ) i Buses1-listen
allbuses( Buses ) :-
        set_of( Bus, regbus(Bus), Buses1 ),   %% was exbus(Bus) %% TA-090608
   bus_equivalents(Buses1,Buses).

allnightbuses(Buses) :-
        set_of(Bus,nightbus(Bus),Buses1),
   bus_equivalents(Buses1,Buses).

bus_equivalents( List1, List3 ) :-
    set_of(Y, ( member(X,List1), converttostandard(X,Y) ), List2 ),
    remove_duplicates1( List2, List3 ).

converttostandard(IntX,ExtY) :- %% TA-09819
    ( busdat:exbusname(IntX,ExtY)  ->  true ;  ExtY=IntX ).



% allstations(-)


allstations(Stations) :-
        set_of(Station,properstation(Station),Stations).

tramstations(Stations) :-
        set_of(Station,tramstation(Station),Stations).



ridstobuses(Y,Z):-  %% called from busanshp.pl
    ridstobuses2(Y,Z).

ridstobuses2([],[]).

ridstobuses2([Rid|Rids],[BusN|Buses]) :-
        ridtobusname(Rid,BusN),
        ridstobuses2(Rids,Buses).


%% Finds the list of stations for the given RID. Does not (and should not) remove duplicate stations. 
ridtostations(Rid,StationsList) :- %% EWEH-1504
    bag_of(Station,passeq(Rid,_,Station,_,_,_),StationsList).

ridtoendhpl(Rids,Ends):-
    ridstotours(Rids,Traces),
    tourstoends(Traces,Ends).

%% Finds the end stations after a given station
searchforlaterendhpl(Rids,FromStation,ToStation,LaterEndStations):- %% EWEH-1504
    ridstotours([Rids],Traces),
    tourstoends(Traces,EndStations),
    ridtostations(Rids,StationsList),
    !,
    % use specific ToStation (ex.: samf_1, not samf)
    disambiguate_stations(StationsList,ToStation,ToStationFixed), 
    !,
    % ensure that FromStation fits list (it sometimes doesn't)
    conform_firststation(StationsList,FromStation,FromStationFixed),
    !, 
    % split stations at FromStation
    splitlistatstation(StationsList,FromStationFixed,StationsBefore,StationsAfter),
    
    %% find endstations only in the relevant direction
    % first part if travelling "backwards" through list
    ( member(ToStationFixed,StationsBefore) -> 
        set_filter(Station,member(Station,StationsBefore), EndStations, LaterEndStations) 
        ; true ),
    % last part if travelling with the list order
    ( member(ToStationFixed,StationsAfter) -> 
        set_filter(Station,member(Station,StationsAfter), EndStations, LaterEndStations) 
        ; true )
    .

%% Splits a list into the parts before and after an element
splitlistatstation(List,Station,ListBefore,ListAfter) :-
    % append() to find "before" and "after" fitting List and Station
    append(ListBefore, [Station|ListAfter], List).


%% Finds matching start station when a start station is not in its list of stations (inaccurate DB) (ex.: munkegt M1 -> munkegt M5)
conform_firststation(List,From,From) :-
    member(From,List). %% no adjustment needed when they already match

conform_firststation(List,From,FromFixed) :-
    \+ member(From,List),
    conform_firststation1(List,From,[city_syd_vestre,city_syd_østre,city_syd_e6],FromFixed) ;
    conform_firststation1(List,From,[dr_gate_d1,dr_gate_d2],FromFixed) ;
    conform_firststation1(List,From,[heimdal,heimdal_stasjon],FromFixed) ;
    conform_firststation1(List,From,[kongens_gate_k1,kongens_gate_k2],FromFixed) ;
    conform_firststation1(List,From,[munkegata_m1,munkegata_m2,munkegata_m3,munkegata_m4,munkegata_m5],FromFixed) ;
    conform_firststation1(List,From,[prinsens_gate_p1,prinsens_gate_p2],FromFixed) ;
    conform_firststation1(List,From,[studentersamfundet,studentersamfundet_2],FromFixed) ;
    
    % If this line is reached, the station needs to be corrected above, but isn't. Add it when found.
    false. % fake success.

conform_firststation1(List,From,Alternatives,FromFixed) :-
    member(From,Alternatives),
    set_filter(Station,(member(Station,List),member(Station,Alternatives)),List,[FromFixed|_]).


%% If ToStation is a station group, finds the specific station for the case of StationsList
disambiguate_stations(List,To,To) :- member(To,List). % Skip when not needed
disambiguate_stations(List,To,heimdal_stasjon) :- To == heimdal, member(heimdal_stasjon,List).
disambiguate_stations(List,To,kongens_gate_k1) :- To == hovedterminalen, member(kongens_gate_k1,List).
disambiguate_stations(List,To,kongens_gate_k2) :- To == hovedterminalen, member(kongens_gate_k2,List).
disambiguate_stations(List,To,munkegata_m1) :- To == hovedterminalen, member(munkegata_m1,List).
disambiguate_stations(List,To,munkegata_m2) :- To == hovedterminalen, member(munkegata_m2,List).
disambiguate_stations(List,To,munkegata_m3) :- To == hovedterminalen, member(munkegata_m3,List).
disambiguate_stations(List,To,munkegata_m4) :- To == hovedterminalen, member(munkegata_m4,List).
disambiguate_stations(List,To,munkegata_m5) :- To == hovedterminalen, member(munkegata_m5,List).
disambiguate_stations(List,To,prinsens_gate_p1) :- To == hovedterminalen, member(prinsens_gate_p1,List).
disambiguate_stations(List,To,prinsens_gate_p2) :- To == hovedterminalen, member(prinsens_gate_p2,List).
disambiguate_stations(List,To,studentersamfundet_2) :- To == studentersamfundet, member(studentersamfundet_2,List).
disambiguate_stations(_List,To,To) :- true. %% If this is reached, disamb. is needed, but not found. Add above.


ridstotours(Rids,Traces):-
    bag_of(Trace,(member(Rid,Rids),ridtotour(Rid,Trace)),FullTracesList), %% EWEH-150312
    remove_duplicates1(FullTracesList,Traces). %% EWEH-150312

ridtotour(Rid,Trace):-
    xdepartureday(Rid,Trace,_,_).

tourstoends(Traces,Ends):-
    bag_of(End, (member(Trace,Traces),tourtoend(Trace,End)), FullEndsList), %% EWEH-150312
    remove_duplicates1(FullEndsList,Ends). %% EWEH-150312

tourtoend(Trace,EndStat):-
    maxseqtour(Trace,MaxSeq),

    (xpasses4(Trace,_,EndStat,1,_,_)
     ;
     xpasses4(Trace,_,EndStat,MaxSeq,_,_)),

    EndStat \== ''.  %% Empty-name




% findstations(+,+,-)

findstations(Bus,_Day,Stationslist) :- %% Only endstations if smsflag
        value(smsflag,true),
   \+ value(airbusflag,true), %% short list anyway %% TA-090401
   !,
   endstations(Bus,Stationslist),
   Stationslist \== []. %% Better with an error message

findstations(Bus,_Day,Stationslist) :-
        set_of(Rid,bustorid(Bus,Rid),Rids), %% TA-090626

   bag_of(Station,passrids(Rids,Station),FullStationslist), %% EWEH-150209 % A bit slower, bus preserves chronological station order
%   set_of(Station,passrids(Rids,Station),FullStationslist), %% RS-150815 % Quick, and useful with sorthing for this prolog programmer (RS)
   remove_duplicates1(FullStationslist,Stationslist), %% EWEH-150209

   Stationslist \== []. %% Better with an error message


passrids(Rids,Station) :-
        member(Rid,Rids),
        passeq(Rid,_,Station,_,_,_).



diffdep4(_,_,depans(_,_,Time1,_,_,_,Time2,_),Diff) :-
    !,
    difftime(Time2,Time1,Diff).


% Uten overgang, liste only the first departure

diffdep4(StartPlace,EndPlace,Deps,Diff):-
         member(depnode(Time1,_,_,_,BegTime,Rid,_,_,Station1),Deps),

    softime(morning,MORN,_), %% busdat

    Time1 >= MORN, %% keep odd night buses out
    xxxstateplace(Station1,StartPlace),
         passeq(Rid,_,Station2,_,Delay2,_),  %% Justification
    Delay2 < 999, %% TA-100827 real time
    xxxstateplace(Station2,EndPlace),
         Station1 \== Station2,    %%  (nec., because close station  make diff
                                %%            times unreliable)
    addtotime(BegTime,Delay2,Time2),

         Time2>=Time1,
         difftime(Time2,Time1,Diff),
    !.

diffdep4(_,_,_,-1). %% (in case of timeout) | catchall



xxxstateplace(X,Y):- (busdat:corresp0(X,Y);isat2(X,Y)). %% ugly


%% Bustrans specific predicate


numberof(departures,depans(_,_,_,_,_,_,_,_),-1):- %% Don't know, transfer
    !.

numberof(_,Set,Length) :-
         length(Set,Length).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

departure( Bus, Place, Day, DepSet ) :- % Alle dag-bussavganger ved en stasjon
        unbound(Bus),
   \+   value(nightbusflag,true),  % NOT Nightbus query
   \+   value(airbusflag,true),    %% TA-090331
   !,
        veh_mod(TTP),
   setdepMOD(TTP,Place,Day,DepSet1),      %%
   set_filter( X, day_route(X), DepSet1, DepSetDag ),
   set_filter( X, night_route(X), DepSet1, DepSetNatt ),
   %% RS-150104
   ( DepSetDag == [] -> DepSet=DepSetNatt ; DepSet=DepSetDag )
   .

departure( Bus, Place, Day, DepSet ) :- % Alle natt-bussavganger ved en stasjon
        unbound(Bus),
   value(nightbusflag,true),      % Nightbus query...  %% RS-150103 Always use as backup?
   \+   value(airbusflag,true),     %% TA-090331
   !,
        veh_mod(TTP),

   setdepMOD( TTP, Place, Day, DepSet1 ), % Natt til søndag means on søndag morning! (Same as nattbuss lørdag?)
%   NextDay is Day+1, setdepMOD( TTP, Place, NextDay, DepSet1 ), %% This was wrong? But include YESTERDAY > 2400

   set_filter( X, night_route(X), DepSet1, DepSet ). %,

% Hastus means YESTERDAY's Nightbuses?!
%   set_filter(X,not_extreme_hastus_time(X),DepSet2,DepSet).   %% RS-141109  Nightbusses are no longer duplicated? (Friday 26:35 === Saturday 02:35)

%   set_filter(X,night_route(X),DepSet1,DepSet2),
%%   set_filter(X,not_extreme_hastus_time(X),DepSet2,DepSet3),   %% RS-141109  Nightbusses are no longer duplicated (Friday 26:35 === Saturday 02:35) RS-150102
%   set_filter(Y, approvenightbustoplace(Place,Y)  ,DepSet2,DepSet).


departure(Bus,Place,Day,DepSet) :- % Alle flybussavganger ved en stasjon
        unbound(Bus),

   value(airbusflag,true),     %% TA-090331
   \+ value(nightbusflag,true),      % Nightbus query

   !,

   airbus_module(TTP), %% ad hoc

   setdepMOD(TTP,Place,Day,DepSet1),

   set_filter(X,airbus_route(X),DepSet1,DepSet). %% TA-090331





departure(Bus,Place,Day,DepSet) :- % Bussavgangene for en buss ved en stasjon
        atomic(Bus), % 5 is a bus
   !,
        veh_mod(TTP),
   set_of( depnode(Time0,Time9,DelArr,DelDep,BegTime,Rid1,Bus,SEQNO,Station1),
              depbusMOD(TTP,Bus,Place,Day,Time0,Time9,DelArr,DelDep,BegTime,Rid1,SEQNO,Station1),
              DepSet ).

%% Double departures Hastus   Friday 2800 + Staurday 0400
%not_extreme_hastus_time( X ) :-
%    X = depnode(_2820,_,_20,_,T2800,_Bus_108_3049,_,_,_),     %    T2800 > 1200. %% TA-?
%    T2800 > 2459.       %% RS-141115  Remove everything except real nightbusses (or trams)...
%
%approvenightbustoplace(Place,Y) :-
%   \+ avoidnightbustoplace(Place,Y).
%
%
%avoidnightbustoplace(Place,Y) :-
%    Y= depnode(_,_,_,_,_,Bus_57_nn,__,_),
%    route( Bus_57_nn, _, B57 ),
%    busdat:spurious_return(B57,Place), %% morten_erichsen_forbid(B57,Place),
%    !.
%

setdepMOD( TTP, Place, Kay, DepSet ):-
        set_of( depnode( Time0, Time9, DelArr, DelDep, BegTime1, Rid1, Bus1, SEQNO, Station1 ),
              depMOD(TTP,Place,Kay,Time0,Time9,DelArr,DelDep,BegTime1,Rid1,Bus1,SEQNO,Station1),
              DepSet).

day_route( depnode( _Time0,_Time9,_DelArr,_DelDep,BegTime,Rid1,NB,_SEQNO,_Station1) ) :-
    ridtobusnr( Rid1, NB ),
    \+ nightbus(NB) ; ( NB=1, BegTime > 0400, BegTime < 2459 ),         %% Tram is both day_route and night_route! %% RS-150102
    \+ busdat:exbusname(NB,skolebuss).

%day_route( depnode( _Time0,_Time9,_DelArr,_DelDep,BegTime,Rid1,NB,_SEQNO,_Station1) ) :-
%    ridtobusnr( Rid1, NB ),
%    ( ( NB=1, BegTime > 0400, BegTime < 2459 ) ; \+ nightbus(NB) ),         %% Tram is both day_route and night_route! %% RS-150102
%    \+ busdat:exbusname(NB,skolebuss).


night_route( depnode( Time0, Time9, DelArr, DelDep, BegTime, Rid1, NB, X1, X2) ) :-
%    ridtobusnr( Rid1, NB ),
%    nightbus(NB).
    \+ day_route( depnode( Time0, Time9, DelArr, DelDep, BegTime, Rid1, NB, X1, X2) ).

%night_route(depnode(_Time0,_Time9,_DelArr,_DelDep,_BegTime,Rid1,NB,_,_)):-
%    ridtobusnr(Rid1,NB),
%    nightbus(NB).


airbus_route( depnode(_Time0,_Time9,_DelArr,_DelDep,_BegTime,Rid1,NB,_,_) ) :-
    ridtobusnr(Rid1,NB),
    busdat:airbus(NB).


xdepartureMOD( TTP, Rid, Trace, BegTime, DaySeqNO ) :-          %% TA-100318

   TTP: ex_departureday(Rid,Trace,BegTime,DaySeqNO).
    % ,  (BegTime < 2500 -> true ) ;  out('app/buslog~1314:late'), output(Rid) ). %% "Friday" at 2500 = "Saturday" at 0100
                   %% ignore, because 2500.. deps are duplicated  %% RS-141109 Entries are no longer duplicated!?!



%% Bus is unknown, Day has been checked %% TA-110318


%% Above here, all days should be converted
%% RS-150103. But remember that nightbus can start at "25:15 the night before" OR/AND "01:15 this morning".

%% Bus is unknown
depMOD(TTP,Place,Day,Time0,Time9,DelArr,DelDep,BegTime,Rid,Bus,Seq,Station) :-
   passeqMOD0(TTP,Rid,Place,_STATNO,Station,Seq,DelArr,DelDep),
   ridtobusnr(Rid,Bus),  TTP:regbus(Bus), %% dont generate removed buses  %% TA-110824 %% RS-141104 What about nightbus?
   adjustarr999(DelArr,DelDep,RealDelArr),
   adjustdep999(DelArr,DelDep,RealDelDep),

        xdepartureMOD( TTP, Rid, _, BegTime, Kay ),

   mod_day_in_set( TTP, Day, Kay, BegTime, TodayTime ),
%        addtotime(BegTime,RealDelArr,Time0),
%   addtotime(BegTime,RealDelDep,Time9),
        addtotime( TodayTime, RealDelArr, Time0 ),
   addtotime( TodayTime, RealDelDep, Time9 ),
   true.


%% Bus is given
depbusMOD(TTP,Bus,Place,Day,Time0,Time9,DelArr,DelDep,BegTime,Rid,Seq,Station) :-
        passeqMOD0(TTP,Rid,Place,_STATNO,Station,Seq,DelArr,DelDep),

   adjustarr999(DelArr,DelDep,RealDelArr),
   adjustdep999(DelArr,DelDep,RealDelDep),

        bustorid(Bus,Rid),

   xdepartureMOD(TTP, Rid,_,BegTime,Kay), %% TA-100318

   mod_day_in_set( TTP, Day, Kay, BegTime, TodayTime ),
%        addtotime(BegTime,RealDelArr,Time0),
%   addtotime(BegTime,RealDelDep,Time9).
        addtotime( TodayTime, RealDelArr, Time0 ),
   addtotime( TodayTime, RealDelDep, Time9 ).




%%%%%%%% TA-110224 adjustarr999(999,DelDep,DelDep):-!.     %%  (reinterpret 999 in passes)
adjustarr999(DelArr,_,DelArr).

%%%%%%%% TA-110224 adjustdep999(DelArr,999,DelArr):-!.     %%  (reinterpret 999 in passes)
adjustdep999(_,DelDep,DelDep).




% NB Problem:  Place = hovedterminalen,  munkegata_m3 occurs in passes


%-

passeqMOD0(TTP,Rid,user_location,STATNO,Station,Seq,DelArr,DelDep):- %% TA-110418
    gps_origin(Station,_Walk),
    passeqMOD(TTP,Rid,STATNO,Station,Seq,DelArr,DelDep).


passeqMOD0(TTP,Rid,H,STATNO,Terminal,Seq,DelArr,DelDep):- %% TA-110318
    H== hovedterminalen,
    !,
    passeqMOD(TTP,Rid,STATNO,Terminal,Seq,DelArr,DelDep),
    busdat:corresp0(Terminal,hovedterminalen).


passeqMOD0(TTP,Rid,Place,STATNO,Station,Seq,DelArr,DelDep) :-  %% TA-110318
    isat2(Station,Place),
         passeqMOD(TTP,Rid,STATNO,Station,Seq,DelArr,DelDep).

%-

passMOD(TTP,Rid,user_location,STATNO,Station,DelArr,DelDep) :- %% TA-110418
    gps_origin(Station,_Walk),
         passeqMOD(TTP,Rid,STATNO,Station,_Seq,DelArr,DelDep).


passMOD(TTP,Rid,H,STATNO,Terminal,DelArr,DelDep):-
    H== hovedterminalen,
    !,
    passeqMOD(TTP,Rid,STATNO,Terminal,_Seq,DelArr,DelDep),
    busdat:corresp0(Terminal,hovedterminalen). %% (busdat.pl)


passMOD(TTP,Rid,Place,STATNO,Station,DelArr,DelDep) :-
    isat2(Station,Place),
         passeqMOD(TTP,Rid,STATNO,Station,_Seq,DelArr,DelDep).

%-


isat2(Station,sentrum) :- %% TA-090915
    value(airbusflag,true),
    busdat:central_airbus_station(Station).


isat2( Station, Place ) :- %% studentersamfundet syndrom
     bound(Place),
    (
     ( station(Place), Station=Place ) ;
     ( busdat:airbusstation(Place), Station=Place ) ; %% TA-090401
     placestat(Place,Station) ;
     alias_station(Station,Place) ; %% AtB
     isat(Station,Place)
    ).


%alias_station(Station,Place) :-         %% RS-141115
%    alias_station(Station,Place).



boundstreet(Ident-_Num):-nonvar(Ident).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

samefplace(X,hovedterminalen) :-
    corr(X,hovedterminalen),
    !.


samefplace(Place1,Place2) :-
    Place1 == Place2,
    !.

samefplace(Place1,Place2):-           % kinoene,prinsens_gate
    isat2(Station1,Place1),
    isat2(Station2,Place2),
    Station1=Station2,
    !.

samefplace(Place1,Place2):-  %%   from m5 to m6
    correspx0(Place1,hovedterminalen), %% corr00 ("confuse")
    correspx0(Place2,hovedterminalen), %% TA-100318
    !.

samefplace(Thomas_angells_street,Sentrum) :-
    street_station(Thomas_angells_street,M0),
    correspx0(Sentrum,M0).


samefplace(Sentrum,Thomas_angells_street) :-
    street_station(Thomas_angells_street,M0),
    correspx0(Sentrum,M0).


correspx0(Place,HT):-
    busdat:corresp0(Place,HT)
    ;
    placestat(Place,HT).



% Defaults if Bus is free
% No harm if Bus is not a bus


bus_place_station(_Bus,X,Y):-  %% TA-090915
    value(airbusflag,true),
    busdat:corr0(X,hovedterminalen),
    !,
    busdat:central_airbus_station(Y). %%  =torget.



bus_place_station(_Bus,X,Y):-  %% TA-100115
    value(nightbusflag,true),
    X= hovedterminalen, %% corr0(X,hovedterminalen), \+ munke_street
    !,
    busdat:nightbusstation(Y). %% olav_tryggvasons_gate.



bus_place_station(_Bus,X,Y):-
%%     unbound(_Bus),
    busdat:corr0(X,hovedterminalen), %% Be liberal wrt M1,... D1,...(even if bus)
    !,
    Y=hovedterminalen.

bus_place_station(Bus,X,Y):-
    unbound(Bus),  %%  fra solbakken
    \+ busdat:bus_depend_station(_,X,_),
    \+ underspecified_place(X), %%% NB til Byåsen %% TA-100422
    !,
    place_station0(X,Y). %% studentersamfundet


bus_place_station(Bus,X,Y):-
    busdat:bus_depend_station(Bus,X,Y), %% busdat.pl
    !,
    station(Y).           %% RIT 17 mai syndrome



bus_place_station(_Bus,X,Y):-
    \+ underspecified_place(X), %% cant harm
    place_station0(X,Y). %% studentersamfundet







% Place is known !


%% PLACE-STATION

place_station( user_location, user_location ). %% TA-110408  Siste innspurt...

place_station(Place,Place) :-  %% TA-090401
     nonvar(Place),
     value(airbusflag,true), %% ad hoc
     busdat:airbusstation(Place), %% Værnes
     !.

%% AtB


place_station(Place,Station2):- %% Fronted
    bound(Place),
    station(Place),            %% don't mess with stations
    \+ neighbourhood(Place),   %% e.g. nardosenteret %% TA-100204
    !,                         %% Migosenteret, både st og neib
    Station2=Place.


place_station(IdentNum,Station):-
         nonvar(IdentNum),
    IdentNum = Ident-Num,
%%     boundstreet(Ident-Num),
    !,                         %% catch street
    streetstation2(Ident,Num,Station).


place_station(Place,Station) :-  %% Place is instantiated
%      nonvar(Place),
          bound(Place),

     (placestat(Place,Station)-> true ;

     station(Place)-> Station=Place ;  %% NOT risk  place_station(next,next)

     isat(_,Place)-> Station=Place     %% e.g. studentersamfunde KEEP the placename!
     ).                                %%      sentrum %% TA-090401



place_station(Ident,Station2):- %% Name in streetstat
         bound(Ident),
         streetstat(Ident,_,_,_,Station),
    Station \== unknown, %% there may be more, find first known
    Station \== '',      %% TA-110418

    optional_alias2(Station,Station2), %% TA-110803
    !.


place_station(Ident,U):-
         bound(Ident),
         streetstat(Ident,_,_,_,_),
    !,
    U= unknown.


place_station(Place,Station) :- %%  (If Place is free, get all)
         var(Place),
    !,
         (placestat(Place,Station);
     isat(Station,Place)).


place_station(Station,Station2):- %% in case of period renaming %% TA-110804
         bound(Station),
    optional_alias2(Station,Station2), %% TA-110803
    !.

% New predicate
% Place is instantiated, Station may be a neighbourhood
% New predicate
% Place is instantiated, Station must be a station

place_station1(Place,Station) :-
     nonvar(Place),
          placestat(Place,Station),
     station(Station),
     !.
place_station1(Place,Place) :-
     nonvar(Place),
     station(Place).





place_station0(Place,Place) :-  %% TA-090401
     nonvar(Place),
     value(airbusflag,true), %% ad hoc
     busdat:airbusstation(Place), %% Værnes
     !.




place_station0(Place,Station) :-
     nonvar(Place),
          placestat(Place,Station),
     station(Station), %% RIT 17. mai   Syndrome
     !.

place_station0(Street,HT):- %% sandgt. 5 -> m0 -> unspec central street
    street(Street),
    place_station(Street,Station),
    Station=m0,
    !,
    HT=hovedterminalen.

place_station0(Street,Station):- %%  P.Fjermstad vei, called from bus_place_station
    street(Street),
    !,
    place_station(Street,Station),
    !.

place_station0(Place,Place) :-
     nonvar(Place),
     (station(Place),!;
      neighbourhood(Place)).


% By coincidence a neighbourhood  can be aligned as a street name: utleira gate.
% This gives a message, but the message should be informative
% Not   The nearest station to Utleira is Utleira

street_station(STOGSTREET- _N_,STOGST):- %% St. Olavs gt 1 \= HT
    value(tramflag,true), %% TA-100120
    busdat:thetramstreetstation(STOGSTREET,STOGST),
    !.

street_station(Street,Station):-
    street(Street),
    !,
    place_station(Street,Station),!.%% NB in case of period renaming renaming
                                     %% TA-110803
street_station(Street,Station):-
    neighbourhood(Street),
    !,
    place_station(Street,Station),!.

street_station(_Street,unknown):-!. % otherwise

street(X):-nonvar(X), streetstat(X,_,_,_,_),!.
street(XN):-nonvar(XN),XN=X- _N,street(X).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Logikk som finner beste vei mellom to stasjoner

%  connections(StartDeps,EndDeps,Bus,FromPlace,ToPlace,Day,DaySeqNo,Opts,Deps,Mid01)


connections(StartDeps,EndDeps,Bus,FromPlace,ToPlace,Day,DaySeqNo,Opts,Deps,Mid01):-
    !,

    starttime,   %% TA-110322  Timer == Stop-watch

    nonvar( StartDeps ),   %% Departures ( depnode() ) are added by the buslog:X_departure predicates?
    nonvar( EndDeps ),     %% Departures are added by the buslog:departure predicate(s)?

    debug_prune(StartDeps,StartDeps777),

    remove_spurious_deps(StartDeps777,StartDeps0),

    remove_roundtrip_deps(FromPlace,ToPlace,StartDeps0,StartDeps1), %% TA-110224

    debug_prune(EndDeps,EndDeps777),

    remove_spurious_arrs(EndDeps777,EndDeps1),

    coupled(StartDeps1,EndDeps1,Bus,FromPlace,ToPlace,Day,DaySeqNo,Opts,Deps,Mid01),

    trackprog( 2, ( nl, taketime, nl ) ). %% TA-110322


remove_roundtrip_deps(FromPlace,ToPlace,StartDeps0,StartDeps1):- %% TA-110224
    set_eliminate(X,looping(FromPlace,ToPlace,X),StartDeps0,StartDeps1).


looping(FromPlace,ToPlace,Bingo) :- %% TA-110224

        Bingo =depnode(9999,T1520,_DelArr,_DelDep,_Time,RID,_BUS,_1,FromPlace),

     veh_mod(TTP),

     xdepartureMOD(TTP,RID,Trace,_BegTime,_Daycode),

     xpasses5(TTP,RID,Trace,_,FromPlace,Seq1,_,DelDep1),   Seq1=1, %% nec? HS

     addtotime(T1520,DelDep1,DepTime1),

     xpasses5(TTP,RID,Trace,_,FromPlace,Seq2,_,DelDep2),   Seq2 > Seq1,   %%  HS

     addtotime(T1520,DelDep2,DepTime2), DepTime2 > DepTime1,

     xpasses5(TTP,RID,Trace,_,ToPlace,Seq3,_,DelDep3),     Seq3 > Seq2,    %% KS

     addtotime(T1520,DelDep3,DepTime3), DepTime3 > DepTime2,

        !.


remove_spurious_deps(Deps,Deps1):-
    set_eliminate(X,  (X=depnode(_,_,_,999,_,_,_,_,_)),Deps,Deps1).


%% depnode(TimeArr,TimeDep,DelayArr,DelayDep,BegTime,Rid,Bus,SeqNo,Station)
remove_spurious_arrs(Deps,Deps1):-
    set_eliminate(X, (X=depnode(_,_,999,_,_,_,_,_,_)),Deps,Deps1).




%%% EXPERIMENTAL QUICK VERSION  %%%%%%%%%%%%%%%%%%%%%%%


/*   SUSPENDED

coupled(StartDeps,EndDeps,_Bus,FromStat,ToStat,Day,DaySeqNo,Opts,Dep01,Mid01) :-
    value(quicktransfer,true),
%%%%%%%%    kindofday(Day,Kay),
    station(FromStat),
    station(ToStat),
    StartDeps\==[],EndDeps\==[],     % Fail when no departures
    keepcorr(StartDeps,EndDeps,BothStartEndDeps),
    BothStartEndDeps == [],
    !,
    firsttime(FT1,StartDeps),
    lasttime(LT2,EndDeps), % in case before time
    findquicktransfers(Opts,FromStat,ToStat,FT1,LT2,Day,DaySeqNo,SetOfDepMid),
    trackprog(3,outputlist(SetOfDepMid)),
    firstmem(SetOfDepMid,depX(_,Dep01,Mid01)). %%


findquicktransfers(Opts,FromStat,ToStat,FT1,LT2,Day,DaySeqNo,SetOfDepMid):-
    \+testmember(lastcorr,Opts),
    \+member(last(_),Opts),  %% testmember syndrome
   transferXYZ(FromStat,ToStat,TransferStations),
    set_of(depX(ArrT,Dep01,Mid01),   % sort on final arrival time
      ( member(X,TransferStations),
        findfirstquicktransfer(FromStat,ToStat,X,FT1,LT2,Day,DaySeqNo,Dep01,Mid01),
         Dep01= depans(_,_,_,_,_,_,ArrT,_)),
    SetOfDepMid).

findquicktransfers(Opts,FromStat,ToStat,FT1,LT2,Kay,SetOfDepMid):-
    (testmember(lastcorr,Opts);test(member(last(_),Opts))), %% testmember syndrome
    transferXYZ(FromStat,ToStat,TransferStations),

    set_of(depX(ArrT,Dep01,Mid01), % sort on final arrival time
      ( member(X,TransferStations),
        findlastquicktransfer(FromStat,ToStat,X,FT1,LT2,Kay,Dep01,Mid01),Dep01= depans(_,_,_,_,_,_,ArrT,_)),
    SetOfDepMid0),
    reverse( SetOfDepMid0,SetOfDepMid).


%% Quick Version

findfirstquicktransfer(FromStat,ToStat,X,FT1,LT2,Kay,Dep01,Mid01):-
       firstquicktransfer(FromStat,ToStat,X,FT1,LT2,Kay,Dep01,Mid01),
       !.


%% Quick Version

findlastquicktransfer(FromStat,ToStat,X,FT1,LT2,Kay,Dep01,Mid01):-
       lastquicktransfer(FromStat,ToStat,X,FT1,LT2,Kay,Dep01,Mid01),
       !.


%%  First A-> X, First X -> B

firstquicktransfer(FromStat,ToStat,X,FT1,LT2,DaySeqNo,Dep01,Mid01):-
    veh_mod(TTP),
% First direct from FromStat to X

    passes4(Trace1,_STATNO,FromStat,Seq1,_,DelDep1),
    passes44(Trace1,X,Y,       Seq2,DelArr1,_),
    Seq2 > Seq1,

    departuredayMOD(TTP,Rid1,Trace1,BegTime1,DayCode),
    mod_day_in_set(TTP,DaySeqNo,DayCode),
    addtotime(BegTime1,DelDep1,DepTime1),

    DepTime1 >= FT1,

    addtotime(BegTime1,DelArr1,ArrTime1),

% First direct from X to ToStat

    passes4(Trace2,STATNO,ToStat,  Seq4,DelArr2,_),
    passes44(Trace2,X,Z,       Seq3,_,DelDep2),

    Seq4 > Seq3,

    departuredayMOD(TTP,Rid2,Trace2,BegTime2,DayCode),
    mod_day_in_set(TTP,DaySeqNo,DayCode),
    addtotime(BegTime2,DelDep2, DepTime2),
    addtotime(BegTime2,DelArr2, ArrTime2),
    ArrTime2 =< LT2,

    withinslack(DepTime2,ArrTime1)   ,  %% [+ 2, + 60]

    ridtobusnr(Rid1,BusN1),
    ridtobusnr(Rid2,BusN2),

    Dep01 = depans(BusN1,Rid1,DepTime1,FromStat,BusN2,Rid2,ArrTime2,ToStat),
    Mid01 = midans(BusN1,ArrTime1,Y,BusN2,DepTime2,Z).



lastquicktransfer(FromStat,ToStat,X,FT1,LT2,DaySeqNo,Dep01,Mid01):-
    veh_mod(TTP),
% Last direct from X to ToStat

    passes4(Trace2,STATNO,ToStat,Seq4,DelArr2,_),
    passes4(Trace2,X, Z,  Seq3,_,      DelDep2),

    Seq4 > Seq3,

    departuredayMOD(TTP,Rid2,Trace2,BegTime2,Kay),
    mod_day_in_set(TTP,DaySeqNo,Kay),
    addtotime(BegTime2,DelArr2, ArrTime2),

    ArrTime2 =< LT2,

    Slack = 15, %% experiment

    subfromtime(LT2,Slack,RelTime), ArrTime2 >= RelTime,

    addtotime(BegTime2,DelDep2, DepTime2),

% First direct from FromStat to X

    passes4(Trace1,STATNO,FromStat,Seq1,_,     DelDep1),
    passes44(Trace1,X, Y,    Seq2,DelArr1,_),
    Seq2 > Seq1,

    departuredayMOD(TTP,Rid1,Trace1,BegTime1,Kay),
    mod_day_in_set(TTP,DaySeqNo,Kay),
    addtotime(BegTime1,DelDep1,DepTime1),

    DepTime1 >= FT1,

    addtotime(BegTime1,DelArr1,ArrTime1),

    withinslack(DepTime2,ArrTime1)   ,  %% [+ 2, + 60]

    ridtobusnr(Rid1,BusN1),
    ridtobusnr(Rid2,BusN2),

    Dep01 = depans(BusN1,Rid1,DepTime1,FromStat,BusN2,Rid2,ArrTime2,ToStat),
    Mid01 = midans(BusN1,ArrTime1,Y,BusN2,DepTime2,Z).

*/


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




% Finner alle rids som passerer endestasjonen, AFTER NOW if SMS/notime

coupled( StartDeps, EndDeps, _, _, _, Day, DaySeqNo, Opts, Deps, Mid01 ) :-

%%%%%%%%%%%%%%  value(smsflag,true), %% NB no bygone departs

   \+ member(nextaftertime(_),Opts),

   sameday(Day),   %% RS-150103. Doesn't work for NightBus (next week)! NOW>0430,
%   finddate( 0, Today ), value( actualdate, Today ), % Really same day!

   timenow2(0,NOW),     % \+ value( nightbusflag, true ),   \+ member(nightbus, Opts ),


   keepafter(NOW,StartDeps,StartDeps1),
   keepafter(NOW,EndDeps,EndDeps1),

   StartDeps1\==[],EndDeps1\==[],     % Fail when no departures
   !,
        keepcorr(StartDeps1,EndDeps1,BothStartDeps), %% TA-100828

   coupled_time( BothStartDeps, StartDeps1, EndDeps1, Day, DaySeqNo, Opts, Deps, Mid01 ).




% Finner alle rids som passerer endestasjonen
coupled( StartDeps, EndDeps, _, _, _, Day, DaySeqNo, Opts, Deps, Mid01 ) :-
         StartDeps\==[], EndDeps\==[],     % Fail when no departures
        keepcorr( StartDeps, EndDeps, BothStartDeps ),
   !,
   coupled_time( BothStartDeps, StartDeps, EndDeps, Day, DaySeqNo, Opts, Deps, Mid01 ).






%% TO AVOID HANGING, THERE IS A timeout CLAUSE ON COUPLED

coupled_time( BothStartDeps, StartDeps, EndDeps, Day, DaySeqNo, Opts, Deps, Mid01 ) :-
    buslogtimeout( MAXTIME ),     %% timedat: RS-141015
    timeout(            %%  calls time_out if not notimeoutflag
      coupled1(BothStartDeps,StartDeps,EndDeps,Day,DaySeqNo,Opts,Deps,Mid01),
        MAXTIME, %% 10 seconds
        Success),

   ( Success =  success -> Deps \== [] %% true %% <--- Experiment FAIL if no connections
     ;
     Deps = [],
     Mid01= [timeout]
   ).

%% purge deps deletes irrelevant passages from StartDeps and EndDeps
%% even if there are direct connections, because these may later prove to be
%% irrelevant (too late/ in the past)

coupled1(BothStartDeps,StartDeps,EndDeps,Day,DaySeqNo,Opts,Deps,Mid01):-
%%%%%%%%%%    (BothStartDeps == []),
%%%%%%%%%%    !,
    purge_deps(Opts,StartDeps,EndDeps,LeanStartDeps,LeanEndDeps),

    coupled2(BothStartDeps,LeanStartDeps,LeanEndDeps,Day,DaySeqNo,Opts,Deps,Mid01).




/*
<>      StartDeps
[]      EndDeps

      [  < ...
=>       [<


      ]  >
=>    ]>

..........................

Die ( oooo > 60 min)

     < oooo [
=>      < o [


     > oooo ]
=>   > o ]
*/


purge_deps(_Opts,StartDeps,EndDeps,LeanStartDeps,LeanEndDeps):-

    firstdeptime(FS,StartDeps),
    lastdeptime(LS,StartDeps),

    firstarrtime(FE,EndDeps),
    lastarrtime(LE,EndDeps),

%%% The Obvious cases ********************

% Skip the last StartDeps after last EndDeps
    minval(LS,LE,LS1),


% Skip the first  StartDeps an hour before first EndDeps

    maxtraveltime(MaxT),

    subfromtime(FE,MaxT,XXX),
    maxval(FS,XXX,FS2),


% Skip the first EndDeps  before the first StartDeps
    maxval(FE,FS,FE1),

% Skip the last  EndDeps   an hour after the last StartDeps
    addtotime(LS,MaxT,YYY),
    minval(LE,YYY,LE2),


% Avoid deps between firstdep+120, lastdep -120

    maxval(FS,FE,LastActualDepTime), %% NB FS is spurious as 1. dep
    addtotime(LastActualDepTime,120,LateDepLow),

    subfromtime(LS,120, LateDepHigh),


% Avoid arrs between firstarr +120, lastarr -120

    addtotime(LateDepLow,120, LateArrLow), %% TA-110324
    subfromtime(LE,120,  LateArrHigh),

%%

    avoiddepbetween(LateDepLow,LateDepHigh,StartDeps,XStartDeps),

    keepdepbetween(FS2,LS1,XStartDeps,LeanStartDeps), %% FS2/LS1 must be DEPtimes!


    avoidarrbetween(LateArrLow,LateArrHigh,EndDeps,XEndDeps),

    keeparrbetween(FE1,LE2,XEndDeps,LeanEndDeps).





sameday(_Day) :-     
     value(samedayflag,true),
     ! . %% TA-091229  Don't backtrack
sameday(Day) :-
     (today(Day),
     \+ value(samedayflag,false)),
     !.



wrotten :-
        write('Something very wrotten happened...').

%% Section coupled2

%% PREFER INDIRECT FREAK
%% IF NO DIRECT ROUTES START WITHIN 60 MINUTES AFTER FIRST DEPTIME, SWITCH TO INDIRECT.
%% IF INDIRECT FINDS A LATE DIRECT ROUTE, IT IS TAKEN, BUT ONLY SINGLETON

%% deleted


%% ************


%% 1. Assumes that the indirect will be BETTER
%% 2. Screws it up if later  after NOW is added

%% FIRSTFREAK
%% IF SMSFLAG, FIRSTCORR  There is a direct connection, but FIRST EndDep >> First Startdep
%% ==> Try indirect


coupled2(BothStartDeps,StartDeps,EndDeps,Day,DaySeqNo,Opts,Deps,Mid01) :-

     fail, wrotten,   %% TA-110411... Debugging!

     BothStartDeps \== [], %% There is a direct connection

%%%%      value(smsflag,true), %% Når går bussen fra Fagerheim alle til iskremfabrikken?
     \+ member(nextaftertime(_),Opts), %%  testmember disallows var
     \+ testmember(direct,Opts),
     \+ testmember(lastcorr,Opts), %% buss fra tonstadkrysset til klæbu.

%%%%%  testmember(firstcorr,Opts), %% no option means next

%% Only applicable if sameday

     sameday(Day),

     timenow2(0,NOW),

     lastmem(BothStartDeps, LastDirect),
     deptimeof(LastDirect,LastDirectTime),

     LastDirectTime > NOW, %% ignore special treatment if last departure time in the past
                    %% <---

     firstmem(BothStartDeps, BothFirstDirect),  %% TA-100207
     deptimeof(BothFirstDirect,BothFirstDirectTime),

     firstmem(StartDeps, FirstInDirect),  %% TA-100207
     deptimeof(FirstInDirect,FirstInDirectTime),


     timenow2(60,Time60), %% in case  FirstDirectTime is late

     BothFirstDirectTime > Time60, %% ignore directroute if wait direct > 60 min
     FirstInDirectTime =< Time60,   %% first indirect within an hour=> hope for Indirect

                     %% <---   %% NEI!  time=0237, first FB kl 0400 \+ =>overgang!!!!!

     !, %% ignore direct connection

     traceprog(4,coup2),

     coupled2([],StartDeps,EndDeps,Day,DaySeqNo,Opts,Deps,Mid01).





%% LASTFREAK
%% IF SMSFLAG, LASTCORR/LAST/ There is a direct connection, Last DEP is before 2100
%% ==> Try indirect%% deleted


%% TRANSFER  AFTER NOW TAKES PRECEDENCE OVER DIRECT ROUTE
%% IF TODAY AND NO TIMECLAUSE AND NONE AFTER NOW

%% deleted



%%%%%%%

% SMS,  cut out bygone departures

% Putter ut listen over busser som passerer begge steder |after now|
coupled2(BothStartDeps,_,_,Day, _DaySeqNo,_Opts,BothStartDeps1,MidDeps) :-
    BothStartDeps \== [],
    sameday(Day),
%    value( actualdate, Today ), finddate( 0, Today ), % Really same day!
%%%%%%%%%%%%%%%%%%%%%%% TA-110706    \+ testmember(lastcorr,Opts),
    traceprog(4,coup6),
    timenow2(0,NOW),
    keepafter(NOW,BothStartDeps,BothStartDeps1), %% NB direct line early in morning***
    BothStartDeps1 \== [], %% TA-100828          %%
    !,                     %%
    MidDeps=[].            %%



% Putter ut listen over busser som passerer begge steder, |even if in the past|.
coupled2(BothStartDeps,_,_,Day,_DaySeqNo,_Opts,BothStartDeps,MidDeps) :-
    BothStartDeps \== [],

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  %% TA-110705
%    value( actualdate, Today ),
    \+ ( sameday(Day) ),%, finddate( 0, Today ) ),  % NOT Really same day! %% time might give opportunity to take next day
    !,
    traceprog(4,coup7),
    MidDeps=[].




%/////////////////////////
% Ingen busser passerer begge steder
% SMS
% Ingen dag oppgitt
% Intet tidspunkt oppgitt
% finner første mulighet etter nå ("neste") if possible
%%%   , otherwise FAIL (Don't announce bygone departures)

coupled2([],StartDeps,EndDeps,Day,DaySeqNo,Opts,Deps,Mid01) :-
%%     value(smsflag,true), %%  Neste buss fra P.A. Munchs gt til Dragvoll
    \+ member(direct,Opts),

%% if no other time options than ...,  try next
   (set_difference(Opts,[first,first(1),next,next(_)],Opts1),
     \+ time_options(Opts1) ),

    sameday(Day),
         !,
    traceprog(4,coup8),
    timenow2(1,NOW),   %% Dont announce bygone departures
    keeparrafter(NOW,StartDeps,AfterStartDeps),
    keeparrafter(NOW,EndDeps,AfterEndDeps),

    coupledtry(AfterStartDeps,AfterEndDeps,Day,DaySeqNo,Opts,Deps,Mid01).




%//////////////

% Ingen busser passerer begge steder - finner beste overgang

% Ingen tidspunkter oppgitt, dag = i dag:
% finner første mulighet etter nå ("neste") if possible, otherwise first

coupled2([],StartDeps,EndDeps,Day,DaySeqNo,Opts,Deps,Mid01) :-
    \+ member(direct,Opts),  % Dont exclude indirect connections

    sameday(Day),
         !,
         traceprog(4,coup9),
    coupledtry(StartDeps,EndDeps,Day,DaySeqNo,Opts,Deps,Mid01).



% Ingen tidspunkter oppgitt, ikke i dag, Første om morgen
%% RS-120916 Make exception when nightbus is specifically specified TODO?

coupled2([],StartDeps,EndDeps,Day,DaySeqNo,Opts,Deps,Mid01) :-
    \+ member(direct,Opts),  % Indirect solutions is not to be found
    \+ time_options(Opts),   %%  busanshp.pl
    \+ sameday(Day),
         !,
         traceprog(4,coup10),
         coupled3(StartDeps,EndDeps,Day,DaySeqNo,Opts,Deps,Mid01).


% Tidspunkter oppgitt

coupled2([],StartDeps,EndDeps,Day,DaySeqNo,Opts,Deps,Mid01) :-
    \+ member(direct,Opts),  % Indirect solutions is not to be found
         !,
         traceprog(4,coup11),
         coupled3(StartDeps,EndDeps,Day,DaySeqNo,Opts,Deps,Mid01).


%% END coupled2



%% Check if a spurious irrelevant direct route blocks a rekevant indirect route
%% Earlier than now, or too far in the future
%% If so, indirect will be tried, and if direct within limits, only 1 passing.



irrelevantdirect(_Opts,_FirstDirectTime,LastDirectTime,_FirstStartTime) :- %% in the past
     value(smsflag,true),
     !,
     timenow2(0,NOW),
     LastDirectTime < NOW,
     !.


irrelevantdirect(_Opts,FirstDirectTime,LastDirectTime,FirstStartTime) :- %% too long after
     \+ value(smsflag,true),
     !,
     maxtraveltime(MaxT),
     addtotime(FirstStartTime,MaxT,F60),

   ( FirstDirectTime > F60
     ; %% even after 60 minutes, have to wait
     LastDirectTime < FirstStartTime). %% direct only in the past




firstactualdeparturetime(Day,_DaySeqNo,S,FAT) :-
     value(smsflag,true),
     sameday(Day),
     !,
     timenow2(0,NOW),
     firstdeparture(S,X),
     deptimeof(X,FirstDirectTime),
     maxval(NOW,FirstDirectTime,FAT).

firstactualdeparturetime(_Day,_DaySeqNo,S,FAT) :-
     firstdeparture(S,X),
     deptimeof(X,FAT).

firstdeparture(S,X):-
    member(X,S),
    deptimeof(X,T),
    T \== 9999,
    !.





% Try finding a solution after now:
coupledtry(StartDeps,EndDeps,Day,DaySeqNo,Opts,Dep01,Mid01) :-

   \+ member(nextaftertime(_),Opts),

   \+  time_options(Opts),

    sameday(Day),

    timenow2(1,NOW),   %% Dont announce bygone departures

    keeparrafter(NOW,StartDeps,AfterStartDeps),
    keeparrafter(NOW,EndDeps,AfterEndDeps),

         coupled3(AfterStartDeps,AfterEndDeps,Day,DaySeqNo,Opts,Dep01,Mid01),
         Dep01 \== [],
    !.


% If no solution after now exist, find first one anyway:
coupledtry(StartDeps,EndDeps,Day,DaySeqNo,Opts,Dep01,Mid01) :-
         coupled3(StartDeps,EndDeps,Day,DaySeqNo,Opts,Dep01,Mid01),
         !.  % If using the whole set fails, then there is no hope



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Finner beste kobling mellom sett

coupled3(StartDeps,EndDeps,Day,DaySeqNo,Opts,Dep01,Mid01) :-

        bestcorr(StartDeps,EndDeps,Day,DaySeqNo,

                                depnode(_,Time1,_,_,_,Rid1,BusN1,SeqNo1,Station1), % Start
                                depnode(Time2,_,_,_,_,Rid2,BusN2,SeqNo2,Station2), % End
                                [OffTime,OffStation,OnTime,OnStation],Opts), %% List
        ridtobusname(Rid1,BusN1),
        ridtobusname(Rid2,BusN2),

      traceprog(5,depnode(_,Time1,_,_,_,Rid1,BusN1,SeqNo1,Station1)),
      traceprog(5,depnode(Time2,_,_,_,_,Rid2,BusN2,SeqNo2,Station2)),

        Dep01 = depans(BusN1,Rid1,Time1,Station1,BusN2,Rid2,Time2,Station2),
   Mid01=  midans(BusN1,OffTime,OffStation,BusN2,OnTime,OnStation).

% Find last possibillity
bestcorr(StartDeps,EndDeps,Day,DaySeqNo, StartDep,EndDep,Mid,Opts) :-
         tofindlastcorr(Opts),
                StartDep  =             depnode(_,_,_,_,_,_,_,_,Orig),
                EndDep    =             depnode(_,_,_,_,_,_,_,_,Dest),
         reverse(StartDeps,RevDeps),
         lastcorr(Orig,Dest,RevDeps,EndDeps,Day,DaySeqNo,StartDep,EndDep,Mid).

% Find first possibillity
bestcorr(StartDeps,EndDeps,Day,DaySeqNo, StartDep,EndDep,Mid,Opts) :-
         \+ ( tofindlastcorr(Opts) ),
                StartDep  =             depnode(_,_,_,_,_,_,_,_,Orig),
                EndDep    =             depnode(_,_,_,_,_,_,_,_,Dest),
    firstcorr(Orig,Dest,StartDeps,EndDeps,Day,DaySeqNo,StartDep,EndDep,Mid).

tofindlastcorr(Opts) :- member(last(_),Opts).
tofindlastcorr(Opts) :- member(lastcorr,Opts).

%%% lastcorr(-Orig,-Dest,+StartDeps,+EndDeps,-StartDep,-EndDep,-Mid01)
%%% Optimizes primary on late departure, secondary on short travel time

lastcorr(Orig,Dest,StartDeps,EndDeps,Day,DaySeqNo,StartDep,EndDep,Mid) :-

% Filter away deps in StartDeps after last Dep in EndDeps

    lasttime(LT,EndDeps),
    keepbefore(LT,StartDeps,StartDeps1),    %% // Unnec

% Filter away deps in StartDeps that are earlier han 1 hour
% before first EndDep

    maxtraveltime(MaxT),

    firsttime(FT,EndDeps),
    subfromtime(FT,MaxT,FT1),
    keeparrafter(FT1,StartDeps1,StartDeps2),

    !,
         member(StartDep,StartDeps2),
    islastcorr(StartDep,Orig,Dest,EndDeps,Day,DaySeqNo,EndDep,Mid).


islastcorr(DEP,Orig,Dest,InDeps,Day,DaySeqNo, StartDep,Mid) :-

           deptimeof(DEP,Time9),

           keeparrafter(Time9,InDeps,Deps), %% keepafterstrict

         !,               % No use in choosing the above again...
         islastcorr2(Orig,Dest,Deps,Day,DaySeqNo,DEP,Mid,StartDep).

islastcorr2(Orig,Dest,DepList,Day,DaySeqNo,EndDep,Mid,Dep) :-
         member(Dep,DepList),
    iscorr3(Orig,Dest,Day,DaySeqNo,EndDep,Dep,Mid).


%%% firstcorr(Orig,Dest,+StartDeps,+EndDeps,Day,DaySeqNo,-StartDep,-EndDep,-Mid01)
%%% Optimizes primary on early arrival, secondary on short travel time

%%  EndDeps sorted on increasing time, earliest first
%%  Find  the first  departure from a  Transfer  to  End
%%             That is  supposed to give early arrival time
%%  Then find last departure from Start to Transfer
%%             That gives short travel time

%% EXPERIMENTAL %%%
%%  N: buss 47 fra Hesttrø til Rostengrenda  etter kl. 21.40 .
%%  OrigX0  OrigX1    OrigY0     Xstat     Dest
%%  Klæbu  Hesttrø    Sandmoen   CitySyd   Rostengrenda
%%  depans(47,bus_47_94,2206,hesttrø,46,bus_46_231,2256,city_syd)

firstcorr(Orig,Dest,StartDeps,EndDeps,Day,DaySeqNo,StartDep,EndDep,Mid):-
    reverse(StartDeps,StartDepsRev),
    !,
    member(EndDep,EndDeps),
    isfirstcorr(EndDep,Orig,Dest,Day,DaySeqNo,StartDepsRev,StartDep,Mid),

    traceprog(4,'*foundcorr').





arrtimeof(depnode(X,Time0,_,_,_,_,_,_,_),Time):-X=9999,!,Time=Time0.
arrtimeof(depnode(Time0,_,_,_,_,_,_,_,_),Time0).

deptimeof(depnode(_,Time0,_,_,_,_,_,_,_),Time0). %% (always?)


%%% TA-110311

firstarrtime(M,L) :-minvalarrs(L,M).
lastarrtime(M,L)  :-maxvalarrs(L,M).

firstdeptime(M,L) :-minvaldeps(L,M).
lastdeptime(M,L)  :-maxvaldeps(L,M).


minvalarrs(L,M) :-
    set_of(TimeArr,member(depnode(TimeArr,_TimeDep,_,_,_,_,_,_,_),L),K),
    minimum(K,M).


minvaldeps(L,M) :-
    set_of(TimeDep,member(depnode(_TimeArr,TimeDep,_,_,_,_,_,_,_),L),K),
    minimum(K,M).



maxvalarrs(L,M) :-
    set_of(TimeArr,member(depnode(TimeArr,_TimeDep,_,_,_,_,_,_,_),L),K),
    maximum(K,M).


maxvaldeps(L,M) :-
    set_of(TimeDep,member(depnode(_TimeArr,TimeDep,_,_,_,_,_,_,_),L),K),
    maximum(K,M).


firsttime(Time,[depnode(X,Time0,_,_,_,_,_,_,_)|_]):-X=9999,!,Time=Time0.
firsttime(Time0,[depnode(Time0,_,_,_,_,_,_,_,_)|_]).


lasttime(Time0,Z):-   %% last arrival !
    reverse(Z,Z1),
    firsttime(Time0,Z1).


isfirstcorr( EndDep,Orig,Dest,Day,DaySeqNo,StartDepsRev,StartDep,Mid) :-
    arrtimeof(EndDep,Time0),  %%    <---- ARR
         isfirstcorr2(Time0, EndDep, Orig,Dest,Day,DaySeqNo,StartDepsRev,StartDep,Mid).

%%%%% EXPERIMENTAL  %% TA-100901

isfirstcorr2(Time0,EndDep,Orig,Dest,Day,DaySeqNo,DepList,StartDep,Mid) :-

%% check if mandatory connection is decided

    ridof(EndDep, ENDRID),
    startstation(ENDRID,Orig2),
    ridtobusnr(ENDRID,Bus2),  %% ENRID will arrive at Rostengrenda

    busdat:preferred_transfer(Bus1,Bus2,Orig1,Orig2,   _OffStation),
%%                     47   46   Klæbu Sandmoen CitySyd
    member(StartDep,DepList), %% last first

    ridof(StartDep, STARID),
    startstation(ENDRID,Orig1),
    ridtobusnr( STARID,Bus1), %% Find Rid that starts at KlæbuS

    arrtimeof(StartDep,S0),  %%  <---- ARR
    S0 =<  Time0,  % skip thru starts until  =<
    iscorr3(Orig,Dest,Day,DaySeqNo,StartDep,EndDep,Mid),
    %% right StartDep is found, iscorr3 will find transfer station (CS)
    !. %


isfirstcorr2(Time0,EndDep,Orig,Dest,Day,DaySeqNo,DepList,StartDep,Mid) :-

%%%     bugdep1(EndDep,bus_5_269),


    member(StartDep,DepList),
    arrtimeof(StartDep,S0),  %%  <---- ARR
    S0 =<  Time0,  % skip thru starts until <  %% =< %%
    iscorr3(Orig,Dest,Day,DaySeqNo,StartDep,EndDep,Mid),
    !. % <-----------------


bugdep1(depnode(TimeArr,TimeDep,DelayArr,DelayDep,BegTime,Rid,Bus,SeqNo,Station),Rid):-
    output(depnode(TimeArr,TimeDep,DelayArr,DelayDep,BegTime,Rid,Bus,SeqNo,Station))
    ;true.

bugdep2(depnode(TimeArr1,TimeDep1,DelayArr1,DelayDep1,BegTime1,Rid1,Bus1,SeqNo1,Station1),
        depnode(TimeArr2,TimeDep2,DelayArr2,DelayDep2,BegTime2,Rid2,Bus2,SeqNo2,Station2),
        Rid1,Rid2):- bongo,
    output([depnode(TimeArr1,TimeDep1,DelayArr1,DelayDep1,BegTime1,Rid1,Bus1,SeqNo1,Station1),
           depnode(TimeArr2,TimeDep2,DelayArr2,DelayDep2,BegTime2,Rid2,Bus2,SeqNo2,Station2)])
    ;true.

bongo.




%% This is the main connection predicate between two depnodes

%% Extended to capture cutloop stations

%% Tries  to  preset offstation ,  backtracks and succeeds otherwise

find_preferred_transfer(TTP,Rid1,Rid2,OffStation):-

     once1( try_preferred_transfer(TTP,Rid1,Rid2,OffStation) )

%% %     nonvar(OffStation) %%%%% <---

     ;
     true. %% Leave uninstanstiated

%% NEW REGIME %% TA-100830

try_preferred_transfer(TTP,Rid1,Rid2,OffStation) :-
    ridtobusname(Rid1,Bus1),
    ridtobusname(Rid2,Bus2),
    busdat:preferred_transfer(Bus1,Bus2,Orig1,Orig2,OffStation), %% busdat.pl

    startstation(TTP,Rid1,Orig1), %% Extra check

%%    TTP:ex_departureday(Rid1,Trace1,_,_),    %%
%%    TTP:ex_passes4(Trace1,_,Orig1,1,_,_),    %%

    startstation(TTP,Rid2,Orig2).

%%    TTP:ex_departureday(Rid2,Trace2,_,_),    %%
%%    TTP:ex_passes4(Trace2,_,Orig2,1,_,_).    %%


startstation(TTP,Rid,Orig) :-
     TTP:ex_departureday(Rid,Trace,_,_),    %%
     TTP:ex_passes4(Trace,_,Orig,1,_,_).

startstation(Rid,Orig) :-
     veh_mod(TTP),
     TTP:ex_departureday(Rid,Trace,_,_),    %%
     TTP:ex_passes4(Trace,_,Orig,1,_,_).







%% TA-110318
trytransbuslist(_Bus1,_Bus2,_OffStation,_OnStation):-
    \+ value(trytransbuslist,true),
    !.

trytransbuslist(Bus1,Bus2,OffStation,OnStation):- %% TA-110322

    htrans(OffStation,HoffStat),
    htrans(OnStation,HonStat),

    transbuslist3(Bus1,Bus2,TBL),
    testmember(HoffStat,TBL),
    testmember(HonStat,TBL),

    traceprog(3,trytransbuslist(Bus1,Bus2,OffStation,OnStation)).

htrans(OffStation,hovedterminalen) :-
    corr(OffStation,hovedterminalen),!.
htrans(X,X).



%% Is there a correspondence between Orig and Dest ?

iscorr3(_Orig,_Dest,_Day,_DaySeqNo,StartDep,EndDep,Mid):-

    StartDep = depnode(_,_,_,_,_,Rid,_,SeqNo1,_),  %% berg_studentby  seq 9
    EndDep =   depnode(_,_,_,_,_,Rid,_,SeqNo2,_),    %% lerkendal_gård seq 8

    SeqNo2 > SeqNo1, %% maybe same time but different seq

    % You have despite expectations found a (late) direct transfer
    !,
    Mid = [0,nil,9999,nil].  %% Make a dummy transfer


%% Orig -> OffStation -> OnStation  -> Dest
%  SeqNo1 -> SeqOFF     ->  SeqON     ->  SeqNo2

iscorr3(Orig,Dest,_Day,_DaySeqNo,StartDep,EndDep,Mid):- %% TA-110325

    StartDep = depnode(_OrigArrTime,OrigDepTime,_DelArr1,_DelDep1,_BegTime1,Rid1,Bus1,SeqNo1,_),
    EndDep   = depnode(DestArrTime,_DestTime9,_DelArr2,_DelDep2,_BegTime2,Rid2,Bus2,SeqNo2,_),

%%%%     bugdep2( StartDep,  EndDep, bus_52_111, bus_5_269),

 \+ toolongtraveltime(OrigDepTime,DestArrTime),

    Mid = [OffTime,OffStation,OnTime,OnStation],
    !,
    veh_mod(TTP),

    find_preferred_transfer(TTP,Rid1,Rid2,OffStation), %% preset offstation

% - 1. leg %% day is already checked

    passtimeMOD0(TTP,Rid1,_,Orig,      SeqNo1,_,      _), % vestlia
    passtimeMOD0(TTP,Rid1,_,OffStation,SeqOFF,OffTime,_), % M3

    SeqOFF > SeqNo1,

    busdat:corresponds(OffStation,OnStation),                              % M3 -> D3

% - 2. leg

    passtimeMOD0(TTP,Rid2,_,OnStation,SeqON,_,OnTime),      % D3

    SeqON < SeqNo2,

    compute_delay_margin(Bus1,Bus2,OffStation,OnStation,Marg),

    addtotime(OffTime,Marg,OffTime5), %% 5 minutes (busdat1.pl)

    OffTime5 =< OnTime,

    passtimeMOD0(TTP,Rid2,_,Dest,SeqNo2,OffTimeX,_),        % Moholt

    OffTimeX =< DestArrTime, %% = ?  nec ?

    \+ diedwaiting(OffTime,OnTime).



passeq(RID,STATNO,Station,Seq,DelArr,DelDep):-   %% Pass with seq. no.
    veh_mod(TTP),

    xdepartureMOD(TTP,RID,Trace,_BegTime,_),

    xpasses5( TTP,RID, Trace,STATNO,Station,Seq,DelArr,DelDep).


passeqMOD(TTP,RID,STATNO,Station,Seq,DelArr,DelDep):-   %% Pass with seq. no.

     xdepartureMOD(TTP,RID,Trace,_BegTime,_),

     xpasses5(TTP,RID,Trace,STATNO,Station,Seq,DelArr,DelDep).


%% RS-150103 Unusued?
%passtimeMOD(TTP,Rid,STATNO,Station,Seq,ArrTime,DepTime,DaySeqNo) :-
%
%    xdepartureMOD(TTP,Rid,Trace,BegTime,Kay),
%
%    mod_day_in_set(TTP,DaySeqNo,Kay),
%    xpasses5(TTP,Rid, Trace,STATNO,Station,Seq,DelArr,DelDep),
%    \+ nostation(Station), %% Ad Hoc for abandoned stations
%    addtotime(BegTime,DelArr,ArrTime),
%    addtotime(BegTime,DelDep,DepTime).
%

%passtimeMOD(TTP,Rid,STATNO,Station,Seq,ArrTime,DepTime,DaySeqNo):-
%
%    xdepartureMOD(TTP,Rid,Trace,BegTime,Kay),
%
%    mod_day_in_set(TTP,DaySeqNo,Kay),
%    xpasses5(TTP,Rid, Trace,STATNO,Station,Seq,DelArr,DelDep),
%    \+ nostation(Station), %% Ad Hoc for abandoned stations
%    addtotime(BegTime,DelArr,ArrTime),
%    addtotime(BegTime,DelDep,DepTime).


%% Day has already been is checked %% TA-110325

passtimeMOD0(TTP,Rid,STATNO,Station,Seq,ArrTime,DepTime):-
    xdepartureMOD(TTP,Rid,Trace,BegTime,_Kay),
    xpasses5(TTP,Rid, Trace,STATNO,Station,Seq,DelArr,DelDep),
    \+ nostation(Station), %% Ad Hoc for abandoned stations
    addtotime(BegTime,DelArr,ArrTime),
    addtotime(BegTime,DelDep,DepTime).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


withinslack(Time,Time0):-
    addtotime(Time0,2,Time2),
    Time >= Time2,
    maxarrivalslack(DieTime),
    addtotime(Time0,DieTime,DiedWaiting),
    Time < DiedWaiting.

diedwaiting(OffTime,OnTime):-
    maxarrivalslack(DieTime),
    addtotime(OffTime,DieTime,DiedWaiting),
    OnTime > DiedWaiting .

toolongtraveltime(Time1,Time2):-
    maxtraveltime(N0),       %% eg 90
    addtotime(Time1,N0,Time),
    Time2 >= Time.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Penger


ticketprice2(BusType,List) :-
    (BusType = nightbus -> Type = nightbus_all ; Type = BusType),
    busdat:busfare2(Type,List).    %% Busdat




% findprice(FromPlace,ToPlace,Day,Price)

%% Findprice is not actual in Trondheim, because of fixed prices

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

statorplace(X) :- station(X) ; X isa neighbourhood.
busorfree(X) :- unbound(X) ;
                bus(X) ;
                internalkonst(X) ;
                listofbuses(X).



listofbuses((A,B)) :-
         bus(A),listofbuses(B).
listofbuses(A) :-
         bus(A).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Kontrollpredikat som hjelper til å bygge reglene


notification(_,_). %% Dummy

atdate2(_,Date) :- %% ad hoc %% TA-090618

    set_actualdate(Date), %%

    decide_period(Date,_). %%%%%% NEW, always executed     %% RS-140102 topreg? interfaceroute?


atdate(Date):-

    set_actualdate(Date), %%

    decide_period(Date,_). %%%%%% NEW, always executed


set_actualdate(Date):-
     ( actualdate := Date ).


%%%%%%%%%%%%%%% This was almost identical with telelog!! %% RS-140101 (Re-move telelog?)
% These predicates are only to preserve information?, no filtering...

flag(_).  %% Panic : Global flag that is sometimes not removed by bustrans

passevent(Deps,_,_,_,_,_) :- Deps\==[]. %%  ==> Message   NO PASSES
atday(_).

timeis(_).
dateis(_,_,_,_).
message(_).

replyq(_).
%reply(_).      %% This should do something in buslog!
takestime(_,_,_).
passesstations(_,_,_,_).
% busespass(_,_,_,_).


% from telelog
%atday(_). %atdate(_). %timeis(_). %dateis(_,_,_,_). %message(_). %%takestime(_,_,_). %passesstations(_,_,_,_).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

internalkonst( sk(_) ).


%% ensure_removed(X,[X|R],R). %% removes only first

ensure_removed(X,[X|RA],RB):- !, %% used by busanshp (only)
    ensure_removed(X,RA,RB).
ensure_removed(X,[A|RA],[A|RB]) :-
    ensure_removed(X,RA,RB).
ensure_removed(_,[],[]).


islist(X) :- nonvar(X), X = [_|_] .

%% occurs_before(Z,X1,X2)  X1 occurs before X2 in Z

occurs_before([X1|Z],X1,X2):-
    !,
    member(X2,Z).

occurs_before([_|Z],X1,X2):-
    occurs_before(Z,X1,X2).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ridtobusnr(RID,BusNr).   %% RID is known, gets BusNr and repaired BusName

ridtobusnr( RID, BusNr ) :-
    xroute( RID, BusNr, _ ),
    !.

%% ridtobusname(RID,BusName).   %% RID is known, gets busname


ridtobusname( RID, BusName ) :-
     xroute(RID,_BusNr,BusN),
     BusName=BusN,
     !.




%% bustorid/2: bustorid( Bus, RID ).        %% bus is either BusNr or BusName, Gets RID
bustorid(Bus,Rid) :-
     xroute(Rid,_,Bus).



%% busToRid/3: ( Bus, DaySeqNo, Rid )
%bustorid( Bus, DaySeqNo, Rid ) :-
%    veh_mod(TTP),
%    xroute( Rid, _, Bus ),
%         TTP:ex_departureday( Rid, _, _, Kay ), %% TA-090812
%    mod_day_in_set( TTP, DaySeqNo, Kay ).


%%%%%%%%%%%%%%% NEVER PASS test %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% neverpases   neverarrives neverdeparts

% statbus/busstat are pertinent to (created from?) the current module of the makeauxtables creation date !


neverpasses(Bus,_Place):- %% Bus is free => neverpasses fails
    unbound(Bus),
    !,
    fail.

neverpasses(Bus,Place):-
    atomic(Bus),
    test(vehicletype(Bus,_)),
    \+ sometimepasses(Bus,Place). %% cuts unnec


sometimepasses( Bus, Sentrum ) :-
    atomic( Bus ),
    samefplace( Sentrum, hovedterminalen ),
    busdat:corresp( X, hovedterminalen ),
    veh_mod(TTP),TTP:route( Rid, Bus, _ ),
    passeq( Rid, _, X, _, _, _ ),
    !.

sometimepasses( Bus, Station ) :-
    atomic(Bus),
    veh_mod(TTP),TTP:route(Rid,Bus,_),
    passeq(Rid,_,Station,_,_,_),
    !.


sometimepasses( Bus, Place ) :-
    atomic(Bus),
    atomic(Place),
    isat2(Station,Place),
    veh_mod(TTP),TTP:route(Rid,Bus,_),
    passeq(Rid,_,Station,_,_,_),
    !.


%&&&

neverarrives(Bus,_Place):- %% Bus is free => neverpasses fails
    unbound(Bus),
    !,
    fail.

neverarrives(Bus,Place):-
    atomic(Bus),
    test(vehicletype(Bus,_)),
    \+ sometimearrives(Bus,Place). %% cuts unnec


sometimearrives(Bus,Sentrum):-
    atomic(Bus),
    samefplace(Sentrum,hovedterminalen),
    busdat:corresp(X,hovedterminalen),
    veh_mod(TTP),TTP:route(Rid,Bus,_),
    passeq(Rid,_,X,Seq,_,_),
    Seq > 1, %% NB Seq=1 only means only depart
    !.

sometimearrives(Bus,Station):-
    atomic(Bus),
    veh_mod(TTP),TTP:route(Rid,Bus,_),
    passeq(Rid,_,Station,Seq,_,_),
    Seq > 1, %% NB Seq=1  means only depart
    !.


sometimearrives(Bus,Place):-
    atomic(Bus),
    atomic(Place),
    isat2(Station,Place),
    veh_mod(TTP),TTP:route(Rid,Bus,_),
    passeq(Rid,_,Station,Seq,_,_),
    Seq > 1, %% NB Seq=1 only means only depart
    !.

%&&&


neverdeparts(Bus,_Place):- %% Bus is free => neverpasses fails
    unbound(Bus),
    !,
    fail.

neverdeparts(Bus,Place):-
    atomic(Bus),
    test(vehicletype(Bus,_)),
    \+ sometimedeparts(Bus,Place). %% cuts unnec


sometimedeparts(Bus,Sentrum):-
    atomic(Bus),
    samefplace(Sentrum,hovedterminalen),
    busdat:corresp(X,hovedterminalen),
    veh_mod(TTP),TTP:route(Rid,Bus,_),
    passeq(Rid,_,X,_Seq,_,_),
 %%%%%%%%%%%%%%%%%%%%%%%%%% TA-110107   Seq = 1, %% NB Seq=1 only means only depart
    !. %% not if cutloop in sentrum

sometimedeparts(Bus,Station):-
    atomic(Bus),
    veh_mod(TTP),TTP:route(Rid,Bus,_),
    passeq(Rid,_,Station,_Seq,_,_),
  %%%%%%%%%%%%%%%%%%%%%%%%%% TA-110107    Seq = 1, %% NB Seq=1 only means only depart
    !. %% not if cutloop in sentrum


sometimedeparts(Bus,Place):-
    atomic(Bus),
    atomic(Place),
    isat2(Station,Place),
    veh_mod(TTP),TTP:route(Rid,Bus,_),
    passeq(Rid,_,Station,_Seq,_,_),
 %%%%%%%%%%%%%%%%%%%%%%%%%% TA-110107     Seq = 1, %% NB Seq=1 only means only depart
    !.%% not if cutloop in sentrum


% &&&&&&&&&&&&&&&&&&&&&&&




% General test predicate
:- meta_predicate testanswer(0,?) .
testanswer(X,Y):-
    call(X),
    !,
    Y=yes ; Y=(no).


selectroute(Rid, Deps1, Deps2) :-
    set_of(Dep, (member(Dep,Deps1),pass_rid(Dep,Rid)),Deps2).

pass_rid([_,_,_,Rid,_],Rid).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Utility for GPS ? %% TA-110218  FARA

% BusNo passes Station1 and then Station2

direct_connection(Station1,Station2,BusNo) :-
    busstat(BusNo,L1),             %% RS-140101, move to auxtables: ?
    memrest(Station1,L1,Lrest),
    memrest(Station2,Lrest,_),
    !.

memrest(X,[X|Z],Z):-!.
memrest(X,[_|Z1],Z2):-
    memrest(X,Z1,Z2).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% These predicates are only to preserve information, no filtering..

depset(_,_).



askref(_, _) :- false.  %% If we need to clarify references, we don't have to compute.
askref(never,succeeds). %% If we need to clarify references, we don't have to compute.

pushframe.
popframe.
nocontext.

addcontext.
relax(_).



%%% NEW TRANSFER LOGIC

% Compute set of possible transfer stations between stations

transferXYZ( GN, CS, XS ):-
%    set_of( X,
    setof( X,
          ( statbus(GN,A), statbus(CS,B), member(B1,A),
             member(B2,B), transbuslist3(B1,B2,Z), member(X,Z) ),
           XS ).

transbuslist3(B1,B2,Z):-
    B2 @< B1 -> transbuslist(B2,B1,Z) ;
                transbuslist(B1,B2,Z). %% TA-110318


frame_remember(_,_):-!. %% Pro forma

%%%% 3069 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Keep the rule-files "small" please!

