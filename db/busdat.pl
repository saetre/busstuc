/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE busdat.pl
%% SYSTEM BUSSTUC
%% AUTHOR J.Bratseth
%% CREATED JB-970312
%% REVISED EH-031121 TA-110824 RS-130327

%% Bussrute database tilpasning PLACES in TRONDHEIM

%     This is adapted to reghpl.pl created from REGTOP format by
%     the program extractreg.pl.

% Domains:   BOOLEAN ROUTETYPE STATION PLACE MINUTES
%            DATE DAY DOMAIN CLOCK

%* List of predicates

:- module( busdat, [ airbus/1,                  % (BUS?)
                     airbusstation/1,           % (STATION)
                     bus_depend_station/3,      % (ROUTE,PLACE,STATION)
                     bus_dependent_station/3,   % (ROUTETYPE,NUMBER*) 
                     busfare2/2,
                     central_airbus_station/1,  % (STATION) 
                     central_fromstation/1,     % (STATION) avoid default to ST % use places.pl (AtB Domain)
                     cmbus/3, corr0/2, % corr/2,
                     corresp/2,                 % (PLACE,PLACE)
                     corresp0/2,                % (PLACE,PLACE)
                     corresponds/2,
                     cutloop_station/2,         % (STATION,STATION)
                     date_day_map/2,            % (DATE)
                     disallowed_night/1,
                     default_destination/2,     % (ROUTE,STATION)
                     endneighbourhood/2,        % (ROUTE,PLACE)
                     exbus/1,                   % (ROUTE)
                     exbusname/2,               % (ROUTE,ROUTE)
                     explicit_part_name/1,      % (NAME)
                     extraallowed_night/2,
                     fromstationonly/1,         % (STATION)
                     home_town/1,               % (PLACE)       % RS-120402  Was missing
                     hours_delay/1,
                     intbusname/2,              % (ROUTE,ROUTE)
                     intbusnr/2,                % (ROUTE,ROUTE)
                     internal_airbus/1,         % (BOOLEAN)
                     maxnumberofindividualdepartures/1,
                     moneyunit/1,               % (NAME) % from db/regbusall.pl nightbus/1,
                     nightbusstation/1,         % (STATION)
                     nightbusdestination/1,     % (STATION)
                     nostationfor/1,            % (PLACE)
                     nostationfor1/1,           % (PLACE)
                     preferred_transfer/5, railway_station/1, regbus/1, % From regbusall, %% RS-140413, experiment
                     spurious_return/2,
                     synbus/2,                  % (NAME,ROUTE)
                     thetram/1, thetramno/1,
                     tramstation/1,             % (STATION)
                     thetramstation/1,          % (STATION)
                     thetramstreetstation/2,
                     tostationonly/1,           % (STATION) %% TA-110228
                     unique_vehicle/2,  vehicletype/2,  xisat/2,
                     xforeign/1,                % (PLACE)
                     xplacestat/2, xsynplace/2 ] ). 
                     
%% RS-120402 %% Moved to timedat.pl  %% create_named_dates/0, % dedicated_date/1, orig_named_date/2,
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% UNIT: /
:- use_module( '../declare', [ value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .
:- use_module( '../interfaceroute', [ domain_module/2 ] ).    %% HEAVY DB? , thisdate_period_module/3

:- use_module( '../utility/utility', [ bound/1, testmember/2 ] ).

%% UNIT: /db/
:- use_module( places, [ corr/2, foreign/1, isat/2, nostation/1, placestat/2 ] ). %% RS-131225
:- use_module( regbusall, [ nightbus/1, regbus/1 ] ).  %% RS-140619
:- use_module( timedat, [ named_date/2 ] ).  %% keep  until modules are fixed bound/1, bus/1, station/1

%% RS-140416 Two different regbus (Period-independent, and many modules with regbus too. %%This used to be done from topreg? (Should be done from topreg:makeauxtable?)
%:- use_module( regcompstr, [] ). %% HEAVY DB! %:- use_module( regstr, [] ). %% HEAVY DB! %:- use_module( teledat2, [] ). %% HEAVY DB!

%% UNIT: /app/
:- use_module( '../app/buslog', [ bus/1, station/1 ] ).%% RS-130210 %% RS-131225  %% keep  until modules are fixed % 
%:- use_module( '../app/telelog', [ bound/1 ] ).    %% RS-131225 %% To utility.pl

%% UNIT: /tuc/
:- use_module( '../tuc/names', [ abroad/1, community/2, country/1 ] ). %:- ensure_loaded( '../tuc/names' ). %% [ abroad/1, community/2, country/1 ] ).


%%testmember(Member, Group/List) %%RS-130210 --> utility.pl
%testmember(Member, List) :-
%        testmember(Member, List).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% tram_module( r1630_111201 ). %% RS-140922       Update this please!
%%route_period(   gb, r1611_141020, date(2014,10,20),   date(2014,12,31) ).       %% Høst v4, including tram!! %% RS-141115
%% thisdate_period_module( _Module, _Todate, TTP ), %% SomeOnes-period covering current date  %% set by reset_period/0

%tram_module( Module ) :-
%        thisdate_period_module( _Company, _Todate, Module ). %% SomeOnes-period covering current date  %% set by reset_period/0   %% RS-141115


%:-volatile station/1. %% RS-121223 
%:-dynamic station/1. %% RS-121223 
%station(X) :-
%        station(X). %% RS-130210 --> '../app/buslog'
%        station(X). %% RS-130210 --> '../app/buslog'      %% RS-131223


railway_station( ts ). %% NB not STATION ! %% TA-110724
%% railway_station(trondheim_s_10).      %% TA-110706



%% CUTLOOP SECTION 


cutloop_station(pling,plong). %%

%% Pendelruter (via Sentrum)   

%% Hvis pendelruter er oppført i rutehefte med fjern destinasjon
%% så er det registrert som direkterute
%% TA-101115

%%%  cutloop_station(3,carl_schjetnans_vei). %% TA-110331 NB creates double loop

%%% fra lade gård  anders buens gt carl_schjetnans_vei -> hagen anders_buens_gate
                                       

%% cutloop_station(3,munkegata_m2). %% Lade - M2 - (Sjetnmarka)
%% cutloop_station(3,munkegata_m5). %% Sjetnmarka - M5 - (Lade) 

%% cutloop_station(4,munkegata_m2). %% Lade - M2 - (Heimdal)
%% cutloop_station(4,munkegata_m5). %% Heimdal - M2 - (Lade)

%% cutloop_station(5,dronningens_gate_d2). %% Dragvoll - D2 - (Buenget)
%% cutloop_station(5,dronningens_gate_d3). %% Buenget- D3 - (Dragvoll)

%% cutloop_station(6,munkegata_m2). %% Værestrøa - M2 - Romolslia
%% cutloop_station(6,munkegata_m5). %% Romolslia - M5 - Værestrøa

%% cutloop_station(7,munkegata_m2). %% Vikåsen -M2-Flatåsen
%% cutloop_station(7,munkegata_m5). %% Flatåsen-M2-Vikåsen
 
%% cutloop_station(8,dronningens_gate_d1). %% Risvollan - D1 - Stavset
%% cutloop_station(8,dronningens_gate_d3). %% Stavset - D3 - Risvollan 

cutloop_station(9,heimdal_sentrum). 
cutloop_station(9,heimdal_stasjon). 

cutloop_station(20,valentinlyst). 
cutloop_station(36,stokkhaugen). %% TA-110824 charlottenlund_krk). 
                   %stokkhaugen?%  %% Alternating official names! %% TA-101228

cutloop_station(47,torgaardssletta). %% RS-130818

cutloop_station(49,carl_schjetnans_vei). %% TA-100913

% cutloop_station(52,othilienborg). %%  ?( > 5 min wait ?)
% cutloop_station(52,vestlia_endeholdeplass). %% etter 070806
    % Too many  spurious departures ( Gløs Vestlia Sentrum)

cutloop_station(60,valentinlyst). 


%% cutloop_station(63,asbjørnsens_gate). %% TA-110315 NB %% RS-131027 Station no longer exists!

%% cutloop_station(63,dronningens_gate_d1). %% TA-110315 wrong
%% cutloop_station(63,munkegata_m3).        %% TA-110315 wrong

cutloop_station(66,stokkhaugen). %% TA-110824 charlottenlund_krk). 
                   %stokkhaugen?%  %% Alternating official names! %% TA-101228


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%  TIME  SECTION %%%%%%%%%%%%%%%%%

                      
% Santa Barbara
% internal_airbus(true). %% The airport is covered

hours_delay(0).    %% Time in Trondheim is 0 hours more than server clock
% hours_delay(-9). %% Time in Santa Barbara  is 9 hours EARLIER than server clock
% hours_delay(7). %% Time in  Tokyo (7 or 8, depends on Daylight Savings Time, Sommertid)




home_town(trondheim).

%% home_town(santa_barbara). %% Test


%% Special dates that run a specific day route
%% holiday means special route

% ¤ EXTRAALLOWEDNIGHT   (DATE, KINDOFDAY)
%% Nightbus goes after midnight on this date despite rule.
%% The route plan is the same as on KINDOFDAY.
% Example:
% busdat:extraallowed_night(date(2009,04,12),saturday). 


%% SPECIAL DATES FOR NIGHTBUS

%% SEE busanshp.pl(->topreg?) for correct default messages !!!

%% extraallowed_night(DATE,DAY). 
%% NIGHTBUS GOES extra, even if not sat-sun, following routes of DAY (pro forma)
%% if DAY=nil, it means NO nightbus routes at all in module,

%% ADJUSTMENT NIGHTBUS Holidays
extraallowed_night(date(9999,12,31),saturday). %% Just at least1
% extraallowed_night(date(2009,04,12),saturday).  %%  Påskedag om morgenen 
% extraallowed_night(date(2013,05,17),fredag).  %%  natt til 17mai. %%Handled by separate route module for may17th.

% ¤ DISALLOWED_NIGHT (DATE)
%% Nightbus does not go  (after midnight) on this date despite rules.
%% NIGHTBUS does not go even if sat-sun
% Example: 
% disallowed_night (date(2009,04,13))
%:- volatile disallowed_night/1.
%:- dynamic disallowed_night/1.

%  JUST standard answer (misfjord rule: NB May vary)
%% disallowed_night(date(9999,12,31)).    %% Just at least 1

%% EASTER 
disallowed_night(date(2009,04,13)).  %%  Påskeaften om morgenen 
disallowed_night(date(2011,04,23)).  %% natt til påskeaften %% TA-110426

%% CHRISTMAS
%% Extrallowed

%% none in 2008 ( "extra night to 3. X day is actually Saturday)

%% Disallowed    Days  sat-sun  without nightbus
%% none 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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


%%%  NOT valid 2011-20xx, own schedules for easter
%%
 date_day_map(Date,  sunday):-  
     named_date(easterday2,Date).   %% 2 Påskedag Ad Hoc

 date_day_map(Date,   monday):-   %% ad hoc
     named_date(palm_monday,Date).

 date_day_map(Date,   saturday):-   %% ad hoc
     named_date(palm_tuesday,Date).


 date_day_map(Date,   saturday):-   %% ad hoc
     named_date(palm_wednesday,Date).


date_day_map(date(_Y20XX,05,01), sunday).   % 1.mai Fix, NOT separate route module

   %% date_day_map(date(_20XX,05,17),   holiday).  %% OWN route module

date_day_map(Date,  sunday):-     %  KrHf- %% NOT OWN route module
     named_date(ascension_day,Date),
     \+ named_date(may17,Date).

date_day_map(Date,  sunday):-  named_date(whitsun_day,Date).    %  1. pinsedag 
  
date_day_map(Date,  sunday):-  named_date(whitsun_day2,Date).   %  2. pinsedag


%%%%%%%%%%%%%%%%%%%%%%%%¤¤¤¤¤¤

%% RESPONSE PARAMETERS


maxnumberofindividualdepartures(2):-
    value(smsflag,true),
    \+ value(nightbusflag,true),   %% RS-131230 From declare.pl
    !. 

maxnumberofindividualdepartures(3):- %% not ridiculously many sequence
    value(smsflag,true),           
    value(nightbusflag,true),           %% RS-131230 value is from declare.pl
    !. 

maxnumberofindividualdepartures(3). 



intbusname(X,X). 
intbusnr(X,X). 


%% 

airbus(fb).     
airbus(airbus).
airbus(flybussen).


exbusname(airbus,'Flybussen').  
exbusname(flybussen,'Flybussen'). 
exbusname(fb,'Flybussen'). 

exbusname(254,'Klæburuten'). 
exbusname(255,'Klæburuten').

exbusname(13,'ekstrabuss'). 


exbusname( 990,skolebuss). 
exbusname( 992,skolebuss).
exbusname( 993,skolebuss).
exbusname(9911,skolebuss).
exbusname(9912,skolebuss).
exbusname(9913,skolebuss).
exbusname(9914,skolebuss).
exbusname(9915,skolebuss).
exbusname(9916,skolebuss).
exbusname(9917,skolebuss).
exbusname(9918,skolebuss).
exbusname(9919,skolebuss).
exbusname(9921,skolebuss).
exbusname(9922,skolebuss).
exbusname(9924,skolebuss).



%%%%%%  PLACE SECTION %%%%%%%%%%



% synplace is also used for synonyms that are not full  names


xplacestat(trondheim,tmn_trondheim):- 
    value(tmnflag,true).   %% RS-131230 from declare.pl  


xplacestat(town,hovedterminalen). 
xplacestat(trondheim,hovedterminalen) :- 
    \+value(dialog,1).     %% RS-131230 From declare.pl


xplacestat(klæbu,klæbu_sentrum):- %% Not possible mess in daytime
    value(nightbusflag,true). %%   NATTBUSSEN      %% RS-131230 From declare.pl




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



xsynplace(X,Y):-
    value(tmnflag,true),   %% RS-131230 From declare.pl
    !,
    domain_module(_,TMN),  %% RS-131230 From topreg.pl
    TMN \== nil, 
    TMN:hpl(_,X,Y,_).


xsynplace(X,Y):-
    \+ value(tmnflag,true),        %% RS-131230 From declare.pl
    !,
    domain_module(tt,TMN),  %% RS-131230 From topreg.pl
    TMN \== nil, 
    TMN:hpl(_,X,Y,_).



%% PLACE INTERFACE SECTION

xsynplace( sentrum, gb_st_olavs_gate ) :- %% Generalize
    value( tmnflag, true ).   %% RS-131230 From declare.pl

                       
xsynplace(toget,ts) :-  %% presumes stasjonen is not noun def
   \+ value(tmnflag,true). %% RS-131230 From declare.pl

                        %%  jeg når toget til oslo
                        %%  jeg bor på (lade og toget) går
                        %%  rekke toget(ts, !) som går

%%%%%%%% INTERDOMAIN SECTION  %%%%%%%%%%%%%



%%% nightbus(X):- tt:nightbus(X). %% TA-110310

vehicletype(flybussen,bus):-!. %%  ...// Used as neste "buss" Flybussen
vehicletype(airbus,airbus):-!.
vehicletype(fb,airbus):-!.

vehicletype( 1, nighttram ) :- value( nightbusflag, true ), !. %% NB TRONDHEIM   %% RS-141115
vehicletype( 1, tram ) :- !. %% NB TRONDHEIM

vehicletype(X,nightbus) :-   nightbus(X),!.  %%% <------
   %% side effects on answer generation  

vehicletype(X,bus):- exbus(X). 



%% not vehicletype('I')


unique_vehicle(tram,true). %%  NB Trondheim
unique_vehicle(bus,false). %%

thetram(1).   %% Only one tram.  

thetramstreetstation(st_olavs_street,st_olavs_gate).

central_airbus_station(torget). %% hovedterminalen// sentrum 

%:- volatile nightbusstation/1. %%RS-121223
%:- dynamic nightbusstation/1. %%RS-121223
nightbusstation( olav_tryggvasons_gate ). %% AtB \== Team %% TA-101202 %%RS-121223

/*  %% compiled into user // regstr.pl %% TA-110406
streetstat(A,B,C,D,E):-  
    tt:streetstat(A,B,C,D,E1),
   ( E1 == '' -> E=unknown;E=E1). %% repair 
*/



thetramno(One):-
    value(tmnflag,true),   %% RS-131230 From declare.pl  
    unique_vehicle(tram,true),
    thetram(One).

thetramstation(STOGT):-
    value(tmnflag,true),   %% RS-131230 From declare.pl 
    tramstation(STOGT).
 

% ABNORMAL SECTION


nostationfor(X) :- %% Heimdal  is unproper, BUT place (with) station 
    nostationfor1(X),
    \+  placestat(X,_). 


% Places in trondheim with no stations

nostationfor1(X) :- nostation(X).     %%  Places with no close bus station 


%nostationfor1(X):-
%    \+ value(tmnflag,true),        %% RS-131230 Tram-stations ONLY for TMN? Not any more!
%    tramstation(X),
%    \+ station(X).


%% nostation ---> places.pl %% TA-100311

%% places in trondheim (not foreign)

tramstation( st_olavs_gate ).
tramstation( st_olavs_street ). %% for street reference 
%% tram_station(st_olavs_gt). %% Wrong, kept for security %% TA-100317

%% All the tram-stations are mixed with other stations in the routes from AtB!! %% RS-150102
%tramstation(X) :-
%    value( tramflag, true ),  %% RS-131230 From declare.pl
%    tram_module( Tram ),   %%  tram_mod(Tram), %% succeeds also if tramflag=false
%    Tram \== nil, %% precaution 
%    Tram:hpl( _, _, X, _ ).   %%



%% Nightbus extend to some foreign stations


xforeign(X):-
    value(actual_domain,TT),       %% RS-131230 From declare.pl
    xforeign(TT,X), %% NB relative to Team !
    \+ nightbusdestination(X).

xforeign(tt,X) :- foreign(X). 

xforeign(_,C) :- abroad(C). 

xforeign(_,C) :- country(C). 

xforeign(fb,C):- foreign(C), %% værnes malvik %%
                 \+ airbusstation(C).         %% TA-100322


xforeign(tt,C):- community(C,County), %% tt malvik foreign to fb
                County \== sør_trøndelag,
         %% e.g. Klæbu //=> \+ trondheim   isa neighbourhood
                \+ station(C). %% e.g. berg     %% RS-130210 TODO:FIX BUG

nightbusdestination(X):-
    value(nightbusflag,true),      %% RS-131230 From declare.pl 
    member(X,[klæbu]). %% Ad Hoc




%%   BUS_DEPEND[ENT]_STATION 

%% bus_dependent_station(<bus no>,<place said>,<station "meant">). 

%% Defaults to <place said> if not defined by  bus_depend_station


bus_dependent_station(Bus,Said,Meant):-
    bound(Bus),
    bus_depend_station(Bus,Said,Meant),
    !.
bus_dependent_station(_Bus,Said,Meant):- 
    \+ value(airbusflag,true),     %% RS-131230 From declare.pl  
    Meant=Said.

bus_dependent_station(_Bus,_Said,Meant):- 
    value(airbusflag,true),        %% RS-131230 From declare.pl       
    default_origin(_,Lerkendal),
    !,
    Meant=Lerkendal. %% Default (but not central!) 




% User specifies a bus and a wrong station/place that
% is caused by confusion of neighbourhoods/places etc.

% bus_depend_station(<bus no>,<place said>,<station "meant">).

bus_depend_station(_Bus,RGH,RGH) :- %% // busdependent ??????
    value(airbusflag,true),        %% RS-131230 From declare.pl  
    testmember(RGH,[royal_garden_hotell,britannia_hotell]),        %% RS-131230 From utility.pl
    !. %%% AD HOC 


%% Berg   Berg is an obscure station on route 75,  76 (not in rutehefte)

bus_depend_station(60,berg,berg_prestegård). 
bus_depend_station(94,berg,berg_østre).

%% 75 Berg , Berg bedehus , 

% bus_depend_station(66,berg,berg_østre).     % 5,20,36,66,94

% bus_depend_station(66,berg,berg_studentby). % 5,20,36,66,94

%% 66 Berg studentby , Berg Østre // not unique
%% 20 Berg studentby , Berg Østre 
%% 36 Berg studentby , Berg Østre


bus_depend_station(3,buran, mellomv_5). 

bus_depend_station(4,    buran,          mellomv_5).
bus_depend_station(4,    mellomstreet,   mellomv_5).      %%  Mellomveien
% Oops:   Holdeplassen nærmest  Mellomveien er  Buran ---> mellomv_5 allikevel



bus_depend_station(1,hovedterminalen, st_olavs_gate). 

%% bus_depend_station(4,    tonstadkrysset,tonstadkrysset_2). %% fra heimdal


bus_depend_station(5,    byåsen,byåsen_sk).  
bus_depend_station(8,    byåsen,byåsen_butikksenter).


bus_depend_station(5,    ntnu_dragvoll,dragvoll). 

bus_depend_station(5,   brøsetveien  ,brøsetv). 

% bus_depend_station(5,    steinan, vestlia).  
% bus_depend_station(5,    universitetet_dragvoll,dragvoll).


bus_depend_station(6,    charlottenlund,charlottenlund_nedre). 
bus_depend_station(6,    romolslia,romolslia_øvre). 
bus_depend_station(6,    leangen, leangen_all).    %%% NBNBNB   AtB feil
bus_depend_station(6,    travbanen, leangen_all).  %% TA-101019

bus_depend_station(8,    steinan, steinan). 

%% bus_depend_station(8,studentersamfundet,studentersamfundet_1). %% AtB


bus_depend_station(9,    bromstad,bromstadsvingen). 

bus_depend_station(9,    brøsetv,brøsetveien_168). %% NB double  
bus_depend_station(9,    brøsetv,brøsetveien_186).  

bus_depend_station(9,    brøsetveien,brøsetveien_168). %% NB double  
bus_depend_station(9,    brøsetveien,brøsetveien_186).  

bus_depend_station(9,    flatåsen, flatåsen_senter).  %% not Flatåstoppen 
bus_depend_station(9,    byåsen, havstadsenteret).  

bus_depend_station(9,    moholt, moholt_storsenter). 

%%%%%%%%%%%   bus_depend_station(9,     stavset, stavset_senter_2). 
bus_depend_station(9,     stavset_senter, stavset_senter_2).  

% bus_depend_station(9,    universitetet_dragvoll,dragvoll).
bus_depend_station(9,    ntnu_dragvoll,dragvoll). 

%%           bus_depend_station(9,    moholt,moholt_storsenter). %% 

bus_depend_station(11,   trolla,trollah_64).  
bus_depend_station(12,   strindheim,strindheim_skole). 
bus_depend_station(15,   stavset,stavset_senter_2). 
bus_depend_station(15,   stavset_senters,tavset_senter_2). 


bus_depend_station(20,   bromstad,bromstadveien). %% TA-110406
bus_depend_station(24,   bromstad,bromstadsvingen).

bus_depend_station(25,   leangen, ikea).  
bus_depend_station(25,   travbanen, ikea). 

bus_depend_station(27,   bromstad,bromstadveien).

bus_depend_station(36,   charlottenlund,charlottenlund_kirke). %% AtB
bus_depend_station(36,   dragvoll,ntnu_dragvoll). 
bus_depend_station(36,   ntnu,ntnu_dragvoll). 

bus_depend_station(36,   voll, voll_gård).   %% not voll_studentby (missing in db)).

%%%% bus_depend_station(36,   voll_studentby, voll_gård). %% NB NB

bus_depend_station(43,   romolslia,romolslia). 

%% bus_depend_station(44,    tonstadkrysset,tonstadkrysset_3). %% Hastus

/*
bus_depend_station(46,    tonstadkrysset,tonstadkrysset_2). %% // fra lundåsen
bus_depend_station(46,    tonstadkrysset,tonstadkrysset_4). %% // fra sandmoen                  
*/

bus_depend_station(52,   ntnu,gløshaugen_syd). 
bus_depend_station(52,   steinan, vestlia).  
%%% bus_depend_station(52,   studentersamfundet, studentersamfundet_2). %% AtB %% TA-110119

bus_depend_station(60,   tyholttårnet,tyholt). 

bus_depend_station(66,   charlottenlund,charlottenlund_kirke). %% AtB 
bus_depend_station(66,   ntnu,ntnu_dragvoll).
bus_depend_station(66,   dragvoll,ntnu_dragvoll). 
bus_depend_station(66,   jakobsli, idrettsplassen). %% idrettsplassen_jakobsli

bus_depend_station(66,   dybdals_veg , peder_kroghs_v). 

bus_depend_station(71,   romolslia,romolslia). %%  (rutedata)
bus_depend_station(73,   romolslia,romolslia). %%

bus_depend_station(90,   lade,  obs_lade). 
bus_depend_station(90,   nardo,  omkjøringsveien_nardo). 
bus_depend_station(90,   nardokrysset,  omkjøringsveien_nardo). 

bus_depend_station(103,  sjetnmarka,paul_skolemesters_vei). 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CORRESPOND SECTION


corresp0(X,Y):-
   X=Y
   ;
   corresp(X,Y).

corresp(X,Y):-

   value(actual_domain,T), %% RS-131230 From declare.pl
   ( corrx(T,X,Y)   ;   corrx(T,Y,X) ).

corresp(X,Y):-                    %% 
   value(actual_domain,T), %% RS-131230 From declare.pl
   ( corrx(T,X,hovedterminalen)
   , %%%%%%% <----------- ; sic
     corrx(T,Y,hovedterminalen) ).


%% corrx(Domain,Place1,Place2).

corrx( tt, X, Y ) :- corr( X, Y ).    %% Default Ad Hoc
%corrx( gb, X, Y ) :- corr( X, Y ).    %% Default Ad Hoc   DOUBLES THE TIME!!!
corrx( gb, st_olavs_gate, hovedterminalen ).    %% RS-141115. Don't treat tram any different... 

%corrx( gb, gb_st_olavs_gate, hovedterminalen ). 

corrx( tmn, trondheim_s, hovedterminalen ).

corrx( tmn, tmn_trondheim_s, hovedterminalen ). 

corrx( tmn, tmn_trondheim, hovedterminalen ).



% corresponds(station1,station2)
% Sier at station1 og station2 korresponderer (ligger like ved hverandre)

corresponds(X,X).                     % Refleksiv
corresponds(X,Y) :-                   % Transitiv i sentrum
   corr(X,hovedterminalen),
   corr(Y,hovedterminalen).
corresponds(X,Y) :- corr(X,Y).        % 
corresponds(X,Y) :- corr(Y,X).        % symmetrisk


corr0(X,Y):- X=Y   % Utility: fast check
           ; corr(X,Y).         



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


exbus(G) :- bus(G), \+ vehicletype(G,tram).  



%---------------------------------------------------------------------
%% NEVER use synword( ) here !!! Erases synword elsewhere :  
%% Use       synplace !!!
%---------------------------------------------------------------------
 
%% streetsyn moved to names.pl 



%% Trondheim

%% Additional Airbus stations

airbusstation(værnes). 

airbusstation(sorgenfriveien).
airbusstation(bratsbergveien).
airbusstation(valøyvegen).
airbusstation(britannia).
   airbusstation(britannia_hotell).
airbusstation(royal_garden).





%% The airport bus is not included  but a reference to it is important

%% internal_airbusflag  static, depending on airbus is included
%% airbusflag           dynamic  set if airbus or airbus station is explicitly mentioned
                                 

internal_airbus(IAB):-  
    value(internal_airbusflag,true) ->     %% RS-131230 From declare.pl 
        IAB=true
      ; 
        IAB=false.



moneyunit(nok).    %% Trondheim %% Local currency

%% moneyunit(usd).  %%  Santa Barbara  



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% PRICES ETC

%% busfare(30,15). %% Adult/Child 

busfare2(airbus,[130,65]). 
busfare2(bus,[50,25]).
busfare2(nightbus,[80-90-110]). % Byen - Klæbu - Byneset
busfare2(nightbus_klæbu,[90]).
busfare2(nightbus_byneset,[110]).
busfare2(nighttram,[80]).
busfare2(tram,[50,25]).  

%%  Ikke Klæbu/Melhus/Byneset (90/110), but that is foreign


fromstationonly(heaven). %% Ad HOC 
tostationonly(hell).     %% 

central_fromstation( torget ). %%  (avoid from torget = default to ST)
central_fromstation( prinsenkrysset ). 
central_fromstation( Olav_tryggvasons_gate ) :- 
    nightbusstation( Olav_tryggvasons_gate ).

%% Some names occur only in lists in cmpl.
%% They are invisible before new hashtable is created
%% This list is ad hoc, awaiting new hashtable
%% All (except one) can be deleted then, 

explicit_part_name(amble). 
%% but leave one!
explicit_part_name(skj). %% E. Tamb.skj gt %% TA-110310

%%
%% PREFERRED TRANSFER %%


% All bus 47 starting in klæbu_sentrum and transfers to bus 46 shall
% preferrably transfer at city_syd  (not e.g. torvtaket).

preferred_transfer(47,46,klæbu_sentrum,sandmoen,city_syd_østre). 
%% NB Østre
%% bus 47 direction from klæbu_sentrum (start),  
%% switches to
%% bus 46 direction from sandmoen(start(
%% have to correspond at city syd !

preferred_transfer(46,47,pirbadet,munkegate_m4,city_syd). 


%% DEFAULT DESTINATION 

%% All buses NN from S goes via DEST
%% Use names as in route leaflet

%% Airbus Section

default_origin(_,sorgenfriveien) :- %% AD HOC 
    value(airbusflag,true),        %% RS-131230 From declare.pl
    !.


default_destination(_,værnes) :- %% AD HOC 
    value(airbusflag,true),        %% RS-131230 From declare.pl
    !.


default_destination(1,lian).
default_destination(10,skistua).
%% default_destination(11,trollahaugen). %% no, neib 
default_destination(19,sandmoen). %% TA-110511
default_destination(20,valentinlyst).
default_destination(24,jonsvatnet). %% solbakken?

%% default_destination(36,jakobsli).  %% " Brundalen Jakobsli"
%% Yes, but station jakobsli is hopeless/only one way 

%% default_destination(36,stokkanhaugen). %%  TA-101228
   %stokkhaugen?%  %% Aternating official names! %% TA-101228

%% default_destination(43,ringvål). %%  except some routes on sunday (Heimdal stasjon) 
default_destination(44,heggstadmoen). 

%% default_destination(46,sandmoen). %% not since 2006

default_destination(46,torvtaket).  

default_destination(48,lundåsen). %% ..nedre
default_destination(49,sjetnemarka).
default_destination(52,vestlia).
default_destination(54,bratsberg).
default_destination(55,rate).  
default_destination(60,valentinlyst). 
default_destination(63,singsaker). 

%% default_destination(66,stokkanhaugen). %% TA-101029 jakobsli).
   %stokkhaugen?%  %% Aternating official names! %% TA-101228

default_destination(73,spongdal).                               
default_destination(75,spongdal).
default_destination(76,spongdal). 


% Default nightbuses

default_destination(103,sjetnmarka).  %% kroppnmarka/sjetnemarka
default_destination(104,heimdal).     %% kolstad/heimdal
default_destination(105,buenget).     %% buenget
default_destination(106,værestrøa).   %% lade/værestrøa
default_destination(107,fortunalia).  %% reppe/vikåsen/fortunalia
default_destination(108,stavset).     %% stavset
default_destination(109,lundåsen).    %% bjørdalen/kattem/lundåsen
default_destination(119,flatåsen_senter).    %% byåsen/flatåsen
default_destination(136,jakobsli).    %% valentinlyst/jakobsli %% 
default_destination(146,tiller).      %% tiller
default_destination(154,klæbu).       %% nidarvoll/klæbu
default_destination(155,brøset).      %% moholt/brøset
default_destination(175,byneset).     %% byneset
default_destination(188,steinan).     %% othilienborg/risvollan/steinan

%% It is totally harmless to have cyclic synplace
%% They are not applied recursively


%%%%%%%  Buses with Markings:


%% Markings are ignored, may cause confusion 

cmbus(3,c,3).  
cmbus(3,e,3). 

cmbus(4,a,4). 

cmbus(6,a,6). 
%% cmbus(6,c,6). %%  // Only to  ALT/Statoil
cmbus(6,e,6). 
cmbus(6,e,6). 

cmbus(7,a,7). 

cmbus(9,a,9).  %% 9a Nia ???

cmbus(10,c,10). 

cmbus(19,e,19). 

cmbus(43,e,43). 
cmbus(44,a,44).  
cmbus(44,e,44). 

cmbus(54,c,54). 

cmbus(75,a,75). 

cmbus(76,a,76). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Other bus namings

%% cmbus(6,a,'6a').  %% etc etc

% cmbus(2,er,2).   %% haz
cmbus(2,ere,2).    %% haz
cmbus(2,eren,2). 
cmbus(2,ern,2). 
%% cmbus(24,a,24). 
%% cmbus(24,c,24). 
%%   cmbus(3,a,3).  %% Autosplit 

% cmbus(3,er,3). 
cmbus(3,ere,3). 
cmbus(3,eren,3). 
cmbus(3,ern,3). 
cmbus(3,t,'3t').  %% get errm

% cmbus(4,er,4). 
cmbus(4,ere,4). 
cmbus(4,eren,4). 
cmbus(4,ern,4). 

% cmbus(5,er,5). 
cmbus(5,ere,5). 
cmbus(5,eren,5). 
cmbus(5,ern,5). 
%% cmbus(52,a,52). 

% cmbus(6,er,6). 
cmbus(6,ere,6). 
cmbus(6,eren,6). 
cmbus(6,ern,6). 

% cmbus(7,c,7). 
%% cmbus(7,e,7). 
% cmbus(7,er,7). 
cmbus(7,ere,7). 
cmbus(7,eren,7). 
cmbus(7,ern,7). 

% cmbus(8,er,8). 
cmbus(8,ere,8). 
cmbus(8,eren,8). 
cmbus(8,ern,8). 

%% cmbus(9,e,9). 
%% cmbus(9,er,9). 
cmbus(9,ere,9). 
cmbus(9,eren,9). 
cmbus(9,ern,9). 


%  cmbus(10,er,10). %%  hvilke stoppested for buss 10 er nærmest samfundet? 
                   %%   etc
cmbus(10,ere,10). 
cmbus(10,eren,10). 
cmbus(10,ern,10). 


cmbus(femmer,n,5). %% etc   femmer'n? 

cmbus(fem,bussen,5). %% etc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

synbus(toerbussen ,  2).
synbus(treerbussen , 3).
synbus(firerbussen , 4). 
synbus(femmerbussen , 5). 
synbus(sekserbussen , 6). 
synbus(sjuerbussen , 7). 
synbus(åtterbussen , 8). 
synbus(nierbussen , 9). 
synbus(tierbussen , 10).  


synbus(tobuss ,  2). 
synbus(trebuss , 3).
synbus(firbuss , 4). 
synbus(firebuss , 4). 
synbus(fembuss , 5). 
synbus(seksbuss , 6). 
synbus(sjubuss , 7). 
synbus(åttbuss , 8). 
synbus(nibuss , 9). 
synbus(tibuss , 10).  

synbus(tobussen ,  2). 
synbus(trebussen , 3).
synbus(firbussen , 4). 
synbus(firebussen , 4). 
synbus(fembussen , 5). 
synbus(seksbussen , 6). 
synbus(sjubussen , 7). 
synbus(åttbussen , 8). 
synbus(nibussen , 9). 
synbus(tibussen , 10).  



synbus(toerbuss ,  2). 
synbus(treerbuss , 3).
synbus(firerbuss , 4). 
synbus(femerbuss , 5). 
synbus(sekserbuss , 6). 
synbus(sjuerbuss , 7). 
synbus(åtterbuss , 8). 
synbus(nierbuss , 9). 
synbus(tierbuss , 10).  %% etc etc %%

synbus(toerbussen ,  2). 
synbus(treerbussen , 3).
synbus(firerbussen , 4). 
synbus(femerbussen , 5). 
synbus(sekserbussen , 6). 
synbus(sjuerbussen , 7). 
synbus(åtterbussen , 8). 
synbus(nierbussen , 9). 
synbus(tierbussen , 10).  %% etc etc %%


synbus('7buss',7).  %% etc //outdated  => 7 buss
synbus(bussen5,5).  %% etc

synbus(buss2,2). %% not nec 
synbus(buss3,3).
synbus(buss4,4).
synbus(buss5,5).
synbus(buss6,6).
synbus(buss7,7).
synbus(buss8,8).
synbus(buss9,9).

synbus(buss10,10). %% not nec
synbus(buss11,11).
synbus(buss12,12).
synbus(buss13,13).

synbus(buss20,20).
synbus(buss24,24).
synbus(buss25,25).

synbus(buss36,36). 

synbus(buss43,43).
synbus(buss44,44).
synbus(buss46,46). 
synbus(buss48,48).
synbus(buss49,49). 

synbus(buss52,52). 
synbus(buss54,54). 

synbus(buss60,60).
synbus(buss63,63).
synbus(buss66,66).





/* not true 

%% når går ikeabussen fra sentrum == du må oppgi en holdeplass til (SIC)

synbus(ikeabuss,25).  
synbus(ikeabussen,25).

*/



synbus(linje1,1). 

synbus(fema,5).  
synbus(femeren,5).  
synbus(femmerbuss,5). %%  ETC

% List not complete 

synbus(b2,2).  
synbus(b8,8). 

synbus(nr2,2).
synbus(nr3,3).
synbus(nr4,4).
synbus(nr5,5).
synbus(nr6,6).
synbus(nr7,7).
synbus(nr8,8).
synbus(nr9,9).

synbus(nr10,10).
synbus(nr11,11).
synbus(nr12,12).
synbus(nr13,13).

synbus(nr20,20).
synbus(nr24,24).
synbus(nr25,25).

synbus(nr36,36).

synbus(nr43,43).
synbus(nr44,44).
synbus(nr46,46). 
synbus(nr48,48).
synbus(nr49,49). 

synbus(nr52,52). 
synbus(nr54,54). 

synbus(nr60,60).
synbus(nr63,63).
synbus(nr66,66).

%% ...

synbus(eneren,1).  
synbus(enern,1).

synbus(toeren,2).
synbus(toern,2). %% not 2 o'clock
synbus(toen,2).  %%  ...

synbus(treeren,3). 
synbus(treern,3). 
synbus(treen,3). 

synbus(fireren,4). 
synbus(firern,4). 
synbus(firen,4). 

synbus(femeren,5). 
synbus(femern,5). 
synbus(femen,5). 

synbus(sekseren,6). 
synbus(seksern,6). 
synbus(seksen,6). 

synbus(sjueren,7).
synbus(sjuern,7).
synbus(sjuen,7).

synbus(åtteren,8).
synbus(åttern,9).
synbus(åtten,9).

synbus(nieren,9). 
synbus(niern,9).  %% ..etc
synbus(nien,9). 

synbus(tieren,10). 
synbus(tiern,10).  %% ..etc
synbus(tien,10).  %

%% Irrelevant. split Num + Alpha


/*
synbus('10c',10). 
synbus('24a',24).
synbus('24c',24).
synbus('43e',43).
synbus('44a',44).
synbus('4a' ,4).
synbus('52a',52).
synbus('54c',52).
synbus('5a' ,5).
synbus('5c', 5).
synbus('5e', 5).
synbus('6a', 6).
synbus('6c', 6).
synbus('6e', 6).
synbus('7a', 7).
synbus('7c', 7).
synbus('8a', 8).
synbus('8c', 8).
synbus('9e', 9).
*/

%% synbus(gråkallbanen,1). %% Buss til gråkallbanen (SIC) =1 o'clock


%¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤


xisat(X,Y) :-  %% Last isat Predicate
    corr(X,hovedterminalen),
    isat(hovedterminalen,Y).       %% RS-130210 --> places.pl


%% Special predicates for nightbuses 
%% AD HOC, nightbuses return to these places, but misleading
%% since other alternatives exist

%% morten_erichsen_forbid

spurious_return(154,hesttrø).
spurious_return(154,prestgårdskrysset).
spurious_return(154,sørborgen).
spurious_return(154,ostangen).
spurious_return(154,tanem_bru).
spurious_return(154,tanem_gård).
spurious_return(154,sjøl).
spurious_return(154,torgardshaugen).
spurious_return(154,torgard).
spurious_return(154,torgårdsletta).
spurious_return(154,sandmoen).



endneighbourhood(57,klæbu).

%% END BUS SECTION
