%% FILE evaluate.pl.
%% SYSTEM TUC
%% CREATED TA-930528
%% REVISED TA-090925

:- ensure_loaded('../declare').

evaluateq2(nil):-!. 


evaluateq2(R):- 
    value(busflag,true), %% Set by Bustuc Application Program
	 !,
    ieval(R).            %%  interapp.pl 

evaluateq2(R):- 
    value(teleflag,true), %% TA-020605
	 !,
    ieval(R).            %%  interapp.pl 

evaluateq2([R|_]):-  %% NB  Only first of multiple queries. 
    evaluateq(R).  

%% TUC Query Language Evaluation

evaluateq(doit:::quit):-!,
    reset,  
    output('Good bye'),
    nl.

evaluateq(doit:::hello):- !,
    output('Hello'),
    nl. 

evaluateq(doit:::P):-
    !,
    doall(qev(P)), %% succeed in the end
    nl,nl.


evaluateq(which(X):::P):-
     findq(X,P,Z),   
     !,
     writelist(Z),
     nl,
     update_focus(Z).


evaluateq(test:::P):-

   ( qev(P),
     doubt('Yes','Ja'),!;
     doubt('No','Nei')),
     nl.

evaluateq(explain:::P):- 
    output('----------------'),
      
%    evaluateq(test::: P),  %%%% TA-020502
 

    (
     qev(P)->
       doubt('That is possible','Det er mulig');
       doubt('I dont know','Jeg vet ikke')
    ),
     nl,

    output('----------------').

evaluateq(howmany(X):::P):-
     !,
     findq(X,P,Z), 
     length(Z,N),
     out(N),nl,
     nl. 

evaluateq(new:::_). %% Actually a miss 

evaluateq(nil).  %% In case queryflag =: true, only nil is produced as TQL. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


difact(F):-  
    value(context_id,UID),
    difact(UID,F).

update_focus(_):- %% TA-020228
    value(queryflag,true),
    !.


update_focus([X]):-        
    have(thing,class,X,C),      
    !,                     
    new_focus(X,C).        

update_focus([X]):-        
    X= [U|_],                      % X is a non empty list of
    have(thing,class,U,C),         % C
    !,                             % 
    new_focus(X,set(C)).           % 

update_focus(_).

new_focus(X,M):-      %  Focus is allowed in permament store

    value(context_id,UID),  
    retractall(difact(UID,_ is_the M)),
    retractall(fact0(_ is_the M)),
    (permanence =: 1 -> 
       asserta(fact0(X is_the M));  
       asserta(difact(UID,X is_the M))). %%   % Last Qualified Reference



findq(X,P,Z):- 
    set_of(Y,(qev(P),qdev(X,Y)),Z).


qdev(X,Too_general):-  
    var(X),
    !,
    (language(english) -> 
        Too_general='Too general';
        Too_general='For generelt').

/*  replace a Skolem constant with a class 
qdev(X,Y):- 
    unskolemize(X,Y),
    !. 

*/

qdev(X,X).

unskolemize(sk(J),AMan):- 
    !,
    fact(sk(J) isa Man), 
    klassing(Man,AMan).       %% turbo.pl


disqev(P) :-  
    qev(nil,P).     %% only allowed to refer to discourse elements

qev(P):-

  traceprint(4,P), %%

qev(0,P). 

qev(N,(X,Y)):-!,
    qev(N,X),
    qev(N,Y) .


qev(N,not X) :- !,
    \+ qev(N,X).

qev(_,true) :- !.

qev(N,set_of(X,Y,Z)):-!, 
    set_of(X,qev(N,Y),Z).

qev(N,aggregate(MAX,X,Y,P,ML)):-!, 
    set_of(Y-X,qev(N,P),Z1),        %% X:Y ==> Y-X  (keysort notation)
    keysort(Z1,Z2),               %% even if not necessary
    aggregate(MAX,Z2,ML).         %% utility.pl

qev(_,quant(CR/M,X):::P):- !,  
     findq(X,P,Z),  
     length(Z,M1),
     testquant(CR,M1,M).


qev(N,dob/be/AB/CD/_) :- 
    nonvar(AB),
    AB=(A,B),
    !,
    CD=(C,D),
    qev(N,be/A/C/_),
    qev(N,be/B/D/_). 


qev(N,P):-
    factrule(N,P).

%%%%%%%%%%%%%%%%%%%%%%%%%%% 

factrule(N,X):- 
    ground(X),
    !,
    gfact(N,X).

factrule(N,X):- 
    vfact(N,X). % hfact ==> vfact


gfact(N,X) :- vfact(N,X),!. % ONCE !


vfact(nil,X isa Y):- !,     % for dialog query
    dialog_referent(X,C),   % X must be a dialog referent
    subclass0(C,Y).         %   and an instance %% TA-010913 

vfact(nil,X):- !,difact(X). 


vfact(_,Z):-  \+ ( Z = _ isa _),  %% Fronted %% TA-031112
   fact(Z).

vfact(N,X):-  
   rule(N,X).

vfact(_,(isa)/W/Y/X):- %% TA-011025
    !,
    winstant(W,X,Y).

vfact(_,X isa Y):- 
     !, 
     instant(X,Y). 

dialog_referent(X,C) :- 
    fakt(X is_the C);      %  dynamic or static 
    difact(X isa C). 


rule(N,Y):- 
   leveltest(N,N1),
   ( X => Y), 
   qev(N1,X).

%% Hierarchy of facts 
 
fact(X):-               %  Predefined interpretations 
    value(deflag,true), % AD HOC FLAG  %% DEF IS  FOR COMMANDS
    nonvar(X),                         %% John shows a car \= command
    X=Y/_,
    nonvar(Y),
 
    def X .   

fact(X):- fact0(X).     %  Semi permanent

fact(X):- difact(X).    %  Dynamic Discourse facts 

fact(X isa Y):- !,      %  Default type definitions
     X isa Y .   


fact(event/real/now):-              %% TA-010913
    \+ fact0(event/_/_).                    %% To allow 
                                    %% Is john a man ?
                                    %% before any event has taken place


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

included(X,Z):-
    fact(nrel/in/_/_/X/Y), 
    included(Y,Z).
included(X,X). % Outside in

%%
winstant(_,X,T):-     
     var(X), 
     testclass(T),
     !.  %% X= ' not listable '. 

instant(X,T):-     
     var(X), 
     testclass(T),
     !.  %% X= ' not listable '. 

%%
winstant(W,X,C):-  
    fact((isa)/W/C/X).

instant(X,C):-  
    fact(X isa C).


instant(X,Z) :- % bottom up
    (Y ako Z), 
    instant(X,Y).
 

winstant(W,X,Z) :- 
     nonvar(Z),     %% TA-040309
    (Y ako Z),    %% Class Hierarchy is world independent 
    winstant(W,X,Y).
 
%%
   

valof(X,Y):-
    number(X),
    !,
    X=Y.


leveltest(M,N):-
    value(maxdepth,K), %% maxlevel(K),
    M < K,
    N is M + 1.

fakt(X):-
         difact(X); %% dynamic
         fact0(X). %% static

%%%%%%%%%%%%%%%  THE END %%%%%%%%%%%%%%%


