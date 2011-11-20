%% FILE noroute.pl 
%% SYSTEM TUC
%% CREATED TA-000307
%% REVISED TA-011017

% Compiles an Empty Busroute table for Text analysis

%% to be used insted of busroute to have a non bus route application.



:-dynamic  hpl/3,
           regbus/1,
           station/1,
           composite_stat/3,
           composite_road/3,
           departureday/4,
           streetstat/5,
           cname/2,

           tram:regbus/1,
           tram:route/3,         
%           tram:passes2/4, %% TA-011030
           tram:passes3/4,  %% TA-011017
           tram:departureday/4,
           tram:hpl/3,
           tram:composite_stat/3.
            


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
