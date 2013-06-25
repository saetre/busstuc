%% FILE inger.pl
%% SYSTEM TUC
%% CREATED 941208
%% AUTHOR T.Amble
%% LAST REVISION TA-970528  

%% Intelligent Resolution
%% Non Horn Theorem Prover with level control
%% and two way explanation


%% fakt ==> factum   %% TA-970528


%% for conformation with ordinary queries

:- ensure_loaded('../declare').



:-op(970,fx,  [lkb]).
:-op(950,fy,  [lemma,fat]). 
:-op(950,xfy, [implies]).
:-op(600,xfy, knows).


:-volatile
          (::)/0,
          factum/1,
          fat/1,
          lemma/1,
          problem/1,
          rawproblem/1.
:-dynamic
          (::)/0,
          factum/1,
          fat/1,
          lemma/1,
          problem/1,
          rawproblem/1.

%%%%%%%%%%%%%%%%%%%%%%%%%%

exprove(P):-
    retractall(rawproblem(_)),
    assert(rawproblem(P)),
    inger.



%%% Main program



inger:- 
    nl,nl,
    output('*** INGER THEOREM PROVER ***'),
    nl,
    out(' Max Depth = '),value(maxdepth,N),output(N),
    nl,
    lemmas,
    theproblem(M),
    out(' * PROBLEM: '),  output(M),
    prov(M,_).


lkb(P):-
    retractall(problem(_)),
    retractall(lemma _),
    retractall(fat _),
    retractall('::'),
    compile(P).

%% lemmas need only be proved once.


lemmas:-
    lemmas_proved =: 1,!;  % reset by \reset and \begin
    nl,
    lemmas_proved :=1,
    proxy,  %% create known axioms bottom up
    for(lemma( A implies B), provelemma(A,B)).
    % lemmas_proved reset if failure
    

provelemma(A,B):-
        out(' * LEMMA: '),output(A implies B),  
        flink(A,B),
        nl,nl.


flink(A,B):-
        nl,
        out(' * Assume * '),output(ck(A)),
        asserta(factum(ck(A))),
        out(' * Prove  * '),output(ck(B)),
        prov(ck(B),1) -> 
          asserta(factum(ck(B if A))),
          out(' * Proved * '),
          output(ck(B if A)),
          retract(factum(ck(A)));
          
          prov(ck(B),0), 
          lemmas_proved := 0, 
          nl,
          retract(factum(ck(A))),
          abort.

theproblem(P):-
     problem(P),!;
     output('* THERE IS NO PROBLEM *'),fail.

cpro(P):-prov(ck(P),1).

prov(P,1):-
    nl,
    solve(P,X,0),
    !,
    print_proof(X),
    output(' * QED *'),
    nl.

prov(P,0):-
    nl,
    solvenot2(P,0),
    output(' * FAILED * '),
    nl.


solve2(Prob,Level) :-  
    nl,
    solve(Prob,X,Level),
    nl,
    print_proof(X),
    nl,
    output(' * QED *'),
    nl.


%%%%%%%%%%%%%%%%%%%%%%

% Inference Engine

solve((X , Y),P1 + P2,N):- %% X and Y
    !,
    solve(X,P1,N),
    solve(Y,P2,N).

solve(true,void,_):-!.

solve({P},proof(_,{P},void,N),N):-!, %% fact
    call(P).

solve(P,proof(_,P,fact,N),N):-fat(P).


solve(X,proof(RN,X,P,N1),N):-
    leveltest(N,N1),
    rule(RN,X,Y),
    solve(Y,P,N1).

fat P :-     factum(P).   %% EXTERNAL  Only reason on current dynamic facts
fat ck(P) :- known(P).  %% EXTERNAL 
fat P :-    computation(P).

computation(exceed/P/Q/_):-
     number(P),
     number(Q),
     P > Q .

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

solvenot2(Prob,Level) :-
    solvenot3(Prob,X,Level), % try all
    print_pr(X),
    false;
    true.
 
solvenot3((P , Q),proof('   ',P and Q,PrZ1-Z2,N),N):- %% P and Q
    leveltest(N,N1),
    attempt((P , Q),PrZ1,Z2,N1), %% P and Q
    solvenot2(Z2,N1).

solvenot3(X,proof(RN,X,PrZ1-Z2,N),N):-
    leveltest(N,N1),
    rule(RN,X,Z),
    attempt(Z,PrZ1,Z2,N1),
    solvenot2(Z2,N1).

rule(Name,A,B) :- Name::(A if B).
rule(rule,A,B) :- B => A.   

attempt(Z,PrZ1,Z2,N1):-
    hoist(Z,Z1,Z2),
    solve(Z1,PrZ1,N1),
    !.  % Z1 is the longest provable prefix

% Print Proof

print_proof(P):-
    output(' * PROOF * '),
    nl,nl,
    print_pr(P).

print_pr(void).

print_pr(X+Y):-
    !,
    print_pr(X),
    print_pr(Y).

print_pr(proof(_,_,void,_)):-
    !.

print_pr(proof(_,X,fact,N)):-
    !,
    indent(N), 
    write(X),write(' is TRUE'),
    nl,nl.

print_pr(proof(_,X,given,_)):-
    !,
    out(X),write(' is GIVEN',_),
    nl.

print_pr(proof(NX,X,Y,N)) :-
    indent(N),
    write(X),
    print_ref(NX),
    print_children(Y),
    nl,nl,
    !,
    print_pr(Y).

print_ref(NX):-
    write(' BECAUSE [ '),write(NX),write(' ]'),nl.


print_children((X+Y)+Z):-
    !,
    print_children(X+(Y+Z)).

print_children(X+Y):-
    !,
    print_child(X),
    write(' AND'),
    nl,
    print_children(Y).

print_children(X-Y):- 
    !,
    print_children(X),
    nl,
    taboutput('BUT NOT '),
    taboutput(Y).

print_children(X):-
    print_child(X).

print_child(void).

print_child(proof(_,X,_Y,_)) :-
    tab(8),write(X).

indent(_):- tab(1). %% tab(N)

taboutput(X):-tab(8),output(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




% creates increasing initial subsequences
%   a and b and c  ==> true , A and B and C   

hoist((A , B),X,Y):-hoist1((A , B),X,Y). %% A and B
hoist(B,true,B).

hoist1((A , B , C), (A , X), Y):- %% A and B and C
    hoist1((B , C), X, Y).

hoist1(( A , B),A,B).




%%%%%%THE END%%%%%%%%%%%%%%%%%%%

