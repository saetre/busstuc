/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE makeauxtables.pl
%% SYSTEM BUSSTUC
%% CREATED TA-971121
%% REVISED TA-100315


%%%%%%%% Section to create Auxillary Bus Tables          %%%%%%%
%   Also predicates for analysis and verification of routes   %%

% Create a file of auxillary bustables (auxtables.pl)
 

%% NB they are compiled again as a separate file
%% The dynamic predicates (xxx0) corresponds to (some of) the filed predicates xxx

:-volatile
          
  toredef0/3,  
  torehash0/2,
  nextstat0/2,  
  interior0/1,  
  transbuslist0/3, 
  statbus0/2,  
  busstat0/2,    
  unproperstation0/1,  
  fromstationonly0/1,
  tostationonly0/1.

:-dynamic  
  toredef0/3,  
  torehash0/2,  
  nextstat0/2,  
  interior0/1,  
  transbuslist0/3, 
  statbus0/2,  
  busstat0/2,    
  unproperstation0/1,  
  fromstationonly0/1,
  tostationonly0/1.

/*

Run in Main directory


%% 0.  Take backup (or use svn)

% cp db/auxtables.pl  db/backup.auxtables.pl
% cp db/namehashtable.pl  db/backup.namehashtable.pl

%%  1. Create Tables 

% busestuc.sav

?- makeauxtables.

  
%% 2. Create namehashtable

?- createhash.

%% 3. Finish

?-halt.

%%  4.  Recompile BusstUC

% busbase.sav
?-[busstuc]. %% or other
?-save_program(busestuc).
?-halt.

*/


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


makeauxtables:-
 
    reset_period,  %% get the right period 

    write('%  Please wait 1 minute...'),nl,

    %%tell('db/auxtables.pl'),    %% RS-121121
    open( 'db/auxtables.pl', write, Stream, [encoding('UTF-8')] ),
    set_output(Stream),

    writeheading,

    createstatbus,  % 30 sec

    createbusstat,  % 10 sec

    createunproperstations, % 10 sec

    createtransbuslist, % 20 sec

/**** %% AD HOC  OMITTED 

    createonlyfromstations, % 20 sec


    createonlytostations, % 20 sec
*/


    told,

%%     createcutribs,  % 2 min

    write(' Finish'),nl,nl,

    crerr.  %% List  undefined station references

writeheading:-
    datetime(A,B,C,D,E,F),
    write('/* -*- Mode:Prolog; coding:utf-8; -*- */'),        %% Make this work with open/4 and encoding %% RS-121118
    %%write('/* -*- Mode:Prolog; coding:utf-8; -*- */'),   %% For other prologs than sicstus, utf-8 compatible
    nl,
    write('% Auxillary tables created '),
    nl,
    write('%%from writeheading in utility/makeauxtables.pl'),
    nl, write('%% '), write(datetime(A,B,C,D,E,F)),
    nl,nl.


createstatbus:-

    set_of(K,(station(K),K \==''),SLIST),  %% NB occurs twice 

    for(member(S,SLIST),stallbuss(S)),

    createhovedt,

    dumppredas(statbus0(X,Y),statbus(X,Y)).

stallbuss(Station):-  %% NB use actual buses names 
    set_of(BusName,(passeq(Rid,_Statno,Station,_,_,_), %% TA-100311
                    route(Rid,_Bus,BusName)) 
          ,Z), 
    \+ (Z=[]),
   assert(statbus0(Station,Z)).


createhovedt:-  % mainly for tabuss
    set_of(BusName,(

       statbus0(X,List),
       corr(X,hovedterminalen),
       member(BusName,List)),

    Z),
    assert(statbus0(hovedterminalen,Z)).
%---

createbusstat:-
   for(bus(S),busstall(S)),
   dumppredas(busstat0(X,Y),busstat(X,Y)).


busstall(Bus):- 
    set_of(Station,

   (route(Rid,Bus,_),passeq(Rid,_Statno,Station,_,_,_)) 

          ,Z), 
    \+ (Z=[]),
   assert(busstat0(Bus,Z)).


createunproperstations:-  
        
    assert(unproperstation0(heaven)). %% dummy (needs 1)

/* SUSPENDED NOFUNK %% TA-090609

    set_of(stationD(S,D),stationD(S,D),Z), %% make it unique //StationD buslog
    for((member(stationD(S,D),Z),nopassanyway(D,S)),
    assert(unproperstation0(S))), %% PANIC
    dumppredas(unproperstation0(X),unproperstation(X)).
*/



%% NB  The following actually pressuposes that the old version of
%% unproperstation/1  is loaded.

%% It will always be correct after two "passes"

createonlyfromstations:-   
     for(fromstation1(A),assert(fromstationonly0(A))),

     dumppredas(fromstationonly0(X),fromstationonly(X)).


createonlytostations:- 
      for(tostation1(A),assert(tostationonly0(A))),

      dumppredas(tostationonly0(X),tostationonly(X)).

createtransbuslist:-

    thisdate_period_module(tt,_Todate,TTP), %% TT-period of current date
                                            %% set by reset_period
    makenext(TTP),

    makeinteriors,

    for(transbuslist1(X,Y,Z),assert(transbuslist0(X,Y,Z))),

    dumppredas(transbuslist0(X,Y,Z),transbuslist(X,Y,Z)).


nopassanyway(D,S):-
    \+ corr(S,_),
    \+ corr(_,S),
    \+ passanyway(D,S).


passanyway(D,S):-
     domain_module(D,TTP),
     TTP \== nil, 
     TTP:ex_passes4(_Trace,_Statno,S,_Seq,_DelArr,_DelDep),
%%     TTP:passes3(_Trace,S,_Seq,_DelArr,_DelDep),
     !. 




% It is impossible to go FROM  hovedterminalen to A  (in this order)

fromstation1(A):-
  
    tafind(A,(xproperstation(A), \+ corr_ht(A)), 

               taforall(Rid,passeq(Rid,_Statno,A,_,_,D1), 
    
                            taforall(D2,passes_ht(Rid,D2), 

                                       D2 > D1))).


% It is impossible to go from A to hovedterminalen (in this order)

tostation1(A):-
  
    tafind(A,(xproperstation(A), \+ corr_ht(A)), 

               taforall(Rid,passeq(Rid,_Statno,A,_,_,D1), 
    
                            taforall(D2,passes_ht(Rid,D2), 

                                        D1 > D2))).


xproperstation(A):-
    properstation(A),
    test(stationD(A,tt)).   %%% Vey Ad HOc, only TT   
  

corr_ht(A):- corr(A,hovedterminalen). 
%%              corrx(A,hovedterminalen). %% Tram

passes_ht(Rid,Delay):-
    passeq(Rid,_Statno,MD,_,_,Delay), 
    corr_ht(MD). 


tafind(_X,Y,Z):- Y,Z.
taexists(_X,Y,Z):-Y,Z,!.
taforall(_X,Y,Z):- \+ (Y, \+ Z),!.


%-------------------------------------------------------------

/* %% TA-080731
%% FILE debugroute.pl


debugroute:-

% Example contraints
 
   Station=dragvoll,
   Delay=0,
   Day = saturday,
   Bus=9,

passes2(Route,Station,_Seq,Delay),
departureday(X,Route,Time,Day),
route(X,Bus,_),

write((Route,X,Station,Delay,Time,Day)),nl,
fail.

*/


%  ----------------------------------------------


%% FILE inconstations.pl

%% Detect inconsistencies in station identifiers

crerr:-
    crerr1,
    crerr2.

crerr1 :-

  write('Undefined station identifiers '),nl,nl,

  set_of(X, (station_reference(X), \+ hpl(_,X,_Off)),

      Z),

  for(member(Y,Z),(write(Y),nl)),

  nl,
  write('-------------'),nl.  

crerr2 :-
  nl,
  write('Undefined street to station references '),nl,
    
  set_of(D,(streetstat(_A,_B,_C1,_C2,D), \+ station(D)),Z),

  for(member(Y,Z),(write(Y),nl)),

  nl,
  write('-------------'),nl.  





station_reference(X):- 
    placestat(_,X)
           ;
%    cmpl(_,_,X)  
%      ;
    isat(X,_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% FILE maketransbuslist.pl
%% CREATED TA-020403
%% REVISED TA-020802

%% Make transbuslist 
%%% TTP:ex_passes4(_Trace,_Statno,S,_Seq,_DelArr,_DelDep)

makenext(TTP) :-
  set_of(next(X,Y),
        (station(X),TTP:ex_passes4(Trace,_,X,S1,_,_),S2 is S1+1,TTP:ex_passes4(Trace,_,Y,S2,_,_)),
         Z),
  for(member(next(A,B),Z),assert(nextstat0(A,B))).



makeinteriors :-
    interiors(Z),
    for(member(I,Z),assert(interior0(I))).


interiors(Z):- set_of(X,interior(X),Z).


interior(Y):-  %% all neigbours have the same buslist
    statbus0(Y,H),

    complies( 

    (   nextstat0(X,Y),
        nextstat0(Y,Z)
    ),
 
   (   statbus0(X,H),
       statbus0(Z,H)
   )).


transbuslist1(B1,B2,Z):-
    busstat0(B1,Z1),
    
    busstat0(B2,Z2), 

    B1 @< B2,  %% term comparison

    set_of(X, connive(X,Z1,Z2), Z),  
              
    Z \== [].

connive(X,Z1,Z2):- 
   member(X,Z1),propertransfer(X), member(X,Z2)
; 
   member(U,Z1),corr_ht(U),member(V,Z2),corr_ht(V), 
   X=hovedterminalen.



complies(P,Q) :- \+ (P, \+ Q).

propertransfer(P):-
    station(P), 
    \+ interior0(P). %% Pre Stored



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




    
%% FILE amblehash.pl
%% SYSTEM  BUSSTUC
%% CREATED TA-010430
%% REVISED TA-010502


%% Method  

%% Strip off street suffix
%% First letter must be right

%% Store all versions with one letter missing

%% Search with all combinations with one character missing


/* 

¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

   toredef(nardosenteret,nil,nardosenteret).     %% full name/ not street
        hpl(16010341,nardosenteret,nardosenteret,'Nardosenteret').

   toredef(erlends,street,erlends).              %% prefix street
        streetstat(erlends_street,'Erlends veg',2,11,rydningen).

   toredef(amalienlyst,streetname,amalienlyst).   %% full street name 
           streetstat(amalienlyst,'Amalienlyst',1,6,travbanen).                               

   toredef(skytter,streetstat,skytterveien). %% full name/ full street 
        hpl(16010449,skytterveien,skytterveien,'Skytterveien').

      // skytter gaten -> skytterveien 

   toredef(skytter,street,skytter_street). %
       streetstat(skytter_street,'Skyttervegen',1,44,skytterveien).

       //   skytter gaten -> skytter_street

¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

*/


/*


torehash(ygdrasil,yggdrasil).
torehash(yggrasil,yggdrasil).
torehash(yggdasil,yggdrasil).
torehash(yggdrsil,yggdrasil).
torehash(yggdrail,yggdrasil).
torehash(yggdrasl,yggdrasil).
torehash(yggdrasi,yggdrasil).
*/



createhash :-
    write(' Please Wait 1 minute '),nl, %% TA-090317


    reset_period,  %% Use the current names (just for hashing)
 

    retractall(toredef0(_,_,_)),   %% NOT abolish
    retractall(torehash0(_,_)),  

    for(toretarget(X),
        generatehash(X)),
   !,
   %%tell('db/namehashtable.pl'),    %% RS-121121
    open( 'db/namehashtable.pl', write, Stream, [encoding('UTF-8')] ),
    set_output(Stream), 
    writeheading,

   dumppredas(toredef0(X,Y,Z),toredef(X,Y,Z)),
   dumppredas(torehash0(X,Y),torehash(X,Y)),
   told,

   consult('db/namehashtable.pl'), 

   nl,write(' Finished '),nl.



%%%%%%%%

% Create file namehash.pl with hashed predicate


toretarget(X):-
    ambletarget(X),
    \+ ends_with(X,_,street). %% already streeted

ambletarget(X):- sameplace(X,_);
                 samename(X,_);    

   %%        foreign(X);     %% No spellch on foreigns (fori-> Frei *)
   %%        abroad(X);      %% No spellch on abroad names

                 placestat(X,_);   %%%% \+ cmpl(_,_,X) ; % avoid X_Y * husebyhallen 

                 cmpl(X,_,_);
 
                 cmpl(_,X,_), atom(X), X \== []; 

                 composite_stat(X,_,_); %% includes X,[],X

                 composite_road(X,_,_);

                 cmpl(_,Y,_),member(X,Y); %% Expensive %% TA-080911

                 composite_stat(_,Y,_),member(X,Y); %% Expensive %% TA-080911

                 composite_road(_,Y,_),member(X,Y). %% Expensive %% TA-080911




/*  
                 tram_mod(T),T:composite_stat(X,_,_);
                 tram_mod(T),T:composite_stat(_,Y,_),member(X,Y).
*/



generatehash(X):-
    filterhash(X),

    splitgenroads(X,ZS),

    for(member((Y,Tag,Off),ZS),

      (remember(toredef0(Y,Tag,Off)),  

       set_of(YMiss,devcand(Y,YMiss),D1), 
  
       for(member((U,_Miss),D1),remembertorehash(U,Y)))).


filterhash(X):-
    \+ number(X),
    \+ (textlength(X,N), N=< 2).


devcand(U,(Y,Miss)):- 
	 name(U,[F|V]),
    delete1(M,V,W),
    name(Miss,[M]), %% uff
    name(Y,[F|W]).

devcand(U,(Y,nil)):- 
    tucsoundex(U,Y).

remembertorehash(U,_):-      %% dalne -> daln /+/ e
    textlength(U,N),N =< 3,  %% vere \-> være TA-080731 *
    !. % bus -> buås/ gl ->  (gol,gls,...)

remembertorehash(U,Y):- 

    \+ spurious_street_hash(U,Y),%% kroglunds -\-> kroglundsv

    remember(torehash0(U,Y)). 


spurious_street_hash(Kroglunds,Kroglundsv) :- 
    composite_stat(Johan,[P,Kroglunds,street],Johan_p_kroglundsv),
    ends_with_vg(Johan_p_kroglundsv),
    composite_stat(Johan,[P,Kroglundsv],      Johan_p_kroglundsv),
    ends_with_vg(Johan_p_kroglundsv).


spurious_street_hash(Kroglunds,Kroglundsv) :- %% TA-061108
    composite_stat(Johan,[Kroglunds,street],Johan_kroglundsv),
    ends_with_vg(Johan_kroglundsv),
    composite_stat(Johan,[Kroglundsv],      Johan_kroglundsv),
    ends_with_vg(Johan_kroglundsv).

spurious_street_hash(Flatås,Flatåsv) :- 
    composite_stat(Flatås,[street],Flatåsv),
    ends_with_vg(Flatåsv).


ends_with_vg(JPv):- 
    (ends_with(JPv,_,v),!
     ;
    ends_with(JPv,_,g)).



dumppred(T):-nl,listing(T),nl.


%% splitgenroad is called by failure loop
%% TA-080415

splitgenroads(X,Z):-
    set_of((Y,U,Off),splitgenroad(X,Y,U,Off),Z).

%%  TA-080415

splitgenroad(Abel,  Abel,street,Abel):-  
    composite_road(Abel,[street],_). 

splitgenroad(Wisting,  Wisting,street,Off):-  
    composite_road(_Oscar,[Wisting,street],Off).

splitgenroad(Churchills,  Churchills,streetstat,Churchills_v):-  
    composite_stat(Churchills,[V],Churchills_v),
    streetsyn(V),
    station(Churchills_v).

splitgenroad(X,  Y,streetstat,X):- 
    station(X),
    streetsyn(V),            %% lex.pl
    ends_with(X,Y,V), 
    Y \== ''.        

splitgenroad(Amalienlyst,  Amalienlyst,streetname,Amalienlyst):-
    composite_road(Amalienlyst,[],Amalienlyst).

splitgenroad(X,  X,nil,X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




assertpredlist(Z):-
    for(member(X,Z),assert(X)).


dumppredas(T0,T):-
    nl,
    write('%%% ' ),nl,nl, 
    for(T0,writepred(T)),
    nl.


writepredicates2(P,Q):-  
    for(P, writepred(Q)).



writepredicates(P):-  
    for(P, writepred(P)).


writepred3(P,Q):-
    set_of(P,Q,Ps),
    writepredlist(Ps).

writepredlist(Z):- for(member(X,Z),writepred(X)).

%% writepred(P):- write(P),write('.'),nl. // utility



%% FILE consistent_dates.pl
%% SYSTEM BUSSTUC
%% CREATED TA-050504
%% REVISED TA-050504

%% Verify that all movable holidays are included, and internally consistent


verify_movedates :-
   ver_movedate,
   !;
   (nl,output('***** The moving holidays are inconsistent *****'),nl).


 
ver_movedate :-    %% Added check for May17 %% TA-100106

   this_year(YYYY),

   easterdate(YYYY, Easterday ),
   named_date(easterday, Easterday ),

   sub_days( Easterday,1,Eastereve),
   named_date(eastereve,Eastereve),


   sub_days( Easterday,2,Good_friday),
   named_date(good_friday,Good_friday),

   sub_days( Easterday,3,Maundy_thursday),
   named_date(maundy_thursday,Maundy_thursday),


   sub_days( Easterday,7,Palm_sunday),  
   named_date(palm_sunday,  Palm_sunday),


   add_days( Easterday,1,Easterday2), 

   named_date(easterday2,Easterday2),

   add_days(Easterday,39,Ascension_day), %% TA-080107 % Bibl. 40th

   named_date(ascension_day,Ascension_day),

% If Ascension day falls on May1, then daycode is sunday anyway %% TA-080108
% If Ascension day falls on May17, then daycode is not Sunday

    named_date(may17,May17),   

(  Ascension_day = May17 -> _Sunday=holiday ; _Sunday=sunday),


   add_days(Easterday,48,      Whitsun_eve), %% TA-080108
   named_date(whitsun_eve,Whitsun_eve),

   add_days(Easterday,49,Whitsun_day), %% Bibl 50, Pentecost
   named_date(whitsun_day,Whitsun_day).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% VERFIFY name consistency differences in two different versions
%% e.g. r1611_100823 (previous winter-routes) and   
%%      r1611-110627 (current summer-routes)

%% example :- verify_consistency(r1611_130429, r1613_130622).
%% Discrepancies r1611_130429 r1613_130622 
%% alias_station2(16011196,bergheim_snuplass,bergheim_snpl).
%% alias_station2(16626030,sjøla,skjøla).
%% alias_station2(16627030,sjøla,skjøla).

verify_consistency(Mod1,Mod2):-
 
     out('%% Discrepancies'),   out(Mod1),out(Mod2),nl,
   
for(

   ( Mod1:hpl(Nr,Name1,_,_),
     Mod2:hpl(Nr,Name2,_,_),

     Name1 \== Name2),

     writepred(alias_station2(Nr,Name1,Name2))).




   






