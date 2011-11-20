%% FILE maketransbuslist.pl
%% SYSTEM TABUSS
%% CREATED TA-020403
%% REVISED TA-020802

%% Make transbuslist 

:-dynamic nextstat/2, interior/1.



%% Compile together with TABUSS/ BUSSTUC


maketransbuslist:-
    
    makenext,

    makeinteriors,

    tell('transbuslist.pl'),

    writepred3(transbuslist(X,Y,Z),transbuslist1(X,Y,Z))

    , told
    .




makenext :-
  set_of(next(X,Y),(station(X),passes3(Tour,X,S1,_,_),S2 is S1+1,passes3(Tour,Y,S2,_,_)),Z),
  for(member(next(A,B),Z),assert(nextstat(A,B))).


makeinteriors :-
    interiors(Z),
    for(member(I,Z),assert(interior1(I))).


interior(Y):-  %% all neigbours have the same buslist
    statbus(Y,H),

    complies( 

    (   nextstat(X,Y),
        nextstat(Y,Z)
    ),
 
   (   statbus(X,H),
       statbus(Z,H)
   )).

writepred3(P,Q):-
    set_of(P,Q,Ps),
    writepredlist(Ps).

writepredlist(Z):- for(member(X,Z),writepred(X)).

writepred(P):- write(P),write('.'),nl.



complies(P,Q) :- \+ (P, \+ Q).


interiors(Z):- set_of(X,interior(X),Z).

propertransfer(P):-
    station(P), 
    \+ interior1(P). %% Pre Stored



transbuslist1(B1,B2,Z):-
    busstat(B1,Z1),
    
%    write('.'), 

    busstat(B2,Z2), 

    B1 @< B2,  %% term comparison

    set_of(X, (propertransfer(X),
               member(X,Z1),
               member(X,Z2)),Z),
    Z \== [].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
