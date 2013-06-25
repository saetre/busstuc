/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE makeframe2.pl
%% SYSTEM TELEBUSTER
%% CREATED TLF-030409 TA-081107

%% REVISED                  COMMON VERSION

:- ensure_loaded('../declare'). %% RS-111213 General (semantic) Operators
:- ensure_loaded('../app/pragma'). %% RS-111213 Pragmatic (rule) Operators


:- module(makeframe,[]). %% - maketeleframe  %% RS-130624 Experiment from 2012?


tracevalue(X):- user:value(traceprog,X),!; X=1.

returnfields rule %% TA-051030
is  present teleprocess([A,B|C],_,_,_) %% at least one (hope they are valid)
id  not frame_setvalue(return, _),
    add frame_setvalue(return,[A,B|C])
ip  [].



fieldtelephone rule
is  present teleprocess([telephone],_,_,_)
id  not frame_setvalue(return, _),
    add frame_setvalue(return, [telephonenumber])
ip  [].

fieldfirstname rule
is  present teleprocess([firstname],_,_,_)
id  not frame_setvalue(return,_),
    add frame_setvalue(return, [givenname])
ip  [].

fieldlastname rule
is  present teleprocess([lastname],_,_,_)
id  not frame_setvalue(return,_),
    add frame_setvalue(return, [sn])
ip  [].

fieldcount rule
is  present teleprocess([count],_,_,_)
id  not frame_setvalue(return,_),
    add frame_setvalue(return, [count])
ip  [].

fieldplace rule
is  present teleprocess([place],_,_,_)
id  not frame_setvalue(return,_),
	add frame_setvalue(return, [roomnumber])
ip	[].

fieldroom rule %% TA-061009
is  present teleprocess([room],_,_,_)
id  not frame_setvalue(return,_),
	add frame_setvalue(return, [roomnumber])
ip	[].

fieldoffice rule
is  present teleprocess([office],_,_,_)
id  not frame_setvalue(return,_),
	add frame_setvalue(return, [roomnumber])
ip	[].

fieldname rule
is 	present teleprocess([name],_,_,_)
id	not frame_setvalue(return,_),
	add frame_setvalue(return,[cn])
ip	[].

fielddepartment rule
is 	present	teleprocess([department],_,_,_)
id	not frame_setvalue(return,_),
	add frame_setvalue(return,[ou])
ip  [].

fieldmail rule
is 	present teleprocess([mailaddress],_,_,_)
id	not frame_setvalue(return,_),
	add frame_setvalue(return,[mail])
ip	[].

fieldmail1 rule
is 	present teleprocess([mail],_,_,_)
id	not frame_setvalue(return,_),
	add frame_setvalue(return,[mail])
ip	[].

fieldadress rule
is	present teleprocess([address],_,_,_)
id	not frame_setvalue(return,_),
	add	frame_setvalue(return,[street]) %% TA-050921 (was return,[mail])
ip	[].

fieldtitle rule
is	present teleprocess([title],_,_,_)
id	not frame_setvalue(return,_),
	add	frame_setvalue(return,[title])
ip	[].

fieldunknown rule
is  present teleprocess([unknown],_,_,_)
id  not frame_setvalue(return,[unknown]),
    add frame_setvalue(return,[unknown])
ip	[].


attribute_givenname rule
is present teleprocess(_,_,AtrList,_)
id not frame_setvalue(attributes::givenname, _),
   add frame_setvalue(attributes::givenname, Value)
ip member(firstname=Value,AtrList).



newlastname_oldfirstname rule %% TA-060609
is present teleprocess(_,_,AtrList,_),
       {  member(lastname=Oien,AtrList), %% TA-081107
          frame_getvalue(attributes::sn,Amble,_Type),
          Oien \== Amble}
id not frame_setvalue(attributes::sn, _),
   add frame_setvalue(attributes::sn, Oien),
   add frame_setvalue(attributes::givenname,?) %% reset firstname if new lastname
ip [].




attribute_sn rule
is present teleprocess(_,_,AtrList,_)
id not frame_setvalue(attributes::sn, _),
   add frame_setvalue(attributes::sn, Value)
ip member(lastname=Value,AtrList).

attribute_department rule
is present teleprocess(_,_,AtrList,_)
id not frame_setvalue(attributes::department, _),
   add frame_setvalue(attributes::department, Value)
ip member(department=Value,AtrList).

attribute_mail rule
is present teleprocess(_,_,AtrList,_)
id not frame_setvalue(attributes::mail, _),
   add frame_setvalue(attributes::mail, Value)
ip member(mail=Value,AtrList).

attribute_cn rule
is present teleprocess(_,_,AtrList,_)
id not frame_setvalue(attributes::cn, _),
   add frame_setvalue(attributes::cn, Value)
ip member(pname=Value,AtrList).

attribute_title rule
is present teleprocess(_,_,AtrList,_)
id not frame_setvalue(attributes::title, _),
   add frame_setvalue(attributes::title, Value)
ip member(title=Value,AtrList).

attribute_telephonenumber rule
is present teleprocess(_,_,AtrList,_)
id not frame_setvalue(attributes::telephonenumber, _),
   add frame_setvalue(attributes::telephonenumber, Value)
ip member(Tel=Value,AtrList),
   (Tel=tel;Tel=telephone).

attribute_roomnumber rule
is present teleprocess(_,_,AtrList,_)
id not frame_setvalue(attributes::roomnumber, _),
   add frame_setvalue(attributes::roomnumber, Value)
ip member(roomnumber=Value,AtrList).

%%%%%%%% =================


%% FILE makeframe.pl


%% relax keepbefore if flag(laterbus)

relaxkeepbefore rule    %% TA-050502
is     flag(laterbus)
id     add frame_setvalue((when)::arrival::before, ?)  %% TA-051109
     , add frame_setvalue((when)::departure::before, ?) %% maybe old constraint
ip     [].
    


%% relax keepafter if flag(laterbus)

relaxkeepafter rule    %% TA-050502
is     flag(earlierbus)
id     add frame_setvalue((when)::departure::after, ?) %% TA-051109
     ,  add frame_setvalue((when)::arrival::after, ?)     %% maybe old constraint
ip     [].
    




instant1_before rule %% TA-021128
is	replace (timenow2(DD,X), keepbefore(X, A, B)) %% TA-041006
     	with	keepbefore(Y, A, B)
id	[]
ip	timenow2(DD,Y).

instant1_after rule  %% TA-021128
is	replace (timenow2(DD,X), keepafter(X, A, B)) %% TA-041006
     	with	keepafter(Y, A, B)
id	[]
ip	timenow2(DD,Y).

toplace rule                       %% ØF-990303
is     present departure(_, Place, _, Dep), 
       present depset(to, DepList)
id     not frame_setvalue(where::arrival, _),
       add frame_setvalue(where::arrival, Place)
ip     varmember(Dep, DepList),
       \+ Place = free(_).

fromplace rule                       %% ØF-990303
is     present departure(_, Place, _, Dep), 
       present depset(from, DepList)
id     not frame_setvalue(where::departure, _),
       add frame_setvalue(where::departure, Place)
ip     varmember(Dep, DepList),
       \+ Place = free(_).


nilplacetofrom rule       
is     present departure(_, Place, _, _Dep), 
       present depset(unknown,_ ) %%%%   [Dep]) %% TA-050411
id     not frame_setvalue(where::unknown, _),
       not frame_setvalue(where::departure, _),
       not frame_setvalue(where::arrival, _),
       not framevalue(where::departure, Place),  % NB
       not framevalue(where::arrival, Place),   % NB
      add frame_setvalue(where::unknown, Place)
ip     % varmember(Dep, DepList),
       \+ Place = free(_).



fromafter rule                       %% ØF-990303
is     present depset(from, DepList),
       present keepafter(Time, Dep, _)
id     not frame_setvalue((when)::departure::after, _),
       add frame_setvalue((when)::departure::after, Time)
ip     bound(Time), varmember(Dep, DepList).

frombefore rule                       %% ØF-990303
is     present depset(from, DepList),
       present keepbefore(Time, Dep, _)
id     not frame_setvalue((when)::departure::before, _),
       add frame_setvalue((when)::departure::before, Time)
ip     bound(Time), varmember(Dep, DepList).

frombefore1 rule                       %% ØF-990303
is     present depset(from, DepList),
       present keepbefore1(Time, Dep, _)
id     not frame_setvalue((when)::departure::before, _),
       add frame_setvalue((when)::departure::before, Time)
ip     bound(Time), varmember(Dep, DepList).

frombetween rule
is     present depset(from, DepList),
       present keepbetween(LowTime, HighTime, Dep, _)
id     not frame_setvalue((when)::departure::after, _),
       add frame_setvalue((when)::departure::after, LowTime),
       not frame_setvalue((when)::departure::before, _),
       add frame_setvalue((when)::departure::before, HighTime)
ip     bound(LowTime), bound(HighTime), varmember(Dep, DepList).

toafter rule                       %% ØF-990303
is     present depset(to, DepList),
       present keepafter(Time, Dep, _)
id     not frame_setvalue((when)::arrival::after, _),
       add frame_setvalue((when)::arrival::after, Time)
ip     bound(Time), varmember(Dep, DepList).




toalett rule                       %% TA-030913
is     replace   depset(unknown, _depList_)  with %% TA-050411
                 depset(arrival, _depList_) 



id     present framevalue(where::departure,_NTH_), % have a departure
       not present frame_setvalue(where::arrival,_Dragvoll_), %% TA-030913
       replace frame_setvalue(where::unknown,Dragvoll) with
               frame_setvalue(where::arrival,Dragvoll) % know it's arrival
ip     [].

toat rule                       %% TA-030913
is     present depset(unknown, DepList),
       present keepat(Time, Dep, _)

id     present framevalue(where::departure,_NTH_), % have a departure
       not frame_setvalue((when)::departure::after, Time), %% already decided
       not frame_setvalue((when)::arrival::before, _),
       add frame_setvalue((when)::arrival::before, Time),
 
       replaceif frame_setvalue(where::unknown,Dragvoll) with %% <--- if 
               frame_setvalue(where::arrival,Dragvoll)

ip     bound(Time), varmember(Dep, DepList).

fromlett rule                       %% TA-030913
is     present depset(unknown, _DepList_)
id     present framevalue(where::arrival,_NTH_), % have a arrival
       not present frame_setvalue(where::departure,_Dragvoll_), 
       replace frame_setvalue(where::unknown,Dragvoll) with
               frame_setvalue(where::departure,Dragvoll) % know it's departure
ip     [].

fromat rule                       %% TA-030913
is     present depset(unknown, DepList),
       present keepat(Time, Dep, _)
id     present framevalue(where::arrival,_NTH_), % have a arrival
       not frame_setvalue((when)::arrival::before, Time), %% already decided
       not frame_setvalue((when)::departure::after, _),
       add frame_setvalue((when)::departure::after, Time),
 
       replaceif frame_setvalue(where::unknown,Dragvoll) with %% <--- if 
               frame_setvalue(where::departure,Dragvoll)


ip     bound(Time), varmember(Dep, DepList).


tobefore rule                       %% ØF-990303
is     present depset(to, DepList),
       present keepbefore(Time, Dep, _)
id     not frame_setvalue((when)::arrival::before, _),
       add frame_setvalue((when)::arrival::before, Time)
ip     bound(Time), varmember(Dep, DepList).

tobefore1 rule                       %% ØF-990303
is     present depset(to, DepList),
       present keepbefore1(Time, Dep, _)
id     not frame_setvalue((when)::arrival::before, _),
       add frame_setvalue((when)::arrival::before, Time)
ip     bound(Time), varmember(Dep, DepList).

tobetween rule
is     present depset(to, DepList),
       present keepbetween(LowTime, HighTime, Dep, _)
id     not frame_setvalue((when)::arrival::after, _),
       add frame_setvalue((when)::arrival::after, LowTime),
       not frame_setvalue((when)::arrival::before, _),
       add frame_setvalue((when)::arrival::before, HighTime)
ip     bound(LowTime), bound(HighTime), varmember(Dep, DepList).



nils rule     %% AD HOC Når går buss 5/ Dragvoll    %% TA-031110
is     present departure(_, Dragvoll, _, Dep), 
       present depset(unknown,[Dep])   %% depset(unknown -> depset(to %% TA-031111

id     frame_setvalue(where::unknown, Dragvoll),
       not frame_setvalue(where::departure, _),
       not frame_setvalue(where::arrival, _),
       not framevalue(where::departure, Dragvoll), 
       not framevalue(where::arrival, Dragvoll), 
       replace frame_setvalue(where::unknown, Dragvoll)
       with    frame_setvalue(where::arrival, Dragvoll)
ip     \+ Dragvoll = free(_).






tobus rule                       %% ØF-990303
is     present departure(Bus, _, _, Dep), 
       present depset(to, DepList)
id     not frame_setvalue(bus, _),   %% JFR frombus
       add frame_setvalue(bus, Bus)  %% TA-030126

     %%  not frame_setvalue(arrival::bus, _),  %% TA-030126
     %%  add frame_setvalue(arrival::bus, Bus) %% TA-030126

ip     varmember(Dep, DepList),
       \+ Bus = free(_). %%%%%% TA-021029 Panic // true

frombus rule                       %% ØF-990303
is     present departure(Bus, _, _, Dep), 
       present depset(from, DepList)
id     not frame_setvalue(bus, _),
       add frame_setvalue(bus, Bus)
ip     varmember(Dep, DepList),
       \+ Bus = free(_).

atday rule                       %% ØF-990304
is     present atday(X),
       not present today(X)
id     not frame_setvalue(day, _), %% separated from when %% TA-051117
       add frame_setvalue(day, X)  %%
ip     nonvar(X),
       \+ X = free(_).	

       
%%%%%%%%%%
%% Consistency rules


consdeptime2 rule
is	[]
id	present frame_setvalue(where::departure, _),
	replace framevalue((when)::departure::before, _)
	with	frame_setvalue((when)::departure::before, ?)
ip	[].

consdeptime3 rule
is	[]
id	present frame_setvalue((when)::departure::after, DepTime),
	replace framevalue((when)::arrival::before, ArrTime)
	with	frame_setvalue((when)::arrival::before, ?)
ip	ArrTime \== ? , DepTime \== ? , DepTime > ArrTime.


consarrplace rule
is	[]
id	present frame_setvalue(where::departure, Place),
	replace framevalue(where::arrival, Place)
	with	frame_setvalue(where::arrival, ?)
ip	[].



consarrtime2 rule
is	[]
id	present frame_setvalue(where::arrival, _),
	replace framevalue((when)::arrival::after, _)
	with	frame_setvalue((when)::arrival::after, ?)
ip	[].

consarrtime3 rule
is	[]
id	present frame_setvalue((when)::arrival::before, ArrTime),
	replace framevalue((when)::departure::after, DepTime)
	with	frame_setvalue((when)::departure::after, ?)
ip	ArrTime \== ? , DepTime \== ? , DepTime > ArrTime.

consarrbus rule
is	[]
id	present frame_setvalue(where::arrival, _),
	replace framevalue(arrival::bus, _)
	with	frame_setvalue(arrival::bus, ?)
ip	[].



deptimeonly   rule  %% TA-041012
is frame_remember((when)::departure::after,Time)
id not present frame_setvalue((when)::departure::after,_), %% more specific!
   add frame_setvalue((when)::departure::after,Time) 
ip [].


arrtimeonly   rule    %% TA-041012
is frame_remember((when)::arrival::before,Time) 
id not present frame_setvalue((when)::arrival::before,_),  %% more specific!
   add frame_setvalue((when)::arrival::before,Time) 
ip [].







