/* -*- Mode:Prolog; coding:utf-8; -*- */
:- ensure_loaded( user:'../declare' ). %% RS-111213 General (semantic) Operators

%:- ensure_loaded( user:'../app/pragma' ). %% RS-111213 Pragmatic (rule) Operators
:-user:use_module( '../app/pragma', [] ). %% RS-140207 Pragmatic (rule) Operators

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

tobus rule                       %% ØF-990303
is     present departure(Bus, _, _, Dep), 
       present depset(to, DepList)
id     not frame_setvalue(arrival::bus, _),
       add frame_setvalue(arrival::bus, Bus)
ip     varmember(Dep, DepList),
       \+ Bus = free(_).

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
id     not frame_setvalue((when)::day, _),
       add frame_setvalue((when)::day, X)
ip     nonvar(X),
       \+ X = free(_).	
       
%%%%%%%%%%
%% Consistancy rules

consdepplace rule
is	[]
id	present frame_setvalue(where::arrival, Place),
	replace framevalue(where::departure, Place)
	with	frame_setvalue(where::departure, ?)
ip	[].

consdeptime rule
is	[]
id	present frame_setvalue(where::departure, _),
	replace framevalue((when)::departure::after, _)
	with	frame_setvalue((when)::departure::after, ?)
ip	[].

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

consdepbus rule
is	[]
id	present frame_setvalue(where::departure, _),
	replace framevalue(bus, _)
	with	frame_setvalue(bus, ?)
ip	[].

consarrplace rule
is	[]
id	present frame_setvalue(where::departure, Place),
	replace framevalue(where::arrival, Place)
	with	frame_setvalue(where::arrival, ?)
ip	[].

consarrtime rule
is	[]
id	present frame_setvalue(where::arrival, _),
	replace framevalue((when)::arrival::before, _)
	with	frame_setvalue((when)::arrival::before, ?)
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
