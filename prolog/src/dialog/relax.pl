%% FILE relax.pl
%% SYSTEM BUSSTUC
%% CREATED TO-970319
%% REVISED TO-970421 TA-041217


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
 :- ['../declare.pl'].

:- module(relax,[]).

tracevalue(L) :- user:myflags(traceprog,L).  % Trace level 1-4

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
      varmember(A, List), frame_getcount(whenis::departure::before, X), linecounter(Y), \+ X = Y.


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
      varmember(A, List), frame_getcount(whenis::departure::before, X), linecounter(Y), \+ X = Y.


arrafter rule
is	context depset(to, List),
        replace keepafter(Time, A, B)
        with    A = B
id	exactly [],
	add relax(time(arrival, after, Time))
ip      varmember(A, List), frame_getcount(whenis::arrival::after, X), linecounter(Y), \+ X = Y.


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

%% ,frame_getcount(whenis::departure::after, X), linecounter(Y), \+ X = Y.

%% this constraint invalidates:  fra nth til nardo.  etter kl 24.



arrbefore rule
is	context depset(to, List),
        replace keepbefore(Time, A, B)
        with    A = B
id	exactly [],
	add relax(time(arrival, before, Time))
ip      varmember(A, List), frame_getcount(whenis::arrival::before, X), linecounter(Y), \+ X = Y.

arrbefore1 rule
is	 context depset(to, List),
    replace keepbefore1(Time, A, B)
    with    A = B,

    replace connections(C1,C2,C3,C4,C5,C6,DaySeqNo,Options,C8,C9)       %% Remove lastcorr option
    with    connections(C1,C2,C3,C4,C5,C6,DaySeqNo,NoLastOptions,C8,C9) %% TA-041007

id	 exactly [],
	 add relax(time(arrival, before, Time))
ip  varmember(A, List), 
    frame_getcount(whenis::arrival::before, X), 
    linecounter(Y), 
    \+ X = Y,
    user: deleteall(lastcorr,Options,NoLastOptions).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
