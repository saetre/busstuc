%% FILE topreg.pl
%% SYSTEM BussTUC DOMAIN TT
%% CREATED TA-981231
%% REVISED TA-110622

%% Contains the important information about route modules

:- module( topreg, [
        compilerouteaux/2,
        default_period/3,
        default_message/3,
        routedomain/1,
        route_period/4,
        period_message/2
    ] ).

%:-dynamic   thisdate_period_module/3 .

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

compilerouteaux(tt,['db/regbusall', %% Inclusive  set of buses 
                    'db/regstr',    %% Streets  
                    'db/regcompstr' %% Composite Street names
                   ]).


%% DEFAULT ROUTE PERIODS 


default_period(tt,winter, r1601_100822).  %% 2011
default_period(tt,summer, r1611_100627).  %% 

default_message(tt,winter,['AtB winter routes are from  Aug. 22 2012  to Dec 23.  2011.',
                           'AtB vinterruter gjelder fra 22. aug. 2011 til 23. des. 2011']).

default_message(tt,summer,['AtB summer routes are from Jun. 27 to  Aug. 21. 2011',
                           'AtB sommerruter gjelder fra 27. juni 2011 til 21. aug. 2011.']).



%% ACTUAL ROUTE PERIODS  SORTED ON --- END DATE ----

% Xmas routes before winter routes
% Easter routes before winter routes

%% Route module 'nil' in route_period means that the route module is not implemented yet
%% Important to have dummy route modules to give message of no routes for this date





%%%% ACTUAL  ROUTES              START-DATE           END-DATE



route_period( tt, r1618_110517, date(2011,05,17),    date(2011,05,17)). 
route_period( tt, r1611_100823,  date(2010,08,23),    date(2011,06,26)).  
route_period( tt, r1611_110627, date(2011,06,27),    date(2011,08,14)). 
route_period( tt, r1612_110815, date(2011,08,15),    date(2011,08,21)). 
route_period( tt, r1601_110822, date(2011,08,22),    date(2012,12,23)). 

period_message(r1618_110517,
['AtB Routes for Constitution Day',             
 'AtB Ruter for 17. mai ']). 

period_message(   r1611_100823,                       
['AtB winter routes ',             
 'AtB vinterruter ']). 

period_message(r1611_110627,                     
['AtB Routes for summer 2011',            
 'AtB Ruter sommeren 2011']).

period_message(r1612_110815,                      
['AtB Routes for week 33 (2011)',           
 'AtB Ruter uke 33 (2011)']).

period_message(r1601_110822,                      
['AtB Winter routes',           
 'AtB Vinterruter']). %% \+ . %% TA-110822


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%% END OF ACTUAL ROUTE PERIODS %%%%%%%%%
