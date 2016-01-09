/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE regbusall.pl
%% SYSTEM BUSSTUC DOMAIN TT
%% CREATED TA-020101
%% REVISED TA-110824    RS-120803
%% REVISED RS-140416    Keep using this! % No regbus after buslog.pl:regbusall was implemented?  %% RS-120803

%% UNIT /db/

:- module( regbusall, [ nightbus/1, regbus/1 ] ). %% HEAVY DB! %% RS-120803 RS-131225 regbus/1 MOVED to app/buslog.pl
%% Inclusive set of bus routes

:- use_module( route_period, [ route_period/4 ] ).

%% UNIT: /utility/,     RS-140914
:- use_module( '../utility/datecalc', [ before_date0/2, todaysdate/1 ] ).

                        %% from /app/
:- use_module( '../app/buslog', [ veh_mod/1 ] ).  %% RS-140927 For busanshp.pl, moved to utility.pl: internalkonst/1,


%% NB NB Has the same name as the <module>:regbus


regbus(1). %% Tram/trikk     %% RS-120803 regbus is generalized in buslog.pl!

regbus(2).
regbus(3).
regbus(4).
regbus(5).
regbus(6).
regbus(7).
regbus(8).
regbus(9).

regbus(10). 
regbus(11). 
regbus(12). %% only summer

regbus(19).    %% New from 2007.03.05

regbus(20).
regbus(24).
% regbus(25).  %% Out 2007

regbus(36).
regbus(38). %% Stjørdal-Melhus. Denne har nok vært med tidligere også. %% RS-150815

regbus(40). %% summer 2006
regbus(41). %% only summer
regbus(43).
regbus(44).
regbus(46).
regbus(47). %%  (Klæbu)
regbus(48). %% Out 070305  %% RS-150815 In again?
regbus(49).

regbus(52).
regbus(54).
regbus(55). 

regbus(60).
regbus(63).
regbus(66).
regbus(67). 

regbus(71).
regbus(73).
regbus(75).
regbus(76).

regbus(80).  
regbus(81).  
regbus(82).
regbus(88).
regbus(89).

regbus(90).
regbus(91).
regbus(92).
regbus(93).
regbus(94).
regbus(95).
regbus(96).
regbus(97). 
regbus(98).

regbus(99).  %% .. not in this period

regbus(254).
regbus(255).

regbus(310). %% RS-150815 Adding new buses. Stjørdal-Trondheim-Fannrem (via E39)
regbus(410). %% RS-150815 Adding new buses. Trondheim-Orkanger (via Fylkesvei 800) 

regbus(777).

regbus(airbus).


%% regbuss from regbussall. %% RS-140413, Experiment.
%% PERIOD INDEPENDENT + CURRENT MODULE (Should be the same?)

regbus(X):- %% TA-110308
   veh_mod(TTP),
   TTP:regbus(X). %, number(X), X  < 10000. %%   e.g. buss 777

%% regbuss from regbussall. %% RS-150815, Experiment. Catch ALL (FUTURE) modules. Time-consuming?
%% PERIOD INDEPENDENT + CURRENT + FUTURE MODULES (Should include extra routes around route updates)

regbus(X):- %% TA-110308
   %route_period(   tt, r1601_150622, date(2015,06,22),   date(2015,08,09) ).    %% Sommer1
   route_period( _Company, TTPeriod, FromDate, _ToDate ),
   todaysdate( Today  ), %% NOT free( date(Y,M,D) )    %% actualdate
   before_date0( Today, FromDate ),  %% Today < FromDate (Future module)

   TTPeriod:regbus(X). %, number(X), X  < 10000. %%   e.g. buss 777


%%  Moved from busdat 
%%  Nightbuses
% nightbus(1).    %% RS-141115  Added night-Trikk
                  %% RS-160108  Make a nighttram-predicate instead! or invent 1n (1-night/natt)

nightbus(103). 
nightbus(104).
nightbus(105).
nightbus(106).
nightbus(107).
nightbus(108).
nightbus(109).
nightbus(119). 
nightbus(136).
nightbus(146).
nightbus(148).
nightbus(149).
nightbus(154).
nightbus(155).
nightbus(175). 
nightbus(188). 
%nightbus(1301).        %% RS-131225    Check this!

%¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
