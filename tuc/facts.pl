/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE facts.pl
%% SYSTEM tuc
%% CREATED  TA-921129
%% REVISED  TA-110707

%  Static Facts for common sense .
%  Common to all applications
%  Facts are deliberately kept separate from semantics

%% cr isa character. %% TA-110303 ako

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Static Facts for common sense .
%  Common to all applications
%  Facts are deliberately kept separate from semantics

:- ensure_loaded( '../declare' ).       %% RS-111212 :-op( 710,xfx, isa ).
%:- use_module( '../main', [ myflags/2 ] ).
%
%%% RS-111205, UNIT: tuc/
%:- use_module( evaluate, [ fact/1 ] ).
%:- use_module( lex, [ unproperstation1/1  ] ).
%:- use_module( names, [ abroad/1, city/1, country/1 ] ).
%:- use_module( semantic, [  adj_templ/2, (ako)/2,  (has_a)/2,  iv_templ/2, tv_templ/3  ] ).
%:- use_module( tuc:world0, [ area/2 ] ).
:-ensure_loaded( tuc:world0 ).
%
%%% RS-111205, UNIT: app/
%:- use_module( '../app/busanshp', [ description/2 ] ).
%:- use_module( '../app/buslog', [ station/1 ] ).

%% RS-111205, UNIT: db/
:- use_module( '../db/busdat', [ vehicletype/2, xforeign/1 ]).
% %:- ensure_loaded( '../db/regbusall' ). %, [ nightbus/1, regbus/1 ] ). %% HEAVY DB? RS-120803
%:- use_module( '../db/places', [
%        isat/2, placestat/2, underspecified_place/1, unwanted_place/1 ]).
%:- use_module( '../db/teledat2', [ building/1, is_dom_val/5 ] ).
%:- use_module( '../db/regcompstr', [ composite_road/3 ] ).
:-ensure_loaded( '../db/regcompstr' ).

%:- use_module( '../db/regstr', [   streetstat/5 ] ). %% RS-111201 Remember to update source program, which is makeaux?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

jonas isa firstname.
follesoe isa lastname. %% http://jonas.follesoe.no
follesø isa lastname.  %% experiment / spammer
%% no isa country.     %% TA-101129 nå

appstore isa system. %% TA-110707
api   isa system. %% ? %% TA-110120
c isa (mark). %% special dep in bus leaflet

1939 isa telephone.
%% 1939 isa phonenumber. 

color_line isa boat. %% TA-110614

%% lars_mo isa man.      %% Team  %% TA-110120
%% rune isa man. %% ad hoc demo 
%% magnus isa man. %% collides with Magnus den godes gate
%% johanne isa woman. %% Team   %%
%% kristian isa man. %% LingIT 

'busstuc.lingit.no' isa ipaddress.  %% ? ip?

'http://www.atb.no' isa webaddress. %% TA-101115
'www.atb.no' isa webaddress.        %% 
'www.google.no' isa webaddress.  
'www.klaburuten.no' isa webaddress.
'www.tkort.no' isa  webaddress.     %% TA-101115
'tkort.no' isa webaddress.
'tmn.no' isa webaddress.    



access isa system.

amazon isa computer.  %% (Amazon Machine Image)
amazon isa system.    %%   AMI

ami  isa system.      %%  (computer) 

dns  isa  system.   
explorer isa system.  %% IE
facebook isa system. 
firefox isa system.   %% 
opera  isa system.  
payex  isa system.  
safari  isa system.  
twitter isa system.  
ebit isa system. 
excel  isa system. 
hastus isa system. 
ikt    isa system.     %% TA-110114
skype  isa system.     %% TA-110301
wikipedia isa system.  

%% regtop isa  format. %% confuse

mac  isa computer. 

%% lizza isa woman.  %% Lizza: buss ned - full av fulle franskmenn...

gps isa system. 

dvi isa form. %% dvi file

forel  isa form. %%  FOREL code 

%% turings_test isa test. %%  :-) -> noun 

'C++' isa  programminglanguage. 

%% idi isa neighbourhood. %% unnec  %% TA-110401

idi isa neighbourhood. %% nec for .. nearest station mess.
idi isa department. %% Ad Hoc// tagger problem

dis isa department.    %% rough (section)

may17  isa date. 

førsteamanuensis isa title. %%  tele

pink isa colour. %% only noun, experiment

ja  isa answer.
nei isa answer.

ok isa answer. %% Haz?

%% yes isa answer. %% this makes no sense = it makes 'no' at Stene
%% no  isa answer.

chess   isa game. 
football isa game.
%% harald  isa king. 


anna isa robot. %% Anna på IKEA
ruth isa robot. %% Teams buss oracle
sara isa robot. %% Sara på 1881 opplysningen

hal     isa computer. %%  2001 :-)

marvin      isa robot.  %%  :-)
marvina     isa robot. 

acura isa car. %% J&M 

%% wumpus isa monster. %% :-) AIMA %% ako

tuc     isa savant.   
%%%  tuc     isa program.  

% busstuc isa program. 
bustuc  isa program.  
buster  isa program. 
smstuc  isa program.
telebuster isa program. 

%% busstuc isa program. %% nec to capture busstucs' 

irc     isa program. %%  :-)
msn     isa program. %% 

%  internet isa network.  %% Changed to noun, to internet syndrom, 

X isa tram:-  
    vehicletype(X,tram). %% busdat.pl

%%%%%%% Trouble

atb isa company. 
fara isa company. %% TA-110303

gråkallbanen    isa tram.  
gråkallbanen    isa otherbus. 

pondus  isa driver. %% :-) 

tbanen          isa underground.  %%  (non existent)


visa  isa card.  
mastercard isa card. %%
%% gardermoen isa airport. %% yes, but foreign 
værnes     isa airport.

the_hitchhikers_guide_to_the_galaxy isa book.  %%  :-)

ais  isa company. %%   Artificial Intelligence Solutions

narvesen isa company. %% sell tickets %% TA-100122
seven_eleven isa company. %% 

sørtrøndelag  isa county.  
lingit  isa company. 


brannvesenet isa company. %%   110
brann      isa company.   %%   110
politiet   isa company.   %%   112
ambulanse  isa company.   %%   113

nettbusskonsernet  isa company.
nettbuss  isa company. % confuse otherbus ?? %% TA-100209

%% nsb isa company.  %% problems ? // confuse TS %% TA-101215

%% vinmonopolet isa company. %%  :-) %% -> undersp place
stfk isa company.  %% Sør-Trøndelag fylkeskommune %% TA-100113
team isa company. 
tkf isa company.   %% Trøndelag Kollektivtrafikk %% ?
tkt isa company.   %% Trøndelag Kollektivtrafikk %% ?
tt isa company.    %% Trondheim Trafikkselskap (old)
tmn isa company.   %% Trafikanten MN 

%% telenor  isa company. %% creates commit error
netcom   isa company. 

dovreekspressen isa otherbus.
expressbuss     isa  otherbus. 
fosenbussen     isa otherbus.
frostabussen    isa otherbus.
fylkesbilane    isa otherbus.
gauldal_billag  isa otherbus. %% company. 
helsebussen     isa otherbus. 
hemnebussen     isa otherbus. 
hob             isa otherbus. %% company. 
hobbuss         isa otherbus. %% same
klæburuten     isa otherbus. %% company.      %%   klæburuten går lørdag ? 
lavprisekspressen isa otherbus. 
regionalbusser isa otherbus.
%% vassfjellbussen      isa otherbus. %% by synname 

melkeruten     isa otherbus. %% :-) %% TA-100130
møreekspressen isa otherbus. 
mørelinja      isa otherbus. 
mørelinjen     isa otherbus. 
nettbuss       isa otherbus.
nettbussen     isa otherbus.  
nettbussene    isa otherbus. 
orkangerbussen isa otherbus.  
orkdalsbussene isa otherbus.
sbmtd          isa otherbus. %%v Santa Barbara
skibussen      isa otherbus. %% (skistua? 10?)
sørlandsekspressen isa otherbus. %% TA-100130
timekspressen  isa otherbus. 
timeekspressen  isa otherbus. 
timesekspressen  isa otherbus. 
timeexpress   isa otherbus. 
timexpressen   isa otherbus.  
timeekspress   isa otherbus.   %% ETC 
timeekspressbuss   isa otherbus. 
trysilbussen   isa otherbus. 
trønderbanen   isa otherbus. %%  ( special NSB)
trønderbilene  isa otherbus. 
ventelo        isa otherbus. %% TA-100409
veolia         isa otherbus. 

østerdalsekspressen  isa  otherbus. 
østerdalsbussen  isa  otherbus. 

microsoft isa company. %%  :-(


christmas_day isa date. 
christmas_eve isa date. 
little_christmas_eve isa date. 

%% christmas     isa date. 

easterday isa date.  
eastereve isa date.  

midsummer_day isa date. 
midsummer_eve isa date.
midummer      isa date. 

whitsun_day isa date. 
whitsun_eve isa date. 
whitsun     isa date. 


vernal_equinox isa date.
autumnal_equinox isa date.
summer_solstice isa date. %% TA-100106
winter_solstice isa date.



palm_sunday isa date.
maundy_thursday isa date. %%  NB correct, not monday
good_friday  isa date.  

% langfredag   isa date. 
% skjærtorsdag isa date. 
% kristi_himmelfartsdag isa date. %%  (ascension_day)

john_f_kennedy_day  isa date. 
oddvar_brå_day isa date.  
arvid_holme_day isa date.
dooms_day  isa date. 


ascension_day isa date.
new_years_eve isa date.  
new_years_day isa date. 
%% vinterferien  isa date.         %%  ( skip translation) %% vacation

skolestart  isa date.  %% Norsk 
skoledager  isa date. 

%% hurtigruta isa boat.  %% Shadows Pirterminalen

%% hovedkontoret isa office.  
rikstrygdeverket  isa office.  %% leg handicap %% TA-100122

% god       isa    animate . % :-) 

%% christmas  isa time.  

earth  isa    world.      

equator             isa    geo_metric.            %% 
north_pole          isa    geo_metric.            %%
south_pole          isa    geo_metric.            %%
tropic_of_capricorn isa    geo_metric.            %%
tropic_of_cancer    isa    geo_metric.            %%
greenwich_line      isa    geo_metric.
date_line           isa    geo_metric.

%%%%%%%%%%%%%%%%

%%i isa self.        %% hvem er jeg  
%% NB  "is" becomes genitive of i

'I' isa self. %% Internal name 

sone1 isa zone.
sone2 isa zone.
sone3 isa zone.
%...

%% web   isa network. %% Technical:  web address 


tore_amble isa man :- \+ value(teleflag,true).

trond_engell isa man :- \+ value(teleflag,true). %% TE-120215

arvid_holme isa man :- \+ value(teleflag,true). 

john    isa man :- \+ value(teleflag,true).    % belongs to every world :-)   -> Johan etc

mary    isa woman :- \+ value(teleflag,true).  % needs some persons for testing

dave    isa man :-  \+  value(teleflag,true).  % 2001  :-)
  

%% bob     isa man.     % (Jurafsky)


(tore,amble) isa programmer :- %% Experiment
    \+  value(teleflag,true). 

(douglas,adams) isa author :-  \+  value(teleflag,true). 


bill_gates isa programmer.  %% (  :-) 

eliza isa woman. %% :-)  

turing isa man. 


tagore isa programmer.
%% tagore isa man.  

Y isa year :- 
    number(Y),
    \+ value(busflag,true),
    Y >0, Y =< 9999.



january   isa  month .
february  isa  month .
march     isa  month .
april     isa  month .
may       isa  month .
june      isa  month .
july      isa  month .
august    isa  month .
september isa  month .
october   isa  month .
november  isa  month .
december  isa  month .


%% country information moved to country.pl

% country(Country,
%         Region,
%         Latitude,
%         Longitude,
%         Area (sqmiles),
%         Population,
%         Capital,
%         Currency)

X isa country:-
    country(X).

%% google   isa  god. %% :-) %%% 

chrome   isa system. %% TA-110520
google   isa  system. 
google_maps   isa  system. 
linux   isa  system.  %%  (not program like TUC :-)
unix    isa  system.
windows isa  system.  %% :-( 
vista   isa  system.  

X  isa city :- city(X). %%  busdat.pl 


sør isa direction. 
nord isa direction.
vest isa direction.
øst isa direction.



%% marvin    isa mayor. %%  :-)

arabic    isa  language. 
bosnisk   isa  language. 
danish    isa  language. 
english   isa  language. 
finnish   isa  language. %% (\+ finsk)
french    isa  language. 
german    isa  language.
greek     isa  language.
gresk     isa  language.
mysql     isa  system.    %% (language?)
norwegian isa  language.
nynorsk   isa  language. % no translation :-) 
bokmål    isa  language.
samisk    isa  language. % no translation
spansk    isa  language.
spanish   isa  language. 
% svensk    isa  language.  
% svenska   isa  language.  %%

swedish   isa  language. %%
tyrkisk      isa  language. 
tysk      isa  language. %% transl. ? 
urdu      isa  language.

sicstus   isa  language.
sql       isa  language.
unix      isa  language.

%% c         isa  programminglanguage.  %% reppeveien 108c  confuse
cobol     isa  programminglanguage. 
fortran   isa  programminglanguage.
java      isa  programminglanguage. 
lisp      isa  programminglanguage. 
perl      isa  programminglanguage.
prolog    isa  programminglanguage.
python    isa  programminglanguage. 
smalltalk isa  programminglanguage. 

ip        isa  network.   %% NO, but must have sth
%%  www       isa  network. 

X isa nightbus :-
    nightbus(X).   %% busdat 

X isa route :- 
    regbus(X). %% tt/regbusall (bus thoug maybe no deparures now) 
%%%       exbus(X).   %% External busname 


X isa route :- 
    value(tmnflag,true), 
    X isa tram.


X isa station :-
	 value(busflag,true), %% \+ dater
    station(X),                %%  Semantically, not actual
    \+ xforeign(X),             %%   ( adjust database error)  
    \+ unwanted_place(X),       %%   ( adjust database error) 
    \+ unproperstation1(X).     %%   ( stations with no passings)
                                 %% maybe empty 

%%  \+ tramstation(X).         %% NO ILA is both


X isa house :- 
    building(X). %% teledat2.pl


/**********

X isa tramstation :- 
% 	 value(tramflag,true),  
    tramstation(X).           %% E.G LIAN  know about it to give errm
                          
*/




X isa neighbourhood :-  
    value(busflag,true), %% \+ dater 
    neighbourhood(X). 


X isa street:-
%%%%     composite_road(_,_,X), %%  Beddingen
    streetstat(X,_,_,_,_). %% Extra check (Mauritz Hansens gt)
  

X-Num isa street:-
    atom(X),
    composite_road(_,_,X),
    number(Num),
    streetstat(X,_,_,_,_). 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Testclass moved as a last option 

X isa Y :-   
    Y==time,!, % dont make any number a time  
    number(X),
    X < 2500. 

X isa number :- %% Only generated if X is nonvar  
    number(X).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% Section for TELEPHONE DIRECTORY

tore isa firstname.  %% Just to have a proper name
amble isa lastname.  %%

trond isa firstname. %% TE-120215
engell isa lastname.

ketil isa firstname.
bø    isa lastname.

arvid isa firstname.
holme isa lastname.

staupe isa lastname.

agnar isa firstname.
aamodt isa lastname.


jon       isa firstname.
bratseth  isa lastname. %% jon 



Tor isa firstname :- %% jarle hermansen  // jarle both firstname and lastname
    teleoption, %% value(teleflag,true),                %% prefer jarle as firstname first
    is_dom_val(person,firstname,Tor,_,_).


Amb isa lastname :- 
    teleoption, 
    is_dom_val(person,lastname,Amb,_,_).

Gore isa middlename :- 
    teleoption, 
    is_dom_val(person,middlename,Gore,_,_).


Ygg isa street :- 
    teleoption, 
    is_dom_val(person,street,Ygg,_,_).


Trond isa city :- 
    teleoption, 
    is_dom_val(person,city,Trond,_,_).

Hist isa department :-  
    teleoption, 
    is_dom_val(person,department,Hist,_,_).

teleoption :- 
   value(telebusterflag,true)
   ;    
   value(teleflag,true).  

%% see teledat2.pl %% 



neighbourhood(X):- 
    neibor(X);
    abroad(X); 
    xforeign(X). 

neibor(X):-   
     (isat(_,X);                     
      nostation(X) ;  
      unproperstation1(X) ; %% recognised as neighbourhood (feature)  
      %% maybe empty

      placestat(X,_) ;
      underspecified_place(X)). 
      %% \+ unwanted_place(X).  %% unwanted_place means unwanted target


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
%%   H A V E   Predicate (Meta predicates)

have(thing,class,X,Y):-
    fact(X isa Y).

have(_,description,X,Y):-
    description(X,Y). 

have(_,area,X,Y):-
    area(X,Y).

have(_,attribute,X,Y):-  X has_a Y .

have(_,identity,X,X).

have(_,subclass,X,Y):- Y ako X.

have(_,superclass,X,Y):- X ako Y.

have(_,subject,X,Y):-
    iv_templ(X,Y);
    tv_templ(X,Y,_);
    adj_templ(X,Y).

have(_,object,X,Y):- 
   tv_templ(X,_,Y).

%% have(team,stadium,brann,brann_stadion). %% Eksempel //deflag := true.

/* SUSPENDED %% TA-100335

% Geography

have(country,capital,X,Y):- 
    country_capital(X,Y).

have(country,currency,X,Y):- 
    country_currency(X,Y).

have(country,latitude,X,Y):-
    country_latitude(X,Y).

have(geo_metric,latitude,X,Y):-
    geometric_latitude(X,Y).

have(country,city,X,Y):-
    city_country(Y,X).

have(country,longitude,X,Y):-
    country_longitude(X,Y).

have(geo_metric,longitude,X,Y):-
    geometric_longitude(X,Y).

have(country,population,X,Y):-
    country_population(X,Y).

have(country,river,X,Y):-  
    country_river(X,Y).

have(country,size,X,Y):- 
    country_area(X,Y).

have(city,population,X,Y):-
    city_population(X,Y).

have(city,size,X,Y):- 
    city_population(X,Y).

have(continent,country,X,Y):- 
    contains4(continent,country,X,Y).

*/



%%% ETC    GENERALIZE!

   
% % % % % % % % % % % % % % % % % % % %


precedent_firstname(Tor) :-
	value(tags,Tags),
	precedent_firstname(Tags,Tor).

precedent_firstname([[Tor,firstname]|_],Tor).

precedent_firstname([First|Rest],Tor) :-
	\+ First = [Tor,lastname],
	precedent_firstname(Rest,Tor).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  Moved from busdat 
%%  Nightbuses

nightbus(103). 
nightbus(104).
nightbus(105).
nightbus(106).
nightbus(107).
nightbus(108).
nightbus(109).
nightbus(119). 
nightbus(136).
nightbus(146).
nightbus(148).
nightbus(149).
nightbus(154).
nightbus(155).
nightbus(175). 
nightbus(188).
nightbus(1301).


%¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
