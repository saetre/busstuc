/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE names.pl
%% SYSTEM BUSSTUC
%% CREATED TA-071026
%% REVISED TA-110825

%% Contains Domain independent names and synonyms



%% Names that occur several places as general appendages
%% It is not a rule that the generic lies at the named place

generic_place(amfi).        
generic_place(atrium). 
generic_place(asyl).  
generic_place(bedehus).  
generic_place(bensinstasjon).   %% TA-110704
generic_place(bensinstasjonen). %%    
generic_place(behandlingsenter).   
generic_place(behandlingssenter). 
generic_place(bibliotek).  
generic_place(biblioteket). %%   Biblioteket på Moholt
generic_place(bohus).       %%  shop chain  
generic_place(bomstasjon). 
generic_place(bunnpris). 
generic_place(bydelshus).
%% generic_place(cinema).   
generic_place(comfort).     %% hotels %% TA-101025
generic_place(coop).  
generic_place(daghjem). 
generic_place(dps).         %% distrikts-psykiatriske senter
generic_place(dyrehospital).
generic_place(dyrepark). 
generic_place(dyreparken).  %% 
generic_place(egon). 
generic_place(esso).   %% TA-110426
generic_place(elkjøp). 
generic_place(familietjenesten). 
generic_place(festivalen).  
generic_place(fritidshus).   
generic_place(fritidshuset). %% 
generic_place(folkebibliotek). 
generic_place(folkehøgskole).  
generic_place('Folkets hus').  
generic_place(fretex).  
generic_place(frikirke). 
generic_place(frikirken). 
generic_place(fysioterapi).
generic_place(gamlehjem). %% TA-110822
generic_place(golfbane). 
generic_place(golfsenter). 
generic_place(grendehus). 
generic_place(gård).  
generic_place(havn).  
generic_place(helsehus). 
generic_place(helsestasjon). 
generic_place(hestesenter). 
generic_place(høyskolesenteret). %% HIST?
generic_place(ica). 

%% generic_place(idrettsanlegg). %% Hutaheiti idrettsanlegg -> noinfoabout idrettsanlegg
%% generic_place(idrettsbygg).   %% NB idrettsplassen jakonsli station %% TA-100828

generic_place(jordbruksskole). 
generic_place(kafe).  
%% generic_place(kai).         %% TA-101129 Jeg har ingen informasjon om Kai .
generic_place(kiosk). 
generic_place(kiwi).       
generic_place(kommune).     %% TA-110825
generic_place(kompetansesenter).
generic_place(kulturhus).   %% TA-101025
generic_place(kulturhuset). %%
generic_place(kunstgress).  %% TA-110824
generic_place(lagunen). 
generic_place(lege).       
generic_place(legekontor).  
generic_place(legesenter).
generic_place(markedet). 
generic_place(maxi). 
generic_place(mega).   
%% generic_place(midten).        %% TA-110121
generic_place(mødrehjem).  
generic_place(nav).  
generic_place(park).      
generic_place(pensjonat).   %% TA-101018
generic_place(prix). 
generic_place(radisson).   
generic_place(rema).        %% 
generic_place(rehabiliteringssenter).   %%et? 
generic_place(retaurant). 
generic_place(rica).  
generic_place(ridesenter). 
generic_place(riksvei). 
generic_place(rimi).    
generic_place(rådhus).  
generic_place(samfunnshus). 
generic_place(sanitetsforening). 
generic_place(skisenter).
generic_place(skytebane).  
generic_place(sas).  
generic_place(shell).
generic_place(snarkjøp). 
%% generic_place(skysstasjon). %%Klæbu Ss  %% TA-101207
generic_place(statuen).  
generic_place(strand). %% \+  Sætran       %% TA-101123
generic_place(stranden).%% underspec?      %% TA-101108
generic_place(studentsamskipnaden). 
generic_place(sykehjem).  
generic_place(sykehus).  
generic_place(tennishall).   
generic_place(tivoli).         %% TA-101221
generic_place(treningssenter).
generic_place(tunnel).         %% TA-110114
generic_place(ungdomsskole).   %% 
generic_place(ultra). 
generic_place(velferdssenter).
generic_place(verkstedhall).   %% TA-10206
    generic_place(verkstedhallen). %% ?
%% generic_place(vestkanten). 
%% generic_place(østkanten).   %% .. undersp

%% generic_place(sykehuset).   %% no info about Sykehuset* 
generic_place(tannklinikk). 
generic_place(tannlege). 
generic_place(tannlegekontor). 
generic_place(tunnel).  
generic_place(xxl).  %% TA-110125 

% Cities  

city(oslo).
city(bergen). 
city(london). %% London bridge %% TA-101129
city(trondheim). 
city(santa_barbara). 
city(sarpsborg). 
city(harstad).
city(hønefoss).  %% TA-110120 etc
city(new_delhi). %% TA-110603 prefer over abroad
city(new_york).

%%¤ COMPNAME

%% web adresses , see also -> facts.pl

compname(app,[store],appstore). %% TA-110707

compname(busstuc,['.',lingit,'.',no],'busstuc.lingit.no'). 

compname(tmn,['.',no],'tmn.no'). 
compname(tkort,['.',no],'tkort.no').

compname(www,['.',google,'.',no],'www.google.no'). 
compname(www,['.',klaburuten,'.',no],'www.klaburuten.no').
compname(www,['.',lingit,'.',no],'www.lingit.no'). %% TA-101008

compname(http,['/','/',www,atb,no],'http://www.atb.no'). %% TA-101115 Official
%% ad hoc, ':' and '.' are skipped 
/*    atb.no
      www.atb.no
      http://atb.no
      httb://www.atb.no
etc*/



compname('A/S',[lingit],lingit).     %%  problem
compname(lingit,['A/S'],lingit).     %% 

%% compname(a,[a,'/',s,lingit],lingit). 
%% compname(lingit,[a,'/',s],lingit).    

compname(albert,[moe],tagore).         %%  anagram Tore Amble

compname(amazon,[machine,image],ami). 

%%% compname(arvid,[holme],arvid_holme). %% Try without, see facts %% TA-101006


compname(carl,[berners,plass],carl_berners_plass). %% Oslo, 
compname(carl,[berner],carl_berners_plass). 

compname(color,[line],color_line). %% TA-110614

compname(folkets,[hus],'Folkets hus'). 
compname(google,[maps],google_maps).   
compname(hage,[by],hageby).   

compname(idretts,[senter],idrettssenter). %% TA-101110 nofunk
compname(institutt,[for,datateknikk,og,informasjonsvitenskap],idi). 
compname(institutt,[for,datateknikk],idi). %%

compname(internet,[explorer],explorer).

compname(jon,[bratseth],tagore).

%% compname(lars,[mo],lars_mo).  %% Team Traffic Route Responsible 

compname(olaf,[misfjord],olaf_misfjord). %% AtB Route Resoponsible

compname(lingit,[a,'/',s],lingit). 


compname(nett,[buss],nettbuss). 
    compname(s,[enteret],senteret). %% <--- doesnt work for nardo s enteret

compname(new,[delhi],new_delhi). %% TA-110603
compname(new,[york],new_york).   %% 

compname(nrk, [2],nrk). %% \+ NRK1 

compname(seven,[eleven],seven_eleven).
compname(7,['-',eleven],seven_eleven). %% 
compname(7,[eleven],seven_eleven).     %% ? funk?

compname(sankt,[petersburg],sankt_petersburg). %% TA-110614
compname(santa,[barbara],santa_barbara). 

compname(st,['.',hans],midsummer_day).        %% TA-100903
compname(st,[hans], midsummer_day).           %% 
compname(st,['.',hans,aften], midsummer_eve). %%
compname(st,[hans,aften], midsummer_eve).     %%

compname(the,[understanding,computer],tuc). 

compname(tore,[amble],tagore) :- 
         \+value(teleflag,true).   


compname(trafikanten,[midt,norge],tmn). 
compname(trøndelag,[kollektivtrafikk],tkt). 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%¤¤  SYNNAME 

synname(regtopp,regtop). 

synname(gaate,gate). 
synname(gade,gate).  
synname(gaden,gate). 
synname(gat,gate). 
synname(gata,gate).
synname(gatan,gate). 
synname(gate,gate).
synname(gaten,gate).
synname(gatene,gate). 
synname(gater,gate).  
synname(gats,gate). 
synname(gave,gate). 
synname(geven,gate). 
synname(gt,gate).
synname(gta,gate). 
synname(gtate,gate). 
synname(gte,gate). 
synname(gtn,gate).  
synname(gtr,gate). 
synname(gåte,gate). 

synname('va|re',være). %% TA-110103 E+N
synname(v,vei).   
synname(vag,vei).  
synname(vaar,vår). % frues kirke %% TA-101210
synname(vaien,vei). 
synname(vayr,vår). % frues kirke %% TA-101210
synname(vedi,vei).   
synname(vegdn,vei).  
synname(veeien,vei).
synname(veein,vei). 
synname(veen,vei).  
synname(vef,vei). 
synname(veg,vei).
synname(vege,vei).  
synname(vegem,vei).  
synname(vegen,vei).
synname(vegene,vei). 
synname(vegein,vei). 
synname(veger,vei). 
synname(veget,vei).  
synname(vegn,vei).  
synname(vegom,vei). 
synname(vei,vei).
synname(veid,vei).  
synname(veie,vei).   
synname(veieb,vei). 
synname(veiebn,vei).  
synname(veieen,vei). 
synname(veiein,vei). 
synname(veiem,vei). 
synname(veien,vei).
synname(veienen,vei). 
synname(veienn,vei).
synname(veiene,vei).  
synname(veig,vei).  
synname(veigen,vei).  
synname(veil,vei).   
synname(vein,vei).  
synname(veine,vei).  
synname(veinen,vei). 
synname(veiene,vei). 
synname(veier,vei). 
synname(veis,vei). 
synname(veio,vei). 
synname(veit,vei). 
synname(veiu,vei).  
synname(vej,vei). 
synname(veneien,vei).
synname(venein,vei). 
synname(venien,vei). 
synname(veo,vei).  
synname(veu,vei).   
synname(vey,vei). 
synname(vg,vei).
synname(vgn,vei).  
synname(vgen,vei).  
synname(vien,vei). 
synname(vig,vei).  
synname(vlls,viis).  % H. 7. 
synname(vn,vei).
synname(vrg,vei). 
synname(vweien,vei).
synname(væg,vei). 
synname(vægen,vei).   

synname(veg,vei). %% Ad Hoc (Brit Grytbakks vei) 
synname(g,gate).  %% Experiment g streetsyn, but vollg hazard
                  %% rosenbor(g) = rosenborg gate %% TA-110314

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% Section klæburuten

synname(kleburuten,klaburuten). 
synname(klaeburuten,klaburuten). 


synname(klaburuten,klæburuten).  
synname(klæburata,klæburuten). 
   synname(vassfjellbussen,klæburuten).
                                             %% klæbu_sentrum in DB

%% Section Th


synname(kjaøpesenter,kjøpesenter). %% TA-110325 %% kjÃ¸pesenter 

%% synname   synomym names without spellcheck
%% samename  like sameplace, with spelling

synname(tambskjelve,tambarskjelves).     %% TA-101018
synname(tambskjelves,tambarskjelves).    %% 
synname(tamerskjel,tambarskjelves). 
synname(tamberskjels,tambarskjelves).   
synname(tamberskjelves,tambarskjelves). 


%%%%%%%%%%%%%%%%%%%%

%%%%¤¤  SYNNAME

    synname(tambarkjelves,tambarskjelves).
    synname(tambarsjelvas,tambarskjelves). 
%    synname(tambarskjelve,tambarskjelves).  
%    synname(tambarsjkelvs,tambarskjelves).

synname(gode,godes). %% Magnus d g

synname(googlemaps,google_maps).

synname(gærd,gård).  

%% synname(s,sentrum). %% NB avoid Trondheim S -> sentrum 

synname(sd,syd).   

synname(sgt,st).  
synname(sgt,sankt).  

synname(sed,syd). 

synname(senteret,senter). 
synname(sentre,senter).
synname(sentre,senteret). %% Migo sentre 
synname(sentrm,sentrum). 
synname(sentrumsterminalen,sentrum). 


synname(sk,skole).
synname(skavlans,skavlands). 
synname(skule,skole).
synname(skule,sk). 


synname(7,viis).    %% H7 .. street
%% synname(7,vii).        %% H7 

synname(sjirke,kirke).
synname(sjuendes,vii).


synname(sportsplass,idrettsbane). 

synname(edg,edgar).   %% e.b. schieldrop
synname(edgr,edgar). 
synname(egges,eggens).       %% christian
synname(ekspresen,ekspressen). 

synname(kaakon,haakon).  
synname(kalr,karl). 
synname(katl,karl). 

synname(kole,skole). 
synname(konges,kongens). %% nec (?) 
synname(kono,kino). 
synname(korke,kirke). 
synname(korke,krk).  


synname(ksel,aksel).  

synname('17mai',may17). 

synname(aees,aaes). %% TA-101110 own

synname(akole,skole).
synname(akole,sk).

%%% synname(atb,team). %% AtB new name for TKF buses %% TA-100824

synname(aton,anton). %% TA-101101
synname(bjørkhaugen,bjørkhaug). 
synname(bten,byen). 

%% synname(byaas,byås). %% --> places 

synname(abel,abels).      %%  (Laura hangeraas syndrom)
synname(abyen,byen).      %%  fr abyen ???

synname(aas,aaes). 
synname(aes,aaes). 
synname(åeder,peder). 
synname(åverås,øverås).  
synname(ås,aaes). 
synname(ajohan,johan).    %% caps lock 
synname(ala,alle). %%  alÃ¨ allé %% TA-110105
synname(ale,alle). %%       allé
synname(alee,alle). 
synname(aleksander,alexander). %% (tsx x -> ks)
synname(alfr,alfred). 
synname(alfred,hallfred). 
synname(all,alle). 
synname(allaø,alle).      %% fagerheim allÃ© 
synname(almaas,almos).   
synname(aolavs,olavs).

synname(andres,anders). 
synname(angel,angells).   %% thomas 
synname(anl,anlegg). 
synname(anl,anlegget).  

synname(arald,harald). 
synname(ark,arkitekt). 
synname(arne,arnt).  %% common name -> rare  name %% NOT Dater

synname(atudentby,studentby). 
synname(aøstre,østre).  

synname(badestranden,badestranda). 
synname(badetet,badet). 
synname(bakk,bakke).  
synname(baldemar,waldemar).  
synname(balen,dalen).   %% ?
synname(bang,bangs).
synname(bard,baard).    %% iversens v 
synname(bard,bård). 
synname(barneskole,skole). 
synname(barneskkole,skole). %%

synname(barrfotts,berrføtts). %% TA-101022
synname(barfotts,berrføtts).  %%
synname(barrfots,berrføtts).  %%
synname(barfots,berrføtts).   %%

synname(beeg,berg). 
synname(begs,bergs). 
synname(bergårds,bergsgårds).
synname(bergs, berg). %% laura hangerås syndromet
synname(berg, bergs). 

synname(berrfots,berrføtts).  
synname(berrføttes,berrføtts). 
synname(bibloteket,biblioteket).  
synname(bishop,biskop).   %% TA-110404
synname(bishops,biskops). %% 
synname(blinde,blindes). %% .. magnus  b g
synname(boch,brochs). 
synname(bocks,brochs). 
synname(bodo,bodø). 
synname(boks,brochs). 
synname(bor,bro).      %%  ?
synname(borcs,brochs).   
synname(borck,brochs).  
synname(borcks,brochs). 
synname(bordson,bårdsøns).  
synname(bordsons,bårdsøns).
synname(borks,brochs).
synname(botners,bothners). 
synname(bovling,bowling). %% unnec ?
                                          
synname(brg,berg).  
synname(bri,bru). 
synname(brannst,brannstasjon).  
synname(brannstasjon,brannst).  
synname(breidabl,breidablikk). 
synname(bredablikk,breidablikk). 

synname(brocks,brochs).  
synname(brof,professor). 
synname(brofessor,professor). 
synname(broc,brochs).  
synname(brocs,brochs). 
synname(broks,brochs).  
synname(brox,brochs).  
synname(broxs,brochs). %% TA-101228

synname(bruksmester,brukseier). %%  olsen

synname(bråkks,brochs). 
synname(bråks,brochs).  
synname(bråtens,braatens).  

%% synname(byåsen,byås). %% byåsen veien //spec. Trondheim -> places

synname(bue,buens).  
synname(bues,buens).  
synname(bukkenes,bukkene). %% bruses // contag
synname(bull,bulls). 
synname(bur,bru).  
synname(bussetuc,bustuc).  %%  NB Names are English 
synname(busstoc,bustuc).  
synname(busstuc,bustuc).  
%% synname(busstucs,bustucs). %% Gen attached to Official English names 

synname(byyn,byen).
synname(byena,byen). 

synname(byensentrum,sentrum). 

synname(bøgda,bygda). 

synname(chlund,charlottenlund).
synname(chr,christian). 
synname(christen,christian). 
synname(chrisen,christian).   %% ?

synname(christoffer,kristoffer). 
synname(christoffer,chr).  %% Monsen

synname(churcill,churchill). 
synname(churtcils,churchills). 
synname(churtshill,churchill). 
synname(churtsils,churchills).  

synname(cr,chr). 
synname(curtshill,churchill). 

%% synname(cinema,kino). %% confuse 

synname(cid,syd).   

synname(cicy,city).  
synname(ciiy,city).   
synname(cit,city).  
synname(cita,city). 
synname(citu,city). 
synname(ciry,city).   
synname(ciy,city).  
synname(ciyd,city).  
synname(coty,city). 
synname(cuti,city). 
synname(ctiy,city).   
synname(cyti,city). 
synname(cyty,city). 
synname(ciyt,city).  
synname(ecity,city). 
synname(cuty,city).   

synname(dahl,dahls).   
synname(dale,dalen).  
synname(dalem,dalen). 
synname(daln,dalen).  
synname(dals,dahls).  
synname(damfundet,samfundet). 
synname(damfunnet,samfundet).  %% 
synname(distr,distriktslege).  

synname(dkole,skole).        %% neib k
synname(dlole,skole). %% 2 neib k 

synname(dkole,sk).        %% neib k
synname(dlole,sk). %% 2 neib k

synname(donnigens,dronningens). 
synname(dons,duuns).  

synname(dr,overlege).     %% Kindt 
synname(doktor,overlege). %% 

synname(droming,dronningens). %% ?
synname(drommingens,dronningens). 
synname(dronigens,dronningens).
synname(dronignens,dronningens).  
synname(dronningems,dronningens). 
synname(dronnings,dronning). %% mauds minne Contag
synname(dronnings,dronningens). %% gt
synname(drømmingens,dronningens).
synname(dtudentby,studentby). 

synname(ebbels,ebbells).   
synname(eina,einar).      %% eina is a place 
synname(einar,erling).    %% first name, who cares 
synname(einer,einar). 
synname(einr,einar). %% TA-110303
synname(enar,einar). 
synname(enstrum,sentrum).  
synname(elvehamn,elvehavn). 
synname(elvseterveien,elgeseter_street).
synname(elvehall,elvehavn). 
synname(elvehallen,elvehavn). 


% (kroppanmarka) endehlp

synname(endeholdestasjon,endehpl).  
synname(endeholdeplass,endehpl). 
synname(endeholderplass,endehpl).
synname(endeholderpl,endehpl). 
synname(endholdepl,endehpl).  
synname(endholdeplass,endehpl).  
synname(endest,endehpl).
synname(endeholdestasjon,endehpl).  
synname(endeholdeplass,endehpl). 
synname(endeholderplass,endehpl).
synname(endeholderpl,endehpl).
synname(endholdepl,endehpl).  
synname(endholdeplass,endehpl). 
synname(endest,endehpl).

% (vestlia) endeholdeplass 

synname(endeholdestasjon,endeholdeplass).   
synname(endeholdeplass,endeholdeplass). 
synname(endeholderplass,endeholdeplass).
synname(endeholderpl,endeholdeplass). 
synname(endeholdepl,endeholdeplass). 
synname(endholdepl,endeholdeplass).  
synname(endholdeplass,endeholdeplass).  
synname(endeh,endeholdeplass). 
synname(endehp,endeholdeplass). 
synname(endehpl,endeholdeplass). 
synname(endehlp,endeholdeplass). 
synname(endh,endeholdeplass). 
synname(endeholdplass,endeholdeplass).  
synname(endhp,endeholdeplass). 
synname(endhpl,endeholdeplass). 
synname(endeholderplass,endeholdeplass). 
synname(endeholdeholdeplassen,endeholdeplass). 
synname(endest,endeholdeplass). 
synname(enedeplass,endeholdeplass).

synname(endeholdestasjon,endehpl). 
synname(endeholderplass,endehpl).
synname(endeholderpl,endehpl). 
synname(endeholdepl,endehpl). 
synname(endholdepl,endehpl).  
synname(endholdeplass,endehpl).  
synname(endeh,endehpl). 
synname(endehp,endehpl). 
synname(endehpl,endehpl). 
synname(endehlp,endehpl). 
synname(endh,endehpl). 
synname(endeholdplass,endehpl).  
synname(endhp,endehpl). 
synname(endhpl,endehpl). 
synname(endeholderplass,endehpl). 
synname(endeholdeholdeplassen,endehpl). 
synname(endest,endehpl). 
synname(enedeplass,endehpl).
synname(enholdeplass,endehpl). 

synname(edga,edgar).   %% autom hash > 5
synname(edgar,einar).  %% act.. tamb...

synname(engebr,engelbrektssons).  
synname(engebrettsons,engelbrektssons). 
synname(engelbretson,engelbrektssons). 
synname(engelbretsons,engelbrektssons). 
synname(englebregtssons,engelbrektssons). 

synname(erl,erling). 
synname(erling,einar). %% act.. tamb... 
synname(erling,eirik). %% jarl
synname(esntrum,sentrum).  

synname(finnland,finland).
synname(finns,finnes).     %% Hans F
synname(fridtjof,fritjof). %% Standard
synname(fridjof,fritjof).
synname(fridjov,fritjof).
synname(fritiof,fritjof).
synname(fritjov,fritjof).

synname(frofessor,professor).  
synname(fronningens,dronningens). 

synname(frue,frues). %%  nec ??
synname(frues,frue). %% frue strete/ frues gate

synname(fård,gård).  

synname(gageby,hageby).  
synname(gaheby,hageby).  
synname(gakke,bakke).            %% neib k
synname(gard,gård). 

synname(garnison,leir). %% e.g. pesaune/ værnes 
synname(garnison,militærleir).

synname(gata,gate). %% Prof,broch (#-> unnec)
synname(gida,gina).  
synname(gildes,gilles).   %% harald
synname(greina,grenda). %% dial 
synname(grendeskole,skole). 
synname(gressbane,idrettsplass).
synname(grevskott,grevskotts). %% NB grevskott new station 

synname(grefskotsvei,grevskottsveg). %% helps ? 

synname(graønnland,       grønnland). %% avoid grønlia %% TA-101118
synname(gråkallbane,      gråkallbanen). 
synname(graakallbanen,    gråkallbanen). 
synname(gråkalbanen,      gråkallbanen). 
synname(gråkallenbanen,   gråkallbanen). 
synname(grakallbanen,     gråkallbanen).
synname(graakallbanen,    gråkallbanen).  
synname(gråkolbanen,      gråkallbanen).
synname(gråkollbanen,     gråkallbanen). 
synname(gårkallbanen,     gråkallbanen). 
%% synname(gårt,gård).    %% går/gått 
%% synname(går,gård).     %% Too haz
synname(gåed,gård).       %% own
synname(gårs,gård). 

synname(hagebyen,hageby). 
synname(habegy,hageby).   %% sperr
synname(hagegård,hageby). %% Dalen h 
synname(hageleir,hageby). 
synname(hall,hallen).   
synname(hallfr,hallfred). 
% synname(halllen,hallen).       %% unnec 
synname(handlesenter,butikksenter). 
synname(hansteensens,hansteens).
synname(harry,harald). 
synname( hayrfarges,hårfagres). %% TA-110415
synname(hereds,innherreds).  
synname(herreds,innherreds).  
synname(hirke,kirke).  

synname(hirsh,hirschs).    %% 
synname(hirch,hirschs).    %%
synname(hirchs,hirschs).   %%
synname(hirsch,hirschs).   %% # unnec 

%% synname(hofstads,ofstads). %% -> dont_spell_check

synname(holterman,holtermann). 
synname(hospitalet,hospital).
synname(hopitsl,hospital).  
synname(hovedflyplass,flyplass). 
synname(hovedflystasjon,flyplass).  
synname(høgskole,høyskole).  
synname(høgskoleparken,høyskoleparken).
synname(hårfagre,hårfagres).  

synname(icea,ikea).
synname(idretsbygg,idrettsbygg). 
synname(idressbygg,idrettsbygg).   
synname(idressbygget,idrettsbygget).  
synname(idressplassen,idrettsplassen). 
synname(idrettsarena,idrettsplass).  
synname(idretsarena,idrettsplass). 
synname(idrettsbane,idrettsplass). 
synname(idrettspark,idrettsplass).   
synname(idrettsparken,idrettsplassen).
%% synname(idrettsplass,idrettsplassen). %% generic
synname(idrettsplats,idrettsplass).  
synname(idrettssenter,idrettsbygg). 
synname(idrettssenter,idrettsplass). 
synname(idrettsenteret,idrettsbygget). 
synname(idrettsenteret,idrettsbygget).  
synname(idrettssenteret,idrettsbygget). 
synname(idrettssenteret,idrettsbygget). 
synname(iddrets,idretts). 
synname(idrets,idretts).       

synname(ikes,ikea). 

synname(ing,ingvald). %% ystgaard 
synname(ingebretson,engelbrektssons).  
synname(ingebritson,engelbrektssons). 
synname(ingemar,ingemann). %% .. torp
synname(ingman,ingemann). 

synname(ingvar,ingvald).  
synname(innherdes,innherreds). 
synname(irke,kirke).
synname(ivas,ivar). 
synname(iver,ivar).

synname(jerbansestasjonen,jernbanestasjonen).  
synname(jerbanestasjonen,jernbanestasjonen).  
synname(jernbansestasjonen,jernbanestasjonen).
synname(jernbabeb,jernbanen).  
synname(jernbanestasjon,stasjon). %% gives noun station 
synname(jernveg,jernbane). 


synname(jhn,johan). 
synname(jhon,john). 

synname(joh,johan).  
synname(joha,johan). 
synname(johm,johan). 
synname(john,johan). 

synname(joh,johannes).  %%
synname(john,johannes). %%

synname(jonn,john). 
synname(johns,john).  

synname(johnsen,jonssons). 

synname(johnsesn,jonssons).  %% etc 

synname(johnsons,jonssons).
synname(johnsåns,jonssons).

synname(jonsens,jonssons). %% etc 

synname(jon,john).  
synname(john,jon).

synname(johan,john). 
synname(joh,johan).  
synname(john,johan). 

synname(joh,johannes).
synname(john,johannes).

synname(jhn,johan).  
synname(jonn,john).   



synname(jærnbane,jernbanen).  
synname(jærnbanen,jernbanen). 

synname(kike,kirke).
synname(kike,krk).   %% nec  %% Tempe krk 
synname(kin,kino).  
synname(kinosal,kinosenter). 
synname(kinosal,kino).
synname(kion,kino). 

synname(krk,kirke). 
  synname(hirke,kirke). 
  synname(kirek,kirke). 
  synname(kire,kirke). 
  synname(kirek,kirke).  
  synname(kirk,krk).  
  synname(kirk,kirke). 
  synname(kirka,kirke). 
  synname(kirkegård,kirke).  
  synname(kirge,krk).   %% strinfa_krk 
  synname(kirge,kirke).
  synname(kirken,kirke). 
  synname(kirkte,kirke). %% \+ kirken
  synname(krike,kirke). 
  synname(krke,kirke).  
  synname(kyrkje,kirke). 

synname(kyststasjon,skysstasjon). %% TA-110418

synname(kirke,krk).  %% chl kirke
  synname(hirke,krk). 
  synname(kirek,krk). 
  synname(kire,krk). 
  synname(kirek,krk).  
  synname(kirka,krk). 
  synname(kirkegård,krk).  
  synname(kirken,krk). 
  synname(kirkte,krk). %% \+ kirken
  synname(krike,krk). 
  synname(krke,krk).  
  synname(kyrkje,krk). 


synname(krogh,krog). %% Pedere Krogh, Gina Krog 

synname(knio,kino).
synname(knudsons, knudssøns). %% etc
synname(kuntsøns, knudssøns).

synname(knutepunkt,terminal). %% ? 

synname(krysse,krysset). 

synname(kunstgressbane,idrettsplass).

synname(lae,lade). 
synname(lair,leir). 
synname(lara,lars). 
synname(late,lade).
%% synname(leier,leir). %% TA-110615 Persaunet . //Leira| hire
synname(leif,leiv).
synname(leit,leir).
synname(leiv,leif).
synname(lirke,kirke).  
synname(lkea,ikea).           %% (other cities)
synname(lsentrum,sentrum). %% ti lsentrum 
synname(lude,lundes).         %% ad hoc 
synname(lysholmers,lysholms). 

synname(maauds,mauds). 
synname(markus,marcus).  %% Thrane %% nec?
synname(markus,magnus).  %%?
synname(mari,marie). 
synname(matisens,mathiesens).
synname(matsenter,kjøpesenter). 
synname(maud,mauds).   
synname(maug,mauds).          %% ? 
synname(mayr,mår).    %% TA-101221 -veien
synname(militærleir,leir).    %% Persaunet o.a.
synname(monke,munke).  
synname(museumet,museet).  
synname(museumet,museum). 
synname(møilands,møylas).  
synname(møilans,møylas).    
synname(møylands,møylas).  
synname(møylands,møylas).   

synname(naton,anton).  
synname(nerg,berg).   
synname(nestrum,sentrum).  
synname(nettbus,nettbuss). 
synname(nettbusser,nettbuss). 
%% synname(nettbusskonsernet,nettbuss).
%% synname(nina,gina).      %% grieg/   %% krog..
synname(njols,njåls). 
synname(njorders,njords). 
synname(nor,nord).  
synname(nsentrum,sentrum). 

synname(ofstads,ofstad). %% I. O. vei 
synname(oistein,øystein).   %% TA-110328
synname(oisteins,øysteins). %%
synname(oalv,olav). 
%% synname(ola,ila). %% neib// Too Haz
synname(olaf,olav). 
synname(olafs,olavs). 
synname(olan,olav). 
synname(olay,olav).  
synname(ol,ola).  
synname(ol,ole).  
synname(ole,ola).
synname(ola,ole).
synname(old,ole). 
synname(olov,olav).  
synname(olv,olav). 
synname(olva,olav). 
synname(olvs,olavs). 
synname(orkar,oscar). 
synname(orkar,oskar).
synname(orle,ole). 
synname(oscar,oskar). 
synname(oskar,oscar). 
synname(osle,oslo). %% \+ osen  Amble# 
synname(ostmark,østmark). 
synname(osvang,åsvang). 
synname(overas,øverås). %% 1. letter+ø trøbbel
synname(owens,owesens). 
synname(owenes,owesens).

synname(pedr,peder).
synname(peder,per). 
synname(per,peder). %% TA-110418 subtle  per morsets vei = per+(peder_morsets_vei)
synname(peter,peder).   
synname(petter,peter).  
synname(pettersens,petersens). 
synname(pl,plass). 
synname(polet,vinmonopolet). 
synname(polti,politi). 
synname(porf,professor).  
synname(porfesor,professor).  
synname(porfessor,professor).  %%
synname(pof,professor).        %% ?
synname(pofessor,professor).  


synname(pr,professor). 
synname(prf,professor).  
synname(prfessor,professor).  
synname(prfessors,professor). 
synname(prffesor,prof).       
synname(prffesors,prof).  
synname(prffesor,professor). 
synname(prffesors,professor).
synname(prochs,brochs).
synname(procks,brochs). 
synname(proessor,prof). 
synname(proessor,professor).
synname(profersor,prof). 
synname(profersor,professor).
synname(profersor,prof). 
synname(profeser,professor).  
synname(professir,professor). 
synname(professir,prof).  
synname(professor,prof).       %% professor_brochs_gate ! station
synname(prof,professor).       %% professor_brochs_street ! street
synname(prod,professor). 
synname(prog,professor).  
   synname(dr,prof). 
   synname(dr,professor). 
synname(prifesor,professor). 
synname(profersor,professor). 
synname(profesor,professor). 
synname(professer,professor). 
synname(professors,professor). 
synname(professot,professor). 
synname(proffecor,professor). 
synname(proffersor,professor). 
synname(proffersors,professor).
synname(proffes,professor).  
synname(proffess,professor). 
synname(proffesor,professor). 
synname(proffessor,professor). 
synname(prosessor,professor).  
synname(prpf,professor). 
synname(pruf,professor).
synname(psykiatrisk,psykriatisk). 
synname(ptof,professor). 

synname(ramfundet,samfundet). 
synname(ramfvndet,samfundet).
synname(renter,senter).   %% neib k
synname(rentrum,sentrum). %% neib k
synname(rich,richard).     %% birkeland 
synname(rich,rikard).      %%
synname(rikart,rikard). 
synname(roal,royal). 
synname(rof,professor).   %% ?
synname(rondheim,trondheim). %%
synname(rprinsen,prinsen).
synname(rofessor,professor).
synname(rofessor,prof).
synname(rosen,rosten).  

synname(safm,samfundet).
synname(samfummet,samfundet). 

synname(sanct,st).  
synname(sanct,sankt).  
synname(sankt,st). 
synname(sanke,st). %% TA-101123
synname(sant,st). 
synname(santum,sentrum). 
synname(sangt,st).  
synname(satsing,stadsing).  
synname(sbjørn,asbjørn).      %% ?
synname(skjetlands,schjetnans). 

synname(schiøts,schiøtz).  
synname(schøts,schiøtz).   
synname(schøits,schiøtz).   
synname(schøitz,schiøtz).  
synname(schøitze,schiøtz).
synname(schøtz,schiøtz).    
synname(sciøts,schiøtz). 
synname(sciøtz,schiøtz). 
synname(scøts,schiøtz). 
synname(scøtz,schiøtz).

synname(semtral,sentral).  
synname(semtru,sentrum).  
synname(semtrum,sentrum). 
synname(semtrun,sentrum).   %% 
%% synname(senter,sentrum).    %% bønes senter
synname(sentere,senter).  
synname(sentere,senteret). 
synname(senteret,senter). 
synname(sentr,sentrum). 
synname(sentralst,sentralstasjon).  
synname(sentralsta,sentralstasjon).   
synname(sentralststasjon,sentralstasjon). 
synname(sentrstasjon,sentralstasjon). 
synname(sentralststajon,sentralstasjon).       %%  ?
synname(sentralststajonen,sentralstasjonen).   %%
synname(sentralterminal,sentrumsterminalen).   %%  ?
synname(sentralterminalen,sentrumsterminalen). %%
synname(sentri,sentrum).  
synname(sentru,sentrum). %% avoid =senter
synname(sentrumsentrum,sentrum). 
synname(senum,sentrum).  
synname(setrm,sentrum).  

synname(shiotz,schiøtz). 
synname(shøts,schiøtz).   
synname(shøtz,schiøtz).   
synname(sjøts,schiøtz).   
synname(sjøtts,schiøtz). 
synname(sjøttz,schiøtz). 
synname(sjøtz,schiøtz).  
synname(skjøtts,schiøtz). 
synname(skjøttz,schiøtz). 

synname(skol,sk).
synname(skole,sk). 

synname(skoe,skole). 
synname(skolemester,skolemesters). 
synname(skolen,skole). 
synname(skoler,skole). 
synname(skolesenter,skole). 

synname(snerum,sentrum).
synname(snetere,senter).  
synname(sneteret,senteret). 
synname(snetret,senteret). 
synname(snetrum,sentrum).  
synname(sneturm,sentrum). 

synname(snpl,endehpl).  
synname(snpl,endeholdeplass). 
synname(snpl,snuplass). 

synname(sntret,senter).  
synname(sntret,senteret).

synname(shoppingsenter,butikksenter).
synname(shoppingsenter,kjøpesenter). 


synname(sid,syd). 
synname(siti,city).  
synname(sityd,syd).   


synname(sjukehus,hospital).
synname(sjukehuset,sykehuset).

synname(skelves,skjelves). 
synname(sjelves,skjelves). 
synname(sjetlein,skjetlein).
synname(skol,skole). 
%% synname(smstuc,bustuc).

synname(snton,anton).  

synname(snuholdeplass,snuplass). 
synname(snuholderplass,snuplass). 

synname(snuplass,endehlp). %% etc 
synname(snuplass,endehpl).

synname(sole,skole).         %% //  -> Skole 

synname(solem,solems).  %% avoid solem -> skole
synname(soli,solli).    %% < 5 ch 
synname(sor,sør). 

synname(srundentby,studentby). 
synname(st,stasjon).
synname(stj,stasjon).  
synname(stabels,stabells). %% \+ Stavne %% amble#
synname(stablers,stabells). 

synname(stad,stadion). %% amb sted %% TA-110309

synname(stadium,stadion).   
synname(stadsingenjør,stadsingeniør). 
synname(stadsingengjør,stadsingeniør). 

synname(stadjo,stadion). 
synname(stadsinginør,stadsingeniør). 
synname(stadtingeniør,stadsing).

synname(stasj,stasjon). %% ? stasjonen / TS ? 

synname(statingeniør,stadsingeniør). 
synname(staton,stadion). %% TA-110406
synname(statsingeniør,stadsingeniør). 
synname(statsinginør,stadsingeniør).  

synname(statsion,stasjon). 
synname(statsjon,stasjon). 

synname(stavels,stabells). 

synname(stby,studentby).  
synname(stduntby,studentby). 
synname(steentby,studentby).          %%  ?
synname(steina,steinan).  
synname(stre,østre). %%  Ø-trøbbel
synname(strastasjon,stasjonen).   %%  // stasjon=noun
synname(studeby,studentby).  
synname(studneby,studentby). 
synname(studntbi,studentby). 
synname(studntby,studentby). 
synname(stud,student).  
synname(studby,studentby).
synname(studenby,studentby). 
synname(studentcity,studentby).
synname(studentbolig,studentby). 
synname(studentboliger,studentby).
  
synname(studentboliger,studentby).  
synname(studentboliger,studentbyen). %% 
synname(studenterhjem,studentby). 
synname(studentet,studenter).  
synname(studnby,studentby).  

synname(studne,student). 
synname(sud,syd).  
synname(sumtrum,sentrum). 
synname(sy,syd).  
synname(sydd,syd).
synname(syde,syd). 
synname(syn,syd). 
synname(sykehjemm,sykehjem).
synname(sykehus,hospital).  
synname(sykehusområdet,sykehuset). 
synname(sys,syd).  
synname(syt,syd).  
synname(syvende,viis).  %% H7
synname(syvendes,viis). %% TA-110203
synname(sæntrum,sentrum). 
synname(sæmtrum,sentrum).

synname(søre,søndre). 

synname(tambars,tambarskjelves).  
synname(tambarskjelds,tambarskjelves). 
synname(tambarskjold,tambarskjelves). 
synname(tambarskjolds,tambarskjelves). 
synname(tambarselves,tambarskjelves).  
synname(tambartselves,tambarskjelves). 
synname(tabarskjeves,tambarskjelves).  
synname(tambarskjel,tambarskjelves).  

synname(tambergskj,tambarskjelves).    
synname(tambeskjells,tambarskjelves).  

synname(tabarskjelvs,tambarskjelves). 
synname(tabarsjelves,tambarskjelves). 
synname(taberskjelvesgate,tambarskjelvesgate).
synname(tambarselves,tambarskjelves). 
synname(tamberselves,tambarskjelves).  
synname(tamberskjelv,tambarskjelves).
synname(tamberskjelves,tambarskjelves). 
synname(tambeskjelvs, tambarskjelves). 
synname(tamberselvs,tambarskjelves).  
synname(tambergselvs,tambarskjelves). 
synname(tambursjelves,tambarskjelves). 
synname(tamburskjelves,tambarskjelves).
synname(tambarseters,tambarskjelves).
synname(tamburseters,tambarskjelves). 

synname(tarne,tårnet).

synname(teab,team). %%  ?
%% synname(teams,team). %% confuse teams ruteopplysning %% ad hoc 

%% synname(tem,team).  %% TA-101124


%% synname(tempeveien,tempevegen). %% unnec
  %% Tempevegen 11 // station 
  %% Tempeveien 11 // street  -- Valøyvegen


synname(terase,terrasse).  
synname(terasse,terrasse). 
synname(term,terminalen). 
%% synname(terminal,terminalen). %%  

synname(thulauw,thaulow).  

synname(thallauw,thaulow). 
synname(tauwlovt,thaulow).
synname(thawløv,thaulow).
synname(thawløv,thaulow).


synname(theim,trondheim).  
synname(th,thonning). 
synname(thoning,thonning).  
synname(thonnig,thonning).  
synname(thonig,thonning). 
synname(thonin,thonning). 
synname(thærnes,thornæs). 
synname(threim,trondheim). 


synname(tiedemanns,tidemands). %% etc 

synname(tilfredsheten,tilfredshet). 
synname(tilfredshetens,tilfredshet).

%% synname(tina,gina). %% haz Tine

synname(togbane,jernbane). 
synname(togbanen,jernbanen). 
synname(tonheim,trondheim).  
synname(tonstad,thonstad). 
synname(tora,thora).  
synname(tord,torg). %% neib %% TA-110527
synname(torne,tårnet). 
synname(torp,torps).  %% TA-110701
synname(torve,torget).        %% nec ???
synname(traverbane,travbane).
synname(trd,trondheim).  
synname(treminal,terminal).  %% TA-110624
synname(trheim,trondheim). 
synname(trlg,trøndelag). 
synname(trnheim,trondheim). 
synname(trodneheim,trondheim). 
synname(trodnehim,trondheim).  
synname(troendelag,trøndelag). 
synname(trog,torg).    
synname(tromheim,trondheim). 
synname(tron,trondheim).  
synname(trondheims,trondheim).  %% T -senterum/ ST ?
synname(trondehiem,trondheim).  

synname(troning,thonning).  
synname(tronningens,dronningens).  
synname(tronndheim,trondheim). 
synname(trove,torget). 
synname(trånheim,trondheim).
synname(trånnhjæm,trondheim).  
synname(tudentby,studentby). 
synname(tune,tunet).  
synname(tårn,tårnet).  

synname(ungdomskle,skole).  
synname(ungdomskole,skole).  
synname(ungdomskule,skole).   
synname(ungdomskule,ungdomskole). 
synname(ungdomskle,ungdomskole).  
synname(ungdommskole,ungdomskole).  
synname(ungdommsskole,ungdomskole). 
synname(ungdommskole,skole).  
synname(ungdommsskole,skole). 
synname(ungdonskole,skole). 
synname(ungdoskole,skole).  
synname(ungsommskole,skole). 

synname(unnset,undsets).  

synname(us,skole). %% ungdomskole 

synname(vdg, videregående). 
synname(vdrg, videregående).
synname(vderegåen,  videregående).

synname(ventrum,sentrum).    %% ? SMS tab
synname(verg,berg). %% ?
synname(vesnet,vesenet).  
synname(vesr,vest).   
synname(victor,viktor).
%  synname(victoria,viktoria).   

synname(vid, videregående).   
synname(vidregaende, videregående). 
synname(vidregåenda, videregående). 
synname(vidregåene, videregående). 
synname(videreg, videregående).  
synname(vidreående, videregående). 
synname(vidregåendeskole, skole). 
synname(videreående, videregående).
synname(videregåene, videregående). 
synname(vigeredående, videregående).
synname(vidergåande, videregående).  

%%       synname(viktoria,victoria). %% bachke why nec
synname(vgd, videregående). 

synname(vdg,sk).   
synname(vga,sk). 
synname(vgd,sk).    %%
synname(vgs,sk).    %% Technical
synname(vs,sk).     %% TA-110121

synname(vdg,skole).   
synname(vga,skole).  
synname(vgd,skole).  
synname(vgs,skole).    %% Tiller vgs 
synname(vs,skole).     %% TA-110121

%% synname(vgskole, skole). %% no, jfr  byåsen vgs \= byåsen skole
%% synname(vidregåendeskole,skole). 
%% synname(videregående,skole). %% heimdal videregående 

synname(vidregåemde, videregående). 
synname(viktor,victor).
synname(vru,bru). 
synname(vskole,skole). 

synname(waldermars,waldemar).
synname(wiedemann,weidemanns). %% dbl 
synname(wm,vm). %% -anlegget

synname(yd,syd).           %% TA-110318
synname(ykehjem,sykehjem). 
synname(yngvald,ingvald). 
synname(yngvar,ingvald).   %% ystgård 
synname(yngvar,ingvar).    %%

synname(zity,city).   
synname(zyd,syd).

synname(øfstiens,øfstis). 
synname(ørre,østre).
synname(ørre,øvtre).
synname(øvr,øvre).  
synname(øvre,østre). %% Hazard ?

synname(øste,østre).
synname(østmarken,østmarka).

synname(østre,øvre).
synname(øtre,østre).

synname(øysteins,øystein). 
synname(øystein,øysteins).

synname(åes,aaes).  
synname(åses,åsas).  
synname(ålle,alle).     %%   àlle
synname(åsta,aasta).  
synname(åøysteins,øysteins).  %%  Ø-trøbbel Ã¸ysteins .


synname(fegslet,fengselet). 
synname(fengs,fengsel).  
synname(fengs,fengselet).  
synname(fengse,fengselet). 
synname(fengslet,fengselet).


synname(ferge,ferje).          %% reflexiv syn,
synname(fergeleie,ferjeleie).  %% no haz

synname(ferje,ferge).  
synname(ferjeleie,fergeleie).  

synname(carl,karl). %% jonssons  // no recursion

synname(centeret,senteret). 
synname(centrum,sentrum).
synname(cesile,cecilie). 
synname(cntrum,sentrum).
synname(centum,sentrum).  
synname(central,sentrum). %%  Engl

synname(cty,city).   

synname(engelbretssons,engelbrektssons).  
synname(engelbrekstons,engelbrektssons). 
%% synname(entre,alle).  %% actual Lade e..
synname(entret,sentret).   
synname(enteret,senteret).   
synname(entrum,sentrum). 

synname(fhs,skole). %% folkeh.s  %%   rough
synname(flyplassen,flyplass). 
synname(flypassen,flyplass).  
synname(folkebiblioteket,biblioteket).

%% synname(folkehøgskole,skole).    %% folkeh.s. %% too special
%% synname(folkehøgskule,skole).    %%  (if not defined)
%% synname(folkehøyskole,skole).    %% folkeh.s.

synname(fotballbane,idrettsplass). %% Ranheim 

synname(folkemsuem,folkemuseum).

synname(gammel,gamle). 
synname(gård,gården). 
synname(gården,gård). 

synname(gård,herregård). 

synname(henr,henrik).  
synname(herregård,gård).  
synname(hotel,hotell).   



synname(hj,hjalmar).  
synname(hostpital,hospital). 
synname(fabr,fabrikk).     
synname(fabr,fabrikker).  
synname(fabrikk,fabrikker). 
synname(fabrik,fabrikk). 
synname(fabrikk,fabrikker). 
synname(fabrik,fabrikker).  
synname(fabrikken,fabrikker). %% ranheim fabrikken %% TA-110520

synname(falkbergs, falkbergets).  
synname(falkesbergs, falkbergets).  
synname(falkberget, falkbergets).    %%  NEC ?
synname(falkenbergs, falkbergets).  
synname(falkenbergets, falkbergets). %% NEC
synname(falkenberget, falkbergets).  %%

synname(butikksenet,butikksenter). 
synname(butiksenter,butikksenter). 
synname(butikksenter,senter).  
synname(butikksenteret,senter).

synname(buttiksenteret,butikksenter). 

synname(bård,baard).       %%  B iversen

synname(karj,karl). %% .. joh...
synname(karl,carl). %% johan     // OK 
synname(kasper,casper). 

synname(himelfart,ascension_day).   %% English name 
synname(himmelfart,ascension_day).  %% 

synname(kr,kristi).  
synname(himmelf,himmelfarts). 
synname(hyen, byen).  
synname(kristihimmelfartsdag,ascension_day).  
synname(kristihimmelfartsdagen,ascension_day).
synname(kristhimmelfartsdag,ascension_day).  

synname(th,trondheim).  
synname(trh,trondheim). 

synname(aentrum,sentrum). 

synname(asb,asbjørn).  
synname(asbjørns,asbjørnsens). 
synname(ass,aas).               %% Ingeborg Aas

synname(asta,aasta).

synname(astrom,astronom).

synname(granasen,granåsen).     %% for partname 
synname(granskogen,granåsen).   %% ???

synname(granåsenlia,granåslia). %% street


synname(istgårds,ystgaards).   
synname(istgaards,ystgaards).  

synname(ystergaards,ystgaards). 
synname(vgws, skole).           %%  v.. skole

synname(sentrumholdeplassene,hovedterminalen). 
synname(sentrumsholdeplassene,hovedterminalen). 

%% synname(senter,senteret). %% TA-101228

synname(sentret,senter).  
synname(sentret,sentrum). 
synname(senteret,sentrum). %% 
synname(semtral,sentrum).  %%  ?
synname(sentral,sentrum).
synname(sentret,senteret). %% OK, no 
synname(senteret,sentret). %% recursion  
synname(senrtrom,sentrum).
synname(senrter,senter). 
synname(senrter,senteret).
synname(seteum,sentrum).

synname(stajasion,stasjon). 
synname(svngen,svingen). 

synname(æstre,østre).  



%% SAMENAME  %% (partname) with spell


samename(barfaøtts,berrføtts). %% TA-110317 
samename(gledish,gleditsch). 
%    synname(gledish,gleditsch). 
%    synname(gletish,gleditsch).

samename(halfred,hallfred). %% TA-101018

samename(sandfundet,samfundet). %% TA-110314

samename(svinestien,vollabakken). %% Experiment 

samename(tambardkjelvsgate,tambarskjelvesgate). %% NEC %% TA-101004

samename(tambaskjelvs,tambarskjelves). 

samename(tambarselve,tambarskjelves).   

%    synname(tambarselve,tambarskjelves).  
%    synname(tambasjelvs,tambarskjelves). 
%    synname(tamberbergsjelves,tambarskjelves).
%    synname(tamberbergskjelves,tambarskjelves).

samename(tambarskjelve,tambarskjelves).  
%    synname(tambarkjeves,tambarskjelves).  

samename(tiedemanns,tiedemands). 

samename(øftis,øfstis). %%  Ã¸ftis = aøftis  %% TA-110324

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  Unwanted names regardless of domain


unwanted_name(anette). %%  \+ Aunet 
unwanted_name(antok).  %% \+ Anton (nec???) 
unwanted_name(arbeidsbuss). 
unwanted_name(astor).  %% \+ astri %% TA-110609
unwanted_name(baghera). 
unwanted_name(baller). %%  \+ bagler-
unwanted_name(balls).  %%  \+ Bulls 
unwanted_name(banke).  %%  \+ slå 
unwanted_name(bedring). %% \+ Beddingen %% TA-101120
unwanted_name(been).   %%  \+ byen Eng, confuse
unwanted_name(begge).  
%%  unwanted_name(bohus). %%  \+ båhus(gate)
unwanted_name(brann).   %%  Buran 
unwanted_name(brenner). %%  \+ Brænne 
unwanted_name(buksa).   %%  \+ bukta (station) 
unwanted_name(bus).     %%  \+ Buås
unwanted_name(busen).   %%  \+ Buås 
unwanted_name(bussen).   
%% unwanted_name(bye).   %%  Good Bye  %%  E: destroys lang sel.
unwanted_name(bærs).  %%  \+ berg   
unwanted_name(bæsj).  %%  \+ byes ??? 
unwanted_name(car).   %%  \+ Carl

unwanted_name(dens).
unwanted_name(dennes).
unwanted_name(deres).
unwanted_name(dets).
unwanted_name(dettes).
unwanted_name(din).
unwanted_name(dine).
unwanted_name(dit).     
unwanted_name(ditt).
unwanted_name(dollar). % dolpa 
unwanted_name(dritt). %%  \+ dist 
unwanted_name(dust). 
unwanted_name(døden). %%  \+ doden -> domen
unwanted_name(door).  %%   \+ Dora
unwanted_name(doors).
unwanted_name(dvs). %% DV's (dragvoll)

unwanted_name(ei).
%% unwanted_name(ekkle).  %% TA-101108 
unwanted_name(elev). 
unwanted_name(eline).  %% \+ einer 
unwanted_name(en).
unwanted_name(eple).   %%  \+ Ekle %% TA-101108
unwanted_name(et). 
unwanted_name(ett). 
unwanted_name(etter).  %% s etter = s enter = senter 
unwanted_name(every).  %%  E-verket 

unwanted_name(fatass).  %% \+ Flatas 
unwanted_name(forstå).  %% Forset 
unwanted_name(forstås). %% Forset %% TA-101102

unwanted_name(fylla).  %%  \+ Follo
unwanted_name(fordi).  %%  \+ fjord
unwanted_name(første). %%  \+ Forset

unwanted_name(gang).    %%   gang -> gan-g -> granveien
unwanted_name(gidder). 
%%  unwanted_name(går).   %%   -> unwanted_place??? English  går buss 5 til nardo? 

unwanted_name(har). 

%%  unwanted_name(hans). % hans finnes gate

unwanted_name(havne). 
unwanted_name(havnet). %% arrived
unwanted_name(havnet). %% arrives
unwanted_name(helen).   %% \+ helse 
unwanted_name(hembres). %% + Hambros   amble# 
unwanted_name(henge).   %% \+ Hemne amble# 
unwanted_name(hennes).
unwanted_name(hente).  %% \+ Hemne 
unwanted_name(hair).    %%  \+ hare
unwanted_name(hallo).   %%  \+ hall
unwanted_name(hello).
unwanted_name(hilde).   %%  holde 

unwanted_name(happens). %%  -> hapen -> hagen %%  amble# 
unwanted_name(happend). %%  -> hapen -> hagen %%  amble# 

unwanted_name(hjem). 
unwanted_name(heim). 
unwanted_name(heime).   %% 
unwanted_name(hjemme).  %%  \+ hemne
unwanted_name(homo).    %%  \+ hoem 
unwanted_name(homse).   %%  \+ hoems 
unwanted_name(homsen).  %% 
unwanted_name(homser).  %%
unwanted_name(homsen).  %%
unwanted_name(hommse).   %%  \+ hoems 
unwanted_name(hommsen).  %% TA-110307
unwanted_name(hommser).  %%
unwanted_name(hommsen).  %%

unwanted_name(hore).    %%  \+ hoem 
unwanted_name(hval).    %%  \+ hall 
unwanted_name(hvem).    %%  \+ hoem | heim (Eng) 
unwanted_name(høyst).   %%  \+ høiset 
unwanted_name(håret).   %%  \+ hare,havre

unwanted_name(informasjon). 
unwanted_name(islam).  %% \+ Isdam- 

unwanted_name(jul).     %%  \+ july
%% unwanted_name(kampen).  %%  \+ kammen (street) 
unwanted_name(kanin).   %%  \+ kaien %%  amble#
unwanted_name(karsk).   %%  \+ karse-(vegen)

unwanted_name(kinon). %% cinema 

%%%% unwanted_name(kiosk).   %%  \+ kinos(enter) Amble#

unwanted_name(kjønn).   %%  \+ kong  amble# ???
unwanted_name(knull).   %%  \+ knut 
unwanted_name(kommer).  %%  \+ komet 
unwanted_name(kontor). 
unwanted_name(kysse). 
unwanted_name(lagt).   %%   lian_street :-)
unwanted_name(land).  
unwanted_name(legger). %% \+ lege %% TA-110429
unwanted_name(lenge).  %% \+ lege
unwanted_name(lærer). 
unwanted_name(min).
unwanted_name(mine).
unwanted_name(mitt).
unwanted_name(mårra).  %%  \+ marka


unwanted_name(langt).   %%  \+ lianveien (gt)
unwanted_name(langø).   %%  \+ Langlo ( Fotograf)
unwanted_name(lasso).   %%  \+ lars
unwanted_name(linda).   %%  \+ Lian  amblehash
unwanted_name(låne).    %%  \+ lian/lade 
%%  unwanted_name(mari).    %%  \+ Mars %%  Mari(e) Sørdal
unwanted_name(married). %%  \+ marie
unwanted_name(maur).    %%  \+ mars
%% unwanted_name(maxi).    %%  \+ main %% < 5 letter 
unwanted_name(mens).  
unwanted_name(mensen).  %% 
unwanted_name(moret).   %% \+ Møre 

%% unwanted_name(norges).  %% experiment spellcheck *-> norge
unwanted_name(node).    %%  \+ nord (knutepunkt) 
unwanted_name(og).      %%  \+ osveien|g(aten) 
unwanted_name(og). %% \+ os ? 
unwanted_name(person). %%  Persson? 
unwanted_name(please). %%  place... %%  amble#
unwanted_name(pluss).  %% \+ plass
unwanted_name(vre). 
unwanted_name(værte).  %% \+ Være 
unwanted_name(vøstre). %% confuse
%% unwanted_name(vår). %% Vår Frue(s) gate/strete
unwanted_name(våre). 
unwanted_name(oss).     %%  \+ os 
unwanted_name(osv).     %%  \+ osveien
unwanted_name(ozon).    %%  \+ Osen 
unwanted_name(pilen).   %%  \+ Piren 
%%  unwanted_name(pinsen).  %%  \+ Prinsen  // Pinsen kino 
unwanted_name(pirrer).  %% \+ piren 
unwanted_name(pule).    %%  \+ paul
unwanted_name(pult).    %%  \+ paul 
unwanted_name(query).   %%  \+ kvern (Eng/No) 

unwanted_name(saft).     %%  \+ samf
unwanted_name(salt).   
unwanted_name(samleie).  %%  -> samle -> svale
unwanted_name(sammen).  
unwanted_name(sammleie).
unwanted_name(sang).     %%  \+ sandgata 
unwanted_name(sats).     %%  \+ SAS,stat 
unwanted_name(science).  %%  -> sjense -> sjetne (amble#)
unwanted_name(sende).    %%  \+ Stene
unwanted_name(sender).   %%  \+ senter 
unwanted_name(sendte).   %%  \+ Stene
unwanted_name(senere).   %%  \+ senter
unwanted_name(senest).   
unwanted_name(setter).   %%  \+ senter 
unwanted_name(shorts).   %%  \+ schiøtz (SIC) 
unwanted_name(spion).    %%  \+ simon,zion  
unwanted_name(sjansen).  %%  \+ Skansen 
unwanted_name(skit).     %%  \+ ski
unwanted_name(skjema).   %%  \+ Skjermveien 
unwanted_name(skjult).   %%  \+ schultz 
unwanted_name(skrue).    %%  \+ skule 
unwanted_name(sluppet).  %%  \+ Sluppen
unwanted_name(sprit).    %%  \+ sport
unwanted_name(stemme).   %%  \+ Stene
unwanted_name(stops).    %%  \+ STPS (S-T psyk syk) 
unwanted_name(sterk).    %%  \+ sæter
unwanted_name(stjerne).  %%  \+ Sjetne (amble#)
%% unwanted_name(stratos).  %%  \+ staton ? %% TA-110406 unnec
unwanted_name(strengt).  %%  \+ Stareveien ( Staregt) %% amble#
unwanted_name(strh).     %%  \+ stor   ( strindheim ? ) no mess 
unwanted_name(strøm).    %%  \+ storm
unwanted_name(støtte).   %%  \+ sorte (amble#)
unwanted_name(sv).       %% streetsyn \+ Sve 
unwanted_name(søtre).    %%  Ambiguous søndre/østre
unwanted_name(tater).    %%  \+ teater 
unwanted_name(stjele).   %%  \+ selje
unwanted_name(there).    %%  \+ tore (Eng.) 
unwanted_name(thanks).   %%  \+ tank 
unwanted_name(thing).    %%  \+ ting 
unwanted_name(tingt).    %%  \+ tinggt
unwanted_name(torstein). %%  ? w(torstein,[name(tonst,n,0),name(torps,n,0),name(tors,n,0)])
unwanted_name(tosk). 
unwanted_name(trine).    %% \+ Tine
%% unwanted_name(trusa). 
%% unwanted_name(trusen). 
unwanted_name(tryne).   %% \+ Trane %% TA-110401
unwanted_name(unik). 
unwanted_name(verdt).   %%  \+ vest
unwanted_name(vinner).  %%  \+ vinter
unwanted_name(which).   %%  \+ Vika Amblehash/TSX 
unwanted_name(åberg).   %%  \+ åkerg(ata) 

%%  streetsyn ADDED to names.pl  

%% NB The s-forms come first

%% Granåsvegen -> Granåstreet  OK, even if this is incorrect in this case
%% ranheimsvegen = ranheimvegen ==> ranheimstreet

%% These are user related synonyms of street suffix
%% The synonyms for processing route tables are more stringent (only actual)

%% streetsyn(alle).   %%  lade alle \== lade()veien //
                      %%leangenveien\= leangen alle
%%%  streetsyn(ate).  %% gate ? %% NO!  tambardkjelvsgate\=  tambardkjelvsg+ate TA-101004
%% streetsyn(agte).   %% gate  
streetsyn(beg).       %% neib k
streetsyn(bei).       %%
streetsyn(begen). 
streetsyn(beien). 
streetsyn(bgate). 
%% streetsyn(date).  %% skal vi dra på date? 
streetsyn(eien).  %%  ?  Byåseien 
streetsyn(evg).  
streetsyn(evi).    %%  ? nec?

streetsyn(ft).   %% TA-101221 %%gt ? 

%% 

streetsyn(g). %% TA-110204 dronningens g 
    %%  Kong (Inges ..) Stadsing. // Håkon Magnussons g 3//
    %%  Fjordg. 25  
    %% Rosenbor(g) OK
    %% EXPERIMENT                   %% string -> strindveien


%% streetsyn(ga).  %%  Tunga \= Tunveien
streetsyn(gaate).
streetsyn(gatte). %% TA-101129 
streetsyn(gade).  
streetsyn(gaden).  %% 
streetsyn(gat). 
streetsyn(gata).
streetsyn(gatan). 
streetsyn(gate).
streetsyn(gatee). %% TA-101117
streetsyn(gaten).
streetsyn(gatene). 
streetsyn(gater). 
streetsyn(gates).
streetsyn(gats). 
streetsyn(gave).
streetsyn(gayte). %% gÃ¥te 
streetsyn(geven).
streetsyn(gste).
streetsyn(gt).
streetsyn(gta). 
streetsyn(gtate). 
streetsyn(gte). 
streetsyn(gtn).  
streetsyn(gtr). 
streetsyn(gåte). 
streetsyn(gy). %%  neib 

%% streetsyn(sveien). %%  blocks osveien 

%% streetsyn(u).   %%  ? Klabu -> Klæb v ***

streetsyn(uegen).
streetsyn(v).      %% OOPS olav --> ola(street) ! Yggdrasilv
streetsyn(vag).  
streetsyn(vaien). 

%% streetsyn(ve).     %% Ringve 10 = Ringveien 10 ?? %% ? Haz

streetsyn(vedi).      %% v ed i    
streetsyn(veeien).
streetsyn(vegdn).  
streetsyn(vegegen).
streetsyn(veggen).  %% TA-101118
streetsyn(veein).   %% spell
streetsyn(veen).    %% spell
streetsyn(vef). 
streetsyn(vefen).  
streetsyn(veg).
streetsyn(vege).  
streetsyn(vegem).  
streetsyn(vegen).
streetsyn(vegenn).
streetsyn(vegene). 
streetsyn(vegein). 
streetsyn(veger). 
streetsyn(veget).  
streetsyn(vegg).  %%  ?
streetsyn(vegn).  
streetsyn(vegom). 
streetsyn(vegrm). %% dbl neib 

streetsyn(veh).   
streetsyn(vei).
streetsyn(veid).  
streetsyn(veie).   
streetsyn(veieb). 
streetsyn(veiebn).  
streetsyn(veieen). 
streetsyn(veiein). 
streetsyn(veiem).   %%  sp
streetsyn(veien).
streetsyn(veienm).  %% slip 
streetsyn(veienen). %%  sp 
streetsyn(veienn).  %%  sp
streetsyn(veiene).  
streetsyn(veient).  %% il sentrum 
streetsyn(veig).  
streetsyn(veigen).  
% streetsyn(veiget).  %% ?
streetsyn(veii). 
streetsyn(veiien). 
streetsyn(veil).    %% Spell
streetsyn(vein).    %% Spell
streetsyn(veine).   %% spell
streetsyn(veinen).  %% spell 
streetsyn(veiene). 
streetsyn(veier).  
streetsyn(veieu). 
streetsyn(veirn).  %% TA-110330
streetsyn(veis). 
%% streetsyn(veio).    %% slip  Sveio neib
streetsyn(veit). 
streetsyn(veiu).    %% slip
streetsyn(vej). 
streetsyn(vel). 
streetsyn(venen).   %% spell 
streetsyn(veneien). %% spell 
streetsyn(venein).  %% spell 
streetsyn(venien).  %% spell 
streetsyn(veo).  

%% streetsyn(vet).     %%  know %% TA-110530 Hazard
                       %% confuse implicitq
streetsyn(veu). 
streetsyn(veuen).  
streetsyn(veuien). 
%% streetsyn(veveien). %%  ?? + strandveveien / - volveveien
streetsyn(vey). 
streetsyn(veyen).  
streetsyn(veyein). 
streetsyn(vg).
streetsyn(vgn).  
streetsyn(vgen).  
%% streetsyn(vi).      %% ?? sp haz ? %% (until next occ)
%% streetsyn(via).     %% ?? actual  haz 
streetsyn(vie).  
streetsyn(vien).    %% \+ Vigen
streetsyn(vig).     %% ?
streetsyn(vn).
streetsyn(vrg).     %% neib 
streetsyn(vweien).  %% slip 
streetsyn(vwgen). 
streetsyn(vwien).   %% slip  
streetsyn(væg). 
streetsyn(vægen).  




%% streetsyn(sg).
%% streetsyn(sgata).
%% streetsyn(sgate).
%% streetsyn(sgaten).
   streetsyn(sgt).    %%  haakon 7 sgt.23 .
%% streetsyn(sv). 
%% streetsyn(sveg).
%% streetsyn(svegen).
%% streetsyn(sveien).
   streetsyn(svei).   %% Paul Fremstad svei 
%% streetsyn(svg).
%% streetsyn(svn).



% Countries  (European first)

 country(albania).
 country(arabia). 
 country(belgia).  
 country(bermuda). %% TA-101122
 country(bosnia). 
 country(danmark). country(denmark).
 country(england).         %% not formally a country  
 country(estland). country(estonia).
 country(finland).   country(finnland). 
 country(frankrike).  country(france). 
 country(georgia). 
 country(greece). 
 country(hellas).  
 country(irak).
 country(irland).  
 country(italia).  
 country(island).
 country(jugoslavia).  country(yugoslavia).
 country(lichtenstein). 
 country(latvia).       %% TA-110110
 country(litauen).      country(lithuania).  
 country(malta).  
 country(marokko).  
 country(mexico). 
 country(montenegro). 
 country(norge). country(norway).    %%   s y n w o r d norway ?
 country(peru). 
 country(polen). country(poland). 
 country(portugal). 
 country(romania). 
 country(russland).
 country(serbia).
 country(skottland). country(skotland).  country(scotland).
 country(slovakia).
 country(spania). country(spain). 
 country(sveits). 
 country(sverige). 
 country(sweden). %% \+ smeden
 country(tunisia). 
 country(tyskland). country(germany). 
 country(ukraina).  
 country(ungarn). 
 country(vatikanstaten). 

% Non European countries

 country(bakvendtland).    %%  :-)
 country(langtvekkistan).  %%  :-)

 country(afghanistan).  country(afganistan).
 country(angola). 
 country(australia).
 country(botswana).
 country(brasil).  country(brazil).
 country(burma). 
 country(bhutan). 
   country(butan).

 country(canada). 
 country(chile). 
 country(china).  country(kina).  
 country(cuba).
 country(egypt). 
 country(etiopia). 
 country(ghana).   
 country(guatemala).
 country(india). 
 country(israel). 
 country(japan).  
 country(kambodsja).
 country(kenya).  
 country(kongo). 
 country(korea). 
 country(kurdistan).
 country(malaysia).
 country(mocambique). 
 country(mongolia).
 country(nigeria).
 country(pakistan). 
 country(somalia). 
 country(sudan). 
 country(syria).
 country(thailand). 
 country(turkmenistan). 
 country(tyrkia).
 country(uganda).  
 country(uruguay). 
 country(usa).
 country(uzbekistan). 
 country(zambia).  
 country(zimbabwe).  


abroad(afrika). 
abroad(amerika). 
abroad(amsterdam). 
abroad(andeby). 
abroad(ankara). %% TA-101012
abroad(asia). 
abroad(aten). 
abroad(athen). 
abroad(atlanta). 
abroad(bagdad). 
abroad(baghdad). 
abroad(bali). 
abroad(bangkok). 
abroad(barcelona). 
abroad(beijing). 
abroad(bejing). 
abroad(berlin). 
abroad(betlehem). 
abroad(bilbao). 
abroad(blokksberg). 
abroad(bloksberg). 
abroad(bratislava). 
abroad(bristol). 
abroad(brugge). 
abroad(budapest). 
abroad(calcutta). 
abroad(california). 
abroad(cambridge). 
abroad(chicago). 
abroad(copenhagen). 
abroad(delfi). 
abroad(delft). 
abroad(new_delhi). %% TA-110603
abroad(delphi). 
abroad(detroit). 
abroad(dover). 
abroad(dubai). 
abroad(dublin). 
abroad(eiffeltårnet). 
abroad(eu).
abroad(europa). 
abroad(evigheten). 
abroad(frankfurt). 
abroad(fredrikshavn). 
abroad(gibraltar). 
abroad(glasgow). 
abroad(grønland).     %% official
%% abroad(grønnland). %%  (country)
abroad(gøteborg). 
abroad(haag).  %% den Haag
abroad(hamburg). 
abroad(heathrow). 
abroad(helsinki). 
abroad(himalaya). 
abroad(holland).  
abroad(hollywood). 
  abroad(holywood). 
abroad(hongkong). 

abroad(huttheita). %%:-) ..
abroad(huttheita). 
abroad(huttaheiti). %% TA-101020
abroad(huttuheita).
abroad(huttiheita).
abroad(huttuheita). 

abroad(islamabad). 
abroad(istanbul). 
abroad(jan_mayen). 
abroad(johannesburg). 
abroad(jupiter). 
abroad(jønkøping). 
abroad(kabul). 
abroad(kairo). 
abroad(kanariøyene). 
abroad(karlstad). 
abroad(katmandu). 
abroad(kaunas). 
abroad(kiel). 
abroad(kiruna). 
abroad(kista).   %% Sv
abroad(kreml). 
abroad(kreta). 
abroad(kronborg).  
abroad(kualalumpur). 
abroad(københavn). 
abroad(kjøbenhavn). 
abroad(køpenhavn). 
abroad(køpenhamn). 
abroad(lahti). 
abroad(leeds). 
abroad(leipzig). 
abroad(liverpool). 
%% abroad(london). %% city London bridge %% TA-101129 
abroad(longyearbyen). 
abroad(los_angeles). 
abroad(luleå). 
abroad(madrid). 
abroad(malaga). 
abroad(mallorca). 
abroad(malmø). 
abroad(manchester). 
abroad(mars). 
abroad(maryland). %% TA-110326
abroad(mekka). 
abroad(melbourne). 
abroad(melkevegen).  %% :-)
abroad(melkeveien). 
abroad(minnesota). 
abroad(montana).  
abroad(moon). 
abroad(moskva). 
abroad(mumbay).   %% TA-110603 ?
abroad(murmansk). %% TA-110614
%% abroad(månen). 
abroad(nairobi). 
abroad(napoli). %% TA-101025 (restaurant)
abroad(nebraska). 
abroad(new_york). %% city %% TA-110603
abroad(nilen). 
abroad(nordpolen). 
abroad(norrtælje).  
   abroad(sødertælje). %% 
abroad(oklahoma).      %% TA-110328 ?
abroad(orknøyene).
abroad(osaka). 
abroad(oxford). %% TA-101122
abroad(paris). 
abroad(peking). 
abroad(pluto). 
abroad(praha). 
abroad(påskeøya). 
abroad(rhodos). 
abroad(rio). 
abroad(roma). 
abroad(roskilde). 
abroad(rovaniemi).  
abroad(sahara). 
abroad(salzburg).   %% TA-110620 
abroad(sankt_petersburg). %% TA-110614
abroad(santa_barbara). 
abroad(seattle). 
abroad(sheffield). 
abroad(sibir). 
abroad(singapore). 
abroad(skagen). 
abroad(skopje). 
abroad(southhampton). 
abroad(springfield). %% :-) Homer?
abroad(stanford). 
abroad(stockholm). 
abroad(strasbourg). 
abroad(strømstad). 
abroad(sundsvall). 
abroad(svalbard). 
abroad(syden). 
abroad(sydney). 
abroad(sydpolen). 
abroad(sørpolen). 
abroad(tallinn). 
abroad(texas). 
abroad(tokyo). 
abroad(toronto). 
abroad(tottenham).
abroad(tripoli). 
abroad(tripolis). 
abroad(tsjernobyl). 
abroad(turku). 
abroad(ucsb). 
abroad(ulanbator). 
abroad(umeå). 
abroad(uppsala). 
abroad(uppsalla). 
abroad(usa). 
abroad(utlandet). 
abroad(valencia). 
abroad(vancouver). 
abroad(venice).  
abroad(venezia).
abroad(venus). 
abroad(vladivostok). 
abroad(washington). 
abroad(wien).  %% TA-110501
abroad(århus). abroad(aarhus). 
abroad(ørebro).
abroad(øresund). 
abroad(østersund). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% FILE communities.pl
%% SYSTEM BUSSTUC
%% CREATED TA-080310
%% REVISED TA-080310

%% Norwegian communities (municipalities) and counties


community(agdenes, sør_trøndelag).
community(alstahaug, nordland).
community(alta, finnmark).
community(alvdal, hedmark).
community(andebu, vestfold).
community(andøy, nordland).
community(aremark, østfold).
community(arendal, aust_agder).
community(asker, akershus).
community(askim, østfold).
community(askvoll, sogn_og_fjordane).
community(askøy, hordaland).
community(audnedal, vest_agder).
community(aukra, møre_og_romsdal).
community(aure, møre_og_romsdal).
community(aurland, sogn_og_fjordane).
community(aurskog_høland, akershus).
community(austevoll, hordaland).
community(austrheim, hordaland).
community(averøy, møre_og_romsdal).
community(balestrand, sogn_og_fjordane).
community(ballangen, nordland).
community(balsfjord, troms).
community(bamble, telemark).
community(bardu, troms).
community(beiarn, nordland).
community(berg, troms). %% also station
community(bergen, hordaland).
community(berlevåg, finnmark).
community(bindal, nordland).
community(birkenes, aust_agder).
community(bjarkøy, troms).
community(bjerkreim, rogaland).
community(bjugn, sør_trøndelag).
community(bjørnøya, svalbard).
community(bodø, nordland).
community(bokn, rogaland).
community(bremanger, sogn_og_fjordane).
community(brønnøy, nordland).
community(bygland, aust_agder).
community(bykle, aust_agder).
community(båtsfjord, finnmark).
community(bærum, akershus).
community(bø, nordland).
community(bø, telemark).
community(bømlo, hordaland).
community(dovre, oppland).
community(drammen, buskerud).
community(drangedal, telemark).
community(dyrøy, troms).
community(dønna, nordland).
community(eid, sogn_og_fjordane).
community(eide, møre_og_romsdal).
community(eidfjord, hordaland).
community(eidsberg, østfold).
community(eidskog, hedmark).
community(eidsvoll, akershus).
community(eigersund, rogaland).
community(elverum, hedmark).
community(enebakk, akershus).
community(engerdal, hedmark).
community(etne, hordaland).
community(etnedal, oppland).
community(evenes, nordland).
community(evje_og_hornnes, aust_agder).
community(farsund, vest_agder).
community(fauske, nordland).
community(fedje, hordaland).
community(fet, akershus).
community(finnøy, rogaland).
community(fitjar, hordaland).
community(fjaler, sogn_og_fjordane).
community(fjell, hordaland).
community(flakstad, nordland).
community(flatanger, nord_trøndelag).
community(flekkefjord, vest_agder).
community(flesberg, buskerud).
community(flora, sogn_og_fjordane).
community(flå, buskerud).
community(folldal, hedmark).
community(forsand, rogaland).
community(fosnes, nord_trøndelag).
community(fredrikstad, østfold).
community(frei, møre_og_romsdal).
community(frogn, akershus).
community(froland, aust_agder).
community(frosta, nord_trøndelag).
community(fræna, møre_og_romsdal).
community(frøya, sør_trøndelag).
community(fusa, hordaland).
community(fyresdal, telemark).
community(førde, sogn_og_fjordane).
community(gamvik, finnmark).
community(gaular, sogn_og_fjordane).
community(gausdal, oppland).
community(gildeskål, nordland).
community(giske, møre_og_romsdal).
community(gjemnes, møre_og_romsdal).
community(gjerdrum, akershus).
community(gjerstad, aust_agder).
community(gjesdal, rogaland).
community(gjøvik, oppland).
community(gloppen, sogn_og_fjordane).
community(gol, buskerud).
community(gran, oppland).
community(grane, nordland).
community(granvin, hordaland).
community(gratangen, troms).
community(grimstad, aust_agder).
community(grong, nord_trøndelag).
community(grue, hedmark).
community(gulen, sogn_og_fjordane).
community(hadsel, nordland).
community(halden, østfold).
community(halsa, møre_og_romsdal).
community(hamar, hedmark).
community(hamarøy, nordland).
community(hammerfest, finnmark).
community(haram, møre_og_romsdal).
community(hareid, møre_og_romsdal).
community(harstad, troms).
community(hasvik, finnmark).
community(hattfjelldal, nordland).
community(haugesund, rogaland).
community(hemne, sør_trøndelag).
community(hemnes, nordland).
community(hemsedal, buskerud).
community(herøy, møre_og_romsdal).
community(herøy, nordland).
community(hitra, sør_trøndelag).
community(hjartdal, telemark).
community(hjelmeland, rogaland).
community(hobøl, østfold).
community(hof, vestfold).
community(hol, buskerud).
community(hole, buskerud).
community(holmestrand, vestfold).
community(holtålen, sør_trøndelag).
community(hopen, svalbard).
community(hornindal, sogn_og_fjordane).
community(horten, vestfold).
community(hurdal, akershus).
community(hurum, buskerud).
community(hvaler, østfold).
community(hyllestad, sogn_og_fjordane).
community(hå, rogaland).
community(hægebostad, vest_agder).
community(høyanger, sogn_og_fjordane).
community(høylandet, nord_trøndelag).
community(ibestad, troms).
community(inderøy, nord_trøndelag).
community(iveland, aust_agder).
community(jevnaker, oppland).
community(jondal, hordaland).
community(jølster, sogn_og_fjordane).
community(karasjok, finnmark).
community(karlsøy, troms).
community(karmøy, rogaland).
community(kautokeino, finnmark).
community(klepp, rogaland).
community(klæbu, sør_trøndelag).
community(kongsberg, buskerud).
community(kongsvinger, hedmark).
community(kragerø, telemark).
community(kristiansand, vest_agder).
community(kristiansund, møre_og_romsdal).
community(krødsherad, buskerud).
community(kvalsund, finnmark).
community(kvam, hordaland).
community(kvinesdal, vest_agder).
community(kvinnherad, hordaland).
community(kviteseid, telemark).
community(kvitsøy, rogaland).
community(kvæfjord, troms).
community(kvænangen, troms).
community(kåfjord, troms).
community(lardal, vestfold).
community(larvik, vestfold).
community(lavangen, troms).
community(lebesby, finnmark).
community(leikanger, sogn_og_fjordane).
community(leirfjord, nordland).
community(leka, nord_trøndelag).
community(leksvik, nord_trøndelag).
community(lenvik, troms).
community(lesja, oppland).
community(levanger, nord_trøndelag).
community(lier, buskerud).
community(lierne, nord_trøndelag).
community(lillehammer, oppland).
community(lillesand, aust_agder).
community(lindesnes, vest_agder).
community(lindås, hordaland).
community(lom, oppland).
community(longyearbyen, svalbard).
community(loppa, finnmark).
community(lund, rogaland).
community(lunner, oppland).
community(lurøy, nordland).
community(luster, sogn_og_fjordane).
community(lyngdal, vest_agder).
community(lyngen, troms).
community(lærdal, sogn_og_fjordane).
community(lødingen, nordland).
community(lørenskog, akershus).
community(løten, hedmark).
community(malvik, sør_trøndelag).
community(mandal, vest_agder).
community(marker, østfold).
community(marnardal, vest_agder).
community(masfjorden, hordaland).
community(meland, hordaland).
community(meldal, sør_trøndelag).
community(melhus, sør_trøndelag).
community(meløy, nordland).
community(meråker, nord_trøndelag).
community(midsund, møre_og_romsdal).
community(midtre_gauldal, sør_trøndelag).
community(modalen, hordaland).
community(modum, buskerud).
community(molde, møre_og_romsdal).
community(moskenes, nordland).
community(moss, østfold).
community(mosvik, nord_trøndelag).
community(målselv, troms).
community(måsøy, finnmark).
community(namdalseid, nord_trøndelag).
community(namsos, nord_trøndelag).
community(namsskogan, nord_trøndelag).
community(nannestad, akershus).
community(narvik, nordland).
community(naustdal, sogn_og_fjordane).
community(nedre_eiker, buskerud).
community(nes, akershus).
community(nes, buskerud).
community(nesna, nordland).
community(nesodden, akershus).
community(nesseby, finnmark).
community(nesset, møre_og_romsdal).
community(nissedal, telemark).
community(nittedal, akershus).
community(nome, telemark).
community(nord_aurdal, oppland).
community(nord_fron, oppland).
community(nord_odal, hedmark).
community(norddal, møre_og_romsdal).
community(nordkapp, finnmark).
community(nordre_land, oppland).
community(nordreisa, troms).
community(nore_og_uvdal, buskerud).
community(notodden, telemark).
community(nærøy, nord_trøndelag).
community(nøtterøy, vestfold).
community(odda, hordaland).
community(oppdal, sør_trøndelag).
community(oppegård, akershus).
community(orkdal, sør_trøndelag).
community(os, hedmark).
community(os, hordaland).
community(osen, sør_trøndelag).
community(oslo, oslo).
community(osterøy, hordaland).
community(overhalla, nord_trøndelag).
community(porsanger, finnmark).
community(porsgrunn, telemark).
    community(porsgrund, telemark). %% TA-101129 ?
community(radøy, hordaland).
community(rakkestad, østfold).
community(rana, nordland).
community(randaberg, rogaland).
community(rauma, møre_og_romsdal).
community(re, vestfold).
community(rendalen, hedmark).
community(rennebu, sør_trøndelag).
community(rennesøy, rogaland).
community(rindal, møre_og_romsdal).
community(ringebu, oppland).
community(ringerike, buskerud).
community(ringsaker, hedmark).
community(rissa, sør_trøndelag).
community(risør, aust_agder).
community(roan, sør_trøndelag).
community(rollag, buskerud).
community(rygge, østfold).
community(råde, østfold).
community(rælingen, akershus).
community(rødøy, nordland).
community(rømskog, østfold).
community(røros, sør_trøndelag).
community(røst, nordland).
community(røyken, buskerud).
community(røyrvik, nord_trøndelag).
community(salangen, troms).
community(saltdal, nordland).
community(samnanger, hordaland).
community(sande, møre_og_romsdal).
community(sande, vestfold).
community(sandefjord, vestfold).
community(sandnes, rogaland).
community(sandøy, møre_og_romsdal).
community(sarpsborg, østfold).
community(sauda, rogaland).
community(sauherad, telemark).
community(sel, oppland).
community(selbu, sør_trøndelag).
community(selje, sogn_og_fjordane).
community(seljord, telemark).
community(sigdal, buskerud).
community(siljan, telemark).
community(sirdal, vest_agder).
community(skaun, sør_trøndelag).
community(skedsmo, akershus).
community(ski, akershus).
community(skien, telemark).
community(skiptvet, østfold).
community(skjervøy, troms).
community(skjåk, oppland).
community(skodje, møre_og_romsdal).
community(skånland, troms).
community(smøla, møre_og_romsdal).
community(snillfjord, sør_trøndelag).
community(snåsa, nord_trøndelag).
community(sogndal, sogn_og_fjordane).
community(sokndal, rogaland).
community(sola, rogaland).
community(solund, sogn_og_fjordane).
community(songdalen, vest_agder).
community(sortland, nordland).
community(spitsbergen, svalbard).
community(spydeberg, østfold).
community(stange, hedmark).
community(stavanger, rogaland).
community(steigen, nordland).
community(steinkjer, nord_trøndelag).
community(stjørdal, nord_trøndelag).
community(stokke, vestfold).
community(stor_elvdal, hedmark).
community(stord, hordaland).
community(stordal, møre_og_romsdal).
community(storfjord, troms).
%% community(strand, rogaland).
community(stranda, møre_og_romsdal).
community(stryn, sogn_og_fjordane).
community(sula, møre_og_romsdal).
community(suldal, rogaland).
community(sund, hordaland).
community(sunndal, møre_og_romsdal).
community(surnadal, møre_og_romsdal).
community(sveio, hordaland).
community(svelvik, vestfold).
community(sykkylven, møre_og_romsdal).
community(søgne, vest_agder).
community(sømna, nordland).
community(søndre_land, oppland).
community(sør_aurdal, oppland).
community(sør_fron, oppland).
community(sør_odal, hedmark).
community(sør_varanger, finnmark).
community(sørfold, nordland).
community(sørreisa, troms).
community(sørum, akershus).
community(tana, finnmark).
community(time, rogaland).
community(tingvoll, møre_og_romsdal).
community(tinn, telemark).
community(tjeldsund, nordland).
community(tjøme, vestfold).
community(tokke, telemark).
community(tolga, hedmark).
community(torsken, troms).
community(tranøy, troms).
community(tromsø, troms).
community(trondheim, sør_trøndelag).
community(trysil, hedmark).
community(træna, nordland).
community(trøgstad, østfold).
community(tvedestrand, aust_agder).
community(tydal, sør_trøndelag).
community(tynset, hedmark).
community(tysfjord, nordland).
community(tysnes, hordaland).
community(tysvær, rogaland).
community(tønsberg, vestfold).
community(ullensaker, akershus).
community(ullensvang, hordaland).
community(ulstein, møre_og_romsdal).
community(ulvik, hordaland).
community(utsira, rogaland).
community(vadsø, finnmark).
community(vaksdal, hordaland).
community(valle, aust_agder).
community(vang, oppland).
community(vanylven, møre_og_romsdal).
community(vardø, finnmark).
community(vefsn, nordland).
community(vega, nordland).
community(vegårshei, aust_agder).
community(vennesla, vest_agder).
community(verdal, nord_trøndelag).
community(verran, nord_trøndelag).
community(vestby, akershus).
community(vestnes, møre_og_romsdal).
community(vestre_slidre, oppland).
community(vestre_toten, oppland).
community(vestvågøy, nordland).
community(vevelstad, nordland).
community(vik, sogn_og_fjordane).
community(vikna, nord_trøndelag).
community(vindafjord, rogaland).
community(vinje, telemark).
community(volda, møre_og_romsdal).
community(voss, hordaland).
community(vågan, nordland).
community(vågsøy, sogn_og_fjordane).
community(vågå, oppland).
community(våler, hedmark).
community(våler, østfold).
community(værøy, nordland).
community(åfjord, sør_trøndelag).
community(ål, buskerud).
community(ålesund, møre_og_romsdal).
community(åmli, aust_agder).
community(åmot, hedmark).
community(årdal, sogn_og_fjordane).
community(ås, akershus).
community(åseral, vest_agder).
community(åsnes, hedmark).
community(øksnes, nordland).
community(ørland, sør_trøndelag).
community(ørskog, møre_og_romsdal).
community(ørsta, møre_og_romsdal).
community(østre_toten, oppland).
community(øvre_eiker, buskerud).
community(øyer, oppland).
community(øygarden, hordaland).
community(øystre_slidre, oppland).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
