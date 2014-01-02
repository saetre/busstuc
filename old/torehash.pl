%% FILE torehash.pl
%% SYSTEM  BUSSTUC
%% CREATED TA-010430
%% REVISED TA-010430



%% Method  

%% strip off street suffix
%% First letter must be right

%% Store all versions with one letter missing

%% Search with all combinations with one character missing

bhash(X,Y,Street):-
   ahash(X,Y),
   toredef(Y,Street).

toredef(yggdrasil,street).

ahash(ygdrasil,yggdrasil).
ahash(yggrasil,yggdrasil).
ahash(yggdasil,yggdrasil).
ahash(yggdrsil,yggdrasil).
ahash(yggdrail,yggdrasil).
ahash(yggdrasl,yggdrasil).
ahash(yggdrasi,yggdrasil).


%toresearch(X,Z):-
%    set_of(Y-Street,candsearch(X,Y,Street),Z).


candsearch(X,Y,Street):-
    splitroad(X,U,Street),
    rtsearch(U,Y,Street).


rtsearch(U,U,Street):-
    toredef(U,Street).   % yggdrasil

rtsearch(U,Y,Street):-
    bhash(U,Y,Street).   % ygdrasil

%rtsearch(U,Y,Street):-  % yggdrasil
%    devcand(U,S),
%    ahash(S,Y),
%    toredef(Y,Street).
% 
%devcand(U,Y):-
%	 name(U,[F|V]),
%    delete1(_,V,W),
%    name(Y,[F|W]).
% 
%splitroad(X,Y,street):-
%    streetsyn(V),       %% lex.pl
%    ends_with(X,Y,V),
%    !.
splitroad(X,X,nil).


%%%%%%%%

% Create file with hashed predicate


/*

?- tell(scratch),
   createhash,
   told.


*/

%toretarget(X):-station(X). %% Example
%
%createhash :-
%    for(toretarget(X),
%        generatehash(X)).
%
%
%
%generatehash(X):-
%    splitroad(X,Y,Z),
%    writepred(toredef(Y,Z)),
%    set_of(Y1,devcand(Y,Y1),D1),
%    for(member(U,D1),writepred(ahash(U,Y))).

