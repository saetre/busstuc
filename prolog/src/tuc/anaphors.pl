%% FILE anaphors.pl
%% SYSTEM TUC
%% CREATED TA-930805
%% REVISED TA-100201

%% RS-131227    UNIT: tuc/
%% Anaphoric resolution
:- module( anaphors, [ matchresol0/2, nabi/3, resolve/2 ] ). % externalresolveit/2, inventresolveit/2, 

%% UNIT: / and /utility
:- ensure_loaded( user:'../declare' ).  %% RS-140915 , track/2
track(X, Y) :- user:track(X, Y) .

%% RS-131225, UNIT: utility/
:- use_module( '../utility/utility', [ match/2, nth/3 ] ). %local: , test/1
:- use_module( '../utility/library', [ reverse/2 ] ).%% RS-131225

%% RS-111205, UNIT: / 
%:- use_module( '../main.pl', [  ] ). %% RS-140209 hei/0,   run/0

%% RS-140210. UNIT: /tuc/
:- use_module( evaluate, [ disqev/1, fakt/1 ] ).          %% RS-140210
:- use_module( facts, [ isa/2 ] ).       %% RS-131225    Necessary?
:- use_module( fernando,[ subtype0/2, type/2 ] ).
:- use_module( semantic,[ subclass0/2 ] ).
:- use_module( translat, [ condq/2 ] ).       %% RS-140210

%% RS-140210. UNIT: /dialog/
:-use_module( '../dialog/newcontext2.pl', [ dialog_resolve/2 ] ).       %% RS-140210

%% META-PREDICATES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- meta_predicate test(0) .  %% RS-140615  %% test/1 is a meta-predicate ( just passing on the incoming X-predicate
test(X):- \+ ( \+ ( X)).        %% Calls test(nostation(Y)), test("X ako Y"), among other things, so: make it local in metacomp-> dcg_?.pl
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


resolve(P,Q):- % Only 1 external
    resolves(P,Q).

resolves([P1|P2],[Q1|Q2]):- 
    !,
    resolve1(P1,Q1),
    resolves(P2,Q2).
resolves([],[]):-!.

resolves(P,Q):- 
    resolve1(P,Q).

resolve1(P,Q):-
    resolist(P,DL,_UL),
    !,
    resolv(P,Q,DL),
    !. 



resolv(Z:::X,Z:::Y,L):- %% TA-090514 Sentence Tags (new:::)
    !,
    resolv(X,Y,L).


%% findexternal



resolv(findexternal(XT)::E::P, E::Q, L):- 
    !,
    resolv(findexternal(XT)::P,Q,L).      


resolv(findexternal(X:T)::P,Q,L):- % External resolution of pronoun
    externalresolve(X,X isa T),      
    !,
    resolv(P,Q,L).       

%%



resolv(findexternal(X:T)::P, exists(X:T)::Q, DL):-
    \+ rasool(X,_,DL),   %% X on DL identically ?
    !,
    inventresolve(X:T,P,Q,DL).  




resolv(findexternal(_)::P, Q, L):- 
    !,                          % already done
    resolv(P,Q,L).


%% findalt

resolv(findalt(diff,X:_,Y:T)::P,exists(Y:T)::Q,DL):-

    rasool(Y,_,DL),
    \+(X==Y),
    !,                     %% TA-100202
    resolv(P,Q,DL).

resolv(findalt(_,_,X:T)::P,exists(X:T)::Q,DL):-
    \+ rasool(X,_,DL),  
    !,
    inventresolve(X:T,P,Q,DL).  

resolv(findalt(_,_,_)::P,Q,L):-
    !,                          % already done
    resolv(P,Q,L).

%% findpron


resolv(findpron(X)::P,Q,L):-     % Internal resolution
    %% user:value(textflag,true),  
    %% \+ user:value(busflag,true), %% <-- Hazard ? 
    internalresolve(X,L),  
    !,
    resolv(P,Q,L).    



resolv(findpron(XT)::E::P, E::Q, L):- 
    !,
    resolv(findpron(XT)::P,Q,L).      


resolv(findpron(X:T)::P,Q,L):- % External resolution of pronoun
    externalresolve(X,X isa T),      
    !,
    resolv(P,Q,L).       

resolv(findpron(X:T)::P, exists(X:T)::  Q,L):- % External resolution of pronoun
                                               % failed
                                             % MUST be quantified
    inventresolve(X:T,P,Q,L).



%% find



resolv(find(X)::P,Q,L):-     % 1.  Internal resolution  first
%%%     user:value(textflag,true),    %% only for texts  
                             %% from nth to this palce \= nth
    \+ user:value(dialog,1), 
    internalresolve(X,L),  
    !,
    resolv(P,Q,L).    



resolv(find(X:_)::(W_and_P),Q,L):- % 2.  External resolution
    W_and_P = (W and _P),
    externalresolve(X,W),      
    !,
    resolv(W_and_P,Q,L).


resolv(find(X:_)::(W_or_P),Q,L):- % 2.  External resolution
    W_or_P = (W or _P),   
    externalresolve(X,W),      
    !,
    resolv(W_or_P,Q,L).


resolv(find(X:Y)::P, exists(X:Y)::Q,L):-  % 3. Invention resolution
    !,
    inventresolve(X:Y,P,Q,L).

%% findit 

resolv(findit(X)::P,Q,L):- % Internal resolution
    internalresolveit(X,L),      
    !,
    resolv(P,Q,L).    

resolv( findit(X)::P, Q, L ) :- % External resolution
    externalresolveit( X ),      
    !,
    resolv( P, Q, L ).

resolv( findit(X:T)::P, exists(X:T)::Q, L ) :-
    inventresolveit( X:T, P, Q, L ).


resolv(aggregate(A,X,Y,P,R),    
        aggregate(A,X,Y,Q,R),L):-
    resolv(P,Q,L).


resolv(Z::X,Z::Y,L):-
    !,
    \+ (Z=findit(_)),
    \+ (Z=findpron(_)), 
    \+ (Z=findexternal(_)), 
    resolv(X,Y,L).


resolv(X isa Y,X isa Y,_):-
    !.


resolv(A and B,A1 and B1,L):-
    !,
    resolv(A,A1,L),
    resolv(B,B1,L).

resolv(A or B,A1 or B1,L):- 
    !,
    resolv(A,A1,L),
    resolv(B,B1,L).

resolv(A => B,A1 => B1,L):- 
    !,
    resolv(A,A1,L),
    resolv(B,B1,L).

resolv(not A,not A1,L):-
    !,
    resolv(A,A1,L).

resolv(X,X,_):-
    \+ X = (findit(_)::_),  % catch all rest
    \+ X = (findpron(_)::_), 
    \+ X = (findexternal(_)::_). 


%inventresolveit( X:_T, _ ) :- nonvar(X), X=(_,_), ! , fail.    %% RS-141018  OLD?

inventresolveit( X:Y, P, X isa Y and Q, L ) :-
    !,
    track(2,(write('Unresolved reference:  '),
             write(Y),nl,nl)),        
    resolv(P,Q,L).

inventresolveit(X:Y,P,X isa Y and Q,L):- 
    !,
    track(2,(write('Unresolved reference:  '),
             write(Y),nl,nl)),        
    resolv(P,Q,L).


inventresolve(I:self,P,Q,L) :-  
    I isa self,  %% Code for myself ==> facts.pl 
    !,
    resolv(P,Q,L).

inventresolve(_:Y,P,Q,L):-
    !,
    track(2, 
       (nl,write('Unresolved reference:  '), write(Y),nl,nl)),      
    resolv(P,Q,L).


%% Should try exact match first 

internalresolve(X:_T,_):- nonvar(X),X=(_,_),!,fail.

internalresolve(X1:T,L):- % Try idents first 
    member(X2/0 isa T,L),
    nonvar(X2),
    X1=X2,                % and exact type match
    !.

internalresolve(X1:T,L):- 
    member(X2/0 isa U,L),
    nonvar(X2),
 
    anasumes(T,U),  

    X1=X2,
    !.

internalresolve(X1:T,L):- 
    member(X2/0 isa T,L),
    \+ (X1 == X2),
    X1 = X2,
    !.

internalresolve(X1:T,L):-
    member(X2/0 isa U,L),
    matchresol1(X1,X2),

    anasumes(T,U). 

%% You can only refer to a possible referent with a more general reference.

anasumes(T,U):- % referent T   versus reference U
    test(subclass0(U,T)).


%% internalresolveit

internalresolveit(X:_T,_):- nonvar(X),X=(_,_),!,fail. 

internalresolveit(X1:T,L):-
    member(X2/0 isa U,L),
    matchresol1(X1,X2), 

    anasumes(T,U),
    nogender(U).

%    type(Y,U),  
%     subsumes(T,U). 


matchresol1(X1,X2):- % dont match identical variables
    var(X1),
    var(X2),
    !,              % how can I explain this
    \+ (X1 == X2),
    X1=X2.

matchresol0(X1,X1). %% matches identical variables

%% Specific for  ...  this statement ...


externalresolve(tuc,tuc isa savant):- %% this system = TUC
    !.

%% externalresolve(tuc,tuc isa system):-  
%%     !.


externalresolve(X,P):-   %   Resolve references using the dialog manager
     user:value(dialog,1), 
     !, 
     condq(P,Q),
     dialog_resolve(X,Q),  % dialog/newcontext2.pl
     !.

externalresolve(X,P):-   % Dynamically query the qualia  X:_
     \+ user:value(busflag,true), %% Not allowed for several users !!! 
     condq(P,Q),
     disqev(Q),          % query the DB using only discourse elements
     nonvar(X),          % testclass returns variables
     !.


%% externalresolveit % % % 

externalresolveit( X:_T ) :- nonvar(X), X=(_,_), ! , fail.

externalresolveit( X:MT ) :-   % reference must not be
    user:value( textflag, true ),
    is_the( X, K ),            % more specific than referent
    type( K, KT ),
    nogender( KT ),
    subclass0( KT, MT ).


externalresolveit( tuc:thing ). %% this thing ==> tuc " it is good"

externalresolveit( it:T ) :- %% Var = this thing ==> tuc " it is good" 
    var(T),
    !.

externalresolveit(it:thing):- %% Var = this thing ==> tuc " it is good" 
    !.

is_the(X,K):-
    fakt(X is_the K).



% nogender tells which classes
% can be referenced by "it"


nogender(T):-  
   type(child,C),
   subtype0(T,C), 
   !.

nogender(T):-
   type(person,P),
   \+ subtype0(T,P). 


%% Method  

% make a chronological list of all nouns.
% Match a find(X)::P with the nouns preceding X 
% in the list.

resolist(P,DL,UL):-       %% Finds list of referents
    res2(P,[],DL,[],UL).  %% DL defined referents, 
                          %% DZ undefined references

%--------------------------------------

error_in_anaphors:-
        write( 'error_in_anaphors' ).   %% RS-140210

res2(V,    _,_,_,_):-var(V),!,error_in_anaphors. 

res2((_X,_Y),_,_,_,_):-!,error_in_anaphors. 

res2(findexternal(X:C)::P,L1,L,Z1,Z):- 
    !,
    mege(_,X/0 isa C,Z1,Z2),
    res2(P,L1,L,Z2,Z).

res2(findpron(X:C)::P,L1,L,Z1,Z):- 
    !,
    mege(_,X/0 isa C,Z1,Z2),
    res2(P,L1,L,Z2,Z).

res2(findalt(a,N,X:C)::P,L1,L,Z1,Z):- 
    !,                                
    mege(_,X/N isa C,L1,L2),
    res2(P,L2,L,Z1,Z).

res2(findalt(the,N,X:C)::P,L1,L,Z1,Z):- %% if the dont find match,
    mege(1,X/N isa C,L1,L2),
    !,
    res2(P,L2,L,Z1,Z).


res2(findalt(the,N,X:C)::P,L1,L2,Z1,Z):- %% if the dont find match,
    externalres2(N,X,C,L1,L),  %% EXTERNAL 
    !,                    
    res2(P,L,L2,Z1,Z).


res2(findalt(the,N,X:C)::_,L1,L1,Z1,Z):- %% if the dont find match,
    !,                
    mege(0,X/N isa C,Z1,Z).


res2(_::P,L,M,Z1,Z):-
    !,
    res2(P,L,M,Z1,Z).

res2(P and Q, L,M,Z1,Z):-
    !,              
    res2(P,L,L1,Z1,Z2),
    res2(Q,L1,M,Z2,Z).

res2(P  or Q, L,M,Z1,Z):- 
    !,              
    res2(P,L,L1,Z1,Z2),
    res2(Q,L1,M,Z2,Z).


res2(P => Q, L,M,Z1,Z):- 
    !,
    res2(P,L,L1,Z1,Z2),
    res2(Q,L1,M,Z2,Z).

res2(X1 isa C,L,L,Z,Z):-
    rasool(X1,C,L),
    !.

res2(X isa Y,L,[X/0 isa Y|L],Z,Z):-
    \+ rasool(X,Y,Z),
    !.

res2(_,L,L,Z,Z).
        
rasool(X1,C,DL):-         %%   X1/N isa Y exists on L
    member(T2 isa C,DL),
    match(T2,X2/_),
    X1==X2,
    !.

        
nabi(X1,C,DL):-         %%   X1/N isa Y exists on L
    member(T2 isa C,DL),
    match(T2,X2/_),
    X1=X2,
    !.

externalres2(N,X,C,L1,L):-      % Dynamically query the qualia  X:_
     bagof(Y,fakt(Y isa C),Z),  % Z > []
     discnth(N,Z,X),
     mege(_,X/N isa C,L1,L).    %    [X/N isa C|L1]).


discnth(N,Z,X):-
    reverse(Z,Z1),  %% discourse elements are stored in 
    nth(N,Z1,X).    %% reverse order.

mege( 1, X/N isa C, L, M ) :-
    member( Y isa C, L ),
    match( Y, X/N ),
    !,
    L=M.

mege(0,P,L,M):- 
    mege0(P,L,M).

mege0(X/N isa C,L,[X/N isa C|L]).



%%%%%%%%%%%%%%%%%%%%%THE END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
