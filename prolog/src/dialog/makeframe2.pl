%% FILE makeframe2.pl
%% SYSTEM TELEBUSTER
%% CREATED TLF-030409 TA-081107

%% REVISED                  COMMON VERSION
:- module( makeframe2, [
        (rule)/2,
        tracevalue/1
    ] ).


% pragma(RuleModule,Source,Dest) bygger Dest fra Source vha reglene i RuleModule

% Operatorer for Pragma-regler

% is operator prefixed with rule RuleID

:- op(1150,xfy,rule).  

:- op(1120, fy,is).
:- op(1110,xfy,id).
:- op(1110,xfy,ip).

:- op( 715, fy,context).    %% similar to ispresent, but doesnt mark as saw
:- op( 715, fy,addfront).   %% (for messages etc) 
:- op( 725, fy,addcon).     %% add if not already ispresent 
:- op( 715, fy,removeall).  %% remove all of a list
:- op( 715, fy,removeif).   %% remove all if any , always succeed 
:- op( 715, fy,replaceall). %% replace iteratively all elements 
:- op( 715, fy,replaceif).  %% replace if occuring. 
:- op( 715, fy,replace).
:- op( 715, fy,replacelast).
:- op( 715,xfy,with).
%%  :- op( 715, fy,to). %% not used, interferes with SWI-Prolog /srel/to/--
%%  :- op( 715,xfy,append).
:- op( 715, fy,no).
:- op( 715, fy,exactly). 
:- op( 715, fy,add).
:- op( 715, fy,remove).
:- op( 715, fy,ispresent).
:- op( 715, fy,assume). 

%% :- op( 715, fy,not).  % Already defined in TUC

:- op( 714,xfy,seq).     %% directly sequence 

:- op( 714,xfy,cond).    %% new   not X isa place cond bound(X)

:- op( 714,xfy,when).    %% same as cond %% TA-081106

:- op( 712, fy,seen). % Lower than "not", higher than "isa"

%%% %%%%%%%% RS-111118
:- ensure_loaded( '../declare' ).  % :- use_module( '../declare.pl').

tracevalue(X):- user:myflags(traceprog,X),!; X=1.

returnfields rule %% TA-051030
is  ispresent teleprocess([A,B|C],_,_,_) %% at least one (hope they are valid)
id  not frame_setvalue(return, _),
    add frame_setvalue(return,[A,B|C])
ip  [].



fieldtelephone rule
is  ispresent teleprocess([telephone],_,_,_)
id  not frame_setvalue(return, _),
    add frame_setvalue(return, [telephonenumber])
ip  [].

fieldfirstname rule
is  ispresent teleprocess([firstname],_,_,_)
id  not frame_setvalue(return,_),
    add frame_setvalue(return, [givenname])
ip  [].

fieldlastname rule
is  ispresent teleprocess([lastname],_,_,_)
id  not frame_setvalue(return,_),
    add frame_setvalue(return, [sn])
ip  [].

fieldcount rule
is  ispresent teleprocess([count],_,_,_)
id  not frame_setvalue(return,_),
    add frame_setvalue(return, [count])
ip  [].

fieldplace rule
is  ispresent teleprocess([place],_,_,_)
id  not frame_setvalue(return,_),
	add frame_setvalue(return, [roomnumber])
ip	[].

fieldroom rule %% TA-061009
is  ispresent teleprocess([room],_,_,_)
id  not frame_setvalue(return,_),
	add frame_setvalue(return, [roomnumber])
ip	[].

fieldoffice rule
is  ispresent teleprocess([office],_,_,_)
id  not frame_setvalue(return,_),
	add frame_setvalue(return, [roomnumber])
ip	[].

fieldname rule
is 	ispresent teleprocess([name],_,_,_)
id	not frame_setvalue(return,_),
	add frame_setvalue(return,[cn])
ip	[].

fielddepartment rule
is 	ispresent	teleprocess([department],_,_,_)
id	not frame_setvalue(return,_),
	add frame_setvalue(return,[ou])
ip  [].

fieldmail rule
is 	ispresent teleprocess([mailaddress],_,_,_)
id	not frame_setvalue(return,_),
	add frame_setvalue(return,[mail])
ip	[].

fieldmail1 rule
is 	ispresent teleprocess([mail],_,_,_)
id	not frame_setvalue(return,_),
	add frame_setvalue(return,[mail])
ip	[].

fieldadress rule
is	ispresent teleprocess([address],_,_,_)
id	not frame_setvalue(return,_),
	add	frame_setvalue(return,[street]) %% TA-050921 (was return,[mail])
ip	[].

fieldtitle rule
is	ispresent teleprocess([title],_,_,_)
id	not frame_setvalue(return,_),
	add	frame_setvalue(return,[title])
ip	[].

fieldunknown rule
is  ispresent teleprocess([unknown],_,_,_)
id  not frame_setvalue(return,[unknown]),
    add frame_setvalue(return,[unknown])
ip	[].


attribute_givenname rule
is ispresent teleprocess(_,_,AtrList,_)
id not frame_setvalue(attributes::givenname, _),
   add frame_setvalue(attributes::givenname, Value)
ip member(firstname=Value,AtrList).



newlastname_oldfirstname rule %% TA-060609
is ispresent teleprocess(_,_,AtrList,_),
       {  member(lastname=Oien,AtrList), %% TA-081107
          frame_getvalue(attributes::sn,Amble,_Type),
          Oien \== Amble}
id not frame_setvalue(attributes::sn, _),
   add frame_setvalue(attributes::sn, Oien),
   add frame_setvalue(attributes::givenname,?) %% reset firstname if new lastname
ip [].




attribute_sn rule
is ispresent teleprocess(_,_,AtrList,_)
id not frame_setvalue(attributes::sn, _),
   add frame_setvalue(attributes::sn, Value)
ip member(lastname=Value,AtrList).

attribute_department rule
is ispresent teleprocess(_,_,AtrList,_)
id not frame_setvalue(attributes::department, _),
   add frame_setvalue(attributes::department, Value)
ip member(department=Value,AtrList).

attribute_mail rule
is ispresent teleprocess(_,_,AtrList,_)
id not frame_setvalue(attributes::mail, _),
   add frame_setvalue(attributes::mail, Value)
ip member(mail=Value,AtrList).

attribute_cn rule
is ispresent teleprocess(_,_,AtrList,_)
id not frame_setvalue(attributes::cn, _),
   add frame_setvalue(attributes::cn, Value)
ip member(pname=Value,AtrList).

attribute_title rule
is ispresent teleprocess(_,_,AtrList,_)
id not frame_setvalue(attributes::title, _),
   add frame_setvalue(attributes::title, Value)
ip member(title=Value,AtrList).

attribute_telephonenumber rule
is ispresent teleprocess(_,_,AtrList,_)
id not frame_setvalue(attributes::telephonenumber, _),
   add frame_setvalue(attributes::telephonenumber, Value)
ip member(Tel=Value,AtrList),
   (Tel=tel;Tel=telephone).

attribute_roomnumber rule
is ispresent teleprocess(_,_,AtrList,_)
id not frame_setvalue(attributes::roomnumber, _),
   add frame_setvalue(attributes::roomnumber, Value)
ip member(roomnumber=Value,AtrList).

%%%%%%%% =================


%% FILE makeframe.pl


%% relax keepbefore if flag(laterbus)

relaxkeepbefore rule    %% TA-050502
is     flag(laterbus)
id     add frame_setvalue(whenis::arrival::before, ?)  %% TA-051109
     , add frame_setvalue(whenis::departure::before, ?) %% maybe old constraint
ip     [].
    


%% relax keepafter if flag(laterbus)

relaxkeepafter rule    %% TA-050502
is     flag(earlierbus)
id     add frame_setvalue(whenis::departure::after, ?) %% TA-051109
     ,  add frame_setvalue(whenis::arrival::after, ?)     %% maybe old constraint
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
is     ispresent departure(_, Place, _, Dep), 
       ispresent depset(to, DepList)
id     not frame_setvalue(where::arrival, _),
       add frame_setvalue(where::arrival, Place)
ip     varmember(Dep, DepList),
       \+ Place = free(_).

fromplace rule                       %% ØF-990303
is     ispresent departure(_, Place, _, Dep), 
       ispresent depset(from, DepList)
id     not frame_setvalue(where::departure, _),
       add frame_setvalue(where::departure, Place)
ip     varmember(Dep, DepList),
       \+ Place = free(_).


nilplacetofrom rule       
is     ispresent departure(_, Place, _, _Dep), 
       ispresent depset(unknown,_ ) %%%%   [Dep]) %% TA-050411
id     not frame_setvalue(where::unknown, _),
       not frame_setvalue(where::departure, _),
       not frame_setvalue(where::arrival, _),
       not framevalue(where::departure, Place),  % NB
       not framevalue(where::arrival, Place),   % NB
      add frame_setvalue(where::unknown, Place)
ip     % varmember(Dep, DepList),
       \+ Place = free(_).



fromafter rule                       %% ØF-990303
is     ispresent depset(from, DepList),
       ispresent keepafter(Time, Dep, _)
id     not frame_setvalue(whenis::departure::after, _),
       add frame_setvalue(whenis::departure::after, Time)
ip     bound(Time), varmember(Dep, DepList).

frombefore rule                       %% ØF-990303
is     ispresent depset(from, DepList),
       ispresent keepbefore(Time, Dep, _)
id     not frame_setvalue(whenis::departure::before, _),
       add frame_setvalue(whenis::departure::before, Time)
ip     bound(Time), varmember(Dep, DepList).

frombefore1 rule                       %% ØF-990303
is     ispresent depset(from, DepList),
       ispresent keepbefore1(Time, Dep, _)
id     not frame_setvalue(whenis::departure::before, _),
       add frame_setvalue(whenis::departure::before, Time)
ip     bound(Time), varmember(Dep, DepList).

frombetween rule
is     ispresent depset(from, DepList),
       ispresent keepbetween(LowTime, HighTime, Dep, _)
id     not frame_setvalue(whenis::departure::after, _),
       add frame_setvalue(whenis::departure::after, LowTime),
       not frame_setvalue(whenis::departure::before, _),
       add frame_setvalue(whenis::departure::before, HighTime)
ip     bound(LowTime), bound(HighTime), varmember(Dep, DepList).

toafter rule                       %% ØF-990303
is     ispresent depset(to, DepList),
       ispresent keepafter(Time, Dep, _)
id     not frame_setvalue(whenis::arrival::after, _),
       add frame_setvalue(whenis::arrival::after, Time)
ip     bound(Time), varmember(Dep, DepList).




toalett rule                       %% TA-030913
is     replace   depset(unknown, _depList_)  with %% TA-050411
                 depset(arrival, _depList_) 



id     ispresent framevalue(where::departure,_NTH_), % have a departure
       not ispresent frame_setvalue(where::arrival,_Dragvoll_), %% TA-030913
       replace frame_setvalue(where::unknown,Dragvoll) with
               frame_setvalue(where::arrival,Dragvoll) % know it's arrival
ip     [].

toat rule                       %% TA-030913
is     ispresent depset(unknown, DepList),
       ispresent keepat(Time, Dep, _)

id     ispresent framevalue(where::departure,_NTH_), % have a departure
       not frame_setvalue(whenis::departure::after, Time), %% already decided
       not frame_setvalue(whenis::arrival::before, _),
       add frame_setvalue(whenis::arrival::before, Time),
 
       replaceif frame_setvalue(where::unknown,Dragvoll) with %% <--- if 
               frame_setvalue(where::arrival,Dragvoll)

ip     bound(Time), varmember(Dep, DepList).

fromlett rule                       %% TA-030913
is     ispresent depset(unknown, _DepList_)
id     ispresent framevalue(where::arrival,_NTH_), % have a arrival
       not ispresent frame_setvalue(where::departure,_Dragvoll_), 
       replace frame_setvalue(where::unknown,Dragvoll) with
               frame_setvalue(where::departure,Dragvoll) % know it's departure
ip     [].

fromat rule                       %% TA-030913
is     ispresent depset(unknown, DepList),
       ispresent keepat(Time, Dep, _)
id     ispresent framevalue(where::arrival,_NTH_), % have a arrival
       not frame_setvalue(whenis::arrival::before, Time), %% already decided
       not frame_setvalue(whenis::departure::after, _),
       add frame_setvalue(whenis::departure::after, Time),
 
       replaceif frame_setvalue(where::unknown,Dragvoll) with %% <--- if 
               frame_setvalue(where::departure,Dragvoll)


ip     bound(Time), varmember(Dep, DepList).


tobefore rule                       %% ØF-990303
is     ispresent depset(to, DepList),
       ispresent keepbefore(Time, Dep, _)
id     not frame_setvalue(whenis::arrival::before, _),
       add frame_setvalue(whenis::arrival::before, Time)
ip     bound(Time), varmember(Dep, DepList).

tobefore1 rule                       %% ØF-990303
is     ispresent depset(to, DepList),
       ispresent keepbefore1(Time, Dep, _)
id     not frame_setvalue(whenis::arrival::before, _),
       add frame_setvalue(whenis::arrival::before, Time)
ip     bound(Time), varmember(Dep, DepList).

tobetween rule
is     ispresent depset(to, DepList),
       ispresent keepbetween(LowTime, HighTime, Dep, _)
id     not frame_setvalue(whenis::arrival::after, _),
       add frame_setvalue(whenis::arrival::after, LowTime),
       not frame_setvalue(whenis::arrival::before, _),
       add frame_setvalue(whenis::arrival::before, HighTime)
ip     bound(LowTime), bound(HighTime), varmember(Dep, DepList).



nils rule     %% AD HOC Når går buss 5/ Dragvoll    %% TA-031110
is     ispresent departure(_, Dragvoll, _, Dep), 
       ispresent depset(unknown,[Dep])   %% depset(unknown -> depset(to %% TA-031111

id     frame_setvalue(where::unknown, Dragvoll),
       not frame_setvalue(where::departure, _),
       not frame_setvalue(where::arrival, _),
       not framevalue(where::departure, Dragvoll), 
       not framevalue(where::arrival, Dragvoll), 
       replace frame_setvalue(where::unknown, Dragvoll)
       with    frame_setvalue(where::arrival, Dragvoll)
ip     \+ Dragvoll = free(_).






tobus rule                       %% ØF-990303
is     ispresent departure(Bus, _, _, Dep), 
       ispresent depset(to, DepList)
id     not frame_setvalue(bus, _),   %% JFR frombus
       add frame_setvalue(bus, Bus)  %% TA-030126

     %%  not frame_setvalue(arrival::bus, _),  %% TA-030126
     %%  add frame_setvalue(arrival::bus, Bus) %% TA-030126

ip     varmember(Dep, DepList),
       \+ Bus = free(_). %%%%%% TA-021029 Panic // true

frombus rule                       %% ØF-990303
is     ispresent departure(Bus, _, _, Dep), 
       ispresent depset(from, DepList)
id     not frame_setvalue(bus, _),
       add frame_setvalue(bus, Bus)
ip     varmember(Dep, DepList),
       \+ Bus = free(_).

atday rule                       %% ØF-990304
is     ispresent atday(X),
       not ispresent today(X)
id     not frame_setvalue(day, _), %% separated from when %% TA-051117
       add frame_setvalue(day, X)  %%
ip     nonvar(X),
       \+ X = free(_).	

       
%%%%%%%%%%
%% Consistency rules


consdeptime2 rule
is	[]
id	ispresent frame_setvalue(where::departure, _),
	replace framevalue(whenis::departure::before, _)
	with	frame_setvalue(whenis::departure::before, ?)
ip	[].

consdeptime3 rule
is	[]
id	ispresent frame_setvalue(whenis::departure::after, DepTime),
	replace framevalue(whenis::arrival::before, ArrTime)
	with	frame_setvalue(whenis::arrival::before, ?)
ip	ArrTime \== ? , DepTime \== ? , DepTime > ArrTime.


consarrplace rule
is	[]
id	ispresent frame_setvalue(where::departure, Place),
	replace framevalue(where::arrival, Place)
	with	frame_setvalue(where::arrival, ?)
ip	[].



consarrtime2 rule
is	[]
id	ispresent frame_setvalue(where::arrival, _),
	replace framevalue(whenis::arrival::after, _)
	with	frame_setvalue(whenis::arrival::after, ?)
ip	[].

consarrtime3 rule
is	[]
id	ispresent frame_setvalue(whenis::arrival::before, ArrTime),
	replace framevalue(whenis::departure::after, DepTime)
	with	frame_setvalue(whenis::departure::after, ?)
ip	ArrTime \== ? , DepTime \== ? , DepTime > ArrTime.

consarrbus rule
is	[]
id	ispresent frame_setvalue(where::arrival, _),
	replace framevalue(arrival::bus, _)
	with	frame_setvalue(arrival::bus, ?)
ip	[].



deptimeonly   rule  %% TA-041012
is frame_remember(whenis::departure::after,Time)
id not ispresent frame_setvalue(whenis::departure::after,_), %% more specific!
   add frame_setvalue(whenis::departure::after,Time) 
ip [].


arrtimeonly   rule    %% TA-041012
is frame_remember(whenis::arrival::before,Time) 
id not ispresent frame_setvalue(whenis::arrival::before,_),  %% more specific!
   add frame_setvalue(whenis::arrival::before,Time) 
ip [].







