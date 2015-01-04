/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE teledat2.pl   
%% SYSTEM TeleTUC
%% CREATED TA-020605
%% REVISED TA-110825


%% File containing TELEDAT ,    %% co-existing with BUSDAT
% UNIT: /db/
:-module( teledat2, [ building/1, bustopic1/1, expandkey/2, has_att_valx/6, has_att_val/4, have_att_val/4, hazard_tagname/1, is_dom_val/5, ldaptotucplace/2,
        legal_tagname/1,        lookupdb2/3,            possible_dom/2,       printdbresult/1,          setoftags/2,   %perform_querycall/2, %% Missing select/4
        tablename/1,            teledbrowfile/1,        teledbtagfile/1,      teleprocessdirect/4,      teletopic1/1,           unwanted_dbname/1
] ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%:- meta_predicate  for(0,0). % for/2. Stay inside the CALLING module? %% RS-141029
%for( P, Q ) :- %% For all P, do Q (with part of P). Finally succeed
%  P, Q, false ; true.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% RS-141026    UNIT: /
%:- ensure_loaded( user:'../declare' ). %% Import has_a operator        %% RS-130624
:- use_module( '../declare', [ value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .

% :- ensure_loaded( user:'../version' ). %% RS-130624 , version_date/1 %% RS-150104 Moved to main.pl module

:- use_module( '../main.pl', [ version_date/1 ] ). %MISERY?!

%% RS-111205, UNIT: utility
:- use_module( '../utility/utility', [ append_atomlist/2, absorb/3, for/2, matchinitchars/3, pront/1, set_of/3, set_ops/3 ] ).  %% RS-141029 for/2, 
%:- use_module( '../utility/library', [ remove_duplicates/2 ]). %% TEMPORARY non-FIX!
:- use_module( '../utility/writeout', [ doubt/2, output/1 ] ).%% RS-140912

:-use_module( '../getphonedir.pl', [  getdbrowsdirect/2 ] ). %% Get LDAP phone info from NTNU

%% UNIT: /tuc/
:- use_module( '../tuc/names', [  unwanted_name/1  ] ).
:- use_module( '../tuc/semantic', [  ( has_a )/2 ] ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% General predicate to expand (or not) a key
%% fetched from database/telekeys.pl

expandkey(Key,Expansion) :-

%%  keyexpansion(Key, Expansion);

	Expansion = Key.


% keyexpansion(idi, 'datateknikk+og+info.vitenskap').
% keyexpansion(ime, 'info.teknologi,+matem+og+elekt').


%% DATA BASE INTERFACE SECTION


teletopic1(X):-
     member(X,[accompany,address,corridor,floor, 
              firstname,lastname,mailaddress,office,telephone,work,hans,hennes,
                       ja,nei, %% ad hoc, most relevant for tele 
               his,her,house,my,it,lift,stair,toilet,entry,exit]).

bustopic1(X):- 
    member(X,[address, arrive,clock,date,station,neighbourhood,
              city,bus,place,route, 
              go,dit,her,hit,kl,           %% nå
              street,
              to,from]).




building(itbygget).       %% IT-vest/IT-syd/IT-øst
building(elektrobygget).  %% Elektro A/B/C/D
building(hovedbygget).
building(sentralbygget).  %% sentralbygg I/ sentralbygg II
building(realfagbygget).  %% [s] Off name 


%% NEW PREDICATE

%% Convert all street filed values to legal busstuc terms 

%  Tabularized Ad Hoc
ldaptotucplace('Høgskoleringen 1',høgskoleringen-1).

ldaptotucplace('Bragstads Pl 2b',o_s_bragstads_plass-2). %% Pl
ldaptotucplace('Bragstads Pl 6', o_s_bragstads_plass-6).


ldaptotucplace('Bragstads pl 2b',o_s_bragstads_plass-2). %% pl
ldaptotucplace('Bragstads pl 6', o_s_bragstads_plass-6).

ldaptotucplace('O. S. Bragstads plass 2',o_s_bragstads_plass-2). 

ldaptotucplace('Dragvoll',dragvoll).
ldaptotucplace('S. Sælands v 7',sem_sælands_street-7).
ldaptotucplace('S. Sælands v 9',sem_sælands_street-9).


tablename(katnavn).     %% TLF-021114
                        %% Sets the name of the table in the database


%% NEW PREDICATE

%% Exception to hazard_tagname('

legal_tagname(amble). %% just to have one

%% NEW PREDICATE  hazard_tagname

%% Destroys taggercall

%% Necessary because LDAP database gives spurious tags 

%% NORWEGIAN %%%%%%%%%

hazard_tagname(adjø). %% actually unnecessary 

hazard_tagname(sælands). %% Panic:  Tagger ->  lastname


hazard_tagname('-').       %% svein-o hvassovd =>  svein o hvassovd
hazard_tagname(',').  

hazard_tagname(avdeling). 

hazard_tagname(bor).  
hazard_tagname(buss). 
hazard_tagname(bussen).  
hazard_tagname(bygning).   %% ? (bygning=firstname)

hazard_tagname(deg). 
hazard_tagname(den). 
hazard_tagname(denne). 
hazard_tagname(dette). 
hazard_tagname(der).  
hazard_tagname(det). 
hazard_tagname(dit).  
hazard_tagname(dra).  
hazard_tagname(dragvoll).  
hazard_tagname(du). 

hazard_tagname(en).   
hazard_tagname(english).   %% do you speak english
hazard_tagname(er).        %% er Arne Halaas lærer 

hazard_tagname(etg). 
hazard_tagname(etage). 
hazard_tagname(etasje).    %% tagged as departent ! 
hazard_tagname(etter).     %% søker etter

hazard_tagname(fins). 
hazard_tagname(folk).
hazard_tagname(fra). 
hazard_tagname(fredag). %% ?
hazard_tagname(før).    %% 
hazard_tagname(første). 

hazard_tagname(gate). 
hazard_tagname(går).

hazard_tagname(han). 
hazard_tagname(hans).   
hazard_tagname(har).       %%  [hvilken tittel] har per borgesen
hazard_tagname(hun). 
hazard_tagname(hvor). 

hazard_tagname(i).  

hazard_tagname(jeg).
hazard_tagname(juni). 

hazard_tagname(kl). 
hazard_tagname(klokka).  %% 
hazard_tagname(klokken). %% 
hazard_tagname(kontor). 

hazard_tagname(mai). 

hazard_tagname(med).  
hazard_tagname(meeting).
hazard_tagname(must).    %% English 
hazard_tagname(møte).    %%  (møterom ok) 

hazard_tagname(navn). 
hazard_tagname(når). 

hazard_tagname(lerkendal). %% NOT Firstname 
hazard_tagname(nardo).     %% NOT Firstname 
hazard_tagname(nth). 
%% hazard_tagname(ntnu).  %% but not firstname
hazard_tagname(nå). 

hazard_tagname(og). 
hazard_tagname(program).
hazard_tagname(rom). 
hazard_tagname(rommet). %% Rolv Rommetveit 

hazard_tagname(sin). 
hazard_tagname(sine).   %% 
hazard_tagname(siste).
hazard_tagname(sitt). 
hazard_tagname(sitte). 
hazard_tagname(sitter). %%
hazard_tagname(skal). 
hazard_tagname(sted). 
hazard_tagname(telefon).

hazard_tagname(tid). 
hazard_tagname(til). 
hazard_tagname(trondheim). 

hazard_tagname(vei). 
hazard_tagname(vet). 
hazard_tagname(vil). 


%%% ENGLISH %%%%%%%

hazard_tagname(bus).  

hazard_tagname(gløshaugen). %% Ad Hoc 

hazard_tagname(get).  
hazard_tagname(have). 
hazard_tagname(her).
hazard_tagname(his).
hazard_tagname(nest).      %%  nest -> next
hazard_tagname(norsk).     %% Kan du snakke norsk
hazard_tagname(now).   
hazard_tagname(there). 
hazard_tagname(time). 
hazard_tagname(you). 
hazard_tagname(with).      %% With navn


%%%  synname(torbjorn,torbjørn). %% for lack of æøå // busdat

%% Unwanted name: Ad hoc total rejection

%% unwanted_dbname(hans). %% New Predicate

%%%% unwanted_dbname(X) :- unwanted_name(X). 

unwanted_dbname(gløshaugen). %% <--- Ad Hoc


%%%%%%%%%%%%%%%%%%%%%%%%% Sequence preserving setof, ( first occurrence stays first)
%:- meta_predicate   set_ops(+,:,+) . %% RS-140211      % set_ops/3 
%set_ops(X,Y,Z):-
%    findall(X,Y,Z1),
%    remove_duplicates(Z1,Z). %% order-preserving
%%%%%%%%%%%%%%%%%%%%%%

%% TA-101110
have_att_val(_SubjectClass,Attribute,SubjectId,Values) :-
    set_ops( X, has_att_val( _, Attribute, SubjectId, X ), Values).        %% utility.pl?



%% Very Small Data Base

%% has_att_val(SubjectClass,Attribute,SubjectId,Value).

has_att_val(_Agent,email,tuc,'toreamb@idi.ntnu.no').          %% TA-110622
has_att_val(_Agent,email,tagore,'toreamb@idi.ntnu.no').       %% i.e. tagore.idi.ntnu.no
has_att_val(_Agent,email,(tore,amble),'toreamb@idi.ntnu.no'). %%

has_att_val(_Person,retirement,(tore,amble),date(2012,04,21)). 
has_att_val(_Person,birthday,(tore,amble),date(1945,04,21)).   %% TA-110519

has_att_val(_Person,retirement,(arvid,holme),date(2011,1,17)). %% TA-101006
has_att_val(_Person,birthday,(arvid,holme),date(1941,1,17)).   %% TA-110519

has_att_val(_Person,birthday,(trond,engell),date(1985,03,09)). %% TE-120215

has_att_val(_Agent,language,tuc,norsk).   %% TA-110825
has_att_val(_Agent,language,tuc,english). %% 

has_att_val(person,retirement,tagore,date(2012,04,21)).   

has_att_val(agent,administrator,tuc,tagore).   
has_att_val(agent,creator,tuc,tagore).       %% NB agent 
has_att_val(agent,leader,tuc,tagore).        %% TA-110606

has_att_val(_Agent,address,atb,'Kongens gate 34b'). %% TA-110622
has_att_val(person,address,(tore,amble),'Guds høyre hånd'). %% RS-120305
has_att_val(person,address,tore,'Guds høyre hånd'). %% RS-120305
has_att_val(person,address,amble,'Guds høyre hånd'). %% RS-120305

has_att_val(person,address,(trond,engell),'IT-Vest'). %% TE-120215
has_att_val(person,address,trond,'IT-Vest'). %% TE-120215
has_att_val(person,address,engell,'IT-Vest'). %% TE-120215

has_att_val(agent,mailaddress,tagore,'toreamb@idi.ntnu.no'). %% TA-110120
has_att_val(agent,mailaddress,tuc,'tagore@idi.ntnu.no'). %% ( only tuc ???)
has_att_val(agent,number,tt,177).    %% anomaly 
has_att_val(agent,number,tmn,177).    %% anomaly 
has_att_val(agent,telephone,tt,177). %% i.e. ruteopplysningen

has_att_val(_Agent,telephone,tuc,73521290).   %% Brage-telefonen
has_att_val(_Agent,telephone,bustuc,73521290). 

has_att_val(company,telephone,brann,110).
has_att_val(company,telephone,politiet,112).
has_att_val(company,telephone,ambulance,112).

has_att_val(agent,telephone,tmn,177). %% anomaly
has_att_val(company,number,tt,177).
has_att_val(company,number,tmn,177). 
has_att_val(company,office,tt,sorgenfri). %% ?
has_att_val(company,telephone,tt,177). %% i.e. ruteopplysningen
has_att_val(company,telephone,tmn,177).

has_att_val(company,telephone,brannvesenet,110).
has_att_val(company,telephone,politiet,112). 
has_att_val(company,telephone,politistasjonen,112). 
has_att_val(company,telephone,ambulanse,113). 

has_att_val(_Company,webaddress,tt,'http://www.atb.no'). %% agent? %% TA-101006

%% TA-101109
has_att_val(_Company,webaddress,flybussen,'http://www.flybussen.no/trondheim/').

%%%% has_att_val(_Company,webaddress,flybussen,'http://www.trondheimflybuss.no/').
%%%% Innstilt %% TA-110308

has_att_val(_Company,webaddress,flybussen,'http://www.vaernesekspressen.no/').


has_att_val(_Company,webaddress,tram,'http://www.graakallbanen.no').

has_att_val(_Agent,streetaddress,atb,'Kongens gate 34'). %% TA-101112

has_att_val(_Agent,webaddress,atb,'http://www.atb.no'). %% %% agent? %% TA-101006

%%% has_att_val( place,webaddress,tt,'http://www.atb.no'). 

has_att_val(program,programmer,tuc,tagore).  %%  (pseudonym of course :-)

has_att_val(system,version,tuc,    X):- version_date(X).   %% RS-131231 version.pl? Imported through main.pl!
has_att_val(system,version,busstuc,X):- version_date(X).
has_att_val(system,version,bustuc, X):- version_date(X).


has_att_val(sms,price,tt,1).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PROGRAM SECTION



%% hours_delay(0). ->> busdat2.pl 


%% Derived composed attributes

% Full Name


% Address

has_att_val(person,address,X,(Street,Num,Char)):-
   value(teleflag,true), 
   has_att_val(person,street,X,Street),
   has_att_val(person,streetnumber,X,Num),
   has_att_val(person,streetcharacter,X,Char).

%%%%%%%%%%%%%

% has_att_valx(person,lastname,telephone,amble,tore_amble,999)

has_att_valx(Person,Lastname,Telephone,Amb,ToreAmble,N):-
    value(teleflag,true),
    is_dom_val(Person,Lastname,Amb,_Amble,ToreAmble),
    has_att_val(Person,Telephone,ToreAmble,N).

%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Prologs setof is baroque %% 
%set_of(X,Y,Z):-           %%
%    setof(X,Y^Y,Z),!;     %% Trick to avoid alternatives
%    Z=[].                 %% What is wrong with empty sets ?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


is_tagged(Word,Concept):-
    value(tags,Tags),
    member([Word,Concept],Tags),

    \+ unwanted_name(Word). %% hans \= Hans  (ad hoc) 


setoftags(Tore,Taglist):-
    value(tags,Tags),

    set_of(Tag,
         (member([result=WT],Tags),
          WT = [[word=Tore]|ToreTags],
          member([Tag=true],ToreTags)),

       Taglist).


%% ACCESS Domain PREDICATES

possible_dom(Person,Amb):-
   Person has_a Att,
   has_att_val(Person,Att,_TA_,Amble),
   matchinitchars(1,Amb,Amble),
   !. %% <---


%% Ad Hoc, 1 is allowed only for first name


is_dom_val(person,Firstname,T,_,_):-
    !,                                   %% <---- Try only tagging
    is_tagged(T,Firstname),
    !.                                   %% <----  Tagging takes precedencs



is_dom_val(person,firstname,T,Tore,ToreAmble):-
   !,
   has_att_val(person,firstname,ToreAmble,Tore),
   matchinitchars(1,T,Tore).


is_dom_val(Person,Lastname,Amb,Amble,ToreAmble):-
   has_att_val(Person,Lastname,ToreAmble,Amble),
   matchinitchars(2,Amb,Amble).  %% avoid t -> last name




%  ADVANCED COMPOSITIONAL LOOKUP ROUTINES

%

%  Database Lookup, Simulated
%  Firstname may be recognized by 1 letter, otherwise 2

lookupdb2(T,Amb,ToreAmble):- %% Tore Amble

       has_att_val(person,firstname,ToreAmble,Tore), % Generate // Slow
       matchinitchars(1,T,Tore),

       has_att_val(person,lastname,ToreAmble,Amble), % Test     // Fast

       matchinitchars(2,Amb,Amble).

lookupdb2(Amb,T,ToreAmble):- %% Amble  Tore

       has_att_val(person,firstname,ToreAmble,Tore), % Generate // Slow
       matchinitchars(1,T,Tore),

       has_att_val(person,lastname,ToreAmble,Amble), % Test     // Fast

       matchinitchars(2,Amb,Amble).


%%%%%%%%%%   DSES  Important Files


teledbtagfile(tagsample0). %% <---------------------

teledbrowfile(rowsample0). %% <---------------------




standardselect([*]). 



teleprocessdirect( AddSelect,Table,Wherelist,Results ) :-

    standardselect(Stan),

    absorb(Stan,AddSelect,Select1), %% seq. preserv. union %% utility.pl

    make_querycall(Select1,Table,Wherelist,InternalQuery),

    write_querycall(InternalQuery),

    perform_querycall2(InternalQuery,Results).




perform_querycall2(InternalQuery,Result):-
    value(useexternal,true),                          %% TLF 030408
    !,
    create_dbquery(InternalQuery,Query),

    getdbrowsdirect(Query,Result). %% Result is now in TQA (rowsample0)

perform_querycall2(_InternalQuery,_Result):-               %% TLF 030408
    \+ value(useexternal,true),
    !,
    output('flag useexternal false ---> no db lookup').



create_dbquery(select(_Select1_,Table,Wherelist,_),Query):-
    plinglist(Wherelist,Table,Query).


plinglist(X,Table,Y):-
    plinglist1(X,PL),
    append_atomlist([ 'select([*],', Table , ',' ,  '[',PL,']', ',X)'],Y).

plinglist1([AV],AV1):-!,
     plingelement(AV,AV1).


plinglist1([AV|T],AVT):-!,
    plingelement(AV,AV1),
    plinglist1(T,T1),
    append_atomlist([AV1, ',' ,T1],AVT).

plingelement(A=V,AV):-
    append_atomlist([A,':',V],AV).



make_querycall(Select1,Person,Wherelist,select(Select1,Person,Wherelist,_Z_)).

%perform_querycall(select(Select1,Person,Wherelist,Z),Z):-
%   select(Select1,Person,Wherelist,Z).


write_querycall(ExternalQuery):-
     value(traceprog,M), number(M), M >= 3,
     nl,
     write('QUERY:  '),
     output(ExternalQuery),nl. 

write_querycall(_).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for( P, Q ) :- %% For all P, do Q (with part of P)
%  P, Q,
%  false;true.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

printdbresult(Z):-
    for( member(L,Z),pront(L) ),

    nl,

    doubt('There are no more',
          'Det er ingen flere'),

    nl.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




