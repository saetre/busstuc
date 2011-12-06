%% FILE amblehash.pl
%% SYSTEM  BUSSTUC
%% CREATED TA-010430
%% REVISED TA-010720

%% RS-111203    Moved to makeauxtables?


%% IMPORTS
%% RS-111205, UNIT: utility/
:- use_module( '../utility/utility', [
        delete1/3, ends_with/3,  for/2,   remember/1,   roundmember/2,   set_of/3   ] ).

%module( 'lex', [ ] ). %% ??
:- use_module( names, [ streetsyn/1 ]).

:- use_module( '../db/places', [  cmpl/3, % (NAME,NAME*,LIST)
  sameplace/2 ] ).

:- use_module( '../db/regcompstr', [ composite_road/3 ] ).

:- use_module( '../app/buslog', [  composite_stat/3,  place_station/2 ] ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Method  

%% Strip off street suffix
%% First letter must be right

%% Store all versions with one letter missing

%% Search with all combinations with one character missing


:-volatile toredef/2, torehash/2.
:-dynamic  toredef/2, torehash/2.


amblesearch(X,Y):-toresearch(X,Y).

toresearch(X,[X]):-number(X),!.

toresearch(X,[X]):-textlength(X,N), N=< 2,!.

toresearch(X,Z):-
    set_of(Y-Street,candsearch(X,Y,Street),Z).

%

bhash(X,Y,Street):-
   torehash(X,Y),
   toredef(Y,Street).

/*
toredef(yggdrasil,street).

torehash(ygdrasil,yggdrasil).
torehash(yggrasil,yggdrasil).
torehash(yggdasil,yggdrasil).
torehash(yggdrsil,yggdrasil).
torehash(yggdrail,yggdrasil).
torehash(yggdrasl,yggdrasil).
torehash(yggdrasi,yggdrasil).
*/


candsearch(X,Y,Street):-
    splitroad(X,U,Street),
    rtsearch(U,Y,Street).


rtsearch(U,U,Street):-
    toredef(U,Street).   % yggdrasil

rtsearch(U,Y,Street):-
    bhash(U,Y,Street).   % ygdrasil

rtsearch(U,Y,Street):-  % yggdrasil
    devcand(U,S),
    torehash(S,Y),
    toredef(Y,Street).
 
devcand(U,Y):-
	 name(U,[F|V]),
    delete1(_,V,W),
    name(Y,[F|W]).
 
splitroad(X,Y,street):-
    streetsyn(V),       %% lex.pl
    ends_with(X,Y,V),
    !.
splitroad(X,X,nil).


textlength(C,N):-name(C,A),length(A,N).


%%%%%%%%

% Create file with hashed predicate


/*

?- tell(scratch),
   createhash,
   told.


*/


toretarget(X):- sameplace(X,_);
%                place_stat(X,_);       %% RS-111203    OLD

                cmpl(X,_,_);
                cmpl(_,X,_),atom(X);
                cmpl(_,Y,_),member(X,Y);
                cmpl(_,Y,_),Y=(_,_),roundmember(X,Y);

                composite_stat(X,_,_);
                composite_stat(_,Y,_),member(X,Y);

                composite_road(X,_,_);
                composite_road(_,Y,_),member(X,Y)
%                                     ;
%                tram_mod(Tram),Tram:composite_stat(X,_,_);
%                tram_mod(Tram),Tram:composite_stat(_,Y,_),member(X,Y)
                                                         .


createhash :-
    write(' Wait a minute '),nl,
    for(toretarget(X),
        generatehash(X)),
   !,
   dumppred(toredef),
   dumppred(torehash).



generatehash(X):-
    filterhash(X),
    splitroad(X,Y,Z),
    Y \== '', 
    remember(toredef(Y,Z)),
    set_of(Y1,devcand(Y,Y1),D1),
    for(member(U,D1),remember(torehash(U,Y))).


filterhash(X):-
    \+ number(X),
    \+ (textlength(X,N), N=< 2).


dumppred(T):-nl,listing(T),nl.




