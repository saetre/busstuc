%% FILE topreg.pl
%% SYSTEM BussTUC DOMAIN TT
%% CREATED TA-981231
%% REVISED TA-110622


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
default_period(tt,winter, r1609_120117).  %% 2012 Winter/Spring?
default_period(tt,summer, r1611_110627).  %% 2011 Summer

default_message(tt,winter,['AtB winter routes are from  Jan. 2 2012  to Dec 23.  2012.',
                           'AtB vinterruter gjelder fra 22. aug. 2012 til 23. des. 2012']).
%
%default_message(tt,winter,['AtB winter routes are from  Aug. 22 to Dec 23.  2012.',
%                           'AtB vinterruter gjelder fra 22. aug. til 23. des. 2012']).

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
%route_period( tt, r1611_110627, date(2011,06,27),    date(2011,08,14) ).
%% route_period( tt, r1612_110815, date(2011,08,15),    date(2011,08,21) ).
%route_period( tt, r1601_110822, date(2011,08,22),    date(2011,12,23) ).
%route_period( tt, r1600_111201, date(2011,12,01),    date(2011,12,23) ).
%route_period( tt, r1601_111224, date(2011,12,24),    date(2011,12,24) ).
%route_period( tt, r1602_111225, date(2011,12,25),    date(2011,12,25) ).
%route_period( tt, r1603_111226, date(2011,12,26),    date(2011,12,26) ).
%route_period( tt, r1603_111227, date(2011,12,26),    date(2011,12,30) ).
%route_period( tt, r1604_111231, date(2011,12,31),    date(2011,12,31) ).
%route_period( tt, r1605_120101, date(2012,1,1),      date(2012,1,1) ).
route_period( tt, r1606_120102, date(2012,1,2),       date(2012,01,11) ).
route_period( tt, r1609_120117, date(2012,1,17),      date(2012,12,31) ).

%period_message( r1618_110517,                        
%['AtB Routes for Constitution Day',             
% 'AtB Ruter for 17. mai ']). 
%
period_message( r1611_110627,                     
['AtB Routes for summer 2011',
 'AtB Ruter sommeren 2011']).

%period_message( r1612_110815,
%['AtB Routes for week 33 (2011)',           
% 'AtB Ruter uke 33 (2011)']).

period_message( r1609_120117,
['AtB Winter routes',
 'AtB Vinterruter']). %% \+ .   %% RS-111220

%period_message( r1601_111224,                      
%['Saturday schedule (Christmas Eve) with last departure (to/from city center) at 15.45',
%% 'AtB Ruter for Julaften']).           %% RS-111218
% 'Lï¿½rdagsrute (Julaften) med siste avganger (til/fra sentrum) kl 15.45']).           %% RS-111223
%
%period_message(r1602_111225,
%['Sunday schedule (Christmas Day) with first departures from 12.30',
%% 'AtB Ruter for fï¿½rste Juledag']).           %% RS-111218
% 'Sï¿½ndagsrute (fï¿½rste Juledag) med fï¿½rste avganger fra kl 12.30']).           %% RS-111223
%
%period_message(r1603_111226,
%['Sunday schedule (2nd Christmas Day)',
% 'Sï¿½ndagsrute (andre juledag)']).           %% RS-111223
%
%period_message(r1603_111227,
%['Saturday Schedule with extra departures (Middle Christmas)',
% 'Lï¿½rdagsruter med ekstra avganger (Mellomjula)']).           %% RS-111223
%
%period_message( r1604_111231,
%['Saturday schedule (New Years Eve) with last departure (to/from city center) at 20.15',
%% 'AtB Ruter for Nyttï¿½rsaften']).           %% RS-111220
% 'Lï¿½rdagsrute (Nyttï¿½rsaften) med siste avganger (til/fra sentrum) kl 20.15']).           %% RS-111223
%
%period_message(r1605_120101,
%['Sunday schedule (New Years Day) with first departures from 12.30',
%% 'AtB Ruter for fï¿½rste Nyttï¿½rsdag']).           %% RS-111218
% 'Sï¿½ndagsrute (Nyttï¿½rsdag) med fï¿½rste avganger fra kl 12.30']).           %% RS-111223

period_message( r1602_120102,
['AtB Winter routes',           
 'AtB Vinterruter']). %% \+ .   %% RS-111220

%period_message( r1601_110822,                      
%['AtB Winter routes',           
% 'AtB Vinterruter']). %% \+ .   %% TA-110822


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%% END OF ACTUAL ROUTE PERIODS %%%%%%%%%
