%% FILE interfaceroute.pl
%% SYSTEN BUSSTUC/BUSTER
%% CREATED TA-040421
%% REVISED TA-060101
%% REVISED  RS-140101 modularized

% Interface procedures for handling interface to route modules

:-module( interfaceroute, [ current_period/4, decide_period/2, domain_module/2, reset_period/0, search_period_module/3,
                            thisdate_period_module/3, valid_period/2 ] ).

% thisdate_period_module( TT, _Module, Period ) contains the actual period... Dynamicly updated by reset_period/0
:-volatile  thisdate_period_module/3 .       %% RS-120915 Not stored in the save_program
:-dynamic   thisdate_period_module/3 .

%:- ensure_loaded( 'declare.pl' ). %, [ := /2 etc. ] ). META:  set/2,   value/2
:- use_module( declare, [ set/2, value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .

:- use_module( sicstus4compatibility, [ output/1 ] ).  %% Compatible with sicstus4, get0/1 etc.

%:- use_module( 'main.pl', [ set/2, value/2 ] ).

%:- use_module( 'utility/writeout', [ output/1 ] ).

:- use_module( 'db/topreg', [ default_period/3, routedomain/1  ]). %% default_message/3, period_message/2,  is not used?, Really?!
:- use_module( 'db/route_period', [ route_period/4  ]). %% default_message/3, period_message/2,  is not used?, Really?!

:- use_module( 'utility/datecalc', [ off_valid_period/3,  on_valid_period/3,   todaysdate/1  ] ).

%% NB  decide_period is called before each question

%% Base Date is the date of today, determines current Period Module
%% Question Date is the date occurring in the question




domain_module(D,M):- 
    routedomain(D), % unique solutions
    route_period( D, M, _, _ ).

reset_period :- %% called from main.pl
    value(tramflag,true),
    set(actual_domain,gb),
    set_period_module(gb),  
    current_period( gb, CP, _, _ ),
    set( actual_period, CP ),

    !. %% ///////// %% RS-140616 Tram ONLY? Use ONLY the FIRST MATCH for a given domain.

reset_period :- %% main.pl
    value(tmnflag,true),
    set(actual_domain,tmn),
    set_period_module(tmn),  
    current_period(tmn,CP,_,_),
    set(actual_period,CP), 

    !. %% ///////// %% RS-140616 Trafikanten MidtNorge ONLY? Use ONLY the FIRST MATCH for a GIVEN domain?

reset_period :- %% NB TT
    set(actual_domain,tt), %% TA-110208
    set_period_module(tt),  %% Default
    current_period(tt,CP,_,_),
    set(actual_period,CP), 

%%%  verify_movedates, %% check consistency  ---> main.pl ---> timedat.pl moved to create_named_dates

    !. %% ///////// %% RS-140616 Don't re-reset period? Use ONLY the FIRST MATCH for a given domain.

reset_period :- output('Reset Period failed'),abort. 


set_period_module(TT) :-       %% Date is the days date, not the date that is asked !
    todaysdate(Date),  %% May change overnight // utility/datecalc.pl
    thisdate_period_module(TT,Date,_Period),
    !.  %% Today is compatible with current period
 
set_period_module(TT) :- 
    todaysdate(Todate), 
    \+  thisdate_period_module(TT,Todate,_CurrentPeriod), % or not assigned
    search_period_module(TT,Todate,NewPeriod),
    !,
    retractall( thisdate_period_module(TT,_,_)),
    assert(     thisdate_period_module(TT,Todate,NewPeriod)),

    !. %% /////////
 
set_period_module(TT) :-
    output('interfacesroute.pl~89: UNABLE TO FIND CURRENT MODULE FOR THIS DATE for '),output(TT).
%%,   abort.



search_period_module(TT,Date,Period):-
    route_period( TT, Period, FromDate, Todate ), % first 
    on_valid_period( Date, FromDate, Todate ),   % that matches
    !.
     
search_period_module(TT,_Date,DO):-  %% BUSTER assumes default winter route
    value(dialog,1),  
    !,
    default_period(TT,winter,DO).   %% AD HOC   TT WINTER ROUTE

search_period_module(_TT,_Date,_Noperiod):- 
    !,
    fail.

current_period( T, CurrentPeriod, Date1, Date2 ):-
    thisdate_period_module( T, _, CurrentPeriod ),      
    route_period( T, CurrentPeriod, Date1, Date2 ),
    !.


valid_period(X,Y):-current_period(_,_,X,Y). 


%%%% Search the special holiday routes first %%%%%


decide_period(DateInQuestion,ThePeriod):- 
    value(actual_domain,TT), 
    search_period_module(TT,DateInQuestion,ThePeriod),
    !,
    set(actual_period, ThePeriod). % actual_period := ThePeriod

decide_period(DateInQuestion,CurrentPeriod):- %% Same date => Period = current period
    value(actual_domain,TT), 
    todaysdate(DateInQuestion), 
    !,
    thisdate_period_module(TT,_,CurrentPeriod),         
    set(actual_period, CurrentPeriod). % actual_period := CurrentPeriod. 

decide_period(DateInQuestion,ActualPeriod):- 
    value(actual_domain,TT),
    current_period(TT,ActualPeriod,Date1,Date2),            %% Extra Check
    on_valid_period(DateInQuestion,Date1,Date2),    %% utility/datecalc
    !,
    set(actual_period, ActualPeriod). %   actual_period := ActualPeriod.    %% This is the Period in the Question

decide_period(DateInQuestion,NextPeriod):- 
    value(actual_domain,TT),  
    current_period(TT,_NOW,Date1,Date2),             %% Extra Check
    off_valid_period(DateInQuestion,Date1,Date2),    %% utility/datecalc
    search_period_module(TT,DateInQuestion,NextPeriod),
    !,
    set(actual_period, NextPeriod). % actual_period := NextPeriod. %% This is the Period in Question

decide_period(_,Nil):-
    !,
    Nil= nil, %% Bloody Trap %% TA-060101
    set(actual_period,nil).  %% actual_period := nil.   


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

