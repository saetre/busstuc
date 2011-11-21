%% FILE  datecalc.pl
%% SYSTEM TUC
%% CREATED TA-010919
%% REVISED TA-110408

% Contains the utility predicates that has to do with dates
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%:- use_module(library(system), [environ/2, datime/1]).
:- use_module( library(system), [datime/1]).

:- use_module( '../db/busdat', []).
:- use_module( '../db/timedat', [clock_delay/3]).

%% should also export : 
% timedat:todaysdate(date(Y,M,D))       %% RS-111120
% timedat:this_year(YYYY) :-

%:- module( utility, [
%    datetime/6,
%    days_between/3,
%    todaysdate/1       %% Lifted up to main -> usually compiled in tucbuses.pl
%   ]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55

% Prolog is really awkard here
convert_zone(YYY, M, D, H,Min,Sec,   YYY,M,D,H,Min,Sec) :- %% TA-080407
    \+ myflags(busflag,true),
    !.

convert_zone(YYY, M, D, H,Min,Sec,
             YYYY,MM,DD,HH,Min,Sec) :-
    clock_delay(0,0,0), %% <--- %% New %% TA-080407
    !,
    YYY=YYYY, %% classic trap ! %% TA-060101
    M=MM,
    D=DD,
    H=HH.

convert_zone(YYY, M, D, H,Min,Sec, 
             YYYY,MM,DD,HH,Min,Sec):-

    clock_delay(SBtime,_,_),     %% busdat.pl  %% TA-080407

%%%     SBtime = -9,             %% test

    H1 is H+SBtime,          %% e.g -9 since SB time is 9 h less.
    conzoneH(YYY, M, D, H1,YYYY,MM,DD,HH).


 
conzoneH(YYYY, MM, DD, HH, YYYY,MM,DD,HH):-  
    ( HH >= 0, HH =< 24 ),
    !.
conzoneH(YYY, M, D, H, YYYY,MM,DD,HH):-  
    (H < 0  -> (D1 is D-1,HH is H+24);
     H > 24 -> (D1 is D+1,HH is H-24);
     D1 = D,HH=H),
    conzoneD(YYY, M, D1, YYYY,MM,DD). %% HH is finished

conzoneD(YYY, M, D, YYYY,MM,DD):- 
     D = 0,
     !,
     M1 is M -1,
     monthdays(YYY,M1,D1),
     conzoneM(YYY,M1,D1, YYYY,MM,DD).
conzoneD(YYY, M, D, YYYY,MM,DD):- 
     monthdays(YYY,M,Max),
     D > Max,
     !,
     D1 = 1,
     M1 is M+1,
     conzoneM(YYY, M1,D1, YYYY,MM,DD).
conzoneD(YYY, M, D, YYY,M,D).

conzoneM(YYYY, M,D, YYYY,MM,DD):-
    D=0,
    M >=2, %% not 1. january
    !,
    previousmonth(M,MM),
    monthdays(YYYY,MM,DD).
conzoneM(YYY, M,_, YYYY,MM,DD):-
    M =1, %%  1. january
    !,
    YYYY is YYY-1,MM=12,DD=31.
conzoneM(YYYY, MM,DD, YYYY,MM,DD):-
    MM >=1,MM =< 12,
    !.
conzoneM(YYY,M,_, YYYY,MM,DD):-
    M > 12,
    !,
    YYYY is YYY+1, MM is 1, DD=1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

%% Rule:  A week must have at least  4  days to count as a week
%% Special rule (e.g. 2010), january  1,2,3 = Week 53 (SIC)

%% 4.1.2009   = week 1
%% 5.1.2009   = week 2
%% 31.12.2009 = week 53
%% 1.1.2010   = week 53 
%% 3.1.2010   = week 53
%% 4.1.2010   = week 1
%% 21.4.2010  = week 16
%% 31.12.2010 = week 52
%% 21.4.2012  = week 16
%% 21.4.2016  = week 16


% weeknumber(Date,WeekNo).
% ?- weeknumber(date(2009,12,28),G). -> G=53

weeknumber(DATE,WeekNo):-  %% (e.g. 2010,Jan 1)
    DATE= date(YYYY,MM,DD),

       NEWYDATE=date(YYYY,01,01), %% ODD year, 1.1= Week 53
       weekday(NEWYDATE,NewYDay), %% 1.1.2009
       dayno(NewYDay,WDNO), %% e.g. friday (saturday or sunday)
       WDNO >= 5, %% Friday

    MM=01,
    DD  + WDNO =< 8, %% before monday
    WeekNo = 53,
    !.


weeknumber(DATE,WeekNo):-  %% (e.g. 2010, Jan 4)
    DATE= date(YYYY,_MM,_DD),

       NEWYDATE=date(YYYY,01,01), %%  ODD year, 1.1= Week 53
       weekday(NEWYDATE,NewYDay), 
       dayno(NewYDay,WDNO), 
       WDNO >= 5, %% Friday   %% not within 1. monday
    !,
    N  is (8-WDNO),
    add_days(NEWYDATE, N, MON1), %% Date of Monday of week 1
    days_between(MON1, DATE,DBTW),
    WeekNo is DBTW//7 + 1.


weeknumber(DATE,WeekNo):-  %% (e.g. 2009, Jan 4)
    DATE= date(YYYY,_MM,_DD),

       NEWYDATE=date(YYYY,01,01), %% Not ODD year, 1.1= Week 1
       weekday(NEWYDATE,NewYDay), 
       dayno(NewYDay,WDNO), 
    !,
    N  is WDNO-1, %% days since 1. monday
    sub_days(NEWYDATE, N, MON1), %% Date of Monday of week 1
    days_between(MON1, DATE,DBTW),
    WeekNo is DBTW//7 + 1.





%%%%%%

days_between(Date1,Date2,N) :-
    before_date1(Date2,Date1),
    !,
    days_between(Date2,Date1,M), %% ugly recursion
    N is -M.
 

%% NB No check on validity of dates
 
days_between(Date1,Date2,N):-  %% Days between within widely different Years
    Date1= date(YYY1,_MM1,_DD1), 
    Date2= date(YYY2,_MM2,_DD2), 
    YYY2 > YYY1 + 1, 
    !, 
    days_between(Date1,date(YYY1,12,31),Rest1), %% careful <> leap day 
    days_between(date(YYY2,01,01),Date2,Rest2), 
    whole_year_days_between(YYY1,YYY2,NYD), % exclusive 
    N is Rest1 + 1 + Rest2 + NYD. 
 


days_between(Date1,Date2,N):- %% Same Year & Month
    Date1= date(YYYY,MM,DD1),
    Date2= date(YYYY,MM,DD2),
    !,
    N is DD2 - DD1.


days_between(Date1,Date2,N):-  %% Days between within same year
    Date1= date(YYYY,MM1,DD1),
    Date2= date(YYYY,MM2,DD2),
    !,
    MM2 > MM1,
    whole_month_days_between(YYYY,MM1,MM2,MDS), % exclusive 
    monthdays(YYYY,MM1,DIM),
    N is  DD2 +(DIM-DD1) +  MDS.


days_between(Date1,Date2,N):- %% Over next year 
    Date1= date(YYYY,_,_),
    Date2= date(YYY1,_,_),
    YYY1 is YYYY+1,
    !,
    days_between(Date1,date(YYYY,12,31),N1),
    days_between(date(YYY1,01,01),Date2,N2),
    N is N1 + (1+N2).


%% whole_year_days_between(YYY1,YYY2,NYD), % exclusive  -- Year 9999

%% Periodic period 400 years = 146097 
  
%% 146097  =  365*400 + 100 (leapdays) -3 ( 100 200 300 , \+ 400)

whole_year_days_between(YYY1,YYY2,NYD) :-
    YYY2 > YYY1,
    Y is YYY1 +1,
    wydays(Y,YYY2,NYD). %% top exclusive



wydays(YYY1,YYY2,NYD) :- %% inclusive
   zerodays(YYY1,N1),    %% top exclusive
   zerodays(YYY2,N2),    %% top exclusive
   NYD is N2 - N1. %% +-

  
zerodays(YYYY,N) :-  %% # days [0000 - YYYY> 
    znofleapdays(YYYY,NL), % top exclusive
    N is YYYY*365 + NL.


znofleapdays(P,N) :- % top exclusive
    P > 0,
    N is 1 + (P-1)//4 - (P-1)//100 + (P-1)//400  .




%%%%%%%%%%%%%%%%%%%%%%



whole_month_days_between(_YYYY,MM1,MM2,MDS):-
    MM2 is MM1 + 1,
    !,
    MDS=0.

whole_month_days_between(YYYY,M1,M2,MDS):-
    !,
    M11 is M1+1,               
    monthdays(YYYY,M11,MX),
    whole_month_days_between(YYYY,M11,M2,MDSX),
    MDS is MX + MDSX.



valid_date(date(YYYY,MM,DD)):-
    YYYY >=  1900,
    YYYY  =< 9999, %% doomsday
    MM >= 1,
    MM =< 31,
    DD >= 1,
    DD =< 31,
    
    Z4 is mod(YYYY,4),
    Z100 is mod(YYYY,100),
    Z400 is mod(YYYY,400),

  ( (Z4 = 0, (\+ Z100 = 0; Z400 = 0)) 
         -> LeapYear = 1;
            LeapYear = 0),
    (MM=2 -> 
         (LeapYear=1 -> Max is 29; Max is 28)
         ;
          monthlength(MM,Max)),
    
    DD =< Max.

   
   

%% New Predicate, relies on busdat.pl

/**
xweekday(Date,HDay):- 
   \+ myflags(nightbusflag,true), %% FICTITIOUS DAYS IRRELEVANT
   \+ myflags(airbusflag,true),   %% TA-090506
   date_day_map(Date,HDay),  %% creates message: 1. Mai. 2010 er en  søndag .WRONG
   !.
**/

xweekday(Date,HDay):-
    weekday(Date,HDay).

todaysdate(date(Y,M,D)):- 
     datetime(Y,M,D,_,_,_).       

%% daysdate(date(Y,M,D)):-   %% Obsolete, kept for security
%%     datetime(Y,M,D,_,_,_).       


dayname(String,Day) :-
	 append(Prefix,_,String),
	 dayprefix(Day,Prefix).


dayprefix(Day,Prefix):-      %%  Solution invariant to
    dayprefix(_,Day,Prefix). %%  unix-installation-language

dayprefix(eng,monday,"Mon").
dayprefix(eng,tuesday,"Tue").
dayprefix(eng,wednesday,"Wed").
dayprefix(eng,thursday,"Thu").
dayprefix(eng,friday,"Fri").
dayprefix(eng,saturday,"Sat").
dayprefix(eng,sunday,"Sun").

dayprefix(nor,monday,"man").
dayprefix(nor,tuesday,"tir").
dayprefix(nor,wednesday,"ons").
dayprefix(nor,thursday,"tor").
dayprefix(nor,friday,"fre").
dayprefix(nor,saturday,"lør").
dayprefix(nor,sunday,"søn").


daysucc(monday,tuesday).
daysucc(tuesday,wednesday).
daysucc(wednesday,thursday).
daysucc(thursday,friday).
daysucc(friday,saturday).
daysucc(saturday,sunday).
daysucc(sunday,monday).

isday(monday).
isday(tuesday).
isday(wednesday).
isday(thursday).
isday(friday).
isday(saturday).
isday(sunday).


number_of_days_between(Thursday,Friday,N):-
    dayno(Thursday,X),
    dayno(Friday,Y),
    N is mod(Y+7-X,7).

dayno(monday,1).
dayno(tuesday,2).
dayno(wednesday,3).
dayno(thursday,4).
dayno(friday,5).
dayno(saturday,6). 
dayno(sunday,7).

%% End of  Import




%% DATE SECTION taken from utility.pl



getdaynew(DayOfWeek):- %%   // Get rid of exec call
     datime( datime(Year,Month,Day,_,_,_) ), %% SICSTUS VERSION, NOT REDEFINABLE
     weekday(date(Year,Month,Day), DayOfWeek). %% weekday.pl


datetime(YYYY,MM,DD,HH,MIN,SEC):- 
    datime( datime(YYY,M,D,H,Min,Sec) ), %% built_in %% Min Sec  stay the same

    convert_zone(YYY, M, D, H, Min,Sec, %% TA-080407
                 YYYY,MM,DD,HH, MIN,SEC).

timedat:this_year(YYYY):-
    datetime(YYYY,_B,_C,_D,_E,_F).


timestring(Z):- %% creates a string of time-point YYYYMMDDHHMMSS
    datetime(X1,X2,X3,X4,X5,X6),
    coerce2d([X1,X2,X3,X4,X5,X6],[D1,D2,D3,D4,D5,D6]),
    concat_atomlist([D1,D2,D3,D4,D5,D6],Z),
    !.
timestring('00000000000000').
%           YYYYMMDDHHMMSS


datestring(Z):- %% creates a string of date  YYYYMMDD
    datetime(X1,X2,X3,_X4,_X5,_X6),
    coerce2d([X1,X2,X3],[D1,D2,D3]),
    concat_atomlist([D1,D2,D3],Z),
    !.
datestring('00000000').
%           YYYYMMDD



previousmonth(1,12):-!.
previousmonth(X,Y):-Y is X -1.

monthdays(_,1,31).

monthdays(Year,2,29):- Z is mod(Year,400), Z ==0,!. %% e.g 2000
monthdays(Year,2,28):- Z is mod(Year,100), Z ==0,!. %% e.g 2100
monthdays(Year,2,29):- Z is mod(Year,4),   Z ==0,!. %% e.g.2004
monthdays(_Yea,2,28).                               %% e.g.2001

monthdays(_,3,31).
monthdays(_,4,30).
monthdays(_,5,31).
monthdays(_,6,30).
monthdays(_,7,31).
monthdays(_,8,31).
monthdays(_,9,30).
monthdays(_,10,31).
monthdays(_,11,30).
monthdays(_,12,31).


 
%% Taken from trans

%%%%  DATE CALCULATIONS  

on_valid_period(X,Y,Z) :- % X in [Y -- Z] inclusive %% TA-110411
   X=date(_,_,_), %% NOT free( ) 
   before_date0(Y,X),
   before_date0(X,Z).


/* %% TA-110411
on_valid_period(X,Y,Z) :- % X in [Y -- Z] inclusive
   X=date(_,_,_), %% NOT free( ) %% TA-110408
   \+ off_valid_period(X,Y,Z),
   !.
*/


off_valid_period(X,Y,Z) :- % X is not in [Y -- Z]
   (before_date1(X,Y)
    ;
    before_date1(Z,X)),    
    !.




findfirstcomingdate(Day,Date):- 
    named_date(Day, Date),
    !.


findfirstcomingdate(easterhol,Date):- %% TA-050322 = easterday
    named_date(easterday, Date),
    !.


findfirstcomingdate(Day,Date):- 
    today(X),
    number_of_days_between(X,Day,N),
    finddate(N,Date).


finddate(Displacement,Date) :- 
    Displacement >= 0,
    !,
    datetime(Y,M,D,_,_,_),
    add_days(date(Y,M,D),Displacement,Date).

finddate(Displacement,Date) :- 
    Displacement < 0, 
    !,
    NegDisp is  - Displacement,
    datetime(Y,M,D,_,_,_),
    sub_days(date(Y,M,D),NegDisp,Date). 



add_days(date(YYYY,MM,DD),N,date(YYY2,M2,D2)):- %% < 28 days after
    N >= 0, 
    N =< 366, %% TA-100106
    D0 is DD+N,
    !,
    monthdays(YYYY,MM,L), 

    (D0 =< L ->  (YYY2=YYYY,M2 = MM, D2=D0 );

    (RESTDAYS is L-DD+1, 
     N1 is N-RESTDAYS,
     MM1 is MM+1,
     D01 = 01,

    (MM1 is 13 -> (YYY1 is YYYY +1, 
            add_days(date(YYY1,01,D01),N1,date(YYY2,M2,D2)))
            ;
            add_days(date(YYYY,MM1,D01),N1,date(YYY2,M2,D2)))
    )).




%% < 28 days before // simplified , not earlier than previous month

sub_days(date(YYYY,MM,DD),N,date(YYY2,M2,D2)):- %% same month
    N > 0, N < 28,
    D0 is DD - N,
    D0 > 0,
    !,
    YYY2=YYYY,
    M2=MM,
    D2=D0.

sub_days(date(YYYY,MM,DD),N,date(YYY2,M2,D2)):- %% from January to December
    N > 0, N < 28,
    D0 is DD - N,
    D0 =< 0,
    MM = 01,
    !,
    YYY2 is YYYY-1,
    M2=12,
    D2 is 31+D0.

sub_days(date(YYYY,MM,DD),N,date(YYY2,M2,D2)):- %% Previous month, same year
    N > 0, N < 28, 
    D0 is DD -N,
    D0 =< 0,
    !,
    YYY2 = YYYY,
    M2 is MM-1,
    monthdays(YYYY,M2,ML2), 
    D2 is D0+ML2.





before_date0(date(Y,M,D),date(Y1,M1,D1)):- %% TA-110411
  ( Y < Y1;
    Y = Y1, M < M1 ;
    Y = Y1, M= M1, D =< D1),
  !.



before_date1(date(Y,M,D),date(Y1,M1,D1)):-
  ( Y < Y1;
    Y = Y1, M < M1 ;
    Y = Y1, M= M1, D < D1),
  !.

monthlength( 1,31).
monthlength( 2,28).
monthlength( 3,31).
monthlength( 4,30).
monthlength( 5,31).
monthlength( 6,30).
monthlength( 7,31).
monthlength( 8,31).
monthlength( 9,30).
monthlength(10,31).
monthlength(11,30).
monthlength(12,31).

%%%%%%%%%%%%%%%%%%%%%%%%%



%% FILE  weekday.pl
%% SYSTEM Busstuc
%% CREATED  Peter Ludemann/Andy Lowry
%% ADAPTED   T.Amble 2000/5/29
%% REVISED TA-001214


/*

The following code is used to figure out the day of week
for any date.

The main predicate is  day_of_week/2, which accepts the date in
a number of formats.  So, you can
try queries such as:


	?- day_of_week(1992/dec/25, D).
	?- day_of_week(1992/12/25,  D).
	?- day_of_week(1992/'December'/25, D).


This algorithm was published in {\tt comp.programming} and comes from
\begin{tabbing}
    Andy Lowry, lowry@watson.ibm.com, (914) 784-7925        \\
    IBM Research, P.O. Box 704, Yorktown Heights, NY 10598
\end{tabbing}


First, there is a special key value for each month and a
correction factor for January and February in leap years.
*/


cal_key( 1, 'January',   jan, 6, 1).
cal_key( 2, 'February',  feb, 2, 1).
cal_key( 3, 'March',     mar, 2, 0).
cal_key( 4, 'April',     apr, 5, 0).
cal_key( 5, 'May',       may, 0, 0).
cal_key( 6, 'June',      jun, 3, 0).
cal_key( 7, 'July',      jul, 5, 0).
cal_key( 8, 'August',    aug, 1, 0).
cal_key( 9, 'September', sep, 4, 0).
cal_key(10, 'October',   oct, 6, 0).
cal_key(11, 'November',  nov, 2, 0).
cal_key(12, 'December',  dec, 4, 0).

month_name(Number, Name) :- cal_key(Number, Name, _, _, _).


%% Next, we associate a number with each day of the week:


dow(0, 'Sunday',    sunday).
dow(1, 'Monday',    monday).
dow(2, 'Tuesday',   tuesday).
dow(3, 'Wednesday', wednesday).
dow(4, 'Thursday',  thursday).
dow(5, 'Friday',    friday).
dow(6, 'Saturday',  saturday).

%% The day of week computation is rather arcane, but it works.  Note the
%% correction for leap years.

weekday(date(Year,Month,Day), DayOfWeek) :- %% Special TUC date frmat
        Century is Year // 100,
        YearInCentury is Year - Century * 100,
        (  cal_key(Month, _, _, Key, LeapC)
        ;  cal_key(_, Month, _, Key, LeapC)
        ;  cal_key(_, _, Month, Key, LeapC)
        ), !,
 
        YearDay is (Century * 5 + Century // 4 +
                 YearInCentury + YearInCentury // 4) mod 7 ,

        (leap_year(Year) -> LeapYear is LeapC; LeapYear is 0),

        DOW is ( YearDay + 
                 Day + Key  -  LeapYear 
                 ) mod 7,

        dow(DOW, _, DayOfWeek).

/**

A leap year is any year which is divisible by 4; if it is also
divisible by 100 then it must also be divisible by 400 (thus,
1600 and 2000 are leap years; 1700, 1800, and 1900 are not).

**/

leap_year(Year) :-
        mod(Year,4) =:= 0,
       (mod(Year,100) =:= 0 -> 
            mod(Year,400) =:=0 
            ; 
            true ). %% TA-001214


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FILE easterdate.pl
%% SYSTEM BUSSTUC
%% CREATED TA-110107
%% REVISED  TA-110107
%% Source  Wikipedia  -- Anonymus
%% Adapted to Prolog by T.Amble


% Computes date of easter day for a given year


:-op(800,xfx,isofloor). 

isofloor(X,Y) :-   %% NB floor() SICS gives float (SIC)
    X is floor(Y). %%    floor() ISO  gives integer

easterdate(Y,date(Year,Month,Day)):-

    A is Y mod 19,
    B isofloor (Y/100),
    C is Y mod 100,
    D isofloor (B/4),
    E is B mod 4,
    F isofloor ((B+8)/25),
    G isofloor ((B-F+1)/3),
    H is (19*A+B-D-G+15) mod 30,
    I isofloor (C/4),
    K is C mod 4,
    L is (32+2*E+2*I-H-K) mod 7,
    M isofloor ((A+11*H+22*L)/451),

    Year is Y,
    Month isofloor ((H+L-7*M+114)/31),
    Day is ((H+L-7*M+114)mod 31)+1.


/**** Old version   Gives wrong answer for 2011   

easterdate(Y,Date):-

    FirstDig is Y // 100,
 
    Remain19 is Y mod 19,

% Calculate Paschal Full Moon (PMF) date

    Temp is (FirstDig-15)//2 +202 -11*Remain19,

    if3(FirstDig > 26, Temp1,Temp -1,Temp),

    if3(FirstDig > 38,Temp2,Temp1-1,Temp1),

    if3( mem(FirstDig,[21,24,33,36,37]),Temp3,Temp2 -1,Temp2),

    Temp4 is  Temp3 mod 30,

    Ta is Temp4 + 21,

    if3( (Temp4 = 28 ,Remain19 > 10), Ta1,Ta -1, Ta), 

% find next sunday

    Tb is (Ta -19) mod 7,

    Tc is (40 - FirstDig) mod 4,

    if3(Tc =3,  Tc1, Tc + 1, Tc),

    if3(Tc > 1, Tc2, Tc1 +1, Tc1),

    Temp5 is Y mod 100,

    Td is (Temp5 + Temp5//4) mod 7,

    Te is ((20 -Tb - Tc2 - Td) mod 7) +1,

    D is Ta1+ Te,

% return date

    if3( D > 31,M,4,3),

    if3( D > 31,D1,D - 31,D),

    Date = date(Y,M,D1).

% utils

if3(Expr,Var,Expr1,Expr2):- 
    Expr,!, 
    Var is Expr1
          ;
    Var is Expr2.

mem(X,[U|V]):-X==U;mem(X,V).



**** */



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

