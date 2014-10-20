/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE evaluate.pl.
%% SYSTEM TUC
%% CREATED TA-930528
%% REVISED TA-090925

%%% RS-111205, UNIT: tuc/
:-module( evaluate, [ disqev/1, evaluateq/1, evaluateq2/1, fakt/1, included/2, instant/2, leveltest/2, new_focus/2, qev/1, qdev/2, valof/2 ] ).  %unskolemize/2,        %% OLD, from turbo.pl

%% META PREDICATES : for/2, foralltest/2, once1/1, set_of/3, set_ops/3, test/1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- meta_predicate doall(0) .  % doall/1 (Goal_0) . Zero input arguments for Goal_0 % doall(P): (P, then succeed)
doall( P ):-  % P, then succeed 
    P,
    false ;
    true.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prologs setof is baroque %%
:- meta_predicate set_of(+,0,-) .
set_of(X,Y,Z):-           %%
    setof(X,Y^Y,Z),!;     %% Trick to avoid alternatives
    Z=[].                 %% What is wrong with empty sets ?
%% Sequence preserving set_of/2, ( first occurrence stays first)
%set_ops(X,Y,Z):-
%    findall(X,Y,Z1),
%    remove_duplicates(Z1,Z). %% order-preserving
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%% RS-131231, UNIT: /  %%% RS-111205, UNIT: utility/
:- ensure_loaded( user:'../declare' ).  %% RS-140208    difact/2, fact/2

:- use_module( '../utility/utility', [ aggregate/3, writelist/1 ]).  %% RS-131117 includes declare.pl language/1,
:- use_module( '../utility/writeout', [ doubt/2, language/1, out/1, output/1 ] ).%% RS-140912

:- use_module( '../main.pl', [ reset/0, traceprint/2 ] ). %% RS-140209 [ (=>)/2, reset/0, traceprint/2 ] Why is => in translat.pl ?! RS-140927
%:-use_module( '../tucbuses', [ ] ).  %RS-140101 % Common File for tucbus  (english) and  tucbuss (norwegian), language/1

%% RS-131227    UNIT: tuc/
%:- use_module( lex, [ ] ).          % lcode1/2  is called in the for-predicate (etc.) %% RS-131225
:- use_module( facts, [ fact/1, difact/1, have/4, isa/2 ]). % , isa/2  %% RS-140210
%:- use_module( fernando, [ ] ).
:- use_module( semantic , [ ako/2, subclass0/2, testclass/1 ] ). %% RS-131228
:- use_module( translat, [ testquant/3 ] ).  %% RS-131231

%%% RS-111205, UNIT: app/
%:-use_module('../app/pragma', [ ] ).      %%RS-131228     pragma/3 etc. loaded in interapp!
:- use_module('../app/interapp', [ ieval/1 ]). %% RS-131231


evaluateq2(nil):-!. 


evaluateq2(R):- 
    user:value(busflag,true), %% Set by Bustuc Application Program
	 !,
    ieval(R).            %%  interapp.pl 

evaluateq2(R):- 
    user:value(teleflag,true), %% TA-020605
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
    doall( qev(P) ), %% succeed in the end   % utility.pl
    nl,nl.


evaluateq(which(X):::P):-
     findq(X,P,Z),   
     !,
     writelist(Z),                         % utility.pl
     nl,
     update_focus(Z).


evaluateq(test:::P):-

   ( qev(P),
     doubt('Yes','Ja'),!;  %% utility.pl ?
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
     out(N),nl,    %% utility.pl
     nl. 

evaluateq(new:::_). %% Actually a miss 

evaluateq(nil).  %% In case queryflag =: true, only nil is produced as TQL. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


update_focus(_):- %% TA-020228
    user:value(queryflag,true),
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

new_focus(X,M) :-      %  Focus is allowed in permament store

    user:value(context_id,UID),  
    retractall( user:difact(UID,_ is_the M) ),
    retractall( user:fact0(_ is_the M) ),
    ( user:(permanence =: 1) ->         %% utility.pl
       asserta( user:fact0(X is_the M) );  
       asserta( user:difact( UID, X is_the M) ) ). %%   % Last Qualified Reference



findq(X,P,Z):- 
    set_of(Y,(qev(P),qdev(X,Y)),Z).        %% utilty.pl


qdev(X,Too_general):-  
    var(X),
    !,
    (language(english) ->          %% main.pl? 
        Too_general='Too general';
        Too_general='For generelt').

/*  replace a Skolem constant with a class 
qdev(X,Y):- 
    unskolemize(X,Y),
    !. 

unskolemize(sk(J),AMan):- 
    !,
    fact(sk(J) isa Man), 
    klassing(Man,AMan).       %% turbo.pl

*/

%Equalilty check...
qdev(X,X).


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
    subclass0(C,Y).         %   and an instance %% TA-010913    fernando.pl 

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


rule(N,Y) :- 
   leveltest(N,N1),
   user:( X => Y), 
   qev(N1,X).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

included(X,Z):-
    fact(nrel/in/_/_/X/Y), 
    included(Y,Z).
included(X,X). % Outside in

%%
instant(X,T):-     
     var(X), 
     testclass(T),
     !.  %% X= ' not listable '. 

instant(X,C):-  
    fact(X isa C).


instant(X,Z) :- % bottom up
    (Y ako Z), 
    instant(X,Y).
 

%%
winstant(_,X,T):-     
     var(X), 
     testclass(T),
     !.  %% X= ' not listable '. 

winstant(W,X,C):-  
    fact((isa)/W/C/X).

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
    user:value(maxdepth,K), %% maxlevel(K),
    M < K,
    N is M + 1.

fakt(X):-
         difact(X); %% dynamic
         user:fact0(X). %% static

%%%%%%%%%%%%%%%  THE END %%%%%%%%%%%%%%%


