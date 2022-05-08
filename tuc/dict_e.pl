/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE dict_e.pl
%% SYSTEM TUC
%% CREATED TA-930601    %% REVISED TA-110825
%% REVISED RS-140921    re-modularized

%% TUC Dictionary for the language E
:-module( dict_e, [ lexnsingirr/2, lexnpluirr/2, noun/1, preposition/1, pronoun/2, unwanted_verb/1, verb_form/4, test_dict_e/0 ] ). %% RS-131227    For morph_e.pl
        % allroundmember/2, compword/3, cw/1, noisew/1, noun2/2, noun_form/5, ow/1, %% RS-131227. For autocompiled dcg_n / dcg_e
        % pronoun/1, rep_verb/1, rewording/2, splitword/2, synsms/2, synwordx/2, unwanted_adjective/1, unwanted_noun/1, unwanted_interpretation/2, verbroot2/2, xcompword/3,

%% RS-131225    UNIT: /
%:- ensure_loaded( '../declare' ).
:- use_module( '../declare', [ value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .

:- use_module( '../main.pl', [ backslash/1 ] ).

%% MISERY! %% RS-131229
%:- ensure_loaded( user:'../tucbuses' ).  %% RS-130329 Make sure (gram/lang) modules are available: dcg_module,
%:- use_module( '../tucbuses.pl', [ ] ). %%, backslash/1 ] ).

%% RS-131225    UNIT: tuc/
:- use_module( evaluate, [ instant/2 ] ).       %% RS-131225
:- use_module( morph_e,[ verbroot/1 ] ).        %% RS-131225 Why is this not used? See verbroot2 instead!
:- use_module( semantic, [ adj_templ/2, ako/2, gradv_templ/2, particle/3, rv_templ/2 ] ). %  TUCs  Lexical Semantic Knowledge Base

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ow(X). % Open Word Class     => specific
% cw(X). % Closed Word Class   => misc 

test_dict_e :-
                   compword(_,_,_),
                   cw(_),
                   noisew(_),
                   noun2(_,_),
                   noun_form(_,_,_,_,_),
                   ow(_),
                   preposition(_),
                   pronoun(_),
                   rep_verb(_),
                   rewording(_,_),
%%                   split(_,_),        %% Only Norsk ?? RS-121218
                   splitword(_,_),
                   synsms(_,_),
                   synwordx(_,_),
                   unwanted_adjective(_),
                   unwanted_noun(_),
                   unwanted_verb(_),
                   unwanted_interpretation(_,_),  %% Only English?? RS-121118
                   verb_form(_,_,_,_),
                   verbroot2(_,_),
                   xcompword(_,_,_).


rewording([can,t],[can,not]).      %% TA-110316
rewording([cant],[can,not]).       %%
rewording([cannot],[can,not]).     %%

rewording([i,want,go], [i,want,to,go]). 
rewording([pong,ping], [ping,pong]).          %% TA-101006
rewording([when,take], [when,do,i,take]).     %% TA-110615


%% split word ahead of analysis. Not implemented ! %%

% Numeric

splitword('+',[plus]). %% TA-100902

splitword('10am',[10,am]).   %% etc.

splitword('30am',[30,am]).   %  minutes

splitword('10pm',[10,pm]). 

splitword('30pm',[30,pm]). %% (minutes)


% Symbolic


splitword(didnt,[did,not]). 
splitword(ily,[i,love,you]). 
splitword(im,[i,am]). 
splitword(lastbus,[last,bus]). 
splitword(lets,[let,us]). 
splitword(goto,[go,to]).  
splitword(thats,[that,is]). 
splitword(whatis,[what,is]). 
splitword(whois,[who,is]). 

compword(':',[')'],[]). %% Smileys
%% compword(':',[],[]).    %%   6:00 

%% Exclusive Composite words 


compword(all,[the],the). 


%% Composite words

compword('.',[am],am).  
compword('.',['00am'],am). %%   9.00am

%% Class independent composite words

compword(after,[now],hereafter). 
compword(ain,[t],is). %% Rough query logic 
compword(air,[bus],airbus).  
compword(air,[port],airport). 

compword(are,[planned],exist).  %% Which routes are planned for Christmas?

compword(are,[you,able,to],[]).  %% tell!

compword(as, [fast,as,possible],soon).
compword(as, [soon,as,possible],soon). %% not hereafter// ... after 16.50 ...
compword(ascension,[day],ascension_day).

compword(bath,[room],toilet). %% Telebuster

compword(bus,[connection],bus). %% i.e. connection --> bus 

compword(bus,[stop],station).        %% but not buses stop !!!
compword(bus,[stops],stations). 

compword(d,[like],want).             %% I'd like
 
compword(didn,[t],does).    %% Rhetoric Query logic 
compword(don,[t],does).     %%
compword(down,[town],downtown).  


compword(christmas,[day],christmas_day).
compword(christmas,[eve],christmas_eve).


compword(credit,[card],card).   %% Rough 
compword(credit,[cards],cards). %% 

compword(easter,[day],easter_day). 
compword(easter,[eve],easter_eve).   
compword(easter,[eave],easter_eve).  %% no synword 


compword(excuse,[me],hi).  

compword(fly,[bus],airbus).          %% Norw 
compword(from,[from],from).  

compword(go,[s],goes).               %% Norw  
compword(going,[on],happening). 

compword(good,[friday],good_friday).

compword(holy,[night],christmas_eve). 

compword(natural,[language],nl). 

compword(new,[years,eve],new_years_eve). 
compword(new,[year,s,eve],new_years_eve). %% New Year's Eve? 
compword(new,[years,day],new_years_day).
compword(new,[year,s,day],new_years_day).


compword(how,[fast],when).  
compword(how,[soon],when). 

compword(i,[want,you,to],[]). 

compword(jump,[on],take). 

compword(m,[going],go). 

%% English named days %% TA-110201 ...

%% See above as well!
%% compword(christmas,[eve],christmas_eve).
%% compword(christmas,[day],christmas_day).
compword(boxing,[day],boxing_day). %% new 2. juledag

compword(new,[year,eve],new_years_eve).
%% compword(new,[years,eve],new_years_eve).
%% compword(new,[year,s,eve],new_years_eve).

compword(new,[year,day],new_years_day).
%% compword(new,[years,day],new_years_day).
%% compword(new,[year,s,day],new_years_day).

%% compword(carnival,[],carnival). %% Sunday before Lent (Faste)

compword(palm,[sunday],palm_sunday). 
%% compword(easter,[eve],easter_eve).
compword(easter,[day],easterday).
compword(easter,[monday],easterday2).
%% compword(day,[of,liberation],may8). %% ? new

compword(maundy,[thursday],maundy_thursday). 

compword(whitsun,[eve], whitsun_eve).   
compword(whit,[sunday], whitsun_day).   
compword(whitsun,[day], whitsun_day).
compword(whit,[monday], whitsun_day2). 

compword(constitution,[day],may17). 

%% See above for alphebetic sorted entries.
%% compword(ascension,[day],ascension_day).
compword(midsummer,[day],midsummer_day).  
compword(midsummer,[eve],midsummer_eve).   

% % % % % % % % % 

%% compword(motorized,[means],vehicle). %% TA-100907
compword(means,[of,transportation],vehicle).    %% Rondane

compword(nice,[to,meet,you],hello). 


compword(passing,[time],departure).  
compword(passing,[times],departures). % The hours indicate ..

compword(prime,[minister],primeminister). %% \+ - %% TA-110214 ?

compword(programming,[language],programminglanguage). 

compword(round, [trip],trip).  %% rough 


compword(in,[deed],[]).
compword(in,[how,many,minutes],when).
compword(in,[particular],[]).  
compword(in,[general],[]).  
compword(is,[the,one],is). 
compword(klæbu,[coaches],klæburuta).
compword(on,[the,other,hand],[]).
compword(pod,[bay],[]).              %%  :-) Hal
compword(same,[as],equal).           %%
compword(show,[up],arrive).  
compword(shut,[up],stop). 
compword(the,[same,as],equal).  
compword(to,[night],tonight).  
compword(to,[to],to).                 %% Repair 
compword(tram,[station],tramstation).
compword(tram,[stop],tramstation).    

compword(using,[only,one,bus],directly). 

compword(without,[bus,change],directly). 
compword(without,[switching,buses],directly). %% ad hoc

compword(what,[clock],when). 
compword(when,[bus],bus).  



xcompword(am,[going,to],will). 
xcompword(are,[going,to],will). %% 
xcompword(is,[going,to],will).      %% bus is going to 
xcompword(nr,['.'],number).  


xcompword(can,[t],cannot).

xcompword(1,[st],first).
xcompword(2,[nd],second).
xcompword(3,[rd],third).

xcompword(4,[th],fourth).
xcompword(5,[th],fifth).   
xcompword(6,[th],sixth).    
xcompword(7,[th],seventh).
xcompword(8,[th],eight).
xcompword(9,[th],ninth).
xcompword(10,[th],tenth).
xcompword(11,[th],eleventh).
xcompword(12,[th],twelvth).
xcompword(13,[th],thirteenth).
xcompword(14,[th],fourteenth).
xcompword(15,[th],fifteenth).
xcompword(16,[th],sixteenth).
xcompword(17,[th],seventeenth).
xcompword(18,[th],eighteenth).
xcompword(19,[th],nineteenth).
xcompword(20,[th],twentieth).  

xcompword(21,[st],twentyfirst).   xcompword(21,[th],twentyfirst).
xcompword(22,[nd],twentysecond).  xcompword(22,[th],twentysecond).
xcompword(23,[rd],twentythird).   xcompword(23,[th],twentythird). 

xcompword(24,[th],twentyfourth). 
xcompword(25,[th],twentyfifth). 
xcompword(26,[th],twentysixth). 
xcompword(27,[th],twentyseventh).
xcompword(28,[th],twentyeighth). 
xcompword(29,[th],twentyninth9).  
xcompword(30,[th],thirtieth).  
xcompword(31,[st],thirtyfirst).  xcompword(31,[th],thirtyfirst).

xcompword(airport,[express],airbus). 

xcompword(any,[other],any). %% TA-100907 Rondane
xcompword(bus,[number],bus). 
xcompword(bus,[ride],trip). %% TA-100902
xcompword(departure,[time],departure). 
xcompword(departure,[times],departures). %% saves problems

xcompword(human,[being],human). %% TA-110825

xcompword(pass,[by],pass). 
xcompword(season,[ticket],special_ticket). 
xcompword(the,[turing],turings). %% .. test Ad Hoc 

xcompword(to,[morrow],tomorrow). 




%% UNWANTED INTERPRETAION %% TA-101124

unwanted_interpretation(bruker,use). %% >1 dummy


unwanted_adjective(supercalif). %% Needs 1 

%% Document all predicates please!
unwanted_verb(bing).  %% \+ being
%% unwanted_verb(cost).  %% \+ cost! %% nofunk 
unwanted_verb(meaning). %% noun, destroys error mess-age: complete sentence

unwanted_noun(ends).  %%  not plu %% TA-110606
unwanted_noun(loves). %%  not plu 
unwanted_noun(second). %% confuse 2. %% TA-100909

%% Modification of individual words in this file 
%% is not commented in the text. 

%% Synonyms must be listed in all forms,
%%  no analysis prior to translation

%% Additional known (internal/ key) words 
%% to avoid spurious error messages
%% due to the keywords in the grammar



% be   = be0  ( be sick )  
% be   = be1  ( be in england  ) 
% be   = be2  ( be a man  = be equal to a man)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ow(X). % Open Word Class     => specific
% cw(X). % Closed Word Class   => misc 


%%%%%%%%%%%% 

ow(nb(_)).
ow(quote(_)).

ow(X) :- instant(X,word),!.

ow(X) :- numerid(X,_,_).
ow(X) :- adjective2(X,_).
ow(X) :- gradv_templ(X,_).  % also cw ? 


%%%%%%%%%  All the words appearing as [ ] constants in grammar  
% cw(X). % Closed Word Class   => misc 

cw('+'). %% TA-100902
cw('-').
cw('.'). 
cw('?').
cw('&'). %% TA-101122
cw('!').
cw(':'). 
cw('/').

cw(X) :- particle(X,_,_).
cw(X) :- gradv_templ(X,_). 
cw(X) :- pronoun(X,_). 

cw(a). cw(b). cw(c). cw(d). cw(e). cw(f). cw(g). cw(h). %% street letters
cw(i). cw(j). cw(k). cw(l). cw(m). cw(n). cw(o). cw(p). 
cw(q). cw(r). cw(s). cw(t). cw(u). cw(v). cw(w).

cw(able). cw(ago).
cw(according). cw(all). cw(also). cw(always). 
cw(afternoon). 
cw(am). % < 12 
cw(an). cw(and). cw(another). cw(any). cw(anybody). 
cw(anything). cw(anyone). cw(anywhere) .
cw(as). cw(average). cw(away). 

%cw(b). %% allow S. R. 12b 
%%%% cw(bay). %% Necessary ????
cw(be). cw(because). cw(been). cw(bigger). cw(biggest). 
cw(both). cw(bound). cw(bravo).  cw(but). cw(by). cw(bye). 

cw(can). cw(cannot). cw(clock).  % cw('can''t'). 
cw(coaches). %% ad hoc  Klæbu coaches

cw(day).

cw(different). cw(do). cw(dont). cw(does).

cw(each). cw(east). cw(equal). cw(every). cw(everybody). cw(everyone).
cw(evening).
cw(everything). cw(everywhere). cw(exit).

cw(false). 
cw(far). cw(few).  
cw(farewell). cw(for).

cw(good). 
cw(goodbye). cw(greater). cw(greatest).

%% cw(h).
cw(hello). cw(herself). cw(here). 
cw(him). cw(himself). cw(his). cw(holdeplass). %% TA-101022
cw(hour). cw(hours). cw(hrs). 
cw(how).

%% cw(i).
cw(ideally). cw(if).  cw(in). %%
cw(it). cw(its). cw(itself). 

cw(just).

cw(kl).  %%   Norwagism, OK 

% cw(kind). %% (noun, but only used in phrases)

cw(last).  cw(lawl). 
cw(least). cw(less). 

%cw(m).
cw(may). %% cw(medium). ==> pro forma adjective
cw(morning). 

cw(never). cw(next). cw(newyear).  cw(no). %% as in no.

%cw(o).
cw(ok). cw(oclock). cw(often). 
cw(older). cw(one). cw(other).

cw(many). cw(more). cw(most). cw(much). 
cw(must). cw(my). 
%cw(next).

cw(night).
%cw(no).
cw(nobody). cw(noone). cw(north). cw(not). cw(nothing). cw(nowhere).

%cw(older).
cw(only). cw(or). cw(order).
%cw(other).
cw(others).
cw(own).

%cw(p).
cw(ping). cw(pong).  cw(pm). %% > 12 

cw(recently). cw(regards). cw(right). 

cw(lol).
%cw(lawl).
cw(rotfl). cw(rofl). cw(roflmao). cw(rotflmao). cw(lmao).

%% cw(s). %% 's  genitive 
cw(set). 
cw(several).   cw(shall). 
cw(simpler).   cw(smaller).  cw(smallest). cw(so). 
cw(some).  cw(somebody). cw(someone).  cw(something). 
cw(somewhere). cw(south). cw(such). 

cw(than). cw(thank). cw(thanks). cw(thankyou). cw(that). cw(thats). cw(the).  
cw(their). cw(then). cw(there).  cw(these) .
cw(this).  cw(to). cw(total). cw(true).

cw(unequal). cw(until). cw(using). cw(usual). cw(usually).


cw(whats). 
cw(well). cw(west). cw(will). cw(without).  
cw(what). cw(when). 
cw(where). cw(wherefrom).  cw(whether). cw(which). cw(while).
cw(who). cw(whose). cw(why).


cw(yes). cw(you). cw(younger). cw(your). cw(yours).


%% Auxillary words (synonyms)

%% No morphological analysis is done on the synonyms,
%  which means that all forms must be listed explicitly.
%  The substitute word is analysed however.
%  No looping in synword, the transitive closure must be done by hand


% synword names -> synplace  (busdat) 

synwordx(X,Y):-value(smsflag,true),synsms(X,Y). 
synwordx(X,Y):-synword(X,Y).


synsms(b,bus).  
synsms(cul8r,bye). 
synsms(l8r,later). 
synsms(f,from).
synsms(m,am).  %% I'm 
synsms(mz,my). 
synsms(r,are). 
synsms(t,to).  
synsms(u,you). 

synword(Four,_4):-numerid(Four,_4).


synword(jan,january).
synword(feb,february). synword(febr,february).
synword(mar,march).
synword(apr,april).
%% synword(may,may). %% :-) OK, No looping in synword. 
synword(jun,june).
synword(jul,july).
synword(aug,august).
synword(sep,september). synword(sept,september).
synword(oct,october).
synword(nov,november).
synword(dec,december).

synword(mon,monday).
synword(tue,tuesday).
synword(wed,wednesday).
synword(thu,thursday).
synword(fri,friday).
synword(sat,saturday).
synword(sun,sunday).

synword(thirsday,thursday).
synword(tusday,tuesday).  
synword(tuewsday,tuesday). %%  own

synword('@',at). %% ?
synword('15h00',1500). %%  ETC ETC 

synword('00am',00). %% more robust  am). %% 9.00am 
synword('30am', 30). %% 30        etc 9.30am=9.30 // NOT for  PM



/*     Must avoid   10am -> 22  for pragmatic reasons
       %% (Ad Hoc,  splitword)

synword('1am',  100). 
synword('2am',  200).
synword('3am',  300).
synword('4am',  400).
synword('5am',  500).
synword('6am',  600).
synword('7am',  700).
synword('8am',  800).
synword('9am',  900).
synword('10am',1000).
synword('11am',1100).
synword('12am',1200).

*/








%% synword('30pm',30) '   8.30pm = 20.30 ### NO


/*    to nth at  10.30pm 

synword('1pm',1300).
synword('2pm',1400).
synword('3pm',1500).
synword('4pm',1600).
synword('5pm',1700).
synword('6pm',1800).
synword('7pm',1900).
synword('8pm',2000).
synword('9pm',2100).
synword('10pm',2200).
synword('11pm',2300).
synword('12pm',2400).

synword('13pm',1300). 
synword('14pm',1400).
synword('15pm',1500).
synword('16pm',1600).
synword('17pm',1700).
synword('18pm',1800).
synword('19pm',1900).
synword('20pm',2000).
synword('21pm',2100).
synword('22pm',2200).
synword('23pm',2300).
synword('24pm',2400).

*/



synword(afer,after).  
synword(afther,after). 
synword(aint,are).      %%  Rough Query Logic 
synword(alike,equal). 
%% synword(all,whole). %% all buses 
synword(allowed,possible). %% rough
%% synword(am,morning).  %% Am I married ? -> (This) morning I marries 
synword(appear,be). 
synword(approximately,around). 
synword(approx,around). 
synword(ar,are).  
synword(araound,around). 
synword(arive,arrive).  
synword(arond,around).  

%% synword(arriving,to).  %% arriving lade %% Ad Hoc 
%% synword(arriving,before).  %% doesn't help  

synword(asap,hereafter).   %% soon/ i.e.. as soon as possible

synword(beatiful,beautiful).
synword(befor,before).  
synword(begin,start).   

synword(besides,       and).
synword(beween,        between). %%  ?
synword(big,           great).
synword(bigger,        greater).
synword(biggest,       greatest).

% synword(bring,         fetch).     %%  (Norwagism, not correct)
% synword(british,       english).  

synword(bues,          bus). %% spell buses
synword(buse,          bus). 
synword(busfare,       price). 
synword(busline,       route). 
synword(buslines,      routes). 
synword(busroute,      route). 
synword(busroutes,     routes).
synword(buss,           bus).     %% Norwenglish
synword(busses,         buses). 
synword(bussconnection, bus). 
synword(bussconnections,buses).  
% synword(bussdeparture,  bus). 
% synword(bussdepartures, buses). %%
synword(bussline,       route).
synword(busslines,      routes).
synword(bussroute,      route). 
synword(bussroutes,     routes).  
synword(busstation,     station). 
synword(busstations,    stations).
synword(busstuc,        bustuc). 

synword(busstop,       station). 
synword(busstops,      stations).

% synword(but,           and). %% Needed for a slight difference

synword(by,            past). 

synword(ca,            around). 
synword(cant,          cannot). 
synword('can''t',      cannot). 
synword(catch,         take).   
synword(center,        centre).     %%   English spelling
synword(chirstmas,     christmas). 
synword(choose,        take).       %%  (rough)
synword(circa,         around). 
synword(citty,         city).
synword(close,         near). 
synword(closest,       nearest). 
synword(cneter,        centre).      %%  English spelling
synword(color,         colour). 
synword(colors,        colours). 
synword(complete,      whole). 
synword(confused,      wrong).  
synword(connection,    bus).      
synword(connections,   buses).    
synword(controll,      control). 
synword(could,         can).    
synword(cpu,           computer). %% rough
synword(crazy,         wrong). %%  (rough)
synword(currently,     now). 


synword(deparature,   departure).  
synword(departrue,    departure).  
synword(departrure,   departure). 
synword(depature,     departure). 
synword(depatrue,     departure). 
synword(depatrure,    departure).  

synword(deparatures,   departures). 
synword(departrues,    departures).  
synword(departrures,   departures). 
synword(depatures,     departures).  
synword(depatrues,     departures).   %%



% synword(departure,     depart).   %% incorrect and confusing 
% synword(departures,    departs).  %%
% synword(departured,    departed). %%

synword(desember, december). 

synword(dicember,december). 

synword(did,           do).       
synword(documentation, document).
%% synword(does,          do). %% NOT do1 inf ! 
synword(doeas,         does).   
synword(dooing,        doing). 
synword(dork,          fool).   %% TA-101104
synword(dose,          does). 
synword(dost,          do).     %% dost you answer everything 
%% synword(du,            do).  %% destroys lang. detection.
synword(drinking,      drink).  %% Ad Hoc %% TA-110606
synword(dumb,          stupid). 


%% synword(earlier,       first). 
synword(earliest,      first). 
synword(easiest,       best). 
synword(eave,          eve). 
synword(elderly,       old).  
synword(email,         mail). %  V V ?
synword(enjoy,         like). 
synword(enjoyed,       liked). 
synword(enjoys,        likes).   
synword(esater,        easter).  
synword(eve,           evening).  
%%synword(eve,           evening).  %% (not Christmas Eve) 
synword(exit,          quit).  

synword(fare,          price).    %% 
synword(fair,          good). 
synword(fares,         prices). 
synword(fellow,        man).    
synword(ferry,         boat).    %% ( rather ako boat)
synword(ferries,       boats). 
synword(fine,          good).  
synword(firsth,        first). 
synword(fix,           repair).
synword(fixed,         repaired).
synword(fixes,         repairs).
synword(flybuss,       airbus). 
%% synword(for,           before). %%  Hazardous
synword(form,          from). 
%% synword(fram,from). %% own, but destroys lang sel.
synword(frequent,      often). 
synword(frequently,    often). 
synword(frim,from). %% TA-110819
synword(fro,           from).  
synword(fron,          from). 
synword(fubar,         bad).  %% f_d up beyonf all recognition :-) %% TA-110606

synword(goeing,        going). 
synword(gors,          goes).  
synword(goto,          pass).  
synword(gp,            go).  
synword(grumpy,        sour). 
synword(guy,           man).    

%% synword(h,             hours).   %%  2 h \ 2 oclock
  %% not noun /duration 

synword(halt,          stop).

synword(hav,           have). 
synword(haw,           how).
synword(heading,       going). 
synword(helloh,        hello).  
synword(hellohello,    hello). 
synword(helllo,        hello).
synword(helo,          hello). 
synword(helpful,       clever).
%% synword(hei,           hello).  %% -> N
synword(hay,           hello). 
synword(hey,           hello). 
synword(heyhey,        hello).
synword(hi,            hello). 
synword(high,          great).
synword(higher,        greater).
synword(higher,        great).  
synword(highest,       greatest).
synword(highest,       great). 

synword(hoe,           how). %%  sp
synword(holiday,       sunday). %%  for all p p
synword(holidays,      sundays). 
synword(hound,         dog).      %% (Norwagism)
% synword(hurtigrute,    hurtigruta). %% ( also def as a place)
synword(hrs,           hours).
synword(hwat,          what). %%  own
synword(hwta,          what). %%  actual 

synword(id,            i). %%  Web:  (I'd ==> id)  like to go to By'n 
%% synword(idiot,         fool). ¤¤ avoid to "idiot" (fool) 
synword('i''d',        i). %%  Unix  (I'd ==> 'i'd') 

synword(identical,     equal).
synword(im,            in). 
synword(immediately,   now).  
synword(impressive,    good). 
synword(info,          information). 
synword(inbetween,     between).
synword(interesting,   good).
%% synword(information,   list). %% NOT the VERB !!! 
synword(iq,            intelligence).  

synword(j,             i).      %% ( J  == I ) Norwagism
synword(jerk,          fool). 
synword(job,           task). 

synword(kid,           child).  
synword(kids,          children). 
synword(kystexpressen, hurtigruta).
synword(large,         great).
synword(larger,        greater).
synword(largest,       greatest).
synword(late,          last).    %% Ambiguous
synword(latest,        last). 
%% synword(leader,        boss).   %%   ( or v.v.) 
synword(boss,          leader). 
synword(left,          forgot). %% I left my bag/ Special
synword(lets,          i).      %% let(u)s sing
synword(leve,          leave). 
%% synword(liff,          life).   %% :-) liff=43
synword(line,          route). 
synword(lines,         routes).
synword(listing,       list). 
synword(little,        small).
synword(location,      place). 
synword(logout,        goodbye). 
synword(lovely,        good).  

synword(mad,           wrong). 
synword(master,        leader).
synword(me,            i).   
synword(merry,         good). 
synword(might,         may).    
synword(min,           minutes).  
synword(mins,          minutes). 
synword(mine,          my).          %% Rough 
synword(mission,       task). 
synword(myself,        i). %% me). %% []). 

synword(nation,        country).
synword(nations,       countries).
synword(near,          around).      %% time ,  near => near, around
synword(nearby,        near).        %%            nearby => near
synword(nearest,       near).        %%   (Rough)
% synword(need,          have).      %% need/have to  % Hazardous
synword(need,          take).        %% bus need stime to go...
synword(need,          want). 
synword(nexst,         next).   
synword(nest,          next).        %%  Norwagism/Neib
synword(nomber,        number).  
synword(norsk,         norwegian).  
synword(notice,        see). 
synword(notices,       sees).
synword(noticed,       saw).
synword(nxt,           next).

% synword(no,            number). %% bus number . ==> (bus) . , not bus (no.)
% synword(nr,              no).  %% ==> NJET 
 
synword(nr,            number).

synword(observe,       see).  
synword(observes,      sees).
synword(observed,      saw).
%% synword(oclock,        clock).  %% only as phrase
%% synword('o''clock',    clock).  %% only as phrase 
synword(ok,            good). 
synword(okay,          ok).
synword(okey,          ok). 
synword(omg,           hello). %% oh my god 
synword(optimal,       best). 
synword(our,           my). 

synword(pas,           pass).     %% spc 
synword(path,          bus).      %% ???
synword(peer,          look).     %%
synword(peered,        looked).   %%
synword(peers,         looks).    %%
%% synword(per,           by).    %% per train ???
synword(per,           each). 
synword(phonenumber,   telephone). 

%% synword(pm,            afternoon). %% destroys 5pm

%% synword(pile,          heap).
synword(plase,         place).  
synword(pn,            pm).  
synword(popular,       good).  
synword(port,          harbour).
synword(possibel,      possible). 

%% synword(purpose,       task). %% TA-110606     %% ( doubtful )

synword(quick,         fast). 
synword(quickest,      fastest).  
synword(quickly,       fast).   
synword(quest,         task). 

synword(railwaystation, railway).
synword(railstation,   railway). 
synword(raining,       rain).      %%  (roughly)
synword(rapid,         fast). 
synword(regular,       common). 
synword(request,       ask).   
synword(requested,     asked).     %%
synword(requests,      asks).      %%

synword(request,       question). 
synword(requests,      questions).

synword(revise,        modify).
synword(revision,      version).
synword(revisions,     versions).

%% synword(ridden,        taken). 
synword(ride,          take). 
synword(riding,        taking). 

% synword(right,         just).  %%   right after 1616

synword(ro,            to).      %% neib k
% synword(rode,          took).  %%

synword(s,             is). %%   what 's
synword(sad,           unhappy). 
synword(silly,         stupid). 

synword(schedule,      departure). 
synword(schedules,     departures). 
synword(scedule,       departure). 
synword(scedules,      departures). 

synword(schedule,      route_plan).    %%   (schedule of departure)

synword(seem,          are). 
synword(seems,         is). 
synword(seemed,        were). %% was

%% synword(sense,         intelligence). %% this makes no sense 
                                         %% sense of humour
synword(sentient,      conscious).   

synword(shall,         will).   
synword(shortest,      fastest).
synword(should,        will).
synword(shutdown,      stop).  %% V or N
synword(shuttle,       bus). 
synword(similar,       equal). 
synword(since,         after).
synword(smart,         clever). 
synword(soon,          hereafter). 
synword(soonest,       hereafter). 
synword(speek,         speak). 
synword(spirit,        mood). 

% synword(spot,          see).
% synword(spots,         sees).  %% 
% synword(spotted,       saw).   %%

% synword(stasion,       station).      %%  (spell Nw) Doesn't work for name
synword(state,         country). % USA ???
synword(states,        countries).

%% synword(station,       railway).  %%   Hazardous, station in E is bigger
%%  end station of bus 66 station -> railway -> TS 


%%%%  synword(stop,          station).  %% which buses stop = which buses' station
                                        %% syndrome 
%%%%% synword(stops,         stations). 

synword(suppose,       think).  

synword(sure,          certain).

% synword(t,             not).    %%  (hazardous ?)  %% ain't

synword(table,         route_plan). 
synword(taht,          that). 
synword(talk,          speak). 
synword(talked,        spoke).      %%   LACK verb root synonym 
synword(talking,       speaking). 


synword(tall,          great).   
synword(taller,        greater).
synword(tallest,       greatest).
synword(th,            the).  
synword(thank,         thanks).
synword(thankz,        thanks). 
synword(thanx,         thanks). 
synword(thx,           thanks). 
synword(thik,          think).  
synword(thirtyeth,     thirtieth). 
synword(those,         these). 
synword(thou,          you). 

%% synword(til,           to).      %% ? ¤¤ TA-101230 (Norwagism)

%% synword(till,          to).  
   
synword(till,          until).     
% synword(timetable,     departure). %% -> time
% synword(timetables,    departures). 
synword(tje,           the).  
synword(tomorow,       tomorrow). 
synword(tommorow,      tomorrow). 
synword(tommorrow,     tomorrow). 
synword(tomorroe,      tomorrow).  
synword(tonigh,        tonight). 
synword(tou,           you). 
synword(tp,            to).  
synword(trail,         train).        %% Norw %% ?
synword(trailstation,  trainstation). %% 
synword(transport,     route). 
synword(transportation, route).
synword(travel,        go).
synword(travels,       goes).    %%
synword(travelled,     went). 
synword(trom,          from).  
synword(tvelve,        twelve).  %% (Norwagism)
synword(tvelwe,        twelve).  %% (Norwagism)
synword(twelveth,      thelwth). 
synword(twentyeth,     twentieth). 
synword(tyo,           to).      %% slip 

synword(u,             you).    
synword(ultimate,      last). %% .. question %% :-) 
synword(unintelligent, stupid). %% TA-100902
synword(update,        version). 
synword(ur,            your). 
synword(us,            i).       %%  (Trans Closure)
synword(useless,       bad).    
synword(useful,        good).   

synword(ve,            have). %% I've seen a bus 
synword(vei,           veg).     %% Odd but necessary 
synword(via,           past).
synword(waht,          what).  
synword(wat,           what).   
synword(wath,          what).  
synword(wanna,         will).
synword(watch,         see).
synword(watched,       saw).
synword(watches,       sees).
synword(way,           route).   %%  --> route --> bus 
synword(we,            i). 
synword(welcome,       hello). 
synword(whant,         want). 
synword(whar,          what).  
synword(whatever,      what).  
synword(whicj,         which). %% own 
synword(whom,          who).
synword(wich,          which). 
synword(wil,           will). 
synword(witch,         which).  %% also woman :-(
synword(would,         will).   

synword(yeah,          yes).
synword(yhe,           the). %% neib key 

synword(you,           tuc). % is there a thing you know= (thing tuc)
                             %% Ad hoc. I love you       
synword(yo,            you).               
synword(your,          tucs).
synword(youre,         tucs).
synword(yourself,      tuc). 


noisew(BS):-backslash(BS).

noisew('«').
noisew('»'). 

noisew('=').
noisew(' ').
noisew('<'). 
noisew('>'). 
noisew(''''). 
noisew('-'). 
%% noisew('+'). %% TA-100902 
noisew('*'). 
noisew('¨').
noisew('#'). 
noisew('('). %%  :- \+ value(noparentflag,true). %%  Not nec
noisew(')'). %%  :- \+ value(noparentflag,true). 
noisew(',').
noisew(';').
noisew('¡'). 
noisew('¯').


noisew(actual). 
noisew(actually     ).
noisew(again). 
noisew(also         ). 
noisew(anyway). 
noisew(briefly). 
noisew(btw). %% by the way
noisew(current).  
noisew(eh). 
noisew(either). 
noisew(else).            %%  what else ...
noisew(even).  
noisew(ever). 
noisew(fully).
noisew(furthermore).  
noisew(ideally      ).
noisew(indeed). 
noisew(instead).  
noisew(just). 
%% noisew(kl          ). %%  Norwagism  (destroyed language selection)
noisew(located).  %% fapp 
noisew(more).            %%  what more do you ...
noisew(moreover).  
noisew(most). 
noisew(noteworthy).  
noisew(oh).
%% noisew(ok).    %% are you OK ?
noisew(okey         ). %% no syn on noise 
noisew(once). 
%% noisew(only).    %% NO;  not only = reductant

noisew(please ).
noisew(plz). 
noisew(quite  ). 
noisew(really ). 
noisew(respectively). 
noisew(similarily ). 
noisew(specifically ). 
noisew(such). 
noisew(suddenly).  
%% noisew(so  ).    %% john dies so that .. 
noisew(thoroughly).  
noisew(thus   ).
noisew(too).
noisew(typical).  
noisew(usually).
noisew(very   ). %%  !
noisew(wassa  ). %% English translation of dialect ("What's the")
noisew(whatsoever).   
noisew(wow). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Noun Section

noun2(M,N):-nounsyn(M,N).
noun2(N,N):-noun(N).

noun(thing).
noun(X) :- (X ako _ ),
    \+ unwanted_noun(X). %% second %% TA-100909

%% Replaces synonyms with inflections (Root synonyms)

nounsyn(aeroplane,     airplane).
nounsyn(ai,            intelligence). %% TA-100902 
%% nounsyn(airplane,      plane). 
nounsyn(pc,             computer). 
nounsyn(plane,          airplane). 
nounsyn(point,          meaning). %% TA-110825
% nounsyn(airplane,airport).  
nounsyn(autobus,bus).   
nounsyn(avenue,        street). %% STREET is the official 

nounsyn(being,         human). %% h b %% TA-110825
nounsyn(bike,          bicycle). 
nounsyn(boyfriend,     friend). 
nounsyn(bug,           error).  
nounsyn(buscard,       card).   
nounsyn(busconnection, bus).     
nounsyn(busdeparture,  departure).  
nounsyn(busdriver,  driver). 
nounsyn(bussdriver,  driver). %% sp %% TA-110215

nounsyn(bussdeparture,  departure). 
nounsyn(busnumber,     number).       %%  (bus ?) busnumber of a bus
nounsyn(bustime,       departure).  

nounsyn(chair,         seat). 
nounsyn(chance,        probability). 
nounsyn(change,        transfer).     %%   or V.V ?
%%%    nounsyn(switch,        transfer).  
nounsyn(coach,         bus).  
nounsyn(consciousness, mind). 
nounsyn(conversation,  talk). 
%% nounsyn(creator,       programmer).   %% rough 
nounsyn(dad,            father). 
nounsyn(daugther,      daughter).     %%  (sp)
nounsyn(dealership,    shop).         %%   (Jurafsky)
nounsyn(departuretime, departure). 
nounsyn(detail,        information). 
nounsyn(flight,        airplane).  
nounsyn(girlfriend,    friend). 
nounsyn(hollyday,      holiday).  %% NB holiday= ferie, holyday=helligdag 
nounsyn(human,         person).  

nounsyn(idiot,         fool).
nounsyn(intersection,  street). %% vei (kryss) rough 
%%% nounsyn(installation,  implementation). %% rough  Rondane %% TA-100908
nounsyn(journey,       trip). 
nounsyn(lecture,       meeting).      %% Rough
nounsyn(loser,         fool). 
nounsyn(lunch,         noon).         %%  (actual synonyms)
nounsyn(machine,       computer). 
nounsyn(mate,          friend).  
nounsyn(newbie,        fool).  
nounsyn(nerd,          savant). 
nounsyn(noob,          fool). 
nounsyn(omnibus,       bus). 
nounsyn(plan,          route_plan).   %% ( too BUSy ?)
nounsyn(prise,         price).        %% spell
nounsyn(purse,         wallet). 
nounsyn(query,         question). 
nounsyn(request,       question).
nounsyn(retard,        fool).  %% \+ idiot  
nounsyn(ride,          trip).  
nounsyn(road,          street). %% STREET is the official
nounsyn(roundtrip,     trip). 
nounsyn(rout,          route).  %% sp

nounsyn(streetcar,     tram). 
nounsyn(sort,          type). 

nounsyn(time,          time).         %% nec, otherwise cut (time_count)
nounsyn(time,          time_count).   %%  ( how many times ) 
nounsyn(timing,        time).
nounsyn(timetable,     departure). 
nounsyn(tour,          trip). 
nounsyn(town,          city). 
nounsyn(tramway,       tram). 
nounsyn(traveller,     passenger).
nounsyn(traveler,     passenger). %% US 

nounsyn(trouble,       problem). 
nounsyn(wc,            toilet).   
nounsyn(webpage,       homepage).  
nounsyn(weekday,       monday).       %%  for all p p

nounsyn(busoracle,oracle). 
nounsyn(dialog,dialogue). 
nounsyn(catalog,directory).   
nounsyn(catalogue,directory). 
nounsyn(people,person).
nounsyn(phone,telephone).
%  nounsyn(town,city).  % prefer town = Sentrum 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% VERB SECTION

%% verbroot2(V,V) :- morph_e:verbroot(V).  %%
verbroot2(V,V) :- verbroot(V).  %%


% These are verb root synonyms, inflection is included

verbroot2(assume,believe). 
verbroot2(become,be). 
verbroot2(board,take). 
verbroot2(carry,take). 
verbroot2(cover,have). 
verbroot2(create,make). 
verbroot2(cross,pass).
verbroot2(declare,define). 
verbroot2(delete,remove). 
verbroot2(depart,leave2).  %%  forlate
verbroot2(design,make).  
verbroot2(develop,make). 
verbroot2(enter,arrive).  
verbroot2(follow,take).    %% Must be at least one here
verbroot2(indicate,be).    %%  the earliest passing times.
verbroot2(overhear,hear).  %% ? Techn
verbroot2(postulate,tell). 
verbroot2(program,make). 
verbroot2(report,write). 
verbroot2(return,go).      %% Roughly 
%% verbroot2(recognize,recognise). %% English Pronounc /z ok
verbroot2(spend,use).   
verbroot2(specify,   tell). %% ala dict_n
verbroot2(supply,   give). 
  %% verbroot2(switch,   change).  %% Try without, only as itv
verbroot2(swap,   change). 
verbroot2(type,   write). 

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %


%%     Irregular Verbs
verb_form(admitted, admit,past,fin).  %% morph_e rule ?
verb_form(admitted, admit,past,part). 

verb_form(am,       be,pres,fin).       
verb_form(are,      be,pres,fin).      

verb_form(ate,      eat,past,fin). 
verb_form(bear,     bear1,pres,fin).
verb_form(bear,     bear2,pres,fin).
verb_form(beaten,   beat,past,part).     
verb_form(been,     be,past,part).    
verb_form(began,    start,past,fin). 
verb_form(begun,    start,past,part). 
verb_form(bit,      bite,past,fin).     
verb_form(bore,     bear1,past,fin).    %% carried 
verb_form(bore,     bear2,past,fin).    %% gave birth 
verb_form(born,     bear2,past,part).    
verb_form(broke,    break,past,fin).
verb_form(broken,   break,past,part).
verb_form(bought,   buy,past,fin).      
verb_form(came,     come,past,fin).     
verb_form(caught,   catch,past,fin).
verb_form(chosen,   chose,past,part).

verb_form(do,       do1,pres,fin).
verb_form(do,       do1,inf,fin).  %% what do you do1 %% odd, but does a bus \== do1 
                                   %% what can you do ?
verb_form(does,     do1,pres,fin). %%  NOT inf !
verb_form(doing,    do1,pres,part).    %%  What are you doing
verb_form(done,     do1,past,part).    %%  What have you done

verb_form(driven,   drive,past,part). 
verb_form(drove,    drive,past,fin).
verb_form(dying,    die,pres,part).  

% verb_form(flies,    fly,pres,fin).    %%

verb_form(forgot,   forget,past,fin).
verb_form(forgotten,forget,past,part). 

verb_form(found,    find,past,fin).     
verb_form(found,    find,past,part). 

verb_form(gave,     give,past,fin).
%% verb_form(get,      receive,pres,fin). %% Confusing
                                          %% I get by bus to NY
verb_form(getting,  go,pres,part).  
verb_form(given,    give,past,part). 
verb_form(gone,     go,past,part). 
verb_form(got,      get,past,fin).
verb_form(got,      get,past,part).
verb_form(got,      receive,past,part). 

verb_form(had,      have,pres,fin).
verb_form(has,      have,pres,fin).
verb_form(having,   have,pres,part).

verb_form(is,       be,pres,fin). 

verb_form(knew,     know1,past,fin). 
verb_form(knew,     know,past,fin). 
verb_form(know,     know1,pres,fin). % know thing
verb_form(know,     know,pres,fin).      % know that
verb_form(known,    know,past,part). 
verb_form(knows,    know1,pres,fin).
verb_form(knows,    know,pres,fin).

verb_form(lay,      lie1,past,fin).
verb_form(laid,     lay,past,_).
verb_form(lain,     lie1,past,part).
verb_form(left,     leave,past,fin). 
verb_form(left,     leave,past,part). 
verb_form(lie,      lie1,pres,fin).
verb_form(lie,      lie2,pres,fin). % speak untruth 
verb_form(lies,     lie1,pres,fin). %% lie2 ..
verb_form(lied,     lie2,past,fin).
verb_form(lied,     lie2,past,part).
verb_form(lost,     lose,past,fin).
verb_form(lost,     lose,past,part).

verb_form(made,     make,past,fin). 
verb_form(made,     make,past,part). 
verb_form(meant,    mean,past,fin).
verb_form(meant,    mean,past,part).
verb_form(met,      meet,past,fin). 
verb_form(modified,modify,past,part).
% verb_form(modifies, modify,pres,fin). %%

verb_form(ran,      run,past,fin).
verb_form(reach,    pass,pres,fin).  
verb_form(read,     read,past,fin). 
verb_form(read,     read,past,part).

verb_form(said,     say,past,fin).
verb_form(said,     say,past,part). 
verb_form(sang,     sing,past,fin). 
verb_form(sat,      sit,past,fin).      
verb_form(saw,      see,past,fin).
verb_form(seen,     see,past,part).     
verb_form(sent,     send,past,fin). 
verb_form(sent,     send,past,part). 
verb_form(shot,     shoot,past,fin). 
verb_form(shot,     shoot,past,part). 
verb_form(sitting,  sit,pres,part). 
verb_form(spoke,    speak,past,fin). 
verb_form(spoken,   speak,past,part).
%% verb_form(shot,     shoot,past,fin). 
verb_form(shopped,  shop,past,fin).
verb_form(slept,    sleep,past,fin).
verb_form(sold,     sell,past,fin).
verb_form(sold,     sell,past,part).
verb_form(stood,    stand,past,fin).
verb_form(stood,    stand,past,part).
verb_form(stopped,  stop,past,fin). 
verb_form(stopped,  stop,past,part).
verb_form(stopping, stop,pres,part). 
verb_form(sung,     sing,past,part).     

verb_form(taken,take,past,part).  
verb_form(took,take,past,fin).       %%
verb_form(travelled,travel,past,_).   
verb_form(tried,try,past,_). 
%% verb_form(think,    believe,pres,fin). % think possible  
%% verb_form(thinks,   believe,pres,fin). % 
verb_form(thought,  think,past,_). 
verb_form(threw,    throw,past,fin). 
verb_form(throwing, throw,pres,part).  
verb_form(thrown,   throw,past,part).  
verb_form(told,     tell,past,fin).     
verb_form(told,     tell,past,part).  

verb_form(understood,understand,past,fin).
verb_form(understood,understand,past,part).  

verb_form(was,be,past,fin).  
verb_form(went,go,past,fin).
verb_form(were,be,past,fin).          %%
verb_form(written,write,past,part).
verb_form(wrote,write,past,fin).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

rep_verb(Tell):- 
    rv_templ(Tell,_). %% Semantic 


%% preposition(intime).  % generic for when
%% preposition(inplace). % generic for where
preposition(by).

preposition(about).   
preposition(above).   
preposition(according_to).
preposition(across).  
preposition(after).
preposition(against).
preposition(along). 
preposition(among).   
preposition(around). 
preposition(as).  %% A is known as B  Hazardous ???
preposition(at).
preposition(because_of). %% Internal 
preposition(being_the).  %%  contrived
preposition(before).
preposition(behind).
preposition(below).
preposition(beside). 
preposition(between).
preposition(beyond).
%% preposition(by). %% RS-220805 Moved first for some reason.
preposition(down). 
preposition(during).
preposition(except).
preposition(for).     
preposition(from).
preposition(in). 
preposition(inside).  
preposition(into).    
preposition(like).  %% You look like an angel 
% preposition(minus).
preposition(near).  
preposition(nearer). 
preposition(nearest). 
preposition(of).
preposition(off).  
preposition(on).
preposition(onto). 
preposition(opposite). 
preposition(out_of).       %% Internal 
preposition(outside).  
preposition(over). 
preposition(past).
% preposition(plus).   
preposition(since). 
preposition(through). 
% preposition(times).        %% :-) multip. 
preposition(to).
preposition(towards). 
preposition(under).   
preposition(until).      %% also subordinate conjunction !
% preposition(up).         %% particle 
preposition(upon).
preposition(via). %% synonym with past %% reach place via route
preposition(with).
preposition(within). 
preposition(without). 



%%%%%%%%%noun_form(ansatte,ansatt,plu,u,n).  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lexnsingirr(Dialog,Dialogue):- 
    nounsyn(Dialog,Dialogue).

/*

lexnsingirr(dialog,dialogue). 
lexnsingirr(catalog,directory).   
lexnsingirr(catalogue,directory). 
lexnsingirr(people,person).
lexnsingirr(phone,telephone).

*/


lexnpluirr(Children,Child):- 
    noun_form(Children,Child,plu,u,n).


noun_form(children,child,plu,u,n).    
noun_form(men,man,plu,u,n).         
noun_form(mice,mouse,plu,u,n).
noun_form(knives,knife,plu,u,n).
noun_form(people,person,plu,u,n). 
noun_form(thieves,thief,plu,u,n).
noun_form(wives,wife,plu,u,n). 
noun_form(women,woman,plu,u,n).    




% Mass nouns (used without article). -> semantic.pl

% massnoun(charge).   
% massnoun(consent).  
% massnoun(contact).  
% massnoun(fish).
% massnoun(logic). 
% massnoun(milk). 
% massnoun(money).
% massnoun(oil).   
% massnoun(sale).  
% massnoun(spring).
% massnoun(time).



adjective2(X,X):- 
    adj_templ(X,_),
    !. %% >1 

adjective2(X,Y):- 
    ordinal2(X,Y,_). 

adjective2(boring,tedious). %% TA-110825

adjective2(fun,good).   %% Not synword
adjective2(glad,happy).
adjective2(meaningless,impossible).
adjective2(odd,wrong). %% TA-110104 .. answer
%%% adjective2(motorized,automatic). %% rough %% rondane TA-100908

% Numerids


numerid(M,N,num):-
    numerid(M,N).

numerid(M,N,ord):-
    ordinal2(_,M,N); 
    ordinal2(M,_,N).


ordinal2('1st',first,1).
ordinal2('2nd',second,2).
ordinal2('3rd',third,3).
ordinal2('4th',fourth,4).
ordinal2('5th',fifth,5).   
ordinal2('6th',sixth,6).    
ordinal2('7th',seventh,7).
ordinal2('8th',eight,8).
ordinal2('9th',ninth,9).
ordinal2('10th',tenth,10).
ordinal2('11th',eleventh,11).
ordinal2('12th',twelvth,12).
ordinal2('13th',thirteenth,13).
ordinal2('14th',fourteenth,14).
ordinal2('15th',fifteenth,15).
ordinal2('16th',sixteenth,16).
ordinal2('17th',seventeenth,17).
ordinal2('18th',eighteenth,18).
ordinal2('19th',nineteenth,19).
ordinal2('20th',twentieth,20).  

ordinal2('21st',twentyfirst,21).   ordinal2('21th',twentyfirst,21).
ordinal2('22nd',twentysecond,22).  ordinal2('22th',twentysecond,22). ordinal2('22rd',twentysecond,22).
ordinal2('23rd',twentythird,23).   ordinal2('23th',twentythird,23).  ordinal2('23nd',twentythird,23).
ordinal2('24th',twentyfourth,24). 
ordinal2('25th',twentyfifth,25). 
ordinal2('26th',twentysixth,26). 
ordinal2('27th',twentyseventh,27).
ordinal2('28th',twentyeighth,28). 
ordinal2('29th',twentyninth,29).  
ordinal2('30th',thirtieth,30).  
ordinal2('31st',thirtyfirst,31).  ordinal2('31th',thirtyfirst,31).  


numerid(none,0).
numerid(zero,0).
numerid(one,1).
numerid(two,2).
numerid(three,3).
numerid(four,4).
numerid(five,5).
numerid(six,6).
numerid(seven,7).
numerid(eight,8).
numerid(nine,9).
numerid(ten,10).
numerid(eleven,11).
numerid(twelve,12).
numerid(thirteen,13).
numerid(fourteen,14).
numerid(fifteen,15).
numerid(sixteen,16).
numerid(seventeen,17).
numerid(eighteen,18).
numerid(nineteen,19).
numerid(twenty,20).
                            %% covered by tallmorph ?
numerid(twentyone,21).
numerid(twentytwo,22).
numerid(twentythree,23).
numerid(twentyfour,24).
numerid(twentyfive,25).
numerid(twentysix,26). 
numerid(twentyseven,27).
numerid(twentyeight,28).
numerid(twentynine,29).
numerid(thirty,30).
numerid(thirtyone,31).
numerid(thirtytwo,32).
numerid(thirtythree,33).
numerid(thirtyfour,34).
numerid(thirtyfive,35).
numerid(thirtysix,36).
numerid(thirtyseven,37).
numerid(thirtyeight,38).
numerid(thirtynine,39).
numerid(forty,40).
numerid(fortyone,41).
numerid(fortytwo,42).
numerid(fortythree,43).
numerid(fortyfour,44).
numerid(fortyfive,45).
numerid(fortysix,46).
numerid(fortyseven,47).
numerid(fortyeight,48).
numerid(fortynine,49).
numerid(fifty,50).
numerid(fiftyone,51).
numerid(fiftytwo,52).
numerid(fiftythree,53).
numerid(fiftyfour,54).
numerid(fiftyfive,55).
numerid(fiftysix,56).
numerid(fiftyseven,57).
numerid(fiftyeight,58).
numerid(fiftynine,59).
numerid(sixty,60).
numerid(sixtyone,61).
numerid(sixtytwo,62).
numerid(sixtythree,63).
numerid(sixtyfour,64).
numerid(sixtyfive,65).
numerid(sixtysix,66).
numerid(sixtyseven,67).
numerid(sixtyeight,68).
numerid(sixtynine,69).
numerid(seventy,70).
numerid(seventyone,71).
numerid(seventytwo,72).
numerid(seventythree,73).
numerid(seventyfour,74).
numerid(seventyfive,75).
numerid(seventysix,76).
numerid(seventyseven,77).
numerid(seventyeight,78).
numerid(seventynine,79).
numerid(eighty,80).
numerid(eightyone,81).
numerid(eightytwo,82).
numerid(eightythree,83).
numerid(eightyfour,84).
numerid(eightyfive,85).
numerid(eightysix,86).
numerid(eightyseven,87).
numerid(eightyeight,88).
numerid(eightynine,89).
numerid(ninety,90).
numerid(ninetyone,91).
numerid(ninetytwo,92).
numerid(ninetythree,93).
numerid(ninetyfour,94).
numerid(ninetyfive,95).
numerid(ninetysix,96).
numerid(ninetyseven,97).
numerid(ninetyeight,98).
numerid(ninetynine,99).
numerid(hundred,100).
numerid(thousand,1000).
numerid(million,1000000). 

numerid(noon,1200).     % Sort of...
numerid(midnight,2400).

%% the patient died when she lived

pronoun(X):-pronoun(X,_).  

pronoun(he,man).  
pronoun(her,woman). 
pronoun(herself,woman).
pronoun(him,man).
pronoun(himself,man).

pronoun(itself,thing). 
pronoun(she,woman).  

pronoun(them,thing).     
pronoun(they,thing).      
pronoun(themselves,thing). 

pronoun(i,self).  
pronoun(you,program). %% (trans dependent on tuc isa program)


%%%%% THE END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
