
add_days(date(YYYY,MM,DD),N,date(YYY2,M2,D2)):- %% < 28 days after
    N >= 0, 
    N < 100, %% Ad Hoc
    D0 is DD+N,
    !,
    monthdays(YYYY,MM,L), 
    (D0 =< L ->  (M1 = MM, D2=D0 );

    RESTDAYS is L-DD, N1 is N-RESTDAYS,
    MM1 is MM+1,
    D01 = 01,

    (MM1 is 13 -> (YYY1 is YYYY +1, 
            add_days_date(date(YYY1,01,D01),N1,date(YYY2,M2,D2));

            add_days_date(date(YYYY,MM1,D01),N1,date(YYY2,M2,D2))))).

