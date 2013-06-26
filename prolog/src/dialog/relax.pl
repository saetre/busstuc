%% FILE relax.pl
%% SYSTEM BUSSTUC
%% CREATED TO-970319
%% REVISED TO-970421 TA-041217

:- ensure_loaded('../declare'). %% RS-111213 General (semantic) Operators
:- ensure_loaded('../app/pragma'). %% RS-111213 Pragmatic (rule) Operators



:- module(relax,[]).  %% RS-130624    2012 Experiment?

tracevalue(L) :- user:value(traceprog,L).  % Trace level 1-4

selectroute rule
is	replace selectroute(_, A, B)
        with    A = B
id	exactly [],
	add relax(selectroute)
ip      [].

depbefore rule %% TA-041217
is	context depset(from, List),
        replace keepbefore(Time, A, B)
        with    A = B
id	exactly [],
	add relax(time(departure, before, Time)),

              % Remove last_options from connection (God willing) %% TA-041217

    replace connections(C,D,H,Nth,Nar,E,DaySeqNo,Opts1,F,G)
    with    connections(C,D,H,Nth,Nar,E,DaySeqNo,Opts3,F,G)

ip    deleteall(last(_),Opts1,Opts2),
      deleteall(lastcorr,Opts2,Opts3),      
      varmember(A, List), frame_getcount((when)::departure::before, X), linecounter(Y), \+ X = Y.


depbefore1 rule
is	context depset(from, List),
        replace keepbefore1(Time, A, B)
        with    A = B
id	exactly [],
	add relax(time(departure, before, Time)),

              % Remove last_options from connection (God willing) %% TA-041217

    replace connections(C,D,H,Nth,Nar,E,DaySeqNo,Opts1,F,G)
    with    connections(C,D,H,Nth,Nar,E,DaySeqNo,Opts3,F,G)

ip    deleteall(last(_),Opts1,Opts2),
      deleteall(lastcorr,Opts2,Opts3),      
      varmember(A, List), frame_getcount((when)::departure::before, X), linecounter(Y), \+ X = Y.


arrafter rule
is	context depset(to, List),
        replace keepafter(Time, A, B)
        with    A = B
id	exactly [],
	add relax(time(arrival, after, Time))
ip      varmember(A, List), frame_getcount((when)::arrival::after, X), linecounter(Y), \+ X = Y.


depafter rule
is	context depset(from, List),
        replace keepafter(Time, A, B)
        with    A = B,

%% TA-030820
        replace connections(C,D,H,Nth,Nar,E,DaySeqNo,Opts1,F,G)
        with    connections(C,D,H,Nth,Nar,E,DaySeqNo,Opts3,F,G)


id	exactly [], % ???
	add relax(time(departure, after, Time))

ip  deleteall(nextaftertime(_U_),Opts1,Opts2)  , %% utility  
    setopt(lastcorr,Opts2,Opts3),   
    varmember(A, List).

%% ,frame_getcount((when)::departure::after, X), linecounter(Y), \+ X = Y.

%% this constraint invalidates:  fra nth til nardo.  etter kl 24.



arrbefore rule
is	context depset(to, List),
        replace keepbefore(Time, A, B)
        with    A = B
id	exactly [],
	add relax(time(arrival, before, Time))
ip      varmember(A, List), frame_getcount((when)::arrival::before, X), linecounter(Y), \+ X = Y.

arrbefore1 rule
is	 context depset(to, List),
    replace keepbefore1(Time, A, B)
    with    A = B,

    replace connections(C1,C2,C3,C4,C5,C6,DaySeqNo,Options,C8,C9)       %% Remove lastcorr option
    with    connections(C1,C2,C3,C4,C5,C6,DaySeqNo,NoLastOptions,C8,C9) %% TA-041007

id	 exactly [],
	 add relax(time(arrival, before, Time))
ip  varmember(A, List), 
    frame_getcount((when)::arrival::before, X), 
    linecounter(Y), 
    \+ X = Y,
    user: deleteall(lastcorr,Options,NoLastOptions).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
