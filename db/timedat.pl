%% FILE timedat.pl
%% SYSTEM BUSSTUC
%% AUTHOR J.Bratseth
%% CREATED TA-010207
%% REVISED TA-110207

%% Time data for bus routes in general

% Domains:   BOOLEAN ROUTETYPE STATION PLACE MINUTES
%            DATE DAY DOMAIN CLOCK

:- module( timedat, [
        after_morning/1,        aroundmargin/1,            % (MINUTES)
        before_morning/1,       buslogtimeout/1,           % (MILLISEC)
        clock_delay/3,          create_named_dates/0,
        date_day_map/2,         % (DATE,DAY)
        dedicated_date/1,       % (DATE)
        defaultprewarningtime/1,        delay_margin/1,    % (MINUTES)
        hours_delay/1,
        kindofday/2,            % (DAY,DAY)
        maxnumberofindividualdepartures/1,    % (NUMBER)
        maxtraveltime/1,        % (MINUTES)
        maxarrivalslack/1,      % (MINUTES)
        morning_break/1,        % (CLOCK) 
        named_date/2,           % (NAME)
        orig_named_date/2,
        softime/3,                 % (NAME,CLOCK,CLOCK)
        this_year/1,
        todaysdate/1,           %% Exported as timedat:pred from datecalc.pl

        %% FROM makeauxtables %%
        busstat0/2,             
        statbus0/2,  %  tostationonly0/1,
        toredef0/3,  torehash0/2, %  transbuslist0/3, 
        %  unproperstation/1,         % (PLACE)
        unproperstation0/1
                   %% FROM makeauxtables %%
]).
%% RS-111204    Surplus
        %cmbus/2,               % (NAME,NAMES,ROUTE)
        %corrx/2,               % (DOMAIN,PLACE,PLACE)
        %hours_delay/2,         % (NUMBER)
        %nightbus/1,            % (ROUTE)
        %spurious_return/1         % (ROUTE,PLACE)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- use_module( '../utility/utility', [ for/2 ]).  %% Module util
:- use_module( '../utility/datecalc', [ 
    add_days/3,
    datetime/6,
    easterdate/2,
    sub_days/3,
    todaysdate/1 ]).  %% Module util
%:- ensure_loaded( '../utility/utility' )

%* Import predicates
:- use_module( '../utility/makeauxtables' ). %% From Utils?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Santa Barbara
%clock_delay(00,00,00). %%  FOR CLOCK ADJUSTMENT
%hours_delay(0).    %% Time in Trondheim is 0 hours more than server clock
% hours_delay(-9). %% Time in Santa Barbara  is 9 hours EARLIER than server clock
% hours_delay(10). %% Time in  Tokyo (?)
%extraallowed_night/2,      % (DATE, KINDOFDAY)
%preferred_transfer/4,      % (ROUTE,ROUTE,STATION,STATION)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- volatile named_date/2.  %% Created Blank Initially, "remember"-ed later 
:- dynamic named_date/2.   %% Created Blank Initially, "remember"-ed later


this_year(YYYY):-
    datetime(YYYY,_B,_C,_D,_E,_F).


create_named_dates :-
    list_of_named_dates(L), 
    for(
         ( member(A,L), orig_named_date(A,B) ),
          %% From util:
         remember(named_date(A,B))). %% To be     refined  

%for(P,Q) :-                    %% From utility.pl
%  P,Q ,
%  false ; true.


%%%%%%%  TIME  SECTION %%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BEGIN  CRITICAL SECTION 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% DATES THAT MUST BE CHECKED ON EACH NEW ROUTE PLAN

% orig_named_date is defined here, and later recreated as named_date
list_of_named_dates([
    new_years_eve,
    new_years_day,
    palm_sunday,
    palm_monday,
    palm_tuesday,
    palm_wednesday,
    maundy_thursday,
    good_friday,
    eastereve,
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

    john_f_kennedy_day, 
    oddvar_brå_day, 
    arvid_holme_day, 
    dooms_day]).



%%% DATES NAMED BY EVENTS  :-)

orig_named_date(john_f_kennedy_day,   date(1963,11,22)).  
orig_named_date(oddvar_brå_day,       date(1982,02,25)).  
orig_named_date(arvid_holme_day,      date(2011,01,17)).  
orig_named_date(dooms_day,            date(2012,12,21)). %% :-) %% TA-100323|      date(10000,01,01)). 

%% Named dates

orig_named_date(new_years_eve,date(YYYY,12,31)) :- %% Nyttårsaften& januar  -> i fjor
     todaysdate(date(YYY1,01,_)),
     YYYY is (YYY1-1),
     !.
orig_named_date(new_years_eve,date(YYYY,12,31)) :- %% Nyttårsaften i år
     this_year(YYYY),
     !.

orig_named_date(new_years_day,date(YYYY,01,01)):- %% january -> this year
    todaysdate(date(YYYY,01,_)),
    !.
orig_named_date(new_years_day,date(YYY1,01,01)):- %% all other todays date 
     this_year(YYYY),
     YYY1 is YYYY+1,
     !.

orig_named_date(easterday,         ED):- %% datecalc
    this_year(YYYY),
    easterdate(YYYY,ED).

orig_named_date(palm_sunday, ND ) :- 
    this_year(YYYY),
    easterdate(YYYY,ED),
    sub_days(ED,7, ND).

orig_named_date(palm_monday,   ND) :- %% Pro forma
    this_year(YYYY),
    easterdate(YYYY,ED),
    sub_days(ED,6, ND).

orig_named_date(palm_tuesday,  ND) :- %% Pro forma
    this_year(YYYY),
    easterdate(YYYY,ED),
    sub_days(ED,5, ND).

orig_named_date(palm_wednesday,   ND) :- 
    this_year(YYYY),
    easterdate(YYYY,ED),
    sub_days(ED,4, ND).

orig_named_date(maundy_thursday,   ND) :- %% skjærT NOT monday  
    this_year(YYYY),
    easterdate(YYYY,ED),
    sub_days(ED,3, ND).

orig_named_date(good_friday,    ND) :-
    this_year(YYYY),
    easterdate(YYYY,ED),
    sub_days(ED,2, ND).

orig_named_date(eastereve,    ND) :-    
    this_year(YYYY),
    easterdate(YYYY,ED),
    sub_days(ED,1, ND).

orig_named_date(easterday2,     ND) :- %% 2. påskedag 
    this_year(YYYY),
    easterdate(YYYY,ED),
    add_days(ED,1, ND).

orig_named_date(ascension_day,   ND) :- %% Krhf 
    this_year(YYYY),
    easterdate(YYYY,ED),
    add_days(ED,39,ND).


orig_named_date(whitsun_eve, ND):-    %% pinseaften
    this_year(YYYY),
    easterdate(YYYY,ED),
    add_days(ED,48,ND).

orig_named_date(whitsun_day,   ND):-   %% pinsedag
    this_year(YYYY),
    easterdate(YYYY,ED),
    add_days(ED,49,ND).


orig_named_date(whitsun_day2,  ND):-       %% 2. pinsedag
    this_year(YYYY),
    easterdate(YYYY,ED),
    add_days(ED,50,ND).


orig_named_date(little_christmas_eve,date(YYYY,12,23)):- 
      this_year(YYYY).

orig_named_date(christmas_eve,     date(YYYY,12,24)):- this_year(YYYY).
orig_named_date(christmas_day,     date(YYYY,12,25)):- this_year(YYYY).

%% orig_named_date(vernal_equinox,    date(YYYY,03,21)):- this_year(YYYY). 
%% orig_named_date(autumnal_equinox,  date(YYYY,09,21)):- this_year(YYYY).

orig_named_date(midsummer_eve,     date(YYYY,06,23)):- this_year(YYYY). 
orig_named_date(midsummer_day,     date(YYYY,06,24)):- this_year(YYYY). 

orig_named_date(may1,              date(YYYY,05,01)):- this_year(YYYY). 

orig_named_date(may17,             date(YYYY,05,17)):- this_year(YYYY). 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% END OF CRITICAL SECTION 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%% Dedicated Date
%% Example   22.10 not clock if 22.10 is date of new route tables


%% dedicated_date(date(YYYY,05,17)):- this_year(YYYY). %% Suspended ved gløshaugen før 17.05 
dedicated_date(date(YYYY,12,24)):- this_year(YYYY).

%% dedicated_date(date(2006,06,19)). %% Check %% summer route



%% Special dates that run a specific day route
%% holiday means special route


%% VARIABLE DATES


%% DATE_DAY_MAP    

%% Maps dates to day, when this is different from the actual day
%% and not covered by route module (as. f.ex.  christmas  2010)
%% 
%% e.g sunday route, BUT only sunday route OF the same route module
%% e.g. 2. juledag 2010 was coverd by a separate datamodule but also declared sunday route,
%% However, there was no sunday day code in THAT module.

%% These are special date_map_days that are declared explicitly each year !!!!!

   %% date_day_map(date(2008,05,02),    saturday).  % friday after may 17 2008(!)
   %% date_day_map(Date,  sunday):-  named_date(palm_sunday,Date).     % Palmesøndag 

%% Easter week will have a separate module, 
%% Mon-Wed in easter are saturday routes + extra departures
%% These are ad hoc definitions %% TA-100106


%%%  NOT valid 2009, own schedule
%%
%% date_day_map(Date,  sunday):-  
%%     named_date(easterday2,Date).   %% 2 Påskedag Ad Hoc

%% date_day_map(Date,   saturday):-   %% ad hoc
%%     named_date(palm_monday,Date).
%%

%% date_day_map(Date,   saturday):-   %% ad hoc
%%     named_date(palm_tuesday,Date).
%%

%% date_day_map(Date,   saturday):-   %% ad hoc
%%     named_date(palm_wednesday,Date).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




date_day_map(date(_,05,01), sunday).   % 1.mai Fix, NOT separate route module

   %% date_day_map(date(_,05,17),   holiday).  %% OWN route module

date_day_map(Date,  sunday):-     %  KrHf- %% NOT OWN route module
     named_date(ascension_day,Date),
     \+ named_date(may17,Date).   

date_day_map(Date,  sunday):-  named_date(whitsun_day,Date).    %  1. pinsedag 
  
date_day_map(Date,  sunday):-  named_date(whitsun_day2,Date).   %  2. pinsedag



%%%%%%%%%%%%%%%%%%%%%%%%¤¤¤¤¤¤



%% SOFT TIME LIMITS 

%% These times are implicit and shall not be VERIFIED in answers

softime(morning,0430,1200).
softime(prenoon,0900,1200).
softime(afternoon,1200,1800).
softime(evening,1800,2400).
softime(night,1800,2400).
softime(midnight,2400,2500).


%% RESPONSE PARAMETERS


maxnumberofindividualdepartures(2):-
    user:myflags(smsflag,true),
    \+ user:myflags(nightbusflag,true),
    !. 

maxnumberofindividualdepartures(3):- %% not ridiculously many sequence
    user:myflags(smsflag,true),
    user:myflags(nightbusflag,true),
    !. 

maxnumberofindividualdepartures(3). 



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

kindofday(eastereve,eastereve).
kindofday(easterhol,easterhol). 


%%%%%%%%% END OF TIME  SECTION %%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clock_delay(00,00,00). %%  FOR CLOCK ADJUSTMENT


hours_delay(0).    %% Time in Trondheim is 0 hours more than server clock

% hours_delay(-9). %% Time in Santa Barbara  is 9 hours EARLIER than server clock
% hours_delay(10). %% Time in  Tokyo (?)


%%% END TIME SECTION

