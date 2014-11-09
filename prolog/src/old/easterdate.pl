%% FILE easterdate.pl
%% SYSTEM BUSSTUC
%% CREATED TA-000617
%% Source   Ronald W.Mallen/ Astronom Society of South Australia, 2000
%% Adapted to Prolog by T.Amble


% Computes date of easter day for a given year

:- meta_predicate  if3( 0, ?, ?, ? ) .

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

if3( Expr, Var, Expr1, Expr2 ) :-
    Expr,!, 
    Var is Expr1
          ;
    Var is Expr2.

mem(X,[U|V]):-X==U;mem(X,V).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

