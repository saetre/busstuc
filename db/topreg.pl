/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE topreg.pl
%% SYSTEM BussTUC DOMAIN TT
%% CREATED TA-981231
%% REVISED TA-120402
%% REVISED RS-121024

%% Contains the important information about route modules. Loaded from interfaceroutes.pl module
%% RS-131223    Included in / Exported throug   busroute.pl
:-module('topreg', [ compilerouteaux/2, default_message/3, default_period/3, period_message/2, routedomain/1 ] ). % , route_period/4

% See compileroute.pl for compilation

% See busdat.pl for specialday to day mapping

%% Ny linje
%:-use_module( 'route_period', [ route_period/4 ] ).



%%%%%%%%%% THIS TABLE IS CRUCIAL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% route_period must be sorted according to their end date        %

%%% SEE ALSO busdat.pl for special dates !!!!!!!!!!!!!!!!!!!!!! %%
%%% Update period_message and  default_period !!!               %%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Route Domains %%

routedomain(tt).  %% Team Trafikk
routedomain(gb).  %% Gråkallbanen
routedomain(fb).  %% Flybussen
routedomain(tmn). %% Generic for TMN related routes


%% TT (Team Trafikk) %%%%%%%

%% Special list to be compiled

compilerouteaux( tt, [
        'db/regbusall', %% Inclusive  set of buses      %% RS-131226 Removed?
        'db/regstr',    %% Streets
        'db/regcompstr' %% Composite Street names
]).

%% DEFAULT ROUTE PERIODS

%default_period(tt,winter, r1601_110822).  %% 2011 Autumn
default_period( tt, winter,  r1601_160815).  %% 2016 Winter (Christmas/Spring?)
default_period( tt, summer,  r1601_160620).  %% 2016 Summer

%default_period(tt,previous, r1611_140203 ).  %% 2014 Most recently period used %% RS-140616
%default_period(tt,previous, r1601_150622 ).  %% 2015 Most recently period used
%default_period(tt,previous, r1601_160620 ).  %% 2016_2 Most recently period used %% RS-151219
default_period( tt,previous, r1601_160815 ).  %% 2016_1 Most recently period used %% RS-151219

%default_message(tt,winter,['AtB winter routes are from  Jan. 2, 2012  to Jun. 26, 2012.',
%                           'AtB vinterruter gjelder fra 2. jan. 2012 til 26. jun. 2012']).
%
default_message(tt,winter,['AtB winter routes are from  Aug. 15 to Dec 23.  2016.',
                           'AtB vinterruter gjelder fra 15. aug. til 23. des. 2016']).

default_message(tt,summer,['AtB summer routes are from Jun. 26 to  Aug. 18. 2017',
                           'AtB sommerruter gjelder fra 26. juni til 18. aug. 2017.']).

%% ACTUAL ROUTE PERIODS  SORTED ON --- END DATE ----
%%see routes.pl


% 17. mai

%Lørdagsruter med første avgang fra kl 08.30 med tilleggsturer.
period_message( r1611_140517,
[ 'AtB Routes for Constitution Day are as Saturday, starting from 8.30 o´clock',
  'AtB Lørdagsruter for 17. mai, med første avgang fra kl 08.30 og noen tilleggsturer']).

% Tram 

period_message( r1630_111201,
['AtB Routes for Tram 2012',
 'AtB Ruter for Trikk 2012']).

% Easter

period_message( r1611_150330,
['AtB Routes for Easter 2015',
 'AtB Ruter påska 2015']).

period_message( r1612_150330,
['AtB Routes for Easter 2015',
 'AtB Ruter påska 2015']).

period_message( r1613_150330,
['AtB Routes for Easter 2015',
 'AtB Ruter påska 2015']).

% Summer

period_message( r1601_170626,
['AtB Routes for summer 2017',
 'AtB Sommerruter  2017']).

period_message( r1602_150810,
['AtB Routes for summer 2015',
 'AtB Sommerruter  2015']).

% Autumn

%period_message( r1603_151012,
%['New Autumn routes',
% 'Endrede Høstruter']). %% \+ .   %% RS-151004

period_message( r1601_160815,
['AtB Autumn routes',
 'AtB Høstruter']). %% \+ .   %% RS-160813


%period_message( r1611_141020,
%['End of Daylight Saving Time!',
% 'Husk Vintertid!']). %% \+ .   %% RS-120810

% Winter

period_message( r1611_131201,
['AtB Winter routes',
 'AtB Vinterruter']). %% \+ .   %% RS-121223


%period_message( r1611_141201,
%['Normal Routes',               %% RS-141207.
% 'Vanlige Ruter']). %% \+ .   %% 01.12.14 – 23.12.14, 27.12.14 – 28.12.14 og 02.01.15 – 11.01.15

% Christmas

%period_message( r1612_141223,
%['Routes for Christmas Eve',
% 'Ruter for Julaften']). %% \+ .   %% RS-131223

%Christmas 2015
%route_period(   tt, r1611_151214, date(2015,12,14),   date(2016,12,22) ).       %% Juleruter
%route_period(   tt, r1615_151214, date(2015,12,14),   date(2015,12,23) ).       %% Desember23_27_30
%route_period(   tt, r1612_151214, date(2015,12,14),   date(2015,12,25) ).       %% Julaften_25des
%route_period(   tt, r1613_151214, date(2015,12,14),   date(2015,12,26) ).       %% Desember26_28_29
%route_period(   tt, r1615_151214, date(2015,12,14),   date(2015,12,27) ).       %% Desember23_27_30
%route_period(   tt, r1613_151214, date(2015,12,14),   date(2015,12,29) ).       %% Desember26_28_29
%route_period(   tt, r1615_151214, date(2015,12,14),   date(2015,12,30) ).       %% Desember23_27_30
%route_period(   tt, r1614_151214, date(2015,12,14),   date(2015,12,31) ).       %% Nyttårsaften
%route_period(   tt, r1611_151214, date(2015,12,14),   date(2016,01,17) ).       %% Juleruter

period_message( r1611_151214,
['Routes for Christmas',
 'Ruter for Julen']). %% \+ .   %% RS-131223

period_message( r1612_151214,
['Routes for Christmas',
 'Ruter for Julen']). %% \+ .   %% RS-131223

%%%% 1-2.juledag, 6.juledag, nyttårsdag
period_message( r1613_151214,
['Routes for Christmas',
 'Ruter for Julen']). %% \+ .   %% RS-131223
%['AtB 1st Christmas Day routes',
% 'AtB Juleruter 1.juledag']). %% \+ .   %% RS-131223

%['AtB Christmas (Saturday) routes for 27th',
% 'Spesial/lørdags-ruter for 27/12']). %% \+ .   %% RS-131223

period_message( r1614_151214,
['Routes for New Years Eve',
 'Ruter for Nyttårsaften']). %% \+ .   %% RS-131223

period_message( r1615_151214,
['Routes for Christmas',
 'Ruter for Julen']). %% \+ .   %% RS-131223
%['AtB Middle Christmas routes',
% 'AtB Ruter for romjulen']). %% \+ .   %% RS-131223

%%%% 4.5.juledag
%period_message( r1612_141223,
%['Routes for New Years Day',
% 'Ruter for Nyttårsdagen']). %% \+ .   %% RS-131223


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% RS-140616 This was moved to another file at some point: route_period.pl

/* -*- Mode:Prolog; coding:utf-8; -*- */
%% Generated by class regtopToBusTUC.TopRegUpdate on 2014-05-12 09:11:44.696

% Xmas routes before winter routes
% Easter routes before winter routes

%% Route module 'nil' in route_period means that the route module is not implemented yet
%% Important to have dummy route modules to give message of no routes for this date

%%%% ACTUAL  ROUTES              START-DATE           END-DATE (sorted!)

%%%route_period( tt, r1601_130930, date(2013,09,30),   date(2014,07,22) ).       %% Høst2013oktober
%route_period(   tmn,r1630_101201, date(2012,12,01),   date(2014,12,31) ).
%route_period(   gb, r1630_111201, date(2012,12,01),   date(2014,12,31) ).  %% Graakallbanen
%route_period(   tt, r1605_140102, date(2014,01,02),   date(2015,01,01) ).       %% 2014v1, %% NyttPrinsenkryss, vinter2013-2014
%%route_period(   tt, r1611_200203, date(2020,02,03),   date(2020,04,13) ).      %% Ruter med trikk

%%%%%% END OF ACTUAL ROUTE PERIODS %%%%%%%%%

