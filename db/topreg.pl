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
routedomain(gb).  %% Gr�kallbanen
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
default_period(tt,winter, r1605_120102).  %% 2012 Winter/Spring?
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
route_period( tt, r1611_110627, date(2011,06,27),    date(2011,08,14) ).
route_period( tt, r1609_120120, date(2011,08,15),    date(2011,08,21) ).

%period_message( r1618_110517,                        
%['AtB Routes for Constitution Day',             
% 'AtB Ruter for 17. mai ']). 
%
period_message( r1611_110627,                     
['AtB Routes for summer 2011',
 'AtB Ruter sommeren 2011']).

period_message( r1609_120120,
['AtB Winter routes',
 'AtB Vinterruter']). %% \+ .   %% RS-111220


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%% END OF ACTUAL ROUTE PERIODS %%%%%%%%%
