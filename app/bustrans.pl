/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE bustrans.pl
%% SYSTEM BUSTUC
%% AUTHOR   T.Amble (TA)
%% CREATED  TA-041006
%% REVISED  TA-110825   %% RS-131225  flag/1, used in execute_ptogram ( interapp/pragma... (could be local bustrans?... Fix meta_predicates!)
%% Rune Sætre (RS), Erlig Eeg-Henriksen (EE)

:- module( bustrans, [ rule/2, module_dependencies/0, tracevalue/1 ] ). %  %% id/2, ip/2, is/1,   composite_stat/3,

% Transformation rules for the bus domain (rule/2 is executed from pragma.pl)

% Rules are sorted on priority, so the first rule is always checked before the second rule, and so on.
% Some rules are marked as :- single  or  :- double  if the apply only to the web- or only the dialog-system

% Control predicates    % Uncomment if needed:
% :-single.   Only in query answer mode
% :-double.   Only in dialog mode

%% RULE  FORMAT

%   RuleID rule %% <evoking question>
%   is IS
%   id ID
%   ip IP.

% Explanation: If IS is satisfied in input source, then modify output destination program according to ID, if IP is true.
% In Source progam (IS), In Destination program (ID), In Prolog code (IP)


:- meta_predicate rule( +, 0 ) .   %% How can we get SPIDER to help us check that all predicates are imported correctly?
%:- meta_predicate is( 0 ) .   %% How can we get SPIDER to help us check that all predicates are imported correctly?
%:- meta_predicate id( +, 0 ) .   %% How can we get SPIDER to help us check that all predicates are imported correctly?
%:- meta_predicate ip( ?, 0 ) .   %% How can we get SPIDER to help us check that all predicates are imported correctly?


%% FLAGS: ( used in BusTrans, local (everything accepted) in buslog.pl )
%flag(_).  %% From buslog... Panic : Global flag that is sometimes not removed by bustrans

% flag(exit)                 Don't create more departures
% flag(fail)                 Explicit call of negative answer

%% % flag(nightbus)      %%   = nightbusflag
% flag(nightbusflag)         Query is about nightbus
% flag(nightbusoption)       Ad Hoc Retention flag (avoid-Loop control)


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
%    value(airbusflag)  global flag

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

%UNIT: / and utility/
:- use_module( '../declare', [ value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, value/2.  set( X, Y ) is X := Y .
%value(Key,Val) :- value(Key,Val).  %% RS-130630 value must NOT be volatile predicate!!! This caused BIG TROUBLE!

:- use_module( '../utility/utility', [ append_atomlist/2 ] ). 
                                    
:-use_module( '../db/topreg', [ default_period/3 ] ).   %% RS-151219 Will this work?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                                 % single-question application
single :- value(dialog,0) ;   % if dialog is 0   or
          \+ value(dialog,_). % if dialog is undefined .

                                 % dialog-question application
double :- value(dialog,1).    % if dialog is 1

                                   % single-question application

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% USE_MODULE DEPENDENCIES       %% RS-141019

module_dependencies :-
        dep_module( Module, PredList ),
        use_module( Module, PredList ),
        fail ; true .   %% Get all use_modules, then succeed...


:-use_module( '../db/busdat' ).


%UNIT: /app/
dep_module( AtbModule, [ composite_stat/3 ] ) :-
        default_period( tt, winter,  Module ),
        append_atomlist( [ '../db/tables/', Module, '/regcut.pl' ], AtbModule ).        %write( AtbModule ).     %% RS-151219 Debug. Use append_atoms instead.

dep_module( buslog, [ airbus_module/1, before/2, bus/1, bus_place_station/3, busorfree/1, dayModSeqNo/2, departure/4, message/1,
                      neverarrives/2, neverdeparts/2, neverpasses/2, not/1, notaclock/1, passesstations/4, place_station/2, samefplace/2, station/1,
                      stationsat/3, street_station/2 ] ). 
% :-use_module( buslog ).

%UNIT: /db/
%dep_module( '../db/busdat', [ airbusstation/1, bus_dependent_station/3, central_fromstation/1, corresponds/2, date_day_map/2,
%                              default_destination/2, disallowed_night/1, exbus/1, 
%                              extraallowed_night/2, fromstationonly/1, home_town/1, internal_airbus/1, nightbusstation/1, nostationfor/1,
%                              railway_station/1, thetramno/1, tostationonly/1, vehicletype/2, xforeign/1 ] ).

%UNIT: /
%%% TODO: Find out why datetime/6, went undiscovered! There must be a way to test all these rules for completeness...
dep_module( '../declare', [ set/2 ] ). %% RS-141015        Set variable-values,  in the module ! (RS-150414. Which module? Caller or Called Module?)

%UNIT: /utility/  and  /
dep_module( '../utility/utility', [ bound/1, implies/2,  maxval/3, minval/3, set_of/3, test/1, testmember/2, unbound/1 ] ). %% RS-131225 set(X,Y) from declare.pl
dep_module( '../utility/datecalc', [ add_days/3, addtotime/3, before_date1/2, datetime/6, days_between/3, daysucc/2, difftime/3,
                                     finddate/2, findfirstcomingdate/2, isday/1, number_of_days_between/3,
                                     sub_days/3, subfromtime/3, timenow/1, timenow2/2, today/1, todaysdate/1, valid_date/1, weekday/2,
                                     xweekday/2 ] ).

dep_module( '../interfaceroute', [ decide_period/2 ] ). %% RS-141015 

%UNIT: /app/
%%% RS-131225, UNIT: app/
%:-use_module( busanshp ).      %% RS-140102 get all? tracevalue/1 is unique for each rule module! (traceans, traceprog, ...)

dep_module( busanshp, [ busman/2, corresporder/3, evening_time/2, evening_time0/2, i_or_a_bus/3, mixopt/3,
                        setopt/3, setopts/3, sorttimes/4, special_day/1, warningtime/2 ] ).
%                         empty_sms_message/1, make_total_google/2, pay/0, printmessage/1, startmark/0 ] ). %%Extra?

dep_module( dmeq, [ dmeq/2 ] ). %% RS-140102, Really Used, in several  pragma.pl->interapp->bustrans rules 
dep_module( interapp, [ newfree/1 ] ).
%dep_module( pragma, [  ]). %% RS-140102-141002 These modules are highly connected: interapp, pragma, bustrans!
%FIXED META-PREDICATES!?!

%UNIT: /db/
dep_module( '../db/foreign_places', [ foreign/1 ] ). % (PLACE) -> places.pl
dep_module( '../db/places', [ corr/2, isat/2, nostation/1, place_resolve/2, placestat/2, underspecified_place/1 ] ). 
%% RS-141102  %uses /db/placestat/2 !! corr/2, foreign/1, isat/2, nostation/1, 
%:- use_module( '../db/regbusall' ). % , [ nightbus/1, regbus/1 ]  %% HEAVY DB! %% RS-120803 RS-131225 regbus/1 MOVED to app/buslog.pl
dep_module( '../db/regbusall', [ nightbus/1, regbus/1 ] ). %% RS-111213 General (semantic) Operators Moved (back) to busdat
dep_module( '../db/teledat2', [ has_att_val/4, have_att_val/4 ] ). %% RS-111213 General (semantic) Operators Moved (back) to busdat
dep_module( '../db/timedat', [  aroundmargin/1, maxtraveltime/1, morning_break/1, named_date/2 ] ). %% RS-111213 General (semantic) Operators Moved (back) to busdat

%UNIT: /dialog/
dep_module( '../dialog/frames2', [ frame_getvalue/3 ] ).
                   
%UNIT: /tuc/
%dep_module( '../tuc/fernando', [ subclass0/2 ] ). %% REALLY USED! See below!
dep_module( '../tuc/facts', [ isa/2 ] ).       %% RS-131225  isa/2 IS used by p0(X) :- call(X). %% X == isa/2, etc.
dep_module( '../tuc/names', [ generic_place/1 ] ).       %% RS-141019
dep_module( '../tuc/semantic', [ ordinal/2 ] ). %% REALLY USED! See below!
dep_module( '../tuc/slash', [ description/2 ] ).       %% RS-141030


:- module_dependencies. %% RS-141019 Import all predicates used in the rules below, from the correct modules.

%dep_module( buslog, [ atday/1, atdate2/2, timeis/1, dateis/4, message/1, neverpasses/2, takestime/3, timeis/1, takestime/3 ] ). %% Date?
%        decide_period(_, _),    % /
%        i_or_a_bus(_, _, _),    % app/busanshp.pl
%        airbus_module(_), bus(_), bus_place_station(_, _, _), composite_stat(_, _, _), dayModSeqNo(_, _), departure(_, _, _, _),% app/buslog.pl
%        message(_), neverdeparts(_, _), neverpasses(_, _), passesstations(_, _, _, _), place_station(_, _), samefplace(_, _), station(_),            % app/buslog.pl
%        dmeq(_, _),  airbusstation(_), bus_dependent_station(_, _, _), central_fromstation(_), date_day_map(_, _), exbus(_),    % db/busdat.pl
%        fromstationonly(_), home_town(_), internal_airbus(_), nostationfor(_), vehicletype(_, _), xforeign(_),                  % db/busdat.pl
%        placestat(_, _), underspecified_place(_), _ isa _,
%        timenow(_), timenow2(_, _), today(_), todaysdate(_), weekday(_, _),                                             % utility/datacalc.pl
%        bound(_), testmember(_, _), unbound(_),                                                                         % utility/utility.pl
%        add_days(_, _, _), addtotime(_, _, _), before_date1(_, _), daysucc(_, _), difftime(_, _, _), isday(_),
%        sub_days(_, _, _), subfromtime(_, _, _),
%        newfree( _ ).



%%%%%%%%    -> dmeq.pl %%%%%%%% dmeq(A,B)  B means the same as A in this domain %%%%%%%% First argument must be bound! %dmeq( Set, Term)

tracevalue(L) :- value(traceprog,L).  % Trace level 1-7      %% RS-131225    Defined in busans?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ONLY FOR TESTING (Rune)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%TESTING RS-140929 %% RS-140101 AVOID existence error for all predicates used in the rules.
%:- use_module( pragma, [ pragma/3, i0/3, d0/3, p0/1 ] ). % , sequence_member/2.   %%RS-131228  pragma/3 etc. Is using "" here the way to go? %% RS-140927
%test(X):- \+ ( \+ ( X)).        %% Calls test(nostation(Y)), test("X ako Y"), among other things, so: make it local in metacomp-> dcg_?.pl
%safe :- 
%        %pragma( bustrans, [(doit,reply('Hei'))], _X ),
%        Source = [(doit,reply('Hei'))],
%        (( _RuleID rule iss InSource idd InDest ipp Cond )),
%         i0( RuleModule:InSource, Source, SourceMiddle ),      %% For *:rule/2 -> is (in source)
%         d0( RuleModule:InDest, SourceMiddle, DestMiddle ),            %% For *:rule/2 -> id (in destination)
%         writeout:output( DestMiddle ),nl,
%         p0( RuleModule:Cond )     %% RS-140101 existence error in mixopt/3 ([to], [from], X), place_station, place_station         %% For *:rule/2 -> ip (in prolog)
%       .
%%  test( InSource ),
%%  test( InDest ), 
%%  test( Cond ).
%:-safe.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%From declare.pl: %% RS-150414
% :- op( 1150, xfy, rule ). %% Moved to declare.pl ?  % RS-140617
% :- op( 1120,  fy, is ).   %% "is" is a prolog operator!?? RS-141006
% :- op( 1110, xfy, id ).
% :- op( 1110, xfy, ip ).
%
%:- op( 715, fy,context).    %% similar to present, but doesnt mark as seen 
%:- op( 715, fy,addfront).   %% (for messages etc) 
%:- op( 725, fy,addcon).     %% add if not already present 
%
%:-op( 725,xfy, or ).    %% From ../declare.pl   OPERATORS
%:-op( 720,xfy, and ).
%:-op( 715, fy, not ).   %% :- op( 715, fy,not).  % Already defined in TUC
%:- op( 715, fy,removeall).  %% remove all of a list
%:- op( 715, fy,removeif).   %% remove all if any , always succeed 
%:- op( 715, fy,replaceall). %% replace iteratively all elements 
%:- op( 715, fy,replaceif).  %% replace if occuring. 
%:- op( 715, fy,replace).
%:- op( 715, fy,replacelast).
%:- op( 715,xfy,with).
%:- op( 715, fy,no).
%:- op( 715, fy,exactly). 
%:- op( 715, fy,add).
%:- op( 715, fy,remove).
%:- op( 715, fy,present).
%
%:- op( 714,xfy,cond).    %% new   not X isa place cond bound(X)
%:- op( 714,xfy,when).    %% same as cond %% TA-081106
%:- op( 712, fy,seen). % Lower than "not", higher than "isa"

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RULE SECTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

heading  rule  bustrans:(% Heading (Comment) , Do nothing
is  [(head,_)],clear
id   add flag(comment)
ip  []).


%% rules to handle list of TQL statements

tqllist0 rule bustrans:( % YES. | NO.
is  [(confirm,_)]
id  add message(answer(bcpbc(ok))),
    add flag(exit) %%  avoid OK./OK.
ip  []).
%%%%%%     :- single.

tqllist1 rule   bustrans:(% YES, ... | NO, ...
is  replaceall [(confirm,_)|Y]
    with Y
id  []
ip  []).
%%%%%%%    :- single.

tqllist2 rule bustrans:(  % List with one query
is  replaceall [X]
    with X
id  []
ip  [])
    :- single.

tqllist2err rule bustrans:(  % ignore 1 error
is  replaceall [X,error]
    with X
id  addfront message(onlyonesentence) %% TA-110112
ip  [])
    :- single.

tqllist3 rule bustrans:( %  varsel  buss går til nth
is  [(flag,Flagname),replyq(_)]
id  add message(mustknow(time)),
    add flag(exit) % no more action
ip  set(Flagname,true))
    :-single.


tqllist4 rule bustrans:( %  varsel  buss går til nth
is  replaceall [(flag,Flagname),Rest]
    with Rest
id  []
ip  set(Flagname,true))
    :-single.


tqllist5 rule bustrans:( %  OK ! Jeg heter Tore
is  replaceall [((do),reply('OK'))|Rest]
    with Rest
id  []
ip  [])
    :-single.

tqllistl6 rule bustrans:( %  OK ! Jeg heter Tore
is  replaceall [((do),replyq('Hello'))|Rest]
    with Rest
id  []
ip  [])
    :-single.


tqllist7 rule bustrans:( %  OK ! Jeg heter Tore
is  replaceall [((do),reply(X))|Rest]
    with Rest
id  addfront replyq(X)
ip  [])
    :-single.

tqllist8 rule bustrans:( %  Hei ! Jeg heter Tore
is  replaceall [((do),replyq(X))|Rest]
    with Rest
id  addfront replyq(X)
ip  [])
    :-single.



tqllist9 rule bustrans:(  % List with several  queries
is  replaceall [X|_]
    with X
id  addfront message(onlyonesentence)
ip  [])
    :-single.



error rule bustrans:( %% Erroneous and nonsensical
is  error
id  add reply('?')
ip  []).

%%%%-------------------------------------------------------------------------------%


%%%%-----------------------------------------------------------------------%

nonightbusatall1 rule bustrans:( % night bus is disabled
is  clear
id  flag(nightbusflag),
    clear,
    add message(noinfoabout(nightbus)),
    add flag(exit)
ip  value(disablenightbus,true)).


nonightbusatall2 rule bustrans:( %% nattbuss til risvollansenteret (but no nightbusatall)
is  _ isa midnight,clear
id  clear,
    add message(noinfoabout(nightbus)),
    add flag(exit)
ip  value(disablenightbus,true)).


% USE CONTEXT  (Dialog)

usecontext rule bustrans:(
is []
id remove
     askfor([], Slot, Value)
ip current_frame(Frame),
   frame_getvalue_rec(Frame, Slot, Value, _)
):- double.


lockcontext rule bustrans:( %% empty value if no framevalues exists
is []
id present askfor([], _, Value)
ip newfree(Value)
):- double.




useref rule bustrans:(
is	present whichref(Type, List) isa _
id not askref(_, _),
	add askref(Type, List)
ip [])
  :- double.




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% SECTION  Source to Source Transformation  %%
%%%%    Can be paraphrased in NRL.             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%:- meta_predicate rule bustrans:((+,+) .   %% How can we get SPIDER to help us check that all predicates are imported correctly?
%%%%:- meta_predicate is(:) .   %% How can we get SPIDER to help us check that all predicates are imported correctly?


bringrule rule bustrans:( %%  Which bus brings me to Ringve
is  replaceall (bring/A/_I_/E, A isa Veh, event/real/E)
    with      (A isa Veh,(do)/go/A/E),
    { dmeq(vehicle,Veh) }
id  []
ip  []).

lunchtime rule bustrans:( %% går buss 5 ved lunsjtider
is  replaceall (T isa lunchtime,srel/Prep/time/T/E)
    with       (1200 isa clock,srel/Prep/time/1200/E)
id  not flag(earlytime),
    add flag(earlytime)
ip  []).


toclock rule bustrans:( %% jeg skal til risvollan til klokka 6
is  replaceall srel/to/clock/T515/E
    with       srel/before/time/T515/E
id  []
ip  []).


isitlongt rule bustrans:( %% er det langt ==> hvor lenge varer det
is  replaceall ( %% test,
                adj/_/long/A/E,event/real/E)
    with       (which(A), A isa duration,B isa vehicle,(do)/go/B/E, srel/(with)/duration/A/E)
id  []
ip  newfree(B)).


movedto rule bustrans:( %% I moved to = go from
is  replaceall (I isa self,move/I/A,srel/to/place/Nth/A)
    with       (I isa self,(do)/go/I/A,srel/from/place/Nth/A)
id  []
ip  []).


%%%% Airbusflag section

airbusquery1 rule bustrans:(
is  replaceall X isa bus
    with       X isa airbus
id  not flag(airbus),
    add flag(airbus)
ip  internal_airbus(true),
    bound(X),
    airbus(X),
    set( airbusflag,true ),  %% must be set to FALSE initially! RS-151219 Remember to do this in tucbuses.pl !
    set( actual_domain, fb ) ).  %% reset in interapp ?

airbusquery2 rule bustrans:(
is  context X isa route  %% not class airbus
id  not flag(airbus),
    add flag(airbus)             %% Somewhat dirty
ip  internal_airbus(true),bound(X),
    airbus(X),
    set(airbusflag,true),  %% must be false initially
    set(actual_domain,fb)).  %% reset in interapp


airbusquery3 rule bustrans:(
is  context _X isa airbus
id  not flag(airbus),
    add flag(airbus)             %% Somewhat dirty
ip  internal_airbus(true),
    set(airbusflag,true),  %% must be false initially
    set(actual_domain,fb)).


airbusquery4 rule bustrans:(
is  context _Værnes isa airport
id  not flag(airbus),
    add flag(airbus)
ip  internal_airbus(true),
    set(actual_domain,fb),
    set(airbusflag,true)). %% must be false initially


%%% subtle, swaps sequence of sentrum flyplass -> værnes sentrum
%%%%    replacement starts at first occurrence of first item ( free(X) isa airport)
tofromairport rule bustrans:(
is  replaceall (  srel/TO/place/free(X)/E , free(X) isa airport) %#%
    with       (  værnes isa airport,  srel/TO/place/Værnes/E ),
    add flag(airbus)
id  []
ip  internal_airbus(true),
    default_destination(fb,Værnes),
    set(airbusflag,true),
    set(actual_domain,fb)).



%% Nightbus section %%

nightbusquery1 rule bustrans:(   %% bus 999 -> nightbus 999 if nightbus
is  replaceall X isa bus
    with       X isa nightbus
id  not flag(nightbusflag),
    add flag(nightbusflag)
ip  bound(X),
    nightbus(X),
    set(nightbusflag,true) ).  %% must be reset initially

nightbusquery2 rule bustrans:(
is  context X isa route  %% not class nightbus
id  not flag(nightbusflag),
    add flag(nightbusflag)             %% Somewhat dirty
ip  bound(X),
    nightbus(X),
    set(nightbusflag,true)).  %% must be reset initially

nightbusquery3 rule bustrans:(
is  context _X isa nightbus
id  not flag(nightbusflag),
    add flag(nightbusflag)             %% Somewhat dirty
ip  set(nightbusflag,true) ).    %% must be reset initially

nightbusquery4 rule bustrans:(   %% move this after shunt ?
is  context _x isa midnight,
    not (do)/exist/_x/_  ,
    not srel/before/time/_/_ ,   %% before midnight is NOT nightbus
    not nrel/before/_/time/_/_, %%
    not srel/around/time/_/_ ,   %% around  midnight is not? nightbus
    not nrel/around/_/time/_/_ %%
id  not flag(nightbusflag),
    add flag(nightbusflag)             %% Somewhat dirty
ip  set(nightbusflag,true)).  %% must be reset initially


donot rule bustrans:( %% dont do that
is  (do), (not _),
    clear
id  clear,
    add reply('OK')
ip  []).


modifier0 rule bustrans:(  %% empty modifier
is  exactly (modifier(_),event/_/_)
id  add message(completesentence)
ip  []).


modifier1 rule bustrans:( %%  med buss til buenget
is  context B isa Bus,
    not present _ isa endstation,  %% Ad Hoc
    replaceall modifier(C)
    with  (which(A),A isa time,(do)/go/B/C,srel/in/time/A/C)
id  []
ip  dmeq( [bus,nightbus,route,tram], Bus ), newfree(A) ).

modifier1a rule bustrans:(  %% busser i tide %% not 1A (\spyr command)
is  context  srel/ION/time/A/C, {dmeq([in,on,nil],ION)}, %% nil
    not _ isa endstation,
    not _ isa  tram,
    replaceall modifier(C)
    with  (which(A),B isa bus,(do)/go/B/C)
id  []
ip  newfree(B)).

modifier1b rule bustrans:(  %% buss på lørdag morgen
is  context  srel/ION/morning/A/C, {dmeq([in,on,nil],ION)},   %% nil
    not _ isa endstation,
    not _ isa  tram,
    replaceall modifier(C)
    with  (which(A),B isa bus,(do)/go/B/C)
id  []
ip  newfree(B)).


modifier2 rule bustrans:( %% Til nardosenteret
is  not present (do)/go/_/_ ,
    not _ isa  tram,
    replaceall modifier( C )
      with  (
               which( A ),
               B isa bus,
          %%%  adj/nil/next/B/real,  %% gets more buses
			 %% "affects  Buster dialog %%
               A isa time, (do)/go/B/C, srel/in/time/A/C 
            )
id  []
ip  newfree(A),newfree(B)).



modifiergo0 rule bustrans:( %% from A in order to goto B
is  replaceall (modifier(C),(do)/go/I/K)
    with  (which(A),B isa bus,(do)/go/B/C,A isa time,srel/in/time/A/C),
    {unbound(I)},
    {unbound(K)}
id  []
ip  newfree(B),newfree(A)).


modifier3 rule bustrans:(%% Bloody repair rule
is  replaceall (modifier(E),srel/nil/_Stat/F/E)
    with       (which(F))
id  []
ip  []).


departurestat rule bustrans:( % departure A -> from A
is replaceall
   (srel/nil/departure/B/A,event/real/A,nrel/nil/departure/place/B/Risvollan)
    with
    (srel/from/place/Risvollan/A,event/real/A)
id  []
ip  []).


arrivalstat rule bustrans:( %%  departure A ->  to  A ( Not tested)
is  replaceall  (srel/nil/arrival/B/A,event/real/A,nrel/nil/arrival/place/B/Risvollan)
     with       (srel/to/place/Risvollan/A,event/real/A)
id  []
ip  []).

srelbeforeplace rule bustrans:(  % buss går før X2 %% TA-110624  = between HT and X2
is  replaceall (srel/before/place/X2/E)
    with       (srel/from/place/hovedterminalen/E,srel/to/place/X2/E)
id  []
ip  []).


srelbetweenplace rule bustrans:(  % buss går mellom  X1 og X2
is  replaceall (srel/Between/place/(X1,X2)/E)
    with       (srel/from/place/X1/E,srel/to/place/X2/E)
id  []
ip  dmeq([between,past],Between)).


srelbetweentoplace rule bustrans:(  % buss går mellom X1 til X2
is  context srel/to/place/_X2/E ,
    replaceall srel/between/place/X1/E
    with       srel/from/place/X1/E
id  []
ip  []).


nrelbetweenplace rule bustrans:(  % buss mellom A og B
is  replaceall (nrel/Between/Bus/place/B/(X1,X2))
    with       (nrel/from/Bus/place/B/X1,nrel/to/Bus/place/B/X2)
id  []
ip  dmeq([between,past],Between)).


nrelforbus rule bustrans:( % avgang for B1 og B2
is  replaceall  nrel/for/departure/Ve/F/(A,_B)
    with        nrel/for/departure/Ve/F/A
id  add message(onlyonebus)
ip  []).

nrelday rule bustrans:(   % buss på torsdag og fredag
is  replaceall (nrel/Prep/Bus/Day/B/(X1,_X2))
    with       (nrel/Prep/Bus/Day/B/X1)
id  add        message(onlyoneday)
ip  dmeq([day],Day)).


%%%% tuc isa program -> tuc isa savant %% etc
knowifexist rule bustrans:( %% = test
is  replaceall
             (test,tuc isa savant,(do)/exist/A/D,tell/(id)/whether/tuc/B/C,event/real/C,event/B/D)
    with     (test, (do)/exist/A/C,event/real/C)
id  []
ip  []).


shuntaroundtime rule bustrans:( %% i halv tre tiden -> halv tre
is replaceall srel/around/time/T/E
   with       srel/nil/time/T/E
id  []
ip  []
):- double.


shuntbetweentime rule bustrans:( %% same event
is  replaceall (nrel/Between/_/Time/A/(X1,X2))
       with    ((do)/be1/A/E, event/real/E,
                srel/between/Time/(T1,T2)/E)
id  []
ip  dmeq([in,between],Between), %% i tidsrommet X1 og X2
    newfree(E),
    sorttimes(X1,X2,T1,T2)).


shuntbetween1 rule bustrans:( %% same event
is  replaceall (nrel/Between/_/Time/A/(X1,X2))
       with    ((do)/be1/A/E, event/real/E,
                srel/from/Time/X1/E, srel/to/Time/X2/E)
id  []
ip  dmeq([in,between],Between), %% i tidsrommet X1 og X2
    newfree(E)).

shuntbetween2 rule bustrans:(  % i tidrsommet  mellom T1 til T2
is  replaceall (nrel/Between/D/Time/A/X1, nrel/to/D/Time/A/X2)
       with    ((do)/be1/A/E, event/real/E,
                srel/from/Time/X1/E, srel/to/Time/X2/E)
id  []
ip  dmeq([in,between],Between), %% i tidsrommet X1 og X2
    newfree(E)).


nrelplaceand rule bustrans:( %% bus from A and B
is  replaceall (nrel/Prep/Bus/place/B/(X1,X2)) %% rute 9 og 6 *
    with       (nrel/Prep/Bus/place/B/X1,nrel/Prep/Bus/place/B/X2)
id  [] %%  add message(onlyoneplace) leave it to other rule bustrans:(s
ip  []).


nrelplaceor rule bustrans:( %% bus from A or  B
is  replaceall  nrel/Prep/Vehicle/place/A/(B;_C)
    with        nrel/Prep/Vehicle/place/A/B
id  addcon message(onlyoneplace)
ip  []).


srelstationnear rule bustrans:( %% to a station near
is  replaceall (B isa station,(do)/be1/B/C,srel/Near/place/Heimdal/C,srel/Prep/place/B/D)
    with       (srel/Prep/place/Heimdal/D)
id  []
ip  dmeq([near,at],Near)).


srelbetweenplace rule bustrans:(  %% bus between  A ,  B
is  replaceall  srel/between/place/(B,C)/E
    with       (srel/from/place/B/E, srel/to/place/C/E)
id  []
ip  []).


passplaceand1 rule bustrans:(  %% passes NS and BE
is  not present srel/nil/place/_SVB/_,
    replaceall  dob/pass/A/(NS,BE)/E
    with        ((do)/go/A/E,srel/from/place/NS/E,srel/to/place/BE/E)
id  []
ip  []).


srelplaceand1 rule bustrans:(  %% past A and B
is  not present srel/nil/place/_SVB/_, %% sverresborg til A and B
    replaceall  srel/Past/place/(B,C)/E
    with        (srel/from/place/B/E,srel/to/place/C/E)
id  []
ip  dmeq([past,for,to],Past)). %% To A and B means from A to B


srelplaceand2 rule bustrans:( %% to A and  B
is  replaceall  srel/Prep/place/(B,_C)/E
    with        srel/Prep/place/B/E
id  add message(onlyoneplace)
ip  []).


srelplaceor rule bustrans:( %% to A or B
is  replaceall  srel/Prep/place/(B;_C)/E
    with        srel/Prep/place/B/E
id  add message(onlyoneplace)
ip  []).

srelvehor rule bustrans:( %% buss sju eller åtte
is  replaceall  srel/Prep/vehicle/(B;_C)/E
    with        srel/Prep/vehicle/B/E
id  add message(onlyonebus)
ip  []).


back rule bustrans:( %  and back
is  srel/back/place/nil/_
id  add message(toomanyplaces),
    add flag(exit)
ip  []).


return rule bustrans:( %  and back
is  _ isa return
id  not message(onlyonesentence),   %% comes first, but should have been omitted
    add message(toomanyplaces)
ip  []).


busintimerepair rule bustrans:( % buss (i tiden ) 1700 1800
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
    maxval(T1700,T1800,Tmax)).


canigetinfo rule bustrans:( %% can i get info
is  replaceall
        (test,A isa self,B isa information,nrel/About/information/thing/B/X,
         event/real/E, dob/Receive/A/B/E) %% the event is irrelevant
    with       (which(X))
id  []
ip  dmeq(about,About),
    dmeq([receive,get,see],Receive)).


iwillhaveinfo rule bustrans:( %% jeg ønsker informasjon om
is  replaceall (new,A isa self,B isa information,nrel/About/information/thing/B/X,
               has/agent/information/A/B)
    with       (which(X))
id  []
ip  dmeq(about,About)).


iwantinfo rule bustrans:( %% jeg ønsker informasjon om
is  replaceall (new,A isa self,want/A/B/_, B isa information,nrel/About/information/thing/B/X)
    with       (which(X))
id  []
ip  dmeq(about,About)).


givemeinfo rule bustrans:( % gi meg informasjon om
is  exactly  ((do),tuc isa savant,Inf isa information,
              dob/give/tuc/Inf/E,event/real/E),
    clear
id  add message(mustknow(place))
ip  []).

benamedsubjobj  rule bustrans:( %% Hva heter bussene
is  replaceall (which(A),dob/be_named/A/B/_, B isa Bus)
    with       (which(B),B isa Bus)
id  []
ip  []).

benamehewho  rule bustrans:( %% Hva heter han som = hvem %% TA-110620
is  replaceall
     (which(F19),dob/be_named/F20/F19/_,F19 isa thing,F20 isa _Man)
    with
     (which(F20),F20 isa agent),
    {unbound(F20)}  %% TA-110627
id  []
ip  []).

benamedobjsubjthing rule bustrans:( %% Hva heter holdeplassene (hvilken x, hpl heter x)
is  replaceall (which(A),dob/be_named/B/A/_, A isa thing,B isa Stat)
    with       (which(B),B isa Stat),
    {unbound(B)}
id  []
ip  []).

benamedobjsubj rule bustrans:( %% Hva heter holdeplassene (hvilken x, hpl heter x)
is  replaceall (which(A),dob/be_named/B/A/_, B isa Stat)
    with       (which(B),B isa Stat),
    {unbound(B)}
id  []
ip  []).


be2awh rule bustrans:( %% Hva er holdeplassene
is  not _ isa clock, %% tricky
    replaceall (which(A),A isa thing,dob/be/B/A/_, B isa Price)
    with       (which(B),B isa Price),
    {unbound(B)}
id  []
ip  []).

be2bwh rule bustrans:( %% Hva er holdeplassene
is  not _ isa clock, %% tricky
    replaceall (which(A),A isa thing,dob/be/A/B/_, B isa Price)
    with       (which(B),B isa Price),
    {unbound(B)}
id  []
ip  []).

be2thing rule bustrans:( %% hvilken uke er dette %% TA-110203
is
    replaceall (which(A),dob/be/B/A/_, B isa thing)
    with       (which(A)),

    {unbound(B)}
id  []
ip  []).


be2a rule bustrans:( %% Hva er billettprisen : which(A), B isa price & dob/be/B/A/D
is  not _ isa clock, %% tricky
    not _ isa date,
    replaceall (which(A),dob/be/B/A/_, B isa Price)
    with       (which(B),B isa Price),
    {unbound(B)}
id  []
ip  []).


be2b rule bustrans:( %% hvilke busser er det fra ...
is  replaceall (which(A),dob/be/A/B/_, B isa Bus)
    with       (which(B),B isa Bus)
id  []
ip  unbound(B)).



nowash1 rule bustrans:(  % ingen info om ren
is  adj/_/clean/_/_
id  add message(noinfoabout(cleaning ))
ip  []).

nowash2 rule bustrans:(  % ingen info om renhold
is  dob/clean/_/_/_
id  add message(noinfoabout(cleaning ))
ip  []).


runttgo rule bustrans:( %% hvor kjører TT ?
is  which(A),A isa place, tt isa company,(do)/run/_/_, srel/nil/place/A/_,
    clear
id  add listofall(bus,_),
    add flag(exit)
ip  []).


runvehgo rule bustrans:(%% intransitive run=go, simplify rules
is  context X isa Veh, {dmeq(vehicle,Veh)}, %% dont eat
    replaceall ((do)/run/X/Y)
    with       ((do)/go/X/Y)

id  []
ip  []).


midday0 rule bustrans:( % mid day is 1200
is  replaceall (B isa noon,nrel/in/bus/time/C/B)
    with       (nrel/around/bus/time/C/1200)
id  []
ip  []).



whathaveyouinfoabout rule bustrans:( % what have you info about
is  replaceall (which(A),B isa information,
                nrel/About/information/thing/B/A,
                has/agent/information/tuc/B,event/real/C)
    with        (which(A),dob/know/tuc/A/C,event/real/C)
id  []
ip  dmeq([about,over,regarding],About)).


secondlast rule bustrans:( %% nestsiste %%
is  replaceall (adj/_/second_last/A/B)
    with       (adj/_/second/A/B,adj/_/last/A/B)
id  []
ip  []).


amonplaceandshallbeonplace rule bustrans:(   %% er på og skal til
is  present (do)/arrive/A/_,           %% ad hoc
    replaceall ((do)/Be1/A/S, srel/NATO/place/B/S) %% hopefully in sequence
    with       ((do)/go/A/S, srel/from/place/B/S),
    {dmeq([be1,befind,stand,sit],Be1)}, %%  og befinner meg
    {dmeq([at,on,in],NATO)} %% drop nil
id  []
ip  []).


arriveniltime rule bustrans:(   %% Norw  BUS ankomme kl 10
is  present  A isa Bus,{dmeq(vehicle,Bus)}, %% I arrive may mean  at start station
    replaceall ((do)/arrive/A/S, srel/nil/time/B/S)
    with       ((do)/go/A/S, srel/before/time/B/S)
id  []
ip  []).


leave2 rule bustrans:(   %% Norw  forlate
is  replaceall (dob/leave2/A/B/S)
    with       ((do)/go/A/S, srel/from/place/B/S)
id  []
ip  []).


pastab rule bustrans:( %% go past A, B
is  replaceall (srel/past/place/(A,B)/E)
    with       (srel/past/place/A/E,srel/past/place/B/E)
id  []
ip  []).


edemang rule bustrans:( %% is it many that (Norw)
is  replaceall (test,quant(gt/2,A))
    with       (howmany(A))
id  []
ip  []).

counthowmany  rule bustrans:( % hva er antall busser
is  replaceall (which(X),quant(count,X))
    with       howmany(X)
id  []
ip  []).

removequantall  rule bustrans:( % kan du hele rutetabellen
is  remove  quant(all,_)
id  []
ip  []).


knowstation rule bustrans:( %% TUC knows station
is  context (tuc isa savant,A isa station),
    replaceall (test,dob/KNOW1/tuc/A/E )
    with       ((do), dob/describe/tuc/A/E),
    {dmeq([know,know1],KNOW1)}
id  []
ip  bound(A)).


isused rule bustrans:( %% is used means exists
is replace  adj/_/use/A/B
   with     (do)/be1/A/B
id []
ip []).


toomanyhours rule bustrans:(
is  NotClock isa hour, {number(NotClock),NotClock > 5},
    clear
id	 add message(inconsistentduration),
    add flag(exit) % finish it
ip	 []).


toomanyminutes  rule bustrans:(
is  NotClock isa minute, {number(NotClock),NotClock > 300},
    clear
id	 add message(inconsistentduration),
    add flag(exit) % finish it
ip	 []).


witharrivaltime rule bustrans:( %% with arrival Time means before Time
is  ET isa arrival,
    replaceall nrel/(with)/bus/arrival/Time/ET
    with       nrel/before/bus/time/Time/ET
id  []
ip  []).


beduring2time rule bustrans:( %% Skal være om 30 minutter = FØR
is  context (I isa self,(do)/be1/I/E),
    replaceall (srel/during2/time/X/E,X isa Minute)
    with  (X isa Minute,srel/within/duration/X/E)
id  []
ip  dmeq(timeunit,Minute)).

arriveduring2time rule bustrans:( %% ankommer  om 30 minutter = FØR
is  context (I isa self, (do)/arrive/I/E),
    replaceall (srel/during2/time/X/E,X isa Minute)
    with  (X isa Minute,srel/within/duration/X/E)
id  []
ip  dmeq(timeunit,Minute)).


duringevening rule bustrans:( %%  buss om kvelden
is  replaceall (X isa night,srel/during/time/X/E)
    with       (srel/in_night/time/nil/E)
id  []
ip  []).


eveningbus rule bustrans:( %% evening bus
is  replaceall (B isa eveningbus)
    with       (B isa bus,srel/after/vehicle/time/B/1800)
id  []
ip  []).

morningbus rule bustrans:( %% morning bus
is  B isa morningbus, % not replace, keep as memory
    add (B isa bus, nrel/before/bus/time/B/1100)
id  []
ip  []).

traveldisttime rule bustrans:(
is  replaceall (nrel/from/Duration/place/A/Nth,nrel/to/Duration/place/A/Risvollan)
    with       (B isa bus,nrel/from/bus/place/B/Nth,nrel/to/bus/place/B/Risvollan,
                nrel/(with)/duration/vehicle/A/B)
id []
ip newfree(B),dmeq(duration,Duration)). %% distance or duration


travellength rule bustrans:( %% travel length
is  context B isa duration,
    replaceall   (which(A),A isa length, has/time/length/B/A)
    with         (which(B))
id  []
ip  []).


directionfromtown rule bustrans:( % from place out from hoveterminalen means to place
is  replaceall (nrel/from/bus/place/S/C,B isa direction,
                nrel/from/direction/place/B/hovedterminalen)
    with       (nrel/to/bus/place/S/C)
id  []
ip  []).


directionfrom rule bustrans:( % from place in direction  hoveterminalen means from  place
is  replaceall (B isa direction,nrel/from/direction/place/B/N,srel/WIN/direction/B/C)
    with       (srel/from/direction/N/C)
id  []
ip  dmeq([with,in,nil],WIN)).


yourjob  rule bustrans:( % hva er jobben DIN %%  before no info about noun
is  %% which(_),
    has/agent/Job/tuc/_,
       {dmeq([job,service,task],Job)}
id  add message(howtuchelp),
    add flag(exit)
ip  []).



infohelp rule bustrans:( % (gi meg) informasjon
is  which(A),(B isa information,event/real/C,dob/be/B/A/C)
id  add message(howtuchelp)
ip  []).


whatisthis1  rule bustrans:(  %% hva er dette if not subsumed
is  exactly (which(A),A isa thing,event/real/E),
    not _Verb/A/E %% hva kjører
    %% not  has/self/thing/_/_ %% hva skal vi ha til middag
id  add message(howtuchelp)
ip  []).


whatisthis2  rule bustrans:(  %% hva er dette %%after be2a
is  which(A),B isa thing,event/real/C,dob/be/B/A/C
id  add message(howtuchelp)
ip  []).

whatisit rule bustrans:( %% hva er det
is  which(it), it isa thing
id  add  message(howtuchelp)
ip  []).


telljoke rule bustrans:(
is  Bustuc isa savant,A isa Joke, dob/tell/Bustuc/A/_
id  add  message(howtuchelp)
ip  dmeq(tuc,Bustuc),
    dmeq([joke,sentence],Joke)). %% etc  :-)



seesomething rule bustrans:(
is  replaceall (Nova isa _place, A isa _Movie, nrel/on/_/place/A/Nova, dob/see/I/A/B)
    with       (Nova isa _place, (do)/go/I/B, srel/to/place/Nova/B)
id  []
ip  []).


wonderquery rule bustrans:(
is  replaceall (new,query/I/B/_,I isa _Whatever)
    with       (which(B))
id  []
ip  []).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



standardclock rule bustrans:( %% <-------- %%  FRONTED
is replaceall srel/nil/clock/T/E
   with       srel/nil/time/T/E
id []
ip number(T)).



%%%%%%%%%%%% No srel/nil/clock/T/E  below this line %%


intimeperiodto rule bustrans:(  %%  I tiden 8 til 9 // both numbers
is  replaceall ( srel/in/time/T1/B, srel/to/clock/T2/B)
    with       ( srel/after/time/T1/B, srel/before/time/T2/B),
    not        srel/nil/time/_/B %% når går rute 8 klokken 8 til kl 9  %% Panic
id  []
ip  bound(T1),bound(T2)).


nestsiste rule bustrans:( %% repair %% ( should be taken in grammar)
is  replaceall (adj/_/next/R9/_C,adj/_/last/R9/C) %% adj events are free
    with       (adj/_/second/R9/C,adj/_/last/R9/C)
id  []
ip  []).


nestførste rule bustrans:( %% repair %% ( should be taken in grammar)
is  replaceall (adj/_/next/R9/_C,adj/_/first/R9/C) %% adj events are free
    with       (adj/_/second/R9/C)
id  []
ip  []).

answerin rule bustrans:(
is  replaceall (Norwegian isa language,Answer/tuc/A,srel/ION/_Language/Norwegian/A)
    with       (Norwegian isa language,speak/tuc/Norwegian/A)
id  []
ip  dmeq([tell,answer],Answer),dmeq([in,on],ION),
    Norwegian \== nynorsk). %% :-)

eveningbus rule bustrans:(
is  replaceall (A isa eveningbus)
    with       (A isa bus,  1800 isa clock,nrel/after/bus/time/A/1800)
id  []
ip  []).


eveningroute rule bustrans:(
is replaceall (A isa eveningroute,(do)/go/A/B)
       with   (A isa route,N isa night,(do)/go/A/B,srel/in/time/N/B)
id  []
ip  newfree(N)).

beforebefore rule bustrans:(
is  not present srel/after/time/_/_, %% > 2 clocks
    replaceall  (X isa clock, Y isa clock, srel/nil/time/X/D, srel/nil/time/Y/D)
    with        (X isa clock, Y isa clock, srel/after/time/Low/D, srel/before/time/High/D)
id  []
ip  number(X),number(Y),sorttimes(X,Y,Low,High)).


giveansin rule bustrans:(
is   replaceall (A isa answer, nrel/on/sentence/language/A/L,dob/give/tuc/A/B)
     with       (tell/tuc/B, srel/on/thing/L/B)
id  []
ip  []).


numbergo rule bustrans:( %% går nummer 52 til NTH
is  replaceall (A isa number,(do)/go/A/B)
    with       (A isa bus,(do)/go/A/B)  %%  <- vehicle
id  []
ip  []).   %% need error message if not bound(A),exbus(A).


monthlyfare rule bustrans:(
is  replaceall (adj/_/monthly/X/_,X isa Fare)
    with       (X isa special_ticket)
id  []
ip  dmeq([fare,price],Fare)).

clockhours rule bustrans:(
is  replaceall (S isa hour) %% 1800 hours is ambigous
    with       (S isa clock)
id  []
ip  number(S), S > 48).


flatter0 rule bustrans:( %% har du fått TA på hjernen ? :-)
is  test, tuc isa savant,TA isa person, srel/on/mind/_/E, dob/Have/tuc/TA/E,
    {dmeq([have,get,receive],Have)}
id  add message(onthecontrary),  %% :-)
    add flag(exit)
ip  []).


flatterc rule bustrans:( %% TA-110106
is  new, tuc isa savant,'I' isa self,_ isa compliment
id  add message(thanks)
ip  []).


flatter1 rule bustrans:(
is  new, tuc isa savant,adj/_/Intel/tuc/A,event/real/A, clear
id  add message(thanks)
ip  dmeq([intelligent,smart,good,clever,nice,funny],Intel)). %% TA-101110


flatter2 rule bustrans:(
is  new,  adj/_/best/B/real, dob/be/Bustuc/B/_D, clear
id  add message(thanks),
    add flag(exit)
ip  dmeq([bustuc,tuc],Bustuc)).


flatter3 rule bustrans:( %% TA-101117 bussoraklet er det beste systemet.
is  new, B isa oracle,adj/nil/best/A/real,dob/be/B/A/_, clear
id  add message(thanks),
    add flag(exit)
ip  []).

flatter4 rule bustrans:( %% det er bra at du ... %% TA-110518
is  new,A isa coevent,
    adj/nil/good/A/_,event/A/C,   (do)/be1/tuc/C
id  add message(thanks),
    add flag(exit)
ip  []).



goodjob  rule bustrans:( %% You do a good job
is  new,tuc isa savant,A isa job,do1/tuc/A/_,adj/_/Intel/A/_
id  add message(thanks)
ip  dmeq([intelligent,smart,good,clever],Intel)).


withoutfer rule bustrans:(
is  replaceall (A isa transfer,srel/without/transfer/A/E)
    with (srel/directly/(mode)/nil/E)
id  []
ip  []).


withoutcofer rule bustrans:( %% without coevent B in which change happens
is  replaceall (srel/without/coevent/_/E, dob/change/_/_/E)
    with (srel/directly/(mode)/nil/E)
id  []
ip  []).



hourafter1 rule bustrans:(
is  replaceall ((do)/go/A/C,srel/nil/hour/B/C, B isa hour,nrel/after/duration/clock/B/Time)
    with       ((do)/go/A/C,srel/after/time/Time60/C)
id  []
ip  unbound(B),
    number(Time),
    addtotime(Time,60,Time60)).

hourafter2 rule bustrans:(
is  replaceall ((do)/go/A/C,srel/nil/hour/B/C, B isa hour,nrel/after/duration/clock/B/Time)
    with       ((do)/go/A/C,srel/after/time/Time60/C)
id  []
ip  number(B), Min is B*60,
    number(Time),
    addtotime(Time,Min,Time60)).


graakallen rule bustrans:(  %% Gråkallen syndrom (NOT synbus)
is  replaceall (gråkallbanen isa tram,(do)/go/gråkallbanen/E)
    with       (F isa tram,(do)/go/F/E)
id  []
ip  thetramno(F)). %%  (busdat).

%  longto rule  %% unevokable

walkingdistance rule bustrans:(
is  replaceall (B isa walking_distance,
                nrel/from/distance/place/B/City_syd,srel/in/distance/B/C,event/real/C)
    with       (srel/near/place/City_syd/C,event/real/C)
id  []
ip  []).


teach rule bustrans:(
is  replaceall (Teach/I/A,srel/on/place/D/A)
    with       ((do)/be1/I/A,srel/on/place/D/A)
id  []
ip  dmeq([teach],Teach)).  %% preach, sing,


takenilafter rule bustrans:(%% Repair rule  ,  before inordertobe
is  not present dob/reach/_/_/_,  %% ad hoc
    not nrel/to/vehicle/place/_/_, %% til valentinlyst Hack ?
    not srel/in_order_to/_/_/_, % removed earlier ????

    not srel/so_that/_/_/_,  %% TA-110413   hvis jeg vil være i sentrum kl 20.10?
                 %% TA-100920 +++  når er jeg på heimdal dersom jeg ta buss nummer 9

    not srel/because_of/_/_/_,  % error in gramn
%%%%%%%%%%%    not srel/on/place/_/E,  %% TA-100920  Bloody hack / skal til og VÆRE på
    not srel/to/place/_/E,
    replaceall (dob/take/I/B/E, srel/nil/time/T/E2) %% E2  hack
    with       (dob/take/I/B/E, srel/after/time/T/E2)
id  []
ip  []).


whyareyou rule bustrans:(
is  _ isa meaning,nrel/(with)/meaning/thing/_/Bustuc,
    not _ isa life %%  :-)
id  add message(howtuchelp)
ip  dmeq([bustuc,busstuc,buster,tuc,free(_),it],Bustuc)).

equinox rule bustrans:(
is   Nox isa date,
    {dmeq([vernal_equinox,autumnal_equinox,summer_solstice,winter_solstice],Nox)}
id  add message(mustknow(date)),
    add flag(exit)
ip  []).


haveyoubeenin rule bustrans:(
is  (do)/be1/tuc/E,srel/in/V/_/E
id  add message(thatisimpossible)
ip  unbound(V)). %%  where have yoy been ?

getholdon rule bustrans:(
is  replaceall (A isa hold,nrel/in/hold/vehicle/A/B,dob/receive/I/A/C)
    with       (dob/take/I/B/C)
id  []
ip  []).

tofromjob rule bustrans:(
is  replaceall (C isa job,nrel/on/job/place/C/PS,nrel/From/vehicle/place/B/C)
    with       (nrel/From/vehicle/place/B/PS)
id  []
ip  []).

raskpaa rule bustrans:(
is  replaceall (B isa way,adj/_/Best/B/_,srel/on/way/B/D)
    with       (srel/hereafter/time/nil/D)
id  []
ip  dmeq([fast,best],Best)). %%  etc.


nearestfuture rule bustrans:(
is  replaceall (C isa future, adj/_/next/C/D)
    with       (srel/hereafter/time/nil/D)
id  []
ip  []).

speedy rule bustrans:(
is  replaceall (A isa speed,(do)/go/X/E, srel/nil/speed/A/E)
    with       (A isa duration,(do)/go/X/E,srel/(with)/duration/A/E)
id  []
ip  []).


aftereight rule bustrans:( %% om morgenen etter 8
is  context  C isa morning,
    replaceall (nrel/during2/_Veh2/time/B/C, nrel/after/Veh1/time/B/Eight)
    with       (nrel/after/Veh1/time/B/Eight)
id  []
ip  number(Eight),Eight =< 1200).


beforeeight rule bustrans:(%% Ad hoc rule  when both morning and evening
is  replaceall (srel/in_night/time/nil/E,srel/in/time/A/E,srel/to/clock/Eight/E)
    with       (srel/after/time/Twenty/E,srel/in/time/A/E)
id  []
ip  evening_time(Eight,Twenty)).


untiltime rule bustrans:(
is  replaceall (srel/until/time/N/E) %% \+ coevent
    with       (srel/before/time/N/E)
id  []
ip  []).


isittakeit rule bustrans:(
is  context  A isa duration,
    replaceall ((do)/be1/it/B,srel/nil/time/A/B)
    with       (dob/take/it/A/B)
id  []
ip  []).


answer0 rule bustrans:(   %% hve svarer på spørsmål
is  A isa agent,B isa question,answer1/A/C,srel/on/thing/B/C,event/real/C,
    clear
id  add message(howtuchelp)
ip  []).

answer1 rule bustrans:(   %%  answer1 is strictly intransitive
is  replaceall answer1/X/Y
    with       tell/X/Y
id  []
ip  []).


withroute rule bustrans:(
is  replaceall ( nrel/(with)/vehicle/number/F/H,  H isa Route,F isa Bus)
    with       ( H isa Route,F isa Bus, has/vehicle/number/F/H)
id  []
ip dmeq([number,route],Route), %% number 8 =-= route 8
   dmeq([bus,nightbus,tram,vehicle],Bus),
   bound(H)).


wheredoifind rule bustrans:(
is  replaceall (which(P),P isa place,
                I isa Self,
                find/I/NTH/S, NTH isa Placoid,srel/in/_Thing/P/S)
    with       (which(P),P isa place,
                (do)/be1/NTH/S,    NTH isa Placoid,srel/in/place/P/S),
   {dmeq([person,self],Self)}
id  []
ip  dmeq(place,Placoid)).


isto rule bustrans:(%% Repair rule   %%  Telefon_  TIL  TT
is  replaceall ((do)/be1/A/E, srel/to/_Agent/TT/E,A isa Telephone, TT isa Company)
    with       (TT isa Company,A isa Telephone, has/Company/Telephone/TT/A)
id  []
ip  dmeq([telephone,webaddress],Telephone)).  %% ETC -> busdat


ison rule bustrans:( %% Repair rule  %%  nummer på  bussen
is  replaceall ((do)/be1/A/E, srel/on/_Company/TT/E, A isa Telephone, TT isa Company)
    with       (TT isa Company,A isa Telephone, has/Company/Telephone/TT/A)
id  []
ip  dmeq([telephone],Telephone)).  %% ETC

onlyon rule bustrans:( %% Repair rule  %%  nummer på  bussen
is  replaceall (which(A),srel/on/_Company/TT/_,A isa Telephone, TT isa Company)
    with       (which(A), TT isa Company,A isa Telephone, has/Company/Telephone/TT/A)
id  []
ip  dmeq([telephone],Telephone)).  %% ETC


spectick rule bustrans:(
is  replaceall (B isa ticket,adj/_/special/B/_C)
    with       (B isa special_ticket)
id  []
ip  []).

holi_day rule bustrans:(
is  replaceall (D isa day,adj/_/Holy/D/_E)
    with       (D isa holiday)
id  []
ip  dmeq([holy,red],Holy)).


amorrow rule bustrans:(
is  replaceall (D isa morrow,srel/in/time/D/E)
    with       (srel/tomorrow/day/nil/E)
id  []
ip  []).



be2eliminate  rule bustrans:(  %% HVA ER       drastic
is replaceall  (which(A),dob/be/B/A/_)
     with      (which(B)),
     not  B isa _ %%  only HVA ER
id  []
ip  unbound(A),unbound(B)).


be2repair rule bustrans:( %% before clock is 1800
is  replaceall (dob/be/B/T0/E, srel/in/time/C/E, event/real/E,
                C isa time,B isa clock,
                (do)/go/A/D,srel/Prep/time/C/D,event/real/D)
    with       (T0 isa clock,(do)/go/A/E,srel/Prep/time/T0/E)
id  []
ip  dmeq([before,after,in],Prep)). %% conj  before/after/when


ifclockrepair rule bustrans:( %% if clock is 1800 -> after 1800
is  replaceall (dob/be/A/T800/D, B isa reason,T800 isa clock,A isa CN,
                (do)/go/X/C,srel/because_of/thing/B/D)
    with       (T800 isa clock,(do)/go/X/C,srel/after/time/T800/C),
    {dmeq([number,clock],CN),unbound(A)}
id  []
ip  []).


itimeor rule bustrans:(   %% kl 11 eller 13
is  replaceall
      srel/in/time/(T1100;T1130)/E
    with
      srel/between/time/(T1100,T1130)/E
id  []
ip  []).

nameon rule bustrans:( %% Name on a thing X = the thing X
is  replaceall (dob/list/tuc/A/E,nrel/On/name/_Thing/A/B,A isa name,B isa Bus)
    with       (dob/list/tuc/B/E,B isa Bus)
id  []
ip  dmeq([on,to,of],On)).

nameof rule bustrans:( % subsumed ???
is  replaceall (which(A), nrel/On/name/_Thing/A/T,A isa name)
    with       (which(T))
id  []
ip  dmeq([on,to,of],On)).


smsprice rule bustrans:(
is  adj/_/sms/_/_   ,
    not tmn isa company,
    dob/cost/_B/_A/_C,
    clear %% have their own
id  clear,
    add message(smsprice(NOK1)),
    add flag(exit)
ip  has_att_val(sms,price,tt,NOK1)).


smsrule1 rule bustrans:(
is  adj/_/sms/_/_   ,
    not tmn isa company,
    not dob/cost/_B/_A/_C,
    clear %% have their own
id  clear,
    add(message(smshelp)),
    add flag(exit)
ip  []).

smsrule2 rule bustrans:(  % er du tilgjengelig på sms ?
is  _ isa sms, not tmn isa company,
    not present _ isa price,
    clear %% have their own
id  clear,
    add(message(smshelp)),
    add flag(exit)
ip  []).

smsrule3 rule bustrans:(  %% er du tilgjengelig på mobil ?
is  _ isa mobile, not tmn isa company, not dob/cost/_/_/_,  clear
id  clear,
    add(message(smshelp)),
    add flag(exit)
ip  []).


phonerule1 rule bustrans:(  %% er du tilgjengelig på telefon ?
is  adj/_/available/tuc/B,srel/on/telephone/_/B
id  clear,
    add(message(phonehelp)),
    add flag(exit)
ip  []).


toab rule bustrans:( %% to A and B
is replaceall (srel/TOBY/place/(A,B)/E)
   with       (srel/TOBY/place/A/E,srel/to/place/B/E)
id []
ip dmeq([to,by],TOBY)).  %% NOT between


leavef   rule bustrans:(  %% Leave a station means go FROM station to center
is   replaceall (dob/leave/A/B/C,event/real/C)
     with       ((do)/go/A/C, srel/from/place/B/C)
id   []
ip   []).


ihaveaq rule bustrans:( % I have a question
is  replaceall (new, I isa self, A isa question,
                has/agent/question/I/A, nrel/regarding/information/thing/A/B)
    with       (which(B))
id  []
ip  []).


listover  rule bustrans:(
is replaceall (tuc isa savant,A isa list,nrel/Over/list/thing/A/B,dob/Give/tuc/A/C)
   with       (tuc isa savant,dob/show/tuc/B/C)
id  []
ip  dmeq([give,receive,show,make],Give),
    dmeq([over,with,for,about,regarding],Over)).


depofbus rule bustrans:( %%   before shunt
is  replaceall (which(A),B52 isa bus,A isa departure,nrel/_To/departure/_Bus/A/B52)
    with       (which(A),B52 isa bus,A isa time,(do)/go/B52/B,srel/in/time/A/B,event/real/B)
id  []
ip  []).



% jeg er på risvollansenteret og har et møte i dragvoll.
%%%% ***** => jeg er i dragvoll  og har et møte på risvollansenteret

%%%% fra  Kongsvegen på Heimdal til St. Olavs hospital? -->
%%%% doubleshunt makes on heimdal on par with the other

nildeparture rule bustrans:(
is  replaceall (nrel/nil/departure/place/A/Nth,event/W/E)
    with       ((do)/be1/A/E,srel/from/place/Nth/E,event/W/E)
id  []
ip  []).

nilarrival rule bustrans:(
is  replaceall (nrel/nil/arrival/place/A/Nth,event/W/E)
    with       ((do)/be1/A/E,srel/to/place/Nth/E,event/W/E)
id  []
ip  []).


havemeetingaftertime rule bustrans:(  %% meeting after time means arrival before time
is  replaceall  (has/agent/meeting/I/A, nrel/_On/meeting/place/A/Nth ,srel/_After/time/T/B,event/W/E)
    with        ((do)/arrive/I/E,srel/at/place/Nth/E,srel/before/time/T/B,event/W/E)
id  []
ip  []).


meetingaftertime rule bustrans:(  %% meeting after time means arrival before time
is  replaceall  (nrel/on/meeting/place/A/Nth,event/W/E,srel/_After/time/T/B)
    with        ((do)/be1/A/E,srel/to/place/Nth/E,event/W/E,srel/before/time/T/B)
id  []
ip  []).



meeting01 rule bustrans:(  %% har møte på = skal til
is  A isa meeting,I isa self,
    replaceall (nrel/_/meeting/place/A/Place,has/agent/meeting/I/A, event/W/E)
    with       ((do)/be1/I/E,srel/to/place/Place/E, event/W/E)
id  []
ip  []).


doubleshuntbe1 rule bustrans:(  %% already got one event, and a be1 %% Ugly
is  replaceall  (nrel/From/_/Place/A/Nth,event/W/E,(do)/be1/A/E) %% avoid double
    with        ((do)/be1/A/E,srel/From/Place/Nth/E,event/W/E)
id  []
ip  []).

doubleshunt rule bustrans:(  %% already got one event
is  replaceall  (nrel/From/_/Place/A/Nth,event/W/E)
    with        ((do)/be1/A/E,srel/From/Place/Nth/E,event/W/E)
id  []
ip  []).


%%%%%

apply rule bustrans:( %% hvilket selskap gjelder BT for
is  (do)/apply/_/B,A isa company,srel/for/thing/A/B
id  add message(team),
    add flag(exit)
ip  []).


laststop01 rule bustrans:( % last stop means end station
is  replaceall (A isa stop,adj/_/last/A/_)
    with       (A isa endstation)
id  []
ip  []).


laststop02 rule bustrans:( % last stop means end station
is  replaceall (A isa station,adj/_/last/A/_)
    with       (A isa endstation)
id  []
ip  []).


laststop1 rule bustrans:( % What is the last station for Bus
is  adj/_/last/A/_,A isa station, has/_Vehicle/station/B/A,B isa Bus
id  add endstations(B,_)
ip  bound(B), dmeq(vehicle,Bus)).


laststopfor rule bustrans:( % What is the last station for Bus
is  A isa endstation, (do)/be1/A/E,srel/For/_Vehicle/B/E, {dmeq([for,of],For)},
    B isa Bus,
    clear
id  clear,
    add endstations(B,_),
    add flag(exit)
ip  bound(B), dmeq(vehicle,Bus)).


noinfoaboutvalidity rule bustrans:(
is  adj/_/valid/_/__, not present _ isa time, %% TA-100905
    clear
id  not flag(exit),
    clear,
    addfront(message(noinfoabout(validity)))
ip  []).

noinfoaboutlength rule bustrans:(
is  adj/_/long/_/__,
        not present _ isa time,
        not present _ isa responsetime, %% TA-110111
    clear
id  not flag(exit),
    clear,
    addfront(message(noinfoabout(length)))
ip  []).


noinfoaboutmodificicatons rule bustrans:(
is  dob/Cancel/_/_/_, {dmeq([cancel,modify],Cancel)},
    clear
id  not flag(exit),
    clear,
    addfront(message(noinfoabout(modification)))
ip  []).


amiodd rule bustrans:( %% er jeg rar ? %% TA-110307
is  adj/_/Down/I/_, I isa self,
      {dmeq([bad,incomprehensible,stupid,ugly,wrong],Down)},
    clear
id  not flag(exit),
    clear,
    addfront(message(thatisimpossible))
ip  []).


noinfoabouterror0 rule bustrans:(
is  _ isa Problem,
        {dmeq([headache,problem, error, errormessage, correction , virus ,stability],Problem)},
    clear
id  not flag(exit),
    clear,
    addfront(message(noinfo_error_report))
ip  []).


noinfoabouterrortuc rule bustrans:( %%  .. you are
is  adj/_/Down/tuc/_,
      {dmeq([bad,incomprehensible,stupid,ugly,wrong],Down)},
    clear
id  not flag(exit),
    clear,
    addfront(message(noinfo_error_report))
ip  []).


noinfoabouterror rule bustrans:(
is  adj/_/Down/bustuc/_,
      {dmeq([down,incomprehensible,wrong],Down)},
    clear
id  not flag(exit),
    clear,
    addfront(message(noinfo_error_report))
ip  []).


noinfoabouterror1 rule bustrans:(
is  adj/_/Wrong/_A/E, event/_/E,  %% something IS correct
      {dmeq([bad,incomprehensible,perfect,reliable,wrong],Wrong)}, %%  \+ correct
                                                  %% er det sant at
    clear
id  not flag(exit),
    clear,
    addfront(message(noinfo_error_report))
ip  []).

noinfoabouterror2 rule bustrans:(
is  srel/Wrongly/(mode)/nil/_, {dmeq([badly,wrongly],Wrongly)},
    clear
id  not flag(exit),
    clear,
    addfront(message(noinfo_error_report))
ip  []).


noinfoabouterror3 rule bustrans:(
is  (do)/stop/BT/_ ,{dmeq([tuc,bustuc],BT)},
    clear
id  not flag(exit),
    clear,
    addfront(message(noinfo_error_report))
ip  []).

noinfoabouterror4 rule bustrans:(
is  (do)/Complain/_/_ ,{dmeq([complain],Complain)},
    clear
id  not flag(exit),
    clear,
    addfront(message(noinfo_error_report))
ip  []).

noinfoabouterror5 rule bustrans:( %%  sby stops sthng -> error
is  dob/Stop/_/_BT/_  , {dmeq([fail,modify],Stop)}, %% gi tegn når du skal stoppe bussen p
    clear
id  not flag(exit),
    clear,
    addfront(message(noinfo_error_report))
ip  []).


noinfoaboutgod rule bustrans:( %% fins gud %%
is  (test,A isa god,(do)/exist/A/B,event/real/B) %% TA-110530
id  not flag(exit),
    clear,
    addfront(message(godknows))
ip  []).


noeating rule bustrans:( %% kan jeg spise is på bussen
is  dob/eat/_/_/B,event/real/B
id  not flag(exit),
    clear,
    addfront(message( nofoodonbus)),
    add flag(exit)
ip  []).

%%%% TA-110214 common knowledge silly questions

noneedtoanswer1 rule bustrans:( %% Hvor ligger Trondhein
is  X isa city, present (do)/lie1/X/_,
    clear
id  not flag(exit),
    clear,
    addfront message(noneedtoanswer)
ip  []).



noneedtoanswernoun rule bustrans:( %% TA-110225 common knowledge silly question
is  _ isa King,         %% stupid not to know te answer, not duty
      {dmeq([capital,king,primeminister,president],King)},
    clear
id  not flag(exit),
    clear,
    addfront message(noneedtoanswer)
ip  []).


%%%% this is before  be2yesfact which hides isa
noinfoaboutnoun rule bustrans:( %% no info and TT doesnt know  either
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

    not present adj/_/fast/_/_, %% raskeste vei (OK)
     not present adj/_/best/_/_, %% TA-101026 verdens beste film
    clear
id  not flag(exit),
    clear,
    addfront(message(noinfoabout(Seat)))
ip  []).


noinfoaboutverb1 rule bustrans:( %%
is  (do)/Work/NN/_,
      {dmeq([work],Work)}, {NN \==tuc},
    clear
id  not flag(exit),
    clear,
    addfront(message(noinfoabout(Work)))
ip  []).


be2role0 rule bustrans:( %% is Vestlia endeholdeplass en endeholdeplass ?
is  test,VEH isa station, {bound(VEH)},
    A isa endstation,event/real/B,dob/be/VEH/A/B,
    not (_ isa bus)
id  clear,
    add message(mustknow(bus)),
    add flag(exit)
ip  []).


be2yesfact rule bustrans:( %% is name a class ? %%  er 2 et tall
is  exactly (test, B2 isa _Route,NA isa Number,event/real/E,dob/be/B2/NA/E),
        {bound(B2),unbound(NA)}
id  clear,
    add true,
    add flag(exit)
ip  test(B2 isa Number)).



be2bustucyes rule bustrans:( %% is tuc a class ?
is  exactly (test,dob/be/Tuc/A/B,bustuc isa program,A isa Agent,event/real/B),
              {dmeq([tuc,bustuc],Tuc)}
id  clear,
    add true,
    add flag(exit)
ip  unbound(A),   %% i.e. general
    dmeq([oracle,computer,agent],Agent)). %% etc %% special case

be2bustucno rule bustrans:( %% is tuc a class ?
is  exactly (test,dob/be/Tuc/A/B,bustuc isa program,A isa Agent,event/real/B),
              {dmeq([tuc,bustuc],Tuc)}
id  clear,
    add false,
    add flag(exit)
ip  unbound(A),   %% i.e. general
    \+ dmeq([oracle,computer],Agent)). %% etc %% special case

be2tucyes rule bustrans:( %% is tuc a class ? // already ok semantically
is  exactly (test,dob/be/Tuc/A/B,tuc isa savant,A isa Agent,event/real/B),
              {dmeq([tuc,bustuc],Tuc)},
              {\+ dmeq([thing],Agent)}  %%"er du det" %% TA-110103
id  clear,
    add true,
    add flag(exit)
ip  unbound(A),   %% i.e. general
      %% dmeq([oracle,computer,agent],Agent). %% etc %% special case
      fernando:subclass0(savant,Agent)). %%  er du et system ?

be2tucno rule bustrans:( %% is tuc a class ?
is  exactly (test,dob/be/Tuc/A/B,tuc isa savant,A isa Agent,event/real/B),
              {dmeq([tuc,bustuc],Tuc)},
              {\+ dmeq([thing],Agent)}  %%"er du det" %% TA-110103
id  clear,
    add false,
    add flag(exit)
ip  unbound(A),   %% i.e. general
    \+ dmeq([oracle,computer,program],Agent)). %% etc %% TA-100909


be2noq rule bustrans:( %% er du en jente
is  test,  exactly   (dob/be/Tagore/A/B,Tagore isa Programmer,A isa Agent,event/real/B)
id  clear,
    add false,
    add flag(exit)
ip  unbound(A),   %% i.e. general
    dmeq([tuc,bustuc],Tagore),
    \+ dmeq([self],Programmer), %% er jeg en jente
    \+ fernando:subclass0(Programmer,Agent)).


%%%%    Integrasjon er en løsning *NEI
be2nost rule bustrans:(  %% du er en jente -> OK*
is  new,     (dob/be/Tagore/A/B,Tagore isa _Programmer,
    A isa Agent,event/real/B),
    not present srel/so_that/thing/_/_ %% etc hvis du er en jente
id  clear,
    add false,
    add flag(exit)
ip  unbound(A),   %% i.e. general
    dmeq([tagore,tuc,busstuc],Tagore),  %% En integrering er en  løsning.NEI
    \+ dmeq([agent, %% TA-110314
       savant,programmer,system,program,computer,oracle],Agent)). %%	 etc


equalnameno rule bustrans:( %% = be2name  ??? % Er TUC lik Tagore ?
is  exactly (test, equal/Tuc/Tagore, Tagore isa _Programmer, Tuc isa _Program,event/real/_)
id  add false
ip  \+ (Tuc=Tagore)).


saturdayroute5 rule bustrans:(  %% lørdagsrute 5 = rute 5 på lørdag.
is  replaceall (B52 isa saturdayroute,(do)/go/B52/E)
    with       (B52 isa route,        (do)/go/B52/E,S isa saturday,srel/on/day/S/E)
id  []
ip  newfree(S)).


sundayroute5 rule bustrans:(  %% søndagsrute 5 = rute 5 på lørdag.
is  replaceall (B52 isa sundayroute,(do)/go/B52/E)
    with       (B52 isa route,        (do)/go/B52/E,S isa sunday,srel/on/day/S/E)
id  []
ip  newfree(S)).


workdayroute5 rule bustrans:( %%  hverdagsrute 5 = rute 5 på lørdag.
is  replaceall (B52 isa workdayroute,(do)/go/B52/E)
    with       (B52 isa route,        (do)/go/B52/E,S isa weekday,srel/on/day/S/E)
id  []
ip  newfree(S)).


dobget rule bustrans:(
is  replaceall (dob/get/'I'/Tagore/A,srel/Prep/place/Nth/A) %% I get Tagore to NTH
     with      ((do)/go/Tagore/A,srel/Prep/place/Nth/A),
     {dmeq([to,from],Prep)} %% \+ nil ... hvor før jeg mat %% TA-100909
id   []
ip   []).



shunt rule bustrans:(
is  replaceall  (nrel/From/_/Place/A/Nth)
    with        ((do)/be1/A/E,
                event/real/E,
                srel/From/Place/Nth/E)
id  []
ip  newfree(E)).


daymorning rule bustrans:( %% søndag morgen -> søndag om morgenen
is  replaceall (B isa morning,srel/nil/day/C/D,srel/nil/daypart/B/D)
    with (B isa morning,      srel/nil/day/C/D,srel/in/time/B/D,event/real/D)
id  []
ip  []).

hasstat0 rule bustrans:( %% Havstads holdeplass
is  replaceall (srel/To/place/B/A,  has/place/station/H/B, B isa station)
 %% NB Important that srel/To/place/B/A comes first,
 %% to	 preserve seq!
    with       (srel/To/place/H/A)
id  []
ip  unbound(B)).


srelbetweentime rule bustrans:(  %%   fra 09.15 - 09.45"
is  replaceall (srel/after/time/T1/A,srel/nil/time/T2/A)
    with       (srel/after/time/T1/A,srel/before/time/T2/A),
    {bound(T1),bound(T2)} %% avoid after sunday nil clock
id  []
ip  []).


gonilfrom rule bustrans:( %%  etter lørdag kl 1234.
is  not (do)/be1/_/_,
    not present  srel/around/time/_/_ , %% confuse
    not srel/to/place/_/_,
    replaceall (srel/nil/time/Six/B, srel/from/place/Stat/B)
    with       (srel/after/time/Six/B,srel/from/place/Stat/B)
id  []
ip  number(Six)).


best rule bustrans:(  % hvilken buss er best til ...
is  replaceall adj/_/Best/X/E %% best til NTH = er til nth
    with       (do)/be1/X/E,
    present X isa Veh, { dmeq(vehicle,Veh)},
    not present has/_/_/_/X, %% have a good night
    not present (do)/exist/X/_,  %% technical
    { dmeq([good,best],Best)}
id  []
ip  unbound(X)).     %% Are you good SIC



runisrun rule bustrans:( %% noen  kjøre rutene = rutene kjører
is  replaceall (A isa route,B isa agent,dob/run/B/A/C,event/real/C)
    with       (A isa route,run/A/B,event/real/B)
id  []
ip  []).


named_date rule bustrans:(  %% also translation in grammar
is   not YYYY isa year when { ( number(YYYY),\+ this_year(YYYY))},
      not  adj/_/first/_/_, %% 1. julaften (should have been  absorbed)
     replaceall  (CE  isa date, srel/Prep/date/CE/E)
      with    (D24 isa date, srel/Prep/date/D24/E),
     {  atom(CE)} %% christmas_eve
id   []
ip   named_date(CE,D24)).



invaliddate rule bustrans:( %% reject invalid date
is   X isa date,
     {bound(X), X= date(_,_,_)},
     clear
id   clear,
     add message(illegaldate),
     add flag(exit)
ip   \+ valid_date( X )).

%%%%------------------------ NO nrel below this line ------------------------------

hello rule bustrans:(
is  (do),hello
id	 add message(start)
ip	 []).

quit rule bustrans:(
is  (do),quit,
    clear
id	 clear,
    add message(quit),
    add flag(exit)
ip	 []).


qmess rule bustrans:(
is  (do),quit(Mess),
    clear
id	 clear,
    add message(quit(Mess)),
    add flag(exit)
ip	 []).


mondaynight  rule bustrans:( %% Repair / Standardize mandag(s) kveld -> mandag om kvelden.
is  replaceall (N  isa night,srel/on/daypart/N /E,has/day/night/D /N )
    with (N isa night, srel/on/day/D/E,srel/in/time/N /E)
id  []
ip  []).


tomorrownight rule bustrans:( %%  Repair / Standardize i morgen kveld -> i morgen om kvelden
is  replaceall (B isa night,srel/tomorrow/day/nil/A,srel/nil/daypart/B/A)
    with (B isa night, C isa morrow,srel/in/time/C/A, srel/in/time/B/A)
id  []
ip  newfree(C)).

%%%% MEETING SECTION

meeting rule bustrans:( %% meeting on a place = to place
is  replaceall (A isa meeting,nrel/on/meeting/place/A/X,srel/_Prep/meeting/A/C)
    with       (srel/to/place/X/C)
	           %% not on/place = liveinhell ->"from place"
id  []
ip  []).


meetingbetween rule bustrans:( %%  Møte mellom 2 og 3 = møte kl 2
is  replaceall (A isa meeting,T2 isa clock,(do)/be1/A/E,srel/between/time/(T1,T2)/E)
    with       (A isa meeting,(do)/be1/A/E,srel/at/time/T1/E)
id  []
ip  []).


havemeeting1 rule bustrans:( % I have a meeting at P
is  not (do)/go/'I'/_,
    not (do)/be1/'I'/_,
    replaceall (A isa meeting,has/agent/meeting/'I'/A, srel/OnAt/place/P/B)
    with       ((do)/go/'I'/B, srel/to/place/P/B)
id  []
ip  dmeq([on,at],OnAt)).


%%%% Presume   lecture -> meeting om beforehand
meeting1 rule bustrans:( %% Moved after shunt
is  replaceall (_ isa meeting, srel/OnAt/place/P/_, (do)/Go/'I'/E)
    with       ((do)/go/'I'/E, srel/to/place/P/E)
id  []
ip  dmeq([on,at],OnAt), %% NOT FROM!
    dmeq([go,run],Go)).

meeting2 rule bustrans:(
is  replaceall ( dob/Reach/'I'/M/E, M isa Meeting, srel/OnAt/place/P/_)
    with       ( (do)/go/'I'/E, srel/to/place/P/E),
            {dmeq([reach,pass],Reach)},
            {dmeq([on,at],OnAt)},
            {dmeq([meeting,movie,lecture],Meeting)}
id  []
ip  []).


%%%% END MEETING SECTION


%%%% Weather (fronted) %% weather in oslo #-> no weather (\+ not oslo)

weather01 rule bustrans:(  %  it rains
is  (do)/rain/_/_
id	 addcon  message(noinfoabout(weather)),
    add flag(exit)
ip	 []).

weather02 rule bustrans:(  % it snows
is  (do)/snow/_/_
id	 addcon  message(noinfoabout(weather)),
    add flag(exit)
ip	 []).


weather1 rule bustrans:(  %  Weather
is  adj/_/Cold/_/_
id	 addcon  message(noinfoabout(weather)),  %%  varmt vær
    add flag(exit)
ip	 dmeq([cold,hot,wet,icy],Cold)).

weather2 rule bustrans:(  %  Weather
is  _ isa rain
id	 addcon message(noinfoabout(weather)),
    add flag(exit)
ip	 []).

weather2sky rule bustrans:(  %  er himmelen blå
is  _ isa sky
id	 addcon message(noinfoabout(weather)),
    add flag(exit)
ip	 []).

weather3 rule bustrans:(  %  ice Weather
is  _ isa ice
id	 addcon message(noinfoabout(weather)),
    add flag(exit)
ip	 []).

weather4 rule bustrans:(  %  Weather
is  _ isa snow
id	 addcon message(noinfoabout(weather)),
    add flag(exit)
ip	 []).

weather5 rule bustrans:( %  Weather
is  _ isa sun
id	 addcon message(noinfoabout(weather)),
    add flag(exit)
ip	 []).

weather6 rule bustrans:( %  Weather // er sola varm
is  _ isa temperature
id	 add message(noinfoabout(weather)),
    add flag(exit)
ip	 []).




warning_sentence  rule bustrans:( %% warning + sentence
is  []
id  addcon flag(warningflag)
ip  value(warning_sentence,true), %%  reset by process
 \+ value(warningflag,true),
    set(warningflag,true)).

warning_sentence_nosms  rule bustrans:( %% warning + sentence,nosms -> cannot
is  []
id  flag(warningflag) ,
    not message(sorrycannot),
    add  message(sorrycannot)
ip  \+ value(smsflag,true)).


warningflag1 rule bustrans:( %%  a warning => set warningflag
is   _ isa notification
id  addcon flag(warningflag)
ip  \+ value(warningflag,true),
      set(warningflag,true)).


warningflag2 rule bustrans:( %% varsler meg at /om/når
is  dob/notify/_/A/_, A isa coevent       %% do notify coevent <--
id  addcon flag(warningflag)
ip  \+ value(warningflag,true),
      set(warningflag,true)).


warningflag3 rule bustrans:( %% notify   du varsler []
is  context (do)/notify/_/_     %% do notify duration
id  addcon flag(warningflag)
ip  \+ value(warningflag,true),
      set(warningflag,true)).


warningflag4 rule bustrans:( %% set warningflag
is  context dob/notify/_/_/_
id  addcon flag(warningflag)
ip  \+ value(warningflag,true),
      set(warningflag,true)).



hourswarningadhoc rule bustrans:( %% trans %% Horrendous Hack
is  replaceall ( N isa hour,      dob/notify/T/N/E)
    with       ( N60 isa minute,  dob/notify/T/N60/E)
id  []
ip  value(warningflag,true),
    number(N), N =< 24,  %%  ass. no change of date
    N60 is N*60 ).


prewarning0before  rule bustrans:( %% send notification Ten min. before first departure
is  send/tuc/N/E, present N isa notification,
    Ten isa minute,
    srel/nil/duration/Ten/E,
    srel/before/vehicle/_/E
id  []
ip  value(warningflag,true),
    set(prewarningtime,Ten)).


%%%% NN  prewarning rule bustrans:(s   with intransitive notify !!!!!

prewarningminbefore  rule bustrans:(
is  (do)/notify/tuc/E, srel/nil/duration/Ten/E,
    Ten isa minute,
    CE isa coevent,
    srel/before/coevent/CE/E,
    event/real/E
id  []
ip  value(warningflag,true),
    set(prewarningtime,Ten)).



%%%% NN  prewarning rule bustrans:(s  all with transitive notify !!!!!

prewarning1before  rule bustrans:( %% warning time before first departure
is  present dob/notify/_Tuc/_/E,
    Ten isa minute,
    srel/nil/duration/Ten/E,
    srel/before/_Coveh/_/E %% vehicle/coevent %% TA-110201
id  []
ip  value(warningflag,true),
    set(prewarningtime,Ten)).


prewarning1after  rule bustrans:( %% warning time after first departure
is  present dob/notify/_Tuc/_/E,
    Ten isa minute,
    srel/nil/duration/Ten/E,
    srel/after/vehicle/_/E
id  []
ip  Tenafter is - Ten,
    value(warningflag,true),
    set(prewarningtime,Tenafter)).


prewarning2before  rule bustrans:( %% warning time before first departure
is  present dob/notify/_Tuc/Ten/_, %% TUC or agent(passive)
    Ten isa minute
id  []
ip  value(warningflag,true),
    set(prewarningtime,Ten)).

prewarning2after  rule bustrans:( %% warning time after first departure
is  present dob/notify/_Tuc/Ten/_, %% TUC or agenet(passive)
    Ten isa minute
id  []
ip  Tenafter is - Ten,
    value(warningflag,true),
    set(prewarningtime,Tenafter)).


prewarning3before  rule bustrans:( %% warning time before first departure
is  replaceall (Ten isa minute, B isa time,srel/nil/duration/Ten/C, srel/before/time/B/C)
    with       (B isa time)
id  []
ip  value(warningflag,true),
    set(prewarningtime,Ten)).

prewarning3after  rule bustrans:( %% warning time after first departure
is  replaceall (Ten isa minute, B isa time,srel/nil/duration/Ten/C, srel/after/time/B/C)
    with       (B isa time)
id  []
ip  Tenafter is - Ten,
    value(warningflag,true),
    set(prewarningtime,Tenafter)).


prewarning4before  rule bustrans:( %% warning time before first departure
is  replaceall (F66 isa departure, Ten isa minute, (do)/be1/Ten/F69,srel/before/departure/F66/F69)
    with       (F66 isa departure)
id  []
ip  value(warningflag,true),
    set(prewarningtime,Ten)).


prewarning4after  rule bustrans:( %% warning time after first departure
is  replaceall (F66 isa departure, Ten isa minute, (do)/be1/Ten/F69,srel/after/departure/F66/F69)
    with       (F66 isa departure)
id  []
ip  Tenafter is - Ten,
    value(warningflag,true),
    set(prewarningtime,Tenafter)).



starttogo rule bustrans:( %%  start to go = go early
is replaceall (Bus9 isa bus,B isa reason,A isa time,
              (do)/start/Bus9/C,srel/in_order_to/thing/B/C,srel/in/time/A/D,
              (do)/go/Bus9/D,event/_R/D)
   with       (Bus9 isa bus,(do)/go/Bus9/D,A isa time,srel/in/time/A/D, srel/early/time/nil/D,event/real/D)
id  []
ip  []).

startandgo rule bustrans:( %%  start and go = go early
is  replaceall (Bus9 isa bus,(do)/start/Bus9/C,(do)/go/Bus9/C, A isa time,srel/in/time/A/C,event/real/C)
    with       (Bus9 isa bus,(do)/go/Bus9/C, A isa time,srel/in/time/A/C,srel/early/time/nil/C,event/real/C)
id  []
ip  []).

startinatend rule bustrans:( %% hvor starter buss 9 = end stations
is  replaceall ((do)/start/X/E,srel/In/place/P/E, P isa place)
    with       (has/vehicle/endstation/X/P,  P isa endstation)
id  []
ip  dmeq([in,at,from],In)).


startinat rule bustrans:( %%  start in/at = go from
is  replaceall ((do)/start/X/E,srel/In/place/P/E)
    with       ((do)/go/X/E,srel/from/place/P/E),
               {dmeq([in,at,from,on],In)}
id  []
ip  []).


entergo rule bustrans:( %% tre ( i kraft) %% TA-101108
is  not X isa meeting,
    replaceall ((do)/enter/X/E)
    with       ((do)/go/X/E)
id  []
ip  []).

startgo rule bustrans:( %% otherwise  start = go
is  not X isa meeting,
    replaceall ((do)/start/X/E)
    with       ((do)/go/X/E)
id  []
ip  []).

startmeeting  rule bustrans:( %% otherwise  start = go
is   X isa meeting, %% Ad Hoc
    replaceall ((do)/start/X/E,srel/nil/_Time/KL/E,(do)/go/I/F)
    with       ((do)/go/I/F,srel/before/time/KL/E)
id  []
ip  []).


gotoxandbeinx1 rule bustrans:( % before tofromsameplace
is  replaceall ((do)/go/I/A87, srel/to/place/Sentrum/A98, (do)/be1/I/A98,srel/in/place/Sentrum/_A88)
    with       ((do)/go/I/A87 ,srel/to/place/Sentrum/A87)
id  []
ip  []).


gotoxandbeinx2 rule bustrans:( % go to and be in X
is  replaceall ((do)/go/I/F59, srel/to/place/Sentrum/F59, srel/in/place/Sentrum/_F60)
    with       ((do)/go/I/F59 ,srel/to/place/Sentrum/F59)
id  []
ip  []).

%%%% Nostation section (before tofromsameplace)


itemrulesingle rule bustrans:( % an item %% Fronted
is  item, _C isa _Class , clear% discard Class
id  clear,
    add   message(completesentence)
ip  [])  %% \+ testmember(Class,[nightbus,tram])
 :-single.


whichdaysbetween rule bustrans:( %% TA-110411
is  which(A),A isa day,(do)/exist/A/_,
    Date1 isa date, Date2 isa date, {bound(Date1), bound(Date2)},
    srel/after/time/Date1/_,
    srel/before/time/Date2/_
id  add message(numberof(N,day)),
    add flag(exit)
ip  days_between(Date1,Date2,N)).


whichdaystospecialdate rule bustrans:(   %% :-) Arvid Holme
is  which(A),A isa day,(do)/exist/A/B,
    present Arvid_holme_day isa date,
    srel/To/time/Arvid_holme_day/B,event/real/B,
           {dmeq([to,until,before],To)}
id  add message(numberof(N,day)),
    add flag(exit)
ip  named_date(Arvid_holme_day,DATE),
    todaysdate(TODAY),
    days_between(TODAY,DATE,N)).


whichdaystoanydate rule bustrans:(
is  which(A),A isa day,(do)/exist/A/B,
    present ANYDATE isa date,
    srel/To/time/ANYDATE/B,event/real/B,
           {dmeq([to,until,before],To)}
id  add message(numberof(N,day)),
    add flag(exit)
ip  todaysdate(TODAY),
    days_between(TODAY,ANYDATE,N)).


howmanydaystonameddate rule bustrans:(
is  howmany(A),Arvid_holme_day isa date,A isa day,(do)/exist/A/B,
           srel/To/time/Arvid_holme_day/B,event/real/B,
           {dmeq([to,until,before],To)}
id  add message(numberof(N,day))
ip  named_date(Arvid_holme_day,DATE), %% :-) %[].
    todaysdate(TODAY),
    days_between(TODAY,DATE,N) ).


worldend  rule bustrans:( %% TA-110608 when will the wold end :-(
is B isa world,A isa time,(do)/End/B/C,srel/in/time/A/C,event/real/C,
    {dmeq([end,stop],End)}
id  add message(date_isa_day(Date,Day))
ip  named_date(dooms_day,Date),xweekday(Date,Day)). %% TA-110609


goffwithpension  rule bustrans:(
is  replaceall
         ((do)/go/Tagore/C,srel/off/_Veh_sic_/nil/C,srel/(with)/pension/B/C,B isa pension)
    with ((do)/retire/Tagore/C)
id  []
ip  []).

daysuntilretireta0 rule bustrans:(
is  howmany(A), A isa day,
    (do)/retire/Tagore/F5,
    (do)/exist/A/F4,srel/Until/time/F3/F4,event/real/F5,
    {dmeq([until,to,before],Until)},
    srel/in/time/F3/F5
id  add message(numberof(N,day))
ip  has_att_val(person,retirement,Tagore,DATE),
    todaysdate(TODAY),
    days_between(TODAY,DATE,N)).


daysuntilretireah rule bustrans:(
is  %%%% howmany(A), | which(A)
    (do)/Retire/Arvid_holme/C, {dmeq([retire,end],Retire)},
    Arvid_holme isa _Man,A isa day,B isa coevent,event/B/C,(do)/exist/A/D,srel/Until/coevent/B/D,event/real/D,
    {dmeq([until,to,before],Until)}
id  add message(numberof(N,day))
ip  has_att_val(person,retirement,Arvid_holme,DATE),
    todaysdate(TODAY),
    days_between(TODAY,DATE,N)).

dayssinceretireah rule bustrans:( %% TA-110215
is  (do)/Retire/Arvid_holme/C, {dmeq([retire,end],Retire)},
    Arvid_holme isa _Man,A isa day,B isa coevent,event/B/C,(do)/exist/A/D,srel/Since/__coevent/B/D,event/real/D,
    {dmeq([since],Since)}
id  add message(numberof(N,day))
ip  has_att_val(person,retirement,Arvid_holme,DATE),
    todaysdate(TODAY),
    days_between(DATE,TODAY,N)). %% NB seq 2 1

daysuntilretireta rule bustrans:(
is  howmany(A),
    (do)/retire/Tagore/D,
    A isa day,B isa coevent,event/B/D,
    (do)/exist/A/E,srel/Until/coevent/B/E,event/real/E,
    {dmeq([until,to,before],Until)}
id  add message(numberof(N,day))
ip  has_att_val(person,retirement,Tagore,DATE),
    todaysdate(TODAY),
    days_between(TODAY,DATE,N)).


retire rule bustrans:(
is  do/Retire/Arvid_holme/_, { dmeq([retire,end],Retire) },
    Arvid_holme isa Man ,{dmeq(trafficant,Man)} %%  i.e. << agent
id  add message(date_isa_day(DATE,Monday)),
    add flag(exit)
ip  has_att_val(person,retirement,Arvid_holme,DATE),
    weekday(DATE,Monday)) .

howlongtoadate1  rule bustrans:(
is  which(A),DATE isa date,A isa duration,
    do/exist/A/B,srel/Before/time/DATE/B,
    {dmeq([before,to],Before)} %% TA-100828
id  add message(numberof(N,day))
ip  todaysdate(TODAY),
    days_between(TODAY,DATE,N) ).

howlongsincedate1  rule bustrans:(
is  which(A),DATE isa date,A isa duration,(do)/exist/A/B,srel/Since/_/DATE/B,
    {dmeq([since,after],Since)}
id  add message(numberof(N,day))
ip  todaysdate(TODAY),
    days_between(DATE,TODAY,N) ).


howmanydayssinceadate rule bustrans:(
is  howmany(A),DATE isa date,A isa day,(do)/exist/A/B,srel/Since/_/DATE/B,event/real/B,
        {dmeq([since,after],Since)}
id  add message(numberof(N,day))
ip  todaysdate(TODATE),
    days_between(DATE,TODATE,N) ).


howmanydaystoadate rule bustrans:(
is  howmany(A),DATE isa date,A isa day,(do)/exist/A/B,srel/To/_/DATE/B,event/real/B,
        {dmeq([to,until,before],To)}
id  add message(numberof(N,day))
ip  todaysdate(TODATE),
    days_between(TODATE,DATE,N) ).


howmany99 rule bustrans:(   %% How many ---> which %%  Fronted
is  replaceall howmany(A)
    with       which(A),
    not present _ isa question, %% TA-101215
    not srel/nil/week/_/_
id  []
%%    add message(cannotanswer) // Unnecessary
ip  [] ).


nostation00 rule bustrans:( % bus from an ocean to nth. It is a ridiculous place
is  present srel/_/place/B/_, B isa Ocean,clear
id  addcon message(foreign(Ocean))
ip  dmeq([sky,ocean,sea,su,moon],Ocean) ). %% ridiculous place subclasses


nostation1 rule bustrans:(
is  X isa station,  { bound(X) },
    clear
id  clear,
    addcon message( noroutesto(X) )
ip  nostationfor(X) ).

nostation2 rule bustrans:(
is  X isa neighbourhood, { bound(X) },
    clear
id  clear,
    addcon message(noroutesto(X))
ip  placestat(X,Y),nostationfor(Y) ).


nostationstreet rule bustrans:(
is  X isa street, { bound(X)},
    clear
id  clear,
    addcon message(noroutesto(X))
ip  street_station(X,Y),
    nostationfor(Y),   %% adm_rit
    \+ placestat(X,_) ).


nostationx rule bustrans:( %% outside T ( meaning not at T)
is  Trondheim isa city,
    srel/outside/place/Trondheim/_,
    clear
id  clear,
    addcon message(foreign(nil))
ip  [] ).


 % %



isversion0 rule bustrans:(
is  _ isa version,
    clear
id  clear,
    add ( message(answer(db_reply(tuc,version,K))),
          flag(exit))
ip  has_att_val(system,version,tuc,K) ).

routeisupdated0 rule bustrans:(  %% when were routes updated
is  update/_B/X/_,
    X isa Route,      {dmeq([route],Route)}, %%
    clear
id  buslog:atdate2(DaySeqNo,Date),
    clear,
    add  message(route_period( tt, RP,Date1,_date2))
ip  decide_period(Date,RP),
    route_period( tt, RP,Date1,_date2),
    dayModSeqNo(Date,DaySeqNo) ).

tucisupdated1 rule bustrans:(  %% when were you updated
is  dob/update/_B/R/_,
    R isa OP,      {dmeq([program,oracle,code,savant],OP)}, %% oracle oppdatert
    clear
id  clear,
    add  message(answer(db_reply(tuc,version,K)))
ip  has_att_val(system,version,tuc,K) ).


tucisupdated2 rule bustrans:(  %% when were you updated
is  adj/_/updated/R/_,
    R isa OP,      {dmeq([program,oracle,code,savant],OP)}, %% oracle oppdatert
    clear
id  clear,
    add  message(answer(db_reply(tuc,version,K)))
ip  has_att_val(system,version,tuc,K) ).


%%%% WANNA SECTION BEFORE nilclocksequence

wannagoto0 rule bustrans:( %% Dirty repair
is  context    (I isa self,NTH isa Station1, Dragvoll isa Station2, event/real/E),
    replaceall ((do)/be1/I/E,srel/On/place/NTH/E,(do)/go/I/E,srel/ONTO/place/Dragvoll/E)
    with       ((do)/go/I/E,srel/from/place/NTH/E,srel/to/place/Dragvoll/E)
id  []
ip  (NTH \== Dragvoll),
    dmeq(place,Station1),dmeq(place,Station2),dmeq(onto,ONTO),
    dmeq([on,at,in],On) ).


wannabeon1 rule bustrans:(
is  not present srel/to/place/_/_,
    not present (do)/live/_/_,
    context (srel/From/place/NTH/C, NTH isa Station1,Dragvoll isa Station2, event/real/C),
    {dmeq([from,past],From)},
    {NTH \== Dragvoll},
    replaceall (srel/OTAN/place/Dragvoll/E,(do)/Be1/'I'/E) %% I -> 'I'
    with       ((do)/go/'I'/E,srel/to/place/Dragvoll/E)
          %%  hvilken av bussholdeplassene (som er)  på studentersamfunnet...
id  []
ip  dmeq([be1,work,go],Be1), %% (work is destination)
    dmeq(nato,OTAN),dmeq(place,Station1),dmeq(place,Station2) ).


wannabeon2 rule bustrans:(
is  context (I isa self,NTH isa Station1,Dragvoll isa Station2),
    replaceall ( want/(id)/that/I/B/C,event/real/C,(do)/be1/I/D,event/B/D,
                 srel/OTAN/place/Dragvoll/D)       % ,srel/from/place/NTH/D)
    with       ((do)/go/I/D,event/real/D,srel/to/place/Dragvoll/D) %,srel/from/place/NTH/D)
id  []
ip  ( NTH \== Dragvoll), dmeq(nato,OTAN),dmeq(place,Station1),dmeq(place,Station2) ).


wannabeon3 rule bustrans:(
is  context (I isa self,NTH isa Station),
    replaceall (want/(id)/that/I/B/C,event/real/C,(do)/be1/I/D,srel/OTAN/place/NTH/D,event/B/D)
    with       ((do)/go/I/D,event/real/D,srel/to/place/NTH/D)
id  []
ip  dmeq(nato,OTAN),dmeq(place,Station) ).


wannabefore1 rule bustrans:( %% I am on X and wanna be on Y %% fails on i wanna be on Y and I am on Y
is  context (I isa self),
    replaceall ((do)/be1/I/D,event/real/D,srel/OTAN1/place/NTH/D,srel/OTAN2/place/Moholt/D,
              srel/NILB/TIME/T/D)
    with       ((do)/go/I/D, event/real/D,srel/from/place/NTH/D,srel/to/place/Moholt/D,
               srel/before/time/T/D)
id  []
ip  dmeq(nato,OTAN1),dmeq(nato,OTAN2), % dmeq(place,Station),
    dmeq(beforenil,NILB),dmeq(time,TIME) ).


wannabefore2 rule bustrans:( %% i wanna be on
is  context (I isa self),
    not srel/to/place/_/_,
    replaceall ((do)/be1/I/D,event/real/D,srel/OTAN/place/NTH/D,NTH isa Station,srel/NILB/TIME/T/D)
    with       ((do)/go/I/D, event/real/D,srel/to/place/NTH/D,NTH isa Station,srel/before/time/T/D)
id  []
ip  dmeq(nato,OTAN),dmeq(place,Station),
    dmeq(beforenil,NILB),dmeq(time,TIME) ).



beonbeforeeqto rule bustrans:(  %% buss er på  Gløshaugen før 1900
is  not present (do)/meetup/'I'/_, %% only about buss arrive
    not present (do)/live/_/_, %% I live on Nidarvoll
    not present (do)/stop/_/_,
    present srel/Before/time/_1900/_B,
              {dmeq([before,nil],Before)},
                       %% jeg er på nidarvoll ... før kl 18
    replaceall ((do)/be1/B/E, srel/ION/place/NTH/E)
    with       ((do)/go/B/E,  srel/to/place/NTH/E),
          {dmeq([in,on],ION)}
id []
ip [] ).


comefromhell rule bustrans:( %% er på holdeplassen på gløs -> fra gløs
is   free(X20) isa station,
     replaceall ((do)/be1/free(X20)/free(X21),
                 srel/on/_Neighbourhood/Gløs/free(X21),
                 (do)/_Bego/'I'/free(X22),
                 srel/on/place/free(X20)/free(X22))
     with
                ((do)/go/'I'/free(X22),srel/from/place/Gløs/free(X22))
id  []
ip  [] ).


beon1 rule bustrans:(  %% I am on A ( but not  skal være på!)
is  context B isa self, %% Jeg er på Gløshaugen
    not present which(_), %% .. hvor er jeg
    not present test,     %% .. er jeg på ...
    replaceall ((do)/be1/B/E, srel/Prep/place/NTH/E)
    with       ((do)/go/B/E,  srel/from/place/NTH/E)
id []
ip \+ dmeq([to],Prep) ).

% END WANNA SECTION %%%

%%%% Fronted. avoid nil -> before
afterdayat rule bustrans:( %% after Thursday at 1800 MEANS  on Thursday after 1800
is replaceall (srel/after/time/B/C, B isa Thursday,srel/ATTIME/time/T1800/C)
   with       (srel/after/time/T1800/C, B isa Thursday,srel/on/time/B/C)
id []
ip dmeq(attime,ATTIME),dmeq(mtwtfss,Thursday) ).

%%%% Fronted. avoid nil -> before
beforedayat rule bustrans:( %% before Thursday at 1800 MEANS  on Thursday before 1800
is replaceall (srel/before/time/B/C, B isa Thursday,srel/ATTIME/time/T1800/C)
   with       (srel/before/time/T1800/C, B isa Thursday,srel/on/time/B/C)
id []
ip dmeq(attime,ATTIME),dmeq(mtwtfss,Thursday) ).



% BEGIN NILCLOCK SECTION %%%%%%%%%%

%%%% clock = nil time
%%%% nil   = nil place
%%%% prep  = prep place

%%%%% .. and .. sequence rules come early because other rule bustrans:(s may change
%%%%% strict sequence

nilclocktoclock rule bustrans:(  %% til nth 0700 til 0800
is replaceall (srel/nil/clock/T700/E,srel/to/clock/T800/E)
   with       (srel/after/time/T700/E,srel/before/time/T800/E)
id  []
ip  [] ).

nilnilclocksequence  rule bustrans:( %% buran  torget  2030 = before  2030
is  context   Time isa clock, {bound(Time)},
    srel/nil/place/_P/E and  srel/nil/place/_Q/E and  srel/nil/time/Time/E, %% IN  INDIRECT SEQUENCE
    replace srel/nil/time/K/E  with  srel/before/time/K/E
id  []
ip  [] ).

nilplacetoplacenilclocksequence  rule bustrans:( %% berg studentby til moholt kl 2030 .
is  context   Time isa clock, {bound(Time)},  %% TA-101020
    srel/nil/place/_P/E and  srel/to/place/_Q/E and  srel/nil/time/Time/E,
    replace srel/nil/time/K/E  with  srel/before/time/K/E
id  []
ip  [] ).


clocknilnilsequence  rule bustrans:( %% 2030  buran  torget = after 2030
is  context   Time isa clock, {bound(Time)},
    srel/nil/P/Time/E and srel/nil/place/_P/E and  srel/nil/place/_Q/E,  %% IN  INDIRECT SEQUENCE
    replace srel/nil/P/K/E  with
            srel/after/time/K/E
id  []
ip  [] ).

nilclocknilsequence  rule bustrans:( %%  buran  2030 torget = after 2030
is  context   Time isa clock, {bound(Time)},
    srel/nil/place/_P/E and srel/nil/P/Time/E and  srel/nil/place/_Q/E,  %% IN  INDIRECT SEQUENCE
    replace srel/nil/P/K/E  with
            srel/after/time/K/E
id  []
ip  [] ).


%%%%  Sentrum  til Coop mega . // Mega comes first

nilnilsequence  rule bustrans:( % go A B
is  not srel/to/place/_Dalen/_, %% bakkegata til Dalen hagene  %% TA-110322
    replaceall (srel/nil/PlaceT1/Place1/E,  srel/nil/PlaceT2/Place2/E)
    with       (srel/from/place/Place1/E, srel/to/place/Place2/E),
    {bound(Place1),bound(Place2), Place1 \== Place2}
id  []
ip  dmeq([neighbourhood,station,place,city],PlaceT1),
    dmeq([neighbourhood,station,place,city],PlaceT2) ).



%%%% PROBLEM

nilplacenilclocktoeqafter   rule bustrans:( %%  arne bergsgårdsvei kl.22.30 til sentrum %% TA-101019
is  context   Time isa clock,
    replaceall (srel/nil/place/ABV/E2,srel/AT/time/Time/E2, srel/to/place/Sentrum/E2)
    with       (srel/nil/place/ABV/E2,srel/to/place/Sentrum/E2,srel/after/time/Time/E2),
    not (do)/meetup/'I'/E2
id  []
ip  dmeq(attime,AT) ).


nilclocktoeqbefore   rule bustrans:( %%  Trondheim sentrum til tunga 6.30 %% TA-101019
is  context   Time isa clock,
    replaceall (srel/nil/place/ABV/E2, srel/to/place/Sentrum/E2,srel/AT/time/Time/E2)
    with       (srel/nil/place/ABV/E2,srel/to/place/Sentrum/E2,srel/before/time/Time/E2),
    not (do)/meetup/'I'/E2
id  []
ip  dmeq(attime,AT) ).

%%%%%%%%%



tofromclocksequence  rule bustrans:( %% til risvollansenteret fra gløshaugen syd 945.
is  not present srel/before/_/_/_, %% TA-110225 e.g. activity/coevent
    not present srel/in_order_to/_/_/_,
    not present srel/so_that/_/_/_,
    not present srel/because_of/thing/_/_, %% error in gram_n
    srel/to/place/_P/E and srel/from/place/_Q/E and srel/nil/time/K/E, %% IN  INDIRECT SEQUENCE
    replace srel/nil/time/K/E  with   srel/after/time/K/E
id  []
ip  [] ).


toclocksequence1  rule bustrans:( %% to A 12:34 //  til vikåsen fra samfundet 1600 .OBS!!! feil
is  present K isa clock,
    not present _ isa departure, %% then time is dep time
    not present (_ isa minute), %% go to Torget 12 minutes
    srel/To/place/_P/E and srel/nil/time/K/E, %% IN  INDIRECT SEQUENCE
    { dmeq([to,on],To) }, %% skal være på ...
    replace srel/nil/time/K/E  with      srel/before/time/K/E
id  not flag(nightbusflag)   %% deptime is the important thing !!
ip  [] ).


%%%% Horrendous hack, sequence problem
fromtoclocknextdayclock  rule bustrans:( %%  bussen går  fra lerkendal til torget neste tirsdag kl 12
is  srel/from/place/_/E and srel/TO/place/_/E , %% TA-110415  HACK
    present srel/nil/time/K/E, {bound(K)},
      present srel/nil/day/F13/E,
      present adj/nil/next/F13/real,

    not present _ isa departure,
    not present srel/after/time/_/_,  %% NO!
    not present srel/on/place/_/E, %%%% (do)/be1/_/E, %% for å være på
    not present srel/in/place/_/E,
    replace srel/nil/time/K/E  with     srel/before/time/K/E
id  []
ip  dmeq([to,at],TO) ).


fromtoclocksequence  rule bustrans:( %% Fra eberg .. ved Brundalen kl 0930 = before
is  srel/from/place/_/E and srel/TO/place/_/E and srel/nil/time/K/E, %% INDIRECT SEQUENCE
    not present _ isa departure,
    not present srel/after/time/_/_,  %% NO!
    not present srel/on/place/_/E, %%%% (do)/be1/_/E, %% for å være på
    not present srel/in/place/_/E,
    replace srel/nil/time/K/E  with     srel/before/time/K/E
id  []
ip  dmeq([to,at],TO) ).


fromclocksequence  rule bustrans:( %% from A 12:34 // fra telverkskrysset 2150 i dag til sentrum?
is  srel/from/place/_P/E and srel/nil/time/K/E, %% IN INDIRECT SEQUENCE
    not present srel/before/_/_/_, %% e.g. activity %% TA-110225
    not present srel/around/time/_/_, % then complicated %% TA-101111
    not present srel/in_order_to/_/_/_, % for å rekke en avtale
    not present _ isa coevent,
    not present srel/before/time/_/_,   %% NO!
    not present srel/on/place/_/E, %%%% (do)/be1/_/E, %% for å være på
    not present srel/in/place/_/E,
    not present dob/reach/_/_/_,
    replace srel/nil/time/K/E  with srel/after/time/K/E
id  []
ip  [] ).


clockniltosequence  rule bustrans:( %% go 12:34 to A  %% 0730 kroppanmarka til dragvoll .
is  srel/nil/time/T/A and srel/nil/place/_K/A and srel/to/place/_D/A,event/real/A,
    replace srel/nil/time/T/E  with    srel/after/time/T/E
id  []
ip  [] ).

%%%% TA-101109
clockfromsequence  rule bustrans:( %% bussen går på  torsdag kl 10  fra nth til nardo.
is  not present (do)/meetup/'I'/_,   %% \+ I go to start station
    not present dob/pass/_/_/_, %%  rough
    not present srel/nil/place/_ABV/E,    %% ABV 2203 til S
    srel/nil/time/K/E  and srel/from/place/_P/E, %% IN SEQUENCE
    replace srel/nil/time/K/E  with srel/after/time/K/E
id  []
ip  [] ).


clocktosequence  rule bustrans:( %% go 12:34 to A = before/ towards = after (subte)
is  not present (do)/meetup/'I'/_,   %% \+ I go to start station
    not present dob/pass/_/_/_, %%  rough
    not present srel/nil/place/_ABV/E,    %% ABV 2203 til S
    srel/nil/time/K/E  and srel/to/place/_P/E, %% IN SEQUENCE
    replace srel/nil/time/K/E  with srel/before/time/K/E
id  []
ip  [] ).



toclocksequence2  rule bustrans:( %% to place  12:34 = before/ towards
is  not present _ isa minute, %% til torget 12 minutter senere
    not present _ isa departure, %% then deptime
    srel/to/place/_P/E and srel/nil/time/K/E,  %% IN SEQUENCE
    replace srel/nil/time/K/E  with srel/before/time/K/E
id  []
ip  [] ).


clockfromsequence  rule bustrans:( %% 2030 fra buran til torget = after 2030
is  context   Time isa clock, {bound(Time)},
    not present srel/in_order_to/thing/_/_  ,
    not present srel/so_that/thing/_/_ ,
    srel/nil/_/Time/E and srel/from/place/_P/E,  %% IN  INDIRECT SEQUENCE
    replace srel/nil/time/K/E  with   srel/after/time/K/E
id  []
ip  [] ).


clocksequence  rule bustrans:( %% go 12:34 (but with default place)
is present K isa clock,
     not present adj/nil/(present)/_/_, %% fremme kl %% TA-110531
     not present srel/so_that/_/_/_,
     not present (do)/arrive/_/E, %% <---
     not present srel/before/_Activity/_/_, %%  before meeting
     not present dob/reach/_/_/_,
     not srel/in_order_to/thing/_/_,
     not srel/because_of/thing/_/_,   %% error in gramn
     not srel/in/time/_/_ ,%% ad hoc %% til S når jeg må være i S kl 0610.
   replace srel/nil/time/K/E  with  srel/after/time/K/E
id  []
ip  [] ).


%%%% END NILCLOCK SECTION %%%%%


visitpass rule bustrans:( %% to see is to pass %% special
is   X isa self, Y isa Place, {dmeq(place,Place)},
     replaceall   dob/visit/X/Y/E
     with         dob/pass/X/Y/E
id  []
ip  [] ).

seepass rule bustrans:( %% to see is to pass %% special
is   X isa self, Y isa Place, {dmeq(place,Place)},
     replaceall   dob/see/X/Y/E
     with         dob/pass/X/Y/E
id  []
ip  [] ).


passnear  rule bustrans:(  %% Pass (near) station means go FROM station to center
is   not present  srel/from/place/_/_,
     not present  srel/past/place/_/_,
     not present  dob/pass/_/(_,_)/_,
     replaceall (pass/A/C, srel/near/place/B/C,event/real/C)
     with       ((do)/go/A/C,   srel/from/place/B/C)
id   []
ip   [] ).


passpast  rule bustrans:(  %%  Pass X  past Y  means go FROM Y to X
is   not present  srel/from/place/_/_, %% because
     present  srel/past/place/Y/C,
     not present  dob/pass/_/(_,_)/_,
     replaceall dob/pass/A/X/C with ((do)/go/A/C, srel/to/place/X/C),
     replaceall srel/past/place/Y/C with srel/from/place/Y/C,
     not B isa train,
     not B isa boat
id   []
ip   [] ).


passgopast  rule bustrans:(     %% Otherwise Pass a station means go past station to center
is   present B isa P, {dmeq(place,P)}, %%  (dont eat)
     not dob/pass/_/(_,_)/_,
     replaceall (dob/pass/A/B/C)
     with       ((do)/go/A/C, srel/past/place/B/C),
     not B isa train,
     not B isa boat
id   []
ip   [] ).

passoneqgoto  rule bustrans:(     %% Pass on = go to
is   srel/on/place/X/B,  %% NB NOT dob/pass/A/B,
     not dob/pass/_/(_,_)/_,
     replaceall (pass/A/B)
     with       ((do)/go/A/C, srel/to/place/X/C),
     not B isa train,
     not B isa boat
id   []
ip   newfree(C) ).


youdo  rule bustrans:( %%  du gjør --> gjør!
is  replaceall (new,tuc isa savant,dob/LIST/tuc/X/E)
    with       ((do),tuc isa savant,dob/LIST/tuc/X/E)
id  []
ip  dmeq([list,show,tell],LIST) ).

canyoudo  rule bustrans:( %% kan du gjøre ?--> gjør
is  replaceall (test,tuc isa savant,dob/LIST/tuc/X/E)
    with       ((do),tuc isa savant,dob/LIST/tuc/X/E)
id  []
ip  dmeq([list,show,tell],LIST) ).


iwonder rule bustrans:( %% I wonder whether
is  replaceall (new,I isa self,wonder/(id)/whether/I/B/C,event/real/C,event/B/_)
    with       (test)
id  []
ip  [] ).


belie rule bustrans:(
is  replaceall  ((do)/lie1/A/B) %% TA-110503
    with        ((do)/be1/A/B)
id  []
ip  [] ).


be2or rule bustrans:( % are you A or B
is  dob/be/_/(_A;_B)/_
id  not message(onlyonething),
    add message(onlyonething)
ip  [] ).


manif rule bustrans:( % exist a or b ?
is  replaceall ((do)/exist/(A;_B)/E) with %% + other verbs
                (do)/exist/A/E
id  not message(onlyonething),
    add message(onlyonething)
ip  [] ).


samestops rule bustrans:(
is  A isa station, adj/_/same/A/_, has/vehicle/station/(_B4,_B6)/A
id  add message(cannotanswer)
ip  [] ).


walkingfrom rule bustrans:( %% walking from means going to
is   not srel/to/place/_/_, %% then pus to that place
     replaceall ((do)/walk/I/E, srel/from/place/X/E)
     with       ((do)/go/I/E,   srel/to/place/X/E)
id   []
ip   [] ).

foots rule bustrans:(
is  (do)/go/_/E , _ isa foot, srel/to/foot/_/E
id  add message(noinfoabout(walking_distance)),
    add flag(exit)
ip  [] ).



walking rule bustrans:(
is  (do)/walk/_/_
id  add message(noinfoabout(walking_distance))
ip  [] ).


web_address rule bustrans:(
is  replaceall  (X isa address,adj/_/web/X/_E)
    with        (X isa webaddress)
id  []
ip  [] ).


knownas rule bustrans:( %% kjent som
is  replaceall (adj/_/known/B/C,srel/as/thing/X/C,srel/BY/Place/B/D,event/real/C)
    with       (srel/BY/Place/X/D)
id  []
ip  [] ).

wayboundnorth  rule bustrans:( %% nord
is  øst isa direction
id  addcon message(noinfoabout(direction))
ip  dmeq([øst,vest,nord,syd, east,west,north,south],øst) ).


waybound1 rule bustrans:( %% nordover
is  adj/_/Wards/_/_
id  addcon message(noinfoabout(direction))
ip  dmeq([waybound,southward,northward,eastward,westward],Wards) ).


offat rule bustrans:( %%   go off at place
is  replaceall (srel/off/vehicle/nil/A,srel/at/place/JX/A)
    with       (srel/to/place/JX/A)
id  []
ip  [] ).


offside rule bustrans:( %%   e.g. south of
is  srel/offside/_/_/_
id  addcon  message(noinfoabout(direction))
ip  [] ).

wards rule bustrans:(
is  srel/Wards/direction/nil/_
id  addcon  message(noinfoabout(direction))
ip  dmeq([southward,northward,eastward,westward],Wards) ).


takedur0 rule bustrans:( %% tar det lang tid fra  kbs til munkegata
is  A isa time,  present adj/_/long/A/real,
    replaceall (dob/take/It/A/E)
    with       ((do)/go/It/E,srel/(with)/duration/A/E)
id  []
ip  [] ).

takedur1 rule bustrans:( %% hvor lang varighet bruker en buss
is  context (dob/use/B/A/E),context (A isa duration),context (B isa V), {dmeq(vehicle,V)},
    replaceall (dob/use/B/A/E)
    with       ((do)/go/B/E,srel/(with)/duration/A/E)
id  []
ip  [] ).


takedur2 rule bustrans:( %% hvor lang tid bruker en buss
is  context    (A isa time,B isa V), {dmeq(vehicle,V)},
    replaceall (dob/Take/B/A/E)
    with       ((do)/go/B/E,srel/(with)/duration/A/E)
id  []
ip  dmeq([take,use],Take) ).





labelled rule bustrans:(
is  replaceall (A isa bus, N isa number,adj/_/label/A/B,event/real/B,srel/(with)/number/N/_,(do)/go/A/E)
    with       (N isa bus, (do)/go/N/E)
id  []
ip  bound(N),exbus(N) ).


fromdash rule bustrans:(  % go 1800 after  1800
is  context T1 isa clock, %% not if T1 isa thursday
    replaceall  ( srel/nil/time/T2/A,srel/after/time/T1/A)
    with        ( srel/after/time/T1/A,srel/before/time/T2/A)
id  []
ip  [] ).


halloween rule bustrans:(
is  replaceall (srel/between/time/T1/E,srel/nil/time/T2/E)
    with       (srel/after/time/T1/E,srel/before/time/T2/E)
id  []
ip  [] ).


doilive1 rule bustrans:( %% only in test mode, not suitable for negans
is  exactly (test,I isa self,(do)/Exist/I/A,event/real/A),clear
id  add message(waddyathink)
ip  dmeq([exist,live,think],Exist) ). %%  ( can I go ... and be at nth before ...)

doilive2 rule bustrans:( %% only in test mode, not suitable for negans Hvorfor lever jeg
is  explain,I isa self,(do)/Exist/I/_,clear
id  add message(cannotanswer)
ip  dmeq([exist,live,think],Exist) ). %%  ( can I go ... and be at nth before ...)


doilive3 rule bustrans:( %% only in test mode, not suitable for negans
is   exactly (test,I isa self,adj/_/Alive/I/A,event/real/A),clear
id   add message(waddyathink)
ip   dmeq([alive,clever],Alive) ). %%  :-)


stand0 rule bustrans:( % two prepositions % i stand means I go from
is  replaceall ((do)/stand/B/E, srel/on/place/X/E,     srel/Prep/place/Y/E)
    with       ((do)/go/B/E,    srel/from/place/X/E, srel/to/place/Y/E)
id []
ip dmeq(to,Prep) ).


stand1 rule bustrans:(
is  context B isa self, %% ikke buss står
    replaceall ((do)/stand/B/E, srel/Prep/place/NTH/E)
    with       ((do)/go/B/E, srel/from/place/NTH/E)
id []
ip \+ dmeq([to],Prep) ).

stand2 rule bustrans:( % I am now at X = go from X now
is  context _ isa self,
    replaceall ((do)/be1/B/E,srel/now/time/nil/E,  srel/ION/place/NTH/E)
    with       ((do)/go/B/E, srel/from/place/NTH/E,srel/now/time/nil/E)
id []
ip dmeq([in,on],ION) ).



ontime1 rule bustrans:(
is  replaceall (Ev isa Night,srel/on/time/Ev/S)  %% på morgenen
    with       (Ev isa Night,srel/before/time/Ev/S)
id  []
ip  dmeq(day,Night) ). %% NOT Minute !


during2timein rule bustrans:(
is  replaceall (Ev isa Night,srel/during2/time/Ev/S) %% om kvelden/ untreated
    with       (Ev isa Night,srel/in/time/Ev/S)
id  []
ip  dmeq([night,midnight,noon,evening],Night) ). %% not day ( om 3 dager)


during2timeafter rule bustrans:(
is  replaceall (Ev isa Minute,srel/during2/_/Ev/S) %% om 5 minutter
    with       (Ev isa Minute,srel/after/time/Ev/S)
id  []
ip  dmeq([hour,minute  ,second],Minute) ). %% ?? %% TA-100903


goandbe rule bustrans:( % after shunt: go and be in_evening => go in_evening
is  context (do)/go/F64/F,
    replaceall ((do)/be1/F64/F,srel/In_night/time/Nil/F) %% meant to be the same
    with       (srel/In_night/time/Nil/F)           %% buss om en halvtime
id  []
ip  dmeq([in_night,in_evening],In_night) ). %% etc.



buyticket rule bustrans:(  %% buy ticket
is  F5 isa  ticket,dob/buy/_I/F5/_
id  clear,
    add message(noinfoabout(sale)),
    add ( message(answer(db_reply(TT,webaddress,K))))
ip  value(actual_domain,TT),
    has_att_val(company,webaddress,TT,K) ).

whereaboutastt rule bustrans:( % user knows you don't know, astt has answer
is (which(A),B isa self,A isa place,srel/FA/_Thing/C/F,C isa Topic,
    (do)/be1/D/F,event/real/F,
    D isa information,dob/FG/B/D/E,event/real/E,srel/in/place/A/E)
id add ( message(answer(db_reply(TT,webaddress,K))))
ip dmeq([find,get,receive],FG),
   dmeq([for,about],FA),
   dmeq([bus,card,departure,information,
         nightbus,season_ticket,special_ticket,
         price,route,agelimit,repair,student,travelinsurance],
         Topic), %% Topics of astt
   value(actual_domain,TT),
   has_att_val(company,webaddress,TT,K) ).


whereaboutdn rule bustrans:( % user knows you don't know, I don't know
is (which(A),B isa self,A isa place,srel/about/thing/C/F,C isa _Topic,
    (do)/be1/D/F,event/real/F,
    D isa information,find/B/D/E,event/real/E,srel/in/place/A/E)
id add  message(icannotanswer)
ip [] ).


wherefindastt rule bustrans:( % user knows you don't know, astt has answers of OTHER Topics
is  (which(A),B isa self,A isa place,C isa Topic,
    find/B/C/E,event/real/E,srel/in/place/A/E),
    not (1 isa route),  %% Ad Hoc,  ikke trikk
    not X isa neighbourhood when { (bound(X),foreign(X))}   %% melhus
id  add  message(answer(db_reply(TT,webaddress,K)))
ip  dmeq([card,departure,nightbus,price,route_plan,
         repair,student,travelinsurance],Topic), %% OTHER Topics of astt
    value(actual_domain,TT),
    has_att_val(company,webaddress,TT,K) ).



tellwhatbuses rule bustrans:(
is  (do), dob/tell/tuc/A/B,event/real/B,
    tuc isa savant,
    A isa Bus, {unbound(A), dmeq([bus,departure], Bus)},
    not present _ isa station,
    not present _ isa neighbourhood,
    not present _ isa street
id  add listofall(bus,_)
ip  [] ).


tellwhere1 rule bustrans:(
is  replaceall (test,tuc isa savant,A isa Place,dob/Tell/tuc/A/C,event/real/C)
    with       (which(A),A isa Place)
id  []
ip  dmeq([place,station],Place),
    dmeq([tell,list],Tell) ).


tellwhere2 rule bustrans:(
is  replaceall ((do),tuc isa savant,A isa Place,dob/tell/tuc/A/C,event/real/C)
    with       (which(A),A isa Place)
id  []
ip  dmeq([place,station],Place) ).


tellwhere3 rule bustrans:( %% kan du fortelle  om et sted
is  replaceall ((do),tuc isa savant,A isa Place,tell/tuc/C,event/real/C,srel/regarding/thing/A/C)
    with       (which(A),A isa Place)
id  []
ip  dmeq([place,station],Place) ).



thereafter rule bustrans:( %% klokken KK og deretter
is  replaceall (srel/nil/time/Tid/C,srel/thereafter/time/nil/C)
    with       (srel/after/time/Tid/C)
id  []
ip  [] ).



otherbus0 rule bustrans:( %% NSB buss %% Fronted
is  _Nettbuss isa otherbus,clear
id	 clear,
    add message(noroutesfor(otherbus))
ip  [] ).


otherbus1 rule bustrans:( %% NSB buss
is  NSB isa company,has/company/bus/NSB/_,
    {NSB \== atb} %% TA-100905
id	 clear,
    add message(noroutesfor(otherbus))
ip  NSB \== tt ). %% varies with installation


otherbus2 rule bustrans:(
is  NSB isa company,(do)/go/NSB/_
id	 clear,
    add message(noroutesfor(otherbus)),
    add flag(exit)
ip  NSB \== tt ). %% varies with installation


otherbus3 rule bustrans:(
is  dob/hire/_/_/_,
    clear
id	 clear,
    add message(noroutesfor(otherbus))
ip  [] ).

otherbus4 rule bustrans:(
is  Klaburuta isa bus, %% bussen Klæburuta
    clear
id	 clear,
    add message(noroutesfor(otherbus))
ip  Klaburuta isa otherbus ). %% but it is a fact

nostation0x rule bustrans:( %% county/country/ -> only buses Th
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
ip  [] ).


nostationairbus rule bustrans:( %% malvik værnes
is  X isa Place, {bound(X),dmeq(place,Place), xforeign(X)}
id  flag(airbus),
    not flag(exit),
    not message(foreign(_)),      %% addcon doesnt work, different X
    clear,
    addfront message(foreign(X)),
    add flag(exit)
ip  xforeign(X) ).  %%  Klæbu


nostation0 rule bustrans:( %% statsminister i norge %% moved after noinfoaboutnoun
is  X isa Place, {bound(X),dmeq(place,Place)},
    not _ isa airplane,
    not _ isa boat,
    not _ isa train,
    not _ isa weather, %% været på Bekkestua
    clear  %% trikk til bekkestua
id  not flag(exit),
    not message(foreign(_)),      %% addcon doesnt work, different X
    %% not message(noinfoabout(_weather)), %% weather in oslo  Nar gar bussen fra vestsiden porsgrunn .
    clear,                                 %% direction OK
    addfront message(foreign(X)),
    add flag(exit)
ip  xforeign(X) ).  %%  Klæbu


notarouteatall rule bustrans:(  % neither bus nor tram
is  NotBus isa route, {bound(NotBus)},
    clear
id	 not flag(exit), %% e.g. foreign
    add message(not(route,NotBus))  %% route
ip	 \+ value(tramflag,true),
    NotBus \== it, %% internal anaphora  :-)
    \+ (NotBus  isa otherbus), %% Klæburuta ?
    \+ exbus(NotBus),
    \+ regbus(NotBus) ). %% tt/regbusall


notabusatall rule bustrans:(  % neither bus nor tram
is  NotBus isa bus, {bound(NotBus)},  %% exclude tram
    clear
id	 not flag(exit), %% e.g. foreign
    add message(not(bus,NotBus))  %% route

%ip     not value(tramflag,true),     %% RS-141019  not  belongs to pragma's is and id processing!
ip       \+ value(tramflag,true),
    NotBus \== it, %% internal anaphora  :-)
    \+ (NotBus  isa otherbus), %% Klæburuta ?
    \+ exbus(NotBus),
    \+ regbus(NotBus) ). %% tt/regbusall


%%%% after nostation0 trikk i arendal => Ikke Arendal
noroutesfortram0 rule bustrans:(
is  X isa route,      %% bane fra nationalteateret AFTER nostation
    not present _ isa telephone,
    not present _ isa webaddress,  %% etc
    clear
id  addcon  message(noroutesfor(tram))
ip  vehicletype(X,tram),
    value(tramflag,false) ).

noroutesforbus1 rule bustrans:( %%  Buss 1
is  X isa bus ,      %% bane fra nationalteateret AFTER nostation
    not present _ isa telephone,
    not present _ isa webaddress,  %% etc
    clear
id  addcon  message(noroutesfor(tram))
ip  vehicletype(X,tram),
    value(tramflag,false) ).


%noroutesfortram1 rule bustrans:( %%  trikk til nth
%is  _ isa tram,
%    not X isa neighbourhood when { foreign(X) },
%    not present _ isa clock, %% ad hoc  den (klokka) er 1
%    clear
%id  addcon  message( noroutesfor(tram) ),
%    addcon  message(answer(db_reply('Gråkallbanen',webaddress,K)))
%ip  \+ value(tmnflag,true),
%    has_att_val(company,webaddress,tram,K) ).


nostation3 rule bustrans:( %% explicit not a destination, after noroutesfrotram1
is  X isa neighbourhood, { bound(X) },
    clear
id  clear,
    addcon message( noroutesto(X) )
ip  nostationfor(X),   %% adm_rit
    \+ placestat(X,_) ).


notanightbus rule bustrans:( %%   NN not a nightbus
is  (NBus isa nightbus),clear
id	 add message(not(nightbus0,NBus)) %% ikke nattbussen men natbuss
ip	 atomic(NBus),  NBus \== it, %% internal anaphora  :-)
%    not vehicletype(NBus,nightbus) ).
    \+ vehicletype(NBus,nightbus) ).


notatram2 rule bustrans:( %% X is not a tram
is  NotTram isa tram
id	 add message(not(tram,NotTram))
ip	 atomic(NotTram),
      \+ (NotTram isa tram),
      \+ (NotTram == it) ).

%%%% after nostation0 etc
totosameplace rule bustrans:( %% %% fra A til B som er på B
is  context srel/to/place/X/E, {bound(X)},
    remove  srel/on/place/X/E
id  []
ip  [] ).


tofromsameplace rule bustrans:( %% to from sameplace
is  srel/to/place/X/E, {bound(X)},
    srel/from/place/X/E, %% From
    clear
id  clear,
    add message(sameplace(X,X)),
    add flag(exit)
ip  [] ).


tofromcorrplace rule bustrans:( %% to from sameplace  %% fra studsamf 1 til studsamf 2
is  srel/to/place/X/E,   { bound(X)},
    srel/from/place/Y/E, { bound(Y)},{ corresponds(X,Y)},
    clear
id  clear,
    add message(sameplace(X,Y)), %% near places
    add flag(exit)
ip  [] ).


resolveclock rule bustrans:( %% -6 means either 1800 today or 6 tomorrow , depending
is  N6 isa clock, {number(N6), N6 <0},
    replaceall (N6 isa clock) with (U1800 isa clock),
    replaceall (srel/P/time/N6/E) with (srel/P/time/U1800/E)
id  []
ip  U1800 is (-N6)*100+1200,
    timenow2(X),
    U1800 < X ).

notaclock rule bustrans:(  %% X is not a clock
is  NotClock isa clock,
    { bound( NotClock)},
    clear
id	 add message(not(clock,NotClock)),
    add flag(exit) % finish it
ip	 notaclock(NotClock) ).    %%  buslog


whichtrase rule bustrans:( %% which tracee does the route follow
is    which(A), Bus isa bus, A isa route_plan, event/real/E, dob/run/Bus/A/E
id    atday(Day),
      add (findstations(Bus,Day,Stl),
           passesstations(Bus,Day,Stl,_))
ip   bound(Bus) ).


nighttosunday rule bustrans:(
is  replaceall
           (C isa midnight,
           srel/nil/daypart/C/D,
           srel/to/time/B/D,
           B isa Sunday)
    with
           (C isa midnight,B isa Saturday,
            srel/nil/daypart/C/D, srel/nil/day/B/D)
id  []
ip  daysucc(Saturday,Sunday) ).


oddtimestid rule bustrans:(
is  replaceall  (B isa Halfhour,has/Halfhour/DUR/B/C, C isa DUR,
                            srel/during2/DUR/TT/E)          %% semantically necessary
    with        (C isa Halfhour,srel/during2/duration/TT/E)  %% pragmatically necessary
id  []
ip  dmeq([hour,halfhour,quarter],Halfhour),dmeq(duration,DUR) ).


withfore rule bustrans:( %% innen en time   (ankomst om en time)
is  present srel/in_order_to/thing/_/_,
    replaceall (srel/during2/duration/X/Y)
    with       (srel/before/time/X/Y),
    not X isa day           %%%%%  very hazardous
id  []
ip  [] ).

withafter rule bustrans:( %% OM 1 time
is  replaceall (srel/during2/duration/X/Y)
    with       (srel/after/time/X/Y),
    not X isa day           %%%%%  very hazardous
id  []
ip  [] ).


direction1 rule bustrans:(
is  replaceall (F74 isa direction,
                srel/Towards/place/Sentrum/F76,
                event/real/F76,
                (do)/be1/F74/F76,
                srel/on/direction/F74/F75)
	 with       (srel/towards/place/Sentrum/F75)
id  []
ip  dmeq(to,Towards) ).

direction2 rule bustrans:( % ?
is  replaceall (Place isa direction,srel/DD/direction/Place/C)
	 with       (Place isa place,srel/to/place/Place/C)
id  []
ip  dmeq([in,nil,with],DD),
    bound(Place) ).  %% "retning" alene er kanskje "veg"


direction3 rule bustrans:( % ?
is  replaceall (Place isa direction,srel/DD/direction/Place/C)
	 with       (Place isa place,srel/from/place/Place/C)
id  []
ip  dmeq([from],DD),
    bound(Place) ).  %% "retning" alene er kanskje "veg"

nightbusitem rule bustrans:(
is  replaceall (item, _ isa nightbus)
    with   which(A),(A isa nightbus,nrel/today/vehicle/day/A/nil)
id  []
ip  newfree(A) ).



%%%% fra nth til risvollan.   den 30. november
itemdate rule bustrans:( % an item is treated like a modifier
is  context (item,  X isa Class),{ dmeq([day,date],Class)},
    replaceall (item, X isa date)
    with   (which(A),X isa Class,B isa vehicle,A isa time,(do)/go/B/C,srel/on/Class/X/C)
id  []
ip  newfree(B)
   ):- double.


%%%% fra nth til risvollan.   kl 1230.
itemclock rule bustrans:( % an item is treated like a modifier
is  context (item,  X isa Class),
    { dmeq([clock],Class)} ,
    not present (do)/go/_/_ ,
    not _ isa endstation,
    not _ isa  tram,
    replaceall (item, X isa Class)
    with   (which(A),X isa Class,B isa vehicle,A isa time,(do)/go/B/C,srel/in/time/X/C)
id  []
ip  newfree(B)
   ):- double.


iteminfo rule bustrans:(  %%  "bussruteinformasjon"
is  item, it  isa information
id  add message(howtuchelp)
ip  [] ).



inperiod rule bustrans:(       %% for å nå DV til kl 0830
is  replaceall  (srel/in/Time1/T1/E1,srel/to/time/T2/E2)
    with        (srel/after/Time1/T1/E1,srel/before/time/T2/E2)
id  []
ip  bound(T1),bound(T2) ).

hasdeparture1 rule bustrans:(  %% which deaprtures has bus 52 ?
is  replaceall  (which(D),B52 isa bus,has/vehicle/departure/B52/D,D isa departure,event/real/A)
    with        (which(T),T isa time,
                 B52 isa bus,(do)/go/B52/A,srel/in/time/T/A,event/real/A)
id  []
ip  newfree(T) ).


hasdeparture2 rule bustrans:( %% which departures does bus 52 have
is  replaceall  (new,B52 isa bus,has/vehicle/departure/B52/D,D isa departure,event/real/A)
    with        (new,T isa time,
                 B52 isa bus,(do)/go/B52/A,srel/in/time/T/A,event/real/A)
id  []
ip  newfree(T) ).


befind rule bustrans:( %% befinne seg  %% Norwagism
is  replaceall (befind/X/_/E)
    with       ((do)/be1/X/E)
id  []
ip  [] ).


hq rule bustrans:( %% what is the office of company
is  replaceall (
      which(FREE_26), TT isa company,
      has/company/office/TT/FREE_23 ,
      FREE_23 isa office,
      (do)/be1/FREE_23 /FREE_25 ,
      event/real/FREE_25 ,
      srel/in/place/FREE_26 /FREE_25 ,
      FREE_26 isa place)
    with  (
      which(FREE_26),  TT isa company,
      (do)/be1/TT/FREE_25 ,
      event/real/FREE_25 ,
      srel/in/place/FREE_26 /FREE_25 ,
      FREE_26 isa place)
id  []
ip  [] ).


inorder0 rule bustrans:(
is  context    ( srel/in_order_to/thing/D/_,srel/in/time/D/E),
    replaceall ( (do)/be1/A/E,srel/ON/place/Drag/E )
    with       ( dob/pass/A/Drag/E )
id  []
ip  dmeq(by,ON) ).


inorder1 rule bustrans:(
is replaceall ( srel/in_order_to/thing/D/C,
                D isa time,
                event/real/E,              %% Does this help
                srel/in/time/D/E,
                srel/to/place/Risvollan/_CE,  %% makes it slightly rougher
                srel/at/time/T1300/E)
   with       ( srel/to/place/Risvollan/C,srel/before/time/T1300/C)
id []
ip [] ).


reachat0 rule bustrans:(
is
    replaceall ( dob/reach/C/D/B, srel/nil/time/Six/B)
    with       ( dob/reach/C/D/B, srel/before/time/Six/B),
    {dmeq(vehicle,C)}
id  []
ip  [] ).


reachat1 rule bustrans:(
is  replaceall ( dob/reach/C/D/B, srel/at/time/Six/B)
    with       ( dob/reach/C/D/B, srel/before/time/Six/B)
id  []
ip  [] ).


reachat2 rule bustrans:(
is  replaceall ( dob/take/C/D/B, srel/nil/time/Six/B) %% nil ???
    with       ( dob/take/C/D/B, srel/before/time/Six/B)
id  []
ip  [] ).


takeit1 rule bustrans:( %% Horrible Hack
is  replaceall (dob/take/it/D/_, (do)/go/it/E)
    with       (V isa bus,(do)/go/V/E,srel/(with)/duration/D/E)
id  []
ip  newfree(V) ).



go2it rule bustrans:(
is  replaceall ((do)/go/it/C)
    with       (V isa bus,(do)/go/V/C)
id  []
ip  newfree(V) ).

get2it rule bustrans:(
is  replaceall (get/it/C)
    with       (V isa bus,(do)/go/V/C)
id  []
ip  newfree(V) ).


longdist1 rule bustrans:(
is  replaceall (D isa distance, (do)/Exist/D/C)
    with       (V isa bus,D isa duration,(do)/go/V/C,srel/(with)/duration/D/C)
id  []
ip  dmeq([be1,exist],Exist),newfree(V) ).

longdist2 rule bustrans:( %% ?
is  replaceall (D isa difference, (do)/be1/D/C,srel/after/thing/X/C,srel/before/thing/Y/C)
    with       (V isa bus,D isa duration,(do)/go/V/C,srel/(with)/duration/D/C,srel/from/place/X/C,srel/to/place/Y/C)
id  []
ip  newfree(V) ).


isnamewhat rule bustrans:( %% er TA et menneske %% TA-110825 #-> Person
is test,dob/be/TA/F10/F11,TA isa Person,F10 isa _,event/real/F11,clear
id clear,
   add message(answer(bcpbc(Person))),
   add flag(exit)
ip [] ).

describename rule bustrans:(
is (tuc isa savant,C isa Clock, dob/describe/tuc/C/E,event/real/E),clear
id clear,          %% hva er du , 1 tuc isa savant -> describe2
   add message(answer(bcpbc(Clock))),
   add flag(exit)
ip bound(C) ).

describenamenor  rule bustrans:( %% what is 42 = hvilken ting er det 42 er %% TA-110523
is   not (_ isa clock),
    (which(A),X isa Number,A isa thing,event/real/B,dob/be/X/A/B)
id  clear,
    add message(answer(bcpbc(Number))),
    add flag(exit)
ip  [] ).

describenameeng  rule bustrans:( %% what is 42 = hvilken X er 42
is which(A),(X isa Number,A isa thing,event/real/B,dob/be/A/X/B)
id  clear,
    add message(answer(bcpbc(Number))),
    add flag(exit)
ip  [] ).

describenoun1 rule bustrans:(  %% beskriv en savant
is  exactly ((do),tuc isa savant,C isa Clock, dob/describe/tuc/C/E,event/real/E),
    clear   %% TA-110523 \+ hva er adressa til steinan
id  clear, add message(answer(bcpbc(Time))),
    add flag(exit)
ip  description(Clock,Time) ).


describenoun2 rule bustrans:(  %% hva betyr savant
is  A isa thing,dob/mean2/B/A/C,B isa Savant,event/real/C,
    {unbound(B)}, %% \+ name %% TA-100927
    clear
id  clear, add message(answer(bcpbc(System))),
    add flag(exit)
ip  description(Savant,System) ).


describe0 rule bustrans:( %% describe X  MEANS what is the class/superclass
is (which(A),Man ako A),
   clear
id clear, add message(answer((bcpbc(Adult)))),
   add flag(exit)
ip description(Man,Adult) ).


describe1 rule bustrans:( %% describe X  MEANS what is the class/superclass
is (tuc isa savant,C isa Clock, dob/describe/tuc/C/E,event/real/E),
   {bound(C)},clear
id clear, add message(answer((bcpbc(Clock)))),
   add flag(exit)
ip [] ).


describe2 rule bustrans:(   %% Dummy, but 2 tuc is coerced
is (tuc isa savant, dob/describe/tuc/C/E,event/real/E),clear
id clear, add message(answer((bcpbc(D)))),
   add flag(exit)
ip description(C,D) ).


describerev rule bustrans:(   %% what are you (E)=hvilken ting er deg %% TA-100902
is (tuc isa savant, dob/be/_C/tuc/E,event/real/E),
   clear
id clear, add message(answer(bcpbc(busstuc))), %% TA-101015
   add flag(exit)
ip [] ).


describeq rule bustrans:(
is (tuc isa savant, dob/describe/tuc/quote(Meaning)/E,event/real/E),
   clear
id clear, add message(answer(bcpbc(Abstract))),
   add flag(exit)
ip (Meaning ako Abstract),
   \+ member(Meaning,[god,price]) ). %% etc.


describename rule bustrans:(
is (tuc isa savant,C isa Clock, dob/describe/tuc/C/E,event/real/E),clear
id clear,          %% hva er du , 1 tuc isa savant -> describe2
   add message(answer(bcpbc(Clock))),
   add flag(exit)
ip bound(C) ).




%%%

innight0 rule bustrans:( % IF T before clock, T < 1200 => in-night just eveningtime
is  srel/in_night/time/nil/E,
    replaceall  (  T isa clock, srel/Prep/time/T/E)
    with        ( T1 isa clock, srel/Prep/time/T1/E)
id  []
ip  before(T,1200), %% safe
    evening_time(T,T1) ).


niltoclockrepair rule bustrans:( % 8 til 9 ( same as toclock ?)
is  replaceall (srel/nil/time/T800/F, srel/to/Time/T900/F)
    with       (srel/after/time/T800/F,srel/before/time/T900/F)
id  []
ip  dmeq([clock,time],Time) ). %%




toplaceclockbefore rule bustrans:( %% clock with toplace = before clock %%  After tonightat
is   not srel/from/place/_/_,
     not  srel/on/time/_F17/E,  %% etter lørdag (nil) kl 8
     not  adj/_/next/_/_,
     not (do)/meetup/'I'/E, %%  på holdepl.
     not present  srel/nil/place/_ABV/E, %% ABV 2203 til S

     replaceall (srel/to/place/J/E,srel/nil/time/T/__E)
     with       (srel/to/place/J/E,srel/before/time/T/E)
id  []
ip  [] ).



aroundtimetime rule bustrans:( %% rundt 1000 - 1030 -> from 1000 - 1030
is replaceall (srel/around/time/T/E1,srel/nil/time/T2/E2)
   with       (srel/after/time/T/E1,srel/before/time/T2/E2)
id  []
ip  [] ).


tomorrowat6ugly  rule bustrans:( % Klokken 22:  reise kl 6, om morgenen => next morning with message
is  context srel/_Prep_/time/Six/_, { number(Six)},
    _ isa morning or  srel/in_morning/time/nil/_,  %% not present
    not present srel/_/time/Seven/_ when { (number(Seven), Six \== Seven)}, %% avoid intervals Ad Hoc
    not present srel/early/time/nil/_,
    not present srel/in_day/time/nil/_,
    not present srel/tomorrow/_/_/_,      %% then explicit
    not present srel/day_after_tomorrow/_/_/_, %% TA-110215
    not present srel/today/_/_/_,
    not present srel/tonight/_Daypart/nil/_,
    not present srel/this_midnight/time/nil/_,
    not present _ isa date,
    not present _ isa weekday,  %% hverdager means general (other) day
    not _ isa Day when { dmeq(mtwtfss, Day)}
id  not flag(nightbusflag),
    not flag(earlytime),
    add flag(earlytime),   % ?
    add atday(TOM),
    not buslog:atdate2(_,_),
    add atdate2(DaySeqNo,DATE),
    add message(assumetomorrow)  %% <--- sometimes unnec
ip  today(TODAY),
    daysucc(TODAY,TOM),
    number(Six),
    timenow2(0,NOW),
    NOW > Six,
    finddate(1,DATE),
    dayModSeqNo(DATE,DaySeqNo) ).


morningtomorrow  rule bustrans:( % Klokken > 1200:  reise  om morgenen => next morning with message
is  _ isa morning or  srel/in_morning/time/nil/_ or adj/_/early/_/real
    or srel/early/time/nil/_ ,

    not present srel/tomorrow/_/_/_ ,
    not present srel/day_after_tomorrow/_/_/_ , %% TA-110215
    not present srel/_/time/Seven/_  when { number(Seven)},
    not present srel/in_day/time/nil/_,
    not present srel/today/_/_/_,
    not present srel/tonight/_Daypart/nil/_,
    not present srel/this_midnight/time/nil/_,
    not present _ isa date,
    not present _ isa weekday,  %% hverdager means general (other) day
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
    finddate(1,DATE),
    dayModSeqNo(DATE,DaySeqNo) ).

tonightis18ugly  rule bustrans:(
is  ( _ isa night or  srel/tonight/_/_/_), %% NEW FEATURE
    context srel/Prep/time/Six/D,
     {number(Six),   Six  =< 1200},
    not present srel/early/time/nil/_,
    not present srel/in_day/time/nil/_,  %% " om dagen"
    not present _B isa morning,
    not present srel/in_morning/time/nil/_,
    not present srel/this_midnight/time/nil/_,
    not present srel/tomorrow/_/_/_,            %%
    not present srel/day_after_tomorrow/_/_/_,  %% TA-110215
    not present _ isa date,
    not present _ isa weekday,  %% hverdager means general (other) day
    not _ isa Day when { dmeq(mtwtfss, Day)}, %% DAY is mentioned
    replaceall ( Six isa clock, srel/Prep/time/Six/D)
    with       ( Eighteen isa clock,srel/Prep/time/Eighteen/D) % time is standard
id  not flag(latetime),
    add flag(latetime),
    not flag(nightbusflag)
ip  evening_time(Six,Eighteen) ).


tonightis18  rule bustrans:(
is  present srel/tonight/_/_/_,  %% ad hoc ugly
    context srel/Prep/time/Six/D,
     { number(Six),   Six  =< 1200},
    not present srel/early/time/nil/_,
    not present srel/in_day/time/nil/_,  %% " om dagen"
    not present _B isa morning,
    not present srel/in_morning/time/nil/_,
    not present srel/this_midnight/time/nil/_,
    not present srel/tomorrow/_/_/_,            %%
    not present srel/day_after_tomorrow/_/_/_,  %% TA-110215
    not present _ isa date,
    not present _ isa weekday,  %% hverdager means general (other) day
    not _ isa Day when { dmeq(mtwtfss, Day)}, %% DAY is mentioned
    replaceall ( Six isa clock, srel/Prep/time/Six/D)
    with       ( Eighteen isa clock,srel/Prep/time/Eighteen/D) % time is standard
id  not flag(latetime),
    add flag(latetime),
    not flag(nightbusflag)
ip  evening_time(Six,Eighteen) ).
clock0now rule bustrans:( % Hva er klokka nå ? (ad hoc)
is  exactly (which(A),A isa Timeq,
    _ isa thing, event/real/B,srel/now/time/nil/B),
    {dmeq(timeclock,Timeq)}
id	 add  message(time(now,T))
ip  timenow2(0,T) ).


%%%% clock questions before   assumeatmidnight %% TA-110221
%%%% Nar gar bussen fra solsiden til alt.
clock0 rule bustrans:( % Hva er klokka
is  exactly  ( which(A),A isa clock,_ isa thing,event/real/_), %%
           %*% space TA-101001
    not present _ isa coevent %% TA-100715
id	 add ( timenow2(0,T), timeis(T) ),
    add flag(exit)
ip	 unbound(A) ).


clocktime  rule bustrans:( % Hvilken tid  er klokka
is  exactly (which(A),(A isa Clock,_ isa time,event/real/_)),
       {dmeq(timeclock,Clock)}
id	 add (timenow2(0,T),timeis(T))
ip	 unbound(A) ).

clock1 rule bustrans:( % Hva er klokka?
is  exactly (which(A),B isa clock,
             (do)/be1/A/C,event/real/C,srel/nil/time/B/C)
id	 add (timenow2(0,T),timeis(T))
ip	 [] ).


clock2 rule bustrans:( % Hva er klokka?
is  exactly (which(Time),Time isa Timeq)
id	 add (timenow2(0,T),timeis(T))
ip  unbound(Time),
    dmeq(timeclock,Timeq) ). %% not duration


clock3 rule bustrans:( % Hva er klokka nå?
is  exactly (which(A),B isa Timeq,(do)/be1/A/C,event/real/C,
             srel/nil/time/B/C,srel/now/time/nil/C)
id	 add (timenow2(0,T),timeis(T))
ip	  dmeq(time,Timeq) ).


clock4 rule bustrans:( % What is the time?
is  exactly (which(A),A isa Timeq,event/real/_)
id	 add (timenow2(0,T),timeis(T))
ip	 dmeq(time,Timeq), unbound(A) ).


clock5 rule bustrans:( % What is the time now?
is  exactly (which(A),A isa Timeq,(do)/be1/A/B,event/real/B,srel/now/_/nil/B)
id	 add (timenow2(0,T),timeis(T))
ip	  dmeq(time,Timeq) ).


clock6 rule bustrans:( % What time is it?
is  exactly (which(A),A isa Timeq,(do)/be1/A/B,event/real/B)
id	 add (timenow2(0,T),timeis(T))
ip	  dmeq(time,Timeq) ).


clock7 rule bustrans:( % What time is it now? << clock0
is  exactly (which(A),(B isa clock,srel/now/time/nil/C,event/real/C,dob/be/A/B/C))
id	 add (timenow2(0,T),timeis(T))
ip  [] ).


clock8sic2 rule bustrans:( % hvor lenge er det til klokka 2400
is  which(A), ( 2400 isa clock, A isa time, (do)/be1/_CLOCK/B, srel/in/time/A/B, event/real/B ),
    { unbound(A) },
    %% not nrel/around/vehicle/time/_B/_2400, %% RS-151219 Transformed earlier by another rule to this:
    not srel/around/time/_2400/_FreeEvent
id	 add (timenow2(0,T),timeis(T)),
    add flag(exit)
ip  [] ).


clock8sic rule bustrans:( % Klokka er 10 (SIC)
is  exactly (new,B isa _Number,A isa clock,event/real/C,dob/be/A/B/C),
    {number(B)}, {unbound(A)}
id	 add (timenow2(0,T),timeis(T)),
    add flag(exit)
ip  [] ).


clock8sicnow rule bustrans:( % Klokka er 10 nå (SIC)
is  exactly (new,dob/be/A/B/C,B isa _Number,A isa clock,event/real/C,srel/now/time/nil/_),
    {number(B)}, {unbound(A)}
id	 add (timenow2(0,T),timeis(T)),
    add flag(exit)
ip  [] ).


%%TODO: THIS ONE IS CAUSEING PROBLEMS: RS-150617

%%%% before assumeatmidnight
%ateveningimplicit  rule bustrans:( %%  1230:  jeg skal til byen før 0200 -> 1400>1230
%is  context srel/Prep/time/Six/D,
%        not  { (number(Six), morning_break(T0430), Six =< T0430) },  %% improbable
%        not present _B isa morning,
%        not present srel/early/time/nil/_,
%        not present srel/this_morning/time/nil/_,
%        not present srel/in_morning/time/nil/_,
%        not present srel/this_midnight/time/nil/_,
%        not present srel/on/day/_/_,                    %% RS-150313  Only when "today" is implicit as well
%        not present srel/tomorrow/day/nil/_,            %% RS-150313  Only when "today" is implicit as well
%       %not present nrel/tomorrow/vehicle/day/_/nil,    %% RS-150313  Only when "today" is implicit as well
%    replaceall ( Six isa clock, srel/Prep/time/Six/D)
%    with       ( Eighteen isa clock,srel/Prep/time/Eighteen/D) % time is standard
%id  not flag(earlytime),
%    not flag(latetime),
%    not flag(latetime),
%    not flag(nightbusflag),
%        addfront message(assumeyesterdepartures) %%
%ip  timenow(T1200),
%    evening_time(Six,Eighteen),
%    T1200 =< Eighteen,  %% RS-150420. kl 0900: valentinlyst til stindheim kl 11.15....
%    T1200 > Six ).      %% RS-150420. Oops! Buss 22 går fra Valentinlyst kl. 2247 til Dalen Hageby kl. 2253 (Morning!)




assumeatmidnight  rule bustrans:(
is  MMMM isa clock, {bound(MMMM)},
        {morning_break(M0), MMMM >= 100, MMMM < M0},

    not present srel/today/_/_/_,  %% etc

    {\+ value(airbusflag,true)}, %% airbus starts at 400 (!)
                                         % 430 set as early time
    not srel/early/time/nil/_,  %% then NOT midnight
    not srel/today/_Day/nil/_   %% means coming morning

id  not flag(airbus),
    not flag(nightbusflag),
    add flag(nightbusflag)

ip  set(nightbusflag,true) ). %%  // necessary (flag above vs. memory


%%%% before tomorrow rule bustrans:( %% TA-101025

ateveningexplicit  rule bustrans:( %% 1230:   jeg skal til byen før 6 -> 1800
is  present  _ isa afternoon,
    not present srel/_Prep2_/time/Fourteen/_
                 when { (number(Fourteen),Fourteen >=1200)},
                              %% Time: 1500,  1200 - 1400 \==> 2400 - 1400
    context srel/Prep/time/Six/D,
    { (number(Six),  Six  =< 1200)},
    not present srel/early/time/nil/_,
    not present _B isa morning,
    not present srel/this_morning/time/nil/_,
    not present srel/in_morning/time/nil/_,
    not present srel/this_midnight/time/nil/_,
    replaceall ( Six isa clock, srel/Prep/Clock/Six/D)
    with       ( Eighteen isa clock,srel/Prep/time/Eighteen/D) % time is standard
id  not flag(earlytime),
    not flag(latetime),
    not flag(latetime),
    not flag(nightbusflag)
ip  number(Six),
    dmeq(clock,Clock),evening_time(Six,Eighteen) ).
    %% man 2150   "før kl 6" -> 18 selv om for sent for det også




tomorrow  rule bustrans:( % TIMENOW > SCHEDULED TIME
is  not present _ isa day, %% om tre dager
    not present  srel/day_after_tomorrow/day/nil/_,
    context
  ( Schedtime isa clock, srel/Prep/time/Schedtime/_),

    not Schedtime isa hour, %%  ad hoc (om) en time
    not Schedtime isa minute,
    not present _ isa morrow,  %% Techn
    not present _ isa midnight,
    not present _ isa morning,
    not present _ isa prenoon, % new
    not present _ isa afternoon, %
    not present _ isa evening, %
    not present _ isa night, %
    not present _ isa date,
    not present _ isa weekday,  %% hverdager means general (other) day

    not _ isa Day when { dmeq(mtwtfss, Day)},
    not present srel/yesterday/_/_/_ ,
    not present srel/this_prenoon/time/nil/_, %% ?
    not present srel/in_prenoon/time/nil/_,   %% ?
    not present srel/in_morning/time/nil/_,
    not present srel/early/time/nil/_,
    not present srel/in_day/time/nil/_,
    not present srel/tomorrow/_/_/_,      %% then explicit
    not present srel/day_after_tomorrow/_/_/_,  %% TA-110215
    not present srel/today/_/_/_,         %% then past deps are OK
    not present srel/tonight/_Daypart/nil/_,
    not present srel/this_midnight/time/nil/_
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
    finddate(1,DATE),
    dayModSeqNo(DATE,DaySeqNo) ).



tomorrowat6early  rule bustrans:( % Klokken 22:  reise kl 6,  next morning with message
is  context srel/_Prep_/time/Six/_, { number(Six)},
 %% If not another day, then these means Today
    not present _ isa midnight,
    not present _ isa morning,
    not present _ isa prenoon, % new
    not present _ isa afternoon, %
    not present _ isa evening, %
    not present _ isa night, %
    not present _ isa date,
    not present _ isa weekday,  %% hverdager means general (other) day

    not _ isa Day  when { dmeq(mtwtfss, Day)},

    not present srel/yesterday/_/_/_ ,
    not present srel/this_prenoon/time/nil/_, %% ?
    not present srel/in_prenoon/time/nil/_,   %% ?
    not present srel/in_morning/time/nil/_,
    not present srel/early/time/nil/_,
    not present srel/in_day/time/nil/_,
    not present srel/tomorrow/_/_/_,           %% then explicit
    not present srel/day_after_tomorrow/_/_/_, %% TA-110215
    not present srel/today/_/_/_,
    not present srel/tonight/_Daypart/nil/_,
    not present srel/this_midnight/time/nil/_,

    replaceall ( Six isa clock, srel/Prep/time/Six/D)
    with       ( Newtime isa clock,srel/Prep/time/Newtime/D) % time is standard

id  not flag(exit),
    not flag(earlytime),
    add flag(earlytime),
    not flag(latetime),
     add flag(latetime),
    not flag(nightbusflag),
    not atdate2(_,_),
    add atdate2(DaySeqNo,DATE),
    add atday(TOM),
    add   message(assumetomorrow)
ip  today(TODAY),
    daysucc(TODAY,TOM),
    number(Six),
    Six >=100,  %% 15 = 0015 never 1215 %% 154       never 1354
    Six >= 0430, %% 429        never 1629 % ?
    timenow2(0,NOW),
    NOW > Six,
    evening_time0(Six,Eighteen), %% 1330 -> 1330

    maxtraveltime(MT),   %% 23:05      fra rosendal til gløshaugen før klokken 10.
     aroundmargin(MT),    %% more modest
     addtotime(Eighteen,MT,EighteenPlus), %% time many  min before now
     NOW > EighteenPlus, %% Far too late for that also

    (Six < 0430 -> Newtime=Eighteen %% not morning if <5
                ;  Newtime=Six),  %% next morning
    finddate(1,DATE),
    dayModSeqNo(DATE,DaySeqNo) ).





tomorrowat6late  rule bustrans:( % Klokken 22:  reise kl 0230 -> 1430 TOMORROW
is  context srel/_Prep_/time/Four/_, { number(Four)},
    not present _ isa midnight,
    not present _ isa morning,
    not present _ isa prenoon,

    not present _ isa afternoon, % then mess is redundant
    not present _ isa evening,
    not present _ isa night,
    not present _ isa date,
    not present _ isa weekday,  %% hverdager means general (other) day

    not _ isa Day when { dmeq(mtwtfss, Day)},

    not present srel/this_prenoon/time/nil/_,
    not present srel/in_prenoon/time/nil/_,
    not present srel/in_morning/time/nil/_,
    not present srel/early/time/nil/_,
    not present srel/in_day/time/nil/_,
    not present srel/tomorrow/_/_/_,   %% then explicit
    not present srel/today/_/_/_,
    not present srel/tonight/_Daypart/nil/_,
    not present srel/this_midnight/time/nil/_,

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

    finddate(1,DATE),
    dayModSeqNo(DATE,DaySeqNo) ).

%%%% TA-101025


anight rule bustrans:( %%  buss går  mellom klokka 6 og 7 om kvelden
is  present _ isa night,
    not _B isa morning,
    not srel/this_midnight/time/nil/_,
    replaceall ( Six isa clock, srel/Prep/Clock/Six/D)
    with       ( Eighteen isa clock,srel/Prep/time/Eighteen/D) % time is standard
id  not flag(nightbusflag)
ip  dmeq(clock,Clock),evening_time(Six,Eighteen) ).



tonightat6 rule bustrans:( %%  buss går  mellom klokka 6 og 7 om kvelden
is  present srel/IE/time/nil/D, { dmeq(pm,IE)}, %% use it twice
    not _B isa morning,
    not srel/this_midnight/time/nil/_,
    replaceall ( Six isa clock, srel/Prep/Clock/Six/D)
    with       ( Eighteen isa clock,srel/Prep/time/Eighteen/D) % time is standard
id  []
ip  dmeq(clock,Clock),evening_time(Six,Eighteen) ).


inconsistenttimes rule bustrans:( %% before 1100 and after 1200  ( 2300 - 0100 ? )
                       %% After notatnight b.o. temporary inconsistency
is  not present srel/back/place/nil/_,
    srel/after/time/X/_, srel/before/time/Y/_,
    not X isa minute, %% ad hoc
    not Y isa minute, %% 10 minutes before
    clear
id  clear,
    add  message(inconsistenttimes),
    add flag(exit)
ip  number(X),number(Y), X > Y ).


neighbourstreetonplace rule bustrans:( %% neighbour street on place
is  replaceall (Byåsen isa neighbourhood,srel/TO/place/Otto_S_street/A,
                Otto_S_street isa STREET,srel/on/place/Byåsen/A)
    with   (Otto_S_street isa STREET,srel/TO/place/Otto_S_street/A)
id  []
ip  dmeq([street],STREET) ). %% e.g. not meeting,station




gotoheaven rule bustrans:( %% for å være på
is  srel/in_order_to/_/_/_,
    not srel/to/_/_/_   ,     %% NOT already a to place
    replaceall ( (do)/be1/I/E, I isa Self, srel/INON/Place/PS/E)
    with       ( (do)/go/I/E,  I isa Self, srel/to/Place/PS/E)
id  []
ip  dmeq([self,agent],Self),
    dmeq(at,INON),
    dmeq(place,Place) ).


liveinhell rule bustrans:( %% means going from
is  %% new, %%  context    (I isa self), %% når jeg bor i %% TA-110825
    %% not srel/in_order_to/_/_/_,          %% related to be1
    not dob/want/_/that/_,
    replaceall (  (do)/live/I/E, srel/_On/place/PS/E)  %% E in/N on
    with       (  (do)/go/I/E,  srel/from/place/PS/E)  %% TA-110225
                           	 %% NOT NEUTRAL
id  []
ip  [] ).


fetch rule bustrans:(  % Fetching cars is very relevant %% after liveinhell
is  replaceall (fetch/I/A/E, I isa self,A isa _Car,srel/AtOn/place/NAF/E)
    with       (I isa self,(do)/go/I/E, srel/to/place/NAF/E)
id  []
ip  dmeq([at,on],AtOn) ). %% not from, destroys go from if live on // Intricate!


nobustohell0 rule bustrans:( %% TA-100910  never NP-mod reach train|to oslo
is  context ('I' isa self,dob/reach/'I'/A/E),
    replaceall (srel/to/place/Oslo/E,A isa Train,Oslo isa Neigh )
    with       (A isa Train)
id  []
ip  dmeq([plane,boat,train],Train),
    dmeq([city,neighbourhood],Neigh) ). %% oslo changed from neigh. to city

nobustohell1 rule bustrans:( % ignore where train goes to
is  replaceall ((do)/go/A/E,srel/to/place/Oslo/E,A isa Train,Oslo isa Neigh )
    with       (A isa Train)
id  []
ip  dmeq([plane,boat,train],Train),
    dmeq([city,neighbourhood],Neigh) ). %% oslo changed from neigh. to city

nobustohell2 rule bustrans:( % ignore where train is to
is  replaceall ((do)/be1/A/E,srel/to/place/Oslo/E,A isa Train,Oslo isa Neigh )
    with       (A isa Train)
id  []
ip  dmeq([plane,boat,train],Train),
    dmeq([city,neighbourhood],Neigh) ). %% oslo changed from neigh. to city


reachtrain rule bustrans:( % nå et tog %%  there are several train stations ?   %% (KME)
is  not present ts isa _,  %% already mentioned -> mess sameplace
    replaceall  (C isa self,D isa train,dob/TAKE/C/D/E)
    with        (C isa self,ts isa neighbourhood,
                 (do)/go/C/E, srel/to/place/TS/E) %% AtB
id  []
ip  dmeq(take,TAKE),
    railway_station(TS) ). %% AtB


reachboatthatleaves rule bustrans:(  % nå en båt som går/er 1215 fra PT
is  replaceall  (C isa self,D isa boat,dob/TAKE/C/D/E,srel/Nil/time/HHMM/K,srel/from/place/PT/K, (do)/Go/D/K)
    with        (C isa self,(do)/go/C/E,srel/before/time/HHMM/E,srel/to/place/PT/E),
    {dmeq([go,be1],Go)},
    {dmeq([nil,after,before],Nil)} %% after clocksequence
id  []
ip  dmeq(take,TAKE) ).


reachbusthatleaves rule bustrans:(  % nå en buss   som går 1215 FRA PT
is   replaceall  (C isa self,D isa bus,dob/reach/C/D/E,srel/Nil/time/HHMM/K,srel/from/place/PT/K,(do)/Go/D/K)
    with        (C isa self,(do)/go/C/E,srel/before/time/HHMM/E,srel/to/place/PT/E),
    {dmeq([go,be1],Go)},
    {dmeq([nil,after],Nil)}
id  []
ip  [] ).  %%   vi tar bussen fra risvollan kl 19. \=  vi rekker bussen fra risvollan kl 19.



%%%% After reachtrainthatleaves
notabusnotmn rule bustrans:( %% AFTER nobustohell boat,plane  no tmnflag
is  (_NotBus isa BR),
    { dmeq([airplane,train,train_route_plan,boat],BR)}, %tram,  %% RS-15-0415
    not present _ isa clock, %% den (klokka) er 1.
    clear
id  clear,
    add message(noinfoabout(BR))
ip  \+ value(tmnflag,true) ).


ankomme rule bustrans:(  %% NB after reachtrain  %% Norwagism %% ankomme (reach) = gå til
is  context    S isa Place,
    not        srel/to/place/_/_,
    replaceall (dob/reach/B/S/E)
    with       ((do)/go/B/E,srel/to/place/S/E)
id  []
ip  dmeq(place,Place) ).

beavailable rule bustrans:(
is  replaceall (A isa BR,adj/_/available/A/C)
    with       (A isa BR,(do)/go/A/C)
id  []
ip  dmeq(bus,BR) ).


witharrival rule bustrans:(
is  present X isa STAT,
    replaceall  srel/(with)/arrival/X/Y %% X is not a time !!!
    with        srel/to/place/X/Y

id  []
ip  dmeq([station,neighbourhood],STAT) ).


contain rule bustrans:(  %%  ( NB   takes both  Subj/OBj and Obj/Subj
is  replaceall  ( contain/A/Midtbyen/B)
    with        ( (do)/be1/Midtbyen/B, srel/in/place/A/B )
id  []
ip  bound(Midtbyen) ).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


firsthour rule bustrans:(  %% firstminutes rule ???
is replaceall (B isa hour,adj/_/first/B/_,srel/nil/hour/B/D)
   with       (B isa hour,srel/within/hour/B/D)
id []
ip [] ).


everynthminute rule bustrans:(
is A isa minute,adj/_/Tenth/A/real,
       not present srel/in/time/_/_, %% ask for time
    clear
id  clear,
    add message(noinfoabout(frequency))
ip  ordinal(Tenth,_) ).


often rule bustrans:(  % how often
is  srel/often/time/nil/_,
    not present srel/last/_/_/_,  %% often late
    clear
id  clear,
    add message(noinfoabout(frequency))
ip  [] ).



eachhour rule bustrans:( % "each hour"  means "how often"
is  context
     (howmany(F1), F1 isa bus, F3 isa hour, event/real/F2, srel/IN/time/F3/F2 ),
    replaceall (howmany(F1),F3 isa hour,srel/IN/time/F3/F2)
    with       (which(F0),  srel/(with)/frequency/F0/F2)
id []
ip dmeq(intime,IN),newfree(F0) ).


goon rule bustrans:(  % Go on means take
is  context  (I isa self,B isa BUS1),
    replaceall  ((do)/Go/I/E,srel/ONOFF/BUS2/B/E)
    with        (dob/take/I/B/E)
id  []
ip  dmeq(onoff,ONOFF),dmeq([bus,nightbus,route],BUS1),dmeq([bus,nightbus,route],BUS2),
    dmeq([go,think,wonder],Go) ).  %% Facetious ???

ident1  rule bustrans:(
is  present test,comp/_Clock/eq/X/X
id  not message(onlyonesentence),
    add true %% Yes is added
ip  [] ).

ident2  rule bustrans:(
is  present test,dob/be/X/X/_
id  not message(onlyonesentence),
    add true %% Yes is added
ip  [] ).


areyouwhator rule bustrans:( % are you a man  or a computer
is  test,tuc isa savant,dob/be/tuc/(_;_)/_,clear
id  not message(onlyonething),
    add  message(onlyonething),
    add flag(exit)
ip  [] ).

areyouamachinenow  rule bustrans:( %% TA-100927
is  test,(tuc isa savant,dob/be/tuc/A/B,A isa S,event/real/B)
id  not message(onlyonesentence),
    add true %% Yes is added
ip  dmeq([program,computer,oracle,savant],S) ).


areyouwhatyes0 rule bustrans:( % are you a program 1 %% er du en maskin da %% TA-100927
is  test,Tuc isa savant,Tuc isa Man,event/real/_
id  not message(onlyonesentence),
    add true %% Yes is added
ip  dmeq([program,computer,oracle],Man) ).


areyouwhatyes1 rule bustrans:( % are you a program 2
is  exactly (test,Tuc isa savant,dob/be/Tuc/A/B,A isa Man,event/real/B )
id  not message(onlyonesentence),
    add true %% Yes is added
ip  dmeq([program,computer,oracle],Man) ).

areyouwhatyes2 rule bustrans:(
is  test,Tuc isa savant,dob/be/Tuc/A/_, event/real/E,adj/nil/correct/_/E,A isa Man
id  not message(onlyonesentence),
    add true %% Yes is added
ip  dmeq([program,computer,oracle],Man) ).


youarewhatyes1 rule bustrans:(
is  new,tuc isa savant,dob/be/tuc/A/B,A isa Man,event/real/B,
    not adj/nil/bad/A/_  %% dårlig :-( %% TA-101222
id  not message(onlyonesentence),
    add true %% Yes is added
ip  dmeq([program,computer,oracle],Man) ).


areyouwhatno0 rule bustrans:(  %%  are you a girl 1
is  exactly (test,Tuc isa savant,Tuc isa Man,event/real/_ )
id  not message(onlyonesentence),
    add false %% No is added
ip  \+ dmeq([program,computer,oracle,friend],Man) ). %% are you my friend->no

areyouwhatno1 rule bustrans:( %%  are you a girl 2
is  test, Tuc isa savant, dob/be/Tuc/A/B, A isa Man, event/real/B
id  not message(onlyonesentence),
       {\+ dmeq([thing],Man)}, %%"er du det" %% TA-110103
    add false %% No is added
ip  \+ dmeq([program,computer,oracle,system,friend],Man) ). %% not agent

areyouwhat1 rule bustrans:( % are you busstuc 1
is  exactly (test,Tuc isa savant,event/real/_ )
id  add  true %% Yes is added
ip  dmeq([busstuc,bustuc,tuc],Tuc) ).

areyouwhat2 rule bustrans:( % are you busstuc 1
is  test,(tuc isa C,event/real/_),
    not adj/_/_/_/_           %% yellow computer
id  add  true %% Yes is added
ip  dmeq([oracle,computer,robot],C) ).  %% etc.

areyouwhat3 rule bustrans:( % are you an oracle
is  test,(tuc isa savant,tuc isa C,event/real/_),
    not adj/_/_/_/_           %% yellow computer
id  add  true %% Yes is added
ip  dmeq([oracle,computer,robot],C) ).  %% etc.

areyouwhat4 rule bustrans:(
is  test,(bustuc isa savant,bustuc isa C,event/real/_),
    not adj/_/_/_/_           %% yellow computer
id  add  true %% Yes is added
ip  dmeq([oracle,computer],C) ).  %% etc.



isitwhat1 rule bustrans:(
is  test,(Two isa route,Two isa bus,event/real/_), %% Ad hoc
    not adj/_/_/_/_           %% yellow bus
id  add  true %% Yes is added
ip  [] ).

isitwhat2 rule bustrans:(
is  test,(CS isa station,CS isa neighbourhood,event/real/_), %% Ad hoc
    not adj/_/_/_/_           %% yellow bus
id  clear, add  true %% Yes is added
ip  bound(CS),
    station(CS),
    neighbourhood(CS) ).


isitwhat3 rule bustrans:(
is  exactly (test, dob/be/Two/F5/E, Two isa route, F5 isa Bus,  event/real/E)
id  clear, add  true,
    add flag(exit) %% %% Yes is added
ip  bound(Two),Two \== it, %%   Is this a joke  :-)
    vehicletype(Two,Bus) ).


isitwhat4 rule bustrans:(
is  exactly (test,Trondheim isa City,event/real/_)
id  add  true %% Yes is added
ip  bound(Trondheim),Trondheim \== it, %%   Is this a joke  :-)
    bound(City),
    dmeq([city,station],City) ). %% NOT holiday !!!



languageyes1 rule bustrans:(  %%  snakke på
is  not which(_),
    L isa language,
    speak/TUC/E,
    srel/ION/language/L/E,
    not  present explain,
    not present adj/_/only/L/_
id  add true
ip  dmeq([in,on],ION),
    dmeq([tuc],TUC),  %% I speak = May I speak
    dmeq([norsk,bokmål,english],L) ).


languageyes2 rule bustrans:( % may I speak = you speak
is  not which(_),
    L isa language,
    dob/Understand/TUC/L/_, %% not speak
    not present explain,
    not present adj/_/only/L/_
id  add true
ip  dmeq([speak,talk,understand,know,know1,write],Understand), %% TA-100905
    dmeq(['I',tuc],TUC),  %% I speak = May I speak
    dmeq(knownlanguage,L) ).


languageand rule bustrans:(
is  not which(_),
    L isa language,
    dob/Understand/TUC/(_,_)/_, %% N and E
    not present explain,
    not present adj/_/only/L/_
id  add message(onlyonething)
ip  dmeq([speak,talk,understand,know,know1],Understand),
    dmeq(['I',tuc],TUC),  %% I speak = May I speak
    dmeq(knownlanguage,L) ).

languageor rule bustrans:(
is  not which(_),
    L isa language,
    dob/Understand/TUC/(_;_)/_, %% N or E
    not present explain,
    not present adj/_/only/L/_
id  add message(onlyonething)
ip  dmeq([speak,talk,understand,know,know1],Understand),
    dmeq(['I',tuc],TUC),  %% I speak = May I speak
    dmeq(knownlanguage,L) ).


languageyes3 rule bustrans:(
is  L isa language,Quest isa question, dob/ask/_I/Quest/_,srel/on/language/L/A,event/real/A,
    not present explain
id  add  true %% message(yes)
ip  L isa language,
    dmeq(knownlanguage,L) ).


languageyes4 rule bustrans:(
is  L isa language,dob/ask/_I/_,srel/on/language/L/A,event/real/A,
    not present explain
id  add  true %%  message(yes)
ip  L isa language,
    dmeq(knownlanguage,L) ).


languageno1 rule bustrans:(
is  tuc isa savant,L isa language,dob/SPEAK/tuc/L/A,event/real/A,
    not present explain
id  add  false
ip  dmeq(speak,SPEAK), L isa language,
    (L isa language) ). %% dmeq(knownlanguage,L).


languageno2 rule bustrans:(
is  tuc isa savant,nynorsk isa language,tell/tuc/A,event/real/A,
   not present explain
id  add  false % message(no)
ip  [] ).


languageno3 rule bustrans:(
is  I isa self,L isa language,(do)/ASK/I/A,srel/_/language/L/A,event/real/A,
    not present explain
id  add  false % message(no)
ip  dmeq([ask],ASK), L isa language,
    \+ dmeq(knownlanguage,L) ).


reply rule bustrans:(
is  reply(H)
id  add message(answer(write(H))),
    add flag(exit)
ip  [] ).


replyq rule bustrans:(
is  replyq(H)
id  add replyq(H),
    add flag(exit)
ip  []
     ):- single.


corresponding0 rule bustrans:( %% reach (last) bus 63    %% TA-110121 RRONTED
is  present Bus isa route,dob/reach/'I'/Bus/_ %% befor onlyonebus..
id	 addcon message(nocorresponse),
    add flag(exit) %
ip  [] ).


corresponding1 rule bustrans:( %% corresponding buses
is  present Bus isa bus,adj/_/corresponding/Bus/_
id	 addcon message(nocorresponse),
    add flag(exit) % ?
ip  [] ).

corresponding2 rule bustrans:( %% wait for bus
is  present Bus isa bus,(do)/wait/Bus/_
id	 addcon message(nocorresponse),
    add flag(exit) % ?
ip  [] ).

corresponding4 rule bustrans:(  %% I change (bus)
is  (do)/change/'I'/_
id	 addcon message(nocorresponse),
    add flag(exit) % ?
ip  [] ).

corresponding5 rule bustrans:( %% bus correspond
is  present _Bus isa BR, (do)/correspond/_Buses/_ %% TA-100903
id	 addcon message(nocorresponse),
    add flag(exit) % ?
ip  dmeq(busdeparr,BR) ).
onlyonebusreach rule bustrans:(
is  dob/reach / (_ ,_)/_ / _ ,
    clear %%  Når Rute 3 og 4 Ringve skole  %% Anomaly
id  add message(answer(bcpbc(onlyonebus)))
ip  [] ).

onlyonebusgo rule bustrans:(
is  (do)/go/(X,_)/_,
    present  X isa BUS %%  når går buss 5 og 66 t dragvoll.
id  add message(answer(bcpbc(onlyonebus)))
ip  dmeq(bus,BUS) ).


onlyonebuspass rule bustrans:(
is  (do)/pass/(X,_)/_, X isa BUS
id  add message(answer(bcpbc(onlyonebus)))
ip  dmeq(bus,BUS) ).


onlyonebus1or rule bustrans:(   %%  etc
is  (do)/go/(X;_)/_ ,  X isa BUS %%  a or b or c
id  add message(answer(bcpbc(onlyonebus)))
ip  dmeq(bus,BUS) ).

onlyonebuspassor rule bustrans:(
is  (do)/pass/(X;_)/_ ,X isa BUS
id  add message(answer(bcpbc(onlyonebus)))
ip  dmeq(bus,BUS) ).

onlyonebuspass2or rule bustrans:(
is  dob/pass/(X;_)/_/_,  X isa BUS
id  add message(answer(bcpbc(onlyonebus)))
ip  dmeq(bus,BUS) ).

onlyonebus3 rule bustrans:(
is  srel/_/_/(X,_)/_ , X isa BUS
id  not message(nocorresponse), %% TA-110121
    add message(answer(bcpbc(onlyonebus)))
ip  dmeq(bus,BUS) ).

onlyonebus4 rule bustrans:(
is  has/BUS1/departure/(X,_)/_ ,X isa BUS
id  add message(answer(bcpbc(onlyonebus)))
ip  dmeq(bus,BUS),dmeq(bus,BUS1) ).


onlyonebus5 rule bustrans:(
is  dob/take/_/(X,_)/_ , X isa BUS
id  add message(answer(bcpbc(onlyonebus))),
    add flag(exit)
ip  dmeq(bus,BUS) ).

onlyonebus5or rule bustrans:(
is  dob/take/_/(X;_)/_ , X isa BUS
id  add message(answer(bcpbc(onlyonebus))),
    add flag(exit)
ip  dmeq(bus,BUS) ).


%

arriveandison rule bustrans:( %% arrive  NTH  and ... to TV
is  context (I isa self, (do)/arrive/I/E,srel/nil/place/TV/E, NTH isa Station ),
    { (NTH \== TV)},
    replaceall ((do)/be1/I/D,event/real/D,srel/OTAN/place/NTH/D)
     with      ((do)/go/I/D, event/real/D,srel/from/place/NTH/D)
id  []
ip  dmeq(nato,OTAN),dmeq(place,Station) ).

isalreadyon rule bustrans:( %% is on NTH  and ... to TV
is  context (I isa self, srel/to/place/TV/_ , NTH isa Station ),
    { NTH \== TV, \+ placestat(NTH,TV),\+ placestat(TV,NTH)},
    replaceall ((do)/be1/I/D,event/real/D,srel/OTAN/place/NTH/D,srel/PREP/TIME/T/D)
     with      ((do)/go/I/D, event/real/D,srel/from/place/NTH/D,srel/PREP/time/T/D)
id  []
ip  dmeq(nato,OTAN),dmeq(place,Station),
    dmeq(time,TIME) ).


haho0 rule bustrans:( %%   before hm1
is  replaceall (A isa hour,adj/_/half/A/_)
    with       (A isa halfhour)
id  []
ip  [] ).

%%%% Convert hours to minutes once and forall



hm0 rule bustrans:( %%  N  hours
is  replaceall (quant(eq/N, Hours), Hours isa hour,      srel/Within/HOUR/Hours/E)
    with       (Minutes isa minute,  srel/Within/minute/Minutes/E)
id  []
ip  dmeq(hour,HOUR),unbound(Hours),Minutes is 60*N ).


hm1 rule bustrans:( %%  an hour
is  replaceall (Hours isa hour,      srel/Within/HOUR/Hours/E)
    with       (Minutes isa minute,  srel/Within/minute/Minutes/E)
id  []
ip  dmeq(hour,HOUR),unbound(Hours),Minutes is 60 ).


hm2 rule bustrans:(
is  replaceall (Hours isa hour,      srel/Within/HOUR/Hours/E)
    with       (Minutes isa minute,  srel/Within/minute/Minutes/E)
id  []
ip   dmeq(hour,HOUR),number(Hours),
     Minutes is integer(Hours*60) ).


haho1 rule bustrans:( %%  halfhour to minutes
is  replaceall (Halfhours isa halfhour, srel/Within/HOUR/Halfhours/E)
    with       (Minutes isa minute,     srel/Within/minute/Minutes/E)
id  []
ip  dmeq(hour,HOUR),unbound(Halfhours), Minutes is 30 ).

haho2 rule bustrans:( %%  n  halfhours  to minutes
is  replaceall (Halfhours isa halfhour,    srel/Within/HOUR/Halfhours/E)
    with       (Minutes isa minute,        srel/Within/minute/Minutes/E)
id  []
ip   dmeq(hour,HOUR),number(Halfhours),Minutes is Halfhours*30 ).



qm1 rule bustrans:( %%   quarter to minutes
is  replaceall (Quarters isa quarter,      srel/Within/QUARTER/Quarters/E)
    with       (Minutes isa minute,  srel/Within/minute/Minutes/E)
id  []
ip  dmeq(quarter,QUARTER),unbound(Quarters),Minutes is 15 ).

qm2 rule bustrans:( %%  quarters to minutes
is  replaceall (Quarters isa quarter,      srel/Within/QUARTER/Quarters/E)
    with       (Minutes isa minute,  srel/Within/minute/Minutes/E)
id  []
ip   dmeq(quarter,QUARTER),number(Quarters),Minutes is Quarters*15 ).


whichisbe2  rule bustrans:( %%    Hvor ligger bussholderplassen som heter Tyholt?
is  replaceall (which(A),Tyholt isa station,B isa station,A isa place,event/real/C,dob/be/B/Tyholt/C,(do)/be1/B/D,srel/in/place/A/D,event/real/D)
    with       (which(A),Tyholt isa station,B isa station,A isa place,event/real/C,
    (do)/lie1/Tyholt/D,srel/in/place/A/D,event/real/D) %% TA-110503
id  []
ip  [] ).

whichisnamed  rule bustrans:( %%    Hvor ligger bussholderplassen som heter Tyholt?
is  replaceall (which(A),Tyholt isa station,B isa station,A isa place,event/real/C,dob/be_named/B/Tyholt/C,(do)/be1/B/D,srel/in/place/A/D,event/real/D)
    with       (which(A),Tyholt isa station,B isa station,A isa place,event/real/C,
    (do)/lie1/Tyholt/D,srel/in/place/A/D,event/real/D)
id  []
ip  [] ).




%%%%%%  SMALLTALK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Statements that obviously challenge the system

life42 rule bustrans:( %% What is the meaning of life
is  which(A),(has/life/meaning/B/A,A isa meaning,B isa life)
id  add message(answer(bcp(42)))
ip  [] ).

life43 rule bustrans:(
is  which(A),(has/life/meaning/B/A,A isa meaning,B isa liff)
id  add message(answer(bcp(43)))
ip  [] ).

life421 rule bustrans:(
is  not explain,
    srel/_/_Thing/L/_E, _M isa meaning, L isa life, %% TA-101013
    clear
id  clear,
    add flag(exit),
    add message(answer(bcp(42)))
ip  [] ).

life422 rule bustrans:(
is  test,42 isa meaning,F1 isa life,(do)/be1/42/F2,event/real/F2,
    srel/(with)/thing/F1/F2
id  add true
ip  [] ).

life423 rule bustrans:(
is  test, has/life/meaning/B/A, A isa meaning, B isa life
id  add message(answer(bcp(42))),
    add flag(exit)
ip  [] ).


whatis1 rule bustrans:(  %%  what is D means describe D
is  exactly (which(X),X isa Y, event/real/_)
id  add message(answer((bcpbc(D))))
ip  \+ value(teleflag,true),
    bound(X), X \== it,
    \+ dmeq([answer,clock, departure, self, time],Y),
    description(X,D) ). %% NB X (?)


whatis2 rule bustrans:(  %% hvem er (det som er) tagore:... X er tagore
is  which(A),A isa agent,dob/be/A/X/B,X isa D,event/real/B
id  add message(answer(bcpbc(D))),
    add flag(exit)
ip  \+ value(teleflag,true),
    bound(X),
    X \== it, X \== tuc,
    \+ dmeq([answer,clock,departure,self,time],D) ).

whatis2b rule bustrans:(  %% hvem er tagore:.. tagore er X %% TA-101230
is  which(A),A isa agent,dob/be/X/A/B,X isa D,event/real/B
id  add message(answer(bcpbc(D))),
    add flag(exit)
ip  \+ value(teleflag,true),
    bound(X),
    X \== it, X \== tuc,
    \+ dmeq([answer,clock,departure,self,time],D) ).

whoareyou0 rule bustrans:( %% hvem er du
is  which(A),(dob/be/tuc/A/B,tuc isa savant,A isa Agent,event/real/B),
    {fernando:subclass0(Agent,agent)}, %% TA-110615
    clear
id  clear,
    add(message(answer((bcpbc(bustuc))))),
    add flag(exit)
ip  TUC \== bustuc, dmeq(tuc,TUC) ).


whoareyou1 rule bustrans:( %% hvem er du
is  which(TUC),(tuc isa savant,event/real/_),
    clear
id  clear,
    add(message(answer((bcpbc(bustuc))))),
    add flag(exit)
ip  TUC \== bustuc, dmeq(tuc,TUC) ).

whoareyou2 rule bustrans:( %% hva er ditt navn
is  has/agent/name/B/A,B isa savant,A isa name, %% TA-110609
    clear
id  clear,
    add(message(answer( bcpbc(bustuc) ))),
    add flag(exit)
ip  [] ).

whoareyou3 rule bustrans:(
is  not explain, %% which(A), %% heter du tore
    (dob/be_named/tuc/_A/_),
    clear
id  clear,
    add(message(answer(bcpbc(bustuc)))),
    add flag(exit)
ip  [] ).

whoareyou3b rule bustrans:( %% hva kalles du
is  not explain, %% which(A), %% heter du tore
    (dob/name/_/tuc/_),
    clear
id  clear,
    add(message(answer(bcpbc(bustuc)))),
    add flag(exit)
ip  [] ).


whoareyou4 rule bustrans:(
is  which(tuc),(tuc isa savant,event/real/_),
    clear
id  clear,
    add(message(answer(bcpbc(bustuc)))),
    add flag(exit)
ip  [] ).    %% Special because 'tuc isa savant'
           %% is a truncated doublette

whoareyou5 rule bustrans:(
is  which(A),(A isa Oracle,event/real/_),
    {dmeq([oracle,service],Oracle)},
    clear
id  clear,
    add(message(answer(bcpbc(bustuc)))),
    add flag(exit)
ip  [] ).

whoareyou7 rule bustrans:( %% repair  which agent is you
is   which(A), BT isa program,A isa agent,event/real/B,dob/be/A/BT/B,
     clear
id   clear,
     add message(answer(bcpbc(bustuc))),
     add flag(exit)
ip   dmeq([bustuc,busstuc,tuc,smstuc],BT) ).


whatisnamed1  rule bustrans:( %%   Hva heter Tagore -> Tagore % after whoareyou
is  which(A),dob/be_named/A/B/_C, { atom(B)} %% bound(B)}
id  add reply(B)
ip  [] ).

whatisnamed2  rule bustrans:( %%   Hva heter du ???
is  which(A),dob/be_named/B/A/_C, { atom(B)}, %% { bound(B)},
    not _ isa self
id  add reply(B)
ip  [] ).

whatisyourname  rule bustrans:( %%  hva er ditt navn
is  which(X),X isa name,tuc isa savant,has/agent/name/tuc/X
id  add message(answer(bcpbc(bustuc)))
ip  [] ).

isbustucyourname  rule bustrans:( %%  er busstuc ditt navn ?
is  test,X isa name,tuc isa savant,has/agent/name/tuc/X
id  add message(answer(bcpbc(bustuc)))
ip  [] ).


whoareyou rule bustrans:(  %% Who are you
is  which(A),
    Marvin isa Robot, {dmeq([tuc,bustuc],Marvin)},
    A isa agent,
    event/real/B,dob/be/A/Marvin/B,
    not present has/_Agent/_Leader/_Tuc/_ %% hvem er din sjef  *-> leder
id  add message(answer(bcpbc(bustuc)))
ip  bound(Marvin), %% hvem er konge -> Konge ***
    \+ value(teleflag,true),
    \+ dmeq([self,creator,programmer,person],Robot) ). %% "selv"

whois1 rule bustrans:(  %%  who  is D (which agent is such that A is D)
is  which(A),Marvin isa Robot,A isa agent,event/real/B,dob/be/A/Marvin/B,
    not present has/_Agent/_Leader/_Tuc/_ %% hvem er din sjef  *-> leder
id  add message(answer((bcpbc(Robot))))
ip  bound(Marvin), %% hvem er konge -> Konge ***
    \+ value(teleflag,true),
    \+ dmeq([self,creator,programmer,person],Robot) ). %% "selv"


eat rule bustrans:( %% allowed to eat on bus :-)
is  eat/_/_/_ ,
    clear
id  clear,
    addfront(message(nofoodonbus)),
    add flag(exit)
ip  [] ).


noinfoaboutstrike rule bustrans:(
is  strike/_/_
id  clear,
    addfront(message(noinfoabout(strike)))
ip  [] ).


noinfoaboutgenerics rule bustrans:( %% sunndalsøra helsestasjon
is  X isa place, {generic_place(X)},
    clear
id  clear,
    addfront(message(noinfoaboutname(X)))
ip  [] ).


summerwinter rule bustrans:( %%  hvor lenge gjelder bussrutene?
is   A isa duration,B isa route,(do)/apply/B/C,srel/(with)/duration/A/C,event/real/C
id  addfront(message(summerishere)),
    addfront(message(winterishere))
ip  [] ).

summer1 rule bustrans:( %%  sommeruter til A %% after weather
is   replaceall (X isa summerroute)
     with       (X isa route)
     ,clear %% dont give todays route
id   addfront(message(summerishere))
ip  [] ).

summer2 rule bustrans:( %% om sommeren
is  _ isa summer ,clear %% dont give todays route
id                clear,
    addfront(message(summerishere))
ip  [] ).


winter1 rule bustrans:(  %% when is winterroutes
is   replaceall (X isa winterroute)
     with       (X isa route)
 %%%    ,    clear    %% ?
id   addfront(message(winterishere))
ip  [] ).


winter2 rule bustrans:(  %% %% when is winter
is  _ isa winter,clear
id   not flag(exit), %% snø i vinter
     clear,addfront(message(winterishere))
ip  [] ).


whereis rule bustrans:( %% hvorfor finnes busstuc
is  explain,Bustuc isa savant,(do)/be1/Bustuc/E,event/real/E
id  add  message(howtuchelp)
ip  dmeq(tuc,Bustuc) ).


whyareyouhere rule bustrans:( %% hvorfor er du her ?
is  explain,(do)/be1/tuc/A, srel/HOME/PLACE/nil/A %% why are you here
id  addfront message(howtuchelp)
ip  dmeq(where,HOME),dmeq([place],PLACE) ).

whyareyoumade rule bustrans:( %% why are you made ?
is  explain,adj/_/make/tuc/_
id  addfront message(howtuchelp)
ip  [] ).


maker rule bustrans:(  %% hvem er din skaper
is  which(A),A isa programmer,tuc isa savant, _ isa agent,has/agent/agent/tuc/A,
    clear  %% not negans
id  add (message(tagore),
         flag(exit))
ip  [] ).


responsible rule bustrans:(  %% hvem er ansvarlig for deg ? %% TA-110120
is  which(A),A isa agent,Tuc isa savant, adj/nil/responsible/A/E,srel/for/thing/Tuc/E
id  add message(tagore)
ip  dmeq([tuc,bustuc,it],Tuc) ).


made1 rule bustrans:(  %% når ble du/dette laget
is  which(T),T isa time, dob/make/_/Tuc/_ ,
    clear  %% not negans
id  add message(idonotknow)
ip  dmeq([tuc,bustuc,it],Tuc) ).


made2 rule bustrans:(  %% hvem laget deg/dette
is  which(_), %% hvem er du laget av %% TA-110128
    dob/Make/A/Tuc/_ , {dmeq([make,write],Make)},
    A isa Agent,                 {dmeq([agent,person],Agent)},
    not _ isa day, %% etc  :-)
    not present srel/_/day/nil/_,
    clear %% not negans
id  add (message(tagore),
         flag(exit))
ip  dmeq([tuc,busstuc,bustuc,it],Tuc) ).


madenoun1 rule bustrans:( %% hvem laget deg
is  which(A),
    A isa agent, dob/make/A/Tuc/_, Tuc isa Oracle,
    not _ isa day, %% etc  :-)
    not present srel/_/day/nil/_,
    not srel/nil/coevent/_/_ ,
    not srel/in/_/_/_
id  add message(tagore)
ip  dmeq([program,oracle,service],Oracle) ).


madenoun2 rule bustrans:( %% laget T deg ?
is  test,
    dob/make/A/Tuc/_,  A isa Agent,Tuc isa Oracle,
    not _ isa day, %% etc  :-)
    not srel/nil/coevent/_/_ ,
    not srel/in/_/_/_ ,
    not srel/on/_/_/_ , %% etc
    not srel/_/day/nil/_
id  add message(tagore)
ip  fernando:subclass0(Agent,agent),
    dmeq([program,oracle,service,savant],Oracle) ).


made3 rule bustrans:( % hvem er du laget av
is  A isa agent,adj/_/make/Tuc/_, Tuc isa Oracle,     %% made as Adj
    srel/by/agent/A/_ ,
    not srel/nil/coevent/_/_,
    not srel/in/_/_/_
id  add message(tagore)
ip  dmeq([program,oracle,service],Oracle) ).


purp rule bustrans:( %% meningen med deg %% TA-110607
is  _ isa purpose,srel/of/thing/_Tuc/_
id  addfront message(howtuchelp)
ip  [] ).


meaning rule bustrans:(
is  has/agent/Meaning/tuc/_, {dmeq([meaning,purpose],Meaning)} %% TA-110606
id  addfront message(howtuchelp)
ip  [] ).

it1 rule bustrans:( %% Hva er dette ?
is  exactly (which(it),true)
id  addfront message(howtuchelp)
ip  [] ).

whytuc rule bustrans:(
is  explain,(do)/be1/tuc/_   %% why are you here
id  addfront message(howtuchelp)
ip  [] ).

work1 rule bustrans:(
is  which(A),(tuc isa savant,work/tuc/B,srel/(with)/thing/A/B)
id  addfront message(howtuchelp)
ip  [] ).


thanks1 rule bustrans:( %% Acknowledge praise
is  (A isa self,adj/_/impressed/A/_)
id  add message(answer((bcpbc(thanks))))
ip  [] ).


%%%END OF SMALLTALK%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


stationonneib0 rule bustrans:( %% fra holdeplassen på Gløshaugen %% TA-100910
is  replaceall (srel/From/place/F2/F4,srel/on/neighbourhood/Gløshaugen/F4)
    with       (srel/From/place/Gløshaugen/F4),
        {unbound(F2)}
id  []
ip  [] ).


stationonneib rule bustrans:( %%  holdeplassen på Risvollan=Risvollan
is  present Risvollan isa neighbourhood ,
    replaceall (srel/Prep/place/B/E, nrel/ONAT/station/_Neib_/B/Risvollan)
    with        srel/Prep/place/Risvollan/E
id  []
ip  dmeq([on,at,near,in],ONAT) ).




stationoneigh0 rule bustrans:( %%  til  Markaplassen ved Vikåsen (neib)
is  present srel/to/place/M/E,  %%  Haz ? not nil
    M isa station,
    V isa neighbourhood,
    remove  srel/at/place/V/E %% university at gløshaugen
id  []
ip  [] ).

stationoneigh2 rule bustrans:( %% station on neighbourhood is a special case ( touchy)     %% RS-130625 Disable for summer routes?
is  replaceall ( srel/on/neighbourhood/lade/B )
    with       ( srel/near/place/lade/B )
id  []
ip  [] ).


stationonstat rule bustrans:( %% Markaplassen på Vikåsen (stat)
is  present srel/to/place/M/E,
    M isa station,
    V isa station,
    remove  srel/on/place/V/E
id  []
ip   V isa neighbourhood ). %% also %

 % % % % % % PART OF DAY rule bustrans:(S

midday rule bustrans:(
is  replaceall (B isa day, srel/around/time/B/E)
    with       (srel/around/time/1200/E)
id  []
ip  [] ).


daypart rule bustrans:(
is  replaceall (has/daypart/bus/B/C,  B isa evening)
    with       (srel/tonight/time/nil/C)
id  []
ip  [] ).


night18 rule bustrans:( % bus sunday night MEANS bus after at the proper time
is  replaceall (B isa night, srel/nil/time/B/E)
    with       (srel/after/time/1800/E)
id  []
ip  [] ).

nesteomkvelden rule bustrans:(  %% neste buss i kveld, gitt atklokken er > 1800
is  replaceall (C isa night,srel/ON/Night/C/E)
    with       (T2300 isa clock,srel/after/time/T2300/E),
    { dmeq([about,on,in],ON),
      dmeq([night,daypart],Night)},
    not  present srel/before/time/_/E   %% not squeeze it
id  not flag(nightbusflag)
ip  timenow(T2300), T2300 > 1800
 ):-single.

omkvelden1 rule bustrans:(  %% Hva er busstidene på kvelden
is  not TI isa clock when { bound(TI)}, %% kl 1955 om kvelden
    replaceall (C isa night,srel/ON/Night/C/E)
    with       (1800 isa clock,srel/after/time/1800/E),
    { dmeq([about,on,in],ON),
      dmeq([night,daypart],Night)},
    not  present srel/before/time/_/E   %% not squeeze it
id  not flag(nightbusflag)
ip  []
 ):-single.

omkvelden2 rule bustrans:(  %% Hva er busstidene på kvelden
is  not present adj/_/last/_/_,
    not K isa clock when {bound(K)},
    replaceall (C isa night,srel/OM/daypart/C/E)
    with       (1800 isa clock,srel/after/time/1800/E),
    not  present srel/before/time/_/E   %% not squeeze it
id  []
ip  dmeq([about,on],OM)
 ):-single.

evening17 rule bustrans:(
is  replaceall (B isa evening, srel/nil/daypart/B/E)
    with       (srel/after/time/1700/E),
    not         srel/before/time/_/E   %% not squeeze it
id  []
ip  [] ).


evening1720 rule bustrans:( %% Tuesday evening MEANS Tuesday between 1700 and 2000
is  replaceall (C isa evening,srel/nil/daypart/C/E)
    with       (srel/after/time/1700/E,srel/before/time/2000/E)
id  []
ip  [] ).


aftermorning rule bustrans:( %% bus goes om morgen -> after morning
is  not present _ isa nightbus,
    not present  srel/early/_Time/nil/_, %%  then explicit //time/daypart
    not present  adj/_/early/_/_,
    replaceall (B isa morning ,srel/after/time/B/E)
    with       (srel/after/time/0430/E),
    not  _ isa clock %% if clock is mentioned, morning is just redundant
id  not flag(earlytime), %% then already set
    add flag(earlytime)  %%
ip  [] ).


noon rule bustrans:(
is  replaceall (B isa noon, srel/nil/daypart/B/E)
    with       (srel/after/time/1200/E)
id  []
ip  [] ).


prenoon0 rule bustrans:( %% Assume time is already adjusted for evening time
is  not present srel/_Prep/time/C/_ when { number(C)},
    replaceall (B isa prenoon, srel/nil/daypart/B/E)
    with       (1200 isa clock,srel/before/time/1200/E)
id  []
ip  [] ).


afternoon0 rule bustrans:(  %% Assume time is already adjusted for evening time
is  not present srel/_Prep/time/C/_ when { number(C)},
    replaceall (B isa afternoon, srel/nil/daypart/B/E)
    with       (1200 isa clock,srel/after/time/1200/E)
id  []
ip  [] ).


rush rule bustrans:( % i rushtiden betyr mellom 1530 og 1730 ? Rough
is  replaceall (R isa rush_hour,srel/in/time/R/E) %% verb modifier
    with       (1530 isa clock, 1730 isa clock,
                 srel/after/time/1530/E, srel/before/time/1730/E)
id  []
ip  [] ).


innight1 rule bustrans:(
is  not present (_ isa clock),
    not  present srel/_/clock/_/_ ,
    replaceall (srel/in_night/time/nil/E)
    with       (1800 isa clock,srel/after/time/1800/E)
id  []
ip  [] ).

twelvemidnight rule bustrans:( % natten  MEANS etter 2400
is  replaceall (srel/in_midnight/time/nil/E,srel/After/time/Twelve/E)
    with       (srel/After/time/Twentyfour/E),
    not present srel/before/time/_/_   %% probably an early morning time
id  []
ip  before(6,Twelve),before(Twelve,1300),
    Twentyfour is Twelve+1200 ).

inattbuss1 rule bustrans:(
is  srel/in_midnight/time/nil/_
id  addcon flag(nightbusflag)
ip  set(nightbusflag,true) ).

inattbuss2 rule bustrans:(
is  srel/this_midnight/time/nil/_
id  addcon flag(nightbusflag)
ip  set(nightbusflag,true) ).


inatt rule bustrans:( %% catch
is  replaceall (srel/in_midnight/time/nil/E)
          with (2400 isa clock,srel/after/time/2400/E),
    not present srel/before/time/_/_   %% probably an early morning time
id  addcon flag(nightbusflag)
ip  [] ).



paanatt rule bustrans:(
is  replaceall (X isa midnight,srel/on/_Time/X/E)
    with       (2400 isa clock,srel/after/time/2400/E)
id  not flag(nightbusflag)
ip  [] ).


umpdaynatt rule bustrans:(  %% Saturday night means Sunday
is  context C isa midnight,
    replaceall (B isa Saturday, has/day/midnight/B/C, srel/nil/daypart/D/E)
    with       (D isa Sunday, srel/nil/daypart/D/E)
id  []
ip  daysucc(Saturday,Sunday) ).


prepnatt rule bustrans:(
is  replaceall (C isa midnight, srel/PREP/time/C/E )
    with       (2400 isa time,  srel/PREP/time/2400/E)
id  not flag(nightbusflag)
ip  dmeq(timeprep,PREP) ).


middag12 rule bustrans:(
is  replaceall (C isa noon, srel/PREP/time/C/E )
    with       (1200 isa time,  srel/PREP/time/1200/E)
id  []
ip  dmeq(timeprep,PREP) ).


midnight024 rule bustrans:(
is  replaceall (0 isa clock,srel/before/X/0/E)
    with       (2400 isa clock, srel/before/X/2400/E)
id  []
ip  [] ).


 % % % % % % % % % % % % % % % % % %

%%%% a bus connects a place with a place MEANS ...  connect

connectwith1 rule bustrans:(
is  context B52 isa bus,
    replaceall  (connect/B52/A/E, event/real/E, srel/(with)/PLACE/B/E)
    with        ((do)/go/B52 /E, event/real/E, srel/from/place/A/E, srel/to/place/B/E)
id  []
ip  dmeq(place,PLACE) ).


endplace rule bustrans:( %% end stop   END station  rules
is  replaceall (S isa PLACE,adj/_/end/S/_)
    with       (S isa endstation)
id  []
ip  dmeq(place,PLACE) ).


bepresentat rule bustrans:( % be present at means go to
is  replaceall (adj/_/(present)/IBus/E, srel/At/place/U/E)
    with       ((do)/go/IBus/E,srel/to/place/U/E),
        {dmeq([at,to],At)} %% framme til
id  []
ip  [] ).


benextgoafter rule bustrans:( % be next after
is  present  adj/_/next/_/_ , %% next CLOCK means next after CLOCK
    replaceall (VEH isa BV,(do)/be1/VEH/E,srel/nil/time/T0/E)
    with       (VEH isa BV,(do)/go/VEH/E,srel/after/time/T0/E)
id  []
ip  dmeq(busdeparr,BV) ).  %% not to  destroy "which departures are"



begofore1 rule bustrans:( % be nil = before
is  context ((do)/go/VEH/E, VEH isa BV),
    replaceall ( (do)/be1/VEH/F, srel/BEFORE/time/T0/F)
    with       ( srel/before/time/T0/E)
id  []
ip  dmeq(beforenil,BEFORE) ,
    dmeq(busdeparr,BV) ).  %% not to  destroy "which departures are"



fromandbeon rule bustrans:( %% from StikV and be on StSf -> to StSf
is  present srel/from/place/_StikV/E,
    replaceall ((do)/be1/_/_,srel/on/place/StSf/E)
    with       (srel/to/place/StSf/E)
id  []
ip  [] ).



bego rule bustrans:( % be go  = be
is  context  ((do)/go/VEH/_E, VEH isa BV), { dmeq(busdeparr,BV)},
    removeall ( (do)/be1/VEH/_F)
id  []
ip  [] ).



startfromp rule bustrans:( %% A bus Starts from P MEANS  The bus has end station at P
is  replaceall  (B52 isa Bus, (do)/start/B52/B,srel/from/place/A/B,A isa place)
    with        (B52 isa Bus,has/_/endstation/B52/A,A isa endstation)
id  []
ip  dmeq(vehicle,Bus) ).


%%%% A bus Starts at P MEANS  The bus has end station at P

startatp rule bustrans:(
is  replaceall  ((do)/start/B52/B,B52 isa Bus,srel/in/place/A/B)
    with        (B52 isa Bus,has/vehicle/endstation/B52/A)
id  []
ip  dmeq(vehicle,Bus) ).

endsinp rule bustrans:(
is  replaceall  (end/B52/B,B52 isa Bus,srel/in/place/A/B)
    with        (B52 isa Bus,has/vehicle/endstation/B52/A)
id  []
ip  dmeq(vehicle,Bus) ).

%%%% This is a specialised rule bustrans:(: change  the 'at times' to either
%%%%  before or after, depending on whether the station is from or to.

fromplaceattoplaceatt rule bustrans:( %  from dragvoll at 1200  to risvollan at 1300
is replaceall (srel/from/place/Dragvoll/E1,srel/ATTIME1/time/T1200/E1,
               srel/ONTO/place/Risvollan/E2,srel/ATTIME2/time/T1300/E2)
   with       (srel/from/place/Dragvoll/E1,srel/after/time/T1200/E1,
               srel/to/place/Risvollan/E2,srel/before/time/T1300/E2)

id []
ip dmeq(by,ONTO),dmeq(attime,ATTIME1),dmeq(attime,ATTIME2) ).


someonetake rule bustrans:( %%  after inorder1
is  replaceall (B isa person,  C isa BR, dob/Take/B/C/D)
    with       (C isa BR, (do)/go/C/D)
id  []
ip  dmeq([take,reach,get,receive,find],Take),
    dmeq(vehicle,BR) ). %% not meeting  reach meeting \= reach train


withouttaking1 rule bustrans:( %%  uten å ta buss 9 =  ta  buss  \=  buss 9
is  present B9 isa bus,{bound(B9)}, %% avoid reshuffeling B9 isa bus
    replaceall  (srel/(not)/coevent/_A/C, dob/Take/I/B9/C) %% C is abanded
    with        (dob/avoid/I/B9/C),
        {dmeq([take,use],Take)}
id  []
ip  [] ).


idotake rule bustrans:( %%   I take Bus -> Bus goes  %% Experiment
is  replaceall (B isa self,  C isa BR, dob/Take/B/C/D) %% New Format
    with       (C isa BR, (do)/go/C/D)
id  []
ip  dmeq([take,get,find,have],Take), %% NOT reach, NOT receive (= få se)
    dmeq(vehicle,BR) ). %% not meeting  reach meeting \= reach train


onecantake rule bustrans:(
is  replaceall (B isa agent, C isa BR, dob/Take/B/C/D)
    with       (C isa BR, (do)/go/C/D)
id  []
ip  dmeq([take,reach,get,receive,find],Take),
    dmeq(vehicle,BR) ). %% not meeting  reach meeting \= reach train

youcantake rule bustrans:(
is  replaceall (B isa program , dob/take/B/C/D, C isa BR)
    with       (C isa BR, (do)/go/C/D)
id  []
ip  dmeq(vehicle,BR) ). %% not meeting  reach meeting \= reach train



atbhave1 rule bustrans:( %% which X does TT have  MEANS  which X  %% tt-> atb %% TA-110121
is replaceall (atb isa company,has/_Company/Bus/atb/A,event/real/E)
   with       ((do)/be1/A/E,event/real/E)
id []
ip dmeq(vehicle,Bus) ).



%%%% will tuc let me see IT  MEANS what is IT

caniseeit rule bustrans:(
is  replaceall (test,tuc isa savant,let/(id)/that/tuc/A/B,event/real/B,
               C isa self,dob/see/C/D/E,event/A/E)
    with       (which(D))
id  []
ip  [] ).


letmeseeit rule bustrans:( %%  let me see IT  MEANS what is IT
is replaceall ((do),tuc isa savant,let/(id)/that/tuc/A/B,event/real/B,
               C isa self,dob/see/C/D/E,event/A/E)
   with       (which(D))

id []
ip [] ).


%%%% full list MEANS list   list ===> information ...

fullham rule bustrans:(
is replaceall (B isa information,adj/_/whole/B/_)
   with       (B isa information)
id []
ip [] ).


listinformation1 rule bustrans:( %% Kan jeg få listet
is  replaceall  (test, B52 isa route,A isa self,dob/list/A/B52/B,event/real/B)
    with        ((do),   B52 isa route,tuc isa savant,dob/list/tuc/B52/B,event/real/B)
id  []
ip  [] ).


listinformation2 rule bustrans:(
is  replaceall ( F53 isa Information, (do)/be1/F53/E,
                 srel/OVER/thing/F52/E,event/real/E,
                 dob/LIST/_Tuc/F53/F54)
    with       ( dob/list/tuc/F52/F54)
id  []
ip  dmeq(list,LIST),dmeq(information,Information),dmeq(about,OVER) ).


listinformation3 rule bustrans:( %%   What is information about
is  replaceall ( which(F53),F53 isa Information, (do)/be1/F53/E,
                 srel/OVER/thing/F52/E,event/real/_E)
    with       ( (do),dob/list/tuc/F52/F54,event/real/F54)
id  []
ip  dmeq(information,Information),dmeq(about,OVER),newfree(F54) ).


knowinformation rule bustrans:( %%  Have you  information about
is  replaceall ( F53 isa Information, has/agent/information/_I/F53,
                 srel/OVER/thing/F52/E,event/real/E)
    with       ( dob/know/tuc/F52/F54,event/real/F54)
id  []
ip  unbound(F52),
    dmeq(information,Information),dmeq(about,OVER),newfree(F54) ).


info1 rule bustrans:( %% about a Boo
is  replaceall (which(A),A isa information,
                         srel/ABOUT/thing/F/E, F isa Boo,(do)/be1/A/E)
    with       ((do),tuc isa savant, dob/describe/tuc/Boo/E,event/real/E)
id []
ip dmeq(about,ABOUT),
   \+ dmeq(vehicle,Boo) ).


info1E rule bustrans:( %% whether  Boo exists
is  replaceall (which(A),A isa information,(do)/exist/A/_,
                         srel/ABOUT/thing/F/E, F isa Boo,(do)/be1/A/E)
    with       ((do),tuc isa savant, dob/describe/tuc/Boo/E,event/real/E)
id  []
ip  dmeq(about,ABOUT),
    \+ dmeq(vehicle,Boo) ).

info2 rule bustrans:( %% about Boo  [exists]
is  replaceall (which(A),A isa information,
                          (do)/be1/A/E,srel/ABOUT/thing/Boo/E)
    with       ((do),tuc isa savant, dob/describe/tuc/Boo/E,event/real/E)
id  []
ip  dmeq(about,ABOUT),bound(Boo),
    \+ dmeq(vehicle,Boo) ).

infobus rule bustrans:(  %% This is a default rule  nrel -> srel
is  replaceall (which(A),A isa information,F isa bus,
                          (do)/be1/A/E,srel/ABOUT/thing/F/E)
    with       (which(A),A isa route,F isa bus,
                          (do)/be1/A/E,srel/for/bus/F/E)
id  []
ip  dmeq(about,ABOUT) ).


%%%% shall be in MEANS shall (go) to  IF there is a from

shallbeinfrom rule bustrans:(
is  context    (srel/from/place/Moholt/E1,event/real/E1),
    replaceall (srel/in/place/Sentrum/E2,srel/AT/time/Time/E2)
    with       (srel/to/place/Sentrum/E2,srel/before/time/Time/E2)
id  []
ip  dmeq([at,in],AT), %% dmeq(attime,AT)
                  %% når er buss nr 9 som gikk fra sentrum 1745 i john aaes vei .
    \+ (Moholt = Sentrum) ).


%%%% to  place at clock MEANS to place before time  %% (before fromattime)

thereattime rule bustrans:( %% jeg skal være der
is  context   Time isa clock,
    replaceall (srel/in/place/Sentrum/E2,srel/AT/time/Time/E2)
    with       (srel/to/place/Sentrum/E2,srel/before/time/Time/E2)
id  []
ip  dmeq([at,in],AT) ).
                      %% når er buss nr 9 som gikk fra sentrum 1745 i john aaes vei.


toattime rule bustrans:(
is  context   Time isa clock,
    replaceall (srel/to/place/Sentrum/E2,srel/AT/time/Time/E2)
    with       (srel/to/place/Sentrum/E2,srel/before/time/Time/E2),
    not (do)/meetup/'I'/E2
id  []
ip  dmeq(attime,AT) ).




%%%% from place at clock MEANS from place after time
%%%%  NB  but only the first after !!!

fromattime rule bustrans:(
is  context   Time isa clock,
    not present srel/around/time/_/_,
    replaceall (srel/from/place/Sentrum/E2,srel/AT/time/Time/E2)
    with       (srel/from/place/Sentrum/E2,srel/after/time/Time/E2),
    not      srel/to/place/_/E2,
    not      present srel/on/place/_/E2,      %% and be on
    not      present (do)/pass/_/_       %% etc ad nauseam
id  []
ip  dmeq(attime,AT) ).


%%%% give me that MEANS give

gimmethat rule bustrans:( %% sjow me the buses
is replaceall (I isa self,srel/to/agent/I/E, dob/SHOW/_Tuc/X/E) %% Give/tuc De = de = du = tuc
   with       (dob/show/tuc/X/E)                             %%
id []
ip dmeq(show,SHOW) ).


infoofthat rule bustrans:(
is replaceall ( which(L),L isa Info, (do)/be1/L/E,srel/Over/X/E)
   with         which(X)
id []
ip dmeq(about,Over),dmeq(information,Info) ).


clinton rule bustrans:( %% vite (hva) om noe
is  replaceall (which(A),tuc isa savant,dob/know/tuc/A/C,srel/regarding/thing/B/C)
    with       (which(B))
id  []
ip  [] ).


starr rule bustrans:(    %%  vet du noe om % hva vet du om  MEANS what is
is replaceall    ( test,tuc isa savant,
                   dob/KNOW1/tuc/_A/B,  %% Normal %% Wrong code here ? know (thing)( about B)
                   event/real/B,srel/regarding/thing/X/B) %% about
    with      (which(X)),
    {dmeq([know,know1],KNOW1)}
id []
ip [] ).


%%%% jeg vil vite noe om  MEANS what is
%%%% kan jeg få opplysninger om  MEANS what is


canigetinfo rule bustrans:( % the route of the route (bus) %% PANIC
is  replaceall ( which(R),has/bus/route/B48/R, B48 isa route,R isa route,event/real/E)
    with       ( which(F0), B48 isa route,(do)/stop/B48/E,
                 srel/in/place/F0/E,event/real/E)
id  []
ip  newfree(F0) ).


%%%% I want to see MEANS see

wannasee rule bustrans:(
is replaceall (new,A isa self,dob/want/A/B/C,B isa coevent,event/B/E, event/real/C,dob/See/A/D/E,D isa X)
   with       ((do),tuc isa savant,dob/list/tuc/D/E,  D isa X,event/real/E)
id []
ip dmeq([see,receive],See),
   dmeq([bus,nightbus,route,route_plan],X) ).

isee rule bustrans:(
is  replaceall  (new,A isa self,dob/SEE/A/B/C ,  B isa X )
    with        ((do),tuc isa savant,dob/list/tuc/B/C,  B isa X )
id  []
ip  dmeq(see,SEE),
    dmeq([bus,nightbus,route,route_plan],X) ).


canigetbus rule bustrans:(
is  replaceall  (A isa self,dob/GET/A/B/E,B isa X)
    with        ((do)/go/B/E, B isa X)
id  []
ip  dmeq([get,receive],GET),
    dmeq([bus,nightbus,route,route_plan,departure],X) ).


givemeabus rule bustrans:(
is  replaceall  (dob/give/tuc/B/E,B isa X)
    with        ((do)/go/B/E, B isa X)
id  []
ip  dmeq([bus,nightbus,route,route_plan,departure],X) ).



%%%% Jeg  ønsker en lørdagsrute ==> "Bussrute" ### ænsker?


%%%% I want  MEANS what is

iwant rule bustrans:(
is  replaceall (new, B isa self, dob/want/B/A/D,A isa Thing,event/real/D)
    with       ((do),  tuc isa savant,A isa Thing,dob/list/tuc/A/D,event/real/D),
    not (A isa help)  %% i want help
id  []
ip  \+dmeq([information,money],Thing),
    unbound(A) ).  %% I want you *



listallstat rule bustrans:(  %% list all stations MEANS what is a station ?
is replaceall ((do),tuc isa savant, dob/LIST/tuc/S52/X, S52 isa Station,event/real/X)
   with       (which(S52),S52 isa Station)
id []
ip dmeq(list,LIST),
   dmeq([station,arrival,price],Station) ). %% stopp = arrival




%%%% Trondheim rule bustrans:(s

trondheim1 rule bustrans:(
is  removeall   (Trondheim isa city,nrel/_/_Bus/CP/_/Trondheim)
id  []
ip  dmeq([city,place],CP),
    home_town(Trondheim) ).


trondheim3 rule bustrans:(
is removeall (Trondheim isa city, srel/in/_/Trondheim/_ ) %% in/for
id []
ip \+ value(teleflag,true),
   home_town(Trondheim) ).

trondheim3n rule bustrans:(
is removeall (Trondheim isa neighbourhood, srel/in/_/Trondheim/_ ) %% in/for
id []
ip \+ value(teleflag,true),
   home_town(Trondheim) ).



trondheim4 rule bustrans:(
is removeall (Trondheim isa city, srel/for/_/Trondheim/_ ) %% in/for
id []
ip home_town(Trondheim) ).

trondheim5 rule bustrans:(
is removeall (Trondheim isa city, has/city/route/Trondheim/_)
id []
ip home_town(Trondheim) ).

trondheim5 rule bustrans:(
is removeall (byen isa neighbourhood, srel/in/neighbourhood/byen/_)
id []
ip [] ).



%%%% .....

%%%% directroute  MEANS  direct route

directroute rule bustrans:(
is replaceall (X isa directroute)
   with       (X isa route, adj/_/direct/X/_)
id []
ip [] ).


isatimefor rule bustrans:(
is  context (A isa time,B52 isa bus,event/real/B),
    replaceall ((do)/be1/A/B,srel/for/vehicle/B52/B)
    with       (has/vehicle/departure/B52/A)
id  []
ip  [] ).

colour0 rule bustrans:( %% colour |  bus
is  _ isa colour,
    present _Bus isa BR, {dmeq(vehicle,BR)}
id	 addcon message(irrelevant(colour(bus))),
    add flag(exit)
ip	 [] ).

colour2 rule bustrans:(
is  present Bus isa BR,adj/_/Colour/Bus/_
id	 addcon message(irrelevant(colour(bus))),
    add flag(exit)
ip  dmeq(colour,Colour),dmeq(vehicle,BR) ).


speed2 rule bustrans:(
is  has/_/speed/_/__ isa speed
id	 addcon  message(noinfoabout(speed))
ip  [] ).

distance rule bustrans:(
is  srel/(with)/distance/_/_
id	 addcon  message(noinfoabout(distance))
ip  [] ).


%%%% Vis bussavganger for rute  5 MEANS vis bussavgangene til rute 5
%%%% which route does bus 9 have MEANS which places does bus 9 pass
%%%% bus between A and B MEANS bus from A to B
%%%% (go) between A and B MEANS (go) from A to B

betweenplace rule bustrans:( %% (go) between TimeA and TimeB MEANS go after TimeA before TimeB
is  replaceall (srel/BETWEEN/place/(P1,P2)/E)
    with       (srel/from/place/P1/E, srel/to/place/P2/E)
id  []
ip  dmeq(between,BETWEEN) ). % dmeq(bepass,PASS)


betweentime0 rule bustrans:(
is  replaceall (T2 isa clock,srel/BETWEEN/Time/(T1,T2)/E)
    with       (T3 isa clock,srel/after/time/T1/E, srel/before/time/T3/E)
id  []
ip  dmeq([between,around,in],BETWEEN),
    dmeq(timeclock,Time), number(T2), number(T1),
    T2 < T1, T2 < 430, %% mellom 12 og 2
    evening_time(T2,T3) ).


betweentime rule bustrans:(
is  replaceall (srel/BETWEEN/Time/(T1,T2)/E)
    with       (srel/after/time/T11/E, srel/before/time/T22/E)
id  []
ip  dmeq([between,around,in],BETWEEN),
    dmeq(timeclock,Time),
    sorttimes(T1,T2,T11,T22) ).


afternow rule bustrans:(
is  replaceall (srel/after/time/now/E)
    with       (srel/hereafter/time/nil/E)
id  []
ip  [] ).



cancel rule bustrans:(
is  cancel/_/_/_
id  addcon(message(noinfoabout(irregularity)))
ip  [] ).


waitdelay rule bustrans:(
is  (do)/wait/'I'/_,clear %%   SMS  >160
id  clear, addcon(message(noinfoabout(delays)))
ip  [] ).


delay3 rule bustrans:(
is  adj/_/Delayed/_/_,
    {dmeq([delayed], Delayed)}, %% TA-100923  Hazard  sen = forsinket
    clear %%   SMS  >160
id  clear, addcon(message(noinfoabout(delays)))
ip  [] ).


delay4 rule bustrans:( %% come delayed
is  srel/delayed/time/nil/_,clear
id  clear, addcon(message(noinfoabout(delays)))
ip  [] ).

delay5 rule bustrans:(
is  _ isa delay
id  addcon(message(noinfoabout(delays)))
ip  [] ).

delay6a rule bustrans:( %% are routes precise/punctual
is  adj/_/precise/_/_,clear %%   SMS  >160
id  clear, addcon(message(noinfoabout(delays)))
ip  [] ).

delay6b rule bustrans:(
is  adj/_/punctual/_/_
id  addcon(message(noinfoabout(delays))),
    add flag(exit)
ip  [] ).


%%%% pass P between TimeA MEANS pass P around TimeA

betweenwhat1 rule bustrans:(
is  context (do)/pass/_/E,
    replaceall (srel/between/time/T1/E)
    with       (srel/after/time/T1/E) %% single between,
id  []
ip  [] ).

betweenwhat2 rule bustrans:(
is  context (do)/go/_/E,
    replaceall (srel/between/time/T1/E)
    with       (srel/after/time/T1/E) %% single between,  (between 1330 to 1600) %% around
id  []
ip  [] ).


yourbuses rule bustrans:( %% your buses
is  dob/be/_/Bus/_, has/agent/_/Tuc/Bus,
        {dmeq([tuc,tt,'I'],Tuc),unbound(Bus)},
    Bus isa  BR,  {dmeq([bus,nightbus,tram,car,route],BR)},
    not present _ isa station,
    not present _ isa neighbourhood,
    not _ isa time
id  not flag(exit),
    %% clear
    add listofall(BR,_)
ip  [] ).


busesattt rule bustrans:( %% your buses
is  (do)/exist/Bus/F10,srel/at/_/Tuc/F10,  {dmeq([tuc,tt],Tuc),unbound(Bus)},
    Bus isa  BR,  {dmeq([bus,nightbus,tram,car,route],BR)},
    not present _ isa station,
    not present _ isa neighbourhood,
    not _ isa time
id  not flag(exit),
    %% clear
    add listofall(BR,_)
ip  [] ).

tuchasabus1 rule bustrans:(   %% tuc has a bus MEANS there exists a bus
is  context (A isa BR1),
    removeall (tuc isa savant,has/agent/BR2/tuc/A)
id  []
ip  dmeq(bus,BR1),dmeq(bus,BR2) ).


tuchasabus2 rule bustrans:( % hvilken buss har tuc
is  context (A isa bus),
    replaceall (tuc isa savant,has/agent/bus/tuc/A)
    with       ((do)/be1/A)
id  []
ip  [] ).


howminutes rule bustrans:( %% how many minutes MEANS  how long time
is replaceall (howmany(A), A isa Minute)
   with       (which(A),   A isa time)
id []
ip dmeq([minute,hour,second],Minute) ). %% NOT DAY


nextday rule bustrans:( %% next day MEANS tomorrow
is  replaceall (B isa day,adj/_/next/B/C)
    with       (srel/tomorrow/day/nil/C)
id  []
ip  [] ).


earlyinthemorning rule bustrans:( %% Imorgen tidlig  MEANS tomorrow  before 0900
is  replaceall (srel/early/time/nil/E,srel/in_morning/time/nil/E)
    with       (srel/after/time/0430/E)
id  []
ip  [] ).


goearly rule bustrans:( %% go early means after 0430 unless ...
is  not present _ isa clock,   %% skal være der kl 8 i morgen tidlig
    srel/early/time/nil/E,
    add     (MornTime isa clock,srel/after/time/MornTime/E)
id  []
ip  MornTime=0430 ). %% ad hoc


goearlydefault rule bustrans:(
is  not present _ isa clock,   %% skal være der kl 8 i morgen tidlig
    B isa morning,srel/in/time/B/E,
%%%%  + restrictions
    add     (MornTime isa clock,srel/after/time/MornTime/E)
id  []
ip  MornTime=0430 %% ad hoc
 ):-double.


todaysfirst rule bustrans:( %% Days first bus = early
is  has/day/bus/_/A,
    not _ isa morning, %% avoid double constraint
    replaceall (adj/_/first/A/E  )
    with       (srel/after/time/0430/E)
id  []
ip  []
  ):- single.   %% not confuse


bearly rule bustrans:( %% early in the morning
is  %% not _ isa morning, %% avoid double constraint // they block each other
    replaceall (adj/_/early/_A/E  )
    with       (srel/after/time/0430/E)
id  []
ip  []
  ):- single.   %% not confuse


howmanytimesgo rule bustrans:( % how many times does a bus go MEANS how many buses go
is context B isa bus,
   replaceall (howmany(A),A isa time,(do)/go/B/E,srel/in/time/A/E)
   with       (howmany(B),(do)/go/B/E)
id []
ip [] ).


gowithouttrans rule bustrans:( %  A bus goes without transfer MEANS A bus goes directly
is context    A isa bus, (do)/go/A/C,
   replaceall (B isa transfer, srel/without/transfer/B/C)
   with       (srel/directly/(mode)/nil/C)
id []
ip [] ).


takeandbeon rule bustrans:( %  I take a bus and is on a place MEANS  I (will)  pass the place.
is context    (B isa self,dob/take/B/_/_),
   replaceall (STAND/B/E, srel/on/place/NTH/E)
   with       ((do)/go/B/E,srel/to/place/NTH/E),
   not present srel/from/place/NTH/E
id []
ip dmeq(stand,STAND) ).


beonandtake rule bustrans:( %% be on place and take
is context    (B isa self,dob/take/B/_/_),
   replaceall (STAND/B/E, srel/on/place/NTH/E)
   with       ((do)/go/B/E, srel/from/place/NTH/E),
   not present srel/to/place/NTH/E
id []
ip dmeq(stand,STAND) ).


beonandgo rule bustrans:( % be on and go
is context    (B isa self,(do)/go/B/_),
   replaceall (STAND/B/E, srel/on/place/NTH/E)
   with       (srel/from/place/NTH/E),
   not present srel/to/place/NTH/E

id []
ip dmeq(stand,STAND) ).


goandbeon rule bustrans:( %% go and be on
is context    (B isa self,(do)/go/B/_),
   replaceall (STAND/B/E, srel/on/place/NTH/E)
   with       (srel/to/place/NTH/E),
   not present srel/from/place/NTH/E
id []
ip dmeq(stand,STAND) ).


nearto rule bustrans:(  %%  er nærmeste busstopp til nardosenteret..
is replaceall (adj/_/NEAR/A/_B,srel/to/place/NTH/B)
   with       ((do)/be1/A/B, srel/NEAR/place/NTH/B)
id []
ip dmeq(near,NEAR) ).


downtown rule bustrans:( %% go downtown
is replace srel/downtown/(mode)/nil/E with
           (sentrum isa neighbourhood,
            srel/to/place/sentrum/E)
id []
ip [] ).


iknowx rule bustrans:( %% Do I know  (" få vite ")
is replaceall ( I isa self ,dob/KNOW1/I/A/B ,event/real/B,test )
   with      which(A)
   ,{dmeq([know,know1],KNOW1)}
id []
ip [] ).


tucnowifx rule bustrans:( % "Do you know whether... " is superf ( ..when .. is not superfluous
is removeall (tuc isa savant ,know/(id)/whether/tuc/_/B, event/real/B) % whether
id []
ip [] ).

iknowifx rule bustrans:( % "Do you know whether...
is removeall (I isa self ,know/(id)/whether/I/_/B, event/real/B) % whether
id []
ip [] ).


showup rule bustrans:( % show up means pass
is remove srel/up/place/nil/B,
   replace (do)/show/A/B with (do)/pass/A/B
id []
ip [] ).


possibletogo rule bustrans:( % "be possible to Go" is the same as Go %% TA-100831
is replaceall   (A isa thing,B isa coevent,adj/nil/Possible/B/C,(do)/Go/A/D,event/B/D)
   with         (I isa self,(do)/Go/I/C)
id []
ip dmeq([possible,easy],Possible) ).


possibletogo1 rule bustrans:( % "be possible" is the same as go %% OUTDATED?
is replaceall   (adj/_/Possible/it/_,(do)/go/it/B)
   with (I isa self,(do)/go/I/B)
id []
ip dmeq([possible,easy],Possible) ).


citycentre rule bustrans:( % centre of city - > sentrum
is  has/city/centre/_/D, %%  ( centre )
	 replace  srel/TOFROMBY/place/D/A
    with     (sentrum isa neighbourhood,
              srel/TOFROMBY/place/sentrum/A)
id  []
ip  dmeq(tofromby,TOFROMBY),unbound(D) ). %% dmeq first !!!



%%%%% END OF SOURCE TO SOURCE SECTION %%%%% %%%%%%%%%%%%

%%%%%%%%%%
%%%% We need to remember if a departure is "from" or "to", to store it in the
%%%% context. Now it's gone when passevent is removed (coupled)


fledsbo1 rule bustrans:(
is []
id present departure(Bus,Place,_DaySeq,Depset1),
   present passevent(Depset2,Bus,Place,Opts,_Day,_),
   not depset(from, _),
   add depset(from, [Depset1])
ip Depset1 == Depset2,
   member(from, Opts)
  ):-double.

fledsbo2 rule bustrans:(
is []
id present departure(Bus,Place,_DaySeq,Depset1),
   present passevent(Depset2,Bus,Place,Opts,_Day,_),
   not depset(to, _),
   add depset(to, [Depset1])
ip Depset1 == Depset2, member(to, Opts)
 ):-double.

fledsbo3 rule bustrans:(
is  []
id  present departure(_,_,_,Depset1),
    present connections(Depset2,_,_,_,_,_,_,_,_,_),
    not depset(from, _),
    add depset(from, [Depset1])
ip  Depset1 == Depset2
  ):-double.


fledsbo4 rule bustrans:(
is []
id present departure(_,_,_,Depset1),
   present connections(_,Depset2,_,_,_,_,_,_,_,_),
   not depset(to, _),
   add depset(to, [Depset1])
ip Depset1 == Depset2
 ):-double.

fledsbo5 rule bustrans:(
is []
id present keepafter(_, Dep1, Dep2),
   remove depset(Dir, List),
   add depset(Dir, [Dep2 | List])
ip varmember(Dep1, List),
   \+ varmember(Dep2, List)
 ):-double.

fledsbo6 rule bustrans:(
is []
id present keepbefore(_, Dep1, Dep2),
   remove depset(Dir, List),
   add depset(Dir, [Dep2 | List])
ip varmember(Dep1, List),
   \+ varmember(Dep2, List)
 ):-double.

fledsbo61 rule bustrans:(
is []
id present keepbefore1(_, Dep1, Dep2),
   remove depset(Dir, List),
   add depset(Dir, [Dep2 | List])
ip varmember(Dep1, List),
   \+ varmember(Dep2, List)
 ):-double.

fledsbo7 rule bustrans:(
is []
id present keepbetween(_,_, Dep1, Dep2),
   remove depset(Dir, List),
   add depset(Dir, [Dep2 | List])
ip varmember(Dep1, List),
   \+ varmember(Dep2, List)
 ):-double.

%%


whichnumberhas rule  bustrans:( % hvilket nr har bussene ? nr -> route (SIC)
is  exactly (which(A),A isa route,Bus isa BR,has/vehicle/route/Bus/A,event/real/_)
id	 add listofall(BR,_)
ip  dmeq([bus,nightbus,tram],BR),unbound(Bus) ).


%%%% allofakind rule bustrans:(s %% all ordinary listable nouns



%%%% hvilke XX  vet du  MEANS what is % Moved back
allofakind00 rule bustrans:( %% kan du bussene FRONTED
is  exactly (test,tuc isa savant,B isa BR,dob/KNOW1/tuc/B/_)
  ,{dmeq([know,know1],KNOW1)}
id	 add listofall(BR,_)
ip  dmeq([bus,nightbus,tram,route],BR),
    unbound(B)
 ):-single.

allofakindmain rule bustrans:( %% what are the main buses
is  exactly (which(Bus),Bus isa BR, adj/_/main/Bus/_) %% etc
id	 add listofall(BR,_)
ip  dmeq([bus,nightbus,tram,route],BR),
    unbound(Bus) ).

allofakindexist rule bustrans:(  %%  after doyouhavex
is  which(Bus),(do)/exist/Bus/_, Bus isa BR,
    not _ isa station,
    not _ isa neighbourhood
id	 add listofall(BR,_)
ip  dmeq([bus,nightbus,tram,route],BR),
    unbound(Bus) ).

allofakindknow rule bustrans:(
is  dob/KNOW1/tuc/Bus/_,Bus isa BR,
    not _ isa station,
    not _ isa neighbourhood
  ,{dmeq([know,know1],KNOW1)}
id	 add listofall(BR,_)
ip  dmeq([bus,nightbus,tram,route],BR),
    unbound(Bus) ).

allofakind0 rule bustrans:( % Hva heter bussene
is  which(Bus),Bus isa BR,
    _ isa thing,            %% ad hoc
    not _ isa station,
    not _ isa neighbourhood
id	 add listofall(BR,_)
ip  dmeq([bus,nightbus,tram,route],BR),
    unbound(Bus) ).


allofakind1 rule bustrans:( % Which buses are there? / What is a bus
is  exactly (which(Bus),Bus isa BR)
id	 add listofall(BR,_)
ip  dmeq([bus,nightbus,tram,route],BR),
    unbound(Bus) ).

allofakind2 rule bustrans:(
is  exactly (which(Bus),Bus isa BR, event/real/_),clear
id	 clear,
    add listofall(BR,_),
    add flag(exit)
ip  dmeq([bus,nightbus,tram],BR),unbound(Bus) ).


allofakind3 rule bustrans:(
is  exactly (which(Bus),Bus isa BR, (do)/be1/Bus/_,event/real/_)
id	 add listofall(bus,_)
ip  dmeq([bus,nightbus,route],BR),unbound(Bus) ).

allofakind4 rule bustrans:(
is  exactly (which(Bus),Bus isa BR, (do)/be1/Bus/_,event/real/_)
id	 add listofall(BR,_)
ip  dmeq([bus,nightbus,tram,route],BR),unbound(Bus) ).


allofakind6 rule bustrans:( %% hva heter bussene
is  A isa thing,B isa BR, dob/be_named/B/A/C,event/real/C,
    {dmeq([bus,nightbus,tram],BR),unbound(B)}
id	 add listofall(BR,_)
ip  [] ).


allbuses0 rule bustrans:(
is  which(A),     A isa bus,
    tuc isa savant,
    dob/KNOW1/tuc/E, srel/_Regarding_/thing/A/E %% know about/
  ,{dmeq([know,know1],KNOW1)}
id  add listofall(bus,_) %% generalized allbuses
ip  [] ).

allbuses1 rule bustrans:( % Goddag mann
is  which(A),     A isa bus,
    tuc isa savant,
    dob/KNOW1/tuc/A/B, event/real/B
  ,{dmeq([know,know1],KNOW1)}
id  add listofall(bus,_) %% generalized allbuses
ip  [] ).

allbuses2 rule bustrans:( %% list all buses
is  exactly ((do),tuc isa savant,Bus isa BR,dob/List/tuc/Bus/E,event/real/E)
id	 add listofall(BR,_)
ip  dmeq([bus,nightbus,route,number],BR),
    unbound(Bus),dmeq([give,list,show,find],List) ).


allbuses3 rule bustrans:( % Which numbers do the buses have ?
is  exactly (which(A),A isa number,B isa BR,has/bus/number/B/A,event/real/_)
id	 add listofall(bus,_)
ip  dmeq(bus,BR),unbound(B) ).


howmanystations1 rule bustrans:( % How many stations are there?
is  exactly (howmany(St),St isa station, STAND/St/A,event/real/A)
id	 add (listofall(station,M),
         numberof(stations,M,_))
ip  \+ value(smsflag,true),
    dmeq([be1,exist],STAND) ).


howmanystations2 rule bustrans:( % How many stations have ...?
is  exactly (howmany(ST ),ST isa station,TT isa Company,has/Company/station/TT/ST ,event/real/_)
id	 add (listofall(station,M),
         numberof(stations,M,_))
ip  [] ).


whichbuses1 rule bustrans:( % Which buses are there?
is  exactly (which(Bus),Bus isa BR, (do)/be1/Bus/A,event/real/A)
id	 add listofall(bus,_)
ip  dmeq(bus,BR) ).



howmanybuses1  rule bustrans:( % How many buses are there  ?
is  howmany(Bus),Bus isa bus,
    (do)/BE/Bus/A,event/real/A,
    not srel/in/day/_/_,  %% frequency ?  % before next:
    not srel/in/_Place/_/A, %% in system etc
    not X isa route when { bound(X)}
id	 add (listofall(bus,M),numberof(busroutes,M,_))
ip  dmeq(exist,BE) ).


howmanybuses2 rule bustrans:( % Howmany buses goes?
is  exactly (howmany(Bus),(do)/PASS/Bus/E,Bus isa BDR,event/real/E)
id	 add (listofall(bus,M),
         numberof(busroutes,M,_))
ip  dmeq(bepass,PASS), dmeq([bus,route],BDR) ).


howmanybuses3 rule bustrans:( % How many buses have you (after transform)  ?
is  howmany(Bus),Bus isa Vus,
    not (not _), %% hides the not qualifications
    not _ isa program, %% programlines :-)
    not present N isa station,
    not present N isa neighbourhood,
    not present stand/_/_,
    not present _ isa clock,
    not present srel/_/place/_,
    not present run/_/_,
    not present (do)/go/_/_,
    not present (do)/pass/_/_, %% (pass + dir)
    not present drive/_/_,
    not present _ isa departure,
    not present srel/in/place/_/_, %% Norge, etc
    not X isa route when { bound(X)}
id  add (listofall(bus,M),numberof(busroutes,M,_))
ip  dmeq([bus,vehicle,route],Vus) ).


whbusin rule bustrans:( % Which buses are there in ...?
is  exactly (which(Bus),Bus isa bus, (do)/be1/Bus/A,event/real/A,srel/in/place/_/A)
id	 add listofall(bus,_)
ip  unbound(Bus) ).


whnightbusesgo rule bustrans:( % Which nightbuses go?
is  exactly (which(Bus),Bus isa nightbus,(do)/PASS/Bus/E,event/real/E)
id	 not  add listofall(nightbus,_),
    add  listofall(nightbus,_)
ip  unbound(Bus),
    dmeq(bepass,PASS) ).


whatisabus  rule bustrans:( %% what is a bus ?
is  exactly (which(A),B isa bus,
    event/real/C,
    dob/be/B/A/C)
id	 add listofall(bus,_)
ip  unbound(B) ).


whbusesin rule bustrans:( % Which buses are in  Team/Oracle/etc
is  A isa route,(do)/be1/A/B,srel/in/_Place/_/B,
    not present _ isa neighbourhood, %% e.g. Klæbu
    not present _ isa station
id	 add listofall(route,_)
ip  unbound(A) ).


whbusesgo rule bustrans:( % Which buses go?
is  exactly (which(Bus),Bus isa BR,(do)/PASS/Bus/E,event/real/E),
    {dmeq(bus,BR)}
id	 add listofall(BR,_)
ip  unbound(Bus),
    dmeq(bepass,PASS) ).


busesexist rule bustrans:( %% (which/does) buses exist
is  exactly (test,B isa Bus, (do)/exist/B/E,  event/real/E),{unbound(B)}
id	 add listofall(Bus,_)
ip  dmeq([bus,nightbus,tram],Bus) ).



noinfochange rule bustrans:(
is  dob/change/_/A/_, present A isa Route,
        {dmeq([route,route_plan],Route)} %% \ikke bytte buss
id	 addcon message(noinfoabout(change)),
    add flag(exit)
ip  [] ).

%%% Irrelevante opplysninger %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



imissbus rule bustrans:( %% similar to reach (miss=lose)
is  present B isa BR,  dob/lose/'I'/B/_ % 'I' is self disappears
id	 addcon message(nocorresponse),
    add flag(exit) % ?
ip  dmeq(busdeparr,BR) ).


canicallyou rule bustrans:(
is  test,I isa Self, dob/call/I/tuc/_  %% TMN
id  clear,
    add (
    message(answer(db_reply(tuc,telephone,K))))
ip  dmeq([self,program],Self),
    has_att_val(agent,telephone,tuc,K) ).


calltmn1 rule bustrans:(
is  which(A),A isa place,I isa Self, dob/call/I/A/_  %% TMN
id  clear,
    add ( %% has_att_val(company,telephone,tmn,K),
    message(answer(db_reply(tmn,telephone,K))))
ip  dmeq([self,program],Self),
    has_att_val(company,telephone,tmn,K) ).

calltmn2 rule bustrans:(
is  which(A),A isa place,I isa Self, dob/turn/I/E, srel/in/place/A/E %% TMN
id  clear,
    add ( %% has_att_val(company,telephone,tmn,K),
         message(answer(db_reply(tmn,telephone,K))))
ip  dmeq([self,program],Self),
    has_att_val(company,telephone,tmn,K) ).

%% AIRBUS / AIRPORT SECTION + Ferry

sail rule bustrans:(
is  sail/_/_
id	 clear,
    add   message(noinfoabout(boat))
ip  [] ).

fly rule bustrans:(
is  fly/_/_
id	 clear,
    add   message(noinfoabout(airplane)),
    add   message(answer(db_reply(flybussen,webaddress,K)))
ip  internal_airbus(false), %% busdat
    have_att_val(company,webaddress,flybussen,K) ).


airplane  rule bustrans:( %% fly_buss --> fly buss -> plane bus
is  adj/_/airplane/_/_
id	 clear,
    add   (message(answer(db_reply(flybussen,webaddress,K))))
ip  internal_airbus(false), %% busdat
    have_att_val(company,webaddress,flybussen,K) ).


airport1 rule bustrans:( %%  airport
is  _ isa airbus,clear
id	 clear,
    add (message(noinfoabout(airbus)),
         message(answer(db_reply(flybussen,webaddress,K)))),
    add flag(exit)
ip  internal_airbus(false), %% busdat
    have_att_val(company,webaddress,flybussen,K) ).

airport2 rule bustrans:( %%  airport værnes
is  Værnes isa airport,
    clear %% værnes, not gardermoen
id	 clear,
    add (message(noinfoabout(airbus)),
         message(answer(db_reply(flybussen,webaddress,Z)))) %% TA-101110
ip  internal_airbus(false), %% busdat
    airbusstation(Værnes), %% busdat.pl
    have_att_val(company,webaddress,flybussen,Z) ).


airport21 rule bustrans:( %%  airport
is  _ isa airport,
    clear
id	 clear,
    add (message(noinfoabout(airbus)),
         message(answer(db_reply(flybussen,webaddress,K))))
ip  internal_airbus(false), %% busdat
    have_att_val(company,webaddress,flybussen,K) ).


airport3 rule bustrans:( %%  airport
is  FLY isa neighbourhood, clear
id	 clear,
    add (message(noinfoabout(airbus)),
         message(answer(db_reply(flybussen,webaddress,K))))
ip  internal_airbus(false),airbusstation(FLY),
    have_att_val(company,webaddress,flybussen,K) ). %% all %% TA-101124


airport4 rule bustrans:( %%  airport
is  X isa airplane, srel/_/airplane/X/_ ,clear
id	 clear,
    add (message(answer(db_reply(flybussen,webaddress,K))))
ip  internal_airbus(false),
    have_att_val(company,webaddress,flybussen,K) ).

airport5 rule bustrans:( %%  airbusterminal %%
is  _ isa airbusterminal,clear
id	 clear,
    add message(noinfoabout(airbus)),
    add message(answer(db_reply(flybussen,webaddress,K)))
ip  internal_airbus(false),
    have_att_val(company,webaddress,flybussen,K) ).


whereairbus rule bustrans:( % Hvor stopper flybussen
is  Bus isa airbus,
    which(Station),(do)/PASS/Bus/B, {dmeq(pass,PASS)},
    srel/_In/place/Station/B, {unbound(Station)},

    not Stat1 isa station  when {bound(Stat1)},
    not Neib1 isa neighbourhood when { bound(Neib1)},
    not present srel/_/place/Moholt/_  when { bound(Moholt)},%% not if station is mentioned
    not present srel/between/place/_/_,
    not present adj/_/next/_/_,
    not srel/off/place/_/_,  %% side av veien
    not srel/_Now/time/_/_ ,                    %% NOW
    not srel/nil/time/_/_ ,
    not has/_Vehicle/departure/Bus/_,

    clear
id	 atday(Day),
    not  passevent(_,_,_,_,_,_), %% avoid test departure(_,_,_,_),
	 add (findstations(flybussen,Day,Stl),passesstations(flybussen,Day,Stl,_))
ip	 [] ).               %% NB   %%



% End Airport Section

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

goddagmann rule bustrans:(
is  howmany(Bus),present Bus isa Frog,
    clear % avoid GodDagMannøkseskaft answers (GDMø)
id  not message(_Already),
    clear,
    addfront message(idonotknow)
ip  \+ testmember(Frog,[money,crown,question]), %% TA-101215
    \+ dmeq(busdeparr,Frog),
    \+ dmeq(place,Frog) ).

nofrequenciessms rule bustrans:(
is  replaceall (which(A), A isa frequency,(do)/go/B20/B,srel/(with)/frequency/A/B)
    with       (which(A), A isa time,(do)/go/B20/B,srel/in/time/A/B),
    clear %% sms>160
id  clear,
    add message(noinfoabout(frequency)),
    add flag(exit)
ip  value(smsflag,true) ).

nofrequencies rule bustrans:(  %% how often -> when
is  replaceall (which(A), A isa frequency,(do)/go/B20/B,srel/(with)/frequency/A/B)
    with       (which(A), A isa time,(do)/go/B20/B,srel/in/time/A/B)

id  add message(noinfoabout(frequency))
ip  \+ value(smsflag,true) ).


perhour rule bustrans:(
is  srel/per/Min/_/_, {dmeq([hour,minute,second],Min)},
    clear %% sms>160
id  clear,
    add message(noinfoabout(frequency))
ip  [] ).


nofrequencies99 rule bustrans:( %% destructive
is  _ isa frequency,
    not present change/_/_,   %% how often change bus
    not present dob/change/_/_/_,
    clear
id  clear,
    add message(noinfoabout(frequency)),
    add flag(exit)
ip  [] ).


ruthphone  rule bustrans:(
is  I isa self, (do)/speak/I/E, srel/(with)/agent/tuc/E
id  clear,
    add message(answer(db_reply(tuc,telephone,73511348)))
ip  [] ).


one77 rule bustrans:( %% Ruteopplysningstelefonen
is  I isa self,call/I/E,X isa place,srel/_/place/X/E
id  clear,
    add message(answer(db_reply(ruteopplysningen,telephone,177)))
ip  [] ).


haveyou rule bustrans:( %%  Hvilke X har du -> Hvilke X fins
is  replaceall (tuc isa savant, has/agent/station/tuc/A, event/real/E)
    with       ((do)/exist/A/E, event/real/E)
id  []
ip  [] ).


hasattvalwebroute rule bustrans:( %% hva er nettsiden til rutetidene
is  which(A),A isa webaddress,B isa route_plan,has/route_plan/webaddress/B/A
id  add  message(answer(db_reply(TT,webaddress,K)))
ip  value(actual_domain,TT),
    has_att_val(company,webaddress,TT,K) ).


hasattvalTT rule bustrans:(
is  which(A),TT isa company, A isa Telephone,
    has/agent/Telephone/TT/A
id  add  message(answer(db_reply(TT,Telephone,K)))
ip  dmeq([telephone,webaddress],Telephone),
    value(actual_domain,TT),
    has_att_val(company,Telephone,TT,K) ).


telephonefor rule bustrans:( %% for politiet (unresolved  possessive  has/)
is  which(A),A isa telephone,TT isa Agent,(do)/be1/A/E,srel/for/_Thing/TT/E,event/real/E,
      { dmeq([place,agent,company,savant],Agent)}
id  add  message(answer(db_reply(TT,telephone,K)))
ip  has_att_val(agent,telephone,TT,K) ).


hastelephone rule bustrans:( %% til politiet
is  which(A),has/Agent/telephone/TT/A,
      { dmeq([agent,company],Agent)},
    {TT \== tuc} %% har du telefon til// ikke din telefon %% TA-110324
id  add  message(answer(db_reply(TT,telephone,K)))
ip  has_att_val(Agent,telephone,TT,K) ).


hasatt0 rule bustrans:( %% Ruteopplysningstelefonen
is  A isa telephone,
    has/company/telephone/tt/A,clear
id  clear,
    add message(answer(db_reply(ruteopplysningen,telephone,177)))
ip  [] ).


hasatt01 rule bustrans:( %% before hasatt1    % din -> a program
is  has/system/Version/Tuc/A,
    Tuc isa savant,
    A isa Version,
    clear
id  clear,
    add  message(answer(db_reply(tuc,Version,K)))
ip  has_att_val(_Company,Version,tuc,K) ).


whichage rule bustrans:(
is which(A),TA isa person,A isa age,has/agent/age/TA/A
id  add  message(answer(db_reply(TA,birthday,K))),
    add flag(exit)
ip  has_att_val(person,birthday,TA,K) ).



wasborn rule bustrans:( %% når ble Tore Amble født %% TA-110520
is  which(A),TA isa person,B isa agent,A isa time,dob/bear2/B/TA/C,srel/in/time/A/C,event/real/C
id  add  message(answer(db_reply(TA,birthday,K))),
    add flag(exit)
ip  has_att_val(person,birthday,TA,K) ).


hasatt1 rule bustrans:(  %% Standard General %%<---
is  A isa Telephone,
    has/Company/Telephone/TT/A,
    not present  has/agent/_/'I'/A, %% har du telefonnumeret mitt
    not present  has/City/Telephone/_/A when {City \== agent},  %% TA-110324
                       %% AD HAC  har du nummeret til Trondheim
    clear    %%  Telephone is never a subclass
id  clear,
    add  message(answer(db_reply(TT,Telephone,K)))
ip  bound(TT),
    has_att_val(Company,Telephone,TT,K) ).

%%%%%%%  TELEPHONE SECTION %%%%%%%%%%%%%%%%%%%%%%%%

hasattvalgen2 rule bustrans:(
is  which(A),   A isa Telephone ,
    has/Person/Telephone/X/A,
    X  isa _Man
id  clear,
    add  message(answer(db_reply(X,Telephone,N)))
ip  bound(X),
    has_att_val(Person,Telephone,X,N) ).


nopicture rule bustrans:(   %% have you got a picture
is  _ isa picture,clear
id  clear,
    addfront message(sorryno(picture))
ip  [] ).

nomap rule bustrans:(   %% Moved forward
is  _ isa map,clear
id  clear,
    addfront message(sorryno(map))
ip  [] ).     % message necessary also for  empty answer


wherefinddn rule bustrans:( % user knows you don't know,  I dont know
is (which(A),B isa self,A isa place,
    (do)/find/B/C/E,event/real/E,srel/in/place/A/E,C isa _Topic)
id add  message(answer(db_reply(tt,webaddress,K)))
ip has_att_val(company,webaddress,tt,K) ).


wheretram rule bustrans:( % Where does the tram go
is  exactly (which(A),A isa Place,srel/_NI/place/A/C,B isa tram,(do)/GO/B/C,event/real/C)
id	 atday(Day),
    add (findstations(TheTram,Day,Stl),
         passesstations(TheTram,Day,Stl,_)) %
ip  dmeq([go,leave,run,pass],GO),unbound(B),
    dmeq([station,place],Place),
    thetramno(TheTram) ).   %% ONLY ONE TRAM


knowtram rule bustrans:(  % Where does the bus go
is  exactly (which(A),A isa place,srel/_NI/place/A/C,B isa tram,(do)/GO/B/C,event/real/C)
id	 add	message(mustknow(tram))
ip  dmeq([go,leave,run,pass],GO),
    unbound(B),
   \+ thetramno(_) ). %% test


wherecanigo rule bustrans:( % Where can I go
is  exactly (which(A),B isa self,(do)/Go/B/C, srel/_NI/place/A/C,A isa place,event/real/C),
    {dmeq([go,run,leave,pass],Go)}
id	 add	message(mustknow(bus))
ip  [] ).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% SECTION DATE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


normalizedate rule bustrans:(
is  replaceall (F58 isa time,(do)/go/F56/F57,srel/in/time/F58/F57,
                            DATE isa date,srel/_/_/DATE/F57)
    with       (F58 isa time, %% in case when ...
                (do)/go/F56/F57, DATE isa date, srel/on/date/DATE/F57)
id  []
ip  [] ).


setexdatenightdateextra rule bustrans:(   %% nightbus, date is given
is  context(DATE isa date)
id  flag(nightbusflag),
    not atdate2(_,_),
    add atdate2(DaySeqNo,DATE),
    addcon  atday(Saturday)
ip  \+ (DATE = date(_,12,24)), %% not in the evening!
    \+ (DATE = date(_,12,31)),
    extraallowed_night(DATE,Saturday),
    dayModSeqNo(DATE,DaySeqNo) ).


setexdatenightdateextraotherwise rule bustrans:(   %%
is  []
id  flag(nightbusflag),
    atdate2(_DaySeqNo,DATE),
    not atday(_),
    add  atday(Saturday)
ip  busdat:extraallowed_night(DATE,Saturday) ).



setexdatenightdateextratoday rule bustrans:( %%  monday 27, "nightbus"
is  not present _ isa day,
    not present _ isa date %% julaften count as "day" and allows night to next day
id  flag(nightbusflag),
    not atday(_),
    add  atday(Saturday),
    add atdate2(DaySeqNo,ED)
ip  timenow(D), D > 0430, %% NOT monday 27 between 2400 - 0059
    todaysdate(DATE),
    add_days(DATE,1,ED),
    extraallowed_night(ED,Saturday),
    dayModSeqNo(DaySeqNo,ED) ).


setexdatenightdateextralatertonight rule bustrans:( %%  monday 27,morning
is  not present _ isa day,
    not present _ isa date %% julaften count as "day" and allows night to next day
id  flag(nightbusflag),
    not atday(_),
    add  atday(Saturday)
ip  timenow(D), D =< 0400,
    todaysdate(DATE),
    busdat:extraallowed_night(DATE,Saturday) ).



crazyrudolph rule bustrans:( %% day is given as e.g. julaften, converted to
                  %% date but should be interpreted allowing night to next day
is  srel/NILON/date/Date1/_, { bound(Date1)},
    Date1 isa date,
    assume( dmeq( [nil,on], NILON ) ),
    not present _ isa morning,
    not present _ isa morrow, %% Norw  morgen ambig.
    not  comp/day/ne/_/_
id  flag(nightbusflag),
    not atdate2(_,_),
    add atdate2(DaySeqNo,ED),
    addcon atday(Saturday)
ip  xweekday(Date1,H),
    today(T),  T \== H,
    add_days(Date1,1,ED),
    extraallowed_night(ED,Saturday),
    dayModSeqNo(DaySeqNo,ED) ).

setdatexdagnattextra rule bustrans:(  %% Nightbus Friday (night) = Saturday
is  srel/NILON/Day/F74/_ ,
    assume( dmeq( [nil,on], NILON)),
    assume( dmeq( [day],Day ) ), %% date?
    F74 isa Friday,
    not present _ isa morning,
    not present _ isa morrow, %% Norw  morgen ambig.
    not (YMD isa date) when { bound(YMD)},
    not  comp/day/ne/_/_
id  flag(nightbusflag),
    not atdate2(_,_),
    add atdate2(DaySeqNo,DATE),
    addcon atday(Saturday)
ip  dmeq(mtwtfss,Friday),
    today(Tuesday),
    daysucc(Friday,Saturday),
%   number_of_days_between(Tuesday,Saturday,N),        %% RS-141115. Clock is extended until 27:59, the SAME day!
    number_of_days_between(Tuesday,Friday,N),   
    finddate(N,DATE),                                   %% RS-141115. Clock is extended until 27:59, the SAME day!
    extraallowed_night(DATE,Saturday),
    dayModSeqNo(DATE,DaySeqNo) ).


setdatexdagnatt1 rule bustrans:(  %% Nightbus Friday (night) = Saturday
is  srel/NILON/Day/F74/_ ,
    assume(dmeq([nil,on],NILON)),
    assume(dmeq([day],Day)),
    F74 isa Friday,
    not present _ isa morning,
    not present _ isa morrow, %% Norw  morgen ambig.
    not (YMD isa date) when { bound(YMD)},
    not  comp/day/ne/_/_
id  flag(nightbusflag),
    not atdate2(_,_),
    add atdate2(DaySeqNo,DATE),
    addcon atday(Saturday)  %% <-----
ip  dmeq(mtwtfss,Friday),
    today(Tuesday),
    daysucc(Friday,Saturday),
%   number_of_days_between(Tuesday,Saturday,N),        %% RS-141115. Clock is extended until 27:59, the SAME day!
    number_of_days_between(Tuesday,Friday,N),   
    finddate(N,DATE),
    \+ disallowed_night(DATE),
    dayModSeqNo(DATE,DaySeqNo) ).



setdatexdagnatt2 rule bustrans:(  %% Nightbus Friday night = Saturday
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
%    daysucc(Friday,Saturday),
%   number_of_days_between(Tuesday,Saturday,N),        %% RS-141115. Clock is extended until 27:59, the SAME day!
    number_of_days_between(Tuesday,Friday,N),   
    finddate(N,DATE),
    dayModSeqNo(DATE,DaySeqNo) ).

setexdateinatt rule bustrans:(  %% Nightbus tonight
is  present srel/This_midnight/time/_/_,
    not (YMD isa date) when { bound(YMD)},
    not  comp/day/ne/_/_
id  flag(nightbusflag),
    not atdate2(_,_),
    add atdate2(DaySeqNo,DATE),
    addcon  atday(Saturday)
ip  dmeq([this_midnight,tonight],This_midnight),
    today(Friday),
    daysucc(Friday,Saturday),
    timenow2(0,HHMM), HHMM > 430, %%  not at midnight
%   finddate(1,DATE), %% find date tomorrow
    finddate(0,DATE),           %% RS-141115. Clock is extended until 27:59, the SAME day!
    dayModSeqNo(DATE,DaySeqNo) ).


setexnighttodate  rule bustrans:(  %% natt til/før 1. mai
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
    dayModSeqNo(DATE,DaySeqNo) ).

setexdagnattxmas  rule  bustrans:( %% Special rules for Xmas/NewYear/Easter 2005(-2015)
is  not srel/T/day/_/_   when { T \== today},
    not srel/_/date/_/_
id  flag(nightbusflag),
    today(Friday),      %% RS-150404 Asked day?
    not atdate2(_,_),
    clear,
    add message(generalnightbusxmas),
    add flag(exit),
    add flag(fail),      %% Force neganswer for easter (not for XMas!)
    add flag(nightbusflag)             %% Somewhat dirty
ip  timenow2(0,T), T > 0430,
    today(Tuesday),     %% RS-150404 Real day?
    daysucc(Friday,Saturday),
    number_of_days_between(Tuesday,Saturday,N),
    finddate(N,DATE),
    disallowed_night(DATE) ).

%% RS-141115. OLD: Tram-Clock is extended until 27:59, the SAME day!

%%%% when nightbus is referred by Friday or Saturday, it means the following day (after midnight).
%%%  But Sunday still means "very early Sunday Morning"
setexdagnattdespair  rule bustrans:(    %% nightbus query after 0430 means next day
is  not srel/TO/day/_/_ when { TO \== today},      %% day not mentioned, except as today
    not srel/_/date/_/_,      %% no explicit date mentioned
    not srel/nil/midnight/_/_, %% ikke "natt til"
    _ isa Friday , {dmeq(mtwtfss,Friday)}
id  flag(nightbusflag),
    not atdate2(_,_),
    add  atday(Saturday),
    add atdate2(DaySeqNo,DATE)
ip  % timenow2(0,Time), Time > 0430, %% This messes up "after midnight nightbus on xDay queries".
    today(Tuesday),
%                            daysucc(Friday,Saturday),    %% RS-150103
    ( Friday \== sunday  ->  daysucc(Friday,Saturday)  ;  Friday=Saturday ),    %% RS-150103. Sunday can mean Sunday (morning)!
    number_of_days_between( Tuesday, Saturday, N ), %% Or Tuesday to Friday
    finddate(N,DATE),
    \+ extraallowed_night(DATE,_),
    \+ disallowed_night(DATE),
    dayModSeqNo(DATE,DaySeqNo) ).



nightbusmeanstomorrow  rule bustrans:(    %% nightbus query after 0430 means next day
is  not srel/Tod/day/_/_  when { Tod \== today},      %% day not mentioned, except as "today"
    not srel/_/date/_/_,       %% no explicit date mentioned
    not srel/nil/midnight/_/_ %% natt til
id  flag(nightbusflag),
    not atdate2(_,_),
%    add  atday(Friday),        %% RS-141115. Tram Clock is extended until 27:59, the SAME day!
    add  atday(Saturday),       %% RS-141115. But not for ALL 1xx-nightbuses. Fixed the Tram!
    add atdate2( DaySeqNo, DATE )
ip  timenow2(0,T), T > 0430,
    today(Friday),
    daysucc(Friday,Saturday),  
%    finddate(0,DATE),           %% RS-141115. Tram-Clock is extended until 27:59, the SAME day!
   finddate(1,DATE),           %% RS-141115. Bus-Clock is NOT extended until 27:59, the SAME day!
    \+ extraallowed_night(DATE,_),
    \+ disallowed_night(DATE),
    dayModSeqNo( DATE, DaySeqNo ) ).





setexeveningbefore  rule bustrans:(  %% kveld  før dato
is  F18 isa night, %% i.e. evening,
    srel/nil/daypart/F18/E,
    replace (DATE isa date) with (NEXTDATE isa date),
    replace (srel/To/_date/DATE/E) with (srel/on/_date/NEXTDATE/E)
id  not flag(nightbusflag),
    not atdate2(_,_)
ip  dmeq([to,before],To),
    sub_days(DATE,1,NEXTDATE) ).


setexoneveningbefore1  rule bustrans:(  %% på/om kveld  før dato
is  F18 isa night, %% i.e. evening,
    srel/On/night/F18/E, { dmeq([on,during2],On)},
    replace (DATE isa date) with (NEXTDATE isa date),
    replace (srel/To/_date/DATE/E) with (srel/on/_date/NEXTDATE/E)
id  not flag(nightbusflag),
    not atdate2(_,_)
ip  dmeq([to,before],To),
    sub_days(DATE,1,NEXTDATE) ).



setexoneveningbefore2  rule bustrans:(  %% på/om kveld  før dato
is  srel/in_night/time/nil/E,
    replace (DATE isa date) with (NEXTDATE isa date),
    replace (srel/To/_date/DATE/E) with (srel/on/_date/NEXTDATE/E)
id  not flag(nightbusflag),
    not atdate2(_,_)
ip  dmeq([to,before],To),
    sub_days(DATE,1,NEXTDATE) ).


nodatecalc  rule bustrans:(  %%  N dager  før dato % NIX
is  _ isa day, not _ isa date,
    DATE isa date,
    srel/To/_Date/DATE/_, { dmeq([to,before,after],To)},
    clear
id  not flag(nightbusflag),
    not atdate2(_,_),
    clear,
    add message(mustknow(date))
ip  [] ).


% SECTION   SET EXPLICIT DATE


setexdateomndays1 rule bustrans:( %% om tre dager
is   srel/during2/_Duration/N/_,{bound(N)},
     context(N isa day)                     %% nof days
id   not atdate2(_,_),
     add atdate2(DaySeqNo,DATE),
     add atday(ThatDay)
ip   finddate(N,DATE),
     xweekday(DATE,ThatDay),
     dayModSeqNo(DATE,DaySeqNo) ).

setexdateomnweeks rule bustrans:( %% om 1 uke dager
is   context(N isa week),{bound(N)},
     srel/during2/time/N/_
id   not atdate2(_,_),
     add atdate2(DaySeqNo,DATE),
     add atday(ThatDay)
ip   N7 is N*7,
     finddate(N7,DATE),
     xweekday(DATE,ThatDay),
     dayModSeqNo(DATE,DaySeqNo) ).

setexdate1previous rule bustrans:(  %% Previous Monday means 7 days ago
is  not (YMD isa date) when { bound(YMD)},  %% another date overrule bustrans:(s
    context(U isa Monday),
    adj/_/previous/U/_  %%
id  not atdate2(_,_),
    add atdate2(DaySeqNo,DATE),
    add atday(Monday)
ip  dmeq(mtwtfss, Monday),
    today(Thursday),
    number_of_days_between(Thursday,Monday,N),
    N7 is N -7,
    finddate(N7,DATE),
    dayModSeqNo(DATE,DaySeqNo) ).

%%%% Next Monday means in a week if Monday  %% However, next tuesday means tuesday (PRAGMATIX)
setexdate1next rule bustrans:(
is  not (YMD isa date) when { bound(YMD)},  %% another date overrule bustrans:(s
    context(U isa Monday),
    adj/_/next/U/_  %% NEXT MONDAY
id  not atdate2(_,_),
    add atdate2(DaySeqNo,DATE),
    add atday(Monday)
ip  dmeq(mtwtfss, Monday),
    today(Monday),
    finddate(7,DATE),
    dayModSeqNo(DATE,DaySeqNo) ).

setexdatemidnighteaster rule bustrans:(  %% midnight in easter
is  context (DATE isa date)
id  flag(nightbusflag),
    add message(generalnightbuseaster),
    not flag(exit),
    add flag(exit)
ip  disallowed_night(DATE) ).


setexdate1 rule bustrans:(   %% Set date if another day //  på mandag
is  not (YMD isa date) when { bound(YMD) },  %% another date overrule bustrans:(s
    context(U isa Monday),  {dmeq(mtwtfss, Monday)},
    not  comp/day/ne/_/U,            %% not excluded !
    not present srel/today/_Day/nil/_ %% søndagsrute idag ...
id  not flag(exit),
    not atdate2(_,_),
    add atdate2(DaySeqNo,DATE),
    addcon atday(Monday)  %% <-----
ip  today(Thursday),
    Thursday \== Monday,
    findfirstcomingdate(Monday,DATE),
    dayModSeqNo(DATE,DaySeqNo) ).

setexdatenamed rule bustrans:(   %% Set date if named date
is  context(KHFD isa date),
    not YYYY isa year when { (number(YYYY),\+ this_year(YYYY))}
id  not atdate2(_,_),
    add atdate2(DaySeqNo,DATE),
    addcon atday(XDAY)
ip  bound(KHFD),
     named_date(KHFD,DATE),
     xweekday(DATE,XDAY),
    dayModSeqNo(DATE,DaySeqNo) ).

setexdate3nightextra rule bustrans:(   %% date  via 2. juledag ->  date -> night to 3. X
is  context(DATE isa date) %% HAIRY
id  flag(nightbusflag),
    not atdate2(_,_),
    add atdate2(DaySeqNo,ED),
    addcon  atday(Saturday)
ip  add_days(DATE,0,ED), %% If date means same date
    dayModSeqNo(ED,DaySeqNo),
    extraallowed_night(ED,Saturday),
    dayModSeqNo(DaySeqNo,ED) ).

setexdate3nightcrazy rule bustrans:(   %% Set date if explicit midnight Xmas
is  DATE isa date
id  flag(nightbusflag),
    not atdate2(_,_),
    add message(generalnightbusxmas),
    add flag(exit)
ip  (DATE = date(_,12,24); %% not in the evening!
    (DATE = date(_,12,31))) ). %%


setexdate3night rule bustrans:(   %% Set date if explicit  midnight
is  context(DATE isa date)
id  flag(nightbusflag),
    not atdate2(_,_),
    add atdate2(DaySeqNo,DATE),
    addcon  atday(XDAY)
ip  \+ disallowed_night(DATE),
    xweekday(DATE,XDAY),
    dayModSeqNo(DATE,DaySeqNo) ).


setexdate3daynil rule bustrans:(   %% ask for days of date outside periods
is  DATE isa date
id  addcon atday(XDAY),
    add message(date_isa_day(DATE,XDAY)),
    add message(noroutesforthisdate),
    add flag(exit)
ip  xweekday(DATE,XDAY),
    decide_period(DATE,TTP), %  set(actual_period, ThePeriod)
    TTP == nil ). %% <---- %% allow 21.4 2012

%%%%     N isa day, srel/during2/time/N/B, %% om N dager


setexdate3day rule bustrans:(   %% Set date if explicit (Normal case)
is  context(DATE isa date)
id  not flag(nightbusflag),
    not atdate2(_,_),
    add atdate2(DaySeqNo,DATE),
    addcon atday(XDAY)
ip  xweekday(DATE,XDAY),
    decide_period(DATE,TTP), %  set(actual_period, ThePeriod)
    TTP \== nil, %% <----
    dayModSeqNo(DATE,DaySeqNo),
    set(samedayflag,false) ). %% Avoid time after now

%% End setexdate section


nightbusholidayno  rule bustrans:( %%  CASE: NIGHTBUS DATA  MISSING
is  not present _ isa price , clear %% <-----------------
id  flag(nightbusflag),
    not flag(exit),
    add flag(nightbusflag), %% Duplicate? RS-150404
    add flag(exit),
    atday(Day),
    add message(nonightbusesthen) %%
ip  findfirstcomingdate(Day,Date), %% NEW datecalc ).pl
    \+ busdat:extraallowed_night(Date,_),
    disallowed_night(Date) ).


nottodaybutholiday rule bustrans:(
is  []
id  not atday(_),
    not message(nodates), % no point if no routes
    atdate2(_DaySeqNo,DATE),
    add atday(holiday)
ip  date_day_map(DATE,Holiday),
    special_day(Holiday) ).



holywood1 rule bustrans:(   %% Holiday , but same date !!!
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
    todaysdate(DATE),
    set(samedayflag,true) ).


holywood2 rule bustrans:( %% Holiday , but another day
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
    special_day(Holiday) ).


nottoday1 rule bustrans:( % on a day not today %% after holywood
is  []
id  %% not flag(nightbusflag), %% confusing
  atday(Day0), %% on monday aug 1., ask monday aug 22 ! #
    atdate2(_DaySeqNo,DATE),
    not flag(exit),
    not message(nodates), % no point if no routes
    not message(date_isa_day(_,_)),
    not message(otherperiod(DATE)), %% Used as Retention flag
    add message(date_isa_day(DATE,Day)), %% addfront ?
    add message(otherperiod(DATE))
ip  \+ value(samedayflag,true),
     \+ today(Day0),
    todaysdate(Todate),
    Todate \== DATE,
    weekday(DATE,Day) ).


nottoday2 rule bustrans:( % on a date not today
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
          special_day(Holiday)) ).


nottoday3 rule bustrans:( % on correct day today but wrong date!
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
    TODAY \== DD ).

noroutesfordate rule bustrans:( %% TA-110203  Special dates outside valid routeplan
is   not srel/today/_/_/_ ,
     DATE isa date , {bound(DATE)} %% TA-110408

id   not message(nodates),  %% not addcon
     not flag(decide_period),
     addfront flag(decide_period),
     add   message(noroutesforthisdate), %% addfront
     add flag(exit)  %% dont make connections
ip   todaysdate(TODAY), %% UNLESS DIFFERENT TIMEZONE AND CHANGE OF DATE
     \+ (TODAY =DATE),
      implies( decide_period(DATE,X),X=nil) ).


whatistime0 rule bustrans:( %% what is the time %% Fronted
is  which(A),(B isa clock,event/real/C,dob/be/B/A/C)
id  add (timenow2(0,T),timeis(T)),
    add flag(exit) %% avoid  May 1. same route ... %% TA-110502
ip  [] ).


mapday1 rule bustrans:( %% Mapped  day , but same date !!!
is   []
id   not flag(fail),
     not flag(exit),
     not flag(nightbusflag),
     atday(_Day),
     atdate2(_DaySeqNo,DATE),
     not message(nodates),
     not message(mustknow(place)),
     not message(mustknowanother(place)),
     not message(date_day_route(date(_YYYY,_MM,_DD),_AnyDay)),
      not  timeis(_),                 %% spurte om klokka <--
     add message(date_day_route(DATE,MapDay)),
     remove atday(_),
%%     add atday(MapDay)        %% RS-130327 Not needed when "Real routes are provided"?
     add atday(MapDay)
ip   todaysdate(DATE),
     date_day_map(DATE,MapDay),
     \+  special_day(MapDay),
    set(samedayflag,true) ). %% AD HOC, global


mapday2 rule bustrans:( %% Map day , but another date
is   []
id   not flag(fail),
     not flag(exit),
     not flag(nightbusflag),
     atday(_Day),
     atdate2(_DaySeqNo,DATE),
     not timeis(_),    %% spurte om klokka
     not message( nodates ),
     not message( otherperiod(date(YYYY,MM,DD),_) ),
     not message( date_day_route( date(YYYY,MM,DD), _ ) ),
     
     add message( date_day_route( DATE, MapDay ) ),

     remove atday(_),
%%     add atday(MapDay)        %% RS-130327 DO NOT use when "Real routes" (Separate Christmas/Easter modules) are provided?
     add atday(MapDay)
ip   date_day_map( DATE, MapDay ),
     \+  special_day(MapDay) ).


morrow0 rule bustrans:( % ...tomorrow // out of period! %% TA-100916
is  srel/tomorrow/day/nil/_ ,
    not _ isa ticket,
%%%%    not _ isa reservation    %% etc ad n
    not _ isa saturdayroute,  %%  (unless saturday tomorrow?)
    not _ isa sundayroute     %%
id	 not atday(_),                  %% e.g. i morgen torsdag
    add (today(Day),
         atday(NextDay),
         atdate2(DaySeqNo,DATE)),
    add message(noroutesforthisdate), %%%%add message(mustknow(date)), %% Ad Hoc
    add flag(exit)  %% fail? %% Avoid "umulig på nyrsdag"
ip	 today(Day),   %% Instantiate it
    daysucc(Day,NextDay),
    finddate(1,DATE),
    \+ dayModSeqNo(DATE,DaySeqNo) ).


morrow1 rule bustrans:( % ...tomorrow
is  srel/tomorrow/day/nil/_ ,
    not _ isa ticket,
%%%%    not _ isa reservation    %% etc ad n
    not _ isa saturdayroute,  %% (unless saturday tomorrow?)
    not _ isa sundayroute     %%
id	 not atday(_),                  %% e.g. i morgen torsdag
    add (today(Day),
         atday(NextDay),
         atdate2(DaySeqNo,DATE))
ip	 today(Day),   %% Instantiate it
    finddate(1,DATE),
    dayModSeqNo(DATE,DaySeqNo),
    daysucc(Day,NextDay) ). %% TA-100916



morrow2 rule bustrans:( % ...day_after_tomorrow
is  srel/day_after_tomorrow/day/nil/_
id  not atday(_),
    add (today(Day),
         atday(Day2),
         atdate2(DaySeqNo,Date))
ip	 today(Day),
    daysucc(Day,Day1),
    daysucc(Day1,Day2),
    finddate(2,Date),
    dayModSeqNo(Date,DaySeqNo) ).

yester1 rule bustrans:( % ...yesterday
is  srel/yesterday/day/nil/_ %% time => day
id	 not atday(_),
    add (today(Day),atday(PrevDay),atdate2(DaySeqNo,Date))
ip	 today(Day),daysucc(PrevDay,Day),
    finddate(-1,Date),
    dayModSeqNo(Date,DaySeqNo) ).

yester2 rule bustrans:( %   day_before_yesterday | forgårs
is  srel/day_before_yesterday/day/nil/_ %% time => day
id	 not atday(_),
    add (today(Day),
         atday(PrevDay),
         atdate2(DaySeqNo,Date))
ip	 today(Day),
    daysucc(Day1,Day),
    daysucc(PrevDay,Day1),
    finddate(-2,Date),
    dayModSeqNo(Date,DaySeqNo) ).


whatisdate  rule bustrans:( %% hva er datoen
is  exactly(which(A), B isa date,dob/be/B/A/C,event/real/C) %% TA-110411
id	 add (atday(Day),
         message(date_isa_day(date(Year,Month,DayNr),Day)))
ip	 today(Day),
    datetime(Year,Month,DayNr,_,_,_) ).



%%%% END SECTION DATE  %%%%%%%%%%%%%%%%%%%%%



notabusperiod rule bustrans:(
is  (NotBus isa BR),clear
id	 atdate2(_,_), %% at least know that
    not atday(easterhol),
    not message(noroutesforthisdate),
    add message(notinperiod(route,NotBus))
ip	 atomic(NotBus),  NotBus \== it, %% internal anaphora  :-)
    dmeq(bus,BR),
    \+ exbus(NotBus),
    regbus(NotBus),  %% tt/regbusall
    \+ vehicletype(NotBus,tram) ).


nightbus0  rule bustrans:( %% date is a holiday, no nightbuses
is  not present _ isa price
id  atdate2(_DaySeqNo,EX),
    flag(nightbusflag),
    atday(holiday),
    not flag(exit),
    add flag(exit),
    add message(standnight)
ip  \+  busdat:extraallowed_night(EX,_) ).



nonightbusgen rule bustrans:( % no nightbus, no nightbus on, on saturday/sunday
is  NB isa nightbus,  { unbound(NB)},
    not present dob/cost/_/_/_,
    not present _ isa price,
    not present _ isa station,
    not present _ isa street,
    not present C isa neighbourhood when {(C \== sentrum)}
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
    add message(nonightbusesthen), %% <---
    add flag(exit)
ip  \+ disallowed_night(Date),
%%%% test if following saturday is disallowed (then no default nightbus message)
   ( disallowed_night(Easter),
     days_between(Date,Easter,N), %% datecalc.pl
     N >=1, N =< 5) ). % sunday morn - saturday ok



busgennatta  rule bustrans:( % bus om natta, tbus, no number, no destination
is  _ isa midnight,
    not present dob/cost/_/_/_,
    not present _ isa price,
    not present _ isa station,
    not present _ isa street,
    not present C isa neighbourhood when { (C \== sentrum)}
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
ip  \+ disallowed_night(Date) ).


nightbusgen  rule bustrans:( % nightbus, no number, no destination
is  NB isa nightbus , {unbound(NB)},
    not present dob/cost/_/_/_,
    not present _ isa price,
    not present _ isa station,
    not present _ isa street,
    not present C isa neighbourhood when { (C \== sentrum)}
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
ip  \+ disallowed_night(Date) ).



nightbusfromcenter  rule bustrans:( % nightbuses go ordinarily from center
is  NB isa nightbus, %% a nightbus is mentioned
    not present dob/cost/_/_/_,
    not present _ isa price ,
    not present sentrum isa _,
    not present srel/from/place/_/_,
%     not present srel/nil/place/_/_ , %% nattbuss risvollan
    not present OT isa station  when {nightbusstation( OT)}
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
    \+ buslog:neverpasses(NB,OT),
    findfirstcomingdate(Day,Date), %% NEW datecalc.pl
    \+ disallowed_night(Date),
    newfree(E) ).


nightbusonly  rule bustrans:( % nightbuses go from center
is  not present _ isa price,
    present Bus isa nightbus
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
     newfree(E) ).


hittegods rule bustrans:( %%  jeg har glemt noe på bussen
is  srel/on/bus/_/_, dob/Forget/_/_/_, {dmeq([forget,lose],Forget)}
id  add ( message(answer(db_reply(tt,webaddress,K)))),  %% will be executed in order
    addfront(message(noinfoabout(luggage)))
ip  has_att_val(company,webaddress,tt,K) ).


handicap_topic rule bustrans:( %% ask for handicap related information (not SMS) % EE-1503dd
is  _ isa Handicap, { value(smsflag,false) }, clear
id  addfront(message(handicap_info)),
%id  add message(handicapinfo),
    add flag(exit)
ip  dmeq([handicap,handicapped,lowentry,lowentry_bus,pram,room,wheelchair], Handicap)).

handicap_topic_sms rule bustrans:( %% ask for handicap related information (SMS) % EE-1503dd
is  _ isa Handicap, { value(smsflag,true) }, clear
id  addfront(message(handicap_info_sms)),
    add flag(exit)
ip  dmeq([handicapped,lowentry,lowentry_bus,pram,room,wheelchair], Handicap)).

atb_topic rule bustrans:( %% no info but pointer to TEAM < nodates
is   _ isa Special_ticket,clear
id  not  message(answer(db_reply(tt,webaddress,K))),  %% ref buyticket
    add  message(answer(db_reply(tt,webaddress,K))),  %% will be executed in order
    addfront(message(noinfoabout(Special_ticket)))
ip   dmeq([agelimit,animal,bag, camera, cat, %% TA-110121 %% RS-150415 bicycle,
           dog,discount, extrabus,
           flexibus,gasbus,  articulated_bus,lowentry,lowentry_bus,
           card, %% overview, %% RS-150415 handicapped,
           luggage,military,
           package,pensioner,pram,room,   %% TA-100829
           ringroute,season_ticket,shed,ski,
           shuttleroute,speed, %% smoking,
           schoolbus,special_ticket,strike,
           student,toilet,transfer,travelinsurance, %% TA-100903
           wallet,wheelchair,zone],
        Special_ticket),
    has_att_val(company,webaddress,tt,K) ).

%
wheniseaster rule bustrans:(   %% ask for period, specify DAY. (Or assume [easter/Xmas] _eve?)
is   which(A), A isa time, B isa Easter, srel/in/time/A/C, do/Come/B/C, event/real/C,
        { dmeq( [easter, whitsun, christmas ], Easter ), dmeq( [ be1, come ], Come ),
          append_atomlist( [ Easter, '_eve' ], EasterEve ), named_date( EasterEve, DATE) },
     not _ isa date,
     not _ isa holiday,
     not srel/today/_Day/nil/_,
     not _ isa morrow,
     add context(DATE isa date)                 %replace  B isa Easter  with  EasterEveDate isa Date
     %clear
     %replace Easter with Easter-eve
id   %clear,
%     addfront message( mustknow(day) )
     addfront message( assumeeve( EasterEve ) ) %DayEve. Messages are printed even if the ans-program is fail.
ip   [] ).



irregular rule bustrans:( %% irregularity
is  srel/regularly/time/_/_
id  addcon(message(noinfoabout(irregularity)))
ip  [] ).


morrowholiday rule bustrans:( % ...tomorrow (is a specialday)
is  srel/tomorrow/day/nil/_ ,
    not _ isa ticket,
    not _ isa reservation %% etc ad n
id	 not atday(_),                  %% e.g. i morgen torsdag
    add (today(Day), atday(Hol),atdate2(DaySeqNo,Date))
ip	 today(Day),   %% Instantiate it
    finddate(1,Date),
    date_Day_map(Date,Hol),
    dayModSeqNo(Date,DaySeqNo) ).

notyesterdaydate rule bustrans:( % between 0000 and 0059, tomorrow mwans same day
is    present   srel/tomorrow/day/nil/_,
    _ isa bus or _ isa departure,

    not present ( _ isa saturdayroute),
    not present ( _ isa sundayroute),
    not present ( _ isa clock),
    not present dob/cost/_/_/_,
    not present _ isa winter,
    not present _ isa summer

id  not reply(_),
    not flag(exit),
    not message(completesentence),

    not atday(_),
    not atdate2(_,_),

    add (today(Today),
         atday(Today))

ip  timenow(G), G < 60, %% < 01:00 at night
    today(Today)

 ) :-single.



%%%% before morrow1
yesterdaydate rule bustrans:( % between 0000 and 0059, date is set to yesterday
     %   -> spurious if  no deps, but rule must apply early
is  _ isa bus or _ isa departure,
    not present _ isa morrow,
    not present _ isa morning,   %% TA-110724
    not present   srel/tomorrow/day/nil/_,
    not present ( _ isa saturdayroute), %% Rough
    not present ( _ isa sundayroute),
    not present ( _ isa clock),
     not present adj/_/_/_/_, %% //next
    not present dob/cost/_/_/_,
    not present _ isa winter,
    not present _ isa summer %% etc etc

id  not reply(_), %% in case no route
    not flag(exit),
    not atday(_),
    not atdate2(_,_),
    add flag(yesterday),
    add (today(Today),
         atday(Yesterday),
         atdate2(DaySeqNo,YESTERDATE)),
    not message(completesentence)
%%%%%    add message(assumeyesterdepartures)  %% spurious if no deps
%%ip  timenow(G), G < 30, %% < 01:00 at night
ip  timenow(G), G < 60, %% < 01:00 at night
    today(Today),
    daysucc(Yesterday,Today),
    todaysdate(DATE),
    sub_days(DATE,1,YESTERDATE),
    dayModSeqNo(YESTERDATE,DaySeqNo)
) :-single.





dianotoday rule bustrans:( % check in frames:  if not explicit today, keep old date
is  not srel/today/_Day/nil/_ ,
    not srel/now/time/nil/_
id  not flag(exit),
    not atday(_),
    not atdate2(_,_),
    not message(completesentence) ,
    add today(Today),
    add atday(Day)
ip  today(Today),
    frame_getvalue(day,Day,day),
    Day \== Today
  ):- double.


todaydatedefault rule bustrans:( % ...if no day is mentioned, default to today
is  []
id  not flag(exit),
    not atday(_),
    not atdate2(_,_),
    
    add (today(Day),
         atday(Day) ),  %% atday only temporary for dialog
    not message(completesentence)
ip  today(Day)
 ):- double.



todaydate rule bustrans:( % ...if no day is mentioned, default to today
is  not present ( _ isa saturdayroute), %% Rough
    not present ( _ isa sundayroute)
id  not flag( exit ),
    not atday( _ ),
    not atdate2( _, _ ),
    add ( today( Day ),
          atday( Day ) ),  %% atday only temporary for dialog
    not message( completesentence )
ip  today( Day )
 ):-single.


atdate rule bustrans:( %%   Find the actual date
is  not present _ isa weekday
id  not flag(exit),
  not flag(nightbusflag), %% if date is not set already
    not message(noroutesforthisdate),
    not atdate2(_,_),
    not message(completesentence),
    add atdate2(DaySeqNo,DATE)
ip  todaysdate(DATE),
    dayModSeqNo(DATE,DaySeqNo) ).


weeknumber0 rule bustrans:( %% hvilken uke (nr)  er i morgen // after atdate
is  which(A),A isa week,(do)/exist/_/_
id  atdate2(_,Date),
    add message(date_isa_week(Date,Weekno))
ip	 weeknumber(Date,Weekno) ).

weeknumber01 rule bustrans:( %% hvilken uke er dette ? %% TA-110203
is  which(A),A isa week
id  atdate2(_,Date),
    add message(date_isa_week(Date,Weekno))
ip	 weeknumber(Date,Weekno) ).


weeknumber01 rule bustrans:( %% hvilken uke er vi %% TA-110203
is  which(A),A isa week
id  atdate2(_,Date),
    add message(date_isa_week(Date,Weekno))
ip	 weeknumber(Date,Weekno) ).

weeknumber1 rule bustrans:( %% hvilken uke (nr)  er dette
is  which(A),A isa week,(do)/be1/_/C,srel/in/time/A/C,event/real/C,
    not message(noroutesforthisdate),
    not message(otherperiod(_)),
    not X  isa date when  {bound(X)}
id  add message(date_isa_week(Date,Weekno))
ip	 todaysdate(Date),
    weeknumber(Date,Weekno) ).

weeknumber2 rule bustrans:( %% hvilken uke (nr)  er 1. aug. 2008
is  which(A),A isa week,
    present Date isa date,
    dob/be/A/Date/C,event/real/C
id  add message(date_isa_week(Date,Weekno))
ip	 weeknumber(Date,Weekno) ).


weeknumber3 rule bustrans:( %% hvilken uke (nr)  er i  1. aug. 2008
is  which(A),A isa week,
    present Date isa date,
    (do)/be1/A/C,srel/in/time/Date/C,event/real/C
id  add message(date_isa_week(Date,Weekno))
ip	 weeknumber(Date,Weekno) ).

weeknumber4 rule bustrans:( %% hvilken uke (nr)  er idag
is  which(A),A isa week,
    (do)/be1/A/C,srel/today/time/nil/C
id  add message(date_isa_week(Date,Weekno))
ip	 todaysdate(Date),
    weeknumber(Date,Weekno) ).


nodates02 rule bustrans:( % Special dates without known mapping
is   clear
id   atdate2(_DaySeqNo,DATE),
     not message(nodates),  %% not addcon
     addfront message(nodates),
     add (message(answer(db_reply(tt,webaddress,K))))
ip    date_day_map( DATE,unknown), %% i.e. no route
     has_att_val(company,webaddress,tt,K) ).


nodates03 rule bustrans:(   % General  Date to day mapping
is   remove  srel/_Prep/day/Day/_
id   atdate2(_DaySeqNo,DATE),
     not message(nodates),
     add atday(Day),
     add message(date_isa_day(DATE,Day))
ip   \+ (date_day_map( DATE,Holiday),
         special_day(Holiday)),
     weekday(DATE,Day) ).


nodates04 rule bustrans:(   %% except for the day today
is   N  isa month, not srel/today/_/_/_ ,
     clear
id   not atday(_),          %%  sundays in november OK
     add message(mustknow(date))
ip   bound(N) ).



nodates07 rule bustrans:(   %% except for the day today
is   %% not _ isa time, %% når er påsken %% TA-101124
     not _ isa date,
     not _ isa holiday,
     not srel/today/_Day/nil/_,
     not _ isa morrow,
      _ isa Easter, %% RS-150404 (not not?)
      { dmeq([advent,autumn,fall,spring,
              christmasroute,semester, vacation,whitsun,holiday,easterroute,christmas],
              Easter) }, % easter,easter_eve,easter_eve,palm_sunday,
     clear
id   not message(mustknow(date)), %% RS-150404 avoid endless recursion!
     clear,
     addfront message(mustknow(date))
ip   [] ).

nodates007 rule bustrans:(   %% week %% TA-100914
is    _ isa week, not _ isa date,
     not srel/today/_Day/nil/_,
     clear
id   not atday(_),
     clear,
     addfront message(mustknow(day))
ip   [] ).


nodates08 rule bustrans:(   %% weekend
is    _ isa weekend, not _ isa date,
     not srel/today/_Day/nil/_,
     clear
id   not atday(_),
     clear,
     addfront message(mustknow(day))
ip   [] ).

nodates09 rule bustrans:(   %% month only
is    A isa month,
      not which(A), %% spørre måned -> date %% TA-100828
      not _ isa date,
     not srel/today/_/_/_ ,

     clear
id   not atday(_),
     clear,
     addfront message(mustknow(date))
ip   [] ).

nodates10 rule bustrans:(   %% year only , not ask when
is    _ isa year, not which(_), %% spørre om når
     not _ isa price,
     not _ isa date,
     not _ isa clock,
     not _ isa money,
     not (do)/live/_/_, %% er 5 år
     not srel/today/_/_/_ ,
     not present (_ isa child), %% under 8 år
     clear
id   not atday(_),
     clear,
     addfront message(mustknow(date))
ip   [] ).

nodates11 rule bustrans:(   %% last year
is    _ isa lastyear,
     not (do)/live/_/_, %% er 5 år
     clear
id   not atday(_),
     clear,
     addfront message(noroutesforthisdate)
ip   [] ).


%% RS-150313 TODO: Make two rules to assume either Monday or Saturday (or Sunday?)
unksetexweekday rule bustrans:(   %% after weeknumber# %% TA-110203
is  _ isa Weekday, {dmeq([week,weekday,weekend],Weekday)},
    not (YMD isa date) when { bound(YMD)},  %% another date overrules
    not  comp/day/ne/_/_,            %% not excluded !
    not present srel/today/_Day/nil/_ %% søndagsrute idag ...
id  not atdate2(_,_),
    not message(noroutesforthisdate),
    add message(mustknow(day)),
    add flag(exit)
ip  [] ).


date1 rule bustrans:( % hvilken dato er det.
is  exactly (which(A),A isa DayDate,(do)/Be1/A/B,event/real/B),
      {dmeq(dayordate,DayDate)}
id	 not  message(date_isa_day(_,_)), %% TA-110502
     %%%     (atday(Day),            %%
    addfront  message(date_isa_day(date(Year,Month,DayNr),Day))
ip	 dmeq([be1,exist],Be1),
    today(Day),
    datetime(Year,Month,DayNr,_,_,_) ).

date2 rule bustrans:( % hvilken dato er det i dag
is  exactly (which(A),A isa DayDate,(do)/Be1/A/B,srel/today/_/nil/B,event/real/B)
id	 add (atday(Day),
         message(date_isa_day(date(Year,Month,DayNr),Day)))
ip	 dmeq([be1,exist],Be1),
    dmeq(dayordate,DayDate),today(Day),
	 datetime(Year,Month,DayNr,_,_,_) ).

date2new rule bustrans:( % det er ... idag %% TA-100829
is  exactly (new,A isa DayDate,(do)/Be1/A/B,srel/today/_/nil/B,event/real/B)
id	 add (atday(Day),
         message(date_isa_day(date(Year,Month,DayNr),Day)))
ip	 dmeq([be1,exist],Be1),
    dmeq(dayordate,DayDate),today(Day),
	 datetime(Year,Month,DayNr,_,_,_) ).


date3 rule bustrans:( %% hvilken ... er det nå
is  exactly (which(A),A isa DayDate,(do)/Be1/A/B,event/real/B) %% ,srel/now/_/nil/B)
id	 add (atday(Day),
         message(date_isa_day(date(Year,Month,DayNr),Day)))
ip	 dmeq([be1,exist],Be1),
    dmeq([year,month,day,date],DayDate),today(Day),
    datetime(Year,Month,DayNr,_,_,_) ).


date4 rule bustrans:( %% hvilket år er det i år
is  exactly (which(A),A isa year,B isa year,(do)/Be1/A/C,event/real/C,srel/in/year/B/C)
id	 not atday(_),
    add (atday(Day),
         message(date_isa_day(date(Year,Month,DayNr),Day)))
ip	 dmeq([be1,exist],Be1),
    today(Day),
	 datetime(Year,Month,DayNr,_,_,_) ).


date5 rule bustrans:( % hva er datoen ?
is  which(A),(A isa date,event/real/_),
    not present srel/tomorrow/day/nil/_  % ad hoc
id	 atday(Day),
    atdate2(_,DATE),
    not message(date_isa_day(DATE,Day)), %% TA-100902
    add message(date_isa_day(DATE,Day))
ip	[] ).

date56 rule bustrans:( % hva er datoen %% OUTDATED ???
is  which(A),(A isa date,event/real/_),
    not present srel/tomorrow/day/nil/_  % ad hoc
id	 not atday(_New_years_day),
    not message(otherperiod(_)),
    add (atday(Day),
         message(date_isa_day(date(Year,Month,DayNr),Day)))
ip	 today(Day),
    datetime(Year,Month,DayNr,_,_,_) ).



date6 rule bustrans:( %%   er det mandag (idag)
is  test,A isa XDay,(do)/Be1/A/B,event/real/B
id	 add (atday(Day),
         message(date_isa_Day(date(Year,Month,DayNr),Day)))
ip	 dmeq([be1,exist],Be1),
    dmeq(mtwtfss,XDay),today(Day),
	 datetime(Year,Month,DayNr,_,_,_) ).

date7 rule bustrans:( %% hvilken dato er dette // NB  not  er 25 nov.
is  which(A),A isa day,event/real/_
id  not message(date_isa_day(_,_)),
    not message(noroutesforthisdate),
    not message(otherperiod(_)),
    not atday(Day), %% already
    add (atday(Day),
         message(date_isa_day(date(Year,Month,DayNr),Day)))
ip	 unbound(A),
    today(Day),
    datetime(Year,Month,DayNr,_,_,_) ).


date8 rule bustrans:( % Hvilken dato er det
is  which(Time),Time isa date,dob/be/Time/it/_ %% ad hoc
id	 not atday(_),
    add (atday(Day),
         message(date_isa_day(date(Year,Month,DayNr),Day)))
ip  unbound(Time),
    today(Day),
    datetime(Year,Month,DayNr,_,_,_) ).


date9 rule bustrans:( % hvilket år er det
is  exactly (which(A),A isa Year1,(do)/Be1/A/C,event/real/C)
id	 not atday(_),
    add (atday(Day),
         message(date_isa_day(date(Year,Month,DayNr),Day)))
ip	 dmeq([be1,exist],Be1),
    dmeq([year,month,week,season,leapyear],Year1),
    today(Day),
	 datetime(Year,Month,DayNr,_,_,_) ).


date10 rule bustrans:( %% Hvilken dag er det  imorgen  -> dagen idag
is  exactly (which(A),A isa DayDate,(do)/Be1/A/B,TM isa morrow,event/real/B,srel/in/day/TM/B)
id	   not atday(_),
      addfront message(todayis),
       add (atday(Day),
	        message(date_isa_day(date(Year,Month,DayNr),Day)))
ip	 dmeq([be1,exist],Be1),
    dmeq(dayordate,DayDate),
    today(Day),
    datetime(Year,Month,DayNr,_,_,_) ).

date11 rule bustrans:( %% Hvilken dag er det i går/imorgen  ->  dagen idag
is  exactly (which(A),A isa DayDate,(do)/Be1/A/B,event/real/B,srel/_day/_day/nil/B)
id	    not atday(_),
       addfront message(todayis),
       add (atday(Day),
	        message(date_isa_day(date(Year,Month,DayNr),Day)))
ip	 dmeq([be1,exist],Be1),
    dmeq(dayordate,DayDate),today(Day),
    datetime(Year,Month,DayNr,_,_,_) ).


date12 rule bustrans:( %% Hva er (lik) datoen i morgen
is  which(X), dob/be/X/A/B, A isa DayDate, event/real/B,
    present srel/_Tomorrow_/_Day/nil/B
id	 not atday(_),
    addfront message(todayis),
    add (atday(Day),
	      message(date_isa_day(date(Year,Month,DayNr),Day)))
ip  dmeq(dayordate,DayDate),today(Day),
    datetime(Year,Month,DayNr,_,_,_) ).

date13 rule bustrans:( % hva er datoen.
is  which(A), A isa DayDate, _ isa thing,event/real/_E
id	 add (atday(Day),
         message(date_isa_day(date(Year,Month,DayNr),Day)))
ip	 dmeq(dayordate,DayDate),today(Day),
    datetime(Year,Month,DayNr,_,_,_) ).

date14 rule bustrans:( % hva er datoen idag .
is  which(A), A isa DayDate,_ isa thing,srel/today/_/nil/E,event/real/E
id	 add (atday(Day),
         message(date_isa_day(date(Year,Month,DayNr),Day)))
ip	 dmeq(dayordate,DayDate),today(Day),
    datetime(Year,Month,DayNr,_,_,_) ).


daysdate rule bustrans:( % Hva er dagens dato
is  X isa day, Y isa date, has/day/date/_/_, clear
id	 not atday(_),
    add (atday(Day),
          message(date_isa_day(date(Year,Month,DayNr),Day)))
ip  unbound(X),unbound(Y),
	 datetime(Year,Month,DayNr,_,_,_),
    today(Day) ).


weekday1 rule bustrans:( % ...on weekday ( today is sat/sun)
is  _ isa weekday
id	 not atday(_),
    add atday(monday) %%  TUESDAY is SAFER
ip	 today(Today) , decidewday(Today,WeekDay), WeekDay \== monday ).


weekday2 rule bustrans:( % ...on Day (on friday, etc.)
is  _ isa WeekDay, {   isday(WeekDay)}
id	 not atday(_),
    not atdate2(_,_), %% date overrule bustrans:(s day
    add atday(WeekDay)
ip	 today(TD), WeekDay \== TD ). %% same day means today


weekday3 rule bustrans:(  % ...on Day (on friday, etc.)
is  srel/WeekDay/day/nil/_       %% _ isa Weekday missing (adverbial)
id	 not atday(_),
    add atday(WeekDay)
ip	 isday(WeekDay) ).


weekday4 rule bustrans:( % ... Day (passes risvollan friday, etc.)
is  srel/WeekDay/time/nil/_
id	 add atday(WeekDay)
ip	 isday(WeekDay) ).



dateisaday rule bustrans:( %% Message date is a day
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
     \+ (Day == AtDay) ).


whatkindofroute  rule bustrans:(%% er det lørdagsrute i dag (merkedag)???
is   (_ isa saturdayroute or _ isa sundayroute)
id   not flag(exit),
     not flag(nightbusflag),
     atdate2(_DaySeqNo,DATE),
     not message(nodates),
     not message(date_day_route(date(_YYYY,_MM,_DD),_)),
     not timeis(_),    %% spurte om klokka
     add message(date_day_route(DATE,MapDay))
ip   date_day_map(DATE,MapDay) ).



isitroutetoday  rule bustrans:( %% er det lørdagsrute i dag ?
is  test,
     (_ isa saturdayroute or _ isa sundayroute or _ isa route_plan
     ), %%        or _ isa route ), %% NB ambig. sende ruter
     not present dob/_/_/_/_  %% rough
id   not flag(exit),
     not flag(nightbusflag),
     not timeis(_),    %% spurte om klokka
     not message(nodates),
     %% today(Today), %% maybe blocked by "saturdayroute"
     atdate2(_DaySeqNo,Todate),
     not message(otherperiod(_)),
     not message(date_day_route(_,_)),
     add message(date_day_route(Todate,Today))
%%%%      add flag(exit)
ip   today(Today) ).



whatkindofroutetoday  rule bustrans:( %% er det lørdagsrute i dag ?
is   which(A),( A isa route or A isa route_plan),
     {unbound(A)}, %% hva er 4*4 -> which(4),4 isa route,
     not present _ isa station,
     not present _ isa neighbourhood
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
ip   today(Today) ).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% END DAY AND DATE SECTION

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

whatclockis rule bustrans:(  %% vet du hvor mye klokka er ?
is  B isa clock,event/real/C,dob/be/B/A/C,dob/KNOW1/_/A/D,event/real/D
  ,{dmeq([know,know1],KNOW1)}
id	 add (timenow2(0,T),timeis(T))
ip  [] ).



questionhelp1 rule bustrans:( % hvilke spørsmål ...
is  which(A),A isa question
id  addfront message(thatisagoodquestion)
ip  [] ).


questionhelp2 rule bustrans:( %% Stiller jeg deg et spørsmål nå?
is  test,_ isa question, present dob/Make/_/_/_,
           {dmeq([make,set],Make)}
id  addfront message(thatisagoodquestion)
ip  [] ).


canyouanswer rule bustrans:( %% Hva kan du svare på
is (tuc isa savant,(do)/Ans/Tuc/B,event/real/B),
    not present _ isa language,  %%  kan du noen språk
    not present (do)/go/_/_, %% then not general
    { dmeq([busstuc,bustuc,tuc],Tuc),
      dmeq([know,know1,answer1],Ans)}
id  not message(_),
    add message(howtuchelp),
    add flag(exit)
ip  [] ).


whatdoyouknow rule bustrans:( %% What do you know  also tuchelp3
is  tuc isa savant,dob/KNOW1/Tuc/_A/B,event/real/B,
      { dmeq([know1,answer1,know],KNOW1),dmeq([busstuc,bustuc,tuc],Tuc)},
        not present BB isa bus when {bound(BB)},
        not present _ isa language,  %%  kan du noen språk
        not present (do)/go/_/_ %% then not general
  ,{dmeq([know,know1],KNOW1)},
    not present _ isa clock %% TA-101104
id  not message(_),
    add message(howtuchelp),
    add flag(exit)
ip  [] ).


%%%% "Do you know what... " is superflous

know1 rule bustrans:(
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
    \+ dmeq([tagore,norwegian,english],A) ).  %% kan du norsk


workdayroute rule bustrans:(  %%   (NB  tuesdayroute --> weekday --> monday
is  replaceall ( B isa workdayroute,srel/(with)/bus/B/C)
    with       ( B isa weekday,srel/on/time/B/C)
id  []
ip  [] ).

% Nearest Station Section

fromstreetstatknown rule bustrans:(
is  X isa street, present srel/from/place/X/_
id  add message(nearest_station(start,X,Y))
ip  bound(X),
    X \== it,
    street_station(X,Y), %% station or unknown
    Y \== unknown,
    Y \== '',             %% empty (error in reghpl)
    X \== Y ).              %% if NTH cast as street, differ


tostreetstatknown rule bustrans:(
is  X isa street, present srel/to/place/X/_
id  add message(nearest_station(stop,X,Y))
ip  bound(X),
    X \== it,
    street_station(X,Y), %% station or unknown
    Y \== unknown,
    Y \== '',             %% empty (error in reghpl)
    X \== Y ).              %% if NTH cast as street, differ






streetstatknown rule bustrans:(
is  X isa street
id  add message(nearest_station(nil,X,Y))
ip  bound(X),
    X \== it,
    street_station(X,Y), %% station or unknown
    Y \== unknown,
    Y \== '',             %% empty (error in reghpl)
    X \== Y ).              %% if NTH cast as street, differ




havestation1  rule bustrans:(
is  F isa station,X isa neighbourhood, dob/Have/X/F/_
id  not message(foreign(_)),
    not message(nearest_station(_st,X,_)),
    add message(nearest_station(_st,X,Y))
ip  bound(X),X \== it,
    dmeq([have,belong_to],Have),
    placestat(X,Y),  %% busdat
    station(Y) ). %% NB  E.g. r_i_t_hovedporten is NOT a station on may	 17.


havestation2  rule bustrans:(
is  X isa station,F isa station, dob/Have/F/X/_
id  not message(foreign(_)),
    not message(nearest_station(_st,X,_)),
    add message(nearest_station(_st,' ',X)) %% ad hoc holdeplassen nærmest er
ip  bound(X),X \== it,
    dmeq([have,belong_to],Have),
    station(X) ).


placestatdepend rule bustrans:( %% place stat with bus_depend
is  context (X isa neighbourhood),     %% trondheim is a city
    not present srel/before/place/_/_,
    not present srel/after/place/_/_,
    present B isa bus , { bound(B)}             %% etc
id  not message(foreign(_)),
    not message(nearest_station(_st,X,_)),
    add message(nearest_station(_st,X,Y))
ip  bound(X),
    X \== it,
    bus_place_station(B,X,Y),
    (station(Y) ;  X \== Y) ). %% dont map neib -> neib


whichstationisnear rule bustrans:( %% Hvilken holdeplass ligger nær nardosenteret
                        %% ignorer station, give places  %% TA-110504
is  which(X), X isa station, NS isa station, {bound(NS)},
       srel/Near/place/NS/_, {dmeq([near,around,at,besides],Near)}
id  not message(nearest_station(_st,X,_)),
    not message(nearest_station(_st,_,X)),
    not message(stationsat(A,NS,B)),
    add message(stationsat(A,NS,B))
ip  X \== it,
    stationsat(A,NS,B) ).

placestat1 rule bustrans:( %% %% Hvilket sted  fins på risvollan
is  context (X isa Neighbourhood),   {bound(X)},  %% trondheim is a city
        {dmeq([neighbourhood,company],Neighbourhood)}, %% Lingit
    not present dob/avoid/_/_/_, %%            city_syd ?%% TA-100823 EXPERIMENT
    not present _ isa telephone

id  not message(foreign(_)),
    not message(nearest_station(_ST,X,_)),
    add message(nearest_station(nil,X,Y))
ip  X \== it,
    placestat(X,Y),
    station(Y) ). %% NB  E.g. r_i_t_hovedporten is NOT a station on may	 17.


placestatnearest  rule bustrans:( %% nærmeste holdeplass til Nardosenteret
is  which(F41),F41 isa station,NS isa station,
    adj/_/near/F41/real,
    (do)/be1/F41/E,srel/to/place/NS/E,event/real/E
id  not message(foreign(_)),        %% skulle av ved ...
    not message(nearest_station(_ST,_,_)), %% no doubles
    not message(stationsat(A,NS,B)),
    add message(stationsat(A,NS,B))
ip  [] ).



placestat2 rule bustrans:( %% nærmeste holdeplass til risvollansenteret
is  context (X isa station) ,
    present srel/Near/place/X/E ,
        {dmeq([near,around],Near)},  %% \+ at %% TA-110502 holdeplassen til
    not (do)/be1/_/E %% Ad Hoc   holdeplassen (som er) til travbanevegen %% TA-110503

id  not message(foreign(_)),        %% skulle av ved ...
    not message(nearest_station(_st,_,_)), %% no doubles
    add message(nearest_station(_st,X,X)) %% NB to itself
ip  bound(X),
    X \== it ). % ?

placestat2at rule bustrans:( %% hva er holdeplass ved risvollansenteret %% TA-101004
is  which(_),
    context (X isa station) ,
    present srel/at/place/X/_
id  not message(foreign(_)),        %% skulle av ved ...
    not message(nearest_station(_st,_,_)), %% no doubles
    add message(nearest_station(_st,X,X)) %% NB to itself
ip  bound(X),
    X \== it ). % ?

placestat3 rule bustrans:( %% nærmeste holdeplass [til] risvollansenteret
is  context (X isa station) , dob/be/_/X/_,
          adj/_/nearest/X/real,{bound(X)}
id  not message(foreign(_)),
    not message(nearest_station(_st,X,_)),
    add message(nearest_station(_st,X,X)) %% NB to itself
ip  [] ).


isatnth rule bustrans:( % NTH. isat(Y,NTH)  Select one, avoid Donotknow message
is  not present srel/_/time/_/_ ,
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
    isat(_,NTH) ).


stationstation rule bustrans:( %% The name IS a station
is  context (Y isa station)
id  not message(nearest_station(_st,_,_)),
    add message(nearest_station(_st,X,Y))
ip  bound(X),
    X \== it,
    placestat(X,Y) ).  %% NB in busdat (Real definition)

streetstatwrong rule bustrans:( %% street mapping is not updated, warning to staff
is  X isa street
id  add message(unrecognized_street(X,Y)) %% e.g. Bård Iversens ->  k_jonssons_vei/old
ip  bound(X),
     X \== it,
    street_station(X,Y), %%  unknown  or not station
    Y \== unknown,
    Y \== '',             %% empty (error in reghpl)
    X \== Y,              %% if NTH cast as street, differ
    Y \== m0,      %% ad hoc for sentrumsterminalen
    \+ station(Y) ). %%




%%%% AFTER streetstatknown because 1. streetnumber may be unknown
streetstatunknown rule bustrans:( %% gaten nth fins ikke i aktuell ruteplan
is  X isa street,clear
id  clear,
    add message(unknown_street(X)),
    add flag(exit)
ip  bound(X),
    X \== it,
    street_station(X,Y), %% station or unknown
    Y=unknown ).


nextbeonplace rule bustrans:( %%  next bus on place = from
is   srel/on/place/Place/C,
     present adj/_/next/_/_,
     not present srel/to/place/_/_, %% already
     present (do)/be1/Agent/C,
     Agent isa Whatever, {i_or_a_bus(Agent,Whatever,Bus)}
id   atday(Day),atdate2(DaySeqNo,_Date),
     not passevent(_,_,Place,_,_,_),
     not passevent(_,_,_Anyplace_,[from],_,_), %% Opts . cond
     add (departure(Bus,Stat,DaySeqNo,Depset),
          passevent(Depset,Bus,Stat,[from],Day,C))
ip  bus_place_station(Bus,Place,Stat),
    Stat \== unknown ).


howmanyq1  rule bustrans:( %  hvor mange spørsmål har du (be)svart (på)?
is  howmany(A), %% TA-101215
    tuc isa savant,A isa question %%%% ,dob/Tell/tuc/A/B,event/real/B
id  add message(webstatistics)
ip  [] ). %% dmeq([tell,answer1,answer],Tell).


howmanyq2  rule bustrans:( %  hvor mange spørsmål har du (be)svart (på)?
is  howmany(A),tuc isa savant,A isa question,dob/Tell/tuc/A/B,event/real/B
id  add message(webstatistics)
ip  dmeq([tell,answer1,answer],Tell) ).



norouteinfooverview rule bustrans:( %%  oversikt over noe
is  _ isa overview
id  add ( message(cannotanswer)),
    add ( message(answer(db_reply(tt,webaddress,K)))),
    add flag(fail)
ip  has_att_val(company,webaddress,tt,K) ).


whatisclass2 rule bustrans:(  %%  what is D means describe D
is  exactly (which(X),Tagore isa Programmer,dob/be/Tagore/X/B,event/real/B)
id  add message(answer((bcpbc(Person))))
ip  \+ value(teleflag,true),
    \+ testmember(Programmer,[answer,bus,  vehicle,route,tram,train,airplane,
             easter,christmas,whitsun,information,
             moment,clock,hour,date,midnight,month,week,weather,year,arrival,departure]),
    unbound(Tagore),
    description(Programmer,Person) ) :-
 single.

team_topic_web_routes  rule bustrans:( %% link til rutene
is  B isa webaddress, has/_agent/webaddress/Tuc/B,   {unbound(Tuc)},
    {dmeq([agent,savant,route,bus,program],_agent)},
    clear
id  add ( message(answer(db_reply(TT,webaddress,K))))
ip  value(actual_domain,TT),
    has_att_val(company,webaddress,TT,K) ).


team_topic_web rule bustrans:( %% nettsider for buss? //cant say no info about
is  B isa webaddress, has/_Agent/webaddress/Tuc/B,
      {dmeq([tuc,bustuc],Tuc)},
    clear
id  add ( message(answer(db_reply(TT,webaddress,K))))
ip  value(actual_domain,TT),
    has_att_val(company,webaddress,TT,K) ).



%%%% PRICE SECTION

costtorunbus rule bustrans:( %% hva koster det å kjøre buss
is  which(A),(B isa coevent,C isa Agent,D isa bus,
        event/B/E,dob/run/C/D/E,dob/cost/B/A/F,event/real/F),
    {dmeq([agent,thing],Agent)}
id  addcon  ticketprice2(bus,_)
ip  [] ).


costthatbusgo rule bustrans:( %% hvor mye koster det at bussen går
is  %% which(A), koster det 30 kroner å ta buss
    C isa coevent,B isa bus,
    (do)/go/B/E,event/C/E,dob/cost/C/_A/F,event/real/F
id  addcon  ticketprice2(bus,_) %
ip  [] ).

costtogocrazy rule bustrans:( %% hvor mye koster å ta buss %% Odd semantics
is  C isa coevent,
    (do)/go/_B/E,event/C/E,dob/cost/C/_A/F,event/real/F
id  addcon  ticketprice2(bus,_) %
ip  [] ).



costtotake rule bustrans:( %% hvor mye koster det å ta buss %% (nec?)
is  %% which(A),  %% koster det 30 kroner å ta buss
    (B isa coevent,C isa Agent,D isa bus,event/B/E,dob/take/C/D/E,dob/cost/B/_A/F,event/real/F),
    {dmeq([agent,thing],Agent)}
id  addcon  ticketprice2(bus,_)
ip  [] ).


ticketcost1 rule bustrans:( % Price of a ticket //vet du hva billetten koster/hva koster billetten
is  dob/cost/B/_A/_ , B isa Ticket, srel/for/_PersonThing/C/_, C isa Adult,  %% not season ticket
    not present X isa neighbourhood when { foreign(X)},
    not present _ isa airbus,
    not present _ isa airport, %% TA-100828
    not present _ isa nightbus,
    %not present _ isa bicycle, %% RS-150415
    not present _ isa pram,      %% etc
    clear
id  clear,
    add ticketprice2( Adult, _ ),
    add flag(exit)
ip  dmeq( [ ticket,trip ], Ticket ),
    dmeq( [ adult, child, bicycle ], Adult ) ).


costittram rule bustrans:( % koster det NN kroner
is  dob/cost/A/_NN/_, A isa V,{dmeq([tram],V)},
    not _ isa nightbus,
    not _ isa airport,
    not present _ isa airbus,
    clear                %% only SMS ?
id  not  message(noinfoabout(_)), %% dogs,prams etc.
    clear,
    addcon  ticketprice2(tram,_), % gets tour as well
    add flag(exit)
ip  [] ).

costitbus rule bustrans:( % koster det NN kroner
is  dob/cost/A/_NN/_, A isa V, { dmeq([ticket,vehicle,bus,tram],V) },
    not _ isa nightbus,
    not _ isa airport,
    not present _ isa airbus,
    clear                %% only SMS ?
id  not  message( noinfoabout(_) ), %% dogs,prams etc.
    clear,
    addcon  ticketprice2(bus,_), % gets tour as well
    add flag(exit)
ip  [] ).


costitairbus1 rule bustrans:( % koste på flybussen
is  dob/cost/_/_NN/_, present _ isa airbus,
    clear                %% only SMS ?
id  not  message(noinfoabout(_)), %% dogs,prams etc.
    clear,
    addcon  ticketprice2(airbus,_) % gets tour as well
ip  [] ).


costitairbus2 rule bustrans:( % koster til/fra airport
is  dob/cost/_A/_NN/_,_ isa airport, %% A isa bus %% TA-100828
    clear                %% only SMS ?
id  not  message(noinfoabout(_)), %% dogs,prams etc.
    clear,
    addcon  ticketprice2(airbus,_) % gets tour as well
ip  [] ).

costit1 rule bustrans:( % hvor mye koster det
is  dob/cost/it/_C/_E,
    not _ isa nightbus,
    not _ isa midnight,
    not bustuc isa savant, %% busstuc er gratis
    clear                %% only SMS ?
id  not  message(noinfoabout(_)), %% dogs,prams etc.
    clear,
    addcon  ticketprice2(bus,_) % gets tour as well
ip  [] ).

costit2 rule bustrans:( % hvor mye koster det %% Ad Hoc
is  dob/cost/it/_E,
    not _ isa nightbus,
    not bustuc isa savant, %% busstuc er gratis
    clear                %% only SMS ?
id  not  message(noinfoabout(_)), %% dogs,prams etc.
    clear,
    addcon  ticketprice2(bus,_) % gets tour as well
ip  [] ).


busncost0 rule bustrans:( % buss om natta
is  which(A),dob/cost/_IT/A/_ ,
    present _ isa midnight,
    not present Stink isa neighbourhood when { foreign(Stink)},
    not present _ isa airport,
    clear
id  clear,
    add ticketprice2(nightbus,_),
    add flag(exit)
ip  [] ).


busncost1 rule bustrans:( % hva koster bussen/ koster bussen 30 kr
is  dob/cost/B/_A/_ ,B isa Nbus,
    not present Stink isa neighbourhood when { foreign(Stink)},
    not present _ isa airport,
   clear
id  clear,
    add ticketprice2(Nbus,_),
    add flag(exit)
ip  dmeq([bus,nightbus,nighttram],Nbus) ).


ticketcostnight rule bustrans:( % Price of a ticket %% not special  ticket
is  dob/cost/B/_A/_ ,B isa Ticket,
    present _ isa nightbus,
    clear
id  clear,
    add ticketprice2(nightbus,_),
    add flag(exit)
ip  dmeq([ticket,trip,adult,child,thing],Ticket) ).


costto rule bustrans:( %% cost to (go...)
is  dob/cost/_/_/F ,srel/in_order_to/thing/_/F,
%%%%     present _ isa bus, ... å reise ...
    not present _ isa nightbus,
    not present _ isa midnight,
    clear
id  clear,
    add ticketprice2(bus,_),
    add flag(exit)
ip  [] ).

thingcost rule bustrans:( % hva koster det
is  dob/cost/B/_A/_ ,B isa Thing,
    not present X isa neighbourhood when { foreign(X)},
    not present _ isa nightbus,
    not present _ isa bicycle,
    not present _ isa pram,      %% etc
    clear
id  clear,
    add message(mustknow(Thing)),
    add flag(exit)
ip  dmeq([thing],Thing) ).


ticketprice3 rule bustrans:( % Price of a ticket
is  which(A),(do)/be1/A/_ ,A isa Ticket,
        { dmeq([ticket],Ticket)}, %% not trip,season ticket %% TA-100829
    not _ isa nightbus,
    not _ isa bicycle,
    not _ isa pram,      %% etc
    not present X isa neighbourhood when { foreign(X)},
    clear
id  clear,
    add ticketprice2(bus,_),
    add flag(exit)
ip  [] ).


freeride rule bustrans:( %% is it free to
is  not _ isa nightbus,
 removeall
    (F1 isa coevent,F3 isa bus,
    dob/run/_/F3/_,adj/nil/gratis/F1/_)
id  add ticketprice2(bus,_)
ip  [] ).

freeride2 rule bustrans:( %% is it free to   %%  UGLY -> gratis
is  not _ isa nightbus,
    removeall (A isa coevent,
               adj/_/gratis/it/C,event/real/C,srel/in_order_to/thing/A/C,
               srel/nil/coevent/A/D,event/real/D)
id  add ticketprice2(bus,_)
ip  [] ).


sufficient rule bustrans:(  %% ticket  sufficient
is   not _ isa nightbus,
    _ isa ticket, adj/_/sufficient/_/_
id  add ticketprice2(bus,_)
ip  [] ).


money  rule bustrans:( %%  jeg mangler penger. etc
is  _ isa money,
    not _ isa airbus,
    not _ isa nightbus,
    not _ isa airport,
    not _ isa beer  %% :-)
id  not ticketprice2(_,_), %% TA-101124
    add ticketprice2(bus,_),
    add flag(exit)
ip  [] ).


expensiveto1 rule bustrans:( %% kjøre gratis %% TA-101108
is  not _ isa nightbus,
    not _ isa beer,  %% :-)
    srel/Expensive/(mode)/nil/_ , {dmeq([expensive,gratis,cheap],Expensive)}
id  add ticketprice2(bus,_),
    add flag(exit)
ip  [] ).

expensiveto2 rule bustrans:( %% is it expensive to
is  not _ isa nightbus,
    not _ isa beer,  %% :-)
    adj/_/Expensive/_IT/_ , {dmeq([expensive,gratis,cheap],Expensive)}
id  add ticketprice2(bus,_),
    add flag(exit)
ip  [] ).


gratis rule bustrans:(
is  not _ isa nightbus,
    srel/freely/(mode)/nil/B,event/real/B %% kjøre gratis
id  add (ticketprice2(bus,_))
ip  [] ).


begratis rule bustrans:(     %% T-100427  free-> gratis
is  not _ isa nightbus, %% være gratis %% adj/_/gratis/_/real
    adj/_/gratis/A/_ ,A isa Bus ,{dmeq(vehicle,Bus)}
id  add (ticketprice2(Bus,_))
ip  [] ).


pay2 rule bustrans:(
is  not _ isa nightbus,
    dob/pay/_/_/_  %% er det lov å betale med 500 kroner
id  add (ticketprice2(bus,_))
ip  [] ).

pay1 rule bustrans:(
is  not _ isa nightbus,
    pay/_/E, event/real/E  %% intrans
id  add (ticketprice2(bus,_))
ip  [] ).


ticketprice1 rule bustrans:( % Price of a ticket
is  not _ isa nightbus,
    which(A),has/Ticket/price/_/A
id  not message(noinfoabout(special_ticket)), %%   " price of a monthly fare
    addcon ticketprice2(bus,_)
ip  dmeq(ticket,Ticket) ).


ticketprice2 rule bustrans:(    % Price of a ticket in the night
is  which(X),dob/be/X/A/_, A isa price
id  flag(nightbusflag),
    addcon ticketprice2(nightbus,_)
ip  [] ).


ticketprice3 rule bustrans:(    % Price of a ticket
is  which(A),A isa price, (do)/be1/A/C,srel/For/_/B52/C,B52 isa BusT
id  addcon ticketprice2(BusT,_)
ip  dmeq([bus,nightbus],BusT),
    dmeq([on,to,for],For) ).


ticketprice4 rule bustrans:(      % What is a price
is  not _ isa nightbus,
    which(A),A isa price,(do)/be1/A/E,srel/for/Person/_/E
id  addcon ticketprice2(bus,_)
ip  dmeq([person,man,woman,child,boy,girl],Person) ).


ticketprice5 rule bustrans:(      % What is a price from to
is  not _ isa nightbus,
    which(A),A isa price,(do)/be1/A/E,srel/_Prep/Place/_/E
id  addcon ticketprice2(bus,_)
ip  dmeq([place],Place) ).


ticketprice6 rule bustrans:( % What is a price on
is  which(A), A isa Price, srel/On/_/Y/_,Y isa Ticket
id  addcon ticketprice2(bus,_)
ip  dmeq([price,fare],Price),
    dmeq([ticket,bus,fare],Ticket),
    dmeq([on,for,of],On) ).


ticketprice7 rule bustrans:( % What is a price
is  which(A),A isa Price,
    not _ isa sms,
    not _ isa night,
    not _ isa nightbus,
    not _ isa boat,
    not _ isa train
id  addcon ticketprice2(bus,_)
ip  dmeq([price,fare],Price) ).


ticketprice8 rule bustrans:( % What is a price
is  which(A),dob/be/A/B/_,B isa Price,
    not _ isa night,
    not _ isa nightbus,
    not  srel/in_midnight/time/_/_,
    not _ isa nightbus,
    not _ isa boat,
    not _ isa train
id  addcon ticketprice2(bus,_)
ip  dmeq([price,fare],Price) ).


ticketprice9 rule bustrans:( % What is a price
is  not _ isa nightbus,
    exactly (which(A),A isa price,event/real/_)
id  addcon ticketprice2(bus,_)
ip  [] ).


ticketprice10 rule bustrans:( % What is a price %% Too gerneral ?
is  not _ isa nightbus,
    _ isa price,
    not _ isa sms
id  addcon ticketprice2(bus,_)
ip  [] ).


ticketpriceveh rule bustrans:( %% pris buss %% no use ????
is  F31 isa price, F32 isa Bus, (do)/be1/F31/F33, srel/nil/vehicle/F32/F33
id  addcon ticketprice2(Bus,_)
ip  dmeq(vehicle,Bus) ).


ticketpricenight rule bustrans:( % What is a price Nightbus
is  _ isa price
id   flag(nightbusflag),
     addcon ticketprice2(nightbus,_)
ip  [] ).


price100 rule bustrans:(   % What is a price for going
is  not _ isa nightbus,
    which(A),A isa price,srel/for/price/A/_
id  add ticketprice2(bus,_)
ip  [] ).


%%% END PRICE SECTION



%%% Warn at  time and date %%%%%%%%%%%%%%%%%%%

warnattime rule bustrans:( %% varsle kl 1015  %% TA-110201
is  { value(smsflag,true) }, %% TA-110202
    tuc isa savant,CLOCK isa clock,
        dob/notify/tuc/_/A,srel/_After/time/CLOCK/A
id  atdate2(_DaySeqNo,Date),
    flag(warningflag),
    add timeis(CLOCK),
    add busanshp:warningtime(Date,CLOCK)
ip  set(warningtime, notification(Date,CLOCK)) ).


warnwhentimeis rule bustrans:( %% varsle når klokken er 1800  %% TA-110202
is  {value(smsflag,true)},
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
    add busanshp:warningtime(Date,T1800)
ip  set(warningtime, notification(Date,T1800)) ).

%%% What time and date %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Tell Time Section

whatistime1 rule bustrans:( %% what is the time
is  which(A),(B isa clock,event/real/C,dob/be/B/A/C)
id  add (timenow2(0,T),timeis(T))
ip  [] ).


whattime2 rule bustrans:( %%  Hvilken tid er det
is  which(A),(A isa time,(do)/exist/A/B,event/real/B)
id  add (timenow2(0,T),timeis(T))
ip  unbound(A) ).


whattimeisit rule bustrans:(
is  which(A),(A isa time,event/real/B,dob/be/A/it/B) %% repair
id  add (timenow2(0,T),timeis(T))
ip  unbound(A) ).


%%%% Outdated %%
whattime1 rule bustrans:( % Hva er klokka? %  Fronted, Date irrelevant
is  exactly (which(Clock1),Clock2 isa clock)
id  add (timenow2(0,T),timeis(T))
ip  unbound(Clock1),Clock1==Clock2 ).          %% Alarm


whattimenow rule bustrans:( % Hva er klokka nå ? %  Fronted, Date irrelevant
is  exactly (which(A),B isa clock,srel/now/time/nil/C,event/real/C,dob/be/A/B/C)
id  add (timenow2(0,T),timeis(T))
ip  [] ).


telltime1 rule bustrans:( % Fortell  hva klokka er
is  tuc isa savant,A isa clock,
    dob/tell/tuc/B/_,dob/be/A/B/_
id  add (timenow2(0,T),timeis(T))
ip  [] ).


whattime2 rule bustrans:( % fortell hva klokka er
is  tuc isa savant,Clock2 isa clock,
    dob/Tell/tuc/Clock2/_ , {dmeq([know,know1,tell],Tell)}
id  add (timenow2(0,T),timeis(T))
ip  [] ).


whattime3 rule bustrans:( % vet du klokka  / vet du hva klokka er ?
is  tuc isa savant,Clock2 isa clock,dob/KNOW1/tuc/Clock2/_
  ,{dmeq([know,know1],KNOW1)}
id  add message(time(now,T)) % eliminate timeis in busans
ip  timenow2(0,T) ).         %% TA-101102


whattime4 rule bustrans:( % har du klokke ?
is   tuc isa savant,has/agent/Clock/tuc/A,A isa Clock
id   add (timenow2(0,T),timeis(T))
ip  dmeq([clock,time],Clock) ).


doyouknowthetime rule bustrans:( % Vet du hva klokka er
is  test,tuc isa savant,A isa clock,
    dob/KNOW1/tuc/B/C,event/real/C,event/real/D,dob/be/A/B/D,
   {dmeq([know,know1],KNOW1)}
id  add message(time(now,T))
ip  timenow2(0,T) ).


whatistimeafter1 rule bustrans:( % Hva er klokka om en time
is  which(Time),Time isa Timeq,  {dmeq([time,clock],Timeq)}, %% not frequency
    (do)/be1/Time/E,
    F isa minute,
    srel/after/_Timemin/F/E,
    not present (do)/go/_/_ % etc
id	 add message(time(then,T))
ip  unbound(Time),
    timenow2(F,T) ).


whatistimeafter rule bustrans:( % Hva er klokka om en time
is  which(Time),Time isa Timeq,  {dmeq([time,clock],Timeq)}, %% not frequency
    srel/_/minute/_/_,
    not present (do)/go/_/_  %% etc
id	 add message(cannotanswer),
    add (timenow2(0,T),timeis(T))
ip  unbound(Time) ).


whattime10 rule bustrans:( % What is your clock .
is (tuc isa savant,has/system/clock/tuc/A,A isa clock)
id	 add (timenow2(0,T),timeis(T))
ip  unbound(A) ).  %% avoid lunch syndrom


whattime11 rule bustrans:( % Time is now (?).
is  exactly (new,A isa clock,(do)/be1/A/B,event/real/B,srel/now/time/nil/B)
id	 add (timenow2(0,T),timeis(T))
ip  unbound(A) ).  %% avoid lunch syndrom


whattime12 rule bustrans:( % when is it now  (Eng)
is  exactly (which(A),(do)/be1/A/B,A isa time,event/real/B,srel/now/time/nil/B,srel/in/time/A/B)
id	 add (timenow2(0,T),timeis(T))
ip  unbound(A) ).

 % % % % % % %


notram2 rule bustrans:( %% Tram station, but user has asked for bus
is  X isa tramstation,
    clear
id  addcon message(noroutesto(X))
ip  bound(X),
%    \+ value(tmnflag,true),
%    \+ value(tramflag,true),
    \+ X isa station ).                %% Ugla


notram3 rule bustrans:( %% tram
is  _X isa tramstation,
    not present (_Y isa bus), %      asks explicitly about bus
    clear
id	 clear,
    addcon message(noroutesfor(tram))
%ip   \+ value(tmnflag,true) ).
ip   \+ value(tramflag,true) ).

%%%% Sørger for riktig retning i "buss fra/til sted passerer TOFROMBY" etc.

%%%%%%%%%%% Stasjoner en kommer fra eller går til %%%%%%%%%


%%%%%%% STASJONER ..og passerer, etc. %%%%%%%%%%%%%

% BEGIN SECTION HOLDEPLASSER %%%


wherebus11 rule bustrans:( % Hvor går buss Bus fra/til?
is  exactly
   (which(A),A isa place,Bus isa Route,    {dmeq(vehicle,Route)},
    (do)/go/Bus/B,event/real/B,srel/_From/place/A/B)
id	 atday(Day),
    not passevent(_,_,_,_,_,_), %% avoid test departure(_,_,_,_),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,_))
ip	 exbus(Bus) ).


wherebus12 rule bustrans:( % Hvor går buss Bus ? %% moved after fromp
is  which(Station),(do)/PASS/Bus/B, {dmeq(pass,PASS)},
    srel/_In/place/Station/B,
    not  Stat1 isa station  when {bound(Stat1)},
    not  Neib1 isa neighbourhood when { bound(Neib1)},
    not present srel/_/place/Moholt/_  when { bound(Moholt)},%% not if station is mentioned
    not present srel/between/place/_/_,
    not present adj/_/next/_/_,
    not srel/off/place/_/_,  %% side av veien
    not srel/_Now/time/_/_ ,                    %% NOW
    not srel/nil/time/_/_ ,
    not has/_Vehicle/departure/Bus/_,
    clear
id	 not flag(exit),
    atday(Day),
    not  passevent(_,_,_,_,_,_), %% avoid test departure(_,_,_,_),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,_))
ip	 unbound(Station),
         exbus(Bus)
).

wherebus13 rule bustrans:( % Hvor går stopper buss 5 nær sentrum
is  which(P),P isa Place,
       {dmeq([place,station,neighbourhood],Place)},
    (do)/PASS/Bus/B, {dmeq(pass,PASS)},
    srel/_In/place/P/B,
    Neib1 isa neighbourhood,
    srel/In/_Neighbourhood/Neib1/_, {dmeq([in,near],In)},
    not present srel/between/place/_/_,
    not present adj/_/next/_/_,
    not srel/off/place/_/_,  %% side av veien
    not srel/_Now/time/_/_ ,                    %% NOW
    not srel/nil/time/_/_ ,
    not has/_Vehicle/departure/Bus/_
id  not message(nearest_station(_ST,Neib1,_)),
    add stationsat(Neib1,_Stations,_SSS)
ip	 exbus(Bus) ).



wherebus14 rule bustrans:( % Hvor går trikk 1 ?
is  which(Station),(do)/PASS/Tramno/B,srel/_In/place/Station/B,
    not srel/_Now/time/_/_ ,
    not srel/nil/time/_/_ ,
    clear
id	 atday(Day),
    not  passevent(_,_,_,_,_,_), %% avoid test    not departure(_,_,_,_),
	 add (findstations(Tramno,Day,Stl),
         passesstations(Tramno,Day,Stl,_))
ip	 unbound(Station),
         dmeq(pass,PASS),
        thetramno(Tramno)
).


whatisbus rule bustrans:( % Hva er buss 6
is  exactly (which(A),A isa Bus),
       { bound(A),dmeq(vehicle,Bus)}
id	 atday(Day),
    not  passevent(_,_,_,_,_,_),
	 add (findstations(A,Day,Stl),
         passesstations(A,Day,Stl,_))
ip	 [] ).


geton rule bustrans:( %% PLASS Where can i get on a bus?
is  present which(Place),
    present dob/get/_/Bus/C,srel/on/place/nil/C,
    srel/in/place/Place/C
id	 atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,C))
ip	 unbound(Place),busorfree(Bus) ).


getoff rule bustrans:( %% PLASS Where can i get off a bus?
is  present which(Place),present dob/get/_/Bus/C,srel/off/place/nil/C,
	 srel/in/place/Place/C
id	 atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,C))
ip	 unbound(Place),busorfree(Bus) ).

busstationsbetween  rule bustrans:(  %% hvilke busstopp er det mellom samfundet og vestre rosten for buss 48 .
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
ip  [] ).


busonroutestoppingbetween  rule bustrans:(  %% TA-110510
 %% hvor stopper buss  .. mellom .. på rute 52
is  which(F22),   F22 isa place, {unbound(F22)},
    srel/Ni/place/F22/F23, {dmeq([in,nil],Ni)},

    Fbus isa Veh1, {unbound(Fbus),dmeq(vehicle,Veh1)},

    (do)/Stop/FBus/F23, {dmeq([stop],Stop)}, %% \+ go!!!
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
ip  [] ).
busstoppingbetween  rule bustrans:(
is  which(F22),   F22 isa place,
    srel/Ni/place/F22/F23, {dmeq([in,nil],Ni)},
    (do)/Stop/Bus/F23, {dmeq([stop],Stop)}, %% \+ go!!!
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
ip  [] ).



passbetween1 rule bustrans:(  %%  Which places does bus N PASS at  between stations
is  present srel/To/place/ToPlace/_,     {dmeq([to,towards],To)},
    not present dob/change/_/_/_,
    present which(Place),  present Place isa station,
    srel/AT/place/Place/A, {dmeq(tofromby,AT),unbound(Place)},
    (do)/PASS/Bus/A, {dmeq(pass,PASS)},
    present srel/From/place/FromPlace/_, {dmeq([from,past,dir],From)}
id	 atday(Day),
	 not  findstations(_,_,_), %% busstationsbetween
    add ( findstations(Bus,Day,Stl1),
          keepbetweenstat(Bus,FromStat,ToStat,Stl1,Stl2),
          passesstations(Bus,Day,Stl2,A))
ip	 bus(Bus),
    bus_place_station(Bus,FromPlace,FromStat),  %%  OK if not bus
    bus_place_station(Bus,ToPlace,ToStat) ).


passbetweenunkbus rule bustrans:( %% Which places does a bus PASS at  between stations
is  present which(Place), { unbound(Place),
                            dmeq(place,Place)},  %%  not side
    srel/AT/place/Place/A, { dmeq(tofromby,AT)},
    PASS1/Bus/A, {dmeq(pass,PASS1),unbound(Bus)},
    present srel/From/place/FromPlace/_,
       {dmeq([from,past,dir],From), bound(FromPlace)},
    present srel/To/place/ToPlace/_,
       {dmeq([to,towards],To), bound(ToPlace)},
    clear
id	 not message(mustknow(bus)),
    clear,
    add message(mustknow(bus))
ip	 [] ).



passbetw3 rule bustrans:( %% Hack   Has stops between
is  present which(Place),has/vehicle/station/Bus/Place,
    present srel/From/place/FromPlace/_, {  dmeq([from,after,past],From)},
    present srel/To/place/ToPlace/_  ,   {  dmeq([before,to,towards],To)}
id	 not  findstations(_,_,_), %%  busstationsbetween
    atday(Day),
	 add ( findstations(Bus,Day,Stl1),
          keepbetweenstat(Bus,FromStat,ToStat,Stl1,Stl2),
          passesstations(Bus,Day,Stl2,_))
ip	 unbound(Place),exbus(Bus),
    bus_place_station(Bus,FromPlace,FromStat),
    bus_place_station(Bus,ToPlace,ToStat) ).


statbetweennamed rule bustrans:( %% hva heter holdeplassene  mellom
is  which(F6),   Place isa station,
    (dob/be_named/F6/Place/A  or dob/be_named/Place/F6/A),
    (do)/be1/Place/A,
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
    unbound(Place),exbus(Bus) ).


statbetweennamednobus rule bustrans:(
is  which(F6),   Place isa station,
    (dob/be_named/F6/Place/A  or dob/be_named/Place/F6/A),
    not present X isa bus when { bound(X)},
    (do)/be1/Place/A,
    srel/From/place/_FromPlace/_A1, %  A1=A2, but shunt
    srel/To/place/_ToPlace/_A2      %  makes havoc
id  add message(mustknow(bus))
ip  dmeq([from,beyond,after],From), %% etter = from/beyond/after
    dmeq([to,before],To),
    unbound(Place) ).


statbetween1 rule bustrans:(  %% hva er holdeplassene mellom A og B (be2 regime)
is  which(F171),   Place isa station,
    (do)/be1/Place/A,
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
    unbound(Place),exbus(Bus) ).


statbeforeis rule bustrans:(  %% hva er  holdeplassene før B
is  which(F171),  Place isa station,
    srel/before/place/_ToPlace/_,
    (do)/be1/Place/A, dob/be/Place/F171/A
id  add message(mustknow(bus)),
    add message(mustknowanother(place))
ip  [] ).

statbeforeheter rule bustrans:(  %% hva er/heter  holdeplassene før B
is  which(F100),  Place isa station, { bound(Place)},
    Free isa station, { unbound(Free)},
    srel/before/place/Place/E,
    (do)/be1/Free/E, dob/be_named/F100/Free/E
id  add message(mustknow(bus)),
    add message(mustknowanother(place))
ip  [] ).


statbetweennoroute rule bustrans:(  %% hva er holdeplassene mellom A og B //NO ROUTE
is  which(F171), dob/be/Place/F171/A,   Place isa station,
    (do)/be1/Place/A,
    srel/From/place/_FromPlace/_A1, %  A1=A2, but shunt
    srel/To/place/_ToPlace/_A2      %  makes havoc
id  add message(mustknow(bus))
ip  dmeq([from,beyond,after],From), %% etter = from/beyond/after
    dmeq([to,before],To) ).



statbetween2 rule bustrans:(
is  which(Place), Place isa station,
    (do)/be1/Place/A,
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
    unbound(Place),exbus(Bus) ).


statbetween4 rule bustrans:( %% hva er neste holdeplass etter samfundet .
is  which(S), S isa station, (do)/Be1/S/E, {dmeq([be1,exist],Be1)},
    srel/after/place/_/E,
    not present _ isa bus,
    not present _ isa route
id  add message(mustknow(bus))
ip  [] ).


stationsonroute rule bustrans:( %% moved after passbetween.....
is    which(A),A isa station,Bus isa BR, {dmeq([bus,nightbus,route],BR)},
      (do)/be1/A/B, srel/ON/route/Bus/B,
      not X isa station when { bound(X)}
id    atday(Day),
	   add (findstations(Bus,Day,Stl),
      passesstations(Bus,Day,Stl,_))
ip    dmeq([on,at],ON),bound(Bus) ).


passat1 rule bustrans:(  %% PLASS Which places does a bus PASS at?
is  present which(Place),PASS1/Bus/A,srel/AT/place/Place/A,
    not present _ isa time,
    not present _ isa clock,
    not present srel/_/place/_/_,
    clear %%  only exact,
id	 atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,A))
ip	 dmeq(pass,PASS1),dmeq(tofromby,AT),unbound(Place),exbus(Bus) ).


pass1 rule bustrans:( %% PLASS Which places does a bus <pass>?
is  which(Place),Place isa place,(do)/PASS/Bus/E, srel/dir/place/Place/E,event/real/E
id	 add message(mustknow(bus))
ip	 dmeq(pass,PASS),unbound(Place),unbound(Bus) ).


stationsarebetweenst rule bustrans:( % hvilke hpl er fra A til B
is  which(F3), F3 isa Station, {dmeq([station,place],Station)}, %% TA-110510
    not X isa bus when{bound(X)},
    not X isa route when{bound(X)},   %% TA-110510
    srel/from/place/_Nardosenteret/F4,srel/to/place/_Torget/F4
id	 not message(foreign(_)),
    add message(mustknow(bus))
ip	 [] ).

tofrombyq rule bustrans:( % PLASS Which places does a buss <pass> <TOFROMBY>?
is  Place isa station,
    present which(Place),present (do)/PASS/Bus/A,present Bus isa BR,
    srel/TOFROMBY/place/Place/A
%%%     not srel/_/place/_/_
id	 not message(foreign(_)),
    add message(mustknow(bus))
ip	 dmeq(tofromby,TOFROMBY),unbound(Place),
    dmeq(bus,BR),unbound(Bus),dmeq(pass,PASS)  ).


%%%% Where does bus go ??? section %% TA-101029 moveed last

stationsalongroute rule bustrans:( %% TA-101110
is  which(A),(Busno isa route,A isa station,
    event/real/B,srel/Along/route/Busno/B),
   	{dmeq([along,on,in,for],Along)}, %% TA-110622
    not _ isa station,                 %% TA-110622
    not _ isa neigbbourhood            %%
id  not passevent(_,_,_,_,_,_),
	 add (findstations(Busno,Day,Stl),
         passesstations(Busno,Day,Stl,_))
ip	 exbus(Busno) ).

stationbeforeafterplace rule bustrans:( %% TA-101110
is  which(A),A isa station,(do)/be1/A/B,
    event/real/B,srel/Along/place/Ikea/B, Ikea isa station,
   	{dmeq([along,on,in,before,after],Along)},
    not present _Busno isa route %% etc
id  not passevent(_,_,_,_,_,_),
	 add message(mustknow(route))
ip	 [] ).



whatistraseeforbus  rule bustrans:( % Route for bus meaning trasee // after mustknowplace
is  not present  _ isa date,
    (do)/be1/B/E, %%  // do you have %%  busstabell for nr 9.
    B isa ROUTE,
    { dmeq([route,route_plan,information,thing,bus],ROUTE)},
    srel/FOR/BUSV/Bus/E,
    event/real/_E,
    not _ isa day ,  %% etc   NO TIME indication
    not srel/_With/time/_/_,   %%  (detail)
    not present srel/_To/place/_/_
id	 not flag(exit),
    not passevent(_,_,_,_,_,_), %% doesnt help
    not departure(_,_,_,_),
    atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,_))
ip	 exbus(Bus),
    dmeq([bus,nightbus,route,vehicle,thing],BUSV),
    dmeq([for,to,over,regarding],FOR) ).


traseeforbus  rule bustrans:( %  trase for nr 9. Route for bus meaning trasee
is  not present _ isa date,
    not present _ isa time,
    srel/FOR/BUSV/Bus/E, {bound(Bus)},
       {dmeq([for,to,over,regarding,at   ,nil],FOR)}, % at=along %% TA-110527
       {dmeq([bus,nightbus,route,vehicle,thing],BUSV)},
    Bus isa ROUTE,
    {dmeq([route,route_plan,information,thing,bus],ROUTE)},
    event/real/E,
    not _ isa day ,  %% etc   NO TIME indication
    not srel/_With/time/_/_,   %%  (detail)
    not present srel/_To/place/_/_
id	 not flag(exit),
    not passevent(_,_,_,_,_,_), %% doesnt help
    not departure(_,_,_,_),
    atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,_))
ip	 exbus(Bus) ).


%%%% END SECTION HOLDEPLASSER


%%%%%%%%%%% Bussoverganger %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

change1 rule bustrans:( % Hvor kan man CHANGE fra Buss1 til Buss2
is  which(Station),dob/CHANGE/_/Station/C,
    srel/TOFROMBY1/bus/Bus1/C,srel/TOFROMBY2/bus/Bus2/C
id  atday(Day),
    add (findstations(Bus1,Day,Stl1),
			findstations(Bus2,Day,Stl2),
			corrstats(Stl1,Stl2,StlBoth),
			passesstations([Bus1,Bus2],Day,StlBoth,C))
ip  dmeq(change,CHANGE),
    dmeq(tofromby,TOFROMBY1),dmeq(tofromby,TOFROMBY2),
    exbus(Bus1),exbus(Bus2) ).


meet2 rule bustrans:( % Where does Bus1 and Bus2 meet?
is  which(Stat),meet2/(Bus1,Bus2)/B,srel/in/place/Stat/B
id  atday(Day),
    add (findstations(Bus1,Day,Stl1),
			findstations(Bus2,Day,Stl2),
			corrstats(Stl1,Stl2,StlBoth),
			passesstations([Bus1,Bus2],Day,StlBoth,B))
ip  exbus(Bus1),exbus(Bus2) ).


samefplace2 rule bustrans:( %% Avoid question if same place
is  srel/From/place/StartPlace/D1, %% not "removed from seen %% 1	 context only
    {StartPlace \== nil}, %%  der
    context srel/To/place/EndPlace/D2, { To \== From, D1==D2}, %% and be at=D1\=D2
    {EndPlace \== nil},
    not _ isa airport %% Th airport
id  add (message(sameplace(StartPlace,EndPlace)))  %% not urgent
ip  atomic(StartPlace), atomic(EndPlace),
    dmeq([to,for,in,from],To),
    samefplace(StartPlace,EndPlace) ).


samefplace2b rule bustrans:(
is  context srel/To/place/EndPlace/_D1, %% not "removed from s(c)een
    not _ isa airport, %% Th airport
    dob/leave/_Bus/StartPlace/_D2
id  add (message(sameplace(StartPlace,EndPlace)))  %% not urgent
ip  atomic(StartPlace), atomic(EndPlace),
    dmeq([to,for],To),samefplace(StartPlace,EndPlace) ).

samefplace3 rule bustrans:(
is context srel/From/place/StartPlace/_D1, %% not "removed from s(c)een
   not _ isa airport, %% Th airport
   srel/at/place/EndPlace/_D2
id add (message(sameplace(StartPlace,EndPlace)))  %% not urgent
ip atomic(StartPlace), atomic(EndPlace),
   samefplace(StartPlace,EndPlace),
   From \== at ). %% Different prepositions


samefplace4 rule bustrans:(
is context srel/_Prep1/place/StartPlace/_D1,
   srel/_Prep2/place/EndPlace/_D2,
    not _ isa airport %% The airport
id add (message(sameplace(StartPlace,EndPlace)))
ip  atomic(StartPlace), atomic(EndPlace),
   (\+ StartPlace = EndPlace,
    samefplace(StartPlace,EndPlace)) ).


samefplace5 rule bustrans:(  %%
is  (do)/pass/_X/E,
    srel/_Prep/place/EndPlace/E
id  add (message(sameplace(StartPlace,EndPlace)))
ip  atomic(StartPlace), atomic(EndPlace),
    samefplace(StartPlace,EndPlace) ).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Stasjonspasseringsdel. Her blir departure/passevent laget
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%% Stasjonspasseringsspesialregler som sikrer riktig rekkefølge...

leavename rule bustrans:( %% Does a bus LEAVE a place?
is  dob/LEAVE/Bus/Place/A, present Bus isa Veh
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[],Day,A)) %%   leave is neutral wrp direction
ip	 bound(Place),dmeq(vehicle,Veh),
    dmeq(leave,LEAVE),busorfree(Bus),
    bus_place_station(Bus,Place,Stat) ).

%%%%%%%%%%% take the bus


sometakebusfrom rule bustrans:( % someone take the bus FROM a place
is  present dob/USE/X/Bus/A, {X \== it}, %% .. tid tar det
    srel/FROM/place/Place/A
id	 not flag(exit),
    atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[from],Day,A))
ip  dmeq(from,FROM),dmeq(use,USE),busorfree(Bus),
        bus_place_station(Bus,Place,Stat) ).


bustakemefrom rule bustrans:( % Bus take me
is  present dob/take/Bus/_/C,present Bus isa bus,srel/FROM/place/Place/C
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[from],Day,C))
ip  dmeq(from,FROM),place_station(Place,Stat),
    busorfree(Bus) ).


bustakemebyto rule bustrans:( % Bus take me by = to
is  present dob/take/Bus/_/C,present Bus isa bus,srel/BY/place/Place/C,
    present srel/from/place/_/_  %% to antother place
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[to],Day,C))
ip  dmeq(by,BY),place_station(Place,Stat),busorfree(Bus) ).


bustakemebyfrom rule bustrans:( % Bus take me by = from (Deafult)
is  present dob/take/Bus/_/C,present Bus isa bus,srel/BY/place/Place/C
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[from],Day,C))
ip  dmeq(by,BY),place_station(Place,Stat),busorfree(Bus) ).


takefrom rule bustrans:( % take FROM
is  present dob/take/X/_/C, {X \== it},
    srel/FROM/place/Place/C
id	 not flag(exit),
    atday(Day),atdate2(DaySeqNo,_Date),
    add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[from],Day,C))   %% same event C !
ip  dmeq(from,FROM),newfree(Bus),place_station(Place,Stat) ).

sometake1 rule bustrans:( % someone take the bus BY a place
is  present dob/take/_/Bus/A,srel/BY/place/Place/A
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[],Day,A))
ip  dmeq(by,BY),busorfree(Bus),
    bus_place_station(Bus,Place,Stat) ).


takeby rule bustrans:( % take BY
is  present dob/take/_/_/C,srel/BY/place/Place/C
id	 atday(Day),atdate2(DaySeqNo,_Date),
    add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[],Day,C)) %% same event C !
ip  dmeq(by,BY),place_station(Place,Stat),newfree(Bus) ).


bustaketime  rule bustrans:( % bus takes time -> bus goes with duration
is  replaceall ( dob/USE/Bus/T/A, B isa Veh, T isa duration)
    with       ( (do)/go/Bus/A, srel/(with)/duration/T/A, B isa bus, T isa duration),
    {dmeq([use,take,  use2],USE)}, %% use2 is unsensical
    {dmeq(vehicle,Veh)}
id	 []
ip  [] ).


sometake2take rule bustrans:( % someone take the bus TO a place
is  present dob/USE/X/Bus/A, {X \== it},
    srel/TO/place/Place/A
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[to],Day,A))
ip  dmeq(to,TO),dmeq(use,USE),place_station(Place,Stat),busorfree(Bus) ).


takeme rule bustrans:( % Bus take me to
is  present dob/take/Bus/_/C,present Bus isa bus,srel/TO/place/Place/C
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[to],Day,C))
ip  dmeq(to,TO),place_station(Place,Stat),busorfree(Bus) ).


taketo rule bustrans:( % take TO
is  present dob/take/X/_/C, {X \== it}, %%  ..  tid tar det
    srel/TO/place/Place/C
id	 atday(Day),atdate2(DaySeqNo,_Date),
    add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[to],Day,C))
ip  dmeq(to,TO),place_station(Place,Stat),newfree(Bus) ).


%%%%%%%%%%% (do)/PASS/TRAVEL/be1 etc. FROM

leavaplace rule bustrans:( % when Does a bus LEAVE a place? (Place is unbound)
is  exactly (which(Time),Bus isa bus, Time isa Timeq,
        dob/LEAVE/Bus/Place/C,event/real/C,srel/in/time/Time/C)
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Place,DaySeqNo,Depset),
			passevent(Depset,Bus,Place,[from],Day,C))
ip	 unbound(Place),dmeq(leave,LEAVE),dmeq(time,Timeq) ).


passfrom2 rule bustrans:( % Do I PASS FROM a place with bus Bus ?
is  Bus isa bus,I isa self,
    (do)/Go/I/A,{dmeq([go,come,travel],Go)}, %% TA-100831
    srel/Prep/place/Place/A,
    srel/(with)/vehicle/Bus/A
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[Prep],Day,A))
ip  dmeq([from],Prep),
    busorfree(Bus),bus_place_station(Bus,Place,Stat) ).


passdir rule bustrans:( % I pass Place to/from Another place
is  context (Pass/Cat/B),
    srel/dir/place/Place/B,
    present Cat isa BVP,
%%%%     not present  srel/to/place/_/_
    not present  srel/from/place/_/_
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Cat,Stat,DaySeqNo,Depset),
         passevent(Depset,Cat,Stat,[from],Day,B)) %% Default
ip  dmeq([pass,reach],Pass),
    dmeq(trafficant,BVP),
    place_station(Place,Stat) ).


passtofrom rule bustrans:( % I pass Place to/from Another place
is  context (Pass/Cat/B), %% only 1
    srel/FROMTO/place/Place/B,
    present Cat isa BVP
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[FROMTO],Day,B))
ip  dmeq([from,to],FROMTO),
    dmeq([pass,reach],Pass),
    notbothfree(Bus,Place),
    dmeq(trafficant,BVP),
    bus_place_station(Cat,Place,Stat),newfree(Bus) ).


passfrom5 rule bustrans:( % Can someone TRAVEL FROM a place a time?
is  present (do)/TRAVEL/_/Time/B,srel/FROM/place/Place/B
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         keepafter(Time,Depset,NewDepset), %% keepat
			passevent(NewDepset,Bus,Stat,[from],Day,B))
ip  dmeq(travel,TRAVEL),dmeq(from,FROM),
    place_station(Place,Stat),number(Time),newfree(Bus) ).


leave1 rule bustrans:( % is a Place  bus LEAVEing a place?
is  present Bus isa bus,present dob/LEAVE/Bus/_,
    adj/_/Place/Bus/A %% NB, Place is a PLACE
id	 atday(Day), atdate2(DaySeqNo,_Date),                                            %% NOT next, etc.
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[from],Day,A))
ip	 dmeq(leave,LEAVE), busorfree(Bus),
    bus_place_station(Bus,Place,Stat) ).


leave2 rule bustrans:( % Does a bus LEAVE a place? %%  leave is noe neutral wrp direction
is  dob/LEAVE/Bus/Place/A, present Bus isa Veh
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[],Day,A))
ip  dmeq(leave,LEAVE),
    dmeq(vehicle,Veh),
    busorfree(Bus),
    bus_place_station(Bus,Place,Stat) ).


wayfrom rule bustrans:( % raskeste vei fra
is  Way isa street,
    present (do)/be1/Way/C,srel/FROM/Xplace/Place/C, % place/city
                      { dmeq([place,city,street,station],Xplace)}
id	 not findstations(_,_,_),
    atday(Day),atdate2(DaySeqNo,_Date),
         not   passevent(_,_,_,[from],_,_),    %%  NOT 2 FROMS
         not   connections(_,_,_,_,_,_,_,_,_,_), %% finished
	 add (departure(Bus,Station,DaySeqNo,Depset),
         passevent(Depset,Bus,Station,[from],Day,C))
ip	 dmeq(from,FROM),
    newfree(Bus),
    bus_place_station(Bus,Place,Station) ).

bedurationfrom rule bustrans:( %% varighet fra ..
is  present _F1 isa duration,
    srel/FROM/Xplace/Place/C, % place/city
                      { dmeq([place,city],Xplace)},
    not comp/vehicle/ne/_/Bus,
    not comp/number/ne/_/Bus,
    not present _ isa information %% Ad Hoc
id	 not flag(exit),
    not findstations(_,_,_),
    atday(Day),atdate2(DaySeqNo,_Date),
         not   passevent(_,_,_,[from],_,_),    %%  NOT 2 FROMS
         not   connections(_,_,_,_,_,_,_,_,_,_), %% finished
	 add (departure(Bus,Station,DaySeqNo,Depset),
         passevent(Depset,Bus,Station,[from],Day,C))
ip	 dmeq(from,FROM),     % raskeste vei = street     %%
    place_station(Place,Station) ).



befrom rule bustrans:( % be FROM
is  present Bus isa BR,
    present (do)/be1/Bus/C,srel/FROM/Xplace/Place/C, % place/city
                      { dmeq([place,city],Xplace)},
    not comp/vehicle/ne/_/Bus,
    not comp/number/ne/_/Bus,
    not present _ isa information %% Ad Hoc
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
    bus_place_station(Bus,Place,Station) ).


%%%% Insanerule bustrans:( %%  before beto %% Dragvoll1 may be street
nevergowithtomessage  rule bustrans:( %% after toplace1 (in case of  depend)
is  present srel/(with)/vehicle/Bus36/B,
    present Bus36 isa BVP,  { bound(Bus36), dmeq(vehicle,BVP)},
    present srel/TO/place/Dragvoll1/X,  %% (see retention)
         {dmeq([for,in,on,to,towards,outside,nil,dir,near,past],TO)},
    present Dragvoll1 isa SN, { bound(Dragvoll1)},
         { dmeq([station,neighbourhood,street],SN)},
    not present (do)/start/_/X,  %% start to go special
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
    newfree(Bus) ).


totoplacesameevent rule bustrans:( % to nth to risvollan  %% before beto
is  not present srel/nil/place/_/_,
    not present srel/from/place/_/_ ,
    replaceall (srel/to/place/Place1/E,srel/to/place/Place2/E)
    with       (srel/from/place/Place1/E,srel/to/place/Place2/E)
id  []
ip  [] ).


totoplacediffevent rule bustrans:( % skal til nth og skal til risvollan %% %% before beto
is  not present srel/nil/place/_/_,
    not present srel/from/place/_/_ ,
    replaceall (srel/to/place/Place1/E,srel/to/place/Place2/F)
    with       (srel/from/place/Place1/E,srel/to/place/Place2/F)
id  add message(onlyonedestination)
ip  [] ).

bedurationto rule bustrans:( %% varighet til ..
is  present _F1 isa duration,
    present (do)/Be1/Bus/_C,  {dmeq([be1,exist],Be1)},           %% raskeste vei = street
    srel/to/Xplace/Place/C, {dmeq([place,city,station,neighbourhood],Xplace)},

    not comp/_Number/ne/_/Bus,
    not present srel/except/_/Bus/_

id  not flag(exit),
    not findstations(_,_,_),
    atday(Day),atdate2(DaySeqNo,_Date),
    not passevent(_,_bus,Place,_,_,_),    %% at least not Place
    not passevent(_,_bus,_AnyPlace,[to],_,_),
    not connections(_,_,_,_,_,_,_,_,_,_),  %%  already identical name
    add (departure(Bus,Station,DaySeqNo,Depset),
         passevent(Depset,Bus,Station,[to],Day,C))
ip  place_station(Place,Station),
    Station \== unknown ).


bepastfrom rule bustrans:( %% %% Bus past a station probably means that you are at station
is  srel/Past/Xplace/Place/C, { dmeq([past,at,by,dir],Past),
                                dmeq([place,city],Xplace)},
    present Bus isa BR, { dmeq(bus,BR)},  %% disprefer departure
    present (do)/Be1/Bus/_C,
    not comp/_Number/ne/_/Bus
id  atday(Day), atdate2(DaySeqNo,_Date),
    not passevent(_,Bus,Place,_,_,_),     %% same place
    passevent(_,Bus,_Place,[to],_,_), %% if already to, past	 means FROM
    not connections(_,_,_,_,_,_,_,_,_,_),
    add (departure(Bus,Station,DaySeqNo,Depset),
         passevent(Depset,Bus,Station,[from],Day,C))
ip  dmeq([be1,exist],Be1),
    busorfree(Bus),bus_place_station(Bus,Place,Station),
    Station \== unknown ).


arrdep0 rule bustrans:(  % arr dep
is  has/bus/ARRDEP/Bus/_,adj/_/Place/Bus/E %% same event E
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
        passevent(Depset,Bus,Stat,[],Day,E))
ip	 dmeq(arrdep,ARRDEP),busorfree(Bus),
    bus_place_station(Bus,Place,Stat) ).


listdeparture rule bustrans:(  % list departures
is    test, tuc isa savant,dob/list/tuc/A/_,
      A isa Departure, %%%   (do)/be1/A/E,
      srel/for/_/Bus/_E, Bus isa BR,
      clear     %% \+  MIX
id    atday(Day),
	   add (findstations(Bus,Day,Stl),
      passesstations(Bus,Day,Stl,_))
ip    bound(Bus),  dmeq(bus,BR),
      dmeq([departure,route_plan,route],Departure) ).


sorttofrom rule bustrans:( %%   in/place to/place ==> from/place to/place
is  not present adj/_/nearest/_/_ , %% nearest to %% Ad Hoc
    not present srel/from/place/_/_,
    replaceall (srel/in/place/M/E,  srel/to/place/S/E)
    with       (srel/from/place/M/E,srel/to/place/S/E)
id  []
ip  M \== S ).

 % % % %



toplaceobviously rule bustrans:( % toplace obviously
is  context Bus isa BVP,    %% don't hide the very bus number present ???
    context  (do)/TRAVEL/Bus/B,
    srel/to/_/Place/X,
    not present (do)/start/_/X
id  atday(Day),atdate2(DaySeqNo,_Date),
    not  passevent(_,_,_,_,_,_), %% departure(_,Place,_,_),   % not already allocated
    add (departure(Bus,Station,DaySeqNo,Depset),
         passevent(Depset,Bus,Station,[to],Day,B))
ip  dmeq(travel,TRAVEL),
    dmeq(trafficant,BVP),   %% not cat, not bus ?????
    place_station(Place,Station), Station \== unknown,
    newfree(Bus) ).



fromfromplace rule bustrans:( % fra nth fra risvollan   %% (?)
is  not present srel/nil/_/_/_,
    not present srel/to/_/_/_ ,
    replaceall (srel/from/place/Place1/E,srel/from/place/Place2/E)
    with       (srel/from/place/Place1/E,srel/to/place/Place2/E)
id  []
ip  [] ).


%%%% NILPLACE SECTION

%%%% IF already FROM then NIL means TO
nilplaceeqtodialog  rule bustrans:( %%   nth (from risvollan)   TO NTH (from risvollan) //FIRST
is  srel/nil/_/Place/_, present (do)/TRAVELBE/Cat/B,
    not present _ isa departure,
    not present srel/to/place/_/_,  %% \+ "to time" Norw
    not present srel/towards/place/_/_,
    present Cat isa BVP
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
    {\+ frame_getvalue(where::arrival,_,_)} %% <-- NB
) :- double.


nilplacetoeqfromdialog rule bustrans:( % nth to risvollan   %% IF already TO then NIL means FROM
is  srel/nil/_/Place/_,
    present srel/to/place/_ /_,
    present (do)/TRAVELBE/Cat/B,
    not present srel/from/place/_/_ ,
    present Cat isa BVP
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
 ) :- double.


nilplaceemptyeqfromdialog rule bustrans:( % nth to risvollan   %% IF not already TO, not from, = from if NOT in frame
is  srel/nil/_/Place/_,
    present (do)/TRAVELBE/Cat/B,
    not present srel/from/place/_/_ ,
    not present srel/to/place/_/_ ,
    present Cat isa BVP
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
    \+ frame_getvalue(where::departure,_,_) %% <-- NB
) :-double.


nilplacetrondheim rule bustrans:( %%   buss trondheim
is  srel/nil/_/Place/_,        {home_town(Place)},
    present (do)/TRAVELBE/Cat/_, {dmeq(travelbe,TRAVELBE)},
    present Cat isa BVP,
    not present _ isa departure,
    not present srel/to/_/_/_,
    not present srel/towards/_/_/_
id  add message(mustknow(place))
ip  dmeq(trafficant,BVP)
 ):-single.

pastplaceeqfromreplace  rule bustrans:(  %%  forbi markus tranesvei til kvt.
is  not present srel/from/place/_/_ ,
    present srel/TO/place/_/_, {dmeq([to,towards],TO)},
     not present srel/to/place/_/_ ,   %% ABV kl 22.03 til S

    replace srel/past/place/Place/E  %%    markus tranesvei til kvt.
    with    srel/from/place/Place/E , {bound(Place)}, %%  hvor er du fra
       not present dob/avoid/_/_/_,
       not present _ isa arrival
id  not flag(exit)
ip  []
 ):-single.

nilplaceeqfromreplace  rule bustrans:(  %%  markus tranesvei til kvt.// MUST have TO
is  not present srel/from/place/_/_ ,
    present srel/nil/Placoid/Place/_,  {bound(Place)}, %%  hvor er du fra,

        {dmeq([place,station],Placoid)}, %% TA-110405 buss ila studentersamfunnet
                        %% nrel/nil/vehicle/station/free(27)/ila -> srel/nil/station/ila/free(28),
     present srel/TO/place/_/_, {dmeq([to,towards],TO)},

     not present dob/avoid/_/_/_,
     not present _ isa arrival,

    replace srel/nil/Placoid/Place/E  %%    markus tranesvei til kvt.
    with    srel/from/place/Place/E

id  not flag(exit)
ip  []
 ):-single.


nilplacetimeeqfrom rule bustrans:( %% IF time (and only 1 place ) then Nil -> From
is  (do)/TRAVELBE/Cat/E,
       {\+ member(TRAVELBE,[arrive,come])},
   {dmeq(travelbe,TRAVELBE)}, %% is it used up ?
    present srel/Nil/P/place/E , %% NOT time ! %% TA-100829
      { dmeq([nil,past,by,through,at],Nil)},
    present _ isa clock,
    not present dob/avoid/_/_/_,
    not present srel/from/place/_/_ ,
    not present _ isa arrival, %% unless arrival
    present Cat isa BVP,   {dmeq(trafficant,BVP)},
    replaceall (srel/Nil/P/place/E) with
               (srel/from/P/place/E)
id  not flag(exit)
ip  []
 ):-single.


nilplacenotimeeqtoreplace  rule bustrans:(  %% IF no time (and only 1 place ) then S->Place
is  not present _ isa clock,
  not present adj/_/next/_/_, %% next means at station %neste buss fra nardo nth.
    not present dob/avoid/_/_/_,
    not present _ isa arrival,   %% ankomst flybuss lerkendal
    not present _ isa departure, %% unless departure
    not present srel/to/place/_/_ ,
    not present srel/in/place/_/_,
    not present srel/in_order_to/_/_,
    not present srel/to/place/_/_ ,
    not present srel/towards/place/_/_ ,

    replace srel/nil/Q/place/R
    with    srel/to/Q/place/R
id  []
ip  []
 ):-single.


nilplaceeqto rule bustrans:( %%   nth (from risvollan)   TO NTH (from risvollan) //FIRST
is  srel/nil/Plass/Place/_,  %% NOT coevent
       {dmeq([place,station,neighbourhood],Plass)}, %% ANOMALY
    not present adj/_/next/_/_, %% next means at station
%     { \+ value(airbusflag,true)},  %% { DIRTY }   %% ankomst flybuss lerkendal.
    present (do)/TRAVELBE/Cat/B, { dmeq(travelbe,TRAVELBE)},
    not present _ isa departure,
    not present _ isa arrival,  %% ankomst flybuss lerkendal
    not present srel/to/place/_/_,       %% "to time"
%    not present srel/to/_/_/_,  %% til D %% NSB qua company %% TA-101215 %RS-141024 nth natt til søndag
    not present srel/towards/place/_/_,  %%
    not present srel/in/place/_/_,       %%  bussen nth for å være i nardo.

    present Cat isa BVP,{dmeq(trafficant,BVP)}
id  atday(Day),atdate2(DaySeqNo,_Date),
    not   passevent(_,_,_,[to],_,_),
    not   connections(_,_,_,_,_,_,_,_,_,_), %% finished
    not  departure(Bus,Place,_,_),
    add (departure(Bus,Station,DaySeqNo,Depset),
         passevent(Depset,Bus,Station,[to],Day,B))
ip  bus_place_station(Cat,Place,Station),  %%  bus_
         Station \== unknown,
    i_or_a_bus(Cat,BVP,Bus),
   \+ neverpasses(Cat,Station)  %% buss 5 from ila to dokkparken ).
) :- single.



% END NILPLACE SECTION




hasarrivaltoplace rule bustrans:( %%  Baroque
is  srel/TO/place/Place/_ ,      %%  Too Restricted ?
    {    dmeq([to],TO)},    %%
    present  has/agent/BusArr/_I/_, {dmeq([bus,arrival],BusArr)}
id  atday(Day),atdate2(DaySeqNo,_Date),
    not   passevent(_,_,_,[to],_,_),
    not   connections(_,_,_,_,_,_,_,_,_,_), %% finished
    not  departure(Bus,Place,DaySeqNo,Depset),
    add (departure(Bus,Station,DaySeqNo,Depset),
         passevent(Depset,Bus,Station,[to],Day,free(0)))
ip  place_station(Place,Station),   Station \== unknown ).


hasdeparturefromplace rule bustrans:( %%  Baroque
is  srel/FROM/place/Place/_ ,  {dmeq([from,after,around],FROM)},
    has/agent/BusDep/_I/_,     {dmeq([bus,departure],BusDep)}
id  atday(Day),atdate2(DaySeqNo,_Date),
    not   passevent(_,_,_,[from],_,_),
    not   connections(_,_,_,_,_,_,_,_,_,_), %% finished
    not  departure(Bus,Place,DaySeqNo,Depset),
    add (departure(Bus,Station,DaySeqNo,Depset),
         passevent(Depset,Bus,Station,[from],Day,free(0)))
ip  place_station(Place,Station),   Station \== unknown ).


fromplace1 rule bustrans:( % someone TRAVEL FROM a place?
is  srel/FROM/place/Place/_ ,   %%  Too Restricted ?
      { dmeq([after,around,from,past  ],FROM)}, %%,on %% fra skansen for a vaere pa ostre berg 1530
                                            %% er jeg på nardo %%   %% in depart in = from
                                            %% Jeg bor i sentrum og skal  fra heimdal
                                            %% NOT in
                                            %% Når går bussen FORBI samfunnet til byen %% RS-160109
    present (do)/TRAVELFROM/Cat/B, { dmeq(travelfrom,TRAVELFROM)},
    present Cat isa BVP, {dmeq(trafficant,BVP)} %% hvilke busser går forbi IKEA = to

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
    i_or_a_bus(Cat,BVP,Bus) ).


neverpassfromessage  rule bustrans:( %%  after fromplace1 in case of depend
is  srel/FROM/place/Place/X,  { dmeq([from],FROM)},
    present Place isa SN,
        {bound(Place), dmeq([station,neighbourhood,street],SN)},
    present (do)/TRAVELBE/Cat/B, { dmeq(travelbe,TRAVELBE)},
    present Cat isa BVP,    { bound(Cat), dmeq(vehicle,BVP)},
    not present (do)/start/_/X   %% start to go special
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
    place_station(Place,Station) ).


befromplace rule bustrans:( % and ...  I am on NTH and ...
is  (do)/be1/Agent/_,
    Agent isa Whatever, %% bussholdeplassen på risvollansenteret
    srel/on/place/Place/C,
    present (do)/go/Agent/C
id  atday(Day),atdate2(DaySeqNo,_Date),
    not passevent(_,_,Place,_,_,_),
    add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[from],Day,C))
ip  i_or_a_bus(Agent,Whatever,Bus),
    bus_place_station(Bus,Place,Stat),
    Stat \== unknown ).


busnotoplacetowards rule bustrans:(  %% Does a bus TRAVEL TO a place TOWARDS a place ?
is   context srel/towards/place/_/_,
     srel/to/place/Place/C, %% actually from
     present (do)/TRAVEL/Bus/C,
     present Bus isa BUS
id   atday(Day),atdate2(DaySeqNo,_Date),
     not passevent(_,_,_,[from],_,_), %% already (Panic)
     add (departure(Bus,Stat,DaySeqNo,Depset),
          passevent(Depset,Bus,Stat,[from],Day,C))
ip  dmeq(travel,TRAVEL),
    dmeq([bus,nightbus,self,agent,route,departure,tram,it,connection],BUS),
    busorfree(Bus),
    bus_place_station(Bus,Place,Stat),
    Stat \== unknown ).

busforto rule bustrans:(  %% Does a bus TRAVEL FOR  a place TO a place ?
is   context srel/to/place/_/_,
     srel/for/place/Place/C, %% actually from
     present (do)/TRAVEL/Bus/C,
     present Bus isa BUS
id   atday(Day),atdate2(DaySeqNo,_Date),
     not passevent(_,_,_,[from],_,_), %% already (Panic)
     add (departure(Bus,Stat,DaySeqNo,Depset),
          passevent(Depset,Bus,Stat,[from],Day,C))
ip  dmeq(travel,TRAVEL),
    dmeq([bus,nightbus,self,agent,route,departure,tram,it,connection],BUS),
    busorfree(Bus),
    bus_place_station(Bus,Place,Stat),
    Stat \== unknown ).


iamin rule bustrans:( %% I am in Risvollan
is  replaceall (I isa self,(do)/be1/I/E,srel/in/place/N/E)
    with       (I isa self,(do)/go/I/E,srel/from/place/N/E) %% ... Restrictions
id  []
ip  [] ).

arrivesnil rule bustrans:( %% arrrive dragvoll = go to dragvoll %% TA-101108
is  replaceall ((do)/arrive/I/F5,srel/nil/place/Dragvoll/F5)
    with       ((do)/go/I/F5,srel/to/place/Dragvoll/F5)
id  []
ip  [] ).

frem1 rule bustrans:( %% fram i edgar b sjeldropsvei kl 19.
is
    replaceall (srel/in/time/_Time/E,srel/On/place/D/E)
    with       ((do)/go/'I'/E,srel/to/place/D/E),
    {dmeq([on,at,in],On)},
    not present srel/to/place/D/E %% TA-110825

id  []
ip  [] ).

fremme1 rule bustrans:( %% framme i edgar b sjeldropsvei kl 19.
is  replaceall (srel/there/place/nil/E,srel/On/place/D/E)
    with       ((do)/go/'I'/E,srel/to/place/D/E),
    {dmeq([on,at,in],On)}
id  []
ip  [] ).

fremme2 rule bustrans:( %% %% fremme på dragvoll %% TA-101108
is  replaceall (adj/nil/(present)/I/E,srel/On/place/D/E)
    with       ((do)/go/I/E,srel/to/place/D/E),
    {dmeq([on,at,in],On)}
id  []
ip  [] ).


tohomeon rule bustrans:( %% til "hjem" på Dalen hageby %% TA-110330
is replaceall (srel/to/place/Free74/Free75,srel/on/place/Dalen_hageby/Free75,Free74 isa home)
   with       (srel/to/place/Dalen_hageby/Free75)
id []
ip [] ).


toplace1 rule bustrans:(  %% Jeg er på lade og skal til dragvoll ==> TO dragvoll
is  srel/TO/PC/Place/X,
      {dmeq([to,at,for,near,outside,towards,dir,  on, along	],TO)}, %% TA-100930

       %% \+ in   ambiguous if to occurs otherwise

     {dmeq([place,company,agent,station],PC)}, %% TA-110401 %% expensive

    not has/agent/_Departure/_Tuc/_/_,
    present Cat isa BVP,   {dmeq(trafficant,BVP)},
    present (do)/TRAVELTO/Cat/B,  {dmeq(travelto,TRAVELTO)},
    not present (do)/start/_/X   %% start to go special
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
    \+ neverpasses(Cat,Station) ). %% buss 5 from ila to dokkparken.


%%%% TA-110509    buss  43 fra romolslia til jarleveien.
neverpasstostreet rule bustrans:(
is  present srel/TO/Plass/Jarlestreet/X,
        {dmeq([for,in,to,towards,outside,nil,on,dir,near,past,at],TO)},
     {dmeq([place,station],Plass)},
    present Jarlestreet isa Street,
        {dmeq([neighbourhood,street],Street)},
        {bound(Jarlestreet)},
    present (do)/TRAVELBE/Bus43/B, {dmeq(travelbe,TRAVELBE)},
    present Bus43 isa BVP,  { bound(Bus43), dmeq(vehicle,BVP)},
    not present (do)/start/_/X
id  not message(neverpasses(Bus43,Jarlestreet)), %% retention
    not connections(_,_,_,_,_,_,_,_,_,_),
    not passevent(_Depset,_Bus,_Jarle_street,Opts,_Day,_B) when {testmember(to,Opts)},
    atday(Day),atdate2(DaySeqNo,_Date),
    add (departure(Bus,Ladekirke,DaySeqNo,Depset),
         passevent(Depset,Bus,Ladekirke,[to],Day,B)),
    add message(neverpasses(Bus43,Ladekirke))
ip  bus_place_station(Bus43,Jarlestreet,Ladekirke),
    neverpasses(Bus43,Jarlestreet),
    newfree(Bus) ).



%%%% buss 60 til Berg /neib &station) ??? //NB also negans message
neverpasstostationmessage  rule bustrans:(  %%  Bus doesnt passes Destination!  %%  after toplace1 (in case of  depend)
is  present srel/TO/Plass/Dragvoll/X,  %% (see retention)
        {dmeq([for,in,to,towards,outside,nil,on,dir,near,past,at],TO)}, %% TA-100903
     {dmeq([place,station],Plass)}, %% ANOMALY %% TA-100929
    present Dragvoll isa Station,
        {dmeq([station,neighbourhood,street],Station)}, %% TA-101112 + street
        {bound(Dragvoll)},
    present (do)/TRAVELBE/Bus36/B, {dmeq(travelbe,TRAVELBE)},
    present Bus36 isa BVP,  { bound(Bus36), dmeq(vehicle,BVP)},
    not present (do)/start/_/X  %% start to go special
id  not message(neverpasses(Bus36,Dragvoll)), %% retention
    not connections(_,_,_,_,_,_,_,_,_,_),

    not passevent(_Depset,_Bus,_Dragvoll,Opts,_Day,_B) when {testmember(to,Opts)},
    %% toplace already fixed

    atday(Day),atdate2(DaySeqNo,_Date),
    add (departure(Bus,Dragvoll,DaySeqNo,Depset),
         passevent(Depset,Bus,Dragvoll,[to],Day,B)),
    add message(neverpasses(Bus36,Dragvoll))
%     add flag(exit)  %% no more neg answers %% -> allow TRANSFER
ip  neverpasses(Bus36,Dragvoll),
    newfree(Bus) ).



%%%% gives spurious deps from sentrum
neverpasstomessage2  rule bustrans:(  %%  Bus doesnt passes destination , not station
is  present srel/TO/SN/Risvollan/X,  %% (see retention)
      { dmeq([for,in,on,to,towards,outside,nil,dir,near,past],TO)},
     present Risvollan isa SN,
        { bound(Risvollan),
          dmeq([neighbourhood,street,station],SN)}, %% not station ???????
    present (do)/TRAVELBE/Bus36/B, { dmeq(travelbe,TRAVELBE)},
    present Bus36 isa BVP,    { bound(Bus36), dmeq(vehicle,BVP)},
    not present (do)/start/_/X,  %% start to go special
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
%%%%     add flag(exit)  %% no more neg answers %%  allow for transfer

ip  neverpasses(Bus36,Risvollansenteret),
    newfree(Bus) ).



nilp rule bustrans:( % Does a bus TRAVEL () a place?   //
is  present Bus isa BDA,present (do)/TRAVEL/Bus/C,srel/nil/Placoid/Place/C
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Station,DaySeqNo,Depset),
         passevent(Depset,Bus,Station,[],Day,C)) %% dont guess dir
ip	dmeq(travel,TRAVEL),
   dmeq([place,neighbourhood,station],Placoid),
   dmeq([bus,departure],BDA),
   notbothfree(Bus,Place),
   busorfree(Bus),
   bus_place_station(Bus,Place,Station)
 ):- double.




%%%% ENDSTATION SECTION BEFORE FINDSTATION  SECTION


endstat1 rule bustrans:( % What is the first STATION FOR Bus
is  which(A),(do)/be1/A/D,srel/in/place/Station/D,adj/_/first/Station/_,
    srel/FOR/bus/Bus/D,
    present Bus isa bus,present Station isa STATION
id  add endstations(Bus,_)
ip  dmeq(for,FOR),exbus(Bus),dmeq(place,STATION) ).


endstat2 rule bustrans:( % What is the last STATION FOR Bus
is  which(A),(do)/be1/A/D,srel/in/place/Station/D,adj/_/last/Station/_,
    srel/FOR/bus/Bus/D,
    present Bus isa bus,present Station isa STATION
id  add endstations(Bus,_)
ip  dmeq(place,STATION),dmeq(for,FOR) ,exbus(Bus) ).


endstat3 rule bustrans:( % What is the name of the endstation for Bus
is  which(A),B isa endstation,has/_V/endstation/Bus/B,dob/be/A/B/_  %%be_named
id  add endstations(Bus,_)
ip  exbus(Bus) ).


endstat4 rule bustrans:( % What is the endstation for Bus
is  which(A),has/_/endstation/Bus/A
id  add endstations(Bus,_)
ip  exbus(Bus) ).


endstat5 rule bustrans:( % Where is the endstation for Bus
is  which(A),A isa place,E isa endstation,has/_/endstation/Bus/E,(do)/be1/E/D,srel/_/place/A/D
id  add endstations(Bus,_)
ip  exbus(Bus) ).


endstat6 rule bustrans:( % Where do the buses turn
is  which(A),A isa place,Bus isa Route,turn/Bus/D,srel/in/place/A/D
id  add endstations(Bus,_)
ip  dmeq(vehicle,Route),exbus(Bus) ).


endstat7 rule bustrans:( % What is the endstation for Bus
is  which(A),has/_/endstation/Tram/A, Tram isa tram
id  add endstations(One,_) %% # Trikken
ip  thetramno(One) ).


endstat8 rule bustrans:( % What is the endstation for Bus
is  which(A), A isa endstation,Bus isa BR, (do)/BE/A/E,event/real/E,srel/ON/BR1/Bus/E
id  add endstations(Bus,_),
    add flag(exit)
ip  exbus(Bus),dmeq([on,for,in,to],ON),dmeq([bus,nightbus,route],BR),
    dmeq([bus,nightbus,route,vehicle],BR1),
    dmeq([be1],BE) ).


endstat8be rule bustrans:( % Hva er startholdeplassen til buss nr 5?
is  which(A), B isa endstation,dob/be/A/B/_ ,Bus isa BR,srel/ON/vehicle/Bus/_
id  add endstations(Bus,_),
    add flag(exit)
ip  exbus(Bus),dmeq([on,for,in,to],ON),dmeq([bus,nightbus,route],BR) ).


endstat8hete rule bustrans:( % What is the endstation for Bus
is  which(A),B isa endstation,
    srel/ON/_/B24/_,
    B24 isa BR,
    dob/be_named/A/B/_
id  add endstations(Bus,_)
ip  exbus(Bus),
    dmeq([on,for,in,to],ON),
    dmeq([bus,nightbus,route],BR) ).


endstat9 rule bustrans:( % Where is the endstation for Bus
is  which(X), A isa endstation, X isa place,
    (do)/BE/A/E,srel/ON/VEH/B52/E,B52 isa BR,
    event/real/E,srel/in/place/X/E
id  add endstations(B52,_)
ip  exbus(B52),
    dmeq([on,for,in,to],ON),
    dmeq([bus,nightbus,route,vehicle],BR),
    dmeq([bus,nightbus,route,vehicle],VEH),
    dmeq([be1],BE) ).


endstat10 rule bustrans:( % Where is the endstation ----
is  which(X), X isa endstation,
    not present _ isa station,
    not present _ isa neighbourhood,
    not present _ isa street
id  add message(mustknow(bus))
ip  [] ).

whereendstat1 rule bustrans:(
is  which(P),P isa endstation,B52 isa route,(do)/be1/P/E,srel/_/route/B52/E,
    {bound(B52)}
id  add endstations(B52,_)
ip  [] ).


%%%% FINDSTATION SECTION  2

findstation2 rule bustrans:(
is  which(R), dob/run/Bus20/R/A,  Bus20 isa bus,R isa route
id	 atday(Day),
	 add (findstations(Bus20,Day,Stl),
         passesstations(Bus20,Day,Stl,A))
ip	 [] ).


findstation3 rule bustrans:( % Hvor kan jeg PASS on Bus
is  which(Station),(do)/PASS/_/B,srel/In/place/Station/B,srel/On/VEHICLE/Bus/B,
    present Bus isa bus
id	 atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,_))
ip	 dmeq([in,at],In),
    dmeq([on,off,by],On), %% av -> by   Repair Hack
    unbound(Station),exbus(Bus),dmeq(pass,PASS),dmeq(vehicle,VEHICLE) ).


findstation4 rule bustrans:( % Where can i get off Bus
is  which(Place),present Bus isa bus,
    present get/_/E,
	 srel/in/place/Place/E,srel/off/VEHICLE/Bus/E
id	 atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,E))
ip	 unbound(Place),exbus(Bus),dmeq(vehicle,VEHICLE) ).


findstation5 rule bustrans:( % Where can i get on Bus
is  which(Place),present Bus isa bus,
    present get/_/E,
	 srel/in/place/Place/E,srel/on/VEHICLE/Bus/E
id	 atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,E))
ip	 unbound(Place),exbus(Bus),dmeq(vehicle,VEHICLE) ).


findstation6 rule bustrans:( % Which stations is AT route Bus
is  which(St),(do)/be1/St/A,srel/AT/bus/Bus/A,Bus isa bus,St isa station
id	 atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,A))
ip	 dmeq(at,AT),unbound(St),exbus(Bus) ).  %% dmeq first


findstation7 rule bustrans:( % Hva er stasjoner til en buss
is  Station isa station,(do)/be1/Station/E,srel/to/vehicle/Bus/E
id	 not message(nearest_station(_ST,_,_)),
    atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,_))
ip	 unbound(Station),exbus(Bus) ).


findstation8 rule bustrans:( % Hva er stasjonene til en buss
is  which(Station),has/vehicle/station/Bus/Station
id	 not departure(_,_,_,_),
    atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,_))
ip	 unbound(Station),exbus(Bus) ).


findstationwhere rule bustrans:( % Hvor  er stasjonene til en buss
is  which(A),A isa place,Bus isa Veh,S isa station,has/_Vehicle/station/Bus/S,
    (do)/be1/S/D, srel/in/place/A/D ,                     %% route/vehicle
      {dmeq(vehicle,Veh)}
id	 not departure(_,_,_,_),
    atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,_))
ip	 unbound(A),exbus(Bus) ).


findstation8nobus rule bustrans:( % Hva er stasjonene til en buss
is  which(Station),has/vehicle/station/Bus/Station
id	 not departure(_,_,_,_),
    add message(mustknow(bus)),
    add flag(exit)                   %% avoid vet ikke
ip	 unbound(Station),unbound(Bus) ).


findstation9 rule bustrans:( %%   ruteplan for en buss
is  has/BR/Route_plan/Bus/_Route
id  not departure(_,_,_,_),
    atday(Day),
    add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,_))
ip  dmeq([bus,nightbus,route,vehicle],BR),
    dmeq([route_plan,route],Route_plan),
    exbus(Bus) ).


findstation20 rule bustrans:(  %% Variant   rute for en rute
is  which(Route),has/BR/Route_plan/Route/Bus  %% hvilken rute har buss 54
id       atday(Day),
         add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,_))
ip       dmeq([bus,nightbus,route,vehicle],BR),
    dmeq([route_plan,route],Route_plan),
    exbus(Bus) ).


findstation30 rule bustrans:( % Hva er trasee for en rute
is  which(Route),B52 isa bus,
    Route isa route_plan,srel/FOR/BR/B52/_E,
    not srel/_With/time/_/_ , %%   (Detail)
    not srel/_/place/_/_
id	 atday(Day),
	 add (findstations(B52,Day,Stl),passesstations(B52,Day,Stl,_))
ip	 dmeq(for,FOR), dmeq(bus,BR),
    unbound(Route),exbus(B52) ).


findstation40 rule bustrans:( % Hvor kan jeg ta en Bus
is  which(Station),dob/take/_/Bus/B,srel/in/place/Station/B,present Bus isa bus
id	 atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,_))
ip	 unbound(Station),exbus(Bus) ).


findstation60 rule bustrans:(  % Hvor kan jeg PASS off Bus
is  which(Station),(do)/PASS/_/B,srel/in/place/Station/B,srel/off/VEHICLE/Bus/B,
    present Bus isa bus
id	 atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,_))
ip	 unbound(Station),exbus(Bus),dmeq(pass,PASS),dmeq(vehicle,VEHICLE) ).


findstation70 rule bustrans:( % Hvor kan jeg PASS with Bus
is  which(Station),(do)/PASS/_/B,srel/in/place/Station/B,
    srel/(with)/VEHICLE/Bus/B,present Bus isa bus
id	 atday(Day),
	 add (findstations(Bus,Day,Stl),passesstations(Bus,Day,Stl,_))
ip	 unbound(Station),exbus(Bus),dmeq(pass,PASS),dmeq(vehicle,VEHICLE) ).


findstation80 rule bustrans:( % Where PASS the Bus bus
is  which(Place),srel/in/place/Place/D,
    present B isa bus, (do)/PASS/B/D,present adj/_/Bus/B/_
id	 atday(Day),
	 add (findstations(Bus,Day,Stl),
         passesstations(Bus,Day,Stl,_))
ip	 unbound(Place),exbus(Bus),dmeq(pass,PASS) ).


findstation90 rule bustrans:( % Hviken ruteplan/rute  tar/følger buss 20
is  which(A),A isa RP,Bus isa Veh,dob/Take/Bus/A/_
id	 atday(Day),
	 add (findstations(Bus,Day,Stl),
         passesstations(Bus,Day,Stl,_))
ip	 bound(Bus),dmeq([take,follow,pass],Take),
    dmeq([route,route_plan],RP),dmeq(vehicle,Veh) ).


%%% End of FindStation Section %%%%%%%%%%%%%%%%%

%%%% SECTION  Pass

passby2 rule bustrans:( %  Does a bus PASS BY two places? % OR A PERSON
is  Bus isa Busman,present (do)/PASS/Bus/A,srel/TOFROMBY/place/(StartPlace,EndPlace)/A
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,StartStat,DaySeqNo,StartDepset),
			passevent(StartDepset,Bus,StartStat,[],Day,A),
			departure(Bus,EndStat,Day,EndDepset),
			passevent(EndDepset,Bus,EndStat,[],Day,A))
ip	 dmeq(tofromby,TOFROMBY),
    place_station(StartPlace,StartStat),place_station(EndPlace,EndStat),
    dmeq(pass,PASS),busman(Bus,Busman) ).


passbyname rule bustrans:( % Does a bus PASSBY a place? (Place is unbound) ??? <----------
is  exactly (which(Time),Bus isa bus, Time isa Timeq,
				 PASSBY/Bus/Place/C,event/real/C,srel/in/time/Time/C)
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Place,DaySeqNo,Depset),
			passevent(Depset,Bus,Place,[],Day,C))
ip	 unbound(Place),dmeq(passby,PASSBY),dmeq(time,Timeq) ).


travelbyplace rule bustrans:( % Do I  TRAVEL BY a place?
is  present I isa SELF, present (do)/TRAVEL/I/C, srel/BY/Placoid/Place/C,
    not present srel/to/place/_/_ %% then [] is not an option
id	 not flag(exit),
    atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[],Day,C))
ip	 dmeq(travel,TRAVEL),
    TRAVEL \== arrive, %% postpone arrive destination , to arrive at = go to
    TRAVEL \== come,
    dmeq(by,BY),dmeq([self,program,agent],SELF),
    dmeq([place,city],Placoid), %% Trondheim as city
    place_station(Place,Stat),newfree(Bus) ).


superfluousvia rule bustrans:(  %% (from X to Y)  VIA Z
is  srel/BY/place/Place/C,   {dmeq(by,BY)},
    present Bus isa BR,
    present (do)/TRAVELBE/Bus/C,
    not present srel/dir/place/_/_,
    not present srel/nil/place/_/_
id	 not flag(exit),
    not message(neverpasses(_,Place)),  %% %% når går buss nr 60 fra sentrum forbi berg
    passevent(_,_,_,[from],_,_),
    passevent(_,_,_,[to],_,_),
    add message(toomanyplaces)
ip	 dmeq(bus,BR),dmeq(travelbe,TRAVELBE), %  ved = kommer til
    busorfree(Bus) ).


%%%% Does a bus TRAVEL BY a place? Detect to option
%%%%     hvis jeg skal være i hornebergveien kl 1500

travelbyto rule bustrans:(  %% past X from  Y
is  srel/BY/place/Place/C,   {dmeq(by,BY)},
     not present srel/to/_/_/_, %% til muligheten (SIC) %% TA-110204

    present Bus isa BR,present (do)/TRAVELBE/Bus/C,
    not present srel/dir/place/_/_

id	 not flag(exit),
    not message(neverpasses(_,_Place)),  %% %% når går buss nr 60 fra sentrum forbi berg
    atday(Day),atdate2(DaySeqNo,_Date),
%	 passevent(_,_,_,Opts0,_,_),     %% TA-110119
    add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[to],Day,C))
ip	 %%%   member(from,Opts0),   %% TA-110119
    dmeq(bus,BR),dmeq(travelbe,TRAVELBE), %  ved = kommer til
    busorfree(Bus),
    bus_place_station(Bus,Place,Stat) ). %% OOPS  nth

travelbyfrom rule bustrans:( % Does a bus TRAVEL BY a place?  => TRAVEL  == FROM
                  %% (only one place mentioned,  time related to that)
is  srel/BY/Placoid/Place/C, {dmeq(by,BY)},
    present Bus isa BR, {dmeq(vehicle,BR)},
    present (do)/Go/Bus/_C , { dmeq([go,stop,run,drive,pass],Go)} ,
    not present (do)/stop/_/_, %% stop never means from
    not present srel/to/place/F/_ when {bound(F)}, %% Hvor tar jeg  bussen forbi ranheim fotballbane?
    not present srel/from/_/_/_,
    not present srel/nil/place/Place/_ %%% when { (Place1 \== Place)} NEVER FROM=TO
id	  not flag(exit),
    atday(Day),atdate2(DaySeqNo,_Date),
    add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[from],Day,C))
ip  dmeq([place,neighbourhood,station,city],Placoid),
    busorfree(Bus),
    bus_place_station(Bus,Place,Stat) ). %% OOPS  nth


travelbybusbyp rule bustrans:( % someone TRAVEL BY bus by a place?
is  present Bus isa bus,present (do)/TRAVEL/_/A,
    present srel/by/vehicle/Bus/A,srel/BY/place/Place/A
id	 not flag(exit),
    atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),passevent(Depset,Bus,Stat,[],Day,A))
ip  dmeq(travel,TRAVEL),dmeq(by,BY),place_station(Place,Stat),
    busorfree(Bus) ).


sometravelby rule bustrans:( % Can someone TRAVEL BY a place a time?
is  present (do)/TRAVEL/_/Time/B,srel/BY/place/Place/B
id	 not flag(exit),
    atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         keeparound(Time,Depset,NewDepset), %% keepat
			passevent(NewDepset,Bus,Stat,[],Day,B))
ip  dmeq(by,BY),place_station(Place,Stat),number(Time),
    dmeq(travel,TRAVEL),   newfree(Bus) ).


nnpassing rule bustrans:( % is a NN bus PASSing a place?
is  present Bus isa bus,present PASSBY/Bus/_,adj/_/Place/Bus/A
id	  not flag(exit),
    atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[],Day,A))
ip	 dmeq(passby,PASSBY),place_station(Place,Stat),
    busorfree(Bus) ).


somepassbybus0 rule bustrans:( % Does a place belong to a route?
is  belong_to/Place/Bus/A
id	  not flag(exit),
    atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[buses],Day,A))
ip  busorfree(Bus),
    bus_place_station(Bus,Place,Stat) ).


somepassbybus1 rule bustrans:( % Does a bus PASS a place?  Dragvoll misere
is  PASSBY/Bus/Place/A,
    not srel/from/place/_/_
id	 not flag(exit),
    atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[],Day,A))
ip  dmeq(passby,PASSBY),busorfree(Bus),
    bus_place_station(Bus,Place,Stat) ).


somepassbybus2 rule bustrans:( % which routes station does route have
is  has/route/station/Bus/Place
id	 not flag(exit),
    atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[],Day,F))
ip  busorfree(Bus),newfree(F),
    bus_place_station(Bus,Place,Stat) ).


somepassbybus3 rule bustrans:( % På hvilke ruter fins moholt
is  which(A),A isa route,
    (do)/be1/Place/B,srel/on/route/A/B,event/real/B
id	 not flag(exit),
    atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[],Day,F))
ip  busorfree(Bus),newfree(F),
    bus_place_station(Bus,Place,Stat) ).


hasstation1 rule bustrans:( % bus has station
is  replaceall (R isa BR, has/route/station/R/A,A isa station)
    with       (R isa route,
	             A isa station,pass/R/E,srel/dir/place/A/E)
id  []
ip  dmeq(bus,BR),bound(R),newfree(E) ).


allbuses99  rule bustrans:( %%  list all the buses
is  tuc isa savant, B52 isa BR, dob/LIST/tuc/B52/X,event/real/X,
    not present adj/_/_/_/_, %% seneste?
    not present  srel/_/_/_/_   ,
    not B63 isa route when { bound(B63)} %% not mention a route
id  not departure(_,_,_,_),
    not findstations(_,_,_),
    add listofall(bus,_)
ip  dmeq(list,LIST),dmeq(bus,BR),unbound(B52) ).


doescome rule bustrans:( %%  Does a bus COME a place? (Place is unbound)
is  exactly (which(Time),Bus isa bus, Time isa Timeq,
				 COME/Bus/Place/C,event/real/C,srel/in/time/Time/C)
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Place,DaySeqNo,Depset),
			passevent(Depset,Bus,Place,[],Day,C))
ip	 unbound(Place),dmeq(come,COME),dmeq(time,Timeq) ).


passto1 rule bustrans:( % Does a bus PASS TO a place? (Place is unbound)
is  (do)/PASS/_/A,srel/TO/place/nil/A
id  atday(Day),atdate2(DaySeqNo,_Date),
    add (departure(Bus,PlaceVar,DaySeqNo,Depset),
			passevent(Depset,Bus,PlaceVar,[],Day,A))
ip	 dmeq(pass,PASS),dmeq(to,TO),newfree(PlaceVar) ).


gotoplace rule bustrans:( % Does a bus PASS TO a place?
is  (do)/PASS/Bus/A,srel/TO/place/Place/A,
    present Bus isa BVP
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
    Stat \== unknown ).


travelby1 rule bustrans:( % someone TRAVEL by bus a place?
is  present Bus isa bus,present (do)/TRAVEL/_/A,
    present srel/by/vehicle/Bus/A,srel/TO/place/Place/A
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[],Day,A))
ip  dmeq(travel,TRAVEL),dmeq(to,TO),
    busorfree(Bus),
    bus_place_station(Bus,Place,Stat) ).


travelby2 rule bustrans:( % someone TRAVEL TO a place when I start at ...
is  present (do)/TRAVEL/Cat/B, (do)/start/_/X ,  %% when I start at
    srel/AT/_/Place/X,
    present Cat isa BVP
id  atday(Day),atdate2(DaySeqNo,_Date),
    not  departure(Bus,Place,DaySeqNo,Depset),
    add (departure(Bus,Station,DaySeqNo,Depset),
         passevent(Depset,Bus,Station,[from],Day,B)) %% NB from
ip  dmeq(travel,TRAVEL),
    dmeq([for,in,on,at],AT), %%  derived    gå i byen// arrive at
    dmeq(trafficant,BVP),           %% Experiment  Not CAT
    place_station(Place,Station),newfree(Bus) ).


travelby99 rule bustrans:( % travel "by" a vehicle which is not a bus
is  present B isa NOTBUS,srel/by/vehicle/B/_
id	 not fail,
	 add fail
ip  dmeq(notbus,NOTBUS) ).


passplace1 rule bustrans:( % someone pass a place?
is  present I isa self, P isa Place,present dob/PASS/I/P/B
id       atday(Day),atdate2(DaySeqNo,_Date),
    not  departure(Bus,P,DaySeqNo,Depset),
         add (departure(Bus,P,DaySeqNo,Depset),
         passevent(Depset,Bus,P,[],Day,B))
ip  dmeq(pass,PASS),
    dmeq(place,Place),
    statorplace(P),newfree(Bus) ).



travelto  rule bustrans:(
is  srel/to/_/place/_X, present (do)/TRAVEL/Cat/B,
    present Cat isa BVP
id  atday(Day),atdate2(DaySeqNo,_Date),
    not  departure(Bus,Place,DaySeqNo,Depset),
    add (departure(Bus,Station,DaySeqNo,Depset),
         passevent(Depset,Bus,Station,[to],Day,B))
ip  dmeq(travel,TRAVEL),
    dmeq(trafficant,BVP),
    place_station(Place,Station),newfree(Bus) ).


travelto2 rule bustrans:( % Can someone TRAVEL TO a place a time?
is  present (do)/TRAVEL/_/Time/B,srel/TO/place/Place/B
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
          keepbefore1(Time,Depset,NewDepset), %% keepat %% < 1 hour before
			passevent(NewDepset,Bus,Stat,[],Day,B))
ip  dmeq(travel,TRAVEL),number(Time),
    dmeq(to,TO),place_station(Place,Stat),newfree(Bus) ).

%%%% passplace2 rule bustrans:( subsumed passfromto4

comebus1 rule bustrans:( % is a Place bus  COMEing?
is  present Bus isa bus,present COME/Bus/_,adj/_/Place/Bus/A
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[],Day,A))
ip	 dmeq(come,COME),
    busorfree(Bus),
    bus_place_station(Bus,Place,Stat) ).


passplaceto rule bustrans:( % pass place TO Place
is  present dob/PASS/Bus/_/A,
    srel/TO/place/Place/A
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[to],Day,A))
ip  dmeq(to,TO), dmeq(pass,PASS),
    busorfree(Bus),bus_place_station(Bus,Place,Stat) ).

passplacefrom rule bustrans:( % pass place FROM Place
is  present dob/pass/Bus/_/A,
    srel/from/place/Place/A
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[from],Day,A))
ip  busorfree(Bus),
    bus_place_station(Bus,Place,Stat) ).


passtoplace3 rule bustrans:( % when PASS Bus TO Place,   srel variant
is  present srel/TO/place/Place/B,present (do)/PASS/Cat/B,
    present Cat isa BVP
id	 atday(Day),
         replace  passevent(Depset,Bus,Place1,[],Day,B)
         with     passevent(Depset,Bus,Place1,[to],Day,B)
ip	 dmeq(to,TO),dmeq(pass,PASS),
    dmeq(trafficant,BVP),
    statorplace(Place),busorfree(Bus) ).


befed rule bustrans:(  %%  Dirty
is    R isa route,  Bus isa bus,
      (do)/be1/R/X, event/real/X, srel/for/bus/Bus/X, % route for Bus
      (do)/be1/R/C, event/real/C, srel/TO/place/Place/C
id	 atday(Day),atdate2(DaySeqNo,_Date),
    add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[to],Day,C)) %% same event C
ip	 dmeq(to,TO),bus_place_station(Bus,Place,Stat) ).


%%% Default-regler for fraser helt uten steder (Place is unbound)


arrdep1 rule bustrans:( % ARRDEP with buss (Place is unbound)
is  present  Arrdep isa ARRDEP, %% which(Arrdep), %% also test
    (do)/be1/Arrdep/E,srel/(with)/bus/Bus/E ,
    not present srel/_/place/_/_
id  not passevent(_,Bus,_,_,_,_),
    not connections(_,_,Bus,_,_,_,_,_,_,_),
    atday(Day),atdate2(DaySeqNo,_Date),
    add (departure(Bus,hovedterminalen,DaySeqNo,Depset),
			passevent(Depset,Bus,hovedterminalen,[],Day,_))
ip  dmeq(arrdep,ARRDEP), busorfree(Bus),
    bound(Bus),                                 %% does it blur the rule (
    \+ neverpasses(Bus,hovedterminalen) ).


arrdep2 rule bustrans:(
is  present  Arrdep isa TAR, %% which(Arrdep), %% also test
    has/bus/ARRDEP/Bus/Arrdep,
    not present srel/_/place/_/_             %%  etc. etc. etc.
id  not passevent(_,Bus,_,_,_,_),
    not connections(_,_,Bus,_,_,_,_,_,_,_),
    atday(Day),atdate2(DaySeqNo,_Date),
    add (departure(Bus,hovedterminalen,DaySeqNo,Depset),
			passevent(Depset,Bus,hovedterminalen,[],Day,_))
ip  dmeq(arrdep,ARRDEP),dmeq(arrdep,TAR),
    busorfree(Bus),
    bound(Bus),                                 %% does it blur the rule bustrans ):(
    \+ neverpasses(Bus,hovedterminalen) ).


arrdep3 rule bustrans:( % ARRDEP for buss (Place is unbound)
is  present  Arrdep isa ARRDEP, %% which(Arrdep), %% also test
    has/bus/ARRDEP/Bus/Arrdep
id  not passevent(_,Bus,_,_,_,_),
    not connections(_,_,Bus,_,_Fro,_,_,_,_),
    addcon  message(mustknow(place))
ip  dmeq(arrdep,ARRDEP),
    busorfree(Bus),
    bound(Bus),
    neverpasses(Bus,hovedterminalen) ).


istoplace rule bustrans:( % is ARRDEP TO Place
is  present B isa ARRDEP, present (do)/be1/B/A, srel/TO/place/Place/A
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 not  departure(_,  Stat,_,  _), %% in case neverpasses
    add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[TO],Day,A))
ip  dmeq(to,TO),place_station(Place,Stat),dmeq(arrdep,ARRDEP),
    newfree(Bus) ).


isfromplace rule bustrans:( % is ARRDEP FROM Place, Bus is UNKNOWN !!!
is  present B isa ARRDEP,present (do)/be1/B/A, srel/FROM/place/Place/A
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[FROM],Day,A))
ip  dmeq(arrdep,ARRDEP),dmeq(from,FROM),place_station(Place,Stat),
    newfree(Bus) ).


hasvehdep rule bustrans:(
is  has/vehicle/departure/Bus/_,adj/_/Place/Bus/A
id	 atday(Day),atdate2(DaySeqNo,_Date),
	 add (departure(Bus,Stat,DaySeqNo,Depset),
         passevent(Depset,Bus,Stat,[from],Day,A))
ip	 place_station(Place,Stat),busorfree(Bus) ).


whathasroute  rule bustrans:( %% which stations exist on route  5
is  present which(Place),
    present Place isa Plak,
    Bus isa route,
    (do)/exist/Place/A,
    srel/On/Vehicle/Bus/A
id	 atday(Day),
    not departure(Bus,_,_,_), %% passevent is removed by conn.
	 add (findstations(Bus,Day,Stl),
         passesstations(Bus,Day,Stl,A))
ip	  dmeq(place,Plak),unbound(Place),
     dmeq([in,on],On),dmeq(vehicle,Vehicle),
     exbus(Bus) ).

remallstations rule bustrans:( %% if specific station passing, remove listall stations moved up
is []
id passesstations(_,_,_,_),
   remove listofall(station,_)
ip [] ).

% END PASSES STATION SECTION %%

firstnext rule bustrans:( % Panic   first,next 4,  no departure yet
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
    corresporder(POSITION,N,POS1) ).


prevlast rule bustrans:( % Panic   previous,last 4,  no departure yet
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
    corresporder(POSITION,N,POS1) ).


home0 rule bustrans:( %% hjem til meg = til meg %% TA-100909
is  srel/to/self/_I_/_,
    clear
id	 not departure(_,_,_,_),
    not message(mustknowanother(place)),
    addcon  message(mustknow(place)),
    add flag(exit)
ip  [] ).


home1 rule bustrans:( %% manyplaces % moved before   NEXT bus home
is  srel/Home/PLACE/nil/_,
    clear
id	 not departure(_,_,_,_),
    not message(mustknowanother(place)),
    addcon  message(mustknow(place)),
    add flag(exit)
ip  dmeq([home,away],Home),dmeq([place,direction],PLACE) ).


home2 rule bustrans:( %% manyplaces % moved before   NEXT bus home
is  has/person/house/_/_,
    clear
id	 not departure(_,_,_,_),
    addcon  message(mustknow(place))
ip  [] ).


notdefault_ht_bus rule bustrans:(
is  []
id  not numberof(stations,_,_),
    not message(mustknow(place)),
    departure(Bus,PlaceVar,_DaySeqNo,_Depset1),
    clear,
    add message(mustknow(place))
ip  bound(Bus),
    \+ thetramno(Bus),
    unbound(PlaceVar),
    neverpasses(Bus,hovedterminalen) ).


defaultfromcenter rule bustrans:( %% default from hovedterminalen
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
    setopt(from,Opts,Opts1) ). %% Experiment



default_ht_tram rule bustrans:(
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
    thetramstation(STOGT),      % St. Olavs Gate
    unbound(PlaceVar),
    setopt(from,Opts,Opts1) ).

%%%% Spørsmål om trikk og flybuss og båt  %%%%%


numberonbus rule bustrans:( %   which number(?) are on the buses
is  which(BusN),(do)/be1/BusN/E,srel/on/object/Bus/E,present Bus isa bus
id	 replace passevent(A,Bus,B,_,C,D) with
    passevent(A,Bus,B,[buses],C,D)
ip	 [] ).

%%%%%%%% Tidsbegrensninger etc. %%%%%%%%%%%%%%%%%%%%%%%%%


in16time rule bustrans:(  %%  ...in Time time (i 16 tida = around 16) % Norwagism
is  srel/in/time/Time/C,srel/nil/time/T/C
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
    with    (keeparound(Time,Deps,NewDeps), %% NEW in buslog
             passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip  number(Time),unbound(T),
    setopt(time,Opts,Opts1) ).


intimetotime rule bustrans:( % ...in time Time1 to Time2
is  srel/in/time/Time1/A,srel/to/time/Time2/A,adj/_/time/Time1/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with ( keepbetween(Time1,Time2,Deps,NewDeps),
           passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip  number(Time1),number(Time2),
    setopt(time,Opts,Opts1) ).

minago rule bustrans:( %  for   30 minutter siden
is  Minutes  isa minute,srel/ago/_Time/Minutes/_C  %% _Time = minute sometimes
id	 replace passevent(Deps,Bus,Place,Opts,Day,C)
	 with    (timenow2(0,Time),
             subfromtime(Time,Minutes,TM),
             keepafter(TM,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,C))
ip  number(Minutes),
    setopt(time,Opts,Opts1) ).


beforemin rule bustrans:(  % before 30 minutter from NOW
is  Minutes  isa minute,srel/before/MINUTE/Minutes/_C,  %% before etc ?
    not (C isa clock) when { bound(C)}
id	 replace passevent(Deps,Bus,Place,Opts,Day,C)
	 with  (  timenow2(Minutes,TM),
             keepbefore(TM,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,C))
ip  number(Minutes),
    dmeq(minute,MINUTE),
    testmember(to,Opts), %% check it is the arrival event ).
    setopts([time,lastcorr],Opts,Opts1)
).

earliermin rule bustrans:(  % before 30 minutter from NOW
is  srel/nil/duration/Minute/E,
    Minutes  isa minute,
    srel/earlier/time/nil/E,
    not (C isa clock) when { bound(C)}
id	 replace passevent(Deps,Bus,Place,Opts,Day,C)
	 with  (  timenow2(Minutes,TM),
             keepbefore(TM,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,C))
ip  number(Minute),
    testmember(to,Opts), %% check it is the arrival event ).
    setopts([time,lastcorr],Opts,Opts1)
).


aftermin1 rule bustrans:(  % after 30 minutter
is  Minutes  isa minute,srel/AFTER/MINUTE/Minutes/_C  %% before etc ?
id	 replace passevent(Deps,Bus,Place,Opts,Day,C)
	 with  (timenow2(Minutes,TM),
             keepafter(TM,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,C))
ip  dmeq([after,about,withafter,during2],AFTER),
    number(Minutes),
    dmeq(minute,MINUTE),
    setopt(time,Opts,Opts0),
    setopt(nextaftertime(1),Opts0,Opts1) ).


aftermin2 rule bustrans:(  % after 30 minutter //alternative
is  Minutes  isa minute, srel/nil/duration/Minutes/E,
    not present srel/before/coevent/_/E,
    not present _ isa clock
id	 replace passevent(Deps,Bus,Place,Opts,Day,C)
	 with  (timenow2(Minutes,TM),
           keepafter(TM,Deps,NewDeps),
			  passevent(NewDeps,Bus,Place,Opts1,Day,C))
ip  number(Minutes),
    setopt(time,Opts,Opts0),
    setopt(nextaftertime(1),Opts0,Opts1) ).


aftersec rule bustrans:( % after 30 seconds
is  Seconds  isa second, srel/AFTER/_/Seconds/_C,
     {number(Seconds), Seconds =< 86400} %% 1 døgn :-) %% TA-100903
id	 replace passevent(Deps,Bus,Place,Opts,Day,C)
	 with (timenow2(Minutes,TM),
          keepafter(TM,Deps,NewDeps),
			 passevent(NewDeps,Bus,Place,Opts1,Day,C))
ip  dmeq([after,about,withafter],AFTER),
    number(Seconds),Minutes is Seconds//60,
    setopt(time,Opts,Opts1) ).


duringmin rule bustrans:(
is  Minutes  isa minute,srel/during/MINUTE/Minutes/_C  %% before etc ?
id  replace passevent(Deps,Bus,Place,Opts,Day,C)
    with    (timenow2(0,Time),
             keepwithin(Time,Minutes,Deps,NewDeps),
             passevent(NewDeps,Bus,Place,Opts1,Day,C))
ip  number(Minutes),dmeq(minute,MINUTE),
   \+ member(to,Opts), %% WITHIN is from Departure time !!!
    setopt(time,Opts,Opts1) ).


afterclockwithin rule bustrans:( %% after clock within minutes
is  Minutes  isa minute,srel/WITHIN/TM/Minutes/_C ,
        {dmeq([within,in,on,for],WITHIN)}, %% within duration
     T1400 isa clock,

    srel/after/time/T1400/_   %% not present, \+ busaftertime3

id  replace passevent(Deps,Bus,Place,Opts,Day,C)
    with    (keepwithin(T1400,Minutes,Deps,NewDeps),
             passevent(NewDeps,Bus,Place,Opts1,Day,C))
ip  number(Minutes),dmeq(minute,TM),
    setopt(time,Opts,Opts1) ).     %% neste 60 minutter = innen

%%%% TA-100912
arrwithin rule bustrans:( %% arrival  within constraints
is  present (do)/Arr/_/E, {dmeq([come,arrive,reach],Arr)},
    Minutes  isa minute,srel/WITHIN/TM/Minutes/E ,
        {dmeq([within,in,on,for],WITHIN)}, %% within duration
    not present srel/after/time/_/_
id  replace passevent(Deps,Bus,Place,[to|Opts],Day,C) %%NB to is 1. option
    with    (timenow2(0,Time),
             keepwithin(Time,Minutes,Deps,NewDeps),
             passevent(NewDeps,Bus,Place,Opts1,Day,C))
ip  number(Minutes),dmeq(minute,TM),
    setopt(time,[to|Opts],Opts1) ).



depwithin rule bustrans:( %% departure within constraints but after NOW
is  present (do)/go/_/E,
    Minutes  isa minute,srel/WITHIN/TM/Minutes/E ,
        {dmeq([within,in,on,for],WITHIN)}, %% within duration
    not present srel/after/time/_/_
id  replace passevent(Deps,Bus,Place,Opts,Day,C)
    with    (timenow2(0,Time),
             keepwithin(Time,Minutes,Deps,NewDeps),
             passevent(NewDeps,Bus,Place,Opts1,Day,C))
ip  number(Minutes),dmeq(minute,TM),
    setopt(time,Opts,Opts1) ).     %% neste 60 minutter = innen


withinwhere rule bustrans:( %% within arrival constraints, unknown place
is  Minutes  isa minute,srel/WITHIN/TM/Minutes/_C ,
    not present srel/after/time/_/_ ,
    not A isa station when {bound(A)},
    not B isa neighbourhood when {bound(B)}
id  add message(mustknow(place))
ip  number(Minutes),dmeq(minute,TM),
    dmeq([within,in,on,for],WITHIN) ).


firstanotherdayisearliest rule bustrans:(
is  adj/_/first/_/_,
    not present srel/tomorrow/day/nil/_,
    not present _ isa clock,
    not present _ isa morning
id	 atdate2(_DaySeqNo,ATDATE),
    replace passevent(Deps,Bus,Place,Opts,Day,A)
    with (keepafter(0430,Deps,NewDeps),
		    passevent(NewDeps,Bus,Place,Opts2,Day,A))
ip	 todaysdate(TODAYSDATE),
    ATDATE \== TODAYSDATE, %%
    testmember(from,Opts),
    setopt(time,Opts,Opts1),setopt(next(1),Opts1,Opts2)

 ):-double.


%%%%  first means herafter unless ...
firstishereafter rule bustrans:(
is  adj/_/first/_/_,
    not present srel/tomorrow/day/nil/_,
    not present _ isa clock,
    not present _ isa monday, % ugly
    not present _ isa tuesday,
    not present _ isa wednesday,
    not present _ isa thursday,
    not present _ isa friday,
    not present _ isa saturday,
    not present _ isa sunday,
    not present _ isa morning
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
    with		(timenow2(0,MinTime),
             keepafter(MinTime,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts2,Day,A))
ip	 setopts([time,next(1)],Opts,Opts2)
 ):-double.


lastisdepbeforemidnight rule bustrans:(  %  last means last before midnight (technically speaking)
is  adj/_/last/_/_,
    not present _ isa clock
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
    with		( keepbefore(2500,Deps,NewDeps),  %% 2500 is not paraphrased
				  passevent(NewDeps,Bus,Place,Opts2,Day,A))
ip	 testmember(from,Opts),    %% last bus is always arrival ?
    setopts([time,lastcorr,last(1)],Opts,Opts2)  %%% WHY BOTH ?
 ):-double.



lastisarrbeforemidnight rule bustrans:(  %  last means last before midnight (technically speaking)
is  adj/_/last/_/_,
    not present _ isa clock,
    not present _ isa monday, % ugly
    not present _ isa tuesday,
    not present _ isa wednesday,
    not present _ isa thursday,
    not present _ isa friday,
    not present _ isa saturday,
    not present _ isa sunday
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
    with (keepbefore(2500,Deps,NewDeps),  %% 2500 is not paraphrased
		    passevent(NewDeps,Bus,Place,Opts2,Day,A))
ip	 testmember(to,Opts),
    setopts([time,lastcorr,last(1)],Opts,Opts2)
 ):-double.



within3 rule bustrans:(  %%   bussen går () neste time
is  Minutes  isa minute,srel/nil/TM/Minutes/_C,
    present  adj/_/next/_/_
id replace passevent(Deps,Bus,Place,Opts,Day,C)
    with    (timenow2(0,Time),
             keepwithin(Time,Minutes,Deps,NewDeps),
             passevent(NewDeps,Bus,Place,Opts1,Day,C))
ip  number(Minutes),dmeq(minute,TM),
   \+ member(to,Opts), %% WITHIN is from Departure time !!!
    setopt(time,Opts,Opts1) ).     %% neste 60 minutter = innen



%%%% in next hour  from station
innexthour1 rule bustrans:(
is  H isa hour,adj/_/next/H/_,srel/IN/time/H/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	(timenow2(0,Time),
                  keepwithin(Time,60,Deps,NewDeps),
                  passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq(intime,IN),setopt(time,Opts,Opts1) ).

%%%% in next hour to station
innexthour2 rule bustrans:(
is  H isa hour,adj/_/next/H/_,srel/IN/time/H/_ %% nil here has been replaced
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	(timenow2(0,Time),
                 keepwithin(Time,60,Deps,NewDeps),
                 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq(intime,IN),
        setopt(time,Opts,Opts1) ).


%%%% in next N minutes
innextmin1 rule bustrans:(
is  B isa minute,srel/in/time/N/C,srel/nil/time/B/C,adj/_/next/N/_
id  replace passevent(Deps,Bus,Place,Opts,Day,C)
    with   (timenow2(0,Time),
            keepwithin(Time,N,Deps,NewDeps),
            passevent(NewDeps,Bus,Place,Opts1,Day,C))
ip  number(N),
    setopt(time,Opts,Opts1) ).



%%%% next N minutes
nextmin3 rule bustrans:(
is  N isa minute,srel/nil/time/N/C,adj/_/next/N/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,C)
	 with	(timenow2(0,Time),
                 keepwithin(Time,N,Deps,NewDeps),
                 passevent(NewDeps,Bus,Place,Opts1,Day,C))
ip  number(N),
    setopt(time,Opts,Opts1) ).

%%%% in next minute
nextmin4 rule bustrans:(
is  H isa minute,adj/_/next/H/_,srel/IN/time/H/A
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with  (timenow2(0,Time),
                keepwithin(Time,1,Deps,NewDeps),
                passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq(intime,IN),
    setopt(time,Opts,Opts1) ).


beatafter rule bustrans:(
is  context (do)/be1/Bus/D, srel/AT/time/Time/D ,            %%  _ ==> Bus  (Experiment)
    not srel/before/time/_/_ ,                           %% no other before - constraint
    not (do)/meetup/_/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
    with  (keepbefore(Time,Deps,NewDeps),
           passevent(NewDeps,Bus,Place,[time,lastcorr|Opts],Day,A))
ip	 dmeq(attime,AT),number(Time) ). %% in time means around



justearly rule bustrans:(
is  EA isa earliness,srel/(with)/earliness/EA/_,
    not present srel/after/time/_/_ , %% fortest mulig etter tid
    not present srel/nil/time/_/_ ,  %% nå kl 1745
    not present srel/before/time/_/_  %% "raskest"
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
    with	   passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 setopt(firstcorr,Opts,Opts1) ).


justlate rule bustrans:(
is  EA isa lateness,srel/(with)/thing/EA/_, %% TA-100914
    not present srel/after/time/_/_ , %% fortest mulig etter tid
    not present srel/nil/time/_/_ ,  %% nå kl 1745
    not present srel/before/time/_/_  %% "raskest"
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
    with	   passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 setopt(lastcorr,Opts,Opts1) ).

howlongmeanshowlate rule bustrans:(
is  EA isa duration,srel/at/time/EA/_,
    not present srel/after/time/_/_ , %% fortest mulig etter tid
    not srel/nil/time/_/_ ,
    not present srel/before/time/_/_  %% "raskest"
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
    with	   passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 setopt(lastcorr,Opts,Opts1) ).


fastap rule bustrans:(  % ... fast (as possible)
is  srel/fast/(mode)/nil/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
    with		(timenow2(0,MinTime),keepafter(MinTime,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 not member(to,Opts), %% not arrival but departure time
    setopt(time,Opts,Opts0),
    setopt(next(1),Opts0,Opts1) ). %% Not last etc


%%%%  ARRIVALS


%%%% ...after a time? Place the keepafter at the right place
%%%%  This is AD Hoc and Ugly

arrwitharr rule bustrans:(
is  Time isa Departure1, srel/(with)/Departure2/Time/_E
id  replace ( passevent(Deps,Bus,Place,Opts,Day,A))
    with (    keepbefore(Time,Deps,NewDeps),
           passevent(NewDeps,Bus,Place,[time|Opts],Day,A))
ip  number(Time),
    dmeq([arrival,stop],Departure1),
    dmeq([arrival,stop],Departure2) ).


withdep rule bustrans:(
is  Time isa Departure1, srel/(with)/Departure2/Time/_E
id       replace ( passevent(Deps,Bus,Place,Opts,Day,A))
         with (    keepafter(Time,Deps,NewDeps),
                             passevent(NewDeps,Bus,Place,[time|Opts],Day,A))
ip       number(Time),
    dmeq([departure,start],Departure1),
    dmeq([departure,start],Departure2),
    not testmember(to,Opts) ).


gofromclock rule bustrans:( %% BEFORE busbeforetime rules
is  present (do)/go/_/A,
    present srel/from/place/_/A,
    not srel/nil/time/_/_ ,
    not srel/in_order_to/_/_/_,  % heuristic
    not dob/reach/_/_/_              % heuristic
id	 replace ( passevent(Deps,Bus,Place,Opts,Day,A))
	 with (    keepafter(Time,Deps,NewDeps),
              passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 number(Time),
    setopt(time,Opts,Opts1)
).


earlierdeparture rule bustrans:( %%
is  present adj/comp/early/D/real,  present D isa departure,
    not srel/last/time/_/_ ,
    not present srel/before/time/_/_, %%  then not nextaftertime
    not present srel/to/clock/_/_     %% Norwagism
id	 not flag(earlierbus),  %% Retention
    add flag(earlierbus),
    not  keepbefore(_,_,_),            %% ( om kvelden etter 1800)
    replace ( passevent(Deps,Bus,Place,Opts,Day,A))
	 with (    keepbefore(FDT1,Deps,NewDeps),
			     passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 member(from,Opts), %% in case two passevents, select the right
    value(firstdeparturetime,FDT), %% first
    subfromtime(FDT,1,FDT1),
    setopt(time,Opts,Opts0),
    setopt(lastcorr,Opts0,Opts1)
 ):-double.


igoearlier rule bustrans:(
is  present srel/earlier/time/nil/_,
    not srel/last/time/_/_ ,
    not present srel/before/time/_/_, %%  then not nextaftertime
    not present srel/to/clock/_/_     %% Norwagism
id	 not flag(earlierbus),  %% Retention
    add flag(earlierbus),
    not  keepbefore(_,_,_),            %% ( om kvelden etter 1800)
    replace ( passevent(Deps,Bus,Place,Opts,Day,A))
	 with (    keepbefore(FDT1,Deps,NewDeps),
			     passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 member(to,Opts), %% in case two passevents, select the right
    value(lastarrivaltime,FDT),
    subfromtime(FDT,1,FDT1),
    setopt(time,Opts,Opts0),
    setopt(lastcorr,Opts0,Opts1)
 ):-double.

earlierarrival rule bustrans:( %%
is  present adj/comp/early/_A_/real,
    not srel/last/time/_/_ ,
    not present srel/before/time/_/_, %%  then not nextaftertime
    not present srel/to/clock/_/_     %% Norwagism
id	 not flag(earlierbus),  %% Retention
    add flag(earlierbus),
    not  keepbefore(_,_,_),            %% ( om kvelden etter 1800)
    replace ( passevent(Deps,Bus,Place,Opts,Day,A))
	 with (    keepbefore(FDT1,Deps,NewDeps),
			     passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 member(to,Opts), %% in case two passevents, select the right
    value(lastarrivaltime,FDT),
    subfromtime(FDT,1,FDT1),
    setopt(time,Opts,Opts0),
    setopt(lastcorr,Opts0,Opts1)
 ):-double.


laterarrival rule bustrans:(
is  present adj/comp/late/D/real, present D isa arrival,  %% LATER
    not srel/last/time/_/_ ,
    not present srel/before/time/_/_, %%  then not nextaftertime
    not present srel/to/clock/_/_     %% Norwagism
id	 not flag(laterbus),  %% Retention
    add flag(laterbus),
    not  keepafter(_,_,_),            %% ( om kvelden etter 1800)
    replace ( passevent(Deps,Bus,Place,Opts,Day,A))
	 with (    keepafter(FDT1,Deps,NewDeps),
			     passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 \+ member(from,Opts), %% in case two passevents, select the right
    value(lastarrivaltime,FDT),
    addtotime(FDT,1,FDT1),
    setopt(time,Opts,Opts0),
    setopt(nextaftertime(1),Opts0,Opts1)
 ):-double.


laterdeparture rule bustrans:(
is  present adj/comp/late/_A_/real,
    not srel/last/time/_/_ ,
    not present srel/before/time/_/_, %%  then not nextaftertime
    not present srel/to/clock/_/_     %% Norwagism
id	 not flag(laterbus),  %% Retention
    add flag(laterbus),
    not  keepafter(_,_,_),            %% ( om kvelden etter 1800)
    replace ( passevent(Deps,Bus,Place,Opts,Day,A))
	 with (    keepafter(FDT1,Deps,NewDeps),
			     passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 \+ member(to,Opts), %% in case two passevents, select the right
    value(firstdeparturetime,FDT),
    addtotime(FDT,1,FDT1),
    setopt(time,Opts,Opts0),
    setopt(nextaftertime(1),Opts0,Opts1)
 ):-double.


igobefore rule bustrans:( %%  Which bus go before -that-
is  present srel/beforethat/time/nil/_,
    not srel/first/time/_/_ ,
    not present srel/after/time/_/_,  %% then not nextaftertime
    not srel/last/time/_/_ ,
    not present srel/before/time/_/_, %%  then not nextaftertime
    not present srel/to/clock/_/_     %% Norwagism
id	 not flag(earlierbus),  %% Retention
    add flag(earlierbus),
    not  keebefore(_,_,_),
    replace ( passevent(Deps,Bus,Place,Opts,Day,A))
	 with (    keepbefore(FDT1,Deps,NewDeps),
			     passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 \+ member(from,Opts), %% in case two passevents, select the right
    value(lastarrivaltime,FDT),
    subfromtime(FDT,1,FDT1),
    setopts([time,lastcorr],Opts,Opts1)
 ):-double.




igolater rule bustrans:(
is  present srel/thereafter/time/nil/_,
    not srel/last/time/_/_ ,
    not present srel/before/time/_/_, %%  then not nextaftertime
    not present srel/to/clock/_/_     %% Norwagism
id	 not flag(laterbus),  %% Retention
    add flag(laterbus),
    not  keepafter(_,_,_),            %% ( om kvelden etter 1800)
    replace ( passevent(Deps,Bus,Place,Opts,Day,A))
	 with (    keepafter(FDT1,Deps,NewDeps),
			     passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 \+ member(to,Opts), %% in case two passevents, select the right
    value(firstdeparturetime,FDT),
    addtotime(FDT,1,FDT1),
    setopt(time,Opts,Opts0),
    setopt(nextaftertime(1),Opts0,Opts1)
 ):-double.



nowresetotady  rule bustrans:(       %% If explicit NOW, reset today if necessary
is  srel/now/time/nil/_
id	 not atday(_),
    today(Tuesday),
    add atday(Tuesday)
ip  frame_getvalue(day,Friday,day),
    Tuesday \== Friday
 ):- double.


nowwhat rule bustrans:(
is  srel/now/time/nil/_,
    not present srel/after/time/1650/_  %% TA-110411

id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with (timenow2(0,Time),
               keepafter(Time,Deps,NewDeps),
               passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip  \+ member(to,Opts), %% NOW never about destination
    setopts([time,firstcorr],Opts,Opts1) ).



%%%% PLACES




keepfrombaywithbus rule bustrans:( %% go from center
is  not present srel/from/place/X/_  when { bound(X)},
    not present srel/nil/place/X/_  when { bound(X)},
    present BB isa Bus, %% 5 to ila = route 5
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
  )
                   :- single.



keepfrombay rule bustrans:( %% go from center
is   {\+ value(new_origin,true)}, %% NO GPS %% TA-110218
    not present srel/here/place/nil/_, %% fra her .. ???
    not present srel/inwards/place/nil/_,
    not present srel/from/___place/X/_  %% in case of error srel/from/text/c/free(32)
           when { (bound(X), \+ home_town(X))}, %% TA-101111
    not present srel/on/place/_/_ ,      %%  hvis jeg er på Samfundet
    not _IDI isa Dep when {dmeq([department],Dep)} %% ad hoc might be placoid
id  not flag(exit),              %% prefer (spurious) warning

    not flag(keepfrombay),   %%  Loop Stop
    not passevent(_,_,_,[from|_],_,_),
     not message(neverpasses(_,_)), %% subtle  11 til Brukseier Olsens vei?
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
  ):- single.


keeptobay rule bustrans:( %% = go to  center ?
is  not present srel/outwards/place/nil/_,
    not present srel/nil/place/NTH/_ when { bound(NTH)},
    not present srel/near/place/NTH/_ when { bound(NTH)}, %% n(ærm)este buss ******
    not present srel/in/place/NTH/_ when { bound(NTH)},
    not present srel/at/place/NTH/_ when { bound(NTH)},
    not present srel/to/_Place/NTH/_ when { bound(NTH)}, %% Lingit: agent %% TA-110401
    not present srel/towards/place/NTH/_ when { bound(NTH)}, %%  shakey
    not present srel/to/meeting/_/_ ,
    not present srel/on/place/_/_ ,
    not present srel/past/place/_/_,
    not present srel/from/place/sentrum/_ %% sentrum generic %% (anomalous q)
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
     %% som NIGHTbuses (do)/ some dont !

    newfree(E),
    newfree(FreeBus)
) :- single.


% TIMES

busaroundtimearrdep rule bustrans:(  % fra A ca kl T til D -> Avgang (?)
is  srel/around/CLO/Time/_ , {   number(Time)},
    not Time isa minute,
    not srel/in_order_to/thing/_/_,
    not srel/because_of/_Thing/_/_,
    present srel/from/place/_/_  %% present form thn around = around DEP
id	 replace    passevent(Deps,Bus,Place,Opts,Day,A)
    with     ( keeparound(Time,Deps,NewDeps),
               passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq(timeclock,CLO),
    member(from,Opts),   %
    setopt(time,Opts,Opts1) ). %% NOT lastcorr


busaroundtimedep rule bustrans:(  % around time departure %% 1
is  srel/AROUND/CLO/Time/_ ,                   %% buss 36 rundt 730
    not Time isa minute
id	 replace    passevent(Deps,Bus,Place,Opts,Day,A)
    with     ( keeparound(Time,Deps,NewDeps),
               passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq(timeclock,CLO),
    dmeq(around,AROUND), %% inclusive in
    member(from,Opts),  %
    number(Time),
    setopt(time,Opts,Opts1) ). %% NOT lastcorr


busaroundtimearr rule bustrans:(  %  around time arrival  %% 2
is  srel/AROUND/CLO/Time/_ ,
    not Time isa minute
id	 replace    passevent(Deps,Bus,Place,Opts,Day,A)
    with     ( keeparound(Time,Deps,NewDeps),
               passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq(timeclock,CLO),
    dmeq(around,AROUND), %% inclusive in
    member(to,Opts),  %
    number(Time),
    setopt(time,Opts,Opts1) ). %% NOT lastcorr



busaroundtime2 rule bustrans:( % bus around a time
is  srel/nil/time/Time/E, present (do)/go/Bus/E,
    not srel/in_order_to/_/_/_,
    not dob/reach/_/_/_
id  not flag(defaultdest), %% not given explicitly
    replace      passevent(Deps,Bus,Place,Opts,Day,E1)
    with      (  keeparound(Time,Deps,NewDeps),
                 passevent(NewDeps,Bus,Place,Opts1,Day,E1))
ip  member(from,Opts),  %% subtle,   default from ht
    setopt(time,Opts,Opts1)
 ):-single.



busbeforetime0 rule bustrans:(   % bus before a time? %%%  unstrict time limit (morningbus),
is  srel/BEFORE/CLO/Time/_ ,
    not srel/thereafter/time/nil/_ ,
    not present adj/_/next/_/_, %% next HHMM means next after
    present _ isa morningbus, %% not strict timelimit
    not Time isa minute
id	 replace    passevent(Deps,Bus,Place,Opts,Day,A)
    with    (  keepbefore(Time,Deps,NewDeps),      %% NB
               passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip dmeq(within,BEFORE),dmeq(timeclock,CLO),
   number(Time),
    \+ member(from,Opts),
   setopt(time,Opts,Opts1) ).


busbeforetime1 rule bustrans:( %%  before time, but not last  arrival
is  present  Time isa clock,
    srel/BEFORE/CLO/Time/_A
id	 keepafter(_ATime,_,_),
    not present adj/_/next/_/_, %% next HHMM means next after
    replace passevent(Deps,Bus,Place,Opts,Day,A)
    with  ( keepbefore(Time,Deps,NewDeps), %% NOT CLOSELY BEFORE !!!
		      passevent(NewDeps,Bus,Place,TOPT,Day,A))
ip	 dmeq(within,BEFORE),
    dmeq(timeclock,CLO), %% not duration
    \+ testmember(from,Opts), %% before -> arrivalplace
    number(Time),
    setopt(time,Opts,TOPT) ).


busarrjustbeforetime rule bustrans:( %% last arrival before time
is  present  Time isa clock, { number(Time)},
    srel/AT/CLO/Time/_E, {dmeq(battime,AT),dmeq(timeclock,CLO)},

    not present (do)/meetup/'I'/_, %% could be to the station
    not srel/thereafter/time/nil/_ ,
    not srel/after/time/F/_  when {bound(F)}   %% then not lastcorr
id	 not flag(defaultdest), %% not given explicitly
    not keepafter(_,_,_),
    not keepbefore(_,_,_),  %% til risvollan kl 1500 før kl 1700.
    not keepbefore1(_,_,_),
    replace passevent(Deps,Bus,Place,Opts,Day,A)
    with (  keepbefore1(Time,Deps,NewDeps),  %% CLOSELY BEFORE !!!
            passevent(NewDeps,Bus,Place,TLCOPT,Day,A))
ip	  \+ member(from,Opts),
    setopt(time,Opts,Opts1),
    setopt(lastcorr,Opts1,TLCOPT) ).


busbeforetime3 rule bustrans:(  %% shouldn't apply to morningbus
is  srel/BEFORE/CLO/Time/_E ,
    not present _ isa departure,
    not (do)/meetup/'I'/_,
    not srel/after/time/_/_ ,  %% then not lastcorr
    not present adj/_/next/_/_, %% next HHMM means next after
    not srel/thereafter/time/nil/_ ,
    not present _ isa morningbus, %% not strict timelimit
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
 member(to,Opts),  %% Too strong ! %%% *** Bussen går forbi NTH før 0815
   setopt(time,Opts,Opts1),
   setopt(lastcorr,Opts1,TLCOPT) ).


busbeforetime4 rule bustrans:( %% Allow bus from place before time
is  srel/BEFORE/CLO/Time/E,
    not present _ isa departure,
    not srel/after/time/_/_ ,  %% then not lastcorr
    not present srel/from/place/_/E ,%%
    not present adj/_/next/_/_, %% next HHMM means next after
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
   setopt(lastcorr,Opts1,TLCOPT) ).


presentniltime1 rule bustrans:( %% buss 52 er fremme kl 19 %% TA-110531
is  srel/nil/CLO/Time/E,
    present adj/nil/(present)/_52/_,
    not present _ isa departure,
    not srel/after/time/_/_ ,  %% then not lastcorr
    not present srel/from/place/_/E ,%%
    not present adj/_/next/_/_, %% next HHMM means next after
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
   setopt(lastcorr,Opts1,TLCOPT) ).



presentniltime2 rule bustrans:( %% buss 52 fremme kl 19 %% TA-110531 UGLY
is  srel/nil/CLO/Time/E,
    present srel/there/place/nil/_, %% fremme
    not present _ isa departure,
    not srel/after/time/_/_ ,  %% then not lastcorr
    not present srel/from/place/_/E ,%%
    not present adj/_/next/_/_, %% next HHMM means next after
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
   setopt(lastcorr,Opts1,TLCOPT) ).


presentniltime3 rule bustrans:( %% buss 52 frem kl 19 %% TA-110531 UGLY
is  srel/nil/CLO/Time/E,
    present srel/redundantly/thing/nil/_, %% fram
    not present _ isa departure,
    not srel/after/time/_/_ ,  %% then not lastcorr
    not present srel/from/place/_/E ,%%
    not present adj/_/next/_/_, %% next HHMM means next after
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
   setopt(lastcorr,Opts1,TLCOPT) ).


betweentimes rule bustrans:( %% (depart) after time1 before time2
is  srel/after/time/Time1/E,srel/before/time/Time2/E,
    not present _ isa departure,
    not _Time isa minute
id replace   passevent(Deps,Bus,Place,Opts,Day,A)
    with   (  keepafter(Time1,Deps,NewDeps1),
              keepbefore(Time2,NewDeps1,NewDeps),
              passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip number(Time1),number(Time2),
   testmember(from,Opts),
   setopts([time],Opts,Opts1) ).



beforeatime rule bustrans:( %% Finally,  bus before time vanilla
is  srel/before/time/Time/_E,
    not present _ isa departure,
    not Time isa minute
id replace   passevent(Deps,Bus,Place,Opts,Day,A)
    with   ( keepbefore(Time,Deps,NewDeps),
             passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip number(Time),
   testmember(to,Opts), %% <----
   setopts([time,lastcorr],Opts,Opts1) ).

prenoonarr1 rule bustrans:( %%   < 1200 %%  arrival
is  A isa prenoon,
    srel/AT/Time/A/_, {dmeq([in,nil,on,during2],AT)},
    not present _ isa clock, %% if so, only for lateflag
        { dmeq([time,afternoon,daypart],Time)}
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with    (keepbefore(1200,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip	 testmember(to,Opts), %% before 1200 = to
    setopts([lastcorr,time],Opts,Opts1) ). %% avoid 0610 #-> 1145


afternoon1 rule bustrans:( % an afternoon  (>=1200)
is  has/day/afternoon/_/A,srel/AT/time/A/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with    (keepafter(1200,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip	 dmeq(at,AT),setopt(time,Opts,Opts1) ).


thisafternoon1 rule bustrans:( % This afternoon  (>=1200) < (=< 1800)
is  A isa afternoon,srel/AT/Time/A/_,
    not present _ isa clock, %% if so, only for lateflag
       {dmeq([time,afternoon,daypart],Time)}
id	 today(Tday), atday(Tday), %% same day
    replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with    (keepafter(Deptime,Deps,NewDeps),
             keepbefore(1800,NewDeps,NewDeps1),
				 passevent(NewDeps1,Bus,Place,Opts1,Day,B))
ip	 dmeq(at,AT),setopt(time,Opts,Opts1),
    timenow2(0,NOW),
    Deptime is max(NOW,1200),
    Deptime < 1800 ).


defaultafternoon rule bustrans:( % This afternoon  (>=1200) < (=< 1800)
is  A isa afternoon,srel/AT/Time/A/_,
    not present _ isa clock, %% if so, only for lateflag
       {dmeq([time,afternoon,daypart],Time)}
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with    (keepafter(Deptime,Deps,NewDeps),
             keepbefore(1800,NewDeps,NewDeps1),
				 passevent(NewDeps1,Bus,Place,Opts1,Day,B))
ip	 dmeq(at,AT),setopt(time,Opts,Opts1),
    Deptime is 1200 ).


afternoon2 rule bustrans:( % afternoon  (>=1200)
is  srel/afternoon/time/nil/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with    (keepafter(1200,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip	 setopt(time,Opts,Opts1) ).


morning1 rule bustrans:( % a morning  (=<1100)
is  has/day/morning/_/A,srel/AT/Time/A/_,
    not present (CC isa clock) when {bound(CC)}
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with (keepafter(0430,Deps,NewDeps),
          keepbefore(1200,NewDeps,NewDeps1),
          passevent(NewDeps1,Bus,Place,Opts1,Day,B))
ip	 dmeq(at,AT),
    dmeq([time,daypart,morning],Time), %%  på lørdag formidag
    setopt(time,Opts,Opts0),
    setopt(firstcorr,Opts0,Opts1) ).


morning2from rule bustrans:( % This morning  (=<1200) , BEFORE = arrival
is  A isa morning,
    srel/AT/_Time_/A/_ , {dmeq([at,before,in,nil,on,during],AT)},
    not present _ isa clock  %% then morning is dummy
id	 not  present keepbefore1(_,_,_),
	 not  present keepbefore(_,_,_),
    replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with (keepafter(0430,Deps,Deps1),
          keepbefore(1200,Deps1,NewDeps),
          passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip	 testmember(to,Opts), %%
    setopt(time,Opts,Opts1) ).

%%%%     setopt(firstcorr,Opts0,Opts1). %% "siste buss .. < 12?



morning3 rule bustrans:( % morning  (=<1200)
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
    setopt(firstcorr,Opts0,Opts1) ).

midtpådagen  rule bustrans:( % midt på dagen
eveningbeforenoon rule bustrans:( %% contradictory evening before noon
is  srel/EVENING/time/nil/_ % see and ignore
id  keepbefore1(F,_,_)      % before?  This is just an experiment
ip  dmeq(evening,EVENING),
    number(F), F < 1800 ) ).    %% Contradictory


thisafternoon rule bustrans:( % i ettermiddag %% > 1200
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
    timenow2(0,Thirteen),  Maxtime is max(1200,Thirteen) ).


evening rule bustrans:( % evening  ( > 1800)  , but if Time > 1800 then after Time !
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
    timenow2(0,Nineteen),  Maxtime is max(1800,Nineteen) ).


dayevening rule bustrans:( % evening  ( > 1800)
is  srel/nil/daypart/N/_, N isa night,
    not present adj/_/last/_/_
id	 not flag(nightbusflag),
    not keepbefore1(_,_,_),
    not keepafter(_,_,_),
    not keeparound(_,_,_),
    replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with		(keepafter(1800,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip	 setopt(time,Opts,Opts1) ).


eveningnightbus rule bustrans:( % Friday evening means friday midningt night
is  srel/nil/daypart/N/_,
    replaceall (N isa night)
    with       (N isa midnight)
id	 flag(nightbusflag),
    not keepbefore1(_,_,_),
    not keepafter(_,_,_),
    not keeparound(_,_,_)
ip	 [] ).


nightlybus rule bustrans:( % night bus ( > 2400)
is  present A isa bus,adj/_/night/A/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with		(keepafter(2400,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip	 setopt(time,Opts,Opts1) ).


mornbus rule bustrans:( % morning bus
is  present A isa bus,adj/_/morning/A/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with	(keepafter(0430,Deps,NewDeps),
		 passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip	 setopt(time,Opts,Opts1) ).


evebus rule bustrans:( % an evening  (>=1800  and =<2400)
is  has/day/evening/_/A,srel/AT/time/A/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with 	(keepafter(1800,Deps,NewDeps),                %% Changed generally
				 passevent(NewDeps,Bus,Place,[time|Opts],Day,B))
ip	 dmeq(at,AT) ).


thiseve rule bustrans:( % This evening  (>=1800)
is  A isa evening,srel/AT/TIMEEQ/A/_
id	 not keepbefore(_,_,_),                         %% tonight at 1800
    not keeparound(_,_,_),                         %%
    replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with		(keepafter(1800,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip	 testmember(from,Opts),
    setopt(time,Opts,Opts1),
    dmeq(at,AT),dmeq(timeclass,TIMEEQ) ).


nileve rule bustrans:( % evening  (>=1800 and =<2400)
is  srel/evening/time/nil/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with 	(keepafter(1800,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,[time|Opts],Day,B))
ip	 [] ).


%%%% AFTERNOON

daysaftnoon rule bustrans:( % an afternoon  12-18
is  has/day/afternoon/_/A,srel/AT/time/A/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with 	(keepbetween(1200,1800,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,[time|Opts],Day,B))
ip	 dmeq(at,AT) ).


thisaft1218 rule bustrans:( % This afternoon  12-18
is  A isa afternoon,srel/AT/time/A/_ ,
    not present _ isa clock %% if so, only for lateflag
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with		(keepbetween(1200,1800,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,[time|Opts],Day,B))
ip	 dmeq(at,AT) ).


aft1218 rule bustrans:( % afternoon  12-18
is  srel/afternoon/time/nil/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with 	(keepbetween(1200,1800,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,[time|Opts],Day,B))
ip	 [] ).


udayeve rule bustrans:( % Uday evening
is  srel/evening/day/nil/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with 	(keepafter(1800,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,[time|Opts],Day,B))
ip	 [] ).


udayaft rule bustrans:( % Uday afternoon
is  srel/afternoon/day/nil/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with 	(keepbetween(1200,1800,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,[time|Opts],Day,B))
ip	 [] ).


%%%% Night section

anight18 rule bustrans:( % a night  (>=1800)
is  has/day/night/_/A,srel/AT/time/A/_
id	 not keepafter(_,_,Deps),
	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with		(keepafter(1800,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip	 dmeq(at,AT),
    setopt(time,Opts,Opts1) ).



thisnightis18ormore rule bustrans:( % This night  (>=1800)
is  A isa night,
    srel/AT/time/A/_,
       {dmeq([after,at,in,nil,on],AT)}, %% \+ før kvelden
    not present _ isa clock   %% then evening is just for lateflag
id	 not flag(nightbusflag),
    today(Wday),atday(Wday), %% same day
    not keepafter(_,_,Deps),
	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with		(keepafter(DepTime,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip  timenow2(0,NOW),DepTime is max(1800,NOW),
     testmember(from,Opts),
    setopts([time],Opts,Opts1) ).



nightis18 rule bustrans:( % This night  (>=1800)
is  A isa night,srel/AT/time/A/_,
    not present _ isa clock   %% then evening is just for lateflag
id	 not flag(nightbusflag),
    not keepafter(_,_,Deps),
	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with		(keepafter(DepTime,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip  dmeq([at,in,nil,on],AT), %% før kvelden
    DepTime is 1800,
    setopts([time],Opts,Opts1) ). %% lastcorr neglected by NON sms


routeforeve rule bustrans:(  % Busroute for the evening
is  A isa night,srel/for/daypart/A/_
id	 not flag(nightbusflag),
    not keepafter(_,_,Deps),
	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with		(keepafter(1800,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip  setopt(time,Opts,Opts1) ).


night18 rule bustrans:( % night  (>=1800)
is  srel/night/time/nil/_
id	 not flag(nightbusflag),
    not keepafter(_,_,Deps),
	 replace passevent(Deps,Bus,Place,Opts,Day,B)
	 with    (keepafter(1800,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,B))
ip	  setopt(time,Opts,Opts1) ).


%%%% End night section


%%%% AT A TIME means before, around or after a time, depending
%%%% ---------------------------------------------------------


batbefore1 rule bustrans:( % be1 at a time (means the bus must be there before that time)
is  present (do)/be1/Self/D, present Self isa self, srel/AT/time/_/D
id	 replace passevent(Deps,Bus,Place,Opts,Day,D)
	 with 		 (keeparound(Time,Deps,NewDeps),
					  passevent(NewDeps,Bus,Place,[time,lastcorr|Opts],Day,D))
ip	 dmeq(at,AT),number(Time) ).


beatbefore2 rule bustrans:( % be1 at a time (means the bus must be there before that time) % ?
is  present (do)/be1/Self/D, present Self isa self,
    srel/AT/time/C/D, srel/nil/time/Time/B,srel/before/time/C/B
id	 replace passevent(Deps,Bus,Place,Opts,Day,D)
	 with   (keepbefore1(Time,Deps,NewDeps), %% Closely before
			   passevent(NewDeps,Bus,Place,[time,lastcorr|Opts],Day,D))
ip	 dmeq(at,AT),number(Time) ).


atatime1 rule bustrans:( % ...at a time?
is  srel/AT/time/Time/_  % precisely ???
id	 replace passevent(Deps,Bus,Place,[],Day,A)     %% Opts -> []
	 with	  ( keeparound(Time,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,[time],Day,A)) % time|Opts -> time
ip	 dmeq(at,AT),number(Time) ).

%%%% ----------------------------------------------------------------------------

%%%% ...from Time1 to Time2?
fromtimetotime rule bustrans:(
is  srel/from/time/Time1/_,srel/to/time/Time2/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with		(inttime(Time1,MinTime1),inttime(Time2,MinTime2),
				 keepbetween(MinTime1,MinTime2,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 number(Time1),number(Time2),setopt(time,Opts,Opts1) ).

%%%% ...around a time? (+/- 15 min)
%%%% (skulle vært implementert mer komplisert, men...)
aroundatime rule bustrans:(
is  srel/around/time/Time/A %% Same event A !
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with		( % inttime(Time,MinTime),

             keeparound(Time,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 number(Time),setopt(time,Opts,Opts1) ).


keepbus2 rule bustrans:( % buss 9 er i sentrum
is  present Bus isa BR,srel/in/time/_/E, present (do)/be1/Bus/E
id	 not passevent(_,Bus,_,_,_,_),
    replace passevent(Deps,_,Place,Opts,Day,A)
	 with    (keepbus(Bus,Deps,NewDeps), %% !,
             passevent(NewDeps,Bus,Station,Opts,Day,A))
ip	 dmeq([bus,nightbus,route],BR),
    exbus(Bus),place_station(Place,Station) ).


keepbus3 rule bustrans:( % with Bus 8  % This is a reserve rule,  too late for bus dependence -> 2415
is  present Bus isa BR,srel/W/V/Bus/_
id	 not passevent(_,Bus,_,_,_,_),
    replace passevent(Deps,_,Place,Opts,Day,A)
	 with   (keepbus(Bus,Deps,NewDeps), %% !,
            passevent(NewDeps,Bus,Station,Opts,Day,A))
ip	 testmember(from,Opts), %% only the departure bus is important
    dmeq([bus,nightbus,route,tram],BR),
    dmeq([for,with,on,by,via,from],W),  %%  for %%  (missp før 19)?
    dmeq([vehicle,route,bus],V),
    bound(Bus), %% bus or tram exbus(Bus),
    place_station(Place,Station) ).


keepbus4 rule bustrans:( % with line 8
is  has/_/departure/Bus/_, present Bus isa BR %% nb swap
id	 not passevent(_,Bus,_,_,_,_),
    replace passevent(Deps,_,Place,Opts,Day,A)
	 with  (keepbus(Bus,Deps,NewDeps), %% !,
           passevent(NewDeps,Bus,Station,Opts,Day,A))
ip	 dmeq([bus,nightbus,route],BR),
    exbus(Bus),place_station(Place,Station) ).


keepbus5 rule bustrans:( % bus that has number 8
is  has/vehicle/number/F/H, present
    F isa BR, H isa number
id	 replace passevent(Deps,_,Place,Opts,Day,A)
	 with  (keepbus(H,Deps,NewDeps), %% !,
           passevent(NewDeps,F,Station,Opts,Day,A))
ip	 dmeq([bus,nightbus,route],BR),
    exbus(H),
    place_station(Place,Station) ).


avoidbus rule bustrans:(  % avoid  Bus 8
is  dob/avoid/'I'/B9/_, present B9 isa BR ,
     {dmeq([bus,nightbus,route,tram],BR)}
id	 replace passevent(Deps,X,Place,Opts,Day,E)
	 with    (avoidbus(B9,Deps,NewDeps),
				 passevent(NewDeps,X,Station,Opts,Day,E))
ip	 bound(B9),bus(B9), %% exbus  exclusive bus/ bus inclusive tram
    place_station(Place,Station) ).

exceptbus1 rule bustrans:(  % except  Bus 8
is  srel/except/_/B8/_,present Bus isa BR, {bound(B8)}
id	 replace passevent(Deps,X,Place,Opts,Day,A)
	 with    (avoidbus(B8,Deps,NewDeps),
				 passevent(NewDeps,X,Station,Opts,Day,A))
ip	 dmeq([bus,nightbus,route,tram],BR),
    bound(Bus),
    bus(Bus), %% exbus  exclusive bus/ bus inclusive tram
    place_station(Place,Station) ).

exceptbus2 rule bustrans:(  % except  Bus 8
is  present Bus isa BR, comp/_/ne/_/Bus
id	 replace passevent(Deps,X,Place,Opts,Day,A)
	 with    (avoidbus(Bus,Deps,NewDeps),
				 passevent(NewDeps,X,Station,Opts,Day,A))
ip	 dmeq([bus,nightbus,route,tram],BR),
    bound(Bus),
    bus(Bus), %% exbus  exclusive bus/ bus inclusive tram
    place_station(Place,Station) ).


goexceptbus rule bustrans:( % go except  Bus 8
is  present Bus isa BR, srel/Except/vehicle/Bus/_,
     {dmeq([except,without],Except)}
id	 replace passevent(Deps,X,Place,Opts,Day,A)
	 with    (avoidbus(Bus,Deps,NewDeps),
				 passevent(NewDeps,X,Station,Opts,Day,A))
ip	 dmeq([bus,nightbus,route,tram],BR),
    bound(Bus),
    bus(Bus), %% exbus  exclusive bus/ bus inclusive tram
    place_station(Place,Station) ).



%%% first/last/next/Nth bus


firstNbus rule bustrans:(  % first  N departures
is  quant(eq/N,B), adj/_/first/B/_ , present B isa Veh
id	 replace passevent(Deps,Bus,Place,Opts, Day,A)
	 with    passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 dmeq(vehicle,Veh),
    setopt(first(N),Opts,Opts1) ).


firstNdep rule bustrans:( % first  N departures
is  quant(eq/N,AD), adj/_/first/AD/_ , AD isa ARRDEP
id	 replace passevent(Deps,Bus,Place,Opts, Day,A)
	 with    passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 dmeq(arrdep,ARRDEP),
    setopt(first(N),Opts,Opts1) ).


firstarr rule bustrans:( %  first ARRDEP
is  adj/_/first/AD/_, present AD isa ARRDEP
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with		passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 dmeq(arrdep,ARRDEP),
    \+ member(nextaftertime(_),Opts),
    setopt(first(1),Opts,Opts1) ).            %%


firsttime rule bustrans:( % first time
is  adj/_/first/Time/_,present Time isa Timeq
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with		passevent(Deps,Bus,Place,[first(1)|Opts],Day,A)
ip	 dmeq(time,Timeq) ).


% NEXT N BUS Section %%%%%%%%%%%%%%%%

nextnbusaftertime rule bustrans:( %%  % next N buses after time see also nextnaftertime
is  quant(eq/N,BD), {(bound(N), N >= 0)},
    adj/_/Next/BD/_ ,
    srel/after/TiCo/Time/_A ,present BD isa BDA,
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
    setopt(nextaftertime(N),Opts0,Opts1) ). %% not next after now


nextnaftertime rule bustrans:( % next N buses after time
is  quant(eq/N,BD), adj/_/Next/BD/_ ,present BD isa BDA
id	 keepafter(_,_,Deps0),        %%% <-------
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with    passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 ( Deps == Deps0),
    dmeq([next,first],Next),  %%  First after = Next after  !
    dmeq(busdeparr,BDA),
    setopt(nextaftertime(N),Opts,Opts1) ). %% not next after now

nbusesaftertime rule bustrans:( %%  N buses after time
is  quant(eq/N,BD), { bound(N), N >= 0},
    srel/after/TiCo/Time/_A ,present BD isa BDA,
    not srel/last/time/_/_
id	 not  keepafter(_,_,_),
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with  ( passevent(NewDeps,Bus,Place,Opts1,Day,A),
            keepafter(Time,Deps,NewDeps))
ip	 dmeq(timeclock,TiCo),
    dmeq(busdeparr,BDA),
    number(Time),
    setopt(time,Opts,Opts0),
    setopt(nextaftertime(N),Opts0,Opts1) ). %% not next after now


nextnbusesanotherday rule bustrans:( %%% Next bus another day   = first on that day IF different Actual day
is  quant(eq/N,BusF),adj/_/next/BusF/_ ,
    not present _ isa clock,
    present BusF isa VEH
id	 atday(Wed),
    not today(Wed),
    not message(date_day_route(_,Wed)), %%  not only different routeplan
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with    passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 \+ value(samedayflag,true), %% Ad Hoc: Global flag
    dmeq(vehicle,VEH),
    busorfree(BusF),
    setopt(first(N),Opts,Opts1) ).

nextnbuses rule bustrans:( % next N buses  %% next(N) is AMBIGUOUS  after now/ after time..
is  quant(eq/N,BD), present BD isa BDA, present adj/_/next/BD/_
id	 not keepafter(_,_,Deps), % "etter T" overstyrer "neste"
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	(timenow2(0,Time),keepafter(Time,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 number(N),N > 0,  %% leave max number to busanshp.pl %%
    dmeq(busdeparrN,BDA), %% N for night
    setopt(next(N),Opts,Opts1) ).

%%%% see also yesterdayevening
nextbusyesterday rule bustrans:( % Next bus after 2400, yesterdays routes
is  BusF isa Ag , {bound(BusF),exbus(BusF)},  %% I ...  routes for bus => fire twice
    {dmeq([agent,self,bus,route,vehicle,tram,train],Ag)}
id	 message(assumeyesterdepartures), %%
    atday(Wed),
    not today(Wed),
    not message(date_day_route(_,Wed)),
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with    (keepafter(T2400,Deps,Deps1), %% avoid morning routes!
             passevent(Deps1,Bus,Place,Opts1,Day,A))
ip	 \+ value(samedayflag,true),
     timenow(LT),LT < 0100, T2400 is LT+2400, %%
     setopt(next(1),Opts,Opts1) ).



nextbusanotherday rule bustrans:( % Next bus another day %% = first on that day IF different Actual day
is  adj/_/next/BusF/_ ,  {busorfree(BusF)},
    present BusF isa VEH
id	 atday(Wed),
    not today(Wed),
    not message(date_day_route(_,Wed)), %%  not only different routeplan
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with    passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 \+ value(samedayflag,true), %% Ad Hoc Global flag
    dmeq(vehicle,VEH),
    setopt(first(1),Opts,Opts1),busorfree(BusF) ).


%%%% moved after  NEXT N BUSES AFTER
busbeforetimedouble rule bustrans:( %%   bus before a time before time  early in the morning  (late at night ?)
is  srel/BEFORE/CLO/Time/_
id	 keepbefore(Time1,Deps,NewDeps),
    replace keepbefore(Time1,Deps,NewDeps)
		with 	    keepbefore(Time,Deps,NewDeps)
ip	 dmeq(within,BEFORE),dmeq(timeclock,CLO),
     number(Time),number(Time1),Time < Time1 ).


busdepattime0 rule bustrans:(  % bus goes time?
is  srel/AT/CLO/Time/E, present (do)/go/Bus/E, present srel/from/place/Place/E,
    not srel/in_order_to/_/_/_,  % heuristic
    not dob/reach/_/_/_              % heuristic
id  replace passevent(Deps,Bus,Place,Opts,Day,E)
    with   ( keepafter(Time,Deps,NewDeps),
             passevent(NewDeps,Bus,Place,Opts1,Day,E))
ip  dmeq([at],AT),dmeq(timeclock,CLO),number(Time), %% bussen går 20 // attime  %% minutter før midnatt
    setopt(time,Opts,Opts1) ).


busdepaftertimegps rule bustrans:( %% missing fromplace %% TA-110406
is  {value(gpsflag,true)},

    srel/AFTER/CLO/Time/E,
            {dmeq(after,AFTER),
             dmeq(timeclock,CLO)},
    not present _ isa arrival,

    not  present srel/from/place/_Place/E,  % solsiden %% what if GPS ??

    present Time isa clock,
    not present srel/around/time/_/_, %% confuse
    not present srel/before/time/_/_, %% // not nextbusafter
    present (do)/Go/Bus/E, {Bus \== 'I'},  %% ad hoc
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
    setopts([time,nextaftertime(0)],Opts,Opts1) ).  %% allow several


busdepafter1time rule bustrans:( %% bus strictly after time // Technical after1
is  srel/after1/CLO/Time/E,  {dmeq(timeclock,CLO)},
    present Time isa clock,
    not present srel/around/time/_/_, %% confuse
    not present srel/before/time/_/_, %% // not nextbusafter
    present (do)/Go/Bus/E, {Bus \== 'I'},  %% ad hoc
        {dmeq([go,be,be1],Go)},
   present srel/from/place/_Place/E, %% solsiden
    not dob/reach/_/_/_ ,              %% heuristic
    not Time isa minute
id  not keepafter(_,_,_),
    replace  passevent(Deps,Bus,Place,Opts,Day,E)
    with   ( keepafter(Time1,Deps,NewDeps),  %% <---
             passevent(NewDeps,Bus,Place,Opts1,Day,E))
ip  number(Time), %% not duration
    addtotime(Time,1,Time1), %% <--
    setopts([time,firstcorr,nextaftertime(1)],Opts,Opts1) ).


busdepaftertime3 rule bustrans:(
is  srel/AFTER/CLO/Time/E,
            {dmeq(after,AFTER),
             dmeq(timeclock,CLO)},
    not present srel/there/place/nil/_, %% fremme = ankomme %% TA-110415 haz ?
    not present _ isa arrival,
    present Time isa clock,
    not present srel/around/time/_/_, %% confuse
    not present srel/before/time/_/_, %% // not nextbusafter
    present (do)/Go/Bus/E, {Bus \== 'I'},  %% ad hoc
          {dmeq([go,be,be1],Go)},        %% hvor er bussen
    present srel/from/place/_Place/E,  % solsiden %% what if GPS ?? %% TA-110406
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
    setopts([time,nextaftertime(0)],Opts,Opts1) ).  %% allow several



busdepaftertimehereafter rule bustrans:( % ...after a clock?
is  srel/after/Thing/Time/_, present Time isa clock,
    present srel/hereafter/time/nil/_
id	 not  keepafter(_,_,_),
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with (keepafter(Time,Deps,NewDeps),
               passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq([time,thing],Thing),   %% catch   bus after time to...
    number(Time),
    \+ member(to,Opts),
    setopts([time,firstcorr],Opts,Opts1) ).

departurebetweentimes rule bustrans:( % between 1700 and 1630 means departure between
is  srel/after/Thing/Time1/_,
    present Time1 isa clock,
    srel/before/_/Time2/_,  %% not present, must use up
    present Time2 isa clock,
    not present srel/around/time/_/_, %% confuse
    not srel/in_order_to/_/_/_
id	 not  keepafter(_,_,_),
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with (keepafter(Time1,Deps,NewDeps1),
          keepbefore(Time2,NewDeps1,NewDeps),
          passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq([time,thing],Thing),
    number(Time1), number(Time2),
    \+ member(to,Opts),
    setopts([time],Opts,Opts1) ). %%


busaftertimebetw rule bustrans:( % ...after a clock? but before another cloc
                      % should ideally consider evening time/ tomorrow
is  srel/after/Thing/Time/_, present Time isa clock,
    present srel/before/time/T10/_,
    not present srel/around/time/_/_, %% confuse
    not present T10 isa minute      %% Ad Hoc
%     not srel/in_order_to/_/_/_
id	 not  keepafter(_,_,_),
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with (keepafter(Time,Deps,NewDeps),
               passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq([time,thing],Thing),   %% catch   bus after time to...
    number(Time),
    \+ member(to,Opts),
    setopts([time],Opts,Opts1) ). %%


busaftertime5 rule bustrans:( % ...after a clock?
is  srel/after/Thing/Time/E, present Time isa clock,
    not present srel/around/time/_/_, %% confuse

 not srel/in_order_to/_/_/_,    %% for å rekke en buss som går 09.30 fra byen?
                                   %% for å gå fra ?
    present (do)/go/V/E, {dmeq(vehicle,V)}, %% same event
    not present adj/_/last/_/real,
    not present (do)/arrive/_/_
id	 not message(nocorresponse), %%  for å rekke en buss som går 09.30 fra byen?
    not  keepafter(_,_,_),
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with (keepafter(Time,Deps,NewDeps),
               passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq([time,thing],Thing),   %% catch   bus after time to...
    number(Time),
    \+ member(to,Opts),
    setopts([time,firstcorr],Opts,Opts1) ).

buswitharraftertime rule bustrans:( %% buss med ankomst etter KL
is  _B isa arrival,      %% srel/_nilwith_/arrival/B/_,
    srel/after/time/Time/_, {number(Time)}, %% not duration
    not present srel/around/time/_/_,
    present srel/To/place/_Place/_, { dmeq([to,nil],To)},
    not Time isa minute
id  not keepafter(_,_,_), %%  etter 1800 om kvelden //not already
    replace  passevent(Deps,Bus1,Place,Opts,Day,G)
    with   ( keepafter(Time,Deps,NewDeps),
             passevent(NewDeps,Bus1,Place,Opts1,Day,G))
ip  testmember(to,Opts), %% be sure it is the destination passevent
    setopts([time,nextaftertime(1)],Opts,Opts1) ).

busarraftertime1 rule bustrans:( %%  I arrive after Time
is  (do)/arrive/_/E,
    srel/after/time/Time/E, {number(Time)}, %% not duration
    not present srel/around/time/_/_,
    present srel/To/place/_Place/_, { dmeq([to,nil],To)},
    not Time isa minute
id  not keepafter(_,_,_), %%  etter 1800 om kvelden //not already
    replace  passevent(Deps,Bus1,Place,Opts,Day,G)
    with   ( keepafter(Time,Deps,NewDeps),
             passevent(NewDeps,Bus1,Place,Opts1,Day,G))
ip  testmember(to,Opts), %% be sure it is the destination passevent
    setopts([time,nextaftertime(1)],Opts,Opts1) ).


busarraftertime2 rule bustrans:( %%  bus goes after Time (to place)
is  srel/AFTER/CLO/Time/E,
      { dmeq(after,AFTER),
        dmeq(timeclock,CLO),
         number(Time)}, %% not duration
    not present srel/around/time/_/_,
    present (do)/Go/Bus/E, {dmeq([go,be1],Go)}, %%  %%% Expensive %%%
    present srel/To/place/Place/E, { dmeq([to,nil],To)},
    not srel/in_order_to/_/_/_,   % heuristic
    not dob/reach/_/_/_ ,             % heuristic
    not Time isa minute
id  not keepafter(_,_,_), %%  etter 1800 om kvelden //not already
    replace  passevent(Deps,Bus,Place,Opts,Day,E)
    with   ( keepafter(Time,Deps,NewDeps),
             passevent(NewDeps,Bus,Place,Opts1,Day,E))
ip  testmember(to,Opts), %% be sure it is the destination passevent
    setopts([time,nextaftertime(1)],Opts,Opts1) ).



%%%% moved after  NEXT N BUSES AFTER
busdepaftertime rule bustrans:( %% bus departure after a time
is  srel/After/TiCo/Time/_A,  {dmeq(after,After),dmeq(timeclock,TiCo)},
    not present srel/there/place/nil/_, %% fremme = ankomme %% TA-110415 haz ?
    not present _ isa arrival,

    present Time isa clock, %% in afternoon ?
    not present srel/earlier/time/_/_, %% ad hoc
    not present srel/before/_Activity/_/_, %% confuse
    not present srel/around/time/_/_, %% confuse
    not srel/in_order_to/_/_/_,
 %%%%   not srel/so_that/_/_/_,
    not present (do)/arrive/_/_,  %% <-- ?
    not srel/last/time/_/_ ,
    not srel/late/time/_/_ ,
    not srel/later/time/_/_ ,
    not present srel/before/time/_/_, %%  then not nextaftertime
    not present srel/to/clock/_/_,     %% Norwagism
    not present adj/_/last/_/real
id	 not  keepafter(_,_,_),            %% ( om kvelden etter 1800)
    replace ( passevent(Deps,Bus,Place,Opts,Day,A))
	 with (    keepafter(Time,Deps,NewDeps),
			     passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 \+ member(to,Opts), %% in case two passevents, select the right
    number(Time),
    setopt(time,Opts,Opts0),
    setopt(nextaftertime(1),Opts0,Opts1) ).



%%%% ARRIVAL AFTER TIME -> moved after keepfrombay


afteratime rule bustrans:( % ...after a time?
is  srel/Hereafter/time/nil/_  ,
    not present srel/after/time/_/_ , %% fortest mulig etter tid
    not present srel/nil/time/_/_ ,  %% nå kl 1745
    not present srel/before/time/_/_  %% "raskest"
id	 atday(Day),
    replace passevent(Deps,Bus,Place,Opts,Day,A)
    with		(timenow2(1,MinTime), %% add 1 minute
             keepafter(MinTime,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	   \+ testmember(to,Opts),     %% not next to destination !!!
    dmeq([now,hereafter],Hereafter),
    today(Day),  %% if another day, first in the morning
    \+ member(to,Opts), %% not arrival but departure time %%
                      %% This rules selects the right passevent if > 2
    setopt(time,Opts,Opts0),
    setopt(next(1),Opts0,Opts1) ). %% Not last etc


afteratime2 rule bustrans:( % ...after a time?  %% default,  OK with next bus to place
is  srel/Hereafter/time/nil/_ ,
    not srel/nil/time/_/_ ,
    not present srel/after/time/_/_,  %% fortest mulig etter tid
    not present srel/before/time/_/_  %% "raskest"
id	 atday(Day),
    replace passevent(Deps,Bus,Place,Opts,Day,A)
    with		(timenow2(0,MinTime),keepafter(MinTime,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq([now,hereafter],Hereafter),
    \+ testmember(to,Opts),     %% not next to destination !!!
    today(Day),
    setopts([time,next(1)],Opts,Opts1) ).


afteratime00 rule bustrans:( % ...from a time? %% defaultdest=> nil clock=after
is  srel/nil/time/Time/_,
    not srel/so_that/_/_/_,     %% NB  in_order_to = so_that
    not srel/in_order_to/_/_/_,
    not present dob/reach/_/_/_
id	 not flag(defaultdest),
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with (keepafter(Time,Deps,NewDeps),
			 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 number(Time),
    \+ testmember(to,Opts), %% fram center actually
    setopt(nextaftertime(1),Opts,Opts1) ). %% (natural for SMS)

justnlastbuses rule bustrans:(  %%  cant take last Nth
is  quant(eq/N,BD), adj/_/last/BD/_ ,
    present (BD isa BDA)
id  replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	passevent(Deps,Bus,Place,Opts2,Day,A)
ip	 dmeq(busdeparr,BDA),
    testmember(to,Opts),
    testmember(lastcorr,Opts),
    N1 is abs(N),   %% last N'th = last
    deleteall(lastcorr,Opts,Opts1),  %% not only last1
    setopt(last(N1),Opts1,Opts2) ).

%%  NTH bus coded as quant(eq/N ..), N < 0 // not anymore

keepfromgpslocation rule bustrans:( %% go from GPS-location %% TA-110418  After busdepaftertime
is  {value(gpsflag,true)},

    {value(new_origin,true)},  %% NB TA-110206

    not present srel/from/___place/X/_
           when { (bound(X), \+ home_town(X))},

    not present srel/on/place/_/_       %%  hvis jeg er på Samfundet

id  not flag(exit),
    not flag(keepfrombay),  %%  Loop Stop
    not passevent(_,_,_,[from|_],_,_),
    not keepto(_,_,_),
    not keepfrom(_,_,_),
    not connections(_,_,_,_,_,_,_,_,_,_),
%%%    not departure(_,hovedterminalen,_,_), %% TA-110506

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
  ):- single.



keepfrombaygps rule bustrans:( %% go from GPS-location %%  After busdepaftertime
is  {value(gpsflag,true)},

    {value(new_origin,true)},  %% NB TA-110206

    not present srel/from/___place/X/_
           when { (bound(X), \+ home_town(X))},

    not present srel/on/place/_/_       %%  hvis jeg er på Samfundet

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
    direct_connection(Strandveien,ToPlace,_Bus_), %% any bus ???
    timenow2(Minutes,NOW2) %% only consider deps after walking-time

  ):- single.



justnthbusanotherday  rule bustrans:(
is  adj/_/ORD/BD/_, { (ordinal(ORD,N), N >1)},
    present (BD isa BDA),
    not present adj/_/last/_/_,
    not present srel/before/time/_C1700/_
id  atday(BB),
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with    passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 dmeq(busdeparrN,BDA),  %% first also for Nightbus
    today(AA), AA \== BB,
    N1 is N,
    setopt(nth(N1),Opts,Opts1) ).

justnthbusearly  rule bustrans:(
is  adj/_/ORD/BD/_, { ordinal(ORD,N)},
    present (BD isa BDA),
    srel/today/_Day/nil/_,
    not present adj/_/last/_/_,
    not present srel/before/time/_C1700/_
id  replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with    passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 dmeq(busdeparrN,BDA),  %% first also for Nightbus
    N1 is N,
    setopts([firstcorr,nth(N1)],Opts,Opts1) ).


justnthbustoday rule bustrans:(  %%% Nth bus = next N buses
is  adj/_/ORD/BD/_, { ordinal(ORD,N),N>1},  %% EXPERIMENT
    present (BD isa BDA),          %% first bus -> firstbus1 (not nth)
    not present _ isa morning,
    not present adj/_/last/_/_,
    not present srel/after/time/_/_ ,
    not present srel/before/time/_/_ ,
    not present srel/on/day/_/_
id  replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	(timenow2(0,Time),
             keepafter(Time,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq(busdeparr,BDA),
    \+ member(to,Opts),
    N1 is N,
    setopt(nth(N1),Opts,Opts1) ).

%%%   END < 0

justnbuses rule bustrans:( % N buses = next N buses
is  quant(eq/N,BD),  { (number(N),N > 1)},
    present (BD isa BDA),
    not present _ isa morning,
    not present adj/_/last/_/_,
    not present srel/after/time/_/_ ,
    not present srel/before/time/_/_ ,
    not present srel/on/day/_/_
id  not message(otherperiod(_)),
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	(timenow2(0,Time),
             keepafter(Time,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq(busdeparr,BDA),
    \+ member(to,Opts),
    setopt(next(N),Opts,Opts1) ).


firstbus2 rule bustrans:( % Dialog: first bus another day, no time
is  adj/_/First/_Bus/_
id	 not message(mustknow(place)),
    not keepbefore1(_,_,_), %% first before is irrelevant
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with	   ( keepafter(0430,Deps,NewDeps),
              passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq([first,early],First),
    setopt(first(1),Opts,Opts1) ) :- double.


firstbus1 rule bustrans:( % first bus
is  adj/_/First/Bus/_ , present Bus isa Veh, {dmeq(vehicle,Veh)}
id	 not message(mustknow(place)),
    not keepbefore1(_,_,_), %% first before is irrelevant
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with	   passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 dmeq([first,early],First),
    setopt(first(1),Opts,Opts1) ).


firstbus3 rule bustrans:(  % bus goes first (samme situasjon som i passevent)
is  srel/first/time/nil/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 setopt(first(1),Opts,Opts1) ).


nextbus0 rule bustrans:( % next bus (samme buss som i passevent)
is  adj/_/next/BusF/_ ,
    not present srel/before/time/_/_,
    not present srel/around/time/_/_, %% <-- takes priority
    present BusF isa VEH,
    not present adj/_/last/BusF/_ %% NOT next last !!
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
    setopt(next(0),Opts,Opts1) ).  %%% next(0) means unspecified number



nextbus2 rule bustrans:( % next bus ARRDEP
is  present AD isa ARRDEP,adj/_/next/AD/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with    (timenow2(0,Time),keepafter(Time,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq(arrdep,ARRDEP),
    \+ member(to,Opts),
    setopt(next(1),Opts,Opts1) ).


nextbus3 rule bustrans:( % next time
is  adj/_/next/Time/_,present Time isa Timeq
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	(timenow2(0,Now),keepafter(Now,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq(time,Timeq),
    \+ member(to,Opts),
    setopt(next(1),Opts,Opts1) ).


secondlast rule bustrans:( % andre siste ( nest siste)
is  adj/nil/second/F/real, F isa BusF       %% alternative coding
id	 replace passevent(Deps,Bus,Place,Opts, Day,A)
	 with    passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 N1 is 2,
    setopt(last(N1),Opts,Opts1),busorfree(BusF) ).


thirdlast rule bustrans:( % nest nest siste)
is  adj/nil/second/F/real, F isa BusF   %% alternative coding
id	 replace passevent(Deps,Bus,Place,Opts, Day,A)
	 with    passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 N1 is 3,
    setopt(last(N1),Opts,Opts1),busorfree(BusF) ).


lastN rule bustrans:( % last  N buses  %% CANNOT TAKE N'th last = N last
is  quant(eq/N,BusF),adj/_/last/BusF/_
id	 replace passevent(Deps,Bus,Place,Opts, Day,A)
	 with    passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 N1 is abs(N),   %% CANNOT TAKE N'th last
    setopt(last(N1),Opts,Opts1),busorfree(BusF) ).


lastNdefault rule bustrans:( % N buses before, default last
is  quant(eq/N,BusF), { (number(N),N>0)},
    present srel/before/time/T1/_,
    { number(T1)}
id	 replace passevent(Deps,Bus,Place,Opts, Day,A)
	 with    passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 setopt(last(N),Opts,Opts1),busorfree(BusF) ).


lastbus1 rule bustrans:(  % last bus (samme buss som i passevent)
is  adj/_/last/BusG/_  %% NB _ ==> BusG
%%%%     not present _ isa clock  %% last bus after (SIC)
id	 replace passevent(Deps,BusG,Place,Opts,Day,A)
	 with 	passevent(Deps,BusG,Place,Opts1,Day,A)
ip	 setopt(last(1),Opts,Opts1) ).


lastbus2 rule bustrans:( % last bus (samme situasjon som i passevent)
is  adj/_/last/_/A
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 setopt(last(1),Opts,Opts1) ).


lastbus3 rule bustrans:( % bus goes last (samme situasjon som i passevent)
is  srel/Last/time/nil/_ , { dmeq([last,late],Last)}
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 setopt(last(1),Opts,Opts1) ).

lastbus4 rule bustrans:( % buss slutter å gå
is  end/_/F80,srel/in_order_to/thing/_F79/F80
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 setopt(last(1),Opts,Opts1) ).


%%%% see also nextbusyesterday
yesterdayevening  rule bustrans:(  %% 00:00 -- 00:30 , probably last evenings deps
is  _ isa bus or _ isa departure,  %% only relevant questions %% HAIRY  %% day is already fixed to yestarday
    not present _ isa morning %% TA-110724
id  flag(yesterday),  %% RS-150103. Completely remove this flag and all associated rules now?
    remove flag(yesterday),
    addfront message(assumeyesterdepartures)  %% TA-110816  %% RS-150104
%        replace passevent(A,B,C,FROM,Day,D) %% NB [first(1),from],
%       with    (keepafter(NEWLATETIME,A,A1), passevent(A1,B,C,FROM,Day,D))     %% RS-150103. Did I change this now?
%        with    (keepafter(T30,A,A1), passevent(A1,B,C,FROM,Day,D))             %% RS-150103. Did I change this now?
	 %%  only late departures yesterday
ip	[] % testmember(from,FROM) %,
%        set(nightbusflag,true),         %% RS-141115 Does this work?
%        timenow(T30) %,
%       addtotime(2400,T30,NEWLATETIME)           %% RS-150103. Did I change this now?
).

withlastbus rule bustrans:( % last ARRDEP
is  present AD isa ARRDEP,adj/_/last/AD/_,
    not present _ isa clock
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 dmeq(busdeparr,ARRDEP), %%  med siste buss
    setopt(last(1),Opts,Opts1) ).


lasttime rule bustrans:( % last time
is  adj/_/last/Time/_,present Time isa Timeq
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 dmeq(time,Timeq),setopt(last(1),Opts,Opts1) ).



prevN rule bustrans:( % previous N buses
is  quant(eq/N,Bus),adj/_/previous/Bus/_
id	 not keepafter(_,_,Deps), % "etter T" overstyrer "neste"
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	(timenow2(0,Time),
             keepbefore(Time,Deps,NewDeps), %%   Not Closely
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 \+ member(from,Opts),  %%    ( NB avoid before departure)
    setopt(last(N),Opts,Opts1) ).



prevbus1 rule bustrans:( % previous bus (samme situasjon som i passevent)
is  adj/_/previous/_/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with		(timenow2(-1,Time), %% NB, < NOW otherwise, =next bus
             keepbefore(Time,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 setopts([lastcorr,last(1)],Opts,Opts1) ). %% Lastcorr will block keepafter NOW


prevarrdep rule bustrans:( % previous ARRDEP
is  present AD isa ARRDEP,adj/_/previous/AD/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with		(timenow2(0,Time),keepbefore(Time,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq(arrdep,ARRDEP),setopt(last(1),Opts,Opts1) ).


prevtime rule bustrans:( % previous time
is  adj/_/previous/Time/_,present Time isa Timeq
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with		(timenow2(0,Time),keepbefore(Time,Deps,NewDeps),
				 passevent(NewDeps,Bus,Place,Opts1,Day,A))
ip	 dmeq(time,Timeq),setopt(last(1),Opts,Opts1) ).


nthbus1 rule bustrans:( % Nth bus (samme buss som i passevent)
is  adj/_/Nth/_Bus/_, %% Not nec same bus ( toplace1  frees the bus)
    {ordinal(Nth,N)} %%
id	 not message(mustknow(place)),
    not keepbefore1(_,_,_), %% not  Nth bus before
    replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	passevent(Deps,Bus,Place,Opts1,Day,A)
ip	 setopt(nth(N),Opts,Opts1) ).


nthbus2 rule bustrans:( % Nth ARRDEP
is  present AD isa ARRDEP,adj/_/Nth/AD/_
id	 replace passevent(Deps,Bus,Place,Opts,Day,A)
	 with 	passevent(Deps,Bus,Place,[nth(N)|Opts],Day,A)
ip	 dmeq(arrdep,ARRDEP),ordinal(Nth,N) ).


%%% N first/next/last

nbuses rule bustrans:(
is  quant(eq/N,Bus)
id	 replace passevent(Deps,Bus,Place,[next(_)],Day,A)
	 with		passevent(Deps,Bus,Place,[next(N)],Day,A)
ip	 [] ).

nnextbuses rule bustrans:(
is  quant(eq/N,Time),present Time isa Timeq,present adj/_/next/Time/_
id	 replace passevent(Deps,Bus,Place,[next(_)],Day,A)
	 with		passevent(Deps,Bus,Place,[next(N)],Day,A)
ip	 dmeq(time,Timeq) ).

nlastbuses rule bustrans:(
is  quant(eq/N,Bus)
id	 replace passevent(Deps,Bus,Place,[last(_)],Day,A)
	 with 	passevent(Deps,Bus,Place,[last(N)],Day,A)
ip	 [] ).


%%% N buses

nbuses9 rule bustrans:(
is  quant(eq/N,Bus)
id	 replace passevent(Deps,Bus,Place,[],Day,A)
	 with 	passevent(Deps,Bus,Place,[next(N)],Day,A)
ip	 [] ).


samebus rule bustrans:(
is  present B isa bus, adj/_/same/B/_  %%  (same bus)
id  replace passevent(Deps,Bus,Place,Opts,Day,A)
    with    passevent(Deps,Bus,Place,[direct|Opts],Day,A)
ip  [] ).

%%% direct buses

direct1 rule bustrans:(
is  adj/_/direct/_Bus_/_
id  replace passevent(Deps,Bus,Place,Opts,Day,A)
    with    passevent(Deps,Bus,Place,[direct|Opts],Day,A)
ip  [] ).


directly rule bustrans:(
is  srel/directly/(mode)/nil/_  % goes directly
id  replace passevent(Deps,Bus,Place,Opts,Day,A)
    with    passevent(Deps,Bus,Place,[direct|Opts],Day,A)
ip  [] ).



spesificroute rule bustrans:(
is present BusN isa ROUTE
id not selectroute(_,_,_),
   replace passevent(Deps,BusN,Place,Opts,Day,A)
   with    (selectroute(Rid,Deps,NewDeps),
	    passevent(NewDeps,BusN,Place,Opts,Day,A))
ip dmeq(vehicle, ROUTE), getcurrent(Cid), getref(Cid, [Rid], lastroute(BusN))
 ):-double.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Ingen filtrering av avgangssett (Depset) under her
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% To passeringer skal kobles

remreduntant rule bustrans:( % Fjerner redundant stasjon uten melding
is  []
id	 remove   departure(Free69,Haukaasen,_14472,_16791),
    remove   passevent(_16791,Free69,Haukaasen,[],_14472,_),
    departure(Free70,Haukaasen,_14472,_18230),
    passevent(_21388,Free70,Haukaasen,_,_14472,_)
ip	 Free69 \== Free70 ).



underspecneibresolve rule bustrans:( %% underspecified neighbourhood, alternative list
is  NTNU isa neighbourhood,  {bound(NTNU)},
    not present (B isa bus) when { bound(B)},
    not present (R isa route) when { bound(R)},
    not present (T isa tram) when { bound(T)},
    not present (X isa train) when { bound(X)},
    clear
id	 clear,
    add message(place_resolve(NTNU,List))
ip  underspecified_place(NTNU),
    set_of(Alt,place_resolve(NTNU,Alt),List),List \== [] ).

%%%% moved after  underspecneibresolve
underspecifiedneibbus rule bustrans:( %% underspecified neighbourhood, bus given
is  NTNU isa neighbourhood, { bound(NTNU)},
    present B isa bus, { bound(B)},
    clear
id	 clear,
    add message(underspecified_place(NTNU))
ip  underspecified_place(NTNU),
    \+ bus_depend_station(B,NTNU,_) ).


underspecifiedneibnobus rule bustrans:( %% underspecified neighbourhood, no bus, no alt
is  NTNU isa neighbourhood,  { bound(NTNU)},
    not present (B isa bus) when { bound(B)},
    not present (R isa route) when { bound(R)},
    not present (T isa tram)  when { bound(T)},
    not present (X isa train) when { bound(X)},
    clear
id	 clear,
    add message(underspecified_place(NTNU))
ip  underspecified_place(NTNU) ).


underspecstatresolve rule bustrans:( %% underspecified neighbourhood, alternative list
is  NTNU isa station, { bound(NTNU)}, % in case neighbourhood is occluded
    clear
id	 clear,
    add message(place_resolve(NTNU,List))
ip  underspecified_place(NTNU),
    set_of(Alt,place_resolve(NTNU,Alt),List),List \== [] ).



underspecifiedstat rule bustrans:( %% underspecified station
is  Steinan isa station,  { bound(Steinan)},
    present B isa Bus, { dmeq(vehicle,Bus)}, %% (neste=neste kjøretøy)
    clear
id	 clear,
    add message(underspecified_place(Steinan))
ip  underspecified_place(Steinan),
    \+ bus_depend_station(B,Steinan,_) ).


underspecifiedneibus rule bustrans:( %% underspecified neighb, bus#
is  Søndre isa neighbourhood, { bound(Søndre)},
    present B isa Bus, { dmeq(vehicle,Bus)}, %% (neste=neste kjøretøy)
    clear
id	 clear,
    add message(underspecified_place(Søndre))
ip  underspecified_place(Søndre),
    \+ bus_depend_station(B,Søndre,_) ).



%%% To passeringer skal kobles

%%%% Sjekker at det ikke er flere enn 2 stasjoner

toomanyplaces rule bustrans:( %% Går buss 9 fra dragvoll via moltmyra til flatåsen senter .
is  clear %% Doesn't work softly
id	 connections(_,_,_,_,_,_,_,_,_,_), %% 10 arg
    remove passevent(_,_,_,_,_,_),
    clear, %% Doesn't work softly
    addcon  message(toomanyplaces)
ip	 [] ).



connection0 rule bustrans:( %% Shortcircuit if sameplace
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
    place_station( Place1, Station1 ),
    place_station( Place2, Station2 ),
    Station1 == Station2
).  %% NEVER MAKE A CONNECTION TO ITSELF


connectionexplicit rule bustrans:( %% connect  2-> from to explicit
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

    add ( connections(Depset1,Depset2,Bus1,Station1,Station2,Day,SeqNo,OptsUnite,_,_) ),
                                      %??% Bus2 ???
    add flag(exit)
ip	 mixopt(Opts2,Opts1,OptsUnite),
    place_station(Place2,Station2),
    place_station(Place1,Station1),
    Station2 \== Station1 ).  %% NEVER MAKE A CONNECTION TO ITSELF

connectionderived rule bustrans:( %% complicated 1. passevent = to, 2. passevent = nil
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
    Station2 \== Station1 ).  %% NEVER MAKE A CONNECTION TO ITSELF


connectionimplicit rule bustrans:( % no direction given or from to in sequence
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
    Station1 \== Station2 ).  %% NEVER MAKE A CONNECTION TO ITSELF



setnightbusoption rule bustrans:( % Set nightbusoption in connections
is  []
id  flag(nightbusflag),
    not flag(nightbusoption), %%% Loop stop
    add flag(nightbusoption),
    replace    connections(Depset1,Depset2,Bus2,Station1,Station2,Day,SeqNo,Opts1,X,Y)
    with       connections(Depset1,Depset2,Bus2,Station1,Station2,Day,SeqNo,OptsUnite,X,Y)
ip  setopt(nightbus,Opts1,OptsUnite) ).


superfluoustat rule bustrans:( % superfluous station buss fra samfundet  til munkvoll-heimdal.
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
%%%%     add flag(exit)  %% irrelevant unless you  clear it all
    not flag(defaultdest) %% TA-110630 (defut dest means to few places)

ip  bound(JV),
    JV \== A,
    JV \== B,
    \+ placestat(JV,A),
    \+ placestat(JV,B),  %%
    \+ placestat(A,JV),
    \+ placestat(B,JV),
    \+ dmeq([sør,nord,øst,vest],JV) ).


connection3 rule bustrans:( % Kobler sammen to busspasseringer
is  []
id	 remove passevent(Depset1,_,Place1,Opts1,Day,_),
    remove passevent(Depset2,Bus2,Place2,Opts2,Day,_),
    atday2(SeqNo,_Date),
    add (connections(Depset1,Depset2,Bus2,Station1,Station2,Day,SeqNo,OptsUnite,_,_))
ip	 mixopt(Opts1,Opts2,OptsUnite),                          %% NB Added Arg %%
    place_station(Place1,Station1),
    place_station(Place2,Station2),
    not(member(from,Opts2)),
    not(member(to,Opts1)) ).


defaultlast rule bustrans:( %% % Legger paa default siste  busspassering (SMS)
is  not present _ isa morning
id	 present keepbefore(_4335,_3171,Deps1),
    not present keepafter(_,_,_),
    replace connections(Deps2,_3724,_free,_lade,_nth,_3004,SeqNo,Opts,          _5276,_5277)
    with    connections(Deps2,_3724,_free,_lade,_nth,_3004,SeqNo,[last(1)|Opts],_5276,_5277)
ip	 value(smsflag,true),
    Deps1 == Deps2,  not (member(last(_),Opts)) ).


%%% Annet om stasjoner og steder


nameofstations rule bustrans:( % What is the name of the stations?
is  which(A),Station isa station,has/place/name/Station/A,
    not srel/at/place/_/_,     %%  (NB a station near station X)
    not srel/before/place/_/_,
    not srel/after/place/_/_
id	 add listofall(station,_)
ip  unbound(Station) ).


whichstationsk rule bustrans:( % Which stations do you know
is  which(A),tuc isa savant,A isa station,dob/KNOW1/tuc/A/_
  ,{dmeq([know,know1],KNOW1)}
id	 add listofall(station,_) %% only 5  first if SMS
ip  [] ).

whichstationhaveyou rule bustrans:( % Which stations have you
is  which(A),tuc isa savant,A isa station,has/agent/station/tuc/A
id	 add listofall(station,_) %% only 5  first if SMS
ip  [] ).

whichstationexist rule bustrans:( % Which stations have you
is  which(A),A isa station,(do)/exist/A/_,  not srel/_Near/place/_/_, %% TA-100825
    not present X isa Bus when {bound(X),dmeq(vehicle,Bus)} %% TA-110510
id	 add listofall(station,_) %% only 5  first if SMS
ip  [] ).

%%%% STATION NEIGHBOURHOOD SECTION


whereiscompany  rule bustrans:( % Where is AtB %% TA-101112
is  which(Place), TT isa company,
    (do)/Be1/TT/A,srel/ION/place/Place/A,
        {dmeq([be,be1,lie1],Be1)},
        {dmeq([in,on,nil],ION)}
id	 not flag(exit),
    add (message(answer(db_reply(TT,streetaddress,K))))
ip  has_att_val(company,streetaddress,TT,K) ).


whereisstreet rule bustrans:( %%  subsumed by streetstatknown ?
is  which(S),(do)/be1/Place/A,srel/in/place/S/A, present Place isa street
id  not flag(exit),
    not message(nearest_station(_ST,_,_)),
    add stationsat(Place,_,_)
ip  bound(Place) ).


whereisstation3 rule bustrans:(  % Where is Station?
is  Station isa BussStat,has/SN/Wlace/Station/_
id	 add stationsat(_,Station,_)
ip  dmeq(busstation,BussStat),
    dmeq([station,neighbourhood],SN),
    dmeq([location,place,neighbourhood],Wlace),
    station(Station) ).

whatisstatnear rule bustrans:( %% TA-101116
is  which(F26),F26 isa station,
    Place isa neighbourhood,
    (do)/be1/F26/F27,
    srel/near/place/Place/F27,
    event/real/F27
id	 not message(nearest_station(_ST,Place,_)), %%  Not double!
    add stationsat(Place,X,Y)
ip  bound(Place),
    \+ underspecified_place(Place), %% hvor er ntnu
    stationsat(Place,X,Y) ).


whereisneigh1 rule bustrans:( % Where is a neighbourhood
is  which(S),Place isa neighbourhood,(do)/Be1/Place/A,srel/IN/place/S/A,
       {dmeq([lie1,be1],Be1)},
       {dmeq([in,nil,near],IN)} %% TA-101116
id	 not message(nearest_station(_ST,Place,_)), %%  Not double!
    add stationsat(Place,X,Y)
ip  bound(Place),
    \+ underspecified_place(Place), %% hvor er ntnu
    stationsat(Place,X,Y) ).


whereisneigh2 rule bustrans:( % Where is a neighbourhood
is  which(S),Place isa neighbourhood,has/neighbourhood/place/Place/S
id	 add stationsat(Place,_,_)
ip  bound(Place) ).


whereisstation rule bustrans:( % Where is Station?
is  exactly (which(Station),Station isa BussStat,event/real/_)
id	 add stationsat(_,Station,_)
ip  dmeq(busstation,BussStat),bound(Station) ).


whereisstation1 rule bustrans:( % Where ligger Station?
is  which(A),A isa place,MS isa station,(do)/Lie1/MS /E,
       {bound(MS)}, {dmeq([lie1,be,be1],Lie1)}, srel/nil/place/A/E,event/real/E
id	 add stationsat(_,MS,_)
ip  dmeq(busstation,Station),bound(Station) ).


wherestationatplace rule bustrans:( % where is Station at Place?
is  which(F21),
    F21 isa place,
    (do)/Be1/Stations/A,srel/AT/place/Place/A,
    srel/in/place/F21/A
id	 not message(nearest_station(_ST,_,_)),
    add stationsat(Place,Stations,SSS)
ip  dmeq([lie1,be1,exist],Be1),
    dmeq(nearat,AT),statorplace(Place),
    stationsat(Place,Stations,SSS) ).

whereisneareststationtoplace rule bustrans:( %%  where is the nearest Station to Place?
is  which(F29),    F29 isa place,
    RD isa station, { bound(RD)},
    adj/_/nearest/F28/real,
    (do)/Be1/F28/E,
    srel/in/place/F29/E
id	 not message(nearest_station(_ST,_,_)),
    add stationsat(RD,_,SSS)
ip  dmeq([lie1,be1,exist],Be1),
    statorplace(RD),
    stationsat(RD,_,SSS) ).


whereisneareststation0 rule bustrans:( % where is nearest Station ?
is  which(F21),F21 isa station,
    adj/_/nearest/F21/_
id	 not message(nearest_station(_ST,_,_)),
    not message(mustknow(place)),
    add message(mustknow(place))
ip  [] ).



stationatstation   rule bustrans:( %% which station is near station
is  Station isa station,srel/around/place/Station/A,
    present (do)/Be1/Station/A,  { dmeq([lie1,be1,exist],Be1)}
id	 not message(nearest_station(_ST,_,_)),
    add stationsat(Station,Station,SSS)
ip  stationsat(Station,Station,SSS) ).



stationsatsentrumsterminalen rule bustrans:( %% which station is at hovedterminalen
is  Station isa station,  {unbound(Station)},
    (do)/Be1/Station/A, { dmeq([lie1,be1,exist],Be1)},
    srel/AT/Placoid/Place/A, { dmeq([station,place],Placoid)},
        {dmeq([hovedterminalen],Place)}
id	 not message(nearest_station(_ST,_,_)),
    add stationsat(sentrum,Station,SSS)
ip  dmeq(nearat,AT),statorplace(Place),
    stationsat(sentrum,Station,SSS) ).


stationatplace rule bustrans:( %% which station is at Place
is  Station isa station,Place is neighbourhood, %% prof. Brochs gt ON torget *
    (do)/Be1/Station/A, { dmeq([lie1,be1,exist],Be1)},
    srel/AT/Placoid/Place/A, { dmeq([station,place],Placoid)}
id	 not message(nearest_station(_ST,_,_)),
    add stationsat(Place,Station,SSS)
ip  dmeq(nearat,AT),statorplace(Place),
    stationsat(Place,Station,SSS) ).


stationsatneighbourhood rule bustrans:(     %% risvollansenteret og buenget er ved tempe (SIC) (avoid OK)
is  Place isa neighbourhood,
    (do)/Be1/(_,_)/A,   {dmeq([lie1,be1,exist],Be1)},
    srel/AT/Placoid/Place/A, {dmeq([station,place],Placoid)}
id	 not message(nearest_station(_ST,_,_)),
    add stationsat(Place,Station,SSS)
ip  dmeq(nearat,AT),
    stationsat(Place,Station,SSS) ).


neib_lies_at_place rule bustrans:( %% does a neib lie at a place
is  (do)/be1/Neib/E,
    Neib isa neighbourhood, { bound(Neib)},
    srel/at/place/Place/E,
    Place isa neighbourhood, { bound(Place)}
id  add stationsat(Neib,_Stations,_)
ip  statorplace(Neib),
     \+ home_town(Neib) ). %%  Place \== trondheim.


wherewhat_is_place rule bustrans:(
is  which(Place), Place isa neighbourhood, event/real/_,
    { bound(Place)}
id	 not message(nearest_station(_ST,_,_)),
    add stationsat(Place,Stations,SSS)
ip  stationsat(Place,Stations,SSS) ).


station_has_station rule bustrans:(% Place has station // Place IS allready a station !
is  which(Free),
    has/place/station/Free/Station, %% // mix subj/obj
    Station isa station,
    Free isa station
id	 add stationsat(Station,_Stations,_)
ip  station(Station),
    \+ home_town(Station), %%  \== trondheim,
    unbound(Free) ).


place_has_station rule bustrans:( % Place has station
is  which(Station),
    Station isa station, Place isa neighbourhood,has/_/station/Place/Station
id	 add stationsat(Place,_Stations,_)
ip  statorplace(Place),
     \+ home_town(Place) ). %%  Place \== trondheim.


%%%%% END STATION NEIGHBOURHOOD SECTION


whereistuc rule bustrans:( % Where is tuc ,Are you here
is  tuc isa _,(do)/be1/tuc/A,srel/In/place/_/A, {dmeq([in,nil],In)},
    not _ isa date,  %% hvor var du da
    clear
id	 not flag(exit),
    clear,
    add message(cannotanswer),
    add flag(exit) %% no error by TUC
ip  [] ).

whereisbustuc rule bustrans:( % Where is bustuc
is  bustuc isa _,(do)/be1/bustuc/A,srel/in/place/_/A
id	 add message(cannotanswer)
ip  [] ).

%%%%[which(A):::(amble isa lastname,A isa place,(do)/be1/amble/B,srel/nil/place/A/B,event/real/B)]
%%%%[which(A):::(tore isa firstname,A isa place,(do)/be1/tore/B,srel/nil/place/A/B,event/real/B)]

whereistoreamble rule bustrans:( % hvor er tore %% RS-110929
is  Tore_amble isa _person,_Place isa place,(do)/be1/Tore_amble/_Time
id   add  message(answer(db_reply(Tore_amble,address,Adr)))
ip  has_att_val(_person,address,Tore_amble,Adr) ).

whereisentity rule bustrans:( % hvor er tore
is  Tore isa _Firstname,_Place isa place,(do)/be1/Tore/_Event
id   add  message(answer(db_reply(Tore,address,Adr)))
ip  has_att_val(_Person,address,Tore,Adr) ).


getoff rule bustrans:( % Where can i get off the bus
is  which(Place),present C isa bus,get/_/E,
	 srel/in/place/Place/E,srel/off/vehicle/C/E
id	 add message(mustknow(bus))
ip  unbound(Place),unbound(C) ).


geton rule bustrans:( % Where can i get on the bus
is  which(Place),present C isa bus, srel/In/place/Place/E,srel/On/vehicle/C/E,
    not NTH isa neighbourhood when { bound(NTH)}, %% NBNB NEW
    not NTH isa station       when { bound(NTH)}

id	 not message(_),
    add message(mustknow(bus))
ip  dmeq([in,at],In),
    dmeq([on,off,by],On),      %% av --> by (SIC) Repair
    unbound(Place),unbound(C) ).


wstatdoyouknow rule bustrans:( % Which stations do you know
is  which(Station),tuc isa savant,Station isa station,dob/KNOW1/tuc/Station/_
  ,{dmeq([know,know1],KNOW1)}
id	 add listofall(station,_)
ip	 [] ).


wisnumberofbus rule bustrans:( % What is the numer of bus Bus
is  which(N),has/bus/number/Bus/N
id	 add message(is(bus,Bus))
ip	 bound(Bus) ).


isplacestation rule bustrans:( % is station a bus station?
is  exactly (test,Station isa Placeq,
             has/vehicle/station/_/Station,event/real/_)
id	 add station(Station)
ip  dmeq(place,Placeq) ).


isbusstation rule bustrans:( % is station a bus station?
is  exactly (test,Station isa station,event/real/_)
id	 add testanswer(properstation(Station),_) %% not Kristiansund
ip  [] ).


buzz rule bustrans:( % is Bus a Bus
is  exactly (test,B52 isa BR,event/real/_)
id	 add true
ip  dmeq(bus,BR),exbus(B52) ).


%%% How many


depsinayear rule bustrans:( % haow many deps in a year
is  howmany(Bus),present Bus isa bus, A isa YEAR, srel/IN/time/A/_
id  clear, add message(idonotknow)  % Dont be fooled
ip  dmeq([in,nil],IN),
    dmeq([year,month,week,minute,second],YEAR) ).

quant  rule bustrans:( % antall  departures, no connections
is  quant(count,A),(A isa bus,(do)/go/A/B,event/real/B),
    not present srel/nil/week/_/_ %% hver uke
id  replace passevent(Deps,X1,X2,Opts, X3,X4)
    with    passevent(Deps,X1,X2,Opts1,X3,X4),
    add numberof(departures,Deps,_)
ip  setopt(number,Opts,Opts1) ).



howmany1 rule bustrans:( % how many buses, have connections
is  howmany(Bus),present Bus isa bus,
    not srel/in_order_to/thing/_/_ ,
    not present _ isa self,
    not present  dob/take/_/_/_,
    not present srel/because_of/_/_/_ %% avoid hvor mange busser må jeg ta
id  replace connections(X1,X2,X3,X4,X5,X6,SeqNo,Opts, Deps,X7)
    with    connections(X1,X2,X3,X4,X5,X6,SeqNo,Opts1,Deps,X7),
    add numberof(departures,Deps,_)
ip  setopt(number,Opts,Opts1) ).


howmany2 rule bustrans:( % how many departures, no connections
is  howmany(Arrdep),present Arrdep isa ARRDEP,
    not present srel/nil/week/_/_ %% hver uke
id  replace passevent(Deps,X1,X2,Opts, X3,X4)
    with    passevent(Deps,X1,X2,Opts1,X3,X4),
    add numberof(departures,Deps,_)
ip  dmeq(busdeparr,ARRDEP),
    setopt(number,Opts,Opts1) ).


howmany3 rule bustrans:( % how many deparures, have connections
is  howmany(Arrdep),present Arrdep isa ARRDEP,
    not present _ isa self,
    not present  dob/take/_/_/_,
    not present srel/because_of/_/_/_ %% avoid hvor mange busser må jeg ta
id  replace connections(X1,X2,X3,X4,X5,X6,SeqNo,Opts, Deps,X7)
    with    connections(X1,X2,X3,X4,X5,X6,SeqNo,Opts1,Deps,X7),
    add numberof(departures,Deps,_)
ip  dmeq(busdeparr,ARRDEP),
    setopt(number,Opts,Opts1) ).



%%% Høflighetsfraser og tull og sludder

tuchelp00 rule bustrans:( % Hva  kan busstuc brukes til
is  which(A), dob/use/_/bustuc/C, srel/to/thing/A/C
id	 add message(howtuchelp)
ip	 [] ).


tuchelp0 rule bustrans:( % What is your task/purpose/job/quest/
is  which(A),(has/agent/Task1/B/A,B isa program,A isa Task2)
id	 add message(howtuchelp)
ip	 dmeq([task,job,domain],Task1), dmeq([task,job,domain],Task2) ).


tuchelp2 rule bustrans:( % can you tell / hva kan du hjelpe med
is  not explain, %% how do you know
    tuc isa savant,(do)/KNOW1/TUC/_ ,
           { dmeq(tuc,TUC)},
           { dmeq([do1,tell,know,know1,help],KNOW1)}, %%  (-work)
    not TUC isa person,       %% etc
    not _ isa neighbourhood,
    not _ isa station
  ,{dmeq([know,know1],KNOW1)}
id	 not departure(_,_,_,_),   %% already answering
    not message(thatisagoodquestion), %% TA-110120
    add message(howtuchelp)
ip	 [] ).



tuchelp3 rule bustrans:( % What can you do? Can you anything
is  which(AA),tuc isa savant,dob/V/TUC/AA/_,
    not present _ isa language,
    not present (_ isa clock),
    not present (_ isa place) , %% not do you know where ...
    not present (_ isa number), %% = route
    not present dob/be_named/_/_/_, %%% ETC ETC
    not present dob/be/_/_/_,
    not present _ isa error     %%  :-(
id	 not message(_),
    not passevent(_,_,_,_,_,_),
    not departure(_,_,_,_),
    not findstations(_,_,_),
    add  message(howtuchelp)
ip	 dmeq(tuc,TUC),dmeq([do1,tell,know,know1,answer1,understand],V),
    \+ dmeq(knownlanguage,AA) ).

tuchelp4 rule bustrans:( % kan du fortelle meg noe ?
is  tuc isa savant, dob/Tell/tuc/A/B,
         {dmeq([tell,know,know1,say,write],Tell)},
         {unbound(A)},
    event/real/B,
    not _ isa language,
    not _ isa question  %% ad hoc  Du må oppgi
id	 not departure(_,_,_,_),

    not message(_Howtuchelp), %% TA-110215 not any message
    add message(howtuchelp)
ip	 [] ).

tuchelp5 rule bustrans:( % hva driver du med (Norw)
is  tuc isa savant, (do)/operate/tuc/B,srel/(with)/thing/_A/B
id	 not departure(_,_,_,_),
    add message(howtuchelp)
ip	 [] ).

tuchelpabout rule bustrans:( % kan du fortelle meg noe ?
is  tuc isa savant, dob/Tell/tuc/A/E, srel/about/thing/A/E,
           {dmeq([tell,know,know1],Tell)},
    event/real/E,
    not _ isa question %% ad hoc  Du må oppgi
id	 not departure(_,_,_,_),
    add message(howtuchelp)
ip	 [] ).

tuchelp5 rule bustrans:( % What can i ask
is  which(_A),I isa self, (do)/ASK/I/_
id	    not departure(_,_,_,_),
    add message(howtuchelp)
ip	 dmeq([ask],ASK) ).

tuchelp6tv rule bustrans:( %% Hva kan du hjelpe meg med
is  dob/help/Tuc/_/_ , { dmeq([tuc,tt],Tuc)} %%  du=tuc, dere=tt
id    not departure(_,_,_,_),
    add message(howtuchelp)
ip  [] ).

tuchelp6itv rule bustrans:( %% Hva kan du hjelpe med (unnec)
is  (do)/help/Tuc/_ , { dmeq([tuc,tt],Tuc)} %%  du=tuc, dere=tt
id    not departure(_,_,_,_),
    add message(howtuchelp)
ip  [] ).


tuchelp8 rule bustrans:(   % Hvilke spørsmål kan jeg stille
is  which(_Q), %% Q isa question, HVA kan jeg ....
    dob/ask/'I'/_/_ %%  jeg spørre
id	 not departure(_,_,_,_),
    add message(howtuchelp)
ip	 [] ).


tuchelp9 rule bustrans:( % Kan jeg/man spørre
is  test,  (do)/ask/I/_,
    I isa Agent
id	 not  message(howtuchelp),
    not departure(_,_,_,_),
    add message(howtuchelp)
ip	 dmeq([self,agent],Agent) ).

tuchelp10 rule bustrans:( % Kan jeg/man spørre om en ting
is  test,  (do)/ask/I/_/_,
    I isa Agent
id	 not departure(_,_,_,_),
    add message(howtuchelp)
ip	 dmeq([self,agent],Agent) ).


tuchelp11 rule bustrans:( % What is possible for you
is  which(Q),
    adj/_/Possible/Q/E,
    srel/for/agent/Bustuc/E
id	 not departure(_,_,_,_),
    add message(howtuchelp)
ip	 dmeq([possible,impossible],Possible),
    dmeq(tuc,Bustuc) ).


tuchelp12 rule bustrans:( % I need help
is  new, I isa self,
    dob/Want/I/X/_ ,{dmeq([want,need],Want)},
    X isa Help, {dmeq([help,advice],Help)} %% TA-110601
id	 not departure(_,_,_,_),
    add message(howtuchelp)
ip	 [] ).


tuchelp13 rule bustrans:( %% hva har du informasjon om
is  which(_),(tuc isa savant,A isa information,has/agent/information/tuc/A,event/real/_)
id	 not departure(_,_,_,_),
    add message(howtuchelp)
ip	 [] ).

tuchelp14 rule bustrans:( % I vil ha hjelp
is  new, I isa self,A isa help,
    has/agent/help/I/A
id	 not departure(_,_,_,_),
    add message(howtuchelp)
ip	 [] ).

tuchelp14 rule bustrans:( % Jeg trenger hjelp
is  new, I isa self,A isa help,dob/_Need/I/A/_
id	 not departure(_,_,_,_),
    add message(howtuchelp)
ip	 [] ).

doyouknow rule bustrans:( %% kan du noen språk %% Moved back
is  tuc isa savant,dob/KNOW1/Tuc/_A/B,event/real/B,
    not present (do)/go/_/_, %% then not general
      { dmeq([busstuc,bustuc,tuc],Tuc),
        dmeq([know,know1,answer1],KNOW1)}
id  not message(_),
    add message(cannotanswer),
    add flag(exit) %% not negans
ip  [] ).


%%%% Very general questions, late ...

busstations0 rule bustrans:( % Which bus stations
is  exactly (which(A),A isa Station)
id  not departure(_,_,_,_),
    add listofall(station,_)
ip  unbound(A),
    dmeq([stop,station,place,destination],Station) ).


busstations1 rule bustrans:( % Which bus stations
is  exactly (which(A),A isa Station,event/real/_)
id  not departure(_,_,_,_),
    add listofall(station,_)
ip  unbound(A),
    dmeq([stop,station,place,destination],Station) ).

busstations2 rule bustrans:( % Hva er holdeplassene
is  exactly (which(A),A isa Station,_ isa thing,event/real/_) %% Ad hoc
id  not departure(_,_,_,_),
    add listofall(station,_)
ip  unbound(A),
    dmeq([stop,station,place,destination],Station) ).

hvaheterstasjonene rule bustrans:( % Which bus stations
is  exactly (which(F23),F22 isa station, dob/be_named/F23/F22/B,event/real/B)
id  not departure(_,_,_,_),
    add listofall(station,_)
ip  [] ).


wstations9 rule bustrans:( % Which bus stations
is  exactly (which(A),A isa station,(do)/be1/A/B,event/real/B)
id  not departure(_,_,_,_),
    add listofall(station,_)
ip  [] ).


wtramstat1 rule bustrans:( % Which tram stations
is  exactly (which(A),A isa tramstation,(do)/be1/A/B,event/real/B)
id  not departure(_,_,_,_),
    add tramstations(_)
ip  [] ).


wtramstat2 rule bustrans:( % Which tram stations
is  exactly (which(A),A isa tramstation)
id  not departure(_,_,_,_),
    add tramstations(_)
ip  [] ).


wtramstat3 rule bustrans:( % Where are the tram stations
is  exactly (which(A),A isa place,B isa tramstation,(do)/be1/B/C,srel/in/place/A/C,event/real/C)
id  not departure(_,_,_,_),
    add tramstations(_)
ip  [] ).


wherearestat rule bustrans:( % Where are the bus stations
is  not X isa station when { bound(X)},
    exactly (which(A),A isa place,B isa station,(do)/be1/B/C,srel/in/place/A/C,event/real/C)
id  not departure(_,_,_,_),
    add listofall(station,_)
ip  \+ value(smsflag,true) ).


wherearestat rule bustrans:( % Where are the bus stations
is  not X isa station when { bound(X)},
    exactly (which(A),A isa place,B isa station,(do)/be1/B/C,srel/in/place/A/C,event/real/C)
id  not departure(_,_,_,_),
    add message(mustknow(bus))
ip  value(smsflag,true) ).


whereisfirststat rule bustrans:( % Where is the first the bus stations
is  not X isa station when { bound(X)},
    which(A),A isa place,B isa station,(do)/be1/B/C,srel/in/place/A/C,event/real/C,adj/_/_/B/_
id  not departure(_,_,_,_),
    add message(mustknow(bus))
ip  [] ).


whichavestattt rule bustrans:( % which stations (is had by) TT
is  which(A),A isa station,has/_/station/tt/A
id  not departure(_,_,_,_),
    add listofall(station,_)
ip  [] ).


whichavestattt rule bustrans:( % which stations (is had by) GB
is  which(A),A isa station,has/_/station/gråkallbanen/A
id  not departure(_,_,_,_),
    add listofall(tramstation,_)
ip  [] ).


equal rule bustrans:(
is  which(T),equal/T/TT,TT isa _Company
id  add message(answer(bcpbc(TT))) %% ugly ?  print specname if any
ip  bound(TT) ).

%%%%........


describe100 rule bustrans:(   % What is a man %% moved backwards
is  exactly (which(A),A isa Man),
    { unbound(A)},
    clear
id  clear,
    add message(answer(bcpbc(Abstract)))
ip  \+ value(teleflag,true),
    (Man ako Abstract),
    \+ member(Man,[airport,god,price,bus,tram,
          route,vehicle,driver,destination,
          clock,telephone,departure,information,route_plan,
          time,question,answer,station,stop]) %% etc.
) :- single.


%%%%%%%%%


%%%% DEFAULTS for Flybussen:::


fbdefaultfromlerkendal  rule bustrans:(
is  FB isa Airbus, {dmeq(vehicle,Airbus)},

   %%  flag(airbus),
    { value(airbusflag,true) },

    not present srel/from/place/Lerk/_,  %% this is a deafult rule bustrans:(

    not present srel/to/place/Lerk/_  when {\+ airbusstation(Lerk)},

    { default_origin(_,LerkStad) }, %% sorgenfriveien

    not present srel/from/place/Scandic/_  when { bound(Scandic)},
    present event/real/E,
    not present dob/pass/FB/_Steinan/E  %% direction ?

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


ip  default_origin( flybussen,CHLK ) %% NEW busdat
 ):- single.


fbdefaulttolerkendal  rule bustrans:(
is  FB isa Airbus, {dmeq(vehicle,Airbus)},

    {value(airbusflag,true)},
    {default_origin(_,CHLK)},

    not present srel/from/place/Scandic/_  when { \+ default_destination(_,Scandic)},

    not present srel/to/place/Scandic/_  when {bound(Scandic)},

    present event/real/E,
    not present dob/pass/FB/_Steinan/E  %% direction ?

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
 ):- single.  %% sic %%


fbdefaultfromværnes rule bustrans:( %% flybuss fra  lerkendal
is  {value(airbusflag,true)},
    present FB isa Airbus, {dmeq(vehicle,Airbus)},

   {default_destination(_,CHLK)},
    not present _ isa airport,

    not present srel/from/place/Scandic/_  when { bound(Scandic)},
    present event/real/E,

    not present dob/pass/FB/_Steinan/E  %% direction ?
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
    not departure(_,st_olavs_gate,_,_),  %% Dirty
    not findstations(_,_,_),

    atday(Day),atdate2(DaySeqNo,_Date),

    add (departure(flybussen,CHLK,DaySeqNo,Depset),
			passevent(Depset,flybussen,CHLK,[from],Day,E))

ip  []
 ):- single.  %% sic %%


fbdefaulttoværnes rule bustrans:( %% flybuss fra  lerkendal
is  {value(airbusflag,true)},
    {default_destination(_,CHLK)},
    present FB isa Airbus, {dmeq(vehicle,Airbus)},

    not present _ isa airport,

    not present srel/to/place/Scandic/_  when { bound(Scandic)},
    present event/real/E,

    not present dob/pass/FB/_Steinan/E  %% direction ?
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
    not departure(_,st_olavs_gate,_,_),  %% Dirty
    not findstations(_,_,_),

    atday(Day),atdate2(DaySeqNo,_Date),

    add (departure(flybussen,CHLK,DaySeqNo,Depset),
			passevent(Depset,flybussen,CHLK,[to],Day,E))

ip  []
 ):- single.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


gotodefaultplace rule bustrans:( %% go from S to default  place
is  not present srel/To/place/Scandic/_  when
                   { dmeq([to,before,in],To),bound(Scandic)},
                                     %%%% TA-110630
    present event/real/E,
    present  Bus36 isa Veh , { bound(Bus36),dmeq(vehicle,Veh)},
    not present dob/pass/Bus36/_Steinan/E  %% direction ?
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
    not departure(_,st_olavs_gate,_,_),  %% Dirty
    not findstations(_,_,_),
    add (departure(Bus36,Paul_Skolemesters_vei,DaySeqNo,Depset),
			passevent(Depset,Bus36,Paul_Skolemesters_vei,[to],Day,E)),
    add flag(defaultdest) %% avoid nil clock = before clock
ip  default_destination(Bus36,Sjetnmarka),
    bus_place_station(Bus36,Sjetnmarka,Paul_Skolemesters_vei)
 ):- single.

gotodefaultplacefromcenter rule bustrans:(
is  not present srel/to/place/_/_,
    present event/real/E,
    present srel/from/place/Sentrum/E, %% or corr
    { samefplace(Sentrum,hovedterminalen)},
    present event/real/E,
    present  Bus36 isa Veh ,{ bound(Bus36),dmeq(vehicle,Veh)},
    not present dob/pass/Bus36/_Steinan/E  %% direction ?
id  not flag(defaultdest),
    not flag(exit),
    not endstations(_,_),
    atday(Day),atdate2(DaySeqNo,_Date),
    not message(sameplace(_,_)),
    not keepto(_,_,_),
    not connections(_,_,_,_,_,_,_,_,_,_),
    not frequency(_,_,_,_),
%%%%%%%%%%%%%%%%%%%%%%    not departure(_,hovedterminalen,_,_),
    not departure(_,st_olavs_gate,_,_),  %% Dirty
    not findstations(_,_,_),
    add (departure(Bus36,CHLK,DaySeqNo,Depset),
			passevent(Depset,Bus36,CHLK,[to],Day,E)),
    add flag(defaultdest) %% avoid nil clock = before clock
ip  default_destination(Bus36,CHLK) %% NEW busdat
 ):- single.



gofromdefaultplace rule bustrans:( %% go to S  from default  place
is  not present srel/_From/place/Scandic/_
           when { bound(Scandic) },
    present event/real/E,
    present  Bus36 isa Veh , { bound(Bus36),dmeq(vehicle,Veh)},
    not _ isa clock, %% klokka er 10
    not present dob/pass/Bus36/_Steinan/E  %% direction ?
id  not flag(defaultdest),  %%  Retention
    not flag(exit),
    not endstations(_,_),
    atday(Day),atdate2(DaySeqNo,_Date),
    not message(sameplace(_,_)),
    not keepto(_,_,_),
    not connections(_,_,_,_,_,_,_,_,_,_),
    not frequency(_,_,_,_),
    not departure(_,st_olavs_gate,_,_),  %% Dirty
    not findstations(_,_,_),
    add (departure(Bus36,CHLK,DaySeqNo,Depset),
			passevent(Depset,Bus36,CHLK,[from],Day,E)),
    add flag(defaultdest)
ip  default_destination(Bus36,CHLK)
 ):- single.


%%%%%%%%%%%%%%%%%

wakeup1 rule bustrans:(  %%  Just wakeup call notify/1
is  present notify/_/_,
    TIME isa clock,  { bound(TIME)},
    srel/Nil/time/TIME/_, { dmeq([at,nil],Nil)},
    not X isa station when { bound(X)},
    not X isa neighbourhood when { bound(X)},
    not X isa street when { bound(X)}
id  not flag(exit), %% Refraction
    add flag(exit),
    atdate2(_DaySeqNo,DATE),
    addfront notification(DATE,TIME)
ip  set(warningtime, notification(DATE,TIME)) ).



wakeup1sick rule bustrans:(  %%  sick    %% You notify me at 1245
is  present dob/notify/_/_/_,
    TIME isa clock,  { bound(TIME)},
    srel/Nil/time/TIME/_, { dmeq([at,nil],Nil)},
    not X isa station when { bound(X)},
    not X isa neighbourhood when { bound(X)},
    not X isa street when { bound(X)}
id  not flag(exit), %% Refraction
    add flag(exit),
    atdate2(_DaySeqNo,DATE),
    addfront notification(DATE,TIME)
ip  set(warningtime, notification(DATE,TIME)) ).

wakeup2sick rule bustrans:(  %%  sick    %% You notify (me) 1245
is  present dob/notify/_/TIME/_,
    TIME isa clock,  { bound(TIME)},
    not X isa station when { bound(X)},
    not X isa neighbourhood when { bound(X)},
    not X isa street when { bound(X)}
id  not flag(exit), %% Refraction
    add flag(exit),
    atdate2(_DaySeqNo,DATE),
    addfront notification(DATE,TIME)
ip  set(warningtime, notification(DATE,TIME)) ).


wakeup2 rule bustrans:(  %%  Just wakeup send notification
is  present N isa notification,
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
ip  set(warningtime, notification(DATE,TIME)) ).


wakeup3 rule bustrans:(  %% Just wakeup send notification
is  present N isa notification,
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
ip  set(warningtime, notification(DATE,TIME)) ).



%%%% USE CONTEXT SECTION 1 %%%

iwantalaterdeparture  rule bustrans:( %%  Går det en senere buss/avgang
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
  ):- double.


iwantalaterarrival  rule bustrans:( %%  kommer  det en senere buss/ankomst
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
  ):- double.


iwantanearlierarrival  rule bustrans:(  %%  Kommer  det en tidligere buss/ankomst
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
  ):- double.

%%%%  Går det en senere  buss/avgang

iwantanearlierdeparture  rule bustrans:(
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
  ):- double.




askforlaterarrival  rule bustrans:(
is  adj/comp/late/Bus/real,
    present _ isa arrival,
    Bus isa BR,
    (do)/PASS/Bus/_,
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
  ):- double.


askforlaterdeparture  rule bustrans:(
is  adj/comp/late/Bus/real,
    Bus isa BR,
    (do)/PASS/Bus/_,
    not srel/to/place/_/_,
    not srel/from/place/_/_,     %% there ok
    not srel/for/bus/_/_,

    not present srel/after/time/_/_, %% Retention
    add srel/after/time/NewDep/_

id	 not message(not(bus,_)),
    not message(foreign(_)),
    not message(idonotknow),
    not departure(_,_,_,_),
	 not findstations(_,_,_),
    not passesstations(_,_,_,_)



%%%%    not askfor(_, where::departure, _),
%%%%    addfront askfor([], where::departure, _Place)

ip  dmeq(bepass,PASS),
    dmeq(trafficant,BR) ,
    current_frame_getvalue(where )::departure, NewDep)
 :- double.


%%%%  Går det en  tidligere  buss

askforearlierbus  rule bustrans:(
is  adj/comp/early/Bus/real, %%%  /// EARLIER
    Bus isa BR,
    (do)/PASS/Bus/_,
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
  ):- double.




bingothisevening rule bustrans:( %% i kveld %%  Grotesque
is  present  A isa night, srel/in/time/A/_,
    not T isa clock when { (bound(T),T>=1200) }, %% then only "late"
    Bus isa BR,  {dmeq(trafficant,BR)},
    (do)/PASS/Bus/_, {dmeq(bepass,PASS)},
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
    not frame_remember((when)::departure::after,_),
    add frame_remember((when)::departure::after,AfTime)
ip  timenow2(0,TNOW), AfTime is max(TNOW,1800) %% Pragmatic: after now
 )
 :- double.


bingoanotherevening rule bustrans:( %% mandag  kveld
is  present  A isa night, srel/in/time/A/_,
    Bus isa BR,
    (do)/PASS/Bus/_,
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

    not frame_remember((when)::departure::after,_),
    add frame_remember((when)::departure::after,AfTime)

ip  dmeq(bepass,PASS),
    dmeq(trafficant,BR),
    AfTime is 1800
  ):- double.


bingothisafternoon rule bustrans:( %% i ettermiddag
is  present  A isa afternoon, srel/in/time/A/_,
    not present srel/before/time/T/_ when { bound(T) },
    Bus isa BR,
    (do)/PASS/Bus/_,
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

    not frame_remember((when)::departure::after,_),
    add frame_remember((when)::departure::after,AfTime)

ip  dmeq(bepass,PASS),
    dmeq(trafficant,BR),
    timenow2(0,TNOW), AfTime is max(TNOW,1200)  %%  Pragmatic: after now
) :- double.

bingoanotherafternoon rule bustrans:( %% i kveld %% Grotesque
is  present  A isa afternoon, srel/in/time/A/_,
    Bus isa BR,
    (do)/PASS/Bus/_,
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

    not frame_remember((when)::departure::after,_),
    add frame_remember((when)::departure::after,AfTime)

ip  dmeq(bepass,PASS),
    dmeq(trafficant,BR),
    AfTime is 1200
 ):- double.




%%%% jeg vil reise etter kl 1500
bingo rule  bustrans:(%% askforwheredeptimeonly rule
is  present  srel/after/time/DepTime/_,
    Bus isa BR,
    (do)/PASS/Bus/_,
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

    not frame_remember((when)::departure::after,DepTime),
    add frame_remember((when)::departure::after,DepTime)

ip  dmeq(bepass,PASS),
    dmeq(trafficant,BR)
  ):- double.


jaglanddepartnil rule bustrans:(    %%   %% jeg vil reise  kl 1500 ->  før kl 1500
is  present  srel/NILAT/Clock/DepTime/_,
             { number(DepTime),
               dmeq([nil,at],NILAT),
               dmeq([time,clock],Clock)},
    DepTime  isa clock,
    (do)/TRAVELFROM/Bus/_, { dmeq(travelfrom,TRAVELFROM)},
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

    not frame_remember((when)::departure::after,DepTime),
    add frame_remember((when)::departure::after,DepTime)
ip  dmeq(trafficant,BR)
  ):- double.






%%%% jeg vil reise før  kl 1500
bongo rule bustrans:( %% askforwherearrtimeonly rule
is  present  srel/before/time/ArrTime/_,
     Bus isa BR,
    (do)/PASS/Bus/_,
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

    not frame_remember((when)::arrival::before,ArrTime),
    add frame_remember((when)::arrival::before,ArrTime)
ip  dmeq(bepass,PASS),
    dmeq(trafficant,BR)
  ):- double.


jaglandarrivenil rule bustrans:(    %% jeg vil ankomme kl 1500 -> før kl 1500
is  present  srel/NILAT/Clock/DepTime/_,
             {number(DepTime),
              dmeq([nil,at],NILAT),
              dmeq([time,clock],Clock)},
    ArrTime  isa clock,
    (do)/TRAVELTO/Bus/_, { dmeq(travelto,TRAVELTO)},
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

    not frame_remember((when)::arrival::before,ArrTime),
    add frame_remember((when)::arrival::before,ArrTime)
ip  dmeq(trafficant,BR)
  ):- double.




askforwhere rule bustrans:( % PASS Bus (Place is unbound, bus is unknown)
is  Bus isa BR,
    (do)/PASS/Bus/_, { dmeq(bepass,PASS)},
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
  ):- double.


%%%% END OF USE CONTEXT SESSION 1


%%%% SECTION OUR rule bustrans:( (MODIFY SOURCE FROM CONTEXT)


ouraround rule bustrans:(       %%  pretend it is before time
is  context srel/around/time/_Rel/E ,
    present (do)/go/_/E,
    present event/real/E,
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/to/place/NewPlace/E
id  []

%%%%   not askfor(_, where::arrival, _), %% where ???
%%%%   addfront askfor([], where::arrival, NewPlace) %% where ???
ip  current_frame_getvalue(where )::arrival, NewPlace)
 :- double.


ourarrbefore rule bustrans:(
is  context srel/before/time/_Rel/E ,
    present (do)/go/_/E,
    present event/real/E,
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/to/place/NewPlace/E
 id []
%%%%     not askfor(_, where::arrival, _), %% where ???
%%%%     addfront askfor([], where::arrival, NewPlace) %% where ???
ip  current_frame_getvalue(where::arrival, NewPlace)
)
  :-double.


ourwithlastbus rule bustrans:(    %% mimic i kveld
is  context srel/(with)/Bus/F69/E,
    context adj/_/last/F69/_,
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/from/place/NewPlace/E
id  []

ip  dmeq(vehicle,Bus),
    current_frame_getvalue(where::departure, NewPlace)
)
  :-double.

ourwithnextbus rule bustrans:(
is  context srel/(with)/Bus/F69/E,
    context adj/_/Next/F69/_, { dmeq([first,next],Next)},
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/from/place/NewPlace/E
id  []

ip  dmeq(vehicle,Bus),
    current_frame_getvalue(where::departure, NewPlace)
) :- double.

ournextbus rule bustrans:(
is  context adj/_/Next/F69/_, { dmeq([first,next],Next)},
    present F69 isa Bus, { dmeq(vehicle,Bus)},
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/from/place/NewPlace/E
id  []
ip  dmeq(vehicle,Bus),
    current_frame_getvalue(where::departure, NewPlace)
) :- double.


ourjustlastbus rule bustrans:(    %% -> med siste buss
is  context adj/_/last/F69/_,
    present F69 isa Bus, { dmeq(vehicle,Bus)},
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/from/place/NewPlace/E
id  []
ip  current_frame_getvalue(where::departure, NewPlace)
)
  :-double.


ourtonight rule bustrans:(
is  srel/tonight/_Time/nil/E,
    present event/real/E,
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/from/place/NewPlace/E
id  []

ip  current_frame_getvalue(where::departure, NewPlace)
)
    :-double.


ourom rule bustrans:(   %  om to timer, create departure place
is  context srel/after/minute/MM/E,
    context MM isa minute,
    present event/real/E,
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/from/place/NewPlace/E
id  []

ip  number(MM),  %% no spurious  after this time
    current_frame_getvalue(where::departure, NewPlace)
) :- double.

%%%

ourdepearlier rule bustrans:(
is  present  adj/comp/early/_Bus/real, present _ isa departure,
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/from/place/NewPlace/E
id  []

ip   current_frame_getvalue(where::departure, NewPlace)
)    :-double.

ourarrearlier1 rule bustrans:(
is  present  adj/comp/early/_Bus/real ,
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/to/place/NewPlace/E
id  []

ip  current_frame_getvalue(where::arrival, NewPlace)
)    :-double.

ourarrearlier2 rule bustrans:(
is  present srel/earlier/time/nil/_, % i go earlier
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/to/place/NewPlace/E
id  []

ip   current_frame_getvalue(where::arrival, NewPlace)
)    :-double.

ourarrlater rule bustrans:(
is  present  adj/comp/late/_Bus/real, present _ isa arrival,
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/to/place/NewPlace/E
id  []
%%%% not askfor(_, where::arrival, _), %% where ???
%%%% addfront askfor([], where::arrival, NewPlace) %% where ???
ip   current_frame_getvalue(where::arrival, NewPlace)
)    :-double.



ourdeplater rule bustrans:(
is  present  adj/comp/late/_Bus/real, %% default departure
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/from/place/NewPlace/E
id  []

ip   current_frame_getvalue(where::departure, NewPlace)
)    :-double.


ourigobefore rule bustrans:(
is  present  srel/beforethat/time/nil/_, %% default departure
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/to/place/NewPlace/E
id  []

ip  current_frame_getvalue(where::arrival, NewPlace)
)    :-double.


ourigolater rule bustrans:(
is  present  srel/thereafter/time/nil/_, %% default departure
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    not present srel/from/place/_/E,        %% retention
    add srel/from/place/NewPlace/E          %% retention
id []
ip  current_frame_getvalue(where::departure, NewPlace) %%    newcontext2.pl NEW
)    :-double.


ourdepafter rule bustrans:(
is  context srel/after/time/Rel/E,
    present event/real/E,
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/from/place/NewPlace/E
id  []
ip  number(Rel),  %% no spurious  after this time
    current_frame_getvalue(where::departure, NewPlace)
) :- double.

ournilafter2 rule   bustrans:(    %% FIX rule in connection with standardclock
is  context srel/nil/time/Rel/E,
    present (do)/go/_/E,
    present event/real/E,
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/from/place/NewPlace/E
id  []
ip  number(Rel),
    current_frame_getvalue(where::departure, NewPlace)
)
 :- double.

ourafternow rule bustrans:(
is  context srel/Now/time/nil/E, { dmeq([now,hereafter],Now)},
    present (do)/go/_/E,
    present event/real/E,
    not srel/_/place/_/E,
    not srel/_/neighbourhood/_/E,
    not srel/_/station/_/E,
    add srel/from/place/NewPlace/E
id  []
ip  current_frame_getvalue(where::departure, NewPlace)
    )
            :- double.


%%%% END OUR SECTION




%%%%%%%% Start MustKnow Section


mustknowplace0  rule bustrans:(  %% Går Buss 8 ?
is  Bus isa Veh,
       %% {bound(Bus)} , %% TA-110118
       %% Dropped for humoristic effect: kan jeg få en suss

       {dmeq(busdeparrtime,Veh)},  %% select a known   bus
    present (do)/Go/Bus/_E,
        {dmeq([arrive,depart,give,pass,go,leave,be1,exist,stop],Go)}, %% give me the time

    not present ( _ isa week), %% TA-110203 %% hvilken uke er ...
    not present  PP isa place when { unbound(PP) }, %% where -> unbound

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
%    add flag(fail)     %%  "det er ikke mulig natt til søndag"
ip	 [] ).


mustknowplace7 rule bustrans:(        %% Jeg er på et sted
is  (do)/be1/X/E ,

%%%% X isa Mov,  {i_or_a_bus(X,Mov,_)}.  %% TA-110314
    not _ isa application,   %% facetious %% TA-110724
    not present X isa clock, %% hva er klokken ....
    not srel/in/place/_/E,   %% hvor er ...
    not srel/on/_Veh/_/E,    %% hvor er ...
    not present _ isa place,
    not present _ isa meaning,
    not present _ isa mood,
    not present _ isa answer,
    not present _ isa duration,
    not present _ isa feeling,
    not present _ isa mind, %% consciousness,
    not present _ isa life,
    not present _ isa information,
    not present U isa neighbourhood when {bound(U)},%% TA-110314
    not present V isa station when {bound(V)},
    not present _ isa webaddress,
    not present _ isa program,
    not present equal/_/_,           %% er voll en buss
    not present dob/be/_/_/_,
    not _ isa ticket,
    not _ isa company,
    not dob/be_named/_/_/_,
    not present adj/_/_/_/_
id  not departure(_,_,_,_),          %% gives an extra go
    not ticketprice2(_,_),
    not passesstations(_,_,_,_), %% TA-110527
    not message(_),
    addcon message(mustknow(place))
ip  [] ). %% i_or_a_bus(X,Mov,_). %% TA-110314


mustknowplace8 rule bustrans:( % bus has time (Place is unbound, bus is unknown)
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
ip	 dmeq(bus,BR),  unbound(Bus) ).



mustknowplace10 rule bustrans:(
is  not explain,
    %% I isa self, %% may disappear, I isa self occcurs 1 %% TA-110329
                   %% hvilke rute skal jeg ta hvis jeg skal komme til sentrum.
    (do)/Go/_I/_,
        {dmeq([go,come,get,arrive,depart],Go)}, %% \+ be1 %% TA-110622
    not (do)/live/_/_, %% leve | bo ? %% TA-100921
    not _ isa company,
    not srel/_/place/_/_ ,
    not present _ isa information,  %% Ad Hoc
    not present ( _ isa week), %% TA-110203 %% hvilken uke er ...
    not present srel/on/language/_/_,   %% TA-110331 ? :-) %% hva heter .. på engelsk

    %%     not present _ isa street      %%
    not present _ isa station,       %% TA-110510
    not present _ isa neighbourhood  %%

id  not departure(_,_,_,_),        %% gives an extra go
    not message(nearest_station(_ST,_,_Unknown)),
    not message(stationsat(_,_,_)), %% TA-110504
    not message(mustknow(_)),
    not message(mustknowanother(_)),
    not message(sameplace(_,_)),
    not message(onlyonesentence),
    not message(onlyonething),       %% may give spurious errors
    not message(date_day_route(_,_)),
    not flag(exit),     %% Skip this rule if exit is already set. 
    addcon message(mustknow(place))
ip  [] ).  %% TA-110329


mustknowplace11 rule bustrans:(  %% sick
is  exactly (which(A),quant(_,A),A isa Bus)
id  addcon message(mustknow(place))
ip  dmeq(vehicle,Bus) ).


mustknowplace12 rule bustrans:(  %% fortell meg om bussavganger
is  (do),tuc isa savant,tell/tuc/_B/C,
    srel/about/thing/A/C, A isa Dep, {unbound(A)},
    {dmeq(busdeparr,Dep)}
id  addcon message(mustknow(place))
ip  [] ).

mustknowplace13  rule bustrans:( %% kan du svare/fortelle om bussen går
is  test,tuc isa savant,A isa coevent,B isa bus,dob/Tell/tuc/A/_,(do)/go/B/_,
        {dmeq([tell,answer1],Tell)}
id  addcon message(mustknow(place))
ip  [] ).


mustknowplaceshow rule bustrans:(
is  dob/show/tuc/Y/_, Y isa Z,
    not (X isa station) when { bound(X) },
    not (X isa neighbourhood) when { bound(X) },
    not (present X isa street) when { bound(X) }
id  not flag(exit),
    addcon message(mustknow(place))
ip  dmeq(vehicle,Z) ).


dobusrun rule bustrans:( %%  kjører busser
is  test,
    (do)/Go/_/D, {dmeq([stop,go,pass],Go)},

    not srel/well/(mode)/nil/D, %% gå bra :-)   %% TA-101228
    not _ isa company,
    not _ isa person, %% etc                   %% TA-100828
    not _ isa cinema, %% TA-100902
    not present (X isa bus) when {bound(X)},
    not present (X isa route) when {bound(X)},
    not present _ isa telephone,
    not dob/tell/'I'/_/_ , %% Hva var det forrige jeg sa?
    not (X isa station) when { bound(X)},
    not (X isa neighbourhood) when  {bound(X)},
    not (present X isa street) when { bound(X)},
    not  (do)/go/tuc/_, %% hvor skal du %% ?
    not  (do)/live/_/_
id  not flag(exit),
    not message(mustknow(place)), %% kan jeg få en buss
    not findstations(_,_,_),
    not departure(_,_,_,_),
    not message(summerishere),
    not message(winterishere),
    not message(mustknowanother(place)),
    addcon message(mustknow(bus))
ip  [] ).

mustknowbus99 rule bustrans:( %%  hvor stopper bussen ->
is  which(A),
    A isa place,
			  present (do)/Go/_/_,
                      {dmeq([stop,go,pass,run],Go)}, %% TA-110308
    not _ isa company,
    not _ isa person, %% etc                   %% TA-100828
    not _ isa cinema, %% TA-100902
    not present (X isa bus) when {bound(X)},   %%
    not present (X isa route) when {bound(X)}, %%
    not present _ isa telephone,
    not dob/tell/'I'/_/_ , %% Hva var det forrige jeg sa?
    not (X isa station) when { bound(X)},
    not (X isa neighbourhood) when  {bound(X)},
    not (present X isa street) when { bound(X)},
%%     not  (do)/go/tuc/_, %% hvor skal du %% ?  hvor kjører du %% TA-110308
    not  (do)/live/_/_
id  not flag(exit),
    not findstations(_,_,_),
    not departure(_,_,_,_),
    not message(summerishere),
    not message(winterishere),
    not message(mustknowanother(place)),
    addcon message(mustknow(bus))
ip  [] ).


mustknowplace99 rule bustrans:(
is     _Y isa Z, {dmeq(busdeparr,Z)}, %% NOT 'I'
    not srel/in/vehicle/_/_,          %%  ad hoc
    not srel/on/vehicle/_/_,          %%
    not present dob/own/_/_/_,
    not present dob/pay/'I'/_/_,
    not present _ isa telephone,
    not dob/tell/'I'/_/_ , %% Hva var det forrige jeg sa?
    not (X isa station) when {bound(X)},
    not (X isa neighbourhood) when  {bound(X)},
    not (present X isa street) when { bound(X)},
    not (X isa endstation) when  {bound(X)},
    not (X isa place ) when  {unbound(X)} %%%% HVOR

id  not flag(exit),
    not message(noinfoabout(_Cleaning)),
    not message(mustknow(place)),
    not endstations(_,_),  %%  Not message
    not message(mustknow(bus)),
    not findstations(_,_,_),
    not departure(_,_,_,_),
    not message(otherperiod(_)),
    not message(summerishere),
    not message(winterishere),

    add message(mustknow(place))
    %% add flag(exit) %% no trytofool
ip  [] ).


warnmustknowplace1 rule bustrans:(
is  present notify/_/_, % without prewarningtime
    not X isa station when { bound(X) },
    not X isa neighbourhood when { bound(X) },
    not X isa street when { bound(X) }
id  not flag(exit),
    not message(mustknow(place)),
    add message(mustknow(place)),
    add flag(exit)
ip  [] ). %% set(warningflag,false).
        %% -> comes up again by :warningflag3


warnmustknowplace3 rule bustrans:(
is  present F4 isa notification,
    Send/tuc/F4/_, {dmeq([send,give],Send)},
    not X isa station when { bound(X) },
    not X isa neighbourhood when { bound(X) },
    not X isa street when { bound(X) }
id  not flag(exit),
    not message(mustknow(place)),
    add message(mustknow(place)),
    add flag(exit)
ip  set(warningflag,false) ).


istand rule bustrans:( %% jeg står på X -> jeg går fra X
is  context    (I isa self, event/real/A),
    replaceall (STAND/I/A, srel/on/place/P/A)
    with       ((do)/go/I/A, srel/from/place/P/A)
id  []
ip  dmeq(stand,STAND)
  ):- double.


beforemodifier rule bustrans:(
is  not _I isa self,
    replace (srel/REL/time/Cl/A,Cl isa clock,event/real/A)
    with ('I' isa self, srel/REL/time/Cl/A,Cl isa clock, (do)/be1/'I'/A, event/real/A)
id  []
ip  dmeq(timeprep, REL)
  ):- double.


mustknowbus0  rule bustrans:( % Which station exists
is  exactly (which(A),A isa station,(do)/exist/A/E,event/real/E)
id	 add	message(mustknow(bus))
ip  [] ).


mustknowbusyou rule bustrans:( % Where do you (qua bus)   go
is  which(A),A isa place,srel/_InAt/place/A/C,T  isa program, (do)/GO/T/C,event/real/C,
        {dmeq([go,leave,stop,run],GO)}
id	 add	message(mustknow(bus))
ip  [] ).


mustknowbustest rule bustrans:( % does the buses go
is  test, B isa Veh, {unbound(B)},
    event/real/C,  (do)/GO/B/C,
         {dmeq([go,leave,stop,be1],GO)},
         {dmeq([vehicle,bus,tram,program,route],Veh)},
%%     not  present X isa clock when { bound(X) },
    not present  srel/_/vehicle/_/_,
    not  present T isa bus when { bound(T) },
    not  present Y isa neighbourhood  when { bound(Y) },
    not  present Z isa station  when { bound(Z) }
id	 add	message(mustknow(Veh))
ip  [] ).


mustknowbusnewgen rule bustrans:( %  the buses go
is  new, B isa Veh, {unbound(B)},  {dmeq([vehicle,bus,tram,program,route],Veh)},
    event/_Real/C,  (do)/GO/B/C, %% jeg tror at bussen går
         {dmeq([go,leave,stop,be1],GO)},
%%     not  present X isa clock when { bound(X) },
    not  present T isa route when { bound(T) },
    not  present T isa bus when { bound(T) },
    not  present Y isa neighbourhood  when { bound(Y) },
    not  present Z isa station  when { bound(Z) },
    not  present Z isa street  when { bound(Z) }
id	 not flag(exit), %% TA-110401
    not  message(mustknow(place)),
    add	message(mustknow(route))  %% \+ kjøretøy
ip  [] ).



mustknowbus1 rule bustrans:( % Where does the bus go
is  exactly (which(A),A isa place,srel/_InAt/place/A/C,B isa Veh,(do)/GO/B/C,event/real/C)
id	 add	message(mustknow(Veh))
ip  dmeq([go,leave,stop,be1],GO),
    unbound(B),
    dmeq([vehicle,bus,tram,program],Veh) ). %% du qua Team


mustknowbus2 rule bustrans:( %% PLASS Which places between ( NO BUS)
is  which(Place),Place isa Placoid,(do)/be1/Place/A,
    srel/from/place/_FromPlace/A, srel/to/place/_ToPlace/A
id  add ( message(mustknow(bus)))
ip	 unbound(Place),
    dmeq([place,station,neighbourhood],Placoid) ).


%%%%%%%% End MustKnow Section %%%%%%%%%%%%%%%%%%

turings  rule bustrans:(  %% :-) %% ville du bestå Turings test ?
is  test,turing isa man,
    tuc isa savant,F55 isa test,
    dob/Manage/tuc/F55/F66, {dmeq([manage,pass],Manage)},
    event/real/F66,
    has/man/test/turing/F55,
    clear
id  add message(cannotanswermyself),
    add flag(exit)
ip  [] ).



gowhere rule bustrans:(  %%
is  not present srel/to/place/_/_,    %% (street)
    not srel/from/place/_/_,  %% passerer maskinagentur på vei fra torget.
    not present  (do)/arrive/_/_, %% <--- derived skal være i
%%    not present srel/on/place/_/_     %% assume direction is handled
    not has/vehicle/station/_/_,
    not srel/beyond/place/_/_   %% ad hoc
%%%%     not present _ isa person %% svensker på risvollan :-) %% ???
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
    not departure(_,st_olavs_gate,_,_),  %% Dirty
    not findstations(_,_,_),
    not message(mustknow(place)),
    not message(mustknowanother(place)),
    not message(sameplace(_,_)),
    not message(onlyonesentence),
    clear,
    add message(mustknowanother(place)),
    add flag(exit)
ip  []
     ):- single.



norouteinfonomessage rule bustrans:(  %% Force negative answer response if no other message
is  %%%%%%%%%%%%%%%%%  not present new, %%%  ==> \+ jeg vet ikke %% TA-101015 du hater meg
    not present has/agent/information/tuc/_, %% -> NO
    not present adj/_/ordinary/_/_,
    not present srel/regularly/time/_/_
id  not flag(exit),
    not message( M ) or M == nearest_station(_,_,_,_),  %% 22. mars (påskeaften) missing negans
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
    not present true,  %% TA-100927
    not present false  %%
ip  []
   ):-single.



norouteinfo rule bustrans:(  %%
is  %% not present dob/give/_/_/_, %% give me the times
    not present has/agent/information/tuc/_, %% -> NO
    not present adj/_/ordinary/_/_,
    not present srel/regularly/time/_/_

id  not flag(exit),
    add  flag(exit),     %% retention

    not  ticketprice2(_,_),

    not listofall( bus, _ ),
    not departure( _, _, _, _ ),
    not message( date_isa_day(_,_) ),
    not findstations(_,_,_),
    not timeis(_),
     not message( answer(_) ),     %%  then tuc knows

   % not message( webstatistics ),
    not message( noinfoabout(irregularity) ),
    not message( mustknow(bus) ),
    not message( mustknow(place) ),
    not message( howtuchelp ),
    not stationsat( _, _, _ ),

    removeif message( date_isa_day(_,_) ), %% er det søndagsruter idag
    removeif message( otherperiod(_) ),
    removeif message( date_day_route(_,_) ),

    not flag(fail),
    add flag(fail) %% needed as retention       %%%%   <-- Kills messages

ip  []
   ) :- single.

missingconnection rule bustrans:(  %% insist on having a connection
is  not present has/agent/information/tuc/_, %% -> NO
    not present adj/_/ordinary/_/_,
    not present srel/regularly/time/_/_
%%%%     not present _ isa person %% svensker på risvollan ? % en passasjer tok sin   buss * til byen.
id  departure(_,_,_,_),
%%     not flag(nightbusflag), %% allow general message %% N:136.

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
%%%%     add flag(fail) %% avoid  cannot answer
ip  []
     ):-single.



%%%%%%%%%%%%%%%%%%%%%

fledsbo8 rule bustrans:( %% %%  Sort out the unknown depsets:We don't know if it's to or from. Hence, it's unknown...
is []
id present departure(_,_,_,Depset1),
   not depset(_, _),
   add depset(unknown, [Depset1])
ip []
 ):-double.



fledsbonilplaceafter rule bustrans:( %% Lerkendal after 1200, check frames = departure, guess to
is      []
id      not depset(to, _),
        present keepafter(_, X, _),
        replace depset(unknown, List)
        with depset(to, List)
ip   %%    value(dialog,1),
        frame_getvalue(where::departure,_,place),
    \+  frame_getvalue(where::arrival,_,place),
        varmember(X, List)
                     ) :- double.


fledsbo12 rule bustrans:( %% If keepafter, we guess from
is      []
id      not depset(from, _),
        replace depset(unknown, List)
        with depset(from, List),
        present keepafter(_, X, _)
ip      varmember(X, List)
 ):-double.


fledsbo131 rule bustrans:( %% If keepbefore1, we guess to
is      []
id      not depset(to, _),
        replace depset(unknown, List)
        with depset(to, List),
        present keepbefore1(_, X, _)
ip      varmember(X, List)
 ):-double.


fledsbo13 rule bustrans:( %% If keepbefore, we guess to
is      []
id      not depset(to, _),
        replace depset(unknown, List)
        with depset(to, List),
        present keepbefore(_, X, _)
ip      varmember(X, List)
 ):-double.

fledsboaround rule bustrans:( %% This was already in buslog, but it makes it hard for makeframe.
is      []
id      replace keeparound(Time, R, Rny)
        with keepbetween(LowTime,HighTime,R,Rny)
ip      subfromtime(Time,14,LowTime),
        addtotime(Time,14,HighTime)
 ):-double.

fledsbowithin rule bustrans:(
is      []
id      replace keepwithin(Time,Mins,R,Rny)
        with keepbetween(Time,NewTime,R,Rny)
ip      addtotime(Time,Mins,NewTime)
 ):-double.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% NEGANS section %% TA-101014

trytofooltestisa rule bustrans:(
is  test,
    X isa XFrog,{ negans:trytofool(test,X isa XFrog,Delphi)} %% TA-110111
id  flag(fail),
    add message(Delphi)
ip  [] ).

trytofooltestslash rule bustrans:(
is  test,
    Toad/Frog,{ negans:trytofool(test,Toad/Frog,Delphi)}
id  flag(fail),
    add message(Delphi)
ip  [] ).

/* Unnec   cannit answer
trytofoolexplainslash rule bustrans:( %% TA-110518
is  explain,
    Toad/Frog,{ negans:trytofool(test,Toad/Frog,Delphi)}
id  flag(fail),
    add message(Delphi)
ip  [] ).
*/


trytofoolnewisa rule bustrans:(
is  new,
    X isa XFrog,{ negans:trytofool(new,X isa XFrog,Delphi)} %% TA-110111
id  flag(fail),
    add message(Delphi)
ip  [] ).

trytofoolnewslash rule bustrans:(
is  new,
    Toad/Frog,{ negans:trytofool(new,Toad/Frog,Delphi)}
id  flag(fail),
    add message(Delphi)
ip  [] ).


trytofooldoisa rule bustrans:(
is  (do),
    X isa XFrog,{ negans:trytofool((do),X isa XFrog,Delphi)} %% TA-110111
id  flag(fail),
    add message(Delphi)
ip  [] ).

trytofooldoslash rule bustrans:(
is  (do),
    Toad/Frog,{ negans:trytofool((do),Toad/Frog,Delphi)}
id  flag(fail),
    add message(Delphi)
ip  [] ).


trytofoolwhichisa rule bustrans:(
is  which(_),
    X isa XFrog,{ negans:trytofool(which, X isa XFrog,Delphi)} %% TA-110111
id  flag(fail),
    add message(Delphi)
ip  [] ).

trytofoolwhichslash rule bustrans:(
is  which(_),
    Toad/Frog,{ negans:trytofool(which,Toad/Frog,Delphi)}
id  flag(fail),
    add message(Delphi)
ip  [] ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                 %
%  This file is already too big to maintain for any sane person.  %
%  It must under no circumstances exceed  16000 lines.            %
