%% FILE world0.pl
%% SYSTEM TUC
%% AUTHOR  T.Amble
%% CREATED 861231
%% REVISED TA-990115

:- module( tuc, [ area/2 ] ).           %% Module TUC  %% RS-111121

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Contains dummy (dynamic- or toy-) predicates for optional applications
% to avoid missing  predicates error messages.

%% May be redefined by compiling application files (eg chatw1.pl/ bus.pl etc)


%% For the BUS application


%% For the CHAT-80 application

:- dynamic        
          border/2,
          city/3,
          contain/2,
          containsX/4,
          contains4/4,
          country/8,
          continent_region/2, 
          region_country/2,
          country_city/2,
          country_river/2,
          river/2,
          continent/1,
          in_continent/2,
          ocean/1,
          sea/1,
          circle_of_latitude/1,
          latitude0/2.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Data for the World Database.
% ---------------------------

%% THIS WILL BE AUTOMATED FROM SCHEMA SOME DAY

% contains   continent 
%                |
%              region 
%                |
%               country
%                / \
%               /   \
%             city river  




african(X) :-  contains4(continent,_,africa,X),!. 
american(X) :- contains4(continent,_,america,X),!. 
asian(X) :-    contains4(continent,_,asia,X),!.
australian(X):-contains4(country,_,  australia,X),!.
european(X) :- contains4(continent,_,europe ,X),!.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


borders(X,C) :- 
    border(C,X);
    border(X,C). 


capital(C) :- capital(_,C).
city(C) :- city(C,_,_).
% country(C) :- country(C,_,_,_,_,_,_,_). 
currency(C,D):- country(C,_,_,_,_,_,_,D).

region(R) :- in_continent(R,_).


in(X,Y) :- var(X), nonvar(Y), !, contains(Y,X).
in(X,Y) :- in0(X,W), ( W=Y ; in(W,Y) ).

in0(X,Y) :- in_continent(X,Y).
in0(X,Y) :- city(X,Y,_).
in0(X,Y) :- country(X,Y,_,_,_,_,_,_).
in0(X,Y) :- flows(X,Y).


country_region(C,R):-     country(C,R,_,_,_,_,_,_).
country_latitude(C,L):-   country(C,_,L,_,_,_,_,_).
country_longitude(C,L):-  country(C,_,_,L,_,_,_,_).
country_area(C,A):-       country(C,_,_,_,A,_,_,_).
country_population(C,P):- country(C,_,_,_,_,P,_,_).
country_capital(C,K):-    country(C,_,_,_,_,_,K,_).
country_currency(C,K):-   country(C,_,_,_,_,_,_,K).

geometric_latitude(X,Y):- 
    latitude0(X,Y).

geometric_longitude(X,Y):-
    longitude0(X,Y).


city_country(X,C):-
    city(X,C,_).

city_population(X,P):-
    city(X,_,P).

latitude(C,L) :-latitude0(C,L). %% continent.pl
latitude(C,L) :- country(C,_,L,_,_,_,_,_).
longitude(C,L) :- country(C,_,_,L,_,_,_,_).

area(C,A) :-
   country(C,_,_,_,A,_,_,_). 

population(C,P) :- city(C,_,P).

population(C,P) :-
   country(C,_,_,_,_,P,_,_). 

capital(C,Cap) :- country(C,_,_,_,_,_,Cap,_).

seamass(X) :- ocean(X).
seamass(X) :- sea(X).


river(R) :- river(R,_).

rises(R,C) :- river(R,L), lastmem(L,C).

drains(R,S) :- river(R,L), first(L,S).

flows(R,C) :- flows(R,C,_).

flows(R,C1,C2) :- 
    river(R,L), links(L,C2,C1).

flows_into(R,C):-  
    river(R,L),
    sniplast(L,L1),  % not last  (in reverse order)
    member(C,L1).

flows_outfrom(R,C):- 
    river(R,L),
    snipfirst(L,L1),  % not first (in reverse order)
    member(C,L1).

first([X|_],X).

links([X1,X2|_],X1,X2).
links([_|L],X1,X2) :- links(L,X1,X2).



%%%%%%%%%%%%%%%%%%%%%%%%%%THE END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




