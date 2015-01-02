/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE makeauxtables.pl
%% SYSTEM BUSSTUC
%% CREATED TA-971121    %% REVISED TA-100315
%% REVISED  RS-140101 modularized
%% REVISED  RS-140101 discrepancies.pl (verify_consistency)

%%%%%%%% Section to create Auxillary Bus Tables           %%%%%%%

%% RS-131225    From torehash.pl (010101)  %% dynamic
:-module( makeauxtables, [ createhash/0, createonlyfromstations/0, createonlytostations/0, makeauxtables/0, nopassanyway/2, 
                           taexists/3, verify_consistency/0, verify_files_exist/1 %, verify_movedates/0 %% RS-140928 moved to db/timedat.pl
                         ] ).

% Create files with auxillary bustables (auxtables.pl)
 
%% NB they are compiled again as a separate file
%% The dynamic predicates (xxx0) corresponds to (some of) the filed predicates xxx

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% USAGE: See bottom of the file!                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% META-PREDICATES SECTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- meta_predicate complies(0,0) .
:- meta_predicate dumppredas(0,?).       %% Moved to extracut... ??

:- meta_predicate tafind(?,0,0), taexists(?,0,0), taforall(?,0,0) .
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% MOVED BACK TO UTILITY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%:- meta_predicate for(0,0) .   
%for( P, Q ) :- %% For all P, do Q (with part of P). Finally true! forall/2 is sometimes false?
%  P, Q,
%  false;true.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%:- meta_predicate set_of(?,0,?) .       %% RS-140615 Fix all meta_predicates like this? No arguments (suppressed or not?)
%set_of( X, Y, Z ):-           %%
%    setof(X,Y^Y,Z),!;     %% Trick to avoid alternatives
%    Z=[].                 %% What is wrong with empty sets ?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%:- meta_predicate test(0) .
%test(X):- \+ ( \+ ( X)).        %% Calls test(nostation(Y)), test("X ako Y"), among other things, so: make it local in metacomp-> dcg_?.pl
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% RS-140102. UNIT: /  and  /utility/  %% RS-140101 Moved to user:declare for common and early compilation!
%:- ensure_loaded( 'declare.pl' ). %, [ := /2 etc. ] ). test/1 
:- use_module( declare, [ remember/1 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .

:- use_module( 'utility/utility.pl', [  delete1/3, ends_with/3, for/2, set_of/3, textlength/2 ] ).
:- use_module( 'utility/datecalc.pl', [ datetime/6 ] ). % add_days/3, easterdate/2, sub_days/3, this_year/1 ]).%% RS-121325-140928 to timedat.pl
:- use_module( 'utility/writeout', [  out/1, output/1, writepred/1 ] ). %writepred/1 is USED! in for/3 or set_of/3,

%:- compile( busroute:'compileroute.pl' ).   %% Bootstrapping for compilation, faster than "ensure loaded"?!
:- use_module( 'compileroute.pl', [ consultbase/1 ] ). %% Interface modules
%COMPILE THE ENTIRE BUSROUTE
:- consultbase(tt).   %% Bootstrapping for compilation

:- use_module( 'interfaceroute', [ domain_module/2, thisdate_period_module/3, reset_period/0 ] ).

%% RS-111205, UNIT: /app/
:- use_module('app/buslog', [ composite_stat/3, properstation/1, stationD/2 ] ). %, passeq/6, station/1 ] ). %% RS-131223   route/3,  etc.

%% RS-111205, UNIT: db/
:- use_module( 'db/places.pl', [ cmpl/3,        isat/2,         placestat/2,    sameplace/2 ] ). % (NAME,NAME*,LIST) % (STATION,PLACE)  % (PLACE,STATION)  % (PLACE,PLACE).
:- use_module( 'db/regcompstr.pl', [ composite_road/3 ] ).
:- use_module( 'db/places.pl' , [ corr/2, isat/2, placestat/2 ] ).
:- use_module( 'db/regstr', [ streetstat/5 ] ). %% RS-131225  makeauxtables USES a for-loop WITH streetstat in it!!
%:- use_module( 'db/timedat.pl', [ named_date/2 ] ).       %%  EASTER DATES AND OTHERS %% RS-131225
:- use_module( 'db/topreg', [ default_period/3  ] ).
%:- use_module( 'db/busdat.pl', [ nightbus/1, vehicletype/2, xforeign/1 ]).

%%% RS-131225, UNIT: tuc
:- use_module( 'tuc/lex.pl', [  tucsoundex/2  ] ).      %% RS-140101 makeauxtables->lex
:- use_module( 'tuc/names.pl', [  samename/2,  streetsyn/1  ] ).

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tafind(_X,Y,Z):- Y,Z.
taexists(_X,Y,Z):-Y,Z,!.
taforall(_X,Y,Z):- \+ (Y, \+ Z),!.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

verify_files_exist( Filename ) :-
        output( Filename ),
        output('...makeauxtables.pl~103: auxtables-file already exists!!!'), nl,
        true .
%        false . % FORCE REGENARATION OF THE DB-files

makeauxtables :-
    %    verify_files_exist( 'db/auxtables.pl' ) ; 
    told,       %% Close all potentially open output-streams first!
%    user:( tramflagg := false ), %% RS-140106 Trenger ikke auxtables for tram?!?
%    user:( tmnflagg := false ), %% RS-140106 Trenger ikke auxtables for trafikanten midtnorge?!?
    reset_period,  %% get the right period 

    write( '... makeauxtables~114: Please wait 1 minute while creating (db/auxtables) regstr/2' ),nl,

    open( 'db/auxtables.pl', write, Stream, [encoding('UTF-8')] ), %% RS-140102, Run from monobuss folder !!
    %open( 'auxtables.pl', write, Stream, [encoding('UTF-8')] ), %% RS-140102, Run from the /db/ folder !!
    set_output(Stream),

    writeheading( 'auxtables, [ busstat/2, statbus/2, transbuslist/3, unproperstation/1 ]' ),  %% Didn't work?

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
    write(' Finish'),nl,

    crerr.  %% List  undefined station references


writeheading( Module ) :-
    datetime(A,B,C,D,E,F),
    write('/* -*- Mode:Prolog; coding:utf-8; -*- */'),nl,  %% Make this work with open/4 and encoding %% RS-121118
    %%write('/* -*- Mode:Prolog; coding:utf-8; -*- */'),nl %% For other prologs than sicstus, utf-8 compatible
    write('% Auxillary tables created '),nl,
    write('%%from writeheading in utility/makeauxtables.pl'),nl,
    write('%% '), write(datetime(A,B,C,D,E,F)),nl,
    write(':-module( '), write(Module), write(' ). '),nl,
    nl.


createstatbus:-

    set_of(K,(buslog:station(K),K \==''),SLIST),  %% NB occurs twice 

    for(member(S,SLIST),stallbuss(S)),

    createhovedt,

    dumppredas(statbus0(X,Y),statbus(X,Y)).

stallbuss(Station):-  %% NB use actual buses names (stop, allbuss?)
    set_of( BusName, ( buslog:passeq(Rid,_Statno,Station,_,_,_),  %% TA-100311 %% RS-140102
                    buslog:route(Rid,_Bus,BusName) ) 
          ,Z), 
    \+ (Z=[]),
   assert(statbus0(Station,Z)).


createhovedt:-  % mainly for tabuss, %% RS-140102 hovedterminalen is default to/from
    set_of(BusName,(

       statbus0(X,List),
       places:corr(X,hovedterminalen),
       member(BusName,List)),

    Z),
    assert(statbus0(hovedterminalen,Z)).
%---

createbusstat:-
   for(buslog:bus(S),busstall(S)),
   dumppredas(busstat0(X,Y),busstat(X,Y)).


busstall(Bus):- 
    set_of(Station,

   (buslog:route(Rid,Bus,_),buslog:passeq(Rid,_Statno,Station,_,_,_)) 

          ,Z), 
    \+ (Z=[]),
   assert(busstat0(Bus,Z)).


createunproperstations :-
    assert( unproperstation0(heaven) ), %% dummy (needs 1) %% RS-140927TODO: Try to fix this again?. 

/* SUSPENDED NOFUNK %% TA-090609 */
    set_of(stationD(S,D),stationD(S,D),Z), %% make it unique //StationD buslog
    for((member(stationD(S,D),Z),nopassanyway(D,S)),
    assert(unproperstation0(S))), %% PANIC
    dumppredas(unproperstation0(X),unproperstation(X)).
/* SUSPENDED NOFUNK %% TA-090609 */



%% NB  The following actually pressuposes that the old version of
%% unproperstation/1  is loaded.

%% It will always be correct after two "passes"

createonlyfromstations :-   
     for( fromstation1(A), assert( fromstationonly0(A) ) ),

     dumppredas( fromstationonly0(X), fromstationonly(X) ).


createonlytostations:- 
      for( tostation1(A), assert( tostationonly0(A) ) ),

      dumppredas( tostationonly0(X),tostationonly(X) ).

createtransbuslist:-

    thisdate_period_module( _Module, _Todate, TTP ), %% SomeOnes-period covering current date  %% set by reset_period/0
    makenext( TTP ),

    makeinteriors,

    for( transbuslist1(X,Y,Z), assert( transbuslist0(X,Y,Z) ) ),
    dumppredas(transbuslist0(X,Y,Z),transbuslist(X,Y,Z)).       %% TODO_ Remember to FORGET all the transbuslist0 that where just written to file again?


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



xproperstation(A):-
    properstation(A). %% , test( stationD(A,tt) ).   %%% Very Ad Hoc, only TT    %% TOD O: RS-140210 
        %% RS-140914 What about unproperstation(X) ??

% It is impossible to go FROM  hovedterminalen to A  (in this order)

fromstation1(A):-
  
    tafind( A, ( xproperstation(A), \+ corr_ht(A) ), 

               taforall(Rid,buslog:passeq(Rid,_Statno,A,_,_,D1), 
    
                            taforall(D2,passes_ht(Rid,D2), 

                                       D2 > D1))).


% It is impossible to go from A to hovedterminalen (in this order)

tostation1(A):-
  
    tafind(A,(xproperstation(A), \+ corr_ht(A)), 

               taforall(Rid,buslog:passeq(Rid,_Statno,A,_,_,D1), 
    
                            taforall(D2,passes_ht(Rid,D2), 

                                        D1 > D2))).


corr_ht(A):- corr(A,hovedterminalen). 
%%              corrx(A,hovedterminalen). %% Tram

passes_ht(Rid,Delay):-
    buslog:passeq(Rid,_Statno,MD,_,_,Delay), 
    corr_ht(MD). 

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
buslog:route(X,Bus,_),

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

  nl, write('Undefined - identifiers... (db/places) placestat/2'),nl,nl,

  set_of(X, (station_reference(X), \+ buslog:hpl(_,X,_Off)),

      Z),

  for(member(Y,Z),(write(Y),nl)),

  nl,
  write('-------------'),nl.  

crerr2 :-
  nl,
  write( 'Undefined street to station references (streetstat/5)' ),nl,
    
  set_of(D,(regstr:streetstat(_A,_B,_C1,_C2,D), \+ buslog:station(D)),Z),

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
        (buslog:station(X),TTP:ex_passes4(Trace,_,X,S1,_,_),S2 is S1+1,TTP:ex_passes4(Trace,_,Y,S2,_,_)),
         Z),
  for(member(next(A,B),Z),assert(nextstat0(A,B))).



makeinteriors :-
    interiors(Z),
    for(member(I,Z),assert(interior0(I))).


interiors(Z):- set_of(X,interior(X),Z).

complies(P,Q) :- \+ (P, \+ Q).

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


propertransfer(P):-
    buslog:station(P), 
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
        buslog:hpl(16010341,nardosenteret,nardosenteret,'Nardosenteret').

   toredef(erlends,street,erlends).              %% prefix street
        streetstat(erlends_street,'Erlends veg',2,11,rydningen).

   toredef(amalienlyst,streetname,amalienlyst).   %% full street name 
           streetstat(amalienlyst,'Amalienlyst',1,6,travbanen).                               

   toredef(skytter,streetstat,skytterveien). %% full name/ full street 
        buslog:hpl(16010449,skytterveien,skytterveien,'Skytterveien').

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
    %    verify_files_exist( 'db/namehashtable.pl' ) ;
    told,
    write('... makeauxtables~488: Please Wait another minute for namehash-table'),nl, %% TA-090317

    reset_period,  %% Use the current names (just for hashing)

    retractall(toredef0(_,_,_)),   %% NOT abolish
    retractall(torehash0(_,_)),  

    for( toretarget(X),
        generatehash(X) ),      % Generate all toredef0 to write as toredef in namehashtable.pl
   !,
    open( 'db/namehashtable.pl', write, Stream, [encoding('UTF-8')] ),     %% Call from monobuss.pl (store in db...)
    set_output(Stream), 
    writeheading( 'namehashtable, [ toredef/3, torehash/2 ]' ),   %%write(':-module(namehashtable, [ toredef/3, torehash/2 ]).'),nl,

   dumppredas(toredef0(X,Y,Z),toredef(X,Y,Z)),
   dumppredas(torehash0(X,Y),torehash(X,Y)),
   told,

%%   consult('db/namehashtable.pl'),      %% Test it?     %% RS-131225

   nl,write(' Finished! Now run: consult(\'db/namehashtable.pl\') '),nl.



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

      (remember( toredef0(Y,Tag,Off) ), % remember( makeauxtables:toredef0/3 )

       set_of(YMiss,devcand(Y,YMiss),D1), 
  
       for(member((U,_Miss),D1),remembertorehash(U,Y)))).


filterhash(X):-
    \+ number(X),
    \+ (textlength(X,N), N=< 2).


devcand(U,(Y,Miss)):- 
	 name(U,[F|V]),
    delete1(M,V,W),        %% RS-140101
    name(Miss,[M]), %% uff
    name(Y,[F|W]).

devcand(U,(Y,nil)):- 
    tucsoundex(U,Y).

remembertorehash(U,_):-      %% dalne -> daln /+/ e
    textlength(U,N),N =< 3,  %% vere \-> være TA-080731 *
    !. % bus -> buås/ gl ->  (gol,gls,...)

remembertorehash(U,Y):- 

    \+ spurious_street_hash(U,Y),%% kroglunds -\-> kroglundsv

    remember(makeauxtables:torehash0(U,Y)). 

%https://sicstus.sics.se/spider/determinacy_analyzer.html How to hide "fake" non-success warnings? RS-140928
spurious_street_hash( Kroglunds, Kroglundsv ) :-
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



%%% dumppred(T):-nl,listing(T),nl.      %% RS-131225 OBSOLETE?


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
    buslog:station(Churchills_v).

splitgenroad(X,  Y,streetstat,X):- 
    buslog:station(X),
    streetsyn(V),            %% lex.pl
    ends_with(X,Y,V), 
    Y \== ''.        

splitgenroad(Amalienlyst,  Amalienlyst,streetname,Amalienlyst):-
    composite_road(Amalienlyst,[],Amalienlyst).

splitgenroad(X,  X,nil,X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


dumppredas( T0, T ):-
    nl,
    write('%%% ' ),nl,nl, 
    for( T0, writepred(T) ),
    nl.

%OBSOLETE from maketransbuslist.pl
%assertpredlist(Z):-
%    for(member(X,Z),assert(X)).

%writepredicates2(P,Q):-  
%    for(P, writepred(Q)).

%writepredicates(P):-  
%    for(P, writepred(P)).

%writepred3(P,Q):-
%    set_of(P,Q,Ps),
%    writepredlist(Ps).

%writepredlist(Z):- for(member(X,Z),writepred(X)).

%% writepred(P):- write(P),write('.'),nl. // utility

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% VERFIFY name consistency differences in two different versions
%% e.g. r1611_100823 (previous winter-routes) and   
%%      r1611-110627 (current summer-routes)

%% example:
%%  :- verify_consistency(r1611_130429, r1613_130622).
%% Discrepancies r1611_130429 r1613_130622 
%% alias_station2(16011196,bergheim_snuplass,bergheim_snpl).
%% alias_station2(16626030,sjøla,skjøla).
%% alias_station2(16627030,sjøla,skjøla).

%% RS-140420 Default consistency check to be used at every re-compilation
verify_consistency :-
%        default_period( tt, winter, First ) ,
%        default_period( tt, summer, First) ,
        default_period( tt, previous, First) ,
        reset_period ,
        thisdate_period_module( _Module, _, Second ) , % contains the actual period... Dynamicly updated by reset_period/0  (above)

        utility:append_atoms( 'db/tables/', First, SummerFile ),
        utility:append_atoms( 'db/tables/', Second, WinterFile ),
        utility:append_atoms( SummerFile, '/reghpl.pl', SummerFileExtension ),
        utility:append_atoms( WinterFile, '/reghpl.pl', WinterFileExtension ),

        ensure_loaded( Second:WinterFileExtension ),
        ensure_loaded( First:SummerFileExtension ),
        verify_consistency( Second, First ) .

verify_consistency( Mod1, Mod2 ) :-
 
     out('%% db/discrepancies'),   out(Mod1),out(Mod2),nl,
   
for(

   ( Mod1:hpl(Nr,Name1,_,_),
     Mod2:hpl(Nr,Name2,_,_),

     Name1 \== Name2),

     writepred( alias_station2(Nr,Name1,Name2)) ).

%:-told.            %% RS-140208 Reset all output-streams first...
%:-nl,write( 'makeauxtables.pl~line790 is making auxtables now...' ),nl.
%:-nodebug.      %% Debugging this takes more than a minute, against only 10 secs in compile-mode! == :-notrace.
%:-debug.      %% Debugging this takes more than a minute, against only 10 secs in compile-mode! == :-notrace.
%:-trace.      %% Debugging this takes more than a minute, against only 10 secs in compile-mode! == :-notrace.

% REMOVED SOME OBSOLETE PREDICATES      RS-140928
%        busstall/1, busstat0/2, connive/3, dumppredas/2, fromstation1/1, generatehash/1, interior/1, 
%        makeauxtables/0,        splitgenroad/4,         stallbuss/1,    statbus0/2,     station_reference/1,    toretarget/1,
%        transbuslist1/3,        writeheading/1,   %   Also predicates for analysis and verification of routes    %%
%        passanyway/2,            tostation1/1, % It is impossible to go from A to hovedterminalen (in this order)   %verify_consistency/2,
%        verify_consistency/0,   fromstationonly0/1,     nextstat0/2,             tostationonly0/1, transbuslist0/3, unproperstation0/1,  % Helper predicates for makeauxtables (->createstatbus)
%        devcand/2,              remembertorehash/2,     toredef0/3,     torehash0/2,        % Helper predicates for createhash
%        passes_ht/2,            taforall/3,     xproperstation/1        % Helper predicates for to/from-station1/1 etc.    %% RS-131225For fromstation1/1
%] ).

%% From utility.pl
% :- use_module( 'makeauxtables', [ toretarget/1,  stallbuss/1 % Loops back here in the for-predicates etc. %% RS-131224 %% Used in FOR from makeauxtables

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% USAGE
% Run in the /db/ directory...

%%RS-140421
%:- makeauxtables.        %%% Move to busstuc.pl? RS-140927   :- vs ?- ???
%:- verify_consistency.

%% 0.  Take backup (or use svn)
% mv db/auxtables.pl  old/auxtables.pl
% mv db/namehashtable.pl  old/namehashtable.pl
% cp db/discrepancies.pl  old/discrepancies.pl

%%  1. Create Tables 
% busestuc.sav
%?- makeauxtables.

%% 2. Create namehashtable
%?- createhash.

%% 2.5 Create discrepancies
%?- verify_consistency.

%% 3. Finish
%?-halt.

%%  4.  Recompile BusstUC
% busbase.sav
%?-[busstuc]. %% or other
%?-save_program(busestuc).
%?-halt.

