/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE places.pl
%% SYSTEM BUSSTUC  DOMAIN AtB
%% CREATED TA-070503
%% REVISED TA-110818 %% RS-120805 Sorting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% d1 --> dr_gate_d1  etc 
% k1 --> kongens_gate_k1  etc 
% m1 --> munkegata_m1 etc
% p1 --> prinsens_gate_p1 etc

%% Contains predicates that describes information about places (only).
%% Domain specific names  (in principle)
%% Domain TT (Team) Now AtB

% See also names.pl for general synonyms
%% RS-160109: place == neighborhood

:-module( places, [ alias_name/2,       % ( NAME, NAME )                %% RS-141122  NAME vs. PLACE? (Neighborhood?)
                    alias_station/2,    % ( STATION, STATION )          %% RS-141122  Faster to walk than to wait.
                    aliasteamatb/3,     % ( STATNUMBER, STATION_TEAM, STATION_ATB )  %%%%%% Conversion TA-100822
                    cmpl/3,             % ( NAME, NAME*, LIST ) %% Used for some kind of multiword spell-checking  %% RS-160108
                    corr/2,             % ( STATION, STATION )  %% RS-160110
%                   foreign/1,          % ( PLACE ), e.g. aalesund, orkanger(?).   %%% FOREIGN (to Trondheim) places.  MOVED to foreign_places.pl
                    isat/2,             % ( STATION, PLACE )    %% STATION is (one, but not necessarily preferred, among several) stations that belong to the NEIGHBOURHOOD (PLACE)  %% RS-150823
                    nostation/1,        % ( PLACE )
                    place_resolve/2,    % ( PLACE, STATION ).   %% RS-141122 If multiple STATIONs at/for/around PLACE...(see isat/2 or underspecified_place/1)
                    placestat/2,        % ( PLACE, STATION )    %% RS-141122 If only one STATION at/for/around PLACE... (see isat/2 or underspecified_place/1)
                    sameplace/2,        % ( PLACE, PLACE )
                    short_specname/2,   % ( NAME, STRING )     %% RS-131225 For concise SMS-messages
                    specname/2,         % ( NAME, STRING )
                    synplace/2,         % ( NAME, PLACE )       %% Used for some kind of spell-checking  %% RS-160108
                    underspecified_place/1,  % ( PLACE )
                    unwanted_place/1,   % ( PLACE )
                    unwanted_station/1  % ( PLACE )
] ).

%% RS-141026    UNIT: /
%:- ensure_loaded( user:'../declare' ). %, [ := /2 etc. ] ).      %RS-131225  Get dynamic definition for user:value/2
:- use_module( '../declare', [ value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .
%:- use_module( '../main.pl', [ value/2 ] ). %MISERY?!
%%RS-131225     %% UNIT: /

%%RS-131225     %% UNIT: utility/
:- use_module( '../utility/utility', [ ] ). %% RS-140208. Includes user:declare, and GRUF (fernando) %% :-op( 714,xfx, := ).


%% hovedterminalen is technically a station as required in some
%% tables, but semantically a neighbourhood (see sentrum and others)


%%%%%%%%%   REFERENCE TO STATION SECTION %% TA-110705

%% corr( STATION, STATION )

%% HOVEDTERMINALEN == "Sentrum" %%

% corr(prinsenkrysset,hovedterminalen). %% ???  SUMMER %% TA-110701
  %% sorry, gir destinasjon munkegate = Prinsenkrysset  %%

%corr( city_syd_e6_1, city_syd).     %% RS-150823  %% RS-190101 Just one station now...
%corr( city_syd_e6_2, city_syd).      %% RS-150823  %% RS-190101 Just one station now...

%corr(d1,hovedterminalen).      %% RS-150815. Move this to lex?
%corr(d2,hovedterminalen). 
%%corr(d3,hovedterminalen). 
%%corr(d4,hovedterminalen). 

corr(dronningens_gate,hovedterminalen). %% Atb   %% RS-150815 Gammelt (2014-feb) format %% RS-151219 Jule-format? RS-220502 _d1 _d2 removed?
corr(dr_gate_d1,hovedterminalen). %% Atb
corr(dr_gate_d2,hovedterminalen). %% RS-130818  %% RS-150815 d2 Tatt med igjen?
%corr(dr_gate_d3,hovedterminalen). 
%corr(dr_gate_d4,hovedterminalen). 
%corr(dronningens_gate_d1,hovedterminalen). %% Atb   %% RS-150815 Gammelt (2014-feb) format %% RS-151219 Jule-format?
%corr(dronningens_gate_d2,hovedterminalen). %% RS-130818  %% RS-150815 Tatt med igjen?
%%corr(dronningens_gate_d3,hovedterminalen). 
%%corr(dronningens_gate_d4,hovedterminalen). 

corr(dronningens_gate_19,hovedterminalen). %% TA-110627
corr(dronningens_gate_46,hovedterminalen). %% TA-110627
corr(dronningens_gate_50,hovedterminalen). %% TA-110627
corr(dronningens_gate_62,hovedterminalen). %% RS-220508


%kongens gate (hovedterminalen fra 2013.08.12   %% RS-130812
corr(k1,hovedterminalen). 
corr(k2,hovedterminalen). 

corr(kongens_gate,hovedterminalen). %% Atb
%corr(kongens_gate_k2,hovedterminalen). 
%corr(kongens_gate_k1,hovedterminalen). %% Atb
%corr(kongens_gate_k2,hovedterminalen). 


%corr(kongens_gate_19,hovedterminalen). %% TA-110627
%corr(kongens_gate_46,hovedterminalen). %% TA-110627
%corr(kongens_gate_50,hovedterminalen). %% TA-110627

%corr(astronomveien, krokstien ).      %% RS-160110 Instead of trying alias_station or isat!
corr( astronomvegen, krokstien ).      %% RS-160110 Instead of trying alias_station or isat! veg med g

%% corr(munkegata_m0,sentrum).  %% ad hoc sverresgt-> m0->sentrum
%corr(m0,hovedterminalen).  %% Generic central place
%corr(m0,sentrum).  %% ad hoc sverresgt-> m0->sentrum
%corr(m1,hovedterminalen). 
%corr(m2,hovedterminalen). 
%corr(m3,hovedterminalen). 
%corr(m4,hovedterminalen). 
%corr(m41,hovedterminalen).  %% SIC
%corr(m5,hovedterminalen). 

corr(munke_street,hovedterminalen). 

%%%%%% corr(munkegata_m0,hovedterminalen).  %% Atb
%corr(munkegata_m1, hovedterminalen). 
%corr(munkegata_m2, hovedterminalen). 
%%corr(munkegata_m3,hovedterminalen). 
%corr(munkegata_m4, hovedterminalen). 
%corr(munkegata_m41,hovedterminalen).  %% SIC
%corr(munkegata_m5, hovedterminalen).

%% old team for compatibility
%corr(munkegata_m0,hovedterminalen).  %% Generic central place
%corr(munkegata_m1,hovedterminalen). 
%corr(munkegata_m2,hovedterminalen). 
%corr(munkegata_m3,hovedterminalen). 
%corr(munkegata_m4,hovedterminalen). 
%corr(munkegata_m41,hovedterminalen).  %% SIC
%corr(munkegata_m5,hovedterminalen). 


%% RS-141207 COMMENT AWAY these two entries?!?
%corr(prinsens_gate_p1,hovedterminalen). %% Atb
%corr(prinsens_gate_p2,hovedterminalen). %% RS-140102
corr(prinsens_gate_p1,hovedterminalen). %% Atb
corr(prinsens_gate_p2,hovedterminalen). %% RS-140102
%corr(p1,hovedterminalen).  %% RS-140102 Difficulties with hovedterminalen != sentrum? Ambiguous p1 == prinsen == prinsens gate == ...
%corr(p2,hovedterminalen).

%corr(sentrum,hovedterminalen). %% RS-150815 Synplace?

%corr(torget,hovedterminalen).         %% SUMMER %% TA-110628 %% RS-130816 REMOVED before WINTER...

corr( st_olavs_gate, hovedterminalen ). %% RS-140102 %% RS-141115 (Tram!) st_olavs_gate
corr( ila, hovedterminalen ). %% RS-140102 %% RS-141115 (Tram!) %% RS-2025-08-19 Gravearbeider i st_olavs_gate "bygrensen" er bedre?
corr( olav_tryggvasons_gate_ot1, hovedterminalen ).  %% RS-120915 (Nightbus!)


%% END HOVEDTERMINALEN == "Sentrum" %%  RS-151219 Different from: Sentrumskvartalet == sentrum !


%% corr(grilstadvegen, skovgård).  %% RS-160212
%% corr(havstad, havstadsenteret). %% RS-160119 OK? No, didn't work! But this did (-:
%%alias_station(havstad, havstadsenteret). %% RS-160119 OK? Should make this predicate symmetric?
%%alias_station(havstadsenteret, havstad). %% RS-160119 OK?


%%% corr(brannstasjon_øst,strindheim).  %% TA-110822
corr(lerkendal_stadion,lerkendal). 

%corr(stavset_senter,stavset_senter). %% RS-160108 ??

%corr(studentersamfundet,studentersamfundet_2).   %% RS-140901 Ser ikke ut som om _1 finnes lenger?
%corr(studentersamfundet_1,studentersamfundet_2). %% RS-140901 Ser ikke ut som om _1 finnes lenger?

corr(trondheim_hurtigbåtterminal,trondheim_s).
corr(trondheim_hurtigbåtterminal,pirbadet).

corr(strindheim, strindheim_2).
corr(strindheim_2, strindheim).

%% ALIAS_NAME

alias_name('44a',44). 
alias_name('4a',4).
alias_name('5e',5). 
alias_name('6e',6). 
alias_name('7a',7). 
alias_name(dv,dragvoll). 
alias_name(klæburuta,klæburuten). 
alias_name(linje9,trikken). 
alias_name(team,tt). 
alias_name(teamtrafikk,tt). 


%¤ alias_station/2,         % (STATION,STATION)
%Examples:
%
%STATION is very close to other STATIONs, and walking is faster than waiting. So practially identical options.
%% This doesn't work (yet?), so try isat (not isat2) instead! E.g. "Fra krokstien til samfunnet på søndag."

%% RS-160110 This is also useful for stations that have no buses on Sundays, for example? No, use corr
%alias_station(krokstien, astronomveien ).      %% RS-160101 vei med i
%alias_station(astronomveien, krokstien ).   %% RS-160101
alias_station( krokstien, astronomvegen ).      %% RS-160809 veg med g
%alias_station( astronomvegen, krokstien ).   %% Doesn't work (yet?), so use corr/2 instead

alias_station( berg_østre, østre_berg ). %% AtB
alias_station( breidablikk_trikk, breidablikk ).        %% RS-141115 %% RS-151219 Try to generalize this for all "X_trikk" if X is a station ?! See alias_station2 ?
alias_station( dv,dragvoll ).

%%alias_station(gudes_gate,høgskoleringen).       %% RS-131027 Not needed according to heuristics

%alias_station(grilstadvegen, skovgård).  %% RS-160212 Bør brukes bare "en vei"?

alias_station(havstad, havstadsenteret). %% RS-160119 OK? Should make this predicate symmetric?
alias_station(havstadsenteret, havstad). %% RS-160119 OK?

alias_station( hospitalskirka_trikk, hospitalskirka ).            %% RS-141115
%%alias_station(høgskoleringen,gudes_gate).

alias_station( lade_gård, lade ). %% TA-100802 old station-> neibourhood
alias_station( lade_alle_80, lade ). %% TA-100802 old station-> neibourhood
alias_station( lade_alle_80, jørgen_b_lysholms_vei ).     %% Bussen står og venter her ganske lenge!  %% RS-141122

alias_station( munkvoll_trikk, munkvoll ).        %% RS-141115
alias_station( ntnu_dragvoll, dragvoll ).

alias_station( nyveibakken_trikk, nyveibakken ).  %% RS-141115

alias_station(skovgård, grilstadvegen).           %% RS-160212

alias_station( ugla_trikk, ugla ).                %% RS-141115


%% RS-151219 Can this also be used for stations that keep changing name between summer and winter routes?
%% Ref discrepencies:alias_station2 and isat2



%% NOSTATION 

%% places in Trondheim without station (not foreign)

%% TRAM  stations
%%  Experiment Only if not properstation

%% ALWAYS INCLUDE TRAMSTATIONS! %% RS-141115
%nostation(bygrensen):- \+value(tmnflag,true).    
%nostation(ferstad):-   \+value(tmnflag,true). %% Ferstads vei
%nostation(herlofsonsløypa) :- \+value(tmnflag,true). 
%nostation(lian):-      \+value(tmnflag,true).  
%nostation(lian). 
%nostation(nordre_hoem) :- \+value(tmnflag,true). 
%nostation(rognheim) :- \+value(tmnflag,true). 
%nostation(søndre_hoem):- \+value(tmnflag,true). 
%  nostation(st_olavs_gate). 
%nostation(st_olavs_gate):- \+ value(tmnflag,true).        %% RS-131223    From busdat.pl



nostation(arbeidsbuss). %% SIC  endstation bus 100 

nostation(frøset). 

%% nostation(heggsnipen). %% fins ikke i rdata(barei hefte). %%fikset 5.3.07


%%%%%% Nostation  no bus to place ever

nostation(baklidammen). 
nostation(bjørnebyen).    %% (langs trikkelinjen mot Lian)
nostation(benjaminbyen).  %%
nostation(benjaminsbyen). 

nostation(bybrua).
nostation(bybruen). 
nostation(bybroen). %%  (gamle bybro)
nostation(bybro).  

nostation(byneset_kirke).  

% nostation(byåsveien).              %%   On Map, not on Route 
nostation(devlebukta). 
nostation(devlebukten). 

nostation(elgsethytta). 
nostation(elgsethytten).  
nostation(elgsetshytta).  

nostation(estenestaddammen). 
nostation(estenstadhytta). 
%%  nostation(fjellseter).  
nostation(fjordgata). %% as street, OK , but underspecified
nostation(flaktveit). %% i Th??? Foreign

nostation(graaemølna). nostation(graaemølna). %% nedlagt f.o.m. høst 2008

nostation(grankollen). 
nostation(gråkallen). 



% nostation(kjøpmannsgata).          %%  (m. var.)  STREET  
% nostation(leuthenhaven).           %% NOT as such


% % % %

%% nostation(arbeidsbuss). %% spurious Reg stations %% fikset 5.3.07
nostation(g).  

nostation(grønningen). 

% nostation(heggstadmyra).  -> heggstadmoen
% nostation(hornebergveien).         %%  OK (ONLY in WINTER)
% nostation(haakon_vii_gate). %% Not in summer 

%% nostation(hårstad).        %% hpl 503 Non Existent -> Krgeness
nostation(hårstadstien). %% 

nostation(lavoll). 
nostation(lavollen). 
nostation(geitfjellet). 

nostation(grønnlia). 
nostation(lillegårdsbakken).    
nostation(munkholm).  
nostation(munkholmen).  
%  nostation(møller_bil).        %% not in summer 
nostation(nardoskrenten). 

%%%  nostation(nidelv_bru). %% nedlagt 22. mars %% TA-110822

%%% nostation(nidarø).    %% Trondheim spektrum 
% nostation(nordre_ilevollen).  
% nostation(nardo_omkjøringsvei). %% Not in summer 
nostation(olsborg).   %%  Trlag ???
%% nostation(royal_garden).   
%%  nostation(skistua). 

%% nostation(roial_garden). %% only 1 departure with nightbus 
                            %% However, hotell royal garden neighbourhood                     
nostation(sommerseter). 
nostation(sommersæter). 
nostation(sommersætra).  
nostation(sommersetra).


nostation(stokkmarka).
%% nostation(storgata).    %%  foreign 

%% nostation(steinaunet).

%% nostation(studenterhytta). 
nostation(sundalsveien). 
nostation(sundlandsskrenten). 
nostation(sunnlandsskrenten).      %%  (no spellc)
nostation(sundlandsveien). 
nostation(sundlandsvn). %% NO SPELLCORR to NOSTATION 
nostation(sundlandsskrenten). 

%  nostation(st_olavs_gate). 
% nostation(st_olavs_gate) :- \+ value(tmnflag,true). %% RS-131223  From busdat.pl
% nostation(st_olavs_gate) :- \+ value(tramflag,true). %% RS-140102 Always include Tram!

nostation(teisendammen).  
nostation(theisendammen). 

%nostation(teisendamen).   %% X
%nostation(theisendamen).  %% X

nostation(ullins_vei). %% abandoned 2006 
                       %% street remains

nostation(varden). %% i TH?  
nostation(vollmarka). 
nostation(våddan).        %%

nostation('Øvre Alle'). 

%%%%%% Conversion  Team Station names > 100822
    %%             AtB Station names  < 100823

aliasteamatb(16010001,prinsens_gate_p1,prinsens_gate_p1). %% just 1 for safety

%% CMPL  ( FIRSTWORD, [ FOLLOWING, WORDS ], identifier ).

cmpl(3,[t,rosten],maskinagentur).  %%  \+  lørdag kl.  0300 ." Vetrse Rosten 80

cmpl(a,[jenssens,veg],anton_jenssens_veg).      %% RS-160108 Station! Todo: And also a street!

cmpl(a,[s,trondheim,trafikkselskap],tt). 
cmpl(aalmos,gate,o_j_aalmos_street). 
cmpl(aalmos,veg,o_j_aalmos_street). 
cmpl(aalmos,vei,o_j_aalmos_street). 
cmpl(aasveien,[skole],åsveien_skole). 
cmpl(abra,hallen,abrahallen). 
cmpl(adm,rit,adm_rit).  %% unvisited station
cmpl(adolf,[øien,skole],'Adolf Øiens skole').   %% NEC????
cmpl(adolf,[øiens,skole],'Adolf Øiens skole').  %% EH-041004
cmpl(adolf,øien,adolf_øien). 
cmpl(adressa,[på,heimdal],adresseavisen). 
cmpl(adresseavisen,[heimdal],adresseavisen). 
cmpl(adresseavisen,[på,heimdal],adresseavisen).
cmpl(alfgodagers,vei,alf_godagers_vei). 

cmpl(alfred,[høyems,vei],hallfred_høyems_vei). 
cmpl(alfred,[høyemsv],hallfred_høyems_vei). 
cmpl(alfred,[høyemsveg],hallfred_høyems_vei). 
cmpl(alfred,[høyemsvei],hallfred_høyems_vei). 
cmpl(alfredhøyems,[veg],hallfred_høyems_vei). 

cmpl(alt,['/',statoil],'ALT/Statoil'). %% extra dep bus 6

cmpl(amo,['-',senteret],amo_senteret). 
cmpl(amo,['-',sentret],henrik_ourens_vei). 
cmpl(amo,senteret,amo_senteret). 
cmpl(amundsens,vei,roald_amundsens_street). 
cmpl(anders,[buås,vei],anders_buens_gate). 
cmpl(anders,[byens,gate],anders_buens_gate). 

%% cmpl(anders,[estenstads,veg],estenstadveien).  %% NO, valentinlyst 

cmpl(anders,[grevskotts,vei],anton_grevskotts_vei). %% RULE HERE (Only check Initials)
cmpl(anders,[grevskottsvei],anton_grevskotts_street). %%  etc Ad Hoc 
                                                       
cmpl(anders,buen,anders_buens_gate). 
cmpl(anders,buens,anders_buens_gate). 
cmpl(anders,buensgate,anders_buens_gate). 
cmpl(anders,smistadsvei,arnt_smistads_vei). 
cmpl(andersbues,gate,anders_buens_gate). 
cmpl(ankers,gata,ankers_gate).  %%gata \+ spellch



cmpl(anton,[grev,skott,veg],anton_grevskotts_vei). 
cmpl(anton,[grev,skott,vei],anton_grevskotts_vei). 
cmpl(anton,[grev,skotts,gt],anton_grevskotts_vei). 
cmpl(anton,[grev,skotts,veg],anton_grevskotts_vei). 
cmpl(anton,[grev,skotts,vei],anton_grevskotts_vei). 
cmpl(anton,[grev,skotts,vei],anton_grevskotts_vei). 
cmpl(anton,grevsgate,anton_grevskotts_vei).
cmpl(anton,grevskottsveg,anton_grevskotts_vei). 
cmpl(anton,grevskottsvei,anton_grevskotts_vei). 
cmpl(anton,grevskottveg,anton_grevskotts_vei). 
cmpl(anton,grevstokksvei,anton_grevskotts_vei). 
cmpl(antongrev,skottsvei,anton_grevskotts_vei). 
cmpl(antongrevskotts,vei,anton_grevskotts_vei). 

cmpl(arne,[buens,vei],anders_buens_gate).
cmpl(arne,[grevskotts,veg],anton_grevskotts_vei).  %% Etc
cmpl(arne,bergårdsvei,arne_bergsgårds_street). 
cmpl(arne,bergårdsvei,arne_bergsgårds_vei).  %% Trouble
cmpl(arnebergsgårds,vei,arne_bergsgårds_vei). 
cmpl(arnt,smestadsvei,arnt_smistads_vei).  %% ?
cmpl(arntsmistads,vei,arnt_smistads_vei).  
cmpl(arntsmistadsvei,[],arnt_smistads_vei). %% TA-110329

cmpl(as,[trondheim,trafikkselskap],tt). 
cmpl(asbj,gate,asbjørnsens_gate). 
cmpl(asbjørn,øveraasv,asbjørn_øverås_street). 
cmpl(asbjørn,øveraasveg,asbjørn_øverås_street). 
cmpl(asbjørn,øveraasvei,asbjørn_øverås_street). 
cmpl(asbjørnoverås,veg,asbjørn_øverås_street). 
cmpl(asbjørns,[ens,gate],asbjørnsens_gate).  %% ?act
cmpl(asbjørns,[gate],asbjørnsens_gate). 
cmpl(asbjørnsens,[],asbjørnsens_gate).  %% Haz ? 
cmpl(asbjørnåverås,veg,asbjørn_øverås_street). 
cmpl(asveien,[skole],åsveien_skole). 
cmpl(auto,[2000],fossegrenda). 
cmpl(avishuset,[på,heimdal],adresseavisen). 

cmpl(bakke,[p,hus],bakkegata). 
cmpl(bakke,bro,bakkegata). 
cmpl(bakke,bru,bakkegata). 
cmpl(bakke,bruk,bakkegata). 
cmpl(bakke,gate,bakkegata). 
cmpl(bakke,kirke,bakkegata). 
cmpl(bakke,parkeringshus,bakkegata). 

cmpl(balders,barnehage,baldershage).  %% SIC:-) ?
cmpl(balders,hage,baldershage). 
cmpl(balders,terasse,baldershage). %% ? 
cmpl(balders,veg,balders_street).  %% is only recognized as street
cmpl(beddingen,[10],solsiden). %% solsiden). 
cmpl(beddingen,[8],solsiden).  %% solsiden). 
cmpl(bedriftsøkonomisk,institutt,bi). 
cmpl(ber,studentby,berg_studentby).  %% < 4 bokst
cmpl(berg,skole,bergsbakken). %%   BERGSBAKKEN 17 , Harald Gilles veg .?
cmpl(berg,[skole,på,tyholt],bergsbakken). 
cmpl(berg,[st,by],berg_studentby).  %%
%cmpl(berg,[student,by],bugges_veg). %% RS-150913 Stengt permanent i februar
cmpl(berg,[student,by],berg_studentby). 

cmpl(berg,arbeiderkirke,'Berg arbeidskirke'). %% \= berg_prestegård). 
cmpl(berg,arbeidskirke,'Berg arbeidskirke'). 
cmpl(berg,arbeidskyrkje,'Berg arbeidskirke'). 
cmpl(berg,bedehus,'Berg arbeidskirke'). 
cmpl(berg,kirke,'Berg arbeidskirke'). 

cmpl(berg,skole,bergsbakken). 
cmpl(berg,student,berg_studentby).  %% ?
cmpl(bergstudent,by,berg_studentby).
cmpl(berg,østre,østre_berg). 
cmpl(bergheim,amfi,bergheim). 
cmpl(bergheim,terrasse,bergheim). 
cmpl(bergs,alle,gyldenløves_gate).  %% \+ sig bergs
cmpl(bergsgårds,[vei],arne_bergsgårds_vei). 
cmpl(bi,tiller,østre_rosten). 
cmpl(bi,trondheim,bi). 
cmpl(billett,kontoret,servicekontoret). 
cmpl(bilsakkyndig,sluppen,e_verket). 
cmpl(bilsakkyndige,sluppen,e_verket). 
cmpl(biologisk,stasjon,biologen). 

cmpl(birkelands,gt,richard_birkelands_street).  
cmpl(birkelands,vei,richard_birkelands_street). 

cmpl(biskop,[gunnerus,gate],gunnerus_street). 
cmpl(biskop,[sigeruds,gate],buran_3). %% This one has a new name buran_3 %% AE-20200706
cmpl(biskop,[syrs,gate],buran_3). %% sigurd syr \= biskop sigurd 
cmpl(biskop,[sigurdsons,gate],buran_3). 
cmpl(biskopsigurds,gate,buran_3). 

cmpl(bispehaugen,skole,bakkegata).  %% Nonnegt 19
cmpl(bjarne,[naess,vei],bjarne_ness_veg). 
cmpl(bjarne,wist,stjørdals_street). 
cmpl(bjørndals,brua,bjørndalsbrua). 
cmpl(bjørndals,toppen,bjørndalstoppen). 
cmpl(blindes,hus,churchills_veg). 
cmpl(blussuvold,skole,strinda_vgs). 
cmpl(blussuvoll,skole,strinda_vgs). 
cmpl(boat,pier,pirbadet).


%cmpl(bothners,v,harald_bothners_veg). 
%cmpl(bothners,vei,harald_bothners_veg). 
cmpl(bragstads,[plass],o_s_bragstads_plass). 
%%%% cmpl(brit,[grytbakks,vei],brit_grytbakks_street). %% Ad Hoc (Ny veg,ikke nr)
cmpl(bratsberg,skole,bratsberg).   

cmpl(britannia,hotell,britannia_hotell). %% Flybussen 

cmpl(broch,[s,gate],hesthagen).  %%broch'sgate
cmpl(brochmannsgate,[],odd_brochmanns_street). 
cmpl(brochmannsveg,[],odd_brochmanns_street).
cmpl(brochmannsvei,[],odd_brochmanns_street).
cmpl(brochmanns,gate,odd_brochmanns_street). 
cmpl(brochmanns,veg,odd_brochmanns_street). 
cmpl(brochmanns,vei,odd_brochmanns_street). 
cmpl(brochs,gata,hesthagen). 
cmpl(brochs,gate,hesthagen). 
cmpl(brochs,gt,hesthagen). 
cmpl(brochs,vei,hesthagen). 
cmpl(bromstad,svingen,bromstadsvingen). 
cmpl(brun,dalen,brundalen). 
cmpl(brundalen,[sykeheim],brundalen_sykehjem). 
cmpl(brundalen,[sykehjem],brundalen_sykehjem). 
cmpl(brundalen,[v,g,s],charlottenlund_vgs).
cmpl(brundalen,[v,g,skole],charlottenlund_vgs).
cmpl(brundalen,[vg,skole],charlottenlund_vgs). 
cmpl(brundalen,[videregående,skole],charlottenlund_vgs). 
cmpl(brundalen,[videregående,skolesenter],charlottenlund_vgs). 
cmpl(brundalen,skolesenter,charlottenlund_vgs).
cmpl(brundalen,videregående,charlottenlund_vgs).
cmpl(brundalen,yrkesskole,charlottenlund_vgs).
cmpl(brundalen,skole,charlottenlund_vgs).
cmpl(brøset,hageby,brøset_hageby). 
cmpl(brøset,sykehus,'Brøset sykehus'). 
cmpl(brøsetv,[168],brøsetvegen_168). 
cmpl(brøsetvegen,[168],brøsetvegen_168).  %% nec ?. . . 
cmpl(brøsetvegen,[168],brøsetvegen_168). 
cmpl(brøsetvn,[168],brøsetvegen_168). 
cmpl(buens,gate,anders_buens_gate).  %% ETC generic,lastname
cmpl(bukk,vollan,bukkvollan). 
cmpl(bukkenes,[bruses,vei],bukken_bruses_street). 
%% cmpl(bunke,gata,munkegata). % bukse 
%% cmpl(bunke,gaten,munkegata). 
cmpl(buran,postkontor,buran). 

cmpl(buss,stasjonen,hovedterminalen). 
cmpl(buss,['-',stasjonen],hovedterminalen). 

cmpl(buss,terminalen,hovedterminalen). 

cmpl(bussentralen,[i,trondheim],hovedterminalen). 
cmpl(busstorget,[],hovedterminalen). 
cmpl(by,sentrum,sentrum). 
cmpl(byen,[trondheim],trondheim). 
cmpl(byens,sentrum,sentrum). 
cmpl(byneset,kirke,byneset_kirke). 
cmpl(byneset,krk,byneset_kirke). 
cmpl(byå,['+',sen],byåsen). 
cmpl(byå,sen,byåsen).  %%byå+senslip
cmpl(byåsen,[butikk,senter],byåsen_butikksenter). 
cmpl(byåsen,kjøpesenter,byåsen_butikksenter). %% TA-101123

cmpl(byåsen,skole, byåsen_skole).      
cmpl(byåsen,barneskole, byåsen_skole).  
cmpl(byåsen,ungdomsskole,  byåsen_skole).

cmpl(byåsen,vgs,       byåsen_videregående_skole). 

cmpl(byåsen,[v,g,skole], byåsen_videregående_skole).     %% TA-110610  byåsen v.g skole 
cmpl(byåsen,[v,'.',g,skole], byåsen_videregående_skole). %% nec ? 


cmpl(byåsen,[vgs,skole],   byåsen_videregående_skole). %% 
cmpl(byåsen,videregående,  hallset). %% byåsen_videregående_skole). %% neib gets lower priority than byåsen skole
cmpl(byåsen,[videregående,skole],   byåsen_videregående_skole). %%

cmpl(byåsen,butikksenter,byåsen_butikksenter). 
cmpl(byåsen,senter,byåsen_butikksenter). 
cmpl(byåsen,senteret,byåsen_butikksenter). 
cmpl(byåsen,ugla,ugla). 
cmpl(byåsen,vei,byåsveien). %% ?
cmpl(byåsen,veien,byås_street).  %%
cmpl(byåsenbutikk,senter,byåsen_butikksenter). 
%% cmpl(byåsenvideregående,skole,byåsen_skole). %% migosenteret). %% RS-131117
cmpl(byåsenvideregående,skole,byåsen_videregående_skole). %% migosenteret). %% RS-131117

cmpl(boechmans,vei,bøckmansveien). % n
cmpl(bøckmannsv,[],bøckmansveien). %% TA-110314
cmpl(bockmannsv,[],bøckmansveien). %% ad hoc 
cmpl(bøchmanns,vei,bøckmansveien). 
cmpl(bøckmans,veg,bøckmansveien). 
cmpl(bøckmans,vei,bøckmansveien). 
cmpl(bøkmans,vei,bøckmansveien). 

cmpl(bøndernes,salgslag,gartnerhallen). 

cmpl(c,[j,hambrosvei],c_j_hambros_vei). 
cmpl(c,[hambros,vei],c_j_hambros_vei). 
cmpl(c,[j,hambros,veg],c_j_hambros_vei). 
cmpl(c,[j,hambros,vei],c_j_hambros_vei). 
cmpl(c,[lund,kirke],charlottenlund_kirke).
cmpl(c,[skjetnans,veg],carl_schjetnans_vei). 
cmpl(c,[skjetnans,vei],carl_schjetnans_vei).  %% problem
cmpl(c,[thoresens,vei],cecilie_thoresens_veg). 
cmpl(c,thoresensveg,cecilie_thoresens_veg). 
cmpl(c,thoresensvei,cecilie_thoresens_veg). 

cmpl(carl,johan,carl_johans_street). %% TA-101006
cmpl(carl,[hambros,vei],c_j_hambros_vei). 
cmpl(carl,[j,hambros,veg],c_j_hambros_vei). 
cmpl(carl,[j,hambros,vei],c_j_hambros_vei). 
cmpl(hambrosv,[],c_j_hambros_vei). 

cmpl(campus,lade,ntnu_lade). 
cmpl(carl,[schjetnans,veg],carl_schjetnans_vei). 
cmpl(carl,[schjetnans,veg],carl_schjetnans_vei).  %%
cmpl(carl,[schjetnans,vei],carl_schjetnans_vei).  %%problem
cmpl(carl,[sjetnans,veg],carl_schjetnans_vei). 
cmpl(carl,schjetnansveg,carl_schjetnans_vei). 
cmpl(carl,schjetnansveg,carl_schjetnans_vei).  %%
cmpl(carl,schjetnansvei,carl_schjetnans_vei).  %%problem
cmpl(casper,[lundes,v],casper_lundes_veg). 
cmpl(casper,[lundes,vei],casper_lundes_veg). 
cmpl(casper,[lunds,vei],casper_lundes_veg). 
cmpl(casper,lundesvei,casper_lundes_veg). 
cmpl(casperlundes,v,casper_lundes_veg). 
cmpl(casperlundes,veg,casper_lundes_veg). 
cmpl(casperlundes,vei,casper_lundes_veg). 
cmpl(center,[of,the,city],sentrum).  %%Thesentrum
cmpl(center,[of,trondheim],sentrum).  %%Thesentrum
cmpl(central,[bus,station],hovedterminalen). 
cmpl(central,[train,station],ts). %% syn ts  %% TA-110225
cmpl(central,station,ts). %% syn ts  

%%%%% cmpl(central,terminal,hovedterminalen).  %% NB AMBIGUOUS %% TA-110224
               %% (ts) central station = central terminal = hovedterminalen *
                               
%%% cmpl(central,terminus,hovedterminalen). 


cmpl(ch,[lund,kirke],charlottenlund_kirke). 
cmpl(ch,[lund,skole],charlottenlund_skole). 
cmpl(ch,kirke,charlottenlund_kirke).
cmpl(ch,lund,charlottenlund). 
cmpl(cha,kirke,charlottenlund_kirke). %%  ?
cmpl(charlotten,lund,charlottenlund). 
cmpl(charlotten,[lund,nedre],charlottenlund_nedre). 
cmpl(charlottenlund,[ung,skole],charlottenlund_videregående). %?
cmpl(charlottenlund,[vgs],  charlottenlund_videregående). %% %% RS-150912, etter klage fra nettet.
cmpl(charlottenlund,[vgs,skole],  charlottenlund_videregående). %% %% RS-150912, etter klage fra nettet.
cmpl(charlottenlund,videregående, charlottenlund_videregående). %% byåsen_videregående_skole). %% neib gets lower priority than byåsen skole
cmpl(charlottenlund,[videregående,skole], charlottenlund_videregående). %% RS-150912, etter klage fra nettet.
cmpl(charlottenlund,[videresende], charlottenlund_videregående). %% RS-160108, julejobbing, pappaperm for Ken
cmpl(charlottenlund,[videresende,skole], charlottenlund_videregående). %% RS-160108, julejobbing, pappaperm for Ken
cmpl(charlottenlundvideresende,[], charlottenlund_videregående). %% RS-160108, julejobbing, pappaperm for Ken
cmpl(charlottenlund,[øvre],skovgård). 
cmpl(charlottenlund,hallen,charlottenlundhallen). 
cmpl(charlottenlund,n,charlottenlund_nedre). 
cmpl(charlottenlund,skole,charlottenlund_skole). 
cmpl(charlottenlund,ungdomsskole,charlottenlund_skole). 
cmpl(charlottenlund,videregående,charlottenlund_videregående). 
cmpl(chlund,kirke,charlottenlund_kirke).  
cmpl(chr,[eggens,veg],chr_eggens_veg).  %% Street
cmpl(christian,[eggens,veg],chr_eggens_veg).  %%S treet
cmpl(christian,hjelstrupsvei,christian_jelstrups_v). 
cmpl(christian,[jelstrups,veg],christian_jelstrups_v). 
cmpl(christiansten,festning,festningen). 
%% cmpl(christmas,eve,christmas).  %% eng -> dict_e
cmpl(churchills,veg,churchills_veg).  %% (NEC!)
cmpl(churchills,vei,churchills_veg). 
cmpl(churchillsvei,[],churchills_veg). 
cmpl(churtshill,gate,churchills_veg). 


cmpl(cirkus,shopping,sirkus_shopping). %% RS-130120 Spellcheck?

cmpl(city,syd,city_syd). %% TA-110627 %% NB city syd no longer aut. generated
cmpl(citi,syd,city_syd). 
cmpl(city,['-',syd],city_syd). 
cmpl(city,['/',syd],city_syd). 

cmpl(city,ade,lade_idrettsanlegg). 

cmpl(city,dyd,city_syd).
cmpl(city,std,city_syd). 

cmpl(city,center,hovedterminalen).  %% Difficult case
cmpl(city,centre,hovedterminalen).  %% Anglicism
cmpl(city,centrum,hovedterminalen). 
cmpl(city,senter,hovedterminalen).  %%  ? 
cmpl(city,[s,id],city_syd).  %% city sid
cmpl(city,[syd,e,6],city_syd).  %%
cmpl(city,[syd,e6],city_syd).  %%forced e6
cmpl(city,[syd,tiller],city_syd). 
cmpl(city,[syde,6],city_syd).  %% City Syd E6
cmpl(city,cyd,city_syd). 
cmpl(city,lade,lade_idrettsanlegg).  %% station
cmpl(city,sydpå,city_syd). 
cmpl(cj,[hambros,veg],c_j_hambros_vei). 
cmpl(cj,[hambros,vei],c_j_hambros_vei). %nec??
cmpl(cj,hambros,c_j_hambros_vei). 
cmpl(cj,hambrosv,c_j_hambros_vei). 
cmpl(cj,hambrosvei,c_j_hambros_vei). 
cmpl(cl,[lund,kirke],charlottenlund_kirke). 

cmpl(clairon,[],clarion_hotell). %% RS-150913 Common Typo
cmpl(clarion,[],clarion_hotell). %% RS-150913
cmpl(clarion,hotell,clarion_hotell). %% RS-150913

cmpl(c,[holst,s,veg],clara_holsts_veg). 
cmpl(c,[holst,s,vei],clara_holsts_veg). 
cmpl(c,[holst,veg],clara_holsts_veg). 
cmpl(c,[holst,vei],clara_holsts_veg). 
cmpl(c,[holsts,v],clara_holsts_veg). 
cmpl(c,[holsts,veg],clara_holsts_veg). 
cmpl(c,[holsts,vei],clara_holsts_veg). 
cmpl(c,[holstsv],clara_holsts_veg). 
cmpl(c,[holstsveg],clara_holsts_veg). 
cmpl(c,[holstsvei],clara_holsts_veg). 
cmpl(c,holstsv,clara_holsts_veg). 

cmpl(clara,[holst,s,veg],clara_holsts_veg). 
cmpl(clara,[holst,s,vei],clara_holsts_veg). 
cmpl(clara,[holst,veg],clara_holsts_veg). 
cmpl(clara,[holst,vei],clara_holsts_veg). 
cmpl(clara,[holsts,v],clara_holsts_veg). 
cmpl(clara,[holsts,veg],clara_holsts_veg). 
cmpl(clara,[holsts,vei],clara_holsts_veg). 
cmpl(clara,[holstsveg],clara_holsts_veg). 
cmpl(clara,[holstsvei],clara_holsts_veg). 
cmpl(clara,holst,clara_holsts_veg). 
cmpl(clara,holts,clara_holsts_veg). 
cmpl(clara,holsts,clara_holsts_veg). 
cmpl(clara,holstsv,clara_holsts_veg). 

cmpl(comfort,[hotel,park],'Comfort Hotel Park'). 

cmpl(cruise,pier,pirbadet).
cmpl(cruise,port,pirbadet). 
cmpl(curtshill,gate,churchills_veg). 
cmpl(cyti,syd,city_syd). 


%cmpl(d,[1],d1). %% RS-150815 Experiment. TA-11xxxx moved to prelex?
%cmpl(d,[2],d2). 
%%cmpl(d,[3],d3). 
%%cmpl(d,[4],d4).
%cmpl(d,[1],dr_gate_d1). %% RS-150815 Experiment, but put longest matches first!!
%cmpl(d,[2],dr_gate_d2). 
%%cmpl(d,[3],dr_gate_d3). 
%%cmpl(d,[4],dr_gate_d4).
cmpl(d,[l,øverlidsv],distriktslege_øverlids_vei). 
cmpl(d,[l,øvrelidsv],distriktslege_øverlids_vei). 
cmpl(d,gt,dronningens_gate).  %% \+ dv(dragvoll)aliasdv_street
cmpl(dagen,hageby,dalen_hageby). 
cmpl(dahls,bryggeri,strandveikaia). 
cmpl(dalen,['/',hageby],dalen_hageby). 
cmpl(dalen,[hage,by],dalen_hageby). 
cmpl(dalenhage,[by],dalen_hageby). 
cmpl(dalgård,skole,'Dalgård skole'). 
cmpl(dalgård,stien,dalgårdstien). 
cmpl(dals,[aune,veien],dalsauneveien).  %%  
cmpl(den,[sjuendes],vii).  %% Ad Hoc H7
cmpl(devle,gård,devlegård). 
cmpl(din,bil,'Din bil'). 
cmpl(diplom,is,iskremfabrikken). 
cmpl(dist,[lege,øvrelids,v],distriktslege_øverlids_vei).  %%in catalog
cmpl(distr,[lege,øvrelids,vei],distriktslege_øverlids_vei). % etc. 
cmpl(distriktslege,[øverlids,veg],distriktslege_øverlids_vei). 
cmpl(distriktslege,[øverlids,vei],distriktslege_øverlids_vei). 
cmpl(distriktslege,[øvrelids,vei],distriktslege_øverlids_vei). 
cmpl(distriktslege,øverlidsv,distriktslege_øverlids_vei). %etc. 
cmpl(disttriktlege,[øverlids,veg],distriktslege_øverlids_vei).  %% (2 spells)
cmpl(ditlevbloms,vei,ditlev_bloms_vei).  %%(#=>generalcollaps_)
cmpl(dokk,kaia,solsiden). 
cmpl(dokk,parken,solsiden). 
cmpl(dokkparken,solsiden,solsiden).  %%
cmpl(dons,vei,carl_dons_street). 

cmpl(dora,1,dora). %% Dora 1 station 
cmpl(dora,2,dora).  %% 

cmpl(dora,bowlingsenter,dora_1). 
cmpl(dora,bowling,dora_1). 
cmpl(dora,i,dora_1). 

%% cmpl(dora,[1],nidelv_bru). 
%% cmpl(dora,[2],nidelv_bru). 
%% cmpl(dora,[3],nidelv_bru).
%% cmpl(dora,ii,dora). 

cmpl(down,town,hovedterminalen). 
cmpl(downtown,trondheim,hovedterminalen). 

cmpl(dr,[sand,veg],dr_sands_street). %% trouble

cmpl(dr,[gate],dronningens_gate). 
cmpl(dr,gt,dronningens_gate). 
cmpl(dr,gt,dronningens_gate). 
cmpl(dra,voll,dragvoll). 
cmpl(dragvo,ll,dragvoll).    %% dragvo¨ll?

cmpl(dragvoll,campus,dragvoll).
cmpl(dragvoll,gård,lohove).  %% (?)
cmpl(dragvoll,høgskole,dragvoll). 
cmpl(dragvoll,høyskole,dragvoll).  %%. . . AVH. . . 
cmpl(dragvoll,idrettssenter,dragvoll).  %%?
cmpl(dragvoll,ntnu,dragvoll). 
cmpl(dragvoll,universitet,dragvoll).  %% universitetet_dragvoll???

cmpl(dronn,[gt,d1],dr_gate_d1).  %% Because it is your (AtB) abbrev.
cmpl(dronn,[gt,d2],dr_gate_d2). 
%cmpl(dronn,[gt,d3],dr_gate_d3). 
%cmpl(dronn,[gt,d4],dr_gate_d4).
%cmpl(dronn,[gt,d1],dronningens_gate_d1).  %% Because it is your (AtB) abbrev. RS-150815 Old station name (from 2014)
%cmpl(dronn,[gt,d2],dronningens_gate_d2). 
%%cmpl(dronn,[gt,d3],dronningens_gate_d3). 
%%cmpl(dronn,[gt,d4],dronningens_gate_d4). 
cmpl(dronn,gt,dronningens_gate).  %%Asyouspeak,

cmpl(dronning,[mauds,høgskole],dalen_hageby). 
cmpl(dronning,[mauds,institutt],dalen_hageby). 
cmpl(dronning,[mauds,minne,høgskole],dalen_hageby). 
cmpl(dronning,[mauds,minne],dalen_hageby). 
cmpl(dronning,[maudsminne,høgskole],dalen_hageby). 
cmpl(dronning,[maudsminne,høyskole],dalen_hageby). 
cmpl(dronning,[maud,minne,skole],dalen_hageby). 

cmpl(dronning,gt,dronningens_gate). 
cmpl(dronning,maud,dalen_hageby). 
cmpl(dronning,[s,gate],dronningens_gate).


cmpl(dronningens,gata,dronningens_gate). %% RS-150815. How do these work?
cmpl(dronningens,gate,dronningens_gate). 
cmpl(dronningens,gate,hovedterminalen). 


cmpl(dronningens,[gate,d,1],dr_gate_d1). 
cmpl(dronningens,[gate,d,2],dr_gate_d2). 
%cmpl(dronningens,[gate,d,3],dr_gate_d3). 
%cmpl(dronningens,[gate,d,4],dr_gate_d4). 

cmpl(dronningens,[gate,d1],dr_gate_d1). %% if not split  %% TA-11xxxx ??
cmpl(dronningens,[gate,d2],dr_gate_d2). 
%cmpl(dronningens,[gate,d3],dr_gate_d3). 
%cmpl(dronningens,[gate,d4],dr_gate_d4). 

cmpl(dronningens,[gate,holdeplass,d,1],dr_gate_d1). 
cmpl(dronningens,[gate,holdeplass,d,2],dronningens_gate_d2). 
%cmpl(dronningens,[gate,holdeplass,d,3],dronningens_gate_d3). 
%cmpl(dronningens,[gate,holdeplass,d,4],dronningens_gate_d4). 

cmpl(dronningens,[gate,holdeplass,d1],dr_gate_d1). %% d 1 -> d1 is prelexed
cmpl(dronningens,[gate,holdeplass,d2],dronningens_gate_d2). %% ugly ?
%cmpl(dronningens,[gate,holdeplass,d3],dronningens_gate_d3).
%cmpl(dronningens,[gate,holdeplass,d4],dronningens_gate_d4). 

cmpl(dronningens,gt,dronningens_gate).  %% RS-150815. How do these work?

cmpl(dronningens,[gt,d,1],dr_gate_d1). 
cmpl(dronningens,[gt,d,2],dr_gate_d2). 
%cmpl(dronningens,[gt,d,3],dr_gate_d3). 
%cmpl(dronningens,[gt,d,4],dr_gate_d4). 

%cmpl(dronningens,[gt,d1],dr_gate_d1). %% if not split  %% TA-11xxxx ??
%cmpl(dronningens,[gt,d2],dr_gate_d2).  
%%cmpl(dronningens,[gt,d3],dr_gate_d3). 
%%cmpl(dronningens,[gt,d4],dr_gate_d4). 


cmpl(dronningensgate,[d,1],dr_gate_d1). %% TA-101026
cmpl(dronningensgate,[d,2],dr_gate_d2). 
%cmpl(dronningensgate,[d,3],dr_gate_d3). 
%cmpl(dronningensgate,[d,4],dr_gate_d4). 

cmpl(dronningensgate,[holdeplass,d,1],dr_gate_d1). 
cmpl(dronningensgate,[holdeplass,d,2],dr_gate_d2). 
%cmpl(dronningensgate,[holdeplass,d,3],dr_gate_d3). 
%cmpl(dronningensgate,[holdeplass,d,4],dr_gate_d4). 

cmpl(dronningensgate,[d1],dr_gate_d1). %% if not split
cmpl(dronningensgate,[d2],dr_gate_d2). 
%cmpl(dronningensgate,[d3],dr_gate_d3). 
%cmpl(dronningensgate,[d4],dr_gate_d4). 

cmpl(dronningensgate,[holdeplass,d1],dr_gate_d1). 
cmpl(dronningensgate,[holdeplass,d2],dr_gate_d2). 
%cmpl(dronningensgate,[holdeplass,d3],dr_gate_d3). 
%cmpl(dronningensgate,[holdeplass,d4],dr_gate_d4). 

cmpl(dronningmauds,[minne,høyskole],dalen_hageby). 
cmpl(dronningmauds,[minne,høyskole],dalen_hageby). 
cmpl(dronnings,gate,dronningens_gate). 
cmpl(dv,dragvoll,dv).        %% presented as DV(Dragvoll)

cmpl(dybdahls,v,dybdahls_veg).  %% summer/ vinter: dybdals_veg %% TA-110704
cmpl(dybdahls,veg,dybdahls_veg).  %%
cmpl(dybdahls,vegen,dybdahls_veg).  %%

%cmpl(dyre,[halses,gate],nidelv_bru).  %% ? ad hoc
%cmpl(dyre,[halses,gt],nidelv_bru).    %%
%cmpl(dyre,halsesgate,nidelv_bru).   
%cmpl(dyre,[halses,gate],buran).  %% ? RS-150111. Less ad hoc?
%cmpl(dyre,[halses,gt],buran).    %%
%cmpl(dyre,halsesgate,buran).   %% new stop named Dyre Halses gate

cmpl(dødens,dal,høyskoleringen). 
cmpl(e,['-',verket],e_verket). %telehas'-'


cmpl(e,[b,schieldropsvei],edgar_b_schieldrops_street). %% Special, only 1 letter allowed
                                                       %% street
cmpl(edgar,[b],edgar_b_schieldrops_veg).  %% TA-100924 ...                                                    

cmpl(e,[b,scheldrupsvei],edgar_b_schieldrops_veg). 
cmpl(e,[b,schieldrops,v],edgar_b_schieldrops_veg). 
cmpl(e,[b,schieldrops,veg],edgar_b_schieldrops_veg). 
cmpl(e,[b,schieldrops,vei],edgar_b_schieldrops_veg). 
cmpl(e,[b,schieldropsv],edgar_b_schieldrops_veg). 
cmpl(e,[b,schieldropsveg],edgar_b_schieldrops_veg). 
cmpl(e,[b,schieldropsveg],edgar_b_schieldrops_veg). 
cmpl(e,[b,schieldropsvei],edgar_b_schieldrops_veg). 
cmpl(e,[b,schildropsveg],edgar_b_schieldrops_veg). 
cmpl(e,[b,schildropsvei],edgar_b_schieldrops_veg). 
cmpl(e,[b,schjeldrups,vei],edgar_b_schieldrops_veg). 
cmpl(e,[b,shieldropsvei],edgar_b_schieldrops_veg). 

cmpl(e,[c,dahls], ec_dahls_bryggeri ).  %% RS-141110
cmpl(e,[c,dahls,bryggeri], strandveikaia).  %%
cmpl(e,[c,dahls,gate],e_c_dahls_street).   %% central


cmpl(e,berg,berg). 

cmpl(e,[brochs,gate],hesthagen).

cmpl(e,kraftverket,e_verket). 

cmpl(e,verk,e_verket). 
cmpl(e,verket,e_verket). 
cmpl(e6,sandmoen,sandmoen). 
cmpl(e6,veien,e6). 
cmpl(ea,smith,e_a_smith). 
cmpl(eb,[schieldrops,v],edgar_b_schieldrops_veg).    %% EH-030616
cmpl(eb,[schieldrops,veg],edgar_b_schieldrops_veg).  %% EH-030616
cmpl(eb,[schieldrops,vei],edgar_b_schieldrops_veg).  %% EH-030616
cmpl(eb,[schieldropsv],edgar_b_schieldrops_veg).     %% EH-030616
cmpl(eb,[schieldropsveg],edgar_b_schieldrops_veg).   %% EH-030616
cmpl(eb,[schieldropsvei],edgar_b_schieldrops_veg).   %% EH-030616

cmpl(ebbells,veg,arkitekt_ebbells_street).  
cmpl(ebbells,gate,arkitekt_ebbells_street).

cmpl(eberg,skole,'Eberg skole'). 
cmpl(ec,[dahls,bryggeri],strandveikaia).  %%
cmpl(ec,[dahls,gate],e_c_dahls_street).   %% central
cmpl(ec,[dahls,vei],e_c_dahls_street). 

cmpl(edg,[b,schieldrops,vei],edgar_b_schieldrops_veg). 
cmpl(edgar,[a,schieldropsvei],edgar_b_schieldrops_veg). 
cmpl(edgar,[b,scheldrups,gate],edgar_b_schieldrops_veg). 
cmpl(edgar,[b,scheldrups,veg],edgar_b_schieldrops_veg). 
cmpl(edgar,[b,schieldrops,v],edgar_b_schieldrops_veg). 
cmpl(edgar,[b,schieldrops,veg],edgar_b_schieldrops_veg). 
cmpl(edgar,[b,schieldrops,vei],edgar_b_schieldrops_veg). 
cmpl(edgar,[b,schieldropsv],edgar_b_schieldrops_veg). 
cmpl(edgar,[b,schieldropsveg],edgar_b_schieldrops_veg). 
cmpl(edgar,[b,schieldropsvei],edgar_b_schieldrops_veg). 
cmpl(edgar,[b,schieldropsvei],edgar_b_schieldrops_street).  %%?
cmpl(edgar,[b,schildropsvei],edgar_b_schieldrops_veg). 
cmpl(edgar,[b,schjeldrup],edgar_b_schieldrops_veg). 
cmpl(edgar,[b,schjeldrups,vei],edgar_b_schieldrops_veg). 
cmpl(edgar,[b,shcieldrops],e_b_shcieldrops_veg). 
cmpl(edgar,[b,sheldrops,veg],edgar_b_schieldrops_veg). 
cmpl(edgar,[b,shieldropsvei],edgar_b_schieldrops_veg). 
cmpl(edgar,[b,shieldrups,veg],edgar_b_schieldrops_veg). 
cmpl(edgar,[b,skieldroupsv],edgar_b_schieldrops_veg). 
cmpl(edgar,[b,skjeldrops,veg],edgar_b_schieldrops_veg). 
cmpl(edgar,[b,skjeldropsvei],edgar_b_schieldrops_veg). 
cmpl(edgar,[b,skjeldrups,veg],edgar_b_schieldrops_veg). 
cmpl(edgar,[b,skjeldrups,vei],edgar_b_schieldrops_veg). 
cmpl(edgar,[schieldrops,veg],edgar_b_schieldrops_veg). 
cmpl(edgar,[schieldrops,veg],edgar_b_schieldrops_veg). 
cmpl(edgar,[schieldrops,vei],edgar_b_schieldrops_veg). 
cmpl(edgar,[schieldropsv],edgar_b_schieldrops_veg). 


cmpl(edgar,b,edgar_b_schieldrops_veg). 

cmpl(edgar,schieldropsvei,edgar_b_schieldrops_veg).  %% Rule?

cmpl(eidsvolls,gate,jonsvannsveien).  %% (crossing)
cmpl(eidsvolls,gt,jonsvannsveien). 


%% EINAR TAMBARSKJELVES GATE

%% Problem: difficult to make composite partname synonym.

cmpl(e,[tamb,skj,gt],einar_tambarskjelves_gate). %% announced in buses 

cmpl(einar,tambertskjelversgt ,einar_tambarskjelves_gate).

cmpl(einar,tambarskjelvesgate,einar_tambarskjelves_gate).
%% cmpl(einar,tambardkjelvsgate,einar_tambarskjelves_gate). %% PROBLEM


cmpl(e,[tambar,gate],einar_tambarskjelves_gate). 

cmpl(e,tambaskjelves,einar_tambarskjelves_gate). 
                                               %% composite streets can drop 'gate'

cmpl(einar,tambarksje,einar_tambarskjelves_gate).  
cmpl(einar,[tambar,sk],einar_tambarskjelves_gate).  

cmpl(e,tambaskjelvergt,einar_tambarskjelves_gate).  
cmpl(e,[tamb,gt],einar_tambarskjelves_gate). 
cmpl(e,tambarkjelvesgate,einar_tambarskjelves_gate). 
cmpl(e,[tambarsk,gt],einar_tambarskjelves_gate). 
cmpl(e,[tambarskj,gate],einar_tambarskjelves_gate). 
cmpl(e,[tambarskj,gt],einar_tambarskjelves_gate). 
cmpl(e,[tambarskjelvars,gt],einar_tambarskjelves_gate). 
cmpl(e,[tambarskjelve],einar_tambarskjelves_gate). 
cmpl(e,[tambarskjelves,gate],einar_tambarskjelves_gate). 
cmpl(e,[tambarskjelves,gt],einar_tambarskjelves_gate). 
cmpl(e,tambarskjelvesgate,einar_tambarskjelves_gate). 
cmpl(e,tambarskjelvesgt,einar_tambarskjelves_gate). 

cmpl(e,tambarsk,einar_tambarskjelves_gate). 
cmpl(e,tambarskj,einar_tambarskjelves_gate). 
cmpl(e,tambarskjelvgate,einar_tambarskjelves_gate). 
cmpl(e,tambasjelvesg,einar_tambarskjelves_gate). 
cmpl(e,tamberskjelve,einar_tambarskjelves_gate).  

cmpl(einar,[t,gate],einar_tambarskjelves_gate).  %% avoid Ukjent gate: EinarTambarskj. gt

cmpl(einar,[tambar,skjelve,gate],einar_tambarskjelves_gate). 
cmpl(einar,[tambar,kjelves,gate],einar_tambarskjelves_gate). 
cmpl(einar,[tambar,kjelvesgate],einar_tambarskjelves_gate). 
cmpl(einar,[tambar,skjelvesgate],einar_tambarskjelves_gate). 

cmpl(einar,[tambar,skjelves,gate],einar_tambarskjelves_gate). 
cmpl(einar,[tambar,skjelves,gate],einar_tambarskjelves_gate).  
cmpl(einar,[tambar,skjelves,gt],einar_tambarskjelves_gate). 
cmpl(einar,[tambar,skjelvsgt],einar_tambarskjelves_gate). 
cmpl(einar,[tambarskj],einar_tambarskjelves_gate).
cmpl(einar,[tambarskj,gate],einar_tambarskjelves_gate). 
cmpl(einar,[tambarskj,gt],einar_tambarskjelves_gate). 
cmpl(einar,[tambarskjelvar,gate],einar_tambarskjelves_gate). 
cmpl(einar,[tambarskjelvar],einar_tambarskjelves_gate). 
cmpl(einar,[tambarskjelve],einar_tambarskjelves_gate). 
cmpl(einar,[tambarskjelves,gate],einar_tambarskjelves_gate). 
cmpl(einar,[tambarskjelves,gt],einar_tambarskjelves_gate). 
cmpl(einar,[tambarskjelves,vei],einar_tambarskjelves_gate). 
cmpl(einar,[tambarskjelves],einar_tambarskjelves_gate). 
cmpl(einar,[tambarskjelvesgate],einar_tambarskjelves_gate). 
cmpl(einar,[tambarskjelvgate],einar_tambarskjelves_gate). 
cmpl(einar,[tamber,skjelves,gate],einar_tambarskjelves_gate). 
cmpl(einar,t,einar_tambarskjelves_gate). 
cmpl(einar,tam,einar_tambarskjelves_gate). 
cmpl(einar,tamb,einar_tambarskjelves_gate). 
cmpl(einar,tambar,einar_tambarskjelves_gate). 
cmpl(einar,tambarselvgt,einar_tambarskjelves_gate). 
cmpl(einar,tambarsjelvesgt,einar_tambarskjelves_gate). 
cmpl(einar,tambarsjelvsgt,einar_tambarskjelves_gate). 
cmpl(einar,tambarsjkelvsgate,einar_tambarskjelves_gate). 
cmpl(einar,tambarskelvarsgate,einar_tambarskjelves_gate). 
cmpl(einar,tambarskjgt,einar_tambarskjelves_gate). 
cmpl(einar,tambasjelvsgate,einar_tambarskjelves_gate).  %%
cmpl(einar,tambersjelvsgt,einar_tambarskjelves_gate). 
cmpl(einar,tamberskjeldsgate,einar_tambarskjelves_gate). 
cmpl(einar,tamberskjelve,einar_tambarskjelves_gate). 
cmpl(einar,tamberskjelvesgate,einar_tambarskjelves_gate). 
cmpl(einar,tambergskjelvesgate,einar_tambarskjelves_gate). %% -> station\+ street
cmpl(einar,tambur,einar_tambarskjelves_gate). 
cmpl(einar,tambursjelvesgate,einar_tambarskjelves_gate). 

cmpl(einartambarskjelves,gate,einar_tambarskjelves_gate). 
cmpl(einartambatskjeves,gate,einar_tambarskjelves_gate).

cmpl(etambarskjelves,gate,einar_tambarskjelves_gate). 


cmpl(tambar,[skjelves,gt],einar_tambarskjelves_gate). %% For the sport of it
cmpl(tambar,[kjelves,gt],einar_tambarskjelves_gate). %% etc 

cmpl(tambarsjelves,gt,einar_tambarskjelves_gate). 
cmpl(tambarskj,gate,einar_tambarskjelves_gate). 
cmpl(tambarskj,gt,einar_tambarskjelves_gate). 
%%%%%  cmpl(tambarskjelves,gate,einar_tambarskjelves_gate). %% blocks einat t....

cmpl(tambarskjelves,gate,einar_tambarskjelves_gate). %% NEC %% TA-110110
cmpl(tambarskjelves,gt,einar_tambarskjelves_gate). 

%% Einar T


cmpl(einar,æfstisv,einar_øfstis_veg). 

cmpl(elgeseter,bru,studentersamfundet). 
% cmpl(elgeseter,gata,elgeseter).  %% (no spell on gata)

cmpl(elgeseter,gate,hesthagen). 
%% cmpl(elgeseter,gt,elgeseter). 
%% cmpl(elgseter,[gt],elgeseter). 
cmpl(elgseter,bru,studentersamfundet). 
cmpl(elgsæter,bru,studentersamfundet). 
cmpl(elgsæter,gata,hesthagen). 
cmpl(elgsæter,gt,hesthagen). 
cmpl(endeholdeplass,vestlia,vestlia_endeholdeplass). 
cmpl(engelbrektssons,alle,olav_engelbrektssons_allé). %% AtB 
cmpl(engelbretsons,alle,olav_engelbrektssons_allé).  %% egt/ekt
cmpl(esso,motorhotell,esso_motorhotell).  %% Lazy complex

cmpl(europavei,6,e6). 
cmpl(e6,nardo,nardo_omkjøringsvei).


cmpl(erlingskakkes,gate,erling_skakkes_street). 
cmpl(erlingskakkes,[],erling_skakkes_street). 

cmpl(f,[b,wallems,vei],fredrik_b_wallems_street). 
cmpl(f,[nansens,vei],fritjof_nansens_street). 
cmpl(f,[nissens,v],fernanda_nissens_street).  %% Syndrome
cmpl(fagerheim,alle,fagerheim_alle). 
cmpl(fagerheim,allé,fagerheim_alle).  %% Necessary, because allé is a partname
cmpl(falkbergets,veg,johan_falkbergets_veg). 
cmpl(falkbergets,vei,johan_falkbergets_veg). 
cmpl(falkenborg,studentby,falkenborg). 
cmpl(fb,[wallems,vei],fredrik_b_wallems_street). 
cmpl(fengselet,[på,tunga],tunga_kretsfengsel). 
cmpl(fengselet,tunga,tunga_kretsfengsel). 

cmpl(ferjeleiet,[på,flakk],flakk). 
cmpl(ferjeleiet,flakk,flakk). 
cmpl(flakk,camping,flakk).
cmpl(flakk,ferge,flakk). %% not []
cmpl(flakk,[ferge,leie],flakk). 
cmpl(flakkferga,[],flakk). 
cmpl(flakkferge,[],flakk). 
cmpl(flakkfergen,[],flakk).

cmpl(flakk,ferjekai,flakk). 
cmpl(flakk,ferjeleie,flakk). 
cmpl(flakk,ferjeleiet,flakk).  %% unnec?
cmpl(flakk,kai,flakk). 
cmpl(flakk,rørvik,flakk).  %% Ferja
cmpl(flakkfergekai,[],flakk).
cmpl(flakkfergekaien,[],flakk).

cmpl(ferstad,street,nedre_ferstad_street).  %%  NB ferstad
cmpl(ferstad,street,øvre_ferstad_street).   %%
cmpl(festningens,gate,festningsgata).  %%
cmpl(festnings,parken,festningsparken).  
cmpl(fiol,svingen,fiolsvingen). 
cmpl(fla,tåsen,flatåsen).     %% å-trøbbel
cmpl(flat,['?',sen],flatåsen). 

cmpl(flatasen,[],flatåsen). %% e.g. fltasen %% TA-110331

cmpl(flat,åsen,flatåsen). 
%% cmpl(flatå,['+'],sen,flatåsen).  %% T-110310
cmpl(flatå,sen,flatåsen).  
cmpl(flatås,[toppen],flatåstoppen). 
cmpl(flatås,senteret,flatåsen_senter). 
cmpl(flatåsen,butikksenter,flatåsen_senter). 
cmpl(flatåsen,s,flatåsen_senter). 
cmpl(flatåsen,senteret,flatåsen_senter). 
cmpl(flatåsen,sentrum,flatåsen_senter).  %%(amb)
cmpl(flatåsen,skole,flatåsen_senter).  %%??2. choice
cmpl(flybuss,holdeplass,flybussterminalen). 
cmpl(fokus,hallen,vestre_rosten). 
cmpl(folkemuseet,sverresborg,trøndelag_folkemuseum).
cmpl(fosstueveien,[],fossestu_street). %% TA-110116 
cmpl(fr,[nansens,vei],fritjof_nansens_street). 
cmpl(fritjof,[nansens,gate],fridtjof_nansens_vei). 
cmpl(fritjof,[nansens,vei],fridjof_nansens_street). 
cmpl(fritjofnansens,vei,fritjof_nansens_street).  
cmpl(froderinnans,veg,frode_rinnans_street). 
cmpl(g,[krogh,s,veg],gina_krogs_veg). 
cmpl(g,[krogh,s,vei],gina_krogs_veg). 
cmpl(g,[krogh,veg],gina_krogs_veg). 
cmpl(g,[krogh,vei],gina_krogs_veg). 
cmpl(g,[kroghs,v],gina_krogs_veg). 
cmpl(g,[kroghs,veg],gina_krogs_veg). 
cmpl(g,[kroghs,vei],gina_krogs_veg). 
cmpl(g,[kroghsv],gina_krogs_veg). 
cmpl(g,[kroghsveg],gina_krogs_veg). 
cmpl(g,[kroghsvei],gina_krogs_veg). 
cmpl(g,kroghsv,gina_krogs_veg). 
cmpl(g,løshaugen,gløshaugen). 
cmpl(gaden,[og,larsen],strandveikaia). 
cmpl(gaden,larsen,stjørdals_street). 
cmpl(gaden,wist,stjørdals_street). 
cmpl(gamle,[elvehavn],nedre_elvehavn). 
cmpl(gamle,bru,bybro). 
cmpl(gamle,brua,bybro). 
cmpl(gamle,bybro,bybro). 
cmpl(gamle,bybro,bybro). 
cmpl(gamle,bybroen,bybro). 
cmpl(gamle,bybrua,bybro). 
cmpl(gamle,bybruen,bybro). 
%% cmpl(gamle,[kongens,vei],kongsvegen). %%   street
%% cmpl(gamle,kongevei,kongsvegen).      %% 
cmpl(gamle,nth,gløshaugen). 
cmpl(gamle,nth,prestegårdsjordet). 
cmpl(gamle,åsvei,gamle_ås_street).  %%Street!
cmpl(gamle,åsveien,gamle_ås_street). 
cmpl(gamlekonge,vei,kongsvegen). 
cmpl(gammel,lena,gammel_lina). 
cmpl(gammel,lian,gammel_lina). 
cmpl(gammel,line,gammel_lina). 
cmpl(gartner,hallen,gartnerhallen). 
cmpl(gartnerhallen,[på,tunga],gartnerhallen). 
cmpl(gartnerhallen,[tunga],gartnerhallen). 
cmpl(landbrukssenteret,[tunga],gartnerhallen). 
cmpl(gauldal,billag,gauldal_billag). 
cmpl(generalwibes,v,general_wibes_street). 
cmpl(gerhard,[schønings,skole],hovedterminalen). 
cmpl(gildevangen,hotell,søndregate). 
cmpl(gina,[krogh,s,veg],gina_krogs_veg). 
cmpl(gina,[krogh,s,vei],gina_krogs_veg). 
cmpl(gina,[krogh,veg],gina_krogs_veg). 
cmpl(gina,[krogh,vei],gina_krogs_veg). 
cmpl(gina,[kroghs,v],gina_krogs_veg). 
cmpl(gina,[kroghs,veg],gina_krogs_veg). 
cmpl(gina,[kroghs,vei],gina_krogs_veg). 
cmpl(gina,[kroghsveg],gina_krogs_veg). 
cmpl(gina,[kroghsvei],gina_krogs_veg). 
cmpl(gina,krog,gina_krogs_veg). 
cmpl(gina,krogh,gina_krogs_veg). 
cmpl(gina,kroghsv,gina_krogs_veg). 

cmpl(gl,['&',248,shaugen],gløshaugen). 
cmpl(gl,shaugen,gløshaugen).  %% æøåtrouble %%Gl;haugen

cmpl(gloeshaugen,[],gløshaugen). 
cmpl(gloeshaugen,ntnu,gløshaugen_nord). 
cmpl(gløs,haugen,gløshaugen). 
cmpl(gløshaugen,campus,gløshaugen). 

cmpl(gløshaugen,idrettssenter,høyskoleringen). 
cmpl(gløshaugen,[idretts,senter],høyskoleringen). %% nec %% TA-101110
cmpl(gløshaugen,n,gløshaugen_nord). 
cmpl(gløshaugen,nord,gløshaugen_nord). 
cmpl(gløshaugen,ntnu,gløshaugen_nord). 
cmpl(gløshaugen,s,gløshaugen). 
cmpl(gløshaugen,sør,gløshaugen). 
cmpl(godagers,[vei],alf_godagers_vei). 

cmpl(gods,nsb,terminalen).  %% godsterminalen_nsb -> terminalen (AtB)
cmpl(godsstasjonen,nsb,terminalen). 
cmpl(godst,nsb,terminalen). 
cmpl(gr,mølna,graaemølna). 
cmpl(graae,mølna,graaemølna). 
cmpl(granskogen,skole, kolstadhaugen). 
cmpl(granasen,vm,granåsen_vm_anlegget). 
cmpl(granåsen,[alpinsenter],granåsen_vm_anlegget).  %% \+ alpine though
cmpl(granåsen,[ski,anlegg],granåsen_vm_anlegget). 
cmpl(granåsen,[ski,arena],granåsen_vm_anlegget). 
cmpl(granåsen,[ski,senter],granåsen_vm_anlegget). 
cmpl(granåsen,[vm,anlegg],granåsen_vm_anlegget).  %%needshash
cmpl(granåsen,skianlegg,granåsen_vm_anlegget). 
cmpl(granåsen,skisenter,granåsen_vm_anlegget). 
cmpl(granåsen,skistadion,granåsen_vm_anlegget). 
cmpl(granåsen,skistadium,granåsen_vm_anlegget).
cmpl(granåsen,vm,granåsen_vm_anlegget). 
cmpl(granåsen,vmanlegg,granåsen_vm_anlegget). 
cmpl(granåsen,vmanlegget,granåsen_vm_anlegget). 
cmpl(granåsen,vmarena,granåsen_vm_anlegget). 
cmpl(grevskotts,vei,anton_grevskotts_vei).  %%Rulehere?
cmpl(grilstad,fjæra,grilstadfjæra). 
cmpl(gråe,mølle,graaemølna). 
cmpl(gråkall,banen,gråkallbanen). 
cmpl(gråkallen,skisenter,skistua).  %%?
cmpl(gudes,[gate],gudes_gate). 
cmpl(gudes,[vei],gudes_gate). 
cmpl(gudesgate,[],gudes_gate). 

%cmpl(h,[botners,v],harald_bothners_veg). 

cmpl(haakon,['7',gate,25],haakon_vii_gate_25). 
cmpl(haakon,['7s',gate,25],haakon_vii_gate_25). 
cmpl(haakon,['7s',gate],haakon_vii_gate_25). 
cmpl(haakon,[7,g],haakon_vii_gate). 
cmpl(haakon,[7,gate],haakon_vii_gate). 
cmpl(haakon,[7,gt],haakon_vii_gate).  %% a. s. o. . . . 
cmpl(haakon,[7,s,gate,25],haakon_vii_gate_25). 
cmpl(haakon,[7,s,gate],haakon_viis_street).  %% haakon7. s gate 8
cmpl(haakon,[den,'7s',gate],haakon_vii_gate_25). 
cmpl(haakon,[den,7,gate],haakon_vii_gate). 
cmpl(haakon,[den,7,gt],haakon_vii_gate). 
cmpl(haakon,[den,sjuendes,gate,25],haakon_vii_gate_25). 
cmpl(haakon,[den,sjuendes,gate],haakon_vii_gate). 
cmpl(haakon,[den,vii,gate],haakon_vii_gate). 
cmpl(haakon,[den,vii,gt],haakon_vii_gate). 
cmpl(haakon,[den,vii,s,gate],haakon_vii_gate). 
cmpl(haakon,[gate,vii],haakon_vii_gate). 
cmpl(haakon,[sjuendes,gate,25],haakon_vii_gate_25). 
cmpl(haakon,[sjuendes,gate],haakon_vii_gate). 
cmpl(haakon,[vii,gate],haakon_vii_gate). 
cmpl(haakon,[vii,gt],haakon_vii_gate). 
cmpl(haakon,[vii,s,g],haakon_vii_gate). 
cmpl(haakon,[vii,s,gate],haakon_vii_gate). 
cmpl(haakon,[vii,s,gt],haakon_vii_gate). 
cmpl(haakon,[vii,s,vei],haakon_vii_gate). 
cmpl(haakon,[vii,vei],haakon_vii_gate). 
cmpl(haakon,[viis,gate],haakon_vii_gate). 
cmpl(haakon,sjuendes,haakon_vii_gate). 
cmpl(haakon,viigt,haakon_vii_gate). 
cmpl(haakon7,gate,haakon_vii_gate). 
cmpl(haakon7gt,25,haakon_vii_gate_25). 
cmpl(haakonvii,[gate],haakon_vii_gate_25). 
cmpl(haakonvii,[s,gate],haakon_vii_gate). 
cmpl(haakonviigt,25,haakon_vii_gate_25). 

cmpl(hallfred,[h,veg],hallfred_høyems_vei). 
cmpl(hallfred,[høyems,veg],hallfred_høyems_vei).  %%vei
cmpl(hallfredhøyems,vei,hallfred_høyems_vei). 
cmpl(hallgrim,[høyems,vei],hallfred_høyems_vei). 
cmpl(hallset,[videregående,skole],hallset).  %% RS-150104. Discrepencies: 1 eller 2 l'er: søndre_halset 
cmpl(hallset,kirke,hallset).  %%???
cmpl(hallset,skole,hallset).  %%Østrehallsetvangen8
cmpl(hallstein,gård,halstein_gård). 
cmpl(hallstein,gården,halstein_gård). 
cmpl(halset,kirke,migosenteret). 
cmpl(halvor,[høyems,vei],hallfred_høyems_vei).  %% Extraservice
cmpl(hambros,v,c_j_hambros_vei).   %%  #-> unnec
cmpl(hambros,veg,c_j_hambros_vei). %%
cmpl(hambros,vei,c_j_hambros_vei). %%
cmpl(hans,[finnes,gate],hans_finnes_street). %% nec, ambig 
cmpl(hansfinnes,gate,hans_finnes_street). 
cmpl(hansfinnes,gt,hans_finnes_street). 
cmpl(hanskemakergata,[],hanskemakerbakken). %% TA-101013
cmpl(hanskemaker,bakken,hanskemakerbakken). 
cmpl(hanskemakker,bakken,hanskemakerbakken). 
%cmpl(harald,[bothners,vei],harald_bothners_veg). 
%cmpl(harald,bothnersvei,harald_bothners_veg). 
%cmpl(harald,[botners,vei],harald_bothners_veg). 
cmpl(harald,[høyems,vei],hallfred_høyems_vei). 
cmpl(harald,[ourens,vei],henrik_ourens_vei). 
cmpl(harald,hårfagres,harald_hårfagres_street). 
cmpl(harald,hårfarge,harald_hårfagres_street). 

cmpl(harald,[hardrådes,plass],harald_hardrådes_street). %% ? 
cmpl(harald,[hårdrådes,plass],harald_hardrådes_street). %%

cmpl(haugnes,[svingen],haugnessvingen).
cmpl(haukåsen,[psykiatriske,sykehus],haukåsen).
cmpl(haukåsen,sykehus,haukåsen).
cmpl(havstad,senter,havstadsenteret). %% TA-110316
cmpl(havstad,senteret,havstadsenteret).
cmpl(havstein,[i,byåsen],havstein). 
cmpl(havstein,kirke,havstadsenteret).  %% better than "u nderspecified kirke"
cmpl(heggstadmoen,[2],heggstadmoen_2).  %%(actual: 14 or 4 ?)
cmpl(heggstadmoen,[4],heggstadmoen_4).  %%(actual: 14 or 4 ?)
cmpl(heim,[dal],heimdal). 
cmpl(heimdal,['/',kolstad],kolstad).
cmpl(heimdal,[v,g,skole],saupstadsenteret). 
cmpl(heimdal,[videregående,skole],saupstadsenteret). 
cmpl(heimdal,kirke,heimdal_stasjon).  %% Kirkeringen
cmpl(heimdal,politistasjon,'Heimdal politistasjon').  %% EH-041004
cmpl(heimdal,sentralstasjon,heimdal_stasjon). 
%% cmpl(heimdal,sentrum,heimdal_stasjon). %% station 
cmpl(heimdal,skole,saupstadsenteret).  %% ( barneskole??? )
cmpl(heimdal,st,heimdal_stasjon). 
cmpl(heimdal,vdg,saupstadsenteret). 
cmpl(heimdal,vgs,saupstadsenteret). 


cmpl(hasselvika, kai, hysneset_kai).
cmpl(hassel, [vika, kai], hysneset_kai).
cmpl(hasselvik, kai, hysneset_kai).
cmpl(hassel, [vik, kai], hysneset_kai).

%%%  cmpl(heimdal,[videregående,skole],hvs). %% ? %% TA-110502


%% cmpl(heimdals,sentrum,heimdal_stasjon).   %% station  %% ( \+  spellc of legal names)
cmpl(hell,[bil,lade],jørgen_b_lysholms_vei). 
cmpl(hell,[bil],jørgen_b_lysholms_vei). 
cmpl(hell,togstasjon,hell). 
cmpl(hell,tågstasjon,hell).  %% no spc
cmpl(helse,[og,sosialhøgskolen],gildheim). % ?
cmpl(hemne,[og,orkdal,billag],hob). 
cmpl(henrik,[matisens,vei],henrik_mathiesens_street). 
cmpl(henrikourens,vei,henrik_ourens_vei).  
cmpl(hermankrags,vei,herman_krags_street). 
cmpl(hest,sjøen,hestsjøen). 
cmpl(hist,ahs,gildheim). 
cmpl(hist,aitel,hovedterminalen).        %%
cmpl(hist,alt,rotvoll_alle).    %% AtB
cmpl(hist,alu,rotvoll_nedre).   %% Avdelingfor Lærerutdanning
cmpl(hist,ammt,gartnerhallen).  %%
cmpl(hist,asp,rotvoll_nedre).   %%
cmpl(hist,rotvoll,rotvoll_nedre). 
cmpl(hist,tekn,hovedterminalen).  %%
cmpl(hist,tøh,østre_berg).  %%
cmpl(hoeggen,kirke,sollia). 
cmpl(holtermanns,gate,holtermannsveien). 
cmpl(holtermanns,veg,holtermannsveien). 
cmpl(holtermanns,vei,holtermannsveien). 
cmpl(hospital,kirka,hospitalskirka).  %% NB hospital<> i rutedb 
cmpl(hospital,kirken,hospitalskirka). 
cmpl(hospitals,kirka,hospitalskirka). 
cmpl(hospitals,kirken,hospitalskirka). 
cmpl(hospitals,løkkan,hospitalsløkkan). 
cmpl(hospitalsløkkan,kirke,hospitalskirka).

%% hotels...  See also a / b / c - hotell       %% RS-150913
cmpl(hotel,[royal,garden],royal_garden).   

cmpl(hotell,augustin,'Hotell Augustin'). 
cmpl(hotell,britannia,britannia_hotell). %% Flybussen 
cmpl(hotell,clarion,clarion_hotell). %% RS-150913
cmpl(hotell,[royal,garden],royal_garden). 
%cmpl(hotell,[scandic,ved,moholt],esso_motorhotell). %% OLD %% RS-150913
%cmpl(hotell,scandic,esso_motorhotell).

cmpl(hourens,vei,henrik_ourens_vei). 
cmpl(husbys,vei,odd_husbys_street). 
cmpl(huseby,[videregående,skole],saupstadsenteret). 
cmpl(huseby,bad,saupstadsenteret). 
cmpl(huseby,badet,saupstadsenteret). 
cmpl(huseby,hallen,husebyhallen). 
cmpl(huseby,skole,saupstadsenteret). 
cmpl(huseby,tunet,husebytunet). 
cmpl(huseby,videregående,saupstadsenteret). 
cmpl(håkon,['7',gate,25],haakon_vii_gate_25). 
cmpl(håkon,[7,s,gate],haakon_vii_gt). 
cmpl(håkon,[den,7,gate],haakon_viis_street).  %% <-- 
cmpl(hårstad,skole,koieflata).  %% Hølbekkveien 62
cmpl(høg,skoleringen,høyskoleringen). 
cmpl(høgskolen,[i,sør,trøndelag],hist). 
cmpl(høy,skoleringen,høyskoleringen). 
cmpl(høyems,[vei],hallfred_høyems_vei). 
cmpl(høyskole,ringen,høyskoleringen). 
cmpl(høyskolen,[i,sørtrøndelag],hist).      %%. . . på lade|rotvoll

cmpl(idrettsparken,jakobsli,jakobsli_idrettsplass).
cmpl(idrettsplassen,[],jakobsli_idrettsplass).
cmpl(idrettsplassen,jakobsli,jakobsli_idrettsplass).
cmpl(idr,plassen,jakobsli_idrettsplass).  %% I rutehefte (på stasjonen). %% RS-190101

cmpl(idrettsparken,jakobsli,idrettsplassen). 

cmpl(idrettsplass,jakobsli,jakobsli_idrettsplass). 
cmpl(idrettsplassen,[på,ranheim],ranheim_idrettsplass). 

cmpl(idretts,[senter],idrettssenter).  %% TA-101110 //nohelp

cmpl(idretts,[plass],idrettsplass).  %%  // nohelp

cmpl(idrettsbygget,[på,dragvoll],dragvoll). 
cmpl(idrettsbygget,[på,gløshaugen],høyskoleringen). 
cmpl(idrettsbygget,[ved,gløshaugen],høyskoleringen). 
cmpl(idrettsbygget,gløshaugen,høyskoleringen). 
cmpl(idrettsbygget,nth,høyskoleringen). 

cmpl(ikea,[på,leangen],ikea). 
cmpl(ikea,[leangen],ikea).
%% cmpl(ikea,buss,25).     %% -> buss 11
%% cmpl(ikea,bussen,25).   %% IKEA-bussen
%% cmpl(ikea,bussene,25).  %%
cmpl(ila,kirke,ila). 
cmpl(ila,park,ila). 
cmpl(ila,parken,ila). 
cmpl(ila,skole,skansen). 

cmpl(ofstadsveg,[],ingeborg_ofstads_vei). 
cmpl(ingeborgofstads,vei,ingeborg_ofstads_vei). 
cmpl(ingeborg,[hofstads,vei],ingeborg_ofstads_vei). %% Difficult > 2 names

cmpl(torps,vei,ingemann_torps_vei).

cmpl(ingemanntorps,vei,ingemann_torps_vei). 
cmpl(ingemanntorps,veg,ingemann_torps_street). %% NB ad hoc

cmpl(ingemann,torpsvei,ingemann_torps_vei). %%  Troublespot

cmpl(ingvald,ystadsveg,ingvald_ystgaards_street).
cmpl(ingvald,ystergaardsvei,ingvald_ystgaards_street). 
cmpl(ingvald,ystergårdsvei,ingvald_ystgaards_street). 
cmpl(ingvald,ystgårdsvei,ingvald_ystgaards_street). 
cmpl(inn,herredsveien,innherredsveien). 
cmpl(inner,city,hovedterminalen). %% TA-110106 E: innen ?
cmpl(innherreds,veg,innherredsveien). 
cmpl(innherreds,veien,innherredsveien). 
cmpl(iskrem,fabrikken,iskremfabrikken). 
cmpl(it,bygget,itbygget). 
cmpl(ivar,[lykkes,vei,1],melkekartongen). 
cmpl(ivar,[lykkesvei,1],melkekartongen). 

%cmpl(j,[aaesvei],john_aae_s_veg). 
%cmpl(j,[aaes,gate],john_aae_s_veg). 
%cmpl(j,[aaes,v],john_aae_s_veg). 
%cmpl(j,[aaes,vei],john_aae_s_veg). 
cmpl(j,[b,lysholmersv],jørgen_b_lysholms_vei). 
cmpl(j,[b,lysholms,vei],jørgen_b_lysholms_vei). 
cmpl(j,[b,lysholmsv],jørgen_b_lysholms_vei). 
cmpl(j,[b,lysholms_vei],jørgen_b_lysholms_vei). 
cmpl(j,[falkbergets,v],johan_falkbergets_veg). 
cmpl(j,[falkbergets,veg],johan_falkbergets_veg). 
cmpl(j,[h,l,vogts,vei],professor_j_h_l_vogts_street). 
cmpl(j,[h,vogts,vei],professor_j_h_l_vogts_street). 

cmpl(j,[kroglunds,vei], johan_p_kroglunds_veg). 
cmpl(j,[p,kroglundsvei], johan_p_kroglunds_veg). %% etc 
cmpl(j,[p,kroglunds,vei], johan_p_kroglunds_veg). 
cmpl(j,[p,kroglundsv], johan_p_kroglunds_veg). 

cmpl(j,[p,kroglundsvei], johan_p_kroglunds_veg). 
cmpl(john,[p,kroglundsvei], johan_p_kroglunds_veg). 

cmpl(j,falkberget,johan_falkbergets_veg). 
cmpl(j,falkbergetsvei,johan_falkbergets_veg). 
cmpl(j,tillersv,johan_tillers_vei).  %%Nøddef
cmpl(jakobsli,idrettsplass,jakobsli_idrettsplass). 
cmpl(jakobsli,idrettsplassen,jakobsli_idrettsplass). %% nec?

cmpl(jakobsli,n,jakobsliveien_nedre). 
cmpl(jakobsli,nedre,jakobsliveien_nedre). 
cmpl(jakobsli,[vegen,nedre],jakobsliveien_nedre).
cmpl(jakobslivegen,n,jakobsliveien_nedre). 
cmpl(jakobslivegen,nedre,jakobsliveien_nedre). 
cmpl(jakobslivegen,nedre,jakobsliveien_nedre).
cmpl(jakobslivenen,[nedre],jakobsliveien_nedre). %% ad hoc, probl.
cmpl(jakobslivn,n,jakobsliveien_nedre).  %% vn_nedre NB!


cmpl(jakobli,nedre,jakobsliveien_nedre). %% tricky place
cmpl(jakobli,[vegen,nedre],jakobsliveien_nedre).
cmpl(jakoblivegen,n,jakobsliveien_nedre). 
cmpl(jakoblivegen,nedre,jakobsliveien_nedre). 
cmpl(jakoblivegen,nedre,jakobsliveien_nedre).
cmpl(jakoblivenen,[nedre],jakobsliveien_nedre). %% ad hoc, probl. 
cmpl(jakoblivn,n,jakobsliveien_nedre).  %% vn_nedre NB!



cmpl(jakobsli,øvre,jakobslivegen_øvre). 
cmpl(jakobsliveien,øvre,jakobslivegen_øvre). 
cmpl(jakobslivegen,øvre,jakobslivegen_øvre). 
cmpl(jakobslivn,øvre,jakobslivegen_øvre).  %% nec 

cmpl(jakobli,øvre,jakobslivegen_øvre). 
cmpl(jakobliveien,øvre,jakobslivegen_øvre). 
cmpl(jakoblivegen,øvre,jakobslivegen_øvre). 
cmpl(jakoblivn,øvre,jakobslivegen_øvre).  %% nec


cmpl(jern,[bane,stasjon],ts).   %% AtB. 
cmpl(jern,[bane,stasjonen],ts). %% AtB. 
cmpl(jern,banestasjonen,ts).    %% AtB. 
cmpl(jernbane,st,ts).           %% AtB. 
cmpl(jernbane,stasjon,ts).      %% AtB. %% TA-110411
cmpl(jernbane,stasjonen,ts).    %% AtB. 
cmpl(jernbanestasj,onen,ts).    %% AtB.  

cmpl(jernbanestasjonen,[holdeplass,10],ts). 
cmpl(jo,[aalmos,gate],o_j_aalmos_street).  %% jo noisew
cmpl(jo,[aalmos,veg],o_j_aalmos_street).  %%
cmpl(jo,[aalmos,vei],o_j_aalmos_street).  %%
%cmpl(johan,[aaes,v],john_aae_s_veg). 
cmpl(johan,[falkberges,vei],johan_falkbergets_veg). 
cmpl(johan,[falkbergets,veg],johan_falkbergets_veg).  %%preferthestationforthestreet
cmpl(johan,[kroglunds,vei], johan_p_kroglunds_veg). 
cmpl(johan,[minsaas,vei],johannes_minsaas_veg). 
cmpl(johan,[p,kroglundsvei], johan_p_kroglunds_veg). 
cmpl(johan,falkberget,johan_falkbergets_veg). 
cmpl(johan,falkbergetsv,johan_falkbergets_veg). 
cmpl(johan,falkbergetsveg,johan_falkbergets_veg). 
cmpl(johan,falkbergetsvei,johan_falkbergets_veg). 
cmpl(johan,falkbergsveien,johan_falkbergets_veg). 
cmpl(johanfalkbergets,veg,johan_falkbergets_veg). 
cmpl(johanfalkbergets,vei,johan_falkbergets_veg). 
cmpl(johannes,[minsaa,s,veg],johannes_minsaas_veg).  %%'JohannesMinsaa`sveg'
%cmpl(john,[aae,s,veg],john_aae_s_veg). 
%cmpl(john,[aae,s,veg],john_aae_s_veg). 
%cmpl(john,[aae,s,vei],john_aae_s_veg).  %%(mapindex)
%cmpl(john,[aaes,veg],john_aae_s_veg). 
%cmpl(john,[aaesv],john_aae_s_veg).  %%(map)
%cmpl(john,[aaesvei],john_aae_s_veg). 
%cmpl(john,[aas,v],john_aae_s_veg). 
%cmpl(john,[aas,veg],john_aae_s_veg). 
%cmpl(john,[aas,vei],john_aae_s_veg). 
%cmpl(john,[aasv],john_aae_s_veg). 
%cmpl(john,[aasveg],john_aae_s_veg). 
%cmpl(john,[aasvei],john_aae_s_veg).  %%(mapindex)
cmpl(john,[p,kroglunds,veg], johan_p_kroglunds_veg). 
cmpl(john,[p,kroglundsvei], johan_p_kroglunds_veg). 
%cmpl(john,[åes,vei],john_aae_s_veg). 
%cmpl(john,[åsvei],john_aae_s_veg). 
%cmpl(john,aasensvei,john_aae_s_veg). 
cmpl(johnssons,vei,karl_jonssons_veg). %% k_jonssons_vei -> karl_jonssons_vei 
%cmpl(jon,[aaens,vei],john_aae_s_veg). 
%cmpl(jon,[aaes,vei],john_aae_s_veg). 
%cmpl(jon,[aaesgt],john_aae_s_veg). 
%cmpl(jon,[aas,vei],john_aae_s_veg). 
cmpl(jonssons,vei,karl_jonssons_veg). 
cmpl(jonsvann,vei,jonsvanns_street).  %%problem
cmpl(jonsvanns,vei,jonsvanns_street). 
cmpl(jonsvanns,vei,jonsvannsveien). 
cmpl(jp,[kroglunds,veg], johan_p_kroglunds_veg). 
cmpl(jp,[kroglunds,vei], johan_p_kroglunds_veg). 
cmpl(jp,[kroglundsv], johan_p_kroglunds_veg). 
cmpl(jp,[kroglundsveg], johan_p_kroglunds_veg). 
cmpl(jp,[kroglundsvei], johan_p_kroglunds_veg). 
cmpl(jørgen,[b,lysholmersvei],jørgen_b_lysholms_vei).
cmpl(jørgen,[lysholms,v],jørgen_b_lysholms_vei). 
cmpl(jørgen,[lysholms,veg],jørgen_b_lysholms_street).  %%
cmpl(jørgen,[lysholms,vei],jørgen_b_lysholms_vei). 
cmpl(jørgen,[lysholms_vei],jørgen_b_lysholms_street).  %% Problem (Både vei og busstopp!) %% RS-141122


cmpl(k,[1],kongens_gate_k1). %%RS-130812
cmpl(k,[2],kongens_gate_k2). 
cmpl(kong,[gt,k1],kongens_gate_k1).  %% Because it is your abbrev. 
cmpl(kong,[gt,k2],kongens_gate_k2). 
cmpl(kong,gt,kongens_gate).  %%Asyouspeak,


cmpl(k,[jonsons,veg],karl_jonssons_veg). 
cmpl(k,[o,thornæs,veg],k_o_thornæs_vei). 
cmpl(k,[o,thornæs_vei],k_o_thornæs_vei). 
cmpl(k,[o,thornæs_veieg],k_o_thornæs_vei). 
cmpl(k,[v,t],østre_rosten). 
cmpl(k,attem,kattem).  %% ?
cmpl(kalvskinnet,skole,nidarosdomen).
cmpl(kaptein,roosen,kaptein_roosens_street). 
cmpl(kaptein,roosens,kaptein_roosens_street). 

cmpl(karinelund,studentby,strinda_kirke). %% Brøsetv 149
%% cmpl(karl,[j,gate],carl_johans_street).  %% karl jonssons vei
cmpl(karl,[johnsensv],karl_jonssons_veg). 
cmpl(karl,[johnsons,gate],karl_jonssons_veg). 
cmpl(karl,[johnsons,veg],karl_jonssons_veg).  %% discrepancy > 1
cmpl(karl,[johnsonsv],karl_jonssons_veg). 
cmpl(karl,[johnsonsveg],karl_jonssons_veg). 
cmpl(karl,[johnsonsvei],karl_jonssons_veg). 
cmpl(karl,[jon,vei],karl_jonssons_veg).  %%?
cmpl(karl,[jonsons,gate],karl_jonssons_veg). 
cmpl(karl,[jonsons,vei],karl_jonssons_veg). 
cmpl(karl,[jonssons,veg],karl_jonssons_veg). 
cmpl(karl,[jonssons,vei],karl_jonssons_veg). 
cmpl(karl,[schjetnans,veg],carl_schjetnans_vei). 
cmpl(karl,jonsosvei,karl_jonssons_veg).  %% NEC ?
cmpl(karljohnsons,veg,karl_jonssons_veg). 

cmpl(kasperlundes,v,casper_lundes_veg). 
cmpl(kasperlundes,veg,casper_lundes_veg). 
cmpl(kattem,lundåsen,lundåsen_n). 
cmpl(kattem,s,kattemsenteret). 
cmpl(kattem,senter,kattemsenteret). 
cmpl(kattem,senteret,kattemsenteret). 
cmpl(kattem,skogen,kattemskogen).
cmpl(kattem,skole,kattemsenteret).  %%Uståsen6
cmpl(kbs,[kjøpe,senter],kbs_senteret).
cmpl(kbs,[leangen],kbs_senteret). 
cmpl(kbs,[på,leangen],kbs_senteret). 
cmpl(kbs,kjøpesenter,kbs_senteret). 
cmpl(kbs,senter,kbs_senteret). 
cmpl(kbs,senteret,kbs_senteret). 
cmpl(kbs,sentret,kbs_senteret). 
cmpl(kiellands,gate,alexander_kiellands_street). 
cmpl(kino,[på,nova],olav_tryggvasons_gate_ot2). 
cmpl(kino,nova,olav_tryggvasons_gate_ot2). 
cmpl(kinoene,[i,prinsengata],nidarosdomen). 
cmpl(kinoene,[i,prinsengate],nidarosdomen). 
cmpl(kinoene,[i,prinsens,gate],nidarosdomen). 
cmpl(kinoene,[i,prinsensgate],nidarosdomen). 
cmpl(kinosenteret,prinsen,nidarosdomen). 
cmpl(kjøpe,[senter],kjøpesenter).  %%(KBS)kjøpesenter
cmpl(kl,bu,klæbu).  %%kl'bu
cmpl(klæbu,[ruta],klæburuten). 
cmpl(klæbu,[ruten],klæburuten). 
cmpl(klæbu,kommunesenter,kommunesenteret). 
cmpl(klæbu,rådhus,kommunesenteret). %% is it a station ? 
cmpl(klæbusentrum,[],klæbu_sentrum). %% TA-101025
cmpl(klæbu,sentrum,klæbu_sentrum).%% AtB %% ? where 
cmpl(klæbu,skysstasjon,klæbu_skysstasjon). 
cmpl(ko,[thornæs,veg],k_o_thornæs_vei). 
cmpl(ko,thornesv,k_o_thornæs_vei). 
cmpl(ko,thornsensvei,k_o_thornæs_vei). 
cmpl(koie,flata,koieflata).  
cmpl(kolstad,['/',heimdal],kolstad).  %% names on bus 4
cmpl(kolstad,dalen,kolstaddalen). 
cmpl(kolstad,senter,casper_lundes_veg). 
cmpl(kolstad,skole,saupstadsenteret). 
cmpl(kolstad,toppen,kolstadhaugen). 
cmpl(kolstad,tunet,kolstadtunet). 
cmpl(kong,[haakon,7,gt],haakon_vii_gt).  %%a. s. o. . . . 
cmpl(kong,[inge,s,gate],kong_inges_street). 
cmpl(kong,[inges,gate],kong_inges_street). 
cmpl(kong,ingesgate,kong_inges_street).  



%cmpl(kong,[gt,k1],kongens_gate_k1).  %% Because it is your abbrev. %% RS-130812 ??
%cmpl(kong,[gt,k2],kongens_gate_k2). 

cmpl(kong,[gt],kongens_gate).  %% As you speak,
cmpl(kong,[s,gate],kongens_gate).

cmpl(kongens,[gate,holdeplass,k,1],kongens_gate_k1). 
cmpl(kongens,[gate,holdeplass,k,2],kongens_gate_k2). 

cmpl(kongens,[gate,holdeplass,k1],kongens_gate_k1). %% d 1 -> d1 is prelexed
cmpl(kongens,[gate,holdeplass,k2],kongens_gate_k2). %% ugly ?

cmpl(kongens,[gate,k,1],kongens_gate_k1). 
cmpl(kongens,[gate,k,2],kongens_gate_k2). 

%cmpl(kongens,[gate,k,1],kongens_gate_k1). 
%cmpl(kongens,[gate,k,2],kongens_gate_k2). 

cmpl(kongens,[gate,k1],kongens_gate_k1). %% if not split
cmpl(kongens,[gate,k2],kongens_gate_k2). 

cmpl(kongens,[gt,k,1],kongens_gate_k1). 
cmpl(kongens,[gt,k,2],kongens_gate_k2). 

cmpl(kongens,[gt,k1],kongens_gate_k1). 
cmpl(kongens,[gt,k2],kongens_gate_k2).  

cmpl(kongens,gata,kongens_gate). 
cmpl(kongens,gate,kongens_gate).
cmpl(kongens,gate,hovedterminalen).
cmpl(kongens,gt,kongens_gate). 

cmpl(kongensgate,[k,1],kongens_gate_k1). %% TA-101026
cmpl(kongensgate,[k,2],kongens_gate_k2). 

cmpl(kongensgate,[holdeplass,k,1],kongens_gate_k1). 
cmpl(kongensgate,[holdeplass,k,2],kongens_gate_k2). 

cmpl(kongensgate,[k1],kongens_gate_k1). %% if not split
cmpl(kongensgate,[k2],kongens_gate_k2). 

cmpl(kongensgate,[holdeplass,k1],kongens_gate_k1). 
cmpl(kongensgate,[holdeplass,k2],kongens_gate_k2). 
%% RS-130812

cmpl(kong,[sverres,gate],sverres_street). 
cmpl(kong,[øisteins,gt],kong_øysteins_veg). 
cmpl(kong,[øysteins,gate],kong_øysteins_veg). 
cmpl(kong,[øysteins,gt],kong_øysteins_veg). 
cmpl(kong,[øysteins,veg],kong_øysteins_veg). 
cmpl(kongøysteins,v,kong_øysteins_veg). 
cmpl(kongøysteins,veg,kong_øysteins_veg).  %%
cmpl(kongøysteins,vei,kong_øysteins_veg).  %%
cmpl(korsvika,alle,lade_gård).    
% cmpl(kr,[himmel,farts,dag],ascension_day).  %% -> dictn
cmpl(kr,marka,kroppanmarka). 
cmpl(kr,sand,kristiansand). 
cmpl(kr,sund,kristiansund). 
cmpl(kretsfengselet,tunga,tunga_kretsfengsel). 
% cmpl(kristelig,[himmelfarts,dag],ascension_day).  %%-> dictn
% cmpl(kristelig,himmelfartsdag,ascension_day). %%-> dictn
cmpl(kristen,[videregående,skole],østre_rosten). 
% cmpl(kristi,[himmelfarts,dag],ascension_day).  %%-> dictn
% cmpl(kristi,himmelfart,ascension_day).  %%-> dictn
% cmpl(kristi,himmelfartsdag,ascension_day).  %%-> dictn
cmpl(kristiansand,[s],kristiansand). 
cmpl(kristiansten,festning,festningen). 
cmpl(kristiansten,festningen,festningen). 
cmpl(kristiansund,[n],kristiansund). 
% cmpl(kristlig,[himmelfarts,dag],ascension_day).  %%-> dictn
% cmpl(kristlig,himmelfartsdag,ascension_day).  %%-> dictn
cmpl(kroppan,marka,kroppanmarka). 

cmpl(kroppanm,endeholdepl,kroppanmarka_snuplass).
cmpl(kroppanmarka,endeholdeplass,kroppanmarka_snuplass). 
cmpl(kroppanmarka,endehp,kroppanmarka_snuplass). 

cmpl(kroppan,bru,kroppanbrua). %% AtB fall 2011 %% TA-110809
%

cmpl(kroppans,bru,kroppan_bru). 
cmpl(kvilhaugen,gård,kvilhaugen). 
cmpl(kvt,[city,syd],østre_rosten). 
cmpl(kvt,vgs,østre_rosten). 

%% cmpl(lade,[arena],haakon_vii_gate_9). %cmpl(lade,[arena],haakon_vii_gate_25).  %% Navnebytte?  %% RS-141122 
cmpl(lade,[arena],lade_arena).
cmpl(lade,80,lade_allé_80). 
%%%%%% cmpl(lade,[all,e],lade_alle_80). 
cmpl(lade,[jarlen,vgs],ladejarlen_v_g_s). 
cmpl(lade,[v,g,skole],lade_gård). 
cmpl(lade,[vg,skole],lade_gård). 
cmpl(lade,[videregående],lade_gård). 

%% cmpl(lade,alle,lade_alle_80).  %% By request from M. Erichsen,27. 2. 2002
cmpl(lade,alle,lade_alle). %% AtB      



cmpl(lade,alle80,lade_allé_80). %% AtB 
cmpl(lade,city,lade_idrettsanlegg). 
cmpl(lade,senter,lade_idrettsanlegg).
cmpl(lade,torg,lade_idrettsanlegg). %% ? 
cmpl(lade,gaard,lade_gård). 
cmpl(lade,går,lade_gård).  
cmpl(lade,hammeren,ladehammeren). 
cmpl(lade,jarlen,ladejarlen_v_g_s). 
cmpl(lade,kapell,ingemann_torps_vei). 
cmpl(lade,ntnu,ntnu_lade). 
cmpl(lade,obs,lade_idrettsanlegg). 
cmpl(lade,skole,krutthusbakken). 
cmpl(lade,teknopark,ladeveien). 
cmpl(lade,universitet,ntnu_lade). 
cmpl(lade,university,ntnu_lade). 
cmpl(lade,vei,lade_alle). 
cmpl(ladeh,[v,g,skole],ladejarlen_v_g_s). 
cmpl(ladeh,[vg,skole],ladejarlen_v_g_s). 
cmpl(ladeh,skole,ladejarlen_v_g_s). 
cmpl(ladehammeren,[maritime,skoler],ladejarlen_v_g_s). 
cmpl(ladehammeren,skole,ladejarlen_v_g_s).
cmpl(ladehhammeren,[v,g,skole],ladejarlen_v_g_s). 
cmpl(ladehhammeren,[vg,skole],ladejarlen_v_g_s).
cmpl(ladejarlen,skole,ladejarlen_v_g_s).  
cmpl(ladejarlen,[v,g,s],ladejarlen_v_g_s).
cmpl(ladejarlen,[vdg,skole],ladejarlen_v_g_s). 
cmpl(ladejarlen,[videregående,skole],ladejarlen_v_g_s). 
cmpl(ladejarlen,[videregående],ladejarlen_v_g_s). 
cmpl(lademoen,kirke,lademoen_kirke). 
cmpl(lademoen,postkontor,buran). 
cmpl(lademoen,skole,buran). 
cmpl(lademoen,skole,lademoen_skole). 
cmpl(lauritz,gate,lauritz_jenssens_street). 
cmpl(le,ythenhaven,leuthenhaven).  %%u:problem
cmpl(leangen,[is,hall],bromstadsvingen). 
cmpl(leangen,[trav,bane],travbanen). 
cmpl(leangen,hallen,leangenhallen).
cmpl(leangen,idrettshall,bromstadsvingen). 
cmpl(leangen,ishall,bromstadsvingen). 
cmpl(leangen,postkontor,leangen_allé). %% AtB 
cmpl(leangen,skøytebane,bromstadsvingen). 
cmpl(leangen,stadion,bromstadsvingen). 
cmpl(leangen,travbane,travbanen). 
cmpl(leangen,travbanen,travbanen). 
cmpl(leif,[erickson,senter],pirbadet). 
cmpl(leif,[erikson,senter],pirbadet).
cmpl(leiftronstads,vei,leif_tronstads_street).
cmpl(nedre,[humle,haug],nedre_humlehaugen_vest).
cmpl(nedre,[humlehaugen],nedre_humlehaugen_vest).
cmpl(n,[humlehaugen],nedre_humlehaugen_vest).
cmpl(nedre,[leir,foss],nedre_leirfoss). 

cmpl(leiebeua,[],leirbrua_gård). %% RS-150913 Typo
cmpl(leira,fengsel,leira_skole).  %% bratsbergvegen 189
cmpl(leira,gartneri,leira_skole). 
cmpl(leirbrua,går,leirbrua_gård).

cmpl(leirnua,gård,leirbrua_gård). 

cmpl(leiv,[erikson,senter],pirbadet). 
cmpl(leiv,[erikson,senteret],pirbadet).

cmpl(lerchendal,gaard,lerkendal_gård). 
cmpl(lerchendal,stadion,lerkendal_stadion). 
cmpl(lerken,[dal,stadion],lerkendal_stadion). 
cmpl(lerken,dal,lerkendal_stadion). 
cmpl(lerkendal,gaard,lerkendal_gård). 
cmpl(lerkendal,går,lerkendal_gård). 
cmpl(lerkendal,gård,lerkendal_gård). 
cmpl(lerkendal,st,lerkendal_stadion). 
cmpl(lerkendal,stadium,lerkendal_stadion). 
cmpl(lerkendal,stasjon,lerkendal_stadion). 
cmpl(lerkendal,station,lerkendal_stadion).   %% staTion
%% cmpl(lerkendal,staton,lerkendal_stadion).    %% stasjon=TS %% TA-110406 names
cmpl(lerkendal,studentby,prestegårsjordet).  %% (ikkegårds)
cmpl(lerkendals,veien,lerkendalsvegen). 
cmpl(lille,rydningen,lillerydningen). 
cmpl(lilleby,skole,'Lilleby skole').
cmpl(lillebyskole,[],'Lilleby skole').
 


cmpl(loholt,alle,loholt_alle). 
cmpl(louisenlyst,gård,louisenlyst). 
cmpl(luftkrigs,skolen,luftkrigsskolen). 
cmpl(lundamo,auto,løvaasveien). 
cmpl(lundå,sen,lundåsen_n).  %% ?

cmpl(lundåsen,[n],lundåsen_n). 
cmpl(lundåsen,[nedre],lundåsen_n). 
cmpl(lundåsen,[nord],lundåsen_n).  
cmpl(lundåsen,[nordre],lundåsen_n). 

cmpl(lykkens,portal,bybro). 
cmpl(lysholms,street,jørgen_b_lysholms_vei). 
cmpl(lærerhøgskolen,[på,rotvoll],rotvoll_nedre). 
cmpl(lærerskolen,[på,rotvoll],rotvoll_nedre). 
cmpl(løkken,verk,løkken). 

cmpl(m,[0,holt],moholt). %% TA-100824   Tricky

cmpl(m,0,hovedterminalen). 
cmpl(m,[1],hovedterminalen). 
cmpl(m,[2],hovedterminalen). 
cmpl(m,[3],hovedterminalen). 
cmpl(m,[4],hovedterminalen). 
cmpl(m,[5],hovedterminalen). 
cmpl(m,[berrføtts,vei],magnus_berrføtts_veg). %% NB changed Hastus <- magnus_berføttsvei
cmpl(m,[gt],hovedterminalen). 
cmpl(m,[kregnes,veg],martin_kregnes_veg). 
cmpl(m,berføttsvei,magnus_berrføtts_veg). 
cmpl(m,thranesvei,marcus_thranes_vei).  %%Nøddef
cmpl(m,tranesgt,marcus_thranes_vei).  %%adhoc
cmpl(m,unkegt,hovedterminalen). 
cmpl(magnus,[barfots,veg],magnus_berrføtts_veg). 
cmpl(magnus,[berrfots,veg],magnus_berrføtts_veg). 
cmpl(magnus,[berrføtts,veg],magnus_berrføtts_veg). 
cmpl(magnus,[blindes],magnus_blindes_vei). 
cmpl(magnus,[den,blinde],magnus_blindes_vei). 
cmpl(magnus,[den,blindes,gt],magnus_blindes_vei).  %%etc
cmpl(magnus,[den,blindes,vei],magnus_blindes_vei). 
cmpl(magnus,barfotsvei,magnus_berrføtts_veg). 
cmpl(magnus,barføtesveg,magnus_berrføtts_veg). 
cmpl(magnus,berrføttsv,magnus_berrføtts_veg). 
cmpl(magnus,bærføtsvei,magnus_berrføtts_veg). 
cmpl(magnus,bærføttsvei,magnus_berrføtts_veg). 
cmpl(magnus,bærrføtsv,magnus_berrføtts_veg). 
cmpl(magnus,bærrføtsvei,magnus_berrføtts_veg). 
cmpl(magnus,bærrføttsvei,magnus_berrføtts_veg). 

cmpl(magnus,[godes,gate],magnus_den_godes_street). 

cmpl(magnusberrføtts,vei,magnus_berrføtts_veg). 
cmpl(main,station,hovedterminalen). 
cmpl(malvik,kommune,malvik).
%cmpl(malvik,[videregående,skole],malvik_vgs).
cmpl(malvik,[videregående,skole],malvik_vgs).
cmpl(marien,[borg],marienborg). 
cmpl(mariesørdals,veg,marie_sørdals_veg). 
cmpl(marin,[teknisk,senter,tyholt],magnus_berrføtts_veg). 
cmpl(marin,[teknisk,senter],magnus_berrføtts_veg). 
cmpl(marintek,[],magnus_berrføtts_veg). 
cmpl(marinteknisk,[senter,tyholt],magnus_berrføtts_veg). 
cmpl(marinteknisk,senter,magnus_berrføtts_veg). 
cmpl(maritimt,senter,ladejarlen_v_g_s).  %%ikke marintek

%% cmpl(market,place,torget).  %% English Lang disamb %% I am in a place

cmpl(kregnes,veg,martin_kregnes_veg).
cmpl(martinkregnes,vei,martin_kregnes_veg). 
cmpl(martinkregnesveg,[],martin_kregnes_veg).
cmpl(martinkrengnesveg,[],martin_kregnes_veg).
cmpl(martinkregnesvei,[],martin_kregnes_veg). 
cmpl(martinkrengnesvei,[],martin_kregnes_veg). 

cmpl(martinstokkens,vei,martin_stokkens_street). 
cmpl(maskin,agentur,maskinagentur). 
cmpl(maskinagentur,rosten,maskinagentur). 
cmpl(melhus,[],melhus_sentrum ).  %%Street//MappingProblem %% RS-150815
cmpl(mellom,ila,mellomila).  %%Street//MappingProblem
 %% cmpl(mellomv,[5],mellomv_5). 
 %% cmpl(mellomvegen,[5],mellomv_5). 
 %% cmpl(mellomveien,[2],mellomv_5). 
 %% cmpl(mellomveien,[4],mellomv_5). 
 %% cmpl(mellomveien,[5],mellomv_5). 
 %% cmpl(mellomvn,[5],mellomv_5). 
cmpl(mid,town,sentrum). 
cmpl(midt,['-',byen],hovedterminalen). 
cmpl(midt,[i,byen],hovedterminalen).  
cmpl(midt,byen,hovedterminalen). 
cmpl(midt,byn,sentrum). 
cmpl(midtby,n,sentrum).  %%(ikkemidtbyen!)
cmpl(midtbyen,['/',sentrum],sentrum). 
cmpl(midtre,[gauldal,billag],gauldal_billag). 
cmpl(midtre,[gauldal],midtre_gauldal). 
cmpl(migo,senteret,hallset).  %%Lazy
cmpl(mnk,gata,hovedterminalen). 
cmpl(mnk,gate,hovedterminalen). 
cmpl(mnk,gaten,hovedterminalen). 
cmpl(mnk,gt,hovedterminalen). 
cmpl(mo,[holt,student,by],moholt_studentby). 
cmpl(mo,[holt,studentby],moholt_studentby). 
cmpl(mo,[i,rana],mo_i_rana). 
cmpl(mo,holt,moholt). 
cmpl(moholt,kirke,strinda_kirke). %%  NB changed
cmpl(moholt,krysset,moholtkrysset). 
cmpl(moholt,[st,by],moholt_studentby). 
cmpl(moholt,[stud,by],moholt_studentby). 
cmpl(moholt,[student,by],moholt_studentby). 
cmpl(moholt,[student,city],moholt_studentby).
cmpl(moholt,[student,village],moholt_studentby). 
cmpl(moholt,studentbyen,moholt_studentby). 
cmpl(moholt,alle,moholt).  %% ???

cmpl(moholtstorsenter,[],moholt_storsenter).  
cmpl(moholt,center,moholt_storsenter).  
cmpl(moholt,kjøpesenter,moholt_storsenter). 
cmpl(moholt,senter,moholt_storsenter). 
cmpl(moholt,senteret,moholt_storsenter). 
cmpl(moholt,storsenter,moholt_storsenter). 

cmpl(moholt,terasse,moholt). 
cmpl(moholt,tun,moholttun). 
cmpl(moholt,tunet,moholttun). 
cmpl(moholts,studentby,moholt_studentby). 
cmpl(moholtsenter,[],moholt_storsenter). 
cmpl(moholtstudent,by,moholt_studentby). 
cmpl(molt,myra,moltmyra).
cmpl(molte,myra,moltmyra).
cmpl(motor,trade,'Motor Trade'). %% (Bil verksted) Nardo
cmpl(monsens,gt,chr_monsensgt). 
cmpl(morsets,vei,peder_morsets_vei). 
cmpl(munk,[voll,gård],munkvoll_gård). 
cmpl(munk,gt,hovedterminalen). 
cmpl(munke,gata,hovedterminalen).  %% Touchy
cmpl(munke,gate,hovedterminalen). 
cmpl(munke,gaten,hovedterminalen).  %% Street Sentrum-> m0
cmpl(munke,gt,hovedterminalen). 
cmpl(munkega,ta,hovedterminalen). 

cmpl(munkvoll,går,munkvoll_gård). 
cmpl(munkvoll,gård,munkvoll_gård). 
cmpl(munkvoll,sykehjem,hallset).  %% selsbakkveien 28
cmpl(music,[museum],ringve_museum). 
cmpl(musikk,[museum],ringve_museum). 
cmpl(møllenberg,nedre,nedre_møllenberg). 
cmpl(møllenberg,øvre,gyldenløves_gate). %% \+ sig bergs
cmpl(møller,[bil,as],møller_bil). 
%%%%% cmpl(møller,bil,granåsveien).  %% haakon_vii_gate_25). 
cmpl(møller,bil,møller_bil). 
cmpl(møller,trondheim,møller_bil). 
cmpl(møre,[og,romsdal],møre_og_romsdal). 
cmpl(n,[elvehavn],nedre_elvehavn). 
cmpl(n,[ilevollen],nordre_ilevolden). 
%cmpl(n,[t,h],gløshaugen). 
cmpl(n,[t,n,u],ntnu). 
cmpl(n,charlottenlund,charlottenlund_nedre). 
cmpl(n,leirfoss,nedre_leirfoss). 
cmpl(naf,senteret,naf). 
cmpl(nardo,[krysset],nardokrysset). 
cmpl(nardo,fotballbane,fiolsvingen).
cmpl(nardo,banen,fiolsvingen). 
cmpl(nardo,bil,travbanen).  %% Tungaveien 2
cmpl(nardo,centeret,nardosenteret). 
cmpl(nardo,centre,nardosenteret). 
cmpl(nardo,centret,nardosenteret). 
cmpl(nardo,senter,nardosenteret). 
cmpl(nardo,senteret,nardosenteret). 

cmpl(nardo,skole,nardokrysset). %% ? Fiosvingen ? %% TA-110516

cmpl(nedre,bakklandet,bakkegata). 
cmpl(nedre,byåsen,byåsen). 
cmpl(nedre,[charlotten,lund],charlottenlund_nedre). 
cmpl(nedre,[charlotten,lund],charlottenlund_nedre). 
cmpl(nedre,charlottenlund,charlottenlund_nedre). 
cmpl(nedre,chlund,charlottenlund_nedre). 
cmpl(nedre,[elve,havn],nedre_elvehavn). 
cmpl(nedre,[elvehavn],nedre_elvehavn). 
cmpl(nedre,[elvehavnen],nedre_elvehavn). 
cmpl(nedre,flatåsen,søndre_flatåsen).  %% ?
cmpl(nedre,flatåssenteret,flatåsen_senter). 
cmpl(nedre,hallset,nordre_halset).
cmpl(nedre,hallsetvei,nordre_hallset_street). 
cmpl(nedre,hoem,nordre_hoem). 
cmpl(nedre,[jakobsli,veg],jakobsliveien_nedre). 
cmpl(nedre,[jakobsli,vei],jakobsliveien_nedre). 
cmpl(nedre,jakobsli,jakobsliveien_nedre). 
cmpl(nedre,jakobsliv,jakobsliveien_nedre). 
cmpl(nedre,jakobsliveg,jakobsliveien_nedre). 
cmpl(nedre,jakobslivei,jakobsliveien_nedre). 
cmpl(nedre,jakobsliveien,jakobsliveien_nedre). 
cmpl(nedre,leirfossen,nedre_leirfoss). 
cmpl(nedre,[lundåsen],lundåsen_n). 
cmpl(nedre,møllenberg,nedre_møllenberg). 
cmpl(nedre,[møllenberg,gate],nedre_møllenberg_street). 
cmpl(nedre,[møllenbergs,gate],nedre_møllenberg_street). 
cmpl(nedre,[møllenbergsgate],nedre_møllenberg_street). 
cmpl(nedre,møllenberggate,nedre_møllenberg_street). 
cmpl(nedre,møllenberggt,nedre_møllenberg_street). 
cmpl(nedre,romolslia,romolslia_nedre). 
cmpl(nedre,rotvoll,rotvoll_nedre). 
cmpl(nedre,singsaker,jonsvannsveien).  
cmpl(nedre,sjettenhaugen,nedre_sjetnhaugan).  %%->streetafter5. 3. 07
cmpl(nedre,sjettnhaugen,nedre_sjetnhaugan).  %%
cmpl(nedre,skovgård, skovgård).  %% RS-160110
%% cmpl(nedre,tverreggen,tverregga).  %% nordre=Nordre 
cmpl(nedre,vikåsen,vikåsen_nedre). 
%% cmpl(new,york,new_york). %% TA-110603
cmpl(ngu,[på,lade],n_g_u). 

cmpl(9,muser,'Ni muser').  %% trouble
cmpl(ni,muser,'Ni muser'). %%

cmpl(nidar,as,sjokoladefabrikken). 
cmpl(nidar,bergene,strindheim). 
cmpl(nidar,fabrikker,strindheim). 
cmpl(nidar,hallen,trondheim_spektrum). 
cmpl(nidar,sjokoladefabrikk,sjokoladefabrikken). 
cmpl(nidaros,cathedral,domkirken).  %% (prins. kinos. unødvendig)
cmpl(nidaros,domen,domkirken).  
cmpl(nidaros,kirke,domkirken). 
cmpl(nidarvoll,sykeheim,nygård). 
cmpl(nidarvoll,sykehjem,nygård). 
cmpl(nidarø,hallen,trondheim_spektrum). 
cmpl(nidelv,[hallen],nidelvhallen). 
cmpl(nidelven,bru,nidelv_bru). 
cmpl(nidelven,skole,nidarosdomen).
cmpl(niels,[abels,gt],abels_street). 

cmpl(nord,california,california). %% rough ad hoc
cmpl(nord,norge,nordnorge). 
cmpl(nord,odal,odalen).   %% rough 

cmpl(nordre,halset,nordre_halset).

cmpl(nordre,[hoem],nordre_hoem).  %% Tramstation
cmpl(nordre,[lundåsen],lundåsen_n). 
cmpl(nordre,gløshaugen,gløshaugen_nord). 
cmpl(nordre,hallset,nordre_halset).  %% \+ spellc to halset
cmpl(nordre,leirfoss,nedre_leirfoss).  %% is actually north
cmpl(nordslettevegen,[],nordslettveien). 
cmpl(nordslettvegen,[],nordslettveien). 
%% cmpl(nordslettveien,snuplass,nordslettv_snuplass).  %% OBS sperrer nordslett vegen

cmpl(norges,[teknisk,naturvitenskapelige,universitet],ntnu). 
cmpl(norges,[tekniske,høgskole],nth). 
cmpl(norges,[tekniske,universitet],nth). 


cmpl(nova,kino,olav_tryggvasons_gate_ot2). 
cmpl(nov,kino,olav_tryggvasons_gate_ot2). 
cmpl(nov,kinosenter,olav_tryggvasons_gate_ot2). %% avoid november %% TA-101012
cmpl(noa,kino,olav_tryggvasons_gate_ot2). 
cmpl(noa,kinosenter,olav_tryggvasons_gate_ot2). 

cmpl(norske,meierier,norske_meierier). %% no longer station %% TA-110705

cmpl(kino,novasenter,olav_tryggvasons_gate_ot2).  %% :-) 

cmpl(nr1,[],gråkallbanen). 
cmpl(nrk,[på,tyholt],strinda_vgs). 
cmpl(nrk,tyholt,nrk). 
cmpl(nsb,gods,terminalen). 

cmpl(nth,[på,gløshaugen],gløshaugen).      %% RS-170623. Sommerruter not passing gløshaugen directly
cmpl(nth,gløshaugen,gløshaugen). 
cmpl(nth,nord,gløshaugen_nord). 
cmpl(nth,sør,gløshaugen). 

%cmpl(nth,[på,gløshaugen],prestegårdsjordet). 
%cmpl(nth,gløshaugen,prestegårdsjordet). 
%cmpl(nth,nord,prestegårdsjordet). 
%cmpl(nth,sør,prestegårdsjordet).
%cmpl(ntnu,[på,gløshaugen],prestegårdsjordet). 
%cmpl(ntnu,[at,gløshaugen],prestegårdsjordet). 
%cmpl(ntnu,[gløshaugen,sør],prestegårdsjordet). 
%cmpl(ntnu,[gløshaugen,nord],prestegårdsjordet). 
%cmpl(ntnu,gloeshaugen,prestegårdsjordet). 
%cmpl(ntnu,gløshaug,prestegårdsjordet). 
%cmpl(ntnu,gløshaugen,prestegårdsjordet). 
%cmpl(ntnu,n,prestegårdsjordet). 
%cmpl(ntnu,nord,prestegårdsjordet). 
%cmpl(ntnu,s,prestegårdsjordet). 
%cmpl(ntnu,sør,prestegårdsjordet). 

cmpl(ntnu,[på,gløshaugen],gløshaugen). 
cmpl(ntnu,[at,gløshaugen],gløshaugen). 
cmpl(ntnu,[gløshaugen,sør],gløshaugen). 
cmpl(ntnu,[gløshaugen,nord],gløshaugen_nord). 
cmpl(ntnu,gloeshaugen,gløshaugen_nord). 
cmpl(ntnu,gløshaug,gløshaugen_nord). 
cmpl(ntnu,gløshaugen,gløshaugen_nord). 
cmpl(ntnu,n,gløshaugen_nord). 
cmpl(ntnu,nord,gløshaugen_nord). 
cmpl(ntnu,s,gløshaugen). 
cmpl(ntnu,sør,gløshaugen). 

cmpl(ntnu,[at,lade],ntnu_lade). 
cmpl(ntnu,[at,lade],ntnu_lade). 
cmpl(ntnu,[på,dragvoll],dragvoll). 
cmpl(ntnu,[på,lade],ntnu_lade). 
cmpl(ntnu,[på,lade],ntnu_lade). 
cmpl(ntnu,dragvoll,ntnu_dragvoll). 
cmpl(ntnu,lade,ntnu_lade). 
cmpl(nyborg,skole,nyborg). 
cmpl(nyg,ård,nygård).  %%Nygård
cmpl(nygards,street,olav_nygards_street).  %% Streets must be tagged as street
cmpl(nypvang,skole,leinstrand). 
cmpl(nyvei,bakken,nyveibakken). 
cmpl(næringsakademiet,trondheim,bakkegata). %% 

cmpl(o,[almos,v],o_j_aalmos_street). 
cmpl(o,[almos,vei],o_j_aalmos_street). 
cmpl(o,[engebr,alle],olav_engelbrektssons_allé). 
cmpl(o,[j,almaasvei],o_j_aalmos_street). 
cmpl(o,[nygards,street],olav_nygards_street). 
cmpl(o,[trygvassons,gt],olav_tryggvasons_gate_ot1). %% changed from olav_trygvassons_gt 
%% cmpl(obs,'!',lade_idrettsanlegg). %% confuse %% TA-110116
cmpl(obs,['!',lade],lade_idrettsanlegg). 
cmpl(obs,lade,lade_idrettsanlegg).  %% TA-100914
cmpl(obs,[på,city,syd],city_syd). 
cmpl(obs,[på,lade],lade_idrettsanlegg).  %% (should avoid obs (and) on lade!)
cmpl(obs,[ved,lade],lade_idrettsanlegg). 
cmpl(odense,vegen,odenseveien). 
cmpl(odd,brochmannsgate,odd_brochmanns_street). 
cmpl(odd,brochmannsveg,odd_brochmanns_street). 
cmpl(odd,brochmannsvei,odd_brochmanns_street). 
cmpl(okstad,plassen,okstadplassen).  %% street
cmpl(okstad,skole,okstad_skole).  %% Okstadvegen 6 = Okstad
cmpl(okstad,østre,okstad_østre). 
cmpl(okstadskole,[],okstad_skole).  %% Okstadvegen 6 = Okstad %% RS-130915

cmpl(okstad,ø,okstad_østre).  %% TA-110125 NB, %% RS-140614 Ikke OkstadØy!

cmpl(ola,[seterums,vei],ola_setroms_vei). 
cmpl(ola,[setroms,veg],ola_setroms_vei). 
cmpl(ola,[setroms,veg],ola_setroms_vei). 
cmpl(ola,[setrums,veg],ola_setroms_vei). 
cmpl(ola,[setrums,vei],ola_setroms_vei). 
cmpl(ola,[sætres,veg],ola_setroms_vei). 
cmpl(ola,[sætres,veg],ola_setroms_vei). 
cmpl(ola,[sætrums,veg],ola_setroms_vei).  %% (disc>1)
cmpl(ola,setrumsv,ola_setroms_vei). 
cmpl(olaf,[tryggvassonsgate],olav_tryggvasons_gate_ot1).  %% local mis

cmpl(olafbulls,veg,olaf_bulls_vei).
cmpl(olav,[bulls,v],olaf_bulls_vei).    %% (ErroronMap)
cmpl(olav,[bulls,vei],olaf_bulls_vei).  %% (ErroronMap)
cmpl(olav,[engel,brektssons,alle],olav_engelbrektssons_allé). 
cmpl(olav,[engelbregtsens,alle],olav_engelbrektssons_allé). 
cmpl(olav,[engelbregtsons,alle],olav_engelbrektssons_allé). 
cmpl(olav,[engelbrektsons,alle],olav_engelbrektssons_allé). 

cmpl(olav,[engelbrektsons,gate],olav_engelbrektssons_allé). 
/*
cmpl(olav,[engelbrektssons,gate],olav_engelbrektssons_alle).  %% Problem spot
cmpl(olav,[engelbrektssons,v],   olav_engelbrektssons_alle).  %% Problem spot
cmpl(olav,[engelbrektssons,veg],olav_engelbrektssons_alle). 
cmpl(olav,[engelbrektssons,vei],olav_engelbrektssons_alle). 
*/

cmpl(olav,[engelbretssons,alle],olav_engelbrektssons_allé). 
cmpl(olav,[tryggvas,onsgate],olav_tryggvasons_gate_ot1). 
cmpl(olav,[tryggvasons,gate],olav_tryggvasons_gate_ot1). 
cmpl(olav,engebrektsgate,olav_engelbrektssons_allé). 
cmpl(olav,engelbregtsalle,olav_engelbrektssons_allé). 
cmpl(olav,engelbrektssonsgate,olav_engelbrektssons_allé). 
cmpl(olav,kyrres,olav_kyrres_street). 
cmpl(olav,nygaardsvei,olav_nygårds_vei). 
cmpl(olav,nygård,olav_nygårds_vei).
cmpl(olav,[t,gate],olav_tryggvasons_gate_ot1). 
cmpl(olav,tryggvasons,olav_tryggvasons_gate_ot1). 
cmpl(olav,tryggvasonsgt,olav_tryggvasons_gate_ot1). 
cmpl(olav,trygvasonsgate,olav_tryggvasons_gate_ot1). 
cmpl(olav,trygvasonsgt,olav_tryggvasons_gate_ot1). 
cmpl(olavengelbreksons,alle,olav_engelbrektssons_allé). 
cmpl(olavnygårds,vei,olav_nygårds_vei).
%% cmpl(olavs,gate,st_olavs_gate).  %% //confuse //irrelevant street
cmpl(olavs,gt,st_olavs_gate).    %%
cmpl(olavs,kvartalet,olavskvartalet). 
cmpl(olavs,hospital,st_olavs_hospital). 
cmpl(olavtryggvasons,gate,olav_tryggvasons_gate_ot1). 



cmpl(olavtrygvasonsgate,[],olav_tryggvasons_gate_ot1). 

cmpl(olavtryggvasons,gt,olav_tryggvasons_gate_ot1). 
cmpl(older,dalen,olderdalen).  
cmpl(olderdalen,ranheim,olderdalen). 
%%%% cmpl(ole,[aasveds,veg],ole_aasveds_street).  %% Ad Hoc (Ny veg,ikke nr)
cmpl(ole,[engelbrektssons,alle],olav_engelbrektssons_allé). 
cmpl(ole,bullsve,ole_bulls_street). 
cmpl(ole,nordgårdsvei,ole_nordgaards_street). 
cmpl(ole,ross,ole_ross_veg). 
cmpl(ole,rossvei,ole_ross_veg). 
cmpl(omkjøringsveien,[ved,moholt],moholt_omkjøringsvei). 
cmpl(omkjøringsveien,[ved,nardo],nardo_omkjøringsvei). 
cmpl(omkjøringsveien,klæbuveien,omkjøringsv_klæbuvveien). 
cmpl(omkjøringsveien,moholt,moholt_omkjøringsvei). 
cmpl(omkjøringsveien,nardo,nardo_omkjøringsvei). 
cmpl(omkjøringsveien,nardokrysset,nardo_omkjøringsvei). 
cmpl(oops,lade,lade_idrettsanlegg).  %%
cmpl(ops,lade,lade_idrettsanlegg).  %%nec?
cmpl(orkdalsbussen,[],hob). 
cmpl(orkanger,[skole], orkanger_skole). %%RS-131222 Flere stasjoner takk!      
cmpl(oskar,bråtensvei,oskar_braatens_street). 
cmpl(oslo,bussterminal,oslo). 
cmpl(oslo,s,oslo). 
cmpl(oslo,sentralbanestasjon,oslo).
%% cmpl(ostersund,sweden,østersund). 
cmpl(othillen,borg,othilienborg). 
cmpl(oth,['.',borg],othilienborg). 
cmpl(ottar,[nilsens,vei],otto_nielsens_veg). 
cmpl(otto,[nielsen,vei],otto_nielsens_veg). 
cmpl(otto,[nielsens,veg],otto_nielsens_veg). 
cmpl(otto,[nilsens,veg],otto_nielsens_veg). 
cmpl(otto,nielsen,otto_nielsens_veg). 
cmpl(otto,nielsensveg,otto_nielsens_veg). 
cmpl(otto,nielsensvei,otto_nielsens_veg). 
cmpl(otto,nielsenvei,otto_nielsens_veg). 
cmpl(otto,nilsen,otto_nielsens_veg). 
cmpl(otto,nilsensvei,otto_nielsens_veg). 
cmpl(ottonilsens,vei,otto_nielsens_veg). 
cmpl(ourens,vei,henrik_ourens_veg). 
cmpl(ovre,flataasveien,øvre_flatåsveg). 
cmpl(owesens,gate,thonning_owesens_street).  %% $Generic
cmpl(p,[1],prinsens_gate_p1).
cmpl(p,[2],prinsens_gate_p2).
%cmpl(p,[3],prinsens_gate_p3).
cmpl(p,kroghsv,peder_kroghs_v). 
cmpl(p,[morsets,vei],peder_morsets_veg). %% peder_morsetts_v %% (SIC) HASTUS 
cmpl(p,morsetsv,peder_morsets_veg). 
cmpl(p,[skole,mesters,vei],paul_skolemesters_veg). 
cmpl(p,[skolemesters,vei],paul_skolemesters_veg). 
cmpl(p,skolemestersv,paul_skolemesters_veg). 
cmpl(panorama,[quality,hotel],melkekartongen). 
cmpl(papirfabrikken,[på,ranheim],ranheim_fabrikker).
cmpl(paul,[skole,mesters,vei],paul_skolemesters_veg). 
cmpl(paul,[skolemesters,vei],paul_skolemesters_veg). 
cmpl(paul,fremstadsveg,paul_fjermstads_street). 
cmpl(paul,skolemestersv,paul_skolemesters_veg). 
cmpl(paul,skolemestersvei,paul_skolemesters_veg). 
cmpl(peder,[kroghs,gate],peder_kroghs_v). 
cmpl(peder,[kroghs,gt],peder_kroghs_v). 
cmpl(peder,[kroghs,veg],peder_kroghs_v).  %%Shouldn'tbenec
cmpl(peder,[kroghs,vei],peder_kroghs_v). 
cmpl(peder,[kroghsvei],peder_kroghs_v). 
cmpl(peder,[krogs,gate],peder_kroghs_v).  %%(nospell)
cmpl(peder,[krogs,veg],peder_kroghs_v). 
cmpl(peder,[morsets,vei],peder_morsets_veg). 
cmpl(peder,krogh,peder_kroghs_v). 
cmpl(peder,krogsgate,peder_kroghs_v). 
cmpl(peder,krogsvei,peder_kroghs_v). 
cmpl(pederkroghs,vei,peder_kroghs_v). 
cmpl(pedermorsets,v,peder_morsets_veg). 
cmpl(pedermorsets,vei,peder_morsets_veg). 
cmpl(pers,aunetleir,persaunet_leir). 
cmpl(persaune,veien,persaunetveien).   %% TA-110415
cmpl(persaunet,leier,persaunet_leir). %% TA-110615
cmpl(persaunet,leir,persaunet_leir).  %% SIC(errorinreghpl)
%cmpl(persaunet,sykehjem,gina_krogs_veg).  %% persaunvn54->
cmpl(persaunet,sykehjem,clara_holsts_veg).  %% persaunvn54->  %% RS-160809 NEW ROAD!
cmpl(pinsen,kino,nidarosdomen). 
cmpl(pinsen,kinos,nidarosdomen). 
cmpl(pinsen,kinosenter,nidarosdomen). 
cmpl(pinsens,kinosenter,nidarosdomen). 

cmpl(pir,1,pir_i).  
cmpl(pir,2,pir_ii).  %% street \+ pirat2'

cmpl(pir,[badet],pirbadet). 
cmpl(pir,[terminal],pirbadet). 
cmpl(pir,bad,pirbadet). 
cmpl(pir,badet,pirbadet). 
cmpl(pir,bath,pirbadet).  %%(Eng)
cmpl(pir,senteret,pirbadet). 
cmpl(pir,terminalen,pirbadet). 
cmpl(pirsenteret,['/',pirterminalen],pirbadet).  %%//unntak
cmpl(politi,huset,politihuset).  %% ts ? (name of station)
cmpl(politi,stasjon,politistasjonen). 
cmpl(police,station,politistasjonen). 
cmpl(politi,stasjonen,politistasjonen). 
cmpl(politiets,hittegodskontor,politistasjonen).
cmpl(polities,hittegodskontor,politistasjonen).  %% own, nec, no spch 

cmpl(post,terminalen,postterminalen). 
cmpl(posten,[på,sluppen],postterminalen). 
cmpl(posten,sluppen,postterminalen). 
cmpl(pr,[brochs,gate],hesthagen). 
cmpl(presteg,jordet,prestegårsjordet). 
cmpl(prestegårds,jordet,prestegårsjordet). 
cmpl(professor,[],hesthagen).  %% RS-160108 



cmpl(prinsen,[gate],prinsens_gate). 
cmpl(prinsen,hotell,prinsenkrysset). 
cmpl(prinsen,[kino,renter],nidarosdomen). 
cmpl(prinsen,[kino,senter],nidarosdomen). 
%% cmpl(prinsen,cinema,prinsen_kinosenter). %%  confuse
cmpl(prinsen,gt,prinsens_gate). 
cmpl(prinsen,kino,nidarosdomen). 
cmpl(prinsen,kino,nidarosdomen). 
cmpl(prinsen,kinos,nidarosdomen). 
cmpl(prinsen,kryss,prinsenkrysset). 
cmpl(prinsen,krysset,prinsenkrysset). 
cmpl(prinsenkino,senter,nidarosdomen). 
cmpl(prinsen,teater,nidarosdomen). 



% cmpl(prinsens,[gata],prinsens_gate).  
% cmpl(prinsens,[gate],prinsens_gate). 
% cmpl(prinsens,[gt],prinsens_gate). 

cmpl(prinsens,[kinosenter],nidarosdomen). 
cmpl(prinsens,gt,nidarosdomen). 
cmpl(prinsens,kino,nidarosdomen).  %%NOSPELL!
cmpl(prisen,kino,nidarosdomen). 
cmpl(prisen,kinosenter,nidarosdomen). 
cmpl(prof,['. '],professor).  %%?Doesnthelp
cmpl(prof,[b,gt],hesthagen). 
cmpl(prof,[br,gate],hesthagen). 
cmpl(prof,[broch,gate],hesthagen). 
cmpl(prof,[broch,gt],hesthagen). 
cmpl(prof,[broch,s,gate],hesthagen). 
cmpl(prof,[brochs,g],hesthagen). 
cmpl(prof,[brochs,gata],hesthagen). 
cmpl(prof,[brochs,gate],hesthagen). 
cmpl(prof,[brochs,gt],hesthagen). 
cmpl(prof,[brochs,v],hesthagen). 
cmpl(prof,[brochs,vei],hesthagen). 
cmpl(prof,[brox,gate],hesthagen). 
cmpl(prof,[brox,s,gate],hesthagen). 
cmpl(prof,[broxs,gate],hesthagen). 
cmpl(prof,broch,hesthagen). 
cmpl(prof,brochs,hesthagen). 
cmpl(prof,brochsgate,hesthagen). 
cmpl(prof,brochsgt,hesthagen). 
cmpl(prof,brochsv,hesthagen). 
cmpl(prof,brochsvei,hesthagen). 
cmpl(prof,brocksgate,hesthagen). 
cmpl(prof,brocksgt,hesthagen). 
cmpl(prof,brocksv,hesthagen). 
cmpl(prof,prochsgate,hesthagen).  %% Contag
cmpl(profbrochs,gate,hesthagen). 

cmpl(professor,[b,gate],hesthagen). 
cmpl(professor,[br,gate],hesthagen). 
cmpl(professor,[broch,gate],hesthagen). 
cmpl(professor,[broch,gt],hesthagen). 
cmpl(professor,[broch,s,gate],hesthagen). 
cmpl(professor,[broch],hesthagen).  %% Ekstraservice
cmpl(professor,[brochs,gt],hesthagen). 
cmpl(professor,[brochs,v],hesthagen). 
cmpl(professor,[brochs,vei],hesthagen). 
cmpl(professor,[brochs],hesthagen).  %% Confuses lex
cmpl(professor,brock,hesthagen). 
cmpl(professor,[brocks,gate],hesthagen). 
cmpl(professor,[brocksgt],hesthagen).  %% Confuses lex
cmpl(professor,[brocksv],hesthagen). 
cmpl(professor,[brogsgate],hesthagen).  %% (bergsgate#)
cmpl(professor,[brox,gate],hesthagen). 
cmpl(professor,[brox,gt],hesthagen). 
cmpl(professor,[brox,s,gate],hesthagen). 
cmpl(professor,[broxs,gate],hesthagen). 
cmpl(professor,[j,h,vogts,vei],professor_j_h_l_vogts_street). 
cmpl(professor,brochsgate,hesthagen). 
cmpl(professor,brochsgt,hesthagen). 
cmpl(professor,brochsveg,hesthagen). 
cmpl(professor,brochsvei,hesthagen). 
cmpl(professor,brocksgate,hesthagen). 
cmpl(professor,brocksgate,hesthagen). 
cmpl(professor,brocksvei,hesthagen). 
cmpl(professorbrochs,gate,hesthagen). 
cmpl(professorbrochs,gt,hesthagen). 

/* %% TA-110314
cmpl(proffessor,[brochs,gate],hesthagen).  %%Just for fun
cmpl(proffessor,[brochs,gt],professor_brochs_gate). 
cmpl(proffessor,[brochs,vei],professor_brochs_gate). 
cmpl(proffessor,[brocks,gate],professor_brochs_gate). 
cmpl(proffessor,[brox,gate],professor_brochs_gate). 
cmpl(proffessor,brochsgate,professor_brochs_gate). 
cmpl(proffessor,brochsgt,professor_brochs_gate). 
*/

cmpl(prøven,[bil],kroppan). %% TA-110520 ?

cmpl(quality,[hotell,panorama],melkekartongen). 
cmpl(quality,[hotell,tiller],melkekartongen). 
cmpl(quality,[panorama,hotel],melkekartongen). 
cmpl(quality,panorama,melkekartongen). 
cmpl(r,[i,t,hovedporten],st_lavs_hospital). 
cmpl(radisson,[sas,royal,garden,hotel],royal_garden). 
cmpl(radisson,[sas,royal,garden],royal_garden). 
cmpl(ragnhilds,gt,ragnhilds_gate).  %% Errorinreghpl(Station)
cmpl(railway,station,ts). %% AtB. 
cmpl(ranheim,[idretts,plass],ranheim_idrettsplass). 
cmpl(ranheim,papirfabrikk,ranheim_fabrikker). 
cmpl(ranheimhallen,[],ranheim_idrettsplass). %% ? %% TA-110314
cmpl(rema,[1000],rema).
cmpl(reppe,['/',vikåsen],reppevegen). 
cmpl(reppe,[vei,kryss],reppevegen). 
cmpl(reppe,endeholdeplass,reppe). 
cmpl(reppe,vegkryss,reppevegen).  %%Discrepancy in Routeguide
cmpl(reppe,veikryss,reppevegen).  %%redundant after rehash
cmpl(reppe,vikåsen,reppevegen).   %%ambiguous on purpose
%%%%  cmpl(ringte,skole,ringve).  %% TA-110502
cmpl(ringve,[botaniske,hage],ringve_museum). 
cmpl(ringve,[gård],ringve_museum). 
cmpl(ringve,[v,g,s],ringve_skole). 
cmpl(ringve,[v,g],ringve_skole). 
cmpl(ringve,[vg,skole],ringve_skole). 
cmpl(ringve,[videregående,skole],ringve_skole). 
cmpl(ringve,[videregående],ringve_skole). 
cmpl(ringve,bugt,ringve_museum).  %% Da
cmpl(ringve,bukt,ringve_museum). 
cmpl(ringve,bukta,ringve_museum).  
cmpl(ringve,bukten,ringve_museum). 
cmpl(ringve,gymnas,ringve_skole). 
cmpl(ringve,[musikk,museum],ringve_museum). 
cmpl(ringve,musikkmuseum,ringve_museum).
cmpl(ringvebukten,[],ringve_museum). 
cmpl(ringvoll,skole,ringve_skole).  %% (obs. iHobøl)
cmpl(risvollan,senteret,risvollan_senter). 
cmpl(rit,adm,adm_rit). %
cmpl(rit,hovedport,st_olavs_hospital). 
cmpl(rit,hovedporten,st_olavs_hospital). 
cmpl(romols,lia,romolslia). 
cmpl(romolslia,skole,skårgangen).  %% romulslia is the correct one, but not working?
cmpl(romolslia,øvre,romolslia_øvre). 
cmpl(romuls,lia,romolslia). 
cmpl(romulslia,skole,skårgangen).  %% tamburhaugen 1
cmpl(rosen,dal,rosendal). 

cmpl(rosenborg,park,gyldenløves_gate). 
cmpl(rosenborg,stadion,lerkendal_stadion). 
cmpl(rosenborg,stadium,lerkendal_stadion).  %% (f o r e i g n e r s)
cmpl(rosenborg,ungdomsskole,rosenborg_skole).
cmpl(rosenborg,vandrerhjem,weidemannsveien). 
cmpl(rosendal,kino,rosendal). 
cmpl(rosendal,skole,rosenborg_skole). %% ?
cmpl(rosendal,teater,rosendal). 
cmpl(rosten,[videregående,skole],tonstadgrenda).
cmpl(rosten,grenda,rostengrenda). 
cmpl(rosten,hallen,rostenhallen). 
cmpl(rosten,skole,tonstadgrenda). 
cmpl(rot,voll,rotvoll). 
cmpl(rotvoll,[alt],statoil_rotvoll). %% ALT %% TA-110627
cmpl(rotvoll,[statoil],statoil_rotvoll).  %% TA-110627
cmpl(rotvoll,n,rotvoll_nedre). 
cmpl(royal,garden,royal_garden). 
cmpl(royal,[garden,hotel],royal_garden). 
cmpl(royal,[garden,hotell],royal_garden).   %% Flybuss 
cmpl(rundkjøringen,[nardo],nardo_omkjøringsvei). 
cmpl(rundkjøringen,[på,nardo],nardo_omkjøringsvei). 
cmpl(rutebil,[stasjonen],rutebilstasjonen).  %%??
cmpl(rønnings,bakken,rønningsbakken). 

cmpl(s,['.',tasjon],ts).   %% AtB. %% TA-110310
cmpl(s,['.',tasjonen],ts). %% AtB. %%
cmpl(s,[p,andersensvei],s_p_andersens_street). 
cmpl(s,enter,senter). 
cmpl(s,entrum,sentrum). 
cmpl(s,ntrum,sentrum). 
cmpl(s,stasjon,ts). %% AtB. 
cmpl(s,stasjonen,ts). %% AtB. 
cmpl(s,tasjon,ts). %% AtB. 
cmpl(s,tasjonen,ts). %% AtB. 

cmpl(saksviks,gate,severin_saksviks_street). 

cmpl(sam,fundet,studentersamfundet). 
%cmpl(samf,1,studentersamfundet_1).   %% nb split name
%cmpl(samf,2,studentersamfundet_2). 
%cmpl(samfun,[det],studentersamfundet). 
%cmpl(samfundet,1,studentersamfundet_1). 
%cmpl(samfundet,2,studentersamfundet_2). 
%cmpl(samfundet,[1],studentersamfundet_1). 
%cmpl(samfundet,[2],studentersamfundet_2). 
%cmpl(samfundet,[l],studentersamfundet_1).  %% L
%cmpl(samfunnet,[1],studentersamfundet_1).  %% AVOID 1300
%cmpl(samfunnet,[2],studentersamfundet_2).  %% AVOID 1400
%cmpl(samfunnet,[l],studentersamfundet_1).  %%
cmpl(sandmoen,[camping],sandmoen). 

cmpl(santolavs,[hospital],st_olavs_hospital). 
cmpl(santolavs,[],st_olavs_hospital). 

cmpl(sas,[royal,garden,hotel],royal_garden). 
cmpl(sas,hotellet,royal_garden). %% onlt Th
cmpl(saupstad,ringen,saupstadringen_109). 
cmpl(saupstad,s,saupstadsenteret).  %%ikkeSentrum
cmpl(saupstad,senter,saupstadsenteret). 
cmpl(saupstad,senteret,saupstadsenteret). 
cmpl(saupstad,skole,midteggen).  %%Saupstadringen187
cmpl(saupstad,sykehjem,saupstadsenteret). 
cmpl(saupstads,senteret,saupstadsenteret). 

cmpl(scandic,hotell,scandic_hotel). %% change, scandic general
cmpl(scandic,hotellet,scandic_hotel). 
cmpl(scandic,[hotel,moholt],esso_motorhotell). %% old name
cmpl(scandic,[hotel,trondheim],scandic_hotel). 
cmpl(scandic,[hotell,moholt],esso_motorhotell). 
cmpl(scandic,moholt,esso_motorhotell). 
cmpl(scandic,[motor,hotell],esso_motorhotell). 

cmpl(schieldrops,[vei],e_b_schieldrops_vei). 
cmpl(schieldrops,veg,e_b_schieldrops_vei). 
cmpl(schjeldrups,vei,e_b_schieldrops_vei). % Gateetternavn
cmpl(schjetnans,veg,carl_schjetnans_vei). 
cmpl(schjetnans,vei,carl_schjetnans_vei). 
cmpl(schøning,[videregående,skole],hovedterminalen). 
cmpl(se,[4,ntrum],sentrum).  %% neibk
cmpl(se,ntrum,sentrum). 
cmpl(selsbakk,skole,selsbakk). 
cmpl(sen,rum,sentrum). 
cmpl(sen,trum,sentrum). 
cmpl(senr,trum,sentrum).  %% repair
cmpl(sent,['. ',stasjonen],ts). %% AtB. 
cmpl(sent,rum,sentrum).
cmpl(sentere,t,senteret).  %% NB sentere`t? doesnt help
cmpl(sentr,stasj,ts). %% AtB. 
cmpl(sentr,um,sentrum).  %% sentru,m neib k 
cmpl(sentral,[bane,stasjon],ts). %% AtB. 
cmpl(sentral,[bane,stasjonen],ts). %% AtB. 
cmpl(sentral,stasjon,ts). %% AtB. 
cmpl(sentral,stasjonen,ts). %% AtB. 
cmpl(sentral,banen,ts). %% AtB. 
cmpl(sentral,banestasjon,ts). %% AtB. 
cmpl(sentral,station,ts). %% AtB.  %%Norwagism
cmpl(sentralbane,[stasjonen],ts). %% AtB. 
cmpl(sentrale,busstasjonen,hovedterminalen). 
cmpl(sentralsta,sjon,sentralstasjon). %% ?
%%% cmpl(sentru,m,sentrum). %% susmeded test %%  sentrum --> sentru***
cmpl(sentrum,[av,trondheim],sentrum).  %% Ad Hoc (Sentrum Syndrom)
cmpl(sentrum,[jernbanestasjon],ts). %% AtB. 
cmpl(sentrum,kino,olav_tryggvasons_gate_ot2). 
cmpl(sentrum,politistasjon,politistasjonen). %% politihuset).
cmpl(sentrum,stasjon,hovedterminalen). 
cmpl(sentrum,trondheim,sentrum). 
cmpl(sentrums,terminalen,hovedterminalen). 
cmpl(service,kontoret,servicekontoret). 
cmpl(setroms,vei,ola_setroms_veg). 
cmpl(siemens,[as],siemens). 
cmpl(siemens,bru,siemens). 
cmpl(siemens,bygget,siemens). 
cmpl(siemens,krysset,siemens). 
cmpl(sig,[bergs,alle],gyldenløves_gate).  %% \+ sig bergs
cmpl(sigrid,[bergs,alle],gyldenløves_gate). 
cmpl(sigrun,[bergs,alle],gyldenløves_gate).  %% Sigrun ???
cmpl(sigurd,[bergs,all],gyldenløves_gate).   %% Makter ikke
cmpl(sigurd,[bergs,alle],gyldenløves_gate).  %% Sigrun ???
cmpl(sigurd,[bergs,gate],gyldenløves_gate). 
cmpl(sigurd,bergsgate,gyldenløves_gate).  
cmpl(sigurd,[bergsted,alle],gyldenløves_gate). 
cmpl(sigurd,bergsalle,gyldenløves_gate). 
cmpl(sigurdbergs,alle,gyldenløves_gate).  
cmpl(sigurds,[berg,alle],gyldenløves_gate). 

%% trouble spot
cmpl(sigurd,biskopsgate,buran_3). %% etc :-)
cmpl(sigurd,[biskops,gate],buran_3). 
cmpl(sigurd,[biskops,street],buran_3). %% TA-110411
cmpl(sigurd,[biskop,street],buran_3).  %%

cmpl(sigurds,gate,buran_3). 
cmpl(sigurds,gt,buran_3). 



cmpl(singsaker,skole,jonsvannsveien). 
cmpl(singsaker,sommerhotell,singsaker_studenthjem). 
cmpl(singsaker,studenterhjem,singsaker_studenthjem). 
cmpl(singsaker,studenthjem,singsaker_studenthjem). 
cmpl(singsaker,studenthotell,singsaker_studenthjem). 
cmpl(sirkus,[kjøpe,senter],sirkus_shopping).
cmpl(sirkus,[kjøpesenter],sirkus_shopping).
cmpl(sirkus,[leangen],sirkus_shopping).
cmpl(sirkus,[på,leangen],sirkus_shopping).
cmpl(sirkus,[senter],sirkus_shopping).
cmpl(sirkus,[senteret],sirkus_shopping).
cmpl(sirkus,[sentret],sirkus_shopping).
cmpl(sirkus,[shopping],sirkus_shopping).
cmpl(sirkus,[shopping,senter],sirkus_shopping).
cmpl(sit,[i,cyd],city_syd).  %%?
cmpl(sit,[i,syd],city_syd).  %%
cmpl(sivert,[thonstads,v],sivert_thonstads_vei). 
cmpl(sivert,[thonstads,veg],sivert_thonstads_vei). 
cmpl(sivert,[thonstads],sivert_thonstads_vei). 
cmpl(sivert,[thonstadsv],sivert_thonstads_vei). 
cmpl(sivert,[thonstadsvei],sivert_thonstads_vei). 
cmpl(sivert,[tondstadsv],sivert_thonstads_vei). 
cmpl(sivert,[tonstad,vei],sivert_thonstads_vei). 
cmpl(sivert,[tonstads,vei],sivert_thonstads_vei). 
cmpl(sivert,[tonstadsvei],sivert_thonstads_street). 
cmpl(sivert,[tonstadv],sivert_thonstads_vei). 

cmpl(sivilforsvaret,[granåsen],granåsen_vm_anlegget).     %% etc 
cmpl(sivilforsvaret,[på,granåsen],granåsen_vm_anlegget). 
cmpl(sivilforsvaret,[ved,granåsen],granåsen_vm_anlegget).

cmpl(sj,marka,sjetnmarka).  %%xservice
cmpl(sjetne,marka,sjetnmarka). 
cmpl(sjetne,skole,carl_schjetnans_veg). 
cmpl(sjetnemarka,skole,carl_schjetnans_veg).  %% no spell
cmpl(sjetnmarka,skole,carl_schjetnans_veg).  
cmpl(skavlands,veg,skavlans_veg). 
cmpl(skavlans,veg,skavlans_veg). 
cmpl(ski,stua,skistua). 
cmpl(skippy,senteret,fossegrenda).  %% schrøder
cmpl(skipsmodelltanken,tyholt,skipsmodelltanken).  %% (?)
cmpl(skjetlein,[v,g,skole],leinstrand). 
cmpl(skjetlein,[videregående,skole],leinstrand). 
cmpl(skjetlein,skole,leinstrand). 
cmpl(skjetne,skole,carl_schjetnans_veg). 
cmpl(skjetnemarka,skole,carl_schjetnans_veg). 
cmpl(skjåness,vei,ivar_skjåness_vei). %% st
cmpl(skole,mesters,paul_skolemesters_veg).  %%AD HOC mesters
cmpl(skolemesters,vei,paul_skolemesters_veg). 
cmpl(skov,gård,skovgård). 
cmpl(sluppen,brua,sluppen_bru). 
cmpl(sluppen,postkontor,postterminalen). 
cmpl(sluppen,postsenter,postterminalen). 
cmpl(sluppen,postsentral,postterminalen). 
cmpl(sluppen,postterminal,postterminalen). 

cmpl(smistads,street,arnt_smistads_vei).  %% NB Street
cmpl(sol,siden,solsiden). 
cmpl(solsiden,dokkparken,solsiden).  
cmpl(solsiden,kjøpesenter,solsiden). 
cmpl(solsiden,senteret,solsiden). 
cmpl(sonans,privatgymnas,olav_tryggvasons_gate_ot2). 
cmpl(sonans,skole,olav_tryggvasons_gate_ot2). %% ? 
cmpl(sorte,[lade,moen],svartlamon). 
cmpl(sosial,høgskolen,gildheim).  %%??
cmpl(sp,[andersens,vei],s_p_andersens_street). 
cmpl(sp,[andersensv],s_p_andersens_street). 
cmpl(sp,[andersensvei],s_p_andersens_street). 
cmpl(spongdal,skole,spongdal). 

cmpl(st,['.',olav],st_olav).
cmpl(st,['.',o,'.',hospital],st_olavs_hospital). 
cmpl(st,[0,lavs,gt],st_olavs_gate).             %% null(0) istedenfor O

cmpl(st,[elisabeth],ila).  %% ad hoc, make elisabeth known before hash
cmpl(st,[elisabeth,hospital,ila],ila). 
cmpl(st,[elisabeth,hospital],ila). 
cmpl(st,[elisabeths],ila).
cmpl(st,[elisabeths,hospital],ila). 

cmpl(st,hospital,st_olavs_hospital). 

cmpl(st,[ing,dahls,gate],gyldenløves_gate). %% \+ sig bergs
cmpl(st,[ing,dahls,gt],gyldenløves_gate). 
cmpl(st,[ing,dahlsgate],gyldenløves_gate). 

cmpl(st,[o,hospital],st_olavs_hospital).        %% RS-160109 Avoid confusion betwween st. olavs gate and hospital
%cmpl(st,[olav],st_olavs_hospital).     %% AMBIGIOUS between st_olavs_hospital (main hospital in Trondheim)  
cmpl(st,[olav],st_olav).                %% AMBIGIOUS between hospital and st_olavs_gate (main tram station in the city center!)
cmpl(st,[olav,sykehuset],st_olavs_hospital).
cmpl(st,[olav,s],st_olavs_hospital).
cmpl(st,[olav,s,hospital],st_olavs_hospital). 

%cmpl(st,[olavs],st_olav).               %% AMBIGIOUS between hospital and st_olavs_gate (main tram station in the city center!)
cmpl(st,[olavs,gate],st_olavs_gate). 
cmpl(st,[olavs,gt],st_olavs_gate). 

cmpl(st,[olavs,h],st_olavs_hospital).
cmpl(st,[olavs,hospital,vest],st_olavs_hospital_vest). 
cmpl(st,[olavs,hospital,øst],st_olavs_hospital). 
cmpl(st,[olavs,hospital],st_olavs_hospital). 
cmpl(st,[olavs,plass],st_olavs_gate). 


cmpl(st,olavsgate,st_olavs_gate). 
cmpl(st,olavsgaten,st_olavs_gate). 
cmpl(st,olavsgt,st_olavs_gate). 

cmpl(st,[olavshospital],st_olavs_hospital). 
cmpl(st,olavsplass,st_olavs_gate). 
cmpl(st,olavssykehus,st_olavs_hospital). 
cmpl(st,olovhospital,st_olavs_hospital). 

cmpl(st,samf,studentersamfunnet). 
cmpl(stabbursmoen,skole,heimdal).

cmpl(stads,[ing,dahls,gt],gyldenløves_gate).  %% ++ sig_bergs
cmpl(stads,[ingeniør,dahls,gate],gyldenløves_gate). 
cmpl(stads,[ingeniør,dahls,gt],gyldenløves_gate). 

cmpl(stadsing,[dahls,alle],gyldenløves_gate). %% TA-110530

cmpl(stadsing,[dahls,gt],gyldenløves_gate).  
cmpl(stadsingdal,gate,gyldenløves_gate).  
cmpl(stadsingdals,gate,gyldenløves_gate). 
cmpl(stadsingeniør,[dahls,gate],gyldenløves_gate). 
cmpl(stadsingeniør,[dahls,gate],gyldenløves_gate).  %% \+ street,avoid rosendal
cmpl(stadsingeniør,[dahls,gt],gyldenløves_gate). 
cmpl(stadsingeniør,[dahls,vei],gyldenløves_gate). 
cmpl(stadsingeniør,[dahlsgate],gyldenløves_gate). 
cmpl(stadsingeniør,[dahlsgt],gyldenløves_gate). 
cmpl(stat,[ingeniør,dahls,gate],gyldenløves_gate). 

cmpl(stads,[ing,dahls,gate],stadsing_dahls_street).  %% Stads. ing. dahls gate  .
cmpl(stadsingdahlsgate,[],stadsing_dahls_street). 
cmpl(stadsing,[dahls,gate],stadsing_dahls_street). 
cmpl(stadsingeniørs,gate,stadsing_dahls_street). 
cmpl(stat,[ing,dahl,gate],stadsing_dahls_street). 

cmpl(statens,hus,statens_hus). 
cmpl(statens,vegvesen,postterminalen). 
cmpl(stating,dahlsgt,gyldenløves_gate). 
cmpl(statoil,[bygget],statoil_rotvoll). 
cmpl(statoil,[forskningssenter,på,rotvoll],statoil_rotvoll). 
cmpl(statoil,[på,lade],statoil_rotvoll). 
cmpl(statoil,[på,rotvoll],statoil_rotvoll). %% rotvoll).

cmpl(statoil,[research,center],statoil_rotvoll). 
cmpl(statoil,forskningssenter,statoil_rotvoll). 
%% cmpl(statoil,research,statoil_rotvoll).  %% trick to make research visible
cmpl(statoil,researchcenter,statoil_rotvoll). 
cmpl(statoil,rotvoll,rotvoll). 
cmpl(statoils,forskningssenter,statoil_rotvoll). 

cmpl(stats,ingeniørsgate,gyldenløves_gate). 
cmpl(stats,[ingenørdals,gate],gyldenløves_gate). 
cmpl(statsingdal,gate,gyldenløves_gate). 
cmpl(statsingeniør,[dahls,gt],gyldenløves_gate). 
cmpl(statsingeniørs,[gt],gyldenløves_gate). 
cmpl(stav,gjestegård,stav). 
cmpl(stav,hotell,stav).  %%st. olavshotell\+
cmpl(stav,set,stavset). 
cmpl(stavne,bru,stavnebrua). 
cmpl(stavset,s,stavset_senter). 
%% cmpl(stavset,senter2,stavset_senter_2). 
cmpl(stavset,[senter,2],stavset_senter). 
cmpl(stavset,sentrum,stavset_senter). 
cmpl(stavset,skole,alfheimsvingen).  %% enromvegen 6
cmpl(stavset,svingen,stavsetsvingen). 
cmpl(stavset,senteret,stavset_senter). 

cmpl(steinan,[stud,by],vestlia). 
cmpl(steinan,[student,by],vestlia). 
cmpl(steinan,[veien,14],heggdalen). 

cmpl(steinan,[student,village],'Steinan studentby'). 

cmpl(steinan,studentby,'Steinan studentby'). 
%% cmpl(steinan,studentbyen,vestlia). %% destroys 'Steinan studentby'
cmpl(steinan,vestlia,vestlia). 
cmpl(steinanv,14,heggdalen). 
cmpl(steinanveien,14,steinanveien). 
cmpl(steindal,skole,hoeggen_skole). 
cmpl(steindalskole,[],hoeggen_skole).  %% TA-110121

cmpl(steinerskolen,[i,ila],skansen). 
cmpl(steinerskolen,[i,ila],skansen). 
cmpl(steinerskolen,[i,trondheim],hesthagen). 
cmpl(steinerskolen,[på,ila],skansen). %%
cmpl(steinerskolen,[på,rotvoll],rotvoll). 

cmpl(steintrøveien,endeholdeplass,steintrøveien). 
cmpl(stjørdal,sentrum,stjørdal_stasjon).        %% RS-150815. New bus added 310/410.
cmpl(stokkan,haugen,stokkanhaugen).
cmpl(stolavs,[hospital],st_olavs_hospital).  %%
cmpl(stolavs,gt,st_olavs_gate). 
cmpl(stor,['-',rosta],stor_rosta). 
cmpl(stor,['-',rosten],stor_rosta). 
cmpl(stor,rosta,stor_rosta). 
cmpl(stor,rosten,stor_rosta). 
cmpl(stps,brøset,brøsetflata). 
cmpl(str,heim,strindheim).  %% Dots are skipped after names
cmpl(strandvei,kai,strandveikaia).
cmpl(strandveien,[auto],buran).  %% Bilverksted
cmpl(strandveien,auto,buran). 

cmpl(strinda,[skole],magnus_blindes_veg). %% TA-110708

cmpl(strinda,[vg,skole],valentinlystveien). 
cmpl(strinda,[videregående,skole],valentinlystveien). 
cmpl(strinda,skole,valentinlystveien). 
cmpl(strinda,videregående,valentinlystveien). 
cmpl(strinda,vgs,valentinlystveien). 

cmpl(strindheim,[hage,by],strindheim_hageby). 
cmpl(strindheim,[kbs],strindheim).
cmpl(strindheim,[kbss,enteret],strindheim).
cmpl(strindheim,[sirkus],strindheim).
cmpl(strindheim,[sirkus,enteret],strindheim).
cmpl(strindheim,kirke,valentinlyst).  %%  ?
cmpl(strindheim,bil,jørgen_b_lysholms_vei).  %% lade alle 67a.  
%cmpl(stud,[samf,1],studentersamfundet_1). 
%cmpl(stud,[samf,2],studentersamfundet_2). 
cmpl(stud,samf,studentersamfundet). 
cmpl(stud,samfundet,studentersamfundet). 
cmpl(stud,samfunn,studentersamfundet). 
cmpl(stud,samfunnet,studentersamfundet). 

cmpl(student,byen,studentbyen). 
cmpl(student,city,studentby). 
cmpl(student,samf,studentersamfundet). 
cmpl(student,samfundet,studentersamfundet). 
cmpl(student,samfunn,studentersamfundet).
cmpl(student,samfunnet,studentersamfundet).
cmpl(studenter,samfunnet,studentersamfundet). %% TA-100905

cmpl(student,village,studentby).
cmpl(studentby,berg,berg_studentby). 
cmpl(studentby,steinan,vestlia).  %% TA. 050405
cmpl(studentbyen,[i,berg],berg_studentby). 
cmpl(studentbyen,[i,moholt],moholt_studentby).  %%
cmpl(studentbyen,[i,steinan],vestlia).  %%
cmpl(studentbyen,[på,berg],berg_studentby). 
cmpl(studentbyen,[på,moholt],moholt_studentby). 
cmpl(studentbyen,[på,steinan],vestlia). 
cmpl(studentbyen,[på,voll],voll_studentby). 
cmpl(studentbyen,berg,berg_studentby). 
cmpl(studentbyen,lerkendal,prestegårsjordet).  %%(ikkegårds)
cmpl(studentbyen,moholt,moholt_studentby). 
cmpl(studentbyen,steinan,vestlia). 
cmpl(studenter,samf,studentersamfundet). 
cmpl(studenter,samfundet,studentersamfundet). 
cmpl(studenter,samfunn,studentersamfundet). 
cmpl(studenter,samfunnet,studentersamfundet). 
cmpl(sunnland,[ungdom,skole],sunnlandskole).  %% ?
cmpl(sunnland,skole,karl_jonssons_veg). 
cmpl(sunnland,ungdomsskole,karl_jonssons_veg). 
cmpl(svart,lamon,svartlamon). 
cmpl(svartlavmoen,[],svartlamon). 
cmpl(sverresborgalle,[],sverresborg_alle). %% street 
cmpl(sverres,borg,sverresborg). 
cmpl(sverresborg,[folke,museum],trøndelag_folkemuseum). 
cmpl(sverresborg,[folkemuseum],trøndelag_folkemuseum). 
cmpl(sverresborg,folkemuseum,trøndelag_folkemuseum). 
cmpl(sverresborg,museum,trøndelag_folkemuseum).  
cmpl(sverresborg,skole,framveien).  %%?????????????
cmpl(sverresborgmuseum,[],trøndelag_folkemuseum). 

cmpl(sykehuset,[],st_olavs_hospital). %% RS-160109 It's a valid default
cmpl(sykehuset,[st,olav],st_olavs_hospital). %% etc

cmpl(sykepleier,høgskolen,st_olavs_hospital). 
cmpl(sykepleier,skolen,st_olavs_hospital).  %%hvor???
cmpl(sæter,bakken,sæterbakken).  

cmpl(søndregate,[22],olav_tryggvasons_gate_ot3). %% Problem %% TA-110526
cmpl(søndregate,[23],olav_tryggvasons_gate_ot3). %% Problem %% TA-110526

cmpl(søndre,[gate,22],olav_tryggvasons_gate_ot3). 
cmpl(søndre,[gate,23],olav_tryggvasons_gate_ot3). 
cmpl(søndre,[gt,22],olav_tryggvasons_gate_ot3). 
cmpl(søndre,[gt,23],olav_tryggvasons_gate_ot3). 
cmpl(søndre,gate,søndregate). 
cmpl(søndre,gløshaugen,gløshaugen).  %% (sydlige?)
cmpl(søndre,gt,søndregate). 
cmpl(søndre,hallset,hallset).  %% \+ spellc to halset
cmpl(søndre,hoem,søndre_hoem).  %% Tramstation

cmpl(søndregt,[],søndregate).   %% NB then neighbourhood 22/23
cmpl(saøndregt,[],søndregate).  %% nec?? sÃ¸ndregt %% TA-110419

cmpl(sør,trøndelag,sørtrøndelag). 
cmpl(t,bane,tbanen). 
cmpl(t,banen,tbanen).  %%tbanenname,tbanenoun


cmpl(ts,10,trondheim_s_10). %% AtB
cmpl(ts,11,trondheim_s_11). %% TA-110627
cmpl(ts,13,trondheim_s_13). %% 

cmpl(ts,[hpl,10],ts). %% AtB
cmpl(ts,[hpl,11],ts). %% AtB.
cmpl(ts,[hlp,11],ts). %% AtB.
cmpl(ts,[hlp,11],ts). %% AtB.


cmpl(tambslyches,veg,tambs_lyches_street). 
cmpl(tambslyches,veien,tambs_lyches_street). 
cmpl(taxi,sentralen,taxisentralen). 

cmpl(team,[buss,i,trondheim],tt). %OK
cmpl(team,[i,trondheim],tt). %OK
cmpl(team,[trafikk,'. ',no],tt).  %%"teamtrafikk. no"(mis u nderst)
cmpl(team,[trafikk,kontoret],servicekontoret). 
cmpl(team,[trafikks,kontor],servicekontoret). 
cmpl(team,[trafikks,salgskontor],servicekontoret). 
cmpl(team,[trafikks,servicekontor],servicekontoret). 
cmpl(team,kontor,servicekontoret). 
cmpl(team,kundesenter,servicekontoret).
cmpl(team,traffic,tt). 
cmpl(team,trafikk,tt).  %% (synned away)
cmpl(team,[trafikk,as],tt). 


cmpl(teams,[trafikk,kontor],servicekontoret). 
cmpl(teams,servicekontor,servicekontoret). 

cmpl(trøndelag,museum,trøndelag_folkemuseum).
cmpl(trøndelagfolkemuseum,[],trøndelag_folkemuseum). 
cmpl(trøndelag,teater,nidarosdomen).   
cmpl(trøndelag,trafikk,tt).   

cmpl(trondheim,busstasjon,hovedterminalen). %%  + sentrumsterminalen
cmpl(trondheim,energi,e_verket). 
cmpl(trondheim,kai,pirterminalen). %% as a neib 
cmpl(trondheim,rutebuss,tt).  
cmpl(trondheim,[rute,buss],tt). 

cmpl(tegelverks,krysset,teglverkskrysset). 
cmpl(teggelverks,tunet,teglverkstunet).  %%
cmpl(teglverk,krysset,teglverkskrysset). 
cmpl(telenor,[bygget],tf). 
cmpl(telenor,[forskningssenter],tf). 
cmpl(telenor,[på,tyholt],tf). 
cmpl(telenor,[tyholt],tf).  %% Extraservice
cmpl(telenorbygget,[],tf). 
cmpl(telenorbygget,[på,tyholt],tf). 
cmpl(telenorhuset,[],tf). 
cmpl(telenorsenteret,[],tf). 
cmpl(telenorsentret,[],tf). 
cmpl(televerket,lade,televerket). 
cmpl(tempe,auto,bratsbergvegen ). 
cmpl(tempe,hallen,nidelvhallen). 
cmpl(tempe,sykehjem,valøyvegen).  %% NB veien

cmpl(thaulow,bakken,thaulowbakken). 
cmpl(thaulows,gate,thaulowbakken).  %% ?
cmpl(thaulowsbakken,[],thaulowbakken). %%  allow thailowsbakken %% TA-110502

cmpl(thomas,[owesens,gate],thonning_owesens_street). 
cmpl(thomas,engelsgate,thomas_angells_street). 

cmpl(thomas,[von,westensgate],thomas_von_westens_street). 

cmpl(thoning,[owesens,gate],thonning_owesens_street). 
cmpl(thonning,[oves,gt],thonning_owesens_street). 
cmpl(thonning,[owes,gt],thonning_owesens_street). 
cmpl(thonning,[owesens,gate],thonning_owesens_street). 
cmpl(thonning,ovesgate,thonning_owesens_street). 
cmpl(thonning,ovesgt,thonning_owesens_street). 
cmpl(thonning,ovesgt,thonning_owesens_street).  
cmpl(thonningowesens,gt,thonning_owesens_street). 
cmpl(thornæs,veg,k_o_thornæs_veg). 
cmpl(thornæs,vei,k_o_thornæs_veg). 
cmpl(thornæs,veien,k_o_thornæs_veg). 
cmpl(tilfredshet,kapell,studentersamfundet). 
cmpl(tilfredshet,kirkegård,studentersamfundet). 
cmpl(tiller,byen,koieflata). 
cmpl(tiller,dps,tonstadgrenda). 

cmpl(tiller,kirke,'Tiller kirke').  %% avoid nearest to MØ is MØ
cmpl(tiller,skole,tonstadgrenda). 
cmpl(tiller,sykehjem,tonstadgrenda). %%  (?) 
cmpl(tiller,[videregående,skole],tonstadgrenda).
cmpl(tiller,vgs,tiller_v_g_s). %% TA-100716

cmpl(time,ekspressen,timeekspressen). 
cmpl(tine,[midt,norge],norske_meierier). 
cmpl(tine,[på,tunga],norske_meierier). 
cmpl(tine,meierier,norske_meierier). 
cmpl(tine,merierier,norske_meierier). 
cmpl(tmv,kai,solsiden). 
cmpl(tmv,kaia,solsiden). 
cmpl(tog,[stasjon],ts). %% AtB. 
cmpl(tog,stasjonen,ts). %% AtB. 
cmpl(tonst,[krysset],tonstadkrysset). 
cmpl(tonstad,grenda,tonstadgrenda). 
cmpl(tonstad,kryss,tonstadkrysset). 
cmpl(tonstad,krysset,tonstadkrysset). 
cmpl(tonstad,krysset,tonstadkrysset). 
cmpl(tonstad,skole,tonstadgrenda). 
cmpl(tonstadkrysset,1,tonstadkrysset). 
cmpl(thonstadkrysset,[],tonstadkrysset). %% TA-110110

cmpl(tor,plassen,casper_lundes_veg). 
cmpl(tor,veg,tors_veg). 
cmpl(tor,vei,tors_veg). 
cmpl(torbjørn,[brath,veg],'Torbjørn Bratts veg'). 
cmpl(torbjørn,[braths,veg],'Torbjørn Bratts veg'). 
cmpl(torbjørn,[bratts,veg],'Torbjørn Bratts veg'). 
cmpl(torbjørn,[brattsvei],'Torbjørn Bratts veg'). 
cmpl(torget,[orkanger], torget_orkanger). %%RS-131222 Flere stasjoner takk!      

cmpl(torp,holdeplass,casper_lundes_veg).  %% misu nderstanding?
cmpl(tors,plass,casper_lundes_veg). 
cmpl(torv,myra,torvmyra). 
%% cmpl(torve,t,torget).  %% destroys torve=torget%% TA-101122
cmpl(town,centre,hovedterminalen). 
cmpl(town,hall,rådhuset). 
cmpl(town,square,hovedterminalen). 
cmpl(toyota,[hell,bil],jørgen_b_lysholms_vei).  %%
cmpl(toyota,hell,jørgen_b_lysholms_vei). 
cmpl(tr,['. ',h,sentralstasjon],ts). %% AtB. 
cmpl(tr,[folkemuseum],trøndelag_folkemuseum).  %%textonstation
cmpl(tr,[hei,sentral],ts). %% AtB. 
cmpl(tr,[heim,s],ts). %% AtB.  %%???
cmpl(tr,[heim,sentralst],ts). %% AtB.  %% Etc
cmpl(tr,[heim,sentralstasjon],ts). %% AtB. 
cmpl(tr,[heim,sentrum],sentrum). 
cmpl(tr,[heim,st],ts). %% AtB. 
cmpl(tr,[heim,torg],hovedterminalen). 
cmpl(tr,[lag,folkemuseum],trøndelag_folkemuseum). 
cmpl(tr,heim,trondheim).  %% ?
cmpl(tr,heimsentralstasjon,ts). %% AtB. 
cmpl(tr,sentralstasjon,ts). %% AtB. 
cmpl(tr,sentrum,sentrum). 
cmpl(tr,st,ts). %% AtB.  %% ?
cmpl(tr,torg,hovedterminalen). 
cmpl(trafikanten,[],tmn). 
cmpl(trafikanten,midtnorge,tmn). 
cmpl(trafikk,['. ',no],tt).  %%
cmpl(trafikk,no,tt).  %%
cmpl(train,station,ts). %% AtB. 
cmpl(trav,bane,travbane). 
cmpl(travbanen,leangen,travbanen). 
cmpl(trheim,jernbane,ts). %% AtB. 
cmpl(trolla,bruk,trolla). 
cmpl(trolla,haugen,trollahaugen). 
cmpl(trollahaugen,10,trollahaugen_10). 
cmpl(trollahaugen,2,trollahaugen_2). 
cmpl(trollahaugen,46,trollahaugen_46). 
cmpl(trollahaugen,64,trollahaugen_64). 
cmpl(trondhe,[4,m],trondheim).  %% smstabl
cmpl(trondheim,[s,'.',holdeplass],ts). %%  TA-110310
cmpl(trondheim,[airport],trondheim_lufthavn_lufthavnveien). 
cmpl(trondheim,[e,verk],e_verket).  %% NB'e-verk'
cmpl(trondheim,[energi,verk],e_verket). 
cmpl(trondheim,[fengsel],tunga_kretsfengsel). 
cmpl(trondheim,[folkemuseum],trøndelag_folkemuseum). 
cmpl(trondheim,[kokk,og,stuertskole],ladejarlen_v_g_s). 
cmpl(trondheim,kommune,trondheim). 
cmpl(trondheim,[maritime,skole],ladejarlen_v_g_s). 
cmpl(trondheim,[politi,stasjon],politihuset). 
cmpl(trondheim,[railway],ts). %% AtB. 


cmpl(trondheim,[s,10],ts). 
cmpl(trondheim,[s,11],ts).
cmpl(trondheim,[s,13],ts). 
cmpl(trondheim,[s,hpl,10],ts).
cmpl(trondheim,[s,st],ts). %% AtB.  %% //doesnt help
cmpl(trondheim,[sentral,hpl,10],ts).  %% ? etc ?
cmpl(trondheim,[sentral,stasjon],ts). %% AtB. 
cmpl(trondheim,[sentralsta,sjon],ts). %% AtB. %%  ?
cmpl(trondheim,[sentralbane,stasjon],ts). %% AtB. 
cmpl(trondheim,[sentralstasjon,10],ts). 
cmpl(trondheim,[sentralstasjon,11],ts). 
cmpl(trondheim,[sentralstasjon,13],ts). 
cmpl(trondheim,[tekniske,fagskole],ladejarlen_v_g_s).
cmpl(trondheim,trafikksentral,ts). %% AtB.        %% ?
cmpl(trondheim,trafikkstasjon,ts). %% AtB. %% ? 
cmpl(trondheimtrafikk,stasjon,ts). %% AtB.      

cmpl(trondheim,[økonomiske,høgskole],tøh).  
cmpl(trondheim,busselskap,tt). 
cmpl(trondheim,bussterminal,hovedterminalen). 
cmpl(trondheim,by,trondheim). 
cmpl(trondheim,centre,sentrum). 
cmpl(trondheim,centrum,sentrum). 
cmpl(trondheim,city,sentrum). 
cmpl(trondheim,enerigverk,e_verket). 
cmpl(trondheim,festning,ankers_gate). 
cmpl(trondheim,flygplats,trondheim_lufthavn_lufthavnveien).  %%(Swe)
cmpl(trondheim,flyplass,trondheim_lufthavn_lufthavnveien). 
cmpl(trondheim,havn,pirbadet). 
cmpl(trondheim,hovedjernbanestasjon,ts). %% AtB. 
cmpl(trondheim,hovedstasjon,ts). %% AtB. 
cmpl(trondheim,jernbanestasjon,ts). %% AtB. 
cmpl(trondheim,jernbanestation,ts). %% AtB. 
cmpl(trondheim,katedralskole,katedralskolen). 
cmpl(trondheim,kino,kino). 
cmpl(trondheim,kretsfengsel,tunga_kretsfengsel). 
cmpl(trondheim,lufthavn,trondheim_lufthavn_lufthavnveien). 
cmpl(trondheim,lærerhøgskole,rotvoll_nedre). 
cmpl(trondheim,norway,trondheim). 
cmpl(trondheim,rutebilstasjon,rutebilstasjonen). 
cmpl(trondheim,s,ts). %% AtB.  %%sentrum???
cmpl(trondheim,sentral,ts). %% AtB.  %%???
cmpl(trondheim,sentralbanestasjon,ts). %% AtB. 
cmpl(trondheim,sentralstasjon,ts). %% AtB. 
cmpl(trondheim,sentralstasjonen,ts). %% AtB. 
cmpl(trondheim,sentralterminal,ts). %% AtB. 
cmpl(trondheim,sentrum,sentrum). 
cmpl(trondheim,spektrum,trondheim_spektrum). 
cmpl(trondheim,st,ts). %% AtB. 
cmpl(trondheim,stasjon,ts). %% AtB. 
cmpl(trondheim,station,ts). %% AtB. 
cmpl(trondheim,taxi,taxi). 
cmpl(trondheim,teater,nidarosdomen). 
cmpl(trondheim,togstasjon,ts). %% AtB. 
cmpl(trondheim,togstation,ts). %% AtB. 
cmpl(trondheim,torg,hovedterminalen). 
cmpl(trondheim,torg,trondheim_torg). 
cmpl(trondheim,torget,trondheim_torg). 
cmpl(trondheim,torv,hovedterminalen).  %%
cmpl(trondheim,trafikk,tt). 
cmpl(trondheim,trafikkselskap,tt).  %%Also for non-places
cmpl(trondheim,trafikkstasjon,ts). %% AtB. 
cmpl(trondheim,university,ntnu). 
cmpl(trondheim,vandrerhjem,weidemannsveien). 
cmpl(trondheim,verft,solsiden). 
cmpl(trondheim,vernes,trondheim_lufthavn_lufthavnveien).  %% NO spell on parts (if too many)
cmpl(trondheim,værnes,trondheim_lufthavn_lufthavnveien).  %% Flybuss trondheim værnes Align
cmpl(trondheims,flygplats,trondheim_lufthavn_lufthavnveien).  %%(Swe)
cmpl(trondheims,flyplass,trondheim_lufthavn_lufthavnveien). 
cmpl(trondheims,sentrum,sentrum). 
cmpl(trondheims,torg,hovedterminalen). 
cmpl(trondhjems,sporveier,gråkallbanen). 
cmpl(tryggvasons,gate,olav_tryggvasons_gate_ot1). 
cmpl(tryggvassons,gate,olav_tryggvasons_gate_ot1). 
cmpl(tryggvassons,gt,olav_tryggvasons_gate_ot1). 
cmpl(trøndelag,[folk,museum],trøndelag_folkemuseum).  %% Eng
cmpl(trøndelag,teater,nidarosdomen).  %%(shortcut)
cmpl(tt,[kontoret],servicekontoret). 
cmpl(tt,[s,servicekontor],servicekontoret). 
cmpl(tt,[trafikk,'. ',no],tt). %(synnedaway)
cmpl(tt,salgskontor,servicekontoret). 
cmpl(tt,traffic,tt).  %%(synnedaway)
cmpl(tt,trafikk,tt). 
cmpl(tts,servicekontor,servicekontoret). 
cmpl(tunga,fengsel,tunga_kretsfengsel). 
cmpl(tunga,fengselet,tunga_kretsfengsel). 
cmpl(tunga,fengslet,tunga_kretsfengsel). 
cmpl(tunga,kretsfengsel,tunga_kretsfengsel). 
cmpl(tunga,landbrukssenter,gartnerhallen). 
cmpl(tv,tower,strinda_vgs). 
cmpl(tv,tårnet,strinda_vgs). 
cmpl(tyholt,sykehjem,tyholt). 
cmpl(tyholt,tower,strinda_vgs). 
cmpl(tyholt,tårnet,strinda_vgs). 
cmpl(tøh,moholt,tøh). 
cmpl(ugla,[på,byåsen],ugla). 
cmpl(ugla,skole,ugla). 
cmpl(ungdomsherberget,[],weidemannsveien). 
cmpl(univ,dragvoll,dragvoll). 
cmpl(univ,dragvoll,dragvoll).  %%NBNB \+ universitetetdragvoll!!!
cmpl(univ,gløshaugen,gløshaugen). 
cmpl(univ,lade,ntnu_lade).  %%ChangeName
cmpl(universitet,[på,lade],ntnu_lade). 
cmpl(universitet,[rosenborg],a_v_h). 
cmpl(universitetet,[i,lade],ntnu_lade). 
cmpl(universitetet,[på,dragvoll],dragvoll). 
cmpl(universitetet,[på,gløshaugen],gløshaugen_nord). 
cmpl(universitetet,[på,lade],ntnu_lade). 
cmpl(universitetet,[på,rosenborg],a_v_h). 
cmpl(universitetet,[rosenborg],a_v_h). 
cmpl(universitetet,[ved,dragvoll],dragvoll). 
cmpl(universitetet,[ved,lade],ntnu_lade). 
cmpl(universitetet,[ved,rosenborg],a_v_h). 
cmpl(universitetet,dragvoll,ntnu_dragvoll).  %%????
cmpl(universitetet,gløshaugen,gløshaugen). 
cmpl(universitetet,lade,ntnu_lade). 
cmpl(universitetssenteret,[dragvoll],ntnu_dragvoll). 
cmpl(university,[at,gløshaugen],gløshaugen).  %%Nec
cmpl(university,[at,lade],ntnu_lade). 
cmpl(university,[of,dragvoll],dragvoll). 
cmpl(university,[of,trondheim],ntnu). 
cmpl(university,gløshaugen,nth). 
cmpl(utleira,skole,risvollan_senter). 
cmpl(v,rnes,trondheim_lufthavn_lufthavnveien).  %%tov'rnes
cmpl(v,rosten,vestre_rosten). 
cmpl(valentien,lyst,valentinlyst). 
cmpl(valentin,lyst,valentinlyst). 
cmpl(valentin,senteret,valentinlyst). 
cmpl(valentinlyst,kjøpesenter,valentinlyst). 
cmpl(valentinlyst,senteret,valentinlyst). 
cmpl(vass,fjellet,vassfjellet). 
cmpl(vassfjellet,skisenter,vassfjellet). 
cmpl(veimesterkroghs,street,veimester_kroghs_street). 
cmpl(veimesterkrogs,street,veimester_kroghs_street). 
cmpl(veimesterkrohgs,street,veimester_kroghs_street). 
cmpl(verdens,ende,tjøme). 
cmpl(vestlia,[ende,holde,plass],vestlia_endeholdeplass). 
cmpl(vestlia,endeholdeplass,vestlia_endeholdeplass).  %% EndeholdeplassSyndrome
cmpl(vestlia,endeholdplass,vestlia_endeholdeplass).  %%Vestliaisaendstation
cmpl(vestlia,endestasjon,vestlia_endeholdeplass). 
cmpl(vestlia,endholdeplass,vestlia_endeholdeplass). 
cmpl(vestlia,endholdplass,vestlia_endeholdeplass). 
cmpl(vestlia,steinan,vestlia). 
%% cmpl(vestre,bratsberg,bratsberg_vestre). 
cmpl(vestre,posten,vestre_rosten).  %%sms
cmpl(vestre,vosten,vestre_rosten).  %%Contag
cmpl(vhurchills,vei,churchills_veg). 
cmpl(victoria,[bachkes,vei],'Victoria Bachkes vei'). 


cmpl(vikelvveien,n,vikelvveien). %% Hastus 
cmpl(vikelvveien,s,vikelvveien). %% Hastus

cmpl(vikåsen,['/',reppe],reppevegen). 
cmpl(vikåsen,[n],vikåsen_nedre). 
cmpl(vikåsen,[s],vikåsen_skole).  %% NB skole
cmpl(vikåsen,endeholdeplass,vikåsen). 
cmpl(vikåsen,hallen,markaplassen_skole). 
cmpl(vikåsen,idrettshall,markaplassen_skole). 
cmpl(vikåsen,reppe,reppevegen). 
cmpl(vm,anlegget,granåsen_vm_anlegget). 
cmpl(vm,arenaen,granåsen_vm_anlegget). 

cmpl(vollstudent,[by],voll_studentby). 
cmpl(voll,['4h',gård],voll_gård).  %%
cmpl(voll,[gryta],gryta). 
cmpl(voll,[st,b],voll_studentby). 
cmpl(voll,[st,by],voll_studentby). 
cmpl(voll,[stud,by],voll_studentby). 
cmpl(voll,[student,by],voll_studentby). 
cmpl(voll,stud,voll_studentby). 
cmpl(voll,student,voll_studentby). 
cmpl(volla,bakken,vollabakken). 
cmpl(vollan,gård,voll_gård). 
cmpl(volls,studentby,voll_studentby). 
cmpl(volls,tudentby,voll_studentby). 
cmpl(vår,[frue,kirke],hovedterminalen). 
cmpl(vår,[frues,kirke],hovedterminalen).  %%spc<6
cmpl(være,trøa,værestrøa). %% off name 
cmpl(værnes,[airport],trondheim_lufthavn_lufthavnveien). 
cmpl(værnes,[fly,havn],trondheim_lufthavn_lufthavnveien). 
cmpl(værnes,[luft,havn],trondheim_lufthavn_lufthavnveien). 
cmpl(værnes,flyhavn,trondheim_lufthavn_lufthavnveien). 
cmpl(værnes,flyplass,trondheim_lufthavn_lufthavnveien). 
cmpl(værnes,flystasjon,trondheim_lufthavn_lufthavnveien). 
cmpl(værnes,lufthavn,trondheim_lufthavn_lufthavnveien). 
cmpl(værnes,trondheim,trondheim_lufthavn_lufthavnveien). 
cmpl(wistings,street,oscar_wistings_street). %% TA-101115 nec
cmpl(witro,bil,fossegrenda).

cmpl(wullums,gården,byåsen_butikksenter). 
cmpl(wullimsgården,[],byåsen_butikksenter). %% TA-101230
cmpl(wøndre,hoem,søndre_hoem).  %% Tramstation RS-160108

cmpl(youth,hostel,weidemannsveien). 
cmpl(ystgaards,vei,ingvald_ystgaards_street). 
cmpl(zion,sykehjem,ole_hogstads_street-16).  %% Tegleverkskrysset

cmpl(ø,[jakobsli],jakobslivegen_øvre). 
cmpl(ø,berg,østre_berg). 
cmpl(ø,[flatås,v],øvre_flatåsveg).  %%Syndrome
cmpl(ø,[flatås,vei],øvre_flatåsveg).  %% \+ direction
cmpl(ø,flatåsen,øvre_flatåsveg). 
cmpl(ø,jakobsliv,jakobslivegen_øvre). 
cmpl(ø,rosten,østre_rosten). 
cmpl(østmarka,[psykiatriske,sykehus],østmarkveien). 
cmpl(østmarka,psykiatriske,østmarkveien). 
cmpl(østmarka,sykehus,østmarkveien). % (Østmarkveien15). Avoid underspecified "sykehus"
cmpl(østre,eberg,østre_berg). 
cmpl(østre,ber,østre_berg). 
cmpl(østre,berg,østre_berg). %% AtB 
cmpl(østre,roten,østre_rosten).         %% RS-150111. Spell-check. Synplace?
cmpl(østre,være,være_østre). 
cmpl(øverste,singsaker,singsaker).  %% EOB:-)
cmpl(øvre,[charlottenlund],skovgård). 
cmpl(øvre,[eberg],østre_berg). 
cmpl(øvre,[flatås,v],øvre_flatåsveg).  %%v=ved#sms
cmpl(øvre,[flatås,veg],øvre_flatåsveg). 
cmpl(øvre,[flatås,vei],øvre_flatåsveg). 
cmpl(øvre,[romolslia],romolslia_øvre). 
cmpl(øvre,alle,'Øvre Allé'). 
cmpl(øvre,berg,østre_berg).  %% similar sound,rightplace?
cmpl(øvre,byåsen,ugla).  %% ???
cmpl(øvre,flatås,øvre_flatåsveg). 
cmpl(øvre,flatåsen,øvre_flatåsveg). 
cmpl(øvre,flatåsvei,øvre_flatåsveg). 
cmpl(øvre,høgreina,høgreina_øvre). 
cmpl(øvre,jakobsli,jakobslivegen_øvre).  %% iv_!#¤ %%changed?  %% feil rute 66
cmpl(øvre,jakobsli_street,jakobslivegen_øvre).  %% street ?
cmpl(øvre,møllenberg,gyldenløves_gate). 
cmpl(øvre,romolslia,romolslia_øvre). 
cmpl(øvre,rosten,østre_rosten). 
cmpl(øvre,singsaker,singsaker). 
cmpl(øvreflatås,veg,øvre_flatåsveg). 
cmpl(øvreflatåsen,veg,øvre_flatåsveg).
cmpl(øvremøllenberg,gate,øvre_møllenberg_street). 
cmpl(øya,helsehus,øya_helsehus). %RS-110926

cmpl(å,[berggårdsvei],arne_bergsgårds_vei). 
cmpl(å,grevskottsvei,anton_grevskotts_veg). 
cmpl(ås,skole,åsveien_skole).  %%?
cmpl(åsheim,[ungdom,skole],åsheim_skole). 
cmpl(åsheim,[videregående,skole],åsheim_skole).  %% ? 
cmpl(åsheim,ungdomsskole,åsheim_skole). 
cmpl(åsv,skole,åsveien_skole). 
cmpl(åsveien,skolen,åsveien_skole). 
cmpl(åsvenein,skole,åsveien_skole).  %% ?
cmpl(byåsen, kirke, martin_stokkens_veg).

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ISAT   (STATION, PLACE), or
% ISAT   (Station, Neighbourhood)?      %% RS-160110    Neighborhood could be a STATION name? No, use corr/2 instead for stations
%  STATION is (one, but NOT preferred, among several) stations that belong to the NEIGHBOURHOOD (PLACE)
%
%Examples:
%
% isat( lerkendal_stadion, lerkendal ).
% isat( lerchendal_gård, lerkendal ). 
%

%% SENTRUM (PLACE) FIRST - ALPHABETICALLY (on PLACE) BELOW
%% RS-140102    REMEMBER: hovedterminalen (used for corr)  vs.  sentrum (used for isat, sentrum as a PLACE) ?

%% ISAT   (STATION, PLACE)
isat( olav_tryggvasons_gate_ot1, hovedterminalen ).    %% RS-121223 RS-141104 Sommer vs. vinter!?
%%isat( hovedterminalen, dronningens_gate ).  %% Where is sentrumsterminalen
%%isat( hovedterminalen, kongens_gate ).  %% RS-130812 Where is sentrumsterminalen, men unngå:  Holdeplassen nærmest Kongens_gate er Sentrumsterminalen ??
isat( hovedterminalen, munkegata ).  %%
isat( hovedterminalen, sentrum ).  %% Experiment Trikk St. Olavs. gt og så sentrum

isat(stavset_senter_syd, stavset_senter).
isat(stavset_senter_nord, stavset_senter).
isat(orkanger_torg, torget_orkanger).

isat(hallset, migosenteret).
isat(olav_tryggvasons_gate_ot2, nova_kinosenter).
isat(nidarosdomen, prinsen_kinosenter).

%isat( dr_gate_d1, sentrum ).   %% AtB 2015 format  %% RS-150815 Get rid of sentrum? Keep just as synonym/sameas/etc to hovedterminalen? 
%isat( dr_gate_d2, sentrum ).   %% RS-151219 isat requires the stations to be "real stations". Idea: Try using discrepencies2( Fake, Real ) to avoid this?
%isat( dr_gate_d3, sentrum ). 
%isat( dr_gate_d4, sentrum ). 
isat( dronningens_gate, sentrum ). %% AtB (2014-feb) format
isat( dronningens_gate_d1, sentrum ). %% AtB (2014-feb) format
isat( dronningens_gate_d2, sentrum ). 
%%isat( dronningens_gate_d3, sentrum ). 
%%isat( dronningens_gate_d4, sentrum ). 

isat(moholt_studentby, moholt).
isat(moholt_omkjøringsvei, moholt).
isat(moholt_storsenter, moholt).

isat(buran_1, buran).
isat(buran_2, buran).
isat(buran_3, buran).

isat(buran_1, lademoparken).
isat(buran_2, lademoparken).
isat(buran_3, lademoparken).

isat(buran_1, næringssenteret).
isat(buran_2, næringssenteret).
isat(buran_3, næringssenteret).

isat(østre_berg, østre_berg).
isat(østre_berg_2, østre_berg).

isat(charlottenlund_vgs, brundalen_skole).

isat(lade_idrettsanlegg, haakon_vii_gate).
isat(haakon_vii_gate_25, haakon_vii_gate).

isat(jørgen_b_lysholms_vei, fagerheim_alle).
isat(høgskoleringen, gudes_gate).

isat(heimdalsvegen_73, heimdalsvegen).

isat(kongens_gate_k1,sentrum). %% AtB
isat(kongens_gate_k2,sentrum). 

isat(skovgård_1, skovgård).
isat(skovgård_2, skovgård).

%isat(munkegata_m1,sentrum). 
%isat(munkegata_m2,sentrum). 
%%isat(munkegata_m3,sentrum). %% Removed winter 2014? 
%isat(munkegata_m4,sentrum). 
%isat(munkegata_m5,sentrum). 

%isat( olav_tryggvasons_gate, sentrum ).    %% RS-121223 Nightbus-station?

isat(st_olavs_gate,sentrum).  %% not AtB. %% RS-141115. Yes! AtB includes Everything now?!?

%isat(prinsens_gate_p1,prinsens_street). %% RS-131007 - 140102
%isat(prinsens_gate_p2,prinsens_street). %% RS-140102 See db/regstr.pl
isat(prinsens_gate_p1,sentrum). %% RS-140428
isat(prinsens_gate_p2,sentrum). %% RS-140428... But  See db/regstr.pl
isat(prinsens_gate_p1,prinsenkrysset). %% TA-110822  %% RS-141102
isat(prinsens_gate_p2,prinsenkrysset). %% RS-141102
isat(kongens_gate_k1,prinsenkrysset). %% RS-141102
isat(kongens_gate_k2,prinsenkrysset). %% RS-141102
%isat(prinsens_gate_p3,sentralbadet).

%% isat(britannia_hotell,sentrum). %%  FlyBuss? %% not AtB


%% ALPHABETICALLY (STATION, PLACE), sorted on PLACE

%isat( astronomveien, krokstien ).      %% RS-160110 Stations! Use corr/2 ? %% RS-160101 astronomvegen med g is a station! vei med i is not?
%isat( krokstien, astronomveien ).      %% RS-160110 Stations! Use corr/2
isat( astronomvegen, krokstien ).      %% RS-160110 Stations! Use corr/2 ? %% RS-160809 astronomvegen med g is a station! vei med i is not?
%isat( krokstien, astronomvegen ).      %% RS-160110 Stations! Use corr/2

isat( bratsberg_kirke, bratsberg ). %% TA-110325
isat( siemens, bratsbergsvegen ).

isat( bromstadsvingen, bromstad ).
isat( bromstadvegen, bromstad ).
%isat( brøsetvegen_168, brøsetvegen). %% RS-150104. Removed winter 2014?
%%isat( byåsen_butikksenter, byåsen). %% RS-131117

isat( charlottenlund_kirke, charlottenlund). 
isat( charlottenlund_nedre, charlottenlund). 

%isat( city_syd_e6_1, city_syd ). %% RS-130818  %% RS-190101
isat( city_syd_e6, city_syd ). %% RS-130818  %% RS-190101
%% isat( city_syd_sentervegen, city_syd ). %% TA-110627  %% RS-190101 Just one station at City Syd now.
%% isat( city_syd_østre, city_syd ).  %% TA-100901 %% City Syd Østre no longer a station. %% RS-2019.09.26
%isat( john_aae_s_veg, city_syd).   %%
%isat( kvt, city_syd ).             %%

isat( fagerliveien,fagerliv). %% Panic %% AtB TA-101010
isat( flatåstoppen,flatåsen). % 7,17
isat( framveien,byåsen). 

isat( gartnerhallen,ikea). %%  (?)

%% isat( hesthagen,gløshaugen). %% RS-170626  %% RS-190919
isat( gløshaugen,prestegårdsjordet). %% AE-20200703
%isat( gløshaugen_nord,gløshaugen). 
%
%isat( gløshaugen_nord,nth). 
%isat( gløshaugen_nord,hesthagen). 

isat( gløshaugen,nth). 
isat( hesthagen,nth). %% RS-170626  %% RS-190919
isat( prestegårdsjordet,nth). %% RS-170626

%isat( haakon_vii_gate_17,haakon_vii_gate). 
%isat( haakon_vii_gate_25,haakon_vii_gate). 
%%isat( haakon_vii_gate_29,lade_alle_80).
%%isat( haakon_vii_gate_29,lade_alle_80).
%isat( haakon_vii_gate, lade_idrettsanlegg). %% RS-2019.09.27

% isat(haukåsen,haukåsen).  %% RS-130330, hva skjer her? %% RS-140502. Haukåsen station removed from AtB's routes 140102
%isat(heggstadmoen,heggstadmoen_4).
%isat(heggstadmoen,heggstadmoen_2).

isat( heimdal_stasjon, heimdal ).
isat( heimdal_stasjon, heimdal_sentrum).

%isat (STATION, PLACE).
%% isat(hommelvik_skole,hommelvik).  %% RS-140614 not since 2013? No longer auto-generated
isat( hommelvik_stasjon,hommelvik_skole).     %% RS-130627 %% Different route from hommelvik_stasjon
isat( hommelvik_stasjon,hommelvik).
%% isat( hommelvikhøgda,hommelvik). %% RS-130627 %% Outside? Same departing busses...

isat( studentersamfundet, høyskoleparken ).

isat( klæbu_sentrum, klæbu ).  %% AtB %% Synplace?
isat( jørgen_b_lysholms_vei, lade_arena ).     %% Bussen står og venter her ganske lenge!  %% RS-141122  Se lade_alle_80

isat(kroppanmarka,kroppanmarka_snuplass). %%RS-120305

%%%%%%placestat( lade, lade_alle_80 ).  %% ( lade-alle_80 more passages => PREFERRED!) %%¤¤¤ %% ulykke AtB %% TA-100715
%% isat( city_lade, lade ).   %% RS-130625 %% Sommerrute-løsning
isat( lade_gård, lade ).   %% RS-130625 %% Nattbuss-løsning

isat( lade_allé_80, lade).
isat( lade_allé_80, lade_arena ).              %% RS-141122  Moved to isat (station, place)

isat(lerkendal_stadion,lerkendal). 
%isat(lerchendal_gård,lerkendal).   %% ? Move to spellcheck somewhere?... Synplace?
isat(lerkendal_gård,lerkendal).   %% ?

isat(loholtbakken,loholt). 
isat(lohove,loholt). 

isat( vikhammer, malvik_vgs ).
isat( markaplassen_skole, vikåsen).
isat(moholt,lingit). %% Ad HOC, best conn from NTH
isat(moholt_storsenter,lingit).

isat( nedre_humlehaugen_øst, ranheim_kirke ).  %% RS-130302 Ranheim Kirke Replaced by Nedre Humlehaugen Øst except morning ride. %% RS-151219 Always in Christmas?

isat( nordre_flatåsen, flatåsen ). %7
%% isat(nordre_hoem,hoem). %% not AtB
isat(olav_tryggvasons_gate_ot2,royal_garden). 

isat(okstad_østre,kroppanmarka).        %% RS-140614

isat(moholt_omkjøringsvei,omkjøringsveien). 
isat(nardo_omkjøringsvei,omkjøringsveien). 

%isat( orkanger_skole, orkanger ).
isat( orkanger_skysstasjon, orkanger ). %% Preferred because end-station? %% RS-150823
%isat( torget_orkanger, orkanger ).

isat( dalen_hageby,persaunetveien). %% RS-130625 AD-HOC. persaunvegen burde egentlig inkludere alle stoppene i den "vegen", ikke bare svare "kan ikke finne flere ruter..." (til "peraunvegen isa station")
%isat( persaunvegen,persaunetveien). 


isat( ranheim_fabrikker,ranheim). 
isat( ranheim_idrettsplass,ranheim). %% TA-110426
%isat( ranheimsfjæra, ranheim_stasjon ).
%isat( ranheim_kirke, ranheim_kirke ).  %% RS-130302 Ranheim Kirke Replaced by Nedre Humlehaugen Øst except morning ride 

isat( ringve_museum,ringve). 
isat( ringve_skole,ringve). 

isat(asbjørn_øverås_veg, risvollan). %% RS-150629 %% RS-150813 Missing in autumn?
isat(gyldenløves_gate,rosenborg). %% AtB %% RS-150813 Missing in autumn?

isat(romolslia, romolslia). %% RS-150111. Trøbbel? Both station and neighborhood.
isat(romolslia_øvre, romolslia). %% RS-150111. Trøbbel? HACK!! (Switched station and neighborhood!)

isat(bratsbergvegen,sluppen).  %% postterminalen på sluppen
isat(sluppen_1, sluppen).
isat(sluppen_2, sluppen).
isat(sluppen_3, sluppen).
isat(sluppen_4, sluppen).
%isat(solbakken_bru,solbakken).  %% Sommer discrepancy %% AE - 200714
isat(solbakken_skole,solbakken). 
%isat(st_olavs_gate,sentrum).  %% not AtB. %% RS-141115. Yes! AtB includes Everything now?!? RS-151219 Moved to other sentrum-station above
isat(stavset_senter,stavset).
isat( strandveikaia, ringnes ).
isat( strandveikaia, ec_dahls_bryggeri ).

isat(søndre_flatåsen,flatåsen). %7
isat(olav_tryggvasons_gate_ot3,søndregate). 
%isat(olav_tryggvasons_gate_ot3,søndregate). 
isat(olav_tryggvasons_gate_ot3,royal_garden). 
%% isat(søndre_hoem,hoem). %% not AtB

% ISAT   (STATION, PLACE)
%STATION is (one, but NOT preferred, among several) stations that belong to the neighbourhood of PLACE
%% ISAT    ( Station , Neighbourhood )

isat( lykkmarka, sjetnmarka ). %% Nightbus ..... Some summer discrepancie? TODO: fix when lykkmarka is back on table, for some reason buss 45 is not included in gtfs data
isat( paul_skolemesters_veg, sjetnmarka ). 

isat(tanem_bru, tanem). %% RS-150111 Langt unna
isat(tanem_gård, tanem). %% RS-150111
isat(tanemskrysset, tanem). %% RS-150111
isat(tanemsmoen, tanem). %% RS-150111
              
isat(lerkendal,tempe).  %%NB
isat(tempevegen_11,tempe). %% AtB
isat(tonstadkrysset,tonstadkrysset).  %%4

isat(travbanen,ikea). %%  (?)

isat(trollahaugen_10,trollahaugen). 
isat(trollahaugen_2,trollahaugen). 
isat(trollahaugen_46,trollahaugen).  %% 11->trollahaugen 64,75->trolla
%% isat(trollahaugen_64,trollahaugen). 

isat(trondheim_s_10,ts). %% SUMMER %% TA-110627
%%isat(trondheim_s_11,ts). %% Terminated WINTER %% RS-150104
isat(trondheim_s_13,ts). %%

isat(tvetestien,cecilienborg).  %% RS-130330, Cecilienborg finnes ikke lenger?

isat(tyholt,tyholt).  %% Hvilke holdeplasserer på tyholt?

isat(valøyvegen,tempe).  %% valøyveien stationname!
%isat(vestlia,steinan).   %%  NOT placestat      %% RS-150104. Vestlia was terminated
%isat(vestlia,vestlia).   %%NB!!!                %% RS-150104. Vestlia was terminated
isat(vestlia_endeholdeplass,steinan).  %%Haz? NOT placestat. %% RS-150104. Vestlia was terminated
isat(vestlia_endeholdeplass,vestlia). 
isat(voll_gård,voll). 
isat(voll_studentby,voll). 


isat(østre_berg,berg_østre). %% AtB  tricky
isat(østre_rosten,city_syd).    %% Ø R must be station
isat(øvre_flatåsveg,flatåsen). % 9,17 

isat(brekstad_ferjekai, brekstad).
isat(brekstad_hurtigbåtkai, brekstad).
isat(brekstad_kai, brekstad).

isat(lerkendal, lerkendal_stadion).

isat(kristiansund_hurtigbåtkai, kristiansund). %% There are just one "station" that atb know about in kristiansand, so we may reference just the one as kristiansund
isat(hitra_hurtigbåtterminal, hitra).
isat(kjørsvikbugen_hurtigbåtkai, kjørsvikbugen).
isat(edøy_hurtigbåtkai, edøy).
isat(ringholmen_kai, ringholmen).

isat(mausundvær_kai, mausundvær).
isat(jøa_hurtigbåtkai, jøa).

isat(stabells_veg, munkvoll_gård).
%isat(hovedterminalen, britannia).
%isat(hovedterminalen, britannia_hotell).

isat(hallset, martin_stokkens_veg).

isat(nardokrysset, tors_veg).
isat(nardo_omkjøringsvei, tors_veg).

% ISAT   (STATION, PLACE)
%STATION is (one, but NOT preferred, among several) stations that belong to the neighbourhood of PLACE
%% ISAT    ( Station , Neighbourhood )

%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%% PLACE_RESOLVE (PLACE,STATION).
% STATION is one of several determinations for PLACE
% Examples:
% place_resolve(charlottenlund,charlottenlund_krk).
% place_resolve(charlottenlund,charlottenlund_nedre).
% place_resolve(charlottenlund,charlottenlund_skole).
% In answer:
% Stedet Berg er flertydig .
% Mulige alternativer er: Berg Prestegård , Berg studentby , Østre Berg  .
%%%

place_resolve(badestranda,korsvika). 
place_resolve(badestranda,øysand). 

%% place_resolve(bakli,baklia). 
%% place_resolve(bakli,blakli). 

%% place_resolve(berg,berg_prestegård). %% RS-190101 Bus 60 no longer stops at Berg Prestegård!
place_resolve(berg,berg_studentby).
place_resolve(berg,østre_berg).


place_resolve(byåsen,byåsen_butikksenter). %% RS-131117
place_resolve(byåsen,byåsen_skole). %% RS-131117
place_resolve(byåsen,byåsenvgs). %% RS-131117


place_resolve(charlottenlund,charlottenlund_kirke). 
place_resolve(charlottenlund,charlottenlund_nedre). 
place_resolve(charlottenlund,charlottenlund_skole). 
place_resolve(flybussterminalen,lerkendal_stadion). 
place_resolve(flybussterminalen,royal_garden). 
place_resolve(flybussterminalen,studentersamfundet). 
place_resolve(flybussterminalen,ts). %% AtB. 
place_resolve(hageby,brøset_hageby). 
place_resolve(hageby,dalen_hageby). 
place_resolve(hageby,strindheim_hageby). 
place_resolve(hist,østre_berg).  %%TØH
place_resolve(hist,gartnerhallen).  %%AMT
place_resolve(hist,gildheim).  %%AHS
place_resolve(hist,rotvoll_alle).  %%ALT
place_resolve(hist,rotvoll_nedre).  %%ALU
place_resolve(hist,hovedterminalen).  %%AiTel

place_resolve(idrettsplassen, jakobsli_idrettsplass).
place_resolve(idrettsplassen, øya).

place_resolve(kino,olav_tryggvasons_gate_ot2).  %%
place_resolve(kino,nidarosdomen). 
place_resolve(kino,rosendal). 

%place_resolve( lade_arena, lade_alle_80 ).              %% RS-141122  Moved to isat (station, place) %% Moved to alias_station
%place_resolve( lade_arena, jørgen_b_lysholms_vei ).     %% Bussen står og venter her ganske lenge!  %% RS-141122

place_resolve(ntnu,dragvoll). 
place_resolve(ntnu,gløshaugen).  %% try without GløsS
place_resolve(ntnu,kalvskinnet). 
place_resolve(ntnu,gjøvik). 
place_resolve(ntnu,ålesund).

place_resolve( orkanger, orkanger_skole). %% RS-131222 % NOT Preferred
%place_resolve( orkanger, orkanger_skyss ). %% Preferred because end-station? %% RS-150823

place_resolve(prestegården,berg_prestegård). 
place_resolve(prestegården,prestegårsjordet).  %%gårdj
place_resolve(rutebilstasjonen,hovedterminalen). 
place_resolve(rutebilstasjonen,leuthenhaven). 
place_resolve(rutebilstasjonen,ts). %% AtB. 

place_resolve(solbakken,solbakken_bru). %% TODO: switch on when available again
%place_resolve(solbakken,solbakken_skole).  %%solbakken->solbakken_bruaftersummer06,

place_resolve(sorgendal,lerkendal). 
place_resolve(sorgendal,sorgenfri). 

place_resolve(st_olav,st_olavs_gate).
place_resolve(st_olav,st_olavs_hospital).

place_resolve(strinda,strinda_kirke).
place_resolve(strinda,valentinlystveien).

place_resolve(studentbyen,berg_studentby). 
place_resolve(studentbyen,moholt_studentby). 
place_resolve(studentbyen,prestegårdsjordet).  %% lerkendal studentby
place_resolve(studentbyen,vestlia).  %% steinan studentby
place_resolve(studentbyen,voll_studentby). 

%place_resolve(tanem, tanem_bru). %% RS-150111 Langt unna. Using isat/2 instead.
%place_resolve(tanem, tanem_gård). %% RS-150111
%place_resolve(tanem, tanemskrysset). %% RS-150111
%place_resolve(tanem, tanemsmoen). %% RS-150111

/*  = godsterminalen_nsb
place_resolve(terminalen,terminalen). 
place_resolve(terminalen,hovedterminalen). 
place_resolve(terminalen,postterminalen). 
place_resolve(terminalen,ts). %% AtB. 
*/

place_resolve(universitetet,dragvoll). 
place_resolve(universitetet,gløshaugen). 
place_resolve(university,dragvoll). 
place_resolve(university,gløshaugen). 
place_resolve(vegmesterveien,vegmesterstien). 
place_resolve(vegmesterveien,veimester_kroghs_street). 


%%






%%% PLACESTAT  neighbourhood station
%¤ PLACESTAT  (PLACE,STATION)
%Examples;
%placestat(arbeidsmarkedsinstituttet,lade_alle_80).
%placestat('Hotell Augustin',torget).
%
%STATION is (one of?) the preferred /recommended nearest station to the
%neighbourhood of PLACE
%

%% Extra for tram? %% RS-151219
placestat(namsos_kai,namsos_hurtigbåtkai).
placestat(namsos_båt,namsos_hurtigbåtkai).

placestat(olav_tryggvasons_gate_ot1,sentrum). %% CORREC %% TA-101203 %% AtB %% TA-100715 %% RS-121223

placestat(atb,prinsenkrysset). %% TA-101108 

placestat(adm_rit,st_olavs_hospital). 
placestat('Adolf Øiens skole',nidarosdomen).  %%
placestat(adresseavisa,adresseavisen). 
placestat(alfheim,alfheimsvingen). 
placestat(alfheimsv,alfheimsvingen).  %% Forkortelse (alfheimsv i rutehefte)
placestat('ALT/Statoil',rotvoll).%% hist/ALT %% extra dep Bus 6 

placestat(amo_senteret,henrik_ourens_veg). 
placestat(angelltrøa,angelltrøvegen). 
placestat(angeltrøa,angelltrøvegen). 
placestat(arbeidsmarkedsinstituttet,lade_allé_80). 
placestat(arnebyen,ugla). 

placestat(atmel,maskinagentur). 

placestat(autronica,haakon_vii_gate_25). %% TA-110818

 
placestat(badeland,pirbadet). 
placestat(bakkaunet,rosendal). 
placestat(bakkebru,bakkegata). 
placestat('Bakke kirke',bakkegata).  %% Syndrome Hvor er bakke kirke
placestat(balders_street,tors_veg).  %% street
%% placestat(barneklinikken,st_olavs_hospital_vest).  %% ????????
placestat(bassengbakken,solsiden). 
placestat(beddingen,solsiden). 
placestat(befalsskolen,festningsgata). 

%% placestat(berg,østre_berg). 
%% also station on obscure route 73 (not in busrutehefte)

placestat('Berg arbeidskirke',strinda_vgs). 
%placestat(bergstudentby,bugges_veg). 
%placestat(bergsvingen,harald_bothners_veg).  %% øvre/nedre
placestat(bi,pirbadet). %%  BI
placestat(bi,østre_rosten). 

placestat(bilcentrum,leangen_allé). %%  Garage
placestat(bilsakkyndige,e_verket). 
placestat(bilsakskyndig,e_verket). 
placestat(biltema,rostengrenda).  %% Østre rosten 22 (not garage)
placestat(biltilsyn,e_verket). 
placestat(biltilsynet,e_verket). 
placestat(bispegata,nidarosdomen). 
placestat(bispegården,nidarosdomen). 
placestat(bispehaugenskole,bakkegata). 
placestat(bjørndal,bjørndalsbrua). 
%% placestat(blaklia,blakli).
placestat(blaklihøgda,blakli). 
placestat(blindeforbundet,churchills_veg). 
placestat(blindeskolen,churchills_veg). 
placestat(blomsterbyen,fiolsvingen). 
placestat(blåklokkevegen,fiolsvingen). 
%% placestat(bohus,brøsetvegen_186). 
%% placestat(brannstasjonen,brannstasjon_øst). %% TA-110822
%% placestat(bratsberg,bratsberg_vestre). 

%% placestat(brattøra,pirbadet). 

placestat(brattørkaia,brattøra). 
placestat(brattørkaien,brattøra). 
placestat(bratørkaia,brattøra). 
placestat(bratørkaien,brattøra). 


%%% placestat(brit_grytbakks_street,gryta). 

placestat(britannia,hovedterminalen).  %% (Britania by spch)%% airbus
placestat(britannia_hotell,hovedterminalen). %% Does not have airbus issues with normal buss that goes in that direction

placestat(bromstadkrysset,bromstadsvingen). 
placestat(brøset,brøsetflata). 
%% placestat('Brøset sykehus',brøsetvegen_119).
placestat(brøsetsvingen,bromstadsvingen). 
placestat(bussgarasjen,sorgenfri). 
placestat(byavisa,nardokrysset).  %%?
placestat(bymarka,skistua).  %%
placestat(byneset,trolla). 
placestat(bytorget,hovedterminalen).  %%avoidhplnærtorgetertorget
%% placestat(byåsen_butikksenter,byåsen_butikksenter). %% TA-110627
placestat(byåsen_videregående_skole,hallset). %% byåsen_videregående_skole neibourhood

placestat(cathedral,nidarosdomen). 
placestat(ceciliebrua,tvetestien). 
%placestat(charlottenlund_skole,churchills_veg).  %% Ungdomsskole/Videregående?
placestat(charlottenlund_skole, tunvegen ).  %% Ungdomsskole/Videregående? %% RS-150912
placestat(charlottenlund_videregående,charlottenlund_vgs). 
%% placestat(charlottenlundbanen,churchills_veg).
placestat(charlottenlundhallen,churchills_veg). 
placestat(charlottenlundhallen,tunvegen).  %% Tunveien18B,Jakobsli
placestat(chr_eggens_veg,bjarne_ness_veg). 
placestat(church,nidarosdomen). 
placestat(cicilliebrua,tvetestien). 
placestat(city_hall,nidarosdomen). 
placestat(clarion_hotell,brattøra).
placestat('Comfort Hotel Park',nidarosdomen).

placestat(dalen,dalen_hageby). 
placestat(dalenhageby,dalen_hageby). 
placestat('Dalgård skole',dalgård).  %%
placestat(dalsaune,dalsaunevegen). 
placestat(dalseng,hesthagen). 
placestat(dalsenget,hesthagen). 

placestat(devlegård,olav_engelbrektssons_allé).

placestat(bilbyen,nidarvoll_skole). %%  bratsbergvegen 17. // garage
placestat(dinbil,nidarvoll_skole).  %%  bratsbergvegen 11. // garage
placestat('Din bil',nidarvoll_skole).  %% bratsbergvegen 11
%placestat(dis,gløshaugen). %% TA-110401 Division of Intelligent Systems? %% RS-170626

placestat(dmmh,dalen_hageby). %% TA-110301

placestat(dokkparken,solsiden). %%  // Changed name !

placestat(dokkhuset,solsiden).
placestat(dokksiden,solsiden). 
placestat(dokkterminalen,solsiden).  %% ? 
placestat(domen,nidarosdomen). 
placestat(domkirka,nidarosdomen). 
placestat(domkirken,nidarosdomen). 

%% placestat(dora,dora_1).  
placestat(dorahallen,dora). 

placestat(dronningens_gate,hovedterminalen).  %% jeg skal til dronningens gate. 
placestat(dronningens_street,hovedterminalen).  %% Technical
placestat(døveskolen,skyttervegen).  %%

placestat('Eberg skole',teglverkskrysset).
placestat(ekle,eklesbakken). 
placestat(elgeseter,hesthagen). 
placestat(elgsetergata,hesthagen).  %% \+ sæterbakken
placestat(erkebispegården,nidarosdomen). 

%% placestat(esso_motorhotell,brøsetvegen_186). %% Old name ! 

placestat(estenstad,loholtbakken). 
placestat(estenstadmarka,loholtbakken). 
placestat(fagerheim,jørgen_b_lysholms_vei). 
placestat(fagerlia,fagerliveien). 
placestat(fagerlien,fagerliveien). 
placestat(falkenborg,dalen_hageby). 
placestat(felleskjøpet,gartnerhallen). 
placestat(fengsel,tunga_kretsfengsel). 
placestat(fengselet,tunga_kretsfengsel). 
placestat(festningen,ankers_gate). 
placestat(festningsparken,ankers_gate).  %% ?
placestat(filmteatret,nidarosdomen). 
placestat(fischebygget,studentersamfundet). 
placestat(flatåsen,flatåstoppen). %Nightbus
placestat(flatåsensenteret,flatåsen_senter). 
placestat(flatåsenskole,flatåsen_senter). 
placestat(flatåsvegen,øvre_flatåsveg). 
placestat(fokushallen,vestre_rosten). 
placestat(fosenferja,pirbadet).
placestat(fosenterminalen,pirbadet). 
placestat(fossesenteret,fossegrenda). %% Leirfossvegen 45
%%cmpl(fossesenteret,[],fossesenteret). %% RS-120805      How? Necessary? 
placestat(fossestuvegen,nedre_leirfoss).   %% RS-150111

placestat(gartnerhagen,gartnerhallen). 
placestat(gilde,gartnerhallen). 
placestat(gildheimsveien,gildheim). 
placestat(gløshaugen,gløshaugen).  %% Avoid Gløs S/N messages %% RS-180813
placestat(godsterminalen,terminalen). 
placestat(granåsen,granåsen_vm_anlegget). 
placestat(grillstad,grilstadkleiva). 
placestat(grilstad,grilstadkleiva). 
placestat(grilstadfjæra,grilstadkleiva). 

placestat(hallset,hallset).  %% nordre søndre 
placestat(halset,hallset).   %% nordre søndre
placestat(hallsetvangen,hallset). %% RS-150104. Halset/Hallset Summer/Winter naming problem. 
placestat(hanger,hangeråsen). 
placestat(hangersletta,hangeråsen).  %% aasen UN properstation
placestat(hangerås,hangeråsen).  %% necessary because laura hangerås veg
placestat(hansbakkfjæra,granåsvegen).  %% map 
placestat(harbour,pirbadet).  %% English the harbour
%placestat(haukvatnet,haukåsen).        %% RS-140502. Haukåden was removed from AtB's routes 140102 
placestat(haukvatnet,dalgård).          %  placestat(haukvatnet,lian).

placestat(havna,pirbadet).
placestat(havna,pirbadet).  %%?
placestat(havnen,pirbadet).
% placestat(havstad,havstadsenteret).   %% RS-160119 Havstad is now a station (bus 18), no longer neighborhood? 
placestat(havstadflata,havstadsenteret). 
placestat(havstein,havstadsenteret). 
placestat(havsteinekra,stabells_veg). %%% ?? helse og velferdssenter
placestat(havsteinflata,havstadsenteret). 
placestat(havsteinflaten,havstadsenteret). 

placestat('Heimdal politistasjon',heimdal_stasjon).  %%
placestat(heimdalsentrum,heimdal_stasjon). 
placestat(hoeggen,hoeggen_skole). 
placestat(holtermannsveien,valøyvegen). 
placestat(horneberg,hornebergvegen). 
placestat(hospitalløkka,hospitalskirka). 
placestat(hospitalløkkan,hospitalskirka). 
placestat(hospitalløkken,hospitalskirka). 
placestat(hospitalsløkkan,hospitalskirka). 
placestat(hospitalsløkka,hospitalskirka). %% hospitalslokka 
%% placestat(hostel,weidemannsveien). %% * P-hotels %% TA-101202
placestat('Hotell Augustin',hovedterminalen).  %% Brage 
placestat(hurtigbåten,pirbadet). 
placestat(hurtigbåtkaia,pirbadet). 
placestat(hurtigbåtkaia,pirbadet). 
placestat(hurtigbåtkaien,pirbadet). 
placestat(hurtigbåtterminalen,trondheim_hurtigbåtterminal). 

%% placestat(hurtigruta,pirbadet). %% Haz, boat
 
placestat(hurtigrutekaia,pirbadet).
placestat(hurtigrutekaien,pirbadet). 
placestat(hurtigruten,pirbadet). 
placestat(hurtigruteterminalen,pirbadet). %% ?
placestat(huseby,husebytunet_1).  %% \+ synplace
placestat(huseby,husebytunet_2).  %% \+ synplace
placestat(huseby,husebytunet_3).  %% \+ synplace
placestat(husebybadet,saupstadsenteret). 
placestat(husebyhallen,saupstadsenteret). 
placestat(husebysenteret,saupstadsenteret). 
placestat(husebytunet,husebytunet_1).  %% \+ synplace
placestat(husebytunet,husebytunet_2).  %% \+ synplace
placestat(husebytunet,husebytunet_3).  %% \+ synplace
placestat(hårstad,martin_kregnes_veg). 
placestat(hårstadmarka,martin_kregnes_veg). 
placestat(hårstadmyra,martin_kregnes_veg). 

placestat(idi,gløshaugen). %% TA-110401
placestat(idrettsbygget,høgskoleringen). 

placestat(idrettsplassen, jakobsli_idrettsplass). %% RS-150104. Name-change. Summer/Winter? %% RS-150814 Doesn't work in autumn %% TODO RS-190101

placestat(ilabekken,ila). 
placestat(iladalen,ila).
placestat(ilakirke,ila). 
placestat(ilaparken,ila). 
placestat(ilevolden,ila). 
placestat(ilevollen,ila). 
placestat(ilevollene,ila). 

%% placestat(ilsvika,ila). %% station
placestat(ilsvikøra,ilsvika). 

placestat(industribygget,solsiden). 
placestat(innherredsveien,solsiden). 
%% placestat(ishallen,bromstadsvingen). %% TA-101124 Station!
%placestat(jonsvannet,solbakken_bru). 
placestat(jonsvannsveikrysset,jonsvannsveien). 
placestat(kaia,pirbadet). 
placestat(kanalen,solsiden). 
placestat(karinelund,strinda_kirke). 
placestat(katedralen,nidarosdomen). 
placestat(katedralskolen,nidarosdomen). 
placestat(kbs,strindheim).
placestat(kbs_senteret,strindheim).
placestat(kinosenteret,nidarosdomen). 
placestat(kirka,nidarosdomen).  %%Uncertain
placestat(klefstad,klefstadhaugen). 
placestat(klostergata,studentersamfundet).  %% (Øya?)_2
%placestat(klæbu,klæbu_sentrum).  %% klæbu_skysstasjon rutehefte/
%placestat(klæbu_skysstasjon,klæbu_sentrum).  %% klæbu_skysstasjon rutehefte/ %% RS-141101 Old
placestat(kolstad,casper_lundes_veg). 
placestat(kolstadflata,casper_lundes_veg). 
placestat(kolstadsenter,casper_lundes_veg). 
placestat(kolstadsenteret,casper_lundes_veg).  %%?
placestat(kolsås,flatåstoppen).  %% også Bærum
placestat(kolsåsen,flatåstoppen). 
placestat(kolsåstoppen,flatåstoppen). 
placestat(kongens_gate,hovedterminalen).  %% jeg skal til kongens gate. 
placestat(kongsvegen,granåsen_vm_anlegget). 
placestat(korsvika,krutthusbakken). 
placestat(kotenghallen,vestre_rosten). %%  private?
placestat(kretsfengselet,tunga_kretsfengsel). 
placestat(kristiansten,ankers_gate). 
placestat(kristianstenfestning,ankers_gate). 
%placestat(kuhaugen,gina_krogs_veg). 
placestat(kuhaugen,clara_holsts_veg).     %% RS-160809 NEW ROAD!
placestat(kvilhaugen,strinda_vgs).     %% RS-20190920 NEW ROAD!
%placestat(kyvannet,skavlans_veg). 
%placestat(kyvatnet,skavlans_veg). 
%% placestat(køff,leangenveien). %% TA-110822

%%¤¤¤ %% ulykke AtB %% TA-100715
%%%%%%placestat(lade,lade_alle_80).  %% ( lade-alle_80 more passages)
%%¤¤¤
placestat(lade_alle,lade_allé_80).  %%
%placestat(lade_arena,lade_alle_80).  %& RS-141122  Moved to isat (station, place)...
%placestat(lade_arena,jørgen_b_lysholms_vei).  %% Bussen står og venter her ganske lenge!  %% RS-141122

placestat(ladehammerveien,ladehammeren).  %%(manystations,
placestat(lademoen,rønningsbakken). 
placestat(lademoen_kirke,rosendal). 
 %% placestat(lademoen_skole,mellomv_5). 
%placestat(lademoparken,buran). 
%placestat(ladeparken,buran). 
placestat(ladeskolen,krutthusbakken). 
placestat(ladetorget,østmarkveien). 
%placestat(lamoparken,buran). 
placestat(langlohaugen,langlo). 
%placestat(larsbyen,olav_nygårds_veg). %% RS-150104. Summer/Winter naming problem 
placestat(larsbyen,olav_nygards_veg). %% RS-150104. Summer/Winter naming problem
placestat(leangen,travbanen). 
placestat(leangenhallen,bromstadsvingen). 
placestat(legard,legårdsbakken). 
placestat(legevakta,st_olavs_hospital). 
placestat(legevakten,st_olavs_hospital). 
placestat(leinstrand,leinstrand_samfunnshus). %% RS-140616 leinstrand_samfunnshus?
placestat(leira,leira_skole). 
placestat(leirbrua,leirbrua_gård). 
placestat(lerkendalskrysset,lerkendal_stadion). 
placestat(lerkendalsvegen,gløshaugen). 
placestat(leuthenhaven,hovedterminalen). 
%% placestat(lianvannet,lian). %% not AtB
placestat('Lilleby skole',ladeveien).  %% Ladeveien 1 
% placestat(lingit,moholt_storsenter). %% //confuse Lingit company
placestat(lingit,moholt). %% TA-110401
placestat(loholt_alle,lohove). 
%% placestat(louisenlyst,leangenveien).  %% Leangenveien3 %% TA-110822
placestat(luftkrigsskolen,persaunet_leir). 
placestat(lundhøgda,lundåsen_nordre).        %% RS-140616 lundåsen_n ?
placestat(lærerhøgskole,rotvoll). 
placestat(lærerhøgskolen,rotvoll). 

placestat(mamoz,fiolsvingen). %% nardo_street-16). 
placestat(marienborg,marienborg_stasjon).               %% RS-160108. Marienborg betyr stasjonen
placestat(marineborgstasjon,marienborg_stasjon).        %% RS-130330. Marienborg er utgått 
placestat(marinen,nidarosdomen). 
placestat(mediahuset,maskinagentur). 

placestat(norske_meierier,heggstadmoen_2). %% NB %% TA-110705

%% placestat(melkekartongen,city_syd). 

% placestat(migosenter,migosenteret). 
% placestat(migosenteret,migosenteret).  %% halset internal name

placestat(misjonskirken,nidarosdomen).  %% Arkitekt Christies gt
placestat(moholtkrysset,moholt_omkjøringsvei). 
placestat(moholtområdet,moholt). 
placestat(moholtsenteret,moholt_storsenter).  
placestat(moholtterasse,moholt).  %% ???
placestat(moholttun,moholt).
placestat('Motor Trade',fiolsvingen). %% Bilverksted
placestat(mts,magnus_berrføtts_veg).  %% Lazy complex
placestat(multiconsult,postterminalen). %% sluppenvegen 23 %% TA-110415
placestat(munkegata,hovedterminalen). 
placestat(møllenberg,solsiden). 

placestat(møller_bil,hallfred_høyems_veg). 

placestat(n_g_u,ringve_skole). 
placestat(naf,e_verket).  %% (?) SIC
placestat(nafsenteret,e_verket).  %%( ?) SIC
placestat(nardo,nardosenteret). 
placestat(nardobanen,fiolsvingen). 
placestat(nardoskole,nardokrysset). 
placestat(nardosletta,nardosenteret).  %% Names should not disappear
placestat(nardovegen,dybdahls_veg). 

placestat(nattbussterminalen,olav_tryggvasons_gate_ot1). %% CORREC %% TA-101203 %% AtB %% TA-100715
placestat(nattbussterminalen,hovedterminalen). %% CORREC %% TA-101203 %% AtB %% TA-100715

placestat(nedre_elvehavn,solsiden).  %%(?)
placestat(nedre_møllenberg,bakkegata). 
placestat(neptunveien,risvollan_senter). 
placestat('Ni muser',nidarosdomen). 
placestat(nidar,strindheim). 
placestat(nidarbergene,strindheim). 
placestat(nidarfabrikken,strindheim). 
placestat(nidaros,hovedterminalen).  %% New name for midtbyn 
placestat(nidarosdomen,nidarosdomen). 
placestat(nidarvoll,nidarvoll_skole). 
placestat(nidarvollsykehjem,nygård). 
%placestat(nidarø,trondheim_spektrum). %% not sum08
placestat(nidarø,skansen). %% RS-150913
%placestat(nidelvbrua,nidelv_bru).  %% nedlagt 22. mars %% TA-110822 %% RS-150814 
placestat(nidelvhallen,valøyvegen).  %% ?
placestat(nilsbyen,stavset_senter). 
placestat(nissekollen,fiolsvingen). 

%% placestat(nordre,nordre_gate).  %% nordre general//HAZARD

placestat(nordre_halset,hallset). %% renamed
placestat(nrk,strinda_vgs). 

placestat(nth,gløshaugen).  %%
placestat(nth,prestegårdsjordet).  %%

placestat(ntnu_lade,ingemann_torps_vei).  %% Changed Name %<---
placestat(ntnui,høgskoleringen).  
%placestat(nyhavna,nidelv_bru).  %%(?) %% nedlagt 22. mars %% TA-110822 %% RS-150814
placestat(nyveilia,bjørndalsbrua). 


placestat(okstadbrinken,kroppanmarka). 
placestat(okstadtunet,okstad). 
%placestat(olav_tryggvasons_gate,sentrum). %% CORREC %% TA-101203 %% AtB %% TA-100715 %% RS-121223 %% RS-151219 Moved to "sentrum-cluster" above
placestat(olavshallen,olav_tryggvasons_gate_ot2). 
placestat(olavskvartalet,olav_tryggvasons_gate_ot2). 
placestat(olavskvarteret,olav_tryggvasons_gate_ot2). 
placestat(olavsstatuen,hovedterminalen). 
placestat(olavsgården,strindheim). %% Thonning Owesens gate 20 

%% placestat(ole_aasveds_street,gryta). 


placestat(palmehaven,hovedterminalen). 
placestat(perleporten,gløshaugen). 
placestat(persaune,persaunet_leir). %neitherisspellch
placestat(persaunet,persaunet_leir). %neitherisspellch
placestat(pir,pirbadet). 
%% placestat(pirbadet,pirbadet). 
placestat(piren,pirbadet).
placestat(pirkaia,pirbadet). 
placestat(pirsenteret,pirbadet). 

placestat(pirterminalen,pirbadet). 

placestat(plantasjen,strindheim_hageby).  %% baldershage 18

%% placestat(politihuset,ts).   %% TA-100927
%% placestat(politistasjon,ts).    %% politihuset). %% Must be station
%% placestat(politi,ts).           %% politi i uniform %% amb 
%% placestat(politistasjonen,ts).  %% ?

 %% placestat(posthuset,postterminalen).  %%(\=p. h. isentrum)

placestat(prinsen,nidarosdomen). 
%placestat(prinsen,nidarosdomen).  %%NB PRINSEN is also a fictitious station
placestat(prinsenkino,nidarosdomen). 
%placestat(prinsens,prinsen_kinosenter).  %%(pga avertering) %% RS-140102 Veldig tvetydig: "prinsens gt p1" == To stopp og en gate?!
%placestat(prinsens_gate,prinsen_kinosenter). RS-140101. prinsens_gate_p1 (og _p2) er nye offisielle navn på sentrumstasjonen! 
%placestat(prinsens_gate,prinsens_gate_p1).     %% Doesn't work... Just one is the prefferred one. Use isat(X, prinsenkrysset)?
%placestat(prinsens_gate,prinsens_gate_p2).
%placestat(prinsens_gate,prinsenkrysset).
placestat(prøven,kroppan). 
placestat(prøvenbil,kroppan). 
placestat(radmannbygget,gildheim). %%  Ranheimsvegen 10
placestat(ramstadkrysset,ramstad). 

placestat( ranheim_kirke, nedre_humlehaugen_øst ). %% RS-130302 Overrides isat(ranheim_kirke,ranheim_kirke).   %% RS-151219 Reinserted

placestat(ravnkloa,hovedterminalen).  %%(Hazard?)

placestat(realfagbygget,gløshaugen). %% --- Telebuster house
placestat(regionssykehuset,st_olavs_hospital).  %%r_i_t_hovedporten). 
placestat(regionsykehuset,st_olavs_hospital).  %%r_i_t_hovedporten). 
placestat(reina,høgreina).  %%betterthanRena
%% placestat(reitgjerdet,brøsetvegen_119). 

placestat(reppevegen,vikelvveien). %% imcomprehensible route 777
placestat(reppeveien,vikelvveien). %% street reppeveien = osveien 
                                   %% reppevegn not in routes

placestat(reppemoen,reppe).        

placestat(rikshospitalet,st_olavs_hospital).  %%-> mess
placestat(ringvebukta,ringve_museum). 
placestat(rishaughallen,haakon_vii_gate_25).  %% (håkon 7 gate 23. )
placestat(risvollan,risvollan_senter). 
placestat(risvolltun,søndre_risvolltun). 
placestat(rit,st_olavs_hospital).  %% r_i_t_hovedporten). 
placestat(rockheim,pirbadet). %% Brattørkaia 14 %% TA-100927
placestat(rognbu,rognbudalen). 
placestat(rognbuveien,rognbudalen).  %%?
placestat(rogndalen,rognbudalen). 

placestat(rosenborghallen,gyldenløves_gate). %% TA-101025

%% placestat(rosenborg,gyldenløves_gate). %% isat (AtB/Team)
%% placestat(rosenborghallen,gyldenløves_gate). 

%% placestat(rosta,rostengrenda).  %% Rosten is station #43
%% placestat(rosten,rostengrenda).
%% placestat(rosten,rostengrenda). 

placestat(rostenhallen,østre_rosten). 
placestat(rostenkrysset,østre_rosten). 
placestat(rotvollfjæra,rotvoll).  %%?
placestat(rønning,rønningsbakken). 
placestat(rådhuset,hovedterminalen). 

placestat(sandgata,hospitalskirka).    %% RS-141021 TEMPORARY REMOVED, construction in kongensgt. %% RS-150104 Restarted
placestat(sandgata,hospitalskirka).    %% RS-141021 Sandgata er en ny (midlertidig) stasjon ifm veiarbeid i Kongensgt.
 
placestat(sandmoencamping,sandmoen). 
placestat(saupstad,saupstadsenteret). 
placestat(saupstadkrysset,saupstadsenteret).  %%?
placestat(saupstadskole,midteggen). 
placestat(saupstadvegen,heimdal_stasjon). 
placestat(saxenborg,dalen_hageby). 
placestat(schrøder,fossegrenda). 
%placestat(servicekontoret,dronningens_gate_d2).        %% RS-130812 Gammelt TT-kontor!
%%placestat(singsaker,asbjørnsens_gate). %% RS-131218. Moved towards Rosenborg Skole? 
placestat(singsaker_studenthjem,jonsvannsveien). 
placestat(sirkus_shopping,strindheim).
placestat(sjetne,carl_schjetnans_veg). 

placestat(sjetnmarka,carl_schjetnans_veg). %% not nightbus (103) Sjetnmarka
 %% bus_depend_station(103,sjetnmarka,paul_skolemesters_veg). %% nightbus anomaly

placestat(sjokoladefabrikken,strindheim). 
placestat(skippy,fossegrenda).  %% schrøder). 
placestat(skippysenteret,fossegrenda).  %%schrøder). 
placestat(skipsmodelltanken,magnus_berrføtts_veg). 
placestat(smistadgrenda,arnt_smistads_veg).  
placestat(smistadkrysset,arnt_smistads_veg). 
%% placestat(solbakkenbrua,osbrua). 
%% placestat(solsiden,solsiden). %% station %% TA-101130

%% placestat(sorgenfriveien,sorgenfri) :- \+ value(airbusflag,true).  %% (on the map)
%% krøll med airbus 

placestat(sosialhøgskolen,gildheim).  %% ???

placestat(spilleplassen,spillebakken). %% TA-110815

placestat(spongdalskole,spongdal). 

%% placestat(st_olavs_gate,torget). %%  \+ tramflag not used at AtB

placestat(stabbursmoenskole,heimdal_stasjon). 
placestat(statens_hus,nidarosdomen). 

placestat(statoil_rotvoll,rotvoll). %% TA-110627 ? isat? %% RS-150104

placestat(stavne,lerkendal).  %% confuse hvor langt er det fra stavne bro til breidablikk
placestat(stavnebro,lerkendal). %% RS-150104. Stavnebrua Station closed in 2014.

%%%                       placestat(steinan,vestlia).  %% NOT nattbussen

placestat('Steinan studentby',vestlia_endeholdeplass).
placestat(steinandalsvegen,steindalsvegen). 
placestat(steinanstudentby,vestlia_endeholdeplass). %% RS-150104. Used to be vestlia, 
placestat(steinanv,heggdalen). 
placestat(steinanvegen,heggdalen). 
placestat(steinanveien,heggdalen). 
placestat(steinberget,møllebakken). 
placestat(steindal,steindalsvegen).  %%<--???
placestat(steindalen,heggdalen). 
placestat(stiftsgården,hovedterminalen). 

placestat(stokkanhaugen,stokkhaugen).  %% SUMMER  %% TA-110627

placestat(stubban,venusvegen). 
placestat(studenterhytta,skistua). 

%placestat(studentersamfundet,studentersamfundet_1).  %% AtB %% NB \+ isat      %% RS-141020, changed name from s-samfundet_1 to s-samfundet %% This line messes up the next line?
                                                                                %%N: fra astrononmvegen til samf.
placestat(studentersamfundet,studentersamfundet).  %% AtB %% NB \+ isat         %% RS-141020    Feedback from Norvald Ryeng. studentersamfundet (K) and _1 are missing without this line!
%placestat(studentersamfundet,studentersamfundet_2).  %% TA-100922  %% RS-140901 %% Reverserte disse
placestat(stjørdal,stjørdal_stasjon).        %% RS-150815. New bus added 310/410.

placestat(sunnland,karl_jonssons_veg).  %%sunnlandskole
placestat(sunnlandskole,karl_jonssons_veg). 
placestat(svartlamon,buran).  %% NB veien
placestat(sverresborg,trøndelag_folkemuseum). 
placestat(sykehusbrua,tvetestien). 
%% placestat(sykehuset,st_olavs_hospital).  %% causes trouble sykehuset st olav
placestat(sykepleierhøgskolen,st_olavs_hospital). 
placestat(sykepleierhøyskolen,st_olavs_hospital). 
placestat(sykepleierskolen,st_olavs_hospital). 

%placestat(tanem, tanemsmoen). %% RS-150111     %% RS-150111. Using isat/2 instead.
placestat(tavern,trøndelag_folkemuseum). 
placestat(tavernaen,trøndelag_folkemuseum). 
placestat(teateret,nidarosdomen).       %% 
placestat(teatret,nidarosdomen).

placestat(tegleverksveien, teglverkskrysset).
placestat(teglgården,fossegrenda). 
placestat(teglverket,teglverkskrysset).  %%(tegle)

placestat(teknobyen,hesthagen).  %%(?)
placestat(teknostallen,hesthagen). 
placestat(telenorbygget,magnus_berrføtts_veg). 
placestat(tf,magnus_berrføtts_veg). 
placestat('Tiller kirke',moltmyra_øst).  
placestat(tiller,torvtaket). 
%% placestat(tiller,moltmyra).  %% moltmyra_øst//bare en retning
%placestat(tillerbruvegen,tiller_bru). %% sommer discrepancie ? %% switch back on when it is available again
placestat(tillerbyen,tonstadgrenda).  %%?koieflata). 

%% placestat(tillertorget,city_syd).  %% Ivar Lykkes veg 3 

placestat(tmv,solsiden).   %% TA-101214
placestat(tomasskolen,bakkegata). 
placestat(tonstad,tonstadkrysset). 
placestat('Torbjørn Bratts veg',fiolsvingen). 
placestat(transitten,brøset_hageby).  %% (nb transittgata->strandveien)
placestat(trikkehallen,hesthagen). 
placestat(trikkestallen,hesthagen). 
placestat(trondheim_spektrum, skansen). %% RS-150913
placestat(trondheim_torg,hovedterminalen). 
placestat(trondheimstorget,hovedterminalen). 
placestat(trondsletten,brøset_hageby). %% beh. senter
placestat(trønderenergi,tunga_kretsfengsel). 
placestat(tunga,tunga_kretsfengsel).  %%(tunga=tungata=tunv#)
placestat(tunhøgda,tunvegen).  %%midte,vestreøstre
placestat(tvetesvingen,tvetestien). 
placestat(tyholtområdet,tyholt). 
placestat(tøh,østre_berg). 
placestat(uglaskole,ugla). 
placestat(uranusveien,risvollan_senter). 
%%% placestat(utleira,utleirmark).  %% NBNB utleira SYNDROME %% TA-100921
placestat(utleirveien,nardosenteret). 
placestat(valentinlystsenter,valentinlyst). 
placestat(valentinlystsenteret,valentinlyst). 
placestat(valgrind,valgrindvegen). 
placestat(valgrinda,valgrindvegen). 
placestat(valøya,valøyvegen). 
placestat(valøygrenda,valøyvegen). 
placestat(vegvesen,postterminalen). 
placestat(vegvesenet,postterminalen). 
placestat(veitrafikktilsynet,e_verket). 
placestat(verdensteatret,nidarosdomen). 
placestat(vestoppfarten,møllebakken). 
placestat(vikåsenhallen,markaplassen_skole). 
placestat(vitenskapsmuseet,hospitalskirka).  %%  \+s
 %% placestat(voldsminde,mellomv_5).  
 %% placestat(voldsmindet,mellomv_5). 
placestat(voll,voll_studentby). 
placestat(væresbukta,være_ranheimsvegen). 
placestat(væresholmen,væresholmen). 
placestat(witro,fossegrenda). 
placestat(åsheim,åsheim_skole). 
placestat(åsheimhallen,åsheim_skole). 
placestat(åsvang,åsvang_skole). 
placestat(åsveien,åsveien_skole). 
placestat(østmarkasykehus,østmarkveien). 
placestat(øya_helsehus,studentersamfundet). % RS-110926 


placestat(wullumsgayrden,byåsen_butikksenter). %% TA-101230
placestat(wollumsgarden,byåsen_butikksenter).  %% TA-110114 wollumsgarden 

placestat(østmarka,østmarkveien). %% TA-110623

%%% END REFERENCE TO STATION SECTION


%% only plausible names
%% intended for intended alternative writing (not spell error)

sameplace(brundalen_skole,charlottenlund_vgs).
sameplace(aasveien,åsveien). 
sameplace(adolføyen,adolf_øien). 
sameplace(adolføyens,adolf_øien). 
sameplace(alfgodagersvei,alf_godagers_veg). 
sameplace(amosenteret,amo_senteret). 
sameplace(angeltrøen,angelltrøa). 
%% sameplace(angeltøveien,angelltrøveien).  %%veg
%% sameplace(anrdosentret,nardosenteret).
sameplace(antongrevskotsv,anton_grevskotts_veg). 
sameplace(antongrevskotsveg,anton_grevskotts_veg). 
sameplace(antongrevskotsvei,anton_grevskotts_veg). 
sameplace(arbeidsmarkedsinst,arbeidsmarkedsinstituttet).  %%etc
sameplace(bakkegata,bakkegata). 
sameplace(bakkegaten,bakkegata). 
sameplace(bakkegt,bakkegata). 
sameplace(bakklandet,bakkegata). 
sameplace(barneavdelingen,barneklinikken).  %%+baarneavdelingen
%% sameplace(bay,pirsenteret). 
sameplace(bergheimterasse,bergheim).  %% terr
sameplace(bergprestegård,berg_prestegård). 
sameplace(bjoerkmyra,bjørkmyr). 

sameplace(bjorndalstoppen,bjørndalstoppen).  %% bjorndalstopprn 
sameplace(bjørnedahlstoppen,bjørndalstoppen). 
sameplace(bjørnstadstoppen,bjørndalstoppen). 

sameplace(blusevol,blussuvold). 
sameplace(blusevold,blussuvold). 
sameplace(blusevoll,blussuvold). 
sameplace(blussevol,blussuvold). 
sameplace(blussevold,blussuvold). 
sameplace(blussevoll,blussuvold). 
sameplace(blussevollsbakken,blusuvollsbakken).  %% street
sameplace(blussuvol,blussuvold). 
sameplace(blussuvoll,blussuvold). 
sameplace(blussvollbakken,blusuvollsbakken). 
sameplace(blusuvol,blussuvold). 
sameplace(blusuvold,blussuvold). 
sameplace(blusuvoll,blussuvold). 
sameplace(bratsberveien,bratsbergvegen). 
sameplace(brattsbergveien,bratsbergvegen). 
sameplace(bredablikk,breidablikk). 
sameplace(breidablik,breidablikk). 
sameplace(brochsgt,hesthagen). 
sameplace(brocksgt,hesthagen). 

sameplace(broset,brøset). %%  brodet hageby

sameplace(brosmadsvingen,bromstadsvingen). 
sameplace(bromstadssvingen,bromstadsvingen). %% ss brumstadssvingen. 

%% sameplace(bryggen,pirbadet). %% Aker brygge  
sameplace(brøsetflaten,brøsetflata). 
sameplace(brøsethageby,brøset_hageby). 
sameplace(bussentralen,hovedterminalen).  %% mot sentrumsterminalen
sameplace(busstasjonen,hovedterminalen). 
sameplace(bussterminalen,hovedterminalen). 
sameplace(busstreminalen,hovedterminalen). 

%%%  sameplace(byen,sentrum). %% TEST %% TA-110120  %%. . . blocks spellcheck to byen!!!

sameplace(bygrensa,bygrensen). 

sameplace(bystasjon,hovedterminalen).    %% sentrum
sameplace(bystasjonen,hovedterminalen).  %%

% sameplace(bystasjon,sentrumsterminalen).    %% sentrum
% sameplace(bystasjonen,sentrumsterminalen).  %%

sameplace(byåsenbutikksenter,byåsen_butikksenter). 
sameplace(byåsensenteret,byåsen_butikksenter). 
sameplace(byåsenskole,byåsen_skole).
sameplace(byåsenskolen,byåsen_skole).

sameplace(byåsenvei,byås_street). %% problem
sameplace(byåsenveien,byås_street). 

sameplace(centralstasjon,ts). %% AtB. 
sameplace(centralstasjonen,ts). %% AtB. 
sameplace(centralstation,ts). %% AtB. 
sameplace(centralstationen,ts). %% AtB. 
sameplace(cesileborg,cecilienborg). 
sameplace(challotenlund,charlottenlund). 
sameplace(charlotelund,charlottenlund).  
sameplace(charlottelunden,charlottenlund). 
%% sameplace(charlottenberg,charlottenlund). %%  //place 
sameplace(charlottenlundkirke,charlottenlund_kirke).
%% sameplace(churshillvei,churchills_veg). 
sameplace(citisyd,city_syd). 
sameplace(citysyd,city_syd). 

sameplace(dalgårdvegen,dalgårdstien). 

sameplace(dalgard,dalgård). %%  dlgar

sameplace(dalhaug,dalhaug_street). 
sameplace(dalheim,dalheim_street). 
sameplace(dalsaunevegen,dalsauneveien). %allow1spell
sameplace(dokken,solsiden). 
sameplace(dokkhavna,solsiden). 
sameplace(dokkporten,solsiden). 
sameplace(dolpen,dolpa). %% dolpen på kart 
sameplace(domkjerka,domkirken). 
sameplace(doningensgate,dronningens_gate). 
sameplace(downtown,hovedterminalen). 

sameplace(dragevold,dragvoll).  %% syn dragovold
sameplace(dragvol,dragvoll).
sameplace(dragvollan,dragvoll). 
sameplace(dragvål,dragvoll).  
sameplace(drogvol,dragvoll). 

sameplace(drongensgate,dronningens_gate). 
sameplace(drongensgt,dronningens_gate). 
sameplace(droningegata,dronningens_gate). 
sameplace(droningensgt,dronningens_gate). 
sameplace(droninggt,dronningens_gate). 
sameplace(droningsgt,dronningens_gate). 
sameplace(dronngt,dronningens_gate). 
sameplace(dronningegate,dronningens_gate). 
sameplace(dronningens,dronningens_gate). 
sameplace(dronningensgata,dronningens_gate). 
sameplace(dronningensgate,dronningens_gate). 
sameplace(dronningensgaten,dronningens_gate). 
sameplace(dronningensgt,dronningens_gate). 
sameplace(dronningsgata,dronningens_gate). 
sameplace(dronningsgate,dronningens_gate). 
sameplace(dronningsgt,dronningens_gate). 

sameplace(dybendahls,dybdahls). %% ? %% TA-110131

sameplace(dybdahlsv,dybdahls_veg). 
sameplace(dybdahlsveg,dybdahls_veg). 
sameplace(dybdahlsvegen,dybdahls_veg). 
sameplace(dybdahlsvei,dybdahls_veg). 
sameplace(dybdahlsveien,dybdahls_veg). 
sameplace(dybdahlv,dybdahls_veg).  %%(rutehefte)
sameplace(dybdalsveg,dybdahls_veg). 
sameplace(dybdalsvegen,dybdahls_veg). 
sameplace(dybdalsvei,dybdahls_veg). 
sameplace(dybdalsveien,dybdahls_veg). 
sameplace(dybendahlsv,dybdahls_veg). 
sameplace(dybendahlsvegen,dybdahls_veg). 
sameplace(dybendahlsveien,dybdahls_veg). 
sameplace(dybendalsvegen,dybdahls_veg). 
sameplace(dybendalsvei,dybdahls_veg). 
sameplace(dybendalsveien,dybdahls_veg). 

sameplace(eberg,østre_berg). 
sameplace(einartambarskjelvesgate,einar_tambarskjelves_gate). 
sameplace(elgeseterbrua,studentersamfundet). 
sameplace(elgesetergata,elgeseter).  %%-sæterbakken?
sameplace(elgesetergate,elgeseter). 
sameplace(elgesetergaten,elgeseter).  %%Necessary,elgesetergt1=sæterbakken(SIC)
sameplace(elgesetergt,elgeseter). 
sameplace(elgesætergate,elgeseter). 
sameplace(elgesæther,elgeseter). 
sameplace(elgseter,elgeseter). 
sameplace(elgseterbro,studentersamfundet). 
sameplace(elgseterbru,studentersamfundet). 
sameplace(elgsetergate,elgeseter). 
sameplace(elgsether,elgeseter). 
sameplace(elgsæter,elgeseter). 
sameplace(elgsætergate,elgeseter). 
sameplace(elvehavn,nedre_elvehavn). 
sameplace(elvehavna,nedre_elvehavn). 
sameplace(elvehavnen,nedre_elvehavn). 
sameplace(elverk,e_verket). 
sameplace(elverket,e_verket). 
sameplace(energiverket,e_verket). 
sameplace(engebretsons,engelbrektssons).  %%spconpartnames
sameplace(etambarskjelvesgate,einar_tambarskjelves_gate). 
sameplace(etambarskjelvgt,einar_tambarskjelves_gate). 
sameplace(europaveg6,e6). 
sameplace(everk,e_verket). 
sameplace(everket,e_verket). 
sameplace(falkberget,johan_falkbergets_vei).  %%confuse
sameplace(falkbergetsv,johan_falkbergets_vei). 
sameplace(fergeterminalen,pirbadet). 
sameplace(festningsgata,festningsgata). 
sameplace(festningsveien,festningsgata). 
sameplace(fiolsving,fiolsvingen). 
sameplace(fiolvegen,fiolsvingen). %inclfiolveg
sameplace(fjernstads,fjermstads). 
sameplace(flatåsne,flatåsen). %% flatåsnne 
sameplace(flataasen,flatåsen). 
sameplace(flatayen,flatåsen). %% TA-110116 flatÃ¥en  
sameplace(flatåsensenter,flatåsen_senter). 
sameplace(flatåsensenteret,flatåsen_senter). 
sameplace(flatåsentoppen,flatåstoppen). 
sameplace(flatåssenteret,flatåsen_senter). 
sameplace(flystasjonen,trondheim_lufthavn_lufthavnveien). 
sameplace(folkemuseet,trøndelag_folkemuseum). 
sameplace(folkemuseum,trøndelag_folkemuseum). 
sameplace(folkemuseumet,trøndelag_folkemuseum). 
sameplace(fosenkaia,ts). %% AtB.  %%tsisnot station
sameplace(fossagranda,fossegrenda). 
sameplace(fossegrande,fossegrenda).  %%(Amblehash:just neib switch)
sameplace(fotballstadion,lerkendal_stadion). 
sameplace(froderinnansveg,frode_rinnans_street). 
sameplace(gammellina,gammel_lina).  %%(_should be dropped). 
sameplace(gildevangen,søndregate).  %%(NB no message)
%sameplace(ginakroghsgt,gina_krogs_veg).        %% RS-160809 NEW ROAD!
sameplace(gina_krogs_veg,clara_holsts_veg).     %% RS-160809 NEW ROAD! 
sameplace(gløahugen,gløshaugen). 
sameplace(gløshaug,gløshaugen). 
sameplace(gløshøgen,gløshaugen).  %%høgem 
sameplace(godst,terminalen). 
sameplace(graaenmølna,graaemølna). 
sameplace(graaermølla,graaemølna). 
sameplace(graaermølna,graaemølna). 
sameplace(graamølna,graaemølna). 
sameplace(graemølla,graaemølna). 
sameplace(graemøllen,graaemølna). 
sameplace(granhaugan,granhaugen).  %% incl ganhaugen
sameplace(granåsbakken,granåsen_vm_anlegget). 
sameplace(granåsenvegen,granåsveien). 

sameplace(grevskott,grevskotts). %% gfevskott 
sameplace(grevskots,grevskotts). %% grevsots 

sameplace(gråemølla,graaemølna). 
sameplace(gråenmølla,graaemølna). 
sameplace(gråmølna,graaemølna). 
sameplace(gråmørna,graaemølna). 
sameplace(gågate,sentrum).              %% RS-151219 Move to "sentrum-cluster" above? 
sameplace(gågaten,sentrum). 

sameplace(hallsetvei,nordre_hallset_street). %% etc 
sameplace(hallsteingård,halstein_gård). 
sameplace(hallsteingården,halstein_gård). 
sameplace(haugnesveien,haugnessvingen). 
sameplace(haukvante,haukvatnet). 
sameplace(havstadsetnret,havstadsenteret). 
sameplace(havsteinsenter,havstadsenteret). 
sameplace(havsteinsenteret,havstadsenteret). 
sameplace(hegdalringen,heggdalsringen). 
sameplace(heggdal,heggdalen). 
sameplace(hegdalen,heggdalen). 
sameplace(heggelia,heggdalen). 
sameplace(heggelien,heggdalen). 
sameplace(hegglia,heggdalen). 
sameplace(heggstadmo,heggstadmoen). 

sameplace(heggstamyra,heggstadmyra). %%hegstamyra heggstmyra 

sameplace(heglia,heggdalen). 
sameplace(heglidalen,heggdalen). 
sameplace(hegmoen,heggstadmoen). 
sameplace(hegstamoen,heggstadmoen). 
sameplace(hekstadmoen,heggstadmoen).
sameplace(heimdalstasjon,heimdal_stasjon). 
sameplace(herlofsonløypa,herlofsonsløypa).  %%2sp
sameplace(hestehagen,hesthagen). 
sameplace(hogskoleringen,høgskoleringen). 
sameplace(holtermannsveg,holtermannsveien). 
sameplace(holtermannsvei,holtermannsveien). 
sameplace(holtermanveg,holtermannsveien).  %%Nofunk
sameplace(hoppbakken,granåsen_vm_anlegget). 
sameplace(hopsitalskirka,hospitalskirka). 
sameplace(hopstilkirka,hospitalskirka). 
sameplace(hospitalet,st_olavs_hospital). 
sameplace(hospitalkirken,hospitalskirka). 
sameplace(hospitalskirka,hospitalskirka). 
sameplace(hospitalkirka,hospitalskirka).  %%NB
sameplace(hosptialskirka,hospitalskirka).  %%

sameplace(hosptalsløkka,hospitallløkka). %% +  hosptalslokka 

sameplace(humlehaugen,nedre_humlehaugen_vest). %%RS-121024 3 nye på Ranheim fra 24.10.2012
sameplace(hundhameren,hundhammeren). 
sameplace(hundhammarn,hundhammeren). 
sameplace(husbytun,husebytunet). 
sameplace(høggrenda,høgreina). 
sameplace(høgseth,høiset). 
sameplace(høyskole,høgskole).   %% TA-110221
sameplace(høyskolen,høgskolen). %%

%% sameplace(høgskoleringen,høgskoleringen). 
sameplace(høiseth,høiset). %% < høisteh 
sameplace(høyset,høiset). 
sameplace(idrettshuset,idrettsbygget). 
sameplace(ilakrysset,ila).  
sameplace(inheradsveien,innherredsveien). 
sameplace(inheredsveien,innherredsveien). 
sameplace(inheresdveien,innherredsveien). 
sameplace(inherradsveien,innherredsveien). 
sameplace(inherresdveien,innherredsveien). 
sameplace(inneherredsvegen,innherreds_street).  
sameplace(inneherredsveien,innherredsveien). 
sameplace(innerhedsveien,innherredsveien). 
sameplace(innheradsveien,innherredsveien). 
sameplace(innherdevn,innherredsveien). 
sameplace(innherdsveien,innherredsveien). 
sameplace(innheredsvegen,innherredsveien). 
sameplace(innheredsveien,innherredsveien). 
sameplace(innheresdveien,innherredsveien). 
sameplace(innherresdveien,innherredsveien). 
sameplace(isfabrikken,iskremfabrikken). 
sameplace(jacobsli,jakobsli). 
sameplace(jakobsgrenda,jakobsli).  %%+jakobsgreda
sameplace(jakobslia,jakobsli). 
sameplace(jern,ts). %% AtB. 
sameplace(jernbane,ts). %% AtB. 
sameplace(jernbanen,ts). %% AtB. 
sameplace(jernbanestasjon,ts). %% AtB. 
sameplace(jernbanestasjonen,ts). %% AtB. 
sameplace(jernbanestationenen,ts). %% AtB. 
sameplace(jernbaneterminal,ts). %% AtB. 
sameplace(jernbaneterminalen,ts). %% AtB. 
sameplace(jernbanetorget,ts). %% AtB. 
sameplace(jernbaneverket,ts). %% AtB. 
sameplace(jonnsvansveien,jonsvannsveien). 
sameplace(kaia,pirbadet).
%% sameplace(kaien,pirbadet). %%  \+ kaken
sameplace(kaiene,pirbadet).
sameplace(kalvskine,kalvskinnet). 
sameplace(karljonssensveien,karl_jonssons_veg). 
sameplace(karljohnsonsveg,karl_jonssons_veg). %%  KalJohnsons veg
sameplace(kattemsenteter,kattemsenteret). 
sameplace(kattemsenteteret,kattemsenteret). 
sameplace(kattskinnet,kalvskinnet). 
sameplace(kattskjinnet,kalvskinnet).
sameplace(kbssenter,kbs_senteret). 
sameplace(kbssenteret,kbs_senteret). 
sameplace(kinosenter,nidarosdomen). 
sameplace(kirkesæterøra,kyrkseterøra). 
sameplace(kirksæterøra,kyrkseterøra). 
sameplace(klabu,klæbu). 
sameplace(klebu,klæbu).  %% ikke spell på foreign ?
sameplace(koieflate,koieflata). 
sameplace(kolstadsenter,casper_lundes_veg). 
sameplace(kojflata,koieflata). 
sameplace(kongøysteinsv,kong_øysteins_veg).  %%alas
sameplace(kongøysteinsvei,kong_øysteins_veg). 
sameplace(krooppanbrua,kroppan_bru). 
sameplace(kropamarka,kroppanmarka). 
sameplace(kropenmarka,kroppanmarka). 
sameplace(kroppamarke,kroppanmarka). 
sameplace(kroppanbru,kroppan_bru). 
sameplace(kroppanbrua,kroppan_bru). 
sameplace(kroppanbruen,kroppan_bru). 
sameplace(kroppangmarken,kroppanmarka). 
sameplace(kroppansbru,kroppan_bru). 
sameplace(kvenilmyra,kvenildsmyra). %% S 
sameplace(kvilhaug,kvilhaugen). 
sameplace(kyrksæterørå,kyrkseterøra). 
sameplace(kyrksæterøya,kyrkseterøra). 
sameplace(kyrksøterøya,kyrkseterøra).  %%act
sameplace(ladegård,lade_gård). 
sameplace(ladegården,lade_gård). 
sameplace(ladehammern,ladehammeren).  %%gammern
sameplace(ladejarlen,ladejarlen_v_g_s).
sameplace(ladejarlen,ladejarlen_v_g_s). 
sameplace(lademoenkirke,lademoen_kirke). 
%sameplace(ladesletta,haakon_vii_gate).  %%neib
sameplace(ladeuniversitet,ntnu_lade). 
sameplace(larkedal,lerkendal). %% eng 
sameplace(leangentravbane,travbanen). 
%% sameplace(leangveien,leangenveien). %% TA-110822
sameplace(leirbruagård,leirbrua_gård). 
sameplace(leirbrugård,leirbrua_gård). 
sameplace(leirfoss,nedre_leirfoss). 
sameplace(leirfossen,nedre_leirfoss). 
sameplace(leirgårdbru,leirbrua_gård). 
sameplace(lerchendalsgård,lerkendal_gård).
sameplace(lerchendalskrysset,lerkendalskrysset). 
%% sameplace(lerkendal,lerkendal_stadion).  %% NB lerk //unnec,creates dbl entry
sameplace(lerkendalgård,lerkendal_gård).
sameplace(lerkendalstadion,lerkendal_stadion). 
sameplace(leutehagen,leuthenhaven). 
sameplace(leutehaven,leuthenhaven). 
sameplace(leutehavn,leuthenhaven). 
sameplace(leutenhagen,leuthenhaven). 
sameplace(leutenhaven,leuthenhaven). 
sameplace(leutenhaven,leuthenhaven). 
sameplace(leutenhaven,leuthenhaven). 
sameplace(leuthenhagen,leuthenhaven).  %%nospell(>1alt)
sameplace(leytenhaven,leuthenhaven). 
sameplace(lianvatnet,lian).  %%(aslolianvattnet)
sameplace(læreskole,lærerskolen).  %%læresskole
sameplace(løitenhaven,leuthenhaven). 
sameplace(marcusthranesvei,marcus_thranes_vei). 
sameplace(marka,bymarka). 
sameplace(markapl,markaplassen). 
sameplace(markaplass,markaplassen). 
sameplace(maskinagent,maskinagentur). 
sameplace(maskinagenturet,maskinagentur). 
sameplace(maskinkompaniet,maskinagentur).  %%?
sameplace(medtbyn,sentrum).  %%dial
sameplace(meierier,norske_meierier). 
sameplace(meieriet,norske_meierier). 

sameplace(midby,sentrum). 
sameplace(midtby,sentrum). 
sameplace(midtbyen,sentrum). 
sameplace(midten,sentrum). %% TA-110121
sameplace(midtbyn,sentrum). 
sameplace(midtbysonen,sentrum). 

sameplace(midtbyterminalen,hovedterminalen). 
                          %% not sentrumsterminalen which itsel is a samename
sameplace(moholtalle,moholt).  %%
sameplace(moholtkirka,strinda_kirke).
sameplace(moholtkirke,strinda_kirke). 
sameplace(moholtkirken,strinda_kirke). 
sameplace(moholtsentret,moholtsenteret).  %% maybe unnec after rehash
sameplace(moholtstudentby,moholt_studentby). 
sameplace(moholttunet,moholttun). 
sameplace(mollenberg,møllenberg).
sameplace(moltemyra,moltmyra).  %% captures p
sameplace(munkvold,munkvoll).   %% munkvild
sameplace(munkvoldgård,munkvoll_gård). 
sameplace(musikkmuseum,ringve_museum). 
sameplace(musikmuseum,ringve_museum). 
sameplace(måhålt,moholt). 
sameplace(mølebaken,møllebakken). 
sameplace(møllenberg,nedre_møllenberg). 
sameplace(møllenberggate,nedre_møllenberg_street).  %% \+ stat. 
sameplace(møller,møller_bil). 

sameplace(nardocenteret,nardosenteret). 
sameplace(nardocenter,nardosenteret). 
sameplace(nardosenter,nardosenteret). 
sameplace(nardosentre,nardosenteret).

%%sameplace(nattbussterminalen,hovedterminalen).  %% RS-120915

sameplace(nedreelvehavn,nedre_elvehavn). 
sameplace(nedrehumlehaugen,nedre_humlehaugen_vest). %%RS-121024 3 nye på Ranheim fra 24.10.2012

sameplace(nidaroshallen,trondheim_spektrum). 
sameplace(nidarrødhallen,trondheim_spektrum). 
sameplace(nidarvollskole,nidarvoll_skole). 
sameplace(nidarøhallen,trondheim_spektrum). 
sameplace(nidarøhallene,trondheim_spektrum). 
sameplace(nordslett,nordslettveien_snuplass). %%  \+ nordset
sameplace(nordslettveiensnuplass,nordslettveien_snuplass). %% vegen 
sameplace(nova,olav_tryggvasons_gate_ot2). 
sameplace(novakino,olav_tryggvasons_gate_ot2). 
sameplace(ntnulade,ntnu_lade). 
sameplace(nygaard,nygård).
sameplace(nyvegbakken,nyveibakken). 
sameplace(nyvegsbakken,nyveibakken). 
sameplace(nyveib,nyveibakken). 
sameplace(nyveisbakken,nyveibakken). 
sameplace(obslade,lade_idrettsanlegg). 
%%sameplace(odenseveien,odensev). 
sameplace(ofstis,øfstis). %% 1. letter sp is not aut 
sameplace(okstadbakken,okstad). 
%% sameplace(okstadhaugen,okstadøy).  %%???
sameplace(olavsgate,st_olavs_gate). 
sameplace(olavshospital,st_olavs_hospital). 
sameplace(olavshospitalet,st_olavs_hospital). 
sameplace(olavtryggvasonsgate,olav_tryggvasons_gate_ot1). 
sameplace(olavtrygvasonsgt,olav_tryggvasons_gate_ot1). 
sameplace(orkangerskole,orkanger_skole).
sameplace(ostmarkveien,østmarkveien).
sameplace(othelianborg,othilienborg). 
sameplace(othileborg,othilienborg). 
sameplace(othilenberg,othilienborg). 
sameplace(otillenborg,othilienborg). 

sameplace(ourensveg,henrik_ourens_veg).  %%etc
sameplace(pederkroghsvei,peder_kroghs_v). 
sameplace(peirterminal,pirbadet).  
sameplace(persauneleir,persaunet_leir). 
sameplace(persaunetveien,persaunetveien). %% TA-110415 
sameplace(persaunveien,persaunetveien). %% TA-110415 
sameplace(persaunvn,persaunetveien). %% TA-110415 
sameplace(piersenteret,pirsenteret). 
sameplace(pierterminal,pirbadet).  
sameplace(pirsenter,pirsenteret). 
sameplace(pirsentralen,pirsenteret). 
sameplace(pirstasjon,pirbadet).  
sameplace(pirterminalalen,pirbadet).   %%
sameplace(pirtersenteret,pirbadet).   %%

%% sameplace(politiet,ts).    %% AtB.  %% politihuset).  %% //problem spot
%% sameplace(politi,ts).      %% AtB. 
%% sameplace(politihuset,ts). %% AtB.                 %% 



sameplace(postsentralen,postterminalen). %% RS-120805
sameplace(postterminal,postterminalen). %% posttermunal %% TA-110221

sameplace(presteaunet,persaunet). 
sameplace(prestegayrdjordet,prestegårdsjordet).   %% TA-101123
sameplace(prestgayrdsjordet,prestegårdsjordet).   %% 
sameplace(prestgårdsjordet,prestegårdsjordet).    %% TA-101122
sameplace(prestegaardsjordet,prestegårdsjordet). 
sameplace(prestegårdsalleen,prestegårdsjordet). 
sameplace(prestegårdsjordet,prestegårdsjordet).  
sameplace(prestegårdsjordet,prestegårdsjordet).  %% allow presetegårdsjordet. 
sameplace(prestegårdsjoret,prestegårdsjordet). 
sameplace(prestegårdstunet,prestegårdsjordet). 
sameplace(prestegårdsvegen,prestegårdsjordet).  %% spurious but actual
sameplace(prestegårjorde,prestegårdsjordet). 
sameplace(prestegårsjorde,prestegårdsjordet). 
sameplace(prestegåsdsjordet,prestegårdsjordet). 
sameplace(prestejordet,prestegårdsjordet).  
sameplace(prestgårdsjordet,prestegårdsjordet). 

sameplace(prinsegata,prinsens_gate). 
sameplace(prinsegaten,prinsens_gate). 
sameplace(prinsengt,prinsens_gate).  %%(actual)
sameplace(prinsenkinosenter,nidarosdomen). 
sameplace(prinsenkinosenteret,nidarosdomen). 
sameplace(prinsensgatekinoene,nidarosdomen). 
sameplace(priterminalen,pirbadet).  

sameplace(prof,hesthagen).   %% RS-160109  Too specific?
sameplace(professorbrochsgate,hesthagen). 
sameplace(professorbrochs,hesthagen). 

sameplace(ragnhildsgt,ragnhlds_gate). 
sameplace(rambech,f_rambech).  %% F Rambech 
sameplace(regionsykehus,regionsykehuset). 

sameplace(ringvemuseum,ringve_museum).  %% RS-120805 Sorting

sameplace(risvollansenter,risvollan_senter). 
sameplace(risvollansenteret,risvollan_senter). 

%sameplace(romolslia,romolslia_øvre). %% RS-150111. Move to isat?
sameplace(romulslia,romolslia_øvre).  %% romulslia street, prefer station

sameplace(ronningbakken,rønningsbakken). 
sameplace(rosenborgskole,gyldenløves_gate).  
sameplace(rosendalområdet,rosendal). 
sameplace(rotvollan,rotvoll). 
sameplace(rotvollen,rotvoll). 
sameplace(rotvollene,rotvoll). 
sameplace(rovoll,rotvoll). %rovol
sameplace(rønningensbakken,rønningsbakken). %% e.g. rønningensabakken
sameplace(samf,studentersamfundet). 
sameplace(samfonnje,studentersamfundet). 
sameplace(samfudnet,studentersamfundet).    

sameplace(stundentersamfundet,studentersamfundet).
sameplace(stundentsamfunnet,studentersamfundet). 
sameplace(samfund,studentersamfundet). 
sameplace(samdundet,studentersamfundet). %% AtB
sameplace(samfundet,studentersamfundet).
sameplace(samfunnet,studentersamfundet). 
sameplace(sammfundet,studentersamfundet). 
sameplace(sammfunetet,studentersamfundet). 
sameplace(sammfunnet,studentersamfundet). 
%% sameplace(sanbaken,sandbakken).  %%inkl sandbaken,sanbakken
sameplace(saupstadsenter,saupstadsenteret). 
sameplace(saupstadveien,søbstad_street).  %%street
sameplace(saupstapsentret,saupstadsenteret). 
%sameplace(scandichotel,esso_motorhotell). 
sameplace(schjetnansveg,carl_schjetnans_veg). 
sameplace(schjetnansvei,carl_schjetnans_veg). 

sameplace(sentalstasjoene,ts). %% AtB.  %%coverscases
sameplace(sentralbanen,ts). %% AtB. 
sameplace(sentralbanestasjon,ts). %% AtB. 
sameplace(sentralbanestasjonen,ts). %% AtB. 
sameplace(sentralbanestasjonen,ts). %% AtB. 
sameplace(sentralbanestasjonen,ts). %% AtB. 
sameplace(sentralbanestrasjon,ts). %% AtB.  %%actual
sameplace(sentralbanststasjonen,ts). %% AtB.  %%spec
sameplace(sentralen,hovedterminalen). 
sameplace(sentraljernbanen,ts). %% AtB. 
sameplace(sentraljernbanestasjon,ts). %% AtB. 
sameplace(sentraljernbanestasjonen,ts). %% AtB. 
sameplace(sentralsajonen,ts). %% AtB. 
sameplace(sentralstarjonem,ts). %% AtB. 
sameplace(sentralstasjon,ts). %% AtB. 
sameplace(sentralstasjone,ts). %% AtB. 
sameplace(sentralstasjonen,ts). %% AtB.  %%sentralstatsjonen13. 25->ts13
sameplace(sentralstasjonenen,ts). %% AtB. 
sameplace(sentralstation,ts). %% AtB. 
sameplace(sentralstationen,ts). %% AtB. 
sameplace(sentralstationen,ts). %% AtB. 
sameplace(sentralstationen,ts). %% AtB. 
sameplace(sentralststationen,ts). %% AtB. 
sameplace(sentralsykehuset,st_olavs_hospital). 
sameplace(sentralterminalen,hovedterminalen). 
sameplace(sentraltogstasjonen,ts). %% AtB. 
sameplace(sentrumsholdeplassen,hovedterminalen). 
sameplace(sentrumskvartalet,sentrum). 
sameplace(sentrumsstasjonen,hovedterminalen). 

sameplace(sentrumsterminal,hovedterminalen). 
sameplace(sentrumsterminalen,hovedterminalen). 
sameplace(sentrumssentralen,hovedterminalen). 

sameplace(shieldropsvei,e_b_schieldrops_vei). %Gateetternavn
sameplace(siemensbygget,siemens). 
sameplace(siemensfabrikken,siemens). 
sameplace(simenskrysset,siemens).
sameplace(siemenskrysset,siemens).  %%(Ambiguous,butspecial)

sameplace(sigurdjorsalfarsvei,sigurd_jorsalfars_street). 
sameplace(sildredråpeveien,sildråpeveien). 
sameplace(sildropveien,sildråpeveien). 
sameplace(circus,sirkus_shopping).      %% RS-160802
sameplace(sirkus,sirkus_shopping).
sameplace(sirkussenter,sirkus_shopping).
sameplace(sirkussenteret,sirkus_shopping).
sameplace(sirkusshopping,sirkus_shopping).
sameplace(sjetnamrka,sjetnmarka). 
sameplace(sjetnemarka,sjetnmarka).     %% /sjetemarka 
sameplace(skavlandsv,skavlans_veg).   
sameplace(skavlandsveg,skavlans_veg). 
sameplace(skavlandsvei,skavlans_veg). 
sameplace(skavlansvei,skavlans_veg).  
sameplace(skihytta,skistua). 
sameplace(skihytten,skistua). 
sameplace(skovgard,skovgård). %%  + skavgard
%% sameplace(skjetlein,leinstrand).  %%?leinstrandnot st 
sameplace(skytterveien,skyttevegen).  %%discrepancy>1
sameplace(slakterhuset,slakthuset).  %%+slakteri. . 
sameplace(slakteriet,slakthuset).  %%NBslakt|
sameplace(sluppenbrua,sluppen_bru). 
sameplace(spektrum,trondheim_spektrum).  %%not station
sameplace(spogndal,spongdal).  %%\+sogndal
sameplace(stabelsv,stabells_veg).  %%  stbelsv
sameplace(stabelsvei,stabells_veg). 
sameplace(stadion,lerkendal_stadion). 
sameplace(strandkaiveien,strandveikaia).  
sameplace(stasjonen,ts). %% AtB. 
sameplace(statoilbygget,statoil_rotvoll). 
sameplace(statsetsentere,stavset_senter).  %%contag
sameplace(stavsetsenter,stavset_senter). 
sameplace(stavsetsenteret,stavset_senter). 
sameplace(stavsetsentrum,stavset_senter). 
sameplace(stdentersamfunnet,studentersamfundet). 
sameplace(steinanbakken,steinanveien). 
sameplace(steinkjær,steinkjer).   %% (steinskjær)
sameplace(steinskjer,steinkjer).  %%
sameplace(steinveien,steinanveien). 
sameplace(stindhiem,strindheim). 
sameplace(stokkanhaugane,stokkanhaugen).
sameplace(stokkanhaugene,stokkanhaugen).
sameplace(stokkhaugane,stokkanhaugen).
sameplace(stokkhaugen,stokkanhaugen).
sameplace(stolavshospital,st_olavs_hospital).  %% stolafshospital
sameplace(storrosta,stor_rosta). 
sameplace(storrosten,stor_rosta). 
sameplace(strandveikaien,strandveikaia). 
sameplace(stridnehim,strindheim). 
sameplace(strindakirke,strinda_kirke). 
sameplace(strinheim,strindheim).  %%striheim
sameplace(studentersamfunnet,studentersamfundet). 
sameplace(studentersammfunnet,studentersamfundet). 
sameplace(studenthuset,studentersamfundet). 
sameplace(studenthytta,studenterhytta). 
sameplace(studentsamfundet,studentersamfundet). 
sameplace(studentsamfunnet,studentersamfundet). 
sameplace(stundersamfundet,studentersamfundet). 
sameplace(sverresborgfolkemuseum,trøndelag_folkemuseum). 
sameplace(sverresli,sverresborg).  %%?lia
sameplace(sykehyset,sykehuset). 
sameplace(søbstad,saupstad). 
sameplace(søbstadmyra,saupstad). 


sameplace(tambarskjelvarsgt,einar_tambarskjelves_gate). 

%% makes tambarskjelves + gate  coerce into  einar_tambarskjelves_street

  %% sameplace(tambarskjelves,einar_tambarskjelves_gate). %% TA-110110
  %% sameplace(tambarskjelve,einar_tambarskjelves_gate). 
  %% sameplace(tambarselve,einar_tambarskjelves_gate). 


sameplace(tambarskjelvesgate,einar_tambarskjelves_gate). 
sameplace(tambarskjelvesgt,einar_tambarskjelves_gate). 
sameplace(tambarskjelvsgate,einar_tambarskjelves_gate).  

%% e t


sameplace(taulobakken,thaulowbakken). 
sameplace(taulovbakken,thaulowbakken). 
sameplace(tawlobakken,thaulowbakken). 

sameplace(teglevegskrysset,teglverkskrysset).
sameplace(tegelstensvegen,teglverkskrysset). 
sameplace(teggelverkskrysset,teglverkskrysset). 
sameplace(teglekrysset,teglverkskrysset). 
sameplace(teglesteinsverket,teglverket). 
sameplace(teglverk,teglverkskrysset).  
sameplace(teglverkkrysset,teglverkskrysset). 
sameplace(teglverkrysset,teglverkskrysset). 
sameplace(teglverkskrysset,teglverkskrysset). 
sameplace(teglverkskrysst,teglverkskrysset). 
sameplace(teglverkskysset,teglverkskrysset). 
sameplace(tekleverkstunet,teglverkskrysset).  %% contagation

sameplace(tempehallen,nidelvhallen). 
sameplace(tempekirke,lerkendal). 
%% sameplace(tempevegen11,tempevegen_11). %% unnec %% TA-101118
sameplace(tev,e_verket).  %% OBS generates te-veien
sameplace(thaulow,thaulowbakken). 
sameplace(thaulowbakk,thaulowbakken). 
sameplace(thauluaw,thaulowbakken). 
sameplace(thoulawbakken,thaulowbakken). 
sameplace(thouwlovbakken,thaulowbakken). 
sameplace(thowlauwbakken,thaulowbakken). 
sameplace(thyholdt,tyholt). 
sameplace(tillerbrua,tiller_bru).  %%(?EndofMap)
sameplace(tilleråsen,martin_kregnes_veg). 
sameplace(tine,norske_meierier). 
sameplace(tjønnåsen,tjønnlia).  %%(?)
sameplace(togbanestasjonen,ts). %% AtB. %% incl. togbanestasjoenen 
sameplace(togstasj,ts). %% AtB. 
sameplace(togstasjon,ts). %% AtB. 
sameplace(togstasjonen,ts). %% AtB. 
sameplace(togstasjonene,ts). %% AtB. 
sameplace(togstation,ts). %% AtB. 
sameplace(togterminalen,ts). %% AtB. 
sameplace(tollboden,tollbua). 
sameplace(tollvesenet,tollbua). 
sameplace(tonstakrysset,tonstad). %%  tonstakrusset  
sameplace(tonsdadkrysse,tonstadkrysset).  %% 2 ch dif
sameplace(tonsdadskrysset,tonstadkrysset). %% tonstadskrysset
sameplace(tonsdakryset,tonstadkrysset). 
sameplace(tonstadsvei,sivert_thonstads_vei).  %%etc
sameplace(tonstakrysse,tonstadkrysset).  %% 2 ch dif
sameplace(torgardsletta,torgardssletta). 
sameplace(torgkvartalet,hovedterminalen). 
%% sameplace(torgplassen,torget). %% ? torplassen 
sameplace(torgsenteret,hovedterminalen).  
sameplace(torplas,casper_lundes_veg). 
sameplace(torpsplass,casper_lundes_veg).  %%?
sameplace(torpveien,ingemann_torps_vei). %ingemann_torps_street).  %%station
sameplace(torvet,hovedterminalen).  %% catch spell-error?
sameplace(torvplassen,hovedterminalen). 
sameplace(travbanestasjonen,travbanen). 
sameplace(travparken,travbanen). 
sameplace(trhsentralstasjon,ts). %% AtB. 
sameplace(trondheimsentral,ts). %% AtB. 
sameplace(trondheimsentralstasjon,ts). %% AtB. 
sameplace(trondheimstasjon,ts). %% AtB. %% inc  tronheimstasjon
sameplace(trondheimtorg,hovedterminalen).  %% tronheimtårg
sameplace(trondhjem,trondheim). 
sameplace(tronheimfengsel,tunga_kretsfengsel). 
sameplace(tryggvassonsgate, olav_tryggvasons_gate_ot1). %%  AtB %% TA-100515
sameplace(tryggvassonsgt,olav_tryggvasons_gate_ot1).    %% AtB  %% TA-100515
sameplace(trøndermeieriet,norske_meierier). 
sameplace(tungstadkrysset,tonstadkrysset). 
sameplace(tvereggen,tverregga).  %% Confusion
sameplace(tverreggen,tverregga). 

sameplace(tyholtstårnet,strinda_vgs). %% tyholtstarnet 
sameplace(tyholtornet,strinda_vgs).   %% NB 1 t in route db
sameplace(tyholtårnet,strinda_vgs).   %% allow tyholtårent 
                                       %% changed to tyholttårnet Xmas 08
sameplace(tåget,ts). %% AtB. 
sameplace(tågstasjonen,ts). %% AtB. 
sameplace(ulinvegen,ullins_street). 
sameplace(ulinvegen,ullins_street). 
sameplace(universitetssenteret,universitetet). 
sameplace(utsikten,utsikten_alle). 
%% sameplace(vaern,værnes). // valerveien -> va(l)er(n) -> værnes 
sameplace(vaernes,trondheim_lufthavn_lufthavnveien). 
sameplace(vaerness,trondheim_lufthavn_lufthavnveien). 
sameplace(valdgrindsvegen,valgrindveien). 
sameplace(valentilystsenteret,valentinlyst). 
sameplace(valentilystsentret,valentinlyst). 
sameplace(valentinlystvegen,valentinlystveien). 
sameplace(valøy,valøyvegen). 
sameplace(valøyvegen,valøyvegen). 
sameplace(vandrerhjemmet,weidemannsveien).  %%+vandrehjemmet
sameplace(varnes,trondheim_lufthavn_lufthavnveien). 
sameplace(varness,trondheim_lufthavn_lufthavnveien). 
sameplace(velgrindvegen,valgrindveien). 
sameplace(vernes,trondheim_lufthavn_lufthavnveien). 
sameplace(vernæs,trondheim_lufthavn_lufthavnveien). 
sameplace(vestrerosten,vestre_rosten).  %%vestreostren
sameplace(vikelva,vikelvveien). 
sameplace(vikhamarløkka,vikhammeråsen). 
sameplace(volabake,vollabakken).  %% vollabake,volabakke
sameplace(vollgård,voll_gård). 
sameplace(vollstudby,voll_studentby). 
sameplace(vollstudby,voll_studentby). 
sameplace(vollstudentby,voll_studentby). 
sameplace(vådanvn,vådanv_5). 
sameplace(våddanveien,vådanv_5). 
sameplace(væretrøa,værestrøa). %% new official name  e.g. væretræa. 
sameplace(værness,trondheim_lufthavn_lufthavnveien).  %%(not genitive!)

sameplace(vullumsgården,byåsen_butikksenter). %% vyllumsgården.
sameplace(wullumsgaard,byåsen_butikksenter). 
sameplace(wullumsgaaren,byåsen_butikksenter). 
sameplace(wullumsgaren,byåsen_butikksenter). 



sameplace(wullumsgård,byåsen_butikksenter). 


sameplace(åsheimskole,åsheim_skole). 
sameplace(åsv,åsveien_skole).  %%Troublespot
sameplace(åsveienskole,åsveien_skole).  %%åsveieskole


sameplace(østreberg,østre_berg). %% østeberg 

sameplace(østmarkneset,østmarkveien).  %%nesset
sameplace(øvreromolslia,romolslia_øvre).
sameplace(kattemsentret,kattemsenteret). 

sameplace(børskrysset,børskrysset_e39).

%% How to write names in SMS-messages (max 160 characters?)
short_specname(d1,'Dronn. gt D1'). 
short_specname(d2,'Dronn. gt D2'). 
%short_specname(d3,'Dronn. gt D3'). 
%short_specname(d4,'Dronn. gt D4'). 
short_specname(d19,'Dronn. gt D19'). %% Buss 67. City Lade / Bergheim %% RS-150815

short_specname(dronningens_gate,'Dronn. gt').
 
short_specname(dr_gate_d1,'Dronn. gt D1'). %% AtB
short_specname(dr_gate_d2,'Dronn. gt D2'). 
%short_specname(dr_gate_d3,'Dronn. gt D3'). 
%short_specname(dr_gate_d4,'Dronn. gt D4'). 
short_specname(dronningens_gate_d1,'Dronn. gt D1'). %% RS-150815 Old (2014-feb) format. Again for Christmas 2015
short_specname(dronningens_gate_d2,'Dronn. gt D2'). 
%%short_specname(dronningens_gate_d3,'Dronn. gt D3'). 
%%short_specname(dronningens_gate_d4,'Dronn. gt D4'). 


short_specname(einar_tambarskjelves_gt,'Einar Tambarskj. gt'). 
%short_specname(haakon_vii_gate_17,'Haakon7. gate 17'). 
short_specname(haakon_vii_gate_25,'Haakon7. gate 25'). 
%%short_specname(haakon_vii_gate_29,'Haakon7. gate 29'). 
%short_specname(haakon_vii_gate_9,'Haakon7. gate 9'). 
short_specname(heimdal_stasjon,'Heimdal st. ').  %% Extra sp
short_specname(hovedterminalen,'Sentrumsterminalen'). 
short_specname(johan_falkbergets_vei,'J Falkbergets v'). 
short_specname(jørgen_b_lysholms_vei,'J. B. Lysholmsv'). 
%% short_specname(lerkendal_stadion,'Lerkendal st. ').  %% %% Extra sp


short_specname(k1,'Kongens gt K1'). %% RS-130812
short_specname(k2,'Kongens gt K2'). 

short_specname(kongens_gate,'Kong. gt').
short_specname(kongens_gate_k1,'Kongens gt K1'). %% AtB
short_specname(kongens_gate_k2,'Kongens gt K2'). 

short_specname(kongensgate_k1,'Kongens gt K1'). 
short_specname(kongensgate_k2,'Kongens gt K2'). 
 
%short_specname(munkegata_m1,'Munkegt M1'). %% AtB
%short_specname(munkegata_m2,'Munkegt M2'). 
%short_specname(munkegata_m3,'Munkegt M3'). 
%short_specname(munkegata_m4,'Munkegt M4'). 
%short_specname(m41,'Munkegt M41'). 
%short_specname(munkegata_m5,'Munkegt M5'). 
%
%short_specname(m1,'Munkegt M1'). 
%short_specname(m2,'Munkegt M2'). 
%short_specname(m3,'Munkegt M3'). 
%short_specname(m4,'Munkegt M4'). 
%short_specname(m41,'Munkegt M41'). 
%short_specname(m5,'Munkegt M5'). 

short_specname(moholt_studentby,'Moholt stud. by'). 
%short_specname(munkegata,'Munkegt'). 

short_specname(p1,'Prins. gt P1').
short_specname(p4,'Prins. gt P4').

short_specname(prinsens_gate,'Prins. gt').
 
short_specname(prinsens_gate_p1,'Prins. gt P1'). %% AtB
short_specname(prinsens_gate_p4,'Prins. gt P4'). %% AtB

short_specname(prinsens_gt_p1,'Prins. gt P1'). %% AtB
short_specname(prinsens_gt_p4,'Prins. gt P4'). %% AtB

short_specname(nidarosdomen,'Prinsen kinos. '). 
short_specname(hesthagen,'Prof. Brochs gt'). 
short_specname(ranheim_stasjon,'Ranheim st. '). 
%short_specname(studentersamfundet_1,'Stud. samf. 1'). 
%short_specname(studentersamfundet_2,'Stud. samf. 2'). 
short_specname(ts,'Trondheim S'). 

short_specname(ts_10,'Trondheim S 10').  %% old names
short_specname(ts_11,'Trondheim S 11').  %% (avoid list of identical names)
short_specname(ts_13,'Trondheim S 13').  %%

short_specname(ts10,'Trondheim S 10'). 
short_specname(ts11,'Trondheim S 11').  %% (avoid list of identical names)
short_specname(ts13,'Trondheim S 13').  %%

short_specname(universitetet_lade,'Univ. Lade'). 

%How to usually write names in plain text.
%specname0(S0,S):- specname(S0,S),!.
%specname0(S0,S):- bigcap(S0,S).

specname('10c','10C'). 
specname('24a','24A'). 
specname('24c','24C'). 
specname('43e','43E'). 
specname('44a','44A'). 
specname('4a','4A'). 
specname('52a','52A'). 
specname('54c','54C'). 
specname('5a','5A'). 
specname('5c','5C'). 
specname('5c-e','5C-E'). 
specname('5e','5E'). 
specname('6a','6A'). 
specname('6c','6C'). 
specname('6e','6E'). 
specname('7a','7A'). 
specname('7c','7C'). 
specname('8a','8A'). 
specname('8c','8C'). 
specname('9e','9E'). 

specname(a_m_o_senteret,'AMOsenteret'). 
specname(adolf_øien,'Adolf Øien').  %%school/street
specname(alf_godagers_vei,'Alf Godagers vei'). 
specname(amo_senteret,'AMO senteret'). 
specname(anders_buens_gate,'Anders Buensgate').  %% EH-031017
specname(angelltrøveien,'Angelltrøveien'). 
specname(ankers_gt,'Ankersgate').  %% EH-030616
specname(arilds_gt,'Arildsgate').  %% EH-030616
specname(arnt_smistads_vei,'Arnt Smistads vei').  %%\+smistad(correction)
specname(asbjørn_øverås_veg,'Asbjørn Øverås veg'). %% RS-150813 Missing in autumn?

specname(asbjørnsens_gate,'Asbjørnsens gate'). %% old ?
specname(asbjørnsensgt,'Asbjørnsens gate').  %% EH-030616

specname(asbjørnsens_gt,'Asbjørnsens gate'). 
specname(atb,'AtB').  %% TA-101108

specname(bakkegata,'Bakkegate').  %% EH-030616
specname(bakkebru,'Bakkebru'). 
specname(balders_street,'Balders veg').  %%Syndrome/not regstr
specname(bekkasinv,'Bekkasinvegen').  %% EH-031017
specname(bergstudentby,'Berg studentby'). 
specname(bi,'BI'). 
%specname(biskop_sigurdsgt,'Biskop Sigurds gate').  %% EH-031017
specname(bjarne_ness_veg,'Bjarne ness vei'). 
%% specname(bjøra,'Bjøra'). 
specname(bjørkmyr,'Bjørkmyr'). 
specname(blusuvoll_alle,'Blusuvoll allé'). 
specname(brannstasjon_øst,'Brannstasjon øst'). 
specname(brattørbrua,'Brattørbrua'). 
specname(breidablikk_sk,'Breidablikk skole'). 
specname(britannia_hotell,'Britannia hotell').               %% airbus
specname(brukseier_olsens_vei_1,'Brukseier Olsensvei 1').    %% EH-030616
specname(brukseier_olsens_vei_40,'Brukseier Olsensvei 40').  %% EH-030616
specname(brukseier_olsens_vei_50,'Brukseier Olsensvei 50').  %% EH-030616
specname(brukseier_olsens_vei_l75_76,'Brukseier Olsensvei 75-76').  %% EH-030616
specname(brukseier_olsensv,'Brukseier Olsens vei'). 
specname(brukseier_olsens_vei_1,'Brukseier Olsens vei 1'). 
specname(brukseier_olsensv_40,'Brukseier Olsensvei 40'). 
specname(brukseier_olsensv_50,'Brukseier Olsensvei 50').  %% EH-031002
specname(brundalen_sk,'Brundalen skole'). 
specname(brundalen_skole,'Brundalen skole'). %% old
specname(brundalen_sykehj,'Brundalen sykehjem'). 
specname(brundalen_sykehjem,'Brundalen sykehjem'). 
specname(brøset_hageby,'Brøset hageby'). 
specname(brøsetflata,'Brøsetflata'). 
specname(brøsetv,'Brøsetvegen'). 
specname(brøsetvegen_168,'Brøsetvegen 168').  %% vei-> veg for konsistens EH-031017
specname(brøsetvegen_186,'Brøsetvegen 186').  %% NB. vei->veg EH-031017
specname(brøsetvegen,'Brøsetvegen'). 
specname(brøsetvegen_119,'Brøsetvegen 119'). 
specname(busstuc,'BussTUC'). 
specname(bybro,'Gamle bybro').
specname(byen,byen). 
specname(byåsen_butikksenter,'Byåsen butikksenter'). 
specname(byåsen_skole,'Byåsen skole'). 
specname(byåsen_videregående_skole,'Byåsen videregående skole'). 

%% specname(bøckmansveien,'Bøckmans veg'). %% Nix %% TA-110314

%% specname(c_j_hambros_vei,'C J Hambros vei').  %% unnec TA-101111

specname(carl_schjetnans_vei,'Carl Schjetnans vei'). %% TA-110322
%% specname(c_schjetnans_v,'C Schjetnansvei').       %% 

specname(charlottenlund_kirke,'Charlottenlund kirke'). %% unnec
specname(charlottenlund_kirke,'Charlottenlund kirke'). 

specname(charlottenlund_skole,'Charlottenlund skole'). 
specname(charlottenlund_vderegåen,'Charlottenlund videregående'). 
specname(charlottenlund_videregående,'Charlottenlund videregående'). 
specname(chr_eggens_veg,'Christian Eggens veg').  %% EH-030616
specname(chr_monsensgt,'Christian Monsens gate').  %% EH-031017
specname(christian_jelstrups_v,'Christian Jelstrups vei').  %% EH-030616
specname(churchills_v,'Churchills vei').  %% EH-030616
specname(clarion_hotell,'Clarion hotell').               %% airbus

specname(dmmh,'DMMH'). %% TA-110323

%% drop holdeplass %% TA-110531

specname(dr_gate_d1,'Dronningens gate D1').  
specname(dr_gate_d2,'Dronningens gate D2'). 
%specname(dr_gate_d3,'Dronningens gate D3'). 
%specname(dr_gate_d4,'Dronningens gate D4'). 
specname(dronningens_gate_d1,'Dronningens gate D1'). %% RS-150815. 2014 februarformat.  
specname(dronningens_gate_d2,'Dronningens gate D2'). 
%%specname(dronningens_gate_d3,'Dronningens gate D3'). 
%%specname(dronningens_gate_d4,'Dronningens gate D4'). 
specname(d1,'Dronningens gate D1').  %% EH-031120
specname(d2,'Dronningens gate D2').  %% 
%specname(d3,'Dronningens gate D3').  %%
%specname(d4,'Dronningens gate D4').  %%

specname(dyre_halses_gate,'Dyre Halses Gate').
specname(den,'den'). %% M .. den godes gate ... 
specname(devle_gård,'Devlegård'). 
specname(dist_lege_øvrelids_v,'Distriktslege Øvrelid svei').    %% EH-030616
specname(distriktslege_øverlidsv,'Distriktlege Øvrelids vei').  %% EH-030616
specname(dps,'DPS'). 
specname(dragvoll_alle,'Dragvoll allé'). 
specname(dronningens_gate,'Dronningens gate'). 
specname(dv,'Dragvoll').  %% Small letters/not Endstation
%% specname(dybdals_veg,'Dybdals veg'). %% TA-100830 unnec
specname(e_a_smith,'E A Smith').  %% EH-031017 
specname(e_b_schieldropsv,'E B Schieldropsvei').  %% EH-030616
specname(einar_tambarskjelves_gt,'Einar Tambarskjelves gate').  %% EH-030616
specname(einar_øfstis_veg,'Einar Øfstis veg'). 
specname(engelsås_endeholdeplass,'Engelsås endeholdeplass'). 
specname(f_rambech,'F Rambech').  %% EH-031017
specname(fagerheim_all,'Fagerheim allé'). 
specname(fagerheim_alle,'Fagerheim allé').  %% EH-030616
specname(fagerliv,'Fagerliveien').  %% EH-031017
specname(festningsgt,'Festningsgata'). 			 %% EH-031002 gaten->gata
 %% specname(festningsgt,'Festningsgaten'). 
specname(fjøslia,'Fjøslia'). 
specname(fjøsvollan,'Fjøsvollan'). 
specname(forsøket,'Forsøket'). 
specname(gløshaugen_nord,'Gløshaugen Nord'). 
specname(gløshaugen,'Gløshaugen Syd'). 
specname(godsterminalen_nsb,'Godsterminalen NSB').  %%(dontprintwhatisnot accepted)EH-030616
specname(granåsen_gård,'Granåsen gård'). 
specname(granåsen_vm_anlegget,'Granåsen VM-anlegget'). 
specname(gudes_gt,'Gudes gate'). 			 %% EH-030616
specname(gudruns_gate,'Gudruns gate'). 			 %% EH-030616
%specname(haakon_vii_gt,'Haakon VII gate'). 
%specname(haakon_vii_gate_17,'Haakon den sjuendes gate 17'). 
specname(haakon_vii_gate_25,'Haakon den sjuendes gate 25'). 
%%specname(haakon_vii_gate_29,'Haakon den sjuendes gate 29'). 
%specname(haakon_vii_gate_9,'Haakon den sjuendes gate 9'). 
specname(hallfred_høyems_vei,'Hallfred Høyems vei'). 
specname(halstein_gård,'Halstein gård'). 
specname(harald_bothnersv,'Harald Bothners vei'). 	 %% EH-030616
specname(harald_hårfagres_gt,'Harald Hårfagres gate'). 
specname(heggstadmoen_2,'Heggstadmoen 2').  %% slight error in busroute
specname(heggstadmoen_4,'Heggstadmoen 4').  %% slight error in busroute
%%%  specname(heimdal_st,'Heimdal stasjon').  
specname(heimdalsveien,'Heimdalsvegen').  %% (not . ) EH-030616. vei-> veg EH-031017
%% specname(heimdalsv,'Heimdalsveien').  %% (not . ) EH-030616
specname(heimdal_sentrum,'Heimdal sentrum'). %%  week 33/34?

%% specname(henrik_ourens_vei,'Henrik Ourens vei').  %% (extra dot in reghpl) EH-030616
specname(hist,'HIST').  %% (IKKE Hist!)
specname(hjalmar_johansens_vei,'Hjalmar Johansens vei'). 
specname(hommelvik_skole,'Hommelvik skole').  %% RS-140614 not since 2013? No longer auto-generated
specname(hospitalskirka,'Hospitalskirka').  %%(Rutehefte)
specname(hotel,'Hotel'). 
specname(hotell,'Hotell'). 
specname(hovedterminalen,'Sentrumsterminalen').  %% // Political decision
specname(høgreina_øvre,'Høgreina øvre'). 
specname(høyset,'Høyset'). 
specname(idi,'IDI').  %% TA-110401
specname(ingeborg_ofstadsv,'Ingeborg Ofstads veg').  %% EH-031017
specname(jakobslivegen_øvre,'Jakobsliveien øvre').  %%jakobsliv
specname(jakobsliveien_nedre,'Jakobsliveien nedre').  %%jakobslivn!!
specname(johan_falkbergets_vei,'Johan Falkbergets veg').  %%Talsmann
specname(johan_p_kroglundsv,'Johan P Kroglunds vei'). 
specname(johan_tillers_vei,'Johan Tillers vei').  %% EH-031017
specname(johannes_minsaas_veg,'Johannes Minsaas veg'). 
%specname(john_aae_s_veg,'John Aaes veg').  %% (avoid, Aae`s in return)
specname(jørgen_b_lysholms_vei,'Jørgen B Lysholms vei'). 
specname(k_jonssons_veg,'Karl Jonssons vei'). 
specname(k_o_thornæs_vei,'K O Thornæs vei').  %% EH-030616
specname(kbs,'KBS').
specname(kbs_senteret,'KBS-senteret'). 
specname(kino,'"kino"'). 
specname(klett_møbel,'Klett Møbel'). 
specname(klæbu_skysstasjon,'Klæbu skysstasjon'). 
specname(kong_øysteins_veg,'Kong Øysteins veg'). 

%% RS-130812
specname(kongens_gate,'Kongens gate').
specname(kongens_gate_k1,'Kongens gate K1').  
specname(kongens_gate_k2,'Kongens gate K2'). 
specname(k1,'Kongens gate K1').  %% RS-130812
specname(k2,'kongens gate K2').  %% 

specname(kronprins_olavs_alle,'Kronprins Olavs allé'). 
%% specname(kroppanmarka_endehpl,'Kroppanmarka endeholdeplass'). 
specname(kuset_gård,'Kuset gård'). 
specname(kvt,'KVT'). 
specname(kystad_alle,'Kystad allé'). 
specname(køff,'KØFF'). 


specname(lade_all,'Lade allé'). %% 'Lade allé').  AtB
specname(lade_allé_80,'Lade allé 80'). 


specname(lade_gård,'Lade kirke'). 
specname(ladejarlen_v_g_s,'Ladejarlen skole'). %% realspeak 
specname(lademoen_kirke,'Lademoen kirke'). 
specname(lademoen_skole,'Lademoen skole'). 
specname(leangen_all,'Leangen allé'). 
specname(leangen_allé,'Leangen allé'). 
specname(leira_sk,'Leira skole').
specname(leirfossveien,'Leirfossveien'). 
specname(leirøya,'Leirøya'). 
specname(lerkendal_gård,'Lerchendal gård'). 
specname(lingit,'LingIT'). 
specname(loholt_alle,'Loholt allé'). 
specname(los_angeles,'Los Angeles').  %% for American queries
specname(lundåsen_n,'Lundåsen nedre').  %% Talsmann
%% specname(løvaasveien,'Løvaasveien').  %% TA-110530  unnec


%specname(munkegata_m0, 'Munkegata M0').  
%specname(munkegata_m1, 'Munkegata M1'). 
%specname(munkegata_m2, 'Munkegata M2'). 
%specname(munkegata_m3, 'Munkegata M3'). 
%specname(munkegata_m4, 'Munkegata M4'). 
%specname(munkegata_m5, 'Munkegata M5'). 
%specname(munkegata_m41, 'Munkegata M41').%% TA-110107
%specname(m41, 'Munkegata M41'). %% SIC (in route data) %% TA-110107
%
%specname(m0, 'Munkegata M0').  %% keep old names also 
%specname(m1, 'Munkegata M1').  %%
%specname(m2, 'Munkegata M2').  %%
%specname(m3, 'Munkegata M3').  %%
%specname(m4, 'Munkegata M4').  %%
%specname(m5, 'Munkegata M5').  %%

specname(magnus_berføttsvei,'Magnus Berføtts vei').  %% EH-031017
specname(magnus_blindesv,'Magnus Blindes vei'). 	  %% EH-030616
specname(marcus_thranesv,'Marcus Thranes vei'). 	  %% EH-030616
specname(margretes_gt,'Margretes gate'). 
specname(marie_sørdals_veg,'Marie Sørdals veg'). 
specname(markaplassen_vest,'Markaplassen Vest'). 
specname(markaplassen_øst,'Markaplassen Øst'). 
specname(markaplassen_skole,'Markaplassen skole').   
specname(mauritz_hansens_gt,'Mauritz Hansens gate'). 	%% EH-030616
 %% specname(mellomv_5,'Mellomveien 5'). 	
specname(mentz_skjetnes_v,'Mentz Skjetnes vei'). 	   %% EH-030616
specname(moltmyra_øst,'Moltmyra øst'). 


specname(munkvoll_gård,'Munkvoll gård'). 
specname(møllebakken,'Møllebakken'). 
specname(møller_bil,'Møller bil'). 
specname(n_g_u,'NGU'). 
specname(n_t_h,'NTH'). 
specname(naf,'NAF'). 
specname(nedre_alle,'Nedre allé'). 
specname(nedre_alle,'Nedre allé'). 
specname(nedre_elvehavn,'Nedre elvehavn'). 
specname(nedre_møllenberg,'Nedre Møllenberg'). 
specname(nidarvoll_sk,'Nidarvoll skole'). 
specname(nidarvoll_skole,'Nidarvoll skole'). %% old
specname(nkl,'NKL'). 
specname(nordre_halset,'Nordre Hallset'). 
specname(nordre_hoem,'Nordre Hoem'). 
specname(nordslettveien_snuplass,'Nordslettveien snuplass'). 
specname(norske_meierier,'Norske meierier'). 
specname(olav_tryggvasons_gate_ot2,'Nova kinosenter').  %%k
specname(nrk,'NRK'). 
specname(nth,'NTH'). 
specname(ntnu,'NTNU'). 
specname(ntnu_lade,'NTNU Lade').  %%Outdated
specname(obs,'OBS'). %not offic. 
specname(city_syd,'City Syd').    %% NEC, CS no longer station %% TA-110624
specname(city_lade,'City Lade').  %%Changedname,not inRouteData
%% specname(odensev,'Odenseveien').  %% EH-031017
specname(okstadøy,'Okstadøy'). 
specname(ola_setroms_vei,'Ola Setroms vei'). 
specname(olaf_bulls_vei,'Olaf Bulls vei'). 	
specname(olav_engelbrektssons_all,'Olav Engelbrektssons allé').   %% AtB %% TA-101018
specname(olav_engelbrektssons_allé,'Olav Engelbrektssons allé').  %% EH-031017
specname(olav_nygårdsv,'Olav Nygårds vei'). 
specname(olav_trygvassons_gt,'Olav Tryggvasons gate').  %% AtB MISSPELLEDINDATABASE
specname(olav_tryggvasons_gt,'Olav Tryggvasons gate').  %%Default
specname(olav_kyrres_gate, 'Olav Kyrres Gate').

specname(omkjøringsv_klæbuvveien,'Omkjøringsveien Klæbuveien').  %% EH-031121
specname(moholt_omkjøringsvei,'Omkjøringsveien Moholt'). 
specname(nardo_omkjøringsvei,'Omkjøringsveien Nardo').

specname(orkanger_skole,'Orkanger skole'). %% RS-131222. Flere!

specname(oscar_wistingsv,'Oscar Wistings vei').  %% EH-031017
specname(otto_nielsens_veg,'Otto Nielsens vei'). 
specname(paul_skolemesters_veg,'Paul skolemesters veg').%% TA-110803

specname(peder_kroghs_v,'Peder Kroghs vei'). 
specname(peder_morsets_vei,'Peder Morsets vei'). 	
specname(persaunet_leir,'Persaunet leir'). 
specname(persaunev,'Persaunevegen'). %% outdated?
specname(prestegårdsjordet,'Prestegårdsjordet').  %% (error)
specname(nidarosdomen,'Prinsen kinosenter').  
specname(prinsens_gate,'Prinsens gate'). 

specname(prinsens_gate_p1,'Prinsens gate P1'). %% RS-140102
specname(prinsens_gate_p2,'Prinsens gate P2').
%specname(prinsens_gate_p3, 'Prinsens gate P3'). %% All nightbusses are canceled until further notice

specname(p1,'Prinsens gate P1').  %% RS-140102
specname(p2,'Prinsens gate P2').  %% RS-140102
specname(p3,'Prinsens gate P3').

specname(ratesvingen, 'Ratesvingen').
specname(r_i_t_hovedporten,'St Olavs hospital'). 
specname(ranheim_kirke,'Ranheim kirke').  %% RS-130302 Replaced by Nedre Humlehaugen Øst 
specname(reppe_endehlp,'Reppe endeholdeplass'). 
specname(ringve_skole,'Ringve skole'). 
specname(risvollan_senter,'Risvollan senter').
specname(rit,'RIT'). 
specname(roial_garden,'Royal Garden').  %% Nattbuss Spell
specname(rormyra,'Rørmyra'). 
specname(rosenborg_gt,'Rosenborg gate'). 	
specname(rosenborg_sk,'Rosenborg skole'). 

specname(rosenborg_skole,'Rosenborg skole'). %% AtB

specname(rotvoll_all,'Rotvoll allé'). 
specname(royal_garden,'Royal Garden'). 
specname(royal_garden_hotell,'Royal Garden hotell'). %% airbus

specname(rye_skole,'Rye skole').
specname(santa_barbara,'Santa Barbara'). 
specname(sas,'SAS'). 
specname(saxenborg_all,'Saxenborg allé'). 
%specname(esso_motorhotell,'Esso Motorhotell').  %% ??? (Old station name) %% RS-150913
specname(senter,senter). 
specname(sentrum,sentrum). 

%% specname(sig_berg_alle,'Sigurd Bergs allé').   

specname(saksvikorsen, 'Saksvikorsen').                                               
specname(singsaker_studenthjem,'Singsaker studenthjem'). 
specname(sirkus_shopping,'Sirkus Shopping').
specname(sivert_thonstadsv,'Sivert Thonstads vei'). 	 %% EH-030616
specname(sk,skole). %% nohelp?
specname(skavlans_vei,'Skavlands vei'). 
specname(smstuc,'SMSTUC'). 
specname(solbakken_skole,'Solbakken skole'). 
specname(solberg_mek_verksted,'Solbergmekaniskeverksted'). 	 %% EH-030616
specname(sondre_hoem_sporvogn,'Søndre Hoems porvogn'). 
specname(st_olavs_hospital_vest,'St Olavs hospital vest'). 
specname(st_olavs_hospital_øst,'St Olavs hospital øst'). 
specname(sigrid_saxedatters_veg, 'Sigrid Saxedatters veg').

%%% specname(st_olavs_hospital,'St Olavs hospital hovedporten'). %% TA-100827
specname(st_olavs_street,'St Olavs gate').
specname(st_olavs_gate,'St Olavs gate'). 
specname(st_olavs_hospital,'St Olavs hospital'). 
specname(statens_hus,'Statens hus'). 
specname(stavset_senter_2,'Stavset senter 2').  %%, holdeplass 2'). 
specname(steinanstudentby,'Steinan studentby'). 
specname(strinda_kirke,'Strinda kirke'). 
specname(strindheim_sk,'Strindheim skole'). 
%specname(studentersamfundet_1,'Studentersamfundet 1'). 
%specname(studentersamfundet_2,'Studentersamfundet 2'). 
specname(støren_st,'Støren stasjon'). 
specname(sverresborg_alle,'Sverresborg allé'). 
specname(sverresborg_folkemuseum,'Sverresborg folkemuseum'). 
specname(sæterbakken_bratsberg,'Sæterbakken Bratsberg'). 
specname(olav_tryggvasons_gate_ot3,'Søndre gate 22'). 
specname(olav_tryggvasons_gate_ot3,'Søndre gate 23'). 
specname(søndre_hoem,'Søndre Hoem'). 
specname(søndregate,'Søndre gate').  %% The neighbourhood (22/23)

specname(tagore,'Tagore'). 

specname(tbane,'T-bane'). 
specname(tempevegen_11,'Tempevegen 11'). 
specname(lerkendal,'Tempe kirke').   
specname(lerkendal,'Tempe kirke').  %% Airbus name
specname(tf,'Telenor Forskningssenter'). 
specname(thora_storms_vei,'Thora Storms vei'). 
specname(tilleringen_130,'Tillerringen 130').  %% (erri)
specname(tmn,'Trafikanten Midtnorge'). 
specname(tordenskiolds_gt,'Tordenskjolds gate').  %% NB iold
specname(tordenskjolds_gt,'Tordenskjolds gate'). 
specname((tore,amble),'Tore Amble').		%RS-110929
specname(tranev,'Traneveien').  

specname(trollahaugen_10,'Trollahaugen 10'). 
specname(trollahaugen_2,'Trollahaugen 2'). 
specname(trollahaugen_46,'Trollahaugen 46'). 
specname(trollahaugen_64,'TROLLAHAUGEN 64'). 

specname(trondheim_torg,'Trondheim Torg'). 

specname(trondheim_sentralstasjon,'Trondheim Sentralstasjon'). %% TA-110628
specname(ts,'Trondheim Sentralstasjon'). 

specname(ts10,'Trondheim Sentralstasjon ') :- value(airbusflag,true),!. 
specname(ts11,'Trondheim Sentralstasjon ') :- value(airbusflag,true),!.
specname(ts13,'Trondheim Sentralstasjon ') :- value(airbusflag,true),!.

specname(ts10,'Trondheim Sentralstasjon holdeplass 10'). 
specname(ts11,'Trondheim Sentralstasjon holdeplass 11').  %% EH-031017
specname(ts13,'Trondheim Sentralstasjon holdeplass 13'). 

specname(ts_10,'Trondheim Sentralstasjon holdeplass 10'). %% old names
specname(ts_11,'Trondheim Sentralstasjon holdeplass 11'). 
specname(ts_13,'Trondheim Sentralstasjon holdeplass 13'). 

specname(tt,'AtB'). 
specname(tuc,'TUC'). 
specname(tulluan_sk,'Tulluan skole'). 
specname(tunga_kretsfengsel,'Tunga kretsfengsel'). 
specname(tverrforb_1,'Tverrforbindelsen 1'). 
specname(tyholt_alle,'Tyholt allé'). 
specname(tyholtv,'Tyholtvegen').  %%Talsmann
specname(tyholtv,'Tyholtveien').  %% EH-031017
specname(tøh,'TØH'). 
specname(ullins_vei,'Ullins vei'). 
specname(universitetet_lade,'Universitetet Lade'). 
specname(utsikten_alle,'Utsikten allé'). 
specname(valentinlystv,'Valentinlystvegen'). 
specname(valset_gård,'Valset gård').  %% outdated 
specname(valøyvegen,'Valøyvegen'). 
specname(valøyvegen,'Valøyvegen').  %% EH-031017 vei->veg. Korrekt/entydig skrivemåte
specname(veisletten_alle,'Veisletten allé'). 
specname(vestlia_endeholdeplass,'Vestlia endeholdeplass'). 
specname(vikåsen_skole,'Vikåsen skole'). 
specname(vollgt,'VOLLGATEN'). 
specname(vådanv_5,'Vådanveien 5'). 
specname(være_østre,'Være Østre'). 
specname(væretroa,'Værestrøa').         %  Det heter nå Værestrøa *** med s. 
specname(værestroa,'Værestrøa'). 
specname(værestrøa,'Værestrøa'). %% Off name  
specname(øvre_alle,'Øvre allé'). 
specname(øvre_flatåsv,'Øvre Flatåsveg'). 
specname(øya_helsehus,'Øya Helsehus').		%RS-110926

specname(skovgård, 'Skovgård').
specname(strindfjordvegen, 'Strindfjordveien').
%% Trapez (Nytt rutesystem hos AtB) -> Hastus synplaces (to make it work). %% TA-2011 -> RS-150815


%%%%%%%%% synplace(tveregga,tvereggen).
%%%%%%%%% synplace(tverregga,tvereggen).

%% RS-160108. Use cmpl for multiword synplaces, e.g. 

synplace(lensvik, lensvik_hurtigbåtkai). %% added for the boat passing lensvik %% AE 20200703
synplace(lensvika, lensvik_hurtigbåtkai).


synplace(ladeparken, lademoparken).
synplace(lamoparken, lademoparken).

synplace(easmith,e_a_smith). 

synplace(mobilt,moholt). %% ???

%%%% synplace(engelbrektssons,engelbrektsons).
%%%% synplace(morsets,morsetts).
%%%% synplace(morset,morsett).

synplace(morseths,morsets). %% NEC

synplace(ostmarka,østmarka). 
%% synplace(ola,ila). %% Hazard? %% TA-110328

%% synplace(olavtrygvasonsgate,olav_tryggvasons_gate_ot1). %% CORREC %% TA-101203 %% AtB DUPLICATE!

synplace(polishuset,ts). %% AtB. %%  ts is neib). 

synplace(reppekrysset,reppevegen). %%  reppevegen is not in the routes

synplace(rosa,ross). %% ? %% TA-110415 Ole Ross veg
synplace(rosta,rosten). %% / 

synplace(staøren,støren). %% TA-101221

%% synplace(steinåsen,seinåsen). 

%% synplace(stiklestadveien,stiklastadveien). %% fixed 
synplace(stiklesveien,ladeveien). %% ?

synplace('va|retraøa',værestrøa).
synplace(val,valentinlyst).
synplace(valgrindveien,valgrindsveien). 
synplace(væretrøa,værestrøa). %% NB væres
synplace(væretøa,værestrøa).   %%
synplace(skjåness,sjåness).
synplace(toming,thonning). 
synplace(tornes,thornæs). %% TA-110203
synplace(torpsvei,torps_vei).
synplace(oppland,opland).
synplace(prestegårsjordet,prestegårdsjordet).
synplace(endeholdepl,endehpl).
synplace(tyholtårnet,strinda_vgs).   %% NB 1 t


synplace('by''n',sentrum).  %%By'n==>'by''n'
synplace('la''moen',lademoen). 
synplace(aaer,aaes). 
synplace(aamfundet,samfundet).  %%?
synplace(aasheim,åsheim). 
synplace(aasn,aaes). 
synplace(aasveienskole,åsveien_skole). 
synplace(adgenes,agdenes). 
synplace(adressa,adresseavisen). 
synplace(aentralstasjonen,ts). %% AtB. 
synplace(aila,ila).  %% ?
synplace(akobsli,jakobsli). 
synplace(alcatraz,munkholmen). %% :-)
synplace(alentinlyst,valentinlyst).  %% ?
synplace(alesund,ålesund). 
synplace(alfheimsvegen,alfheimsvingen). 
synplace(alfheimsvei,alfheimsvingen). 
synplace(alfheimsvei,alfheimsvingen). 
synplace(alfheimsveien,alfheimsvingen). 
synplace(alfheimsvingen,alfheimsvingen). 

synplace(alvheimveien,alfheimsvingen). %% etc 

synplace(alpintbussen,alpinbussen). 
synplace(alvheimsvegen,alfheimsvingen). 
synplace(alvheimsvei,alfheimsvingen). 
synplace(alvheimsvei,alfheimsvingen). 
synplace(alvheimsveien,alfheimsvingen). 
synplace(ambjørnsensgate,asbjørnsens_gate).  %%(nospellc)
synplace(amfundet,samfundet).  %%neib
synplace(amfunnet,samfundet).  %%
synplace(amigosenteret,hallset). %% TA-100519
%synplace(migosenteret,hallset). %% TA-100519
synplace(amunkegata,munkegata). 
synplace(andersbuensgate,anders_buens_gate). 
synplace(andersbuesgate,anders_buens_gate). 
synplace(angelltrøvegen,angelltrøveien). 
synplace(ankererveien,ankerveien). 
synplace(anlegg,anlegget). 
synplace(anleggene,anlegget). 
synplace(anrdo,nardo).  %% ? 
synplace(antongrevskottsgate,anton_grevskotts_vei). 
synplace(antongrevskottsgt,anton_grevskotts_vei). 
synplace(antongrevskottsvei,anton_grevskotts_vei).
synplace(ardo,nardo).  %%?
synplace(arneberggårdsv,arne_bergsgårds_vei). 
synplace(arneberggårdsvei,arne_bergsgårds_vei). 
synplace(arnebergsgårdsvei,arne_bergsgårds_street).  %%(systemat?)
synplace(arnebergsgårdsvei,arne_bergsgårds_vei).  
synplace(arntsmistadsv,arnt_smistads_vei).  
synplace(asbjørnsgate,asbjørnsens_gate). 
synplace(asbjørnsveien,asbjørnsens_gate). 
synplace(asbjørnøveråsveg,asbjørn_øverås_street). 
synplace(asentrum,sentrum). 
synplace(askeladenveien,askeladdvegen). 
synplace(astronautveien,astronom_street). 
synplace(astt,tt). 
synplace(astudentersamfundet,studentersamfundet). 
synplace(asveien,åsveien). 
synplace(atrindheim,strindheim). 
synplace(atudentersamfundet,studentersamfundet). 
synplace(auran,buran).  %% ?
synplace(austmarka,østmarka). 
synplace(avdelingskontoret,servicekontoret).  
synplace(bachs,brochs). 
synplace(bake,bakke). 
synplace(bakgate,bakkegata).  %% ?
synplace(bakkbro,bakkebru). 
synplace(bakkbroen,bakkebru). 
synplace(bakkbru,bakkebru). 
synplace(bakkbruen,bakkebru). 
synplace(bakkebro,bakkebru). 
synplace(bakkebroen,bakkebru). 
synplace(bakkebru,bakkebru). 
synplace(bakkebruen,bakkebru). 
synplace(bakkebybro,bakkebru).  %% ?
synplace(bakkekirke,bakkegata). 
synplace(bakkeland,bakklandet). 
synplace(bakklainne,bakklandet). 
synplace(bakkland,bakklandet). 
synplace(bakklanne,bakklandet). 
synplace(baklane,bakklandet). 
synplace(baklanee,bakklandet). 
synplace(balentinlyst,valentinlyst).  %% ?
synplace(balgård,dalgårdd). 
synplace(banegården,jernbanestasjonen). 
synplace(banestasjon,jernbanestasjonen). 
synplace(banestasjonen,jernbanestasjonen). 
synplace(bardo,nardo). 
synplace(barfots,berrføtts). 
synplace(barneavd,barneklinikken).  %%synname
synplace(barneskole,skole). 
%% synplace(barnhage,barnehage). 
synplace(bartlamoen,svartlamon). 
synplace(bartlamon,svartlamon). 
synplace(bbyen,byen). 
synplace(bbyn,byen).
synplace(beg,berg).  %% nohash<4
synplace(beldevere,belvedere). 
synplace(belverede,belvedere). 
synplace(berf,berg). %% ?
synplace(berføttsvei,berrføttsveg).   
synplace(berrføttsvei,magnus_berrføttsveg). 
synplace(berfoettsvei,berføttsvei). 
synplace(berg,bergs).  %%nohashbecausenot unknown
synplace(bergkirke,berg_prestegård). 
synplace(bergårdsvei,bergsgårdsvei). 
synplace(bert,berg). %% ?
synplace(bestlia,vestlia). 
synplace(beunge,buenget). 
synplace(bharlottenlund,charlottenlund).  %%?
synplace(bidtbyen,sentrum). 
synplace(bikåsen,vikåsen). 
synplace(bilioteket,biblioteket). 
synplace(billettkontoret,servicekontoret). 
synplace(birbadet,pirbadet). 
synplace(birchs,brochs). 
%synplace(biskopsigurdsgate,biskop_sigurds_gate). 
synplace(bispegaten,bispegata). 
synplace(biyosen,byåsen). 
synplace(bjørdalsrua,bjørndalsbrua). 
synplace(bjørndalbru,bjørndalsbrua).  
synplace(bjørndalbua,bjørndalsbrua). 
synplace(bjørndalen,bjørndalsbrua). 
synplace(bjørndalsbroen,bjørndalsbrua). 
synplace(bjørndalsbroen,bjørndalsbrua). 
synplace(bjørndalsbruen,bjørndalsbrua). 
synplace(bjørndalsbua,bjørndalsbrua). 
synplace(bjørndalstopnne,bjørndalstoppen). 
%% synplace(bjørndas,bjørndals). %%  (nec?)

synplace(bjørnebru,bjørndalsbrua). 
synplace(bjørnebrua,bjørndalsbrua). 
synplace(bjørnsdalsbura,bjørndalsbrua). 
synplace(bjørnstadbrua,bjørndalsbrua). 
synplace(bks,kbs).
%% synplace(blaklia,blakli). %% \+ baklia 
synplace(blodbank,blodbanken). 
synplace(blussevoll,blussuvoll). 
synplace(boll,voll).  
synplace(bollabakken,vollabakken).
synplace(borcghrevinkvei,borchgrevinks_street). 
synplace(borch,brochs). 
synplace(borchs,brochs). 
synplace(borgchrevinkvei,borchgrevinks_street). 
synplace(borsa,børsa). %% Trlag

synplace(bowling,bowling_1). 
synplace(bowlingen,bowling_1). 
% synplace(bran,buran). %% confus? 
synplace(brannstasjon,brannstasjonen). 
synplace(bratbegsvegen,bratsbergvegen). 
synplace(bratsbeg,bratsberg).  %% \+brattsveg 
synplace(bratsbergkirke,bratsberg_kirke). 
synplace(brattbergsveien,bratsbergvegen). 
synplace(brattoera,brattøra). 
synplace(brattørtveita,brattørveita). %%  SIC brattø/err in regstr
synplace(brattsbergeveien,brattsbergveien). 
synplace(brattsbergsveien,bratsbergvegen). 
synplace(brattsbergvegen,bratsbergvegen). 
synplace(brattsperg,bratsberg). 
synplace(bredablikkskole,breidablikk_skole). 
synplace(bredablitt,breidablikk).  %%Dbl
synplace(breidablikk,breidablik).  %%breidablikkveien->breidablikveien
synplace(breidablikkskole,breidablikk_skole). 
%synplace(broch,brochs).  %% \+ spc because known
synplace(broch,odd_brochmanns_street).  %% RS-160108
synplace(brochs,hesthagen).  %%?
synplace(brochsgate,hesthagen). 
synplace(brochsvei,hesthagen).
synplace(brogs,brochs). 
synplace(bromsdat,bromstad). 
synplace(bromsetsvingen,bromstadsvingen). 
synplace(brundal,brundalen). 
%synplace(brundalenskole,brundalen_skole).   
synplace(brundalensykehjem,brundalen_sykehjem).
synplace(brundarn,brundalen). 
synplace(brygen,bryggen). 
synplace(brygga,pirbadet).  
synplace(brødsettveien,brøsetv).  %%v. ! %%  \tsx brødsettveien brotsetv
synplace(brøsetflatata,brøsetflata). %?
synplace(brøseth,brøset). 
synplace(brøsethvegen,brøsetv).  %%
synplace(brøsethveien,brøsetv).  %% station is preferred %%  Touchy
%% brøsetvegen_168 Station was removed in 2014. %% RS-150104
synplace(brøsetvegen168,brøsetvegen_168).   
%% synplace(brøsetvegen186,brøsetvegen_186). 
synplace(brøsetvn168,brøsetvegen_168).
%% synplace(brøsetvn186,brøsetvegen_186). 
synplace(brøsterveien,brøsetvegen). 
synplace(buan,buran). 
synplace(buen,buens). %% nec anders b 
synplace(buen,byen).  %%  Haz Anders B?
synplace(bueng,buenget).  %% beunsgt ? buengvegen
synplace(buengenet,buenget). 
synplace(buensgate,anders_buens_gate). 
synplace(buenteg,buenget). 
synplace(bukkvoll,bukkvollan).  %% street
synplace(bunkegata,munkegata). 
synplace(bura,buran). 
synplace(burn,buran). 
synplace(buråk,brurok).  %% \+ buran
synplace(busskontoret,servicekontoret). 
synplace(busstermialen,hovedterminalen). 
synplace(bussterminal,hovedterminalen). 
synplace(busstermin,hovedterminalen). 
synplace(busterminal,hovedterminalen). 
synplace(butan,buran). %% TA-110214
synplace(buterminalen,hovedterminalen). 
synplace(buyn,byen).
synplace(bya,sentrum). 
synplace(bye,sentrum).  %% (unless unwanted_place)

synplace(byen,sentrum).  %% TA-110120 * byen Hønefoss 

synplace(byasveien,byås_street).  %% problem
synplace(byasvei,byås_street).    %%  TSX <--- byÃ¥sveien //nohelp
synplace(byaysveien,byås_street). 
synplace(byaysveien,byås_street).

synplace(byaas,byås). %% nec for byås_street (< 5 chars)
synplace(byaasen,byåsen). 
synplace(byaysen,byåsen).  %%byÃ¥sen
synplace(bybdahls,dybdahls). 
synplace(byem,byen). 
synplace(byenk,byen). 
synplace(bygensen,bygrensen). 
synplace(bygransen,bygrensen). 
synplace(bykjerna,sentrum). 
synplace(bykjernen,sentrum). 
synplace(byn,sentrum).  %% By'n==>byn WEB
synplace(byne,byen). 
synplace(bynes,byneset). %% TA-110331 
  %% w(bynes,[name(bynes,n,0),name(bryns,n,0),name(byens,n,0),name(byes,n,0)])
synplace(bysenet,byneset). 
synplace(bysentralen,hovedterminalen). 
%%  synplace(bysn).  byen | byåsen ?
synplace(byterminalen,hovedterminalen). 
synplace(byterminal,hovedterminalen).  
synplace(bytårnet,strinda_vgs).  
synplace(byås,byåsen). 
synplace(byåse,byåsen). 
synplace(byåsenhallen,byåsen_videregående_skole).   
synplace(byåsensenter,byåsen_butikksenter).
synplace(byåsenvgs, byåsen_videregående_skole). %% migosenteret). %%  byåsen_skole). 
synplace(byåskole,byåsen_skole).        
synplace(byåsskole,byåsen_skole).       %% . . . 
synplace(bæretrøa,værestrøa). %% off name 
synplace(bærføtsvei,berføttsvei).  %% Doesn'thelp
synplace(bærrføtsvei,berføttsvei). 
synplace(bøchmannsvn,bøckmans_street). 
synplace(bøchmannsvn,bøckmansveien). 
synplace(bøckmannsveg,bøckmans_street). 
synplace(bøckmannsveg,bøckmansveien). 
synplace(bøckmannsvegen,bøckmans_street). 
synplace(bøckmannsvegen,bøckmansveien). 
synplace(bøckmannsvei,bøckmans_street).  %% (discr>1). . . 
synplace(bøckmannsvei,bøckmansveien).  %% (discr>1). . . 
synplace(bøckmannsveien,bøckmans_street). 
synplace(bøckmannsveien,bøckmansveien). 
synplace(bøckmansvei,bøckmans_street). 
synplace(bøckmansvei,bøckmansveien). 
synplace(børdsåns,bårdsøns).  %% actual

synplace(carljohnssonsvei,karl_jonssons_veg). 
synplace(carljonssonsvei,karl_jonssons_veg). 

synplace(carlottenlundkirke,charlottenlund_kirke).   
synplace(casperlundesgate,casper_lundes_veg). 
synplace(casperlundesv,casper_lundes_veg). 
synplace(casperlundesv,casper_lundes_veg). 
synplace(casperlundesveg,casper_lundes_veg). 
synplace(casperlundesvei,casper_lundes_veg).
synplace(cbs,kbs). 
synplace(cbssenteret,kbs_senteret).  %%
synplace(center,hovedterminalen). 
synplace(centere,hovedterminalen). 
synplace(centre,hovedterminalen). 
synplace(centrum,hovedterminalen).  %% Necessary, centrum is partname

synplace(charlottenberg,charlottenlund). 
synplace(chalottenlud,charlottenlund). 
synplace(chrlottelud,charlottenlund).   
synplace(chrlottenlun,charlottenlund).  

synplace(char,charlottenlund). 
synplace(charlotenlumd,charlottenlund). 
synplace(charlotnlund,charlottenlund). 
synplace(charlotten,charlottenlund). 
synplace(charlottend,charlottenlund). 
synplace(charlottenli,charlottenlund). 
synplace(charlottenlid,charlottenlund). 
synplace(charlottenlundungdomskole,charlottenlund_skole).  
synplace(charottelund,charlottenlund). 
synplace(chl,charlottenlund). 

synplace(cicilienborg,cecilienborg). 
synplace(cicillienborg,cecilienborg). 
synplace(cirkus,sirkus_shopping).
synplace(cirkussenteret,sirkus_shopping).
synplace(cirkusshopping,sirkus_shopping).
synplace(cisilienborg,cecilienborg). 
synplace(citi,city).  %% not nec syd (Eng)
%% synplace(cityn,city_syd). %%  confuse
synplace(citilade,lade_idrettsanlegg). 
%% synplace(city,hovedterminalen). %% confuse city syd %% TA-110627
synplace(citylade,lade_idrettsanlegg). 
synplace(cytisyd,city_syd). 

synplace(d1,dronningens_gate_d1).       %% RS-150815. old (2014-feb) station identifiers
synplace(d2,dronningens_gate_d2).
%%synplace(d3,dronningens_gate_d3).
%%synplace(d4,dronningens_gate_d4).
synplace(d1,dr_gate_d1).                %% RS-150815. Experiment. Move to compl (shortest "catch all" last) ? What about Christmas: long station name
synplace(d2,dr_gate_d2).
%synplace(d3,dr_gate_d3).
%synplace(d4,dr_gate_d4).

synplace(dagevoll,dragvoll). 
synplace(dalenhage,dalen_hageby). 
synplace(dalgaard,dalgård). 
synplace(dalgården,dalgård). 


synplace(dalsethveien,dalsetveien). 
synplace(dargvold,dragvoll). 
synplace(darvoll,dragvoll). 
synplace(degavoll,dragvoll). 

synplace(devle,devlesvingen). 
synplace(devlesveien,devlesvingen). 


synplace(dgarvoll,dragvoll). 
synplace(diplomis,iskremfabrikken). 
synplace(diplomisfabrikken,iskremfabrikken). 
synplace(distriktspsykiatriske,dps). %%  Tiller
synplace(dlane,dalen). 
%% synplace(dmmh,dalen_hageby). 


synplace(doggparken,solsiden). 
synplace(dokkaia,solsiden). 
synplace(dokkanparken,solsiden). 
synplace(dokkbakken,solsiden). 
synplace(dokkerparken,solsiden).  
synplace(dokkpark,solsiden). 
synplace(dokkplassen,solsiden). 
synplace(dolsiden,solsiden).
synplace(dors,dora). 
synplace(drag,dragvoll). 
synplace(drag,dragvoll).  %% -dragv,dora,etc. 
synplace(dragol,dragvoll). 
synplace(dragold,dragvoll).  
synplace(dragv,dragvoll). 
synplace(dragvild,dragvoll). 
synplace(dragvo,dragvoll). 
synplace(dragvod,dragvoll). 
synplace(dragvokk,dragvoll). 
synplace(dragvoldt,dragvoll). 
synplace(dragvollen,dragvoll). 
synplace(dragvoo,dragvoll). 
synplace(dragwall,dragvoll). 
synplace(dravold,dragvoll). 
synplace(drettsanlegget,idrettsplass).  %%?
synplace(drgate,dronningens_gate). 
synplace(drgt,dronningens_gate). 
synplace(dron,dronningens).  %%//WYWIWYR Whatyouwriteiswhatyou(haveto)read
synplace(droningata,dronningens_gate). 
synplace(droningen,dronningens). 
synplace(droninggata,dronningens_gate). 
synplace(droningsgata,dronningens_gate). 
synplace(dronn,dronningens). 
synplace(dronninegt,dronningens_gate).  %%
synplace(dronningensgate,dronningens_gate). 
synplace(dronningensgt,dronningens_gate). 
synplace(dronninges,dronningens). 
synplace(dronningsgate,dronningens_gate). 
synplace(dronningsgate,dronningens_street).  %%dronningsgate40?"
synplace(dronningsgaten,dronningens_gate). 
synplace(dronningt,dronningens_gate). 
synplace(dronnsingsgate,dronningens_gate). 
synplace(dråningensgate,dronningens_gate).  
synplace(dubedalsveien,dybdahls_veg). 
synplace(dvalentinlyst,valentinlyst). 
synplace(dvoll,dragvoll). 

synplace(dybdahls,dybdals).  %%allow station to domninate
synplace(dybdalsv,dybdahls_veg).  %%
synplace(dybdalvegen,dybdahls_street).  %%
synplace(dybdalveien,dybdahls_street).  %% <----h
synplace(dybdalveien,dybdahls_veg). 
synplace(dybdedalsvei,dybdahls_veg). 
synplace(dybedalsveien,dybdahls_veg). 
synplace(dybendal,dybdals). 
synplace(dybendals,dybdals). 
synplace(dybendalsgate,dybdahls_veg). 
synplace(dybvika,djupvika). 
synplace(dypedalsveien,dybdahls_veg). 
synplace(dypvika,djupvika). 
synplace(dødensdal,høgskoleringen).  
synplace(ebergskole,'Eberg skole'). 
synplace(ebrochs,brochs). 
synplace(ehimdal,heimdal). 
synplace(einar_tambarsjelves_gt,einar_tambarskjelves_gate). 

synplace(einartambarsjelves,einar_tambarskjelves_gate). %% <-- ?? 
synplace(einartambarskjelvensgate,einar_tambarskjelves_gate).
synplace(einartambarskjelvesgate,einar_tambarskjelves_gate). 
synplace(einartambarskjelvesgt,einar_tambarskjelves_gate). 
synplace(einartambarskjelvsgate,einar_tambarskjelves_gate). 
synplace(einartamberskjelvs,einar_tambarskjelves_gate). 
synplace(einartamerskjelvs,einar_tambarskjelves_gate). 

synplace(ekraftverket,e_verket). 
synplace(ekspedisjonen,servicekontoret). 
synplace(elgeset,elgeseter). 
synplace(elgseretgate,elgesetergate). 
synplace(elgsetergate,elgeseter_street). 
synplace(elset,elgeseter).  %%?
synplace(elseter,elgeseter). 
synplace(engebrektsons,engelbrektssons). 
synplace(engelbektson,engelbrektssons). 
synplace(engelbr,engelbrektssons). 
synplace(engelbregtson,engelbrektssons). 
synplace(engelbregtsons,engelbrektssons). 
synplace(engelbrekson,engelbrektssons). 
synplace(engelbrektsons,engelbrektssons). 
synplace(engelbretsons,engelbrektssons).  %%ssons
synplace(engelbrikstons,engelbrektssons). 
synplace(engelsåsen,engelsås_street). 
synplace(enrumveien,enerom_street). 
synplace(erlinghøviksvei,erling_høviks_street). 
synplace(esp,esp_meieri). 
synplace(estnestadveien,estenstadveien).  %%NOT synplaceandspellcor
synplace(fagerheimalle,fagerheim_alle).  %%automatic %%
synplace(fagerheimallee,fagerheim_alle). 
synplace(fagerli,fagerliveien).  %%redundant
synplace(fagerlibakken,fagerliveien).  %%?
synplace(falgård,dalgård). 
synplace(falkbergsvei,johan_falkbergets_vei). %
%% synplace(fengsel,tunga_kretsfengsel). %% YA-080526
synplace(ferstads_street,nedre_ferstad_street).  
synplace(ferstadsvei,nedre_ferstad_street). 
synplace(festning,festningen). 
synplace(festningata,festningsgata). 
synplace(festningensgaten,festningsgata). 
synplace(festningensgt,festningsgata). 
synplace(fiolinbuen,fiolsvingen). 
synplace(fiolinsvingen,fiolsvingen). 
synplace(fiolkrysset,fiolsvingen).  
synplace(fiolsv,fiolsvingen). 
synplace(fiolvei,fiolsvingen). 
synplace(fiolveien,fiolsvingen). 
synplace(firterminalen,pirbadet).  
synplace(fjellheim,bergheim).  %%?
synplace(fjellseter,fjellsæter). 
synplace(fjordsvingen,fiolsvingen).  %%fjol

synplace(fjosli,fjøslia). 

synplace(flak,flakk). 

synplace(flatssentere,flatåsen_senter). 
synplace(flatås,flatåsen). 
synplace(flatåsensentrum,flatåsen_senter). 
synplace(flatåsenter,flatåsen_senter). 
synplace(flatåsentere,flatåsen_senter). 
synplace(flatåssenter,flatåsen_senter). 
synplace(flatåssentre,flatåsen_senter). 
synplace(flatåssentrum,flatåsen_senter). 
synplace(flybussholdeplass,flybussterminalen). 
synplace(flybussholdeplassen,flybussterminalen). 
synplace(flybussstasjon,flybussterminalen). 
synplace(flybusstasjon,flybussterminalen). 
synplace(flybusstermial,flybussterminalen). 
synplace(flybussterminal,flybussterminalen). 
synplace(flybusstopp,flybussterminalen). 
synplace(flåtasen,flatåsen). 
synplace(flåtasveg,øvre_flatåsveg). 
synplace(fløshaugen,gløshaugen). 
synplace(folketmuseet,folkemuseum). 
synplace(fossestua,fossestu_street).  %%
synplace(fossestua,fossestuv).
synplace(fossestuen,fossestuv).
synplace(fosseutvegen,fossestuvegen).   %% RS-150111
synplace(fragvoll,dragvoll). 
synplace(fremstad,fjermstads). 
synplace(fremstads,fjermstads). 

synplace(frostadveien,frosta_street). %% \+ ferstadveien

synplace(fønningsbakken,rønningsbakken). 
synplace(gadenwist,stjørdals_street).  %%!stjørdals_streetNOT station!
synplace(gamlekongevei,gamle_konge_street). 
synplace(gamleåsvei,gamle_ås_street). 
synplace(gamleåsveien,gamle_ås_street). 
synplace(gardermoens,gardemoens). 
synplace(gartneriet,gartnerhallen). 

synplace(generalvibesvei,general_wibes_street). 

synplace(gerg,berg). 
synplace(ghaugen,gløshaugen). 
synplace(ghøs,gløshaugen).  %%slip
synplace(gildheimen,gildheim). 
synplace(gjaøshaugen,gløshaugen).  
synplace(gjernbanestasjon,jernbanestasjon). 
synplace(gjernbanestasjonen,jernbanestasjonen). 

synplace(gjødselhaugen,gløshaugen).  %% :-)
synplace(gjøs,gløshaugen). 
synplace(gkls,gløshaugen).  %% dbl neib
synplace(gkøs,gløshaugen). 
synplace(glas,gløshaugen).  %% :-) 
synplace(glis,gløshaugen).  %% :-) 
synplace(gløa,gløshaugen). 
synplace('gla|s',gløshaugen).  %% glÃ¦s  %% =<5  
synplace('gla¦s',gløshaugen).  %% 

synplace(glashagen,gløshaugen). 
synplace(glashogan,gløshaugen).
synplace(glashogen,gløshaugen).
synplace(glashogenan,gløshaugen).
synplace(glashougen,gløshaugen). 
synplace(glashuagen,gløshaugen).
synplace(glashuange,gløshaugen).
synplace(glashøgen,gløshaugen). 

synplace(glauhogen,gløshaugen). 
synplace(glauhogene,gløshaugen). 
synplace(glaushagen,gløshaugen). 
synplace(glaushaugen,gløshaugen). 
synplace(glaushogen,gløshaugen). 
synplace(glaushøgen,gløshaugen). 
synplace(glaøs,gløshaugen).       %% glÃ¸s  Ø-trøbbel
synplace(glaøsgaugen,gløshaugen).
synplace(glaøshaugne,gløshaugen). %% glÃ¸shaugne 
synplace(glhaugen,gløshaugen).  
synplace(glodhaugen,gløshaugen). 
synplace(gloes,gløshaugen). 
synplace(gloeshaugen,gløshaugen). 
synplace(glohaugen,gløshaugen). %% langlohaugen?
synplace(glohogen,gløshaugen). 
synplace(glos,gløshaugen). 
synplace(glosaugen,gløshaugen).  
synplace(glosh,gløshaugen). 
synplace(gloshagen,gløshaugen).  
synplace(gloshauegn,gløshaugen). 
synplace(gloshaug,gløshaugen). 
synplace(gloshaugen,gløshaugen). 
synplace(gloshauen,gløshaugen). 
synplace(gloshogen,gløshaugen). 
synplace(gloshougen,gløshaugen). 
synplace(gloshugen,gløshaugen). 
synplace(gloushagen,gløshaugen).
%% synplace(gls,gløshaugen).  %% limit 
synplace(glsø,gløshaugen). 
synplace(glsøaughne,gløshaugen).
synplace(glæs,gløshaugen). 

synplace(glød,gløshaugen). 
synplace(gløeshaugen,gløshaugen). 
synplace(gløos,gløshaugen). 
synplace(gløs,gløshaugen). % \+ glis/gls/
synplace(gløsh,gløshaugen). 
synplace(gløsha,gløshaugen).
synplace(gløshagen,gløshaugen). 

synplace(gløshaugane,gløshaugen). 
%%synplace(gløshaugennord,gløshaugen_nord). %% RS-2019.09.25 
%synplace(gløshaugensyd,gløshaugen). 
%synplace(gløshaugensør,gløshaugen). 
synplace(gløshaun,gløshaugen). 
synplace(gløshogen,gløshaugen). 
synplace(gløshuagne,gløshaugen). 
synplace(gløshævven,gløshaugen). 
synplace(gløshgen,gløshaugen).
synplace(gløshøyen,gløshaugen). 
synplace(gløsnord,gløshaugen_nord). 
synplace(gløss,gløshaugen). 
synplace(gløsshaggen,gløshaugen). 
synplace(gløst,gløshaugen). 
synplace(glåøs,gløshaugen).  %% GlÃ¸s
synplace(glås,gløshaugen).  

synplace(godsnsb,terminalen). 
synplace(graaemølla,graaemølna).  
synplace(graakaillbanen,gråkallbanen). 
synplace(graakalbanen,gråkallbanen). 
synplace(graakallen,gråkallen). 
synplace(graakollen,gråkallen). 
synplace(graemølne,graaemølna). 
synplace(gragvoll,dragvoll). 
synplace(granaasen,granåsen). 
synplace(granasen,granåsen).  %% doesnt help for partnames 
synplace(granåsenanlegget,granåsen_vm_anlegget). 
synplace(granåsengård,granåsen_gård). 
synplace(granåsens,granåsen). %% granÃ¥sens skole?  *sivilforsvarets skole, granåsen
             
synplace(grevkott,grevskotts).  
synplace(grevsgott,grevskotts).
synplace(grevsk,grevskotts). 
synplace(grevskot,grevskott). 
synplace(grevskot,grevskotts).  
synplace(grevskots,grevskotts). 
synplace(grevskottsvei,anton_grevskotts_vei).  
synplace(grevstokk,grevskott). 
synplace(grevstokks,grevskotts). 
synplace(grevstokksvei,grevskotts_vei). 

synplace(grilstadheia,grilstadkleiva).  %% ? 
synplace(grushaugen,gløshaugen).  %%  :-)

synplace(graønnlnd,grønnland). %% avoid grønlia %% TA-101118

synplace(grønnlien,grønnlia). %% \+ granlia %% amble#
synplace(gråkaillbanen,gråkallbanen). %% not stat/neib
synplace(gråkalen,gråkallen). 
synplace(gråkall,gråkallen). 
synplace(gråkolen,gråkallen). 
synplace(gråmølla,graaemølna). 
synplace(gråmøllen,graaemølna). 
synplace(grånemølna,graaemølna). 
synplace(guenget,buenget). 
synplace(gulashogan,gløshaugen). 
synplace(gyda,gina). % krog 
synplace(gøls,gløshaugen). 
synplace(gølshaguen,gløshaugen). 
synplace(gøs,gløshaugen). 

synplace(haakon,håkon).  %%OK,norecursion
synplace(haakon7gt,haakon_vii_gate_25). 
synplace(haakonviigt,haakon_vii_gate_25). 
synplace(haarfagres,hårfagres). 
synplace(hagnesvingen,haugnessvingen). %% naer miss

synplace(hakobsli,jakobsli). 
synplace(hallfredhøyemsvei,hallfred_høyems_vei). 
synplace(halseth,halset). 

synplace(hansfinnesgt,hans_finnes_street). 
synplace(hanskebakken,hanskemakerbakken). 
synplace(hanskemakerveien,hanskemakerbakken). 
synplace(hansmakerbakken,hanskemakerbakken). 
%synplace(haraldbothnersvei,harald_bothners_veg). 
synplace(haraldhårfagresgate,harald_hårfagres_street).  
synplace(haraldhårfagresgt,harald_hårfagres_street).  
synplace(haraldhårfagresvei,harald_hårfagres_street).  
synplace(hasselvika,hasselbakken). 
synplace(haugnessveien,haugnessvingen). 
synplace(haugnesveien,haugnessvingen). 
synplace(haukås,haukåsen). 
synplace(haulowbakken,thaulowbakken). 
synplace(havnegata,pirbadet).   %%???(case)
synplace(havstads,havstadsenteret).  %%destroys havstadsenteret?
synplace(havstadsenter,havstadsenteret). 
synplace(havstadtunet,havstadsenteret). 
synplace(havstasenter,havstadsenteret). 
synplace(haøgskoleparken,høyskoleparken). %%  høgskoleparken?

synplace(hofstads,ofstads). %%  ingeborg nohelp
synplace(hogskoleparken,høyskoleparken). 

synplace(haøyskoleparken,høyskoleparken). %%   Nec 

synplace(heimdalsbyen,heimdal_stasjon). 
synplace(heimdalsentralstasjon,heimdal_stasjon). 
synplace(heimdalst,heimdal_stasjon). 
synplace(helhus,melhus). 
synplace(hembres,hambros). %% TA-101111
synplace(hemidla,heimdal). 
synplace(hemnskjell,hemnskjel). 
synplace(henry,henrik). 

synplace(herløfs,herlofsons) . %% ? 

synplace(herlofsenløypa,herlofsonsløypa). 
synplace(hestehaven,hesthagen). 
synplace(hesthaven,hesthagen). 
%% synplace(himmelen,værnes).  %% -> airplane 
synplace(himmelportalen,perleporten). 
synplace(hjelstrupsvei,christian_jelstrups_v).  %%
synplace(hjernbanen,ts). %% AtB. 
synplace(hjernbanestasjon,ts). %% AtB. 
synplace(hjørtlerveien,gjørtler_street). 
synplace(hoegga,hoeggen). 
synplace(hoeggenskole,hoeggen_skole). 
synplace(hogskolering,høgskoleringen). 
synplace(hogskøleringen,høyskoleringen). 
synplace(hogskølringen,høyskoleringen). 
synplace(hoholt,moholt). %parasitictypo
synplace(hoieflata,koieflata).  
synplace(holocks,hørløcks). 
synplace(holtemansv,holtermanns_street). 
synplace(holtemansveien,holtermansveien). 
synplace(holtermanveg,holtermanns_street).  %%HMV17
synplace(horlocks,hørløcks). 
synplace(hornbergvegen,hornebergveien).  %%
synplace(hornbergvegen,hornebergveien).  %%Thestreet
synplace(hornbergveien,hornebergveien).  %%
synplace(hornbergveien,hornebergveien).  %%Thestation
synplace(hornberveien,hornbergveien). 
synplace(hornebergvegen,hornebergveien).  %%
synplace(hornebergveien,hornebergveien).  %%
synplace(hornebyvegen,hornebergveien).  %%
synplace(hornebyveien,hornebergveien).  %% ?
synplace(hornæs,thornæs). 
synplace(hosp,hospital). 
%% synplace(hospital,regionsykehuset).  %% (anglicism) 
synplace(hospitalskyrkan,hospitalskirka). 
synplace(hospitalsløkkan,hospitalløkkan). 
synplace(hostipalløkka,hospitalløkkan). 
synplace(hostipalsløkka,hospitalløkkan). 
synplace(hotrelmannsvei,holtermanns_street). 
synplace(hovebergveien,hornbergveien). 
synplace(hovedbanestasjonen,ts). %% AtB.  
synplace(hovedjernbanestasjon,ts). %% AtB. 
synplace(hovedpostterimalen,postterminalen).  %% ?
synplace(hovedstasjon,ts). %% AtB. 
synplace(hsopitalløkkan,hospitalløkkan). 
synplace(hsopitalløkkan,hospitalløkkan). 
synplace(ht,hovedterminalen).  %%hovedterminalen?
synplace(hurloks,hørløcks). 
synplace(humlehaugen,humlehaug_street).  
synplace(hundhamaren,hundhammeren). 
synplace(hunnhammern,hunhammeren). 

synplace(husdaytunet,husebytunet).  %%  dbl sms feil %%?
%% synplace(huseby,husebytunet). 
synplace(husebyhalle,husebyhallen). 
synplace(husebytun,husebytunet). 

synplace(hvaløyv,valøyvegen). 
synplace(hvaløyveien,valøyvegen). 
synplace(hvilhaugen,kvilhaugen). 
synplace(håkon,haakon).  %% OK, no recursion
synplace(hårstadreina,hårstad). 
synplace(hægstadmoen,heggstadmoen). 
synplace(høglieveien,høili_street).  
synplace(høgskolebakken,høyskoleringen). 
synplace(høgskolering,høgskoleringen). 
synplace(høgskolring,høyskoleringen). 
synplace(høgskoleringens,høyskoleringens). %% allow høgskoleringens adresse 
                                         
synplace(haørlocksvei,hørløcks_street). %% TA-101123
synplace(høili,høili_street).  %%
synplace(høiskole,høgskole). 
synplace(høiskolen,høgskolen). 
synplace(hølock,hørløcks). 
synplace(hørlocs,hørløcks). 
synplace(hørløc,hørløcks). 

synplace(høyskolring,høyskoleringen). 
synplace(høysteh,høiset). 
synplace(ia,ila). 
synplace(iade,lade). 
synplace(iademoen,lademoen). 
synplace(iansensvei,lanssens_street).  %%<--helps
synplace(ianssens,janssens). 
synplace(iddretsanlegg,idrettsanlegg). 
synplace(idr,idrettsplass). 
synplace(idrattsenter,idrettsbygg). 
synplace(idretsanlegg,idrettsanlegg). 
synplace(idretsplas,idrettsplass).  %%Ranheim
synplace(idrettbygg,idrettsbygg). 
synplace(idrettsanleg,idrettsbygg). 
synplace(idrettsanlegg,idrettsbygg). 
synplace(idrettsanlegg,idrettsplass). 
synplace(idrettsanlegget,jakobsli_idrettsplass). 
synplace(idretsbanen,idrettsbygget). %% RS-150913 Typo 
synplace(idrettsbanen,idrettsbygget). 
synplace(idrettsbygg,idrettssenter). 
synplace(idrettsbygningen,idrettsbygget). 
synplace(idrettsenter,idrettssenter). 
synplace(idrettsp,jakobsli_idrettsplass). 
synplace(idrettspark,idrettplass). 
synplace(idrettspl,jakobsli_idrettsplass).  %% Heter Idrettsplassen i ruteheftet/stasjonsskiltet ? RS-190101
synplace(idrettssenter,idrettsbygg). 
synplace(idrettssenter,idrettsbygg). 
synplace(idrettssenteret,idrettsbygget). 
synplace(idrettssentret,idrettsbygget). 
synplace(ihla,ila). 
%% synplace(ika,ikea).    %% ica?
%% synplace(ike,ikea).    %% ikke
synplace(ikae,ikea).  %% %typo
synplace(ilakirka,ila). 
synplace(ilakrysset,ila). 
synplace(ilas,ila). 
synplace(ile,ila). 
synplace(ilen,ila). 
synplace(illa,ila). 
synplace(iloa,ila). 
synplace(ils,ila).   
synplace(ilsøra,ila). 
synplace(ilta,ila). 
synplace(indusrvegen,industri_street).  
synplace(indæretsveien,innherredsveien). 
synplace(ing,ingemann). 
synplace(ingeborgofstadsvei,ingeborg_ofstads_vei). 
synplace(ingenmanns,ingeman). %% torpsv  
synplace(ingenmannstorpsvei,ingemann_torps_vei). 
synplace(ingrid,ingeborg).  %% ofstad (or just use I.)
synplace(ingv,ingvald). 
synplace(ingvars,ingvar). 
synplace(inherraveien,inherredsveien). 
synplace(inherred,innherredsveien).  %%
synplace(inneherredsvegen,innherredsveien). 

synplace(innherdsveien,innherredsveien). 
synplace(innherdsveien,innherreds_street).   %% Touchy
synplace(innheredsveien,innherreds_street).  %% Touchy

synplace(innherred,innherredsveien).  %% ?
synplace(iskremfab,iskremfabrikken). 
synplace(iskremfabr,iskremfabrikken). 
synplace(istgårds,ystgård). 
synplace(it_bygget,itbygget).  %% if applicable
synplace(iugla,ugla). 
synplace(jacbsli,jakobsli). 
synplace(jacoblsli,jakobsli). 
synplace(jacobsgrend,jakobsli).  %%
synplace(jacobsligrend,jakobsli). 
synplace(jacobsligrenda,jakobsli). 
synplace(jacokbsli,jakobsli). 
synplace(jacoksli,jakobsli).
synplace(jaconsli,jakobsli). 
synplace(jacosli,jakobsli). 
synplace(jade,lade).    
synplace(jadejarlen,ladejarlen).
synplace(jakobli,jakobsli).  
synplace(jakobslien,jakobsli).    %% (NB jakobslien syndrom)
synplace(jakobsligrend,jakobsli). 
synplace(jakobsligrenda,jakobsli). 
synplace(jakobsliidrettsplassen,jakobsli_idrettsplass). 

synplace(jakobsliveiennedre,jakobsliveien_nedre). %% vn 

synplace(jakobslivegen,jakobsliveien). %% nec diff names station/street
synplace(jakobsliveien,jakobslivegen).
synplace(jalsteingård,halstein_gård). 
synplace(jaobsli,jakobsli).  %%
synplace(jarlsveien,jarleveien).  %% Collides Håkon Jarls gate
synplace(jarnebanen,jernbanen). 
synplace(jebes,jeve).  %% jebes gate -> jebeveien %% <4
synplace(jeimdal,heimdal). 
synplace(jeldsrup,jelstrup). 
synplace(jerbanest,ts). %% AtB. 
synplace(jernbabanen,jernbanestasjonen). %% sp 
synplace(jernbanen,jernbanestasjonen). 
synplace(jernbanest,ts). %% AtB. 
synplace(jernbanestasj,jernbanestasjonen).
synplace(jernbanestasjon,jernbanestasjonen). 
synplace(jernbastasjonen,ts). %% AtB. 
synplace(jnyborg,nyborg).  %% ?
synplace(joakosbli,jakobsli). 
synplace(jobsli,jakobsli). 
synplace(jocobsli,jakobsli). 
synplace(joh,john).  %%Joh Skaarvoldsv
synplace(johanfalkbergetsveg,johan_falkbergets_vei). 
synplace(johanfalkbergetsvei,johan_falkbergets_vei). 
synplace(johanfalkebergetsveg,johan_falkbergets_vei). %% ? 
synplace(johansen,johnsen). 
synplace(johanvannsveien,jonsvannsveien). 
synplace(john,johan). 
synplace(johnssons,jonssons). 
synplace(johnssonsvei,karl_jonssons_veg).

%% synplace(johnsvannet,jonsvatnet).  %% TA-110202
synplace(johnsvatnet,   jonsvannet).  %%
synplace(johnsvattenet, jonsvannet).  %%
synplace(jonnsvatnet,   jonsvannet).  %%
synplace(jonsvann,      jonsvannet).  %%
synplace(jonsvatn,      jonsvannet).  %%

synplace(joieflata,koieflata). 
synplace(jokabsli,jakobsli). 

synplace(jonnsvansveikrysset,jonsvannsveikrysset).  %% unnec

synplace(jonsdalsveien,jonsvannsveien). 

synplace(jonsvansveikrysset,jonsvannsveikrysset).   %% unnec

synplace(jonsvatnveien,jonsvannsveien).  %% (etc)

synplace(jskobli,jakobsli). 

synplace(k1,kongens_gate_k1). %% RS-130812
synplace(k2,kongens_gate_k2).
synplace(k_johnssonsveg,karl_jonssons_veg).  %% RS-120805 Space? 
synplace(kade,lade). 
synplace(kadehammeren,ladehammeren).  %%?
synplace(kaien,pirbadet).
synplace(kakobsli,jakobsli). 
synplace(kapell,kirke). 
synplace(kasperlundesgate,casper_lundes_veg). 
synplace(kasperlundesv,casper_lundes_veg). 
synplace(kasperlundesv,casper_lundes_veg). 
synplace(kasperlundesvei,casper_lundes_veg). 
synplace(katemsenter,kattemsenteret). 
synplace(katta,katedralskolen). 
synplace(kattemsenter,kattemsenteret).  %%
synplace(kattemsentre,kattemsenteret). 
synplace(katten,kattem).  %% (shadowed by "cat" )
synplace(kattæmsentret,kattemsenteret). 
synplace(kb,kbs). %% ?
%% synplace(kinoen,kino).  %%subtle, u n d e r specified
%% synplace(kinoene,kino). %% cinema 
synplace(kinos,kinosenter). 
synplace(kjerka,kirken). 
synplace(kjøpesenter,senter). 
synplace(klabu,klæbu).  %%-kabul
synplace(klaebu,klæbu). 
synplace(klaeburuta,klæburuten). 
synplace(klaebuveien,klæbu_street). 
synplace(klaebuveien,klæbuveien). 
synplace(kleet,klett). 
synplace(klet,klett).  
synplace(klefstadhaug,klefstadhaugen). 
synplace(kleisgate,kleists_street). 
synplace(klestaghaugen,klefstadhaugen). 
synplace(klettkrysset,klett). 
synplace(klivhaugen,kvilhaugen).  %% only neib key swap
synplace(klokkergården,klokkerplassen). 
synplace(klokkerpl,klokkerplassen). 
synplace(klostergt,klostergata).
synplace(klæbu,klæbu_sentrum).  %% AtB %% RS-150823 
synplace(klæburute,klæburuten). 
synplace(klæburuten,klæburuten). 
synplace(klæbuveien,klæbuvveien).  %%Databaseerror
synplace(klæfstahaugen,klefstadhaugen). 
synplace(klæt,klett). 
synplace(klætt,klett).
synplace(knudzonsgt,knudssøns_street). 
synplace(koeflat,koieflata). 
synplace(koieflaten,koieflata). 
synplace(kolstadtoppen,kolstadhaugen).
synplace(kolsåslia,kolsåsdalen).
synplace(komunesenter,kommunesenter). 
synplace(komunesenteret,kommunesenter). 

synplace(knggate,kongens_gate). 
synplace(knggt,kongens_gate). 
synplace(kong,kongens).  %%//WYWIWYR Whatyouwriteiswhatyou(haveto)read
synplace(kongata,kongens_gate). 
synplace(kongen,kongens). 
synplace(konggata,kongens_gate). 
synplace(kongsgata,kongens_gate). 
synplace(konn,kongens). 
synplace(konngt,kongens_gate).  %%
synplace(kongensgate,kongens_gate). 
synplace(kongensgt,kongens_gate). 
synplace(konnges,kongens). 
synplace(kongsgate,kongens_gate). 
synplace(konngsgate,kongens_street).  %%dronningsgate40?"
synplace(konngsgaten,kongens_gate). 
synplace(konngt,kongens_gate). 
synplace(konnsgsgate,kongens_gate). 
synplace(kångensgate,kongens_gate).  

synplace(kongevegen,kongsvegen). 
synplace(kongleien,kongleveien).  
synplace(koppan,kroppan). 
synplace(kopparmarka,kroppanmarka). 
synplace(koppermarka,kroppanmarka). 
synplace(korppamarka,kroppanmarka). 
synplace(korppanmrka,kroppanmarka). 
synplace(kps,kbs). 
synplace(kretsfengsel,tunga_kretsfengsel). 
synplace(krigshøyskolen,luftkrigsskolen). 
synplace(krigsskolen,luftkrigsskolen). 
synplace(kristian,christian).  %%Didithelp???
synplace(krmarka,kroppanmarka). 
synplace(krogruds,kroglunds). 
synplace(krogs,kroghs).  %%//Doesn'thelp
synplace(kroksti,krokstien). 
synplace(kropanmarke,kroppanmarka). 

synplace(kroppanm,kroppanmarka). 
synplace(kroppama,kroppanmarka).  %%otherwise kropanm partname
%% synplace(kroppanm,kroppanmarka_snuplass). 

synplace(kroppanma,kroppanmarka). 
synplace(kroppanmarke,kroppanmarka). 
synplace(kroppanmarken,kroppanmarka). 
synplace(ksb,kbs). 
synplace(ktv,kvt). 
synplace(kulsaas,kolsås). 
synplace(kullsås,kolsås). 
synplace(kundåsen,lundåsen_n). 
synplace(kvamshaug,kvamshaugen). 
synplace(kvannhaugen,kvamshaugen). 
synplace(kvannshaugen,kvamshaugen). 
synplace(kvilhagne,kvilhaugen). 
synplace(kvilhaugengård,kvilhaugen). 
synplace(kvilhøgden,kvilhaugen). 
synplace(kysstasjon,skysstasjon). 
synplace(kyststad,kystad). 
synplace(kyvann,kyvatnet). 
synplace(kyvannet,kyvatnet).  %% (No help really,see comment)
synplace(kyvatn,kyvatnet). 
synplace(kågleveien,kongleveien). 
synplace(kålsta,kolstad). 
synplace(kålstad,kolstad). 
synplace(kæbu,klæbu). 
synplace(køpmansgata,kjøpmanns_street). 
synplace(lad,lade). 
synplace(lada,lade). 
synplace(ladd,lade).  
synplace(ladealle,lade_alle_80). 
synplace(ladecity,lade_idrettsanlegg). 
synplace(ladehalvøya,lade). 
synplace(ladejarlen,ladejarlen_v_g_s).
synplace(ladejarlenvgs,ladejarlen_v_g_s). 
synplace(ladejarlenvideregående,ladejarlen_v_g_s). 
synplace(ladekirka,lade_gård). 
synplace(ladekirke,lade_gård). 
synplace(lademoens,lademoen).  %%kirkealle
synplace(laden,lade).
synplace(ladeområdet,lade). 
synplace(ladf,lade). 
synplace(ladr,lade). 
synplace(laed,lade). 
synplace(lafe,lade). 
synplace(ladw,lade). 
synplace(lalentinlyst,valentinlyst).  %%Contag
synplace(lamoen,lademoen). 
synplace(lamon,lademoen). 
synplace(lande,lade). %% ?
synplace(langrennstadion,langrennsstadion). 
synplace(lase,lade).
synplace(lattem,kattem). %% 1. 
synplace(lautenhavnen,leuthenhaven). 
synplace(lde,lade). 
synplace(lderdalen,olderdalen). 
synplace(leangenbanen,leangen). 
synplace(lede,lade). 
synplace(leitagrenda,leistadgrenda). 
synplace(leiv,leif). 

synplace(lekerdal,lerkendal). 
synplace(lekrdal,lerkendal). 
synplace(lekredal,lerkendal). 
synplace(lekredal,lerkendal). 
synplace(lerchendal,lerkendal_gård).  %% NB lerch, ikke same/cmpl
synplace(lerkdal,lerkendal). 
synplace(lerkedalstudentby,prestegårdsjordet). 
synplace(lerkedel,lerkendal). 
synplace(lerkend,lerkendal). 
synplace(lerkendalområdet,lerkendal). 
synplace(lerkendalsområdet,lerkendal). 
synplace(lerkendalst,lerkendal_stadion). 
synplace(lerkendalstadium,lerkendal_stadion). 
synplace(lerkendalstudentby,prestegårdsjordet). 
synplace(lerkendalsveien,lerkendalsvegen). 
synplace(lerkenstad,lerkendal). 

synplace(leuthenhaven,leuthenhaven). 
% synplace(levang,levanger). %% another place ? 
synplace(levange,levanger).  %%not Leangen(Levangesyndrom)
synplace(leythenhaven,leuthenhaven). 
synplace(liam,lian). 
synplace(lide,lade).  %%?
synplace(lien,lian). 
synplace(lila,ila).  %% ? til_lila
synplace(lillebyen,lilleby). 
synplace(lilleryrydningen,lillerydningen). 
synplace(lla,ila). 
synplace(loavs,olavs). %% own sp
synplace(loltbakken,loholtbakken). 
synplace(lovhovet,lohove).
synplace(lroppanmarka,kroppanmarka). 
synplace(lsdamveien,isdamveien). 
%% synplace(lsentrum,sentrum).  %% fra moltmyra ti lsentrum? \+ Moltmyra 10 
synplace(lufthavnværnes,trondheim_lufthavn_lufthavnveien). 
synplace(luftkrigenskole,luftkrigsskolen). 
synplace(lund,lundes). 

synplace(lundaasen,lundåsen_n). 

synplace(lunderåsen,lundåsen_n). % NB også foreign 

synplace(lundemobk,lundemobakken). 
synplace(lundåawn,lundåsen_n).  %%dblneib
synplace(luthenhaven,leuthenhaven). 
synplace(lykkensportal,bybro). 
synplace(lykkesv,ivar_lykkes_street).  %%Lastnameoption
synplace(lysholmsv,jørgen_b_lysholms_vei). 
synplace(lysholms_vei,jørgen_b_lysholms_vei). 
synplace(lythenhaven,leuthenhaven). 
synplace(lærekendal,lerkendal). 
synplace(løshaugen,gløshaugen). %typo
synplace(løvaasen,løvaasveien). 
synplace(løvaasvegen,løvaasveien). 
synplace(løvaasveien,løvaasveien). 
synplace(løvåsen,løvaasveien). 
synplace(løvåsvegen,løvaasveien). 
synplace(løvåsveien,løvaasveien).  %% Prefer station
synplace(løytenhaven,leuthenhaven). 
synplace(løytnanthagen,leuthenhaven). 

%synplace(m0,hovedterminalen). 
%synplace(m1,munkegata_m1).  %%
%synplace(m2,munkegata_m2).  %%
%synplace(m3,munkegata_m3).  %%
%synplace(m4,munkegata_m4).  %%
%synplace(m5,munkegata_m5).  %%

synplace(magnusblindes,magnusblindes). 
synplace(malhus,melhus). 
synplace(malkvik,malvik). 
synplace(mardo,nardo). 
synplace(mardosenter,nardosenteret). 
synplace(mardosenteret,nardosenteret). 
synplace(marienberg,marienborg).  %% ? (\+marienbergveien)
synplace(marienborg,marienborg_stasjon).  %% ? (\+marienbergveien)
synplace(marienenborg,marienborg). %% amble# doesn't make it
synplace(marienlyst,marienborg).  %% ?Oslo?
synplace(mariesørdalsv,marie_sørdals_veg). 
synplace(mariesørdalsvei,marie_sørdals_veg). 
synplace(maskinistborgen,maskinistboligene). 
synplace(maskinboligene,maskinistboligene). 
synplace(maskiniststoppet,maskinistboligene). 
synplace(mattem,kattem).  %%  sic
synplace(mautirz,mauritz). 
synplace(mburan,buran). 
synplace(mdbyen,sentrum). 
synplace(meieri,meierier). 
synplace(meieriene,norske_meierier). 
synplace(meldalen,meldal). 
synplace(melhu,melhus). 
synplace(melhussentrum,melhus). 
synplace(mellhus,melhus). 
synplace(mellolima,mellomila). %% swap not neibs 
synplace(mellomlina,mellomila). 

synplace(mehus,melhus). 
synplace(meluhs,melhus). 
synplace(melus,melhus). 
synplace(meraker,meråker). 
synplace(mgata,munkegata). 
synplace(mgt,munkegata). 
synplace(michael,michel). 
synplace(midarvoll,nidarvoll). %% ? 
synplace(midtgen,midteggen). 
synplace(midtsandan,midtsanden). 
synplace(migo,hallset).   %% TA-100519
synplace(migosenter,hallset). 
synplace(migosentre,hallset). %% TA-101004
synplace(mikael,michel).  %% grendahlsvei Nøddef
synplace(minkegaten,munkegata). %% nec 
synplace(minsås,minsaas). 
synplace(mkgt,munkegata). 
synplace(moeggen,hoeggen). % ?
%% synplace(moh,moholt).   % ? 
synplace(moho,moholt).
synplace(mohoholt,moholt). %%  ?
synplace(moholstudentby,moholt_studentby). 
synplace(moholtalee,moholt). 
synplace(moholtallee,moholt). 
synplace(moholtstudent,moholt_studentby). 
synplace(mohotle,moholt). 
synplace(moirana,mo_i_rana). 
synplace(mokegata,munkegata). 
synplace(mokegate,munkegata). 
synplace(molholt,moholt).  %% Actually nec
synplace(molot,moholt). 
synplace(molt,moholt). 
synplace(moltmyraøst,moltmyra_øst). 
synplace(monkgata,munkegata). 
synplace(monkholmen,munkholmen). 
synplace(munkeholmen,munkholmen). 
synplace(monkvold,munkvoll). 
synplace(motolh,moholt). 
synplace(msolsiden,solsiden). 
synplace(muhult,moholt).  %%eng
synplace(mukegt,munkegata).  %% avoid munkegt + M2
synplace(mukgata,munkegata).  
synplace(mumlegata,munkegata).  %% doubl neib
synplace(mumlegaten,munkegata). 
synplace(mumlegava,munkegata).  %% ?-) 
synplace(mumlegt,munkegata).  %% Dbl neib sms
synplace(munchegata,munkegata). 
synplace(mungata,munkegata).  %% ikke sigurd munns v
synplace(mungegata,munkegata). 
synplace(mungejata,munkegata). 
synplace(mungekata,munkegata). 
synplace(mungt,munkegata). 
synplace(munk,munkegata). 
synplace(munkata,munkegata). 
synplace(munke,munkegata). 
synplace(munkeg,munkegata). 
synplace(munkega,munkegata). 
synplace(munkegat,munkegata). 
synplace(munkegate,munkegata). 
synplace(munkegaten,munkegata). 
synplace(munkege,munkegata). 
synplace(munkegsts,munkegata). 
synplace(munkegt,munkegata).  %% ( munkegtm1 )
synplace(munkegtr,munkegata). 
synplace(munkgt,munkegata). 
synplace(munkholmgata,munkegata). 
synplace(munkvokk,munkvoll). 
synplace(munkvollgård,munkvoll_gård). 
synplace(murens,ourens). 
synplace(murevik,muruvik). 
synplace(muruvika,muruvik). %% MW-121119
synplace(museet,museum). 
synplace(musikmuseum,museum). 
synplace(myen,byen). 
synplace(mølleballen,møllebakken). 
synplace(møllergate,møllebakken).  %% (?)
synplace(nado,nardo). 
synplace(nadrocentere,nardosenteret). 
synplace(nadrocentret,nardosenteret). 
synplace(nard,nardo). 
synplace(nardobrua,nardokrysset). 
synplace(nardokr,nardokrysset). 
synplace(nardoområdet,nardo). 
synplace(nardos,nardosenteret). 
synplace(nardosent,nardosenteret). 
synplace(nardosentereret,nardosenteret). 
synplace(nardøhallen,trondheim_spektrum). 
synplace(naro,nardo).  %%own
synplace(naskinagentur,maskinagentur). 
synplace(nedrebakklandet,bakkegata). 
synplace(nedreelvehanv,nedre_elvehavn). 
synplace(nedreflatåsen,søndre_flatåsen). 
%synplace(nedrehumlehaugen,nedre_humlehaugen_vest). %%RS-121024 3 nye på Ranheim fra 24.10.2012
synplace(nedrejakobsliveg,jakobsliveien_nedre). 
synplace(nedrejakobslivei,jakobsliveien_nedre). 
synplace(nedreleirfoss,nedre_leirfoss).  %% (automatic*)
synplace(nergårdsvei,nordgaardsvei). 
synplace(ngu,n_g_u). 
synplace(niarøhallen,trondheim_spektrum). 
synplace(nidarhalen,trondheim_spektrum). 
synplace(nidarhallen,trondheim_spektrum). 
synplace(nidrehallen,trondheim_spektrum). 
synplace(nilsens,nielsens).  %% Otto nilsens vei/Aksel nilsens vei
synplace(nnherredsveien,innherredsveien). 
synplace(noa,nova). 
synplace(noholdttun,moholttun). 
synplace(noholt,moholt). synplace(omholt,moholt). 
synplace(noll,voll). 
synplace(nordgårds,nordgaards). 
synplace(nordo,nardo). 
synplace(nordgårdsvei,nordgaardsvei). 
synplace(nordrehallset,nordre_halset). %% migosenteret). 
synplace(nordrehalset,nordre_halset). %% migosenteret). 



synplace(noreg,norge). 
synplace(norgårds,nordgaards). 
synplace(novakinosenter,olav_tryggvasons_gate_ot2). 
synplace(nove,olav_tryggvasons_gate_ot2). 
synplace(npva,olav_tryggvasons_gate_ot2). 
synplace(nrdo,nardo). 
synplace(nsb,ts). %% AtB.  %%(=tog?)
synplace(ntnt,ntnu). %%  sperr
synplace(ntnudragvoll,ntnu_dragvoll). 
synplace(nunkegata,munkegata). 
synplace(nunkvoll,munkvoll).  %% <
synplace(nuseum,museum).  %%OWNsp
synplace(nybakkeveien,nybakkveien). 
synplace(nybakkveien,nyveibakken). 
synplace(nybårdsveien,nygård_street). 
synplace(nydal,nydalen). 
synplace(nyenget,buenget).  %%Neib?
synplace(nygaardsvei,nygårds_vei). 
synplace(nygaardsvei,olav_nygårds_vei). 
synplace(nygården,nygård). 

%%%%%%%%%%%%%%%%  different names in/out synplace(nygårds,nygards).  %%street/station/misspellconfusion
%% TA-110803

synplace(nygårdsvei,nygårds_vei).  %%nec,alas
synplace(nygårdsvei,olav_nygårds_vei). 
synplace(nygårdsvolds,nygaardsvolds). 
synplace(nygårdsvoll,nygaardsvolds). 
synplace(nynu,ntnu).  
synplace(nyorg,nyborg). 
synplace(nyveibk,nyveibakken). 
synplace(nyåsen,byåsen). 
synplace(nåva,olav_tryggvasons_gate_ot2). 
synplace(oeveraas,øverås). 
synplace(ofstisv,øfstis_vei).  %%einarofstisv. 
synplace(okanger,orkanger).
synplace(oksda,okstad). 
synplace(ola,olaf). 
synplace(ola,olav). 
synplace(ola,ole). 
synplace(olaf,ola). 
synplace(olaf,olav). 
synplace(olaf,ole). 
synplace(olav,ola). 
synplace(olav,olaf). 
synplace(olav,olavs). 
synplace(olav,ole). 
synplace(olavnigardsvei,olav_nygårds_vei).   
synplace(olavnygaardsvei,olav_nygårds_vei). 
synplace(olavnygårdsvei,olav_nygårds_vei). 
synplace(olavnygrdsvei,olav_nygårds_vei).  

synplace(olavs,olav). 
synplace(olavtryggvasonsgt,olav_tryggvasons_gate_ot1). %% CORREC %% TA-101203 %% AtB
synplace(olavtrygvasonsgate,olav_tryggvasons_gate_ot1). %% CORREC %% TA-101203 %% AtB
synplace(olderdal,olderdalen). 
synplace(oldredal,olderdalen). 
synplace(ole,ola). 
synplace(ole,olaf). 
synplace(ole,olav). 
synplace(olovhospital,st_olavs_hospital). 
synplace(omkjøringsv,omkjøringsveien). 
synplace(omkjøringsveg,omkjøringsveien). %% generic TSX 
synplace(omkjøringsvei,omkjøringsveien). 
synplace(omkjaøringsvegen,omkjøringsveien). %% ø-trøbbel


synplace(oops,lade_idrettsanlegg). 
synplace(opland,oppland).  %%bus 10 skistua down
synplace(ops,lade_idrettsanlegg). 
synplace(orkander,orkanger).
synplace(orkangar,orkanger). 
%synplace(orkanger,orkanger_skole). %% RS-150823
synplace(orkanger,torget_orkanger). %% RS-150823
synplace(orkanger_torg,torget_orkanger).
synplace(osb,lade_idrettsanlegg).  %% (not spell # < 4)
synplace(ostersund,østersund). 
synplace(ostmarkveien,østmark_street). %% no spell 1. letter 
synplace(ostre,østre). 
synplace(otb,othilienborg). 
synplace(otelieborg,othilienborg). 
synplace(otelienborg,othilienborg). 
synplace(othb,othilienborg). 
synplace(othborg,othilienborg). 
synplace(othelieborg,othilienborg). 
synplace(othilb,othilienborg). 
synplace(othilienlenborg,othilienborg). 
synplace(othilielinborg,othilienborg).
synplace(otilinborg,othilienborg). 

synplace(othilenbor,othilienborg). 
synplace(othilenborg,othilienborg). 
synplace(othili,othilienborg). 
synplace(othilie,othilienborg). 
synplace(othilien,othilienborg). 
synplace(othilienb,othilienborg). 
synplace(othilienbo,othilienborg). 
synplace(othilienborg,othilienborg).  
synplace(othillenborg,othilienborg). 
synplace(othillhenborg,othilienborg). 
synplace(othillienborg,othilienborg). 
synplace(othillingborg,othilienborg). 
synplace(otilenburg,otilenburg). 
synplace(otillenborgveien,othilienborg_street). 
synplace(otillingborg,othilienborg). 
synplace(otlienborg,othilienborg). 
synplace(otliengborg,othilienborg). 
synplace(otthillienborg,othilienborg). 
synplace(ottilenburg,othilienborg). 
synplace(ottonielsensvei,otto_nielsens_veg). 
synplace(oya,øya). 
synplace(owesensgate,thonning_owesens_street).  %% $Generic

%synplace(p1,prinsens_gate_p1). %% RS-140102
%synplace(p2,prinsens_gate_p2). 

synplace(pedermorsetsv,peder_morsets_vei). 
synplace(pedermorsetsvei,peder_morsets_vei).
synplace(peppe,reppe). 
synplace(peraunetveien,persaun_street).  %%aun(Help?)
synplace(peraunetveien,persaunetveien). %% TA-110415 
synplace(peribadet,pirbadet). 

synplace(persaun,persaune). 
synplace(persaun,persaunet). %% Persaun leir %% TA-110519
synplace(persaunetleir,persaunet_leir). 
synplace(persaunetlier,persaunet_leir). 
synplace(persaunetv,persaun_street). 

synplace(persaunetvegen,persaunetveien). %% TA-110415
synplace(persaunetveien,persaunetveien). %% TA-110415
synplace(persaunevegen,persaunetveien).  %% TA-110415  
synplace(persauneveien,persaunetveien).  %% TA-110415

synplace(persautunet,persaunet). 
synplace(persetunet,persaunet). 
synplace(persuanevegen,persaun_street). 
synplace(persunet,persaunet). 
synplace(pier,pirbadet).  
synplace(pierbadet,pirbadet). 
synplace(pinsen,prinsen).  %%confusewhitsun
synplace(pir1,pirbadet).  
synplace(pir2,pirbadet).  
synplace(pirbad,pirbadet). 
synplace(pirbade,pirbadet). 
synplace(pirbated,pirbadet). 
synplace(pirbsdet,pirbadet). 
synplace(pirebadet,pirbadet). 
synplace(pirenbadet,pirbadet). 
synplace(piretbadet,pirbadet). 
synplace(pirhuset,pirbadet).  
synplace(pirii,pir_ii).  %%
synplace(pirkaia,pirbadet). 
synplace(pirn,pirsenteret). 
synplace(pirsent,pirsenteret). 
synplace(pirsenteteret,pirsenteret).
synplace(pirteminal,pirbadet). 
synplace(pirterimanlen,pirbadet).  
synplace(pirterm,pirbadet).  
synplace(pirtermenaln,pirbadet).  
synplace(pirtermianelen,pirbadet).  
synplace(pirtermianeltn,pirbadet).  
synplace(pirtermilane,pirbadet).  
synplace(pirtermin,pirbadet).  
synplace(pirterminal,pirbadet).  
synplace(piteminalen,pirbadet).   %%2spc
synplace(plantagen,plantasjen). 
synplace(plderdalen,olderdalen).  %% ?
synplace(pnsen,prinsen). 
synplace(politidistrikt,politihuset). 
synplace(politihus,politihuset).  
synplace(posten,postterminalen). 
synplace(postenterminalen,postterminalen). 
synplace(postterimalen,postterminalen). 
synplace(postterm,postterminalen). 

synplace(prbade,pirbadet). 
synplace(prbadet,pirbadet). 
synplace(prestegårdsbakken,prestegårdsjordet).  %%  ?
synplace(prestegårdsgjerdet,prestegårdsjordet). %%  ?
synplace(prestegårdsj,prestegårdsjordet). 
synplace(prestejordjordet,prestegårdsjordet). %% \+ dsj
synplace(presthuset,presthus_street). 
synplace(presthushagen,presthus_street).  
synplace(pribadet,pirbadet). 
synplace(prinsegate,prinsens_gate). 
synplace(prinsengata,prinsens_gate).  %% (actual)
synplace(prinsengate,prinsens_gate). 
synplace(prinsenkryss,prinsenkrysset).
synplace(prinsenskrysset,prinsenkrysset).       %% RS-151219
synplace(prinsentrysset,prinsenkrysset).       %% RS-151219
synplace(prinsgade,prinsens_gate).  %% (actual)
synplace(prisentret,pirsenteret).  
%% synplace(prisenteret,pirsenteret).  %% unnec
synplace(prochs,brochs). 
synplace(profbroch,hesthagen). 

synplace(profbrochsgt,hesthagen). 
synplace(prov,prof).
synplace(psentrum,sentrum). 
synplace(qurens,ourens). %% ? 
synplace(rabheim,ranheim). 
synplace(ragvold,dragvoll). 
synplace(ragvoll,dragvoll). 
synplace(railway,ts). %% AtB. 
synplace(ranheimidrettsplass,ranheim_idrettsplass). 
synplace(ranheimidrettsplassen,ranheim_idrettsplass). 
synplace(ranheimkirka,ranheim_kirke). 
synplace(ranheimkirke,ranheim_kirke). 
synplace(ranheimsidrettsplass,ranheim_idrettsplass). 
synplace(ranheimsidrettsplassen,ranheim_idrettsplass). 
synplace(ranheimskole,granåsvegen). %% Hastus
synplace(ranheom,ranheim). 
synplace(rare,rate).     %% ?
synplace(rat,rate). %% ?
synplace(ratefeltet,rate).  
synplace(ratet,rate). 
synplace(ravbaneveien,travbaneveien). 
synplace(realfagbygg,realfagbygget). 
synplace(realfagsbygget,realfagbygget). 
synplace(regionalsykehuset,st_olavs_hospital). 
synplace(repe,reppe).  
synplace(repp,reppe). 
synplace(reppr,reppe). 
synplace(reppeendeholdeplass,reppe).  
synplace(reppekrysset,reppevegen). 
synplace(reppevegkryss,reppevegen). 
synplace(reppeveikryss,reppevegen). 
synplace(reppeveikrysset,reppevegen). 
synplace(reppevikåsen,reppevegen). 
synplace(ridevoldsgate,riddervolds_street). 
synplace(ringe,ringve). 
synplace(ringsaker,singsaker). 
synplace(ringv,ringve).  %%?
synplace(ringvaal,ringvål). 
synplace(ringvedskole,ringved_skole). 
synplace(ringvemuseet,ringve_museum). 

synplace(ringveskole,ringve_skole). 
synplace(ringveskolen,ringve_skole). 
synplace(ringvevidregåendeskole,ringve_skole). 
synplace(ringvold,ringvål). 
synplace(ringvoll,ringvål). 
synplace(ringvollgrind,ringvål_grind). 
synplace(ringvålgrind,ringvål_grind). 
synplace(rinveskole,ringve_skole). 
synplace(rinvoll,ringvål). 
synplace(rirterminalen,pirterminalem). 
synplace(rissvoll,risvollan). 
synplace(rissvollen,risvollan). 
synplace(risv,risvollan). 

synplace(ristunet,risvolltun). %% ? 
synplace(risvol,risvollan).
synplace(risvoll,risvollan). 
synplace(risvolltunet,risvolltun). %% 

synplace(risvollansentret,risvollan_senter). 
synplace(risvollanv,risvollveien). 
synplace(risvollanveien,risvollveien).  
synplace(risvollene,risvollan). 
synplace(risvollsenter,risvollan_senter). 
synplace(risvollsenteret,risvollan_senter). 
synplace(risvålan,risvollan). 
synplace(risvållan,risvollan). 
synplace(rlgeseter,elgeseter). 
synplace(robuslia,romolslia). 
synplace(roenningsbakken,rønningsbakken). 
synplace(roeros,røros). 
synplace(rogbudal,rogbudalen). 
synplace(rognbudal,rognbudalen). 
synplace(rognbuedalen,rognbudalen). 
synplace(rognbuendalen,rognbudalen). 
synplace(rogneim,rognheim). 
synplace(romaslia,romolslia). 
synplace(romerslia,romolslia). 
synplace(romeslia,romolslia). 
synplace(romislia,romolslia). 
synplace(rommeslia,romolslia). 
synplace(romondslia,romolslia). 
synplace(romosli,romolslia). 
synplace(romoslia,romolslia). 
synplace(romoslien,romolslia). 
synplace(romouslia,romolslia). 
synplace(romslia,romolslia). 
synplace(romsolia,romolslia). 
synplace(romulslia,romolslia). 
synplace(romulslien,romolslia). 
synplace(romundslia,romolslia). 
synplace(romurslia,romolslia). 
synplace(romusli,romolslia). 
synplace(romuslia,romolslia). 
synplace(romuslis,romolslia). 
synplace(romuslisa,romolslia). 
synplace(romåslia,romolslia). 
synplace(roros,røros). 
synplace(rosedal,rosendal).  %%IKKE Romsdal (wrong preference)
synplace(rosenborgpark,gyldenløves_gate).  
synplace(rosenborgparken,gyldenløves_gate).   
synplace(rosenborgs,rosenborg). 
synplace(rosenborgskolen,gyldenløves_gate).   
synplace(rosenbårr,rosenborg). 
synplace(rosendela,rosendal). 
synplace(rostagrenda,rostengrenda).  %%
synplace(rostgrenda,rostengrenda). 
synplace(rosvolan,risvollan). 
synplace(rotvollen,rotvoll). 
synplace(rravbaneveien,travbaneveien). 
synplace(rutebilselskap,trafikkselskap). 

%% synplace(ruteinformasjonen,tmn). %% TA-110202
%% synplace(ruteopplysningen,tmn).  %%
%% synplace(rutetelefonen,tmn).     %%

synplace(ruttebilstasjonen,rutebilstasjonen). 
synplace(rya,rye). 
synplace(råmølla,graaemølna). 

synplace(rønnebakken,rønningsbakken).

%% synplace(rønningensbakke,rønningsbakken). %% sameplace 
%% synplace(rønningensbakken,rønningsbakken).%% 

synplace(rønningsbakk,rønningsbakken). 
synplace(rønningsbakkenst,rønningsbakken). 
synplace(rønningsgabkken,rønningsbakken). 

synplace(rørås,røros). 
synplace(røvik,rørvik). 
synplace(sakseborgveien,dalen_hageby). 
synplace(sakseborgvn,dalen_hageby). 
synplace(saksenborg,saxenborg). 
synplace(saksevigs,saksviks). 
synplace(saksvig,saksviks). 
synplace(saksvigs,saksviks). 

synplace(saksevik,saksvik). %% foreign

synplace(saland,sælands). 
synplace(salgskontore,servicekontoret). 
synplace(salgskontorene,servicekontoret). 
synplace(salgskontoret,servicekontoret). 
%synplace(samf1,studentersamfundet_1). 
%synplace(samf2,studentersamfundet_2). 
synplace(samfun,samfund). %% studne samfun 
synplace(samfun,studentersamfundet). 
synplace(samfunft,samfundet). 
synplace(samfunn,samfundet). 
synplace(samholdet,samfundet). %% TA-110118
synplace(samoen,sandmoen). 
synplace(sandermoen,sandmoen). 
synplace(sandmo,sandmoen).  %% sandmom -> sandmoveien -> sandmoen
%% synplace(sand,sands). %% Dr Sands veg %% <-> sandveien
synplace(sanktolavssykehus,st_olavs_hospital). 
synplace(saubsta,saupstad). 
synplace(saubstasentre,saupstadsenteret). 
synplace(saupsdaringen,saupstadringen_109).
synplace(saupstadringen,saupstadringen_109). 
synplace(saupstadringen,saupstadringen_109). 
synplace(saupstads,saupstadsenteret). 
synplace(saupstadsentrum,saupstadsenteret).  
synplace(saupstadsvingen,saupstadringen_109). 
synplace(saupstakrysset,saupstadsenteret). 
synplace(saupstasenteret,saupstadsentret). 
synplace(saupstasentre,saupstadsenteret). 
synplace(saupstasentret,saupstadsenteret). 
synplace(saupstseneret,saupstadsenteret). 
synplace(saustadsentret,saupstadsentret). 
synplace(saustaringen,saupstadringen_109). 
synplace(saxeborgveien,dalen_hageby). 
synplace(saxeborgvn,dalen_hageby). 
synplace(saxenborgale,dalen_hageby). 
synplace(saxenborgen,saxenborg). 
synplace(saøndre,søndre). %% sÃ¸ndre halset? %% //u n d e r s p_place
synplace(saørborgen,sørborgen). %% NB \+ sørberg %% TA-101108
synplace(scharlottenlund,charlottenlund). 

synplace(scheldups,schieldrops). 
synplace(sceldrup,schieldrop). 
synplace(schjeldrup,schieldrop). 
synplace(schedropsvei,schedropsvei). 
synplace(scheldrupsvei,e_b_schieldrops_vei). 
synplace(schentnas,schjetnans). 
synplace(schieldropsv,e_b_schieldrops_vei). 
synplace(schieldropsveg,e_b_schieldrops_vei). 
synplace(schieldropsvegen,e_b_schieldrops_vei). 
synplace(schieldropsvei,e_b_schieldrops_vei). 
synplace(schieldrupsvegen,e_b_schieldrops_vei). 
synplace(schieldrupsvei,e_b_schieldrops_vei). 

synplace(sciotz,schiøtz).  %% TA-101214
synplace(schiots,schiøtz). 
synplace(scøyts,schiøtz).  
synplace(shøts,schiøtz). 
synplace(schiøtsvwj,schiøtz_vei). 

synplace(schjethmans,schjetnans).  
synplace(schjetnemarka,sjetnmarka). 
synplace(schjetnes,schjetnans). 
synplace(schøtsvei,schiøtz_vei). 
synplace(sdressavisa,adresseavisa). 
synplace(sdresseavisa,adresseavisa). 
synplace(seland,sælands).  
synplace(selands,sælands). 
synplace(selsbakflaten,selsbakkflata). 
synplace(selsbakkflaten,selsbakkflata). 
synplace(selsbakklia,selsbakkflata). 
synplace(selsbaksflaten,selsbakkflata). 
synplace(senralstasonen,ts). %% AtB. 
synplace(senter,hovedterminalen). %% TA-101228 ?
synplace(senteret,hovedterminalen). 
synplace(sentralbane,sentralstasjon).  %%Ths. . 
synplace(sentralbanest,ts). %% AtB. 
synplace(sentralbansesatsjon,sentralbaneestasjon). 
synplace(sentralbusstasjonen,ts). %% AtB. 
synplace(sentrals,ts). %% AtB. 
synplace(sentralsjatsjon,ts). %% AtB.  %%?
synplace(sentralst,ts). %% AtB. 
synplace(sentralstasj,ts). %% AtB. 
synplace(sentralstj,ts). %% AtB. 
synplace(sentralstojsonen,ts). %% AtB. 
synplace(sentralststasjon,ts). %% AtB. 
synplace(sentrasjonen,sentralstasjonen). 
synplace(sentreun,sentrum). 
synplace(sentrumcity,sentrum). 
synplace(sentrumen,sentrum). 
synplace(sentrumet,sentrum). 
synplace(sentrumsentralen,hovedterminalen). 
synplace(sentrumsområdet,sentrum). 
synplace(sentrumstasj,hovedterminalen).  %%NB
synplace(sentrumsterm,sentrum).  
synplace(sentrumstermianel,hovedterminalen). 
synplace(sentrumstreminalen,sentrum). 
synplace(sentsj,ts). %% AtB.   
synplace(serum,sentrum). 
synplace(setrun,sentrum). 
synplace(setun,sentrum). 
synplace(sharlottenlund,charlottenlund). 
synplace(shettlein,sjetlein). 
synplace(shieldrops,schieldrops). 
synplace(shieldrups,schieldrops). 
synplace(shiledrops,schieldrops). 
synplace(shoppingcenter,senter). 
synplace(shøitzsvei,schiøtz_vei). 
synplace(sigurdbergsalle,gyldenløves_gate). 
synplace(silddråvegen,silddråvegen). 
%% synplace(simen,siemens).  % See unwanted_place (E.g. Mobbing: Simen er stygg)
synplace(singsakerkrysset,jonsvannsveien). 
synplace(singsakerstudentby,singsaker_studenthjem). 
synplace(singsaker,singsaker_studenthjem).
synplace(sinsaker,singsaker_studenthjem).
synplace(sitti,city). 
synplace(sittisyd,city_syd). 
synplace(sitty,city). 
synplace(sittysyd,city_syd). 
synplace(sity,city). 
synplace(sitycid,city_syd). 
synplace(sitycyd,city_syd). 
synplace(sitysyd,city_syd). 
synplace(sivertthonstadsv,sivert_thonstads_street). 
synplace(sjalottenlund,charlottenlund). 
%% synplace(sjansen,skansen). %% for at ...
synplace(sjarlottenlund,charlottenlund). 
synplace(sjarlottenlund,charlottenlund). 
synplace(sjetlandsvei,carl_schjetnans_vei). 
synplace(sjetnanhaugan,sjetnhaugan). 
synplace(sjetmarka,sjetnmarka). 
synplace(sjetnan,schjetnans). 
synplace(sjetnans,schjetnans). 
synplace(sjetnansveg,carl_schjetnans_vei). 
synplace(sjetnansvei,carl_schjetnans_vei). 
synplace(sjetnegrenda,sjetnmarka). 
synplace(sjetnemarka,sjetnmarka). 
synplace(sjødalen,stjørdal). 
synplace(skandik,scandic). 
synplace(skippersenteret,fossegrenda). 
synplace(skiskistua,skistua). 
synplace(skistadion,granåsen_vm_anlegget).  
synplace(skistova,skistua). 
synplace(skiststua,skistua). 
synplace(skistuen,skistua). 
synplace(skjetemarka,sjetnmarka). 
synplace(skjetlien,sjetlein). 
synplace(skjetnan,schjetnans). 
synplace(skjetne,sjetnmarka). 
synplace(skjetnemarka,sjetnmarka). 
synplace(skjettnemarka,sjetnmarka). 
synplace(skoleringen,høyskoleringen).  %% ?
synplace(skovgaard,skovgård). 
synplace(skovgors,skovgård). 
synplace(skovgårde,skovgård). 
synplace(skule,skole). 

%synplace(skyssstasjon,klæbu_skysstasjon).  
%synplace(skysstasjonen,klæbu_skysstasjon). 

synplace(skysta,kystad). 
synplace(skystad,kystad). 
synplace(skyttrerveien,skytterveien). 
synplace(skågård,skovgård). 
synplace(skårvolds,skaarvolds). 
synplace(skårvoldsvei,skaarvolds_street). 
synplace(skåvgår,skovgård). 
synplace(slubben,sluppen). 
synplace(sluppenbrt,sluppen_bru). 
synplace(smestadsvei,arnt_smistads_vei). 
synplace(smfndet,studentersamfundet). 
synplace(smfnt,samfundet).  %% ?
synplace(smistadsvei,arnt_smistads_vei). 
synplace(smith,e_a_smith). 
synplace(sniplas,snuplass).
synplace(sntrm,sentrum).  %% ?
synplace(soh,st_olavs_hospital).  %% ?
synplace(sokkparken,solsiden). 
synplace(solbakkenskole,solbakken_skole). 
synplace(solien,sollia). 
synplace(sollien,sollia).
synplace(solsida,solsiden). 
synplace(solsidensenteret,solsiden).  %%
synplace(solsidesenteret,solsiden).  %%
synplace(solvollveien,solvolvegen).  %%discrepancy>1
synplace(sondemoen,sandmoen).  %%contag
synplace(songdal,sogndal). 
synplace(sorgen,sorgenfri).  %% TA-101102 \+ skogen
synplace(sorgfri,sorgenfri). %% TA-110704
synplace(spektrum,trondheim_spektrum).  %% to get message no.

synplace(spogndalen,spongdal). 
synplace(spongdalen,spongdal). 
synplace(sragvoll,dragvoll). 
synplace(stadingeniør,stadsing).  %%(forstreet)
synplace(stadingeniør,stadsingeniør).  %%(forstreet)
synplace(stadionen,stadion). 
synplace(stadsing,stadsingeniør). 
synplace(stadsingeniør,stadsing). 
synplace(stasion,stasjon). 
synplace(stasion,station). 
synplace(stasjon,ts). %% AtB. 
 
synplace(staten,stadsing_dahls_street). %% AH-080401

synplace(station,stasjon). %% ang sel ?

synplace(statoilhydro,statoil_rotvoll). %% Obs. %% TA-110624

synplace(stationen,ts). %% AtB. 
synplace(statsing,stadsing). 
synplace(statsingeniør,stadsingeniør). 
synplace(statsingeniørs,stadsingeniør). 
synplace(stavet,stavset).  %%-stavne
synplace(stavnegård,stavnebrua). 
synplace(stavnrbroa,stavnebrua). 
synplace(std,student). 
synplace(steinen,steinan).  
synplace(steinaasen,steinåsen). 
synplace(steinanhaugen,steinhaugen). 
synplace(steinanåsen,steinåsen). 
synplace(steinberg,steinberget). 
synplace(steinsbakken,ny_steinsbakken). 
synplace(steintrøa,steintrøveien). 
synplace(stensbakken,ny_steinsbakken). 
synplace(stiftsgårn,stiftsgården). 
synplace(stikkelstad,stiklestad).  %%
synplace(stikkelstadveien,strandveikaia). 
synplace(stikklestadvegen,strandveikaia). 
synplace(stjørdaln,stjørdalen). 
synplace(stjørdarn,stjørdalen). 
synplace(stmarka,østmarka). %% ø trøbbel 
synplace(stokkes,stokkens).  %% Martin
synplace(stolan,stokkan). 
synplace(stolav,st_olavs_hospital). 
synplace(stolavs,st_olavs_hospital). 
synplace(stolavsgata,st_olavs_gate). 
synplace(stolavsgate,st_olavs_gate). 
synplace(stolavsgaten,st_olavs_gate). 
synplace(stolavsgt,st_olavs_gate). 
synplace(stolavssykehus,st_olavs_hospital). 
synplace(storlin,storlien). 
synplace(storen,støren). 
synplace(storsenter,senter). 
synplace(stortorget,hovedterminalen). 
synplace(strandkaia,strandveikaia). %
synplace(strandkaien,strandveikaia). 
synplace(strandkaivegen,strandveikaia). 
synplace(strandkaiveien,strandveikaia). 
synplace(strandveik,strandveikaia). 
synplace(strandveikaien,strandveikaia). 
synplace(strind,strinda). 
synplace(strinden,strinda). 
synplace(strindh,strindheim). 
synplace(strindheimhageby,strindheim_hageby). 
synplace(strindheimhageby,strindheim_hageby). 
synplace(strindheimskole,strindheim_skole). 
synplace(strindheimskolen,strindheim_skole). 
synplace(strjoerdal,stjørdalen). 
synplace(stud,studentby). 
synplace(studendentersamfundet,studentersamfundet).  %%
synplace(studentboligene,studentbyen). 
synplace(studentby,studenthjem). 
synplace(studenteerby,studentby). 
synplace(studenterby,studentby). 
synplace(studenterby,studentby). 
synplace(studenterhytten,studenterhytta). 
synplace(studentersam,studentersamfundet). 
synplace(studentersambunnet,studentersamfundet). 
synplace(studentersamf,studentersamfundet).  %% (komb. 1/2)
synplace(studentersamfun,studentersamfundet). 
synplace(studentersamfund,studentersamfundet).  
synplace(studentersamfunn,studentersamfundet).  
synplace(studentersamrundet,studentersamfundet).  
synplace(studentersamrunet,studentersamfundet).  %% ?
synplace(studentesamfund,studentersamfundet). 
synplace(studentesamfunnet,studentersamfundet).  %% (komb. 1/2)
synplace(studentheim,studentby).  
synplace(studenthjem,studentby). 
synplace(studentsamf,studentersamfundet). 
synplace(studentsamfun,studentersamfundet). 
synplace(studentsamfunn,studentersamfundet). 
synplace(studentsammfun,studentersamfundet). 
synplace(studentsammfunn,studentersamfundet). 
synplace(studerntersmafundet,studentersamfundet). 
synplace(studesamf,studentersamfundet).            %%  own
synplace(studneby,studentby). 
synplace(studsamf,studentersamfundet). 
synplace(studsamfund,studentersamfundet). 
synplace(stundertersamfunnet,studentersamfundet). 
synplace(supsta,saupstad). 
synplace(svaresborg,sverresborg). 
synplace(svartlademoen,svartlamon). 
synplace(svartlamoen,svartlamon). 
synplace(sveberg,svebergkrysset). %% RS-150913
synplace(sverige,sweden). %nec?
synplace(sverresgård,sverresborg). 
synplace(sykeheim,sykehjem). 
synplace(sykehj,sykehjem). 
synplace(sykehjem,sykeheim). 
%% synplace(sykehuset,st_olavs_hospital).  %% sykehuset Brøset
synplace(søbeg,søberg). 
synplace(søbstadringen,saupstadringen_109). 
synplace(søbstadsenteret,saupstadsenteret). 
synplace(søndemoen,sandmoen).  %%contag


synplace(søndregate,søndre_street). %% Nec %% TA-110526
synplace(søndregate_22,olav_tryggvasons_gate_ot3). 
synplace(søndregate_23,olav_tryggvasons_gate_ot3). 
synplace(søndregt,søndregate).  %%NBsynSyndrome



synplace(søndrehoem,søndre_hoem). %% Tram station
synplace(sønningsbakken,rønningsbakken).  %% ? sms
synplace(søpstadsenteret,saupstadsenteret). 
synplace(søtmarka,østmarka). 
synplace(søupstamyra,saupstadmyra). 
synplace(tabarsjelve,tambarskjelve). 
synplace(talentinlyst,valentinlyst).  %%sms

synplace(tamb,tambarskjelves). 
synplace(tambardskjelves,tambarskjelves). 
synplace(tambarselve,tambarskjelve). 
synplace(tambarsjelvarsgt,tambarskjelvesgate). 
synplace(tambarsjelve,tambarskjelve). 
synplace(tambarsjelves,tambarskjelves).  %%Repair,ERRORinregcomsptr
synplace(tambarskjellgt,tambarskjelvesgate). 
synplace(tambarskjelv,tambarskjelves). 
synplace(tambarskjelvars,tamberskjelves). 
synplace(tambarskjelvarsgate,tambarskjelvesgate). 
synplace(tambarskjelvarsgt,tambarskjelvesgate). 
synplace(tambarskjelvgt,einar_tambarskjelves_gate). 
synplace(tambarskjelvsgate,einar_tambarskjelves_gate).  %%
synplace(tambarskjgt,einar_tambarskjelves_gate). 
synplace(tambarskjoldsgate,tambarskjelvesgate). 
synplace(tambartjelvesgate,einar_tambarskjelves_gate). 
synplace(tambasjelvsgate,einar_tambarskjelves_gate).  %%
synplace(tambergsjelvsgt,einar_tambarskjelves_gate). 
synplace(tambergskjeldsgate,einar_tambarskjelves_gate). 
synplace(tambergskjellsgate,tambarskjelvesgate). 
synplace(tambersk,einar_tambarskjelves_gate).  %%
synplace(tamberskjeldsgt,einar_tambarskjelves_gate). 
synplace(tamberskjelds,tambarskjelves).   
synplace(tamberskjellsgt,einar_tambarskjelves_gate). 
synplace(tamberskjelves,tambarskjelves). 
synplace(tamberskjevs,tambarskjelves). 
synplace(tamberskjolds,tambarskjelves). 
synplace(tambesjelvesgate,einar_tambarskjelves_gate). 



synplace(tanbergsjedesgate,einar_tambarskjelves_gate). 

synplace(taøh,tøh). %% TA-110411   %% tÃ¸h

synplace(tanemskrysset,tanemskrysset_1). 
synplace(tanemskrysset,tanemskrysset_2). %% RS-150111
synplace(teamkontoret,servicekontoret). 
synplace(technoport,trondheim_spektrum). 

synplace(tegelsteinsveien,teglverkskrysset). 
synplace(tegelvegstunet,teglverkstunet). 
synplace(tegelverk,teglverk). 
synplace(tegelverketskrysset,teglverkskrysset). 
synplace(tegelverketstunet,teglverkstunet). 
synplace(tegelverkstunet,teglverkstunet).  %% street
synplace(teggelsverkskrysset,teglverkskrysset). 
synplace(teggelverkskrysset,teglverkskrysset). 
synplace(teglegården,teglgården). 
synplace(teglekrysset,teglverkskrysset). 
synplace(tegleverkkrysset,teglverkskrysset). 
synplace(tegleverkrysset,teglverkskrysset). 
synplace(teglkrysset,teglverkskrysset). 
synplace(teglsteinskrysset,teglverkskrysset). 
synplace(teglsteinsveien,teglverkskrysset). 
synplace(teglsteinverket,teglverket). 
synplace(teglstenskrysset,teglverkskrysset).  %%
synplace(teglstensvegen,teglverkskrysset).    %%
synplace(teglstensveien,teglverkskrysset). 
synplace(teglvegstunet,teglverkstunet). 
synplace(teglveiskrysset,teglverkskrysset). 
synplace(teglveiskrysset,teglveiskrysset). 
synplace(teglveistunet,teglverkstunet). 
synplace(teglverkkysset,teglverkskrysset). 
synplace(teglverksbakken,teglverkskrysset).  %%
synplace(teglverkskr,teglverkskrysset). 
synplace(teglverksveien,teglverkskrysset).   %% ?
synplace(tegleverksveien,teglverkskrysset).  %% ? 
synplace(tegverkkysset,teglverkskrysset). 
synplace(teilverksbakken,teglverkskrysset).  %%
synplace(teisendamen,theisendammen). 
synplace(televerkskrysset,teglverkskrysset). 
synplace(telverkskrysset,teglverkskrysset).  %%

synplace(temp,tempe). 

synplace(tempeveien,tempevegen). %% nofunk tempeveien 11
        % street    station

%%  Tempevegen 11 // station
%%  Tempeveien 11 street -> valøyvegen

% synplace(terase,terrasse). 
% synplace(terasse,terrasse). 
synplace(thamberskj,tambarskjelves). 

synplace(thalouwveien,thaulowbakken). 
synplace(thaulaubakken,thaulowbakken).
synplace(thaulauwbakken,thaulowbakken). 
synplace(thaulauwbakken,thaulowbakken). 
synplace(thaulowsgate,thaulowbakken). 
synplace(thaulwlobakken,thaulowbakken). 

synplace(theisendamen,theisendammen). 
synplace(thoming,thonning). %% Owesen
synplace(thonstad,tonstad). 
synplace(thorsplassen,casper_lundes_veg).  %%
synplace(thouwlowbakken,thauwlowbakken). 
synplace(thrheim,trondheim). 
synplace(thonheim,trondheim). 
synplace(tikker,tiller). 
synplace(tillerbruen,tiller_bru). 
synplace(tilleringen,tiller_ringen). 
synplace(tillerkirka,'Tiller kirke'). 
synplace(tillerkirke,'Tiller kirke').
synplace(tillerområdet,tiller). 
synplace(tillerringen,tiller_ringen).  %% street
synplace(tisvollan,risvollan). 
synplace(tjyvatnet,kyvatnet). 
synplace(tlh,lærerhøgskolen). 
synplace(tnga,tunga). 
synplace(togbanestasjon,ts). %% AtB.
% synplace(toget,ts). %% AtB // no torget ? %% 
synplace(togsentral,ts). %% AtB. 
synplace(togsentralen,ts). %% AtB. 
synplace(toholdttårnet,strinda_vgs). 
synplace(tonstad,thonstad). 
synplace(tonstad,thonstad).  %%Nec???
synplace(tonstadbrinken,tonstad). 

synplace(tonstads,thonstads). 
synplace(tonstadsvei,thonstadsvei). 
synplace(tonstagrena,tonstadgrenda). 
synplace(tonstagrenna,tonstadgrenda). 
synplace(toorvplassen,hovedterminalen). 
synplace(tordenskjol,tordenskiolds). 
synplace(tordenskjoldsgate,tordenskiolds_gate).  %%Problems
synplace(tordenskjoldsgt,tordenskiolds_gate). %inregtrikketc. 
synplace(tordenskjols,tordenskiolds).  %%NBio
synplace(torg,hovedterminalen). 
synplace(torge,hovedterminalen).  %%nospellbecausetorg|torget
synplace(torndheimtorg,hovedterminalen). 
synplace(torne,thornæs). 
synplace(tornesvei,k_o_thornæs_vei). 
synplace(torsplass,casper_lundes_veg).  %%
synplace(torsvei,tors_veg). 
synplace(torsvn,tors_veg). 
synplace(torv,torg). 
synplace(torvet,hovedterminalen). 
synplace(torvet,hovedterminalen). 
synplace(torvoll,rotvoll). 
synplace(torvtakeket,torvtaket). 
synplace(tovet,hovedterminalen). 
synplace(tprvet,hovedterminalen). 
synplace(trafikksentralen,ts). %% AtB. 
synplace(trafikkterminalen,hovedterminalen). 
synplace(trafikkterminal,hovedterminalen). %% ? Moa traf.
synplace(trafikkterminialen,sentrumsterminalen). 
synplace(trafikselskap,trafikkselskap). 
synplace(tragvoll,dragvoll).
synplace(trainstation,ts). %% AtB. 
synplace(transportselskap,trafikkselskap). 
synplace(travbane,travbanen).  %% Not spellcheck on part names if they are fullnames
synplace(travbanebeien,travbaneveien). 
synplace(travpark,travbane). 
synplace(travpark,travbanen). 
synplace(trdhiem,trondheim). 
synplace(trheim,trondheim). 
%% synplace(trikk9,9).  %%? 
synplace(troendelag,trøndelag). 
synplace(trola,trolla). 
synplace(trollahaugen46,trollahaugen_46). 
synplace(trollahaugen64,trollahaugen_64). 
synplace(trollhugen,trollahaugen). 
synplace(trond,thrond).  %% thronneergaardsvei? %%
%% synplace(trond,trondheim). %% silly answers %% TA-100829 
synplace(trondein,trondeinm). 
synplace(trondh,trondheim). 
synplace(trondhe,trondheim). 
synplace(trondheimheim,trondheim).  %% ?
synplace(trondheimsdistriktet,trondheim). 
synplace(trondheimsentralbanestasjon,ts). %% AtB. 
synplace(trondheimsentrum,sentrum). 
synplace(trondheimsentrumsstasjon,hovedterminalen). 
synplace(trondheimspektrum,trondheim_spektrum). 
synplace(trondheimst,ts). %% AtB. 
%% synplace(trondheimstasjon,ts). %% AtB.  %% sameplace 
synplace(trondheimsterminal,ts). %% AtB. 
synplace(trondheimsterminalen,ts). %% AtB. 
synplace(trondheimterminalen,ts). %% AtB.  %% ?
synplace(trondheimterminalstasjon,ts). %% AtB.  %% used that way
synplace(trondheimtrafikkstasjon,ts). %% AtB. 
synplace(trondheitorg,hovedterminalen). 
synplace(trondhjemsdistriktet,trondheim). 
synplace(trondsentrum,hovedterminalen). 
synplace(tronheim,trondheim). 
synplace(tronhem,trondheim). 
synplace(tronheom,trondheim). 
synplace(tronjæm,trondheim). 
synplace(trovet,hovedterminalen).  %% trofet-vegen ?
synplace(trtorg,hovedterminalen). 
synplace(trudvengveien,trudevang_street).  %% dev. . 
synplace(tryggvassons,trygvassons).  %% local misspell
synplace(trygvason,tryggvason). 
synplace(trygvason,tryggvasons). 
synplace(trygvasonsgt,olav_tryggvasons_gate_ot1). %% CORREC %% TA-101203 %% AtB
synplace(tråjæm,trondheim). 
synplace(trødheim,trondheim). 
synplace(tsrindheim,strindheim). 
synplace(tuga,tunga).  
synplace(tungafengsel,tunga_kretsfengsel). 
synplace(tungafengslet,tunga_kretsfengsel). 
synplace(tungafengselet,tunga_kretsfengsel). 
synplace(tungakretsfengsel,tunga_kretsfengsel). 
synplace(tungakrysset,iskremfabrikken).  %% (?)
synplace(tunge,tunga). 
synplace(turge,hovedterminalen). 
synplace(tvestien,tvetestien). %% TA100107
synplace(tvedesiten,tvetestien). 
synplace(tveitanstien,tvetestien). 
synplace(tydalen,tydal).  %% (ikke Nydalen)
synplace(tyhikt,tyholt).  %% dbl neib
synplace(tyholttaarnet,strinda_vgs). 
synplace(tyholttårn,strinda_vgs). 
synplace(tyholtårndt,strinda_vgs). 
synplace(tårnet,strinda_vgs). %% <- 
synplace(tæglegården,teglgården). 
synplace(tæretrøa,værestrøa). %% off name  %% ?
synplace(uantinlyst,valentinlyst).  %% ?
synplace(udbergs,udbyes). %% gt
synplace(uglaholdplass,ugla).  %% ?
synplace(uglastasjon,ugla). 
synplace(uglastien,uglahaugstien). 
synplace(ugle,ugla).  %%nospellif=<4ch
synplace(ugls,ugla). 
synplace(uikåsen,vikåsen). 
synplace(uka,studentersamfundet). 
synplace(ulga,ugla).
synplace(ullstadløkka,ulstadløkkveien). % sameplace doesn'twork
synplace(ullumsgården,byåsen_butikksenter).   %% ? 
synplace(ulstadløkka,ulstadløkkveien).  %%(?)Road
synplace(ungdomsskole,skole). 
synplace(unherredsvei,inherredsveien). 
synplace(unit,ntnu). 
synplace(universitetssenter,universitet). 
synplace(unkegata,munkegata). 
synplace(urtigruta,hurtigruta). % ?
synplace(utla,ugla). 
synplace(utleiramarka,utleirmark). 
synplace(utsikt,utsikten_alle). 
synplace(uæretrøa,værestrøa). %% off name %%  ? (sms)
synplace(vaadan,vådanv_5).    % ?
synplace(vaerestroa,værestrøa). %% TA100110
synplace(vaeretroa,værestrøa). %% off name 
synplace(vaeretroea,værestrøa). %% off name
synplace(valdntynlyst,valentinlyst). 
synplace(valenlyst,valentinlyst). 
synplace(valentdenlyst,valentinlyst).  
synplace(valentenenlyst,valentinlyst). 
synplace(valententinlyst,valentinlyst). 
synplace(valentin,valentinlyst). 
synplace(valentine,valentinlyst). 
synplace(valentinenlyst,valentinlyst). 
synplace(valentinenlystvegen,valentinlystvegen). % already a spellerr
synplace(valentinerlyst,valentinlyst). 
synplace(valentinersenteret,valentinlyst). 
synplace(valentines,valentinlyst).  
synplace(valentininlyst,valentinlyst). 
synplace(valentinl,valentinlyst). 
synplace(valentinsenteret,valentinlyst). 
synplace(valentinsentret,valentinlyst).  
synplace(valentintinlyst,valentinlyst). 
synplace(valentlyst,valentinlyst). 
synplace(valentylist,valentinlyst). 
synplace(valentynlist,valentinlyst). 
synplace(valervegen,valøyvegen). 
synplace(valerveien,valøyvegen). %% ?
synplace(valerøyveien,valøyvegen). 
synplace(valetinenlyst,valentinlyst). 
synplace(valetinerlyst,valentinlyst). 
synplace(valin,valentinlyst). 
synplace(valinlyst,valentinlyst). 
synplace(valkbergets,falkbergets). 
synplace(vallentin,valentinlyst). 
synplace(valtenlyst,valentinlyst). 
synplace(valtinlyst,valentinlyst). 
synplace(valtninlyst,valentinlyst). 
synplace(valøiveien,valøyvegen). 
synplace(valøyvegen,valøy_street). 
synplace(vaneltynlyst,valentinlyst). 
synplace(vanetelyst,valentinlyst). 
synplace(vanetinlyst,valentinlyst). 
synplace(vanlentynlyst,valentinlyst). 
synplace(vantelyst,valentinlyst). 
synplace(vantinlyst,valentinlyst). 
synplace(varetroa,værestrøa). %% off name
synplace(varetroea,værestrøa). %% off name 
synplace(vassfjell,vassfjellet). 
synplace(vassfjelt,vassfjellet).

synplace(vblakli,blakli). 
synplace(vearnas,trondheim_lufthavn_lufthavnveien). 
synplace(velntinlyst,valentinlyst).
synplace(veratrøa,værestrøa). %% off name 
synplace(verdaln,verdalen). 
synplace(vertrøa,værestrøa). %% off name 
synplace(vesterlia,vestlia). 
synplace(vestli,vestlia). 
synplace(vestliaendeholdeplass,vestlia_endeholdeplass). 
synplace(vestlias,vestlia). 
synplace(vestlien,vestlia). 
synplace(vey,veg). 
synplace(vey,vei). 
synplace(vg,skole).  %% collides with veg???
%% synplace(vgs,skole). %% no jfr byåsen skole \= byåsen vgs 
synplace(vharlottenlund,charlottenlund).  %%
synplace(videregående,skole). 
synplace(videregåendeskole,skole).  %%etc
synplace(vidergående,videregående). 
synplace(vidergåendeskole,skole). 
synplace(vidreg,videregående). 
synplace(vidregående,skole). 
synplace(vidregående,videregående). 
synplace(vikaasen,vikåsen). 
synplace(vikahammer,vikhammer). 
synplace(vikahmmer,vikhammer). 
synplace(vikhamar, vikhammer). %% MW-121119  
synplace(vikhamaren, vikhammer). %% MW-121119   
synplace(vikhamarn, vikhammer). %% MW-121119  
synplace(vikhammar, vikhammer). %% MW-121119  
synplace(vikhammaren, vikhammer). %% MW-121119  
synplace(vikhammarn, vikhammer). %% MW-121119  
synplace(vikhamer, vikhammer). %% MW-121119  
synplace(vikhammeren, vikhammer). %% MW-121119 
synplace(vikamer,vikhammer). 
synplace(vikelv,vikelvveien).  %%Complicated
synplace(vikhamaråsen,vikhammeråsen).
synplace(vikhameråsen,vikhammeråsen). 
synplace(vikhmmer,vikhammer). 
synplace(vikås,vikåsen). 
synplace(vikåshallen,vikåsenhallen). 

synplace(vill,voll). %% haz? 

synplace(violsvingen,fiolsvingen). 
synplace(vity,city). %% ?
synplace(vlanetinlyst,valentinlyst). 
synplace(voill,voll).  %% ikke voll(gt)
synplace(vol,voll). 
synplace(vold,voll).  %% Necessary(?) vold\=volda %% (Syndrome)
synplace(voldsminne,voldsminde). 
synplace(vollababakken,vollabakken). 
synplace(vollaballen,vollabakken).  %%contag
synplace(vollabkenn,vollabakken). 
synplace(vollumsgården,byåsen_butikksenter). 
synplace(vstla,vestlia). 
synplace(vull,voll). 
synplace(vullumsgården,byåsen_butikksenter). 
synplace(vådan,vådanv_5).  %%?
synplace(våll,voll). 
synplace(værestrøya,værestrøa).
synplace(væretrøen,værestrøa). 
synplace(væretrøene,værestrøa).
synplace(værnesflyplass,trondheim_lufthavn_lufthavnveien). 
synplace(værnes,trondheim_lufthavn_lufthavnveien).
synplace(værøtra,værestrøa). 
synplace(vætertrøa,værestrøa). 
synplace(wist,stjørdals_street).  %% \+ placestat
synplace(woll,voll). 
synplace(ygla,ugla). 
synplace(yiller,tiller). %?
synplace(ystergaardsvei,ystgaardsvei). 
synplace(ystergårdsvei,ystgaardsvei). 
synplace(ystgaardsvei,ingvald_ystgaards_street).  %% //Confus? Notanymore 
synplace(ystgårds,ystgaards). 
synplace(ystgårdsvei,ystgaardsvei). 
synplace(yåsen,byåsen). 
synplace(zentral,sentral). 
synplace(ælgesætergt,elgeseter). 
synplace(æsheim,åsheim). 
synplace(æsvang,åsvang). 
synplace(æsveien,åsveien). 

synplace(øeangen,leangen).  %%1. 
synplace(øerkendal,lerkendal).
synplace(øst,østre). 
synplace(østerberg,østre_berg). 
synplace(østgårds,ystgaards). 

synplace(østre_roten,østre_rosten).         %% RS-150111. Spell-check. Synplace?
synplace(østrerosten,østre_rosten). 
synplace(øver,øvre). 
synplace(øveraas,øverås). 
synplace(øvreflatåsvegen,øvre_flatås_street).  %% problem
synplace(øvreflatåsvegen,øvre_flatåsveg).  
synplace(øvrejakobsli,jakobslivegen_øvre).  
synplace(øvreromulslia,romolslia_øvre).  %% (SICromol)//redundant eventually
synplace(øvretvereggen,øvre_tvereggen).  %% street?
synplace(øysand,øysandkrysset).  %% RS-150913

synplace(åaveienskole,åsveien_skole). 
synplace(åirbadet,pirbadet). 
synplace(åiren,pirbadet).   %%?
synplace(åirterminalen,pirbadet).  
synplace(ålderdalen,olderdalen). 
synplace(åpirterminalen,pirbadet).   %%1. letter
synplace(årinsen,prinsen). 
synplace(åsns,aaes).  %%strangename
synplace(åsvangskole,åsvang_skole). 
synplace(åsvei,åsveien). 
synplace(åsveienskolen,åsveien_skole). 
synplace(åsveiskolen,åsveien_skole). 
synplace(åveienskole,åsveien_skole). 
synplace(åøstmarka,østmarka). 

%%% synplace(atb,kongens_street-34). %%  %% <----- AtB Funk // hva er atb %% RS-120805 Sorting
synplace(ts,ts).   %% <----- AtB
synplace(ts10,ts). %% 
synplace(ts11,ts). %%


%%% UNDERSPECIFIED_PLACE (PLACE)

underspecified_place(adolf_øien).  %% See ¤ PLACE_RESOLVE (PLACE,STATION).
underspecified_place(alpinanlegget). 
underspecified_place(alpinbakken). 
underspecified_place(badestranda). 
underspecified_place(bakke). 
%% underspecified_place(bakli). 
%% underspecified_place(barnehage). %% --> noinfo
%% underspecified_place(barnehave).
underspecified_place(berg). 
%% underspecified_place(bibliotek). %% TA-101116 generic
%% underspecified_place(biblioteket).  Biblioteket på Moholt
underspecified_place(blussuvold). 
underspecified_place(bomringen). 
%% underspecified_place(bratsberg). %% TA-110325
%    hpl(16010046,bratsberg_østre,bratsberg_østre,'Bratsberg østre').
%    hpl(16010609,bratsbergflata,bratsbergflata,'Bratsbergflata').
%    hpl(16010763,bratsberg_kirke,bratsberg_kirke,'Bratsberg kirke

underspecified_place(brygge).  
underspecified_place(butikken).
underspecified_place(butikksenteret).  
underspecified_place(bygda). 
underspecified_place(bygden).  

underspecified_place(byåsen). 

underspecified_place(båthavna). 
underspecified_place(charlottenlund). 
underspecified_place(drosjesentralen). 
underspecified_place(e6). 
underspecified_place(europaveg). 
underspecified_place(europavegen). 
underspecified_place(europavei).
underspecified_place(europaveien).

underspecified_place(fabrikken). 
underspecified_place(fjellet). 
underspecified_place(forskningsparken).  
underspecified_place(forskningssenteret). 
underspecified_place(flybussterminalen). 
underspecified_place(fokus).  %% -hallen?
%% underspecified_place(fotballbane).  %% ? 
underspecified_place(fotballbanen). 
%% underspecified_place(golfbane). %% generic, 
underspecified_place(golfbanen). % ?
underspecified_place(grensa). 
underspecified_place(grensen). 

%%   underspecified_place(gård). %% Stavne gård is not U

underspecified_place(gården). 
%underspecified_place(haakon_vii_gate).  %% Despair 
underspecified_place(hageby). 
underspecified_place(hist). 
underspecified_place(hotell). 
underspecified_place(hotellet).  %%
underspecified_place(hovedinngangen). %% ( slightly odd) hovedinngangen til st.olavshospital?
underspecified_place(hovedstasjonen).  %% TS|ST ?
underspecified_place(huseby).     %% Husebyst//Husebysentret 
underspecified_place(høgskolen).  %% HIST or NTH?
underspecified_place(høyskolesenteret). 

%% underspecified_place(idrettsbygg).  -> generic_place 
underspecified_place(idrettsparken).
%% underspecified_place(idrettsplassen).  %% TA-100828  idrplassen jakobsli %% RS-190101 TODO

underspecified_place(ingeniørhøgskolen). 
underspecified_place(innlandet). 
underspecified_place(jakobslivegen).  %% nedre/øvre vegen official road name
underspecified_place(jordet). 
%% underspecified_place(kafe).  %% generic
underspecified_place(kafeen). 
underspecified_place(kino). 
underspecified_place(kirka). 
%% underspecified_place(kirke). %% "nardo kirke" 
underspecified_place(kirken). 
underspecified_place(kirkegården).
%% underspecified_place(kjøpesenter). %% unk
underspecified_place(kjøpesenteret). 
underspecified_place(kjøpesentra). 
underspecified_place(kjøpesentret). 
%% underspecified_place(klinikk).  
%% underspecified_place(klinikken). %% noinfoaboutnoun
underspecified_place(kommunehuset). 
underspecified_place(kommunesenteret). 
underspecified_place(kroghsvei).  %%peder/gina
underspecified_place(lilleby).  %% (? whereisit)
underspecified_place(lærerskolen). 
underspecified_place(malvikmarka). 
underspecified_place(mellomveien).  %% Mellomveien 5 st. ,nearestBuran
underspecified_place(markedet). %% torget ? 
underspecified_place(mo).  %% Mo i Rana?
underspecified_place(motorveien). 
underspecified_place(museum). 
underspecified_place(myra).  
underspecified_place(møllenbergveien).  %% Øvre/Nedre M. gt
underspecified_place(nidaros). %% Th, sjokol domen, 
underspecified_place(nidelva). 
underspecified_place(nidelven). 
underspecified_place(nordre). %% TA-110418
underspecified_place(ntnu).   %%
underspecified_place(oasen).  %% \+ Osen 
underspecified_place(obs).    %% Obs Lade,Heimdal,City Syd
underspecified_place(omkjøringsveg).  %% something missing
underspecified_place(omkjøringsvei).  
underspecified_place(omkjøringsveien). 
%% underspecified_place(omkjøringsvegen).  %% something missing
%% underspecified_place(omkjøringsveien). 
underspecified_place(parken). 
underspecified_place(prestegården). 
underspecified_place(rutebilstasjonen).  %% Sentralstasjonen,
underspecified_place(samfunnshuset).  %% %% slightly misplaced error message
underspecified_place(sanatoriet).  
underspecified_place(scandic_hotel).
%%  underspecified_place(senter). %% Try without %% TA-101228
underspecified_place(sintef). 
underspecified_place(sjøen). 
underspecified_place(skauen).  
underspecified_place(skibakken). 
underspecified_place(skogen). 
%% underspecified_place(skole).  %% ? destroys byåsen videregående
underspecified_place(skolen). %% nidarvoll skolen \+ flertydig %% TA-100903
underspecified_place(skytebanen). 
underspecified_place(solbakken). 
underspecified_place(sorgendal). 
underspecified_place(st_olav).     %% RS-160109
underspecified_place(storsenteret). %% TA-110125
underspecified_place(stranden).  %% TA-101108
underspecified_place(strinda). 
underspecified_place(strindamarka). 
underspecified_place(studentby). 
underspecified_place(studentbyen). 
%underspecified_place(sykehuset). %% Nesten alle mener st. olavs hospital
underspecified_place(svingen).  
underspecified_place(svømmehallen). 
underspecified_place(svømmehaller). 
%% underspecified_place(sykehus). %% -> noinfoabout %%  Brøset sykehus= more precise *
underspecified_place(søndre).  %% confusing
underspecified_place(taxisentralen). 
underspecified_place(telenor). 
underspecified_place(televerket). 

underspecified_place(terminal). %% TA-110624
%% underspecified_place(terminalen). %% = godsterminalen_nsb

underspecified_place(togstasjon). %% \+ en 
underspecified_place(toyota).     %% verksted %% TA-100823
underspecified_place(trafikkstasjon).  %% TS or ST
underspecified_place(trafikkstasjonen). 
underspecified_place(tunnelen). %% TA-110114
underspecified_place(tunnellen). 
underspecified_place(tunellen). 

underspecified_place(trøndelag).       %% // not foreign (spchk)
underspecified_place(universitetet). 
underspecified_place(university). 
underspecified_place(utleira). %% TA-100921
underspecified_place(utkanten). 
underspecified_place(vann). 
underspecified_place(vannet). 
underspecified_place(vatn). 
underspecified_place(vatnet). 
underspecified_place(vegmesterveien). 
underspecified_place(veita).  
underspecified_place(veiten). 
underspecified_place(vestbyen).
underspecified_place(vestkanten).
underspecified_place(vinmonopol). 
underspecified_place(vinmonopolet). 
underspecified_place(vinmonopolet). 
underspecified_place(voldsminde).  %% mellomv_5|ØvreMøllenberggt 40->Bakkegate
underspecified_place(vollan). 

underspecified_place(ødemarka). 
underspecified_place(ødemarken).  %%
underspecified_place(øra). 
underspecified_place(østbyen). 
underspecified_place(østkanten). 
underspecified_place(øya).  %% or nobuses ?
underspecified_place(åsen). 


unwanted_station(politihuset). % station, never used , but valid neighbourhood  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  Unwanted place names (Domain dependent)

unwanted_place('3t').  %% Ambiguousname(Sluppen,Rosten,Heimdal)
unwanted_place(alke). 
unwanted_place(alt).   %%  \+ alta destroys lang sel. 
unwanted_place(amok).  %%  \+ AMO
unwanted_place(anal).  %%  \+ asal street
unwanted_place(arbeidsbuss). %% pro forma station (SIC) 
unwanted_place(are).   %% Disturbs N/E
unwanted_place(arve).  %% aure/aare
unwanted_place(ass). 
unwanted_place(astma).  %%  \+ Aasta amble # overgen
unwanted_place(atle). 
unwanted_place(bake).   %%  \+ bakke
unwanted_place(bakenden). %% \+ bakken
unwanted_place(banan).  %%  \+  bane(Dialect banene?)
unwanted_place(banne).  %%  \+ banen
unwanted_place(behn).   %%  \+ byen
unwanted_place(bekken). %% bukken/bakken
unwanted_place(berget).  %% ???
unwanted_place(bist).   %% German(not Wist)
unwanted_place(bjørn).  %% \+  Bjøra
unwanted_place(bjaørn).  %% \+  Bjøra  ..BjÃ¸rn 
unwanted_place(blakk).  %% \+  Flakk
unwanted_place(blinker).  %%  \+ bleiker
%%  unwanted_place(bombingen).  %%  \+ bomringen // Experiment
unwanted_place(brage).   %% name, \+ berge 
unwanted_place(brenne).  %%  \+ Brænne
unwanted_place(brus).  %% \+  bru
unwanted_place(brå).  %%  Hvor var du da Brå brakk staven
unwanted_place(bush). 
%% unwanted_place(bye).  %%  \+ byen -  eng good bye 
unwanted_place(byåse).  %% Byåsen/Byåsv(eien)
unwanted_place(cars).  %%  \+ carl,lang. selection
unwanted_place(club).  %%  \+ Cuba
%%   unwanted_place(cola).  %%  ( \+ Sola)
unwanted_place(dachs).  %%  \+ dahls
unwanted_place(das).  %%  \+ SAS
unwanted_place(dekk).  %%  \+ dokk
unwanted_place(dikt).  %% norDist. . . lege
unwanted_place(dn).  %% DireforN. . . -D1
unwanted_place(does).  %%  \+ Dons %% destroys lang selection
unwanted_place(dommen). %% \+ Domen
unwanted_place(dong).  %%  \+ Dons
unwanted_place(door).  %%  \+ Dora(amble#)//theotherway?
unwanted_place(downs).  %%  \+ dons
unwanted_place(drit).  %% \+  RIT(forthisreason,badwordsarerepelled)
unwanted_place(drite).  %%  \+ Ditle
unwanted_place(dt).  %% (det?)not D0
unwanted_place(dust).  %% ikkedist
unwanted_place(døden).  %% (mendødensdalOK)
unwanted_place(egget).  %%  \+ Eggen
%% unwanted_place(einar_tambarsjelves_gate). %%% ??????????????
unwanted_place(elgen).  %%  \+ Eggen
unwanted_place(en). 
%% unwanted_place(enter).  %% einerv.
unwanted_place(eple). 
unwanted_place(er).  %% especiallyinenglish
unwanted_place(erichsen).  %% \+  erichsens
unwanted_place(et). 
unwanted_place(eu).  %% \+  e6
unwanted_place(evner).  %% einer/everk
unwanted_place(faan).  %%  \+ Fana
unwanted_place(faen).  %%  \+ Fana
unwanted_place(faller).  %% \+  Fallet
unwanted_place(fan).  %%  \+ Fana
unwanted_place(feit).  %%  \+ Frei
unwanted_place(fest).  %% \+  vest
unwanted_place(finnses). %% \+ Finnsnes ?
unwanted_place(fjærta). 
unwanted_place(fjerta). %%
unwanted_place(flåtten). %% \+ Flaten
unwanted_place(foo).     %%  \+ Foto
unwanted_place(forget).  %% \+ Forset 
unwanted_place(fra).  %% \+  Fram
unwanted_place(fram).  %% \+  framveien
unwanted_place(fre).  %% \+  frue
unwanted_place(fresk).  %%  \+ frues
unwanted_place(from).  %% \+  fram
unwanted_place(fy).  %% \+  by
unwanted_place(fylla).  %% \+  folla
unwanted_place(føre).  %% (not Møre)
unwanted_place(førte).  %% (not Førde)
unwanted_place(g).  %% Mysterious internal station,\+ gå
unwanted_place(gang).  %%  gang-> gan-g-> grabvegen 
unwanted_place(gave).  %%  \+ gate
unwanted_place(gay).  %% (not May).  %% NBnot actuallyplace
unwanted_place(ger).  %% \+  Ler,probablygår
unwanted_place(gjøk).  %% \+  Gjøa
unwanted_place(glede). %% \+ Gilde
unwanted_place(goes).  %%  \+ godes,destroyslanguagedetection
unwanted_place(gp).  %% probablygo,butbecomesgt
unwanted_place(grade). %% \+ graae
unwanted_place(graaemølla).  %% ?
unwanted_place(gral).  %% gran?
unwanted_place(grille).  %%  \+ Gilles
unwanted_place(gro).  %% \+  bro
unwanted_place(guide).  %% \+Gudesgt
unwanted_place(guten).  %% \+gaten
unwanted_place(går).  %% NBMunkvoldgår
unwanted_place(gåt).  %% probablygår,butbecomesgt
unwanted_place(habla).  %% \+  Halsa(Spansk
unwanted_place(haik).  %% \+  Hank(Sport)
unwanted_place(half).  %%  \+ hall
unwanted_place(hallo).  %%  \+ hall(Eng,destroys lang. selction)
unwanted_place(halvto). 
unwanted_place(happens).  %% hagen(amble#)
unwanted_place(hasj). 
unwanted_place(havren).  %% \+  havnen
unwanted_place(heder).  %% \+  peder
unwanted_place(hege).  %% \+  hage
unwanted_place(hello).  %% \+  Hell
unwanted_place(help).  %% \+  Hell
unwanted_place(hem).  %% hjem,not hoem
unwanted_place(hembres). %% \+ Hambros %% TA-101111
unwanted_place(heng).  %% \+hegg
unwanted_place(henge).  %% \+hemne
unwanted_place(henger). %% \+ Hanger(åsen) 
unwanted_place(henne).  %% \+ Hemne 
unwanted_place(hermer).  %% helmer??OK?
unwanted_place(hoel).  %% hotel/hoem
unwanted_place(home).  %% \+  Hoem
unwanted_place(homo).  %% \+  Hoem
unwanted_place(homse).  %% \+  Holms
unwanted_place(hor).  %% \+Horg
unwanted_place(hora).  %%  \+ Horg
unwanted_place(hore).  %% \+  hare
unwanted_place(horegata).  %%  \+ Hareveien
unwanted_place(horegaten).  %% 
unwanted_place(horen).  %%  \+ Horten
unwanted_place(horene).  %%  \+ Horten %% 
%% unwanted_place(huseby).  %% Husby/Husebysenteret huseby skole?? 
unwanted_place(hv).  %% \+  av,dv(prob. hva?)
unwanted_place(hval).  %% \+  Hal
unwanted_place(hve).  %% \+  eve
unwanted_place(hvor).  %% \+  horg(probleminEnglish)Syndrome
unwanted_place(høns).  %% \+  Hans
unwanted_place(i).  %% \+  is(gen)
unwanted_place(ida).  %% (not ila)
unwanted_place(is).  %% \+  ii

%% unwanted_place(ishall).  %% \+ishallen

unwanted_place(jeb).  %%  \+ jeg
unwanted_place(jev).  %%  \+ jeg
%% unwanted_place(kampen).  %%  \+ Kammen no longer
unwanted_place(kapre).  %% \+  karse. 
unwanted_place(karsk).  %% \+  karse. . 
unwanted_place(king).   %% (Burger)King--->Kina
unwanted_place(kinoen). %% -> noun cinema 
unwanted_place(kjærest).  %%  \+ kjærems
unwanted_place(kjønn). 
unwanted_place(kl).  %% 
unwanted_place(knudsen).  %%  \+ Knausen
unwanted_place(knuse).  %%  \+ kuset
unwanted_place(knutsen).  %%  \+ Knausen
unwanted_place(kolla).  %% \+  Folla
unwanted_place(komen). 
unwanted_place(kor).  %%  -kors(EngSyndrome)
unwanted_place(kors).  %%  \+  kors/gata
unwanted_place(kos).  %%  \+  kors
unwanted_place(kose).  %%  \+  kors
unwanted_place(kråke). 
unwanted_place(ku).  %%  \+ KO. . . . 
unwanted_place(kuk).  %%  (not krk)(badwordsshallberepelled)
unwanted_place(kunst).  %%  \+ kuset
unwanted_place(kyr).  %%  \+  kor(korsvegen???)
unwanted_place(kåt).  %%  (Not KVT)
unwanted_place(laden).  %%  -lade//OsamaBinLaden
unwanted_place(laks). 
unwanted_place(lande).  %% lade
unwanted_place(langt).  %% \+Liangata###(Eng)
unwanted_place(lego).  %%  \+ Lege
unwanted_place(lei). 
unwanted_place(leke).  %% (ikkeLege)
unwanted_place(lene).  %% ikkeLege
unwanted_place(lerk).  %% (not Ler)
unwanted_place(lisa).  %%  \+ Lia
unwanted_place(lisp).  %% liaslies
unwanted_place(litn).  %% \+Lian
unwanted_place(lives).  %% ikkeLies//DestroysLangSelection
unwanted_place(lla).  %% IlaorLia?
unwanted_place(lua).  %% \+  lia
unwanted_place(luka).  %%  \+ Luna
unwanted_place(lykke).  %% Løkke
unwanted_place(lære).  %% (not Være)
unwanted_place(løgn).  %%  \+ Lønn(vei)
unwanted_place(mad).  %% \+  May <----not place,but ok
unwanted_place(mads). 
unwanted_place(mai).  %% not main %% should be taken by lex
unwanted_place(mail). 
unwanted_place(mandag).  %% \+  Mandal Eng. 
unwanted_place(mari).  
unwanted_place(maria). %% \+ marka 

%%%% unwanted_place(martin). %% \+ marinen %% kregness 

%% not allowed as destination, allowed as (part) name 

unwanted_place(martine).
unwanted_place(masa). 
unwanted_place(maur).  %% mars DOESNT HELP unwanted_name
unwanted_place(meg). 
unwanted_place(melllom). 
unwanted_place(mens). 
unwanted_place(mensen).  %% 
unwanted_place(meny).    %% moen#
unwanted_place(mogen).   %% (morgen?,not Moen)
unwanted_place(moms). 
unwanted_place(mona).  %%  \+ Moen
unwanted_place(mongolid).  %% mongolioid/mongolia
unwanted_place(mons).  %%  \+ Moen
unwanted_place(morten).  %% \+  Horten
unwanted_place(mp3).  %% \+  m3(filformat)
unwanted_place(mr). 
unwanted_place(må).  %% mo,m1
unwanted_place(mår).  %% \+  vår(fruekirke)
unwanted_place(møkka).  %%  \+ mekka
unwanted_place(møllen).  %% Møllrnberg/Møller
unwanted_place(narko).  %% \+nardo(?)
unwanted_place(nek).  %% \+  nrk
unwanted_place(ner).  %% \+  Ler,probablynår
unwanted_place(nerd).  %% (not nord)
%% unwanted_place(nissen).  %%  \+ Nissens. . . %% TA-110328
unwanted_place(nr). 
unwanted_place(nr1).  %% (not nrk)
unwanted_place(nrå). 
%%  unwanted_place(ntnui).  %% idrettsbygget? \+ ntnu?
unwanted_place(nuss).  %% buss/Næss
unwanted_place(nåre).  %% \+  Åre
unwanted_place(nåt).  %% (not nt)
unwanted_place(nør).  %% \+  sør,probablynår. 

%%% unwanted_place(o).  %% \+osveien(SIC) %% st o hospital 

%% unwanted_place(oasen). %% \+ Osen (station) 
unwanted_place(og).  %% \+  og,vg,ono(s)veien|g(aten)
unwanted_place(okse).  %% \+osen
unwanted_place(ondes).  %% \+  Osnes
unwanted_place(ost).  %% \+  Os
unwanted_place(osv).  %% \+Osv(eien)

%%% unwanted_place(oth).  %% \+  NTH, not short name for Othilienborg? 

unwanted_place(pakk). 
unwanted_place(palm).  %% \+  paul
unwanted_place(pi).  %% (not på,pir,ii etc)
unwanted_place(pinsen). 
unwanted_place(plage).  %% \+  place
unwanted_place(prins).  %%  \+ paris###
unwanted_place(pul).  %% \+  Paul%NB all dirty words shall be repelled
unwanted_place(pule).  %% \+  Paul
unwanted_place(pult).  %% \+  Paul
unwanted_place(pål).  %% avoid pål=på,give message
unwanted_place(radmann).  %%  \+ rådmann
unwanted_place(ran).   %% \+  Roan
%% unwanted_place(rema).  %% "REMA" is not Rena %%-> generic
unwanted_place(rian).  %% \+  Roan
unwanted_place(rik).   %% \+  RIT
unwanted_place(ril).   %% \+  RIT(//til)
unwanted_place(rio).   %% \+  RIT
unwanted_place(ris).   %% \+  RIT
unwanted_place(rita).  %% RIT/Rota(RitaOttervik)
unwanted_place(road).  %%  \+ roan
unwanted_place(roar).  %%  \+ roan
unwanted_place(roger).  %%  \+ rognergate
unwanted_place(rompa).  %%  \+ Roma %% all expletives
unwanted_place(rompe).  %%  \+ Rome %% shall be framed
unwanted_place(ronke). 
unwanted_place(ronker).  %% \+Rogner-veien
unwanted_place(ronket).  %% 
unwanted_place(rope).   %%  \+ rype
unwanted_place(rot).    %%  \+ rota
unwanted_place(roten).  %%  \+ Rosten
unwanted_place(runke).  %% 
unwanted_place(runker). %% 
unwanted_place(runket). %% 
unwanted_place(rute). 
unwanted_place(ryte).   %% rute?, \+ rye  \+ rate
unwanted_place(salg).   %% \+sag
unwanted_place(salme).  %% svale(v)amble#
unwanted_place(samlev). %% old station, \+ svaleveien
%% unwanted_place(sands).  %%  TA-not sande,not Dr. sandsvei 
unwanted_place(satan).  %%  \+ santa(barbara)
unwanted_place(saus).   %%  \+ SAS
unwanted_place(seile).  %%  \+ Selje
unwanted_place(selve).  %%  \+ Selje
unwanted_place(sex).    %%  \+ Sem
%% unwanted_place(shell).  %%  \+ spell mix with Hell 
unwanted_place(simen).  %% \+ Siemens .. er simen stygg? 
unwanted_place(sion).   %%  \+ simon
%unwanted_place(sirkus). %%  \+ sirius  %% RS-130120 Sirkus Shopping
unwanted_place(sist).   %%  \+ Wist
unwanted_place(sjansen).%%  \+ Skansen 
unwanted_place(sko).    %% 
unwanted_place(skrue).  %% \+
unwanted_place(skumle). %% \+skule
unwanted_place(skyttrerveien). 
%%  unwanted_place(sola).  %% \+sollia,solia  
unwanted_place(solen).     %% \+  Polen
unwanted_place(spank).     %% \+spania
unwanted_place(spare).     %% \+stare
unwanted_place(sprit).     %% \+  sport
unwanted_place(spurt).     %% \+  (Hank)Sport
unwanted_place(stand).   %% \+Sande
unwanted_place(staven).  %% \+Stavne
unwanted_place(stien).   %% \+Skien
unwanted_place(stiller). %% \+ Tiller
unwanted_place(stine).   %% \+ Stene %% TA-110228
unwanted_place(stop).    %% \+ stor-
%% unwanted_place(stranda). %%  \+ strinda 
unwanted_place(street).  %% Lang Ambig
unwanted_place(strøm).   %% \+storm
unwanted_place(stut).    %% \+ stud
unwanted_place(stående). %% \+ Stene 
unwanted_place(sug).     %% \+ Sig. 
unwanted_place(sum). 
unwanted_place(suppen).  %%  \+ sluppen
unwanted_place(syklen).  %%  \+ skolen
unwanted_place(sæ).      %%  \+ st
%% unwanted_place(sætre).   %% \+ sætres/stare %% foreign 
unwanted_place(søren).   %% \+ støren
unwanted_place(søt).     %% \+  sør
unwanted_place(søvn). 
unwanted_place(ta).     %% \+ tt,ts
unwanted_place(tank).   %% \+ thanks 
unwanted_place(tanke).  %%  \+ tanem
unwanted_place(tell).   %% dialect,not Hell
unwanted_place(th).     %% Trondh? \+ TT
unwanted_place(the).    %% don'tspellchecktothe
unwanted_place(thor).   %%  \+ Torp
unwanted_place(thr).    %% the, \+ chr,tr,etc. 
unwanted_place(tid). 
unwanted_place(tier).   %% ikke tiur
unwanted_place(tim).    %% \+ Sim
unwanted_place(time).   %% \+ Time kommune 
unwanted_place(ting). 
unwanted_place(tio).    %% \+ to
unwanted_place(tl).     %% \+ TT,probably til
unwanted_place(tnt).    %% \+ TT
unwanted_place(tom).    %% \+ Lom,tog
unwanted_place(torsk).  %% \+ Tors'vei
unwanted_place(torvet). %% name of station going inwards
unwanted_place(tosk).   %% (ikke tysk)
unwanted_place(tp).     %% \+ TT,probably to
unwanted_place(tra).    %%  \+ fra/-trøa
%% unwanted_place(trade).  %%  \+ trane 
unwanted_place(tram).   %%  \+ Trøa (SIC)
unwanted_place(transe).  %%  \+ tranev
unwanted_place(trynet).  %%  \+ Tynset(SIC)
unwanted_place(trøng).  %%  \+ trøa-vegen(trø(n)a-g) %% amble#
%% unwanted_place(tuller).  %%  \+ Tiller %% nein 
unwanted_place(ture).   %% \+ Tiur-vegen
unwanted_place(tviler).%%  \+ Tiller
unwanted_place(twin).  %%  \+ Tine
unwanted_place(tåsk).  %%  \+ tysk
unwanted_place(tøff).  %%  \+ KØFF
unwanted_place(urdu).  %%  \+ Urds vei
unwanted_place('va|ret').  %% \+ Være  
unwanted_place('va¦ret').  %%
unwanted_place(valg).  %%  \+ vang
unwanted_place(veien). %%  \+ viken
unwanted_place(verb). 
unwanted_place(verdt).  %%  \+ verft
unwanted_place(vere).  
unwanted_place(verst). 
unwanted_place(verste). %%  \+ vestre
unwanted_place(vestlig).%%  \+ vestlia 
unwanted_place(vet).    %%  \+ vest(E:)
unwanted_place(vinkel). %%  \+ vikelv
unwanted_place(vodka).  %%  \+ volda
unwanted_place(volvo).  %%  \+ volve-
unwanted_place(vre).    %%  \+ Være
unwanted_place(world).  %%  \+ wolds
unwanted_place(yrke).   %%  \+ York
unwanted_place(øre).    %%  \+ øvre

%%%%%%%  9940 %%%%
