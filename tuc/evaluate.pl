%% FILE evaluate.pl.
%% SYSTEM TUC
%% CREATED TA-930528
%% REVISED TA-090925

:- module( evaluate, [
    difact/1,     disqev/1,     evaluateq/1,    evaluateq2/1,   %explain/1,
    fact/1,       fakt/1,       included/2,     user:instant/2,
    new_focus/2,  qdev/2,       unskolemize/2,  valof/2,        winstant/3  ] ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- ensure_loaded( '../declare' ).       %% Operators for TUC
:- use_module( '../main', [ 
        user:(:=)/2,    user:(=:)/2,    %% :=/2 and =:/2 exported from declare, through main, to "user:"
        traceprint/2
   ] ).

:-volatile difact/2, fact0/1.
:-dynamic difact/2, fact0/1.

:- use_module( '../app/interapp', [   ieval/1   ] ).

%% RS-111205, UNIT: tuc/
:- use_module( facts, [ (isa)/2, have/4   ] ).  %% RS-111204    isa/2 from facts.pl
:- use_module( fernando, [ subclass0/2 ]).
:- use_module( metacomp, [ language/1 ] ).
:- use_module( semantic, [ (ako)/2, testclass/1 ] ).
:- use_module( slash, [ (def)/1 ] ).    %% export def/1. %% Prefix operator-predicate
:- use_module( translat, [ (=>)/2,  testquant/3  ] ).

%% RS-111205, UNIT: utility/
:- use_module( '../utility/utility', [
        aggregate/3, doubt/2,   out/1,  output/1, set_of/3,  writelist/1
   ] ).  %% Module util

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

evaluateq2(nil):-!.

evaluateq2(R):-
    user:myflags(busflag,true), %% Set by Bustuc Application Program
	 !,
    ieval(R).            %%  interapp.pl

evaluateq2(R):-
    user:myflags(teleflag,true), %% TA-020605
	 !,
    ieval(R).            %%  interapp.pl

evaluateq2([R|_]):-  %% NB  Only first of multiple queries.
    evaluateq(R).

%% TUC Query Language Evaluation

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

evaluateq(nil).  %% In case user:queryflag =:  true, only nil is produced as TQL.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


difact(F):-
    user:myflags(context_id,UID),
    difact(UID,F).

update_focus(_):- %% TA-020228
    user:myflags(queryflag,true),
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

    user:myflags(context_id,UID),
    retractall(difact(UID,_ is_the M)),
    retractall(fact0(_ is_the M)),
    (user:permanence =:  1 ->
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
    klassing(Man,AMan).       %% turbo.pl %% RS-111205, where? very old? ~toreamb/TUC/BACKUP/tuc/turbo.pl
klassing(G,G).

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

%vfact(_,isa/W/Y/X):- %% TA-011025
%    !,
%    winstant(W,X,Y).
%
vfact(_,X isa Y):-
     !,
     user:instant(X,Y).

dialog_referent(X,C) :-
    fakt(X is_the C);      %  dynamic or static
    difact(X isa C).


rule(N,Y):-
   leveltest(N,N1),
   ( X => Y),
   qev(N1,X).

%% Hierarchy of facts

fact(X):-               %  Predefined interpretations
    user:myflags(deflag,true), % AD HOC FLAG  %% DEF IS  FOR COMMANDS
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

included(X,Z):-
    fact(nrel/in/_/_/X/Y),
    included(Y,Z).
included(X,X). % Outside in

user:instant(X,T):-
     var(X),
     testclass(T),
     !.  %% X= ' not listable '.

user:instant(X,C):-
    fact(X isa C).


user:instant(X,Z) :- % bottom up
%    (ako/Y/Z),
    (Y ako Z),
    user:instant(X,Y).

%%

winstant(_,X,T):-
     var(X),
     testclass(T),
     !.  %% X= ' not listable '.

winstant(W,X,Z) :-
     nonvar(Z),     %% TA-040309
%    (ako/Y/Z),
    (Y ako Z),    %% Class Hierarchy is world independent
    winstant(W,X,Y).

:- op( 0, xfx, isa ).                   %% "Temporarily disable" 'isa' as an operator for this file, "tightest binding"
winstant(W,X,C) :- fact(isa/W/C/X).     %% RS-111118 'isa' operator problems, from declare.
:- op( 710, xfx, isa ).                 %% "Restore" 'isa' as an operator for this file, "tightest binding"


%%


valof(X,Y):-
    number(X),
    !,
    X=Y.


leveltest(M,N):-
    user:myflags(maxdepth,K), %% maxlevel(K),
    M < K,
    N is M + 1.

fakt(X):-
         difact(X); %% dynamic
         fact0(X). %% static

%%%%%%%%%%%%%%%  THE END %%%%%%%%%%%%%%%


