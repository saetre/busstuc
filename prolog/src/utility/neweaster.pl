%% FILE neweaster.pl
%% SYSTEM BUSSTUC
%% AUTHOR Rune Sætre
%% REVISED TA-111118

:-op(800,xfx,isofloor). 

isofloor(X,Y) :-
    X is Y//1.


anonymous(Y,date(Year,Month,Day)):-

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

