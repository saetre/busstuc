/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE topreg.pl
%% SYSTEM BussTUC DOMAIN TT
%% CREATED TA-981231
%% REVISED TA-120402
%% REVISED RS-121024

%% Ny linje
%% Ny linje
:-ensure_loaded(route_period).        
%% Contains the important information about route modules

:-volatile  thisdate_period_module/3 .       %% RS-120915
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
%%see routes.pl


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

period_message( r1612_121024,
['AtB Autumn routes',
 'AtB Høstruter']). %% \+ .   %% RS-120810

period_message( r1601_120101,
['AtB Winter routes',
 'AtB Vinterruter']). %% \+ .   %% RS-111220


period_message( r1611_121201,
['AtB Winter routes',
 'AtB Vinterruter']). %% \+ .   %% RS-121223

period_message( r1612_121224,
['Routes for Christmas Eve',
 'Ruter for Julaften']). %% \+ .   %% RS-121223

period_message( r1613_121225,
['AtB Christmas routes',
 'AtB Ruter for julen']). %% \+ .   %% RS-121223

period_message( r1614_121227,
['AtB Christmas routes for 27th',
 'Spesialruter for 27/12']). %% \+ .   %% RS-121223

period_message( r1615_121224,
['Routes for New Years Eve',
 'Ruter for Nyttårsaften']). %% \+ .   %% RS-121223


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%% END OF ACTUAL ROUTE PERIODS %%%%%%%%%




