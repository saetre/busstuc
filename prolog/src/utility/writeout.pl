/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE readin.pl
%% SYSTEM TUC
%% CREATED  TA-910531   %% REVISED  TA-110725
%% REVISED  RS-140101 modularized

%%%% OUTPUT     %% RS-140921 To split utility.pl into managable modules

:-module( writeout, [
  %% From BusAnsHP
    bcp/1,      bcw/2,  bcpbc/1,        bigcap/2,
    bw1/1,      bwc/2,  bwq/1,  bwr/1,  bwr2/2,         bwr2bc/1, bwrbc/1, bwrbus/2, bwrbusbc/2,
    bwrstreet/1,        bwrprices/1,    bwstat2/2,  bwt/1,  bwt2/1,         bwtimes2/1,     %% Utility
    colon/0, comma/0,   cwc/2,  dot/0,  busanswer_sat/3,        doubt/2,      getphrase0/2,
    endline/0,  indentprint/2,  languagenr/1,   listall/1,              listrequirements/1,
    nopay/0,    nopay1/0,       outcap/1,       pay/0,  pay1/0,  period/0, period0/0, space/0,
    punkt/0,  question/0,
    space0/0,   startmark/0,      %% From BusAnsHP
    prettyprint/1, roundwrite/1, print_parse_tree/1, printdots/0, %% out/1, MOVED prettypr to sicstus4comp... Avoiding loops in imports.
    sequence_write/1, statistics/1, teleanswer_sat/2, traceprint/2,  %  track/2, trackprog/2, 
    waves/0, writedate/1, writefields/1, writename/1, writeprog/1,       writesimplelist/1, %writepred/1, MOVED to SP4compatibility
    writetelebusteranswer_rep/1, writetelebusteranswer_saf/2, writetelebusteranswer_sqt/3, writetelebusteranswer4/4, writetelebusteranswerfields/1,
    writevaluelist/2, xwriteanswer/2
  ] ). %% RS-141105 Moved to main?: language/1,

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% META_PREDICATES SECTION, %% RS-140927 meta_predicates    : means use source module       + means use this (utility) module  for expansion %% RS-131231 %From utility.pl
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- meta_predicate  busanswer_sat( ?, 0, ? ) . %% RS-141105
:- meta_predicate listall( 0 ) .
:- meta_predicate  teleanswer_sat( +, 0 ) .
:- meta_predicate  xwriteanswer( ?, 0 ) .
:- meta_predicate  writetelebusteranswer1( 0 ) .
:- meta_predicate  writetelebusteranswer_rep( 0 ) .
:- meta_predicate  writetelebusteranswer_saf( ?, 0 ) .

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- use_module( '../declare', [ language/1, track/2, value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .
:- use_module( '../sicstus4compatibility', [ out/1, output/1, prettypr/2, tab/1, writeanswer/1 ] ).  %% Compatible with sicstus4, get0/1 etc.

:- use_module( library(varnumbers), [ numbervars/1 ] ). %% RS-140210.

%% RS-131225, UNIT: /utility/
:- use_module( '../utility/utility', [ append_atomlist/2,
        for/2, internalkonst/1, lastmems/3, nth/3, set_ops/3, split/4, testmember/2 ] ). %% RS-150104
        % follow_sequence/3, once1/1, roundmember/2, occ/2, sequence_member/2,
:- use_module( ptbwrite, [ ptbwrite/1, shrink_tree/2 ] ). %% drucke_baum_list/1, drucke_baum/1,

:- use_module( utility, [ for/2, set_ops/3 ] ). %% drucke_baum_list/1, drucke_baum/1, append_atomlist/2,   TROUBLE RS-141105

%% RS-141026    UNIT: /
%:- use_module( '../main.pl', [ language/1 ] ). %MISERY?!

%%% RS-140914, UNIT: /app/
%:- use_module( '../app/busanshp', [ bcp/1, bcpbc/1, bwrbc/1 ] ). % , colon/0, space/0 
%% RS-131225    UNIT: /app/
:- use_module( '../app/buslog', [ cname/2, islist/1 ] ).

%%% RS-140914, UNIT: /db/
:- use_module( '../db/busdat', [ exbusname/2, moneyunit/1, vehicletype/2 ] ).
:- use_module( '../db/places', [ short_specname/2, specname/2 ] ).
:- use_module( '../db/regstr', [ streetstat/5 ] ). %% RS-150104

%% RS-141026    UNIT: /dialog/
:- use_module( '../dialog/frames2', [ frame_getvalue_rec/4, frame_setvalue_rec/4 ] ). %MISERY?!
:- use_module( '../dialog/newcontext2', [ addref/3, getcurrent/1 ] ). %% RS-131223 INCLUDED IN FRAMES2!!
:- use_module( '../dialog/parseres', [ atomreplace/4, cleanup_name/3, findfieldvalue1/3, convert_tucnf/3, ldap_addrefdialog/2, ldaptotuc/2,
                                       removebackslashes/2, recordfieldvalue/3 ] ). %MISERY?!

%% RS-131225    UNIT: tuc/
:- use_module( '../tuc/facts', [ isa/2 ] ). %% RS-150104  
:- use_module( '../tuc/lex', [ dict_module/1, known_name/1 ] ).  %  TUCs  Lexical Knowledge Base.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%:- meta_predicate  track( +, 0 ) .     %% Moved to declare!  %% RS-150111
%:- meta_predicate  trackprog( +, 0 ) . %% Moved to declare!  %% RS-150111
%:- meta_predicate  traceanswer( 0 ) .
%:- meta_predicate  writeanswer( 0 ) .
%out(P) :- write(P), tab(1). %% Moved to sicstus4compatibility!
%output(P) :- write(P), nl.
%language(L) :- value( language, L ). %% value(language,X) should have been set dynamically by now! In tucbuses
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%MOVED

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

colon    :- write( ': ' ).
comma    :- write( ', ' ).
dot      :- write( '.' ).  %% No Space
endline.                       %% marker, nl
period0  :- write( '.' ).
period   :- write( '.' ),nl.
punkt    :- write( '. ' ). %%  Space
question :- write( '?' ),nl.
space    :- write( ' ' ).
space0.                 %% nothing


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

doubt(A,B) :-
    language( english ) -> out( A );
    language( norsk ) -> out( B );
    out(A).


%% RS-150104 From BusAnsHP
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SECTION    BASIC WRITE %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predikat som skriver ut navn og tall etc.  bwr*


bwrprices([Ad,Ch]):- moneyunit(nok), % both languages
    !,
    bwr(Ad),bcp(or),bwr(Ch),bcp(kroner).

bwrprices([Ad,Ch]):-
    moneyunit(usd), % both languages
    !,
    bwr(Ad),write('$'),bcp(or),bwr(Ch),write('$').

bwrprices([Ad]):- %% Unit Price
    moneyunit(nok), % both languages
    !,
    bwr(Ad),bcp(kroner).

bwrprices([Ad]):-  %% Unit Price
    moneyunit(usd), % both languages
    !,
    bwr(Ad),write('$').

bwrprices(Price):-  bwr(or(Price)).





% Square lists  % a,  b, c and d

bwrsinglelist([Elem1,Elem2|List]) :- %% Max 12 with SMS
     value(smsflag,true),
     length(List,Leng),Leng > 10,
     !,
     bwr(Elem1),comma,
     bwr(Elem2), write(' ,...,'),
     lastmems(2,List,LX),
     bwr(LX).

bwrsinglelist(E):-
    portionlist(E).


bwrsinglelist([Elem]) :-
    !,
    bwr(Elem).

bwrsinglelist([Elem1,Elem2]) :-
    !,
    bwr(Elem1),bcp(and),bwr(Elem2).

bwrsinglelist([Elem|List]) :-
    !,
    portionlist([Elem|List]).

%
% Round lists

bwrsinglelist(Elem) :-
        atomic(Elem),bwr(Elem).


bwrsinglelist((Elem1,Elem2)) :- % Round lists...
        atomic(Elem2),bwr(Elem1),
        %%%  bcp(and), %% (tore,amble) \#-> Tore and Amble
        bwr(Elem2).


bwrsinglelist((Elem,List)) :-
        bwr(Elem),comma,bwrsinglelist(List).

% Square or lists

%% writesimplelist %% TA-110110

writesimplelist([Elem1,Elem2|List]) :-!,
        write(Elem1),out(','),writesimplelist([Elem2|List]).
writesimplelist([Elem1]):-write(Elem1),!,nl.
writesimplelist([]):-!.

writesimplelist(E) :-write(E),nl.

bwrsingleorlist([Elem]) :-
        bwr(Elem).
bwrsingleorlist([Elem1,Elem2]) :-
        bwr(Elem1), bcp(or), %% bcp(and), ØF-990908
        bwr(Elem2).
bwrsingleorlist([Elem|List]) :-
        bwr(Elem),comma,bwrsingleorlist(List).

% Round or lists

bwrsingleorlist(Elem) :-
        atomic(Elem),
        !,
        bwr(Elem).
bwrsingleorlist((Elem1,Elem2)) :- % Round lists...
        atomic(Elem2),bwr(Elem1),  bcp(or), %% bcp(and), ØF-990908
        bwr(Elem2).
bwrsingleorlist((Elem,List)) :-
        bwr(Elem),comma,bwrsingleorlist(List).



bwrbus(_Bus_,One):-
     exbusname(One,Klaburuta),
     !,
     bwr(Klaburuta).

bwrbus(number,One):-
    exbusname(One,Klaburuten),
    !,
    bwr(Klaburuten).

bwrbus(Bus,One):-
    bcp(Bus),
    bwrbusno(One).


bwrbusbc(_Bus_,One):-
     exbusname(One,Klaburuta),
     !,
     bwr(Klaburuta).

bwrbusbc(number,One):-
    bcpbc(number),
    bwrbusno(One).

bwrbusbc(Bus,One):-
    bcpbc(Bus),
    bwrbusno(One).

bwrbusno(One):-
    xbusname0(One,Klaburuta),
    bwr(Klaburuta).

xbusname0(One,Klaburuta):-
    exbusname(One,Klaburuta),
    !.%% -> busdat.pl
xbusname0(One,One).

%% exbusname(254,'Klæburuta'). %% -> busdat.pl




bwr2bc(One):-vehicletype(One,Bus), !,bcpbc(Bus),bcp(One),!.
bwr2bc(One):-bcpbc(One).


% No leading blank


bwrbc(X)     :- xspecname(X,N),!, bigcap(N,NN),  out(NN). %% TA-110103
bwrbc(X)     :- cname(X,N),!,         out(N).
bwrbc(X)     :- streetspecname(X,N),!,out(N).

bwrbc(X)     :- %%  'kofod petersen' -> Kofod Petersen
    atom(X),  %% ** tempe_street-11 %% TA-101102
    splitdoublename(X,Y),
    !,
    out(Y).

bwrbc(X):-bwr(X). %% TA-101102

bwrbc(X)     :- bigcap(X,N),!,    out(N). %% Default




% Øyvind Krøvel-Velle Standal.
% Øyvind Krøvel velle -> Øyvind Krøvel Velle



splitdoublename(X,Y):-
    name(X,List),
    testmember(32,List), %% blank %% short test
    !,
    splatom(List,List2),
    name(Y,List2).


%% New,   List with Class, small caps

bwr2([],Class):- !,bcpbc(notany),bcp(Class).

bwr2([X],buses) :- !, %% Trikk 1 / Buss 2
    busortram(X,BT),bcp(BT),bwr(X).

bwr2(List,departure):- !,bwtimes(List),space.

bwr2(List,_):- bwrsinglelist(List),space.





%% ...................


realspeak_comma:- value(dialog,1),write(', '). %% For better prosody/ pause
realspeak_comma.


/*
splatom(L,L1,L2) :- %% Expensive
     append(U,L2,L),
     append(L1,[32],U).
*/


splatom([K|L],[K1|L1]) :-
    uppercase0(K,K1),
    splat(L,L1).

splat([32,K|L],[32,K1|L1]):-
    K \== 32,
    uppercase0(K,K1),
    splat(L,L1).

splat([32,K|L],[K|L1]):-
    K == 32,
    splat(L,L1).


splat([K|L],[K|L1]):-
    K \== 32,
    !,
    splat(L,L1).

splat(L,L). %% default includes []



uppercase0(K,K1):-
    uppercase(K,K1),
    !.
uppercase0(K,K).

uppercase(K,K1):-
    K >=97,K =< 122,!, K1 is K -32.
uppercase(198,230).
uppercase(248,216).
uppercase(229,197).


%%% bwrstreet(yggdrasil_street-9) ?   -> Yggdrasilvegen 9


bwrstreet(X-N) :- bwr(X),write(N),space,!.
bwrstreet(X)   :- bwr(X).


%% BCP   Basic Common Words


%% bcw: bcpbc = basic common phrase big cap
%% RS-120728

outcap(X):-
    bigcap(X,Y),
    write(' '),
    out(Y).

bcpbc(Con) :-
         (cwc(Con,Phrases);cwcerror(Con,Phrases)),
         languagenr(LN),
         nth(LN,Phrases,Phrase),
         bigcap(Phrase,BCPhrase),
         out(BCPhrase),
    !.   % Write once

bcpbc(_) :-  write(' *** ').

%% RS-120729
%% BCP = Basic Common Phrase. INCLUDES cwc: Common Word Concept

bcp(Con) :-
         ( cwc(Con,Phrases) ; cwcerror(Con,Phrases) ),
         languagenr(LN),
         nth(LN,Phrases,Phrase),
%%%%%    space,  %% Space first  Experiment %% Jeg--har ingen ruter
         write(Phrase),
    space,
         !.   % Write once

bcp(_):- write(' ** ').


%% RS-120728
%% bwc: Basic Word Common? Concept?

% New  List with Class, Big caps

bwc([],Class):- !,bcpbc(notany),bcp(Class).
bwc([X],buses) :- !, %% Trikk 1 / Buss 2
    busortram(X,BT),bcpbc(BT),bwr(X).

bwc(List,buses):- !,portionlist(List),space.

bwc(List,_):- bwrsinglelist(List),space.


bcw(bus,List):-!,portionlist(List),space.
bcw(route,List):-!,portionlist(List),space.
bcw(station,List):-!,portionlist(List),space.

bcw(_,List):- \+ value(smsflag,true),!,portionlist(List),space.
bcw(_,List):- bwrsinglelist(List),space.


%% bwstat2(Intname,Offname) %% TA-110505

bwstat2(X,N)     :- xspecname(X,N),!.
bwstat2(X,N)     :- cname(X,N),!.
bwstat2(X,N)     :- bigcap(X,N),!.



%% bwr    %%


bwr(V):- var(V),!,write('X? '). %% capture loop  error

bwr(_TT_:X):-!,bwr(X). %% TMN

bwr(date(Year,Month,DayNr)) :- %% TA-110519
    writedate(date(Year,Month,DayNr)).

bwr(unknown) :-!,bcp(unknown).


%% Update reference for all relevant items that are printed
bwr(X) :- value(dialog, 1),
          atomic(X),
          X isa Type,
          \+  Type=number, %% uninteresting as reference
          getcurrent(Cid), addref(Cid, X, Type),
          false.  %% it is meant to backtrack

bwr(X)     :- X=STOG-N,streetstat(STOG,_,_,_,_),
              !,
              bwr(STOG),write(N),space, realspeak_comma.

bwr(X-Y)   :- !,  bwr(X),bwr(-),bwr(Y).

bwr([nostation]):-!, bcp(nostation).

bwr(X)     :- internalkonst(X),!,bcp(that),space.
bwr(or(X)) :- !,bwrsingleorlist(X),space.
bwr(X)     :- islist(X),!, %% compound(X),!, %% built-in
              portionlist(X). %%  bwrsinglelist(X).



bwr(X)     :- streetspecname(X,N),!,write(N),space,realspeak_comma.

bwr(X)     :- compound(X),!, write('***'),nl.

% ',' for better Realspeak Prosody


bwr(X)     :- X==so_on,!,getphrase0(X,N),write(N),space. %% Special:  så videre,  lowercase
bwr(X)     :- xspecname(X,N),!,    write(N), space,realspeak_comma. %% Holdeplassnavn
bwr(X)     :- cname(X,N),!,        write(N), space,realspeak_comma.


bwr(X)     :- bigcap(X,N),!,   %%  space,
               write(N),space, realspeak_comma.




bwr(X)     :- %% space,
              write(X).  %% DEFAULT

%%

bwq(X) :- write(X). %% no space


bw1(X-Y) :- value(dialog,1),write(X),bcp(to),space,write(Y). %% RealSpeak

bw1(X)     :- space,write(X),space.  %% NEW Predicate No add ref

%%%

busortram(X,tram):-vehicletype(X,tram),!.
busortram(_,bus).

%% Print times including clock (kl.). %% For pronounciation


bwtimes2([Elem]) :-
        bwt2(Elem).

bwtimes2([Elem1,Elem2]) :-
        bwt2(Elem1),space,bcp(and), bwt2(Elem2).
bwtimes2([Elem|List]) :-
        bwt2(Elem),comma,bwtimes2(List).

bwt2(nil):-write('***'),!. %% Error
bwt2(T):-bcp(attime),bwt(T).



%% Print out Time HHMM

bwtimes([Elem]) :-
        bwt(Elem).
bwtimes([Elem1,Elem2]) :-
        bwt(Elem1),bcp(and),bwt(Elem2).
bwtimes([Elem|List]) :-
        bwt(Elem),comma,bwtimes(List).


bwt(nil):-write('***'),!.

bwt(T) :- \+ number(T),!,write(T).

bwt(T) :-
    T >= 2900,
    !,
    write(T). %% 9999, not 399

bwt(T) :-
     T > 2400,
     !, %% changed from 2359
     NewT is T - 2400,
     bwt(NewT). %  0002 til

bwt(T) :- bwt1(T),space.


bwt00(NN):-  %% write a number with exactly 2 digits
    NN = 0 ->  write('00');
    NN <10 ->  write('0'),write(NN);
               write(NN).


/*

 English:       0000 -> 00:00 am
                1159 -> 11:59 am
                1200 -> 12:00 pm
                1201 -> 12:01 pm
                1259 -> 12:59 pm
                1300 ->  1:00 pm
                2359 -> 11:59 pm
                2400 ->  0:00 am

*/

bwt1(T0) :-
    language(norsk),
    value(dialog,1), %% 14:00 format for speech synthesis
    !,
%%%%%%%%%%%%    space,  kl.  1530 %% TA-101110

   ( T0 > 2400 ->  T is T0 - 2400; T is T0),

     HH is T//100,
     MM is mod(T,100),

%%    bwt00(HH),write(':'), bwt00(MM), realspeak_comma.  %% EH-031015 Bedre syntese.
    bwt00(HH), write('.'), bwt00(MM), realspeak_comma.  %% RS-111025 IKKE! Bedre syntese.

bwt1(T0)     :-
    language(norsk),
%%%%%    space, ,  kl.  1530 %% TA-101110

   ( T0 > 2400 ->  T is T0 - 2400; T is T0),

   ( T <   10 -> write('000'),write(T);
     T <  100 -> write('00'), write(T);
     T < 1000 -> write('0'),  write(T);
                              write(T)
    ).

bwt1(T0)     :-
    language(english),
    space,

  ( T0 >= 2400 ->  T is T0 - 2400; T is T0),

    H is T//100,
    M is mod(T,100),

    Aft is H//12,
    L is mod(H,12),
    (L==0,Aft>0 -> L12=12;L12=L),

    write(L12),
    write(':'),     %% RS-111025 Caused problems for AtB's Web-server script, which strips from colon... Fixed 120401

    (M < 10 ->  write('0');true),
    write(M),
    (Aft >0 -> write(' pm');write(' am')).


%% Portion

portionlist([N]):- !,bwr(N).

portionlist(List):-
    split(5,List,FirstN,Rest),
    Rest = [_,_|_], % at least two more
    !,
    ramses(FirstN),
    nl,
    portionlist(Rest).

portionlist(List):-
    splitlast2(List,Body,[Y,Z]),
    ramses(Body),
    bwr(Y),
    write(', '), %%  bcp(and),
    bwr(Z).

ramses(List):-
   for( member(E,List), (bwr(E),write(', ')) ).



splitlast2(List,Body,[Y,Z]):-
    append(Body,[Y,Z],List).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predikat som skriver ut ord    bcp*

bigcap(In,Out) :-
         atomic(In),            %% SAFEGUARD
    name(In,[SC|R]),
         SC>96,SC<123,     % a-z
         !,
         BC is SC-32,
         name(Out,[BC|R]).

bigcap(In,Out) :-
         atomic(In),            %% SAFEGUARD
         name(In,[SC|R]),
         SC>223,SC<256,    % à-ÿ, some exceptions not covered, i guess
         !,
         BC is SC-32,
         name(Out,[BC|R]).

bigcap(P,P).          % Else, already big or bigcapping do not apply


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mapping fra konsept til ord på hvert språk

%% RS-120728
%% Common Word Concept

cwc(quote(S),[S,S]).

cwc(a,['a','en']).
cwc(about,['about','om']).
cwc(abus,['a bus','en buss']).
cwc(acomputer,['a computer','en datamaskin']).
cwc(after,['after','etter']).
cwc(airbuses,[airbuses,flybusser]).
cwc(and,['and ','og ']).
cwc(adate,['a date','en dato']).
cwc(aday,['a day','en dag']).
cwc(anotherplace,['another place','et sted til']).
cwc(aplace,['a place','et sted']).
cwc(atime,['a time','et tidspunkt']).
cwc(are,['are','er']).
cwc(are_the_same_as,['are the same as on','er de samme som på']).
cwc(aroute,['a route','en rute']).
cwc(arrivesat,['','']):- value(smsflag,true),!.
cwc(arrivesat,['arrives at ','kommer til ']).
cwc(arrival,['arrival', 'ankomst']).
cwc(arrivaltime,['arrival time', 'ankomsttid']).

cwc(andsoon,[',...',',...']). %%  ( Realspeak ?)
%% cwc(andsoon,['and so on','og så videre']).


cwc(as,['as','som']).
cwc(astation,['a station','en holdeplass']).


cwc(assumetomorrow,['I assume you want routes for tomorrow.',    %% TA-110201
                    'Jeg antar du ønsker ruter for i morgen.']). %%


% cwc(assumetomorrow,['I assume you mean routes the day after.',
%                    'Jeg antar du mener ruter for dagen etter.']).


cwc(assumeyesterdepartures,['I assume you mean departures tonight.',
                            'Jeg antar du mener avganger fra ikveld.']).


cwc(atram,['a tram','en trikk']).
cwc(at,['at','ved']).
cwc(atday,['at','på']).
cwc(atstation,['at ','ved ']). %% 'på'  ved mer nøytralt  ( "Hovedterminalen er på Trondheim")

cwc(attime,['at','klokken']):- value(dialog,1),!.
cwc(attime,['at','kl.']).  % otherwise

cwc(athing,['a thing','en ting']). %% hva koster det

cwc(avehicle,['a vehicle','et kjøretøy']).

cwc(before,['before','før']).
cwc(between,['between','mellom']).
cwc(both,['both','både']).
cwc(bus,['bus','buss']).
cwc(buses,['buses','busser']).
cwc(bus_det,['bus','bussen']).      % den siste bussen/the last bus          % Bestemt form
cwc(bus_ana_comes,['it comes','kommer den']). % Buss anaforisert kommer
cwc(busdepartures,['bus departures','bussavganger']).
cwc(busroutes,['bus routes','bussruter']).
cwc(bustuc,['BusTUC','BussTUC']).
cwc(by,['by','ved']).
cwc(bye,['Good bye','Ha det bra']).

cwc(called,['called','som kalles']).
cwc(can,['can','kan']).
cwc(cannot,['can not','kan ikke']).

cwc(change,['route changes','ruteendringer']).


cwc(cannotanswer,['I can not answer that.','Jeg kan ikke svare på det.']).

cwc(cannotanswermyself,['I can not answer that on my own.', %% self judgment
                        'Jeg kan ikke svare på det selv.']).

cwc(cannotanswersuchquestions,['I can not answer such questions.', %% slutte å...
                        'Jeg kan ikke svare på slike spørsmål.']).

cwc(cannotfindanyroutes,['I cannot find any connections ',
                         'Jeg kan ikke finne noen ruteforbindelser']).

cwc(cannotconnectto,['I can not find connections to',
                     'Jeg kan ikke finne noen forbindelse til ']).

cwc(cantake,['may take','kan ta']).

cwc(change,['change','bytte']).
cwc(changeorder,['change','bytt']).

cwc(comes,['comes','kommer']).
cwc(coming,['coming','på vei']).
cwc(company,[company,selskap]).
cwc(completesentence,['Please use a complete sentence',
                       'Vennligst bruk en fullstendig setning']).
cwc(congratulations,['Congratulations!','Gratulerer!']).

cwc(dateof,['of','']).

cwc(day8,['New years eve','nyttårsaften']). %% Ad Hoc for X,mas routes 24.12--31.1
cwc(day9,['New years day','nyttårsdag']).

cwc(delays,[delays,forsinkelser]).
cwc(departure,['departure','avgang']).
cwc(departures,['departures','avganger']).
cwc(departuretime,['departure time','avgangstid']).
cwc(direction,['direction','retning']).
cwc(donotknow,['don''t know','vet ikke']).


%% cwc(drink,['drink','drikk']).

cwc(earliesttimes,[ 'The hours indicate the earliest passing times.',
                    'Tidene angir tidligste passeringer av holdeplassene.']).

cwc(easterday2,['2. Easter day','2. påskedag']).

cwc(eastereve,['Easter eve','påskeaften']).
cwc(easterhol,['Easter holiday','påskehelligdag']).
cwc(each,['each','hvert']).
cwc(end_stations,['the end stations','endestasjonene']).
cwc(entering,['entering','å gå på']).

cwc(error_reports_sent,        %% TA-101206
       ['Error reports will be forwarded to the administrator',
        'Feilrapporter vil bli videresendt administrator']).

cwc(error_restart,['OK, where do you want to go?',
                   'OK, hvor vil du reise ?']).

cwc(every,['every','hver']).

cwc(flybussen,['The Aiport bus','Flybussen']).
cwc(for,['for','for']).
cwc(friday,['Friday','fredag']).
cwc(fridays,['Fridays','fredager']).
cwc(from,['from','fra']).
cwc(first,['first','første']).

/* %% TA-110426
cwc(generalnightbuseaster, %% also pmess !
         ['Nightbus goes night to  Easter Sunday from O.Tryggvasons gt. at  0100,0200 and 300 am.',
          'Nattbuss går natt til 1. påskedag fra O.Tryggvasons gt. kl 0100,0200 og 0300.']).
*/


cwc(godknows,['God knows.','Gud vet.']). %% :-)

cwc(goes,['goes','går']).
cwc(goesfrom, ['goes from','går fra']).
cwc(goesto,  ['goes to','går til']).
cwc(going,['going','å dra']).
cwc(happy_new_year,['Happy New Year','Godt Nyttår']).
cwc(endure,['Endure!','Hold ut!']).
cwc(holiday,['route holiday','rutehelligdag']).
cwc(have,['have','har']).
cwc(has,['has','har']).
cwc(hello,['hello','hallo']).
cwc(hereafter,['after now','etter nå']). %% heretter can mean "after the above"
cwc(hi,['Hi','Hei']).

cwc(i,['I','jeg']).

cwc(iamhere,['I am here','Jeg er her']). %% obnoxious ?

cwc(icannot,['I am sorry I cannot do that','Det kan jeg dessverre ikke']).
%% (but you  can)


cwc(icannotanswer,['I am not able to answer that.',
                  'Jeg kan ikke svare på det.']).

cwc(icannotfind,['I am sorry I cannot answer that.',
                 'Det kan jeg dessverre ikke svare på.']).

cwc(idonotknow,['I don''t know.','Jeg vet ikke.']).

%% cwc(idonotknow,['I am not able to answer that.',
%%                'Jeg kan ikke svare på det.']).

cwc(idonotknowanyplacesnear,['I do not know any places near',
                            'Jeg kjenner ingen steder nær']).
cwc(idonotknowanystationsnear,['I do not know any stops near',
                              'Jeg kjenner ingen holdeplasser nær']).

cwc(idonotunderstand,['I don''t understand that', %%  (  Avoid I want to die ==> OK)
                      'Jeg forstår ikke det']).

cwc(idkwhether,['I don''t know whether',
                'Jeg vet ikke om']).

cwc(isillegal,['is invalid.',
               'er ugyldig.']).

cwc(illegaldate,['This  date is invalid.',
                 'Den datoen er ugyldig.']).

cwc(unknownfield,['uknknown field',
                  'ukjent felt']).

cwc(unknowndate,['This  date is unknown.',
                 'Den datoen er ukjent.']).

cwc(in,['in','i']).

cwc(inconsistenttimes, ['This  time interval is not possible.',
                        'Dette tidsintervallet er ikke mulig.']).

cwc(inconsistentduration, ['This duration  is too large.',
                           'Jeg kan ikke svare for så store tidsintervaller.']).

cwc(indirection,['in direction','i retning']):-
    value(smsflag,true),!.

cwc(indirection,['in direction','i retning']).


cwc(indirectiontowards,['towards',  'mot']):-
    value(smsflag,true),
    !.

cwc(indirectiontowards,['in direction towards',  'i retning mot']).


cwc(indirectionfrom,['from', '  fra']):-
   value(smsflag,true),
   !.

cwc(indirectionfrom,['in direction from',
                        ' i retning fra']).

cwc(instead,['instead','istedenfor']).

cwc(inthisperiod,['in this route period','i denne ruteperioden']).
                                                %% dont mix with time period
cwc(invitemore,['If you want more information, you may ask now, or end the conversation.',
                'Ønsker du flere opplysninger kan du spørre nå, eller avslutte samtalen.']).


cwc(irregularity,['changes in schedules',
                  'ruteendringer']).
cwc(irrelevant,['irrelevant','irrelevant']).
cwc(is,['is','er']).
cwc(isa,['is a ','er en ']).

cwc(ismanyvalued,['is not unique','er flertydig']).
cwc(it,['it','det']).


cwc(knownostations,
     ['I have no information about its neighbour stations',
     'Jeg vet ikke om noen stasjoner i nærheten']).
cwc(kroner,['NOK','kr']).

cwc(last,['last','siste']).
cwc(later,['later','senere']).
cwc(leaves,['leaves',forlater]).
cwc(leaving,['leaving','å gå av']).
cwc(length,[lengths,lengder]). %% nb plu
cwc(luggage,['luggage or lost property',
             'bagasje eller hittegods']).

cwc(mayor,[mayor,burgermester]). %% :-)
cwc(map,[map,kart]).
cwc(merry_christmas,['Merry Christmas','God jul']).
cwc(meta,[text,tekst]). %% Technical
cwc(minute,['minute','minutt']).

cwc(minutes,['min.','min.']):-
    value(smsflag,true),
 \+ value(dialog,1),!.  %% Talsmann
cwc(minutes,['minutes','minutter']).

/*
cwc(misfjordeaster,
     ['Nightbus goes night to  Easter Sunday from O.Tryggvasons gt. at  0100,0200 and 0300  am.',
      'Nattbuss går natt til 1. påskedag fra O.Tryggvasons gt. kl 0100,0200 og 0300. ']).


cwc(misfjordxmas, ['Nightbus goes from O.Tryggvasons gt.: 0100, 0200 and 0300 am.',
  'Nattbussen har følgende avganger 27.12 fra O.Tryggvasons gt.: 0100, 0200 og  0300. ']).


cwc(misfjordmessage, ['Nightbus goes from O.Tryggvasons gt.: 0100, 0200 and   0300 am.',
  'Nattbussen har følgende avganger 27.12 fra O.Tryggvasons gt.: 0100, 0200 og 300.']).

*/


cwc(monday,['Monday','mandag']).
cwc(mondays,['Mondays','mandager']).

cwc(more,[more,flere]).

cwc(must,['must','må']).

cwc(may17,['Constitutional Day','Nasjonaldag']). %% TA-110518   %% RS-120503

cwc(mustknowfood,['You must specify food in such questions',
                  'Du må spesifisere mat i slike spørsmål']).

cwc(near,['near','nær']).

cwc(never,['never','aldri']).
cwc(neverpasses,['never passes ','passerer aldri ']).
cwc(next,['next','neste']).

%% * nattbussen 106 ??
% busfare2(nightbus,[100-150-200]). % By,Nes - Klæbu,Melhus,Malvik,Skaun - Stjørdal,Orkdal
 cwc(nightbus,['Nightbus(City - Klæbu,Melhus,Malvik,Skaun - Stjørdal,Orkdal)', 'Nattbuss(By/nes - Klæbu,Melhus,Malvik,Skaun - Stjørdal,Orkdal)']).
%cwc(nightbus_far,['Nightbus(Town/Byneset/Klæbu)', 'Nattbuss(By-Byneset-Klæbu)']).   %% * nattbussen 106
 cwc(nightbus_far,['Nightbus(Stjørdal,Orkdal)', 'Nattbuss(Stjørdal,Orkdal)']).   %% * nattbussen 106
%cwc(nightbus_klæbu,['Nightbus(Klæbu)', 'Nattbuss (Byen)']).   %% * nattbussen 106
 cwc(nightbus_klæbu,['Nightbus(Klæbu,Melhus,Malvik,Skaun)', 'Nattbuss (Klæbu,Melhus,Malvik,Skaun)']).   %% * nattbussen 106
cwc(nightbus_byneset,['Nightbus(Byneset)', 'Nattbuss (Byneset)']).   %% * nattbussen 106
cwc(nighttram,['Night-tram', 'Natt-trikk ']).   %% * nattrikk 1  %% RS-141115

cwc(nightbus0,['night bus', 'nattbuss']). %% -> the nightbus
%cwc(nighttram0,['night tram', 'natt-trikk']). %% -> the nightbus

cwc(new_years_eve,['New years eve','nyttårsaften']).
cwc(new_years_day,['New years day','nyttårsdag']).

cwc(nofoodonbus,
     ['It is not allowed to  eat sausages, chips,  icecream  etc on the bus.',  %% :-)
      'Det er ikke tillatt å spise pølser, chips, is  o.l. ombord i bussen.']).

%  cwc(nofoodonbus, %% plakat i bussen
%    ['Please don''t eat sausages, chips,  icecream etc on the bus.',
%     'Vennligst ikke spis pølser, is, chips o.l. ombord i bussen.']).

cwc(nodrinkonbus,
    ['It is not allowed to drink alcoholic beverages in the bus.',
     'Det er ikke tillatt å nyte alkoholholdige drikker på bussen.']).


cwc(noneedtoanswer,['I don''t need to answer that.',
                    'Jeg trenger ikke å svare på det.']).

cwc(nosenseofhumour,   %% TA-110125
     ['I have no sense of humour.',
      'Jeg har ingen sans for humor.']).

cwc(nosmokeonbus,
    ['It is not allowed to smoke in the bus.',
     'Røyking er forbudt i bussene.']).

cwc(nonightbus,['I have no routes for the nightbus',
                'Jeg har for tiden ingen ruter for nattbussen']).


cwc(nopassages,['There are none passing then.','Det er ingen som passererer da.']).

cwc(noroutesforthisdate,['I have no routes for this date.', %% RS-140616  yet? Maybe long, long time ago...
                         'Jeg har ingen ruter for denne datoen.']). %%  enda? Kanskje fortid?

cwc(notthestation, ['This route does not pass the station.',
                    'Denne ruten passerer ikke stasjonen.']).

cwc(no,['No.','Nei.']).

cwc(nocorresponse,['I cannot answer the request for correspondance',
                   'Jeg kan ikke besvare forespørsel om korrespondering']).

cwc(nodatesX,[ 'Route data for this date is not available yet',
               'Rutedata for denne dato er ikke tilgjengelig ennå']).

cwc(nodirectroutes,['There are no direct routes ', 'Det er ingen direkteruter']).




cwc(nonightbusdepartures,['No nightbus on this date in holidays',
                'Det er ingen nattbusser på denne dato i helgen.']).
                   %%       'Det er ingen nattbusser på denne dato i helgen. (Bare natt til 27.12)']).


cwc(nightbusdepartures,['The nightbus has the following departures from the center on the night to ',
                        'Nattbussen har følgende avganger fra O.Tryggvasons gt. natt til ']).


cwc(nightbusdeparturesshort,['The nightbus has the following departures from O.Tryggvasons gt.',
                        'Nattbussen har følgende avganger fra O.Tryggvasons gt.']).


cwc(nobodyisperfect,['Nobody is perfect','Ingen er feilfri']).
cwc(noinformation,
     ['I have no information about',
      'Jeg har ingen informasjon om']).

%% cwc(nolonger,['There are no more','Det er ingen flere']).

cwc(nolonger,['I cannot find any more connections',
              'Jeg kan ikke finne flere ruteforbindelser']). %% .. på tirsdag.

cwc(nolongerperiod,['I cannot find any more connections',
                    'Jeg kan ikke finne flere ruteforbindelser']). %% .


cwc(nomark,['No,','Nei,']).
cwc(nomoreon,['There are no more on ', 'Det er ingen flere på ']).
cwc(none,['none','ingen']).

cwc(nonightbusesthen,
         ['There are no nightbuses.',
          'Det er ingen nattbusser.']).



cwc(noplaces,['No known stations','Ingen kjente stasjoner']).
cwc(normally,['normally','vanligvis']).

cwc(noroutes,['I cannot find any connections','Jeg finner ingen ruteforbindelser']).

cwc(nostation,['No bus stations','Ingen busstasjoner']).
cwc(not,[not,ikke]).

%% cwc(notpossible,['not possible','umulig']). % ?

cwc(thatisagoodquestion,['That was a good question.', %%  :-)
                         'Det var et godt spørsmål.']). %% det er et g.s.  :-)


cwc(thatisnotgood,['That is not good',
                   'Det er ikke bra']).
cwc(notpossible,['That is not possible',
                   'Det er ikke mulig']).

cwc(notpossibleon,['That is not possible on',
                   'Det er ikke mulig på']).

cwc(notany,['no','ingen']).
cwc(now,['now','nå']).
cwc(nowhere,['nowhere','ingen steder']).
cwc(nth(N),[Ord,Ord]) :- ordinal2(Ord,_,N).

cwc(number,['number','nr.']):- value(smsflag,true),!. %% // avoid No.
cwc(number,['number','nummer']).

cwc(of,['of','i']).
cwc(ofa,['of a','til en']).
cwc(ofabus,['of a vehicle','til et kjøretøy']). %%  (tram ?)
cwc(ofmonth,['a month','i måneden']).
cwc(ofatrip,['of a trip','på en tur']).
cwc(ok,['OK','OK']).
cwc(on,['on','på']).
cwc(ondate,[' on ',' den ']).
cwc(once,[once,'en gang']).
cwc(only,['only','bare']).

cwc(onlyonedestination,
    ['I can only answer for one destination at a time.',
     'Jeg kan bare svare for ett reisemål av gangen.']).

cwc(onlyonebus,['I can only answer for one  bus at a time.',
                'Jeg kan bare svare for en buss av gangen.']).  %% ad?

cwc(onlyoneday,['I can only answer for one day at a time.',
                'Jeg kan bare svare for  en dag av gangen. ']). %% ad? %% TA-110111

cwc(onlyoneplace,['I can only answer for one place at a time.',
                  'Jeg kan bare svare for ett sted av gangen.']). %% ad?


cwc(onlyonething,['I can only answer one thing at a time.',
                  'Jeg kan bare svare på en ting av gangen.']). %% ad?

cwc(onlyonesentence,['I can only answer one sentence at a time.',
                     'Jeg kan bare svare på en setning av gangen.']). %% ad?

cwc(onthecontrary,['No, on the contrary.', 'Nei, tvertimot.']). %%  :-)


cwc(onthisday,['on this day','på denne dagen']).

cwc(picture,[picture,bilde]).

cwc(put,[placement,plassering]). %% T-100308 the verb as action

cwc(or,['or','eller']).

cwc(otherbus, ['other route company. ',
               'andre ruteselskap enn AtB ']).
cwc(passes,['passes by ','passerer ']).
cwc(passing,['passing','passerer']).
cwc(past,[past,forbi]).           %% not past time
cwc(phonehelp,['Bustuc has phone number  73511348.','Busstuc har telefon 73511348.']).
cwc(ping,[ping,ping]).            %%  :-)
cwc(pong,[pong,pong]).            %%  :-)
cwc(possalternatives,
    ['Possible alternatives are:', 'Mulige alternativer er:']).
cwc(place,['place','sted']).
cwc(precize,['Please use a more specific name.',
             'Vennligst bruk et mer presist navn.']).

cwc(probably,['probably','sannsynligvis']).
cwc(questions,['questions','spørsmål']).
cwc(routes,['routes','ruter']).

cwc(ruteopplysningen,['Route Information','Ruteopplysningen']).
cwc(saturday,['Saturday','lørdag']).
cwc(saturdays,['Saturdays','lørdager']).

cwc(say,['say','si']).
cwc(self,[self,selv]).

cwc(size,[size,størrelse]).
cwc(smshelp,['Prefix question with RUTE , and send to 2027.', %% TA-100924
             'Begynn meldingen med RUTE , og send til 2027.']).

cwc(so_on,['...','...']).
%% cwc(so_on,['so on','så videre']).



cwc(sorrycannot,['I''m afraid I can''t do that.', %% HAL :-)
                 'Jeg kan dessverre ikke gjøre det.']). %%   //Actions

cwc(sorryno, ['Unfortunately, I can not show you any',
              'Jeg kan dessverre ikke vise noe']).

cwc(sorrynot,['No, I don''t. ',   %%  Non action (kjenne/like)
              'Nei, desverre']).


cwc(sorrydont,['No, I don''t. ',   %%  Non action (kjenne/like)
               'Jeg  gjør dessverre ikke det.']).

cwc(spacename,[spacename, 'navn på område' ]). %% utgang/toalett/ etc

cwc(special_ticket,['special tickets','spesielle billetter']).

cwc(specificdays,['routes on this date',
                  'ruter på denne datoen']).
cwc(specify,['specify','oppgi']).


%% except Easter holiday
cwc(standnight,['The Nightbus goes only  night to Saturdays and  Sundays.',
                'Nattbussen går  bare natt til lørdag og søndag. ']).
                                              %% unntatt i påskehelgen

cwc(station,['station','holdeplass']).
cwc(stations,['stations','holdeplasser']).

cwc(strikeison,['The bus drivers are now on strike',
                'Bussjåførene er for tiden i streik']). %%

cwc(submarines,['submarines','ubåter']).
cwc(such,['such','slike']).


cwc(sunday,['Sunday','søndag']).
cwc(sundays,['Sundays','søndager']).
cwc(swim,['swim','svømme']).

cwc(takes,['takes','tar']).
cwc(tao,[unkown,ukjent]).

cwc(team,['Team traffic','Team trafikk']).

cwc(tell,['tell','fortelle']).
cwc(thanks,['Thanks.','Takk.']).
cwc(that,['that','det']).
cwc(thatisimpossible,['That is not possible.','Det er ikke mulig.']).
cwc(thatisunclear,['That is unclear.','Det er uklart.']).
cwc(thatmeans,['that means','det betyr at']).
cwc(the,['the','den']).
cwc(thereafter,[thereafter,'like etterpå']).
cwc(therearenodeparturesfor,['There are no departures for','Det er ingen avganger for']).
cwc(thebus,['the bus','bussen']).
cwc(thebuses,['the buses','bussene']).
cwc(the_routes_on,['The routes on ','Rutene ']).

cwc(theneareststationto,['The station nearest to',
                         'Holdeplassen nærmest']).

cwc(thenightbus,['the nightbus','nattbussen']).
cwc(thenightbuses,['the nightbuses','nattbussene']).
cwc(thecolour,['the colour','fargen']).
cwc(thedate,['the date','datoen']).
cwc(thefirst,['the first','første']).
cwc(thelast,['the last','siste']).
cwc(thenext,['the next','neste']).
cwc(theprice,['the price','prisen']).
cwc(therearenone,['there are no departures','det er ingen avganger']).
cwc(thesame,['the same','samme']).
cwc(thespeed,['the speed','hastigheten']).
cwc(there,['there','det']).
cwc(thestation,['the station','holdeplassen']).
cwc(thestations,['the stations ','holdeplassene ']).
cwc(theweather,['the weather','været']).
cwc(theplace,['The place','Stedet']).
cwc(thetime,['the time','klokka']).
cwc(this,['this','dette']).
cwc(thisdate,['this date','denne dato']).
cwc(thursday,['Thursday','torsdag']).
cwc(thursdays,['Thursdays','torsdager']).
cwc(timeout,['I could not find any connections in time',
             'Jeg klarte ikke å finne noen forbindelser i tide']).

cwc(to,['to','til']).
cwc(todayis,['Todays day: ','Dagen idag: ']).

cwc(toolate,['Time of notification has already passed.',
             'Tidspunkt for varsling er allerede passert.']).

cwc(toomanyplaces,['I can not handle so many places at a time !',
                   'Jeg kan ikke svare for så mange steder av gangen !']).

cwc(tram,['tram','trikk']).
cwc(trams,['trams','trikker']).
cwc(tramstation,['tramstation',trikkestasjon]).
cwc(try,['try','prøv']).
cwc(tuesday,['Tuesday','tirsdag']).
cwc(tuesdays,['Tuesdays','tirsdager']).
cwc(unknown,['unknown','ukjent']).
cwc(user,[user,bruker]).
cwc(bag,[bag,veske]).
cwc(via,[via,via]).
cwc(yes,['Yes.','Ja.']).
cwc(yesmark,['Yes,','Ja,']).
cwc(you,['you','du']).
cwc(you_acc,['you','deg']).
cwc(you_are_welcome,['You are welcome.','Vær så god.']).
cwc(youarenotified,['Notification at','Varsel kl']).
cwc(youknow,['you know','vet du']).

cwc(waddyathink,['I suppose so','Jeg antar det']).
cwc(walking_distance,['walking distance','gangavstand']).
cwc(wednesday,['Wednesday','onsdag']).
cwc(wednesdays,['Wednesdays','onsdager']).
cwc(when,['when','når']).
cwc(why,['Why  ?','Hvorfor ?']).
cwc(whynot,['Why not ?','Hvorfor ikke ?']).
cwc(with,['with','med']).
cwc(withthat,['with this','med denne']).
cwc(wonderful,['Wonderful','Flott']).
cwc(work,[work,arbeide]).  %% verb/noun?
cwc(would,['would','ville']).

%% ? for Talsmann Prosody

% EH-031015 RealSpeak tilpasninger er gjort nedenfor: "ønsker du" --> "vil du ha"

% cwc(askfor(when),['When do you wish to travel ?', 'Når ønsker du å dra ?']).  %%  Talsmann ...
cwc(askfor(when),['When do you wish to travel ?', 'Når vil du dra?']).          %% EH-031014 RealSpeak...
cwc(askfor((when)::departure),['What time of departure do you wish ?', 'Når vil du ha avgang?']).               %% EH-031014 RealSpeak...
cwc(askfor((when)::arrival),['When do you wish to arrive ?', 'Når vil du ankomme ?']).
cwc(askfor((when)::day),['Which day do you want to travel ?', 'Hvilken dag vil du dra ?']).
cwc(askfor(where::direction), ['In what direction do you wish to travel ?',
                               'I hvilken retning vil du dra ?']).

cwc(askfor(bus),['What bus do you want to take ?',
             'Hvilken buss vil du bruke ?']).


cwc(askfor(where),['Where do you want to travel ?',
             'Hvor vil du reise ?']).
cwc(askfor(where::arrival),['Where do you want to go to ?',
             'Hvor vil du reise til ?']).
cwc(askfor(where::departure),['Where do you want to travel from ?',
             'Hvor vil du reise fra ?']).

/* %% EH-030115

cwc(askfor(when),['When do you wish to travel ?', 'Når ønsker du å dra ?']).
cwc(askfor((when)::departure),['What time of departure do you wish ?', 'Når ønsker du avgangstid ?']).
cwc(askfor((when)::arrival),['When do you wish to arrive ?', 'Når ønsker du å ankomme ?']).
cwc(askfor((when)::day),['Which day do you want to travel ?', 'Hvilken dag ønsker du å dra ?']).
cwc(askfor(where::direction), ['In what direction do you wish to travel ?',
                               'I hvilken retning ønsker du å dra ?']).

cwc(askfor(bus),['What bus do you want to take ?',
             'Hvilken buss ønsker du å bruke ?']).


cwc(askfor(where),['Where do you want to travel ?',
             'Hvor ønsker du å reise ?']).
cwc(askfor(where::arrival),['Where do you want to go to ?',
             'Hvor ønsker du å reise til ?']).
cwc(askfor(where::departure),['Where do you want to travel from ?',
             'Hvor ønsker du å reise fra ?']).
*/



%% START TELEBUSTER

cwc(norecordsfound, ['Could not find any matching records','Kan ikke finne noen som svarer til søket']).




cwc(tellnumber(No), L) :-
        cwc(numrecords(No),L),
   nl.

cwc(numrecords(10000), ['cannot find that number', 'kan ikke finne det antallet']):-!.
cwc(numrecords(Count),[Eng, Nor]) :-
        append_atomlist(['there are ', Count, ' records that matches the query'],Eng),
        append_atomlist(['jeg finner ', Count, ' poster som svarer til søket'],Nor).

cwc(tomanytolist, ['Cannot list so many records', 'Kan ikke liste så mange poster']).

cwc(telebuster,['Telebuster', 'Telebuster']).


%% Fieldnames:
cwc(field(attributes::Slot),L) :- cwc(field(Slot),L).



cwc(cn,['name','navn']).
cwc(sn,['family name','etternavn']).
cwc(givenname,['first name','fornavn']).
cwc(telephonenumber,['telephone number', 'telefonnummer']).
cwc(ou,['department','avdeling']).
cwc(mail,['e-mail', 'e-post']).
cwc(mailaddress,['e-mail', 'e-post']). %% NEC ???
cwc(title,['title', 'tittel']).
cwc(roomnumber,['room number','romnummer']).
cwc(street,['street','gate']).      %%  (-> streetaddress)
cwc(streetaddress,['street address','gateadresse']). %%
cwc(count,['number of posts','antall poster']).
cwc(unknown,['unknown field','ukjent felt']).


cwc(field(cn),['name','navn']).
cwc(field(sn),['family name','etternavn']).
cwc(field(givenname),['first name','fornavn']).
cwc(field(telephonenumber),['telephone number', 'telefonnummer']).
cwc(field(ou),['department','avdeling']).
cwc(field(mail),['e-mail', 'e-post']).
cwc(field(mailaddress),['e-mail', 'e-post']). %%  NEC ???
cwc(field(title),['title', 'tittel']).
cwc(field(roomnumber),['room number','romnummer']).
cwc(field(street),['street address','gateadresse']).
cwc(field(count),['number of posts','antall poster']).
cwc(field(unknown),['unknown field','ukjent felt']).




cwc(unknownfield,['I don\'t have the answer to that question','Jeg har ikke svaret på det spørsmålet']).

% alternative fieldnames
cwc(field(pname),L) :- cwc(field(cn),L).
cwc(field(lastname),L) :- cwc(field(sn),L).
cwc(field(firstname),L) :- cwc(field(givenname),L).
cwc(field(department),L) :- cwc(field(ou),L).
cwc(field(telephone),L) :- cwc(field(telephonenumber),L).





%% the  (attribute in determined form)

cwc(the(attributes::Slot),L) :- cwc(the(Slot),L),!.


cwc(the(spacename),['the space name','navnet på stedet']). %% toalettet

cwc(the(cn),['the name','navnet']).
cwc(the(sn),['the family name','etternavnet']).
cwc(the(givenname),['the first name','fornavnet']).
cwc(the(telephonenumber),['the telephone number', 'telefonnummeret']).
cwc(the(ou),['the department','avdelingen']).
cwc(the(mail),['the e-mail', 'e-postadressen']).
cwc(the(title),['the title', 'tittelen']).
cwc(the(roomnumber),['the room number','romnummeret']).
cwc(the(street),['the street address','gateadressen']).
cwc(the(unknown),['the unknown field','det ukjente feltet']).

cwc(the(pname),L) :- cwc(the(cn),L).
cwc(the(lastname),L) :- cwc(the(sn),L).
cwc(the(firstname),L) :- cwc(the(givenname),L).
cwc(the(department),L):-cwc(the(ou),L).
cwc(the(telephone),L) :- cwc(the(telephonenumber),L).


cwc(then,[then,da]).

cwc(doyouknow,['do you know','vet du']).
cwc(please_state,['please state','vennligst oppgi']).

cwc(searchingfor(Field),[Eng, Nor]) :-
        cwc(the(Field),[EngTheField, NorTheField]),
        append_atomlist(['searching for ', EngTheField,' of the person with: '],Eng),
        append_atomlist(['leter etter ', NorTheField, ' til personen med:  '], Nor).



cwc(cantfind, ['can\'t find anyone with','finner ingen med']).
cwc(butitis, ['but there is','men det er']).
cwc(matchingrecords, ['records that matches','poster som svarer til']).
cwc(ison, ['is on', 'er på']).

%% END TELEBUSTER


cwc(dialogerror,['I don\'t understand',
             'Jeg skjønner ikke']).

cwc(which,['Which', 'Hvilken']).

cwc(tbs_welcomegreeting, ['Welcome to the Tabor-project bus route information.',
                          'Velkommen til Tabor-prosjektets ruteopplysning.']).
cwc(tbs_welcomequestion,['Do you know how the system works?','Vet du hvordan systemet virker?']).
cwc(tbs_userhelp, ['Please try to express yourself in simple sentences',
                   'Forsøk å uttrykk deg så enkelt som mulig']).
cwc(tbs_whentotravel, ['Please state a time.', 'Vennligst angi tidspunkt.']).
cwc(tbs_deporarr, ['do you wish depature or arrival at', 'ønsker du avgang eller ankomst kl']).

cwc(tbs_askref_from, ['do you wish to travel from', 'ønsker du å dra fra']).
cwc(tbs_askref_to, ['do you wish to arrive at', 'ønsker du å ankomme']).
cwc(tbs_askref_day, ['do you wish to travel on', 'ønsker du å dra på']).
cwc(tbs_asknewtime, ['do you wish to state a new time', 'ønsker du å oppgi et nytt tidspunkt?']).
cwc(tbs_asknewbusconnection, ['Do you wish more information about a new bus connections?',
                               'ønsker du opplysninger om en ny bussforbindelse?']).
cwc(tbs_endmsg, ['can I help you with something else?', 'kan jeg hjelpe deg med noe annet?']).
cwc(tbs_whichday, ['Which day do you wish to travel?', 'Hvilken dag ønsker du å reise?']).
cwc(tbs_wishtime, ['Do you want timeinformation?', 'Ønsker du opplysninger om tiden?']).
cwc(tbs_askref_day, ['Do you wish to travel on', 'Ønsker du å dra på']).
cwc(tbs_fromwhere, ['where do you wish to travel from?', 'hvor ønsker du å dra fra?']).
cwc(tbs_towhere, ['where do you wish to travel to?', 'hvor ønsker du å dra til?']).


%% Last after explicit defs

cwc(G,[G,N]):-
    dict_n:noun2(N,G).

cwc(G,[G,N]):-
    dict_n:noun3(N,G,_). %% hjul



cwc(N,[N,N]) :- number(N).
cwc(M,[N,N]) :- known_name(M), specname(M,N).       %% lex.pl



% Skriver feilmelding dersom mapping mangler
cwcerror(Con,[Con,'???']) :-
    !.

% % % % % % % % % % % %

getphrase0(C,Phrase):-
   cwc(C,List),
   languagenr(LN),
   nth(LN,List,Phrase).


languagenr(1) :- language(english).
languagenr(2) :- language(norsk).



monthshort(1, 'Jan.', 'Jan.').
monthshort(2, 'Feb.', 'Feb.').
monthshort(3, 'Mar.', 'Mar.').
monthshort(4, 'Apr.', 'Apr.').
monthshort(5, 'May.', 'Mai'). %% TA-110202 not short
monthshort(6, 'Jun.', 'Jun.').
monthshort(7, 'Jul.', 'Jul.').
monthshort(8, 'Aug.', 'Aug.').
monthshort(9, 'Sep.', 'Sep.').
monthshort(10,'Oct.', 'Okt.').
monthshort(11,'Nov.', 'Nov.').
monthshort(12,'Dec.', 'Des.').



ordinal2( X, Y, Z ) :-
        dict_module( dict_n ),
        dict_n:ordinal2( X, Y, Z ) .    %% RS-141026 true to Remove warnings because of Dict-modules not visible

ordinal2( X, Y, Z ) :-
        dict_module( D ),
        D:ordinal2( X, Y, Z ) .    %% RS-141026 true to Remove warnings because of Dict-modules not visible




%% Important:  Empty output gives a strange warning message

pay1   :-  write('+ '),nl.
nopay1 :-  write('- '),nl.

pay :-  value(smsflag,true),
      \+ value(dialog,1),
      \+ value(warningflag,true),
      !,
      write('+ '),nl.

pay :-  value(smsflag,true),
      \+ value(dialog,1),
      value(warningflag,true),
      \+ value(warningtime,_),
      !,
      write('- '),nl. %% warning but no time

pay.

nopay :- value(smsflag,true),
%%%%% \+ value(warningflag,true), %% always
      \+ value(dialog,1),
         !,
         write('- '),nl.

nopay.


startmark :- value(smsflag,true),
             \+ value(dialog,1),
             !.

startmark :- nl.


streetspecname(X,N) :- regstr:streetstat(X,N,_,_,_),!.  %% NB NOT FIRST ORDER NORMAL FORM
%%
%% RS-150104 Extra predicates from BusAnsHP
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%numbervars(F) :-
%    numbervars( F, 0, _ ).

prettyprint( P ) :-
    numbervars( P ),
    writeq( P ),nl,
    false; % release bindings
    true.

print_parse_tree(Parse1):- %% TA-110207
   value(norsource,true),
   !,
   shrink_tree(Parse1,Pa1),

   output('<tree> '),   prettyprint(Pa1),  output('</tree>'),nl.

   
print_parse_tree(Parse1):- %% TA-110207
   track(4, printparse(Parse1) ), %%  print proper parsetree
   track(2, output('*** Simplified parse tree ***') ),
   track(1, ptbwrite:ptbwrite(Parse1) ), %% -> ptbwrite.pl
   track(2, (output('*****************************'),nl) ).

printparse(X) :- 
    write('*** Parse Tree ***'),nl,nl,
    indentprint(0,X),nl,
    write('******************'),nl,nl.

indentprint(N,Y):-
     var(Y),
     !,
     tab(N),write(Y),nl.
    
indentprint(N,[H|T]):-
    !,
    tab(N),write(H),nl,
    M is N+2, 
    for( member(X,T), indentprint(M,X) ).

indentprint(N,Y):-
     tab(N),write(Y),nl.


%listall(Frame) :-
%
%   frame_getvalue_rec(Frame, return, [Field|Rest], _),!,
%       frame_getvalue_rec(Frame, itemsfound::items, Recs, _),
%
%   for(member(Rec,Recs),                %% TA-060614
%       tahasattval(Rec, [Field|Rest])). %% Speakable
%%%     listfields(Recs, [cn,Field]).
%
%listall(Frame) :-
%       frame_getvalue_rec(Frame, itemsfound::items, Recs, _),
%
%   for(member(Rec,Recs),
%       tahasattval(Rec, [department,telephone])). %% Speakable
%
%%%     listfields(Recs, [cn,department,telephone]).
%
%
%
%%%%%   listfields(Recs, [cn,title,telephonenumber,mail,ou,roomnumber,street]).

listrequirements( Frame ) :-
        set_ops( Field=Val, frame_getvalue_rec( Frame, attributes::Field,Val,_), List ),

        listrequirements2(List).



listrequirements2([_Field=dontknow|Rest]) :-
        listrequirements2(Rest).

listrequirements2([_Field=doknow|Rest]) :-
        listrequirements2(Rest).

listrequirements2([Field=Value|Rest]) :-
    value(traceprog,N), N >=2,
    !,
    listreq2([Field=Value|Rest]).

listrequirements2(_). 


listreq2([Field=Value|Rest]) :-
   !,
        bcpbc( field(Field) ), colon, write(Value),nl,
        listreq2(Rest).

listreq2([]).

%%%%%%%%%%%%%%%%%%%%%%%%


printdots :-  %% TA-110204
    dotline(DOTS),
    traceprint(1,DOTS).

dotline(''):-value(smsflag,true),!.
dotline('........................................................................').
   


roundwrite( nil ) :-!. %% catches var
roundwrite( (X,Y) ) :-!, out(X),roundwrite(Y).
roundwrite( X ) :- !, out(X).

sequence_write(X) :- roundwrite(X). %% New name, more standard

statistics(G) :- 
               statistics(G,K),
               output(K).

traceprint(N,P):- %% same as trace
    value(trace,M), number(M), M >= N, 
    !,
    write(P),nl
;
    true.

%///


%% sant

writeprog(P) :-
         value(traceprog,L),
         L>1,
         !,
    copy_term(P,Pwr),
         numbervars(Pwr),
         nl,  
    prettypr('Application program',Pwr), 
    nl, 
    !.

writeprog(_). % Otherwise

%% ¤¤¤¤¤¤¤¤¤¤¤¤




writefieldvalues(_Rec, []) :- !,nl. %% 0 

writefieldvalues([record(Rec)],List) :-  %% TA-060324   
    !,
    writefieldvalues(Rec,List).

writefieldvalues(Rec,List) :-       %% >0 
    writefieldvalues2(Rec,List),
    !,  
    write('.').


%% writefieldvalues2   

writefieldvalues2(_Rec, []) :- !,nl. %% 0

writefieldvalues2(Rec,[R]) :-  %% 1
    !,
    writefieldvalue2(Rec, R). 

writefieldvalues2(Rec,[R,S]) :-  %% 2
    !,
    writefieldvalue2(Rec, R),
    !, 
    bcp(and),
    writefieldvalue2(Rec, S).

writefieldvalues2(Rec,[R,S|T]) :-  %% > 2
    writefieldvalue2(Rec, R),
    !, 
    write(', '),
    writefieldvalues2(Rec,[S|T]).


%% writefieldvalue2

writefieldvalue2([record(R)],L):- 
    !,
    writefieldvalue2(R,L).

writefieldvalue2(record(R),L):- 
    !,
    writefieldvalue2(R,L).

writefieldvalue2(Rec, R):- 
   writefieldvalue1(Rec, R).


%% dialog/parseres ???

writefields(F):- var(F),!,write('¤ variable ¤').


writefields([F]):-   % telf
   !,
   writefield1(F).

writefields([F,G]):-  % telf og email
   !,
   writefield1(F),
   bcp(and),write(' '),
   writefield1(G).

writefields([F,G|H]):- % telf, email and room
   writefield1(F),
   !,
   write(', '),
   writefields([G|H]).

writefields([]):-!.

writefields(_):- write(' ??? '). %% catchall

writefield1(unknown):-
    !,
    bcp(unknownfield).

writefield1(F):-
    ldaptotuc(F,G),!,
    bcp(G),write(' '),!.

writefield1(F):- bcp(F),write(' '),!. %% bcp(field(F))

writefield1(_):- write(' ??? '). %% catchall

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




writefieldvalue1(Rec,Field):- %% finds value, addref
    findfieldvalue1(Rec,Field,Val),
    !,
    writefield1(Field), 
    write(' '),
    
    cleanup_name(Field,Val,Val0),

    out(Val0), %% TA-070611

    convert_tucnf(Field,Val0,Val1), 
    
    !,
 
    ldap_addrefdialog(Field,Val1).
 
writefieldvalue1(_Rec,Field):- %% field not present %% TA-070112 ad hoc
    writefield1(Field),   
    doubt('unknown', ukjent).



writefieldvalue(Rec, roomnumber) :- %% adds street to the output
        recordfieldvalue(Rec, roomnumber, Room),
        recordfieldvalue(Rec, street, Street),
        !,  
   writeroom(Room), comma, space,
        write(Street).

writefieldvalue(Rec, ou) :-
        set_ops(Value, recordfieldvalue(Rec, ou, Value),Values),

   writevaluelist(_,Values).  %% RS-140914, where is writevaluelist/1 gone ?! 


writefieldvalue(Rec, Field) :-
        recordfieldvalue(Rec, Field, Value),
        removebackslashes(Value, Text),
        out(Text).    %% ****  Tore Amblehar



writename(TA):- var(TA),!,write('???').

writename(TA) :-
    specname(TA,TTAA),
    !,
    roundwrite(TTAA).   % utility.pl

writename((F,G)):-!,
    writename(F),
    roundwrite(G).

writename(TA):-bwrbc(TA).



writeroom(Room) :-
        atomreplace(Room,'*',': ',Repl),
        writename(Repl). %%  busanshp.pl


writevaluelist(Field,ValList) :-
        bcpbc(field(Field)),colon,
   wrfs(ValList).


wrfs([]):-!,write([]).

wrfs([X]) :- !,wrf1(X).


wrfs([Val|List]):-
    wrf1(Val), 
    for(member(X, List), (write(', '),wrf1(X))).


wrf1(X):-
       removebackslashes(X, NewText),
       writeroom(NewText).


%writevaluelist2([Value],'-') :-
%        removebackslashes(Value, Text),
%        nl,
%        writeroom(Text).
%
%writevaluelist2([First|Rest],Int) :-
%        writevaluelist2(Rest,TmpInt),
%        nl,
%        write(TmpInt),
%        append_atomlist([TmpInt, '-'],Int),
%   removebackslashes(First, NewText),
%        writeroom(NewText).





%% QUIT %% TA-070419
xwriteanswer( Fql, AnswerOut ) :-
    value(directflag,true),
    !,
    value(directoutputfile,Newans), 
    tell(Newans), 
       nl,

        output('*** TQL  ***'),nl,
        output(Fql),nl,

        output('*** Answer ***'),nl,
        output(' '),nl,

        call(AnswerOut),nl,

     told.


xwriteanswer(_Fql,AnswerOut):- %% TA-070608
   writeanswer( AnswerOut ).


%% WRITE TELEBUSTER ANSWER ...

writetelebusteranswer4(sant,TQL,_AnswerOut,_Frame):-%% TA-060905 
    value(directflag,true),
    !,
    nl,
    output('*** TQL  ***'),nl,
    prettyprint(TQL), nl,
    output('*** Answer ***'),nl,
    output(' '),nl.   %% no answer 

writetelebusteranswer4(sant,_Tql,_AnswerOut,_Frame). %% TA-060905 


writetelebusteranswer_rep( Frame ) :- %% TA-060224
    writetelebusteranswer1( Frame ).

%% sqt

writetelebusteranswer_sqt(TQL,_AnswerOut,_Frame) :-   %% TA-060224
    value(directflag,true),
    !,
%%     value(directoutputfile,Newans), %% TA-060825
%%     tell(Newans), %% ALREADY OPEN BY PARAPHRASE2

        nl,
        output('*** TQL  ***'),nl,
        prettyprint(TQL), nl,

        output('*** Answer ***'),nl,
        output(' '),nl.   %% no answer 
%%        writeanswer(AnswerOut),nl.  %% TA-060825


writetelebusteranswer_sqt(_TQL,_,_Frame) :-  %% TA-060825  
   true.


%% sat

teleanswer_sat( TQL, Frame ) :-  %% TA-060224
    value(directflag,true),
    !,
%%    value(directoutputfile,Newans), %% TA-060825
%%    tell(Newans), %% ALREADY OPEN BY PARAPHRASE2

        nl,
        output('*** TQL  ***'),nl,
        prettyprint(TQL), nl,
        output('*** Answer ***'),nl,
        writetelebusteranswer1( Frame ),
    true.  %% TA-060127 Keep Open

teleanswer_sat(_,Frame) :-
    writetelebusteranswer1(Frame). 


busanswer_sat( TQL, AnswerOut, _Frame ) :-  %% TA-060224
    value(directflag,true),
    !,
%%    value(directoutputfile,Newans), %% TA-060825
%%     tell(Newans), %% Already open by PARAPHRASE2

        output('*** TQL  ***'),nl,
        prettyprint(TQL), nl,
        output('*** Answer ***'),nl,
        writeanswer(AnswerOut), %% TA-060428
    true.  %% TA-060127 Keep Open


busanswer_sat(_Tql,AnswerOut,_Frame):-  %% TA-060428
    writeanswer(AnswerOut).











writetelebusteranswer_saf(TQL,Frame) :-  %% TA-060420
    value(directflag,true),
    !,
%%  value(directoutputfile,Newans),  %% TA-060825
%%     tell(Newans),  %% Already OPEN by paraphrase2

        output('*** TQL  ***'),nl,
        prettyprint(TQL), nl,
       
        output('*** Answer ***'),nl,
       
        writetelebusteranswer1( Frame ),

    true.  %% TA-060127 %% Keep open


writetelebusteranswer_saf(_,_Frame) :- %% TA-060420
    !. %% writetelebusteranswer1(_Frame). 



listall( Module:P ) :- for( Module:P, output(Module:P) ).  %% RS-141015 Always succeed even when no output?


%%

writetelebusteranswer1( Module:Frame ) :-
    frame_getvalue_rec( Module:Frame, return, [count|_], _ ),!,
    !,
    frame_getvalue_rec( Module:Frame, itemsfound::itemcount, C, _),
    bcpbc(numrecords(C)),
    colon,nl. %%%  period.

writetelebusteranswer1( Module:Frame ) :- 
    frame_getvalue_rec( Module:Frame, return, [], _),
    !, 
    output('Fant ingen felt å finne verdien til.'),nl.  %% doubt


writetelebusteranswer1( Module:Frame ) :-                %% return not set,show standard (Marvin):
    value(telebusterflag,true),     %% Telebuster,  address is important
    \+ frame_getvalue_rec( Module:Frame, return, _A,_B ), %% TA-0605116

    frame_setvalue_rec( Module:Frame, return,[roomnumber,address], Frame1 ),
    !,

    listall( Frame1 ). %% avdeling til odd pettersen
%%     writetelebusteranswerfields(Frame1). 



writetelebusteranswer1( Module:Frame) :-                %% return not set,show standard (Marvin):
    value(teleflag,true),        %% DAter, telephone is important
    \+ frame_getvalue_rec( Module:Frame, return,_A,_), %% TA-0605116
    !,
    frame_setvalue_rec( Module:Frame,return,[telephonenumber],Frame1),


    listall(Frame1).

%%    writetelebusteranswerfields(Frame1). %% TA-060302


writetelebusteranswer1( Module:Frame ) :-                %% 
    value(teleflag,true),      
    frame_getvalue_rec( Module:Frame, return,_A,_),
    !,
    listall( Module:Frame ).



writetelebusteranswer1(Frame) :-                %% return not set, show a nice list of properties
    listall(Frame).                


writetelebusteranswerfields( Module:Frame) :- %% TA-060306
    frame_getvalue_rec( Module:Frame, return, RList, _),
    !, 
    frame_getvalue_rec( Module:Frame, itemsfound::items, Recs, _),

%% torea amble has phone 94451

   tahasattval(Recs,RList).

writetelebusteranswerfields(Frame) :- %% TA-060306

     output(Frame). %%%%%%%% Panic Dump %%%%%%

tahasattval(I,RList):-   

    writefieldvalue(I,cn),
    writefieldverb(RList),
    !, 
    writefieldvalues(I,RList),
    nl.



waves :-  value(norsource,true), %% TA-110207
    !.

waves :-  value(traceprog,0), %% TA-110207
          !.

waves :-  value(dialog,1),
          !.

waves :-        
         write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'), % 77 chars
         write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),nl.


writedate(date(Y2000,M11,D12)) :-
    language(norsk),
    !,
    monthshort(M11,_,Nov),
    write(D12),write('. '),write(Nov),write(' '),write(Y2000),write(' ').


writedate(date(Y2000,M11,D12)) :-
    language(english),
    !,
    monthshort(M11,Nov,_),
    write(Nov),write(' '),write(D12),write(', '),write(Y2000),write(' ').



%%%%%%%%%

writefieldverb([ou]) :- %% ad hoc
   bcp(ison).

writefieldverb(ou) :-
        bcp(ison).

writefieldverb(_) :-
    bcp(has).

%%%%%%%%%%%%%%%%%%

%% RS-150104 Extra predicates from BusAnsHP

xspecname(XXXX,XX):-
    value(dialog,1),
    specname(XXXX,XX).



xspecname(XXXX,XX):-  %% NB ??????????
    \+ value(dialog,1),
    value(smsflag,true),
    short_specname(XXXX,XX).



xspecname(TMN_S,S):-
    specname(TMN_S,S),
    !.

xspecname(TMN_S,S):-
%%    routedomain(D),

   value(actual_period, M),

%%    route_period(D,M,_,_), %% NO, current route domain!!!!

   M \== nil,
   M:hpl(_,_S0,TMN_S,S),
   !.



