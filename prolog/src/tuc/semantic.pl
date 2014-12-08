/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE semantic.pl
%% SYSTEM TUC
%% CREATED TA-921129
%% REVISED TA-110825

%  TUCs  Lexical Semantic Knowledge Base
:-module( semantic, [ a_compl/4, abnormalverb/2, adj_templ/2, adjname_templ/2, adjnamecomp_templ/3, adjnoun_templ/2, adjnouncomp_templ/3,
        ako/2, aligen2/2, align1/2, coher_class/3, dtv_templ/4, gradv_templ/2, ( has_a )/2, %% == has_a/2 RS-131228  For fernando.pl
        iv_templ/2, jako/2,  measureclass/1, n_compl/3, ordinal/2, pai_templ/2,  particle/3, post_adjective/1,       %% RS-131225    Down Town etc.
        pvi_templ/2, rv_templ/2, stanprep/2, subclass/2, subclass0/2, superclass0/2,     %% RS-140921    From fernando.pl
        testclass/1, tv_templ/3, v_compl/4,  vako/2      %% RS-131225    Necessary?
] ).

:- use_module( '../declare', [ ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .

%UNIT: /tuc/
% :- use_module( facts, [ isa/2 ] ).       %% RS-131225    Necessary?

%:- use_module( fernando,[ subclass0/2 ] ).

:-discontiguous( [ (ako)/2, (has_a)/2, a_compl/4, adj_templ/2, iv_templ/2, rv_templ/2, tv_templ/3, v_compl/4 ] ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Metagoric:  metonym for the information about something

%%  Verbs are normal unless they are abnormal

% % % % % % % % % % % % % % % % 


superclass0(X,X).
superclass0(X,Z):-
    X ako Y,
    superclass0(Y,Z).


subclass0(X,Y):- 
    X=Y;
    subclass(X,Y).

subclass(X,Z):- % go upwards (preferred)
    nonvar(X), % var(Z),
    X ako Y,
    subclass0(Y,Z).

subclass(X,Z):-
    var(X),nonvar(Z),
    Y ako Z,
    subclass0(X,Y).

% % % % % % % % % % % % % % % % % % % % % % %

normalverb(V,_):- \+ abnormalverb(V,_),!.  % normal if not abnormal at all
normalverb(V,T):- abnormalverb(V,U),\+ subclass0(T,U).

%% ABNORMALVERB   EventLess (Static) verbs etc

abnormalverb(cost,_).  
abnormalverb(be_named,_).  %%   EventLess
        abnormalverb(describe,agent).
%%%% abnormalverb(die,god).     %% just to have 1
abnormalverb(have,_).      %% ha feil feil(aktig)

    abnormalverb(use2,_).     %%  NB No inheritance   (abnormalverb(use2,bus) tc.

%% NEW RELATION   jako (hyponym of adjectives) 

jako(best,good).
jako(popular,good).
jako(earlier,early).

jako(smokefree,clean).

%% NEW RELATION    vako  (hyponym of verbs).
%% sorted on hypernym. Only one level inheritance.

vako(exist,be1).        %%

vako(bicycle,go).    
vako(come,go).          %% 
%% vako(run,go).           %% time goes but duration doesnt %% TA-110530 
vako(sail,go).          %% hvem kan seile foruten vind
vako(travel,go).        %% 
vako(walk,go).          %% 

vako(murder,kill).      %%

vako(leave2,leave).     %% nec? 

vako(reach,pass).       %% I reach an appointment

vako(kjøre_v_rel,run).  %% OMNITUC 

vako(propose,tell). 




%% tv_templ(Verb,Agent,nil). %% allows  Agent Verb <something>
%%  jeg rapporterer (noe)
%% NB NOT ***  huset brenner <->  huset brenner noe NB <--***

%% Internal words are kept in British English spelling.

% Semantic net is assumed to be consistent, i.e. loopfree and complete.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Classes that shall not generate instances

%%   Only exact match, no inheritance

%% aso   a set of  (not implemented) ("bunch of") 

unkn            ako    thing. %% agent ? place ?

event           ako    thing. %% generic for event/ 

testclass(person).  %% <=== NB

testclass(age).         
%% testclass(area). %% Geographic        
testclass(count). %% of
%  testclass(departure).
testclass(frequency). 
testclass(identity).    
testclass(latitude).    
testclass(longitude).   
testclass(measure). 
testclass(moment). 
testclass(number).       
testclass(place). 
testclass(population).  
testclass(situation).   
testclass(size).
testclass(speed). 
testclass(statement). %% ??
testclass(string).    
testclass(thing).
%  testclass(time).  %%   <-- KEINE EXPERIMENTE (exception)
testclass(weight). 



% CLASSES THAT ACT AS MEASURES, THOUGH NOT OF CLASS MEASURE 

       measureclass(cent).
       measureclass(crown).
       measureclass(day).
       measureclass(halfhour).
       measureclass(hour).
       measureclass(kmh).   %% speed 
       measureclass(kilometer). %% TA-110429
       measureclass(meter).
       measureclass(mile).   %% TA-110429
       measureclass(minute).
       measureclass(money). 
       measureclass(month).
       measureclass(noon).    %%   12 noon \= quant
       measureclass(percent). 
       measureclass(quarter).
       measureclass(second).
       measureclass(temperature). 
       measureclass(time_count). 
 %%       measureclass(week). %% ad hoc, mer enn 3 uker = count
       measureclass(year).



% Noun Compatibility Section
% Which objects of incompatible classes can be matched
% This is in a replacement of a multiple inheritance system


% Measures  classes (M) are implicitly defined by align(M,number).



%% COHERENCE_CLASS  

%% give a class to a composite NP of things that dont belong together
%% to avoid  nounclass = thing which is not allowed.
%% NOT Symmetric .   %% TA-101022
%% Inheritance (?)   %%

coher_class(abstract,information,abstract).

coher_class(bicycle,dog,luggage). %% these together in the context of luggage

coher_class(bus,company,bus). 

coher_class(city,condition,condition).

coher_class(question,condition,question). %% TA-110707

coher_class(correction,name_recognition,correction). %% TA-110707
coher_class(name_recognition,correction,correction). %%


%% coher_class(departure,price,information). %% TA-101018 priser og busstider fra røros

coher_class(error,text,error).

coher_class(error,word,error). %% ad hoc skrivefeil og dialektord

coher_class(font,colour,font).  

coher_class(information,version,information).  %% jeg Trenger   utgave  og  ruteinformasjon.
coher_class(information,system,information). 
coher_class(information,station,information). 

coher_class(interface,program,system).  
coher_class(interface,consistency,system). %% TA-110725

coher_class(route,information,information).  
coher_class(route,price,information).   

coher_class(station,map,information).   %% 

coher_class(street,vehicle,traffic). %% TA-100908 %% buss munkegt ***

coher_class(map,station,information).   %% ? 
%%%%%%%%%%% coher_class(route,station,information). %% rute dragvoll %% TA-101006

coher_class(oracle,departure,oracle). %% bussorakelet og busstidene er feil 
coher_class(oracle,route,information). %% not synchronous 
coher_class(oracle,map,oracle). 

coher_class(price,ticket,price). 

coher_class(savant,bus,bus).
coher_class(ski,luggage,luggage). 

coher_class(station,departure,data). 

coher_class(telephone,webaddress,address). %% ? 

coher_class(time,transfer,departure). 
coher_class(universe,life,life).

coher_class(webaddress,sms,address).       %% ? 

coher_class(traffic,vehicle,traffic). 

coher_class(route,destination,information). %% on bus 
%%% coher_class(_,_,information). %% Ad Hoc %%  tider priser og trase 
%%    RUTETILBUDET skjærtorsdag:


% with vars

/* %% TA-110325 østensjø ring : 
     ringroute neighbourhood ---> information neighbourhood
coher_class(_C,information,information).
coher_class(information,_C,information).
*/

coher_class(C,modification,C).
coher_class(C,rest,C).   %% busser og resten av ruter 
coher_class(C,variant,C).  


%% General Alignment with inheritance
%% symmetric, only 1 necessary (alphabetic)

aligen2(answer,vehicle). 

aligen2(area,thing).  

aligen2(basis,system).  

aligen2(cause,thing).    %%  alt kan være en årsak

aligen2(condition,thing). %% infrastrukturen for  by og  miljø://*** disamb

%% aligen2(company,vehicle). %% team bus \= team isa bus 

aligen2(coevent,question). 

aligen2(description,thing).

aligen2(example,thing).

aligen2(item,thing). %% neste punkt %% TA-110707

aligen2(neighbourhood,thing). 

aligen2(number,vehicle). %% (-> ALIGNABLE

aligen2(part,thing).


%%%%%%%

%% ALIGN1  

%% NO DEFAULT INHERITANCE HERE

%% called symmetrically, only one way is necessary 
%% Should be sorted alphabetically, 
%% The first alphabetically as first argument

align1(answer,thing).  %% TA-110107 svaret var "Bingo"

align1(abstract,coevent). 
align1(activity,coevent).

align1(answer,coevent).  


align1(account,number).

%% align1(adult,program). %% ??? man or woman = adult 

align1(address,neighbourhood). %%
%% align1(address,station).    %% Moholt adresse -> Moholt har adresse
align1(address,street). 

align1(adult,savant). %%  joinclass(boy,girl,adult) SIC %% 
align1(adult,self). 

align1(age,number). 

align1(agent,part). %% ad hoc 

%% align1(airbus,neighbourhood). %% Flybussen værnes (AD HOC)
%%   NOT flybussen lade %% TA-100630

align1(amount,money). 
align1(amount,number). 

align1(answer,departure).    %%  svaret er en bussavgang
align1(answer,number). 

align1(arrival,clock). 
%   align1(arrival,station). %% first arrival sentrum gets wrong 
%  ...

align1(author,adult).     
align1(author,student).     %%  :-)


align1(boy,savant).        %% just to allow the question 
align1(boy,self). 

align1(bus,colour).         %% what colour IS a bus 
align1(bus,departure).      %% which bus is the last (possiblity)
align1(bus,number).         
align1(bus,route).          %% subtle  (stations in route 9)  %%
                            %% obsolete if route ako bus

align1(bus,tram).           %% bus 2
align1(bus,type).           %% hvilke typer busser

align1(card,solution).   %% e.g. everything 
align1(cause,problem).   %% TA-110708


align1(centre,name).  %% generally
align1(christmas_day,number).

%% align1(clock,departure).  %% avgang fra NTH  kl 1300 %% Destroys and no help
                          %% departure clock syndrome  ==> nil_compl %% EXPERIMENT
% er det avganger kl 17 fra nth

align1(clock,hour).       %% klokka er en time ??? 
align1(clock,start).      %% with start 1000
align1(clock,number).  

align1(code,number).

align1(coevent,activity).  
align1(coevent,experience). 
align1(coevent,irony).      %%  :-\
align1(coevent,policy).     %% 
align1(coevent,problem). 
align1(coevent,project). 
align1(coevent,sentence).   
align1(coevent,solution).  

align1(company,agent). 
align1(computer,person). 
align1(computer,program).
align1(computer,programmer). 
align1(computer,savant).
align1(computer,self).      %% no inh. 
align1(company,service).   
align1(company,shop).   
% align1(computer,type). 

align1(crown,money).        %% -> aligen2
align1(crown,number).       %% No Inheritance
align1(crown,payment). 
align1(crown,price).        %% necessary ?

align1(customer,user). 

align1(data,program). %% i.e. datamaskin,TUC 

align1(date,route_plan). %% 1. mai er en søndagskjøring 

align1(daycode,number).
%% align1(day,number).  %%   Om 3 dager *

align1(date,holidaydayroute).
align1(date,sundayroute).  %% er 17 mai en søndagsrute.
align1(date,saturdayroute). 

align1(departure,route). %% avgang 36 
align1(departure,bus). 
align1(departure,tram). 



align1(destination,neighbourhood). 
align1(destination,station).  

%%% align1(direction,neighbourhood). %% lerkendal retning sentrum 
align1(direction,route). 
align1(direction,route_plan). %% er rute 36 den beste veien

%%%  align1(direction,station).  %% lerkendal stadion  retning sentrum 

  %%% otto nilsens vei -> otto nilsensv vei  -> the direction ONV ???
                                               
align1(driver,man). 
align1(driver,self). 
align1(driver,woman).
align1(driver,savant). %% tuc --> no 

align1(employee,program). %% :-) %% er du (en) ansatt i tt
align1(employee,programmer). %% :-) Tagore 
align1(employee,self). %% :-)

align1(endstation,station).
align1(enemy,program).
align1(enemy,self). 

align1(error,coevent).   
align1(errormessage,coevent). %% dette problem 

align1(father,self). %% etc 
align1(floor,number).  %% 3. etage
align1(fool,program).
align1(fool,savant).   
align1(fool,self). 
align1(footnote,number). 
align1(friend,program).     %%  :-) % technically (unix)
align1(friend,savant).   
align1(friend,self).

align1(genious,program).    %%  :-)
align1(genious,programmer). 
align1(genious,self).       %%  :-)

align1(girl,savant).        %%  :-) 
align1(girl,self). 
align1(god,agent).          %%  :-)

align1(halfhour,number). 
align1(host,person).   
align1(hour,number).

align1(integration,solution). %% ad hoc (gen!) 

align1(king,man).
align1(kmh,speed).

align1(mail,sentence).      %% (Ad hoc) My email is 'toreamb@idi.ntnu,no'
align1(man,program).
align1(man,programmer). 
align1(man,savant).
align1(man,self).


align1(map,solution).   

align1(meaning,number).     %%  :-)
align1(member,thing).
align1(minute,number).   
align1(money,number).       %%  (10 crowns \= 1 coins)

align1(name,neibourhood). 
align1(name,place).
align1(name,program).  %% navnet ditt
align1(name,programmer).    %%  (special) 
align1(name,savant). 
align1(name,sentence).      %%  ( quotes)
align1(name,station).       %% Metagoric 
align1(name,street).  

align1(neighbourhood,station).
align1(neighbourhood,zone).

align1(nightbus,number).  
align1(nightbus,route). 

align1(number,postbox).  
align1(number,price).
align1(number,quarter).  
align1(number,room).  
align1(number,route). 
align1(number,speed). 

align1(number,saturdayroute). 
align1(number,sundayroute).   %% søndagsrute 4

align1(number,speed).  
align1(number,subscription).
align1(number,telephone). 
align1(number,time).         %% time 1300 
align1(number,time_count).   %% NOF times
align1(number,tram). 
align1(number,vehicle).
align1(number,weight).
align1(number,week). 
align1(number,year). 
align1(number,zone).  

align1(oracle,person).
align1(oracle,self). %% no inherit 
align1(oracle,program).
align1(oracle,savant).
align1(oracle,version). 

%% align1(part,person). %% vi er en del av -> aligen2

align1(programmer,teacher). %% no sidewise inheritance(!) 
align1(project,savant).


align1(origin,station).  

align1(owner,person).

align1(passenger,person). 
   align1(passenger,student). %% etc
 
%% align1(part,speech_recognition). %% etc etc %% Ad hoc). unnec

align1(person,savant). 
align1(person,trafficplanner). %%
align1(person,program).     %% just to allow the question
align1(person,programmer). 



align1(program,driver). %% tuc --> no 
align1(program,project).
align1(program,robot). 
align1(program,savant).  
align1(program,service). 
align1(program,version).    %%  Hvilken versjon er du ?
align1(program,woman). 
align1(programmer,savant).
align1(programmer,self). 



align1(robot,savant). 
align1(route,tram). 

align1(route,route_plan). 

% align1(route,sundayroute).   %%  er det s.rute 24 (mai)


align1(savant,self). 
align1(savant,service). 
align1(savant,trafficplanner). 
align1(savant,version).    %%  Hvilken versjon er du ?
align1(savant,woman). 


align1(self,student). 
align1(self,teacher). 
align1(self,user). 
align1(self,woman). 

align1(sentence,word).  %% the word 'bus' 

align1(station,street).  %% holdeplass fykenvegen (street -> fykenborg)
                        

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% CLASS HIERARCHY

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   stratified, alphabetic 

% ako      subclass
% has_a    has attribute



%-LEVEL 0 ----------------------------------

% thing is the top

    thing          has_a  beginning.  
    thing          has_a  cause. 
    thing          has_a  class.
    thing          has_a  consistency. %% TA-110707
    thing          has_a  description.
    thing          has_a  end.        
    thing          has_a  existence.
    thing          has_a  example.
    thing          has_a  future. 
    thing          has_a  identity.   
    thing          has_a  location.  %% TA-101230
    thing          has_a  property.
    thing          has_a  purpose.   %% TA-110607
    thing          has_a  quality. 
    thing          has_a  shape.     %% general %% TA-110615
    thing          has_a  standard.  
    thing          has_a  subset.
    thing          has_a  validity. 

%-LEVEL 1 ----------------------------------

coevent  ako thing. %% event ?

set ako thing. 
    set            has_a  cardinality. 
    set            has_a  qualification.
    set            has_a  member.

item          ako     thing.

member        ako     thing.

amount        ako     thing. %% amount of work = work


    
% % % % % % % % % % % % % % % % % % % % % % % % % % % % %

abstract        ako    thing.

account         ako    thing. 

activity        ako    thing.   % to make/do an activity 
    activity        has_a  date.
    activity        has_a  time.  
    activity        has_a  possibility. 

addition        ako    thing. %% generic

agent           ako    thing. 

    agent           has_a   firstname. 
    agent           has_a   middlename.
    agent           has_a   lastname.

    agent           has_a  accident.       %% (qua company)
    agent           has_a  account. 
    agent           has_a  activity.       %% Mye å gjøre
    agent           has_a  address.  
    agent           has_a  advice.  
    agent           has_a  age. 
    agent           has_a  airbus. 
    agent           has_a  alcohol. 
    agent           has_a  answer. 
    agent           has_a  arrival. 
    agent           has_a  aunt. %% for trytofool

%%     agent           has_a  beer. %% -> have (own) 
    agent           has_a  bicycle.
    agent           has_a  birthday. 
    agent           has_a  boss.   %% unoff.
    agent           has_a  leader. %% (boss)
    agent           has_a  boat. 
    agent           has_a  boat_route_plan.



    agent           has_a  brain.          %% ( = memory)
    agent           has_a  brother.
    agent           has_a  car.     %% jeg vil ha en bil til...
    agent           has_a  card.           %% qua TT company
    agent           has_a  child.  
    agent           has_a  christmas.
    agent           has_a  christmasroute. 
    agent           has_a  city. %% byen vår 
    agent           has_a  coffee. 
    agent           has_a  correction. %% i.e. spell corr.. 
    agent           has_a  crown. 
    agent           has_a  clock.

    agent           has_a  computer. %% not every agent
    agent           has_a  email.    %% TA-110622
    agent           has_a  mind. %% consciousness. 
    agent           has_a  creator. 
    agent           has_a  daughter. 
    agent           has_a  day.  
    agent           has_a  departure. 

    agent           has_a  destination.  
    agent           has_a  startingpoint. 

    agent           has_a  discount.  
    agent           has_a  dog. %% man = agent/person
    agent           has_a  domain.         %% eg bus departures 
    agent           has_a  driver.         %% (qua TT representative)
    agent           has_a  enemy. 
    agent           has_a  error. 
    agent           has_a  expectation.  
    agent           has_a  family.         %%   ( eg person :-)
    agent           has_a  file. 
    agent           has_a  friend. 
    agent           has_a  father.         %%  :-) 
    agent           has_a  feeling.        %%  ( eg person :-)

    agent           has_a  gasbus.         %% (qua company)
    agent           has_a  genious.  %% a genius ???      %% Deep:  din luring :-)))
    agent           has_a  god. 

    agent           has_a  health. 
    agent           has_a  help.  %%  (e.g. i need your help)
    agent           has_a  homepage.
    agent           has_a  husband. %% ? 
    agent           has_a  interest.  
    agent           has_a  idea.
    agent           has_a  indulgence. 
    agent           has_a  information. 
    agent           has_a  overview.
    agent           has_a  intelligence. 
    agent           has_a  job. 
    agent           has_a  knowledge. 
    agent           has_a  life.           %% ( :-)
    agent           has_a  list. 
    agent           has_a  luck.          %% :-) ?  
    agent           has_a  badluck.       %% Norw  uflaks 
    agent           has_a  lunch.          
    agent           has_a  lust.           %% ha lyst på (Norwagism)

    agent           has_a  mail.           %%  ( mail address)
    agent           has_a  mailaddress.    %% email
    agent           has_a  management.    
    agent           has_a  map. 
    agent           has_a  may17route. 
    agent           has_a  meaning.        %% =opinion 
    agent           has_a  message. 
    agent           has_a  meeting.
    agent           has_a  memory.  
    agent           has_a  midnight.       %% du får ha en GN
    agent           has_a  mobile.         %% no. 
    agent           has_a  mood.           %%  (spirit ?)
    agent           has_a  mother.         %%  :-)

    agent           has_a  name. 
    agent           has_a  neighbourhood. 
    agent           has_a  night. 
    agent           has_a  nightbus. 
    agent           has_a  noon.           %%  Tricky lunch -> noon/meal 
    agent           has_a  notification.  
    agent           has_a  number.         %%  Phone

    agent           has_a  opening_hours. 
    agent           has_a  opinion.
    agent           has_a  oracle. 
    agent           has_a  otherbus. 

    agent           has_a  page.  
    agent           has_a  passenger.      %% (qua company)
    agent           has_a  parent.         %% (no inheritance).
    agent           has_a  permission. 
    agent           has_a  picture. 
%     agent           has_a  plan.         %% collides with route_plan  
    agent           has_a  policy.  
    agent           has_a  postaddress.    %% NON email
    agent           has_a  price.          %%  (qua bus company representative)
    agent           has_a  printer. 
    agent           has_a  problem. 
    agent           has_a  project. 
    agent           has_a  proposal. 
    agent           has_a  question. 
    agent           has_a  relation. 
    agent           has_a  relative. 
    agent           has_a  request.        %% ønske 
    agent           has_a  right.   
    agent           has_a  route. 
    agent           has_a  route_plan. 
    agent           has_a  spouse.    
    agent           has_a  saturdayroute. 
    agent           has_a  sundayroute.  
    agent           has_a  seat.           %%  (person)
    agent           has_a  service. 
    agent           has_a  servicecenter. 
    agent           has_a  sister.  
    agent           has_a  smoke. 
    agent           has_a  sms.  
    agent           has_a  speed.          %% I am faster than you
    agent           has_a  street.  %% Norw har kort vei
    agent           has_a  subscription. 
    agent           has_a  summerroute.    %% NB No inheritance in has_a 
    agent           has_a  system.  
    agent           has_a  service.  
    agent           has_a  station.        %% qua TT
    agent           has_a  talk. 
    agent           has_a  task.
    agent           has_a  taxi.  
    agent           has_a  telephone. 
    agent           has_a  ticket.  
    agent           has_a  time.           %% har du tiden på bussen ?
    agent           has_a  train. 
    agent           has_a  train_route_plan. 
    agent           has_a  tram. 
    agent           has_a  tram_route_plan.
    agent           has_a  transfer. 
    agent           has_a  trip.           %%  jeg vil ha en tur
    agent           has_a  uncle. %% for trytofool 
    agent           has_a  universe.       %% :-) 
    agent           has_a  use. 
    agent           has_a  vacation. 
    agent           has_a  visit.          %%  my visit
    agent           has_a  way. 
    agent           has_a  webaddress.     %% web page
    agent           has_a  weekend. 
    agent           has_a  wife.           %% ?
    agent           has_a  word.           %% i.e. vocabulary

alternative     ako    thing. %% TA-110228 confuse way (måte)

base            ako    thing.

care            ako    abstract. %% ta vare på %% TA-110815

chance          ako    abstract. %% sjanse

contact         ako    thing.  %% person/appliance/abstract/... ?
content         ako    thing.
copy            ako    thing.
course          ako    thing. 
    course          has_a     department.
    course          has_a     year.
%     course          has_a     size.

creation        ako    activity. 

definition      ako    abstract. 

effect          ako    abstract. 

wish            ako    abstract. %% a wish %% TA-101124

group           ako    thing.
identity        ako    thing.  
information     ako    thing.   
    information     has_a format. 
    information     has_a  source.
    information     has_a  version.
%%     information     has_a  footnote. %% -> have 

interest        ako    abstract. 

list            ako    thing.     
mass            ako    thing.     %% => stuff

measure         ako    thing.
    measure         has_a  decrease. 
    measure         has_a  size.
    measure         has_a  length. 

meta            ako    thing.   % lexical object 


object          ako    thing.   %% class.  
       object       has_a  age. 
       object       has_a  colour. 
       object       has_a  weight.
       object       has_a  length.
       object       has_a  height.
       object       has_a  safety.
       object       has_a  size. 

%% part            ako    place.  %% syndrome part is generic 
                                  %% du må være en av delen
part            ako    thing.    

place           ako    thing.
       place        has_a   address. 
       place        has_a   name. 
       place        has_a   opening_hours. 
       place        has_a   postcode. %% rough 
       place        has_a   webaddress.     
       place        has_a   station.   %% (station,neighb,..)
       place        has_a   telephone.
       
       place        has_a   latitude. %%  ?
       place        has_a   longitude.%%
      
%% river           ako    thing.    %% (water but no area) %% -> place

rest            ako thing. %% actually generic rest of X=X

%% step            ako    abstract. 

story           ako    thing.

study           ako    activity. 

subset          ako    thing.

suspicion       ako    abstract. 

%% version         ako   abstract. 
version            ako   system.  
    version         has_a   management.
    version         has_a   number.    %% ????????
    version         has_a   distribution.

cardinality   ako  number.
qualification ako  abstract.
reference     ako  abstract.


%-LEVEL 2 ----------------------------------


access          ako    abstract. %% TA-110429 tilgang

area            ako    place. %% not measure %% TA-100908

company         ako    agent.       %%   e.g. TT 
    company         has_a  address. 
    company         has_a  age.       %%  :-)
    company         has_a  articulated_bus. %%  (leddbuss) 
    company         has_a  lowentry_bus.  
    company         has_a  boss.     %% unoff
    company         has_a  leader.  
    company         has_a  bus.      %%  NO inheritance 
    company         has_a  card.     %% etc. qua issuer
    company         has_a  computer. 
    company         has_a  departure. 
    company         has_a  discount. 
    company         has_a  driver.    
    company         has_a  easterroute. 
    company         has_a  employee.
    company         has_a  flexibus. 
    company         has_a  gasbus.     %%  awkard, here inheritance is OK 
    company         has_a  homepage. 
    company         has_a  interface.
    company         has_a  minibus. 
 
    company         has_a  holidayroute.
    company         has_a  mailaddress.  %% email ?
    company         has_a  minibus.
    company         has_a  number. 
    company         has_a  office.
    company         has_a  postaddress. 
    company         has_a  price. % on ... 
%%     company         has_a  route.  %%  EXPERIMENT
%%     company         has_a  route_plan. 
    company         has_a  sale.
    company         has_a  service. 
    company         has_a  station. 
    company         has_a  summerroute. 
    company         has_a  sundayroute. 
    company         has_a  saturdayroute. %%
    company         has_a  telephone. 
    company         has_a  vehicle. 
    company         has_a  webaddress. 
    company         has_a  whitsunroute. %% etc, chrM/easter 
    company         has_a  winterroute. 

%% company         ako    place. %% NB also agent |Deliberately
%% take 47 klæburuten -> \+ take (route) 47 (to) klæburuten (qua place)

    company         has_a   luggage. %% hittegods-kontor 

ability         ako    abstract. 
accident        ako    activity. 
acquisition     ako    activity. 
activation      ako    activity.  %% start of it
%% addition        ako    abstract. %% thing
address         ako    place.  
advice          ako    abstract. 
    
age             ako    year.  %% (measure)  
agreement       ako    abstract. 


ambiguity       ako    abstract.

%% air             ako    place. %% kan bussen gå i lufta ? 
analysis        ako    abstract.

animate         ako    agent.  
    animate         has_a  head.
    animate         has_a  ear. 
application     ako    activity. 

approval        ako    activity.  

%% area            ako    measure.      %% geography 
argument        ako    abstract.
arrival         ako    activity. 
arrow           ako    object.
attempt         ako    activity. 
attention       ako    abstract.

bank            ako    company. %%  & place ?
bar             ako    place.
beard           ako    object.  %%  :-#)
bed             ako    place.   %% placoid
beginning       ako    part.
bicycle         ako    vehicle. %% EXPERIMENT object. / using bicycle
                                %% take on the bus / take to NTH
(block)           ako    object.
bodypart        ako    object.

foot            ako    bodypart. %% ?? //by foot
bookcase        ako    object.
border          ako    place. 
bottom          ako    place.  %% part ??
box             ako    object. 
brain           ako    object.
brake           ako    object.  

case            ako    abstract.
cause           ako    abstract. 
ceiling         ako    place.
centre          ako    place.
chair           ako    object. 
change          ako    activity. %%  = transfer
choice          ako    abstract. 
claim           ako    abstract.

cinema          ako    place. 
circuit         ako    abstract.
class           ako    set. 
cleaning        ako    activity. 
clothing        ako    object.  
colour          ako    abstract.  %% attribute.  %% NO WORD !
communication   ako    abstract. 
comparison      ako    abstract. 
competition     ako    activity. 
complexity      ako    measure.

condition       ako    abstract.
consideration   ako    abstract. 
consistency     ako    abstract. %% riktighet %% TA-110707
connection      ako    abstract. 
connector       ako    circuit.
consciousness   ako    abstract.
control         ako    activity.  %% abstract ?
corner          ako    place.
correction      ako    activity.
   curiosity       ako    feeling. 
currency        ako    meta.          

decrease        ako    measure.      
definition      ako    abstract.
delay           ako    abstract. 
    delay           has_a  size. 
demonstration   ako    activity.
departure       ako    activity. 
    departure          has_a  departure. %% sic 
%%     departure       has_a  footnote. %% rough %% -> have
    departure       has_a  frequency. 

decision        ako    activity.

destination     ako    place.
detail          ako    part. %% rough
development     ako    activity. 
dialogue        ako    activity.
difference      ako    measure.  %% abstract ????
direction       ako    place. %% abstract. 
directory       ako    place.     
     directory      has_a  name. 
distance        ako    measure.       
distribution    ako    abstract.

document        ako    information.            
    document        has_a  date.
    document        has_a  version. 
  
domain          ako    abstract. 
door            ako    object.


education       ako    activity. 
efficiency      ako    abstract.
end             ako    part.          
entertainment   ako    activity.
environment     ako    abstract. 

equipment       ako    system. %% e.g. camera %% object. 
error           ako    activity.
    error          has_a  connection. 
%%     problem        has_a  connection. %% ako error
    error          has_a  source. 

estimate        ako    measure.


example         ako    abstract. %%  (difficult ?)
exhaust         ako    gas. %% but not "fuel" ad hoc 
existence       ako    abstract.  
expectation     ako    abstract. 
expert          ako    agent.
extension       ako    name.    

family          ako    agent.  %% aso  a set of, rough 
fault           ako    abstract.
feature         ako    abstract.
feeling         ako    abstract.      
field           ako    information.
file            ako    object.
    file            has_a  name.        
    file            has_a  extension.   
    file            has_a  accessright. 
%    file            has_a  line.       
    file            has_a  content.
    file            has_a  date.
    file            has_a  field.
    file            has_a  heading.
    file            has_a  type.
    file            has_a  version.

floor           ako    place. 
food            ako    object. 

footnote        ako    information.

forehead        ako    object.
 
forgery         ako    activity. 

form            ako    information. %% abstract. %% skjema  %% often misspelled for from  

format          ako    information. %% regtop-
formalism       ako    abstract.

frequency       ako    measure. 

enemy          ako    person. %% TA-91102

friend          ako    person. %% agent. %% :-) 
% Syndrome  A friend is on a bus ==> person is on bus ==> coercing!

game            ako    activity.
gas             ako    fuel. 
generalisation  ako    abstract. % version ?

geo_metric      ako    place. %% common   name for equator, poles       
    geo_metric      has_a  latitude.    % 
    geo_metric      has_a  longitude.   % 

goal            ako    activity.      
god             ako    agent. %% :-) abstract. % a god

group           ako    set.

% gun             ako    object. % weapon

habit           ako    abstract.

hand            ako    object.

harbour         ako    place. 

head            ako    object.
header          ako    object.        

health          ako    abstract.

heap            ako    place.     
    heap            has_a   cloth.  %% ( object and subclasses )

heart           ako    object.       
    heart           has_a valve.

height          ako    measure. 

help            ako    activity. 
hold            ako    abstract. 
home            ako    place.        
    home            has_a    address.  
    home            has_a    telephone. 
    
hope            ako    abstract.

homepage        ako    information.
honour          ako    abstract. 

horsepower      ako    measure. 
host            ako    agent.

identification  ako    information. 

ignorance       ako    abstract.

import          ako    activity. %% innleggelse 

indication      ako    abstract. %% information ? 

introduction    ako    activity.

idea            ako    abstract. 
implementation  ako    activity. 

inspiration     ako    abstract. 

installation    ako    object. %% building? %% TA-100908

intelligence    ako    abstract.  %% :-)
integration     ako    activity.  %% ?
interview       ako    activity.


iphone          ako  smartphone.     %%
    smartphone      ako    telephone. %% TA-110725

informationcentre  ako agent. 
irony              ako abtract. 


job             ako    activity. %% place. %% activity. %% jeg går jobb *

%% journey         ako    activity.  %%  --> trip

kilometer       ako    distance. %% measure.  %% TA-110427
meter           ako    distance.
mile            ako    distance.
         
 
kind            ako    abstract. 
%% kiss            ako    activity. %% TA-110520 :-(
kmh             ako    speed. 


knob            ako    object.
knowledge       ako    information.


label           ako    mark. %% information. 

lack            ako    abstract. 
landmark        ako    neighbourhood. %% SIC bus world
language        ako    abstract.     
    language        has_a  grammar.
latitude        ako    measure.      

location        ako    place. %% TA-101230

mind            ako    abstract. 
motorcycle      ako    vehicle.



lack_of_space   ako    space. %% sic

lap             ako    bodypart. %% på fanget
leg             ako    bodypart. %% /on leg  

length          ako    measure. 
lesson          ako    information.
letter          ako    information. % ambiguous 
life            ako    time.  %% abstract
	 life            has_a  meaning. % :-)
light           ako    abstract. % physical weightless
limit           ako    measure.
liquid          ako    mass. 
load            ako    measure. %% overbelastning ?
location        ako    place. %% smaller 
log             ako    data. 
longitude       ako    measure.      
%% love            ako    activity. %% :-)))
luggage         ako    object.  

% machine         ako    place. %% syn computer
mail            ako    information. 
    mail            has_a  identification. %% rough postvesenet
map             ako    picture. 
match           ako    activity.
meaning         ako    abstract. %% number. % :-)
    meaning         has_a  question.   % :-)
meeting         ako    activity.
    meeting         has_a host. 
    meeting         has_a place. 
memory          ako    abstract. 
meter           ako    measure. 
method          ako    abstract.  %%  ( = way ???)
mile            ako    measure.  
mobile          ako    telephone. %% number. 
(mode)            ako    abstract.
modification    ako    activity. %%  = av ruteplaner etc.
monster         ako    agent. 
motor           ako    object.   %% engine ???
movement        ako    activity.
movie           ako    information. %% place. % cinema hall 

name            ako    word. %% meta.  Navnet Danmark

necessity       ako    abstract. 
need            ako    abstract. 
negation        ako    abstract.  %% meta ?  :-)
neighbourhood   ako    place. 

%%  neighbourhood   has_a  bus. %% Fredrikstads busser %%
%%  // når går bussen til fredrikstad
    neighbourhood   has_a  centre. 
    neighbourhood   has_a  location. %% place. 
    neighbourhood   has_a  computer. %% special, NTNU sin server 
    neighbourhood   has_a  size.  
    neighbourhood   has_a  zip.  
    neighbourhood   has_a  zone. 

    neighbourhood   has_a  station. %% holdeplassen til Nardo ? %%  HAZ? 
                                     
network         ako    system. %%  thing. %% I find a picture on the internet// system?

news            ako    information.

nonsense        ako    sentence. %% abstract. 

number          ako    measure.
    number          has_a  endstation. 

office          ako    place.      
    office          has_a  manager.
    office          has_a  meeting. %% julebord 
    office          has_a  opening_hours. 
    office          has_a  telephone.

oil             ako    fuel.

operation       ako    activity. 

operator        ako    agent. 
opinion         ako    abstract.  

optimalization  ako    activity. 

oracle          ako    program.   %% agent. 
    oracle          has_a     bus.       %% qua TT 
    oracle          has_a     otherbus.  %% qua TT 

order           ako    abstract. %% //NB, rekkefølge bestilling %% rough

organisation    ako    company. %% or vv ??
origin          ako    place. 
oversight       ako    abstract.
overview        ako    information. 

page            ako    information. %% e.g. home page
payment         ako    activity.  
percent         ako    measure. 
permission      ako    abstract. 
petrol          ako    fuel. %% UK 
picture         ako    information. 
    picture               has_a  colour. %% TA-101210
plan            ako    information. %% abstract. %% collides with route_plan 

plant           ako    object.
planet          ako    place.

pocket          ako    place. 
policy          ako    abstract. 
position        ako    place.
possibility     ako    abstract.
power           ako    abstract.
pram            ako    wheelchair. %% object. 

presentation    ako    activity.
  
printout        ako    information. %% (?) 

problem         ako    error. %% abstract %% feil og problemer (vv?)  
    problem         has_a  source.

procedure       ako    activity. 

producer        ako    company. %% leverandør 

property        ako    abstract.

praise          ako    phrase.    
   criticism          ako    phrase. %%

promise         ako    phrase. 

proposal        ako    phrase. %% abstract. 

protection      ako    meta.

purpose         ako    abstract.

quality         ako    measure.  %%  ( Technical )

queue           ako    place.

rank            ako    meta. 
reason          ako    coevent. %%%% abstract
reference       ako    abstract.  
relation        ako    abstract. 
repair          ako    activity.
responsibility  ako    abstract.

restaurant      ako    place. 
%% road            ako    place. %%  Street 
restriction     ako    abstract. %% TA-110419

right           ako    abstract.    %% rett til skyss 
river           ako    place.
robot           ako    agent.  
roof            ako    place. 
room            ako    place.  
    room            has_a  number.
root            ako    abstract.

%% ! in som sense, a route is a set of vehicles
route           ako    vehicle. %% Technical solution %%% <- - NB NB Tram etc
%%     route           has_a      bus. %% hvilken rute har buss 5 
    route           has_a      distance. %% TA-100908
    route           has_a      frequency.
    route           has_a      map. 
    route           has_a      number. 
    route           has_a      route_plan.
%%     route           has_a      station. %% << vehicle 
    route           has_a      saturdayroute. 
    route           has_a      sundayroute.   %% 
    route           has_a      time. 
    route           has_a      webaddress. 

route_plan      ako    information. %% summer routes/winterroutes
    route_plan      has_a  webaddress. 

school          ako    place.  
search          ako    activity. 
seat            ako    object. %% placoid
sequence        ako    set. 
service         ako    activity. 
    service         has_a number.  
    service         has_a telephone. 
sound           ako    abstract.
standard        ako    abstract. 
start           ako    activity. 
startingpoint   ako    place.
storage         ako    place. 
strategy        ako    abstract. 
strike          ako    activity.  
success         ako    abstract. 
superagent      ako    agent.  %% Technical term
%% swimmingpool   ako    place. %% Should be name 
service         ako    activity. 
%  sex             ako    meta.    %% dirty :-)
side            ako    place. 
situation       ako    abstract. 
size            ako    measure.
skeleton        ako    abstract.     
ski             ako    object.
sky             ako    place.     %%  :-)
smoke           ako    activity.  %% (?)
smoking         ako    activity.  
solution        ako    abstract.
song            ako    activity.
snowploughing   ako    activity. %% GBR 
space           ako    place.
    space          has_a  room.    %% Telebuster 
    space          has_a  office.  %% hvor (hva) er (romnummer til) utgangen
specification   ako    information. %% rough   
speed           ako    measure.
spot            ako    object.
    spot            has_a  colour.
%% start           ako    departure.  %% ( too bus specific ?)   

stability       ako    abstract.
%% statue          ako    object. %% landmark 
stone           ako    object.
stop            ako    activity.
structure       ako    abstract. 
summary         ako    meta.     
surface         ako    place.  

%% switch          ako    circuit.

system          ako    agent.
    system          has_a  administrator. %% Tagore 
    system          has_a  clock. %% also captures   har du klokke 
    system          has_a  date.
    system          has_a  feature.
    system          has_a  file.
    system          has_a  hardware.  
    system          has_a  information.
    system          has_a  interface.
    system          has_a  load. 
    system          has_a  module.
    system          has_a  release.
    system          has_a  version.

tail            ako    object. 
talk            ako    activity. 
task            ako    activity. 
travelinsurance ako    abstract.  
taxi            ako    vehicle. 

timetable      ako    information. %% rutehefte 

transfer        ako    activity. 

trip            ako    activity.  
%    trip            has_a   cost. 
    trip            has_a   price.
    trip            has_a   destination.
    trip            has_a   distance.   %% TA-100909
    trip            has_a   origin.
    trip            has_a   direction.
    trip            has_a   length.
    trip            has_a   arrival.  %% -time
    trip            has_a   departure.%% -time    
    trip            has_a   tourtype.

teacher         ako   person. %%  tele

team            ako    group.     
    team            has_a  country. 

terminal        ako    machine.     %% also  bus-
test            ako    activity.

tour           ako    activity. 
    tour            has_a   tourtype. %% TA-101008

tourtype       ako    information. %% TA-101008

phonenumber ako telephone.   

%%%%  ¤ telephone   ako phonenumber.  %%    SMOKETEST 



sense           ako    feeling. %% TA-110114

shape           ako    abstract. %% how is your day = shape of day

strap           ako    object. 

telephone       ako system. %% TA-110527

telephone       ako    number. %% object.  % what is a phonenumber
    telephone       has_a    number. 

% telephone    ako system. %% NB ambiguous

telescope       ako    object.
temperature     ako    measure. 
text            ako    information.
theory          ako    abstract.
ticket          ako    object.
    ticket          has_a  price.
tissue          ako    object.   %% ?
top             ako    place.
toy             ako    object.
tunnel          ako    street. %% TA-110114 (place)

traffic         ako    activity.
transfer        ako    activity. 
transformation  ako    abstract.    %%  TA-110503 ?
truth           ako    abstract. 
turtype         ako    information. %% TA-101008 ?
type            ako    meta.         


underground         ako    vehicle. %% TA-101115
universe        ako    place. % Or object? or abstract?
	 universe        has_a  age.  %% :-) 
    universe        has_a  meaning.  

university      ako    place. 

update          ako    activity. %% \+ version ? 

use             ako    activity. 

vehicle         ako    thing. %% EXPERIMENT %% TA-110309
                              %%  object. %% i.e. traffic line 

    vehicle         has_a  arrival. 
    vehicle         has_a  brake.  
    vehicle         has_a  christmasroute.
    vehicle         has_a  colour. %% TA-110606 (vehicle no longer object)
    vehicle         has_a  delay. 
    vehicle         has_a  departure. 
    vehicle         has_a  door. 
    vehicle         has_a  endstation. 
    vehicle         has_a  driver. 
    vehicle         has_a  frequency. 
 %    vehicle         has_a  label.     %%  number
    vehicle         has_a  lowentry.  
    vehicle         has_a  label.  
    vehicle         has_a  mark.  
    vehicle         has_a  modification. %% ruteendring
    vehicle         has_a  motor. 
    vehicle         has_a  name. 
    vehicle         has_a  number.  
    vehicle         has_a  passenger. 
    vehicle         has_a  price. %% i.e. fare
    vehicle         has_a  return. 
    vehicle         has_a  roof. 

%%     vehicle         has_a  route. 
                       %%   HAZARD  bus (that) has (number 8)=route
                       %% bytte fra (rute 5 til rute 8)
    vehicle         has_a  route_plan. %%  (not route)
    vehicle         has_a  place. %% i.e. seat hvilke plasser har bussen.
    vehicle         has_a  seat. 
    vehicle         has_a  size.   
    vehicle         has_a  speed. 
    vehicle         has_a  startingpoint.
    vehicle         has_a  station. %% TRICKY  route has_a station  sounds better ,
                                    %    but route ako vehicle !
    vehicle         has_a  time.  
    vehicle         has_a  time_count. %% togets gang ad hoc 
    vehicle         has_a  trip. %% togets gang ad hoc 
    vehicle         has_a  departure. %% når har siste 9 ...
    vehicle         has_a  weight. 

way             ako    direction. %% abstract. %%  "the best way to.."// direction?

weapon          ako    object.

detour          ako    way.  

weather         ako    abstract. 
weight          ako    measure.
wheel           ako    object.
wheelchair      ako    object. 
%% window          ako    object.   %%  i bussen?       
window          ako    place.    %% in the window
wire            ako    object.          %% circuit ??
workstation     ako    machine.      

zone            ako    place.    %% (NOT abstract), border for zone ...
    zone    has_a   size. 

%-LEVEL 3 -------------


airplane_arrival ako arrival.   
airplane_departure ako departure.  

animation       ako     system. %% face animation 
application     ako     system.

auditory        ako     room. 

bar             ako      room.  

broadband       ako     system.  

browser         ako     system.  


camera          ako     equipment.  %% TA-110121
chaos           ako     situation.  %% :-)

chip            ako     food. %% pl chips

concert         ako     meeting.  
confusion       ako     error.
corridor        ako     space. 

pizza           ako     food. 
sausage         ako     food. 

behaviour       ako     (mode). 

font            ako     format. 

front           ako     side. 
back            ako     side.

happiness       ako     feeling. 

headache        ako     feeling. %% illness?

ice             ako     weather. %% iset
icecream        ako     food. 

interest        ako     feeling. 

eastside        ako    side.
northside       ako    side.
southside       ako    side.
westside        ako    side.

key             ako    text. %% e.g. 'A'

left            ako    direction. 
right           ako    direction. 


zip             ako     number.
title           ako     text. % ?
phonetype       ako     abstract.
extrainfo       ako     text.
%% hiddenflag      ako     text.


adult           ako     person.
    adult           has_a   baby. 
    adult           has_a   child.   
    adult           has_a   daughter. 
    adult           has_a   son.      

agelimit        ako    age. 

alternative     ako    route.  %% VERY SPECIAL

appointment     ako    meeting. 

airport         ako    neighbourhood.

alcohol         ako    drink. 

animal          ako    animate. %% and object 
    animal          has_a  tail.

answer          ako    statement.

attachment      ako    mail. 

author          ako    person.     

bag             ako    luggage. 

%% ball            ako    toy. 

base            ako    software. %% (technical)
%    base            has_a    content.

bear            ako    animal.

beer            ako    drink. %% liquid. 

book            ako    document.
bridge          ako    street. %%  roughly

bird            ako    animate. %% animal ?

boat            ako    vehicle. %% a kind of :-) 

bus             ako    vehicle. 
    bus             has_a  card. %% kortterminal?
    bus             has_a  horsepower.
    bus             has_a  route.  %% hva er ruten til
    bus             has_a  route_plan.  
    bus             has_a  wheel.   %%    

cannibal        ako    person. %%  :-)

car             ako    vehicle.  
    car             has_a  owner.

card            ako    ticket.
cat             ako    animal.
character       ako    text.
child           ako    person.
christmasroute  ako    route_plan. 
coat            ako    cloth. 
code            ako    text. 
coffee          ako    drink. 
competitor      ako    person.     
computer        ako    system.
    computer        has_a   operatingsystem.  

constant        ako    argument.
count           ako    number. 

cow             ako    animal.     
    cow             has_a  milk.
cube            ako    box. 

easterroute ako route_plan. 


front           ako   side. 
backside        ako   side. 

variant         ako   vehicle. %% (route)  %% thing.

boat_route_plan  ako     route_plan. 
train_route_plan ako     route_plan. 
tram_route_plan  ako     route_plan. 


data            ako    information. 

%% database        ako    place. %% ligge i databasen %% metagoric 

database        ako    information.
database        ako    software. 
    database        has_a   size. 
department      ako    office.
    department      has_a  department. 


description     ako    information.
dictionary      ako    file.
dinner          ako    food. 
directroute     ako    route. 
display         ako    equipment.

dog             ako    animal.
    dog             has_a  name.
    dog             has_a  owner.

doll            ako    toy.

donkey          ako    animal.
dress           ako    cloth.   
drink           ako    liquid.  

egg             ako    food. 

elephant        ako    animal.

email           ako    mail. %%  (or the same?)

employee        ako    person.  
    employee        has_a rank.
%    employee        has_a salary. // person

eveningroute   ako    route_plan.  

exam           ako    test. 

example         ako    text.

exchange        ako    activity.  %% ? 
exchange        ako    equipment. %% ? 

experience      ako    knowledge. %% ? 
    instruction      ako    knowledge. %% ?

expert          ako    agent. 

expertsystem    ako    system.  

entry           ako    space. %% inngang
exit            ako    space. %% utgang %% Telebuster
fact            ako    statement.

factor          ako    abstract. %% Experiment

farmer          ako    person. 
    farmer          has_a  donkey.

final           ako    match.
firstname       ako    person. %% Tores telefon name. %% Technical 
fish            ako    animal.
fizzydrink      ako    drink. 

flow            ako    traffic. %% fremkommelighet

flower          ako    plant. 
fuel            ako    liquid. 

% fly             ako    animal. %% confuse when bilingual

fruit           ako    food. 

glue            ako    liquid. 
gun             ako    weapon.

hardware        ako    system. 

hat             ako    cloth.
heading         ako    text.

horse           ako    animal.
horse           ako    vehicle.  %% :-)

house           ako    place. 
hydrogen        ako    gas. 

icecream        ako    food.  
implementation  ako    program. %% also activity
increase        ako    measure. 
indulgence      ako    feeling. %% (leniency ?)
interface       ako    program.
internet        ako    network.  %% changed from fact due to internet syndrome 

ipaddress       ako    address.

jog             ako    trip. %% i.e spasertur/løpetur

journal         ako    document.

keyboard        ako    system. 

knife           ako    weapon. 

lamb            ako    animal.
%% landsurface     ako    surface. 
territory     ako    surface. 
    territory       has_a  area.

lastname        ako    person. %%  ambles telefon name. 
liff            ako    life.  %%  :-)
line            ako    text.
lift            ako    vehicle. %% !! 
lion            ako    animal.
logic           ako    language.
logo            ako    identification. %% TA-110707
lunch           ako    food.  %% meal ?
lust            ako    feeling. %% Techn. Ha lyst på 

manual          ako    document.
mood            ako    feeling. %% spirit
mailaddress     ako    address.
mark            ako    text.
meat            ako    food.
medicine        ako    food.  %% Roughly
meetingroom     ako    room.
message         ako    statement.
middlename      ako    person. 
milk            ako    liquid.  
module          ako    system.
money           ako    measure. %%  number.   * money on the bus
morningroute    ako    route_plan. 
mood            ako    (mode).
mouse           ako    animal.
music           ako    sound. 

nl              ako    language.

notification          ako    information.

operatingsystem ako    system. 
     
owner           ako    person.

pair            ako  number.  %% NOT thing.  et par ting = par har ting


person          ako    animate. 

%%     person         has_a   hiddenflag.  
%%     person         has_a   street. %% teletuc veien til Arvid Holme
    person         has_a   city.
    person         has_a   streetnumber.
    person         has_a   streetcharacter. %% teletuc
    person         has_a   zip.             %% teletuc
    person         has_a   title.
    person         has_a   community.    %% teletuc
    person         has_a   phonetype.    %% teletuc
    person         has_a   extrainfo.    %% teletuc
    person         has_a   organisation. %% teletuc
    person         has_a   salary.
    person         has_a   telepone.

%%    person          has_a  address. 
    person          has_a  airplane.
    person          has_a  animal. 
    person          has_a  aunt.
    person          has_a  bag.  %%  (no inher. luggage)
    person          has_a  bed.
%%    person          has_a  bicycle. 
%%    person          has_a  car.    
%%    person          has_a  card. 
    person          has_a  chair.  
    person          has_a  cloth.
    person          has_a  coat.   %   cloth   
    person          has_a  cousin.
    person          has_a  dress. 
    person          has_a  hat.
%%    person          has_a  discount. 
    person          has_a  food. 
    person          has_a  department.
    person          has_a  destination. 
    person          has_a  doll.
%%    person          has_a  feeling.     
    person          has_a  forehead.
    person          has_a  frequency. 
    person          has_a  hand. 
    person          has_a  home.
    person          has_a  house.
    person          has_a  husband. %% to allow question
%%    person          has_a  job.
    person          has_a  king. 
    person          has_a  luggage. 
%%    person          has_a  mother.
    agent           has_a  money.  %% person
%%    person          has_a  name.        
%%   person          has_a  night. %%  ( kvelden min )  
    person          has_a  office.      
    person          has_a  plan.   
    person          has_a  pram. 
%%   person          has_a  question. 
    person          has_a  room.         
    person          has_a  sex.
    person          has_a  shirt.     
    person          has_a  size.
    person          has_a  school.
    person          has_a  son. 
    person          has_a  spot.
%%    person          has_a  telephone.
    person          has_a  telescope.
%%    person          has_a  ticket.  
    person          has_a  toy.
    person          has_a  uncle. 
    person          has_a  wallet. 
    person          has_a  wheelchair. 
    person          has_a  wife.  
    person          has_a  woman. %% :-) 

passenger       ako    person . 
escort          ako    person. %% passenger? 

phrase          ako    text. %% nl text
    phrase          has_a  complexity.
    phrase          has_a  definition.
    phrase          has_a  structure.
    phrase          has_a  version.

pity            ako    feeling.
pizza           ako    food.

airplane        ako    vehicle.   % official// aeroplane UK, airplane US

player          ako    person.     
point           ako    geo_metric. 
population      ako    number.
postaddress     ako    address. %% NB mailadress is ambiguoous
postcode        ako    number.  %% in Norway 
postbox         ako    address.
post_office     ako    office.
price           ako    money.  
    price           has_a  price. %%   price of a (fare=price)

printer         ako    system. 
% printer         ako    object.      
   printer          has_a  printqueue.        
   printer          has_a  name.              

card_reader            ako    system.  %% t-kort

printqueue      ako    queue.
    printqueue      has_a job. 
printquota      ako    number. 


program         ako    software. 
    program         has_a  address. %% i.e.  internet address 
    program         has_a  code.  %%  ( as such)
    program         has_a  computer. %% your server 
    program         has_a  internet. %% ?
    program         has_a  program. %% ditt program 
    program         has_a  programmer. %%  ( author )
    program         has_a  size. 
    program         has_a  operatingsystem. 
    program         has_a  oracle. %% dere har et../ du er et. 
    program         has_a  owner. 
    program         has_a  user.

programmer      ako    person. %%  (not agent as such) 

programminglanguage ako language. %%  (prefer non _ version

project         ako    activity. 
    project    has_a   boss.   %% unoff.
    project    has_a   leader. 

prototype       ako    system.

radio           ako    object.
rain            ako    weather.  
release         ako    system.
report          ako    document. 
reservation     ako    ticket.
restart         ako    start. 
return          ako    trip. 
ringroute       ako    route_plan. 
risk            ako    abstract.    %%
%%  roomnumber      ako    room.    %% Confuse Buster: Go there ? 
rule            ako    statement.   %% Reserved in SWI 


safety          ako    abstract.
savant          ako    system. 
screen          ako    information. %% ?
season_ticket   ako    ticket. 

servicecenter   ako    office.

special_ticket  ako    ticket. 
shirt           ako    cloth. 
shop            ako    house.     %% I saw it in the shop
%% show            ako    meeting. %% show me ... 
snow            ako    weather.

 %% collides with verb  % I have time to shop

name_recognition  ako system. %% rough %% TA-110706

speech_recognition  ako system. 

software        ako    system. 
    software       has_a    database. 
source          ako    information.

speech          ako    text. %% NB
spelling        ako    text. 
    
spellingerror   ako    error.

stamp           ako    ticket.  

statue          ako    landmark. 

string          ako    text. 

sun             ako    weather. %% in this domain

supermarket     ako    house.  

moon            ako    place.  

stair           ako    space. %% pl stairs  (street?) 

street          ako    neighbourhood.

streetnumber     ako    number.
streetcharacter  ako    character.

subscription    ako    telephone. %% my subscription 123435 

table           ako    file.
thief           ako    person.
time            ako    measure. 
    time            has_a   length. 

time_count      ako    measure.       %% N.of. times 

technology      ako    system. %% rough

television      ako    object. 
%% tiger           ako    animal. 
toilet          ako    room.   

trace           ako    route_plan.  

train           ako    vehicle. 

translation     ako    text. %% TA-110503

tram            ako    vehicle. 
    tram             has_a telephone. %% qua company


turing_test     ako    test. 

understanding   ako    knowledge. 

uniform         ako    clothing. 

user            ako    person.
    user            has_a   printquota.  
    user            has_a   diskspace.   
variable        ako    argument.

virus          ako    error. 

visit          ako    meeting. 

walking_distance ako distance.  

walking_time    ako  duration. %% TA-110419

wallet          ako    luggage. 

ward            ako    office. %% ???

water           ako    liquid. 

water_surface   ako    surface.
    water_surface   has_a area.

web             ako    network.  


webaddress      ako    address. 

summerroute    ako    route_plan.
winterroute    ako    route_plan.
holidayroute   ako    route_plan. 
sundayroute    ako    route_plan. 
saturdayroute  ako    route_plan. 
workdayroute   ako    route_plan. 
whitsunroute   ako    route_plan. 
may17route     ako    route_plan. 

video          ako    system. %% TA-110526

watch            ako   job. 

widget          ako    system. 

wind            ako    weather. 

window          ako    system. %% data-  ad hoc

wine            ako    drink. 

word            ako    text.
    word            has_a semantics.
    word            has_a form.

wumpus          ako    monster. % :-)  R&N AIMA 

youth           ako     person. 


%-LEVEL 4 ----------------

advance          ako time. %% forveien techn 

administrator    ako leader. %% (person) Tagore %% TA-110606

baby             ako child. 

cr               ako character. %% TA-110304
customer         ako person.  %% TA-101102

gentlemen_toilet ako toilet. 
ladies_toilet    ako toilet.

earliness       ako time . %% how early
lateness        ako time . %% how late

extension       ako program. %% fapp %% TA-110411

abbreviation    ako    word.  

advent          ako    time.

afternoon       ako    daypart. 

% adjective       ako    word.     

apple           ako    fruit.
author          ako    person. 

autumn          ako    time.  
    autumn has_a winterroute.
    autumn has_a route_plan. 

baby            ako    child.
banana          ako    fruit.
bill            ako    money. 
board           ako    person. %% aso a set of
boss            ako    leader. %% person. 
boy             ako    man.  %% child.  nec. because of HE
building        ako    house.  

capital         ako    city.
carrier         ako    employee. 
cent            ako    money. %% incl "øre"
charge          ako    money.
christmas       ako    time. %% not date
church          ako    building. %% (house)
city            ako    territory.
    city            has_a  age. 
    city            has_a  bus. 
    city            has_a  population. %% territory
    city            has_a  size.       %% s.a. population
    city            has_a  centre. 
    city            has_a  cinema.       %% hall
    city            has_a  driver. 
    city            has_a  harbour. 
    city            has_a  mayor.  
    city            has_a  person.  %% how many ... 
    city            has_a  street. %% road.
    city            has_a  route.  
    city            has_a  route_plan. 
% clause          ako    phrase.

clock           ako    time. 

comment         ako    phrase.

compiler        ako    processor.
complaint       ako    message.  %%  :-(
% conjunction     ako    word.
continent       ako    territory.
    continent      has_a  country. %% many

community       ako    territory.   % kommune
county          ako    territory.   % fylke

country         ako    territory.
    country         has_a  capital.
    country         has_a  city.    %% many
    country         has_a  currency.    
    country         has_a  king.       
    country         has_a  latitude.   
    country         has_a  longitude.  
    country         has_a  mountain. 
    country         has_a  population. 
    country         has_a  president.  
    country         has_a  primeminister. 
    country         has_a  queen.
    country         has_a  river.
    country         has_a  size.      %% s.a. population
    country         has_a  system.  
    country         has_a  team.       

compliment      ako    phrase.

conductor       ako    person. 

creator         ako    person.  
crown           ako    money. 

council         ako    territory.   % kommune

date            ako    time.
    date            has_a  evening.    %% Christmas Eve 

daycode         ako    code.  
    daycode         has_a   day. %%
    daycode         has_a   departure. 

daytime         ako    time.
day             ako    time.        
    day             has_a  afternoon.
    day             has_a  date.
    day             has_a  departure. 
    day             has_a  evening.  
    day             has_a  morning.  
    day             has_a  midnight.  %% natt (Norwagism) natt til fredag = fredag "morgen"
                                      %% torsdag natt // tvetydig	
    day             has_a  night.    
    day             has_a  bus.      %% søndagens rute // når går i dag %%
                                     %% dagens første buss bussen  
    day             has_a  route.    %% hvilke tider har rute 5 ? 
    day             has_a  time.      %% dagens tider 
    day             has_a  weather.


discount        ako    money. 
district        ako    territory.
doctor          ako    person.
dollar          ako    money. 
driver          ako    person. 
    driver           has_a beard. %%   :-#) person
daypart         ako    time. 
     daypart         has_a  bus.   %% Fig of sp.

doctor          ako    person. 

duration        ako    time.

easter          ako    time. 

elder           ako    person. 

errormessage    ako    message.

evening         ako    daypart. 
expression      ako    phrase. 

extrabus        ako    bus. 

family          ako    person. %% (i.e. set of persons !)
    family   has_a member. 

fare            ako    price.
    fare             has_a price. % price of a fare

fine            ako    price. %% (straffe-)gebyr

fool            ako    person.  
future          ako    time. 

garage          ako    place. %% bilverksted 
garden          ako    place.
genious         ako    person.  %%  :-)
girl            ako    woman.   %%  child.  %% nec because SHE

greeting        ako    message. 
halfyear        ako    time. %% apo year /not ako year
lastyear        ako    time. 

handicapped     ako    person.

healthcenter    ako    house. 


helicopter      ako    airplane.  

holiday         ako    date.  %% christmas/easter etc. 

hotel           ako    house. %%  i.e. place, elgeseter hotel#


hospital        ako    house.

humour          ako    mood.

income          ako    money.

inspector       ako    person. 

instructor      ako    employee.

intrans_verb    ako    verb.

island          ako    territory. 

kindergarten    ako    house. 
museum          ako    house. 

sportscentre    ako    house.  %% rough

king            ako    person.  %% man 
    king            has_a advisor.

leader          ako    person. 

linguist        ako    person. %%  :-)

lunchtime       ako    daypart. 

man             ako    adult.
%    man             has_a  wife. %% => person to allow question
%    man             has_a  love. %% ? which person loves ==> which (person love)
     man             has_a  test. %% Turings test :-)

manager         ako    employee.

management      ako   activity. 
%% management      ako    employee.   %% suspended ad hoc 
    management       has_a  policy.

mayor           ako    person.

midnight        ako    daypart.  %% (natt til søndag) 
military        ako    person. 

moment          ako    time. %%  Øyeblikk
month           ako    time.
morning         ako    daypart.  

morrow          ako    day.      %% NB  Technical

night           ako    daypart.  

noon            ako    daypart. 

noun            ako    word. 

ocean           ako    water_surface.

opening_hours   ako    time. 

operator        ako    person. 

otherbus        ako company . %% EXPERIMENT
otherbus        ako route. %%  bus. %% TA-110411  vehicle. %% // bus/company
    otherbus has_a  telephone.  %% qua company
    otherbus has_a  summerroute. %% etc. xome confusion 

overtime        ako    time. 

package         ako    data. %% Metagoric 

past            ako    time.  %%% <-- ???

patient         ako    person.
parent          ako    adult.
park            ako    territory.
    park            has_a lion.
    park            has_a statue.

% particle        ako    word. %%
penguin         ako    bird.
pensioner       ako    person. 
people          ako    person. %% Techn 
period          ako    time.
%% politician      ako    person.  %%  :-))))))))))
police          ako    person.  
pound           ako    money.    

predicate       ako    data. %% information ? 
prenoon         ako    daypart.   %% NEW CONCEPT
% preposition     ako    word.        
preprocessor    ako    processor.
president       ako    person.

primeminister   ako    person.

processor       ako    program.

teacher         ako person.

%% programmer      ako    person.  %%  agent 

% pronoun         ako    word.
   
quote           ako    mark.

region          ako    territory.      
requisition     ako    money. %%  ?


export          ako    database. 

rose            ako    flower.  

rush_hour       ako    time.  

salary          ako    money.
sale            ako    activity. 
sale            ako    money.      
sea             ako    water_surface.
season          ako    time. % årstid
self            ako    user. 
%%      self   has_a bus.  %% unnec 

semantics       ako    description.
semester        ako    time.  
sentence        ako    phrase.    

server          ako    computer. 

shed            ako    house.    %% Leskur (penthouse)
shuttleroute    ako    bus. 
signal          ako    message.
sms             ako    message.  
spring          ako    time.


startdate       ako    date. 
stopdate        ako    date. 

station         ako    place.    %% GENERIC BUS STOP etc
    station          has_a  address.
    station          has_a  place. % ( location ?), i.e. neighbourhood 

%    station          has_a  saturdayroute. %% søndagsrute 5 til dragvoll
%    station          has_a  sundayroute.  

    station          has_a  seat. 
    station          has_a  shed.  
    station          has_a  streetnumber. 
    station          has_a  zone.
%     station          has_a  departure.  %% til nth avreise kl. 18=nths avreise 

statistics      ako    data. 

student         ako    adult. 

summer          ako    time. %%  (re summer routes)
    summer           has_a     duration.  %% Generalize?

% teleporter      ako    airplane. %% synonym
thanks          ako answer. %% TA-101228

trafficplanner ako person.

trans_verb      ako    verb. 
    trans_verb       has_a  object.

underground     ako    vehicle. %% subway is American 

vacation        ako    time. %% not holiday (holy)


validity        ako time. %% of ticket/route 

verb            ako    word.
     verb            has_a  subject.

visitor         ako    person.

week            ako    time.
weekend         ako    day.  %% e.g. sunday  (time).
weekday         ako    day.  

whitsun         ako    time.
winter          ako    time.

woman           ako    adult.
%    woman           has_a  husband. %% Moved to person to allow question
    woman           has_a  lamb. % :-)   Mary

workshop        ako    place. %% garage ? 

world           ako    territory. 
year            ako    time. 
        year         has_a  route_plan. 
        year         has_a  bus. %% årets siste 
yester          ako    day. %% Norwagism  (i) gaar 

%-LEVEL 5 -------------------


monday    ako  day .   
tuesday   ako  day .
wednesday ako  day .
thursday  ako  day .
friday    ako  day .
saturday  ako  day .
sunday    ako  day .

% workday   ako  day.  %% (weekday)

/*   Meta 

attribute       ako    noun. 
subclass        ako    noun.    
subject         ako    noun. 
superclass      ako    noun. 

*/


advisor         ako    person. 

airbusterminal ako station.

bachelor        ako    man. 
birthday        ako    date.
brother         ako    man.

busterminal     ako    station. %% Central  station proper.

busstation      ako    station.  
tramstation     ako    station.
railwaystation  ako    station. 
class           ako    group. %%  NB !! Double

comment         ako    sentence. 

airbus          ako    bus.
    airbus           has_a webaddress.  %% qua company

articulated_bus ako    bus.      %% leddbuss
lowentry    ako    bus.          %% laventre buss // has lowentry
lowentry_bus    ako    bus.      %% laventre buss 
aunt            ako    woman.

callingtime     ako    clock. 
command         ako    sentence.

cousin          ako    person. 
daughter        ako    girl.

day             ako    duration.  %%   om 3 dager 
%%  buss går på mandag ==>  srel/on/duration/ %% NB


endstation      ako    station.
eveningbus      ako    bus. 
explanation     ako    sentence.  
father          ako    man.        % father    ako parent. 
fjord           ako    sea. 
flexibus        ako    bus.   
formula         ako    expression.
gasbus          ako    bus. 
grandfather     ako    man.     %% father, but that is too deep
grandmother     ako    woman.   %% mother, but too deep

halfhour        ako    duration.
hill            ako    place. %% mountain/ steep road
hour            ako    duration. %% time
    hour   has_a  time.     %%        En times tid
    hour   has_a  duration. %%        En times varighet
    hour   has_a  pause.    %% no inherit 

husband         ako    man. 

joke            ako    sentence.  %% :-)

leapyear        ako    year. 

minibus         ako    bus. 

minute          ako    duration. %% time
moment          ako    duration. 
morningbus      ako    bus.
mother          ako    woman.    %  mother     ako parent.
mountain        ako    place.

nightbus        ako    bus. 
nighttram       ako    tram. 

relative        ako    person. 

pause           ako    duration.  %% break
planet          ako    world.  %%  :-)


professor       ako    teacher.          %% tele
associate_professor       ako  teacher.  %% 
assistant_professor       ako  teacher.  %%
lecturer        ako    teacher. 

researcher       ako    person.

quarter         ako    duration. 
queen           ako    woman. 
question        ako    sentence.
    question        has_a  answer. 


regtop          ako    export. %% used as such
regtop_export   ako    export. 

responsetime    ako    duration. 

schoolbus       ako    bus.
second          ako    duration. 
sister          ako    woman.
son             ako    boy.
spouse          ako    adult. 
statement       ako    sentence. 
strike          ako    period.

traveltime      ako    duration.  %% technical
    traveltime     has_a  duration. 
uncle           ako    man. 

webmaster       ako    leader. %% boss. 

webserver       ako    server. %% level > ?

wife            ako    woman.

% =========NO MORE LEVELS! =========================================================

%    query           ako    question. %% Level 6
%    request         ako    question. %% Level 6


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%% A-Part-Of Section %%%%%%%%%%%%%%%%%%
%
% EXPERIMENTAL
% Defines transitive closure of the in relation
% Transitive closure in the apo definition is unnecessary

apos(C,E):-   
    C apo D,
    apos0(D,E).

apos0(E,E). 

apos0(C,E):-      
     apos(C,E).


% Space

continent apo   world.
sea       apo   world.
ocean     apo   world.

region    apo   continent.

country   apo   region.

city      apo   country.
county    apo   country.
river     apo   country.

district  apo   city.
neighbourhood apo city. 
park      apo   city. 

% Time

month     apo   year.
week      apo   month. %% and year by inference
day       apo   week.


% Diverse

ward      apo   hospital.

line      apo   file. 



%%%%%%%%% VERB  TEMPLATES %%%%%%%%%%%%%%%%%%%%%

% verb templates and compliances COULD have been organised under subject class,
% but then the inheritage would make it difficult to look up


% Reporting Verbs that take statements as complements

%
%% Reporting Verbs (rv)



rv_templ(admit,agent).  

rv_templ(allow,agent). 

rv_templ(answer1,agent). 
    v_compl(answer1,agent,nil,abstract). %% ærlig
    v_compl(answer1,agent,nil,agent). %% allows  john answered mary 

    v_compl(answer1,agent,to,agent). 
    v_compl(answer1,agent,from,agent). 
    v_compl(answer1,agent,from,place). %% orakelet svarer fra feil skole  
                                       %% gir et svar 'fra en skole' men oppgir feil skole
rv_templ(approve,agent). 

rv_templ(ask,agent). 
    v_compl(ask,agent,nil,agent). %% allows  john asked  mary 
    v_compl(ask,agent,on,sms).  
    v_compl(ask,agent,to,place).  %% ? spørre [om ruter] til nardo 
    v_compl(ask,agent,with,word).  %% med ordlyd 
    v_compl(ask,agent,with,sms).
    v_compl(ask,agent,with,telephone).  %% med ordlyd

rv_templ(arrange,agent). 
    v_compl(arrange,agent,to,agent). %% sic satt opp til
    v_compl(arrange,person,with,person).
%% rv_templ(be_free,agent). %%   være gratis å kjøre

rv_templ(avoid,agent). 

rv_templ(base,agent). %% basert på at bussen går %% TA-110708

rv_templ(believe,agent).

rv_templ(bet,agent).
     v_compl(bet,agent,nil,agent).
     v_compl(bet,agent,nil,money). %% bet one pound that

rv_templ(calculate,agent). %% amb %% regner med

rv_templ(cause,agent).

rv_templ(check,agent). %% sjekke om

%%%%%%%%%%%%%%%%%  
rv_templ(choose,agent). %% .. to // TEST

rv_templ(comment,agent).

rv_templ(consider,agent). 
    v_compl(consider,agent,nil,agent).
    v_compl(consider,agent,as,thing). 

rv_templ(convince,agent).
    v_compl(convince,agent,nil,agent).
    v_compl(convince,agent,to,agent). 

rv_templ(decide,agent). %%  to/that
rv_templ(deny,agent).
rv_templ(discover,agent).  
rv_templ(discuss,agent).

rv_templ(dislike,agent). %%   ..ha vanskeligheter med

rv_templ(do1,agent). %% Norw  det gjør at man 

rv_templ(doubt,agent).
    v_compl(doubt,agent,on,thing). 

rv_templ(end,thing).    %% slutte (med) å
rv_templ(ensure,agent). 

rv_templ(expect,agent). 
rv_templ(explain,agent).
    v_compl(explain,agent,to,agent). 

%% rv_templ(fail,agent). %% ? 
rv_templ(feel,agent). 
rv_templ(find,agent). 
%% rv_templ(fit,thing). %% egne seg til å ...wait
rv_templ(forget,agent). 

rv_templ(hate,agent). 

rv_templ(hear,agent).   %%  he heard  her leave 

rv_templ(help,thing). %% det hjelper at trikken går.  


rv_templ(hope,agent).   
   v_compl(hope,agent,for,thing).
   v_compl(hope,agent,on,thing). %% Norw 

iv_templ(hope,agent). %% håpet på et svar

rv_templ(blame1,thing).      %% Feilen skyldes at bussen står

rv_templ(indicate,thing). %% tyde på Norw
rv_templ(is_caused_by,thing). %% Feilen skyldes at bussen står

rv_templ(know,agent).   
    v_compl(know,agent,nil,day). 
    v_compl(know,agent,nil,date).
    v_compl(know,agent,regarding,thing). %% vet om 
    v_compl(know,agent,with,thing). %% vet (ved hjelp av) %%  ?

rv_templ(know1,agent).   %% Ad Hoc, DISAMBIG = know
    v_compl(know1,agent,nil,day). 
    v_compl(know1,agent,nil,date).
    v_compl(know1,agent,regarding,thing). %% vet om 
    v_compl(know1,agent,with,thing). %% vet (ved hjelp av) %%  ?


rv_templ(learn,agent). 
rv_templ(let,agent). 

rv_templ(lie2,agent). %% lyve
    v_compl(lie2,agent,to,agent).

rv_templ(like,agent). 



%% rv_templ(make,agent).    %% Made to be 
                            %% -> agent .... IKKE NORSK! lage 

rv_templ(manage,agent).   %% manage that

rv_templ(mean,agent).
%% rv_templ(mean2,agent).  %% obsolete %% TA-110112 

rv_templ(miss,agent). %% savne

rv_templ(need,agent).   %% trenge å 

rv_templ(notify,agent).   %% varsle 
    v_compl(notify,agent,nil,time).

rv_templ(pay2,thing). %% lønne seg å

rv_templ(plan,agent). 

rv_templ(postpone,agent). 

rv_templ(prefer,agent). 

rv_templ(pretend,agent). %% late som om

rv_templ(prevent,agent). %%  hindre at

rv_templ(promise,agent).
    v_compl(promise,agent,nil,agent).

rv_templ(propose,agent). 
rv_templ(prove,agent).      

%% rv_templ(reach,agent). %% rekke å stoppe bussen 
%%  NOR english reach a bus


rv_templ(recognize,agent). %% kjenner du til om ...
rv_templ(recommend,agent).

rv_templ(regard,agent).
    v_compl(regard,agent,nil,agent). 
    v_compl(regard,agent,with,abstract). %% med ansvar   

rv_templ(refuse,agent). 
rv_templ(register,agent).
rv_templ(regret,agent).  
rv_templ(remember,agent). 
rv_templ(report,agent). 
rv_templ(resist,agent).   %%  vegre/kvie
rv_templ(risk,agent). 

rv_templ(say,agent).
    v_compl(say,agent,to,agent).
    v_compl(say,agent,in,language).
    v_compl(say,agent,on,language). %% Norw

rv_templ(say,information).

rv_templ(see,person).       
rv_templ(seem,person).

rv_templ(show,agent). 
rv_templ(show,information). %% TA-101102

rv_templ(slip,agent). %% Norwagism = slippe =  Don' have (to)
rv_templ(start,agent).

rv_templ(tell,agent). 
rv_templ(tell,answer). %%  the answer tells

rv_templ(test,agent).  %%   test if ...
rv_templ(think,agent).  %% think possible
rv_templ(try,agent). 

rv_templ(understand,agent).

rv_templ(urge,agent).
    v_compl(urge,agent,nil,agent). 

rv_templ(use2,agent). %% pleie 

%% rv_templ(wait,agent). %% may confuse vente = expect

rv_templ(want,agent). %% need is reserved for plain transitive verb      
    v_compl(want,agent,for,time). 

rv_templ(wish,agent).      
rv_templ(wonder,agent).
    v_compl(wonder,agent,on,thing).  %% Norwagism  lure på
    v_compl(wonder,agent,regarding,thing).   %%  ( not about)


%% iv_templ(wonder,agent).  // I wonder when .. \= I wonder (at the same time as) ..



%%%%%%%%% BiModal (SIC) %%%%%%%%%%%%%%%%%%%%%%%%% 

%% PVI_TEMPL 

%% it VP NP to VP

pvi_templ(cost,money). % it costs money to ...
pvi_templ(cost,crown). %% no inheritance ?
pvi_templ(take,time).
pvi_templ(last,time).
pvi_templ(pay,person).
pvi_templ(suit,time). %% det passer meg (i) tid å ta buss %% Norwagism


%% PAI_TEMPL 

%% it is  Adj to VP

pai_templ(be,cheap). 
pai_templ(be,clever).   %% Too far   er det lurt å ...
pai_templ(be,dangerous). 
pai_templ(be,difficult). 
pai_templ(be,easy). 
pai_templ(be,expensive).
pai_templ(be,free). 
pai_templ(be,funny). 
pai_templ(be,gratis). 
pai_templ(be,nice). 
pai_templ(be,safe). 


%%%%%%%%% Intransitive verb templates %%%%%%%%


iv_templ(babble,agent). %% Tulle 
    v_compl(babble,agent,with,agent). 

iv_templ(be1,thing).
    v_compl(be1,thing,inside,place). %% amb place %% TA-110309
    v_compl(be1,thing,within,place). %% amb time. %%

    v_compl(be1,thing,nil,place). 
    v_compl(be1,vehicle,nil,minute).  %% Technical ...16 minutes ( after depatrure)
    v_compl(be1,place,along,route).   %% TA-100905
    v_compl(be1,thing,without,thing). %% rough 
    v_compl(be1,thing,below,measure). %% under 4 år 

    v_compl(be1,thing,on,computer).   %% metagorical 

%%    v_compl(be1,thing,in,neighbourhood). %% i nærheten av %% ?=nær 

    v_compl(be1,duration,to,place). %% TA-110225

    v_compl(be1,agent,in,doubt).
    v_compl(be1,agent,to,help). 

%%     v_compl(be1,route_plan,on,timetable). %%ad hoc 

  
  %    normalverb(be1,thing).   %% TOO GENERAL
  %  bus goes to A which is on B at T

%% normalverb(be1,person). %%  NB not thing, nor agent 

    v_compl(be1,activity,nil,time). 
%%    v_compl(be1,person,nil,place). %%  Jeg er et sted // jeg er Norge

   v_compl(be1,agent,nil,time).

   v_compl(be1,person,past,place).
   v_compl(be1,activity,in,time). 
   v_compl(be1,address,in,place). 
   v_compl(be1,agent,during,time).  %% I am at NTH during time 
   v_compl(be1,agent,for,meeting).  %% Anglicism be there for a meeting
   v_compl(be1,agent,from,place). 

   v_compl(be1,thing,in,format). 

   v_compl(be1,thing,in,activity). 
   v_compl(be1,agent,in,life). 
%%    v_compl(be1,agent,in,job). %% unnec 
   v_compl(be1,agent,in,life).           %%  ( i live) Norwagism
   v_compl(be1,agent,in,meeting). 
   v_compl(be1,agent,in,mood).           %%  :-)
   v_compl(be1,agent,in,network).   
   v_compl(be1,agent,in,place).          %%   (Q: where are you)
   v_compl(be1,agent,in,time).           %%   (Q: where are you now)
   v_compl(be1,agent,in,vehicle).        %% har du vært i en buss

   v_compl(be1,agent,on,activity).       %% på tur
   v_compl(be1,agent,on,duration). %% skal være på NTH på 5 minutter 
   v_compl(be1,agent,on,job).  
   v_compl(be1,agent,on,meeting).        %% Norwag
   v_compl(be1,agent,on,network).   
   v_compl(be1,agent,on,place). 
   v_compl(be1,agent,on,problem).    %% inne på et 
   v_compl(be1,agent,on,time).   
   v_compl(be1,agent,on,vehicle).  

   v_compl(be1,agent,to,direction). %% Norw til venstre/høyre 
   v_compl(be1,agent,to,meeting). %% .. meeting-place 
   v_compl(be1,agent,to,place).          %% bli (med) til ... %%?
   v_compl(be1,agent,to,time).           %% NON-standard 
   v_compl(be1,agent,with,vehicle). 
   v_compl(be1,agent,with,agent).  

   v_compl(be1,company,in,place). 
   v_compl(be1,date,in,time).  
   v_compl(be1,destination,to,place).  
   v_compl(be1,object,in,place). 
   v_compl(be1,object,in,sale). 

   v_compl(be1,operation,for,thing). %% virkemåte 

   v_compl(be1,permission,on,vehicle).   %%  (Norwag)
   v_compl(be1,person,nil,daypart).      %% I am  on NTH monday morning
   v_compl(be1,person,between,time).     %% not clock / confusing 
%   v_compl(be1,person,in,vehicle).      %% agent :-)
   v_compl(be1,person,to,clock).         %%   Norwagism  = before

   v_compl(be1,place,in,vehicle).  %% e.g. %% rullestoler er det plasstil i bussen
   v_compl(be1,place,on,vehicle). 

   v_compl(be1,revision,in,time).  

   v_compl(be1,sentence,to,agent). 

   v_compl(be1,thing,in,format).   %% system/info  

   v_compl(be1,thing,so_that,thing). %% abnormalverb

   v_compl(be1,clock,in,time).           %% klokka nå 
   v_compl(be1,day,in,day).              %% what day is it today 

   v_compl(be1,day,in,time).   %% (mange) dager er det til julaften
   v_compl(be1,hour,in,time).  
   v_compl(be1,minute,in,time).  

   v_compl(be1,minute,to,coevent).  %% til bussen går

   v_compl(be1,day,in,time).
   v_compl(be1,hour,in,time).  
   v_compl(be1,minute,in,time).  


   v_compl(be1,date,in,day).             %% what date is it today
   v_compl(be1,departure,from,place). 
   v_compl(be1,departure,on,day). 
   v_compl(be1,departure,in,day).        %%  Daily
   v_compl(be1,direction,in,place).      %%  WHERE is the way to NTH 

   v_compl(be1,hour,in,day).  
   v_compl(be1,meaning,in,time).          %%  :-)
   v_compl(be1,meeting,before,time).  
   v_compl(be1,meeting,to,time).         %% Norwagism

   v_compl(be1,oracle,on,sms).   
   v_compl(be1,oracle,on,mobile).  
   v_compl(be1,oracle,on,internet).  
   v_compl(be1,oracle,on,network).  

   v_compl(be1,person,nil,clock). %% time).         %% I am here kl 1200 (Norw) 
   v_compl(be1,person,nil,day).          %%  I am on NTH monday
   v_compl(be1,person,nil,date).         %%  I am on NTH 21.4.45  ??? 
   v_compl(be1,person,from,place). 
   v_compl(be1,person,to,place).         %% (i.e. skal være )
   v_compl(be1,person,within,clock). 
   v_compl(be1,person,within,hour). 
   v_compl(be1,person,within,minute). 

   v_compl(be1,place,at,place). 
   v_compl(be1,place,between,place). 
   v_compl(be1,place,in,distance).      %%  ....from X
   v_compl(be1,place,in,relation). 
   v_compl(be1,place,near,place).   

%  v_compl(be1,place,in,place).          %%  (Where is NTH )
%% PROBLEM   bus to nth that is in gløshaugen (at 1200)

   v_compl(be1,place,in,city). 
   v_compl(be1,price,in,city).           %%  Generalize ?
   v_compl(be1,place,to,object). %% i.e. space 

   v_compl(be1,station,after,place).
   v_compl(be1,station,before,place). 
   v_compl(be1,station,for,place).  
   v_compl(be1,station,in,direction). 
   v_compl(be1,station,near,place). 
   v_compl(be1,station,on,place). 
   v_compl(be1,station,to,place).  %% stasjoner fra A til B
   v_compl(be1,station,towards,place). %% on bus X 
   v_compl(be1,station,with,bus).  %% Ad Hoc  første holdeplass med
                                   %% buss 5 etter gløshaugen syd mot moholt 

   v_compl(be1,thing,for,time).   %% filene er for jula 
   v_compl(be1,thing,in,comparison). 
   v_compl(be1,thing,in,use). 
   v_compl(be1,thing,in_order_to,thing).

   v_compl(be1,thing,on,distance). %%  på strekningen ( distance ako measure#)
   v_compl(be1,thing,on,webaddress). %%  "alt kan være der"

   v_compl(be1,thing,offside,place). 
   v_compl(be1,thing,outside,place). 
   v_compl(be1,thing,with,duration).     %%  ( techn )
   v_compl(be1,thing,with,temperature).  %%  ( techn ) 

   v_compl(be1,time,between,activity).  
   v_compl(be1,time,from,place).    %% ( techn ) hva er tid fra rosenborg.
   v_compl(be1,time,in,place).      %%  (Hazardous ?) what is the time in NY


   v_compl(be1,vehicle,nil,place).       %%  Hazard ?
   v_compl(be1,vehicle,nil,daypart).     %% Bus is on NTH monday morning
   v_compl(be1,vehicle, nil,clock). %% time). 
   v_compl(be1,vehicle, nil,date).
   v_compl(be1,vehicle, nil,day). 

   v_compl(be1,vehicle,around,time). 
   v_compl(be1,vehicle,between,place). %% ruter er det mellom nth og nardo 

   v_compl(be1,vehicle,in,direction). 
   v_compl(be1,vehicle,in,operation).   
   v_compl(be1,vehicle,in,place).  
   v_compl(be1,vehicle,in,route).        %% Norw, ( punctual)
   v_compl(be1,vehicle,in,situation).
   v_compl(be1,vehicle,in,strike). 
   v_compl(be1,vehicle,in,system).       %%  in bus system / in database  %% ambiguous
   v_compl(be1,vehicle,in,time). 
   v_compl(be1,vehicle,in,traffic). 

   v_compl(be1,vehicle,near,place).  

   v_compl(be1,vehicle,on,place).        %%   bus is on station 1500
   v_compl(be1,vehicle,over,time). 
   v_compl(be1,vehicle,past,place).      %%  ( er innom ..)
   v_compl(be1,vehicle,to,clock).        %%  i.e.  before (Norw)
   v_compl(be1,vehicle,to,repair). 

   v_compl(be1,vehicle,within,clock).
   v_compl(be1,vehicle,within,hour). 
   v_compl(be1,vehicle,within,minute). 

   v_compl(be1,weather,nil,time). 

   v_compl(be1,year,in,year).  

   v_compl(be1,weather,nil,time).       %% Time Adverbials 

   v_compl(be1,window,to,thing). %% vindu til bussoraklet %%  TA-110617

v_compl(be1,weather,in,place).
   v_compl(be1,weather,at,agent). 

   v_compl(be1,C,Prep,D):-               %% be1 bus on route ( <= n_compl(on,bus,route))
        n_compl(Prep,C,D).               %% bus on station removed 

   
% v_compl(be1,station,on,neighbourhood).
%%  (bus from A which is on B before T)
%%  (hvilke busser er på lade)

%% TV-TEMPL

tv_templ(V,Agent,coevent) :- 
    rv_templ(V,Agent).


%% HAVE  

%% noun modifier are preferred   have (regtop_export on route_plan)
%% Non attribute have ( "own, receive" ), Inheritance

tv_templ(have,agent,claim).      %% TA-110707
tv_templ(have,agent,condition).  %% TA-110707
tv_templ(have,thing,connection). %% sammenheng 
tv_templ(have,thing,safety). 

tv_templ(have,agent,agent).  %%  * har du dame 
tv_templ(have,agent,access). %% TA-110409
tv_templ(have,agent,room).
    v_compl(have,agent,nil,place). %% hvor har Atb lokale %% TA-100915
    v_compl(have,agent,in,place).  %% nec ?
    v_compl(have,agent,on,place).   %% 

tv_templ(have,agent,suspicion). 

    v_compl(have,thing,nil,time). %% samtidig har jeg en ide 
    v_compl(have,thing,because_of,thing). %% TA-101210
    v_compl(have,thing,nil,day).  %% no inheritance?  idag har jeg en ide
    v_compl(have,thing,nil,coevent). %% inital if adverbial3
    v_compl(have,thing,redundantly,thing). %% ???

    v_compl(have,agent,according_to,thing).  %% iglge avtale
    v_compl(have,agent,from,agent).   %% ha (få) fra  meg %% Norw 
    v_compl(have,agent,off,agent).    %%         av
    v_compl(have,agent,on,connection).   %% Tagore på tråden
    v_compl(have,agent,in,addition). %% stanprep, but have is abnormal  
    v_compl(have,agent,in,idea). %% disam  tankene 
    v_compl(have,agent,in,mind).
    v_compl(have,agent,on,bodypart). %% på fanget ? 
    v_compl(have,thing,so_that,coevent). %% stanprep, but have  abnormal 

tv_templ(have,agent,answer).  
tv_templ(have,agent,house).
tv_templ(have,agent,beer).       %% doesnt work if attribute
tv_templ(have,agent,cat). 
tv_templ(have,agent,choice).  
tv_templ(have,agent,error).  
tv_templ(have,agent,honour).
tv_templ(have,agent,information). 
tv_templ(have,agent,need).   
tv_templ(have,agent,part).  
tv_templ(have,agent,phrase).     %%  kommentar/ løfte
tv_templ(have,agent,responsibility).
tv_templ(have,agent,room). 

    v_compl(have,agent,in,place). %% TA-110111

tv_templ(have,agent,route_plan). 
tv_templ(have,agent,side).       %%  vår side
    tv_templ(have,agent,page).   %%  vår side//ad hoc disamb
tv_templ(have,agent,stability).  
tv_templ(have,agent,traffic).   

tv_templ(have,departure,footnote). 
tv_templ(have,departure,vehicle).  

    v_compl(have,agent,in,mind).   
    v_compl(have,agent,on,mind).    %% 
    v_compl(have,agent,on,vehicle).
    v_compl(have,agent,to,time).    %% har en øving til i morgen 
    v_compl(have,thing,to,coevent). %% ha samvittighet til at 

tv_templ(have,agent,language).   %% e.g. logic 
tv_templ(have,agent,list).       %% doesnt work if attribute
%% tv_templ(have,agent,management). %% håndtering %%  has_a

tv_templ(have,agent,object).     %% event, not attribute 

tv_templ(have,agent,vehicle).    %% vehicle no longer object %% TA-110315

tv_templ(have,agent,regtop_export).    %% regtop-

tv_templ(have,company,vehicle). %% unnec ???
tv_templ(have,company,information). %% teams ruteopplysning %%
tv_templ(have,route,footnote). 
tv_templ(have,country,system). %% e.g. bus route system 
tv_templ(have,city,system).    %% e.g. bus route system %% 

tv_templ(have,person,agent). 

tv_templ(have,person,drink).  
%% tv_templ(have,person,fizzydrink). %% UNNEC!

tv_templ(have,person,food).     %% \+ nec att 

tv_templ(have,vehicle,transfer).
tv_templ(have,world,thing). %% verdens smarteste orakel 


%% Attribute  have  (the attribute has a value)

tv_templ(have,X,Y):- 
     X has_a Y.

% have complements should have the first complement as parameter
%  bus have (departure) from station, but
%  sometimes, this cannot be solved by noun complements  (departure from station)
%  as in " what is the departures that the bus have from the station "

    v_compl(have,agent,nil,time).     %% jeg har en avtale kl 10 
    v_compl(have,agent,at,activity).  %% ha tid ved overgang 
    v_compl(have,agent,from,place).  
    v_compl(have,agent,in,place). 
    v_compl(have,agent,on,ticket).    %% agent has price on ticket    (++)
    v_compl(have,agent,on,vehicle). 
    v_compl(have,agent,to,place).     %% have buses to nardo   

    v_compl(have,person,on,mind). 
    v_compl(have,person,on,self).     %% penger på seg 
    v_compl(have,vehicle,from,place). 
    v_compl(have,vehicle,at,place).    %% Hvilke passeringer har buss nr. 44 ved prof. Brochs gate 
    v_compl(have,vehicle,before,place). %% -"- 
    v_compl(have,thing,as,thing).      %% have john as father
    v_compl(have,thing,in,time).  
    v_compl(have,thing,to,agent).

    v_compl(have,agent,about,thing).     %% NEC hvilket navn har du informasjon om
    v_compl(have,agent,regarding,thing). 

%%%%%%%%%%% INFINITIVAL COMPLEMENTS %%%%%%%%%%%%%%

iv_templ(start,activity).  %% activity starts
iv_templ(start,agent).
iv_templ(start,cinema). %% i.e. show
iv_templ(start,school). 
iv_templ(start,activity). %% TA-101115
  
tv_templ(save,agent,thing). 
tv_templ(save,country,thing).   %%  ad hoc %%

tv_templ(start,agent,thing). %%  system/message


tv_templ(start,agent,route_plan). 

    v_compl(start,agent,nil,time).      %% Haz ? starter (i) påsken 

    v_compl(start,agent,from,place).    %% nonstandard   
    v_compl(start,agent,on,activity).   %%
    v_compl(start,agent,to,place).      %% start (fra A) til B 
    v_compl(start,agent,upon,activity). %% activation?
    v_compl(start,agent,with,thing).    %% start message with Team 


iv_templ(start,card). %% å gjelde  

iv_templ(start,departure). 
    v_compl(start,departure,at,place).
    v_compl(start,departure,on,place).
    v_compl(start,departure,from,place).

iv_templ(start,file).               
    v_compl(start,file,with,string).
iv_templ(start,special_ticket).  %% å gjelde 
iv_templ(start,movie).
iv_templ(start,name).               
    v_compl(start,name,with,string). 
iv_templ(start,meeting). 
iv_templ(start,price). 

iv_templ(start,vehicle).  %% når starter NTH *
   v_compl(start,vehicle,at,place). 
   v_compl(start,vehicle,with,route_plan).  

   v_compl(start,thing,with,route_plan).  %% "de" starter med ...
  
iv_templ(start,route_plan). 
iv_templ(start,time). 
%   v_compl(start,vehicle,nil,clock). 
    v_compl(start,vehicle,nil,place). %% where does bus start 
    v_compl(start,thing,nil,clock).                %%  (vehicle/person)
    v_compl(start,vehicle,from,place).             %%  (nonstandard (?))
    v_compl(start,vehicle,to,place).               %%  hvor starter = to ???

iv_templ(start,weather).   %%  (techn)

tv_templ(start,agent,company).
tv_templ(start,agent,activity). %%  departure
tv_templ(start,agent,program). 
tv_templ(start,agent,vehicle). 
    v_compl(start,agent,with,thing). %% sommertid
tv_templ(start,company,route_plan). 
tv_templ(start,person,activity). %% thing overgeneralised 
                                 % I start to go 1730 ==> 
                                 % I start to go and start 1730

tv_templ(state,agent,thing). %% oppgi // pure transituve (techn) 
    v_compl(state,agent,in,sentence). %%

tv_templ(stop,agent,activity). 
tv_templ(stop,agent,system).  
tv_templ(stop,agent,vehicle). %%  ( by signal ?) 

    v_compl(stop,agent,nil,daypart). %%  BT stoppe (igår) kveld
    v_compl(stop,agent,nil,time). %%  stoppe ikveld
    v_compl(stop,agent,on,activity).            %% (Norw)
    v_compl(stop,agent,on,time). 

    v_compl(stop,thing,nil,day). %% yesterday/day/nil %% <-- 

%% iv_templ(stop,station). %% repair ->  lie %% * %%? korsen stanset 
%%     v_compl(stop,station,near,place).          %% TA-101118

iv_templ(stop,thing). %% TA-110609 stop verden 

/*
iv_templ(stop,agent). 
iv_templ(stop,company). %% qua neib qua company %% TA-101118 Korsen stanset
iv_templ(stop,weather).   %%  (techn. stoppe å regne
iv_templ(stop,departure). 

*/
    v_compl(stop,departure,at,place).
    v_compl(stop,departure,on,place).
 
%% iv_templ(stop,number). %% in case number 7 \= route 7

%% iv_templ(stop,vehicle).   %% ( not thing !!) 
    v_compl(stop,vehicle,nil,place).
    v_compl(stop,thing,nil,clock). 
    v_compl(stop,vehicle,nil,time_count). 
	 v_compl(stop,vehicle,nil,clock).  %%  (nil,time not standard anymore)
    v_compl(stop,vehicle,nil,day).  
    v_compl(stop,vehicle,nil,date).
    v_compl(stop,vehicle,nil,day).  
    v_compl(stop,thing,between,time). 
    v_compl(stop,vehicle,after,departure). 
%%     v_compl(stop,vehicle,because_of,strike).    %%  (Just a protype test) 
    v_compl(stop,vehicle,before,place). 
    v_compl(stop,vehicle,between,place). 
    v_compl(stop,vehicle,by,place). 
    v_compl(stop,vehicle,for,person). 
    v_compl(stop,vehicle,from,place).     %% abnormal  stop at A from B
    v_compl(stop,vehicle,near,place). 
    v_compl(stop,vehicle,on,departure). %% fram sentrum 
%    v_compl(stop,vehicle,on,day).
    v_compl(stop,vehicle,on,place).    
    v_compl(stop,vehicle,on,signal). 
    v_compl(stop,vehicle,on,trip). 
    v_compl(stop,vehicle,outside,place). 
    v_compl(stop,vehicle,to,place).       %% abnormal  stop at A to B 

%% iv_templ(stop,strike). 
%% iv_templ(stop,time). % e.g. day end



%% iv_templ(use,vehicle). %  bussen bruker tid    %% EXPERIMENT

tv_templ(use2,agent,coevent).    %% NB: abnormalverb/2

%%% iv_templ(use2,thing). %%  dette svaret bruker (jeg).= dette svaret pleier

/*
iv_templ(use2,vehicle).     %%   (Pleie  Norwagism)
iv_templ(use2,agent).       %% pleie å gå = pleier for å gå.
iv_templ(use2,delay).
*/

    v_compl(use2,thing,with,duration).          %% hvor lenge pleier ...
    v_compl(use2,thing,in_order_to,thing).
    v_compl(use2,thing,between,time). 
    v_compl(use2,thing,nil,clock). 
    v_compl(use2,agent,in_order_to,thing). 
    v_compl(use2,agent,in,time).  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



tv_templ(base,agent,thing).
    v_compl(base,agent,on,thing). 

tv_templ(become,thing,thing). 

% Epistemic Verbs 

%% iv_templ(believe,agent). %% suspended .. en buss som jeg tror du tok 
    v_compl(believe,agent,in,agent).  %% cause trouble ?
    v_compl(believe,agent,on,agent).  %% Norwagism
    v_compl(believe,agent,on,information). 
    v_compl(believe,agent,regarding,thing). 

% Passive verbs  

tv_templ(bear2,agent,agent).  %% tv   Give birth to
    v_compl(bear2,agent,by,woman).

%----------------------------------------------------------
% Active verbs

iv_templ(abstain,person). 

tv_templ(accept,vehicle,card). 

tv_templ(accompany,agent,explanation). %% AMB  følge anvisninger 

tv_templ(accompany,thing,thing).  %% ad hoc  merking må følges AMB 

tv_templ(accompany,agent,agent). 
    v_compl(accompany,agent,from,agent). 
    v_compl(accompany,agent,from,place). 
    v_compl(accompany,agent,of,consideration).  %% av hensyn til 
    v_compl(accompany,agent,to,agent).          %% "følges" amb
    v_compl(accompany,agent,to,place).  

% tv_templ(accompany,thing,vehicle).  %% -> go2 


iv_templ(account,agent). %% 
   v_compl(account,agent,for,agent). 

tv_templ(adapt,agent,thing).
    v_compl(adapt,agent,nil,thing). %% minibusser er tilpasset   handicapped
    v_compl(adapt,agent,for,thing). %% .. wheelchair 
    v_compl(adapt,agent,to,thing).  
    v_compl(adapt,agent,in,system). 

iv_templ(agree,thing). %%  ( stemme, Norwagism)
     v_compl(agree,thing,in,thing).
     v_compl(agree,thing,with,thing). 

iv_templ(aim,person).  
    v_compl(aim,person,at,thing).

tv_templ(allow,agent,thing).  
tv_templ(allow,weather,thing). %% :-) %% TA-101117

tv_templ(amuse,thing,agent). 


%%
tv_templ(answer1,thing,nil). %% den svare (noe) på engelsk

iv_templ(answer1,agent). %%  Norwegian: Intransitivt
tv_templ(answer1,agent,thing). %% Ambiguity problem %% hva kan jeg svare.

    v_compl(answer1,thing,nil,time_count). 
   
    v_compl(answer1,thing,according_to,ability). %% 
    v_compl(answer1,thing,after,ability). %% Norw 
    v_compl(answer1,thing,for,thing).
    v_compl(answer1,thing,in,language).
%    v_compl(answer1,thing,in,mode). %% e.g. wrongly,correctly 
    v_compl(answer1,thing,in,sentence). 
    v_compl(answer1,thing,on,thing). 
    v_compl(answer1,thing,with,sentence). 

tv_templ(answer1,agent,nil).      %%  svare (noe) på engelsk
tv_templ(answer1,agent,question). %%  besvare   //
tv_templ(answer1,agent,sentence). %%  svart med //

tv_templ(answer,agent,nil).      %%  svare (noe) på engelsk
tv_templ(answer,agent,question). %%  besvare   //
tv_templ(answer,agent,sentence). %%  svart med //

   tv_templ(answer,agent,error). %% e.g. feil
%%


iv_templ(appeal,person). 
    v_compl(appeal,person,to,person).

iv_templ(appear,thing). %% se ut/dukke upp %% TA-101210
    v_compl(appear,thing,nil,mode).
    v_compl(appear,thing,as,thing). %% TA-101210
    v_compl(appear,thing,in,text).       %% metagoric %% TA-110504

tv_templ(apply,thing,thing). %% dette gjelder en feil 

iv_templ(apply,person). 
    v_compl(apply,person,to,person).
    v_compl(apply,person,for,thing).
    v_compl(apply,thing,nil,thing). %% dette gjelder en feil 

iv_templ(apply,thing). %% gjelde 
    v_compl(apply,thing,for,thing). %%
    v_compl(apply,thing,on,thing). 

tv_templ(approve,agent,thing). %% + rv
    v_compl(approve,person,of,thing). 

iv_templ(argue,person). 
    v_compl(argue,person,about,thing).

tv_templ(arrange,agent,thing). %% rutene er "satt opp"
    v_compl(arrange,thing,nil,mode).   %% directly 
    v_compl(arrange,thing,in,thing). 
    v_compl(arrange,agent,to,time).    %%   Norw 
    v_compl(arrange,agent,with,thing). 

iv_templ(arrive,agent). %% hvis du skal komme 
iv_templ(arrive,time).  %% det har kommet til 5 minutter
iv_templ(arrive,trip).  %% turen 

iv_templ(arrive,thing).

    v_compl(arrive,thing,in,information). %% metagoric
 
    v_compl(arrive,agent,nil,activity). %% skal på = ankomme jobb 
    v_compl(arrive,agent,nil,time). 
    v_compl(arrive,agent,nil,meeting). 
    v_compl(arrive,agent,nil,place). 
    v_compl(arrive,agent,between,time).
    v_compl(arrive,agent,from,place). %% ankomme X fra Y
    v_compl(arrive,agent,on,place). 
    v_compl(arrive,agent,on,duration). 
    v_compl(arrive,agent,on,vehicle). %%  være på toget
    v_compl(arrive,agent,to,place).   %%  (Norwagism) 
    v_compl(arrive,agent,to,time).    %%  ankomme til kl 1234
    v_compl(arrive,agent,by,vehicle).
    v_compl(arrive,agent,with,vehicle). 
    v_compl(arrive,agent,for,meeting). 
    v_compl(arrive,agent,on,meeting). 
    v_compl(arrive,agent,to,meeting). 
    v_compl(arrive,agent,towards,place). %% Techn. jeg må mot nth
    v_compl(arrive,agent,via,place). 


%  ankomme = arrive Norwagism transitively  changed to pass
%  necessary in English 

iv_templ(arrive,vehicle). 
iv_templ(arrive,question).
   v_compl(arrive,vehicle,nil,clock).  %% (never nil,time)
   v_compl(arrive,vehicle,nil,day).    %% (never nil,time)
   v_compl(arrive,vehicle,about,time). 

   v_compl(arrive,agent,after,route_plan).     
   v_compl(arrive,agent,before,route_plan).  
   v_compl(arrive,trip,nil,place).  

   v_compl(arrive,vehicle,after,route_plan).  
   v_compl(arrive,vehicle,before,route_plan). 
   v_compl(arrive,vehicle,between,time).  
   v_compl(arrive,vehicle,from,place).   %% ( arrive at X FROM Y)
   v_compl(arrive,vehicle,on,time).
   v_compl(arrive,vehicle,to,place).
   v_compl(arrive,vehicle,to,time).  %% Norw
   v_compl(arrive,vehicle,towards,place). 
   v_compl(arrive,vehicle,via,place). 

iv_templ(arrive,version).  %% Metagoric

   v_compl(arrive,thing,nil,time). 
   v_compl(arrive,thing,nil,place).

% 

iv_templ(ask,agent). 
tv_templ(ask,agent,coevent). %% e.g.  om (trikken går)
tv_templ(ask,agent,sentence). %%  Skjønner du hva jeg spør om
tv_templ(ask,agent,agent).    %% I beg you to go  

    v_compl(ask,agent,about,thing).      %% about is for times and places
    v_compl(ask,agent,after,thing).  %% rough ask after)ask regarding 

    v_compl(ask,agent,from,thing).  %% rough ask after)ask regarding
    %% spør etter sted = ask after place = ask from place %%   weak
    v_compl(ask,agent,nil,time_count).   %% ask many times  (standard ?)
    v_compl(ask,agent,on,language).       %%  (Norw)
    v_compl(ask,agent,in,language).       %%  (Eng)

    v_compl(ask,agent,regarding,thing).  %% regarding is for topics 
    v_compl(ask,agent,via,thing). %%  //nettstad/telf/sted 

tv_templ(attend,agent,thing). 

tv_templ(automatize,agent,information). 
tv_templ(automatize,agent,system). 

tv_templ(awaken,thing,feeling).  
%% tv_templ(awaken,agent,feeling).  
%% tv_templ(awaken,information,feeling).


iv_templ(bark,dog). 

tv_templ(believe,agent,thing). %% .. Hva mener du ?

tv_templ(border,surface,surface ). % incl sea   
iv_templ(border,surface).       %%  (Norw)
    v_compl(border,surface,to,surface). %%  (Norw)

iv_templ(bicycle,agent). %%  ( :-))
    v_compl(bicycle,agent,from,place).
    v_compl(bicycle,agent,to,place).   %%  not standard
    v_compl(bicycle,agent,to,agent).  

iv_templ(blame1,agent). %% Norw, skylde /det/  på
    v_compl(blame1,agent,on,thing). 


tv_templ(bore,thing,agent). 

iv_templ(burn,house). 

%% iv_templ(check,system). 

tv_templ(check,agent,nil). %% jeg undersøker () 
tv_templ(check,agent,thing). 
    v_compl(check,thing,against,thing). 
    v_compl(check,thing,towards,thing). %% lex dependent 
    v_compl(check,agent,with,thing).    %%  undersøke med server/undersøke (ting) med ..

tv_templ(choose,agent,nil).   %%jeg velger mellom ... CONFUSE %% TA-110310

tv_templ(choose,agent,thing). 
    v_compl(choose,agent,among,thing).   %% etc
    v_compl(choose,agent,between,thing).
    v_compl(choose,agent,for,thing).     %% TA-110228
    v_compl(choose,agent,in,time). %% nec?
    v_compl(choose,agent,on,object). %% velge på t:kort


tv_templ(close,agent,door). %% etc

iv_templ(close,agent).
iv_templ(close,company).
iv_templ(close,office). 
iv_templ(close,place). %% IKEA, ... ??? 


iv_templ(come,thing). %% * kan katten|m bli med

    v_compl(come,thing,at,thing).      %% ved neste regtopekspor
    v_compl(come,thing,from,system).
    v_compl(come,thing,in,database).   %% i.e. export 
%%     v_compl(come,thing,in,text).       %% metagoric %% TA-110504
    v_compl(come,thing,on,time).       %% bus/person komme på 10 minutter
    v_compl(come,thing,to,agent).
    v_compl(come,thing,to,coevent). %%  come to moholte.g. coevent %% TA-110411
    v_compl(come,thing,via,thing). 
    v_compl(come,thing,with,thing).    %% den kommer fram ved søking 

    v_compl(come,place,after,place). %% stat/neigh 
    v_compl(come,place,before,place).   
    v_compl(come,place,with,vehicle).  %% Norw
%%     v_compl(come,station,after,place). %% Norw 
    v_compl(come,station,in,route).    %% Norw   
    v_compl(come,station,on,route). 

    v_compl(come,vehicle,from,place). 
    v_compl(come,vehicle,to,place).
    v_compl(come,vehicle,from,place). 
    v_compl(come,vehicle,between,time).  
    v_compl(come,vehicle,by,place).      
    v_compl(come,vehicle,past,place).  



iv_templ(complain,agent).
   v_compl(complain,agent,regarding,thing). %% om 
   v_compl(complain,agent,on,thing). 
   v_compl(complain,agent,over,thing).  %
   v_compl(complain,agent,to,thing). 

%% gjelde= concern/exist  Problems
%% iv_templ(concern,route_plan). %%   Norw   gjelde
%% tv_templ(concern,thing,thing). 
%% tv_templ(concern,change,thing). 
                  
tv_templ(concern,thing,vehicle). %% rutetrafikk 
tv_templ(concern,thing,system).  %% \+ thing,thing
             
tv_templ(concern,information,thing).   %% hvilke endringer gjelder bussen 17 (mai)
%     v_compl(concern,thing,nil,time).       %% NOT nil month
    v_compl(concern,route_plan,nil,date).    %%  (Too specific)
%     v_compl(concern,route_plan,to,place).  %%  exist

%% iv_templ(congratulate,agent).        %%  :-)
tv_templ(congratulate,agent,nil).   
tv_templ(congratulate,agent,agent).  %%  :-)
    v_compl(congratulate,agent,with,thing). 

iv_templ(consist,thing).    
    v_compl(consist,thing,of,thing). 
    v_compl(consist,thing,off,thing). %% Norwagism ( Nec??)    

iv_templ(continue,thing). 

iv_templ(correspond,vehicle).  %% \+ thing torvet korrepsonderer
iv_templ(correspond,company). 

    v_compl(correspond,thing,on,thing).   %% passer på nettside
    v_compl(correspond,thing,with,thing). 
    v_compl(correspond,company,with,company). 
    v_compl(correspond,company,with,vehicle).

iv_templ(correspond,departure). 

iv_templ(correspond,route_plan). 
iv_templ(correspond,vehicle). 

    v_compl(correspond,thing,nil,time). %% vehicle -> thing 
    v_compl(correspond,thing,with,vehicle).
    v_compl(correspond,thing,for,person). %% Ad Hoc passer for folk
    v_compl(correspond,thing,between,place). %% NO, as such === go	 %% Hazard ?
    v_compl(correspond,thing,from,place).   
    v_compl(correspond,thing,to,place).   
    v_compl(correspond,thing,with,place).   


%   Problem: correspond is selected before go because of alphabet
%   intransitive correspond is selected
%   then commit error

iv_templ(correspond,person). 

    v_compl(correspond,person,with,vehicle).

tv_templ(cost,thing,money). %%  hva koster dolpa 
                            %%  Hvor mye koster en ny bestemor? 

tv_templ(cost,thing,nil). 
%% iv_templ(cost,thing). 
     v_compl(cost,thing,in_order_to,coevent). 
     v_compl(cost,thing,after,time).  

    v_compl(cost,thing,for,thing).     %%  not money

%%%%     v_compl(cost,thing,in,place).      %%  -> n_compl

    v_compl(cost,thing,over,money).    %% > 1 kr
    v_compl(cost,thing,per,thing).     %% koste per måned 
    v_compl(cost,thing,under,money).   %% < 1 kr
    v_compl(cost,thing,with,card).  
    v_compl(cost,thing,within,place).  

    v_compl(cost,ticket,in,vehicle). 
    v_compl(cost,thing,on,vehicle). %% :-) beer 

tv_templ(count,agent,thing).  %% Alt er tall :-)

iv_templ(count,agent). 
    v_compl(count,agent,to,number). 
iv_templ(dance,person).     

tv_templ(cut,agent,thing).         %%  e.g. klippe billett
    v_compl(cut,agent,on,vehicle). %%
 
iv_templ(deal,person). 
    v_compl(deal,person,with,thing).

iv_templ(depart,person).  
    v_compl(depart,person,nil,place). 
    v_compl(depart,person,between,time).     
    v_compl(depart,person,from,place).
    v_compl(depart,person,to,place).
    v_compl(depart,person,by,vehicle).  
    v_compl(depart,person,in,direction).
    v_compl(depart,person,with,vehicle). 

iv_templ(depart,vehicle). 
    v_compl(depart,vehicle,nil,place). 
    v_compl(depart,vehicle,between,time).
    v_compl(depart,vehicle,for,place).
    v_compl(depart,vehicle,from,place).
    v_compl(depart,vehicle,in,direction).
    v_compl(depart,vehicle,on,direction). %% (norwagism)
    v_compl(depart,vehicle,to,place).
    v_compl(depart,vehicle,towards,place).

iv_templ(depend,thing). 
    v_compl(depend,thing,on,thing).

iv_templ(die,agent). 
    v_compl(die,person,bil,time). 
    v_compl(die,person,in,vehicle).  %% TA-110823
    v_compl(die,person,on,vehicle).  %%
    v_compl(die,person,on,activity). %%
    v_compl(die,person,of,activity). 


iv_templ(disappear,thing).  
    v_compl(disappear,thing,at,thing). %% ved en feil %% Norw
    v_compl(disappear,thing,by,thing). %%


iv_templ(doubt,agent).  
    v_compl(doubt,agent,on,thing). 
    v_compl(doubt,agent,regarding,thing).   %% om 

tv_templ(empty,agent,thing).       %%
    v_compl(empty,agent,for,thing).

tv_templ(enclose,agent,thing).

tv_templ(end,station,route). %% (endstation) ends route 
                             
iv_templ(end,thing). %% TA-110606 the world

    v_compl(end,agent,on,activity). %% Norw på jobb
    v_compl(end,text,with,text).     

/* %% TA-110606
iv_templ(end,agent). %%  ( stop ???)
iv_templ(end,place). %% skolen 
iv_templ(end,summer). 
iv_templ(end,summerroute). 
iv_templ(end,text).
iv_templ(end,time). 
iv_templ(end,vehicle). 
iv_templ(end,zone).
iv_templ(end,winterroute). 
*/


% iv_templ(end,route).               %% at place

iv_templ(enter,thing).
    v_compl(enter,thing,in,thing).%% tre i kraft (ad hoc) %% TA-101108

tv_templ(estimate,agent,measure).   
    v_compl(estimate,thing,from,place). 
    v_compl(estimate,thing,to,place). 

iv_templ(exercise,agent). %%  trene/øve



tv_templ(export,agent,thing). %% techn 

tv_templ(import,agent,thing). %% techn 
tv_templ(import,agent,nil). %% importere i (SIC) 
    v_compl(import,agent,in,system). %% billettmaskin? %% 

iv_templ(exist,thing). 

%%     v_compl(exist,Thing,Prep,Obj):- v_compl(be1,Thing,Prep,Obj). 
%%    generalised 

    v_compl(exist,thing,nil,time). %% problem?
    v_compl(exist,thing,nil,clock). 
    v_compl(exist,thing,nil,date). 
    v_compl(exist,thing,nil,day ).  
    v_compl(exist,thing,nil,place). %% hvor eksisterer bussene ?

    v_compl(exist,thing,as,thing). %% gjelde som søndagsrute 
    v_compl(exist,thing,at,thing). %% gjelde ved reise 

    v_compl(exist,thing,after,coevent). 
    v_compl(exist,thing,before,coevent).

    v_compl(exist,thing,for,agent). %% TA-110426
    v_compl(exist,thing,for,place). 
    v_compl(exist,thing,for,object).

    v_compl(exist,thing,in,fact).
    v_compl(exist,thing,in,relation).
    v_compl(exist,thing,in,company).          %%  (ako place ?)
    v_compl(exist,thing,in,information).  %% metagoric 
    v_compl(exist,thing,in,text). 
    v_compl(exist,thing,in,ticket).   %% inngå i .. 
    v_compl(exist,thing,in,vehicle).  %%  delays in route (SIC)
    v_compl(exist,thing,on,system).  
    v_compl(exist,thing,on,activity). %% på reiser 
    v_compl(exist,thing,on,network).  

    v_compl(exist,place,on,route). 
  
    v_compl(exist,time,to,place).  %% tid til nardo 

    v_compl(exist,place,from,place).  %% i.e. (på veg) fra 

    v_compl(exist,time,since,time). 
    v_compl(exist,time,since,coevent). 
    v_compl(exist,time,until,coevent). 

    v_compl(exist,thing,with,duration).       %%  ( hvor lenge)
    v_compl(exist,thing,with,spelling). %% opptrer med (feil) staving 
    v_compl(exist,thing,to,time).     %% Norw
 
    v_compl(exist,horsepower,in,vehicle).  
    v_compl(exist,vehicle,nil,time). %% buss fins neste time 

    v_compl(exist,duration,to,place). %%  " hvor langt er det fra "

iv_templ(experiment,person).

tv_templ(extend,agent,route).  %% TA-101006
tv_templ(extend,agent,information).  
tv_templ(extend,agent,card). %% etc  

tv_templ(extend,agent,system).  
    v_compl(extend,agent,to,coevent). 
    v_compl(extend,agent,to,information).
    v_compl(extend,agent,to,system).
    v_compl(extend,agent,to,informationcentre). %%  ad hoc
    v_compl(extend,agent,with,coevent).
    v_compl(extend,agent,with,informationcentre). 
  

tv_templ(fail,agent,thing). %% hva feiler deg 
iv_templ(fail,agent).
    v_compl(fail,thing,in,relation).

iv_templ(fall,object).
iv_templ(fall,time).   
   v_compl(fall,date,on,day). 
   v_compl(fall,day,on,day).  %%  e.g. holidays

tv_templ(fasten,agent,thing).
    v_compl(fasten,agent,for,thing). %% too gen
    v_compl(fasten,agent,in,thing).
    v_compl(fasten,agent,on,thing).
    v_compl(fasten,agent,to,thing). %% 
    v_compl(fasten,agent,with,thing).
 


iv_templ(feel,agent). 

tv_templ(feel,agent,thing). 

tv_templ(fill,agent,birthday). %% TA-110215
tv_templ(fill,agent,card). %% t-kort (med penger)
tv_templ(fill,agent,special_ticket). %% t-kort (med penger)
tv_templ(fill,agent,year). %% fylle år (Norw, rough) 
tv_templ(fill,agent,nil). %% fyller (penger) på t-kort 
    v_compl(fill,agent,on,card). 

tv_templ(finish,thing,thing). %% veh, agent 
%%% iv_templ(finish,thing). stop?   

iv_templ(fit,thing).  
    v_compl(fit,thing,to,thing).  

iv_templ(flash,object).  %%  det lyner


iv_templ(flow,river).
    v_compl(flow,river,from,surface). 
    v_compl(flow,river,into,surface).   
    v_compl(flow,river,out_of,surface). 
    v_compl(flow,river,through,territory).

% iv_templ(fly,airbus).           %%  :-)  Just for the question
iv_templ(fly,bird). 
iv_templ(fly,agent). %% person).   %% allow question 
iv_templ(fly,time).         
iv_templ(fly,airplane). 

    v_compl(fly,thing,from,place). %% from place is not standard 
    v_compl(fly,thing,to,place).   %% to place 

iv_templ(freeze,person).      %% personal

iv_templ(get,agent). %%   = go, semantically and factual       
    v_compl(get,agent,nil,day). 
    v_compl(get,agent,about,time). %% (almost synonym)
    v_compl(get,agent,at,agent). %% hos dere %% Norw
    v_compl(get,agent,between,time). 
    v_compl(get,agent,by,place). 
    v_compl(get,agent,by,vehicle).   
    v_compl(get,agent,from,place). 
    v_compl(get,agent,from,agent).   %% TA-101102
	 v_compl(get,agent,in,place).     %% nec?
	 v_compl(get,agent,in,time). 
    v_compl(get,agent,of,agent).     %% få av %% TA-101102 
    v_compl(get,agent,off,agent).    %%
	 v_compl(get,agent,off,vehicle). 
	 v_compl(get,agent,on,vehicle). 
    v_compl(get,agent,past,place). 
    v_compl(get,agent,to,vehicle). %% få ruter til buss 
    v_compl(get,agent,to,place).
    v_compl(get,agent,to,time). %% til jul ..
    v_compl(get,agent,with,vehicle). 
    v_compl(get,agent,without,transfer).

tv_templ(get,question,answer). 

tv_templ(get,agent,thing). %%  gå svar/buss 

tv_templ(get,agent,coevent). 
    tv_templ(receive,agent,coevent). 

tv_templ(get,vehicle,competition). %% thing ?

tv_templ(get,thing,competition).  


tv_templ(get,agent,thing). 
    v_compl(get,agent,nil,clock).  
    v_compl(get,agent,on,mind). %% :-) 
    v_compl(get,agent,on,place).
    v_compl(get,agent,with,sms).      %% TA-101118 etc (metagoric)
    v_compl(get,agent,with,web).      %%
    v_compl(get,agent,with,internet). %%

iv_templ(get,vehicle). %%   = go, semantically and factual       
	 v_compl(get,vehicle,nil,clock). 
    v_compl(get,vehicle,between,time). 
    v_compl(get,vehicle,by,place). 
    v_compl(get,vehicle,from,place).
    v_compl(get,vehicle,past,place).  
    v_compl(get,vehicle,to,place).


%%%%%% GO %%%%

iv_templ(go,activity).

iv_templ(go,traffic).  
   v_compl(go,traffic,nil,place).  %% hvor går trafikken



iv_templ(go,agent).       %% include command:  go to hell!  
    v_compl(go,agent,nil,time). %% I go now
    v_compl(go,agent,nil,direction). %% go home
    v_compl(go,agent,nil,place).     %%  Jeg går et sted 
    v_compl(go,agent,nil,speed).     %%  How fast can I go     
    v_compl(go,agent,nil,time_count). 
    v_compl(go,agent,nil,trip).      %% reise en tur
%%     v_compl(go,agent,nil,vehicle).   %% go to X next busy
%%                                      %%   nå går de(pron)  neste bussene .


    v_compl(go,agent,after,agent).    
    v_compl(go,agent,along,place).   
    v_compl(go,agent,between,place). 
    v_compl(go,agent,by,vehicle). 
    v_compl(go,agent,by,foot).

%%%    v_compl(go,agent,except,vehicle).   %% unntatt (med) buss 9
%%%    v_compl(go,vehicle,except,vehicle). %% hvilke busser går unntatt  46

    v_compl(go,agent,for,money). 
    v_compl(go,agent,for,price).  

    v_compl(go,agent,from,coevent).  %% gå ut fra=believe (metaphor)
    v_compl(go,agent,from,meeting).  %% TA-110330
    v_compl(go,agent,from,seat). 
 %%    v_compl(go,agent,from,vehicle).  %% komme til roseborg fra buss 63
 %%          når går neste fra buss -> ooo0
    v_compl(go,agent,from,intelligence). %% :-) vettet Norw  
    v_compl(go,agent,from,meeting).  
         %% ( can you go  ) 
    v_compl(go,agent,from,place).  

    v_compl(go,agent,in,contact).           %% (Norw: komme i kontakt)      
    v_compl(go,agent,in,direction).         %%   go home ! :-)
    v_compl(go,agent,in,group).  
    v_compl(go,agent,in,vehicle). 

    v_compl(go,agent,off,vehicle).   %% man kan gå av 
    v_compl(go,agent,off,station).   %% man kan gå av [på] hpl



%%%    v_compl(go,agent,on,time).    %% PROBLEM 

%    v_compl(go,agent,nil,place).  %% hvilket sted kan jeg ta bussen ( fra/til )
                                   %% jeg går oslo veien  ( road ako place)                        
                                   %% hvordan kommer jeg meg fra OBS
                                   %% Lade >OBS< på heimdal

    v_compl(go,agent,on,christmas). 
    v_compl(go,agent,on,daypart).    %%  Norw på kvelden 
    v_compl(go,agent,on,easter).  
    v_compl(go,agent,on,meeting).   
    v_compl(go,agent,on,midnight).     %% Norw reise midt på natta
    v_compl(go,agent,on,vacation).          %% Norw 
    v_compl(go,agent,on,vehicle).    %% man kan gå på ("spasere innepå ")    v_compl(go,agent,through,place). 

    v_compl(go,agent,to,person).   %%  :-) ** jeg går til Lingit/company/neighbourhood 
    v_compl(go,agent,to,clock).             %% Norwagism = before 
    v_compl(go,agent,to,company). 
    v_compl(go,agent,to,foot). %% Norw til fots 

    v_compl(go,agent,to,place).             %% (figuratively )
    v_compl(go,agent,to,strike). %% :-( 
    v_compl(go,agent,to,summerroute). 
    v_compl(go,agent,to,winterroute).      %% gå over til  FOS

    v_compl(go,agent,via,vehicle).     %% odd
%%    v_compl(go,agent,with,object).   %% Hazard  vehicle ako object    
 
    v_compl(go,agent,with,agent).      %% med AtB
    
    v_compl(go,agent,with,animal).     %% dog, not horse :-)
    v_compl(go,agent,with,person).          %% ( go with me)
    v_compl(go,agent,with,pension). 
    v_compl(go,agent,with,pram). 
    v_compl(go,sgent,with,speed).      %% TA-110520
    v_compl(go,agent,with,vehicle).         %% reise fra A med buss

    v_compl(go,agent,without,transfer). 
    v_compl(go,agent,without,vehicle). %% unnatt (med) buss 5 
    v_compl(go,agent,without,weather). %% "vind" %% :-) 


iv_templ(go,correction). %% rettelse 
iv_templ(go,information).  %% come -> come/go -> go (1 pass)

iv_templ(go,sentence).           %% i.e. come
iv_templ(go,street). %% TA-110121 veien går til nardo
iv_templ(go,summer). %% komme -> go/come
iv_templ(go,sun). 
iv_templ(go,moon).  
iv_templ(go,variant).%% generic for thing
iv_templ(go,wheel).  %% .. rundt :-) 
iv_templ(go,winter).
iv_templ(go,test).            %%  .. bra  

    v_compl(go,test,in,time). %%
    v_compl(go,thing,to,agent). 


    v_compl(go,company,from,place). %% bus -c 
    v_compl(go,company,to,place). 

    v_compl(go,person,nil,day).  
    v_compl(go,person,nil,date). 
    v_compl(go,person,nil,clock). %% time ???
    v_compl(go,person,nil,daypart). 
    v_compl(go,person,after,meeting).
    v_compl(go,person,between,time).  
    v_compl(go,person,between,place). 
    v_compl(go,person,by,vehicle).  
    v_compl(go,person,by,place).  
    v_compl(go,person,for,place). 
    v_compl(go,person,for,activity).     %% (Norwagism)
    v_compl(go,person,in,activity).    %% i møte
    v_compl(go,person,in,direction).
    v_compl(go,person,near,place). 
    v_compl(go,person,on,ski).
              v_compl(go,person,to,vehicle).   %% <--- deliberately
    v_compl(go,person,with,agent).          %% i.e. go with you
    v_compl(go,person,with,departure). 
    v_compl(go,person,with,distance). 
%%     v_compl(go,agent,with,duration).  % stan
    v_compl(go,person,with,ticket). 
    v_compl(go,person,with,speed). 
    v_compl(go,person,with,wheelchair). 

    v_compl(go,person,without,ticket). 
    v_compl(go,person,without,thing). %% money,luggage 

%    v_compl(go,person,withafter,duration). %% OBSOL
%    v_compl(go,person,on,clock).   %% Norwagism  to ... on 1 hour
    v_compl(go,person,on,duration).     %% Jeg går på en time
    v_compl(go,person,within,duration). %% Jeg går innen en time 

    v_compl(go,agent,on,activity).      %%  (Norwagism)
    v_compl(go,agent,on,foot).  %% gå på bena    
    v_compl(go,agent,on,leg).   %% gå på bena
    v_compl(go,agent,on,ticket).        %%  Norw 
    v_compl(go,person,offside,place).   %%  ( e.g. south of)
    v_compl(go,person,outside,place).   %%  (e.g. utenom)
    v_compl(go,agent,past,place). 
    v_compl(go,person,to,activity).
% v_compl(go,person,to,object). %% Not Tram (NONMONOTONIC)
    v_compl(go,person,towards,object).            
    v_compl(go,person,towards,place). 
    v_compl(go,person,with,arrival). %% etc.
    v_compl(go,person,with,company). %% TT 

    v_compl(go,person,with,person).
    v_compl(go,agent,with,ticket). 
    v_compl(go,person,with,transfer).  
%    v_compl(go,person,within,clock). 
%    v_compl(go,person,within,hour). 
%    v_compl(go,person,within,minute). 



iv_templ(go,arrival). 
    v_compl(go,arrival,X,Y):-
        v_compl(go,vehicle,X,Y). 

iv_templ(go,border).
    v_compl(go,border,between,place). 
    v_compl(go,border,to,place).      %%  NOT standard 
    v_compl(go,border,in,place).      %% NEC ??

iv_templ(go,cinema). %%  subclass of place, but qua show
    v_compl(go,cinema,nil,time). 


iv_templ(go,departure). 
    v_compl(go,arrival,nil,vehicle).    %% ankomst flybuss 
    v_compl(go,departure,nil,vehicle).  %% avgang [med] buss
 
    v_compl(go,departure,X,Y):- %%% <-- rule
        v_compl(go,vehicle,X,Y).

iv_templ(go,development). 
    v_compl(go,thing,towards,thing). %% TA-110111



%% iv_templ(go,clock).   %%  does a bus that arrives before 9:30 go ...

iv_templ(go,duration). %% det går 5 minutter 

iv_templ(go,coevent). %% gå galt|dårlig   .. 
    v_compl(go,coevent,nil,mode). 

iv_templ(go,company).

%% Når går  buss forbi moholt på mandag som kommer  til samfundet .
%% iv_templ(go,duration). %% between ... %% NOT time, not Day:
%%                       %%   will a bus that goes before 930 go (to...
%%    v_compl(go,duration,between,departure). 
%%    v_compl(go,duration,between,vehicle). 

iv_templ(go,limit).  %% ambiguous 

iv_templ(go,movie).

iv_templ(go,number).  %%  (qua route) %% går 52 neste gang 
    v_compl(go,number,X,Y):- %% ad hoc 
        v_compl(go,vehicle,X,Y). %%%% NB No inheritance        

% Problem   will a bus that goes before (930 go)
% OK, someone can say   number 52 goes ==> number


iv_templ(go,relation). %%Ad Hoc  hvor lenge kommer forholdet til å vare
                       %% = hvor lenge går forholdet for å vare

    v_compl(go,relation,nil,duration).
    v_compl(go,relation,with,duration).



iv_templ(go,route_plan). %% Winter routes/ summer routes 
    v_compl(go,route_plan,nil,date).  %% ETC.
    v_compl(go,route_plan,nil,place). %% hazard ?
    v_compl(go,route_plan,nil,way).   %% ringrute går en omvei 
    v_compl(go,route_plan,between,place). 
    v_compl(go,route_plan,for,place). 
    v_compl(go,route_plan,from,place). 
    v_compl(go,route_plan,to,place). 
    v_compl(go,route_plan,for,distance). %% special // ruteplan for strekn. 

iv_templ(go,price). 
    v_compl(go,price,in,place). %% UP/DOWN %% Technical
    v_compl(go,price,for,vehicle). 

iv_templ(go,program).  
    v_compl(go,program,on,place).            %%  (Norwagism) ( also TV :-)
    v_compl(go,program,in,computer).        %% i.e.run 
    v_compl(go,program,on,computer). 

iv_templ(go,plane). 
    v_compl(go,plane,nil,time).
    v_compl(go,plane,from,airport). 
    v_compl(go,plane,from,city).    
    v_compl(go,plane,from,country). 
    v_compl(go,plane,to,airport). 
    v_compl(go,plane,to,city).    
    v_compl(go,plane,to,country). 
 

% iv_templ(go,street).   %% går  K gate til ila/ når kommer K gate F+ 
%    når går neste yggdrasilvegen 
%    v_compl(go,street,past,route).  %% Special

    v_compl(go,agent,nil,street).  
    v_compl(go,vehicle,nil,street).


%% NB 
%% iv_templ(go,time).  %% Den første (sept*) går
%% iv_templ(go,clock).     %% når går 131 = klokken (01:30) går 
                        %% * klokken går riktig %% TA-110701

iv_templ(go,day).      %% Hazard

iv_templ(go,transfer).   
    v_compl(go,transfer,to,place).

iv_templ(go,trip). % tur
    v_compl(go,trip,nil,place).   %% tur vollabakken 
    v_compl(go,trip,nil,time). 
    v_compl(go,trip,between,place). 
    v_compl(go,trip,in,place). %% where 
    v_compl(go,trip,from,place).
    v_compl(go,trip,to,place).


iv_templ(go,return). % retur
    v_compl(go,return,nil,place).   %%tur vollabakken 
    v_compl(go,return,to,place).
    v_compl(go,return,in,place). %% where 

%% +++ GO VEHICLE

%% Experiment %%


%% iv_templ(go,thing). %%  Experiment går nardo

    v_compl(go,thing,nil,mode). %% det går bra 
    v_compl(go,thing,nil,departure). %% de går (siste) avgang ... 
    v_compl(go,thing,for,agent).   %% gå greitt for deg ? 
    v_compl(go,thing,from,place).  
    v_compl(go,thing,to,place).      %% OK


    v_compl(go,route_plan,for,vehicle). %% route_plan go for buss 5


iv_templ(go,vehicle).                    
 
    v_compl(go,vehicle,nil,bus). %% buss går (med) siste buss %% haz  ? 
%%%    v_compl(go,vehicle,nil,vehicle).     %%  værnes sentrum  buss 9

%     v_compl(go,vehicle,nil,time).    IS TOO GENERAL (WHY)

    v_compl(go,vehicle,nil,coevent).

    v_compl(go,vehicle,nil,minute).  %% .. before tram stops 
	 v_compl(go,vehicle,nil,arrival). 
    v_compl(go,vehicle,nil,clock). %%  Important  go 1200, not go 5 minutes
    v_compl(go,vehicle,nil,departure).   
    v_compl(go,vehicle,nil,direction).       %% hvilken vei går bussen
    v_compl(go,vehicle,nil,distance). 
    v_compl(go,vehicle,nil,duration).        %%  hour,minute
    v_compl(go,vehicle,nil,day).  
    v_compl(go,vehicle,nil,daypart).         %%   go sunday evening
    v_compl(go,vehicle,nil,date). 
    v_compl(go,vehicle,nil,month). %% cannot answer though
    v_compl(go,vehicle,nil,year). 
    v_compl(go,vehicle,nil,week).  %% no inh
    v_compl(go,vehicle,nil,autumn). 
    v_compl(go,vehicle,nil,winter). 
    v_compl(go,vehicle,nil,spring). 
    v_compl(go,vehicle,nil,summer). 
    v_compl(go,vehicle,nil,semester).
    v_compl(go,vehicle,nil,easter).   
    v_compl(go,vehicle,nil,christmas). %% 
    v_compl(go,vehicle,nil,time_count).  %% 9 times 10 = 9 goes (times) 10'clock  %% bussen går noen ganger 
    v_compl(go,vehicle,nil,midnight).        %%  gå natt til lørdag (Norwagism)
    v_compl(go,vehicle,nil,nightbus).    %% i.e. with nightbus
    v_compl(go,vehicle,nil,route_plan). 
    v_compl(go,vehicle,nil,route).   

     %%   nå går de(pron)  neste bussene . 
    v_compl(go,vehicle,nil,place). 

    v_compl(go,vehicle,nil,way). %%  e.g. omvei

%    v_compl(go,vehicle,about,time).         %% om    10 minutter => during2

    v_compl(go,vehicle,according_to,route_plan).

  %    v_compl(go,vehicle,after,vehicle).        %% PROHIBITED  %    buss går   fra vestlia etter ni (buss ?)

    v_compl(go,vehicle,after,route_plan).  

    v_compl(go,vehicle,after,arrival).    %% båtens ankomst 
    v_compl(go,vehicle,along,place).  
    v_compl(go,vehicle,around,place). 
    v_compl(go,vehicle,as,route_plan). 
    v_compl(go,vehicle,as,route).      %% go as number 9
    v_compl(go,vehicle,as,rule).   %% Norw .. som regel

    v_compl(go,vehicle,before,departure). %% båtens avgang 

%   v_compl(go,vehicle,before,vehicle).  %% cant handle it though 
%                                        %% bus goes before 5 *** %% HAZARD
    v_compl(go,vehicle,between,place). 
    v_compl(go,vehicle,between,time). 
    v_compl(go,vehicle,by,vehicle).     %% go from X by bus 9


% during = i løpet av
% during2 = om

    v_compl(go,vehicle,for,duration). 
    v_compl(go,vehicle,for,place).
    v_compl(go,vehicle,for,vehicle). 
                      %%  (  derived:  buss for rute 66)
                      %% avgang for rute 66
                      %% = avgang går for rute 66
                      %% = vehicle går for tute 66
%%             ***   %% buss går for 10 minutter siden
    v_compl(go,vehicle,for,time_count). 
    v_compl(go,vehicle,for,self).  

    v_compl(go,vehicle,from,direction).   
    v_compl(go,vehicle,from,meeting).  %% TA-110330
    v_compl(go,vehicle,from,place).      
    v_compl(go,vehicle,from,person).   %% self).  -fra- meg \= fra -meg- 
    v_compl(go,vehicle,from,train).    %% i.e. train station
    v_compl(go,vehicle,from,airplane). %% i.e. i.e. airport

    v_compl(go,vehicle,in,average).  %% Technical 
    v_compl(go,vehicle,in,departure). %% ad hoc, rutetid=departure  
    v_compl(go,vehicle,in,direction).  
    v_compl(go,vehicle,in,distance). %% walking_distance 
    v_compl(go,vehicle,in,route_plan). 
    v_compl(go,vehicle,in,sequence). 
    v_compl(go,vehicle,in,speed).  
    v_compl(go,vehicle,in,weather).  
%%    v_compl(go,vehicle,in,week).            %%  unnec

    v_compl(go,vehicle,into,place). 
    v_compl(go,vehicle,near,place).  
    v_compl(go,vehicle,on,distance).  
    v_compl(go,vehicle,on,fuel). 
    v_compl(go,vehicle,on,route).  
    v_compl(go,vehicle,on,route_plan). %% Norw
%     v_compl(go,vehicle,on,place).          %%  (hazardous) bus pass NTH on Gløshaugen

%%    v_compl(go,vehicle,on,route).            %%  (on bus)

%% Problem --------------------------

%   v_compl(go,vehicle,on,time).             %% på tidspunkt/ på 3 minutter  %% Problem
%       v_compl(go,vehicle,on,clock). % on 17.5 = date 
    v_compl(go,vehicle,on,daytime).
    v_compl(go,vehicle,on,christmas). 
    v_compl(go,vehicle,on,date).       %%   Not  go on 19 (aug)
    v_compl(go,vehicle,on,daypart).    %% Norw
    v_compl(go,vehicle,on,easter).  
    v_compl(go,vehicle,on,summer). 
    v_compl(go,vehicle,on,winter). 

%%%    v_compl(go,vehicle,on,duration). 
%%%    OOOPS   bus goes on monday + day ako duration %% SYNDROME 

    v_compl(go,vehicle,on,hour).  %%  på en time 

%%    v_compl(go,vehicle,on,way).            %%  ( Norwagism  på en måte) 
    v_compl(go,vehicle,out_of,place). 
                                       %% rutetid = departure
    v_compl(go,departure,over,vehicle). %% <### rutetider over buss 5

    v_compl(go,departure,in,system). %% metagoric %% virke i bussoraklet

    v_compl(go,vehicle,offside,place).       %% (e.g. sønnenfor 
    v_compl(go,vehicle,outside,place).       %% (e.g. utenom) 
    v_compl(go,vehicle,past,place). 
    v_compl(go,vehicle,through,place). 

%%    v_compl(go,vehicle,to,activity).    %% jobben %%  not til feil
    v_compl(go,vehicle,to,boat). %% TA-100908
    v_compl(go,vehicle,to,job). 

    v_compl(go,vehicle,to,agent).   
    v_compl(go,vehicle,to,airplane).    %% i.e. airport
    v_compl(go,vehicle,to,clock).
%%%     v_compl(go,vehicle,to,company). %% // qua place %% Experiment
    v_compl(go,vehicle,to,date). %% from date is coverd by standard 
    v_compl(go,vehicle,to,day).  %% til mandag ss på mandag %% Norw 
    v_compl(go,vehicle,to,direction).
    v_compl(go,vehicle,to,meeting). 
    v_compl(go,vehicle,to,place).         %% fra 16:00 til 17:00

    v_compl(go,vehicle,to,self). %% person).  % bus comes to me
                                              %  not to tagore

    v_compl(go,vehicle,to,time).    %% bussen går til.. tider % EXPERIMENT 
    v_compl(go,vehicle,to,train).            %%  (train station)

    v_compl(go,vehicle,towards,place).  
    v_compl(go,vehicle,towards,direction). %% nec? 

    v_compl(go,vehicle,via,route).   %% via rute 36
    v_compl(go,vehicle,via,vehicle). %% via buss/båt 

    v_compl(go,vehicle,with,arrival).        %%   Norwagism ( arriving )
    v_compl(go,vehicle,with,vehicle).        %%  no narrowing %% TA-101115

    v_compl(go,vehicle,with,connection).     %%  ( with connection) TO place
    v_compl(go,vehicle,with,departure). 
    v_compl(go,vehicle,with,delay).  
    v_compl(go,vehicle,with,direction). 
    v_compl(go,vehicle,with,distance).       %%  how far
    v_compl(go,vehicle,with,earliness).  %% how early 
    v_compl(go,vehicle,with,lateness).   %% how late
    v_compl(go,vehicle,with,person).         %%   driver :-)/passenger
    v_compl(go,vehicle,with,route).  
    v_compl(go,vehicle,with,route_plan). 
    v_compl(go,vehicle,with,speed).  
    v_compl(go,vehicle,with,tram).  %% Technical  til lian med trikk  
    v_compl(go,vehicle,with,transfer). 
    v_compl(go,vehicle,with,sundayroute).
    v_compl(go,vehicle,with,duration).       %%  (duration?) NOT time ??

    v_compl(go,vehicle,without,transfer). 
    v_compl(go,vehicle,without,person).  %% driver :-)/ passenger

 

%% END  GO VEHICLE

iv_templ(go,job). %% TA-101117 arbeidet går sin gang
    v_compl(go,activity,in,way).

iv_templ(go,version). 

iv_templ(go,world). %% går under :-) 
    v_compl(go,world,in,place).   %% :-) 
    v_compl(go,world,in,time).    %% :-) 
    v_compl(go,world,from,place). %% :-)  Sophies world

iv_templ(go,zone).             %% Fig of sp. // where does the zone go
    v_compl(go,zone,to,place). %% -"-

tv_templ(guess,agent,thing). 

iv_templ(handle2,thing).  %% Norwagism  handle om 
    v_compl(handle2,thing,about,thing).     % ??
    v_compl(handle2,thing,regarding,thing). % ??


iv_templ(happen,thing). 
    v_compl(happen,thing,nil,time). 
    v_compl(happen,thing,at,activity).
    v_compl(happen,thing,with,thing). 
    v_compl(happen,thing,to,time).      %%  til høsten ???
    v_compl(happen,thing,in,vehicle). 
    v_compl(happen,thing,on,vehicle).   %% 

iv_templ(hitchhike,agent).  %% :-)

tv_templ(hold,agent,nil). %% hvor holder du (til) %% TA-101018

tv_templ(hold,agent,thing).
    v_compl(hold,agent,nil,thing). %% hvor holder du (til) %% TA-101018
    v_compl(hold,agent,at,thing). 
    v_compl(hold,agent,for,thing).  
    v_compl(hold,agent,to,thing). 
    v_compl(hold,agent,towards,thing).
  
iv_templ(hurry,agent). %% seg = reciprov 
 

tv_templ(is_caused_by,thing,thing). %% Technical, skyldes 
tv_templ(blame1,thing,thing). %

iv_templ(jump,agent).   
    v_compl(jump,agent,on,vehicle).
    v_compl(jump,agent,from,place). %% :-)
    v_compl(jump,agent,to,place).   %% :-)




tv_templ(keep,company,departure). %% " holde rutetidene
tv_templ(keep,agent,thing).   %% promise/ticket.
tv_templ(keep,place,system).  %% TH har behold BT

    v_compl(keep,agent,for,thing).   %% for kontroll

/*
tv_templ(keep,agent,meeting). %% Norw holde møte 
tv_templ(keep,agent,meeting). %%
tv_templ(keep,agent,job).     %% e.g activity, but job ako place.
tv_templ(keep,agent,speech).  %% Norwagism holde tale 
*/


%% iv_templ(know1,agent). %% do you know about route 4
                           %% hvilken ting vet () ? *
                           %% hva kan [du] busstuc

tv_templ(know,agent,nil).  %% I don't know %% TA-110411


tv_templ(know,agent,thing).               %% ambig
    v_compl(know,agent,about,thing). 
    v_compl(know,agent,regarding,thing).  %% about 
    v_compl(know,agent,to,thing).         %% to (Norwagism)

tv_templ(know1,agent,thing).               %% (kjenne) %% ad hoc ?
    v_compl(know1,agent,about,thing). 
    v_compl(know1,agent,regarding,thing).  %% about 
    v_compl(know1,agent,to,thing).         %% to (Norwagism)

iv_templ(land,airplane).  


iv_templ(laugh,person). 
    v_compl(laugh,agent,of,thing). %% TA-110116    

iv_templ(lead,thing). 
    v_compl(lead,thing,to,thing). 


%% iv_templ(learn,agent). 
%% tv_templ(learn,agent,nil). %% ?
tv_templ(learn,agent,thing). %% e.g. teach (same in Norw)

%% LEAVE 

%% NB leave2 is Norwagism (forlate) and is strictly transitive 

tv_templ(leave2,agent,thing).   %% Norwagism (forlate)
tv_templ(leave2,vehicle,place).  %% Norwagism (forlate)
    v_compl(leave2,vehicle,to,place). %% technical forlate A til B
    v_compl(leave2,vehicle,nil,time). %% 

%%%  v_compl(leave2,A,B,C):- %%   vako(leave2,leave)
%%        v_compl(leave,A,B,C).

%% LEAVE (from/to etc)

tv_templ(leave,person,thing).  
tv_templ(leave,vehicle,place). 

iv_templ(leave,person). 
    v_compl(leave,person,between,time).     
    v_compl(leave,person,from,place).
    v_compl(leave,person,for,place). 
    v_compl(leave,person,to,place).
    v_compl(leave,person,by,vehicle).  
    v_compl(leave,person,in,direction). 
    v_compl(leave,person,nil,direction). 
    v_compl(leave,person,with,vehicle). 


iv_templ(leave,vehicle).  %% når forlater 60 sentrum 
    v_compl(leave,vehicle,nil,direction). 
    v_compl(leave,vehicle,between,time). 

    v_compl(leave,vehicle,for,place). 
    v_compl(leave,vehicle,from,place).
    v_compl(leave,vehicle,in,direction). 
    v_compl(leave,vehicle,on,time).
    v_compl(leave,vehicle,to,place). 
    v_compl(leave,vehicle,towards,place).  


%% abnormalverb(lie1,_). %% not lie in time %% so what 


iv_templ(lie1,thing). %% metagoric (e.g. in DB) 

    v_compl(lie1,thing,after,thing). %%  ligger turen etter midnatt
    v_compl(lie1,thing,before,thing). %%  ligger turen etter midnatt
    v_compl(lie1,thing,at,thing). %%  ved eksport
    v_compl(lie1,thing,as,thing).
    v_compl(lie1,thing,for,system). 
    v_compl(lie1,thing,in,system).
    v_compl(lie1,thing,in,type).   %% ad hoc  , metagoric 
    v_compl(lie1,thing,in,variant).
    v_compl(lie1,place,on,vehicle). %% Metagorical holdeplass ligger på buss 52

    v_compl(lie1,departure,from,place). %% special Metagorial
%   v_compl(lie1,station,in,time). %%  ... når man tar buss 3  %% doesnt help
    v_compl(lie1,station,within,place).                             
    v_compl(lie1,thing,in,place).  
    v_compl(lie1,thing,as,thing). 
%%    v_compl(lie1,place,nil,place).   %% hpl ligger haukåsen
    v_compl(lie1,object,below,object). %% OK all subclasses
    v_compl(lie1,thing,with,thing).    %%  ligger med fotnote . 
    v_compl(lie1,place,around,place).  
    v_compl(lie1,place,at,place).  
    v_compl(lie1,place,at,route).      %%  holdeplass langs rute
    v_compl(lie1,place,between,place). 
    v_compl(lie1,place,inside,route_plan).  %% rutenettet 
    v_compl(lie1,place,for,route).
    v_compl(lie1,thing,in,database). %% metagoric (info about)
    v_compl(lie1,place,in,distance). 
    v_compl(lie1,place,in,relation). 
    v_compl(lie1,place,near,place). 
    v_compl(lie1,place,on,route).
    v_compl(lie1,place,on,latitude). %% measure %% TA-100902
    v_compl(lie1,place,on,place).
    v_compl(lie1,station,in,street). %% i.e. station 
    v_compl(lie1,station,on,street).
    v_compl(lie1,place,with,route).

    v_compl(lie1,program,on,computer).
    v_compl(lie1,station,on,trip). %% Very Special // ligger på veien
    v_compl(lie1,thing,after,place).  
    v_compl(lie1,thing,before,place). 
    v_compl(lie1,thing,on,network). %% i.e. information about
    v_compl(lie1,thing,on,place). 
    v_compl(lie1,thing,on,plan).    %%  metagoric                               


iv_templ(lie2,agent).    % lyve

iv_templ(listen,agent). 
    v_compl(listen,agent,on,agent).   %% Norwagism 
    v_compl(listen,agent,on,object).  %% tv 
    v_compl(listen,agent,on,sound).  
    v_compl(listen,agent,to,agent).
    v_compl(listen,agent,to,sound). 

iv_templ(live,agent).   % I live in lade (and) tonight I..
    v_compl(live,agent,nil,place). %% Bo etsted 
    v_compl(live,agent,nil,time_count). 
    v_compl(live,agent,nil,minute). %% no inh.  -- from NTH 

    v_compl(live,agent,as,agent).
    v_compl(live,agent,below,place).  %% Experiment/ more general
    v_compl(live,agent,in,computer).  %% :-)
    v_compl(live,agent,in,vehicle).   %% :-) 
    v_compl(live,agent,from,place).   %% ..(away) from
    v_compl(live,agent,from,time).    %% bo
    v_compl(live,agent,near,place).  
%    v_compl(live,agent,in,year).     %% NOT tonight NB
    v_compl(live,agent,to,time).  %% bo

iv_templ(long,agent).
    v_compl(long,agent,for,place). 
    v_compl(long,agent,in,place).   %% ( e.g. home Necessary IF Adverbial )
    v_compl(long,agent,to,place).                                      

iv_templ(look,agent). %%  se ut = appear (qv) %% TA-101210 ...
%%    v_compl(look,thing,in,mode).  %% 
%%    v_compl(look,thing,like,thing). %% appear

    v_compl(look,agent,on,thing). %%  .. on TV
    v_compl(look,agent,to,thing). %% Norw (se frem til) 

%%    dtv_templ(look,thing,nil,mode). %% se slik ut (eg. appear thus) %% RS-121118

iv_templ(meet2,vehicle).
iv_templ(meet2,agent). 

iv_templ(move,agent). 
    v_compl(move,agent,from,place). 
    v_compl(move,agent,to,place). 
    v_compl(move,agent,on,thing). %% incl seg Norw 

iv_templ(open,office). 
iv_templ(open,neighbourhood). %% qua office
iv_templ(open,shop). 
    
tv_templ(open,agent,window). 
iv_templ(operate,agent). 
tv_templ(operate,agent,thing). 
%% iv_templ(operate,company). 

v_compl(operate,agent,with,thing).

tv_templ(order,agent,ticket). %% (bestille rom) på mandag # 
                              %% bestille frokost = time

    v_compl(order,agent,nil,clock). %%           lø 12
    v_compl(order,agent,on,time).   %% på mandag
    v_compl(order,agent,to,time).   %% 

iv_templ(park,person). 
iv_templ(park,vehicle). 

tv_templ(park,driver,vehicle).

iv_templ(pay2,thing).  %% lønne seg

%% iv_templ(pay,agent).    %% without paying

tv_templ(pay,agent,nil). %% PAY=PAY SOMETHING %% EXPERIMENT

tv_templ(pay,agent,money).
    v_compl(pay,agent,nil,date). 
    v_compl(pay,agent,in,bill). 
    v_compl(pay,agent,in,vehicle).
    v_compl(pay,agent,for,object). %% too specific
    v_compl(pay,agent,for,agent). 
    v_compl(pay,agent,on,vehicle).
    v_compl(pay,agent,for,trip).   %%
    v_compl(pay,agent,as,person).
    v_compl(pay,agent,with,card). 
tv_templ(pay,agent,object). 



tv_templ(plan,agent,thing).
tv_templ(plan,agent,nil). %% vi planlegger.



%% iv_templ(play,person). 
tv_templ(play,agent,nil). 
tv_templ(play,agent,game). 
    
    v_compl(play,person,for,country). 
    v_compl(play,person,on,team).     

tv_templ(please,thing,agent). %% det gleder meg %%  (enjoy?)

iv_templ(point,thing).
    v_compl(point,thing,at,thing). %%  busstuc.lingit.no points to server 
    v_compl(point,thing,to,thing). %% Norw 

iv_templ(practise,person). 
    v_compl(practise,person,upon,thing).

iv_templ(proceed,person).  

tv_templ(propose,agent,thing). 
iv_templ(propose,agent). %% John was proposed to go
    v_compl(propose,agent,to,agent).  %% propose to mary 
%%%     v_compl(propose,agent,nil,agent). %% propose mary ???
    v_compl(propose,agent,instead_of,thing). %% TA-110111


tv_templ(puncture,person,nil).  %% Norw.
tv_templ(puncture,vehicle,nil). 

%% iv_templ(puncture,person). 
%% iv_templ(puncture,vehicle).


tv_templ(puncture,person,wheel).
tv_templ(puncture,vehicle,wheel).

tv_templ(push,agent,button). %% eng
iv_templ(push,agent).        %% nor
    v_compl(push,agent,on,button). %% \+  push agent button on button


iv_templ(quit,agent).

iv_templ(rain,weather). 
iv_templ(snow,weather). 


iv_templ(react,thing).
    v_compl(react,thing,on,thing).  %% TA-110701
tv_templ(read,agent,thing). %% dette blir lest 

tv_templ(read,agent,nil). 
iv_templ(read,agent). 

    v_compl(read,agent,nil,page). %% les (på) side 16
    v_compl(read,agent,in,information). 
    v_compl(read,agent,on,mailaddress).  %% etc 
    v_compl(read,agent,on,webaddress).   %% 
    v_compl(read,agent,regarding,thing). %%\ about
    v_compl(read,agent,from,thing).

tv_templ(read,agent,departure).        %% " Rutetid"
tv_templ(read,agent,information). 
tv_templ(read,agent,route).       %% e.g. route_plan
tv_templ(read,agent,route_plan).
tv_templ(read,agent,sentence). 


tv_templ(regard,agent,thing). 

tv_templ(register,agent,thing).
    v_compl(register,agent,in,system). 
    v_compl(register,agent,in,information). 

tv_templ(regret,agent,thing). 

tv_templ(relate,agent,thing).
    v_compl(relate,agent,to,thing). 

tv_templ(release,agent,thing).         %% TA-110330
tv_templ(release,neighbourhood,thing). %% Rogaland frigir sanntidsdataene.

iv_templ(remain,thing).
    v_compl(remain,thing,on,thing). 
    v_compl(remain,thing,to,time).    %% inntil -> to/until
    v_compl(remain,thing,until,time). %%

%% iv_templ(repeat,agent).
tv_templ(repeat,agent,nil).   
tv_templ(repeat,agent,activity). 
tv_templ(repeat,agent,sentence). 
tv_templ(repeat,agent,agent).  %%   repeat oneself

tv_templ(report,agent,thing). 
tv_templ(report,agent,nil).  
    v_compl(report,agent,to,agent). 

tv_templ(replace,agent,thing). 

tv_templ(require,thing,thing). 

iv_templ(retire,agent).


iv_templ(revolve,thing). 
    v_compl(revolve,thing,around,thing).


%% tv_templ(run,otherbus,route). 

%%% NB   new relation v_templ includes iv_templ

tv_templ(run,agent,agent). %% du kjører meg %% TA-110105
tv_templ(run,agent,program). 
tv_templ(run,agent,trip).
tv_templ(run,agent,route_plan).
tv_templ(run,agent,vehicle).
tv_templ(run,company,vehicle).
    v_compl(run,company,nil,departure). %% tt kjører [] rutetide


tv_templ(run,vehicle,agent).   %% ambiguous
tv_templ(run,vehicle,trip).    %% ambiguous
tv_templ(run,vehicle,station). %% kjøre en stasjon
tv_templ(run,vehicle,route_plan).
tv_templ(run,vehicle,route).
tv_templ(run,vehicle,person).


    v_compl(run,agent,nil,distance).   %% TA-110427
    v_compl(run,vehicle,nil,distance). %%
 
    v_compl(run,agent,nil,zone). 
    v_compl(run,agent,nil,route_plan). %% vi kjører søndagsrute   

    v_compl(run,agent,from,day). %% kjøre søndagsrute     %% TA-110504
    v_compl(run,thing,to,day).   %% fra mandag til onsdag %% (to time \= stanprep)

    v_compl(run,thing,with,vehicle). %% ? noen kjører med buss
    v_compl(run,agent,with,vehicle). 
    v_compl(run,agent,with,speed).   %% TA-110520

%%     v_compl(run,agent,to,day).   %%   special
    v_compl(run,agent,to,time). %% kjøre buss natt til 2/1

    v_compl(run,program,on,system).
    v_compl(run,program,on,operatingsystem).
    v_compl(run,program,with,operatingsystem). 

    v_compl(run,vehicle,nil,zone). %%
    v_compl(run,vehicle,nil,direction). 
    v_compl(run,vehicle,nil,neighbourhood). %%  kjøre innherredsveien
    v_compl(run,vehicle,with,speed). %% TA-110701

%% iv_templ(run,thing). %% begge disse kjører fra samme instans
                        %% varighet kjører
    iv_templ(run,vehicle). 
    iv_templ(run,agent).
    iv_templ(run,system).

    v_compl(run,thing,from,version).

iv_templ(run,agent).   %% jeg kjører [] en sone

iv_templ(run,river).
    v_compl(run,river,past,place). %% gjennom=past (veh)
    v_compl(run,river,through,place).
%% iv_templ(run,river). % synonym with flow, but only for rivers


iv_templ(run,vehicle). % = go  
    v_compl(run,vehicle,at,speed). 
    v_compl(run,vehicle,between,place).   
    v_compl(run,vehicle,between,time).
    v_compl(run,vehicle,by,place).
    v_compl(run,vehicle,from,place).
    v_compl(run,vehicle,in,direction).
    v_compl(run,vehicle,in,speed).  
    v_compl(run,vehicle,on,time). 
    v_compl(run,vehicle,past,place).  
    v_compl(run,vehicle,past,person). %% ?
    v_compl(run,vehicle,through,place).
    v_compl(run,vehicle,to,place).
    v_compl(run,vehicle,towards,place).


iv_templ(run,route_plan). %% kjøres søndagsruter 

    v_compl(run,vehicle,past,place). 

    v_compl(run,thing,through,place).
    v_compl(run,thing,towards,place).   
    v_compl(run,thing,towards,direction). 

iv_templ(sail,agent). 
iv_templ(sail,vehicle).
    v_compl(sail,agent,with,boat). 


iv_templ(see,vehicle). %% se ut Norwagism 
                     %% buss kom til moholt så fort som mulig// moholt ser

iv_templ(search,agent).
    v_compl(search,agent,on,thing).
    v_compl(search,agent,dir,thing).    %% jeg søker  asyl %% NB   DIR 
%     v_compl(search,agent,nil,thing).  %% jeg søker (i) et sted     %% adjunct
    v_compl(search,agent,after,thing).  %%  (Norwagism)
    v_compl(search,agent,for,thing). 

tv_templ(see,agent,thing).
    v_compl(see,agent,nil,page). %% se .. side 86 
    v_compl(see,person,with,telescope). 
    v_compl(see,agent,nil,place). %%  ?
    v_compl(see,person,with,telescope).
%     v_compl(see,person,at,shop).   
    v_compl(see,agent,from,vehicle).  
    v_compl(see,agent,in,route). %% se i rute 

%% tv_templ(see,agent,nil). %% <--- ?
iv_templ(see,agent). %%  (i.e. look) Norwagism
    v_compl(see,agent,on,thing). 
    v_compl(see,agent,to,thing). %% Norw (se frem til) 





tv_templ(seek,agent,thing). 

iv_templ(serve,person).
    v_compl(serve,person,under,person).    
tv_templ(serve,bus,place).
       

%% iv_templ(shop,person).

tv_templ(shop,person,nil). 
tv_templ(shop,person,object).


tv_templ(shorten,agent,thing). %% reise(tide)n
    v_compl(shorten,agent,on,thing). %% forkorte reisen på måte

tv_templ(show,agent,thing). 
tv_templ(show,information,thing). %% TA-101102 

tv_templ(show,clock,time). 
tv_templ(show,map,thing). 
tv_templ(show,vehicle,information). %% i front 
tv_templ(show,ticket,thing).  %%  metagoric

% iv_templ(show,vehicle). %% shows up 
                          %% show usually (di) transitive
    v_compl(show,agent,for,agent). 
    v_compl(show,agent,on,question). 
    v_compl(show,agent,without,proposal). %% oppfordring 
    v_compl(show,agent,without,question). %% uoppfordret

    v_compl(show,agent,at,activity). %% sale/use 


%% tv_templ(silence.agent,agent). %% få noen til å 
iv_templ(silence,agent). %% e.g. tie , keep silence

tv_templ(sing,agent,song).  %% :-)
tv_templ(sing,agent,nil).   %% Experimet  Sing=sing something
                            %% iv_templ(sing,agent).  
    v_compl(sing,agent,in,vehicle).
    v_compl(sing,agent,on,vehicle). %%  (Norw)
    v_compl(sing,agent,for,person). 




iv_templ(sit,agent). 
    v_compl(sit,agent,behind,agent). %% who %% TA-101022
    v_compl(sit,agent,beside,agent). %%

    v_compl(sit,agent,on,company).       %%  Norw
%    v_compl(sit,agent,in,computer).     %%  :-))))
    v_compl(sit,agent,at,computer).  
    v_compl(sit,agent,on,computer). 
    v_compl(sit,agent,in,seat). 
    v_compl(sit,agent,on,seat). 
    v_compl(sit,agent,in,vehicle). 
    v_compl(sit,agent,on,vehicle).
    v_compl(sit,agent,on,information).   %%  Norw :-)))))    
    v_compl(sit,agent,from,place). 
    v_compl(sit,agent,to,place). 

 iv_templ(sleep,agent).
    v_compl(sleep,person,with,person).       %% :-)
    v_compl(sleep,agent,on,vehicle).  %% :-) 
%    v_compl(sleep,agent,in,mode).        %% har du sovet godt ?

iv_templ(smile,agent).                       %% :-)
    v_compl(smile,agent,to,agent). 
iv_templ(laugh,agent).  
    v_compl(laugh,agent,at,agent). 
    v_compl(laugh,agent,off,agent).   %%  (Norwagism: av)

iv_templ(smoke,agent).
    v_compl(smoke,agent,in,vehicle).
    v_compl(smoke,agent,on,vehicle).      %%  (Norw)
    v_compl(smoke,agent,outside,vehicle).

iv_templ(sneak,agent).
    v_compl(sneak,agent,on,vehicle). %% (man)
    v_compl(sneak,agent,to,place).
    v_compl(sneak,agent,in,vehicle).
    v_compl(sneak,agent,into,vehicle).

tv_templ(speak,agent,language). 
tv_templ(speak,agent,sentence). %% snakke tull

iv_templ(speak,agent). 
%%  tv_templ(speak,agent,nil). %%  NO  speak with \= speak something

    v_compl(speak,agent,to,agent).
    v_compl(speak,agent,about,thing). 
    v_compl(speak,agent,with,agent). 
    v_compl(speak,agent,regarding,thing). 
    v_compl(speak,agent,in,language).  %% Norwagism
    v_compl(speak,agent,in,telephone). 
    v_compl(speak,agent,on,language).  %% Norwagism


iv_templ(squeak,animal).

iv_templ(stand,thing).
   v_compl(stand,thing,behind,thing). 
   v_compl(stand,thing,for,thing). 
   v_compl(stand,thing,in,information). %% stå i rutehefte Norw
   v_compl(stand,thing,on,information). %% Norw  står på %% paper, roof %% TA-101013
   v_compl(stand,thing,in,thing).       %% stå igjen i ruten  // Difficult 
   v_compl(stand,agent,in,vehicle).     %% stå i bussen
   v_compl(stand,agent,off,vehicle).    %% Dial.  stå av = gå av
   v_compl(stand,thing,on,object).      %%
   v_compl(stand,thing,outside,place).  %% object ?
   v_compl(stand,agent,to,service).  %% Norwagism 

iv_templ(stay,thing).

%% iv_templ(study,agent).  

tv_templ(study,agent,nil).  %% study=study something 
tv_templ(study,agent,thing).  


iv_templ(strike,agent). 
iv_templ(strike,bus).  
iv_templ(strike,company). 
    v_compl(strike,thing,nil,date). 

tv_templ(survive,agent,thing).     %% TA-101117
    tv_templ(survive,agent,nil).   %%

iv_templ(swim,person). %% agent). %%  to allow question :-))))

tv_templ(talk,agent,language). %%  ad hoc // speak
iv_templ(talk,agent).
    v_compl(talk,agent,in,telephone). 
    v_compl(talk,agent,of,thing).  %% skryte  Norw        
    v_compl(talk,agent,to,agent).        %% etc = speak
    v_compl(talk,agent,about,thing).     %% etc = speak 
    v_compl(talk,agent,regarding,thing). %% etc = speak
    v_compl(talk,agent,with,agent).    
    v_compl(talk,agent,on,vehicle).      %% TA-110308

tv_templ(taste,agent,food). 
iv_templ(taste,food).       %% different meanings

iv_templ(thank,agent). 
tv_templ(tank,agent,agent). 
    v_compl(thank,agent,for,thing).

%% tv_templ(think,thing,meta). %% what do you think about

tv_templ(think,agent,meta). %% hva tenker maria=marka på

iv_templ(think,agent).  %% **jeg tenker (for å gjøre meg i stand til)  å ta bussen
                        %% tenker å --> vil
    v_compl(think,agent,after,coevent). %% TA-110106
    v_compl(think,agent,on,thing). 
    v_compl(think,agent,over,thing).  
    v_compl(think,agent,logically,nil).     %% <-- experiment?
    v_compl(think,agent,regarding,thing).   %% om 


iv_templ(thrive,agent).  %%  Norw:  trives

    v_compl(thrive,agent,in,activity). %% e.g. job 

%% travel = go ???

iv_templ(travel,vehicle). %%  travel vehicle = go vehicle 
 %%   v_compl(travel,vehicle,X,Y):-  %% gen. vako 
 %%       v_compl(go,vehicle,X,Y).    %% NB NB NB 
    v_compl(travel,vehicle,in,direction).  
    v_compl(travel,vehicle,nil,direction).   


iv_templ(travel,person).
    v_compl(travel,person,X,Y):-   v_compl(go,person,X,Y).    %% NB NB NB 
    v_compl(travel,person,nil,direction).   
    v_compl(travel,person,by,vehicle). %% by 6 pm | by route 6 
    v_compl(travel,person,through,place). 
    v_compl(travel,person,on,vehicle).
    v_compl(travel,person,in,direction).  
    v_compl(travel,person,with,vehicle).
    v_compl(travel,person,without,object). 


iv_templ(trust,agent). %% Norwagism
    v_compl(trust,agent,on,thing). 

tv_templ(try,agent,thing). 
tv_templ(try,agent,nil).  %% prøvde fra flere steder
%%% iv_templ(try,agent). 
    v_compl(try,agent,from,place). 


tv_templ(turn,agent,object). 

iv_templ(turn,vehicle). 
iv_templ(turn,agent).       %%  ( " henvende (seg) ")
iv_templ(turn,webaddress).   %% qua server 
    v_compl(turn,agent,to,thing). 
    v_compl(turn,webaddress,to,thing). %% ad hoc
    v_compl(turn,agent,regarding,thing). 


iv_templ(wait,agent).
    v_compl(wait,thing,to,coevent).    %% = until
    v_compl(wait,thing,until,coevent). %% TA-110106
    v_compl(wait,agent,nil,place).
    v_compl(wait,agent,nil,duration). 
    v_compl(wait,agent,nil,duration).    % wait an hour
    v_compl(wait,agent,at,time).  
    v_compl(wait,agent,for,vehicle).
    v_compl(wait,agent,for,person).    %% ?
    v_compl(wait,agent,in,vehicle). 
    v_compl(wait,agent,on,thing). %% activity).  
 
%    v_compl(wait,agent,on,person).     %% norw 
%    v_compl(wait,agent,on,vehicle).    %%  (Norwagism)

    v_compl(wait,agent,to,time).       %%  (Norwagism) 
    v_compl(wait,agent,with,duration). %%  (techn:  how long)
    v_compl(wait,agent,without,thing). %% respons

iv_templ(wait,trip). %%  i.e. kjøring
    v_compl(wait,thing,to,activity). %%

iv_templ(wait,vehicle).  
     v_compl(wait,vehicle,in,place).     %% TA-100905
    v_compl(wait,vehicle,with,duration). %% etc 
    v_compl(wait,vehicle,for,person).    %% :-(
    v_compl(wait,vehicle,on,person).     %% norw 



iv_templ(walk,agent).  %% man.
/* gen  vako %%
    v_compl(walk,agent,along,place). 
    v_compl(walk,agent,nil,clock).  
    v_compl(walk,agent,down,place).   %%   (road :-)
    v_compl(walk,agent,from,vehicle). 
    v_compl(walk,agent,from,place). 
    v_compl(walk,agent,to,vehicle). %
    v_compl(walk,agent,to,place). 
    v_compl(walk,agent,with,agent). 
*/


iv_templ(wave,agent).  %%  ( give signal)
    v_compl(wave,agent,to,agent).  
    v_compl(wave,agent,to,vehicle).

iv_templ(win,person).


iv_templ(function,thing). %% det virker 
    v_compl(function,thing,nil,mode). %% e.g. dårlig/direkte 

    v_compl(function,thing,to,thing). 
    v_compl(function,thing,from,thing). 

    v_compl(function,thing,for,thing).  %% 
    v_compl(function,thing,in,language).  

    v_compl(function,thing,on,agent).     %% det virker på meg %%  Norw
    v_compl(function,thing,on,language).  %% Norw ion

    v_compl(function,thing,via,thing).    %% viker via sms 
    v_compl(function,thing,with,thing).   %% Norw ion

%% iv_templ(function,activity).  %% tjenesten fungerer
%% iv_templ(function,system). 

iv_templ(function,agent).  %%  fungere
    v_compl(function,agent,as,agent). 
    v_compl(function,agent,at,company). 
    v_compl(function,agent,on,place).  
    v_compl(function,agent,with,thing).  


iv_templ(work,agent). 
    v_compl(work,agent,nil,time). %% overtid 
    v_compl(work,agent,as,agent). 
    v_compl(work,agent,at,company). 
%              v_compl(work,agent,for,company). %% what was the trouble???
%              v_compl(work,agent,in,company). 
    v_compl(work,agent,for,office).
    v_compl(work,agent,for,agent).  
    v_compl(work,agent,in,company).  
    v_compl(work,agent,in,office).
    v_compl(work,agent,on,company). 
    v_compl(work,agent,on,office).  
 
    v_compl(work,agent,on,place).     %%  (Norwagism)
    v_compl(work,agent,on,route_plan).%%  (Norw.)
    v_compl(work,agent,on,vehicle).  
        v_compl(work,agent,in,vehicle).%%
    v_compl(work,agent,with,thing).   %%  (  company,etc..)


iv_templ(work,activity).              %%  ( service)
iv_templ(work,medicine). 
iv_templ(work,ticket).                %% i.e. gjelde 
iv_templ(work,vehicle). 

iv_templ(worry,agent).                %% incomplete
    v_compl(worry,agent,about,thing).  
    v_compl(worry,agent,regarding,thing). %% ?

%%%%%%%%% DiTransitive Verb templates    %%%%%%%% 


dtv_templ(allow,agent,agent,thing).  %% I allow him (to leave)

dtv_templ(ask,agent,agent,thing).  
dtv_templ(ask,agent,agent,thing).  

dtv_templ(bring,agent,agent,thing).  %% I brought him a beer
dtv_templ(buy,agent,agent,thing).    %% kjøpe seg billett 

dtv_templ(call,agent,thing,thing).   %% I called him a man
dtv_templ(give,agent,thing,thing).   %% I brought mary an apple
dtv_templ(give,thing,agent,thing).   %% kortet gir deg valg // avoid thing thing 
dtv_templ(fine,agent,agent,money).   %% Politiet ilegger meg en bot 

dtv_templ(let,agent,agent,thing).    %% I let him (to) leave 
dtv_templ(look,thing,nil,mode). %% se slik ut (eg. appear thus)
dtv_templ(name,agent,thing,thing).   %% I named it  BussTUC
dtv_templ(owe,agent,thing,thing).    %% I owe you 10 crowns
dtv_templ(sell,agent,thing,thing).   %% I sold Team a program
dtv_templ(send,agent,thing,thing).   %% I sent him a package//NB not places
dtv_templ(secure,agent,agent,thing). %% sikre seg
dtv_templ(set,agent,agent,thing).    %% jeg stiller deg et spørsmål (Techn) 
dtv_templ(show,agent,thing,thing).   %% I showed him the ticket
dtv_templ(tell,agent,agent,thing).   %% I told him a joke
dtv_templ(wish,agent,agent,thing).   %% I wish you a merry christmas




%%%%%%%%% Ordinary Verb Templates  %%%%%%%%

iv_templ(add,person).  

tv_templ(add,person,number).
    v_compl(add,person,to,number).
%    v_compl(add,person,in,mode).   %% together

tv_templ(adjust,agent,thing). %% ordne ting %% ? %% Norw
    v_compl(adjust,agent,nil,mode). %% direkte

tv_templ(adjust,agent,time). %% klokka  subsumed?


tv_templ(admit,agent,agent). %% whodidit
    v_compl(admit,agent,to,hospital).
    v_compl(admit,agent,from,hospital). 


tv_templ(admit,hospital,patient).
     v_compl(admit,hospital,to,ward).
 
  
%% tv_templ(arrive,vehicle,place).   %%  Also transitive ==> reach 

tv_templ(avoid,agent,thing).  
tv_templ(avoid,vehicle,thing). 

%%%%%%%  BE2  Transitive  be (hete, kalles)


tv_templ(be2,agent,year). %% ad hoc du er .. år 

tv_templ(be2,thing,thing). 
%  tv_templ(be2,vehicle,departure).   %% which buses are last departure (SIC) 
%  tv_templ(be2,vehicle,vehicle).     %% the first bus is bus 5 now
%  tv_templ(be2,time,time).           %% en time er 60 minutter

    v_compl(be2,thing,nil,date).    %% Ad Hoc   (noe) er vanlige ruter julaften 
    v_compl(be2,thing,for,thing).  
    v_compl(be2,thing,on,activity). 

%
%  noe er vanlige ruter julaften ::: be2  rute julaften


iv_templ(befind,thing). 
tv_templ(befind,thing,thing). %%  I befind myself ... (Norwagism)  

iv_templ(belong,thing). 
        v_compl(belong,thing,to,company). 
        v_compl(belong,thing,to,agent). 

iv_templ(beworry,agent). 
    v_compl(beworry,agent,over,thing). 

tv_templ(belong_to,thing,thing). %% tilhører tt %% TA-110707

tv_templ(boil,person,liquid).
tv_templ(boil,person,food).  
% tv_templ(border,surface,surface).     
tv_templ(borrow,person,thing). 
    v_compl(borrow,person,from,person). 

tv_templ(be_named,thing,thing). %% meta).  No Coercion Syndrome 
    v_compl(be_named,thing,from,thing).  %% kalles ut ifra Turings test
    v_compl(be_named,thing,according_to,thing).
    v_compl(be_named,thing,to,thing). %% hete til etternavn

iv_templ(be_urgent,thing). %% Norw  haste 
    v_compl(be_urgent,thing,with,thing).

tv_templ(bear1,animate,object).   


/*  NEW Structure  fødes = iv
tv_templ(bear2,woman,agent). %% Just to allow the question when are you born ?? :-)     
*/


tv_templ(beat,agent,agent). %% in chess
tv_templ(bite,animate,animate).
tv_templ(break,animate,object).


tv_templ(bring,agent,bicycle).  %% i.e. vehicle
tv_templ(bring,agent,agent). 
tv_templ(bring,agent,object).   %% ta med på bussen
tv_templ(bring,agent,animate).  %% ..hund/barn  
tv_templ(bring,agent,money).    %% thing is too general (COMIX) 
tv_templ(bring,agent,abstract). %% problems :-(
tv_templ(bring,vehicle,agent).  %% TA-110128

    v_compl(bring,agent,on,vehicle). %% take with me on the bus
    v_compl(bring,vehicle,to,place). 


%% BUY

%% buy  bus = buy nil + srel/nil/vehicle
tv_templ(buy,agent,nil). %%  Buy = buy something 

tv_templ(buy,agent,object).   %% comes first (buy car) // who=>agent
tv_templ(buy,agent,system).   %% \+ person %% TA-110725

                            
%% buy 1 ... / NOT tram




tv_templ(buy,agent,food). 
tv_templ(buy,agent,liquid). %% :-))))) 
tv_templ(buy,agent,house). 

tv_templ(buy,agent,program). %% tuc

tv_templ(buy,agent,route_plan). %% rutehefte

tv_templ(buy,agent,system). %% e.g. PC 
tv_templ(buy,agent,ticket). 
tv_templ(buy,agent,trip). 

    v_compl(buy,agent,nil,place). 
    v_compl(buy,agent,nil,vehicle).
    v_compl(buy,agent,in,vehicle).
    v_compl(buy,agent,on,vehicle).
    v_compl(buy,agent,for,agent). 
    v_compl(buy,agent,from,agent).
    v_compl(buy,agent,off,agent).  %%  Norw
    v_compl(buy,agent,to,agent).   %%  Norw
    v_compl(buy,agent,to,time).    %%  Norw til lørdag
    v_compl(buy,agent,via,servicecenter). 
    v_compl(buy,agent,via,webaddress). 

iv_templ(calculate,agent).
     v_compl(calculate,agent,with,thing). %% inc coevent

iv_templ(call,agent). 
    v_compl(call,agent,for,thing). %% Dial.  Jeg kaller meg (for) Tore
    v_compl(call,agent,to,agent). 

% Jeg ringer et sted
% tv_templ(call,agent,thing).  %% call is ambiguous

tv_templ(call,agent,agent). 
tv_templ(call,person,thing).
    v_compl(call,agent,nil,place). %% ringe et sted
    v_compl(call,agent,to,place).  %% phone 
    v_compl(call,agent,pro,agent).           %% (artificial)
    v_compl(call,agent,from,place).
    v_compl(call,agent,from,vehicle).          %% semi place
    v_compl(call,agent,for,vehicle).  
    v_compl(call,agent,after,vehicle).

tv_templ(cancel,agent,thing). %% (abstract) // is bus cancelled 

    v_compl(cancel,agent,nil,thing). %% time/coevent

    v_compl(cancel,agent,before,thing). %% time/coevent
    v_compl(cancel,agent,after,thing). 

tv_templ(carry,person,thing). 

tv_templ(catch,animate,animate).

tv_templ(cause,thing,thing). %% medføre



%% Change

iv_templ(switch,agent).    %% veksle (Norw) 
    v_compl(switch,agent,to,vehicle).
    v_compl(switch,agent,in,place).   %% unnec ? 
    v_compl(switch,agent,from,place). %%  switch to from sentrun

iv_templ(change,agent).    %% veksle (Norw) 
iv_templ(change,route_plan). 

tv_templ(change,agent,thing). 
% tv_templ(change,agent,vehicle). %% "man" 

    v_compl(change,agent,nil,time).     %% jeg skifter kl 12
    v_compl(change,agent,to,place).     
    v_compl(change,agent,with,ticket).  
    v_compl(change,agent,between,place). 
    v_compl(change,agent,between,vehicle). 
    v_compl(change,agent,for,thing). 
    v_compl(change,agent,from,vehicle).
    v_compl(change,agent,in,thing).    
    v_compl(change,agent,on,distance). % bytte på strekning 
    v_compl(change,agent,on,vehicle).    %%  "man" (Norw)
    v_compl(change,agent,past,vehicle).  %% ugly  til/fra 
    v_compl(change,agent,to,vehicle).  
    v_compl(change,agent,to,route_plan).    %% sommerrute
    v_compl(change,agent,nil,time_count).   %% (neste gang)

%    v_compl(change,agent,with,change). %% ?
%    v_compl(change,agent,at,person).    %% veksle hos  (Norw) ??

    v_compl(change,route_plan,to,time).  %% winter/summer  Norw

tv_templ(change,place,address).   %%  e.g. politistasj.

tv_templ(change,system,thing).     
    v_compl(change,system,to,thing).
    v_compl(change,system,for,time). %% change routeplan for summer



% tv_templ(change,departure,departure).  %% endre seg  Norwagism

tv_templ(change,vehicle,vehicle). %% bus goes without changing bus (SIC)
tv_templ(change,vehicle,zone). 
   
tv_templ(change,thing,name). 
%   v_compl(change,thing,to,thing). %% change to lade 

%%  end change

tv_templ(chase,animate,animate).
tv_templ(chose,system,analysis).

tv_templ(clean,agent,nil). %% han vasker () 
tv_templ(clean,agent,thing). %% :-) 
    v_compl(clean,agent,withh,frequency).
tv_templ(close,agent,door). 
tv_templ(close,agent,subscription).  
    v_compl(close,agent,until,date). 

tv_templ(comment,agent,thing). 
iv_templ(comment,agent). 
      v_compl(comment,agent,on,thing). 

tv_templ(compare,person,thing).
    v_compl(compare,person,with,thing).

tv_templ(connect,agent,thing).  %% metagoric
    v_compl(connect,agent,to,thing).  
    v_compl(connect,agent,together,thing).
    v_compl(connect,agent,with,thing). 

tv_templ(connect,bus,place).  
    v_compl(connect,bus,with,place).
    v_compl(connect,bus,between,time). 

tv_templ(consider,agent,thing).

tv_templ(contact,agent,agent). 

tv_templ(contain,thing,thing).   
    v_compl(contain,thing,for,information).
    v_compl(contain,thing,in,thing). 

tv_templ(control,person,thing). 


tv_templ(convince,person,person). 
    v_compl(convince,person,nil,person). 

iv_templ(copy,agent).

tv_templ(copy,telephone,thing).%% TA-110303 (telephone amb system)
                               %% telfonen  kopierer "rute"
 
tv_templ(copy,agent,information).        
 tv_templ(copy,agent,program).  
   
    v_compl(copy,agent,to,thing).     
    v_compl(copy,agent,into,thing).   
    v_compl(copy,agent,from,directory).
    v_compl(copy,agent,from,system). 
%                    v_compl(copy,agent,to,file).     
    v_compl(copy,agent,into,file).
    v_compl(copy,agent,to,directory). 
    v_compl(copy,agent,to,system).  
%                   v_compl(copy,agent,into,directory).



%%%
tv_templ(correct,agent,nil).  %% justere (på) elliptic
    %% not working %% ??      %% rette på

tv_templ(correct,agent,thing). 
    v_compl(correct,agent,nil,place).
    v_compl(correct,thing,in,thing). 
    v_compl(correct,thing,on,thing). 
    v_compl(correct,thing,to,thing). 

% tv_templ(cost,thing,money).   %% OOPS hva koster en dame

tv_templ(cost,animal,money). %% dog on veh 
tv_templ(cost,person,money). %% qua passenger
tv_templ(cost,pram,money). 
tv_templ(cost,liquid,money). 
tv_templ(cost,transfer,money). 
tv_templ(cost,vehicle,money).          %% (also boat,etc)

    v_compl(cost,thing,for,person).    %%  vehicle/ticket
    v_compl(cost,thing,for,object). 
    v_compl(cost,thing,for,animal). 
    v_compl(cost,thing,in,time).  
    v_compl(cost,thing,from,place). 
    v_compl(cost,thing,in,place). 
    v_compl(cost,thing,outside,place). %%
    v_compl(cost,thing,within,place).  %%
    v_compl(cost,thing,to,place).  
%    v_compl(cost,thing,in,mode).      %% cost much

tv_templ(cost,trip,money). 
tv_templ(cost,ticket,money).  
    v_compl(cost,ticket,for,person). 
    v_compl(cost,ticket,from,place). 
    v_compl(cost,ticket,in,vehicle).  
    v_compl(cost,ticket,on,vehicle).    %% (Norwagism)     
    v_compl(cost,ticket,to,place). 
    v_compl(cost,ticket,with,discount).
    v_compl(cost,ticket,with,vehicle).  %% (Norwagism) 

tv_templ(cover,agent,thing). 

%% tv_templ(cover,system,place). 
tv_templ(cover,vehicle,place). 
tv_templ(cover,station,company).
tv_templ(cover,place,place). 
    v_compl(cover,thing,with,thing). 


iv_templ(crash,vehicle). 
    v_compl(crash,vehicle,with,thing). %%

tv_templ(create,thing,thing). %% object|system). %% TA-110607
                              %% endring av navn  skaper merarbeid.

tv_templ(damage,thing,thing).

tv_templ(debug,agent,system). %% TA-110708

iv_templ(decide,agent). 
tv_templ(decide,agent,thing). 
    v_compl(decide,agent,with,thing). %% vha.

tv_templ(demonstrate,agent,thing). 
    v_compl(demonstrate,agent,for,agent). 

tv_templ(define,agent,thing). 
    v_compl(define,agent,with,meta).

tv_templ(delay,thing,thing). 

tv_templ(delete,agent,thing).    
     v_compl(delete,thing,in,route_plan). %% gen!
     v_compl(delete,thing,from,system).   %% 

tv_templ(deliver,agent,thing).        
    v_compl(deliver,agent,in,place). 
    v_compl(deliver,agent,ion,place).
    v_compl(deliver,agent,on,place).
    v_compl(deliver,agent,to,place). 

tv_templ(derive,agent,thing). 

tv_templ(describe,agent,thing).         %% NB: abnormalverb/2
                                 %%  describe bus 5 at NTH 
%% tv_templ(design,agent,thing). %% make

tv_templ(determine,thing,thing).
tv_templ(dial,agent,number).
tv_templ(direct,person,question). 

tv_templ(discover,agent,thing). 

tv_templ(discuss,agent,thing). 
    v_compl(discuss,agent,with,agent). 
tv_templ(display,system,thing).  
    v_compl(display,system,in,file). 

tv_templ(distribute,agent,thing).  %% db, system 
    v_compl(distribute,agent,to,place). %% 

tv_templ(do1,thing,coevent).    %% kortet gjør hverdagen effektiv 

%% tv_templ(do1,vehicle,coevent).  % buss gjør at trikken står

tv_templ(do1,vehicle,stop).     %  (activity?)
tv_templ(do1,vehicle,station).  % activity is hidden by station
tv_templ(do1,agent,activity). 

 
    v_compl(do1,agent,nil,mode).    %% manually 
    v_compl(do1,agent,at,thing).  %% TA-110804

    v_compl(do1,agent,in,system).   %% metagoric 
    v_compl(do1,agent,in,mode).     
    v_compl(do1,agent,off,station).   %% man kan [metaverb] av [på]    hpl 
    v_compl(do1,agent,on,system). %% server 
    v_compl(do1,agent,via,thing). %% TA-110804
  
tv_templ(do1,agent,fool). %% gjør du narr
tv_templ(do1,agent,thing). %% hva kan du gjøre for meg 

    v_compl(do1,thing,nil,time). %% I do it 1. may
    v_compl(do1,agent,for,agent). 
    v_compl(do1,agent,to,time).     %% gjøre noe fra tid til tid 
    v_compl(do1,agent,on,time). 
    v_compl(do1,agent,with,thing). 
    v_compl(do1,agent,without,thing). %
    v_compl(do1,agent,off,agent).   %% narr av (?) 


tv_templ(draw,person,thing). 

iv_templ(dream,agent).  %%  :-) 
    v_compl(dream,agent,about,thing).
    v_compl(dream,agent,regarding,thing).


tv_templ(drink,agent,liquid).      %% :-)
tv_templ(drink,agent,nil). 
%% iv_templ(drink,agent).  %%  :-)
    v_compl(drink,person,in,vehicle). 
    v_compl(drink,person,on,vehicle). 
    v_compl(drink,person,to,food). 



%%%  tv_templ(drive,agent,company). %% N: drive """ must give place """

iv_templ(drive,vehicle). %% i.e. kjøre/go
iv_templ(drive,agent). 

tv_templ(drive,agent,nil).  
%% tv_templ(drive,vehicle,nil).   %% This is unresolved sense diasambiguity

tv_templ(drive,agent,person). 

  v_compl(drive,A,P,Q):- %% Ad Hoc
        v_compl(go,A,P,Q).

tv_templ(drive,agent,vehicle). %% driver

tv_templ(drive,vehicle,person). 
    v_compl(drive,vehicle,from,place).      
    v_compl(drive,vehicle,between,time). 
    v_compl(drive,vehicle,between,place).  
    v_compl(drive,vehicle,to,place).        
    v_compl(drive,vehicle,by,place).  
    v_compl(drive,vehicle,through,place). 
    v_compl(drive,vehicle,in,direction). 
    v_compl(drive,vehicle,nil,direction). 
    v_compl(drive,vehicle,towards,place). 
    v_compl(drive,vehicle,for,place). 
    v_compl(drive,vehicle,past,place). 
    v_compl(drive,vehicle,into,place). 
    v_compl(drive,vehicle,out_of,place).
    v_compl(drive,vehicle,with,speed). 

tv_templ(drive,bus,route).  

tv_templ(drive,company,route).  %% figure of speech 


tv_templ(earn,agent,money).      %%  :-)     

%% iv_templ(eat,agent). 
tv_templ(eat,agent,nil).  
tv_templ(eat,agent,food).        %% :-)
    v_compl(eat,agent,in,vehicle).  %%  Facetious
    v_compl(eat,agent,on,vehicle).
    v_compl(eat,agent,to,time).      %%  Norw til middag/frokost qua (dinner)
    v_compl(eat,agent,on,meeting).    %%  julebord :-)
    v_compl(eat,agent,on,time). 
    v_compl(drink,agent,on,meeting).

tv_templ(enjoy,thing,agent).  %% det gleder meg
    v_compl(enjoy,agent,to,thing).  %%  Norw /look forw 

%% tv_templ(ensure,person,thing). %% confuse rv

tv_templ(exceed,measure,measure).    

tv_templ(exclude,agent,thing). 


tv_templ(demand,agent,thing). %% ?? kreve= demand %%  ambig
tv_templ(demand,question,thing). %% kreve lang responstid
    v_compl(demand,agent,from,agent). %% i.e.   demand     
    v_compl(demand,agent,off,agent).  

tv_templ(expect,agent,nil). %% amb venter () 
tv_templ(expect,agent,thing). %% ?? kreve= demand %% ambig
tv_templ(expect,question,thing). %% kreve lang responstid
    v_compl(expect,agent,from,agent). %% i.e.   demand     
    v_compl(expect,agent,off,agent).  
    v_compl(expect,agent,on,thing).  %% jeg venter på trikken på holdeplassen
                                     %% vente=wait/expect/await 
tv_templ(explain,agent,thing). 
    v_compl(explain,agent,to,agent). 

tv_templ(fetch,agent,thing). 
    v_compl(fetch,agent,nil,time).
 
    v_compl(fetch,agent,from,place). 
    v_compl(fetch,agent,from,system). 
    v_compl(fetch,agent,on,place). 
    v_compl(fetch,agent,from,agent). 
    v_compl(fetch,agent,from,database). %% etc
    v_compl(fetch,agent,from,mail). 
    v_compl(fetch,agent,in,system). 


tv_templ(find,agent,thing).    
    v_compl(find,agent,nil,clock). 
    v_compl(find,agent,nil,place). 
    v_compl(find,agent,after,thing).
    v_compl(find,agent,between,thing). 
    v_compl(find,agent,from,thing). %% page nn
    v_compl(find,agent,in,place). %% // find out ? %% hvor finner ...
    v_compl(find,agent,in,thing).
    v_compl(find,agent,on,thing). %%  (e.g. Internet)
    v_compl(find,agent,regarding,thing). 
    v_compl(find,agent,past,place). %% 
    v_compl(find,agent,past,route). %% etc
    v_compl(find,agent,for,agent). 

    v_compl(find,agent,to,agent).   %%  Norw  
    v_compl(find,agent,to,vehicle). %% TA-100902 ?

iv_templ(follow,station). 
    v_compl(follow,station,after,place).  
    v_compl(follow,station,towards,place).

iv_templ(follow,property). 
    v_compl(follow,property,with,thing).

tv_templ(follow,vehicle,route).   
tv_templ(follow,vehicle,route_plan). 
tv_templ(follow,agent,route_plan). 
    v_compl(follow,agent,of,consideration). %% av hensyn (til)%% Norw

tv_templ(fool,agent,agent). 

tv_templ(force,agent,thing). %% jeg er nødt til å gå. 

tv_templ(forget,agent,thing). %% tuc forgets bag ??? 
    v_compl(forget,thing,in,vehicle). 
    v_compl(forget,thing,on,vehicle). 

tv_templ(forgive,agent,thing). 

tv_templ(give,activity,thing). %% tester gir resultater 
tv_templ(give,agent,thing).

    v_compl(give,agent,nil,duration). %% gi meg varsel 10 min før ...
    v_compl(give,agent,nil,time).     
    v_compl(give,agent,before,vehicle). %% warning before bus
    v_compl(give,agent,in,meeting). 
    v_compl(give,agent,on,meeting). 
    v_compl(give,agent,in,vehicle). 
    v_compl(give,agent,on,vehicle). 
    v_compl(give,agent,to,area).   %% TA-100907 Rondane  (measure)

tv_templ(give,search,answer). 

tv_templ(give,ticket,transfer). 
tv_templ(give,time,departure). %% Tiden angir tidligste passeringer

tv_templ(give,vehicle,transfer). 
%% tv_templ(give,company,thing).

    v_compl(give,agent,to,agent). %%  (ref show)
%     v_compl(give,agent,for,thing). %% Most probably, for thing is a noun complement
    v_compl(give,agent,to,place). %% TA-100907 Rondane

tv_templ(give,card,discount). %%  kort gir rabatt
    v_compl(give,card,on,vehicle).

tv_templ(give,question,answer). 


tv_templ(go2,thing,vehicle).  %% følges vanlige ruter idag ?
                        %% noe følger vanlige ruter 

tv_templ(go2,vehicle,route).      %%  bus 5 goes bus 6 *
     v_compl(go2,vehicle,nil,direction).  %% buss følger rute  motsatt retning 
%      v_compl(go2,vehicle,in,time). 
                              %% This is WRONG , but the alternative
                              %% is worse (a minute's silence)
                              % når går neste buss fra mellomvn. 5 mot byen.
tv_templ(go2,vehicle,route_plan).  %% trase 
tv_templ(go2,vehicle,place).       %% bus follows road
tv_templ(go2,vehicle,trip). 
    v_compl(go2,vehicle,with,duration). 



%% tv_templ(greet,agent,nil). 
%% tv_templ(greet,agent,agent).
%% tv_templ(greet,agent,team). 

iv_templ(greet,agent).  %% hilser på 
    v_compl(greet,agent,nil,agent).
    v_compl(greet,agent,on,agent).
    v_compl(greet,agent,from,agent). 
    v_compl(greet,agent,on,team).    
 
tv_templ(hate,agent,thing). %% allow question

tv_templ(hear,agent,thing).

iv_templ(hear,agent). %% disamb.  listen
    v_compl(hear,agent,from,agent). %% 
    v_compl(hear,agent,to,agent).
    v_compl(hear,agent,on,agent).   %% Norwagism 
    v_compl(hear,agent,on,object).  %% television 
    v_compl(hear,agent,on,abstract). %% musikk  (listen)
    v_compl(hear,agent,in,vehicle). %% TA-101126

iv_templ(help,thing). %% agent).  %% It helps 
tv_templ(help,agent,agent). 
    v_compl(help,agent,with,thing).
    v_compl(help,agent,in,direction). 

tv_templ(hide,agent,thing). 
    v_compl(hide,agent,in,thing). %% place/system 

tv_templ(hire,person,person). 
tv_templ(hire,agent,vehicle). 

tv_templ(hurt,thing,agent).   %% en ting plager meg ???
tv_templ(hurt,agent,agent). 
tv_templ(hurt,agent,feeling). 

tv_templ(ignore,agent,thing). 

tv_templ(improve,agent,thing).  
    v_compl(improve,agent,with,thing).   %% 

tv_templ(include,agent,thing). 

tv_templ(input,agent,thing).  %% legge inn %% technical
tv_templ(output,agent,thing). %%  ta ut     %% technical
    v_compl(input,thing,in,system). 

iv_templ(increase,measure). 
    v_compl(increase,measure,with,thing). 


tv_templ(increase,agent,seat). %% i.e. capacity (more buses?) 
tv_templ(increase,agent,price). 
tv_templ(increase,company,price).
iv_templ(increase,price). %% unnec
    v_compl(increase,thing,from,money).
    v_compl(increase,thing,to,money).
    v_compl(increase,thing,with,thing). 
tv_templ(interpret,agent,thing). 
    v_compl(interpret,agent,as,thing). 
tv_templ(interview,person,person). 

iv_templ(investigate,agent).
    v_compl(investigate,agent,on,thing). %% Norw forske på 

tv_templ(kill,agent,animate).       %%  whoq demands agent 
    v_compl(kill,agent,with,weapon).   %% not person. type chex forbids
                                    %% type specialization as a side
                                    %% effect  (Gun syndrome)

%% tv_templ(kiss,agent,animate).  %% TA-110520 :-)  %% agent ==> who q


tv_templ(label,agent,vehicle).         %% er merket 
tv_templ(label,agent,departure).
    v_compl(label,agent,nil,thing).  
    v_compl(label,agent,on,thing). 
    v_compl(label,agent,under,thing).  %%  footnote,number,...
    v_compl(label,agent,with,thing).

    v_compl(discover,agent,with,thing). %% ad hoc disamb "merke" 


iv_templ(last,thing). %% vare... %% TA-110609
%%     v_compl(last,thing,nil,time).
    v_compl(last,thing,nil,duration).  %% vare 2 uker
    v_compl(last,thing,for,thing).     %% ad hoc Norw, gjelde 
    v_compl(last,thing,in,duration).   %%  
    v_compl(last,thing,with,duration). %% hvor lenge %%
    v_compl(last,thing,nil,duration). 
    v_compl(last,time,to,time).
    v_compl(last,thing,with,duration). 


/*
iv_templ(last,route_plan). 
iv_templ(last,route_plan).
iv_templ(last,time). %%  Jula varer
iv_templ(last,ticket). %% overgangs- 
iv_templ(last,trip). 
iv_templ(last,transfer). %% hvor lenge varer en overgang
*/
 

%%%%  tv_templ(last,thing,duration). %% ad hoc ? tur varer 5 min %% TA-110609
/*
tv_templ(last,activity,time). 
tv_templ(last,vehicle,time). %% e.g. bus tour 
tv_templ(last,ticket,time). 
tv_templ(last,transfer,time).
*/

 


tv_templ(lay,agent,thing).
%% tv_templ(lay,agent,agent).  % ?
%% tv_templ(lay,agent,pause). 
    v_compl(lay,agent,as,thing).  %% legge inn som metalev
    v_compl(lay,agent,between,thing).

    v_compl(lay,agent,in,database). 
    v_compl(lay,agent,in,system).    
    v_compl(lay,agent,into,database).
    v_compl(lay,agent,into,system). 
    v_compl(lay,agent,on,memory).     %% legge det på minnet 
    v_compl(lay,agent,on,network).    %% legge på nett
    v_compl(lay,agent,on,system).     %% på server 
    v_compl(lay,agent,to,thing).   

tv_templ(lay,agent,information).  %%  e.g. route_plan
tv_templ(lay,agent,vehicle).      %% legge ned rute 10 // Technical
    v_compl(lay,agent,on,place).  %% down

tv_templ(lead,person,animate). 


tv_templ(let,agent,thing).      %% NB intransitive? RS-121118

tv_templ(like,agent,thing). 

tv_templ(list,agent,thing). 
%     v_compl(list,agent,after,place).  %% ==> n_compl
%     v_compl(list,agent,before,place). %% 
%     v_compl(list,agent,in,order).     %%

    v_compl(list,agent,as,thing).    

    v_compl(list,agent,for,thing). %% information/route 
                                   %% oppført avganger for ruter
    v_compl(list,agent,for,demonstration).
    v_compl(list,agent,in,information). 
    v_compl(list,agent,on,information).  %% screen 
    v_compl(list,agent,with,thing). %% header, avgangstid
    v_compl(list,agent,with,summary).  
                                       % find synonym with list ( wise ???)
tv_templ(locate,system,object).   
tv_templ(log,agent,thing). %% it
    v_compl(log,agent,on,system).

%% iv_templ(lose,agent). 

tv_templ(lose,agent,thing). %% game? 
tv_templ(lose,person,thing). 
    v_compl(lose,agent,in,vehicle).
    v_compl(lose,agent,on,vehicle).
tv_templ(lose,company,money). 

tv_templ(love,agent,agent). %%   :-) %% subject must be agent : who

tv_templ(maintain,agent,thing). 

tv_templ(make,activity,thing). %% TA-110607
tv_templ(make,agent,thing). %%  not child :-)

    v_compl(make,agent,nil,place).    %% make up
    v_compl(make,agent,before,time). 
    v_compl(make,agent,in,data).      %% i pakke 
    v_compl(make,agent,in,job).       %% i samarbeide 
    v_compl(make,agent,on,place).     %% Norwagism 
    v_compl(make,agent,with,agent).   %% e.g. jokes
    v_compl(make,agent,in,language).  %% (passive  sensitive to exact class)
    v_compl(make,agent,with,language).
    v_compl(make,agent,for,thing).    %%   agent sup company
    v_compl(make,agent,of,thing).     %%   Steel is made of iron
    v_compl(make,agent,to,use).       %% Norw til bruk
    v_compl(make,person,to,person).   %-)
    v_compl(make,person,with,person). % (?)



iv_templ(manage,agent). %% jeg orker ikke. 

tv_templ(manage,agent,thing).
tv_templ(manage,address,thing). %% qua agent metonym/web|ip

    v_compl(manage,employee,in,office).


%% iv_templ(marry,person).
tv_templ(marry,person,nil).  
tv_templ(marry,person,person).     %% what a priest does
tv_templ(match,set,set).     

tv_templ(indicate,thing,thing). %% Norw .. bety "mean2" %% TA-110112

tv_templ(mean,agent,thing). %% Norw mene %% TA-101115

tv_templ(mean,thing,meta). %% mean a thing
    v_compl(mean,agent,by,thing). 
    v_compl(mean,agent,with,thing).      %%   Norwagism 
    v_compl(mean,agent,regarding,thing).

%% iv_templ(meet,agent).  %% kan vi møtes = møte // look ahead trouble

iv_templ(meetup,agent). %% arrive person (møte opp) %% \= arrive

tv_templ(meet,agent,nil). 
    
tv_templ(meet,agent,agent). 
   v_compl(meet,agent,nil,time). 
   v_compl(meet,agent,with,agent). %% Norw 
   v_compl(meet,agent,without,vehicle). %% uten transport 

tv_templ(meet,vehicle,vehicle). 
tv_templ(meet,agent,vehicle).  
tv_templ(meet,vehicle,agent).   %% %% ?

tv_templ(miss,thing,nil).       %% noe mangler (ad hoc disamb) 
   tv_templ(miss,agent,thing).  %% correct is  miss (something), means be absent
   tv_templ(misspell,agent,thing).  

tv_templ(misunderstand,agent,thing). 

tv_templ(modify,agent,nil). %% endre i DNS 
tv_templ(modify,agent,thing).   
    v_compl(modify,agent,from,thing). %% TA-110527
    v_compl(modify,agent,to,thing). %% time). 
    v_compl(modify,agent,in,thing).  

tv_templ(move,system,file).      
    v_compl(move,system,to,file). 
    v_compl(move,system,to,directory).
    
tv_templ(move,agent,station). %% stasjonen er flyttet
tv_templ(move,agent,system).  %% etc 

tv_templ(name,thing,thing). %% bli kalt 
tv_templ(name,person,name).
    v_compl(name,person,pro,animate). 



tv_templ(need,thing,thing).  
    v_compl(need,agent,nil,time). 
    v_compl(need,agent,for,thing). 
    v_compl(need,agent,from,place). %% hvor mange overganger trenger jeg   
    v_compl(need,agent,to,place). 

iv_templ(negotiate,agent). %% (om) = dicuss %% TA-110707

tv_templ(notify,agent,nil). %% EXPERIMENT %% TA-101129
%% iv_templ(notify,agent). %% Unlucky duality

tv_templ(notify,agent,coevent). 
tv_templ(notify,agent,clock). %%  to minutter før 4/ to  minutter før bussen 

%%%  tv_templ(notify,agent,hour).   %% TA-101126 // NO, nil-complement
%%%  tv_templ(notify,agent,minute). %% varsle 2 min | før bussen går 

tv_templ(notify,agent,agent).    
tv_templ(notify,agent,departure).   
%% tv_templ(notify,agent,vehicle).     %% jeg varsler buss ??? 
tv_templ(notify,agent,place).  %% varsle nardo = 1. departure for nardo 

     v_compl(notify,agent,nil,duration).  
     v_compl(notify,agent,after,activity).  
     v_compl(notify,agent,after,vehicle).  
     v_compl(notify,agent,before,activity).  
     v_compl(notify,agent,before,vehicle). 
     v_compl(notify,agent,regarding,thing). 
     v_compl(notify,agent,to,time).  %% Norw %% TA-60306




tv_templ(open,agent,door). 
tv_templ(open,agent,mail). 
tv_templ(open,agent,subscription). 


%%%% tv_templ(overlook,person,thing).



tv_templ(owe,agent,object).      %% di-transitive
tv_templ(owe,agent,money).       %% not thing e.g. person
   v_compl(owe,agent,to,agent).  %%  (ref give)

tv_templ(own,agent,company). %%  :-) 
tv_templ(own,agent,computer).  
tv_templ(own,agent,information). 
tv_templ(own,agent,feeling).   %%  :-)
tv_templ(own,agent,object). 
tv_templ(own,agent,program). 
tv_templ(own,agent,room). 
tv_templ(own,agent,savant). 
tv_templ(own,company,vehicle). 
tv_templ(own,agent,vehicle). %% qua company 


tv_templ(pay,person,money). 
    v_compl(pay,person,with,card). 
    v_compl(pay,person,with,money).

%% PASS section

tv_templ(pass,vehicle,nil). %% NB %% TA-110330 Problems?

tv_templ(pass,agent,test). 
tv_templ(pass,agent,company). 
tv_templ(pass,agent,place). 

%% tv_templ(pass,agent,agent). %% i.e. visit someone %% (telebuster) 

tv_templ(pass,departure,place). %%   (slightly incorrect) Norwagism
   v_compl(pass,agent,dir,place). 

tv_templ(pass,agent,place). %%  can of worms ?


tv_templ(pass,vehicle,place). %%   Also intransitive
    v_compl(pass,vehicle,dir,place).   %%  New Regime
    v_compl(pass,vehicle,for,agent).   %% NB suits, rough 
    v_compl(pass,vehicle,in,sequence).

%%% tv_templ(pass,vehicle,direction). 
v_compl(pass,vehicle,nil,direction). 

v_compl(pass,vehicle,nil,time). %% 212 min later 
v_compl(pass,vehicle,with,route_plan). %% summerroute| 


%% tv_templ(pass,person,person).  
    %% E.G visit , but pass/visit syndrome
    %% ambiguity of besøke, pass is acce
    %% because also transitive

iv_templ(pass,clock).   %% klokken passerer 12 
iv_templ(pass,departure).   %% ODD 
    v_compl(pass,departure,X,Y):-  
        v_compl(pass,vehicle,X,Y).    

iv_templ(pass,agent). %% Also transitive     // man = agent
     v_compl(pass,agent,nil,clock). 
     v_compl(pass,agent,at,departure).  %% pass NTH ved avreise  (Norwagism ???) 
     v_compl(pass,agent,by,place).                
     v_compl(pass,agent,past,place). 
     v_compl(pass,agent,between,time).            
     v_compl(pass,agent,in,direction).            
     v_compl(pass,agent,nil,direction). 
     v_compl(pass,agent,towards,place).  
     v_compl(pass,agent,by,vehicle). 
     v_compl(pass,agent,from,place).
     v_compl(pass,agent,from,vehicle). %% e.g. see 
     v_compl(pass,agent,to,place).
     v_compl(pass,agent,with,vehicle). 
     v_compl(pass,agent,with,departure).  %% from somewhere else
	  v_compl(pass,agent,for,place). 

iv_templ(pass,vehicle). %% Also transitive // Norw passe /fit
%% buss passerer i munkegaten 


     v_compl(pass,vehicle,nil,date). 
     v_compl(pass,vehicle,nil,hour). 
     v_compl(pass,vehicle,nil,daypart). 
     v_compl(pass,vehicle,nil,time_count). 
     v_compl(pass,vehicle,nil,direction). 
     v_compl(pass,vehicle,nil,clock). 
     v_compl(pass,vehicle,nil,day).                %% passes each day ?
     v_compl(pass,vehicle,after,time). 
     v_compl(pass,vehicle,before,place). 
     v_compl(pass,vehicle,between,place). 
     v_compl(pass,vehicle,between,time).  
     v_compl(pass,vehicle,for,time_count).          %% (Norwagism  for siste gang)
	  v_compl(pass,vehicle,for,place). 
     v_compl(pass,vehicle,from,place). 
     v_compl(pass,vehicle,in,direction).  
     v_compl(pass,vehicle,in,time).  
     v_compl(pass,vehicle,near,place). 
     v_compl(pass,vehicle,on,direction). 
     v_compl(pass,vehicle,on,time). 
     v_compl(pass,vehicle,past,place).  
     v_compl(pass,vehicle,through,place). 
     v_compl(pass,vehicle,to,place).      
     v_compl(pass,vehicle,to,time). 
     v_compl(pass,vehicle,towards,place). 
     v_compl(pass,vehicle,with,arrival).  
     v_compl(pass,vehicle,with,departure).  
     v_compl(pass,vehicle,with,direction). 


%%% End pass

tv_templ(pay,person,money).    
tv_templ(pay,person,ticket). 
    v_compl(pay,person,between,place).
    v_compl(pay,person,for,person). 
    v_compl(pay,person,from,place). 
    v_compl(pay,person,on,vehicle).   
    v_compl(pay,person,to,place). 

tv_templ(pay,person,attention).
    v_compl(pay,person,to,thing).

tv_templ(perform,system,command).

tv_templ(pick,agent,object).
tv_templ(position,person,object).
   v_compl(position,person,to,place).

tv_templ(postpone,agent,activity). 

tv_templ(prefer,agent,thing). 

tv_templ(press,agent,thing).  

tv_templ(prevent,agent,thing).

tv_templ(print,agent,thing). 
     v_compl(print,agent,on,printer). 

tv_templ(process,system,question). 
%% tv_templ(program,agent,program). %%  make 
tv_templ(provide,person,thing).
tv_templ(pull,person,thing).
tv_templ(push,person,thing). 

tv_templ(put,vehicle,agent).  %% technical 
    v_compl(put,vehicle,off,vehicle). %% bli satt av bussen
                                      %% Norw, bli "satt_av"  av sjåføren
    v_compl(put,thing,in,activity).  %% sette i drift

tv_templ(put,agent,thing).
    v_compl(put,agent,upon,thing). 
    v_compl(put,agent,in,vehicle).
    v_compl(put,agent,off,vehicle). 
    v_compl(put,agent,on,vehicle). 
    v_compl(put,agent,on,account). %%   in/into ...

    v_compl(put,agent,with,information). %% med beskjed



tv_templ(put,vehicle,thing). %% Problem: bli satt av bussen/sjåføren
    v_compl(put,vehicle,with,information). %% med beskjed // ad hoc   nonsense 
        

% NB reach  ( ankomme ) %% Norwagism 

% +++ The following is possibly duplicate

tv_templ(reach,agent,nil).   %% Hazard ?

tv_templ(reach,agent,activity).  %% departure|meeting %% TA-110419
tv_templ(reach,agent,place).    
tv_templ(reach,agent,vehicle).  %% not thing (station)  reach train \= TS
tv_templ(reach,agent,movie). 
tv_templ(reach,agent,meeting). 
    v_compl(reach,agent,to,clock). 
                 %% rekke fram til kl 1234. %%	 Norwagism

%%%%  tv_templ(reach,X,Y):-tv_templ(pass,X,Y). %% rekke toget = TS 


    v_compl(reach,agent,past,place).
    v_compl(reach,person,via,vehicle). %%  nå NTH via linje 1
%%     v_compl(reach,X,Y,Z):-  v_compl(pass,X,Y,Z).

tv_templ(reach,vehicle,place).  
    v_compl(reach,vehicle,nil,clock). 
	 v_compl(reach,vehicle,between,time).

tv_templ(reach,vehicle,vehicle). %% correspondance 

%  når(rekker)  buss nr 3 fra kroppan marka 17. Mai (ca kl) ni ?  

%%%%%%%%%%% tv_templ(reach,agent,thing). %% man 

    %%% v_compl(reach,agent,nil,time) ???? 

    v_compl(reach,agent,nil,clock). %% avoid
    v_compl(reach,agent,nil,date). 
	 v_compl(reach,agent,nil,daypart). %% tonight 
    v_compl(reach,agent,between,time).
    v_compl(reach,agent,by,vehicle).
    v_compl(reach,agent,with,vehicle).
    v_compl(reach,agent,on,telephone). 


tv_templ(receive,thing,competition). 


tv_templ(receive,agent,thing).         %%  ( Norw. 'få' )// Jeg får Danmark ?
    v_compl(receive,agent,nil,time). 
    v_compl(receive,agent,by,mail). 
    v_compl(receive,agent,from,agent).
    v_compl(receive,agent,from,place). 
    v_compl(receive,agent,in,database). 
    v_compl(receive,agent,in,mail).  
    v_compl(receive,agent,in,place).  %% Norw. hvor fåe heg tak
    v_compl(receive,agent,in,vehicle).
    v_compl(receive,agent,in,system).
    v_compl(receive,agent,in,vehicle). 

    v_compl(receive,agent,on,memory). 
    v_compl(receive,agent,on,mind).
    v_compl(receive,agent,on,question). %% få svar på spørsm. /V-compl
    v_compl(receive,agent,on,sms).   
    v_compl(receive,agent,on,system).   %%  forslag på oraklet (qua  skjerm?)    
    v_compl(receive,agent,on,ticket).
    v_compl(receive,agent,on,vehicle).  %% placoid 
    v_compl(receive,agent,under,time).  %% SIC  under sommerrutene

    tv_templ(receive,income,thing).     %% f.o.s. %% få konkurranse
    v_compl(receive,thing,to,coevent).  %% få samvittighet til at 

tv_templ(receive,service,message). 


tv_templ(receive,vehicle,departure). %% fut have 
    v_compl(receive,vehicle,under,route_plan). % special 
tv_templ(receive,vehicle,modification). %% fått ruteendring

tv_templ(recognize,processor,word). %%  s->z
tv_templ(recognize,agent,thing). %% kjenner du meg ?
    v_compl(recognize,agent,as,thing).

tv_templ(recommend,agent,thing).  

tv_templ(remember,agent,thing). 
iv_templ(remember,agent).

tv_templ(remove,agent,thing).   %% remove is reserved in sicstus, gives funny print
    v_compl(remove,agent,from,thing).%% TA-101221 ...
%%     v_compl(remove,agent,from,printqueue).
    v_compl(remove,agent,nil,time).  

tv_templ(rename,system,file).  
    v_compl(rename,system,to,file).

tv_templ(repair,person,circuit).
tv_templ(repair,person,object).  % rather fix, really
    v_compl(repair,person,with,glue). 

tv_templ(repair,person,equipment).
tv_templ(repair,person,fault).

tv_templ(resemble,thing,thing). 
    v_compl(resemble,thing,at,thing). %% Norw ved god oppførsel
    v_compl(resemble,thing,by,thing). 

tv_templ(reset,agent,thing).  
    v_compl(reset,agent,to,thing). 

tv_templ(resist,agent,agent). %% ad hoc  jeg vegrer meg 

tv_templ(return,system,solution).

tv_templ(save,agent,file).           
     v_compl(save,agent,in,thing). 
     v_compl(save,agent,into,thing).   
     v_compl(save,agent,to,thing).     


tv_templ(say,information,thing). %% TA-101102
tv_templ(say,agent,thing). %%  tell?

tv_templ(score,person,goal).       
    v_compl(score,player,against,team).   
    v_compl(score,player,in,match).   

tv_templ(sell,company,thing). %% TA-110429

%% tv_templ(sell,company,card).  
%% tv_templ(sell,company,solution). 

tv_templ(sell,agent,object).   %%   NOT mother
tv_templ(sell,agent,software). 
tv_templ(sell,agent,trip). 

%% tv_templ(sell,agent,thing). %%  ( no instantiation person -> agent )

    v_compl(sell,agent,for,agent). 
    v_compl(sell,agent,from,place).
    v_compl(sell,agent,to,agent).
    v_compl(sell,agent,on,vehicle). 


tv_templ(send,agent,nil). %% send til 1939 

tv_templ(send,agent,thing). % e.g. notification // not places
                            % metagorially


    v_compl(send,agent,nil,agent).  
    v_compl(send,agent,after,thing). %% etter forslag fra    
    v_compl(send,agent,for,activity).
    v_compl(send,agent,on,question). %%  Norw sende på forespørsel
    v_compl(send,agent,past,thing). 
    v_compl(send,agent,to,agent).
    v_compl(send,agent,to,number).   %% 1939
    v_compl(send,agent,to,telephone).%% .. number

tv_templ(send,vehicle,agent). 

    v_compl(send,agent,nil,duration). %% send warning 9 min. (before...) 
    v_compl(send,agent,nil,time).   %% or time ????
    v_compl(send,agent,after,vehicle). %% i.e. warning 
    v_compl(send,agent,before,vehicle). %% ?
    v_compl(send,agent,to,number). %% Rough sms to 1939 
    v_compl(send,agent,to,place). 
    v_compl(send,agent,to,person). 
    v_compl(send,agent,with,vehicle). %% pakke med buss (Norw) 
    v_compl(send,agent,without,thing). 

tv_templ(send,system,file).          
    v_compl(send,system,to,printer). 

tv_templ(set,agent,thing). %% set watch/ question %% stille 
%    v_compl(set,person,in,mode).

tv_templ(set,agent,protection).
    v_compl(set,agent,on,thing). % set protection
    v_compl(set,agent,for,thing).
    v_compl(set,agent,to,meta).

tv_templ(shoot,person,animate).  
    v_compl(shoot,person,with,gun).

tv_templ(show,agent,thing). 
    v_compl(show,agent,to,agent).


iv_templ(sit,person). 

tv_templ(slip ,agent,thing). %% Norwagism  slippe //  don't have (to)

tv_templ(smell,agent,thing). 

tv_templ(solve,agent,thing). %%  dette 
   v_compl(solve,agent,with,thing).

tv_templ(split,person,text).


tv_templ(store,system,statement).

tv_templ(suit,thing,thing). %% det passer meg (ad hoc)

tv_templ(suit,thing,time). %%  passe (ad hoc) 

iv_templ(suit,thing). %%
    v_compl(suit,thing,for,thing).  
    v_compl(suit,thing,within,place). 
    v_compl(suit,thing,within,time). 

tv_templ(support,object,object).



% TAKE  begin

tv_templ(take,agent,care). %% TA-110816

tv_templ(take,coevent,time). %% hvor lang tid tar det å %% TA-110530

tv_templ(take,thing,street). %% "ta veien" %% TA-101126
  
tv_templ(take,system,restriction). %% TA-110419

tv_templ(take,agent,agent).  %% ta deg med %% TA-110128

tv_templ(take,agent,cr). %% metaphor ta linjeskift %% TA-110303

tv_templ(take,agent,money).  %% TA-101124
%% tv_templ(take,agent,nil). %% ta til vestre %% rewording %% TA-101116
    v_compl(take,agent,to,vehicle).  %% money %% TA-101124
   
    v_compl(take,thing,for,agent).  %% dont ask %% TA-110426 
    v_compl(take,thing,to,direction).      %%

    v_compl(take,thing,towards,direction). %%
    v_compl(take,agent,for,thing).  %% TA-110228

tv_templ(take,agent,activity). %% ta avgjørelse

tv_templ(take,activity,time).  
    v_compl(take,activity,from,place).   %%
    v_compl(take,activity,on,daypart).   %% ta buss midt på natta
    v_compl(take,activity,to,place).     %%
    v_compl(take,trip,with,vehicle).


%% Take Agent

%% tv_templ(take,agent,thing). %% ta (ut) loggen 
%% TA toget = Take Trainstation


tv_templ(take,agent,activity). %%  (not thing)
tv_templ(take,agent,animal).   % ta hunden på bussen 
tv_templ(take,agent,consideration). 
tv_templ(take,agent,contact).  
tv_templ(take,agent,error).  %% Du tar feil  :-)
tv_templ(take,agent,hold).   %% ta tak i (Norw)
tv_templ(take,agent,honour). 
tv_templ(take,agent,information).
tv_templ(take,agent,liquid). 
tv_templ(take,agent,number).   % qua vehicle 
tv_templ(take,agent,object).   % not thing, (=> person) %% e.g. cat takes bus
tv_templ(take,agent,otherbus). %% Freak, ako company 
tv_templ(take,agent,pause).   
tv_templ(take,agent,person).    %% ta med seg folk 
tv_templ(take,agent,route_plan). %% få tak i rute...
tv_templ(take,agent,self).      %%  :-) take me to your leader/ not
tv_templ(take,agent,sentence). %% "velge " %% Ad hoc 
%% tv_templ(take,agent,station). %% TA toget = Take Trainstation
tv_templ(take,agent,vacation). 
tv_templ(take,agent,vehicle).  %% vehicle \+ object. %% TA-110309

    v_compl(take,agent,nil,time). %%% <--- New regime when 
    v_compl(take,agent,nil,clock). 
    v_compl(take,agent,nil,daypart).       %%  take bus sunday evening
    v_compl(take,agent,nil,direction). 
    v_compl(take,agent,nil,date). 
    v_compl(take,agent,nil,day).
    v_compl(take,agent,nil,place). %% take bus nardo to city 
    v_compl(take,agent,nil,time_count). 

    v_compl(take,agent,according_to,thing). %% ifølge 
    v_compl(take,agent,as,thing). %% ta det som det kommer

    v_compl(take,agent,between,place).     %%  ta seg fram mellom 
    v_compl(take,agent,between,time). 
    v_compl(take,agent,for,arrival). %% Artif. Velg holdeplass for destinasjon 
    v_compl(take,agent,for,money). 
    v_compl(take,agent,in,wheelchair).   %% ta buss i 
    v_compl(take,agent,on,vehicle).      %% ta (med seg) 

    v_compl(take,agent,from,person).       %%  (take bus from )
    v_compl(take,agent,from,place). 
	 v_compl(take,agent,in,direction). 
    v_compl(take,agent,in,route_plan). 
    v_compl(take,agent,in,vehicle). 
    v_compl(take,agent,into,vehicle).       %% .. rullestol
    v_compl(take,agent,near,place). 
    v_compl(take,agent,on,place).           %%  (Norwagism)
    v_compl(take,agent,on,ticket).          %%  Norw
    v_compl(take,agent,on,time).            %% på natta 
    v_compl(take,agent,on,activity).        %%  ta tur på reise 
    v_compl(take,agent,on,vehicle).         %%  ta tur på toget
    v_compl(take,agent,out_of,place).
    v_compl(take,agent,past,place). %% i.e. bus 
    v_compl(take,agent,to,clock).           %% ( i.e. before )
    v_compl(take,agent,to,date).            %% ta buss natt til...  
    v_compl(take,agent,to,day).             %% 

    v_compl(take,agent,to,meeting).         %% e.g. bus
    v_compl(take,agent,to,person).          %%  (take bus to )
	 v_compl(take,agent,to,place).
    v_compl(take,agent,to,time_count).      %% til neste gang     

    v_compl(take,agent,with,thing).      %% ta med meg 


tv_templ(take,number,route).   %% number 6 takes route  

tv_templ(take,thing,way).    %% :-) Hvor har tiden tatt veien ?
    v_compl(take,time,nil,place). 

tv_templ(take,vehicle,agent).  %% take me to NTH 
tv_templ(take,vehicle,card).   %% metaphorically
tv_templ(take,vehicle,class).  %% school class
tv_templ(take,vehicle,route).   %% TRICKY hvilken rute tar bussen
    v_compl(take,vehicle,between,place). %% time between NTH and Nardo 
    v_compl(take,vehicle,with,vehicle).  %% bus takes time with bus 5
    v_compl(take,vehicle,by,vehicle).    %%                -by-

% tv_templ(take,vehicle,duration).   %% -thing  vehicle takes sunday *

tv_templ(take,vehicle,time).  %% Hvilken tid tar bussen

    v_compl(take,vehicle,between,time). %% standard ??
    v_compl(take,vehicle,from,place).  
	 v_compl(take,vehicle,to,place).  

 
tv_templ(take,vehicle,direction).  %%   bussen tar veien %% (Norwagism)   
tv_templ(take,vehicle,route_plan). 
tv_templ(take,vehicle,trip). 
   v_compl(take,vehicle,from,place).  %% take time  
   v_compl(take,vehicle,past,place). 
   v_compl(take,vehicle,to,place).    

tv_templ(take,driver,person).  %% variant

% TAKE  end


tv_templ(teach,person,nil).
iv_templ(teach,person).  
tv_templ(teach,person,subject).         %% professor
    v_compl(teach,person,to,student).
    v_compl(teach,person,nil,clock). 


tv_templ(tell,agent,thing). 
tv_templ(tell,agent,nil).  %% fortelle () om 

%% TRY  tv+particle 
%% iv_templ(tell,agent).  %% also answer %% fortelle om ??? 
                          %% can you tell me about buses 

    v_compl(tell,agent,nil,agent). %% tell mary // <-- This is DTV

    v_compl(tell,agent,nil,place). %% Hazardous 

    v_compl(tell,agent,about,thing).   %% DANGEROUS   tell that 
    v_compl(tell,agent,in,question).   %% hvorfor må jeg oppgi et sted i slike spørsmål
    v_compl(tell,agent,in,time).       %% ?
    v_compl(tell,agent,in,information).  %%  kunngjort i ruteheftet 
    v_compl(tell,agent,on,thing).      %% (Norwagism) svare på
    v_compl(tell,agent,per,thing).     %% (Norwagism) svareper telefon  
    v_compl(tell,agent,regarding,thing). 
    v_compl(tell,agent,to,agent).  %% tell to mary 
    v_compl(tell,agent,with,time).  %% med amerikansk tid 

tv_templ(test,agent,thing). 

tv_templ(throw,agent,thing).
    v_compl(throw,agent,off,vehicle). %% bussen/baren    
    v_compl(throw,agent,off,place).  

tv_templ(throw,vehicle,thing). %% Problem: bli kastet av bussen/sjåføren 
     v_compl(throw,vehicle,off,agent).

     v_compl(throw,agent,nil,vehicle).  %% vi ble kastet av
                                        %% noen kastet (av) oss

tv_templ(transfer,agent,thing). 

%% iv_templ(translate,agent). 
tv_templ(translate,agent,nil). 

tv_templ(translate,agent,thing). %% translate hest
                             

    v_compl(translate,agent,from,thing).
    v_compl(translate,agent,to,thing).  


tv_templ(treat,agent,thing).
tv_templ(treat,thing,information). %%  -de-

 
/*
tv_templ(treat,agent,mail). 
tv_templ(treat,agent,problem). 
tv_templ(treat,company,agent). 
tv_templ(treat,doctor,patient).
tv_templ(treat,system,text).
*/

    v_compl(treat,system,in,thing).
    v_compl(treat,agent,with,agent).
    v_compl(treat,agent,past,thing).  %%  amb (ugly) via
    v_compl(treat,agent,via,thing). 

tv_templ(type,person,text).

%%% iv_templ(understand,agent). 

tv_templ(understand,agent,thing). 
tv_templ(understand,development,thing). %% ad hoc..   utviklingen går
                                        %% mot å forstå teksten

    v_compl(understand,agent,as,thing).
    v_compl(understand,agent,by,thing).
    v_compl(understand,agent,in,case). 
    v_compl(understand,agent,on,thing).   %% Norw 

tv_templ(update,agent,information). 
tv_templ(update,agent,price).   
tv_templ(update,agent,route).
tv_templ(update,agent,route_plan).
tv_templ(update,agent,agent). 
    v_compl(update,agent,with,thing). 


tv_templ(use,agent,thing). 
    v_compl(use,agent,nil,place). %%  ???
    v_compl(use,agent,nil,information).  %%  ad hoc  bruk .., side 18 
    v_compl(use,agent,as,thing).  
	 v_compl(use,agent,between,place).  
	 v_compl(use,agent,from,place).   

%%     v_compl(use,agent,for,place). 
    v_compl(use,agent,for,thing). %% different senses
                                  %% oops for formål| for brukere

    v_compl(use,agent,in,thing). 

/*
    v_compl(use,agent,in,activity).
    v_compl(use,agent,in,wheelchair). %% use bus in wheelchair
    v_compl(use,agent,in,company). 
    v_compl(use,agent,in,vehicle).    %% use wheelchair in bus
*/


    v_compl(use,agent,on,telephone).  
    v_compl(use,agent,on,trip). 
    v_compl(use,agent,on,ticket).     %% benytte overgang på billett
    v_compl(use,agent,on,vehicle). 

	 v_compl(use,agent,to,place).   %% 
    v_compl(use,agent,to,thing).   %% place + job(activity)
    v_compl(use,agent,from,thing). %%   (fra = etter stanprep)
    v_compl(use,agent,past,thing). %% place + job(activity)

    v_compl(use,agent,via,sms).  
    v_compl(use,agent,with,thing).
    v_compl(use,agent,without,thing).

v_compl(use,agent,for,thing). %% different senses
                               %% oops for formål| for brukere

% v_compl(use,system,as,thing).


tv_templ(use,trip,thing). %% kjøring 

tv_templ(use,vehicle,fuel).

tv_templ(use,vehicle,station). %% i.e. pass 
tv_templ(use,vehicle,zone). %% i.e. zone fare
tv_templ(use,vehicle,time). 

%% iv_templ(use,vehicle).  %% under 50 minutter %% Hazard 
    v_compl(use,thing,to,thing). %% bruke ting til ting
    v_compl(use,vehicle,between,place).  
    v_compl(use,vehicle,from,place).
    v_compl(use,vehicle,on,distance). %% time 
    v_compl(use,vehicle,on,trip).     %% TA-100905
    v_compl(use,vehicle,to,place).
    v_compl(use,vehicle,over,time). 
    v_compl(use,vehicle,under,time). 


tv_templ(verify,agent,thing).
tv_templ(visit,agent,agent). %% passive --> agent 
tv_templ(visit,agent,place). 
    v_compl(visit,agent,nil,time).

tv_templ(visit,agent,company). 

tv_templ(wake,agent,agent).    %%   :-)  

tv_templ(want,agent,thing). 
tv_templ(want,company,thing). 
    v_compl(want,agent,nil,clock).  %% need a bus 0815 
    v_compl(want,agent,to,time).    %% til jul :-)
tv_templ(want,vehicle,time).        %%  Norw.   trenger
    v_compl(want,vehicle,on,trip). %% Norw.  trenger tid på tur


tv_templ(wash,person,route). %% :-)
tv_templ(watch,agent,thing). %% TA-110526
    v_compl(watch,agent,by,system). %% watch by video %% TA-110526

tv_templ(weigh,vehicle,weight). 

%% tv_templ(wish,person,thing). %% wish to/ want it
%%     v_compl(wish,thing,to,agent).   


tv_templ(wonder,agent,thing). %% lure på en ting 

tv_templ(worry,agent,agent). %% bryr meg/bryr deg %% Norwagism

%% iv_templ(write,agent). 
tv_templ(write,agent,nil).
tv_templ(write,agent,thing). % well,   software, file, letter, etc.
    v_compl(write,agent,in,detail).  
    v_compl(write,agent,in,part).     %% =detail
    v_compl(write,agent,in,language).
    v_compl(write,agent,on,activity).   %%  på reise
    v_compl(write,agent,on,language).   %% Norw 
    v_compl(write,agent,on,ticket). 
    v_compl(write,agent,in,file).
    v_compl(write,agent,from,place).
    v_compl(write,agent,to,agent). 
    v_compl(write,thing,to,agent). %% "de" 

%%%%%%%% Embedding verb Template %%%%%%%%%%%%%

%%%%%%% Regular adjectives %%%%%%%%%%%%%%%%


%% a_compl    semantic.pl
%% adj_compl  fernando.pl


a_compl(_A,thing,nil,coevent).       %%  bussen er forsinket slik at jeg går
a_compl(_A,thing,so_that,coevent).
a_compl(_A,thing,because_of,coevent).

a_compl(_A,_C,In,time):-
    stanprep(In,time). %% All adjectives are temporal 

a_compl(_A,_C,In,place):-
    stanprep(In,place). %% All adjectives are spatial

a_compl(_A,_C,with,duration). %% how long

a_compl(_A,_C,because_of,coevent). 
a_compl(_A,_C,in_order_to,coevent). 




%%  OOPS  Er det andre ruter*

adj_templ(Ordinal,thing) :- %% object ?  hvem var de første menneskene ? (trytofool)
    ordinal1(Ordinal). 


%% adj_templ(Colour,object):- 
%%    colour(Colour).

adj_templ(red,house). %%  etc

adj_templ(occupied,thing). 
    a_compl(occupied,agent,of,thing). %% Norw, opptatt av
    a_compl(occupied,agent,off,thing).%% ? 

adj_templ(online,agent). %% system,person 
adj_templ(only,thing).  %% only Norwegian \== Norwegian

adj_templ(ready,thing). %% Norwagism i gang/ til stede/ going/ klar 

adj_templ(beige,object). %%  (Berge?)
adj_templ(big,thing). %% if appl 

adj_templ(bilingual,agent).

adj_templ(black,object). %% object , but who cares// colour
adj_templ(black,person). %% ?
adj_templ(blue,thing).   %% vehicle ako thing %% TA-110629(and the other colours)  not thing

%% adj_templ(blue,sky). %% ~ weather 
adj_templ(grey,sky). %% 

adj_templ(green,thing).
adj_templ(grey,thing).
adj_templ(orange,thing). %% jeg skal til Orange kl 13 = Orange Clockwork
adj_templ(red,thing).
adj_templ(white,thing).
adj_templ(yellow,thing).
adj_templ(yellow,sun). %% weather %% TA-101230
    a_compl(yellow,thing,nil,time). 

adj_templ(violet,thing).

adj_templ(beige,colour).
adj_templ(black,colour).
adj_templ(blue,colour). 
adj_templ(green,colour).
adj_templ(grey,colour).
adj_templ(orange,colour). 
adj_templ(red,colour).
adj_templ(white,colour).
adj_templ(yellow,colour).
adj_templ(violet,colour).

adj_templ(white,person).
adj_templ(black,person).
adj_templ(coloured,person).

adj_templ(able,agent). 
adj_templ(absent,thing). %%  borte
    a_compl(absent,thing,to,place). %% bortreist til utlandet
    a_compl(absent,thing,on,time). 

adj_templ(accepted,language).
adj_templ(acceptable,sentence).
adj_templ(active,thing).
adj_templ(actual,thing). %% time/ 
adj_templ(adult,agent).         %%  NB Also noun   %% Når er man voksen
adj_templ(affected,thing). %% maybe tv ?
adj_templ(afraid,agent). 
    a_compl(afraid,agent,for,thing). %% Norw
    a_compl(afraid,agent,of,thing).  %% Eng
adj_templ(african,thing).
adj_templ(agreed,agent).   %% ENIG  Norw Tech 
    a_compl(agreed,agent,with,agent). 

adj_templ(alcoholic,drink). 

adj_templ(alive,agent). %% thing). 
adj_templ(alone,thing). 
adj_templ(ambiguous,sentence).
adj_templ(american,thing). 
adj_templ(angry,agent). 
adj_templ(annual,thing).
adj_templ(anonymous,thing).
adj_templ(artificial,thing). 
adj_templ(ascending,thing). 
adj_templ(asian,thing).

adj_templ(at_home,agent).   %% adv? ProForma     %%   (Norwagism)
    a_compl(at_home,agent,nil,time). %% hjemme nå %% TA-100910

adj_templ(australian,thing).  
adj_templ(automatic,thing). %% activity). %% TA-100907 Rondane
adj_templ(automatic,program).
adj_templ(automatic,service).  

adj_templ(available,thing). %%   %% er bussen tilgjengelig 17  
    a_compl(available,thing,nil,date).  
    a_compl(available,thing,as,thing). %% TA-110725
    a_compl(available,thing,at,thing). 
    a_compl(available,thing,during,time). 
    a_compl(available,thing,for,thing).  
    a_compl(available,thing,from,place). %% NOT STANDARD
    a_compl(available,thing,in,direction).
    a_compl(available,thing,in,thing).   %% place/system 
%%     a_compl(available,thing,in,place).  
    a_compl(available,thing,on,time).   
    a_compl(available,thing,on,vehicle).  
    a_compl(available,thing,on,message).     %% sms 
    a_compl(available,thing,on,telephone). 
    a_compl(available,thing,to,place).       %% NOT STANDARD

adj_templ(average,thing). 
adj_templ(awake,thing). 
    a_compl(awake,agent,until,coevent). %% TA-110106

adj_templ(aware,thing). 
    a_compl(aware,agent,of,thing). %%
    a_compl(aware,agent,on,thing). %% Norw




adj_templ(bad,thing). 
    a_compl(bad,thing,for,agent). %% dårlig til å være 
    a_compl(bad,thing,in,place). 
adj_templ(beautiful,thing). 
    a_compl(beautiful,thing,in,place).  

% adj_templ(beautiful,agent). %%  :-) 
% adj_templ(beautiful,weather). %% thing ?

adj_templ(below,thing). %% spm nedenefor

adj_templ(best,thing).
   a_compl(best,thing,in,place). %% you are best in the world 
   a_compl(best,vehicle,from,place). %% standard ???? 
   a_compl(best,vehicle,to,place).   %% standard ???? 

adj_templ(better,thing).
adj_templ(bright,colur).
adj_templ(bright,object). 
adj_templ(brown,vehicle). %% thing). %% TA-101129 er du brun? --


adj_templ(busy,agent). %%  travel/opptatt/interesert 
     a_compl(busy,agent,in,thing). %% TA-101109
     a_compl(busy,agent,of,thing). 

adj_templ(busy,time). 

adj_templ(central,place). 
adj_templ(certain,thing). 
    a_compl(certain,thing,on,thing). 
    a_compl(certain,thing,with,measure). %% sikker med 90 %

%%%   adj_templ(change,thing). 
%%%    a_compl(change,thing,nil,time_count). %%  (?)
adj_templ(cheap,thing). 
    a_compl(cheap,thing,for,agent). 
adj_templ(clean,thing). 

adj_templ(clear,thing). %%  (sometimes ready, disamb err)
    a_compl(clear,thing,for,thing). 
    a_compl(clear,agent,to,thing).    %% Norw.
    a_compl(clear,agent,over,thing).  %% klar over

adj_templ(clever,agent). 
    a_compl(clever,thing,to,thing).   %% Norw: flink til noe 
    a_compl(clever,agent,with,thing).

adj_templ(closed,thing). 
    a_compl(closed,thing,in,place).  %% standard ?
    a_compl(closed,thing,for,for). 
adj_templ(coloured,thing).
adj_templ(cool,thing). 
adj_templ(cold,drink). 
adj_templ(cold,weather).
    a_compl(cold,weather,in,place). 
adj_templ(common,thing).

adj_templ(complete,thing). %% ferdigglaget

adj_templ(comprehensible,thing). 
    a_compl(comprehensible,thing,for,agent). 
adj_templ(comprehensible,sentence). 

adj_templ(conscious,agent).
adj_templ(correct,thing). 
    a_compl(correct,thing,for,thing). 
    a_compl(correct,thing,in,thing).  %% rettet i bussoraklet %% TA-101102
adj_templ(correct,time). 
adj_templ(corresponding,vehicle). 
adj_templ(crude,oil).         
adj_templ(curious,agent). 
    a_compl(curious,agent,on,thing). 

adj_templ(current,thing). %% abstract/place/time/version 

adj_templ(daily,leader). %% boss %%  day_to_day, but daily is more general
adj_templ(daily,vehicle). 
adj_templ(daily,departure). 
adj_templ(dangerous,thing). %% activity). 
adj_templ(danish,thing). 
adj_templ(dark,thing).

adj_templ(delayed,thing). %% trege (svar) = forsinket=deleayed
   a_compl(delayed,thing,to,place). 

adj_templ(dependent,thing).
     a_compl(dependent,thing,for,thing).
     a_compl(dependent,thing,of,thing). 

adj_templ(depressed,agent). 
adj_templ(dead,agent). 



/*
adj_templ(delayed,person). 
adj_templ(delayed,activity). 
adj_templ(delayed,clock). 
adj_templ(delayed,company).  %% e.g. TT (Team) 
*/
    
adj_templ(delayed,vehicle). 
    a_compl(delayed,thing,nil,time). 
    a_compl(delayed,vehicle,from,place). %% nonstandard for some reason
    a_compl(delayed,vehicle,on,route).   %% vehicle? 
    a_compl(delayed,vehicle,to,place). 
    a_compl(delayed,vehicle,to,place).   %% (not standard ?)
    a_compl(delayed,agent,to,activity).  %% for sen til møte 
    a_compl(delayed,person,to,vehicle).  %% jeg er for sen 
    a_compl(delayed,thing,with,time).    %% buss|klokke  med 2 minutter  
    a_compl(delayed,vehicle,with,frequency). %% ofte (with frequency)

adj_templ(dummish,thing). %% dummy adjective ( a la redundantly).%% TA-110309

adj_templ(together,thing). %% NB aslo adverb
    a_compl(together,thing,with,thing). %% TA-110221

adj_templ(tolerant,agent).     
    a_compl(tolerant,agent,at,thing). %% overfor

adj_templ(tooearly,person). %% Techn. <-> delayed 
adj_templ(tooearly,activity). 
adj_templ(tooearly,company).  %% e.g. TT (Team) 
    
adj_templ(tooearly,vehicle). 
    a_compl(tooearly,thing,nil,time). 
    a_compl(tooearly,vehicle,from,place). %% nonstandard for some reason
    a_compl(tooearly,vehicle,on,route).   %% vehicle? 
    a_compl(tooearly,vehicle,to,place). 
    a_compl(tooearly,vehicle,to,place).   %% (not standard ?)
    a_compl(tooearly,agent,to,activity).  %%  for sen til møte  
    a_compl(tooearly,person,to,vehicle).  %%  jeg er for sen 
    a_compl(tooearly,vehicle,with,frequency).

    a_compl(toearly,thing,to,place). 


adj_templ(different,thing).
   a_compl(different,thing,from,thing). 
   a_compl(different,thing,on,thing).

adj_templ(difficult,thing). 
    a_compl(difficult,thing,on,place). %% :-)
    a_compl(difficult,thing,outside,thing). %% "utover" Norw %% TA-110426
 

adj_templ(digital,equipment).

adj_templ(direct,sentence).   %% sp/svar 
adj_templ(direct,connection).
adj_templ(direct,transfer).  
adj_templ(direct,vehicle). 

adj_templ(dissatisfied,agent).
    a_compl(dissatisfied,agent,with,thing). 
adj_templ(divorced,person).
adj_templ(double,thing). 
adj_templ(down,thing).      %% DOWN
    a_compl(down,thing,nil,time). %% 
    a_compl(down,thing,via,thing). %% irreg, bussoraklet er nede via SMS 
    a_compl(down,thing,on,thing).  %% nedrest på ruteheftet
  
%% full -> full|drunk Norw

adj_templ(drunk,savant). %% just for you %% TA-100923
%% adj_templ(drunk,program).

adj_templ(drunk,person).
    a_compl(drunk,person,in,vehicle).
    a_compl(drunk,person,on,vehicle).
    a_compl(drunk,agent,on,job).  %% TA-110807

adj_templ(full,vehicle). %% thing). gulle folk %% AMB
    a_compl(full,thing,of,thing). 

% an earlier/later bus


adj_templ(early,thing). 

adj_templ(easy,thing). 
    a_compl(easy,thing,with,thing). 
    a_compl(easy,thing,for,agent).  

adj_templ(eastern,area).
adj_templ(electronic,information). %% (e.g. map)
    adj_templ(electronic,card). 
    adj_templ(electronic,sale). 
    adj_templ(electronic,ticket).  


adj_templ(electric,vehicle). 
    adj_templ(electric,wheelchair). 

adj_templ(embarrassed,agent). %% rr 
    a_compl(embarrassed,agent,about,thing). %%
    a_compl(embarrassed,agent,for,thing). %% incl coevent
    a_compl(embarrassed,agent,over,thing). %%

adj_templ(empty,vehicle). 
adj_templ(empty,information). %% e.g. 
    a_compl(empty,vehicle,for,fuel). 


adj_templ(enclosed,thing). %% ad hoc 
adj_templ(english,thing). %% blocked  by name

    adj_templ(british,thing).

adj_templ(equal,thing). %% set), % buses go at the same time
adj_templ(european,thing).

%% adj_templ(expensive,thing). %% ala cheap %% avoid cheap girls (?)
adj_templ(expensive,thing).   %%      Dyre halse = expensive Halset  
adj_templ(expensive,price).
    adj_templ(expensive,trip).
    a_compl(expensive,thing,with,thing).
    a_compl(expensive,thing,for,agent). 
    a_compl(expensive,thing,from,place). 
    a_compl(expensive,thing,to,place).  


adj_templ(experienced,agent). 

adj_templ(expired,thing). 

adj_templ(extra,thing). 

adj_templ(external,thing). %% TA-110622

adj_templ(false,thing). 
    a_compl(false,thing,with,thing). %% amb galt=false|wrong 

adj_templ(famous,thing). %% TA-110301
    a_compl(famous,thing,in,place).

adj_templ(fast,thing). 
adj_templ(faster,thing).
adj_templ(fastest,thing). 
    a_compl(fast,thing,in,place). 
    a_compl(fast,thing,from,place).
    a_compl(fast,thing,on,thing).  %% Norw  raskere på spørsmål
    a_compl(fast,thing,to,place). 


adj_templ(favourite, thing). 
adj_templ(female,agent). %% are you female    
%% adj_templ(fine,weather). %% = good ?


adj_templ(finished,thing).  
    a_compl(finished,agent,nil,clock). %% ferdig kl 12

% adj_templ(finished,summer). %% NOT thing incl time/ number:
% adj_templ(finished,winter).
%%%                  ti  over 11 -> til finished 11
    a_compl(finished,thing,on,thing).  %% Norwagism  slutt på sommeren
    a_compl(finished,agent,with,thing). 


adj_templ(first,departure).  
adj_templ(first,time_count). %%  (necessary ?)
adj_templ(first,vehicle).    %% any problems ??

adj_templ(fixed,thing).  %% TA-101117

adj_templ(foreign,thing). 
    a_compl(foreign,thing,in,abstract).
    a_compl(foreign,thing,in,place). 

adj_templ(foremost,thing).

adj_templ(free,thing). %%   e.g. free_of_charge
    a_compl(free,thing,for,agent). 
    a_compl(free,thing,on,vehicle). 

adj_templ(gratis,thing). %%   e.g. gratis_of_charge
    a_compl(gratis,thing,for,agent). 
    a_compl(gratis,thing,on,vehicle). 

adj_templ(french,thing).   
adj_templ(full,departure).  %% -- list, i.e. timetable 
adj_templ(full,vehicle). 
    a_compl(full,thing,in,vehicle).
    a_compl(full,thing,on,vehicle). %%  fullt på bussen
adj_templ(full,place). 
    a_compl(full,place,with,thing).
    a_compl(full,place,on,thing).   %%  (på bussen :-)
    a_compl(full,place,off,thing).  %%  (av)
    a_compl(full,thing,on,vehicle). %% ?
adj_templ(funny,thing).  %%   :-)

adj_templ(general,abstract).
adj_templ(general,program).
adj_templ(general,information).

adj_templ(given,thing). %% angitt/oppgitt 

adj_templ(good,thing). %% not friday :-(
    
%% unnec  a_compl(good,thing,nil,thing). %%//good,bad etc

    a_compl(good,thing,among,thing). %% best in Norway
    a_compl(good,thing,for,thing).
    a_compl(good,thing,in,place).  
    a_compl(good,thing,on,thing). %% god på bussruter %% TA-110825 %%  Norw
    a_compl(good,thing,to,agent). %% thing). %% gode svar til bruker 
    a_compl(good,thing,with,thing). 
    
    a_compl(good,agent,in,place).
    a_compl(good,agent,in,language). 
    a_compl(good,agent,in,relation). 
    a_compl(good,weather,in,time). 


adj_templ(grateful,person). 
    a_compl(grateful,person,for,thing).


%% adj_templ(great,thing). %% -> stor rosten

adj_templ(great,thing). 
    a_compl(great,thing,in,place).
    a_compl(great,thing,on,place). %%  Norw
    a_compl(great,thing,off,place). %% størst av Norge og Sverige %% TA-110331

% adj_templ(half,thing).       %%  Confuses  halv tre
adj_templ(half,hour).          %% bus goes a half hour
adj_templ(half,month).  %% etc
adj_templ(half,abstract). %% halve æren :-) 

%%%   adj_templ(half,object). %%  NEI halv 7 = halv object route

adj_templ(happy,agent). 
    a_compl(happy,agent,in,thing).   %% i.e. glad i ( Norwagism)
    a_compl(happy,agent,with,thing). %% fornøyd med 

adj_templ(happy,time). %% (incl life)  :-)

adj_templ(heavy,thing).   %% object/person  etc
    a_compl(heavy,thing,for,thing). %% too heavy


adj_templ(hidden,thing). 
    adj_templ(visible,thing).

adj_templ(high,intelligence). 
adj_templ(high,measure).
adj_templ(high,number).   
adj_templ(high,house). 

adj_templ(honest,agent). 
adj_templ(human,thing).  
adj_templ(humoristic,thing). %% TA-110125 \+ ou
adj_templ(hungry,agent). %% :-)
adj_templ(holy,day). 
adj_templ(hot,weather). 
    a_compl(hot,weather,in,place). 
adj_templ(icy,weather). %% icy road
adj_templ(icy,street). 
    a_compl(icy,weather,in,place). 
    a_compl(icy,thing,on,place). 
 %%    a_compl(icy,thing,on,street).  


adj_templ(ill,agent). 
adj_templ(implied,thing).
adj_templ(important,thing).
    a_compl(important,thing,for,agent).
adj_templ(impossible,thing). 
    a_compl(impossible,thing,for,agent). 
    a_compl(impossible,thing,in,time).
    a_compl(impossible,thing,on,time). 
    a_compl(impossible,thing,in,vehicle).
    a_compl(impossible,thing,on,vehicle).
    a_compl(impossible,thing,before,time).
    a_compl(impossible,thing,after,time).
    a_compl(impossible,thing,with,thing).  %% Norw %% relax qual
    a_compl(impossible,bus,from,place).
    a_compl(impossible,bus,to,place).
    a_compl(impossible,pram,on,vehicle). %%   ( umulig med barnevogn på bussen ?)


adj_templ(impressed,person).
    a_compl(impressed,person,over,thing).
    a_compl(impressed,person,by,thing).

adj_templ(included,thing).
    a_compl(included,thing,in,thing).

adj_templ(incomprehensible,thing). 
    a_compl(incomprehensible,thing,for,agent). 
 
% adj_templ(incomprehensible,agent).   
% adj_templ(incomprehensible,sentence).  %% ( question/ answer  :-)


adj_templ(independent,thing).  
    a_compl(independent,thing,of,thing).

adj_templ(indifferent,agent). 
    a_compl(indifferent,agent,in,thing).   %% i.e. glad i ( Norwagism)
    a_compl(indifferent,agent,with,thing). %% fornøyd med 

adj_templ(individual,thing). %% ACT as a dummy adjective %% TA-110419

adj_templ(intelligent,coevent). %% å reise til Lian er smart
adj_templ(intelligent,agent).
    a_compl(intelligent,agent,in,place). %%  :-)
adj_templ(intelligent,game).   
adj_templ(intelligent,homepage). %% :-) 
adj_templ(intelligent,mode). 
adj_templ(intelligent,service) . %% :-) 
adj_templ(intelligent,sentence).  
adj_templ(intelligent,talk). 
    a_compl(intelligent,agent,according_to,test).  %%  :-)

adj_templ(intensive,ward).
adj_templ(interested,agent). 
    a_compl(interested,agent,in,thing). 

adj_templ(interesting,thing).

adj_templ(internal,thing).

adj_templ(intransitive,verb).
adj_templ(irrelevant,thing).  %%  (answer closure)

adj_templ(joint,thing).      %% - bill 

adj_templ(known,thing).
    a_compl(known,thing,as,thing). 
    a_compl(known,agent,in,place). 
    a_compl(known,agent,with,thing). %% Norw 

adj_templ(last,thing). 
    a_compl(last,thing,from,place). 
    a_compl(last,thing,to,place).
    a_compl(last,thing,before,time).

adj_templ(late,time).  
adj_templ(late,agent).    %% sen
adj_templ(late,answer). 
adj_templ(late,departure). 
adj_templ(late,vehicle).  %% not thing 
    a_compl(late,thing,at,place). 
    a_compl(late,thing,for,meeting).
    a_compl(late,thing,to,meeting).  %% norw
    a_compl(late,thing,to,vehicle).  %% for sen til bussen 
    a_compl(late,thing,with,thing). 

adj_templ(left,thing). %% side,

adj_templ(limited,thing). %%  rutetilbud ???/way
    a_compl(limited,thing,to,thing). 

adj_templ(little,thing). %%  if appl
adj_templ(small,thing).  %%
    a_compl(small,thing,for,thing). %% little step for a man 
adj_templ(local,company). 
adj_templ(local,vehicle).

adj_templ(local,thing). %%  trip/time ...
%% adj_templ(local,trip). 
adj_templ(lost,luggage). 
adj_templ(low,thing).
adj_templ(loyal,person).     
    a_compl(loyal,person,to,manager).

adj_templ(logical,thing). %% formula).

adj_templ(long,thing).    %% er det langt fra A til B
    a_compl(long,place,between,place).
    a_compl(long,place,from,place).
    a_compl(long,place,to,place).   
    a_compl(long,place,until,place). %% inn()til 
    a_compl(long,route_plan,in,place).
    a_compl(long,route,in,place). 

adj_templ(longer,thing).  
adj_templ(longest,thing). 
adj_templ(lucky,agent). 

adj_templ(mail,carrier).     
adj_templ(main,thing).
adj_templ(male,agent).   %% are you male   

adj_templ(manual,activity). 
adj_templ(married,agent). 
    a_compl(married,person,to,agent).  
    a_compl(married,person,with,agent).  %% Norwagism

adj_templ(massive,object).
adj_templ(medium,thing).         %%  NB Ad hoc medium is adjective

adj_templ(mild,weather).   
adj_templ(mild,form).  %% TA-100907 rondane 
    a_compl(mild,thing,in,time). 
    a_compl(mild,thing,now,time). %%   ad hoc ?

adj_templ(missing,thing).
adj_templ(misspelled,thing).
adj_templ(monthly,price).    %% fare
adj_templ(monthly,ticket). 

adj_templ(motorized,thing). %% TA-100909

adj_templ(named,thing). %% etter nevnte avgang 

adj_templ(nasty,weather). 

adj_templ(national,thing). 
    adj_templ(global,thing). 

/** causes havoc   station that is nearest ... Kolstad 
                       adj / nearest/Kolstad
    must be eliminated in syntax

**/

adj_templ(natural,thing).  
adj_templ(linguistic,thing). %% metagorical naturlig språklig 

adj_templ(near,place). 
    a_compl(near,thing,to,place).

adj_templ(near,time).    %% near future 
adj_templ(near,vehicle). %%   err nærmeste buss -> neste buss 




adj_templ(nearest,place). %% ad hoc = sup near 
    a_compl(nearest,city,to,city). %% special ?
    a_compl(nearest,place,to,place).
    a_compl(nearest,place,off,place). %% i nærheten AV 

adj_templ(nearest,departure). %%  (nærmest)   means next
adj_templ(nearest,vehicle).  


adj_templ(necessary,thing).
    a_compl(necessary,thing,in,time).
    a_compl(necessary,thing,on,time).
    a_compl(necessary,thing,before,time).
    a_compl(necessary,thing,after,time).
    a_compl(necessary,thing,with,transfer). %% Norw
    a_compl(necessary,thing,with,animal). %% Norw (er det lov med dyr
    a_compl(necessary,thing,for,agent).  
    a_compl(necessary,bus,from,place).
    a_compl(necessary,bus,to,place).
    a_compl(necessary,pram,on,vehicle).  %%   ( lov med barnevogn på bussen ?)
    a_compl(necessary,thing,with,thing).


adj_templ(nearest,hour). %% = next   cautious definition

adj_templ(new,thing). %% ny bussrute OK qua route_plan/ not ok qua bus

adj_templ(nex,thing). %% NB   same as nest  (NORW, Technical) 

adj_templ(next,thing). %% not next (2'o) clock  ?? 


adj_templ(nice,thing). 

    a_compl(nice,thing,nil,time).      %% it was nice tonight
    a_compl(nice,thing,on,meeting).    %%  :-)
    a_compl(nice,agent,in_order_to,thing). 
    a_compl(nice,agent,with,agent).    %% snill med :-)
    a_compl(nice,agent,towards,agent). %%              mot

adj_templ(northern,area).
adj_templ(norwegian,thing).  

adj_templ(old,thing). 
    a_compl(old,agent,for,ticket). 



adj_templ(open,agent). %% (you qua) company %% dere 
adj_templ(open,company).
adj_templ(open,information).  
adj_templ(open,office). 
adj_templ(open,door). 
adj_templ(open,place). %% qua office 
    a_compl(open,thing,now,time). %% TA-100915
    a_compl(open,thing,nil,date). 
    a_compl(open,thing,nil,day). 
    a_compl(open,thing,for,thing).
    a_compl(open,thing,in,place).  
    a_compl(open,thing,on,date).  
    a_compl(open,thing,on,day). 
    a_compl(open,thing,with,duration). 

adj_templ(opposite,direction). 
adj_templ(ordinary,thing). 


adj_templ(perfect,thing). 

adj_templ(permanent,thing).

adj_templ(personal,thing). %% :-) belonging
%% adj_templ(personal,problem).

%% adj_templ(percent,measure).        %%   Incorrect  

adj_templ(pink,thing).

adj_templ(planned,thing). 

adj_templ(poor,agent). 

adj_templ(possible,thing).
    a_compl(possible,thing,before,time).
    a_compl(possible,thing,after,time).
    a_compl(possible,thing,for,thing).  
    a_compl(possible,thing,in,time).
    a_compl(possible,thing,in,vehicle). 
    a_compl(possible,thing,on,vehicle). 
    a_compl(possible,thing,on,time). 
    a_compl(possible,thing,with,transfer). %% Norw
    a_compl(possible,thing,with,animal).   %% Norw (er det lov med dyr ?)
    a_compl(possible,thing,with,food).
    a_compl(possible,thing,for,agent). 
    a_compl(possible,bus,from,place).
    a_compl(possible,bus,to,place).
    a_compl(possible,pram,on,vehicle).   %%  ( lov med barnevogn på bussen ?)
    a_compl(possible,thing,with,pram).   %% tillatt med barnevogn %% SIC %% TA-100915
    a_compl(possible,pram,with,vehicle). 

% Bussen er fremme 10 \==  en "fremme" buss. 



adj_templ(precise,thing). %% presist navn 

adj_templ(present,thing).  %%   NOT place ! // OK
    a_compl(present,thing,at,place). 
    a_compl(present,thing,on,place). %% TA-101108
    a_compl(present,thing,to,place). %% Norw  fremme til
    a_compl(present,thing,to,time).  %% Norw  fremme før 
    a_compl(present,thing,from,place). %%   fremme (til A) fra B

%% etc 
%%    a_compl(present,thing,Prep,X):-
%%       v_compl(exist,thing,Prep,X). 

adj_templ(previous,thing).     
adj_templ(printed,information). %% route_plan

adj_templ(private,_). 

adj_templ(proud,agent). %%
    a_compl(proud,agent,of,thing).   %% also subord 
    a_compl(proud,agent,over,thing). 

adj_templ(public,agent).  
adj_templ(public,vehicle). 
%% adj_templ(punctual,company). %% TT // Experiment
adj_templ(punctual,vehicle). 
%% adj_templ(punctual,time).          // experiment

adj_templ(ready,thing). 
    a_compl(ready,agent,for,thing).   %% 
    a_compl(ready,agent,to,thing).    %% Norw.
    a_compl(ready,agent,over,thing).  %% klar over

adj_templ(real,thing).
    a_compl(real,thing,for,thing).  %% TA-110808 
adj_templ(relative,thing).
adj_templ(relevant,thing).  %% Answer closure 
    a_compl(relevant,thing,for,thing). 
adj_templ(reliable,thing). 
adj_templ(remaining,thing). %% money/time 

adj_templ(remote,agent).  %% du er fjern 
adj_templ(remote,place). 
adj_templ(responsible,agent). 
    a_compl(responsible,agent,for,thing). 
adj_templ(revised,file).
adj_templ(right,thing). %% side 

%% adj_templ(safe,agent).  
adj_templ(safe,thing). %% vehicle).
    a_compl(safe,thing,in,place).  
    a_compl(safe,thing,in,vehicle). 
adj_templ(same,thing). 
adj_templ(second,thing). %% TA-109090
adj_templ(second_last,thing). 
adj_templ(secret,thing). 
adj_templ(semantic,base).
adj_templ(separate,thing). 
adj_templ(short,thing). %% time,object,...
adj_templ(sick,agent). 
adj_templ(similar,thing).
adj_templ(simple,thing). %% information/problem
adj_templ(single,thing). 
adj_templ(sized,thing).  %%  ( medium sized :-)  ad hoc
adj_templ(slow,thing).
    a_compl(slow,thing,via,thing).
adj_templ(small,thing).
adj_templ(sober,agent). 
    a_compl(sober,agent,in,vehicle). 
    a_compl(sober,agent,on,vehicle).
adj_templ(sophisticated,thing).
adj_templ(sorted,list).   
adj_templ(sorry,agent).  

adj_templ(sour,sentence). %% frekt/ etc
adj_templ(sour,agent).    %%  :-(
    a_compl(sour,agent,by,thing).
    a_compl(sour,agent,on,thing).   %% Norw. 
    a_compl(sour,agent,over,thing). %% Norw. 
    a_compl(sour,agent,towards,agent). 

adj_templ(southern,area).
adj_templ(special,thing). 
    a_compl(special,thing,with,thing). %% Norw 
adj_templ(specified,thing).  %% ?

adj_templ(speech_based,system).

adj_templ(static,thing).


adj_templ(strong,thing). 
adj_templ(stupid,thing).

%% adj_templ(stupid,place). %%  :-)
%% adj_templ(stupid,agent). %% "bussen er dum*" 
    a_compl(stupid,agent,in,head). %% :-)

adj_templ(sufficient,thing).
    a_compl(sufficient,thing,for,thing).
    a_compl(sufficient,thing,to,thing). 
adj_templ(swedish,thing).
adj_templ(sweet,thing).
adj_templ(system,command).

adj_templ(tedious,thing). 
    a_compl(tedious,thing,on,job). %% TA-101228
    a_compl(tedious,thing,on,place). 

adj_templ(terrible,weather).  

adj_templ(textual,system). 
adj_templ(textual,information).

adj_templ(technical,thing). 
adj_templ(tired,agent). 
    a_compl(tired,agent,off,thing). %% N  
    a_compl(tired,agent,of,thing).  %% E
adj_templ(transitive,verb).  
adj_templ(true,thing).             %%   (i.e. dummy)

    a_compl(bad,thing,for,thing). 
    a_compl(good,thing,for,thing).


adj_templ(ugly,thing).  
adj_templ(uncertain,agent).
     a_compl(uncertain,agent,for,thing). %% mhp = for 
     a_compl(uncertain,agent,on,thing).  %% Norw 
adj_templ(unchanged,thing).
adj_templ(understanding,agent). 

adj_templ(sad,thing). %% beklagelig feil 
    a_compl(sad,agent,nil,time).   %%  trist nå %%  nec?
    a_compl(sad,agent,off,thing).  %%  Norw lei av å

adj_templ(unhappy,agent).      %% -> sad
    a_compl(unhappy,agent,off,thing).  %%  Norwag lei av å


adj_templ(unknown,thing).  
    a_compl(unknown,thing,in,place). 
  a_compl(unknown,thing,in,language). 
  a_compl(unknown,thing,on,language). %% Norw
  a_compl(unknown,thing,with,thing). 

adj_templ(up,thing).         %% Pragmatic (adverb)
    a_compl(up,thing,nil,time). 

adj_templ(updated,thing). 
    a_compl(updated,thing,nil,time).
    a_compl(updated,thing,in,time).

adj_templ(used,thing). 
% adj_templ(use,bus).            %% i.e. used 
%     a_compl(use,bus,in,place). %%   confusing --> passive

adj_templ(user,manual).      

adj_templ(valid,thing). 
    a_compl(valid,thing,nil,time).  %% hvor lenge %% TA-100907
    a_compl(valid,thing,for,activity).  %% TA-100907
    a_compl(valid,thing,for,time). 
    a_compl(valid,thing,in,time).       %%  generic
    a_compl(valid,thing,on,vehicle).
    a_compl(valid,thing,from,time).     %% stanprep ?
    a_compl(valid,thing,to,time).       %% 
    a_compl(valid,thing,until,time). 

adj_templ(wide,thing). 

adj_templ(waybound,vehicle). 
adj_templ(waybound,place). 
adj_templ(waybound,direction). 

adj_templ(webbased,system). 
adj_templ(webbased,information).
    a_compl(webbased,thing,with,weight). %% ad hoc, metaphoric 

adj_templ(welcome,thing).
adj_templ(western,area).

adj_templ(wet,weather).          %%  (rainy)
    a_compl(wet,weather,in,place).

adj_templ(whole,thing). 

    adj_templ(full,thing). %% disamb 

adj_templ(wise,person). 
adj_templ(worn,cloth).  
adj_templ(worse,thing). 
adj_templ(worst,thing).
adj_templ(wrong,thing). 
    a_compl(wrong,thing,in,thing). 
    a_compl(wrong,thing,with,thing).
% adj_templ(wrong,agent).        %%   (misinformed or mad :-)
adj_templ(young,person). 


%% POST-ADJECTIVE 

post_adjective(down).     %% down town 

%% post_adjective(finished).  %% ferdig kl 13 // en ferdiglaget tekst
   %% ferdig tekst                       %% NB PROBLEM

post_adjective(present).  %% a present bus ##

%% post_adjective(possible). %% mulig nth  / et mulig spørsmål 


% ADJECTIVAL NOUN PREFIX

%%% TRIPLETS 

%%% adjnoun_templ/3 ->adjnouncomp_templ/3 


%% TRIPLETS  air bus => T isa airbus

adjnouncomp_templ(network,page,webaddress). 
adjnouncomp_templ(age,limit,agelimit). 
adjnouncomp_templ(air,bus,airbus).  
adjnouncomp_templ(airport,bus,airbus). 
adjnouncomp_templ(bus,company,company). %%  (?)
adjnouncomp_templ(bus,departure,departure).   
adjnouncomp_templ(bus,information,information). 
adjnouncomp_templ(bus,list,route_plan). %% TA-110701
adjnouncomp_templ(bus,money,money). 
adjnouncomp_templ(bus,number,bus).     %% ( bus no. 4) buss nr 12345 
adjnouncomp_templ(bus,oracle,oracle). 
adjnouncomp_templ(bus,person,driver).  %% imprecise
adjnouncomp_templ(bus,route,bus).   
adjnouncomp_templ(bus,service,route). 
adjnouncomp_templ(bus,time,departure). 
% adjnouncomp_templ(bus,stop,station).   %% Only for E, destroys which bus stop at nth
adjnouncomp_templ(data,base,database). 
adjnouncomp_templ(departure,time,departure).
adjnouncomp_templ(departure,departure,departure).   %%  (sic) departure schedule
adjnouncomp_templ(email,address,mailaddress). %%  i.e. email
adjnouncomp_templ(email,window,window).       %% TA-110617 
adjnouncomp_templ(end,station,endstation). 
adjnouncomp_templ(expert,system,expertsystem). 
adjnouncomp_templ(evening,bus,eveningbus).
adjnouncomp_templ(home,page,webaddress). %% - homepage 
adjnouncomp_templ(internet,address,webaddress). %% in case internet is a noun
adjnouncomp_templ(mail,address,mailaddress).  
adjnouncomp_templ(month,card,card).
adjnouncomp_templ(morning,bus,morningbus). 
adjnouncomp_templ(midnight,bus,nightbus). 
adjnouncomp_templ(midnight,price,special_ticket). 
adjnouncomp_templ(web,address,webaddress).
adjnouncomp_templ(night,bus,nightbus). 
adjnouncomp_templ(nl,system,oracle). %%  Rough
adjnouncomp_templ(plane,bus,airbus).          
adjnouncomp_templ(route,number,route).  
adjnouncomp_templ(route,oracle,oracle). 
adjnouncomp_templ(start,station,endstation).   %% SIC 
adjnouncomp_templ(station,station,station).    %% e.g. stopp holdeplass
adjnouncomp_templ(summer,halfyear,summer). 
adjnouncomp_templ(summer,route,summerroute). 
adjnouncomp_templ(telephone,number,telephone).
adjnouncomp_templ(ticket,price,price). 
adjnouncomp_templ(time,departure,departure). 
adjnouncomp_templ(time,list,departure). 
adjnouncomp_templ(time,route_plan,departure).  %% get time plan
adjnouncomp_templ(traffic,route,route_plan). 
adjnouncomp_templ(train,station,station).      %% = bus station from the point our p.o.v.
adjnouncomp_templ(tram,number,tram). 
adjnouncomp_templ(tram,route,tram). 
adjnouncomp_templ(tram,time,tram_route_plan). 
adjnouncomp_templ(type,question,question).     %%  etc etc
adjnouncomp_templ(vehicle,number,vehicle).
adjnouncomp_templ(web,page,webaddress).%% web side/sideb/sider/sidene 
adjnouncomp_templ(winter,route,winterroute). 

%% DOUBLETS   arrival time = T isa time and adj / arrival/T/E 

adjnoun_templ(address,route_plan). %% gateadresse-katalogen 
adjnoun_templ(bus,accident). 
adjnoun_templ(arrival,time).  
adjnoun_templ(bus,door).  
adjnoun_templ(bus,station).  
adjnoun_templ(bus,route).        
adjnoun_templ(bus,trip).      %% TA-110823
adjnoun_templ(train,route).         %% (no inheritance (vehicle))
adjnoun_templ(bus,question). 
adjnoun_templ(bus,ticket). 
%% adjnoun_templ(bus,trip). %% 
adjnoun_templ(card,servicecenter).
adjnoun_templ(company,vehicle). %%  ==> allows tt bus but not tt object
adjnoun_templ(company,route).  %% nec ? %% TA-110309
adjnoun_templ(computer,operation). %% server ..
adjnoun_templ(departure,time). 

adjnoun_templ(dialogue,content). %% Eng spelling
adjnoun_templ(dialogue,system). 

adjnoun_templ(error,message).
adjnoun_templ(example,thing). 

adjnoun_templ(football,team). 
adjnoun_templ(information,system).
adjnoun_templ(host,company).   
adjnoun_templ(host,computer).  %%
adjnoun_templ(knowledge,base).       

adjnoun_templ(language,processor).
adjnoun_templ(language,savant). %% (natural) language spørresystem
adjnoun_templ(language,system). %% natural language system

adjnoun_templ(mobile,subscription). %% no inheritance  
adjnoun_templ(mobile,telephone). 
adjnoun_templ(mailaddress,system). 

adjnoun_templ(network,thing). %% TA-110309

adjnoun_templ(noun,phrase).
               
adjnoun_templ(oracle,computer). %% ... server 
adjnoun_templ(regtop,export). %% regtop name/noun 

adjnoun_templ(regtop_export,name).

adjnoun_templ(route,information).  
adjnoun_templ(route_plan,file). 


adjnoun_templ(sms,thing).  


adjnoun_templ(service,thing).  
adjnoun_templ(smartphone,thing).  %% TA-110804
adjnoun_templ(statistics,way).    %% -muligheten
adjnoun_templ(syntax,error).
adjnoun_templ(system,savant).

adjnoun_templ(taxi,driver).  
adjnoun_templ(taxi,bill).  

%% adjnoun_templ(time,bus).      %%   fredag buss %%   "a 1610 bus" (prev adj_templ)
adjnoun_templ(time,period).  

adjnoun_templ(walking_time,restriction). %% TA-110419

adjnoun_templ(web,computer).     %% server 
adjnoun_templ(web,format).  
    adjnoun_templ(web,design). 
adjnoun_templ(web,interface). 
adjnoun_templ(web,address).  
adjnoun_templ(web,log).   


% ADJECTIVAL NAME PREFIX

%%% TRIPLETS 

%%% adjname_templ/3 ->adjnamecomp_templ/3 

%% adjnamecomp_templ(regtop,export,regtop_export). 
%% adjnamecomp_templ(hastus,trip,regtop_export).   %% kjøring=trip (metaphoric)
  

adjnamecomp_templ(internet,address,webadress). 
adjnamecomp_templ(sql,base,database). 
adjnamecomp_templ(www,address,webaddress). %% www address -> webaddress
adjnamecomp_templ(www,page,webaddress). 
adjnamecomp_templ(web,page,webaddress). 


%%%% DOUBLETS 

adjname_templ(atb,interface).  %% TA-110701
adjname_templ(atb,logo).       %% TA-110707
adjname_templ(atb,computer).   %% AtB-server


adjname_templ(regtop,export).   %% doesnt work  with adjective
adjname_templ(hastus,trip).     %% e.g. run

adjname_templ(bustuc,computer). 
adjname_templ(busstuc,computer). %% nec?
adjname_templ(c,departure).      %% ad hoc %% route names with a suffix C
adjname_templ(california,time).  %% gen! 
adjname_templ(dvi,file).         %% dvi file -> adj/ dvi /X/real
adjname_templ(e,mail).  
adjname_templ(e,mailaddress).
adjname_templ(forel,code). 
adjname_templ(gauldal_billag,bus).
adjname_templ(gps,location). %% TA-101230
adjname_templ(football,team). 
adjname_templ(gsm,telephone). 
adjname_templ(hastus,data).  
adjname_templ(hastus,name).  %% Metagoric 
adjname_templ(ikt,person).   %% IKT-sjefen %% TA-110114
adjname_templ(internet,address). %%  ( webadress !! )
adjname_templ(ip,address). 
adjname_templ(klæbu,route). 
adjname_templ(msn,address).  %% ?
adjname_templ(prolog,system).
adjname_templ(sms,interface). 
adjname_templ(t,tram).   % t-bane
adjname_templ(tt,driver).
%% adjname_templ(tt,bus).  %% EXCLUDED , inherit from company bus 

adjname_templ(tt,easterroute). %% = teams easterroute 
adjname_templ(tt,summerroute). %%  tt is official name 
adjname_templ(tt,winterroute). 

adjname_templ(team,easterroute). %% = teams easterroute
adjname_templ(team,summerroute). %
adjname_templ(team,winterroute). %

adjname_templ(turing,computer). 
adjname_templ(trondheim,bus).    %%  rough
adjname_templ(trondheim,route).  %%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% N_COMPL


n_compl(above,thing,nil). %% reglene over
n_compl(below,question,nil). %% question below 

n_compl(ago,time,duration). %% TA-100915
n_compl(as,thing,thing).    %% Ad Hoc  samme dag som onsdag %% Technical

% This is only necessary for incomplete sentences
% N: buss fra gløshaugen 2000 til moholt. 
% Also Time consuming

% n_compl COULD have been organised under subject class,
% but then the inheritage would make it difficult to look up


%%   NBNBNB  New use of n_compl

n_compl(below,thing,nil).  %% bussen nedenfor so står 
n_compl(day_after_tomorrow,vehicle,nil).   %% nattbuss i overimorgen
n_compl(day_before_yesterday,vehicle,nil). %% 
n_compl(directly,vehicle,nil).   %% buss direkte fra voll
n_compl(early,vehicle,nil). 
n_compl(today,arrival,nil). 
n_compl(today,departure,nil).
n_compl(hereafter,departure,nil). 
n_compl(hereafter,vehicle,nil).  %%   går buss heretter/snarest

%% n_compl(now,vehicle,nil). %% will bus now go // i take the bus now 

n_compl(now,weather,nil).  %% været nå

n_compl(today,route_plan,nil).  
n_compl(today,vehicle,nil). 

n_compl(today,question,nil). %% spørsmål idag 

n_compl(tomorrow,weather,nil). 
n_compl(tomorrow,vehicle,nil). 
n_compl(tonight,vehicle,nil). 
n_compl(yesterday,vehicle,nil). 

n_compl(that,thing,coevent). %% a solution that  %% Ad Hoc %% TA-110809

% % % % %


%% NO INHERITANCE TO SAVE TIME


n_compl(nil,office,place). %% hvor har AtB sitt kontor %% TA-101029

n_compl(nil,arrival,place). 
n_compl(nil,arrival,neighbourhood). 
n_compl(nil,arrival,station). 

n_compl(nil,arrival,afternoon). 
n_compl(nil,arrival,clock). 
n_compl(nil,arrival,date).  
n_compl(nil,arrival,day).  
n_compl(nil,arrival,evening). 
n_compl(nil,arrival,midnight).
n_compl(nil,arrival,morning). 
n_compl(nil,arrival,morrow). 
n_compl(nil,arrival,night). 

%% n_compl(nil,bus,place).     %% NO, passerer bussen tempe   pragma problem /nil/station/...  
%% n_compl(nil,bus,station).   
%% n_compl(nil,bus,neighbourhood).  

n_compl(nil,group,thing). %% en gruppe mennesker 

n_compl(nil,route,date). %% rute 1. juledag
n_compl(nil,route,station).        %% når er nr 19 Flatåsen %%%% rute (til) dragvoll .

n_compl(nil,route,neighbourhood).  %% TA-101006 ???
n_compl(nil,route,direction). %%  avgang retning lade ?

n_compl(nil,bus,day).   %% TA-110112       %% E: buses saturday ? %% solsiden 10.10 

n_compl(nil,bus,clock).        %% E: buses 1940 ? 
%% n_compl(nil,bus,date).  %% bus june 24  (route) %% solsiden 10.10   

n_compl(nil,bus,monday).  
n_compl(nil,bus,tuesday).    
n_compl(nil,bus,wednesday).    
n_compl(nil,bus,thursday).    
n_compl(nil,bus,friday).    
n_compl(nil,bus,saturday).    
n_compl(nil,bus,sunday).    

n_compl(nil,clock,date).         %%   tidspunkt 18.mai

n_compl(nil,departure,afternoon).
n_compl(nil,departure,clock). 
n_compl(nil,departure,date).  
n_compl(nil,departure,day).  
n_compl(nil,departure,evening). 
n_compl(nil,departure,midnight).
n_compl(nil,departure,morning). 
n_compl(nil,departure,morrow). 
n_compl(nil,departure,night). 
n_compl(nil,departure,place).   %% avgang nth 
n_compl(nil,departure,route).   

n_compl(nil,direction,clock). 

n_compl(nil,extrabus,thing). %% time/route, 

n_compl(nil,length,clock).
n_compl(nil,meeting,time). %% har møte kl 11

n_compl(nil,notification,time).  

n_compl(nil,plan,time). %% ad hoc disponering  ligger på planen kl 2500 for sjåførene 

n_compl(nil,price,card).  
n_compl(nil,price,day).     %% price monday ? 


n_compl(nil,price,vehicle).   %%  doesn't work

n_compl(nil,price,adult). 
n_compl(nil,price,child). 

% n_compl(nil,price,year). 

n_compl(nil,route,date). 
n_compl(nil,route,daypart).      %% e.g. monday morning 

%% n_compl(nil,route,place).        %%  angi ruter dragvoll midtbyen 
                                    %%  3. etage

n_compl(nil,route_plan,date). 
n_compl(nil,route_plan,daypart).    
n_compl(nil,route_plan,day). 
n_compl(nil,route_plan,clock). 
n_compl(nil,route_plan,vehicle). 
                               
n_compl(nil,seat,clock).          %% in case ticket reservation 

n_compl(nil,station,place).   %%  NAF-sentret Trondheim. %% Hazard
n_compl(nil,station,vehicle). %% Haz  ??? holdeplasser buss nr 19 

n_compl(nil,special_ticket,person). 

n_compl(nil,duration,minute). %% ad hoc reisetid 3 minutter 
n_compl(nil,minute,duration). %% ad hoc 3 minutter reisetid 

n_compl(nil,transfer,time). %% TA-101115
n_compl(nil,trip,place).  
n_compl(nil,trip,time). %% tur hver dag 

n_compl(nil,vehicle,date).      %% buss 17. mai 
n_compl(nil,vehicle,clock).     %%  (no inheritance ???)
n_compl(nil,vehicle,direction). %% buss (i) retning byen ??? 
n_compl(nil,vehicle,midnight).  %% buss natt (til søndag)
n_compl(nil,vehicle,daypart).   %%  (? dangerous)
n_compl(nil,vehicle,return).    %%  buss fra nth  med retur kl 19. 
%% n_compl(nil,vehicle,month).  %% buss april ?

%% n_compl(nil,vehicle,place).  %% buss (til folkvang) skole   %%  Når er nr 19 Flatåsen NB

%% n_compl(nil,vehicle,station).  %% TA-110405 *-> nrel/vehicle/station/ila/torvet
                                                                %%%%%%%

n_compl(nil,vehicle,neighboutrhood).  %% 

n_compl(nil,weather,time).      %% været i morgen 
%% n_compl(nil,weather,today).     %% været idag ?
n_compl(nil,weather,place).     %% været ute 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n_compl(about,departure,daypart).           %% busstider  om kvelden  (sloppy)
n_compl(about,departure,day).           %%  (om lørdagen)  Norwagism
n_compl(about,route,day). 
n_compl(about,information,thing). %% regarding is precise %% Need it in English
n_compl(about,vehicle,daypart).   %% om kvelden  (sloppy)

n_compl(about,request,thing). %% et ønske om å ...  


% n_compl(about,route,time).  
% n_compl(about,truth,thing).  

n_compl(after,thursday,clock).  %% Experiment %% TA-101109


n_compl(after,arrival,arrival).   
n_compl(after,arrival,departure). 
n_compl(after,arrival,time).   
n_compl(after,arrival,vehicle).  

n_compl(after,data,activity). %% Metagoric 

n_compl(after,departure,arrival).   
n_compl(after,departure,departure).  
n_compl(after,departure,time).  
n_compl(after,departure,vehicle).


% n_compl(after,bus,time).  -> vehicle         
 %%   (not clock)  buss etter fredag kl 1400

n_compl(after,direction,time). 
n_compl(after,hour,clock).    %%   An hour after 1200
n_compl(after,minute,clock).  %%  NOT duration ( e.g.monday)  %% monday after 1200 <-- no 

n_compl(after,letter,meta).   %% letters after 
n_compl(after,letter,measure).
n_compl(after,route,time). %% NOT clock, nrel/after/route/clock/ 

n_compl(after,time,arrival). 
n_compl(after,time,departure). 


 n_compl(after,vehicle,time). %%  vil buss etter kl 1200 gå til nth ?

% n_compl(after,vehicle,vehicle).       %%  NO " bus after 20" => 2000
% n_compl(after,route_plan, time).  %%   rutetider     tabell over 17
%                                                   => tabell etter kl 17

n_compl(after,station,place). %% (can't answer it though) 
%        bus to Blakli from  NTH . from ==> after (SIC)// not relevant anymore

n_compl(after,route_plan,time). %% not clock  
n_compl(after,way,time). 


n_compl(against,match,country).      % 's team    '
n_compl(against,match,team).

n_compl(ago,vehicle,duration). %% (det gikk en) buss for 5 minutter siden

n_compl(around,arrival,time). 
n_compl(around,vehicle,time). 
n_compl(around,departure,time).  
n_compl(around,neighbourhood,station). 
n_compl(around,route_plan,time). %% clock). // clock makes trouble 

n_compl(at,arrival,place).
n_compl(at,arrival,time). 
n_compl(at,bus,place).           %%  ( vehicle confuses bustrans)
n_compl(at,bus,time). 
n_compl(at,departure,place). 
n_compl(at,departure,time). 
n_compl(at,discount,sale). 
n_compl(at,driver,agent).   %% company "dere"
n_compl(at,job,company). 
n_compl(at,meaning,thing).  %% == with  
n_compl(at,meeting,place).

n_compl(at,neighbourhood,place). %% området ved ...

n_compl(at,person,place). 
n_compl(at,property,thing). 

n_compl(at,route,company). 
n_compl(at,route_plan,place).    %% = for 
n_compl(at,route_plan,time). 

n_compl(at,sale,thing).
n_compl(at,use,thing). 

n_compl(at,station,place).       %%  (e.g. near) 
                                 %% What was the problem sentence ? EXPERIMENT
n_compl(at,station,route).  
   n_compl(after,station,route).   %%  ? act

n_compl(at,strike,company). 
n_compl(at,subscription,company). 

% n_compl(at,station,route).   % vis stasjoner på rute  5 %% EXPERIMENT FAILED 
% bus 5  pass Prinsen Kino at 20 ==> station at route ***


n_compl(after,period,time). %% i (perioden fra ..) til 
n_compl(before,period,time). 

    n_compl(after,minute,vehicle).  %% varslet etter bussen til nardo. %%%%%%%%%
    n_compl(before,minute,vehicle). %% varslet før bussen til nardo/ Garden path

n_compl(behind,system,system). %% programvaren bak  "Spør Anna".



% Buss fra Vestlia som er ved Leangen Ishall klokken 1830

n_compl(after,minute,arrival).  
n_compl(after,minute,departure).  
n_compl(after,minute,vehicle).    %% 4 minutter etter buss 
n_compl(after,notification,time). %% not very likely

n_compl(at,computer,system). %% serveren hos Amazon 
n_compl(at,ticket,company). 
n_compl(at,time,departure).  

n_compl(because_of,delay,thing). %%   EXPERIMENT pga

n_compl(after,minute,printout). %% 45 min. etter utskrift (-s tidspunkt) %% metagoric

n_compl(after,minute,coevent).  


n_compl(after,start,time).  
%%    n_compl(from,start,time).   %%?

n_compl(before,minute,coevent).  %% 15 minutter før bussen går 
n_compl(before,arrival,time). 
n_compl(before,bus,time).            %% (before =\ within)
n_compl(before,departure,time). 
%%%%%% n_compl(before,minute,vehicle).      %% 4 minutter før buss  


n_compl(before,midnight,date).  
n_compl(before,midnight,day).    %% night to sunday (Norwagism)

n_compl(before,minute,arrival).   
n_compl(before,minute,departure). 

n_compl(before,notification,time). 

n_compl(before,question,thing).

n_compl(before,route_plan,clock). 
n_compl(before,hour,time).          %%  1 hour before midnight

n_compl(before,station,place).    

n_compl(before,time,departure).
n_compl(before,time,arrival). 


%% n_compl(before,minute,time). %% to be taken by syntax  ????  %% 16 minutter før 18 = 1744 

n_compl(before,way,time). 

n_compl(below,station,place).   %%  ( place, ?)
n_compl(beyond,station,place).  %% after  w.r.t. place

n_compl(beside,person,person). 

n_compl(between,agelimit,person). 
n_compl(between,arrival,time). 
n_compl(between,border,place). 
n_compl(between,bus,place).     %% Time Between Sentrum ???  %%  buss mellom A og B
% n_compl(between,bus,time).    %% når går bussen mellom 11 og 12
n_compl(between,delay,place). 
n_compl(between,departure,place). 
n_compl(between,departure,time). 
n_compl(between,difference,thing). %% Norwagism
n_compl(between,distance,place).
n_compl(between,duration,vehicle). 
n_compl(between,duration,arrival).    %% 
n_compl(between,duration,departure).  %% 
n_compl(between,duration,place).
n_compl(between,length,place). 
n_compl(between,minute,activity).    %% i.e. departure //
n_compl(between,place,place). 
n_compl(between,route,place).  %% route between stavset and strindheim 
n_compl(between,route_plan,place). 
n_compl(between,station,place). %  route between stavset not rejected 

n_compl(between,transfer,vehicle). 

n_compl(between,ticket,place). 
n_compl(between,ticket,vehicle). %% overgangs ...
n_compl(between,time,activity). 
n_compl(between,time,arrival).  %%  (duration?) 
n_compl(between,time,departure).%%  (duration?)
n_compl(between,transfer,company).
n_compl(between,transfer,place).
n_compl(between,transfer,vehicle).                              
n_compl(between,traveltime,place). %% Technical 
n_compl(between,trip,place). 

% n_compl(between,time,place). %% Time Between Sentrum ???  ( melloma og b)

n_compl(between,vehicle,time).   
n_compl(between,connection,place). 

n_compl(by,arrival,place).
n_compl(by,bus,place).  
n_compl(by,departure,place).
n_compl(by,departure,vehicle). %% passive
n_compl(by,employee,company). 
n_compl(by,time,departure).    %% strange Norw. 
% n_compl(during,bus,time). %% om ==> during2, NOT during 

n_compl(during,departure,time). 


n_compl(during2,clock,time).     %%  :-) %% OM duration 
n_compl(during2,departure,time). 

n_compl(during2,vehicle,time). %% når går buss kl 0830 om morgenen
                               %% <-- Problem ?
     
n_compl(during2,route_plan,time). %% søndagsrute om 4 dager

%% n_compl(during2,vehicle,minute). %% buss om 10 min. %% Suspended 


n_compl(during2,vehicle,summer).
n_compl(during2,vehicle,winter).

n_compl(except,thing,thing). 

n_compl(instead_of,thing,thing). %% TA-110531 (also subjunction)

%% n_compl(except,time,time). %%  (Too general)
%% n_compl(except,departure,route_plan).



n_compl(for,abbreviation,word). 
n_compl(for,address,place). 
n_compl(for,agelimit,person). %% child,... 
n_compl(for,agelimit,ticket). 
n_compl(for,idea,agent).       %% TA-110426 for meg er det en tanke  Norw


% n_compl(for,age,ticket).       %% i.e. limit 
%   shadows  minste alder = aldersgrense

n_compl(for,airport,city). 
n_compl(for,arrival,bus). 
n_compl(for,arrival,place). 

n_compl(for,base,thing). 

n_compl(for,border,place).  

n_compl(for,christmasroute,vehicle). %% = of? 
% n_compl(for,clock,vehicle). 
% buss til buenget  etter (klokken 17 for rute 66) .
n_compl(for,condition,thing).
n_compl(for,leader,company). 
n_compl(for,leader,agent). 

n_compl(for,period,time). 



  %% n_compl(for,bus,route).   %%  bus for route 5// bss fo(ø)r 19 NB
                             
n_compl(for,card,person).  
n_compl(for,card,place).
n_compl(for,card,time). 
n_compl(for,cause,coevent). 
n_compl(for,claim,agent).   %% kriterium for 
n_compl(for,clock,departure).        %%  (tidspunkt for avgang)
n_compl(for,clock,vehicle). 

n_compl(for,time,easter). %% careful  n_compl(for,time,time). %% tider for påske
                          %% TA-110504

% n_compl(for,time,vehicle).   %% i.e. departure %% NOT DAY
                             %% rute på <lørdag for buss> 54
n_compl(for,cause,thing). %% bakgrunn for Norw 

n_compl(for,computer,webaddress). %% server 
n_compl(for,computer,system).     %% oracle

n_compl(for,contact_man,system).


n_compl(for,data,thing).
n_compl(for,date,thing).

n_compl(for,daycode,time). 

n_compl(for,delay,vehicle). 

n_compl(for,departure,vehicle). 
n_compl(for,departure,traffic). %% TA-100905

n_compl(for,delay,vehicle).   
n_compl(for,departure,summer). %% summeroutes
n_compl(for,departure,winter). %% winterroutes

n_compl(for,departure,date). 
n_compl(for,departure,day).
n_compl(for,departure,vehicle). 
n_compl(for,description,thing). %% Norw 

n_compl(for,direction,thing). %% Norw til (vestre for noe) %% 
n_compl(for,discount,person).  


n_compl(for,department,person). %% avdeling for Erik Harborg
n_compl(for,departure,place).
n_compl(for,departure,route_plan).  

n_compl(for,endstation,vehicle). 
n_compl(for,export,route_plan). 

n_compl(for,extrabus,thing). %% vehicle/company/time ... 

n_compl(for,feeling,thing).         %% :-)
n_compl(for,field,thing).            %  "ref thing"
n_compl(for,flow,thing). %% fremkommelighet 
n_compl(for,form,thing). %% skjema 
n_compl(for,frequency,thing). 

n_compl(for,gap,time).     
n_compl(for,interval,time).

n_compl(for,happiness,agent). 
n_compl(for,honour,thing). 
n_compl(for,hope,thing).  
n_compl(for,host,meeting). 
n_compl(for,information,place).
n_compl(for,information,vehicle).
n_compl(for,information,traffic).
n_compl(for,interface,agent). %% person, systemer 


n_compl(for,limit,thing).  
n_compl(for,manual,system).     
n_compl(for,module,interface).
n_compl(for,map,thing).   %% vehicle etc
n_compl(for,name,thing). 
n_compl(for,need,thing).  

n_compl(for,opening_hours,company). 
n_compl(for,opening_hours,neighbourhood).
n_compl(for,opening_hours,office). 
n_compl(for,opening_hours,luggage). %% hittegods-kontor 

n_compl(for,oracle,place). %% e.g. oslo 

n_compl(for,pity,agent).  
n_compl(for,place,liquid). %% sted for øl :-) 
%% n_compl(for,plan,time). 
n_compl(for,plan,thing). %% plan for sjåfører

n_compl(for,price,thing).  

n_compl(for,price,activity).  %% for å reise 
n_compl(for,price,animal).    %%  ( ako object)
n_compl(for,price,bus).  
n_compl(for,price,fare). 
n_compl(for,price,liquid).
n_compl(for,price,object). 
n_compl(for,price,person). 
n_compl(for,price,ticket).   %% ako object ???


n_compl(for,problem,agent). %%  løser problemer for folk

n_compl(for,regtop_export,thing). %%  metagoric
n_compl(for,responsibility,thing). %% (har) ansvar for ...
n_compl(for,return,vehicle). 

n_compl(for,place,thing). %% plass til ting 
n_compl(for,room,thing).  %% Eng
n_compl(for,seat,thing).  %% ?

n_compl(for,solution,thing). %% TA-110807

n_compl(for,route,date).
n_compl(for,route,day). 
n_compl(for,route,departure). 
n_compl(for,route,distance).    %% strekning 
n_compl(for,route,vehicle). 
n_compl(for,route,place). 
n_compl(for,route,daypart).

%% n_compl(for,route_plan,bus). 
n_compl(for,route_plan,vehicle).
n_compl(for,route_plan,place). 



n_compl(for,route_plan,departure). 
n_compl(for,route_plan,day).  
n_compl(for,route_plan,daypart). %% morning, etc.
n_compl(for,route_plan,time).
n_compl(for,route_plan,date). 
n_compl(for,route_plan,place).

n_compl(for,route_plan,spring). 
n_compl(for,route_plan,summer). 
n_compl(for,route_plan,winter).
n_compl(for,route_plan,summerroute). 
n_compl(for,route_plan,winterroute). 
n_compl(for,rule,activity). 

n_compl(for,speech,thing). %% takktale for maten 
n_compl(for,station,bus).  %% hva er stoppested for buss 9 %% route???

%%  buss til buenget for rute 66 etter klokken 17 * 
%% NO longer a problem                           

% n_compl(for,station,place).        %%   MIX leave S for T
n_compl(for,station,route).   %% holdeplass for rute 24?
n_compl(for,station,person). %% hpl for meg 
n_compl(for,stop,bus).
n_compl(for,stamp,ticket).  
n_compl(for,station,vehicle). %% siste stopp for trikken 
n_compl(for,streetnumber,station).  
n_compl(for,saturdayroute,vehicle). 
n_compl(for,strategy,thing). %% incl coevent
n_compl(for,sundayroute,vehicle).   
n_compl(for,system,place). %% TA-110426 bussoraklet for hedmark   

n_compl(for,telephone,thing). %% service, information,...

n_compl(for,thank,help).  

n_compl(for,ticket,animal). 
n_compl(for,ticket,object).
n_compl(for,ticket,person). 
n_compl(for,ticket,time). 
n_compl(for,ticket,trip). 

                        %%  NB  Problem
n_compl(for,time,bus).  %%   buss til buenget  etter klokken 17 for rute 66 .
                        %% EXPERIMENT when noun_complements disallowed for names



n_compl(for,time,arrival).
n_compl(for,time,departure).
n_compl(for,time,meeting).   %%  (activity?)
n_compl(for,time,route). 
n_compl(for,time,number).  %% qua route
n_compl(for,time,place).   %% bus departure times for 

n_compl(for,time,traffic).  %% TA-100905
n_compl(for,time,transfer). %% tid(gyldighet) for overgang

n_compl(for,use,thing).      %%  Norw bruk for

n_compl(for,vehicle,person). %%  cost take a bus for a perso
n_compl(for,vehicle,place). 

n_compl(for,route_plan,time). 
n_compl(for,vehicle,easter).  %% etc nattbussruter
n_compl(for,vehicle,summer).
n_compl(for,vehicle,winter).
n_compl(for,vehicle,christmas).

%%% n_compl(for,vehicle,time).   %%  buss for neste time =
                                 %%  buss for kl 11 #= buss før kl 11
                                
n_compl(for,vehicle,duration).   %%  buss for neste time
n_compl(for,vehicle,spring). 
n_compl(for,vehicle,summer).
n_compl(for,vehicle,fall). 
n_compl(for,vehicle,winter). 



n_compl(for,way,thing).      %% muligheter for
n_compl(for,webaddress,thing).
n_compl(for,word,thing). %% søkeord for


n_compl(from,need,thing). %% special %%
n_compl(from,airplane,place). 
n_compl(from,arrival,place).  
n_compl(from,arrival,bus).           %% EXPERIMENTAL  (e.g.  arrival by )
n_compl(from,boat,place).            %% merge vehicle ?

% n_compl(from,bus,route).      %%  ~ on bus route
% n_compl(from,bus,time).       %% (  clock   touchy ) 

n_compl(from,card,otherbus). 

n_compl(from,claim,agent). 
n_compl(from,claim,place). %% i.e. fra kommunen// rough 
n_compl(from,clock,place). 
n_compl(from,connection,place). 

n_compl(from,departure,place). 
    n_compl(from,way,place). 
n_compl(from,departure,time). 
n_compl(from,direction,place).
n_compl(from,distance,place). 

%% n_compl(from,duration,place).  %%   om en time fra nth
%% n_compl(from,duration,place).  %% tid(sforbruk) fra NTH

n_compl(from,error,thing). %% feil fra vår side 

n_compl(from,export,agent).    
n_compl(from,frequency,place).       %% avgangshyppighet 

n_compl(from,information,agent).     %% not to TUC (?) 

n_compl(from,information,place).     %% ruteopplysning fra Trondheim til Orkanger? 
n_compl(from,length,place).          %%  length from A to B
n_compl(from,message,agent).   

n_compl(from,seat,place).            %% ticket reservation

n_compl(from,service,agent). 

n_compl(from,payment,agent). %% TA-110724
n_compl(from,period,time).   %% \+ (i perioden) (fra ...) ?

n_compl(from,proposal,agent). 

n_compl(from,question,agent). 

n_compl(from,service,agent). 
%% n_compl(from,sms,phonenumber).   
n_compl(from,sms,number).  
n_compl(from,sms,telephone).

n_compl(from,text,thing). %% DB | "eksempler og nedover"

n_compl(from,ticket,company). 
n_compl(from,ticket,place). 

n_compl(from,transfer,place). 
n_compl(from,transformation,thing).    %% TA-110503
    n_compl(to,transformation,thing).  %%
n_compl(from,trip,place). %% TA-100902

n_compl(from,vehicle,place).  

n_compl(from,traveltime,place).

n_compl(from,price,place). 

n_compl(from,bus,route).  % bussen fra rute 7 fra sentrum // Haz?

n_compl(from,route_plan,place).  %%   rutetider 

%   n_compl(from,station,place). 
%   n_compl(to,station,place). 
%   NO                is there a bus from (pirterminalen to torvet).  
                   
%% n_compl(from,street,station). % vei fra  dalgård til tyholt         
n_compl(from,street,place).      % ... fra byen 

%% n_compl(from,person,place).   %% The man from Trondheim 
%%                   %% (hvilken buss tar (jeg fra sjetnemarka) 

n_compl(from,plane,airport).  %% place).           
n_compl(from,money,agent). 
n_compl(from,money,place).

n_compl(from,thing,set).          
n_compl(from,ticket,place). 

% n_compl(from,time,place).    %% NB bussen går (i morgen formiddag fra byen)

n_compl(from,train,place).  

% n_compl(from,tram,place).    %% The relation as such is more general  

%% n_compl(from,thing,text).      %% metagoric %% TA-101110 buss fra c. (j....) 

n_compl(from,transfer,vehicle).         %% cannot take it  %% bus

n_compl(from,trip,place).  

n_compl(from,use,telephone). 

n_compl(from,vehicle,company).      %%   Always as general as possible
%%%    n_compl(from,vehicle,place).    %%  Problem ?       




n_compl(in,C,E):-                    %  Made recursive  
     apos(C,E).

n_compl(in,activity,place).   
n_compl(in,activity,time).  

n_compl(in,agent,company).%% we in Team
n_compl(in,agent,speed).  %% i farta (hurry) %% Norw 
n_compl(ion,agent,speed). %%

n_compl(in,airbus,date). 

n_compl(in,arrival,connection). 
n_compl(in,arrival,direction). 
n_compl(in,arrival,route). 
n_compl(in,arrival,time).       %% ( i tidsrom ... )

n_compl(in,interest,thing). 

n_compl(in,bus,company).  

n_compl(in,company,company). %% Team - Nettbuss 

%% n_compl(in,bus,day).  %% buss i dag                 %%  Emergency

n_compl(in,bus,city).             %% route   Subtle   bussavganger i trondheim

n_compl(in,change,route). % qua plan (Nec)
n_compl(in,change,route_plan). 

n_compl(in,choice,thing).   
   n_compl(of,choice,thing). 

% n_compl(in,clock,place).   %% klokka i Mongolia/ 14:00 in Nardo

n_compl(in,company,company). 

n_compl(in,thing,connection). %% dette er i samsvar med intensjonen
n_compl(in,thing,theory).     %% e.g. according to plan %% TA-110527
n_compl(in,thing,timetable).  %% metagoric 

n_compl(in,database,format). 

n_compl(in,date,year). %% julaften i 2009 

n_compl(in,day,christmas).  %% etc
n_compl(in,day,year).  

n_compl(in,departure,connection).
n_compl(in,departure,direction).
n_compl(in,departure,route).  
n_compl(in,departure,route_plan).  
n_compl(in,departure,time).          %% ( i tidsrom ... )

n_compl(in,station,direction). %% holdeplass i retning (sentrum)

n_compl(in,driver,vehicle). 

n_compl(in,duration,time). %% venting i 30 minutter


n_compl(in,education,use). %% opplæring i bruk
n_compl(in,employee,company). 
n_compl(in,employee,office).   

n_compl(in,error,thing).    %% program ? 

n_compl(in,file,directory).
n_compl(in,file,printqueue).
n_compl(in,file,system).

n_compl(in,hold,thing).    % Norwagism %% tak i

n_compl(in,horsepower,vehicle). 
n_compl(in,job,company).  
%% n_compl(in,king,country). %%  :-) 
n_compl(in,letter,text).    %%  :-)
n_compl(in,life,place). %% agent).

n_compl(in,management,plan). %% disponering i dagplanene 
n_compl(in,meaning,thing). %% life
n_compl(in,meeting,language). %% lecture in logic

n_compl(in,modification,thing).
n_compl(in,money,use).  


n_compl(in,notification,time). 

% n_compl(in,object,place). 
%% ambiguity prone in Norwegian:  stopper bussen i sentrum.

n_compl(in,office,place). 

n_compl(in,oracle,place).            %%  :-)

n_compl(in,person,company).
n_compl(in,person,city). 
n_compl(in,person,class).
n_compl(in,person,department).       %  employee
%% n_compl(in,person,life).   %%   "i live" Norwag
n_compl(in,person,machine).
n_compl(in,person,mood).
n_compl(in,person,place).  
n_compl(in,person,uniform). 
n_compl(in,person,wheelchair). 
%% n_compl(in,phrase,description). 



n_compl(in,place,place). %%  which places in town ... ?

n_compl(in,pram,vehicle). %% object too general 
n_compl(in,president,country).


n_compl(in,place ,city).          %%  byer i Trondheim #

n_compl(in,pram,vehicle).
n_compl(in,wheelchair,vehicle).


n_compl(in,price,city).
n_compl(in,price,time). 
n_compl(in,price,zone). 

n_compl(in,problem,thing). 

n_compl(in,route,neighbourhood). %% NOT station 

n_compl(in,route_plan,city). 
n_compl(in,route_plan,database). 
n_compl(in,route_plan,neighbourhood). 
n_compl(in,route_plan,system). 

%% n_compl(in,route_plan,time). %% from adverbial  om morgenen = in ... 
%% går det søndagsrute i dag   


n_compl(in,salary,month).       
n_compl(in,sale,month).         

n_compl(in,sale,place).   

n_compl(in,search,database). 
n_compl(in,search,place). 
n_compl(in,search,system).
n_compl(in,search,vehicle). 

n_compl(in,seat,vehicle). %% # place tv i bussen
n_compl(in,sentence,language).
n_compl(in,sentence,information). %% text ako inf..

n_compl(in,set,thing). 

n_compl(in,spot,object).

n_compl(in,strap,vehicle).

n_compl(in,thing,test).
n_compl(in,thing,variant). 

%% Problem Area
n_compl(in,station,place).    %%   (Hazardous ?) 
% NOT in station station
% n_compl(in,station,neighbourhood). %%   creates v_compl(be1,_,in,neighbourhood)
                                     %% creates  srel/in/neighbourhood
n_compl(in,station,route).  
n_compl(in,station,route_plan).  %% i rutehefte

n_compl(in,student,class).   

n_compl(in,telephone,place). 
n_compl(in,thing,database). 


%% n_compl(in,thing,street).    %% Norwagism  noe i veien. %% road %%
%% ## går det (busser i wessels gate) 

%%% n_compl(in,thing,city).    %% place  byer i Trondheim #
 
n_compl(in,thing,language). %% .. in english 

%% n_compl(in,station ,city).  
%% n_compl(in,neighbourhood ,city). %%  = be1/station/E, srel/in/neighbourhood/sentrum/E

n_compl(in,station,sequence). %% oppramsing 

n_compl(in,thing,country).
n_compl(in,thing,picture).  %%  ? 

n_compl(in,ticket,place). 
n_compl(in,ticket,class).    %%  ( 1. class) 
n_compl(in,time,vehicle).  
n_compl(in,time_count,time). %%  (en gang i timen)
n_compl(in,traffic,place). 
n_compl(in,tram_route_plan,place). 
n_compl(in,transfer,place).   %%  bytte i Mkgt. 

n_compl(in,monday,time).   
n_compl(in,tuesday,time).   %% i påsken
n_compl(in,wednesday,time). %% 
n_compl(in,thursday,time).  %% 
n_compl(in,friday,time).    %% 
n_compl(in,saturday,time).  %% 
n_compl(in,sunday,time).    %% 

n_compl(in,situation,place).  %% chaos in busstop 

%% n_compl(in,vehicle,time).    %%

n_compl(in,vehicle,management).  %% nattbuss i disponering   i dagplanene * fins .//
                                 %% e.g. extraposition nattbuss  fins i disponering  
n_compl(in,vehicle,question). 

n_compl(in,vehicle,christmas). %% christmas/easter . 
n_compl(in,vehicle,summer).   
n_compl(in,vehicle,winter).
n_compl(in,vehicle,connection). 
n_compl(in,vehicle,daypart). 
n_compl(in,vehicle,direction). 
n_compl(in,vehicle,easter).    %% \\\ +bussen i dag  
n_compl(in,vehicle,week). 
n_compl(in,vehicle,month). 
n_compl(in,vehicle,year).  


n_compl(in,vehicle,place). %% <-- Hazard ?
%% n_compl(in,vehicle,route).  %% er (toget i rute) ** 
n_compl(in,vehicle,route_plan). %% buss i ruteheftet

% n_compl(in,vehicle,route).  %% (Norwagism, On Schedule)// only adverbial 
% hazard ?

   
n_compl(in,thing,addition). % A in addition to B
n_compl(in,thing,start). 

n_compl(in,toilet,vehicle). 

n_compl(in,information,route_plan). %% footnote
n_compl(in,thing,relation).  %% noe i forhold til 

n_compl(in,possibility,way). %% Tech. valgmulighet i valg
n_compl(in,way,way). %% Tech. valgmulighet i valg

n_compl(in,weather,place). 
n_compl(in,weather,time). 
n_compl(in,word,language).  %% what is 'buss' in English
n_compl(in,word,sentence). 
n_compl(in,zone,place).  

n_compl(into,export,system). 

n_compl(like,thing,thing). %% dager lik søndag %% Techn 

n_compl(minus,thing,thing).

n_compl(near,   place,place).   
n_compl(nearer, place,place).  
%  n_compl(nearest,place,place).  % EXPERIMENT  bussen går til nth nærneste time 


%% n_compl(of   , possessive unnecesary  .. X  has_a Y

n_compl(of,agent,company).%% er du ansatt i team
n_compl(of,acquisition,thing).
n_compl(of,activity,thing). 


% n_compl(of,centre,neighbourhood).   %% nardo til trondheim *

%  off:  best av ting  (Norwagism)

% n_compl(of,address,company). %% adressE til TT  // (does not parse)

n_compl(of,amount,money). 
n_compl(of,author,system). 
n_compl(of,care,thing). %% (take) care of thing
n_compl(on,care,thing). %% (ta) vare på ting %% Norw

n_compl(of,centre,city). 
n_compl(of,copy,thing).      
n_compl(of,correction,thing). 
n_compl(of,description,thing). %% 
n_compl(of,definition,thing).  
n_compl(of,departure,vehicle). 
n_compl(of,departure,station).        %%  (doesn' work)
n_compl(of,description,thing). 
n_compl(of,feeling,thing).    %% sense of humour :-)
n_compl(of,forgery,thing). %%  :-(
n_compl(of,heap,object). 
n_compl(of,hold,thing).     %% get hold of 
n_compl(of,implementation,thing). 
n_compl(of,import,thing). 
n_compl(of,increase,thing).  %% TA-110503
n_compl(of,information,thing). 
n_compl(of,king,country). 
n_compl(of,lack,thing).  
n_compl(of,list,thing). 
n_compl(of,management,thing). 
n_compl(of,map,thing). 
n_compl(of,meaning,life).  
n_compl(of,number,thing).  %% antall ...
n_compl(of,optimalization,thing). 
n_compl(of,owner,thing).   
n_compl(of,part,thing).  
n_compl(of,picture,thing). 

n_compl(of,producer,thing). 

n_compl(of,regtop_export,information).  
n_compl(of,regtop_export,data).  
n_compl(of,regtop_export,database).
n_compl(of,rest,thing). 

n_compl(of,route,vehicle).  
n_compl(of,sale,thing). 

n_compl(of,sense,humour).  %% TA-110119
n_compl(of,set,thing). %% TA-100905

n_compl(of,set,thing).
n_compl(of,son,agent). 
n_compl(of,specification,thing). %% TA-101108
n_compl(of,start,thing). 
n_compl(of,stop,thing).  
n_compl(of,thing,set).  
n_compl(of,time,day).         %%  (Smalltalk)
n_compl(of,top,place). 
n_compl(of,type,thing). 
n_compl(of,understanding,thing).
n_compl(of,use,thing). 
n_compl(of,version,thing).



% off:  ubest av ting  (Norwagism)

n_compl(off,author,system).   %% Norw: forfatter av
n_compl(off,change,vehicle). 
n_compl(off,departure,station). 
n_compl(off,bus,route).        %% busser av  linje 36 
n_compl(off,enemy,agent). 
n_compl(off,friend,agent).     %%  venn av  Norw
n_compl(off,list,thing).               %%  (lista av...)(norwagism)
n_compl(off,neighbourhood,place).  %% nærheten av 
n_compl(off,part,thing). 
n_compl(off,pause,thing).     %% Norw  frysing av abonnementet (SIC)
n_compl(off,picture,thing).            %% bilde av noe
n_compl(off,side,place). 
%% n_compl(off,son,agent).  
n_compl(off,set,thing). %% Norw mengder av ting 
n_compl(off,test,thing).               %%  (test av ...) (norwagism)
n_compl(off,top,place).                %%  toppen av bakken
n_compl(off,transfer,vehicle).         %%  av (norwagism) better as off
n_compl(off,user,thing).  
n_compl(off,version,program).
n_compl(off,thing,version).  %% disse kjører fra instans (SIC) 
n_compl(off,version,route_plan). 

n_compl(offside,place,place). 


%% Generic possessive on  %% navnet til TT 

%% n_compl(on,Name,Company):- Company has_a Name. %% Too General ??
             
n_compl(on,activity,day).  %% TA-101109 har et møte på torsdag
                                     %%%%%%%%%%%%%%%%%
n_compl(on,agent,activity).  
n_compl(on,agent,department).   %% telebuster
n_compl(on,agent,telephone). 
n_compl(on,agent,speed).     %% på farta

n_compl(on,animal,vehicle). 
n_compl(on,answer,thing). %% Svar på alt
n_compl(on,arrival,place).           %% ( Norwagism ???)

n_compl(on,age,card).  
n_compl(on,agelimit,card).   %% Norw
n_compl(on,database,thing).  
n_compl(on,discount,trip).
n_compl(on,family,person).   %% Norwagism familie på 3
n_compl(on,format,thing).    %% design
n_compl(on,lack,thing).      %% Norw 
n_compl(on,load,system). 
n_compl(on,money,thing).     %% rough

%% n_compl(on,place,place).  %% Når er 43 til sentrum på korsen 
n_compl(on,name,thing). 
n_compl(on,number,vehicle).  %%
n_compl(on,number,sms).      %% ad hoc  ellipt. 17 (meldinger) på SMS
n_compl(on,payment,thing). 

%%%%%%%%%%%%%%% n_compl(on,vehicle,time).  %% buss på morgenen
%%  shamefully subtle,   ==> on/day   needs distinction

n_compl(on,bicycle,vehicle).


n_compl(on,border,ticket).
n_compl(on,boss,company).  %% TA-110114
 
n_compl(on,limit,ticket). 

n_compl(on,bus,afternoon). 

n_compl(on,bus,evening).  
n_compl(on,bus,night). 

n_compl(on,bus,bus).  %% buss(nummeret) på bussen.
n_compl(on,bus,route_plan).  

n_compl(on,card,place).  
n_compl(on,change,thing). 
n_compl(on,claim,thing).  %% TA-110707
n_compl(on,class,person). 

n_compl(on,clock,place).        %% i see (departure) times on nardo 
n_compl(on,clock,system).
n_compl(on,clock,agent).        %%  klokke på deg    
n_compl(on,colour,object). 
n_compl(on,correction,thing).  


n_compl(on,delay,vehicle).   
n_compl(on,departure,vehicle).       %%   Dubious (= for)
n_compl(on,departure,day). 
n_compl(on,departure,daypart). 
n_compl(on,departure,date).
n_compl(on,departure,daytime). 
n_compl(on,departure,place).         %% i see departures on nardo 
n_compl(on,departure,screen). 
n_compl(on,departure,summer).
n_compl(on,departure,time).   
n_compl(on,departure,winter). 

n_compl(on,difference,thing).  %% Norwagism
%% n_compl(on,direction,day).  %%   bussen til nth  -vei på mandag-?
n_compl(on,direction,route).   %% rute 81 SIC
n_compl(on,discount,ticket).   %% Norw 
n_compl(on,discount,vehicle).  
n_compl(on,driver,departure). 
n_compl(on,driver,vehicle). 

n_compl(on,employee,place).    %% i.e. company 
n_compl(on,endstation,route). 
n_compl(on,end,route_plan).    %% stop ???
n_compl(on,error,thing). 
n_compl(on,explanation,thing). %% TA-101108
n_compl(on,export,route_plan).

n_compl(on,frequency,departure).
n_compl(on,idea,thing).  

n_compl(on,information,sms).    %% special  %% greie/rede på  %% Norw ? 
n_compl(on,information,system). %% TA-110506

n_compl(on,house,place).         %%  (Norwagism)
n_compl(on,mood,job).      %% TA-110114 humor|humør på jobben
n_compl(on,job,place).  
n_compl(on,length,time).   %% lengde på periode=poss       %% hvor langte er det ... på mandag
n_compl(on,life,place). 
n_compl(on,luggage,vehicle). 
n_compl(on,lust,thing).          %% Norwagism Facetious
n_compl(on,map,webaddress).      %% nettsiden 
n_compl(on,meeting,place). 
n_compl(on,modification,thing). 
n_compl(on,movie,place). 
n_compl(on,name,thing). 
n_compl(on,number,object). 
n_compl(on,number,route_plan). 
n_compl(on,opinion,thing). 

n_compl(on,person,company).  
n_compl(on,person,place).      %% tore på nardo
n_compl(on,person,vehicle).    %% passasjer på rute 
n_compl(on,person,year).       %%  barn på 3 år %% Tore på Nardo

n_compl(on,picture,card).
n_compl(on,pity,agent). %% "synd på deg "   Norw

%% n_compl(on,place,vehicle).   %% plass/sete ** nardo på 17. 5 

n_compl(on,pram,vehicle). 
n_compl(on,wheelchair,vehicle). 
n_compl(on,pram,vehicle).
% n_compl(on,price,object).  %%  on price number qua bus :-(Hva kosteret nummer)

n_compl(on,price,sms).
n_compl(on,price,vehicle).  
n_compl(on,price,ticket). 
n_compl(on,price,trip).
n_compl(on,price,liquid).  


n_compl(on,program,homepage). 
n_compl(on,program,sms). 

n_compl(on,roof,place).        %% station/house 

n_compl(on,route,vehicle).  %%  nummer på bussen -> route on b  
n_compl(on,route,date).     %%   ( ruter på julaften)
n_compl(on,route,bus).      %%   (Norwagism)
n_compl(on,route,day).      %% (etc) 
n_compl(on,route,daypart). 

n_compl(on,route,system). %% metagoric 

n_compl(on,route_plan,date).     %%   ( ruter på julaften)
n_compl(on,route_plan,bus).      %%   (Norwagism)
n_compl(on,route_plan,day).      %% (etc) 

n_compl(on,route_plan,timetable). %% ad hoc

n_compl(on,salary,company). 

n_compl(on,sale,mailaddress). 
n_compl(on,sale,webaddress).  %% 

n_compl(on,search,thing). 
n_compl(on,seat,vehicle). 
n_compl(on,seat,vehicle). %% (if not confus)

n_compl(on,specification,thing).




n_compl(on,speed,vehicle). %% TA-100905
n_compl(on,speed,kmh).     %% hastighet på 50 kmt (Norw) 

n_compl(on,station,route).           % vis stasjoner på buss 5 %% EXPERIMENT
n_compl(on,station,vehicle). %% e.g. route 


% n_compl(on,station,place).   % ( neighbourhood) compatibility

n_compl(on,station,neighbourhood).  %% ligger nardosenteret på nardo%% NO 
                                    %% hva heter holdeplassen på nardo . # 

n_compl(on,station,station).  %% # holdeplassen på skjetlein (st)  %% ProfBrochsgt ON Torget  
    
n_compl(on,sundayroute,vehicle). 
n_compl(on,system,network).  
n_compl(on,system,sms).  


n_compl(on,situation,place). 
n_compl(on,special_ticket,vehicle). 

% n_compl(on,street, neighbourhood). 

n_compl(on,sentence,language).       %% (Norwagism)
n_compl(on,sequence,thing). 

n_compl(on,thing,language). %% på engelsk Norw 
n_compl(on,thing,picture). 
n_compl(on,thing,television).  

n_compl(on,ticket,vehicle). %% hva koster biletten på bussen Norw
n_compl(on,thing,language). %%
n_compl(on,thing,way).      %% på vei (til)       
n_compl(on,thing,street).   %% på vei disamb (til)

n_compl(on,time,bus).
n_compl(on,time,thing). %% frist på 45 minutter

n_compl(on,toilet,vehicle).
n_compl(on,transfer,place). %% TA-101115

   n_compl(on,vehicle,arrival).  
n_compl(on,vehicle,day).                %%   (vehicle ?) 
n_compl(on,vehicle,date).  

n_compl(on,vehicle,departure).    %% talemåte, busser på avgang
n_compl(on,vehicle,direction).    %%  (Norwagism  på veg = on direction)  
n_compl(on,vehicle,place).        %% TA-110807
n_compl(on,vehicle,route).        %% busser på rute 66 
n_compl(on,vehicle,summer).  %% ekstraavganger 
n_compl(on,vehicle,winter).  %%

%% n_compl(on,vehicle,place).   % route 66 on moholt +   buss forbi nth på gløshaugen * 
%%                           % når er neste buss på Torplassen som går til sentrum
%% når  er buss 36 på Buran  % unwerwunscht

n_compl(on,vehicle,service).  



% n_compl(on,thing,thing).           %  TOO GENERAL ti på fire ?
% n_compl(on,object,place).          %  Too general 
% n_compl(on,object,time).  
%% n_compl(on,television,vehicle). %% 
n_compl(on,time,vehicle).     %%  tiden på bussene %% OOPS klokka på to
n_compl(on,time,daytime). 
n_compl(on,time,day). 
n_compl(on,time,date). 

n_compl(on,traffic,system). 

n_compl(on,tramstation,tram).
n_compl(on,transfer,ticket). %% TA-100907
n_compl(on,transfer,vehicle).  

n_compl(on,trip,route). 

n_compl(on,weather,place). 
n_compl(on,weather,time). 
n_compl(on,webaddress,company). 
n_compl(on,webaddress,network).
n_compl(on,weight,thing). %% e,g, coevent att 
n_compl(on,wheel,vehicle).


n_compl(outside,company,place). 
n_compl(outside,place,place). 
n_compl(outside,route,time). 
n_compl(outside,thing,city). %% place ?

n_compl(over,departure,vehicle).
n_compl(over,information,thing).
n_compl(over,list,thing). 
n_compl(over,map,thing). 
n_compl(over,overview,thing).
n_compl(over,person,age).           %%  person over 18 years
n_compl(over,route,route). 
n_compl(over,route_plan,bus). %% information,thing   too general
n_compl(over,route_plan,departure). 

n_compl(past,bus,place). 
n_compl(past,need,thing). %% special %%
n_compl(past,street,place).
n_compl(past,route_plan,place).

%% n_compl(past,clock,place).       %% (passerings)tidspunkt forbi nth
                                    %% når går buss etter (1830 forbi nardo)

n_compl(past,departure,place). 
n_compl(past,time,place).  
n_compl(past,trip,place). 
n_compl(past,vehicle,place).   %% hvilke avganger har rute 5 forbi DV
n_compl(past,station,place). 

n_compl(per,thing,vehicle). 
n_compl(per,departure,time).  %% en avgang pr døgn 
n_compl(per,time_count,time). %% en gang per døgn  

n_compl(plus,number,number).   

        
%% n_compl(regarding,thing,vehicle). %% I know something about
                                     %% OOPS     søndagsruter om 4 dager 
%%% når går bussen om 10 minutter 

n_compl(regarding,claim,thing).  

n_compl(regarding,doubt,thing).  %%  incl tvil om bussen går 

n_compl(regarding,information,thing). %% regarding is moreunambiguous than about
n_compl(regarding,meaning,thing).
n_compl(regarding,meeting,thing).  
n_compl(regarding,plan,thing). 
n_compl(regarding,request,thing).   %% ønske om
n_compl(regarding,suspicion,thing).
n_compl(regarding,text,thing).   
n_compl(regarding,truth,thing).
n_compl(regarding,way,thing).   

n_compl(through,route,place).  
n_compl(through,bus,place).         %%  NB bus
n_compl(times,number,number). 



%% Generic possessive to  %% navnet til TT

%%% n_compl(to,Name,Company):- Company has_a Name. %% Too Geeneral ??
%%%                      // buss til tagore        %% EXPERIMENT
n_compl(to,number,place). %% nr nr til flatåsen etter kl19 

n_compl(to,access,thing).  %% TA-110429
n_compl(to,activity,thing). 
n_compl(to,addition,thing).   

n_compl(to,address,station). %% nec?
n_compl(to,address,company). %% adressE til TT 
n_compl(to,airplane,place). 

n_compl(to,answer,agent).   
n_compl(to,answer,question).  %% diff senses of to
n_compl(to,answer,test).  

n_compl(to,arrival,place). 
n_compl(to,author,system).   %% Norw: forfatter til

% n_compl(to,bus,time).      %% når går bussen (fra sju) til elleve 

n_compl(to,capital,country). %% Norw hovedstaden til Pakistan %% TA-110225
n_compl(to,card,card).       %% i.e. månedsmerke til kort

n_compl(to,cause,thing). %% coevent). 
n_compl(to,claim,thing).  

n_compl(to,clock,place).     %% clock = departuretime
n_compl(to,clock,route).   
n_compl(to,colour,thing).  
n_compl(to,connection,place). 
n_compl(to,consideration,thing). %% Norw ta hensyn til 

n_compl(to,department,department). %% avd. til HIST tele 

n_compl(to,departure,place).  
n_compl(to,departure,time). 
n_compl(to,departure,bus).           %%  EXPERIMENTAL  = of ?? 
n_compl(to,departure,route_plan). 
n_compl(to,departure,route).  

n_compl(to,email,thing). %% TA-110622
%% n_compl(to,direction,place). 
n_compl(to,thing,direction). %% jenta til venstre 

n_compl(to,speed,thing). %% possessive ! 

n_compl(to,thing,feeling). %% til glede 

n_compl(to,distance,place).  

% n_compl(to,duration,place).     %% Bussen kommer om (en time til nth)*
%                                 %% (reisetid) * om en time til nardo
n_compl(to,frequency,thing). 
n_compl(to,idea,thing). 
n_compl(to,inspiration,thing). 
n_compl(to,information,place).  %% ruteopplysning fra Trondheim til Orkanger? 

%% n_compl(to,interface,system).    

n_compl(to,length,place).  

n_compl(to,map,place). 
n_compl(to,message,agent). 
n_compl(to,midnight,date).  
n_compl(to,midnight,day).    %% night to sunday (Norwagism)

n_compl(to,name,company). 
n_compl(to,name,station). %% Hazard

n_compl(to,need,thing). 

n_compl(to,permission,coevent). %% lov å røyke %% (infin)
n_compl(to,period,time).     %% \+ (i perioden) (fra ...)   ? 
n_compl(to,place,person).  %% e.g. seat

%% n_compl(to,place,pram).    %% plass til barnevogn     

%% n_compl(to,place,thing). %% plass til ting Norw %% TA-101130 

n_compl(to,responsetime,system). %% TA-110112
n_compl(to,room,thing).  %% Eng
n_compl(to,seat,thing).  %% ?


n_compl(to,station,place).      %% Hazard ?? 
n_compl(to,street,place).     %%  road to hell from street to   

n_compl(to,transfer,place). 
n_compl(to,transfer,vehicle).

n_compl(to,money,thing).     %% overgenerate? 

%% Syndrome:   natt til søndag = søndag morgen ( 0000 - ),
%% men rutetidene om kvelden oppgis som 0000, selv om det er over midnatt
%% og det formelt er neste dag.
%% Kan løses ved å gjeninnføre   2415 + forandre datoen


% n_compl(to,night,day).      %% (Not English)  Night to saturday 

n_compl(to,number,vehicle).  
n_compl(to,passenger,place). 
%% n_compl(to,place,person).   %% adressen til tagore ?   
n_compl(to,plane,airport).     %% place
n_compl(to,plane,city).
n_compl(to,plane,country).

n_compl(to,price,place).    % prisen til Molde

n_compl(to,permission,thing). 
n_compl(to,possibility,thing). 

n_compl(to,proposal,thing).

n_compl(to,right,thing). %% rett til skyss
n_compl(to,question,agent).  
n_compl(to,reference,thing). %% henvisning
n_compl(to,relation,thing).

% n_compl(to,roof,vehicle).  %% AD HOC  taket til bussen :-)

n_compl(to,route,place).   %% ruter til Ålesund %%  way = route = bus  ? 

n_compl(to,route,vehicle).  % allow bussrute til buss 9 %% TA-110105
                            % possessive %% TA-110105
                            % bytte fra buss 5 til buss 8

n_compl(to,route_plan,place). 
n_compl(to,route_plan,vehicle).   % allow bussrute til buss 9

n_compl(to,seat,person).       %% (Norwagism) plass til 
n_compl(to,seat,pram).       %% not elephant :))))
n_compl(to,seat,place).       %% ledig plass til Tromsø 

n_compl(to,service,agent).    %%  ??? agent has_a service

n_compl(to,station,street).   %% holdeplassen til Y9c %% hazard ?
n_compl(to,station,vehicle).  
n_compl(to,system,purpose). 

n_compl(to,telephone,company). %% egentlig telefonen til = of
n_compl(to,thing,price).       %% ticket to price 
n_compl(to,ticket,company). 
n_compl(to,ticket,place). 

%%% n_compl(to,ticket,vehicle). 

n_compl(to,time,meeting).        %%  Norw ( for)
%%  n_compl(to,time,place).      %% bussen går om (5 minutter til nth) *

%% n_compl(to,time,vehicle).        %% gi meg tidene til buss 5 
%%  det er åtte timer til bussen går

% n_compl(to,time,time).    %% tid (fram) til midnatt ???? EXPERIMENT
%%    (buss fra  sju om) morgenen til elleve
    
n_compl(to,time,route_plan).  %% TA-110810 


% n_compl(to,time,vehicle).   %% Norwagism  (passerings)tid til buss
%    buss til 11 (route)      %% 

n_compl(to,transfer,vehicle).     %% cannot take it 
n_compl(to,transfer,otherbus). %% other bus company 
n_compl(to,transfer,company).
n_compl(to,transfer,place).   

n_compl(to,train,place). 
%  n_compl(to,tram,place).  %% The relation is more general

n_compl(to,trip,place).    
n_compl(to,traveltime,place).
n_compl(to,trip,place). 

%% n_compl(to,vehicle,activity). %% buss til jobben // nor til feil

n_compl(to,vehicle,date).%%  buss til 1 . august  %% TA-110527

n_compl(to,vehicle,airplane). 
n_compl(to,vehicle,job).
n_compl(to,vehicle,place). 
%% n_compl(to,vehicle,agent). %% send en rute til meg

n_compl(to,way,thing).    %% på veg til møte 
n_compl(to,street,thing). %% disamb på veg til møte 
%% n_compl(to,way,place). 
%% n_compl(to,way,vehicle). 

n_compl(to,weather,time). %%  Norw snø til vinteren y

n_compl(to,webaddress,thing). %%  metagoric
%% n_compl(to,webaddress,agent).  %% busstuc  
%% n_compl(to,webaddress,bus).    %% e.g.airbus ( capture link(en) til flybussen)
n_compl(to,wife,agent). %% possessive %% TA-110116


n_compl(towards,bus,place).        %% both?
n_compl(towards,departure,place).  %% both?
n_compl(towards,direction,place). 
n_compl(towards,interface,system). 
n_compl(towards,midnight,date).  
n_compl(towards,midnight,day).    %% night to sunday (Norwagism)
n_compl(towards,route,place). 
n_compl(towards,route_plan,place). %% 
n_compl(towards,station,place). %% holdeplasser mot Gløs (på buss 5)

n_compl(under,person,year).   %% NB under 8 ÅR
n_compl(until,vehicle,time).

n_compl(via,vehicle,sms).
n_compl(via,price,place). 
n_compl(via,way,place). 

n_compl(when,information,coevent). %% NB %% oppl. om når bussen går

n_compl(where,doubt,coevent). %% ad hoc 

n_compl(with,address,station).
n_compl(with,agent,answer). 
n_compl(with,agent,right).       %% rettighet 
n_compl(with,application,identification).  %% TA-110707 applikasjon med AtB-logo
n_compl(with,area,installation). %%  Rondane

n_compl(with,company,payment). %% omsetning 
n_compl(with,connection,thing).

n_compl(with,error,thing). 
n_compl(with,export,thing). 

n_compl(with,frequency,vehicle).  
n_compl(with,help,thing). 

n_compl(with,mail,sentence).    %% TA-110724
n_compl(with,meeting,agent). 

n_compl(with,computer,address). 
n_compl(with,set,thing).        %% sett med ting  Norw 
n_compl(with,system,screen).    %% TA-110527
n_compl(with,thing,idea).       %%  med tanke på ....
n_compl(with,word,thing).       %% ad hoc 

n_compl(with,time,gap).
n_compl(with,time,interval). 
n_compl(with,time,need).  


%% Some of these n_compl(with,... may be  redundant

n_compl(with,accident,thing). 
n_compl(with,agent,firstname). 

n_compl(with,arrival,vehicle).  

n_compl(with,day,departure).  

n_compl(with,day,saturdayroute).  
n_compl(with,day,sundayroute).   

n_compl(with,departure,duration). %% overgangstid 
n_compl(with,departure,vehicle).
n_compl(with,departure,daycode). 

n_compl(with,dog,handicapped).

n_compl(with,bus,route). 
n_compl(with,card,bus). 
n_compl(with,card,transfer).   

n_compl(with,company,money).   %% selskap med omsetning
n_compl(with,comparison,thing). 
n_compl(with,connection,place).     %% forbindelse med tiller 
n_compl(with,connection,company).   %% TT
n_compl(with,connection,vehicle).   %% otherbus
n_compl(with,connection,coevent).   %% med at bussen går

n_compl(with,contact,agent). 
n_compl(with,contact,company). 

n_compl(with,departure,vehicle).  
n_compl(with,departure,arrival).  
n_compl(with,departure,transfer). 
n_compl(with,duration,vehicle).  
n_compl(with,experience,thing).   
   n_compl(with,instruction,thing).
n_compl(with,format,thing). %% i.e. regtop 
n_compl(with,idea,thing).
n_compl(outside,passenger,price).   %% SIC passasjer utenom voksentakt
n_compl(outside,activity,place).    %% tur utenfor sone 

n_compl(except,passenger,price). 

n_compl(with,identification,thing).

n_compl(in,job,thing). %% i samarbeide med lingit 
n_compl(with,indulgence,agent).  
n_compl(with,list,thing). 
n_compl(with,map,station).  
n_compl(with,meaning,thing).  
n_compl(with,meeting,agent). %% person/company 

n_compl(with,passenger,price).   %% personer med voksentakt


n_compl(with,period,thing).  
n_compl(with,permission,thing).  
n_compl(with,place,distance). %% med avstand til ...
n_compl(with,problem,thing). 

% n_compl(with,thing,agent).    %% tar (øl med meg) %% noe i veien med deg
n_compl(with,ticket,discount).  

n_compl(with,trip,agent).   
n_compl(with,trip,vehicle). 


n_compl(with,round,test).     %% runder med kontroll Norw 
n_compl(with,trip,test).  

%  n_compl(with,information,thing).  %%  -> winterroute with nightbus
n_compl(with,webaddress,thing). 

% n_compl(with,meaning,life).         %% :-)
% n_compl(with,meaning,universe).     %% :-)

n_compl(with,permission,thing).  
n_compl(with,person,money).         %%  thing =>  (?) en person med jernbanen*

n_compl(with,price,bus). 
n_compl(with,problem,thing).

n_compl(with,regtop,thing). %% i.e. information
n_compl(with,route,vehicle). 
n_compl(with,route,clock).          %%  (Bussrute med klokkeslett)
n_compl(with,route_plan,departure). 
n_compl(with,route_plan,map). 
n_compl(with,route_plan,time).  


n_compl(with,route_plan,vehicle).    %%  (lørdags)rute med buss 5

n_compl(with,sentence,thing).  
n_compl(with,station,vehicle).   %% Experiment % stasjon etter M0 med buss 4
n_compl(with,street,vehicle).    %% kortest vei med buss (ad hoc) 

n_compl(with,talk,agent).  
n_compl(with,ticket,transfer). 
n_compl(with,ticket,vehicle). 

n_compl(with,transfer,card). 

n_compl(with,vehicle,arrival).  
n_compl(with,vehicle,departure).  

n_compl(with,vehicle,delay).   
n_compl(with,vehicle,duration). 

n_compl(with,vehicle,number). 
n_compl(with,vehicle,route).  %% buss med nummer 99

n_compl(with,vehicle,person). %% passenger
n_compl(with,vehicle,price).  
n_compl(with,vehicle,station). 
n_compl(with,vehicle,transfer). 
% n_compl(with,vehicle,vehicle).      %% ???


n_compl(within,thing,neighbourhood). %% area 
n_compl(within,price,zone).   
n_compl(within,system,thing).   
n_compl(within,ticket,place).  
n_compl(within,vehicle,clock).        %% Different relations!
n_compl(within,vehicle,hour).         %% Different relations!
n_compl(within,vehicle,minute).       %% Different relations!
% n_compl(within,vehicle,time).       %% same as before

n_compl(without,agent,knowledge).  
n_compl(without,agent,system).        %% PC 
n_compl(without,passenger,price).     %% personer med voksentakst

n_compl(without,area,street).         %% road  %% TA-100907 Rondane
n_compl(without,area,vehicle).        %% TA-100907 Rondane
n_compl(without,area,traffic).        %% join_class(street,vehicle) %% TA-100908

n_compl(without,bus,transfer). 
n_compl(without,way,vehicle). 
    n_compl(without,vehicle,vehicle).  %% by synonym
n_compl(without,thing,responsibility).
n_compl(without,thing,answer). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% ADVERB SECTION %%%%%%%%%%%%%%%%%%%%%%


% Adjectival Adverbs  adv_templ -> gradv_templ  

% gradv_templ(closely,related).

gradv_templ(easily,adaptable).
gradv_templ(equally,good). %% like godt 
gradv_templ(just,after).  
gradv_templ(more,great).
gradv_templ(too,early).
gradv_templ(too,late). 
gradv_templ(very,_).


% Adverbial Particles   

%% particle(nil,night,pre). %% (i morgen) kveld  ???

%% particle(redundantly,mode,_).  %%  Dummy Adverb unnec, inherit %% TA-110504
particle(redundantly,thing,_).    %%

%% particle(Adverb,Class,Pos)

%% Pos = pre  Cen be prefix
%% Pos = post Can be postfix

particle(above,place,pre).    % in a text
%% particle(afternoon,day,pre). 
particle(afterwards,time,pre).
particle(at_home,place,pre).

particle(available,mode,post). %% semi adjective

particle(below,place,pre).
particle(correctly,mode,post).
particle(currently,time,pre).
particle(daily,day,pre). 
particle(earlier,time,pre). 
particle(evening,day,pre). 
particle(everywhere,place,pre). 
particle(finished,mode,post). %% e.g. ready (ferdig..amb)  semi adjective
particle(here,place,pre).    
particle(hereafter,time,pre). 
particle(immediately,time,pre). 
particle(indirectly,mode,pre). 

particle(inwards,place,post). %% to sentrum
particle(outwards,place,post).%% from sentrum

particle(later,time,pre). 
particle(last,time,pre). %% sist (\+ siste) !
particle(latest,time,post).       %%  = last (as particle)
particle(manually,mode,post).  
%% particle(normally,mode,pre).   %%  I walk normally

particle(night,daypart,pre).      %%  (I morgen) kveld

particle(normally,time,pre).      %%  I walk, normally Preferred in BusTUC
particle(now,time,pre).   
particle(once,time,pre).
particle(often,time,pre). 
particle(often,time,post).
particle(ready,mode,post). 
particle(recently,time,pre).  

particle(slowly,time,pre). 
particle(somewhere,place,pre). 
particle(still,time,pre).
particle(thereafter,time,pre).

    particle(beforethat,time,pre).

particle(there,place,pre). 
particle(thereafter,time,pre). 
particle(this_afternoon,time,pre).
particle(this_evening,time,pre). 
particle(today,day,pre).
particle(together,mode,pre).
particle(tomorrow,day,pre).    %% after,today 
particle(yesterday,day,pre).   %% before,today 
particle(day_after_tomorrow,day,pre). 
particle(day_before_yesterday,day,pre).

%% time of day

% day determinate

particle(this_morning,time,pre). 
% this daytime missing ?
particle(tonight,daypart,pre).      %% TA-100909
particle(this_midnight,time,pre).   %%   (mid_night = > 2400)

% day indeterminate

particle(in_day,time,pre). 
particle(in_afternoon,time,pre).
particle(in_evening,time,pre). 
particle(in_morning,time,pre). 
particle(in_night,time,pre).
particle(in_midnight,time,pre).

%       particle(Day,day,pre) :- (Day isa day).            %% RS-140921
%particle(Day,day,pre) :- isa( Day, day ).

%% can not be prefix

% particle(after,time,post). %% bus goes after * 

%  particle(about,place,post). %% bus goes  about 1700 Prepositional
particle(abroad,place,post).
particle(across,place,post). 
particle(ahead,place,post).  
particle(along,place,post). 
particle(aloud,mode,post). 
particle(always,time,post). 
particle(anymore,time,post).  
particle(apart,mode,post).  
particle(around,place,post).
particle(aside,place,post).  
particle(astray,place,post). 
%% particle(at,time,post).  ??? 
particle(automatically,mode,post). 
particle(away,place,post).  

particle(back,place,post).
particle(badly,mode,post). 
%% particle(before,time,post). % does a bus that arrives before 900 go ? %% EXPERIMENT
particle(behind,time,post).

particle(below,place,post).  %% ? spørsmålet nedenfor

% particle(best,mode,post).  %% == well 
% particle(by,place,post).   %%  preposition is preferred

particle(cheaply,mode,post). 
particle(correctly,mode,post). 

particle(delayed,time,post). %%  (duration?)
particle(differently,mode,post). %% TA-110808
particle(directly,mode,post).   
particle(down,place,post).
particle(downtown,mode,post).   %%   go downtown \= go in place
particle(early,time,post).
particle(ever,time,post). 

particle(far,place,post).  
particle(fast,time,post). 
particle(fast,mode,post).       %% !
particle(faster,mode,post). 
particle(fastest,mode,post). 
particle(first,time,post). 
particle(forth,place,post).
particle(forward,place,post).
particle(freely,mode,post).
%% particle(from,mode,post).  %%  Si ifra   %% Norwagism %% Hazardous 

particle(gratis,mode,post).  %% kjøre gratis, also E 

particle(home,direction,post).  
particle(honestly,abstract,post). 
 
particle(in,place,post).   %% Hazardous ?? what is prolog in ???
particle(inside,place,post). 

particle(eastward,direction,post).  
particle(northward,direction,post). 
particle(southward,direction,post). 
particle(westward,direction,post).  

particle(late,time,post).
particle(last,time,post).       %%  går sist
particle(little,mode,post). %% hjelper lite 
particle(locally,place,post). 
particle(logically,mode,post).
particle(longer,time,post).     %%  waited longer
particle(more,mode,post).       %%  Rough  (I know more =know better)
particle(much,mode,post).       %%  cost much 
particle(off,vehicle,post).     %%  NOT place 
particle(offside,direction,post). %% southward/southbound etc 

particle(on,vehicle,post).      %%  NOT place 

particle(openly,mode,post).     %% adjective  holde åpent 

particle(out,mode,post).        %% se ut (Norwagism) 
particle(out,place,post). 

particle(outside,place,post). 

% particle(past,place,post).        %%   gå forbi.  (reductant)  
particle(punctually,time,post).   %%  
particle(regularly,time,post).   %% according to schedule 
particle(round,place,post).
particle(secretly,mode,post). 
particle(silent,mode,post). %% stå stille/ gå stille 
particle(simultaneously,time,post). 
%% particle(soon,mode,post). %% ??? not pre ???// herafter
particle(there,place,post). 
particle(through,place,post).
particle(thus,mode,post). %% slik ut | ut slik
particle(together,mode,post).
particle(under,place,post).
particle(up,place,post).
particle(up,mode,post).        %% show up 
particle(well,mode,post). 
particle(wrongly,mode,post).

% particle(with1,mode,post).   %% Norwagism,EXPERIMENT (hva kan jeg ta med)
                               %% Failed,  jeg går med bussen

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



v_compl(V,thing,nil,daypart) :- normalverb(V,_). 

v_compl(V,thing,nil,day):-      normalverb(V,_).
v_compl(V,thing,nil,day):-      normalverb(V,_). 
v_compl(V,thing,nil,week):-     normalverb(V,_).
%%% v_compl(V,thing,nil,month):-    normalverb(V,_). %% Går buss 2 januar 
v_compl(V,thing,nil,year):-     normalverb(V,_). %%

%% NB   v_compl(be1,plonk,on,date). ## 



%% Verb-compliances not connected

v_compl(break,person,with,object).
v_compl(call,person,as,thing).    

v_compl(consist,thing,of,thing).  
v_compl(cut,system,from,place).

v_compl(direct,person,to,person).

v_compl(fly,thing,like,thing).         % like = prep

v_compl(include,person,in,system).

% v_compl(lose,company,on,company).
v_compl(marry,person,to,person). 
v_compl(shop,person,for,object).   
v_compl(split,person,into,text).
v_compl(split,person,until,time).
v_compl(store,system,as,statement).
v_compl(time,thing,like,thing).  


/***********'  SUSPENDED  -> FERNANDO
%%  Called from fernando

v_compl(A,B,X,Y):-   %% general complements allowed for 
   nonvar(X),
   normalverb(A,B), %% this class of verbs
   stanprep(X,Y).

**/


%%%%% Standard Prepositions

%%%%%%%%%  Preposition templates common to all normal verbs %%%%%%%%%%%%%%%%%

stanprep(nil,clock).
stanprep(nil,coevent).  
stanprep(nil,duration).  %% hvor lenge (venter) %% TA-100905
stanprep(nil,date).      %%  ?
stanprep(nil,day).  
stanprep(nil,mode). 
stanprep(nil,place).     %% hvor (går bussen) ...til  

stanprep(id,coevent).      %% alt.
stanprep(not,coevent).     %% and not doing %% pro forma

stanprep(without,coevent). %% without (doing) statement 
stanprep(without,problem). 



stanprep(nil,mode).    %% kjøre gratis
%% stanprep(nil,duration). %% \+ go friday morning
stanprep(nil,time_count). 

stanprep(about,time).    %% English 
stanprep(according_to,thing).
stanprep(afore,place).   %% Foran = in front of %% Technical
stanprep(afore,object).  %% vehicle etc 
stanprep(afore,person).  %% qua body

stanprep(after,activity). 
stanprep(after,coevent).
stanprep(after,proposal). %% Norw  according_to 
stanprep(after,rule).    %% etter=according to Norw 
stanprep(after,time).
stanprep(after1,time).   %% (strict)
stanprep(ago,time).      %% Technical   10 minutes ago
stanprep(around,time). 

%% stanprep(as,thing).      %% dit tlf %% TA-101108

stanprep(as_in,thing). %% Techn bus goes as in example

stanprep(at,activity).   %% ved fremvisning 
stanprep(at,coevent).    %% 
stanprep(at,error).      %% mistake Norw  ved feil
stanprep(at,place). 
stanprep(at,question).   %% ved forespørsel %% Norw 
stanprep(at,time).


stanprep(before,activity). 
stanprep(before,coevent).  
stanprep(before,time).
stanprep(before1,time).  %%  (strict)
stanprep(behind,place). 
stanprep(because_of,thing). 
stanprep(between,time). 
stanprep(beyond,place). 

stanprep(by,activity). %% buy presentation 
stanprep(by,coevent). %% by taking a bus
stanprep(by,error). %% mistake
stanprep(by,time). 

stanprep(despite_of,reason). 
stanprep(during,activity). 
stanprep(during,coevent).

    stanprep(below,activity). %% Norwagism under = during // ad hoc, 

stanprep(during,time). 
stanprep(during2,time). %% om våren

stanprep(for,fun). %% for moro skyld %% TA-110427

stanprep(from,time).
%% stanprep(to,time). %%  until  go to second (closest station) 

stanprep(not_withstanding,coevent). %% subjunction 
stanprep(unless,coevent).  


%% stanprep(not_withstanding,time).    



stanprep(to,noon). %% :-) til middag 

stanprep(in,addition).  
stanprep(in,case).   
stanprep(in,connection). 
stanprep(in,direction).   %% to go home 
stanprep(in,mode). 
stanprep(in,place).
stanprep(in,route_plan). %% TA-110808 metagoric
stanprep(in,start). 
stanprep(in,time).
stanprep(in,timetable).   %%  Metagoric
stanprep(in,time_count).  %% Norwagism
stanprep(in,version).     %% metagoric
stanprep(in,way). 
stanprep(in_order_to,thing). 
stanprep(inside,place).   %%   (== within?)
stanprep(instead_of,thing). %% incl coevent 
stanprep(into,place). 

stanprep(near,place).  
stanprep(notwithstanding,thing). 
stanprep(not_withstanding,thing). 

stanprep(of,cause).
stanprep(of,reason).

%% stanprep(on,time). %% ? Haz
stanprep(on,date). 
stanprep(on,day).  
stanprep(on,evening).  %%  on monday evening
stanprep(on,morning).  %%     ...    morning
stanprep(on,place).      
stanprep(on,way).      %% Norwagism ( på en måte)
stanprep(outside,place).
stanprep(over,place). 
%% stanprep(over,thing). %%   bus runs over me # 
stanprep(per,time).   

%% stanprep(rather_than,thing). %% ..Norw framfor= instead:of
stanprep(regarding,thing). %% angående 

stanprep(since,thing). %% date/coevent 
stanprep(so_that,thing). 
stanprep(than,thing). %% hack, haster mer enn dette 
stanprep(towards,place). 
stanprep(under,condition). 
stanprep(under,time_count). %% under gang %%Norw ad hoc
stanprep(under,trip).       %%
stanprep(until,time).
stanprep(upon,time).   %%   :-)

stanprep(with,duration).  %% How long // Hvor lang er en buss 
stanprep(with,frequency).
stanprep(with,method). 
stanprep(with,necessity).
stanprep(with,plan).        %% planlegging
stanprep(with,possibility). %% 

stanprep(within,time).

stanprep(without,thing). %% coevent). %% uten å måtte ... %% TA-110304

% % % % % % % % % % % % % % % % % % % % % % % %

%%%%%%%%%%%% Numbers 


ordinal1(X):-ordinal(X,_).

%% Occurs also in  %% dict_e.pl on a lexical level

ordinal(first,1).
ordinal(second,2). 
ordinal(third,3).  
ordinal(fourth,4). 
ordinal(fifth,5).  
ordinal(sixth,6).  
ordinal(seventh,7). 
ordinal(eighth,8). 
ordinal(ninth,9).   
ordinal(tenth,10).  
ordinal(eleventh,11).
ordinal(twelvth,12).  % twelveth synword 
ordinal(thirteenth,13). 
ordinal(fourteenth,14). 
ordinal(fifteenth,15).  
ordinal(sixteenth,16).  
ordinal(seventeenth,17). 
ordinal(eighteenth,18).  
ordinal(nineteenth,19).  
ordinal(twentieth,20). 
ordinal(twentyfirst,21). 
ordinal(twentysecond,22). 
ordinal(twentythird,23). 
ordinal(twentyfourth,24). 
ordinal(twentyfifth,25). 
ordinal(twentysixth,26). 
ordinal(twentyseventh,27). 
ordinal(twentyeighth,28). 
ordinal(twentyninth,29). 
ordinal(thirtieth,30). 
ordinal(thirtyfirst,31). 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%% 10469 %%%%%%%%%%%%%%%%%%%%%%%
