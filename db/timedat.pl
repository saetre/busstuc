/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE timedat.pl
%% SYSTEM BUSSTUC
%% AUTHOR J.Bratseth
%% CREATED TA-110207
%% REVISED TA-110207    RS-130327

%% Time data for bus routes in general
:-module( timedat, [ after_morning/1, aroundmargin/1, before_morning/1, buslogtimeout/1, clock_delay/3, create_named_dates/0, dedicated_date/1, 
                    %% Dedicated Date Example 22.10 not clock if 22.10 is date of new route tables
        defaultprewarningtime/1, delay_margin/1, kindofday/2, maxarrivalslack/1,      % unacceptably long  exchange waitingtime
        maxtraveltime/1,        %% 100 MINUTES in Trondheim %% fra Vestlia til Jonsvatnet kl. 14.30? %%  1258 ->  1430
        morning_break/1,        named_date/2,        orig_named_date/2,      softime/3,               %% These times are implicit and shall not be VERIFIED in answers
        verify_movedates/0      %% When does morning start?
] ).

%:- meta_predicate  for(0,0). % for/2. Stay inside the CALLING module? %% RS-141029
%:- meta_predicate  remember(0) .        %% RS-140928 Remember the facts IN THE MODULE THAT CALLS REMEMBER! Use  :  or  0

% Domains:   BOOLEAN ROUTETYPE STATION PLACE MINUTES
%            DATE DAY DOMAIN CLOCK

%:- ensure_loaded( user:'../declare' ). %, [ := /2 etc. ] ).  %% RS-131117 includes declare.pl
:- use_module( '../declare', [ remember/1 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .
:- use_module( '../sicstus4compatibility', [ output/1 ] ).  %% Compatible with sicstus4, get0/1 etc.

:- use_module( '../utility/utility', [ for/2 ] ).  %%  used in forall instead of utility:for/2. % Moved to declare.pl
:- use_module( '../utility/datecalc.pl', [ add_days/3, easterdate/2, sub_days/3, this_year/1, todaysdate/1 ]).  %% RS-121325 Contains the utility predicates that has to do with dates
%:- use_module( '../utility/writeout.pl', [ output/1 ] ). % out/1, Not used  %% RS-141029

%% :-use_module( '../utility/library.pl' ).        %% for: uses orig_named_date %% KISS %% RS-131230
%:-use_module( library(aggregate), [ foral/2 ] ). %% KISS %% RS-140914    %% RS-141029  for-all Does NOT work like utility:for/2


%% List of volatile/dynamic predicates (named_date includes all orig_named_date and Holidays)
:- volatile named_date/2. %% Created Initially, not stored in save_program
:- dynamic named_date/2. %% Created Initially,  redefined with remember(day_map) below

create_named_dates :-
    list_of_named_dates( L ),
    for( ( member(A,L), orig_named_date(A,B) ),
          remember( named_date(A,B) )          % remember( timedat:named_date(A,B) )
    ), %% To be     refined
    verify_movedates. % verify_dates (that change every year)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%remember( Module:F ) :- Module:F, ! ; assert( Module:F ).        %% Add F it is does not already exist.
% remember( Module:F ) :- out( 'timedat:remember/1 => Something went wrong with:'), out( Module:F ), (call( Module:F ) -> output( 'true' ) ; output( false )).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% meta_predicate  for(0,0). % for/2. Stay inside the CALLING module? %% RS-141029
%for( P, Q ) :- %% For all P, do Q (with part of P). Finally succeed
%  P, Q, false ; true.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%  TIME  SECTION %%%%%%%%%%%%%%%%%

clock_delay(00,00,00). %%  FOR ABNORMAL SERVER TIME ERROR, CLOCK ADJUSTMENT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BEGIN  CRITICAL SECTION 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% DATES THAT MUST BE CHECKED ON EACH NEW ROUTE PLAN

                            

% orig_named_date is defined here, and later recreated as named_date

list_of_named_dates( [
    new_years_eve,
    new_years_day,

    palm_sunday,
    palm_monday,
    palm_tuesday,
    palm_wednesday,
    maundy_thursday,
    good_friday,
    easter_eve,
    easterday,
    easterday2,
    ascension_day,
    whitsun_eve,
    whitsun_day, 
    whitsun_day2, 

    may1,    
    may17,      

%   vernal_equinox, 
%   autumnal_equinox, 
%   summer_solstice,
%   winter_solstice,

    midsummer_eve, 
    midsummer_day, 

    little_christmas_eve,
    christmas_eve,

    christmas_day, %% TA-100122
    christmas_day2, %% RS-151219
    christmas_day3, %% RS-151219
    christmas_day4, %% RS-151219
    christmas_day5, %% RS-151219
    christmas_day6, %% RS-151219

    john_f_kennedy_day, 
    oddvar_brå_day, 
    arvid_holme_day, 
    dooms_day]).



%%% DATES NAMED BY EVENTS  :-)

orig_named_date(john_f_kennedy_day, date(1963,11,22) ).  
orig_named_date(oddvar_brå_day,     date(1982,02,25) ).  
orig_named_date(arvid_holme_day,    date(2011,01,17) ).  
orig_named_date(dooms_day,          date(2012,12,21) ). %% :-) %% TA-100323|      date(10000,01,01)). 

%% Named dates ( Ordered Chronologically within a year ). %% RS-151219

orig_named_date( easterday,    ED ):- %% datecalc
    this_year(YYYY),
    easterdate(YYYY,ED).

orig_named_date( palm_sunday, ND ) :- 
    this_year(YYYY),
    easterdate(YYYY,ED),
    sub_days(ED,7, ND).

orig_named_date( palm_monday,   ND ) :- %% Pro forma
    this_year(YYYY),
    easterdate(YYYY,ED),
    sub_days(ED,6, ND).

orig_named_date( palm_tuesday,  ND ) :- %% Pro forma
    this_year(YYYY),
    easterdate(YYYY,ED),
    sub_days(ED,5, ND).

orig_named_date( palm_wednesday,   ND ) :- 
    this_year(YYYY),
    easterdate(YYYY,ED),
    sub_days(ED,4, ND).

orig_named_date( maundy_thursday,   ND ) :- %% skjærT NOT monday  
    this_year(YYYY),
    easterdate(YYYY,ED),
    sub_days(ED,3, ND).

orig_named_date( good_friday,    ND ) :-
    this_year(YYYY),
    easterdate(YYYY,ED),
    sub_days(ED,2, ND).

orig_named_date( easter_eve,    ND ) :-    
    this_year(YYYY),
    easterdate(YYYY,ED),
    sub_days(ED,1, ND).

orig_named_date( easterday2,     ND ) :- %% 2. påskedag 
    this_year(YYYY),
    easterdate(YYYY,ED),
    add_days(ED,1, ND).

orig_named_date( ascension_day,   ND ) :- %% Krhf 
    this_year(YYYY),
    easterdate(YYYY,ED),
    add_days(ED,39,ND).


orig_named_date( whitsun_eve, ND ) :-    %% pinseaften
    this_year(YYYY),
    easterdate(YYYY,ED),
    add_days(ED,48,ND).

orig_named_date( whitsun_day,   ND ) :-   %% pinsedag
    this_year(YYYY),
    easterdate(YYYY,ED),
    add_days(ED,49,ND).

orig_named_date( whitsun_day2,  ND ) :-       %% 2. pinsedag
    this_year(YYYY),
    easterdate(YYYY,ED),
    add_days(ED,50,ND).

%% orig_named_date(vernal_equinox,    date(YYYY,03,21)):- this_year(YYYY). 
%% orig_named_date(autumnal_equinox,  date(YYYY,09,21)):- this_year(YYYY).

orig_named_date( may1,              date(YYYY,05,01)) :- this_year(YYYY). 

orig_named_date( may17,             date(YYYY,05,17)) :- this_year(YYYY).

orig_named_date( midsummer_eve,     date(YYYY,06,23)) :- this_year(YYYY). 
orig_named_date( midsummer_day,     date(YYYY,06,24)) :- this_year(YYYY).


orig_named_date( little_christmas_eve, date(YYYY,12,23) ) :- this_year(YYYY).

orig_named_date( christmas_eve,     date(YYYY,12,24) ) :- this_year(YYYY).
orig_named_date( christmas_day,     date(YYYY,12,25) ) :- this_year(YYYY).
orig_named_date( christmas_day2,     date(YYYY,12,26) ) :- this_year(YYYY).
orig_named_date( christmas_day3,     date(YYYY,12,27) ) :- this_year(YYYY).
orig_named_date( christmas_day4,     date(YYYY,12,28) ) :- this_year(YYYY).
orig_named_date( christmas_day5,     date(YYYY,12,29) ) :- this_year(YYYY).
orig_named_date( christmas_day6,     date(YYYY,12,30) ) :- this_year(YYYY).

orig_named_date( new_years_eve, date(YYYY,12,31) ) :- %% Nyttårsaften& januar  -> i fjor
     todaysdate(date(YYY1,01,_)),
     YYYY is YYY1 -1,
     !.
orig_named_date( new_years_eve,date(YYYY,12,31) ) :- %% Nyttårsaften i år
     this_year(YYYY),
     !.

orig_named_date( new_years_day, date(YYYY,01,01) ) :- %% january -> this year
    todaysdate( date(YYYY,01,_) ),
    !.
orig_named_date( new_years_day, date(YYY1,01,01) ) :- %% all other todays date -> next year (january)
     this_year(YYYY),
     YYY1 is YYYY+1,
     !.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% END OF CRITICAL SECTION 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%% Dedicated Date
%% Example   22.10 not clock if 22.10 is date of new route tables

%% dedicated_date(date(YYYY,05,17)):- this_year(YYYY). %% Suspended ved gløshaugen før 17.05 
dedicated_date( date(YYYY,12,24) ) :- this_year(YYYY).

%% dedicated_date(date(2006,06,19)). %% Check %% summer route




%% SOFT TIME LIMITS 

%% These times are implicit and shall not be VERIFIED in answers

softime(morning,0430,1200).
softime(prenoon,0900,1200).
softime(afternoon,1200,1800).
softime(evening,1800,2400).
softime(night,1800,2400).
softime(midnight,2400,2500).


%% TIME PARAMETERS 

%% Max travel time  100  MINUTES  in Trondheim

%% hvordan komme fra Vestlia til Jonsvatnet kl. 14.30? 
%%  1258 ->  1430

%% maxtraveltime(90). 
 
maxtraveltime(100).

%% MAX 60 minutes  Arrival Slack

maxarrivalslack(60).  % unacceptably long  exchange waitingtime



%% Max milliseconds  route  computing time


buslogtimeout(10000) . %% Bloody Test 
    % 10  seconds necessary ( usually for connections)
    % however, www.idi.ntnu.no (uranus) is SLOW.


%% morning break  %% Time dividing nightbus from ordinary bus 

morning_break(0430). 

before_morning(T):-number(T),morning_break(MB),T < MB. 
after_morning(T):- number(T),morning_break(MB),T > MB.


%% AroundMargin    Around a clock means clock +- AroundMargin


aroundmargin(20). %% 

%  Bus around 2300  , don't miss 2240 if that is the last
%  bussrute 49 rundt klokka 14 på søndag.Buss 49 passerer  Munkegt M2 kl. 1320
%  og   C Schjetnans vei kl. 1339. <-- missed that

%% Minimum  minutes for bus transfer

delay_margin(5). % min time between transfer %%  (Jfr. O.Misfjord)

%%% EXPERIMENT


%% Default pre warning time

defaultprewarningtime(15). %% minutes

%% Multidefined names that shall not be flagged

%%   station = noun(station)+ names railway + stasjon station  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kindofday(monday,workday). 
kindofday(tuesday,workday).
kindofday(wednesday,workday).
kindofday(thursday,workday).
kindofday(friday,workday).

kindofday(saturday,saturday).
kindofday(sunday,sunday).

kindofday(workday,workday). 
kindofday(holiday,holiday).

kindofday(easter_eve,easter_eve).
kindofday(easterhol,easterhol). 


%%%%%%%%% END OF TIME  SECTION %%%%%%%%%%%%%%%%%%%%%%%%%%


%% FILE consistent_dates.pl
%% SYSTEM BUSSTUC
%% CREATED TA-050504
%% REVISED TA-050504

%% Verify that all movable holidays are included, and internally consistent
verify_movedates :-
   ver_movedate,
   ! ; ( nl, output('***** The moving holidays are inconsistent *****'), nl ).


%VERIFY
ver_movedate :-    %% Added check for May17 %% TA-100106

   this_year(YYYY),

   easterdate(YYYY, Easterday ),
   named_date(easterday, Easterday ),

   sub_days( Easterday,1,Eastereve),
   named_date(easter_eve,Eastereve),


   sub_days( Easterday,2,Good_friday),
   named_date(good_friday,Good_friday),

   sub_days( Easterday,3,Maundy_thursday),
   named_date(maundy_thursday,Maundy_thursday),


   sub_days( Easterday,7,Palm_sunday),  
   named_date(palm_sunday,  Palm_sunday),


   add_days( Easterday,1,Easterday2), 

   named_date(easterday2,Easterday2),

   add_days(Easterday,39,Ascension_day), %% TA-080107 % Bibl. 40th

   named_date(ascension_day,Ascension_day),

% If Ascension day falls on May1, then daycode is sunday anyway %% TA-080108
% If Ascension day falls on May17, then daycode is not Sunday

    named_date(may17,May17),   

   (  Ascension_day = May17  ->  _Sunday=holiday  ;  _Sunday=sunday ),


   add_days(Easterday,48,      Whitsun_eve), %% TA-080108
   named_date(whitsun_eve,Whitsun_eve),

   add_days(Easterday,49,Whitsun_day), %% Bibl 50, Pentecost
   named_date(whitsun_day,Whitsun_day).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% END OF consistent_dates.pl
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%hours_delay(0).    %% Time in Trondheim is 0 hours more than server clock. Moved to busdat (local) module
% hours_delay(-9). %% Time in Santa Barbara  is 9 hours EARLIER than server clock
% hours_delay(7). %% Time in  Tokyo (Sommer?)
% hours_delay(8). %% Time in  Tokyo (Vinter?)
% hours_delay(10). %% Time in  Australia (?)


%%% END TIME SECTION

