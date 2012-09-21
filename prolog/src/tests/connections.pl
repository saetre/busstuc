/* -*- Mode:Prolog; coding:utf-8; -*- */
[new:::(hovedterminalen isa station,være isa station,A isa nightbus,doit/go/A/B,event/real/B,nrel/from/vehicle/place/A/hovedterminalen,nrel/to/vehicle/place/A/være)]
OK!!
trans/Found rule:tqllist2
trans/Found rule:nightbusquery3
trans/Found rule:doubleshunt
trans/Found rule:doubleshuntbe1
trans/Found rule:nightbusmeanstomorrow
trans/Found rule:nottoday1
trans/Found rule:befrom
trans/Found rule:toplace1
trans/Found rule:connectionexplicit
trans/Found rule:setnightbusoption
*** Application program ***

flag(nightbusflag)
atday(sunday)
atdate2(4,date(2012,9,16))
message(date_isa_day(date(2012,9,16),sunday))
message(otherperiod(date(2012,9,16)))
departure(free(23),olav_tryggvasons_gate,4,A)
departure(free(27),være,4,B)
connections(A,B,free(23),olav_tryggvasons_gate,være,sunday,4,[nightbus,to,from],C,D)
flag(exit)
flag(nightbusoption)

%% NEW FORMAT %% TA-110323
% depnode(TimeArr,TimeDep,DelayArr,DelayDep,BegTime,Rid,Bus,SeqNo,Station)
connections(.(depnode(9999,30,999,0,30,bus_0103_0001,103,1,olav_tryggvasons_gate),.(depnode(9999,30,999,0,30,bus_0104_0001,104,1,olav_tryggvasons_gate),.(depnode(9999,30,999,0,30,bus_0106_0001,106,1,olav_tryggvasons_gate),.(depnode(9999,30,999,0,30,bus_0107_0001,107,1,olav_tryggvasons_gate),.(depnode(9999,30,999,0,30,bus_0119_0001,119,1,olav_tryggvasons_gate),.(depnode(9999,30,999,0,30,bus_0136_0001,136,1,olav_tryggvasons_gate),.(depnode(9999,100,999,0,100,bus_0103_0002,103,1,olav_tryggvasons_gate),.(depnode(9999,100,999,0,100,bus_0104_0002,104,1,olav_tryggvasons_gate),.(depnode(9999,100,999,0,100,bus_0106_0002,106,1,olav_tryggvasons_gate),.(depnode(9999,100,999,0,100,bus_0107_0002,107,1,olav_tryggvasons_gate),.(depnode(9999,100,999,0,100,bus_0119_0002,119,1,olav_tryggvasons_gate),.(depnode(9999,100,999,0,100,bus_0136_0002,136,1,olav_tryggvasons_gate),.(depnode(9999,130,999,0,130,bus_0103_0003,103,1,olav_tryggvasons_gate),.(depnode(9999,130,999,0,130,bus_0104_0003,104,1,olav_tryggvasons_gate),.(depnode(9999,130,999,0,130,bus_0106_0003,106,1,olav_tryggvasons_gate),.(depnode(9999,130,999,0,130,bus_0107_0003,107,1,olav_tryggvasons_gate),.(depnode(9999,130,999,0,130,bus_0119_0003,119,1,olav_tryggvasons_gate),.(depnode(9999,130,999,0,130,bus_0136_0003,136,1,olav_tryggvasons_gate),.(depnode(9999,200,999,0,200,bus_0103_0004,103,1,olav_tryggvasons_gate),.(depnode(9999,200,999,0,200,bus_0104_0004,104,1,olav_tryggvasons_gate),.(depnode(9999,200,999,0,200,bus_0106_0004,106,1,olav_tryggvasons_gate),.(depnode(9999,200,999,0,200,bus_0107_0004,107,1,olav_tryggvasons_gate),.(depnode(9999,200,999,0,200,bus_0119_0004,119,1,olav_tryggvasons_gate),.(depnode(9999,200,999,0,200,bus_0136_0004,136,1,olav_tryggvasons_gate),.(depnode(9999,230,999,0,230,bus_0103_0005,103,1,olav_tryggvasons_gate),.(depnode(9999,230,999,0,230,bus_0104_0005,104,1,olav_tryggvasons_gate),.(depnode(9999,230,999,0,230,bus_0106_0005,106,1,olav_tryggvasons_gate),.(depnode(9999,230,999,0,230,bus_0107_0005,107,1,olav_tryggvasons_gate),.(depnode(9999,230,999,0,230,bus_0119_0005,119,1,olav_tryggvasons_gate),.(depnode(9999,230,999,0,230,bus_0136_0005,136,1,olav_tryggvasons_gate),.(depnode(9999,300,999,0,300,bus_0103_0006,103,1,olav_tryggvasons_gate),.(depnode(9999,300,999,0,300,bus_0104_0006,104,1,olav_tryggvasons_gate),.(depnode(9999,300,999,0,300,bus_0106_0006,106,1,olav_tryggvasons_gate),.(depnode(9999,300,999,0,300,bus_0107_0006,107,1,olav_tryggvasons_gate),.(depnode(9999,300,999,0,300,bus_0119_0006,119,1,olav_tryggvasons_gate),.(depnode(9999,300,999,0,300,bus_0136_0006,136,1,olav_tryggvasons_gate),[])))))))))))))))))))))))))))))))))))),.(depnode(53,53,23,23,30,bus_0106_0001,106,31,være),.(depnode(123,123,23,23,100,bus_0106_0002,106,31,være),.(depnode(153,153,23,23,130,bus_0106_0003,106,31,være),.(depnode(223,223,23,23,200,bus_0106_0004,106,31,være),.(depnode(253,253,23,23,230,bus_0106_0005,106,31,være),.(depnode(323,323,23,23,300,bus_0106_0006,106,31,være),[])))))),free(88),olav_tryggvasons_gate,være,sunday,4,.(nightbus,.(to,.(from,[]))),_12636,_12637)
