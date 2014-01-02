%% FILE  weekday.pl
%% SYSTEM Busstuc
%% CREATED  Peter Ludemann/Andy Lowry
%% ADAPTED   T.Amble 2000/5/29
%% REVISED TA-001214

%% MOVED TO -> utility/datecalc.pl

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
