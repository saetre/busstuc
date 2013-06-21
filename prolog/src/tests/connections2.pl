%[new:::(sentrum isa neighbourhood,være isa station,A isa nightbus,do/go/A/B,event/real/B,nrel/from/vehicle/place/A/sentrum,nrel/to/vehicle/place/A/være)]
%IKKE MULIG!
%trans/Found rule:tqllist2
%trans/Found rule:nightbusquery3
%trans/Found rule:doubleshunt
%trans/Found rule:doubleshuntbe1
%trans/Found rule:nightbusmeanstomorrow
%trans/Found rule:nottoday1
%trans/Found rule:befrom
%trans/Found rule:toplace1
%trans/Found rule:connectionexplicit
%trans/Found rule:setnightbusoption
%*** Application program ***
%
%flag(nightbusflag)
%atday(sunday)
%atdate2(4,date(2012,9,16))
%message(date_isa_day(date(2012,9,16),sunday))
%message(otherperiod(date(2012,9,16)))
%departure(free(28),hovedterminalen,4,A)
%departure(free(32),være,4,B)
%connections(A,B,free(28),hovedterminalen,være,sunday,4,[nightbus,to,from],C,D)
%flag(exit)
%flag(nightbusoption)

%% NEW FORMAT %% TA-110323

% depnode(TimeArr,TimeDep,DelayArr,DelayDep,BegTime,Rid,Bus,SeqNo,Station)

