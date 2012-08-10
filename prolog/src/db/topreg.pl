/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE topreg.pl
%% SYSTEM BussTUC DOMAIN TT
%% CREATED TA-981231
%% REVISED TA-120402


%% Contains the important information about route modules

:-dynamic   thisdate_period_module/3 .

% See compileroute.pl for compilation

% See busdat.pl for specialday to day mapping


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

compilerouteaux(tt,[ %% 'db/regbusall', %% Inclusive  set of buses
                    'db/regstr',    %% Streets
                    'db/regcompstr' %% Composite Street names
                   ]).

%% DEFAULT ROUTE PERIODS

%default_period(tt,winter, r1601_110822).  %% 2011 Autumn
default_period(tt,winter, r1602_120813).  %% 2012 Winter/Spring?
default_period(tt,summer, r1604_120625).  %% 2012 Summer

%default_message(tt,winter,['AtB winter routes are from  Jan. 2, 2012  to Jun. 26, 2012.',
%                           'AtB vinterruter gjelder fra 2. jan. 2012 til 26. jun. 2012']).
%
default_message(tt,winter,['AtB winter routes are from  Aug. 13 to Dec 23.  2012.',
                           'AtB vinterruter gjelder fra 13. aug. til 23. des. 2012']).

default_message(tt,summer,['AtB summer routes are from Jun. 27 to  Aug. 21. 2012',
                           'AtB sommerruter gjelder fra 27. juni til 21. aug. 2012.']).



%% ACTUAL ROUTE PERIODS  SORTED ON --- END DATE ----

% Xmas routes before winter routes
% Easter routes before winter routes

%% Route module 'nil' in route_period means that the route module is not implemented yet
%% Important to have dummy route modules to give message of no routes for this date





%%%% ACTUAL  ROUTES              START-DATE           END-DATE (sorted!)



%% route_period( tt, r1618_110517, date(2011,05,17),    date(2011,05,17) ).
%% route_period( tt, r1611_100823, date(2010,08,23),    date(2011,06,26) ).
route_period( tmn, r1630_101201, date(2011,12,01),    date(2011,12,31) ).
%route_period( tt, r1609_120120, date(2012,01,20),    date(2012,12,31) ).
%route_period( tt, r1601_120201, date(2012,02,01),    date(2012,12,31) ).
%route_period( tt, r1602_120401, date(2012,04,01),    date(2012,04,08) ).
%route_period( tt, r1603_120409, date(2012,04,09),    date(2012,05,12) ). %% Overwrote 120415
route_period( tt, r1602_120517, date(2012,05,17),    date(2012,05,17) ).
route_period( tt, r1601_120415, date(2012,04,15),    date(2012,06,24) ).
%route_period( tt, r1602_120425, date(2012,04,25),    date(2012,06,24) ).       %Mangler alle linjer over 79

route_period( tt, r1604_120625, date(2012,06,25),    date(2012,08,12) ).
%route_period( tt, r1611_110627, date(2012,06,27),   date(2012,08,14) ).
route_period( tt, r1602_120813, date(2012,08,13),    date(2012,12,22) ).
route_period( tt, r1601_120101, date(2012,01,01),    date(2012,12,31) ).
route_period( gb, r1630_111201, date(2011,12,01),    date(2012,12,31) ).


period_message( r1602_120517,
['AtB Routes for Constitution Day',
 'AtB Ruter for 17. mai ']).

period_message( r1630_111201,
['AtB Routes for Tram 2012',
 'AtB Ruter for Trikk 2012']).

period_message( r1602_120401,
['AtB Routes for Easter 2012',
 'AtB Ruter påska 2012']).

period_message( r1604_120625,
['AtB Routes for summer 2012',
 'AtB Sommerruter  2012']).

period_message( r1602_120813,
['AtB Autumn routes',
 'AtB Høstruter']). %% \+ .   %% RS-120810

period_message( r1601_120101,
['AtB Winter routes',
 'AtB Vinterruter']). %% \+ .   %% RS-111220


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%% END OF ACTUAL ROUTE PERIODS %%%%%%%%%
