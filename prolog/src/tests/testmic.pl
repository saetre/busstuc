
:-use_module( '../app/buslog', [ connections/10 ] ).

%connections(StartDeps,EndDeps,Bus,FromPlace,ToPlace,Day,DaySeqNo,Opts,Deps,Mid01):-

testmic:-
 connections(
 [
 [1410,0,1410,bus_20_86,valentinlyst],
 [1425,0,1425,bus_60_90,valentinlyst],
 [1440,0,1440,bus_20_87,valentinlyst],
 [1455,0,1455,bus_60_91,valentinlyst],
 [1510,0,1510,bus_20_88,valentinlyst],
 [1510,0,1510,bus_60_156,valentinlyst],
 [1525,0,1525,bus_20_142,valentinlyst],
 [1525,0,1525,bus_60_92,valentinlyst],
 [1540,0,1540,bus_20_89,valentinlyst],
 [1540,0,1540,bus_60_157,valentinlyst],
 [1555,0,1555,bus_20_143,valentinlyst],
 [1555,0,1555,bus_60_93,valentinlyst]
 ],
 [
  [1521,6,1515,bus_48_87,heimdalsv],
  [1529,24,1505,bus_48_27,heimdalsv],
  [1536,6,1530,bus_48_88,heimdalsv],
  [1536,31,1505,bus_90_3,heimdalsv],
  [1544,24,1520,bus_48_28,heimdalsv]
 ], free(93),valentinlyst,heimdalsv,tuesday,_DaySeq,[time],_4775,_4776).
