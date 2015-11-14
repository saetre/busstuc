:-module( test, [ whichrid/4 ] ).

:-use_module( '../app/buslog', [ departureday/4 ] ).
%:-use_module( '../db/tables/r1611_200203/regdep.pl', [ departureday/4 ] ).
:-use_module( '../utility/datecalc', [ addtotime/3 ] ).

whichrid(Station,Deptime,Day,Rid):-
    passes3(T,Station,_Seq,DelA,DelD),
    departureday(Rid,T,StartTime,Day),
    addtotime(StartTime,DelA,Atime),
    addtotime(StartTime,DelD,Dtime),
    Deptime >= Atime,
    Deptime =< Dtime.

passes3(_,_,_,_,_).     %% RS-141019    What happened to this predicate?
