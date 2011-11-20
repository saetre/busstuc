

whichrid(Station,Deptime,Day,Rid):-
    passes3(T,Station,_Seq,DelA,DelD),
    departureday(Rid,T,StartTime,Day),
    addtotime(StartTime,DelA,Atime),
    addtotime(StartTime,DelD,Dtime),
    Deptime >= Atime,
    Deptime =< Dtime.





