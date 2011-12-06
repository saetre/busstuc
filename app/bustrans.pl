%% FILE bustrans.pl
%% SYSTEM BUSTUC
%% AUTHOR   T.Amble
%% CREATED  TA-041006
%% REVISED  TA-110825
%% REVISED  RS-111118

%% Unit: app
:- module( trans, [ (rule)/2, double/0, tracevalue/1 ] ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RS-111205, UNIT: /
:- ensure_loaded( '../declare' ).  % :- use_module( userNOTME:'../declare.pl').
:- use_module( '../main', [ myflags/2 ] ). %, set/2  ] ).

%% RS-111205, UNIT: utility/
:- use_module( '../utility/utility', [] ).
%:- ensure_loaded( '../utility/utility' ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% RULE  FORMAT
%   RuleID rule %% <evoking question>
%   is IS
%   id ID
%   ip IP.

% Operatorer for Pragma-regler

% is operator prefixed with rule RuleID

:- op(1150,xfy,rule).

:- op(1120, fy,is).
:- op(1110,xfy,id).
:- op(1110,xfy,ip).

:- op( 715, fy,add).
:- op( 715, fy,assume).
:- op( 715, fy,context).    %% similar to ispresent, but doesnt mark as saw
:- op( 715, fy,addfront).   %% (for messages etc)
:- op( 725, fy,addcon).     %% add if not already ispresent
:- op( 715, fy,exactly).
:- op( 715, fy,ispresent).
:- op( 715, fy,no).
%:-op( 715, fy,not).  % Already defined in TUC: declare.pl
:- op( 715, fy,remove).
:- op( 715, fy,removeall).  %% remove all of a list
:- op( 715, fy,removeif).   %% remove all if any , always succeed
:- op( 715, fy,replaceall). %% replace iteratively all elements
:- op( 715, fy,replaceif).  %% replace if occuring.
:- op( 715, fy,replace).
:- op( 715, fy,replacelast).
%:-op( 715, fy,to).     %% not used, interferes with SWI-Prolog /srel/to/--
:- op( 715,xfy,with).

:- op( 714,xfy,seq).     %% directly sequence
:- op( 714,xfy,cond).    %% new   not X isa place cond bound(X)
:- op( 714,xfy,when).    %% same as cond %% TA-081106

%% seen was reserved in sicstus4
:- op( 712, fy,saw). % Lower than "not", higher than "isa".

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Control predicates

% :-single.   Only in query answer mode
% :-double.   Only in dialog mode

%% FLAGS: (local to BusTrans)


% flag(exit)                 Dont create more departures
% flag(fail)                 Explicit call of negative answer

%% % flag(nightbus)      %%   = nightbusflag
% flag(nightbusflag)         Query is about nightbus
% flag(nightbusoption)       Ad Hoc Retention flag (Loop control)


% flag(warningflag)          Query contained warning request
% flag(earlytime)            Time + 1200 is excluded
% flag(latetime)             Time + 1200 is decided
% flag(decide_period)        Retention flag for out of period routes
% flag(defaultdest)          Destination is unique and default (vs sentrum)
% flag(todefaultdest)        Out to  default peripheral destination
% flag(fromdefaultdest)      Back from default peripheral destination
% flag(todefaultorig)        Back to central default (e.g. Airbus Lerkendal)
% flag(fromdefaultorig)      Out from  central default (e.g. Airbus Lerkendal)


% flag(keepfrombay)          Default from sentrum
% flag(keeptobay)            Default to sentrum
% flag(yesterday)            Time 2400 -- 2500, possibly late departures yesterday

% flag(earlierbus)  earlier than previous arrival (dialog)
% flag(laterbus)    later than previous departure (dialog)


% flag(airbus)      %% airbus/airport query
%    main:myflags(airbusflag)  global flag

%% OPTIONS

/*

from
to
time

nextaftertime(1)
nextaftertime(N)

first(1)
first(N)

next(0)
next(1)
next(N)

last(1)
last(N)

firstcorr
lastcorr

nth(N1)

number
nightbus

*/


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                                   % single-question application
single :-  main:myflags(dialog,0) ;   % if dialog is 0   or
	       \+ main:myflags(dialog,_). % if dialog is undefined .

                                   % dialog-question application
double :- main:myflags(dialog,1).    % if dialog is 1


tracevalue(L) :- main:myflags(traceprog,L).  % Trace level 1-7


%%%%%%%%    -> dmeq.pl %%%%%%%%
%%%%%%%% dmeq(A,B)  B means the same as A in this domain
%%%%%%%% First argument must be bound !!!



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RULE SECTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

heading  rule  % Heading (Comment) , Do nothing
is  [(head,_)],clear
id   add flag(comment)
ip  [].


% rules to handle list of TQL statements

tqllist0 rule  % YES. | NO.
is  [(confirm,_)]
id  add message(answer(bcpbc(ok))),
    add flag(exit) %%  avoid OK./OK.
ip  [].
%%%%%%%%     :- single.

tqllist1 rule   % YES, ... | NO, ...
is  replaceall [(confirm,_)|Y]
    with Y
id  []
ip  [].
%%%%%%%%%%    :- single.

tqllist2 rule  % List with one query
is  replaceall [X]
    with X
id  []
ip  []
    :- single.

tqllist2err rule  % ignore 1 error
is  replaceall [X,error]
    with X
id  addfront message(onlyonesentence) %% TA-110112
ip  []
    :- single.

tqllist3 rule %  varsel  buss går til nth
is  [(flag,Flagname),replyq(_)]
id  add message(mustknow(time)),
    add flag(exit) % no mire action
ip  main:set(Flagname,true)
    :-single.


tqllist4 rule %  varsel  buss går til nth
is  replaceall [(flag,Flagname),Rest]
    with Rest
id  []
ip  main:set(Flagname,true)
    :-single.


tqllist5 rule %  OK ! Jeg heter Tore
is  replaceall [(doit,reply('OK'))|Rest]
    with Rest
id  []
ip  []
    :-single.

tqllistl6 rule %  OK ! Jeg heter Tore
is  replaceall [(doit,replyq('Hello'))|Rest]
    with Rest
id  []
ip  []
    :-single.


tqllist7 rule %  OK ! Jeg heter Tore
is  replaceall [(doit,reply(X))|Rest]
    with Rest
id  addfront replyq(X)
ip  []
    :-single.

tqllist8 rule %  Hei ! Jeg heter Tore
is  replaceall [(doit,replyq(X))|Rest]
    with Rest
id  addfront replyq(X)
ip  []
    :-single.

tqllist9 rule  % List with several  queries
is  replaceall [X|_]
    with X
id  addfront message(onlyonesentence)
ip  []
    :-single.



error rule %% Erroneous and nonsensical
is  error
id  add reply('?')
ip  [].

%-------------------------------------------------------------------------------%


%-----------------------------------------------------------------------%

nonightbusatall1 rule % night bus is disabled
is  clear
id  flag(nightbusflag),
    clear,
    add message(noinfoabout(nightbus)),
    add flag(exit)
ip  main:myflags(disablenightbus,true).


nonightbusatall2 rule %% nattbuss til risvollansenteret (but no nightbusatall)
is  _ isa midnight,clear
id  clear,
    add message(noinfoabout(nightbus)),
    add flag(exit)
ip  main:myflags(disablenightbus,true).


%%% USE CONTEXT  (Dialog)

usecontext rule
is []
id remove
     askfor([], Slot, Value)
ip current_frame(Frame),
   frame_getvalue_rec(Frame, Slot, Value, _)
:- double.


lockcontext rule %% empty value if no framevalues exists
is []
id ispresent askfor([], _, Value)
ip newfree(Value)
:- double.



%%
useref rule
is	ispresent whichref(Type, List) isa _
id not askref(_, _),
	add askref(Type, List)
ip []
  :- double.




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SECTION  Source to Source Transformation  %%
%%    Can be paraphrased in NRL.             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



bringrule rule %%  Which bus brings me to Ringve
is  replaceall (bring/A/_I_/E, A isa Veh, event/real/E)
    with      (A isa Veh,doit/go/A/E),
    {dmeq(vehicle,Veh)}
id  []
ip  [].

lunchtime rule %% går buss 5 ved lunsjtider
is  replaceall (T isa lunchtime,srel/Prep/time/T/E)
    with       (1200 isa clock,srel/Prep/time/1200/E)
id  not flag(earlytime),
    add flag(earlytime)
ip  [].


toclock rule %% jeg skal til risvollan til klokka 6
is  replaceall srel/to/clock/T515/E
    with       srel/before/time/T515/E
id  []
ip  [].


isitlongt rule %% er det langt ==> hvor lenge varer det
is  replaceall ( %% test,
                adj/_/long/A/E,event/real/E)
    with       (which(A), A isa duration,B isa vehicle,doit/go/B/E, srel/pwith/duration/A/E)
id  []
ip  newfree(B).


movedto rule %% I moved to = go from
is  replaceall (I isa self,move/I/A,srel/to/place/Nth/A)
    with       (I isa self,doit/go/I/A,srel/from/place/Nth/A)
id  []
ip  [].

% Airbusflag section

airbusquery1 rule
is  replaceall X isa bus
    with       X isa airbus
id  not flag(airbus),
    add flag(airbus)
ip  internal_airbus(true),
    bound(X),
    airbus(X),
    set(airbusflag,true),  %% must be reset initially
    set(actual_domain,fb).  %% reset in interapp

airbusquery2 rule
is  context X isa route  %% not class airbus
id  not flag(airbus),
    add flag(airbus)             %% Somewhat dirty
ip  internal_airbus(true),bound(X),
    airbus(X),
    set(airbusflag,true),  %% must be reset initially
    set(actual_domain,fb).  %% reset in interapp


airbusquery3 rule
is  context _X isa airbus
id  not flag(airbus),
    add flag(airbus)             %% Somewhat dirty
ip  internal_airbus(true),
    set(airbusflag,true),  %% must be reset initially
    set(actual_domain,fb).


airbusquery4 rule
is  context _Værnes isa airport
id  not flag(airbus),
    add flag(airbus)
ip  internal_airbus(true),
    set(actual_domain,fb),
    set(airbusflag,true).


%%%%% subtle, swaps sequence of sentrum flyplass -> værnes sentrum
%%    replacement starts at first occurrence of first item ( free(X) isa airport)
tofromairport rule
is  replaceall (  srel/TO/place/free(X)/E , free(X) isa airport) %#%
    with       (  værnes isa airport,  srel/TO/place/Værnes/E ),
    add flag(airbus)
id  []
ip  internal_airbus(true),
    default_destination(fb,Værnes),
    set(airbusflag,true),
    set(actual_domain,fb).



% Nightbus section %%

nightbusquery1 rule   %% bus 999 -> nightbus 999 if nightbus
is  replaceall X isa bus
    with       X isa nightbus
id  not flag(nightbusflag),
    add flag(nightbusflag)
ip  bound(X),
    nightbus(X),
    userNOTME: set(nightbusflag,true).  %% must be reset initially

nightbusquery2 rule
is  context X isa route  %% not class nightbus
id  not flag(nightbusflag),
    add flag(nightbusflag)             %% Somewhat dirty
ip  bound(X),
    nightbus(X),
    userNOTME: set(nightbusflag,true).  %% must be reset initially

nightbusquery3 rule
is  context _X isa nightbus
id  not flag(nightbusflag),
    add flag(nightbusflag)             %% Somewhat dirty
ip  userNOTME: set(nightbusflag,true).  %% must be reset initially

nightbusquery4 rule   %% move this after shunt ?
is  context _x isa midnight,
    not doit/exist/_x/_  ,
    not srel/before/time/_/_ ,   %% before midnight is NOT nightbus
    not nrel/before/_/time/_/_, %%
    not srel/around/time/_/_ ,   %% around  midnight is not? nightbus
    not nrel/around/_/time/_/_ %%
id  not flag(nightbusflag),
    add flag(nightbusflag)             %% Somewhat dirty
ip  userNOTME: set(nightbusflag,true).  %% must be reset initially


donot rule %% dont do that
is  doit, (not _),
    clear
id  clear,
    add reply('OK')
ip  [].


modifier0 rule  %% empty modifier
is  exactly (modifier(_),event/_/_)
id  add message(completesentence)
ip  [].


modifier1 rule %%  med buss til buenget
is  context B isa Bus,
    not ispresent _ isa endstation,  %% Ad Hoc
    replaceall modifier(C)
    with  (which(A),A isa time,doit/go/B/C,srel/in/time/A/C)
id  []
ip  dmeq([bus,nightbus,route,tram],Bus),newfree(A).


modifier1a rule  %% busser i tide %% not 1A (\spyr command)
is  context  srel/ION/time/A/C, {dmeq([in,on,nil],ION)}, %% nil
    not _ isa endstation,
    not _ isa  tram,
    replaceall modifier(C)
    with  (which(A),B isa bus,doit/go/B/C)
id  []
ip  newfree(B).

modifier1b rule  %% buss på lørdag morgen
is  context  srel/ION/morning/A/C, {dmeq([in,on,nil],ION)},   %% nil
    not _ isa endstation,
    not _ isa  tram,
    replaceall modifier(C)
    with  (which(A),B isa bus,doit/go/B/C)
id  []
ip  newfree(B).


modifier2 rule %% Til nardosenteret
is  not ispresent doit/go/_/_ ,
    not _ isa  tram,
    replaceall modifier(C)
    with  (which(A),B isa bus,
          %%%  adj/nil/next/B/real,  %% gets more buses
			 %% "affects  Buster dialog %%
            A isa time,doit/go/B/C,srel/in/time/A/C)
id  []
ip  newfree(A),newfree(B).



modifiergo0 rule %% from A in order to goto B
is  replaceall (modifier(C),doit/go/I/K)
    with  (which(A),B isa bus,doit/go/B/C,A isa time,srel/in/time/A/C),
    {unbound(I)},
    {unbound(K)}
id  []
ip  newfree(B),newfree(A).


modifier3 rule %% Bloody repair rule
is  replaceall (modifier(E),srel/nil/_Stat/F/E)
    with       (which(F))
id  []
ip  [].


departurestat rule % departure A -> from A
is replaceall
   (srel/nil/departure/B/A,event/real/A,nrel/nil/departure/place/B/Risvollan)
    with
    (srel/from/place/Risvollan/A,event/real/A)
id  []
ip  [].


arrivalstat rule %%  departure A ->  to  A ( Not tested)
is  replaceall  (srel/nil/arrival/B/A,event/real/A,nrel/nil/arrival/place/B/Risvollan)
     with       (srel/to/place/Risvollan/A,event/real/A)
id  []
ip  [].

srelbeforeplace rule  % buss går før X2 %% TA-110624  = between HT and X2
is  replaceall (srel/before/place/X2/E)
    with       (srel/from/place/hovedterminalen/E,srel/to/place/X2/E)
id  []
ip  [].


srelbetweenplace rule  % buss går mellom  X1 og X2
is  replaceall (srel/Between/place/(X1,X2)/E)
    with       (srel/from/place/X1/E,srel/to/place/X2/E)
id  []
ip  dmeq([between,past],Between).


srelbetweentoplace rule  % buss går mellom X1 til X2
is  context srel/to/place/_X2/E ,
    replaceall srel/between/place/X1/E
    with       srel/from/place/X1/E
id  []
ip  [].


nrelbetweenplace rule  % buss mellom A og B
is  replaceall (nrel/Between/Bus/place/B/(X1,X2))
    with       (nrel/from/Bus/place/B/X1,nrel/to/Bus/place/B/X2)
id  []
ip  dmeq([between,past],Between).


nrelforbus rule % avgang for B1 og B2
is  replaceall  nrel/for/departure/Ve/F/(A,_B)
    with        nrel/for/departure/Ve/F/A
id  add message(onlyonebus)
ip  [].

nrelday rule   % buss på torsdag og fredag
is  replaceall (nrel/Prep/Bus/Day/B/(X1,_X2))
    with       (nrel/Prep/Bus/Day/B/X1)
id  add        message(onlyoneday)
ip  dmeq([day],Day).


%% tuc isa program -> tuc isa savant %% etc
knowifexist rule %% = test
is  replaceall
             (test,tuc isa savant,doit/exist/A/D,tell/myid/whether/tuc/B/C,event/real/C,event/B/D)
    with     (test, doit/exist/A/C,event/real/C)
id  []
ip  [].


shuntaroundtime rule %% i halv tre tiden -> halv tre
is replaceall srel/around/time/T/E
   with       srel/nil/time/T/E
id  []
ip  []
:- double.


shuntbetweentime rule %% same event
is  replaceall (nrel/Between/_/Time/A/(X1,X2))
       with    (doit/be1/A/E, event/real/E,
                srel/between/Time/(T1,T2)/E)
id  []
ip  dmeq([in,between],Between), %% i tidsrommet X1 og X2
    newfree(E),
    sorttimes(X1,X2,T1,T2).


shuntbetween1 rule %% same event
is  replaceall (nrel/Between/_/Time/A/(X1,X2))
       with    (doit/be1/A/E, event/real/E,
                srel/from/Time/X1/E, srel/to/Time/X2/E)
id  []
ip  dmeq([in,between],Between), %% i tidsrommet X1 og X2
    newfree(E).

shuntbetween2 rule  % i tidrsommet  mellom T1 til T2
is  replaceall (nrel/Between/D/Time/A/X1, nrel/to/D/Time/A/X2)
       with    (doit/be1/A/E, event/real/E,
                srel/from/Time/X1/E, srel/to/Time/X2/E)
id  []
ip  dmeq([in,between],Between), %% i tidsrommet X1 og X2
    newfree(E).


nrelplaceand rule %% bus from A and B
is  replaceall (nrel/Prep/Bus/place/B/(X1,X2)) %% rute 9 og 6 *
    with       (nrel/Prep/Bus/place/B/X1,nrel/Prep/Bus/place/B/X2)
id  [] %%  add message(onlyoneplace) leave it to other rules
ip  [].


nrelplaceor rule %% bus from A or  B
is  replaceall  nrel/Prep/Vehicle/place/A/(B;_C)
    with        nrel/Prep/Vehicle/place/A/B
id  addcon message(onlyoneplace)
ip  [].


srelstationnear rule %% to a station near
is  replaceall (B isa station,doit/be1/B/C,srel/Near/place/Heimdal/C,srel/Prep/place/B/D)
    with       (srel/Prep/place/Heimdal/D)
id  []
ip  dmeq([near,at],Near).


srelbetweenplace rule  %% bus between  A ,  B
is  replaceall  srel/between/place/(B,C)/E
    with       (srel/from/place/B/E, srel/to/place/C/E)
id  []
ip  [].


passplaceand1 rule  %% passes NS and BE
is  not ispresent srel/nil/place/_SVB/_,
    replaceall  dob/pass/A/(NS,BE)/E
    with        (doit/go/A/E,srel/from/place/NS/E,srel/to/place/BE/E)
id  []
ip  [].


srelplaceand1 rule  %% past A and B
is  not ispresent srel/nil/place/_SVB/_, %% sverresborg til A and B
    replaceall  srel/Past/place/(B,C)/E
    with        (srel/from/place/B/E,srel/to/place/C/E)
id  []
ip  dmeq([past,for,to],Past). %% To A and B means from A to B


srelplaceand2 rule %% to A and  B
is  replaceall  srel/Prep/place/(B,_C)/E
    with        srel/Prep/place/B/E
id  add message(onlyoneplace)
ip  [].


srelplaceor rule %% to A or B
is  replaceall  srel/Prep/place/(B;_C)/E
    with        srel/Prep/place/B/E
id  add message(onlyoneplace)
ip  [].

srelvehor rule %% buss sju eller åtte
is  replaceall  srel/Prep/vehicle/(B;_C)/E
    with        srel/Prep/vehicle/B/E
id  add message(onlyonebus)
ip  [].


back rule %  and back
is  srel/back/place/nil/_
id  add message(toomanyplaces),
    add flag(exit)
ip  [].


return rule %  and back
is  _ isa return
id  not message(onlyonesentence),   %% comes first, but should have been omitted
    add message(toomanyplaces)
ip  [].


busintimerepair rule % buss (i tiden ) 1700 1800
is  context (T1700 isa Tim1,T1800 isa Tim2 ),
    replaceall (nrel/INIL1/BDA/Tim3/B/T1700,nrel/INIL2/BDA/Tim4/B/T1800)
    with       (nrel/between/_BusDep/time/B/(Tmin,Tmax))
id  []
ip  dmeq(timeclock,Tim1),
    dmeq(timeclock,Tim2),
    dmeq(timeclock,Tim3),
    dmeq(timeclock,Tim4),
    dmeq([in,nil],INIL1),
    dmeq([in,nil],INIL2),
    number(T1700),number(T1800),
    minval(T1700,T1800,Tmin),
    maxval(T1700,T1800,Tmax).


canigetinfo rule %% can i get info
is  replaceall
        (test,A isa self,B isa information,nrel/About/information/thing/B/X,
         event/real/E, dob/Receive/A/B/E) %% the event is irrelevant
    with       (which(X))
id  []
ip  dmeq(about,About),
    dmeq([receive,get,see],Receive).


iwillhaveinfo rule %% jeg ønsker informasjon om
is  replaceall (new,A isa self,B isa information,nrel/About/information/thing/B/X,
               has/agent/information/A/B)
    with       (which(X))
id  []
ip  dmeq(about,About).


iwantinfo rule %% jeg ønsker informasjon om
is  replaceall (new,A isa self,want/A/B/_, B isa information,nrel/About/information/thing/B/X)
    with       (which(X))
id  []
ip  dmeq(about,About).


givemeinfo rule % gi meg informasjon om
is  exactly  (doit,tuc isa savant,Inf isa information,
              dob/give/tuc/Inf/E,event/real/E),
    clear
id  add message(mustknow(place))
ip  [].

benamedsubjobj  rule %% Hva heter bussene
is  replaceall (which(A),dob/be_named/A/B/_, B isa Bus)
    with       (which(B),B isa Bus)
id  []
ip  [].

benamehewho  rule %% Hva heter han som = hvem %% TA-110620
is  replaceall
     (which(F19),dob/be_named/F20/F19/_,F19 isa thing,F20 isa _Man)
    with
     (which(F20),F20 isa agent),
    {unbound(F20)}  %% TA-110627
id  []
ip  [].

benamedobjsubjthing rule %% Hva heter holdeplassene (hvilken x, hpl heter x)
is  replaceall (which(A),dob/be_named/B/A/_, A isa thing,B isa Stat)
    with       (which(B),B isa Stat),
    {unbound(B)}
id  []
ip  [].

benamedobjsubj rule %% Hva heter holdeplassene (hvilken x, hpl heter x)
is  replaceall (which(A),dob/be_named/B/A/_, B isa Stat)
    with       (which(B),B isa Stat),
    {unbound(B)}
id  []
ip  [].


be2awh rule %% Hva er holdeplassene
is  not _ isa clock, %% tricky
    replaceall (which(A),A isa thing,dob/be/B/A/_, B isa Price)
    with       (which(B),B isa Price),
    {unbound(B)}
id  []
ip  [].

be2bwh rule %% Hva er holdeplassene
is  not _ isa clock, %% tricky
    replaceall (which(A),A isa thing,dob/be/A/B/_, B isa Price)
    with       (which(B),B isa Price),
    {unbound(B)}
id  []
ip  [].

be2thing rule %% hvilken uke er dette %% TA-110203
is
    replaceall (which(A),dob/be/B/A/_, B isa thing)
    with       (which(A)),

    {unbound(B)}
id  []
ip  [].


be2a rule %% Hva er billettprisen : which(A), B isa price & dob/be/B/A/D
is  not _ isa clock, %% tricky
    not _ isa date,
    replaceall (which(A),dob/be/B/A/_, B isa Price)
    with       (which(B),B isa Price),
    {unbound(B)}
id  []
ip  [].


be2b rule %% hvilke busser er det fra ...
is  replaceall (which(A),dob/be/A/B/_, B isa Bus)
    with       (which(B),B isa Bus)
id  []
ip  unbound(B).



nowash1 rule  % ingen info om ren
is  adj/_/clean/_/_
id  add message(noinfoabout(cleaning ))
ip  [].

nowash2 rule  % ingen info om renhold
is  dob/clean/_/_/_
id  add message(noinfoabout(cleaning ))
ip  [].


runttgo rule %% hvor kjører TT ?
is  which(A),A isa place, tt isa company,doit/run/_/_, srel/nil/place/A/_,
    clear
id  add listofall(bus,_),
    add flag(exit)
ip  [].


runvehgo rule %% intransitive run=go, simplify rules
is  context X isa Veh, {dmeq(vehicle,Veh)}, %% dont eat
    replaceall (doit/run/X/Y)
    with       (doit/go/X/Y)

id  []
ip  [].


midday0 rule % mid day is 1200
is  replaceall (B isa noon,nrel/in/bus/time/C/B)
    with       (nrel/around/bus/time/C/1200)
id  []
ip  [].



whathaveyouinfoabout rule % what have you info about
is  replaceall (which(A),B isa information,
                nrel/About/information/thing/B/A,
                has/agent/information/tuc/B,event/real/C)
    with        (which(A),dob/know/tuc/A/C,event/real/C)
id  []
ip  dmeq([about,over,regarding],About).


secondlast rule %% nestsiste %%
is  replaceall (adj/_/second_last/A/B)
    with       (adj/_/second/A/B,adj/_/last/A/B)
id  []
ip  [].


amonplaceandshallbeonplace rule   %% er på og skal til
is  ispresent doit/arrive/A/_,           %% ad hoc
    replaceall (doit/Be1/A/S, srel/NATO/place/B/S) %% hopefully in sequence
    with       (doit/go/A/S, srel/from/place/B/S),
    {dmeq([be1,befind,stand,sit],Be1)}, %%  og befinner meg
    {dmeq([at,on,in],NATO)} %% drop nil
id  []
ip  [].


arriveniltime rule   %% Norw  BUS ankomme kl 10
is  ispresent  A isa Bus,{dmeq(vehicle,Bus)}, %% I arrive may mean  at start station
    replaceall (doit/arrive/A/S, srel/nil/time/B/S)
    with       (doit/go/A/S, srel/before/time/B/S)
id  []
ip  [].


leave2 rule   %% Norw  forlate
is  replaceall (dob/leave2/A/B/S)
    with       (doit/go/A/S, srel/from/place/B/S)
id  []
ip  [].


pastab rule %% go past A, B
is  replaceall (srel/past/place/(A,B)/E)
    with       (srel/past/place/A/E,srel/past/place/B/E)
id  []
ip  [].


edemang rule %% is it many that (Norw)
is  replaceall (test,quant(gt/2,A))
    with       (howmany(A))
id  []
ip  [].

counthowmany  rule % hva er antall busser
is  replaceall (which(X),quant(count,X))
    with       howmany(X)
id  []
ip  [].

removequantall  rule % kan du hele rutetabellen
is  remove  quant(all,_)
id  []
ip  [].


knowstation rule %% TUC knows station
is  context (tuc isa savant,A isa station),
    replaceall (test,dob/KNOW1/tuc/A/E )
    with       (doit, dob/describe/tuc/A/E),
    {dmeq([know,know1],KNOW1)}
id  []
ip  bound(A).


isused rule %% is used means exists
is replace  adj/_/use/A/B
   with     doit/be1/A/B
id []
ip [].


toomanyhours rule
is  NotClock isa hour, {number(NotClock),NotClock > 5},
    clear
id	 add message(inconsistentduration),
    add flag(exit) % finish it
ip	 [].


toomanyminutes  rule
is  NotClock isa minute, {number(NotClock),NotClock > 300},
    clear
id	 add message(inconsistentduration),
    add flag(exit) % finish it
ip	 [].


witharrivaltime rule %% with arrival Time means before Time
is  ET isa arrival,
    replaceall nrel/pwith/bus/arrival/Time/ET
    with       nrel/before/bus/time/Time/ET
id  []
ip  [].


beduring2time rule %% Skal være om 30 minutter = FØR
is  context (I isa self,doit/be1/I/E),
    replaceall (srel/during2/time/X/E,X isa Minute)
    with  (X isa Minute,srel/within/duration/X/E)
id  []
ip  dmeq(timeunit,Minute).

arriveduring2time rule %% ankommer  om 30 minutter = FØR
is  context (I isa self, doit/arrive/I/E),
    replaceall (srel/during2/time/X/E,X isa Minute)
    with  (X isa Minute,srel/within/duration/X/E)
id  []
ip  dmeq(timeunit,Minute).


duringevening rule %%  buss om kvelden
is  replaceall (X isa night,srel/during/time/X/E)
    with       (srel/in_night/time/nil/E)
id  []
ip  [].


eveningbus rule %% evening bus
is  replaceall (B isa eveningbus)
    with       (B isa bus,srel/after/vehicle/time/B/1800)
id  []
ip  [].

morningbus rule %% morning bus
is  B isa morningbus, % not replace, keep as memory
    add (B isa bus, nrel/before/bus/time/B/1100)
id  []
ip  [].

traveldisttime rule
is  replaceall (nrel/from/Duration/place/A/Nth,nrel/to/Duration/place/A/Risvollan)
    with       (B isa bus,nrel/from/bus/place/B/Nth,nrel/to/bus/place/B/Risvollan,
                nrel/pwith/duration/vehicle/A/B)
id []
ip newfree(B),dmeq(duration,Duration). %% distance or duration


travellength rule %% travel length
is  context B isa duration,
    replaceall   (which(A),A isa length, has/time/length/B/A)
    with         (which(B))
id  []
ip  [].


directionfromtown rule % from place out from hoveterminalen means to place
is  replaceall (nrel/from/bus/place/S/C,B isa direction,
                nrel/from/direction/place/B/hovedterminalen)
    with       (nrel/to/bus/place/S/C)
id  []
ip  [].


directionfrom rule % from place in direction  hoveterminalen means from  place
is  replaceall (B isa direction,nrel/from/direction/place/B/N,srel/WIN/direction/B/C)
    with       (srel/from/direction/N/C)
id  []
ip  dmeq([with,in,nil],WIN).


yourjob  rule % hva er jobben DIN %%  before no info about noun
is  %% which(_),
    has/agent/Job/tuc/_,
       {dmeq([job,service,task],Job)}
id  add message(howtuchelp),
    add flag(exit)
ip  [].



infohelp rule % (gi meg) informasjon
is  which(A),(B isa information,event/real/C,dob/be/B/A/C)
id  add message(howtuchelp)
ip  [].


whatisthis1  rule  %% hva er dette if not subsumed
is  exactly (which(A),A isa thing,event/real/E),
    not _Verb/A/E %% hva kjører
    %% not  has/self/thing/_/_ %% hva skal vi ha til middag
id  add message(howtuchelp)
ip  [].


whatisthis2  rule  %% hva er dette %%after be2a
is  which(A),B isa thing,event/real/C,dob/be/B/A/C
id  add message(howtuchelp)
ip  [].

whatisit     rule %% hva er det
is  which(it),it isa thing
id  add  message(howtuchelp)
ip  [].


telljoke rule
is  Bustuc isa savant,A isa Joke, dob/tell/Bustuc/A/_
id  add  message(howtuchelp)
ip  dmeq(tuc,Bustuc),
    dmeq([joke,sentence],Joke). %% etc  :-)



seesomething rule
is  replaceall (Nova isa _place, A isa _Movie, nrel/on/_/place/A/Nova, dob/see/I/A/B)
    with       (Nova isa _place, doit/go/I/B, srel/to/place/Nova/B)
id  []
ip  [].


wonderquery rule
is  replaceall (new,query/I/B/_,I isa _Whatever)
    with       (which(B))
id  []
ip  [].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



standardclock rule %% <-------- %%  FRONTED
is replaceall srel/nil/clock/T/E
   with       srel/nil/time/T/E
id []
ip number(T).



%%%%%%%%%%%%%% No srel/nil/clock/T/E  below this line %%


intimeperiodto rule  %%  I tiden 8 til 9 // both numbers
is  replaceall ( srel/in/time/T1/B, srel/to/clock/T2/B)
    with       ( srel/after/time/T1/B, srel/before/time/T2/B),
    not        srel/nil/time/_/B %% når går rute 8 klokken 8 til kl 9  %% Panic
id  []
ip  bound(T1),bound(T2).


nestsiste rule %% repair %% ( should be taken in grammar)
is  replaceall (adj/_/next/R9/_C,adj/_/last/R9/C) %% adj events are free
    with       (adj/_/second/R9/C,adj/_/last/R9/C)
id  []
ip  [].


nestførste rule %% repair %% ( should be taken in grammar)
is  replaceall (adj/_/next/R9/_C,adj/_/first/R9/C) %% adj events are free
    with       (adj/_/second/R9/C)
id  []
ip  [].

answerin rule
is  replaceall (Norwegian isa language,Answer/tuc/A,srel/ION/_Language/Norwegian/A)
    with       (Norwegian isa language,speak/tuc/Norwegian/A)
id  []
ip  dmeq([tell,answer],Answer),dmeq([in,on],ION),
    Norwegian \== nynorsk. %% :-)

eveningbus rule
is  replaceall (A isa eveningbus)
    with       (A isa bus,  1800 isa clock,nrel/after/bus/time/A/1800)
id  []
ip  [].


eveningroute rule
is replaceall (A isa eveningroute,doit/go/A/B)
       with   (A isa route,N isa night,doit/go/A/B,srel/in/time/N/B)
id  []
ip  newfree(N).

beforebefore rule
is  not ispresent srel/after/time/_/_, %% > 2 clocks
    replaceall  (X isa clock, Y isa clock, srel/nil/time/X/D, srel/nil/time/Y/D)
    with        (X isa clock, Y isa clock, srel/after/time/Low/D, srel/before/time/High/D)
id  []
ip  number(X),number(Y),sorttimes(X,Y,Low,High).


giveansin rule
is   replaceall (A isa answer, nrel/on/sentence/language/A/L,dob/give/tuc/A/B)
     with       (tell/tuc/B, srel/on/thing/L/B)
id  []
ip  [].


numbergo rule %% går nummer 52 til NTH
is  replaceall (A isa number,doit/go/A/B)
    with       (A isa bus,doit/go/A/B)  %%  <- vehicle
id  []
ip  [].   %% need error message if not bound(A),exbus(A).


monthlyfare rule
is  replaceall (adj/_/monthly/X/_,X isa Fare)
    with       (X isa special_ticket)
id  []
ip  dmeq([fare,price],Fare).

clockhours rule
is  replaceall (S isa hour) %% 1800 hours is ambigous
    with       (S isa clock)
id  []
ip  number(S), S > 48.


flatter0 rule %% har du fått TA på hjernen ? :-)
is  test, tuc isa savant,TA isa person, srel/on/mind/_/E, dob/Have/tuc/TA/E,
    {dmeq([have,get,receive],Have)}
id  add message(onthecontrary),  %% :-)
    add flag(exit)
ip  [].


flatterc rule %% TA-110106
is  new, tuc isa savant,'I' isa self,_ isa compliment
id  add message(thanks)
ip  [].


flatter1 rule
is  new, tuc isa savant,adj/_/Intel/tuc/A,event/real/A, clear
id  add message(thanks)
ip  dmeq([intelligent,smart,good,clever,nice,funny],Intel). %% TA-101110


flatter2 rule
is  new,  adj/_/best/B/real, dob/be/Bustuc/B/_D, clear
id  add message(thanks),
    add flag(exit)
ip  dmeq([bustuc,tuc],Bustuc).


flatter3 rule %% TA-101117 bussoraklet er det beste systemet.
is  new, B isa oracle,adj/nil/best/A/real,dob/be/B/A/_, clear
id  add message(thanks),
    add flag(exit)
ip  [].

flatter4 rule %% det er bra at du ... %% TA-110518
is  new,A isa coevent,
    adj/nil/good/A/_,event/A/C,   doit/be1/tuc/C
id  add message(thanks),
    add flag(exit)
ip  [].



goodjob  rule %% You do a good job
is  new,tuc isa savant,A isa job,do1/tuc/A/_,adj/_/Intel/A/_
id  add message(thanks)
ip  dmeq([intelligent,smart,good,clever],Intel).


withoutfer rule
is  replaceall (A isa transfer,srel/without/transfer/A/E)
    with (srel/directly/pmode/nil/E)
id  []
ip  [].


withoutcofer rule %% without coevent B in which change happens
is  replaceall (srel/without/coevent/_/E, dob/change/_/_/E)
    with (srel/directly/pmode/nil/E)
id  []
ip  [].



hourafter1 rule
is  replaceall (doit/go/A/C,srel/nil/hour/B/C, B isa hour,nrel/after/duration/clock/B/Time)
    with       (doit/go/A/C,srel/after/time/Time60/C)
id  []
ip  unbound(B),
    number(Time),
    main:addtotime(Time,60,Time60).

hourafter2 rule
is  replaceall (doit/go/A/C,srel/nil/hour/B/C, B isa hour,nrel/after/duration/clock/B/Time)
    with       (doit/go/A/C,srel/after/time/Time60/C)
id  []
ip  number(B), Min is B*60,
    number(Time),
    main:addtotime(Time,Min,Time60).


graakallen rule  %% Gråkallen syndrom (NOT synbus)
is  replaceall (gråkallbanen isa tram,doit/go/gråkallbanen/E)
    with       (F isa tram,doit/go/F/E)
id  []
ip  thetramno(F). %%  (busdat).

%%  longto rule %% unevokable

walkingdistance rule
is  replaceall (B isa walking_distance,
                nrel/from/distance/place/B/City_syd,srel/in/distance/B/C,event/real/C)
    with       (srel/near/place/City_syd/C,event/real/C)
id  []
ip  [].


teach rule
is  replaceall (Teach/I/A,srel/on/place/D/A)
    with       (doit/be1/I/A,srel/on/place/D/A)
id  []
ip  dmeq([teach],Teach).  %% preach, sing,


takenilafter rule %% Repair rule ,  before inordertobe
is  not ispresent dob/reach/_/_/_,  %% ad hoc
    not nrel/to/vehicle/place/_/_, %% til valentinlyst Hack ?
    not srel/in_order_to/_/_/_, % removed earlier ????

    not srel/so_that/_/_/_,  %% TA-110413   hvis jeg vil være i sentrum kl 20.10?
                 %% TA-100920 +++  når er jeg på heimdal dersom jeg ta buss nummer 9

    not srel/because_of/_/_/_,  % error in gramn
%%%%%%%%%%%%%    not srel/on/place/_/E,  %% TA-100920  Bloody hack / skal til og VÆRE på
    not srel/to/place/_/E,
    replaceall (dob/take/I/B/E, srel/nil/time/T/E2) %% E2  hack
    with       (dob/take/I/B/E, srel/after/time/T/E2)
id  []
ip  [].


whyareyou rule
is  _ isa meaning,nrel/pwith/meaning/thing/_/Bustuc,
    not _ isa life %%  :-)
id  add message(howtuchelp)
ip  dmeq([bustuc,busstuc,buster,tuc,free(_),it],Bustuc).

equinox rule
is   Nox isa date,
    {dmeq([vernal_equinox,autumnal_equinox,summer_solstice,winter_solstice],Nox)}
id  add message(mustknow(date)),
    add flag(exit)
ip  [].


haveyoubeenin rule
is  doit/be1/tuc/E,srel/in/V/_/E
id  add message(thatisimpossible)
ip  unbound(V). %%  where have yoy been ?

getholdon rule
is  replaceall (A isa hold,nrel/in/hold/vehicle/A/B,dob/receive/I/A/C)
    with       (dob/take/I/B/C)
id  []
ip  [].

tofromjob rule
is  replaceall (C isa job,nrel/on/job/place/C/PS,nrel/From/vehicle/place/B/C)
    with       (nrel/From/vehicle/place/B/PS)
id  []
ip  [].

raskpaa rule
is  replaceall (B isa way,adj/_/Best/B/_,srel/on/way/B/D)
    with       (srel/hereafter/time/nil/D)
id  []
ip  dmeq([fast,best],Best). %%  etc.


nearestfuture rule
is  replaceall (C isa future, adj/_/next/C/D)
    with       (srel/hereafter/time/nil/D)
id  []
ip  [].

speedy rule
is  replaceall (A isa speed,doit/go/X/E, srel/nil/speed/A/E)
    with       (A isa duration,doit/go/X/E,srel/pwith/duration/A/E)
id  []
ip  [].


aftereight rule %% om morgenen etter 8
is  context  C isa morning,
    replaceall (nrel/during2/_Veh2/time/B/C, nrel/after/Veh1/time/B/Eight)
    with       (nrel/after/Veh1/time/B/Eight)
id  []
ip  number(Eight),Eight =< 1200.


beforeeight rule %% Ad hoc rule when both morning and evening
is  replaceall (srel/in_night/time/nil/E,srel/in/time/A/E,srel/to/clock/Eight/E)
    with       (srel/after/time/Twenty/E,srel/in/time/A/E)
id  []
ip  evening_time(Eight,Twenty).


untiltime rule
is  replaceall (srel/until/time/N/E) %% \+ coevent
    with       (srel/before/time/N/E)
id  []
ip  [].


isittakeit rule
is  context  A isa duration,
    replaceall (doit/be1/it/B,srel/nil/time/A/B)
    with       (dob/take/it/A/B)
id  []
ip  [].


answer0 rule   %% hve svarer på spørsmål
is  A isa agent,B isa question,answer1/A/C,srel/on/thing/B/C,event/real/C,
    clear
id  add message(howtuchelp)
ip  [].

answer1 rule   %%  answer1 is strictly intransitive
is  replaceall answer1/X/Y
    with       tell/X/Y
id  []
ip  [].


withroute rule
is  replaceall ( nrel/pwith/vehicle/number/F/H,  H isa Route,F isa Bus)
    with       ( H isa Route,F isa Bus, has/vehicle/number/F/H)
id  []
ip dmeq([number,route],Route), %% number 8 =-= route 8
   dmeq([bus,nightbus,tram,vehicle],Bus),
   bound(H).


wheredoifind rule
is  replaceall (which(P),P isa place,
                I isa Self,
                find/I/NTH/S, NTH isa Placoid,srel/in/_Thing/P/S)
    with       (which(P),P isa place,
                doit/be1/NTH/S,    NTH isa Placoid,srel/in/place/P/S),
   {dmeq([person,self],Self)}
id  []
ip  dmeq(place,Placoid).


isto rule %% Repair rule  %%  Telefon_  TIL  TT
is  replaceall (doit/be1/A/E, srel/to/_Agent/TT/E,A isa Telephone, TT isa Company)
    with       (TT isa Company,A isa Telephone, has/Company/Telephone/TT/A)
id  []
ip  dmeq([telephone,webaddress],Telephone).  %% ETC -> busdat


ison rule %% Repair rule  %%  nummer på  bussen
is  replaceall (doit/be1/A/E, srel/on/_Company/TT/E, A isa Telephone, TT isa Company)
    with       (TT isa Company,A isa Telephone, has/Company/Telephone/TT/A)
id  []
ip  dmeq([telephone],Telephone).  %% ETC

onlyon rule %% Repair rule  %%  nummer på  bussen
is  replaceall (which(A),srel/on/_Company/TT/_,A isa Telephone, TT isa Company)
    with       (which(A), TT isa Company,A isa Telephone, has/Company/Telephone/TT/A)
id  []
ip  dmeq([telephone],Telephone).  %% ETC


spectick rule
is  replaceall (B isa ticket,adj/_/special/B/_C)
    with       (B isa special_ticket)
id  []
ip  [].

holi_day rule
is  replaceall (D isa day,adj/_/Holy/D/_E)
    with       (D isa holiday)
id  []
ip  dmeq([holy,red],Holy).


amorrow rule
is  replaceall (D isa morrow,srel/in/time/D/E)
    with       (srel/tomorrow/day/nil/E)
id  []
ip  [].



be2eliminate  rule  %% HVA ER       drastic
is replaceall  (which(A),dob/be/B/A/_)
     with      (which(B)),
     not  B isa _ %%  only HVA ER
id  []
ip  unbound(A),unbound(B).


be2repair rule %% before clock is 1800
is  replaceall (dob/be/B/T0/E, srel/in/time/C/E, event/real/E,
                C isa time,B isa clock,
                doit/go/A/D,srel/Prep/time/C/D,event/real/D)
    with       (T0 isa clock,doit/go/A/E,srel/Prep/time/T0/E)
id  []
ip  dmeq([before,after,in],Prep). %% conj  before/after/when


ifclockrepair rule %% if clock is 1800 -> after 1800
is  replaceall (dob/be/A/T800/D, B isa reason,T800 isa clock,A isa CN,
                doit/go/X/C,srel/because_of/thing/B/D)
    with       (T800 isa clock,doit/go/X/C,srel/after/time/T800/C),
    {dmeq([number,clock],CN),unbound(A)}
id  []
ip  [].


itimeor rule   %% kl 11 eller 13
is  replaceall
      srel/in/time/(T1100;T1130)/E
    with
      srel/between/time/(T1100,T1130)/E
id  []
ip  [].

nameon rule %% Name on a thing X = the thing X
is  replaceall (dob/list/tuc/A/E,nrel/On/name/_Thing/A/B,A isa name,B isa Bus)
    with       (dob/list/tuc/B/E,B isa Bus)
id  []
ip  dmeq([on,to,of],On).

nameof rule % subsumed ???
is  replaceall (which(A), nrel/On/name/_Thing/A/T,A isa name)
    with       (which(T))
id  []
ip  dmeq([on,to,of],On).


smsprice rule
is  adj/_/sms/_/_   ,
    not tmn isa company,
    dob/cost/_B/_A/_C,
    clear %% have their own
id  clear,
    add message(smsprice(NOK1)),
    add flag(exit)
ip  has_att_val(sms,price,tt,NOK1).


smsrule1 rule
is  adj/_/sms/_/_   ,
    not tmn isa company,
    not dob/cost/_B/_A/_C,
    clear %% have their own
id  clear,
    add(message(smshelp)),
    add flag(exit)
ip  [].

smsrule2 rule  % er du tilgjengelig på sms ?
is  _ isa sms, not tmn isa company,
    not ispresent _ isa price,
    clear %% have their own
id  clear,
    add(message(smshelp)),
    add flag(exit)
ip  [].

smsrule3 rule  %% er du tilgjengelig på mobil ?
is  _ isa mobile, not tmn isa company, not dob/cost/_/_/_,  clear
id  clear,
    add(message(smshelp)),
    add flag(exit)
ip  [].


phonerule1 rule  %% er du tilgjengelig på telefon ?
is  adj/_/available/tuc/B,srel/on/telephone/_/B
id  clear,
    add(message(phonehelp)),
    add flag(exit)
ip  [].


toab rule %% to A and B
is replaceall (srel/TOBY/place/(A,B)/E)
   with       (srel/TOBY/place/A/E,srel/to/place/B/E)
id []
ip dmeq([to,by],TOBY).  %% NOT between


leavef   rule  %% Leave a station means go FROM station to center
is   replaceall (dob/leave/A/B/C,event/real/C)
     with       (doit/go/A/C, srel/from/place/B/C)
id   []
ip   [].


ihaveaq rule % I have a question
is  replaceall (new, I isa self, A isa question,
                has/agent/question/I/A, nrel/regarding/information/thing/A/B)
    with       (which(B))
id  []
ip  [].


listover  rule
is replaceall (tuc isa savant,A isa list,nrel/Over/list/thing/A/B,dob/Give/tuc/A/C)
   with       (tuc isa savant,dob/show/tuc/B/C)
id  []
ip  dmeq([give,receive,show,make],Give),
    dmeq([over,with,for,about,regarding],Over).


depofbus rule %%   before shunt
is  replaceall (which(A),B52 isa bus,A isa departure,nrel/_To/departure/_Bus/A/B52)
    with       (which(A),B52 isa bus,A isa time,doit/go/B52/B,srel/in/time/A/B,event/real/B)
id  []
ip  [].



%%% jeg er på risvollansenteret og har et møte i dragvoll.
% ***** => jeg er i dragvoll  og har et møte på risvollansenteret

%% fra  Kongsvegen på Heimdal til St. Olavs hospital? -->
%% doubleshunt makes on heimdal on par with the other

nildeparture rule
is  replaceall (nrel/nil/departure/place/A/Nth,event/W/E)
    with       (doit/be1/A/E,srel/from/place/Nth/E,event/W/E)
id  []
ip  [].

nilarrival rule
is  replaceall (nrel/nil/arrival/place/A/Nth,event/W/E)
    with       (doit/be1/A/E,srel/to/place/Nth/E,event/W/E)
id  []
ip  [].


havemeetingaftertime rule  %% meeting after time means arrival before time
is  replaceall  (has/agent/meeting/I/A, nrel/_On/meeting/place/A/Nth ,srel/_After/time/T/B,event/W/E)
    with        (doit/arrive/I/E,srel/at/place/Nth/E,srel/before/time/T/B,event/W/E)
id  []
ip  [].


meetingaftertime rule  %% meeting after time means arrival before time
is  replaceall  (nrel/on/meeting/place/A/Nth,event/W/E,srel/_After/time/T/B)
    with        (doit/be1/A/E,srel/to/place/Nth/E,event/W/E,srel/before/time/T/B)
id  []
ip  [].



meeting01 rule  %% har møte på = skal til
is  A isa meeting,I isa self,
    replaceall (nrel/_/meeting/place/A/Place,has/agent/meeting/I/A, event/W/E)
    with       (doit/be1/I/E,srel/to/place/Place/E, event/W/E)
id  []
ip  [].


doubleshuntbe1 rule  %% already got one event, and a be1 %% Ugly
is  replaceall  (nrel/From/_/Place/A/Nth,event/W/E,doit/be1/A/E) %% avoid double
    with        (doit/be1/A/E,srel/From/Place/Nth/E,event/W/E)
id  []
ip  [].

doubleshunt rule  %% already got one event
is  replaceall  (nrel/From/_/Place/A/Nth,event/W/E)
    with        (doit/be1/A/E,srel/From/Place/Nth/E,event/W/E)
id  []
ip  [].


%%%%%%%

apply rule %% hvilket selskap gjelder BT for
is  doit/apply/_/B,A isa company,srel/for/thing/A/B
id  add message(team),
    add flag(exit)
ip  [].


laststop01 rule % last stop means end station
is  replaceall (A isa stop,adj/_/last/A/_)
    with       (A isa endstation)
id  []
ip  [].


laststop02 rule % last stop means end station
is  replaceall (A isa station,adj/_/last/A/_)
    with       (A isa endstation)
id  []
ip  [].


laststop1 rule % What is the last station for Bus
is  adj/_/last/A/_,A isa station, has/_Vehicle/station/B/A,B isa Bus
id  add endstations(B,_)
ip  bound(B), dmeq(vehicle,Bus).


laststopfor rule % What is the last station for Bus
is  A isa endstation, doit/be1/A/E,srel/For/_Vehicle/B/E, {dmeq([for,of],For)},
    B isa Bus,
    clear
id  clear,
    add endstations(B,_),
    add flag(exit)
ip  bound(B), dmeq(vehicle,Bus).


noinfoaboutvalidity rule
is  adj/_/valid/_/__, not ispresent _ isa time, %% TA-100905
    clear
id  not flag(exit),
    clear,
    addfront(message(noinfoabout(validity)))
ip  [].

noinfoaboutlength rule
is  adj/_/long/_/__,
        not ispresent _ isa time,
        not ispresent _ isa responsetime, %% TA-110111
    clear
id  not flag(exit),
    clear,
    addfront(message(noinfoabout(length)))
ip  [].


noinfoaboutmodificicatons rule
is  dob/Cancel/_/_/_, {dmeq([cancel,modify],Cancel)},
    clear
id  not flag(exit),
    clear,
    addfront(message(noinfoabout(modification)))
ip  [].


amiodd rule %% er jeg rar ? %% TA-110307
is  adj/_/Down/I/_, I isa self,
      {dmeq([bad,incomprehensible,stupid,ugly,wrong],Down)},
    clear
id  not flag(exit),
    clear,
    addfront(message(thatisimpossible))
ip  [].


noinfoabouterror0 rule
is  _ isa Problem,
        {dmeq([headache,problem, error, errormessage, correction , virus ,stability],Problem)},
    clear
id  not flag(exit),
    clear,
    addfront(message(noinfo_error_report))
ip  [].


noinfoabouterrortuc rule %%  .. you are
is  adj/_/Down/tuc/_,
      {dmeq([bad,incomprehensible,stupid,ugly,wrong],Down)},
    clear
id  not flag(exit),
    clear,
    addfront(message(noinfo_error_report))
ip  [].


noinfoabouterror rule
is  adj/_/Down/bustuc/_,
      {dmeq([down,incomprehensible,wrong],Down)},
    clear
id  not flag(exit),
    clear,
    addfront(message(noinfo_error_report))
ip  [].


noinfoabouterror1 rule
is  adj/_/Wrong/_A/E, event/_/E,  %% something IS correct
      {dmeq([bad,incomprehensible,perfect,reliable,wrong],Wrong)}, %%  \+ correct
                                                  %% er det sant at
    clear
id  not flag(exit),
    clear,
    addfront(message(noinfo_error_report))
ip  [].

noinfoabouterror2 rule
is  srel/Wrongly/pmode/nil/_, {dmeq([badly,wrongly],Wrongly)},
    clear
id  not flag(exit),
    clear,
    addfront(message(noinfo_error_report))
ip  [].


noinfoabouterror3 rule
is  doit/stop/BT/_ ,{dmeq([tuc,bustuc],BT)},
    clear
id  not flag(exit),
    clear,
    addfront(message(noinfo_error_report))
ip  [].

noinfoabouterror4 rule
is  doit/Complain/_/_ ,{dmeq([complain],Complain)},
    clear
id  not flag(exit),
    clear,
    addfront(message(noinfo_error_report))
ip  [].

noinfoabouterror5 rule %%  sby stops sthng -> error
is  dob/Stop/_/_BT/_  , {dmeq([fail,modify],Stop)}, %% gi tegn når du skal stoppe bussen p
    clear
id  not flag(exit),
    clear,
    addfront(message(noinfo_error_report))
ip  [].


noinfoaboutgod rule %% fins gud %%
is  (test,A isa god,doit/exist/A/B,event/real/B) %% TA-110530
id  not flag(exit),
    clear,
    addfront(message(godknows))
ip  [].


noeating rule %% kan jeg spise is på bussen
is  dob/eat/_/_/B,event/real/B
id  not flag(exit),
    clear,
    addfront(message( nofoodonbus)),
    add flag(exit)
ip  [].

%% TA-110214 common knowledge silly questions

noneedtoanswer1 rule %% Hvor ligger Trondhein
is  X isa city, ispresent doit/lie1/X/_,
    clear
id  not flag(exit),
    clear,
    addfront message(noneedtoanswer)
ip  [].



noneedtoanswernoun rule %% TA-110225 common knowledge silly question
is  _ isa King,         %% stupid not to know te answer, not duty
      {dmeq([capital,king,primeminister,president],King)},
    clear
id  not flag(exit),
    clear,
    addfront message(noneedtoanswer)
ip  [].


%% this is before  be2yesfact which hides isa
noinfoaboutnoun rule %% no info and TT doesnt know  either
is  _ isa Seat,
      {dmeq([
          %% brother, negans %% TA-101026
          accident,
   %%        age,    %% TA-110520
          bank,car,
          church,cinema,delay,driver,employee,god, fuel, petrol,harbour, hospital,horse,
          intelligence,headache,healthcenter,horsepower,job,kindergarten,length,
          network,gas,%% life,
          king, %% leader,  .. negans %% TA-110125
          mail,mayor, modification,motorcycle, movie,
          opening_hours,overtime,president,police,primeminister,restaurant,
          salary,seat,sequence, size,
          sportscentre,snowploughing,
          supermarket,taxi,television,tram_route_plan,tunnel,underground,
          walking_distance,weather,wheel
         ],Seat)},

    not ispresent adj/_/fast/_/_, %% raskeste vei (OK)
%%     not ispresent adj/_/best/_/_, %% TA-101026 verdens beste film
    clear
id  not flag(exit),
    clear,
    addfront(message(noinfoabout(Seat)))
ip  [].


noinfoaboutverb1 rule %%
is  doit/Work/NN/_,
      {dmeq([work],Work)}, {NN \==tuc},
    clear
id  not flag(exit),
    clear,
    addfront(message(noinfoabout(Work)))
ip  [].


be2role0 rule %% is Vestlia endeholdeplass en endeholdeplass ?
is  test,VEH isa station, {bound(VEH)},
    A isa endstation,event/real/B,dob/be/VEH/A/B,
    not (_ isa bus)
id  clear,
    add message(mustknow(bus)),
    add flag(exit)
ip  [].


be2yesfact rule %% is name a class ? %%  er 2 et tall
is  exactly (test, B2 isa _Route,NA isa Number,event/real/E,dob/be/B2/NA/E),
        {bound(B2),unbound(NA)}
id  clear,
    add true,
    add flag(exit)
ip  test(B2 isa Number).



be2bustucyes rule %% is tuc a class ?
is  exactly (test,dob/be/Tuc/A/B,bustuc isa program,A isa Agent,event/real/B),
              {dmeq([tuc,bustuc],Tuc)}
id  clear,
    add true,
    add flag(exit)
ip  unbound(A),   %% i.e. general
    dmeq([oracle,computer,agent],Agent). %% etc %% special case

be2bustucno rule %% is tuc a class ?
is  exactly (test,dob/be/Tuc/A/B,bustuc isa program,A isa Agent,event/real/B),
              {dmeq([tuc,bustuc],Tuc)}
id  clear,
    add false,
    add flag(exit)
ip  unbound(A),   %% i.e. general
    \+ dmeq([oracle,computer],Agent). %% etc %% special case

be2tucyes rule %% is tuc a class ? // already ok semantically
is  exactly (test,dob/be/Tuc/A/B,tuc isa savant,A isa Agent,event/real/B),
              {dmeq([tuc,bustuc],Tuc)},
              {\+ dmeq([thing],Agent)}  %%"er du det" %% TA-110103
id  clear,
    add true,
    add flag(exit)
ip  unbound(A),   %% i.e. general
      %% dmeq([oracle,computer,agent],Agent). %% etc %% special case
      subclass0(savant,Agent). %%  er du et system ?

be2tucno rule %% is tuc a class ?
is  exactly (test,dob/be/Tuc/A/B,tuc isa savant,A isa Agent,event/real/B),
              {dmeq([tuc,bustuc],Tuc)},
              {\+ dmeq([thing],Agent)}  %%"er du det" %% TA-110103
id  clear,
    add false,
    add flag(exit)
ip  unbound(A),   %% i.e. general
    \+ dmeq([oracle,computer,program],Agent). %% etc %% TA-100909


be2noq rule %% er du en jente
is  test,  exactly   (dob/be/Tagore/A/B,Tagore isa Programmer,A isa Agent,event/real/B)
id  clear,
    add false,
    add flag(exit)
ip  unbound(A),   %% i.e. general
    dmeq([tuc,bustuc],Tagore),
    \+ dmeq([self],Programmer), %% er jeg en jente
    \+ subclass0(Programmer,Agent).


%%    Integrasjon er en løsning *NEI
be2nost rule  %% du er en jente -> OK*
is  new,     (dob/be/Tagore/A/B,Tagore isa _Programmer,
    A isa Agent,event/real/B),
    not ispresent srel/so_that/thing/_/_ %% etc hvis du er en jente
id  clear,
    add false,
    add flag(exit)
ip  unbound(A),   %% i.e. general
    dmeq([tagore,tuc,busstuc],Tagore),  %% En integrering er en  løsning.NEI
    \+ dmeq([agent, %% TA-110314
       savant,programmer,system,program,computer,oracle],Agent). %%	 etc


equalnameno rule %% = be2name  ??? % Er TUC lik Tagore ?
is  exactly (test, equal/Tuc/Tagore, Tagore isa _Programmer, Tuc isa _Program,event/real/_)
id  add false
ip  \+ (Tuc=Tagore).


saturdayroute5 rule  %% lørdagsrute 5 = rute 5 på lørdag.
is  replaceall (B52 isa saturdayroute,doit/go/B52/E)
    with       (B52 isa route,        doit/go/B52/E,S isa saturday,srel/on/day/S/E)
id  []
ip  newfree(S).


sundayroute5 rule  %% søndagsrute 5 = rute 5 på lørdag.
is  replaceall (B52 isa sundayroute,doit/go/B52/E)
    with       (B52 isa route,        doit/go/B52/E,S isa sunday,srel/on/day/S/E)
id  []
ip  newfree(S).


workdayroute5 rule %%  hverdagsrute 5 = rute 5 på lørdag.
is  replaceall (B52 isa workdayroute,doit/go/B52/E)
    with       (B52 isa route,        doit/go/B52/E,S isa weekday,srel/on/day/S/E)
id  []
ip  newfree(S).


dobget rule
is  replaceall (dob/get/'I'/Tagore/A,srel/Prep/place/Nth/A) %% I get Tagore to NTH
     with      (doit/go/Tagore/A,srel/Prep/place/Nth/A),
     {dmeq([to,from],Prep)} %% \+ nil ... hvor får jeg mat %% TA-100909
id   []
ip   [].



shunt rule
is  replaceall  (nrel/From/_/Place/A/Nth)
    with        (doit/be1/A/E,
                event/real/E,
                srel/From/Place/Nth/E)
id  []
ip  newfree(E).


daymorning rule %% søndag morgen -> søndag om morgenen
is  replaceall (B isa morning,srel/nil/day/C/D,srel/nil/daypart/B/D)
    with (B isa morning,      srel/nil/day/C/D,srel/in/time/B/D,event/real/D)
id  []
ip  [].

hasstat0 rule %% Havstads holdeplass
is  replaceall (srel/To/place/B/A,  has/place/station/H/B, B isa station)
 %% NB Important that srel/To/place/B/A comes first,
 %% to	 preserve seq!
    with       (srel/To/place/H/A)
id  []
ip  unbound(B).


srelbetweentime rule  %%   fra 09.15 - 09.45"
is  replaceall (srel/after/time/T1/A,srel/nil/time/T2/A)
    with       (srel/after/time/T1/A,srel/before/time/T2/A),
    {bound(T1),bound(T2)} %% avoid after sunday nil clock
id  []
ip  [].


gonilfrom rule %%  etter lørdag kl 1234.
is  not doit/be1/_/_,
    not ispresent  srel/around/time/_/_ , %% confuse
    not srel/to/place/_/_,
    replaceall (srel/nil/time/Six/B, srel/from/place/Stat/B)
    with       (srel/after/time/Six/B,srel/from/place/Stat/B)
id  []
ip  number(Six).


best rule  % hvilken buss er best til ...
is  replaceall adj/_/Best/X/E %% best til NTH = er til nth
    with       doit/be1/X/E,
    ispresent X isa Veh, { dmeq(vehicle,Veh)},
    not ispresent has/_/_/_/X, %% have a good night
    not ispresent doit/exist/X/_,  %% technical
    { dmeq([good,best],Best)}
id  []
ip  unbound(X).     %% Are you good SIC



runisrun rule %% noen  kjøre rutene = rutene kjører
is  replaceall (A isa route,B isa agent,dob/run/B/A/C,event/real/C)
    with       (A isa route,run/A/B,event/real/B)
id  []
ip  [].


named_date rule  %% also translation in grammar
is   not YYYY isa year when { ( number(YYYY),\+ this_year(YYYY))},
%%      not  adj/_/first/_/_, %% 1. julaften (should have been  absorbed)
     replaceall  (CE  isa date, srel/Prep/date/CE/E)
      with    (D24 isa date, srel/Prep/date/D24/E),
     {  atom(CE)} %% christmas_eve
id   []
ip   main:named_date(CE,D24).



invaliddate rule %% reject invalid date
is   X isa date,
     {bound(X), X= date(_,_,_)},
     clear
id   clear,
     add message(illegaldate),
     add flag(exit)
ip   \+ valid_date( X ).

%------------------------ NO nrel below this line ------------------------------

hello rule
is  doit,hello
id	 add message(start)
ip	 [].

quit rule
is  doit,quit,
    clear
id	 clear,
    add message(quit),
    add flag(exit)
ip	 [].


qmess rule
is  doit,quit(Mess),
    clear
id	 clear,
    add message(quit(Mess)),
    add flag(exit)
ip	 [].


mondaynight  rule %% Repair / Standardize mandag(s) kveld -> mandag om kvelden.
is  replaceall (N  isa night,srel/on/daypart/N /E,has/day/night/D /N )
    with (N isa night, srel/on/day/D/E,srel/in/time/N /E)
id  []
ip  [].


tomorrownight rule %%  Repair / Standardize i morgen kveld -> i morgen om kvelden
is  replaceall (B isa night,srel/tomorrow/day/nil/A,srel/nil/daypart/B/A)
    with (B isa night, C isa morrow,srel/in/time/C/A, srel/in/time/B/A)
id  []
ip  newfree(C).

%% MEETING SECTION

meeting rule %% meeting on a place = to place
is  replaceall (A isa meeting,nrel/on/meeting/place/A/X,srel/_Prep/meeting/A/C)
    with       (srel/to/place/X/C)
	           %% not on/place = liveinhell ->"from place"
id  []
ip  [].


meetingbetween rule %%  Møte mellom 2 og 3 = møte kl 2
is  replaceall (A isa meeting,T2 isa clock,doit/be1/A/E,srel/between/time/(T1,T2)/E)
    with       (A isa meeting,doit/be1/A/E,srel/at/time/T1/E)
id  []
ip  [].


havemeeting1 rule % I have a meeting at P
is  not doit/go/'I'/_,
    not doit/be1/'I'/_,
    replaceall (A isa meeting,has/agent/meeting/'I'/A, srel/OnAt/place/P/B)
    with       (doit/go/'I'/B, srel/to/place/P/B)
id  []
ip  dmeq([on,at],OnAt).


%% Presume   lecture -> meeting om beforehand
meeting1 rule %% Moved after shunt
is  replaceall (_ isa meeting, srel/OnAt/place/P/_, doit/Go/'I'/E)
    with       (doit/go/'I'/E, srel/to/place/P/E)
id  []
ip  dmeq([on,at],OnAt), %% NOT FROM!
    dmeq([go,run],Go).

meeting2 rule
is  replaceall ( dob/Reach/'I'/M/E, M isa Meeting, srel/OnAt/place/P/_)
    with       ( doit/go/'I'/E, srel/to/place/P/E),
            {dmeq([reach,pass],Reach)},
            {dmeq([on,at],OnAt)},
            {dmeq([meeting,movie,lecture],Meeting)}
id  []
ip  [].


%% END MEETING SECTION


%% Weather (fronted) %% weather in oslo #-> no weather (\+ not oslo)

weather01 rule  %  it rains
is  doit/rain/_/_
id	 addcon  message(noinfoabout(weather)),
    add flag(exit)
ip	 [].

weather02 rule  % it snows
is  doit/snow/_/_
id	 addcon  message(noinfoabout(weather)),
    add flag(exit)
ip	 [].


weather1 rule  %  Weather
is  adj/_/Cold/_/_
id	 addcon  message(noinfoabout(weather)),  %%  varmt vær
    add flag(exit)
ip	 dmeq([cold,hot,wet,icy],Cold).

weather2 rule  %  Weather
is  _ isa rain
id	 addcon message(noinfoabout(weather)),
    add flag(exit)
ip	 [].

weather2sky rule  %  er himmelen blå
is  _ isa sky
id	 addcon message(noinfoabout(weather)),
    add flag(exit)
ip	 [].

weather3 rule  %  ice Weather
is  _ isa ice
id	 addcon message(noinfoabout(weather)),
    add flag(exit)
ip	 [].

weather4 rule  %  Weather
is  _ isa snow
id	 addcon message(noinfoabout(weather)),
    add flag(exit)
ip	 [].

weather5 rule %  Weather
is  _ isa sun
id	 addcon message(noinfoabout(weather)),
    add flag(exit)
ip	 [].

weather6 rule %  Weather // er sola varm
is  _ isa temperature
id	 add message(noinfoabout(weather)),
    add flag(exit)
ip	 [].

%%


warning_sentence  rule %% warning + sentence
is  []
id  addcon flag(warningflag)
ip  main:myflags(warning_sentence,true), %%  reset by process
 \+ main:myflags(warningflag,true),
    main:set(warningflag,true).

warning_sentence_nosms  rule %% warning + sentence,nosms -> cannot
is  []
id  flag(warningflag) ,
    not message(sorrycannot),
    add  message(sorrycannot)
ip  \+ main:myflags(smsflag,true).


warningflag1 rule %%  a warning => set warningflag
is   _ isa notification
id  addcon flag(warningflag)
ip  \+ main:myflags(warningflag,true),
       main:set(warningflag,true).


warningflag2 rule %% varsler meg at /om/når
is  dob/notify/_/A/_, A isa coevent       %% do notify coevent <--
id  addcon flag(warningflag)
ip  \+ main:myflags(warningflag,true),
       main:set(warningflag,true).


warningflag3 rule %% notify   du varsler []
is  context doit/notify/_/_     %% do notify duration
id  addcon flag(warningflag)
ip  \+ main:myflags(warningflag,true),
       main:set(warningflag,true).


warningflag4 rule %% set warningflag
is  context dob/notify/_/_/_
id  addcon flag(warningflag)
ip  \+ main:myflags(warningflag,true),
       main:set(warningflag,true).



hourswarningadhoc rule %% trans %% Horrendous Hack
is  replaceall ( N isa hour,      dob/notify/T/N/E)
    with       ( N60 isa minute,  dob/notify/T/N60/E)
id  []
ip  main:myflags(warningflag,true),
    number(N), N =< 24,  %%  ass. no change of date
    N60 is N*60 .


prewarning0before  rule %% send notification Ten min. before first departure
is  send/tuc/N/E, ispresent N isa notification,
    Ten isa minute,
    srel/nil/duration/Ten/E,
    srel/before/vehicle/_/E
id  []
ip  main:myflags(warningflag,true),
    main:set(prewarningtime,Ten).


%%%%%% NN  prewarning rules   with intransitive notify !!!!!

prewarningminbefore  rule
is  doit/notify/tuc/E, srel/nil/duration/Ten/E,
    Ten isa minute,
    CE isa coevent,
    srel/before/coevent/CE/E,
    event/real/E
id  []
ip  main:myflags(warningflag,true),
    main:set(prewarningtime,Ten).



%%%%%% NN  prewarning rules  all with transitive notify !!!!!

prewarning1before  rule %% warning time before first departure
is  ispresent dob/notify/_Tuc/_/E,
    Ten isa minute,
    srel/nil/duration/Ten/E,
    srel/before/_Coveh/_/E %% vehicle/coevent %% TA-110201
id  []
ip  main:myflags(warningflag,true),
    main:set(prewarningtime,Ten).


prewarning1after  rule %% warning time after first departure
is  ispresent dob/notify/_Tuc/_/E,
    Ten isa minute,
    srel/nil/duration/Ten/E,
    srel/after/vehicle/_/E
id  []
ip  Tenafter is - Ten,
    main:myflags(warningflag,true),
    main:set(prewarningtime,Tenafter).


prewarning2before  rule %% warning time before first departure
is  ispresent dob/notify/_Tuc/Ten/_, %% TUC or agent(passive)
    Ten isa minute
id  []
ip  main:myflags(warningflag,true),
    main:set(prewarningtime,Ten).

prewarning2after  rule %% warning time after first departure
is  ispresent dob/notify/_Tuc/Ten/_, %% TUC or agenet(passive)
    Ten isa minute
id  []
ip  Tenafter is - Ten,
    main:myflags(warningflag,true),
    main:set(prewarningtime,Tenafter).


prewarning3before  rule %% warning time before first departure
is  replaceall (Ten isa minute, B isa time,srel/nil/duration/Ten/C, srel/before/time/B/C)
    with       (B isa time)
id  []
ip  main:myflags(warningflag,true),
    main:set(prewarningtime,Ten).

prewarning3after  rule %% warning time after first departure
is  replaceall (Ten isa minute, B isa time,srel/nil/duration/Ten/C, srel/after/time/B/C)
    with       (B isa time)
id  []
ip  Tenafter is - Ten,
    main:myflags(warningflag,true),
    main:set(prewarningtime,Tenafter).


prewarning4before  rule %% warning time before first departure
is  replaceall (F66 isa departure, Ten isa minute, doit/be1/Ten/F69,srel/before/departure/F66/F69)
    with       (F66 isa departure)
id  []
ip  main:myflags(warningflag,true),
    main:set(prewarningtime,Ten).


prewarning4after  rule %% warning time after first departure
is  replaceall (F66 isa departure, Ten isa minute, doit/be1/Ten/F69,srel/after/departure/F66/F69)
    with       (F66 isa departure)
id  []
ip  Tenafter is - Ten,
    main:myflags(warningflag,true),
    main:set(prewarningtime,Tenafter).



starttogo rule %%  start to go = go early
is replaceall (Bus9 isa bus,B isa reason,A isa time,
              doit/start/Bus9/C,srel/in_order_to/thing/B/C,srel/in/time/A/D,
              doit/go/Bus9/D,event/_R/D)
   with       (Bus9 isa bus,doit/go/Bus9/D,A isa time,srel/in/time/A/D, srel/early/time/nil/D,event/real/D)
id  []
ip  [].

startandgo rule %%  start and go = go early
is  replaceall (Bus9 isa bus,doit/start/Bus9/C,doit/go/Bus9/C, A isa time,srel/in/time/A/C,event/real/C)
    with       (Bus9 isa bus,doit/go/Bus9/C, A isa time,srel/in/time/A/C,srel/early/time/nil/C,event/real/C)
id  []
ip  [].

startinatend rule %% hvor starter buss 9 = end stations
is  replaceall (doit/start/X/E,srel/In/place/P/E, P isa place)
    with       (has/vehicle/endstation/X/P,  P isa endstation)
id  []
ip  dmeq([in,at,from],In).


startinat rule %%  start in/at = go from
is  replaceall (doit/start/X/E,srel/In/place/P/E)
    with       (doit/go/X/E,srel/from/place/P/E),
               {dmeq([in,at,from,on],In)}
id  []
ip  [].


entergo rule %% tre ( i kraft) %% TA-101108
is  not X isa meeting,
    replaceall (doit/enter/X/E)
    with       (doit/go/X/E)
id  []
ip  [].

startgo rule %% otherwise  start = go
is  not X isa meeting,
    replaceall (doit/start/X/E)
    with       (doit/go/X/E)
id  []
ip  [].

startmeeting  rule %% otherwise  start = go
is   X isa meeting, %% Ad Hoc
    replaceall (doit/start/X/E,srel/nil/_Time/KL/E,doit/go/I/F)
    with       (doit/go/I/F,srel/before/time/KL/E)
id  []
ip  [].


gotoxandbeinx1 rule % before tofromsameplace
is  replaceall (doit/go/I/A87, srel/to/place/Sentrum/A98, doit/be1/I/A98,srel/in/place/Sentrum/_A88)
    with       (doit/go/I/A87 ,srel/to/place/Sentrum/A87)
id  []
ip  [].


gotoxandbeinx2 rule % go to and be in X
is  replaceall (doit/go/I/F59, srel/to/place/Sentrum/F59, srel/in/place/Sentrum/_F60)
    with       (doit/go/I/F59 ,srel/to/place/Sentrum/F59)
id  []
ip  [].

%% Nostation section (before tofromsameplace)


itemrulesingle rule % an item %% Fronted
is  item, _C isa _Class , clear% discard Class
id  clear,
    add   message(completesentence)
ip  [].  %% \+ testmember(Class,[nightbus,tram])


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5   :-single.


whichdaysbetween  rule %% TA-110411
is  which(A),A isa day,doit/exist/A/_,
    Date1 isa date, Date2 isa date, {bound(Date1), bound(Date2)},
    srel/after/time/Date1/_,
    srel/before/time/Date2/_
id  add message(numberof(N,day)),
    add flag(exit)
ip  days_between(Date1,Date2,N).


whichdaystospecialdate rule   %% :-) Arvid Holme
is  which(A),A isa day,doit/exist/A/B,
    ispresent Arvid_holme_day isa date,
    srel/To/time/Arvid_holme_day/B,event/real/B,
           {dmeq([to,until,before],To)}
id  add message(numberof(N,day)),
    add flag(exit)
ip  named_date(Arvid_holme_day,DATE),
    todaysdate(TODAY),
    days_between(TODAY,DATE,N).


whichdaystoanydate rule
is  which(A),A isa day,doit/exist/A/B,
    ispresent ANYDATE isa date,
    srel/To/time/ANYDATE/B,event/real/B,
           {dmeq([to,until,before],To)}
id  add message(numberof(N,day)),
    add flag(exit)
ip  todaysdate(TODAY),
    days_between(TODAY,ANYDATE,N).


howmanydaystonameddate rule
is  howmany(A),Arvid_holme_day isa date,A isa day,doit/exist/A/B,
           srel/To/time/Arvid_holme_day/B,event/real/B,
           {dmeq([to,until,before],To)}
id  add message(numberof(N,day))
ip  named_date(Arvid_holme_day,DATE), %% :-) %[].
    todaysdate(TODAY),
    days_between(TODAY,DATE,N).


worldend  rule %% TA-110608 when will the wold end :-(
is B isa world,A isa time,doit/End/B/C,srel/in/time/A/C,event/real/C,
    {dmeq([end,stop],End)}
id  add message(date_isa_day(Date,Day))
ip  named_date(dooms_day,Date),xweekday(Date,Day). %% TA-110609


goffwithpension  rule
is  replaceall
%         (doit/go/Tagore/C,srel/off/_Veh_sic_/nil/C,srel/pwith/pension/B/C,B isa pension)
         (doit/go/Tagore/C,srel/off/ _ /nil/C,srel/pwith/pension/B/C,B isa pension)
    with (doit/retire/Tagore/C)
id  []
ip  [].

daysuntilretireta0 rule
is  howmany(A), A isa day,
    doit/retire/Tagore/F5,
    doit/exist/A/F4,srel/Until/time/F3/F4,event/real/F5,
    {dmeq([until,to,before],Until)},
    srel/in/time/F3/F5
id  add message(numberof(N,day))
ip  has_att_val(person,retirement,Tagore,DATE),
    todaysdate(TODAY),
    days_between(TODAY,DATE,N).


daysuntilretireah rule
is  %%%% howmany(A), | which(A)
    doit/Retire/Arvid_holme/C, {dmeq([retire,end],Retire)},
    Arvid_holme isa _ ,A isa day,B isa coevent,event/B/C,doit/exist/A/D,srel/Until/coevent/B/D,event/real/D,
    {dmeq([until,to,before],Until)}
id  add message(numberof(N,day))
ip  has_att_val(person,retirement,Arvid_holme,DATE),
    todaysdate(TODAY),
    days_between(TODAY,DATE,N).

dayssinceretireah rule %% TA-110215
is  doit/Retire/Arvid_holme/C, {dmeq([retire,end],Retire)},
    Arvid_holme isa _ ,A isa day,B isa coevent,event/B/C,doit/exist/A/D,srel/Since/__Coevent/B/D,event/real/D,
    {dmeq([since],Since)}
id  add message(numberof(N,day))
ip  has_att_val(person,retirement,Arvid_holme,DATE),
    todaysdate(TODAY),
    days_between(DATE,TODAY,N). %% NB seq 2 1

daysuntilretireta rule
is  howmany(A),
    doit/retire/Tagore/D,
    A isa day,B isa coevent,event/B/D,
    doit/exist/A/E,srel/Until/coevent/B/E,event/real/E,
    {dmeq([until,to,before],Until)}
id  add message(numberof(N,day))
ip  has_att_val(person,retirement,Tagore,DATE),
    todaysdate(TODAY),
    days_between(TODAY,DATE,N).


retire rule
is  doit/Retire/Arvid_holme/_, {dmeq([retire,end],Retire)},
    Arvid_holme isa Man ,{dmeq(trafficant,Man)} %%  i.e. << agent
id  add message(date_isa_day(DATE,Monday)),
    add flag(exit)
ip  has_att_val(person,retirement,Arvid_holme,DATE),
    weekday(DATE,Monday).

howlongtoadate1  rule
is  which(A),DATE isa date,A isa duration,
    doit/exist/A/B,srel/Before/time/DATE/B,
    {dmeq([before,to],Before)} %% TA-100828
id  add message(numberof(N,day))
ip  todaysdate(TODAY),
    days_between(TODAY,DATE,N).

howlongsincedate1  rule
is  which(A),DATE isa date,A isa duration,doit/exist/A/B,srel/Since/_/DATE/B,
    {dmeq([since,after],Since)}
id  add message(numberof(N,day))
ip  todaysdate(TODAY),
    days_between(DATE,TODAY,N).


howmanydayssinceadate rule
is  howmany(A),DATE isa date,A isa day,doit/exist/A/B,srel/Since/_/DATE/B,event/real/B,
        {dmeq([since,after],Since)}
id  add message(numberof(N,day))
ip  todaysdate(TODATE),
    days_between(DATE,TODATE,N).


howmanydaystoadate rule
is  howmany(A),DATE isa date,A isa day,doit/exist/A/B,srel/To/_/DATE/B,event/real/B,
        {dmeq([to,until,before],To)}
id  add message(numberof(N,day))
ip  todaysdate(TODATE),
    days_between(TODATE,DATE,N).


howmany99 rule   %% How many ---> which %%  Fronted
is  replaceall howmany(A)
    with       which(A),
    not ispresent _ isa question, %% TA-101215
    not srel/nil/week/_/_
id  []
%%%%    add message(cannotanswer) // Unnecessary
ip  [].


nostation00 rule % bus from an ocean to nth. It is a ridiculous place
is  ispresent srel/_/place/B/_, B isa Ocean,clear
id  addcon message(foreign(Ocean))
ip  dmeq([sky,ocean,sea,su,moon],Ocean). %% ridiculous place subclasses


nostation1 rule
is  X isa station,  { bound(X)},
    clear
id  clear,
    addcon message(noroutesto(X))
ip  nostationfor(X).

nostation2 rule
is  X isa neighbourhood, {bound(X)},
    clear
id  clear,
    addcon message(noroutesto(X))
ip  placestat(X,Y),nostationfor(Y).


nostationstreet rule
is  X isa street, { bound(X)},
    clear
id  clear,
    addcon message(noroutesto(X))
ip  street_station(X,Y),
    nostationfor(Y),   %% adm_rit
    \+ main:placestat(X,_).


nostationx rule %% outside T ( meaning not at T)
is  Trondheim isa city,
    srel/outside/place/Trondheim/_,
    clear
id  clear,
    addcon message(foreign(nil))
ip  [].


% % %



isversion0 rule
is  _ isa version,
    clear
id  clear,
    add ( message(answer(db_reply(tuc,version,K))),
          flag(exit))
ip  has_att_val(system,version,tuc,K).

routeisupdated0 rule  %% when were routes updated
is  update/_B/X/_,
    X isa Route,      {dmeq([route],Route)}, %%
    clear
id  atdate2(DaySeqNo,Date),
    clear,
%    add  message(route_period( tt, RP,Date1, _Date2))
    add  message(route_period( tt, RP,Date1, _ ))
ip  decide_period(Date,RP),
%    route_period( tt, RP,Date1,_Date2),
    route_period( tt, RP,Date1, _ ),
    dayModSeqNo(Date,DaySeqNo).

tucisupdated1 rule  %% when were you updated
is  dob/update/_B/R/_,
    R isa OP,      {dmeq([program,oracle,code,savant],OP)}, %% oracle oppdatert
    clear
id  clear,
    add  message(answer(db_reply(tuc,version,K)))
ip  has_att_val(system,version,tuc,K).


tucisupdated2 rule  %% when were you updated
is  adj/_/updated/R/_,
    R isa OP,      {dmeq([program,oracle,code,savant],OP)}, %% oracle oppdatert
    clear
id  clear,
    add  message(answer(db_reply(tuc,version,K)))
ip  has_att_val(system,version,tuc,K).


%% WANNA SECTION BEFORE nilclocksequence

wannagoto0 rule %% Dirty repair
is  context    (I isa self,NTH isa Station1, Dragvoll isa Station2, event/real/E),
    replaceall (doit/be1/I/E,srel/On/place/NTH/E,doit/go/I/E,srel/ONTO/place/Dragvoll/E)
    with       (doit/go/I/E,srel/from/place/NTH/E,srel/to/place/Dragvoll/E)
id  []
ip  (NTH \== Dragvoll),
    dmeq(place,Station1),dmeq(place,Station2),dmeq(onto,ONTO),
    dmeq([on,at,in],On).


wannabeon1 rule
is  not ispresent srel/to/place/_/_,
    not ispresent doit/live/_/_,
    context (srel/From/place/NTH/C, NTH isa Station1,Dragvoll isa Station2, event/real/C),
    {dmeq([from,past],From)},
    {NTH \== Dragvoll},
    replaceall (srel/OTAN/place/Dragvoll/E,doit/Be1/'I'/E) %% I -> 'I'
    with       (doit/go/'I'/E,srel/to/place/Dragvoll/E)
          %%  hvilken av bussholdeplassene (som er)  på studentersamfunnet...
id  []
ip  dmeq([be1,work,go],Be1), %% (work is destination)
    dmeq(nato,OTAN),dmeq(place,Station1),dmeq(place,Station2).


wannabeon2 rule
is  context (I isa self,NTH isa Station1,Dragvoll isa Station2),
    replaceall ( want/myid/that/I/B/C,event/real/C,doit/be1/I/D,event/B/D,
                 srel/OTAN/place/Dragvoll/D)       % ,srel/from/place/NTH/D)
    with       (doit/go/I/D,event/real/D,srel/to/place/Dragvoll/D) %,srel/from/place/NTH/D)
id  []
ip  ( NTH \== Dragvoll), dmeq(nato,OTAN),dmeq(place,Station1),dmeq(place,Station2).


wannabeon3 rule
is  context (I isa self,NTH isa Station),
    replaceall (want/myid/that/I/B/C,event/real/C,doit/be1/I/D,srel/OTAN/place/NTH/D,event/B/D)
    with       (doit/go/I/D,event/real/D,srel/to/place/NTH/D)
id  []
ip  dmeq(nato,OTAN),dmeq(place,Station).


wannabefore1 rule %% I am on X and wanna be on Y %% fails on i wanna be on Y and I am on Y
is  context (I isa self),
    replaceall (doit/be1/I/D,event/real/D,srel/OTAN1/place/NTH/D,srel/OTAN2/place/Moholt/D,
              srel/NILB/TIME/T/D)
    with       (doit/go/I/D, event/real/D,srel/from/place/NTH/D,srel/to/place/Moholt/D,
               srel/before/time/T/D)
id  []
ip  dmeq(nato,OTAN1),dmeq(nato,OTAN2), % dmeq(place,Station),
    dmeq(beforenil,NILB),dmeq(time,TIME).


wannabefore2 rule %% i wanna be on
is  context (I isa self),
    not srel/to/place/_/_,
    replaceall (doit/be1/I/D,event/real/D,srel/OTAN/place/NTH/D,NTH isa Station,srel/NILB/TIME/T/D)
    with       (doit/go/I/D, event/real/D,srel/to/place/NTH/D,NTH isa Station,srel/before/time/T/D)
id  []
ip  dmeq(nato,OTAN),dmeq(place,Station),
    dmeq(beforenil,NILB),dmeq(time,TIME).



beonbeforeeqto rule  %% buss er på  Gløshaugen før 1900
is  not ispresent doit/meetup/'I'/_, %% only about buss arrive
    not ispresent doit/live/_/_, %% I live on Nidarvoll
    not ispresent doit/stop/_/_,
    ispresent srel/Before/time/_1900/_B,
              {dmeq([before,nil],Before)},
                       %% jeg er på nidarvoll ... før kl 18
    replaceall (doit/be1/B/E, srel/ION/place/NTH/E)
    with       (doit/go/B/E,  srel/to/place/NTH/E),
          {dmeq([in,on],ION)}
id []
ip [].


comefromhell rule %% er på holdeplassen på gløs -> fra gløs
is   free(X20) isa station,
     replaceall (doit/be1/free(X20)/free(X21),
%                srel/on/_Neighbourhood/Gløs/free(X21),
                 srel/on/ _ /Gløs/free(X21),
%                doit/_Bego/'I'/free(X22),
                 doit/ _ /'I'/free(X22),
                 srel/on/place/free(X20)/free(X22))
     with
                (doit/go/'I'/free(X22),srel/from/place/Gløs/free(X22))
id  []
ip  [].


beon1 rule  %% I am on A ( but not  skal være på!)
is  context B isa self, %% Jeg er på Gløshaugen
    not ispresent which(_), %% .. hvor er jeg
    not ispresent test,     %% .. er jeg på ...
    replaceall (doit/be1/B/E, srel/Prep/place/NTH/E)
    with       (doit/go/B/E,  srel/from/place/NTH/E)
id []
ip \+ dmeq([to],Prep).

%%% END WANNA SECTION %%%

%% Fronted. avoid nil -> before
afterdayat rule %% after Thursday at 1800 MEANS  on Thursday after 1800
is replaceall (srel/after/time/B/C, B isa Thursday,srel/ATTIME/time/T1800/C)
   with       (srel/after/time/T1800/C, B isa Thursday,srel/on/time/B/C)
id []
ip dmeq(attime,ATTIME),dmeq(mtwtfss,Thursday).

%% Fronted. avoid nil -> before
beforedayat rule %% before Thursday at 1800 MEANS  on Thursday before 1800
is replaceall (srel/before/time/B/C, B isa Thursday,srel/ATTIME/time/T1800/C)
   with       (srel/before/time/T1800/C, B isa Thursday,srel/on/time/B/C)
id []
ip dmeq(attime,ATTIME),dmeq(mtwtfss,Thursday).



%%% BEGIN NILCLOCK SECTION %%%%%%%%%%

% clock = nil time
% nil   = nil place
% prep  = prep place

%%% .. and .. sequence rules come early because other rules may change
%%% strict sequence

nilclocktoclock rule  %% til nth 0700 til 0800
is replaceall (srel/nil/clock/T700/E,srel/to/clock/T800/E)
   with       (srel/after/time/T700/E,srel/before/time/T800/E)
id  []
ip  [].

nilnilclocksequence  rule %% buran  torget  2030 = before  2030
is  context   Time isa clock, {bound(Time)},
    srel/nil/place/_P/E and  srel/nil/place/_Q/E and  srel/nil/time/Time/E, %% IN  INDIRECT SEQUENCE
    replace srel/nil/time/K/E  with  srel/before/time/K/E
id  []
ip  [].

nilplacetoplacenilclocksequence  rule %% berg studentby til moholt kl 2030 .
is  context   Time isa clock, {bound(Time)},  %% TA-101020
    srel/nil/place/_P/E and  srel/to/place/_Q/E and  srel/nil/time/Time/E,
    replace srel/nil/time/K/E  with  srel/before/time/K/E
id  []
ip  [].


clocknilnilsequence  rule %% 2030  buran  torget = after 2030
is  context   Time isa clock, {bound(Time)},
    srel/nil/P/Time/E and srel/nil/place/_P/E and  srel/nil/place/_Q/E,  %% IN  INDIRECT SEQUENCE
    replace srel/nil/P/K/E  with
            srel/after/time/K/E
id  []
ip  [].

nilclocknilsequence  rule %%  buran  2030 torget = after 2030
is  context   Time isa clock, {bound(Time)},
    srel/nil/place/_P/E and srel/nil/P/Time/E and  srel/nil/place/_Q/E,  %% IN  INDIRECT SEQUENCE
    replace srel/nil/P/K/E  with
            srel/after/time/K/E
id  []
ip  [].


%%  Sentrum  til Coop mega . // Mega comes first

nilnilsequence  rule % go A B
%is  not srel/to/place/_Dalen/_, %% bakkegata til Dalen hagene  %% TA-110322
is  not srel/to/place/ _ / _ , %% bakkegata til Dalen hagene  %% TA-110322
    replaceall (srel/nil/PlaceT1/Place1/E,  srel/nil/PlaceT2/Place2/E)
    with       (srel/from/place/Place1/E, srel/to/place/Place2/E),
    {bound(Place1),bound(Place2), Place1 \== Place2}
id  []
ip  dmeq([neighbourhood,station,place,city],PlaceT1),
    dmeq([neighbourhood,station,place,city],PlaceT2).



%% PROBLEM

nilplacenilclocktoeqafter   rule %%  arne bergsgårdsvei kl.22.30 til sentrum %% TA-101019
is  context   Time isa clock,
    replaceall (srel/nil/place/ABV/E2,srel/AT/time/Time/E2, srel/to/place/Sentrum/E2)
    with       (srel/nil/place/ABV/E2,srel/to/place/Sentrum/E2,srel/after/time/Time/E2),
    not doit/meetup/'I'/E2
id  []
ip  dmeq(attime,AT).


nilclocktoeqbefore   rule %%  Trondheim sentrum til tunga 6.30 %% TA-101019
is  context   Time isa clock,
    replaceall (srel/nil/place/ABV/E2, srel/to/place/Sentrum/E2,srel/AT/time/Time/E2)
    with       (srel/nil/place/ABV/E2,srel/to/place/Sentrum/E2,srel/before/time/Time/E2),
    not doit/meetup/'I'/E2
id  []
ip  dmeq(attime,AT).

%%%%%%%%%%%



tofromclocksequence  rule %% til risvollansenteret fra gløshaugen syd 945.
is  not ispresent srel/before/_/_/_, %% TA-110225 e.g. activity/coevent
    not ispresent srel/in_order_to/_/_/_,
    not ispresent srel/so_that/_/_/_,
    not ispresent srel/because_of/thing/_/_, %% error in gram_n
    srel/to/place/_P/E and srel/from/place/_Q/E and srel/nil/time/K/E, %% IN  INDIRECT SEQUENCE
    replace srel/nil/time/K/E  with   srel/after/time/K/E
id  []
ip  [].


toclocksequence1  rule %% to A 12:34 //  til vikåsen fra samfundet 1600 .OBS!!! feil
is  ispresent K isa clock,
    not ispresent _ isa departure, %% then time is dep time
    not ispresent (_ isa minute), %% go to Torget 12 minutes
    srel/To/place/_P/E and srel/nil/time/K/E, %% IN  INDIRECT SEQUENCE
    { dmeq([to,on],To) }, %% skal være på ...
    replace srel/nil/time/K/E  with      srel/before/time/K/E
id  not flag(nightbusflag)   %% deptime is the important thing !!
ip  [].


%% Horrendous hack, sequence problem
fromtoclocknextdayclock  rule %%  bussen går  fra lerkendal til torget neste tirsdag kl 12
is  srel/from/place/_/E and srel/TO/place/_/E , %% TA-110415  HACK
    ispresent srel/nil/time/K/E, {bound(K)},
      ispresent srel/nil/day/F13/E,
      ispresent adj/nil/next/F13/real,

    not ispresent _ isa departure,
    not ispresent srel/after/time/_/_,  %% NO!
    not ispresent srel/on/place/_/E, %%%% doit/be1/_/E, %% for å være på
    not ispresent srel/in/place/_/E,
    replace srel/nil/time/K/E  with     srel/before/time/K/E
id  []
ip  dmeq([to,at],TO).


fromtoclocksequence  rule %% Fra eberg .. ved Brundalen kl 0930 = before
is  srel/from/place/_/E and srel/TO/place/_/E and srel/nil/time/K/E, %% INDIRECT SEQUENCE
    not ispresent _ isa departure,
    not ispresent srel/after/time/_/_,  %% NO!
    not ispresent srel/on/place/_/E, %%%% doit/be1/_/E, %% for å være på
    not ispresent srel/in/place/_/E,
    replace srel/nil/time/K/E  with     srel/before/time/K/E
id  []
ip  dmeq([to,at],TO).


fromclocksequence  rule %% from A 12:34 // fra telverkskrysset 2150 i dag til sentrum?
is  srel/from/place/_P/E and srel/nil/time/K/E, %% IN INDIRECT SEQUENCE
    not ispresent srel/before/_/_/_, %% e.g. activity %% TA-110225
    not ispresent srel/around/time/_/_, % then complicated %% TA-101111
    not ispresent srel/in_order_to/_/_/_, % for å rekke en avtale
    not ispresent _ isa coevent,
    not ispresent srel/before/time/_/_,   %% NO!
    not ispresent srel/on/place/_/E, %%%% doit/be1/_/E, %% for å være på
    not ispresent srel/in/place/_/E,
    not ispresent dob/reach/_/_/_,
    replace srel/nil/time/K/E  with srel/after/time/K/E
id  []
ip  [].


clockniltosequence  rule %% go 12:34 to A  %% 0730 kroppanmarka til dragvoll .
is  srel/nil/time/T/A and srel/nil/place/_K/A and srel/to/place/_D/A,event/real/A,
    replace srel/nil/time/T/E  with    srel/after/time/T/E
id  []
ip  [].

%% TA-101109
clockfromsequence  rule %% bussen går på  torsdag kl 10  fra nth til nardo.
is  not ispresent doit/meetup/'I'/_,   %% \+ I go to start station
    not ispresent dob/pass/_/_/_, %%  rough
    not ispresent srel/nil/place/_ABV/E,    %% ABV 2203 til S
    srel/nil/time/K/E  and srel/from/place/_P/E, %% IN SEQUENCE
    replace srel/nil/time/K/E  with srel/after/time/K/E
id  []
ip  [].


clocktosequence  rule %% go 12:34 to A = before/ towards = after (subte)
is  not ispresent doit/meetup/'I'/_,   %% \+ I go to start station
    not ispresent dob/pass/_/_/_, %%  rough
    not ispresent srel/nil/place/_ABV/E,    %% ABV 2203 til S
    srel/nil/time/K/E  and srel/to/place/_P/E, %% IN SEQUENCE
    replace srel/nil/time/K/E  with srel/before/time/K/E
id  []
ip  [].



toclocksequence2  rule %% to place  12:34 = before/ towards
is  not ispresent _ isa minute, %% til torget 12 minutter senere
    not ispresent _ isa departure, %% then deptime
    srel/to/place/_P/E and srel/nil/time/K/E,  %% IN SEQUENCE
    replace srel/nil/time/K/E  with srel/before/time/K/E
id  []
ip  [].


clockfromsequence  rule %% 2030 fra buran til torget = after 2030
is  context   Time isa clock, {bound(Time)},
    not ispresent srel/in_order_to/thing/_/_  ,
    not ispresent srel/so_that/thing/_/_ ,
    srel/nil/_/Time/E and srel/from/place/_P/E,  %% IN  INDIRECT SEQUENCE
    replace srel/nil/time/K/E  with   srel/after/time/K/E
id  []
ip  [].


%% RS-111118
clocksequence  rule %% go 12:34 (but with default place)
is ispresent K isa clock,
%     not ispresent adj/nil/present/_/_, %% fremme kl %% TA-110531
     not ispresent srel/so_that/_/_/_,
     not ispresent doit/arrive/_/E, %% <---
%     not ispresent srel/before/_Activity/_/_, %%  before meeting
     not ispresent srel/before/ _ / _ / _ , %%  before meeting
     not ispresent dob/reach/_/_/_,
     not srel/in_order_to/thing/_/_,
     not srel/because_of/thing/_/_,   %% error in gramn
     not srel/in/time/_/_ ,%% ad hoc %% til S når jeg må være i S kl 0610.
   replace srel/nil/time/K/E  with  srel/after/time/K/E
id  []
ip  [].


%% END NILCLOCK SECTION %%%%%


visitpass rule %% to see is to pass %% special
is   X isa self, Y isa Place, {dmeq(place,Place)},
     replaceall   dob/visit/X/Y/E
     with         dob/pass/X/Y/E
id  []
ip  [].

seepass rule %% to see is to pass %% special
is   X isa self, Y isa Place, {dmeq(place,Place)},
     replaceall   dob/see/X/Y/E
     with         dob/pass/X/Y/E
id  []
ip  [].


passnear  rule  %% Pass (near) station means go FROM station to center
is   not ispresent  srel/from/place/_/_,
     not ispresent  srel/past/place/_/_,
     not ispresent  dob/pass/_/(_,_)/_,
     replaceall (pass/A/C, srel/near/place/B/C,event/real/C)
     with       (doit/go/A/C,   srel/from/place/B/C)
id   []
ip   [].


passpast  rule  %%  Pass X  past Y  means go FROM Y to X
is   not ispresent  srel/from/place/_/_, %% because
     ispresent  srel/past/place/Y/C,
     not ispresent  dob/pass/_/(_,_)/_,
     replaceall dob/pass/A/X/C with (doit/go/A/C, srel/to/place/X/C),
     replaceall srel/past/place/Y/C with srel/from/place/Y/C,
     not B isa train,
     not B isa boat
id   []
ip   [].


passgopast  rule     %% Otherwise Pass a station means go past station to center
is   ispresent B isa P, {dmeq(place,P)}, %%  (dont eat)
     not dob/pass/_/(_,_)/_,
     replaceall (dob/pass/A/B/C)
     with       (doit/go/A/C, srel/past/place/B/C),
     not B isa train,
     not B isa boat
id   []
ip   [].

passoneqgoto  rule     %% Pass on = go to
is   srel/on/place/X/B,  %% NB NOT dob/pass/A/B,
     not dob/pass/_/(_,_)/_,
     replaceall (pass/A/B)
     with       (doit/go/A/C, srel/to/place/X/C),
     not B isa train,
     not B isa boat
id   []
ip   newfree(C).


youdo  rule %%  du gjør --> gjør!
is  replaceall (new,tuc isa savant,dob/LIST/tuc/X/E)
    with       (doit,tuc isa savant,dob/LIST/tuc/X/E)
id  []
ip  dmeq([list,show,tell],LIST).

canyoudo  rule %% kan du gjøre ?--> gjør
is  replaceall (test,tuc isa savant,dob/LIST/tuc/X/E)
    with       (doit,tuc isa savant,dob/LIST/tuc/X/E)
id  []
ip  dmeq([list,show,tell],LIST).


iwonder rule %% I wonder whether
is  replaceall (new,I isa self,wonder/myid/whether/I/B/C,event/real/C,event/B/_)
    with       (test)
id  []
ip  [].


belie rule
is  replaceall  (doit/lie1/A/B) %% TA-110503
    with        (doit/be1/A/B)
id  []
ip  [].


be2or rule % are you A or B
is  dob/be/_/(_A;_B)/_
id  not message(onlyonething),
    add message(onlyonething)
ip  [].


manif rule % exist a or b ?
is  replaceall (doit/exist/(A;_B)/E) with %% + other verbs
                doit/exist/A/E
id  not message(onlyonething),
    add message(onlyonething)
ip  [].


samestops rule
is  A isa station, adj/_/same/A/_, has/vehicle/station/(_B4,_B6)/A
id  add message(cannotanswer)
ip  [].


walkingfrom rule %% walking from means going to
is   not srel/to/place/_/_, %% then pus to that place
     replaceall (doit/walk/I/E, srel/from/place/X/E)
     with       (doit/go/I/E,   srel/to/place/X/E)
id   []
ip   [].

foots rule
is  doit/go/_/E , _ isa foot, srel/to/foot/_/E
id  add message(noinfoabout(walking_distance)),
    add flag(exit)
ip  [].



walking rule
is  doit/walk/_/_
id  add message(noinfoabout(walking_distance))
ip  [].


web_address rule
is  replaceall  (X isa address,adj/_/web/X/_E)
    with        (X isa webaddress)
id  []
ip  [].


knownas rule %% kjent som
is  replaceall (adj/_/known/B/C,srel/as/thing/X/C,srel/BY/Place/B/D,event/real/C)
    with       (srel/BY/Place/X/D)
id  []
ip  [].

wayboundnorth  rule %% nord
is  Øst isa direction
id  addcon message(noinfoabout(direction))
ip  dmeq([øst,vest,nord,syd, east,west,north,south],Øst).


waybound1 rule %% nordover
is  adj/_/Wards/_/_
id  addcon message(noinfoabout(direction))
ip  dmeq([waybound,southward,northward,eastward,westward],Wards).


offat rule %%   go off at place
is  replaceall (srel/off/vehicle/nil/A,srel/at/place/JX/A)
    with       (srel/to/place/JX/A)
id  []
ip  [].


offside rule %%   e.g. south of
is  srel/offside/_/_/_
id  addcon  message(noinfoabout(direction))
ip  [].

wards rule
is  srel/Wards/direction/nil/_
id  addcon  message(noinfoabout(direction))
ip  dmeq([southward,northward,eastward,westward],Wards).


takedur0 rule %% tar det lang tid fra  kbs til munkegata
is  A isa time,  ispresent adj/_/long/A/real,
    replaceall (dob/take/It/A/E)
    with       (doit/go/It/E,srel/pwith/duration/A/E)
id  []
ip  [].

takedur1 rule %% hvor lang varighet bruker en buss
is  context (dob/use/B/A/E),context (A isa duration),context (B isa V), {dmeq(vehicle,V)},
    replaceall (dob/use/B/A/E)
    with       (doit/go/B/E,srel/pwith/duration/A/E)
id  []
ip  [].


takedur2 rule %% hvor lang tid bruker en buss
is  context    (A isa time,B isa V), {dmeq(vehicle,V)},
    replaceall (dob/Take/B/A/E)
    with       (doit/go/B/E,srel/pwith/duration/A/E)
id  []
ip  dmeq([take,use],Take).





labelled rule
is  replaceall (A isa bus, N isa number,adj/_/label/A/B,event/real/B,srel/pwith/number/N/_,doit/go/A/E)
    with       (N isa bus, doit/go/N/E)
id  []
ip  bound(N),exbus(N).


fromdash rule  % go 1800 after  1800
is  context T1 isa clock, %% not if T1 isa thursday
    replaceall  ( srel/nil/time/T2/A,srel/after/time/T1/A)
    with        ( srel/after/time/T1/A,srel/before/time/T2/A)
id  []
ip  [].


halloween rule
is  replaceall (srel/between/time/T1/E,srel/nil/time/T2/E)
    with       (srel/after/time/T1/E,srel/before/time/T2/E)
id  []
ip  [].


doilive1 rule %% only in test mode, not suitable for negans
is  exactly (test,I isa self,doit/Exist/I/A,event/real/A),clear
id  add message(waddyathink)
ip  dmeq([exist,live,think],Exist). %%  ( can I go ... and be at nth before ...)

doilive2 rule %% only in test mode, not suitable for negans Hvorfor lever jeg
is  explain,I isa self,doit/Exist/I/_,clear
id  add message(cannotanswer)
ip  dmeq([exist,live,think],Exist). %%  ( can I go ... and be at nth before ...)


doilive3 rule %% only in test mode, not suitable for negans
is   exactly (test,I isa self,adj/_/Alive/I/A,event/real/A),clear
id   add message(waddyathink)
ip   dmeq([alive,clever],Alive). %%  :-)


stand0 rule % two prepositions % i stand means I go from
is  replaceall (doit/stand/B/E, srel/on/place/X/E,     srel/Prep/place/Y/E)
    with       (doit/go/B/E,    srel/from/place/X/E, srel/to/place/Y/E)
id []
ip dmeq(to,Prep).


stand1 rule
is  context B isa self, %% ikke buss står
    replaceall (doit/stand/B/E, srel/Prep/place/NTH/E)
    with       (doit/go/B/E, srel/from/place/NTH/E)
id []
ip \+ dmeq([to],Prep).

stand2 rule % I am now at X = go from X now
is  context _ isa self,
    replaceall (doit/be1/B/E,srel/now/time/nil/E,  srel/ION/place/NTH/E)
    with       (doit/go/B/E, srel/from/place/NTH/E,srel/now/time/nil/E)
id []
ip dmeq([in,on],ION).



ontime1 rule
is  replaceall (Ev isa Night,srel/on/time/Ev/S)  %% på morgenen
    with       (Ev isa Night,srel/before/time/Ev/S)
id  []
ip  dmeq(day,Night). %% NOT Minute !


during2timein rule
is  replaceall (Ev isa Night,srel/during2/time/Ev/S) %% om kvelden/ untreated
    with       (Ev isa Night,srel/in/time/Ev/S)
id  []
ip  dmeq([night,midnight,noon,evening],Night). %% not day ( om 3 dager)


during2timeafter rule
is  replaceall (Ev isa Minute,srel/during2/_/Ev/S) %% om 5 minutter
    with       (Ev isa Minute,srel/after/time/Ev/S)
id  []
ip  dmeq([hour,minute  ,second],Minute). %% ?? %% TA-100903


goandbe rule % after shunt: go and be in_evening => go in_evening
is  context doit/go/F64/F,
    replaceall (doit/be1/F64/F,srel/In_night/time/Nil/F) %% meant to be the same
    with       (srel/In_night/time/Nil/F)           %% buss om en halvtime
id  []
ip  dmeq([in_night,in_evening],In_night). %% etc.



buyticket rule  %% buy ticket
is  F5 isa  ticket,dob/buy/_I/F5/_
id  clear,
    add message(noinfoabout(sale)),
    add ( message(answer(db_reply(TT,webaddress,K))))
ip  main:myflags(actual_domain,TT),
    has_att_val(company,webaddress,TT,K).

whereaboutastt rule % user knows you don't know, astt has answer
is (which(A),B isa self,A isa place,srel/FA/_Thing/C/F,C isa Topic,
    doit/be1/D/F,event/real/F,
    D isa information,dob/FG/B/D/E,event/real/E,srel/in/place/A/E)
id add ( message(answer(db_reply(TT,webaddress,K))))
ip dmeq([find,get,receive],FG),
   dmeq([for,about],FA),
   dmeq([bus,card,departure,information,
         nightbus,season_ticket,special_ticket,
         price,route,agelimit,repair,student,travelinsurance],
         Topic), %% Topics of astt
   main:myflags(actual_domain,TT),
   has_att_val(company,webaddress,TT,K).


whereaboutdn rule % user knows you don't know, I don't know
is (which(A),B isa self,A isa place,srel/about/thing/C/F,C isa _Topic,
    doit/be1/D/F,event/real/F,
    D isa information,find/B/D/E,event/real/E,srel/in/place/A/E)
id add  message(icannotanswer)
ip [].


wherefindastt rule % user knows you don't know, astt has answers of OTHER Topics
is  (which(A),B isa self,A isa place,C isa Topic,
    find/B/C/E,event/real/E,srel/in/place/A/E),
    not (1 isa route),  %% Ad Hoc,  ikke trikk
    not X isa neighbourhood when { (bound(X),foreign(X))}   %% melhus
id  add  message(answer(db_reply(TT,webaddress,K)))
ip  dmeq([card,departure,nightbus,price,route_plan,
         repair,student,travelinsurance],Topic), %% OTHER Topics of astt
    main:myflags(actual_domain,TT),
    has_att_val(company,webaddress,TT,K).



tellwhatbuses rule
is  doit, dob/tell/tuc/A/B,event/real/B,
    tuc isa savant,
    A isa Bus, {unbound(A), dmeq([bus,departure], Bus)},
    not ispresent _ isa station,
    not ispresent _ isa neighbourhood,
    not ispresent _ isa street
id  add listofall(bus,_)
ip  [].


tellwhere1 rule
is  replaceall (test,tuc isa savant,A isa Place,dob/Tell/tuc/A/C,event/real/C)
    with       (which(A),A isa Place)
id  []
ip  dmeq([place,station],Place),
    dmeq([tell,list],Tell).


tellwhere2 rule
is  replaceall (doit,tuc isa savant,A isa Place,dob/tell/tuc/A/C,event/real/C)
    with       (which(A),A isa Place)
id  []
ip  dmeq([place,station],Place).


tellwhere3 rule %% kan du fortelle  om et sted
is  replaceall (doit,tuc isa savant,A isa Place,tell/tuc/C,event/real/C,srel/regarding/thing/A/C)
    with       (which(A),A isa Place)
id  []
ip  dmeq([place,station],Place).



thereafter rule %% klokken KK og deretter
is  replaceall (srel/nil/time/Tid/C,srel/thereafter/time/nil/C)
    with       (srel/after/time/Tid/C)
id  []
ip  [].



otherbus0 rule %% NSB buss %% Fronted
is  _Nettbuss isa otherbus,clear
id	 clear,
    add message(noroutesfor(otherbus))
ip  [].


otherbus1 rule %% NSB buss
is  NSB isa company,has/company/bus/NSB/_,
    {NSB \== atb} %% TA-100905
id	 clear,
    add message(noroutesfor(otherbus))
ip  NSB \== tt. %% varies with installation


otherbus2 rule
is  NSB isa company,doit/go/NSB/_
id	 clear,
    add message(noroutesfor(otherbus)),
    add flag(exit)
ip  NSB \== tt. %% varies with installation


otherbus3 rule
is  dob/hire/_/_/_,
    clear
id	 clear,
    add message(noroutesfor(otherbus))
ip  [].

otherbus4 rule
is  Klaburuta isa bus, %% bussen Klæburuta
    clear
id	 clear,
    add message(noroutesfor(otherbus))
ip  Klaburuta isa otherbus. %% but it is a fact

nostation0x rule %% county/country/ -> only buses Th
is  _ isa Place, { dmeq([country,community,county],Place)},
    not _ isa airplane,
    not _ isa boat,
    not _ isa train,
    not _ isa weather,
    clear
id  not flag(exit),
    not message(foreign(_)),
    not message(noinfoabout(_Weather)),
    clear,
    addfront message(onlybusesforhometown),
    add flag(exit)
ip  [].


nostationairbus rule %% malvik værnes
is  X isa Place, {bound(X),dmeq(place,Place), xforeign(X)}
id  flag(airbus),
    not flag(exit),
    not message(foreign(_)),      %% addcon doesnt work, different X
    clear,
    addfront message(foreign(X)),
    add flag(exit)
ip  xforeign(X).  %%  Klæbu


nostation0 rule %% statsminister i norge %% moved after noinfoaboutnoun
is  X isa Place, {bound(X),dmeq(place,Place)},
    not _ isa airplane,
    not _ isa boat,
    not _ isa train,
    not _ isa weather, %% været på Bekkestua
    clear  %% trikk til bekkestua
id  not flag(exit),
    not message(foreign(_)),      %% addcon doesnt work, different X
    %% not message(noinfoabout(_Weather)), %% weather in oslo  Nar gar bussen fra vestsiden porsgrunn .
    clear,                                 %% direction OK
    addfront message(foreign(X)),
    add flag(exit)
ip  xforeign(X).  %%  Klæbu


notarouteatall rule  % neither bus nor tram
is  NotBus isa route, {bound(NotBus)},
    clear
id	 not flag(exit), %% e.g. foreign
    add message(not(route,NotBus))  %% route
ip	 not main:myflags(tramflag,true),
    NotBus \== it, %% internal anaphora :-)
    not (NotBus  isa otherbus), %% Klæburuta ?
    not exbus(NotBus),
    not regbus(NotBus). %% tt/regbusall


notabusatall rule  % neither bus nor tram
is  NotBus isa bus, {bound(NotBus)},  %% exclude tram
    clear
id	 not flag(exit), %% e.g. foreign
    add message(not(bus,NotBus))  %% route
ip	 not main:myflags(tramflag,true),
    NotBus \== it, %% internal anaphora :-)
    not (NotBus  isa otherbus), %% Klæburuta ?
    not exbus(NotBus),
    not regbus(NotBus). %% tt/regbusall


%% after nostation0 trikk i arendal => Ikke Arendal
noroutesfortram0 rule
is  X isa route,      %% bane fra nationalteateret AFTER nostation
    not ispresent _ isa telephone,
    not ispresent _ isa webaddress,  %% etc
    clear
id  addcon  message(noroutesfor(tram))
ip  main:vehicletype(X,tram),
    \+ main:myflags(tmnflag,true).

noroutesforbus1 rule %%  Buss 1
is  X isa bus ,      %% bane fra nationalteateret AFTER nostation
    not ispresent _ isa telephone,
    not ispresent _ isa webaddress,  %% etc
    clear
id  addcon  message(noroutesfor(tram))
ip  main:vehicletype(X,tram),
    \+ main:myflags(tmnflag,true).


noroutesfortram1 rule %%  trikk til nth
is  _ isa tram,
    not X isa neighbourhood when { foreign(X)},
    not ispresent _ isa clock, %% ad hoc  den (klokka) er 1
    clear
id  addcon  message(noroutesfor(tram)),
    addcon  message(answer(db_reply('Gråkallbanen',webaddress,K)))
ip  \+ main:myflags(tmnflag,true),
    has_att_val(company,webaddress,tram,K).


nostation3 rule %% explicit not a destination, after noroutesfrotram1
is  X isa neighbourhood, { bound(X)},
    clear
id  clear,
    addcon message(noroutesto(X))
ip  nostationfor(X),   %% adm_rit
    \+ main:placestat(X,_).


notanightbus rule %%   NN not a nightbus
is  (NBus isa nightbus),clear
id	 add message(not(nightbus0,NBus)) %% ikke nattbussen men natbuss
ip	 atomic(NBus),  NBus \== it, %% internal anaphora :-)
    not vehicletype(NBus,nightbus).


notatram2 rule %% X is not a tram
is  NotTram isa tram
id	 add message(not(tram,NotTram))
ip	 atomic(NotTram),
      \+ (NotTram isa tram),
      \+ (NotTram == it).

%% after nostation0 etc
totosameplace rule %% %% fra A til B som er på B
is  context srel/to/place/X/E, {bound(X)},
    remove  srel/on/place/X/E
id  []
ip  [].


tofromsameplace rule %% to from sameplace
is  srel/to/place/X/E, {bound(X)},
    srel/from/place/X/E, %% From
    clear
id  clear,
    add message(sameplace(X,X)),
    add flag(exit)
ip  [].


tofromcorrplace rule %% to from sameplace  %% fra studsamf 1 til studsamf 2
is  srel/to/place/X/E,   { bound(X)},
    srel/from/place/Y/E, { bound(Y)},{ corresponds(X,Y)},
    clear
id  clear,
    add message(sameplace(X,Y)), %% near places
    add flag(exit)
ip  [].


resolveclock rule %% -6 means either 1800 today or 6 tomorrow , depending
is  N6 isa clock, {number(N6), N6 <0},
    replaceall (N6 isa clock) with (U1800 isa clock),
    replaceall (srel/P/time/N6/E) with (srel/P/time/U1800/E)
id  []
ip  U1800 is (-N6)*100+1200,
    timenow2(X),
    U1800 < X.

notaclock rule  %% X is not a clock
is  NotClock isa clock,
    { bound( NotClock)},
    clear
id	 add message(not(clock,NotClock)),
    add flag(exit) % finish it
ip	 main:notaclock(NotClock).    %%  buslog


whichtrase rule %% which tracee does the route follow
is    which(A), Bus isa bus, A isa route_plan, event/real/E, dob/run/Bus/A/E
id    atday(Day),
      add (findstations(Bus,Day,Stl),
           passesstations(Bus,Day,Stl,_))
ip   bound(Bus).


nighttosunday rule
is  replaceall
           (C isa midnight,
           srel/nil/daypart/C/D,
           srel/to/time/B/D,
           B isa Sunday)
    with
           (C isa midnight,B isa Saturday,
            srel/nil/daypart/C/D, srel/nil/day/B/D)
id  []
ip  daysucc(Saturday,Sunday).


oddtimestid rule
is  replaceall  (B isa Halfhour,has/Halfhour/DUR/B/C, C isa DUR,
                            srel/during2/DUR/TT/E)          %% semantically necessary
    with        (C isa Halfhour,srel/during2/duration/TT/E)  %% pragmatically necessary
id  []
ip  dmeq([hour,halfhour,quarter],Halfhour),dmeq(duration,DUR).


withfore rule %% innen en time   (ankomst om en time)
is  ispresent srel/in_order_to/thing/_/_,
    replaceall (srel/during2/duration/X/Y)
    with       (srel/before/time/X/Y),
    not X isa day           %%%%%  very hazardous
id  []
ip  [].

withafter rule %% OM 1 time
is  replaceall (srel/during2/duration/X/Y)
    with       (srel/after/time/X/Y),
    not X isa day           %%%%%  very hazardous
id  []
ip  [].


direction1 rule
is  replaceall (F74 isa direction,
                srel/Towards/place/Sentrum/F76,
                event/real/F76,
                doit/be1/F74/F76,
                srel/on/direction/F74/F75)
	 with       (srel/towards/place/Sentrum/F75)
id  []
ip  dmeq(to,Towards).

direction2 rule % ?
is  replaceall (Place isa direction,srel/DD/direction/Place/C)
	 with       (Place isa place,srel/to/place/Place/C)
id  []
ip  dmeq([in,nil,with],DD),
    bound(Place).  %% "retning" alene er kanskje "veg"


direction3 rule % ?
is  replaceall (Place isa direction,srel/DD/direction/Place/C)
	 with       (Place isa place,srel/from/place/Place/C)
id  []
ip  dmeq([from],DD),
    bound(Place).  %% "retning" alene er kanskje "veg"

nightbusitem rule
is  replaceall (item, _ isa nightbus)
    with   which(A),(A isa nightbus,nrel/today/vehicle/day/A/nil)
id  []
ip  newfree(A).



%% fra nth til risvollan.   den 30. november
itemdate rule % an item is treated like a modifier
is  context (item,  X isa Class),{ dmeq([day,date],Class)},
    replaceall (item, X isa date)
    with   (which(A),X isa Class,B isa vehicle,A isa time,doit/go/B/C,srel/on/Class/X/C)
id  []
ip  newfree(B)
  :- double.


%% fra nth til risvollan.   kl 1230.
itemclock rule % an item is treated like a modifier
is  context (item,  X isa Class),
    { dmeq([clock],Class)} ,
    not ispresent doit/go/_/_ ,
    not _ isa endstation,
    not _ isa  tram,
    replaceall (item, X isa Class)
    with   (which(A),X isa Class,B isa vehicle,A isa time,doit/go/B/C,srel/in/time/X/C)
id  []
ip  newfree(B)
  :- double.


iteminfo rule  %%  "bussruteinformasjon"
is  item, it  isa information
id  add message(howtuchelp)
ip  [].



inperiod rule       %% for å nå DV til kl 0830
is  replaceall  (srel/in/Time1/T1/E1,srel/to/time/T2/E2)
    with        (srel/after/Time1/T1/E1,srel/before/time/T2/E2)
id  []
ip  bound(T1),bound(T2).

hasdeparture1 rule  %% which deaprtures has bus 52 ?
is  replaceall  (which(D),B52 isa bus,has/vehicle/departure/B52/D,D isa departure,event/real/A)
    with        (which(T),T isa time,
                 B52 isa bus,doit/go/B52/A,srel/in/time/T/A,event/real/A)
id  []
ip  newfree(T).


hasdeparture2 rule %% which departures does bus 52 have
is  replaceall  (new,B52 isa bus,has/vehicle/departure/B52/D,D isa departure,event/real/A)
    with        (new,T isa time,
                 B52 isa bus,doit/go/B52/A,srel/in/time/T/A,event/real/A)
id  []
ip  newfree(T).


befind rule %% befinne seg  %% Norwagism
is  replaceall (befind/X/_/E)
    with       (doit/be1/X/E)
id  []
ip  [].


hq rule %% what is the office of company
is  replaceall (
      which(FREE_26), TT isa company,
      has/company/office/TT/FREE_23 ,
      FREE_23 isa office,
      doit/be1/FREE_23 /FREE_25 ,
      event/real/FREE_25 ,
      srel/in/place/FREE_26 /FREE_25 ,
      FREE_26 isa place)
    with  (
      which(FREE_26),  TT isa company,
      doit/be1/TT/FREE_25 ,
      event/real/FREE_25 ,
      srel/in/place/FREE_26 /FREE_25 ,
      FREE_26 isa place)
id  []
ip  [].


inorder0 rule
is  context    ( srel/in_order_to/thing/D/_,srel/in/time/D/E),
    replaceall ( doit/be1/A/E,srel/ON/place/Drag/E )
    with       ( dob/pass/A/Drag/E )
id  []
ip  dmeq(by,ON).


inorder1 rule
is replaceall ( srel/in_order_to/thing/D/C,
                D isa time,
                event/real/E,              %% Does this help
                srel/in/time/D/E,
                srel/to/place/Risvollan/_CE,  %% makes it slightly rougher
                srel/at/time/T1300/E)
   with       ( srel/to/place/Risvollan/C,srel/before/time/T1300/C)
id []
ip [].


reachat0 rule
is
    replaceall ( dob/reach/C/D/B, srel/nil/time/Six/B)
    with       ( dob/reach/C/D/B, srel/before/time/Six/B),
    {dmeq(vehicle,C)}
id  []
ip  [].


reachat1 rule
is  replaceall ( dob/reach/C/D/B, srel/at/time/Six/B)
    with       ( dob/reach/C/D/B, srel/before/time/Six/B)
id  []
ip  [].


reachat2 rule
is  replaceall ( dob/take/C/D/B, srel/nil/time/Six/B) %% nil ???
    with       ( dob/take/C/D/B, srel/before/time/Six/B)
id  []
ip  [].


takeit1 rule %% Horrible Hack
is  replaceall (dob/take/it/D/_, doit/go/it/E)
    with       (V isa bus,doit/go/V/E,srel/pwith/duration/D/E)
id  []
ip  newfree(V).



go2it rule
is  replaceall (doit/go/it/C)
    with       (V isa bus,doit/go/V/C)
id  []
ip  newfree(V).

get2it rule
is  replaceall (get/it/C)
    with       (V isa bus,doit/go/V/C)
id  []
ip  newfree(V).


longdist1 rule
is  replaceall (D isa distance, doit/Exist/D/C)
    with       (V isa bus,D isa duration,doit/go/V/C,srel/pwith/duration/D/C)
id  []
ip  dmeq([be1,exist],Exist),newfree(V).

longdist2 rule %% ?
is  replaceall (D isa difference, doit/be1/D/C,srel/after/thing/X/C,srel/before/thing/Y/C)
    with       (V isa bus,D isa duration,doit/go/V/C,srel/pwith/duration/D/C,srel/from/place/X/C,srel/to/place/Y/C)
id  []
ip  newfree(V).


isnamewhat rule %% er TA et menneske %% TA-110825 #-> Person
is test,dob/be/TA/F10/F11,TA isa Person,F10 isa _,event/real/F11,clear
id clear,
   add message(answer(bcpbc(Person))),
   add flag(exit)
ip [].

describename rule
is (tuc isa savant,C isa Clock, dob/describe/tuc/C/E,event/real/E),clear
id clear,          %% hva er du , 1 tuc isa savant -> describe2
   add message(answer(bcpbc(Clock))),
   add flag(exit)
ip bound(C).

describenamenor  rule %% what is 42 = hvilken ting er det 42 er %% TA-110523
is   not (_ isa clock),
    (which(A),X isa Number,A isa thing,event/real/B,dob/be/X/A/B)
id  clear,
    add message(answer(bcpbc(Number))),
    add flag(exit)
ip  [].

describenameeng  rule %% what is 42 = hvilken X er 42
is which(A),(X isa Number,A isa thing,event/real/B,dob/be/A/X/B)
id  clear,
    add message(answer(bcpbc(Number))),
    add flag(exit)
ip  [].

describenoun1 rule  %% beskriv en savant
is  exactly (doit,tuc isa savant,C isa Clock, dob/describe/tuc/C/E,event/real/E),
    clear   %% TA-110523 \+ hva er adressa til steinan
id  clear, add message(answer(bcpbc(Time))),
    add flag(exit)
ip  main:description(Clock,Time).


describenoun2 rule  %% hva betyr savant
is  A isa thing,dob/mean2/B/A/C,B isa Savant,event/real/C,
    {unbound(B)}, %% \+ name %% TA-100927
    clear
id  clear, add message(answer(bcpbc(System))),
    add flag(exit)
ip  main:description(Savant,System).

describe0 rule %% describe X  MEANS what is the class/superclass
%is which(A), (ako/Man/A),
is which(A), (Man ako A),
   clear
id clear, add message(answer((bcpbc(Adult)))),
   add flag(exit)
ip description(Man,Adult).


describe1 rule %% describe X  MEANS what is the class/superclass
is (tuc isa savant,C isa Clock, dob/describe/tuc/C/E,event/real/E),
   {bound(C)},clear
id clear, add message(answer((bcpbc(Clock)))),
   add flag(exit)
ip [].


describe2 rule   %% Dummy, but 2 tuc is coerced
is (tuc isa savant, dob/describe/tuc/C/E,event/real/E),clear
id clear, add message(answer((bcpbc(D)))),
   add flag(exit)
ip description(C,D).


describerev rule   %% what are you (E)=hvilken ting er deg %% TA-100902
is (tuc isa savant, dob/be/_C/tuc/E,event/real/E),
   clear
id clear, add message(answer(bcpbc(busstuc))), %% TA-101015
   add flag(exit)
ip [].


describeq rule
is (tuc isa savant, dob/describe/tuc/quote(Meaning)/E,event/real/E), %RS-111118 ako operator problem
   clear
id clear, add message(answer(bcpbc(Abstract))),
   add flag(exit)
ip userNOTME:(Meaning ako Abstract),  %% (ako/Meaning/Abstract)  %% RS-111121
   \+ member(Meaning,[god,price]). %% etc.


describename rule
is (tuc isa savant,C isa Clock, dob/describe/tuc/C/E,event/real/E),clear
id clear,          %% hva er du , 1 tuc isa savant -> describe2
   add message(answer(bcpbc(Clock))),
   add flag(exit)
ip bound(C).




%¤

innight0 rule % IF T before clock, T < 1200 => innight just eveningtime
is  srel/in_night/time/nil/E,
    replaceall  (  T isa clock, srel/Prep/time/T/E)
    with        ( T1 isa clock, srel/Prep/time/T1/E)
id  []
ip  before(T,1200), %% safe
    evening_time(T,T1).


niltoclockrepair rule % 8 til 9 ( same as toclock ?)
is  replaceall (srel/nil/time/T800/F, srel/to/Time/T900/F)
    with       (srel/after/time/T800/F,srel/before/time/T900/F)
id  []
ip  dmeq([clock,time],Time). %%




toplaceclockbefore rule %% clock with toplace = before clock %%  After tonightat
is   not srel/from/place/_/_,
     not  srel/on/time/_F17/E,  %% etter lørdag (nil) kl 8
     not  adj/_/next/_/_,
     not doit/meetup/'I'/E, %%  på holdepl.
     not ispresent  srel/nil/place/_ABV/E, %% ABV 2203 til S

     replaceall (srel/to/place/J/E,srel/nil/time/T/__E)
     with       (srel/to/place/J/E,srel/before/time/T/E)
id  []
ip  [].



aroundtimetime rule %% rundt 1000 - 1030 -> from 1000 - 1030
is replaceall (srel/around/time/T/E1,srel/nil/time/T2/E2)
   with       (srel/after/time/T/E1,srel/before/time/T2/E2)
id  []
ip  [].


tomorrowat6ugly  rule % Klokken 22:  reise kl 6, om morgenen => next morning with message
is  context srel/_Prep_/time/Six/_, { number(Six)},
    _ isa morning or  srel/in_morning/time/nil/_,  %% not present
    not ispresent srel/_/time/Seven/_ when { (number(Seven), Six \== Seven)}, %% avoid intervals Ad Hoc
    not ispresent srel/early/time/nil/_,
    not ispresent srel/in_day/time/nil/_,
    not ispresent srel/tomorrow/_/_/_,      %% then explicit
    not ispresent srel/day_after_tomorrow/_/_/_, %% TA-110215
    not ispresent srel/today/_/_/_,
    not ispresent srel/tonight/_Daypart/nil/_,
    not ispresent srel/this_midnight/time/nil/_,
    not ispresent _ isa date,
    not ispresent _ isa weekday,  %% hverdager means general (other) day
    not _ isa Day when { dmeq(mtwtfss, Day)}
id  not flag(nightbusflag),
    not flag(earlytime),
    add flag(earlytime),   % ?
    add atday(TOM),
    not atdate2(_,_),
    add atdate2(DaySeqNo,DATE),
    add message(assumetomorrow)  %% <--- sometimes unnec

ip  today(TODAY),
    daysucc(TODAY,TOM),
    number(Six),
    timenow2(0,NOW),
    NOW > Six,
    main:finddate(1,DATE),
    dayModSeqNo(DATE,DaySeqNo).


morningtomorrow  rule % Klokken > 1200:  reise  om morgenen => next morning with message
is  _ isa morning or  srel/in_morning/time/nil/_ or adj/_/early/_/real
    or srel/early/time/nil/_ ,

    not ispresent srel/tomorrow/_/_/_ ,
    not ispresent srel/day_after_tomorrow/_/_/_ , %% TA-110215
    not ispresent srel/_/time/Seven/_  when { number(Seven)},
    not ispresent srel/in_day/time/nil/_,
    not ispresent srel/today/_/_/_,
    not ispresent srel/tonight/_Daypart/nil/_,
    not ispresent srel/this_midnight/time/nil/_,
    not ispresent _ isa date,
    not ispresent _ isa weekday,  %% hverdager means general (other) day
    not _ isa Day when { dmeq(mtwtfss, Day)}
id  not flag(exit), %% hva spiste du til frokost %% TA-110816
    not flag(earlytime),
    add flag(earlytime),
    not flag(nightbusflag),
    not atdate2(_,_),
    add atday(TOM),
    add atdate2(DaySeqNo,DATE),
    add message(assumetomorrow)
ip  today(TODAY),
    daysucc(TODAY,TOM),
    timenow2(0,NOW),
    NOW > 1200, %% morning must be tomorrow
    main:finddate(1,DATE),
    dayModSeqNo(DATE,DaySeqNo).

tonightis18ugly  rule
is  ( _ isa night or  srel/tonight/_/_/_), %% NEW FEATURE
    context srel/Prep/time/Six/D,
     {number(Six),   Six  =< 1200},
    not ispresent srel/early/time/nil/_,
    not ispresent srel/in_day/time/nil/_,  %% " om dagen"
    not ispresent _B isa morning,
    not ispresent srel/in_morning/time/nil/_,
    not ispresent srel/this_midnight/time/nil/_,
    not ispresent srel/tomorrow/_/_/_,            %%
    not ispresent srel/day_after_tomorrow/_/_/_,  %% TA-110215
    not ispresent _ isa date,
    not ispresent _ isa weekday,  %% hverdager means general (other) day
    not _ isa Day when { dmeq(mtwtfss, Day)}, %% DAY is mentioned
    replaceall ( Six isa clock, srel/Prep/time/Six/D)
    with       ( Eighteen isa clock,srel/Prep/time/Eighteen/D) % time is standard
id  not flag(latetime),
    add flag(latetime),
    not flag(nightbusflag)
ip  evening_time(Six,Eighteen).


tonightis18  rule
is  ispresent srel/tonight/_/_/_,  %% ad hoc ugly
    context srel/Prep/time/Six/D,
     { number(Six),   Six  =< 1200},
    not ispresent srel/early/time/nil/_,
    not ispresent srel/in_day/time/nil/_,  %% " om dagen"
    not ispresent _B isa morning,
    not ispresent srel/in_morning/time/nil/_,
    not ispresent srel/this_midnight/time/nil/_,
    not ispresent srel/tomorrow/_/_/_,            %%
    not ispresent srel/day_after_tomorrow/_/_/_,  %% TA-110215
    not ispresent _ isa date,
    not ispresent _ isa weekday,  %% hverdager means general (other) day
    not _ isa Day when { dmeq(mtwtfss, Day)}, %% DAY is mentioned
    replaceall ( Six isa clock, srel/Prep/time/Six/D)
    with       ( Eighteen isa clock,srel/Prep/time/Eighteen/D) % time is standard
id  not flag(latetime),
    add flag(latetime),
    not flag(nightbusflag)
ip  evening_time(Six,Eighteen).
clock0now rule % Hva er klokka nå ? (ad hoc)
is  exactly (which(A),A isa Timeq,
    _ isa thing, event/real/B,srel/now/time/nil/B),
    {dmeq(timeclock,Timeq)}
id	 add  message(time(now,T))
ip  timenow2(0,T).


%% clock questions before   assumeatmidnight %% TA-110221
%% Nar gar bussen fra solsiden til alt.
clock0 rule % Hva er klokka
is  exactly  ( which(A),A isa clock,_ isa thing,event/real/_), %%
           %*% space TA-101001
    not ispresent _ isa coevent %% TA-100715
id	 add (timenow2(0,T),timeis(T)),
    add flag(exit)
ip	 unbound(A).


clocktime  rule % Hvilken tid  er klokka
is  exactly (which(A),(A isa Clock,_ isa time,event/real/_)),
       {dmeq(timeclock,Clock)}
id	 add (timenow2(0,T),timeis(T))
ip	 unbound(A).

clock1 rule % Hva er klokka?
is  exactly (which(A),B isa clock,
             doit/be1/A/C,event/real/C,srel/nil/time/B/C)
id	 add (timenow2(0,T),timeis(T))
ip	 [].


clock2 rule % Hva er klokka?
is  exactly (which(Time),Time isa Timeq)
id	 add (timenow2(0,T),timeis(T))
ip  unbound(Time),
    dmeq(timeclock,Timeq). %% not duration


clock3 rule % Hva er klokka nå?
is  exactly (which(A),B isa Timeq,doit/be1/A/C,event/real/C,
             srel/nil/time/B/C,srel/now/time/nil/C)
id	 add (timenow2(0,T),timeis(T))
ip	  dmeq(time,Timeq).


clock4 rule % What is the time?
is  exactly (which(A),A isa Timeq,event/real/_)
id	 add (timenow2(0,T),timeis(T))
ip	 dmeq(time,Timeq), unbound(A).


clock5 rule % What is the time now?
is  exactly (which(A),A isa Timeq,doit/be1/A/B,event/real/B,srel/now/_/nil/B)
id	 add (timenow2(0,T),timeis(T))
ip	  dmeq(time,Timeq).


clock6 rule % What time is it?
is  exactly (which(A),A isa Timeq,doit/be1/A/B,event/real/B)
id	 add (timenow2(0,T),timeis(T))
ip	  dmeq(time,Timeq).


clock7 rule % What time is it now? << clock0
is  exactly (which(A),(B isa clock,srel/now/time/nil/C,event/real/C,dob/be/A/B/C))
id	 add (timenow2(0,T),timeis(T))
ip  [].


clock8sic2 rule % hvor lenge er det til klokka 2400
is  which(A),(2400 isa clock,A isa time,doit/be1/_CLOCK/B,srel/in/time/A/B,event/real/B),
    {unbound(A)}
id	 add (timenow2(0,T),timeis(T)),
    add flag(exit)
ip  [].


clock8sic rule % Klokka er 10 (SIC)
is  exactly (new,B isa _Number,A isa clock,event/real/C,dob/be/A/B/C),
    {number(B)}, {unbound(A)}
id	 add (timenow2(0,T),timeis(T)),
    add flag(exit)
ip  [].


clock8sicnow rule % Klokka er 10 nå (SIC)
is  exactly (new,dob/be/A/B/C,B isa _Number,A isa clock,event/real/C,srel/now/time/nil/_),
    {number(B)}, {unbound(A)}
id	 add (timenow2(0,T),timeis(T)),
    add flag(exit)
ip  [].


%% before assumeatmidnight
ateveningimplicit  rule %%  1230:, jeg skal til byen før 0200 -> 1400>1230
is  context srel/Prep/time/Six/D,
          { (number(Six),morning_break(T0430),Six =< T0430)},  %% improbable
        not ispresent srel/early/time/nil/_,
        not ispresent _B isa morning,
        not ispresent srel/this_morning/time/nil/_,
        not ispresent srel/in_morning/time/nil/_,
        not ispresent srel/this_midnight/time/nil/_,
    replaceall ( Six isa clock, srel/Prep/time/Six/D)
    with       ( Eighteen isa clock,srel/Prep/time/Eighteen/D) % time is standard
id  not flag(earlytime),
    not flag(latetime),
    not flag(latetime),
    not flag(nightbusflag)
ip  timenow(T1200),
    evening_time(Six,Eighteen),
    T1200 =< Eighteen.



assumeatmidnight  rule
is  MMMM isa clock, {bound(MMMM)},
        {morning_break(M0), MMMM >= 100, MMMM < M0},

    not ispresent srel/today/_/_/_,  %% etc

    {\+ main:myflags(airbusflag,true)}, %% airbus starts at 400 (!)
                                         % 430 set as early time
    not srel/early/time/nil/_,  %% then NOT midnight
    not srel/today/_Day/nil/_   %% means coming morning

id  not flag(airbus),
    not flag(nightbusflag),
    add flag(nightbusflag)

ip  set(nightbusflag,true). %%  // necessary

%% before tomorrow rule %% TA-101025

ateveningexplicit  rule %% 1230:   jeg skal til byen før 6 -> 1800
is  ispresent  _ isa afternoon,
    not ispresent srel/_Prep2_/time/Fourteen/_
                 when { (number(Fourteen),Fourteen >=1200)},
                              %% Time: 1500,  1200 - 1400 \==> 2400 - 1400
    context srel/Prep/time/Six/D,
    { (number(Six),  Six  =< 1200)},
    not ispresent srel/early/time/nil/_,
    not ispresent _B isa morning,
    not ispresent srel/this_morning/time/nil/_,
    not ispresent srel/in_morning/time/nil/_,
    not ispresent srel/this_midnight/time/nil/_,
    replaceall ( Six isa clock, srel/Prep/Clock/Six/D)
    with       ( Eighteen isa clock,srel/Prep/time/Eighteen/D) % time is standard
id  not flag(earlytime),
    not flag(latetime),
    not flag(latetime),
    not flag(nightbusflag)
ip  number(Six),
    dmeq(clock,Clock),evening_time(Six,Eighteen).
    %% man 2150   "før kl 6" -> 18 selv om for sent for det også




tomorrow  rule % TIMENOW > SCHEDULED TIME
is  not ispresent _ isa day, %% om tre dager
    not ispresent  srel/day_after_tomorrow/day/nil/_,
    context
  ( Schedtime isa clock, srel/Prep/time/Schedtime/_),

    not Schedtime isa hour, %%  ad hoc (om) en time
    not Schedtime isa minute,
    not ispresent _ isa morrow,  %% Techn
    not ispresent _ isa midnight,
    not ispresent _ isa morning,
    not ispresent _ isa prenoon, % new
    not ispresent _ isa afternoon, %
    not ispresent _ isa evening, %
    not ispresent _ isa night, %
    not ispresent _ isa date,
    not ispresent _ isa weekday,  %% hverdager means general (other) day

    not _ isa Day when { dmeq(mtwtfss, Day)},
    not ispresent srel/yesterday/_/_/_ ,
    not ispresent srel/this_prenoon/time/nil/_, %% ?
    not ispresent srel/in_prenoon/time/nil/_,   %% ?
    not ispresent srel/in_morning/time/nil/_,
    not ispresent srel/early/time/nil/_,
    not ispresent srel/in_day/time/nil/_,
    not ispresent srel/tomorrow/_/_/_,      %% then explicit
    not ispresent srel/day_after_tomorrow/_/_/_,  %% TA-110215
    not ispresent srel/today/_/_/_,         %% then past deps are OK
    not ispresent srel/tonight/_Daypart/nil/_,
    not ispresent srel/this_midnight/time/nil/_
id  not flag(exit),
    not flag(nightbusflag),
    not atdate2(_,_),  %% Retention
    add atdate2(DaySeqNo,DATE),
    add atday(TOM),
    add message(assumetomorrow)
ip  today(TODAY),
    daysucc(TODAY,TOM),
    number(Schedtime),
    timenow2(0,Timenow),
    Timenow > Schedtime,

    (Prep = after ->   aroundmargin(MT); MT=0),

    addtotime(Schedtime,MT,SchedtimePlus), %% time many  min before now
    Timenow > SchedtimePlus,
    main:finddate(1,DATE),
    dayModSeqNo(DATE,DaySeqNo).



tomorrowat6early  rule % Klokken 22:  reise kl 6,  next morning with message
is  context srel/_Prep_/time/Six/_, { number(Six)},
 %% If not another day, then these means Today
    not ispresent _ isa midnight,
    not ispresent _ isa morning,
    not ispresent _ isa prenoon, % new
    not ispresent _ isa afternoon, %
    not ispresent _ isa evening, %
    not ispresent _ isa night, %
    not ispresent _ isa date,
    not ispresent _ isa weekday,  %% hverdager means general (other) day

    not _ isa Day  when { dmeq(mtwtfss, Day)},

    not ispresent srel/yesterday/_/_/_ ,
    not ispresent srel/this_prenoon/time/nil/_, %% ?
    not ispresent srel/in_prenoon/time/nil/_,   %% ?
    not ispresent srel/in_morning/time/nil/_,
    not ispresent srel/early/time/nil/_,
    not ispresent srel/in_day/time/nil/_,
    not ispresent srel/tomorrow/_/_/_,           %% then explicit
    not ispresent srel/day_after_tomorrow/_/_/_, %% TA-110215
    not ispresent srel/today/_/_/_,
    not ispresent srel/tonight/_Daypart/nil/_,
    not ispresent srel/this_midnight/time/nil/_,

    replaceall ( Six isa clock, srel/Prep/time/Six/D)
    with       ( Newtime isa clock,srel/Prep/time/Newtime/D) % time is standard

id  not flag(exit),
    not flag(earlytime),
    add flag(earlytime),
    not flag(latetime),
%%     add flag(latetime),
    not flag(nightbusflag),
    not atdate2(_,_),
    add atdate2(DaySeqNo,DATE),
    add atday(TOM),
    add   message(assumetomorrow)
ip  today(TODAY),
    daysucc(TODAY,TOM),
    number(Six),
%    Six >=100,  %% 15 = 0015 never 1215 %% 154       never 1354
    Six >= 0430, %% 429        never 1629 % ?
    timenow2(0,NOW),
    NOW > Six,
    evening_time0(Six,Eighteen), %% 1330 -> 1330

%    maxtraveltime(MT),   %% 23:05      fra rosendal til gløshaugen før klokken 10.
     aroundmargin(MT),    %% more modest
     addtotime(Eighteen,MT,EighteenPlus), %% time many  min before now
     NOW > EighteenPlus, %% Far too late for that also

    (Six < 0430 -> Newtime=Eighteen %% not morning if <5
                ;  Newtime=Six),  %% next morning
    main:finddate(1,DATE),
    dayModSeqNo(DATE,DaySeqNo).





tomorrowat6late  rule % Klokken 22:  reise kl 0230 -> 1430 TOMORROW
is  context srel/_Prep_/time/Four/_, { number(Four)},
    not ispresent _ isa midnight,
    not ispresent _ isa morning,
    not ispresent _ isa prenoon,

    not ispresent _ isa afternoon, % then mess is redundant
    not ispresent _ isa evening,
    not ispresent _ isa night,
    not ispresent _ isa date,
    not ispresent _ isa weekday,  %% hverdager means general (other) day

    not _ isa Day when { dmeq(mtwtfss, Day)},

    not ispresent srel/this_prenoon/time/nil/_,
    not ispresent srel/in_prenoon/time/nil/_,
    not ispresent srel/in_morning/time/nil/_,
    not ispresent srel/early/time/nil/_,
    not ispresent srel/in_day/time/nil/_,
    not ispresent srel/tomorrow/_/_/_,   %% then explicit
    not ispresent srel/today/_/_/_,
    not ispresent srel/tonight/_Daypart/nil/_,
    not ispresent srel/this_midnight/time/nil/_,

    replaceall ( Four isa clock, srel/Prep/time/Four/D)
    with       ( Fourteen isa clock,srel/Prep/time/Fourteen/D) % time is standard

id  not flag(exit), %% ?
    not flag(earlytime),
    not flag(latetime),
    add flag(latetime),
    not flag(nightbusflag),
    not atdate2(_,_),
    add atdate2(DaySeqNo,DATE),
    add atday(TOM),
    addfront message(assumetomorrow)
ip  today(TODAY),
    daysucc(TODAY,TOM),
    before(Four, 0430), %% NB
    timenow2(0,NOW),
    NOW > Four,
    evening_time0(Four,Fourteen),
    NOW > Fourteen,

    main:finddate(1,DATE),
    dayModSeqNo(DATE,DaySeqNo).

%% TA-101025


anight rule %%  buss går  mellom klokka 6 og 7 om kvelden
is  ispresent _ isa night,
    not _B isa morning,
    not srel/this_midnight/time/nil/_,
    replaceall ( Six isa clock, srel/Prep/Clock/Six/D)
    with       ( Eighteen isa clock,srel/Prep/time/Eighteen/D) % time is standard
id  not flag(nightbusflag)
ip  dmeq(clock,Clock),evening_time(Six,Eighteen).



tonightat6 rule %%  buss går  mellom klokka 6 og 7 om kvelden
is  ispresent srel/IE/time/nil/D, { dmeq(pm,IE)}, %% use it twice
    not _B isa morning,
    not srel/this_midnight/time/nil/_,
    replaceall ( Six isa clock, srel/Prep/Clock/Six/D)
    with       ( Eighteen isa clock,srel/Prep/time/Eighteen/D) % time is standard
id  []
ip  dmeq(clock,Clock),evening_time(Six,Eighteen).


inconsistenttimes rule %% before 1100 and after 1200  ( 2300 - 0100 ? )
                       %% After notatnight b.o. temporary inconsistency
is  not ispresent srel/back/place/nil/_,
    srel/after/time/X/_, srel/before/time/Y/_,
    not X isa minute, %% ad hoc
    not Y isa minute, %% 10 minutes before
    clear
id  clear,
    add  message(inconsistenttimes),
    add flag(exit)
ip  number(X),number(Y), X > Y.


neighbourstreetonplace rule %% neighbour street on place
is  replaceall (Byåsen isa neighbourhood,srel/TO/place/Otto_S_street/A,
                Otto_S_street isa STREET,srel/on/place/Byåsen/A)
    with   (Otto_S_street isa STREET,srel/TO/place/Otto_S_street/A)
id  []
ip  dmeq([street],STREET). %% e.g. not meeting,station




gotoheaven rule %% for å være på
is  srel/in_order_to/_/_/_,
    not srel/to/_/_/_   ,     %% NOT already a to place
    replaceall ( doit/be1/I/E, I isa Self, srel/INON/Place/PS/E)
    with       ( doit/go/I/E,  I isa Self, srel/to/Place/PS/E)
id  []
ip  dmeq([self,agent],Self),
    dmeq(at,INON),
    dmeq(place,Place).


liveinhell rule %% means going from
is  %% new, %%  context    (I isa self), %% når jeg bor i %% TA-110825
    %% not srel/in_order_to/_/_/_,          %% related to be1
    not dob/want/_/that/_,
    replaceall (  doit/live/I/E, srel/_On/place/PS/E)  %% E in/N on
    with       (  doit/go/I/E,  srel/from/place/PS/E)  %% TA-110225
                           	 %% NOT NEUTRAL
id  []
ip  [].


fetch rule  % Fetching cars is very relevant %% after liveinhell
is  replaceall (fetch/I/A/E, I isa self,A isa _Car,srel/AtOn/place/NAF/E)
    with       (I isa self,doit/go/I/E, srel/to/place/NAF/E)
id  []
ip  dmeq([at,on],AtOn). %% not from, destroys go from if live on // Intricate!


nobustohell0 rule %% TA-100910  never NP-mod reach train|to oslo
is  context ('I' isa self,dob/reach/'I'/A/E),
    replaceall (srel/to/place/Oslo/E,A isa Train,Oslo isa Neigh )
    with       (A isa Train)
id  []
ip  dmeq([plane,boat,train],Train),
    dmeq([city,neighbourhood],Neigh). %% oslo changed from neigh. to city

nobustohell1 rule % ignore where train goes to
is  replaceall (doit/go/A/E,srel/to/place/Oslo/E,A isa Train,Oslo isa Neigh )
    with       (A isa Train)
id  []
ip  dmeq([plane,boat,train],Train),
    dmeq([city,neighbourhood],Neigh). %% oslo changed from neigh. to city

nobustohell2 rule % ignore where train is to
is  replaceall (doit/be1/A/E,srel/to/place/Oslo/E,A isa Train,Oslo isa Neigh )
    with       (A isa Train)
id  []
ip  dmeq([plane,boat,train],Train),
    dmeq([city,neighbourhood],Neigh). %% oslo changed from neigh. to city


reachtrain rule % nå et tog %%  there are several train stations ?   %% (KME)
is  not ispresent ts isa _,  %% already mentioned -> mess sameplace
    replaceall  (C isa self,D isa train,dob/TAKE/C/D/E)
    with        (C isa self,ts isa neighbourhood,
                 doit/go/C/E, srel/to/place/TS/E) %% AtB
id  []
ip  dmeq(take,TAKE),
    railway_station(TS). %% AtB


reachboatthatleaves rule  % nå en båt som går/er 1215 fra PT
is  replaceall  (C isa self,D isa boat,dob/TAKE/C/D/E,srel/Nil/time/HHMM/K,srel/from/place/PT/K, doit/Go/D/K)
    with        (C isa self,doit/go/C/E,srel/before/time/HHMM/E,srel/to/place/PT/E),
    {dmeq([go,be1],Go)},
    {dmeq([nil,after,before],Nil)} %% after clocksequence
id  []
ip  dmeq(take,TAKE).


reachbusthatleaves rule  % nå en buss   som går 1215 FRA PT
is   replaceall  (C isa self,D isa bus,dob/reach/C/D/E,srel/Nil/time/HHMM/K,srel/from/place/PT/K,doit/Go/D/K)
    with        (C isa self,doit/go/C/E,srel/before/time/HHMM/E,srel/to/place/PT/E),
    {dmeq([go,be1],Go)},
    {dmeq([nil,after],Nil)}
id  []
ip  [].  %%   vi tar bussen fra risvollan kl 19. \=  vi rekker bussen fra risvollan kl 19.



%% After reachtrainthatleaves
notabusnotmn rule %% AFTER nobustohell boat,plane  no tmnflag
is  (_NotBus isa BR),
    { dmeq([airplane,train,train_route_plan,tram,boat],BR)},
    not ispresent _ isa clock, %% den (klokka) er 1.
    clear
id  clear,
    add message(noinfoabout(BR))
ip  \+ main:myflags(tmnflag,true).


ankomme rule  %% NB after reachtrain  %% Norwagism %% ankomme (reach) = gå til
is  context    S isa Place,
    not        srel/to/place/_/_,
    replaceall (dob/reach/B/S/E)
    with       (doit/go/B/E,srel/to/place/S/E)
id  []
ip  dmeq(place,Place).

beavailable rule
is  replaceall (A isa BR,adj/_/available/A/C)
    with       (A isa BR,doit/go/A/C)
id  []
ip  dmeq(bus,BR).


witharrival rule
is  ispresent X isa STAT,
    replaceall  srel/pwith/arrival/X/Y %% X is not a time !!!
    with        srel/to/place/X/Y

id  []
ip  dmeq([station,neighbourhood],STAT).


contain rule  %%  ( NB   takes both  Subj/OBj and Obj/Subj
is  replaceall  ( contain/A/Midtbyen/B)
    with        ( doit/be1/Midtbyen/B, srel/in/place/A/B )
id  []
ip  bound(Midtbyen).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


firsthour rule %% firstminutes rule ???
is replaceall (B isa hour,adj/_/first/B/_,srel/nil/hour/B/D)
   with       (B isa hour,srel/within/hour/B/D)
id []
ip [].


everynthminute rule
is A isa minute,adj/_/Tenth/A/real,
       not ispresent srel/in/time/_/_, %% ask for time
    clear
id  clear,
    add message(noinfoabout(frequency))
ip  ordinal(Tenth,_).


often rule  % how often
is  srel/often/time/nil/_,
    not ispresent srel/last/_/_/_,  %% often late
    clear
id  clear,
    add message(noinfoabout(frequency))
ip  [].



eachhour rule % "each hour"  means "how often"
is  context
     (howmany(F1), F1 isa bus, F3 isa hour, event/real/F2, srel/IN/time/F3/F2 ),
    replaceall (howmany(F1),F3 isa hour,srel/IN/time/F3/F2)
    with       (which(F0),  srel/pwith/frequency/F0/F2)
id []
ip dmeq(intime,IN),newfree(F0).


goon rule  % Go on means take
is  context  (I isa self,B isa BUS1),
    replaceall  (doit/Go/I/E,srel/ONOFF/BUS2/B/E)
    with        (dob/take/I/B/E)
id  []
ip  dmeq(onoff,ONOFF),dmeq([bus,nightbus,route],BUS1),dmeq([bus,nightbus,route],BUS2),
    dmeq([go,think,wonder],Go).  %% Facetious ???

ident1  rule
is  ispresent test,comp/_Clock/eq/X/X
id  not message(onlyonesentence),
    add true %% Yes is added
ip  [].

ident2  rule
is  ispresent test,dob/be/X/X/_
id  not message(onlyonesentence),
    add true %% Yes is added
ip  [].


areyouwhator rule % are you a man  or a computer
is  test,tuc isa savant,dob/be/tuc/(_;_)/_,clear
id  not message(onlyonething),
    add  message(onlyonething),
    add flag(exit)
ip  [].

areyouamachinenow  rule %% TA-100927
is  test,(tuc isa savant,dob/be/tuc/A/B,A isa S,event/real/B)
id  not message(onlyonesentence),
    add true %% Yes is added
ip  dmeq([program,computer,oracle,savant],S).


areyouwhatyes0 rule % are you a program 1 %% er du en maskin da %% TA-100927
is  test,Tuc isa savant,Tuc isa Man,event/real/_
id  not message(onlyonesentence),
    add true %% Yes is added
ip  dmeq([program,computer,oracle],Man).


areyouwhatyes1 rule % are you a program 2
is  exactly (test,Tuc isa savant,dob/be/Tuc/A/B,A isa Man,event/real/B )
id  not message(onlyonesentence),
    add true %% Yes is added
ip  dmeq([program,computer,oracle],Man).

areyouwhatyes2 rule
is  test,Tuc isa savant,dob/be/Tuc/A/_, event/real/E,adj/nil/correct/_/E,A isa Man
id  not message(onlyonesentence),
    add true %% Yes is added
ip  dmeq([program,computer,oracle],Man).


youarewhatyes1 rule
is  new,tuc isa savant,dob/be/tuc/A/B,A isa Man,event/real/B,
    not adj/nil/bad/A/_  %% dårlig :-( %% TA-101222
id  not message(onlyonesentence),
    add true %% Yes is added
ip  dmeq([program,computer,oracle],Man).


areyouwhatno0 rule  %%  are you a girl 1
is  exactly (test,Tuc isa savant,Tuc isa Man,event/real/_ )
id  not message(onlyonesentence),
    add false %% No is added
ip  \+ dmeq([program,computer,oracle,friend],Man). %% are you my friend->no

areyouwhatno1 rule %%  are you a girl 2
is  test, Tuc isa savant, dob/be/Tuc/A/B, A isa Man, event/real/B
id  not message(onlyonesentence),
       {\+ dmeq([thing],Man)}, %%"er du det" %% TA-110103
    add false %% No is added
ip  \+ dmeq([program,computer,oracle,system,friend],Man). %% not agent

areyouwhat1 rule % are you busstuc 1
is  exactly (test,Tuc isa savant,event/real/_ )
id  add  true %% Yes is added
ip  dmeq([busstuc,bustuc,tuc],Tuc).

areyouwhat2 rule % are you busstuc 1
is  test,(tuc isa C,event/real/_),
    not adj/_/_/_/_           %% yellow computer
id  add  true %% Yes is added
ip  dmeq([oracle,computer,robot],C).  %% etc.

areyouwhat3 rule % are you an oracle
is  test,(tuc isa savant,tuc isa C,event/real/_),
    not adj/_/_/_/_           %% yellow computer
id  add  true %% Yes is added
ip  dmeq([oracle,computer,robot],C).  %% etc.

areyouwhat4 rule
is  test,(bustuc isa savant,bustuc isa C,event/real/_),
    not adj/_/_/_/_           %% yellow computer
id  add  true %% Yes is added
ip  dmeq([oracle,computer],C).  %% etc.



isitwhat1 rule
is  test,(Two isa route,Two isa bus,event/real/_), %% Ad hoc
    not adj/_/_/_/_           %% yellow bus
id  add  true %% Yes is added
ip  [].

isitwhat2 rule
is  test,(CS isa station,CS isa neighbourhood,event/real/_), %% Ad hoc
    not adj/_/_/_/_           %% yellow bus
id  clear, add  true %% Yes is added
ip  bound(CS),
    main:station(CS),
    main:neighbourhood(CS).


isitwhat3 rule
is  exactly (test, dob/be/Two/F5/E, Two isa route, F5 isa Bus,  event/real/E)
id  clear, add  true,
    add flag(exit) %% %% Yes is added
ip  bound(Two),Two \== it, %%   Is this a joke :-)
    vehicletype(Two,Bus).


isitwhat4 rule
is  exactly (test,Trondheim isa City,event/real/_)
id  add  true %% Yes is added
ip  bound(Trondheim),Trondheim \== it, %%   Is this a joke :-)
    bound(City),
    dmeq([city,station],City). %% NOT holiday !!!



languageyes1 rule  %%  snakke på
is  not which(_),
    L isa language,
    speak/TUC/E,
    srel/ION/language/L/E,
    not  ispresent explain,
    not ispresent adj/_/only/L/_
id  add true
ip  dmeq([in,on],ION),
    dmeq([tuc],TUC),  %% I speak = May I speak
    dmeq([norsk,bokmål,english],L).


languageyes2 rule % may I speak = you speak
is  not which(_),
    L isa language,
    dob/Understand/TUC/L/_, %% not speak
    not ispresent explain,
    not ispresent adj/_/only/L/_
id  add true
ip  dmeq([speak,talk,understand,know,know1,write],Understand), %% TA-100905
    dmeq(['I',tuc],TUC),  %% I speak = May I speak
    dmeq(knownlanguage,L).


languageand rule
is  not which(_),
    L isa language,
    dob/Understand/TUC/(_,_)/_, %% N and E
    not ispresent explain,
    not ispresent adj/_/only/L/_
id  add message(onlyonething)
ip  dmeq([speak,talk,understand,know,know1],Understand),
    dmeq(['I',tuc],TUC),  %% I speak = May I speak
    dmeq(knownlanguage,L).

languageor rule
is  not which(_),
    L isa language,
    dob/Understand/TUC/(_;_)/_, %% N or E
    not ispresent explain,
    not ispresent adj/_/only/L/_
id  add message(onlyonething)
ip  dmeq([speak,talk,understand,know,know1],Understand),
    dmeq(['I',tuc],TUC),  %% I speak = May I speak
    dmeq(knownlanguage,L).


languageyes3 rule
is  L isa language,Quest isa question, dob/ask/_I/Quest/_,srel/on/language/L/A,event/real/A,
    not ispresent explain
id  add  true %% message(yes)
ip  L isa language,
    dmeq(knownlanguage,L).


languageyes4 rule
is  L isa language,dob/ask/_I/_,srel/on/language/L/A,event/real/A,
    not ispresent explain
id  add  true %%  message(yes)
ip  L isa language,
    dmeq(knownlanguage,L).


languageno1 rule
is  tuc isa savant,L isa language,dob/SPEAK/tuc/L/A,event/real/A,
    not ispresent explain
id  add  false
ip  dmeq(speak,SPEAK), L isa language,
    (L isa language). %% dmeq(knownlanguage,L).


languageno2 rule
is  tuc isa savant,nynorsk isa language,tell/tuc/A,event/real/A,
   not ispresent explain
id  add  false % message(no)
ip  [].


languageno3 rule
is  I isa self,L isa language,doit/ASK/I/A,srel/_/language/L/A,event/real/A,
    not ispresent explain
id  add  false % message(no)
ip  dmeq([ask],ASK), L isa language,
    \+ dmeq(knownlanguage,L).


reply rule
is  reply(H)
id  add message(answer(write(H))),
    add flag(exit)
ip  [].


replyq rule
is  replyq(H)
id  add replyq(H),
    add flag(exit)
ip  []
    :- single.


corresponding0 rule %% reach (last) bus 63    %% TA-110121 RRONTED
is  ispresent Bus isa route,dob/reach/'I'/Bus/_ %% befor onlyonebus..
id	 addcon message(nocorresponse),
    add flag(exit) %
ip  [].


corresponding1 rule %% corresponding buses
is  ispresent Bus isa bus,adj/_/corresponding/Bus/_
id	 addcon message(nocorresponse),
    add flag(exit) % ?
ip  [].

corresponding2 rule %% wait for bus
is  ispresent Bus isa bus,doit/wait/Bus/_
id	 addcon message(nocorresponse),
    add flag(exit) % ?
ip  [].

corresponding4 rule  %% I change (bus)
is  doit/change/'I'/_
id	 addcon message(nocorresponse),
    add flag(exit) % ?
ip  [].

corresponding5 rule %% bus correspond
is  ispresent _Bus isa BR, doit/correspond/_Buses/_ %% TA-100903
id	 addcon message(nocorresponse),
    add flag(exit) % ?
ip  dmeq(busdeparr,BR).
onlyonebusreach rule
is  dob/reach / (_ ,_)/_ / _ ,
    clear %%  Når Rute 3 og 4 Ringve skole  %% Anomaly
id  add message(answer(bcpbc(onlyonebus)))
ip  [].

onlyonebusgo rule
is  doit/go/(X,_)/_,
    ispresent  X isa BUS %%  når går buss 5 og 66 t dragvoll.
id  add message(answer(bcpbc(onlyonebus)))
ip  dmeq(bus,BUS).


onlyonebuspass rule
is  doit/pass/(X,_)/_, X isa BUS
id  add message(answer(bcpbc(onlyonebus)))
ip  dmeq(bus,BUS).


onlyonebus1or rule   %%  etc
is  doit/go/(X;_)/_ ,  X isa BUS %%  a or b or c
id  add message(answer(bcpbc(onlyonebus)))
ip  dmeq(bus,BUS).

onlyonebuspassor rule
is  doit/pass/(X;_)/_ ,X isa BUS
id  add message(answer(bcpbc(onlyonebus)))
ip  dmeq(bus,BUS).

onlyonebuspass2or rule
is  dob/pass/(X;_)/_/_,  X isa BUS
id  add message(answer(bcpbc(onlyonebus)))
ip  dmeq(bus,BUS).

onlyonebus3 rule
is  srel/_/_/(X,_)/_ , X isa BUS
id  not message(nocorresponse), %% TA-110121
    add message(answer(bcpbc(onlyonebus)))
ip  dmeq(bus,BUS).

onlyonebus4 rule
is  has/BUS1/departure/(X,_)/_ ,X isa BUS
id  add message(answer(bcpbc(onlyonebus)))
ip  dmeq(bus,BUS),dmeq(bus,BUS1).


onlyonebus5 rule
is  dob/take/_/(X,_)/_ , X isa BUS
id  add message(answer(bcpbc(onlyonebus))),
    add flag(exit)
ip  dmeq(bus,BUS).

onlyonebus5or rule
is  dob/take/_/(X;_)/_ , X isa BUS
id  add message(answer(bcpbc(onlyonebus))),
    add flag(exit)
ip  dmeq(bus,BUS).


%%%

arriveandison rule %% arrive  NTH  and ... to TV
is  context (I isa self, doit/arrive/I/E,srel/nil/place/TV/E, NTH isa Station ),
    { (NTH \== TV)},
    replaceall (doit/be1/I/D,event/real/D,srel/OTAN/place/NTH/D)
     with      (doit/go/I/D, event/real/D,srel/from/place/NTH/D)
id  []
ip  dmeq(nato,OTAN),dmeq(place,Station).

isalreadyon rule %% is on NTH  and ... to TV
is  context (I isa self, srel/to/place/TV/_ , NTH isa Station ),
    { NTH \== TV, \+ placestat(NTH,TV),\+ placestat(TV,NTH)},
    replaceall (doit/be1/I/D,event/real/D,srel/OTAN/place/NTH/D,srel/PREP/TIME/T/D)
     with      (doit/go/I/D, event/real/D,srel/from/place/NTH/D,srel/PREP/time/T/D)
id  []
ip  dmeq(nato,OTAN),dmeq(place,Station),
    dmeq(time,TIME).


haho0 rule %%   before hm1
is  replaceall (A isa hour,adj/_/half/A/_)
    with       (A isa halfhour)
id  []
ip  [].

%% Convert hours to minutes once and forall



hm0 rule %%  N  hours
is  replaceall (quant(eq/N, Hours), Hours isa hour,      srel/Within/HOUR/Hours/E)
    with       (Minutes isa minute,  srel/Within/minute/Minutes/E)
id  []
ip  dmeq(hour,HOUR),unbound(Hours),Minutes is 60*N.


hm1 rule %%  an hour
is  replaceall (Hours isa hour,      srel/Within/HOUR/Hours/E)
    with       (Minutes isa minute,  srel/Within/minute/Minutes/E)
id  []
ip  dmeq(hour,HOUR),unbound(Hours),Minutes is 60.


hm2 rule
is  replaceall (Hours isa hour,      srel/Within/HOUR/Hours/E)
    with       (Minutes isa minute,  srel/Within/minute/Minutes/E)
id  []
ip   dmeq(hour,HOUR),number(Hours),
     Minutes is integer(Hours*60).


haho1 rule %%  halfhour to minutes
is  replaceall (Halfhours isa halfhour, srel/Within/HOUR/Halfhours/E)
    with       (Minutes isa minute,     srel/Within/minute/Minutes/E)
id  []
ip  dmeq(hour,HOUR),unbound(Halfhours), Minutes is 30.

haho2 rule %%  n  halfhours  to minutes
is  replaceall (Halfhours isa halfhour,    srel/Within/HOUR/Halfhours/E)
    with       (Minutes isa minute,        srel/Within/minute/Minutes/E)
id  []
ip   dmeq(hour,HOUR),number(Halfhours),Minutes is Halfhours*30.



qm1 rule %%   quarter to minutes
is  replaceall (Quarters isa quarter,      srel/Within/QUARTER/Quarters/E)
    with       (Minutes isa minute,  srel/Within/minute/Minutes/E)
id  []
ip  dmeq(quarter,QUARTER),unbound(Quarters),Minutes is 15.

qm2 rule %%  quarters to minutes
is  replaceall (Quarters isa quarter,      srel/Within/QUARTER/Quarters/E)
    with       (Minutes isa minute,  srel/Within/minute/Minutes/E)
id  []
ip   dmeq(quarter,QUARTER),number(Quarters),Minutes is Quarters*15.


whichisbe2  rule %%    Hvor ligger bussholderplassen som heter Tyholt?
is  replaceall (which(A),Tyholt isa station,B isa station,A isa place,event/real/C,dob/be/B/Tyholt/C,doit/be1/B/D,srel/in/place/A/D,event/real/D)
    with       (which(A),Tyholt isa station,B isa station,A isa place,event/real/C,
    doit/lie1/Tyholt/D,srel/in/place/A/D,event/real/D) %% TA-110503
id  []
ip  [].

whichisnamed  rule %%    Hvor ligger bussholderplassen som heter Tyholt?
is  replaceall (which(A),Tyholt isa station,B isa station,A isa place,event/real/C,dob/be_named/B/Tyholt/C,doit/be1/B/D,srel/in/place/A/D,event/real/D)
    with       (which(A),Tyholt isa station,B isa station,A isa place,event/real/C,
    doit/lie1/Tyholt/D,srel/in/place/A/D,event/real/D)
id  []
ip  [].




%%%%%%%%  SMALLTALK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Statements that obviously challenge the system

life42 rule %% What is the meaning of life
is  which(A),(has/life/meaning/B/A,A isa meaning,B isa life)
id  add message(answer(bcp(42)))
ip  [].

life43 rule
is  which(A),(has/life/meaning/B/A,A isa meaning,B isa liff)
id  add message(answer(bcp(43)))
ip  [].

life421 rule
is  not explain,
    srel/_/_Thing/L/_E, _M isa meaning, L isa life, %% TA-101013
    clear
id  clear,
    add flag(exit),
    add message(answer(bcp(42)))
ip  [].

life422 rule
is  test,42 isa meaning,F1 isa life,doit/be1/42/F2,event/real/F2,
    srel/pwith/thing/F1/F2
id  add true
ip  [].

life423 rule
is  test, has/life/meaning/B/A, A isa meaning, B isa life
id  add message(answer(bcp(42))),
    add flag(exit)
ip  [].


whatis1 rule  %%  what is D means describe D
is  exactly (which(X),X isa Y, event/real/_)
id  add message(answer((bcpbc(D))))
ip  \+ main:myflags(teleflag,true),
    bound(X), X \== it,
    \+ dmeq([answer,clock, departure, self, time],Y),
    description(X,D). %% NB X (?)


whatis2 rule  %% hvem er (det som er) tagore:... X er tagore
is  which(A),A isa agent,dob/be/A/X/B,X isa D,event/real/B
id  add message(answer(bcpbc(D))),
    add flag(exit)
ip  \+ main:myflags(teleflag,true),
    bound(X),
    X \== it, X \== tuc,
    \+ dmeq([answer,clock,departure,self,time],D).

whatis2b rule  %% hvem er tagore:.. tagore er X %% TA-101230
is  which(A),A isa agent,dob/be/X/A/B,X isa D,event/real/B
id  add message(answer(bcpbc(D))),
    add flag(exit)
ip  \+ main:myflags(teleflag,true),
    bound(X),
    X \== it, X \== tuc,
    \+ dmeq([answer,clock,departure,self,time],D).

whoareyou0 rule %% hvem er du
is  which(A),(dob/be/tuc/A/B,tuc isa savant,A isa Agent,event/real/B),
    {subclass0(Agent,agent)}, %% TA-110615
    clear
id  clear,
    add(message(answer((bcpbc(bustuc))))),
    add flag(exit)
ip  TUC \== bustuc, dmeq(tuc,TUC).


whoareyou1 rule %% hvem er du
is  which(TUC),(tuc isa savant,event/real/_),
    clear
id  clear,
    add(message(answer((bcpbc(bustuc))))),
    add flag(exit)
ip  TUC \== bustuc, dmeq(tuc,TUC).

whoareyou2 rule %% hva er ditt navn
is  has/agent/name/B/A,B isa savant,A isa name, %% TA-110609
    clear
id  clear,
    add(message(answer( bcpbc(bustuc) ))),
    add flag(exit)
ip  [].

whoareyou3 rule
is  not explain, %% which(A), %% heter du tore
    (dob/be_named/tuc/_A/_),
    clear
id  clear,
    add(message(answer(bcpbc(bustuc)))),
    add flag(exit)
ip  [].

whoareyou3b rule %% hva kalles du
is  not explain, %% which(A), %% heter du tore
    (dob/name/_/tuc/_),
    clear
id  clear,
    add(message(answer(bcpbc(bustuc)))),
    add flag(exit)
ip  [].


whoareyou4 rule
is  which(tuc),(tuc isa savant,event/real/_),
    clear
id  clear,
    add(message(answer(bcpbc(bustuc)))),
    add flag(exit)
ip  [].    %% Special because 'tuc isa savant'
           %% is a truncated doublette

whoareyou5 rule
is  which(A),(A isa Oracle,event/real/_),
    {dmeq([oracle,service],Oracle)},
    clear
id  clear,
    add(message(answer(bcpbc(bustuc)))),
    add flag(exit)
ip  [].

whoareyou7 rule %% repair  which agent is you
is   which(A), BT isa program,A isa agent,event/real/B,dob/be/A/BT/B,
     clear
id   clear,
     add message(answer(bcpbc(bustuc))),
     add flag(exit)
ip   dmeq([bustuc,busstuc,tuc,smstuc],BT).


whatisnamed1  rule %%   Hva heter Tagore -> Tagore % after whoareyou
is  which(A),dob/be_named/A/B/_C, { atom(B)} %% bound(B)}
id  add reply(B)
ip  [].

whatisnamed2  rule %%   Hva heter du ???
is  which(A),dob/be_named/B/A/_C, { atom(B)}, %% { bound(B)},
    not _ isa self
id  add reply(B)
ip  [].

whatisyourname  rule %%  hva er ditt navn
is  which(X),X isa name,tuc isa savant,has/agent/name/tuc/X
id  add message(answer(bcpbc(bustuc)))
ip  [].

isbustucyourname  rule %%  er busstuc ditt navn ?
is  test,X isa name,tuc isa savant,has/agent/name/tuc/X
id  add message(answer(bcpbc(bustuc)))
ip  [].


whoareyou rule  %% Who are you
is  which(A),
    Marvin isa Robot, {dmeq([tuc,bustuc],Marvin)},
    A isa agent,
    event/real/B,dob/be/A/Marvin/B,
    not ispresent has/_Agent/_Leader/_Tuc/_ %% hvem er din sjef  *-> leder
id  add message(answer(bcpbc(bustuc)))
ip  bound(Marvin), %% hvem er konge -> Konge ***
    \+ main:myflags(teleflag,true),
    \+ dmeq([self,creator,programmer,person],Robot). %% "selv"

whois1 rule  %%  who  is D (which agent is such that A is D)
is  which(A),Marvin isa Robot,A isa agent,event/real/B,dob/be/A/Marvin/B,
    not ispresent has/_Agent/_Leader/_Tuc/_ %% hvem er din sjef  *-> leder
id  add message(answer((bcpbc(Robot))))
ip  bound(Marvin), %% hvem er konge -> Konge ***
    \+ main:myflags(teleflag,true),
    \+ dmeq([self,creator,programmer,person],Robot). %% "selv"


eat rule %% allowed to eat on bus :-)
is  eat/_/_/_ ,
    clear
id  clear,
    addfront(message(nofoodonbus)),
    add flag(exit)
ip  [].


noinfoaboutstrike rule
is  strike/_/_
id  clear,
    addfront(message(noinfoabout(strike)))
ip  [].


noinfoaboutgenerics rule %% sunndalsøra helsestasjon
is  X isa place, {generic_place(X)},
    clear
id  clear,
    addfront(message(noinfoaboutname(X)))
ip  [].


summerwinter rule %%  hvor lenge gjelder bussrutene?
is   A isa duration,B isa route,doit/apply/B/C,srel/pwith/duration/A/C,event/real/C
id  addfront(message(summerishere)),
    addfront(message(winterishere))
ip  [].

summer1 rule %%  sommeruter til A %% after weather
is   replaceall (X isa summerroute)
     with       (X isa route)
     ,clear %% dont give todays route
id   addfront(message(summerishere))
ip  [].

summer2 rule %% om sommeren
is  _ isa summer ,clear %% dont give todays route
id                clear,
    addfront(message(summerishere))
ip  [].


winter1 rule  %% when is winterroutes
is   replaceall (X isa winterroute)
     with       (X isa route)
 %%%    ,    clear    %% ?
id   addfront(message(winterishere))
ip  [].


winter2 rule  %% %% when is winter
is  _ isa winter,clear
id   not flag(exit), %% snø i vinter
     clear,addfront(message(winterishere))
ip  [].


whereis rule %% hvorfor finnes busstuc
is  explain,Bustuc isa savant,doit/be1/Bustuc/E,event/real/E
id  add  message(howtuchelp)
ip  dmeq(tuc,Bustuc).


whyareyouhere rule %% hvorfor er du her ?
is  explain,doit/be1/tuc/A, srel/HOME/PLACE/nil/A %% why are you here
id  addfront message(howtuchelp)
ip  dmeq(where,HOME),dmeq([place],PLACE).

whyareyoumade rule %% why are you made ?
is  explain,adj/_/make/tuc/_
id  addfront message(howtuchelp)
ip  [].


maker rule  %% hvem er din skaper
is  which(A),A isa programmer,tuc isa savant, _ isa agent,has/agent/agent/tuc/A,
    clear  %% not negans
id  add (message(tagore),
         flag(exit))
ip  [].


responsible rule  %% hvem er ansvarlig for deg ? %% TA-110120
is  which(A),A isa agent,Tuc isa savant, adj/nil/responsible/A/E,srel/for/thing/Tuc/E
id  add message(tagore)
ip  dmeq([tuc,bustuc,it],Tuc).


made1 rule  %% når ble du/dette laget
is  which(T),T isa time, dob/make/_/Tuc/_ ,
    clear  %% not negans
id  add message(idonotknow)
ip  dmeq([tuc,bustuc,it],Tuc).


made2 rule  %% hvem laget deg/dette
is  which(_), %% hvem er du laget av %% TA-110128
    dob/Make/A/Tuc/_ , {dmeq([make,write],Make)},
    A isa Agent,                 {dmeq([agent,person],Agent)},
    not _ isa day, %% etc  :-)
    not ispresent srel/_/day/nil/_,
    clear %% not negans
id  add (message(tagore),
         flag(exit))
ip  dmeq([tuc,busstuc,bustuc,it],Tuc).


madenoun1 rule %% hvem laget deg
is  which(A),
    A isa agent, dob/make/A/Tuc/_, Tuc isa Oracle,
    not _ isa day, %% etc  :-)
    not ispresent srel/_/day/nil/_,
    not srel/nil/coevent/_/_ ,
    not srel/in/_/_/_
id  add message(tagore)
ip  dmeq([program,oracle,service],Oracle).


madenoun2 rule %% laget T deg ?
is  test,
    dob/make/A/Tuc/_,  A isa Agent,Tuc isa Oracle,
    not _ isa day, %% etc  :-)
    not srel/nil/coevent/_/_ ,
    not srel/in/_/_/_ ,
    not srel/on/_/_/_ , %% etc
    not srel/_/day/nil/_
id  add message(tagore)
ip  subclass0(Agent,agent),
    dmeq([program,oracle,service,savant],Oracle).


made3 rule % hvem er du laget av
is  A isa agent,adj/_/make/Tuc/_, Tuc isa Oracle,     %% made as Adj
    srel/by/agent/A/_ ,
    not srel/nil/coevent/_/_,
    not srel/in/_/_/_
id  add message(tagore)
ip  dmeq([program,oracle,service],Oracle).


purp rule %% meningen med deg %% TA-110607
is  _ isa purpose,srel/of/thing/_Tuc/_
id  addfront message(howtuchelp)
ip  [].


meaning rule
is  has/agent/Meaning/tuc/_, {dmeq([meaning,purpose],Meaning)} %% TA-110606
id  addfront message(howtuchelp)
ip  [].

it1 rule %% Hva er dette ?
is  exactly (which(it),true)
id  addfront message(howtuchelp)
ip  [].

whytuc rule
is  explain,doit/be1/tuc/_   %% why are you here
id  addfront message(howtuchelp)
ip  [].

work1 rule
is  which(A),(tuc isa savant,work/tuc/B,srel/pwith/thing/A/B)
id  addfront message(howtuchelp)
ip  [].


thanks1 rule %% Acknowledge praise
is  (A isa self,adj/_/impressed/A/_)
id  add message(answer((bcpbc(thanks))))
ip  [].


%%%%%END OF SMALLTALK%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


stationonneib0 rule %% fra holdeplassen på Gløshaugen %% TA-100910
is  replaceall (srel/From/place/F2/F4,srel/on/neighbourhood/Gløshaugen/F4)
    with       (srel/From/place/Gløshaugen/F4),
        {unbound(F2)}
id  []
ip  [].


stationonneib rule %%  holdeplassen på Risvollan=Risvollan
is  ispresent Risvollan isa neighbourhood ,
    replaceall (srel/Prep/place/B/E, nrel/ONAT/station/_Neib_/B/Risvollan)
    with        srel/Prep/place/Risvollan/E
id  []
ip  dmeq([on,at,near,in],ONAT).




stationoneigh0 rule %%  til  Markaplassen ved Vikåsen (neib)
is  ispresent srel/to/place/M/E,  %%  Haz ? not nil
    M isa station,
    V isa neighbourhood,
    remove  srel/at/place/V/E %% university at gløshaugen
id  []
ip  [].

stationoneigh2 rule %% station on neighbourhood is a special case ( touchy)
is  replaceall ( srel/on/neighbourhood/lade/B )
    with       ( srel/near/place/lade/B )
id  []
ip  [].


stationonstat rule %% Markaplassen på Vikåsen (stat)
is  ispresent srel/to/place/M/E,
    M isa station,
    V isa station,
    remove  srel/on/place/V/E
id  []
ip  userNOTME: V isa neighbourhood. %% also %

% % % % % % % PART OF DAY RULES

midday rule
is  replaceall (B isa day, srel/around/time/B/E)
    with       (srel/around/time/1200/E)
id  []
ip  [].


daypart rule
is  replaceall (has/daypart/bus/B/C,  B isa evening)
    with       (srel/tonight/time/nil/C)
id  []
ip  [].


night18 rule % bus sunday night MEANS bus after at the proper time
is  replaceall (B isa night, srel/nil/time/B/E)
    with       (srel/after/time/1800/E)
id  []
ip  [].

nesteomkvelden rule  %% neste buss i kveld, gitt atklokken er > 1800
is  replaceall (C isa night,srel/ON/Night/C/E)
    with       (T2300 isa clock,srel/after/time/T2300/E),
    { dmeq([about,on,in],ON),
      dmeq([night,daypart],Night)},
    not  ispresent srel/before/time/_/E   %% not squeeze it
id  not flag(nightbusflag)
ip  timenow(T2300), T2300 > 1800
:-single.

omkvelden1 rule  %% Hva er busstidene på kvelden
is  not TI isa clock when { bound(TI)}, %% kl 1955 om kvelden
    replaceall (C isa night,srel/ON/Night/C/E)
    with       (1800 isa clock,srel/after/time/1800/E),
    { dmeq([about,on,in],ON),
      dmeq([night,daypart],Night)},
    not  ispresent srel/before/time/_/E   %% not squeeze it
id  not flag(nightbusflag)
ip  []
:-single.

omkvelden2 rule  %% Hva er busstidene på kvelden
is  not ispresent adj/_/last/_/_,
    not K isa clock when {bound(K)},
    replaceall (C isa night,srel/OM/daypart/C/E)
    with       (1800 isa clock,srel/after/time/1800/E),
    not  ispresent srel/before/time/_/E   %% not squeeze it
id  []
ip  dmeq([about,on],OM)
:-single.

evening17 rule
is  replaceall (B isa evening, srel/nil/daypart/B/E)
    with       (srel/after/time/1700/E),
    not         srel/before/time/_/E   %% not squeeze it
id  []
ip  [].


evening1720 rule %% Tuesday evening MEANS Tuesday between 1700 and 2000
is  replaceall (C isa evening,srel/nil/daypart/C/E)
    with       (srel/after/time/1700/E,srel/before/time/2000/E)
id  []
ip  [].


aftermorning rule %% bus goes om morgen -> after morning
is  not ispresent _ isa nightbus,
    not ispresent  srel/early/_Time/nil/_, %%  then explicit //time/daypart
    not ispresent  adj/_/early/_/_,
    replaceall (B isa morning ,srel/after/time/B/E)
    with       (srel/after/time/0430/E),
    not  _ isa clock %% if clock is mentioned, morning is just redundant
id  not flag(earlytime), %% then already set
    add flag(earlytime)  %%
ip  [].


noon rule
is  replaceall (B isa noon, srel/nil/daypart/B/E)
    with       (srel/after/time/1200/E)
id  []
ip  [].


prenoon0 rule %% Assume time is already adjusted for evening time
is  not ispresent srel/_Prep/time/C/_ when { number(C)},
    replaceall (B isa prenoon, srel/nil/daypart/B/E)
    with       (1200 isa clock,srel/before/time/1200/E)
id  []
ip  [].


afternoon0 rule  %% Assume time is already adjusted for evening time
is  not ispresent srel/_Prep/time/C/_ when { number(C)},
    replaceall (B isa afternoon, srel/nil/daypart/B/E)
    with       (1200 isa clock,srel/after/time/1200/E)
id  []
ip  [].


rush rule % i rushtiden betyr mellom 1530 og 1730 ? Rough
is  replaceall (R isa rush_hour,srel/in/time/R/E) %% verb modifier
    with       (1530 isa clock, 1730 isa clock,
                 srel/after/time/1530/E, srel/before/time/1730/E)
id  []
ip  [].


innight1 rule
is  not ispresent (_ isa clock),
    not  ispresent srel/_/clock/_/_ ,
    replaceall (srel/in_night/time/nil/E)
    with       (1800 isa clock,srel/after/time/1800/E)
id  []
ip  [].

twelvemidnight rule % natten  MEANS etter 2400
is  replaceall (srel/in_midnight/time/nil/E,srel/After/time/Twelve/E)
    with       (srel/After/time/Twentyfour/E),
    not ispresent srel/before/time/_/_   %% probably an early morning time
id  []
ip  before(6,Twelve),before(Twelve,1300),
    Twentyfour is Twelve+1200.

inattbuss1 rule
is  srel/in_midnight/time/nil/_
id  addcon flag(nightbusflag)
ip  userNOTME: set(nightbusflag,true).

inattbuss2 rule
is  srel/this_midnight/time/nil/_
id  addcon flag(nightbusflag)
ip  userNOTME: set(nightbusflag,true).


inatt rule %% catch
is  replaceall (srel/in_midnight/time/nil/E)
    with       (2400 isa clock,srel/after/time/2400/E),
    not ispresent srel/before/time/_/_   %% probably an early morning time
id  addcon flag(nightbusflag)
ip  [].



paanatt rule
is  replaceall (X isa midnight,srel/on/_Time/X/E)
    with       (2400 isa clock,srel/after/time/2400/E)
id  not flag(nightbusflag)
ip  [].


umpdaynatt rule  %% Saturday night means Sunday
is  context C isa midnight,
    replaceall (B isa Saturday, has/day/midnight/B/C, srel/nil/daypart/D/E)
    with       (D isa Sunday, srel/nil/daypart/D/E)
id  []
ip  daysucc(Saturday,Sunday).


prepnatt rule
is  replaceall (C isa midnight, srel/PREP/time/C/E )
    with       (2400 isa time,  srel/PREP/time/2400/E)
id  not flag(nightbusflag)
ip  dmeq(timeprep,PREP).


middag12 rule
is  replaceall (C isa noon, srel/PREP/time/C/E )
    with       (1200 isa time,  srel/PREP/time/1200/E)
id  []
ip  dmeq(timeprep,PREP).


midnight024 rule
is  replaceall (0 isa clock,srel/before/X/0/E)
    with       (2400 isa clock, srel/before/X/2400/E)
id  []
ip  [].


% % % % % % % % % % % % % % % % % % %

%% a bus connects a place with a place MEANS ...  connect

connectwith1 rule
is  context B52 isa bus,
    replaceall  (connect/B52/A/E, event/real/E, srel/pwith/PLACE/B/E)
    with        (doit/go/B52 /E, event/real/E, srel/from/place/A/E, srel/to/place/B/E)
id  []
ip  dmeq(place,PLACE).


endplace rule %% end stop   END station  rules
is  replaceall (S isa PLACE,adj/_/end/S/_)
    with       (S isa endstation)
id  []
ip  dmeq(place,PLACE).

%% RS-111118
%bepresentat rule % be ispresent at means go to
%is  replaceall (adj/_/presentat/IBus/E, srel/At/place/U/E) %%%% RS-111118 Present is reserved word
%    with       (doit/go/IBus/E,srel/to/place/U/E),
%        {dmeq([at,to],At)} %% framme til
%id  []
%ip  [].


benextgoafter rule % be next after
is  ispresent  adj/_/next/_/_ , %% next CLOCK means next after CLOCK
    replaceall (VEH isa BV,doit/be1/VEH/E,srel/nil/time/T0/E)
    with       (VEH isa BV,doit/go/VEH/E,srel/after/time/T0/E)
id  []
ip  dmeq(busdeparr,BV).  %% not to  destroy "which departures are"



begofore1 rule % be nil = before
is  context (doit/go/VEH/E, VEH isa BV),
    replaceall ( doit/be1/VEH/F, srel/BEFORE/time/T0/F)
    with       ( srel/before/time/T0/E)
id  []
ip  dmeq(beforenil,BEFORE) ,
    dmeq(busdeparr,BV).  %% not to  destroy "which departures are"



fromandbeon rule %% from StikV and be on StSf -> to StSf
is  ispresent srel/from/place/_StikV/E,
    replaceall (doit/be1/_/_,srel/on/place/StSf/E)
    with       (srel/to/place/StSf/E)
id  []
ip  [].



bego rule % be go  = be
is  context  (doit/go/VEH/_E, VEH isa BV), { dmeq(busdeparr,BV)},
    removeall ( doit/be1/VEH/_F)
id  []
ip  [].



startfromp rule %% A bus Starts from P MEANS  The bus has end station at P
is  replaceall  (B52 isa Bus, doit/start/B52/B,srel/from/place/A/B,A isa place)
    with        (B52 isa Bus,has/_/endstation/B52/A,A isa endstation)
id  []
ip  dmeq(vehicle,Bus).


%% A bus Starts at P MEANS  The bus has end station at P

startatp rule
is  replaceall  (doit/start/B52/B,B52 isa Bus,srel/in/place/A/B)
    with        (B52 isa Bus,has/vehicle/endstation/B52/A)
id  []
ip  dmeq(vehicle,Bus).

endsinp rule
is  replaceall  (end/B52/B,B52 isa Bus,srel/in/place/A/B)
    with        (B52 isa Bus,has/vehicle/endstation/B52/A)
id  []
ip  dmeq(vehicle,Bus).

%% This is a specialised rule: change  the 'at times' to either
%  before or after, depending on whether the station is from or to.

fromplaceattoplaceatt rule %  from dragvoll at 1200  to risvollan at 1300
is replaceall (srel/from/place/Dragvoll/E1,srel/ATTIME1/time/T1200/E1,
               srel/ONTO/place/Risvollan/E2,srel/ATTIME2/time/T1300/E2)
   with       (srel/from/place/Dragvoll/E1,srel/after/time/T1200/E1,
               srel/to/place/Risvollan/E2,srel/before/time/T1300/E2)

id []
ip dmeq(by,ONTO),dmeq(attime,ATTIME1),dmeq(attime,ATTIME2).


someonetake rule %%  after inorder1
is  replaceall (B isa person,  C isa BR, dob/Take/B/C/D)
    with       (C isa BR, doit/go/C/D)
id  []
ip  dmeq([take,reach,get,receive,find],Take),
    dmeq(vehicle,BR). %% not meeting  reach meeting \= reach train


%% RS-111118
%withouttaking1 rule %%  uten å ta buss 9 =  ta  buss  \=  buss 9
%is  ispresent B9 isa bus,{bound(B9)}, %% avoid reshuffeling B9 isa bus
%    replaceall  (srel/not/coevent/_A/C, dob/Take/I/B9/C) %% C is abanded
%    with        (dob/avoid/I/B9/C),
%        {dmeq([take,use],Take)}
%id  []
%ip  [].
%

idotake rule %%   I take Bus -> Bus goes  %% Experiment
is  replaceall (B isa self,  C isa BR, dob/Take/B/C/D) %% New Format
    with       (C isa BR, doit/go/C/D)
id  []
ip  dmeq([take,get,find,have],Take), %% NOT reach, NOT receive (= få se)
    dmeq(vehicle,BR). %% not meeting  reach meeting \= reach train


onecantake rule
is  replaceall (B isa agent, C isa BR, dob/Take/B/C/D)
    with       (C isa BR, doit/go/C/D)
id  []
ip  dmeq([take,reach,get,receive,find],Take),
    dmeq(vehicle,BR). %% not meeting  reach meeting \= reach train

youcantake rule
is  replaceall (B isa program , dob/take/B/C/D, C isa BR)
    with       (C isa BR, doit/go/C/D)
id  []
ip  dmeq(vehicle,BR). %% not meeting  reach meeting \= reach train



atbhave1 rule %% which X does TT have  MEANS  which X  %% tt-> atb %% TA-110121
is replaceall (atb isa company,has/_Company/Bus/atb/A,event/real/E)
   with       (doit/be1/A/E,event/real/E)
id []
ip dmeq(vehicle,Bus).



%% will tuc let me see IT  MEANS what is IT

caniseeit rule
is  replaceall (test,tuc isa savant,let/myid/that/tuc/A/B,event/real/B,
               C isa self,dob/see/C/D/E,event/A/E)
    with       (which(D))
id  []
ip  [].


letmeseeit rule %%  let me see IT  MEANS what is IT
is replaceall (doit,tuc isa savant,let/myid/that/tuc/A/B,event/real/B,
               C isa self,dob/see/C/D/E,event/A/E)
   with       (which(D))

id []
ip [].


%% full list MEANS list   list ===> information ...

fullham rule
is replaceall (B isa information,adj/_/whole/B/_)
   with       (B isa information)
id []
ip [].


listinformation1 rule %% Kan jeg få listet
is  replaceall  (test, B52 isa route,A isa self,dob/list/A/B52/B,event/real/B)
    with        (doit,   B52 isa route,tuc isa savant,dob/list/tuc/B52/B,event/real/B)
id  []
ip  [].


listinformation2 rule
is  replaceall ( F53 isa Information, doit/be1/F53/E,
                 srel/OVER/thing/F52/E,event/real/E,
                 dob/LIST/_Tuc/F53/F54)
    with       ( dob/list/tuc/F52/F54)
id  []
ip  dmeq(list,LIST),dmeq(information,Information),dmeq(about,OVER).


listinformation3 rule %%   What is information about
is  replaceall ( which(F53),F53 isa Information, doit/be1/F53/E,
                 srel/OVER/thing/F52/E,event/real/_E)
    with       ( doit,dob/list/tuc/F52/F54,event/real/F54)
id  []
ip  dmeq(information,Information),dmeq(about,OVER),newfree(F54).


knowinformation rule %%  Have you  information about
is  replaceall ( F53 isa Information, has/agent/information/_I/F53,
                 srel/OVER/thing/F52/E,event/real/E)
    with       ( dob/know/tuc/F52/F54,event/real/F54)
id  []
ip  unbound(F52),
    dmeq(information,Information),dmeq(about,OVER),newfree(F54).


info1 rule %% about a Boo
is  replaceall (which(A),A isa information,
                         srel/ABOUT/thing/F/E, F isa Boo,doit/be1/A/E)
    with       (doit,tuc isa savant, dob/describe/tuc/Boo/E,event/real/E)
id []
ip dmeq(about,ABOUT),
   \+ dmeq(vehicle,Boo).


info1E rule %% whether  Boo exists
is  replaceall (which(A),A isa information,doit/exist/A/_,
                         srel/ABOUT/thing/F/E, F isa Boo,doit/be1/A/E)
    with       (doit,tuc isa savant, dob/describe/tuc/Boo/E,event/real/E)
id  []
ip  dmeq(about,ABOUT),
    \+ dmeq(vehicle,Boo).

info2 rule %% about Boo  [exists]
is  replaceall (which(A),A isa information,
                          doit/be1/A/E,srel/ABOUT/thing/Boo/E)
    with       (doit,tuc isa savant, dob/describe/tuc/Boo/E,event/real/E)
id  []
ip  dmeq(about,ABOUT),bound(Boo),
    \+ dmeq(vehicle,Boo).

infobus rule  %% This is a default rule  nrel -> srel
is  replaceall (which(A),A isa information,F isa bus,
                          doit/be1/A/E,srel/ABOUT/thing/F/E)
    with       (which(A),A isa route,F isa bus,
                          doit/be1/A/E,srel/for/bus/F/E)
id  []
ip  dmeq(about,ABOUT).


%% shall be in MEANS shall (go) to  IF there is a from

shallbeinfrom rule
is  context    (srel/from/place/Moholt/E1,event/real/E1),
    replaceall (srel/in/place/Sentrum/E2,srel/AT/time/Time/E2)
    with       (srel/to/place/Sentrum/E2,srel/before/time/Time/E2)
id  []
ip  dmeq([at,in],AT), %% dmeq(attime,AT)
                  %% når er buss nr 9 som gikk fra sentrum 1745 i john aaes vei.
    \+ (Moholt = Sentrum).


%% to  place at clock MEANS to place before time  %% (before fromattime)

thereattime rule %% jeg skal være der
is  context   Time isa clock,
    replaceall (srel/in/place/Sentrum/E2,srel/AT/time/Time/E2)
    with       (srel/to/place/Sentrum/E2,srel/before/time/Time/E2)
id  []
ip  dmeq([at,in],AT).
                      %% når er buss nr 9 som gikk fra sentrum 1745 i john aaes vei.


toattime rule
is  context   Time isa clock,
    replaceall (srel/to/place/Sentrum/E2,srel/AT/time/Time/E2)
    with       (srel/to/place/Sentrum/E2,srel/before/time/Time/E2),
    not doit/meetup/'I'/E2
id  []
ip  dmeq(attime,AT).




%% from place at clock MEANS from place after time
%%  NB  but only the first after !!!

fromattime rule
is  context   Time isa clock,
    not ispresent srel/around/time/_/_,
    replaceall (srel/from/place/Sentrum/E2,srel/AT/time/Time/E2)
    with       (srel/from/place/Sentrum/E2,srel/after/time/Time/E2),
    not      srel/to/place/_/E2,
    not      ispresent srel/on/place/_/E2,      %% and be on
    not      ispresent doit/pass/_/_       %% etc ad nauseam
id  []
ip  dmeq(attime,AT).


%% give me that MEANS give

gimmethat rule %% sjow me the buses
is replaceall (I isa self,srel/to/agent/I/E, dob/SHOW/_Tuc/X/E) %% Give/tuc De = de = du = tuc
   with       (dob/show/tuc/X/E)                             %%
id []
ip dmeq(show,SHOW).


infoofthat rule
is replaceall ( which(L),L isa Info, doit/be1/L/E,srel/Over/X/E)
   with         which(X)
id []
ip dmeq(about,Over),dmeq(information,Info).


clinton rule %% vite (hva) om noe
is  replaceall (which(A),tuc isa savant,dob/know/tuc/A/C,srel/regarding/thing/B/C)
    with       (which(B))
id  []
ip  [].


starr rule    %%  vet du noe om % hva vet du om  MEANS what is
is replaceall    ( test,tuc isa savant,
                   dob/KNOW1/tuc/_A/B,  %% Normal %% Wrong code here ? know (thing)( about B)
                   event/real/B,srel/regarding/thing/X/B) %% about
    with      (which(X)),
    {dmeq([know,know1],KNOW1)}
id []
ip [].


% jeg vil vite noe om  MEANS what is
% kan jeg få opplysninger om  MEANS what is


canigetinfo rule % the route of the route (bus) %% PANIC
is  replaceall ( which(R),has/bus/route/B48/R, B48 isa route,R isa route,event/real/E)
    with       ( which(F0), B48 isa route,doit/stop/B48/E,
                 srel/in/place/F0/E,event/real/E)
id  []
ip  newfree(F0).


% I want to see MEANS see

wannasee rule
is replaceall (new,A isa self,dob/want/A/B/C,B isa coevent,event/B/E, event/real/C,dob/See/A/D/E,D isa X)
   with       (doit,tuc isa savant,dob/list/tuc/D/E,  D isa X,event/real/E)
id []
ip dmeq([see,receive],See),
   dmeq([bus,nightbus,route,route_plan],X).

isee rule
is  replaceall  (new,A isa self,dob/SEE/A/B/C ,  B isa X )
    with        (doit,tuc isa savant,dob/list/tuc/B/C,  B isa X )
id  []
ip  dmeq(see,SEE),
    dmeq([bus,nightbus,route,route_plan],X).


canigetbus rule
is  replaceall  (A isa self,dob/GET/A/B/E,B isa X)
    with        (doit/go/B/E, B isa X)
id  []
ip  dmeq([get,receive],GET),
    dmeq([bus,nightbus,route,route_plan,departure],X).


givemeabus rule
is  replaceall  (dob/give/tuc/B/E,B isa X)
    with        (doit/go/B/E, B isa X)
id  []
ip  dmeq([bus,nightbus,route,route_plan,departure],X).



%% Jeg  ønsker en lørdagsrute ==> "Bussrute" ###


% I want  MEANS what is

iwant rule
is  replaceall (new, B isa self, dob/want/B/A/D,A isa Thing,event/real/D)
    with       (doit,  tuc isa savant,A isa Thing,dob/list/tuc/A/D,event/real/D),
    not (A isa help)  %% i want help
id  []
ip  \+dmeq([information,money],Thing),
    unbound(A).  %% I want you *



listallstat rule  %% list all stations MEANS what is a station ?
is replaceall (doit,tuc isa savant, dob/LIST/tuc/S52/X, S52 isa Station,event/real/X)
   with       (which(S52),S52 isa Station)
id []
ip dmeq(list,LIST),
   dmeq([station,arrival,price],Station). %% stopp = arrival




%% Trondheim rules

trondheim1 rule
is  removeall   (Trondheim isa city,nrel/_/_Bus/CP/_/Trondheim)
id  []
ip  dmeq([city,place],CP),
    home_town(Trondheim).


trondheim3 rule
is removeall (Trondheim isa city, srel/in/_/Trondheim/_ ) %% in/for
id []
ip \+ main:myflags(teleflag,true),
   home_town(Trondheim).

trondheim3n rule
is removeall (Trondheim isa neighbourhood, srel/in/_/Trondheim/_ ) %% in/for
id []
ip \+ main:myflags(teleflag,true),
   home_town(Trondheim).



trondheim4 rule
is removeall (Trondheim isa city, srel/for/_/Trondheim/_ ) %% in/for
id []
ip home_town(Trondheim).

trondheim5 rule
is removeall (Trondheim isa city, has/city/route/Trondheim/_)
id []
ip home_town(Trondheim).

trondheim5 rule
is removeall (byen isa neighbourhood, srel/in/neighbourhood/byen/_)
id []
ip [].



%% .....

%% directroute  MEANS  direct route

directroute rule
is replaceall (X isa directroute)
   with       (X isa route, adj/_/direct/X/_)
id []
ip [].


isatimefor rule
is  context (A isa time,B52 isa bus,event/real/B),
    replaceall (doit/be1/A/B,srel/for/vehicle/B52/B)
    with       (has/vehicle/departure/B52/A)
id  []
ip  [].

colour0 rule %% colour |  bus
is  _ isa colour,
    ispresent _Bus isa BR, {dmeq(vehicle,BR)}
id	 addcon message(irrelevant(colour(bus))),
    add flag(exit)
ip	 [].

colour2 rule
is  ispresent Bus isa BR,adj/_/Colour/Bus/_
id	 addcon message(irrelevant(colour(bus))),
    add flag(exit)
ip  dmeq(colour,Colour),dmeq(vehicle,BR).


speed2 rule
is  has/_/speed/_/__ isa speed
id	 addcon  message(noinfoabout(speed))
ip  [].

distance rule
is  srel/pwith/distance/_/_
id	 addcon  message(noinfoabout(distance))
ip  [].


% Vis bussavganger for rute  5 MEANS vis bussavgangene til rute 5
% which route does bus 9 have MEANS which places does bus 9 pass
%% bus between A and B MEANS bus from A to B
%% (go) between A and B MEANS (go) from A to B

betweenplace rule %% (go) between TimeA and TimeB MEANS go after TimeA before TimeB
is  replaceall (srel/BETWEEN/place/(P1,P2)/E)
    with       (srel/from/place/P1/E, srel/to/place/P2/E)
id  []
ip  dmeq(between,BETWEEN). % dmeq(bepass,PASS)


betweentime0 rule
is  replaceall (T2 isa clock,srel/BETWEEN/Time/(T1,T2)/E)
    with       (T3 isa clock,srel/after/time/T1/E, srel/before/time/T3/E)
id  []
ip  dmeq([between,around,in],BETWEEN),
    dmeq(timeclock,Time), number(T2), number(T1),
    T2 < T1, T2 < 430, %% mellom 12 og 2
    evening_time(T2,T3).


betweentime rule
is  replaceall (srel/BETWEEN/Time/(T1,T2)/E)
    with       (srel/after/time/T11/E, srel/before/time/T22/E)
id  []
ip  dmeq([between,around,in],BETWEEN),
    dmeq(timeclock,Time),
    sorttimes(T1,T2,T11,T22).


afternow rule
is  replaceall (srel/after/time/now/E)
    with       (srel/hereafter/time/nil/E)
id  []
ip  [].



cancel rule
is  cancel/_/_/_
id  addcon(message(noinfoabout(irregularity)))
ip  [].


waitdelay rule
is  doit/wait/'I'/_,clear %%   SMS  >160
id  clear, addcon(message(noinfoabout(delays)))
ip  [].


delay3 rule
is  adj/_/Delayed/_/_,
    {dmeq([delayed], Delayed)}, %% TA-100923  Hazard  sen = forsinket
    clear %%   SMS  >160
id  clear, addcon(message(noinfoabout(delays)))
ip  [].


delay4 rule %% come delayed
is  srel/delayed/time/nil/_,clear
id  clear, addcon(message(noinfoabout(delays)))
ip  [].

delay5 rule
is  _ isa delay
id  addcon(message(noinfoabout(delays)))
ip  [].

delay6a rule %% are routes precise/punctual
is  adj/_/precise/_/_,clear %%   SMS  >160
id  clear, addcon(message(noinfoabout(delays)))
ip  [].

delay6b rule
is  adj/_/punctual/_/_
id  addcon(message(noinfoabout(delays))),
    add flag(exit)
ip  [].


%% pass P between TimeA MEANS pass P around TimeA

betweenwhat1 rule
is  context doit/pass/_/E,
    replaceall (srel/between/time/T1/E)
    with       (srel/after/time/T1/E) %% single between,
id  []
ip  [].

betweenwhat2 rule
is  context doit/go/_/E,
    replaceall (srel/between/time/T1/E)
    with       (srel/after/time/T1/E) %% single between,  (between 1330 to 1600) %% around
id  []
ip  [].


yourbuses rule %% your buses
is  dob/be/_/Bus/_, has/agent/_/Tuc/Bus,
        {dmeq([tuc,tt,'I'],Tuc),unbound(Bus)},
    Bus isa  BR,  {dmeq([bus,nightbus,tram,car,route],BR)},
    not ispresent _ isa station,
    not ispresent _ isa neighbourhood,
    not _ isa time
id  not flag(exit),
    %% clear
    add listofall(BR,_)
ip  [].


busesattt rule %% your buses
is  doit/exist/Bus/F10,srel/at/_/Tuc/F10,  {dmeq([tuc,tt],Tuc),unbound(Bus)},
    Bus isa  BR,  {dmeq([bus,nightbus,tram,car,route],BR)},
    not ispresent _ isa station,
    not ispresent _ isa neighbourhood,
    not _ isa time
id  not flag(exit),
    %% clear
    add listofall(BR,_)
ip  [].

tuchasabus1 rule   %% tuc has a bus MEANS there exists a bus
is  context (A isa BR1),
    removeall (tuc isa savant,has/agent/BR2/tuc/A)
id  []
ip  dmeq(bus,BR1),dmeq(bus,BR2).


tuchasabus2 rule % hvilken buss har tuc
is  context (A isa bus),
    replaceall (tuc isa savant,has/agent/bus/tuc/A)
    with       (doit/be1/A)
id  []
ip  [].


howminutes rule %% how many minutes MEANS  how long time
is replaceall (howmany(A), A isa Minute)
   with       (which(A),   A isa time)
id []
ip dmeq([minute,hour,second],Minute). %% NOT DAY


nextday rule %% next day MEANS tomorrow
is  replaceall (B isa day,adj/_/next/B/C)
    with       (srel/tomorrow/day/nil/C)
id  []
ip  [].


earlyinthemorning rule %% Imorgen tidlig  MEANS tomorrow  before 0900
is  replaceall (srel/early/time/nil/E,srel/in_morning/time/nil/E)
    with       (srel/after/time/0430/E)
id  []
ip  [].


goearly rule %% go early means after 0430 unless ...
is  not ispresent _ isa clock,   %% skal være der kl 8 i morgen tidlig
    srel/early/time/nil/E,
    add     (MornTime isa clock,srel/after/time/MornTime/E)
id  []
ip  MornTime=0430. %% ad hoc


goearlydefault rule
is  not ispresent _ isa clock,   %% skal være der kl 8 i morgen tidlig
    B isa morning,srel/in/time/B/E,
%  + restrictions
    add     (MornTime isa clock,srel/after/time/MornTime/E)
id  []
ip  MornTime=0430 %% ad hoc
:-double.


todaysfirst rule %% Days first bus = early
is  has/day/bus/_/A,
    not _ isa morning, %% avoid double constraint
    replaceall (adj/_/first/A/E  )
    with       (srel/after/time/0430/E)
id  []
ip  []
 :- single.   %% not confuse


bearly rule %% early in the morning
is  %% not _ isa morning, %% avoid double constraint // they block each other
    replaceall (adj/_/early/_A/E  )
    with       (srel/after/time/0430/E)
id  []
ip  []
 :- single.   %% not confuse


howmanytimesgo rule % how many times does a bus go MEANS how many buses go
is context B isa bus,
   replaceall (howmany(A),A isa time,doit/go/B/E,srel/in/time/A/E)
   with       (howmany(B),doit/go/B/E)
id []
ip [].


gowithouttrans rule %  A bus goes without transfer MEANS A bus goes directly
is context    A isa bus, doit/go/A/C,
   replaceall (B isa transfer, srel/without/transfer/B/C)
   with       (srel/directly/pmode/nil/C)
id []
ip [].


takeandbeon rule %  I take a bus and is on a place MEANS  I (will)  pass the place.
is context    (B isa self,dob/take/B/_/_),
   replaceall (STAND/B/E, srel/on/place/NTH/E)
   with       (doit/go/B/E,srel/to/place/NTH/E),
   not ispresent srel/from/place/NTH/E
id []
ip dmeq(stand,STAND).


beonandtake rule %% be on place and take
is context    (B isa self,dob/take/B/_/_),
   replaceall (STAND/B/E, srel/on/place/NTH/E)
   with       (doit/go/B/E, srel/from/place/NTH/E),
   not ispresent srel/to/place/NTH/E
id []
ip dmeq(stand,STAND).


beonandgo rule % be on and go
is context    (B isa self,doit/go/B/_),
   replaceall (STAND/B/E, srel/on/place/NTH/E)
   with       (srel/from/place/NTH/E),
   not ispresent srel/to/place/NTH/E

id []
ip dmeq(stand,STAND).


goandbeon rule %% go and be on
is context    (B isa self,doit/go/B/_),
   replaceall (STAND/B/E, srel/on/place/NTH/E)
   with       (srel/to/place/NTH/E),
   not ispresent srel/from/place/NTH/E
id []
ip dmeq(stand,STAND).


nearto rule  %%  er nærmeste busstopp til nardosenteret..
is replaceall (adj/_/NEAR/A/_B,srel/to/place/NTH/B)
   with       (doit/be1/A/B, srel/NEAR/place/NTH/B)
id []
ip dmeq(near,NEAR).


downtown rule %% go downtown
is replace srel/downtown/pmode/nil/E with
           (sentrum isa neighbourhood,
            srel/to/place/sentrum/E)
id []
ip [].


iknowx rule %% Do I know  (" få vite ")
is replaceall ( I isa self ,dob/KNOW1/I/A/B ,event/real/B,test )
   with      which(A)
   ,{dmeq([know,know1],KNOW1)}
id []
ip [].


tucnowifx rule % "Do you know whether... " is superf ( ..when .. is not superfluous
is removeall (tuc isa savant ,know/myid/whether/tuc/_/B, event/real/B) % whether
id []
ip [].

iknowifx rule % "Do you know whether...
is removeall (I isa self ,know/myid/whether/I/_/B, event/real/B) % whether
id []
ip [].


showup rule % show up means pass
is remove srel/up/place/nil/B,
   replace doit/show/A/B with doit/pass/A/B
id []
ip [].


possibletogo rule % "be possible to Go" is the same as Go %% TA-100831
is replaceall   (A isa thing,B isa coevent,adj/nil/Possible/B/C,doit/Go/A/D,event/B/D)
   with         (I isa self,doit/Go/I/C)
id []
ip dmeq([possible,easy],Possible).


possibletogo1 rule % "be possible" is the same as go %% OUTDATED?
is replaceall   (adj/_/Possible/it/_,doit/go/it/B)
   with (I isa self,doit/go/I/B)
id []
ip dmeq([possible,easy],Possible).


citycentre rule % centre of city - > sentrum
is  has/city/centre/_/D, %%  ( centre )
	 replace  srel/TOFROMBY/place/D/A
    with     (sentrum isa neighbourhood,
              srel/TOFROMBY/place/sentrum/A)
id  []
ip  dmeq(tofromby,TOFROMBY),unbound(D). %% dmeq first !!!



%%%%%%% END OF SOURCE TO SOURCE SECTION %%%%% %%%%%%%%%%%%

%%%%%%%%%%%%
% We need to remember if a departure is "from" or "to", to store it in the
% context. Now it's gone when passevent is removed (coupled)


fledsbo1 rule
is []
id ispresent departure(Bus,Place,_DaySeq,Depset1),
   ispresent passevent(Depset2,Bus,Place,Opts,_Day,_),
   not depset(from, _),
   add depset(from, [Depset1])
ip Depset1 == Depset2,
   member(from, Opts)
 :-double.

fledsbo2 rule
is []
id ispresent departure(Bus,Place,_DaySeq,Depset1),
   ispresent passevent(Depset2,Bus,Place,Opts,_Day,_),
   not depset(to, _),
   add depset(to, [Depset1])
ip Depset1 == Depset2, member(to, Opts)
:-double.

fledsbo3 rule
is  []
id  ispresent departure(_,_,_,Depset1),
    ispresent connections(Depset2,_,_,_,_,_,_,_,_,_),
    not depset(from, _),
    add depset(from, [Depset1])
ip  Depset1 == Depset2
 :-double.


fledsbo4 rule
is []
id ispresent departure(_,_,_,Depset1),
   ispresent connections(_,Depset2,_,_,_,_,_,_,_,_),
   not depset(to, _),
   add depset(to, [Depset1])
ip Depset1 == Depset2
:-double.

fledsbo5 rule
is []
id ispresent keepafter(_, Dep1, Dep2),
   remove depset(Dir, List),
   add depset(Dir, [Dep2 | List])
ip varmember(Dep1, List),
   \+ varmember(Dep2, List)
:-double.

fledsbo6 rule
is []
id ispresent keepbefore(_, Dep1, Dep2),
   remove depset(Dir, List),
   add depset(Dir, [Dep2 | List])
ip varmember(Dep1, List),
   \+ varmember(Dep2, List)
:-double.

fledsbo61 rule
is []
id ispresent keepbefore1(_, Dep1, Dep2),
   remove depset(Dir, List),
   add depset(Dir, [Dep2 | List])
ip varmember(Dep1, List),
   \+ varmember(Dep2, List)
:-double.

fledsbo7 rule
is []
id ispresent keepbetween(_,_, Dep1, Dep2),
   remove depset(Dir, List),
   add depset(Dir, [Dep2 | List])
ip varmember(Dep1, List),
   \+ varmember(Dep2, List)
:-double,

%%%%


whichnumberhas rule % hvilket nr har bussene ? nr -> route (SIC)
is  exactly (which(A),A isa route,Bus isa BR,has/vehicle/route/Bus/A,event/real/_)
id	 add listofall(BR,_)
ip  dmeq([bus,nightbus,tram],BR),unbound(Bus).


%% allofakind rules %% all ordinary listable nouns



% hvilke XX  vet du  MEANS what is % Moved back
allofakind00 rule %% kan du bussene FRONTED
is  exactly (test,tuc isa savant,B isa BR,dob/KNOW1/tuc/B/_)
  ,{dmeq([know,know1],KNOW1)}
id	 add listofall(BR,_)
ip  dmeq([bus,nightbus,tram,route],BR),
    unbound(B)
:-single.

allofakindmain rule %% what are the main buses
is  exactly (which(Bus),Bus isa BR, adj/_/main/Bus/_) %% etc
id	 add listofall(BR,_)
ip  dmeq([bus,nightbus,tram,route],BR),
    unbound(Bus).

allofakindexist rule  %%  after doyouhavex
is  which(Bus),doit/exist/Bus/_, Bus isa BR,
    not _ isa station,
    not _ isa neighbourhood
id	 add listofall(BR,_)
ip  dmeq([bus,nightbus,tram,route],BR),
    unbound(Bus).

allofakindknow  rule
is  dob/KNOW1/tuc/Bus/_,Bus isa BR,
    not _ isa station,
    not _ isa neighbourhood
  ,{dmeq([know,know1],KNOW1)}
id	 add listofall(BR,_)
ip  dmeq([bus,nightbus,tram,route],BR),
    unbound(Bus).

allofakind0 rule % Hva heter bussene
is  which(Bus),Bus isa BR,
    _ isa thing,            %% ad hoc
    not _ isa station,
    not _ isa neighbourhood
id	 add listofall(BR,_)
ip  dmeq([bus,nightbus,tram,route],BR),
    unbound(Bus).


allofakind1 rule % Which buses are there? / What is a bus
is  exactly (which(Bus),Bus isa BR)
id	 add listofall(BR,_)
ip  dmeq([bus,nightbus,tram,route],BR),
    unbound(Bus).

allofakind2 rule
is  exactly (which(Bus),Bus isa BR, event/real/_),clear
id	 clear,
    add listofall(BR,_),
    add flag(exit)
ip  dmeq([bus,nightbus,tram],BR),unbound(Bus).


allofakind3 rule
is  exactly (which(Bus),Bus isa BR, doit/be1/Bus/_,event/real/_)
id	 add listofall(bus,_)
ip  dmeq([bus,nightbus,route],BR),unbound(Bus).

allofakind4 rule
is  exactly (which(Bus),Bus isa BR, doit/be1/Bus/_,event/real/_)
id	 add listofall(BR,_)
ip  dmeq([bus,nightbus,tram,route],BR),unbound(Bus).


allofakind6 rule %% hva heter bussene
is  A isa thing,B isa BR, dob/be_named/B/A/C,event/real/C,
    {dmeq([bus,nightbus,tram],BR),unbound(B)}
id	 add listofall(BR,_)
ip  [].


allbuses0 rule
is  which(A),     A isa bus,
    tuc isa savant,
    dob/KNOW1/tuc/E, srel/_Regarding_/thing/A/E %% know about/
  ,{dmeq([know,know1],KNOW1)}
id  add listofall(bus,_) %% generalized allbuses
ip  [].

allbuses1 rule % Goddag mann
is  which(A),     A isa bus,
    tuc isa savant,
    dob/KNOW1/tuc/A/B, event/real/B
  ,{dmeq([know,know1],KNOW1)}
id  add listofall(bus,_) %% generalized allbuses
ip  [].

allbuses2 rule %% list all buses
is  exactly (doit,tuc isa savant,Bus isa BR,dob/List/tuc/Bus/E,event/real/E)
id	 add listofall(BR,_)
ip  dmeq([bus,nightbus,route,number],BR),
    unbound(Bus),dmeq([give,list,show,find],List).


allbuses3 rule % Which numbers do the buses have ?
is  exactly (which(A),A isa number,B isa BR,has/bus/number/B/A,event/real/_)
id	 add listofall(bus,_)
ip  dmeq(bus,BR),unbound(B).


howmanystations1 rule % How many stations are there?
is  exactly (howmany(St),St isa station, STAND/St/A,event/real/A)
id	 add (listofall(station,M),
         numberof(stations,M,_))
ip  \+ main:myflags(smsflag,true),
    dmeq([be1,exist],STAND).


howmanystations2 rule % How many stations have ...?
is  exactly (howmany(ST ),ST isa station,TT isa Company,has/Company/station/TT/ST ,event/real/_)
id	 add (listofall(station,M),
         numberof(stations,M,_))
ip  [].


whichbuses1 rule % Which buses are there?
is  exactly (which(Bus),Bus isa BR, doit/be1/Bus/A,event/real/A)
id	 add listofall(bus,_)
ip  dmeq(bus,BR).



howmanybuses1  rule % How many buses are there  ?
is  howmany(Bus),Bus isa bus,
    doit/BE/Bus/A,event/real/A,
    not srel/in/day/_/_,  %% frequency ?  % before next:
    not srel/in/_Place/_/A, %% in system etc
    not X isa route when { bound(X)}
id	 add (listofall(bus,M),numberof(busroutes,M,_))
ip  dmeq(exist,BE).


howmanybuses2 rule % Howmany buses goes?
is  exactly (howmany(Bus),doit/PASS/Bus/E,Bus isa BDR,event/real/E)
id	 add (listofall(bus,M),
         numberof(busroutes,M,_))
ip  dmeq(bepass,PASS), dmeq([bus,route],BDR).


howmanybuses3 rule % How many buses have you (after transform)  ?
is  howmany(Bus),Bus isa Vus,
    not (not _), %% hides the not qualifications
    not _ isa program, %% programlines :-)
    not ispresent N isa station,
    not ispresent N isa neighbourhood,
    not ispresent stand/_/_,
    not ispresent _ isa clock,
    not ispresent srel/_/place/_,
    not ispresent run/_/_,
    not ispresent doit/go/_/_,
    not ispresent doit/pass/_/_, %% (pass + dir)
    not ispresent drive/_/_,
    not ispresent _ isa departure,
    not ispresent srel/in/place/_/_, %% Norge, etc
    not X isa route when { bound(X)}
id  add (listofall(bus,M),numberof(busroutes,M,_))
ip  dmeq([bus,vehicle,route],Vus).


whbusin rule % Which buses are there in ...?
is  exactly (which(Bus),Bus isa bus, doit/be1/Bus/A,event/real/A,srel/in/place/_/A)
id	 add listofall(bus,_)
ip  unbound(Bus).


whnightbusesgo rule % Which nightbuses go?
is  exactly (which(Bus),Bus isa nightbus,doit/PASS/Bus/E,event/real/E)
id	 not  add listofall(nightbus,_),
    add  listofall(nightbus,_)
ip  unbound(Bus),
    dmeq(bepass,PASS).


whatisabus  rule %% what is a bus ?
is  exactly (which(A),B isa bus,
    event/real/C,
    dob/be/B/A/C)
id	 add listofall(bus,_)
ip  unbound(B).


whbusesin rule % Which buses are in  Team/Oracle/etc
is  A isa route,doit/be1/A/B,srel/in/_Place/_/B,
    not ispresent _ isa neighbourhood, %% e.g. Klæbu
    not ispresent _ isa station
id	 add listofall(route,_)
ip  unbound(A).


whbusesgo rule % Which buses go?
is  exactly (which(Bus),Bus isa BR,doit/PASS/Bus/E,event/real/E),
    {dmeq(bus,BR)}
id	 add listofall(BR,_)
ip  unbound(Bus),
    dmeq(bepass,PASS).


busesexist rule %% (which/does) buses exist
is  exactly (test,B isa Bus, doit/exist/B/E,  event/real/E),{unbound(B)}
id	 add listofall(Bus,_)
ip  dmeq([bus,nightbus,tram],Bus).



noinfochange rule
is  dob/change/_/A/_, ispresent A isa Route,
        {dmeq([route,route_plan],Route)} %% \ikke bytte buss
id	 addcon message(noinfoabout(change)),
    add flag(exit)
ip  [].

%%%%% Irrelevante opplysninger %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



imissbus rule %% similar to reach (miss=lose)
is  ispresent B isa BR,  dob/lose/'I'/B/_ % 'I' is self disappears
id	 addcon message(nocorresponse),
    add flag(exit) % ?
ip  dmeq(busdeparr,BR).


canicallyou rule
is  test,I isa Self, dob/call/I/tuc/_  %% TMN
id  clear,
    add (
    message(answer(db_reply(tuc,telephone,K))))
ip  dmeq([self,program],Self),
    has_att_val(agent,telephone,tuc,K).


calltmn1 rule
is  which(A),A isa place,I isa Self, dob/call/I/A/_  %% TMN
id  clear,
    add ( %% has_att_val(company,telephone,tmn,K),
    message(answer(db_reply(tmn,telephone,K))))
ip  dmeq([self,program],Self),
    has_att_val(company,telephone,tmn,K).

calltmn2 rule
is  which(A),A isa place,I isa Self, dob/turn/I/E, srel/in/place/A/E %% TMN
id  clear,
    add ( %% has_att_val(company,telephone,tmn,K),
         message(answer(db_reply(tmn,telephone,K))))
ip  dmeq([self,program],Self),
    has_att_val(company,telephone,tmn,K).

%%%% AIRBUS / AIRPORT SECTION + Ferry

sail rule
is  sail/_/_
id	 clear,
    add   message(noinfoabout(boat))
ip  [].

fly rule
is  fly/_/_
id	 clear,
    add   message(noinfoabout(airplane)),
    add   message(answer(db_reply(flybussen,webaddress,K)))
ip  internal_airbus(false), %% busdat
    have_att_val(company,webaddress,flybussen,K).


airplane  rule %% fly_buss --> fly buss -> plane bus
is  adj/_/airplane/_/_
id	 clear,
    add   (message(answer(db_reply(flybussen,webaddress,K))))
ip  internal_airbus(false), %% busdat
    have_att_val(company,webaddress,flybussen,K).


airport1 rule %%  airport
is  _ isa airbus,clear
id	 clear,
    add (message(noinfoabout(airbus)),
         message(answer(db_reply(flybussen,webaddress,K)))),
    add flag(exit)
ip  internal_airbus(false), %% busdat
    have_att_val(company,webaddress,flybussen,K).

airport2 rule %%  airport værnes
is  Værnes isa airport,
    clear %% værnes, not gardermoen
id	 clear,
    add (message(noinfoabout(airbus)),
         message(answer(db_reply(flybussen,webaddress,Z)))) %% TA-101110
ip  internal_airbus(false), %% busdat
    airbusstation(Værnes), %% busdat.pl
    have_att_val(company,webaddress,flybussen,Z).


airport21 rule %%  airport
is  _ isa airport,
    clear
id	 clear,
    add (message(noinfoabout(airbus)),
         message(answer(db_reply(flybussen,webaddress,K))))
ip  internal_airbus(false), %% busdat
    have_att_val(company,webaddress,flybussen,K).


airport3 rule %%  airport
is  FLY isa neighbourhood, clear
id	 clear,
    add (message(noinfoabout(airbus)),
         message(answer(db_reply(flybussen,webaddress,K))))
ip  internal_airbus(false),airbusstation(FLY),
    have_att_val(company,webaddress,flybussen,K). %% all %% TA-101124


airport4 rule %%  airport
is  X isa airplane, srel/_/airplane/X/_ ,clear
id	 clear,
    add (message(answer(db_reply(flybussen,webaddress,K))))
ip  internal_airbus(false),
    have_att_val(company,webaddress,flybussen,K).

airport5 rule %%  airbusterminal %%
is  _ isa airbusterminal,clear
id	 clear,
    add message(noinfoabout(airbus)),
    add message(answer(db_reply(flybussen,webaddress,K)))
ip  internal_airbus(false),
    have_att_val(company,webaddress,flybussen,K).


whereairbus rule % Hvor stopper flybussen
is  Bus isa airbus,
    which(Station),doit/PASS/Bus/B, {dmeq(pass,PASS)},
    srel/_In/place/Station/B, {unbound(Station)},

    not Stat1 isa station  when {bound(Stat1)},
    not Neib1 isa neighbourhood when { bound(Neib1)},
    not ispresent srel/_/place/Moholt/_  when { bound(Moholt)},%% not if station is mentioned
    not ispresent srel/between/place/_/_,
    not ispresent adj/_/next/_/_,
    not srel/off/place/_/_,  %% side av veien
    not srel/_Now/time/_/_ ,                    %% NOW
    not srel/nil/time/_/_ ,
    not has/_Vehicle/departure/Bus/_,

    clear
id	 atday(Day),
    not  passevent(_,_,_,_,_,_), %% avoid test departure(_,_,_,_),
	 add (findstations(flybussen,Day,Stl),passesstations(flybussen,Day,Stl,_))
ip	 [].               %% NB   %%



%%% End Airport Section

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

goddagmann rule
is  howmany(Bus),ispresent Bus isa Frog,
    clear % avoid GodDagMannØkseskaft answers (GDMØ)
id  not message(_Already),
    clear,
    addfront message(idonotknow)
ip  \+ testmember(Frog,[money,crown,question]), %% TA-101215
    \+ dmeq(busdeparr,Frog),
    \+ dmeq(place,Frog).

nofrequenciessms rule
is  replaceall (which(A), A isa frequency,doit/go/B20/B,srel/pwith/frequency/A/B)
    with       (which(A), A isa time,doit/go/B20/B,srel/in/time/A/B),
    clear %% sms>160
id  clear,
    add message(noinfoabout(frequency)),
    add flag(exit)
ip  main:myflags(smsflag,true).

nofrequencies rule  %% how often -> when
is  replaceall (which(A), A isa frequency,doit/go/B20/B,srel/pwith/frequency/A/B)
    with       (which(A), A isa time,doit/go/B20/B,srel/in/time/A/B)

id  add message(noinfoabout(frequency))
ip  \+ main:myflags(smsflag,true).


perhour rule
is  srel/per/Min/_/_, {dmeq([hour,minute,second],Min)},
    clear %% sms>160
id  clear,
    add message(noinfoabout(frequency))
ip  [].


nofrequencies99 rule %% destructive
is  _ isa frequency,
    not ispresent change/_/_,   %% how often change bus
    not ispresent dob/change/_/_/_,
    clear
id  clear,
    add message(noinfoabout(frequency)),
    add flag(exit)
ip  [].


ruthphone  rule
is  I isa self, doit/speak/I/E, srel/pwith/agent/tuc/E
id  clear,
    add message(answer(db_reply(tuc,telephone,73511348)))
ip  [].


one77 rule %% Ruteopplysningstelefonen
is  I isa self,call/I/E,X isa place,srel/_/place/X/E
id  clear,
    add message(answer(db_reply(ruteopplysningen,telephone,177)))
ip  [].


haveyou rule %%  Hvilke X har du -> Hvilke X fins
is  replaceall (tuc isa savant, has/agent/station/tuc/A, event/real/E)
    with       (doit/exist/A/E, event/real/E)
id  []
ip  [].


hasattvalwebroute rule %% hva er nettsiden til rutetidene
is  which(A),A isa webaddress,B isa route_plan,has/route_plan/webaddress/B/A
id  add  message(answer(db_reply(TT,webaddress,K)))
ip  main:myflags(actual_domain,TT),
    has_att_val(company,webaddress,TT,K).


hasattvalTT rule
is  which(A),TT isa company, A isa Telephone,
    has/agent/Telephone/TT/A
id  add  message(answer(db_reply(TT,Telephone,K)))
ip  dmeq([telephone,webaddress],Telephone),
    main:myflags(actual_domain,TT),
    has_att_val(company,Telephone,TT,K).


telephonefor rule %% for politiet (unresolved  possessive  has/)
is  which(A),A isa telephone,TT isa Agent,doit/be1/A/E,srel/for/_Thing/TT/E,event/real/E,
      { dmeq([place,agent,company,savant],Agent)}
id  add  message(answer(db_reply(TT,telephone,K)))
ip  has_att_val(agent,telephone,TT,K).


hastelephone rule %% til politiet
is  which(A),has/Agent/telephone/TT/A,
      { dmeq([agent,company],Agent)},
    {TT \== tuc} %% har du telefon til// ikke din telefon %% TA-110324
id  add  message(answer(db_reply(TT,telephone,K)))
ip  has_att_val(Agent,telephone,TT,K).


hasatt0 rule %% Ruteopplysningstelefonen
is  A isa telephone,
    has/company/telephone/tt/A,clear
id  clear,
    add message(answer(db_reply(ruteopplysningen,telephone,177)))
ip  [].


hasatt01 rule %% before hasatt1    % din -> a program
is  has/system/Version/Tuc/A,
    Tuc isa savant,
    A isa Version,
    clear
id  clear,
    add  message(answer(db_reply(tuc,Version,K)))
ip  has_att_val(_Company,Version,tuc,K).


whichage rule
is which(A),TA isa person,A isa age,has/agent/age/TA/A
id  add  message(answer(db_reply(TA,birthday,K))),
    add flag(exit)
ip  has_att_val(person,birthday,TA,K).



wasborn rule %% når ble Tore Amble født %% TA-110520
is  which(A),TA isa person,B isa agent,A isa time,dob/bear2/B/TA/C,srel/in/time/A/C,event/real/C
id  add  message(answer(db_reply(TA,birthday,K))),
    add flag(exit)
ip  has_att_val(person,birthday,TA,K).


hasatt1 rule  %% Standard General %%<---
is  A isa Telephone,
    has/Company/Telephone/TT/A,
    not ispresent  has/agent/_/'I'/A, %% har du telefonnumeret mitt
    not ispresent  has/City/Telephone/_/A when {City \== agent},  %% TA-110324
                       %% AD HAC  har du nummeret til Trondheim
    clear    %%  Telephone is never a subclass
id  clear,
    add  message(answer(db_reply(TT,Telephone,K)))
ip  bound(TT),
    has_att_val(Company,Telephone,TT,K).

%%%%%%%%%  TELEPHONE SECTION %%%%%%%%%%%%%%%%%%%%%%%%

hasattvalgen2 rule
is  which(A),   A isa Telephone ,
    has/Person/Telephone/X/A,
    X  isa _Man
id  clear,
    add  message(answer(db_reply(X,Telephone,N)))
ip  bound(X),
    has_att_val(Person,Telephone,X,N).


nopicture rule   %% have you got a picture
is  _ isa picture,clear
id  clear,
    addfront message(sorryno(picture))
ip  [].

nomap rule   %% Moved forward
is  _ isa map,clear
id  clear,
    addfront message(sorryno(map))
ip  [].     % message necessary also for  empty answer


wherefinddn rule % user knows you don't know,  I dont know
is (which(A),B isa self,A isa place,
    doit/find/B/C/E,event/real/E,srel/in/place/A/E,C isa _Topic)
id add  message(answer(db_reply(tt,webaddress,K)))
ip has_att_val(company,webaddress,tt,K).


wheretram rule % Where does the tram go
is  exactly (which(A),A isa Place,srel/_NI/place/A/C,B isa tram,doit/GO/B/C,event/real/C)
id	 atday(Day),
    add (findstations(TheTram,Day,Stl),
         passesstations(TheTram,Day,Stl,_)) %
ip  dmeq([go,leave,run,pass],GO),unbound(B),
    dmeq([station,place],Place),
    thetramno(TheTram).   %% ONLY ONE TRAM


knowtram rule  % Where does the bus go
is  exactly (which(A),A isa place,srel/_NI/place/A/C,B isa tram,doit/GO/B/C,event/real/C)
id	 add	message(mustknow(tram))
ip  dmeq([go,leave,run,pass],GO),
    unbound(B),
   \+ thetramno(_). %% test


wherecanigo rule % Where can I go
is  exactly (which(A),B isa self,doit/Go/B/C, srel/_NI/place/A/C,A isa place,event/real/C),
    {dmeq([go,run,leave,pass],Go)}
id	 add	message(mustknow(bus))
ip  [].



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SECTION DATE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


normalizedate rule
is  replaceall (F58 isa time,doit/go/F56/F57,srel/in/time/F58/F57,
                            DATE isa date,srel/_/_/DATE/F57)
    with       (F58 isa time, %% in case when ...
                doit/go/F56/F57, DATE isa date, srel/on/date/DATE/F57)
id  []
ip  [].


setexdatenightdateextra rule   %% nightbus, date is given
is  context(DATE isa date)
id  flag(nightbusflag),
    not atdate2(_,_),
    add atdate2(DaySeqNo,DATE),
    addcon  atday(Saturday)
ip  \+ (DATE = date(_,12,24)), %% not in the evening!
    \+ (DATE = date(_,12,31)),
    extraallowed_night(DATE,Saturday),
    dayModSeqNo(DATE,DaySeqNo).


setexdatenightdateextraotherwise rule   %%
is  []
id  flag(nightbusflag),
    atdate2(_DaySeqNo,DATE),
    not atday(_),
    add  atday(Saturday)
ip  extraallowed_night(DATE,Saturday).



setexdatenightdateextratoday rule %%  monday 27, "nightbus"
is  not ispresent _ isa day,
    not ispresent _ isa date %% julaften count as "day" and allows night to next day
id  flag(nightbusflag),
    not atday(_),
    add  atday(Saturday),
    add atdate2(DaySeqNo,ED)
ip  timenow(D), D > 0430, %% NOT moday 27 between 2400 - 0059
    todaysdate(DATE),
    add_days(DATE,1,ED),
    extraallowed_night(ED,Saturday),
    dayModSeqNo(DaySeqNo,ED).


setexdatenightdateextralatertonight rule %%  monday 27,morning
is  not ispresent _ isa day,
    not ispresent _ isa date %% julaften count as "day" and allows night to next day
id  flag(nightbusflag),
    not atday(_),
    add  atday(Saturday)
ip  timenow(D), D =< 0400,
    todaysdate(DATE),
    extraallowed_night(DATE,Saturday).



crazyrudolph rule %% day is given as e.g. julaften, converted to
                  %% date but should be interpreted allowing night to next day
is  srel/NILON/date/Date1/_, { bound(Date1)},
    Date1 isa date,
    assume(dmeq([nil,on],NILON)),
    not ispresent _ isa morning,
    not ispresent _ isa morrow, %% Norw  morgen ambig.
    not  comp/day/ne/_/_
id  flag(nightbusflag),
    not atdate2(_,_),
    add atdate2(DaySeqNo,ED),
    addcon atday(Saturday)
ip  xweekday(Date1,H),
    today(T),  T \== H,
    add_days(Date1,1,ED),
    extraallowed_night(ED,Saturday),
    dayModSeqNo(DaySeqNo,ED).

setdatexdagnattextra rule  %% Nightbus Friday (night) = Saturday
is  srel/NILON/Day/F74/_ ,
    assume(dmeq([nil,on],NILON)),
    assume(dmeq([day],Day)), %% date?
    F74 isa Friday,
    not ispresent _ isa morning,
    not ispresent _ isa morrow, %% Norw  morgen ambig.
    not (YMD isa date) when { bound(YMD)},
    not  comp/day/ne/_/_
id  flag(nightbusflag),
    not atdate2(_,_),
    add atdate2(DaySeqNo,DATE),
    addcon atday(Saturday)
ip  dmeq(mtwtfss,Friday),
    today(Tuesday),
    daysucc(Friday,Saturday),
    main:number_of_days_between(Tuesday,Saturday,N),
    main:finddate(N,DATE),
    extraallowed_night(DATE,Saturday),
    dayModSeqNo(DATE,DaySeqNo).


setdatexdagnatt1 rule  %% Nightbus Friday (night) = Saturday
is  srel/NILON/Day/F74/_ ,
    assume(dmeq([nil,on],NILON)),
    assume(dmeq([day],Day)),
    F74 isa Friday,
    not ispresent _ isa morning,
    not ispresent _ isa morrow, %% Norw  morgen ambig.
    not (YMD isa date) when { bound(YMD)},
    not  comp/day/ne/_/_
id  flag(nightbusflag),
    not atdate2(_,_),
    add atdate2(DaySeqNo,DATE),
    addcon atday(Saturday)  %% <-----
ip  dmeq(mtwtfss,Friday),
    today(Tuesday),
    daysucc(Friday,Saturday),
    main:number_of_days_between(Tuesday,Saturday,N),
    main:finddate(N,DATE),
    \+ disallowed_night(DATE),
    dayModSeqNo(DATE,DaySeqNo).



setdatexdagnatt2 rule  %% Nightbus Friday night = Saturday
is  srel/NILON/daypart/F239/E,srel/on/day/F240/E,
    assume(testmember(NILON,[nil,on])),
    F239 isa Midnight, %% nattbuss fredag kveld = nattbuss lørdag
    F240 isa Friday,
     {dmeq([night,midnight],Midnight)},
    not (YMD isa date) when { bound(YMD)},
    not  comp/day/ne/_/_
id  flag(nightbusflag),
    not atdate2(_,_),
    add atdate2(DaySeqNo,DATE)
ip  dmeq(mtwtfss,Friday),
    today(Tuesday),
    daysucc(Friday,Saturday),
    main:number_of_days_between(Tuesday,Saturday,N),
    finddate(N,DATE),
    dayModSeqNo(DATE,DaySeqNo).

setexdateinatt rule  %% Nightbus tonight
is  ispresent srel/This_midnight/time/_/_,
    not (YMD isa date) when { bound(YMD)},
    not  comp/day/ne/_/_
id  flag(nightbusflag),
    not atdate2(_,_),
    add atdate2(DaySeqNo,DATE),
    addcon  atday(Saturday)
ip  dmeq([this_midnight,tonight],This_midnight),
    today(Friday),
    daysucc(Friday,Saturday),
    main:timenow2(0,HHMM), HHMM > 430, %%  not at midnight
    main:finddate(1,DATE), %% find date tomorrow
    dayModSeqNo(DATE,DaySeqNo).


setexnighttodate  rule  %% natt til/før 1. mai
is  DATE isa date,
    F18 isa midnight,
    srel/nil/daypart/F18/E,
    srel/To/date/DATE/E, { dmeq([to,before],To)}
id  flag(nightbusflag),    %% ignore date day map etc
    not atdate2(_,_),
    add atdate2(DaySeqNo,DATE),
    add atday(Day)
ip  timenow2(0,T), T > 0430,
    weekday(DATE,Day),
    dayModSeqNo(DATE,DaySeqNo).

setexdagnattXmas  rule  %% Special rules for Xmas/NY 2005/2005
is  not srel/T/day/_/_   when { T \== today},
    not srel/_/date/_/_
id  flag(nightbusflag),
    today(Friday),
    not atdate2(_,_),
    clear,
    add message(generalnightbusxmas),
    add flag(exit)
ip  timenow2(0,T), T > 0430,
    today(Tuesday),
    daysucc(Friday,Saturday),
    main:number_of_days_between(Tuesday,Saturday,N),
    main:finddate(N,DATE),
    main:disallowed_night(DATE).



% when nightbus is referred by day, it means the following midnight
setexdagnattdespair  rule    %% nightbus query after 0430 means next day
is  not srel/T/day/_/_ when { T \== today},      %% day not mentioned except today
    not srel/_/date/_/_,      %% no explicit date mentioned
    not srel/nil/midnight/_/_, %% natt til
    _ isa Friday , {dmeq(mtwtfss,Friday)}
id  flag(nightbusflag),
    not atdate2(_,_),
    add  atday(Saturday),
    add atdate2(DaySeqNo,DATE)
ip  timenow2(0,T), T > 0430,
    today(Tuesday),
    daysucc(Friday,Saturday),
    main:number_of_days_between(Tuesday,Saturday,N),
    main:finddate(N,DATE),
    \+ extraallowed_night(DATE,_),
    \+ main:disallowed_night(DATE),
    dayModSeqNo(DATE,DaySeqNo).



nightbusmeanstomorrow  rule    %% nightbus query after 0430 means next day
is  not srel/T/day/_/_  when { T \== today},      %% day not mentioned except today
    not srel/_/date/_/_,       %% no explicit date mentioned
    not srel/nil/midnight/_/_ %% natt til
id  flag(nightbusflag),
    not atdate2(_,_),
    add  atday(Saturday),
    add atdate2(DaySeqNo,DATE)
ip  timenow2(0,T), T > 0430,
    today(Friday),
    daysucc(Friday,Saturday),
    main:finddate(1,DATE),
    \+ extraallowed_night(DATE,_),
    \+ main:disallowed_night(DATE),
    dayModSeqNo(DATE,DaySeqNo).





setexeveningbefore  rule  %% kveld  før dato
is  F18 isa night, %% i.e. evening,
    srel/nil/daypart/F18/E,
    replace (DATE isa date) with (NEXTDATE isa date),
    replace (srel/To/_date/DATE/E) with (srel/on/_date/NEXTDATE/E)
id  not flag(nightbusflag),
    not atdate2(_,_)
ip  dmeq([to,before],To),
    main:sub_days(DATE,1,NEXTDATE).


setexoneveningbefore1  rule  %% på/om kveld  før dato
is  F18 isa night, %% i.e. evening,
    srel/On/night/F18/E, { dmeq([on,during2],On)},
    replace (DATE isa date) with (NEXTDATE isa date),
    replace (srel/To/_date/DATE/E) with (srel/on/_date/NEXTDATE/E)
id  not flag(nightbusflag),
    not atdate2(_,_)
ip  dmeq([to,before],To),
    main:sub_days(DATE,1,NEXTDATE).



setexoneveningbefore2  rule  %% på/om kveld  før dato
is  srel/in_night/time/nil/E,
    replace (DATE isa date) with (NEXTDATE isa date),
    replace (srel/To/_date/DATE/E) with (srel/on/_date/NEXTDATE/E)
id  not flag(nightbusflag),
    not atdate2(_,_)
ip  dmeq([to,before],To),
    main:sub_days(DATE,1,NEXTDATE).


nodatecalc  rule  %%  N dager  før dato % NIX
is  _ isa day, not _ isa date,
    DATE isa date,
    srel/To/_Date/DATE/_, { dmeq([to,before,after],To)},
    clear
id  not flag(nightbusflag),
    not atdate2(_,_),
    clear,
    add message(mustknow(date))
ip  [].


%%% SECTION   SET EXPLICIT DATE


setexdateomndays1 rule %% om tre dager
is   srel/during2/_Duration/N/_,{bound(N)},
     context(N isa day)                     %% nof days
id   not atdate2(_,_),
     add atdate2(DaySeqNo,DATE),
     add atday(ThatDay)
ip   finddate(N,DATE),
     xweekday(DATE,ThatDay),
     dayModSeqNo(DATE,DaySeqNo).

setexdateomnweeks rule %% om 1 uke dager
is   context(N isa week),{bound(N)},
     srel/during2/time/N/_
id   not atdate2(_,_),
     add atdate2(DaySeqNo,DATE),
     add atday(ThatDay)
ip   N7 is N*7,
     finddate(N7,DATE),
     xweekday(DATE,ThatDay),
     dayModSeqNo(DATE,DaySeqNo).

setexdate1previous rule  %% Previous Monday means 7 days ago
is  not (YMD isa date) when { bound(YMD)},  %% another date overrules
    context(U isa Monday),
    adj/_/previous/U/_  %%
id  not atdate2(_,_),
    add atdate2(DaySeqNo,DATE),
    add atday(Monday)
ip  dmeq(mtwtfss, Monday),
    today(Thursday),
    main:number_of_days_between(Thursday,Monday,N),
    N7 is N -7,
    main:finddate(N7,DATE),
    dayModSeqNo(DATE,DaySeqNo).

%% Next Monday means in a week if Monday  %% However, next tuesday means tuesday (PRAGMATIX)
setexdate1next rule
is  not (YMD isa date) when { bound(YMD)},  %% another date overrules
    context(U isa Monday),
    adj/_/next/U/_  %% NEXT MONDAY
id  not atdate2(_,_),
    add atdate2(DaySeqNo,DATE),
    add atday(Monday)
ip  dmeq(mtwtfss, Monday),
    today(Monday),
    main:finddate(7,DATE),
    dayModSeqNo(DATE,DaySeqNo).

setexdatemidnighteaster rule  %% midnight in easter
is  context (DATE isa date)
id  flag(nightbusflag),
    add message(generalnightbuseaster),
    not flag(exit),
    add flag(exit)
ip  disallowed_night(DATE).


setexdate1 rule   %% Set date if another day //  på mandag
is  not (YMD isa date) when { bound(YMD)},  %% another date overrules
    context(U isa Monday),  {dmeq(mtwtfss, Monday)},
    not  comp/day/ne/_/U,            %% not excluded !
    not ispresent srel/today/_Day/nil/_ %% søndagsrute idag ...
id  not flag(exit),
    not atdate2(_,_),
    add atdate2(DaySeqNo,DATE),
    addcon atday(Monday)  %% <-----
ip  today(Thursday),
    Thursday \== Monday,
    findfirstcomingdate(Monday,DATE),
    dayModSeqNo(DATE,DaySeqNo).

setexdatenamed rule   %% Set date if named date
is  context(KHFD isa date),
    not YYYY isa year when { (number(YYYY),\+ this_year(YYYY))}
id  not atdate2(_,_),
    add atdate2(DaySeqNo,DATE),
    addcon atday(XDAY)
ip  bound(KHFD),
    userNOTME: named_date(KHFD,DATE),
    userNOTME: xweekday(DATE,XDAY),
    dayModSeqNo(DATE,DaySeqNo).

setexdate3nightextra rule   %% date  via 2. juledag ->  date -> night to 3. X
is  context(DATE isa date) %% HAIRY
id  flag(nightbusflag),
    not atdate2(_,_),
    add atdate2(DaySeqNo,ED),
    addcon  atday(Saturday)
ip  add_days(DATE,0,ED), %% If date means same date
    dayModSeqNo(ED,DaySeqNo),
    extraallowed_night(ED,Saturday),
    dayModSeqNo(DaySeqNo,ED).

setexdate3nightcrazy rule   %% Set date if explicit midnight Xmas
is  DATE isa date
id  flag(nightbusflag),
    not atdate2(_,_),
    add message(generalnightbusxmas),
    add flag(exit)
ip  (DATE = date(_,12,24); %% not in the evening!
    (DATE = date(_,12,31))). %%


setexdate3night rule   %% Set date if explicit  midnight
is  context(DATE isa date)
id  flag(nightbusflag),
    not atdate2(_,_),
    add atdate2(DaySeqNo,DATE),
    addcon  atday(XDAY)
ip  \+ main:disallowed_night(DATE),
    main:xweekday(DATE,XDAY),
    dayModSeqNo(DATE,DaySeqNo).


setexdate3daynil rule   %% ask for days of date outside periods
is  DATE isa date
id  addcon atday(XDAY),
    add message(date_isa_day(DATE,XDAY)),
    add message(noroutesforthisdate),
    add flag(exit)
ip  main:xweekday(DATE,XDAY),
    decide_period(DATE,TTP), %  set(actual_period, ThePeriod)
    TTP == nil. %% <---- %% allow 21.4 2012

%%     N isa day, srel/during2/time/N/B, %% om N dager


setexdate3day rule   %% Set date if explicit (Normal case)
is  context(DATE isa date)
id  not flag(nightbusflag),
    not atdate2(_,_),
    add atdate2(DaySeqNo,DATE),
    addcon atday(XDAY)
ip  main:xweekday(DATE,XDAY),
    decide_period(DATE,TTP), %  set(actual_period, ThePeriod)
    TTP \== nil, %% <----
    dayModSeqNo(DATE,DaySeqNo),
    set(samedayflag,false). %% Avoid time after now

%%%% End setexdate section


nightbusholidayno  rule %%  CASE: NIGHTBUS DATA  MISSING
is  not ispresent _ isa price , clear %% <-----------------
id  flag(nightbusflag),
    not flag(exit),
    add flag(nightbusflag),
    add flag(exit),
    atday(Day),
    add message(nonightbusesthen) %%
ip  main:findfirstcomingdate(Day,Date), %% NEW datecalc.pl
    \+ extraallowed_night(Date,_),
    main:disallowed_night(Date).


nottodaybutholiday rule
is  []
id  not atday(_),
    not message(nodates), % no point if no routes
    atdate2(_DaySeqNo,DATE),
    add atday(holiday)
ip  date_day_map(DATE,Holiday),
    special_day(Holiday).



holywood1 rule   %% Holiday , but same date !!!
is  []
id  not message(nodates), % no point if no routes
    not flag(decide_period),
    atdate2(_DaySeqNo,DATE),
    atday(_), %%  maybe holiday
    add message(date_isa_day(DATE,Holiday)),
    addfront flag(decide_period), %% (DATE,_Mess),  %% ALWAYS IMPLICIT
    remove atday(_),
    add atday(Holiday),    %% for formal reasons
    add message(otherperiod(DATE))
ip  date_day_map(DATE,Holiday),
    special_day(Holiday),
    main:todaysdate(DATE),
    main:set(samedayflag,true).


holywood2 rule %% Holiday , but another day
is  []
id  not message(nodates), % no point if no routes
    not flag(decide_period), %% (_,_),
    atdate2(_DaySeqNo,DATE),
    atday(_), %%  maybe holiday
    add message(date_isa_day(DATE,Holiday)),
    addfront flag(decide_period), %% (DATE,_Mess), %% ALWAYS IMPLICIT
    remove atday(_),
    add atday(Holiday),    %% for formal reasons
    add message(otherperiod(DATE))
ip  decide_period(DATE,Per),Per \== nil,     %% %% ALWAYS IMPLICIT
    date_day_map(DATE,Holiday),
    special_day(Holiday).


nottoday1 rule % on a day not today %% after holywood
is  []
id  %% not flag(nightbusflag), %% confusing
%%  atday(Day0), %% on monday aug 1., ask monday aug 22 ! #
    atdate2(_DaySeqNo,DATE),
    not flag(exit),
    not message(nodates), % no point if no routes
    not message(date_isa_day(_,_)),
    not message(otherperiod(DATE)), %% Used as Retention flag
    add message(date_isa_day(DATE,Day)), %% addfront ?
    add message(otherperiod(DATE))
ip  \+ main:myflags(samedayflag,true),
%%     \+ today(Day0),
    todaysdate(Todate),
    Todate \== DATE,
    weekday(DATE,Day).


nottoday2 rule % on a date not today
is  not _ isa saturdayroute,
    not _ isa sundayroute
id  not message(nodates), % no point if no routes
    not atday(_),
    not  message(date_isa_day(_,_)),
    atdate2(_DaySeqNo,DATE),
    add atday(Day),
    not message(completesentence),
    add message(date_isa_day(DATE,Day)),
    add message(otherperiod(DATE)) %% på mandag hvis
ip  weekday(DATE,Day),
    \+  ( date_day_map(DATE,Holiday),
          special_day(Holiday)).


nottoday3 rule % on correct day today but wrong date!
is  X isa date,_ isa DD,{dmeq(mtwtfss,DD)}
id  not message(nodates), % no point if no routes
    atday(TODAY),
    not  message(date_isa_day(_,_)),
    atdate2(_DaySeqNo,DATE),
    add atday(Day),
    not message(completesentence),
    add message(date_isa_day(DATE,Day)),
    add message(otherperiod(DATE)) %% på mandag hvis
ip  weekday(X,Day),
    TODAY \== DD.

noroutesfordate rule %% TA-110203  Special dates outside valid routeplan
is   not srel/today/_/_/_ ,
     DATE isa date , {bound(DATE)} %% TA-110408

id   not message(nodates),  %% not addcon
     not flag(decide_period),
     addfront flag(decide_period),
     add   message(noroutesforthisdate), %% addfront
     add flag(exit)  %% dont make connections
ip   todaysdate(TODAY), %% UNLESS DIFFERENT TIMEZONE AND CHANGE OF DATE
     \+ (TODAY =DATE),
     userNOTME: implies( decide_period(DATE,X),X=nil).


whatistime0 rule %% what is the time %% Fronted
is  which(A),(B isa clock,event/real/C,dob/be/B/A/C)
id  add (timenow2(0,T),timeis(T)),
    add flag(exit) %% avoid  May 1. same route ... %% TA-110502
ip  [].


mapday1 rule %% Mapped  day , but same date !!!
is   []
id   not flag(fail),
     not flag(exit),
     not flag(nightbusflag),
     atday(_day),
     atdate2(_DaySeqNo,DATE),
     not message(nodates),
     not message(mustknow(place)),
     not message(mustknowanother(place)),
     not message(date_day_route(date(_YYYY,_MM,_DD),_day)),
%%      not  timeis(_),                 %% spurte om klokka <--
     add message(date_day_route(DATE,MapDay)),
     remove atday(_),
     add atday(MapDay)
ip   main:todaysdate(DATE),
     date_day_map(DATE,MapDay),
     \+  special_day(MapDay),
     main:set(samedayflag,true). %% AD HOC, global



mapday2 rule %% Map day , but another date
is   []
id   not flag(fail),
     not flag(exit),
     not flag(nightbusflag),
     atday(_Day),
     atdate2(_DaySeqNo,DATE),
     not timeis(_),    %% spurte om klokka
     not message(nodates),
     not message(date_day_route(date(_YYYY,_MM,_DD),_)),
     add message(date_day_route(DATE,MapDay)),
     remove atday(_),
     add atday(MapDay)
ip   date_day_map(DATE,MapDay),
     \+  special_day(MapDay).


morrow0 rule % ...tomorrow // out of period! %% TA-100916
is  srel/tomorrow/day/nil/_ ,
    not _ isa ticket,
    not _ isa reservation    %% etc ad n
%%    not _ isa saturdayroute,  %%  (unless saturday tomorrow?)
%%    not _ isa sundayroute     %%
id	 not atday(_),                  %% e.g. i morgen torsdag
    add (today(Day),
         atday(NextDay),
         atdate2(DaySeqNo,DATE)),
    add message(noroutesforthisdate), %%%%add message(mustknow(date)), %% Ad Hoc
    add flag(exit)  %% fail? %% Avoid "umulig på nyrsdag"
ip	 today(Day),   %% Instantiate it
    daysucc(Day,NextDay),
    main:finddate(1,DATE),
    \+ dayModSeqNo(DATE,DaySeqNo).


morrow1 rule % ...tomorrow
is  srel/tomorrow/day/nil/_ ,
    not _ isa ticket,
    not _ isa reservation    %% etc ad n
%%    not _ isa saturdayroute,  %% (unless saturday tomorrow?)
%%    not _ isa sundayroute     %%
id	 not atday(_),                  %% e.g. i morgen torsdag
    add (today(Day),
         atday(NextDay),
         atdate2(DaySeqNo,DATE))
ip	 today(Day),   %% Instantiate it
    main:finddate(1,DATE),
    dayModSeqNo(DATE,DaySeqNo),
    daysucc(Day,NextDay). %% TA-100916



morrow2 rule % ...day_after_tomorrow
is  srel/day_after_tomorrow/day/nil/_
id  not atday(_),
    add (today(Day),
         atday(Day2),
         atdate2(DaySeqNo,Date))
ip	 today(Day),
    daysucc(Day,Day1),
    daysucc(Day1,Day2),
    main:finddate(2,Date),
    dayModSeqNo(Date,DaySeqNo).

yester1 rule % ...yesterday
is  srel/yesterday/day/nil/_ %% time => day
id	 not atday(_),
    add (today(Day),atday(PrevDay),atdate2(DaySeqNo,Date))
ip	 today(Day),daysucc(PrevDay,Day),
    main:finddate(-1,Date),
    dayModSeqNo(Date,DaySeqNo).

yester2 rule %   day_before_yesterday | forgårs
is  srel/day_before_yesterday/day/nil/_ %% time => day
id	 not atday(_),
    add (today(Day),
         atday(PrevDay),
         atdate2(DaySeqNo,Date))
ip	 today(Day),
    daysucc(Day1,Day),
    daysucc(PrevDay,Day1),
    main:finddate(-2,Date),
    dayModSeqNo(Date,DaySeqNo).


whatisdate  rule %% hva er datoen
is  exactly(which(A), B isa date,dob/be/B/A/C,event/real/C) %% TA-110411
id	 add (atday(Day),
         message(date_isa_day(date(Year,Month,DayNr),Day)))
ip	 today(Day),
    datetime(Year,Month,DayNr,_,_,_).



%% END SECTION DATE  %%%%%%%%%%%%%%%%%%%%%



notabusperiod rule
is  (NotBus isa BR),clear
id	 atdate2(_,_), %% at least know that
    not atday(easterhol),
    not message(noroutesforthisdate),
    add message(notinperiod(route,NotBus))
ip	 atomic(NotBus),  NotBus \== it, %% internal anaphora :-)
    dmeq(bus,BR),
    not exbus(NotBus),
    regbus(NotBus),  %% tt/regbusall
    not vehicletype(NotBus,tram).


nightbus0  rule %% date is a holiday, no nightbuses
is  not ispresent _ isa price
id  atdate2(_DaySeqNo,EX),
    flag(nightbusflag),
    atday(holiday),
    not flag(exit),
    add flag(exit),
    add message(standnight)
ip  \+  main:extraallowed_night(EX,_).



nonightbusgen rule % no nightbus, no nightbus on  on saturday/sunday
is  NB isa nightbus,  { unbound(NB)},
    not ispresent dob/cost/_/_/_,
    not ispresent _ isa price,
    not ispresent _ isa station,
    not ispresent _ isa street,
    not ispresent C isa neighbourhood when {(C \== sentrum)}
id  not flag(exit),
    atdate2(_DaySeqNo,Date),
%%     not  atday(easterhol), %% Ad Hoc
    flag(nightbusflag),
    not flag(keepfrombay),
    not keepto(_,_,_),
    not keepfrom(_,_,_),
    not passevent(_,_,_,_,_,_),
    not connections(_,_,_,_,_,_,_,_,_,_),
    add flag(keepfrombay),
    add message(nonightbusesthen), %% <---
    add flag(exit)
ip  \+ disallowed_night(Date),
%% test if following saturday is disallowed (then no default nightbus message)
   ( disallowed_night(Easter),
     days_between(Date,Easter,N), %% datecalc.pl
     N >=1, N =< 5). % sunday morn - saturday ok



busgennatta  rule % bus om natta, tbus, no number, no destination
is  _ isa midnight,
    not ispresent dob/cost/_/_/_,
    not ispresent _ isa price,
    not ispresent _ isa station,
    not ispresent _ isa street,
    not ispresent C isa neighbourhood when { (C \== sentrum)}
id  not flag(exit),
    atdate2(_DaySeqNo,Date),
    not  atday(easterhol), %% Ad Hoc
    flag(nightbusflag),
    not flag(keepfrombay),
    not keepto(_,_,_),
    not keepfrom(_,_,_),
    not passevent(_,_,_,_,_,_),
    not connections(_,_,_,_,_,_,_,_,_,_),
    add flag(keepfrombay),
    add message(generalnightbusmessage), %%  general_nightbus_message
    add flag(exit)
ip  \+ disallowed_night(Date).


nightbusgen  rule % nightbus, no number, no destination
is  NB isa nightbus , {unbound(NB)},
    not ispresent dob/cost/_/_/_,
    not ispresent _ isa price,
    not ispresent _ isa station,
    not ispresent _ isa street,
    not ispresent C isa neighbourhood when { (C \== sentrum)}
id  not flag(exit),
    atdate2(_DaySeqNo,Date),
    not  atday(easterhol), %% Ad Hoc
    flag(nightbusflag),
    not flag(keepfrombay),
    not keepto(_,_,_),
    not keepfrom(_,_,_),
    not passevent(_,_,_,_,_,_),
    not connections(_,_,_,_,_,_,_,_,_,_),
    add flag(keepfrombay),
    add message(generalnightbusmessage), %%  general_nightbus_message
    add flag(exit)
ip  \+ disallowed_night(Date).



nightbusfromcenter  rule % nightbuses go ordinarily from center
is  NB isa nightbus, %% a nightbus is mentioned
    not ispresent dob/cost/_/_/_,
    not ispresent _ isa price ,
    not ispresent sentrum isa _,
    not ispresent srel/from/place/_/_,
%%%     not ispresent srel/nil/place/_/_ , %% nattbuss risvollan
    not ispresent OT isa station  when {nightbusstation( OT)}
id  not flag(exit),
    flag(nightbusflag),
    not flag(keepfrombay),
    not keepto(_,_,_),
    not keepfrom(_,_,_),
    not passevent(_,_,_,_,_,_),
    not connections(_,_,_,_,_,_,_,_,_,_),
    add flag(keepfrombay),
    atday(Day), atdate2(DaySeqNo,_Date),
    add ( departure(NB,OT,DaySeqNo,NewDepset),
		  	 passevent(NewDepset,NB,OT,[from,time,nightbus],Day,E))
ip  nightbusstation(OT),
    \+ neverpasses(NB,OT),
    findfirstcomingdate(Day,Date), %% NEW datecalc.pl
    \+ main:disallowed_night(Date),
    newfree(E).


nightbusonly  rule % nightbuses go from center
is  not ispresent _ isa price,
    ispresent Bus isa nightbus
id  flag(nightbusflag),       %% maybe all ?
    not flag(exit),
    not flag(keepfrombay),
    not keepto(_,_,_),
    not keepfrom(_,_,_),
    not passevent(_,_,_,_,_,_),
    not connections(_,_,_,_,_,_,_,_,_,_),
    add flag(keepfrombay),
    atday(Day),atdate2(DaySeqNo,_Date),
    add ( departure(Bus,hovedterminalen,DaySeqNo,NewDepset),
		  	 passevent(NewDepset,Bus,hovedterminalen,[from,time,nightbus],Day,E))
ip   newfree(Bus),
     newfree(E).


hittegods rule %%  jeg har glemt noe på bussen
is  srel/on/bus/_/_, dob/Forget/_/_/_, {dmeq([forget,lose],Forget)}
id  add ( message(answer(db_reply(tt,webaddress,K)))),  %% will be executed in order
    addfront(message(noinfoabout(luggage)))
ip  has_att_val(company,webaddress,tt,K).


atb_topic rule %% no info but pointer to TEAM < nodates
is   _ isa Special_ticket,clear
id  not  message(answer(db_reply(tt,webaddress,K))),  %% ref buyticket
    add  message(answer(db_reply(tt,webaddress,K))),  %% will be executed in order
    addfront(message(noinfoabout(Special_ticket)))
ip   dmeq([agelimit,animal,bag, bicycle,camera,cat, %% TA-110121
           dog,discount, extrabus,
           flexibus,gasbus,  articulated_bus,lowentry,lowentry_bus,
           card,handicapped,%% overview,
           luggage,military,
           package,pensioner,pram,room,   %% TA-100829
           ringroute,season_ticket,shed,ski,
           shuttleroute,speed, %% smoking,
           schoolbus,special_ticket,strike,
           student,toilet,transfer,travelinsurance, %% TA-100903
           wallet,wheelchair,zone],
        Special_ticket),
    has_att_val(company,webaddress,tt,K).


wheniseaster rule   %% ask for period, specify DAY(eastereve?)
is   which(A),srel/in/time/A/C,A isa time,doit/exist/B/C,
     not _ isa date,
     not _ isa holiday,
     not srel/today/_Day/nil/_,
     not _ isa morrow,
     B isa Easter,
       { dmeq([easter,whitsun,christmas],Easter)},
     clear
id   clear,
     addfront message(mustknow(day))
ip   [].



irregular rule %% irregularity
is  srel/regularly/time/_/_
id  addcon(message(noinfoabout(irregularity)))
ip  [].


morrowholiday rule % ...tomorrow (is a specialday)
is  srel/tomorrow/day/nil/_ ,
    not _ isa ticket,
    not _ isa reservation %% etc ad n
id	 not atday(_),                  %% e.g. i morgen torsdag
    add (today(Day), atday(Hol),atdate2(DaySeqNo,Date))
ip	 today(Day),   %% Instantiate it
    finddate(1,Date),
    date_day_map(Date,Hol),
    dayModSeqNo(Date,DaySeqNo).

notyesterdaydate rule % between 0000 and 0059, tomorrow mwans same day
is    ispresent   srel/tomorrow/day/nil/_,
    _ isa bus or _ isa departure,

    not ispresent ( _ isa saturdayroute),
    not ispresent ( _ isa sundayroute),
    not ispresent ( _ isa clock),
    not ispresent dob/cost/_/_/_,
    not ispresent _ isa winter,
    not ispresent _ isa summer

id  not reply(_),
    not flag(exit),
    not message(completesentence),

    not atday(_),
    not atdate2(_,_),

    add (today(Today),
         atday(Today))

ip  timenow(G), G < 60, %% < 01:00 at night
    today(Today)

:-single.



%% before morrow1
yesterdaydate rule % between 0000 and 0059, date is set to yesterday
     %   -> spurious if  no deps, but rule must apply early
is  _ isa bus or _ isa departure,
    not ispresent _ isa morrow,
    not ispresent _ isa morning,   %% TA-110724
    not ispresent   srel/tomorrow/day/nil/_,
    not ispresent ( _ isa saturdayroute), %% Rough
    not ispresent ( _ isa sundayroute),
    not ispresent ( _ isa clock),
%%     not ispresent adj/_/_/_/_, %% //next
    not ispresent dob/cost/_/_/_,
    not ispresent _ isa winter,
    not ispresent _ isa summer %% etc etc

id  not reply(_), %% in case no route
    not flag(exit),
    not atday(_),
    not atdate2(_,_),
    add flag(yesterday),
    add (today(Today),
         atday(Yesterday),
         atdate2(DaySeqNo,YESTERDATE)),
    not message(completesentence)
%%%%%%%    add message(assumeyesterdepartures)  %% spurious if no deps
ip  timenow(G), G < 60, %% < 01:00 at night
    today(Today),
    daysucc(Yesterday,Today),
    todaysdate(DATE),
    sub_days(DATE,1,YESTERDATE),
    dayModSeqNo(YESTERDATE,DaySeqNo)
:-single.





dianotoday rule % check in frames:  if not explicit today, keep old date
is  not srel/today/_Day/nil/_ ,
    not srel/now/time/nil/_
id  not flag(exit),
    not atday(_),
    not atdate2(_,_),
    not message(completesentence) ,
    add today(Today),
    add atday(Day)
ip  today(Today),
    main:frame_getvalue(day,Day,day),
    Day \== Today
 :- double.


todaydatedefault rule % ...if no day is mentioned, default to today
is  []
id  not flag(exit),
    not atday(_),
    not atdate2(_,_),
    add (today(Day),
         atday(Day)),  %% atday only temporary for dialog
    not message(completesentence)
ip  today(Day)
:- double.



todaydate rule % ...if no day is mentioned, default to today
is  not ispresent ( _ isa saturdayroute), %% Rough
    not ispresent ( _ isa sundayroute)
id  not flag(exit),
    not atday(_),
    not atdate2(_,_),
    add (today(Day),
         atday(Day)),  %% atday only temporary for dialog
    not message(completesentence)
ip  today(Day)
:-single.


atdate rule %%   Find the actual date
is  not ispresent _ isa weekday
id  not flag(exit),
%%  not flag(nightbusflag), %% if date is not set already
    not message(noroutesforthisdate),
    not atdate2(_,_),
    not message(completesentence),
    add atdate2(DaySeqNo,DATE)
ip  main:todaysdate(DATE),
    dayModSeqNo(DATE,DaySeqNo).


weeknumber0 rule %% hvilken uke (nr)  er i morgen // after atdate
is  which(A),A isa week,doit/exist/_/_
id  atdate2(_,Date),
    add message(date_isa_week(Date,Weekno))
ip	 weeknumber(Date,Weekno).

weeknumber01 rule %% hvilken uke er dette ? %% TA-110203
is  which(A),A isa week
id  atdate2(_,Date),
    add message(date_isa_week(Date,Weekno))
ip	 weeknumber(Date,Weekno).


weeknumber01 rule %% hvilken uke er vi %% TA-110203
is  which(A),A isa week
id  atdate2(_,Date),
    add message(date_isa_week(Date,Weekno))
ip	 weeknumber(Date,Weekno).

weeknumber1 rule %% hvilken uke (nr)  er dette
is  which(A),A isa week,doit/be1/_/C,srel/in/time/A/C,event/real/C,
    not message(noroutesforthisdate),
    not message(otherperiod(_)),
    not X  isa date when  {bound(X)}
id  add message(date_isa_week(Date,Weekno))
ip	 todaysdate(Date),
    weeknumber(Date,Weekno).

weeknumber2 rule %% hvilken uke (nr)  er 1. aug. 2008
is  which(A),A isa week,
    ispresent Date isa date,
    dob/be/A/Date/C,event/real/C
id  add message(date_isa_week(Date,Weekno))
ip	 weeknumber(Date,Weekno).


weeknumber3 rule %% hvilken uke (nr)  er i  1. aug. 2008
is  which(A),A isa week,
    ispresent Date isa date,
    doit/be1/A/C,srel/in/time/Date/C,event/real/C
id  add message(date_isa_week(Date,Weekno))
ip	 weeknumber(Date,Weekno).

weeknumber4 rule %% hvilken uke (nr)  er idag
is  which(A),A isa week,
    doit/be1/A/C,srel/today/time/nil/C
id  add message(date_isa_week(Date,Weekno))
ip	 todaysdate(Date),
    weeknumber(Date,Weekno).


nodates02 rule % Special dates without known mapping
is   clear
id   atdate2(_DaySeqNo,DATE),
     not message(nodates),  %% not addcon
     addfront message(nodates),
     add (message(answer(db_reply(tt,webaddress,K))))
ip   userNOTME: date_day_map( DATE,unknown), %% i.e. no route
     has_att_val(company,webaddress,tt,K).


nodates03 rule   % General  Date to day mapping
is   remove  srel/_Prep/day/Day/_
id   atdate2(_DaySeqNo,DATE),
     not message(nodates),
     add atday(Day),
     add message(date_isa_day(DATE,Day))
ip   \+ (date_day_map( DATE,Holiday),
         special_day(Holiday)),
     weekday(DATE,Day).


nodates04 rule   %% except for the day today
is   N  isa month, not srel/today/_/_/_ ,
     clear
id   not atday(_),          %%  sundays in november OK
     add message(mustknow(date))
ip   bound(N).



nodates07 rule   %% except for the day today
is   %% not _ isa time, %% når er påsken %% TA-101124
     not _ isa date,
     not _ isa holiday,
     not srel/today/_Day/nil/_,
     not _ isa morrow,
     _ isa Easter,
       { dmeq([advent,autumn,easter,easter_eve,eastereve,fall,spring,
               christmasroute,semester,
               vacation,whitsun,holiday,easterroute,christmas],Easter)},
     clear
id   clear,
     addfront message(mustknow(date))
ip   [].

nodates007 rule   %% week %% TA-100914
is    _ isa week, not _ isa date,
     not srel/today/_Day/nil/_,
     clear
id   not atday(_),
     clear,
     addfront message(mustknow(day))
ip   [].


nodates08 rule   %% weekend
is    _ isa weekend, not _ isa date,
     not srel/today/_Day/nil/_,
     clear
id   not atday(_),
     clear,
     addfront message(mustknow(day))
ip   [].

nodates09 rule   %% month only
is    A isa month,
      not which(A), %% spørre måned -> date %% TA-100828
      not _ isa date,
     not srel/today/_/_/_ ,

     clear
id   not atday(_),
     clear,
     addfront message(mustknow(date))
ip   [].

nodates10 rule   %% year only , not ask when
is    _ isa year, not which(_), %% spørre om når
     not _ isa price,
     not _ isa date,
     not _ isa clock,
     not _ isa money,
     not doit/live/_/_, %% er 5 år
     not srel/today/_/_/_ ,
     not ispresent (_ isa child), %% under 8 år
     clear
id   not atday(_),
     clear,
     addfront message(mustknow(date))
ip   [].

nodates11 rule   %% last year
is    _ isa lastyear,
     not doit/live/_/_, %% er 5 år
     clear
id   not atday(_),
     clear,
     addfront message(noroutesforthisdate)
ip   [].


unksetexweekday rule   %% after weeknumber# %% TA-110203
is  _ isa Weekday, {dmeq([week,weekday,weekend],Weekday)},
    not (YMD isa date) when { bound(YMD)},  %% another date overrules
    not  comp/day/ne/_/_,            %% not excluded !
    not ispresent srel/today/_Day/nil/_ %% søndagsrute idag ...
id  not atdate2(_,_),
    not message(noroutesforthisdate),
    add message(mustknow(day)),
    add flag(exit)
ip  [].


date1 rule % hvilken dato er det.
is  exactly (which(A),A isa DayDate,doit/Be1/A/B,event/real/B),
      {dmeq(dayordate,DayDate)}
id	 not  message(date_isa_day(_,_)), %% TA-110502
     %%%     (atday(Day),            %%
    addfront  message(date_isa_day(date(Year,Month,DayNr),Day))
ip	 dmeq([be1,exist],Be1),
    today(Day),
    datetime(Year,Month,DayNr,_,_,_).

date2 rule % hvilken dato er det i dag
is  exactly (which(A),A isa DayDate,doit/Be1/A/B,srel/today/_/nil/B,event/real/B)
id	 add (atday(Day),
         message(date_isa_day(date(Year,Month,DayNr),Day)))
ip	 dmeq([be1,exist],Be1),
    dmeq(dayordate,DayDate),today(Day),
	 datetime(Year,Month,DayNr,_,_,_).

date2new rule % det er ... idag %% TA-100829
is  exactly (new,A isa DayDate,doit/Be1/A/B,srel/today/_/nil/B,event/real/B)
id	 add (atday(Day),
         message(date_isa_day(date(Year,Month,DayNr),Day)))
ip	 dmeq([be1,exist],Be1),
    dmeq(dayordate,DayDate),today(Day),
	 datetime(Year,Month,DayNr,_,_,_).


date3 rule %% hvilken ... er det nå
is  exactly (which(A),A isa DayDate,doit/Be1/A/B,event/real/B) %% ,srel/now/_/nil/B)
id	 add (atday(Day),
         message(date_isa_day(date(Year,Month,DayNr),Day)))
ip	 dmeq([be1,exist],Be1),
    dmeq([year,month,day,date],DayDate),today(Day),
    datetime(Year,Month,DayNr,_,_,_).


date4 rule %% hvilket år er det i år
is  exactly (which(A),A isa year,B isa year,doit/Be1/A/C,event/real/C,srel/in/year/B/C)
id	 not atday(_),
    add (atday(Day),
         message(date_isa_day(date(Year,Month,DayNr),Day)))
ip	 dmeq([be1,exist],Be1),
    today(Day),
	 datetime(Year,Month,DayNr,_,_,_).


date5 rule % hva er datoen ?
is  which(A),(A isa date,event/real/_),
    not ispresent srel/tomorrow/day/nil/_  % ad hoc
id	 atday(Day),
    atdate2(_,DATE),
    not message(date_isa_day(DATE,Day)), %% TA-100902
    add message(date_isa_day(DATE,Day))
ip	[].

date56 rule % hva er datoen %% OUTDATED ???
is  which(A),(A isa date,event/real/_),
    not ispresent srel/tomorrow/day/nil/_  % ad hoc
id	 not atday(_New_years_day),
    not message(otherperiod(_)),
    add (atday(Day),
         message(date_isa_day(date(Year,Month,DayNr),Day)))
ip	 today(Day),
    datetime(Year,Month,DayNr,_,_,_).



date6 rule %%   er det mandag (idag)
is  test,A isa XDay,doit/Be1/A/B,event/real/B
id	 add (atday(Day),
         message(date_isa_day(date(Year,Month,DayNr),Day)))
ip	 dmeq([be1,exist],Be1),
    dmeq(mtwtfss,XDay),today(Day),
	 datetime(Year,Month,DayNr,_,_,_).

date7 rule %% hvilken dato er dette // NB  not  er 25 nov.
is  which(A),A isa day,event/real/_
id  not message(date_isa_day(_,_)),
    not message(noroutesforthisdate),
    not message(otherperiod(_)),
    not atday(Day), %% already
    add (atday(Day),
         message(date_isa_day(date(Year,Month,DayNr),Day)))
ip	 unbound(A),
    today(Day),
    datetime(Year,Month,DayNr,_,_,_).


date8 rule % Hvilken dato er det
is  which(Time),Time isa date,dob/be/Time/it/_ %% ad hoc
id	 not atday(_),
    add (atday(Day),
         message(date_isa_day(date(Year,Month,DayNr),Day)))
ip  unbound(Time),
    today(Day),
    datetime(Year,Month,DayNr,_,_,_).


date9 rule % hvilket år er det
is  exactly (which(A),A isa Year1,doit/Be1/A/C,event/real/C)
id	 not atday(_),
    add (atday(Day),
         message(date_isa_day(date(Year,Month,DayNr),Day)))
ip	 dmeq([be1,exist],Be1),
    dmeq([year,month,week,season,leapyear],Year1),
    today(Day),
	 datetime(Year,Month,DayNr,_,_,_).


date10 rule %% Hvilken dag er det  imorgen  -> dagen idag
is  exactly (which(A),A isa DayDate,doit/Be1/A/B,TM isa morrow,event/real/B,srel/in/day/TM/B)
id	   not atday(_),
      addfront message(todayis),
       add (atday(Day),
	        message(date_isa_day(date(Year,Month,DayNr),Day)))
ip	 dmeq([be1,exist],Be1),
    dmeq(dayordate,DayDate),
    today(Day),
    datetime(Year,Month,DayNr,_,_,_).

date11 rule %% Hvilken dag er det i går/imorgen  ->  dagen idag
is  exactly (which(A),A isa DayDate,doit/Be1/A/B,event/real/B,srel/_day/_day/nil/B)
id	    not atday(_),
       addfront message(todayis),
       add (atday(Day),
	        message(date_isa_day(date(Year,Month,DayNr),Day)))
ip	 dmeq([be1,exist],Be1),
    dmeq(dayordate,DayDate),today(Day),
    datetime(Year,Month,DayNr,_,_,_).


date12 rule %% Hva er (lik) datoen i morgen
is  which(X), dob/be/X/A/B, A isa DayDate, event/real/B,
    ispresent srel/_Tomorrow_/_Day/nil/B
id	 not atday(_),
    addfront message(todayis),
    add (atday(Day),
	      message(date_isa_day(date(Year,Month,DayNr),Day)))
ip  dmeq(dayordate,DayDate),today(Day),
    datetime(Year,Month,DayNr,_,_,_).

date13 rule % hva er datoen.
is  which(A), A isa DayDate, _ isa thing,event/real/_E
id	 add (atday(Day),
         message(date_isa_day(date(Year,Month,DayNr),Day)))
ip	 dmeq(dayordate,DayDate),today(Day),
    datetime(Year,Month,DayNr,_,_,_).

date14 rule % hva er datoen idag .
is  which(A), A isa DayDate,_ isa thing,srel/today/_/nil/E,event/real/E
id	 add (atday(Day),
         message(date_isa_day(date(Year,Month,DayNr),Day)))
ip	 dmeq(dayordate,DayDate),today(Day),
    datetime(Year,Month,DayNr,_,_,_).


daysdate rule % Hva er dagens dato
is  X isa day, Y isa date, has/day/date/_/_, clear
id	 not atday(_),
    add (atday(Day),
          message(date_isa_day(date(Year,Month,DayNr),Day)))
ip  unbound(X),unbound(Y),
	 datetime(Year,Month,DayNr,_,_,_),
    today(Day).


weekday1 rule % ...on weekday ( today is sat/sun)
is  _ isa weekday
id	 not atday(_),
    add atday(monday) %%  TUESDAY is SAFER
ip	 today(Today) , decidewday(Today,WeekDay), WeekDay \== monday.


weekday2 rule % ...on Day (on friday, etc.)
is  _ isa WeekDay, {   isday(WeekDay)}
id	 not atday(_),
    not atdate2(_,_), %% date overrules day
    add atday(WeekDay)
ip	 today(TD), WeekDay \== TD. %% same day means today


weekday3 rule  % ...on Day (on friday, etc.)
is  srel/WeekDay/day/nil/_       %% _ isa Weekday missing (adverbial)
id	 not atday(_),
    add atday(WeekDay)
ip	 isday(WeekDay).


weekday4 rule % ... Day (passes risvollan friday, etc.)
is  srel/WeekDay/time/nil/_
id	 add atday(WeekDay)
ip	 isday(WeekDay).



dateisaday rule %% Message date is a day
is   []
id   not flag(exit),
     todyay(Today), %% maybe fictitious
     atday(AtDay),
     atdate2(_DaySeqNo,DATE),
     not message(nodates),
     not message(date_isa_day(_,_)), %% refraction condition
     addfront message(date_isa_day(DATE,Day))
ip   \+ (date_day_map(DATE,Holiday),
         special_day(Holiday)),
     weekday(DATE,Day),
     \+ (Day == Today),
     \+ (Day == AtDay).


whatkindofroute  rule%% er det lørdagsrute i dag (merkedag)???
is   (_ isa saturdayroute or _ isa sundayroute)
id   not flag(exit),
     not flag(nightbusflag),
     atdate2(_DaySeqNo,DATE),
     not message(nodates),
     not message(date_day_route(date(_YYYY,_MM,_DD),_)),
     not timeis(_),    %% spurte om klokka
     add message(date_day_route(DATE,MapDay))
ip   date_day_map(DATE,MapDay).



isitroutetoday  rule %% er det lørdagsrute i dag ?
is  test,
     (_ isa saturdayroute or _ isa sundayroute or _ isa route_plan
     ), %%        or _ isa route ), %% NB ambig. sende ruter
     not ispresent dob/_/_/_/_  %% rough
id   not flag(exit),
     not flag(nightbusflag),
     not timeis(_),    %% spurte om klokka
     not message(nodates),
     %% today(Today), %% maybe blocked by "saturdayroute"
     atdate2(_DaySeqNo,Todate),
     not message(otherperiod(_)),
     not message(date_day_route(_,_)),
     add message(date_day_route(Todate,Today))
%%      add flag(exit)
ip   today(Today).



whatkindofroutetoday  rule %% er det lørdagsrute i dag ?
is   which(A),( A isa route or A isa route_plan),
     {unbound(A)}, %% hva er 4*4 -> which(4),4 isa route,
     not ispresent _ isa station,
     not ispresent _ isa neighbourhood
id   not flag(exit),
     not flag(nightbusflag),
     not timeis(_),    %% spurte om klokka
     not message(nodates),
    %% today(Today), %% maybe blocked by "saturdayroute"
     atdate2(_DaySeqNo,Todate),
     not message(otherperiod(_)),
     not message(date_day_route(_,_)),
     add message(date_day_route(Todate,Today)),
     add flag(exit)
ip   today(Today).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% END DAY AND DATE SECTION

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

whatclockis rule  %% vet du hvor mye klokka er ?
is  B isa clock,event/real/C,dob/be/B/A/C,dob/KNOW1/_/A/D,event/real/D
  ,{dmeq([know,know1],KNOW1)}
id	 add (timenow2(0,T),timeis(T))
ip  [].



questionhelp1 rule % hvilke spørsmål ...
is  which(A),A isa question
id  addfront message(thatisagoodquestion)
ip  [].


questionhelp2 rule %% Stiller jeg deg et spørsmål nå?
is  test,_ isa question, ispresent dob/Make/_/_/_,
           {dmeq([make,set],Make)}
id  addfront message(thatisagoodquestion)
ip  [].


canyouanswer rule %% Hva kan du svare på
is (tuc isa savant,doit/Ans/Tuc/B,event/real/B),
    not ispresent _ isa language,  %%  kan du noen språk
    not ispresent doit/go/_/_, %% then not general
    { dmeq([busstuc,bustuc,tuc],Tuc),
      dmeq([know,know1,answer1],Ans)}
id  not message(_),
    add message(howtuchelp),
    add flag(exit)
ip  [].


whatdoyouknow rule %% What do you know  also tuchelp3
is  tuc isa savant,dob/KNOW1/Tuc/_A/B,event/real/B,
      { dmeq([know1,answer1,know],KNOW1),dmeq([busstuc,bustuc,tuc],Tuc)},
        not ispresent BB isa bus when {bound(BB)},
        not ispresent _ isa language,  %%  kan du noen språk
        not ispresent doit/go/_/_ %% then not general
  ,{dmeq([know,know1],KNOW1)},
    not ispresent _ isa clock %% TA-101104
id  not message(_),
    add message(howtuchelp),
    add flag(exit)
ip  [].


% "Do you know what... " is superflous

know1 rule
is  dob/Know1/Tuc/A/B, {dmeq([know,know1,understand,remember],Know1)},
    context  tuc isa savant,
    event/real/B,
    not srel/about/_/_/B,
    not srel/regarding/_/_/B,
    not srel/_/place/_/_ ,
    not _ isa day,
    not _ isa date,
    not _ isa clock,
    not _ isa station,
    not _ isa bus,
    not _ isa nightbus,
    A isa WE
id  add message(howtuchelp)
ip  dmeq([tuc,bustuc,busstuc],Tuc),
    \+ dmeq([departure,clock,man,woman,language,place,number,route,route_plan],WE),
    \+ dmeq([tagore,norwegian,english],A).  %% kan du norsk


workdayroute rule  %%   (NB  tuesdayroute --> weekday --> monday
is  replaceall ( B isa workdayroute,srel/pwith/bus/B/C)
    with       ( B isa weekday,srel/on/time/B/C)
id  []
ip  [].

%%% Nearest Station Section

fromstreetstatknown rule
is  X isa street, ispresent srel/from/place/X/_
id  add message(nearest_station(start,X,Y))
ip  bound(X),
    X \== it,
    street_station(X,Y), %% station or unknown
    Y \== unknown,
    Y \== '',             %% empty (error in reghpl)
    X \== Y.              %% if NTH cast as street, differ


tostreetstatknown rule
is  X isa street, ispresent srel/to/place/X/_
id  add message(nearest_station(stop,X,Y))
ip  bound(X),
    X \== it,
    street_station(X,Y), %% station or unknown
    Y \== unknown,
    Y \== '',             %% empty (error in reghpl)
    X \== Y.              %% if NTH cast as street, differ






streetstatknown rule
is  X isa street
id  add message(nearest_station(nil,X,Y))
ip  bound(X),
    X \== it,
    street_station(X,Y), %% station or unknown
    Y \== unknown,
    Y \== '',             %% empty (error in reghpl)
    X \== Y.              %% if NTH cast as street, differ




havestation1  rule
is  F isa station,X isa neighbourhood, dob/Have/X/F/_
id  not message(foreign(_)),
    not message(nearest_station(_sT,X,_)),
    add message(nearest_station(_sT,X,Y))
ip  bound(X),X \== it,
    dmeq([have,belong_to],Have),
    placestat(X,Y),  %% busdat
    station(Y). %% NB  E.g. r_i_t_hovedporten is NOT a station on may	 17.


havestation2  rule
is  X isa station,F isa station, dob/Have/F/X/_
id  not message(foreign(_)),
    not message(nearest_station(_sT,X,_)),
    add message(nearest_station(_sT,' ',X)) %% ad hoc holdeplassen nærmest er
ip  bound(X),X \== it,
    dmeq([have,belong_to],Have),
    station(X).


placestatdepend rule %% place stat with bus_depend
is  context (X isa neighbourhood),     %% trondheim is a city
    not ispresent srel/before/place/_/_,
    not ispresent srel/after/place/_/_,
    ispresent B isa bus , { bound(B)}             %% etc
id  not message(foreign(_)),
    not message(nearest_station(_sT,X,_)),
    add message(nearest_station(_sT,X,Y))
ip  bound(X),
    X \== it,
    bus_place_station(B,X,Y),
    (station(Y) ;  X \== Y). %% dont map neib -> neib


whichstationisnear rule %% Hvilken holdeplass ligger nær nardosenteret
                        %% ignorer station, give places  %% TA-110504
is  which(X), X isa station, NS isa station, {bound(NS)},
       srel/Near/place/NS/_, {dmeq([near,around,at,besides],Near)}
id  not message(nearest_station(_sT,X,_)),
    not message(nearest_station(_sT,_,X)),
    not message(stationsat(A,NS,B)),
    add message(stationsat(A,NS,B))
ip  X \== it,
    stationsat(A,NS,B).

placestat1 rule %% %% Hvilket sted  fins på risvollan
is  context (X isa Neighbourhood),   {bound(X)},  %% trondheim is a city
        {dmeq([neighbourhood,company],Neighbourhood)}, %% Lingit
    not ispresent dob/avoid/_/_/_, %%            city_syd ?%% TA-100823 EXPERIMENT
    not ispresent _ isa telephone

id  not message(foreign(_)),
    not message(nearest_station(_ST,X,_)),
    add message(nearest_station(nil,X,Y))
ip  X \== it,
    placestat(X,Y),
    station(Y). %% NB  E.g. r_i_t_hovedporten is NOT a station on may	 17.


placestatnearest  rule %% nærmeste holdeplass til Nardosenteret
is  which(F41),F41 isa station,NS isa station,
    adj/_/near/F41/real,
    doit/be1/F41/E,srel/to/place/NS/E,event/real/E
id  not message(foreign(_)),        %% skulle av ved ...
    not message(nearest_station(_ST,_,_)), %% no doubles
    not message(stationsat(A,NS,B)),
    add message(stationsat(A,NS,B))
ip  [].



placestat2 rule %% nærmeste holdeplass til risvollansenteret
is  context (X isa station) ,
    ispresent srel/Near/place/X/E ,
        {dmeq([near,around],Near)},  %% \+ at %% TA-110502 holdeplassen til
    not doit/be1/_/E %% Ad Hoc   holdeplassen (som er) til travbanevegen %% TA-110503

id  not message(foreign(_)),        %% skulle av ved ...
    not message(nearest_station(_sT,_,_)), %% no doubles
    add message(nearest_station(_sT,X,X)) %% NB to itself
ip  bound(X),
    X \== it. % ?

placestat2at rule %% hva er holdeplass ved risvollansenteret %% TA-101004
is  which(_),
    context (X isa station) ,
    ispresent srel/at/place/X/_
id  not message(foreign(_)),        %% skulle av ved ...
    not message(nearest_station(_sT,_,_)), %% no doubles
    add message(nearest_station(_sT,X,X)) %% NB to itself
ip  bound(X),
    X \== it. % ?

placestat3 rule %% nærmeste holdeplass [til] risvollansenteret
is  context (X isa station) , dob/be/_/X/_,
          adj/_/nearest/X/real,{bound(X)}
id  not message(foreign(_)),
    not message(nearest_station(_sT,X,_)),
    add message(nearest_station(_sT,X,X)) %% NB to itself
ip  [].


isatnth rule % NTH. isat(Y,NTH)  Select one, avoid Donotknow message
is  not ispresent srel/_/time/_/_ ,
    context (NTH isa neighbourhood),
    replace (srel/nil/_Neighbourhood/NTH/E)
    with    (srel/past/place/NTH/E)
id  not message(foreign(_)),
    not message(nearest_station(_ST,_,_)),
    not stationsat(_,_,_),
    add stationsat(NTH,_,_)
ip  bound(NTH),
    NTH \== it,
    NTH \== sentrum, %% etc
    isat(_,NTH).

isatnth rule % NTH. isat(Y,NTH)  Select one, avoid Donotknow message
is  not ispresent srel/_/time/_/_ ,
    context (NTH isa neighbourhood),
    replace (srel/nil/_Neighbourhood/NTH/E)
    with    (srel/past/place/NTH/E)
id  not message(foreign(_)),
    not message(nearest_station(_ST,_,_)),
    not stationsat(_,_,_),
    add stationsat(NTH,_,_)
ip  bound(NTH),
    NTH \== it,
    NTH \== sentrum, %% etc
    isat(_,NTH).


stationstation rule %% The name IS a station
is  context (Y isa station)
id  not message(nearest_station(_sT,_,_)),
    add message(nearest_station(_sT,X,Y))
ip  bound(X),
    X \== it,
    placestat(X,Y).  %% NB in busdat (Real definition)

streetstatwrong rule %% street mapping is not updated, warning to staff
is  X isa street
id  add message(unrecognized_street(X,Y)) %% e.g. Bård Iversens ->  k_jonssons_vei/old
ip  bound(X),
     X \== it,
    street_station(X,Y), %%  unknown  or not station
    Y \== unknown,
    Y \== '',             %% empty (error in reghpl)
    X \== Y,              %% if NTH cast as street, differ
    Y \== m0,      %% ad hoc for sentrumsterminalen
    \+ station(Y). %%




%% AFTER streetstatknown because 1. streetnumber may be unknown
streetstatunknown rule %% gaten nth fins ikke i aktuell ruteplan
is  X isa street,clear
id  clear,
    add message(unknown_street(X)),
    add flag(exit)
ip  bound(X),
    X \== it,
    street_station(X,Y), %% station or unknown
    Y=unknown.


nextbeonplace rule %%  next bus on place = from
is   srel/on/place/Place/C,
     ispresent adj/_/next/_/_,
     not ispresent srel/to/place/_/_, %% already
     ispresent doit/be1/Agent/C,
     Agent isa Whatever, {i_or_a_bus(Agent,Whatever,Bus)}
id   atday(Day),atdate2(DaySeqNo,_Date),
     not passevent(_,_,Place,_,_,_),
     not passevent(_,_,_Anyplace_,[from],_,_), %% Opts . cond
     add (departure(Bus,Stat,DaySeqNo,Depset),
          passevent(Depset,Bus,Stat,[from],Day,C))
ip  bus_place_station(Bus,Place,Stat),
    Stat \== unknown.


howmanyq1  rule %  hvor mange spørsmål har du (be)svart (på)?
is  howmany(A), %% TA-101215
    tuc isa savant,A isa question %%%% ,dob/Tell/tuc/A/B,event/real/B
id  add message(webstatistics)
ip  []. %% dmeq([tell,answer1,answer],Tell).


howmanyq2  rule %  hvor mange spørsmål har du (be)svart (på)?
is  howmany(A),tuc isa savant,A isa question,dob/Tell/tuc/A/B,event/real/B
id  add message(webstatistics)
ip  dmeq([tell,answer1,answer],Tell).



norouteinfooverview rule %%  oversikt over noe
is  _ isa overview
id  add ( message(cannotanswer)),
    add ( message(answer(db_reply(tt,webaddress,K)))),
    add flag(fail)
ip  has_att_val(company,webaddress,tt,K).


whatisclass2 rule  %%  what is D means describe D
is  exactly (which(X),Tagore isa Programmer,dob/be/Tagore/X/B,event/real/B)
id  add message(answer((bcpbc(Person))))
ip  \+ main:myflags(teleflag,true),
    \+ testmember(Programmer,[answer,bus,  vehicle,route,tram,train,airplane,
             easter,christmas,whitsun,information,
             moment,clock,hour,date,midnight,month,week,weather,year,arrival,departure]),
    unbound(Tagore),
    description(Programmer,Person) :- single.

team_topic_web_routes  rule %% link til rutene
is  B isa webaddress, has/_agent/webaddress/Tuc/B,   {unbound(Tuc)},
    {dmeq([agent,savant,route,bus,program],_agent)},
    clear
id  add ( message(answer(db_reply(TT,webaddress,K))))
ip  main:myflags(actual_domain,TT),
    has_att_val(company,webaddress,TT,K).


team_topic_web rule %% nettsider for buss? //cant say no info about
is  B isa webaddress, has/_Agent/webaddress/Tuc/B,
      {dmeq([tuc,bustuc],Tuc)},
    clear
id  add ( message(answer(db_reply(TT,webaddress,K))))
ip  main:myflags(actual_domain,TT),
    has_att_val(company,webaddress,TT,K).



%% PRICE SECTION

costtorunbus rule %% hva koster det å kjøre buss
is  which(A),(B isa coevent,C isa Agent,D isa bus,
        event/B/E,dob/run/C/D/E,dob/cost/B/A/F,event/real/F),
    {dmeq([agent,thing],Agent)}
id  addcon  ticketprice2(bus,_)
ip  [].


costthatbusgo rule %% hvor mye koster det at bussen går
is  %% which(A), koster det 30 kroner å ta buss
    C isa coevent,B isa bus,
    doit/go/B/E,event/C/E,dob/cost/C/_A/F,event/real/F
id  addcon  ticketprice2(bus,_) %
ip  [].

costtogocrazy rule %% hvor mye koster å ta buss %% Odd semantics
is  C isa coevent,
    doit/go/_B/E,event/C/E,dob/cost/C/_A/F,event/real/F
id  addcon  ticketprice2(bus,_) %
ip  [].



costtotake rule %% hvor mye koster det å ta buss %% (nec?)
is  %% which(A),  %% koster det 30 kroner å ta buss
    (B isa coevent,C isa Agent,D isa bus,event/B/E,dob/take/C/D/E,dob/cost/B/_A/F,event/real/F),
    {dmeq([agent,thing],Agent)}
id  addcon  ticketprice2(bus,_)
ip  [].


costitbus rule % koster det NN kroner
is  dob/cost/A/_NN/_, A isa V,{dmeq([ticket,vehicle,bus],V)},
    not _ isa nightbus,
    not _ isa airport,
    not ispresent _ isa airbus,
    clear                %% only SMS ?
id  not  message(noinfoabout(_)), %% dogs,prams etc.
    clear,
    addcon  ticketprice2(bus,_), % gets tour as well
    add flag(exit)
ip  [].


costitairbus1 rule % koste på flybussen
is  dob/cost/_/_NN/_, ispresent _ isa airbus,
    clear                %% only SMS ?
id  not  message(noinfoabout(_)), %% dogs,prams etc.
    clear,
    addcon  ticketprice2(airbus,_) % gets tour as well
ip  [].


costitairbus2 rule % koster til/fra airport
is  dob/cost/_A/_NN/_,_ isa airport, %% A isa bus %% TA-100828
    clear                %% only SMS ?
id  not  message(noinfoabout(_)), %% dogs,prams etc.
    clear,
    addcon  ticketprice2(airbus,_) % gets tour as well
ip  [].

costit1 rule % hvor mye koster det
is  dob/cost/it/_C/_E,
    not _ isa nightbus,
    not _ isa midnight,
    not bustuc isa savant, %% busstuc er gratis
    clear                %% only SMS ?
id  not  message(noinfoabout(_)), %% dogs,prams etc.
    clear,
    addcon  ticketprice2(bus,_) % gets tour as well
ip  [].

costit2 rule % hvor mye koster det %% Ad Hoc
is  dob/cost/it/_E,
    not _ isa nightbus,
    not bustuc isa savant, %% busstuc er gratis
    clear                %% only SMS ?
id  not  message(noinfoabout(_)), %% dogs,prams etc.
    clear,
    addcon  ticketprice2(bus,_) % gets tour as well
ip  [].


busncost0 rule % buss om natta
is  which(A),dob/cost/_It/A/_ ,
    ispresent _ isa midnight,
    not ispresent Stink isa neighbourhood when { foreign(Stink)},
    not ispresent _ isa airport,
    clear
id  clear,
    add ticketprice2(nightbus,_),
    add flag(exit)
ip  [].


busncost1 rule % hva koster bussen/ koster bussen 30 kr
is  dob/cost/B/_A/_ ,B isa Nbus,
    not ispresent Stink isa neighbourhood when { foreign(Stink)},
    not ispresent _ isa airport,
   clear
id  clear,
    add ticketprice2(Nbus,_),
    add flag(exit)
ip  dmeq([bus,nightbus],Nbus).


ticketcost1 rule % Price of a ticket //vet du hva billetten koster/hva koster billetten
is  dob/cost/B/_A/_ ,B isa Ticket,  %% not season ticket
    not ispresent X isa neighbourhood when { foreign(X)},
    not ispresent _ isa airbus,
    not ispresent _ isa airport, %% TA-100828
    not ispresent _ isa nightbus,
    not ispresent _ isa bicycle,
    not ispresent _ isa pram,      %% etc
    clear
id  clear,
    add ticketprice2(bus,_),
    add flag(exit)
ip  dmeq([ticket,trip,adult,child],Ticket).


ticketcostnight rule % Price of a ticket %% not special  ticket
is  dob/cost/B/_A/_ ,B isa Ticket,
    ispresent _ isa nightbus,
    clear
id  clear,
    add ticketprice2(nightbus,_),
    add flag(exit)
ip  dmeq([ticket,trip,adult,child,thing],Ticket).


costto rule %% cost to (go...)
is  dob/cost/_/_/F ,srel/in_order_to/thing/_/F,
%%     ispresent _ isa bus, ... å reise ...
    not ispresent _ isa nightbus,
    not ispresent _ isa midnight,
    clear
id  clear,
    add ticketprice2(bus,_),
    add flag(exit)
ip  [].

thingcost rule % hva koster det
is  dob/cost/B/_A/_ ,B isa Thing,
    not ispresent X isa neighbourhood when { foreign(X)},
    not ispresent _ isa nightbus,
    not ispresent _ isa bicycle,
    not ispresent _ isa pram,      %% etc
    clear
id  clear,
    add message(mustknow(Thing)),
    add flag(exit)
ip  dmeq([thing],Thing).


ticketprice3 rule % Price of a ticket
is  which(A),doit/be1/A/_ ,A isa Ticket,
        { dmeq([ticket],Ticket)}, %% not trip,season ticket %% TA-100829
    not _ isa nightbus,
    not _ isa bicycle,
    not _ isa pram,      %% etc
    not ispresent X isa neighbourhood when { foreign(X)},
    clear
id  clear,
    add ticketprice2(bus,_),
    add flag(exit)
ip  [].


freeride rule %% is it free to
is  not _ isa nightbus,
 removeall
    (F1 isa coevent,F3 isa bus,
    dob/run/_/F3/_,adj/nil/gratis/F1/_)
id  add ticketprice2(bus,_)
ip  [].

freeride2 rule %% is it free to   %%  UGLY -> gratis
is  not _ isa nightbus,
    removeall (A isa coevent,
               adj/_/gratis/it/C,event/real/C,srel/in_order_to/thing/A/C,
               srel/nil/coevent/A/D,event/real/D)
id  add ticketprice2(bus,_)
ip  [].


sufficient rule  %% ticket  sufficient
is   not _ isa nightbus,
    _ isa ticket, adj/_/sufficient/_/_
id  add ticketprice2(bus,_)
ip  [].


money  rule %%  jeg mangler penger. etc
is  _ isa money,
    not _ isa airbus,
    not _ isa nightbus,
    not _ isa airport,
    not _ isa beer  %% :-)
id  not ticketprice2(_,_), %% TA-101124
    add ticketprice2(bus,_),
    add flag(exit)
ip  [].


expensiveto1 rule %% kjøre gratis %% TA-101108
is  not _ isa nightbus,
    not _ isa beer,  %% :-)
    srel/Expensive/pmode/nil/_ , {dmeq([expensive,gratis,cheap],Expensive)}
id  add ticketprice2(bus,_),
    add flag(exit)
ip  [].

expensiveto2 rule %% is it expensive to
is  not _ isa nightbus,
    not _ isa beer,  %% :-)
    adj/_/Expensive/_IT/_ , {dmeq([expensive,gratis,cheap],Expensive)}
id  add ticketprice2(bus,_),
    add flag(exit)
ip  [].


gratis rule
is  not _ isa nightbus,
    srel/freely/pmode/nil/B,event/real/B %% kjøre gratis
id  add (ticketprice2(bus,_))
ip  [].


begratis rule     %% T-100427  free-> gratis
is  not _ isa nightbus, %% være gratis %% adj/_/gratis/_/real
    adj/_/gratis/A/_ ,A isa Bus ,{dmeq(vehicle,Bus)}
id  add (ticketprice2(Bus,_))
ip  [].


pay2 rule
is  not _ isa nightbus,
    dob/pay/_/_/_  %% er det lov å betale med 500 kroner
id  add (ticketprice2(bus,_))
ip  [].

pay1 rule
is  not _ isa nightbus,
    pay/_/E, event/real/E  %% intrans
id  add (ticketprice2(bus,_))
ip  [].


ticketprice1 rule % Price of a ticket
is  not _ isa nightbus,
    which(A),has/Ticket/price/_/A
id  not message(noinfoabout(special_ticket)), %%   " price of a monthly fare
    addcon ticketprice2(bus,_)
ip  dmeq(ticket,Ticket).


ticketprice2 rule    % Price of a ticket in the night
is  which(X),dob/be/X/A/_, A isa price
id  flag(nightbusflag),
    addcon ticketprice2(nightbus,_)
ip  [].


ticketprice3 rule    % Price of a ticket
is  which(A),A isa price, doit/be1/A/C,srel/For/_/B52/C,B52 isa BusT
id  addcon ticketprice2(BusT,_)
ip  dmeq([bus,nightbus],BusT),
    dmeq([on,to,for],For).


ticketprice4 rule      % What is a price
is  not _ isa nightbus,
    which(A),A isa price,doit/be1/A/E,srel/for/Person/_/E
id  addcon ticketprice2(bus,_)
ip  dmeq([person,man,woman,child,boy,girl],Person).


ticketprice5 rule      % What is a price from to
is  not _ isa nightbus,
    which(A),A isa price,doit/be1/A/E,srel/_Prep/Place/_/E
id  addcon ticketprice2(bus,_)
ip  dmeq([place],Place).


ticketprice6 rule % What is a price on
is  which(A), A isa Price, srel/On/_/Y/_,Y isa Ticket
id  addcon ticketprice2(bus,_)
ip  dmeq([price,fare],Price),
    dmeq([ticket,bus,fare],Ticket),
    dmeq([on,for,of],On).


ticketprice7 rule % What is a price
is  which(A),A isa Price,
    not _ isa sms,
    not _ isa night,
    not _ isa nightbus,
    not _ isa boat,
    not _ isa train
id  addcon ticketprice2(bus,_)
ip  dmeq([price,fare],Price).


ticketprice8 rule % What is a price
is  which(A),dob/be/A/B/_,B isa Price,
    not _ isa night,
    not _ isa nightbus,
    not  srel/in_midnight/time/_/_,
    not _ isa nightbus,
    not _ isa boat,
    not _ isa train
id  addcon ticketprice2(bus,_)
ip  dmeq([price,fare],Price).


ticketprice9 rule % What is a price
is  not _ isa nightbus,
    exactly (which(A),A isa price,event/real/_)
id  addcon ticketprice2(bus,_)
ip  [].


ticketprice10 rule % What is a price %% Too gerneral ?
is  not _ isa nightbus,
    _ isa price,
    not _ isa sms
id  addcon ticketprice2(bus,_)
ip  [].


ticketpriceveh rule %% pris buss %% no use ????
is  F31 isa price, F32 isa Bus, doit/be1/F31/F33, srel/nil/vehicle/F32/F33
id  addcon ticketprice2(Bus,_)
ip  dmeq(vehicle,Bus).


ticketpricenight rule % What is a price Nightbus
is  _ isa price
id   flag(nightbusflag),
     addcon ticketprice2(nightbus,_)
ip  [].


price100 rule   % What is a price for going
is  not _ isa nightbus,
    which(A),A isa price,srel/for/price/A/_
id  add ticketprice2(bus,_)
ip  [].


%%%%% END PRICE SECTION



%%%%% Warn at  time and date %%%%%%%%%%%%%%%%%%%

warnattime rule %% varsle kl 1015  %% TA-110201
is  {main:myflags(smsflag,true)}, %% TA-110202
    tuc isa savant,CLOCK isa clock,
        dob/notify/tuc/_/A,srel/_After/time/CLOCK/A
id  atdate2(_DaySeqNo,Date),
    flag(warningflag),
    add timeis(CLOCK),
    add warningtime(Date,CLOCK)
ip  set(warningtime, notification(Date,CLOCK)).


warnwhentimeis rule %% varsle når klokken er 1800  %% TA-110202
is  {main:myflags(smsflag,true)},
    tuc isa savant,
    dob/be/A/T1800/D,{bound(T1800)},
    T1800 isa NClock,{dmeq([time,clock,number],NClock)}, %% T1800  may be parsed as number

    A isa clock, {unbound(A)},
    B isa time,
    dob/notify/tuc/_I_/C,
    srel/in/time/B/C,
    event/real/C,srel/in/time/B/D,event/real/D

id  atdate2(_DaySeqNo,Date),
    flag(warningflag),
    add timeis(T1800),
    add warningtime(Date,T1800)
ip  set(warningtime, notification(Date,T1800)).

%%%%% What time and date %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Tell Time Section

whatistime1 rule %% what is the time
is  which(A),(B isa clock,event/real/C,dob/be/B/A/C)
id  add (timenow2(0,T),timeis(T))
ip  [].


whattime2 rule %%  Hvilken tid er det
is  which(A),(A isa time,doit/exist/A/B,event/real/B)
id  add (timenow2(0,T),timeis(T))
ip  unbound(A).


whattimeisit rule
is  which(A),(A isa time,event/real/B,dob/be/A/it/B) %% repair
id  add (timenow2(0,T),timeis(T))
ip  unbound(A).


%% Outdated %%
whattime1 rule % Hva er klokka? %  Fronted, Date irrelevant
is  exactly (which(Clock1),Clock2 isa clock)
id  add (timenow2(0,T),timeis(T))
ip  unbound(Clock1),Clock1==Clock2.          %% Alarm


whattimenow rule % Hva er klokka nå ? %  Fronted, Date irrelevant
is  exactly (which(A),B isa clock,srel/now/time/nil/C,event/real/C,dob/be/A/B/C)
id  add (timenow2(0,T),timeis(T))
ip  [].


telltime1 rule % Fortell  hva klokka er
is  tuc isa savant,A isa clock,
    dob/tell/tuc/B/_,dob/be/A/B/_
id  add (timenow2(0,T),timeis(T))
ip  [].


whattime2 rule % fortell hva klokka er
is  tuc isa savant,Clock2 isa clock,
    dob/Tell/tuc/Clock2/_ , {dmeq([know,know1,tell],Tell)}
id  add (timenow2(0,T),timeis(T))
ip  [].


whattime3 rule % vet du klokka  / vet du hva klokka er ?
is  tuc isa savant,Clock2 isa clock,dob/KNOW1/tuc/Clock2/_
  ,{dmeq([know,know1],KNOW1)}
id  add message(time(now,T)) % eliminate timeis in busans
ip  timenow2(0,T).         %% TA-101102


whattime4 rule % har du klokke ?
is   tuc isa savant,has/agent/Clock/tuc/A,A isa Clock
id   add (timenow2(0,T),timeis(T))
ip  dmeq([clock,time],Clock).


doyouknowthetime rule % Vet du hva klokka er
is  test,tuc isa savant,A isa clock,
    dob/KNOW1/tuc/B/C,event/real/C,event/real/D,dob/be/A/B/D,
   {dmeq([know,know1],KNOW1)}
id  add message(time(now,T))
ip  timenow2(0,T).


whatistimeafter1 rule % Hva er klokka om en time
is  which(Time),Time isa Timeq,  {dmeq([time,clock],Timeq)}, %% not frequency
    doit/be1/Time/E,
    F isa minute,
    srel/after/_Timemin/F/E,
    not ispresent doit/go/_/_ % etc
id	 add message(time(then,T))
ip  unbound(Time),
    timenow2(F,T).


whatistimeafter rule % Hva er klokka om en time
is  which(Time),Time isa Timeq,  {dmeq([time,clock],Timeq)}, %% not frequency
    srel/_/minute/_/_,
    not ispresent doit/go/_/_  %% etc
id	 add message(cannotanswer),
    add (timenow2(0,T),timeis(T))
ip  unbound(Time).


whattime10 rule % What is your clock .
is (tuc isa savant,has/system/clock/tuc/A,A isa clock)
id	 add (timenow2(0,T),timeis(T))
ip  unbound(A).  %% avoid lunch syndrom


whattime11 rule % Time is now (?).
is  exactly (new,A isa clock,doit/be1/A/B,event/real/B,srel/now/time/nil/B)
id	 add (timenow2(0,T),timeis(T))
ip  unbound(A).  %% avoid lunch syndrom


whattime12 rule % when is it now  (Eng)
is  exactly (which(A),doit/be1/A/B,A isa time,event/real/B,srel/now/time/nil/B,srel/in/time/A/B)
id	 add (timenow2(0,T),timeis(T))
ip  unbound(A).

% % % % % % % %


notram2 rule %% Tram station, but user has asked for bus
is  X isa tramstation,
    clear
id  addcon message(noroutesto(X))
ip  bound(X),
    \+ main:myflags(tmnflag,true),
    \+ X isa station.                %% Ugla


notram3 rule %% tram
is  _X isa tramstation,
    not ispresent (_Y isa bus), %      asks explicitly about bus
    clear
id	 clear,
    addcon message(noroutesfor(tram))
ip   \+ main:myflags(tmnflag,true).

% Sørger for riktig retning i "buss fra/til sted passerer TOFROMBY" etc.

%%%%%%%%%%%%% Stasjoner en kommer fra eller går til %%%%%%%%%


%%%%%%%%% STASJONER ..og passerer, etc. %%%%%%%%%%%%%

%%% BEGIN SECTION HOLDEPLASSER %%%


wherebus11 rule % Hvor går buss Bus fra/til?
is  exactly
   (which(A),A isa place,Bus isa Route,    {dmeq(vehicle,Route)},
    doit/go/Bus/B,event/real/B,srel/_From/place/A/B)
id	 atday(Day),
    not passevent(_,_,_,_,_,_), %% avoid test departure(_,_,_,_),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,_))
ip	 exbus(Bus).


wherebus12 rule % Hvor går buss Bus ? %% moved after fromp
is  which(Station),doit/PASS/Bus/B, {dmeq(pass,PASS)},
    srel/_In/place/Station/B,
    not  Stat1 isa station  when {bound(Stat1)},
    not  Neib1 isa neighbourhood when { bound(Neib1)},
    not ispresent srel/_/place/Moholt/_  when { bound(Moholt)},%% not if station is mentioned
    not ispresent srel/between/place/_/_,
    not ispresent adj/_/next/_/_,
    not srel/off/place/_/_,  %% side av veien
    not srel/_Now/time/_/_ ,                    %% NOW
    not srel/nil/time/_/_ ,
    not has/_Vehicle/departure/Bus/_,
    clear
id	 not flag(exit),
    atday(Day),
    not  passevent(_,_,_,_,_,_), %% avoid test departure(_,_,_,_),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,_))
ip	 unbound(Station),exbus(Bus).

wherebus13 rule % Hvor går stopper buss 5 nær sentrum
is  which(P),P isa Place,
       {dmeq([place,station,neighbourhood],Place)},
    doit/PASS/Bus/B, {dmeq(pass,PASS)},
    srel/_In/place/P/B,
    Neib1 isa neighbourhood,
    srel/In/_Neighbourhood/Neib1/_, {dmeq([in,near],In)},
    not ispresent srel/between/place/_/_,
    not ispresent adj/_/next/_/_,
    not srel/off/place/_/_,  %% side av veien
    not srel/_Now/time/_/_ ,                    %% NOW
    not srel/nil/time/_/_ ,
    not has/_Vehicle/departure/Bus/_
id  not message(nearest_station(_ST,Neib1,_)),
    add stationsat(Neib1,_Stations,_SSS)
ip	 exbus(Bus).



wherebus14 rule % Hvor går trikk 1 ?
is  which(Station),doit/PASS/Tramno/B,srel/_In/place/Station/B,
    not srel/_Now/time/_/_ ,
    not srel/nil/time/_/_ ,
    clear
id	 atday(Day),
    not  passevent(_,_,_,_,_,_), %% avoid test    not departure(_,_,_,_),
	 add (findstations(Tramno,Day,Stl),
         passesstations(Tramno,Day,Stl,_))
ip	 unbound(Station),dmeq(pass,PASS),
    thetramno(Tramno).


whatisbus rule % Hva er buss 6
is  exactly (which(A),A isa Bus),
       { bound(A),dmeq(vehicle,Bus)}
id	 atday(Day),
    not  passevent(_,_,_,_,_,_),
	 add (findstations(A,Day,Stl),
         passesstations(A,Day,Stl,_))
ip	 [].


geton rule %% PLASS Where can i get on a bus?
is  ispresent which(Place),
    ispresent dob/get/_/Bus/C,srel/on/place/nil/C,
    srel/in/place/Place/C
id	 atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,C))
ip	 unbound(Place),busorfree(Bus).


getoff rule %% PLASS Where can i get off a bus?
is  ispresent which(Place),ispresent dob/get/_/Bus/C,srel/off/place/nil/C,
	 srel/in/place/Place/C
id	 atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,C))
ip	 unbound(Place),busorfree(Bus).

busstationsbetween  rule  %% hvilke busstopp er det mellom samfundet og vestre rosten for buss 48 .
is  which(S),  S isa station,
    B52 isa bus, {bound(B52)},
    FromStat isa P1, { dmeq(place,P1)},
    ToStat   isa P2, { dmeq(place,P2)},
    srel/From/place/FromStat/F23, {dmeq([from,after],From)},
    srel/To/place/ToStat/F23,{dmeq([to,before,towards],To)}
id  atday(Day),
    add ( findstations(B52,Day,Stl1),
          keepbetweenstat(B52,FromStat,ToStat,Stl1,Stl2),
          passesstations(B52,Day,Stl2,_S_))
ip  [].


busonroutestoppingbetween  rule  %% TA-110510
 %% hvor stopper buss  .. mellom .. på rute 52
is  which(F22),   F22 isa place, {unbound(F22)},
    srel/Ni/place/F22/F23, {dmeq([in,nil],Ni)},

    Fbus isa Veh1, {unbound(Fbus),dmeq(vehicle,Veh1)},

    doit/Stop/FBus/F23, {dmeq([stop],Stop)}, %% \+ go!!!
    {unbound(FBus)},

    srel/on/route/NBus/_,
    NBus isa Veh, {bound(NBus),dmeq(vehicle,Veh)}, %% nightbus? %% TA-101206

    srel/from/place/FromStat/F23,
    srel/to/place/ToStat/F23,
    FromStat isa P1, {dmeq(place,P1)},
    ToStat   isa P2, {dmeq(place,P2)}
id  atday(Day),
    add ( findstations(NBus,Day,Stl1),
          keepbetweenstat(NBus,FromStat,ToStat,Stl1,Stl2),
          passesstations(NBus,Day,Stl2,_S_))
ip  [].
busstoppingbetween  rule
is  which(F22),   F22 isa place,
    srel/Ni/place/F22/F23, {dmeq([in,nil],Ni)},
    doit/Stop/Bus/F23, {dmeq([stop],Stop)}, %% \+ go!!!
    Bus isa NBus, {bound(Bus)},        %% TA-110510
    {dmeq(vehicle,NBus)}, %% nightbus? %% TA-101206
    srel/from/place/FromStat/F23,
    srel/to/place/ToStat/F23,
    FromStat isa P1, {dmeq(place,P1)},
    ToStat   isa P2, {dmeq(place,P2)}
id  atday(Day),
    add ( findstations(Bus,Day,Stl1),
          keepbetweenstat(Bus,FromStat,ToStat,Stl1,Stl2),
          passesstations(Bus,Day,Stl2,_S_))
ip  [].



passbetween1 rule  %%  Which places does bus N PASS at  between stations
is  ispresent srel/To/place/ToPlace/_,     {dmeq([to,towards],To)},
    not ispresent dob/change/_/_/_,
    ispresent which(Place),  ispresent Place isa station,
    srel/AT/place/Place/A, {dmeq(tofromby,AT),unbound(Place)},
    doit/PASS/Bus/A, {dmeq(pass,PASS)},
    ispresent srel/From/place/FromPlace/_, {dmeq([from,past,dir],From)}
id	 atday(Day),
	 not  findstations(_,_,_), %% busstationsbetween
    add ( findstations(Bus,Day,Stl1),
          keepbetweenstat(Bus,FromStat,ToStat,Stl1,Stl2),
          passesstations(Bus,Day,Stl2,A))
ip	 bus(Bus),
    bus_place_station(Bus,FromPlace,FromStat),  %%  OK if not bus
    bus_place_station(Bus,ToPlace,ToStat).


passbetweenunkbus rule %% Which places does a bus PASS at  between stations
is  ispresent which(Place), { unbound(Place),
                            dmeq(place,Place)},  %%  not side
    srel/AT/place/Place/A, { dmeq(tofromby,AT)},
    PASS1/Bus/A, {dmeq(pass,PASS1),unbound(Bus)},
    ispresent srel/From/place/FromPlace/_,
       {dmeq([from,past,dir],From), bound(FromPlace)},
    ispresent srel/To/place/ToPlace/_,
       {dmeq([to,towards],To), bound(ToPlace)},
    clear
id	 not message(mustknow(bus)),
    clear,
    add message(mustknow(bus))
ip	 [].



passbetw3 rule %% Hack   Has stops between
is  ispresent which(Place),has/vehicle/station/Bus/Place,
    ispresent srel/From/place/FromPlace/_, {  dmeq([from,after,past],From)},
    ispresent srel/To/place/ToPlace/_  ,   {  dmeq([before,to,towards],To)}
id	 not  findstations(_,_,_), %%  busstationsbetween
    atday(Day),
	 add ( findstations(Bus,Day,Stl1),
          keepbetweenstat(Bus,FromStat,ToStat,Stl1,Stl2),
          passesstations(Bus,Day,Stl2,_))
ip	 unbound(Place),exbus(Bus),
    bus_place_station(Bus,FromPlace,FromStat),
    bus_place_station(Bus,ToPlace,ToStat).


statbetweennamed rule %% hva heter holdeplassene  mellom
is  which(F6),   Place isa station,
    (dob/be_named/F6/Place/A  or dob/be_named/Place/F6/A),
    doit/be1/Place/A,
    srel/For/Route/Bus/A,
    srel/From/place/FromPlace/_A1, %  A1=A2, but shunt
    srel/To/place/ToPlace/_A2      %  makes havoc
id  not  findstations(_,_,_), %% busstationsbetween
    atday(Day),
	 add ( findstations(Bus,Day,Stl1),
          keepbetweenstat(Bus,FromStat,ToStat,Stl1,Stl2),
          passesstations(Bus,Day,Stl2,A))
ip  dmeq([from,beyond,after],From), %% etter = from/beyond/after
    dmeq([to,before],To),
    dmeq([for,with,on,to],For),
    dmeq([route,vehicle,bus],Route),
    place_station(FromPlace,FromStat),
    place_station(ToPlace,ToStat),
    unbound(Place),exbus(Bus).


statbetweennamednobus rule
is  which(F6),   Place isa station,
    (dob/be_named/F6/Place/A  or dob/be_named/Place/F6/A),
    not ispresent X isa bus when { bound(X)},
    doit/be1/Place/A,
    srel/From/place/_FromPlace/_A1, %  A1=A2, but shunt
    srel/To/place/_ToPlace/_A2      %  makes havoc
id  add message(mustknow(bus))
ip  dmeq([from,beyond,after],From), %% etter = from/beyond/after
    dmeq([to,before],To),
    unbound(Place).


statbetween1 rule  %% hva er holdeplassene mellom A og B (be2 regime)
is  which(F171),   Place isa station,
    doit/be1/Place/A,
    dob/be/Place/F171/A,
    srel/For/Route/Bus/A,
    srel/From/place/FromPlace/_A1, %  A1=A2, but shunt
    srel/To/place/ToPlace/_A2      %  makes havoc
id  not findstations(_,_,_),
    atday(Day),
	 add ( findstations(Bus,Day,Stl1),
          keepbetweenstat(Bus,FromStat,ToStat,Stl1,Stl2),
          passesstations(Bus,Day,Stl2,A))
ip  dmeq([from,beyond,after],From), %% etter = from/beyond/after
    dmeq([to,before],To),
    dmeq([for,with,on,to],For),
    dmeq([route,vehicle,bus],Route),
    place_station(FromPlace,FromStat),
    place_station(ToPlace,ToStat),
    unbound(Place),exbus(Bus).


statbeforeis rule  %% hva er  holdeplassene før B
is  which(F171),  Place isa station,
    srel/before/place/_ToPlace/_,
    doit/be1/Place/A, dob/be/Place/F171/A
id  add message(mustknow(bus)),
    add message(mustknowanother(place))
ip  [].

statbeforeheter rule  %% hva er/heter  holdeplassene før B
is  which(F100),  Place isa station, { bound(Place)},
    Free isa station, { unbound(Free)},
    srel/before/place/Place/E,
    doit/be1/Free/E, dob/be_named/F100/Free/E
id  add message(mustknow(bus)),
    add message(mustknowanother(place))
ip  [].


statbetweennoroute rule  %% hva er holdeplassene mellom A og B //NO ROUTE
is  which(F171), dob/be/Place/F171/A,   Place isa station,
    doit/be1/Place/A,
    srel/From/place/_FromPlace/_A1, %  A1=A2, but shunt
    srel/To/place/_ToPlace/_A2      %  makes havoc
id  add message(mustknow(bus))
ip  dmeq([from,beyond,after],From), %% etter = from/beyond/after
    dmeq([to,before],To).



statbetween2 rule
is  which(Place), Place isa station,
    doit/be1/Place/A,
    srel/For/Route/Bus/A, {dmeq([for,with,on,to],For)},
    srel/From/place/FromPlace/_A1,  { dmeq([from,beyond,after],From)},
         %% etter = from/beyond/after %  A1=A2, but shunt
    srel/To/place/ToPlace/_A2,    { dmeq([to,before],To)}     %  makes havoc
id  not findstations(_,_,_),
    atday(Day),
	 add ( findstations(Bus,Day,Stl1),
          keepbetweenstat(Bus,FromStat,ToStat,Stl1,Stl2),
          passesstations(Bus,Day,Stl2,A))
ip  dmeq([route,vehicle,bus],Route),
    place_station(FromPlace,FromStat),
    place_station(ToPlace,ToStat),
    unbound(Place),exbus(Bus).


statbetween4 rule %% hva er neste holdeplass etter samfundet .
is  which(S), S isa station, doit/Be1/S/E, {dmeq([be1,exist],Be1)},
    srel/after/place/_/E,
    not ispresent _ isa bus,
    not ispresent _ isa route
id  add message(mustknow(bus))
ip  [].


stationsonroute rule %% moved after passbetween.....
is    which(A),A isa station,Bus isa BR, {dmeq([bus,nightbus,route],BR)},
      doit/be1/A/B, srel/ON/route/Bus/B,
      not X isa station when { bound(X)}
id    atday(Day),
	   add (findstations(Bus,Day,Stl),
      passesstations(Bus,Day,Stl,_))
ip    dmeq([on,at],ON),bound(Bus).


passat1 rule  %% PLASS Which places does a bus PASS at?
is  ispresent which(Place),PASS1/Bus/A,srel/AT/place/Place/A,
    not ispresent _ isa time,
    not ispresent _ isa clock,
    not ispresent srel/_/place/_/_,
    clear %%  only exact,
id	 atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,A))
ip	 dmeq(pass,PASS1),dmeq(tofromby,AT),unbound(Place),exbus(Bus).


pass1 rule %% PLASS Which places does a bus <pass>?
is  which(Place),Place isa place,doit/PASS/Bus/E, srel/dir/place/Place/E,event/real/E
id	 add message(mustknow(bus))
ip	 dmeq(pass,PASS),unbound(Place),unbound(Bus).


stationsarebetweenst rule % hvilke hpl er fra A til B
is  which(F3), F3 isa Station, {dmeq([station,place],Station)}, %% TA-110510
    not X isa bus when{bound(X)},
    not X isa route when{bound(X)},   %% TA-110510
    srel/from/place/_Nardosenteret/F4,srel/to/place/_Torget/F4
id	 not message(foreign(_)),
    add message(mustknow(bus))
ip	 [].

tofrombyq rule % PLASS Which places does a buss <pass> <TOFROMBY>?
is  Place isa station,
    ispresent which(Place),ispresent doit/PASS/Bus/A,ispresent Bus isa BR,
    srel/TOFROMBY/place/Place/A
%%%%%     not srel/_/place/_/_
id	 not message(foreign(_)),
    add message(mustknow(bus))
ip	 dmeq(tofromby,TOFROMBY),unbound(Place),
    dmeq(bus,BR),unbound(Bus),dmeq(pass,PASS) .


%% Where does bus go ??? section %% TA-101029 moveed last

stationsalongroute rule %% TA-101110
is  which(A),(Busno isa route,A isa station,
    event/real/B,srel/Along/route/Busno/B),
   	{dmeq([along,on,in,for],Along)}, %% TA-110622
    not _ isa station,                 %% TA-110622
    not _ isa neigbbourhood            %%
id  not passevent(_,_,_,_,_,_),
	 add (findstations(Busno,Day,Stl),
         passesstations(Busno,Day,Stl,_))
ip	 exbus(Busno).

stationbeforeafterplace rule %% TA-101110
is  which(A),A isa station,doit/be1/A/B,
    event/real/B,srel/Along/place/Ikea/B, Ikea isa station,
   	{dmeq([along,on,in,before,after],Along)},
    not ispresent _Busno isa route %% etc
id  not passevent(_,_,_,_,_,_),
	 add message(mustknow(route))
ip	 [].



whatistraseeforbus  rule % Route for bus meaning trasee // after mustknowplace
is  not ispresent  _ isa date,
    doit/be1/B/E, %%  // do you have %%  busstabell for nr 9.
    B isa ROUTE,
    { dmeq([route,route_plan,information,thing,bus],ROUTE)},
    srel/FOR/BUSV/Bus/E,
    event/real/_E,
    not _ isa day ,  %% etc   NO TIME indication
    not srel/_Pwith/time/_/_,   %%  (detail)
    not ispresent srel/_To/place/_/_
id	 not flag(exit),
    not passevent(_,_,_,_,_,_), %% doesnt help
    not departure(_,_,_,_),
    atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,_))
ip	 exbus(Bus),
    dmeq([bus,nightbus,route,vehicle,thing],BUSV),
    dmeq([for,to,over,regarding],FOR).


traseeforbus  rule %  trase for nr 9. Route for bus meaning trasee
is  not ispresent _ isa date,
    not ispresent _ isa time,
    srel/FOR/BUSV/Bus/E, {bound(Bus)},
       {dmeq([for,to,over,regarding,at   ,nil],FOR)}, % at=along %% TA-110527
       {dmeq([bus,nightbus,route,vehicle,thing],BUSV)},
    Bus isa ROUTE,
    {dmeq([route,route_plan,information,thing,bus],ROUTE)},
    event/real/E,
    not _ isa day ,  %% etc   NO TIME indication
    not srel/_Pwith/time/_/_,   %%  (detail)
    not ispresent srel/_To/place/_/_
id	 not flag(exit),
    not passevent(_,_,_,_,_,_), %% doesnt help
    not departure(_,_,_,_),
    atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,_))
ip	 exbus(Bus).


%% END SECTION HOLDEPLASSER


%%%%%%%%%%%%% Bussoverganger %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

change1 rule % Hvor kan man CHANGE fra Buss1 til Buss2
is  which(Station),dob/CHANGE/_/Station/C,
    srel/TOFROMBY1/bus/Bus1/C,srel/TOFROMBY2/bus/Bus2/C
id  atday(Day),
    add (findstations(Bus1,Day,Stl1),
			findstations(Bus2,Day,Stl2),
			corrstats(Stl1,Stl2,StlBoth),
			passesstations([Bus1,Bus2],Day,StlBoth,C))
ip  dmeq(change,CHANGE),
    dmeq(tofromby,TOFROMBY1),dmeq(tofromby,TOFROMBY2),
    exbus(Bus1),exbus(Bus2).


meet2 rule % Where does Bus1 and Bus2 meet?
is  which(Stat),meet2/(Bus1,Bus2)/B,srel/in/place/Stat/B
id  atday(Day),
    add (findstations(Bus1,Day,Stl1),
			findstations(Bus2,Day,Stl2),
			corrstats(Stl1,Stl2,StlBoth),
			passesstations([Bus1,Bus2],Day,StlBoth,B))
ip  exbus(Bus1),exbus(Bus2).


samefplace2 rule %% Avoid question if same place
is  srel/From/place/StartPlace/D1, %% not "removed from saw%% 1	 context only
    {StartPlace \== nil}, %%  der
    context srel/To/place/EndPlace/D2, { To \== From, D1==D2}, %% and be at=D1\=D2
    {EndPlace \== nil},
    not _ isa airport %% Th airport
id  add (message(sameplace(StartPlace,EndPlace)))  %% not urgent
ip  atomic(StartPlace), atomic(EndPlace),
    dmeq([to,for,in,from],To),
    main:samefplace(StartPlace,EndPlace).


samefplace2b rule
is  context srel/To/place/EndPlace/_D1, %% not "removed from s(c)een
    not _ isa airport, %% Th airport
    dob/leave/_Bus/StartPlace/_D2
id  add (message(sameplace(StartPlace,EndPlace)))  %% not urgent
ip  atomic(StartPlace), atomic(EndPlace),
    dmeq([to,for],To),main:samefplace(StartPlace,EndPlace).

samefplace3 rule
is context srel/From/place/StartPlace/_D1, %% not "removed from s(c)een
   not _ isa airport, %% Th airport
   srel/at/place/EndPlace/_D2
id add (message(sameplace(StartPlace,EndPlace)))  %% not urgent
ip atomic(StartPlace), atomic(EndPlace),
   main:samefplace(StartPlace,EndPlace),
   From \== at. %% Different prepositions


samefplace4 rule
is context srel/_Prep1/place/StartPlace/_D1,
   srel/_Prep2/place/EndPlace/_D2,
    not _ isa airport %% The airport
id add (message(sameplace(StartPlace,EndPlace)))
ip  atomic(StartPlace), atomic(EndPlace),
   (\+ StartPlace = EndPlace,
    main:samefplace(StartPlace,EndPlace)).


samefplace5 rule  %%
is  doit/pass/_X/E,
    srel/_Prep/place/EndPlace/E
id  add (message(sameplace(StartPlace,EndPlace)))
ip  atomic(StartPlace), atomic(EndPlace),
    main:samefplace(StartPlace,EndPlace).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Stasjonspasseringsdel. Her blir departure/passevent laget
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%% Stasjonspasseringsspesialregler som sikrer riktig rekkefølge...

leavename rule %% Does a bus LEAVE a place?
is  dob/LEAVE/Bus/Place/A, ispresent Bus isa Veh
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[],Day,A)) %%   leave is neutral wrp direction
ip	 bound(Place),dmeq(vehicle,Veh),
    dmeq(leave,LEAVE),busorfree(Bus),
    bus_place_station(Bus,Place,Stat).

%%%%%%%%%%%%% take the bus


sometakebusfrom rule % someone take the bus FROM a place
is  ispresent dob/USE/X/Bus/A, {X \== it}, %% .. tid tar det
    srel/FROM/place/Place/A
id	 not flag(exit),
    atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[from],Day,A))
ip  dmeq(from,FROM),dmeq(use,USE),busorfree(Bus),
        bus_place_station(Bus,Place,Stat).


bustakemefrom rule % Bus take me
is  ispresent dob/take/Bus/_/C,ispresent Bus isa bus,srel/FROM/place/Place/C
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[from],Day,C))
ip  dmeq(from,FROM),place_station(Place,Stat),
    busorfree(Bus).


bustakemebyto rule % Bus take me by = to
is  ispresent dob/take/Bus/_/C,ispresent Bus isa bus,srel/BY/place/Place/C,
    ispresent srel/from/place/_/_  %% to antother place
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[to],Day,C))
ip  dmeq(by,BY),place_station(Place,Stat),busorfree(Bus).


bustakemebyfrom rule % Bus take me by = from (Deafult)
is  ispresent dob/take/Bus/_/C,ispresent Bus isa bus,srel/BY/place/Place/C
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[from],Day,C))
ip  dmeq(by,BY),place_station(Place,Stat),busorfree(Bus).


takefrom rule % take FROM
is  ispresent dob/take/X/_/C, {X \== it},
    srel/FROM/place/Place/C
id	 not flag(exit),
    atday(Day),atdate2(DaySeqNo,_Date),
    add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[from],Day,C))   %% same event C !
ip  dmeq(from,FROM),newfree(Bus),place_station(Place,Stat).

sometake1 rule % someone take the bus BY a place
is  ispresent dob/take/_/Bus/A,srel/BY/place/Place/A
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[],Day,A))
ip  dmeq(by,BY),busorfree(Bus),
    bus_place_station(Bus,Place,Stat).


takeby rule % take BY
is  ispresent dob/take/_/_/C,srel/BY/place/Place/C
id	 atday(Day),atdate2(DaySeqNo,_Date),
    add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[],Day,C)) %% same event C !
ip  dmeq(by,BY),place_station(Place,Stat),newfree(Bus).


bustaketime  rule % bus takes time -> bus goes with duration
is  replaceall ( dob/USE/Bus/T/A, B isa Veh, T isa duration)
    with       ( doit/go/Bus/A, srel/pwith/duration/T/A, B isa bus, T isa duration),
    {dmeq([use,take,  use2],USE)}, %% use2 is unsensical
    {dmeq(vehicle,Veh)}
id	 []
ip  [].


sometake2take rule % someone take the bus TO a place
is  ispresent dob/USE/X/Bus/A, {X \== it},
    srel/TO/place/Place/A
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[to],Day,A))
ip  dmeq(to,TO),dmeq(use,USE),place_station(Place,Stat),busorfree(Bus).


takeme rule % Bus take me to
is  ispresent dob/take/Bus/_/C,ispresent Bus isa bus,srel/TO/place/Place/C
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[to],Day,C))
ip  dmeq(to,TO),place_station(Place,Stat),busorfree(Bus).


taketo rule % take TO
is  ispresent dob/take/X/_/C, {X \== it}, %%  ..  tid tar det
    srel/TO/place/Place/C
id	 atday(Day),atdate2(DaySeqNo,_Date),
    add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[to],Day,C))
ip  dmeq(to,TO),place_station(Place,Stat),newfree(Bus).


%%%%%%%%%%%%% doit/PASS/TRAVEL/be1 etc. FROM

leavaplace rule % when Does a bus LEAVE a place? (Place is unbound)
is  exactly (which(Time),Bus isa bus, Time isa Timeq,
        dob/LEAVE/Bus/Place/C,event/real/C,srel/in/time/Time/C)
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Place,DaySeqNo,Depset),
			passevent(Depset,Bus,Place,[from],Day,C))
ip	 unbound(Place),dmeq(leave,LEAVE),dmeq(time,Timeq).


passfrom2 rule % Do I PASS FROM a place with bus Bus ?
is  Bus isa bus,I isa self,
    doit/Go/I/A,{dmeq([go,come,travel],Go)}, %% TA-100831
    srel/Prep/place/Place/A,
    srel/pwith/vehicle/Bus/A
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[Prep],Day,A))
ip  dmeq([from],Prep),
    busorfree(Bus),bus_place_station(Bus,Place,Stat).


passdir rule % I pass Place to/from Another place
is  context (Pass/Cat/B),
    srel/dir/place/Place/B,
    ispresent Cat isa BVP,
%%     not ispresent  srel/to/place/_/_
    not ispresent  srel/from/place/_/_
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Cat,Stat,DaySeqNo,Depset),
         passevent(Depset,Cat,Stat,[from],Day,B)) %% Default
ip  dmeq([pass,reach],Pass),
    dmeq(trafficant,BVP),
    place_station(Place,Stat).


passtofrom rule % I pass Place to/from Another place
is  context (Pass/Cat/B), %% only 1
    srel/FROMTO/place/Place/B,
    ispresent Cat isa BVP
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[FROMTO],Day,B))
ip  dmeq([from,to],FROMTO),
    dmeq([pass,reach],Pass),
    notbothfree(Bus,Place),
    dmeq(trafficant,BVP),
    bus_place_station(Cat,Place,Stat),newfree(Bus).


passfrom5 rule % Can someone TRAVEL FROM a place a time?
is  ispresent doit/TRAVEL/_/Time/B,srel/FROM/place/Place/B
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         keepafter(Time,Depset,NewDepset), %% keepat
			passevent(NewDepset,Bus,Stat,[from],Day,B))
ip  dmeq(travel,TRAVEL),dmeq(from,FROM),
    place_station(Place,Stat),number(Time),newfree(Bus).


leave1 rule % is a Place  bus LEAVEing a place?
is  ispresent Bus isa bus,ispresent dob/LEAVE/Bus/_,
    adj/_/Place/Bus/A %% NB, Place is a PLACE
id	 atday(Day), atdate2(DaySeqNo,_Date),                                            %% NOT next, etc.
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[from],Day,A))
ip	 dmeq(leave,LEAVE), busorfree(Bus),
    bus_place_station(Bus,Place,Stat).


leave2 rule % Does a bus LEAVE a place? %%  leave is noe neutral wrp direction
is  dob/LEAVE/Bus/Place/A, ispresent Bus isa Veh
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[],Day,A))
ip  dmeq(leave,LEAVE),
    dmeq(vehicle,Veh),
    busorfree(Bus),
    bus_place_station(Bus,Place,Stat).


wayfrom rule % raskeste vei fra
is  Way isa street,
    ispresent doit/be1/Way/C,srel/FROM/Xplace/Place/C, % place/city
                      { dmeq([place,city,street,station],Xplace)}
id	 not findstations(_,_,_),
    atday(Day),atdate2(DaySeqNo,_Date),
         not   passevent(_,_,_,[from],_,_),    %%  NOT 2 FROMS
         not   connections(_,_,_,_,_,_,_,_,_,_), %% finished
	 add (departure(Bus,Station,DaySeqNo,Depset),
         passevent(Depset,Bus,Station,[from],Day,C))
ip	 dmeq(from,FROM),
    newfree(Bus),
    bus_place_station(Bus,Place,Station).

bedurationfrom rule %% varighet fra ..
is  ispresent _F1 isa duration,
    srel/FROM/Xplace/Place/C, % place/city
                      { dmeq([place,city],Xplace)},
    not comp/vehicle/ne/_/Bus,
    not comp/number/ne/_/Bus,
    not ispresent _ isa information %% Ad Hoc
id	 not flag(exit),
    not findstations(_,_,_),
    atday(Day),atdate2(DaySeqNo,_Date),
         not   passevent(_,_,_,[from],_,_),    %%  NOT 2 FROMS
         not   connections(_,_,_,_,_,_,_,_,_,_), %% finished
	 add (departure(Bus,Station,DaySeqNo,Depset),
         passevent(Depset,Bus,Station,[from],Day,C))
ip	 dmeq(from,FROM),     % raskeste vei = street     %%
    place_station(Place,Station).



befrom rule % be FROM
is  ispresent Bus isa BR,
    ispresent doit/be1/Bus/C,srel/FROM/Xplace/Place/C, % place/city
                      { dmeq([place,city],Xplace)},
    not comp/vehicle/ne/_/Bus,
    not comp/number/ne/_/Bus,
    not ispresent _ isa information %% Ad Hoc
id	 not flag(exit),
    not findstations(_,_,_),
    atday(Day),atdate2(DaySeqNo,_Date),
         not   passevent(_,_,_,[from],_,_),    %%  NOT 2 FROMS
         not   connections(_,_,_,_,_,_,_,_,_,_), %% finished
	 add (departure(Bus,Station,DaySeqNo,Depset),
         passevent(Depset,Bus,Station,[from],Day,C))
ip	 dmeq([bus,nightbus,route,route_plan,vehicle,direction,tram,trip],BR),
    dmeq(from,FROM),                   % raskeste vei = street     %%
    busorfree(Bus),
    bus_place_station(Bus,Place,Station).


%% Insanerule %%  before beto %% Dragvoll1 may be street
nevergowithtomessage  rule %% after toplace1 (in case of  depend)
is  ispresent srel/pwith/vehicle/Bus36/B,
    ispresent Bus36 isa BVP,  { bound(Bus36), dmeq(vehicle,BVP)},
    ispresent srel/TO/place/Dragvoll1/X,  %% (see retention)
         {dmeq([for,in,on,to,towards,outside,nil,dir,near,past],TO)},
    ispresent Dragvoll1 isa SN, { bound(Dragvoll1)},
         { dmeq([station,neighbourhood,street],SN)},
    not ispresent doit/start/_/X,  %% start to go special
        { bus_place_station(Bus36,Dragvoll1,NTNU_Dragvoll) }
id  not  message(neverpasses(Bus36,Dragvoll)), %% retention
    atday(Day),atdate2(DaySeqNo,_Date),
    not connections(_,_,_,_,_,_,_,_,_,_),

    not departure(_,Dragvoll,_,_),     % not already allocated Risvollan
    not departure(_,NTNU_Dragvoll,_,_),% nor to                Risvollansenteret

    not passevent(_depset,_bus,_Station,Opts,_day,_b) when {  testmember(to,Opts)},
    not passevent(_depset,_bus,Dragvoll,Opts,_day,_b) when { testmember(to,Opts)},

    add (departure(Bus,Dragvoll,DaySeqNo,Depset),
         passevent(Depset,Bus,Dragvoll,[to],Day,B)),
    add message(neverpasses(Bus36,Dragvoll))
ip  neverpasses(Bus36,Dragvoll),
    newfree(Bus).


totoplacesameevent rule % to nth to risvollan  %% before beto
is  not ispresent srel/nil/place/_/_,
    not ispresent srel/from/place/_/_ ,
    replaceall (srel/to/place/Place1/E,srel/to/place/Place2/E)
    with       (srel/from/place/Place1/E,srel/to/place/Place2/E)
id  []
ip  [].


totoplacediffevent rule % skal til nth og skal til risvollan %% %% before beto
is  not ispresent srel/nil/place/_/_,
    not ispresent srel/from/place/_/_ ,
    replaceall (srel/to/place/Place1/E,srel/to/place/Place2/F)
    with       (srel/from/place/Place1/E,srel/to/place/Place2/F)
id  add message(onlyonedestination)
ip  [].

bedurationto rule %% varighet til ..
is  ispresent _F1 isa duration,
    ispresent doit/Be1/Bus/_C,  {dmeq([be1,exist],Be1)},           %% raskeste vei = street
    srel/to/Xplace/Place/C, {dmeq([place,city,station,neighbourhood],Xplace)},

    not comp/_Number/ne/_/Bus,
    not ispresent srel/except/_/Bus/_

id  not flag(exit),
    not findstations(_,_,_),
    atday(Day),atdate2(DaySeqNo,_Date),
    not passevent(_,_bus,Place,_,_,_),    %% at least not Place
    not passevent(_,_bus,_AnyPlace,[to],_,_),
    not connections(_,_,_,_,_,_,_,_,_,_),  %%  already identical name
    add (departure(Bus,Station,DaySeqNo,Depset),
         passevent(Depset,Bus,Station,[to],Day,C))
ip  place_station(Place,Station),
    Station \== unknown.


bepastfrom rule %% %% Bus past a station probably means that you are at station
is  srel/Past/Xplace/Place/C, { dmeq([past,at,by,dir],Past),
                                dmeq([place,city],Xplace)},
    ispresent Bus isa BR, { dmeq(bus,BR)},  %% disprefer departure
    ispresent doit/Be1/Bus/_C,
    not comp/_Number/ne/_/Bus
id  atday(Day), atdate2(DaySeqNo,_Date),
    not passevent(_,Bus,Place,_,_,_),     %% same place
    passevent(_,Bus,_Place,[to],_,_), %% if already to, past	 means FROM
    not connections(_,_,_,_,_,_,_,_,_,_),
    add (departure(Bus,Station,DaySeqNo,Depset),
         passevent(Depset,Bus,Station,[from],Day,C))
ip  dmeq([be1,exist],Be1),
    busorfree(Bus),bus_place_station(Bus,Place,Station),
    Station \== unknown.


arrdep0 rule  % arr dep
is  has/bus/ARRDEP/Bus/_,adj/_/Place/Bus/E %% same event E
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
        passevent(Depset,Bus,Stat,[],Day,E))
ip	 dmeq(arrdep,ARRDEP),busorfree(Bus),
    bus_place_station(Bus,Place,Stat).


listdeparture rule  % list departures
is    test, tuc isa savant,dob/list/tuc/A/_,
      A isa Departure, %%%   doit/be1/A/E,
      srel/for/_/Bus/_E, Bus isa BR,
      clear     %% \+  MIX
id    atday(Day),
	   add (findstations(Bus,Day,Stl),
      passesstations(Bus,Day,Stl,_))
ip    bound(Bus),  dmeq(bus,BR),
      dmeq([departure,route_plan,route],Departure).


sorttofrom rule %%   in/place to/place ==> from/place to/place
is  not ispresent adj/_/nearest/_/_ , %% nearest to %% Ad Hoc
    not ispresent srel/from/place/_/_,
    replaceall (srel/in/place/M/E,  srel/to/place/S/E)
    with       (srel/from/place/M/E,srel/to/place/S/E)
id  []
ip  M \== S.

% % % % %



toplaceobviously rule % toplace obviously
is  context Bus isa BVP,    %% don't hide the very bus number ispresent ???
    context  doit/TRAVEL/Bus/B,
    srel/to/_/Place/X,
    not ispresent doit/start/_/X
id  atday(Day),atdate2(DaySeqNo,_Date),
    not  passevent(_,_,_,_,_,_), %% departure(_,Place,_,_),   % not already allocated
    add (departure(Bus,Station,DaySeqNo,Depset),
         passevent(Depset,Bus,Station,[to],Day,B))
ip  dmeq(travel,TRAVEL),
    dmeq(trafficant,BVP),   %% not cat, not bus ?????
    place_station(Place,Station), Station \== unknown,
    newfree(Bus).



fromfromplace rule % fra nth fra risvollan   %% (?)
is  not ispresent srel/nil/_/_/_,
    not ispresent srel/to/_/_/_ ,
    replaceall (srel/from/place/Place1/E,srel/from/place/Place2/E)
    with       (srel/from/place/Place1/E,srel/to/place/Place2/E)
id  []
ip  [].


%% NILPLACE SECTION

%% IF already FROM then NIL means TO
nilplaceeqtodialog  rule %%   nth (from risvollan)   TO NTH (from risvollan) //FIRST
is  srel/nil/_/Place/_, ispresent doit/TRAVELBE/Cat/B,
    not ispresent _ isa departure,
    not ispresent srel/to/place/_/_,  %% \+ "to time" Norw
    not ispresent srel/towards/place/_/_,
    ispresent Cat isa BVP
id  atday(Day),atdate2(DaySeqNo,_Date),
    not   passevent(_,_,_,[to],_,_),
    not   connections(_,_,_,_,_,_,_,_,_,_), %% finished
    not  departure(Bus,Place,DaySeqNo,Depset),
    add (departure(Bus,Station,DaySeqNo,Depset),
         passevent(Depset,Bus,Station,[to],Day,B))
ip  dmeq(travelbe,TRAVELBE),
    dmeq(trafficant,BVP),
    place_station(Place,Station), Station \== unknown,
    i_or_a_bus(Cat,BVP,Bus),
    \+ main:frame_getvalue(where::arrival,_,_) %% <-- NB
:-double.


nilplacetoeqfromdialog rule % nth to risvollan   %% IF already TO then NIL means FROM
is  srel/nil/_/Place/_,
    ispresent srel/to/place/_ /_,
    ispresent doit/TRAVELBE/Cat/B,
    not ispresent srel/from/place/_/_ ,
    ispresent Cat isa BVP
id  atday(Day),atdate2(DaySeqNo,_Date),
    not   passevent(_,_,_,[from],_,_),
    not   connections(_,_,_,_,_,_,_,_,_,_), %% finished
    not  departure(Bus,Place,DaySeqNo,Depset),
    add (departure(Bus,Station,DaySeqNo,Depset),
         passevent(Depset,Bus,Station,[from],Day,B))
ip  dmeq(travelbe,TRAVELBE),
    dmeq(trafficant,BVP),
    bus_place_station(Cat,Place,Station), %%   90 risvollankrysset
    Station \== unknown,
    i_or_a_bus(Cat,BVP,Bus)
:-double.


nilplaceemptyeqfromdialog rule % nth to risvollan   %% IF not already TO, not from, = from if NOT in frame
is  srel/nil/_/Place/_,
    ispresent doit/TRAVELBE/Cat/B,
    not ispresent srel/from/place/_/_ ,
    not ispresent srel/to/place/_/_ ,
    ispresent Cat isa BVP
id  atday(Day),atdate2(DaySeqNo,_Date),
    not   passevent(_,_,_,[from],_,_),
    not   connections(_,_,_,_,_,_,_,_,_,_), %% finished
    not  departure(Bus,Place,DaySeqNo,Depset),
    add (departure(Bus,Station,DaySeqNo,Depset),
         passevent(Depset,Bus,Station,[from],Day,B))
ip  dmeq(travelbe,TRAVELBE),
    dmeq(trafficant,BVP),
    bus_place_station(Cat,Place,Station), %%   90 risvollankrysset
    Station \== unknown,
    i_or_a_bus(Cat,BVP,Bus),
    \+ main:frame_getvalue(where::departure,_,_) %% <-- NB
:-double.


nilplacetrondheim rule %%   buss trondheim
is  srel/nil/_/Place/_,        {home_town(Place)},
    ispresent doit/TRAVELBE/Cat/_, {dmeq(travelbe,TRAVELBE)},
    ispresent Cat isa BVP,
    not ispresent _ isa departure,
    not ispresent srel/to/_/_/_,
    not ispresent srel/towards/_/_/_
id  add message(mustknow(place))
ip  dmeq(trafficant,BVP)
:-single.

pastplaceeqfromreplace  rule  %%  forbi markus tranesvei til kvt.
is  not ispresent srel/from/place/_/_ ,
    ispresent srel/TO/place/_/_, {dmeq([to,towards],TO)},
%%     not ispresent srel/to/place/_/_ ,   %% ABV kl 22.03 til S

    replace srel/past/place/Place/E  %%    markus tranesvei til kvt.
    with    srel/from/place/Place/E , {bound(Place)}, %%  hvor er du fra
       not ispresent dob/avoid/_/_/_,
       not ispresent _ isa arrival
id  not flag(exit)
ip  []
:-single.

nilplaceeqfromreplace  rule  %%  markus tranesvei til kvt.// MUST have TO
is  not ispresent srel/from/place/_/_ ,
    ispresent srel/nil/Placoid/Place/_,  {bound(Place)}, %%  hvor er du fra,

        {dmeq([place,station],Placoid)}, %% TA-110405 buss ila studentersamfunnet
                        %% nrel/nil/vehicle/station/free(27)/ila -> srel/nil/station/ila/free(28),
     ispresent srel/TO/place/_/_, {dmeq([to,towards],TO)},

     not ispresent dob/avoid/_/_/_,
     not ispresent _ isa arrival,

    replace srel/nil/Placoid/Place/E  %%    markus tranesvei til kvt.
    with    srel/from/place/Place/E

id  not flag(exit)
ip  []
:-single.


nilplacetimeeqfrom rule %% IF time (and only 1 place ) then Nil -> From
is  doit/TRAVELBE/Cat/E,
       {\+ member(TRAVELBE,[arrive,come])},
   {dmeq(travelbe,TRAVELBE)}, %% is it used up ?
    ispresent srel/Nil/P/place/E , %% NOT time ! %% TA-100829
      { dmeq([nil,past,by,through,at],Nil)},
    ispresent _ isa clock,
    not ispresent dob/avoid/_/_/_,
    not ispresent srel/from/place/_/_ ,
    not ispresent _ isa arrival, %% unless arrival
    ispresent Cat isa BVP,   {dmeq(trafficant,BVP)},
    replaceall (srel/Nil/P/place/E) with
               (srel/from/P/place/E)
id  not flag(exit)
ip  []
:-single.


nilplacenotimeeqtoreplace  rule  %% IF no time (and only 1 place ) then S->Place
is  not ispresent _ isa clock,
%%  not ispresent adj/_/next/_/_, %% next means at station %neste buss fra nardo nth.
    not ispresent dob/avoid/_/_/_,
    not ispresent _ isa arrival,   %% ankomst flybuss lerkendal
    not ispresent _ isa departure, %% unless departure
    not ispresent srel/to/place/_/_ ,
    not ispresent srel/in/place/_/_,
    not ispresent srel/in_order_to/_/_,
    not ispresent srel/to/place/_/_ ,
    not ispresent srel/towards/place/_/_ ,

    replace srel/nil/Q/place/R
    with    srel/to/Q/place/R
id  []
ip  []
:-single.


nilplaceeqto rule %%   nth (from risvollan)   TO NTH (from risvollan) //FIRST
is  srel/nil/Plass/Place/_,  %% NOT coevent
       {dmeq([place,station,neighbourhood],Plass)}, %% ANOMALY
    not ispresent adj/_/next/_/_, %% next means at station
%%%     { \+ main:myflags(airbusflag,true)},  %% DIRTY   %% ankomst flybuss lerkendal.
    ispresent doit/TRAVELBE/Cat/B, { dmeq(travelbe,TRAVELBE)},
    not ispresent _ isa departure,
    not ispresent _ isa arrival,  %% ankomst flybuss lerkendal
    not ispresent srel/to/place/_/_,       %% "to time"
    not ispresent srel/to/_/_/_,  %% til D %% NSB qua company %% TA-101215
    not ispresent srel/towards/place/_/_,  %%
    not ispresent srel/in/place/_/_,       %%  bussen nth for å være i nardo.

    ispresent Cat isa BVP,{dmeq(trafficant,BVP)}
id  atday(Day),atdate2(DaySeqNo,_Date),
    not   passevent(_,_,_,[to],_,_),
    not   connections(_,_,_,_,_,_,_,_,_,_), %% finished
    not  departure(Bus,Place,_,_),
    add (departure(Bus,Station,DaySeqNo,Depset),
         passevent(Depset,Bus,Station,[to],Day,B))
ip  bus_place_station(Cat,Place,Station),  %%  bus_
         Station \== unknown,
    i_or_a_bus(Cat,BVP,Bus),
   \+ neverpasses(Cat,Station)  %% buss 5 from ila to dokkparken.

:-single.



%%% END NILPLACE SECTION




hasarrivaltoplace rule %%  Baroque
is  srel/TO/place/Place/_ ,      %%  Too Restricted ?
    {    dmeq([to],TO)},    %%
    ispresent  has/agent/BusArr/_I/_, {dmeq([bus,arrival],BusArr)}
id  atday(Day),atdate2(DaySeqNo,_Date),
    not   passevent(_,_,_,[to],_,_),
    not   connections(_,_,_,_,_,_,_,_,_,_), %% finished
    not  departure(Bus,Place,DaySeqNo,Depset),
    add (departure(Bus,Station,DaySeqNo,Depset),
         passevent(Depset,Bus,Station,[to],Day,free(0)))
ip  place_station(Place,Station),   Station \== unknown.


hasdeparturefromplace rule %%  Baroque
is  srel/FROM/place/Place/_ ,  {dmeq([from,after,around],FROM)},
    has/agent/BusDep/_I/_,     {dmeq([bus,departure],BusDep)}
id  atday(Day),atdate2(DaySeqNo,_Date),
    not   passevent(_,_,_,[from],_,_),
    not   connections(_,_,_,_,_,_,_,_,_,_), %% finished
    not  departure(Bus,Place,DaySeqNo,Depset),
    add (departure(Bus,Station,DaySeqNo,Depset),
         passevent(Depset,Bus,Station,[from],Day,free(0)))
ip  place_station(Place,Station),   Station \== unknown.


fromplace1 rule % someone TRAVEL FROM a place?
is  srel/FROM/place/Place/_ ,   %%  Too Restricted ?
      { dmeq([after,around,from    ],FROM)}, %%,on %% fra skansen for a vaere pa ostre berg 1530
                                            %% er jeg på nardo %%   %% in depart in = from
                                            %% Jeg bor i sentrum og skal  fra heimdal
                                            %% not in
    ispresent doit/TRAVELFROM/Cat/B, { dmeq(travelfrom,TRAVELFROM)},
    ispresent Cat isa BVP, {dmeq(trafficant,BVP)} %% hvilke busser går forbi IKEA = to

id  not flag(exit),
    not findstations(_,_,_),
    not passevent(_,_,_,[from],_,_),
    not connections(_,_,_,_,_,_,_,_,_,_),  %% finished
    not departure(Bus,Place,DaySeqNo,_Depset),
    atday(Day), atdate2(DaySeqNo,_Date),
    add (departure(Bus,Station,    DaySeqNo   ,Depset),  %% DaySeqNo = Day
         passevent(Depset,Bus,Station,[from],Day,B))
ip  bus_place_station(Cat,Place,Station), %% OK if not bus
    Station \== unknown,
     \+ neverpasses(Cat,Station), %% TA-110105
    i_or_a_bus(Cat,BVP,Bus).


neverpassfromessage  rule %%  after fromplace1 in case of depend
is  srel/FROM/place/Place/X,  { dmeq([from],FROM)},
    ispresent Place isa SN,
        {bound(Place), dmeq([station,neighbourhood,street],SN)},
    ispresent doit/TRAVELBE/Cat/B, { dmeq(travelbe,TRAVELBE)},
    ispresent Cat isa BVP,    { bound(Cat), dmeq(vehicle,BVP)},
    not ispresent doit/start/_/X   %% start to go special
id  atday(Day),atdate2(DaySeqNo,_Date),
    not connections(_,_,_,_,_,_,_,_,_,_),
    not departure(_,Place,_,_),   % not already allocated// OBS to Risvollan//Risvollansenteret
    not passevent(_depset,_bus,Station,Opts,_day,_b) when  {  testmember(from,Opts)},
    not passevent(_depset,_bus,Place,Opts,_day,_b) when { testmember(from,Opts)},
    add (departure(Bus,Station,DaySeqNo,Depset),
         passevent(Depset,Bus,Station,[from],Day,B)),
    add message(neverpasses(Cat,Place))
ip  neverpasses(Cat,Place),
    newfree(Bus),
    place_station(Place,Station).


befromplace rule % and ...  I am on NTH and ...
is  doit/be1/Agent/_,
    Agent isa Whatever, %% bussholdeplassen på risvollansenteret
    srel/on/place/Place/C,
    ispresent doit/go/Agent/C
id  atday(Day),atdate2(DaySeqNo,_Date),
    not passevent(_,_,Place,_,_,_),
    add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[from],Day,C))
ip  i_or_a_bus(Agent,Whatever,Bus),
    bus_place_station(Bus,Place,Stat),
    Stat \== unknown.


busnotoplacetowards rule  %% Does a bus TRAVEL TO a place TOWARDS a place ?
is   context srel/towards/place/_/_,
     srel/to/place/Place/C, %% actually from
     ispresent doit/TRAVEL/Bus/C,
     ispresent Bus isa BUS
id   atday(Day),atdate2(DaySeqNo,_Date),
     not passevent(_,_,_,[from],_,_), %% already (Panic)
     add (departure(Bus,Stat,DaySeqNo,Depset),
          passevent(Depset,Bus,Stat,[from],Day,C))
ip  dmeq(travel,TRAVEL),
    dmeq([bus,nightbus,self,agent,route,departure,tram,it,connection],BUS),
    busorfree(Bus),
    bus_place_station(Bus,Place,Stat),
    Stat \== unknown.

busforto rule  %% Does a bus TRAVEL FOR  a place TO a place ?
is   context srel/to/place/_/_,
     srel/for/place/Place/C, %% actually from
     ispresent doit/TRAVEL/Bus/C,
     ispresent Bus isa BUS
id   atday(Day),atdate2(DaySeqNo,_Date),
     not passevent(_,_,_,[from],_,_), %% already (Panic)
     add (departure(Bus,Stat,DaySeqNo,Depset),
          passevent(Depset,Bus,Stat,[from],Day,C))
ip  dmeq(travel,TRAVEL),
    dmeq([bus,nightbus,self,agent,route,departure,tram,it,connection],BUS),
    busorfree(Bus),
    bus_place_station(Bus,Place,Stat),
    Stat \== unknown.


iamin rule %% I am in Risvollan
is  replaceall (I isa self,doit/be1/I/E,srel/in/place/N/E)
    with       (I isa self,doit/go/I/E,srel/from/place/N/E) %% ... Restrictions
id  []
ip  [].

arrivesnil rule %% arrrive dragvoll = go to dragvoll %% TA-101108
is  replaceall (doit/arrive/I/F5,srel/nil/place/Dragvoll/F5)
    with       (doit/go/I/F5,srel/to/place/Dragvoll/F5)
id  []
ip  [].

frem1 rule %% fram i edgar b sjeldropsvei kl 19.
is
    replaceall (srel/in/time/_Time/E,srel/On/place/D/E)
    with       (doit/go/'I'/E,srel/to/place/D/E),
    {dmeq([on,at,in],On)},
    not ispresent srel/to/place/D/E %% TA-110825

id  []
ip  [].

fremme1 rule %% framme i edgar b sjeldropsvei kl 19.
is  replaceall (srel/there/place/nil/E,srel/On/place/D/E)
    with       (doit/go/'I'/E,srel/to/place/D/E),
    {dmeq([on,at,in],On)}
id  []
ip  [].

fremme2 rule %% %% fremme på dragvoll %% TA-101108
is  replaceall (adj/nil/present/I/E,srel/On/place/D/E)
    with       (doit/go/I/E,srel/to/place/D/E),
    {dmeq([on,at,in],On)}
id  []
ip  [].


tohomeon rule %% til "hjem" på Dalen hageby %% TA-110330
is replaceall (srel/to/place/Free74/Free75,srel/on/place/Dalen_hageby/Free75,Free74 isa home)
   with       (srel/to/place/Dalen_hageby/Free75)
id []
ip [].


toplace1 rule  %% Jeg er på lade og skal til dragvoll ==> TO dragvoll
is  srel/TO/PC/Place/X,
      {dmeq([to,at,for,near,outside,towards,dir,  on, along	],TO)}, %% TA-100930

       %% \+ in   ambiguous if to occurs otherwise

     {dmeq([place,company,agent,station],PC)}, %% TA-110401 %% expensive

    not has/agent/_Departure/_Tuc/_/_,
    ispresent Cat isa BVP,   {dmeq(trafficant,BVP)},
    ispresent doit/TRAVELTO/Cat/B,  {dmeq(travelto,TRAVELTO)},
    not ispresent doit/start/_/X   %% start to go special
id  not flag(exit),
    not findstations(_,_,_),
    not  connections(_,_,_,_,_,_,_,_,_,_),
    not  departure(_,Place,_,_),   % not already allocated// OBS to Risvollan//Risvollansenteret
    not passevent(_depset,_bus,Station,Opts,_day,_b) when {  testmember(to,Opts)},
    not passevent(_depset,_bus,Place,Opts,_day,_b) when { testmember(to,Opts)},
    atday(Day),atdate2(DaySeqNo,_Date),
    add (departure(AnyBus,Station,    DaySeqNo   ,Depset),  %% DaySeqNo Day
         passevent(Depset,AnyBus,Station,[to],Day,B))
ip  i_or_a_bus(Cat,BVP,Bus),
    newfree(AnyBus), %%% (AnyBus=Cat), <--- ToBus not bound by FromBus
    bus_place_station(Bus,Place,Station),  %% \+ Trondheim
    \+ neverpasses(Cat,Station). %% buss 5 from ila to dokkparken.


%% TA-110509    buss  43 fra romolslia til jarleveien.
neverpasstostreet rule
is  ispresent srel/TO/Plass/Jarlestreet/X,
        {dmeq([for,in,to,towards,outside,nil,on,dir,near,past,at],TO)},
     {dmeq([place,station],Plass)},
    ispresent Jarlestreet isa Street,
        {dmeq([neighbourhood,street],Street)},
        {bound(Jarlestreet)},
    ispresent doit/TRAVELBE/Bus43/B, {dmeq(travelbe,TRAVELBE)},
    ispresent Bus43 isa BVP,  { bound(Bus43), dmeq(vehicle,BVP)},
    not ispresent doit/start/_/X
id  not message(neverpasses(Bus43,Jarlestreet)), %% retention
    not connections(_,_,_,_,_,_,_,_,_,_),
    not passevent(_Depset,_Bus,_Jarle_street,Opts,_Day,_B) when {testmember(to,Opts)},
    atday(Day),atdate2(DaySeqNo,_Date),
    add (departure(Bus,Ladekirke,DaySeqNo,Depset),
         passevent(Depset,Bus,Ladekirke,[to],Day,B)),
    add message(neverpasses(Bus43,Ladekirke))
ip  bus_place_station(Bus43,Jarlestreet,Ladekirke),
    neverpasses(Bus43,Jarlestreet),
    newfree(Bus).



% buss 60 til Berg /neib &station) ??? //NB also negans message
neverpasstostationmessage  rule  %%  Bus doesnt passes Destination!  %%  after toplace1 (in case of  depend)
is  ispresent srel/TO/Plass/Dragvoll/X,  %% (see retention)
        {dmeq([for,in,to,towards,outside,nil,on,dir,near,past,at],TO)}, %% TA-100903
     {dmeq([place,station],Plass)}, %% ANOMALY %% TA-100929
    ispresent Dragvoll isa Station,
        {dmeq([station,neighbourhood,street],Station)}, %% TA-101112 + street
        {bound(Dragvoll)},
    ispresent  doit/TRAVELBE/Bus36/B, {dmeq(travelbe,TRAVELBE)},
    ispresent Bus36 isa BVP,  { bound(Bus36), dmeq(vehicle,BVP)},
    not ispresent doit/start/_/X  %% start to go special
id  not message(neverpasses(Bus36,Dragvoll)), %% retention
    not connections(_,_,_,_,_,_,_,_,_,_),

    not passevent(_Depset,_Bus,_Dragvoll,Opts,_Day,_B) when {testmember(to,Opts)},
    %% toplace already fixed

    atday(Day),atdate2(DaySeqNo,_Date),
    add (departure(Bus,Dragvoll,DaySeqNo,Depset),
         passevent(Depset,Bus,Dragvoll,[to],Day,B)),
    add message(neverpasses(Bus36,Dragvoll))
%%%     add flag(exit)  %% no more neg answers %% -> allow TRANSFER
ip  neverpasses(Bus36,Dragvoll),
    newfree(Bus).



%% gives spurious deps from sentrum
neverpasstomessage2  rule  %%  Bus doesnt passes destination , not station
is  ispresent srel/TO/SN/Risvollan/X,  %% (see retention)
      { dmeq([for,in,on,to,towards,outside,nil,dir,near,past],TO)},
     ispresent Risvollan isa SN,
        { bound(Risvollan),
          dmeq([neighbourhood,street,station],SN)}, %% not station ???????
    ispresent doit/TRAVELBE/Bus36/B, { dmeq(travelbe,TRAVELBE)},
    ispresent Bus36 isa BVP,    { bound(Bus36), dmeq(vehicle,BVP)},
    not ispresent doit/start/_/X,  %% start to go special
      { bus_place_station(Bus36,Risvollan,Risvollansenteret)}
id  not  message(neverpasses(Bus36,Risvollan)),
    not  message(neverpasses(Bus36,Risvollansenteret)), %% retention
    atday(Day),atdate2(DaySeqNo,_Date),
    not connections(_,_,_,_,_,_,_,_,_,_),

    not departure(_,Risvollan,_,_),     % not already allocated Risvollan
    not departure(_,Risvollansenteret,_,_),% nor to   Risvollansenteret
    not passevent(_depset,_bus,_Station,Opts,_day,_b) when { testmember(to,Opts)},
    not passevent(_depset,_bus,Risvollansenteret,Opts,_day,_b) when { testmember(to,Opts)},

    add (departure(Bus,Risvollansenteret,DaySeqNo,Depset),
         passevent(Depset,Bus,Risvollansenteret,[to],Day,B)),
    add message(neverpasses(Bus36,Risvollansenteret))
%%     add flag(exit)  %% no more neg answers %%  allow for transfer

ip  neverpasses(Bus36,Risvollansenteret),
    newfree(Bus).



nilp rule % Does a bus TRAVEL () a place?   //
is  ispresent Bus isa BDA,
    ispresent doit/TRAVEL/Bus/C,
    srel/nil/Placoid/Place/C
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Station,DaySeqNo,Depset),
         passevent(Depset,Bus,Station,[],Day,C)) %% dont guess dir
ip	dmeq(travel,TRAVEL),
   dmeq([place,neighbourhood,station],Placoid),
   dmeq([bus,departure],BDA),
   notbothfree(Bus,Place),
   busorfree(Bus),
   bus_place_station(Bus,Place,Station)
:- double.




%% ENDSTATION SECTION BEFORE FINDSTATION  SECTION


endstat1 rule % What is the first STATION FOR Bus
is  which(A),doit/be1/A/D,srel/in/place/Station/D,adj/_/first/Station/_,
    srel/FOR/bus/Bus/D,
    ispresent Bus isa bus,ispresent Station isa STATION
id  add endstations(Bus,_)
ip  dmeq(for,FOR),exbus(Bus),dmeq(place,STATION).


endstat2 rule % What is the last STATION FOR Bus
is  which(A),doit/be1/A/D,srel/in/place/Station/D,adj/_/last/Station/_,
    srel/FOR/bus/Bus/D,
    ispresent Bus isa bus,ispresent Station isa STATION
id  add endstations(Bus,_)
ip  dmeq(place,STATION),dmeq(for,FOR) ,exbus(Bus).


endstat3 rule % What is the name of the endstation for Bus
is  which(A),B isa endstation,has/_V/endstation/Bus/B,dob/be/A/B/_  %%be_named
id  add endstations(Bus,_)
ip  exbus(Bus).


endstat4 rule % What is the endstation for Bus
is  which(A),has/_/endstation/Bus/A
id  add endstations(Bus,_)
ip  exbus(Bus).


endstat5 rule % Where is the endstation for Bus
is  which(A),A isa place,E isa endstation,has/_/endstation/Bus/E,doit/be1/E/D,srel/_/place/A/D
id  add endstations(Bus,_)
ip  exbus(Bus).


endstat6 rule % Where do the buses turn
is  which(A),A isa place,Bus isa Route,turn/Bus/D,srel/in/place/A/D
id  add endstations(Bus,_)
ip  dmeq(vehicle,Route),exbus(Bus).


endstat7 rule % What is the endstation for Bus
is  which(A),has/_/endstation/Tram/A, Tram isa tram
id  add endstations(One,_) %% # Trikken
ip  thetramno(One).


endstat8 rule % What is the endstation for Bus
is  which(A), A isa endstation,Bus isa BR, doit/BE/A/E,event/real/E,srel/ON/BR1/Bus/E
id  add endstations(Bus,_),
    add flag(exit)
ip  exbus(Bus),dmeq([on,for,in,to],ON),dmeq([bus,nightbus,route],BR),
    dmeq([bus,nightbus,route,vehicle],BR1),
    dmeq([be1],BE).


endstat8be rule % Hva er startholdeplassen til buss nr 5?
is  which(A), B isa endstation,dob/be/A/B/_ ,Bus isa BR,srel/ON/vehicle/Bus/_
id  add endstations(Bus,_),
    add flag(exit)
ip  exbus(Bus),dmeq([on,for,in,to],ON),dmeq([bus,nightbus,route],BR).


endstat8hete rule % What is the endstation for Bus
is  which(A),B isa endstation,
    srel/ON/_/B24/_,
    B24 isa BR,
    dob/be_named/A/B/_
id  add endstations(Bus,_)
ip  exbus(Bus),
    dmeq([on,for,in,to],ON),
    dmeq([bus,nightbus,route],BR).


endstat9 rule % Where is the endstation for Bus
is  which(X), A isa endstation, X isa place,
    doit/BE/A/E,srel/ON/VEH/B52/E,B52 isa BR,
    event/real/E,srel/in/place/X/E
id  add endstations(B52,_)
ip  exbus(B52),
    dmeq([on,for,in,to],ON),
    dmeq([bus,nightbus,route,vehicle],BR),
    dmeq([bus,nightbus,route,vehicle],VEH),
    dmeq([be1],BE).


endstat10 rule % Where is the endstation ----
is  which(X), X isa endstation,
    not ispresent _ isa station,
    not ispresent _ isa neighbourhood,
    not ispresent _ isa street
id  add message(mustknow(bus))
ip  [].

whereendstat1 rule
is  which(P),P isa endstation,B52 isa route,doit/be1/P/E,srel/_/route/B52/E,
    {bound(B52)}
id  add endstations(B52,_)
ip  [].


%% FINDSTATION SECTION  2

findstation2 rule
is  which(R), dob/run/Bus20/R/A,  Bus20 isa bus,R isa route
id	 atday(Day),
	 add (findstations(Bus20,Day,Stl),
         passesstations(Bus20,Day,Stl,A))
ip	 [].


findstation3 rule % Hvor kan jeg PASS on Bus
is  which(Station),doit/PASS/_/B,srel/In/place/Station/B,srel/On/VEHICLE/Bus/B,
    ispresent Bus isa bus
id	 atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,_))
ip	 dmeq([in,at],In),
    dmeq([on,off,by],On), %% av -> by   Repair Hack
    unbound(Station),exbus(Bus),dmeq(pass,PASS),dmeq(vehicle,VEHICLE).


findstation4 rule % Where can i get off Bus
is  which(Place),ispresent Bus isa bus,
    ispresent get/_/E,
	 srel/in/place/Place/E,srel/off/VEHICLE/Bus/E
id	 atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,E))
ip	 unbound(Place),exbus(Bus),dmeq(vehicle,VEHICLE).


findstation5 rule % Where can i get on Bus
is  which(Place),ispresent Bus isa bus,
    ispresent get/_/E,
	 srel/in/place/Place/E,srel/on/VEHICLE/Bus/E
id	 atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,E))
ip	 unbound(Place),exbus(Bus),dmeq(vehicle,VEHICLE).


findstation6 rule % Which stations is AT route Bus
is  which(St),doit/be1/St/A,srel/AT/bus/Bus/A,Bus isa bus,St isa station
id	 atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,A))
ip	 dmeq(at,AT),unbound(St),exbus(Bus).  %% dmeq first


findstation7 rule % Hva er stasjoner til en buss
is  Station isa station,doit/be1/Station/E,srel/to/vehicle/Bus/E
id	 not message(nearest_station(_ST,_,_)),
    atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,_))
ip	 unbound(Station),exbus(Bus).


findstation8 rule % Hva er stasjonene til en buss
is  which(Station),has/vehicle/station/Bus/Station
id	 not departure(_,_,_,_),
    atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,_))
ip	 unbound(Station),exbus(Bus).


findstationwhere rule % Hvor  er stasjonene til en buss
is  which(A),A isa place,Bus isa Veh,S isa station,has/_Vehicle/station/Bus/S,
    doit/be1/S/D, srel/in/place/A/D ,                     %% route/vehicle
      {dmeq(vehicle,Veh)}
id	 not departure(_,_,_,_),
    atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,_))
ip	 unbound(A),exbus(Bus).


findstation8nobus rule % Hva er stasjonene til en buss
is  which(Station),has/vehicle/station/Bus/Station
id	 not departure(_,_,_,_),
    add message(mustknow(bus)),
    add flag(exit)                   %% avoid vet ikke
ip	 unbound(Station),unbound(Bus).


findstation9 rule %%   ruteplan for en buss
is  has/BR/Route_plan/Bus/_Route
id  not departure(_,_,_,_),
    atday(Day),
    add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,_))
ip  dmeq([bus,nightbus,route,vehicle],BR),
    dmeq([route_plan,route],Route_plan),
    exbus(Bus).


findstation20 rule  %% Variant   rute for en rute
is  which(Route),has/BR/Route_plan/Route/Bus  %% hvilken rute har buss 54
id       atday(Day),
         add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,_))
ip       dmeq([bus,nightbus,route,vehicle],BR),
    dmeq([route_plan,route],Route_plan),
    exbus(Bus).


findstation30 rule % Hva er trasee for en rute
is  which(Route),B52 isa bus,
    Route isa route_plan,srel/FOR/BR/B52/_E,
    not srel/_Pwith/time/_/_ , %%   (Detail)
    not srel/_/place/_/_
id	 atday(Day),
	 add (findstations(B52,Day,Stl),passesstations(B52,Day,Stl,_))
ip	 dmeq(for,FOR), dmeq(bus,BR),
    unbound(Route),exbus(B52).


findstation40 rule % Hvor kan jeg ta en Bus
is  which(Station),dob/take/_/Bus/B,srel/in/place/Station/B,ispresent Bus isa bus
id	 atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,_))
ip	 unbound(Station),exbus(Bus).


findstation60 rule  % Hvor kan jeg PASS off Bus
is  which(Station),doit/PASS/_/B,srel/in/place/Station/B,srel/off/VEHICLE/Bus/B,
    ispresent Bus isa bus
id	 atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,_))
ip	 unbound(Station),exbus(Bus),dmeq(pass,PASS),dmeq(vehicle,VEHICLE).


findstation70 rule % Hvor kan jeg PASS with Bus
is  which(Station),doit/PASS/_/B,srel/in/place/Station/B,
    srel/pwith/VEHICLE/Bus/B,ispresent Bus isa bus
id	 atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,_))
ip	 unbound(Station),exbus(Bus),dmeq(pass,PASS),dmeq(vehicle,VEHICLE).


findstation80 rule % Where PASS the Bus bus
is  which(Place),srel/in/place/Place/D,
    ispresent B isa bus, doit/PASS/B/D,ispresent adj/_/Bus/B/_
id	 atday(Day),
	 add (findstations(Bus,Day,Stl),
         passesstations(Bus,Day,Stl,_))
ip	 unbound(Place),exbus(Bus),dmeq(pass,PASS).


findstation90 rule % Hviken ruteplan/rute  tar/følger buss 20
is  which(A),A isa RP,Bus isa Veh,dob/Take/Bus/A/_
id	 atday(Day),
	 add (findstations(Bus,Day,Stl),
         passesstations(Bus,Day,Stl,_))
ip	 bound(Bus),dmeq([take,follow,pass],Take),
    dmeq([route,route_plan],RP),dmeq(vehicle,Veh).


%%%%% End of FindStation Section %%%%%%%%%%%%%%%%%

%% SECTION  Pass

passby2 rule %  Does a bus PASS BY two places? % OR A PERSON
is  Bus isa Busman,ispresent doit/PASS/Bus/A,srel/TOFROMBY/place/(StartPlace,EndPlace)/A
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,StartStat,DaySeqNo,StartDepset),
			passevent(StartDepset,Bus,StartStat,[],Day,A),
			departure(Bus,EndStat,Day,EndDepset),
			passevent(EndDepset,Bus,EndStat,[],Day,A))
ip	 dmeq(tofromby,TOFROMBY),
    place_station(StartPlace,StartStat),place_station(EndPlace,EndStat),
    dmeq(pass,PASS),busman(Bus,Busman).


passbyname rule % Does a bus PASSBY a place? (Place is unbound) ??? <----------
is  exactly (which(Time),Bus isa bus, Time isa Timeq,
				 PASSBY/Bus/Place/C,event/real/C,srel/in/time/Time/C)
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Place,DaySeqNo,Depset),
			passevent(Depset,Bus,Place,[],Day,C))
ip	 unbound(Place),dmeq(passby,PASSBY),dmeq(time,Timeq).


travelbyplace rule % Do I  TRAVEL BY a place?
is  ispresent I isa SELF, ispresent doit/TRAVEL/I/C, srel/BY/Placoid/Place/C,
    not ispresent srel/to/place/_/_ %% then [] is not an option
id	 not flag(exit),
    atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[],Day,C))
ip	 dmeq(travel,TRAVEL),
    TRAVEL \== arrive, %% postpone arrive destination , to arrive at = go to
    TRAVEL \== come,
    dmeq(by,BY),dmeq([self,program,agent],SELF),
    dmeq([place,city],Placoid), %% Trondheim as city
    place_station(Place,Stat),newfree(Bus).


superfluousvia rule  %% (from X to Y)  VIA Z
is  srel/BY/place/Place/C,   {dmeq(by,BY)},
    ispresent Bus isa BR,
    ispresent doit/TRAVELBE/Bus/C,
    not ispresent srel/dir/place/_/_,
    not ispresent srel/nil/place/_/_
id	 not flag(exit),
    not message(neverpasses(_,Place)),  %% %% når går buss nr 60 fra sentrum forbi berg
    passevent(_,_,_,[from],_,_),
    passevent(_,_,_,[to],_,_),
    add message(toomanyplaces)
ip	 dmeq(bus,BR),dmeq(travelbe,TRAVELBE), %  ved = kommer til
    busorfree(Bus).


% Does a bus TRAVEL BY a place? Detect to option
%     hvis jeg skal være i hornebergveien kl 1500

travelbyto rule  %% past X from  Y
is  srel/BY/place/Place/C,   {dmeq(by,BY)},
     not ispresent srel/to/_/_/_, %% til muligheten (SIC) %% TA-110204

    ispresent Bus isa BR,ispresent doit/TRAVELBE/Bus/C,
    not ispresent srel/dir/place/_/_

id	 not flag(exit),
    not message(neverpasses(_,_Place)),  %% %% når går buss nr 60 fra sentrum forbi berg
    atday(Day),atdate2(DaySeqNo,_Date),
%%%	 passevent(_,_,_,Opts0,_,_),     %% TA-110119
    add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[to],Day,C))
ip	 %%%   member(from,Opts0),   %% TA-110119
    dmeq(bus,BR),dmeq(travelbe,TRAVELBE), %  ved = kommer til
    busorfree(Bus),
    bus_place_station(Bus,Place,Stat). %% OOPS  nth

travelbyfrom rule % Does a bus TRAVEL BY a place?  => TRAVEL  == FROM
                  %% (only one place mentioned,  time related to that)
is  srel/BY/Placoid/Place/C, {dmeq(by,BY)},
    ispresent Bus isa BR, {dmeq(vehicle,BR)},
    ispresent doit/Go/Bus/_C , { dmeq([go,stop,run,drive,pass],Go)} ,
    not ispresent doit/stop/_/_, %% stop never means from
    not ispresent srel/to/place/F/_ when {bound(F)}, %% Hvor tar jeg  bussen forbi ranheim fotballbane?
    not ispresent srel/from/_/_/_,
    not ispresent srel/nil/place/Place/_ %%% when { (Place1 \== Place)} NEVER FROM=TO
id	  not flag(exit),
    atday(Day),atdate2(DaySeqNo,_Date),
    add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[from],Day,C))
ip  dmeq([place,neighbourhood,station,city],Placoid),
    busorfree(Bus),
    bus_place_station(Bus,Place,Stat). %% OOPS  nth


travelbybusbyp rule % someone TRAVEL BY bus by a place?
is  ispresent Bus isa bus,ispresent doit/TRAVEL/_/A,
    ispresent srel/by/vehicle/Bus/A,srel/BY/place/Place/A
id	 not flag(exit),
    atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),passevent(Depset,Bus,Stat,[],Day,A))
ip  dmeq(travel,TRAVEL),dmeq(by,BY),place_station(Place,Stat),
    busorfree(Bus).


sometravelby rule % Can someone TRAVEL BY a place a time?
is  ispresent doit/TRAVEL/_/Time/B,srel/BY/place/Place/B
id	 not flag(exit),
    atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         keeparound(Time,Depset,NewDepset), %% keepat
			passevent(NewDepset,Bus,Stat,[],Day,B))
ip  dmeq(by,BY),place_station(Place,Stat),number(Time),
    dmeq(travel,TRAVEL),   newfree(Bus).


nnpassing rule % is a NN bus PASSing a place?
is  ispresent Bus isa bus,ispresent PASSBY/Bus/_,adj/_/Place/Bus/A
id	  not flag(exit),
    atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[],Day,A))
ip	 dmeq(passby,PASSBY),place_station(Place,Stat),
    busorfree(Bus).


somepassbybus0 rule % Does a place belong to a route?
is  belong_to/Place/Bus/A
id	  not flag(exit),
    atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[buses],Day,A))
ip  busorfree(Bus),
    bus_place_station(Bus,Place,Stat).


somepassbybus1 rule % Does a bus PASS a place?  Dragvoll misere
is  PASSBY/Bus/Place/A,
    not srel/from/place/_/_
id	 not flag(exit),
    atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[],Day,A))
ip  dmeq(passby,PASSBY),busorfree(Bus),
    bus_place_station(Bus,Place,Stat).


somepassbybus2 rule % which routes station does route have
is  has/route/station/Bus/Place
id	 not flag(exit),
    atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[],Day,F))
ip  busorfree(Bus),newfree(F),
    bus_place_station(Bus,Place,Stat).


somepassbybus3 rule % På hvilke ruter fins moholt
is  which(A),A isa route,
    doit/be1/Place/B,srel/on/route/A/B,event/real/B
id	 not flag(exit),
    atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[],Day,F))
ip  busorfree(Bus),newfree(F),
    bus_place_station(Bus,Place,Stat).


hasstation1 rule % bus has station
is  replaceall (R isa BR, has/route/station/R/A,A isa station)
    with       (R isa route,
	             A isa station,pass/R/E,srel/dir/place/A/E)
id  []
ip  dmeq(bus,BR),bound(R),newfree(E).


allbuses99  rule %%  list all the buses
is  tuc isa savant, B52 isa BR, dob/LIST/tuc/B52/X,event/real/X,
    not ispresent adj/_/_/_/_, %% seneste?
    not ispresent  srel/_/_/_/_   ,
    not B63 isa route when { bound(B63)} %% not mention a route
id  not departure(_,_,_,_),
    not findstations(_,_,_),
    add listofall(bus,_)
ip  dmeq(list,LIST),dmeq(bus,BR),unbound(B52).


doescome rule %%  Does a bus COME a place? (Place is unbound)
is  exactly (which(Time),Bus isa bus, Time isa Timeq,
				 COME/Bus/Place/C,event/real/C,srel/in/time/Time/C)
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Place,DaySeqNo,Depset),
			passevent(Depset,Bus,Place,[],Day,C))
ip	 unbound(Place),dmeq(come,COME),dmeq(time,Timeq).


passto1 rule % Does a bus PASS TO a place? (Place is unbound)
is  doit/PASS/_/A,srel/TO/place/nil/A
id  atday(Day),atdate2(DaySeqNo,_Date),
    add (departure(Bus,PlaceVar,DaySeqNo,Depset),
			passevent(Depset,Bus,PlaceVar,[],Day,A))
ip	 dmeq(pass,PASS),dmeq(to,TO),newfree(PlaceVar).


gotoplace rule % Does a bus PASS TO a place?
is  doit/PASS/Bus/A,srel/TO/place/Place/A,
    ispresent Bus isa BVP
id	 not flag(exit),
    not findstations(_,_,_),
    not departure(_Bus,_Stat,_Day,_Depset), %% only for beginners
    not message(mustknowanother(place)),
    atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[],Day,A))
ip  dmeq(pass,PASS),dmeq(to,TO),
    dmeq(trafficant,BVP),
    busorfree(Bus),
    bus_place_station(Bus,Place,Stat),
    Stat \== unknown.


travelby1 rule % someone TRAVEL by bus a place?
is  ispresent Bus isa bus,ispresent doit/TRAVEL/_/A,
    ispresent srel/by/vehicle/Bus/A,srel/TO/place/Place/A
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[],Day,A))
ip  dmeq(travel,TRAVEL),dmeq(to,TO),
    busorfree(Bus),
    bus_place_station(Bus,Place,Stat).


travelby2 rule % someone TRAVEL TO a place when I start at ...
is  ispresent doit/TRAVEL/Cat/B, doit/start/_/X ,  %% when I start at
    srel/AT/_/Place/X,
    ispresent Cat isa BVP
id  atday(Day),atdate2(DaySeqNo,_Date),
    not  departure(Bus,Place,DaySeqNo,Depset),
    add (departure(Bus,Station,DaySeqNo,Depset),
         passevent(Depset,Bus,Station,[from],Day,B)) %% NB from
ip  dmeq(travel,TRAVEL),
    dmeq([for,in,on,at],AT), %%  derived    gå i byen// arrive at
    dmeq(trafficant,BVP),           %% Experiment  Not CAT
    place_station(Place,Station),newfree(Bus).


travelby99 rule % travel "by" a vehicle which is not a bus
is  ispresent B isa NOTBUS,srel/by/vehicle/B/_
id	 not fail,
	 add fail
ip  dmeq(notbus,NOTBUS).


passplace1 rule % someone pass a place?
is  ispresent I isa self, P isa Place,ispresent dob/PASS/I/P/B
id       atday(Day),atdate2(DaySeqNo,_Date),
    not  departure(Bus,P,DaySeqNo,Depset),
         add (departure(Bus,P,DaySeqNo,Depset),
         passevent(Depset,Bus,P,[],Day,B))
ip  dmeq(pass,PASS),
    dmeq(place,Place),
    statorplace(P),newfree(Bus).



travelto  rule
is  srel/to/_/place/_X, ispresent doit/TRAVEL/Cat/B,
    ispresent Cat isa BVP
id  atday(Day),atdate2(DaySeqNo,_Date),
    not  departure(Bus,Place,DaySeqNo,Depset),
    add (departure(Bus,Station,DaySeqNo,Depset),
         passevent(Depset,Bus,Station,[to],Day,B))
ip  dmeq(travel,TRAVEL),
    dmeq(trafficant,BVP),
    place_station(Place,Station),newfree(Bus).


travelto2 rule % Can someone TRAVEL TO a place a time?
is  ispresent doit/TRAVEL/_/Time/B,srel/TO/place/Place/B
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
          keepbefore1(Time,Depset,NewDepset), %% keepat %% < 1 hour before
			passevent(NewDepset,Bus,Stat,[],Day,B))
ip  dmeq(travel,TRAVEL),number(Time),
    dmeq(to,TO),place_station(Place,Stat),newfree(Bus).

%% passplace2 rule subsumed passfromto4

comebus1 rule % is a Place bus  COMEing?
is  ispresent Bus isa bus,ispresent COME/Bus/_,adj/_/Place/Bus/A
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[],Day,A))
ip	 dmeq(come,COME),
    busorfree(Bus),
    bus_place_station(Bus,Place,Stat).


passplaceto rule % pass place TO Place
is  ispresent dob/PASS/Bus/_/A,
    srel/TO/place/Place/A
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[to],Day,A))
ip  dmeq(to,TO), dmeq(pass,PASS),
    busorfree(Bus),bus_place_station(Bus,Place,Stat).

passplacefrom rule % pass place FROM Place
is  ispresent dob/pass/Bus/_/A,
    srel/from/place/Place/A
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[from],Day,A))
ip  busorfree(Bus),
    bus_place_station(Bus,Place,Stat).


passtoplace3 rule % when PASS Bus TO Place,   srel variant
is  ispresent srel/TO/place/Place/B,ispresent doit/PASS/Cat/B,
    ispresent Cat isa BVP
id	 atday(Day),
         replace  passevent(Depset,Bus,Place1,[],Day,B)
         with     passevent(Depset,Bus,Place1,[to],Day,B)
ip	 dmeq(to,TO),dmeq(pass,PASS),
    dmeq(trafficant,BVP),
    statorplace(Place),busorfree(Bus),


befed rule  %%  Dirty
is    R isa route,  Bus isa bus,
      doit/be1/R/X, event/real/X, srel/for/bus/Bus/X, % route for Bus
      doit/be1/R/C, event/real/C, srel/TO/place/Place/C
id	 atday(Day),atdate2(DaySeqNo,_Date),
    add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[to],Day,C)) %% same event C
ip	 dmeq(to,TO),bus_place_station(Bus,Place,Stat).


%%%%% Default-regler for fraser helt uten steder (Place is unbound)


arrdep1 rule % ARRDEP with buss (Place is unbound)
is  ispresent  Arrdep isa ARRDEP, %% which(Arrdep), %% also test
    doit/be1/Arrdep/E,srel/pwith/bus/Bus/E ,
    not ispresent srel/_/place/_/_
id  not passevent(_,Bus,_,_,_,_),
    not connections(_,_,Bus,_,_,_,_,_,_,_),
    atday(Day),atdate2(DaySeqNo,_Date),
    add (departure(Bus,hovedterminalen,DaySeqNo,Depset),
			passevent(Depset,Bus,hovedterminalen,[],Day,_))
ip  dmeq(arrdep,ARRDEP), busorfree(Bus),
    bound(Bus),                                 %% does it blur the rule
    \+ neverpasses(Bus,hovedterminalen).


arrdep2 rule
is  ispresent  Arrdep isa TAR, %% which(Arrdep), %% also test
    has/bus/ARRDEP/Bus/Arrdep,
    not ispresent srel/_/place/_/_             %%  etc. etc. etc.
id  not passevent(_,Bus,_,_,_,_),
    not connections(_,_,Bus,_,_,_,_,_,_,_),
    atday(Day),atdate2(DaySeqNo,_Date),
    add (departure(Bus,hovedterminalen,DaySeqNo,Depset),
			passevent(Depset,Bus,hovedterminalen,[],Day,_))
ip  dmeq(arrdep,ARRDEP),dmeq(arrdep,TAR),
    busorfree(Bus),
    bound(Bus),                                 %% does it blur the rule
    \+ neverpasses(Bus,hovedterminalen).


arrdep3 rule % ARRDEP for buss (Place is unbound)
is  ispresent  Arrdep isa ARRDEP, %% which(Arrdep), %% also test
    has/bus/ARRDEP/Bus/Arrdep
id  not passevent(_,Bus,_,_,_,_),
    not connections(_,_,Bus,_,_Fro,_,_,_,_),
    addcon  message(mustknow(place))
ip  dmeq(arrdep,ARRDEP),
    busorfree(Bus),
    bound(Bus),
    neverpasses(Bus,hovedterminalen).


istoplace rule % is ARRDEP TO Place
is  ispresent B isa ARRDEP, ispresent doit/be1/B/A, srel/TO/place/Place/A
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 not  departure(_,  Stat,_,  _), %% in case neverpasses
    add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[TO],Day,A))
ip  dmeq(to,TO),place_station(Place,Stat),dmeq(arrdep,ARRDEP),
    newfree(Bus).


isfromplace rule % is ARRDEP FROM Place, Bus is UNKNOWN !!!
is  ispresent B isa ARRDEP,ispresent doit/be1/B/A, srel/FROM/place/Place/A
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[FROM],Day,A))
ip  dmeq(arrdep,ARRDEP),dmeq(from,FROM),place_station(Place,Stat),
    newfree(Bus).


hasvehdep rule
is  has/vehicle/departure/Bus/_,adj/_/Place/Bus/A
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[from],Day,A))
ip	 place_station(Place,Stat),busorfree(Bus).


whathasroute  rule %% which stations exist on route  5
is  ispresent which(Place),
    ispresent Place isa Plak,
    Bus isa route,
    doit/exist/Place/A,
    srel/On/Vehicle/Bus/A
id	 atday(Day),
    not departure(Bus,_,_,_), %% passevent is removed by conn.
	 add (findstations(Bus,Day,Stl),
         passesstations(Bus,Day,Stl,A))
ip	  dmeq(place,Plak),unbound(Place),
     dmeq([in,on],On),dmeq(vehicle,Vehicle),
     exbus(Bus).

remallstations rule %% if specific station passing, remove listall stations moved up
is []
id passesstations(_,_,_,_),
   remove listofall(station,_)
ip [].

%%% END PASSES STATION SECTION %%

firstnext rule % Panic   first,next 4,  no departure yet
is  quant(eq/N,Bus),Bus isa BR,adj/_/POSITION/Bus/E
id	 not message(not(route,_)),
    not departure(_,_,_,_),
	 atday(Day), atdate2(DaySeqNo,_Date),
    add (timenow2(0,Time),
         departure(Bus,PlaceVar,DaySeqNo,Depset),
         keepafter(Time,Depset,Depset1),
			passevent(Depset1,Bus,PlaceVar,[POS1],Day,E))
ip	 ( POSITION=first; POSITION=next),
    dmeq(bus,BR),dmeq(position,POSITION), busorfree(Bus),
    bound(PlaceVar),
    corresporder(POSITION,N,POS1).


prevlast rule % Panic   previous,last 4,  no departure yet
is  quant(eq/N,Bus),Bus isa BR,adj/_/POSITION/Bus/E
id	 not message(not(route,_)),
    not departure(_,_,_,_),
	 atday(Day), atdate2(DaySeqNo,_Date),
    add (timenow2(0,Time),
         departure(Bus,PlaceVar,DaySeqNo,Depset),
         keepbefore(Time,Depset,Depset1),
			passevent(Depset1,Bus,PlaceVar,[POS1],Day,E))
ip	 ( POSITION=last; POSITION=previous),
    dmeq(bus,BR),dmeq(position,POSITION), busorfree(Bus),
    bound(PlaceVar), %% newfree(PlaceVar),
    corresporder(POSITION,N,POS1).


home0 rule %% hjem til meg = til meg %% TA-100909
is  srel/to/self/_I_/_,
    clear
id	 not departure(_,_,_,_),
    not message(mustknowanother(place)),
    addcon  message(mustknow(place)),
    add flag(exit)
ip  [].


home1 rule %% manyplaces % moved before   NEXT bus home
is  srel/Home/PLACE/nil/_,
    clear
id	 not departure(_,_,_,_),
    not message(mustknowanother(place)),
    addcon  message(mustknow(place)),
    add flag(exit)
ip  dmeq([home,away],Home),dmeq([place,direction],PLACE).


home2 rule %% manyplaces % moved before   NEXT bus home
is  has/person/house/_/_,
    clear
id	 not departure(_,_,_,_),
    addcon  message(mustknow(place))
ip  [].


notdefault_ht_bus rule
is  []
id  not numberof(stations,_,_),
    not message(mustknow(place)),
    departure(Bus,PlaceVar,_DaySeqNo,_Depset1),
    clear,
    add message(mustknow(place))
ip  bound(Bus),
    \+ thetramno(Bus),
    unbound(PlaceVar),
    neverpasses(Bus,hovedterminalen).


defaultfromcenter rule %% default from hovedterminalen
is  []
id  atday(Day), atdate2(DaySeqNo,_Date),
    not numberof(stations,_,_),
    not message(mustknow(place)),
    replace departure(Bus,PlaceVar,DaySeqNo,Depset1)
     with   departure(Bus,hovedterminalen,DaySeqNo,Depset1),
    replace passevent(Depset2,Bus,PlaceVar,Opts,Day,A)
      with  passevent(Depset2,Bus,hovedterminalen,Opts1,Day,A)
ip  bound(Bus),
    \+ thetramno(Bus),
    unbound(PlaceVar),
    \+ neverpasses(Bus,hovedterminalen),
    setopt(from,Opts,Opts1). %% Experiment



default_ht_tram rule
is  []
id  atday(Day), atdate2(DaySeqNo,_Date),
    not numberof(stations,_,_),
    not message(mustknow(place)),
    replace departure(Bus,PlaceVar,DaySeqNo,Depset1)
     with   departure(Bus,STOGT,DaySeqNo,Depset1),
    replace passevent(Depset2,Bus,PlaceVar,Opts,Day,A)
      with  passevent(Depset2,Bus,STOGT,Opts1,Day,A)
ip  bound(Bus),
    thetramno(Bus),
    thetramstation(STOGT),
    unbound(PlaceVar),
    setopt(from,Opts,Opts1).

%%%%%% Spørsmål om trikk og flybuss og båt  %%%%%


numberonbus rule %   which number(?) are on the buses
is  which(BusN),doit/be1/BusN/E,srel/on/object/Bus/E,ispresent Bus isa bus
id	 replace passevent(A,Bus,B,_,C,D) with
    passevent(A,Bus,B,[buses],C,D)
ip	 [].

%%%%%%%%%% Tidsbegrensninger etc. %%%%%%%%%%%%%%%%%%%%%%%%%


in16time rule  %%  ...in Time time (i 16 tida = around 16) % Norwagism
is  srel/in/time/Time/C,srel/nil/time/T/C
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
    with    (keeparound(Time,Deps,NewDeps), %% NEW in buslog
             passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip  number(Time),unbound(T),
    setopt(time,Opts,Opts1).


intimetotime rule % ...in time Time1 to Time2
is  srel/in/time/Time1/A,srel/to/time/Time2/A,adj/_/time/Time1/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with ( keepbetween(Time1,Time2,Deps,NewDeps),
           passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip  number(Time1),number(Time2),
    setopt(time,Opts,Opts1).

minago rule %  for   30 minutter siden
is  Minutes  isa minute,srel/ago/_Time/Minutes/_C  %% _Time = minute sometimes
id	 replace passevent(Deps,Bus,Place,Opts,Day,C)
	 with    (timenow2(0,Time),
             subfromtime(Time,Minutes,TM),
             keepafter(TM,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,C))
ip  number(Minutes),
    setopt(time,Opts,Opts1).


beforemin rule  % before 30 minutter from NOW
is  Minutes  isa minute,srel/before/MINUTE/Minutes/_C,  %% before etc ?
    not (C isa clock) when { bound(C)}
id	 replace passevent(Deps,Bus,Place,Opts,Day,C)
	 with  (  timenow2(Minutes,TM),
             keepbefore(TM,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,C))
ip  number(Minutes),
    dmeq(minute,MINUTE),
    testmember(to,Opts), %% check it is the arrival event.
    setopts([time,lastcorr],Opts,Opts1).

earliermin rule  % before 30 minutter from NOW
is  srel/nil/duration/Minute/E,
    Minutes  isa minute,
    srel/earlier/time/nil/E,
    not (C isa clock) when { bound(C)}
id	 replace passevent(Deps,Bus,Place,Opts,Day,C)
	 with  (  timenow2(Minutes,TM),
             keepbefore(TM,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,C))
ip  number(Minute),
    testmember(to,Opts), %% check it is the arrival event.
    setopts([time,lastcorr],Opts,Opts1).


aftermin1 rule  % after 30 minutter
is  Minutes  isa minute,srel/AFTER/MINUTE/Minutes/_C  %% before etc ?
id	 replace passevent(Deps,Bus,Place,Opts,Day,C)
	 with  (timenow2(Minutes,TM),
             keepafter(TM,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,C))
ip  dmeq([after,about,withafter,during2],AFTER),
    number(Minutes),
    dmeq(minute,MINUTE),
    setopt(time,Opts,Opts0),
    setopt(nextaftertime(1),Opts0,Opts1).


aftermin2 rule  % after 30 minutter //alternative
is  Minutes  isa minute, srel/nil/duration/Minutes/E,
    not ispresent srel/before/coevent/_/E,
    not ispresent _ isa clock
id	 replace passevent(Deps,Bus,Place,Opts,Day,C)
	 with  (timenow2(Minutes,TM),
           keepafter(TM,Deps,NewDeps),
			  passevent(NewDeps,Bus,Place,Opts1,Day,C))
ip  number(Minutes),
    setopt(time,Opts,Opts0),
    setopt(nextaftertime(1),Opts0,Opts1).


aftersec rule % after 30 seconds
is  Seconds  isa second, srel/AFTER/_/Seconds/_C,
     {number(Seconds), Seconds =< 86400} %% 1 døgn :-) %% TA-100903
id	 replace passevent(Deps,Bus,Place,Opts,Day,C)
	 with (timenow2(Minutes,TM),
          keepafter(TM,Deps,NewDeps),
			 passevent(NewDeps,Bus,Place,Opts1,Day,C))
ip  dmeq([after,about,withafter],AFTER),
    number(Seconds),Minutes is Seconds//60,
    setopt(time,Opts,Opts1).


duringmin rule
is  Minutes  isa minute,srel/during/MINUTE/Minutes/_C  %% before etc ?
id  replace passevent(Deps,Bus,Place,Opts,Day,C)
    with    (timenow2(0,Time),
             keepwithin(Time,Minutes,Deps,NewDeps),
             passevent(NewDeps,Bus,Place,Opts1,Day,C))
ip  number(Minutes),dmeq(minute,MINUTE),
%%   \+ member(to,Opts), %% WITHIN is from Departure time !!!
    setopt(time,Opts,Opts1).


afterclockwithin rule %% after clock within minutes
is  Minutes  isa minute,srel/WITHIN/TM/Minutes/_C ,
        {dmeq([within,in,on,for],WITHIN)}, %% within duration
     T1400 isa clock,

    srel/after/time/T1400/_   %% not present, \+ busaftertime3

id  replace passevent(Deps,Bus,Place,Opts,Day,C)
    with    (keepwithin(T1400,Minutes,Deps,NewDeps),
             passevent(NewDeps,Bus,Place,Opts1,Day,C))
ip  number(Minutes),dmeq(minute,TM),
    setopt(time,Opts,Opts1).     %% neste 60 minutter = innen

%% TA-100912
arrwithin rule %% arrival  within constraints
is  ispresent doit/Arr/_/E, {dmeq([come,arrive,reach],Arr)},
    Minutes  isa minute,srel/WITHIN/TM/Minutes/E ,
        {dmeq([within,in,on,for],WITHIN)}, %% within duration
    not ispresent srel/after/time/_/_
id  replace passevent(Deps,Bus,Place,[to|Opts],Day,C) %%NB to is 1. option
    with    (timenow2(0,Time),
             keepwithin(Time,Minutes,Deps,NewDeps),
             passevent(NewDeps,Bus,Place,Opts1,Day,C))
ip  number(Minutes),dmeq(minute,TM),
    setopt(time,[to|Opts],Opts1).



depwithin rule %% departure within constraints but after NOW
is  ispresent doit/go/_/E,
    Minutes  isa minute,srel/WITHIN/TM/Minutes/E ,
        {dmeq([within,in,on,for],WITHIN)}, %% within duration
    not ispresent srel/after/time/_/_
id  replace passevent(Deps,Bus,Place,Opts,Day,C)
    with    (timenow2(0,Time),
             keepwithin(Time,Minutes,Deps,NewDeps),
             passevent(NewDeps,Bus,Place,Opts1,Day,C))
ip  number(Minutes),dmeq(minute,TM),
    setopt(time,Opts,Opts1).     %% neste 60 minutter = innen


withinwhere rule %% within arrival constraints, unknown place
is  Minutes  isa minute,srel/WITHIN/TM/Minutes/_C ,
    not ispresent srel/after/time/_/_ ,
    not A isa station when {bound(A)},
    not B isa neighbourhood when {bound(B)}
id  add message(mustknow(place))
ip  number(Minutes),dmeq(minute,TM),
    dmeq([within,in,on,for],WITHIN).


firstanotherdayisearliest rule
is  adj/_/first/_/_,
    not ispresent srel/tomorrow/day/nil/_,
    not ispresent _ isa clock,
    not ispresent _ isa morning
id	 atdate2(_DaySeqNo,ATDATE),
    replace passevent(Deps,Bus,Place,Opts,Day,A)
    with (keepafter(0430,Deps,NewDeps),
		    passevent(NewDeps,Bus,Place,Opts2,Day,A))
ip	 todaysdate(TODAYSDATE),
    ATDATE \== TODAYSDATE, %%
    main:testmember(from,Opts),
    setopt(time,Opts,Opts1),setopt(next(1),Opts1,Opts2)

:-double.


%  first means herafter unless ...
firstishereafter rule
is  adj/_/first/_/_,
    not ispresent srel/tomorrow/day/nil/_,
    not ispresent _ isa clock,
    not ispresent _ isa monday, % ugly
    not ispresent _ isa tuesday,
    not ispresent _ isa wednesday,
    not ispresent _ isa thursday,
    not ispresent _ isa friday,
    not ispresent _ isa saturday,
    not ispresent _ isa sunday,
    not ispresent _ isa morning
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
    with		(timenow2(0,MinTime),
             keepafter(MinTime,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts2,Day,A))
ip	 setopts([time,next(1)],Opts,Opts2)
:-double.


lastisdepbeforemidnight rule  %  last means last before midnight (technically speaking)
is  adj/_/last/_/_,
    not ispresent _ isa clock
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
    with		( keepbefore(2500,Deps,NewDeps),  %% 2500 is not paraphrased
				  passevent(NewDeps,Bus,Place,Opts2,Day,A))
ip	 main:testmember(from,Opts),    %% last bus is always arrival ?
    setopts([time,lastcorr,last(1)],Opts,Opts2)  %%% WHY BOTH ?
:-double.



lastisarrbeforemidnight rule  %  last means last before midnight (technically speaking)
is  adj/_/last/_/_,
    not ispresent _ isa clock,
    not ispresent _ isa monday, % ugly
    not ispresent _ isa tuesday,
    not ispresent _ isa wednesday,
    not ispresent _ isa thursday,
    not ispresent _ isa friday,
    not ispresent _ isa saturday,
    not ispresent _ isa sunday
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
    with (keepbefore(2500,Deps,NewDeps),  %% 2500 is not paraphrased
		    passevent(NewDeps,Bus,Place,Opts2,Day,A))
ip	 main:testmember(to,Opts),
    setopts([time,lastcorr,last(1)],Opts,Opts2)
:-double.



within3 rule  %%   bussen går () neste time
is  Minutes  isa minute,srel/nil/TM/Minutes/_C,
    ispresent  adj/_/next/_/_
id replace passevent(Deps,Bus,Place,Opts,Day,C)
    with    (timenow2(0,Time),
             keepwithin(Time,Minutes,Deps,NewDeps),
             passevent(NewDeps,Bus,Place,Opts1,Day,C))
ip  number(Minutes),dmeq(minute,TM),
%%   \+ member(to,Opts), %% WITHIN is from Departure time !!!
    setopt(time,Opts,Opts1).     %% neste 60 minutter = innen



% in next hour  from station
innexthour1 rule
is  H isa hour,adj/_/next/H/_,srel/IN/time/H/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	(timenow2(0,Time),
                  keepwithin(Time,60,Deps,NewDeps),
                  passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq(intime,IN),setopt(time,Opts,Opts1).

% in next hour to station
innexthour2 rule
is  H isa hour,adj/_/next/H/_,srel/IN/time/H/_ %% nil here has been replaced
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	(timenow2(0,Time),
                 keepwithin(Time,60,Deps,NewDeps),
                 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq(intime,IN),
        setopt(time,Opts,Opts1).


% in next N minutes
innextmin1 rule
is  B isa minute,srel/in/time/N/C,srel/nil/time/B/C,adj/_/next/N/_
id  replace passevent(Deps,Bus,Place,Opts,Day,C)
    with   (timenow2(0,Time),
            keepwithin(Time,N,Deps,NewDeps),
            passevent(NewDeps,Bus,Place,Opts1,Day,C))
ip  number(N),
    setopt(time,Opts,Opts1).



% next N minutes
nextmin3 rule
is  N isa minute,srel/nil/time/N/C,adj/_/next/N/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,C)
	 with	(timenow2(0,Time),
                 keepwithin(Time,N,Deps,NewDeps),
                 passevent(NewDeps,Bus,Place,Opts1,Day,C))
ip  number(N),
    setopt(time,Opts,Opts1).

% in next minute
nextmin4 rule
is  H isa minute,adj/_/next/H/_,srel/IN/time/H/A
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with  (timenow2(0,Time),
                keepwithin(Time,1,Deps,NewDeps),
                passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq(intime,IN),
    setopt(time,Opts,Opts1).


beatafter rule
is  context doit/be1/Bus/D, srel/AT/time/Time/D ,            %%  _ ==> Bus  (Experiment)
    not srel/before/time/_/_ ,                           %% no other before - constraint
    not doit/meetup/_/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
    with  (keepbefore(Time,Deps,NewDeps),
           passevent(NewDeps,Bus,Place,[time,lastcorr|Opts],Day,A))
ip	 dmeq(attime,AT),number(Time). %% in time means around



justearly rule
is  EA isa earliness,srel/pwith/earliness/EA/_,
    not ispresent srel/after/time/_/_ , %% fortest mulig etter tid
    not ispresent srel/nil/time/_/_ ,  %% nå kl 1745
    not ispresent srel/before/time/_/_  %% "raskest"
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
    with	   passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 setopt(firstcorr,Opts,Opts1).


justlate rule
is  EA isa lateness,srel/pwith/thing/EA/_, %% TA-100914
    not ispresent srel/after/time/_/_ , %% fortest mulig etter tid
    not ispresent srel/nil/time/_/_ ,  %% nå kl 1745
    not ispresent srel/before/time/_/_  %% "raskest"
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
    with	   passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 setopt(lastcorr,Opts,Opts1).

howlongmeanshowlate rule
is  EA isa duration,srel/at/time/EA/_,
    not ispresent srel/after/time/_/_ , %% fortest mulig etter tid
    not srel/nil/time/_/_ ,
    not ispresent srel/before/time/_/_  %% "raskest"
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
    with	   passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 setopt(lastcorr,Opts,Opts1).


fastap rule  % ... fast (as possible)
is  srel/fast/pmode/nil/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
    with		(timenow2(0,MinTime),keepafter(MinTime,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 not member(to,Opts), %% not arrival but departure time
    setopt(time,Opts,Opts0),
    setopt(next(1),Opts0,Opts1). %% Not last etc


%  ARRIVALS


% ...after a time? Place the keepafter at the right place
%  This is AD Hoc and Ugly

arrwitharr rule
is  Time isa Departure1, srel/pwith/Departure2/Time/_E
id  replace ( passevent(Deps,Bus,Place,Opts,Day,A))
    with (    keepbefore(Time,Deps,NewDeps),
           passevent(NewDeps,Bus,Place,[time|Opts],Day,A))
ip  number(Time),
    dmeq([arrival,stop],Departure1),
    dmeq([arrival,stop],Departure2).


withdep rule
is  Time isa Departure1, srel/pwith/Departure2/Time/_E
id       replace ( passevent(Deps,Bus,Place,Opts,Day,A))
         with (    keepafter(Time,Deps,NewDeps),
                             passevent(NewDeps,Bus,Place,[time|Opts],Day,A))
ip       number(Time),
    dmeq([departure,start],Departure1),
    dmeq([departure,start],Departure2),
    not testmember(to,Opts).


gofromclock rule %% BEFORE busbeforetime rules
is  ispresent doit/go/_/A,
    ispresent srel/from/place/_/A,
    not srel/nil/time/_/_ ,
    not srel/in_order_to/_/_/_,  % heuristic
    not dob/reach/_/_/_              % heuristic
id	 replace ( passevent(Deps,Bus,Place,Opts,Day,A))
	 with (    keepafter(Time,Deps,NewDeps),
              passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 number(Time),
    setopt(time,Opts,Opts1).


earlierdeparture rule %%
is  ispresent adj/comp/early/D/real,  ispresent D isa departure,
    not srel/last/time/_/_ ,
    not ispresent srel/before/time/_/_, %%  then not nextaftertime
    not ispresent srel/to/clock/_/_     %% Norwagism
id	 not flag(earlierbus),  %% Retention
    add flag(earlierbus),
    not  keepbefore(_,_,_),            %% ( om kvelden etter 1800)
    replace ( passevent(Deps,Bus,Place,Opts,Day,A))
	 with (    keepbefore(FDT1,Deps,NewDeps),
			     passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 member(from,Opts), %% in case two passevents, select the right
    main:myflags(firstdeparturetime,FDT), %% first
    main:subfromtime(FDT,1,FDT1),
    setopt(time,Opts,Opts0),
    setopt(lastcorr,Opts0,Opts1)
:-double.


igoearlier rule
is  ispresent srel/earlier/time/nil/_,
    not srel/last/time/_/_ ,
    not ispresent srel/before/time/_/_, %%  then not nextaftertime
    not ispresent srel/to/clock/_/_     %% Norwagism
id	 not flag(earlierbus),  %% Retention
    add flag(earlierbus),
    not  keepbefore(_,_,_),            %% ( om kvelden etter 1800)
    replace ( passevent(Deps,Bus,Place,Opts,Day,A))
	 with (    keepbefore(FDT1,Deps,NewDeps),
			     passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 member(to,Opts), %% in case two passevents, select the right
    main:myflags(lastarrivaltime,FDT),
    main:subfromtime(FDT,1,FDT1),
    setopt(time,Opts,Opts0),
    setopt(lastcorr,Opts0,Opts1)
:-double.

earlierarrival rule %%
is  ispresent adj/comp/early/_A_/real,
    not srel/last/time/_/_ ,
    not ispresent srel/before/time/_/_, %%  then not nextaftertime
    not ispresent srel/to/clock/_/_     %% Norwagism
id	 not flag(earlierbus),  %% Retention
    add flag(earlierbus),
    not  keepbefore(_,_,_),            %% ( om kvelden etter 1800)
    replace ( passevent(Deps,Bus,Place,Opts,Day,A))
	 with (    keepbefore(FDT1,Deps,NewDeps),
			     passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 member(to,Opts), %% in case two passevents, select the right
    main:myflags(lastarrivaltime,FDT),
    main:subfromtime(FDT,1,FDT1),
    setopt(time,Opts,Opts0),
    setopt(lastcorr,Opts0,Opts1)
:-double.


laterarrival rule
is  ispresent adj/comp/late/D/real, ispresent D isa arrival,  %% LATER
    not srel/last/time/_/_ ,
    not ispresent srel/before/time/_/_, %%  then not nextaftertime
    not ispresent srel/to/clock/_/_     %% Norwagism
id	 not flag(laterbus),  %% Retention
    add flag(laterbus),
    not  keepafter(_,_,_),            %% ( om kvelden etter 1800)
    replace ( passevent(Deps,Bus,Place,Opts,Day,A))
	 with (    keepafter(FDT1,Deps,NewDeps),
			     passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 \+ member(from,Opts), %% in case two passevents, select the right
    main:myflags(lastarrivaltime,FDT),
    main:addtotime(FDT,1,FDT1),
    setopt(time,Opts,Opts0),
    setopt(nextaftertime(1),Opts0,Opts1)
:-double.


laterdeparture rule
is  ispresent adj/comp/late/_A_/real,
    not srel/last/time/_/_ ,
    not ispresent srel/before/time/_/_, %%  then not nextaftertime
    not ispresent srel/to/clock/_/_     %% Norwagism
id	 not flag(laterbus),  %% Retention
    add flag(laterbus),
    not  keepafter(_,_,_),            %% ( om kvelden etter 1800)
    replace ( passevent(Deps,Bus,Place,Opts,Day,A))
	 with (    keepafter(FDT1,Deps,NewDeps),
			     passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 \+ member(to,Opts), %% in case two passevents, select the right
    main:myflags(firstdeparturetime,FDT),
    main:addtotime(FDT,1,FDT1),
    setopt(time,Opts,Opts0),
    setopt(nextaftertime(1),Opts0,Opts1)
:-double.


igobefore rule %%  Which bus go before -that-
is  ispresent srel/beforethat/time/nil/_,
    not srel/first/time/_/_ ,
    not ispresent srel/after/time/_/_,  %% then not nextaftertime
    not srel/last/time/_/_ ,
    not ispresent srel/before/time/_/_, %%  then not nextaftertime
    not ispresent srel/to/clock/_/_     %% Norwagism
id	 not flag(earlierbus),  %% Retention
    add flag(earlierbus),
    not  keebefore(_,_,_),
    replace ( passevent(Deps,Bus,Place,Opts,Day,A))
	 with (    keepbefore(FDT1,Deps,NewDeps),
			     passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 \+ member(from,Opts), %% in case two passevents, select the right
    main:myflags(lastarrivaltime,FDT),
    main:subfromtime(FDT,1,FDT1),
    setopts([time,lastcorr],Opts,Opts1)
:-double.




igolater rule
is  ispresent srel/thereafter/time/nil/_,
    not srel/last/time/_/_ ,
    not ispresent srel/before/time/_/_, %%  then not nextaftertime
    not ispresent srel/to/clock/_/_     %% Norwagism
id	 not flag(laterbus),  %% Retention
    add flag(laterbus),
    not  keepafter(_,_,_),            %% ( om kvelden etter 1800)
    replace ( passevent(Deps,Bus,Place,Opts,Day,A))
	 with (    keepafter(FDT1,Deps,NewDeps),
			     passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 \+ member(to,Opts), %% in case two passevents, select the right
    main:myflags(firstdeparturetime,FDT),
    main:addtotime(FDT,1,FDT1),
    setopt(time,Opts,Opts0),
    setopt(nextaftertime(1),Opts0,Opts1)
:-double.



nowresetotady  rule       %% If explicit NOW, reset today if necessary
is  srel/now/time/nil/_
id	 not atday(_),
    today(Tuesday),
    add atday(Tuesday)
ip  main:frame_getvalue(day,Friday,day),
    Tuesday \== Friday
:- double.


nowwhat rule
is  srel/now/time/nil/_,
    not ispresent srel/after/time/1650/_  %% TA-110411

id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with (timenow2(0,Time),
               keepafter(Time,Deps,NewDeps),
               passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip  \+ member(to,Opts), %% NOW never about destination
    setopts([time,firstcorr],Opts,Opts1).



%% PLACES




keepfrombaywithbus rule %% go from center
is  not ispresent srel/from/place/X/_  when { bound(X)},
    not ispresent srel/nil/place/X/_  when { bound(X)},
    ispresent BB isa Bus, %% 5 to ila = route 5
      {bound(BB),dmeq([bus,route],Bus)} %% TA-110215
id  not flag(exit),
    not keepafter(_,_,_), %% TA-110218 FARA
    not message(neverpasses(_,_)),
    not flag(keepfrombay),
    not keepto(_,_,_),
    not keepfrom(_,_,_),
    not passevent(_,_,_,[from|_],_,_),
    not connections(_,_,_,_,_,_,_,_,_,_),
    passevent(_Depset,_,OnPlace,Opts,Day,_E),
    atdate2(DaySeqNo,_Date),
    add flag(keepfrombay),
    add (departure(BB,Hovedterminalen,DaySeqNo,NewDepset), %% is the to-station
			passevent(NewDepset,Bus,Hovedterminalen,[from],Day,E))  %% not time opt
ip  member(to,Opts),
    \+ central_fromstation(OnPlace), %%  til torget
    \+ samefplace(OnPlace,hovedterminalen),
    \+ fromstationonly(OnPlace),
    bus_dependent_station(Bus,hovedterminalen,Hovedterminalen),
    newfree(E)
 :- single.



keepfrombay rule %% go from center
is   {\+ main:myflags(new_origin,true)}, %% NO GPS %% TA-110218
    not ispresent srel/here/place/nil/_, %% fra her .. ???
    not ispresent srel/inwards/place/nil/_,
    not ispresent srel/from/___Place/X/_  %% in case of error srel/from/text/c/free(32)
           when { (bound(X), \+ home_town(X))}, %% TA-101111
    not ispresent srel/on/place/_/_ ,      %%  hvis jeg er på Samfundet
    not _IDI isa Dep when {dmeq([department],Dep)} %% ad hoc might be placoid
id  not flag(exit),              %% prefer (spurious) warning

    not flag(keepfrombay),   %%  Loop Stop
    not passevent(_,_,_,[from|_],_,_),
%%     not message(neverpasses(_,_)), %% subtle  11 til Brukseier Olsens vei?
    not keepto(_,_,_),
    not keepfrom(_,_,_),
    not connections(_,_,_,_,_,_,_,_,_,_),
    not departure(_,hovedterminalen,_,_),
    passevent(_Depset,Bus,OnPlace,Opts,Day,_E),
    atdate2(DaySeqNo,_Date),
    add flag(keepfrombay),
    add (departure(Bus,Hovedterminalen,DaySeqNo, All),
			passevent(All,Bus,Hovedterminalen,[from],Day,E))  %% not time opt
ip  member(to,Opts),
    \+ central_fromstation(OnPlace), %%  til torget
    \+ samefplace(OnPlace,hovedterminalen),
    \+ fromstationonly(OnPlace),
    bus_dependent_station(Bus,hovedterminalen,Hovedterminalen),
          %% (NB, with deafult)
    \+ neverdeparts(Bus,hovedterminalen),  %%  neverpasses*   %%  OK if Bus is free
    newfree(E)
 :- single.


keeptobay rule %% = go to  center ?
is  not ispresent srel/outwards/place/nil/_,
    not ispresent srel/nil/place/NTH/_ when { bound(NTH)},
    not ispresent srel/near/place/NTH/_ when { bound(NTH)}, %% n(ærm)este buss ******
    not ispresent srel/in/place/NTH/_ when { bound(NTH)},
    not ispresent srel/at/place/NTH/_ when { bound(NTH)},
    not ispresent srel/to/_Place/NTH/_ when { bound(NTH)}, %% Lingit: agent %% TA-110401
    not ispresent srel/towards/place/NTH/_ when { bound(NTH)}, %%  shakey
    not ispresent srel/to/meeting/_/_ ,
    not ispresent srel/on/place/_/_ ,
    not ispresent srel/past/place/_/_,
    not ispresent srel/from/place/sentrum/_ %% sentrum generic %% (anomalous q)
id  not flag(exit),
    not flag(nightbusflag),  %% meant for periphery
    not flag(keepfrombay),   %%
    not flag(keeptobay),     %%  Loop Stop
    not keepfrom(_,_,_),
    not keepto(_,_,_),
    not connections(_,_,_,_,_,_,_,_,_,_),
    not message(nocorresponse),
    add flag(keeptobay),
    passevent(_depset,Bus,OnPlace,Opts,Day,_e),
    not  passevent(_depset,_,_,[to],_Day,_e),
    not departure(_,hovedterminalen,_,_),
    atdate2(DaySeqNo,_Date),
    add (departure(FreeBus,Hovedterminalen,DaySeqNo,NewDepset), %% may switch
			passevent(NewDepset,Bus,Hovedterminalen,[to],Day,E))  %% not time opt
ip  member(from,Opts),
    \+ central_fromstation(OnPlace), %% e.g. Torget
    \+ samefplace(OnPlace,hovedterminalen),
    \+ tostationonly(OnPlace),
    bus_dependent_station(Bus,hovedterminalen,Hovedterminalen),

    \+ neverarrives(Bus,hovedterminalen),  %% <-- NB neverpasses*
     %% som NIGHTbuses doit/ some dont !

    newfree(E),
    newfree(FreeBus)
:-single.


%%% TIMES

busaroundtimearrdep rule  % fra A ca kl T til D -> Avgang (?)
is  srel/around/CLO/Time/_ , {   number(Time)},
    not Time isa minute,
    not srel/in_order_to/thing/_/_,
    not srel/because_of/_Thing/_/_,
    ispresent srel/from/place/_/_  %% ispresent form thn around = around DEP
id	 replace    passevent(Deps,Bus,Place,Opts,Day,A)
    with     ( keeparound(Time,Deps,NewDeps),
               passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq(timeclock,CLO),
    member(from,Opts),   %
    setopt(time,Opts,Opts1). %% NOT lastcorr


busaroundtimedep rule  % around time departure %% 1
is  srel/AROUND/CLO/Time/_ ,                   %% buss 36 rundt 730
    not Time isa minute
id	 replace    passevent(Deps,Bus,Place,Opts,Day,A)
    with     ( keeparound(Time,Deps,NewDeps),
               passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq(timeclock,CLO),
    dmeq(around,AROUND), %% inclusive in
    member(from,Opts),  %
    number(Time),
    setopt(time,Opts,Opts1). %% NOT lastcorr


busaroundtimearr rule  %  around time arrival  %% 2
is  srel/AROUND/CLO/Time/_ ,
    not Time isa minute
id	 replace    passevent(Deps,Bus,Place,Opts,Day,A)
    with     ( keeparound(Time,Deps,NewDeps),
               passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq(timeclock,CLO),
    dmeq(around,AROUND), %% inclusive in
    member(to,Opts),  %
    number(Time),
    setopt(time,Opts,Opts1). %% NOT lastcorr



busaroundtime2 rule % bus around a time
is  srel/nil/time/Time/E, ispresent doit/go/Bus/E,
    not srel/in_order_to/_/_/_,
    not dob/reach/_/_/_
id  not flag(defaultdest), %% not given explicitly
    replace      passevent(Deps,Bus,Place,Opts,Day,E1)
    with      (  keeparound(Time,Deps,NewDeps),
                 passevent(NewDeps,Bus,Place,Opts1,Day,E1))
ip  member(from,Opts),  %% subtle,   default from ht
    setopt(time,Opts,Opts1)
:-single.



busbeforetime0 rule   % bus before a time? %%%  unstrict time limit (morningbus),
is  srel/BEFORE/CLO/Time/_ ,
    not srel/thereafter/time/nil/_ ,
    not ispresent adj/_/next/_/_, %% next HHMM means next after
    ispresent _ isa morningbus, %% not strict timelimit
    not Time isa minute
id	 replace    passevent(Deps,Bus,Place,Opts,Day,A)
    with    (  keepbefore(Time,Deps,NewDeps),      %% NB
               passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip dmeq(within,BEFORE),dmeq(timeclock,CLO),
   number(Time),
    \+ member(from,Opts),
   setopt(time,Opts,Opts1).


busbeforetime1 rule %%  before time, but not last  arrival
is  ispresent  Time isa clock,
    srel/BEFORE/CLO/Time/_A
id	 keepafter(_ATime,_,_),
    not ispresent adj/_/next/_/_, %% next HHMM means next after
    replace passevent(Deps,Bus,Place,Opts,Day,A)
    with  ( keepbefore(Time,Deps,NewDeps), %% NOT CLOSELY BEFORE !!!
		      passevent(NewDeps,Bus,Place,TOPT,Day,A))
ip	 dmeq(within,BEFORE),
    dmeq(timeclock,CLO), %% not duration
    \+ testmember(from,Opts), %% before -> arrivalplace
    number(Time),
    setopt(time,Opts,TOPT).


busarrjustbeforetime rule %% last arrival before time
is  ispresent  Time isa clock, { number(Time)},
    srel/AT/CLO/Time/_E, {dmeq(battime,AT),dmeq(timeclock,CLO)},

    not ispresent doit/meetup/'I'/_, %% could be to the station
    not srel/thereafter/time/nil/_ ,
    not srel/after/time/F/_  when {bound(F)}   %% then not lastcorr
id	 not flag(defaultdest), %% not given explicitly
    not keepafter(_,_,_),
    not keepbefore(_,_,_),  %% til risvollan kl 1500 før kl 1700.
    not keepbefore1(_,_,_),
    replace passevent(Deps,Bus,Place,Opts,Day,A)
    with (  keepbefore1(Time,Deps,NewDeps),  %% CLOSELY BEFORE !!!
            passevent(NewDeps,Bus,Place,TLCOPT,Day,A))
ip	  \+ main:member(from,Opts),
    setopt(time,Opts,Opts1),
    setopt(lastcorr,Opts1,TLCOPT).


busbeforetime3 rule  %% shouldn't apply to morningbus
is  srel/BEFORE/CLO/Time/_E ,
    not ispresent _ isa departure,
    not doit/meetup/'I'/_,
    not srel/after/time/_/_ ,  %% then not lastcorr
    not ispresent adj/_/next/_/_, %% next HHMM means next after
    not srel/thereafter/time/nil/_ ,
    not ispresent _ isa morningbus, %% not strict timelimit
    not (Time isa minute),
    not (Time isa day)          %%      3 days
id  not flag(defaultdest), %% not given explicitly
    not keepafter(_,_,_),
    replace    passevent(Deps,Bus,Place,Opts,Day,A)
    with   (keepbefore(Time,Deps,NewDeps),
            passevent(NewDeps,Bus,Place,TLCOPT,Day,A))
ip dmeq(within,BEFORE),dmeq(timeclock,CLO), %%  Not duration
   number(Time),
    \+ member(from,Opts),
%% member(to,Opts),  %% Too strong ! %%% *** Bussen går forbi NTH før 0815
   setopt(time,Opts,Opts1),
   setopt(lastcorr,Opts1,TLCOPT).


busbeforetime4 rule %% Allow bus from place before time
is  srel/BEFORE/CLO/Time/E,
    not ispresent _ isa departure,
    not srel/after/time/_/_ ,  %% then not lastcorr
    not ispresent srel/from/place/_/E ,%%
    not ispresent adj/_/next/_/_, %% next HHMM means next after
    not (Time isa day),        %% Panic  %%   3 days
    not (Time isa minute)      %% 10 minutes
id	 not flag(nightbusflag),
    not keepafter(_,_,_), %% ?
    replace   passevent(Deps,Bus,Place,Opts,Day,A)
    with   (  keepbefore1(Time,Deps,NewDeps),
              passevent(NewDeps,Bus,Place,TLCOPT,Day,A))
ip dmeq([at,before,by,in,on,to,until,within],BEFORE), %% not NIL
   dmeq(timeclock,CLO),
   number(Time),
   setopt(time,Opts,Opts1),
   setopt(lastcorr,Opts1,TLCOPT).


presentniltime1 rule %% buss 52 er fremme kl 19 %% TA-110531
is  srel/nil/CLO/Time/E,
    ispresent adj/nil/present/_52/_,
    not ispresent _ isa departure,
    not srel/after/time/_/_ ,  %% then not lastcorr
    not ispresent srel/from/place/_/E ,%%
    not ispresent adj/_/next/_/_, %% next HHMM means next after
    not (Time isa day),        %% Panic  %%   3 days
    not (Time isa minute)      %% 10 minutes
id	 not flag(nightbusflag),
    not keepafter(_,_,_), %% ?
    replace   passevent(Deps,Bus,Place,Opts,Day,A)
    with   (  keepbefore1(Time,Deps,NewDeps),
              passevent(NewDeps,Bus,Place,TLCOPT,Day,A))
ip dmeq(timeclock,CLO),
   number(Time),
   setopt(time,Opts,Opts1),
   setopt(lastcorr,Opts1,TLCOPT).



presentniltime2 rule %% buss 52 fremme kl 19 %% TA-110531 UGLY
is  srel/nil/CLO/Time/E,
    ispresent srel/there/place/nil/_, %% fremme
    not ispresent _ isa departure,
    not srel/after/time/_/_ ,  %% then not lastcorr
    not ispresent srel/from/place/_/E ,%%
    not ispresent adj/_/next/_/_, %% next HHMM means next after
    not (Time isa day),        %% Panic  %%   3 days
    not (Time isa minute)      %% 10 minutes
id	 not flag(nightbusflag),
    not keepafter(_,_,_), %% ?
    replace   passevent(Deps,Bus,Place,Opts,Day,A)
    with   (  keepbefore1(Time,Deps,NewDeps),
              passevent(NewDeps,Bus,Place,TLCOPT,Day,A))
ip dmeq(timeclock,CLO),
   number(Time),
   setopt(time,Opts,Opts1),
   setopt(lastcorr,Opts1,TLCOPT).


presentniltime3 rule %% buss 52 frem kl 19 %% TA-110531 UGLY
is  srel/nil/CLO/Time/E,
    ispresent srel/redundantly/thing/nil/_, %% fram
    not ispresent _ isa departure,
    not srel/after/time/_/_ ,  %% then not lastcorr
    not ispresent srel/from/place/_/E ,%%
    not ispresent adj/_/next/_/_, %% next HHMM means next after
    not (Time isa day),        %% Panic  %%   3 days
    not (Time isa minute)      %% 10 minutes
id	 not flag(nightbusflag),
    not keepafter(_,_,_), %% ?
    replace   passevent(Deps,Bus,Place,Opts,Day,A)
    with   (  keepbefore1(Time,Deps,NewDeps),
              passevent(NewDeps,Bus,Place,TLCOPT,Day,A))
ip dmeq(timeclock,CLO),
   number(Time),
   setopt(time,Opts,Opts1),
   setopt(lastcorr,Opts1,TLCOPT).


betweentimes rule %% (depart) after time1 before time2
is  srel/after/time/Time1/E,srel/before/time/Time2/E,
    not ispresent _ isa departure,
    not _Time isa minute
id replace   passevent(Deps,Bus,Place,Opts,Day,A)
    with   (  keepafter(Time1,Deps,NewDeps1),
              keepbefore(Time2,NewDeps1,NewDeps),
              passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip number(Time1),number(Time2),
   testmember(from,Opts),
   setopts([time],Opts,Opts1).



beforeatime rule %% Finally,  bus before time vanilla
is  srel/before/time/Time/_E,
    not ispresent _ isa departure,
    not Time isa minute
id replace   passevent(Deps,Bus,Place,Opts,Day,A)
    with   ( keepbefore(Time,Deps,NewDeps),
             passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip number(Time),
   testmember(to,Opts), %% <----
   setopts([time,lastcorr],Opts,Opts1).

prenoonarr1 rule %%   < 1200 %%  arrival
is  A isa prenoon,
    srel/AT/Time/A/_, {dmeq([in,nil,on,during2],AT)},
    not ispresent _ isa clock, %% if so, only for lateflag
        { dmeq([time,afternoon,daypart],Time)}
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with    (keepbefore(1200,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip	 testmember(to,Opts), %% before 1200 = to
    setopts([lastcorr,time],Opts,Opts1). %% avoid 0610 #-> 1145


afternoon1 rule % an afternoon  (>=1200)
is  has/day/afternoon/_/A,srel/AT/time/A/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with    (keepafter(1200,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip	 dmeq(at,AT),setopt(time,Opts,Opts1).


thisafternoon1 rule % This afternoon  (>=1200) < (=< 1800)
is  A isa afternoon,srel/AT/Time/A/_,
    not ispresent _ isa clock, %% if so, only for lateflag
       {dmeq([time,afternoon,daypart],Time)}
id	 today(Tday), atday(Tday), %% same day
    replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with    (keepafter(Deptime,Deps,NewDeps),
             keepbefore(1800,NewDeps,NewDeps1),
				 passevent(NewDeps1,Bus,Place,Opts1,Day,B))
ip	 dmeq(at,AT),setopt(time,Opts,Opts1),
    timenow2(0,NOW),
    Deptime is max(NOW,1200),
    Deptime < 1800.


defaultafternoon rule % This afternoon  (>=1200) < (=< 1800)
is  A isa afternoon,srel/AT/Time/A/_,
    not ispresent _ isa clock, %% if so, only for lateflag
       {dmeq([time,afternoon,daypart],Time)}
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with    (keepafter(Deptime,Deps,NewDeps),
             keepbefore(1800,NewDeps,NewDeps1),
				 passevent(NewDeps1,Bus,Place,Opts1,Day,B))
ip	 dmeq(at,AT),setopt(time,Opts,Opts1),
    Deptime is 1200.


afternoon2 rule % afternoon  (>=1200)
is  srel/afternoon/time/nil/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with    (keepafter(1200,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip	 setopt(time,Opts,Opts1).


morning1 rule % a morning  (=<1100)
is  has/day/morning/_/A,srel/AT/Time/A/_,
    not ispresent (CC isa clock) when {bound(CC)}
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with (keepafter(0430,Deps,NewDeps),
          keepbefore(1200,NewDeps,NewDeps1),
          passevent(NewDeps1,Bus,Place,Opts1,Day,B))
ip	 dmeq(at,AT),
    dmeq([time,daypart,morning],Time), %%  på lørdag formidag
    setopt(time,Opts,Opts0),
    setopt(firstcorr,Opts0,Opts1).


morning2from rule % This morning  (=<1200) , BEFORE = arrival
is  A isa morning,
    srel/AT/_Time_/A/_ , {dmeq([at,before,in,nil,on,during],AT)},
    not ispresent _ isa clock  %% then morning is dummy
id	 not  ispresent keepbefore1(_,_,_),
	 not  ispresent keepbefore(_,_,_),
    replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with (keepafter(0430,Deps,Deps1),
          keepbefore(1200,Deps1,NewDeps),
          passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip	 testmember(to,Opts), %%
    setopt(time,Opts,Opts1).

%%     setopt(firstcorr,Opts0,Opts1). %% "siste buss .. < 12?



morning3 rule % morning  (=<1200)
is  srel/MORNING/time/nil/_ %%  morning ---> this_morning
id	 not keepafter(_,_,_),
    not keepbefore1(_,_,_),
    not keepbefore(_,_,_),
    replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with		(keepafter(0430,Deps,NewDeps),
             keepbefore(1200,NewDeps,NewDeps1),
				 passevent(NewDeps1,Bus,Place,Opts1,Day,B))
ip	 dmeq(morning,MORNING),
    setopt(time,Opts,Opts0),
    setopt(firstcorr,Opts0,Opts1).

%% midtpådagen  rule % midt på dagen
eveningbeforenoon rule %% contradictory evening before noon
is  srel/EVENING/time/nil/_ % see and ignore
id  keepbefore1(F,_,_)      % before?  This is just an experiment
ip  dmeq(evening,EVENING),
    number(F), F < 1800.    %% Contradictory


thisafternoon rule % i ettermiddag %% > 1200
is  srel/this_afternoon/time/nil/_
id	 not flag(nightbusflag),
    not keepbefore(_,_,_),
    not keepbefore1(_,_,_),     %% evening is weak constraint
    not keepafter(_,_,_),  %%  Assume AM/PM problem is settled
    not keeparound(_,_,_),
    replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with		(keepafter(Maxtime,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip	 setopt(time,Opts,Opts1),
    timenow2(0,Thirteen),  Maxtime is max(1200,Thirteen).


evening rule % evening  ( > 1800)  , but if Time > 1800 then after Time !
is  srel/EVENING/time/nil/_
id	 not flag(nightbusflag),
    not keepbefore(_,_,_),
    not keepbefore1(_,_,_),     %% evening is weak constraint
    not keepafter(_,_,_),  %%  Assume AM/PM problem is settled
    not keeparound(_,_,_),
    replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with		(keepafter(Maxtime,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip	 dmeq(evening,EVENING),setopt(time,Opts,Opts1),
    timenow2(0,Nineteen),  Maxtime is max(1800,Nineteen).


dayevening rule % evening  ( > 1800)
is  srel/nil/daypart/N/_, N isa night,
    not ispresent adj/_/last/_/_
id	 not flag(nightbusflag),
    not keepbefore1(_,_,_),
    not keepafter(_,_,_),
    not keeparound(_,_,_),
    replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with		(keepafter(1800,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip	 setopt(time,Opts,Opts1).


eveningnightbus rule % Friday evening means friday midningt night
is  srel/nil/daypart/N/_,
    replaceall (N isa night)
    with       (N isa midnight)
id	 flag(nightbusflag),
    not keepbefore1(_,_,_),
    not keepafter(_,_,_),
    not keeparound(_,_,_)
ip	 [].


nightlybus rule % night bus ( > 2400)
is  ispresent A isa bus,adj/_/night/A/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with		(keepafter(2400,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip	 setopt(time,Opts,Opts1).


mornbus rule % morning bus
is  ispresent A isa bus,adj/_/morning/A/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with	(keepafter(0430,Deps,NewDeps),
		 passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip	 setopt(time,Opts,Opts1).


evebus rule % an evening  (>=1800  and =<2400)
is  has/day/evening/_/A,srel/AT/time/A/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with 	(keepafter(1800,Deps,NewDeps),                %% Changed generally
				 passevent(NewDeps,Bus,Place,[time|Opts],Day,B))
ip	 dmeq(at,AT).


thiseve rule % This evening  (>=1800)
is  A isa evening,srel/AT/TIMEEQ/A/_
id	 not keepbefore(_,_,_),                         %% tonight at 1800
    not keeparound(_,_,_),                         %%
    replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with		(keepafter(1800,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip	 testmember(from,Opts),
    setopt(time,Opts,Opts1),
    dmeq(at,AT),dmeq(timeclass,TIMEEQ).


nileve rule % evening  (>=1800 and =<2400)
is  srel/evening/time/nil/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with 	(keepafter(1800,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,[time|Opts],Day,B))
ip	 [].


% AFTERNOON

daysaftnoon rule % an afternoon  12-18
is  has/day/afternoon/_/A,srel/AT/time/A/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with 	(keepbetween(1200,1800,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,[time|Opts],Day,B))
ip	 dmeq(at,AT).


thisaft1218 rule % This afternoon  12-18
is  A isa afternoon,srel/AT/time/A/_ ,
    not ispresent _ isa clock %% if so, only for lateflag
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with		(keepbetween(1200,1800,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,[time|Opts],Day,B))
ip	 dmeq(at,AT).


aft1218 rule % afternoon  12-18
is  srel/afternoon/time/nil/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with 	(keepbetween(1200,1800,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,[time|Opts],Day,B))
ip	 [].


udayeve rule % Uday evening
is  srel/evening/day/nil/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with 	(keepafter(1800,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,[time|Opts],Day,B))
ip	 [].


udayaft rule % Uday afternoon
is  srel/afternoon/day/nil/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with 	(keepbetween(1200,1800,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,[time|Opts],Day,B))
ip	 [].


%% Night section

anight18 rule % a night  (>=1800)
is  has/day/night/_/A,srel/AT/time/A/_
id	 not keepafter(_,_,Deps),
	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with		(keepafter(1800,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip	 dmeq(at,AT),
    setopt(time,Opts,Opts1).



thisnightis18ormore rule % This night  (>=1800)
is  A isa night,
    srel/AT/time/A/_,
       {dmeq([after,at,in,nil,on],AT)}, %% \+ før kvelden
    not ispresent _ isa clock   %% then evening is just for lateflag
id	 not flag(nightbusflag),
    today(Wday),atday(Wday), %% same day
    not keepafter(_,_,Deps),
	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with		(keepafter(DepTime,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip  timenow2(0,NOW),DepTime is max(1800,NOW),
%%     testmember(from,Opts),
    setopts([time],Opts,Opts1).



nightis18 rule % This night  (>=1800)
is  A isa night,srel/AT/time/A/_,
    not ispresent _ isa clock   %% then evening is just for lateflag
id	 not flag(nightbusflag),
    not keepafter(_,_,Deps),
	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with		(keepafter(DepTime,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip  dmeq([at,in,nil,on],AT), %% før kvelden
    DepTime is 1800,
    setopts([time],Opts,Opts1). %% lastcorr neglected by NON sms


routeforeve rule  % Busroute for the evening
is  A isa night,srel/for/daypart/A/_
id	 not flag(nightbusflag),
    not keepafter(_,_,Deps),
	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with		(keepafter(1800,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip  setopt(time,Opts,Opts1).


night18 rule % night  (>=1800)
is  srel/night/time/nil/_
id	 not flag(nightbusflag),
    not keepafter(_,_,Deps),
	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with    (keepafter(1800,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip	  setopt(time,Opts,Opts1).


%% End night section


%% AT A TIME means before, around or after a time, depending
%% ---------------------------------------------------------


batbefore1 rule % be1 at a time (means the bus must be there before that time)
is  ispresent doit/be1/Self/D, ispresent Self isa self, srel/AT/time/_/D
id	 replace passevent(Deps,Bus,Place,Opts,Day,D)
	 with 		 (keeparound(Time,Deps,NewDeps),
					  passevent(NewDeps,Bus,Place,[time,lastcorr|Opts],Day,D))
ip	 dmeq(at,AT),number(Time).


beatbefore2 rule % be1 at a time (means the bus must be there before that time) % ?
is  ispresent doit/be1/Self/D, ispresent Self isa self,
    srel/AT/time/C/D, srel/nil/time/Time/B,srel/before/time/C/B
id	 replace passevent(Deps,Bus,Place,Opts,Day,D)
	 with   (keepbefore1(Time,Deps,NewDeps), %% Closely before
			   passevent(NewDeps,Bus,Place,[time,lastcorr|Opts],Day,D))
ip	 dmeq(at,AT),number(Time).


atatime1 rule % ...at a time?
is  srel/AT/time/Time/_  % precisely ???
id	 replace passevent(Deps,Bus,Place,[],Day,A)     %% Opts -> []
	 with	  ( keeparound(Time,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,[time],Day,A)) % time|Opts -> time
ip	 dmeq(at,AT),number(Time).

% ----------------------------------------------------------------------------

% ...from Time1 to Time2?
fromtimetotime rule
is  srel/from/time/Time1/_,srel/to/time/Time2/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with		(inttime(Time1,MinTime1),inttime(Time2,MinTime2),
				 keepbetween(MinTime1,MinTime2,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 number(Time1),number(Time2),setopt(time,Opts,Opts1).

% ...around a time? (+/- 15 min)
% (skulle vært implementert mer komplisert, men...)
aroundatime rule
is  srel/around/time/Time/A %% Same event A !
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with		( % inttime(Time,MinTime),

             keeparound(Time,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 number(Time),setopt(time,Opts,Opts1).


keepbus2 rule % buss 9 er i sentrum
is  ispresent Bus isa BR,srel/in/time/_/E, ispresent doit/be1/Bus/E
id	 not passevent(_,Bus,_,_,_,_),
    replace passevent(Deps,_,Place,Opts,Day,A)
	 with    (keepbus(Bus,Deps,NewDeps), %% !,
             passevent(NewDeps,Bus,Station,Opts,Day,A))
ip	 dmeq([bus,nightbus,route],BR),
    exbus(Bus),place_station(Place,Station).


keepbus3 rule % with Bus 8  % This is a reserve rule,  too late for bus dependence -> 2415
is  ispresent Bus isa BR,srel/W/V/Bus/_
id	 not passevent(_,Bus,_,_,_,_),
    replace passevent(Deps,_,Place,Opts,Day,A)
	 with   (keepbus(Bus,Deps,NewDeps), %% !,
            passevent(NewDeps,Bus,Station,Opts,Day,A))
ip	 testmember(from,Opts), %% only the departure bus is important
    dmeq([bus,nightbus,route,tram],BR),
    dmeq([for,with,on,by,via,from],W),  %%  for %%  (missp før 19)?
    dmeq([vehicle,route,bus],V),
    bound(Bus), %% bus or tram exbus(Bus),
    place_station(Place,Station).


keepbus4 rule % with line 8
is  has/_/departure/Bus/_, ispresent Bus isa BR %% nb swap
id	 not passevent(_,Bus,_,_,_,_),
    replace passevent(Deps,_,Place,Opts,Day,A)
	 with  (keepbus(Bus,Deps,NewDeps), %% !,
           passevent(NewDeps,Bus,Station,Opts,Day,A))
ip	 dmeq([bus,nightbus,route],BR),
    exbus(Bus),place_station(Place,Station).


keepbus5 rule % bus that has number 8
is  has/vehicle/number/F/H,
    ispresent F isa BR, H isa number
id	 replace passevent(Deps,_,Place,Opts,Day,A)
	 with  (keepbus(H,Deps,NewDeps), %% !,
           passevent(NewDeps,F,Station,Opts,Day,A))
ip	 dmeq([bus,nightbus,route],BR),
    exbus(H),
    place_station(Place,Station).


avoidbus rule  % avoid  Bus 8
is  dob/avoid/'I'/B9/_, ispresent B9 isa BR ,
     {dmeq([bus,nightbus,route,tram],BR)}
id	 replace passevent(Deps,X,Place,Opts,Day,E)
	 with    (avoidbus(B9,Deps,NewDeps),
				 passevent(NewDeps,X,Station,Opts,Day,E))
ip	 bound(B9),bus(B9), %% exbus  exclusive bus/ bus inclusive tram
    place_station(Place,Station).

exceptbus1 rule  % except  Bus 8
is  srel/except/_/B8/_,ispresent Bus isa BR, {bound(B8)}
id	 replace passevent(Deps,X,Place,Opts,Day,A)
	 with    (avoidbus(B8,Deps,NewDeps),
				 passevent(NewDeps,X,Station,Opts,Day,A))
ip	 dmeq([bus,nightbus,route,tram],BR),
    bound(Bus),
    bus(Bus), %% exbus  exclusive bus/ bus inclusive tram
    place_station(Place,Station).

exceptbus2 rule  % except  Bus 8
is  ispresent Bus isa BR, comp/_/ne/_/Bus
id	 replace passevent(Deps,X,Place,Opts,Day,A)
	 with    (avoidbus(Bus,Deps,NewDeps),
				 passevent(NewDeps,X,Station,Opts,Day,A))
ip	 dmeq([bus,nightbus,route,tram],BR),
    bound(Bus),
    bus(Bus), %% exbus  exclusive bus/ bus inclusive tram
    place_station(Place,Station).


goexceptbus rule % go except  Bus 8
is  ispresent Bus isa BR, srel/Except/vehicle/Bus/_,
     {dmeq([except,without],Except)}
id	 replace passevent(Deps,X,Place,Opts,Day,A)
	 with    (avoidbus(Bus,Deps,NewDeps),
				 passevent(NewDeps,X,Station,Opts,Day,A))
ip	 dmeq([bus,nightbus,route,tram],BR),
    bound(Bus),
    bus(Bus), %% exbus  exclusive bus/ bus inclusive tram
    place_station(Place,Station).



%%%%% first/last/next/Nth bus


firstNbus rule  % first  N departures
is  quant(eq/N,B), adj/_/first/B/_ , ispresent B isa Veh
id	 replace passevent(Deps,Bus,Place,Opts, Day,A)
	 with    passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 dmeq(vehicle,Veh),
    setopt(first(N),Opts,Opts1).


firstNdep rule % first  N departures
is  quant(eq/N,AD), adj/_/first/AD/_ , AD isa ARRDEP
id	 replace passevent(Deps,Bus,Place,Opts, Day,A)
	 with    passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 dmeq(arrdep,ARRDEP),
    setopt(first(N),Opts,Opts1).


firstarr rule %  first ARRDEP
is  adj/_/first/AD/_, ispresent AD isa ARRDEP
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with		passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 dmeq(arrdep,ARRDEP),
    \+ main:member(nextaftertime(_),Opts),
    setopt(first(1),Opts,Opts1).            %%


firsttime rule % first time
is  adj/_/first/Time/_,ispresent Time isa Timeq
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with		passevent(Deps,Bus,Place,[first(1)|Opts],Day,A)
ip	 dmeq(time,Timeq).


%%% NEXT N BUS Section %%%%%%%%%%%%%%%%

nextnbusaftertime rule %%  % next N buses after time see also nextnaftertime
is  quant(eq/N,BD), {(bound(N), N >= 0)},
    adj/_/Next/BD/_ ,
    srel/after/TiCo/Time/_A ,ispresent BD isa BDA,
    not srel/last/time/_/_
id	 not  keepafter(_,_,_),  %%% <-------
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with  ( passevent(NewDeps,Bus,Place,Opts1,Day,A),
            keepafter(Time,Deps,NewDeps))
ip	 dmeq(timeclock,TiCo),
    dmeq([next,first],Next),
    dmeq(busdeparr,BDA),
    number(Time),
    setopt(time,Opts,Opts0),
    setopt(nextaftertime(N),Opts0,Opts1). %% not next after now


nextnaftertime rule % next N buses after time
is  quant(eq/N,BD), adj/_/Next/BD/_ ,ispresent BD isa BDA
id	 keepafter(_,_,Deps0),        %%% <-------
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with    passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 ( Deps == Deps0),
    dmeq([next,first],Next),  %%  First after = Next after  !
    dmeq(busdeparr,BDA),
    setopt(nextaftertime(N),Opts,Opts1). %% not next after now

nbusesaftertime rule %%  N buses after time
is  quant(eq/N,BD), { bound(N), N >= 0},
    srel/after/TiCo/Time/_A ,ispresent BD isa BDA,
    not srel/last/time/_/_
id	 not  keepafter(_,_,_),
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with  ( passevent(NewDeps,Bus,Place,Opts1,Day,A),
            keepafter(Time,Deps,NewDeps))
ip	 dmeq(timeclock,TiCo),
    dmeq(busdeparr,BDA),
    number(Time),
    setopt(time,Opts,Opts0),
    setopt(nextaftertime(N),Opts0,Opts1). %% not next after now


nextnbusesanotherday rule %%% Next bus another day   = first on that day IF different Actual day
is  quant(eq/N,BusF),adj/_/next/BusF/_ ,
    not ispresent _ isa clock,
    ispresent BusF isa VEH
id	 atday(Wed),
    not today(Wed),
    not message(date_day_route(_,Wed)), %%  not only different routeplan
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with    passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 \+ main:myflags(samedayflag,true), %% Ad Hoc: Global flag
    dmeq(vehicle,VEH),
    busorfree(BusF),
    setopt(first(N),Opts,Opts1).

nextnbuses rule % next N buses  %% next(N) is AMBIGUOUS  after now/ after time..
is  quant(eq/N,BD), ispresent BD isa BDA, ispresent adj/_/next/BD/_
id	 not keepafter(_,_,Deps), % "etter T" overstyrer "neste"
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	(timenow2(0,Time),keepafter(Time,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 number(N),N > 0,  %% leave max number to busanshp.pl %%
    dmeq(busdeparrN,BDA), %% N for night
    setopt(next(N),Opts,Opts1).

%% see also yesterdayevening
nextbusyesterday rule % Next bus after 2400, yesterdays routes
is  BusF isa Ag , {bound(BusF),exbus(BusF)},  %% I ...  routes for bus => fire twice
    {dmeq([agent,self,bus,route,vehicle,tram,train],Ag)}
id	 message(assumeyesterdepartures), %%
    atday(Wed),
    not today(Wed),
    not message(date_day_route(_,Wed)),
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with    (keepafter(T2400,Deps,Deps1), %% avoid morning routes!
             passevent(Deps1,Bus,Place,Opts1,Day,A))
ip	 \+ main:myflags(samedayflag,true),
     timenow(LT),LT < 0100, T2400 is LT+2400, %%
     setopt(next(1),Opts,Opts1).



nextbusanotherday rule % Next bus another day %% = first on that day IF different Actual day
is  adj/_/next/BusF/_ ,  {busorfree(BusF)},
    ispresent BusF isa VEH
id	 atday(Wed),
    not today(Wed),
    not message(date_day_route(_,Wed)), %%  not only different routeplan
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with    passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 \+ main:myflags(samedayflag,true), %% Ad Hoc: Global flag
    dmeq(vehicle,VEH),
    setopt(first(1),Opts,Opts1),busorfree(BusF).


%% moved after  NEXT N BUSES AFTER
busbeforetimedouble rule %%   bus before a time before time  early in the morning  (late at night ?)
is  srel/BEFORE/CLO/Time/_
id	 keepbefore(Time1,Deps,NewDeps),
    replace keepbefore(Time1,Deps,NewDeps)
		with 	    keepbefore(Time,Deps,NewDeps)
ip	 dmeq(within,BEFORE),dmeq(timeclock,CLO),
     number(Time),number(Time1),Time < Time1.


busdepattime0 rule  % bus goes time?
is  srel/AT/CLO/Time/E, ispresent doit/go/Bus/E, ispresent srel/from/place/Place/E,
    not srel/in_order_to/_/_/_,  % heuristic
    not dob/reach/_/_/_              % heuristic
id  replace passevent(Deps,Bus,Place,Opts,Day,E)
    with   ( keepafter(Time,Deps,NewDeps),
             passevent(NewDeps,Bus,Place,Opts1,Day,E))
ip  dmeq([at],AT),dmeq(timeclock,CLO),number(Time), %% bussen går 20 // attime  %% minutter før midnatt
    setopt(time,Opts,Opts1).


busdepaftertimegps rule %% missing fromplace %% TA-110406
is  {main:myflags(gpsflag,true)},

    srel/AFTER/CLO/Time/E,
            {dmeq(after,AFTER),
             dmeq(timeclock,CLO)},
    not ispresent _ isa arrival,

    not  ispresent srel/from/place/_Place/E,  % solsiden %% what if GPS ??

    ispresent Time isa clock,
    not ispresent srel/around/time/_/_, %% confuse
    not ispresent srel/before/time/_/_, %% // not nextbusafter
    ispresent doit/Go/Bus/E, {Bus \== 'I'},  %% ad hoc
          {dmeq([go,be,be1],Go)},        %% hvor er bussen

    not srel/in_order_to/_/_/_,        % heuristic
    not srel/so_that/_/_/_,
    not dob/reach/_/_/_ ,              % heuristic
    not Time isa minute
id  not keepafter(_,_,_), %%  etter 1800 om kvelden

    replace  passevent(Deps,Bus1,Place,Opts,Day,E) % Place=Dokkparken?
    with   ( keepafter(Time,Deps,NewDeps),         % Bus -> Bus1 %% TA-110406
             passevent(NewDeps,Bus1,Place,Opts1,Day,E))

ip  %% testmember(from,Opts), %% TA-110406
    number(Time), %% not duration
    setopts([time,nextaftertime(0)],Opts,Opts1).  %% allow several


busdepafter1time rule %% bus strictly after time // Technical after1
is  srel/after1/CLO/Time/E,  {dmeq(timeclock,CLO)},
    ispresent Time isa clock,
    not ispresent srel/around/time/_/_, %% confuse
    not ispresent srel/before/time/_/_, %% // not nextbusafter
    ispresent doit/Go/Bus/E, {Bus \== 'I'},  %% ad hoc
        {dmeq([go,be,be1],Go)},
   ispresent srel/from/place/_Place/E, %% solsiden
    not dob/reach/_/_/_ ,              %% heuristic
    not Time isa minute
id  not keepafter(_,_,_),
    replace  passevent(Deps,Bus,Place,Opts,Day,E)
    with   ( keepafter(Time1,Deps,NewDeps),  %% <---
             passevent(NewDeps,Bus,Place,Opts1,Day,E))
ip  number(Time), %% not duration
    addtotime(Time,1,Time1), %% <--
    setopts([time,firstcorr,nextaftertime(1)],Opts,Opts1).


busdepaftertime3 rule
is  srel/AFTER/CLO/Time/E,
            {dmeq(after,AFTER),
             dmeq(timeclock,CLO)},
    not ispresent srel/there/place/nil/_, %% fremme = ankomme %% TA-110415 haz ?
    not ispresent _ isa arrival,
    ispresent Time isa clock,
    not ispresent srel/around/time/_/_, %% confuse
    not ispresent srel/before/time/_/_, %% // not nextbusafter
    ispresent doit/Go/Bus/E, {Bus \== 'I'},  %% ad hoc
          {dmeq([go,be,be1],Go)},        %% hvor er bussen
    ispresent srel/from/place/_Place/E,  % solsiden %% what if GPS ?? %% TA-110406
    not srel/in_order_to/_/_/_,        % heuristic
    not srel/so_that/_/_/_,
    not dob/reach/_/_/_ ,              % heuristic
    not Time isa minute
id  not keepafter(_,_,_), %%  etter 1800 om kvelden

    replace  passevent(Deps,Bus,Place,Opts,Day,E) % Place=Dokkparken?
    with   ( keepafter(Time,Deps,NewDeps),
             passevent(NewDeps,Bus,Place,Opts1,Day,E))

ip  testmember(from,Opts),
    number(Time), %% not duration
    setopts([time,nextaftertime(0)],Opts,Opts1).  %% allow several



busdepaftertimehereafter rule % ...after a clock?
is  srel/after/Thing/Time/_, ispresent Time isa clock,
    ispresent srel/hereafter/time/nil/_
id	 not  keepafter(_,_,_),
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with (keepafter(Time,Deps,NewDeps),
               passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq([time,thing],Thing),   %% catch   bus after time to...
    number(Time),
    \+ member(to,Opts),
    setopts([time,firstcorr],Opts,Opts1).

departurebetweentimes rule % between 1700 and 1630 means departure between
is  srel/after/Thing/Time1/_,
    ispresent Time1 isa clock,
    srel/before/_/Time2/_,  %% not present, must use up
    ispresent Time2 isa clock,
    not ispresent srel/around/time/_/_, %% confuse
    not srel/in_order_to/_/_/_
id	 not  keepafter(_,_,_),
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with (keepafter(Time1,Deps,NewDeps1),
          keepbefore(Time2,NewDeps1,NewDeps),
          passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq([time,thing],Thing),
    number(Time1), number(Time2),
    \+ member(to,Opts),
    setopts([time],Opts,Opts1). %%


busaftertimebetw rule % ...after a clock? but before another cloc
                      % should ideally consider evening time/ tomorrow
is  srel/after/Thing/Time/_, ispresent Time isa clock,
    ispresent srel/before/time/T10/_,
    not ispresent srel/around/time/_/_, %% confuse
    not ispresent T10 isa minute      %% Ad Hoc
%%%     not srel/in_order_to/_/_/_
id	 not  keepafter(_,_,_),
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with (keepafter(Time,Deps,NewDeps),
               passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq([time,thing],Thing),   %% catch   bus after time to...
    number(Time),
    \+ member(to,Opts),
    setopts([time],Opts,Opts1). %%


busaftertime5 rule % ...after a clock?
is  srel/after/Thing/Time/E, ispresent Time isa clock,
    not ispresent srel/around/time/_/_, %% confuse

%% not srel/in_order_to/_/_/_,    %% for å rekke en buss som går 09.30 fra byen?
                                   %% for å gå fra ?
    ispresent doit/go/V/E, {dmeq(vehicle,V)}, %% same event
    not ispresent adj/_/last/_/real,
    not ispresent doit/arrive/_/_
id	 not message(nocorresponse), %%  for å rekke en buss som går 09.30 fra byen?
    not  keepafter(_,_,_),
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with (keepafter(Time,Deps,NewDeps),
               passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq([time,thing],Thing),   %% catch   bus after time to...
    number(Time),
    \+ member(to,Opts),
    setopts([time,firstcorr],Opts,Opts1).

buswitharraftertime rule %% buss med ankomst etter KL
is  _B isa arrival,      %% srel/_Nilwith_/arrival/B/_,
    srel/after/time/Time/_, {number(Time)}, %% not duration
    not ispresent srel/around/time/_/_,
    ispresent srel/To/place/_Place/_, { dmeq([to,nil],To)},
    not Time isa minute
id  not keepafter(_,_,_), %%  etter 1800 om kvelden //not already
    replace  passevent(Deps,Bus1,Place,Opts,Day,G)
    with   ( keepafter(Time,Deps,NewDeps),
             passevent(NewDeps,Bus1,Place,Opts1,Day,G))
ip  testmember(to,Opts), %% be sure it is the destination passevent
    setopts([time,nextaftertime(1)],Opts,Opts1).

busarraftertime1 rule %%  I arrive after Time
is  doit/arrive/_/E,
    srel/after/time/Time/E, {number(Time)}, %% not duration
    not ispresent srel/around/time/_/_,
    ispresent srel/To/place/_Place/_, { dmeq([to,nil],To)},
    not Time isa minute
id  not keepafter(_,_,_), %%  etter 1800 om kvelden //not already
    replace  passevent(Deps,Bus1,Place,Opts,Day,G)
    with   ( keepafter(Time,Deps,NewDeps),
             passevent(NewDeps,Bus1,Place,Opts1,Day,G))
ip  testmember(to,Opts), %% be sure it is the destination passevent
    setopts([time,nextaftertime(1)],Opts,Opts1).


busarraftertime2 rule %%  bus goes after Time (to place)
is  srel/AFTER/CLO/Time/E,
      { dmeq(after,AFTER),
        dmeq(timeclock,CLO),
         number(Time)}, %% not duration
    not ispresent srel/around/time/_/_,
    ispresent doit/Go/Bus/E, {dmeq([go,be1],Go)}, %%  ¤¤¤ Expensive ¤¤¤
    ispresent srel/To/place/Place/E, { dmeq([to,nil],To)},
    not srel/in_order_to/_/_/_,   % heuristic
    not dob/reach/_/_/_ ,             % heuristic
    not Time isa minute
id  not keepafter(_,_,_), %%  etter 1800 om kvelden //not already
    replace  passevent(Deps,Bus,Place,Opts,Day,E)
    with   ( keepafter(Time,Deps,NewDeps),
             passevent(NewDeps,Bus,Place,Opts1,Day,E))
ip  testmember(to,Opts), %% be sure it is the destination passevent
    setopts([time,nextaftertime(1)],Opts,Opts1).



%% moved after  NEXT N BUSES AFTER
busdepaftertime rule %% bus departure after a time
is  srel/After/TiCo/Time/_A,  {dmeq(after,After),dmeq(timeclock,TiCo)},
    not ispresent srel/there/place/nil/_, %% fremme = ankomme %% TA-110415 haz ?
    not ispresent _ isa arrival,

    ispresent Time isa clock, %% in afternoon ?
    not ispresent srel/earlier/time/_/_, %% ad hoc
    not ispresent srel/before/_Activity/_/_, %% confuse
    not ispresent srel/around/time/_/_, %% confuse
    not srel/in_order_to/_/_/_,
 %%%%   not srel/so_that/_/_/_,
    not ispresent doit/arrive/_/_,  %% <-- ?
    not srel/last/time/_/_ ,
    not srel/late/time/_/_ ,
    not srel/later/time/_/_ ,
    not ispresent srel/before/time/_/_, %%  then not nextaftertime
    not ispresent srel/to/clock/_/_,     %% Norwagism
    not ispresent adj/_/last/_/real
id	 not  keepafter(_,_,_),            %% ( om kvelden etter 1800)
    replace ( passevent(Deps,Bus,Place,Opts,Day,A))
	 with (    keepafter(Time,Deps,NewDeps),
			     passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 \+ member(to,Opts), %% in case two passevents, select the right
    number(Time),
    setopt(time,Opts,Opts0),
    setopt(nextaftertime(1),Opts0,Opts1).
%


%% ARRIVAL AFTER TIME -> moved after keepfrombay


afteratime rule % ...after a time?
is  srel/Hereafter/time/nil/_  ,
    not ispresent srel/after/time/_/_ , %% fortest mulig etter tid
    not ispresent srel/nil/time/_/_ ,  %% nå kl 1745
    not ispresent srel/before/time/_/_  %% "raskest"
id	 atday(Day),
    replace passevent(Deps,Bus,Place,Opts,Day,A)
    with		(timenow2(1,MinTime), %% add 1 minute
             keepafter(MinTime,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	   \+ testmember(to,Opts),     %% not next to destination !!!
    dmeq([now,hereafter],Hereafter),
    today(Day),  %% if another day, first in the morning
    not member(to,Opts), %% not arrival but departure time %%
                      %% This rules selects the right passevent if > 2
    setopt(time,Opts,Opts0),
    setopt(next(1),Opts0,Opts1). %% Not last etc


afteratime2 rule % ...after a time?  %% default,  OK with next bus to place
is  srel/Hereafter/time/nil/_ ,
    not srel/nil/time/_/_ ,
    not ispresent srel/after/time/_/_,  %% fortest mulig etter tid
    not ispresent srel/before/time/_/_  %% "raskest"
id	 atday(Day),
    replace passevent(Deps,Bus,Place,Opts,Day,A)
    with		(timenow2(0,MinTime),keepafter(MinTime,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq([now,hereafter],Hereafter),
    \+ testmember(to,Opts),     %% not next to destination !!!
    today(Day),
    setopts([time,next(1)],Opts,Opts1).


afteratime00 rule % ...from a time? %% defaultdest=> nil clock=after
is  srel/nil/time/Time/_,
    not srel/so_that/_/_/_,     %% NB  in_order_to = so_that
    not srel/in_order_to/_/_/_,
    not ispresent dob/reach/_/_/_
id	 not flag(defaultdest),
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with (keepafter(Time,Deps,NewDeps),
			 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 number(Time),
    \+ testmember(to,Opts), %% fram center actually
    setopt(nextaftertime(1),Opts,Opts1). %% (natural for SMS)

justnlastbuses rule  %%  cant take last Nth
is  quant(eq/N,BD), adj/_/last/BD/_ ,
    ispresent (BD isa BDA)
id  replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	passevent(Deps,Bus,Place,Opts2,Day,A)
ip	 dmeq(busdeparr,BDA),
    testmember(to,Opts),
    testmember(lastcorr,Opts),
    N1 is abs(N),   %% last N'th = last
    deleteall(lastcorr,Opts,Opts1),  %% not only last1
    setopt(last(N1),Opts1,Opts2).

%%%%  NTH bus coded as quant(eq/N ..), N < 0 // not anymore

keepfromgpslocation rule %% go from GPS-location %% TA-110418  After busdepaftertime
is  {main:myflags(gpsflag,true)},

    {main:myflags(new_origin,true)},  %% NB TA-110206

    not ispresent srel/from/___Place/X/_
           when { (bound(X), \+ home_town(X))},

    not ispresent srel/on/place/_/_       %%  hvis jeg er på Samfundet

id  not flag(exit),
    not flag(keepfrombay),  %%  Loop Stop
    not passevent(_,_,_,[from|_],_,_),
    not keepto(_,_,_),
    not keepfrom(_,_,_),
    not connections(_,_,_,_,_,_,_,_,_,_),
%%%%%    not departure(_,hovedterminalen,_,_), %% TA-110506

    passevent(_Depset,Bus,ToPlace,Opts,Day,_E), %% ToPlace !
    atdate2(DaySeqNo,_Date),
    add flag(keepfrombay),
    add (departure(Bus,user_location ,DaySeqNo, All), %% TA-110410
         keepafterwalking(All,Wall),                  %%
         passevent(Wall,Bus,user_location,[from],Day,E))  %% not time opt
ip  member(to,Opts),
   \+ fromstationonly(ToPlace),
    \+ neverdeparts(Bus,ToPlace),   %%  OK if Bus is free
    newfree(E)
 :- single.



keepfrombaygps rule %% go from GPS-location %%  After busdepaftertime
is  {main:myflags(gpsflag,true)},

    {main:myflags(new_origin,true)},  %% NB TA-110206

    not ispresent srel/from/___Place/X/_
           when { (bound(X), \+ home_town(X))},

    not ispresent srel/on/place/_/_       %%  hvis jeg er på Samfundet

id  not flag(exit),
    not flag(keepfrombay),  %%  Loop Stop
    not passevent(_,_,_,[from|_],_,_),
    not keepto(_,_,_),
    not keepfrom(_,_,_),
    not connections(_,_,_,_,_,_,_,_,_,_),
    not departure(_,hovedterminalen,_,_),

    passevent(_Depset,Bus,ToPlace,Opts,Day,_E), %% ToPlace !
    atdate2(DaySeqNo,_Date),
    add flag(keepfrombay),
    add (departure(Bus,Strandveien ,DaySeqNo, All),
         keepafter(NOW2,All,All2),
			passevent(All2,Bus,Strandveien,[from],Day,E))  %% not time opt
ip  member(to,Opts),
   \+ fromstationonly(ToPlace),
    \+ neverdeparts(Bus,ToPlace),   %%  OK if Bus is free
    newfree(E),

    gps_origin(Strandveien,Minutes), %% <---- !!! There are more!
%%    direct_connection(Strandveien,ToPlace,_Bus_), %% any bus ???
    timenow2(Minutes,NOW2) %% only consider deps after walking-time

 :- single.



justnthbusanotherday  rule
is  adj/_/ORD/BD/_, { (ordinal(ORD,N), N >1)},
    ispresent (BD isa BDA),
    not ispresent adj/_/last/_/_,
    not ispresent srel/before/time/_1700/_
id  atday(BB),
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with    passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 dmeq(busdeparrN,BDA),  %% first also for Nightbus
    today(AA), AA \== BB,
    N1 is N,
    setopt(nth(N1),Opts,Opts1).

justnthbusearly  rule
is  adj/_/ORD/BD/_, { ordinal(ORD,N)},
    ispresent (BD isa BDA),
    srel/today/_Day/nil/_,
    not ispresent adj/_/last/_/_,
    not ispresent srel/before/time/_1700/_
id  replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with    passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 dmeq(busdeparrN,BDA),  %% first also for Nightbus
    N1 is N,
    setopts([firstcorr,nth(N1)],Opts,Opts1).


justnthbustoday rule  %%% Nth bus = next N buses
is  adj/_/ORD/BD/_, { ordinal(ORD,N),N>1},  %% EXPERIMENT
    ispresent (BD isa BDA),          %% first bus -> firstbus1 (not nth)
    not ispresent _ isa morning,
    not ispresent adj/_/last/_/_,
    not ispresent srel/after/time/_/_ ,
    not ispresent srel/before/time/_/_ ,
    not ispresent srel/on/day/_/_
id  replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	(timenow2(0,Time),
             keepafter(Time,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq(busdeparr,BDA),
    \+ member(to,Opts),
    N1 is N,
    setopt(nth(N1),Opts,Opts1).

%%%%%   END < 0

justnbuses rule % N buses = next N buses
is  quant(eq/N,BD),  { (number(N),N > 1)},
    ispresent (BD isa BDA),
    not ispresent _ isa morning,
    not ispresent adj/_/last/_/_,
    not ispresent srel/after/time/_/_ ,
    not ispresent srel/before/time/_/_ ,
    not ispresent srel/on/day/_/_
id  not message(otherperiod(_)),
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	(timenow2(0,Time),
             keepafter(Time,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq(busdeparr,BDA),
    \+ member(to,Opts),
    setopt(next(N),Opts,Opts1).


firstbus2 rule % Dialog: first bus another day, no time
is  adj/_/First/_Bus/_
id	 not message(mustknow(place)),
    not keepbefore1(_,_,_), %% first before is irrelevant
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with	   ( keepafter(0430,Deps,NewDeps),
              passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq([first,early],First),
    setopt(first(1),Opts,Opts1):-
double.


firstbus1 rule % first bus
is  adj/_/First/Bus/_ , ispresent Bus isa Veh, {dmeq(vehicle,Veh)}
id	 not message(mustknow(place)),
    not keepbefore1(_,_,_), %% first before is irrelevant
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with	   passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 dmeq([first,early],First),
    setopt(first(1),Opts,Opts1).


firstbus3 rule  % bus goes first (samme situasjon som i passevent)
is  srel/first/time/nil/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 setopt(first(1),Opts,Opts1).


nextbus0 rule % next bus (samme buss som i passevent)
is  adj/_/next/BusF/_ ,
    not ispresent srel/before/time/_/_,
    not ispresent srel/around/time/_/_, %% <-- takes priority
    ispresent BusF isa VEH,
    not ispresent adj/_/last/BusF/_ %% NOT next last !!
id	 not keepafter(_,_,_), % "etter T" overstyrer "neste" Essential
    not keepbefore(_,_,_),
    not keepbefore1(_,_,_),
    not keepwithin(_,_,_,_),
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with  (  keepafter(Time,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq(vehicle,VEH),
    timenow2(0,Time),  %% at compiletime
    busorfree(BusF),
    \+ member(to,Opts),
    setopt(next(0),Opts,Opts1).  %%% next(0) means unspecified number



nextbus2 rule % next bus ARRDEP
is  ispresent AD isa ARRDEP,adj/_/next/AD/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with    (timenow2(0,Time),keepafter(Time,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq(arrdep,ARRDEP),
    \+ member(to,Opts),
    setopt(next(1),Opts,Opts1).


nextbus3 rule % next time
is  adj/_/next/Time/_,ispresent Time isa Timeq
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	(timenow2(0,Now),keepafter(Now,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq(time,Timeq),
    \+ member(to,Opts),
    setopt(next(1),Opts,Opts1).


secondlast rule % andre siste ( nest siste)
is  adj/nil/second/F/real, F isa BusF       %% alternative coding
id	 replace passevent(Deps,Bus,Place,Opts, Day,A)
	 with    passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 N1 is 2,
    setopt(last(N1),Opts,Opts1),busorfree(BusF).


thirdlast rule % nest nest siste)
is  adj/nil/second/F/real, F isa BusF   %% alternative coding
id	 replace passevent(Deps,Bus,Place,Opts, Day,A)
	 with    passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 N1 is 3,
    setopt(last(N1),Opts,Opts1),busorfree(BusF).


lastN rule % last  N buses  %% CANNOT TAKE N'th last = N last
is  quant(eq/N,BusF),adj/_/last/BusF/_
id	 replace passevent(Deps,Bus,Place,Opts, Day,A)
	 with    passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 N1 is abs(N),   %% CANNOT TAKE N'th last
    setopt(last(N1),Opts,Opts1),busorfree(BusF).


lastNdefault rule % N buses before, default last
is  quant(eq/N,BusF), { (number(N),N>0)},
    ispresent srel/before/time/T1/_,
    { number(T1)}
id	 replace passevent(Deps,Bus,Place,Opts, Day,A)
	 with    passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 setopt(last(N),Opts,Opts1),busorfree(BusF).


lastbus1 rule  % last bus (samme buss som i passevent)
is  adj/_/last/BusG/_  %% NB _ ==> BusG
%%     not ispresent _ isa clock  %% last bus after (SIC)
id	 replace passevent(Deps,BusG,Place,Opts,Day,A)
	 with 	passevent(Deps,BusG,Place,Opts1,Day,A)
ip	 setopt(last(1),Opts,Opts1).


lastbus2 rule % last bus (samme situasjon som i passevent)
is  adj/_/last/_/A
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 setopt(last(1),Opts,Opts1).


lastbus3 rule % bus goes last (samme situasjon som i passevent)
is  srel/Last/time/nil/_ , { dmeq([last,late],Last)}
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 setopt(last(1),Opts,Opts1).

lastbus4 rule % buss slutter å gå
is  end/_/F80,srel/in_order_to/thing/_F79/F80
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 setopt(last(1),Opts,Opts1).


%% see also nextbusyesterday
yesterdayevening  rule  %% 00:00 -- 00:30 , probably last evenings deps
is  _ isa bus or _ isa departure,  %% only relevant questions %% HAIRY  %% day is already fixed to yestarday
    not ispresent _ isa morning %% TA-110724
id	 flag(yesterday),
    remove flag(yesterday),
    addfront message(assumeyesterdepartures), %% TA-110816
        replace passevent(A,B,C,FROM,Day,D) %% NB [first(1),from],
        with    (keepafter(NEWLATETIME,A,A1), passevent(A1,B,C,FROM,Day,D)) %%
	 %%  only late departures yesterday
ip	 testmember(from,FROM),
    timenow(T30),
    addtotime(2400,T30,NEWLATETIME).


withlastbus rule % last ARRDEP
is  ispresent AD isa ARRDEP,adj/_/last/AD/_,
    not ispresent _ isa clock
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 dmeq(busdeparr,ARRDEP), %%  med siste buss
    setopt(last(1),Opts,Opts1).


lasttime rule % last time
is  adj/_/last/Time/_,ispresent Time isa Timeq
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 dmeq(time,Timeq),setopt(last(1),Opts,Opts1).



prevN rule % previous N buses
is  quant(eq/N,Bus),adj/_/previous/Bus/_
id	 not keepafter(_,_,Deps), % "etter T" overstyrer "neste"
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	(timenow2(0,Time),
             keepbefore(Time,Deps,NewDeps), %%   Not Closely
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 \+ member(from,Opts),  %%    ( NB avoid before departure)
    setopt(last(N),Opts,Opts1).



prevbus1 rule % previous bus (samme situasjon som i passevent)
is  adj/_/previous/_/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with		(timenow2(-1,Time), %% NB, < NOW otherwise, =next bus
             keepbefore(Time,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 setopts([lastcorr,last(1)],Opts,Opts1). %% Lastcorr will block keepafter NOW


prevarrdep rule % previous ARRDEP
is  ispresent AD isa ARRDEP,adj/_/previous/AD/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with		(timenow2(0,Time),keepbefore(Time,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq(arrdep,ARRDEP),setopt(last(1),Opts,Opts1).


prevtime rule % previous time
is  adj/_/previous/Time/_,ispresent Time isa Timeq
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with		(timenow2(0,Time),keepbefore(Time,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq(time,Timeq),setopt(last(1),Opts,Opts1).


nthbus1 rule % Nth bus (samme buss som i passevent)
is  adj/_/Nth/_Bus/_, %% Not nec same bus ( toplace1  frees the bus)
    {ordinal(Nth,N)} %%
id	 not message(mustknow(place)),
    not keepbefore1(_,_,_), %% not  Nth bus before
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 setopt(nth(N),Opts,Opts1).


nthbus2 rule % Nth ARRDEP
is  ispresent AD isa ARRDEP,adj/_/Nth/AD/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	passevent(Deps,Bus,Place,[nth(N)|Opts],Day,A)
ip	 dmeq(arrdep,ARRDEP),ordinal(Nth,N).


%%%%% N first/next/last

nbuses rule
is  quant(eq/N,Bus)
id	 replace passevent(Deps,Bus,Place,[next(_)],Day,A)
	 with		passevent(Deps,Bus,Place,[next(N)],Day,A)
ip	 [].

nnextbuses rule
is  quant(eq/N,Time),ispresent Time isa Timeq,ispresent adj/_/next/Time/_
id	 replace passevent(Deps,Bus,Place,[next(_)],Day,A)
	 with		passevent(Deps,Bus,Place,[next(N)],Day,A)
ip	 dmeq(time,Timeq).

nlastbuses rule
is  quant(eq/N,Bus)
id	 replace passevent(Deps,Bus,Place,[last(_)],Day,A)
	 with 	passevent(Deps,Bus,Place,[last(N)],Day,A)
ip	 [].


%%%%% N buses

nbuses9 rule
is  quant(eq/N,Bus)
id	 replace passevent(Deps,Bus,Place,[],Day,A)
	 with 	passevent(Deps,Bus,Place,[next(N)],Day,A)
ip	 [].


samebus rule
is  ispresent B isa bus, adj/_/same/B/_  %%  (same bus)
id  replace passevent(Deps,Bus,Place,Opts,Day,A)
    with    passevent(Deps,Bus,Place,[direct|Opts],Day,A)
ip  [].

%%%%% direct buses

direct1 rule
is  adj/_/direct/_Bus_/_
id  replace passevent(Deps,Bus,Place,Opts,Day,A)
    with    passevent(Deps,Bus,Place,[direct|Opts],Day,A)
ip  [].


directly rule
is  srel/directly/pmode/nil/_  % goes directly
id  replace passevent(Deps,Bus,Place,Opts,Day,A)
    with    passevent(Deps,Bus,Place,[direct|Opts],Day,A)
ip  [].



spesificroute rule
is ispresent BusN isa ROUTE
id not selectroute(_,_,_),
   replace passevent(Deps,BusN,Place,Opts,Day,A)
   with    (selectroute(Rid,Deps,NewDeps),
	    passevent(NewDeps,BusN,Place,Opts,Day,A))
ip dmeq(vehicle, ROUTE), getcurrent(Cid), getref(Cid, [Rid], lastroute(BusN))
:-double.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ingen filtrering av avgangssett (Depset) under her
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% To passeringer skal kobles

remreduntant rule % Fjerner redundant stasjon uten melding
is  []
id	 remove   departure(Free69,Haukaasen,_14472,_16791),
    remove   passevent(_16791,Free69,Haukaasen,[],_14472,_),
    departure(Free70,Haukaasen,_14472,_18230),
    passevent(_21388,Free70,Haukaasen,_,_14472,_)
ip	 Free69 \== Free70.



underspecneibresolve rule %% underspecified neighbourhood, alternative list
is  NTNU isa neighbourhood,  {bound(NTNU)},
    not ispresent (B isa bus) when { bound(B)},
    not ispresent (R isa route) when { bound(R)},
    not ispresent (T isa tram) when { bound(T)},
    not ispresent (X isa train) when { bound(X)},
    clear
id	 clear,
    add message(place_resolve(NTNU,List))
ip  underspecified_place(NTNU),
    main:set_of(Alt,place_resolve(NTNU,Alt),List),List \== [].

%% moved after  underspecneibresolve
underspecifiedneibbus rule %% underspecified neighbourhood, bus given
is  NTNU isa neighbourhood, { bound(NTNU)},
    ispresent B isa bus, { bound(B)},
    clear
id	 clear,
    add message(underspecified_place(NTNU))
ip  underspecified_place(NTNU),
    \+ bus_depend_station(B,NTNU,_).


underspecifiedneibnobus rule %% underspecified neighbourhood, no bus, no alt
is  NTNU isa neighbourhood,  { bound(NTNU)},
    not ispresent (B isa bus) when { bound(B)},
    not ispresent (R isa route) when { bound(R)},
    not ispresent (T isa tram)  when { bound(T)},
    not ispresent (X isa train) when { bound(X)},
    clear
id	 clear,
    add message(underspecified_place(NTNU))
ip  underspecified_place(NTNU).


underspecstatresolve rule %% underspecified neighbourhood, alternative list
is  NTNU isa station, { bound(NTNU)}, % in case neighbourhood is occluded
    clear
id	 clear,
    add message(place_resolve(NTNU,List))
ip  underspecified_place(NTNU),
    main:set_of(Alt,place_resolve(NTNU,Alt),List),List \== [].



underspecifiedstat rule %% underspecified station
is  Steinan isa station,  { bound(Steinan)},
    ispresent B isa Bus, { dmeq(vehicle,Bus)}, %% (neste=neste kjøretøy)
    clear
id	 clear,
    add message(underspecified_place(Steinan))
ip  underspecified_place(Steinan),
    \+ bus_depend_station(B,Steinan,_).


underspecifiedneibus rule %% underspecified neighb, bus#
is  Søndre isa neighbourhood, { bound(Søndre)},
    ispresent B isa Bus, { dmeq(vehicle,Bus)}, %% (neste=neste kjøretøy)
    clear
id	 clear,
    add message(underspecified_place(Søndre))
ip  underspecified_place(Søndre),
    \+ bus_depend_station(B,Søndre,_).



%%%%% To passeringer skal kobles

% Sjekker at det ikke er flere enn 2 stasjoner

toomanyplaces rule %% Går buss 9 fra dragvoll via moltmyra til flatåsen senter .
is  clear %% Doesn't work softly
id	 connections(_,_,_,_,_,_,_,_,_,_), %% 10 arg
    remove passevent(_,_,_,_,_,_),
    clear, %% Doesn't work softly
    addcon  message(toomanyplaces)
ip	 [].



connection0 rule %% Shortcircuit if sameplace
is  []
id	 not message(neverpasses(_,_)),
    remove passevent(_Depset1,_Bus1,Place1,_Opts1,_Day1,_),
    remove passevent(_Depset2,_Bus2,Place2,_Opts2,_Day2,_),
    add (message(sameplace(Place1,Place2))),
    removeall departure(_,_,_,_),
    removeall passevent(_,_,_,_,_,_),
    removeall keepafter(_,_,_),       %%
    removeall keepbefore(_,_,_),      %%
    removeall keepbefore1(_,_,_),     %%
    add flag(exit)
ip
    place_station(Place1,Station1),
    place_station(Place2,Station2),
    Station1 == Station2.  %% NEVER MAKE A CONNECTION TO ITSELF


connectionexplicit rule %% connect  2-> from to explicit
is  []            %% bus taken as from bus
id  not flag(exit),
    not connections(_,_,_,_,_,_,_,_,_,_),
    passevent(Depset1,Bus1,Place1,Opts1,Day,_),
       {testmember(from,Opts1)}, %%  Remove the from-station
    passevent(Depset2,Bus2,Place2,Opts2,Day,_),
       { testmember(to,Opts2)}, %%  Remove the to-station
    remove passevent(Depset1,Bus1,Place1,Opts1,Day,_),
    remove passevent(Depset2,Bus2,Place2,Opts2,Day,_),

    atdate2(SeqNo,_Date_),

    add (connections(Depset1,Depset2,Bus1,Station1,Station2,Day,SeqNo,OptsUnite,_,_)),
                                     %??% Bus2 ???
    add flag(exit)
ip	 mixopt(Opts2,Opts1,OptsUnite),
    place_station(Place2,Station2),
    place_station(Place1,Station1),
    Station2 \== Station1.  %% NEVER MAKE A CONNECTION TO ITSELF

connectionderived rule %% complicated 1. passevent = to, 2. passevent = nil
is  []
id  not flag(exit),
    not connections(_,_,_,_,_,_,_,_,_,_),

    passevent(Depset1,_bus1,Place1,Opts1,Day,_),
          {   testmember(to,Opts1) } ,

    passevent(Depset2,Bus2,Place2,Opts2,Day,_),
          {\+ testmember(to,Opts2) } ,

    remove passevent(Depset1,_bus1,Place1,Opts1,Day,_),
    remove  passevent(Depset2,Bus2,Place2,Opts2,Day,_),

    atdate2(SeqNo,_Date_),

    add (connections(Depset2,Depset1,Bus2,Station2,Station1,Day,SeqNo,OptsUnite,_,_)),
    add flag(exit)
ip	 mixopt(Opts2,Opts1,OptsUnite),
    place_station(Place2,Station2),
    place_station(Place1,Station1),
    Station2 \== Station1.  %% NEVER MAKE A CONNECTION TO ITSELF


connectionimplicit rule % no direction given or from to in sequence
is  []
id  not flag(exit),
    not connections(_,_,_,_,_,_,_,_,_,_),
    remove passevent(Depset1,Bus1,Place1,Opts1,Day,_),
    remove passevent(Depset2,_Bus2,Place2,Opts2,Day,_),
    atdate2(SeqNo,_Date_),
    add (connections(Depset1,Depset2,Bus1,Station1,Station2,Day,SeqNo,OptsUnite,_,_)),
    add flag(exit)
ip	 setopt(from,Opts1,Opts11), setopt(to,Opts2,Opts22),
    mixopt(Opts11,Opts22,OptsUnite),
    place_station(Place1,Station1),
    place_station(Place2,Station2),
    Station1 \== Station2.  %% NEVER MAKE A CONNECTION TO ITSELF



setnightbusoption rule % Set nightbusoption in connections
is  []
id  flag(nightbusflag),
    not flag(nightbusoption), %%% Loop stop
    add flag(nightbusoption),
    replace    connections(Depset1,Depset2,Bus2,Station1,Station2,Day,SeqNo,Opts1,X,Y)
    with       connections(Depset1,Depset2,Bus2,Station1,Station2,Day,SeqNo,OptsUnite,X,Y)
ip  setopt(nightbus,Opts1,OptsUnite).


superfluoustat rule % superfluous station buss fra samfundet  til munkvoll-heimdal.
is  remove  srel/T/place/JV/_ , {
    T \== there,             %% be there ...
    T \== here,              %% robust
    JV \== nil, %% ?
    \+ home_town(JV)  }
id  not  message(toomanyplaces),
    add  message(toomanyplaces),
    not flag(nightbusflag),     %% rough // fra munkegt til valøyveien
    not message(neverpasses(_,_)),
    not message(onlyoneplace),
    connections(_,_,_,A,B,_,_,_,_,_),
%%     add flag(exit)  %% irrelevant unless you  clear it all
    not flag(defaultdest) %% TA-110630 (defut dest means to few places)

ip  bound(JV),
    JV \== A,
    JV \== B,
    \+ placestat(JV,A),
    \+ placestat(JV,B),  %%
    \+ placestat(A,JV),
    \+ placestat(B,JV),
    \+ dmeq([sør,nord,øst,vest],JV).


connection3 rule % Kobler sammen to busspasseringer
is  []
id	 remove passevent(Depset1,_,Place1,Opts1,Day,_),
    remove passevent(Depset2,Bus2,Place2,Opts2,Day,_),
    atday2(SeqNo,_Date),
    add (connections(Depset1,Depset2,Bus2,Station1,Station2,Day,SeqNo,OptsUnite,_,_))
ip	 mixopt(Opts1,Opts2,OptsUnite),                          %% NB Added Arg %%
    place_station(Place1,Station1),
    place_station(Place2,Station2),
    not(member(from,Opts2)),
    not(member(to,Opts1)).


defaultlast rule %% % Legger paa default siste  busspassering (SMS)
is  not ispresent _ isa morning
id	 ispresent keepbefore(_4335,_3171,Deps1),
    not ispresent keepafter(_,_,_),
    replace connections(Deps2,_3724,_free,_lade,_nth,_3004,SeqNo,Opts,          _5276,_5277)
    with    connections(Deps2,_3724,_free,_lade,_nth,_3004,SeqNo,[last(1)|Opts],_5276,_5277)
ip	 main:myflags(smsflag,true),
    Deps1 == Deps2,  not (member(last(_),Opts)).


%%%%% Annet om stasjoner og steder


nameofstations rule % What is the name of the stations?
is  which(A),Station isa station,has/place/name/Station/A,
    not srel/at/place/_/_,     %%  (NB a station near station X)
    not srel/before/place/_/_,
    not srel/after/place/_/_
id	 add listofall(station,_)
ip  unbound(Station).


whichstationsk rule % Which stations do you know
is  which(A),tuc isa savant,A isa station,dob/KNOW1/tuc/A/_
  ,{dmeq([know,know1],KNOW1)}
id	 add listofall(station,_) %% only 5  first if SMS
ip  [].

whichstationhaveyou rule % Which stations have you
is  which(A),tuc isa savant,A isa station,has/agent/station/tuc/A
id	 add listofall(station,_) %% only 5  first if SMS
ip  [].

whichstationexist rule % Which stations have you
is  which(A),A isa station,doit/exist/A/_,  not srel/_Near/place/_/_, %% TA-100825
    not ispresent X isa Bus when {bound(X),dmeq(vehicle,Bus)} %% TA-110510
id	 add listofall(station,_) %% only 5  first if SMS
ip  [].

%% STATION NEIGHBOURHOOD SECTION


whereiscompany  rule % Where is AtB %% TA-101112
is  which(Place), TT isa company,
    doit/Be1/TT/A,srel/ION/place/Place/A,
        {dmeq([be,be1,lie1],Be1)},
        {dmeq([in,on,nil],ION)}
id	 not flag(exit),
    add (message(answer(db_reply(TT,streetaddress,K))))
ip  has_att_val(company,streetaddress,TT,K).


whereisstreet rule %%  subsumed by streetstatknown ?
is  which(S),doit/be1/Place/A,srel/in/place/S/A, ispresent Place isa street
id  not flag(exit),
    not message(nearest_station(_ST,_,_)),
    add stationsat(Place,_,_)
ip  bound(Place).


whereisstation3 rule  % Where is Station?
is  Station isa BussStat,has/SN/Wlace/Station/_
id	 add stationsat(_,Station,_)
ip  dmeq(busstation,BussStat),
    dmeq([station,neighbourhood],SN),
    dmeq([location,place,neighbourhood],Wlace),
    station(Station).

whatisstatnear rule %% TA-101116
is  which(F26),F26 isa station,
    Place isa neighbourhood,
    doit/be1/F26/F27,
    srel/near/place/Place/F27,
    event/real/F27
id	 not message(nearest_station(_ST,Place,_)), %%  Not double!
    add stationsat(Place,X,Y)
ip  bound(Place),
    \+ underspecified_place(Place), %% hvor er ntnu
    stationsat(Place,X,Y).


whereisneigh1 rule % Where is a neighbourhood
is  which(S),Place isa neighbourhood,doit/Be1/Place/A,srel/IN/place/S/A,
       {dmeq([lie1,be1],Be1)},
       {dmeq([in,nil,near],IN)} %% TA-101116
id	 not message(nearest_station(_ST,Place,_)), %%  Not double!
    add stationsat(Place,X,Y)
ip  bound(Place),
    \+ underspecified_place(Place), %% hvor er ntnu
    stationsat(Place,X,Y).


whereisneigh2 rule % Where is a neighbourhood
is  which(S),Place isa neighbourhood,has/neighbourhood/place/Place/S
id	 add stationsat(Place,_,_)
ip  bound(Place).


whereisstation rule % Where is Station?
is  exactly (which(Station),Station isa BussStat,event/real/_)
id	 add stationsat(_,Station,_)
ip  dmeq(busstation,BussStat),bound(Station).


whereisstation1 rule % Where ligger Station?
is  which(A),A isa place,MS isa station,doit/Lie1/MS /E,
       {bound(MS)}, {dmeq([lie1,be,be1],Lie1)}, srel/nil/place/A/E,event/real/E
id	 add stationsat(_,MS,_)
ip  dmeq(busstation,Station),bound(Station).


wherestationatplace rule % where is Station at Place?
is  which(F21),
    F21 isa place,
    doit/Be1/Stations/A,srel/AT/place/Place/A,
    srel/in/place/F21/A
id	 not message(nearest_station(_ST,_,_)),
    add stationsat(Place,Stations,SSS)
ip  dmeq([lie1,be1,exist],Be1),
    dmeq(nearat,AT),statorplace(Place),
    stationsat(Place,Stations,SSS).

whereisneareststationtoplace rule %%  where is the nearest Station to Place?
is  which(F29),    F29 isa place,
    RD isa station, { bound(RD)},
    adj/_/nearest/F28/real,
    doit/Be1/F28/E,
    srel/in/place/F29/E
id	 not message(nearest_station(_ST,_,_)),
    add stationsat(RD,_,SSS)
ip  dmeq([lie1,be1,exist],Be1),
    statorplace(RD),
    stationsat(RD,_,SSS).


whereisneareststation0 rule % where is nearest Station ?
is  which(F21),F21 isa station,
    adj/_/nearest/F21/_
id	 not message(nearest_station(_ST,_,_)),
    not message(mustknow(place)),
    add message(mustknow(place))
ip  [].



stationatstation   rule %% which station is near station
is  Station isa station,srel/around/place/Station/A,
    ispresent doit/Be1/Station/A,  { dmeq([lie1,be1,exist],Be1)}
id	 not message(nearest_station(_ST,_,_)),
    add stationsat(Station,Station,SSS)
ip  stationsat(Station,Station,SSS).



stationsatsentrumsterminalen rule %% which station is at hovedterminalen
is  Station isa station,  {unbound(Station)},
    doit/Be1/Station/A, { dmeq([lie1,be1,exist],Be1)},
    srel/AT/Placoid/Place/A, { dmeq([station,place],Placoid)},
        {dmeq([hovedterminalen],Place)}
id	 not message(nearest_station(_ST,_,_)),
    add stationsat(sentrum,Station,SSS)
ip  dmeq(nearat,AT),statorplace(Place),
    stationsat(sentrum,Station,SSS).


stationatplace rule %% which station is at Place
is  Station isa station,Place is neighbourhood, %% prof. Brochs gt ON torget *
    doit/Be1/Station/A, { dmeq([lie1,be1,exist],Be1)},
    srel/AT/Placoid/Place/A, { dmeq([station,place],Placoid)}
id	 not message(nearest_station(_ST,_,_)),
    add stationsat(Place,Station,SSS)
ip  dmeq(nearat,AT),statorplace(Place),
    stationsat(Place,Station,SSS).


stationsatneighbourhood rule     %% risvollansenteret og buenget er ved tempe (SIC) (avoid OK)
is  Place isa neighbourhood,
    doit/Be1/(_,_)/A,   {dmeq([lie1,be1,exist],Be1)},
    srel/AT/Placoid/Place/A, {dmeq([station,place],Placoid)}
id	 not message(nearest_station(_ST,_,_)),
    add stationsat(Place,Station,SSS)
ip  dmeq(nearat,AT),
    stationsat(Place,Station,SSS).


neib_lies_at_place rule %% does a neib lie at a place
is  doit/be1/Neib/E,
    Neib isa neighbourhood, { bound(Neib)},
    srel/at/place/Place/E,
    Place isa neighbourhood, { bound(Place)}
id  add stationsat(Neib,_Stations,_)
ip  statorplace(Neib),
     \+ home_town(Neib). %%  Place \== trondheim.


wherewhat_is_place rule
is  which(Place), Place isa neighbourhood, event/real/_,
    { bound(Place)}
id	 not message(nearest_station(_ST,_,_)),
    add stationsat(Place,Stations,SSS)
ip  stationsat(Place,Stations,SSS).


station_has_station rule% Place has station // Place IS allready a station !
is  which(Free),
    has/place/station/Free/Station, %% // mix subj/obj
    Station isa station,
    Free isa station
id	 add stationsat(Station,_Stations,_)
ip  station(Station),
    \+ home_town(Station), %%  \== trondheim,
    unbound(Free).


place_has_station rule % Place has station
is  which(Station),
    Station isa station, Place isa neighbourhood,has/_/station/Place/Station
id	 add stationsat(Place,_Stations,_)
ip  statorplace(Place),
     \+ home_town(Place). %%  Place \== trondheim.


%%%%%%% END STATION NEIGHBOURHOOD SECTION


whereistuc rule % Where is tuc ,Are you here
is  tuc isa _,doit/be1/tuc/A,srel/In/place/_/A, {dmeq([in,nil],In)},
    not _ isa date,  %% hvor var du da
    clear
id	 not flag(exit),
    clear,
    add message(cannotanswer),
    add flag(exit) %% no error by TUC
ip  [].

whereisbustuc rule % Where is bustuc
is  bustuc isa _,doit/be1/bustuc/A,srel/in/place/_/A
id	 add message(cannotanswer)
ip  [].

%[which(A):::(amble isa lastname,A isa place,doit/be1/amble/B,srel/nil/place/A/B,event/real/B)]
%[which(A):::(tore isa firstname,A isa place,doit/be1/tore/B,srel/nil/place/A/B,event/real/B)]

whereistoreamble rule % hvor er tore %% RS-110929
is  Tore_amble isa _person,_Place isa place,doit/be1/Tore_amble/_Time
id   add  message(answer(db_reply(Tore_amble,address,Adr)))
ip  has_att_val(_person,address,Tore_amble,Adr).

whereisentity rule % hvor er tore
is  Tore isa _Firstname,_Place isa place,doit/be1/Tore/_Event
id   add  message(answer(db_reply(Tore,address,Adr)))
ip  has_att_val(_Person,address,Tore,Adr).


getoff rule % Where can i get off the bus
is  which(Place),ispresent C isa bus,get/_/E,
	 srel/in/place/Place/E,srel/off/vehicle/C/E
id	 add message(mustknow(bus))
ip  unbound(Place),unbound(C).


geton rule % Where can i get on the bus
is  which(Place),ispresent C isa bus, srel/In/place/Place/E,srel/On/vehicle/C/E,
    not NTH isa neighbourhood when { bound(NTH)}, %% NBNB NEW
    not NTH isa station       when { bound(NTH)}

id	 not message(_),
    add message(mustknow(bus))
ip  dmeq([in,at],In),
    dmeq([on,off,by],On),      %% av --> by (SIC) Repair
    unbound(Place),unbound(C).


wstatdoyouknow rule % Which stations do you know
is  which(Station),tuc isa savant,Station isa station,dob/KNOW1/tuc/Station/_
  ,{dmeq([know,know1],KNOW1)}
id	 add listofall(station,_)
ip	 [].


wisnumberofbus rule % What is the numer of bus Bus
is  which(N),has/bus/number/Bus/N
id	 add message(is(bus,Bus))
ip	 bound(Bus).


isplacestation rule % is station a bus station?
is  exactly (test,Station isa Placeq,
             has/vehicle/station/_/Station,event/real/_)
id	 add station(Station)
ip  dmeq(place,Placeq).


isbusstation rule % is station a bus station?
is  exactly (test,Station isa station,event/real/_)
id	 add testanswer(properstation(Station),_) %% not Kristiansund
ip  [].


buzz rule % is Bus a Bus
is  exactly (test,B52 isa BR,event/real/_)
id	 add true
ip  dmeq(bus,BR),exbus(B52).


%%%%% How many


depsinayear rule % haow many deps in a year
is  howmany(Bus),ispresent Bus isa bus, A isa YEAR, srel/IN/time/A/_
id  clear, add message(idonotknow)  % Dont be fooled
ip  dmeq([in,nil],IN),
    dmeq([year,month,week,minute,second],YEAR).

quant  rule % antall  departures, no connections
is  quant(count,A),(A isa bus,doit/go/A/B,event/real/B),
    not ispresent srel/nil/week/_/_ %% hver uke
id  replace passevent(Deps,X1,X2,Opts, X3,X4)
    with    passevent(Deps,X1,X2,Opts1,X3,X4),
    add numberof(departures,Deps,_)
ip  setopt(number,Opts,Opts1).



howmany1 rule % how many buses, have connections
is  howmany(Bus),ispresent Bus isa bus,
    not srel/in_order_to/thing/_/_ ,
    not ispresent _ isa self,
    not ispresent  dob/take/_/_/_,
    not ispresent srel/because_of/_/_/_ %% avoid hvor mange busser må jeg ta
id  replace connections(X1,X2,X3,X4,X5,X6,SeqNo,Opts, Deps,X7)
    with    connections(X1,X2,X3,X4,X5,X6,SeqNo,Opts1,Deps,X7),
    add numberof(departures,Deps,_)
ip  setopt(number,Opts,Opts1).


howmany2 rule % how many departures, no connections
is  howmany(Arrdep),ispresent Arrdep isa ARRDEP,
    not ispresent srel/nil/week/_/_ %% hver uke
id  replace passevent(Deps,X1,X2,Opts, X3,X4)
    with    passevent(Deps,X1,X2,Opts1,X3,X4),
    add numberof(departures,Deps,_)
ip  dmeq(busdeparr,ARRDEP),
    setopt(number,Opts,Opts1).


howmany3 rule % how many deparures, have connections
is  howmany(Arrdep),ispresent Arrdep isa ARRDEP,
    not ispresent _ isa self,
    not ispresent  dob/take/_/_/_,
    not ispresent srel/because_of/_/_/_ %% avoid hvor mange busser må jeg ta
id  replace connections(X1,X2,X3,X4,X5,X6,SeqNo,Opts, Deps,X7)
    with    connections(X1,X2,X3,X4,X5,X6,SeqNo,Opts1,Deps,X7),
    add numberof(departures,Deps,_)
ip  dmeq(busdeparr,ARRDEP),
    setopt(number,Opts,Opts1).



%%%%% Høflighetsfraser og tull og sludder

tuchelp00 rule % Hva  kan busstuc brukes til
is  which(A), dob/use/_/bustuc/C, srel/to/thing/A/C
id	 add message(howtuchelp)
ip	 [].


tuchelp0 rule % What is your task/purpose/job/quest/
is  which(A),(has/agent/Task1/B/A,B isa program,A isa Task2)
id	 add message(howtuchelp)
ip	 dmeq([task,job,domain],Task1), dmeq([task,job,domain],Task2).


tuchelp2 rule % can you tell / hva kan du hjelpe med
is  not explain, %% how do you know
    tuc isa savant,doit/KNOW1/TUC/_ ,
           { dmeq(tuc,TUC)},
           { dmeq([do1,tell,know,know1,help],KNOW1)}, %%  (-work)
    not TUC isa person,       %% etc
    not _ isa neighbourhood,
    not _ isa station
  ,{dmeq([know,know1],KNOW1)}
id	 not departure(_,_,_,_),   %% already answering
    not message(thatisagoodquestion), %% TA-110120
    add message(howtuchelp)
ip	 [].



tuchelp3 rule % What can you do? Can you anything
is  which(AA),tuc isa savant,dob/V/TUC/AA/_,
    not ispresent _ isa language,
    not ispresent (_ isa clock),
    not ispresent (_ isa place) , %% not do you know where ...
    not ispresent (_ isa number), %% = route
    not ispresent dob/be_named/_/_/_, %%% ETC ETC
    not ispresent dob/be/_/_/_,
    not ispresent _ isa error     %%  :-(
id	 not message(_),
    not passevent(_,_,_,_,_,_),
    not departure(_,_,_,_),
    not findstations(_,_,_),
    add  message(howtuchelp)
ip	 dmeq(tuc,TUC),dmeq([do1,tell,know,know1,answer1,understand],V),
    \+ dmeq(knownlanguage,AA).

tuchelp4 rule % kan du fortelle meg noe ?
is  tuc isa savant, dob/Tell/tuc/A/B,
         {dmeq([tell,know,know1,say,write],Tell)},
         {unbound(A)},
    event/real/B,
    not _ isa language,
    not _ isa question  %% ad hoc  Du må oppgi
id	 not departure(_,_,_,_),

    not message(_Howtuchelp), %% TA-110215 not any message
    add message(howtuchelp)
ip	 [].

tuchelp5 rule % hva driver du med (Norw)
is  tuc isa savant, doit/operate/tuc/B,srel/pwith/thing/_A/B
id	 not departure(_,_,_,_),
    add message(howtuchelp)
ip	 [].

tuchelpabout rule % kan du fortelle meg noe ?
is  tuc isa savant, dob/Tell/tuc/A/E, srel/about/thing/A/E,
           {dmeq([tell,know,know1],Tell)},
    event/real/E,
    not _ isa question %% ad hoc  Du må oppgi
id	 not departure(_,_,_,_),
    add message(howtuchelp)
ip	 [].

tuchelp5 rule % What can i ask
is  which(_A),I isa self, doit/ASK/I/_
id	    not departure(_,_,_,_),
    add message(howtuchelp)
ip	 dmeq([ask],ASK).

tuchelp6tv rule %% Hva kan du hjelpe meg med
is  dob/help/Tuc/_/_ , { dmeq([tuc,tt],Tuc)} %%  du=tuc, dere=tt
id    not departure(_,_,_,_),
    add message(howtuchelp)
ip  [].

tuchelp6itv rule %% Hva kan du hjelpe med (unnec)
is  doit/help/Tuc/_ , { dmeq([tuc,tt],Tuc)} %%  du=tuc, dere=tt
id    not departure(_,_,_,_),
    add message(howtuchelp)
ip  [].


tuchelp8 rule   % Hvilke spørsmål kan jeg stille
is  which(_Q), %% Q isa question, HVA kan jeg ....
    dob/ask/'I'/_/_ %%  jeg spørre
id	 not departure(_,_,_,_),
    add message(howtuchelp)
ip	 [].


tuchelp9 rule % Kan jeg/man spørre
is  test,  doit/ask/I/_,
    I isa Agent
id	 not  message(howtuchelp),
    not departure(_,_,_,_),
    add message(howtuchelp)
ip	 dmeq([self,agent],Agent).

tuchelp10 rule % Kan jeg/man spørre om en ting
is  test,  doit/ask/I/_/_,
    I isa Agent
id	 not departure(_,_,_,_),
    add message(howtuchelp)
ip	 dmeq([self,agent],Agent).


tuchelp11 rule % What is possible for you
is  which(Q),
    adj/_/Possible/Q/E,
    srel/for/agent/Bustuc/E
id	 not departure(_,_,_,_),
    add message(howtuchelp)
ip	 dmeq([possible,impossible],Possible),
    dmeq(tuc,Bustuc).


tuchelp12 rule % I need help
is  new, I isa self,
    dob/Want/I/X/_ ,{dmeq([want,need],Want)},
    X isa Help, {dmeq([help,advice],Help)} %% TA-110601
id	 not departure(_,_,_,_),
    add message(howtuchelp)
ip	 [].


tuchelp13 rule %% hva har du informasjon om
is  which(_),(tuc isa savant,A isa information,has/agent/information/tuc/A,event/real/_)
id	 not departure(_,_,_,_),
    add message(howtuchelp)
ip	 [].

tuchelp14 rule % I vil ha hjelp
is  new, I isa self,A isa help,
    has/agent/help/I/A
id	 not departure(_,_,_,_),
    add message(howtuchelp)
ip	 [].

tuchelp14 rule % Jeg trenger hjelp
is  new, I isa self,A isa help,dob/_Need/I/A/_
id	 not departure(_,_,_,_),
    add message(howtuchelp)
ip	 [].

doyouknow rule %% kan du noen språk %% Moved back
is  tuc isa savant,dob/KNOW1/Tuc/_A/B,event/real/B,
    not ispresent doit/go/_/_, %% then not general
      { dmeq([busstuc,bustuc,tuc],Tuc),
        dmeq([know,know1,answer1],KNOW1)}
id  not message(_),
    add message(cannotanswer),
    add flag(exit) %% not negans
ip  [].


% Very general questions, late ...

busstations0 rule % Which bus stations
is  exactly (which(A),A isa Station)
id  not departure(_,_,_,_),
    add listofall(station,_)
ip  unbound(A),
    dmeq([stop,station,place,destination],Station).


busstations1 rule % Which bus stations
is  exactly (which(A),A isa Station,event/real/_)
id  not departure(_,_,_,_),
    add listofall(station,_)
ip  unbound(A),
    dmeq([stop,station,place,destination],Station).

busstations2 rule % Hva er holdeplassene
is  exactly (which(A),A isa Station,_ isa thing,event/real/_) %% Ad hoc
id  not departure(_,_,_,_),
    add listofall(station,_)
ip  unbound(A),
    dmeq([stop,station,place,destination],Station).

hvaheterstasjonene rule % Which bus stations
is  exactly (which(F23),F22 isa station, dob/be_named/F23/F22/B,event/real/B)
id  not departure(_,_,_,_),
    add listofall(station,_)
ip  [].


wstations9 rule % Which bus stations
is  exactly (which(A),A isa station,doit/be1/A/B,event/real/B)
id  not departure(_,_,_,_),
    add listofall(station,_)
ip  [].


wtramstat1 rule % Which tram stations
is  exactly (which(A),A isa tramstation,doit/be1/A/B,event/real/B)
id  not departure(_,_,_,_),
    add tramstations(_)
ip  [].


wtramstat2 rule % Which tram stations
is  exactly (which(A),A isa tramstation)
id  not departure(_,_,_,_),
    add tramstations(_)
ip  [].


wtramstat3 rule % Where are the tram stations
is  exactly (which(A),A isa place,B isa tramstation,doit/be1/B/C,srel/in/place/A/C,event/real/C)
id  not departure(_,_,_,_),
    add tramstations(_)
ip  [].


wherearestat rule % Where are the bus stations
is  not X isa station when { bound(X)},
    exactly (which(A),A isa place,B isa station,doit/be1/B/C,srel/in/place/A/C,event/real/C)
id  not departure(_,_,_,_),
    add listofall(station,_)
ip  \+ main:myflags(smsflag,true).


wherearestat rule % Where are the bus stations
is  not X isa station when { bound(X)},
    exactly (which(A),A isa place,B isa station,doit/be1/B/C,srel/in/place/A/C,event/real/C)
id  not departure(_,_,_,_),
    add message(mustknow(bus))
ip  main:myflags(smsflag,true).


whereisfirststat rule % Where is the first the bus stations
is  not X isa station when { bound(X)},
    which(A),A isa place,B isa station,doit/be1/B/C,srel/in/place/A/C,event/real/C,adj/_/_/B/_
id  not departure(_,_,_,_),
    add message(mustknow(bus))
ip  [].


whichavestattt rule % which stations (is had by) TT
is  which(A),A isa station,has/_/station/tt/A
id  not departure(_,_,_,_),
    add listofall(station,_)
ip  [].


whichavestattt rule % which stations (is had by) GB
is  which(A),A isa station,has/_/station/gråkallbanen/A
id  not departure(_,_,_,_),
    add listofall(tramstation,_)
ip  [].


equal rule
is  which(T),equal/T/TT,TT isa _Company
id  add message(answer(bcpbc(TT))) %% ugly ?  print specname if any
ip  bound(TT).

%........


describe100 rule   % What is a man %% moved backwards
is  exactly (which(A),A isa Man),
    { unbound(A)},
    clear
id  clear,
    add message(answer(bcpbc(Abstract)))
ip  \+ main:myflags(teleflag,true),
%   userNOTME:(ako/Man/Abstract),
    userNOTME:(Man ako Abstract),
    \+ member(Man,[airport,god,price,bus,tram,
          route,vehicle,driver,destination,
          clock,telephone,departure,information,route_plan,
          time,question,answer,station,stop]) %% etc.
:-single.


%%%¤¤¤¤¤¤¤¤¤¤¤¤¤¤


%% DEFAULTS for Flybussen:::

%
fbdefaultfromlerkendal  rule
is  FB isa Airbus, {dmeq(vehicle,Airbus)},

   %%  flag(airbus),
    {main:myflags(airbusflag,true)},

    not ispresent srel/from/place/Lerk/_,  %% this is a deafult rule

    not ispresent srel/to/place/Lerk/_  when {\+ airbusstation(Lerk)},

   {default_origin(_,LerkStad)}, %% sorgenfriveien

    not ispresent srel/from/place/Scandic/_  when { bound(Scandic)},
    ispresent event/real/E,
    not ispresent dob/pass/FB/_Steinan/E  %% direction ?

id  not flag(exit),
    not flag(todefaultorig),
    not flag(fromdefaultorig),
    add flag(fromdefaultorig),
    not flag(exit),
    not endstations(_,_),
    not message(sameplace(_,_)),
    not keepto(_,_,_),
    not connections(_,_,_,_,_,_,_,_,_,_),
    not frequency(_,_,_,_),

    not departure(_,LerkStad,_,_),  %% already

    not findstations(_,_,_),

    atday(Day),atdate2(DaySeqNo,_Date),

    add (departure(flybussen,CHLK,DaySeqNo,Depset),
			passevent(Depset,flybussen,CHLK,[from],Day,E))


ip  default_origin(flybussen,CHLK) %% NEW busdat
:- single.


fbdefaulttolerkendal  rule
is  FB isa Airbus, {dmeq(vehicle,Airbus)},

    {main:myflags(airbusflag,true)},
    {default_origin(_,CHLK)},

    not ispresent srel/from/place/Scandic/_  when { \+ default_destination(_,Scandic)},

    not ispresent srel/to/place/Scandic/_  when {bound(Scandic)},

    ispresent event/real/E,
    not ispresent dob/pass/FB/_Steinan/E  %% direction ?

id  not flag(exit),
    not flag(fromdefaultorig),
    not flag(todefaultorig),
    add flag(todefaultorig), %% i.e. to central
    not flag(exit),
    not endstations(_,_),
    not message(sameplace(_,_)),
    not keepto(_,_,_),
    not connections(_,_,_,_,_,_,_,_,_,_),
    not frequency(_,_,_,_),

    not departure(_,CHLK,_,_),  %%

    not findstations(_,_,_),

    atday(Day),atdate2(DaySeqNo,_Date),

    add (departure(flybussen,CHLK,DaySeqNo,Depset),
			passevent(Depset,flybussen,CHLK,[to],Day,E))


ip  []
:- single.  %% sic %%


fbdefaultfromværnes rule %% flybuss fra  lerkendal
is  {main:myflags(airbusflag,true)},
    ispresent FB isa Airbus, {dmeq(vehicle,Airbus)},

   {default_destination(_,CHLK)},
    not ispresent _ isa airport,

    not ispresent srel/from/place/Scandic/_  when { bound(Scandic)},
    ispresent event/real/E,

    not ispresent dob/pass/FB/_Steinan/E  %% direction ?
id  not flag(exit),
    not flag(fromdefaultorig),
    not flag(fromdefaultdest),
    add flag(fromdefaultdest),
    not flag(exit),
    not endstations(_,_),
    not message(sameplace(_,_)),
    not keepto(_,_,_),
    not connections(_,_,_,_,_,_,_,_,_,_),
    not frequency(_,_,_,_),
    not departure(_,st_olavs_gt,_,_),  %% Dirty
    not findstations(_,_,_),

    atday(Day),atdate2(DaySeqNo,_Date),

    add (departure(flybussen,CHLK,DaySeqNo,Depset),
			passevent(Depset,flybussen,CHLK,[from],Day,E))

ip  []
:- single.  %% sic %%


fbdefaulttoværnes rule %% flybuss fra  lerkendal
is  {main:myflags(airbusflag,true)},
    {default_destination(_,CHLK)},
    ispresent FB isa Airbus, {dmeq(vehicle,Airbus)},

    not ispresent _ isa airport,

    not ispresent srel/to/place/Scandic/_  when { bound(Scandic)},
    ispresent event/real/E,

    not ispresent dob/pass/FB/_Steinan/E  %% direction ?
id  not flag(exit),
    not flag(todefaultorig),
    not flag(todefaultdest),
    add flag(todefaultdest),
    not flag(exit),
    not endstations(_,_),
    not message(sameplace(_,_)),
    not keepto(_,_,_),
    not connections(_,_,_,_,_,_,_,_,_,_),
    not frequency(_,_,_,_),
    not departure(_,st_olavs_gt,_,_),  %% Dirty
    not findstations(_,_,_),

    atday(Day),atdate2(DaySeqNo,_Date),

    add (departure(flybussen,CHLK,DaySeqNo,Depset),
			passevent(Depset,flybussen,CHLK,[to],Day,E))

ip  []
:- single.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


gotodefaultplace rule %% go from S to default  place
is  not ispresent srel/To/place/Scandic/_  when
                   { dmeq([to,before,in],To),bound(Scandic)},
                                     %%%% TA-110630
    ispresent event/real/E,
    ispresent  Bus36 isa Veh , { bound(Bus36),dmeq(vehicle,Veh)},
    not ispresent dob/pass/Bus36/_Steinan/E  %% direction ?
id  not flag(defaultdest),
    not flag(exit),
    not endstations(_,_),
    atday(Day),
    atdate2(DaySeqNo,_Date),
    not message(sameplace(_,_)),
    not message(neverpasses(_,_)), %% makes it complicated %% TA-110530
    not keepto(_,_,_),
    not connections(_,_,_,_,_,_,_,_,_,_),
    not frequency(_,_,_,_),
    not departure(_,st_olavs_gt,_,_),  %% Dirty
    not findstations(_,_,_),
    add (departure(Bus36,Paul_Skolemesters_vei,DaySeqNo,Depset),
			passevent(Depset,Bus36,Paul_Skolemesters_vei,[to],Day,E)),
    add flag(defaultdest) %% avoid nil clock = before clock
ip  default_destination(Bus36,Sjetnmarka),
    bus_place_station(Bus36,Sjetnmarka,Paul_Skolemesters_vei)
:- single.

gotodefaultplacefromcenter rule
is  not ispresent srel/to/place/_/_,
    ispresent event/real/E,
    ispresent srel/from/place/Sentrum/E, %% or corr
    { samefplace(Sentrum,hovedterminalen)},
    ispresent event/real/E,
    ispresent  Bus36 isa Veh ,{ bound(Bus36),dmeq(vehicle,Veh)},
    not ispresent dob/pass/Bus36/_Steinan/E  %% direction ?
id  not flag(defaultdest),
    not flag(exit),
    not endstations(_,_),
    atday(Day),atdate2(DaySeqNo,_Date),
    not message(sameplace(_,_)),
    not keepto(_,_,_),
    not connections(_,_,_,_,_,_,_,_,_,_),
    not frequency(_,_,_,_),
%%%%%%%%%%%%%%%%%%%%%%%%    not departure(_,hovedterminalen,_,_),
    not departure(_,st_olavs_gt,_,_),  %% Dirty
    not findstations(_,_,_),
    add (departure(Bus36,CHLK,DaySeqNo,Depset),
			passevent(Depset,Bus36,CHLK,[to],Day,E)),
    add flag(defaultdest) %% avoid nil clock = before clock
ip  default_destination(Bus36,CHLK) %% NEW busdat
:- single.



gofromdefaultplace rule %% go to S  from default  place
is  not ispresent srel/_From/place/Scandic/_
           when { bound(Scandic) },
    ispresent event/real/E,
    ispresent  Bus36 isa Veh , { bound(Bus36),dmeq(vehicle,Veh)},
    not _ isa clock, %% klokka er 10
    not ispresent dob/pass/Bus36/_Steinan/E  %% direction ?
id  not flag(defaultdest),  %%  Retention
    not flag(exit),
    not endstations(_,_),
    atday(Day),atdate2(DaySeqNo,_Date),
    not message(sameplace(_,_)),
    not keepto(_,_,_),
    not connections(_,_,_,_,_,_,_,_,_,_),
    not frequency(_,_,_,_),
    not departure(_,st_olavs_gt,_,_),  %% Dirty
    not findstations(_,_,_),
    add (departure(Bus36,CHLK,DaySeqNo,Depset),
			passevent(Depset,Bus36,CHLK,[from],Day,E)),
    add flag(defaultdest)
ip  default_destination(Bus36,CHLK)
:- single.


%%%¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

wakeup1 rule  %%  Just wakeup call notify/1
is  ispresent notify/_/_,
    TIME isa clock,  { bound(TIME)},
    srel/Nil/time/TIME/_, { dmeq([at,nil],Nil)},
    not X isa station when { bound(X)},
    not X isa neighbourhood when { bound(X)},
    not X isa street when { bound(X)}
id  not flag(exit), %% Refraction
    add flag(exit),
    atdate2(_DaySeqNo,DATE),
    addfront notification(DATE,TIME)
ip  main:set(warningtime, notification(DATE,TIME)).



wakeup1sick rule  %%  sick    %% You notify me at 1245
is  ispresent dob/notify/_/_/_,
    TIME isa clock,  { bound(TIME)},
    srel/Nil/time/TIME/_, { dmeq([at,nil],Nil)},
    not X isa station when { bound(X)},
    not X isa neighbourhood when { bound(X)},
    not X isa street when { bound(X)}
id  not flag(exit), %% Refraction
    add flag(exit),
    atdate2(_DaySeqNo,DATE),
    addfront notification(DATE,TIME)
ip  main:set(warningtime, notification(DATE,TIME)).

wakeup2sick rule  %%  sick    %% You notify (me) 1245
is  ispresent dob/notify/_/TIME/_,
    TIME isa clock,  { bound(TIME)},
    not X isa station when { bound(X)},
    not X isa neighbourhood when { bound(X)},
    not X isa street when { bound(X)}
id  not flag(exit), %% Refraction
    add flag(exit),
    atdate2(_DaySeqNo,DATE),
    addfront notification(DATE,TIME)
ip  main:set(warningtime, notification(DATE,TIME)).


wakeup2 rule  %%  Just wakeup send notification
is  ispresent N isa notification,
    send/tuc/N/E,
    TIME isa clock,  {bound(TIME)},
    srel/nil/time/TIME/E,
    not X isa station when { bound(X)},
    not X isa neighbourhood when { bound(X)},
    not X isa street when { bound(X)}
id  not flag(exit), %% Refraction
    add flag(exit),
    atdate2(_DaySeqNo,DATE),
    addfront notification(DATE,TIME)
ip  main:set(warningtime, notification(DATE,TIME)).


wakeup3 rule  %% Just wakeup send notification
is  ispresent N isa notification,
    dob/give/tuc/N/E,
    TIME isa clock,  {bound(TIME)},
    srel/nil/time/TIME/E,
    not X isa station when { bound(X)},
    not X isa neighbourhood when { bound(X)},
    not X isa street when { bound(X)}
id  not flag(exit), %% Refraction
    add flag(exit),
    atdate2(_DaySeqNo,DATE),
    addfront notification(DATE,TIME)
ip  main:set(warningtime, notification(DATE,TIME)).



%% USE CONTEXT SECTION 1 %%%

iwantalaterdeparture  rule %%  Går det en senere buss/avgang
is  adj/comp/late/BusDep/real,  { dmeq([bus,departure],BusDep)},
    has/agent/_Veh/_I/BusDep,
    not srel/to/place/_/_,
    not srel/from/place/_/_,     %% there ok
    not srel/for/bus/_/_
id	 not message(not(bus,_)),
    not message(foreign(_)),
    not message(idonotknow),
    not departure(_,_,_,_),
	 not findstations(_,_,_),
    not passesstations(_,_,_,_),
    not askfor(_, where::departure, _),
    addfront askfor([], where::departure, _Place)
ip  []
 :- double.


iwantalaterarrival  rule %%  kommer  det en senere buss/ankomst
is  adj/comp/late/BusArr/real, { dmeq([bus,departure],BusArr)},
    has/agent/_Veh/_I/BusArr,
    not srel/to/place/_/_,
    not srel/from/place/_/_,     %% there ok
    not srel/for/bus/_/_
id	 not message(not(bus,_)),
    not message(foreign(_)),
    not message(idonotknow),
    not departure(_,_,_,_),
	 not findstations(_,_,_),
    not passesstations(_,_,_,_),
    not askfor(_, where::arrival, _),
    addfront askfor([], where::arrival, _Place)
ip  []
 :- double.


iwantanearlierarrival  rule  %%  Kommer  det en tidligere buss/ankomst
is  adj/comp/early/BusArr/real, { dmeq([bus,departure],BusArr)},
    has/agent/_Veh/_I/BusArr,
    not srel/to/place/_/_,
    not srel/from/place/_/_,     %% there ok
    not srel/for/bus/_/_
id	 not message(not(bus,_)),
    not message(foreign(_)),
    not message(idonotknow),
    not departure(_,_,_,_),
	 not findstations(_,_,_),
    not passesstations(_,_,_,_),
    not askfor(_, where::arrival, _),
    addfront askfor([], where::arrival, _Place)
ip  []
 :- double.

%%  Går det en senere  buss/avgang

iwantanearlierdeparture  rule
is  adj/comp/early/BusDep/real, { dmeq([bus,departure],BusDep)},
    has/agent/_Veh/_I/BusDep,
    not srel/to/place/_/_,
    not srel/from/place/_/_,     %% there ok
    not srel/for/bus/_/_
id	 not message(not(bus,_)),
    not message(foreign(_)),
    not message(idonotknow),
    not departure(_,_,_,_),
	 not findstations(_,_,_),
    not passesstations(_,_,_,_),
    not askfor(_, where::departure, _),
    addfront askfor([], where::departure, _Place)
ip  []
 :- double.




askforlaterarrival  rule
is  adj/comp/late/Bus/real,
    ispresent _ isa arrival,
    Bus isa BR,
    doit/PASS/Bus/_,
    not srel/from/place/_/_,
    not srel/from/place/_/_,     %% there ok
    not srel/for/bus/_/_
id	 not message(not(bus,_)),
    not message(foreign(_)),
    not message(idonotknow),
    not departure(_,_,_,_),
	 not findstations(_,_,_),
    not passesstations(_,_,_,_),
    not askfor(_, where::arrival, _),
    addfront askfor([], where::arrival, _Place)
ip  dmeq(bepass,PASS),
    dmeq(trafficant,BR)
 :- double.


askforlaterdeparture  rule
is  adj/comp/late/Bus/real,
    Bus isa BR,
    doit/PASS/Bus/_,
    not srel/to/place/_/_,
    not srel/from/place/_/_,     %% there ok
    not srel/for/bus/_/_,

    not ispresent srel/after/time/_/_, %% Retention
    add srel/after/time/NewDep/_

id	 not message(not(bus,_)),
    not message(foreign(_)),
    not message(idonotknow),
    not departure(_,_,_,_),
	 not findstations(_,_,_),
    not passesstations(_,_,_,_)



%%    not askfor(_, where::departure, _),
%%    addfront askfor([], where::departure, _Place)

ip  dmeq(bepass,PASS),
    dmeq(trafficant,BR) ,
    current_frame_getvalue(where::departure, NewDep)
 :- double.


%%  Går det en  tidligere  buss

askforearlierbus  rule
is  adj/comp/early/Bus/real, %%%  /// EARLIER
    Bus isa BR,
    doit/PASS/Bus/_,
    not srel/to/place/_/_,
    not srel/from/place/_/_     %% there ok
id	 not message(not(bus,_)),
    not message(foreign(_)),
    not message(idonotknow),
    not departure(_,_,_,_),
	 not findstations(_,_,_),
    not passesstations(_,_,_,_),
    not askfor(_, where::arrival, _),
    addfront askfor([], where::arrival, _Place)
ip  dmeq(bepass,PASS),
    dmeq(trafficant,BR)
 :- double.




bingothisevening rule %% i kveld %%  Grotesque
is  ispresent  A isa night, srel/in/time/A/_,
    not T isa clock when { (bound(T),T>=1200) }, %% then only "late"
    Bus isa BR,  {dmeq(trafficant,BR)},
    doit/PASS/Bus/_, {dmeq(bepass,PASS)},
    not srel/to/place/_/_,
    not srel/from/place/_/_,     %% there ok
    not srel/for/bus/_/_
id	 not message(date_isa_day(_,_)),
    not message(not(bus,_)),
    not message(foreign(_)),
    not message(idonotknow),
    not departure(_,_,_,_),
	 not findstations(_,_,_),
    not passesstations(_,_,_,_),
    not askfor(_, where::departure, _),
    addfront askfor([], where::departure, _Place),
    not frame_remember(whenis::departure::after,_),
    add frame_remember(whenis::departure::after,AfTime)
ip  timenow2(0,TNOW), AfTime is max(TNOW,1800) %% Pragmatic: after now
 :- double.


bingoanotherevening rule %% mandag  kveld
is  ispresent  A isa night, srel/in/time/A/_,
    Bus isa BR,
    doit/PASS/Bus/_,
    not srel/to/place/_/_,
    not srel/from/place/_/_,     %% there ok
    not srel/for/bus/_/_
id	 message(date_isa_day(_,_)),
    not message(not(bus,_)),
    not message(foreign(_)),
    not message(idonotknow),
    not departure(_,_,_,_),
	 not findstations(_,_,_),
    not passesstations(_,_,_,_),

    not askfor(_, where::departure, _),
    addfront askfor([], where::departure, _Place),

    not frame_remember(whenis::departure::after,_),
    add frame_remember(whenis::departure::after,AfTime)

ip  dmeq(bepass,PASS),
    dmeq(trafficant,BR),
    AfTime is 1800
 :- double.


bingothisafternoon rule %% i ettermiddag
is  ispresent  A isa afternoon, srel/in/time/A/_,
    not ispresent srel/before/time/T/_ when { bound(T) },
    Bus isa BR,
    doit/PASS/Bus/_,
    not srel/to/place/_/_,
    not srel/from/place/_/_,     %% there ok
    not srel/for/bus/_/_
id	 not message(day_isa_date(_,_)),
    not message(not(bus,_)),
    not message(foreign(_)),
    not message(idonotknow),
    not departure(_,_,_,_),
	 not findstations(_,_,_),
    not passesstations(_,_,_,_),

    not askfor(_, where::departure, _),
    addfront askfor([], where::departure, _Place),

    not frame_remember(whenis::departure::after,_),
    add frame_remember(whenis::departure::after,AfTime)

ip  dmeq(bepass,PASS),
    dmeq(trafficant,BR),
    timenow2(0,TNOW), AfTime is max(TNOW,1200)  %%  Pragmatic: after now
:- double.

bingoanotherafternoon rule %% i kveld %% Grotesque
is  ispresent  A isa afternoon, srel/in/time/A/_,
    Bus isa BR,
    doit/PASS/Bus/_,
    not srel/to/place/_/_,
    not srel/from/place/_/_,     %% there ok
    not srel/for/bus/_/_
id	 message(day_isa_date(_,_)),
    not message(not(bus,_)),
    not message(foreign(_)),
    not message(idonotknow),
    not departure(_,_,_,_),
	 not findstations(_,_,_),
    not passesstations(_,_,_,_),

    not askfor(_, where::departure, _),
    addfront askfor([], where::departure, _Place),

    not frame_remember(whenis::departure::after,_),
    add frame_remember(whenis::departure::after,AfTime)

ip  dmeq(bepass,PASS),
    dmeq(trafficant,BR),
    AfTime is 1200
:- double.

%
%

% jeg vil reise etter kl 1500
bingo rule %% askforwheredeptimeonly rule
is  ispresent  srel/after/time/DepTime/_,
    Bus isa BR,
    doit/PASS/Bus/_,
    DepTime  isa clock,
    not srel/to/place/_/_,
    not srel/from/place/_/_,     %% there ok
    not srel/for/bus/_/_
id	 not message(not(bus,_)),
    not message(foreign(_)),
    not message(idonotknow),
    not departure(_,_,_,_),
	 not findstations(_,_,_),
    not passesstations(_,_,_,_),

    not askfor(_, where::departure, _),
    addfront askfor([], where::departure, _Place),

    not frame_remember(whenis::departure::after,DepTime),
    add frame_remember(whenis::departure::after,DepTime)

ip  dmeq(bepass,PASS),
    dmeq(trafficant,BR)
 :- double.


jaglanddepartnil rule    %%   %% jeg vil reise  kl 1500 ->  før kl 1500
is  ispresent  srel/NILAT/Clock/DepTime/_,
             { number(DepTime),
               dmeq([nil,at],NILAT),
               dmeq([time,clock],Clock)},
    DepTime  isa clock,
    doit/TRAVELFROM/Bus/_, { dmeq(travelfrom,TRAVELFROM)},
    Bus isa BR,
    not srel/to/place/_/_,
    not srel/from/place/_/_,     %% there ok
    not srel/for/bus/_/_
id	 not message(not(bus,_)),
    not message(foreign(_)),
    not message(idonotknow),
    not departure(_,_,_,_),
	 not findstations(_,_,_),
    not passesstations(_,_,_,_),

    not askfor(_, where::departure, _),
    addfront askfor([], where::departure, _Place),

    not frame_remember(whenis::departure::after,DepTime),
    add frame_remember(whenis::departure::after,DepTime)
ip  dmeq(trafficant,BR)
 :- double.






%% jeg vil reise før  kl 1500
bongo rule %% askforwherearrtimeonly rule
is  ispresent  srel/before/time/ArrTime/_,
     Bus isa BR,
    doit/PASS/Bus/_,
    ArrTime isa clock,
    not srel/to/place/_/_,
    not srel/from/place/_/_,     %% there ok
    not srel/for/bus/_/_
id	 not message(not(bus,_)),
    not message(foreign(_)),
    not message(idonotknow),
    not departure(_,_,_,_),
	 not findstations(_,_,_),
    not passesstations(_,_,_,_),

    not askfor(_, where::departure, _),
    addfront askfor([], where::arrival, _Place),

    not frame_remember(whenis::arrival::before,ArrTime),
    add frame_remember(whenis::arrival::before,ArrTime)
ip  dmeq(bepass,PASS),
    dmeq(trafficant,BR)
 :- double.


jaglandarrivenil rule    %% jeg vil ankomme kl 1500 -> før kl 1500
is  ispresent  srel/NILAT/Clock/DepTime/_,
             {number(DepTime),
              dmeq([nil,at],NILAT),
              dmeq([time,clock],Clock)},
    ArrTime  isa clock,
    doit/TRAVELTO/Bus/_, { dmeq(travelto,TRAVELTO)},
    Bus isa BR,
    not srel/to/place/_/_,
    not srel/from/place/_/_,     %% there ok
    not srel/for/bus/_/_
id	 not message(not(bus,_)),
    not message(foreign(_)),
    not message(idonotknow),
    not departure(_,_,_,_),
	 not findstations(_,_,_),
    not passesstations(_,_,_,_),

    not askfor(_, where::arrival, _),
    addfront askfor([], where::arrival, _Place),

    not frame_remember(whenis::arrival::before,ArrTime),
    add frame_remember(whenis::arrival::before,ArrTime)
ip  dmeq(trafficant,BR)
 :- double.




askforwhere rule % PASS Bus (Place is unbound, bus is unknown)
is  Bus isa BR,
    doit/PASS/Bus/_, { dmeq(bepass,PASS)},
    not srel/to/place/_/_,
    not srel/from/place/_/_,     %% there ok
    not srel/for/bus/_/_
id	 not message(not(bus,_)),
    not message(foreign(_)),
    not message(idonotknow),
    not departure(_,_,_,_),
	 not findstations(_,_,_),
    not passesstations(_,_,_,_),
    not askfor(_, where::departure, _),
    addfront askfor([], where::departure, _Place)
ip  dmeq(trafficant,BR)
 :- double.


%% END OF USE CONTEXT SESSION 1


%% SECTION OUR RULE (MODIFY SOURCE FROM CONTEXT)


ouraround rule       %%  pretend it is before time
is  context srel/around/time/_Rel/E ,
    ispresent doit/go/_/E,
    ispresent event/real/E,
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/to/place/NewPlace/E
id  []

%%   not askfor(_, where::arrival, _), %% where ???
%%   addfront askfor([], where::arrival, NewPlace) %% where ???
ip  current_frame_getvalue(where::arrival, NewPlace)
 :- double.


ourarrbefore rule
is  context srel/before/time/_Rel/E ,
    ispresent doit/go/_/E,
    ispresent event/real/E,
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/to/place/NewPlace/E
 id []
%%     not askfor(_, where::arrival, _), %% where ???
%%     addfront askfor([], where::arrival, NewPlace) %% where ???
ip  current_frame_getvalue(where::arrival, NewPlace)
  :-double.


ourwithlastbus rule    %% mimic i kveld
is  context srel/pwith/Bus/F69/E,
    context adj/_/last/F69/_,
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/from/place/NewPlace/E
id  []

ip  dmeq(vehicle,Bus),
    current_frame_getvalue(where::departure, NewPlace)
  :-double.

ourwithnextbus rule
is  context srel/pwith/Bus/F69/E,
    context adj/_/Next/F69/_, { dmeq([first,next],Next)},
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/from/place/NewPlace/E
id  []

ip  dmeq(vehicle,Bus),
    current_frame_getvalue(where::departure, NewPlace)
:-double.

ournextbus rule
is  context adj/_/Next/F69/_, { dmeq([first,next],Next)},
    ispresent F69 isa Bus, { dmeq(vehicle,Bus)},
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/from/place/NewPlace/E
id  []
ip  dmeq(vehicle,Bus),
    current_frame_getvalue(where::departure, NewPlace)
:-double.


ourjustlastbus rule    %% -> med siste buss
is  context adj/_/last/F69/_,
    ispresent F69 isa Bus, { dmeq(vehicle,Bus)},
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/from/place/NewPlace/E
id  []
ip  current_frame_getvalue(where::departure, NewPlace)
  :-double.


ourtonight rule
is  srel/tonight/_Time/nil/E,
    ispresent event/real/E,
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/from/place/NewPlace/E
id  []

ip  current_frame_getvalue(where::departure, NewPlace)
    :-double.


ourom rule   %  om to timer, create departure place
is  context srel/after/minute/MM/E,
    context MM isa minute,
    ispresent event/real/E,
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/from/place/NewPlace/E
id  []

ip  number(MM),  %% no spurious  after this time
    current_frame_getvalue(where::departure, NewPlace)
:-double.
% ¤¤¤¤

ourdepearlier rule
is  ispresent  adj/comp/early/_Bus/real, ispresent _ isa departure,
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/from/place/NewPlace/E
id  []

ip   current_frame_getvalue(where::departure, NewPlace)
    :-double.

ourarrearlier1 rule
is  ispresent  adj/comp/early/_Bus/real ,
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/to/place/NewPlace/E
id  []

ip  current_frame_getvalue(where::arrival, NewPlace)
    :-double.

ourarrearlier2 rule
is  ispresent srel/earlier/time/nil/_, % i go earlier
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/to/place/NewPlace/E
id  []

ip   current_frame_getvalue(where::arrival, NewPlace)
    :-double.

ourarrlater rule
is  ispresent  adj/comp/late/_Bus/real, ispresent _ isa arrival,
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/to/place/NewPlace/E
id  []
%% not askfor(_, where::arrival, _), %% where ???
%% addfront askfor([], where::arrival, NewPlace) %% where ???
ip   current_frame_getvalue(where::arrival, NewPlace)
    :-double.



ourdeplater rule
is  ispresent  adj/comp/late/_Bus/real, %% default departure
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/from/place/NewPlace/E
id  []

ip   current_frame_getvalue(where::departure, NewPlace)
    :-double.


ourigobefore rule
is  ispresent  srel/beforethat/time/nil/_, %% default departure
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/to/place/NewPlace/E
id  []

ip  current_frame_getvalue(where::arrival, NewPlace)
    :-double.


ourigolater rule
is  ispresent  srel/thereafter/time/nil/_, %% default departure
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    not ispresent srel/from/place/_/E,        %% retention
    add srel/from/place/NewPlace/E          %% retention
id []
ip  current_frame_getvalue(where::departure, NewPlace) %%    newcontext2.pl NEW
    :-double.


ourdepafter rule
is  context srel/after/time/Rel/E,
    ispresent event/real/E,
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/from/place/NewPlace/E
id  []



ip  number(Rel),  %% no spurious  after this time
    current_frame_getvalue(where::departure, NewPlace)
:-double.

ournilafter2 rule      %% FIX rule in connection with standardclock
is  context srel/nil/time/Rel/E,
    ispresent doit/go/_/E,
    ispresent event/real/E,
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/from/place/NewPlace/E
id  []


ip  number(Rel),
    current_frame_getvalue(where::departure, NewPlace)
 :- double.

ourafternow rule
is  context srel/Now/time/nil/E, { dmeq([now,hereafter],Now)},
    ispresent doit/go/_/E,
    ispresent event/real/E,
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/from/place/NewPlace/E
id  []


ip  current_frame_getvalue(where::departure, NewPlace)
    :- double.


%% END OUR SECTION




%%%%%%%%%% Start MustKnow Section


mustknowplace0  rule  %% Går Buss 8 ?
is  Bus isa Veh,
       %% {bound(Bus)} , %% TA-110118
       %% Dropped for humoristic effect: kan jeg få en suss

       {dmeq(busdeparrtime,Veh)},  %% select a known   bus
    ispresent doit/Go/Bus/_E,
        {dmeq([arrive,depart,give,pass,go,leave,be1,exist,stop],Go)}, %% give me the time

    not ispresent ( _ isa week), %% TA-110203 %% hvilken uke er ...
    not ispresent  PP isa place when { unbound(PP) }, %% where -> unbound

    not X isa station when { bound(X) },
    not X isa neighbourhood when { bound(X) },
    not X isa street when { bound(X) }
id	 not flag(exit),
    not message(not(route,_)),
    not message(mustknow(bus)),
    not departure(_,_,_,_),
	 not findstations(_,_,_),
    not passesstations(_,_,_,_),
    not message(summerishere),
    not message(winterishere),
    addcon message(mustknow(place))
%%%    add flag(fail)     %%  "det er ikke mulig natt til søndag"
ip	 [].


mustknowplace7 rule        %% Jeg er på et sted
is  doit/be1/X/E ,

%% X isa Mov,  {i_or_a_bus(X,Mov,_)}.  %% TA-110314
    not _ isa application,   %% facetious %% TA-110724
    not ispresent X isa clock, %% hva er klokken ....
    not srel/in/place/_/E,   %% hvor er ...
    not srel/on/_Veh/_/E,    %% hvor er ...
    not ispresent _ isa place,
    not ispresent _ isa meaning,
    not ispresent _ isa mood,
    not ispresent _ isa answer,
    not ispresent _ isa duration,
    not ispresent _ isa feeling,
    not ispresent _ isa mind, %% consciousness,
    not ispresent _ isa life,
    not ispresent _ isa information,
    not ispresent U isa neighbourhood when {bound(U)},%% TA-110314
    not ispresent V isa station when {bound(V)},
    not ispresent _ isa webaddress,
    not ispresent _ isa program,
    not ispresent equal/_/_,           %% er voll en buss
    not ispresent dob/be/_/_/_,
    not _ isa ticket,
    not _ isa company,
    not dob/be_named/_/_/_,
    not ispresent adj/_/_/_/_
id  not departure(_,_,_,_),          %% gives an extra go
    not ticketprice2(_,_),
    not passesstations(_,_,_,_), %% TA-110527
    not message(_),
    addcon message(mustknow(place))
ip  []. %% i_or_a_bus(X,Mov,_). %% TA-110314


mustknowplace8 rule % bus has time (Place is unbound, bus is unknown)
is  Bus isa BR, has/route/time/Bus/_,
    not srel/_/place/_/_,       %%  etc etc etc
    not srel/for/bus/_/_
id	 not message(not(route,_)),
    not message(foreign(_)),
    not message(idonotknow),
    not departure(_,_,_,_),
	 not findstations(_,_,_),
    not passesstations(_,_,_,_),
    addcon  message(mustknow(place))    %% More natural, only once
ip	 dmeq(bus,BR),  unbound(Bus).



mustknowplace10 rule
is  not explain,
    %% I isa self, %% may disappear, I isa self occcurs 1 %% TA-110329
                   %% hvilke rute skal jeg ta hvis jeg skal komme til sentrum.
    doit/Go/_I/_,
        {dmeq([go,come,get,arrive,depart],Go)}, %% \+ be1 %% TA-110622
    not doit/live/_/_, %% leve | bo ? %% TA-100921
    not _ isa company,
    not srel/_/place/_/_ ,
    not ispresent _ isa information,  %% Ad Hoc
    not ispresent ( _ isa week), %% TA-110203 %% hvilken uke er ...
    not ispresent srel/on/language/_/_,   %% TA-110331 ? :-) %% hva heter .. på engelsk

    %%     not ispresent _ isa street      %%
    not ispresent _ isa station,       %% TA-110510
    not ispresent _ isa neighbourhood  %%

id  not departure(_,_,_,_),        %% gives an extra go
    not message(nearest_station(_ST,_,_Unknown)),
    not message(stationsat(_,_,_)), %% TA-110504
    not message(mustknow(_)),
    not message(mustknowanother(_)),
    not message(sameplace(_,_)),
    not message(onlyonesentence),
    not message(onlyonething),       %% may give spurious errors
    not message(date_day_route(_,_)),
    addcon message(mustknow(place))
ip  [].  %% TA-110329


mustknowplace11 rule  %% sick
is  exactly (which(A),quant(_,A),A isa Bus)
id  addcon message(mustknow(place))
ip  dmeq(vehicle,Bus).


mustknowplace12 rule  %% fortell meg om bussavganger
is  doit,tuc isa savant,tell/tuc/_B/C,
    srel/about/thing/A/C, A isa Dep, {unbound(A)},
    {dmeq(busdeparr,Dep)}
id  addcon message(mustknow(place))
ip  [].

mustknowplace13  rule %% kan du svare/fortelle om bussen går
is  test,tuc isa savant,A isa coevent,B isa bus,dob/Tell/tuc/A/_,doit/go/B/_,
        {dmeq([tell,answer1],Tell)}
id  addcon message(mustknow(place))
ip  [].


mustknowplaceshow rule
is  dob/show/tuc/Y/_, Y isa Z,
    not (X isa station) when { bound(X) },
    not (X isa neighbourhood) when { bound(X) },
    not (ispresent X isa street) when { bound(X) }
id  not flag(exit),
    addcon message(mustknow(place))
ip  dmeq(vehicle,Z).


dobusrun rule %%  kjører busser
is  test,
    doit/Go/_/D, {dmeq([stop,go,pass],Go)},

    not srel/well/pmode/nil/D, %% gå bra :-)   %% TA-101228
    not _ isa company,
    not _ isa person, %% etc                   %% TA-100828
    not _ isa cinema, %% TA-100902
    not ispresent (X isa bus) when {bound(X)},
    not ispresent (X isa route) when {bound(X)},
    not ispresent _ isa telephone,
    not dob/tell/'I'/_/_ , %% Hva var det forrige jeg sa?
    not (X isa station) when { bound(X)},
    not (X isa neighbourhood) when  {bound(X)},
    not (ispresent X isa street) when { bound(X)},
    not  doit/go/tuc/_, %% hvor skal du %% ?
    not  doit/live/_/_
id  not flag(exit),
    not message(mustknow(place)), %% kan jeg få en buss
    not findstations(_,_,_),
    not departure(_,_,_,_),
    not message(summerishere),
    not message(winterishere),
    not message(mustknowanother(place)),
    addcon message(mustknow(bus))
ip  [].

mustknowbus99 rule %%  hvor stopper bussen ->
is  which(A),
    A isa place,
			  ispresent doit/Go/_/_,
                      {dmeq([stop,go,pass,run],Go)}, %% TA-110308
    not _ isa company,
    not _ isa person, %% etc                   %% TA-100828
    not _ isa cinema, %% TA-100902
    not ispresent (X isa bus) when {bound(X)},   %%
    not ispresent (X isa route) when {bound(X)}, %%
    not ispresent _ isa telephone,
    not dob/tell/'I'/_/_ , %% Hva var det forrige jeg sa?
    not (X isa station) when { bound(X)},
    not (X isa neighbourhood) when  {bound(X)},
    not (ispresent X isa street) when { bound(X)},
%%%%     not  doit/go/tuc/_, %% hvor skal du %% ?  hvor kjører du %% TA-110308
    not  doit/live/_/_
id  not flag(exit),
    not findstations(_,_,_),
    not departure(_,_,_,_),
    not message(summerishere),
    not message(winterishere),
    not message(mustknowanother(place)),
    addcon message(mustknow(bus))
ip  [].


mustknowplace99 rule
is     _Y isa Z, {dmeq(busdeparr,Z)}, %% NOT 'I'
    not srel/in/vehicle/_/_,          %%  ad hoc
    not srel/on/vehicle/_/_,          %%
    not ispresent dob/own/_/_/_,
    not ispresent dob/pay/'I'/_/_,
    not ispresent _ isa telephone,
    not dob/tell/'I'/_/_ , %% Hva var det forrige jeg sa?
    not (X isa station) when {bound(X)},
    not (X isa neighbourhood) when  {bound(X)},
    not (ispresent X isa street) when { bound(X)},
    not (X isa endstation) when  {bound(X)},
    not (X isa place ) when  {unbound(X)} %%%% HVOR

id  not flag(exit),
    not message(noinfoabout(_Cleaning)),
    not message(mustknow(place)),
    not endstations(_,_),  %%  Not message
    not message(mustknow(bus)),
    not findstations(_,_,_),
    not departure(_,_,_,_),
%%    not message(otherperiod(_)),
    not message(summerishere),
    not message(winterishere),

    add message(mustknow(place))
    %% add flag(exit) %% no trytofool
ip  [].


warnmustknowplace1 rule
is  ispresent notify/_/_, % without prewarningtime
    not X isa station when { bound(X) },
    not X isa neighbourhood when { bound(X) },
    not X isa street when { bound(X) }
id  not flag(exit),
    not message(mustknow(place)),
    add message(mustknow(place)),
    add flag(exit)
ip  []. %% main:set(warningflag,false).
        %% -> comes up again by :warningflag3


warnmustknowplace3 rule
is  ispresent F4 isa notification,
    Send/tuc/F4/_, {dmeq([send,give],Send)},
    not X isa station when { bound(X) },
    not X isa neighbourhood when { bound(X) },
    not X isa street when { bound(X) }
id  not flag(exit),
    not message(mustknow(place)),
    add message(mustknow(place)),
    add flag(exit)
ip  main:set(warningflag,false).


istand rule %% jeg står på X -> jeg går fra X
is  context    (I isa self, event/real/A),
    replaceall (STAND/I/A, srel/on/place/P/A)
    with       (doit/go/I/A, srel/from/place/P/A)
id  []
ip  dmeq(stand,STAND)
 :- double.


beforemodifier rule
is  not _I isa self,
    replace (srel/REL/time/Cl/A,Cl isa clock,event/real/A)
    with ('I' isa self, srel/REL/time/Cl/A,Cl isa clock, doit/be1/'I'/A, event/real/A)
id  []
ip  dmeq(timeprep, REL)
 :- double.


mustknowbus0  rule % Which station exists
is  exactly (which(A),A isa station,doit/exist/A/E,event/real/E)
id	 add	message(mustknow(bus))
ip  [].


mustknowbusyou rule % Where do you (qua bus)   go
is  which(A),A isa place,srel/_Inat/place/A/C,T  isa program, doit/GO/T/C,event/real/C,
        {dmeq([go,leave,stop,run],GO)}
id	 add	message(mustknow(bus))
ip  [].


mustknowbustest rule % does the buses go
is  test, B isa Veh, {unbound(B)},
    event/real/C,  doit/GO/B/C,
         {dmeq([go,leave,stop,be1],GO)},
         {dmeq([vehicle,bus,tram,program,route],Veh)},
%%%%     not  ispresent X isa clock when { bound(X) },
    not ispresent  srel/_/vehicle/_/_,
    not  ispresent T isa bus when { bound(T) },
    not  ispresent Y isa neighbourhood  when { bound(Y) },
    not  ispresent Z isa station  when { bound(Z) }
id	 add	message(mustknow(Veh))
ip  [].


mustknowbusnewgen rule %  the buses go
is  new, B isa Veh, {unbound(B)},  {dmeq([vehicle,bus,tram,program,route],Veh)},
%    event/_Real/C,  doit/GO/B/C, %% jeg tror at bussen går
    event/ _ /C,  doit/GO/B/C, %% jeg tror at bussen går
         {dmeq([go,leave,stop,be1],GO)},
%%%%     not  ispresent X isa clock when { bound(X) },
    not  ispresent T isa route when { bound(T) },
    not  ispresent T isa bus when { bound(T) },
    not  ispresent Y isa neighbourhood  when { bound(Y) },
    not  ispresent Z isa station  when { bound(Z) },
    not  ispresent Z isa street  when { bound(Z) }
id	 not flag(exit), %% TA-110401
    not  message(mustknow(place)),
    add	message(mustknow(route))  %% \+ kjøretøy
ip  [].



mustknowbus1 rule % Where does the bus go
%is  exactly (which(A),A isa place,srel/_inat/place/A/C,B isa Veh,doit/GO/B/C,event/real/C)
is  exactly (which(A),A isa place,srel/ _ /place/A/C,B isa Veh,doit/GO/B/C,event/real/C)
id	 add	message(mustknow(Veh))
ip  dmeq([go,leave,stop,be1],GO),
    unbound(B),
    dmeq([vehicle,bus,tram,program],Veh). %% du qua Team


mustknowbus2 rule %% PLASS Which places between ( NO BUS)
is  which(Place),Place isa Placoid,doit/be1/Place/A,
    srel/from/place/_FromPlace/A, srel/to/place/_ToPlace/A
id  add ( message(mustknow(bus)))
ip	 unbound(Place),
    dmeq([place,station,neighbourhood],Placoid).


%%%%%%%%%% End MustKnow Section %%%%%%%%%%%%%%%%%%

turings  rule  %% :-) %% ville du bestå Turings test ?
is  test,turing isa man,
    tuc isa savant,F55 isa test,
    dob/Manage/tuc/F55/F66, {dmeq([manage,pass],Manage)},
    event/real/F66,
    has/man/test/turing/F55,
    clear
id  add message(cannotanswermyself),
    add flag(exit)
ip  [].



gowhere rule  %%
is  not ispresent srel/to/place/_/_,    %% (street)
    not srel/from/place/_/_,  %% passerer maskinagentur på vei fra torget.
    not ispresent  doit/arrive/_/_,  %% <--- derived skal være i
%%%%    not ispresent srel/on/place/_/_,     %% assume direction is handled
    not has/vehicle/station/_/_,
    not srel/beyond/place/_/_   %% ad hoc
%%     not ispresent _ isa person %% svensker på risvollan :-) %% ???
id  not flag(exit),
    not flag(nightbusflag),
    not stationsat(_,_,_),
    not message(unrecognized_street(_,_)),
    not message(nearest_station(_ST,_,_)),  %% hva er nærmeste stopp  hvis man skal til Kringsjåveien 16
    not replyq(_),
    not keepto(_,_,_),
    departure(_,_,_,_),
    not connections(_,_,_,_,_,_,_,_,_,_),
    not frequency(_,_,_,_),
    not departure(_,st_olavs_gt,_,_),  %% Dirty
    not findstations(_,_,_),
    not message(mustknow(place)),
    not message(mustknowanother(place)),
    not message(sameplace(_,_)),
    not message(onlyonesentence),
    clear,
    add message(mustknowanother(place)),
    add flag(exit)
ip  []
    :- single.



norouteinfonomessage rule  %% Force negative answer response if no other message
is  %%%%%%%%%%%%%%%%%  not ispresent new, %%%  ==> \+ jeg vet ikke %% TA-101015 du hater meg
    not ispresent has/agent/information/tuc/_, %% -> NO
    not ispresent adj/_/ordinary/_/_,
    not ispresent srel/regularly/time/_/_
id  not flag(exit),
    not message(_),  %% 22. mars (påskeaften) missing negans
    not reply(_),
    not true, %% = Yes
    not ticketprice2(_,_),
    not departure(_,_,_,_),
    not timeis(_),
    not stationsat(_,_,_),
    not passesstations(_,_,_,_),
    not findstations(_,_,_),
    not listofall(_,_),
    not endstations(_,_),
    not flag(fail),
    add flag(fail),
    not ispresent true,  %% TA-100927
    not ispresent false  %%
ip  []
  :-single.



norouteinfo rule  %%
is  %% not ispresent dob/give/_/_/_, %% give me the times
    not ispresent has/agent/information/tuc/_, %% -> NO
    not ispresent adj/_/ordinary/_/_,
    not ispresent srel/regularly/time/_/_

id  not flag(exit),
    add  flag(exit),     %% retention
    not flag(fail),

    not  ticketprice2(_,_),

    not listofall(bus,_),
    not departure(_,_,_,_),
    not message(date_isa_day(_,_)),
    not findstations(_,_,_),
    not timeis(_),
%%     not message(answer(_)),     %%  then tuc knows

    not message(noinfoabout(irregularity)),
    not message(mustknow(bus)),
    not message(mustknow(place)),
    not message(howtuchelp),
    not stationsat(_,_,_),

    removeif message(date_isa_day(_,_)), %% er det søndagsruter idag
    removeif message(otherperiod(_)),
    removeif message(date_day_route(_,_))

%%%     add flag(fail) %% needed as retention
%%   <-- Kills messages

ip  []
  :-single.

missingconnection rule  %% insist on having a connection
is  not ispresent has/agent/information/tuc/_, %% -> NO
    not ispresent adj/_/ordinary/_/_,
    not ispresent srel/regularly/time/_/_
%%     not ispresent _ isa person %% svensker på risvollan ? % en passasjer tok sin   buss * til byen.
id  departure(_,_,_,_),
%%%%     not flag(nightbusflag), %% allow general message %% N:136.

    not flag(airbus), %% annuls foreign message

    not connections(_,_,_,_,_,_,_,_,_,_),
    not findstations(_,_,_),
    not timeis(_),
    not stationsat(_,_,_),
    not message(mustknowanother(place)),
    not message(neverpasses(_,_)),
    not message(answer(_)),     %%  then tuc knows
    not message(noinfoabout(irregularity)),
    not message(mustknow(bus)),
    not message(mustknow(place)),
    not message(howtuchelp),

    not flag(exit),   %% NB used both as finished and as failure !!!!!!
    add flag(exit),
    %% add flag(fail), %% avoid  Det er ikke mulig  på tirsdager.

    not message(mustknowanother(place)), %% retention

    removeall departure(_,_,_,_),        %% Haz?
    removeall passevent(_,_,_,_,_,_),    %% Nec

    %%  clear,  %% <--- kills messages

    add message(mustknowanother(place))  % wrong if message(neverpasses(_,_))
%%     add flag(fail) %% avoid  cannot answer
ip  []
    :-single.



%%%%%%%%%%%%%%%%%%%%%%%

fledsbo8 rule %% %%  Sort out the unknown depsets:We don't know if it's to or from. Hence, it's unknown...
is []
id ispresent departure(_,_,_,Depset1),
   not depset(_, _),
   add depset(unknown, [Depset1])
ip []
:-double.



fledsbonilplaceafter rule %% Lerkendal after 1200, check frames = departure, guess to
is      []
id      not depset(to, _),
        ispresent keepafter(_, X, _),
        replace depset(unknown, List)
        with depset(to, List)
ip   %%    main:myflags(dialog,1),
        main:frame_getvalue(where::departure,_,place),
    \+  main:frame_getvalue(where::arrival,_,place),
        varmember(X, List)
:- double.


fledsbo12 rule %% If keepafter, we guess from
is      []
id      not depset(from, _),
        replace depset(unknown, List)
        with depset(from, List),
        ispresent keepafter(_, X, _)
ip      varmember(X, List)
:-double.


fledsbo131 rule %% If keepbefore1, we guess to
is      []
id      not depset(to, _),
        replace depset(unknown, List)
        with depset(to, List),
        ispresent keepbefore1(_, X, _)
ip      varmember(X, List)
:-double.


fledsbo13 rule %% If keepbefore, we guess to
is      []
id      not depset(to, _),
        replace depset(unknown, List)
        with depset(to, List),
        ispresent keepbefore(_, X, _)
ip      varmember(X, List)
:-double.

fledsboaround rule %% This was already in buslog, but it makes it hard for makeframe.
is      []
id      replace keeparound(Time, R, Rny)
        with keepbetween(LowTime,HighTime,R,Rny)
ip      subfromtime(Time,14,LowTime),
        addtotime(Time,14,HighTime)
:-double.

fledsbowithin rule
is      []
id      replace keepwithin(Time,Mins,R,Rny)
        with keepbetween(Time,NewTime,R,Rny)
ip      addtotime(Time,Mins,NewTime)
:-double.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% NEGANS section %% TA-101014

trytofooltestisa rule
is  test,
    X isa XFrog,{ trytofool(test,X isa XFrog,Delphi)} %% TA-110111
id  flag(fail),
    add message(Delphi)
ip  [].

trytofooltestslash rule
is  test,
    Toad/Frog,{ trytofool(test,Toad/Frog,Delphi)}
id  flag(fail),
    add message(Delphi)
ip  [].

/* Unnec   cannit answer
trytofoolexplainslash rule %% TA-110518
is  explain,
    Toad/Frog,{ trytofool(test,Toad/Frog,Delphi)}
id  flag(fail),
    add message(Delphi)
ip  [].
*/


trytofoolnewisa rule
is  new,
    X isa XFrog,{ trytofool(new,X isa XFrog,Delphi)} %% TA-110111
id  flag(fail),
    add message(Delphi)
ip  [].

trytofoolnewslash rule
is  new,
    Toad/Frog,{ trytofool(new,Toad/Frog,Delphi)}
id  flag(fail),
    add message(Delphi)
ip  [].


trytofooldoisa rule
is  doit,
    X isa XFrog,{ trytofool(doit,X isa XFrog,Delphi)} %% TA-110111
id  flag(fail),
    add message(Delphi)
ip  [].

trytofooldoslash rule
is  doit,
    Toad/Frog,{ trytofool(doit,Toad/Frog,Delphi)}
id  flag(fail),
    add message(Delphi)
ip  [].


trytofoolwhichisa rule
is  which(_),
    X isa XFrog,{ trytofool(which, X isa XFrog,Delphi)} %% TA-110111
id  flag(fail),
    add message(Delphi)
ip  [].

trytofoolwhichslash rule
is  which(_),
    Toad/Frog,{ trytofool(which,Toad/Frog,Delphi)}
id  flag(fail),
    add message(Delphi)
ip  [].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                 %
%  This file is already too big to maintain for any sane person.  %
%  It must under no circumstances exceed  15956 lines.            %
