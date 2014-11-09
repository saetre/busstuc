%% FILE translat.pl.
%% SYSTEM TUC
%% CREATED TA-940218
%% REVISED TA-110624

%% RS-140210    UNIT: tuc/
%% A => B is both volatile (not saved) and dynamic (asserted)
:-module( translat, [ (=>)/2, condq/2, hazardrule/1, makedisjunct/2, optand/3, optor/3, protectrule/2, redundant/1,
        testimpossible/1, testquant/3, transfix1/2, unforgettable/2, plunder/3 % clausifystm/1, clausifyq/2, %% RS-141026 for transfix1
] ).

:-volatile (=>)/2.
:-dynamic (=>)/2.

:- meta_predicate  beats( ?, ?, -).
:- meta_predicate  normsplit( ?, ?, -).
:- meta_predicate  skolem( ?, ?, ?, ?, - ).
%:- meta_predicate  test(0) . %% RS-140211 RS-140915 0 instead of : ?
%:- meta_predicate  track(+,0) .
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% meta_predicate  for(0,0). % for/2. Stay inside the CALLING module? %% RS-141029
% for(P,Q) :- P,Q,  false;true. %% RS-140929 What about variable binding? Compare to library(aggregate):forall/2. CAREFUL: there is a "homemade" forall in BusTUC!
%for( P, Q ) :- %% For all P, do Q (with part of P). Finally succeed
%  P, Q, false ; true.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%test(X):- \+ ( \+ ( X)).        %% Calls test(nostation(Y)), test("X ako Y"), among other things, so: make it local in metacomp-> dcg_?.pl
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%local: test/1 % RS-131117 includes declare.pl  %%,  unsquare/2 RS-131227

%% RS-131227    UNIT: /utility/
:- use_module( '../utility/utility', [ error/2, do_count/1, flatlist/2, flatround/2, for/2, freshcopy/2, ident_member/2, match/2, occ/2, subcase/2, subsumes/2 ] ). %% RS-141029  LOOPS! for/2, test/1
:- use_module( '../utility/library', [ reverse/2 ] ).  %%    %% RS-131225
:- use_module( '../utility/writeout', [ output/1, prettyprint/1, track/2 ] ).  %% Module util  , prettyprint/1, output/1, 

:- use_module( library(varnumbers), [ numbervars/1 ] ). %% RS-140210.

%% RS-141026    UNIT: /
%:- ensure_loaded( '../declare' ).%, [ := /2, for/2 (from library.pl) etc. ] ). %% RS-140208
:- use_module( '../declare', [ (:=)/2, (=:)/2, value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .
:- use_module( '../main.pl', [ difact/2, fact0/1 ] ). %MISERY? track/2

% UNIT: tuc/
:- use_module( slash, [ def/1 ] ).     %% RS-131228

%UNIT: /app/
% :- use_module( '../app/interapp', [  ] ).   %% RS-140915 140921

%UNIT: /tuc/
:- use_module( anaphors, [ is_the/2 ] ).   %% Semi-permanent? declare.pl (dynamic), asserted in evaluate.pl & translat.pl
:- use_module( evaluate, [ new_focus/2 ] ).   %% Semi-permanent? declare.pl (dynamic), asserted in evaluate.pl & translat.pl
:- use_module( facts, [ difact/1 ] ).   %% Semi-permanent? declare.pl (dynamic), asserted in evaluate.pl & translat.pl
%:- use_module( fernando, [  ] ).  
:- use_module( semantic, [ subclass/2, testclass/1 ] ).

%:- use_module( '../app/pragma', [ occ/2 ] ).   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  Skolemization of FOL expressions

clausifystm( JLM ):- 
    newskolem(X),
    clausify(X,Y,[],JLM,CLAUSELIST),
    number(Y),
    writeconjuncts(CLAUSELIST,true),
    (skolocon := Y). 
                   

clausify(X,Y,L,P,R):- 
    skolem(X,Y,L,P,Q),   
    !, 
    normalise(Q,R). %% R is a list of tql clauses


%%% Reduce scope of Negation and Skolemize 

%% skolem( SkolemVariableNoBefore, Variable after, Scope Chain, Source, Destination)

skolem(_,_,_,variable,_):- 
    !,
    error(skolem,1),
    fail.



skolem(X,Y,CH, exists(AZ)::JLM,RES):- 
    subcase(AZ,(A,Z):(TA,TZ)), 
    !,
    skolem(X,Y,CH, exists(A:TA)::
                   (exists(Z:TZ)::JLM),RES).

skolem(X,Y,CH, exists(A:_)::JLM,RES):-
    anaphor_bound(CH,A),
    !,
    skolem(X,Y,CH,JLM,RES).

skolem(X,Z,CH, (exists(A:_)::JLM),RES):-!,
    varbind(X,CH,A,Y), 
    skolem(Y,Z,CH,JLM,RES).

skolem(X,Y,CH,(forall(A:_)::JLM),RES):-!,
    var(A),            %% fails if not var !!!                           
    skolem(X,Y,[A|CH],JLM,RES).


%%%% Quantified Expressions with Defaults

skolem( X, X, _, (quant(lt/0,_)::_), false ) :- !.

skolem( X, X, _, (quant(ge/0,_)::_), true ) :- !.

skolem( X, Y, CH, (quant(le/0,A)::P), RES ) :-
    !,
    skolem( X, Y, CH, (quant(eq/0,A)::P), RES ).

skolem( X, Y, CH, (quant(lt/1,Z)::P), RES ) :-
    !, 
    skolem( X, Y, CH, not (exists(Z)::P), RES ).

skolem( X, Y, CH, (quant(gt/0,A)::P), RES ) :-
    !, 
    skolem( X, Y, CH, (exists(A)::P), RES ).

skolem( X, Z, CH, (quant(eq/1,Y)::P), RES ) :-
    !,
    skolem( X, Z, CH, exists(Y)::P, RES ). % APPROX


skolem( X, Y, CH, (quant(ge/1,A)::Z), RES ) :-
    !,
    skolem( X, Y, CH, (exists(A)::Z), RES ).


%% Quantified expressions without Defaults
    
skolem( X, Y, CH, (quant(eq/N,U:T)::P), RES ) :-  
    !,
    skolem( X, Y, CH,
         exists(S:set)::S isa set and 
                    has/set/cardinality/S/N and 
       (forall(U:T):: has/set/member/S/U => P),RES). 

skolem(X,Y,CH,(quant(GT/N,U:T)::P),RES):- 
    !,
    skolem(X,Y,CH,
         exists(S:set):: S isa set and 
         (exists(M:number):: M isa number and 
                     has/set/cardinality/S/M and
                     comp/number/GT/M/N) and    
         (forall(U:T):: has/set/member/S/U => P),
    RES).


skolem(X,Y,CH,(not (quant(EQN,A)::JLM)),RES):-!,
    oppquant(EQN,NEN),
    skolem(X,Y,CH,(quant(NEN,A)::JLM),RES).


skolem(X,Y,CH,(not (exists(A)::JLM)),RES):-!,
    skolem(X,Y,CH,forall(A)::(not JLM),RES).

skolem(X,Y,CH,(not (forall(A)::JLM)),RES):-!,
    skolem(X,Y,CH,exists(A)::(not JLM),RES).

skolem(X,Y,CH,not (P  and  Q),RES):-!,         
    skolem(X,Y,CH,(not P) or (not Q),RES).

skolem(X,Y,CH,not (P or Q),RES):-!,         
    skolem(X,Y,CH,(not P)  and (not Q),RES).

skolem(X,Y,CH,not (not P),RES):-!,
    skolem(X,Y,CH,P,RES).

skolem(X,Y,CH,not (P => Q),RES):-!,
    skolem(X,Y,CH,P and (not Q),RES).

skolem(X,Z,CH, P or Q , ( P1 or Q1)) :-!, %% or <-> ; ! %% TA-090309
    skolem(X,Y,CH,P,P1),
    skolem(Y,Z,CH,Q,Q1).

skolem(X,Z,CH,P  and  Q,P1  and  Q1):-!,
    skolem(X,Y,CH,P,P1),
    skolem(Y,Z,CH,Q,Q1).

skolem(X,Z,CH,(P => Q) ,N1 or Q1):-!,
    skolem(X,Y,CH,not P,N1),
    skolem(Y,Z,CH,Q,Q1).

skolem(X,X,_,Y isa C, (isa)/World/C/Y):- %% Brave New World
    value(textflag,true),
    value(world,World),
    World \== real,
    !.
skolem(X,X,_,P,P).

%%%%%%%%%%%%%%%%%%%%%%%%%

anaphor_bound(CH,AE):- %% Interface: typed variables
    match(AE,A:_E),
    !,
    ident_member(A,CH). % Utility    
 
anaphor_bound(CH,A):-
     ident_member(A,CH). % Utility


oppquant(much,little).
oppquant(little,much). 

oppquant(even,odd).
oppquant(odd,even).

oppquant(eq/0,gt/0):-!.
oppquant(ne/0,eq/0):-!.
oppquant(gt/0,eq/0):-!.
oppquant(ge/0,lt/0):-!. % impossible
oppquant(lt/0,ge/0):-!. % tautology
oppquant(le/0,gt/0):-!.


oppquant(eq/N,ne/N). % 3 men did not live
oppquant(ne/N,eq/N).
oppquant(gt/N,le/N).
oppquant(ge/N,lt/N).
oppquant(lt/N,ge/N).
oppquant(le/N,gt/N).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%  Normalize to Conjunctive Normal Form %%%

normalise(P,R):-
    cnf(P,Q),     
    normprod(Q,R). %% R is a list of tql clauses

% cnf( any formula(and,or) , the same formula in CNF ) 
% Existing order is retained



cnf(P and Q,R):-!, % P is simple  wrt and
    cnf(P,PF),
    cnf(Q,QF),
    muand(PF,QF,R). %% Join two flat cnfs


cnf((P1 and P2) or Q,PF):-!, 
    cnf((P1 or Q) and (P2 or Q),PF).

cnf(P1 or (P2 or Q),R):-  %% gather all ors into first operand
    !,
    cnf((P1 or P2) or Q,R).


cnf(Q or (P1 and P2) ,R1R2):-!, 
    cnf((Q or P1),R1),
    cnf((Q or P2),R2),
    cnf(R1 and R2,R1R2). %% linearize 

%%% cnf(P or Q,(P ; Q)):-!. %% TA-090326 Destroys implicative normal form


cnf(P,P).


%% flatten and


muand((P1 and P2), Q,R):-!,
    muand(P1,(P2 and Q),R).

muand(P,Q1 and Q2,P and Q):-!,
    muand(Q1,Q2,Q).
  
muand(P1,P2,P1 and P2).



normprod(Claus1 and Claus2,[TQC1|TQC2]):-!,
    normprod0(Claus1,TQC1),
    normprod(Claus2,TQC2).

normprod(Claus1,[TQC1]):-!,
    normprod0(Claus1,TQC1).

normprod0(Clause,XXX) :-
    optclause(Clause,Clause1),
    normprod1(Clause1,XXX).     


normprod1(Clause , R):-
    normsplit(Clause,Posl,Negl),
    !,
    do_something(Posl,Negl,R).


optclause(false or P,Q):-!,
    optclause(P,Q).

optclause(true or _P,true):-!.

optclause(P or Q, R):-!,
   optclause(Q,Q1),
   optcl(P,Q1,R).

optclause(P,P).
  

optcl(_P,true,true):-!. %% P is finished
optcl(P,false,P):-!.  
optcl(P,Q,P or Q).


normsplit( (P or Q) or R , A, B ) :- !,
    normsplit(P or (Q or R), A, B ).

normsplit( (not P) or Q , Posl, [P|Negl] ) :- !,
    normsplit(Q, Posl , Negl).

normsplit( P or Q , [P|Posl], Negl ) :- !,
    normsplit(Q, Posl , Negl).

normsplit( not P , [], [P] ) :- !.
normsplit(Q, [Q], []).

%% do_something   [positives]  [negatives] Result

do_something([],Negl,R):-!, %% goal clause
    doclause(false,Negl,R).

do_something([P],[],P):-!.  %% unit fact 

do_something([P],Negl,R):-!, %% definite clause
    doclause(P,Negl,R).

do_something(P,Q,R):- 
    non_horn(P,Q,R).

doclause(P,[],P):-!.

doclause(P,N,(CONDS => P)):-
    optimize(N,CONDS). 


non_horn(_PQ,_Negl,true):-!. %% true, In case nonhorn clauses are unwanted

%% In any case, they should be checked for subsumtions  etc


/*

% Non-Horn Clauses    if they are supported

non_horn(PQ,Negl,R):-!,
    remove_duplicates(PQ,P),
    unforgettable(P,P1),
    makedisjunct(P1,NH), 
    doclause(NH,Negl,R).

*/

makedisjunct([P],P):-!.

makedisjunct([A|B],(A;B1)):-!,
    makedisjunct(B,B1).



unforgettable(P,P):-
    \+ forgettable(P),
    !.

unforgettable(_,[true]):-!. %% pling 

forgettable(P):-
    member(true,P);      
    member(event/_/_,P); 
    member(_ isa _,P).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  SKOLEM FUNCTIONS 

%% sk(no,var1,var2,   ,varn).


varbind(SKM,VCHAIN,SKTERM,SKN):-  
    var(SKTERM),
    !,
    SKN is SKM+1,
    reverse(VCHAIN,VC), 
    List = [sk,SKM|VC],
    SKTERM =.. List.

varbind(X,_,_V,X):-!.  % already constant 


   
plunder(SX,[],SX):-!.
plunder(SX,[Y|Z],R):-
    plunder((SX/Y),Z,R).

writeconjuncts(CL,TF):-
    for( member(C,CL),        writeconjunct(C,TF) ),

    track(2,(nl,
                for( (Y is_the K),          output(Y is_the K))) ).


writeconjunct(( P => Q) ,TF):-!,
    wrclause( (P => Q),TF ).

writeconjunct(P,TF):-!, 
    wrclause(P,TF).


wrclause(_,_):-
    value(queryflag,true), 
    !.

wrclause(P,TF):-
 \+ value(queryflag,true), 
    skupdate(P,TF).


skupdate(_,false):-!.
skupdate(P,true):-
    skup(P).

skup(true):-!.
skup(inconsistent):-!.
skup(undefined):-!.   
skup(_ isa thing):-!. 

skup(X isa _):-
    var(X),!,
    nl,write(' Uninstantiated Constant '),
    nl,
    abort. 

%test(X) :- \+ ( \+ ( X)).  
skup(R) :- %test
        \+ ( \+ ( redundant(R) ) ),
    ! . 

skup(P):-
    skup1(P).


skup1(A => B) :- !,
    track(1,prettyprint(A => B)),  
    assert( (A => B ) ). 


skup1(X isa M):-  
    !,
    premfakt(X isa M),            
    new_focus(X,M).   %% ==> evaluate.pl

skup1(P):-
    premfakt(P). 

%%  Discern between semi permanent and dynamic


premfakt(P):- 
    \+ fact0(P), 
    \+ difact(P), 
    \+ (P = (_ isa Y),testclass(Y)), 
    !,
    assertfact(P),    % new facts are inserted in stack order
    track(1,prettyprint(P)). 

premfakt(_). 

 
assertfact(P):-
    ( permanence =: 0 ),
    value(context_id,UID),  
    !, 
    retractall( difact(UID,P) ), 
    asserta( difact(UID,P) ).       %% reverse order

assertfact(P):-
    ( permanence =:1 ),
    !,
    value(context_id,UID), 
    retractall( fact0(P) ),
    retractall( difact(UID,P) ), 
    assert( fact0(P) ).            % straight order


testimpossible(P):-
    %explain(false),                    %% RS-140915    Typo?
    %interapp:explain_query(false),      %% RS-140915    Typo? Moved to ??
    !, 
    value( context_id, UID ),     
    retract( difact(UID,P) ). 

testimpossible(_).


redundant( equal/X/X/_ ):-!. %% Somewhat Ad Hoc
    
redundant(P):-
    tautology(P).

tautology(P) :- 
    tautol(P),
    track(2,(nl,write('** removed ** '),nl, write('    '),write(P),nl,nl)).


tautol(( _ => P)):- 
    tauthead(P), 
    !.


tautol( (A => C) ):- %% Assumes Protectable Rules are already handled
    occ(B,A), 
    B==C.


tauthead(true).  
tauthead(X isa _):- ground(X),!.
tauthead(_ isa C):-testclass(C). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%track( N, P ) :- 
%    value( trace, M ),  number(M), M >= N, 
%    !,
%    call(P)   %% TA-110130
%;
%    true.

transfix1(error,error):-!. 

transfix1(new:::P,nil):-   %%  ==> causes an extra [nil]
    \+ value(busflag,true), %% Set by Bustuc Application Program
    !,
    clausifystm(P),   %% translat.pl
    !. 

transfix1(new:::P,nil):-
         ( value(queryflag,false) ), 
         !,           
    clausifystm(P).   %% translat.pl


transfix1( QX:::P, R ) :- 
     clausifyq( QX:::P, R ). %% translat.pl



%%%%% Clausify Query %%%%%%%%%%%

%  No Skolemization


clausifyq( which(XT):::Y ,which(X):::Z):-
    nonvar(XT), XT= (X:_T),
    !, 
    condiq(Y, Z ).

clausifyq( howmany(XT):::Y ,howmany(X):::Z):-
    nonvar(XT), XT= (X:_T),
    !, 
    condiq(Y, Z ).


clausifyq( QX:::Y ,QX:::Z):-!, 
    condiq(Y, Z ).

clausifyq( not (exists(X)::Q) , Z):-!,
    condiq(forall(X)::not Q , Z ).

clausifyq( (P => Q) , (Z12 => Q) ):- %  clausify query
   condiq(P,Z12),
   !,
   writeconjunct((Z12 => Q),false).  %  no update

clausifyq( (P or Q) , Z12 ):- %  clausify query
   condiq((P or Q),Z12),
   !,
   writeconjunct(P or Q,false).  %  no update


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Translate a condition with quantifiers


condiq(P,Z12):-
   condq(P,Z),
   condopt(Z,Z12). 

condopt(Z,Z12):-
   flatlist(Z,FZ),  %% utility.pl
   optimize(FZ,Z12).

condq(set_of(X,Y,Z),set_of(X,Y1,Z)):-!, 
    condiq(Y,Y1). 

condq(aggregate(MAX,X,Y,P,Z),
      aggregate(MAX,X,Y,P1,Z)):-!, 
    condiq(P,P1).

condq((P => Q),(P1 => Q1)):-!,
    condq(P,P1),
    condq(Q,Q1).

condq((P or Q),(P1 ; Q1)):-!,  %%  last %% TA-090326
    condq(P,P1),
    condq(Q,Q1).

condq((P  and  Q)  and  R,Z):-!,
   condq(P  and (Q  and  R),Z).


condq(P and true,Q):-!, 
    condq(P,Q). 

condq(true and  P,Q):-!, 
    condq(P,Q).  



condq(P  and  Q,P1Q1):-!,
    condq1(P,P1),
    condq(Q,Q1),
    flatround((P1, Q1),P1Q1).      %% utility.pl

condq(not (A => B),Z):-!,
    condq(A  and  (not B),Z).

condq(not (not P), Z):-!,
    condq(P,Z).

condq(not false,true):-!. 
condq(not true,false):-!. 


condq(not P, not Q):-!,
    condiq(P,Q). 

/*
condq(not (P and Q), (not P1) or (not Q1)):-!, 
    condq(P,P1),
    condq(Q,Q1).
 
*/




condq(P,Q):-condq1(P,Q).

%% condq1 compiles a single condition

condq1(not (exists(X)::Q),Q1):-!,
    condq(forall(X)::not Q,Q1).

condq1(not (forall(X)::Q),Q1):-!,
    condq(exists(X)::not Q,Q1).

condq1(forall(_)::P,Z):-!, 
    P=Q, %    replace(P,X,_,Q),      %% replace X with a Free variable
    condq(Q,Z).                      %% Hazardious

condq1(exists(_)::P,Z):-!,
    condq(P,Z).

condq1(quant(N,X)::P,quant(N,Y)::Z):-
    nonvar(X), X= (Y:_T_),
    !,
    condiq(P,Z). %

condq1(set_of(X,Y,Z),set_of(X,Y1,Z)):- 
    condiq(Y,Y1).


% Prefer wider scope for or %

/*
condq1(not (P and Q), NPQ):- %%         (NP;NQ)):-
    condq((not P),NP),
    condq((not Q),NQ),
    optor(NP,NQ,NPQ), 
    !.
*/


% Prefer narrow scope for or (Redundant if after wider scope)
condq1(not PQ, (not PQ1)):- 
    condq(PQ,PQ1),
    !.

% Update focus also in questions 

condq1(X isa C, (isa)/World/C/X):- 
    value(textflag,true),
    value(world,World),
    World \== real,
    !.

condq1(X isa C,X isa C):- 
    nonvar(X),
 \+ value(queryflag,true), 
    !,
    new_focus(X,C).

condq1(P or Q, (P ; Q)):-!. %% TA-090326


condq1(P,P).

% 

optand(false, _,     false):-!.   
optand(_,     false, false):-!.
optand(true,  P,     P):-!.
optand(P,     true,  P):-!.
optand(P,     Q,    (P,Q)).


optor(false, P,    P):-!.  
optor(P,     false,P):-!.
optor(true,  _,    true):-!.
optor(_,     true, true):-!.
optor(P,     Q,    (P;Q)).

testquant(CR,A,B):-
   def number/CR/A/B . 

%% optimize(Square list, Condition)
%%
%% Quick and dirty optimization

optimize(A,B):-
    removesfluous(A,A2),
    sortcond(A2,A3), 
    utility:unsquare(A3,B).        %% utility.pl

% remove conditions that are superfluous in conjunction


removesfluous(X,Z):- %% preserve 1. occurrence %% TA-060211
    reverse(X,Y),    %% removesfluous([a,b,c,d,e,f,a],X) -> X= [a,b,c,d,e,f] ? //ok
    rems(Y,[],Z).    %% *** ([a,b,c,d,e,f,a],X) ->  [b,c,d,e,f,a] ?  //no

/*
removesfluous(X,Z):- 
    rems(X,[],Y),
    reverse(Y,Z). 
*/


rems([X|Y],L,Z):- % worse than a successor
     member(T,Y),
     superfluous(X,T), %% 
     !,
     rems(Y,L,Z).

rems([X|Y],L,Z):- %  worse than a predecessor
     member(T,L),
     superfluous(X,T), %% 
     !,
     rems(Y,L,Z).

rems([X|Y],L,Z):-
    !,
    rems(Y,[X|L],Z).

rems([],L,L).


% superfluous(X , Y ).
% X is superfluous in a conjunction with Y

superfluous(true,_).

%% superfluous(X isa _,_):-atom(X).  

superfluous(X,Y):-X==Y.
%% superfluous(_ isa thing,_).   %% <---- Experiment %% TA-071016
superfluous(X isa C,Y isa D):-
    X==Y,
    subclass(D,C). 


% sortcond(X,Y) Y is an optimal sequence

% ground < anything < testclass < numeric

%%
%%  all isa < ground < anything < numeric
%% 

sortcond([],[]):-!.
sortcond(Z1,[A|Z2]):-
    beats(Z1,A,REST), % Z1 is split into an A which is better 
                     % than  REST
    !,
    sortcond(REST,Z2).
sortcond(Z,Z).

% beats( L, X, Y )   X is not worse than any condition in Y

beats( [X], X, [] ) :- !.

beats( Z, ISA, L ) :-
    superbeat( ISA, Z ), % try them in this sequence
    deleteq( ISA, Z, L ).
    % OOOPS delete1( ila isa station, [ X isa station, .. ila isa_station] 
    % Dont remove ( and instantiate) X isa station

deleteq(X,[X1|Y],Y):- X == X1,!. 
deleteq(X,[U|V],[U|W]):-
    deleteq(X,V,W).


superbeat(X isa Y,Z):-member(X isa Y,Z), nonvar(X). 
superbeat(X isa Y,Z):-member(X isa Y,Z). %% easier to read, worse to execute
superbeat(X,Z):-      member(X,Z),  \+ (X = (not _Y)), ground(X). %% negation at last
superbeat(X,Z):-      member(X,Z), \+  (X = (not _Y)).   


%% Some removals destined for qev optimisation

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

newskolem(Y):-  
    do_count(skolocon), % skolocon := skolocon + 1
    ( skolocon =: Y ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Hazardous rule
% Check if a unification of the head with a condition
% will lead to a occurrence check anomaly ( infinite tree )

hazardrule(( P => Q)):- 
    occ(A,P),
    \+ A==Q,         %  not identical  ( => tatutology)
    numbervars(Q),
    freshcopy(A,B),  %  avoids occur check hazards
    subsumes(B,Q).

protectrule(P,P). %% Ad Hoc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
