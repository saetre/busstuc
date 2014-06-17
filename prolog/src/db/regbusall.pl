/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE regbusall.pl
%% SYSTEM BUSSTUC DOMAIN TT
%% CREATED TA-020101
%% REVISED TA-110824    RS-120803
%% REVISED RS-140416    Keep using this! % No regbus after buslog.pl:regbusall was implemented?  %% RS-120803

:- module( regbusall, [ nightbus/1, regbus/1 ] ). %% HEAVY DB! %% RS-120803 RS-131225 regbus/1 MOVED to app/buslog.pl
%% Inclusive set of bus routes

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

regbus(19).    %% New from 5.3.07

regbus(20).
regbus(24).
 regbus(25).  %% Out 2007

regbus(36).

regbus(40). %% summer 2006
regbus(41). %% only summer
regbus(43).
regbus(44).
regbus(46).
regbus(47). %%  (Klæbu)
 regbus(48). %% Out 070305
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
regbus(777).


%%  Moved from busdat 
%%  Nightbuses
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
