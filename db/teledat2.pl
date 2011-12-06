%% FILE teledat2.pl   
%% SYSTEM TeleTUC
%% CREATED TA-020605
%% REVISED TA-110825

%% File containing TELEDAT 
%% co-existing with BUSDAT

:- module( teledat, [
        expandkey/2,        %% DATA BASE INTERFACE SECTION
        bustopic1/1,        building/1,
        has_att_valx/6,       have_att_val/4,        has_att_val/4,        hazard_tagname/1,       %% goodbye: actually unnecessary
        is_tagged/2,          is_dom_val/5,        ldaptotucplace/2, %  Tabularized Ad Hoc
        legal_tagname/1,       %% Exception to hazard_tagname('
        lookupdb2/3,          make_querycall/4,        teledbrowfile/1,        standardselect/1,
        teleprocessdirect/4,  perform_querycall/2,        perform_querycall2/2,
        create_dbquery/2,     possible_dom/2,        plinglist1/2,
        plingelement/2,       unwanted_dbname/1,              printdbresult/1,
        setoftags/2,          tablename/1,          teletopic1/1,
        teledbtagfile/1,      write_querycall/1
    ] ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%% RS-111205, UNIT: /
:- ensure_loaded( '../declare' ).
:- use_module( '../version' ).    %% version_date/1

:- use_module( library(lists), [ select/4 ] ).
%:- use_module( library(system3), [ exec/3, shell/1 ] ).

:- use_module( '../bustermain2', [ getdbrowsdirect/2 ] ).   %% From getphonedir.pl
:- use_module( '../main', [myflags/2
        %%(:=)/2,    userNOTME:(=:)/2,    myflags/2, %% RS-111204 from declare.pl
   ] ).

%% RS-111205, UNIT: tuc
%:-use_module( '../tuc/names', [
%        compword/3,   kw/1, %% TA-100902 %%%%%%%%%  All the words appearing as [ ] constants in grammar
%        noisew/1,     rewording/2,   synwordx/2,  xcompword/3
%    ] ).
%:- use_module( '../tuc/names', [ fact/1, instant/2 ] ).
:- use_module( '../tuc/names', [ unwanted_name/1 ] ).
:- use_module( '../tuc/semantic', [ (has_a)/2  ] ).  %% RS-111204    has_a/2 from facts.pl

%% RS-111205, UNIT: utility/
:- use_module( '../utility/utility', [
        absorb/3,         append_atomlist/2, doubt/2,  for/2,
        matchinitchars/3, output/1,          output/1, set_of/3,
        set_ops/3
   ] ). %% RS-111204 from utility

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
              go,dit,her,hit,kl,           %% n�
              street,
              to,from]).




building(itbygget).       %% IT-vest/IT-syd/IT-�st
building(elektrobygget).  %% Elektro A/B/C/D
building(hovedbygget).
building(sentralbygget).  %% sentralbygg I/ sentralbygg II
building(realfagbygget).  %% [s] Off name 


%% NEW PREDICATE

%% Convert all street filed values to legal busstuc terms 

%  Tabularized Ad Hoc
ldaptotucplace('H�gskoleringen 1',h�gskoleringen-1).

ldaptotucplace('Bragstads Pl 2b',o_s_bragstads_plass-2). %% Pl
ldaptotucplace('Bragstads Pl 6', o_s_bragstads_plass-6).


ldaptotucplace('Bragstads pl 2b',o_s_bragstads_plass-2). %% pl
ldaptotucplace('Bragstads pl 6', o_s_bragstads_plass-6).

ldaptotucplace('O. S. Bragstads plass 2',o_s_bragstads_plass-2). 

ldaptotucplace('Dragvoll',dragvoll).
ldaptotucplace('S. S�lands v 7',sem_s�lands_street-7).
ldaptotucplace('S. S�lands v 9',sem_s�lands_street-9).


tablename(katnavn).     %% TLF-021114
                        %% Sets the name of the table in the database


%% NEW PREDICATE

%% Exception to hazard_tagname('

legal_tagname(amble). %% just to have one

%% NEW PREDICATE  hazard_tagname

%% Destroys taggercall

%% Necessary because LDAP database gives spurious tags 

%% NORWEGIAN %%%%%%%%%

hazard_tagname(adj�). %% actually unnecessary 

hazard_tagname(s�lands). %% Panic:  Tagger ->  lastname


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
hazard_tagname(er).        %% er Arne Halaas l�rer 

hazard_tagname(etg). 
hazard_tagname(etage). 
hazard_tagname(etasje).    %% tagged as departent ! 
hazard_tagname(etter).     %% s�ker etter

hazard_tagname(fins). 
hazard_tagname(folk).
hazard_tagname(fra). 
hazard_tagname(fredag). %% ?
hazard_tagname(f�r).    %% 
hazard_tagname(f�rste). 

hazard_tagname(gate). 
hazard_tagname(g�r).

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
hazard_tagname(m�te).    %%  (m�terom ok) 

hazard_tagname(navn). 
hazard_tagname(n�r). 

hazard_tagname(lerkendal). %% NOT Firstname 
hazard_tagname(nardo).     %% NOT Firstname 
hazard_tagname(nth). 
%% hazard_tagname(ntnu).  %% but not firstname
hazard_tagname(n�). 

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

hazard_tagname(gl�shaugen). %% Ad Hoc 

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


%%%  synname(torbjorn,torbj�rn). %% for lack of ��� // busdat

%% Unwanted name: Ad hoc total rejection

%% unwanted_dbname(hans). %% New Predicate

%%%% unwanted_dbname(X) :- unwanted_name(X). 

unwanted_dbname(gl�shaugen). %% <--- Ad Hoc


%%%%%%%%%%%%%%%%%%%%%%

%% TA-101110
have_att_val(_SubjectClass,Attribute,SubjectId,Values) :-
    set_ops(X,has_att_val(_,Attribute,SubjectId,X),Values).



%% Very Small Data Base

%% has_att_val(SubjectClass,Attribute,SubjectId,Value).

has_att_val(_Agent,email,tuc,'toreamb@idi.ntnu.no').          %% TA-110622
has_att_val(_Agent,email,tagore,'toreamb@idi.ntnu.no').       %% i.e. tagore.idi.ntnu.no
has_att_val(_Agent,email,(tore,amble),'toreamb@idi.ntnu.no'). %%

has_att_val(_Person,retirement,(tore,amble),date(2012,04,21)). 
has_att_val(_Person,birthday,(tore,amble),date(1945,04,21)).   %% TA-110519

has_att_val(_Person,retirement,(arvid,holme),date(2011,1,17)). %% TA-101006
has_att_val(_Person,birthday,(arvid,holme),date(1941,1,17)).   %% TA-110519

has_att_val(_Agent,language,tuc,norsk).   %% TA-110825
has_att_val(_Agent,language,tuc,english). %% 

has_att_val(person,retirement,tagore,date(2012,04,21)).   

has_att_val(agent,administrator,tuc,tagore).   
has_att_val(agent,creator,tuc,tagore).       %% NB agent 
has_att_val(agent,leader,tuc,tagore).        %% TA-110606

has_att_val(_Agent,address,atb,'Kongens gate 34b'). %% TA-110622
has_att_val(person,address,(tore,amble),'�ya Helsehus 5etg'). %% RS-110926
has_att_val(person,address,tore,'�ya Helsehus 5etg'). %% RS-110926
has_att_val(person,address,amble,'�ya Helsehus 5etg'). %% RS-110926

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

has_att_val(system,version,tuc,    X):- version_date(X).
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
    main:myflags(teleflag,true), 
   has_att_val(person,street,X,Street),
   has_att_val(person,streetnumber,X,Num),
   has_att_val(person,streetcharacter,X,Char).

%%%%%%%%%%%%%

% has_att_valx(person,lastname,telephone,amble,tore_amble,999)

has_att_valx(Person,Lastname,Telephone,Amb,ToreAmble,N):-
     main:myflags(teleflag,true),
    is_dom_val(Person,Lastname,Amb,_Amble,ToreAmble),
    has_att_val(Person,Telephone,ToreAmble,N).

%%%%%%%


is_tagged(Word,Concept):-
     main:myflags(tags,Tags),
    member([Word,Concept],Tags),

    \+ unwanted_name(Word). %% hans \= Hans  (ad hoc) 


setoftags(Tore,Taglist):-
     main:myflags(tags,Tags),

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



teleprocessdirect(AddSelect,Table,Wherelist,Results):-

    standardselect(Stan),

    absorb(Stan,AddSelect,Select1), %% seq. preserv. union

    make_querycall(Select1,Table,Wherelist,InternalQuery),

    write_querycall(InternalQuery),

    perform_querycall2(InternalQuery,Results).




perform_querycall2(InternalQuery,Result):-
     main:myflags(useexternal,true),                          %% TLF 030408
    !,
    create_dbquery(InternalQuery,Query),

    getdbrowsdirect(Query,Result). %% Result is now in TQA (rowsample0)

perform_querycall2(_InternalQuery,_Result):-               %% TLF 030408
    \+  main:myflags(useexternal,true),
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

perform_querycall(select(Select1,Person,Wherelist,Z),Z):-
   select(Select1,Person,Wherelist,Z).


write_querycall(ExternalQuery):-
      main:myflags(traceprog,M), number(M), M >= 3,
     nl,
     write('QUERY:  '),
     output(ExternalQuery),nl. 

write_querycall(_).


printdbresult(Z):-
    for(member(L,Z),pront(L)),

    nl,

    doubt('There are no more',
          'Det er ingen flere'),

    nl.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




