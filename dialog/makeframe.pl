:- module(makeframe,[]).

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
 :- ['../declare.pl'].

tracevalue(3).

instant1 rule
is	replace (timenow(X), keepbefore(X, A, B))
     	with	keepbefore(Y, A, B)
id	[]
ip	timenow(Y).

instant1 rule
is	replace (timenow(X), keepafter(X, A, B))
     	with	keepafter(Y, A, B)
id	[]
ip	timenow(Y).

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

tobus rule                       %% ØF-990303
is     ispresent departure(Bus, _, _, Dep), 
       ispresent depset(to, DepList)
id     not frame_setvalue(arrival::bus, _),
       add frame_setvalue(arrival::bus, Bus)
ip     varmember(Dep, DepList),
       \+ Bus = free(_).

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
id     not frame_setvalue(whenis::day, _),
       add frame_setvalue(whenis::day, X)
ip     nonvar(X),
       \+ X = free(_).	
       
%%%%%%%%%%
%% Consistancy rules

consdepplace rule
is	[]
id	ispresent frame_setvalue(where::arrival, Place),
	replace framevalue(where::departure, Place)
	with	frame_setvalue(where::departure, ?)
ip	[].

consdeptime rule
is	[]
id	ispresent frame_setvalue(where::departure, _),
	replace framevalue(whenis::departure::after, _)
	with	frame_setvalue(whenis::departure::after, ?)
ip	[].

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

consdepbus rule
is	[]
id	ispresent frame_setvalue(where::departure, _),
	replace framevalue(bus, _)
	with	frame_setvalue(bus, ?)
ip	[].

consarrplace rule
is	[]
id	ispresent frame_setvalue(where::departure, Place),
	replace framevalue(where::arrival, Place)
	with	frame_setvalue(where::arrival, ?)
ip	[].

consarrtime rule
is	[]
id	ispresent frame_setvalue(where::arrival, _),
	replace framevalue(whenis::arrival::before, _)
	with	frame_setvalue(whenis::arrival::before, ?)
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
