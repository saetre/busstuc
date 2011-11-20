%% FILE dict_n.pl
%% SYSTEM BUSSTUC/BUSTER
%% CREATED TA-930601
%% REVISED JB-970312  TA-110824
%% TUC Dictionary for the language N

:-module(dict_n,[]). 

%�������������������������������������������������
% sp     spell error (unintended) ,not inflectable
% spiw   incorrect  writing (intended), inflectable
% repair repair (without deletion)
% dial   dialect
% haz    hazardous (may cause wrong parse)
% own    inauthentic  error
% actual occurred, with that interpretation
% rough  imprecise, but gives an adequate (negative?) response
% slip   key  error
% neib   key neighbour error
% nec    necessary (surprisingly)
% ?      dubious (facetious)
%�������������������������������������������������



% Prelexical translations

% rewording    List -> List, drop alternatives
% splitword    Word -> List, drop alternatives
% xcompword    List -> Word, drop alternatives
% compword     List -> Word, keep alternatives
% synword      Word -> Word, keep alternatives


%%�  REWORDING 
 
 %% Use only for context dependent rewriting
 %% Use with extreme care if synword,compword,splitword is futile

%--
   rewording([1,t],[1,time]).  %% TA-110617  Ad Hoc -> N
   rewording([2,t],[2,timer]). %% 
   rewording([3,t],[3,timer]). %% 

   rewording([bare,�],            [mulig,�]).       %% TA-110111
   rewording([beste,buss],        [neste,buss ]).   
   rewording([buss,dra],          [buss,fra ]).
   rewording([bussen,dra],        [bussen,fra ]). 
   rewording([b�r,m�],            [n�r,m� ]).       %% b�r=n�r|g�r

   rewording([det,ekle],[det,d�rlige]). %% \+ Ekle %% TA-101108  

   rewording([dvs,'.'],[dvs]). %% Tricky %% TA-110304
 
   rewording([det,rare,er],       [det,er,rart ]).  
%%    rewording([er,det,til],        [er,det,inntil ]).   %% TA-100825 til dragvoll
   rewording([er,hyppig,forekommende], [skjer,ofte ]). %% 
    
   rewording([er,stavet],[er,skrevet]). %% \+ Stavset %% TA-110808


   rewording([feiler,det],[er,feil,med]).  %% TA-101103 hva er feil med deg

   rewording([for,kl],            [f�r,kl ]).  %% for kl 11 \+ for (rute) 11
   rewording([for,klokken],       [f�r,kl ]). 
   rewording([for,klokken],       [f�r,kl ]). 

   rewording([for,�,v�re],        [for,�,v�re ]). 
   rewording([for,a,v�re],        [for,�,v�re ]).           %% TA-100921

   rewording([f�ler,jeg,meg],     [er,jeg]). %% ..sikker p� %% TA-101025   
   rewording([g�,til,fradrag],    [v�re,inkludert ]).   

   rewording([g�r,fordi],         [g�r,forbi ]). 

   rewording([ha,v�rt,p�],    [komme,til]). %% skulle gjerne ha v�rt.. %% rough %% TA-101022

   rewording([han,du],[kan,du]). %% TA-110201 own

   rewording([hvilken,er],    [hva,er]). %% TA-100829
   rewording([hvilket,er],    [hva,er]). %% 

   rewording([hvor,langt,tar],    [hvor,lang,tid,tar]). 

%%    rewording([i,dette,tilfelle],  [som,er]).   %% etc. %% TA-110807

   rewording([i,ett,tida],        [rundt,kl,1300]). 
   rewording([i,ett,tiden],       [rundt,kl,1300]).  %% fix

   rewording([ifb,med,'.'],  [i,forbindelse,med ]).
   rewording([ifm,'.'],      [i,forbindelse,med ]). 
   rewording([i,forb,'.',m], [i,forbindelse,med ]). 
   rewording([i,forb,m],     [i,forbindelse,med ]).  

%%%%%   rewording([jeg,n�r],           [jeg,rekker ]).    %% TA-100923
%% hva gj�r jeg n�r ...

   rewording([kan,skyldes],       [er,for�rsaket,av ]). %% before skyldes =
   rewording([kommer,jeg,til,�],  [vil,jeg]). %%  hva kommer jeg til  � bli

   rewording([nr,g�r],            [n�r,g�r ]).  
   rewording([nr,m�],             [n�r,m� ]).
  
   rewording([n�r,g�r],           [n�r,g�r]).       %% TA-110116
   rewording([n�r,har,bussen],    [n�r,g�r,bussen ]). 
   rewording([n�r,jeg,tar,bussen], [n�r,g�r,bussen ]).  %%  Haz
             
   rewording([og,retur],          [og,tilbake ]).

   rewording([over,halvparten],   [de,fleste ]). 
                                               %% only from start
   rewording([p�,jeg,ta],         [m�,jeg,ta ]).        %%   n�r ... bussen                    
   rewording([s,buss],            [siste,buss ]).       %% TA-100825
   rewording([sa,jeg,er],         [s�,jeg,er ]).   
   rewording([skal,med],          [skal,reise,med ]).   %% TA-100902
   rewording([straks,dette],      [n�r,dette ]).  
   rewording([s�,derfor],         [fordi,da]).          %% TA-110105 rough
   rewording([s�,n�ye],[]).                             %% TA-110105
   rewording([st�r,oppf�rt,med],  [har]).               %% TA-101115 ad hoc

 /*
   rewording([ta,vare,p�],[beholde]).    %% TA-110816
   rewording([tar,vare,p�],[beholder]).  %%
   rewording([tok,vare,p�],[beholdt]).   %%
   rewording([tatt,vare,p�],[beholdt]).  %%
*/

   rewording([ta,til],[g�,til]). %% .. venstre
   rewording([ta,utgangspunkt],[starte]).   %% ad hoc %% TA-101115 overgangen vil ta utgangspunkt .
   rewording([tar,utgangspunkt],[starter]). %%

   rewording([ti,minutter],       [10,minutter ]). %% ti =til/tid %% TA-100912

   rewording([til,buen],[til,byen]). %% Anders buens vei %% TA-110204 

%%    rewording([tid,g�r],           [n�r,g�r ]). %%  hva tid g�r

   rewording([t,buss],            [ta,buss ]). 

   rewording([tre,i,kraft],[starte]). %% TA-101108 problem tre=3

   rewording([vil,vekk],          [vil,reise,vekk]). %% TA-100902
   rewording([visst,jeg],         [hvis,jeg]). %% trouble visst=redundantly 

   rewording([v�re,at],[bli,at]). %% ad hoc fedup %% TA-110810

   rewording([�,svar],            [�,svare]).  %% trouble svar=noun|verb
   

%--

%% No general rewrite rules (List -> List)  (Precaution)


% Numeric (digits are flexible)
% sorted on 1. alphabetic

%% splitword ('19og20',    [19,og,20]). 


%%  Unnnec %% Automatic  SPLIT NNAA 
%%  Unnnec %% Automatic  SPLIT AANN 

%% splitword only for common words couples , no names.


%%%%%%% splitword can also be used as  pre-synword substitution
%% simplifies compword definitions which has no synning
%% Destructive

%% Single splitword 1

split('+',[pluss]). %% TA-100902

splitword(null,[0]).   
%%  splitword(en,[1]).   %% no  en buss
%%  splitword(et,[1]).   %% 

%% splitword(ett,[1]).   %% ett hotell

%% splitword(to,[2]).    %% n�r m� jeg to bussen 
splitword(tre,[3]).   
splitword(fire,[4]).
splitword(fem,[5]).
splitword(seks,[6]).
splitword(sju,[7]).
splitword(�tte,[8]).
splitword(ni,[9]). %% Ni muser -> 9 muser

splitword(bortimot,[nesten]).  
splitword(busen,[bussen]).
splitword(fa�r,[f�r]).          %% simplifies compword   %% før

splitword(faa,[f�]).            %% TA-100918
splitword(faatt,[f�tt]).  

splitword(fkl,[fra,kl]).  
splitword(frem,[fram]).         %% NB fram is official, avoid  
splitword(framme,[fremme]).     %% NB fremme is official (?)     

splitword(gaar,[g�r]). 
splitword(gan,[gang]).          %% TA-110324
splitword(gar,[g�r]). 
splitword(gayr,[g�r]).          %% simplifies compword  
splitword(greitt,[greit]). 
splitword(heile,[hele]).  

splitword(ifjor,[i,fjor]).  
splitword(igjenn,[igjen]).      %% TA-110121
splitword(in,[inn]). 
splitword(intil,[inntil]). 
splitword(jag,jeg). 
splitword(kjappast,[hurtigst]).
splitword(kjappest,[hurtigst]). %%
splitword(km,[kilometer]).
splitword(may,[m�]).            %% må
splitword(mig,meg).  
%% splitword(morra,[morgen]).   %%  amb morrow/morning
splitword(muligt,[mulig]). 
splitword(naa,[n�]). 
splitword(naar,[n�r]).   
splitword(nar,[n�r]).  
splitword(nayr,[n�r]).
splitword(nedi,[ned,i]). 
splitword(neri,[ned,i]).  
splitword(nermeste,[n�rmeste]). 
splitword(nyttigj�re,[nyttiggj�re]).
%% splitword(noke,[noe]).       %% cuts noke=noen
splitword(paa,[p�]).   
splitword(pay,[p�]). 
splitword(pensjoneres,[pensjonere,seg]). %% TA-100821 // inf|pres
splitword(poske,[p�ske]).  
splitword(raskes,[raskest]). 
splitword(rote,[rute]).   
splitword(roter,[ruter]). 
splitword(sj�f�r,sj�f�r).       %% TA-110324
splitword(slute,[slutte]).      %% involved in compwords
splitword(smaa,sm�).  
splitword(s�,[seg]).
splitword(tillfelle,[tilfelle]).
splitword(turretur,[retur]).    %% rough 
splitword(untak,[unntak]). 
splitword(utenbys,[utenfor,byen]). 
splitword(ut�ver,[utover]).  
%% splitword(vert,[blir]).   %% ~~ v�rt      %% NN (haz? en vert)   
%% splitword(vor,[for]).           %% TA-10119=hvor
splitword('va|re',[v�re]). 
splitword(vaere,[v�re]).    
splitword(�re,[v�re]). 
splitword(�yblikket,[�yeblikket]). %% actual %% TA-101123
splitword(�p,[p�]).   


%% Composite splitword 2

splitword(avgangerp�,[avganger,p�]).  
%% splitword(hjem,[fra,nth,til,nardo]). %% FREAK 
%%  splitword(andreneste,[andre,neste]). 
splitword(ankommerf�r,[ankommer,f�r]).
splitword(ankomstkl,[ankomst,klokken]). 
splitword(an�,[an,�]).  
splitword(atden,[at,den]).  
splitword(atjeg,[at,jeg]). 
splitword(avgangerhar,[avganger,har]). 
splitword(busfra,[buss,fra]). 
splitword(bussemfra,[bussen,fra]).     %% etc ???
splitword(busseneste,[buss,neste]).  
splitword(bussenetter,[bussen,etter]).  
splitword(bussenefra,[bussene,fra]).  
splitword(bussenfra,[buss,fra]). 
splitword(bussenn�r,[bussen,n�r]). 
splitword(bussenskal,[bussen,skal]). %%  own
splitword(bussentil,[bussen,til]).
splitword(bussen�,[bussen,�]).  
splitword(busserfra,[busser,fra]).  
splitword(bussertil,[bussen,til]).  
splitword(bussetter,[buss,etter]). 
splitword(bussfra,[buss,fra]). 
splitword(bussffra,[buss,fra]).  
splitword(bussg�r,[buss,g�r]). 
splitword(bussholdeplassligger,[bussholdeplass,ligger]).
splitword(bussifra,[buss,fra]). 
splitword(bussinn,[buss,inn]). 
splitword(busskan,[buss,kan]).   
splitword(bussm�,[buss,m�]). 
splitword(bussrundt,[buss,rundt]). 
splitword(busstil,[buss,til]). 
splitword(byenca,[byen,ca]). 
splitword(byenfra,[byen,fra]).    
splitword(byenfor,[byen,for]).  
splitword(byeninnen,[byen,innen]). 
splitword(byenklokken,[byen,klokken]).  
splitword(byentil,[byen,til]).  
splitword(bytil,[by,til]). 

splitword(dagetter,   [dag,etter]).
splitword(dagfra,     [dag,fra]).  
splitword(deif�rste,  [de,f�rste]). 
splitword(densom,     [den,som]).  

splitword(derkl, [der,kl]). 
splitword(derklokka, [der,kl]).  %% splitword(detbuss,    [det,buss]).  
splitword(derklokken, [der,kl]).

splitword(deter,      [det,er]). 
splitword(detnattbuss,[det,nattbuss]).  
splitword(direktebuss,[direkte,buss]). 
splitword(direktebusser,[direkte,busser]).
splitword(direktelinje,[direkte,linje]).
splitword(dragvollbussen,[bussen,til,dragvoll]).
splitword(drarfra,[drar,fra]).  
splitword(dugj�re,[du,gj�re]). 

%% splitword(dvs,[og]).           %% bussen g�r dvs trikken st�r
%% splitword(dvs,[som,er]).       %% rough 
%% splitword(dvs,[og,dette,er]). 

%% splitword(nemlig,[som,er]).  %% jeg begynner nemlig

splitword(egta,[jeg,ta]).  
splitword(ekje,[er,ikke]). 
splitword(enbuss,[en,buss]).
splitword(erbuss,[er,buss]).
splitword(erde,[er,det]). 
splitword(erder,[er,der]).
splitword(erdet,[er,det]).
splitword(erdu,[er,du]).
splitword(ere,[er,det]). 
splitword(erfra,[er,fra]).
splitword(erikke,[er,ikke]). 
splitword(erjeg,[er,jeg]). 
splitword(erklokka,[er,klokka]). 
splitword(erp�,[er,p�]).  
splitword(erru,[er,du]). 
splitword(eru,[er,du]). 
splitword(etterkl,[etter,klokken]). 
splitword(etterklokka,[etter,klokken]). 
splitword(etterklokken,[etter,klokken]).
splitword(eterkl,[etter,klokken]). 
splitword(ettermiddagsruter,[ruter,om,ettermiddagen]). 
splitword(etterti,    [etter,10]).  

splitword(femmern,[buss,5]). %% etc avoid 5 as 1. word
splitword(finnesp�,[finnes,p�]).  
splitword(fint�,[fint,�]).     
splitword(flyfra,[fly,fra]). 
splitword(foray,[for,�]).                %%  forå
splitword(forbussen,[for,bussen]).  
splitword(foreksempel,[for,eksempel]).   %% noise ???
splitword(formiddagsrute,[rute,om,formiddagen]). 
splitword(forrigebuss,[forrige,buss]). 
splitword(for�,[for,�]). 
splitword(for�v�re,[for,�,v�re]).  
splitword(frabyen,[fra,byen]).  
splitword(frasamfundet,[fra,samfundet]).
   splitword(samfundetetter,[samfundet,etter]).
   splitword(samfundetkl,[samfundet,klokken]).
   splitword(samfundetf�r,[samfundet,f�r]).
   splitword(samfundettil,[samfundet,til]).
splitword(frasentrum,[fra,sentrum]). 
splitword(fratorget,[fra,torget]).
splitword(fratorvet,[fra,torget]).
splitword(fratr,[fra,trondheim]). 
splitword(fratrondheim,[fra,trondheim]). 
splitword(frai,[fra,i]). 
splitword(fraklokken,[fra,klokken]).  
splitword(fremmef�r,[fremme,f�r]).
splitword(f�rmandag,[f�r,mandag]).       %%  ETC 
splitword(f�rsebuss,[f�rste,buss]).      %% sp
splitword(f�rstebuss,[f�rste,buss]).  
splitword(f�rstebussen,[f�rste,buss]). 
splitword(f�rstep�ske,[f�rste,p�ske]). 

splitword(gateetter,[gate,etter]). 
splitword(gatefor,[gate,for]).
splitword(gatekl,[gate,klokken]).
splitword(gateklokken,[gate,klokken]).  
splitword(gatemellom,[gate,mellom]).   
splitword(gatesom,[gate,som]).  
splitword(gatetil,[gate,til]).    
splitword(gayrbussen,[g�r,bussen]). %% TA-110103  gårbussen
splitword(gl�setter,[gl�shaugen,etter]).  %% ?
splitword(gn,[g�r,neste]).
splitword(gneste,[g�r,neste]). 
splitword(godmorgen,[god,morgen]). 
splitword(g�rbuss,[g�r,buss]).   
splitword(g�rdetter,[g�r,det,etter]). 
splitword(g�rflere,[g�r,flere]). 
splitword(g�rf�rste,[g�r,f�rste]).  
splitword(g�rf�rst,[g�r,f�rste]).
splitword(g�rinnom,[g�r,innom]). 
splitword(g�rlinje,[g�r,neste]).  
splitword(g�rneste,[g�r,neste]).  
splitword(g�rnetste,[g�r,neste]). %% sp 
splitword(g�rnestebuss,[g�r,neste,buss]).
splitword(g�rn�rmest,[g�r,n�rmest]).  
splitword(g�rre,[g�r,det]). 
splitword(g�rsiste,[g�r,siste]). 
splitword(g�rbuss,[g�r,buss]). 
splitword(g�rbussen,[g�r,bussen]).  
splitword(g�ste,[g�r,neste]).  

splitword(hadu,[har,du]). 
splitword(hardu,[har,du]).  
splitword(haru,[har,du]).  %% dial
splitword(harnoen,[har,noen]).  
splitword(harru,[har,du]). 
splitword(heledagen,[hele,dagen]).  
splitword(helligdagrutetider,[ruter,p�,helligdager]). %% ! 
splitword(helligdagsrutetider,[ruter,p�,helligdager]). 
splitword(heligdagrutetider,[ruter,p�,helligdager]). 
splitword(heligdagsrutetider,[ruter,p�,helligdager]).
splitword(holdeplassfor,[holdeplass,for]). 
splitword(holdeplasstil,[holdeplass,til]).   
splitword(hvaer,[hva,er]). 
splitword(hvaheter,[hva,heter]).  
splitword(hvakoster,[hva,koster]). 
splitword(hvemer,[hvem,er]). 
splitword(hvilkebusser,[hvilke,busser]). 
splitword(hvilkenbuss,[hvilken,buss]).  
splitword(hvisjeg,[hvis,jeg]). 
splitword(hvordang�r,[hvordan,g�r]). 
splitword(hvorlang,[hvor,lang]).         %% tid ..
splitword(hvorlenge,[hvor,lenge]). 
splitword(hvormange,[hvor,mange]).  
splitword(hvorofte,[hvor,ofte]).  
splitword(hvorskal,[hvor,skal]).

splitword(idet,[i,det]). 

splitword(ifb,[i,forbindelse,med]).  %%  i forbindelse med // problem
splitword(ifbm,[i,forbindelse,med]). %%

splitword(ifm,[i,forbindelse,med]).  %% 
splitword(ibyen,[i,byen]).  
splitword(ikeabussen,[buss,til,ikea]). %% Ad Hoc (tt)
splitword(ikeabuss,[buss,til,ikea]).  
splitword(imeg,[i,meg]).  
splitword(innenkl,[innen,klokken]).  
splitword(innenklokka,[innen,klokken]). 
splitword(innenklokken,[innen,klokken]). 
splitword(il�pet,[i,l�pet]).   
splitword(imorgenetter,[imorgen,etter]).
splitword(imorgentidlig,[imorgen,tidlig]). 
splitword(irute,[i,rute]). 
splitword(isentrum,[i,sentrum]).  
splitword(istf,[i,stedet,for]). 
splitword(itrondheim,[i,trondheim]). 

splitword(januarsenest,[januar,senest]). %% ?
splitword(jegdra,[jeg,dra]).   
splitword(jeger,[jeg,er]).    
splitword(jegsp�r,[jeg,sp�r]). 
splitword(jegta,[jeg,ta]).  
splitword(jegvil,[jeg,vil]).  
splitword(julerutetider,[ruter,i,jula]). %% ! 
%% splitword(juleruter,[ruter,i,jula]).  %% chr...
%% splitword(julruter,[ruter,i,jula]). 

splitword(kanf�, [kan,f�]).  
splitword(kanjeg, [kan,jeg]).  
splitword(kinofor,[kino,for]).     
splitword(kinokl, [kino,kl]).   
splitword(kommemeg,   [komme,meg]).  
splitword(kommetil,   [komme,til]).  
splitword(kommertil,   [kommer,til]).  
splitword(kommerjeg,  [kommer,jeg]). 
splitword(klokkahalv,[klokka,halv]).
splitword(kosteren,   [koster,en]). 
splitword(kvabuss,[kva,buss]).  

splitword(kveldsavgang,[avgang,om,kvelden]).       %% ad hoc 
splitword(kveldsavgangen,[avgangen,om,kvelden]).   %% 
splitword(kveldsavganger,[avganger,om,kvelden]).   %%
splitword(kveldsavgangene,[avgangene,om,kvelden]). %%

splitword(kveldtil,[kveld,til]).  

splitword(langtid,[lang,tid]).  
splitword(lillejul,[lille,jul]). %% ... aften
splitword(lillejuleaften,[lille,julaften]). 
splitword(lopet,l�pet).   %% TA-101215
splitword(l�rdagf�r,[l�rdag,f�r]).       %% etc 
splitword(l�rdagnatt,[l�rdag,natt]). 

splitword(l�rdagsbuss,   [buss,p�,l�rdag]). 
splitword(l�rdagsbussen, [buss,p�,l�rdag]). 
splitword(l�rdagsbusser, [buss,p�,l�rdag]). 
splitword(l�rdagsbussene,[buss,p�,l�rdag]).
splitword(l�rdagsformiddag,[l�rdag,formiddag]).
splitword(l�rdagsvis,[om,l�rdager]). %% !

splitword(nayrmay,[n�r,m�]). 
splitword(nbf,[neste,buss,fra]).  
splitword(nordtil,[nord,til]). 
splitword(opptur,[tur,opp]). 

splitword(l�rdagsnatt,[l�rdag,natt]).       %%  smtotfl /s
splitword(l�rdagnatta,[l�rdag,natt]).
splitword(l�rdagsnatten,[l�rdag,natt]).
splitword(l�rdagsruta,[ruten,p�,l�rdag]).  

%% splitword(l�rdagsrute,[rute,p�,l�dag]). %% Concept

splitword(l�rdagsruten,[ruten,p�,l�rdag]).   %%
splitword(l�rdagsrutene,[ruten,p�,l�rdag]).  %%


splitword(sanntidsinfo,[informasjon,om,forsinkelser]).        %% TA-110309
splitword(sanntidsinformasjon,[informasjon,om,forsinkelser]). %% TA-101013

% ...

splitword(mandagden, [mandag,den]). 
splitword(tirsdagden,[tirsdag,den]).
splitword(onsdagden, [onsdag,den]). 
splitword(torsdagden,[torsdag,den]). 
splitword(fredagden, [fredag,den]). 
splitword(l�rdagden, [l�rdag,den]). 
splitword(s�ndagden, [s�ndag,den]).  

splitword(mandagklokken, [mandag,klokken]).  
splitword(tirsdagklokken,[tirsdag,klokken]). 
splitword(onsdagklokken, [onsdag,klokken]). 
splitword(torsdagklokken,[torsdag,klokken]).
splitword(fredagklokken, [fredag,klokken]). 
splitword(l�rdagklokken, [l�rdag,klokken]). 
splitword(s�ndagklokken, [s�ndag,klokken]). 

%% etc kl ,  klokka, 

splitword(s�ndagsbuss,   [buss,p�,s�ndag]). 
splitword(s�ndagsbussen, [buss,p�,s�ndag]).
splitword(s�ndagsbusser, [buss,p�,s�ndag]).
splitword(s�ndagsbussene,[buss,p�,s�ndag]). 
splitword(s�ndagsformiddag,[s�ndag,formiddag]). 

splitword(fredagsettermiddag,[fredag,ettermiddag]).   %%  smtotfl /s
% ...

splitword(fredagkvelden,[fredag,kveld]).   %%  smtotfl /s
splitword(fredagskveld,[fredag,kveld]).
splitword(fredagskvelden,[fredag,kveld]).  
% ...

splitword(fredagsnatt,[fredag,natt]).  %%  smtotfl /s
splitword(l�rdagsnatt,[l�rdag,natt]).  

splitword(fredagsnatta,[fredag,natt]).  %%  smtotfl /s
splitword(l�rdagsnatta,[l�rdag,natt]).  


splitword(fredagsnatten,[fredag,natt]).  %%  smtotfl /s
splitword(l�rdagsnatten,[l�rdag,natt]).  

splitword(mandagmorgen,[mandag,morgen]).  %% smtotfl /s %% Most typical
splitword(mandagskveld,[mandag,kveld]).
splitword(mandagsmorgen,[mandag,morgen]). %% smtotfl /s
splitword(mandagsformiddag,[mandag,formiddag]).
% ...
splitword(junikl,  [juni,kl]).
splitword(julikl,  [juli,kl]).

splitword(mangedager,[mange,dager]).  
splitword(manp�,  [man,p�]).  

splitword(marskl,  [mars,kl]). %% etc
splitword(maikl,   [mai,kl]).
splitword(maikl,   [mai,kl]).

splitword(megfra,[meg,fra]). 
splitword(midtbyenklokken,[midtbyen,klokken]). 

splitword(morgenavganger,[avganger,om,morgenen]). 
splitword(morgenetter,[morgen,etter]).  
splitword(morgenettermiddag,[morgen,ettermiddag]). 
splitword(morgenfra,[morgen,fra]). 
splitword(morgenf�r,[morgen,f�r]). 
splitword(morgeng�r,[morgen,g�r]). %% TA-100823
splitword(morgenkveld,[morgen,kveld]). 
splitword(morgenrundt,[morgen,rundt]).
splitword(morraf�r,[morgen,f�r]).  


splitword(munkegatakl,[munkegata,klokken]).
splitword(munkegatatil,[munkegata,til]). 

splitword(m�eg,[m�,jeg]).
splitword(m�jeg,[m�,jeg]).
splitword(m�nedlig,[hver,m�ned]).
splitword(m�jeg,   [m�,jeg]).  
   splitword(n�jeg,   [m�,jeg]). 

splitword(nattkl,[natt,kl]).   
splitword(nattakst,[takst,for,nattbuss]). 
splitword(nayrgayr,[n�r,g�r]).    
splitword(nestebus,[neste,buss]). 
splitword(nestebuss,[neste,buss]). 
splitword(nestebussen,[neste,buss]). 
splitword(nestebussene,[neste,bussene]).
splitword(nestebusser,[neste,busser]). 
splitword(nesteavgang,[neste,avgang]). 
splitword(nesteavganger,[neste,avganger]). 
splitword(nesteavgangen,[neste,avgangen]). 
splitword(nesteavgangene,[neste,avgangene]).
splitword(nestebusser,[neste,busser]). 
splitword(nestefra,[neste,fra]). 
splitword(nestegang,[neste,gang]).  
splitword(nestenr,[neste,nr]).
splitword(nestesiste,[nest,siste]). 
splitword(nestetrikk,[neste,trikk]). 
splitword(nestenbuss,[neste,buss]).
splitword(nestneste,[andre,neste]).
splitword(nestnestsiste,[andre,siste]).
splitword(nestnestnestsiste,[tredje,siste]). 
splitword(ng,[n�r,g�r]). 
splitword(nifra,[9,fra]).    %% ?
splitword(niog,[ni,og]).     %% ?
splitword(n�rg�r,[n�r,g�r]).  
splitword(n�rmestebusstopp,[n�rmeste,busstopp]). 
splitword(n�m�,[n�,m�]).  
splitword(n�r�,[n�r,m�]). 
splitword(n�rbg�r,[n�r,g�r]).
splitword(n�rg�,[n�r,g�r]).
splitword(n�rg�r,[n�r,g�r]).  
splitword(n�rg�rdet,[n�r,g�r,det]). 
splitword(n�rg�rbuss,[n�r,g�r,buss]). 
splitword(n�rg�rneste,[n�r,g�r,neste]).
splitword(n�rjeg,[n�r,jeg]).  
splitword(n�rkan,[n�r,kan]). 
splitword(n�rkommer,[n�r,kommer]). 
splitword(n�rm�,[n�r,m�]).  
splitword(n�rm�jeg,[n�r,m�,jeg]). 
splitword(n�rneste,[n�r,neste]). 
splitword(n�rng�r,[n�r,g�r]).  
splitword(n�rpasser,[n�r,passerer]).    %%  sp
splitword(n�rpasserer,[n�r,passerer]).  %%
splitword(n�rp�,[n�r,p�]).  
splitword(n�rsentrum,[n�r,sentrum]). 

splitword(omsentrum,[forbi,sentrum]).  %% sic
splitword(overneste,[andre,neste]).    %% sic 
splitword(ogfra,       [og,fra]).  
splitword(ogklokken,   [og,klokken]).  
%% splitword(ogs�,        [og,s�]).  %% noise|[]
splitword(overett,    [over,ett]).    
splitword(overto,    [over,to]).  
splitword(overtre,    [over,tre]). 
splitword(overfire,    [over,fire]). 
splitword(overfem,    [over,fem]). 
splitword(overseks,    [over,seks]). 
splitword(oversju,    [over,sju]). 
splitword(over�tte,    [over,�tte]).  
splitword(overni,    [over,ni]).
splitword(overti,    [over,ti]).
splitword(overelve,    [over,elve]).
splitword(overtolv,    [over,tolv]).

splitword(passererneste,[passerer,neste]).
splitword(p�hverdager, [p�,hverdager]). 
splitword(p�stasjonen, [p�,stasjonen]).  
splitword(p�togstasjonen, [p�,togstasjonen]). 

splitword(p�sju,[p�,klokken,7]). %% etc

splitword(raskestmulig,  [raskest,mulig]). 
splitword(retursentrum,  [retur,sentrum]).   
splitword(returtrondheim,[retur,trondheim]). 
splitword(rundtkl,       [rundt,klokken]).  

splitword(seint,[sent]).   
splitword(senast,[senest]). %% sw, pre lex for compword 
splitword(senets,[senest]). 

%��

splitword(senteretkl,  [senteret,klokken]).  
splitword(senterkl,  [senter,klokken]). 
splitword(senteretklokken,  [senteret,klokken]). 
splitword(senterklokken,  [senter,klokken]).
splitword(sentretkl,   [senteret,klokken]).
splitword(sentretklokken,   [senteret,klokken]).

splitword(sentralstasjonkl,[sentralstasjon,kl]). 
splitword(sentrumetter,[sentrum,etter]).  
splitword(sentrumfor,  [sentrum,for]).  
splitword(sentrumforbi,  [sentrum,forbi]).
splitword(sentrumfra,  [sentrum,fra]). %% TA-100927
splitword(sentrumf�r,  [sentrum,f�r]). 
splitword(sentruminnen,[sentrum,innen]).
splitword(sentrumkl,   [sentrum,kl]).  
splitword(sentruml�rdag,[sentrum,l�rdag]). %% etc
splitword(sentrums�ndag,[sentrum,l�rdag]).
splitword(sentrummed,  [sentrum,med]).  
splitword(sentrumom,   [sentrum,om]).   
splitword(sentrump�,   [sentrum,p�]).  
splitword(sentrumrundt,[sentrum,rundt]). 
splitword(sentrumsbussen,[buss,forbi,sentrum]).
splitword(sentrumtil,[sentrum,til]). 

splitword(sistebuss,   [siste,buss]).
splitword(sisstebussen,[siste,buss]). 
splitword(sistebussen, [siste,buss]).
splitword(skalfra,     [skal,fra]).  
splitword(skaltil,     [skal,til]).   
splitword(skalreise,   [skal,reise]). 
splitword(skalv�re,    [skal,v�re]).  
splitword(skoleetter,  [skole,etter]). 
splitword(skolekl,     [skole,kl]).  
splitword(skoletil,    [skole,til]).  

splitword(skyldes, [er,for�rsaket,av]).  %%  kan skyldes etc
splitword(skyldtes,[var,for�rsaket,av]). %% NB kan skyldes = rewording/

%% splitword(slikt,       [slike,ting]). %%  finn et slikt tidspunkt
splitword(slikat,      [slik,at]). 

%% splitword(snakkes,      [snakker,sammen]).   %% hilsen %% TA-110310
splitword(samsnakkes,   [snakker,sammen]). 
splitword(somg�r,       [som,g�r]). 

splitword(samfunnet, [samfundet]). %% TA-110314
splitword(sanfundet, [samfundet]). %%


splitword(stasjonkl,    [stasjon,kl]). 
splitword(stasjonenetter, [stasjonen,etter]). 
splitword(studentbyfor, [studentby,for]). 
splitword(studentbytil, [studentby,til]). 
splitword(sydtil,       [syd,til]).  
splitword(s�ndagfra,    [s�ndag,fra]). 
splitword(s�ndagmorgen,   [s�ndag,morgen]). 

splitword(tabuss,[ta,buss]).  
splitword(tabussen,[ta,bussen]).   
splitword(tabbussen,[ta,bussen]). %% sp 
splitword(tafor,[ta,for]). 
splitword(tafra,[ta,fra]).  
splitword(tare,[tar,det]).   
splitword(tatil,[ta,til]). 
splitword(telefonentil,[telefonen,til]).
splitword(tidenimorgen,[tiden,imorgen]).
splitword(tiderg�r,[tider,g�r]). 
splitword(tilbyen,[til,byen]).
splitword(tildette,[til,dette]). 
splitword(tilen,  [til,en]).  
splitword(tilfull,  [til,full]).  %% ?
splitword(tilog,  [til,og]).      %% ..med
splitword(tilkl,[til,kl]). 
splitword(tilklokka,[til,kl]). 
splitword(tilklokkwn,[til,kl]). 
splitword(tilmidtbyen,[til,midtbyen]). 
splitword(tilrette,[til,rette]).
splitword(tilsentralstasjonen,[til,sentralstasjonen]).
splitword(tilsentrum,[til,sentrum]). 
splitword(tiltrondheim,[til,trondheim]).
splitword(til�,[til,�]). 
splitword(tip�,[ti,p�]).  
splitword(tirsdagmellom,[tirsdag,mellom]). %% etc
splitword(tirsdagmorgen,[tirsdag,morgen]).
splitword(tirsdagetter,[tirsdag,etter]).   %% etc etc
splitword(togfra,[tog,fra]).  
splitword(togtil,[tog,til]).  
splitword(togtas,[tog,tas]).  
splitword(torgetden,[torget,den]). 
splitword(torgetf�r,[torget,f�r]).   
splitword(torgetkl,[torget,kl]).   
splitword(torvetden,[torvet,den]).  
splitword(trafikkn�r,trafikkn�r).   
splitword(tredjenest,[tredje,neste]). 
splitword(treneste,[tre,neste]).  
splitword(trikkfra,[trikk,fra]). 
splitword(trikketur,[tur,med,trikk]). %% ?
splitword(trondheimtil,[trondheim,til]). 
splitword(trondheimetter,[trondheim,etter]).
splitword(trondheimn�r,[trondheim,n�r]). 

%% splitword(turingtesten,[turings,test]). 

splitword(uoppfordret,[uten,oppfordring]).
splitword(utav,[ut,av]). 

%% splitword(vare,[v�re]). %%  pre lex for compword 

splitword(varriktig,[var,riktig]). 

%% splitword(varsle10,[varsle,10]). 
splitword(vegetter,[veg,etter]).  
splitword(vegfor,[veg,for]). 
splitword(vegkl,[vei,kl]). 
splitword(vegtil,[veg,til]). 
splitword(veietter,[vei,etter]).  
splitword(veifor,[vei,for]). 
splitword(veikl,[vei,kl]).   
splitword(veiklokken,[vei,klokken]).  
splitword(veimed,[vei,med]).  
splitword(veitil,[vei,til]). 
splitword(verkitj,[virker,ikke]).  %%  :-)
splitword(vetikke,[vet,ikke]).  
splitword(vilta,[vil,ta]).   
splitword(vkl,[vei,klokken]).      %%  ?
splitword(v�reder,[v�re,der]).   
splitword(v�ree,[v�re]). %% pre lex for compword 
splitword(v�rei,[v�re,i]).   
splitword(v�reved,[v�re,ved]). 

splitword(�kke,[er,ikke]). 

splitword(�bli,[�,bli]).  
splitword(�ta,[�,ta]). 
splitword(�v�re,[�,v�re]).  



%%%%%%%%%%%%%%%%%%

%% // Dont cheat with compword unless you have to !



%% NB   xcompword are not applied recursively nor exclusively
%% System will try xcompword first, but
%% you should try compword first


% Use with extreme care, and only if compword fails
% Can be used if there is an error rehabilitation
% No warranty

%% xcompwords is executed sequentially, and must sometimes be carefully sorted.
% Longest first if identical initially

%% EXCLUSIVE COMPWORD : kills alternatives  


%% PRIORITY LIST,   must come first
    

%% xcompword(her,[er],er). %% selv om det her er %%
%% xcompword(det,[her],dette). 
%% replacement are sequential by occurrence 

    xcompword(m�,[jeg,to],g�r). %% SIC (ta) 
    xcompword(m�,[me,ta],g�r).  %% dial
    xcompword(mye,[de,vil],mye).   %% <-- left recursive

%%  syndrom.  
%%  lex tillater ikke venstre-rekursive erstatninger

%%  mye de vil -> mye
%%  mye  removes de vil
%%  but 'de vil' are still on the txt, and will be reintroduced

    xcompword(fra,[a,til,b],overalt). %% rough %% TA-110122
    xcompword(fra,[a,te,b],overalt).  %% rough

%%    xcompword(a,[til,b],atb). %% AtB  n�r g�r bussen fra ... %%  TA-100828 :-) 
%%    xcompword(a,[te,b],atb).  %% TA-110128  rough
%%    xcompword(a,[t,b],atb).   %% 

%%     xcompword(alt,['/',statoil],'ALT/Statoil'). %% emergency, alt confuses

%    xcompword(ga,['\203',ayr],g�r).  %%    gÃ¥r  %%  ad hoc
%    xcompword(gl,['\211',shaugen],gl�shaugen). %%    gÃ¥r  %%  ad hoc
%    xcompword(na,['\203',ayr],n�r).  %%    nÃ¥r  %% ad hoc

    xcompword(17,['.',mai,'-',rute],rute17mai). 
    xcompword(17,['.',mai,'-',ruter],rute17mai). 
    xcompword(17,['.',mai,'-',rutene],rute17mai). 

    xcompword(17,['.',mai,rute],rute17mai). 
    xcompword(17,['.',mai,ruter],rute17mai). 
    xcompword(17,['.',mai,rutene],rute17mai). 

    xcompword(a,['/',s],'A/S'). %%  Problem  A/S

    xcompword(ang,['.'],ang�ende). 


    xcompword(da,[':'],da). 
    xcompword(da,[jeg,m�,v�re,fremme],f�r). 
    xcompword(da,[jeg,m�,v�re,der],f�r). 
    xcompword(da,[sj�],[]).  %% Dial %% TA-110330 :-)
    xcompword(da,[som],som). %% TA-101228
    xcompword(da,[s�],[]).   %% TA-101123

    xcompword(du,[','],[]). %%  // only if ',' is not noise
    xcompword(du,[n�],du).  %% cheat %% hvis du n� l�per 

%%     xcompword(dvs,['.'],og). %% TA-110304  (unnec rewording)
    xcompword(dvs,[],og).    %%

    xcompword(det,[v�re,seg],enten).

    xcompword(en,[av,de],en).    %%  rough
    xcompword(en,[av,disse],en). %%
    xcompword(en,[av,mine],en).  %% 
    xcompword(en,[din],din).     %% IQ'en din = IQ din
    xcompword(en,[av,v�re],v�re).    %% etc 

compword(en,[av],[]). %% Haz ? 

    xcompword(et,[og,samme],samme).  

    xcompword(ett,[av,de],et).    %% rough
    xcompword(ett,[av,disse],et). %% 
    xcompword(ett,[av,mine],et).  %%  

    xcompword(f,['.',o,'.',m,'.'],etter). 
    xcompword(f,['.',o,'.',m],etter). 
    xcompword(f,['.',eks,'.'],redundant0). %% f.eks. = [] %% NB    
    xcompword(f,[�,v,p],til).  %%  for � v�re p�, f ambig 
    
    xcompword(fom,['.'],etter).

    xcompword(f�,[tak,i],finne). %% TA-100902
    xcompword(f�r,[opp],mottar). %% nofunk particlev1 

    xcompword(f�,[p�,plass],lag).  
    xcompword(f�r,[p�,plass],lager). 
    xcompword(fikk,[p�,plass],laget). 

    xcompword(f�r,[tak,i],mottar).   %% forst�r ? 
    xcompword(f�r,[tak,p�],forst�r). %% forst�r ? %% particlev2?

    xcompword(hpl,['.'],holdeplass). 


    xcompword(i,[fra],fra).       %% TA-110221
    xcompword(i,[dag],idag).      %% TA-100828 (NB)
    xcompword(i,[gjen],igjen).    %% TA-10111
    xcompword(i,[g�r],ig�r).      %% TA-100909
    xcompword(i,[morra],imorgen). %% TA-101115
    

    xcompword(i,[morgen],imorgen).            %% #2

    xcompword(i,[hvilken,grad],hvordan). %%(hvormye?) 
    xcompword(i,[l�pet,av],i).   %%  "during"
    xcompword(i,[orden],bra).    %%  skal v�re i=ankomme/ v�re st�r f�r i

    xcompword(i,[over,i,morgen],overimorgen). %% #1 %% TA-110401
%%     xcompword(i,[over],over). %% TA-110401   %% destroys   xcompword(i,[over,i,morgen]



    xcompword(i,[phone],iphone). 
    xcompword(i,[prinsippet],redundant0).
    xcompword(i,[realiteten],redundant0). 
    xcompword(i,[virkeligheten],redundant0). 
  
    xcompword(igjen,[til],til). %% TA-100908
    xcompword(ikke,[sant],[]).
    xcompword(ikke,[s�],ikke).  %% TA-110105
    xcompword(nei,[ikke],ikke).  
    xcompword(nei,[tvert,imot],nei). 

    xcompword(nettside,[ansvarlig],administrator).  %% rough 
    xcompword(nett,[side,ansvarlig],administrator). %% rough 

    xcompword(noe,[konkret],noe). %% TA-110111
    xcompword(noe,[rart],noe).    %% TA-100831 :-)

    xcompword(og,[da,alts�],[]). 
    xcompword(om,[bord],ombord). %% TA-100909
    xcompword(om,[f,'.',eks,'.'],om). %% etc 

%%     xcompword(st,[':'],st). %%  ':' as skipdot//  unnec

    xcompword(sy,['.'],st). %% Olvs.. 

    xcompword(t,[':',kort,periode],tkort).    %% special
      xcompword(t,[':',kort],tkort).          %% 
      xcompword(t,[':',kortet],tkort).  

    xcompword(t,['-',kort],tkort).  
    xcompword(t,['-',kortet],tkort). 

    xcompword(t,[kort],tkort). 
    xcompword(t,[kortet],tkort). 

    xcompword(t,['.',o,'.',m,'.'],f�r). 
    xcompword(t,['.',o,'.',m],f�r). 

%%     xcompword(t,['.'],til).    %% TA-110405 einar t.

%%     xcompword(tom,['.'],f�r).  %% bussen er tom %% TA-110620 Haz

    xcompword(team,['-',trafikk],tt). %%  '-' trouble

    xcompword(team,[trafikks],teams). %%  dirty 

    xcompword(web,['-',orientert],webbasert). %% Techn
    xcompword(web,['-',basert],webbasert).   %% 
    xcompword(web,['-',side],webside). %% Techn 
    xcompword(web,['-',siden],websiden).
    xcompword(web,['-',sider],websider).
    xcompword(web,['-',sidene],websidene).

    xcompword(web,[basert],webbasert).   %% 
    xcompword(web,[oriented],webbasert). %% Techn 
  
    xcompword(web,[internett],internett).  %% own 

%% Event named days 


%% xcompword(n�r,[pensjoneres,arvid,holme],arvid_holme_day).        %%TA-101013 ...
%% xcompword(arvid,[holme,g�r,av,med,pensjon],arvid_holme_day).    
%% xcompword(arvid,[holme,g�r,av],arvid_holme_day).    %% g�r av bussen 
%% xcompword(arvid,[holme,slutter],arvid_holme_day).  
%% xcompword(arvid,[holme,blir,pensjonist],arvid_holme_day).
%% xcompword(arvid,[holme,pensjonerer,seg],arvid_holme_day).

xcompword(president,[kennedy,ble,drept],john_f_kennedy_day).%% 22.11.1963
xcompword(oddvar,[br�,brakk,staven],oddvar_br�_day).        %% 25.02.1982

xcompword(hans,[finnes,gate],hans_finnes_street). %% Ad Hoc Despair 



%% xcompword('.',['\''],'.'). %% close to <- (return) %% unnec ?
xcompword('.',['/'],'.'). 

xcompword(':',[':'],':'). 
xcompword(':',[')'],[]). %% :) %% \+ '' %% TA-110624
xcompword(':',['('],[]). %%    %% TA-110630

xcompword(0,[l],1). %% etc 

xcompword(l,[0],10). %% L 
xcompword(l,[1],11). %% 
xcompword(l,[2],12). %%
xcompword(l,[3],13). %%
xcompword(l,[4],14). %% 
xcompword(l,[5],15). %%
xcompword(l,[6],16). %%
xcompword(l,[7],17). %% 
xcompword(l,[8],18). %%
xcompword(l,[9],19). %% 

xcompword(2,[b],2). %% Experiment// not 2 buses

xcompword(2,['-',3],2). %% fast uttrykk, 2 is conservative
xcompword(3,['-',4],3). 
xcompword(4,['-',5],4). 
xcompword(5,['-',6],5). 

xcompword(e,[post],epost).  
xcompword(e,[posten],eposten).  

xcompword(e,['-',post],epost). 
xcompword(e,['-',posten],eposten). 

xcompword(email,[adresse],emailadresse). 
xcompword(email,[adressen],emailadressen). 

xcompword(og,[alt,mulig],[]). %% (trailer ?)
xcompword(der,[m�,jeg,v�re,seinest],f�r).  %% ?
xcompword(s�,[�],�).      %% for s� � ta buss 
xcompword(trondheim,[s],ts). %% ikke sentrum %% Special

     compword(si,[ifra],fortell).   %% TA-110724
     compword(si,[i,fra],fortell).  %% 
     compword(si,[fra],fortell).    %% 

     compword(si,[ifra],fortelle).   %% TA-110724
     compword(si,[i,fra],fortelle).  %% 
     compword(si,[fra],fortelle).    %% 


%%%%%%% END PRIORITY LIST %%%

    xcompword(buss,[rute,r],bussruter).   %% TA-110724

%% NUMERIC/ SPECIAL 

compword(bu,[8,ss],buss).       %% slip 

compword(vi,[jeg],jeg). 
compword(jeg,[vi],jeg).
    xcompword(jeg,[meg],jeg). %% ? hvordan kommer jeg meg %%** er jeg meg ?

    xcompword(vii,[s],viis).         %% N�d H7 
    xcompword(den,[sjuendes],viis).  %%

    xcompword(rekke,[bort],g�). %% (ogs� reach)
    xcompword(rekke,[ned],g�).
    xcompword(rekke,[opp],g�).

%% // dont split  d1 etc 

    xcompword(d,[1],d1). %% Ad Hoc   Dronningens gt
    xcompword(d,[2],d2).
    xcompword(d,[3],d3).
    xcompword(d,[4],d4).

    xcompword(m,[1],m1). %% Ad Hoc   Munkeg
    xcompword(m,[2],m2).
    xcompword(m,[3],m3).
    xcompword(m,[4],m4).
    xcompword(m,[5],m5).

    xcompword(1, [o],10).
    xcompword(2, [o],20).
    xcompword(3, [o],30).
    xcompword(4, [o],40).
    xcompword(5, [o],50).
    xcompword(6, [o],60).


 %%   xcompword(av,[p�],til). %% Holdeplassen som jeg skal av p� %%  Haz %% TA-110629

 
    xcompword(og,['/',eller],eller).  

compword(dom,[kirka],domkirken).  %% TA-110214
compword(dom,[kirken],domkirken). %%

%% xcompword(e,['.',c], ec).     %%  e.c. dahls gate ? VERY AD HOC
%% xcompword(e,['.'],etter).     %%  e.c. dahls gate ???

   xcompword(e,['.',l],[]). 
   xcompword(e,[6],e6).  
   xcompword(el,['.'],eller).  

compword(eller,[ikke],[]). 

   xcompword(eller,[kl,'.'],etter). 
      xcompword(eller,[kl],etter).      %%  (kl) NB seq

   xcompword(eller,[annet],[]).
   xcompword(eller,[for],for).     %% ad hoc
   xcompword(eller,[hva],[]).      %% TA-101018
   xcompword(eller,[omvendt],[]).  %% TA-110629

compword(eller,[i],eller).      %% ad hoc, Haz avganger i rutehefte eller (i) ...
compword(eller,[p�],eller).     %% ad hoc

    xcompword(ellers,[ingenting],[]). %%  etc.

    xcompword(f,['.',eks,'.'],[]). %% If redun. adv, then for eksempel
    xcompword(f,['.',eks],[]). 
    xcompword(f,[eks,'.'],[]).
    xcompword(f,[eks],[]).

%% compword(eks,['.'],[]).  

    xcompword(ekstra,[buss],ekstrabuss). 
    xcompword(ekstra,[busser],ekstrabusser).
    xcompword(ekstraavganger,[rute],ekstrabusser). %% ekstraavganger rute 10 skistua * fins . 
    xcompword(ekstraavgang,[rute],ekstrabuss). %% ad hoc

   xcompword(eller,[klokka],etter). 
   xcompword(eller,[klokken],etter).
compword(eller, [bare,til], eller).   %% Rough

compword(eller, [til], eller).  %% til nth eller til nardo
                                %% rough anyway 

    xcompword(eller,[senere],[]).  


    xcompword(f�rre,[eller,ingen],f�rre). %% problem 

    xcompword(kl,[o],klokken).        %% kl o900? 
    xcompword(k,[kl],klokken).        %% repair 
    xcompword(k,[l],klokken). 
    xcompword(kl,[kl],klokken).   
    xcompword(kl,['.'],klokken). 
    xcompword(klok,[ken],klokken).   


xcompword(men,[n�r,'?'],'?'). %% TA-110824

    xcompword(senest,[ta],ta).  %% rough, but context will help 
 
    xcompword(like,[godt],godt).
    xcompword(like,[greit],godt).
  
compword(se,[for,meg],tro). 
compword(se,[frem,til],forvente). %% fast uttrykk 
compword(ser,[frem,til],forventer). %%

    xcompword(se,[n�rmere,p�],unders�ke). %% probl. prep(n�rmere) 

%% compword(se,[siste],siste).  %% why

    xcompword(se,[�],[]). 
%%     xcompword(selv,[om],hvis). %% uansett om %% gram 
%%     xcompword(ser,[ut,som],ligner). %% Det ser ut som om
%%     xcompword(se,[ut,som],ligne).   %%

    xcompword(selv,[om],selvom).  %% Technical, problem 
    xcompword(uavhengig,[av,om],selvom). %% TA-110111

    xcompword(senest,[fremme],fremme).  % seinest/ framme etc 


compword(seg,[ihjel],[]). %% sprang seg ihjel :-)

%%     xcompword(ser,[ut,som],stemmer). %% rough one word substitute 

compword(sett,[etter],etter). 
compword(sett,[f�r],f�r).
compword(sette,[opp],�ke).    %% prisene ? 

    xcompword(snakk,[om],meningen). %% TA-110724 .. at

%%     xcompword(som,[at],at). %% det virker som at %% TA-110122 unnec
    xcompword(som,[deretter],som). %%  som deretter g�r til byen? 

    xcompword(som,[det,skal],bra). %% TA-110110
    
    xcompword(som,[f�lger],f�lgende).  

%%     xcompword(som,[om],at). %% det virker som om %% rough %% TA-110122

    xcompword(virkelig,[ikke],ikke).

    xcompword(vinter,[ruta],vinterruten). 
    xcompword(vinter,[rute],vinterrute).
    xcompword(vinter,[ruten],vinterruten).
    xcompword(vinter,[rutene],vinterrutene).
    xcompword(vinter,[ruter],vinterruter).

    xcompword(sommer,[ruta],sommerruten). 
    xcompword(sommer,[rute],sommerrute).
    xcompword(sommer,[ruten],sommerruten).
    xcompword(sommer,[rutene],sommerrutene).
    xcompword(sommer,[ruter],sommerruter).

    xcompword(v�re,[med],komme). %% diff in gram
    xcompword(er,[med],kommer).

%% compword(er,[p�],er). %% NB ikke X bel�pet er p� 30 kroner
                         %% jeg er p� nardo \= jeg er nardo
    xcompword(er,[':'],er).     %% TA-110107
    xcompword(var,[':'],var).   %%
    xcompword(blir,[':'],blir). %%

    xcompword(var,[med],kom). 
    xcompword(v�rt,[med],kom). 

    xcompword(v�re,[til,hjelp],hjelpe).   %% Fast uttrykk ?
    xcompword(v�re,[til,hjelpe],hjelpe).  %% sp
    xcompword(v�re,[der],ankomme). 
    xcompword(v�r,[ei],til). %% v�re i 


%% NB   compword are not applied recursively nor exclusively


/*  %% hva er 4 4. = hva er 4 fjerde 
compword(1,['.'],f�rste).
compword(2,['.'],andre). 
compword(3,['.'],tredje).
compword(4,['.'],fjerde). 
*/

% compword(5,['.'],femte).  %%  neste avgang etter 09:05 .  \==> femte %% ? NO Problem 

    xcompword(etter,['.'],etter). %% Etc 

    xcompword('.',[etter],etter).
    xcompword('.',[fra],fra). 
    xcompword('.',[f�r],f�r). 
    xcompword('.',[til],til).
    xcompword('.',['.'],'.'). 
    xcompword('.',[framme],framme). 

    xcompword('?',[ca,'.'],ca). %% addendum 
    xcompword('?',[ca],ca).     %% addendum

compword(':',[')'],[]).    %% Smileys 
    xcompword(':',[d],[]). %% :D  
    xcompword(':',[p],[]). %% :P 

%% compword(';',[')'],[]). 

compword('+',[retur],tilbake).  %% ? 

%% buss 7.00 - 8.00 \=>  7 08 00 

/* %% TA-110406     kl 06.00 06.04.11 *= 6 . 0 6  .04.11 = 6.6 4.11

    xcompword(0,[0],00).  
    xcompword(0,[1],01). 
    xcompword(0,[2],02).
    xcompword(0,[3],03).
    xcompword(0,[4],04). 
    xcompword(0,[5],05).
    xcompword(0,[6],06).
    xcompword(0,[7],07).
    xcompword(0,[8],08).
    xcompword(0,[9],09).
*/

    xcompword(0,[g],og). 

%%% hvilken holdeplass til buss |7 er| n�rmest m�llenberg



%% ALPHABETIC 


%%    xcompword(videre,[derfra],[]). %% ad hoc subopt 

compword(a,[fra],fra). %% hvor g�r 5 a fra 
compword(a,[m],formiddag). 

compword(aldri,[i,verden],nei).  
    xcompword(aldri,[i,rute],forsinket). 
    xcompword(aldri,[slik],umulig). %% at trikken st�r 

    xcompword(i,[f�rste,omgang],[]). %% redundant0). %% TA-110707

compword(ikke,[slik],umulig). %% at trikken st�r  %% ?

compword(alias,[navn],navn). 
compword(alias,[],navn). %% TA-101018

compword(all,[din],din). 
compword(all,[e],alle). 

   xcompword(alle,[andre],andre). 
   xcompword(alle,[dine],dine).  
   xcompword(alle,[disse],disse).  
   xcompword(alle,[mine],mine). 
   xcompword(alle,[sine],sine). 
   xcompword(alle,[v�re],v�re). 

compword(aller,[helst],[]).       %%  helst not noise //noe som helst
compword(aller,[f�rst],f�rst).   
compword(aller,[f�rste],f�rste). 
compword(aller,[sist],sist).     
compword(aller,[siste],siste).   

    xcompword(allerede,[n�],n�). %% TA-110426

compword(alt,[i,alt],[]).
compword(alt,[ialt],[]).

    xcompword(alt,[mulig],alt). 
compword(alt,[om],om).  

compword(alt,[for],altfor). %% x? %% TA-110503

compword(alts�,[ikke],unntatt).             %% ? alts� noisew !!!

%%% compword(alts�,[],[]).                      %% NB after alts� ikke
   %% creates  w(alts�,[[alts�],name([],n,0),[]]) -> remove

    xcompword(an,[til],an).

compword(andre,[buss,etter,neste],tredje).   %% etc
compword(andre,[bussen,etter,neste],tredje). %%
    xcompword(andre,[enn],unntatt).
compword(andre,[steder,enn],[]). %% rough, works as corrective 

    compword(ang,[at],at).

compword(ankom,[f�r],f�r).    
%% compword(ankomme,[f�r],f�r). 

%% compword(ankomst,[f�r],f�r).  %% SUSPENDED Buster 

compword(ankomst,[rundt],rundt). 
compword(annet,[enn],[]).                   %% Rough, Rhetoric


%%    xcompword(anse,[for,�],mene).   %% fast uttrykk 
%%    xcompword(anser,[for,�],mener). %%

%%       bussen g�r .. for � v�re 


compword(antall,[kilometer],avstanden). 
%% compword(arbeids,[buss],arbeidsbuss). 
%% compword(arbeids,[bussen],arbeidsbussen).  

    xcompword(ass,[buss],ekstrabuss). 
    xcompword(ass,[bussen],ekstrabussen).
    xcompword(ass,[bussene],ekstrabussene).
    xcompword(ass,[busser],ekstrabusser).

    xcompword(at,[det,er,det,at],at).
compword(at,[at],at).                       %% Repair
compword(att,[med],forbi). 
compword(att,[me],forbi).  

%% compword(at,[med],forbi). %% jeg tror at med buss er det lett
%% compword(at,[me],forbi). 

compword(atter,[en,gang],redundant0). 

compword(automatisk,[svarer],automat).  
%%     xcompword(av,[disse],[]). %% noen av disse 

compword(av,[fra],av). %% .. bussen 

compword(ad,[gangen],[]).
compword(av,[gangen],[]). 

compword(av,[g�rde],[]). 
    xcompword(av,[og,til],tidvis).  %%  g�r bussen %% TA-111001
 

compword(av,[p�],til). %% av p� station/ av bussen

compword(avg,[pr,time],avgangshyppighet). 
compword(avg,[buss],buss). 
compword(avg,[nr],buss).  
compword(avg,['.',nr],avgang). 

compword(avgag,[buss],buss).  % ? own %% neste avgang buss 36 
compword(avgang,[buss],buss).  


%% compword(avgang,[etter],etter). %% buss 36 har avgang etter 
compword(avgang,[neste],neste).  
compword(avgang,[rute],rute).  
compword(avganger,[linje],linje).   
compword(avgang,[nr],buss).  
compword(avganger,[buss],buss).  
compword(avganger,[etter],etter).     
compword(avganger,[nr],busser). 

%% compword(b,[4,ss],buss). %% ? 

compword(b,[buss],buss). %% repair 
compword(b,[uss],buss).  
compword(b,['.'],buss). 
compword(b,[nr],buss).  
compword(b,[ss],buss).   %% "b~ss" 

%% compword(bare,[],[]). %% not noise (ikke bare = []) // s y n w o r d 


    xcompword(bare,[hyggelig],ok).    %% * takk ->v�rs�god -> takk...
compword(barne,[bilett],barnebillett).
compword(barne,[billett],barnebillett).
%% compword(barnehagen,[ved],[]). %% (noinfo)

    xcompword(begynner,[�],vil).  %%  rough
    xcompword(begynne,[�],[]).     %%
    xcompword(begynne,[med,�],[]). %%

    xcompword(befinner,[meg],er). %% ETC (replaces befind) 

    xcompword(benytte,[meg,av],benytte).  
    xcompword(benyttet,[meg,av],benyttet). 

compword(beste,[rute],rute). %% .. fra X 
compword(billettypen,[midtby],midtbybillett). %% etc 
compword(billetttypen,[midtby],midtbybillett). 
compword(billettype,[midtby],midtbybillett).

    xcompword(bl,['.',a,'.'],[]). %% etc 

compword(ble,[d,av],er). 
compword(ble,[det,av],er).  
compword(bli,[det,av],er). 

compword(bli,[med],komme).  
compword(ble,[med],kom).  
compword(blir,[med],kommer).

compword(blir,[det,satt,opp],kj�rer).          %%  Pragmatic
compword(blir,[d,av],er).  
compword(blir,[det,av],er). 
compword(blir,[av],er).    %% ?
compword(bortsett,[fra,det],[]). 
compword(bortsett,[fra],unntatt). 
    xcompword(bort,[til],til).


    xcompword(bra,[n�r],n�r). %% Fedup
    xcompword(bra,[til],bra). %% Fedup %% st�r bra til 

compword(brutt,[sammen],stoppet).              %% Rough

compword(bus,[buss],buss).                  %% Repair
compword(bus,[hold],holdpelass).  
compword(bus,[s],buss).  
compword(bus,[ser],busser).  

compword(buss,[':'],buss). %% not x  //last : conevntion 

compword(buss,['/',busser],busser).  
compword(buss,['/',trikk],kj�ret�y).         %%  ETC ETC

compword(buss,[avgang],bussavgang).  
compword(buss,[avgangen],bussavgangn). 
compword(buss,[avgangene],bussavgangne).
compword(buss,[avganger],bussavganger). 

compword(buss,[billett],bussbillett). 
compword(buss,[billetten],bussbilletten). 
compword(buss,[billetter],bussbilletter). 
compword(buss,[buss],buss).  
compword(buss,[bussen],bussen). 
compword(buss,[det,buss],buss).              %% repair
compword(buss,[det,en,buss],buss).  
compword(buss,[eller,trikk],kj�ret�y). 
compword(buss,[eller,tog],tog).              %% mess no routes 
compword(buss,[en,buss],buss).  %% repair
compword(buss,[en],bussen). 
compword(buss,[folka],sj�f�rene). 
compword(buss,[f�rste,buss],buss).            %% Repair
compword(buss,[f�rste],buss).                 %% buss f�rste nummer 
compword(buss,[hold],holdeplass).   
compword(buss,[holdplass],holdeplass). 
compword(buss,[holde,plass],holdeplass).  
compword(buss,[holde,plassen],holdeplassen). 
compword(buss,[holde,plassenr],holdeplasser). 

%% compword(buss,[':'],buss). %%  destroys  BARNEVOGN P� BUSS:

compword(buss,['.',neste],neste). %% Team buss. ...
compword(buss,['.',n�r],neste).  

    xcompword(buss,['-',stasjonen],busstasjonen). %% nec  
    xcompword(buss,[flybussen],flybussen). 
    xcompword(buss,[eller,trikk],kj�ret�y).

compword(buss,[nt],buss). %%  (nr)
    xcompword(buss,[nummer],buss). %% n�r passerer buss nummer tempe 
    xcompword(buss,[rute],bussrute).
compword(buss,[streik],streik).  
compword(buss,[streiken],streiken). 

compword(buss,[stasjonen],holdeplassen). %% TA-101108

compword(buss,[tabell],bustabell). 
compword(buss,[tabellen],bustabellen). 
compword(buss,[tabeller],bustabeller). 
compword(buss,[tabellene],bustabellene). 

compword(bussoraklets,[mobil],smstuc).         %% etc etc
compword(bussoraklets,[mobiltelefon],smstuc).  %% 
compword(bussoraklets,[mobiltjeneste],smstuc). %%
compword(bussorakelets,[mobil],smstuc).        %% 
compword(bussorakelets,[mobiltelefon],smstuc). %% 
compword(bussorakelets,[mobiltjeneste],smstuc).%% 


   xcompword(bussen,[buss],buss). %% repair 
   xcompword(bussen,[f�r,siste],nestsiste). %% Hazard 

compword(bussen,[neste],neste). %% gdsgd 

   xcompword(buss,  [n],bussen).         %% buss'n
   xcompword(bussen,  [nr],bussen). %% N�r g�r bussen... nr fra  wullumsg�rden

   xcompword(buss,[n�r,buss], buss).  %% repair 
   xcompword(buss,[n�r,g�r,det,buss], buss).  %% repair
   xcompword(buss,[n�r,g�r,neste,buss], buss). 
   xcompword(buss,[n�r,g�r,neste], buss). 




compword(buss,[i,linje],buss).   %%  (avoid sem) bus i rute 
compword(buss,[kart],busskart). 
%% compword(buss,[kl],kl).      %% buss kl 9 til nth
compword(buss,[linje],buss). 
compword(bus,[n], bussen).  
compword(buss,[n], bussen). 

compword(buss,['.',nr], buss).  

 %  x EXPERIMENT
     compword(buss,[nr], buss). %% TA-101206  %% also syntax  

compword(buss,[nr,'.'], buss).        %% ad hoc
compword(buss,[nr,':'], buss).  

compword(buss,[nummer], buss).        %% ad hoc
compword(buss,[neste], neste). 
%%     xcompword(buss,[n�r], buss).      %% nr    %% doesnt help 
    xcompword(buss,[n�r,g�r], buss). %% buss n�r g�r 6 fra byen   

compword(buss,[og,fra,hvor],buss).  
compword(buss,[orakel],bussorakel). 
compword(buss,[plan],bussrute).   
   xcompword(buss,[p�,rute],buss).  

    xcompword(buss,[rute,nr],buss).      %% etc 

    xcompword(buss,[ruta],bussruten).    %% amb. experiment   




%%%     xcompword(buss,[rute],bussrute).     %%   -> gram hovedvogn rute       
                                             %% suspended for test
    xcompword(buss,[ruter],bussruter).   %%

compword(buss,[sjaf�rer],bussj�f�rer).  
compword(buss,[sjof�r],bussj�f�rer). 
compword(buss,[sj�f�r],bussj�f�r). 
compword(buss,[sj�f�ren],bussj�f�ren). 
compword(buss,[sj�f�rer],bussj�f�rer).   
compword(buss,[sj�f�rene],bussj�f�rene). 
compword(buss,[stop],holdeplass).  
compword(buss,[stopp],holdeplass). 
compword(buss,[stoppen],holdeplassen). 
% compword(buss,[stopper],holdeplasser). 
compword(buss,[stoppet],holdeplassen). 
compword(buss,[til,nr],buss). 
compword(buss,[tur],busstur). 
compword(buss,[tuc],busstuc). 
compword(buss,[busser],busser).   
compword(buss,[siste],siste).      %% Repair 
    xcompword(buss,[tider],busstider). 
compword(bussen,[de],de). %% repair , \+ x 
compword(bussen,[e],bussene).             %% haz ?
compword(bussen,[bussen],bussen).           %% Repair
compword(bussen,[etter,neste],andre).     %% ... buss 
compword(bussen,[f�rste,buss],bussen).    %% Repair
compword(bussen,[f�rste,bussen],bussen).  %% Repair 
compword(bussen,[f�rste],bussen).         %% standard prompt 
compword(bussen,[fra,bussen],bussen). 
    xcompword(bussen,[g�r,bussen],bussen). %% err ->x
compword(bussen,[fra,neste],neste).       %% Repair 
compword(bussen,[neste,bussen],bussen).   %% 
compword(bussen,[neste,buss],bussen).     %% 
compword(bussen,[neste],bussen).          %% neste).  
compword(bussen,[siste],siste).  
compword(bussen,[ta,buss],buss). %% Repair ta bussen ta buss

compword(bussene, [rute],buss).   
compword(busser,[rute],buss). 
compword(busser,[buss],buss).             %% Repair  

compword(bussholde,[plass],holdeplass).   %%  disloc
compword(bussholde,[plassen],holdeplassen).  
compword(bussholde,[plassene],holdeplassene).
compword(bussholde,[plasser],holdeplasser). 

compword(bussholder, [plass],holdeplass). 
compword(bussnr,['.'],rute).  

compword(bussrute,   [tid],bussrutetider). 
compword(bussrute,   [tider],bussrutetider). 
compword(bussrute,   [tidene],bussrutetider).

    compword(busrute,   [tid],bussrutetider).  
    compword(busrute,   [tider],bussrutetider).  
    compword(busrute,   [tidene],bussrutetider). 

compword(bussrute,   [buss],buss).   

compword(bussruter,[til,buss],buss).   
compword(busstider,[buss],buss).  

    xcompword(by,[en],byen). 
    xcompword(by,[n],byen).    

    xcompword(by,[buss],buss).  %%  X

    xcompword(b�r,[g�r],g�r). %% avoid amb 


compword(c, [a],ca).  
compword(ca,['.',i],i).  

    xcompword(ca,['.'],ca).    %%
    xcompword(ca,[':'],ca).    %%

compword(ca,[i],i).             %% to tiden 
compword(ca,[imorgen],imorgen).
compword(ca,[mellom],mellom). 
compword(ca,[n�],n�).   
compword(ca,[n�r],n�r). 
compword(ca,[rundt],rundt).     %%   ops: ogs� forbi
compword(ca,[til],f�r). 
   xcompword(ca,[ved],i).  

compword(cirka,[n�r],n�r).     %%  s�nn cirka n�r
compword(cirka,[rundt],rundt). 

compword(d,      [en], en).   
%% compword(d,      [en], buss). %% Haz 
compword(d,      [�], []).  %% dette �r   

    xcompword(da,[ta],ta).  %% pga da -> ta repair 
%%  m� jeg da ta removes da because m� is invoked before  da ta
    
    xcompword(dagen,[etter,idag],imorgen). 
    xcompword(dagen,[etter,i,dag],imorgen). 

    xcompword(dagen,[etter,i,morgen],overimorgen). %% cathch i morgen
	 %% TA-110401

compword(dagen,[etter,imorgen],overimorgen). 
    xcompword(dagen,[etter,morgendagen],overimorgen). 

    xcompword(dagen, [f�r,i,morgen],idag).  %%  :-)  %% TA-110401
compword(dagen, [f�r,imorgen],idag).   %%

compword(dagen, [f�r],ig�r). 
compword(dagen, [busser],buss).  %%  (actual)
compword(dagens,[siste],siste).  
compword(data,  [maskin],datamaskin).

    xcompword(de,[ca],de). 
compword(de,[de],de).
    xcompword(de,[forskjellige],[]). 

compword(defacto,[],[]). 
compword(de,[facto],[]).
    %%% xcompword(de,[fleste],alle). %% rough (?) 

    xcompword(de,[fleste,av],alle). %% rough
    xcompword(de,[fleste],mange).   %%

compword(de,[i,neste], neste). %% n�r g�r de i neste bussen %% ?
 

compword(de,[neste,gangene], heretter). 

    xcompword(definert,[som],lik). %% ad hoc 

compword(definisjonen,[p�,en],en).

    xcompword(deg,[og,dine],deg).  %% dine is ellipt.

compword(deg,[selv],deg).  

    xcompword(den,[eller,de],de). 

compword(den,[neste,gangen], heretter). 
    xcompword(den,[noen], noen). %% det noen
compword(den,[du,nettopp,oppga],denne). 
%% compword(den,[en],det). %% da spurte den en mann 
compword(den,[i,dag],idag).  
compword(den,[idag],idag).             
    xcompword(den,[i,morgen],imorgen). %% TA-110401
compword(den,[imorgen],imorgen).              


    xcompword(den,[her],den).
    xcompword(det,[her],det).

compword(den,[l�rdag],l�rdag). 
compword(den,[s�ndag],s�ndag). 
compword(den,[mandag],mandag). 
compword(den,[n�rmeste,til],n�rmest). 
compword(den,[n�rmeste],n�rmest). 

    xcompword(den,[varianten],denne). %% generic

compword(den,[vet,eg],den). 
compword(den,[vet,jeg],den).

compword(den,[som,g�r],[]).  %% Removeblanks is destructive


compword(denne,[sms,tjenesten],smstuc). 
compword(denne,[smstjenesten],smstuc).   %% 

compword(denne,[type],denne).  
compword(denne,[typen],denne).  
    
    xcompword(dere,[begge],dere). 

%% compword(det,[av],[]). %%  Hvor ble det av ... 

xcompword(det,[buss,g�r],buss). %%  \+ x <--- ???
%%     compword(det,[der],dette).  %% regner det der jeg bor

    xcompword(det,[det,er],noe). %% rough

%% compword(det,[er,greit],ok).  %% -> gram 
%% compword(det,[er,greitt],ok). 
    xcompword(det,[der],dette). 
    
    xcompword(det,[enkleste],l�sningen). %% TA-110807

%% compword(det,[er,greitt],ja).  %% det er greitt � ta buss 
compword(det,[er,greitt,det],ja). 



compword(det,[fikk,jeg,ikke,med,meg],gjenta). 
%% compword(det,[fra],buss).  
%% compword(det,[hadde,v�rt,fint],takk). 
compword(det,[hele],alt).  

compword(det,[her],dette). 

compword(det,[lenge,til],det).     %% Rough ?
%%    xcompword(det,[med,buss],buss). %% Hvor langt er det med buss
compword(det,[med,bussen],bussen).   
compword(det,[m�,du,gjenta],gjenta). 

%%    xcompword(da,[ser,det,ut,til,at],[]).  -> gram

%%    xcompword(det,[samme,som],slik). %% rough hazard  %%  svaret er  ikke det samme som i g�r *
%%   jeg sier det samme som deg 

    xcompword(det,[siste,du,sa],dette). 
    xcompword(det,[siste],dette).

compword(d,[s�nn,at],at). 
compword(d,[slik,at],at).  

compword(det,[s�nn,at],at). 
%% compword(det,[slik,at],at).  %% f�r var det slik at


    xcompword(det,[sp�rs,om],[]). %% TA-110112
    xcompword(sp�rs,[om],[]).     %%

compword(det,[vil,si],[]). 

compword(dette,[for,noe],dette).  
compword(dette,[for,en,ting],dette). 

    xcompword(d,[her],dette).  
    xcompword(d,[h�r],dette). 
    xcompword(det,[for,noe],det).   
%%     xcompword(det,[her],dette). %% coll det her er 
    xcompword(det,[h�r],dette).
    xcompword(dette,[her],dette). 
    xcompword(dette,[h�r],dette).
    xcompword(dette,[for,noe],dette). 

compword(di,[to],to).

compword(dit,    [jeg,skal],dit).  
   xcompword(dit,    [jeg,bor],hjem).  
   compword(dit,    [du,vil],dit).  %% rough 

   xcompword(der,    [jeg,bor],hjemme). 
   xcompword(der,    [jeg,m�,v�re],f�r).  
   xcompword(der,    [m�,jeg,v�re],f�r).
   xcompword(der,    [jeg,m�,v�re,seinest],f�r). 
   xcompword(der,    [jeg,m�,v�re,senest],f�r). 
   xcompword(der,    [m�,jeg,v�re,senest],f�r).   %% etc


compword(dr,[de], de).            %% dr=de + rep 
compword(dra,    [dra],dra).  
compword(dra,    [klokka], etter).          %%  rough

compword(dreide, [seg,om], gjaldt).   %% fast uttr
compword(dreier, [seg,om], gjelder).  %% fast uttr

compword(driver, [med], gj�r). 
compword(driver, [p�], arbeider).  
compword(du,[anbefale,meg,�],jeg). %% cheat
compword(du,[buss],buss).  
%%  compword(du,[ikke],du).   %% Rough Rhetorics hvorfor kan du ikke ta trikken

    xcompword(du,[du],du). %% own
compword(du,[f�r,ha],ha). %% en god dag 
compword(du,[g�r,neste],g�r). %% error 

%% compword(du,[jeg],jeg). %% tror du jeg kan ta bussen 
                           %% Du, jeg skal ... 

compword(du,[n�r],n�r). 
compword(du,[hvilken],hvilken).   %% ?

    xcompword(du,[personlig],du).
    xcompword(du,[selv],du).

compword(du,[tuc],tuc).   

compword(dukke,[opp],komme).  
compword(dukker,[opp],kommer).  
compword(dukket,[opp],kom).          
compword(dukket,[opp],kommet). 
compword(duss,[buss],buss).  %% repair
    xcompword(d�rlig,[gjort],d�rlig). %% TA-110113
compword(d�gnets,[tider],tider).   

%%   compword(e,['.'],etter).   %% E.Tambarskj.  
compword(e,[g�r],g�r). %% dial.. repair 
compword(e,[m],ettermiddag). 
compword(e,['.',m],ettermiddag). 
compword(e,[mail],email). 
compword(e,[mailen],mailadressen). 
compword(e,[posten],mailadressen).  
compword(e,[r],er).                     %%  own sp

%% compword(egner,[seg],er).   %%..best egner seg = fit (itself) 

    xcompword(eller,[i,n�rheten],[]).


    xcompword(en,[ca,'.'],ca). %% fra H�iseth om en ca.  en halv time
    xcompword(en,[ca],ca).  

    compword(en,[del],flere). %%  busstuc er en del av// en del feil
    %% TA-110725
    
compword(en,[en],en). %%  repair
compword(en,[gang,til],gjenta).     
    xcompword(en,[gang,for,alle],alltid). 
compword(en,[gang],[]). 

compword(en,[god,del],mye). %% meget? 
    xcompword(en,[gruppe,med],[]).    %%.. studenter
%%     xcompword(en,[gruppe],[]).     %% jeg reiser i en gruppe 
    xcompword(en,[gjeng,med],[]).   %%.. studenter 
    xcompword(en,[gjeng],[]).      %%.. studenter

    xcompword(en,[sjelden,gang],sjelden). 


compword(en,[toer],to). %% ,2) %% (numbers are not atoms)
compword(en,[treer],tre).  
compword(en,[firer],fire).
compword(en,[femmer],fem).
compword(en,[sekser],seks).  
compword(en,[sjuer],sju). 
compword(en,[�tter],�tte). 
compword(en,[nier],ni).
compword(en,[tier],ti).
compword(en,[elver],elve). 
compword(en,[tolver],tolv).

    xcompword(en,[eller,annen],en).

compword(en,[mengde],mange).
    xcompword(en,[gjeng],mange).

compword(en,[million],1000000). 
compword(en,[gang,til],[]).  
%% compword(en,[gang],[]).  %% per time
compword(en,[slik], en).  
compword(en,[s�nn], en). 
compword(en,[s�],en).    
compword(en,[viss], en).     
compword(en,[slik],en). 
compword(en,[slikt],en).  

compword(ende,[opp],komme). 
compword(ender,[opp],kommer). 


compword(ende,[holde,plass],endeholdeplass).
compword(endeholde,[plass],endeholdeplass).
compword(endeholder,[plass],endeholdeplass). 
compword(ende,[holdeplass],endeholdeplass).
compword(ende,[holde,plassen],endeholdeplass).
compword(endeholde,[plassen],endeholdeplass).
compword(ende,[holdeplassen],endeholdeplass).
compword(endeholde,[plass],endeholdeplass). 

compword(ender,[opp],kommer).

    xcompword(endres,['/',slettes],endres). %% weaker



compword(endte,[opp],kom).  
compword(enda,[en,gang],redundant0). 

compword(engangs,[billett],enkeltbillett). 

    xcompword(en,[gang],redundant0). 

    compword(enn,[bare],enn). 
%% compword(enn,[det],avgang). %% Freak g�r det noen tidligere enn det 

    xcompword(enn,[avtalt],[]). %% TA-110105
    xcompword(enn,[f�r],[]).    %% tidligere enn f�r %% rough
    xcompword(enn,[ellers],[]). 
    xcompword(enn,[tidligere],[]).    %% tidligere enn f�r %% rough

%% compword(enn,[],[]).     % enn (hva med) buss 5 ? , st�rre enn 

compword(enn�,[en,gang],redundant0).


%% compword(er,[den,f�rste,som],[]).       %%  doesntwork 
compword(er,[den,neste,til,�,kj�re], g�r). 
compword(er,[der,kl],kl). %% IKKE X

    xcompword(er,[det,med],er). %% hvordan e.d.m. 
    xcompword(gikk,[det,med],var). 
%%     xcompword(g�r,[det,med],er).   %% hvordan g�r det med deg %% TA-101202

compword(er,[det,blitt,av], er). 
   xcompword(er,[det,du,har],fins).  
compword(er,[det,med], er). 
%% compword(er,[det,for], koster).   %% Too rough 
%% compword(er,[det,noe], eksisterer).   %% ? 
   xcompword(er,[det,som],[]). %% .. kj�rer // er det = exist (gram) 
   xcompword(er,[det,�,v�re],virker). %% ... en datamaskin :-)


%% compword(er,[det],eksisterer). %% NB ikke x 
                                  %% hvor lenge er det til ...

compword(er,[du,av],er).  
compword(er,[du,vel],[]). 
compword(er,[e],er).          %% slang
   xcompword(er,[enig,i],mener). 
   xcompword(e,[enig,i],mener). %% ?
compword(er,[er],er).   
compword(er,[g�r], g�r).      %%  repair 

%%    xcompword(er,[hyppig,forekommende],skjer). %% -- ofte %%

compword(er,[i,drift], g�r). 
    xcompword(er,[kj�rer],g�r). %% AVOID TAKE kj�rer
compword(er,[kommer],kommer).   %% repair

compword(er,[ligger], ligger). %% TA-100823 repair

%% compword(er,[med], er). %% er sammen med = er med =er*
                           %% TA-110221

compword(er,[m�], m�).    %%repair 

compword(er,[n�],er). %%  Rough   klokken er -n�- 1545.
   xcompword(er,[n�r],er).
   xcompword(er,[passerer], passerer).      %%  repair  
%% compword(er,[planlagt], g�r). %% rough 

    xcompword(er,[tillagt],har). %% ad hoc 

compword(er,[snakk,om],gjelder).  

%% compword(er,[s�], er).                  %% er s� du/stor 

    xcompword(er,[vil],vil).            %% Repair

    xcompword(er,[ute,etter],s�ker).  
    xcompword(var,[ute,etter],s�kte).  

    xcompword(et,[eller,annet],noe). 
    xcompword(ett,[eller,annet],noe). %% 

%    xcompword(et,[a�yeblikk,bare],[]). %% spam
    xcompword(et,[�yeblikk,bare],[]). 

    xcompword(et,[et],et). %% own 

compword(et,[ja],ja).  
compword(et,[nei],nei). 
compword(eit,[ja],ja). 
compword(eit,[nei],nei).

compword(et,[dusin],12). 
compword(et,[kl],etter). 
compword(et,[mer],et).   %% et mer presist navn
compword(et,[slik],et).  
compword(et,[slikt],et). 
compword(et,[snes],20).  
compword(et,[sted,p�],p�).  
compword(et,[ter],etter). 
compword(et,[visst],et).  
compword(et,[s�],et).  

compword(ett,[er],etter).  %% Hazardous ???
compword(ett,[kl],etter). 


%% compword(etter,[den],deretter).
    xcompword(etter,[denne],deretter).
    xcompword(etter,[den,som,g�r],efter).    %%  efter = strict after/techn 
compword(�tter,[den,som,g�r],efter).    %% ? dial

    xcompword(etter,[�nske],redundant0). %% TA-101004 ad hoc

%%     xcompword(etter,[det],deretter).    %% Telebuster!  %% suspended .. etter det jeg forst�r 

    xcompword(etter,[dette],deretter).  %% 

compword(etter,[etter],etter).         %%  Repair 
compword(etter,[fra],fra).             %%  Repair 
compword(etter,[f�r],f�r).             %%  Repair
compword(etter,[g�r],g�r).             %%  Repair
compword(etter,[med],med).             %%  Repair 
compword(etter,[mellom],mellom).       %%  Repair
compword(etter,[middag],ettermiddag). 
compword(etter,[neste],heretter). %%  ? rough, \+ xc..
    xcompword(etter,[n�],heretter). 
compword(etter,[passert],etter).       %% � ha passert         
compword(etter,[til],til).             %%  Repair
compword(etter,[�,ha,passert],forbi). 
compword(etter,[�,ha,startet,i],fra). 

compword(ettermiddag,['/',kveld],ettermiddag). %% most inclusive 
compword(eventuelt,[n�r],[]). 

compword(eventuelt,[],[]).  %% collides ? 
    xcompword(ev,['.'],[]). 
    xcompword(evt,['.'],[]). 

compword(evt,[n�r],[]). 
%% compword(evt,[],[]). %% destructive ?  


    xcompword(f,[eks],redundant0).    
    xcompword(f,['.',eks,'.'],redundant0). 
    xcompword(f,['.',eks],redundant0).


compword(f,[o,m],etter).  
compword(f,[o,m,'.'],etter).  
compword(f,['.',o,'.',m],etter). 
compword(f,['.',o,'.',m,'.'],etter). 
compword(f,[r],f�r).  % f;r 
compword(f,[ra],fra). 
compword(f,[rste],f�rste).   %%  f;rste
compword(f,[til],til).       %% Repair  

compword(f,[�,komme,t],til).    %%
compword(f,[�,komme,til],til). 

compword(f,[�,v�re,i],til). 
compword(f,[�,v�re,p�],til).
    xcompword(feiler,[det],plager). %% rough (be wrong with) %% TA-101103
compword(femme,[f�r],f�r). 
compword(ferdig,[til],f�r).       %% Rough experiment
compword(ferie,[ruter],ferie).   %%   Rough
compword(finne,[sted],finnes). 
compword(finner,[sted],finnes). 
compword(finner,[ikke],s�ker). %%  <-- rough 
    xcompword(fint,[�],�). %% rekker f.�. 

%% Begin FOR

%%       xcompword(for,[�,v�re],er). %% anser for � v�re= anser er
    xcompword(for,[den,sakens,skyld],redundant0). 
    xcompword(for,[eksempel],redundant0).         %% f.eks. = []
    xcompword(for,[min,del],redundant0).          %% TA-101117
    xcompword(for,[sikkerhets,skyld],redundant0). 

    xcompword(for,[�yeblikket],n�). %% TA-101123

    xcompword(for,[�,v�re,der,f�r],f�r).  %#1        %% TA-100921
    xcompword(for,[�,v�re,der],f�r).      %#2        %%
    xcompword(for,[for],for).      
    xcompword(for,[p,v�re,pa],til). 

compword(for,[tiden],n�).

    xcompword(for,[�,v�re,i],til).   %%  � sp
    xcompword(for,[�vrig],for�vrig). %% 

%% compword(for,[klokka],f�r).  %% NB for kl 11 \= for rute 11
%% compword(for,[klokken],f�r). 
%% compword(for,[kl],f�r).      %% 
compword(familie,[ dagsbilett],familiebilett).
compword(familie,[ dagsbillett],familiebilett). 

    xcompword(far,[a,v�re, i],til). %% no pardon

compword(fare,[for],mulig). % .. at
compword(fler,[enn,en],flere). 

    xcompword(flest,[mulig],mange). 

compword(fly,[buss],flybuss). 
compword(fly,[bussen],flybuss). 
compword(fly,[bussene],flybussene). 
compword(fly,[plas],flyplass).    
compword(fly,[plasen],flyplassen). 
compword(fly,[plaset],flyplassen).  %% actual
compword(fly,[plass],flyplass).    
compword(fly,[plassen],flyplassen). 


    compword(for,[alt,jeg,vet],redundant0).
compword(for,[fra],fra).         %% repair

    xcompword(for,[tidlig,framme],fortidlig). 
    xcompword(for,[tidlig,ute],fortidlig).
    xcompword(for,[tidlig],fortidlig).

    xcompword(for,[�,v�r,ei],til).  %% v�re i   
    xcompword(for,[�,v�re,p�],til). %% �-tr�bbel 

    xcompword(for,[og,v�re,p�],til).     %%   spiw
    xcompword(fo,[r�,v�re,i],til).  
    xcompword(fo,[r�,v�re,p�],til). 

    xcompword(for,[p,v�re,i], til).  
    xcompword(for,[p,v�re,p�], til).
    xcompword(for,[p�,v�re,i], til).  
    xcompword(for,[p�,v�re,p�], til).  
%% compword(for,[�,komme,til], til). 
    xcompword(for,['?' ,komme,til], til).
    xcompword(fortelle,[med],fortelle). %% 
    xcompword(for,[for],for). 
compword(for,[guds,skyld],[]).
    xcompword(for,[i,v�re,p�],til). 


     xcompword(for,[langsomt],forsinket). %% 
     xcompword(for,[sakte],forsinket). %% 
     xcompword(for,[sent],forsinket). %% 

    xcompword(for,[v�re,p�],til).   %%
compword(for,[komme,fram,til],til). 
compword(for,[komme,frem,til],til).
compword(for,[mye],mye). 

    xcompword(for,[sen],forsinket).  
    xcompword(for,[sein],forsinket). 
    xcompword(for,[sent],forsinket).  
    xcompword(for,[seint],forsinket). 

    xcompword(for,[�yeblikket],[]). %% #->  n� // rough 

    xcompword(for,[�,ved],til). 

compword(for,[p�,v�re],til). %% for � v�re p� *

    xcompword(for,[�,rekke,frem ,til], til). 
    xcompword(for,[�,rekke,frem],f�r).  
    xcompword(for,[�,v�re,der,til],f�r). 
compword(for,[�,v�re,der],kl).  

   xcompword(for,[�,v�re,der,f�r],f�r).

%% compword(for,[�,v�re,der],[]).  

    xcompword(for,[v�re,der],[]). 

compword(for,[v�re,i],til).  
compword(for,[vre,i],til).  %%  ?
compword(for,[v�re,ii],til).        %% ?
compword(for,[v�re,p�],til).        %% V�re-syndrom

compword(for,[a,v�re,p�],til).      %% etc
compword(for,[a,v�re,ved],til). 

   xcompword(for,[�,v�re,p�],til). 
   xcompword(for,[�,vere,p�],til). 
   xcompword(f�r,[�,v�re,p�],til). 
   xcompword(f�r,[�,vere,p�],til). %% no pardon

compword(for,[at,v�re,i],til).      %%  DK
compword(for,[at,v�re,p�],til).     %% 

compword(for,[v�re,i],til). 

    xcompword(f�rer,[til],for�rsaker).  %% problem f�rer=noun 


%% compword(f�r,[den],derf�r).       %% Technical  f�r dette blir verifisert *
%%    xcompword(f�r,[denne],derf�r). 
%% compword(f�r,[det],derf�r).       %% Dialog
%%    xcompword(f�r,[dette],derf�r). %% 

    xcompword(f�r,[�,v�re,i],til).   %% no pardon 
    xcompword(f�r,[ay,v�re,i],til).  %% no pardon %% TA-110518
    xcompword(f�r,[og,etter],rundt). %% rough   utenfor ? 

    xcompword(f�r,[klokka,blir],f�r). %% etc. ad hoc 

compword(f�r,[v�re,i],til).
compword(f�r,[v�re,p�],til).

    xcompword(for,[i,morgen],imorgen). %% TA-110401
 compword(for,[imorgen],imorgen).      %%

%% compword(for,[i],for�).          %%  in_order_to
compword(for,[idag],idag).       %%  hairy
compword(for,[kl,'.'],f�r).   
compword(for,[kl],f�r).  
compword(for,[klokka],f�r).  
compword(for,[komme,til],til).   

compword(for,[og,v�re,der],f�r).  %% ... // err
compword(for,[og,v�re,framme,f�r], f�r).   
compword(for,[og,v�re,framme,rundt], f�r).
compword(for,[og,v�re,framme], f�r). 
compword(for,[og,v�re,frem], f�r). 
compword(for,[og,v�re,fremme], f�r). 
    xcompword(for,[og,v�re,i],til).     %% TA-101206 %% ... // err
compword(for,[og,v�re,p�],til).    %% 
compword(for,[og,v�re,til],til).   %% 

%%%% compword(for,[og,v�re],til). %%  Haz? %% TA-101206

compword(for,[noe],[]). 
compword(for,[oppm�te],f�r). %% for oppm�te kl 8:15 p� ...

compword(for,[sein],forsinket). 
compword(for,[sen],forsinket).   
compword(for,[seint],forsinket). 
compword(for,[sent],forsinket). 

    xcompword(for,[s�,�,v�re,p�],til). 

compword(for,[s�,�],og).         %%  Rough 
compword(for,[s�],og).           %%   Rough 
compword(for,[til],til).         %%  fort til ? (Rough)

compword(for,[�,i],til).  
compword(for,[�,for],for).       %% repair
     %% compword(for,[�,komme],g�r).     %%  Harmful and unnec
     %% compword(for,[�,komme,til],til). 
compword(for,[komme,meg,til],til).  
compword(for,[�,komme,meg,til],til).

compword(for,[a,komme,til],til). 
compword(for,[at,komme,til],til). 
compword(for,[�,n�],til).  
compword(for,[�,p�],til).        %% ?????
compword(for,[�,rekke,det],[]). 
compword(for,[�,ta,buss,til],til).
%%% compword(for,[�,rekke],til).   rekke en avtale/buss
compword(for,[�,var,i],til).   

compword(for,[ay,'va|re',der],f�r). %% etc ad hoc 
compword(for,[ay,'va�re',der],f�r).

%%    xcompword(for,[�,v�re,der,etter],etter).  
%%    xcompword(for,[�,v�re,der],f�r).          %% suspended

compword(for,[�,v�re,fra],fra).   
compword(for,[�,v�re,fram,p�], til). 
compword(for,[�,v�re,fram], f�r). 
compword(for,[�,v�re,framme,f�r], f�r).  
compword(for,[�,v�re,framme,rundt], f�r).
compword(for,[�,v�re,framme], f�r). 
compword(for,[�,v�re,frem], f�r). 
compword(for,[�,v�re,fremme], f�r). 
%%   compword(for,[�,v�re,i],til). %% destroys in_order_to 
                                   %% n�r m� jeg ta bussen fra bekasinveien for og v�re i byen ca kl0900?
compword(for,[�,v�re,m�],til).     %% sp 

compword(for,[�,v�re,p�,p�],til).  %% difficult case 
compword(for,[�,v�re,p�],til).     %% Subsumes trans rule/ busaroundtimearrdep 
                                   %%  ... for � v�re p� ... 
   compword(for,[�,hver,p�],til).

%% compword(for,[�,v�re],til).   %% Ad Hoc EXPERIMENT 

compword(for,[�,komme,meg,til],til).  
compword(for,[ay,va�re,pay],til).
compword(for,[�,hv�re,p�],til). 
compword(for,[�,v�re,til],til). 
compword(for,[�,v�re,�],til).      %%  p/� neib  %% ... LAST
compword(for,[�v�re,der,til],f�r). %% ... kl 0900
compword(for,[�v�re,i],til).  
compword(for,[�v�re,p�],til).  
compword(for,[�,v�rep�],til). 
compword(for,[�v�rra,der,te],f�r).  
compword(for,[�v�rra,i,der,te],f�r). %% ?

%%     compword(for,[�,v�re],til).   %% .. for � v�re sentrum f�r %% Haz
                                     %% som jeg anser for � v�re

%% End FOR

    xcompword(f�r,[inn],mottar). %% etc. ad hoc 
    xcompword(f�r,[til],klarer). %% ad hoc, incomplete 



compword(fr,[til],til).     %% repair 
    xcompword(fr,[5,a],fra). %% slip
compword(fr,[a],fra). 
compword(fr,[�,n�],til).  %% for � n� 

    xcompword(fra,[direkte,fra],fra). %% repair 
    xcompword(fra,[her,jeg,er,n�],herfra).  %% TA-100909
    xcompword(fra,[her],herfra).  
    xcompword(fra,[n�,av],heretter).  %% 1.
    xcompword(fra,[n�],heretter).     %% 2.
    xcompword(fra,[hvor,og,n�r],n�r).  

compword(fra,['.'],fra). %% Ad Hoc 

compword(fra,[der,jeg,er,n�],herfra). 
compword(fra,[for],for).       %%  hvor tar jeg bussen fra for � %% Rough
compword(fra,['/',forbi],forbi).
compword(fra,[forbi],fra). 
compword(fra,[fra],fra).   %% repair
compword(fra,[f�r],fra). 
compword(fra,['/',til],forbi). 
compword(fra,[her,p�],fra). 
compword(fra,[herfra],herfra).
compword(fra,[herifra],herfra). 
compword(fra,[hvis],hvis).      %% ta bussen fra ... 
%% compword(fra,[i],i).   %% Repair hvor g� bussen fra i sentrum
% compword(fra,[i,n�rheten,av],fra). 
compword(fra,[hjem],hjemmefra). 
compword(fra,[hjemme],hjemmefra).
compword(fra,[med],med). %%  repair
compword(fra,[nr],nr).  
compword(fra,[nummer],nmmer). 
compword(fra,[n�,til,klokken],f�r). % ??? 
compword(fra,[n�,til],f�r). 
compword(fra,[n�r],n�r). %% Rough hvor skal jeg ta bussen fra n�r...
compword(fra,[og,med],efter).  
compword(fra,[p�],fra). %% reversed repair 
compword(fra,[rundt],fra).  
compword(fra,[sted],utgangspunkt). 
compword(fra,[til],til).        %% repair   
    xcompword(fra,[�,v�re,p�],til). %% fra  � v�re p� ikea= til 
compword(fra,[�],fra). 
compword(fraog,[med],efter).  


%  
    xcompword(f�r,[�,v�re,i],til).  
% compword(f�r,[�,v�re],til).  

    xcompword(f�r,[fra],forlater). 
    xcompword(f�r,[�,v�re,p�],til). 
    xcompword(f�r,[�,n�],til).  

compword(foran,[i],i).  
compword(forrerst,[i],i).           %%
compword(forbi,['/',til],til).  
compword(forbi,['/',i,n�rheten],forbi). 
compword(forbi,['/',i,n�rheten,av],forbi).
compword(forbi,['/',n�rheten],forbi).
compword(forbi,['/',n�rheten,av],forbi). 

compword(forbi,[bortenfor],forbi). 
compword(forbi,[etter],etter).     %% repair
compword(forbi,[fra],fra).         %% repair
compword(forbi,[her],hit).  
compword(forbi,[mot],mot).         %% repair ?
compword(forbi,[p�],forbi).        %%   prep2 ?
compword(forbi,[ved],forbi). 

compword(forbin,[delse],forbindelse). 

compword(forbli,[i],ankomme).  %% repair, forbli=forbi
compword(forbli,[p�],ankomme). 

compword(fordi,[om,det,er],[]). 

    xcompword(forel�pig,[bare],bare).  
    xcompword(men,[forel�pig,bare],bare). %% ad hoc ?

compword(forsen,[],forsinket).   %% 
compword(forsent,[],forsinket). 
compword(forsein,[],forsinket).
compword(forseint,[],forsinket). 


compword(fotball,[bussen],fotballbuss).  
compword(fra,[buss,fra],fra). 
compword(fra,[dit],dit). 
compword(fra,[hit],hit). %%
compword(fra,[f�r],allerede).
compword(fra,[heim],hjemmefra). 
compword(fra,[hvor,i],fra).  
compword(fra,[mot],mot).                  %% repair
compword(fra,[nord],nordfra). 
compword(fra,[s�r], s�rfra). 
compword(fra,[syd], s�rfra). 
compword(fra,[t],til).    %% Repair (forbi)
compword(fra,[til],til).  %%
compword(fra,[ved],ved).  %% repair
compword(fra,[vest],vestfra). 
compword(fra,[�st], �stfra). 

compword(framme,[f�r],f�r). %% Ikke x 
    xcompword(framme,[i],i).   
%%    xcompword(framme,[p�],p�).   %% som er framme p�
    xcompword(framme,[ved],ved). %%
    xcompword(fremme,[til],fremme). %% ? %% TA-100921 fremme official

    xcompword(fram,[til,n�],tidligere). %%  hittil -> tidligere
%%    xcompword(frem,[til,n�],tidligere). %% unnec
compword(fram,[til,da],tidligere). %% Rough

%% compword(fram,[til],inntil). %%  frem til i morra 
                                %%  jeg ser fram til et samarbeide

compword(framm�te,[f�r],f�r).  
compword(fram�te,[f�r],f�r).
compword(framm�te,[kl],f�r).  
compword(fram�te,[kl],f�r).
compword(framm�te,[f�r],f�r).  
compword(fram�te,[f�r],f�r).
compword(framm�te,[],f�r).  
compword(fram�te,[],f�r). %% etc 


compword(frem,[til,da],tidligere). %%

    xcompword(frem,[til],til). 
    xcompword(fram,[til],til).

    xcompword(fremme,[for], f�r). %%  f�r
    xcompword(fremme,[seneste], f�r). %% spell 

%% compword(fremme,[p�], til). %% n�r er jeg fremme p� Nardo %% TA-101108
compword(fremme,[til], til).  
compword(fullt,[mulig],mulig).  
compword(f�,[rste],f�rste).        %% f�#rste
    xcompword(f�ler,[meg],er). %% Ad Hoc ..trett %% TA-101117
compword(f�r,['/',etter],rundt). 
    xcompword(f�r,[at,v�re,der],f�r).  
compword(f�r,[den,som,g�r],f�r). 
compword(f�r,[etter],etter).       %%  repair
compword(f�r,[f�r],f�r).   
   compword(f�r,[i,morgen],idag).  
%% xcompword(f�r,[imorgen],idag).      %% f�r i morgen kl 12 \= idag kl 12

compword(f�r,[like,etter],etter).  %%
compword(f�r,[til],til).           %%  rep
compword(f�rst,[kommende],neste).
compword(f�rst,[som,sist],[]). 
    compword(f�rst,[skal],skal).  
compword(f�rste,[av],f�rste). 
compword(f�rste,[etter,n�],neste). 
compword(f�rste,[fra,n�],neste). 
compword(f�r,[i,kveld],ikveld). %% Rough
compword(f�r,[kvelden],ikveld). %%



compword(f�rste,[neste],neste). %% repair 

%%% compword(f�rste,[og,andre],begge). %% Ignored , loses precision

compword(f�,[bekreftet],vite).  %% rough lazy ad hoc
compword(fikk,[bekreftet],vet). %% .. n�
compword(f�tt,[bekreftet],vet). 

compword(f�,[se],vis).   
compword(f�,[h�re],vis).    %%  Rough

compword(f�,[meg],kj�re). %% f� meg ny billett * 
                          %% f� meg til NTH      %% <--

compword(f�,[opp],f�). 
compword(f�,[tak,i],f�). %% ta).  %% rough
compword(f�,[fatt,i],ta). %%
    xcompword(f�,[�,v�re,p�],til). %% (if error then xcomp...)


compword(f�r,[fra],forlater).       %% g�r fra 
   xcompword(f�r,[forbi],passerer).
compword(f�r,[i], g�r). %% confus
compword(f�r,[klokka], f�r).
compword(f�r,[meg], til). 

compword(g,['&',aring,r],g�r). 
compword(g,['�',�r],g�r). 
compword(g,[�r],g�r).  
compword(g,[r],g�r).  %% g?r   
compword(g,['?',r],g�r). %% g?r  
compword(g,[�r],g�r).  

%% compword(g, ['\214',r],g�r).   %% Sicstus 4 
%% compword(ga,['\205',r],g�r).   %% Sicstus 4
%% compword(ga,['\203',ayr],g�r). %% Sicstus 4 

compword(gang,[til], gang).     %% en gang til 

    xcompword(gang,[tid],gangtid).   %% TA-110419
    xcompword(gang,[tids],gangtid).  %%
    xcompword(g�,[tid],gangtid).     %% 
    xcompword(g�,[tids],gangtid).    %%

compword(ganger,[i,d�gnet],ganger).  %% Default
compword(ganger,[om,dagen],ganger).  %% Default 

    xcompword(gate,[adresse],gateadresse). 

    xcompword(godt,[hjulpet],hjulpet). %% old standard phrase 
    xcompword(godt,[over],over). 

    compword(greit,[det],ok).  
    compword(helt,[greit],ok). 
    compword(helt,[greit,det],ok).
% compword(gi,[deg],slutt).  %% Han kan gi deg informasjon 

compword(gi,[med],gi). %% gi meg 

compword(gi,[opp],slutt). 
compword(gir,[opp],slutter). 

    xcompword(gi,[seg,ut,for,�,v�re],etterligne). 
    xcompword(gir,[seg,ut,for,�,v�re],etterligner). 
    xcompword(ga,[seg,ut,for,�,v�re],etterlignet). 
    xcompword(gitt,[seg,ut,for,�,v�re],etterlignet).

compword(gitt,[at], hvis). 

compword(gi�,['�',r],g�r).         %% � tr�bbel

compword(gj,['?',r],gj�r). %% hva gj?r du 
compword(gjenta,[det,siste,du,sa],gjenta).

    xcompword(s�,[sm�tt],[]).     %% TA-110228
    xcompword(s�,[gjerne],redundant0).    %% grad+adv

    xcompword(gjette,[seg,til],gjette). %% lazy 
    xcompword(gjetter,[seg,til],gjetter).  
    xcompword(gjettet,[seg,til],gjettet).

compword(gj�r,[at,jeg,kan,komme],g�r).  
compword(gj�r,[oppmerksom,p�],sier).  
compword(gj�r,[rede,for],fortell). 

compword(gt,[gt],gt).  

compword(gruer,[meg,til,�],m�). %%  :-) 


compword(g�,[meg],g�).     %% avoid transitive go 
    xcompword(g�,[�],[]).    %% legg deg 
compword(g�r,[ankommer],ankommer). %% repair  
compword(g�r,[hvilke],g�r).   

    xcompword(g�r,[ma,jeg,ta],g�r). %% ??
    xcompword(g�r,[m�,jeg,ta],g�r). %% ?

compword(g�r,[meg],g�r). 
    xcompword(g�r,[�,v�re,p�],til). 
    xcompword(g�r,[neste,g�r],g�r).
%% compword(g�r,[ofte],g�r). 


compword(g��r,[g�r],g�r).       %% repair

%compword(g�,[avstand],gangavstand). 
compword(g�,[r],g�r). 
compword(g�,[�],[]). %% .. legg deg 

%% compword(g�,[til],ta).   %% g� til NTH           
%%  compword(g�r,[bra],passerer).  %% bra=fra ? %% Haz, det g�r bra 


compword(bussen,[g�r,bussen],bussen). %% repair (n�r g�r b g b) I was fooled

compword(g�r,[dem,en],g�r).    %% sp

compword(g�r,[de,ei],g�r). 
compword(g�r,[de,en],g�r).    %% nofunk
compword(g�r,[de,et],g�r). 

compword(g�r,[det,ei],g�r). 
%%%  compword(g�r,[det,en],g�r). %% nofunk %% g�r det en tidligere buss
compword(g�r,[det,et],g�r).    %%
    compword(g�r,[det,med],g�r).   %% \+ x hvordan g�r det med deg 

compword(g�r,[drar],g�r).      %% repair
%% compword(g�r,[e],g�r).      %%  slang   e=etter/er
%%  compword(g�r,[er],er).   %% Repair no %% n�r  bussen g�r er klokken 3
compword(g�r,[g�r],g�r).                %% Repair 
compword(g�r,[jeg,ta],g�r).     
%% compword(g�r,[ofte],g�r).               %% ignore
compword(g�r,[kj�re],kj�rer).           %% Repair .. 
compword(g�r,[kj�rer],kj�rer).          %%
compword(g�r,[kommer],kommer).          %% 
compword(g�r,[me],g�r).                 %%
compword(g�r,[m�],m�).                  %% 
compword(g�r,[neste,gang],g�r).  
    xcompword(g�r,[stopper],g�r). %% stopper?  %% repair 

%%% compword(g�r,[n�r],g�r).  %% g�r n�r? %% bussen g�r n�r trikken st�r 

%% compword(g�r,[n�r],g�r). %%   %% jeg g�r n�r bussen kj�rer

compword(g�r,[passerer],passerer).      %% Repair (doesnt help?)

compword(g�r,[ta],g�r). 
compword(g�r,[vil],passerer). 

compword(h,[p],holdeplass). 
compword(h,[pl],holdeplass).   %%
    xcompword(h,[va],hva). 
compword(ha,[behov,for,�],[]). 
compword(ha,[en,hyggelig,kveld],adj�). 

%% trouble in gram %% TA-100915

    xcompword(ha,[med,deg],bringe). 
    xcompword(ha,[med,meg],bringe). 
    xcompword(ha,[med,seg],bringe). 

    xcompword(har,[med,deg],bringer). 
    xcompword(har,[med,meg],bringer). 
    xcompword(har,[med,seg],bringer). 

    xcompword(hadde,[med,deg],brakte). 
    xcompword(hadde,[med,meg],brakte). 
    xcompword(hadde,[med,seg],brakte).

    xcompword(hatt,[med,deg],brakt). 
    xcompword(hatt,[med,meg],brakt). 
    xcompword(hatt,[med,seg],brakt).


compword(ha,[med],ha). 



compword(ha,[ha],hei).    %%  ???
compword(ha,[ha,ha],hei). 
compword(ha,[neste],g�r). %% ?  n�r ha neste

compword(ho,[ho],hei).    %% TA-101029


compword(hadde,[tenkt,meg,�],skal).   

compword(hadde,[m�ttet],m�tte). %% Ad hoc    aux(must,nil,past) %%
compword(hadde,[tenkt,meg],skal).  

    xcompword(hage,[by],hageby). %% problem Br�set hage by 

compword(hal,[9000],hal). %%  :-)
    xcompword(halv,[fem,fem],1645).    %% Experiment

compword(halv,[time],halvtime). 
compword(halv,[timen],halvtimen). 
compword(halve,[time],halvtime). 
compword(halve,[timen],halvtimen). 

compword(han,['/',hun],han).       %% (eller hun)
compword(har,[ankomst],ankommer).

compword(har,[avgang,fra],forlater). %%  *har avgang kl 12

compword(har,[behov,for,�],m�). 
compword(har,[d],g�r). %% sms har=g�r 
compword(har,[det,blitt,av],er). 
    xcompword(har,[det,kj�rt],kj�rte). %% Ad Hoc, grammar 
compword(har,[et,�nske,om],�nsker).   
compword(har,[forbi],passerere). %% g�r f.

compword(har,[f�tt],har). %% aux 

compword(har,[fra],forlater). %% SMS har =~g�r 
compword(har,[g�r],g�r).    

    xcompword(har,[hast],haster).  
    xcompword(har,[noen,hast],haster).  %% (ikke) noe h


compword(har,[man,hos],har).   
compword(har,[med],har).  
compword(har,[tenkt,meg,�],skal).   
compword(har,[tenkt,meg],skal).  
compword(har,[til],ankommer). %% SMS ordliste har=g�r 
    xcompword(har,[�,gj�re,med],gjelder). %%  har med ... � gj�re


compword(he,[he],hei). %% :-) 
    xcompword(hele,[tiden],alltid).   
    xcompword(hele,[tida],alltid).  

compword(hellig,[rute],   helligdagsrute).  
compword(hellige,[rute],  helligdagsrute). 
compword(hellig,[ruter],  helligdagsrute). 
compword(hellige,[ruter], helligdagsrute). 

compword(helst,[],[]).                  %% noe som helst

%% compword(har,[neste],g�r). %% sms har=g�r  %% Hvilken farge har neste buss
%% compword(henne,[],[]).    %% = hen %% noise 


    xcompword(her,[som],som). %% Sender over regtop her som skal %% rough 

compword(herfra,[p�],fra). 

    xcompword(hetter,[kl],etter). 

compword(hjem,[igjen],hjem).
%% compword(hjem,[igjenn],hjem). %% TA-110121 splitw
    xcompword(hjem,[fra],fra).  
    xcompword(hjem,[til],til).  

compword(hjemme,[fra],hjemmefra).  
compword(hjemme,[sida],hjemmesiden).
compword(hjemme,[siden],hjemmesiden).

compword(hold,[opp],adj�). 

compword(holde,[plass],holdeplass).  
compword(holde,[plassen],holdeplassen).
compword(holde,[plassene],holdeplassene).
compword(holde,[plasser],holdeplasser). 
%% compword(holder,[til],er).  -> %% gn  particlev2 
compword(holder,[plass],holdeplass).  
compword(holdt,[p�,med],gjort).  

compword(honn�r,[billett],honn�rbillett). 
compword(honn�r,[bilett], honn�rbillett). 
compword(honn�r,[rabatt], honn�rbillett).   

compword(hos,[meg],hjemme).
    compword(hos,[de],deres). 

compword(hurtigst,[mulig],[]).
compword(hurtigst,[r�d],[]).   %% kjappest r�d

compword(hv,[a],  hva).  
compword(hv,[9,ilken],hvilken).  %% slip
compword(hva,[annet],hva). 
compword(hva,[behager],hva). 
    xcompword(hva,[med],[]).                  %%  Hva med nth ?
%%     xcompword(hva,[buss],buss). %%  unnec
compword(hva,[for,en],hvilken).  
compword(hva,[for,et],hvilket). 

    xcompword(hva,[jeg,vil],alt).  
    xcompword(hva,[som,helst],alt).

compword(hva,[mer],hva). 
compword(hva,[om],[]).  
compword(hva,[slags], hvilket). 
    xcompword(hva,[som,helst], alt). %%  ?
    xcompword(hva,[tid,n�r],g�r). %% Ad Hoc
    xcompword(hva,[tid],n�r). 

compword(hvad,[for,en],hvilken).  %% DK
compword(hvad,[for,et],hvilken). 

compword(hvem,[der],hei). %% # hvem er du
compword(hver,[gang],n�r).   
compword(hvert,[�yeblikk],straks).   

compword(hviken, [vei], hvor).  
compword(hvilke, [av],  hvilke). 
compword(hvilken,[av],  hvilke).   %% prag: expects plu
compword(hvilket,[av],  hvilke).   %%

compword(hvilke,['/',hvilken],hvilken). 
compword(hvilke,['/',hvilket],hvilket). 
compword(hvilken,['/',hvilke],hvilke). 
compword(hvilket,['/',hvilke],hvilke). 

compword(hvilke,['\\',hvilken],hvilken). 
compword(hvilke,['\\',hvilket],hvilket). 
compword(hvilken,['\\',hvilke],hvilke). 
compword(hvilket,['\\',hvilke],hvilke). 


compword(hvilke,[fra], fra).  
compword(hvilken,[fra], fra). 
compword(hvilket,[fra],  fra). 

compword(hvilke,[bus,fra],fra).   
compword(hvilken,[bus,fra],fra).   
compword(hvilket,[bus,fra],fra). 
compword(hvilke,[buss,fra],fra).    
compword(hvilken,[buss,fra],fra).   

    xcompword(hvilken,[buss,og,n�r],n�r). 

compword(hvilket,[buss,fra],fra). 
compword(hvilke,[busser,fra],fra).  
compword(hvilken,[busser,fra],fra). 
compword(hvilket,[busser,fra],fra).  

compword(hvilken,[m�,jeg,ta],buss). %% rough

compword(hvilke,[og,n�r],  n�r). 
compword(hvilken,[og,n�r],  n�r).  
compword(hvilkent,[og,n�r],  n�r).   

compword(hvilken,[en],    hvilken).           %%  dial
compword(hvilken,[g�r,buss],buss).  
compword(hvilken,[som,g�r],buss).     %%  ?
compword(hvilken,[g�r],buss). 
compword(hvilken,[hvilken],hvilken).  %% Repair
compword(hvilken,[hvilket],hvilket).  %% 
compword(hvilken,[som,helst],alle). 
compword(hvilken,[vei],hvor). 
compword(hvilket,[hvilken],hvilket).  %% Repair
compword(hvilket,[hvilket],hvilken).  %%


compword(hvis,[for],for).      %%Repair
compword(hvis,[framme],f�r).  


    xcompword(hvis,[ikke],redundant0). %%  Haz

%% compword(hvis,[jeg,skal,v�re,p�],til). %% nec ? 
compword(hvis,[jeg,skal,hver,der],f�r). %% feil 
    
    xcompword(hvis,[v�re,p�],til).  

%% compword(hvis,[jeg],jeg). %% as a first in sent ! 

compword(hvor,[dan], hvordan).
compword(hvor,[fra,og,n�r],n�r).
    xcompword(hvor,[dan],hvordan). %% TA-110103  
    xcompword(hvor,[for],hvorfor).
%%  compword(hvor,[fort],n�r).  %% rough 

%%     xcompword(hvor,[f�r],hvorfor).    %% hvor f�r jeg busskort 

compword(hvor,[hvordan], hvordan). %% Repair
%% compword(hvor,[i], hvor).   %% hvor i trondheim ligger
compword(hvor,[jeg,ankommer],[]). 

    xcompword(hvor,[lang,tid,fra],fra). %% rough 
    xcompword(hvor,[langt,borte],hvor). 

compword(hvor,[mange,og,n�r],  n�r). 
%% compword(hvor,[mange,avganger,fra],fra).   %%  Rough Default
compword(hvor,[mange,minutter],  hvor).    %% .. forsinket
compword(hvor,[n�rmest],n�rmest).    %% ?

compword(hvor,[ofte,f�r],g�r). %% (rough) .. bussen til 

    xcompword(hvor,[og,n�r,neste],neste).  
    xcompword(hvor,[og,n�r],hvor). %% rough 
    xcompword(n�r,[og,hvor],n�r).  %% rough 


compword(hvor,[som,helst],[]). 
compword(hvor,[ti],n�r).   
compword(hvor,[tid],n�r).   
%%% compword(hvor,[sent],n�r).  %%no, ... last   %% Rough %% TA-100914
compword(hvor,[tidlig],n�r).   %% Rough

compword(hvord,[an], hvordan). %%
compword(hvordan,[fra], fra).  
   xcompword(hvordan,[g�,fra], fra).  
   xcompword(hvordan,[g�r,fra], fra). 
compword(hvordan,[og,n�r],n�r).  
compword(hvordan,[overganger,g�r], g�r).      %%  Rough
compword(hvordan,[reise],[]).   %% reise=trip
compword(hvordan,[skal,til], til). 
compword(hvordan,[type], hvilken). 
compword(hvordan,[�,komme,fra],fra).
compword(hvordan,[�,komme,til],til).

compword(hvorfor,[ikke],hvorfor).
compword(hvorfor,[hva],hva).                  %% Repair
compword(h�re,[til],tilh�re). 
compword(h�rer,[til],tilh�rer).        
compword(h�rte,[til],tilh�rte).     
compword(h�rt,[til],tilh�rt). 
compword(h�st,[rutene],h�strutene).   
    xcompword(h�yst,[sannsynlig],sannsynligvis). 

compword(i,[alt],[]). 
compword(i,[all,verden],[]).    %% NB not both in grammar and in dict
compword(i,[alminnelighet],redundant0). 
compword(i,[allverden],[]).  
compword(i,[alle,dager],[]). 

    xcompword(i,[allefall],redundant0). 
    xcompword(i,[alle,fall],redundant0).
    xcompword(i,[det,hele,tatt],redundant0).
    xcompword(i,[den,anledning],redundant0).
    xcompword(i,[det,hele,tatt],redundant0).  
    xcompword(i,[det,heletatt],redundant0).
    xcompword(i,[ettertid],etterp�).
    xcompword(i,[hvertfall],[]). 
    xcompword(i,[hvert,fall],[]).

compword(i,[blir,det,av],er).   %% ?
   compword(i,[ca],i).   
   compword(i,[ca],ca).     
compword(i,[cirka],i). 

compword(i,[der],der).                   %%  Repair Doesnt help

compword(i,[ett,tiden],1300).  
    compword(i,[1,sett],[]).      %% prelex 
    compword(i,[ett,sett],[]).    %% (not nec as redundant0) 
compword(i,[etter],etter).               %%  repair 
compword(i,[fag],idag). 
compword(i,[forhold,til],til).
compword(i,[forholdtil],til). 
    xcompword(iflg,['.'],if�lge).
compword(iforhold,[til],til). 
    xcompword(i,[henhold,til],if�lge). 

compword(i,[fra,n�r],n�r).  
compword(i,[fr�],ifra).      
compword(i,[f�lge],if�lge).     
compword(i,[f�r],f�r).           %% repair

compword(i,[gang],igang). %% -> ready (adj

compword(i,[g�r],ig�r).                  %%  Drop yester
%% compword(i,[gayr],ig�r). %%   i går // splitword

compword(i,[hele],i). 


compword(i,[hvilken,grad],hvordan).  
compword(i,[hvilket,intervall],n�r).     %%  Rough #hvor ofte
compword(i,[hvilken,intervall],n�r).     %% ?
compword(i,[i],i).                       %% Repair 
compword(i,[ikveld],ikveld).  
compword(i,[kilometer],[]).              %% repair
compword(i,[live],levende).  
compword(i,[l�pet,av],innen).  
    compword(l�pet,[av],innen). %% ?
compword(i,[mellem],mellom).   
compword(i,[mellom],mellom).  
compword(i,[morgen],imorgen).            %%  Drop morrow
compword(i,[mora],imorgen).  %% avoid mora = morning
compword(i,[morn],imorgen). 
compword(i,[morgen],imorgen). 
compword(i,[morra],imorgen).   %% avoid morra = morgen (tidlig) 
    xcompword(i,[natt],inatt).      %%  +i i (en) natt

compword(i,[n�rheten,av],n�r).

   xcompword(i,[n�rheten,at],n�r). %% at :  err -> x 
compword(fra,[n�rheten,av],fra). 
    
    xcompword(i,[om],om). %% repair 

    xcompword(i,[over,morgen],overimorgen). %% TA-110401



compword(i,[prinsippet],redundant0). 
compword(i,[p�],p�). 
compword(i,[retning,av],mot). 
compword(i,[retning],mot).  
compword(i,[retning,mot],mot).   
compword(i,[retur],tilbake). 
    
compword(i,[rundt],rundt).               %% Repair
%%     xcompword(i,[rute],presis). %%  buss i rute 52   
compword(i,[sin,helhet],[]). 

compword(i,[sta],tidligere). 
compword(i,[stad],tidligere). 
compword(i,[stand],istand). %% ready 
compword(i,[ste],tidligere). 

    xcompword(i,[steden,for],istedenfor). 
    xcompword(i,[stedet,for],istedenfor).
    xcompword(i,[stedenfor], istedenfor).  
    xcompword(i,[stedetfor] ,istedenfor). 

    xcompword(i,[s�fall],redundant0).  
    xcompword(i,[s�,fall],redundant0).  
    xcompword(i,[s�,tilfelle],redundant0). 


compword(i,[tilfelle],[]).
compword(i,[s�fall],[]). 

compword(i,[stor,utstrekning],redundant0). %% lazy 

compword(i,[stykker],�delagt). 

%%    xcompword(i,[stedet,for],unntatt). %% i stedet for � ta buss
%%    xcompword(i,[stedet],[]).          %% 

compword(i,[s�fall],[]). 
compword(i,[s�,fall],[]). 
compword(i,[rett,tid],presis).  
    xcompword(i,[tide],presis).   
    xcompword(i,[tid],[]).          %% korteste i tid
compword(i,[til],til).                   %% Repair
%% compword(i,[tillegg],[]). %% -> sem. 

%% compword(i,[tilfelle],[]).  %%  hvis
%% compword(i,[tillfelle],[]). 
compword(i,[tilfelle],hvis). %%  I tilfelle, hva er forskjellen 

compword(i,[�stlig,retning],�stover).
compword(i,[nordlig,retning],nordover). 
compword(i,[sydlig,retning],s�rover). 
compword(i,[s�rlig,retning],s�rover).
compword(i,[vestlig,retning],vestover).
%% compword(i,[�], �). %% vits i �  %% -> gram 

   xcompword(i,[dag,da],da).  
   xcompword(id,[ag],idag). 
   xcompword(id,[kort],legitimasjon). 
   xcompword(id,['-',kort],legitimasjon).

compword(idet,[hele,tatt],[]).
compword(idet,[heletatt],[]).

compword(idretts,[anlegget],idrettsanlegget).
compword(idretts,[plassen],idrettsplassen).  

% ikke

    xcompword(ikke,[annet,en],[]).  
    xcompword(ikke,[annet,enn],[]).
    xcompword(ikke,[lenger],ikke).  
    xcompword(ikke,[like,mange],f�rre).
    xcompword(ikke,[mange],f�tallig). %% f�=verb tr�bbel
    xcompword(ikke,[ment,�,v�re],ikke). 
 
%% compword(ikke,[noe],ikke).    %% ikke noe morsomt 
                                 %% jeg vet ikke noe

%%      xcompword(ikke,[f�],mange).    %% s� vil dere ikke f� 
    xcompword(ikke,[noen],ingen).

    xcompword(ikke,[alle],noen). %% rough -> gram notall 
    %% = noen by Griecean convention
    %% if actually none, that would have been said.

    xcompword(ikke,[akkurat],ikke).
    xcompword(ikke,[nattbuss],[]). %% default rough 
    xcompword(ikke,[f�r],etter).  
    xcompword(ikke,[glem],husk).  

    compword(ikke,[triviell],ikketriviell).  
    compword(ikke,[trivielle],ikketrivielle). 
    compword(ikke,[triviellt],ikketrivielt). 

compword(ikke,[verst],bra). 
    xcompword(ikke,[vil,v�re,for,sen,til],rekker). %% Ad Hoc 
compword(ikke,[v�rst],bra).


compword(il�pet,[av],innen). % den neste timen 
compword(im,[orgen],imorgen). %% ?

    xcompword(imorgen,[tidlig],imorgen). %% rough 
    xcompword(morgen,[tidlig],morgen).   %% rough

compword(in,[til],til).  %% spoil language det ? 
compword(ingen,[andre,enn],[]).             %%  rough 
compword(ingen,[andre,busser,enn],[]). 

compword(ingen,[fare,for],umulig). 
% compword(ingen,[flere],ruter).    %% OBS. retorisk/ellipsis(doesntwork)
compword(ingen,[�rsak],ok).  

compword(inn,[i],til).    %% TA-100830
%% compword(inn,[i],inni).             %% .. bussen
    xcompword(innom,[her],her). 
    xcompword(inntil,[da],heretter). 
    xcompword(inntil,[videre],heretter).

compword(inn,[til],til). 
    xcompword(innover,[til],til). %% 
    xcompword(utover,[til],til).  %%

compword(internett,[side],hjemmeside).
compword(internt,[i],i).

    xcompword(iphone, [vennlig],vennlig). %% rough

    xcompword(ip,[adresse],ipadresse).
    xcompword(ip,[nummer],ipadresse). 

    xcompword(istedetfor,[], istedenfor). 
    xcompword(istedet,[for], istedenfor). 
    xcompword(isteden,[for], istedenfor).  

compword(itj,[no],ingen). 
compword(itj,[n�],ingen). 

compword(j,['?',eg],jeg). %% ??
compword(j,[eg],jeg).

    xcompword(ja,[men],[]).   %% TA-101221
compword(ja,[ja], ja).           %%  Repair
compword(ja,[takk],ja).          %%  Dialog

compword(jeg,[jeg], jeg).        %% Repair

compword(jeg,[m�,v�re,der,f�r],f�r).  
compword(jeg,[m�,v�re,der],f�r).       %% 

    xcompword(jeg,[personlig],jeg).
    xcompword(jeg,[selv],jeg).

compword(jeg,[gir,opp],adj�).

    xcompword(jo,[da],ja). 
    xcompword(jo,[det,er,det],ja). %% TA-101124
    xcompword(nei,[da],nei). 
    xcompword(jo,[fordi],[]). %%  ?-)
    xcompword(nei,[fordi],[]). %% 

%%     xcompword(jeg,[sier,at],[]).  %% Too rough
%%     xcompword(jeg,[sier],[]). 

compword(jeg,[skal,v�re,der,f�r],f�r). 
    compword(jeg,[skal,v�re,der],f�r).     %% Hazardous %%  hvis...
compword(jeg,[skal,buss],buss). 
compword(jeg,[slik], slik).      %% Freak  jeg tar bussen jeg, slik at 
compword(jeg,[vil,buss], buss). 
    xcompword(jeg,[vet,ikke,men],[]). 

compword(jern,[bane],jernbane). 

compword(kr,[himmel,farts,dag],ascension_day).   

compword(kristelig,[himmelfarts,dag],ascension_day).  
compword(kristelig,himmelfartsdag,ascension_day).  

compword(kristi,[himmelfarts,dag],ascension_day). 
compword(kristi,himmelfart,ascension_day).     
compword(kristi,himmelfartsdag,ascension_day).  

compword(kristlig,[himmelfarts,dag],ascension_day).  
compword(kristlig,himmelfartsdag,ascension_day).   


compword(jul,[dag],christmas_day). %% ...
compword(jule,[dag],christmas_day).
compword(jul,[dagen],christmas_day).
compword(jule,[dagen],christmas_day).

    compword(jule,[og],[]). %% .. vinterruter rough 

compword(jule,[ruta],juleruta).  

compword(k,[veld],kveld).  
compword(ka,[f�r], hvilken).  

    xcompword(ka,[tid], n�r). %% TA-110609

compword(kajeg,[ta],g�r).         %% 
compword(kan,[d,varsle],varsle). 

    xcompword(kan,[godt],kan). %% rough 

compword(kan,[jeg,ta,som],[]). 
compword(kanjeg,[ta],g�r).  


compword(kan,[�],kan).            %% (dial)

compword(kilometer,['/',t],kmt). %% split km -> kilometer
compword(kilometer,['/',time],kmt).
compword(kilometer,[pr,time],kmt).
compword(kilometer,[i,timen],kmt).


compword(kj�pe,[senter],kj�pesenter). 

compword(kl,[0,kka],klokken). 
compword(kl,[0,kken],klokken). 

compword(kl,[okka],klokken). 
compword(kl,[okken],klokken). 
compword(kl,[okkan],klokken). %% ?

compword(klippe,[kort],klippekort). 

%% Ad Hoc    kl 17   = 1700, kl 17.10 = kl 17

%% Til nyg�rdsveien kl17.15  Jeg kan ikke finne forbindelser til  Nyg�rdvegen 17

/** doesnt work

compword(kl1,['.'],              01). 
compword(kl2,['.'],              02). 
compword(kl3,['.'],              03). 
compword(kl4,['.'],              04). 
compword(kl5,['.'],              05). 
compword(kl6,['.'],              06). 
compword(kl7,['.'],              07). 
compword(kl8,['.'],              08). 
compword(kl9,['.'],              09). 


compword(kl10,['.'],            10). 
compword(kl11,['.'],             11). 
compword(kl12,['.'],             12). 
compword(kl13,['.'],             13). 
compword(kl14,['.'],             14). 
compword(kl15,['.'],             15).
compword(kl16,['.'],             16). 
compword(kl17,['.'],             17).
compword(kl18,['.'],             18). 
compword(kl19,['.'],             19).
compword(kl20,['.'],             20). 
compword(kl21,['.'],             21).
compword(kl22,['.'],             22).
compword(kl23,['.'],             23).
compword(kl24,['.'],             24). %%

*/





compword(kl,[ca,kl],klokken). 
compword(kl,[ca],klokken).   

compword(klo,[kken],klokken).  
compword(klokk,[en],klokken).

compword(klokka,[kl],klokken).                %% repair
compword(klokken,[er,blitt],klokken).   
compword(klokken,[er,over],klokken).          %%   ... etter klokken ...
compword(klokken,[etter],etter).              %% Repair  rough ...etc
compword(klokken,[har,blitt],klokken).  
compword(klokken,[klokken],klokken).  

compword(klokkeslettet,[n�r],n�r). %% Ad Hoc



compword(kl�bu,[ruta],kl�buruta). 

compword(kollektiv,[kj�ret�y],rute).  
compword(kollektiv,[trafikk],trafikk). %% rough

compword(kom,[igjen],kom).  
%% compword(kom,[�],[]).           %% kom � gi meg en klem 
%% compword(komme,[med],rekke).    %% Jeg vil komme med buss

compword(komme,[p�],ankomme).   %% \+ v�re p� 
compword(kommer,[p�],ankommer). %% 


compword(kommer,[til,�],vil). %%

compword(kommer,[det,til,�],det).             %% ROUGH 
compword(kommer,[g�r],g�r). 

    xcompword(kommer,[passerer],passerer). %% repair %% TA-110330
    xcompword(kommet,[til],ankommet). %% ad hoc

compword(kong,[haakon],haakon). %% this is really a matter of busdat
                                %% part word assembly problem
    xcompword(kor,[tid],n�r).       %%
    xcompword(kor,[ti],n�r).        %% 


    xcompword(kort,[tid,etter,det],etterp�).  
    xcompword(kort,[tid,etterp�],etterp�).  

compword(kort,[tid,etter],etter).         % 1    
    xcompword(kort,[tid,etter],etterp�).  % 2     %% tricky sequence

    xcompword(korte,[ned],forkorte).

compword(kos,[n],hvordan). 
compword(koss,[n],hvordan). 
compword(koss,[d,g�r],hei).  
compword(koss,[det,g�r],hei).    
compword(kossn,[vi,kj�m,oss],buss).          %% Freak
compword(koste,[r],koster).  
compword(koster,[er],koster).  
compword(koster,[det,for,et],koster). 
%% compword(koster,[�,ta],koster).  


compword(kristi,[himmelfartsdag],ascension_day).
%% etc  ->>> busdat

compword(kryss,[mellom],[]).   %% ... A og B
compword(krysset,[mellom],[]). %%

compword(kvantum,[klippekort],klippekort).  
compword(kveld,['/',natt],kveld). 
compword(kveldens,[busser],kveldsbusser). %% etc ad hoc
compword(kveldens,[siste],siste).         %% rough
compword(kvelds,[tid],kveldstid).  

compword(l,[0],10). %%  etc
compword(l,[5],15). %% 
compword(l,[8,r],senere). %%  sms l8r
compword(la,[oss,si],[]). 

    xcompword(la,[seg,gj�re],gj�res).         %% TA-110330
    xcompword(la,[seg,tilpasse],tilpasses).   %% Ad Hoc, Rule ??? %% 

compword(lagt,[til,rette],bra). %% Rough
compword(lagt,[tilrette],bra).  %% 

compword(lagt,[ut],betalt). %% Haz %% .. filer .

compword(lang,[avstand],langt).  
    compword(langt,[fra],ikke). %% obs er det langt fra nth til nardo?

compword(lang,[fredag],langfredag). 
compword(lang,[reisetid],langt).  
compword(langt,[oppe,p�],p�).                %% :-)
compword(langt,[unna],n�r).  
compword(lar,[meg,komme],g�r).  

    xcompword(later,[som,om],pretenderer). 

compword(lav,[entre],laventrebuss).   
compword(laventre,[buss],laventrebuss).   
compword(legge,[seg],slutte).              %%  rough
compword(legge,[til],si). 

compword(lei,[meg],trist).                 %% :-(
compword(lei,[seg],trist).                 %% 
compword(lei,[deg],trist).                 %% 

compword(lettere,[kan],kan). %% ad hoc 

compword(ligger,[vi,an,med],g�r). %% rough,

    xcompword(like,[f�r],f�r). 
compword(like,[etter],etterp�). 
compword(like,[etterp�],etterp�).          %%
compword(like,[godt],[]).  
compword(like,[over],etter).  
compword(like,[ved],n�r).  
compword(like,[ved,p�],n�r).     %% 
compword(lille,[julaften],little_christmas_eve).  %%   Norwagism
compword(lille,[juleaften],little_christmas_eve). 
compword(linje,[nr],rute). 
compword(list,[opp],list).  
compword(liste,[over,n�r],n�r).  
    xcompword(litt,[annen],annen). %% TA-110331 .. sak
compword(litt,[av],[]). %% en luring 
compword(litt,[over,halv],halv). %% rough
    xcompword(lov,[til],lov). %% probl. %% lov til � 
    xcompword(litt,[over],etter).
compword(lykke,[til],adj�). 
compword(l,[rdag],l�rdag). % l;rdag  
compword(l�,[rdag],l�rdag). %l��rdag?   
compword(l�nner,[det,seg,�,ta], g�r).         %%  Rough

    xcompword(l�r,[rute],l�rdagsrute). 
compword(s�n,[rute],s�ndagsrute). %%

compword(l�rdag,['/',s�ndag],weekend). 
compword(l�rdager,['/',s�ndager],weekend).  
compword(l�rdag,[rute],l�rdagsrute). 
    xcompword(m,[�],m�). %% trouble with � 

    xcompword(men,[som],som). %% TA-110701

compword(mlm,['.'],mellom). 


compword(mye,[forsinket],forsinket). 
    xcompword(mye,[mer],mye). 

    xcompword(man,[fre],hverdager). %% avoid man=en 

compword(man,['.'],mandag). 
compword(tir,['.'],tirsdag).
compword(tirs,['.'],tirsdag).
compword(ons,['.'],onsdag).  
compword(tors,['.'],torsdag). 
compword(fre,['.'],fredag). 
compword(l�r,['.'],l�rdag).  
compword(s�n,['.'],s�ndag).  

compword(man,[dag],mandag). 
compword(tir,[dag],tirsdag).
compword(tirs,[dag],tirsdag).
compword(ons,[dag],onsdag).  
compword(tors,[dag],torsdag). 
compword(fre,[dag],fredag). 
compword(l�r,[dag],l�rdag).  
compword(s�n,[dag],s�ndag).  


compword(man,[dagen],mandag). 
compword(tir,[dagen],tirsdag).
compword(tirs,[dagen],tirsdag).
compword(ons,[dagen],onsdag).  
compword(tors,[dagen],torsdag). 
compword(fre,[dagen],fredag). 
compword(l�r,[dagen],l�rdag).  
compword(s�n,[dagen],s�ndag).  


compword(man,[dan],mandag).
compword(tir,[dan],tirsdag).
compword(tirs,[dan],tirsdag).
compword(ons,[dan],onsdag).  
compword(tors,[dan],torsdag). 
compword(fre,[dan],fredag). 
compword(l�r,[dan],l�rdag).  
compword(s�n,[dan],s�ndag).  


compword(man,[jeg,ta],g�r). %% m� jeg ta
compword(man,[fre],hverdager). 
    xcompword(man,[til,fre],hverdager). 


compword(mandag,[til,fredag],hverdager).  
compword(manglende,[punktlighet],forsinkelser). 
compword(me,[jeg,ta],g�r).  %% me \== m� (Haz)
    xcompword(med,[hilsen],hilsen). 
    xcompword(med,[med],med). 

compword(med,[ankomst,f�r],f�r). 
compword(med,[ankomst,n�r],f�r).   %%  Rough

compword(med,[ankomst],f�r).   %% TA-110610
compword(med,[avgang],etter).  %% 

compword(med,[det,f�rste],snart).
compword(med,[en,gang],n�). 
compword(med,[fra],fra). 
compword(med,[gratis],gratis).  
compword(med,[hjem],hjem). %% meg hjem

    xcompword(med,[inntil],med). %% 250 kr

    xcompword(med,[i,regningen],[]). %% rough

    xcompword(med,[i],i). %% er jeg med i en buss ? (\+ x) %% TA-101006

    xcompword(med,[l�rdagsrute],l�rdag). 
    xcompword(med,[s�ndagssrute],s�ndag).

compword(med,[overgang,til],til). %% rough 
compword(med,[p�],med).   %% p� ? 

    xcompword(med,[tanke,p�],for). 
compword(med,[unntak,ab],unntatt).  %% sp
compword(med,[unntak,av],unntatt). 

compword(meg,[jeg], jeg).   %% meg 
%% compword(meg,[jeg,ta], g�r). %% Nofunk
compword(meget,[bra],bra). 
compword(mellom,[etter],etter).
compword(mellom,[f�r],f�r). %% repair
compword(mellom,[fra],fra). %% repair
compword(mellom,[i,ca],i).  %% .. tiden
compword(mellom,[n�,og],f�r). 
compword(mellom,[til],til).     %% repair

compword(men,[etter],etter).  
compword(men,[f�r],f�r).  

compword(men,[ikke,med],unntatt).
compword(men,[ikke],unntatt). 
compword(men,[om],[]). 
compword(menes,[med],er). 

    xcompword(mer,[om],om).

compword(mest,[mulig,av],[]).  
compword(mulig,[av],[]).   %% (mest noisew)

%% compword(mulig,[for,meg],mulig).  %% Trouble somewhere 

%% mulig for meg som har billett

%% compword(mulig,[for,deg],mulig).  %%
%% compword(mulig,[for,noen],mulig). %%

    xcompword(fra,[midt,i],fra). 
compword(midt,[i],i).   
compword(midt,[p�],p�).    

    xcompword(midtby,[bilett],midtbybillett).  
    xcompword(midtby,[billett],midtbybillett).  
    xcompword(midtby,[billetten],midtbybilletten). 
    xcompword(midtbyn,[billetten],midtbybilletten).

compword(minne,[meg],varsle).  
compword(minner,[meg],varsler).  
compword(minne,[meg,p�],varsle).  
compword(minner,[meg,p�],varsler). 
compword(minner,[om],vet).   

compword(minste,[alder],aldersgrense). 
compword(mitt,[bosted],[]). %% Voll 
compword(mnd,[kort],m�nedskort). 
compword(mnd,[merke],m�nedskort).  
compword(mnd,[merker],m�nedskort).  %%
compword(morgen,['/',formiddag],formiddag). 
compword(morgen,[buss],morgenbuss). 
compword(morgen,[bussen],morgenbussen). %% 
compword(morgenen,[av],morgenen). %%  (fra) ...

    xcompword(moro,[skyld],moro). %% TA-110627 :-)

compword(mot,[fra],fra). %% Repair   
compword(mot,[mot],mot). 
compword(mot,[nord],nordover). 
compword(mot,[s�r],s�rover).
compword(mot,[syd],s�rover).  
   xcompword(mot,[til],til).      %%  Repair
compword(mot,[vest],vestover).
compword(mot,[�st],�stover).
%% compword(mus,[eum],museum). 
compword(m�,['+'],m�).        %% �-tr�bbel  
compword(m�,[eg,at],g�r).     %% confus
    compword(m�,[g�r],g�r). %% repair

compword(m�,[jeg,va],g�r).    %% N�r m� jeg va bussen 
   xcompword(m,[j,ta],g�r).  
   xcompword(m,[jeg,ta],g�r).  
   xcompword(m�,[ja,ta],g�r).  

%%   xcompword(m�,[jeg,da],g�r).     %%  da ta -> ta // da->ta 


compword(m�,[jeg,for,�,komme],g�r). 

    xcompword(m�,[jeg,fra],forlater).%%  hvilken buss må jeg fra hegdalen for å 
%% compword(m�,[jeg,fra],fra). 

compword(m�,[jeg,hvis,jeg,skal],g�r). %% hvilken buss [ m� jeg hvis jeg skal] til s
compword(m�,[jeg,p�],g�r).     
    xcompword(m�,[jeg,tabuss],g�r). %% (ad hoc splitword) X

compword(m�,[jeg,ta,som],[]). %

    xcompword(m�,[jeg,to],g�r). %% .. bussen 

compword(m�,[man,for,�,komme],g�r). %% rough %%  ..ta..
compword(m�,[n�r,g�r],g�r).   %% repair  n�r....
%% compword(m�,[ta],g�r).        %%  ?????
compword(m�,[tar],g�r).       %% confus 

    xcompword(hva,[m�,til,for,�],hva). 

%% compword(m�,[v�r,der],f�r). %% jeg m� v�re der senest 
compword(m�,[v�re,der,kl],f�r).   
%%     xcompword(m�,[v�re,der,senest],f�r). %% jeg ...
compword(m�,[v�re,der],f�r).  
    xcompword(m�,[v�re,der,ca],f�r). 
compword(m�,[v�re,framme],f�r). %% 
compword(m�,[v�re,i],til). 

%%     xcompword(m�,[v�re],ankommer). %%  .. senest

compword(m�,[�],m�).  
compword(m�jeg,[ta],g�r).  
compword(m�nedskort,[buss],m�nedskort). 

compword(m�r,[m�],m�).         %%  Repair

    xcompword(m�tte,[sitte,p�],passere). %% X %% Rough uten � m.. til

%compword(na,['\203',ayr],n�r). %% etc
%compword(ga,['\203',ayr],g�r). 

    xcompword(g,[&,r],g�r).  %% TA-100914
    xcompword(n,[&,r],n�r).  %% TA-100914
compword(n,[2,r],n�r).     %%  sms �-tr�bbel
compword(n,['.'],nummer). 
compword(n,['�',�r],n�r).  %% �-tr�bbel

compword(n,[i,neste],neste). %% n i = n g (sms)
compword(n,[i,buss],buss).
compword(n,[i,bussen],bussen). % etc ???

compword(nord,[og,ned],nordover). %% :-( 

compword(v,[11],7).   %% VII
compword(v,[11],vii). %% 7

compword(v,['&',230,re],v�re). 
compword(v,['?',�re],v�re).    %% � tr�bbel 

    xcompword(v,[g,s],vgs).   
    xcompword(v,['.',g,'.',s],vgs). 

compword('&',[229],�).     
compword(m,['&',229],m�).  
compword(n,['&',229],n�).  
compword(n,['&',229,r],n�r). 
compword(p,['&',229],p�).   
compword(pr,['.'],per). 

    xcompword(med,[retur],tilbake).  
compword(m,[retur],tilbake).     %%
compword(m,['.',retur],tilbake). %%

compword(n,[este],neste). 

%% compword(n,[g],g�r).  %% N�R G�R (n \= n�r) %%  n g n b

%% compword(n,[gayr],g�r). %% split 
%% compword(n,[g�r],g�r).  %% n�r g�r 
compword(n,[m�],m�).  %% n�r/neste m� jeg // Rough 
compword(n,[r],n�r).  %% n?r 
compword(n,[�r],n�r). %% n��r   neib k 
compword(n,['?',r],n�r). %% n?r 

compword(n,['�',�r],n�r). 
compword(n,[�r],n�r).  

compword(ni�,['�',r],n�r).         %% 
%% compword(na,['\203',ayr],n�r).     %%%% Sicstus 4 
%% compword(na,['\205',r],n�r).       %%
%% compword(n,['\214',r],n�r).        %%

compword(naar,[neste],g�r). %%  Rough

compword(nat,[bus],nattbuss).   
compword(nat,[buss],nattbuss).  
compword(natt,[bus],nattbuss).   

compword(natt,[bussrute],nattbuss). 
compword(natt,[bussruten],nattbussen).
compword(natt,[bussruter],nattbusser).



compword(natt,[buss],nattbuss).       %%  unnec
compword(natt,[bussen],nattbussen).  
compword(natt,[bussene],nattbussene). %%  
compword(natt,[busser],nattbusser).   %%

    xcompword(natt,[trikk],trikk).      %%  rough  unpriority
    xcompword(natt,[trikken],trikk).  
compword(natt,[trikker],trikk).  %%
compword(natt,[trikkene],trikk). %%

compword(natt,[rute],nattbuss). 
compword(nattbussen,[e],nattbuss).   
compword(nattbussen,[rute],nattbussen). 

    xcompword(naturlig,[nok],naturligvis). 

    xcompword(ne,[3,ste],neste). %% neib 
    xcompword(ne,[4,ste],neste). 
    xcompword(ne,[ste],neste).  

compword(nei,[nei],nei).  %% Repair
compword(nei,[takk],nei). %% Dialog 
    xcompword(nei,[tvertimot],nei).  
    xcompword(nei,[tvert,i,mot],nei).
    xcompword(nei,[tvert,imot],nei). 
    xcompword(tvertimot,[],nei).   
    xcompword(tvert,[i,mot],nei).    
    xcompword(tvert,[imot],nei).     


compword(neimen,[om],[]). %%  :-) ikke faen om ...

    xcompword(javel,[men],[]). 
    xcompword(neivel,[men],[]). 

compword(nest,[nest],tredje). %%  siste/nest nest siste
compword(nest,[neste],tredje).  
compword(nest,[raskest],[]). %% :-) 

%% compword(neste,[buss,etter],andre).    %%  neste buss etter 1130
 compword(neste,[buss,etter,den],andre).  

compword(nesten,[alle],mange). %% rough 

compword(neste,[buss,etter,neste],andre). 
    xcompword(neste,[buss,neste],neste).       %% repair 

    xcompword(neste,[buss,n�r],n�r). 

compword(neste,[de],de). 

compword(neste,[deretter],neste).  
compword(neste,[der,igjen],neste).  
compword(neste,[der,igjen,da],neste). 
compword(neste,[det],neste).  
compword(neste,[etter,f�rste],andre). 
compword(neste,[etter,nest],andre).  
compword(neste,[etter,neste],andre).
compword(neste,[etter,neste,etter,neste],tredje). %% :-) limit
compword(neste,[etter,n�],neste).
%%  compword(neste,[fra],fra).  %% n�r g�r neste fra buss gl�shaugeb

    xcompword(neste,[fra,buss],fra).  %% ?

compword(neste,[f�rste],f�rste).  
compword(neste,[gang],heretter).   
compword(neste,[ganger],heretter). 
compword(neste,[to,ganger],heretter).  %% veldig Ad Hoc
compword(neste,[2,ganger],heretter).   %%
compword(neste,[3,ganger],heretter).   %%
compword(neste,[nr],neste).  
compword(neste,[p�],neste).  
%% compword(neste,[til],neste).  %% 3 neste til nardo
compword(neste,[tre,ganger],heretter).

    xcompword(nesten,[alle],alle). 
    xcompword(nesten,[til],til).  

    xcompword(nettopp,[innom,her],her). %% ad hoc, difficult 

compword(noe,[annet],noe). 

compword(noe,[av],[]).  %% som jeg ikke forst�r noe av
compword(noe,[annet,enn],ikke).  %%  Rough
compword(noe,[mere,enn],[]). 
compword(noe,[mer],noe).  
compword(noe,[mer,enn],[]). 
compword(noe,[mer],mer). 
compword(noe,[mere],mer). 

compword(noe,[om,at],at). %% Rough

    %% compword(noe,[som],som).  %% ? det skjedde noe som jeg likte 

    xcompword(noe,[i,retning,av],[]). %% TA-110330 ? :-)
    xcompword(noe,[i,retning],[]).    %% 

    xcompword(noen,[andre],noen). %% Rough in dialog 
    xcompword(noen,[av,de],de).       %%  rough
    xcompword(noen,[av,disse],disse). %% 
    xcompword(noen,[av,mine],mine).   %% 
%%     xcompword(noen,[av],noen).     %% TA-110428  noen [av] v�re
    xcompword(noen,[form,for],noen). 
    xcompword(noen,[flere],flere).
    xcompword(noen,[f�],f�). 
    xcompword(noen,[gang],[]).        %% ?
    xcompword(noen,[ganger],tidvis).  %% TA-110111

%% Trouble spot 
    xcompword('.',[nr,'.'],nr).
    xcompword('.',[nr],nr).  
    xcompword(nr,['.'],nr).     %% hvilket nr . g�r // ikke ruteplan
    xcompword(nr,[':'],nr).  

%% compword(nr,['.'],nummer).  %% gets priority (alphabetic)

compword(nr,[m,jeg],jeg).
compword(nr,[buss],buss).  
compword(nr,[bussen],bussen). 
compword(nr,[f�rste],f�rste).  %% repair
compword(nr,[gr,nste,buss],buss).
   xcompword(nr,[nr],nr).      %% repair

/* nar splitword 
compword(nar,[buss],buss).   %% Rough 
etc...
*/

compword(norges,[nasjonaldag],may17).  

compword(nor,[og,hvilke],    hvilke). 
compword(nor,[og,hvilken],   hvilken). 
compword(nor,[og,hvilket],   hvilket).  

compword(norges,[nasjonaldag],may17).  

compword(naar,[g�r],g�r).  %%  Rough  
compword(naar,[gar],g�r).  % �-tr�bb 
compword(naar,[gr],g�r).   %
compword(naar,[gaar],g�r). %% �-tr�bbel


%% compword(nr,[g�r],g�r).  %%  Rough 
compword(nr,[gar],g�r).  % �-tr�bb 
compword(nr,[gr],g�r).   %
compword(nr,[gaar],g�r). %% �-tr�bbel

compword(nr,[p�,buss],buss). 
compword(nummer,[buss],buss). 
compword(nummer,[p�,buss],buss). 

compword(nytt,[�rsaften],new_years_eve). 

    xcompword(nyttiggj�re,[seg],bruke).

compword(nytt�rs,[aften],new_years_eve). 
compword(nytt�rssaften,[],new_years_eve). %% spiw %% TA-110203
compword(nytt�rs,[dag],nytt�rsdag). 
compword(nytt�rs,[helga],helgen). %% anb on purp 


compword(n�rmere,[kl],f�r).  %% = f�r kl Rough  
compword(n�rmes,[te],n�rmeste). 
compword(nermest,[mulig],n�rmest). 
compword(n�rmest,[mulig],n�rmest). 
compword(n�rmeste,[tid],heretter). 

compword(n�yaktig,[n�r],n�r). 
compword(n�yaktig,[p�],p�). 

    xcompword(n�,[da],n�). %% Norw %% TA-110112
compword(n�,['+',r],n�r). %% �-tr�bbell
compword(n�,[f],fra). 
compword(n�,[fra],fra).  

compword(n�,[fram,til],ankomme). 
compword(n�,[frem,til],ankomme). 

compword(n�,[fram,til],til).  
compword(n�,[frem,til],til). 

%% compword(n�,[g�r],g�r). %% N� g�r bussen -> n�r g�r.. 
                           %% .. og n� g�r bussen

compword(n�,[jeg,skal,v�re,der],f�r). %% n�(r), Ad Hoc 
compword(n�,[jeg,senest,skal,v�re,der],f�r). 


compword(n�,[jeg,skal,v�re,i],  til). %% n�(r), Ad Hoc 
compword(n�,[jeg,ta],g�r).            %% n�
compword(n�,[kl],n�). %% klokka overrides 
compword(n�,[klokka],n�). 
compword(n�,[klokken],n�). 
compword(n�,[5,r],n�r).  %%  n�5r g�r bussen. slip 
compword(n�,[r],n�r).  
compword(n�,[rm�],[]).  %% AVOID n� m� ... f�r = now and before

    xcompword(n�,[som],som). %% Jeg s�kte p� rute 5 n� som passerer begge..

compword(n�,[ta],tar).  %% repair (m� ta)

%%% compword(n�r,[5],n�r).   %% slip %% n�r 5 fra samf 

    xcompword(n�r,[g�r,bussen,n�r],n�r).  %% repair TEAM web 

    xcompword(n�r,[ga],g�r).  %% nar ga = n�r g�r 
    xcompword(n�r,[n�r],n�r).  
    xcompword(n�r,[og,hvorfor],n�r). %% ? %% Facetious     
    xcompword(n�r,[jeg,seinest,skal,v�re,der],f�r). 
    xcompword(n�r,[jeg,skal,til],til). %% bus til A n j s t B 
    xcompword(n�r,[g�r,buss,g�r],buss).  
    xcompword(n�r,[g�r,bussen,g�r],buss).
    xcompword(n�r,[g�r,bussen,skal,v�re],bussen). %% prompt 
    xcompword(n�r,[g�r,fra,bussen],fra). 
    xcompword(n�r,[g�r,fra],fra).  

compword(n�r,[du,kan],alltid). %% rough
compword(n�r,[du,m�],ofte). 

%% compword(n�r,[g�r,neste],avgang). %% n�r g�r neste nth * m�ller bil . %% Haz
%% n�r g�r  neste 2 fra bromstadsvingen

compword(n�r,[g�rn�r],n�r). %% repair 

    xcompword(n�r,[jeg,skal,v�re,der,f�r],f�r). 
    xcompword(n�r,[jeg,skal,v�re,der,til],f�r).
    xcompword(n�r,[jeg,skal,v�re,der],f�r).  
    xcompword(n�r,[jeg,skal,v�re,i,p�],til).    %% interaction
    xcompword(n�r,[jeg,skal,v�re,i],til).  

    xcompword(n�r,[jeg,skal,v�re,p�],til).  

%%    xcompword(n�r,[jeg,skal,v�re,ved],til).

    xcompword(n�r,[kl],klokken). 
    xcompword(n�r,[vi,skal,v�re,p�],til).  

    xcompword(da,[jeg,skal,v�re,i],til).  %% etc

compword(naar,[buss],buss).  % etc 
%% compword(n�r,[bus],buss).  %% Rough jeg tar buss n�r bussen 
%% compword(n�r,[buss],buss).        %% Rough
%% compword(n�r,[bussen],bussen). 
%% compword(n�r,[busser],busser).    %%

%% compword(n�r,[bussen,g�,fra],fra).   %% nohelp
compword(n�r,[de,g�r],g�r).        %% Rough n�r (er det) de g�r (,disse) b
compword(n�r,[det,buss],buss). 
%% compword(n�r,[det,er],[]). %% ..mandag / sommerrute Too rough
compword(n�r,[det,g�r],g�r).
compword(n�r,[dra,fra],fra).       %%   no funk
compword(n�r,[dra],[]).            %% ? 
compword(n�r,[for],for).           %%  hvilken buss m� jeg ta n�r for � v�re p
compword(n�r,[fra,neste],neste).   %% confusion
    xcompword(n�r,[fra],fra).      %% Xclusive
    xcompword(n�r,[f],fra).        %% ? n�r f�r?
    xcompword(n�r,[f,ra],fra).     %%  ?
    xcompword(n�r,[til],til).      %%  
    xcompword(n�r,[f�r,buss],buss). 


compword(n�r,[fram],ankommer).  %% disamb
compword(n�r,[f�r],g�r).           %% Rough 
%%  compword(n�r,[g�r,fra],fra).   %%  Doesnt help 
 compword(n�r,[g�r,til],til). 
compword(n�r,[g�r,buss,g�r],[]).   %%  confus
compword(n�r,[g�r,n�r],n�r).       %% Repair 
    xcompword(n�r,[g�r,til],til). 
compword(n�r,[g�rd,det],[]). 
compword(n�r,[g�rd],[]).  
%%  xcompword(n�r,[til,neste],neste). %% ?  nohelp

% har = g�r (sms ordliste), men n�r har siste 9 => siste buss ha rute 9 

compword(n�r,[har],g�r):- user:myflags(smsflag,true). %% ad hoc, ordliste  //nofunc
    xcompword(n�r,[har,neste],neste).


compword(n�r,[hvilke],hvilke).
compword(n�r,[hvilken],hvilken).
compword(n�r,[hvilket],hvilket). 

compword(n�r,['/',hvilken],hvilken). %% repair

compword(n�r,[hvor],hvor).  %% Repair
compword(n�r,[hvordan],hvordan).
compword(n�r,[jeg,m�,ta],g�r).   %%  Rough
    xcompword(n�r,[jeg,m�,ja],g�r).   %%  Rough
compword(n�r,[jeg,ta],g�r).     %% Rough n�r KAN jeg ta //Interference n�r n�r jeg ta

% compword(n�r,[jeg,skal,komme,meg],[]).  %%  Doesntwork

    xcompword(n�r,[jeg,m�,v�re,der,f�r],f�r). %% some problems 
    xcompword(n�r,[jeg,m�,v�re,der,til],f�r). 
%%     xcompword(n�r,[jeg,m�,v�re,der],f�r).  %% n�r jeg m� v�re der 
    xcompword(n�r,[jeg,m�,v�re,til],f�r). 
    xcompword(n�r,[jeg,m�,v�re,d�r],f�r). 

compword(n�r,[klokka],n�r).  
compword(n�r,[klokken],n�r).   
    xcompword(n�r,[klokken,er,over],etter).  

    xcompword(n�r,[man,m�,v�re,der,senest],f�r).  

compword(n�r,[meg,jeg,ta],g�r).  %%  Rough

compword(n�r,[me,jeg,ta],g�r).  

compword(n�r,[mjeg,ta],g�r).  
compword(n�r,[m�,dra],buss).     %% Rough
compword(n�r,[m�,jeg,at],g�r).   %% Rough at=ta


compword(n�r,[m�,jeg,buss],buss).  
    xcompword(n�r,[m�,jeg,bussen],bussen). 

    xcompword(n�r,[m�,ta,buss],buss).      %% Rough 
    xcompword(n�r,[m�,ta,bussen],bussen).  %% Rough
    xcompword(n�r,[m�,jeg,ta,fra],fra).    %% ? 
    xcompword(n�r,[m�,jeg,ja],g�r).  %% ja=ta 
    xcompword(n�r,[m�,jeg,fra],fra).  

compword(n�r,[m�,reise], reise).  
compword(n�r,[m�,ta],       g�r).  

compword(n�r,[nattbuss],nattbuss).   
compword(n�r,[nest,g�r],       []).     %% rough 
    xcompword(n�r,[neste,g�r],       []).    %%  rough

%%%%  compword(n�r,[neste],  neste). %% TA-100829 %% kan du si meg n�r neste \+x 

compword(nar,[neste],       []).   
compword(nor,[neste],       []). 



   compword(n�r,[neste],        g�r).   %% �-tr�bbel
compword(n�r,[n�yaktig],     n�r). 
compword(n�r,[n�],           m�).       %% n�r m� jeg ...
compword(n�r,[n�r],          n�r).  
compword(n�r,[og,ankommer],[]).  
compword(n�r,[og,med],med). %% .. hvilken buss 

    xcompword(n�r,[�r],[]).  %% g�r

compword(n�r,[nest],nest). %% siste .. 

%%% compword(n�r,[neste],neste). %% du sier n�r neste buss g�r %% TA-100829

compword(n�r,[og,hviklen],   hvilken).  %%  ?
compword(n�r,[og,hvilke],    hvilke). 
compword(n�r,[og,hvilken],   hvilken). 
compword(n�r,[og,hvilken],   n�r).      %% ambig
compword(n�r,[og,hvilket],   hvilket). 
compword(n�r,[og,hvor],      hvor).     %%  ,n�r)  ?
compword(n�r,[og,hvorfra],   n�r). 
compword(n�r,[og,hvor,fra],  n�r).      %%
compword(n�r,[og,hvor,ifra], n�r).      %%
compword(n�r,[og,vilken],    hvilken). 
compword(n�r,[p�,dagen],n�r).      %%  ... p� hverdager 
%% compword(n�r,[p�,jeg,ta],g�r).     %%  rough, but err reording
compword(n�r,[p�],p�).             %% v�re n�r p�
%% compword(n�r,[siste],siste). %% TA-110105 kan du fortelle n�r siste
compword(n�r,[s�nn,ca],n�r).  
compword(n�r,[ta],g�r).  
compword(n�r,[ti],n�r). 
compword(n�r,[�r],[]). %% n�r g�r 
compword(n�rg,[�r],g�r).      %%  (n�r g�r) 
compword(n�rm�,[jeg],jeg).     %% Ad Hoc 

% n�r

    xcompword(o,['/'],over). 
    xcompword(o,['.',l,'.'],etc). 

compword(o,[0],00). %% O0 
compword(o,[1],01). 
compword(o,[2],02). 
compword(o,[3],03).
compword(o,[4],04). 
compword(o,[5],05). 
compword(o,[6],06).
compword(o,[7],07). 
compword(o,[8],08). 
compword(o,[9],09). 

compword(o,['/'],via). %% over   

compword(o,['.',l,'.'],etc). 
compword(o,[l,'.'],etc).
compword(ol,['.'],etc).
compword(o,[lignende],etc).
compword(o,['.',lignende],etc).

compword(ofte,[fullt],fullt).   %% Ad Hoc, fedup
compword(ofte,[i,timen],ofte). 
compword(ofte,[og,n�r],ofte).

compword(o,[hoi],hei). 

%% OG ...

    xcompword(og,[for],og). 

%% compword(og,[ikke],unntatt). %% rough %% -> gram

    xcompword(og,[da,med],med). %%3 etc..
                      
%%%%     xcompword(og,[der],og). %% Too rough 
    xcompword(og,[hit],hit).   
    xcompword(og,[vil,v�re,i],til).   
compword(og,[fremme],f�r). %% no pardon 

compword(og,[er,ved],til). 

    xcompword(og,[jeg,drar,fra],fra). 
    xcompword(og,[mellom],mellom). 
    xcompword(og,[skal,v�re,der,f�r],f�r). 
    xcompword(og,[skal,v�re,fram,p�],til). 
    xcompword(og,[skal,v�re,framme,p�],til).  
    xcompword(og,[skal,v�re,frem,p�],til). 
    xcompword(og,[skal,v�re,fremme,p�],til). 
%%     xcompword(og,[s�],og). %% []). %% ogs� -> []     %% .. skal jeg til
    xcompword(og,[s�nt],[]).
    xcompword(og,[vil,v�re,der,f�r],f�r).  

    xcompword(og,[v�re,der,kl],f�r).
    xcompword(og,[v�re,der,senest],f�r). 
    xcompword(og,[v�re,framme,senest],f�r). 
    xcompword(og,[v�re,fremme,senest],f�r). %%  in case incomplete sentence

compword(og,[lignende],etc).

%% compword(og,[ankommer],til). %% og ankommer til X etter =A ARRIVAL  AFTER

compword(og,[av],av). 
compword(og,[bare],og).     
    xcompword(og,[best,mulig],[]). 
    xcompword(best,[mulig],[]).     %%  sequence
%% compword(og,[den],som). 
compword(og,[er,i],til).  
compword(og,[etter],etter).   
compword(og,[f�r],f�r).         %% 
compword(og,[hjem],hjem).  
compword(og,[inn,te],til). 
compword(og,[inn,til],til). 
    xcompword(og,[joda],[]). %% :-) 
compword(og,[jeg,er,i],fra). %% Rough
%            compword(og,[kommer,til],til). 
compword(og,[lignende],[]). 
compword(og,[mot], mot). 
compword(og,[mot,kl], f�r).          %% .. kl
compword(og,[ned,til],til).   
%% compword(og,[n�rmest,mulig],til). 
compword(og,[n�r,er,den,ved],til). 
compword(og,[n�r,er,den,p�],til).  
compword(og,[n�r,er,den,da,p�],til). %% ad hoc 
compword(og,[n�r,g�r,den],g�r). 
compword(og,[n�r,den,er,i],til).      %% Experiment
%% compword(og,[n�r,m�,jeg,ta,den],[]).   
compword(og,[opp,til],til).  
compword(og,[oppover,til],til). 
    compword(�,[oppover,til],til). 

compword(og,[passering],forbi).    
compword(og,[retur],tilbake).  

%% compword(og,[skal],til).  %% (og skal) til  v�re *         
%% compword(og,[som],til).   %% og som g�r til 

%% compword(og,[s�],[]).   %% ogs� %% (destructive)

compword(og,[s�til],og). 
%%      xcompword(og,[til],til).  %% Haz, try without 
compword(og,[tilbake],tilbake). 
compword(og,[ut,kvelden],ikveld). 

compword(og,[utover],[]).            %% Rough   
compword(og,[ut�ver],[]).  %% nec %%  (nofunk synword)

compword(og,[v�re, framme,klokka],f�r). 
compword(og,[v�re, fremme,p�],til).  %% Xservice
compword(og,[v�re, fremme,ved],til). %% Xservice 
compword(og,[v�re, ved],til).        %%
compword(og,[v�re,p�],til). 
compword(og,[�,v�re,p�],til).  

   xcompword(ok,[men],[]). %% grums %%  ?
   xcompword(ok,[s�],[]).  %% TA-110629

compword(om,[ca],om).
compword(om,[cirka],om).

compword(om,[f,'.',eks,'.'],om). 

%% compword(om,[for],for). 


compword(om,[man,vil,v�re,p�],til).   %% Ad Hoc, om tr�bbel 
compword(om,[mellom],mellom).         %%  om /morgenen/ mellom
    xcompword(om,[m�,v�re,p�],til).   
    xcompword(om,[noe,fra],om). 
    xcompword(om,[mulig],redundant0). 


compword(om,[n�r],n�r).   
compword(om,[fra],om). %% morgenen  repair

    xcompword(om,[mulig],redundant0).

%% xcompword(om,[n�r],n�r).  %%     jeg har opplysninger om n�r toget kommer
              %% \=  jeg har opplysninger n�r toget kommer


%% compword(om,[n�r],om).               %% varsel om n�r \= om 

compword(omkring,[halv],halv). 

   xcompword(omr�der,[i,n�rheten,av],n�r). %% 
   xcompword(omr�der,[n�rheten,av],n�r).   %% actual

compword(om,[trent],ca). 
  %% compword(om,[�,gj�re],viktig). %% har AIS noen �nsker om � gj�re 
compword(ombord,[i],i). 
compword(omr�der,[n�r],n�r). 
compword(omtrent,[samtidig],samtidig). %% [] ?   
compword(omtrent,[som],som).   
compword(omtrent,[til],til).  
compword(opp,[forbi],forbi). 
compword(opp,[i],til). 
compword(opp,[igjen],tilbake). %% igjen not noisew 
compword(opp,[med],med). 
compword(opp,[til,opp,i],til).        %% Repair 
compword(oppe,[p�],p�). 

compword(oppfordre,[til],anbefale).   %% ad hoc
compword(oppfordrer,[til],anbefaler).
compword(oppfordret,[til],anbefalt). 
compword(oppfordret,[til],anbefalte).

compword(oppover,[],[]).                 %% Optionally noiseword 

compword(oss,[begge],oss).       %% Rough

%% compword(oss,[i],[]). %% Lingit  %% Rough : * Dere hadde oss i tankene
                         %% i praksis, destruktiv 

%% compword(overgang,[til],til). %% Rough n�r er overgang til 
    xcompword(over,[i,morgen],overimorgen). %% TA-110401
compword(over,[morgen],overimorgen). %% TA-110401
compword(over,[hodet],[]).
compword(over,[p�],p�).     
compword(over,[sikt],oversikt). 

compword(overgangs,[billett],overgangsbillett). 
compword(overgangs,[bilett],overgangsbillett). 
compword(p,['�',�],     p�).%%  p�� l��rdag?  
compword(p,[�],     p�).

compword(p,[m], ettermiddag).
compword(p,[�], p�).   %%  Trouble with � 
compword(pas,[serer],passerer). 

compword(passer,[det,best,�,ta],passer). %%  Lazy
compword(passer,[best,�,ta],passer).     %%
compword(passer,[det,best,for,meg,�,ta],passer).   %%  Lazy

%% compword(passer,[til],passerer). %% 


compword(per,[dags,dato],idag). 
compword(pinse,[dag],pinsedag).   
%% compword(prof,['.'],professor).    %% \+ nodotflag ???

compword(pr�ve,[med],pr�ve).  


compword(p�,[at],at).   
compword(p�,[best,mulig,m�te],[]). 

    xcompword(p�,[ca],p�). 

%%%    xcompword(p�,[der],der).             %% Hazard 
%% compword(p�,[etter],etter). %% repair %% hvilken holdeplass stopper bussen p� etter �sveien
compword(p�,[for],for).              %% repair
compword(p�,[fra],fra).              %% repair 
compword(p�,[f�r],p�).               %% ?  
compword(p�,[grunn,av],pga).             %%  Technical
compword(p�,[is],ned).               %% lagt p� is
    xcompword(p�,[kort,sikt],snart).
    xcompword(p�,[ordentlig],[]).
    xcompword(p�,[orntlig],[]).       %% :-)
    xcompword(p�,[onkli],[]).         %% :-)
%%  compword(p�,[i],p�).         %% p�= i ?
   xcompword(p�,[i],i).          %%  Repair 
compword(p�,[idag],idag).    %% repair 

    xcompword(p�,[is],ned). %% FOS lagt .. 

compword(p�,[jeg,ta],g�r).   %% m� jeg ta 
    xcompword(p�,[kl],klokken).     %%  repair 
    xcompword(p�,[klokka],klokken). %%
compword(p�,[kortest,mulig,tid],snarest). 

compword(p�,[kl],klokken).       %% Hva er snareste m�te � til nth p� kl
    xcompword(p�,[kl,'.'],klokken). 
compword(p�,[klokken],klokken).

compword(p�,[med],med). 
compword(p�,[mindre,enn],innen). 
compword(p�,[n�r],n�r). %% svare p� n�r  
compword(p�,[n�rti],n�r). 
   % compword(p�,[p�],p�).    %%  repair destroys p� p� p� example 
compword(p�,[rundt],rundt).   %%
compword(p�,[siden,av],attmed). %% Techn? beside 
    xcompword(p�,[sikt],heretter). %% TA-110724

    xcompword(p�,[tide],mulig).
    xcompword(p,[tur,til],til). 
compword(p�,[til],til).  
compword(p�,[tur,mot],til). 
compword(p�,[tur,via],fra). 
compword(p�,[tur,t],til). 
    xcompword(p�,[tur,til],til). 


compword(p�,[v],ved).       %%  repair
    xcompword(p�,[ved],ved).    
compword(p�,[vei,mot],til). 
compword(p�,[vei,til],til). % also gn

compword(p�ske,[rute],p�skerute). 
compword(p�ske,[ruten],p�skeruten).
compword(p�ske,[ruter],p�skeruter).

compword(r,[d,lenge,til],[]). %% Rough
   xcompword(rute,[r],ruter).   %% TA-110724
   xcompword(rb,[stasjon],rutebilstasjon). 
   xcompword(rb,[stasjonen],rutebilstasjonen).
compword(rabatt,[kort],rabattkort).
compword(raskest,[komme],komme).   
compword(raskest,[mulig],[]).       %% (implic) 

compword(raskeste,[m�te],[]).  
    xcompword(raskeste,[reise],rute).  %%  TA-100805?
    xcompword(raskeste,[vei],rute). 
    xcompword(regne,[med,�],[]). 
compword(regner,[med,�],[]).

compword(regne,[med,at],anta ).  
compword(regner,[med,at],antar). 
compword(regnet,[med,at],antok ).  
compword(regner,[med,�],[]).  

    xcompword(regtop,[eksport], regtoppeksport).
    xcompword(regtopp,[eksport],regtoppeksport).
    xcompword(regtop,['-',eksport], regtoppeksport). %% //- noisew now
    xcompword(regtopp,['-',eksport],regtoppeksport). %% ad hoc

compword(rekke,[�],kan). 
compword(rekker,[�],kan). 

compword(rei,[gjerne,reise],reise). %% disrupt
compword(rei,[reise],reise). 

compword(reise,[forbindelse],forbindelse). 
compword(reise,[klokka],etter).               %% rough
compword(reise,[m�te],reisem�te).  

compword(resten,[av,dagen],heretter).  
compword(resten,[av],etter).  %% rough %% .. kvelden

%% compword(resten,[av],[]). %% resten av livet ....

compword(retning,[nord], nordover).
compword(retning,[syd],  s�rover).
compword(retning,[s�r],  s�rover).
compword(retning,[vest], vestover).
compword(retning,[�st],  �stover).

compword(rett,[etter],etter).
compword(rett,[for],f�r).   %% rett ikke noise (rett og slett)
compword(rett,[forbi],forbi). 
compword(rett,[fra],fra). 
compword(rett,[f�r],f�r). 
compword(rett,[og,slett],[]).
compword(rett,[til],til). 

compword(rett,[vest],vestover). %% :-)
compword(rett,[�st],�stover). 
compword(rett,[nord],nordover). 
compword(rett,[syd],s�rover). 
compword(rett,[s�r],nordover). 

compword(rette,[f�r],f�r). %% ?
compword(rette,[etter],etter).

    xcompword(riktig,[god],god). 

compword(rom,[jul],romjula). 
compword(rom,[jula],romjula).
compword(rom,[julen],romjula).

compword(rukket,[�],[]).  

compword(rukket,[opp],reist). %% etc

compword(rund,[t],rundt). %%  repair
compword(rundt,[i],i).  
compword(rundt,[og,rundt],[]). %%  :-)
compword(rundt,[om,i],i).      %% TA-110506
compword(rundt,[omkring,i],i). 
compword(rundt,[p�],p�).   
compword(rush,[trafikk],rushtrafikk). 
compword(rush,[tid],rushtrafikk). 
compword(rute,[buss],buss).    
compword(rute,[endring],endring).  
compword(rute,[endringer],endringer). 
compword(rutehellig,[dag],rutehelligdag). 
    xcompword(rute,[rute],rute). 
compword(rute,['/',ruter],ruter).  
    xcompword(rute,[tiden],rutetiden). 
compword(rute,[tider],rutetider).  
%% compword(rutebil,[stasjon],rutebilstasjon). %% -> busdat



compword(ruter,[til,buss],buss).  
compword(rutetabell,[nr],rute). 
compword(rutetabell,[rute],rute).   

compword(rutetid,[buss],buss).  
compword(rutetider,[buss],buss).  %% etc
    compword(rutatider,[buss],buss). 
compword(rutetid,[rute],buss).  
compword(rutetider,[rute],buss).  %% etc
    compword(rutatider,[buss],buss). 


%�S

    xcompword(s,[enter],senter).   
    xcompword(s,[enteret],senteret). %% nec for nardo s enteret
    xcompword(s,[entret],senteret).  %%
    xcompword(sent,[ute],forsinket). %% TA-100830
    xcompword(sentere, [t],senteret).%%  (busdat?)

compword(s,[gate],gate).   
compword(s,[ndag],s�ndag).  %% s;ndag 

    xcompword(s,[om],som). 

%%     xcompword(sammen,[med],med). %% hvem er du sammen med %% TA-110221

    xcompword(satt,[opp],arrangert). %% buss til nth 
    xcompword(satte,[opp],arrangerte). %% nb -e
compword(seneste,[mulighet],sist).
compword(sentru,[m],sentrum).
compword(sentrum,[bussen],bussen).  %% Rough 
compword(sentrums,[bussen],bussen). %%
compword(sentrum,[sentrum],sentrum). 
%% xcompword(si,[alle,tidene,som],[]). %% Rough
    xcompword(si,[alle,tidene],[]). %% ... buss 5 g�r             
compword(si,[det],snakke).                 %%  si det s�nn 
compword(si,[det,en,gang,til],gjenta).   
compword(sim,[kort],simkort).     %% TA-110707
compword(sim,[kortet],simkortet). %%


compword(sikkert,[ikke],ikke).
    xcompword(siste,[gang],sist). 

%% compword(sikre,[seg],motta).
%% compword(sikre,[deg],motta). 

compword(sitte,[p�,med],ta). 
compword(sier,[fra],varsler).  
compword(sjekke,[det,opp],unders�ke). %% det ?

compword(skal,[jeg,med],g�r). 
    xcompword(skal,[jeg,n�r,jeg,skal],skal). 
    xcompword(skal,[vil],vil). %% repair 

    xcompword(skal,[fra],forlater).  
%%     xcompword(skal,[i],ankommer).    %%  rough skal i fremtiden... 
    xcompword(skal,[p�],ankommer).      %%

    xcompword(skal,[til],ankommer).     %% 
    xcompword(skal,[av,p�],ankommer).   %% TA-110629 Haz

    xcompword(skal,[innover,til],ankommer).     %% ad hoc 
    xcompword(skal,[utover,til],ankommer).      %% 

%%%     xcompword(skal,[v�re,i],ankommer).  %% ... i orden 
    xcompword(skal,[v�re,p�],ankommer). %% 
 
    xcompword(skal,[vare,i],ankommer).  %% splitword impossible
    xcompword(skal,[vare,p�],ankommer). 

compword(skal,[v�re,der],f�r). %% presume jeg skal v�re der %	 ...hvis
    compword(skal,[v�re,der,til],f�r). %% Haz \+x % du * skal v�re der til 9 : 0 . 

compword(skal,[v�re,framme],f�r).  
compword(skal,[v�re,fremme],f�r). 

%% compword(skal,[v�re],ankommer). %% Haz 

    xcompword(skole,[buss],skolebuss).
    xcompword(skole,[bussen],skolebussen).

compword(skjer,[a],hjelp). %%  #-> hva skjer

compword(skj�r,[torsdag],skj�rtorsdag).  
compword(skriv,[inn],skriv).                  %%  Lazy
compword(slapper,[av],hviler).  
compword(slett,[ikke],ikke).           

    xcompword(slik,[ut],s�ledes).  %%  adverb
    xcompword(s�nn,[ut],s�ledes).  %% TA-110130  

    xcompword(ut,[slik],s�ledes).  %%  adverb

    xcompword(slik, [som],[]).  
    xcompword(slike,[som],[]).   %% ... dette
    xcompword(slikt,[som],[]).   %% 

    xcompword(omtrent,[slik,ut],s�ledes).  %%  # 
    xcompword(ut,[omtrent,slik],s�ledes).  %%  # 


compword(slik,[at,jeg,ankommer],f�r).  
    xcompword(slik,[at,jeg,er,der,f�r],f�r). 
    xcompword(slik,[at,jeg,er,der,til],f�r).

compword(slik,[at,jeg,er,der],f�r).  %% x is Haz 

compword(slik,[at,jeg,er,framme,f�r],f�r). 
    xcompword(slik,[at,jeg,er,fremme,�r],f�r).   
compword(slik,[at,jeg,er,framme],f�r).   
compword(slik,[at,jeg,er,fremme],f�r). 
    xcompword(slik,[at,jeg,er,p�],til). 
    xcompword(slik,[at,jeg,er,i],til).   

compword(slik,[er,fremme], f�r).  

compword(slik,[�,forst�],slik).

compword(slipp,[p�],tillate).    %% dial 
compword(slippe,[p�],tillate).   %% allow , rough 
compword(slippe,[inn],tillate).  %%

%% To handle misformed relative clauses ( go to X which arrives before Y)
%% To be removed if they cause trouble 

compword(slutte,[med],slutte). %% � r�yke  (uniqe for slutte)\+ x 
compword(slutter,[med],slutter). 

compword(slutte,[me],slutte). %% � r�yke  (uniqe for slutte)\+ x 
compword(slutter,[me],slutter). 

compword(so,[mg�r],[]).  %% if sp, anything goes

    compword(som,[man,kan,se],redundant0).  

compword(som,[ankommer],f�r).   

    compword(som,[det,er],[]). %% Haz %%  brukes ..

compword(som,[er,der,f�r],f�r).  
compword(som,[er,der,til],f�r).       %% 

    xcompword(som,[er,fram,f�r],f�r).      %%   1.
    xcompword(som,[er,fram,kl],f�r). 
%%%%         xcompword(som,[er,fram],ankommer). %% Touchy %%    2. 
    xcompword(som,[er,fram],f�r). 

    xcompword(som,[er,framme,etter],etter). 
    xcompword(som,[er,fremme,etter],etter). 
    xcompword(som,[er,framme,f�r],f�r).  
    xcompword(som,[er,fremme,f�r],f�r).  
    xcompword(som,[er,framme,senest],f�r). 
    xcompword(som,[er,fremme,senest],f�r).  
    xcompword(som,[er,framme,innen],f�r).  
    xcompword(som,[er,fremme,innen],f�r).  

    xcompword(som,[er,framme,tidligst],etter). 
    xcompword(som,[er,fremme,tidligst],etter).  

    xcompword(som,[er,framme,p�],til).  
%%%%%    xcompword(som,[er,framme,til],f�r).  %% Ambiguous ... 9:35/Tiller
    xcompword(som,[er,framme,ved],til). %% grammar handles ambiguity

    xcompword(som,[er,framme,i],til). 

       xcompword(som,[er,framme,til],til).      %%  til tid/sted????
    xcompword(som,[er,framme,kl],f�r).  %% avoid n�r g�r  (BUSSEN SOM ER FRAMME) kl
%%%%%%%%%%%%%%%%%%%%%%%%    xcompword(som,[er,framme,f�r],f�r). %% 1. Tricky
    xcompword(som,[er,fremme,f�r],f�r). %% 1. Tricky
    xcompword(som,[er,fremme,til],f�r). 
    xcompword(som,[er,fremme,p�],til).  %%
    xcompword(som,[er,fremme,i],til).  
    xcompword(som,[er,fremme,ved],til).  
    xcompword(som,[er,framme],f�r).     %% Last (som er framme p�)
    xcompword(som,[er,fremme],f�r).     %% Last !!! <---- 

    xcompword(som,[er,senest,fremme,ved],til). %% seinest/framme etc  Ad Hoc

    xcompword(som,[sagt],redundant0).  

%% compword(som,[er,i],til).             %% buss til A som er i B kl ...
compword(som,[er,i],til).   %% 
                                  %% fra munkegata som er p� pirterminalen 
%%     xcompword(som,[er,p�],til).   %% NB !! <--- Hazard 

    xcompword(som,[er,ved],til). %% 
    xcompword(som,[er,p�],til).  %%  Haz ?

    xcompword(som,[f,'.',eks],[]).   %% apposition
    xcompword(som,[f,'.',eks,'.'],[]). 
    xcompword(som,[f,'.',eksempel],[]).

    xcompword(som,[f,eks],[]).       %% 
    xcompword(som,[f,eks,'.'],[]). 
    xcompword(som,[f,eksempel],[]). 

    xcompword(som,[for,eks],[]).     %% 
    xcompword(som,[for,eks,'.'],[]). 
    xcompword(som,[for,eksempel],[]).  


    xcompword(som,[fremme,f�r],f�r).
compword(som,[fremme],f�r).   

compword(som,[g�r,i],i).  
compword(som,[g�r,fra],fra).  
    xcompword(som,[ikke,er,etter],f�r). %% Ad Hoc, avoid negations 

    xcompword(som,[mer,ved],til). %% error -> x 

compword(som,[passer,med],slik).      %% .. at 
compword(som,[passerer],til). 
    %% compword(som,[p�],til). %% .. er .. 
       xcompword(som,[p�],p�). %%  p� samme tid som p� julaften %%	 rough
                               
compword(som,[erp�],til).   
compword(som,[her,p�],til). %% sp
    xcompword(som,[helst],[]).
compword(som,[mulig],[]).  
compword(som,[jeg,sa],[]). 
compword(som,[skal,v�re,i],til).  
compword(som,[til],til).   
compword(som,[vanlig],presis).   
compword(som,[verst],mye).   %% sn�dde .. :-) 

compword(sommer,[ruta],sommerruten). 
compword(sommer,[rute],sommerrute).  
compword(sommer,[rutene],sommerrutene).
compword(sommer,[ruter],sommerruter). 
compword(sommer,[tider],sommerruter).

    xcompword(sp�rsm�let,[':'],sp�rsm�let). 
    xcompword(svaret,[':'],svaret).

    xcompword(sp�rre,[svar,system],savant).  
    xcompword(sp�rre,['/',svar,system],savant). 
    xcompword(sp�rre,[system],savant). 


%% compword(st,['.'],stasjon). 

compword(stilt,[seg,positiv,til],godkjent). %% metaphor

compword(stopp,[knappen],stoppknappen).

compword(stopp,[plassen],holdeplassen). 
compword(stopp,[plasen],holdeplassen).  %% actual


compword(stoppe,[sted],stoppested).  
compword(stoppe,[steder],stoppesteder).
compword(stoppe,[stedet],stoppestedet).

compword(student,[billett],studentbillett). 
    xcompword(studenter,[samfundet],studentersamfundet). %% ad hoc

%%    xcompword(studenter,[samfunnet],studentersamfundet). %% TA-110314

    xcompword(strengt,[tatt],redundant0). %% Techical, nec for word order
    xcompword(ideelt,[sett],redundant0). 

compword(svare,[til],ligne). %% ad hoc (\+ partivlev2)
compword(svarer,[til],ligner).
compword(svarte,[til],lignet).
compword(svart,[til],lignet).

%% compword(svare,[p�],besvare).     
   compword(svare,[pay],vite).          %% på
compword(svart,[p�],besvart).           %% ad hoc
compword(s�ndag,[p�ske],p�skes�ndag).  

compword(l�rdags,[runde],l�rdagsrute). 
compword(l�rdags,[runder],l�rdagsrute). 
compword(l�rdags,[rute],l�rdagsrute). 
compword(l�rdags,[ruter],l�rdagsrute). 
compword(l�rdags,[tur],l�rdagsrute). 
compword(l�rdags,[turer],l�rdagsrute).  

compword(s�ndags,[runde],s�ndagsrute). 
compword(s�ndags,[runder],s�ndagsrute). 
compword(s�ndags,[rute],s�ndagsrute). 
compword(s�ndags,[ruter],s�ndagsrute). 
compword(s�ndags,[tur],s�ndagsrute). 
compword(s�ndags,[turer],s�ndagsrute). 

%%     xcompword(s�,[skal],skal). %%  skulle/ville ...
    xcompword(s�,[fort,som,mulig],n�). %% buster/avoid item:clock
    xcompword(s�,[langt,vi,kan,se],derfor). %% Lazy %% ad hoc 
   
    xcompword(s�,[langt,som],hvis). %% s� langt som  det er mulig 

compword(s�,[langt],hittil).   %% s� langt har alt g�tt bra 
compword(s�,[langt],hvis).     %% s� langt det er mulig   %%

    xcompword(s�,[mye,du,vil],ofte).  %%  adv 
    xcompword(s�,[raskt],n�r). %% sende ruter s� snart 
    xcompword(s�,[si],si).     %% s� si meg/ du kan s� si 
    xcompword(s�,[snart],n�r). %%
    xcompword(s�,[ta],ta).     %% og s� ta
    xcompword(s�,[veldig],[]). %% jeg vil (ikke) s v 


compword(s�,[bussen,er,i],til).  
compword(s�,[du],du). %% ? %% s� du er alts� ... 
compword(s�,[er,du,grei],[]). 
    xcompword(s�,[fort,som,mulig],snart).  
compword(s�,[gjerne],[]).             %%  noisew

    xcompword(sa,[jeg,er,der],f�r). 
    xcompword(s�,[jeg,er,der,til],f�r). 
    xcompword(s�,[jeg,er,der,f�r],f�r).  %% 1
    xcompword(s�,[jeg,er,der],f�r).      %% 2

compword(s�,[jeg,er,framme],f�r). %% \+ x
compword(s�,[jeg,er,p�],til). 
   compword(say,[jeg,er,pay],til).    %% �-t�bbel 
compword(s�,[jeg,er,senest,i],til).   %% rough   
compword(s�,[jeg,er,ved],til).  
   xcompword(s�,[jeg,er,framme,p�],til). 
   xcompword(s�,[jeg,er,framme,f�r],f�r).  


compword(s�,[jeg,rekker,�,v�re,i],til). 
compword(s�,[jeg,rekker,�,v�re,p�],til).
compword(s�,[jeg,ankommer],f�r).   
compword(s�,[jeg,er,i],til). 
compword(s�,[klart],[]).  
compword(s�,[langt],[]).  %% ? da skal du f� slippe � busse til heimdal. s� langt   

    xcompword(s�,[lenge,som],mens). %% TA-110309
    xcompword(s�,[lenge],mens).     %% 

compword(s�,[man,er,framme],f�r). 
compword(s�,[man,er,fremme],f�r).
%%%%    xcompword(s�,[mye],mye).  %% destroys s� mye som mulig.
compword(s�,[n�re],n�r).              %% (f�r?)
compword(s�,[n�re,som,mulig],f�r).        
compword(s�,[vi,er,i],til).  
compword(s�,[vi,er,fremme],f�r).  %% place?
compword(s�,[vi,er,der],f�r).     %%

    xcompword(s�,[vidt,jeg,vet],redundant0).
    xcompword(s�vidt,[jeg,vet],redundant0).

compword(s�nn,[at,ankomst,er],[]). 
compword(s�nn,[ca],[]). 
compword(s�nn,[cirka],[]).
compword(s�nn,[jeg,er,til],til). 
compword(s�nn,[ved],ved).   %% .. tolv tiden

    xcompword(samfundet,[1],studentersamfundet_1). 
    xcompword(samfundet,[2],studentersamfundet_2). 

    xcompword(i,[kraft],redundant0). %% TA-101108 ad hoc  metaphor


compword(trondheim,[s],ts).  %% not X %% trondheim s -> trondheim sentrum -> sentrum

compword(trondheim,[taxi],taxi). 
    xcompword(trondheim,[buss],buss).    %% etc
    xcompword(trondheim,[rutebil],buss). %% 

compword(tr�ndersk,[dialekt],dialekt). %% rough 

compword(sankt,[hans],sankthans). 
compword(sankthans,[aften],midsummer_eve). 
compword(sankthans,[dag],midsummer_day). 

    xcompword(sneket,[seg],kommet). 
    xcompword(snik,[deg],kom). 
    xcompword(snike,[seg],komme).
    xcompword(snek,[seg],kom). 

compword(snilt,[av,deg],snilt).

compword(sp�,[rre],sp�rre). %%  ?

compword(s�nda,[g],s�ndag). 

    xcompword(s�rg,[for],bes�rg).  
    xcompword(s�rge,[for],bes�rge). %% ensure

  xcompword(t,[bane,rute],tbane).  %% 
   xcompword(t,[bane,ruter],tbane). %% 
    xcompword(t,[bane],tbane).   %% t = til
     xcompword(t,[banen],tbane).
   
     xcompword(tbane,[ruter],tbane).  %% Rough 
    xcompword(tbane,[rute],tbane).    %% 
    xcompword(tbane,[ruter],tbane).   %% 



compword(t,[o,m],f�r).
compword(t,[o,m,'.'],f�r).      
compword(t,['.',o,'.',m],f�r).     
compword(t,['.',o,'.',m,'.'],f�r).   
    xcompword(t,[kort],tkort).  
    xcompword(t,[':',kort],tkort). 


compword(tjo,[hei],hei). 

    xcompword(tog,[stasjonen],togstasjonen). %% ad hoc avoid tog as such 
    xcompword(tog,[stasjon],togstasjon).     %%

compword(tvers,[over],ved). %% TA-101116 .. veien

%% TA-101207
    xcompword(tre,[i,kraft],starte).     %%
    xcompword(trer,[i,kraft],starter).   %%
    xcompword(tr�dd,[i,kraft],startet).  %%
    xcompword(tr�dde,[i,kraft],startet). %%


%% compword(ta,[fra],forlate). %%  hvilken buss skal ta fra nth.? 
%% hvilken buss m� jeg ta fra angelltr�a

compword(ta,[hvilke],ta). 
compword(ta,[hvilken],ta).
compword(ta,[hvilket],ta).

compword(ta,[i,bruk],bruke). 
%% compword(ta,[i],[]).               %% tak i 

compword(ta,[jeg],ta). %% ??? n�r m� jeg ta jeg bussen 

%% compword(ta,[meg], reise).  % ta meg en billett          %%  ? ta meg til nardoit/ kom � ta meg 

compword(ta,[meg,til], ankomme).   
compword(tar,[meg,til], ankommer). 

%% compword(ta,[fra],forlate).  %%  n�r m� jeg ta fra A til B

   xcompword(ta,[jeg],jeg). %% ? N�r m� ta jeg ta sp 
                                %   hvilken buss m� jeg ta fra 
compword(ta,[ned],g�). %% bakken ned nth ...
compword(ta,[opp],g�). 


compword(ta,[og,ta],ta). 

%%% compword(ta,[n�r], ta).  %% ta n�r for � 
                                 %% hv. buss skal jeg ta n�r jeg skal
compword(ta,[seg], komme).  
compword(ta,[som,g�r],ta). 
compword(ta,[til,seg],motta). 

compword(ta,[�,ta],ta). 
compword(ta,[�],ta).  %% ta � (sp) 
compword(ta,[�],[]).  %% ta � komme seg til byen

compword(ta,[av],dra).   %% rough
compword(tar,[av],drar). %%


compword(tabell,[buss],buss).  
compword(tabell,[rute],rute).  

compword(tanke,[arbeidet],tankearbeid).
compword(tanke,['-',arbeidet],tankearbeid). %% nec ?

compword(tanke,[arbeid],tankearbeid).
compword(tanke,['-',arbeid],tankearbeid). %% nec ?

%%compword(tar,[seg], kommer).           %% ad hoc
%% compword(tar,[meg], kommer).           %%
compword(tar,[tar], tar).   %% 

compword(tek,[seg], g�r).           %% ad hoc 
compword(tek,[meg], g�r).           %%

    xcompword(telef,['.'],telefon).    %% ad hoc
    xcompword(telefon,[nr],telefon). 
    xcompword(telefon,[nummer],telefon). %% TA-101202
 
compword(te,[neste],neste).           %% err 
compword(te,[ved],til). 
    

    xcompword(team,[p�skeruter],p�skeruter). 
    xcompword(team,[sommerruter],sommerruter). %%  
compword(tenke,[deg,�],[]).  
   xcompword(tenker,[�],vil).  %% avoid tenker for � v�re i stand til
                                
compword(tenkt,[�,dukke,opp],ankommet).

compword(tett,[ved],n�r). 
compword(ti,[l],til).  
%%%  compword(tid,[fra],fra). %% tid fra nth til nardo 

compword(ti,[stille],tistille). %% techn, avoid 'ti' 

compword(hold,[kjeft],tistille). 
compword(hold,[kj�ft],tistille). 
compword(hold,[munn],tistille). 

compword(tid,[buss],buss).        %%  repair

%% compword(tid,[g�r],[]). %% ? destroys = n�r=hvilken tid
%%    xcompword(n�r,[tid,g�r],[]). %% juks %% TA-101013
%% compword(tid,[g�r],[]).  
%%    xcompword(ti,[g�r],[]).  %%  Haz
%%    xcompword(ti,[drar],[]). %% 

%% compword(tid,[g�r,neste],neste).
%% compword(tid,[g�r,buss],buss). 
%% compword(tid,[g�r,bussen],bussen).
%% compword(tid,[g�r,bussene],bussene).
%% compword(tid,[g�r,busser],busser).

%% compword(tid,[g�r,b�t],b�t).     %%
%% compword(tid,[g�r,rute],rute).   %%
%% compword(tid,[g�r,rute],rute).   %%
%% compword(tid,[g�r,trikk],trikk). %%


compword(tid,[oversikt],ruteplan). %% avganger). %% nb times 

compword(tiden,[tiden],tiden).       %%  Repair
compword(tider,[og,nr],tider). 

    xcompword(tider,[over,rute],rutetider).  
    xcompword(tider,[over,ruter],rutetider). 

compword(tidlig,[etter],etter).       %% i morgen tidlig etter %% AD HOC
compword(tidligere,[enn],f�r). 
compword(tidligst,[mulig],tidlig).    %% tidligst betyr F�R

compword(tids,[avgang],avgang).   
compword(tids,[avgangen],avgangen).   
compword(tids,[avgangene],avgangene).  
compword(tids,[avganger],avganger).  

compword(tidspunktet,[n�r],n�r).

compword(til,[om],at). %%  kjenner du til om ?

   xcompword(til,[overs],[]).
compword(til,[vanlig],redundant0). 

compword(til,['.'],til). %%  N�r g�r neste 7 til.buran"

    xcompword(til,[alle,tider],alltid). 
    xcompword(til,[daglig],daglig).       %% TA-100828    
    xcompword(til,[en,hver,tid],alltid).  %%
    xcompword(til,[enhver,tid],alltid).   %%

compword(til,[i],i).   %% \+ x Du m� oppgi et sted til i slike sp�rsm�l
                       %% du holder til i Th %% TA-101018
    xcompword(til,[n�],[]).

%%    xcompword(til,[i],i). %% et sted til i slike sp�rsm�l %%  Haz
                            %% venter til i morgen

compword(til,[sted],destinasjon). 
    xcompword(til,[stede],her). 
    xcompword(til,[at,jeg,kommer,til],til).
compword(til,[ca],til).   
compword(til,[omtrent],til). 


    xcompword(til,[da],da).   %% "derf�r"
compword(til,[d�mes],[]).  


compword(til,[for,�,v�re,i],til).  %%   // fronted
compword(til,[for,�,v�re,ved],til).%%  repair
compword(til,[for,�,v�re,p�],til).
compword(til,[for,�,v�re,p�],til). 
compword(til,[for],for). %%  repair

compword(til,['+'],til).           %% actual ?
    xcompword(til,[ankommer],ankommer).  
compword(til,[borti],til).  
compword(til,[dit],dit). 
    xcompword(til,[d�ra],hjem).  
compword(til,[en,holdeplass,ved],til).
%% compword(til,[et],til). %% ?
    xcompword(til,['/',fra],forbi).  %% rough %% tol/fra buss? 
compword(til,[forbi],forbi).     %%  err repair
compword(til,[g�r],g�r).         %%  hvilken buss til g�r til /Repair
    xcompword(til,[hvis],hvis).      %% (repair) X

    xcompword(til,[imorgen],imorgen). 
    xcompword(til,[i,morgen],imorgen).

compword(til,[i,n�rheten,av],til). 
%   xcompword(til,[i],i). %% et sted til (i tillegg) %% plass til i bussen
%   compword(til,[i],til).     %%  (i?) Du m� oppgi et sted til i slike sp�rsm�l . oo 

compword(til,[klokka,er],f�r).  
compword(til,[klokken,er],f�r). 
compword(til,[hit],hit).  
compword(til,[hvilken,tid],n�r). 
compword(til,[hvis],hvis).       %% repair
%% compword(til,[l],til).  %%? %% TA-110818
compword(til,[lands],[]). 
compword(til,[med,ankomst],til).   %% repair

% compword(til,[med],til).      %% jeg hjelper til med at
%    xcompword(til,[med],med).  %% repair 

compword(til,[n�rheten,av],til).   %% nofunk?
    xcompword(til,[og,fra],forbi).
    xcompword(til,[og,med],til).  
compword(til,[og,v�re,fremme],til). 

%% compword(til,[p�],til).    %% Repair * hvor mange personer  er det  plass til p� bussen

compword(til,[rett,tid],presis). 
compword(til,[retning],til).  
compword(til,[rundt],f�r).  
compword(til,[sammen],[]).  
%% compword(til,[sent],[]). %% gl�s til sent -> sentrum -> gl�s 
compword(til,[slutt], sist). 
compword(til,[som],som).        %% repair

    xcompword(til,[sted],tilsted). %% destinasjon ? %%  x?

compword(til,[s�nn], s�nn).     %% repair .. at jeg er  p�
    xcompword(til,[til],til).   %% repair 
compword(til,[ut], ut).    
compword(til,[ved],til).   
compword(til,[via],via).        %% repair 
compword(til,[viss],hvis).      %% doesnt help
%% compword(til,[�],til).          %% sms lov til � 
%%%%%%% compword(til,[vanlig,tid],presis). %% // ordinary route
compword(til,[�verst,i],til).      %% Rough
compword(til,[�,v�re,i],til).

%%% compword(til,[�],[]). %%\+ x jeg skulle akkurat til � ...* mulighet til �
compword(skal,[til,�],skal). 
compword(skulle,[til,�],skulle). 

compword(tilsentrum,[],[]).  %% also splitword
compword(tilbake,[p�],p�).  
compword(tilbake,[til],til).
compword(til,[tilbake],til). %% ?

compword(tilbyen,[],[]).  %% ad hoc, byen is default anyway 
compword(times,[tid],time).  

compword(trase,[rute],rute). 

compword(trippel,['-',trykk],sms). %% .. tastatur %%  own

compword(tt,[kontoret],servicekontoret).
compword(tt,[kort],kort). 
compword(tt,[s],tts). 

compword(tur,[retur],tilbake).  
compword(tur,[retur],tilbake).             %% (ignore) 
compword(tur,[rettur],tilbake). 
compword(tur,['/',retur],tilbake).   

    xcompword(turing,['-',test],turing_test).  
    xcompword(turing,['-',testen],turing_test).
    xcompword(turing,[test],turing_test). 
    xcompword(turing,[testen],turing_test). 
    xcompword(turings,[test],turing_test).   %% TA-100907 
    xcompword(turingtest,[],turing_test).   %% TA-110120
    xcompword(turingstest,[],turing_test). 

compword(u,[bane],tbane).   

    xcompword(uforst�elige,[ord],feil). 
    xcompword(uff,[da],[]).  %% :-) 
    xcompword(huff,[da],[]). %% 
compword(u,[b�t],b�t).                   %% Rough 


compword(uke,[dag],ukedag). 

    xcompword(lure,[p�],undre).    %%  rough
    xcompword(undre,[p�],undre).   %% tricky
    xcompword(lurer,[p�],undrer).  %% 
    xcompword(undrer,[p�],undrer). %% 

compword(ungdom,skole,skole). 

compword(universal,[kort],universalkort).  
compword(universal,[merke],universalkort).
compword(universelt,[kort],universalkort).  
compword(universelt,[skibusskort],universalkort). %% etc 
compword(unntatt,[med],unntatt). 

    xcompword(ut,[av,det],l�sningen).
    xcompword(ut,[av,noe],l�sningen). 

compword(ut,[av],fra). 
compword(ut,[om],ut).  
compword(ut,[p�],p�).  
compword(ut,[�],[]).   

    xcompword(ute,[av,drift],nede). 

compword(uten,[bussbytte],direkte). 
compword(uten,[pause],direkte). 
compword(uten,[stopp],direkte).  

    xcompword(uten,[unntak],alltid).
    xcompword(uten,[�,bytte,buss],direkte).  %% ad hoc
    xcompword(uten,[�,skifte,buss],direkte).  

compword(uttrykke,[deg],snakke). 
compword(utvidet,[skolekort],skolekort). %% ?? 

    xcompword(v,['/'],ved).   
%%    xcompword(va,['.'],ca).  %% hva ?
    xcompword(va,[halv],halv). %% ca halv 

    xcompword(veldig,[gjerne],redundant0). %%=gjerne --> 
    xcompword(veldig,[ofte],ofte).         %% TA-101228

compword(vi,[gir,opp],adj�). 

%% compword(videreg�ende,[skole],skole). %% Haz ?
compword(videreg�ende,[skoler],skoler).  %% 

compword(v,[re],v�re).   
compword(va,[re],v�re).         %% være 
compword(vanlig,[dag],hverdag). 
%%%%  compword(vanlig,[],presis).   %% p� en vanlig dag

compword(var,[s�], var).   

compword(varsle,[fra],varsle). 

compword(vart,[av],er). %% Dial 

    xcompword(ved,[hjelp,av],med). %%  Haz?
    xcompword(ved,[n�rmere,ettertanke],redundant0). %% TA-101102

compword(ved,[navn],[]).  
compword(ved,[p�],p�).           %%  repair

    xcompword(vegg,[i,vegg,med],n�r).   
    xcompword(vegg,[til,vegg,med],n�r). 

compword(vel,[ikke],[]).  
compword(vell,[],[]). 
compword(ved,[i], i).         %% Repair
compword(ved,[p�], p�).       %% Repair 

  compword(ve,[sia,av],attmed).   
  compword(ve,[sida,av],attmed).  
  compword(ve,[siden,av],attmed). 
  compword(ved,[sia,av],attmed).  
  compword(ved,[sida,av],attmed). 
  compword(ved,[siden,av],attmed). 

compword(ved,[til],til).      %% repair
compword(vekke,[meg,opp],varsle). 

%% compword(vet,[du,om],fins).     %% Lazy  %% TA-110629
%% compword(veit,[du,om],fins).    %%


%% compword(vg,[],[]).       %% vennligst
compword(vg,[s],vgs). 
compword(via,['/',til],til). 
compword(via,[fra],fra). 
compword(via,[til],til).  
compword(vice,[versa],tilbake). 

    xcompword(vil,[at],�nsker).  %% Haz?
compword(vil,[det,v�re],er).     %% Grammar repair
   xcompword(vil,[det,g�],g�r).   
compword(vil,[det,kj�re],kj�re). %%  
compword(vil,[komme,til,�],vil). 

    xcompword(vil,[skal],skal). %% repair 

compword(vil,[v�re,der],f�r).  

compword(ville,[det,v�re],er).    %%
compword(visa,[kort], visakort ). 
%% compword(visst,[],[]).       %% hvis     %%  optional noise

    xcompword(visst,[jeg,skal,v�re,i],til). %% no pardon 

    xcompword(v�r,[dag],[]).   %% -> daglig -> noisew %%  err

compword(v�r,[hilset],hei).  
compword(v�r,[s�,god], v�rs�god).

   xcompword(v�r,[s�,snill,'.'],[]). 
compword(v�r,[s�,snill,�],[]). 
 
compword(�,[v�r,s�,snill],[]). 

compword(v�,[der],ankomme).        %%  dial
compword(v�re,[der,klokken],f�r).     %% no funk 
%% compword(v�re,[der],f�r).  %% Hazard  %% no funk 
compword(v�re,[framme],f�r).   
compword(v�re,[i],til).  
compword(v�re,[komme],komme).   
compword(v�re,[kommet,til],til).  

  %% compword(v�re,[p�],til).  %% haz?  %% n�r vil bussen v�re p� 
  %% compword(v�re,[ved],til). %% haz 
   xcompword(v�re,[p�],ankomme). %% <--- 

    xcompword(v�re,[s�,snill,�],[]).  
    xcompword(v�re,[s�,snill],[]). 

%% compword(v�re,[p�],ankomme).    %%  Tekn. Fremtid// jeg skal v�re p� nardo
compword(v�rs�god,[�],[]). 

compword(verden,[over],overalt).  %% rough 

compword(vers�god,[�],[]). %% no spell before

    %% compword(v�rt,[p�],til). %% har noen v�rt p� m�nen
compword(v�rt,[ved],til). 


compword(voksen,[billett],billett). %% rough
compword(v�,[re], v�re).           %%  være

    xcompword(y,[til],til). %% repair 

compword(�vre,[aldersgrense],aldersgrense). 

%% compword(�,[f�],�).  %% .. komme til %% \not x
                                        %% \+ x, jeg �nsker � f� en billett
                                                        
compword(�,[fra],fra).      %% Repair

%% compword(�,[gj�re],arbeide).  %% hva liker jeg � gj�re

compword(�,[inn],inn).   
compword(�,[ja],ja).  

    xcompword(�,[jeg,ta],g�r).   %%  exclusive

compword(�,[jass�],[]).     %%  :-))))))

%%      xcompword(�,[da],ja).  %% TA-101014     %% X � (jo) da
%%      xcompword(�,[m�tte],�).     %% eff. ville skulle burde kunne 
                                    %% destroys uten � m�tte
compword(�,[ned],ned).  
compword(�,[nei],nei).      %%  :-)
%% compword(�,[s�],�).         %%  Rough  %% TA-110105 ... � s� sier du
compword(�,[t],til).  
compword(�,[ta,fra],fra).   %% Ad Hoc
compword(�,[ta,til],til).   %% 
compword(�,[te],til). 
   xcompword(�,[tid],n�r).  %% dial 
compword(�,[til],til).      %% og til
    xcompword(�,[�],�). %% repair 

compword(�r,[g�r],g�r).     %% Paste slip n�r g�r
compword(�r,[m�],m�).       %% Very Rough  (n)�r m� 

compword(�rs,[kort],�rskort).


%% UNWANTED INTERPRETAION %% TA-101124

unwanted_interpretation(brukar,use).   %% NN %% TA-110411
unwanted_interpretation(bruker,use).   %% \+ plu bruk
unwanted_interpretation(byen,city).    %% sentrum  %% TA-110120 //confuse
unwanted_interpretation(haven,ocean).  %% \+ havet %% TA-101221

%% UNWANTED NUMBER 

unwanted_number(nien).  %% \+ 901
unwanted_number(et).    %% jeg bruker (bussen et) sted 
unwanted_number(en).    %% ???
unwanted_number(entre).
unwanted_number(ein). 
unwanted_number(eit). 
unwanted_number(toto).   %% \+ 202  
unwanted_number(ettet).  %% = etter
unwanted_number(ettre).  
unwanted_number(etttre). 
unwanted_number(treen).  %% TA-110502
unwanted_number(treet).  %% 

%% UNWANTED ADJECTIVE

unwanted_adjective(begynte).  %% begynt (past,part) -> adj (sin) -> adj(plu)
unwanted_adjective(eit).      %% eidd ?? 
unwanted_adjective(eitt).     %% eidd ?? 
unwanted_adjective(ekkle).    %% Ekle %% TA-110812
unwanted_adjective(ett).      %% spist (av en l�ve) 
unwanted_adjective(f�tt).   
unwanted_adjective(gidte).    %% \+ giddet 
unwanted_adjective(gifte).    %% most prob verb
unwanted_adjective(hatt). 
unwanted_adjective(h�pet). 
%%  unwanted_adjective(hele).     %% (determiner) %% rundt hele byneset 
unwanted_adjective(kalte).    %% not plu of kalt
unwanted_adjective(kj�rt).  
unwanted_adjective(kj�rte).   %% 
unwanted_adjective(ledet).
unwanted_adjective(leie).     %% hire
unwanted_adjective(likte).    %% " de er likt(e)"
unwanted_adjective(lille).    %% lille julaften \== small Xmas 
unwanted_adjective(logget).   %% problems  bli logget
unwanted_adjective(loggf�rt). 
unwanted_adjective(lurte). 
unwanted_adjective(m�tet).    %% \+ m�tt 
unwanted_adjective(nesten).   %% redunt adverb %% TA-110106
unwanted_adjective(nestet).   %% det nestet toget *

unwanted_adjective(noke).     %% \+ sufficient 
unwanted_adjective(nytte). 
unwanted_adjective(passere).  %% \+ passe(re)= gode ere %% TA-110330
unwanted_adjective(passert). 
%% unwanted_adjective(raskest).  %% not rask = fast  .. raskest mulig = heretter%% what was the trouble %% 

unwanted_adjective(rettet).   %% \+right (det rette toget)
unwanted_adjective(ringte). 
unwanted_adjective(satt). 
unwanted_adjective(senest).   %% =f�r
unwanted_adjective(seneste).  %%  ?
unwanted_adjective(seinest).  %% = f�r
unwanted_adjective(seineste). %% ?
unwanted_adjective(sent).     %% TA-100905  ???  
unwanted_adjective(seint).    %% hazard  et sent tog
unwanted_adjective(sete). 
unwanted_adjective(sette).    %% because past part  // rule here 
unwanted_adjective(skapet). 
unwanted_adjective(slutte).   %%  Filmen er slutt, filmene er slutt
unwanted_adjective(snakket).  
unwanted_adjective(sne).      %% sen -> sne 
unwanted_adjective(spurte).  
unwanted_adjective(stanset). 
unwanted_adjective(stilt).    %% (stilt,adj(be/ask))
unwanted_adjective(stoppet). 
unwanted_adjective(svaret). 
unwanted_adjective(tenkt).    %%  et tenkt tilfelle?
unwanted_adjective(tidligst). %% confuse f�r 
unwanted_adjective(trengte).
unwanted_adjective(varte).    %% \+ lasted 
unwanted_adjective(vekt).     %% \+ vekk 
unwanted_adjective(vise).     %% \+ wise 
unwanted_adjective(vist).     %%  et vist bilde ? 

% unwanted_adjective(nestee). %%  En neste buss , Den nestee bussen 
% not nec (new general morph_rule)
%% unwanted_adjective(senere).  %% not forsinket OK 



unwanted_verb(an).      %% \+ believe!
unwanted_verb(ang�ende).%% prep 
unwanted_verb(ankomt).  %% TA-110523
unwanted_verb(b).       %% be  %% mix with English and confuses error message 
unwanted_verb(bar).     %% bear
unwanted_verb(bedre).   %% confuse gooder 
unwanted_verb(best).    %% beest (being asked ) %% er jeg best
unwanted_verb(bet).     %% \+ bedt
unwanted_verb(betalende).     %% adj 
unwanted_verb(bt).      %% bedt
unwanted_verb(blinde).  %% \+ blivende 
unwanted_verb(br�k).    %% \+ lag br�k %% TA-100830
unwanted_verb(bus).     %% \+ passive of bu /bo )
unwanted_verb(bust).    %% \+ buast 
unwanted_verb(dekk).    %% \+ cover !  
unwanted_verb(digg).    %% \+ like!
unwanted_verb(drift).   %% \+ run 
unwanted_verb(drikk).   %% \+ drink!
unwanted_verb(dum).     %% \+ ikke dum deg ut 
unwanted_verb(dumm).    %% TA-101123
unwanted_verb(ei).      %% \+ own!
unwanted_verb(eit).     %% \+ eiet 
unwanted_verb(eitt).    %% \+ eiet
unwanted_verb(eksporter). %% \+ !
unwanted_verb(end).     %% TA-110304
unwanted_verb(et).      %% \+ eat!
unwanted_verb(eter).    %% \+ spiser -> etter
unwanted_verb(ett).     %% \+ spist 
unwanted_verb(ette).    %% \+ spiste 
unwanted_verb(fall).    %% \+ fall!
unwanted_verb(far).     %% spc fra 
unwanted_verb(fara).    %% \+ FARA A/S %% TA-110303
unwanted_verb(feil).    %% feil! (SIC)
%% unwanted_verb(finn). %%  finn bostad %% Ad Hoc
unwanted_verb(finnes).  %%  = eksisterer
unwanted_verb(finnses).  %% \+ Finnsnes %% TA-110118
unwanted_verb(fint).    %% \+ funnet
unwanted_verb(forsinket). %% TA-100823 adj
unwanted_verb(forsvinnende). 
unwanted_verb(fors�ket). %% \+ Fors�ket %% TA-110724
unwanted_verb(f�rre).   %% =f�, but not the verb 
unwanted_verb(f�lgende).%% \+ follow-ing 
unwanted_verb(f�r).     %% \+ imp 
unwanted_verb(gidte).   %% \+ giddet
unwanted_verb(gjeldende). 
unwanted_verb(gj�rer). 
unwanted_verb(grei).    %% \+ manage! 
unwanted_verb(greit).   %% \+ manage!
unwanted_verb(greitt).  %% \+ manage!
unwanted_verb(grense).  %% infin 
unwanted_verb(greia). 
unwanted_verb(grue).    %% dread | municipality 
unwanted_verb(g�s).     %% Passive -> g�r 
unwanted_verb(h).       %% ha ?
unwanted_verb(hast).    %% \+ be urgent! 
unwanted_verb(hat).     %% \+ hat! 
unwanted_verb(havn).    %% \+ havn! (endup!) 
unwanted_verb(havna).   %% \+ havnet (ended) 
unwanted_verb(hei).     %% \+ heie
unwanted_verb(ht).      %% hatt
unwanted_verb(h�p).     %% \+ h�p! 

%% unwanted_verb(het).     %% \+ imperative  Het Titanic!
                        %% hva het faren din 

unwanted_verb(innlegg). %% \+ legg inn
unwanted_verb(insa).    %% \+ understand // a-form
unwanted_verb(jobb).    %% \+  jobb!
unwanted_verb(kati).    %% \+ n�r=reach 

%% unwanted_verb(kj�rende). %% -> adj %%  unnec

unwanted_verb(klar).    %% \+  imp (Klar en klassiker :-)
unwanted_verb(kommes).  %% kommer
unwanted_verb(kost).    %% \+ kost!
unwanted_verb(krysset). %% destroys unprotected verb (Nardo-)
unwanted_verb(l).       %% le 
unwanted_verb(lei).     %% \+ hire!
unwanted_verb(leier).   %% \+ hire \+ Leira %% TA-110615 ?

unwanted_verb(lopet).   %% l�pet   %% TA-101215
unwanted_verb(l�v).     %% \+ promise!

%% unwanted_verb(lagt).    %% \+ lag(e)t %%  <--- dette blir lagt

unwanted_verb(land).    %% \+  imperative, for pilots 
unwanted_verb(last).    %% laes (� la) 
unwanted_verb(leit).    %% \+ leiet
%% unwanted_verb(ler).     %% \+ Ler %% TA-110116
unwanted_verb(lett).    %% \+ letet 

unwanted_verb(lik).     %% \+ imperative
unwanted_verb(log).     %% \+ (take) log 
unwanted_verb(logg).    %% \+ (take) logg
unwanted_verb(lov).     %% \+ promise!
unwanted_verb(loves).   %% \+ elsker (eng) 
unwanted_verb(lur).     %% \+ imperative
unwanted_verb(l�nn).    %% \+ l�nne (seg)

unwanted_verb(melda).   %% \+ Meldal %% TA-101228
unwanted_verb(men).     %% - mean !
unwanted_verb(mor).     %% \+ amuse! 
unwanted_verb(mora).    %% � more (seg)
unwanted_verb(m�t). 
unwanted_verb(m�tet).   %% \+ m�tte %% TA-110330
unwanted_verb(m�r).     %% m� = go, m�r = goes  (m� til nth)
unwanted_verb(m�tter). 

unwanted_verb(n).       %% sms n= n�
unwanted_verb(no).      %% \+ n�=reach
unwanted_verb(np).      %%  doesnt help
unwanted_verb(nu).  
unwanted_verb(nytte).   %% haz, only as nyte/n�t not as benytte
unwanted_verb(n�r).     %% n�r

unwanted_verb(oppdatert).  %% problem %% Try again 
unwanted_verb(oppdaterte). %% confuse 

unwanted_verb(pass).   %% passport 
unwanted_verb(passende).
unwanted_verb(passes). %% \+ passeres, \+ korrespondes
unwanted_verb(programmer). %% \+ programmer! 
unwanted_verb(r).      %% re (seng)
unwanted_verb(rasende).
unwanted_verb(reisende).  %% noun 
unwanted_verb(regn).   %% \+ rain!
unwanted_verb(rent).  
unwanted_verb(rett).   %% \+ correct\! 

unwanted_verb(s).      %% = se ! (elsk(e))
unwanted_verb(samarbeid). %% \+ cooperate! 
unwanted_verb(sats).   %% \+ SATS (satse OK) 
%%%%%%%%%%    unwanted_verb(sendet). %% \+ sendt (causes confusion) 
unwanted_verb(sete).   %% \+ sett
unwanted_verb(sist).   %% \+ sies(t)
unwanted_verb(sitt).   %%  e.pron
unwanted_verb(skap).  
unwanted_verb(skj).    %% \+ skje %% morpg rule ? %% TA-110309
unwanted_verb(skapet). %% \+skapte 
unwanted_verb(snakkes). %% not passive, split=snakker sammen 
unwanted_verb(sne). 
unwanted_verb(snus).   %%  snuff
unwanted_verb(sn�). 
unwanted_verb(so).     %% so=s�=sedde** 
unwanted_verb(spillet).  
unwanted_verb(spor).   %% TA-101117 \+ spor!
unwanted_verb(st).     %% \+ sett
unwanted_verb(stav).   %% \+ spell!  # Stav  
unwanted_verb(stavet). %% \+ spell!  # Stavset
unwanted_verb(stavest).%% \+ Stavset %% TA-110725
unwanted_verb(ste).    %% \+ s� 
unwanted_verb(stengt). %% only adjective 
unwanted_verb(stigende). 
unwanted_verb(stolt).  %% \+ trusted
unwanted_verb(stopp). 

unwanted_verb(strand). %% strande = ankomme (sl�ng) 
unwanted_verb(stranda). %% comm 


unwanted_verb(streik). %% \+  Streik!
unwanted_verb(svar).   %%  Jeg f�r svar// kan du svar //  svar p� sp�rsm�let mitt !
unwanted_verb(svaret). %% \+ svarte
unwanted_verb(s�ket).  %% \+ search
unwanted_verb(s�).     %% confusion,ooo %% TA-110127  then/ as fast as // Jeg s� en buss* 

unwanted_verb(tak).    %% \+ ta!
unwanted_verb(take).   %% \+ ta NN, but destroys lang. sel.
unwanted_verb(takk).   %% \+ imperativ
unwanted_verb(tast).   %% \+ taes 
unwanted_verb(tasta).  %% TA-101006
unwanted_verb(te).     %% dial, \+ t-e 
unwanted_verb(ti).     %% \+ ti(e)
unwanted_verb(tilh�rende). %% adj
unwanted_verb(tillatt).%% adj %% ad hoc
unwanted_verb(tillegg).%% \+ add 
unwanted_verb(tull).   %% \+ speak! 
unwanted_verb(tuller). %% = Tiller %% TA-101103
unwanted_verb(tvil).   %% \+ tvil (ikke)! 

unwanted_verb(visa).   %% Visa,  \+ show 
unwanted_verb(varet).  %% \+ varte
unwanted_verb(vedlikehold). %% \+ maintain!
%%  unwanted_verb(veit).   %% also   knows %% TA-110804
unwanted_verb(veret).  %% \+ v�r NN 
%% unwanted_verb(vist).   %% vist = hvis %% hazard ?? Bildet ble vist 
%%% unwanted_verb(var).    %% \+ var!  Funker ikke, spesialregel
unwanted_verb(v�ret).  %% \+ v�rt
%% unwanted_verb(v�rte).  %% � v�re \+ var

unwanted_verb(yt).   %% \+ give

unwanted_verb(n�r).  %% \+ reach,  Hazard ? n�=reach ok 

%% unwanted_verb(n�).  %% = now  (Roughly) 

%% Some words are out of alphabetical order due to
%% backward translation from english, which selects the first word.


%% Synonyms must be listed in all forms, no
%% analysis prior to translation


%% Known (internal/ key) words  to avoid spurious error messages
%% due to the keywords in the grammar

% be   = be0  ( be sick )  
% be   = be1  ( be in england  )     
% be   = be2  ( be a man  = be equal to a man) // suspended 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kw(X):-ow(X). % Open Word Class     => coded
kw(X):-cw(X). % Closed Word Class   => uncoded 


%%%%%%%%%%%% 

ow(nb(_)).
ow(quote(_)).

ow(X) :- user:instant(X,word),!.

ow(X) :- numerid(X,_,_).
ow(X) :- adjective2(X,_). 
ow(X) :- user:gradv_templ(X,_). 


%%%%%%%%%  All the words that may appear as literal constants in grammar.

/*
  Mostly adverbs, 
         auxillary verbs, 
         articles, 
         pronouns
         conjunctions, 
         exclamations,
         etc.

*/

%% CW 

cw('�').   %% Headline 

cw(';'). %% Sentence delimiter

cw(',') :- user:myflags(teleflag,true).  
cw('.'). 
cw('?').
cw('!').
cw(':').
cw('+'). 
%% cw('-'). 
cw('/'). 

cw(X) :- pronoun(X,_).   

cw(a). cw(b). cw(c). cw(d). cw(e). cw(f). cw(g). cw(h). %% street letters
cw(i). cw(j). cw(k). cw(l). cw(m). cw(n). cw(o). cw(p). 
cw(q). cw(r). cw(s). cw(t). cw(u). cw(v). cw(w).

cw(ad). cw(adj�). cw(alene). cw(all). cw(alle). cw(alltid).
    cw(allverden).  cw(alt). cw(alts�). cw(am). cw(an). 
    cw(andre). cw(andres). 
    cw(annen). cw(annet). cw(antall). cw(at). cw(av).

cw(badet). cw(bakfra). cw(bakover).  cw(baklengs). cw(bedre). cw(best). %%
    cw(banen). %% T-banen 
    cw(bare). cw(begge).  cw(bort). cw(bra). cw(bravo).  cw(bruk).   cw(b�r).
    cw(bli). cw(blir). cw(bortover). cw(burde). cw(b�de). 


cw(ca). 

cw(da). cw(dag). cw(daglig).
    cw(de). cw(deg). cw(den). cw(denne). cw(dens). cw(der). 
    cw(dere). cw(deretter). cw(derfor).  cw(derfra).  cw(derf�r). cw(dessverre) .
    cw(det). cw(dets). cw(dette). cw(din). %% cw(di). 
    cw(disse). cw(direkte). 
    cw(dit). cw(ditt).   cw(dra). % fra(sms)| g�
    cw(du).   cw(d�rlig). %% adverb
    
cw(egen). cw(egentlig). cw(egne). cw(eget). cw(eksempelvis). cw(ekte). 
    cw(en). cw(enda). cw(ende). %% 9ende
    cw(enklest). cw(engang). cw(enn). cw(enn�). cw(eren). cw(ergo). cw(erru).
    cw(et). cw(etc). cw(ei). cw(ett). %%  Tricky !!!
    cw(eldre). cw(eller). cw(enten). 
%%     cw(exit).

cw(faktisk). cw(fall). 
     cw(farefritt).  cw(fler). cw(flere). cw(fleste). 
     cw(for). cw(forat). cw(forh�nd). cw(formiddag).
     cw(for�vrig).  
     cw(forbi). 
     cw(fordi). cw(forg�rs).
     cw(forskjellig). cw(fort). cw(for�). cw(fra). cw(fram). % adv 
     cw(fremfor). 
     cw(fri). cw(f�lge). cw(f�r). cw(fyi). cw(f�rst). cw(f�rre). %%
     cw(f�). cw(f�r). %%

cw(galt). cw(gang). cw(gitt). cw(gjen). cw(gjennom).  
%    cw(gjennomsnittet). 
    cw(gjensyn). cw(gratis). %%  
    cw(greitt). cw(grr).  cw(g�r). %% cw(gt).   confuses lex
    cw(goddag). cw(godnatt). 

cw(ha). cw(hade). cw(hadet). cw(halvtime). 
    cw(hallo). 
    cw(halv).  cw(han). 
  cw(hans). %% confuse hans Finnes gate 
    cw(hei). cw(heldigvis). cw(hele).   cw(helst). 
    cw(henne). cw(hensyn).  cw(her). cw(herfra). cw(hennes). 
    cw(heretter). cw(hilsen). 
    cw(hit). cw(hitover). cw(hjem). cw(hjemme). cw(http). cw(huff).  
    cw(hva). cw(hvem). cw(hver).  cw(hverandre). 
    cw(hvert). cw(hvertfall). cw(hvilke).  cw(hvilken). 
    cw(hvilket). cw(hvis). cw(hvor). cw(hvorav). cw(hvordan). cw(hvorfor). cw(hvorfra).
    cw(hvorvidt). cw(h�y). cw(h�yere). cw(h�yest). 
    cw(hysj). %% :-)

%% cw(i). %% (Molde) dialect for Jeg  jeg reiser for � v�re i Th  NO!
     cw(idag). cw(ig�r). cw(ikt). cw(imens). cw(imorgen).
    cw(ifra). cw(igjen).  cw(ihvertfall).
cw(ikke). cw(ikveld). cw(inatt). cw(ingen). cw(ingenting). cw(inn). cw(inne).
   cw(innimellom). cw(innover). cw(inntil).  

       cw(isteden).   cw(istedet). cw(istedenfor). cw(istedetfor). 
       %% should be unnec , (compword)

cw(j). %% nec to make j distinguisable from jeg
    cw(ja).  cw(jo). cw(jovisst).  % cw(javel). 
    cw(jeg).  cw(jevnlig). cw(jul).

cw(kan). cw(kanskje). cw(kl). cw(kunne).     cw(kvart).
%% cw(klokka). cw(klokken).

 %% cw(kor). 


% cw(lag). 
cw(langsomt). cw(langt).
     cw(lavere). cw(lenge). cw(lenger). cw(lengre). 
     cw(lik). cw(like). cw(likeledes). cw(likevel). cw(likt). cw(lite).
     cw(lokalt). cw(rpgol).  cw(rpgolram). %% TA-110524
     cw(l�pet). 

cw(m). 
cw(maksimum).
    cw(man). cw(mao). cw(mange). cw(med). %% (adv)
    cw(meg). %%  (  show difference between I and me )
    cw(meget).  cw(men).  cw(mens). cw(mer). 
    cw(midt). cw(million). cw(millioner). cw(milliard). cw(milliarder). 
    cw(min). cw(mindre).  cw(minst). cw(mine).   cw(minimum). cw(minst).  cw(mitt). 
    cw(mon). cw(morges). cw(morgen). cw(mulig). cw(mye). cw(m�). 

cw(n). %% n = nr in certain places 
    cw(nb). %% 'NB' 
    cw(natt).  %%  (i natt) 
    cw(naturligvis).
    cw(ned). cw(nede). cw(nei). cw(nest). cw(nedover). cw(no).
    cw(nylig).
    cw(noe). cw(noen). cw(noensted). cw(nord). cw(nordfra). cw(nordover). 
    cw(nordligste). cw(normalt). cw(nr).  %%  buss nr. 5 =/=>  (buss nummmer) .
    cw(nytt�r). 
    cw(n�r). %% Swedish, but    s y n w o r d n�r,n�r ==> n�r = reach
    cw(n�rheten). 
    cw(n�).  cw(n�r). 

cw(o). cw(obs). cw(ok). cw(om). cw(ommorgenen). cw(overalt). 
    cw(overmorgen). cw(overimorgen). cw(ofte).
    cw(og). cw(ogs�).  cw(om). cw(opp). cw(oppover). 
    cw(oss). 

cw(p). cw(ps).
cw(ping). cw(pong). %% cw(pm). %% cw(presis). 
    cw(punktlighet).  
    cw(p�). %%  lure p�  , stige p� 

cw(rart). %%  adv 
cw(raskest). 

cw(redundant0).%% Techn  % redundant adverb %%  only internal

 cw(resten). %% Techn  % resten av 
    cw(retur). 

cw(s). %%  (  NSB s buss ==> nsb s buss) 
   cw(samme). cw(sammen). cw(samtidig).
   cw(sann). cw(sanne). cw(sant). cw(seg). cw(selv). cw(selvom). cw(selvf�lgelig).
   cw(selvsagt). 
   cw(senere).  cw(sent). %% cw(senest).  cw(seneste).
   cw(siden). cw(sikker).  cw(sikkert). cw(sikre). 
   cw(sin). cw(sine). cw(sitt).  %% (genitive)
   cw(sist). % cw(siste).
   cw(sjelden).
   cw(skal). cw(slags). cw(slik). cw(snakkes).  
   cw(snarest). cw(snarere).  cw(snart).
   cw(som). cw(sorry). cw(sta). cw(stad). cw(stille). %%  
   cw(st�rst). cw(st�rste).  cw(s�r). cw(s�rligste). cw(s�rfra). cw(s�rover).
   cw(straks). cw(supert). cw(svar).  
   cw(sydfra). cw(sydover). cw(s�). 


cw(takk). cw(team). cw(tem).
    cw(ti). cw(tide). cw(tidlig). cw(t). cw(tt).  %%
    cw(tidligere).   cw(tidligst). cw(tidvis).
    cw(til). % inntil
    cw(tilbake). cw(tilfelle). cw(tilsammen).  cw(ting).
    cw(total).  cw(totalt).  cw(totale). cw(trafikk). cw(trygt). cw(tur). 
    cw(tusen). cw(tusener).

cw(tkort). %% ad hoc 

cw(uansett). %% nec* 
cw(uff). cw(ulik). cw(ulikt). cw(ulike). cw(umulig).
    cw(under).  cw(unnskyld). cw(unntatt). %% Konj.  
    cw(uriktig). cw(usant).
    cw(ut). cw(ute). cw(uten). cw(utover).

cw(vanligvis). cw(ved). cw(veg).   %%  NB Necessary to distinguish 'veg' from 'direction'
%% cw(vekk). 
cw(vel).
    cw(veldig).  cw(velkommen). 
    cw(vest). cw(vestligste). cw(vestover). 
    cw(videre).
    cw(vil). cw(v�rs�god). %%

cw(www). 

cw(yngre).

cw(�kke). 

cw(�). cw(�st). cw(�stfra). cw(�stover). cw(�yeblikket). 

cw(�).  



%% SYNONYMS    (Alphabetically)

%% No morphological analysis is done on the synonyms,
%  which means that all forms must be listed explicitly.
%  The substitute word is analysed however.
%  No recursion in synword, the transitive closure must be done by hand

% Norsk til Norsk


synwordx(X,Y):-user:myflags(smsflag,true),synsms(X,Y). 
synwordx(X,Y):-synword(X,Y).

% SMS synonyms  

synsms('1r',etter).  %% c m p l(1,[r],etter). if split NNAA


synsms(a,�).  %% collides with 5a (accepted, but no bus 5a)
synsms(a,av).

synsms(ats,buss).   %% bus (actual) 
synsms(auss,buss).  %% sms neib
synsms(aussen,bussen).
synsms(b,buss).        %%  to b = to busser, ikke buss 2 
%% synsms(bra,fra).       %%  Haz %% er det bra med deg
%% synsms(bar,n�r). %% act  ?
synsms(brn,bru).       %%  bakke br�
synsms(bu,buss). 
synsms(bur,buss). 
synsms(busp,buss).     %% smstab 
synsms(cup,buss).      %% smstabl
synsms(cul8r,adj�).    %% see you later
%% synsms(d,du).          %% Haz 
%% synsms(d,det).      %%  -> synword
synsms(depa,fra).      %% d(1#) ... e(2#) = f(3#) 

%% synsms(dn,den).  
synsms(dr,der).  
synsms(dro,for).   %% ordliste ?

%% synsms(dra,          fra).  %%   Hazardous 
%% "dra" Will be removed if followed by a name /remove-smers
%% // n�r m� jeg dra fra NTH Feil


%% synsms(e, en).       %%  ?  Hazard ?
%% synsms(e,er).          %% koss dag e d * /collides with etter 
synsms(e,etter).       %%  collides with er

%%% synsms(ei,jeg).        %% ? (actual) %%  Collides ei datter

%% synsms(eller,etter).   %% hazard %% fra strindheim skole til gl�s med buss 20 eller 60.

synsms(etteq,etter).   %% neib k  

%% synsms(f,fra).      %%  NB ikke f�r //unnec prep(f,from

%% synsms(f,for). %% causes trouble

%% synsms(f,f�rste).      %%  Haz
synsms(far,fra).       %% // blocks father
synsms(fia,fra). 
%% synsms(fengs,fengsel).
%% synsms(for,f�r).    %%  neib key %% tar buss for � 
synsms(fnr,for). 
synsms(fpa,fra).       %% // neib key sms
synsms(fr,fra).        %%  Nei, bare fredag ???
synsms(frab,fra).      %% 

synsms(ft,f�rste).     %% for tiden? 
synsms(furr,buss).     %% ?
synsms(futer,etter).   %% double neib 

synsms(f�rstpe,f�rste). 
synsms(f�s,f�r).  

%% synsms(galt,halv).     %% ordliste / neib %%  nohelp
synsms(gave,gate).     %% neib # k
%% synsms(gr,g�r).     %% synw
synsms(g,g�r). 
synsms(g�i,g�r). 
synsms(g�q,g�r).      %%  Ordliste
synsms(g�sa,g�r).     %%  Ordliste, actual

synsms(halt,halv).   
%% synsms(har,g�r). %% Ordliste // Hvilke st har rute 5 // hvem har tuc det 
%% NB  HAZARD// DOESNT WORK // hvilken adresse har Tagore

synsms(hj�,ila). 
%% synsms(hpl,holdeplass).
synsms(h�p,g�r).   %%  tabl
synsms(h�pe,g�rd).


synsms(j,jeg). 
synsms(jakk,takk). 
synsms(jep,jeg).    %% smstab
synsms(jg,jeg). 

%% synsms(k,klokken). %% confuse K. Jonssons vei
synsms(kj�kken,klokken). 

%% synsms(kj�per,kj�rer).   %%  .. billett ? 

synsms(kommeq,kommer).   %% neib k

synsms(lei,jeg).     %% :-)
%% synsms(liv,til).     %% ordliste %% ? 
synsms(l8r,senere).  %% 
%% synsms(l�,l�rdag).%% synword 
synsms(l�gn,john).   %% :-) tablatur

%% synsms(m,med).       %% synw
%% synsms(m,meg).    %% Hazard // jeg vil dra m buss 5

synsms(m,m�).     %% Haz ? // %%  hvilken buss m jeg ta, doesnt help

%% synsms(man,mandag).  %%  NB NB  man = noen// Hazardous !
%% hvor g�r man av ...

synsms(mar,n�r).  
%% synsms(marte,neste). %% ?? 
synsms(mlm,mellom). 
synsms(mrg,morgen). 
synsms(mu,m�).   %% act 
synsms(n,neste). 
synsms(ns,nr). 

%% -> gn
%% synsms(n,n�r).  %% n g   %% Too hazardous
                         %% \+  n= n�r = REACH !

synsms(nas,n�r).  
synsms(nat,n�r). 
%% synsms(nbuss,nattbuss). %% most likeley on sms/slip ? (n)buss 
synsms(ncr,n�r).        %%  Actual 
% synsms(nr,n�r).       %% NO  Too Haz 
% synsms(n�r,n�r).      %% (men ikke reach; fixed in gram)
synsms(ne,neste).
synsms(neite,neste).  
synsms(nesthe,neste).
synsms(ngb,buss).     %% �r g�r buss
synsms(n�q,n�r). 

synsms(o,over).      %% (om) ? 
synsms(oar,n�r). 
synsms(o�r,n�r). 
synsms(ob,nattbuss). %% neib key 
synsms(or,nummer). 
synsms(ora,fra). 

synsms(p,p�). 
synsms(p�sserer,passerer).   %% neib key 
synsms(qlt,kult).   

    synsms(drqlt,bra). %% as single word

synsms(qutetider,rutetider). %% ETC 
synsms(r,er). 
%% synsms(rik,til).  %% blir jeg rik ?
synsms(rulr,bestemmer). %% ruler :-)

synsms(s,sentrum).    %% NB trondheim s -> trondheim sentrum* (#->TS) 

%% synsms(s,siste). %% TA-100825  %%  Hazardous, change to fnlp = [s] 
                         %%  Buss 6 g�r fra s kl 16.00   

% synsms(sett,rett).  %%  noise

%%%%%% synsms(st,sentrumsterminalen). %%  NB St Olavs hosp. 
synsms(sundt,rundt).   

%% synsms(s�,p�). %% for � v�re p� %% Haz?


synsms(t4l,til).         %% sms tastatur 
%% synsms(t,til).        %% -> synword
%% synsms(t,ta).           %% Hazard ???  t sentrum
synsms(teg,veg).         %% neib key 
synsms(tei,vei).         %% neib key
synsms(thl,til).         %% neib key
synsms(tl,til).  
synsms(tij,til).         %% neib key
synsms(tijk,til).        %% j=1,+ k=2 = l=3 smstab
synsms(tilw,til).  
synsms(tolk,voll).       %% ordliste 

synsms(u,du). %% E/N confuse %% er'u g�rn eller 
synsms(u�re,v�re).       %% neib key 

synsms(v,ved).  
synsms(v,v�re).    %%  haz ?

synsms(va,ta).           %% neib key ?

                %% destroys va re = v�re
%% synsms(var,tar).         %% Hazardous %% det var buss 5 som gikk
%% synsms(v,varsle).     %% Hazard
%% synsms(v,ved).  %%## johan falkberges v <--- 
%% synsms(vi,vil).       %%  Hazard    vi tar buss
%% synsms(vi,til). %% vi -> ti -> til 

%% synword(vil,til).     %% Too haz 

synsms(vik,til).         %%  low haz
synsms(vt,vet).  


synsms(�ste,neste). %% actual

% sms names
synsms(lgctr,elgeseter). 

%--------------------------------------------------------------------%


synword(femtes,femte). %% Lack gen  of ordinals
%% etc etc
synword('f|r',f�r). 


synword('-',til). %% 24/12 - 1/1 
synword(',',[]). %% makes ',' optional

%% Roman Numerals ( subset)

%%%% synword(i,1). Too Haz

synword(ii,  2). 
synword(iii ,3). 
synword(iv,  4).   


synword('va�re',v�re). 
synword('va|re',v�re). 

synword('a|',jeg). %%   æ %%  dial+
synword('va|re',v�re). %%  va|re 
%% synword('va|r',v�re). %%  va|r  ? %% dial+  



%% synword(v,5). %% Too hazardous  v = 5 = kl 5 
%% synword(vi,  6). %% Too Hazardous

synword(v11s,viis).   
synword(vii,viis).   

synword(vll,viis).   
synword(v11,viis).   

synword(vll,vii).   
synword(v11,vii).    

synword(vll,7).     
synword(v11,7).     

synword(iiv,vii).       %%  Haakon

synword(iiv,  7).   %% correction 
synword(iivs,  7).  %% 

synword(v11 ,7).  
synword(vii ,7).  
synword(vll ,7). 
synword(viis ,7). 
synword(viii,8).
synword(ix,  9).
% synword(x,  10). %% Fra x til voll

synword(ol,etc).

%%  synword(o,[]).  %% fra o j almos veg 

synword(o,0).  
synword(oo,00).  
synword(ooo,000).  
synword(oooo,0000). %%  2400). %% confusing
  
synword('0o',00). 
synword('o0',00). 

synword('o100',0100). 
synword('o745',0745). 

synword('08oo',0800). %% unnec split NNAA

synword(o8oo,0800).    %% ETC

synword('11oo',1100).  %% unnec split NNAA
synword('12oo',1200).  
synword('13oo',1300).
synword('14oo',1400).
synword('15oo',1500).
synword('16oo',1600).
synword('17oo',1700).
synword('18oo',1800). 
synword('19oo',1900).
synword('20oo',2000).
synword('21oo',2100).
synword('22oo',2200).
synword('23oo',2300).
synword('24oo',2400).

synword('00am',00). %% No hazard  18.00am=18 00

synword('4am',400).                 % ETC.
synword('5am',500).     
synword('6am',600).     
synword('7am',700).  
synword('8am',800).  
synword('9am',900).  

%% synword('00pm',00).%% Hazard  6.00pm \= 6.00 <--- Reminder
synword('00tiden',midnatt). 

synword('7tida',7).  %% etc 

synword('7tiden',7). %% etc


synword('10ern',10).     %% ETC 

synword('1o',10). 
synword('2o',20).  
synword('3o',30).  
synword('4o',40).  
synword('5o',50).  
synword('6o',60). 
synword('7o',70). 
synword('8o',80).
synword('9o',90). 

% Etc for big O not relevant



synword('23oo',2300). %%  etc

synword('2oo2',2002).
synword('2oo3',2003). %% etc 


synword('7endes',7).  

%%% synword('1mai', date(2003,05,01)). % Not implemented

synword(ll,11). 

synword(l030,1030). %% NB L030 etc etc 

synword('li�rdag',l�rdag). %%  ? � tr�bbel
synword('si�ndag',s�ndag). %% i� = � 


synword('i�',�). %% special  ��� tr�bbel Ad Hoc 
synword('mi�',m�).
synword('ni�',n�).
synword('ni�r',n�r).
synword('pi�',p�).
synword('vi�re',v�re).
synword('gi�r',       g�r).     %%  g�r



%% synword('/',og).    %%  Heimdal/Lund�sen  never from H to L 
synword('/',eller). %% Hazardious ? %% buss Lademoen/Dragvoll 

%%%

%%� synword(a   

synword(a,             �). %% �-probl %% Haz

synword(aa,            �). 
synword(aadj�,         adj�). 
synword(aatte,         �tte).
synword(aav,           av).   
synword(abuss,         buss).   %% ? ala buss 3A
synword(abussen,       bussen). %% t abussen ??? 
synword(adh�,          adj�). 
synword(adhj�,         adj�). 
synword(adhl�,         adj�).
synword(adj,           adj�). 
synword(adja�,         adj�).           %% adjø
synword(adjj�,         adj�). 
synword(adjo,          adj�). 
synword(adjoe,         adj�). 
synword(adj�,          adj�).           %% own
synword(adkomst,       ankomst).        %%  (spell ?)
synword(adk�,          adj�).  
synword(adk�,          adj�). 
synword(adre,          andre). 
synword(adresseb,      adressen).  %% TA-110324 own 
synword(af,            av).        %% DK
synword(afra,          fra).  
synword(afgange,       avganger).  %%  (DK)
synword(afor,          for). 
synword(aftem,         aften). 
synword(ah,            av).        %% own 
synword(ai,            intelligens).    %% kunstig dog :-)
synword(aillt,         alt).            %%  Dial
synword(aj�,           adj�).  
synword(akomst,        ankomst).  
synword(alik,          slik). 
%% synword(all,           alle).        %% all -> article  Roughly
synword(allj,          alle).   %% dial
synword(allje,         alle).   %%
synword(aldri,         ikke). 
synword(aldrig,        ikke).
synword(ale,           alle). %%  all /all'e
synword(all_e,         alle). %% if applicable 
synword(alla,          alle).  
synword(alldri,        ikke).           %%  (spell)
%% synword(allerede,      n�).             %%  (roughly) -> reach %% n� syndrome
synword(allerede,[]). 
synword(allereie,      n�).             %% allerede, closure 
synword(allle,         alle). 
synword(allt,          alt).  
synword(alikevel,      likevel).        %%  (spell)
synword(allikevel,     likevel).
%% synword(alt,           alle).        %% not person 
synword(altid,         alltid).         %% (spell)
synword(altsay,        []). 

%%  synword(alts�,         []). %% ikke noisew (alts� ikke)

synword(allting,       alt). 
synword(alting,        alt). 
synword(allvitende,    intelligent).
synword(altvitende,    intelligent).
synword(amge,          mange). 
%%% synword(annen,         buss).     %% Jeg tar en annen buss
synword(ande,          andre). 
synword(andkom,        ankom). 
synword(andkomme,      ankomme).  
synword(andkommer,     ankommer). 
synword(ankomt,        ankomst). %% TA-110523 \+ ankommet
synword(alng,          lang).   %% sp
synword(andres,        deres).  %% rough 
% synword(andre,         ulik).           %%  / ikke ulike ! synw
% den andre bussen = #2  
%% synword(andreneste,    andre).    %% rough, also split
synword(ang,           ang�ende).
%% synword(angitt,        gitt). %% adj
synword(angjeldende,   disse).
synword(annlegg,       anlegg).   
synword(annt,          annet).    %% own
synword(annlegget,     anlegget). %%
synword(ansides,       attmed).   %% beside 
synword(anskomst,      ankomst). 
synword(ansl�,         si). 
synword(aog,           og).          %% own
synword(aom,           som).    
%% synword(applikkasjon,  applikasjon). %% -> noun
synword(avdelig,       avdeling). 
synword(avfang,        avgang). 
synword(avgag,         avgang).    %% own
synword(avgane,        avgang).   
synword(avgange,       avganger). 
synword(avgangssted,   holdeplass).%%  rough
synword(avgangssted,   origin). %%  technical
synword(avgangwer,     avganger). 
synword(avgansgtider,  avgangstider). 
synword(avgongstider,  avgangstider). %% NN
synword(avgssted,      holdeplass).
synword(avganh,        avgang).
synword(avgitt,        gitt).  
synword(avr,           avreise).
%%   synword(avreise,       etter).     %% tid Hazard ? � avreise = avgang
%%   synword(avreise,       fra).       %% sted 

synword(avkomst,       ankomst).  
synword(avnganger,     avganger).  
synword(avsender,      jeg).  
synword(ann,           an).             %% (misspell)
synword(annan,         annen). 

synword(annenhver,     mange).    %% rough 
synword(annenhvert,     mange).   %% rough 
synword(annethver,     mange).    %% rough 
synword(annethvert,     mange).   %% rough 

synword(ank,           f�r).            %%  ank 1234
synword(ank,           ankomst). 
synword(ankmst,        ankomst). 
%% synword(ankom,         ankomst). %% TA-101103
synword(ankomee,       ankomme). 
synword(ankomeer,      ankommer). 
synword(ankommme,      ankomme). 
synword(ankommmer,     ankommer).  
synword(ankommre,      ankommer). 
synword(ankommst,      ankomst).        %% (spell)
synword(ankomsy,       ankomst).        %% neibk  
synword(ankosmt,       ankomst).  
synword(annkomst,      ankomst). 

%%%%%%%%     synword(ankomst,       f�r).    %% tid  Hazard ?
%% ankomst buss v�rnes 

     synword(ankomstid,     f�r). 
     synword(ankomsttid,    f�r).    %%

%%%%  jeg vil ha en tidligere ankomst NB NB

synword(antallet,      antall).         %%  antall(et) busser
synword(ar,            er). 
synword(arabisk,       arabic). %% arabian ? 
synword(aring,         �).    %% Ringv&aring;lvn =  Ringv�lveien
synword(asap,          heretter).  
synword(asp,           heretter).
%%% synword(at,            �).    %% Hazardous  
synword(att,           at). 
synword(att,           �).              %% (Swedish)
synword(att,           tilbake). %% Hazard ? 
synword(atte,          �tte). 
synword(attenda,       tilbake). %% sp
synword(attende,       tilbake).
synword(atter,         etter). 
synword(attevar,       hva).     %%  at det var ???
synword(atme,          ved).     %%  forbi?
synword(atmed,         ved).     %%  forbi?
synword(attme,         ved).   %%
synword(attmed,        ved).   %%
synword(aust,          �st). 
synword(avg,           avgang). 

%% synword(avg,           f�r).            %%  buss avg 1234 ...
%% synword(avgang,           f�r).    %% Hazardious  avg nr 9 fra 

synword(avgamg,        avgang).  
synword(avstigning,   ankomst). 
synword(ay,            at). 
synword(ay,            �).        %%  å 
synword(aytte,         8). 
synword(a�nsker,       �nsker). 
synword(a�yeblikk,     �yeblikk).
synword(ayr,           �r).  
%% synword(ayr,           g�r).  %% �r
%% synword(ayr,           n�r).  %% ??
synword(aypen,         �pen).
synword(ayssen,        hvordan). %% �assen
synword(ayssn,         hvordan). 
synword(a�st,          �st).  
synword(a�stre,        �stre).
synword(a�vre,         �vre). 
synword(a�,            �).   
synword(a�,            m�). %% ? actual   

%%� synword(b   


synword(b,             buss). 
synword(baklengs,      tilbake).        %%  :-)
synword(ban,           man). 
%% synword(banan,         banene).  %% ? :-) 
synword(bar,           bra). 
synword(bar,           n�r).  %% neib nar

%% synword(bare,  []). %% bare engelsk %% not noise ( ikke bare \== ikke)

synword(basserer,      passerer).    %% own
synword(battbus,       nattbuss).  
synword(battbuss,      nattbuss).    %% own   neib
synword(bauss,         buss). 
synword(bayt,          b�t). 
synword(bbuss,         buss).   
synword(bdet,          det). 
synword(bed,           ved). 
%% synword(bedre,         bra).  
synword(bedste,        neste).   %% Dan  "den bedste"
synword(begge,         alle).    %% Rough, ignore implicit presumption(2)
synword(bei,           nei).  
synword(bekjed,        beskjed).  
synword(beklager,      unnskyld). 
synword(better,        etter). %% ? lang. sel. buss better 
synword(ben,           byen).    %% ?
%% synword(ber,           her).       %% ber studentby 
synword(bere,          bare).       
synword(berre,         bare). 
synword(bersvart,      besvart). 
synword(berusede,      beruset).
synword(besked,        beskjed).  
synword(beskeder,      beskjeder).
synword(besser,        busser). 
%% synword(beste,         neste).   %% Ambiguous Rough Norges beste system 
synword(bestandig,     alltid).  

%% synword(bestemte,      en).      %% jeg �nsker bestemte ruter ( not noise!) %% jeg bestemte at

synword(betse,         beste).   %% neste? 
synword(beyn,          byen).  
synword(bfr,           fra).     %% b fra 
synword(bfra,          fra).     %%
synword(bf�rste,       f�rste).
synword(bgynte,        begynte).
synword(bhilke,        hvilke). 
synword(bhva,          hva). 
synword(billetrt,      billett).
synword(billigst,      best).    %% rough
synword(bir,           bor). 
synword(bissem,        bussen).   
   synword(flybissem,     flybussen).  %% 
synword(biuss,         buss). 
synword(biussen,       bussen). 
synword(biussene,      bussene). 
synword(biusser,       busser).
synword(blaa,          bl�). 
synword(ble,           er).
synword(blei,          er).  
synword(blidere,       blid). 
synword(blidest,       blid).
synword(blideste,      blid). 
synword(blii,          bli).  
synword(blit,          blitt).
synword(bliver,        blir). 
synword(bluss,         buss).  
synword(bn,            bussnummer). %%  ?
synword(bneste,        neste). 
synword(bnussen,       bussen). 
synword(bn�r,          n�r).    %%  neib
synword(borbi,         forbi). 
synword(bortafor,      bortenfor).
synword(bortfra,       fra). 
synword(borti,         i).      %%  / to ?
synword(bortil,        til). 
synword(borttil,       til). 
synword(bot,           bor).  %% TA-110214
synword(br,            bussrute). 
synword(br,            nr).     %%  neib key
%% synword(bra,           fra).    %% er det bra med deg
synword(braa,          bra). 
synword(brar,          drar). 
synword(bro,           bru). 
synword(brukker,       bruker).
synword(brukr,         bruker).
synword(bruss,         buss).  
synword(bs,            buss).
synword(bsod,          kr�sj).       %% blue screen of death :-)
synword(bluescreen,          kr�sj). 
synword(bss,           buss). 
synword(bssen,         bussen). 
synword(bssene,        bussene).
synword(bsser,         busser). 
synword(bsus,          buss). 
synword(bsuss,         buss).  

synword(btil,          til).  
synword(btss,          buss). 
synword(btssen,        bussen).
synword(btssene,       bussene).
synword(btsser,        busser).

synword(bu,            buss). %% NN bo ?
synword(bu8ss,         buss).   %% not actual if numsplit
synword(buaa,          buss). 
synword(bub,           buss).   %% bu�
synword(bubb,          buss). 
synword(bubuss,        buss). 
synword(budd,          buss). 
synword(buds,          buss).   %% slip
synword(budss,         buss).   %% slip
synword(buee,          buss).   %% slip 
synword(buf,           buss).   %% slip
synword(buff,          buss). 
synword(buffen,        bussen). 

% synword(bug,feil).        %% Not adjektiv // messy
synword(bugs,bug).       %% NB, skal ikke b�yes som subst
synword(buiss,         buss).
synword(buissen,       bussen).
synword(buissene,      bussene).
synword(buisser,       busser).

synword(bukker,        takker). %% takker og bukker :-) 
synword(buker,         bruker). 
synword(bummer,        nummer). 
synword(bunn,          buss). 
%% synword(burde,         kan).  %%  (kunne syn kan)
synword(burr,          buss).   
%% synword(burs,          buss).  % noun2

synword(busas,         buss). 
synword(busd,          buss). 
synword(busds,         buss).     %%  own slip
synword(buseen,        bussen). 
synword(buseene,       bussene). 
synword(busenne,       bussene). 
synword(busesen,       bussen).  
synword(buseser,       busser).  
synword(busesn,        bussen). 
synword(busn,          bussen). 
synword(busnr,         bussnummer).
synword(busren,        bussen).  
synword(bussan,        bussene). 
synword(bussalternativ,buss). 
synword(bussalternativer, busser).  

synword(bussane,       bussene).        %%   NYNORSK*
synword(bussarna,      bussene).        %%  sv
synword(bussb,         buss).   
synword(bussbytt,      overgang).
synword(bussd,         buss).           %%  NeibK 
synword(bussden,       bussen).  
synword(bussdn,        bussen).         %% 
synword(busse,         busser).         %%   DANSK  
synword(busse,         kj�re).          %%  ( take_bus )
synword(busseb,        bussen).         %% neighb key  spell
synword(bussebe,       bussene).  
% synword(busseene,      bussene).   
synword(bussem,        bussen).         %% neighb key 
synword(busseme,       bussene). 
synword(bussenea,      bussene).  
synword(bussend,       bussen). 
synword(bussenen,      bussene). 
synword(bussenene,     bussene).  
synword(bussenf,       bussen). %% .. ra
synword(bussenj,       bussen).  
synword(bussenm,       bussen). 
synword(bussenn,       bussen).   
synword(bussenneste,   neste).  %% .. buss (repair) 
synword(bussenne,      bussene).
synword(bussenr,       nr). 
%% synword(bussens,       bussen).         %% Haz?  bussens innvendige merking

synword(bussere,       busser).         %%  own
synword(busserrute,    bussrute).       %%  own
synword(busserr,       busser).         %% sp 
synword(bussesn,       bussen).         %% contag
synword(bussent,       bussen).  
synword(bussern,       bussene).        %%  Dial
synword(busserna,      bussene).        %%   SVENSK
synword(busserne,      bussene).        %%   DANSK
synword(bussers,       busser). 
synword(bussert,       busser). 
synword(busses,        busser).         %%  ( ikke buses Lang Conflict)
synword(bussesr,       busser).  
synword(busset,        bussen). 
synword(bussewn,       bussen).         %%  neib k
synword(bussewr,       busser). 

synword(bussf,         buss).  
synword(bussholderplasse, bussholdeplass).
synword(bussholde�lass, bussholdeplass).   
synword(bussi,         buss).  
%% synword(bussinn,       buss). %%... til (also split) 
synword(bussin,        bussen).   %% 1n 
synword(bussing,       busser).  
synword(bussirakel,    bussorakel).  %%  ?
synword(bussm,         buss). 

synword(bussorakalet,  bussoraklet). 
synword(bussoreklet,   bussoraklet).    %% own

synword(busj�f�r,      bussj�f�r). 
synword(busjoff�r,     bussj�f�r).
synword(bussj�rf�r,    bussj�f�r).  
synword(buusj�f�r,     bussj�f�r).  


synword(bussjayfa�r,   bussj�f�r).   
synword(bussj�f�re,    bussj�f�rer).  
synword(busssj�foren,  bussj�f�ren).
synword(busssj�f�rern,bussj�f�ren).
synword(busssj�f�rern,bussj�f�ren).
synword(bussf�rern,bussj�f�ren).
synword(bussf�ren,bussj�f�ren).
synword(bussf�reren,bussj�f�ren).
synword(busssj�f�reren,bussj�f�ren).

synword(bussrt,        busser).         %% dbl neib
synword(bussrue,       bussrute).       %%  spc
synword(bussrutan,     bussrutene).   
synword(bussruteb,     bussruten).   %% TA-110104
synword(bussrutebe,    bussrutene).  %% 
synword(bussrutte,     bussrute).
synword(bussruth,      bussrute).

synword(bussn,         bussen). 
synword(bussne,        bussene). 
synword(bussnee,       bussene). 
synword(bussnene,      bussene).
synword(busr,          busser). 
synword(busran,        bussene). %% dial+spell 

synword(busorakelet,   bustuc). %% TA-101117
synword(busoraklet,    bustuc). 
synword(bussorakelet,  bustuc).  
synword(bussoraklet,   bustuc). 
synword(bussorakelt,   bustuc). 
synword(bussorakl,     bustuc).
synword(bussoraaklet,  bustuc). 

synword(bussr,         busser).
synword(bussre,        busser). 
synword(bussrn,        bussene). %% Dial 
synword(bussrnr,       bussene). %% neib 
synword(bussrutenen,   bussruten). 
synword(bussrutenr,    rute). 
synword(bussse,        bussen). 
synword(busssr,        busser). 
synword(busssen,       bussen).  
synword(bussser,       busser). 
synword(busst,         buss). 
%% synword(busstasjone,   holdeplass). %%  no HT   
synword(bussterm,      bussterminalen). 
synword(busst�k,       bustuc).  
synword(bussum,        bussen).  
synword(bussun,        bussen).   
synword(bosstrerminalen,  bussterminalen).  %% ?
synword(bust,          buss). 
synword(buste,         buss).  
synword(bustrute,      bussrute). 
synword(busstrute,     bussrute).
synword(bustt,         buss). 
synword(bustter,       busser).   
synword(busss,         buss).           %% not genitive
synword(bussnr,        rute). %%  kvilket bussnr g�r til ... 
synword(bussten,       bussen).  
synword(busstuc,       bustuc).
synword(busspen,       bussen).
synword(bussurte,      bussrute).
synword(busswe,        busser). %% dbl neib k 
synword(busswen,       bussen).
synword(busswer,       busser). 
synword(busws,         buss). 
synword(buterminal,    bussterminal). 
synword(butset,        bussen). %%  (fleip)
synword(butt,          buss). 
synword(buu,           buss).   %%  ?
synword(buus,          buss). 
synword(buwss,         buss). %%  neib
synword(buzs,          buss).
synword(buzz,          buss).
synword(buzn,          bussen). %% :-)
synword(buzzn,         bussen). %% :-)
synword(buzzoracl,     bustuc). %%
synword(buzzoraklet,   bustuc). %% :-)
synword(buzzorakelet,  bustuc).
synword(buzzorakel,    bustuc). %%

synword(bva,           hva).
synword(bvs,           buss).  
synword(bwtyr,         betyr).  
%% synword(bye,           byen).    %% er bye = adj� p� norsk ?
%% synword(bye,           adj�).   
synword(byeb,          byen).    %% neib k
synword(byebye,        adj�).
synword(byby,          adj�). %% ?
synword(bygd,          laget). 
synword(bysss,         buss). 
synword(byta,          bytte).
synword(byte,          bytte). 
synword(bytte,         overgang).   %% Haz?
synword(bytur,         byen).  
synword(byuss,         buss). 
synword(byussen,       bussen). 
synword(byussene,      bussene). 
synword(byusser,       busser). 
synword(byy,           by). 
synword(b�r,           n�r).
synword(b�re,          v�re). %%  prob.
synword(b�st,          best).  
synword(b�,            hei).   %% :-) B� i Telemark 
synword(b���h,         hei).  %% act 

% synword(b�r,           m�).  -> g� (jeg m� til) ***
% synword(burde,         m�).  -> 

synword(burdte,       burde). %%  spiw

%% synword(b�r,           kan). // ikke kan=know1 
synword(b�ss,          buss). 
synword(b�,             n�).  %%  neib k  ?
synword(b�r,            g�r). %%  neib k
synword(b�r,            n�r). %%  neib k
synword(b�r,            b�t). %%  own sp 

%%� synword(c  

synword(cakl,          klokken).  %% Rough
synword(caklokken,     klokken).  
synword(caq,           ca).   
synword(cil,           vil).      %% own
synword(circka,        cirka).  
synword(clokka,        klokken). 
synword(clokken,       klokken). 
synword(cpu,           computer).
synword(cuss,          buss).
synword(cyberspace,    internett). 
synword(c�re,          v�re). %% slip 

%%� synword(d  


synword(d,             det).  %% from synsms
%% synword(da,   n�).              %%  ==> da= reach etc
synword(daa,           da).   
synword(daaa,          da).  
synword(daegen,        dagene).    %%  own 
synword(dafer,         dager).     %%  own 
synword(dagan,         dagene).    %%  Dial.
synword(dage,          dager).     %%  Dan
synword(dagere,        dager).     %% own  
synword(dagleg,        daglig). %% TA-100828
synword(dagli,         daglig). %% TA-110214
synword(dagtili,  morges). 
synword(dagtidli,  morges). 
synword(dagtidlig,  morges).  
synword(dagtilig,  morges).  

synword(dah,           da).  
synword(dah,           dag). 

synword(dan,           dagen).  
synword(dansk,danish).  %% language 

synword(dar,           dra).  
synword(das,           dag).   

synword(datan,         datamaskinen).
synword(dataen,        datamaskinen). 
synword(datao,         dato).  
synword(datamskin,     datamaskin). 
synword(datamarskin,   datamaskin).   
synword(dataskin,      datamaskin).  
synword(datamsikin,    datamaskin).  
synword(datamasikin,   datamaskin).  
synword(dati,          dato).  

synword(ddet,          det). 
synword(ddu,           du).  
synword(dey,           det). %% neib 
synword(deig,          deg). %% :-) %% TA-110311
synword(dg,            dag).   
synword(di,            de).  %% ?  sp/din 
synword(di,            din). 
synword(dia,           via).       %%  ?
synword(dib,           din).  
synword(didd,          ditt).
synword(diu,           du). 
synword(dj�,           adj�).  
synword(dkal,          skal).  
synword(dn,            den). 
synword(dne,           den). 
synword(dn�r,          n�r). 

synword(dua,           du). 
synword(due,           du).  

synword(duh,           du).  %%  :-)
synword(dui,           du).  
synword(dundt,         rundt). 
synword(duss,          buss).
synword(dussen,        bussen).
synword(dusser,        busser).
synword(duu,           du). 
% synword(de,            det). %% Dial. Hazard // g�r de to=g�r det 2
% synword(de,            du).  %% De %% Hazard 

synword(dea,           fra).  %% parall 
synword(deb,           den). 
synword(ded,           deg). %% ? 
synword(dee,           de). 
synword(deet,          det). 
synword(deg,           tuc). 
synword(degf,          tuc).
synword(dei,           de). 
synword(dei,           deg). 
synword(dein,          den). 
synword(deinn,         den).
synword(dej,           deg). 

%% synword(dem,           de).  %% dem to bussene Dial //subj|obj 

synword(dene,          denne).  
synword(denest,        senest). %% act
%% synword(deneste,       neste). %% de neste ?? seneste 
synword(denn,          den).
synword(dennee,        denne). %%  contag
synword(denste,        neste). 
synword(deste,         neste).

synword(desvere,       dessverre). %% SS 
synword(desverre,      dessverre). 

synword(dew,           de). 
synword(dewg,          deg).   
synword(dewt,          det).  
synword(dentrum,       sentrum). %%  Neib k
synword(dere,          tt).  %% NB Application Specific 
%% synword(dere,          tuc). 
synword(dereter,       deretter).
synword(derifra,       derfra). 
synword(derifr�,       derfra). 
synword(derefter,      deretter). 
synword(deres,         din). 
synword(dermed,        derfor). 
synword(derom,         der). 
synword(deromkring,    omegn). %% til Molde og omegn
synword(derr,          der).  
synword(derretter,     deretter). 
synword(dersom,        hvis). 
synword(dersoom,       hvis).  
synword(dert,          det).  %% der/det
synword(dertil,        []).   
synword(dertter,       deretter). 

synword(destinasjon,   endeholdeplass).
%% synword(destinasjon,   ankomst). 
synword(destinasjon,   til).    %% VERY pragmatic  Haz ?

 
synword(dete,          dette). 
%% synword(dete,          det).  
 
synword(detm,          det). 
synword(dett,          det). 
synword(dett,          dette).
synword(detta,         dette).
synword(dettee,        dette). 
synword(detter,        etter). 
synword(dettew,        dette). 
synword(dettte,        dette). %%  Own
synword(detye,         dette). 
synword(deu,           du).
synword(deyt,          det).  
synword(dfag,          dag).
synword(df�r,          f�r). 
synword(dga,           dag).   %% own
synword(di,            din). 
%% synword(di,            de).    %%  dial Er mora di mann ?

synword(dialekt,       norwegian). %% wrongeian :-)

synword(dial�kt,       norwegian). %%  dial :-)
synword(dig,           tuc). %%   %% Dan/Sve 
synword(digre,         store). 
synword(dil,           til).     %% own
synword(dine,          din). 
synword(dins,          eksisterer). % ?  %%  own
synword(dir,           dit).  
synword(dirr,          ditt).  
synword(direket,       direkte). %% own
synword(dirkete,       direkte). 
synword(dirkte,        direkte).
synword(dirtekte,      direkte). 

%%% synword(dit,           ditt).     %% Danish %%% ?
%% Syndrom   toget dit = toget ditt  %% keep separate, and diambiguate in gram
synword(ditt,          din).
%% synword(ditt,          dit).    %%  haz ? %% TA-101105
synword(ditta,         dette).    %% Dial 
synword(direkt,        direkte). 
synword(diretke,       direkte). 
synword(dirket,        direkte). 
synword(dneste,        neste). %% de neste 

synword(dokk,          dere). %% dial 
  synword(dom,           dum). 
%%%   synword(dom,           som).   %%  neib k
synword(domm,          dum).
synword(dommedag,      dooms_day). 

   synword(pensjonsalderen,      dooms_day). %% :-) %% TA-101117

synword(dp�,           p�). %% d p� %% own sp 
synword(draa,          dra). 
synword(drikk,         drikker). %% TA-10210
synword(spis,          spiser).  %%

%% synword(dr,            de).      %% ?
synword(drt,           det).
synword(dsag,          dag). %%   slip key
synword(dt,            det). 
synword(dta,           data). 
synword(dte,           det). 
synword(dtil,          til).
synword(dtopper,       stopper). 
synword(dtte,          dette).  

synword(du,            tuc). 

synword(dumm,          dum). 
synword(dy,            du).  %% Neib key 
%% synword(dy,            dyr). %%  dy -> dyr -> animal 

%% synword(doit,            toalett). %% ???
synword(dor,           for).     %% neib ? 
synword(dorekte,       direkte). %%  neib k ?
synword(dorlig,        d�rlig). 

%% synword(dvs,           men). %% Rough %% ? 

% synword(dyrt,          dyr). 

synword(d�,            deg). 
synword(d�g,           deg).
synword(d�m,           de).  %%  (dem??)
synword(d�n,           den). 
synword(d�r,           der).  

%% synword(d�,            du). %% Dialect die 
synword(d�gne,         d�gnet).
synword(d�gned,        d�gnet). 
synword(d�r,           f�r). %% n�r d�r jeg ?
synword(d�ygnet,       d�gnet). %% spiw 
synword(d�,            da). 
synword(d�kker,        tuc). 
%% synword(d�kker,        dere). %% shadows for tuc ? ad hoc
synword(d�r,           g�r). 
synword(d�rli,         d�rlig).

%%� synword(e  

synword(e,        er).       %% Dialect collides etter fossegrenda t trondheim s e kl 1215
synword(e,        etter).    %% (destroys n�r e � p� nardo)
%% synword(e,        jeg).      %% dial, Haz
synword(eb,       en).       %% own ?
synword(ebuss,    buss).     %% sist ebuss 
synword(ebussen,  bussen).   %%  
synword(ebussene, bussene).  %%
synword(ebusser,  busser).   %%
synword(eer,      er). 
synword(eet,      et). 
synword(eetr,     etter). 
synword(eetter,   etter).  

synword(�n, ett).   %% ( no eq in masc) 

% n�r passerer bussen e-verket

synword(ee,          er). %%  ?
synword(een,         en). %%  (even ?)
synword(eer,         er). 
synword(eeter,       etter). 
synword(effektivt,   hurtig). 
synword(efra,   fra). %% nest efra 
synword(eftermiddagsrute,ettermiddagsrute).

synword(efter,         etter).  %% efter = strict after ??no %% TA-110314   

synword(ef�r,          f�r).  %%  ... fremm ef�r 8?
synword(eg,            jeg). 

%% synword(egenlig,       []).  
%% synword(egentli,       []).  %% redundant
%% synword(egentlie,      []). 
%% synword(egentlige,     []). 

synword(eget,          []). %% TA-101019 ditt/sitt..

synword(eh,            hva). 
synword(ehh,           hva). 
synword(ehjem,         hjem). 
synword(eil,           eller). 
synword(eiller,        eller).
% synword(eiiter,        etter). 
% synword(eitter,        etter). 
synword(ei,            en). 
synword(ein,           en). 
%% synword(ein,           man). %% NN 
synword(eit,           et).  
synword(eitt,          ett). 
synword(ej,       jeg). %% ikke). %% (DK) 
synword(ej,       jeg). %% ?
synword(ejg,      jeg). 
synword(ejeg,     jeg).  
%% synword(ekker,    eller). %% ? own 
%% synword(eks,      []).  %% (f.)eks

synword(eks,      eksempel). 

synword(ekspress, direkte).  

synword(ekstra,   noe). %% koster det ekstra %% rough
synword(ekstremt, veldig). 

synword(el,            eller). 
synword(eldst,         gammel).%%  (rough, only for chat) 
synword(eldste,        gammel).
synword(eler,          eller). 
synword(elerl,         eller).
synword(elelr,         eller).
synword(elker,         eller).
%% synword(eller,         etter).  %%  buss 5 eller 36 fra moholt =>  2436 
%% synword(ellers,        []).     %% destroys ellers tenkte jeg p� bussen     
synword(elle,          eller).  
synword(ellee,         11).   
synword(elller,        eller).
synword(ellr,          eller).
synword(elr,           eller).
synword(eltter,        etter).

synword(em,            en).         
synword(emeil,         email). 
synword(emellom,       mellom).  
synword(emllom,        mellom). 
synword(emmlom,        mellom). 
synword(emn,           men).
synword(ene,           en). 
synword(eneset,        eneste). %% own sp
synword(enest,         eneste).
synword(engelsk,       english). 
synword(englesk,       english). 
synword(enhver,        alle). 
synword(enste,         neste). %% eneste). 
synword(ennu,          n�).            %%  rough
synword(enn�,          n�).            %%  rough

% synword(enda,          n�).   % Noise

synword(endrede,       endrete). 
synword(endrerde,      endrete). 

synword(enkelte,       noen). 
synword(enklast,       enklest). 
synword(enkleste,      beste). 
synword(en�r,          n�r).  


synword(eom,      som). 
synword(ep�,      p�).  
synword(era,      fra).  
synword(erv,      er). %% e r bl sperr
synword(er�,      er).

%% synword(erdet,    eksisterer). 
synword(erf,      er).  
% synword(erk,      fra).           %% act.
synword(ern,      en). %% ??? ti ern = tiern
synword(err,      er). 
synword(errer,    etter).  
synword(erret,    etter).  
synword(errter,   etter). 
synword(erter,    etter). 
synword(ertt,     etter). 
synword(ertter,   etter).  

synword(este,          neste). 
synword(estimert,      riktig). 
synword(eteer,         etter). 
synword(etellerannet,  noe). 
synword(eter,          etter).  
synword(eterr,         etter). %% own
synword(etermida,      ettermiddag). 
synword(etermidda,     ettermiddag). 
synword(etetr,         etter). 
synword(etf�r,         f�r).   
synword(etgter,        etter).  
synword(ether,         etter).  %% TA-110120
synword(etn,           en).          %% repair 
%% synword(etr,           et). %%  own
synword(etr,           etter).  
synword(etrter,        etter). 
synword(etsaje,        etasje). 
synword(ett,           et).          %% Spezial behandlung 
%% synword(ett,           etter).    %% Haz
synword(ette,          etter).       %% spell/dial 
synword(ettee,         etter).  
synword(etteer,        etter). 
synword(etterr,        etter). 
synword(ettert,        etter).  
synword(ettfr,         etter).       
synword(ettek,         etter).  
synword(ettel,         etter).   
synword(ettellerannet, noe).   
synword(etterb,        etter). 
synword(ettere,        etter). 
synword(etterf�r,      f�r).    %%  own 
synword(etterhvert,    deretter). 
%% synword(etterkl,       etter).  %% split
%% synword(etterklokka,   etter). 
%% synword(etterklokken,  etter).  %%
synword(etterm,        ettermiddag). 
synword(ettermidda,    ettermiddag). 
synword(ettermiddadg,  ettermiddag). 
synword(ettermidddag,  ettermiddag). 
synword(ettermkl,      etter). 
synword(ettermida,     ettermiddag). 
synword(ettern�,       heretter). 
synword(etterpay,      deretter).   %% etterpå 
synword(etterp�,       deretter).  
synword(ettersom,      fordi).    
synword(ettes,         etter).  
synword(ettet,         etter). 
synword(ettewr,        etter). 
synword(ettor,         etter). 
synword(ettr,          etter). 
synword(ettre,         etter).  
synword(ettrer,        etter).       %% own sp
synword(ettrmiddag,    ettermiddag).
synword(ettrp�,        etterp�). 
synword(ettrt,         etter). 
synword(ettter,        etter). 
synword(etyter,        etter). 

synword(eundt,         rundt).  

synword(evd,           ved).   
%% synword(eventuell,eller). 

synword(eventuell,[]).

synword(eventuelle,[]). %%  eventuelle feil 

synword(eventuelt,eller).  %%
synword(evntuelt,eller). 
synword(evntuellt,eller). 
synword(event,eller).
synword(evn,eller).  
synword(evnt,eller). 
%% synword(evt,[]).  %% blocks evt. ? 
synword(evt,eller). 
synword(ev,eller).  
%%  synword(exit,          adj�).    %% -> eng
synword(ewr,           er).      %% ? own
synword(eyter,         etter).   %%  slip
synword(eytter,        etter). 


%%� synwordf  


%% synword(f,             fra).     %%   f -> fra -> etter #####   
%% synword(f,             f�r).     %% causes ambig 
%% synword(f,             f�rste).  %% ogs� synsms ? 

synword('fi�r',       f�r).  
synword(f0rste,        f�rste). 
synword(fa,            fra).  
%% synword(fa,            f�). %% Haz 

synword(faorste,       f�rste).     %% �-tr�bbel  første
%% synword(far,           f�r).        %% TA-110122 // fra ??
synword(fa�lger,       f�lger).  
synword(fa�r,          f�r).        %% før .
synword(fa�rste,       f�rste).     %% �-tr�bbel
synword(fa�rstkommende, f�rste). 
%% synword(fa,            f�).      %%  Collision ?
synword(faa,           f�). 
synword(faar,          f�r). 
synword(faarstaar,     forst�r).  
synword(faerre,        f�).      %%  enn???
synword(famile,        familie).
synword(famme,         framme). 
synword(fakta,         informasjon). 
synword(far,           fra). 
%% synword(fara,          fra). %% FARA a/s 
% synword(farefritt,     safely). 
synword(farve,         farge). 
synword(farvell,       adj�).  
synword(farven,        fargen).
synword(farvene,       fargene). 
synword(farvens,       fargens). 
synword(farvenes,      fargenes). 
synword(farvel,        adj�).
%% synword(favoritt,      beste). %% ? 
synword(fay,           f�).     %%  få
synword(fayr,          f�r).    %%  får
synword(faytt,         f�tt). 
synword(fa�ste,        f�rste). %% føste 
synword(fbuss,         buss).   %% f�rste? 
synword(fca,           fra). 
synword(fda,           fra). 
synword(fdra,          fra). 
synword(fea,           fra).
synword(femme,         fremme). 
synword(fen,           fem). 
synword(feorste,       f�rste).
synword(fer,           kj�rer). 
synword(fer,           for).  %% dial
synword(fera,          fra).  %%           sp 
synword(ferdag,        fredag). 
synword(ferdes,        g�r).  
synword(ferdi,         ferdig).  
synword(ferm,          5).  
synword(ferrest,       f�rre).   %%  incomplete #
synword(ferrest,       f�). 
synword(ferste,        f�rste). 
synword(festbussen,    nattbussen). 
synword(fetter,        etter).   %% actual
synword(fe�,           fra). 
synword(ffor,          for).  
synword(ffra,          fra). 
synword(ff�r,          f�r).  
synword(fgra,          fra). 
synword(fil,           til).   %% file? Haz?
synword(fims,          eksisterer).
synword(fimns,         eksisterer). %% neib k 
synword(finnast,       eksisterer). %% NN 
synword(finnes,        eksisterer).
synword(finnnes,       eksisterer). %% (finnsnes)
synword(finns,         eksisterer). 
synword(fins,          eksisterer). 
synword(finsk,         finnish).  
synword(finst,         eksisterer). %%  NN
synword(finnst,        eksisterer). 
synword(fint,          bra).        %% avoid fine 3 biler = bra, tre biler
synword(fior,          for).   
synword(fir,           for). %% own 
synword(firmiddag,     formiddag). 
synword(firmiddagen,   formiddagen). 
synword(firste,        f�rste). 
synword(fjede,         fjerde).   
synword(fla,           fra).  
synword(fleire,        flere).  
synword(fleksibelt,    bra).        %%   (roughly)
synword(flere,         mange).      %% rough
synword(flinkest,      flink).
synword(flr,           f�r).        %%  neib k
synword(flrste,        f�rste).     %%  neib k
synword(fluybuss,      flybuss).   
synword(fluybussen,    flybussen).  %%
synword(flyavg,        flyavgang). 
synword(flybusse,      flybusser).  %% Da 
synword(flyp�ass,      flyplass). 
synword(flyp�assen,    flyplassen).
synword(fly�buss,      flybuss).   
synword(fnattbussen,   nattbussen).
synword(fneste,        neste).      %% Repair 
synword(fn�r,          n�r).  
synword(fo,            for).  
synword(fof,           for). 
synword(foill,         full). 
synword(foir,          for). 
synword(fobi,          forbi). 
synword(foelgende,     f�lgende). 
synword(foer,          f�r). 
synword(foerbi,        forbi). 
synword(foerst,        f�rst). 
synword(foerste,       f�rste). 
synword(folgende,      f�lgende).  
synword(folk,          personer). 
synword(fom,           etter).    %% fra og med 
synword(foor,          for).    
synword(fopr,          for). 
synword(foprbi,        forbi). 
%% synword(for,           fordi).   %%  jeg jobber for TT
synword(fora,          for).  %%  ?
synword(forai,         forbi). 
synword(forci,         forbi). 
synword(fori,          for). %  fori � v�re .. 
synword(forb,          forbi). 
synword(forbe,         forbi). 
synword(forbiu,        forbi). 
synword(forbu,         forbi).
synword(forby,         forbi). 
synword(forbid,        forbi).   
synword(forbie,        forbi). 
synword(forbil,        forbi). 
synword(forbin,        forbi).  
synword(forbir,        forbi).  
synword(forbli,        forbi).   
synword(ford,          fordi). 
synword(fordbi,        forbi).      %%  neik
%% synword(fordi,         forbi).   %% Haz
%% Haz ? g�r bussen fordi det er streik ? 
synword(foreg�ende,    forrige). 
synword(forelsening,   forelesning). 
synword(forerst,       forrerst).
synword(foresten,      forresten). 
synword(fore�pig,      forel�pig). %% own 
synword(forressten,    forresten). %%

synword(forf,          for). 
synword(forferdelig,   veldig). 
synword(forgi,         forbi).  
synword(forgie,        forrige). 
synword(forgif,        forrige).    %% ?
synword(forg�r,        foreg�r).    %%  own
synword(fori,          forbi).      %%  "Frei" sic
synword(forib,         forbi). 
synword(foribi,        forbi).  
synword(forige,        forrige). 
synword(forig�rs,      forg�rs). 
synword(forig�rs,      forg�rs). 
synword(forje,         forrige). 
synword(forni,         forbi). 
synword(foro,          for). 
synword(forr,          for).  
synword(forran,        foran).
synword(forrbi,        forbi).  
synword(forsent,       sent). %%  forsinket).
synword(forsi,         forbi). 
synword(forsinka,      forsinket). 
synword(forsinkede,    forsinket).  %%  ( DANSK)
synword(forrig�rs,     forg�rs). 
synword(forsjelie,     forskjellige). 
synword(forsjelige,    forskjellige). %%
synword(forsjellig,    forskjellig).
synword(forsjellige,   forskjellige).
synword(forsjelige,    forskjellige). 
synword(forskinket,    forsinket). 
synword(forskjelie,    forskjellige).
synword(forskjelige,   forskjellige). 
synword(forst,         f�rste).        %% most prob (f�rst?) 
synword(forstayr,      forst�r).
synword(forste,        f�rste). 
synword(forstod,       forsto). 
synword(forst�e,       forst�r). 
%% synword(forsvant,      gikk). 
synword(forsunket,     forsinket).  
synword(fortast,       snarest). 
synword(fortel,        fortell).  
synword(fortest,       snarest).  
synword(fortes,        snarest). 
synword(fortest,       bra). 
synword(forteste,      beste). 
%% synword(fortsatt,      n�).        %%  NOT the verb !!!
synword(fort�l,        fortelle). 
synword(fort�ll,       fortelle). 
synword(fort�lle,      fortelle). 
synword(foruten,       uten). 
synword(forvbi,        forbi).  
synword(forvirrende,   d�rlig). 

synword(for�vrig,      redundant0). %% redundant adverb
                                    %% but necessary for word order %% TA-101117

synword(fot,           for).      %% NEIB KEY 
synword(fotball,       football). %% name
synword(fottball,      football). %% name 

synword(fotbi,         forbi). 
synword(fote,          ofte).
synword(fotelle,       fortelle). 
synword(fots,          fot). %% ad hoc  Til fots 
synword(fp,            f�).       %% neib k 
synword(fpr,           f�r). 
synword(fpr,           for).      %% neib k 
synword(fprst�r,       forst�r).  %%  own sp
synword(fprt,          fort). 
synword(fqa,           fra).  
synword(fr,            fra). 
%% synword(fr,            for).   %%  confuse ??
synword(fr4a,          fra).      %% neib k
synword(frab,          fra). 
synword(frad,          fra).  
synword(frafra,        fra).      %%  Repair 
%%  synword(frai,          fra).
synword(frak,          fra).  
synword(fral,          fra).  
synword(fram,          framme). 
%% synword(fram,        fra).     %% ignored anyway
synword(framdeles,     n�). 
synword(frame,         framme).  

synword(framfor,       foran).   
%% synword(framfor,       fremfor). %% ordnett %% instead_of


synword(framkomst,     ankomst). 
synword(framm,         framme).   %% dial 
synword(framme,        f�r).
synword(frammen,         framme).  
synword(framleis,      n�). 
synword(frammme,       framme). 
synword(framover,      fram).         %%   ( g�r det framover ?)
synword(framover,      heretter). 
synword(framste,  f�rste).    %%
synword(framerste,  f�rste).  %%
synword(frammerste,  f�rste). %%
% synword(framover,      bra).        %%  :-)
synword(fran,          fra). %% - Fana amblehash
synword(franm,         fram). 
synword(franme,        framme).
synword(franmme,       framme).
synword(fransk,        french).
synword(fran�r,        hvorfra).  %%  Rough
synword(frap,          fra).
synword(frar,          fra).    
synword(frar,          drar). %% ?  own
synword(fraq,          fra).  
synword(fras,          fra).      %% neib k
synword(frat,          fra).  
synword(fratil,        forbi). 
%%  synword(fratr,         fra).     %% fra tr sentralst.
synword(fray,          fra).  
synword(fra�,          fra).  
synword(frbi,          forbi). 
synword(frd,           fra).  
synword(frda,          fra).  
synword(frea,          fra).  
synword(frem,          fram).  
%% synword(fremfor,       foran). %% ?  %% also "better than"
synword(fremm,         fram). 
synword(fremdeles,     n�).
synword(fremkomst,     ankomst). 
synword(fremover,      heretter). 
synword(fremmover,     heretter). 
synword(freme,         framme). 
synword(fremma,        framme). 

synword(fremme,        framme). 
%% synword(fremme,        f�r).   %%  (Trans.  -> framme ->) 
                                  %% bussen er fremme  onsdag

synword(fremmede,      personer). %% rough  (most persons are ...
synword(fremmer,       framme). 
synword(fremmme,       framme). 
synword(frfa,          fra). 
synword(frta,          fra). 
synword(forbh,         forbi).  
synword(forrerste,     f�rste).  %% Rough 
synword(fremste,       f�rste).


%% fram er redundant  buss 66 er fremme 10 ==> buss 66 = 10 # 

synword(frg,           forrige).  
%% synword(fri,           fra).   %% ?? Haz 
synword(frifor,        uten). 
%%synword(frisk,         god).          %%  (Rough)
synword(fresk,         god).  
synword(frla,          fra). 
%% synword(frm,           fra). %% fram?
synword(frmeme,        framme).
%% synword(fro,           fra). %% causes commit error
synword(fro,           for).    %% for � v�re

synword(frobi,         forbi). 
%% synword(fron,          fra). %% TA-110415  (S�r) Fron
synword(fror,          for). 
synword(frorbi,        forbi).  
synword(fraa,          fra). 
synword(frq,           fra).
synword(frqa,          fra). 
synword(frp,           fra). %% fr�? :-) 
synword(frr,           fra).
synword(frra,          fra).  
synword(frrra,         fra).
synword(fryktelig,     d�rlig). 
synword(fr�,           fra). 
synword(fr�kk,         frekk). 
synword(fr�,           fra).
synword(fr�rste,       f�rste).
synword(fr�ste,        f�rste). 
synword(fr�,           fra).  
synword(fr�n,          fra).          %% Swedish 
synword(frs,           fra).     %% neib k 
synword(frsa,          fra). 
synword(frst,          f�rst). 
synword(frste,         f�rste).  %% 
synword(fru,           fra).     %%  ?
synword(fsa,           fra). 
synword(fta,           fra).     %% own sp 
synword(ftil,          til). 
synword(ftra,          fra).  
synword(fu,            du).      %% neib 
synword(ful,           full). %% lur?
synword(fulstendig,    fullstendig). 
synword(fulstendige,   fullstendige). 
synword(fllstendig,    fullstendig). 
synword(fllstendige,   fullstendige). 
synword(fult,          fullt). 
synword(fusser,        busser). %% etc
synword(fvra,          fra).  
%% synword(fy,            d�rlig). %% :-) 
synword(fydda,         d�rlig).
synword(fyrst,         f�rst). 
synword(fyrste,        f�rste).
synword(fyste,         f�rste). 
synword(f�m,           fem).  
%% synword(f�r,           g�r).      %%  Dial %% confuse f�r %% TA-110214
%% synword(f�r,           reise).    %%  dial \+ en reise
synword(f�r,           f�r).      %%   f�r  %%  N�r f�r bussen
%% synword(f�r,           kj�rer).   %%  Dial.%% confuse f�r %% TA-110214

synword(f�rdi,         ferdig).  
synword(f�re,          v�re). %% sp 
%% synword(f�rre,         f�).  %% (unwanted_verb) \+ get  
synword(f�rrest,       f�).           %%  Rough 
synword(f�rste,        f�rste).  
synword(f�,            f�r). 
synword(f�dd,          f�dt). 
synword(f�e,           f�r).  
synword(f�er,          f�r).  
synword(f�k,           f�r).  
synword(f�l,           f�r).
synword(f�les,         er).           %% For all PP 
synword(f�lgelig,      derfor).
synword(f�lges,        g�r).    %% hvilke ruter f�lges 
synword(f�prste,       f�rste).  

%% synword(f�r,           tidligere).    %% (Hazard// Adverb)
%%                    %% (buss passerer) nth 33 f�r klokka 20
                      %% ==>             nth 33 tidlige klokker (SIC)

%% synword(f�r,           for).          %% Swe/Dial  %% Hazard
synword(f�rbi,       forbi).
synword(f�rdte,      f�rste). 
synword(f�rkl,       f�r). 
synword(f�rklokka,   f�r). 
synword(f�rklokken,   f�r). 

synword(f�rr,           for).             %% Tr�nd 
synword(f�rre,          forrige).         %% NN 
synword(f�re,          f�r).              %%  (dialect)
synword(f�rehand,      forh�nd).          %%  (dialect)

synword(f�reste,       f�rste).
synword(f�rete,        f�rste). 
synword(f�rrste,       f�rste). 
synword(f�rse,         f�rste). 
synword(f�rset,        f�rste).  

synword(f�rstg�ende,   f�rste). 

synword(f�rskommende,  f�rste). 
synword(f�rstkomende,  f�rste). 
synword(f�rstkommenede,f�rste). 
synword(f�rstekommende,f�rste). 
   synword(f�rtskommende,f�rste). 
synword(f�rst,         f�rste).        %% Haz Ambig ??? 
synword(f�rsta,        f�rste).
synword(f�rstd,        f�rste).       %% sms neib key 
%%  synword(f�rstebuss,    buss).         %% also splitword
synword(f�rstew,       f�rste). 
synword(f�rstre,       f�rste). 
synword(f�rstye,       f�rste).       %% neib k 
synword(f�rswte,       f�rste).  
synword(f�rsye,        f�rste). 
synword(f�rt,          f�r).          %% slip
synword(f�rte,         f�rste).  %%  ( spell ) %%   haz?
synword(f�rts,         f�rst).  
synword(f�rtse,        f�rste). 
synword(f�rtste,       f�rste).  
synword(f�rt�l,        fortelle).  
synword(f�sst,         f�rst).  
synword(f�sr,          f�r).          %% own
synword(f�st,          f�rst).        %% Dialect
synword(f�ste,         f�rste).       %% Dialect
synword(f��r,          f�r).   
synword(f��rste,       f�rste).
synword(f�s,           f�rste).       %% \+ f�rst
synword(f�sret,        f�rste). 
synword(f�srte,        f�rste). 
synword(f�t,           f�r).   
synword(f�tr,          f�r).  
synword(f�tste,        f�rste).  
%% synword(f�r,           for).       %%  Hvor f�r man kj�pt kort?
%% synword(f�r,           g�r).       %%   Hazardous
synword(f�rbi,         forbi). 
synword(f�rrbi,        forbi).
synword(f�rr�,         reise).  
synword(f�rste,        f�rste). 
synword(f�t,           f�tt).  
synword(f��r,          f�r).          %%  før 
synword(f��rste,       f�rste). 


%%� synword(g  


synword(g,             g�r). %% Hazard ?? 

%% synword(ga,            g�r).  %% haz?
synword(ga,            g�).  

synword(gaard,         g�rd).         %% (Lade gaard)
synword(gaat,          g�r). 
synword(gadd,          �nsket).       %% rough
synword(gamal,         gammel). 
synword(gamel,         gammel). 
synword(gamla,         gamle). 
synword(gamleste,      gammel).  
synword(gammal,        gammel). 
synword(gaa,           g�). 
synword(gaar,          g�r). 
synword(gaayr,         g�r).  
 synword(gan,          gang). %% TA-110324
%% synword(gange,         ganger). %% spasertur
%% synword(ganske,        meget). %% noise
synword(gaor,          g�r). 
synword(gar,           g�r).  

synword(garr,          g�r).  
synword(garr,          g�rd).  %% act

synword(garde,         sted).  %% av garde = av sted ?
synword(garneste,      g�r).  
synword(gas,           gass). 
%% synword(gay,           g�).    %% not nec, hom 
synword(gayr,          g�r).   %% går  �-tr�bbel also splitword
synword(gayt,          g�r).   %% gåt (?) %% act 
synword(gaytt,         g�tt). 
synword(ga�,           g�).
synword(ga�r,          g�r).   %%  gør 
synword(ga�,           g�).  
synword(ga�r,          g�r). 
synword(gbussen,       bussen).
synword(geg,           jeg).   %% LAST SYNONYM 
synword(genere,        generere). %% own
% synword(generellt,     generelt).     %% No,Noise
synword(gengur,        g�r). %% Isl
synword(ger,           g�r).
synword(ge�r,          g�r).
synword(gfra,          fra). %% slip 
synword(gg�r,          g�r). 
synword(ghvilken,      hvilken). %% slip
synword(gh�r,          g�r). %% own 
%% synword(gidder,        vil).   %%  manage
synword(gies,          gis).
synword(giff,          gikk).  
synword(gii,           gi).  
synword(gik,           gikk). 
synword(gio,           gi). 

synword(gja�r,         gj�r).  
synword(gja�re,        gj�re).  
synword(gje,           gi).     %% NN 
synword(gjeg,          jeg). 
synword(gjele,         gjelde). 
synword(gjell,         gjelder). %% dial
synword(gjelle,        gjelde).  %% spe
synword(gjelser,       gjelder). 
synword(gjemnnom,      gjennom). %% own
synword(gjemnom,       gjennom). %%  own
synword(gjemta,        gjenta). 
synword(gjennsyn,      gjensyn). 
synword(gjennomsnitts, vanlig).
% hva er en gjennomsnitts pris = measure ?
synword(gjennta,       gjenta). 
synword(gjer,          gj�r). 
synword(gjere,         gj�re).
%% synword(gjerne,        ja).   
synword(gji,           gi).  
synword(gjikk,         gikk).  
synword(gjik,          gikk).

synword(gjleder,       gjelder). 

synword(gjoer,         gj�r). 
synword(gjoere,        gj�re). 
synword(gjor,          gj�r). 
synword(gjore,         gj�re). 
synword(gjorde,        gj�re).       
synword(gjrlder,       gjelder). %% \+ Jarle
synword(gj�ng,         g�r).  
synword(gj�nge,        g�r).   
synword(gj�r,          gj�r). %% TA-100823
synword(gj�e,          gj�r).   %% own
synword(gj�rer,        gj�re). 
synword(gj�rr,         gj�re). 
synword(gj�r,          g�r).  
%% synword(gk�r,          gj�r).   %%  verb
synword(gk�rse,        gj�res). %%  own
synword(gl�m,          glem).   %% dial
synword(gl�m,          glem).   %%
synword(gmmel,         gammel). %% own 
synword(gm�,           m�). 
synword(gnag,          gang). 

%% synword(go,            god). %% Destroys lang sel.

synword(godag,         goddag). 
synword(godagen,       goddag). 
synword(goddagen,      goddag). 
%% synword(godmorgen,     goddag).      %%  (Rough)
synword(godmorn,       goddag).      %%  (Rough)
synword(godt,          bra).         %%  (sove godt :-)
synword(godtt,         bra).         %%  spell
synword(gof,           god).   %% own
synword(gomorn,        goddag).      %%  (Rough)
synword(gonatt,        godnatt).
synword(gor,           g�r). 
synword(gp,            g�).  %% Neib
synword(gpr,           g�r). 
synword(gprd,          g�rd). %% own
synword(gp�,           g�). 
synword(gr,            g�r). 
synword(gp�r,          g�r). 
synword(gra,           fra). 
synword(greie,         informasjon). %% Norw   greie p�
synword(greiest,       bra). 
synword(greit,         bra). 
synword(greitt,        bra).
synword(gretne,        sure). 
synword(gretten,       sur). 
synword(grovt,         veldig).
synword(grunnet,       pga).  %% techn
synword(gr�,           g�r). %% Haz 
synword(gr�r,          g�r). 

synword(gta,           fra). %% dbl neib %%  .. + street 
synword(gta,           ta). %% je gta 

% synword(gt,            gate).     %% only as part name, not as noun

synword(gtil,          til).    %% slip

synword(gur,           g�r).  
synword(guss,          buss).       %%  neib k
synword(gussen,        bussen).     %%  neib k
synword(guut,          gutt). 
synword(gva,           hva).        %% own sp
synword(gyr,           g�r). 
synword(g�r,           g�r).   

synword(g�r,          g�r).    %%  g�r klokken 20.10 

% synword(g�r,          f�r).       %% Haz ? n�r g�r bussen %% Destroy each other
% synword(g�r,          gj�r).        %% ?

synword(g�ra,          gj�re). 
synword(g�,            g�). 
synword(g�r,           g�r).          %% g[r ?
synword(g�rn,          gal). 
synword(g��rn,         gal).
synword(g�ern,         gal).  

synword(g�a,           g�).  
synword(g�ar,          g�r). 
synword(g�d,           g�r).  
synword(g�dd,          g�tt). 
synword(g�dr,          g�r).   
synword(g�dr,          g�rd).
synword(g�e,           g�r).        %% neighbour key 
synword(g�fr,          g�r).  
synword(g�g,           g�r). 
synword(g�gr,          g�r). 
synword(g�ir,          g�r). 
synword(g�n,           g�r).  %%  ?
synword(g�ng,          gang).  
synword(g�p,           g�r).
synword(g�pr,          g�r).

synword(g�rde,         g�r).          %% g�r det 
synword(g�rde,         sted).         %% av g�rde = av sted ? 
synword(g�rdet,        g�r).  
synword(g�re,          g�r).  
synword(g�rf,          g�r). 
%% synword(g�rf�rst,      g�r). %% rough, (split)
synword(g�rl,          g�r). 
synword(g�rn,          g�r). 
%% synword(g�rneste,      g�r).          %% also splitword 

%%% synword(g�rd,          g�r).  %%  Hazardous Lerkenda g�rd nardo

%% synword(g�rfra,        passerer).     %%  Rough
synword(g�rtil,        passerer).     %% 
synword(g�rr,          g�r). 
synword(g�rsj,         g�r). %% ?
synword(g�r�,          g�r).  
synword(g�s,           g�r). %% doesnt help? 
synword(g�rm�,         m�).  %% repair 
synword(g�rt,          g�r). %% --> g�rd ? 
synword(g�rw,          g�r). 
synword(g�t,           g�r).          %% neighbour key
synword(g�tr,          g�r).
synword(g�yr,          g�r). %% går 
synword(g��r,          g�r). 


%%� synword(h 


synword(hada,          adj�). 
synword(hadd,          hadde). 
synword(hade,          adj�).         %% ikke Lade :-)
synword(hadet,         adj�).  
synword(hadebra,       adj�). 
synword(hadeok,        adj�).  
synword(hadetbra,      adj�). 
synword(hadegv�kk,     adj�).  
synword(hadre,         hadet). 
synword(had�,          adj�). 
synword(had�v�kk,      adj�).         %%  :-)
synword(haer,          her). 

synword(hai,           hei).  
synword(haid�,         adj�).  %% ?
synword(haihai,        hei).   %% ? :-)))

synword(hakv,          halv).  %% own
synword(halb,          halv). 
synword(half,          halv). 
synword(hal,           halv).


synword(haallo,        hei). %% hallo -> hei (trans syn) 
synword(hall,          halv).  
synword(halla,         hei).  
synword(hallais,       hei).
synword(hallaisen,     hei). 
synword(halloi,        hei).
synword(halloo,        hei). 
synword(hallosann,     hei). 
synword(halloy,        hei). 
synword(hall�y,        hei). 
synword(halo,          hei). 
synword(haloen,        hei). 
synword(halloen,       hei). 
synword(haloysen,      hei).

synword(halve,         halv). 
synword(halvsy,        0630).  % etc
synword(halvsyv,       0630). 
synword(halvt,         halv). 
synword(halvv,         halv).  
%   synword(vtiden,         tiden). %% ? 

%% halv.., sorted numeric

synword(halveitt,      1230). %% Prag ,NN 
synword(halvett,       1230). %% Prag 
synword(halvettida,    1230). %% Prag
synword(halvettiden,   1230). %% Prag 
synword(halvetttiden,  1230). 

synword(halvto,        1330).         %%   etc
synword(halvtotida,    1330). 
synword(halvtotiden,   1330). 

synword(halvfem,       1630).   %% prag
synword(halvfemtida,   1630).   %% prag
synword(halvfemtiden,  1630).   %% prag

synword(halvseks,       530).         
synword(halvsekstida,   530).    
synword(halvsekstiden,  530).    


synword(halvsju,        630).         
synword(halvsjutida,    630).   
synword(halvsjutiden,   630).   
synword(halvsyvtida,    630).  % ?
synword(halvsyvtiden,   630).  

synword(halv�tte,       730).         %%   etc etc ad hoc
synword(halv�ttetida,   730).   
synword(halv�ttetiden,  730).   

synword(halvni,         830). 
synword(halvnitida,     830). 
synword(halvnitiden,    830). 

synword(halvti,         930).  
synword(halvtitida,     930).     
synword(halvtitiden,    930).     


synword(halvelve,      1030).         %%  
synword(halvelvetida,  1030).     
synword(halvelvetiden, 1030).     
synword(halvellevetiden,  1030).     

synword(halvtolv,      1130).   
synword(halvtolvtiden, 1130).   

synword(halvtretten,     1230).   
synword(halvtrettentida, 1230).   
synword(halvtrettentiden,1230).   

% etc 14 15 16 17 18 19  ???


%%% synword(han,           kan).  %% actual/hazardous

    synword(hannuka,jul). %% actual Rough
    synword(hanukka,jul). %% correct (new moon in december)


synword(hann,          han).   

synword(hasr,          har).  
%% synword(hatt,          ha).           %% (skulle hatt) %% NOT imp 
synword(hat,           har).          %% neib k 
synword(hat,           hatt).         %% Dan ? %%
synword(hatr,          hatt).    
% synword(hay,         hei).          %%  ?  eng
synword(haustruter,    vinterruter). 
synword(hav,           hva).          %%  ??? 
synword(hav,           halv). 
synword(havl,          halv). 
synword(havle,         halve).   %% JB-081208
synword(hbilke,        hvilke).     
synword(hbilken,       hvilken).  
synword(hbilket,       hvilket).  
synword(hbor,          hvor).
synword(hbordan,       hvordan).  
synword(hbvilke,       hvilke). %% own
synword(hca,           hva). 
synword(hcilke,        hvilke). 
synword(hcilken,       hvilken). 
synword(hcilket,       hvilket). 
synword(hcordan,       hvordan).   
synword(hcvilke,       hvilke).
synword(hcvilken,      hvilken). 
synword(hcvilket,      hvilket).  
synword(he,            har).          %%  dial
synword(heei,          hei).          % - heim 
synword(heer,          her).   
synword(heg,           jeg).          %%  (own sp)
synword(heh,           hei). 
%% synword(hehe,          hei). 
synword(hehei,         hei). 
synword(heia,          hei). 
synword(heiaa,         hei). 
synword(heida,         adj�). 
synword(heid�,         adj�). 
synword(heidu,         hei). 
synword(heii,          hei).  
synword(heiia,         hei).  
synword(heiiaa,        hei).  
synword(heij,          hei). 
synword(heija,         hei).  
synword(heijah,        hei). 
synword(heihei,        hei).
synword(heillo,        hei). 
synword(heil,          hel). 
%% synword(heile,         hele).  %% split
synword(heilt,         helt). 

synword(heime,         hjemme). 
synword(heimefra,      hjem).         %%  wrong direction, but error anyway
synword(heimefr�,      hjem).         %%
synword(heimanfr�,     hjem).         %% 
synword(heim,          hjem). 
synword(heisan,        hei). 
synword(heisann,       hei). 
synword(heite,         heter).  %% Dial.
synword(heiter,        heter).
synword(heitte,        heter).  %% Dial
synword(hej,           hei).    %% DK
synword(heja,          hei). 
synword(hejm,          hjem). 
synword(helgin,        helgen). 
% synword(hello,         hei).        %% Avoid  hell (spellcorr) ( gets N answer)
 synword(helv,         halv).           %% \+ hell 
synword(hem,           hjem).
synword(hem,           hvem).  
synword(hem,           hjem).   %% ?
synword(hemmat,        hjem). 
synword(hendeholdeplass,  endeholdeplass). %% diffusion
synword(henholdsvis,   b�de). 
synword(henne,         hen). %% hen may be noiseword
synword(hensiktsmessig,bra).  
synword(herefter,      heretter). 
synword(heretetr,      heretter).  
synword(herifra,       herfra). 
synword(herlig,        godt).  
synword(herr,          her).     %%  Rough (Herr)
synword(hertil,        hit).  
synword(hertter,       heretter). 
%% synword(hermed,        redundant0). 
%% synword(herved,        redundant0). %% Techical, dummy adverb
synword(hetr,          heter).  
synword(hetter,        heter).   %% Dial
synword(heste,         neste).  
synword(heu,           hei).   
synword(heui,          hei).     %% slip
synword(hevm,          hvem).   
synword(hevem,         hvem). 
%% synword(hey,           hei).     %%  destroys lang sel
synword(hgvilken,      hvilken).
synword(hhar,          har).  
synword(hhjem,         hjem).  
synword(hhva,          hva).  
synword(hhvor,         hvor).  
synword(hhvordan,      hvordan). 
synword(hhvorfor,      hvorfor). 
%% synword(hi,            har).    %% Dial ? %% Lang sel
synword(hie,           hei).  
synword(hil,           til). %% neib %% TA-110221
synword(hildringstimen,kvelden). %%  :-)
synword(hilen,         hvilken). 
synword(hilke,         hvilke). 
synword(hilken,        hvilken). 
synword(hilkene,       hvilke).  
synword(hilket,        hvilket).
synword(hilvken,       hvilken). 
synword(himmels,       himmelen). %% :-) 
synword(his,           hvis). 
synword(hitil,         tidligere). %% ?
synword(hittil,        tidligere).
synword(hivlke,        hvilke). 
synword(hivlken,       hvilken). 
synword(hivlket,       hvilket). 
synword(hivs,          hvis). 
synword(hjeg,          jeg). 
synword(hjelep,        hjelpe). %%  ?
synword(hjelpem,       hjelpen).  
synword(hjennom,       gjennom).      %% own 
synword(hjenta,        gjenta).       %%  own sp
synword(hjertet,       minnet).       %% legge det p� 
synword(hjemme,        hjem).         %% ? til hjemme
synword(hjemmefra,     hjem).         %% wrong direction, but error anyway
synword(hjemmefra,     fra).          %% hjemmefra moholt
synword(hjemmeifra,    hjem). 
synword(hjemmenfra,    hjem).  
synword(hjemmenifra,   hjem). 
synword(hjemm,         hjem).
synword(hjemmside,     hjemmeside). %% own 
synword(hjemover,      hjem). 
synword(hjenm,         hjem). 
synword(hjlp,          hjelp). 
synword(hjlpe,         hjelpe).  
synword(hjlpen,        hjelpen).  
synword(hjvilken,      hvilken).  
synword(hj�lp,         hjelp). 
synword(hj�m,          hjem).         %%   (dialect)
synword(hj�,           ved). %% hos %% NN

synword(hkvart,        kvart). 
synword(hl,            klokken). %% own (kl) 
synword(hliken,        hvilken). 
synword(hlv,           halv).    
synword(hna,           hva). 
synword(hnor,          hvor). 
synword(hn�r,          n�r).  
synword(ho,            hun). 
synword(hoho,          hei). 
synword(hoi,           hei). 
synword(hola,          hei). 
synword(hold,          holdeplass). 
synword(holdplassnavn, holdeplass). 
synword(holdepalss,    holdeplass).
synword(holdepl,       holdeplass).  
synword(holdeplasse,   holdeplasser). 
synword(holdeplassnr,  holdeplassnummer).  %% TA-110708
synword(holdeplasst,   holdeplass).    %% as noun 
synword(holpdeplass,   holdeplass).    %%  Own
synword(holdpeplass,   holdeplass).    %%  Own 
synword(holdpeplasse,  holdeplasser).  %%  Own 
synword(holdpeplasser, holdeplasser).
synword(holeplass,     holdeplass).    %%  Own 
synword(holla,         hei).         %% 
synword(holleplass,    holdeplass).    %%
synword(holpeplass,    holdeplass).    %%
synword(hoordan,       hvordan). 
synword(hoppsann,      hei).
  synword(hopsann,     hei).
  synword(hoppsan,     hei).
  synword(hopsan,      hei).
  synword(hopsansa,    hei).
  synword(hoppsansa,   hei).

synword(hor,           hvor).  %% ?
synword(hordan,        hvordan).      %%  OK ? 
synword(horfor,        hvorfor). 
%% synword(hos,           ved).          %%  \ name(ved
%% synword(hos,           hvordan). %% dial tjeneren hos ventelo
synword(hovr,          hvor).  
synword(hovor,         hvor). 
synword(hovordan,      hvordan). 
synword(hovorfor,      hvorfor).
synword(hovrdan,       hvordan). 
synword(hpl,           holdeplass).
  synword(jpl,           holdeplass). %% own
  synword(kpl,           holdeplass). %%

synword(hlp,           holdeplass). 
synword(hr,            har).         % sp %%  Haz Hr Amble
synword(hra,           fra).        %% own
synword(hror,          hvor). 
synword(hta,           ta). %% actual
synword(hter,          heter).
synword(hu,            hun). 
synword(huh,           hva). 
synword(huis,          hvis).  
synword(humor,         hum�r).        %% incorrect though
synword(hunn,          hun). 

synword(hur,           hvor).         %% (Swed)  .. lenge
synword(hur,           hvordan).      %% (Swed)

synword(hurra,         hei). 
synword(hurtigb�r,     hurtigrute).   %%  ?
synword(hurtigrute,    hurtigruta). 
synword(hurtiruta,     hurtigruta). 
synword(hurtirute,     hurtigruta). 
synword(hurtigst,      snarest).
synword(hurtigste,     beste).
synword(huse,          huset).
synword(huss,          buss).
synword(hv,            hva). 
synword(hvaa,          hva). 
synword(hvaa,          hva). 
synword(hvaaaa,        hva). 
synword(hvab,          hva). 
synword(hvad,          hva). 
synword(hvae,          hva).     %%  Own spc
synword(hvafor,        hvilken). 

synword(hvam,          hvem).    %% ?? 
synword(hvaorfor,      hvorfor). 
synword(hvarfor,       hvorfor). 
synword(hvaq,          hva).     %% own 
synword(hvar,          hva).     %% ??
synword(hvar,          hvor).    %%
synword(hvar,          var).     %% 
synword(hvart,         kvart). 
synword(hvas,          hva). 
synword(hvaslags,      hvilken). %%
synword(hva�r,         hvor).    %% hvør
synword(hvcor,         hvor).    %% TA-110110 neib
synword(hve,           hva).     %% ??? 
synword(hveem,         hvem). 
synword(hveh,          hvem).   
synword(hvehva,        hva).     %% repair
synword(hvemm,         hvem). 
synword(hveld,         kveld).   %%  own
synword(hvelke,        hvilke). 
synword(hven,          hvem). 
synword(hven�r,        n�r). %% Isl. 
synword(hver,          alle).  
synword(hvere,         hver).  %% ?
synword(hvere,         v�re).  
synword(hverken,       ikke). %% rough 
synword(hvet,          vet).  
synword(hvha,          hva). 
synword(hvhilken,      hvilken).
synword(hvm,           hvem). %% own 
synword(hvme,          hvem). 
%% synword(hverandre,     noe). %% ikke noen, e.g. busser
synword(hverdageer,    hverdager).
synword(hverdger,      hverdager).
synword(hverdah,       hverdag). 
synword(hverdaher,     hverdager).

%% synword(hvert,         hver). %%   ???
%% synword(hvert,         v�rt). %% Not worth it
%%%
synword(hvga,          hva).  
synword(hvi,           jeg). %% (vi) %% actual
synword(hvid,          hvis).  
synword(hvil,          hvilken). 

synword(hvelken,hvilken). 
synword(hvelket,hvilket).
synword(hvilenk,hvilken).
synword(hvilike,hvilke).
synword(hviliken,hvilken).
synword(hviliket,hvilket).
synword(hviljen,hvilken). 
synword(hviljken,hvilken).
synword(hvilka, hvilke).   %%  Sv
synword(hvilkin, hvilken).
synword(hvilklet,hvilket). %% own
synword(hvilkse,hvilken).  %% 
synword(hvillen,hvilken).  %% 
synword(hvirdan,hvordan).  %% own
synword(hvislen,hvilken).  %%



synword(hviilke,       hvilke). 
synword(hviilken,      hvilken).
synword(hviilket,      hvilket). 
synword(hviis,         hvis).

synword(hvike,         hvilke).      
synword(hviken,        hvilken).      
synword(hviket,        hvilket).     
synword(hviklen,       hvilken). 
synword(hviklet,       hvilket). 
synword(hviklket,      hvilket). 
synword(hviklken,      hvilken). 
synword(hvikke,        hvilke).  
synword(hvikken,       hvilken). 
synword(hvikket,       hvilket).  %%
synword(hvikle,        hvilke). 
synword(hvileken,      hvilken). 
synword(hvilekn,       hvilken). 
synword(hvil,          vil). 
synword(hvile,         hvilke).   %%  (?)
synword(hvilen,        hvilken). 
synword(hvilet,        hvilken).
synword(hvilekt,       hvilket). 
synword(hvilhen,       hvilken). 
synword(hvilk,         hvilke). 
synword(hvilkan,       hvilken). 
synword(hvilkeb,       hvilken).   %% own, neib
synword(hvilked,       hvilken).   %% own, neib
synword(hvilkee,       hvilke).    %% own, %% TA-110311
synword(hvilkelt,      hvilket).  
synword(hvilkem,       hvilken). 
synword(hvilkene,      hvilke). 
synword(hvilkenn,      hvilken). 
synword(hvilkent,      hvilket). 
synword(hvilker,       hvilke).  
synword(hvilkern,      hvilken).  
synword(hvilkje,       hvilke).  
synword(hvilkke,       hvilke). 
synword(hvilkle,       hvilke).  
synword(hvilkken,      hvilken). 
synword(hvilkket,      hvilket). 
synword(hvilkn,        hvilken). 
synword(hvilkt,        hvilket). 
synword(hvilkne,       hvilken). 
synword(hvilkrn,       hvilken). 
synword(hvilkwn,       hvilken).  
synword(hvilkwnt,      hvilket).      %%  (neib k)
synword(hvillke,       hvilke).  
synword(hvillken,      hvilken).   
synword(hvillket,      hvilket).   
synword(hviloke,       hvilke).  
synword(hviloken,      hvilken).  
synword(hviloket,      hvilket). 
synword(hvil�ke,       hvilke).   
synword(hvil�ken,      hvilken).   
synword(hvil�ket,      hvilket).  
synword(hvilsken,      hvilken).  
synword(hvinlken,      hvilken). 
synword(hvioke,        hvilke). 
synword(hvioken,       hvilken).  
synword(hvioket,       hvilket).  
synword(hviolke,       hvilken).   
synword(hviolken,      hvilken).   
synword(hviolket,      hvilket).   

synword(hvior,         hvor).
synword(hviordan,hvordan). 
synword(hvir,          hvor). 
synword(hvirs,         hvis). 
synword(hvivken,       hvilken).  
%% synword(hvis,          vis).       %% Hazard ? NOT vis!
synword(hvisken,       hvilken).   
synword(hviss,hvis).       %%
synword(hvist,         hvis).  
synword(hviulke,       hvilke). 
synword(hviulken,      hvilken). 
synword(hvliken,       hvilken). 
synword(hvlilken,      hvilken). 
synword(hvlike,        hvilke).
synword(hvliken,       hvilken).
synword(hvliket,       hvilket). 
synword(hvlke,         hvilke).  
synword(hvlken,        hvilken). 
synword(hvlket,        hvilket). 

synword(hvrodan,hvordan). 
synword(hvvilke,hvilke).  
synword(hvvilken,hvilken). 
synword(hvvilket,hvilket).

synword(hvo,           hvor).  
synword(hvoa,          hva).    %% repair

synword(hvoilke,       hvilke). %% own
synword(hvoilken,      hvilken).
synword(hvoilket,      hvilket).

synword(hvodan,        hvordan). 

synword(hvoe,          hvor). 
synword(hvoedan,       hvordan). 
synword(hvoefor,       hvorfor). 
synword(hvoer,         hvor).   
synword(hvof,          hvor).        %%  own
synword(hvofer,        hvorfor).  
synword(hvofor,        hvorfor).
synword(hvoilke,       hvilke). 
synword(hvoir,         hvor). 

synword(hvoilkne,      hvilke). %% own 
synword(hvolke,        hvilke).       %% neib key 
synword(hvolken,       hvilken).      %% neib key

synword(hvolkne,       hvilke). %% own 

synword(hvolket,       hvilket).      %% neib key
synword(hvoorfor,      hvorfor).      %%  ? own
synword(hvopr,         hvor).   
synword(hvoradn,       hvordan).  
%% synword(hvorav,    og). %% TA-110617 rough  vp_conjunction, \+ np_conjunction 
synword(hvorcan,       hvordan).      %% neib 
synword(hvord�n,       hvordan).      %% TA-110111
synword(hvorda,        hvordan). 
synword(hvordab,       hvordan).      %% neib k
synword(hvordagn,      hvordan).  
synword(hvorden,       hvordan). 
synword(hvordn,        hvordan). 
synword(hvordna,       hvordan). 
synword(hvoran,        hvordan).      
synword(hvordag,       hvordan). 
synword(hvordam,       hvordan).
synword(hvordand,      hvordan).  
synword(hvordang,      hvordan). 
synword(hvordann,      hvordan). 
synword(hvordsan,      hvordan).  
synword(hvordti,       n�r).  
synword(hvore,         hvor).    
synword(hvorfoe,       hvorfor).   %%  own 
synword(hvori,         hvor).      %%  (also sp.adv)
synword(hvorofr,       hvorfor).  
synword(hvorrdan,      hvordan).
synword(hvortan,       hvordan).
synword(hvortdan,      hvordan).
synword(hvortfor,      hvorfor). 
synword(hvorvidt,      om). 
synword(hvos,          hvis). 
synword(hvorf,         hvorfor). 
synword(hvorf,         hvor).     %% actual, Repair
synword(hvorfr,        hvorfor). 
synword(hvorfan,       hvordan). 
synword(hvorfayr,      hvorfor).  
synword(hvorfer,       hvorfor). 
synword(hvorfoer,      hvorfor). 
synword(hvorfro,       hvorfor). 
synword(hvorf�,        hvorfor). 
synword(hvorf�r,       hvorfor).  
synword(hvorhen,       hvor). 
synword(hvorhenn,      hvor). 
synword(hvorifra,      hvorfra). 
synword(hvorl,         hvor). 
synword(hvorledes,     hvordan). 
synword(hvorleis,      hvordan). 
synword(hvormeget,     hva). 
synword(hvormye,       hva). 
synword(hvorn�r,       n�r). 
synword(hvorsan,       hvordan).
synword(hvorsteds,     hvor). 
synword(hvort,         hvor). 
synword(hvorti,        n�r).  
synword(hvortid,       n�r). 
%  synword(hvos,          hvis). %% NEI
%  synword(hvos,          hvor). %% NEI
synword(hvot,          hvor). 
synword(hvotfor,       hvorfor). 
synword(hvprdan,       hvordan). 
synword(hvpr,          hvor). 
synword(hvr,           hvor).
synword(hvrdan ,       hvordan). 
synword(hvrdana,       hvordan).
synword(hvrfor,        hvorfor). 
synword(hvro,          hvor). 
synword(hvrofor,       hvorfor). 
synword(hvrorfor,      hvorfor).
synword(hvs,           hvis). %% hva ? 
synword(hvsa,          hva).  %% TA-110118
synword(hvsi,          hvisa). 
synword(hvulken,       hvilken). %%  Own
synword(hvulket,       hvilket). 
synword(hvur,          hvor). 
synword(hvus,          hvis).    %% dont encourage 
synword(hvvem,         hvem). 
synword(hvvor,         hvor). 
synword(hvvordan,      hvordan). 
synword(hvvorfor,      hvorfor).  
synword(hvwm,          hvem). 
synword(hv�re,         v�re). 
synword(hv�r,          hvor). 

synword(hygelig,       hyggelig). 
synword(hyggeligst,    hyggelig). 
synword(hyppig,        ofte). 
synword(hyppige,       ofte). 
synword(hyppigere,     ofte). 
synword(hyppigst,      ofte).  
synword(hyvor,         hvor).  
synword(h�,            hva).
synword(h�h,           hva). 
synword(h�j,           hei). 
synword(h�ilt,         helt). 
synword(h�kken,        hvem). %%dial
synword(h�lsningar,    hilsen). 
synword(h�nn,          hvor). %% -hen 
synword(h�r,           her).
synword(h�rfra,        her). 
synword(h��,           hva).  
synword(h�g,           h�y). %% NN
synword(h�gaste,       st�rste). 
synword(h�stjevnd�gn,  autumnal_equinox).  %%
synword(h�stgjevnd�gn,  autumnal_equinox). %%
synword(h�tt,          hva). %% dial
synword(h�yest,        st�rst). 
synword(h�yeste,       st�rste). 
synword(h�,            hei).  
synword(h�r,           g�r).  
% synword(h�pl�s,        d�rlig). % adj
synword(h�pl�st,       umulig). 


%%� synword(i  

synword(iadg,          idag).  
synword(iaften,        ikveld). 
synword(iag,           idag). 

synword(icke,          ikke). %% Sv
synword(ig,            og). 
synword(iht,           if�lge). 
synword(ihht,          if�lge). 
synword(iherdig,       mye). 
%% synword(iherdig,       ofte). %% rough 

synword(ida,           idag). 
synword(idad,          idag). 
synword(idah,          idag).
synword(idak,          idag).  % synophon 
synword(identisk,      lik).
synword(idra,          fra). 
synword(ieg,           jeg).  
synword(iei,           jeg). 
synword(ietter,        etter). %% repair?
synword(ifra,          fra). 
synword(ifraa,         fra). 
synword(ifr�,          ifra).  
% synword(ifr�,          fra). 
synword(iflg,          if�lge). 
synword(igaar,         ig�r).
synword(igag,          idag). 
synword(igayr,         ig�r).  
synword(igjenom,       gjennom). 
synword(igjennom,      gjennom).
%% synword(igjenn,        igjen). %% splitw %% TA-110121
synword(igjen,         []).  
synword(ii,            i).   
synword(iidag,         idag).  
synword(iike,          ikke).   %%  spc
synword(ijen,          igjen). 
synword(ijenn,         igjen).
synword(ijgen,         igjen). 
synword(ikcvedl,       ikveld). 
synword(ike,           ikke).
synword(ikek,          ikke). 
synword(ikeld,         ikveld).
synword(ikje,          ikke).  
synword(ikk,           ikke).   %% own 

synword(ikkeno,        ingen). %% -> intet ->
synword(ikkenoe,       ingen). %% -> intet ->

synword(ikker,         ikke). 
synword(ikkje,         ikke).   %% NN
synword(ikkke,         ikke).   %% own 
synword(ikkw,          ikke).  
synword(ikvekld,       ikveld).
synword(ikvel,         ikveld). 
synword(ikvelde,       ikveld). %% own 
synword(ikvell,        ikveld). 
synword(ikverld,       ikveld). 
synword(ikvled,        ikveld). 
synword(il,            til).  
synword(ille,          d�rlig).
synword(ilt,           til).  

synword(imelleom,      mellom). 
synword(imellem,       mellom). 
synword(imellom,       mellom).
synword(imelom,        mellom).
synword(imoegen,       imorgen).
synword(imoergen,      imorgen).
synword(imora,         imorgen).
synword(imorge,        imorgen). 
    synword(imorges,        idag). %% Rough
synword(imorn,         imorgen). 
synword(imorgeb,       imorgen). 
synword(imorgenb,      imorgen). 
synword(imorgenp,      imorgen). 
%%  synword(imorgentidlig,      imorgen). %% Rough (splitword)
synword(imorgn,        imorgen).
synword(imorgon,       imorgen). 
synword(imoren,        imorgen). 
synword(imorra,        imorgen). 
synword(imorro,        imorgen).
synword(imponerende,   bra). 
synword(imprgen,       imorgen).
synword(imot,          mot).  
synword(im�ra,         imorgen). 
synword(im�rgen,       imorgen). 
synword(im�rn,         imorgen). 
synword(im�rra,        imorgen). 
synword(inden,         innen). 
synword(inegn,         ingen). 
synword(infgen,        ingen). 
synword(ingnen,        ingen).  
synword(ingenteng,     ingenting).     %%  dial
synword(ingnentin,     ingenting).  
synword(inje,          linje).         %% act 

synword(inkludert,     og). %%  rough

synword(inkl,          med).
synword(inklusive,     med).
synword(inklusivt,     med).
synword(innn,          inn). %% own %% TA-110707
synword(innan,         innen).         %% Dialect/Swe
%% synword(inne,          f�r).  %% Haz 
synword(innenfor,      innen).   %% actual
%%  synword(innenkl,       f�r). 
%% synword(innenklokken,  f�r).
synword(innerst,       inne).          %%  Rough
synword(innimellem,    innimellom). 
synword(innin,         innen).
synword(innj,          inn).   %% dial 
synword(innnen,        innen). 

%% synword(innom,         forbi). %%  -> prep
%% synword(innom,         ved).   
 synword(innom,        her). 

synword(innp�,         til).   
synword(inom,          innom).  
synword(inoom,         innom). synword(instilt,       innstillt). 
synword(innstilt,      innstillt).
synword(instillt,      innstillt). 
synword(innt,          inn).
synword(inte,          ikke).  
%%   synword(intelligen,    intelligent). %% ? 
synword(interessant,   bra). 
synword(internet,      internett).    %%  made noun (internet syndrome)
synword(intet,         ingen).  
synword(intil,         inntil). 
synword(inttil,        inntil).
synword(in�,           n�). %% repair 
synword(io,            i).            %%   slip
%% synword(io,            jo). 
synword(iovermorgen,   overimorgen).
synword(ioverimorgen,   overimorgen). 
synword(ipa,           p�).     %% Repair 
synword(ip�,           p�).     %% Repair 
   synword(i�p,           p�).  %% Repair
%% synword(iq,            intelligens).   %%  :-)
synword(irundt,        rundt).  
%% synword(irute,        presis).  

synword(irriterannes,  irriterende).  
%% synword(is,            i).  

%%  synword(isentrum,      sentrum).  %% ad hoc /splitword 
synword(ista,          tidligere).
synword(istad,         tidligere).
synword(iste,          []).  
synword(iste,          siste). 
%% synword(iste,          tidligere). %% 1ste (s)iste %% ?
synword(isted,         tidligere). 
synword(itidlig,       tidlig).  
synword(itil,          til).  
synword(itime,         time). 

synword(itj,           ikke).         %%  (dialect)
  %%%    synword(it,           ikke).   %% * Lang Selection

synword(itl,           til).
synword(ittj,           ikke).        %%  (dialect)
synword(iukke,         ikke).  


%%� synword(j  

synword(j,             jeg). %% j aaes veg syn in gram
                             %% Fixed   

%% synword(ja,            jeg).          %%  no effect
synword(jaa,           ja).  
synword(jaaa,          ja).     %%
synword(jada,          ja). 
synword(jadda,         ja). 
synword(jaeg,          jeg).  
synword(jaja,          ja). 
synword(jajaja,        ja). 
%% synword(jag,           jeg). %% splitword         %% ( swedish)
synword(jaha,          ja).  
synword(jai,           jeg).  
synword(jalla,         hei).        %%  ?
synword(janur,         januar).  
synword(jaok,          ok).     %% ja, ok
synword(jau,           ja). 
synword(javel,         ja).     %% bra). --> du m� oppgi... 
synword(javell,        bra). 
synword(javvel,        bra).  
synword(jav�l,         bra). 
synword(jav�ll,        bra).  
% synword(jass�,         hei).         %%(?)
% synword(jas�,          hei). 

synword(jdg,           jeg).  
synword(je,            jeg).           %%  ( dialect )
synword(jeb,           jeg).           %% neib k 
synword(jed,           jeg).   
synword(jeeg,          jeg).  
synword(jef,           jeg).    %%  neik
synword(jegb,          jeg). 
synword(jefg,          jeg).  
synword(jegf,          jeg).  
synword(jegg,          jeg).  
synword(jegh,          jeg).  
synword(jegr,          jeg). 
synword(jegs,          jeg).    % ... skulle 
synword(jegt,          jeg). 
synword(jeh,           jeg). 
synword(jehg,          jeg).  
synword(jei,           jeg). 
synword(jej,           jeg). 
synword(jem,           hjem). 
synword(jer,           jeg).
synword(jess,          ja). 
synword(jet,           jeg).  
synword(jetg,          jeg). 
synword(jev,           jeg). 
synword(jevnlig,       ofte). 
synword(jewg,          jeg). 
synword(jg,            jeg).  
synword(jge,           jeg). 
synword(jgeg,          jeg). 
synword(jhar,          har).  
synword(jikk,          gikk). 
synword(jjeg,          jeg). 
synword(jk,            kl).  %% dbl slip 
synword(jkan,          kan). %% own
synword(jkeg,          jeg). 
synword(jledag,        juledag). 
% synword(jl,            klokken).     %% kl ?
synword(jn�r,          n�r).  

synword(jo,            ja) :- user:myflags(busterflag,true). %% Jo

synword(joa,           ja). 
%% synword(jo,            []).  %% bussen g�r jo// redundant 
synword(joho,          ja).            %% \+ john
synword(johoi,         hei). 
synword(jojo,          ja). 
synword(joda,          ja).  
synword(jolder,        holder). 
synword(jomme,         komme).  
synword(jommer,        kommer).        %%  own
synword(joo,           ja). 
synword(jooo,          ja).            %%
synword(jreg,          jeg). 
synword(jrg,           jeg). 
synword(jva,           hva).           %% own slip
synword(jvem,          hvem).          %% own
synword(jvilken,       hvilken).       %% own
synword(jvor,          hvor).  
synword(jvorfor,       hvorfor).  
synword(j�,            jeg). 
synword(j�g,           jeg).  
synword(j�r,           gj�re).         %% dial      
synword(j�r,           n�r).           %% neib k

synword(jonsok,        midsummer_day). 
synword(jonsokaften,   midsummer_eve).
%% synword(ju,            juni). %% haz jul?
synword(juk,           jul). 

synword(juaften,       christmas_eve). %%  own
synword(julaften,      christmas_eve). 
synword(julaftenen,    christmas_eve). %%  ( name, not noun)
synword(juleaften,     christmas_eve).
synword(juleaftenen,   christmas_eve).

synword(lulaften,      christmas_eve).
synword(luleaften,     christmas_eve).

synword(juldag,        christmas_day). 
synword(juldagen,      christmas_day). 
synword(juleda,        christmas_day). 
synword(juledad,       christmas_day).
synword(juledag,       christmas_day).  
synword(juledags,      christmas_day). 
synword(juledagen,     christmas_day). 

synword(julekvelden,   christmas_eve). 

%% synword(jul,           christmas). 
%% synword(juletiden,     christmas).  %% rough
%% synword(jula,          christmas).  %% roughly
%% synword(julen,         christmas).  %% rough

synword(jweg,          jeg). 
synword(jwg,           jeg). 

%%� synword(k  

synword(kbvart,        kvart). 
synword(kj,            klokken).
synword(kjan,          kan).
synword(kja�r,         kj�r).  %% kjør
synword(kja�re,        kj�re).
synword(kja�pesenter,  kj�pesenter). %% TA-110325
synword(kje,           ikke).
synword(kjekt,         bra). 
%% synword(kjipt,         d�rlig).   %% 
synword(kju�rer,       kj�rer).   %%
synword(kj�re,         kj�re).    %%  .. gud
synword(kj�rer,        kj�rer).   %% 


%%� synword(l 

synword(lbe,           ble).      %% ??
synword(likeledes,     redundant0). %% TA-110411
synword(lng,           lang). 
synword(lurt,          bra). 
synword(lveien,        veien). %% ?
synword(lv�re,         v�re).  %% 
synword(lysst,         lyst). 
synword(lyt,           m�).  
synword(l�rerere,      l�rere). %% own 

synword('l��rdag',       l�rdag). %% l��rdag? 
synword('s��ndag',       s�ndag). %%

synword(srdag,       l�rdag).

synword(l�,            l�rdag). 

synword(l�dagsrute,    l�rdagsrute). 
synword(l�dagsruter,   l�rdagsruter).
synword(l�sdagsrute,   l�rdagsrute).
synword(l�sdagsruter,  l�rdagsruter).
%% synword(k,             klokken).  %%    til k jonssons vei %% Haz

synword(ka,            hva). 
%% synword(ka,            kan).  %% ka e 2 2 
synword(kaem,          hvem). 
synword(kab,           kan).   %% own 
synword(kaffor,        hvorfor).       %% ?
synword(kaffor,        hvilken).       %% kva for ?
synword(kal,           skal). 

synword(kalles,        hete).  %% kan kalles %% verb_form
synword(kalles,        heter).

synword(kallt,         kalt).          %% Own
synword(kain,          kan).           %% Dial
synword(kainn,         kan).           %% Dial
synword(kanb,          kan).           %% Neib k
synword(kand,          kan).
synword(kang,          lang).          %%  own
synword(kanj,          kan).           %% dial

synword(kankjse,       kanskje).  %% AK-110624
synword(kansje,        kanskje).  %% redun %% TA-110624
synword(kansje,        kanskje).  %%
synword(kanksje,       kanskje).  %%


synword(kann,          kan).  

% synword(kan,           snakker).     %% Too hazardous

%% synword(kan,           vet).  %% Kan syndrome


%  synword(kan,           vil).  
%  kan -> vil -> go, ==> kan -> go *

% hva kan du   = vet
% hva kan du fortelle = vil
% kan du noe om flybuss   = vet
% kan du si noe om flybuss = vil

synword(kar,           hvilken). %% Dial
synword(kas,           hvordan). %% Dial (?)
synword(kass,          hvordan). %% Dial (?) 
synword(katastrofalt,  d�rlig). 
synword(kati,          n�r). %%  Dial.
synword(katid,         n�r). %%  Dial.
synword(katti,         n�r). %%  Dial. 
synword(kavrt,         kvart).
synword(keffer,        hvorfor). %% Dial? 
synword(keffor,        hvorfor). 
synword(keg,           jeg). 
synword(kellom,        mellom).
%% synword(ken,           kan).  %% Hazardous ??? 
synword(ke,            hva). 
synword(kem,           hvem). 
synword(ken,           hvem). 
synword(ken,           hvor).
synword(kenn,          hvem). 
synword(kerr,          hvor).    %%  Dial ?
synword(kes,           hvordan). 
synword(kess,          hvordan). 
synword(kest,          hvordan).
synword(keti,          n�r).     %%  Dial. 
synword(kevld,         kveld).  
synword(keveld,        kveld). 
synword(khva,          hva).     %% own
synword(khvordan,      hvordan).
synword(kin,           hvem).    %% Dial 
synword(kinje,         linje).   %% owm sp 
synword(kinn,          hvem).    %% Dial 
synword(kinn,          kino). 

synword(kinoan,        kinoene).
synword(kinon,         kinoene).

synword(kjapp,         fort). 
synword(kjappeste,     beste).  
synword(kjapt,         fort).  
synword(kja�re,        kj�re).      %% kjøre  
synword(kja�rer,       kj�rer). 
synword(kjedeli,       kjedelig).  
synword(kjederlig,     kjedelig). 
synword(kjedli,        kjedelig).  
   synword(kjip,         kjedelig). 
   synword(kjipt,        kjedelig). 
synword(kjekk,         hyggelig).  
synword(kjekk,         god). 
synword(kjem,          kommer).  %% NN
synword(kjeme,         kommer). %% Dial 
synword(kjemm,         kommer).
synword(kjempestor,    stor).
synword(kjempefint,    bra).   %% closure fint 
synword(kjempeflink,   flink). 
synword(kjolkken,      klokken). 
synword(kjomme,        komme). 
synword(kjoere,        kj�re). 
synword(kjorer,        kj�rer).  
synword(kjoerer,       kj�rer).
synword(kjorte,        kj�rte). 
synword(kjoerte,       kj�rte).
synword(kjort,         kj�rt). 
synword(kjoert,        kj�rt). 
synword(kjr�e,         kj�re).  
synword(kjr�er,        kj�rer).
synword(kj�m,          kommer).
synword(kj�mm,         kommer).  %%  Dial
synword(kj�erer,       kj�rer).
synword(kj�m,          kommer).  %%  Dial
synword(kj�me,         kommer).  %% Dial 
sunword(kj�peseter,    kj�pesenter).
synword(kj�pre,        kj�pe). 
synword(kj�r,          kj�rer). %% Dial Haz? 
synword(kj�rere,       kj�rer). 
synword(kj�rerer,      kj�rer).  
synword(kj�rerr,       kj�rer). 
synword(kj�rers,       kj�res). 
synword(kj�yrde,       kj�rte). 
synword(kj�yrd,        kj�rt).   %% NN
synword(kk,            kl).      %% klokken?
synword(kkan,          kan). 
synword(kke,           ikke). 
synword(kkj�re,        kj�re). 
synword(kkj�rer,       kj�rer).
synword(klareer,       klarer). 
synword(kle,           klokken). %%  (?)
synword(klem,          adj�). %  %%  ? 

synword(kkl,           klokken). 
synword(kklk,          klokken). 
synword(kkoken,        klokken). 
synword(kkokken,       klokken).
synword(kkunne,        kunne).   %% act  TA-110329
synword(kl,            klokken). 
synword(kla,           klokken). 
synword(klakka,        klokken). 
synword(klaokka,       klokken).
synword(klikken,       klokken). %% \+ kirken
synword(klk,           klokken). 
synword(klken,         klokken).
synword(klkl,          klokken). 
synword(kll,           klokken). 
synword(klkoka,        klokken). 
synword(klkokka,       klokken).
synword(klkoken,       klokken).
synword(klkokken,      klokken). 
synword(klkka,         klokken). 
synword(klkke,         klokke). 
synword(klkken,        klokken). 
synword(klkkka,        klokken).
synword(kllokka,       klokken). 
synword(kllokken,      klokken). 


% OBS 
% g�r  bussen  kl8       buss kl8 = buss 8 #

%% kl14.00 = 1400 not 1400 , 0000

% k18 = kl 18 ...

%%   buss kl21 = buss 21 ### 

synword(kl1,           0100). 
synword(kl2,           0200). 
synword(kl3,           0300). 
synword(kl4,           0400). 
synword(kl5,           0500). 
synword(kl6,           0600). 
synword(kl7,           0700). 
synword(kl8,           0800). 
synword(kl9,           0900). 

synword(kl01,           0100). 
synword(kl02,           0200). 
synword(kl03,           0300). 
synword(kl04,           0400). 
synword(kl05,           0500). 
synword(kl06,           0600). 
synword(kl07,           0700). 
synword(kl08,           0800). 
synword(kl09,           0900). 


synword(kl10,          1000). 
synword(kl11,          1100). 
synword(kl12,          1200). 
synword(kl13,          1300). 
synword(kl14,          1400). 
synword(kl15,          1500).
synword(kl16,          1600). 
synword(kl17,          1700).
synword(kl18,          1800). 
synword(kl19,          1900).
synword(kl20,          2000). 
synword(kl21,          2100).
synword(kl22,          2200).
synword(kl23,          2300).
synword(kl24,          2400). %%


synword(k10,          10). %% etc  k10.30


%% synword(kl1000,       1000). %% ETC unnec 


synword(klo,           klokken).  
synword(kloekn,        klokken). 
synword(kloakka,       klokken).  %%  own spc
synword(klocka,        klokken). 
synword(klockan,       klokken). 
synword(klocken,       klokken).
synword(kloikken,      klokken). 
synword(klok,          klokken). 
synword(klokaa,        klokken). 
synword(kloka,         klokken). 
synword(klokak,        klokken).

synword(klokekn,       klokken). 
synword(kloken,        klokken).      %%  ( spellch)
synword(klokeen,       klokken). 

synword(klokkaen,      klokken).
synword(klokkaa,       klokken). 
synword(klokkal,       klokken). 
synword(klokkan,       klokken).      %%  ( swedicism )
synword(klokkat,       klokken).  

synword(klokkebn,      klokken). 
synword(klokkek,       klokken). 
synword(klokkel,       klokken). 
synword(klokkena,      klokken). 
synword(klokkenh,      klokken).
%% synword(klokkentolv,  1200).    %% etc unnec
synword(klokker,       klokken).  
synword(klokkga,       klokken).  
synword(klokkja,       klokken). 
synword(klokkjen,      klokken).    %% dial?
%%  synword(klokkahalv,    halv). %% klokken).    %% (split)

synword(klokkem,       klokken). 
synword(klokkenn,      klokken). 
synword(klokkka,       klokken).  
synword(klokkken,      klokken).
synword(klokkkka,      klokken). 
synword(klokkkken,     klokken). 
synword(klokklen,      klokken). 
synword(klokkn,        klokken).  
synword(klokko,        klokken).  
synword(klokkoen,      klokken). 
synword(klokkon,       klokken).  
synword(klokkr,        klokken). 
synword(klokkrn,       klokken). 
synword(klokkw,        klokken). 
synword(klokkwn,       klokken).  
synword(klokk�,        klokken). 
synword(klokla,        klokken). 
synword(kloklka,       klokken). 
synword(klolla,        klokka).  
synword(klollen,       klokken).
synword(klomme,        komme).       %% slip 
synword(klooka,        klokken). 
synword(klookka,       klokken).  
synword(klooken,       klokken). 
synword(klpkka,        klokken).  
synword(klpkken,       klokken).
synword(klpokka,       klokken). 
synword(klpokken,      klokken).
synword(klr,           klokken). 
synword(kl�kka,        klokken).
synword(kl�kken,       klokken).  
% synword(km,            kilometer). %% splitword
synword(kmme,          komme).  
synword(kmmer,         kommer).  
synword(kn,            kan). 
synword(kna,           hva). %% actual 
synword(knapt,         ikke).   
%% synword(ko,            kor).  %%  ?
synword(ko,            klokken).
synword(kofer,         hvorfor). 
synword(koffer,        hvorfor). 
synword(koffor,        hvorfor). 
synword(koff�r,        hvorfor).  
synword(koff�r,        hvorfor).  
synword(kofo,          hvorfor). 
synword(kofor,         hvorfor). 
synword(kof�r,         hvorfor). %% TA-101221
synword(kof�r,         hvorfor). %% TA-101123
synword(kokke,         klokken). 
synword(kokken,        klokken). 
synword(kokka,         klokken). 
synword(kol,           klokken). 
synword(kolega,        kollega). 
synword(koles,         hvordan). 
synword(kolkka,        klokken). 
synword(kolkken,       klokken).
synword(kolla,         klokken). %% ?
synword(kollen,        klokken). %% ?
synword(kolles,        hvordan).      %%  (dial.)
synword(kolokka,       klokken). 
synword(kolokken,      klokken).
synword(koma,          komme). 
synword(komee,         komme).  
synword(komemr,        kommer).
synword(komen,         kommet). 
synword(kome,          komme). 
synword(komer,         kommer).       %% (dialect?)
synword(komm,          komme).        %% dialect
synword(komma,         komme). 
synword(kommaer,       kommer).       %%  own
synword(kommande,      neste).        %% NN
synword(kommber,       kommer). 
synword(kommee,        komme).  
synword(kommeer,       kommer). 
%%  synword(kommemeg,      komme).     
synword(kommen,        kommet). 
synword(kommende,      neste).  
synword(kommerj,       kommer). %% kommerj eg
synword(kommert,       kommer).       %% kommert il
synword(kommes,        kommer). 
synword(kommew,        kommer).       %%  neik
synword(kommf,         komme). 
synword(kommme,        komme). 
synword(kommmer,       kommer).
synword(kommr,         kommer).
synword(kommrt,        kommer). %% own 
synword(komprimering,  tekst).  %% rough 
synword(komt,          kommet). 
synword(konsekvent,    alltid).
synword(kontonr,       kontonummer). 
synword(kor,           hvor). 
synword(kores,         hvordan). %%  ?
synword(korenspoderer, korresponderer).
synword(korrenspoderer, korresponderer).

synword(korespndanse,  korrespondanse).  
synword(korrespondanse,korrespondanse).  
synword(korespondanse, korrespondanse). 
synword(korigert,      korrigert). %%  adj/vpart 
synword(korrespodanse, korrespondanse). 
synword(korespodanse,  korrespondanse). 
synword(korrspondanse, korrespondanse). 

synword(korrospondere, korrespondere).  
synword(korrosponderer,korresponderer).

synword(kordan,        hvordan). 
synword(korfor,        hvorfor).
synword(korlei,        hvor). %% hvordan?
synword(korleis,       hvordan). 
synword(korles,        hvordan). 
synword(korr,          hvor).         %%  dial
synword(kors,          hvordan). 
synword(korsen,        hvordan). 
synword(korsn,         hvordan).      %%  // Korsen hpl
synword(korrsn,        hvordan).  
%% synword(kortere,       kort).         %% Rough `\+card 
synword(kortes,        kort).  
synword(kortest,       snarest). 
synword(korti,         n�r).          %% dialekt
synword(kortid,        n�r).          %% dialekt 
synword(kos,           hvordan).      %% hvordan? Kos buss // actual
%% synword(kos,           adj�).   
synword(koz,           adj�).         %% jargon 
synword(kozn,          hvordan).  
synword(kosjn,         hvordan). 
synword(kosjen,        hvordan). 
synword(kosn,          hvordan).  
synword(koss,          hvordan). 
synword(kosse,         hvordan).  
synword(kosen,         hvilken).   %% kosen buss ... // inconseq
synword(kossen,        hvordan).   %% hvilken ?
synword(kossn,         hvordan).   %% 
synword(koti,          n�r).       %%  Dial
synword(kpmmer,        kommer).  
synword(kr,            kroner).
synword(kra,           fra). 
synword(kraftig,       veldig).
  
% synword(kristihimmelfartsdag,kristi_himmelfartsdag). 
synword(kristihimmelfartsdag,ascension_day). %% NB English name
synword(krysset,       veien). %% rough  ..mellom A og B

synword(ktil,          til).
synword(kun,           bare).    %%  \+ noisew
synword(kunn,          bare).  %% kunne?
%% synword(kunne,         kan).     % past vil du kunne
synword(kunstlig,      kunstig).
synword(kv,            kveld). 
synword(kva,           hva). 
 %% synword(kva,           hvilken). %%  (kva buss) Veit du kva klokka er 
synword(kvaerter,      kvarter). 
synword(kvafor,        hvilken).
synword(kvbart,        kvart). 
synword(kvalitetsikring, kvalitetssikring).  %%  own  ss
synword(kvalt,         kvart). 
synword(kvar,          hvor). 
synword(kvar,          kvart). %% p� 6 
synword(kvar,          hver).  %% NN 
synword(kvarhen,       hvor). 
synword(kve,           hva).
synword(kveil,         kveld). 
synword(kveill,        kveld). 
synword(kvekd,         kveld). 
synword(kvel,          kveld). 
synword(kvelde,        kveld).  
synword(kveldeb,       kvelden). 
synword(kveled,        kveld). 
synword(kvelen,        kvelden). %%  own sp  
synword(kvelf,         kveld).   %%  own spc
synword(kvelv,         kveld).  
synword(kvem,          hvem). 
synword(kven,          hvem). 
synword(kver,          hver). %% own
synword(kvert,         kvart).
synword(kvifor,        hvorfor). 
synword(kvikt,         n�). 
synword(kvikkt,        n�).  
synword(kvilke,        hvilke). 
synword(kvilken,       hvilken). 
synword(kvilket,       hvilket). 
synword(kvisleis,      hvordan).  
synword(kvissleis,     hvordan). 
synword(kvit,          hvit). 
synword(kvld,          kveld). 
synword(kvled,         kveld). 
synword(kvor,          hvor).  
synword(kvordan,       hvordan).
synword(kv�ll,         kveld). 
synword(kv�r,          hver). 

synword(kystekspressen,hurtigruta). 

synword(k�,            hva). 
synword(k�inn,         kan).  %% Dial 
synword(k�m,           hvem). 
synword(k�r,           hvor). %% dial
synword(k�,            kl).  %%  haz lang k�..
synword(k�ffer,        hvorfor). 
synword(k�yrde,        kj�rte). 
synword(k�yrd,         kj�rt). 

synword(k�,            hva). 
synword(k�r,           g�r).     %% own spell
synword(k�r,           hvor).    %%  ???
synword(k�rr,          hvor).    %%  ???
synword(k�sen,         hvordan).
synword(k�ss,          hvordan). 
synword(k�ssen,        hvordan). 
synword(k�ste,         koste).  


%%� synword(l 

synword(l1,            11).  % L1

synword(lafer,lager).  %% own 
synword(lagett,        laget). 
synword(lagn,          lang).   
%% synword(lagt,          langt).  %% lagt deg=lang tuc
%% synword(lagt,          laget). 

synword(lalv,          halv).  
synword(lan,           lang).  
synword(lanf,          lang).  %  own

%% synword(land,          lang).   %%  ??
synword(lande,         landet). %% Dialect
synword(langet,        langt). 

synword(langfredag,    good_friday).
   synword(lengfredag,    good_friday).
   synword(langfrdag,    good_friday).  


synword(langtfra,      ikke).   %% langt fra ?
synword(latterlig,     veldig).

synword(leg,           jeg).  
synword(leget,         laget).
synword(legste,        lengste). 
synword(lemge,         lenge). 
synword(lenger,        lang). %% rough ?????
%% synword(lengre,        lang). %% lengre adj / lenger adv 
    %% for lengre reiser \+ altfor lange reiser
synword(lengere,       lang). 
synword(leseren,       kortleseren). %% avoid leser(noun)
synword(letter,        etter). %% dragvol letter ??? 

%% synword(lettere,         []).  %%  (?) lettere forvirret
%% synword(lettere,       litt).   %% .. komisk %%  lettere enn 


synword(leva,          leve).   
synword(levva,         leve).  %%  dial
synword(l�nge,         lenge). 
synword(l�nt,          fint). 
synword(l�va,          leve). 
synword(l�vva,         leve). 
synword(liggeer,       ligger).    %%  own sp    
synword(lingnende,     lignende). 
synword(linhe,         linje).     %% own sp 
synword(linle,         linje). 
synword(lije,          linje). 
synword(lika,          liker).  
synword(likar,         bra).       %%  (trans. closure) (Det g�r likar no)
synword(likeer,        liker). 
synword(likevell,      likevel).  
synword(likt,          samme). %% likt navn 
synword(lil,           til).  
synword(lilje,         linje).
%%%% synword(lille,         liten).  %% lille julaften
synword(lillejulaften, little_christmas_eve). %% English internal
synword(lilnje,        rute). 
synword(linj,          rute). 
synword(linjd,         rute).
synword(linjr,         rute). 
synword(linjenr,       linjenummer).

%% synword(linje1,        trikken). %% NB NB Only Trondh.

synword(lit,           til ). 
synword(lit,           noe ).   %% DK
synword(litn,          liten).  
synword(litt,          noe ). 
%%% synword(litt,          []).  %%  litt dum| jeg testet litt %% TA-110228
synword(litte,         lite).   %% ? dial
synword(littover,      over). 
synword(bittelitt,     noe ).   %%  ? Facetious
%% synword(lite,          ikke).   %% du er lite glup %%  forst�r lite
synword(live,          livet).  %% Norwagism
synword(livvet,        livet). 


synword(ljeg,          jeg).    %% e.g. ska ljeg 
synword(ljnie,         linje). 

synword(lk,            klokken). 
synword(lkl,           klokken). 
synword(lkokka,        klokken). 
synword(lkokken,       klokken).
synword(lkomme,        komme). 
synword(lokka,         klokken). 
synword(lokken,        klokken). %% 
%% synword(long,kong). %% destroys lang sel.ection 
synword(lov,           mulig). 
synword(lovlig,        mulig).  
synword(lovva,         love). 
synword(lovv�,         love). 
synword(lsng,          lang).  
synword(lstre,         �stre).   %% neib 
synword(lune,          hum�r).
%%%%synword(lunch,         1200). %%NO, 1200 -> 2400 if too late
%%%%synword(lunsh,         1200).  
%%%%synword(lunsj,         1200).
synword(lurest,        beste). 
synword(lureste,       beste). 

synword(l�gg,          legg).  
synword(l�get,         situasjonen). 
synword(l�ng,          lenge). 
synword(l�ngte,        lengter).      %% ( :-)
synword(l�ng,          lang).
synword(l�nga,         lange). %% SWE
synword(l�v,           lov). 
synword(l�v,           mulig). %% nec 

%%� synword(m 

synword(m,             med). 
synword('ma|',         m�).
synword(maangw,        mange). 
synword(maar,          m�). %% act 
synword(mae,           m�).
synword(mag,           meg).  
%% synword(man,           mann). %%  Haz
synword(mang,          mange).                     %% (dialect)
synword(mangen,        mange). 
synword(manger,        mange).  
synword(maskine,       maskin).    %%  DK
synword(masse,         mye). 
synword(ma,            m�).  
synword(maa,           m�). 
synword(maeg,          meg).   %% own sp
synword(mage,          mange). 
synword(maile,         sende). 
%% synword(maj,           mai).   %%  no E:may
synword(makan,         noe).   %%  :-) 
synword(maken,         noe).   %% 
synword(mamge,         mange). 
synword(mane,          mange). 
synword(mangen,        mange). 
synword(mangt,         mye). 
synword(manhe,         mange). 
synword(may,           m�).  
synword(maynedskort,   m�nedskort). 
synword(ma�te,         m�te). 
synword(ma�,           m�). 
synword(md,            med).
synword(mde,           med).  
synword(mded,          med).  

synword(me,            med).          %% Dialect 
synword(me,            meg).    % dial
%% synword(me,            vi).  %   %% NN
%% synword(me,            m�).  %% �-tr�bbel %% Hazardous

synword(medd,          med). 
synword(mede,          med). 
synword(medio,         i).   %% medio januar 
synword(medregnet,     med).  
synword(mef,           meg). %%  own 
synword(mef,           med). %% 
%% synword(meg,           jeg).    %% Needs Case difference
synword(meget,         veldig). 
synword(megh,          meg).
synword(meh,           meg). %% own 
synword(mei,           meg).
synword(meir,          mer). 
synword(meiningo,      meningen). %% Dial :-) 
synword(meining�,      meningen). %%
synword(mej,           meg). 
synword(meed,          med). 
synword(meeg,          meg). 
synword(mektig,        meget).        %%  :-) mektig imponert
synword(mekkom,        mellom).       %%  neib
synword(mell,          mellom). 
synword(mellan,        mellom).       %%  (Swed)
synword(mellem,        mellom).       %%  (Dan)
synword(mellen,        mellom). 
synword(melleom,       mellom). 
synword(mellim,        mellom). 
synword(melllom,       mellom). 
synword(mellm,         mellom).        %%  own spell
synword(mello,         mellom). 
synword(mellok,        mellom). 
synword(mellon,        mellom). 
synword(mellomhvis,    hvis).         %% ?
synword(mellomk,       mellom). 
synword(mellomm,       mellom). 
synword(mell�m,        mellom).  
synword(melom,         mellom).
synword(melomm,        mellom). 
synword(meloom,        mellom). 
synword(meningern,     meningen).  
synword(menigen,       meningen).  
synword(meningn,       meningen). 
synword(met,           med). 
%% synword(metan,         gass). 
synword(me�,           m�).  
synword(mfra,          fra). 
synword(mf�r,          f�r).  %% ? sentru mf�r
synword(mhp,           for). %% alt er s� usikkert mhp Team
synword(mi,            min).          %% (dialect)
synword(mib,           min).  %% beib
synword(mida,          middag). 
synword(midda,         middag).   
synword(middagstid,    middag). 
synword(middagstiden,  middag). 
synword(middagstider,  middag). 
synword(middels,       vanlig). 
synword(midel,         vanlig).   %% rough
synword(middel,        vanlig).   %% 
synword(middnatt,      midnatt). 
synword(middga,        middag).  
synword(midtnatt,      midnatt). 
synword(midtsommer,    sommertid).
%% synword(mig,           jeg).  %% splitword  % trans clos.        %%  (Swed,Dan)
synword(milig,         mulig).  %%  spc
synword(millom,        mellom).
synword(min,           minutter). 
     %% OOPS  jeg er st�rre enn min mor
     %% bussen g�r om 5 min
synword(miorgen,       morgen). %%  own
synword(mirgen,        morgen). %% TA-110328
synword(mit,           mitt). 
synword(miutt,         minutt).    
synword(miutter,       minutter).
%% synword(mindre,        ikke). %% Haz, mindre detaljer 
                                 %%  ( mindre klok )
synword(minimalt,      minst). 
synword(mjeg,          jeg).  
synword(mklokken,      klokken). 
synword(mllom,         mellom).        %%  own spell
synword(mlm,           mellom). 
synword(mndag,         mandag). %% TA-110214 own
synword(mna,           man). 
synword(mne,           men). 
synword(mnt,           mot). %%  m�t
synword(mofrgen,       morgen).  %% TA-110704 own, dbl neib
%% synword(mo,            m�). %% collides Mo (i Rana) 
synword(moegen,        morgen).  
synword(moegenbuss,    morgenbuss). 
synword(mogen,         morgen). 
synword(moglen,        mulig). 
synword(mogren,        morgen). 
synword(mogrenen,      morgenen). 
synword(mollom,        mellom).   
synword(momt,          mot). %% sp 
synword(monge,         mange).
synword(moot,          mot). 
synword(mor,           mot).         %% ??? 
synword(mora,          imorgen).     %% ikke morgen
synword(moragen,       morgen).   
synword(moregen,       morgen).  
synword(moregn,        morgen). 
synword(moren,         morgen).      %% -- mother ? // hva heter moren din*
synword(morga,         morgen). 
synword(morgoen,       morgen). %% TA-110214
synword(morg�,         morgen).  
synword(morgan,        morgen).  
synword(morge,         morgen). 
synword(morgeb,        morgen).      %% neib 
synword(morgebeb,      morgen).      %% morgenen %% dbl neib 
synword(morgeben,      morgen).  %% own
synword(morgebuss,     morgenbuss). 
synword(morgeen,       morgen).  
synword(morgem,        morgen).  
synword(morgenb,       morgen). 
synword(morgenm,       morgen).  
synword(morgene,       morgenen). 
synword(morgenene,     morgenen). 
%%  synword(morgenkveld,   morgen).      %%  (Rough)
synword(morgent,       morgen). 
synword(morgentidlig,  morgen).      %%  (Rough)
synword(morgentidelig, morgen). 
synword(morgentilig,   morgen).  
synword(morget,        morgen).   
synword(morggen,       morgen).   
synword(morgi,         morgen). 
synword(morgne,        morgen). 
synword(morgnene,      morgen).  
synword(morgningen,    morgenen).  
synword(morgo,         morgen).
synword(morgwen,       morgen).
synword(morgwn,        morgen). 
synword(morhen,        morgen). 
synword(morn,          hei). 

synword(morna,         adj�). 
synword(morosamt,      morsomt). 
synword(morosomt,      morsomt). 
synword(morra,         imorgen). %% not morra -> morgen -> gomorgen
synword(morran,        morgenen). 
synword(morratidlig,   morgen).      %%  (Rough) 
synword(morratilig,    morgen).      %% 
synword(morrgen,       morgen).  
synword(morro,         moro). 
synword(morrra,        morgen). %% ?

synword(mote,          m�te).   
synword(mote,          mot).

synword(motgen,        morgen). 
synword(mott,          mot). 
synword(mottat,        mottatt).
synword(mh,            hilsen).  
synword(mht,           til).       
synword(mvh,           hilsen).   
synword(my,            mye). 
synword(my,            m�). 
%%% synword(mye,           ting).     %%  Techn.
synword(mycket,        meget).  %% S
synword(myr,           mye). %% gen place ? %% act
synword(mykje,         meget). 
synword(mytji,         meget).
synword(m�,            meg).          %%  (NB, not jeg  only use in reciproc )
synword(m�,            m�).           %%  Haz ? (Doesnt help)
synword(m�g,           meg). 
synword(m�rmeste,      n�rmeste).
synword(m�st,          mest). 
synword(maanedskort,   m�nedskort).
synword(m�endskort,    m�nedskort).  
synword(m�ndeskort,    m�nedskort).   %%  Sp.
synword(m�nedkort,     m�nedskort). 
synword(m�nedskotr,    m�nedskort).   %% Sp 
synword(m�nedspris,    m�nedskort).   %% Rough
synword(m�neskort,     m�nedskort).  
synword(m�a,           m�). 
synword(m�n,           mandag).   %% Sv 
synword(m�nga,         mange).    %% SV
synword(m�nge,         mange).    %% 
synword(m�p,           m�).       %% neib k


synword(m�r,           m�).  
synword(m�ra,          morgen).   
synword(m�rn,          hei).
synword(m�ro,          morgen).  
synword(m�rra,         morgen).  %% dial
synword(m�rr�,         morgen). 
synword(m�rres,        morges).  
synword(m�rrest,       morges). 
synword(m�r�,          morgen).  %% dial 
synword(m�ste,         m�).      %% Sv 
%% synword(m�te,          m�te).        %%  !  
%% synword(m�te,          m�).          %% 
synword(m�tt,          m�). 
synword(m�tte,         m�).          %% Confusion ???
synword(m��,           m�).  
%% synword(mellomjula,    christmas).     %% roughly 

synword(mena,          mene).  
synword(menge,         mange). 
synword(meningsfullt,  bra).
synword(meningn,       meningen). 
synword(menner,        menn).
synword(menneskan,     menneskene). %% dial 
synword(mere,          mer).  
synword(mes,           med).   %% own
synword(mesd,          med).  
synword(meste,         neste).         %% ?
% synword(mester,         neste).        %% ??

synword(mg,            meg). 
synword(mg�,           g�). 
synword(mg�r,          g�r).   %% blank  neib m
synword(mleeom,        mellom). 
synword(mmp,           m�).            %% ??
synword(mnd,           m�ned). 
synword(mneste,        neste). 
synword(mp,            m�).            %%  nb key
synword(mpt,           mot). %% own 
synword(mp�,           m�).  %% actual
synword(mr,            nr). 
synword(mrd,           med). 
synword(mrg,           morgen).
synword(mrgn,          morgen).
synword(mrogen,        morgen). 
synword(mt,            mot).  
synword(mtil,          mot). 
synword(mugleg,        mulig).  
synword(muglig,        mulig).      
synword(muleg,         mulig).           
synword(mulegheit,     mulighet).  
synword(muli,          mulig). 
synword(mulighe,       mulighet). 
synword(muloig,        mulig). 
synword(murlig,        mulig).         %% TA-110331
synword(m�jlig,        mulig).         %% (SWE)
synword(m�jligt,       mulig).         %% (SWE)
synword(m�t,           mot).     
synword(m�j,           m�).            %%   m�j eg
synword(m�l,           m�). 
synword(m�r,           n�r). 
synword(m�rgen,        morgen). 
synword(m�rran,        morgenen). 
synword(m�y,           m�).            %%  må 

%%� synword(n  

synword(n,             neste).    %% sms 
synword(n,             n�r).      %% sms 
synword('na|r',        n�r).      %% TA-100829 
synword('na|ste',      neste). 
synword('na|rheten',   n�rheten). %% TA-101001
synword('na|rmeste',   n�rmeste). %% TA-100829 
synword(na,            n�). 
synword(nai,           nei).  
synword(naerheten,     n�rheten). 
synword(naermest,      neste). 
synword(naermeste,     n�rmeste).  
synword(naermste,      n�rmeste).  
synword(naert,         n�r).  %% n�r, act
synword(naeste,        neste). 
synword(nalle,         alle). 
synword(namge,         mange).  
synword(nar,           n�r). 
synword(narmest,       n�rmest).   
synword('na|rmest',       n�rmest). 
synword(narmeste,      n�rmeste). 
%% synword(narr,          natt).  %% TA-110609
synword(narsle,        varsle).  
synword(naubuss,       nattbuss).
synword(navne,         navn).     %% Dan
synword(nay,           n�).       %% nå
synword(nayr,          n�r).      %%  når also splitword
synword(na�,           n�). 
synword(na�,           n�r).      %%  actual
synword(na�r,          n�r). 
synword(naer,          n�r).      %% Svensk (aktuell) 
synword(naer,          n�r). 

synword(nasjonaldagen, may17).   
synword(naste,         neste).  
synword(nat,           natt).  
synword(natbtbuss,     nattbuss). 
synword(natta,         godnatt). 
synword(nattb,         nattbuss). 
synword(nattbbuss,     nattbuss).  
synword(nattbiss,      nattbuss). 
synword(nattbs,        nattbuss). 
synword(nattbusd,      nattbuss).
synword(nattbuseen,    nattbussen).
synword(nattbussan,    nattbussene). 
synword(nattbussbuss,  nattbuss). 
synword(nattbusse,     nattbussene). 
synword(nattbussem,    nattbussen). 
synword(nattbussenen,  nattbussen). 
synword(nattbussenene, nattbussene). 
synword(nattbussn,     nattbussen).  
synword(nattbusr,      nattbusser). 
synword(nattbussrn,    nattbussen). %% TA-110815
synword(nattbussr,     nattbusser). 
synword(nattbyss,      nattbuss). 
synword(nattis,        natten).  
synword(nattubuss,     nattbuss).  
synword(nattubussen,   nattbussen).

synword(naturlignok,   naturligvis). 

synword(nb,    nattbuss). 
% neste buss confusion (actual),%% used in TT InfoPage
synword(nbeste,        neste).  

%%  synword(nbf,      fra). %% neste buss fra , also splitword 
%% synword(nbuss,         buss).      %% nattbuss|buss most likely on keyboard (neib k)
%% synword(nbusse,        buss). 
%% synword(nbussen,       bussen).
%% synword(nbusser,       busser).

synword(nb�r,          n�r). 
synword(nde,           ned).       %%
synword(nde,           de).        %% actual 
synword(ndet,          det).
synword(ndste,         neste). 
synword(ne,            ned). 
%% synword(ne,            nummer).  %% TA-101222  
synword(neafor,        nedenfor).
synword(neaste,        neste). 
synword(neate,         neste). 
synword(nebte,         neste).     %%  ne�te buss 
synword(nedafor,       nedenfor). 
synword(nednefor,      nedenfor). %% own 
synword(nedenst�ende,  dette). %% rough 
synword(nedst�ende,    dette). %% rough
synword(nederst,       nede).  

synword(nedom,         ned).  
synword(nedom,         forbi).

synword(nedste,        neste). 
synword(nedt,          neste). 
synword(nedte,         neste). 
synword(neeste,        neste). 
synword(neete,         neste). 
synword(neh,           nei).  
synword(nehei,         nei). 
synword(neida,         nei).  
synword(neii,          nei). 
synword(neinei,        nei).       %% vel?
synword(neivel,        nei).  
synword(neivell,       nei).  
synword(nekste,        neste). 
synword(nellom,        mellom).  
synword(nemest,        n�rmest).  
synword(nemeste,       n�rmeste). 
synword(nemste,        neste). 
synword(nen,           noen).  
synword(nenste,        neste).  
synword(neom,          nedenom). 
synword(neon,          noen). 
synword(neppe,         ikke). 
synword(ner,           ned).       %%  SWE (n�r?)
synword(ner,           nr).  


%%N�RMEST     adverb, adjective, preposition

synword(nerheten,      n�rheten).
synword(nerhetern,     n�rheten).
synword(nerleiken,     n�rhetent).
synword(nerme,         n�r).
synword(nermer,        n�r).
synword(nermere,       n�r). 
synword(nermes,        n�rmest). 
synword(nermeset,      n�rmeste).  
synword(nermest,       n�rmest). 
synword(nermest,       n�rmeste).  
%%% synword(nermeste,      n�rmest).     %% etc. %% n�r g�r nermeste buss 

synword(nermaste,      n�rmeste). 
%% synword(nermeste,      n�rmeste).   %% splitword
%% synword(nermeste,      neste).  
synword(nermetse,      n�rmeste). 
synword(nermetse,      neste).  

synword(nerse,         neste).
synword(nerste,        neste).  
synword(nerte,         neste). 
synword(nesate,        neste).  
synword(nesdte,        neste). 
synword(nese,          neste).  
synword(neset,         neste).
synword(nesete,        neste). 
synword(nesge,         neste).    %%  neib k
synword(nesgte,        neste).  
synword(neskommende,   neste). 
synword(nesnte,        neste).  %% TA-110630 
synword(nesre,         neste).  
synword(nesrte,        neste).  
synword(nesste,        neste). 

synword(nest,          neste).     %%   nest f�rste / nest siste
synword(nesta,         neste).     %%  (dialect)
synword(nestd,         neste).  
synword(nesteb,        neste). 
synword(nested,        neste).  
synword(nestee,        neste). 
synword(nestef,        neste).  
synword(nestel,        neste).  

%%  synword(nestefra,      fra). %% also split 
%%  synword(nestegang,     heretter). 
synword(nestei,        neste). 

%% synword(nesten,        neste). %% Rough 3 nesten buss %% ( or noisew ?)
                                  %% TA-110106
synword(nestene,       neste). 
synword(nesteneste,    andre). 
synword(nester,        neste). 
%%  synword(nesten,        []).   
synword(nestes,        neste). 
synword(nestet,        neste). 
synword(nestetter,     etter).   
synword(nestew,        neste). 

synword(nestf,         neste). 
synword(nestf�rste,    andre). 
synword(nestn,         neste). 
synword(nestneste,     andre). 

synword(nestge,        neste). 
synword(nestkommende,  neste). 
synword(nestle,        neste). 
synword(nestr,         neste).  
synword(nestw,         neste). 
synword(nestwe,        neste). 
synword(nestre,        neste). 
synword(nests,         neste). 
synword(nestte,        neste). 

% N�r g�r nest buss = neste buss                                     

% synword(nest,          andre).   %% Fixed in bustrans

synword(nestse,        neste).  
synword(nestye,        neste). 

synword(nesue,         neste).  
synword(nesye,         neste).   
synword(neswte,        neste).  
synword(neszte,        neste).  
synword(nete,          neste). 
synword(neteste,       neste).   
synword(nets,          nest).  
synword(netse,         neste). 
synword(netst,         neste). 
synword(netste,        neste). 
% synword(nettop,        n�).     %%  = reach * 
% synword(nettopp,       n�).     %%  = reach * 
%% synword(nevnte,        dette). %% -> adj2 
synword(newste,        neste).   
synword(newte,         neste). 
synword(nexte,         neste).  
%% synword(next,         nest(e)). %% No, lang sel.
synword(ne�r,          n�r).  
synword(nfra,          fra). 
%% synword(ng,            [n�r,g�r]).  %% n�r g�r (also splitword)
synword(ngn,           neste). %% n�r g�r neste 
synword(ngnb,          buss). 
synword(ng�r,          g�r).  %%  act
synword(nh�r,          n�r). 
synword(nkan,          kan). 
synword(nk�r,          n�r). 

%% synword(ni,            du).        %%  SVENSK ( EXPERIMENT )    
                                    %% failed  N�r g�r ni til dragvoll ?
synword(nie,           noe).
synword(nien,          noen). 
synword(nii,           9).  
synword(nio,           9).  
synword(niste,         neste).
synword(njeste,        neste). 
synword(nj�r,          n�r). 
synword(nl�r,          n�r).  
synword(nmed,          med). 
synword(nmeste,        neste). 
synword(nmmer,         nummer).  
synword(nmr,           nr). 
synword(nm�,           n�).  
synword(nm�r,          n�r). 
synword(nneste,        neste). 
synword(nn�,           n�).      %%  own spc
synword(nn�r,          n�r). 
synword(nnr,           nr).  
synword(nnr�,          n�r).  
synword(nnr�,          n�r). 
synword(nnummer,       nummer).  
synword(nn�r,          n�r). 

synword(no,            n�). %% no -> n� -> reach 
%%                                  %% ( "synparticle" , solved in  grammar) 
%% synword(no,            noe). %% er det no post ? 
%% synword(no,            nr). 

%% synword(noe,           []).  %% er det noe g�y %% jeg liker noe
 
synword(noe,           ting).  %% jeg vet noe (som er) rart
synword(noe,           litt).  %% Hazard

synword(noeb,          noen). %% own
synword(noem,          noen).  
synword(noenting,      noe). 
%% synword(noensted,      dit).    %%   Roughly  particle  somewhere
synword(noensteder,    noensted). 
synword(noenstedes,    noensted).  %% Technical word
synword(noesk,         norwegian).
synword(nog,           nok).  %%  SW 
synword(nogen,         noen). 
synword(noke,          noen). %% act. %% //nofunk
synword(noke,          noe).  %% dial
synword(nokka,         noe). 
synword(nokke,         noe).  
synword(nokken,        noen). 
synword(nokko,         noe).  
synword(noko,          noe).
synword(nokon,         noen). 
synword(nokre,         noen).
synword(nomer,         nummer).    %%  noun
synword(nomere,        nummeret).  %%
synword(nommer,        nummer).    %%  Sp
synword(nommere,       nummer).  
synword(nomrer,        nummer).
synword(non,           noen). 
% synword(nor,         nord).    %% ?
synword(nor,           n�r).     %% ? 
synword(nordmenn,      personer). 
synword(normenn,       personer). 
synword(norgestaxi,taxi). 
synword(norover,       nordover). 
synword(norr,          n�r). 
synword(norsk,         norwegian). %%  the language
%% synword(nordover,      nord). 
synword(norover,       nordover). 
synword(nort,          nord). %% TA-101210
synword(noste,         neste).  

synword(np,              n�).  
synword(npe,             noe). 
synword(npr,             n�r). 
synword(np�r,            n�r).  

% synword(nr,            rute).      %% Ad Hoc, destroys busphrases
% synword(nr,            buss).      %%  en nr.9 g�r

synword(nr,            nummer).      %% Experiment
%% synword(nr,            n�r).      %%  haz! N�r g�r nr 5 fra dragvoll til sentrum?

synword(nreste,        neste).  
synword(nri,           nei). 
synword(nrr,           nummer).  
synword(nrste,         neste).
synword(nrummer,       numer).  
synword(nr�,           n�r). 
synword(nteste,        neste). 
synword(ntidlig,       tidlig).  %% morge|n tidlig
synword(nvor,          hvor).  

%%    n�r er avgangene nr9 ? ==> kl 9  %% HAZARD 

%% Solve by    w(nr9,name(9,u,route)). 

/* -> synbus  
synword(buss3,         3).  %%  etc
*/

synword(rute3,         3).  %%  etc

synword(nr1,           1).            %%  ( nr1 ~ nrk )
synword(nr2,           2).            %%
synword(nr3,           3).            %%
synword(nr4,           4).            %%
synword(nr5,           5).            %%
synword(nr6,           6).            %%
synword(nr7,           7).            %%
synword(nr8,           8).            %%
synword(nr9,           9).            %%
synword(nr10,         10).            %%  etc...
synword(nr24,         24).            %% actual X


synword(nsb,           tog).   
synword(nset,          neste).
synword(nsete,         neste). 
synword(nsste,         neste). 
synword(nst,           neste). 
synword(nste,          neste).   

synword(nytt�rsfeiring,feiring). %% rough

synword(nyttayrsaften,new_years_eve). 
synword(nyttarsaften,new_years_eve).
synword(nytt�rsafen, new_years_eve).
synword(nytt�rsafta, new_years_eve).
synword(nytt�rsften, new_years_eve).
synword(nyttarsaften,new_years_eve ). 
synword(nytt�rsfaten,new_years_eve ). 
synword(ntt�rsaften,new_years_eve ).
synword(nytt�eraften,new_years_eve ).
synword( nyaften,new_years_eve ).

synword(nu,            n�). 
%% synword(nu,            nr). %% ... og nu =og nummer Confuse 
synword(nudd,          buss). 
synword(nuh,           n�).          %% :-) 
synword(nume,          nummer). 
synword(numummer,      nummer).  
synword(nunummer,      nummer). 
synword(nussem,        bussen). 
synword(nuste,         neste). 
synword(nymmer,        nummer). 
synword(nur,           nummer).  
synword(n�r,           n�r).  
synword(nweste,        neste). 
synword(nwste,         neste). 
synword(nyr,           n�r).
synword(n�emeste,      n�rmeste).  
synword(n�i,           nei).   
synword(n�j,           nei).      
synword(n�jj,          nei).         %% ?  
synword(n�meste,       n�rmeste).  
synword(n�raste,       n�rmest). 
synword(n�remere,      n�rmere). 
synword(n�remest,      n�rmest). 
synword(n�remeste,     n�rmeste). 
synword(n�remset,      n�rmest). 
synword(n�remst,       n�rmest). 
synword(n�remste,      n�rmeste). 
synword(n�rest,        n�rmest). 
synword(nerest,        n�rmest). 

synword(n�rheyen,      n�rheten).  
synword(n�rleiken,     n�rheten). 
synword(n�rliggende,   n�r).          %%  ?
synword(n�rtliggende,  n�r).          %%
synword(n�rmaste,       n�rmeste).  
%% synword(n�rmenste,     n�rmest).  
%% synword(n�rmenste,     n�rmeste).  
synword(n�rmesst,      n�rmest). 
%%%% synword(n�rmeste,      n�rmest). %% makes ADJ -> PREP *
synword(n�rmes,        n�rmest).  
synword(n�rmheten,     n�rheten). 
synword(n�rmmeste,     n�rmest).      %% hard to spot spell
synword(n�rmet,        n�rmest).   
synword(n�rmete,       n�rmeste). 
synword(n�rmset,       n�rmest).  
synword(n�rma,         n�r).         %% dial
synword(n�rmast,       n�rmest). 
synword(n�rmaste,      n�rmest).  
synword(n�rme,         n�r). 
% synword(n�rmeste,  n�rmest).   %%  " N�rmeste stasjon ==> forbi stasjon ==> buss forbi stasjon
synword(n�rmeset,      n�rmest).
   %% synword(n�rmeste,      neste).         %%% Repair  n�rmeste time //


synword(n�rmenste,     neste).   %% (succeeds as neste) 

synword(n�srmest,      n�rmest).  
synword(n�srmeste,     n�rmeste). %% 
synword(n�st,          neste).  
synword(n�t,           n�r).  %%  ?  N[t g[r

synword(n�dig,         ikke). %% rough 
synword(n�r,           n�r). 
synword(n�rme,         n�rme).  
synword(n�rmere,       n�rmere). 
synword(n�rmest,       n�rmest). 
synword(n�ste,         neste).  
synword(n�a,           n�). 
synword(n�ar,          n�r).  
synword(n�d,           n�).
synword(n�e,           n�r). 
synword(n�er,          n�r). 
synword(n�f,           n�r). 
synword(n�hr,          n�r). 
synword(n�i,           n�r). 
synword(n�mr,          n�r). 
synword(n�n,           noen). 
synword(n�nr,          n�r).  
synword(n�p,           n�r). 
synword(n�pr,          n�r). 
synword(n�pq,          n�r). 
synword(n�n�r,         n�r). 
synword(n�ra,          n�r).
synword(n�rb,          n�r).
synword(n�rhvilken,    hvilken). %%  Repair
synword(n�rk,          n�r).     %% 
synword(n�rm,          n�r). 
synword(n�rn,          n�r).   
synword(n�rneste,      neste). 
synword(n�rn�r,        n�r).
synword(n�rsj,         n�r). 
synword(n�rt,          n�r). 
synword(n�rtid,        n�r). 
synword(n�r�,          n�r). 
synword(n�y,           n�). 
synword(n�yr,          n�r). %% når 
synword(n��r,          n�r). 
synword(n��,           n�). 
synword(n��r,          n�r). 
synword(number,        nummer).   %% ? destroys language selection!
synword(nummber,       nummer). 

%% synword(nr,rute)     :- \+ user:myflags(teleflag,true). 
%% synword(nummer,rute) :- \+ user:myflags(teleflag,true). %% hva er et nummer 

synword(nummeret,telefonnummeret). %% ad hoc  nummeret til SMSTUC 

% synword(nummer,        buss).          %%  hva er nummer = kj�ret�y 
 % Try without   <<Hvor kan  jeg f� et nummer>> 

synword(num,           nummer). 	
synword(numme,         nummer). 
synword(nummerr,       nummer).  
synword(nummertet,     nummeret).
synword(numemer,       nummer). 
synword(numemr,        nummer). 
synword(numer,         nummer). 
synword(nummet,        nummeret). 
synword(nummker,       nummer). 
synword(nummrt,        nummer).  
synword(nuymmer,       nummer).   %%  Neib k
%  synword(nummber,       nummer).   %%   Eng
synword(nummmer,       nummer). 

synword(nummer1,           1). %% why not nr1 ?
synword(nummer2,           2).  
synword(nummer3,           3). 
synword(nummer4,           4).
synword(nummer5,           5). 
synword(nummer6,           6). 
synword(nummer7,           7). 
synword(nummer9,           9). 

synword(nyen,          byen).  %% neib k
synword(nyeste,        siste).  

synword(nyttayr,        new_years_day).       

synword(ny�rsaften,     new_years_eve).  


synword(nytt�raften,    new_years_eve).  
synword(nytt�rsaften,   new_years_eve).  
synword(nytt�rsaftenen, new_years_eve).   %% (name, not noun)
synword(nytt�rsfeiring, new_years_eve).   %% rough 

synword(nytt�r,         new_years_day).   %%   Ambiguous/ but ny.eve is not the new year
synword(nytt�rshelga,   new_years_day).   %% ambi, but helgen is mentioned
synword(nytt�rshelgen,  new_years_day).   %% ambi, but helgen is mentioned
synword(nytt�rahelgen,  new_years_day).   %% sp

synword(nytt�rdag,      new_years_day). 
synword(nytt�rsdag,     new_years_day).
synword(nytt�rsdagen,   new_years_day).   %% (name, not noun)
synword(nyt�rsaften,    new_years_eve). 
synword(nyt�rsdagen,    new_years_day).  
synword(ny�rsdagen,     new_years_day).   %
synword(ny�rsdag,       new_years_day). 

synword(n�,            n�).          %% TA-101228
synword(n�rt,          n�r).  
synword(n�yktig,       n�yaktig).    %%  own
synword(n�r,           n�r).         %%  Swedish   Can not be n�r (near :-)

%% synword(n�r,           n�r).      %%  Swedish NOT reach !!!!!!! 

synword(n�se,          neste).       %% ? 
synword(n�sta,         neste).       %% Swedish 
synword(n�sti,         neste).       %% Isl
% synword(n�sta,         neste).     %% not surfacing
synword(n�ste,         neste). 
% synword(n�sten,        nesten).  

synword(naa,           n�).   

synword(naar,          n�r). 
synword(naaar,         n�r).  
synword(naayr,         n�r). 
synword(n�g,           n�r).    %% n�r g�r
synword(n�ge,          noe).    %% TA-101029 
synword(n�gen,         noen). 
synword(n�k,           n�r). %%  -.. kommer
synword(n�kka,         noen).
synword(n�nn,          noen). 
synword(n�re,          n�r).  
synword(n�rg,          n�r).   
%% synword(n�rg�r,        g�r).     %%  Rough
%%  synword(n�rg�rbuss,    buss).    %%  Rough 
%%  synword(n�rg�rneste,   neste).   %%  Rough
synword(n�rr,          n�r). 
synword(n�rti,         n�r).   
%% synword(n�rtid,        n�r).  %% preposition2 \+ reach
synword(n�s,           n�r).   %% actual
synword(n�t,           n�r).   %% key neigh
synword(n�tiden,       n�). 
synword(n�ttid,        n�). 
synword(n�tr,          n�r).  
synword(n�yr,          n�r).   %% når 
synword(naartid,       n�r). 
synword(n�v�rende,     denne).        %%  Rough %% TA-110725
%%  synword(n�v�rende,     dette).        %%  Rough %% TA-110725

%%� synword(o 


synword(o1,01). 
synword(o2,02). 
synword(o3,03). 
synword(o4,04). 
synword(o5,05). 
synword(o6,06). 
synword(o7,07). 
synword(o8,08). 
synword(o9,09). 

synword(och,           og).           %%  (Swedish)
synword(ocks�,         ogs�).
  
synword(odte,          ofte). 
synword(oest,          �st).          %% also avoids vest
%% synword(oestover,        �stover). %% NO, cant handle anyway 
synword(oestre,        �stre).        %%  avoids vestre
synword(oevre,         �vre). 
%% synword(of,            og).  %% destroys lang. selection 
synword(offer,         hvorfor). 
synword(offte,         ofte).  
synword(ofr,           for).  
synword(oft,           ofte).         % dialekt ? 
synword(ofta,          ofte).         % dialekt ?
synword(oftare,        ofte).         %%  NN
synword(oftere,        ofte). 
synword(oftest,        ofte).
%%  synword(ogfra,         fra).  
synword(ogsom,         som). 
synword(ohoi,          hei).    
synword(ohoj,          hei).  

synword(okai,          ok).
synword(okay,          ok). 
synword(okeei,         ok). 
synword(okei,          ok). 
synword(okeida,        ok). 
synword(okej,          ok). 
synword(okeii,         ok).
synword(okey,          ok).
synword(okhei,         hei). 
synword(oki,           ok).  
synword(okii,          ok).  
synword(okok,          ok).
synword(oky,           ok). 
synword(ok�,           ok).
synword(ook,           ok).

synword(okken,         hvilken). 
%%% synword(om,            hvis). %% Hazardous  
synword(ombord,        inn). 
synword(omg�ende,      n�).  
synword(omkting,       omkring). 
synword(omm,           om). 

%% synword(omme,          slutt). %% tiden er .. %%  -> Ha det bra
synword(omme,          komme). %% for � omme 

synword(omorgenen,     ommorgenen). 
synword(omradet,       omr�det). 
synword(omrking,       omkring). 
synword(omrkring,      omkring). 
synword(omrpde,        omr�de). 
synword(omrtent,       omtrent). 
synword(omtrendt,      omtrent).
synword(omvendt,       tilbake). 
%% synword(on,            om).   %% Destroys language sel
synword(onfo,          informasjon). %% info 
synword(onkring,       omkring). 
synword(online,        her).   %% Ad Hoc 

synword(onnen,         innen). %%  own
synword(op,            opp). 
synword(op,            p�). %%  doubl neibk
synword(open,          �pen). 
synword(opent,         �pent). 
synword(opg,           og).      %% slip
synword(opgitt,        opgitt). 
synword(oppbygd,       laget). 
synword(oppi,          i). 
synword(opne,          �pne). 
synword(oppdaterte,    oppdatert). %% Rule her 
synword(oppmot,        mot).  
synword(oppom,         forbi).
synword(oppsto,        hendte). % oppst�r/oppst�
synword(oppst�,        hende). 
synword(oppsto,        hendte).
synword(oppst�tt,      hendt).
synword(opp�,          til). %% opp p� by�sen 
synword(opp�ver,       oppover). 
synword(or,            for).  
synword(orakwl,        orakel). 
synword(orakle,        orakel). 
synword(oraklet,       orakelet).     %%  (there is a rule)
synword(orbi,          forbi).
%% synword(ord,           ordin�r).   %%  du bruker -ord- som fins
synword(oreklet,       orakelet).    %% oraklet er selv syn orakelet 
synword(orgenen,       morgenen).     %%  om (m)orgenen

synword(orsak,         unnskyld). 
synword(otti,          �tti). 

%% synword(oss,           jeg).  %% Need Case distinction 
synword(ossen,         hvordan). %%  �ssen
synword(ossn,          hvordan).
synword(ost,           �st). 

synword(otil,          til). 
synword(otte,          �tte). 
synword(otter,         �tte).  
synword(otterne,       �tte). 

synword(ovenfor,       ved). 
synword(ovennevnte,    denne).
synword(overfor,       ved). 
synword(overmorgen,    overimorgen). %% ?
synword(overmorra,     overimorgen).
synword(overstadig,    veldig).
synword(overt,         over). 
synword(ovet,          over). 
synword(ovre,          �vre). 
synword(oxo,           ogs�). 
synword(o�,            p�). 

%% synword(p 

synword(p,             p�). %% sms 
synword(pa,            p�).
synword(palmes�ndag,   palm_sunday). 

synword(paa,           p�).

synword(paserere,      passere).  
synword(pasererer,     passerer). 
synword(pasesrer,      passerer). 

synword(paskedag,      easterday).  %% NB
synword(paskeaften,    eastereve). 
synword(p�skedag,      easterday).  %% NB
synword(p�skeaften,    eastereve). 
synword(p�skerute,     p�skerute).


synword(passeer,       passerer).  
synword(passrer,       passerer). 
synword(pasrerer,      passerer). 
synword(passende,      fin).

synword(passer,        passerer). %% det passer meg %% matches  with correspond
               
synword(passeerer,     passerer).     %%  (actual)
synword(passereer,     passerer).  
synword(passeren,      passerer).     %% sp
synword(passereq,      passerer).
synword(passerere,     passerer).     %%  er (heur)
synword(passererer,    passerer). %% avoid noun(passerere --> passerer=imp
%% synword(passeres,      passerer). %% NB spiw %% NOHELP
synword(passeser,      passerer).
synword(passeserer,    passerer).
synword(passeses,      passerer). 
synword(pay,           p�). %%  på  %% �-tr�bbel
synword(payske,        p�ske).

synword(pb,            postboks). 
synword(pi,            p�).       %% actual
%% synword(pils,�l).  %% Facetious  
synword(pinlig,        d�rlig).
synword(pinsedag,      whitsun_day). 
synword(pinseaften,    whitsun_eve). 
synword(pinsaften,     whitsun_eve).
synword(pirs,          pris). %% own 
synword(pisneaften,    whitsun_eve). 
synword(pinses�ndag,   whitsun_day). 
%% synword(pc,            datamaskin). %% noun
synword(pemger,        penger). 
synword(penest,        pen).  
synword(pengar,        penger). %% trouble
synword(pengerr,       penger).
synword(per,           hver).   %%  Per Bogesen //tele ?
%% synword(per,           i).         %% per dags dato ?????
synword(perfekt,       bra). 
synword(pesron,        person). 
synword(pfra,          fra).          %% ? act 
synword(pg,            og).           %%  own sp
synword(pl,            kl).           %% ?? Haz?
%% synword(pm,            om).           %%  ? Eng,  dislike om
synword(po,            p�).   
synword(pog,           og).           %% own 
synword(polities,      politiets). 
synword(po�,           p�).           %% slip 
synword(pp,            p�).  
synword(ppasserer,     passerer).  
synword(pp�,           p�). 
synword(pr,            hver).         %% For hver ? 
synword(pra,           fra).          %% ?
synword(pra�ver,       pr�ver).
synword(precis,        presis). 
synword(priesen,       prisen).       %%  own sp
synword(prise,         priser).       %% DK 
% synword(priseb,         priser).    %% own sp
synword(prisn,         prisen).   
synword(prisens,       prinsens).     %% not gen price 
synword(probem,        problem). 
synword(pronto,        hurtig).  
synword(propan,        gass). 
synword(psserer,       passerer).  
synword(ptte,          8).            %%  neib
synword(pussene,       bussene).
synword(py,            p�).           %% p� 
synword(p�ls,          p�lse).  
synword(p�stre,        �stre).        %% slip
synword(p�,            p�).  
synword(p�e,           p�).       %%  own
synword(p�f�lgende,    neste). 
synword(p�l,           p�). %% ? 
%% synword(p�litelig,     presis).   %% rough reliable (good)
%% synword(p�litelige,    presise).  %% 
synword(p�logget,      her).      %% Ad Hoc 
synword(p�p,           p�).  
synword(p�r,           g�r).  
synword(p�r,           n�r).   
synword(p�seke,        p�ske).   %% own
synword(p�s�ndag,      s�ndag). 
synword(p�mandag,      mandag). 
synword(p�tirsdag,     tirsdag). 
synword(p�onsdag,      onsdag). 
synword(p�torsdag,     torsdag).
synword(p�fredag,      fredag). 
synword(p�l�rdag,      l�rdag). 

synword(p�skaften,     eastereve). 
synword(p�skdag,       easterday). 
synword(p�skfag,       easterday). %% sms

synword(p�skeaftem,    eastereve). 
synword(p�skeaften,    eastereve). 

synword(paaskeaften,    eastereve). 

synword(p�skaften,     eastereve).
synword(p�skedag,      easterday). 
synword(p�skes�ndag,   easterday).
synword(p�skehelligdag,p�ske).       %% (Rough, -> must specify date) 
synword(p�skehellidag, p�ske).       %%
synword(p�sledag,      p�skedag).    %% own sp
synword(p�t,           p�). 
synword(p�y,           p�).          %% på
synword(p��,           p�).  


%%�  synword(q 

synword(qtter,         etter).  

%%�  synword(r 

synword(r,             er). %% TA-101103 Haz?

 synword(ra,            fra).   %% mutually destructive
 synword(ra,            ta). 

synword(raf,           fra).        
synword(rakt,          hurtig). 
synword(rar,           uforst�elig).  %% ( There is a wisdom herein !)
synword(rare,          uforst�elig).  
%%%  synword(rart,          d�rlig). 
synword(rart,          uforst�elig).  

% synword(rasende,       veldig). %% ..fort 
% synword(rask,          hurtig).  %% not adverb
% synword(raske,         hurtig).  %% not adverb 

synword(rb,            rutebil). 
synword(rbuss,         buss). %% g� rbuss
synword(rdet,          det).  %% g� rdet 
synword(rdu,           du).   %% bo rdu
synword(rjeg,          jeg). 
synword(rm�,           m�). 
synword(rsakest,       raskest). 
synword(rumdt,         rundt). 
synword(rvndt,         rundt). %% TA-101011
synword(russ,          buss). 
synword(r�r,           g�r). 


synword(raskt, []). %% hurtig). %%   h�per   dere raskt  kan bidra .

synword(raskesk,       raskest).  
synword(raskeste,      beste).
synword(raskeset,      beste). 
%% synword(romjula,       christmas). 
%% synword(romjulen,      christmas). 
%% synword(julehelgen,    christmas).  

synword(raud,          r�d). 
synword(re,            er).   %% provoc?
synword(rede,          informasjon).  %% rede p�
synword(regelmessig,   ofte).         %%  (roughly)
synword(registert,     registrert).   %% own
synword(rei,           reise).        %% disrupt
synword(reis,          reise).        %% Dial
synword(reisel,        reise).  
synword(reisevei,      vei).   
synword(rekekr,        rekker).       %%  own
synword(reke,          rekke). 
synword(reker,         rekker).  
synword(rekvisjon,     rekvisisjon).  %% sp
synword(remme,         framme).       %% a 
synword(rening,        retning).  
synword(resa,          reise).  
synword(rese,          reise). 
synword(resie,         reise).   
synword(resise,        reise).  
synword(restart,       start).
%% synword(restarting,    start). %% ?

synword(reste,         neste). %% g�r reste (contag)
synword(retn,          retning). 
synword(reting,        retning). 
synword(retnig,        retning).  

%%%% synword(retning,       mot).   %% starter i feil retning %% TA-101115

%% synword(retur,         til).    %% retur munkegata
synword(retur,         tilbake). %% n�r g�r det retur ? No help
synword(returbuss,     til).    %% rough
% synword(retur,         tur).        %%  (knows word, but cant handle)
%% buss i retur = buss i tur = buss i rute = buss uten forsinkelse !!!

synword(rette,   rett).
synword(rettet,   korrigert). %%  -> rettet = adj
synword(rettede,  korrigerte).

synword(retut,   tur). %% useless 
synword(rettur,  tur). %% useless
%% synword(rett,[]).  
%% synword(retter,  etter). %% suspended for test (de retter feilen)
synword(returtider, retur).
synword(ret,           rett).    %% retur ???
synword(rfa,           fra).  
synword(rg�r,          g�r).     %% own spc
synword(ril,           til). 
synword(rindt,         rundt).   %%  neib k
synword(rite,          rute).    %%  own
synword(riter,         ruter).  
synword(rkl,           kl).      %%  ette rkl
synword(rklokka,       klokken). 
synword(rklokken,      klokken).
synword(rndt,          rundt).  
synword(rneste,        neste).   %%  g� rneste
synword(rnudt,         rundt).
synword(roinntur,      rundtur).    %% rough

synword(romnumer,      romnummer).  
synword(romnr,         romnummer). 
synword(roter,         ruter). 

 synword(ra,            fra).   %% mutually destructive
 synword(ra,            ta). 

synword(raf,           fra).        
synword(rakt,          hurtig). 
synword(rar,           uforst�elig).  %% ( There is a wisdom herein !)
synword(rare,          uforst�elig).  
%%%  synword(rart,          d�rlig). 
synword(rart,          uforst�elig).  

% synword(rasende,       veldig). %% ..fort 
% synword(rask,          hurtig).  %% not adverb
% synword(raske,         hurtig).  %% not adverb 

%% synword(sightseeing,   rundtur). 

synword(rutetabbel,    rutetabell). 
synword(rutetabel,     rutetabell). 
synword(rutetide,      rutetider).   
synword(rutider,       rutetider).    %%  ( slightly dyslex.)
synword(ryte,          rute). 

synword(r�tning,       retning).  %% dial
synword(r�kk,          rekker).  
synword(r�king,        r�yking). %% no need for inflect 

synword(rra,           fra).     %%  neib k
synword(rrundt,        rundt).  
%% synword(rt,            et).   %% et|er  
synword(rtil,          til).     %% own  busse rtil 
synword(rtter,         etter).   %%  neib k
synword(rubdt,         rundt).  
synword(rudnt,         rundt). 
synword(rudt,          rundt). 
synword(ruet,          rute). 
synword(ruetabell,     rutetabell).

synword(rundet,        rundt). 
synword(runkdt,        rundt). 
synword(runndt,        rundt).  

synword(rund,          rundt). %% own (er jorda rund ?)

synword(runde,         rundt). 
synword(rundft,        rundt).  
synword(rundk,         rundt).  
%%  synword(rundtkl,       klokken). %% rough, also split
synword(rundtom,       rundt). 
synword(rundtr,        rundt).  
synword(rundy,         rundt). 
synword(rundyt,        rundt).  
synword(runft,         rundt).   %% own spc
synword(runst,         rundt).  
synword(runt,          rundt). 
synword(runtd,         rundt).  
synword(rure,          rute).    %%  neib k
synword(rutan,         rutene). 
synword(rutd,          rute). 
synword(rutende,       rutene). 
synword(rutenen,       ruten).  
synword(rutenr,        rute).  
synword(ruteopplysng,  ruteopplysning).
synword(rutepln,       ruteplan). %% own sp
% synword(rutenummer,    nummer). 
% synword(rutenummer,    rute).



%%� synword(s 
 
synword(s,            sentrum).   %% avoid Trondheim S = sentrum %% 
%%% synword(s,            siste).  %% TA-100825     %%  Hazardous, change to fnlp = [s] 
                      %%  Buss 6 g�r fra s kl 16.00   

%% synword(sa,           s�). %% �-problem Haz

synword(saklig,       bra).  
synword(sal,          skal).    

synword(sankthans,    midsummer_day).       %%  ambiguous
synword(sankthansaften,  midsummer_eve).  
synword(sankthansdag, midsummer_day).  
synword(sannt,        sant). 
synword(sap,          heretter). 
synword(sato,         dato).      %% Not 'Stor'   amble# anomaly 
synword(satsa,        h�pet). 
synword(say,          s�).        %% så  destroys lang select ?
synword(sbuss,        buss). 
synword(sdet,         det).       %%  own
synword(sdj�,         adj�).      %% Neibk
synword(sdu,          du).        %% TA-11033	 neib
%% synword(sfall,        s�fall). %% ?
synword(sfra,         fra). 
synword(sge,          seg). 
synword(sg�r,         g�r).       %% buss sg�r
synword(sher,         skjer). %% ? 
synword(skejr,        skjer).
synword(sm,           som). 
synword(sm�penger,    penger).   


synword(saynn,         slik). %% sånn 

synword(saa,           s�).  
synword(sakl,          skal).  

%% synword(sakte,         fort).    %% -> slowly 
%% synword(saktere,       fort).    %%  
%% synword(saktest,       fort).    %%

synword(samarbeid,     samarbeide). 
synword(sammmen,       sammen).  
%% synword( sammen,       []). %% together
synword(samen,         sammen). 
synword(samnorsk,      bokm�l).  %% rough
synword(samt,          og).  
synword(samtaln,       samtalen). 
synword(samtlige,      alle). 
synword(sann,          sant). 
synword(sanne,         sant).  
synword(sarest,        heretter).  
synword(sarkastisk,    bra). %% returnerer Takk, (som er sarkastisk :-) 

%% synword(se,            s�).   %% �tr�bbel haz
synword(sedan,         siden).    %% Swe
%% synword(seg,           jeg).   %% han liker seg
synword(sei,           si).       %% NN 
synword(sei,           seg).
   synword(sek,           sekunder).

synword(sein,           sen).   
 synword(seiner,        senere). 
 synword(seinere,       senere).  
 synword(seint,         sent). 
 synword(seinast,       senest).  %% now prep 
 synword(seinaste,      siste).   %% now prep 
 synword(seinest,       senest).    %%
 synword(seinest,       sist).    %% seinest 2230 
 synword(seineste,      siste). 

 synword(selv,          redundant0).     %% selv er jeg nyssgjerrig %% TA-110103

 synword(selvf�lgelig,  redundant0). 
 synword(self�lgelig,   redundant0). 
                            
%% destroys selv om// not any more (selv om -> selvom

 synword(senast,        senest). %% SW 
 synword(senaste,       senest). %% SW 
 synword(sener,         senere). 
 synword(senert,        senest). 
 %% synword(senest,        sist).   %% i kveld  %% SUSPENDED TEST
 synword(seneste,       siste).
 synword(seneste,       senest).  
 synword(seneset,       senest).    %% now prep
 synword(senr,          sent). 
 synword(senrum,        sentrum). 
 synword(sensest,       senest).    %%
 synword(senset,        senest). 
 synword(sensete,       siste).  
 synword(sentest,       senest).  

synword(set,           det).  
synword(setd,          sted).  
%% synword(sett,          sitte).   %%  Dial ? har du sett 
%% synword(sett,         []). %% neste sett busser  %% har du sett ... 

% synword(siden,         etter). %% ikke forbi
synword(siden,         fordi). 
synword(sidste,        siste). 
synword(sisdte,        siste). %%


synword(sia,           siden). %% for x min siden 
synword(siate,         siste). 
synword(sida,          siden). %% for x min siden 
synword(sidne,         siden).
synword(sidte,         siste). 
synword(sie,           si). 
synword(siere,         sier). %% own
synword(sifra,         si). 

synword(sig,           seg). %%   DK Sig Bergs alle %% TA-101215  %% fixed  

synword(sik,           slik). 
synword(sike,          slike). 
synword(sil,           til).     %% ???
synword(silk,          slik). 
synword(sinna,         sint).  
synword(sirekte,       direkte). %% slip
synword(sirka,         cirka). 
synword(sirste,        siste). 
synword(sirte,         siste). 
synword(sise,          siste). 
synword(sisete,        siste). 
synword(sisite,        siste).  
synword(sisst,         sist).   
synword(sisste,        siste).  
synword(sista,         siste). 
%%  synword(sistebuss,     siste).  %% ad hoc (splitword).
synword(sisten,        siste).  
synword(sister,        siste). %% ? 
synword(sisti,         siste). 
synword(sistnevnte,    dette).  %% (essence of anaphor)
synword(sistre,        siste). 
synword(sistw,         siste). 
synword(site,          siste). 
synword(siter,         sitter). %% telebuster
synword(siiter,        sitter). %%
synword(sjakk,         chess). 
synword(sjal,          skal). 
synword(sjans,         sjanse).
synword(sjeg,          jeg).  

synword(sjelden,       ofte).   %% Rough but no info about frequecy
synword(sjeldent,      ofte).   %% Rough
synword(sjeldnere,     ofte).   %% Rough
synword(sjeldnest,     ofte).   %% Rough
synword(sjeldneste,    ofte).   %% Rough

synword(sjer,          skjer). 
synword(sjett,         sett).   %% Dial
synword(sjher,         ser).    %% Dial 
synword(sjkal,         skal).  
synword(sjue,          7). 
synword(sjukehus,      sykehus). 
synword(sj�l,          selv).   %% Dial 
synword(sj�s,          sj�en). 
synword(sj�,           se). 
synword(sj�f�rere,     sj�f�r).  
synword(skel,          skal).  
synword(skitur,        tur).    %% Rough 
synword(skja�nner,     forst�r).%%  skjønner
synword(skjelden,      ofte).   %% Rough
synword(skjeldent,     ofte).   %% Rough
synword(skjera,        skjer). 
synword(skj�re,        kj�re). 
synword(skj�rer,       kj�rer). 
synword(skj�rte,       kj�rte).
synword(skj�rt,        kj�rt). 
synword(skl,           skal).  
synword(skla,          skal).
synword(skoel,         skole).  
synword(skold,         skole). 
synword(skoln,         skolen).  

synword(ska,           vil).       %% dialect NB takk ska du ha
synword(skaf,          skaff).     %% TA-110128 DK
%% synword(skal,          vil).        %%   Unnec
synword(skaj,          skal). 
synword(skal�,         skal). 
synword(skak,          skal).   
synword(skall,         vil).           %% slight misspell (Swedish)
synword(skam,          skal).  
synword(skap,          vil).           %% skal 
synword(skasl,         vil).           %% slip
synword(skav,          skal).          %% .. v�re 
synword(ska�,          skal).     %% TA-110817
synword(ska�l,         skal).  
synword(skoill,        vil).  
synword(sku,           vil). 
synword(skulla,        vil).  
synword(skulle,        vil).   

synword(skute,         b�t). %% NB ikke skuter (scooter)
synword(skuter,        motorsykkel). %% NB ikke b�te

synword(skj�rtorsdag,      maundy_thursday). %% Correct,  not monday
   synword(skj�rtorsda,    maundy_thursday). %%
   synword(skj�retorsdag,  maundy_thursday). %% own
   synword(skj�rtorsdags,  maundy_thursday). %%
   synword(sj�rtorsdag,    maundy_thursday). %% should be a name
   synword(skj�rtorsag,    maundy_thursday).
   synword(skj�rtorsdag,   maundy_thursday). 
   synword(skj�rtordag,    maundy_thursday). 
   synword(skj�rtorstag,   maundy_thursday).
   synword(skj�rtorstag,   maundy_thursday).


synword(skj�nar,       forst�r). 
% synword(slett,         d�rlig).
% synword(slette,        d�rlig). %%
% synword(slik,          s�nn). 

synword(slk,           slik).  

  %% synword(slik,          denne). %% rough %% slik * oppf�rsel skjer .
  %% slik at ... 

synword(slike,          disse). %% rough 
synword(slrive,skrive). %%  own


synword(skreven,       skrevet). 
% synword(skrv,          skrev). %% ? 
synword(sk�l,          skal).
synword(sli,           slik). 
synword(slika,         slik). %% slik|a t 
%%  synword(slikat,        s�).   %% splitword? 
synword(sm�,           liten). 

synword(snacks,  mat).

synword(snakkes,        adj�).
  synword(prates,       adj�).
  synword(sees,         adj�). 
  synword(snakes,       adj�).
  synword(snakkast,     adj�). 
  synword(talast,       adj�).
  synword(tastes,       adj�). 

synword(sne,  sn�).   
synword(snr,  nr). %% bus snr
synword(sn�ll,snill). %% Dial
synword(sn�l,           uforst�elig).  %% ( There is a wisdom herein !)
synword(sn�r,           n�r). 

synword(snil,          snill).  
synword(snkomst,       ankomst). 
%% problematic

%%synword(snarest,       n�).           %%  ---> reach ***

synword(snarets,       heretter). 
synword(snarast,       heretter).  %%  ???
synword(snareste,      beste).
synword(snarest,       heretter). 
synword(snarest,       beste).     %% spiw %% hva er snareste vei// nofunk 
synword(snartest,      heretter).  %% slight 
synword(snartest,      snarest). 
synword(snareste,      fort).
synword(snart,         heretter). 
% synword(snart,         fort).  %% g�r bussen snart


synword(snodig,        uforst�elig). 
synword(so,            s�).     %%  dial// \+ see 
%% synword(so,            som). %%  
synword(soendre,       s�ndre). 
synword(soer,          s�r).
synword(soiste,        siste). 
synword(some,          som). 
synword(somm,          som). %% TA-110329

% synword(sommertid,     sommerrute).   %%  ( inconsistent ?)
synword(sommmertid,    sommertid). 
synword(sommmerstid,   sommertid).
synword(sommerstid,    sommertid).    

synword(somnormalt,    som). %% rough

synword(sort,          svart).

% sad story   skal -> vil -> g� -> komme : 
% hvordan skal jeg komme til nth ==> 
% hvordan kommer jeg ! * komme til nth

synword(so�rre,       sp�rre). %% own


synword(sopinj,        sulten). %% dial Telf kat ST
%% synword(st,            stasjon). %% Moholt St. Olavs Hospital
synword(spessielt,    spesielt). 
synword(sp�r,         sp�r). 
synword(sp�rsm�l,     sp�rsm�l).  %% own 
%% synword(sp,        s�).        %% Neib K %% sp andersens vei 
synword(ssom,         som).       %% TA-110330
synword(ssyd,         syd).   
%% synword(spasserer,    passerer). %%  (g�r?)

synword(spa�rre,      sp�rre).  
synword(spa�rsmayl,   sp�rsm�l).  %% spørsmål 
synword(spa�rsmaylet, sp�rsm�let).

synword(spm,          sp�rsm�l). 
synword(spm,          som). %%  ?
synword(spoer,        sp�r). 
synword(spoersmaal,   sp�rsm�l). 
synword(spraak,       spr�k). 
synword(sprayk,       spr�k).  
synword(sprek,        god).       %%  ? 
synword(sprog,        spr�k).  
synword(sp�rja,       sp�rre).    %% NN 
synword(sp�rr,        sp�r).  
synword(sp�rsml,      sp�rsm�l). 
synword(sp�rsmpl,     sp�rsm�l). 
synword(sp�rs�l,      sp�rsm�l).  
synword(srayk,        spr�k).
synword(srever,       server).  
synword(sror,         stor).  
synword(ssite,        siste).     %% contag 
synword(sste,         siste). 

%% synword(svar,         svarer). %% dial %% Haz %% dette  svar er feil

synword(sveisann,     hei).       %% :-)
synword(svensk,       swedish).   %% 
synword(svenska,      swedish). 
synword(svenskar,     personer).  %% rough :-)
synword(svensker,     personer).  %% 

synword(svr,          svar). 
synword(svret,        svaret). 
synword(sv�re,        svare). 
synword(sv�rt,        meget). 

                                    
synword(sta,           st�).

    synword(stajon,station). %% -> TS 
    synword(stadjonon,station).  
    synword(tasjon,station).  

synword(staks,         heretter). 
synword(stand,         tilstand). %% \+ i stand  
synword(standard,      vanlig). 
synword(staa,          st�).
synword(staar,         st�r).
synword(star,          st�r).
synword(stater,        land).
synword(statene,       landene).
synword(stat,          land). % USA ???
synword(statio,        stasjon). 
synword(statsjonen,        stasjonen). %% avoid ts if possible
synword(station,        stasjon).  
synword(statjon,        stasjon).
synword(stay,           st�). %%  stå //lang. confusion
synword(stede,         stedet).
synword(sten,          stein).
synword(stertsted,     startsted).   
synword(stil,          til).   
synword(stilte,        stillte).       %% there is a rule wanting 
synword(stiste,        siste).         %% 
synword(stk,           stykker).       %% -er 

synword(stod,          sto).  
%% synword(stoppet,       holdeplassen). %% 
synword(stoppper,      stopper).       %%  Spellcorr
synword(stoppst,       holdeplass). 
synword(stora,         store). 
synword(stter,         etter).  
synword(straks,        heretter). 
synword(strasjon,      stasjon). 
synword(strax,         heretter).  
synword(stste,         siste).   
synword(stykkje,       stykke).  
    synword(st�a,          tilstanden). %% NN :-) %% TA-100831
synword(st�t,          st�r).  
synword(su,            du).            %%  ?
synword(su,            si).            %%  Own spc, neib K
synword(sundt,         bra).   
synword(sunt,          bra).         %%
synword(supert,        bra). 

synword(suss,          buss).   %%  kan jeg f� en suss
           %% intentional humour -> du m� oppgi et sted

synword(suste,         siste).         %% spell neibor
synword(svensker,      personer).   %% de ogs� :-) 
synword(svenskene,     personene).  %% ?   
synword(sybs,          syns). 
synword(syd,           s�r).
synword(sydetter,      s�rover).  
synword(synest,        synes). 
synword(synnes,        synes). 
synword(syns,          synes).
synword(sydover,       s�rover). 
synword(systam,        system).  
synword(syvende,       7).  %% TA-110203
synword(syvendes,      7).             %% Haakon VII gate

synword(s�,            seg).           %%  Dialect
% synword(s�rli,         s�rlig).  
synword(s�e,           s�). %% own 
synword(s�leis,        slik). 
synword(s�m,           som).  
synword(s�mm,          som). 

synword(s�pass,        mye).  %%  det brukes s�pass
synword(s�pass,        s�). 

synword(s�ndag,s�ndag). 
synword(s�,s�ndag). 
synword(s�d,syd).
synword(s�d,s�r).

synword(s�ta,s�te).    %% ..bror
% synword(s�rover,       s�r). 

synword(s�rsia,          s�r).  
synword(s�rsida,         s�r).  
synword(s�rsiden,        s�r).  
synword(nordsia,         nord). 
synword(nordsida,        nord). 
synword(nordsiden,       nord). 

synword(s�rre,         sp�rre).    

synword(son,           som).   %% Son ? 
synword(sonn,          slik).  %% s�nn 

% synword(sondere,       slike). %% no synword to noise
% synword(sonderre,      slike). %%
% synword(s�nnderre,     slike). %%  

synword(sundag,        s�ndag). 
synword(suspekt,       gal).

%% synword(s�,            deretter).  %% confuse  hvis ... s� ...
synword(s�h,           deretter).    %%  ???
synword(s�n,           slik).
synword(s�nn,          slik).
synword(s�nna,         slik). %% s�nna
synword(s�nne,         slike).  
synword(s�nt,          slikt).  
synword(s�nt,          slik). %% dial
synword(s�nt,          noe).  
synword(s��,           s�).   
synword(s��,           deretter).  %% ?

%%� synword(t 

synword(s�rg�ende,     s�rover). 
synword(s�roverg�ende, s�rover).

synword(nordg�ende,     nordover). 
synword(nordoverg�ende, nordover).

synword(ves,ved). %% vest? %%  neib
synword(vesjon,versjon).   %%  own

%%� synword(v 

synword(vestg�ende,     vestover). 
synword(vestoverg�ende, vestover).
synword(vorf�r,         hvorfor). %% TA-101126 
synword(vyss,buss).  

%%� synword(� 

synword(�frste,          �verste).
%% synword(�ste,            �stre).   %% busdat
synword(�l,              �ler). %% ad hoc, 2 �l(er) 
synword(�msker,          �nsker). %%  own
synword(�og,             og).
synword(�stsia,          �st).  
synword(�stsida,         �st). 
synword(�stsiden,        �st). 
synword(�ve,             over).  %% Dial
synword(�vrige,          andre). 

synword(�stg�ende,     �stover).
synword(�stoverg�ende, �stover).

%%� synword(t 

synword(t,               til). %% from synsms
synword(t,               timer). %%  ?? Hazard

synword(tab,             ta). %% bussen
synword(tbuss,           buss).    %% de tbuss


synword(taa,            ta). 
synword(tack,           takk).
synword(tacksam,        takknemlig).   %%  (Swe)
synword(taen,           ta).    % (en) 
synword(taes,           tas).  
synword(tage,           ta).    %% (Dan)
synword(tager,          tar).   %% 
synword(taget,          tatt).  %% 

%% synword(tak,           ta).   % tak i  %% ?
%% synword(tak,           takk). %        %% (Dan)/roof 
% synword(takker,        takk).       %% disturbs syntax  
synword(tal,           til).          %% ? 
synword(taq,           ta).           %%  slip
synword(tat,           tatt).  
synword(tden,          tiden).  
synword(te,            til).          %% Dialect 
synword(tea,           ta).  %%  ?

synword(teambuss,      buss).         %% Local TT ? 

%% synword(teamn�r,       n�r). %% TA-110128 SMS system matches Team without space
                             %% then team n�r is not taken as preheader

synword(team,          teams).  % Team p�skeruter// ad hoc
% synword(te,            ta).         %% � vil te s�ntrum
synword(teiden,        tiden). 
synword(teikk,         trikk). 
synword(teikken,       trikken). 
synword(teil,          til).   
synword(teit,          dum).        
synword(teite,         dumme). 
synword(tek,           tar).      %% NN
synword(tekseten,      teksten).  %% own 
synword(tel,           til).          %% Dialect
synword(tell,          til).          %% Dialect
%% synword(tem,           team).  %% TA-110203

synword(tenger,        trenger). 
synword(tengt,         tenkt). 
synword(tenkende,      intelligent). 
synword(ter,           tre). 
%% synword(teste,         neste).   
synword(tetter,        etter).   
synword(tfor,          for). 
synword(tfra,          fra).   
synword(tg,            tog).  
synword(tgl,           til).  
synword(tg�r,          g�r). 
synword(thankz,        takk).           %%  ? eng
synword(thil,          til).  
synword(thl,           til).  

synword(tia�,          til).  %% TA-101019   ti�
synword(tij,           til).  
synword(tijl,          til). %% dialect

synword(tik,til).         %% neib key  
synword(tikken,        trikken). %% men ikke tikk (takk) 
synword(tikl,til).  

synword(ti,            tid). %% Haz ? 
%% synword(ti,            til).            %% Dialect
%% SORRY   ti over 11 ==> til finished 11 (SIC) // Handled in gram_n

synword(tia,           tiden).          %% Dialect 
synword(tidd,          tid).   
%% synword(tide,          tid).  %% i tide 
%% i tide ==> presis

synword(tidenes,       den). %% st�rste idiot 
synword(tidenne,       tidene). 
%% synword(tider,         avgangstider). %% TIME FROM syndrome %% XP
%%   hvilke tider g�r bussen = n�r 
%% bussen g�r tidlig = om morgenen 

synword(tide,          tiden).
synword(tideb,         tiden). %% neib
synword(tideer,        tider).
synword(tidelig,       tidlig). 
synword(tideligere,    tidligere). 
synword(tideligest,    tidligst).
synword(tidem,         tiden). 
synword(tidi,          tidlig).
synword(tidig,         tidlig). 
synword(tidigere,      tidligere).
synword(tidigst,       tidligst). 
synword(tidigste,      tidligste).

synword(tidkig,        tidlig).  
synword(tidl,          tidlig). 
synword(tidleg,        tidlig).  
synword(tidlegaste,    tidligste).
synword(tidlg,         tidlig).  
synword(tidli,         tidlig). 
synword(tidlid,        tidlig). 
synword(tidligmorgen,  morgen).  
synword(tidligmorgenen,morgenen). 
synword(tidligs,       tidligst). 
synword(tidlist,       tidligst). 
synword(tidlog,        tidlig). 
synword(tdlig,         tidlig). 
synword(tidliog,       tidlig).  
synword(tidliogere,    tidligere).
synword(tideligste,    f�rste). 
synword(tidelikste,    f�rste).  
synword(tidliere,      tidligere). 
synword(tidliegere,    tidligere). %%
synword(tidliger,      tidligere).
synword(tidligerere,   tidligere). 
synword(tidlig�re,     tidligere).
synword(tidligse,      tidlig).    %% f�rste). 
synword(tidligste,     f�rste). 
synword(tidlikste,     f�rste). 
synword(tisligste,     f�rste). 
synword(tidligset,     f�rste).  
synword(tidligste,     tidlig). 
synword(tidligtste,    tidlig). %%f�rste). 
synword(tidligest,     f�rst).          %%  Problem ?
synword(tidligeste,    tidlig). %%f�rste).         %%  (regular 
%% synword(tidligst,      etter).  %%  avoid tidligst -> etter -> beyond
%% tidligst >=   etter > (formally)
%%       synword(tidligst,      tidlig). %% confuse 
synword(tidlilg,       tidlig). 
synword(tidedne,       tidene). 
synword(tidne,         tidene). 
synword(tidnen,        tiden).  
synword(tidsommet,     tidsrommet). 
synword(tidsnok,       presis).     %% ikke for sen/tidlig 
synword(tidsperriode,  periode).  
synword(tidspunk,      tidspunkt). 
synword(tidssjema,     tidsskjema).     %%   (spell)
synword(innimellom,    tidvis). %%  TA-110111
synword(tid�ig,        tidlig). %% own 
synword(tifra,         forbi). 
synword(tikl,          til). 
%% synword(tim,           team). %%  trafikk %% TA-110214
synword(tila,          til).    
synword(tilbak,        tilbake). 
synword(tilbaket,      tilbake). 
synword(tilbars,       tilbake). %%  Dial 
%% synword(tilbke,        tilbake). %% cant
synword(tildig,        tidlig).
synword(tildilig,      tidlig). 
synword(tildlig,       tidlig).
synword(tildligere,    tidligere). 
synword(tildligste,    f�rste).
synword(tile,          til). 
synword(tilfra,        forbi). 
synword(tilgi,         tidlig).  
synword(tilh,          til).  
synword(tilh�rere,     tilh�rer). 
synword(tiliare,       tidligere).
synword(tiliast,       tidligst). 
synword(tiliaste,      tidligste). 
synword(tilig,         tidlig).  
synword(tiligere,      tidligere).
synword(tiligst,       tidligst).
synword(tilist,        tidligst).

synword(tilj,          til). %% dial 
synword(tilk,          til).
%%  synword(tilkl,         f�r). %% also splitword 
%%  synword(tilklokka,     f�r). %% also splitword
synword(tilklokken,    f�r). %% also splitword

synword(tilm,          til). 
synword(tilt,          til). 
synword(tim,           til).     % actual 
synword(timan,         timene).
synword(timeb,         timen). 
synword(timg,          ting).  
synword(tin,           til).   
synword(tinf,          ting).    %%  own sp  ???
synword(tio,           til).  
synword(tiol,          til). 
synword(tiren,         turen).  
synword(tirlig,        tidlig).  
synword(tiu,           til). 
synword(tiul,          til).  
synword(tiulo,         til).   


synword(tii,           til). 
synword(tiil,          til). 
synword(till,          til).            %%  (Sewdish)
synword(tili,          tidlig).  %%  (til?)
synword(tiligst,       tidlig).  %% f�rst). 
synword(tiligste,      f�rste).  %%
synword(til0,          til). 
synword(tillig,        tidlig). 
synword(tills,         til).  
synword(tilo,          til). 
synword(tilogmed,      til). 
synword(tils,          til). 
synword(tilsv,         tilsvarende). 
synword(til�,          til).            %%  key slip
synword(tilatt,        mulig).          %% spell + transitive till.
synword(tillat,        mulig).   
synword(tillatt,       mulig). 
synword(tip,           til).  

synword(tit,           til). 
synword(tit,           n�r).   %% ?? %% Dial

synword(titei,         hei). 
synword(tittei,        hei).    %%  \+ Tine (amble#)
synword(titil,         til).    
synword(titlig,        tidlig). 
synword(tiul,          til).  
synword(ti�,           til). 
synword(ti�l,          til).   
synword(tjenetse,      tjeneste). %% own
synword(tjenste,       tjeneste). 
synword(tjl,           til). 
synword(tkk,           takk).  

%%    synword(to,til). %% ringve skole to strandveien %% Lang%%
	%% Experiment %% TA-110221 failed klokka er to

synword(toeget,        toget).
%% synword(tom,           f�r).  %% t.o.m. %% TA-110620 Haz Bussen er tom.
synword(tover,         over). %% act (utover?) 
synword(to�,           til). %%  dbl neib k
 synword(toge,         toget). 
% synword(toget,         jernbanestasjonen).  %% (Whatever that gives)
synword(togh,          tog).  
%% synword(togret,        toget). %% no torget 
synword(togt,          toget).  
synword(tl,            til). 
synword(tle,           til).     %%  ?
synword(tli,           til). 
synword(tlil,          til). 
synword(tll,           til).  
synword(toil,          til).  
synword(tol,           til).     %%  neib k
synword(tq,            ta).   
%%%%%%%%% synword(tr,   tre). %% Haz %% TA-101207
%% synword(tra,           fra).     %% slip  
synword(tra,           ta).  
synword(traff,         trafikk). %% ?
synword(trasa�en,      traseen). 
synword(tra�nder,      tr�nder).
synword(tredde,        tredje). 
synword(tredhe,        tredje).   %%  own
synword(treff,         sp�rsm�l). %%  hvor mange treff
synword(tregest,       snarest).  %% Rough, Rhet
synword(tregt,         langsomt). 
synword(tremme,        framme). 
synword(trengs,        trenges).
synword(trengst,       trenges).
synword(trejde,        tredje). 
%% synword(trene,         v�re).    %% Too Rough 
synword(tres,          tre). 
synword(trid,          tid). 
synword(trikke,        trikk). 
synword(tril,          til).  
synword(trkk,          trikk). 
synword(trkken,        trikken). 
synword(trondhjem,     trondheim). 
synword(trondjem,      trondheim). 
synword(tronjem,       trondheim). 
synword(trukk,         trikk). %% own 
 %%  synword(trykk,         trikk). %% neib confuse trikk %% TA-110303
synword(tryk,          trikk). %%  neib
synword(tr�g,          dum). 
synword(tr�ng, trenger).   %%  Dial
synword(tr�ndertaxi,taxi). 

synword(tr�ndersk,     norwegian).          %%    :-)
synword(tr�ng,         trenger). 
synword(tsom,          som).  
synword(tta,           ta).  
synword(tter,          etter). 
synword(ttil,          til).
synword(ttl,           til).
synword(ttur,          tur).
synword(tu,            ti).  %% ? = 10
synword(tuene,         turene).
synword(tuil,          til). %% neib key 
synword(tuk,           til). %% double neib k 
synword(tul,           til). %% neib key 
synword(tundt,         rundt).
%% synword(tur,           veg).            %%   ???
synword(turingtest,    turing_test).  
synword(turingtesten,  turing_test).  
synword(tusentakk,     takk). 
synword(tusind,        1000). %%  DK
synword(tusinde,       1000). 
synword(tusn,          1000).  
synword(tv�rt,         tvert). 
synword(tv�,           to). 
synword(tyar,          tar).  %% slip 

synword(tyil,          til). 
synword(tyl,           til). 
synword(type,          slags).
synword(tysen,         tusen). 
synword(tysdag,        tirsdag). 
synword(t�,            til).         %% ? dial 
synword(t�k,           tar).  
synword(t�l,           til). 
synword(t�ll,          til).  
synword(t�r,             vil). 
synword(t�rr,            vil). 
synword(t�,            ta).  
synword(t�,            av).   %% Dial
synword(t�g,           tog).            %% SWE
% synword(t�get,         jernbanestasjonen). 
synword(t�r,           tar). 


%%� synword(u 

synword(u,du).         %% har u en tier
%% synword(uansett,       []). %% reduntant0
%% synword(uansett,        i). %% ? uansett v�r
synword(uavbrudt,       []).  %% not redundant
synword(uavbrutt,       []).  %% not redundant

synword(ud,            du). 
synword(ud,            ut). 
synword(uendelig,      []). 
synword(ubss,          buss). 
% synword(ufost�elig,    uforst�elig).  %%   Dont invite
synword(uforst�lig,    uforst�elig).    %% acceptable
% synword(uforst�lige,   uforst�elige). %%
synword(uforstayelig,  uforst�elig).  
synword(uforst�eleig,  uforst�elig).  
synword(ufra,          fra).            %% (u(t))fra
synword(uil,           til).            %%  neibk
synword(ukenr,         ukenummer). 
synword(umiddelbart,   n�).
synword(umiulig,       umulig).         %% ? 
synword(ummer,         nummer). 
synword(universitet,   universitetet).
synword(unna,          fra).  
synword(unnagjort,     gjort). 
synword(unner,         under).  
synword(unsjyld,       unnskyld).
synword(unskyld,       unnskyld). 
synword(untatt,        unntatt). 
synword(uss,           buss). 
synword(ussb,          buss). 
synword(ussen,         bussen).
synword(utafor,        utenfor). 
synword(utaf�r,        utenfor). 
synword(utanfor,       utenfor).  
   synword(utaf�rsj,        utenfor).  %%  ?
%% synword(utbrede,       utbedre). %% utbre
synword(utenifra,      inn). 
synword(utenfra,       inn).  

%% synword(utenforst�ende,personer). %% rough %% TA-110622
synword(utenforst�ende,ekstern).

synword(utfor,         fra). %% outfrom?
synword(utfordrende,   []).  %% veldig ? 
synword(utf�r,         fra). %% 
synword(utgj�r,        blir). 
synword(uti,           i). 
synword(util,          i). 
synword(utti,          i).  
synword(utmed,         ved). 
synword(utmerket,      bra).
%% synword(utover,        senere).
 
%% synword(utover,       []). %% adv

synword(utover,        utenfor). 

synword(utp�,          p�). 
synword(ut�ver,        utover). %% spiw 

%% synword(v  


synword('va|r',        v�r).   
synword('va|re',       v�re). 
synword('va|rt',       v�rt). 

synword(va,            hva).
synword(va,            var).    %%  Dialect
%% synword(va,            ta).  %% ? haz HVA 

synword(vad,           hva). 
synword(vae,           v�re). 
synword(vaer,          v�re).   %% more probable (dial)
%% synword(vaere,         v�re). %% split
synword(vaert,         v�rt).  
synword(vaeret,        v�ret). 
synword(vanig,         vanlig). 
synword(vanli,         vanlig).  
%% synword(vanlig,        []). 

synword(vanligfe,      vanlige).
synword(vanvittig,     meget).          %% (- bra)
 
%% synword(var,           v�re).  %% Dial? Doesnt help
%% synword(var,           hvor).  %% Swedish  %% Haz

synword(vara,          v�re).           %% Swe
synword(vare,          v�re).     %% Hazard (sp) 
synword(varf�r,        hvorfor).
synword(varsl,         varsel).   
synword(varske,        varsle).  
synword(vart,          hvor).      %%  also blei NN
synword(vasrle,        varsle).   %% own
synword(va�r,          v�r).      %% � tr�bbel

synword(vbuss,         buss).     %%  slip
synword(vbussen,       bussen).   %% 
synword(vbusser,       busser).   %% 

%% synword(v,ved).          %%  Hazardous /vei

synword(ve,            ved).  
synword(veckor,        uker).           %% Swe 
synword(vede,          ved).  
synword(vedl,          ved). 

% synword(ve,            ved). 
% synword(ve,            vei).
% synword(ve,            vet). 


synword(vedkommende,   personen). 

/*
synword(vedkommende,   han). % obje ham           %%   (han,hun, "hen")
synword(vedkommende,   hun). 
*/

synword(vedr,          ang�ende). %% = "om" = past ??? %% TA-110429 
synword(vedr�rende,    ang�ende). %%

synword(vef,           ved). %% own, neib k 
synword(veh,           veg). %% neib k  
synword(veh,           vei). %% neib k + syn %%
%%%  synword(veg,        retning).   %% ikke vegen * noifoabout direction *
%%%  synword(vei,        retning).   %% ikke veien
synword(veinen,        veien). 
synword(vey,           veg).  
synword(vey,           vei).            %% 
%% synword(ve,            vil).            %%   Dialect Hazard ???
synword(vekk,          bort).  
synword(vel,           []).    %%  istedet for noisew
synword(vell,          []). 
synword(v�are,         v�re).
synword(v�ll,          []).    %% dial 
%% synword(v��re,         v�re). %% verb_form 
synword(vem,           hvem). 
synword(veed,          ved).  
%% synword(ver,           var). %% ?
synword(ver,           hver).
synword(verda,         verden). %% NN
%% synword(verdt,         godt). %% ? 
synword(versegod,      v�rs�god).  
synword(versjom,       versjon).      %% own
synword(vesrjon,       versjon).      %% own
synword(verst,         d�rlig).
synword(ve�re,         v�re).  
%%%%%% synword(vera,          v�re).  %% Hva er problemet ?
%%%%%% synword(vere,          v�re).  %%
synword(verre,          v�re).        %% Dial
synword(vert,           v�rt).
% synword(vestover,      vest). 
synword(vess,          hvis). 
synword(vestsia,         vest). 
synword(vestsida,        vest).
synword(vestsiden,       vest). 


%% synword(vet,             ved). %%  Hazard

synword(vett,          vet). 



synword(veitt,         vet).

synword(vfra,          fra). 
% synword(vg,          vennligst).  
synword(vh,            hilsen). 
synword(vha,           hva).  
synword(vhem,          hvem). 
synword(vhvilke,       hvilke). 
synword(vhvilken,      hvilken). 
synword(vhvilken,      hvilken). 
synword(vhis,          hvis). 
synword(vhilke,        hvilke). 

synword(vhor,          hvor). 
synword(vhordan,       hvordan). 
synword(vhvordan,      hvordan). 

synword(vi,            we).  %%  <--- NB  %% I and tuc | I and Tom
%% synword(vi,            jeg).  %% suspended

synword(viul,          vil). %% own 

% synword(vi,            via).       %% Hazard/Nohelp

synword(vid,           ved).         %%  (swe)
synword(vide,          vite).        %%  (dk)
synword(vider,         videre). 
synword(videre,        []).  %% et videre samarbeide 
synword(viderereisen,  reisen). %% .. videre %% rough

synword(viken,         hvilken). 
synword(vilen,         hvilken). 
synword(vili,          vil).

%%%%%%% synword(vill,          gal). %% Voll %% TA-101116// nohelp
%%%%%%% synword(vill,          vil). 

synword(ville,         vil). 
synword(vilja,         ville). 
synword(vilje,         ville). 
synword(vilka,         hvilke).         %%  (SWE)
synword(vilke,         hvilke). 
synword(vilken,        hvilken).
synword(vilket,        hvilket). 
synword(villke,        hvilke). 
synword(villken,       hvilken). 
synword(villket,       hvilket). 
synword(vil�,          vil). 
synword(vinterrutr,   vinterruter). %% own
synword(sommerrutr,   sommerruter).


synword(viol,          vil).       %% slip
%% synword(vis,           via).    %% Hazardous Ambiguity
   synword(virkelig,      []). %% meget). %% -> gradv %%  %% .. flink
   synword(verkeleg,[]). %%   meget).  %% 

synword(vis,           hvis).  %% 
synword(viss,          hvis).  
synword(visst,         hvis). 
synword(vist,          hvis).  %% haz? 

synword(vi�,           vil).  
synword(vl,            vil). 
synword(vli,           bli). %% own 
synword(vli,           vil). %%
synword(vneste,        neste). %% slip 
synword(vn�r,          n�r).   %% slip 
synword(vofor,         hvorfor).
synword(voldsomt,      veldig).
%% synword(vor,           for).  %% neib %% // shadows hvo
synword(vor,           hvor). 
synword(vordan,        hvordan). 
synword(vorfor,        hvorfor). 
synword(vorrfor,       hvorfor).  
synword(vortid,        n�r). 
synword(vra,           fra). 
synword(vre,           v�re).   
synword(vri,           vei).      %% own sp
synword(vr�re,         v�re).  

%% synword(vta,           ta). %% TA-110426
synword(vtil,          til).  

synword(vul,           vil).  %% own
synword(vus,           buss).
synword(vuss,          buss).  
synword(vussen,        bussen). 
synword(vusser,        busser). 
synword(vva,           hva).   
synword(vved,            ved).  
synword(vv�re,         v�re). 
synword(v�,            v�re).  
synword(v�e,           v�re).  
synword(v�er,          v�re). 
synword(v�ere,         v�re).  
synword(v��re,         v�re).  
synword(v�l,           vel).  
synword(v�la,          verden). 
synword(v�rd,          v�re).  
synword(v�red,         v�re).  
%%  synword(v�rei,         til).      %% rough 
%%  synword(v�reved,       passere).  %% ad hoc, splitword 
synword(v�ri,          v�rt).   
synword(v�rra,         v�re). 
synword(v�rre,         v�re).  
synword(v�rst,         d�rlig).
synword(v�rt,          hvert). %% ?
synword(v�te,          v�re).  
synword(v�re,          v�re).  
synword(v�ri,          v�rt). 
synword(v�e,           v�r).  
synword(v�ksen,        voksen). 
synword(v�r,           min). 
synword(v�re,          mine).  
%% synword(v�re,          v�re).    %% Haz %% Busene v�re g�r 

synword(v�rjevnd�gn,   vernal_equinox).    %% Must be Eng.
synword(v�rgjevnd�gn,  vernal_equinox).    %% sp. Must be Eng. 

synword(sommersolverv,summer_solstice). 
synword(vintersolverv,winter_solstice). 

synword(v�rres,        min).     %% ind
synword(v�rr�,         v�re).  
synword(v�rt,          mitt). 

%%� synword(w 


synword(wc,            toalett).    %% er det wc p� bussen 
synword(wer,           er).     %% own 
synword(wha,           hva).    %%  what->...
synword(whem,          hvem).  
synword(whvilken,      hvilken).
synword(wrrwe,         etter).  %% Freak , multiple neibour keys 
synword(wskal,         skal). 
synword(wtter,         etter). 
synword(wttwr,         etter).  %% own

%%� synword(y 

synword(ya,            ta). 
synword(yay,           jeg).  %% :-) 
synword(yil,           til). 
synword(yit,           hit). 
synword(yngre,         unge). %% unge = barn
synword(yngst,         ung).  %% rough 

synword(yo,            ja). % ? 
synword(yolv,          tolv).  
synword(yo�,           til). %% trippel slip 
synword(ypperlig,      bra). %% ! (ogs� adj) 
synword(ytil,          til).
synword(zom,           som). %% :-)

% synword(y2k,           2000).           %%  not clock

%%� synword(�

synword(ae,            jeg).  
synword(aen,           annen).  %% dial
synword(aer,           er).     %%  own
synword(�,             jeg).   
synword(�bruker,       bruker).   %% ? 
%% synword(�,             �).     %%  // destroys jeg 
synword(�g,            jeg). 
synword(�nkelte,       enkelte). 
synword(�r,            er).  
%% synword(�re,           v�re).   %% \+ confuse V�re station 
synword(�rmeste,       n�rmeste). 
synword(�tte,          etter). 
synword(�tter,         etter).    %% dial.
%% synword(�vre,          v�re).  
synword(�vre,         �vre). %% jakobsli   %%

%%� synword(�

% synword(�,1).   %% Neib key  1 |
% synword(�4,14). %% Neib key|  ETC

synword(�kseskaft,     hei).          %%  :-)
synword(�nser,         �nsker).  
% synword(�stover,       �st). 

synword(�yeblikkelig,  n�). 

%%synword(� 

% synword(�,             og).     %%  HAZARD, Nofunk
synword(�ffer,         hvorfor). 
synword(�fte,          ofte).  
synword(�gr,           g�r). 
synword(�henn,         hvor). 
synword(�ja,           ja).  
synword(�jo,           ja). 
synword(�joda,         ja).  
synword(�kken,         hvem). 
synword(�kken,         hvilken). 
synword(�lts�,         alts�).   %%  (doesnt help)
synword(�m,            m�).   
synword(�nr,           n�r).   
synword(�p,            p�). 
%% synword(�r,            g�r).     %% ? SUSPENDED
%% synword(�r,            n�r).     %% Haz 
synword(�rk,           orker). %% dial 
synword(�ssen,         hvordan). 
synword(�ssn,          hvordan). 
synword(�ss�,          ogs�).   
synword(�t,            til).     %%   Sw 
synword(�te,           �tte). 
synword(�ver,          over).  
synword(�y,            �).       %% å
synword(�ytte,         �tte).    %% åtte 
synword(��stre,        �stre).   %% østre berg
synword(��,            p�).  %% neib 
synword(��,            �).   
synword(���,           �). 
synword(����,          �). 

% Buss-slang
synword(toa,           2).
synword(toer,          2).
%% synword(toern,         2). %% not 2 o'clock 
synword(toerne,        2). 
synword(toeren,        2).
synword(trea,          3).
synword(tree,          3). 
synword(treer,         3).
synword(treern,        3).
synword(treeren,       3).
synword(treerne,       3).
synword(fira,          4).
synword(firer,         4).
synword(firern,        4).
synword(fireren,       4).
synword(firerne,       4).  
synword(femer,         5). 
synword(femern,        5).  
synword(femm,          5). 
synword(femma,         5).
synword(femt,          femte).
synword(femmer,        5). 
synword(femmern,       5).
synword(femmerne,      5).
synword(femmeren,      5).
synword(f�mma,         5). 
synword(f�mmeren,      5). 
synword(f�mmern,       5). 

synword(sekd,          6). 
synword(seksa,         6).
synword(sekse,         6).
synword(sekser,        6). 
synword(seksern,       6).
synword(sekseren,      6).
synword(sekserne,      6). 
synword(sjua,          7).
% synword(sjue,          7). %% tjue?
synword(sjuer,         7).
synword(sjuern,        7).
synword(sjueren,       7).
synword(sjuerne,       7).
synword(syva,          7).
synword(syvern,        7).
synword(syveren,       7).
synword(�tta,          8).
synword(�tte,          8).
synword(�ttene,        �ttende).  
synword(�tter,         8). 
synword(�ttern,        8).
synword(�tteren,       8).
synword(�tterne,       8). 
synword(�ttte,         8).
synword(ni,            9). %%  as a bus
synword(nia,           9).
synword(nie,           9). %% ?
synword(nier,          9).
synword(niern,         9).
synword(nieren,        9).
synword(nierne,        9). %%  etc ed nauseam
synword(ti,           10). %% as a bus


% synword(nierbuss,      9). %%  etc. ad. nauseam
% synword(nierbusser,    9).

%% synword(tier,          10). %% en tier = 1 10 = 1.10
synword(tieren,        10).

synword(toerne,2). 
synword(treerne,3).
synword(firerne,4).
synword(femerne,5).
synword(sekserne,6).
synword(sjuerne,7).
synword(�tterne,8).
synword(nierne,9).
synword(tierne,10). % ... osv

%% etc etc
synword('17oo',1700). 
%% etc etc
synword('20tida',2000). %% etc. etc. 

synword(  ettia,1300). 
synword(  ettida,1300). %% etc etc
   synword(  etttida,1300). 
synword( etttiden,1300).
synword(  totia, 1400). 
synword(  totida,1400).
synword(  totiden,1400).
synword( tretia, 1500).
synword( tretida,1500).
synword( tretiden,1500).
synword(firetia,1600).
synword(firetida,1600).
synword(firetiden,1600).
synword( femtiaa,1700).
synword( femtida,1700).
synword( femtiden,1700). % By Def, no ordinary buses that early

synword(sekstia, 1800).  
synword(sekstida,1800).  %% 1800 more probable than 0600 
synword(sekstiden,  1800).

synword( sjutia, 0700). % OK ?
synword( sjutida,0700). % OK ?
synword(sjutiden,0700).
synword( syvtia, 0700). 
synword( syvtida,0700). % OK ?
synword( syvtiden,  0700).
synword(�ttetia, 0800).
synword(�ttetida,0800).
synword(�ttetiden,  0800).
synword(  nitia,0900).
synword(  nitida,0900).
synword(  nitiden,  0900).
synword(  titia ,  1000).
synword(  titida ,  1000).
synword(  titiden,  1000).
synword(elvetia,1100).
synword(elvetida,1100).
synword(elvetiden,  1100).
synword(ellvetiden, 1100).  
synword(ellevetida, 1100). 
synword(ellevetiden,1100). 
synword(tolvtia,1200).
synword(tolvtida,1200).
synword(tolvtiden,  1200).
synword(trettentia,1300).
synword(trettentida,1300).
synword(trettentiden,1300).
synword(fjortentia,1400).
synword(fjortentida,1400).
synword(fjortentiden,1400).
synword(femtentia,1500).
synword(femtentida,1500).
synword(femtentiden,1500).
synword(sekstentia,1600).
synword(sekstentida,1600).
synword(sekstentiden,1600).
synword(syti,70). 
synword(syttentia,1700).
synword(syttentida,1700).
synword(syttentiden,1700).
synword(s�tende,syttende).
synword(s�ttentia,1700).
synword(s�ttentida,1700).
synword(s�ttentiden,1700).
synword(attentia,1800).
synword(attentida,1800).
synword(attentiden,1800).
synword(nittentia,1900). %% ... 
synword(nittentida,1900).
synword(nittentiden,1900).
%-

synword(l�rdagskj�ring,l�rdagsrute).  
synword(s�ndagskj�ring,s�ndagsrute). 
synword(s�mdagskj�ring,s�ndagsrute).  %% own 


synword(tolevte, tolvte).
synword(tolfte,  tolvte).
synword(tollevte,tolvte).
synword(tollvte, tolvte).
synword(tolvde,  tolvte).
synword(tolvete, tolvte).
synword(t�llte,  tolvte).
synword(t�lvte,  tolvte).
%% etc etc :-)


%%%%  synword(Fire,_4):-numerid(Fire,_4). %% 4=fourth ?

%% synword('*',ganger). 
synword('0g',og). %% 
synx1word(-,til).                        %% EXPERIMENT
synword(&,og).    
%% synword(+,og).     %% Hva er 2+2
%% synword(pluss,og). 
%% synword(plus,og). 


/*  NB    12:10pm  Outdated (split NA)

synword( '1pm',1300). 
synword( '2pm',1400).
synword( '3pm',1500). 
synword( '4pm',1600).
synword( '5pm',1700).
synword( '6pm',1800).
synword( '7pm',1900).
synword( '8pm',2000).
synword( '9pm',2100).
synword('10pm',2200).
synword('11pm',2300).
synword('12pm',2400).

*/

%% Not captured by spell corr because they are nouns and not names.

%%% ODD TIMES  ( synword norsk -> norsk ??? )






synword(ami,may). 
synword(aapril,april).  
synword(febr,february).    
synword(februari,february). %% SW 

%% synword(jan,kan).  %%   own sp ?

synword(jan,january) :- 
    \+ user:myflags(telebusterflag,true),
    \+ user:myflags(daterflag,true).

synword(feb,february).
synword(mar,march).
synword(apr,april).
synword(aprin,april).  
synword(spr,april). %% ? 
% synword(mai,may). %unnec
synword(maj,may). %% Name: E
synword(mau,may). 
synword(jun,june).
synword(uni,june). 
%% synword(jul,july). %% sorry, christmas %% confuse %% Delib %% TA-110724
synword(aug,august).
synword(sept,september). synword(sep,september).
synword(okt,october).
synword(nov,november).
synword(des,december).

synword(septemer,september). 
synword(setember,september). 
synword(septrmber,september). %%  own

synword(jaunar,january). 
synword(januar,january).
synword(februar,february).
synword(mar,n�r). %% synsms haz ?
synword(mars,march). %% Eng. names
   synword(april,april).
synword(mai,may).
synword(juni,june).
synword(junig,june).  
synword(juli,july).
synword(august,august).
   synword(september,september).
synword(septemper,september). 
synword(oktober,october).
   synword(november,november).
synword(deesember,december). 
synword(desember,december).
synword(deseber,december). 
synword(desemeber,december).
synword(disember,december).

%% ODD DAYS
synword(tirrsdag,tirsdag). 
synword(tirsdagf,tirsdag). 
synword(l�radag,l�rdag). 
synword(l�trdag,l�rdag).   %% own 
synword(onsadag,  onsdag).
synword(onsdak,  onsdag). 

synword(tirstag, onsdag). 
synword(onstag, onsdag).  
synword(torstag, onsdag). 

synword(l�srdag, l�rdag).  
synword(l�ndag , l�rdag). 
synword(masndag,mandag). 
synword(l�lrdag, l�rdag).     
synword(fedag,fredag). 
synword(�rdag, l�rdag).  
synword(s�ndasg,s�ndag). 
synword(s�ndaag,s�ndag).   
synword(l�nsdag,l�rdag).  
synword(l�rdagenne,l�rdag).
synword(gredag,fredag). 
synword(manddag,mandag). 
synword(mandeg,mandag). 
synword(tordager,torsdag).
synword(mandah,mandag). 
synword(tirsdah,tirsdag). 
synword(ondagen,onsdag).   
synword(onsdah,onsdag). 
synword(torsdah,torsdag). 
synword(fredah,fredag).   
synword(freedag,fredag).  
synword(layrdag,l�rdag).  
synword(l�rdah,l�rdag). 
synword(s�ndah,s�ndag). 
synword(s�nsdag,s�ndag). 

synword(fred,fredag). %% <------- ???


synword(manedag,mandag).   

synword(fredagt,fredag). 
synword(frdager,fredag). 
synword(maandag,mandag). 
synword(s�dags ,s�ndag).

synword(lrdag,l�rdag).   
synword(l�ragene,l�rdag). 
synword(l�rager,l�rdag). 
synword(l�rdadag,l�rdag).
synword(l�rdak,l�rdag). 
synword(l�rdal,l�rdag). 
synword(l�rdsag,l�rdag).  
synword(l�rdsg,l�rdag). 
synword(l�rgad,l�rdag). 
synword(l�rgad,l�rdag). 

synword(s��ndag,s�ndag).  %% søndag  
synword(l��rdag,l�dag).   %% lørdag 
synword(l�rrdag, l�rdag).
synword(l�rdaag, l�rdag).

synword(s�mdag,s�ndag). 
synword(magndag,mandag).  
synword(manndag,mandag).  
synword(mondag, mandag).  
synword(tosdag, torsdag). 
synword(torstag, torsdag).
synword(s�nndag,s�ndag). 
synword(s�ndad,s�ndag).  


synword(mansag, mandag). 
synword(msndag, mandag).  
    synword(m�nsag, mandag). %% spell
synword(tirsag, tirsdag).    %% ...
synword(onsag,  onsdag). 
synword(onsfag, onsdag).
synword(torsag, torsdag). 
synword(fresag, fredag). 
synword(l�rsag, l�rdag). 
synword(s�nsag, s�ndag).  

synword(l�rsaf, l�rdag). 

synword(mandags, mandag).  
    synword(m�ndags, mandag). 
synword(tirsdags,tirsdag).  
synword(onsdags, onsdag). 
synword(onsdsag, onsdag). 
synword(torsdags,torsdag). 
synword(fredags, fredag). 
synword(l�rdags, l�rdag). 
synword(s�ndags, s�ndag).  


synword(mandagg, mandag). 
synword(tirsdagg,tirsdag).  
synword(onsdagg, onsdag). 
synword(torsdagg,torsdag). 
synword(fredagg, fredag). 
synword(l�rdagg, l�rdag). 
synword(s�ndagg, s�ndag).  

synword(mandas, mandag). 
synword(tirsdas,tirsdag).  
synword(onsdas, onsdag). 
synword(torsdas,torsdag). 
synword(fredas, fredag). 
synword(l�rdas, l�rdag). 
synword(s�ndas, s�ndag).  



synword(mandagan, mandag). %%  Dialect 
synword(tirsdagan,tirsdag).  
synword(onsdagan, onsdag). 
synword(torsdagan,torsdag). 
synword(fredagan, fredag). 
synword(l�rdagan, l�rdag). 
synword(s�ndagan, s�ndag).  

synword(mandage, mandag). %%   Danish
synword(tirsdage,tirsdag).  
synword(onsdage, onsdag). 
synword(torsdage,torsdag). 
synword(fredage, fredag). 
synword(l�rdage, l�rdag). 
synword(s�ndage, s�ndag).  


synword(manda, mandag). 
synword(tirsda,tirsdag).  
synword(onsda, onsdag). 
synword(torsda,torsdag). 
synword(freda, fredag). 
synword(l�rda, l�rdag). 
synword(s�nda, s�ndag).  

synword(mandaf, mandag). 
synword(tirsdaf,tirsdag).  
synword(onsdaf, onsdag). 
synword(torsdaf,torsdag). 
synword(fredaf, fredag). 
synword(l�rdaf, l�rdag). 
synword(s�ndaf, s�ndag).  

synword(mandafg, mandag). 
synword(tirsdafg,tirsdag). 
synword(onsdafg, onsdag).  
synword(torsdafg,torsdag). 
synword(fredafg, fredag). 
synword(l�rdafg, l�rdag). 
synword(s�ndafg, s�ndag).  


synword(mandan, mandag).  
synword(tirsdan,tirsdag).  
synword(onsdan, onsdag). 
synword(torsdan,torsdag). 
synword(fredan, fredag). 
synword(l�rdan, l�rdag). 
synword(s�ndan, s�ndag).  

synword(mandg, mandag).
synword(tirsdg,tirsdag).  
synword(onsdg, onsdag). 
synword(torsdg,torsdag). 
synword(fredg, fredag). 
synword(l�rdg, l�rdag). 
synword(s�ndg, s�ndag).  

synword(mandga, mandag). 
synword(tirsdga,tirsdag).  
synword(onsdga, onsdag). 
synword(torsdga,torsdag). 
synword(fredga, fredag). 
synword(l�rdga, l�rdag). 
synword(s�ndga, s�ndag).  

synword(madag, mandag). 
synword(tidag,tirsdag).  
synword(ondag, onsdag). 
synword(todag,torsdag). 
synword(frdag, fredag). 
synword(fredga, fredag). 
synword(fredafa, fredag). 
synword(fredat, fredag). 
% synword(l�dag, l�rdag). 
synword(l�rsdag, l�rdag).
synword(s�dag, s�ndag).  
synword(tirddag,tirsdag). 
synword(tirdsdag,tirsdag). %% own


synword(madnag, mandag).  
synword(tirdsag,tirsdag). 
synword(ondsag, onsdag). 
synword(tordsag,torsdag). 
synword(freadg, fredag). 
synword(l�drag, l�rdag). 
synword(s�dnag, s�ndag).  



synword(manag, mandag).  
synword(tirsag,tirsdag). 
synword(onsag, onsdag). 
synword(torsag,torsdag). 
synword(freag, fredag). 
synword(l�rag, l�rdag). 
synword(s�nag, s�ndag).  


synword(manadg, mandag). 
synword(tirsadg,tirsdag). 
synword(onsadg, onsdag). 
synword(torsadg,torsdag). 
synword(freadg, fredag). 
synword(l�radg, l�rdag). 
synword(s�nadg, s�ndag).  


synword(managd, mandag). 
synword(tirsagd,tirsdag). 
synword(onsagd, onsdag). 
synword(torsagd,torsdag). 
synword(freagd, fredag). 
synword(l�ragd, l�rdag). 
synword(s�nagd, s�ndag).  



synword(manday, mandag). 
synword(tirsday,tirsdag).  
synword(onsday, onsdag). 
synword(torsday,torsdag). 
synword(freday, fredag).  
synword(l�rday, l�rdag). 
synword(s�nday, s�ndag).  



synword(mand, mandag). 
synword(tirsd,tirsdag).  
synword(onsd, onsdag). 
synword(torsd,torsdag). 
%% synword(fred, fredag). %% hva er fred -> Dag  peace 
synword(l�rd, l�rdag). 
synword(s�nd, s�ndag).  


%% synword(man, mandag). %%  collides with man=en
synword(tir,tirsdag).  
synword(tirs,tirsdag).  
synword(ons, onsdag).
synword(toradag,torsdag).
%% synword(tor,torsdag). %% Jeg heter tor ??? 
%%%%  synword(tors,torsdag).   %% tors veg ???
synword(fre, fra).       %%  Doesnt work (fre=fredag)
synword(fre, fredag).    %% - fre= fra  Hazard  
synword(l�r, l�rdag). 
synword(s�n, s�ndag).  

synword(fr, fra).  %% Fredag ? 
synword(fradag,fredag). 
synword(fredad,fredag). 
synword(fredasg,fredag). 
synword(freddag,fredag).   %%  own sp

synword(tiersdag,tirsdag). 
synword(tirsdal,tirsdag).  %% actual
synword(tisdag,tirsdag). 
synword(tirsadg,tirsdag).
synword(tirsdsag,tirsdag). 
synword(tisrdag,tirsdag). 
synword(tisrdage,tirsdag). 

synword(la�rdag,l�rdag). 
synword(la�rdagen,l�rdag). 
synword(la�rdager,l�rdag). 
synword(la�rdagene,l�rdag). 
synword(l�rsdags,l�rdag).

synword(sandag,s�ndag).  %%  ?
synword(s�dag,s�ndag). 
synword(s�dager,s�ndager).
synword(sa�ndag ,s�ndag).   %% søndag?
synword(sa�ndagen ,s�ndag). %% søndag?
synword(sa�ndager ,s�ndag). %%

synword(mangag,mandag). 
synword(mnadag,mandag).  
synword(magndag,mandag).  
synword(m�ndag,mandag).  


synword(sa�r,          s�r).  
synword(aprol,         april).  
synword(autgust,       august).      
synword(frbruar,       february).  
synword(desebmer,      december).  
synword(desmeber,      december).     %% Name = English
synword(desmember,     december). 
synword(desmber,       december).   
synword(dessa,         disse).        %% SV
synword(dessember,     december). 
synword(freadag,       fredag). 
synword(fraedgar,      fredag).  
synword(freadg,        fredag). 
synword(fredig,        fredag). 
synword(ferbruaur,     february ). 
synword(ferbruar,      february ).    %% Name = English
synword(kl�kken,       klokken).   
synword(kl�okka,       klokken). 
synword(kl�rdag,       l�rdag).       %% neib k 

synword(lordag,        l�rdag).  
synword(lordagsrute,   l�rdagsrute). 
synword(lordagan,      l�rdag).       %% smtotfl
synword(loerdag,       l�rdag). 
synword(loerdagen,     l�rdag). 
synword(loerdager,     l�rdag). 
synword(loerdags,      l�rdag). 

synword(l�rdag,l�rdag). 
synword(l�prdag,l�rdag). 
synword(l�rag,l�rdag).  
synword(l�radg,l�rdag). 
synword(l�radger,l�rdag). 
synword(l�rdad,l�rdag). 
synword(l�redag,l�rdag). 
synword(l�rgag,l�rdag). 
synword(l�darg,l�rdag).  
synword(l�drag,l�rdag).  
synword(l�rdeg,l�rdag).  
synword(mamdag,mandag).  

synword(novemeber,november). %% // Name = English
synword(novemer,november).  
synword(novenber,november). 

synword(onadag,onsdag).    

synword(onsdadg,onsdag). 
synword(onsndag,onsdag). 
synword(s�andag,s�ndag).  
synword(s�andager,s�ndag). 
synword(s�mndag,s�ndag).     %% own
synword(s�nmdag,s�ndag).     %% own
synword(tirdag,tirsdag).  
synword(tirsadag,tirsdag).  
synword(torsdad,torsdag). 
synword(tordag,torsdag). 
synword(trosdag,torsdag).  
synword(redag,fredag).  


synword(torsdagsmordgen,torsdag). %%  ? 


%% Experiment, remove hazardous entries 

synword(gaate,gate). 
synword(gade,gate).  
synword(gaden,gate). 
synword(gat,gate). 
synword(gata,gate).
synword(gatan,gate). 
synword(gate,gate).
synword(gaten,gate).
synword(gatene,gate). 
synword(gater,gate).  
synword(gats,gate). 
synword(gave,gate). 
synword(geven,gate). 
synword(gt,gate).
synword(gta,gate). 
synword(gtate,gate). 
synword(gte,gate). 
synword(gtn,gate).  
synword(gtr,gate). 
%% synword(g�te,gate). %% TA-110798 problem


synword(vente,forvente).     %% ad hoc l�sning
synword(venter,forventer).
synword(ventet,forventet).


synword(v,vei).   
synword(vag,vei).  
synword(vaien,vei). 
synword(vedi,vei).   
synword(vegdn,vei).  
synword(veeien,vei).
synword(veein,vei). 
synword(veen,vei).  
synword(vef,vei). 
synword(veg,vei).
synword(vege,vei).  
synword(vegem,vei).  
synword(vegen,vei).
synword(vegene,vei). 
synword(vegein,vei). 
synword(veger,vei). 
synword(veget,vei).  
synword(vegn,vei).  
synword(vegom,vei). 
synword(vei,vei).
synword(veid,vei).  
synword(veie,vei).   
synword(veieb,vei). 
synword(veiebn,vei).  
synword(veieen,vei). 
synword(veiein,vei). 
synword(veiem,vei). 
% synword(veien,vei). %% av veien = av vei ? 
synword(veienen,vei). 
synword(veienn,vei).
synword(veiene,vei).  
synword(veig,vei).  
synword(veigen,vei).  
synword(veil,vei).   
synword(vein,vei).  
synword(veine,vei).  
synword(veinen,vei). 
synword(veiene,vei). 
synword(veier,vei). 
synword(veis,vei). 
synword(veio,vei). 
synword(veit,vei). 
synword(veiu,vei).  
synword(vej,vei). 
synword(veneien,vei).
synword(venein,vei). 
synword(venien,vei). 
synword(veo,vei).  
synword(veu,vei).   
synword(vey,vei). 
synword(vg,vei).
synword(vgn,vei).  
synword(vgen,vei).  
synword(vien,vei). 
synword(vig,vei).  
synword(vn,vei).
synword(vrg,vei). 
synword(vweien,vei).
synword(v�g,vei). 
synword(v�gen,vei).   

synword(veg,vei). %% Ad Hoc (Brit Grytbakks vei) 

% synword(g,gate).  %% Experiment g streetsyn, but vollg hazard
                    %%  N�r g�r bussen  etter kl 20.00.G. // G \+ street

synword(vei,veg). %%  KarlJohnsons vei."

%------------------------------------------------------------------


synword(TLF, telefonnummer):-   %% nr 6 -> telefonnummeret 6 // Bare tele
    user:myflags(teleflag,true),  %% ret -> r
    tlf(TLF).  


synword(TLF, telefonnummer):-      %% nr 6 -> telefonnummeret 6 // Bare tele
    \+ user:myflags(teleflag,true),  %% ret -> r
    \+ user:testmember(TLF,[nr,nummer,nummeret]), %% ad hoc (BUS no) 
    tlf(TLF).  



%---------------------------------------------------------

%%% ADVERBS  

%% additional adverbs with 1 english translation

adv2(redundant0,redundantly). %% Techn., redundant adverb expression

adv2(allikevel, redundantly). 
adv2(alltid,redundantly).      %%  rough, always 
adv2(antakelig, redundantly). 
adv2(atter,     redundantly). 
adv2(automatisk,automatically).
%% adv2(bak,behind).           %% Haz ?
adv2(bare, redundantly).       %% haz? bare ikke| ikke bare
adv2(bedre, well).             %% rough
adv2(billig,cheaply).  
adv2(bra, well).   
adv2(da,now).                  %%  ?? then 
adv2(daglig,redundantly).      %% TA-100828
adv2(dermed, redundantly). 
adv2(derimot, redundantly).  
adv2(dessuten, redundantly). 
adv2(dessverre, redundantly).
%%  adv2(direkte, directly).   %% SUSPENDED TEST en direkte forbindelse
adv2(dog, redundantly). 
adv2(d�rlig, badly).           %% 
adv2(egentlig,redundantly).  
adv2(enn�,redundantly). 
adv2(erfaringsmessig,redundantly).  
adv2(ergo,redundantly).  
adv2(etterp�,thereafter).
adv2(fast,redundantly).        %% satt seg fast 
adv2(generelt, redundantly).   %% TA-110607
%%%              adv2(feil,wrongly).            %% trouble test 

adv2(forel�pig, redundantly). 
adv2(forh�pentligvis, redundantly). %% TA-110701
adv2(forsinket, delayed). 

adv2(forskjellig,differently). %% TA-110808  
adv2(ulikt,differently).       %% 

adv2(fort,fast).               %% faster ? (context depends 
adv2(fortere,fast).            %% faster ? (context depends
adv2(forresten, redundantly). 
adv2(frekt,badly).  

     adv2(f�r,earlier).  %%  Hazard? SUSPENDED TEST for � trikk ...

adv2(galt,wrongly). 
adv2(godt, well).  
adv2(heldigvis,redundantly).  
adv2(hemmelig,secretly). 
adv2(hermed,redundantly). 
adv2(herved,redundantly). 
adv2(hjemme,at_home). 
adv2(hurtig,fast).               %% faster ? (context depends 
adv2(hvertfall,redundantly). 
adv2(ihvertfall,redundantly).  
adv2(imidlertid,redundantly). 
adv2(imorgen,tomorrow).        %% B new regime ... til imorgen
adv2(inne,inside).     
adv2(innover,inwards).         %%  to sentrum
adv2(istedenfor,redundantly).  %% also prep 

adv2(jo, redundantly).           %%
adv2(kanskje,redundantly).       %% TA-110624
adv2(klar,ready).                %% holde bill. k
adv2(kollektivt,redundantly).  
%% adv2(korrekt,redundantly). 
adv2(korrekt,correctly).   
adv2(kontinuerlig,redundantly). 

adv2(langsomt,slowly).           
adv2(langsommere,slowly).        %% slowlier (context depends)

adv2(lenger,longer).             %%  enn 12 sekunder 

%% adv2(lettest,redundantly).   %% TA-110510 hvoe er det lettest �
adv2(likevel, redundantly).  
adv2(lite,little). 
adv2(manuelt,manually). 
adv2(mer,more). 
adv2(merkelig, badly).           %%  rough
adv2(milj�vennlig,redundantly).  %% ? kj�re m..
adv2(muligens,redundantly). 
adv2(mye,much).                  %%  reiste mye (suspended?)

adv2(naturligvis,redundantly).   %% redundant adverb
adv2(nedenfor, below).           %%  sp�rsm�let nedenfor
%% adv2(nemlig,redundantly).     %%  noisew
adv2(nesten,redundantly).  
adv2(nok,redundantly).   
adv2(n�rmere, hereafter).        %% vi h�res n�rmere ????
adv2(n�dvendigvis,redundantly).  %% TA-110324
adv2(n�yaktig,redundantly). 
adv2(n�ye,redundantly). 
%% adv2(naa,now).  %% = n�
adv2(n�,now).  
adv2(ofte,often).
adv2(oppe,up).   
adv2(ovenfor,above).            
adv2(permanent,redundantly).     %% ad hoc permanently

adv2(plutselig, redundantly).    %% TA-110520

adv2(rart, badly).               %% rough
adv2(raskt,fast).                %% faster ? (context depends 



adv2(riktig,correctly).       %% confuse adjektiv \\ly %% TA-110701

adv2(rundt,around).

adv2(sakte,slowly).             
adv2(saktere,slowly).            %% rough
adv2(saktest,slowly).            %% rough
adv2(sammen,together).          
adv2(samlet,redundantly).  
adv2(sannsynligvis,redundantly).
adv2(selv, redundantly).         %% TA-110107
adv2(selvstendig, redundantly).  %% TA-110128
adv2(senest,last).               %%  (= latest)
adv2(sikkert,redundantly). 

adj2(spennende,well). %% rough h�res spennende %% TA-110724

adv2(tydelig,redundantly).       %% TA-110103 Also ADJ !!!  
adv2(sist,last). 
%%%  adv2(slik,redundantly).     %%  ? bussen g�r slik som trikken
adv2(snart,redundantly).         %% ? 
adv2(stabilt,well).              %%  reliably?
adv2(s�ledes,redundantly). 
%% adv2(s�ledes,thus).              %%   slik ut|ut slik
adv2(tidligere,earlier).        
adv2(tilgjengelig,available).    %% semi adjective
adv2(tilsvarende,redundantly). 
adv2(trolig, redundantly).  
adv2(trygt,redundantly).    
adv2(tydeligvis,redundantly). 
%% adv2(uansett,redundantly).  %% .. v�r  %% TA-100828 %% (?) suspended. bussen g�r uansett om
adv2(uheldigvis,redundantly). 
adv2(uoppfordret,redundantly).  
adv2(ute,outside).       
adv2(utover,outwards).           %% from sentrum
adv2(vanligvis, redundantly).    %%  som v..    
adv2(videre, redundantly).       %%
%%  adv2(virkelig, redundantly).   %% not initially
adv2(visst, redundantly). 
adv2(�rlig,honestly).   
%% adv2(�pent,openly).           %% Not really necessary har LingIT �pen



%%% ADJECTIVES 

adjective2(ON,OE) :- ordinal2(ON,OE,_).  %%  <-- NB  %% niende NOT adjective 
 
%% PROBLEM:    first bus nr 7  = determiner+name_phrase *****

%% Adjectival participles 

/* SUSPENDED skrevet = adjektiv skrevet

adjective2(Skrevet,be/Write):- 
    \+ unwanted_adjective(Skrevet), 
    morph_n:lexv(Skrevet,Skrive,past,part),
    verbroot2(Skrive,Write),
    \+ adj2(Skrevet,_), %% e.g. svart
    user:tv_templ(Write,_,_).

*/

adjective2(X,Y):- adj2(X,Y).


adjective3(X,G,Y):- adj3(X,G,Y).

adj3(bedre,comp,good).
adj3(best,sup,good). 

adj3(enklere,comp,good).
adj3(enklest,sup,good).

adj3(flere,comp,many).       %% ? 
adj3(flest,sup,many).        %% ? 

%% adj3(f�rre,comp,few).  %% confuse quantifier 

adj3(lengre,comp,long). %% lang lengre lengst 
adj3(lengst,sup,long). 
adj3(lengste,sup,long). %% 

%% adj3(n�r,nil,near).  %% i n�rheten av = n�r SUSPENDED TEST

adj3(mindre,comp,small). 
adj3(minst,sup,small).  

adj3(n�rere,comp,near).
adj3(n�rest,sup,near).

adj3(n�rme,nil,near).
adj3(n�rmere,comp,near).
%% adj3(n�rmest,sup,near). %% -> prep 
adj3(n�rmeste,sup,near).

adj3(sen,nil,late).
adj3(senere,comp,late).
adj3(senest,sup,late).    %% ? (also f�r)

adj3(stor,nil,great).
adj3(st�rre,comp,great).
adj3(st�rst,sup,great).
adj3(st�rste,sup,great). 

adj3(tidligere,comp,early). 


%% Ordinary adjectives

adj2(aktiv,active). 
adj2(aktuell,real).  %% topical/of interest/"actual" %% rough

adj2(alene,alone). 
adj2(alkoholholdig,alcoholic).

adj2(alternativ,different).  %%  ( i.e. dummy) 

adj2(amerikansk,american).  

adj2(angitt,given).  
   adj2(oppgitt,given).   

adj2(anonym,anonymous). 
adj2(ansvarlig,responsible). %% (also NOUN!)

adj2(automatisk,automatic). 
adj2(avhengig,dependent).  


%% adj2(bare,only). %% bare norsk \== norsk %% Technical 
   %% *** da hadde de bare (???)

adj2(begrenset,limited). 

adj2(ber�mt,famous). %% TA-110301

adj2(best,best). 
    adj2(likest,best). 
    adj2(likast,best). %%
%% adj2(beste,best). %% unnec 

adj2(betalt,ordinary).    %% rough betalt billett
adj2(betalende,ordinary). %% rough ...passenger

adj2(bevisst,conscious). 
    adj2(selvbevisst,conscious). 
adj2(billig,cheap). 
   adj2(bilig,cheap). %% Sp
   adj2(rabattert,cheap). 

adj2(blid,nice). 
  %%  adj2(s�t,nice). % Facetious

adj2(borte,absent).   %% ? %% away,gone 
   adj2(vekk,absent). %%
adj2(bred,wide).
    adj2(bredbremmet,wide). %%  :-) hatt  

adj2(benyttede,used). %% ad hoc 

adj2(ekstern,external). %% TA-110622
adj2(europeisk,european).
adj2(flau,embarrassed).   %% rr

adj2(forandret,different).  %% rough 
    adj2(endret,different).

%% adj2(g 

adj2(global,global).

adj2(god,good).
    adj2(adekvat,good). 
    adj2(allright,good).
    adj2(artig,good).  
    adj2(attraktiv,good).
    adj2(avansert,good).
%%%     adj2(best,good).  %% TA-101125  %% adj2(good,sup))|adj2(best,nil))
    adj2(bra,good).  
    adj2(behagelig,good). 
    adj2(brukbar,good).  
    adj2(dyp,good). %% .. forst�else 
    adj2(effektiv,good). 
    adj2(egned,good). %% egnede 
    adj2(egnet,good). %%
    adj2(elskverdig,good). 
    adj2(fleksibel,good). 
    adj2(fin,good). 
    adj2(flott,good).      adj2(flott,good).      
    adj2(flotteste,good).  
    adj2(forsvarlig,good).      
    adj2(fornuftig,good). 
    adj2(fortreffelig,good). 
    adj2(frisk,good).       %% TA-110107
    adj2(friskmeldt,good).  %%
    adj2(fullgod,good).  

    adj2(grei,good). 
    adj2(g�y,good).            %% :-) = bra

    adj2(hensiktsmessig,good). 

    adj2(informativ,good). 
    adj2(innlagt,actual).   %% rough

    adj2(iphonevennlig,good). %% :-) %% rough 

    adj2(kjempekul,good).   %% ? 
    adj2(kjempebra,good). 
    adj2(kj�rende,current). 
    adj2(komfortabel,good). 
    adj2(komfortable,good). %% Missing Morph 
    adj2(kul,good).            %% Facetious ?
    adj2(kurant,good).      %% TA-110329
    adj2(kuul,good).          
    adj2(lekkert,good).  
    adj2(l�kkert,good).  % :-))))))
    adj2(meningsfylt,good).  %% TA-110725 rough
    adj2(meningsfyllt,good). %% spiw
 
    adj2(m�lretted,good). %%-e %% ad hoc 
    adj2(milj�vennlig,good). %% :-) rough 
    adj2(misforn�yd,dissatisfied). %%  displeased
    adj2(mobilvennlig,good). %% 
    adj2(m�lrettet,good).     %%

    adj2(nyttig,good).       adj2(n�ringsrik,good). %% :-))) 

    adj2(ok,good).      %% er det OK � ta buss
    adj2(oppe,up).      %% Haz? 
    adj2(spennende,good).
    adj2(opphissende,good). %% :-) %% TA-110426
    adj2(oppmerksom,aware). %% attentive+ 
    adj2(opptatt,busy).
    adj2(opptatt,occupied).  
    adj2(optimal,good).  
    adj2(perfekt,good).     
    adj2(popul�r,good). 
    adj2(positiv,good).     
    adj2(praktisk,good). 

    adj2(rolig,good).  %% Rough 

    adj2(saklig,good). 
    adj2(sunn,good). 
    adj2(spennende,good). 
    adj2(stilig,good). 
    adj2(str�lende,good).
    adj2(super,good). %% -> bra 
    adj2(superb,good).

    adj2(trivelig,good). %% ogs� nice 
    adj2(t�ff,good).  

    adj2(uavhengig,independent).  
         adj2(uavhenig,independent). %% own 

    adj2(underholdende,good).  
    adj2(up�klagelig,good).  

    adj2(velfortjent,good).    %% rough 
    adj2(velfungerende,good).

    adj2(ypperlig,good).  
    adj2(�nskelig,good).  %% rough 
    adj2(�lreit,good).  
    adj2(�reit,good).     %% spiw

% adj2(daglig,daily).          %%  (day_to_day)
adj2(dansk,danish). 
adj2(deprimert,depressed). 

adj2(direkte,direct). 
    adj2(overgangsfri,direct). %% TA-100905

adj2(dobbel,double).   
    adj2(doble,double). 
    adj2(duplikat,double).

adj2(dum,stupid). 
   adj2(dom,stupid).  %% som ? %% TA-101004
   adj2(domm,stupid). 
   adj2(dommere,stupid).
   adj2(dommest,stupid). 
   adj2(dumm,stupid).  %% TA-101123
   adj2(dummere,stupid).
   adj2(dummest,stupid). 
   adj2(glemsk,stupid).  
   adj2(idiotisk,stupid). 
   adj2(inkompetent,stupid). 
   adj2(lat,stupid).           %% Rough 
   adj2(spr�,stupid).          %% (roughly)
   adj2(stupid,stupid).
   adj2(s�r,stupid).  
   adj2(tilbakest�ende,stupid). %% -> forsinket :-)
%%    adj2(treg,stupid).  %% forsinket        %% \= treg = late  :-)  Jargon ( not late ???)  
%%    adj2(treig,stupid).  
   adj2(tilh�rende,true). %% ad hoc rough 
   adj2(tungnem,stupid).   
   adj2(t�pelig,stupid).  
   adj2(uintelligent,stupid). 
   adj2(uinteligent,stupid). 
   adj2(uklok,stupid).
   adj2(useri�s,stupid). 
   adj2(uvitende,stupid). 

adj2(dyr,expensive). 

adj2(d�d,dead).  %%  ikke sp�ke :-( ? 
    adj2(slettet,dead). %%  :-)

adj2(d�rlig,bad). 
    adj2(d�lig,bad).  %% sp
    adj2(elendig,bad). 
    adj2(fetende,bad).     %%  :-) 
    adj2(flertydig,bad).   %% T (Rough , ambiguous)
    adj2(forferdelig,bad). %% ogs� adverb 
    adj2(f�l,bad).
    adj2(h�pl�s,bad).
    adj2(horribel,bad).  
    adj2(ille,bad).   
    adj2(irriterende,bad). 
    adj2(komplisert,bad).
    adj2(ond,bad). 
    adj2(plagsam,bad). %% NN
    adj2(plagsom,bad). %%
    adj2(simpel,bad). 
    adj2(skral,bad).  
    adj2(slett,bad). 
    adj2(svak,bad). 
    adj2(ubrukbar,bad). 
    adj2(ubrukelig,bad).
    adj2(udugelig,bad).  
    adj2(uheldig,bad). %% rough
    adj2(ustabil,bad). 
    adj2(usund,bad).
       adj2(usunn,bad).    %% TA-110331 .. � r�yke :-) 
 
    adj2(vond,bad).   
    adj2(vondt,bad).   %% vondt adv (ok) 
    adj2(�delagt,bad).  
    adj2(�delagt,bad).     %%  :-)

adj2(edru,sober).           %%  Facetious ?? 
adj2(ekstra,extra). 
adj2(ekte,real).   
adj2(eldre,old). 
adj2(elektrisk,electric).
adj2(elektronisk,electronic). 
adj2(element�r,single). 
adj2(endret,different). 
adj2(engelsk,english).  
adj2(enig,agreed).  %%  ( Norw  Tech).  
%% adj2(enklest,fast).           %% (fastest) Adverb
adj2(evig,long). 

adj2(farlig,dangerous).  
%    adj2(skummelt,dangerous).    %% facetious ?
    adj2(utrygt,dangerous).
adj2(fast,fixed).
%% adj2(fattig,poor). 


adj2(felles,common).    
    adj2(kolletiv,common).    %% rough

adj2(ferdig,finished).

    adj2(ferdiglagde,complete).  %%  bussen er (ferdig klokken) 4
    adj2(ferdiglagede,complete). %%
    adj2(ferdiglaget,complete).  
    adj2(ferdiglagete,complete).

adj2(fersk,new).

adj2(fjern,remote).    
   adj2(avsidesliggende,remote). %%   
adj2(flink,clever). 
%%     adj2(avansert,clever). 
    adj2(behjelpelig,clever).  %% ( snill?)
    adj2(dyktig,clever). 
    adj2(enest�ende,clever).
    adj2(fantastisk,clever). %% ? facetious
    adj2(hjelpsom,clever).  
    adj2(kompetent,clever). 
    adj2(super,clever). 

adj2(fojll,drunk). %% TA-100923 // \+ full

adj2(forrige,previous). 

adj2(fortidlig,tooearly). %% Techn. 

adj2(forsinket,delayed). 
    adj2(forsein,delayed). 
    adj2(tilbakest�ende,delayed). %%  :-))
    adj2(treg,delayed). 
    adj2(treig,delayed). 

%% NB bare som preadj   NOT correct 
adj2(forskjellig,different).   % forskjellige dager ... ? 
    adj2(ulike,different).       %%  Comparator  han er ulik (henne)
    adj2(annen,different). %% NB ikke 2.
    adj2(annet,different). 
    adj2(annerledes,different). 
    adj2(anderledes,different). %% ?

%  adj2(fort,fast).                %% Adverb
adj2(fortere,faster). 
% adj2(fortest,fast).            %% (fastest) %% Kr�ll med fortest mulig

adj2(fremmed,foreign).  

adj2(fri,free).

adj2(forst�elig,comprehensible). 

adj2(fransk,french). 
adj2(frav�rende,absent).  
    adj2(bortreist,absent).


adj2(fremre,foremost). 

adj2(full,full). 
    adj2(smekkfull,full). 
    adj2(stappfull,full). 
%% adj2(full,whole).  

adj2(full,drunk). 
    adj2(beruset,drunk).


adj2(fullstendig,full).  
%% adj2(fullstendig,whole). 
    adj2(utfyllende,whole). 
%%   adj2(skikkelig,whole).   

%% adj2(f�rstg�ende,next).   %%  = first
%% adj2(f�rstkommende,next). %%  = first

adj2(framme,present). 


adj2(gal,wrong). 
    adj2(avvikende,wrong). %% rough 
    adj2(feil,wrong). 
%%    adj2(feilstavet,wrong).   %%  rough
    adj2(feilstavet,misspelled).%% 
    adj2(fiktiv,wrong).      %% rough 
    adj2(misvisende,wrong).  %% rough %% bad? 
    adj2(feilaktig,wrong).
    adj2(forfalskede,wrong). %% hack
    adj2(forfalsket,wrong).
    adj2(forvirret,wrong).      %% confused ? 
    adj2(galen,wrong).
    adj2(galn,wrong).  %% + galne
    adj2(gal,wrong). 
    adj2(mangelfull,wrong). 
    adj2(optimistisk,wrong). %% rough but wise %% TA-110411 (cmp pessimistisk)

    adj2(spr�,wong).    
    adj2(spr�tt,wrong).      %% .. rule ?
    adj2(tullet,wrong).  
    adj2(tullete,wrong).    %% nec ?
    adj2(uriktig,wrong).  
%%    adj2(uforst�elig,wrong).    %% rough -> incomp.. 
    adj2(uforutsigbar,wrong).   %% rough


adj2(gamle,old). 
adj2(gammel,old).
adj2(gift,married). 
adj2(glad,happy).              %%  :-)
   adj2(gla,happy). 
   adj2(forn�yd,happy). 
   adj2(tilfreds,happy).       %%
adj2(glatt,icy).               %%  (slippery)

adj2(gratis,gratis). 
%% adj2(gratis,free).
   adj2(fraktfritt,gratis). %% Rutehefte

% adj2(grinete,sour).            %%  ( ? facetious ?) 


adj2(gyldig,valid).  
    adj2(gjeldende,valid). 

adj2(halv,half).     %% ?  usually only  clock 

adj2(hektisk,busy).  
adj2(heldig,lucky).   %%  ?
adj2(hemmelig,secret). 


%% hel -> determiner (~all)
%% adj2(hele,whole).  

adj2(hel,whole).   
     adj2(detaljert,whole).     %% (Roughly)
     adj2(full,whole).           %%  "den fulle og hele sannhet"



adj2(hjemme,at_home).   %% er hjemme = adj pr def ? 

adj2(hellig,holy).   

adj2(humoristisk,humoristic). %% \+ ou  %% TA-110125

adj2(hurtig,fast).
    adj2(kjapp,fast).  
    adj2(kjapt,fast).          %% rule slapt/
    adj2(kvikk,fast).   
    adj2(snarlig,fast). 

adj2(hurtigere,faster). 
% adj2(hurtigst,fastest). 
adj2(hyggelig,nice).           %%   more general
   adj2(h�flig,nice).  
   adj2(h�fleg,nice).  
   adj2(koselig,nice).  
   adj2(kultivert,nice). 
   adj2(serviceinnstilt,nice). 
   adj2(sympatisk,nice). 
   adj2(trivelig,nice). 

adj2(h�y,high). 
    %% adj2(h�y,great). %% h�y skoleringen 
adj2(h�yere,high).
adj2(h�yest,high). 

%% adj2(i 

adj2(igang,ready). %% Technical 
adj2(imponerende,good).      %% also adverb !
adj2(imponert,impressed). 

%% adj2(i 

adj2(individuell,individual). %% general dummy adjective %% TA-110419

adj2(inkludert,included).

adj2(innvendig,internal). 

adj2(intelligent,intelligent).
%%     adj2(avansert,intelligent).  %% ?
    adj2(fornuftig, intelligent). 
    adj2(forst�elsesfull, intelligent).
    adj2(genial,intelligent). 
    adj2(glup,intelligent).
    adj2(gl�gg,intelligent).  
%%%    adj2(inteligent,intelligent).    %%  (spell)
%%%    adj2(innteligent,intelligent). 
    adj2(klog, intelligent). 
    adj2(klok, intelligent). 
    adj2(rasjonell,intelligent). 
    adj2(rasjonnell,intelligent). %% spiw 
    adj2(rasjonnel,intelligent).  %%
    adj2(saklig,intelligent). 
    adj2(smart,intelligent). 
    adj2(ufeilbarlig,intelligent).   %% facetious

adj2(interessant,interesting).

adj2(interessert,interested).
    adj2(interesert,interested).
    adj2(interresert,interested). 
    adj2(interressert,interested).%%

adj2(irrelevant,irrelevant).
    adj2(irellevant,irrelevant). %%  Spell error
    adj2(urelevant,irrelevant).

adj2(istand,ready).

%% adj2(k 

adj2(kald,cold). 
    adj2(kall,cold). 
%%%     adj2(kalt,cold).   %% (opp)kalt %%  (kaltt? is accepted)

adj2(karakteristisk,true). %% rough 

adj2(kjapest,fast).  
adj2(kjapt,fast).
adj2(kjappere,fast).           %%  (fastest)
adj2(kjappest,fast).           %%  (fastest)
    
adj2(kjedelig,tedious).  %% boring?
   adj2(ensformig,tedious).
   adj2(kjip,tedious).     
   adj2(uinteressant,tedious).    

adj2(kjent,known). 
%%    adj2(ber�mt,known). %%  TA-110301???    
    adj2(lokalkjent,known). %% TA-110301 NB 

adj2(klar,clear). %% indication ... %% (generic)

adj2(klar,ready).  
    adj2(rede,ready).          %%  rede til et m�te
    adj2(villig,ready).        %%   (Rough) 

    
adj2(kommersiell,real). %% rough %% TA-110329

adj2(komplett,whole).
   adj2(komlett,whole).  

adj2(korresponderende,corresponding). 

adj2(kort,short). 
    adj2(konsis,short).  
    adj2(momentan,short). %% responstid %%rough  
    adj2(snau,short).     %% TA-101117
    
adj2(korteste,fast).           %%(fastest)  
adj2(kunnskapsteknologisk,intelligent). %%   (roughly, humourous)
adj2(kunstig,artificial). 
adj2(kvinnelig,female).

%% adj2(l 


adj2(lang,long).
    adj2(dr�y,long). 
%%     adj2(bred,long).   %%  (roughly)  \+ duration 
    adj2(langvarig,long).       %% rough

adj2(langsom,slow). 
    adj2(sakte,slow).      
    adj2(tidkrevende,slow). %% rough 

adj2(lav,small). 
    adj2(lav,low).  

adj2(ledig,free). 
adj2(lengst,long).             %% lengste   ?
% adj2(lenge,long).            %%(adverb)
adj2(lett,easy).  
    adj2(enkel,easy). %% ?  
    adj2(enkelt,easy). %% ? 
    adj2(enklest,easy). %% ? 
    adj2(forenklet,easy). %% simple  
    adj2(triviell,easy).


adj2(letteste,easy).  
%% adj2(lettest,easy).     %% adverb 
adj2(letteste,easy).       %%        %% (nec ?)
adj2(levende,alive).  

adj2(lik,similar).      %% equal? // Comparator 
   adj2(synkron,similar).      %% 
   adj2(synkronisert,similar). %%

adj2(lignende, similar).  
   adj2(liknende, similar). 
   adj2(likedan, similar). %% TA-110411
   adj2(likedanne, similar). %% rule ?

adj2(likeglad,  indifferent).
adj2(likegyldig,indifferent).  

adj2(lite,small). %% TA-110511 et lite sp�rsm�l %% TA-110511

adj2(line�r,simple). %% rough, who cares %% TA-110503

adj2(liten,small). 
    adj2(forsvinnende,small). %% also gradverb
%%     adj2(lille,small).        %% destroys lille julaften

adj2(logisk,logical).
adj2(lokal,local).   
    adj2(lokalisert,local). %% rough    

adj2(lur,intelligent). 
adj2(lykkelig,happy). 


adj2(mannlig,male).  

adj2(manuell,manual). 
%%   adj2(manuelt,manual). 

adj2(menneskelig,human).  
    adj2(menneskelignende,human). 

adj2(merkelig,funny). 
adj2(mild,mild).   %% mildt v�r 
%% adj2(minst,small).             %% adj3
adj2(mistet,lost).  
    adj2(gjenglemt,lost). 
    adj2(glemt,lost). 

adj2(moro,funny). 
adj2(morsom,funny).            %%  ( :-)
   adj2(arti,funny).  
   adj2(artig,funny). 
   adj2(festlig,funny).   
   adj2(g�y,funny).            %%  :-)
   adj2(komisk,funny).  

adj2(motsatt,opposite). 
adj2(mulig,possible). 
    adj2(mogleg,possible). %% NN %% TA-100830
    adj2(tenkbar,possible). 
adj2(m�nedlig,monthly). 


adj2(nasjonal,national). 

adj2(naturlig,natural). %% language/ also ordinary

adj2(nede,down).     %% adj2(nede,present). %% ikke synword nede = framme ==> 'f�r'
  
adj2(nedenfor,below). %% sp�rsm�let nedenfor ? 


adj2(nedlagt,closed).          %%  (roughly)

%% adj2(nest,nex).                %% NEST  %% EXPERIMENT  

adj2(nest,second).             %% NB, not next ( nest siste )
                                       %% n�r g�r nest nr 9 ? 
adj2(neste,next).
    adj2(fortl�pende,next). 
    adj2(framtidig,next).  
    adj2(fremtidig,next). 
    adj2(f�lgende,next).  
    adj2(nestebuss,next).  
    adj2(nestebus,next).   

adj2(nestsiste,second_last). 
   adj2(sistneste,second_last).

adj2(nordg�ende,waybound).  %% Technical
   adj2(s�rg�ende,waybound).
   adj2(sydg�ende,waybound).
   adj2(�stg�ende,waybound).
   adj2(vestg�ende,waybound).

   adj2(nordligst,waybound).  %% Technical
   adj2(s�rligst,waybound).
   adj2(sydligst,waybound).
   adj2(�stligst,waybound).
   adj2(vestligst,waybound).

adj2(nevnt,named). %% den nevnte avgangen

adj2(norsk,norwegian).  
    adj2(norek,norwegian).   %%  own 
    adj2(noesk,norwegian).   %%  own 

adj2(ny,new).                  %% Nye busstabeller
    adj2(jomfruelig,new). %% :-) 

adj2(nysgjerrig,curious).  
    adj2(nyssgjerrig,curious). 
adj2(nytt,new). 

%% N�RMEST

%% adj2(n�r,near). %% SUSPENDED TEST 

adj2(n�re,near).  
adj2(n�rere, near). 
adj2(n�rmere,near).  %% er).

adj2(n�rest, nearest).
%% adj2(n�rmest,nearest).  %% SUSPENDED TEST %% n�rmeste time/ n�rmeste stasjon 
%% adj2(n�rmest,near).      % n�rmest festningen 

adj2(n�dvendig,necessary). 
    adj2(p�krevet,necessary). 

adj2(n�yaktig,precise).    %%  accurate?

%% adj2(odd,funny). %% odde %% Odd Husbys Veg

adj2(offentlig,public). 
adj2(offisiell,public).        %% Not corect
    adj2(kollektiv,public).  
    adj2(oficiell,public).     %% Danish
    adj2(uniformert,public).   %% rough .. kontroll�r
    adj2(ruteg�ende,public).   %% rough


adj2(online,online).  
adj2(operativ,active). 

adj2(oppe,up).

  
%% adj2(oppdatert,new).  %% Try with past/part (passive)
 
adj2(oppdatert,updated). 

adj2(ordin�r,ordinary).        %%  (dummy, really)
    adj2(ordinar,ordinary).
    adj2(ordiner,ordinary).    %% sp
%%% adj2(over,finished). %% IKKE ADJ  over 10 busser venter\=finished 


adj2(orientert,oriented).    

adj2(passe,good).              %%   passe tid
adj2(pen,beautiful). 
   adj2(nydelig,beautiful). 
   adj2(vakker,beautiful).
   adj2(vakre,beautiful).  

adj2(perfekt,perfect).  
    adj2(feilfri,perfect). 

adj2(permanent,permanent). 

adj2(personlig,personal). 

adj2(planlagt,planned).

adj2(presis,punctual). 
    adj2(eksakt,punctual).
    adj2(pressis,punctual).  %%  sp
    adj2(punktlig,punctual). 

adj2(presis,precise). 

adj2(privat,private). 
adj2(p�litelig,reliable).


adj2(rask,fast). 
% adj2(raskere,fast).      %% (fastest)
% adj2(raskest,fast).      %% (fastest)
adj2(redd,afraid). 
    adj2(nerv�s,afraid).  
adj2(realistisk,actual).   %% TA-110503 possible?
adj2(reell,actual).        %% tid 


adj2(rein,clean). 
    adj2(ren,clean).
    adj2(rengjort,clean). 

adj2(relevant,relevant).  

adj2(resterende,remaining). 
adj2(riktig,correct). 
    adj2(forst�elig,correct). %% rough
    adj2(korrekt,correct). 
    adj2(korekt,correct).    %% spell :-)
    adj2(korrigert,correct).
    adj2(pessimistisk,correct). %% rough :-) %% TA-110411 cmp otimistic
    adj2(rett,correct). %% riktig Haz ?
    adj2(sant,correct). 
    adj2(tydelig,correct).     %%  rough

adj2(r�ykfri,smokefree).

%% adj2(s 

adj2(sammen,together). %% TA-110221 %% NB also adv

adj2(samme,same). 
   adj2(same,same).  %% ikke Samf(undet)
   adj2(samsvarende,same). 

adj2(samlet,joint). 
adj2(sant,true). 
   adj2(singel,single). 
adj2(skriftlig,printed). 
   adj2(skrevet,printed).   
   adj2(skrevne,printed). 
   adj2(trykket,printed). 
   adj2(utskrevne,printed).
   adj2(utskrevet,printed).


adj2(sen,late).      %% NB senere \= forsinket | senest = f�r ***
    adj2(sein,late). %% Technical %%  fremme seinest
    adj2(treg,slow). 
    adj2(treig,slow).

%% adj2(senere,later).   %% RELATIVE %% SUSPENDED TEST
adj2(seinere,later).  %% NB 

adj2(separat,separate). 

adj2(sikker,certain). %% safe
adj2(sint,sour).         %%   for all p p.
    adj2(hissig,sour).
    adj2(irritert,sour). 

adj2(sist,last).         %% sist,siste  (OK ???)
    adj2(bakerst,last).  
    adj2(ultimat,last).  %% :-)

adj2(sivil,ordinary). %% rough 

adj2(skjult,hidden).  

adj2(synlig,visible). 

adj2(slik,dummish). %% kunstig %% TA-101106

adj2(slutt,finished). 
    adj2(omme,finished).  %%  ?

%% adj2(snarest,fast).    %%  ogs� adverb (snareste buss) " snarest mulig"

adj2(smal,little). %% small 

adj2(snill,nice).  
%   adj2(grei,nice).  %% good 
    adj2(r�rende,nice).  
    adj2(s�t,nice). 

adj2(snillest,nice). 
adj2(snilt,nice). 
adj2(snillt,nice). 

adj2(spesiell,special). 
    adj2(spesiel,special). 
    adj2(spessiel,special). 
    adj2(spessiell,special). 
    adj2(egen,special).
    adj2(spessiell,special). 
%    adj2(s�rlig,special). 


adj2(spr�klig,linguistic). %% naturlig spr�klig ES 
adj2(stabil,reliable).  
adj2(statisk,static). 
adj2(stengt,closed).
adj2(sterk,strong). 

adj2(stigende,ascending). %% order 

adj2(stolt,proud). 
adj2(stor,great). 
    adj2(diger,great).  
    adj2(mektig,great).  
    adj2(voksende,great).  %% ad hoc,
%%%      adj2(voksende,increasing). 
    adj2(voldsom,great).  

%% adj2(st�rre,great).        %%  (rough, for chat) %% SUSPENDED

%%% adj2(st�rst,great).        %% SUSPENDED TEST 
  adj2(maksimal,great).  
adj2(stygg,ugly). 
    adj2(st�gg,ugly). 
adj2(sulten,hungry). 
    adj2(mett,satisfied). 
adj2(sur,sour).          %%   grumpy :-)
    adj2(avvisende,sour). 

    adj2(ekkel,bad).  %% TA-101108
    adj2(ekkel,sour). 

%%     adj2(ekle,sour).  %% morph rule

    adj2(frekk,sour).     %% (rough)
%%     adj2(frekt,sour).  %% kt -> kkt, but only this (lekk - lekt/lekkt) 
                         
    adj2(slem,sour).  
    adj2(slemm,sour). 
    adj2(spydig,sour).
    adj2(udanned,sour).  
    adj2(udannet,sour). 
    adj2(uh�flig,sour). 
    adj2(zur,sour).  % :-)

adj2(svensk,swedish). 
adj2(syk,ill). 
   adj2(sjuk,ill).   
%% adj2(s�t,nice).          %% (sweet ?)  Facetious 


adj2(s�nn,true). %% rough, ad hoc det skal v�re s�nn 

adj2(takknemlig,grateful). 

adj2(talebasert,speech_based). 

adj2(teknisk,technical).

adj2(tekstlig,textual).
    adj2(tekstbasert,textual). 


adj2(tidlig,early). 
%%%     adj2(snart,early). 
    adj2(tidli,early).  
    adj2(tidligst,early). 

%% adj2(tidliger,earlier).  %% RELATIVE  incl tidligere (plu)
%%% adj2(tidligere,earlier). %% e // incorrect %% adj3(eraly,comp) 
                             %% not tidlig = morning
adj2(tilgjengelig,available). 
    adj2(s�kbar,available).  %% rough

adj2(tilstrekkelig,sufficient). 
    adj2(nok,sufficient). %% bruker nok mer tid %% TA-110411

adj2(tolerant,tolerant).  
adj2(tom,empty). 
adj2(topp,good). 

adj2(tospr�klig,bilingual). 

adj2(travel,busy). 
adj2(trett,tired).  
    adj2(sliten,tired).  
    adj2(tr�tt,tired).  


adj2(trinn,step).

%% adj2(trist,unhappy). %% more neutral etc -> sad  // I am sad/ it is sad
                        
adj2(trist,sad).  
   adj2(beklagelig,sad). 
   adj2(bekymret,sad).  
   adj2(ensom,sad). 
   adj2(lei,sad). 
   adj2(skuffet,sad). 

adj2(trygg,safe). 
    adj2(kontrollert,safe).  

adj2(tung,heavy).

adj2(uforst�elig,incomprehensible).
    adj2(meningsl�se,incomprehensible). 
    adj2(p�fallende,incomprehensible). 
    adj2(rar,incomprehensible).         %% 
    adj2(uf�rst�elig,incomprehensible).  
    adj2(ufullstendig,incomprehensible).
  


adj2(ukjent,unknown). 
   adj2(udefinert,unknown). 
   adj2(udokumentert,unknown). %% rough
   adj2(uforutsett,unknown).   %% rough 
   adj2(uventet,unknown).      %% rough


% adj2(ulik,different).   


adj2(umulig,impossible). 
    adj2(forbudt,impossible). 
    adj2(meningsl�st,impossible). %% Rough 
    adj2(p�budt,possible).        %% Rough 
    adj2(ulovlig,impossible).

adj2(ung,young). 
adj2(usikker,uncertain). 

adj2(usant,false).  
%%    adj2(feil,false).  %% ad adj, wrong 
   adj2(galt,false). 

adj2(utdatert,expired). %% rough 
    adj2(utg�tt,expired). %% expired 

adj2(vanlig,ordinary). 
    adj2(alminnelig,ordinary). 
    adj2(forutsetningsl�s,ordinary). 
    adj2(generell,ordinary).  
    adj2(naturlig,ordinary).   %%  Rough
    adj2(normal,ordinary). 
    adj2(vanelig,ordinary).    %% spell
    adj2(vandlig,ordinary).
    adj2(vanlog,ordinary).     %% spell

adj2(vanskelig,difficult). 
    adj2(arbeidskrevende,difficult). %% TA-110426
    adj2(ikketriviell,difficult). 
    adj2(komplisert,difficult).  
    adj2(slitsomt,difficult). 
    adj2(ul�st,difficult).      %% TA-110419
    adj2(vanskerlig,difficult). %% sperr
    adj2(vrang,difficult).      %% ?
    adj2(vrien,difficult).      %% ?
    adj2(vanskelieg,difficult). %% own 

adj2(varm,hot). 

adj2(vedlagt,enclosed). 

adj2(velkommen,welcome).
adj2(vellykket,good). 
adj2(vennlig,good). 
   adj2(venlig,good). 
   adj2(venleg,good). 
   adj2(vennelig,good). 
   adj2(verdifull,good). 

adj2(venstre,left).
adj2(h�yre,right).

adj2(viktig,important). 

adj2(virkelig,real).  
    adj2(konkret,real).  
    adj2(verkeleg,real). 
adj2(vis,intelligent).   
adj2(voksen,adult).        %% NB ALSO NOUN
adj2(v�ken,awake). 
adj2(v�t,wet).             %% rainy

adj2(webbasert,webbased).  %%  techn


adj2(�rlig,honest). 
adj2(�pen,open). 
    adj2(aapen,open).
    adj2(oppe,open). %% folk talk 

adj2(�rlig,annual).

adj2(m�rk,dark). 

adj2(beige,beige). %% Berge ? 
adj2(rosa,pink).                 
adj2(svart,black).               
adj2(sort,black).                
adj2(gr�,grey).                  
adj2(hvit,white).                
adj2(r�d,red).                   
    adj2(roed,red). 
adj2(bl�,blue).                  
adj2(gul,yellow).                
adj2(gr�nn,green).               
    adj2(gr�nt,green). %% \= gr�nnt 
adj2(brun,brown).                
adj2(lilla,violet).              
adj2(purpur,purple).             
adj2(turkis,cyan).               
adj2(oransje,orange).            
adj2(orange,orange).             


%% NOUN SECTION

unwanted_noun(arbeider). %% verb 
%% unwanted_noun(bilet).    %% billett, not bilen %% barne bilet 
unwanted_noun(bokers).   %% bok boker* bokers  ( Prob. Bojer )
unwanted_noun(boks).     %% bok gen ?
%%%  unwanted_noun(bruker).   %% not bruk (plu) %% hva er en bruker 
%% unwanted_noun(brus).     %% not bridges %% fizzydrink ? 
unwanted_noun(buger).    %% messy (softw error)
unwanted_noun(bugene).   %%

%% unwanted_noun(byen). %% = sentrum, otherwise irrelevant 
%% byen H�nefoss %% TEST %% TA-110120

unwanted_noun(bygger). %% \+ plu bygg

unwanted_noun(drifter).   
unwanted_noun(dumpet).   %% dump=liste 
unwanted_noun(dy).       %% not dy(r)

unwanted_noun(elvenes). %% river's
%%%%%%%%%%%%%%%%%% unwanted_noun(far).      %% most prob. fra 
unwanted_noun(fara). %% \+ fathers %% TA-110303

unwanted_noun(feiler).   %% not plu error 
unwanted_noun(festet).
unwanted_noun(fester). %% ? %%p� fest (fast utt)
unwanted_noun(flatas).   %% \+ Flat�s 

unwanted_noun(g).        %% \+ street (only in addresses) 
unwanted_noun(gleder).   %% \+ happinesses 

unwanted_noun(hava).     %% \+ havene  
unwanted_noun(havnet).   %% \+ harbour
unwanted_noun(hender).   %% \+ hands %% ?
unwanted_noun(himmels).  %% \+ gen av himmel
unwanted_noun(hjelper).
unwanted_noun(h�sta).    %% \+ h�st
unwanted_noun(ida).      %% ikke idea ( a la klokka)

unwanted_noun(jobber).   %% probably verb, hvilken agent jobber i trondheim
unwanted_noun(july).     %% not jul 

unwanted_noun(katten). %% \+ Kattem  (Katt ok) %% TA-100920

unwanted_noun(kirkenes). %% \+ of churches %% TA-110531

unwanted_noun(kj�per).   %% \+ kj�p (plu) 
unwanted_noun(kodet). 
unwanted_noun(konges).   %% confuse konges gate %%  ad hoc
unwanted_noun(kongens).  %% confuse kongens gate %%  ad hoc
unwanted_noun(kortere).  
unwanted_noun(kr�sjer).  %% \+ plu %% TA-100903

unwanted_noun(lager).    %%  lag(plu)
unwanted_noun(laget).    %% \+ team -et. 
unwanted_noun(lander).   %% land 

%%% unwanted_noun(lina).  %% \+ linjen      %% collides with Gammel-lina = old route 

unwanted_noun(liver).    %% pl av liv 
unwanted_noun(logget).   %% Verb
unwanted_noun(lover).    %% \+ permissions 
unwanted_noun(l�nner).   %% \+ salaries

unwanted_noun(mana).     %% \+ menn 
unwanted_noun(manna).    %% \+ menn
unwanted_noun(mats).     %%  mat gen
unwanted_noun(minner).   %% memories / reminds 
unwanted_noun(morer).    %% pl mor 
unwanted_noun(moret).    %% moren

unwanted_noun(orden). %% \+ ordet \+ order 

unwanted_noun(paras).    %% \+ parenes 
unwanted_noun(pluss).    %% \+ plass
unwanted_noun(prater).   %% \+ talks 
unwanted_noun(prisens).  %% -> prinsens 

unwanted_noun(pr�ven).   %% TA-110520   collides with Pr�ven (ex. station) 

unwanted_noun(pr�ver).   %% TA-101115

unwanted_noun(regner). 


%%% unwanted_noun(reiser).   %%  \+ trips %% Hazard ? %% ad hoc  n�r de reiser sammen
 

unwanted_noun(restartet). %% \+  restarten

unwanted_noun(rette). 

%%  unwanted_noun(rettet). %% unnec the right (noun3(_,_,m). 

unwanted_noun(roma). %% \+ rooms %% TA-100905

unwanted_noun(r�yken).   %% \+ R�yken
unwanted_noun(r�yker).  

unwanted_noun(setter). %% Team setter opp ruter 
unwanted_noun(serveres). %% not servers (comouters)
unwanted_noun(serverer). 

%%% unwanted_noun(siden). %% cofuse .. i ruteheftet siden dette er ..
                          %% p� den andre siden

unwanted_noun(skien).    %% / Skien 
unwanted_noun(skifter). 
unwanted_noun(skiftet). 
unwanted_noun(slutter).  %% not plu of slutt (?)

unwanted_noun(sola). %% neib

unwanted_noun(starter). 
unwanted_noun(startet).  %% verb / ikke starten 

unwanted_noun(stasjonen). %% usually means Trondheim Sentralstasjon
%%  Experiment  Vestlia stasjonen
unwanted_noun(stavet). %% \+ staven %% TA-110808

unwanted_noun(steinar). %% \+ steiner
unwanted_noun(steinan). %% \+ steinene
unwanted_noun(stian).   %% \+ stiene 

unwanted_noun(stoper).   %% \+ stations 
unwanted_noun(stopper).  %% \+ plu of stopp // en buss gj�r stopper Avoid confusion
unwanted_noun(stoppet).  %% \+ plu of stopp /  buss stoppet
unwanted_noun(stops).    %% \+ holdeplassens 

unwanted_noun(streiket). %%\+ the strike

%% unwanted_noun(studenter). %% - samfundet 
unwanted_noun(svarer).  %%  (not plu svar)
unwanted_noun(s�ker).   %% \+ s�k 
unwanted_noun(taket).   %% f� tak i
unwanted_noun(tasta).   %% TA-101006
unwanted_noun(testet).  %% \+ testen 
unwanted_noun(tide).    %% i tide/p� tide 
unwanted_noun(togstasjonen). %%    shadows name(ts 
% unwanted_noun(tosk).    %%  not Tysk // = fool 
unwanted_noun(tra).     %% not trea a la klokka 

unwanted_noun(trykker). %% \+ trikker %% TA-110303  
unwanted_noun(trykket). %% \+ trikken %%
unwanted_noun(tuller).  %% noe tull 
%% ...
unwanted_noun(ura).     %% \+ clocks %% TA-110818

%                      % programmer erne  ~ v erne

unwanted_noun(varsler). %% confuses  
unwanted_noun(vera).    %% not v�rene
unwanted_noun(vere).    %% not v�ret 
unwanted_noun(verene).  %% not v�rene
unwanted_noun(v�rene).  %% not v�rene
unwanted_noun(v�renes). %% not N�rnes 
unwanted_noun(v�ra).    %% \+ v�ren 

unwanted_noun(verne).  %% \+  v�renes (plu def  of weather !) 
unwanted_noun(vernes). %% \+  v�renes (plu def gen of weather !) 

%%% unwanted_noun(�nsker). %% try with again with care
%% \+ many wishes // har du  noen �nsker     

unwanted_noun(�ren).   %% \+  the cent
unwanted_noun(�rens).  %% \+  the cent's /rule here?

unwanted_noun(�yer).   %% Comm, \+ islands %% TA-110310

% noun2 is also used as a de facto synword definition,
% because all inflection comes with  the bargain


%% NOUN3     noun3(NorRoot,EnglishRoot,Gender).
%%   specially when illegal indlection causes ambiguoty (retter \= rights)

%% It may be safe to have NOUN3 in addition to NOUN2

   noun3(buss,bus,m).
   noun3(dag,day,m).
   noun3(dato,date,m).
   noun3(forslag,proposal,n). %% 10 forslag 
   noun3(hus,house,n).    %% hus -> sin|plu
   noun3(hjul,wheel,n).   %% hjul -> sin|plu
   noun3(holdeplass,station,m).
   noun3(kj�ret�y,vehicle,n).
   noun3(klokke,clock,f).  

 %%%%   noun3(lag,team,n).   %% (should exclude lager = team plu
 %% confuse
  
 noun3(rett,right,m). %% rett til skyss \+ rettet 
   noun3(rute,route,f). % avoid ruta = ruter 

   noun3(sp�rsm�l,question,n). %% shall give question, sin|plu ,u,n
 
%%    noun3(sted,place,n). %YES, but inflected as  1 sted, 2 steder 
   noun3(tid,time,f).   %
   noun3(trikk,tram,m).

   noun3(vedlegg,attachment,n).   %% \+ vedlegger




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% noun2(a 

noun2(abstraksjon,abstract). 
    noun2(abstrakt,abstract). 
    
noun2(abonnement,subscription). 
    noun2(abonement,subscription).   %% sp
    
noun2(administrator,administrator).  %% Tagore 

noun2(adresse,address). 
    noun2(addres,address).  
    noun2(address,address).       %% anglicism 
    noun2(adrese,address). 
    noun2(adres,address).   
    noun2(adress,address).     
    noun2(bes�ksadresse,address).
    noun2(gateadresse,address). 
    noun2(kontoradresse,address). 

noun2(advent,advent).
noun2(agent,agent). 
    noun2(vesen,agent).  

noun2(airport,airport). %% SIC %% haz ? 

noun2(aktivitet,activity).    %%  Spurious  What is a route ???  
    noun2(aksjon,activity). 
    noun2(handling,activity). 
    noun2(virksomhet,activity). 

noun2(alder,age). 
noun2(aldersgrense,agelimit). %% agelimit  capture the oneword 
    noun2(aldergrense,agelimit). 
    noun2(�rsgrense,agelimit). %% TA-101020 
    noun2(lavalder,agelimit). 

noun2(alternativ,alternative). %% \= m�te (confuse) %% TA-110228

noun2(analyse,analysis).
 
noun2(animat,animate). 

noun2(animering,animation).
     noun2(ansiktsanimering,animation). %% rough      

noun2(ankomst,arrival).
    noun2(amkmost,arrival). 
    noun2(ankmost,arrival).  
    noun2(ankomstholdeplass,arrival). %% rough 
    noun2(ankomstid,arrival). 
    noun2(ankomsttid,arrival).
    noun2(ankosmyt,arrival).   
    noun2(anl�p,arrival). 
       noun2(b�tanl�p,arrival).   %% rough, ad hoc
    noun2(annkomst,arrival). 
    noun2(bussankomst,arrival). 


%     noun2(stopp,arrival). %%  ( Hazardous) Hvilken stopp er n�rmest nth

noun2(anropstidspunkt,callingtime). 
   noun2(anropstid,callingtime).

noun2(ansatt,employee). 
    noun2(annsatt,employee).
    noun2(annsat,employee).
    noun2(ansat,employee).  
%%    noun2(kollega,employee). %%

noun2(angivelse,specification). %%
    noun2(spesifikasjon,specification). %% TA-101108
    noun2(spesifisering,specification). %%

noun2(ansvar,responsibility).

noun2(anvendelse,application).
    noun2(applikasjon,application).    %% program ? 
    noun2(applikkasjon,application).   %% spiw 

noun2(auditorium,auditory). %% Rough %% (ikke room/praphrase first) 
    noun2(auditori,auditory).      %% missing rule auditori -et

noun2(avdeling,department).
    noun2(arbeidssted,department).   %% rough  
    noun2(arbeidsted,department).  
    noun2(markedsavdeling,department).   %% rough  
    noun2(trafikkplanleggingsavdeling,department).  %%  rough  

noun2(avgang,departure).
    noun2(adgang,       departure).  %% spiw
    noun2(adgangstid,   departure).  %% apiw
    noun2(afgang,       departure).  %% (DK) 
    noun2(afgangstid,   departure). 
    noun2(agang,        departure).  %% spell 
    noun2(angang,       departure).  %% spell  
    noun2(avgabg,       departure).  %% own 
    noun2(avang,        departure). 
    noun2(avgagn,       departure). 
    noun2(avgagng,      departure). 
    noun2(avgamg,       departure). 
    noun2(avgamgstid,   departure).  %% own sp  
    noun2(avgan,        departure). 
    noun2(avganf,       departure).  
    noun2(avgangsholdeplass, departure). %% rough
    noun2(avgangstype,  departure).  %% rough, metagoric 
    noun2(avganmg,      departure).  %% own sp 
    noun2(avgangsbuss,  departure). 
    noun2(avgangstid,   departure).
    noun2(avganstid,    departure). 
    noun2(avgangstidspunkt,departure). 
    noun2(avgangtid,    departure). 
    noun2(avgnag,       departure). 
    noun2(avg�ng,       departure).  %% SWE
    noun2(avreise,      departure). 
    noun2(busavgang,    departure). 
    noun2(bussadgang,   departure).  %%  spell
    noun2(bussagang,    departure). 
    noun2(bussavg,      departure). 
    noun2(bussavgafng,  departure). 
    noun2(bussavgan ,   departure).  %% sp
    noun2(bussavgang,   departure).  %%   "Bussavgang for buss 7
    noun2(busseavgang,  departure). 
    noun2(bussenavgang, departure). 
    noun2(bussertid,    departure).  %%  own
    noun2(bussgang,     departure). 
    noun2(bussm�te,     departure).  %%   ???
    noun2(busspassering,departure).
    noun2(busspassring, departure).  %% sp
    noun2(busrutetid,   departure).  %% sp
    noun2(bussrte,      departure).  %% sp
    noun2(bussrutetid,  departure). 
    noun2(bussrtid,     departure). 
    noun2(busstid,      departure). 
    noun2(bustid,       departure).  %%  (spell)  
    noun2(busstime,     departure). 
    noun2(busstidspunkt,departure). 
    noun2(bybussavgang, departure).  %%   "
%%    noun2(kveldsavgang, departure).  %% rough 
%%    noun2(morgenavgang, departure).  %% rough 
    noun2(hovedavgang,    departure). 
    noun2(oppf�ring,    departure). 
    noun2(oppm�te,      departure). 
    noun2(ordin�ravgang,   departure).  %% rough 
    noun2(p�stigning,   departure).  
    noun2(rutatid,      departure). 
    noun2(ruteavgang,   departure). 
    noun2(rutebusstid,  departure). 
    noun2(ruterid,      departure).  %%  neibk

    noun2(rutetid,      departure). 
        noun2(rudetid,      departure). %% DK %% TA-110215

    noun2(rutetidspunkt, departure). 
    noun2(ruttetid,     departure).  %%  sp
    noun2(rutedit,      departure).  %%  sp
    noun2(rutetis,      departure). 
    noun2(rutertid,     departure).  
    noun2(rutetd,       departure).  %% sp  
    noun2(ruttid,       departure).  %%  Dialect
    noun2(rutetif,      departure).  %%  neibk
    noun2(starttid,     departure). 
    noun2(tidsavgang,   departure). 
 
% noun2(bussavgang,bus).             %% Siste bussavgang til lian    

noun2(avgj�relse,decision). 
   noun2(beslutning,decision). 
   noun2(bestemmelse,decision).

noun2(avstand,distance). 
    noun2(avstanf,distance).  %% own 
    noun2(distanse,distance). 
    noun2(langdistanse,distance). 

%% noun2(b 


noun2(bagasje,luggage).   %% all kind of losable things(lost property)
    noun2(bag,luggage).   %% rough 
    noun2(baggasje,luggage).  
    noun2(brille,luggage).   %% rough 
    noun2(eiendel,luggage).  %% rough 
    noun2(hatt,luggage).  
    noun2(hittegods,luggage). 
    noun2(hittegodskontor,luggage). %% rough 
    noun2(hanske,luggage).          %%  Rough (glove)
    noun2(jakke,luggage).    %% ytter -
    noun2(kjelke,luggage).   %% rough 
    noun2(lue,luggage).  
    noun2(skjerf,luggage).     
    noun2(koffert,luggage).  
    noun2(lommebok,luggage). 
%%     noun2(pakke,luggage).   %% package 
    noun2(paraply,luggage).    %% rough (weather)
    noun2(reisegods,luggage). 
    noun2(sekk,luggage). 
%%     noun2(ski,luggage).     %% Ski 
    noun2(skistav,luggage).    %% TA-100828
    noun2(stav,luggage).       %%
    noun2(sm�ting,luggage).        %% rough
    noun2(spark,luggage).          %% rough 
    noun2(sparkst�tting,luggage).  %% rough
    noun2(sportskjelke,luggage).   %% rough
    noun2(veske,luggage).          %% 
    noun2(vott,luggage). 

%% noun2(bakke,hill).            %%  Fra Bakke til NTNU 
%%    collides with bakke gt. 

    noun2(oppoverbakke,street). %%  :-)
    noun2(nedoverbakke,street). %%

noun2(bakside,backside).

noun2(bank,bank).

noun2(bar,bar). 
  
noun2(barn,child). 
    noun2(barnebarn,child).   %% Rough 
    noun2(elev,child).        %%
%%     noun2(klasse,child).      %% TA-101201
    noun2(l�rling,child).     %% 
    noun2(skoleelev,child).  
    noun2(skoleklasse,child). 
    noun2(sm�barn,child).     %% TA-101105
    noun2(sm�gutt,child).     %%
    noun2(sm�jente,child).    %%
    noun2(unge,child). 

    noun2(tre�ring,child).    %% etc 


noun2(barnevogn,pram).  

noun2(barnehage,kindergarten). 
    noun2(barnehave,kindergarten).   
    noun2(barnhage,kindergarten).  
    noun2(f�rskole,kindergarten). 

noun2(bart,beard).                 %%   :-#)

noun2(basis,base).  

noun2(behov,need). 
   noun2(marked,need). %% TA-110426 rough

noun2(belastning,load).    
    noun2(overbelastning,load). %% rough

noun2(bensin,petrol). 
noun2(beskrivelse,description).
    noun2(beskrivesle,description). %% own
    noun2(veibeskrivelse,description). 
    noun2(beskrivelsessted,description).  %%  rough
    noun2(beskrivelsested,description).   %% sp

noun2(bestemor,grandmother).      %% visit  (etcetera aunt,uncle,...)
    noun2(farmor,grandmother). 
    noun2(mormor,grandmother). 

noun2(bestefar,grandfather).          %% visit ...
    noun2(farfar,grandfather). 
    noun2(morfar,grandfather).

noun2(bestilling,order). 

noun2(bes�k,visit). 

noun2(betaling,payment). 
    noun2(omsetning,payment). %% rough
    noun2(refusjon,payment). 

noun2(betingelse,condition).             %% TA-110707
    noun2(forh�ndsbetingelse,condition). %% 

%% consciousness ---> mind
noun2(bevissthet,mind). 
   noun2(bevisthet,mind). %%  spiw
   noun2(sjel,mind). 
   noun2(hjerne,mind). 
   noun2(personlighet,mind). %%  :-)
   noun2(samvittighet,mind). 

noun2(bidrag,payment). %% rough 

noun2(bil,car). 
    noun2(bilskyss,car).   
    noun2(lastebil,car).   %% rough
    noun2(firhjuling,car). %%    
   
noun2(bilde,picture).  
    noun2(billede,picture).  %%  (old)
    noun2(passbilde,picture). 
    noun2(tegning,picture). 

noun2(billett,ticket).
    noun2(barnebussbilett, ticket). %%
    noun2(barnebussbillett, ticket). %% rough, but answer gen 
    noun2(bilet,  ticket  ). 
    noun2(bilett, ticket  ). 
    noun2(billet, ticket  ). 
    noun2(billettype, ticket). 
    noun2(billetttype, ticket). %% ?
    noun2(busbillet,ticket). 
    noun2(bussbilett,    ticket). 
    noun2(bussbillet,    ticket).        %%  (slight spell error)
    noun2(fullprisbillett,  ticket). 
    noun2(barnebillet,ticket).         %%  sp
    noun2(barnebillete,ticket). 
    noun2(barnebillett,ticket).        %%  OK, both prices are given
    noun2(barnebilett,ticket).         %% spell
    noun2(engangsbillett,ticket). 
    noun2(enkelbillett,ticket).        %%  etc. ad. n
    noun2(enklebillett,ticket). 
    noun2(enklebilett,ticket).    %%
    noun2(enklebillet,ticket).    %%
    noun2(enkeltbilett,ticket). 
    noun2(enkeltbillet,ticket). 
    noun2(enkeltbillett,ticket).  
    noun2(enkeltur,ticket).            %%  (sp)
    noun2(enkelttur,ticket).
    noun2(lokaltakst,ticket). 


    noun2(ungdomsbillet,ticket).  
    noun2(ungdomsbillett,ticket). 
    noun2(voksenbilett,ticket).       %%  OK, both prices are given
    noun2(voksenbillett,ticket).      %%

noun2(billettpris,price).
   noun2(betalingsm�te,price).        %%  (Rough)  
   noun2(billetpris,price).           %%  (spell)
   noun2(bilettpris,price).           %%  (spell)
   noun2(billettakst,price). 
   noun2(busstakst,price). 
   noun2(voksentakst,price). 
   noun2(fullpris,price).  
   noun2(prisliste,price).  
   noun2(prisopplysning,price). 
   noun2(tariff,price). 

noun2(bilverksted,garage). 

noun2(bok,book).  
   
noun2(bokstav,letter). 
   noun2(alfabet,letter).   %% Rough 
   noun2(ordforr�d,letter). %% Rough
   noun2(tegn,letter).      %% Rough



noun2(bredb�nd,broadband).
noun2(breddegrad,latitude). 
noun2(lengdegrad,latitude). 

noun2(brems,brake). 
noun2(bror,brother). 
    noun2(lillebror,brother). %% rough
    noun2(storebror,brother). %% rough 

noun2(bruker,user).          %%   hvilken tid (som) bruker  (rel_clause)
    noun2(nettbruker,user).  %% rough %% TA-110617
   
noun2(bru,bridge). %%  Confusion ??
   noun2(bro,bridge).  

noun2(bruk,use). 
    noun2(nytte,use).
    noun2(utnyttelse,use). %% TA-110707

%% noun2(brukerne,user).    %% AD HOC, no confusion
%% noun2(brukere ,user).  

noun2(brus,fizzydrink).

noun2(f�dselsdag,birthday). %% more time absolute %% TA-110520
    noun2(bursdag,birthday). 
 

noun2(buss,bus). 
%%    noun2(alpinbuss, otherbus). 
%%    noun2(alpintbuss, otherbus). 
%%     noun2(arbeidbuss,bus).    %% rough 
%%     noun2(arbeidsbuss,bus).   %% Rough (arbeidsbuss is a special route)
    noun2(arbeidsrute,bus).  %% ?
    noun2(autobuss,bus).   %%  ? \+ autobus
    noun2(bess,bus). 
    noun2(bgus,bus).  %% sp
    noun2(bguss,bus). %% sp 
    noun2(biss,bus). 
    noun2(boss,bus). 
    noun2(brss,bus).   
    noun2(bruss,bus).  
    noun2(bsss,bus).   %%  own
    noun2(bsus,bus). 
    noun2(buass,bus).    
    noun2(bud,bus). 
    noun2(budd,bus).  
    noun2(bugg,bus).   
    noun2(buess,bus). 
    noun2(buis,bus).   %% own 
    noun2(burs,bus).   
    noun2(burss,bus).  
    noun2(bus,bus).    %% \eng
    noun2(busd,bus).   %% TA-101230
    noun2(busr,bus).    
    noun2(busrs,bus). 
    noun2(bussee,bus).        %%  spc
    noun2(bussekspress,bus).  
    noun2(bussernummer,bus). 
    noun2(busskj�ret�y,bus). 
    noun2(busskyss,bus).
    noun2(busselinje,bus). 
    noun2(bussertype,bus).  
    noun2(bussforbindelse,bus). 
    noun2(bussforbinnelse,bus).        %%   (slight spell)
    noun2(busslinie,bus). 
    noun2(busslinje,bus).
    noun2(bussrs,bus).  
    noun2(busnummer,bus). 
    noun2(busforbindelse,bus). 
    noun2(bussj,bus).    %%  freak
    noun2(bussrutenummer,bus).  
    noun2(bussruteinformasjon,bus). %% telebuster
    noun2(busss,bus).   
    noun2(busstransport,bus). 
    noun2(busstype,bus).    
    noun2(bussurute,bus). 
    noun2(bussvrak,bus).  
    noun2(buus,bus).                   %% common spell
    noun2(buuss,bus). 
    noun2(buyss,bus).  
    noun2(buz,bus).  
    noun2(buzz,bus).   
    noun2(bvss,bus). 
    noun2(bvuss,bus).                  %%   neib k
    noun2(byss,bus).  
    noun2(b�ss,bus).  
    noun2(dagbuss,bus).            %% rough, adequate
    noun2(direktebuss,bus).            %%  ( answer will be adequate)
    noun2(ekspressbuss,bus). 
    noun2(ettermiddagsbuss,bus).       %% (rough)

%%    noun2(expressbuss,bus).            %% otherbus 
    noun2(hovedvogn,bus). %% i.e. the ordinary bus 
    noun2(jobbuss,bus).  %% rough 
    noun2(lokalbuss,bus).              %% ( direktebuss?)
    noun2(lokaltransport,bus).  %% Rough
    noun2(matebuss,bus). 
    noun2(muss,bus).                   %%  spc 
    noun2(mbuss,bus).     
%%     noun2(nbuss,nightbus).  %% ?//or slip
    noun2(nus,bus). 
    noun2(nuss,bus).  
    noun2(omnibuss,bus). %% ss
    noun2(puss,bus). 
    noun2(returbuss,bus). %% TA-100907
    noun2(rutebus,bus).  
    noun2(rutebuss,bus).  
    noun2(ruteuss,bus).   %% sp
    noun2(rutebus,bus). 
    noun2(rutebil,bus).  
    noun2(servicerute,bus).       %% ?
    noun2(skibuss,bus).                %%  (???) Oppdal
    noun2(teambuss,buss).      %% Rough
    noun2(trondheimsbuss,bus).  
    noun2(ubss,bus). 
    noun2(vuss,buss).  

%% noun2(c 

%% noun2(d 

%% noun2(e 

noun2(effekt, effect).   
    noun2(virkning,effect). 

noun2(ekspert,expert).
noun2(ekspertsystem,expertsystem). 

noun2(eksport,export). %% database - 
    noun2(leveranse,export). %% rough, techn.


noun2(ekstraavgang,extrabus). 
    noun2(assistansebuss,extrabus). 
%%     noun2(arbeidsbuss,extrabus).  %%  scheduled , not extra 
    noun2(assistansetur,extrabus). 
    noun2(chartertur,extrabus).     
    noun2(dublering,extrabus).       %%  rough
    noun2(extrabuss,extrabus).  
    noun2(ekstrabuss,extrabus). 
    noun2(ekstrarute,extrabus).   
    noun2(ekstratur,extrabus).  
    noun2(ekstravgang,extrabus).   
    noun2(ekstrakj�ring,extrabus).   
    noun2(fotballbuss,extrabus).  
    noun2(gratisbuss,extrabus).  
    noun2(helsebuss,extrabus).    
    noun2(skolebus,extrabus).  
    noun2(skolebuss,extrabus).  
    noun2(skolerute,extrabus).
    noun2(skoletur,extrabus).  
    noun2(spesialbuss,extrabus).  
    noun2(spesialrute,extrabus).
    noun2(sightseeing,extrabus).     %% TA-100902 
    noun2(spesialtur,extrabus).  
    noun2(tilleggrute,extrabus).     %% SIC
    noun2(tilleggsrute,extrabus).
    noun2(utleiebuss,extrabus). 

noun2(ekstrainformasjon, extrainfo). 
   noun2(oppslag, extrainfo). 

noun2(eldre,elder).      %%  also adj
%%%     noun2(gamle,elder).  %%   Created havov with gamle oslo vei

noun2(elv,river). 

noun2(estimat,estimate).         %% TA-110503
    noun2(tidsestimat,estimate). %% rough
noun2(evne,ability). 

% noun2(f 

noun2(font,font).   
    noun2(fontst�rrelse,font). %% rough 

noun2(forsker,researcher). %% TA-110204 .. scientist

noun2(fotnote,footnote). 

noun2(bussbillett,ticket).  
noun2(bussorakel,oracle). 
   noun2(busorakel,oracle).     %% TA-101117
   noun2(bussorakl,oracle).     %% AD Hoc  -et %%  Rule
   noun2(bussorakal,oracle).  
   noun2(bussorkel,oracle).  
   noun2(bussoraklel,oracle). %% sp
   noun2(bussruteorakel,oracle).       %% ( rather subclass of)
   noun2(orakeltjeneste,oracle).       %% Hva vet du om bussavganger
   noun2(orekel,oracle).        %%  own

noun2(butikk,shop). 
   noun2(butik,shop).  
%%%%%%   noun2(kiosk,shop).  %% rough %%  suspended
   noun2(utsalgssted,shop). 

noun2(fot,foot). %% til fots 


%% noun2(h 

noun2(hellidagsrute,holidayroute). 
    noun2(helgerute,holidayroute).     %%  ? rough ?
    noun2(helligrute,holidayroute).    %%
    noun2(helligdagrute,holidayroute). 
    noun2(helligdagsrute,holidayroute). 
    noun2(hellidagsrute,holidayroute).   
    noun2(hellgdagsrute,holidayroute). 


noun2(helse,health). 
    noun2(bedring,health). %% rough %% TA-101110
noun2(hode,head). 
    noun2(hue,head). %% dial

noun2(hodepine,headache). %% :-)

noun2(holdeplass,station).          % Fronted as official name
    noun2(bussholdepalss,station). 
    noun2(bussholldeplass,station).
    noun2(rutestopp,station). 
    noun2(busholdingplass,station).  
    noun2(busholdingsplass,station). 
    noun2(bussholdingplass,station).  
    noun2(bussholdingsplass,station). 
    noun2(bussholdplass,station). 
    noun2(bussholdeplas,station).  
    noun2(bussholdeplass,station). 
    noun2(busholdeplass,station). 
    noun2(bussholdeplss,station).   %% spc 
    noun2(bussholderplass,station). %% spell 
    noun2(bussholeplass,station).   %% spell
    noun2(busshldeplass,station).  
    noun2(busshlderplass,station). 
    noun2(bussplass,station). 
    noun2(bussruteholdeplass,station). 
    noun2(bussted,station). 
    noun2(busssted,station).
    noun2(haldeplass,station). 
    noun2(hldeplass,station).  
    noun2(holdelass,station). 
    noun2(holdeplassnavn,station).   %%  rough
    noun2(holdeplassnummer,station). %% rough
    noun2(holdeplats,station).  
    noun2(hodeplass,station). 
    noun2(hokdeplass,station).      %% own sp
    noun2(holdepalss,station). 
    noun2(holdepas,station).  
    noun2(holdepass,station).       %%
    noun2(holdeplas,station).  
    noun2(holdesplass,station).  
    noun2(holdplasss,station). 
    noun2(holdeplasss,station).     %%  own sp
    noun2(holeplass,station). 
    noun2(holgeplass,station).      %% sp
    noun2(holpdeplass,station).     %% sp
    noun2(hopldplass,station).  
    noun2(hopldeplass,station).     %%
    noun2(hpldeplass,station).      %%  own
    noun2(h�ldeplass,station).  
    noun2(h�llplass,station).   
    noun2(h�ldeplass,station).  
    noun2(joldeplass,station).      %% own sp
    noun2(perrong,station).         %% Rough
    noun2(perong,station).          %% Rough
    noun2(stoppeplass,station).  
    noun2(stopplass,station).  

noun2(import,import).
    noun2(innleggelse,import).
    noun2(innlegg,import).


noun2(stabilitet,stability). %% opposite error 

noun2(stasjon,station). %% hvilken stasjoner finnes p� huseby 
    
    noun2(busstasjon,station). 
    noun2(bustop ,  station).  
    noun2(bustopp,  station).  
    noun2(bustasjon,station).  
    noun2(bussasjon,station). 
    noun2(bussstasjon,station). 
    noun2(busstopp, station).      
    noun2(busstop,  station). 
    noun2(busstropp,  station). 
    noun2(bussstopp,station).
    noun2(bussstop,station).  
    noun2(busslomme,station). 
    noun2(busskur,station). 
    noun2(holdpelass,station). 
    noun2(holdplass,station). 
    noun2(holdested,station).       %% (dansk?)
    noun2(holderplass,station).     %% spell
    noun2(passeringsplass,station). %%  (SIC)    
    noun2(paseringsplass,station).  %%  (SIC)    
    noun2(passeringssted,station). 
    noun2(platform,station).  
    noun2(plattform,station).       %% (also computer) 
    noun2(rutebusstasjon,station). 
    noun2(starsjon,station).        %%  sp
    noun2(stasjoin,station).       %% own 


noun2(bussterminal,  busterminal). 
   noun2(busterminal,  busterminal).  %%  ? lang
   noun2(busstarminal,  busterminal). %% sp
   noun2(busstermin,  busterminal). 
   noun2(busstorg, busterminal).     
   noun2(rutebilstasjon, busterminal). 
    

noun2(busspris,price). 


noun2(bussreise,bus).           %% (pragmatix)
noun2(busstur,bus).             %% (pragmatix)
    noun2(bussertur,bus).    


%% NB For the paraphrase takes the first norwegian word
%% Therefore, bussrute must come first !

%% route placed first  %% priority is preserved now

noun2(rute,route).    % NB ambiguous
    noun2(bussnummer,route). %% bus). 
    noun2(busrute, route). 
    noun2(busrutte,route). 

%%      noun2(bussrute,bus). %%  //kan se i bussrite/ikke i buss

    noun2(bussrtue,route).      %%  own
    noun2(bussrutete, route).   %%  Sp
    noun2(bussryte,route).
    noun2(bybussrute, route).   
    noun2(bussmulighet,route). 
    noun2(busssrute,route).     %% sp
    noun2(limje,   route).      %% sp
    noun2(linje,   route).      %% sometimes they mean the route
    noun2(lnje,    route).      %% sp 
    noun2(linjenummer,route). 
    noun2(kj�rerute,  route). 
    noun2(kurs,   route).    
    noun2(line,    route).  
    noun2(melkerute,  route).      %%:-)
%%     noun2(nummer,  route):-   \+ user:myflags(teleflag,true). 

    noun2(nussrute,route).   %% sp
    noun2(reiserute,  route).   %% route_plan
    noun2(ringrute,  route). %% rough, "ringrute" ako route
    noun2(rude,    route). %%  DK
    noun2(runte,   route).
    noun2(rut,     route).
    noun2(rutenummer, route).
    noun2(rutte,   route). 
    noun2(lokalrute,  route). 
    noun2(ruteforbindelse,route). %% .. for nattbussen
    noun2(rutetibud, route). 
    noun2(rutetilbud, route).  

    noun2(rutrtilbud, route). 
    noun2(tilbud,  route).  
    noun2(tute,    route). %% own 
   %%  noun2(tur,route). %% bus).   %% FAPP trip).     hva koster en tur ? 

noun2(turtype,tourtype). %% TA-101008



noun2(bussrute,route).      %% Prefer this one (bussrute for buss 5)
    noun2(bursrute,route).  
    noun2(burssrute,route).
    noun2(busrsrute,route).
    noun2(busserute,route).  
    noun2(busserrute,route).  %% spiw 
    noun2(busstute,route).  
    noun2(busstilbud, route). 
    noun2(lokalbusstilbud, route).  %% rough


noun2(ruteplan, route_plan). %% abstract, not a vehicle
    noun2(busskj�ring, route_plan). 
    noun2(busstilbud,  route_plan). 
    noun2(busstrafikk, route_plan).
    noun2(bustrafik,route_plan).   %% etc
    noun2(busskj�ring, route_plan). 
    noun2(busstilbud,  route_plan). 
    noun2(busstrafikk, route_plan).
    noun2(bustrafik,route_plan).   %% etc
    noun2(rutevariant,route_plan). 
    noun2(tidtabell,route_plan).  %% ambiguous  tidtabell om avganger

%     noun2(rute,route_plan).       %%  ( Ambiguous !) NO! 36 -> route_plan  %% M� st� etter route
%     noun2(rutetid,route_plan).    %%  ( Ambiguous !) 

    noun2(l�rdagskj�ring, route_plan). %% rough ad hoc
    
    noun2(ruteformat,route_plan). %% rough ad hoc %% TA-110426

    noun2(s�ndagskj�ring, route_plan). %% rough ad hoc 
  
noun2(alternativ,way). %% alternative). 

noun2(antall,count).          %% (?)


noun2(by,city). %%  destroys  Anders Byens gate 
    noun2(bygrense,city). %% rough

noun2(bybuss,bus). 

noun2(ferge,boat).
    noun2(bat,boat). 
    noun2(b�t,boat).  
       noun2(bot,boat). %% fine ?
    noun2(b�t,boat).  
    noun2(baat,boat).  
%     noun2(b�trute,boat). %% confuse with brp 
    noun2(b�tforbindelse,boat). 
    noun2(b�tskyss,boat). 
    noun2(ekspressb�t,boat).
    noun2(ferje,boat). 
    noun2(hurtigrute,boat).
    noun2(kystbuss,boat). 
    noun2(skip,boat). 
%%     noun2(skute,boat). %% NB skuter

%% nouan2(d 

noun2(dag,day).              
    noun2(dagg,day).  
    noun2(ukedag,weekday).       %%   ( day ?)
    noun2(ukadag,weekday). 

noun2(dagkode,daycode).
    noun2(dagskode,daycode). 


noun2(dagtid,daytime).

noun2(data,data). 
   noun2(datasett,data).     %% TA-110429
   noun2(testdatasett,data). %%

noun2(database,database). 
    noun2(arkiv,database).
    noun2(nyhetsarkiv,database).  %% rough 
    noun2(navnekatalog,database). %% rough   i bussoraklet
    noun2(rutedatabase,database). %% rough 

noun2(datamaskin,computer).
    noun2(automat,computer).
    noun2(automatsvarer,computer). 
    noun2(computer,computer). 
    noun2(dampmaskin,computer).  %%  :-)
    noun2(datamanskin,computer).
    noun2(dator,computer). 
    noun2(kompjuter,computer).
    noun2(maskin,computer).
    noun2(maksin,computer).  
    noun2(maskkin,computer). 
    noun2(orakelserver,computer). 
    noun2(prosessor,computer).
    noun2(server,computer).        %%  ( ako )
    noun2(mellomserver,computer).  %% SIC
    noun2(tjener,server). 
    noun2(pc,computer).  % no inclination
    noun2(terminalserver,computer).  %%  rough 



noun2(dato,date).
noun2(datter,daughter).  

noun2(definisjon,definition). 
    noun2(definering,definition).
    noun2(omdefinering,definition).

noun2(del,part). 
    noun2(avsnitt,part). %% rough %% TA-121817
    
noun2(detalj,detail). %% rough

noun2(reisem�l,destination).
    noun2(avstigningsholdeplass,destination).
    noun2(bestemmelsessted,destination). 
    noun2(destinasjon,destination). 
    noun2(tilsted,destination).

noun2(lege,doctor).   
    noun2(doktor,doctor). 

noun2(prototype,prototype). 
   noun2(demo,prototype). 
   noun2(flybussdemo,prototype). %% rough
   noun2(demonstrator,prototype).
   noun2(imponator,prototype). 
   noun2(pilot,prototype). 
   noun2(prototyp,prototype).  %% TA-110427

noun2(dialektord,word). %% rough 

noun2(dialog,dialogue).          %%  Eng. spell.
noun2(diesel,oil).               %%  ( rather ako oil)
noun2(direkterute,directroute). 
noun2(dokument,document).  
noun2(domene,domain).            %%  Omr�de abstract

noun2(drift,operation). %% i drift
    noun2(operasjon,operation). 
    noun2(funksjonalitet,operation). %% rough ..
    noun2(vedlikehold,operation). %% rough .. 
    noun2(virkem�te,operation).   %% rough 

noun2(drink,drink).  
noun2(drikk,drink).     %% e.g. beer 
noun2(drivstoff,fuel).
    noun2(brensel,fuel).  
    noun2(brennstoff,fuel). 
    noun2(drivsstoff,fuel). 

noun2(dyr,animal).  %% also expensive 
    noun2(husdyr,animal).
    noun2(kj�ledyr,animal). 
noun2(d�gn,day). 
    noun2(driftsd�gn,day). %% rough
noun2(d�gndel,daypart).             %%  Internal
    noun2(d�r, door).  %% Experiment   D�ra -> Dora *
    noun2(d�rr, door). %% Dialect 

noun2(egenskap,property).  

noun2(eier,owner). 

noun2(eksempel,example). 
    noun2(innspill,example). %% rough 

noun2(eksistens,existence). 

noun2(ektefelle,spouse). 
    noun2(partner,spouse).
    noun2(samboer,spouse).


noun2(ektemann,husband). 

noun2(ankomststed,destination). 
noun2(avgangssted,origin). 

noun2(endestasjon,endstation).
    noun2(endedtasjon,endstation).      %% sp
    noun2(deholdeplass,endstation).     %% en de.. 


    noun2(endepunkt,endstation). 
    noun2(endestason,endstation). 
    noun2(endestation,endstation). %%   Own spc
    noun2(endeterminal,endstation).
    noun2(endeholdeplass,endstation).
    noun2(endeholdeplassnavn,endstation). %% metagoric
    noun2(endeholdplassnavn,endstation). %% sic
    noun2(endeholderplass,endstation).  %%  #-> soft commonword spellcorr
    noun2(endestopp,endstation). 
    noun2(endeplass,endstation). 
    noun2(startholdeplass,endstation).

/*  %% snuplass,\= endeholdeplass  ?
    noun2(snuplass,endstation).  
    noun2(snuholdeplass,endstation).  
    noun2(snuholderplass,endstation). 
*/

noun2(ruteendring,modification). %% 1. 
    noun2(endring,modification). %% change = transfer  
    noun2(enedring,modification). 
    noun2(forandring,modification).  
    noun2(forbedring,modification). 
    noun2(ruteskifte,modification). %% TA-110804
    noun2(takstendring,modification). 

/*
noun2(endring,change).  // transfer?
    noun2(enedring,change). 
    noun2(forandring,change).  
    noun2(forbedring,change). 
    noun2(ruteendring,change). 
*/


%%     noun2(skifte,transfer).  

noun2(erfaring,experience). 

noun2(ervervelse,acquisition). 
    noun2(erverv,acquisition). 

noun2(etage,floor).  
    noun2(etasje,floor).
    noun2(etg,floor). 

noun2(etternavn,lastname). 

noun2(ettermiddag,afternoon). 
    noun2(ettermidag,afternoon). 
    noun2(etermiddag,afternoon). 
    noun2(etermidag,afternoon). 
    noun2(ettermidag,afternoon). 
    noun2(eftermiddag,afternoon).
    noun2(ettermiddagstid,afternoon). 
    noun2(ettermidsdag,  afternoon). 

noun2(ettermiddagsrute,eveningroute). 
    noun2(kvedsrute,eveningroute).   %% sp
    noun2(kveldsrute,eveningroute). 
    noun2(kveldsbuss,eveningroute). 
    noun2(kveldrute,eveningroute). 
    noun2(kveldbuss,eveningroute). 


%% naoun2(f 

noun2(familie,family).  
    noun2(familiemedlem,family). 
    noun2(slektning,family). 

noun2(fang,lap).

noun2(far,father).  
    noun2(papa,          father). 
    noun2(pappa,         father).     %%

noun2(farge,colour).
    noun2(bakgrunnsfarge,colour). %% not bus
    noun2(farve,colour).

noun2(ferje,boat).
noun2(ferge,boat).

noun2(ferjerute,boat_route_plan). 
    noun2(b�trute,boat_route_plan). %%

noun2(ferie,vacation).       %%  (not holiday). Techn. term
    noun2(ferieruter,vacation). 
    noun2(fri,vacation).     %% rough :-) %%  fri tiden
    noun2(fritid,vacation).  %%  (Rough definition,, but vague answer anyhow)
    noun2(vinterferie,vacation).  
    noun2(vinterferieruter,vacation). %% ?
    noun2(vinterferieuke,vacation).
    noun2(v�rferie,vacation).  
    noun2(sommerferieferie,vacation).  
    noun2(h�stferie,vacation).  

noun2(feil,error).
    noun2(avvik,error).  
    noun2(bug,error).           %% NB skal ikke b�yes som subst.// buger*
    noun2(driftsforstyrrelse,error).  
    noun2(feiltagelse,error).  
    noun2(feilrapport,error).   %% rough 
    noun2(feilrate,error).      %% rough
    noun2(konflikt,error).      %% rough
    noun2(inkonsistens,error).  %% 
    noun2(krise,error).         %% rough
    noun2(programfeil,error). 
    noun2(signalfeil,error).    %% TA-110614
    noun2(skrivefeil,error).    %% rough 
    noun2(stavefeil,error).     %% rough 
    noun2(svakhet,error).  
    noun2(svikt,error).  
    noun2(systemsvikt,error).   %% TA-101018
    noun2(tabbe,error). 
    noun2(uregelmessighet,error). %% 
    noun2(uregelmeesighet,error). %% sp
    noun2(ustabilitet,error).     %% 


noun2(feilmelding,errormessage).
    noun2(feilopplysning,errormessage). 
    noun2(hastemelding,errormessage). %% rough 
    noun2(innvending,errormessage). %% rough 
    noun2(innvening,errormessage). %%

noun2(fetter,cousin). 
    noun2(niese,cousin).


noun2(fil,file). 
noun2(film,movie). 
%%%     noun2(kino,movie). %%  Rough, Hazard? // for bus, it is a place

noun2(fjell,mountain).  
    noun2(fjeld,mountain).       %% DK 
    noun2(fjelltopp,mountain).  
%%    noun2(berg,fjell).         %%  Berg stasjon
noun2(fjor,lastyear).            %% Technical  (i) fjord 
noun2(fjord,fjord). 
noun2(flaks,luck).               %% \+ Flakk ?
noun2(flate,surface).            %%  (Meta)

noun2(flertydighet,ambiguity). 

noun2(flexibuss,flexibus). 
    noun2(fleksibuss,flexibus). 

noun2(fly,airplane). 
   noun2(flyankomst,airplane).
   noun2(flyselskap,airplane).
   noun2(nattcharter,airplane).
   noun2(romskip,airplane).     %% :-)
   noun2(romferge,airplane). 

noun2(flyankomst,airplane_arrival).  %%
   noun2(flyankomsttid,airplane_arrival). %% rough

noun2(flyavgang,airplane_departure).
    noun2(flyavgangstid,airplane_departure).

noun2(flybuss,airbus).  
   noun2(flubuss,airbus). 
   noun2(flybbus,airbus).    %% sp
   noun2(flybiss,airbus).    %%  own
   noun2(flybbuss,airbus).   %%
   noun2(flybus,airbus).  
   noun2(flybusss,airbus).  
   noun2(flybussavgang,airbus).
   noun2(flybussekspress,airbus). 
   noun2(flybussrute,airbus). 
   noun2(flybusstid,airbus).    %% (Roughly)
   noun2(flygbuss,airbus).      %% (Sw)
   noun2(flyrute,airbus).       %% ???
   noun2(flyvebuss,airbus).  
   noun2(fybuss,airbus).  
   noun2(lufthavnbuss,airbus). 
   noun2(lufthavnsbuss,airbus). %%
 
noun2(flybussterminal,airbusterminal).  
   noun2(flybussholdeplass,airbusterminal).

noun2(flyplass,airport).
   noun2(flypass,airport). 
   noun2(flyplasss,airport). 
   noun2(flyplats,airport).   %%    (Swedish)
   noun2(flygplats,airport).  %%    (Swedish)
   noun2(flyghavn,airport).   %%    (Danish)
   noun2(flyhavn,airport).  
   noun2(lufthavn,airport).   %%

noun2(forfalskning,forgery).

noun2(forhold,condition). 
    noun2(bymilj�,condition).  
    noun2(forutsetning,condition).  %% TA-110426
    noun2(infrastruktur,condition). 
    noun2(milj�,condition). 
    noun2(omstendighet,condition). 
    noun2(vilk�r,condition).         %% TA-110426

noun2(forbindelse,connection). %%  (Overgang)
    noun2(forbindeles,connection).  %% own 
    noun2(samband,connection).
    noun2(tilknytning,connection). 
    noun2(tilknyttning,connection).
    noun2(tr�d,connection).    %% holde tr�den %%  rough
    noun2(videreforbindelse,connection). 

noun2(forbindelse,bus).   %%          
    noun2(direkteforbindelse,bus). %%   Rough

noun2(foreldre,parent).

noun2(forestilling,show). 
noun2(forfatter,author).  
noun2(forg�rs,day_before_yesterday).

noun2(forhold,relation).  

noun2(forkortelse,abbreviation).  
noun2(forklaring,explanation). 
    noun2(anvisning,explanation). 
    noun2(oppklaring,explanation). 

noun2(format,format). 
    noun2(form,format).    
    noun2(design,format).  

noun2(formel,text). %% rough 


noun2(formiddag,prenoon).   %% Norw formiddag

noun2(fornavn,firstname).  

%% noun2(formiddag,morning). // i formiddag -> i morgen -> tomorrow***
    noun2(formidag,morning). 
    noun2(forrmidag,morning).  
    noun2(forrmiddag,morning). 
    noun2(frokost,morning).      %% ( "after breakfast")
    noun2(frokosttid,morning).   %% NB i frokosttid = i morgen ???
    noun2(frukost,morning).      %% NN
    noun2(f�remiddag,morning).   %% NN 
    noun2(f�rmiddag,morning).    %%
 %%    noun2(mj�lketid,morning). %% amb

noun2(forside,front). 

noun2(forskjell,difference). 

noun2(forsinkelse,delay). 
    noun2(bussforsinkelse,delay).
    noun2(forsenking,delay).      %%  NN
    noun2(forsinkelsestid,delay). 
    noun2(k�,delay).              %% ( rough)
%     noun2(ventetid,delay). 

    noun2(tidligankomst,earlyarrival). %% Techn

%% noun2(forslag,proposal). %% noun3 %% to forslag  NB oppfordring er m 
    noun2(oppfordring,proposal). %% question). 

noun2(forst�else,understanding). 

noun2(fors�k,attempt). 

noun2(fortid,past). 
noun2(forvei,advance). %% tech. i forveien 

noun2(forventning,expectation). 

noun2(forvirring,confusion).  
   noun2(navneforvirring,confusion). %% etc 

noun2(framkommelighet,flow).    %% rough 
   noun2(fremkommelighet,flow). %% traffic


noun2(framtid,future).
   noun2(fremtid,future). 
   noun2(fremmtid,future). 

noun2(framvisning,presentation).   
    noun2(fremvisning,presentation). 

noun2(frase,phrase).         %%   (Meta)

noun2(front,front).  

noun2(funksjonshemmede,handicapped). %% inflection as for ADJ
   noun2(blind,handicapped). %% rough ...
   noun2(blinde,handicapped). %% rough ...
   noun2(bevegelseshemmede,handicapped). 
   noun2(bevegelseshemmet,handicapped). 
   noun2(bevegelseshemmete,handicapped). 
   noun2(d�vblind,handicapped). 
   noun2(d�vblinde,handicapped). 
   noun2(funksjonshemmet,handicapped). 
   noun2(funksjonshemmete,handicapped). 
   noun2(handicapped,handicapped).   
   noun2(handicappede,handicapped).  %%  adj/noun flex
   noun2(handicaped,handicapped). 
   noun2(uf�r,handicapped). %% plu
   noun2(uf�re,handicapped). %% plu
   noun2(uf�retrygdede,handicapped). 


noun2(fylke,county).
noun2(f�lelse,feeling).      %%  (Meta)
   noun2(affekt,feeling). 

%% noun2(g 


noun2(gang,time_count).      %%  ( Norwagism, how many times )
   noun2(gong,time_count).   %% NN
    %%    noun2(gang,trip).     %% togets gang  ? %% TA-110511

noun2(gangavstand,walking_distance). 
   noun2(g�avstand,walking_distance).

noun2(gangtid,walking_time). %% TA-110419


noun2(gass,gas).
noun2(gassbuss,gasbus). 
noun2(gate,street). 
    noun2(gade,street).  
    noun2(gatekryss,street). 
noun2(gatenavn,street).      %%  (?)
noun2(gatenummer,streetnumber).  
    noun2(gatunummer,streetnumber). 
noun2(gatebokstav,streetcharacter). 
noun2(gebyr,fine).         
   noun2(avgift,fine).       %% rough 
   noun2(bot,fine).          %%
   noun2(politianmeldelse,fine). %%  rough 
   noun2(semesteravgift,fine). %%  rough /ugly 
   noun2(straffegebyr,fine). %%        

noun2(geni,genious).         %%  :-)
   noun2(luring,genious).         %%  :-)   
   noun2(smarting,genious). 

noun2(generering,creation).

noun2(gjennomsnitt,average). 
    noun2(snitt,average).  

noun2(glede,happiness). %% (joy)

noun2(godkjenning,approval). 

noun2(grense,border).  
noun2(grense,limit). 

noun2(grensesnitt,interface).   
    noun2(brukergrensesnitt,interface). %% TA-110705
    noun2(grenesnitt,interface). %% own

noun2(gruppe,group). 

noun2(gud, god). 
    noun2(herregud, god). 
noun2(gutt,boy). 
    noun2(dreng,boy).
    noun2(gut,boy). 

noun2(gyldighet,validity). %% application? 

noun2(g�te,problem). %% "gate" %% TA-110708

%% noun2(h 


noun2(halvtime,halfhour). 
   noun2(halltime,halfhour). %% spiw
noun2(halv�r,halfyear). 
noun2(hastighet,speed).
    noun2(busshastighet,speed). 
    noun2(fart,speed). 
    noun2(fartsgrense,speed).  
    noun2(gjennomsnittsfart,speed). 
    noun2(gjennomsnittshastighet,speed). 
    noun2(maksfart,speed).
    noun2(makshastighet,speed). 
    noun2(maksimalfart,speed).
    noun2(maksimalhastighet,speed). 
    noun2(toppfart,speed). 
    noun2(topphastighet,speed). 

noun2(hav,ocean).  
noun2(havn,harbour).
noun2(heis,lift). 
noun2(helikopter,helicopter). 

noun2(hendelse,event). 
   noun2(begivenhet,event).     %% ?
   noun2(episode,event).     
   noun2(hendelse,event).       %% ?

noun2(hendelsesforl�p,coevent).  %%

noun2(hensyn,consideration). 

noun2(henvisning,reference). 
    noun2(peker,reference).  

noun2(hest,horse). 
    noun2(h�st,horse).


noun2(hestekrefter,horsepower). %%  lazy:   hestekreft(er))
%%  noun2(hest,horsepower).

noun2(hjelp,help).            %% ( hazardous ?)
    noun2(guide,help).     %% TA-110724
    noun2(st�tte,help).    %% TA-110701
%%    noun2(hj�lp,help).   %% syn 

noun2(hjem,home). 
%% noun2(hjul,wheel). %% noun3

noun2(hotell,hotel). %%  Til elgeseter hotell = NO ERRM 

noun2(hovedstad,capital). 
   noun2(hovudstad,capital). %% NN
noun2(hukommelse,memory). 
    noun2(hukomelse,memory). %%  spc
    noun2(minne,memory). 
noun2(hum�r,humour).           %% :-)
   noun2(humor,humour).        %% TA-110114

noun2(hund,dog).             %% (actual, avoids hund = Lund)
    noun2(bikkje,dog). 
    noun2(f�rerhund,dog).    % rough 
    noun2(politihund,dog).   %

%% noun2(hurtigrute,boat).  %% shadows Pirterminalen
noun2(hus,house). 
    noun2(bygg,house).  
    noun2(bygning,house). 
    noun2(hybel,house).      %% rough

noun2(hydrogen,hydrogen). 
noun2(hyppighet,frequency).
    noun2(avgangsfrekvens,frequency). 
    noun2(avgangshyppighet,frequency).
    noun2(bruksfrekvens,frequency). 
    noun2(bussfrekvens,frequency). 
    noun2(frekvens,frequency).
    noun2(rutefrekvens,frequency).
    noun2(tidsintervall,frequency).    %%  (for all pp) 
    noun2(tidsinterval,frequency).     %% spell

noun2(helg,weekend). 
    noun2(hellg,weekend). 
    noun2(langhelg,weekend). 
    noun2(weekend,weekend).
noun2(helligdag,holiday).     %%  NOT SUNDAY 
    noun2(helgedag,holiday).  %%  NOT SUNDAY
    noun2(heligdag,holiday). 
    noun2(helidag,holiday).   %%
    noun2(hellidag,holiday). 
    noun2(rutehellidag,holiday).  
    noun2(rutehelligdag,holiday).  
    noun2(rutehellogdag,holiday). %% sp
    noun2(r�dag,holiday).  %% sp
    noun2(r�ddag,holiday). %% sp

noun2(hilsen,greeting).       %% IDIOM ?
   noun2(hilsn,greeting). %% -> hilsner


noun2(himmel,sky). %%  rough 
    noun2(sky,sky). %% N: "cloud"
   %% noun2(himmel,airplane). %%  rough
   %% noun2(himmel,airport).

noun2(historie,story).  

noun2(holdeplasstid,departure). %% (SIC)

noun2(hurtigb�t,boat).
noun2(hverdag,weekday). 
    noun2(arbeidsdag,weekday).
    noun2(hverdagsmorgen,weekday). %%  ( OR morning ?)
    noun2(hv�rdag,weekday).  
    noun2(reisehverdag,weekday). %% rough
    noun2(virkedag,weekday). 
    noun2(v�rdag,weekday).

noun2(hverdagsrute,workdayroute).   %% 
   noun2(hverdagsbuss,workdayroute).
   noun2(fredagstid,workdayroute).  %% Rough
   noun2(verdagsrute,workdayroute). 


noun2(h�st,autumn). 
    noun2(haust,autumn). 
noun2(h�yde,height). 


noun2(h�ytidsdag,holiday). %% not just sunday ?????
    noun2(h�ytid,holiday).

noun2(h�nd,hand). 
    noun2(h�nd,hand).

noun2(h�ndtering,management). %% handling?
    noun2(disponering,management).

noun2(h�p,hope). %% haz ? 

%% noun2(i 

noun2(ide,idea).  
    noun2(fokus,idea). %% rough 
    noun2(perspektiv,idea). 
    noun2(tanke,idea). 
    noun2(tenking,idea). %% TA-100905

noun2(inspirasjon,inspiration). 
noun2(instruksjon,instruction). 

/* Idrettsplassen jakobsli %% TA-100828
noun2(idrettsanlegg,sportscentre). 
    noun2(idrettsplass,sportscentre).
    noun2(idresttsbygg,sportscentre). 
*/

noun2(indikasjon,indication). 

noun2(informasjon,information).
    noun2(anelse,information).
    noun2(detalj,information). 
    noun2(informason,information). 
%%    noun2(bussruteinformasjon,information). %%  (#bus specific!)
    noun2(dokumentasjon,information). 
    noun2(info,information). 
    noun2(infomasjon,information).  %% spc 
    noun2(informasion,information). 
    noun2(information,information). 
    noun2(innformasjon,information).
    noun2(instruks,information).
%     noun2(logg,information).        %%   Rough
    noun2(logikk,logic).  
    noun2(peiling,information). 
    noun2(ruteinformasjon,information).
    noun2(ruteinfo,information). %% TA-110120
    noun2(skjerminformasjon,information). 
    noun2(tips,information). 
    noun2(prognose,information).  %% ? %% TA-101117

noun2(innf�ring,introduction). 

noun2(integrering,integration).  
   noun2(integrasjon,integration). 

noun2(interesse,interest).  
noun2(internett,internet).   %%  (changed from name due to internet syndrome)
noun2(intervall,frequency).  %%  for all p.p.
noun2(intelligens,intelligence).     %%  :-)
   noun2(fornuft,intelligence). 
   noun2(forstand,intelligence).  
   noun2(inteligens,intelligence).  
   noun2(intellegens,intelligence).   %%  sp
   noun2(iq,intelligence).  %% iqen
   noun2(vett,intelligence).         

noun2(ipadresse,ipaddress). 

noun2(iphone,smartphone).  %% generic %% TA-110725
noun2(htc,smartphone).     %% rough  

%% noun2(is,ice). %% weather -> iskrem 
%%    noun2(glattis,ice). 

noun2(ironi,irony). 

noun2(iskrem,icecream).  %% pizza, etc %%  spise p� buss
    noun2(is,icecream).

%% noun2(j 


noun2(jente,girl). 
    noun2(pike,girl).

noun2(jobb,job).             %%  (jobb! is unwanted)
    noun2(arbeid,job).
    noun2(arbeide,job). 
    noun2(arbeidstid,job).  %% rough  etter a 
%%     noun2(stilling,job).  %% -> title
    noun2(merarbeid,job).   %% TA-110607
    noun2(yrke,job).  
    noun2(samarbeide,job). %% rough (work)

noun2(jul,christmas).  %% christmas_route ???
    noun2(juleferie,christmas).
    noun2(julehelg,christmas).
    noun2(juleperiode,christmas). 
    noun2(juletid,christmas).
    noun2(mellemjul,christmas). 
    noun2(mellomjul,christmas). 
    noun2(romjul,christmas).



noun2(julerute,christmasroute).         %% _ 
   noun2(julerut,christmasroute).       %% dial
   noun2(juletabell,christmasroute). 
   noun2(juleurte,christmasroute).  
   noun2(julerurte,christmasroute).     %% 
   noun2(nytt�rsrute,christmasroute).   %%  (Rough)


%% noun2(k 

noun2(kl�r,clothing). %% plu 

noun2(konsistens,consistency). %% riktighet %% TA-110707

noun2(kort,card).  %% collides with Kort tid etter
    noun2(busskort,card).
    noun2(bankkort,card). 
    noun2(dagskort,card). 
    noun2(buskort,card).            
    noun2(bussmerke,card).
    noun2(dagkort,card). 
    noun2(familiekort,card). 
    noun2(fleksikort,card). 
    noun2(flerdagskort,card). 
    noun2(frikort,card).
    noun2(fylkeskort,card). 
    noun2(f�rerkort,card).  %% rough 
    noun2(klippekort,card).           %% (Rough, but so is answer (no info)  etc
    noun2(kredittkort,card).
    noun2(kortterminal,card). %% rough
    noun2(kredittkort,card). 
    noun2(kvantumsklippekort,card).
    noun2(kvantumskort,card). 
    noun2(kvantumsklippekort,card). 
    noun2(mastercard,card). 
    noun2(masterkort,card).  
    noun2(m�nadskort,card). 
    noun2(m�nedskort,card). 
    noun2(m�neskort,card). 
    noun2(m�nedsmerke,card).  
    noun2(m�ndesmerke,card). 
    noun2(m�nesmerke,card).   
    noun2(m�ndedskort,card).  
    noun2(halvm�nedskort,card). 
    noun2(oblat,card). %% rough 
    noun2(periodekort,card).  
    noun2(pluz,card).  
    noun2(pluzz,card). 
    noun2(rabattkort,card). 
    noun2(reisekort,card). 
    noun2(semesterkort,card). 
    noun2(sesongkort,card). 
    noun2(simkort,card). %% rough %% TA-110707
    noun2(skolekort,card).          
    noun2(studentbusskort,card).    
    noun2(studentkort,card).  
    noun2(studentm�nedskort,card). 
    noun2(trondheimkort,card). 
    noun2(trondheimskort,card). 
    noun2(studentm�nedskort,card). 
    noun2(tkort,card).  
    noun2(tilleggskort,card).   
    noun2(ungdomskort,card).          %% (Rough, but so is answer)
    noun2(ungdommskort,card). 
    noun2(ungdomsm�nedskort,card). 
    noun2(universalkort,card).
    noun2(visacard,card). 
    noun2(visakort,card).
    noun2(�konomikort,card). 
    noun2(�rskort,card). 
    noun2(bankkort,card). % not bus cards
    noun2(visakort,card). 




noun2(klasse,class).  




noun2(korrespondering,connection). 
noun2(korrespondanse,connection). 
    noun2(sammenheng,connection).
    noun2(samsvar,connection).

noun2(korridor,corridor). 

noun2(klage,complaint). 
    noun2(hjertesukk,complaint).   %% TA-110620
    noun2(kunderespons,complaint). %% fapp

noun2(klokkeslett,clock). %% NB Paraphrase sequence
    noun2(klokke,clock). 
    noun2(klokkeslettet,clock).  %% et //ok     
    noun2(klokkaslett,clock).   %% dial
    noun2(kjlokke,clock).  %%   slip
    noun2(klokeslett,clock).  
  
    noun2(klokk,clock). 

noun2(kommentar, comment).

noun2(kommune,community). 

noun2(kommunikasjon,communication).   
    noun2(internkommunikasjon,communication).
    noun2(internkomunikasjon,communication) . 
    noun2(komunikasjon,communication).

noun2(konkurranse,competition). 

noun2(kontor,office).  %% i.e. arbeidsplass
    noun2(arbeidsplass,office). %% Very rough 
    noun2(avdelingskontor,office). 
    noun2(servicekontor,office). %%  Hazard ??
    noun2(hovedkontor,office).   %% hovedkonoret til 
    noun2(informasjonskontor,office). 
    noun2(romnummer,office).  
    noun2(rommnummer,office).
    noun2(romnumer,office). 


noun2(krav,claim). 
    noun2(kriterium,claim). 
    noun2(minstekrav,claim).

noun2(kritikk,criticism). 
    noun2(ris,criticism).

noun2(krone,crown). 
    noun2(spenn,crown).  %%  Jargong
%% noun2(ku,cow).           %%  ?

noun2(kunde,customer). %% passenger ? 
    noun2(gjest,customer). %% guest? 


noun2(kunnskap,knowledge). 
    noun2(datakunnskap,knowledge). %% rough
    noun2(kompetanse,knowledge). 
    noun2(kunskap,knowledge). 
    noun2(viten,knowledge).      

noun2(kvardag,monday). 
noun2(kvarter,quarter).      %%  ( of an hour)
noun2(kvinne,woman).
    noun2(dame,woman).
    noun2(frue,woman). 
    noun2(kvinnfolk,woman). 
noun2(kveld,night).          %%  evening)
    noun2(kvald,night).      %% sp 
    noun2(kveill,night).  
    noun2(kvell,night). 
    noun2(aften,night). 
    noun2(kveldstid,night).      %%  evening). 
    noun2(kveldtid,night). 
    noun2(senkveld,night). 
    noun2(seinkveld,night).  
    noun2(senkvell,night).  
    noun2(seinkvell,night). 


noun2(kaffe,coffee). 

noun2(videokamera,camera).   %% TA-110121
    noun2(video,camera).     %% TA-110526
    noun2(kamera,camera).    %%         
 
noun2(kaos,chaos).   %% Hva er kaos ? :-)
noun2(kart,map). 
  noun2(karta,map). %% sv
  noun2(kartinformasjon,map). %% rough
  noun2(bykart,map). 
  noun2(busskart,map).  
  noun2(bussrutekart,map).  
  noun2(kartoversikt,map). 
  noun2(linjekart,map). 
  noun2(rutekart,map).  
  noun2(rutekarte,map).    
  noun2(oversiktskart,map).
  noun2(sentrumsterminalkart,map). %% rough 
  noun2(trondheimskart,map). 
  noun2(veikart,map).  

noun2(katt,cat).             %% actual, and to avoid misspelling katter = Kattem
    noun2(pus,cat).  %% TA-100927
noun2(kilometer,kilometer). 
noun2(kino,cinema).  
    noun2(kirke,church). 
noun2(kmt,kmh).  

noun2(kjekken,sweetheart). %% :-) %% ?
    noun2(s�ten,sweetheart).  %%   
%   noun2(s�ta,sweetheart). %% TA-110309 Busstuc er mann :-)

noun2(kopi,copy). 

noun2(kode,code). 

    noun2(kildekode,code).
noun2(kompliment,compliment).  
   noun2(komplimang,compliment).
   noun2(skryt,compliment). 


noun2(kone,wife). 
   noun2(kjerring,wife). 
   noun2(kj�rring,wife). 
noun2(konge,king).  
%%     noun2(kong,king). %% confuse kong inges gate 
noun2(konsert,concert). 
noun2(kontakt,contact). 
    noun2(kontaktperson,contact). 
noun2(konto,account).  
    noun2(kontonummer,account).    %%
noun2(kontroll,control).  
    noun2(billettkontroll,control).
noun2(kontroll�r,inspector).  


noun2(kj�pesenter,supermarket). 
noun2(kj�retid,departure).
noun2(kj�ret�y,vehicle).
    noun2(befraktningsmiddel,vehicle). 
    noun2(befraktningsm�te,vehicle).  
    noun2(vagn,vehicle).  %% Isl
    noun2(fremkomstmiddel,vehicle). 
    noun2(framkomstmiddel,vehicle).
    noun2(kjerre,vehicle).
    noun2(transport,vehicle). %% rough
    noun2(transportmiddel,vehicle). 
    noun2(vogn,vehicle). 
    noun2(vongn,vehicle).    %% sp
%%     noun2(nr,vehicle).   
%%     noun2(nummer,vehicle). %% nr 5 fra nth g�r EXPERIMENT
                              %% buss har nummer 8
noun2(kortleser,card_reader). %% t-kort
    %% noun2(leser,card_reader). %% haz?    

%% noun2(l 

%% noun2(lag,team).  %-> noun3 n   
    noun2(fotballag,team).  %% rough %% 
    noun2(fotballlag,team). %%

noun2(lager,storage). %% Haz ?

noun2(land,country). 
    naun2(nasjon, country).
    noun2(rike,   country). 

noun2(landomr�de,territory). %%  (technical) 
    noun2(landomr�de,territory). %
 

noun2(laventrebuss,lowentry_bus). 
noun2(laventre,lowentry).   %% Technical... buss har laventre


noun2(lengde,length). 

noun2(liff,liff). %%  :-))))

noun2(linjeskift,cr). %% carriage return %% TA-110303

noun2(liste,list).
    noun2(dump,list).  
%%%%%     noun2(utskrift,list).  
    noun2(vognliste,list). 
    noun2(listing,list). 
noun2(liv,life).
    noun2(eksistens,life). 
    noun2(tilv�relse,life).    

noun2(leddbuss,articulated_bus).

noun2(leder,leader).  
    noun2(arbeidsgiver,leader).   
    noun2(direkt�r,leader). 
    noun2(konsernsjef,leader). 
    noun2(mester,leader).  
    noun2(sjef,leader). 
%%     noun2(eier,leader).              %%  hvilken (person eier) bussen
%%     noun2(herre,leader).

noun2(ledsager,escort). %%  passenger

%% noun2(legesenter,healthcenter).  %% generic name

noun2(legitimasjon,identification). 
   noun2(h�nn�rbevis,identification).    
   noun2(honn�rlegitimasjon,identification).    
   noun2(identifikasjon,identification). 
   noun2(ledsagerbevis,identification).  %%  rough
   noun2(pass,identification).           %% passport
   noun2(studentbevis,identification).   %% 

noun2(leskur,shed).     %% or penthouse
    noun2(skur,shed). 

noun2(logo,logo).      %% TA-110707
noun2(lomme,pocket). 
noun2(lov,permission).  %% har du lov/ (er det lov?) -> lover = ...

noun2(lokasjon,location).         %% TA-101230
    noun2(lokalisasjon,location). %% spiw

noun2(lyd,sound).

noun2(lys,light).               %% TA-110311
    noun2(gatebelysning,light). %%  rough

noun2(lykke,happiness). 

noun2(lyst,lust).       %% Tecnical term, Norwagism 
    noun2(trang,lust).  

noun2(luft,air). 

noun2(lunsj,lunchtime).  
    noun2(lunch,lunchtime). %%
    noun2(lunsjtid,lunchtime).

noun2(l�rer,teacher).    %% tele

noun2(l�fte,promise).   
    noun2(servicel�fte,promise).

noun2(l�rdagsrute,saturdayroute).  %% etc.
   %%  noun2(l�rdagsbuss,saturdayroute).   %%  Hazardous
    noun2(loerdagsrute,saturdayroute). 
    noun2(l�rdagrute,saturdayroute).   
    noun2(l�rdagsavgang,saturdayroute). 
    noun2(l�rdagsrutetabell,saturdayroute).
noun2(l�sning,solution). 

%% noun2(m 


noun2(mail,mail).  
%%    noun2(email,mail).
%%    noun2(epost,mail).

noun2(mandagsrute,workdayroute).  %%   etc  but workday --> monday
noun2(tirsdagsrute,workdayroute). 
noun2(onsdagsrute,workdayroute).  
noun2(torsdagsrute,workdayroute). 
noun2(fredagsrute,workdayroute). 

noun2(mandagrute,workdayroute).  
noun2(tirsdagrute,workdayroute). 
noun2(onsdagrute,workdayroute).  
noun2(torsdagrute,workdayroute). 
noun2(fredagrute,workdayroute). 

%% noun2(masse,mass). %% ?

noun2(medisin,medicine). 

noun2(mistanke,suspicion).

noun2(modul,module). %% 
noun2(morgenbuss,morningbus).
   noun2(morgonbuss,morningbus).  
   noun2(morgenbusstilbud,morningbus).  
   noun2(formiddagsbuss,morningbus).     %% Rough


noun2(morgendag,morrow).    %% Techn 
%% noun2(morgendagens,morrow). %% Cant handle, better with error mess

noun2(morgenrute,morningroute). 


noun2(moro,fun). %% TA-110627
 
noun2(motor,motor). 

noun2(motorsykkel,motorcycle).
    noun2(moped,motorcycle).  
    noun2(scooter,motorcycle).

noun2(museum,museum). %%  et museum

noun2(m�te,meeting).
    noun2(arrangement,meeting).  %%  rough
    noun2(avtale,meeting). 
    noun2(eksamen,meeting).      %%  Rough
    noun2(examen,meeting).       %%  Rough 
    noun2(feiring,meeting). 
    noun2(fest,meeting).         %%  Rough
    noun2(forelesning,meeting).  %%  (with prof :-)
    noun2(forhandling,meeting).  %%  Rough %% negotiation %% TA-110329
    noun2(f�st,meeting).         %%  Dialect
    noun2(intervju,meeting).
    noun2(jobbintervju,meeting). 
    noun2(julebord,meeting). 
    noun2(kj�retime,meeting). 
    noun2(klagem�te,meeting).    
    noun2(konferanse,meeting). 
    noun2(konfirmasjon,meeting). 
%%     noun2(kino,meeting).   %% som begynner %%  nohelp
    noun2(legetime,meeting).  
    noun2(m�testart,meeting).   
    noun2(m�tetid,meeting).        %% rough
    noun2(m�tetidspunkt,meeting).  %%
    noun2(nachspiel,meeting).  
    noun2(party,meeting).  
%%     noun2(selskap,meeting). % (bus) company ?
    noun2(stevnem�te,meeting). 
    noun2(trening,meeting). 
    noun2(turnering,meeting).  
    noun2(vorspiel,meeting).  
    noun2(�rend,meeting). 
    noun2(�rende,meeting). 

noun2(m�terom,meetingroom). 
   noun2(m�terum,meetingroom). 

%% noun2(n 


noun2(nattbuss,nightbus).  
    noun2(nattbuds,nightbus).  %% sp %% TA-110221
    noun2(mattbus,nightbus). 
    noun2(mattbuss,nightbus). 
    noun2(nastbuss,nightbus).  %% sp 
    noun2(nasttbuss,nightbus). %% sp 
    noun2(natbuss,nightbus).    
    noun2(natbus,nightbus). 
    noun2(nattabuss,nightbus).  
    noun2(nattboss,nightbus). 
    noun2(nattbus,nightbus). 
    noun2(nattbusss,nightbus). 
    noun2(nattbussavgang,nightbus). %%  (rough)
    noun2(nattbussbillett,nightbus).%%  Rough (hva koster)
    noun2(nattbusstid,nightbus).    %%  (rough)
    noun2(nattbussrute,nightbus). 
    noun2(nattbuzz,nightbus). 
    noun2(nattebuss,nightbus).  
    noun2(nattnuss,nightbus).  
    noun2(nattrute,nightbus). 
    noun2(nattsrute,nightbus).  
    noun2(natttbuss,nightbus).  
    noun2(nnattbuss,nightbus). 
    noun2(nttbuss,nightbus). 
    noun2(nattuss,nightbus). 
%%   noun2(nattrikk,nightbus). 
%%   noun2(natttrikk,nightbus). 
    noun2(nsttbuss,nightbus).  %% sp

noun2(nattrikk,tram).     %% Rough 
   noun2(natttrikk,tram). %% Rough sp
   noun2(strikk,tram).    %% sp 

noun2(naturgass,gas). 

noun2(navn,name). 
    noun2(anagram,name).    %% Albert Moe
    noun2(brukernavn,name). %% TA-110301
    noun2(kortnavn,name).   %%  rough
    noun2(namn,name).       %% NN
    noun2(navnevalg,name).  %% rough
    noun2(pseudonym,name).  %%
    noun2(regtopnavn,name). %%  rough
    noun2(stedsnavn,name).  %% Rough 
    noun2(synonym,name).    %% 


noun2(negasjon,negation). 
noun2(nett,network).  
   noun2(web,web).   %% network). 
   noun2(webb,web).  %% network).  %% webben

noun2(webserver,webserver). 

noun2(nettleser,browser). 
    noun2(browser,browser).

noun2(nummer,number).        
    noun2(bussnummer,number).  
                                %% Hvilket bussnummer g�r | bussnummeret til bussen
%%     noun2(merke,number).  %% bokstav ??? buss merket 1 stopper ikke

    noun2(nr,number).  
    noun2(nummerering,nummer). %% Rough 
    noun2(numner,number).      %% TA-110318 neib

% noun2(nummer,bus).            %% nummeret p� bus til nardo

noun2(nyhet,news).  
    noun2(nytt,news). 

noun2(n�dvendighet,necessity). 
noun2(n�kkel,key).  


noun2(nettadresse,webaddress). %% TA-101115
    noun2(internettadresse,webaddress).
    noun2(webadresse,webaddress).   


noun2(nysgjerrighet,curiosity).    
   noun2(nyssgjerrighet,curiosity).     %% spiw


%% noun2(o 

noun2(omforming,transformation).   %% TA-110503

noun2(operat�r,operator).
noun2(oppf�rsel,behaviour). 

noun2(overgang,transfer). %% TA-100903
    noun2(overf�ring,transfer).     
    noun2(sending,transfer).   %% rough   
    noun2(overf�ringskapasitet,transfer). %% rough
    noun2(videresending,transfer).  

noun2(oversettelse,translation).   %% TA-110503



noun2(overtid,overtime). 

%% noun2(p  

noun2(pakke,package).

noun2(par,pair). 
noun2(part,part). 

noun2(pause,pause).  
 %    noun2(frysing,pause). 
    noun2(nedetid,pause). 
    noun2(opphold,pause). 


noun2(pendelbuss, shuttleroute). 
noun2(pendellinje,shuttleroute).
noun2(pendelrute,shuttleroute). 
noun2(pendlerbuss,shuttleroute). 
noun2(pendlerrute,shuttleroute). 

noun2(pensjon,     pension).  %%  (retirement)

noun2(pinse,whitsun).              % pentecost
    noun2(pinsehelg,whitsun).  
noun2(pinserute,whitsunroute).
noun2(pizza,pizza).   
noun2(plan,plan).
    noun2(dagplan,plan). %%  rough
    noun2(fredagsplan,plan). %%  etc ad hoc
    noun2(planlegging,plan). %%  rough 

noun2(planet,planet). 
% noun2(politiker,politician).       %%  :-)))))))
noun2(post,mail). 
noun2(postadresse,postaddress).    %%  mailadress is ambiguous
noun2(postboks,postbox).           %% Rough
noun2(postkontor,post_office).
  
noun2(postnummer,postcode). 

noun2(predikat,predicate).

noun2(president,president).
noun2(programmerer,programmer). 
%    noun2(designer,programmer).    %%  :-)))))
    noun2(programerer,programmer).
    noun2(progammerer,programmer). 
    noun2(skaper,programmer).       %%  :-)
    noun2(utvikler,programmer). 


noun2(prosedyre,procedure). 
    noun2(framgangsm�te,procedure). 
    noun2(fremgangsm�te,procedure). 
noun2(prosent,percent). 

noun2(p�lse,sausage). 
   noun2(hamburger,sausage). %% rough 

   noun2(chips,chip).     %% special, avoid chipss

noun2(prosjekt,project). 

noun2(p�skerute,easterroute).     
   noun2(payskerute,easterroute).  
   noun2(p�skerut,easterroute).    %% dial 
   noun2(p�askerute,easterroute).  
   noun2(p�skebussrute,easterroute).  
   noun2(p�skerutetabell,easterroute). 
   
noun2(p�ske,easter).  
   noun2(paaske,easter).
   noun2(poske,easter).    
   noun2(p�skeferie,easter).      %% (Rough, -> must specify date)
   noun2(p�skeperiode,easter).  
   noun2(p�sketrafikken,easter).
   noun2(p�sketid,easter). 
   noun2(p�skeuke,easter). 
   noun2(p�skeveke,easter). 

%% noun2(q 

%% noun2(r 

noun2(reim,strap).
    noun2(festereim,strap). 

noun2(retting,correction).
    noun2(justering,correction).
    noun2(kompensasjon,correction). %% rough 
    noun2(korreksjon,correction).
    noun2(navnekorreksjon,correction). %% TA-110706
    noun2(oppretting,correction). 
    noun2(rettelse,correction). 
    noun2(stavefeilsanalyse,correction). %% rough
    noun2(stavefeilskorreksjon,correction). 
    noun2(stavefeilkorreksjon,correction). %% spiw %% TA-110807

noun2(ros,praise).  


noun2(referanse,reference).

noun2(rettighet,right). %% rough
   noun2(rett,right).   %%  .. til skoleskyss  

noun2(rutesystem,oracle).            %% TA-110120
noun2(ruteopplysningssystem,oracle). %%
noun2(ruteopplysningsystem,oracle).  %% 


%% noun2(s 

noun2(sans,sense).  %% TA-110114

noun2(savant,savant).  
   noun2(autist,savant). 
   noun2(bot,savant).    %% the other way around, %%  ? fine
   noun2(nerd,savant).
   noun2(nles,savant).   %%  Nat. Lang. Expert System 
   noun2(softbot,savant). %%
   noun2(sp�rresystem,savant). %%  e.g. Anna rough 
   noun2(dialogsystem,savant). %% rough

noun2(sikkerhet,safety). 

%% noun2(ski,ski).  %% Ski %% TA-101129
noun2(skjema,form). %%  rough
noun2(skjerm,screen).  
    noun2(skrivebord,screen). %% fapp %% TA-101228
noun2(skjultflag,hiddenflag).

noun2(skole,school).  %% Destroy name %% Experiment
    noun2(barneskole,school). %% TA-110121

noun2(skolebuss,schoolbus).
   noun2(skolerute,schoolbus). 
noun2(sn�,snow).   
    noun2(skif�re,snow). 
    noun2(sne,snow). 
    noun2(sn�fall,snow).

noun2(sn�br�yting,snowploughing).  %% GBR
    noun2(br�yting,snowploughing).

noun2(skudd�r,leapyear). 
noun2(s�king,search).
    noun2(s�k,search).  


noun2(s�keord,word). %% rough 
noun2(�stside,eastside).
noun2(nordside,northside).
noun2(s�rside,southside). 
noun2(vestside,westside).

noun2(standard,standard).
noun2(stavefeil,spellingerror).   

synword(s�ndaksrute,s�ndagsrute). 


noun2(s�ndagsrute,sundayroute). 
%%    noun2(helgedagsrute,holiday).  %% s�ndag/helligdag
    noun2(helgerute,sundayroute).     %% Not correct 
    noun2(s�ndagrute,sundayroute). 
    noun2(s�ndagsavgang,sundayroute). 
    noun2(s�ndasrute,sundayroute).  %%  sp/dial
    noun2(s�ndagsute,sundayroute).  %% own

noun2(ruter17mai,may17route). 


%%     noun2(s�ndagsbuss,sundayroute). %% Hazard
noun2(s�nn,son).  
noun2(s�sken,relative).            %%  (doesnt matter)
   noun2(s�skenbarn,relative).     %%  (doesnt matter)
%    noun2(fetter,relative). 
%    noun2(kusine,relative). 

noun2(s�ster,sister). 
   noun2(lilles�ster,sister). %% rough
   noun2(stores�ster,sister). %% rough


noun2(utskrift,printout).    
    noun2(printscreen,printout). 
    noun2(demorun,printout). %% TA-110303

noun2(email,email).     %% email adresse
noun2(epost,email).     %% 

noun2(epostadresse,mailaddress).
    noun2(emailadresse,mailaddress).
    noun2(mailadresse,mailaddress).
    noun2(epostaddresse,mailaddress). % spell
    noun2(emailaddresse,mailaddress). % spell
    noun2(mailaddresse,mailaddress).  % spell


noun2(form�l,meaning).  %% purpose).  %% TA-110607
noun2(hensikt,meaning). %% purpose).  %%  


noun2(logg,log).
    noun2(log,log).
    noun2(loggrotasjon,log). %% rough
    noun2(logrotasjon,log). 

%% noun2(m 

noun2(mangel,lack).

noun2(mann,man).
   noun2(fyr,man). %%  also lighthouse
   noun2(herre,man). 
   noun2(kar,man). 
   noun2(kis,man). %% slang  ??
   noun2(man,man). %% ? %% confus? //ok ?

noun2(manual,manual).
noun2(maskinvare,hardware).  
noun2(mat,food).                      %%  (Avoid  mat = Mai)
    noun2(matpakke,food). 
    noun2(niste,food). 
    noun2(nistepakke,food).

noun2(mellomnavn,middlename).   

noun2(mengde,set). 
noun2(melding,message). 
%%    noun2(beskjed,message).     %% -> notification
%%    noun2(besked,message).         %% Danish
    noun2(melling,message).   
    noun2(tekstmelding,message).   %% (meaning SMS)
    noun2(tilbakemelding,message). 

noun2(mening,meaning). 
    noun2(betydning,meaning).  
    noun2(form�l,meaning).  
    noun2(hemmelighet,meaning). 
    noun2(hensikt,meaning). 
    noun2(intensjon,meaning). 
    noun2(meening,meaning).    %%  ?  
    noun2(menin,meaning). 
    noun2(meinin,meaning).  
    noun2(meining,meaning).               %% Nynorsk
    noun2(menig,meaning). 
    noun2(menging,meaning). 
    noun2(menning,meaning).  
    noun2(mnging,meaning). 
    noun2(m�l,meaning). 
    noun2(opphopning,set).     %% rough 
    noun2(poeng,meaning). 
    noun2(vits,meaning).         %% :-)  joke


noun2(meter,meter).
noun2(middag,noon).  
    noun2(midag,noon).  
noun2(natt,midnight). 
    noun2(leggetid,midnight). %% :-) 
    noun2(midnat,midnight).   %% sp/DK 
    noun2(midnatt,midnight).
    noun2(nattetid,midnight). 
    noun2(nattestid,midnight). 

% noun2(middagstid,noon).       %%  why???
noun2(mil,kilometer).           %% I know, but this is only for questions 
noun2(milit�re,military). 
    noun2(milit�r,military). 
    noun2(vernepliktig,military). 
    noun2(vernepliktige,military). 
    noun2(v�rnepliktig,military).   %% nominalisert adj
    noun2(v�rnepliktige,military).  %% nominalisert adj
noun2(minibuss,minibus). 
noun2(minstetakst,price).
noun2(minutt,minute).
    noun2(minitt,minute). 
    noun2(miniutt,minute). 
    noun2(minut,minute).  
noun2(modus,mode). 
noun2(mor,mother).            %% :-)
    noun2(mama,mother).  
    noun2(mamma,mother).      %%
noun2(morgen,morning).
    noun2(morgengry,morning). 
    noun2(morgenkvist,morning). 
    noun2(morgentime,morning).  %% I morgentimene 
    noun2(morgentrafikk,morning). 
    noun2(morging,morning).   
    noun2(morning,morning). 
    noun2(mprgen,morning). %%  typo
%% noun2(morgen,morrow).   %% men ikke morgenen !!!
%% noun2(morg,morrow).     %%  cause disamb problems ???

noun2(morges,morn).             %%  Norwagism
noun2(morres,morn). 
noun2(mobiltelefon,mobile).  
    noun2(mobil,mobile).
    noun2(mobiltelefonnr,mobile). %   etc.
    noun2(mobilnummer,mobile). 

noun2(morgon,morning).   

%%  noun2(mulighet,departure). %%   disturbs "possibility"
%%   noun2(sjanse,departure).  

noun2(sjanse,chance). 

noun2(mulighet,way). 
    noun2(anledning,way).    %%  rough possibility ?
%%    noun2(sjanse,way).       %%  NO, sjansen til Solsiden
                                %%          \+-> way to thing solsiden

%    noun2(tilatelse ,way).  % -> permit
%    noun2(tillatelse ,way). 

    noun2(opsjon,way).       %% option?
    noun2(m�te,way).           %% fleksibilitet i valg
    noun2(vis,way).     %% p� et vis %% TA-110304

noun2(valg,choice).            
    noun2(fleksibilitet,choice).  
    noun2(valgmulighet,way).  


noun2(merke,label). %% mark?
    noun2(merking,label). %%
    noun2(refleks,label). %% rough

noun2(musikk,music). 

noun2(m�l,measure).  
noun2(m�l,destination).

noun2(m�ne,moon).

noun2(m�ned,month). 
    noun2(m�nde,month). 
    noun2(m�nte,month). 
noun2(m�nedsbillett,season_ticket). 
    noun2(m�nedsbilett,season_ticket).  %%  mispel
    noun2(periodebillett,season_ticket). 

%% noun2(m�nedskort,season_ticket). % card
%% noun2(periodekort,season_ticket).% card

noun2(m�te,way). 
    noun2(knep,way). 
    noun2(metode,way). 
    noun2(m�de,way). %% DK 
    noun2(spor,way). %% ? %% TA-101117 double metonym

noun2(tilfelle,case).

noun2(tillatelse ,permission).  %% permit
    noun2(oppholdstilatelse,permission). %% rough
    noun2(oppholdstillatelse,permission). %% 
    noun2(tilatelse,permission). 

noun2(tillegg,addition). %% .. til

noun2(toalett,toilet).  
    noun2(toilett,toilet).


noun2(dametoalett,  ladies_toilet).
noun2(dametoilett,  ladies_toilet).  
noun2(herretoalett, gentlemen_toilet). 
noun2(herretoilett, gentlemen_toilet). 

noun2(takk,thanks). %% TA-101228

noun2(tale,speech).   
    noun2(syntese,speech).    %% rough 
    noun2(takketale,speech).  %% :-)
    noun2(talesyntese,speech).    %% rough 

noun2(navnegjenkjenning,name_recognition). %% TA-110706

noun2(talegjenkjenning,speech_recognition).  
    noun2(gjenkjenning,speech_recognition). %% rough 
    noun2(talegjenkjenningsdel,speech_recognition). 

noun2(tankearbeid,job). %%  rough \+ work

noun2(tosk,fool). %% ?-) 
    noun2(amat�r,fool). 
    noun2(domming,fool). 
    noun2(domrian,fool). 
    noun2(duming,fool).  
    noun2(dummen,fool).  %%  own
    noun2(dumming,fool).  
    noun2(dumrian,fool). 
    noun2(dust,fool).
    noun2(fjols,fool). 
    noun2(fjott,fool).  
    noun2(frekkas,fool). 
    noun2(gj�k,fool).  
    noun2(idiot,fool).
    noun2(mehe,fool).
    noun2(klovn,fool). 
    noun2(narr,fool). 
%%    noun2(nerd,fool).   %% savant
%%    noun2(newbie,fool). %%  eng
%%    noun2(noob,fool).   %%  eng
    noun2(raring,fool). 
    noun2(stakkar,fool). 
    noun2(taper,fool). 
    noun2(teiting,fool). 
    noun2(tufs,fool). 
    noun2(tullebukk,fool). 
    noun2(tulling ,fool).
    noun2(t�sk,fool).      %% ?


noun2(gjenstand,object). 
    noun2(objekt,object).  


noun2(lingvist,linguist).
noun2(l�nn,salary).  

noun2(olje, oil).         %%  diesel, disel

noun2(omgivelse,environment). 

noun2(omr�de,neighbourhood). 
    noun2(bydel,neighbourhood). 
    noun2(distrikt,neighbourhood).     %%  After omr�de (official name, 
    noun2(grend,neighbourhood).  %% ??
    noun2(hjemmeomr�de,neighbourhood). %%
    noun2(nabolag,neighbourhood). 
    noun2(n�rhet,neighbourhood). %% i n�rheten %% TA-101108
    noun2(omegn,neighbourhood).
    noun2(ommr�de,neighbourhood). 
    noun2(omrade,neighbourhood). 
    noun2(omrayde,neighbourhood).  %%  område 
    noun2(omr�denavn,neighbourhood). 
    noun2(or�de,neighbourhood).
%%%     noun2(n�rhet,neighbourhood). %% destroys i n�rheten av
    noun2(n�romr�de,neighbourhood). 
    noun2(utested,neighbourhood).   %% Rough 

noun2(omvei,way). %% rough

noun2(onkel,uncle).



noun2(operativsystem,operatingsystem).
noun2(oppgave,task). 
    noun2(funksjon,task).              %% 
    noun2(hensikt,task).               %%
    noun2(misjon,task).   
%     noun2(mening,task).              %% confusing  commitments
    noun2(�ving,task). 

noun2(oppdatering,update). %% \+ version 
    noun2(oppdtering,update). %% authentic sperr %% TA-101102

noun2(opplysning,information).   %% transitive closure
    noun2(bussopplysing,information). 
    noun2(bussopplysning,information). %% 
    noun2(opplysing,information).
    noun2(oplysning,information). %% spell 
    noun2(opplysningssentral,information).   %% rough 
    noun2(publikumsopplysning,information). %% rough 
    noun2(ruteopplysning,information).      %% rough
    noun2(upplysning,information). 

noun2(optimaliseringering,optimalization). 
    noun2(optimering,optimalization).

noun2(orakel,oracle). 
    noun2(teamorakel,oracle).  
    noun2(flybussorakel,oracle). %% rough?

noun2(ord,word).
    noun2(ordlyd,word). %% rough  
noun2(ordf�rer,mayor). 
    noun2(borgermester,mayor).
    noun2(burgermester,mayor). %% :-) Marvin Wiseth
noun2(overb�renhet,indulgence).  %%(leniency ?)
noun2(overgang,transfer). %% // i.e. BYTTE AV BUSS
    noun2(bussbytte,transfer). 
    noun2(bussovergang,transfer). 
    noun2(busskifte,transfer). 
    noun2(bussskifte,transfer). 
%%     noun2(bytte,transfer). %%  (NB Ogs� verb ) kan en bytte?? 
    noun2(bytting,transfer). 
    noun2(gjennomgang,transfer). 
    noun2(mellomstopp,transfer).
    noun2(omstigning,transfer). 
    noun2(overgan,transfer).   %% spc
    noun2(overang,transfer). %% own, * overan-gaten=�ver�s_street%% 
    noun2(overgangsmulighet,transfer).  
    noun2(skifte,transfer).    
    noun2(skifting,transfer). 
    noun2(veksling,transfer). %% also money 

%% noun2(overmorgen,day_after_tomorrow).     %% confuse %% TA-110401
%%    noun2(overimorgen,day_after_tomorrow). %% adv 

% noun2(overovermorgen,future). 
%    noun2(overoverimorgen,day_after_tomorrow). 



noun2(oversikt,overview). %% information). 

noun2(passasjer,passenger). 
    noun2(busspassasjer,passenger).  
    noun2(klager,passenger).  %% misforn�yd s�dan 
    noun2(kunde,passenger).        %% ja, p� bussen, ikke p� SMS
    noun2(medpassasjer,passenger).
    noun2(passager,passenger). 
    noun2(pasasjer,passenger).     %% spell
    noun2(politiker,passenger).    %% :-)
    noun2(reisende,passenger).  
    noun2(sidemann,passenger).  

noun2(passering,departure). 
    noun2(pasering,departure).        %%  (misspell)
    noun2(paserin,departure).  
    noun2(passeringstid,departure).
    noun2(passeringstide,departure). %% Dan 
    noun2(passeringstidspunkt,departure). 
    noun2(stoppetid,departure).

noun2(penge,money). %%  mange penger=plu
    noun2(bel�p,money). 
    noun2(busspenge,money).
          noun2(inntekt,income).    
    noun2(kontant,money).  
%%     noun2(lapp,money).  %% Lappen  station      %%  50-lapp %% Har du lappen
    noun2(mynt,money). 
    noun2(honorar,money).  %% TA-110707 rough
    noun2(hundrelapp,money).  %% rough
    noun2(seddel,money).
    noun2(kronestykke,money). 

    noun2(femti�re,money). 
    noun2(femti�ring,money).   %% 
%%     noun2(periode,time). %%moved because of paraphrase (backwards translation)

noun2(person,person). %% NB Used for backwards translation
    noun2(amerikaner,person).        %% ?-)
    noun2(befolkning,person). 
%%     noun2(folk,person). %% plu
         noun2(fremmed,person). %% rough 
    noun2(innbygger,person). 
    noun2(innf�dt,person).         %% tr�nder? 
    noun2(innf�dte,person).        %% 
    noun2(meneske,person).  
    noun2(menneske,person).        %% Must come after 
    noun2(menneskehet,person).  
    noun2(menneskelig,person).     %% rough
    noun2(mennesklig,person).  
     noun2(m�nniska,person).        %% ? SV  
     noun2(nordmann,person).        %%  :-)  
     noun2(normann,person).  
%     noun2(passasjer,person).      %% Try with passenger
     noun2(perseon,person).         %% own
     noun2(persom,person).   
     noun2(peson,person).   
     noun2(publikum,person).   %% e.g. set of
    
     noun2(nordlending,person).     %%  :-)                           
     noun2(s�rlending,person). 
     noun2(tr�nder,person).  

noun2(politi,police).  



%% Name professor  confuses busstuc   
noun2(professor,professor):-  %%  tele ...
    user:myflags(teleflag,true).
noun2(f�rsteamanuensis,associate_professor):-
    user:myflags(teleflag,true).
noun2(amanuensis,assistant_professor):-
    user: myflags(teleflag,true).
noun2(universitetslektor,lecturer):-
    user: myflags(teleflag,true).
noun2(sekret�r,secretary):-    
    user: myflags(teleflag,true).
noun2(forsker,researcher):-   
     user: myflags(teleflag,true). 

noun2(semantikk,semantics). 
noun2(semester,semester). 


%% noun2(skriver,printer). %% skj�nner du det som du skriver * %%   problem
    noun2(printer,printer). 

%% noun2(prins,prince). %% just to avoid prins -> paris 
%% Prinsen til heimdal ###

noun2(pris,price).
    noun2(kostnad,price). 
    noun2(prisniv�,price). 
    noun2(utgift,price). %% TA-110411

noun2(problem,problem). 
    noun2(hovedproblem,problem). %% TA-110701
    noun2(mareritt,problem). 
    noun2(problemstilling,problem). 
    noun2(utfordring,problem).   

noun2(program,program).
    noun2(dataprogram,program). 
    noun2(datamaskinprogram,program). 
    noun2(datasystem,program).  
    noun2(miniprogram,program). 
    noun2(oppfinnelse,program).     %%  ( roughly ) After program
    noun2(progam,program).   
    noun2(programm,program). 
    noun2(script,program).      %% rough
    noun2(skript,program).      %% 
    noun2(snutt,program). %% programsnutt %%  own

noun2(programmerer,programmer).  
noun2(programvare,software). 
   noun2(programvaresystem,software). 
noun2(programmeringsspr�k,programminglanguage). 
    noun2(programeringsspr�k,programminglanguage).  %% ( spell )

%% niun2(r 

noun2(rabatt,discount). 
    noun2(fradrag,discount). 
    noun2(grupperabatt,discount). 
    noun2(honn�rrabatt,discount). 
    noun2(hon�rrabatt,discount).
    noun2(milit�rrabatt,discount). 
    noun2(moderasjon,discount). 
    noun2(prisduksjon,discount). 
    noun2(rabbat,discount). 
    noun2(rabattordning,discount). 
    noun2(reduksjon,discount). 
    noun2(studentmoderasjon,discount).
    noun2(studentpris,discount).  
    noun2(studentrabatt,discount).
    noun2(studentrabat,discount). 
    noun2(studentrabbat,discount). 
    noun2(studierabatt,discount).

noun2(rapport,report). 
    noun2(prosjektoppgave,report). %% TA-110511

noun2(regel,rule).
    noun2(hovedregel,rule).  
    noun2(lov,rule).  %% rough  
    noun2(myndighetene,rule).    %% iflg  %% rough
    noun2(partnerskapslov,rule). %% rough 
    noun2(overgangsregel,rule). 

noun2(regionbuss,otherbus). 
    noun2(alpinbuss, otherbus). 
    noun2(alpintbuss, otherbus).
    noun2(fjernrute,otherbus). 
    noun2(fotballbuss,otherbus). 
    noun2(regionsbuss,otherbus). 
    noun2(spesialbuss,otherbus).
    noun2(turbuss,otherbus). 
noun2(regn,rain).  
    noun2(regnfall,rain).  
    noun2(regnv�r,rain). 
noun2(regning,bill).  

noun2(regtoppeksport,regtop_export). 
   noun2(regtopeksport,regtop_export). %%
   noun2(regtop,regtop_export).  
   noun2(regtopdata,regtop_export).  
   noun2(regtopp,regtop_export).       %% confuse regtopp eksport
   noun2(regtoppp,regtop_export).  
   noun2(regtopddata,regtop_export). 



noun2(reise,trip). %% journey).
    noun2(avstikker,trip). 
%%     noun2(ekstratur,trip). = extabus 
    noun2(enkeltreise,trip). %% rough 
    noun2(ferd,trip). 
    noun2(fisketur,trip). %% very rough
    noun2(forflyttning,trip).    %%  :-)  tni tti ti
    noun2(kj�ring,trip).  
    noun2(kj�retur,trip).  
    noun2(langkj�ring,trip).  %%  rough
    noun2(omvisning,trip).
  
    noun2(produkt,trip).      %% tkort-produkt
    noun2(reiseprodukt,trip). %% Hefte

    noun2(runde,trip).
    noun2(rundtur,trip). 
    noun2(skoleskyss,trip).   
    noun2(skyss,trip).  
    noun2(snartur,trip). 
    noun2(tur,trip).        %% tour ? %% TA-101008
    noun2(turnr,trip).      %% Techn.  Linje+Turnnr= Departure
    noun2(turnnummer,trip).

%%     noun2(ture,trip).     %% tureen 

noun2(reisegaranti,travelinsurance). %% rough

noun2(reisem�te,route). 
    noun2(reisemate,route).  

noun2(reisetid,traveltime).  % problematic
noun2(rreisetid,traveltime).  
     noun2(rekord,traveltime).    %%  :-)
noun2(rekkef�lge,sequence). 
noun2(rekvisisjon,requisition). 
 
noun2(rengj�ring,cleaning). 
noun2(reparasjon,repair). 
    noun2(behandling,repair). %%  rough %% TA-101117

noun2(reservasjon,reservation). 
    noun2(plassreservasjon,reservation).  

noun2(responstid,responsetime).  
    noun2(reponstid,responsetime). %% sp %% TA-110112
    noun2(svartid,responsetime). 
    noun2(tenketid,responsetime).

noun2(restart,restart).  
noun2(restaurant,restaurant). 
   noun2(restaurang,restaurant). 
   noun2(resturant,restaurant). 
noun2(rest,rest).  
    
noun2(restriksjon,restriction). %% TA-110419

noun2(retning,direction). 
    noun2(kj�reretning,direction). 
    noun2(rentning, direction).  
    noun2(retnning, direction). 
    noun2(rettning, direction).   
%%    noun2(retur,    direction).  %% Very Rough
%%    noun2(tur,      direction).  %% p� tur til %% tur    vollabakken \= retning vollabakken

%%    noun2(veg,direction). %% IKKE veien
%%    noun2(vei,direction). %% 


noun2(retningslinje,policy). 
    noun2(policy,policy).   %% ad hoc? 


%% noun2(rett,right). %% rett til skyss %%  noun3

noun2(retur,return). %% ako dircetion 
   noun2(returtidspunkt,return).       %%  ?
 
noun2(ringrute,ringroute). 
    noun2(ring,ringroute). %% tough 
noun2(robot,robot). 
    noun2(bot,robot).  
%%     noun2(softbot,robot). %% savant 

 noun2(lokale,room). 
    noun2(rom,room). 
    noun2(romm,room).  
    noun2(rum,room).  
    noun2(rumm,room).  
    noun2(sal,room). %%

noun2(rullestol,wheelchair).
   noun2(rullestolbruker,wheelchair). %% Rough 

noun2(rushtid,rush_hour).
   noun2(rush,rush_hour). %% rushen/et 
noun2(rushtrafikk,rush_hour). %% (slightly Rough)

noun2(ringbuss,bus).             %% rough
%% noun2(ringbuss,shuttleroute).     %% rough, but only fro error message

%% noun2(rute,route_plan). %% Must appear after noun2(rute,route).  
                           %% NO! 36 -> route_plan (Trouble)

noun2(rute17mai,may17route). 



noun2(ruteplan, route_plan).  
   noun2(avgangsoversikt,  route_plan).

   noun2(bustabell,     route_plan).
   noun2(busshefte,     route_plan). %% rough 
   noun2(bussliste,     route_plan). 
   noun2(bussoversikt,  route_plan). 
   noun2(bussplan,      route_plan). 
   noun2(bussruteoversikt, route_plan). 
   noun2(bussruteplan,     route_plan). 
   noun2(bussrutetabell,   route_plan). 
   noun2(bussrutetabelll,  route_plan). %% sp 
   noun2(busserutetabell,  route_plan).  
   noun2(busstabell,       route_plan). 
   noun2(busstabell,       route_plan). 
   noun2(holdeplasstabell, route_plan). 
   noun2(katalog,          route_plan). 
   noun2(kj�rem�nster,     route_plan).
   noun2(kj�replan,        route_plan).  
   noun2(oversiktsrute,    route_plan). 
   noun2(passeringsoversikt, route_plan).  
%%    noun2(plan,          route_plan).  % "buss plan"   %% ad hoc \= 
   noun2(reisealternativ,  route_plan).
   noun2(rudetabell,       route_plan).  %% S�rlandsk 
   noun2(rutebok,          route_plan).  %% paper?
   noun2(rutedata,         route_plan).  %% data? 
   noun2(sanntidsdata,     route_plan).  %% Rough %% TA-110330
 

   noun2(rutebeskrivelse,  route_plan). 
   noun2(ruteoversikt,  route_plan). 
   noun2(rutetabbel,    route_plan). 
   noun2(rutetabbell,   route_plan). 
   noun2(rutetabell,    route_plan).  
   noun2(rutetabll,     route_plan). 
   noun2(ruttabell,     route_plan).  %% Dial 
   noun2(rutetrafik,    route_plan). 
   noun2(rutetrafikk, route_plan). 
   noun2(rutenett, route_plan). 
   noun2(samletabell,    route_plan).
   noun2(tabel,    route_plan). 
   noun2(tabell,   route_plan). 
   noun2(tidsoversikt,route_plan). 
   noun2(turliste, route_plan). 
   noun2(tidsplan, route_plan).  
   noun2(timetabell,  route_plan). 
   noun2(timerute,departure).      %%  (time is mentioned)

%%    noun2(veg,      route_plan).  
%%    noun2(vei,      route_plan). %% veien til Arvid Holme %% telebuster 
   noun2(vognl�p,  route_plan). %% ?

%   noun2(ruteopplysning, route_plan).      %% ==> information
%   noun2(reiserute,route_plan). %% == route   reiserute om morgenen 
         

noun2(rutehefte,    timetable). %%  route_plan).  %% paper?   %% = information regarding morgen
    noun2(hefte,        timetable). 
    noun2(ruteside,     timetable). %%  rough side i rutehefte

noun2(r�d,advice).   


noun2(severdighet,landmark).    %% 1 ? 
    noun2(landemerke,landmark). %% 2 ?

noun2(sms,sms).            %%  Short Message System 
noun2(sol,sun). 
   noun2(solskinn,sun). 
   noun2(t�rke,sun).        %% rough  
   noun2(vannmangel,sun).  

noun2(spasertur,jog).    %% rough
%%    noun2(gange,jog).  %% TA-110511
    noun2(joggetur,jog).
    noun2(l�petur,jog). 


noun2(spebarn,baby).    %% (free of charge ?)
    noun2(baby,baby).  

noun2(spesialbillett, special_ticket).

    noun2(hon�r,special_ticket).  
    noun2(honn�r,special_ticket).              %%  (?)
    noun2(overgangsbilett,special_ticket).  
    noun2(overgangsbillett,special_ticket).  
    noun2(overgangsbillet,special_ticket). 

    noun2(billettautomat,  special_ticket). 
    noun2(bybillett,  special_ticket). 
    noun2(dagbillett, special_ticket). 
    noun2(dagsbillett,special_ticket). 
    noun2(dagsbillet, special_ticket).  
    noun2(dagsbilett, special_ticket). 
    noun2(dagstur, special_ticket). 
    noun2(d�gnbilet,  special_ticket). 
    noun2(d�gnbillet, special_ticket). 
    noun2(d�gnbilett, special_ticket).
    noun2(d�gnbillett,special_ticket). 
    noun2(enhetstakst,special_ticket).  
    noun2(familiebillett,special_ticket).
    noun2(familiebillet,special_ticket).
    noun2(familiebilett,special_ticket). 
    noun2(familiedagbillett,special_ticket). 
    noun2(familiedagsbillett,special_ticket). 
    noun2(familied�gnbillett,special_ticket). 
   
    noun2(heldagsbillett,  special_ticket). %% TA-100905
    noun2(heldagsbilett,   special_ticket). %%
    noun2(honn�rbillett,special_ticket). 
    noun2(honn�rbilett, special_ticket).  
    noun2(hon�rbillett, special_ticket).  
    noun2(hon�rbilett,  special_ticket).  
    noun2(honn�rbillet, special_ticket).  
    noun2(honn�rbilet,  special_ticket).  
    noun2(hon�rbillet,  special_ticket).  
    noun2(hon�rbilet,   special_ticket).  
    noun2(honn�rpris,   special_ticket). 
    noun2(hon�rpris,     special_ticket). 
    noun2(midbybillett,  special_ticket). 
    noun2(midtbybillett, special_ticket).  
    noun2(midtbybillet,  special_ticket).  %% spiw
    noun2(midtbybilett,  special_ticket). 
    noun2(midtbypris,    special_ticket).  %% rough 
    noun2(midtbytakst,special_ticket).  
    noun2(nattakst,   special_ticket).  % ?
    noun2(natttakst,  special_ticket). % ?
    noun2(overgangsbillett, special_ticket).
    noun2(pensjonistbillett,special_ticket). 
    noun2(persondagbillett, special_ticket). 
    noun2(studentbillett,special_ticket). 
    noun2(spesialbillet, special_ticket).
%%    noun2(tkort,         special_ticket). %% card 
    noun2(togbilett,     special_ticket). 
    noun2(togbillett,    special_ticket).

noun2(pensjonist,pensioner). 

noun2(radio,radio).  

noun2(periode,period). 
    noun2(peridode,period).
    noun2(periodelengde,period). %% rough 
    noun2(ruteperiode,period).   %% rough

noun2(produsent,producer). 
    noun2(leverand�r,producer). 

noun2(r�yk,smoke). 
    noun2(snus,smoke).  %% rough //er snusing tillatt i buss?:-) 
    noun2(tobakk,smoke).  
    noun2(sigarett,smoke). 

noun2(r�yking,smoking). 




    
noun2(billettsalg,sale).   %%  rough
    noun2(billettering,sale).  
    noun2(billettkj�p,sale). 
    noun2(kj�p,sale).  
    noun2(salg,sale).  

%% noun2(s 


noun2(samtale,talk).   
   noun2(prat,talk). 
noun2(sang,song). 
noun2(sannhet,truth). 
%%  noun2(sentrum,centre).   %%  causes confusion with Sentrum

 noun2(sekund,second).  

noun2(senter,centre). 
    noun2(sentra,centre). %% allow sentraer etc     

noun2(selskap,company). 
    noun2(aksjeselskap,company).     %% rough
    noun2(busselskap,company).       %% rough
    noun2(bussselskap,company).      %% spell 
    noun2(bussruteselskap,company). 
    noun2(firma,company). 
    noun2(firmanavn,company).        %%  rough
    noun2(kollektivselskap,company). 
    noun2(ruteselskap,company). 
    noun2(selskab,company).          %%  dan
    noun2(trafikkselskap,company). 

%% noun2(selv,self).  %% disturbs Selv om 

noun2(service,service).

noun2(kundesenter,servicecenter). 
     noun2(servicesenter,servicecenter). %%  

noun2(sett,set). 

noun2(signal,signal). 
    noun2(stoppsignal,signal). 

noun2(sitteplass,seat). 
    noun2(st�plass,seat).  %% rough   %% TA-100902  %%  ( :-)
    noun2(barnesete,seat). %%  Rough
    noun2(benk,seat).      %%  rough (ako) 
    noun2(kapasitet,seat).  
%%    noun2(plass,seat).  %% after noun2(plass,place).
    noun2(sete,seat).  
    noun2(stol,seat). 

noun2(setning,sentence). 
%%    noun2(setning,statement). %% paraphrase only %% ? 
    noun2(p�stand,sentence).     %% TA-110824
    noun2(testsetning,sentence). %% rough
    noun2(utsagn,sentence).     %% TA-110824


noun2(side,side).  %%  ( side av samfundet) %% Fronted %% TA-110119
   noun2(side,page).   %% amb
   noun2(overside,side).  
   noun2(underside,side).    %%
   noun2(side,homepage). 


noun2(staving,spelling). 

noun2(tilstand,situation). %% hva er kaos -> tilstand 
    noun2(situasjon,situation). 

noun2(sitteplass,seat). 
noun2(sj�,sea).  
    noun2(innsj�,sea).  %% TA-110105

noun2(sj�f�r,driver).  
    noun2(bussnisse,driver). %% :-)
    noun2(bussf�rer,driver).
    noun2(busf�rer,driver). 
    noun2(bussj�f�r,driver).
    noun2(bussj�f�r,driver). 
    noun2(bussjafor,driver).
    noun2(bussjofor,driver).
    noun2(bussj�f�rdame,driver). 
    noun2(bussj�f�rherre,driver). 
    noun2(bussj�r�r,driver). %% sp
    noun2(bussj�ff�r,driver). 
    noun2(bussjaafor,driver).  
    noun2(busssjaf�r,driver). 
    noun2(busssj�f�r,driver).  
    noun2(bussjaafoer,driver). %%  ?
    noun2(bussjaf�r,driver). 
    noun2(bussjof�r, driver).  
    noun2(busssjof�r, driver).  %%  ? 
    noun2(bussmann, driver).
    noun2(busssj�f�r, driver).
    noun2(f�rer, driver). 
    noun2(kondukt�r,driver).  %% rough 
    noun2(sjaf�r,driver). 
    noun2(sja�f�r,driver). 
    noun2(sjof�r,driver). 
    noun2(sj�f�r,driver).  
    noun2(sj�f�r,driver). 
    noun2(sj��r,driver). 
    noun2(sj�f�r,driver).  
    noun2(sj�f�r,driver).  

noun2(slutt,end).  
   noun2(slut,end).  %% ( inc slutet )

noun2(sommer,summer).  
    noun2(skoleferie,summer). % ?
    noun2(somar,summer). 
    noun2(sommar,summer). 
    noun2(somer,summer). 
    noun2(sommerhalv�r,summer). 
    noun2(sommerm�ned,summer). 
    noun2(sommertid,summer).  
    noun2(sommmer,summer).  
    noun2(sumar,summer). 
    noun2(summar,summer). 

noun2(sommerferie,summerroute). %% vacation).
noun2(sommerrute,summerroute).
    noun2(sommerbuss,summerroute).  
    noun2(sensommerrute,summerroute). %%  -- problem 04.08.08--22
    noun2(sommerbussrute,summerroute).
    noun2(sommerrure,summerroute).    %%  (sp)
    noun2(sommerrutetid,summerroute). 
    noun2(sommerute,summerroute).     %%  (spell)
    noun2(somerrute,summerroute).     %%  (spc)
    noun2(sommertid,summerroute).  
    noun2(sommerrrute,summerroute). 
    noun2(sommmerrute,summerroute).  
    noun2(sommerversjon,summerroute). 

noun2(sone,zone).            %%   = takstsone (?)
    noun2(sonegrense,zone). 
    noun2(soneinndeling,zone). 
    noun2(soneomr�de,zone). 
    noun2(sonepris,zone). 
    noun2(sonetakst,zone). 
    noun2(sonetakstgrense,zone). 
    noun2(takstgrense,zone). 

noun2(spill,game). 

noun2(sprit,alcohol). %% illegal
    noun2(alkohol,alcohol).
    noun2(karsk,alcohol). %% local brew 

noun2(spr�k,language).  
    noun2(dialekt,language). 
    noun2(dial�kt,language). %% dial :-)
    noun2(morsm�l,language). %% TA-110824
    noun2(m�lf�re,language).  
    noun2(spraak, language).
 
noun2(sp�k,joke). 
    noun2(gj�n,joke). 

noun2(sp�rsm�l,question).  
    noun2(bussavgangssp�rsm�l,question). %% etc. 
    noun2(bussp�rsm�l,question). %% etc.
    noun2(busssp�rsm�l,question). %% etc. 
    noun2(bussrutesp�rsm�l,question). %% etc.
    noun2(foresporsel,question). 
    noun2(foresp�rsel,question). 
    noun2(formulering,question). %% Rough 
    noun2(forsp�rsel,question).  %% own 
    noun2(henvendelse,question). 
    noun2(kommando,question). %% Rough 
    noun2(oppfordring,question). %% reguest 
    noun2(orakelsp�rsm�l,question). 
    noun2(rutesp�rsm�l,question). 
    noun2(sporsmal,question). 
    noun2(sporsmaal,question). 
    noun2(spr�sm�l,question).  
    noun2(sp�rgsm�l,question). 
    noun2(sp�rsmaal,question). 
    noun2(sp�rm�l,question).  
    noun2(sp�rring,question). 
    noun2(sp�sm�l,question).  
    noun2(sp�srm�l,question).  
 

noun2(start,start).   
    noun2(begynnelse,start).
    noun2(forkant,start).
    noun2(oppstart,start). 

noun2(startdato,startdate). %% for route periods   
noun2(sluttdato,stopdate). %% enddate | finaldate ?  %%
noun2(gyldighetsdato,stopdate). %% more relevant than start date 

%%    noun2(restart,start). 

noun2(startsted,startingpoint). %%  starting point
    noun2(utgangspunkt,startingpoint).
    noun2(frasted,startingpoint).
    noun2(p�stigningsholdeplass,startingpont). %% Techn 


noun2(statistikk,statistics).

noun2(statsminister,primeminister). %%   :-)

noun2(statue,statue). 

noun2(sted,place).   %%  neut, but inflected as  1 sted, 2 steder

    noun2(campus,place).  
    noun2(campuss,place).       %% techn 
    noun2(plas,place).          %% e.g. plasen
    noun2(plass,place).         %% ( holdeplass ?)
    noun2(plassering,place).    %%  ( location ?)  Attribute 

    noun2(stad,place).          %%  (NN) / stadion

    noun2(tilgang,access). %%    place).  %% rough %% TA-110429

noun2(plass,seat).  %% after noun2(plass,place). 

%% noun2(stein,stone). 

noun2(stempel,stamp). %% p� busskort

noun2(stopp,station).  
    noun2(stop,station).  

    noun2(st�pp,station).  
noun2(stoppested,station). 
    noun2(stoppsted,station). 
noun2(strategi,strategy). 
noun2(streik,strike).  
    noun2(bussstreik,strike). 
    noun2(busstreik,strike). 
    noun2(streikebryteri,strike). 
noun2(strekning,distance). 
    noun2(bussrutestrekning,distance).
    noun2(rutestrekning,distance). 
noun2(str�k,neighbourhood). 
noun2(synspunkt,opinion). 

noun2(student,student). 
    noun2(datastudent,student). %% (PRAGMATIX)
    noun2(sudent,student). 

noun2(suksess,success). 

noun2(styre,board). %%  ? 

noun2(st�rrelse,size). 
noun2(svar,answer).  
    noun2(scar,answer).          %% own
    noun2(orakelsvar,answer).
    noun2(respons,answer).      
%%     noun2(responstid,answer).   
    noun2(resulat,answer).       %% own
    noun2(resultat,answer).     
%%     noun2(resulatet,answer).     %% unnec
    noun2(unnskyldning,answer).
    noun2(unskyldning,answer). 
%%     noun2(svartid,answer).   
    noun2(svarstrategi,answer).  %% rough

noun2(sv�mmebasseng,swimmingpool). 

%% noun2(sykehus,hospital).       %% sykehuset st olav//noinfo
    noun2(klinikk,hospital).   %%

noun2(sykkel,bicycle). 
%%     noun2(moped,bicycle).  
%%     noun2(motorsykkel,bicycle).  %% Rough
    noun2(sukel,bicycle). 
    noun2(sukkel,bicycle). 
    noun2(sykel,bicycle). 
    noun2(syklist,bicycle). %% Rough 

noun2(synd,pity).            %% :-)
noun2(system,system). 
    noun2(konsept,system).   %% TA-110426 rough
    noun2(opplegg,system). 
    noun2(billettmaskin,system).   %% Rough 
    noun2(billettsystem,system).   %% rough ad hoc
    noun2(billetmaskin,system).  
    noun2(konfigurasjon,system).  
    noun2(parkeringsystem,system). %%  rough
    noun2(rammeverk,system).       %% framework ?

% noun2(t 

%%% noun2(p 

noun2(pil,mark).        %% rough 
    noun2(pil,key).     %% rough
    noun2(piltast,key).
    noun2(retningspil,mark). 
    noun2(tast,key).


noun2(plassmangel,lack_of_space). 

noun2(punkt,item).  %% TA-110707   

%%% noun2(t 

noun2(tastatur,keyboard).

noun2(taxi,taxi). 
    noun2(drosje,taxi).           %% drosje official Norwegian
    noun2(dorsje,taxi).           %%   dont encourage
    noun2(taxisentral,taxi).      %%  rough
    noun2(trondheimsdrosje,taxi). %%  rough 
%   noun2(pirattaxi,taxi).
%   noun2(piratdrosje,taxi).


noun2(tbane,underground).
    noun2(metro,underground). 


noun2(teknologi,technology).  

noun2(tekst,text). 
    noun2(korpus,text).
    noun2(skrivem�te,text). %% rough
    noun2(text,text). %% Angl


noun2(teori,theory). 

noun2(tak,hold). 
  noun2(fatt,hold). %%  hold ==> tak
    
%%% noun2(tak,roof). 

noun2(takst,price). 
    noun2(barnetakst,price).       %% rough
    noun2(ungdomstakst,price).     %%  
    noun2(voksentakst,price).      %%
    noun2(takstregel,price).       %% rough
    noun2(takstbestemmelse,price). %% rough 
    noun2(takstsone,zone).  
    noun2(enhetstakstsone,zone).   %% rough   




noun2(tall,number). 
noun2(tante,aunt). 

noun2(telefon,telephone). 
noun2(telefonnummer,telephone). %% se tlf(_)
noun2(telefonnymmer,telephone). %% own  
% -----------------------------------------

noun2(telefontype,phonetype).

% noun2(terminal,endstation). % ST    %%  (terminal is a better word)

noun2(test,test).  
    noun2(pr�ve,test).         %%  kolliderer med Pr�ven som tidl. stasjon
    noun2(pr�ving,test).  
    noun2(eksamen,test).  
    noun2(kontroll,test).    
    noun2(kvalitetskontroll,test).  %%
    noun2(kvalitetssikring,test).
    noun2(testing,test).  
    noun2(uttesting,test).   

noun2(tid,time).
    noun2(bustid,time).   
    noun2(busstid,time).    %% departure   %% til hvilke busstider g�r 5a
    noun2(intervall,time).
    noun2(mellomtid,time).      %% rough
%%     noun2(periode,time).     %%  NB after tid because of paraphrase
    noun2(overgangsfrist,time). %% rough 
    noun2(tidrom,time).  
    noun2(tidrum,time).  
    noun2(tidsfrist,time). %% rough 
    noun2(tidsrom,time).  
    noun2(tidsrum,time). 
    noun2(todsrom,time). 
    noun2(tidsperiode,period). %% time). 

    noun2(tisrom,time).  

noun2(tidspunkt,clock). 
   noun2(tidpunkt,clock). 
   noun2(tidsangivelse,clock).  
   noun2(tidsponkt,clock). 
   noun2(tidspungt,clock). %%  spc
noun2(tidtabell,departure).          %%  (route_plan)  departure gives time indication
   noun2(timeplan,departure). 
   noun2(timeplane,departure).       %% sp 
   noun2(tidstabell, departure). 
   noun2(tidsskjema, departure).    
   noun2(rutetidsskjema, departure). 
   noun2(tidsplan,departure). 


noun2(time,hour). 
   noun2(heltime,hour).  
   noun2(tilme,hour). % ?

noun2(ting,thing). 
   noun2(aff�re,thing).  %% rough 
   noun2(emne,thing).   
   noun2(greie,thing).  
   noun2(sak,thing).              %%  After ting (paraphrase) 
   noun2(selvf�lgelighet,thing).  %% deep,rough (except buses), that's  what TUC knows
   noun2(stykke,thing).           %% personer/biter/ 
   noun2(tema,thing).     

noun2(tittel,title).  
    noun2(titel,title).  
    noun2(stilling,title). 

noun2(tjeneste,service). 

    noun2(tiltak,service). 

noun2(tog,train).  
    noun2(flytog,train).          %% Rough but error mode 
    noun2(kveldstog,train).       %%  (Rough)
%%     noun2(jernbane,train).        %%  most probably station 
    noun2(lokaltog,train).        %%  (Rough) 
    noun2(morgentog,train).       %%  (Rough)    
    noun2(morgontog,train).
    noun2(lokaltog,train).      
    noun2(nabotog,train).      
    noun2(nattog,train).          %% Rough 
    noun2(regiontog,train).       %% Rough 
%%    noun2(togbane,train).       %% TS
   
    noun2(togskyss,tog).   
    noun2(togtid,train).          %% Rough
    noun2(togg,train).            %% Sp 

%% noun2(tog,procession).  %% 17. mai //SUSPENDED

/* confuse  with no message   
noun2(togstasjon,railwaystation).
   noun2(togholdeplass,railwaystation). 
   noun2(t�gstasjon,railwaystation).
   noun2(jernbanestopp,railwaystation).
*/
 
    
noun2(togrute,train_route_plan). 
   noun2(togtabell,train_route_plan). 
noun2(topp,top).  %%  toppen av veien


noun2(trafikk,traffic). 
    noun2(belegg,traffic).  %% h�yt belegg = lite plass 
    noun2(bussrutekj�ring,traffic). 
    noun2(kollektivtrafikk,traffic).   
    noun2(kollektivtransport,traffic).  
    noun2(oppdragskj�ring,traffic).
    noun2(rutekj�ring,traffic). 
    noun2(skolekj�ring,traffic). 
    noun2(traffik,traffic). 
    noun2(traffikk,traffic).
    noun2(trafik,traffic).   %% SWE

noun2(trafikkplanlegger,trafficplanner). %% Techn 

%% noun2(transport,route).  %% vehicle
    noun2(logistikk,route). %%traffic ?    

noun2(trapp,stair). %% stairs trapper
    noun2(rampe,stair). %% rough, laventre
    noun2(trinn,stair).

%% trace  ako route_plan
noun2(trase,trace). 
    noun2(busstrase,trace). 
    noun2(hovedtrase,trace).
    noun2(kj�retrase,  trace). 
    noun2(tr�se,trace).  %%   (illog.)
    noun2(trace,trace).  %% eng
    noun2(tras�,trace).   
    noun2(trasee,trace).  
    noun2(trasse,trace). 
    noun2(tras�,trace).  
    noun2(rutetrase,trace). 
    noun2(rutetrasee,  trace). 
    noun2(rutetrasse,  trace).
    noun2(veitrase, trace). 

noun2(trikk,tram).  
    noun2(bane,tram). % jern bane :-)
    noun2(sporvei,tram).   
    noun2(sporvogn,tram). 
%%     noun2(tikk,tram).  %% hva siet tikk takk %% :-)
    noun2(tirk,tram).   
    noun2(tirkk,tram). 
    noun2(tirrk,tram). 
%    noun2(tram,tram).                  %% (NorwEng) ??
    noun2(trick,tram).                 %% (Swed)
    noun2(trilk,tram).  
    noun2(trilkk,tram). 
    noun2(trik,tram).                  %% (Danish)
    noun2(trike,tram).  
    noun2(trikkeavgang,tram). 
    noun2(trikkelinje,tram). 
    noun2(trikklinje,tram). 
    noun2(trikkespor,tram). 
    noun2(trikkspor,tram). 
    noun2(trikkeovergang,tram). 
    noun2(trikkovergang,tram). 

    noun2(trikketid,tram).    %% Rough 
    noun2(triukk,tram).   
    noun2(trykk,tram).  

noun2(trikkeholdeplass,tramstation). 
   noun2(trikkholdeplass,tramstation).
   noun2(trikkeholdplass,tramstation).
   noun2(trikkeholdplass,tramstation).
   noun2(trikkestasjon,tramstation). 
   noun2(trikkestopp,tramstation).

noun2(trikkerute,tram_route_plan). 
   noun2(trikketute,tram_route_plan).  %% contag 
noun2(trikketabell,tram_route_plan).
noun2(trikketid,tram_route_plan).      %% (roughly)

noun2(trikkrute,tram_route_plan).  
noun2(trikktabell,tram_route_plan).   %%
noun2(trikktid,tram_route_plan).      %% 


noun2(trykknapp,button). 
    noun2(knapp,button).
    noun2(stoppknapp,button). 
    noun2(stoppeknapp,button). 

noun2(tull,nonsense). 
    noun2(t�v,nonsense). 
    noun2(t�ys,nonsense). 

noun2(tunnel,tunnel). 
    noun2(tunel,tunnel).
    noun2(tunell,tunnel).
    noun2(tunnell,tunnel).    

noun2(turingtest,turing_test). 
   noun2(turing_test,turing_test). 

noun2(tv,television).   
   noun2(fjernsyn,tv). 

noun2(tvil,doubt). %% ogs� v imp

noun2(type,type). 

%% noun2(u 

noun2(uflaks,badluck). 

noun2(uhell,accident).  
    noun2(bussulykke,accident). 
    noun2(kollisjon,accident).     
    noun2(ulykke,accident).  
    noun2(kr�sj,accident). 
    noun2(sammenbrudd,accident). 

noun2(uke,week).  
    noun2(uge,week).   %% Dan 
    noun2(veke, week). 
% noun2(ukedag,  weekday)  %% -> day.  
    noun2(ukenummer,week). %%  Rough 

noun2(underholdning,entertainment). 

noun2(undervisning,education).
    noun2(oppl�ring,education).

noun2(ungdom,youth). %% Important distinction child).                 %%  (roughly) ???

noun2(uniform,uniform). 

noun2(univers,universe). 
   noun2(kosmos,universe).      %%  \+ Korsmo
   noun2(verdensrom,universe).  %% ? 
noun2(universitet,university).
noun2(ur,  clock). 
noun2(usannhet,untruth).  %% lie ?
   noun2(l�gn,untruth).   
   noun2(selvmotsigele,untruth). 

noun2(utf�relse,implementation). %%  rough

noun2(utgang,exit). 
    noun2(inngang,entry). 

noun2(utslipp,exhaust). %% general -> milieu specific 

noun2(utveksling,exchange). 

noun2(utvikling,development). 
    noun2(bygging,development).  
    noun2(utbygging,development).
    noun2(videreutvikling,development).

noun2(uvitenhet,ignorance). 

noun2(uvenn,enemy).  %%  :-(
    noun2(fiende,enemy).  %%  :-(

%% noun2(v 


noun2(vakt,watch).   

noun2(vane,habit).  
   noun2(bussvane,habit). 

noun2(vare,care). %% .. p� %% TA-110815

noun2(variant,variant).  

noun2(varighet,duration).  
     noun2(margin,duration). 
     noun2(mellomrom,duration). 
     noun2(mellomrum,duration). 
     noun2(stund,duration).  
     nounq(tid,duration). %% Hazardous  EXPERIMENT
     noun2(tidsforbruk,duration).
     noun2(overgangstid,duration).   %% rough 
     noun2(regulering,duration).     %% ad hoc, rough %
     noun2(reguleringstid,duration).  %% 
     noun2(st�tid,duration).  
     noun2(ventetid,duration). %% not forsinkelse
     noun2(venting,duration).  %% rough  

noun2(varsel,notification).  
   noun2(p�minnelse,notification). %%  reminder). 
   noun2(p�minning,notification). %
   noun2(advarsel,notification).   
   noun2(beskjed,notification).  
   noun2(alarm,notification). 
   noun2(varsling,notification).  
   noun2(vekking,notification).    %% fapp

noun2(venn,friend).
    noun2(pennevenn,friend).   %% TA-110620


noun2(verden,world). 
    noun2(allverd,world).     %%  (allverden/  techn)
    noun2(jord,world). 
    noun2(klode,world).       %% TA-110118
    noun2(utland,world).      %% rough 
    noun2(v�rd,world). 

noun2(verksted,workshop).       %%  (garage?)
noun2(versjon,version).
%%     noun2(oppdatering,version).  %% update
    noun2(fors�ksversjon,version). 
    noun2(nettversjon,version).     %% rough %% TA-110309
    noun2(instans,version).   
    noun2(oppgradering,version). 
    noun2(programvareversjon,version).
    noun2(revisjon,version). 
    noun2(utgave,version).
    noun2(versjonsnummer,version).  %% rough
    noun2(verson,version).  
    noun2(version,version). 
    noun2(verson,versjon).  

noun2(vert,host).  
    noun2(vertskap,host).


noun2(voksen,adult).             %%  MAIN DEFINITION first !!! (paraphrase)
   noun2(pensjonist,adult).      %% (PRAGMATIX)
%%    noun2(foreldre,adult).        %%    -> parent

noun2(veg,street).  %% STREET is official
    noun2(avkj�ring,street).  %% Rough
    noun2(vei,street).  
    noun2(sti,street).   %%  rough 
    noun2(veikryss,street).    %%  rough 
    noun2(kryss,street).       %%  rough %% TA-110825
    noun2(rundkj�ring,street). %%  rough %%
    
noun2(vei,way).      %% ? kort vei //nb way after street

noun2(veiledning,information). %% rough
    noun2(ruteplanveiledning,information). %% rough 
noun2(vekt,weight). 
noun2(venn,friend).
    noun2(bekjent,friend). 
    noun2(bestevenn,friend). %% ?
    noun2(kamerat,friend).  
    noun2(kammerat,friend).  
    noun2(kolleg,friend). %% ad hoc kolleg(a)er 
    noun2(kollega,friend).  %% employee ?  
    noun2(kompis,friend). 
    noun2(ven,friend).      %% NN
    noun2(venninne,friend). %% 
    noun2(veninne,friend).  %%

noun2(venstre,left). 
noun2(h�yre,right). 

noun2(vin,wine). %%  :-)

noun2(vindu,window).

noun2(vinter,winter).  
    noun2(senvinter,winter).     %%  rough 
    noun2(vinterperiode,winter). 
    noun2(vintersesong,winter).
    noun2(vinterstid,winter). 
    noun2(vintertid,winter). 
 

noun2(vinterrute,winterroute).  
    noun2(h�sttid,winterroute).  
    noun2(h�strute,winterroute).   %% not 2001
    noun2(h�sttabell,winterroute). %%  
    noun2(skole�r,winterroute).    %% rough
    noun2(vinterrue,winterroute). 
    noun2(vinterute,winterroute).
    noun2(vinterrrute,winterroute). %%  own 
    noun2(vinterversjon,winterroute). 

noun2(virus,virus). 


noun2(v�r,weather).
    noun2(blest,weather). 
    noun2(bl�st,weather).
    noun2(finv�r,weather).       %%  (Rough) 
    noun2(godv�r,weather).  
    noun2(grad,weather).  
    noun2(gr�v�r,weather).     
    noun2(regnv�r,weather).   
    noun2(storm,orkan). 
    noun2(storm,weather). 
    noun2(kuling,weather).  
    noun2(bris,weather).  
    noun2(styggv�r,weather). 
    noun2(temperatur,weather).  
    nounw(uv�r,weather).         %% sic 
    noun2(vejr,weather).         %% DK ? 
    noun2(ver,weather).          %% Nynorsk
    noun2(vind,weather).
    noun2(vindretning,weather). 
    noun2(v�rforhold,weather).   %% TA-100828
    noun2(v�rmelding,weather). 

noun2(v�ske,liquid). 

%% noun2(v�r,spring).   %% SUSPENDED , ambig 

noun2(v�r,spring).   %% allows v�renen %% TA-110415

noun2(ny�r, spring).  %% ny�ret



noun2(webadresse,webaddress). 
    noun2(bussorakelside,webaddress).     %% rough
    noun2(hjemmeadresse,webaddress).  %%
    noun2(hjemmeside,webaddress).     %% 
    noun2(internettadresse,webaddress).
    noun2(internettside,webaddress). 
%%     noun2(ipadresse,webaddress).   
    noun2(lenke,webaddress). 
    noun2(link,webaddress). 
    noun2(nettadresse,webaddress).
    noun2(nettside,webaddress).      %%  (Rough)    
    noun2(nettsted,webaddress).  
    noun2(url,webaddress).  
    noun2(webgrensesnitt,webaddress). %%  Rough
    noun2(webside,webaddress).        %%

%% noun2(w

noun2(webmaster,webmaster).  
noun2(wumpus,wumpus). %% R&N AIMA (:-#) 

noun2(postnummer,zip).  
    noun2(postnr,zip).   %%  etc.

%% noun2(x
%% noun2(y
%% noun2(z

noun2(�re,honour).   %% du skal ha ...

%% noun2(� 


%% noun2(� 

noun2(�kning,increase).      %% TA-110502
    noun2(dobling,increase). %%  rough

noun2(�l,beer). %% ?-)
    noun2(pils,beer). %
    noun2(�ll,beer).  

noun2(�nske,request). %% a wish  %% TA-101124 // haz, �nsker verb

noun2(�re,cent). %% ear). %%  body and coin
noun2(�ring,cent). %% rough (1/100) crown 

noun2(�y,island). %% confuse �ya ? 
noun2(�yeblikk,moment). 

noun2(hull,interval). %% rough 
noun2(�pningstid,opening_hours). 
noun2(�r,year). 
    noun2(aar,year).  
    noun2(�rstal,year).   %% NN 
    noun2(�rstall,year). 

%% noun2(� 

noun2(�rsak,cause).   
   noun2(argument,cause). %% rough 
   noun2(bakgrunn,cause).
   noun2(grunn,cause). 
   noun2(hoved�rsak,cause).
   noun2(orsak,cause). 


noun2(�rstid,season). 

% % % %

noun2(mandag,monday).  noun2(m�ndag,monday). 
    noun2(mandagsmorgen,monday). %% Rough  
noun2(tirsdag,tuesday).    
    noun2(tirsdagsmorgen,tuesday).    
    noun2(tisdag,tuesday). 
noun2(onsdag,wednesday).   
    noun2(onsdagsmorgen,wednesday).   
noun2(torsdag,thursday).   
    noun2(torsdagsmorgen,thursday).   
noun2(fredag,friday).      
    noun2(fredagsmorgen,friday).      
    noun2(fredagkveld,friday).  %% Rough 
    noun2(fredagskveld,friday). %% Rough 
noun2(l�rdag,saturday).    
    noun2(laurdag,saturday). 
    noun2(lordag,saturday). 
    noun2(l�dag,saturday).  
    noun2(l�rdagsmorgen,saturday). %% Rough (Rough, but adequate) 
    noun2(l�rdagsmorran,saturday). %% 
    noun2(l�rdagskveld,saturday).  %%   splitword
    noun2(l�rdagmorgen,saturday).  %% Rough
    noun2(l�rdagkveld,saturday). 

noun2(s�ndagmorgen,sunday).  %% Rough (but works)

noun2(s�ndag,sunday).      
    noun2(sondag,sunday).
    noun2(soendag,sunday). 
    noun2(s�ndagsmorgen,sunday). %% Rough, but adequate


noun2(mandagsaften, monday).  %% Rough
noun2(tirsdagsaften,tuesday).  
noun2(onsdagsaften, wednesday). 
noun2(torsdagsaften,thursday). 
noun2(fredagsaften, friday). 
noun2(l�rdagsaften, saturday). 
noun2(s�ndagsaften, sunday).  

noun2(mandagskveld, monday).  %% Rough 
noun2(tirsdagskveld,tuesday).  
noun2(onsdagskveld, wednesday). 
noun2(torsdagskveld,thursday). 
noun2(fredagskveld, friday). 
noun2(l�rdagskveld, saturday). 
noun2(s�ndagskveld, sunday).  




%% VERB SECTION   

verbroot2(X,Y):-verb2(X,Y).


verb2(ang�,concern). 
     verb2(anng�,concern).       %% spiw
%%     verb2(gjelde,concern).    %% also apply 
     verb2(omhandle,concern). 


verb2(anse,regard). 

verb2(anvende,use). 

%% Ankomme

% ankomme intransitiv, men med nil_complement 
% ankomme NTH solved by nil-compl
% ankomme P = ankomme nil P


verb2(ankomme,arrive).  
    verb2(ankmomme,arrive). %% own 
    verb2(annkomme,arrive).
    verb2(ankome,arrive). %% spc 
    verb2(arrivere,arrive). %% :-)
    verb2(havne,arrive). %% :-) 

%% verb2(ankomme,pass).  

% important in :   buss  forbi tempe kirke (1.) med buss som ankommer sentrum (2.).

%--------------------------------                                 


verb2(ake,go). 
verb2(akseptere,accept).
verb2(anbefale,recommend).

verb2(angi,give).
    verb2(angive,give).   %% Danish 

verb2(anta,believe).
verb2(arbeide,work).      %% (roughly)
    verb2(slite,work). 
verb2(arrangere,arrange). %% techn sette opp 

verb2(automatisere,automatize). 
    verb2(billetere,automatize).  %% ad hoc 
    verb2(billettere,automatize). %%   
    verb2(helautomatisere,automatize). %%   
verb2(avbl�se,cancel).
verb2(avg�,depart).
verb2(avlede,derive).
verb2(avslutte,stop). 

verb2(basere,base). 

verb2(befinne,befind).    %%  ( Norwagism, artificial) ( befinne seg)
verb2(begripe,understand).
verb2(begynne,start). 
    verb2(begyne,start).
    verb2(beynne,start). %%  own spc
    verb2(bynne,start).  %% Tr�ndersk
verb2(behandle,treat). 
     verb2(betjene,treat). 
verb2(beholde,keep).  
verb2(beklage,regret). 
verb2(bekymre,beworry).   %%  Norwagism (bekymre seg)

verb2(benytte,use).  %% unng� benyttet = bruke .. �   

verb2(beskrive,describe).
verb2(bestemme,decide).  
   verb2(beslutte,decide).  
   verb2(besteme,decide).  
   verb2(ombestemme,decide).  %% roug

verb2(bestille,order).   %% Telebuster %% (kj�pe) 

verb2(best�,manage). 
    verb2(best�,consist).
%   verb2(bestaa,consist). 
%% :-) Turings test

verb2(besvare,tell).      %% technical = svare 
   verb2(gjengi,tell).

verb2(besvare,answer1).   %% ? 
   verb2(gjengi,answer1).


%% verb2(bes�ke,pass).  %%  (a place) %% jeg bes�ker en person****
verb2(bes�ke,visit). 

verb2(bes�rge,ensure). %% s�rge for

verb2(betale,pay).  
    verb2(bettale,pay). 
    verb2(spandere,pay).  
verb2(betjene,pass).      %% serve). for all p.p.

verb2(betrakte,regard).  

verb2(bety,indicate).  %% "mean2" %% TA-110112  
                       %% technical, miss sense in E // signify
    verb2(inneb�re,indicate).
    verb2(indikere,indicate). 
    verb2(tilsi,indicate).   


%% verb2(bli,become).  %%! NB new verb %% Kun hjelpeverb %% EXPERIMENT
     verb2(bli,be).     %% "kan jeg bli varslet "


%%%%   verb2(forbli,be).      %% forbi fapp
verb2(bo,live). 
    verb2(bu,live). 
verb2(bringe,bring). 

verb2(bruke,use).          %% benytte

verb2(bruke,use2).        %% pleie (Norwagism) %%  NB  MIXED WITH SPEND
%    verb2(trenge,use2).  %%  ????

   verb2(beregne,use).     %% ..tid 
   verb2(misbruke,use).    %% Rough 
   verb2(missbruke,use).   %% 
   verb2(nyttiggj�re,use).   %   utilize (rough, reflexive) 
  

verb2(misoppfatte,misunderstand). 


%%% verb2(busse,run).  %%  � busse  %% Hazard

%% verb2(bruke,take).        %% causes backtracking 

verb2(bry,worry).   %% Norw bry seg Rough 

verb2(bygge,make). %% rough 
verb2(bytte,change). 

verb2(debugge,debug). %% TA-110707


verb2(definere,describe). %% define).
    verb2(omdefinere,describe). 

verb2(dekke,cover). 
    verb2(dekke,betale). 

verb2(delta,be).          %% rough

verb2(demonstrere,demonstrate). 

verb2(diskutere, discuss). 
    verb2(dr�fte, discuss).  
    verb2(drofte, discuss). 

verb2(distribuere, distribute). 
    verb2(fordele, distribute).
    verb2(utbre, distribute).
    verb2(utbrede, distribute). %% SIC

verb2(dra,go).            

verb2(drive,operate).  
    verb2(drifte,operate).

verb2(drikke,drink).      %% :-) 
     verb2(nyte,drink).    %%  alkohol... // ad hoc  nytte

verb2(drive,work).        %%  hva driver du (p�) medv
%% verb2(drive,drive).       %%  company "drives"  a bus(iness)
  % verb2(drive,make).    %%  drive gj�n med ?-)
verb2(dr�mme,dream).  
verb2(d�,die).


verb2(egne,fit). %% .. seg 

verb2(eie,own). 
   verb2(disponere,own). 

verb2(eksistere,exist).
    verb2(inng�,exist). 


%% verb2(elske,love).    %% Facetious
    verb2(opptre,exist). 
    verb2(vedvare,exist). %% rough 

verb2(eksportere,export). 
verb2(importere,import).  %%  technical

verb2(ende,end).  
verb2(endre,modify). %% change).  change means change bus/modify means modify routes

verb2(erstatte,replace).

verb2(estimere,estimate). 
verb2(ettersp�rre,seek).

        
verb2(falle,fall).        %%  ( 17. mai faller p� en torsdag)
verb2(fatte,understand). 
verb2(finne,find).        %%          ( jeg finner 
    verb2(finde,find).    %%  (DAN)
 % verb2(finnes,exist). 
   verb2(hitte,find).     %% SW
verb2(fjerne,remove).     %%         (remove is reserved i sicstus)
    verb2(blokkere,remove).  %%  rough
    verb2(fj�rne,remove).   

verb2(fly,fly). 
verb2(flytte,move).   
   verb2(begi,move).      %%  begi seg
verb2(forandre,change). 
verb2(forbedre,improve). 
    verb2(bedre,improve).    %%  haz better?  
    verb2(skjerpe,improve).  %%  :-)
    verb2(utbedre,improve).  

verb2(forebygge,prevent).  %% tell 
    verb2(hindre,prevent). %% rough? hinder/obstruct

verb2(foresl�,propose). %% tell 

verb2(foreta,do1).  

verb2(foretrekke,prefer). 
    verb2(prioritere,prefer). 

verb2(forhandle,negotiate). %% NB iv %% TA-110701 fornadle om=discuss

verb2(forlate,leave2).    %%   (Norsk, strengt transitiv)
    verb2(folate,leave2).  %% sp

verb2(forsinke,delay).

verb2(forske,investigate). 

verb2(forst�,understand).
    verb2(f�rst�,understand).  
    verb2(f�rst�,understand). 
    verb2(godta,understand). 
    verb2(innse,understand).  
    verb2(inse,understand).   %% sp
    verb2(konstatere,understand). %% see?
    verb2(oppfatte,understand).
    verb2(sj�nne,understand). 
    verb2(skj�ne,understand). %%  NN
    verb2(skj�nne,understand).
    verb2(sk�nne,understand). %% DK 
    verb2(takle,understand).    %%  :-)

verb2(forsvinne,disappear).  
    verb2(drukne,disappear).



verb2(fortelle,tell). %% requires at
%%     verb2(foresl�,tell).   %% propose vako tell 
    verb2(annonsere,tell).
    verb2(avsl�re,tell).  %% TA-110808
    verb2(fotrelle,tell). %% sp 
    verb2(hevde,tell).   
    verb2(begrunne,tell). 
    verb2(forklare,tell). 
    verb2(formidle,tell). 
    verb2(fortele,tell).  
    verb2(fotelle,tell).  
    verb2(informere,tell).
    verb2(innr�mme,tell).  %% Rough 
    verb2(kunngj�re,tell). 
    verb2(melde,tell). 
    verb2(oppgi,tell). 
    verb2(opplyse,tell). 
    verb2(publisere,tell). 
    verb2(tilkjennegi,tell). 
    verb2(sp�,tell). %% :-) om bussavganger? Ja 
    verb2(tipse,tell). 
    verb2(utdype,tell).  
    verb2(videreformidle,tell). 

%%     verb2(varsle,tell).  %% More specific NOTIFY 

%% verb2(oppgi,state). %% pure TV 
    verb2(oppgi,tell).   %% tv/rv
    verb2(p�peke,tell).  


verb2(forkorte,shorten). 

verb2(forutsette,require). 
    
verb2(fortsette,continue). 

verb2(forvente,expect). 
%%     verb2(vente,expect).  %%  vente � rekke bussen Hazard ? 
                             %% vennligst vent
verb2(for�rsake,cause). 
   verb2(medf�re,cause). 

verb2(frakte,take).       %%  ( bring )
    verb2(transportere,take). 
    verb2(tranportere,take).   %%  spell

verb2(frigi,release). %% TA-110320
   verb2(frigj�re,release).
verb2(fryse,freeze). 

verb2(fullf�re,finish).  

verb2(fungere,function).  
    verb2(funke,function). 

    verb2(virke,function).  %%  appear/function %% TA-110304

verb2(fylle,fill). %% .. t:kort 
        %% Norw rough f. 67 �r 

verb2(f�de,bear2). 
verb2(f�le,feel).

verb2(f�re,lead). 

verb2(kjede,bore).  


%% F�lge  %%%%%%%

%% Problematic f�lges vanlige bussruter ? 

verb2(f�lge,accompany).   %% jeg f�lger ham p� bussen

% Hvilken buss f�lger Inneheredsveien til Lademoen kirke? 

verb2(f�lge,take).        %% hvilken rute skal jeg f�lge (Hazard ?)
verb2(f�lge,follow).      %% buss f�lger rute 
verb2(f�lge,pass).        %% bus follows road

%%%%%%%%%%



% SYNDROME    hvilken rute f�lger bussen = ? bus pass route FAILS, then intransitive and !


verb2(feste,fasten).

%% verb2(f�re, do1). %% f�re en dialog %% special // blocks f�rte -> f�rste

verb2(f�,get).  %% generic verb/aux  f� kj�rt 
    verb2(motta,get). 
    verb2(fortjene,get).
    verb2(oppn�,get).

/*  get er  supersyn
verb2(f�,receive).        %%  ( get is ambiguous )
    verb2(motta,receive). 
    verb2(fortjene,receive).
*/

verb2(gi,give).  
    verb2(angi,give). 
    verb2(avgi,give). 
    verb2(donere,gi).  
    verb2(give,give).       %%  (Danish)
    verb2(muliggj�re,give). %%  ?
    verb2(overdra,give). %% buy
%%     verb2(skaffe,give). 
    verb2(tildele,give).  
    verb2(tilby,give). 
    verb2(yte,give). 

verb2(generere,make). 

%% verb2(gjelde,last). %% hvor lenge gjelder en billett %% apply
%% verb2(gjelde,concern).  %% fronted %% SUSPENDED

    verb2(gjelde,apply). 

%%    verb2(gjelde,exist).         %% (roughly) 

    
verb2(gjemme,hide). 
    verb2(skjule,hide). 

verb2(gjenst�,remain). 

verb2(gjenta,repeat). 
    verb2(repetere,repeat). 

verb2(gjette,guess). %% tell). 


verb2(gj�re,do1).         %%   (what do you do1 ?-)
    verb2(bedrive,do1). 
    verb2(gjennomf�re,do1).    
    verb2(gjere,do1).     %% NN 
    verb2(gk�re,do1).     %% gk�res 
    verb2(j�re,do1). 
    verb2(utf�re,do1). 
    verb2(utrette,do1).   %%

verb2(glane,look).        %% NB ikke se %% (se at) 
verb2(glede,enjoy).       %% rough
verb2(glede,please).       %% rough
verb2(glemme,forget). 

verb2(godkjenne,approve).

verb2(gratulere,congratulate). %%  :-)
verb2(grense,border). 

verb2(gripe,take).
    verb2(inndra,take).     %% rough
    verb2(konfiskere,take). %% confiscate

verb2(grue,dread).          %% gue seg for/til (not impl) 

verb2(g�,go).



%%     verb2(komme,go). %% NB after go under komme
%%     verb2(havne,go). %% come

    verb2(bevege,go).       %%   bevege seg = g� seg OK
    verb2(forflytte,go).    %%
%%    verb2(f�re,go). 
%%     verb2(hoppe,go).        %% hoppe p� bussen %% -> walk
    verb2(klatre,go).   
    verb2(returnere,go). 
    verb2(rykke,go).        %%  (ut?)
    verb2(satse,go).        %% hvilken buss skal jeg satse p� / jump
    verb2(stige,go).        %%  (steg,steget)
    verb2(stikke,go). 

    verb2(kkomme,go).
    verb2(k�me,go).  
    verb2(k�mme,go). 
    verb2(strande,go).


% verb2(g�,go1).            %%  g� meg   transitive (Norwagism)
% verb2(g�,go2).            %%  bus goes route      (Norwagism)
                            %% Too complicated
verb2(ha,have). 
    verb2(fylle,have). %% rough  fylle bursdag %% TA-110215

verb2(haike,hitchhike).   %%  :-)

verb2(handle,shop).
verb2(handle,handle2). %% Norwagism // Handle om 
   


verb2(haste,be_urgent).

verb2(hate,hate). 
    verb2(mislike,hate). 
verb2(hende,happen). 
    verb2(foreg�,happen). %% irreg 
    verb2(forekomme,happen). %%  irreg 
    verb2(oppst�,happen). %% irreg
    verb2(skje,happen). 

verb2(hente,fetch). 
    verb2(grave,fetch).    %% fram .. bilen 
    verb2(laste,fetch).    %% ned %% data rough 
    verb2(sakse,fetch). 
%%    verb2(klippe,fetch).   %% copy (..save)
 
verb2(henvende,turn).      %% technical  henvende seg
    verb2(hendvende,turn). %% spc 
    verb2(hendvenne,turn). %
    verb2(hennvende,turn). %% spc 
    verb2(hennvenne,turn). 

/*
verb2(hete,be2).     %%  Norwagism  // hete -> v�re 
   verb2(hede,be2).     %%  danish    
   verb2(hedde,be2).    %%  dial
*/

%% hva heter du \= hva er du  

verb2(hete,be_named).     %%  Norwagism 
   verb2(hede,be_named).     %%  danish    
   verb2(hedde,be_named).    %%  dial
   verb2(heite,be_named).  
   verb2(heitte,be_named). 
%%%    verb2(hetere,be_named).   %%  sp -> heter imp

% verb2(help,help).          %%  ( help unwanted_place )

verb2(hilse,greet). 
   verb2(heie,greet).  %% rough 
verb2(hjelpe,help).
   verb2(avhjelpe,help).
   verb2(bidra,help).
   verb2(p�hjelpe,help). %% ? own

verb2(holde,hold). 
    verb2(holde,keep).  %% holde m�te ???
    verb2(oppbevare,keep).  %% .. billetten

verb2(hoppe,walk). %%  ? 

verb2(huske,remember). 
    verb2(hugse,remember).    %%  NN

verb2(hvile,sit).   %% rough 
    verb2(avspasere,sit). %% rough 

verb2(h�re,hear).   %% trans 
    verb2(ha�re,hear).   %% hører 
    verb2(hoere,hear). 
    verb2(h�yre,hear).   %%  NN
verb2(h�re,listen).      %% intrans
    verb2(lytte,listen). 

verb2(h�res,appear). %% Norw h�res rart ut 
%%%%%%%%%%%%%%%%    verb2(virke,appear). %% virke p�fallende 
    verb2(fremg�,appear). %% ?
verb2(h�pe,hope).  

%%     verb2(h�pe,believe). %% Suspended
    verb2(satse,believe). 

verb2(ilegge,fine). %% eng: to fine

verb2(implementere,make). 
verb2(inneholde,contain).
%%    verb2(inneheld,contain).   %% NN pres fin -> verb_form
    verb2(indeholde,contain).  %%  (Dan)
    verb2(inkludere,contain).
verb2(innr�mme,admit). 
verb2(innstille,cancel). 
    verb2(kansellere,cancel). 
    verb2(kanselere,cancel). 
verb2(jobbe,work).      %%(roughly)

%% verb2(kalle,call).   %% kalle noen en dust  ( special, bitransitive)
                        %% kan kalles 
verb2(kalle,name).      %%  confutant kalles
   verb2(d�pe,name).       %% TA-110707
   verb2(omd�pe,name).     %% TA-110707


verb2(kaste,throw). 
verb2(kjenne,recognize).     %% OK B Spelling
    verb2(kjene,recognize).  %%  spiw  
    verb2(gjenkjenne,recognize). 
%% verb2(kjenne,know1).  %% OK


verb2(kj�pe,buy).
    verb2(bestille,buy). 
    verb2(fornye,buy).  %% roughly
    verb2(kjope,buy). 
    verb2(k�be,buy).    %% Dan 
    verb2(k�pe,buy).    %% Dan?
    verb2(sikre,secure).   %% sikre seg 
    verb2(skaffe,buy).  %% rough     %% 

%% kj�re  % % % % % % % % 


verb2(kj�revrel,kj�re_v_rel). %% exerimant vako  run

verb2(kj�re,run).         %% run a bus(iness)
    verb2(administrere,run). %% rough
%%     verb2(drifte,run).    %% rough    %% operate 
    verb2(hj�re,run).     %% own
    verb2(kjore,run).  

    verb2(befordre,run).
%%     verb2(bringe,run). 
    verb2(frakte,run).    %%   meg til byen
    verb2(kh�re,run).     %% own slip
    verb2(kjre,run).  

%%  verb2(kj�re,take).    %% last option?     %% transitive (I take bus/ bus takes me ...)

    verb2(k�re,run).      %% Dansk
    verb2(k�yre,run).     %% NN     %%
    verb2(kj�yre,run).    %% NN     %%
    verb2(renne,run).  
    verb2(rulle,run). 
    verb2(skj�re,run).    %% spiw %% TA-110526   
    verb2(sj�re,run).     %% spiw 
    verb2(svippe,run).    %% Coll
    verb2(trille,run).  
%%     verb2(ta,run).        %% jeg tar kontakt  // run tv


verb2(klage,complain).

verb2(klare,manage). 
%%    verb2(best�,manage).    %%  :-)
    verb2(fikse,manage).  
    verb2(gidde,manage). 
    verb2(gide,manage).   
    verb2(greie,manage).
    verb2(h�ndtere,manage). 
    verb2(makte,manage).
    verb2(mestre,manage).  
    verb2(orke,manage).
    verb2(overkomme,manage). 

verb2(kollidere,crash). 

verb2(komme,come).   %% spec.   station come/ day come after    
    verb2(framkomme,come). %% framkom ? 
    verb2(fremkomme,come). 

    verb2(komme,go). %% after komme
    verb2(k�yre,go).        %% NN     

verb2(kommentere,comment). 

verb2(kontakte,contact). 
verb2(konversere,speak). %% (talk?) 

verb2(klippe,cut). %% klippe billett 

verb2(kopiere,copy).      %%  datasjargong
%%     verb2(klippe,copy).   %% copy (..save) 


verb2(kople,connect). 
    verb2(knytte,connect). %% TA-110808

verb2(kreve,expect). 
verb2(krysse,correspond). %% rough %% TA-100903 

verb2(korrespondere,correspond).
    verb2(koordinere,   correspond). 
    verb2(korepsondere, correspond). 
    verb2(korespondere, correspond).
    verb2(koresspondere,correspond). 
    verb2(koresponderre,correspond).
    verb2(korenspondere,correspond).
    verb2(korispondere, correspond).
    verb2(korrenspondere,  correspond).
    verb2(koerepsondere, correspond). 
    verb2(korepsonderere, correspond). %% ?
    verb2(korresspondere, correspond). 
    verb2(korrspondere, correspond). 
    verb2(korresponere, correspond).
    verb2(korspondere,  correspond). 
    verb2(krysse,       correspond).  
    verb2(samkj�re,     correspond). 

verb2(koste,cost).
    verb2(joste,cost). %%  own
    verb2(korste,cost). 
    verb2(k�ste,cost).

%% verb2(l 

verb2(la,let). 

verb2(lagre,save).
    verb2(frelse,save). %%  :-)
    verb2(lime,save).   %% (copy/save)
    verb2(spare,save).  %%

verb2(lage,make). %% NB laget laget // ikke lagt 
    verb2(danne,      make). 
    verb2(innstallere,make). %% rough
    verb2(innstalere, make). 
    verb2(installere, make).  
    verb2(instalere,  make). 
    verb2(kode,       make). 
    verb2(kompilere,  make).  
    verb2(konstruere, make). 
    verb2(lave,       make). %%  DK
    verb2(muliggj�re, make).
    verb2(opprette,make).  
%%     verb2(ordne,   make).  %% det ordner seg (SIC)
    verb2(orne,    make).  %% Dial
    verb2(produsere,  make).
    verb2(utvide,  extend). 

    verb2(utvikle, make).       %% develop ?
    verb2(videref�re, make). %%  rough develop ?
    verb2(videreutvikle, make). %%  rough develop ?

verb2(lande,arrive). %% land).  
   verb2(le,laugh).    %%  collides with Ler %% TA-110116

%% verb2(le,laugh).    %% :-)) Telebuster Hien-Nam le

%% verb2(late,make). %% late som om =make as if Techn (pretend?) 
 
verb2(legge,lay). 
%%     verb2(lime,lay). %%  save
    verb2(innlegge,lay). %% rough legge (inn)

verb2(lengte,long).         %% :-)
    verb2(ivre,long).  %% rough %% TA-110329 etter

verb2(leie,hire).           %%  ogs� noun
verb2(lese,read). 
    verb2(gjennomg�,read). 
verb2(lete,search). 
verb2(leve,live).   

verb2(overleve,survive).  %% TA-101117 :-)

verb2(overv�ke,watch). %% TA-110526

verb2(levere,deliver). 

% verb2(ligge,be).   
%  Sad story:   bus goes to nth which is in sentrum at 13 => means bus passes gl�s
%                                                            not   nth is in sentrum
%  Needs be for internal reasons                         
%
verb2(ligge,lie1).  
 verb2(lige,lie1).   %% spell

verb2(ligne,resemble).  
   verb2(etterligne,resemble).  %% rough

verb2(like,like). 
%%     verb2(elske,like).     %% :-) ->  love is defined
%%     verb2(gille,like).  %% S :-) %% Harald Gilles gate %% TA-110214
    verb2(digge,like).  %% ? 

verb2(liste,list). 
    verb2(dumpe,list). 
verb2(logge,log). 
   verb2(loge,log). %% own
   verb2(loggf�re,log).  
verb2(lokalisere,finne). %% TA-110724
verb2(love,promise). 
verb2(lukke,close).
%%    verb2(fryse,close). %% subscription 

verb2(lure,wonder).
    verb2(lurere,wonder).
%%%    verb2(lurje,wonder).  %% freak ?
    verb2(undre,wonder). 
verb2(lyve,lie2). 
    verb2(juge,lie2).
    verb2(lyge,lie2). 

verb2(l�re,learn).   %% SUSPENDED TEST
   verb2(oppleve,learn). %% Rough (experience)

verb2(l�nne,pay2). %% det l�nner seg 
    verb2(l�ne,pay2). 
verb2(l�pe,walk).          %% For all PP, buses go, humans walk
    verb2(l�pe,run). %% after kj�re=run
    verb2(jogge,walk).  
    verb2(renne,walk).     %% (rant,rant)
    verb2(springe,walk). 

verb2(l�se,buy). %% .. ticket 
verb2(l�se,solve). 

verb2(l�ne,borrow). %% lend?

verb2(l�se,stop). %% l�st=stoppet %% rough

verb2(more,amuse).   



verb2(narre,fool). 
    verb2(dumme,fool).  %% dumme (seg) ut
    verb2(lure,fool).  %% lure p�

verb2(nekte,deny).  
verb2(nekte,refuse). 
verb2(nevne,say). %% TA-100824
%% verb2(nevne,list).  

verb2(notere,write). 

%% verb2(nytte,use).  %% confuse  har nytte av
% verb2(n�,pass) .                %% ONLY TRANSITIVE, 
                                      %% pass is also intransitive
                                      %% buss 5 n�(r)

verb2(n�,reach) .               %% (take)  ...  bussen n�r jeg skal til 
                                    %                     ==>  bussen tar meg ....
                                    % og i kveld m� jeg n�

%% n�r bussen fra kroppan marka kl 1200 ?

verb2(mangle,miss).   

verb2(mene,mean). %% hva mener du \+ hva betyr du 
   %% verb2(mene,believe). 
%%     verb2(anse,mean). %% "anser for � v�re" %%  -> regard


verb2(merke,discover).

verb2(merke,label).             %% En buss merket 73

verb2(misforst�,misunderstand). 
    verb2(feiloppfatter,misunderstand). 
verb2(miste,lose). 
   verb2(misste,lose). 
   verb2(mistte,lose). 
verb2(m�te,meet). 
    verb2(treffe,meet). 
verb2(m�tes,meet2).             %% intransitive for a set
    verb2(h�ras,meet2). %%  ?
    verb2(h�res,meet2). %%
    verb2(sees,meet2).  
    verb2(samles,meet2). 
    verb2(snakkes,meet2). 
    verb2(treffes,meet2).


%% verb2(m�le,measure). 
  

verb2(omfatte,contain).         %%  (comprise)

verb2(operere,work). %% rough %% operate 

verb2(oppf�re,list).  

verb2(oppdage,discover).  
    verb2(detektere,discover). 

verb2(oppdatere,update). 
   verb2(oppgradere,update).   

verb2(overf�re,transfer).
verb2(oversette,translate).  

% verb2(oppgi,know). 
% verb2(oppgi,know1).  

verb2(ordne,arrange). %% 
verb2(ordne,adjust).  %% ordne seg 
                          %% confuse 

verb2(opprette,start).          %%  :-)
verb2(parkere,park).

%% verb2(passe,pass).        %% ( spellerr )  passer=passerer

%% verb2(passe,suit).    %%  passere

verb2(passe,correspond).
verb2(passere,pass).
    verb2(bes�ke,pass). %% ? 
    verb2(paasere,pass).   
    verb2(paassere,pass).   %% 
    verb2(frekventere,pass). 
    verb2(pasere,pass).  
    verb2(passsere,pass).
    verb2(trafikere,pass). 
    verb2(trafikkere,pass).  %%
    verb2(traffikere,pass).  %%
    verb2(traffikkere,pass). %%
    verb2(v�rep�,pass).      %% ? 
    verb2(v�rrep�,pass).     %% ? 
%%     verb2(paserere,pass).  %% => pasere = imp
%%     verb2(passerere,pass). %% => passerer = imp

verb2(peile,search).  %% TA-110724

verb2(peke,point).

verb2(pensjonere,retire). %% .. seg 
verb2(pensjoneres,retire).  %% Norw, rough

verb2(plage,hurt).       %% rough   not worry(intr)
   verb2(spamme,hurt).   %% rough 
verb2(feile,fail).   %% very rough Norw: hva feiler deg
   verb2(feilstave,misspell). %%  suspended test

%%% verb2(halte,fail). %% Techn halt Eng

verb2(planlegge,plan). %% � ta buss=want? 
verb2(plassere,put). 
   verb2(stasjonere,put). 
verb2(pleie,use2).           %% Technical

verb2(pretendere,pretend). 

verb2(printe,print). %% write?

verb2(punktere,puncture).    %% Norw
verb2(programmere,make).
    verb2(kode,make). 
    verb2(programere,make).  %% spell

verb2(pr�ve,try).   
    verb2(fors�ke,try).

verb2(p�se,ensure). 
verb2(ramse,list). 

verb2(rapportere,report).   
    verb2(innrapportere,report).


verb2(reagere,react). %% TA-110701

verb2(regne,rain). 
    verb2(bl�se,rain). %% rough , weather

verb2(regne,calculate). 

verb2(reise,go).          %% (travel)
    verb2(fare,go). 
    verb2(fera,go).       %% dial 
    verb2(flykte,go). 
%%     verb2(f�r,go).        %% dialect %% confuse f�r 
%%     verb2(f�rra,go).   %% few
    verb2(pendle,go).     %% Rough
    verb2(rase,go). 
    verb2(rejse,go).      %%  Danish
%%    verb2(rese,go).     %% synw reise    
verb2(rekke,reach). 

verb2(relatere,relate).  %% TA-110111
   
%%     verb2(naa,reach). %% ad hoc %% =n�
    verb2(rekkke,reach).  

verb2(resette,reset). 

verb2(rette,correct).  
    verb2(justere,correct).  
    verb2(korigere,correct).    %% sp
    verb2(korrigere,correct).   %%

verb2(ringe,call). 

verb2(risikere,risk). 

verb2(rope,call). %% ..opp 
verb2(r�yke,smoke).        %%  :-(
    verb2(r�ke,smoke).    

verb2(samarbeide,work).   %% (roughly)
verb2(savne,miss). 


verb2(se,look). %% 1. intransitive  se ut// kan jeg f� se ??? 
                %% se slik ut = look thus 

    verb2(kikke,look). 

verb2(se,see).  %% 2   %% Transitive
    verb2(iaktta,see). 
    verb2(konstatere,see).      %%  understand?
    verb2(observere,see).       %% 
    verb2(registrere,register).
    verb2(registrere,see).      %% rough // write down
    verb2(registere,see).       %%  own

verb2(seile,sail).  
verb2(selge,sell). 
    verb2(kommersialisere,sell). %%  rough
    verb2(markedsf�re,sell). 
verb2(sende,send).
    verb2(overbringe,send).
    verb2(oversende,send). 
    verb2(tilsende,send).    %% fikk tilsendt 
    verb2(videresende,send). 

verb2(sette,put).       %% sette meg Norwagism

verb2(si,say).  %% does not require 'at' 
    verb2(seie,say). %% NN
    verb2(p�st�,say). 


verb2(sjekke,check). 

verb2(slette,delete). %% i.e. bokmerke
    verb2(avinnstallere,delete). 
verb2(slippe,avoid).       %% Norwagism = don't have to (intranslatable)
   verb2(sleppe,avoid).  

verb2(sykle,bicycle). 
verb2(synge,sing). 
verb2(sitte,sit).  

verb2(skade,damage). 
verb2(skape,make). 
   verb2(gjenskape,make). 
verb2(skifte,change).
verb2(skje,happen). 
verb2(skj�nne,understand).
verb2(skrive,write). 
   verb2(stave,write).  
   verb2(taste,write).  
verb2(slutte,end).        %% not stop as for busstops 
   verb2(slute,end). 


verb2(skylde,blame1). %% rough %%  skylde p�

verb2(skyldes,is_caused_by).     %% Technical 
   verb2(skyldtes,is_caused_by).

%% verb2(skylde,owe). %% Suspended 

verb2(skynde,hurry). 

verb2(sl�,turn). %% off/on 
   verb2(skru,turn). %% TA-110518
verb2(sl�,beat). %% TA-101112


verb2(smake,taste).  %%  both tv and iv
verb2(smile,smile).      %% :-)

verb2(snakke,talk). %% intrans
    verb2(skryte,talk).     %%  .. av

verb2(snakke,speak).
    verb2(br�ke, speak).    %% rough (people) 
    verb2(chatte, speak). 
    verb2(mase, speak).  %% :-)
    verb2(prate,speak). 
    verb2(skravle,speak). 
    verb2(snake,speak). 
    verb2(snakkke,speak). %%  own 
    verb2(tale, speak). 

%% verb2(s 

verb2(snike,sneak). 
verb2(snu,turn). 
verb2(sn�,snow). 
verb2(spore,find).
verb2(sove,sleep).
verb2(spasere,walk). %% not go 
    verb2(rusle,walk).
    verb2(spankulere,walk). %% :-)
    verb2(tusle,walk).
    verb2(vandre,walk). 
verb2(spille,play). 
verb2(spise,eat). 
    verb2(ete,eat).  
verb2(sp�rre,ask). 
    verb2(anmode,ask).  
    verb2(be,ask).
    verb2(formulere,ask).
    verb2(sp�re,ask).  

verb2(stanse,stop).
verb2(starte,start). 
    verb2(aktivere,start). 
    verb2(etablere,start). 
    verb2(grunnlegge,start). 
    verb2(igangsette,start). 
    verb2(innf�re,start).
    verb2(innlede,start). %% TA-110329
    verb2(lansere,start). 
    verb2(opprette,start). 
    verb2(restarte,start). %%  rough
    verb2(stifte,start).
    verb2(utl�se,start). %% .. garantien 

verb2(stavefeilskorrigere,correct).  
    verb2(stavefeilkorrigere,correct). 
verb2(stemme,agree).        %%   ( not perfect English though )
verb2(stenge,close). 
verb2(stige,increase). 


%% verb2(stille,ask).       %%  ... et sp�rsm�l
%% verb2(stille,adjust).   % 1 %  klokka // stille sp�rsm�l NORW/
%% verb2(stille,make).         % 2 % ask rv verb, confuse

verb2(stille,set).     %% technical compromise 


verb2(stole,trust).       %%  :-)

verb2(stoppe,stop).  %% ,end ?

    verb2(slutte,stop).  
    verb2(stoope,stoppe). 
    verb2(stope,stop).  
    verb2(terminere,stop). 

    verb2(knekke,stop).
    verb2(�delegge,stop).

verb2(streike,strike). 
verb2(studere,study).  
verb2(styre,drive). 
verb2(st�,stand).   

verb2(svare,answer1).    %%  Bare Intransitivt
% verb2(svare,tell).     %% not answer %%  WHY NOT ?

verb2(sv�mme,swim).
verb2(synes,mean).       %% (think)
   verb2(syntes,mean).   %%
   verb2(tykkje,mean).   %%

%% verb2(synes,believe). %%

verb2(s�ke,search).       %% intransitive 

%% verb2(s�ke,want).  %%  transitive %% TA-110331  // s�ke p� andre steder en i trondheim? -->


verb2(s�rge,care1). %% s�rge for = take care of 
                    %% make sure
%% verb2(t 


verb2(ta,take).
%%    verb2(bringe,take).      %% mat * jeg har brakt penger .
%%    verb2(medbringe,take).   %% TA-101125
   verb2(kapre,take).       %% .. drosje 

verb2(takke,thank). 
    verb2(takkke,thank).  
verb2(overta,take). 
% verb2(ta,bring).        %% (Fail bring < take)
    verb2(forf�lge,take).  %% Slang 
verb2(telle,count). 
    verb2(tallfeste,count). %% m�le? 

verb2(tenke,think). 
    verb2(filosofere,think).
    verb2(p�nske,think). 
    verb2(resonere,think). 
    verb2(resonnere,think). 
    verb2(ressonere,think).  %% spc
    verb2(stusse,think).     %%  rough
    verb2(tenkje,think).     %% NN
    verb2(tygge,think).      %% slang 
    verb2(t�nke,think).      %% (Dan)

verb2(teste,test).  
    verb2(testkj�re,test). 

verb2(tie,silence). %% e.g. keep s

verb2(tulle,babble).  %%  :-)
    verb2(bable, babble). %% :-) 
    verb2(babble, babble). 
    verb2(t�yse,babble). 

verb2(tilby,sell). %%  offer %% rough
verb2(tilgi,forgive). 

verb2(tilh�re,belong_to). 
    verb2(sogne,belong).  %% TA-110707

verb2(tillate,allow).   
verb2(tillegge,add).   
verb2(tilpasse,adapt).  
    verb2(innpasse,adapt).  
    verb2(tilrettelegge,adapt). 

verb2(tjene,earn). 
verb2(trafikkere,pass).
%% jeg trenger billett

%% verb2(tre,start). %% tre i kraft %% TA-101207 tr=start

verb2(trenge,need).   
    verb2(beh�ve,need).    %% .. � 
verb2(trenge,want).        %%   (I need a bus)
   %%  verb2(beh�ve,want). 
verb2(trives,thrive).  
verb2(tro,believe).
   verb2(tru,believe).  

verb2(tolke,interpret). 
    verb2(fortolke,interpret). 

verb2(trykke,write).   %% fapp %% TA-110303
%%     verb2(trykke,push). %% knapp 

verb2(tvile,doubt).  
verb2(tvinge,force). 

verb2(tyde,indicate). %% .. p� Norw 
    verb2(indikere,indicate).  

verb2(t�mme,empty). 

verb2(unders�ke,check).    %%  rough
   verb2(analysere,check).
   verb2(lodde,check). 
   verb2(sjekke,check).  

verb2(undervise,teach). 
verb2(unng�,avoid). 

verb2(utelate,exclude).

verb2(utsette,postpone). 

verb2(vare,last). 

verb2(varsle,notify).
   verb2(advare,notify).     %%
   verb2(advarere,notify).   %% own
   verb2(alarmere,notify). 
   verb2(anrope,notify).  
   verb2(p�kalle,notify). 
   verb2(p�minne,notify). 
   verb2(varlse,notify).
   verb2(vekke,notify). 

verb2(vekke,awaken).
    verb2(pirre,awaken).   %% ?  


verb2(vaske,clean). 
   verb2(renvaske,clean).

verb2(vedlegge,enclose).

verb2(vedlikeholde,maintain). 

verb2(vegre,resist). %%  .. seg  decline,refuse,oppose
    verb2(kvie,resist). 

% verb2(veie,weigh).      %%  Tors vei causes Trouble

% verb2(vekke,wake).      %% notify FAPP

verb2(veksle,change).

verb2(velge,choose).   
%% verb2(velge,take).        %%  (Roughly) 

%% verb2(vente,take).        %%  (expect) 
verb2(vente,wait).
    verb2(v�nte,wait).  
%% verb2(vil,go).          %%  ( gives inf )

%% verb2(ville,go).          %%  � ville    % vil reise til  = g�r reisen til
%%     verb2(m�tte,go).   %% Jeg m� til nth// hvilken buss m� (g�r) jeg ta
                                 %% m� = pres 

verb2(verifisere,verify).

verb2(vinke,wave).    %% for signals. 

%% verb2(virke,work).

%% verb2(virke,be).  %%   du virker dum  Confuse  
                  %%  (da) virker det p�fallende at

verb2(vise,show).
    verb2(anvise,show). 
    verb2(avdekke,show).  %% TA-101102
    verb2(bevise,show).   %% prove?
    verb2(forevise,show). 

verb2(vite,know).           %%    Jeg vet at
    verb2(ane,know). 
    verb2(avgj�re,know).    %% bestemme?
    verb2(garantere,know).  %% Rough 

%    verb2(vete,know).       %% Dialect (Swe) %% ==> vet = vit!
% verb2(vite,know1).    %%    Jeg vet en ting

%%%%%%%%%%%%%%%% verb2(kunne,know1).  

verb2(vurdere,consider). %% ? 

verb2(v�re,be).
   verb2(vere,be).   %% Not Synword   Vera -> V�re
%%    verb2(trene,be).  %% Rough.. trene p� dragvoll 
   verb2('va|re',be). 
   verb2('va|rre',be). 


verb2(�ke,increase). 
    verb2(auke,increase). %% NN

verb2(�nske,want).  
  verb2(foretrekke,want). 
  verb2(forlange,want).  
  verb2(gidde,want).       %% rough
  verb2(gide,want).  
  verb2(orke,want).        %%  rough
  verb2(oenske,want).      %% ønsker
  verb2(onske,want).  
%%     verb2(planlegge,want).   %% rough ? plan 
  verb2(ynskje,want).      %%  NN
  verb2(ynsje,want). 
  verb2(�nke,want).        %% sp 
  verb2(�nskje,want).      %%  dial
  verb2(�nsje,want).  

verb2(�nske,wish).          % ? Reporting verb

%% verb2(�ke,take).            %%   (Swedicism)
verb2(�ke,go).  

verb2(�pne,open). 
    verb2(opne,open).
    verb2(oppne,open). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% verb_form  %% sortert p� hovedform (?)

verb_form(ankjem,ankomme,pres,fin). %% NN
verb_form(ankom,ankomme,past,fin).

verb_form(antok,  anta,past,fin). 
verb_form(antatt, anta,past,part).
verb_form(avgj�r,   avgj�re,pres,fin). %% ikke avgj�rer 

verb_form(ba,be,past,fin).  
verb_form(bedt,be,past,part). 

verb_form(bega,begi,past,fin).  
verb_form(begitt,begi,past,part).  %%

verb_form(begynte,begynne,past,fin). 
verb_form(begynt, begynne,past,part).

verb_form(beskrev,beskrive,past,fin). 
verb_form(beskrevet,beskrive,past,part).

verb_form(bestemte,  bestemme,past,fin). 
verb_form(bestemt,bestemme,past,part).

    verb_form(ombestemte, bestemme,past,fin). 
    verb_form(ombestemt,  bestemme,past,part).

verb_form(bestilt,bestille,past,part). %% reg is bestillt 
verb_form(besto,  best�,past,fin).  
verb_form(best�tt,best�,past,part).   
verb_form(blitt,  v�re,past,part). 
verb_form(bodd,   bo,past,part). 
verb_form(bodde,  bo,past,fin). 

verb_form(brakte,bringe,past,fin). %% TA-100915
verb_form(brakt,bringe,past,part). %%

verb_form(busset, reise,past,fin). %% avoid busse = verb 

verb_form(dro,    dra,past,fin). 
verb_form(dradd,  dra,past,part). 
verb_form(dratt,  dra,past,part). %% TA-110315

verb_form(drakk,drikke,past,fin).   
verb_form(drukket,drikke,past,part). %%
   verb_form(drekki,drikke,past,part). %% :-)

verb_form(d�de,   d�,past,fin). 
verb_form(d�dd,   d�,past,part).

%% verb_form(eide,   eie,past,fin). 
verb_form(er,     v�re,pres,fin).       

verb_form(ettersp�r,    ettersp�rre,pres,fin).  
verb_form(etterspurte,  ettersp�rre,past,fin).   
verb_form(etterspurt,   ettersp�rre,past,part).  


verb_form(fant,   finne,past,fin). 
verb_form(fantes, finne,past,pass).

verb_form(fikk,   f�,past,fin).

%% verb_form(for,fare,past,fin).    %% Too Hazardous
%% verb_form(fart,fare,past,part). 

verb_form(foregikk,foreg�,past,fin).  
verb_form(foreg�tt,foreg�,past,part). 

verb_form(forekom,forekomme,past,fin). 
verb_form(forekommet,forekomme,past,part).

verb_form(foreslo,foresl�,past,fin).  
verb_form(foresl�tt, foresl�,past,part). 

verb_form(foretok,  foreta,past,fin).  
verb_form(foretatt, foreta,past,part).  

verb_form(foretrakk, foretrekke,past,fin). 
verb_form(foretrukket, foretrekke,past,part). 

verb_form(forlatt,forlate,past,part).
verb_form(forlot, forlate,past,fin). 
verb_form(forsto, forst�,past,fin).
verb_form(forst�tt,  forst�,past,part). 
verb_form(forsvant, forsvinne,past,fin). 
verb_form(forsvunnet, forsvinne,past,part).

verb_form(fortalt,fortelle,past,part). 
verb_form(fortalte,  fortelle,past,fin). 

% verb_form(funker, v�re,pres,fin). 

verb_form(friga,frigi,past,fin).     %% TA-110330
verb_form(frigitt,frigi,past,part).  %%
verb_form(frigjorde,frigi,past,fin). %%
verb_form(frigjort,frigi,past,part).  %%

verb_form(funnet, finne,past,part). 
verb_form(fylt,   fylle,past,part). %% fyllt? 

%% verb_form(f�r,    kj�re,imp,fin).   %%  f�r meg!
verb_form(f�tt,   f�,past,part).

verb_form(ga,     gi,past,fin). 
verb_form(gav,    gi,past,fin). 
verb_form(gikk,   g�,past,fin).
verb_form(gitt,   gi,past,part). 
verb_form(gjemt,  gjemme,past,part). 
verb_form(gjeng,  g�,pres,fin). 

verb_form(gjaldt,gjelde,past,fin). 
verb_form(gjeldt,gjelde,past,part). 

verb_form(gjenge, g�,pres,fin). % NN
verb_form(gjenga, gjengi,past,fin).  
verb_form(gjengav, gjengi,past,fin).  
verb_form(gjengitt, gjengi,past,part). 
verb_form(gjenkjent,  gjenkjenne,past,part). %% Rule here 
verb_form(gjenkjente, gjenkjenne,past,fin). 

verb_form(gjekk,  g�,past,fin). 
verb_form(gjorde, gj�re,past,fin). 
verb_form(gjort,  gj�re,past,part). 
verb_form(gj�r,   gj�re,pres,fin). %% ikke gj�rer
verb_form(glemt,  glemme,past,part).
verb_form(gjenglemt, glemme,past,part). 
verb_form(glemte, glemme,past,fin).
verb_form(gravde, grave,past,fin).
verb_form(grunnla,grunnlegge,past,fin). %% ?
verb_form(grunnlagt,grunnlegge,past,part).

verb_form(g�tt,   g�,past,part). 

verb_form(har,    ha,pres,fin).
verb_form(hadde,  ha,past,fin).
verb_form(hatt,   ha,past,part). 
% verb_form(hatt,   ha,pres,fin).  %%  skulle hatt ?

verb_form(het,    hete,past,fin). 
% verb_form(hett,    hete,past,part). // varmt

verb_form(kalles,hete,pres,fin). %% avoid passive
verb_form(kaltes,hete,past,fin). 

verb_form(hjalp,  hjelpe,past,fin).
verb_form(hjulpet,hjelpe,past,part).

verb_form(h�res,h�res,pres,fin). 
verb_form(h�rtes,h�res,past,fin).

verb_form(iakttok,se,past,fin). 
verb_form(iakttatt,se,past,fin).

verb_form(igangsatte,igangsette,past,fin).
verb_form(igangsatt,igangsette,past,part).

%% verb_form(ila,ilegge,past,fin). %% \Ila 
verb_form(ilagt,ilegge,past,part).  

verb_form(inneheld,inneholde,pres,fin). 
verb_form(innlagt,innlegge,past,part). 
verb_form(innlagt,innlegge,past,part). 
verb_form(inns�,innse,past,fin).   

verb_form(j�r,gj�re,pres,fin). %% TA-110114 nec 

verb_form(kalte,  kalle,past,fin). 

verb_form(kallet, kalle,past,part). %% ? 
verb_form(kalt,   kalle,past,part). %% ?

verb_form(kaltes, kalle,past,pass).

verb_form(kan,    kunne,pres,fin). 
verb_form(kunne,  kunne,past,fin). 
verb_form(kunnet, kunne,past,part). 

verb_form(kunngjorde,  kunngj�re,past,fin). 
verb_form(kunngjort,   kunngj�re,past,part).

%% verb_form(kan,    kjenne,pres,fin). 
%% verb_form(kunne,  kjenne,past,fin). 
%% verb_form(kunnet, kjenne,past,part).

verb_form(kjent,  kjenne,past,part).
verb_form(kjente, kjenne,past,fin). 

verb_form(kj�rt,  kj�re,past,part).
verb_form(kj�rte, kj�re,past,fin).
% verb_form(kjent,  vite,past,part).   %% -> know1 ??? 
% verb_form(kjent,  kjenne,past,part).

verb_form(kom,    komme,past,fin).     
verb_form(kom,    komme,imp,fin).
verb_form(komme,    komme,inf,fin). %% i.e. inf !! NEW
verb_form(kommet,    komme,past,part). %% IKKE past fin 

verb_form(la,     legge,past,fin).
verb_form(lagd,   lage,past,part). 
verb_form(laga,   lage,past,part). 
verb_form(lagde,  lage,past,fin). 
verb_form(lagt,   legge,past,part).
verb_form(lar,    la,pres,fin).
verb_form(latt,   la,past,part).
verb_form(levde,  leve,past,fin). 
verb_form(levd,   leve,past,part).
verb_form(ligg,   ligge,pres,fin). %% TA-110825
verb_form(lot,    la,past,fin). 

verb_form(l�p,    l�pe,past,fin). 
verb_form(l�pt,   l�pe,past,part).

verb_form(l�y,    lyve,past,fin).
verb_form(l�yet,  lyve,past,part).
verb_form(l�,     ligge,past,fin).

verb_form(misforsto,misforst�,past,fin). 
verb_form(mista,miste,past,fin). %% Missing Morf 
verb_form(mista,miste,past,part).
verb_form(motatt,  motta,past,part). %%  spc
verb_form(mottatt, motta,past,part).
verb_form(mottok,  motta,past,fin). 
verb_form(m�,   m�tte,pres,fin).

% verb_form(oppgi,vise,imp,fin). % fortelle !
% verb_form(oppgir,  vise,pres,fin).
verb_form(opplevde, oppleve,past,fin). 
verb_form(opplevd, oppleve,past,part).
verb_form(oppga,fortelle,past,fin). 
verb_form(oppgav,  fortelle,past,fin). 
verb_form(oppgitt, fortelle,past,part). %% | sad
verb_form(oppsatt, arrangere,past,part). 

verb_form(oppsto, oppst�,past,fin). 
verb_form(oppst�tt, oppst�,past,part). 

verb_form(oversatte, oversette,past,fin).  
verb_form(oversatt,  oversette,past,part). 

verb_form(planla,planlegge,past,fin).  
verb_form(planlagt,planlegge,past,part). 
verb_form(pr�vde,pr�ve,past,fin). 
verb_form(pr�vd, pr�ve,past,part).

verb_form(p�sto, p�st�,past,fin). 
verb_form(p�stod, p�st�,past,fin).    %%
verb_form(p�st�tt, p�st�,past,part). %%


verb_form(rakk,    rekke,past,fin).  
verb_form(resatte, resette,past,fin). 
verb_form(resatt,  resette,past,part).


verb_form(rukket,  rekke,past,part). 

verb_form(r�yka, r�yke,past,fin).  %% not plu sigaretter
verb_form(r�yka, r�yke,past,part). 

verb_form(sa,    si,past,fin).  
verb_form(sagt,  si,past,part).
verb_form(satt,  sette,past,part). 
verb_form(satt,  sitte,past,part). 
verb_form(satte, sette,past,fin). 
verb_form(se,    se,imp,fin).     %% Trykksterk e (kle,bre,gre,le,re,te)
verb_form(sees,  se,pres,pass).  
verb_form(solgte,selge,past,fin).
verb_form(solgt, selge,past,part). 
verb_form(sett,  se,past,part).     
verb_form(sier,  si,pres,fin).
verb_form(sies,  si,pres,pass). 
verb_form(saes,  si,past,pass). %% ?

verb_form(skjedd,skje,past,part). 
verb_form(skjedde, skje,past,fin). 
verb_form(skj�nte, skj�nne,past,fin). 
verb_form(skj�nt, skj�nne,past,part). 
verb_form(skrev, skrive,past,fin). 
verb_form(skrevet,skrive,past,part). 

verb_form(skyldtes,skyldes,past,fin). %% Technical
verb_form(skyldes,skyldes,pres,fin). 

verb_form(slapp,slippe,past,fin).    %% TA-110401
verb_form(sluppet,slippe,past,part). %%

verb_form(sn�dde,sn�,past,fin).  
verb_form(sn�dd,sn�,past,part).
verb_form(sov,sove,past,fin). 

verb_form(spilte, spille,past,fin).  
verb_form(spilt, spille,past,part).
verb_form(sprang, springe,past,fin).  
verb_form(sprunget, springe,past,part). 

verb_form(spurde, sp�rre,past,fin).  %%  Irrelevant 
verb_form(spurd,  sp�rre,past,part). %%  Hva spurte jeg om \= hva kan jeg sp�rre om
verb_form(spurte, sp�rre,past,fin).  %%  Irrelevant,
verb_form(spurt,  sp�rre,past,part). %%  Hva spurte jeg om \= hva kan jeg sp�rre om
verb_form(spurt,  sp�rre,past,fin).  %% � spurt om no %% Dial

verb_form(sp�r,  sp�rre,pres,fin). 
%%% verb_form(sp�r,  sp�rre,imp,fin).  %% Irrelevant
verb_form(sp�rr,  sp�rre,pres,fin).    %% slight problem 
verb_form(sp�rr,  sp�rre,imp,fin).  

verb_form(steg,  �ke,past,fin).  %%  Ad Hoc , not syn go
%% verb_form(steg,  go,past,fin). %% TA-110118
verb_form(steget,�ke,past,part).
%% verb_form(steget,  go,past,part). %% TA-110118

verb_form(stilt, stille,past,part). 
verb_form(stilte,stille,past,fin). 
verb_form(sto,   st�,past,fin). 
verb_form(st�tt, st�,past,part).
verb_form(svar,  svare,inf,fin). %%  dial  like � svar
verb_form(svar,  svare,imp,fin). 

verb_form(syns,  mene,pres,fin). 
verb_form(synes, mene,pres,fin).
verb_form(synest, mene,pres,fin). %% NYN
verb_form(synst, mene,pres,fin). %%

verb_form(s�,    se,past,fin). %% nb also unwanted 

verb_form(taka,  ta,inf,fin).
verb_form(take,  ta,inf,fin).
verb_form(tar,   ta,pres,fin).
verb_form(tatt,  ta,past,part). 

verb_form(ties,  tie,pres,pass).   
verb_form(tilla,tillegge,past,fin). 
verb_form(tillagt,tillegge,past,part).
verb_form(tilrettela,tilrettelegge,past,fin).  
verb_form(tilrettelagt,tilrettelegge,past,part).

verb_form(tistille,tie,imp,fin). %% avoid ti 
verb_form(tok,   ta,past,fin). 
verb_form(trodd, tro,past,part).
verb_form(trodde,tro,past,fin).  
verb_form(trudd, tro,past,part). 
verb_form(trudde,tro,past,fin).  
verb_form(tvang,tvinge,past,fin).   
verb_form(tvunget,tvinge,past,part).

verb_form(valgte, velge,past,fin). 
verb_form(valgt,  velge,past,part). %% 
verb_form(var, v�re,past,fin).   %% past 
%%   verb_form(var, v�re,inf,fin).    %% Dial // not synword(var,v�re)
verb_form(varsle, varsle,imp,fin).  %% rule?
verb_form(vart,v�re,past,fin).   %% NN 
verb_form(vedla,  vedlegge,past,fin).
verb_form(vedlagt,vedlegge,past,part). 

verb_form(veier,  veie,pres,fin).   %% Don't allow vei !
verb_form(veit,vite,pres,fin). 
verb_form(vere,ankomme,inf,fin). %% NN (Techn: future be)
verb_form(vet, vite,pres,fin).
verb_form(vil, ville,pres,fin).
verb_form(ville,  ville,past,fin).  %% 
verb_form(visste, vite,past,fin). 
%% verb_form(visst,  vite,past,part). %% hvis ??

%% verb_form(vore,v�re,inf,fin).  %% ?
verb_form(vore,v�re,past,part). 
%% verb_form(v�re,ankomme,inf,fin). %% (Techn: future be) %% Try without
verb_form(vori,v�re,past,part).  %% Dial
verb_form(virri,v�re,past,part).
verb_form(v�rt,v�re,past,part).  

verb_form(v�rte,v�re,past,part). %%  (? actual)

verb_form(v��re,v�re,inf,fin). %%  avoid V�re

verb_form(�pne,  �pne,imp,fin). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rep_verb(Tell):-  
    user:rv_templ(Tell,_). %% Semantic  


preposition(X):-preposition2(X,_).  

% preposition2(akkurat,at). 

preposition2(ang�ende,regarding). 
preposition2(attmed,beside). 
preposition2(attom,past).  

%% preposition2(av,by).                %%  f�dt av en kvinne
%% passive is handled as [av] !! %% (conjunction?)
%% causes confusion... restene av livet


preposition2(av,of).                %%   (sentrum av byen)
preposition2(av,off).               %% g� av bussen

preposition2(bak,behind).
preposition2(bakp�,on).   %% upon/behind). %% Rough  bakp� bussen \= bak bussen
preposition2(baki,in).

preposition2(blant,among).  
preposition2(bortenfor,beyond).
preposition2(ca,around).
preposition2(circa,around). 
preposition2(cirka,around). 
preposition2(etter,after).      %% time !
preposition2(efter,after1).  %% after1 strictly after (not implemented) 

%% preposition2(etter,beyond).     %% place ! 
%% preposition2(etter,past).       %% bus after ranheimsvegen  (Dubious)
                    
preposition2(forbi,past).           %% ("by" is ambiguous!) 

preposition2(for,for).     %% prisen for en billett Norw %% TA-110105
% preposition2(for,of).             %% Hazardous

preposition2(for�,in_order_to).     %%  Technical
preposition2(foran,at). %% afore).         %%  ? == in front of  

%% preposition2(fordi,because_of). %%  // fordi= forbi �svang skole
%% preposition2(fordi,being_the).  %% 

preposition2(f,from). %% NOT f  -> fra -> etter !!! (Ad Hoc)

%%% preposition2(fra,after).  %% e.g. time  Hazardous %% sp�rsm�l fra brukere

preposition2(fra,from).

preposition2(fremfor,instead_of). %% also subjunction

preposition2(f�r,before). 

%% preposition2(gjennom,through). %% unwanted in Bus domain 
   
preposition2(gjennom,past).   

%% preposition2(ganger,times).    %% :-) bussen g�r (3) ganger
preposition2(henimot,towards).  
preposition2(hinsides,beyond).  %% jargon ???

%% preposition2(hver,every).   %% bussen g�r hvert minutt // pron,determ ??? emergency
%% preposition2(hvere,hver). 
%% preposition2(hvert,every).       %% hver time  // emergency

preposition2(i,in).
preposition2(if�lge,according_to).

%%     preposition2(etter,according_to). %% Experiment bussen g�r etter    det jeg forst�r
   %% Haz, fom -> etter ->  according_to  

% preposition2(innen,before).      %% before clock / within an hour ???
preposition2(innen,within).        %%  within duration
preposition2(innenfor,inside).

preposition2(inni,into).  %% 1   
%% preposition2(inni,in).    %% 2     %%  e.g. inne i %% confuse

preposition2(innom,past). 
preposition2(inntil,to). 
preposition2(inntil,until).  

preposition2(istedenfor,instead_of). 

preposition2(kring,about).  

preposition2(langs,along). 
preposition2(langs,past). 
preposition2(langs,at). 

preposition2(lik,like).    

% preposition2(med,by).         %% komme med tog   Necessary ?
% preposition2(med,of).      %% hva er tiden med buss ?? (Must be exemplified !)
preposition2(med,with).
preposition2(mellom,between).
preposition2(mens,during).
%%%  preposition2(minus,minus).    %% :-) %% TA-100825 :-(
%%% preposition2(mot,against). %% not relevant 
preposition2(mot,towards). 
% preposition2(nedenfor,below). 
preposition2(nedenfor,past). %% Rough
preposition2(nedenom,past).  
preposition2(n�yaktig,at).
preposition2(n�r,near).
preposition2(n�re,near). %% sted 
   preposition2(n�r,around).  %%% tid
   preposition2(n�re,around).
preposition2(n�rere,nearer).
preposition2(n�rmere,near). 

%% N�RMEST
   
preposition2(n�rest,near). 

preposition2(n�rmest,near).      %%
preposition2(n�rmest,around).   
%% preposition2(n�rmeste,nearest).  %%  problematic ( adjective)%% ** 

preposition2(n�rtid,when). %% \+ reach 

%% OM (ogs� = HVIS)


preposition2(om,past).   %% TA-110429 #1

preposition2(om,during2).     %% Ambiguous    om kvelden = during/ om 1 time = after

preposition2(om,regarding).   %%  informasjon om ( about is ambiguous)

preposition2(om,om).          %% Fictive preposition %% TA-110429


% preposition2(om,during).        %  om sommeren,kvelden ...
% preposition2(om,withafter).     %  dra  om en time  = etter en time
% preposition2(om,about).         %  om bussavganger
% preposition2(om,after).         %  om en time  = etter en time 
% preposition2(om,in).            %  om kvelden  (covered by 'by night')
% preposition2(om,within).        %  v�re om en time  = f�r en time 

%%%%%%%%%

preposition2(omkring,about).   
preposition2(omkring,around).    
preposition2(omlag,around).
preposition2(omtrent,around).
%% preposition2(opp,past).         %% (opp By�sveien) // opp igjen 
preposition2(opp�,upon).
preposition2(oppover,past). 

%%%%  preposition2(over,above).  %% informasjon over ...

preposition2(over,over).        %% over will be prioritised 
preposition2(over,past).        %%  (=forbi) buss over nth


%%%% preposition2(over,after).   %% litt over kl 4 
                                 %% oversikt over avganger 

%  preposition2(pluss,plus).       %% :-)

preposition2(per,per).         %%  Per Bogesen (Tele) ?
    preposition2(pr,per).      %%
preposition2(pga,because_of).  %% (Norwagism) 
preposition2(presis,at).    %% er bussen min presis *** 
preposition2(p�,on).

 % preposition2(p�,of).          %% ( Norwagism  lengden p� en buss ) % Haz ??
 % g�r bussen p� onsdag = onsdagens buss * 

preposition2(rundt,around). 
preposition2(rundtklokka,around). 
preposition2(rundt,past).      %%   Rundt Trygvason


%% preposition2(siden,after).  %%  not past/  confuse subjunction ? %% 110119
                            %% disamb. im gram 

preposition2(som,as).          %% NB Doubly defined (no problem) 
preposition2(som,like). 

preposition2(senest,before).  %%  avoid syn senest -> f�r -> [f�r] (adverb)

preposition2(tidligst,after).    %% avoid tidligst-> etter -> beyond
preposition2(til,to).           
preposition2(til,of) :-  user:myflags(teleflag,true).

%% preposition2(till,to).         %% Swedicism  

preposition2(to,to). %% torget to dragvol //meant as English ? %% TA-110614

preposition2(tversover,across).  
%% preposition2(uansett,notwithstanding).  %% suspended test

preposition2(ulik,except). %%  ? 
preposition2(under,below).
preposition2(under,during). 
preposition2(under,under).  %% adv p� engelsk ? 
preposition2(unntatt,except).

preposition2(uten,without).
    preposition2(utan,without).  %%  NN

%% preposition2(utenfor,at). %%utenfor nidarosdomen| utenfor trondheim 

preposition2(utenfor,outside). 
   preposition2(utanfor,outside). 
 % preposition2(utenfor,past). 
preposition2(utenom,except). 
preposition2(utenom,outside).   %%   (not quite)

preposition2(utfra,out_of).     %% Internal 
%% preposition2(utover,in).        %% Time / Place 

preposition2(ved,at).
    preposition2(hos,at).  
% preposition2(ved,by).         %% ambiguous and superfluous 
% preposition2(ved,near).  %% unnecessary %% stopper bussen fra A ved B ?
preposition2(vha,with).    %%  ( Norw Acronym) 
preposition2(via,past). 
preposition2(via,via).     %% n� nth via #1
    

%% Preposition to denote directions off place 
    preposition2(s�nnenfor,offside). %% Rough 
    preposition2(s�nnenom,offside).  %% ETC ETC  
    preposition2(sydfor,offside).    %% 
    preposition2(sydf�r,offside).    %% 
%     preposition2(sydfra,offside).    %% particle

    % nord �st vest

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  noun_form(Form,Root,Sin,Def,Gen). 

noun_form(ansatte,ansatt,plu,u,n).  
noun_form(barn,barn,plu,u,n).    
noun_form(bussnumre,bussnummer,plu,u,n). 
noun_form(b�kene,bok,plu,def,n). %% MTR-020919
noun_form(b�ker,bok,plu,u,n).
noun_form(foreldre,foreldre,plu,u,n).
noun_form(foresp�rselen,sp�rsm�l,sin,def,n).
noun_form(foresp�rsler,sp�rsm�l,plu,u,n). 
noun_form(foresp�rslene,sp�rsm�l,plu,def,n). %
noun_form(hender,h�nd,plu,u,n). 
noun_form(hus,hus,plu,u,n).       %% Neutrum Nec ?
noun_form(kl�rne,kl�r,plu,def,n). %% kl�r root 
noun_form(menn,mann,plu,u,n).         
noun_form(mennene,mann,plu,def,n).
noun_form(nettene,natt,plu,def,n). 
noun_form(netter,natt,plu,u,n).
noun_form(numre,nummer,plu,u,n). 
noun_form(politikerne,politiker,plu,def,n). 
noun_form(regler,regel,plu,u,n). 
noun_form(sedler,seddel,plu,u,n). 
noun_form(syklen,sykkel,sin,def,n).
noun_form(tidsrommet,tidsrom,sin,def,n).
noun_form(tidsrom,tidsrom,plu,u,n).   
noun_form(ting,ting,plu,u,n).     %% Gjelder ogs� alle Intetkj�nn!!!!!
noun_form(voksne,voksen,plu,u,n).
noun_form(v�rnepliktige,vernepliktig,plu,u,n).
noun_form(�r,�r,plu,u,n). % nec?


% Numerids


numerid(M,N,num):-
    numerid(M,N).


ordinal2(f�rste,first,1).    ordinal2(f�rst,first,1).
ordinal2(andre,second,2).  %  ordinal2(nest,second,2). (nest siste ?)
%%%     ordinal2(annet,second,2). %% annen en \+ 2. 
%%%     ordinal2(annen,second,2). 

ordinal2(tredje,third,3). 
ordinal2(fjerde,fourth,4).
ordinal2(femte,fifth,5).
ordinal2(sjette,sixth,6).
ordinal2(sjuede,seventh,7).
ordinal2(sjuende,seventh,7). ordinal2(syvende,seventh,7). 
ordinal2(�ttende,eighth,8). 
ordinal2(niende,ninth,9).
ordinal2(tiende,tenth,10).
ordinal2(ellevte,eleventh,11).  
ordinal2(tolvte,twelvth,12). 
ordinal2(trettende,thirteenth,13).
   ordinal2(trettonde,thirteenth,13). 
ordinal2(fjortende,fourteenth,14). 
   ordinal2(fjortonde,thirteenth,13).
ordinal2(femtende,fifteenth,15). 
   ordinal2(femtonde,fifteenth,15). 
ordinal2(sekstende,sixteenth,16).
   ordinal2(sekstonde,seventeenth,17).
ordinal2(syttende,seventeenth,17).
   ordinal2(s�ttende,seventeenth,17).
   ordinal2(sjuttonde,seventeenth,17).
ordinal2(attende,eighteenth,18).
    ordinal2(attonde,eighteenth,18).
ordinal2(nittende,nineteenth,19). 
    ordinal2(nittonde,nineteenth,19).
ordinal2(tyvende,twentieth,20). 
ordinal2(tjuende,twentieth,20). 
ordinal2(tjuef�rste,twentyfirst,21). 
ordinal2(tjueandre,twentysecond,22). 
ordinal2(tjuetredje,twentythird,23). 
ordinal2(tjuefjerde,twentyfourth,24). 
ordinal2(tjuefemte,twentyfifth,25). 
ordinal2(tjuesjette,twentysixth,26). 
ordinal2(tjuesjuende,twentyseventh,27). 
ordinal2(tjue�ttende,twentyeighth,28). 
ordinal2(tjueniende,twentyninth,29). 

ordinal2(trettiende,thirtieth,30). 
ordinal2(tredevte,thirtieth,30). 
ordinal2(treddevte,thirtieth,30).  
ordinal2(tredjevte,thirtieth,30).  
ordinal2(trettif�rste,thirtyfirst,31). %% MTR-020918

% covers the dates


%% numerid extended to take lexical numbers  

% numerid(ingen,0).   %% ingen 5 buss 

numerid(null,0).
% numerid(en,1). numerid(et,1). %% hazard ? 
% numerid(ett,1). %% Special treatment

numerid(halvannen,1.5). 

numerid(to,2).
numerid(tre,3).
numerid(fire,4).
numerid(fem,5).
numerid(seks,6).
numerid(sju,7). numerid(syv,7).
numerid(�tte,8).
numerid(ni,9).
numerid(ti,10).
numerid(elve,11).
numerid(eleve,11).
numerid(elleve,11).
numerid(elleva,11). 
numerid(ellva,11).
numerid(ellve,11). 
% numerid(elva,11).

numerid(tolv,12).
numerid(tretten,13).    
numerid(fjorten,14).    
numerid(femten,15).     
numerid(seksten,16).    
numerid(sytten,17).     
numerid(atten,18).      
numerid(nitten,19).     
numerid(tjue,20).    numerid(tyve,20).      
numerid(tretti,30).  numerid(tredve,30). 
numerid(f�rti,40).      
numerid(femti,50).      
numerid(seksti,60).     
numerid(s�tti,70).   numerid(sytti,70).   
numerid(�tti,80).  
numerid(nitti,90). 
numerid(hundre,100).
numerid(tusen,1000).

numerid(million,1000000). 
numerid(millioner,1000000). 

% numerid(middag,1200). % 
% numerid(lunsj,1200).  % har du hatt lunsj



%% the patient died when she lived

pronoun(X):-pronoun(X,_). 

pronoun(dere,agent). %% ? Haz
pronoun(de,agent).  

pronoun(han,man). 
pronoun(hanselv,man).   %% Techn 
pronoun(hun,woman). 
pronoun(hunselv,woman). %% Techn 
pronoun(ham,man).
pronoun(hanselv,man).

pronoun(henne,woman). 

pronoun(seg,agent). 
pronoun(segselv,agent).  %% (thing?)

pronoun(dem,thing).  
pronoun(de,thing).  

pronoun(jeg,self).  
pronoun(meg,self).
 
pronoun(vi,self). %% selves ?
pronoun(oss,self). 

pronoun(du,savant).   
pronoun(deg,savant).  %%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A good many noise words are rather dummy adverbs
%    see also  reduntant particle (gram_n.pl)

% Noisewords are also calles stopwords

% If a word can be removed in all places without change om meaning
% However, if word is needed in compword etc, define this word also by
% compword []. Example  compword(vel,[],[]).


noisew(BS):-user:backslash(BS).   

noisew('&'). %% TA-110225

noisew(quote('n .')). %% by\'n. 
noisew(quote('')).

noisew('{'). %% ad hoc 
noisew('}'). %%

noisew('�'). 
noisew('�').

%%% noisew('�'). %% l��rdag .
noisew(' '). 
noisew('').

%%% noisew('/').   
noisew('='). 
noisew('^'). 

noisew('-'). %%  :- \+ user:myflags(teleflag,true). %% Too much trouble
            
                 %% bus   between 1200 - 1300 etc. fails
                 %% Dont remove this, causes more trouble than not

noisew('~').  
noisew('_'). 

%% n�r+g�r bussen ...

%% TA-100902
%% noisew('+').  %% hva er 2+2   %%  og ? %% Du m� oppgi et sted .....
              %% neste+til+ila+fra+voll  

noisew('*').     %% hva er 3*3  => 3:03 %%   6*4 -> 6 4-buses OK
noisew('�').     %% NB  � \=  " 
noisew('#').       %% (or nummer ?)

% noisew(':').       %%  17:04 is a clock, not a date
%                    %% destroys :)
%% noisew(';'). %% SENTENCE Delimiter

noisew(','):- \+ user:myflags(teleflag,true). 

noisew('(').
noisew(')'). 

%%  add to cited text to make it compreh. ?
%% noisew('['). %% buss g�r fra idrettsbygget til  by[sen butikksenter kl 2000
%% noisew(']'). %%                  = BY SENT 

noisew('<'). 
noisew('>'). 

noisew('�'). 
noisew('�'). 

noisew('|'). %% [124] 
noisew('�'). %% [166]

noisew('%').

%%% noisew('@'). special symbol AT floowed by neib locs

noisew('$'). 

% Some of these noisewords could be defined as redundant adverbs

/* 

noisew(a).  %% gate 12 a  
noisew(b).  %% sms=buss
noisew(c).
noisew(d).  %% sms = d

*/



noisew(absolutt). 
noisew(absolut).   %%  (spell/Swed)
noisew(ah).  
noisew(aha). 
noisew(akkurat). 
noisew(aldeles).  %% not allowed initially (\+ redundantly) 
noisew(aller). 
%%  noisew(allikevel).
noisew(alikevel).  %% (spiw)
% noisew(alltid).    %%   (problem?) hele tiden -> alltid

noisew(altfor). 

%% noisew(alts�). %% alts� �  %% (redundant) alts� ikke => unntatt  NB 
%% noisew(an).      %%  g�r an ==> redundant

%% noisew(ane).       %% (9'ane)
noisew(ansl�tt).  
noisew(antatt).  
%% noisew(beregnet).   Tidsfristene blir beregnet 
noisew(ansl�tte).  
noisew(antagelig).
noisew(arane).     %%  (9' arane)
noisew(aren).      %% 
noisew(as).        %% company AS
%% noisew(ass).       %%  as-buss = extrabuss
noisew(assa).  
noisew(ass�).   
%% noisew(att).   
%% noisew(atter).     %%  (igjen) =etter
%% noisew(avd).       %% ???
%%%%  noisew(avdeling).  

noisew(avg�rde). 

%% noisew(bare).   %% ikke bare = () \= ikke
noisew(berre).     %% NB ikkje berre = []
noisew(bestemt). 
noisew(bitte).     %% .. liten
noisew(bla).       %% bla a / bla bla
noisew(blabla).  
%% noisew(borte).  %% feilen er borte    
noisew(bortover). 
noisew(b�de).      %% ( very pragmatic)

noisew(ch�). %% Dial 

%% noisew(da).     %%  = n�r ???

noisew(davel).  

noisew(das�).  

%% noisew(dagleg).     %%  redundant

%% noisew(daglig).     %%  Rough

noisew(daglige).    %%  Rough 
noisew(daglege).    %% 

noisew(delvis).    
%% noisew(derfor). 
%% noisew(derimot).  %%redundant
noisew(derre).     %% di derre
   noisew(d�rre). 

noisew(dermed). %% da  . blir dermed %% ad hoc 

/* desverre er bussen forsinket :: ikke test 
noisew(desverre). %% not syn on noisew 
*/

noisew(detmed). %% det med, but redundant 
noisew(div).  
noisew(diverse). 

noisew(ds). %% dennes (denne m�ned) 

noisew(egen).      %%   (roughly)

%% noisew(egentlig).   %% Redundant0
    noisew(egenlig).  
    noisew(egentli).   %%  hvem er du egentlig
    noisew(egnetlig).
    noisew(egentle).   %% Dial
    noisew(egentlie).  %%
    noisew(egentlige). %%
    noisew(eigentleg). %% NN 

noisew(eh). 
noisew(ehm).
%% noisew(ekstra).  %% ekstra avganger 
%%     noisew(extra).  

noisew(eksplisitt).  
noisew(eksplisitte).  

noisew(ekstremt).  
noisew(ellernoe).  
%% noisew(ellers).   %%  destroys enn ellers

noisew(enda). 
noisew(endelig). 
noisew(endelige). 
noisew(ene).        %% (?)
noisew(eneste).       
   noisew(enste). 
   noisew(eneset).     %% no spc to noisew
noisew(engang).     %% redundant ? 
%% noisew(enn�).    %%  red.
% noisew(enklest).    %%  enklest mulig ==> mulig *
noisew(eine).       %% (?)
noisew(enten).      %%  enten eller (enten not required)
noisew(ern).        %% 9 ern
noisew(erne). 

% noisew(esse).       %% alts� Dial %% :-) ? 
% noisew(ass). 
% noisew(evnt).       %%  -> eller
% noisew(eventuell). 
% noisew(eventuelle). 
% noisew(eventuelt). 
% noisew(event). 
% noisew(evt). 
% noisew(ev).  

noisew(faktisk). 
noisew(feks).  
%% noisew(flest).    %%  sup many ? %% flest mulig
noisew(ford�mte).    %% bad ?
noisew(foreksempel). 
noisew(forlengs). 
noisew(formodentlig). 
noisew(fornoe).  %%  dial
noisew(fornoke). %%

noisew(forresten). %% redundant ?

noisew(forressten).  %% no pardon

% noisew(forst�elig). %% hazardous 
noisew(fortsatt).
%% noisew(for�vrig). %% (for�vrig) g�r bussen NOT question
%% noisew(fram).  %% rekke fram  
%% noisew(frem).  %% rekke frem
%% noisew(fritt). %%  :-) Rough her st�r det fritt for AtB �... 
noisew(fx).       %% f. eks
noisew(f�rstkommende). %% alltid default 

noisew(ganske).   
noisew(garantert).  
%% noisew(generelt). %% reduns %% TA-110607
noisew(generellt). 
   
noisew(gerne). %% DK

noisew(gjennomsnittlig). 
noisew(gjennomsnittelig).
noisew(gjennomsnitlig).  
noisew(gjenomsnittlig).  

% noisew(gjennomsnitts). %%  -> vanlig 

%% noisew(gjerne). %% // s� gjerne * / veldig gjerne 

noisew(gj�rne). 
noisew(gjertlig).
noisew(gj�rtlig).  

noisew(gresselig). 
noisew(gresslig).
noisew(greslig).
noisew(gressli).
noisew(gresli).
noisew(grovt). 

noisew(haen). %% hen

noisew(hah). 
noisew(haha). 
noisew(hahah). 
noisew(hahaha). 
noisew(hahha). 

% noisew(hehe). 
noisew(heheh). 
noisew(hehehe). 

noisew(henholdsvis). 
noisew(hhv).   

noisew(hehe).  %% ( hei). 
noisew(herregud). 

noisew(hihi).  %%  :-)
noisew(hihih). 
noisew(hihihi). 

%  noisew(hei).        %% (single hei = empty (hello)) n==> Initial greeting
noisew(heller). 
% noisew(helst).      %%   Vet du noe som helst
noisew(helt). 
noisew(heilt).
noisew(hen).
noisew(henn). 
%% noisew(henne).   %% ?? 
noisew(hjertelig).
noisew(hjertlig).
noisew(hm). 
noisew(hmf). 
noisew(hmm). 
noisew(hmm). 
noisew(hmmm). 
noisew(huh).
noisew(h�).
noisew(h�).
%% noisew(huff). %% destroys huff da
noisew(huffda). 
noisew(h�h�). 
noisew(h�n).    %% Dial 
noisew(h�nn).   %%
noisew(h�yt).   %%  :-) Rough

%% noisew(ialt).  %%  destroys alt ialt
%% noisew(igjen). %% opp igjen = tilbake

%% noisew(ihjel). %% fryse ??  :-)
noisew(imidlertid). %%  ( but imidlertid g�r bussen NOT question)
noisew(implisitt). 
noisew(indirekte).  %%  (Rough)
noisew(intenst).    %% not used as pre-statement

%% noisew(istede).  
%% noisew(isteden).
%% noisew(istedet). 
%% noisew(istedetfor).  
%% noisew(istedenfor).   %% istedenfor � si 
 
noisew(is�fall).  %% what about i s� fall/ i s�fall ?
noisew(i�r). 
%% noisew(jada). %%  ja
%% noisew(jaja). %%
noisew(jaggu). 
noisew(jammen).
noisew(jamen). 
noisew(jamvel). 
noisew(jas�). 
noisew(jass�). %%
noisew(jertlig).
noisew(jertelig).

% noisew(jo).       %% jeg har jo ingen penger %% jo skjermo 
% noisew(joda).   %% = ja
noisew(j�ss).  

%% noisew(kanskje).  %% redun %% TA-110624
%% noisew(kansje).   %% spiw  %%

noisew(kjempe).   %% kjempe bra 
%% noisew(kj�re).      %% :-)

%% noisew(klart). %% det er klart at 
noisew(kronologisk). 
noisew(kronologiske). 

noisew(kun). %% = bare %% TA-110304

%% noisew(kunn).  

noisew(lell).
noisew(letteste). 
noisew(lokalisert). %% fapp 
noisew(l�ll). %% dial

%% noisew(like).       %% (like f�r) alle menn er like

noisew(likes�godt). 
noisew(liks�godt).  %%

noisew(likedan).    %% hazardous ? 
noisew(liksom). 
noisew(lissom). 
%% noisew(litt).    %% litt over halv   %% ( dummy preadverb )

noisew(mao).        %% TA-110107 also vmod_conjunction 
noisew(max).  
noisew(medio).      %%  rough
noisew(mest). 
noisew(m�).  

noisew(iallefall).   
noisew(iallfall).
noisew(ikkesant). 
%% noisew(imidlertid). %% redundantly 
noisew(midlertid). 
noisew(midlertidig). 
%% noisew(muligens). %% redundant 
noisew(nedover). 
noisew(neimen). 
%% noisew(neivel). %% NEI 
noisew(nemlig). 

noisew(nesten).     %% -> neste %%  (Rough) %% TA-110427
                 %% caveat jeg rakk bussen nesten=ikke
noisew(netopp).  
noisew(nettopp). 
noisew(nettop).   
noisew(nylig). 

noisew(noengang).
noisew(noensinne). 
%% noisew(nok). %% -> redundant       %% forst�elig nok funker ikke
noisew(noks�). 
noisew(n�ye).  %% TA-110105
%% noisew(n�yaktig).   %% er bussen n.   
noisew(n�sten).     %%  ( ikke synword+ noisew)

noisew(ogsay). 
noisew(ogs�).       %% ( it should not disappear in the error message)
   noisew(�ss�).
noisew(oh).    
noisew(oi). 
noisew(oj).
% noisew(ok).          %%   Du er OK 
% noisew(okey).        %%   (synword does not work for noise)
%% noisew(ombord). 
noisew(ombrod).    
noisew(omsider). 
%% noisew(omtrent).  
noisew(ooh). 
%% noisew(overalt).    %%  ( or reducant )
noisew(ordentlig). 
noisew(ordentlige). 
noisew(ordrett). 
noisew(osv).           %% o.s.v. %%  osveien?
noisew(overhodet).  

noisew(pang).          %%  :-)
%% noisew(plutselig).  %% redundantly %% TA-110520   
noisew(prim�r).
%% noisew(ps).      %% P.S. -> personal 
noisew(p�h). 
noisew(p�vei).  %% pragm 

noisew(rasende). %% fort
noisew(relativt).
%% noisew(rent). %% clean 
noisew(respektive).
%% noisew(rett).       %% (rett f�r) rett og slett
%% noisew(riktig).     %%  er du riktig klok // du varer riktig
noisew(rimelig).
noisew(rn).   %% 5ern 
% noisew(sammen).     %% til sammen
% noisew(samtidig).   %%  simultaneosly 
noisew(sannelig).   
noisew(sannerlig).  
%% noisew(sannsynligvis). %% redun
% noisew(seg).        %% NO
% noisew(sj�).        %% Dial+ lake
noisew(sj�h).         %% Dial :-) 
noisew(sch�).         %% Dial :-) 
noisew(sch�h).        %% Dial :-) 
%% noisew(selv)       %% selv om  
   noisew(sj�l).  
   noisew(sj�lv). 
noisew(selve).         %%  hva koster selve bussen ?
%  noisew(selvf�lgelig). %% redundant0
%  noisew(self�lgelig).
noisew(seri�st). 
noisew(serska). %% dial
%% noisew(sikkert).   %% sikkert best 
%% noisew(singel).       %%  default 

%% noisew(sj�).  %% TA-110330        %% (dialect, "you see")

noisew(skikkelig). 
noisew(sikkelig).     %%
   noisew(skj�). 
noisew(slag). 
noisew(slags).     %%   hva slags v�r  =/=> hva v�r
   noisew(slaks). 
% noisew(slik).    %%  Allow slik at // Soft Noise
%% noisew(slike).  %% disse 
%% noisew(slikt).  %% slik er vanlig 
%% noisew(snart).     %% ? s� snart=n�r
noisew(sondere).   %%  (no synwords to noise)
noisew(sonderre).  %%
noisew(spesielt). 
noisew(spessielt). 
noisew(spesifikk). 
noisew(spesifikke).
noisew(spesifikt). 

noisew(stadig).
noisew(stakkar). 
noisew(stakkars).  %%  ..deg
noisew(sterkt). 
noisew(stk). 
noisew(stykk).  
%% noisew(stykker). %% i stykker ? 
noisew(sukk). 
%% noisew(s�ren). %% allowed swearword :-) %% TA-100912 
noisew(s�rli). 
noisew(s�rlig). 
noisew(s�rlige).
noisew(s�rlg). 
noisew(s�kalt). 
   noisew(s�kalte). 
%% noisew(s�nn). %%   s�nn at 
noisew(s�nnd�rre). %%
%% noisew(s�nt).   %% du sier s�nt 
noisew(s�jnn). %%  :-)
noisew(s�nnj). %%  :-)
noisew(saann). 
noisew(sammenlagt). 
noisew(temmelig).  
%% noisew(tidsnok).  %% = presis  punctually ??
noisew(tilfeldigvis).
noisew(tiln�rmet).  
noisew(tilsammen).    %% (eller redundant ?)
%% noisew(tilsendt).     %% f� tilsendt 
noisew(tilstede).  
noisew(tilsvarende). 

noisew(tja).     
noisew(totalt).  

%% noisew(trafikk):- user:myflags(smsflag,true). 
%% noisew(tvert).       %% n�!/ tvert om / tvert nei %% tvert imot
%% noisew(tydeligvis). 
noisew(typisk).      %%  rough 

noisew(uansett). %% * uansett v�r  %% TA-110503

%% noisew(uff). %% destroys uff da 
 noisew(uffda).   
noisew(underveis).    %%  (redundant)
noisew(underveid).    %% spell 
%% noisew(unnskyld).  %% -> OK.
%% noisew(unskyld). 

noisew(urk).   %% :-(
noisew(utenat).  
noisew(utrolig).      %% :-)

% noisew(vanligvis).  %% ==> redundant ( = til vanlig )

%%% noisew(vel).      %%   vel ikke -> []
                      %% word is needed otherwise in compword , use compword
                          

%% noisew(veldig).   %% positivt gradsadverb     
noisew(venligst).     %%  (DK)
noisew(vennligst). 
noisew(vers�god). 
noisew(vesentlig).  
noisew(vettu). 
noisew(vidare).  
%% noisew(videre).  
noisew(vidre).        %% ???
%% noisew(virkelig). %% er du virkelig ?
noisew(visse). 
%% noisew(visst). 
noisew(visstnok).  
noisew(voldsomt). 
noisew(v�res�god). 
noisew(v�rs�snill).
noisew(v�rs�god). %% N: takk -> S:v�rs�god  -> N: takk
noisew(v�rsegod).
noisew(versegod).


%% noisew(yo).  %% jo , ja

noisew(�h). 
noisew(�hh).  
noisew(�rten). %% umpteen 
noisew(�sj).

noisew(�h). 
noisew(��h). 
noisew(�nei). 
noisew(�nej). 
noisew(�nkli). %% ordentlig
noisew(�penbart). %% TA-111002 *det er �penbart at
noisew(�rntli).  
noisew(�rntlig). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Ways to spell telephone in Norwegian. 
%% Extended list

tlf(nomer).
tlf(nomeret).
tlf(nomerne).
tlf(nommer).
tlf(nommeret).
tlf(nommerne).
tlf(nommmer).
tlf(nommmeret).
tlf(nommmerne).
tlf(nommmr).
tlf(nommmret).
tlf(nommr).
tlf(nommrene).
tlf(nommret).
tlf(nomr).
tlf(nomrene).
tlf(nomret).
tlf(nr).
tlf(numer).
tlf(numeret).
tlf(numerne).
tlf(nummer).
tlf(nummeret).
tlf(nummert).
tlf(nummerne).
tlf(nummmer).
tlf(nummmeret).
tlf(nummmerne).
tlf(nummmr).
tlf(nummmrene).
tlf(nummmret).
tlf(nummr).
tlf(nummrene).
tlf(nummret).
tlf(numr).
tlf(numrene).
tlf(numret).
tlf(tefn).
tlf(tefnr).
tlf(tel).
tlf(tele).
tlf(telef).  
tlf(telefn).
tlf(telefnr).  
tlf(telefnnomer).
tlf(telefnnomeret).
tlf(telefnnomerne).
tlf(telefnnommer).
tlf(telefnnommeret).
tlf(telefnnommerne).
tlf(telefnnommmer).
tlf(telefnnommmr).
tlf(telefnnommmret).
tlf(telefnnommr).
tlf(telefnnommret).
tlf(telefnnomr).
tlf(telefnnomrene).
tlf(telefnnomret).
tlf(telefnnr).
tlf(telefnnumer).
tlf(telefnnumeret).
tlf(telefnnumerne).
tlf(telefnnummer).
tlf(telefnnummeret).
tlf(telefnnummerne).
tlf(telefnnummmer).
tlf(telefnnummmr).
tlf(telefnnummmret).
tlf(telefnnummr).
tlf(telefnnummrene).
tlf(telefnnummret).
tlf(telefnnumr).
tlf(telefnnumrene).
tlf(telefnnumret).
tlf(telefom).
tlf(telefon).
tlf(telefone).
%% tlf(telefonen). %% sin def 
tlf(telefoner).
tlf(telefonn).
tlf(telefonnomer).
tlf(telefonnomeret).
tlf(telefonnomerne).
tlf(telefonnommer).
tlf(telefonnommeret).
tlf(telefonnommerne).
tlf(telefonnommmer).
tlf(telefonnommmeret).
tlf(telefonnommmr).
tlf(telefonnommr).
tlf(telefonnommrene).
tlf(telefonnommret).
tlf(telefonnomr).
tlf(telefonnomrene).
tlf(telefonnomret).
tlf(telefonnr).
tlf(telefonnu).
tlf(telefonnum).
tlf(telefonnumer).
tlf(telefonnumeret).
tlf(telefonnumerne).
tlf(telefonnummeet). 
tlf(telefonnummer).
%% tlf(telefonnummeret).  %% sin def 
tlf(telefonnunner). %%  own 
tlf(telefonnummerne).
tlf(telefonnummmer).
tlf(telefonnummmeret).
tlf(telefonnummmerne).
tlf(telefonnummmr).
tlf(telefonnummmrene).
tlf(telefonnummmret).
tlf(telefonnummr).
tlf(telefonnummrene).
tlf(telefonnummret).
tlf(telefonnumr).
tlf(telefonnumrene).
tlf(telefonnumret).
tlf(telefonu).
tlf(telefonumer).
tlf(telefonumeret).
tlf(telefonumerne).
tlf(telefonummer).
tlf(telefonummeret).
tlf(telefonummerne).
tlf(telefonummmer).
tlf(telefonummmeret).
tlf(telefonummmerne).
tlf(telefonummmr).
tlf(telefonummmrene).
tlf(telefonummmret).
tlf(telefonummr).
tlf(telefonummrene).
tlf(telefonummret).
tlf(telefonum).
tlf(telefonumr).
tlf(telefonumrene).
tlf(telefonumret).

tlf(telenomer).
tlf(telenomeret).
tlf(telenomerne).
tlf(telenommer).
tlf(telenommeret).
tlf(telenommerne).
tlf(telenommmer).
tlf(telenommmeret).
tlf(telenommmerne).
tlf(telenommmr).
tlf(telenommmret).
tlf(telenommr).
tlf(telenommrene).
tlf(telenommret).
tlf(telenomr).
tlf(telenomrene).
tlf(telenomret).
tlf(telenr).
tlf(telenumer).
tlf(telenumeret).
tlf(telenumerne).
tlf(telenummer).
tlf(telenummeret).
tlf(telenummerne).
tlf(telenummmer).
tlf(telenummmeret).
tlf(telenummmerne).
tlf(telenummmr).
tlf(telenummmrene).
tlf(telenummmret).
tlf(telenummr).
tlf(telenummrene).
tlf(telenummret).
tlf(telenumr).
tlf(telenumrene).
tlf(telenumret).
tlf(telf).
tlf(telfn).
tlf(telfnn).
tlf(telfnnomer).
tlf(telfnnomerne).
tlf(telfnnommer).
tlf(telfnnommeret).
tlf(telfnnommerne).
tlf(telfnnommmer).
tlf(telfnnommmeret).
tlf(telfnnommmr).
tlf(telfnnommr).
tlf(telfnnommret).
tlf(telfnnomr).
tlf(telfnnomrene).
tlf(telfnnomret).
tlf(telfnnr).
tlf(telfnnumer).
tlf(telfnnumeret).
tlf(telfnnumerne).
tlf(telfnnummer).
tlf(telfnnummeret).
tlf(telfnnummerne).
tlf(telfnnummmer).
tlf(telfnnummmr).
tlf(telfnnummmret).
tlf(telfnnummr).
tlf(telfnnummret).
tlf(telfnnumr).
tlf(telfnnumrene).
tlf(telfnnumret).
tlf(telfno). 
tlf(telfnommer). 
tlf(telfnr).
tlf(telfnum).
tlf(telfnummeret). 
tlf(telfnur).
tlf(telfon).
tlf(telfonn).
tlf(telfonnomer).
tlf(telfonnomeret).
tlf(telfonnomerne).
tlf(telfonnommer).
tlf(telfonnommeret).
tlf(telfonnommmer).
tlf(telfonnommmeret).
tlf(telfonnommmr).
tlf(telfonnommmret).
tlf(telfonnommr).
tlf(telfonnommrene).
tlf(telfonnommret).
tlf(telfonnomr).
tlf(telfonnomrene).
tlf(telfonnomret).
tlf(telfonnr).
tlf(telfonnumer).
tlf(telfonnumeret).
tlf(telfonnumerne).
tlf(telfonnummer).
tlf(telfonnummeret).
tlf(telfonnummerne).
tlf(telfonnummmer).
tlf(telfonnummmeret).
tlf(telfonnummmerne).
tlf(telfonnummmr).
tlf(telfonnummmrene).
tlf(telfonnummmret).
tlf(telfonnummr).
tlf(telfonnummrene).
tlf(telfonnummret).
tlf(telfonnumr).
tlf(telfonnumrene).
tlf(telfonnumret).
tlf(tell).
tlf(telle).
tlf(tellefn).
tlf(tellefnn).
tlf(tellefnnomer).
tlf(tellefnnomeret).
tlf(tellefnnomerne).
tlf(tellefnnommer).
tlf(tellefnnommeret).
tlf(tellefnnommerne).
tlf(tellefnnommmer).
tlf(tellefnnommmeret).
tlf(tellefnnommmr).
tlf(tellefnnommmret).
tlf(tellefnnommr).
tlf(tellefnnommrene).
tlf(tellefnnommret).
tlf(tellefnnomr).
tlf(tellefnnomrene).
tlf(tellefnnomret).
tlf(tellefnnr).
tlf(tellefnnumer).
tlf(tellefnnumeret).
tlf(tellefnnumerne).
tlf(tellefnnummer).
tlf(tellefnnummeret).
tlf(tellefnnummerne).
tlf(tellefnnummmer).
tlf(tellefnnummmeret).
tlf(tellefnnummmerne).
tlf(tellefnnummmr).
tlf(tellefnnummmrene).
tlf(tellefnnummmret).
tlf(tellefnnummr).
tlf(tellefnnummrene).
tlf(tellefnnummret).
tlf(tellefnnumr).
tlf(tellefnnumrene).
tlf(tellefnnumret).
tlf(tellefon).
tlf(tellefonn).
tlf(tellefonnomer).
tlf(tellefonnomeret).
tlf(tellefonnomerne).
tlf(tellefonnommer).
tlf(tellefonnommeret).
tlf(tellefonnommerne).
tlf(tellefonnommmer).
tlf(tellefonnommmeret).
tlf(tellefonnommmerne).
tlf(tellefonnommmr).
tlf(tellefonnommmret).
tlf(tellefonnommr).
tlf(tellefonnommrene).
tlf(tellefonnommret).
tlf(tellefonnomr).
tlf(tellefonnomrene).
tlf(tellefonnomret).
tlf(tellefonnr).
tlf(tellefonnumer).
tlf(tellefonnumeret).
tlf(tellefonnumerne).
tlf(tellefonnummer).
tlf(tellefonnummeret).
tlf(tellefonnummerne).
tlf(tellefonnummmer).
tlf(tellefonnummmeret).
tlf(tellefonnummmerne).
tlf(tellefonnummmr).
tlf(tellefonnummmrene).
tlf(tellefonnummmret).
tlf(tellefonnummr).
tlf(tellefonnummrene).
tlf(tellefonnummret).
tlf(tellefonnumr).
tlf(tellefonnumrene).
tlf(tellefonnumret).
tlf(tellen).
tlf(tellenomer).
tlf(tellenomeret).
tlf(tellenomerne).
tlf(tellenommer).
tlf(tellenommeret).
tlf(tellenommerne).
tlf(tellenommmer).
tlf(tellenommmeret).
tlf(tellenommmerne).
tlf(tellenommmr).
tlf(tellenommmret).
tlf(tellenommr).
tlf(tellenommrene).
tlf(tellenommret).
tlf(tellenomr).
tlf(tellenomrene).
tlf(tellenomret).
tlf(tellenr).
tlf(tellenumer).
tlf(tellenumeret).
tlf(tellenumerne).
tlf(tellenummer).
tlf(tellenummeret).
tlf(tellenummerne).
tlf(tellenummmer).
tlf(tellenummmeret).
tlf(tellenummmerne).
tlf(tellenummmr).
tlf(tellenummmrene).
tlf(tellenummmret).
tlf(tellenummr).
tlf(tellenummrene).
tlf(tellenummret).
tlf(tellenumr).
tlf(tellenumrene).
tlf(tellenumret).
tlf(tellfn).
tlf(tellfnn).
tlf(tellfnnomer).
tlf(tellfnnomeret).
tlf(tellfnnomerne).
tlf(tellfnnommer).
tlf(tellfnnommeret).
tlf(tellfnnommerne).
tlf(tellfnnommmer).
tlf(tellfnnommmeret).
tlf(tellfnnommmerne).
tlf(tellfnnommmr).
tlf(tellfnnommmret).
tlf(tellfnnommr).
tlf(tellfnnommrene).
tlf(tellfnnommret).
tlf(tellfnnomr).
tlf(tellfnnomrene).
tlf(tellfnnomret).
tlf(tellfnnr).
tlf(tellfnnumer).
tlf(tellfnnumeret).
tlf(tellfnnumerne).
tlf(tellfnnummer).
tlf(tellfnnummeret).
tlf(tellfnnummerne).
tlf(tellfnnummmer).
tlf(tellfnnummmeret).
tlf(tellfnnummmr).
tlf(tellfnnummmrene).
tlf(tellfnnummmret).
tlf(tellfnnummr).
tlf(tellfnnummrene).
tlf(tellfnnummret).
tlf(tellfnnumr).
tlf(tellfnnumrene).
tlf(tellfnnumret).
tlf(tellfon).
tlf(tellfonn).
tlf(tellfonnomer).
tlf(tellfonnomeret).
tlf(tellfonnomerne).
tlf(tellfonnommer).
tlf(tellfonnommeret).
tlf(tellfonnommerne).
tlf(tellfonnommmer).
tlf(tellfonnommmeret).
tlf(tellfonnommmerne).
tlf(tellfonnommmr).
tlf(tellfonnommmret).
tlf(tellfonnommr).
tlf(tellfonnommrene).
tlf(tellfonnommret).
tlf(tellfonnomr).
tlf(tellfonnomrene).
tlf(tellfonnomret).
tlf(tellfonnr).
tlf(tellfonnumer).
tlf(tellfonnumeret).
tlf(tellfonnumerne).
tlf(tellfonnummer).
tlf(tellfonnummeret).
tlf(tellfonnummerne).
tlf(tellfonnummmer).
tlf(tellfonnummmeret).
tlf(tellfonnummmerne).
tlf(tellfonnummmr).
tlf(tellfonnummmrene).
tlf(tellfonnummmret).
tlf(tellfonnummr).
tlf(tellfonnummrene).
tlf(tellfonnummret).
tlf(tellfonnumr).
tlf(tellfonnumrene).
tlf(tellfonnumret).
tlf(telln).
tlf(tellnomer).
tlf(tellnomeret).
tlf(tellnomerne).
tlf(tellnommer).
tlf(tellnommeret).
tlf(tellnommerne).
tlf(tellnommmer).
tlf(tellnommmeret).
tlf(tellnommmerne).
tlf(tellnommmr).
tlf(tellnommmret).
tlf(tellnommr).
tlf(tellnommrene).
tlf(tellnommret).
tlf(tellnomr).
tlf(tellnomrene).
tlf(tellnomret).
tlf(tellnr).
tlf(tellnumer).
tlf(tellnumeret).
tlf(tellnumerne).
tlf(tellnummer).
tlf(tellnummeret).
tlf(tellnummerne).
tlf(tellnummmer).
tlf(tellnummmeret).
tlf(tellnummmerne).
tlf(tellnummmr).
tlf(tellnummmrene).
tlf(tellnummmret).
tlf(tellnummr).
tlf(tellnummrene).
tlf(tellnummret).
tlf(tellnumr).
tlf(tellnumrene).
tlf(tellnumret).
tlf(teln).
tlf(telnomer).
tlf(telnomeret).
tlf(telnomerne).
tlf(telnommer).
tlf(telnommeret).
tlf(telnommerne).
tlf(telnommmer).
tlf(telnommmeret).
tlf(telnommmerne).
tlf(telnommmr).
tlf(telnommmret).
tlf(telnommr).
tlf(telnommrene).
tlf(telnommret).
tlf(telnomr).
tlf(telnomrene).
tlf(telnomret).
tlf(telnr).
tlf(telnumer).
tlf(telnumeret).
tlf(telnumerne).
tlf(telnummer).
tlf(telnummeret).
tlf(telnummerne).
tlf(telnummmer).
tlf(telnummmeret).
tlf(telnummmerne).
tlf(telnummmr).
tlf(telnummmrene).
tlf(telnummmret).
tlf(telnummr).
tlf(telnummrene).
tlf(telnummret).
tlf(telnumr).
tlf(telnumrene).
tlf(telnumret).
tlf(tfn).
tlf(tfnn).
tlf(tfnnomer).
tlf(tfnnomeret).
tlf(tfnnomerne).
tlf(tfnnommer).
tlf(tfnnommeret).
tlf(tfnnommerne).
tlf(tfnnommmer).
tlf(tfnnommmeret).
tlf(tfnnommmr).
tlf(tfnnommmret).
tlf(tfnnommr).
tlf(tfnnommrene).
tlf(tfnnommret).
tlf(tfnnomr).
tlf(tfnnomrene).
tlf(tfnnomret).
tlf(tfnnr).
tlf(tfnnumeret).
tlf(tfnnumerne).
tlf(tfnnummer).
tlf(tfnnummeret).
tlf(tfnnummerne).
tlf(tfnnummmer).
tlf(tfnnummmeret).
tlf(tfnnummmerne).
tlf(tfnnummmr).
tlf(tfnnummmrene).
tlf(tfnnummmret).
tlf(tfnnummr).
tlf(tfnnummrene).
tlf(tfnnummret).
tlf(tfnnumr).
tlf(tfnnumrene).
tlf(tfnnumret).
tlf(tfnummer).
tlf(tfon).
tlf(tfonn).
tlf(tfonnomer).
tlf(tfonnomeret).
tlf(tfonnomerne).
tlf(tfonnommer).
tlf(tfonnommeret).
tlf(tfonnommerne).
tlf(tfonnommmer).
tlf(tfonnommmeret).
tlf(tfonnommmerne).
tlf(tfonnommmr).
tlf(tfonnommmret).
tlf(tfonnommr).
tlf(tfonnommrene).
tlf(tfonnommret).
tlf(tfonnomr).
tlf(tfonnomrene).
tlf(tfonnomret).
tlf(tfonnr).
tlf(tfonnumer).
tlf(tfonnumeret).
tlf(tfonnumerne).
tlf(tfonnummer).
tlf(tfonnummeret).
tlf(tfonnummerne).
tlf(tfonnummmer).
tlf(tfonnummmeret).
tlf(tfonnummmerne).
tlf(tfonnummmr).
tlf(tfonnummmrene).
tlf(tfonnummmret).
tlf(tfonnummr).
tlf(tfonnummrene).
tlf(tfonnummret).
tlf(tfonnumr).
tlf(tfonnumrene).
tlf(tfonnumret).
%% tlf(tl). // til
tlf(tlef).
tlf(tlf).
tlf(tlfn).
tlf(tlfnn).
tlf(tlfnr).
tlf(tlfnnomret).
tlf(tlfnnr).
tlf(tlfnnumer).
tlf(tlfnnumeret).
tlf(tlfnnumerne).
tlf(tlfnnummer).
tlf(tlfnnummeret).
tlf(tlfnnummerne).
tlf(tlfnnummmer).
tlf(tlfnnummmeret).
tlf(tlfnnummmerne).
tlf(tlfnnummmr).
tlf(tlfnnummmrene).
tlf(tlfnnummmret).
tlf(tlfnnummr).
tlf(tlfnnummrene).
tlf(tlfnnummret).
tlf(tlfnnumr).
tlf(tlfnnumrene).
tlf(tlfnnumret).
tlf(tlfnummer). 
tlf(tlfnummeret).
tlf(tlfon).
tlf(tlfonn).
tlf(tlfonnomer).
tlf(tlfonnomeret).
tlf(tlfonnomerne).
tlf(tlfonnommer).
tlf(tlfonnommeret).
tlf(tlfonnommerne).
tlf(tlfonnommmer).
tlf(tlfonnommmeret).
tlf(tlfonnommmerne).
tlf(tlfonnommmr).
tlf(tlfonnommmret).
tlf(tlfonnommr).
tlf(tlfonnommrene).
tlf(tlfonnommret).
tlf(tlfonnomr).
tlf(tlfonnomrene).
tlf(tlfonnomret).
tlf(tlfonnr).
tlf(tlfonnumer).
tlf(tlfonnumeret).
tlf(tlfonnumerne).
tlf(tlfonnummer).
tlf(tlfonnummeret).
tlf(tlfonnummerne).
tlf(tlfonnummmer).
tlf(tlfonnummmeret).
tlf(tlfonnummmerne).
tlf(tlfonnummmr).
tlf(tlfonnummmrene).
tlf(tlfonnummmret).
tlf(tlfonnummr).
tlf(tlfonnummrene).
tlf(tlfonnummret).
tlf(tlfonnumr).
tlf(tlfonnumrene).
tlf(tlfonnumret).
tlf(tllfn).
tlf(tllfnn).
tlf(tllfnnomer).
tlf(tllfnnomeret).
tlf(tllfnnomerne).
tlf(tllfnnommer).
tlf(tllfnnommeret).
tlf(tllfnnommerne).
tlf(tllfnnommmer).
tlf(tllfnnommmeret).
tlf(tllfnnommmerne).
tlf(tllfnnommmr).
tlf(tllfnnommmret).
tlf(tllfnnommr).
tlf(tllfnnommret).
tlf(tllfnnomr).
tlf(tllfnnr).
tlf(tllfnnumer).
tlf(tllfnnumeret).
tlf(tllfnnumerne).
tlf(tllfnnummer).
tlf(tllfnnummeret).
tlf(tllfnnummerne).
tlf(tllfnnummmer).
tlf(tllfnnummmeret).
tlf(tllfnnummmerne).
tlf(tllfnnummmr).
tlf(tllfnnummmrene).
tlf(tllfnnummmret).
tlf(tllfnnummr).
tlf(tllfnnummrene).
tlf(tllfnnummret).
tlf(tllfnnumr).
tlf(tllfnnumrene).
tlf(tllfnnumret).
tlf(tllfon).
tlf(tllfonn).
tlf(tllfonnomer).
tlf(tllfonnomeret).
tlf(tllfonnomerne).
tlf(tllfonnommer).
tlf(tllfonnommeret).
tlf(tllfonnommerne).
tlf(tllfonnommmer).
tlf(tllfonnommmeret).
tlf(tllfonnommr).
tlf(tllfonnr).
tlf(tllfonnumer).
tlf(tllfonnumeret).
tlf(tllfonnumerne).
tlf(tllfonnummer).
tlf(tllfonnummeret).
tlf(tllfonnummerne).
tlf(tllfonnummmer).
tlf(tllfonnummmeret).
tlf(tllfonnummmr).
tlf(tllfonnummmrene).
tlf(tllfonnummmret).
tlf(tllfonnummr).
tlf(tllfonnummrene).
tlf(tllfonnummret).
tlf(tllfonnumr).
tlf(tllfonnumrene).
tlf(tllfonnumret).
tlf(tlln).
tlf(tllnomer).
tlf(tllnomeret).
tlf(tllnomerne).
tlf(tllnommer).
tlf(tllnommeret).
tlf(tllnommerne).
tlf(tllnommmer).
tlf(tllnommmr).
tlf(tllnommr).
tlf(tllnommrene).
tlf(tllnommret).
tlf(tllnomrene).
tlf(tllnomret).
tlf(tllnumer).
tlf(tllnumeret).
tlf(tllnumerne).
tlf(tllnummer).
tlf(tllnummeret).
tlf(tllnummerne).
tlf(tllnummmer).
tlf(tllnummmeret).
tlf(tllnummmerne).
tlf(tllnummmr).
tlf(tllnummmrene).
tlf(tllnummmret).
tlf(tllnummr).
tlf(tllnummrene).
tlf(tllnummret).
tlf(tllnumr).
tlf(tllnumrene).
tlf(tllnumret).
tlf(tln).
tlf(tlnomer).
tlf(tlnomeret).
tlf(tlnomerne).
tlf(tlnommer).
tlf(tlnommeret).
tlf(tlnommerne).
tlf(tlnommmer).
tlf(tlnommmr).
tlf(tlnommmret).
tlf(tlnommr).
tlf(tlnommrene).
tlf(tlnommret).
tlf(tlnomr).
tlf(tlnomrene).
tlf(tlnomret).
tlf(tlnr).
tlf(tlnumer).
tlf(tlnumeret).
tlf(tlnumerne).
tlf(tlnummer).
tlf(tlnummeret).
tlf(tlnummerne).
tlf(tlnummmer).
tlf(tlnummmeret).
tlf(tlnummmerne).
tlf(tlnummmr).
tlf(tlnummmrene).
tlf(tlnummmret).
tlf(tlnummr).
tlf(tlnummrene).
tlf(tlnummret).
tlf(tlnumr).
tlf(tlnumrene).
tlf(tlnumret).
tlf(tn).
tlf(tnomer).
tlf(tnomeret).
tlf(tnomerne).
tlf(tnommer).
tlf(tnommeret).
tlf(tnommerne).
tlf(tnommmer).
tlf(tnommmeret).
tlf(tnommr).
tlf(tnommrene).
tlf(tnommret).
tlf(tnomr).
tlf(tnomrene).
tlf(tnomret).
tlf(tnr).
tlf(tnumer).
tlf(tnumeret).
tlf(tnumerne).
tlf(tnummer).
tlf(tnummeret).
tlf(tnummerne).
tlf(tnummmer).
tlf(tnummmeret).
tlf(tnummmr).
tlf(tnummmret).
tlf(tnummr).
tlf(tnummrene).
tlf(tnummret).
tlf(tnumr).
tlf(tnumrene).
tlf(tnumret).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                 %
%  This file is already too big to maintain for any               %
%  sane person. It must under no circumstances exceed             %
%  20910 lines                                                    % 
