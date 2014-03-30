:- module( r1630_111201,  [ %% RS-140106    Automate this during regcut creation...
        ex_departureday/4, ex_ntourstops/2, ex_passes4/6, hpl/4,
        ntourstops/2, passes4/6,    %% RS-140106    Automate this, from regpas.pl
        regbus/1, route/3, xi/2
]).

:- ensure_loaded( regbus ). %%,  [ route/3 ] ).    %% RS-140106    Automate this
:- ensure_loaded( reghpl ). %%,  [ hpl/4 ] ).    %% RS-140106    Automate this
:- ensure_loaded( regpas ). %%,  [ passes4/6 ] ).    %% RS-140106    Automate this

% :- module( r1630_111201,  [ hpl/4 ] ).    %% RS-140106    Automate this
%:- module( r1630_111201,  [ passes4/6 ] ).    %% RS-140106    From regpas.pl
%:-module( r1630_111201, [ route/3 ] ).           %% RS-131223    Included in / Exported throug   busroute.pl

%%% 

xi(pax(1,0,0,0),1).
xi(pax(22,0,0,0),2).


%%% 

ex_passes4(1,16010718,st_olavs_gt,1,999,0).
ex_passes4(1,16010719,dronningensgt,2,0,0).
ex_passes4(1,16010724,hospitalkirka,3,1,1).
ex_passes4(1,16010779,kalvskinnet,4,2,2).
ex_passes4(1,16010715,skansen,5,3,3).
ex_passes4(1,16010792,ila,6,4,4).
ex_passes4(1,16010713,bergsli_gate,7,5,5).
ex_passes4(1,16010712,nyveibakken_trondheim,8,6,6).
ex_passes4(1,16010711,bygrensen,9,7,7).
ex_passes4(1,16010740,belvedere,10,8,8).
ex_passes4(1,16019999,breidablikk,11,9,9).
ex_passes4(1,16010709,nordre_hoem,12,10,10).
ex_passes4(1,16010708,søndre_hoem,13,11,11).
ex_passes4(1,16010707,rognheim,14,13,13).
ex_passes4(1,16010706,munkvoll_trikk,15,15,15).
ex_passes4(1,16010705,ferstad,16,16,16).
ex_passes4(1,16010704,ugla_trondheim,17,17,17).
ex_passes4(1,16010703,kyvannet,18,18,18).
ex_passes4(1,16010702,vestmarka,19,19,19).
ex_passes4(1,16010701,herlofsenløypa,20,20,20).
ex_passes4(1,16010700,lian_trondheim,21,21,999).
ex_passes4(2,16010700,lian_trondheim,1,999,0).
ex_passes4(2,16010701,herlofsenløypa,2,1,1).
ex_passes4(2,16011702,vestmarka,3,2,2).
ex_passes4(2,16010703,kyvannet,4,4,4).
ex_passes4(2,16011704,ugla_trondheim,5,5,5).
ex_passes4(2,16010705,ferstad,6,6,6).
ex_passes4(2,16010706,munkvoll_trikk,7,8,8).
ex_passes4(2,16010707,rognheim,8,9,9).
ex_passes4(2,16011708,søndre_hoem,9,10,10).
ex_passes4(2,16010709,nordre_hoem,10,11,11).
ex_passes4(2,16019999,breidablikk,11,13,13).
ex_passes4(2,16010740,belvedere,12,14,14).
ex_passes4(2,16010711,bygrensen,13,15,15).
ex_passes4(2,16010712,nyveibakken_trondheim,14,16,16).
ex_passes4(2,16011792,ila,15,17,17).
ex_passes4(2,16011715,skansen,16,18,18).
ex_passes4(2,16011779,kalvskinnet,17,19,19).
ex_passes4(2,16011724,hospitalkirka,18,20,20).


%%% 

ex_ntourstops(1,21).
ex_ntourstops(2,18).


%%% 

ex_departureday(bus_0001_0001,1,630,42).
ex_departureday(bus_0001_0002,1,645,43).
ex_departureday(bus_0001_0003,1,700,42).
ex_departureday(bus_0001_0004,1,715,43).
ex_departureday(bus_0001_0005,1,730,42).
ex_departureday(bus_0001_0006,1,745,44).
ex_departureday(bus_0001_0007,1,800,42).
ex_departureday(bus_0001_0008,1,815,44).
ex_departureday(bus_0001_0009,1,830,42).
ex_departureday(bus_0001_0010,1,845,44).
ex_departureday(bus_0001_0011,1,900,42).
ex_departureday(bus_0001_0012,1,915,44).
ex_departureday(bus_0001_0013,1,930,42).
ex_departureday(bus_0001_0014,1,945,45).
ex_departureday(bus_0001_0015,1,1000,46).
ex_departureday(bus_0001_0016,1,1015,47).
ex_departureday(bus_0001_0017,1,1030,46).
ex_departureday(bus_0001_0018,1,1045,45).
ex_departureday(bus_0001_0019,1,1100,46).
ex_departureday(bus_0001_0020,1,1115,47).
ex_departureday(bus_0001_0021,1,1130,46).
ex_departureday(bus_0001_0022,1,1145,45).
ex_departureday(bus_0001_0023,1,1200,46).
ex_departureday(bus_0001_0024,1,1215,47).
ex_departureday(bus_0001_0025,1,1230,46).
ex_departureday(bus_0001_0026,1,1245,45).
ex_departureday(bus_0001_0027,1,1300,46).
ex_departureday(bus_0001_0028,1,1315,47).
ex_departureday(bus_0001_0029,1,1330,46).
ex_departureday(bus_0001_0030,1,1345,45).
ex_departureday(bus_0001_0031,1,1400,46).
ex_departureday(bus_0001_0032,1,1415,47).
ex_departureday(bus_0001_0033,1,1430,46).
ex_departureday(bus_0001_0034,1,1445,45).
ex_departureday(bus_0001_0035,1,1500,46).
ex_departureday(bus_0001_0036,1,1515,47).
ex_departureday(bus_0001_0037,1,1530,46).
ex_departureday(bus_0001_0038,1,1545,45).
ex_departureday(bus_0001_0039,1,1600,42).
ex_departureday(bus_0001_0040,1,1615,48).
ex_departureday(bus_0001_0041,1,1630,42).
ex_departureday(bus_0001_0042,1,1645,49).
ex_departureday(bus_0001_0043,1,1700,42).
ex_departureday(bus_0001_0044,1,1715,48).
ex_departureday(bus_0001_0045,1,1730,42).
ex_departureday(bus_0001_0046,1,1745,49).
ex_departureday(bus_0001_0047,1,1800,42).
ex_departureday(bus_0001_0048,1,1815,48).
ex_departureday(bus_0001_0049,1,1830,42).
ex_departureday(bus_0001_0050,1,1845,49).
ex_departureday(bus_0001_0051,1,1915,48).
ex_departureday(bus_0001_0052,1,1945,49).
ex_departureday(bus_0001_0053,1,2015,48).
ex_departureday(bus_0001_0054,1,2045,49).
ex_departureday(bus_0001_0055,1,2115,48).
ex_departureday(bus_0001_0056,1,2145,49).
ex_departureday(bus_0001_0057,1,2215,48).
ex_departureday(bus_0001_0058,1,2245,49).
ex_departureday(bus_0001_0059,1,2315,48).
ex_departureday(bus_0001_0060,1,2345,50).
ex_departureday(bus_0001_0061,1,2400,51).
ex_departureday(bus_0001_0062,1,2415,52).
ex_departureday(bus_0001_0063,1,2515,53).
ex_departureday(bus_0001_0064,1,2615,53).
ex_departureday(bus_0001_0065,1,2715,53).
ex_departureday(bus_0001_0066,2,557,42).
ex_departureday(bus_0001_0067,2,612,43).
ex_departureday(bus_0001_0068,2,627,42).
ex_departureday(bus_0001_0069,2,642,43).
ex_departureday(bus_0001_0070,2,657,42).
ex_departureday(bus_0001_0071,2,712,54).
ex_departureday(bus_0001_0072,2,727,42).
ex_departureday(bus_0001_0073,2,742,44).
ex_departureday(bus_0001_0074,2,757,42).
ex_departureday(bus_0001_0075,2,812,44).
ex_departureday(bus_0001_0076,2,827,42).
ex_departureday(bus_0001_0077,2,842,44).
ex_departureday(bus_0001_0078,2,857,42).
ex_departureday(bus_0001_0079,2,912,45).
ex_departureday(bus_0001_0080,2,927,46).
ex_departureday(bus_0001_0081,2,942,47).
ex_departureday(bus_0001_0082,2,957,46).
ex_departureday(bus_0001_0083,2,1012,45).
ex_departureday(bus_0001_0084,2,1027,46).
ex_departureday(bus_0001_0085,2,1042,47).
ex_departureday(bus_0001_0086,2,1057,46).
ex_departureday(bus_0001_0087,2,1112,45).
ex_departureday(bus_0001_0088,2,1127,46).
ex_departureday(bus_0001_0089,2,1142,47).
ex_departureday(bus_0001_0090,2,1157,46).
ex_departureday(bus_0001_0091,2,1212,45).
ex_departureday(bus_0001_0092,2,1227,46).
ex_departureday(bus_0001_0093,2,1242,47).
ex_departureday(bus_0001_0094,2,1257,46).
ex_departureday(bus_0001_0095,2,1312,45).
ex_departureday(bus_0001_0096,2,1327,46).
ex_departureday(bus_0001_0097,2,1342,47).
ex_departureday(bus_0001_0098,2,1357,46).
ex_departureday(bus_0001_0099,2,1412,45).
ex_departureday(bus_0001_0100,2,1427,46).
ex_departureday(bus_0001_0101,2,1442,47).
ex_departureday(bus_0001_0102,2,1457,46).
ex_departureday(bus_0001_0103,2,1512,45).
ex_departureday(bus_0001_0104,2,1527,42).
ex_departureday(bus_0001_0105,2,1542,48).
ex_departureday(bus_0001_0106,2,1557,42).
ex_departureday(bus_0001_0107,2,1612,49).
ex_departureday(bus_0001_0108,2,1627,42).
ex_departureday(bus_0001_0109,2,1642,48).
ex_departureday(bus_0001_0110,2,1657,42).
ex_departureday(bus_0001_0111,2,1712,49).
ex_departureday(bus_0001_0112,2,1727,42).
ex_departureday(bus_0001_0113,2,1742,48).
ex_departureday(bus_0001_0114,2,1757,42).
ex_departureday(bus_0001_0115,2,1812,49).
ex_departureday(bus_0001_0116,2,1842,48).
ex_departureday(bus_0001_0117,2,1912,49).
ex_departureday(bus_0001_0118,2,1942,48).
ex_departureday(bus_0001_0119,2,2012,49).
ex_departureday(bus_0001_0120,2,2042,48).
ex_departureday(bus_0001_0121,2,2112,49).
ex_departureday(bus_0001_0122,2,2142,48).
ex_departureday(bus_0001_0123,2,2212,49).
ex_departureday(bus_0001_0124,2,2242,48).
ex_departureday(bus_0001_0125,2,2312,50).
ex_departureday(bus_0001_0126,2,2342,55).
ex_departureday(bus_0001_0127,2,2442,53).
ex_departureday(bus_0001_0128,2,2542,53).
ex_departureday(bus_0001_0129,2,2642,53).

