/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE dmeq.pl
%% SYSTEM BUSTER/TELEBUSTER
%% CREATED TA-051011
%% REVISED TA-100829

%% Domain Equivalents common  tele and bus
:-module( dmeq, [ dmeq/2 ] ).

%% UNIT: /
:- use_module( '../declare', [ value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .
%:- use_module( '../main', [ value/2 ] ).

%% UNIT: utility/
:- use_module( '../utility/utility', [ testmember/2 ] ).%:- ensure_loaded( user:'../utility/utility' ).       %% RS-131231
:- use_module( '../tuc/semantic', [ subclass0/2 ] ).

%%%%%%%% dmeq( A, B ) : B betyr det samme som A i dette domenet;
%%%%%%%% dmeq( List,B): B er et av ordene i LIST;
%%%%%%%% First argument must be bound !!!


dmeq( List, U ) :-   %% traps var
    \+ atom(List),
    !,      
    testmember(U,List).    %% utility.pl


dmeq(about,about).
dmeq(about,of).  
dmeq(about,over).  
dmeq(about,regarding). 
dmeq(about,with). % oversikt med busser

dmeq(after,after).
dmeq(after,from).    %%  (time, Norwagism)
dmeq(after,over). 
dmeq(after,after1).  %% strictly after

dmeq(amble,tore).    %% RS-110926

dmeq(around,about).   %% should have been synonym in sem ? 
dmeq(around,around).
dmeq(around,in). 

dmeq(arrdep,arrival).
dmeq(arrdep,clock).  
dmeq(arrdep,departure).
dmeq(arrdep,route_plan). 
dmeq(arrdep,time). 
dmeq(arrdep,way). %  muligheter 


dmeq(at,at).
dmeq(at,below). 
dmeq(at,in).
dmeq(at,nil).
dmeq(at,on).


dmeq(attime,nil). 
dmeq(attime,at). 
dmeq(attime,in). 

dmeq(battime,nil). 
dmeq(battime,by). %% TA-090505 by 6'oclock
dmeq(battime,before).
dmeq(battime,at).  
dmeq(battime,in).
dmeq(battime,to). %% Norwagism   framme til 1234.
dmeq(battime,within).

dmeq(beforenil,before).
dmeq(beforenil,nil). 
dmeq(beforenil,to).     %% Norwagism (være på Nardo til 0800)  


%  dmeq(bepass,be1). %% if be, other rules apply
dmeq(bepass,exist). 
dmeq(bepass,live). 
dmeq(bepass,X):-dmeq(pass,X).

dmeq(between,between).
dmeq(between,during). %% during 9 to 10
dmeq(between,in).     %% i tiden 1800 - 2000 

dmeq(bus,bus).
dmeq(bus,nightbus). %% Haz ?
dmeq(bus,route). 
dmeq(bus,route_plan). 
dmeq(bus,trip). 
dmeq(bus,vehicle).

% dmeq(bus,direction).  %%  e.g. way % retning singsaker "=" bus singsaker   SIC!

dmeq(busdeparrtime,arrival).
dmeq(busdeparrtime,bus).  
dmeq(busdeparrtime,clock).
dmeq(busdeparrtime,departure).
dmeq(busdeparrtime,direction).   %% veg -> direction ( in stead of route)
dmeq(busdeparrtime,route). 
dmeq(busdeparrtime,route_plan).  
dmeq(busdeparrtime,saturdayroute). 
dmeq(busdeparrtime,sundayroute). 
dmeq(busdeparrtime,time). 
dmeq(busdeparrtime,tram). 
dmeq(busdeparrtime,trip). 
dmeq(busdeparrtime,vehicle).
dmeq(busdeparrtime,self).  %% jeg drar dit

dmeq(busdeparr,arrival).
dmeq(busdeparr,bus).         %% what time is it OOPS
dmeq(busdeparr,departure).
dmeq(busdeparr,direction).   %% veg -> direction ( in stead of route)
dmeq(busdeparr,route). 
dmeq(busdeparr,route_plan). 
dmeq(busdeparr,tram). 
dmeq(busdeparr,vehicle).  

dmeq(busdeparrN,vehicle). 
dmeq(busdeparrN,nightbus).
dmeq(busdeparrN,X):- 
   dmeq(busdeparr,X). 

%% dmeq(busdeparr,time).        %%  IKKE ALLE NÅR-spørsmål

dmeq(busstation,station).   
dmeq(busstation,busstation). %%  (busstation is new subclass)

dmeq(by,around). 
dmeq(by,at).
dmeq(by,by).
dmeq(by,dir). 
dmeq(by,for).  %% passage for bus 
%% dmeq(by,in).   %% ( in John Aaaes veg ) EXPERIMENT failed %% TA-100902
dmeq(by,near). 
dmeq(by,nil).
dmeq(by,off).    %%   passeringer av nth ( a bit artificial )
dmeq(by,over).
dmeq(by,past).
dmeq(by,through).

% dmeq(by,on).     %%   EXPERIMENT  AVH on Rosenborg \= AVH past Rosenborg
% dmeq(by,to).     %%  Correct ?

dmeq(can,understand). 
dmeq(can,know1). 
dmeq(can,know).

dmeq(change,change).

dmeq(clock,clock).
dmeq(clock,time). 


dmeq(colour,black).
dmeq(colour,blue).
dmeq(colour,brown).
dmeq(colour,cyan).
dmeq(colour,grey).
dmeq(colour,gray).
dmeq(colour,green).
dmeq(colour,orange).
dmeq(colour,pink).
dmeq(colour,purple).
dmeq(colour,red).
dmeq(colour,violet).
dmeq(colour,white).
dmeq(colour,yellow).

dmeq(come,come).
dmeq(come,arrive).
dmeq(come,reach).
dmeq(come,stop).

dmeq(day,day).
dmeq(day,afternoon).
dmeq(day,morning).
dmeq(day,night).
dmeq(day,evening).

dmeq(dayordate,day). 
dmeq(dayordate,date).

dmeq(dayordate,monday). %% TA-100829
dmeq(dayordate,tuesay).
dmeq(dayordate,wednesday).
dmeq(dayordate,thursday).
dmeq(dayordate,friday).
dmeq(dayordate,saturday).
dmeq(dayordate,sunday).

dmeq(duration,duration). 
dmeq(duration,traveltime). 
dmeq(duration,time). 

dmeq(evening,in_evening).   
dmeq(evening,tonight).

dmeq(exist,exist).
dmeq(exist,be1). 


dmeq(for,for).
dmeq(for,on).
dmeq(for,at).

dmeq(from,from). %% also awayfrom ?

dmeq(hour,hour).
dmeq(hour,duration). 
dmeq(hour,time).   %%  Semantics may be vague (time IS tid, no pun)


dmeq(information,information).
dmeq(information,list). 

dmeq(intime,nil).
dmeq(intime,in).

dmeq(knownlanguage,norsk).
dmeq(knownlanguage,bokmål).
dmeq(knownlanguage,nynorsk).
dmeq(knownlanguage,norwegian).
dmeq(knownlanguage,english).

dmeq(leave,start).
dmeq(leave,leave).
dmeq(leave,depart).

dmeq(list,list).   % the verb
dmeq(list,give).  
dmeq(list,write).
dmeq(list,show). 

dmeq(minute,minute).
dmeq(minute,time).     %% Semantics may be vague
dmeq(minute,duration). 

dmeq(morning,in_morning).
dmeq(morning,this_morning).

dmeq(mtwtfss, monday).
dmeq(mtwtfss, tuesday).
dmeq(mtwtfss, wednesday).
dmeq(mtwtfss, thursday).
dmeq(mtwtfss, friday).
dmeq(mtwtfss, saturday).
dmeq(mtwtfss, sunday).
dmeq(mtwtfss, weekend). 

dmeq(notbus,airbus). 
dmeq(notbus,boat). 
dmeq(notbus,boat_route_plan).
dmeq(notbus,helicopter).
dmeq(notbus,nightbus) :- \+  value(nightbusflag,true). 
dmeq(notbus,airplane). 
dmeq(notbus,plane).     %% 
dmeq(notbus,schoolbus). 
dmeq(notbus,taxi).
dmeq(notbus,train). 
dmeq(notbus,tram).
dmeq(notbus,train_route_plan). 
dmeq(notbus,tram_route_plan). 
dmeq(notbus,otherbus). 
dmeq(notbus,underground). 
% dmeq(notbus,car).   means bus 

dmeq(nato,on). %% wanna be ...
dmeq(nato,at).
dmeq(nato,outside). 
dmeq(nato,in).      %% in sentrum
dmeq(nato,nil).     %%  Jeg vil ankomme  nardo før 18 og er på nth.

dmeq(near,at).
dmeq(near,close).
dmeq(near,in). 
dmeq(near,near).
dmeq(near,nearer).
dmeq(near,nearest).
dmeq(near,on). 
dmeq(near,outside). 

dmeq(nearat,nil).   
dmeq(nearat,around).
dmeq(nearat,at).
dmeq(nearat,below). 
dmeq(nearat,close).
dmeq(nearat,in).
dmeq(nearat,near).  
dmeq(nearat,nearer).
dmeq(nearat,nearest).
dmeq(nearat,on).
dmeq(nearat,outside). 
dmeq(nearat,within).  

dmeq(onoff,on).
dmeq(onoff,off). 

dmeq(onto,on).  %% Ad hoc 
dmeq(onto,to).

dmeq(pass,arrive).
dmeq(pass,be1).  %% alle hpl som buss 63 er ved 
dmeq(pass,come).
dmeq(pass,depart).
dmeq(pass,drive).
dmeq(pass,get). 
dmeq(pass,go).
dmeq(pass,leave).
dmeq(pass,pass).
dmeq(pass,reach).
dmeq(pass,see).  %% want to see Rosenborg
dmeq(pass,run).
dmeq(pass,serve).
dmeq(pass,start).
dmeq(pass,stop).

dmeq(passby,drive).
dmeq(passby,go).
dmeq(passby,go2). %% follow
dmeq(passby,leave).     %%  NB  leave is neutral wrt direction
dmeq(passby,pass).
dmeq(passby,run).
dmeq(passby,serve).
dmeq(passby,cover). 

dmeq(place,airport). 
dmeq(place,busstation).
dmeq(place,city). 
dmeq(place,community). 
dmeq(place,country). 
dmeq(place,county).       %% TA-090818
dmeq(place,municipality). %% TA-090818
dmeq(place,neighbourhood).
dmeq(place,place).
dmeq(place,station).
dmeq(place,stop).
dmeq(place,street).  

dmeq(pm,afternoon).    %% Expression denoting after 1200 AM 
dmeq(pm,evening). 
dmeq(pm,in_afternoon).
dmeq(pm,in_evening). 
dmeq(pm,in_night). 
dmeq(pm,night). 
dmeq(pm,tonight).

dmeq(position,first).
dmeq(position,next).
dmeq(position,last).
dmeq(position,previous). 


dmeq(quarter,quarter).  
dmeq(quarter,duration).
dmeq(quarter,time).  %%  Semantics may be vague (time IS tid, no pun)

dmeq(see,see). 
dmeq(see,get). 
dmeq(see,receive).

dmeq(show,give).
dmeq(show,show). 
dmeq(show,list). 
dmeq(show,tell). 

dmeq(speak,answer). 
dmeq(speak,ask).
dmeq(speak,know).  %% TA-091130
dmeq(speak,know1). 
dmeq(speak,speak). 
dmeq(speak,talk). %% TA-090728
dmeq(speak,understand).
dmeq(speak,use). 

dmeq(stand,stand).
dmeq(stand,be).  
dmeq(stand,be1). 

dmeq(teacher,T) :- subclass0(T,teacher). %% tele, fernando.pl

dmeq(ticket,activity). %%  SIC (techn)
dmeq(ticket,adult). 
dmeq(ticket,child).
dmeq(ticket,bus).      %% (SIC)
dmeq(ticket,price).    %% (?)
dmeq(ticket,ticket).
dmeq(ticket,person).
dmeq(ticket,route).   %% (reise)
dmeq(ticket,trip).    %% (reise)
dmeq(ticket,season_ticket). 
dmeq(ticket,special_ticket). 
dmeq(ticket,vehicle).        %%  ( tram, train ???? )
 
dmeq(take,take).
dmeq(take,reach).

dmeq(time,time).
dmeq(time,duration).
dmeq(time,clock).

dmeq(timeclock,time). %%  NOT duration
dmeq(timeclock,clock). 

dmeq(timeprep,nil). 
dmeq(timeprep,before).
dmeq(timeprep,after).
dmeq(timeprep,around).
dmeq(timeprep,at).

dmeq(timeclass,time). %%  buss på kvelden ==> srel/on/evening/E 
dmeq(timeclass,evening).
dmeq(timeclass,daypart). 
%% etc ad nauseam

dmeq(timeunit,second). %%  :-)
dmeq(timeunit,minute).
dmeq(timeunit,hour).
dmeq(timeunit,day).    %% :-)

dmeq(to,on).    %% Busstider for buss 9 på Teglverkskrysset. 
dmeq(to,to).
dmeq(to,for).      %% Anglicism, not 100% correct in Norwegian
dmeq(to,towards). 

dmeq(tofromby,at).
dmeq(tofromby,by).
dmeq(tofromby,for).
dmeq(tofromby,from).
dmeq(tofromby,in).
dmeq(tofromby,nil).
dmeq(tofromby,on).
dmeq(tofromby,over).
dmeq(tofromby,past).
dmeq(tofromby,through).
dmeq(tofromby,to).
% dmeq(tofromby,off).  

dmeq(trafficant,arrival). 
dmeq(trafficant,airbus).   %% TA-090331
dmeq(trafficant,bus).          %%  allowed to go by bus ( e.g. no cats )
dmeq(trafficant,car). 
dmeq(trafficant,departure). 
dmeq(trafficant,direction).    %% far fetched ???  %% hvilken vei går til
dmeq(trafficant,duration).     %% technical: varigheten er fra A til B
dmeq(trafficant,eveningroute).
dmeq(trafficant,nightbus).
dmeq(trafficant,number). %% TA-091215 in case nr 7 \= route 7
dmeq(trafficant,route). 
dmeq(trafficant,route_plan). %% hvilke trasee går til
dmeq(trafficant,tram).  
dmeq(trafficant,tram_route_plan). 
dmeq(trafficant,trip).
dmeq(trafficant,vehicle).
dmeq(trafficant,way). %% muligheter Rough 

dmeq(trafficant,Person):- 
    subclass0(Person,agent). %% kan man ta

dmeq(tram,tram_route_plan). 
dmeq(tram,tram). 

dmeq(travel,arrive). 
dmeq(travel,come).
dmeq(travel,depart).
dmeq(travel,drive).
dmeq(travel,exist). %% is there a bus now 
dmeq(travel,get).
dmeq(travel,go).
dmeq(travel,leave).
dmeq(travel,pass). 
dmeq(travel,run).  
dmeq(travel,stop). 
dmeq(travel,take).
dmeq(travel,think).   %% tenker på buss
dmeq(travel,travel).
% dmeq(travel,use).   %% use a bus


dmeq(travelbe,be1).   %% will be obsolete
dmeq(travelbe,see).   %% see Nidrasosdomen
dmeq(travelbe,start). 
dmeq(travelbe,X):-dmeq(travel,X).



 %% travel, intention to depart

dmeq(travelfrom,arrive). %% ankommer fra Rydningen ? 
dmeq(travelfrom,be1).    %% om busser fra = busser som er fra 
dmeq(travelfrom,come).
dmeq(travelfrom,depart).
dmeq(travelfrom,drive).
dmeq(travelfrom,exist). %% is there a bus now 
dmeq(travelfrom,get).
dmeq(travelfrom,go).
dmeq(travelfrom,leave).
dmeq(travelfrom,move). %% TA-100125
dmeq(travelfrom,pass). 
dmeq(travelfrom,run).  
dmeq(travelfrom,start).
dmeq(travelfrom,take).
dmeq(travelfrom,think).   %% tenker på buss
dmeq(travelfrom,travel).

 %% travel, intention to arrive
dmeq(travelto,be1).  
dmeq(travelto,leave). %% leave from ts TO  NTNU %% (cant be choosy)  
dmeq(travelto,see).   %% see Nidarosdomen
dmeq(travelto,start). 
dmeq(travelto,arrive). 
dmeq(travelto,come).
dmeq(travelto,depart). %% depart from A TO B
dmeq(travelto,drive).
dmeq(travelto,exist). %% is there a bus now 
dmeq(travelto,get).
dmeq(travelto,go).
dmeq(travelto,move).  %% TA-100125
dmeq(travelto,pass). 
dmeq(travelto,run).  
dmeq(travelto,stop). 
dmeq(travelto,take).
dmeq(travelto,think).   %% tenker på buss
dmeq(travelto,travel).


dmeq(tuc,bustuc).  
dmeq(tuc,busstuc). 
dmeq(tuc,buster). 
dmeq(tuc,smstuc). 
dmeq(telebuster,tuc).  
dmeq(tuc,tuc).      %% My names :-) 

dmeq(use,use).
dmeq(use,take).

dmeq(vehicle,bus).
dmeq(vehicle,airbus).  %% TA-090331
dmeq(vehicle,car).  
dmeq(vehicle,arrival). 
dmeq(vehicle,departure).
dmeq(vehicle,nightbus). 
dmeq(vehicle,number). 
dmeq(vehicle,route).
dmeq(vehicle,route_plan). 
dmeq(vehicle,tram).
dmeq(vehicle,trip). %%  ta en reise
dmeq(vehicle,vehicle).

dmeq(where,home).
dmeq(where,here). 
dmeq(where,there). 

dmeq(within,nil).    %% Technical:  be present 1300 => be nil 1300
dmeq(within,at).
dmeq(within,before).
dmeq(within,by). 
dmeq(within,in).     %%  contra   in means possibly  i 8 tiden 
dmeq(within,on).     %%  (Norwagism) på 30 minutter
dmeq(within,to).     %% Norwagism   til Kl 2100
dmeq(within,until). 
dmeq(within,within).
%  dmeq(within,during). %% om 30 minutter => during 30 minutes == after 30 minutes
