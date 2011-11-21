%% FILE interfaceroute.pl
%% SYSTEN BUSSTUC/BUSTER
%% CREATED TA-040421
%% REVISED TA-060101

% Interface procedures for handling interface to route modules

%:- use_module( 'db/timedat', [todaysdate/1] ).  % database functions, for time and days
:- use_module( 'utility/utility', [output/1] ).  % utility functions

%% NB  decide_period is called before each question

%% Base Date is the date of today, determines current Period Module
%% Question Date is the date occurring in the question


% thisdate_period_module(TT,_,Period) contains the actual period Dynamic


domain_module(D,M):- 
    routedomain(D), % unique solutions
    route_period(D,M,_,_).

reset_period :- %% called from main.pl
    myflags(gbflag,true),  
    set(actual_domain,gb), 
    set_period_module(gb),  
    current_period(gb,CP,_,_),
    set(actual_period,CP), 
    !. %% /////////

reset_period :- %% main.pl
    myflags(tmnflag,true),
    set(actual_domain,tmn),
    set_period_module(tmn),  
    current_period(tmn,CP,_,_),
    set(actual_period,CP), 
    !. %% /////////



reset_period :- %% NB TT
    set(actual_domain,tt), %% TA-110208
    set_period_module(tt),  %% Default
    current_period(tt,CP,_,_),
    set(actual_period,CP), 

%%%  verify_movedates, %% check consistency  ---> main.pl

    !. %% /////////

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
 
set_period_module(_TT_) :- 
    output('UNABLE TO FIND CURRENT MODULE FOR THIS DATE'),
    abort.



search_period_module(TT,Date,Period):-
    route_period(TT,Period,FromDate,Todate), % first 
    on_valid_period(Date,FromDate,Todate),   % that matches
    !.
     
search_period_module(TT,_Date,DO):-  %% BUSTER assumes default winter route
    myflags(dialog,1),  
    !,
    default_period(TT,winter,DO).   %% AD HOC   TT WINTER ROUTE

search_period_module(_TT,_Date,_Noperiod):- 
    !,
    fail.

current_period(T,CurrentPeriod,Date1,Date2):-
    thisdate_period_module(T,_,CurrentPeriod),      
    route_period(T,CurrentPeriod,Date1,Date2),
    !.


valid_period(X,Y):-current_period(_,_,X,Y). 


%%%% Search the special holiday routes first %%%%%


decide_period(DateInQuestion,ThePeriod):- 
    myflags(actual_domain,TT), 
    search_period_module(TT,DateInQuestion,ThePeriod),
    !,
    set(actual_period, ThePeriod). % actual_period := ThePeriod

decide_period(DateInQuestion,CurrentPeriod):- %% Same date => Period = current period
    myflags(actual_domain,TT), 
    todaysdate(DateInQuestion), 
    !,
    thisdate_period_module(TT,_,CurrentPeriod),         
    set(actual_period, CurrentPeriod). % actual_period := CurrentPeriod. 

decide_period(DateInQuestion,ActualPeriod):- 
    myflags(actual_domain,TT),
    current_period(TT,ActualPeriod,Date1,Date2),            %% Extra Check
    on_valid_period(DateInQuestion,Date1,Date2),    %% utility/datecalc
    !,
    set(actual_period, ActualPeriod). %   actual_period := ActualPeriod.    %% This is the Period in the Question

decide_period(DateInQuestion,NextPeriod):- 
    myflags(actual_domain,TT),  
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

