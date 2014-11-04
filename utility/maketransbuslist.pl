%% FILE maketransbuslist.pl
%% SYSTEM TABUSS
%% CREATED TA-020403
%% REVISED TA-020802

%% Make transbuslist 

:-module( maketransbuslist, [ maketransbuslist/0 ] ).

:-meta_predicate  complies( 0, 0 ).
:-meta_predicate  writepred3( ?, 0 ).

%:-volatile nextstat/2, interior/1.
%:-dynamic nextstat/2, interior/1.
:-volatile nextstat/2, interior1/1.     %% RS-140915 Typo?
:-dynamic nextstat/2, interior1/1.

:-use_module( '../utility/utility', [ for/2, set_of/3 ] ).    % RS-140915, transbuslist/3

%%% RS-111205, UNIT: /app/
:-use_module( '../app/buslog', [ bus_mod/1, station/1 ] ) .

:-use_module( '../db/auxtables', [ busstat/2, statbus/2 ] ).    % RS-140915, transbuslist/3


%% Compile together with TABUSS/ BUSSTUC


maketransbuslist:-
    
    makenext,

    makeinteriors,

    %%tell('transbuslist.pl'),    %% RS-121121
    open( 'transbuslist.pl', write, Stream, [encoding('UTF-8')] ),
    set_output(Stream),

    writepred3( transbuslist(X,Y,Z), transbuslist1(X,Y,Z) )

    , told
    .

passes3( Tour, STATNO, B, C, D, E) :-   bus_mod(TTP),TTP:ex_passes4( Tour, STATNO, B, C, D, E ). %% RS-141102 Resurrect needed?

makenext :-
  set_of( next(X,Y),( station(X), passes3(Tour,X,S1,_,_,_), S2 is S1+1, passes3(Tour,Y,S2,_,_,_) ),Z ),
  for( member( next(A,B), Z ), assert(nextstat(A,B)) ).


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
