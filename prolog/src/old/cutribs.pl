%
%cutloop_connected_rib(Rid1,Station,Rid2):-
%    cutloop_station(Bus,Station),
%
%    passes3(Tour1,Station,Seq,Arr1,_Dep1),
%
%    Seq > 1, % at least not the first
%
%    departureday(Rid1,Tour1,Time1,Day),
%
%    route(Rid1,Bus,_),
%
%    passes3(Tour2,Station,1,_Arr2,_Dep2),
%
%
%    addtotime(Time1,Arr1,TimeX),
%
%    departureday(Rid2,Tour2,Time2,Day),
%
%    route(Rid2,Bus,_), %% same bus
%
%    TimeX =< Time2,  %% maybe the same ?
%
%    addtotime(TimeX,5,TimeY),
% 
%    TimeY >= Time2.
%
%
%
%
%
%
%    
