


minvalarrs(L,M) :-
    set_of(TimeArr,member(depnode(TimeArr,_TimeDep,_,_,_,_,_),L),K),
    minimum(K,M).


minvaldeps(L,M) :-
    set_of(TimeDep,member(depnode(_TimeArr,TimeDep,_,_,_,_,_),L),K),
    minimum(K,M).



maxvalarrs(L,M) :-
    set_of(TimeArr,member(depnode(TimeArr,_TimeDep,_,_,_,_,_),L),K),
    maximum(K,M).


maxvaldeps(L,M) :-
    set_of(TimeDep,member(depnode(_TimeArr,TimeDep,_,_,_,_,_),L),K),
    maximum(K,M).

