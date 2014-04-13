/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE topreg.pl
%% SYSTEM BussTUC DOMAIN TT
%% CREATED TA-981231
%% REVISED TA-120402
%% REVISED RS-121024

%% Contains the important information about route modules. Loaded from interfaceroutes.pl module
%% RS-131223    Included in / Exported throug   busroute.pl
:-module('topreg', [ compilerouteaux/2, default_message/3, default_period/3, period_message/2, routedomain/1, route_period/4 ] ).

% See compileroute.pl for compilation

% See busdat.pl for specialday to day mapping

%% Ny linje
:-ensure_loaded('route_period').        



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

compilerouteaux(tt,[
%%      'db/regbusall', %% Inclusive  set of buses      %% RS-131226 Removed?
        'db/regstr',    %% Streets
        'db/regcompstr' %% Composite Street names
]).

%% DEFAULT ROUTE PERIODS

%default_period(tt,winter, r1601_110822).  %% 2011 Autumn
default_period(tt,winter, r1611_140331).  %% 2014 Winter/Spring?
default_period(tt,summer, r1604_120625).  %% 2013 Summer

%default_message(tt,winter,['AtB winter routes are from  Jan. 2, 2012  to Jun. 26, 2012.',
%                           'AtB vinterruter gjelder fra 2. jan. 2012 til 26. jun. 2012']).
%
default_message(tt,winter,['AtB winter routes are from  Aug. 13 to Dec 23.  2014.',
                           'AtB vinterruter gjelder fra 13. aug. til 23. des. 2014']).

default_message(tt,summer,['AtB summer routes are from Jun. 24 to  Aug. 11. 2014',
                           'AtB sommerruter gjelder fra 24. juni til 11. aug. 2014.']).

%% ACTUAL ROUTE PERIODS  SORTED ON --- END DATE ----
%%see routes.pl


period_message( r1613_130429,
['AtB Routes for Constitution Day',
 'AtB Ruter for 17. mai ']).

period_message( r1630_111201,
['AtB Routes for Tram 2012',
 'AtB Ruter for Trikk 2012']).

period_message( r1613_140415,
['AtB Routes for Easter 2014',
 'AtB Ruter påska 2014']).

period_message( r1614_140415,
['AtB Routes for Easter 2014',
 'AtB Ruter påska 2014']).

period_message( r1615_140415,
['AtB Routes for Easter 2014',
 'AtB Ruter påska 2014']).

period_message( r1604_120625,
['AtB Routes for summer 2014',
 'AtB Sommerruter  2014']).

period_message( r1612_121024,
['AtB Autumn routes',
 'AtB Høstruter']). %% \+ .   %% RS-120810

period_message( r1601_120101,
['AtB Winter routes',
 'AtB Vinterruter']). %% \+ .   %% RS-111220


period_message( r1611_131201,
['AtB Winter routes',
 'AtB Vinterruter']). %% \+ .   %% RS-121223


period_message( r1612_131216,
['Routes for Christmas Eve',
 'Ruter for Julaften']). %% \+ .   %% RS-131223

%%%% 1-2.juledag, 6.juledag, nyttårsdag
period_message( r1613_131216,
['AtB Christmas routes',
 'AtB Juleruter']). %% \+ .   %% RS-131223

period_message( r1614_131216,
['AtB Christmas (Saturday) routes for 27th',
 'Spesial/lørdags-ruter for 27/12']). %% \+ .   %% RS-131223

%%%% 4.5.juledag
period_message( r1615_131216,
['AtB Middle Christmas routes',
 'AtB Ruter for romjulen']). %% \+ .   %% RS-131223

period_message( r1616_131216,
['Routes for New Years Eve',
 'Ruter for Nyttårsaften']). %% \+ .   %% RS-131223

period_message( r1613_131216,
['Routes for New Years Day',
 'Ruter for Nyttårsdagen']). %% \+ .   %% RS-131223


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%% END OF ACTUAL ROUTE PERIODS %%%%%%%%%

