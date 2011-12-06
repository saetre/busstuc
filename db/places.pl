%% FILE places.pl
%% SYSTEM BUSSTUC  DOMAIN AtB
%% CREATED TA-070503
%% REVISED TA-110818
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% d1 --> dronningens_gate_d1  etc 
% m1 --> munkegata_m1 etc

%  Det heter V�restr�a ***

%% Contains predicates that describes information about places (only).

%% Domain specific names  (in principle)
%% Domain TT (Team)

% See also names.pl for general synonyms

:- module( places, [
  alias_name/2,            % (NAME,NAME)
  alias_station/2,         % (STATION,STATION)
  aliasteamatb/3,
  cmpl/3,                  % (NAME,NAME*,LIST)
  corr/2,                  % (PLACE,PLACE)
  foreign/1,
  isat/2,                  % (STATION,PLACE)
  nostation/1,
  place_resolve/2,         % (PLACE,STATION).
  placestat/2,             % (PLACE,STATION)
  sameplace/2,             % (PLACE,PLACE)
%  short_specname/1,        % (NAME,STRING)
  short_specname/2,
  specname/2,              % (NAME,STRING)
  synplace/2,              % (NAME,PLACE)
  underspecified_place/1,  % (PLACE)
  unwanted_place/1,        % (PLACE)
  unwanted_station/1      % (PLACE)
]).

%% RS-111205, UNIT: /
%:- ensure_loaded( '../declare' ).    %% Operators for TUC
:- use_module( '../main', [  myflags/2 ] ). %% set/2, 



%% hovedterminalen is technically a station as required in some
%% tables, but semantically a neighbourhood

%%%%%%%%%   REFERENCE TO STATION SECTION %% TA-110705


corr(torget,hovedterminalen).         %% SUMMER %% TA-110628

%% corr(prinsenkrysset,hovedterminalen). %% ???  SUMMER %% TA-110701
  %% sorry, gir destinasjon munkehate = Prinsenkrysset  %%

corr(sentrum,hovedterminalen).  

corr(munke_street,hovedterminalen). 
%%% corr(brannstasjon_�st,strindheim).  %% TA-110822

corr(dronningens_gate_d1,hovedterminalen). %% Atb
corr(dronningens_gate_d2,hovedterminalen). 
corr(dronningens_gate_d3,hovedterminalen). 
corr(dronningens_gate_d4,hovedterminalen). 

corr(dronningens_gate_19,hovedterminalen). %% TA-110627
corr(dronningens_gate_46,hovedterminalen). %% TA-110627
corr(dronningens_gate_50,hovedterminalen). %% TA-110627



%% corr(munkegata_m0,sentrum).  %% ad hoc sverresgt-> m0->sentrum

%%%%%% corr(munkegata_m0,hovedterminalen).  %% Atb
corr(munkegata_m1,hovedterminalen). 
corr(munkegata_m2,hovedterminalen). 
corr(munkegata_m3,hovedterminalen). 
corr(munkegata_m4,hovedterminalen). 
corr(munkegata_m41,hovedterminalen).  %% SIC
corr(munkegata_m5,hovedterminalen). 

%% old team for compatibility
corr(munkegata_m0,hovedterminalen).  %% Generic central place
corr(munkegata_m1,hovedterminalen). 
corr(munkegata_m2,hovedterminalen). 
corr(munkegata_m3,hovedterminalen). 
corr(munkegata_m4,hovedterminalen). 
corr(munkegata_m41,hovedterminalen).  %% SIC
corr(munkegata_m5,hovedterminalen). 



corr(d1,hovedterminalen). 
corr(d2,hovedterminalen). 
corr(d3,hovedterminalen). 
corr(d4,hovedterminalen). 
corr(lerkendal_stadion,tempe_kirke). 
corr(m0,hovedterminalen).  %% Generic central place
corr(m0,sentrum).  %% ad hoc sverresgt-> m0->sentrum
corr(m1,hovedterminalen). 
corr(m2,hovedterminalen). 
corr(m3,hovedterminalen). 
corr(m4,hovedterminalen). 
corr(m41,hovedterminalen).  %% SIC
corr(m5,hovedterminalen). 


corr(stavset_senter,stavset_senter). 
corr(studentersamfundet_1,studentersamfundet_2). 

corr(lerkendal_stadion,tempe_kirke). 




%% ISAT    Station Neighbourhood

isat(prinsens_gate_p1,prinsenkrysset). %% TA-110822
isat(prinsens_gate_p4,prinsenkrysset). %%

isat(dronningens_gate_d1,sentrum). %% AtB
isat(dronningens_gate_d2,sentrum). 
isat(dronningens_gate_d3,sentrum). 
isat(dronningens_gate_d4,sentrum). 

isat(munkegata_m1,sentrum). 
isat(munkegata_m2,sentrum). 
isat(munkegata_m3,sentrum). 
isat(munkegata_m4,sentrum). 
isat(munkegata_m5,sentrum). 

isat(bratsberg_kirke,bratsberg). %% TA-110325

%% isat(britannia_hotell,sentrum). %%  FB? %% not AtB
isat(bromstadsvingen,bromstad).
isat(bromstadvegen,bromstad). 
isat(by�sen_butikksenter,by�sen).
isat(br�setvegen_168,br�setvegen). 

isat(charlottenlund_kirke,charlottenlund). 
isat(charlottenlund_nedre,charlottenlund). 

isat(city_syd_�stre,city_syd).  %% TA-100901
isat(city_syd_vestre,city_syd). %% TA-110627

isat(flat�stoppen,flat�sen). % 7,17
isat(framveien,by�sen). 

isat(gl�shaugen_nord,gl�shaugen). 
isat(gl�shaugen_nord,nth). 
isat(gl�shaugen_syd,gl�shaugen). 
isat(gl�shaugen_syd,hesthagen). 
isat(gl�shaugen_syd,nth). 

isat(haakon_vii_gate_17,haakon_vii_gate). 
isat(haakon_vii_gate_17,haakon_vii_gate). 
isat(haakon_vii_gate_25,haakon_vii_gate). 
isat(haakon_vii_gate_25,haakon_vii_gate). 
isat(haakon_vii_gate_29,haakon_vii_gate). 
isat(haakon_vii_gate_29,haakon_vii_gate). 
isat(haakon_vii_gate_9,haakon_vii_gate). 
isat(haakon_vii_gate_9,haakon_vii_gate). 
isat(heggstadmoen_2,heggstadmoen). 
isat(heggstadmoen_4,heggstadmoen). 
isat(heimdal_sentrum,heimdal). 
isat(heimdal_sentrum,heimdal). 
isat(heimdal_stasjon,heimdal). 
isat(heimdal_stasjon,heimdal). 
isat(hovedterminalen,dronningens_gate).  %% Where is sentrumsterminalen
isat(hovedterminalen,munkegata).  %%
isat(hovedterminalen,sentrum).  %% Experiment Trikk St. Olavs. gt og s� sentrum

isat(ikea,leangen). %%  (?)

isat(kl�bu_sentrum,kl�bu).  %% AtB


isat(john_aaes_veg,city_syd).   %%
isat(kvt,city_syd).             %%


isat(lerkendal_stadion,lerkendal). 
isat(lerchendal_g�rd,lerkendal).   %% ?

isat(loholtbakken,loholt). 
isat(lohove,loholt). 
isat(lykkmarka,sjetnmarka). %% Nightbus 

isat(markaplassen_skole,vik�sen). 

isat(nordre_flat�sen,flat�sen). %7
%% isat(nordre_hoem,hoem). %% not AtB
isat(nova_kinosenter,royal_garden). 

isat(omkj�ringsveien_moholt,omkj�ringsveien). 
isat(omkj�ringsveien_moholt,omkj�ringsveien). 
isat(omkj�ringsveien_nardo,omkj�ringsveien). 
isat(omkj�ringsveien_nardo,omkj�ringsveien). 

isat(paul_skolemesters_veg,sjetnmarka). 
isat(prof_brochs_gate,hesthagen). 
isat(ranheim_fabrikker,ranheim). 
isat(ranheim_stasjon,ranheim). 
isat(ranheim_idrettsplass,ranheim). %% TA-110426
isat(ringve_museum,ringve). 
isat(ringve_museum,ringve). 
isat(ringve_skole,ringve). 
isat(rosenborg_skole,rosenborg). %% AtB


isat(sluppen,sluppen).  %% postterminalen p� sluppen
isat(solbakken_bru,solbakken).  
isat(solbakken_skole,solbakken). 
%% isat(st_olavs_gate,sentrum).  %% not AtB
isat(stavset_senter,stavset). 

isat(s�ndre_flat�sen,flat�sen). %7
isat(s�ndre_gate_22,s�ndregate). 
isat(s�ndre_gate_23,s�ndregate). 
isat(s�ndre_gate_23,royal_garden). 
%% isat(s�ndre_hoem,hoem). %% not AtB

isat(tempe_kirke,tempe).  %%NB
isat(tempevegen_11,tempe). %% AtB
isat(tonstadkrysset,tonstadkrysset).  %%4

isat(trollahaugen_10,trollahaugen). 
isat(trollahaugen_2,trollahaugen). 
isat(trollahaugen_46,trollahaugen).  %% 11->trollahaugen 64,75->trolla
%% isat(trollahaugen_64,trollahaugen). 
isat(tyholt,tyholt).  %% Hvilke holdeplasserer p� tyholt?

isat(val�yvegen,tempe).  %% val�yveien stationname!
isat(vestlia,steinan).   %%  NOT placestat 
isat(vestlia,vestlia).   %%NB!!!
isat(vestlia_endeholdeplass,steinan).  %%Haz?
isat(vestlia_endeholdeplass,vestlia). 
isat(voll_g�rd,voll). 
isat(voll_studentby,voll). 


isat(�stre_berg,berg_�stre). %% AtB  tricky
isat(�stre_rosten,city_syd).    %% � R must be station
isat(�vre_flat�sveg,flat�sen). % 9,17 

isat(moholt,lingit). %% Ad HOC, best conn from NTH
isat(moholt_storsenter,lingit).
%%��� %% ulykke AtB %% TA-100715
isat(lade_alle_80,lade).
%%%%%%placestat(lade,lade_alle_80).  %% ( lade-alle_80 more passages)
%%���

isat(fagerliveien,fagerliv). %% Panic %% AtB


isat(trondheim_s_10,ts). %% SUMMER %% TA-110627
isat(trondheim_s_11,ts). %%
isat(trondheim_s_13,ts). %%



%%% PLACESTAT  neighbourhood station

%% placestat(atb,torget). %% TA-101108 

placestat(studentersamfundet_1,studentersamfundet).  %% AtB %% NB \+ isat
placestat(studentersamfundet_2,studentersamfundet).  %% TA-100922

placestat('ALT/Statoil',rotvoll_nedre).%% hist/ALT %% extra dep Bus 6 
placestat('Adolf �iens skole',prinsen_kinosenter).  %%
placestat('Bakke kirke',bakkegata).  %% Syndrome Hvor er bakke kirke
placestat('Berg arbeidskirke',kvilhaugen). 
%% placestat('Br�set sykehus',br�setvegen_119). 
placestat('Comfort Hotel Park',prinsen_kinosenter). 
placestat('Dalg�rd skole',dalg�rd).  %%
placestat('Din bil',nidarvoll_skole).  %% Bratsbergveien 11
placestat('Eberg skole',teglverkskrysset). 
placestat('Heimdal politistasjon',heimdal_stasjon).  %%
placestat('Hotell Augustin',torget).  %% Brage 
placestat('Motor Trade',fiolsvingen). %% Bilverksted
placestat('Lilleby skole',stiklestadveien).  %% Ladeveien 1 
placestat('Ni muser',prinsen_kinosenter). 
placestat('Steinan studentby',vestlia).
placestat('Tiller kirke',moltmyra_�st).  
placestat('Torbj�rn Bratts veg',fiolsvingen). 


placestat(adm_rit,st_olavs_hospital). 
placestat(adresseavisa,adresseavisen). 
placestat(alfheim,alfheimsvingen). 
placestat(alfheimsv,alfheimsvingen).  %% Forkortelse (alfheimsv i rutehefte)

placestat(amo_senteret,henrik_ourens_veg). 
placestat(angelltr�a,angelltr�vegen). 
placestat(angeltr�a,angelltr�vegen). 
placestat(arbeidsmarkedsinstituttet,lade_alle_80). 
placestat(arnebyen,ugla). 



placestat(atmel,maskinagentur). 

placestat(autronica,haakon_vii_gate_25). %% TA-110818

placestat(multiconsult,postterminalen). %% sluppenvegen 23 %% TA-110415

 
%% placestat(lingit,moholt_storsenter). %% //confuse Lingit company

placestat(lingit,moholt). %% TA-110401

placestat(idi,gl�shaugen_syd). %% TA-110401

placestat(dis,gl�shaugen_syd). %% TA-110401


placestat(badeland,pirbadet). 
placestat(bakkaunet,rosendal). 
placestat(bakkebru,bakkegata). 
placestat(balders_street,tors_veg).  %% street
%% placestat(barneklinikken,st_olavs_hospital_vest).  %% ????????
placestat(bassengbakken,solsiden). 
placestat(beddingen,solsiden). 
placestat(befalsskolen,festningsgata). 

%% placestat(berg,�stre_berg). 
%% also station on obscure route 73 (not in busrutehefte)

placestat(bergstudentby,bugges_veg). 
placestat(bergsvingen,harald_bothners_veg).  %% �vre/nedre
placestat(bi,pirbadet). %%  BI
placestat(bi,�stre_rosten). 
placestat(bilcentrum,leangen_alle). %%  Garage
placestat(bilsakkyndige,e_verket). 
placestat(bilsakskyndig,e_verket). 
placestat(biltema,rostengrenda).  %% �stre rosten 22 (not garage)
placestat(biltilsyn,e_verket). 
placestat(biltilsynet,e_verket). 
placestat(bispegata,prinsen_kinosenter). 
placestat(bispeg�rden,prinsen_kinosenter). 
placestat(bispehaugenskole,bakkegata). 
placestat(bj�rndal,bj�rndalsbrua). 
%% placestat(blaklia,blakli).
placestat(blaklih�gda,blakli). 
placestat(blindeforbundet,churchills_veg). 
placestat(blindeskolen,churchills_veg). 
placestat(blomsterbyen,fiolsvingen). 
placestat(bl�klokkevegen,fiolsvingen). 
%% placestat(bohus,br�setvegen_186). 
%% placestat(brannstasjonen,brannstasjon_�st). %% TA-110822
%% placestat(bratsberg,bratsberg_vestre). 

%% placestat(bratt�ra,pirbadet). 

placestat(bratt�rkaia,bratt�ra). 
placestat(bratt�rkaien,bratt�ra). 
placestat(brat�rkaia,bratt�ra). 
placestat(brat�rkaien,bratt�ra). 


%%% placestat(brit_grytbakks_street,gryta). 

placestat(britannia,hovedterminalen).  %% (Britania by spch)%% airbus
placestat(britannia_hotell,hovedterminalen). 

placestat(bromstadkrysset,bromstadsvingen). 
placestat(br�set,br�setflata). 
placestat(br�setsvingen,bromstadsvingen). 
placestat(bussgarasjen,sorgenfri). 
placestat(byavisa,nardokrysset).  %%?
placestat(bymarka,skistua).  %%
placestat(byneset,trolla). 
placestat(bytorget,torget).  %%avoidhpln�rtorgetertorget
%% placestat(by�sen_butikksenter,by�sen_butikksenter). %% TA-110627
placestat(by�sen_videreg�ende_skole,migosenteret). %% by�sen_videreg�ende_skole neibourhood

placestat(cathedral,prinsen_kinosenter). 
placestat(ceciliebrua,cecilienborg). 
placestat(charlottenlund_skole,churchills_veg).  %% Ungdomsskole/Videreg�ende?
placestat(charlottenlund_videreg�ende,brundalen_skole). 
%% placestat(charlottenlundbanen,churchills_veg).
placestat(charlottenlundhallen,churchills_veg). 
placestat(charlottenlundhallen,tunvegen).  %% Tunveien18B,Jakobsli
placestat(chr_eggens_veg,bjarne_ness_veg). 
placestat(church,prinsen_kinosenter). 
placestat(cicilliebrua,cecilienborg). 
placestat(city_hall,prinsen_kinosenter). 
placestat(dalen,dalen_hageby). 
placestat(dalenhageby,dalen_hageby). 
placestat(dalsaune,dalsaunevegen). 
placestat(dalseng,prof_brochs_gate). 
placestat(dalsenget,prof_brochs_gate). 

placestat(devleg�rd,olav_engelbrektssons_alle).

placestat(bilbyen,nidarvoll_skole). %%  bratsbergveien 17. // garage
placestat(dinbil,nidarvoll_skole).  %%  bratsbergveien 11. // garage

placestat(dmmh,dalen_hageby). %% TA-110301

placestat(dokkparken,solsiden). %%  // Changed name !

placestat(dokkhuset,solsiden).
placestat(dokksiden,solsiden). 
placestat(dokkterminalen,solsiden).  %% ? 
placestat(domen,prinsen_kinosenter). 
placestat(domkirka,prinsen_kinosenter). 
placestat(domkirken,prinsen_kinosenter). 

%% placestat(dora,dora_1).  
placestat(dorahallen,dora). 

placestat(dronningens_gate,hovedterminalen).  %% jeg skal til dronningens gate. 
placestat(dronningens_street,hovedterminalen).  %% Technical
placestat(d�veskolen,skyttervegen).  %%
placestat(ekle,eklesbakken). 
placestat(elgeseter,prof_brochs_gate). 
placestat(elgsetergata,prof_brochs_gate).  %% \+ s�terbakken
placestat(erkebispeg�rden,prinsen_kinosenter). 

%% placestat(esso_motorhotell,br�setvegen_186). %% Old name ! 

placestat(estenstad,estenstadvegen). 
placestat(estenstadmarka,estenstadvegen). 
placestat(fagerheim,fagerheim_alle). 
placestat(fagerlia,fagerliveien). 
placestat(fagerlien,fagerliveien). 
placestat(falkenborg,dalen_hageby). 
placestat(felleskj�pet,gartnerhallen). 
placestat(fengsel,tunga_kretsfengsel). 
placestat(fengselet,tunga_kretsfengsel). 
placestat(festningen,ankers_gate). 
placestat(festningsparken,ankers_gate).  %% ?
placestat(filmteatret,prinsen_kinosenter). 
placestat(fischebygget,studentersamfundet). 
placestat(flat�sen,flat�stoppen). %Nightbus
placestat(flat�sensenteret,flat�sen_senter). 
placestat(flat�senskole,flat�sen_senter). 
placestat(flat�svegen,�vre_flat�sveg). 
placestat(fokushallen,vestre_rosten). 
placestat(fosenferja,pirbadet).
placestat(fosenterminalen,pirbadet). 

placestat(gartnerhagen,gartnerhallen). 
placestat(gilde,gartnerhallen). 
placestat(gildheimsveien,gildheim). 
placestat(gl�shaugen,gl�shaugen_syd).  %% Avoid GS/N messages
placestat(godsterminalen,terminalen). 
placestat(gran�sen,gran�sen_vm_anlegget). 
placestat(grillstad,grilstadkleiva). 
placestat(grilstad,grilstadkleiva). 
placestat(grilstadfj�ra,grilstadkleiva). 

placestat(hallset,s�ndre_halset).  %% nordre s�ndre 
placestat(halset,s�ndre_halset).   %% nordre s�ndre
placestat(hallsetvangen,s�ndre_halset). 
placestat(hanger,hanger�sen). 
placestat(hangersletta,hanger�sen).  %% aasen UN properstation
placestat(hanger�s,hanger�sen).  %% necessary because laura hanger�s veg
placestat(hansbakkfj�ra,ranheim_skole).  %% map 
placestat(harbour,pirbadet).  %% English the harbour
placestat(haukvatnet,hauk�sen). 
placestat(havna,pirbadet).
placestat(havna,pirbadet).  %%?
placestat(havnen,pirbadet).
placestat(havstad,havstadsenteret). 
placestat(havstadflata,havstadsenteret). 
placestat(havstein,havstadsenteret). 
placestat(havsteinekra,stabells_veg). %%% ?? helse og velferdssenter
placestat(havsteinflata,havstadsenteret). 
placestat(havsteinflaten,havstadsenteret). 
placestat(heimdalsentrum,heimdal_sentrum). 
placestat(hoeggen,hoeggen_skole). 
placestat(holtermannsveien,val�yvegen). 
placestat(horneberg,hornebergvegen). 
placestat(hospitall�kka,hospitalkirka). 
placestat(hospitall�kkan,hospitalkirka). 
placestat(hospitall�kken,hospitalkirka). 
placestat(hospitalsl�kkan,hospitalkirka). 
placestat(hospitalsl�kka,hospitalkirka). %% hospitalslokka 

%% placestat(hostel,sig_berg_alle). %% * P-hotels %% TA-101202
placestat(hurtigb�ten,pirbadet). 
placestat(hurtigb�tkaia,pirbadet). 
placestat(hurtigb�tkaia,pirbadet). 
placestat(hurtigb�tkaien,pirbadet). 
placestat(hurtigb�tterminalen,pirbadet). 

%% placestat(hurtigruta,pirbadet). %% Haz, boat
 
placestat(hurtigrutekaia,pirbadet).
placestat(hurtigrutekaien,pirbadet). 
placestat(hurtigruten,pirbadet). 
placestat(hurtigruteterminalen,pirbadet). %% ?
placestat(huseby,husebytunet).  %% \+ synplace
placestat(husebybadet,saupstadsenteret). 
placestat(husebyhallen,saupstadsenteret). 
placestat(husebysenteret,saupstadsenteret). 
placestat(h�rstad,martin_kregnes_veg). 
placestat(h�rstadmarka,martin_kregnes_veg). 
placestat(h�rstadmyra,martin_kregnes_veg). 
placestat(idrettsbygget,h�gskoleringen). 

placestat(ilabekken,ila). 
placestat(iladalen,ila).
placestat(ilakirke,ila). 
placestat(ilaparken,ila). 
placestat(ilevolden,ila). 
placestat(ilevollen,ila). 
placestat(ilevollene,ila). 

%% placestat(ilsvika,ila). %% station
placestat(ilsvik�ra,ilsvika). 

placestat(industribygget,solsiden). 
placestat(innherredsveien,solsiden). 
%% placestat(ishallen,bromstadsvingen). %% TA-101124 Station!
placestat(jonsvannet,solbakken_bru). 
placestat(jonsvannsveikrysset,jonsvannsveien). 
placestat(jonsvannet,solbakken_bru). %% TA-110202
placestat(kaia,pirbadet). 
placestat(kanalen,solsiden). 
placestat(karinelund,strinda_kirke). 
placestat(katedralen,prinsen_kinosenter). 
placestat(katedralskolen,prinsen_kinosenter). 
placestat(kbs,strindheim). 
placestat(kbs_senteret,strindheim). 
placestat(kinosenteret,prinsen_kinosenter). 
placestat(kirka,prinsen_kinosenter).  %%Uncertain
placestat(klefstad,klefstadhaugen). 
placestat(klostergata,studentersamfundet).  %% (�ya?)_2
placestat(kl�bu_skysstasjon,kl�bu_sentrum).  %% kl�bu_skysstasjon rutehefte/
placestat(kolstad,torplassen). 
placestat(kolstadflata,torplassen). 
placestat(kolstadsenter,torplassen). 
placestat(kolstadsenteret,torplassen).  %%?
placestat(kols�s,flat�stoppen).  %% ogs� B�rum
placestat(kols�sen,flat�stoppen). 
placestat(kols�stoppen,flat�stoppen). 
placestat(kongsvegen,gran�sen_vm_anlegget). 
placestat(korsvika,lade_kirke). 
placestat(kotenghallen,vestre_rosten). %%  private?
placestat(kretsfengselet,tunga_kretsfengsel). 
placestat(kristiansten,ankers_gate). 
placestat(kristianstenfestning,ankers_gate). 
placestat(kuhaugen,gina_krogs_veg). 
placestat(kyvannet,skavlans_veg). 
placestat(kyvatnet,skavlans_veg). 
%% placestat(k�ff,leangenveien). %% TA-110822

placestat(lade_alle,lade_alle_80).  %%

placestat(ladehammerveien,ladehammeren).  %%(manystations,
placestat(lademoen,r�nningsbakken). 
placestat(lademoen_kirke,rosendal). 
 %% placestat(lademoen_skole,mellomv_5). 
placestat(lademoparken,buran). 
placestat(ladeparken,buran). 
placestat(ladeskolen,lade_kirke). 
placestat(ladetorget,�stmarkveien). 
placestat(lamoparken,buran). 
placestat(langlohaugen,langlo). 
placestat(larsbyen,olav_nyg�rds_veg). 
placestat(leangen,travbanen). 
placestat(leangenhallen,bromstadsvingen). 
placestat(legard,leg�rdsbakken). 
placestat(legevakta,st_olavs_hospital). 
placestat(legevakten,st_olavs_hospital). 
placestat(leinstrand,leinstrand_samfunnshus). 
placestat(leira,leira_skole). 
placestat(leirbrua,leirbrua_g�rd). 
placestat(lerkendalskrysset,lerkendal_stadion). 
placestat(lerkendalsvegen,gl�shaugen_syd). 
placestat(leuthenhaven,torget). 
%% placestat(lianvannet,lian). %% not AtB
placestat(loholt_alle,lohove). 
%% placestat(louisenlyst,leangenveien).  %% Leangenveien3 %% TA-110822
placestat(luftkrigsskolen,persaunet_leir). 
placestat(lundh�gda,lund�sen_n). 
placestat(l�rerh�gskole,rotvoll_nedre). 
placestat(l�rerh�gskolen,rotvoll_nedre). 
placestat(mamoz,fiolsvingen). %% nardo_street-16). 
placestat(marineborgstasjon,marienborg). 
placestat(marinen,prinsen_kinosenter). 
placestat(mediahuset,maskinagentur). 

placestat(norske_meierier,heggstadmoen). %% NB %% TA-110705

%% placestat(melkekartongen,city_syd). 


% placestat(migosenter,migosenteret). 
% placestat(migosenteret,migosenteret).  %% halset internal name

placestat(misjonskirken,prinsen_kinosenter).  %% Arkitekt Christies gt
placestat(moholtkrysset,omkj�ringsveien_moholt). 
placestat(moholtomr�det,moholt). 
placestat(moholtsenteret,moholt_storsenter).  
placestat(moholtterasse,moholt).  %% ???
placestat(moholttun,moholt). 
placestat(mts,magnus_berrf�tts_veg).  %% Lazy complex
placestat(munkegata,hovedterminalen). 
placestat(m�llenberg,solsiden). 

placestat(m�ller_bil,hallfred_h�yems_veg). 

placestat(n_g_u,ringve_skole). 
placestat(naf,e_verket).  %% (?) SIC
placestat(nafsenteret,e_verket).  %%( ?) SIC
placestat(nardo,nardosenteret). 
placestat(nardobanen,fiolsvingen). 
placestat(nardoskole,nardokrysset). 
placestat(nardosletta,nardosenteret).  %% Names should not disappear
placestat(nardovegen,dybdahls_veg). 

placestat(nattbussterminalen,olav_tryggvasons_gate). %% CORREC %% TA-101203 %% AtB %% TA-100715

placestat(nedre_elvehavn,solsiden).  %%(?)
placestat(nedre_m�llenberg,bakkegata). 
placestat(neptunveien,risvollan_senter). 
placestat(nidar,strindheim). 
placestat(nidarbergene,strindheim). 
placestat(nidarfabrikken,strindheim). 
placestat(nidaros,hovedterminalen).  %% New name for midtbyn 
placestat(nidarosdomen,prinsen_kinosenter). 
placestat(nidarvoll,nidarvoll_skole). 
placestat(nidarvollsykehjem,nyg�rd). 
placestat(nidar�,trondheim_spektrum). %% not sum08
placestat(nidelvbrua,nidelv_bru). 
placestat(nidelvhallen,val�yvegen).  %% ?
placestat(nilsbyen,stavset_senter). 
placestat(nissekollen,fiolsvingen). 

%% placestat(nordre,nordre_gate).  %% nordre general//HAZARD

placestat(nordre_halset,migosenteret). %% renamed


placestat(nrk,tyholtt�rnet). 
placestat(nth,gl�shaugen_syd).  %%
placestat(ntnu_lade,harald_h�rfagres_gate).  %% Changed Name %<---
placestat(ntnui,h�gskoleringen).  
placestat(nyhavna,nidelv_bru).  %%(?)
placestat(nyveilia,bj�rndalsbrua). 
placestat(n�ringssenteret,buran).
placestat(okstadbrinken,kroppanmarka). 
placestat(okstadtunet,okstad). 
placestat(olavshallen,nova_kinosenter). 
placestat(olavskvartalet,nova_kinosenter). 
placestat(olavskvarteret,nova_kinosenter). 
placestat(olavsstatuen,torget). 
placestat(olavsg�rden,strindheim). %% Thonning Owesens gate 20 

%% placestat(ole_aasveds_street,gryta). 


placestat(palmehaven,hovedterminalen). 
placestat(perleporten,gl�shaugen_syd). 
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

placestat(prinsen,prinsen_kinosenter). 
placestat(prinsen,prinsen_kinosenter).  %%NBPRINSENisalsoafictitiousstation
placestat(prinsenkino,prinsen_kinosenter). 
placestat(prinsens,prinsen_kinosenter).  %%(pgaavertering)
placestat(prinsens_gate,prinsen_kinosenter). 
placestat(pr�ven,kroppan). 
placestat(pr�venbil,kroppan). 
placestat(radmannbygget,gildheim). %%  Ranheimsvegen 10
placestat(ramstadkrysset,ramstad). 
placestat(ravnkloa,hovedterminalen).  %%(Hazard?)

%% placestat(realfagbygget,gl�shaugen_syd). %% --- Telebuster house
placestat(regionssykehuset,st_olavs_hospital).  %%r_i_t_hovedporten). 
placestat(regionsykehuset,st_olavs_hospital).  %%r_i_t_hovedporten). 
placestat(reina,h�greina).  %%betterthanRena
%% placestat(reitgjerdet,br�setvegen_119). 

placestat(reppevegen,vikelvveien). %% imcomprehensible route 777
placestat(reppeveien,vikelvveien). %% street reppeveien = osveien 
                                   %% reppevegn not in routes

placestat(reppemoen,reppe).        

placestat(rikshospitalet,st_olavs_hospital).  %%-> mess
placestat(ringvebukta,ringve_museum). 
placestat(rishaughallen,haakon_vii_gate_25).  %% (h�kon 7 gate 23. )
placestat(risvollan,risvollan_senter). 
placestat(risvolltun,s�ndre_risvolltun). 
placestat(rit,st_olavs_hospital).  %% r_i_t_hovedporten). 
placestat(rockheim,pirbadet). %% Bratt�rkaia 14 %% TA-100927
placestat(rognbu,rognbudalen). 
placestat(rognbuveien,rognbudalen).  %%?
placestat(rogndalen,rognbudalen). 

placestat(rosenborghallen,rosenborg_skole). %% TA-101025

%% placestat(rosenborg,rosenborg_skole). %% isat (AtB/Team)
%% placestat(rosenborghallen,rosenborg_skole). 

%% placestat(rosta,rostengrenda).  %% Rosten is station #43
%% placestat(rosten,rostengrenda).
%% placestat(rosten,rostengrenda). 



placestat(rostenhallen,kvt). 
placestat(rostenkrysset,�stre_rosten). 
placestat(rotvollfj�ra,rotvoll).  %%?
placestat(r�nning,r�nningsbakken). 
placestat(r�dhuset,torget). 

placestat(sandgata,hospitalkirka). 
placestat(sandmoencamping,sandmoen). 
placestat(saupstad,saupstadsenteret). 
placestat(saupstadkrysset,saupstadsenteret).  %%?
placestat(saupstadskole,midteggen). 
placestat(saupstadvegen,heimdal_stasjon). 
placestat(saxenborg,saxenborg_alle). 
placestat(schr�der,fossegrenda). 
placestat(servicekontoret,dronningens_gate_d2).
placestat(singsaker,asbj�rnsens_gate). 
placestat(singsaker_studenthjem,jonsvannsveien). 
placestat(sjetne,carl_schjetnans_veg). 

placestat(sjetnmarka,carl_schjetnans_veg). %% not nightbus (103) Sjetnmarka
 %% bus_depend_station(103,sjetnmarka,paul_skolemesters_veg). %% nightbus anomaly

placestat(sjokoladefabrikken,strindheim). 
placestat(skippy,fossegrenda).  %% schr�der). 
placestat(skippysenteret,fossegrenda).  %%schr�der). 
placestat(skipsmodelltanken,magnus_berrf�tts_veg). 
placestat(smistadgrenda,arnt_smistads_veg).  
placestat(smistadkrysset,arnt_smistads_veg). 
%% placestat(solbakkenbrua,osbrua). 
%% placestat(solsiden,solsiden). %% station %% TA-101130

%% placestat(sorgenfriveien,sorgenfri) :- \+ main:myflags(airbusflag,true).  %% (on the map)
%% kr�ll med airbus 

placestat(sosialh�gskolen,gildheim).  %% ???

placestat(spilleplassen,spillebakken). %% TA-110815

placestat(spongdalskole,spongdal). 

%% placestat(st_olavs_gate,torget). %%  \+ tramflag not AtB

placestat(stabbursmoenskole,ditlev_bloms_veg). 
placestat(statens_hus,prinsen_kinosenter). 

placestat(statoil,statoil_rotvoll). %% TA-110627 ? isat?

placestat(stavne,stavnebrua).  %% confuse hvor langt er det fra stavne bro til breidablikk
placestat(stavnebro,stavnebrua). 

%%%                       placestat(steinan,vestlia).  %% NOT nattbussen

placestat(steinandalsvegen,steindalsvegen). 
placestat(steinanstudentby,vestlia). 
placestat(steinanv,hegdalen). 
placestat(steinanvegen,hegdalen). 
placestat(steinanveien,hegdalen). 
placestat(steinberget,m�llebakken). 
placestat(steindal,steindalsvegen).  %%<--???
placestat(steindalen,hegdalen). 
placestat(stiftsg�rden,hovedterminalen). 

placestat(stokkanhaugen,stokkhaugen).  %% SUMMER  %% TA-110627

placestat(stubban,venusvegen). 
placestat(studenterhytta,skistua). 
placestat(sunnland,karl_jonssons_veg).  %%sunnlandskole
placestat(sunnlandskole,karl_jonssons_veg). 
placestat(svartlamon,strandveien).  %% NB veien
placestat(sverresborg,tr�ndelag_folkemuseum). 
placestat(sykehusbrua,cecilienborg). 
%% placestat(sykehuset,st_olavs_hospital).  %% causes trouble sykehuset st olav
placestat(sykepleierh�gskolen,st_olavs_hospital). 
placestat(sykepleierh�yskolen,st_olavs_hospital). 
placestat(sykepleierskolen,st_olavs_hospital). 
placestat(tavern,tr�ndelag_folkemuseum). 
placestat(tavernaen,tr�ndelag_folkemuseum). 
placestat(teateret,prinsen_kinosenter).       %% 
placestat(teatret,prinsen_kinosenter).

placestat(tegleverksveien, teglverkskrysset).
placestat(teglg�rden,fossegrenda). 
placestat(teglverket,teglverkskrysset).  %%(tegle)

placestat(teknobyen,prof_brochs_gate).  %%(?)
placestat(teknostallen,prof_brochs_gate). 
placestat(telenorbygget,magnus_berrf�tts_veg). 
placestat(tf,magnus_berrf�tts_veg). 
placestat(tiller,torvtaket). 
%% placestat(tiller,moltmyra).  %% moltmyra_�st//bare en retning
placestat(tillerbruvegen,tiller_bru). 
placestat(tillerbyen,tonstadgrenda).  %%?koieflata). 

%% placestat(tillertorget,city_syd).  %% Ivar Lykkes veg 3 

placestat(tmv,solsiden).   %% TA-101214
placestat(tomasskolen,bakkegata). 
placestat(tonstad,tonstadkrysset). 
placestat(transitten,br�set_hageby).  %% (nb transittgata->strandveien)
placestat(trikkehallen,prof_brochs_gate). 
placestat(trikkestallen,prof_brochs_gate). 
placestat(trondheim_torg,torget). 
placestat(trondheimstorget,torget). 
placestat(trondsletten,br�set_hageby). %% beh. senter
placestat(tr�nderenergi,tunga_kretsfengsel). 
placestat(tunga,tunga_kretsfengsel).  %%(tunga=tungata=tunv#)
placestat(tunh�gda,tunvegen).  %%midte,vestre�stre
placestat(tvetesvingen,tvetestien). 
placestat(tyholtomr�det,tyholt). 
placestat(t�h,�stre_berg). 
placestat(uglaskole,ugla). 
placestat(uranusveien,risvollan_senter). 
%%% placestat(utleira,utleirmark).  %% NBNB utleira SYNDROME %% TA-100921
placestat(utleirveien,nardosenteret). 
placestat(valentinlystsenter,valentinlyst). 
placestat(valentinlystsenteret,valentinlyst). 
placestat(valgrind,valgrindvegen). 
placestat(valgrinda,valgrindvegen). 
placestat(val�ya,val�yvegen). 
placestat(val�ygrenda,val�yvegen). 
placestat(vegvesen,postterminalen). 
placestat(vegvesenet,postterminalen). 
placestat(veitrafikktilsynet,e_verket). 
placestat(verdensteatret,prinsen_kinosenter). 
placestat(vestoppfarten,m�llebakken). 
placestat(vik�senhallen,markaplassen_skole). 
placestat(vitenskapsmuseet,hospitalkirka).  %%  \+s
 %% placestat(voldsminde,mellomv_5).  
 %% placestat(voldsmindet,mellomv_5). 
placestat(voll,voll_studentby). 
placestat(v�resbukta,v�re). 
placestat(v�resholmen,v�re). 
placestat(witro,fossegrenda). 
placestat(�sheim,�sheim_skole). 
placestat(�sheimhallen,�sheim_skole). 
placestat(�svang,�svang_skole). 
placestat(�sveien,�sveien_skole). 
placestat(�stmarkasykehus,�stmarkveien). 
placestat(�ya_helsehus,studentersamfundet). % RS-110926 


placestat(wullumsgayrden,by�sen_butikksenter). %% TA-101230
placestat(wollumsgarden,by�sen_butikksenter).  %% TA-110114 wollumsgarden 

placestat(�stmarka,�stmarkveien). %% TA-110623



%%% END REFERENCE TO STATION SECTION


%% only plausible names
%% intended for intended alternative writing (not spell error)

sameplace(samdundet,studentersamfundet). %% AtB
sameplace(aasveien,�sveien). 
sameplace(adolf�yen,adolf_�ien). 
sameplace(adolf�yens,adolf_�ien). 
sameplace(alfgodagersvei,alf_godagers_veg). 
sameplace(amosenteret,amo_senteret). 
sameplace(angeltr�en,angelltr�a). 
%% sameplace(angelt�veien,angelltr�veien).  %%veg
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
sameplace(bergpresteg�rd,berg_presteg�rd). 
sameplace(bjoerkmyra,bj�rkmyr). 

sameplace(bjorndalstoppen,bj�rndalstoppen).  %% bjorndalstopprn 
sameplace(bj�rnedahlstoppen,bj�rndalstoppen). 
sameplace(bj�rnstadstoppen,bj�rndalstoppen). 

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
sameplace(bratsberveien,bratsbergveien). 
sameplace(brattsbergveien,bratsbergveien). 
sameplace(bredablikk,breidablikk). 
sameplace(breidablik,breidablikk). 
sameplace(brochsgt,prof_brochs_gate). 
sameplace(brocksgt,prof_brochs_gate). 

sameplace(broset,br�set). %%  brodet hageby

sameplace(brosmadsvingen,bromstadsvingen). 
sameplace(bromstadssvingen,bromstadsvingen). %% ss brumstadssvingen. 

%% sameplace(bryggen,pirbadet). %% Aker brygge  
sameplace(br�setflaten,br�setflata). 
sameplace(br�sethageby,br�set_hageby). 
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

sameplace(by�senbutikksenter,by�sen_butikksenter). 
sameplace(by�sensenteret,by�sen_butikksenter). 
sameplace(by�senskole,by�sen_skole).
sameplace(by�senskolen,by�sen_skole).

sameplace(by�senvei,by�s_street). %% problem
sameplace(by�senveien,by�s_street). 

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

sameplace(dalg�rdvegen,dalg�rdstien). 

sameplace(dalgard,dalg�rd). %%  dlgar

sameplace(dalhaug,dalhaug_street). 
sameplace(dalheim,dalheim_street). 
sameplace(dalsaunevegen,dalsauneveien). %allow1spell
sameplace(dokken,solsiden). 
sameplace(dokkhavna,solsiden). 
sameplace(dokkporten,solsiden). 
sameplace(dolpen,dolpa). %% dolpen p� kart 
sameplace(domkjerka,domkirken). 
sameplace(doningensgate,dronningens_gate). 
sameplace(downtown,hovedterminalen). 

sameplace(dragevold,dragvoll).  %% syn dragovold
sameplace(dragvol,dragvoll).
sameplace(dragvollan,dragvoll). 
sameplace(dragv�l,dragvoll).  
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

sameplace(eberg,�stre_berg). 
sameplace(einartambarskjelvesgate,einar_tambarskjelves_gate). 
sameplace(elgeseterbrua,studentersamfundet). 
sameplace(elgesetergata,elgeseter).  %%-s�terbakken?
sameplace(elgesetergate,elgeseter). 
sameplace(elgesetergaten,elgeseter).  %%Necessary,elgesetergt1=s�terbakken(SIC)
sameplace(elgesetergt,elgeseter). 
sameplace(elges�tergate,elgeseter). 
sameplace(elges�ther,elgeseter). 
sameplace(elgseter,elgeseter). 
sameplace(elgseterbro,studentersamfundet). 
sameplace(elgseterbru,studentersamfundet). 
sameplace(elgsetergate,elgeseter). 
sameplace(elgsether,elgeseter). 
sameplace(elgs�ter,elgeseter). 
sameplace(elgs�tergate,elgeseter). 
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
sameplace(flat�sne,flat�sen). %% flat�snne 
sameplace(flataasen,flat�sen). 
sameplace(flatayen,flat�sen). %% TA-110116 flatåen  
sameplace(flat�sensenter,flat�sen_senter). 
sameplace(flat�sensenteret,flat�sen_senter). 
sameplace(flat�sentoppen,flat�stoppen). 
sameplace(flat�ssenteret,flat�sen_senter). 
sameplace(flystasjonen,v�rnes). 
sameplace(folkemuseet,tr�ndelag_folkemuseum). 
sameplace(folkemuseum,tr�ndelag_folkemuseum). 
sameplace(folkemuseumet,tr�ndelag_folkemuseum). 
sameplace(fosenkaia,ts). %% AtB.  %%tsisnot station
sameplace(fossagranda,fossegrenda). 
sameplace(fossegrande,fossegrenda).  %%(Amblehash:just neib switch)
sameplace(fotballstadion,lerkendal_stadion). 
sameplace(froderinnansveg,frode_rinnans_street). 
sameplace(gammellina,gammel_lina).  %%(_should be dropped). 
sameplace(gildevangen,s�ndregate).  %%(NB no message)
sameplace(ginakroghsgt,gina_krogs_veg). 
sameplace(gl�ahugen,gl�shaugen). 
sameplace(gl�shaug,gl�shaugen). 
sameplace(gl�sh�gen,gl�shaugen).  %%h�gem 
sameplace(godst,terminalen). 
sameplace(graaenm�lna,graaem�lna). 
sameplace(graaerm�lla,graaem�lna). 
sameplace(graaerm�lna,graaem�lna). 
sameplace(graam�lna,graaem�lna). 
sameplace(graem�lla,graaem�lna). 
sameplace(graem�llen,graaem�lna). 
sameplace(granhaugan,granhaugen).  %% incl ganhaugen
sameplace(gran�sbakken,gran�sen_vm_anlegget). 
sameplace(gran�senvegen,gran�sveien). 

sameplace(grevskott,grevskotts). %% gfevskott 
sameplace(grevskots,grevskotts). %% grevsots 

sameplace(gr�em�lla,graaem�lna). 
sameplace(gr�enm�lla,graaem�lna). 
sameplace(gr�m�lna,graaem�lna). 
sameplace(gr�m�rna,graaem�lna). 
sameplace(g�gate,sentrum). 
sameplace(g�gaten,sentrum). 

sameplace(hallsetvei,nordre_hallset_street). %% etc 
sameplace(hallsteing�rd,halstein_g�rd). 
sameplace(hallsteing�rden,halstein_g�rd). 
sameplace(haugnesveien,haugnessvingen). 
sameplace(haukvante,haukvatnet). 
sameplace(havstadsetnret,havstadsenteret). 
sameplace(havsteinsenter,havstadsenteret). 
sameplace(havsteinsenteret,havstadsenteret). 
sameplace(hegdalringen,heggdalsringen). 
sameplace(heggdal,hegdalen). 
sameplace(heggdalen,hegdalen). 
sameplace(heggelia,hegdalen). 
sameplace(heggelien,hegdalen). 
sameplace(hegglia,hegdalen). 
sameplace(heggstadmo,heggstadmoen). 

sameplace(heggstamyra,heggstadmyra). %%hegstamyra heggstmyra 

sameplace(heglia,hegdalen). 
sameplace(heglidalen,hegdalen). 
sameplace(hegmoen,heggstadmoen). 
sameplace(hegstamoen,heggstadmoen). 
sameplace(hekstadmoen,heggstadmoen).
sameplace(heimdalstasjon,heimdal_stasjon). 
sameplace(herlofsonl�ypa,herlofsonsl�ypa).  %%2sp
sameplace(hestehagen,prof_brochs_gate). 
sameplace(hogskoleringen,h�gskoleringen). 
sameplace(holtermannsveg,holtermannsveien). 
sameplace(holtermannsvei,holtermannsveien). 
sameplace(holtermanveg,holtermannsveien).  %%Nofunk
sameplace(hoppbakken,gran�sen_vm_anlegget). 
sameplace(hopsitalskirka,hospitalkirka). 
sameplace(hopstilkirka,hospitalkirka). 
sameplace(hospitalet,st_olavs_hospital). 
sameplace(hospitalkirken,hospitalkirka). 
sameplace(hospitalskirka,hospitalkirka). 
sameplace(hospitalskirka,hospitalkirka).  %%NB
sameplace(hosptialskirka,hospitalkirka).  %%

sameplace(hosptalsl�kka,hospitalll�kka). %% +  hosptalslokka 

sameplace(hundhameren,hundhammeren). 
sameplace(hundhammarn,hundhammeren). 
sameplace(husbytun,husebytunet). 
sameplace(h�ggrenda,h�greina). 
sameplace(h�gseth,h�iset). 
%% sameplace(h�gskoleringen,h�gskoleringen). 
sameplace(h�iseth,h�iset). %% < h�isteh 
sameplace(h�yset,h�iset). 

sameplace(h�yskole,h�gskole).   %% TA-110221
sameplace(h�yskolen,h�gskolen). %%

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
sameplace(kinosenter,prinsen_kinosenter). 
sameplace(kirkes�ter�ra,kyrkseter�ra). 
sameplace(kirks�ter�ra,kyrkseter�ra). 
sameplace(klabu,kl�bu). 
sameplace(klebu,kl�bu).  %% ikke spell p� foreign ?
sameplace(koieflate,koieflata). 
sameplace(kolstadsenter,torplassen). 
sameplace(kojflata,koieflata). 
sameplace(kong�ysteinsv,kong_�ysteins_veg).  %%alas
sameplace(kong�ysteinsvei,kong_�ysteins_veg). 
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
sameplace(kyrks�ter�r�,kyrkseter�ra). 
sameplace(kyrks�ter�ya,kyrkseter�ra). 
sameplace(kyrks�ter�ya,kyrkseter�ra).  %%act
sameplace(ladeg�rd,lade_g�rd). 
sameplace(ladeg�rden,lade_g�rd). 
sameplace(ladehammern,ladehammeren).  %%gammern
sameplace(ladejarlen,ladejarlen_v_g_s).
sameplace(ladejarlen,ladejarlen_v_g_s). 
sameplace(lademoenkirke,lademoen_kirke). 
sameplace(ladesletta,haakon_vii_gate).  %%neib
sameplace(ladeuniversitet,ntnu_lade). 
sameplace(larkedal,lerkendal). %% eng 
sameplace(leangentravbane,travbanen). 
%% sameplace(leangveien,leangenveien). %% TA-110822
sameplace(leirbruag�rd,leirbrua_g�rd). 
sameplace(leirbrug�rd,leirbrua_g�rd). 
sameplace(leirfoss,nedre_leirfoss). 
sameplace(leirfossen,nedre_leirfoss). 
sameplace(leirg�rdbru,leirbrua_g�rd). 
sameplace(lerchendalskrysset,lerkendalskrysset). 
%% sameplace(lerkendal,lerkendal_stadion).  %% NB lerk //unnec,creates dbl entry
sameplace(lerkendalg�rd,lerchendal_g�rd). 
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
sameplace(l�reskole,l�rerskolen).  %%l�resskole
sameplace(l�itenhaven,leuthenhaven). 
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
                          %% not sentrumsterminalen whic itsel is a samename
sameplace(moholtalle,moholt).  %%
sameplace(moholtkirka,strinda_kirke).
sameplace(moholtkirke,strinda_kirke). 
sameplace(moholtkirken,strinda_kirke). 
sameplace(moholtsentret,moholtsenteret).  %% maybe unnec after rehash
sameplace(moholtstudentby,moholt_studentby). 
sameplace(moholttunet,moholttun). 
sameplace(mollenberg,m�llenberg).
sameplace(moltemyra,moltmyra).  %% captures p
sameplace(munkvold,munkvoll).   %% munkvild
sameplace(munkvoldg�rd,munkvoll_g�rd). 
sameplace(musikkmuseum,ringve_museum). 
sameplace(musikmuseum,ringve_museum). 
sameplace(m�h�lt,moholt). 
sameplace(m�lebaken,m�llebakken). 
sameplace(m�llenberg,nedre_m�llenberg). 
sameplace(m�llenberggate,nedre_m�llenberg_street).  %% \+ stat. 
sameplace(m�ller,m�ller_bil). 

sameplace(nardocenteret,nardosenteret). 
sameplace(nardocenter,nardosenteret). 
sameplace(nardosenter,nardosenteret). 
sameplace(nardosentre,nardosenteret). 
sameplace(nedreelvehavn,nedre_elvehavn). 
sameplace(nidaroshallen,trondheim_spektrum). 
sameplace(nidarr�dhallen,trondheim_spektrum). 
sameplace(nidarvollskole,nidarvoll_skole). 
sameplace(nidar�hallen,trondheim_spektrum). 
sameplace(nidar�hallene,trondheim_spektrum). 
sameplace(nordslett,nordslettveien_snuplass). %%  \+ nordset
sameplace(nordslettveiensnuplass,nordslettveien_snuplass). %% vegen 
sameplace(nova,nova_kinosenter). 
sameplace(novakino,nova_kinosenter). 
sameplace(ntnulade,ntnu_lade). 
sameplace(nygaard,nyg�rd).
sameplace(nyvegbakken,nyveibakken). 
sameplace(nyvegsbakken,nyveibakken). 
sameplace(nyveib,nyveibakken). 
sameplace(nyveisbakken,nyveibakken). 
sameplace(obslade,city_lade). 
%%sameplace(odenseveien,odensev). 
sameplace(ofstis,�fstis). %% 1. letter sp is not aut 
sameplace(okstadbakken,okstad). 
%% sameplace(okstadhaugen,okstad�y).  %%???
sameplace(olavsgate,st_olavs_gate). 
sameplace(olavshospital,st_olavs_hospital). 
sameplace(olavshospitalet,st_olavs_hospital). 
sameplace(olavtryggvasonsgate,olav_tryggvasons_gate). 
sameplace(olavtrygvasonsgt,olav_tryggvasons_gate). 
sameplace(ostmarkveien,�stmarkveien).
sameplace(othelianborg,othilienborg). 
sameplace(othileborg,othilienborg). 
sameplace(othilenberg,othilienborg). 
sameplace(otillenborg,othilienborg). 

sameplace(ourensveg,henrik_ourens_veg).  %%etc
sameplace(pederkroghsvei,peder_kroghs_v). 
sameplace(peirterminal,pirbadet).  
sameplace(persauneleir,persaunet_leir). 
sameplace(persaunetveien,persauneveien). %% TA-110415 
sameplace(persaunveien,persauneveien). %% TA-110415 
sameplace(persaunvn,persauneveien). %% TA-110415 
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

sameplace(postsentralen,postterminalen). 
sameplace(postterminal,postterminalen). %% posttermunal %% TA-110221

sameplace(presteaunet,persaunet). 
sameplace(prestegayrdjordet,presteg�rdsjordet).   %% TA-101123
sameplace(prestgayrdsjordet,presteg�rdsjordet).   %% 
sameplace(prestg�rdsjordet,presteg�rdsjordet).    %% TA-101122
sameplace(prestegaardsjordet,presteg�rdsjordet). 
sameplace(presteg�rdsalleen,presteg�rdsjordet). 
sameplace(presteg�rdsjordet,presteg�rdsjordet).  
sameplace(presteg�rdsjordet,presteg�rdsjordet).  %% allow preseteg�rdsjordet. 
sameplace(presteg�rdsjoret,presteg�rdsjordet). 
sameplace(presteg�rdstunet,presteg�rdsjordet). 
sameplace(presteg�rdsvegen,presteg�rdsjordet).  %% spurious but actual
sameplace(presteg�rjorde,presteg�rdsjordet). 
sameplace(presteg�rsjorde,presteg�rdsjordet). 
sameplace(presteg�sdsjordet,presteg�rdsjordet). 
sameplace(prestejordet,presteg�rdsjordet).  
sameplace(prestg�rdsjordet,presteg�rdsjordet). 

sameplace(prinsegata,prinsens_gate). 
sameplace(prinsegaten,prinsens_gate). 
sameplace(prinsengt,prinsens_gate).  %%(actual)
sameplace(prinsenkinosenter,prinsen_kinosenter). 
sameplace(prinsenkinosenteret,prinsen_kinosenter). 
sameplace(prinsensgatekinoene,prinsen_kinosenter). 
sameplace(priterminalen,pirbadet).  

sameplace(professorbrochsgate,prof_brochs_gate). 
sameplace(professorbrochs,prof_brochs_gate). 

sameplace(ragnhildsgt,ragnhlds_gate). 
sameplace(rambech,f_rambech).  %% F Rambech 
sameplace(regionsykehus,regionsykehuset). 

sameplace(ringvemuseum,ringve_museum).  
sameplace(risvollansenter,risvollan_senter). 
sameplace(risvollansenteret,risvollan_senter). 

sameplace(romolia,romolslia). 
sameplace(romulslia,romolslia).  %% romulslia street, prefer station

sameplace(ronningbakken,r�nningsbakken). 
sameplace(rosenborgskole,rosenborg_skole).  
sameplace(rosendalomr�det,rosendal). 
sameplace(rotvollan,rotvoll). 
sameplace(rotvollen,rotvoll). 
sameplace(rotvollene,rotvoll). 
sameplace(rovoll,rotvoll). %rovol
sameplace(r�nningensbakken,r�nningsbakken). %% e.g. r�nningensabakken
sameplace(samf,studentersamfundet). 
sameplace(samfonnje,studentersamfundet). 
sameplace(samfudnet,studentersamfundet).    

sameplace(stundentersamfundet,studentersamfundet).
sameplace(stundentsamfunnet,studentersamfundet). 
sameplace(samfund,studentersamfundet). 
sameplace(samfundet,studentersamfundet). 
sameplace(samfunnet,studentersamfundet). 
sameplace(sammfundet,studentersamfundet). 
sameplace(sammfunetet,studentersamfundet). 
sameplace(sammfunnet,studentersamfundet). 
%% sameplace(sanbaken,sandbakken).  %%inkl sandbaken,sanbakken
sameplace(saupstadsenter,saupstadsenteret). 
sameplace(saupstadveien,s�bstad_street).  %%street
sameplace(saupstapsentret,saupstadsenteret). 
sameplace(scandichotel,esso_motorhotell). 
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
sameplace(siemenskrysset,siemens).  %%(Ambiguous,butspecial)
sameplace(sigurdjorsalfarsvei,sigurd_jorsalfars_street). 
sameplace(sildredr�peveien,sildr�peveien). 
sameplace(sildropveien,sildr�peveien). 
sameplace(simenskrysset,siemens). 
sameplace(sjetnamrka,sjetnmarka). 
sameplace(sjetnemarka,sjetnmarka).     %% /sjetemarka 
sameplace(skavlandsv,skavlans_veg).   
sameplace(skavlandsveg,skavlans_veg). 
sameplace(skavlandsvei,skavlans_veg). 
sameplace(skavlansvei,skavlans_veg).  
sameplace(skihytta,skistua). 
sameplace(skihytten,skistua). 
sameplace(skovgard,skovg�rd). %%  + skavgard
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
sameplace(steinkj�r,steinkjer).   %% (steinskj�r)
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
sameplace(sverresborgfolkemuseum,tr�ndelag_folkemuseum). 
sameplace(sverresli,sverresborg).  %%?lia
sameplace(sykehyset,sykehuset). 
sameplace(s�bstad,saupstad). 
sameplace(s�bstadmyra,saupstad). 


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
sameplace(tempekirke,tempe_kirke). 
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
sameplace(tiller�sen,martin_kregnes_veg). 
sameplace(tine,norske_meierier). 
sameplace(tj�nn�sen,tj�nnlia).  %%(?)
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
sameplace(torgkvartalet,torget). 
%% sameplace(torgplassen,torget). %% ? torplassen 
sameplace(torgsenteret,torget).  
sameplace(torplas,torplassen). 
sameplace(torpsplass,torplassen).  %%?
sameplace(torpveien,ingemann_torps_vei). %ingemann_torps_street).  %%station
sameplace(torvet,torget).  %% catch sperr
sameplace(torvplassen,torget). 
sameplace(travbanestasjonen,travbanen). 
sameplace(travparken,travbanen). 
sameplace(trhsentralstasjon,ts). %% AtB. 
sameplace(trondheimsentral,ts). %% AtB. 
sameplace(trondheimsentralstasjon,ts). %% AtB. 
sameplace(trondheimstasjon,ts). %% AtB. %% inc  tronheimstasjon
sameplace(trondheimtorg,torget).  %% tronheimt�rg
sameplace(trondhjem,trondheim). 
sameplace(tronheimfengsel,tunga_kretsfengsel). 
sameplace(tryggvassonsgate, olav_tryggvasons_gate). %%  AtB %% TA-100515
sameplace(tryggvassonsgt,olav_tryggvasons_gate).    %% AtB  %% TA-100515
sameplace(tr�ndermeieriet,norske_meierier). 
sameplace(tungstadkrysset,tonstadkrysset). 
sameplace(tvereggen,tverregga).  %% Confusion
sameplace(tverreggen,tverregga). 

sameplace(tyholtst�rnet,tyholtt�rnet). %% tyholtstarnet 
sameplace(tyholtornet,tyholtt�rnet).   %% NB 1 t in route db
sameplace(tyholt�rnet,tyholtt�rnet).   %% allow tyholt�rent 
                                       %% changed to tyholtt�rnet Xmas 08
sameplace(t�get,ts). %% AtB. 
sameplace(t�gstasjonen,ts). %% AtB. 
sameplace(ulinvegen,ullins_street). 
sameplace(ulinvegen,ullins_street). 
sameplace(universitetssenteret,universitetet). 
sameplace(utsikten,utsikten_alle). 
%% sameplace(vaern,v�rnes). // valerveien -> va(l)er(n) -> v�rnes 
sameplace(vaernes,v�rnes). 
sameplace(vaerness,v�rnes). 
sameplace(valdgrindsvegen,valgrindveien). 
sameplace(valentilystsenteret,valentinlyst). 
sameplace(valentilystsentret,valentinlyst). 
sameplace(valentinlystvegen,valentinlystveien). 
sameplace(val�y,val�yvegen). 
sameplace(val�yvegen,val�yvegen). 
sameplace(vandrerhjemmet,sig_berg_alle).  %%+vandrehjemmet
sameplace(varnes,v�rnes). 
sameplace(varness,v�rnes). 
sameplace(velgrindvegen,valgrindveien). 
sameplace(vernes,v�rnes). 
sameplace(vern�s,v�rnes). 
sameplace(vestrerosten,vestre_rosten).  %%vestreostren
sameplace(vikelva,vikelvveien). 
sameplace(vikhamarl�kka,vikhammer�sen). 
sameplace(volabake,vollabakken).  %% vollabake,volabakke
sameplace(vollg�rd,voll_g�rd). 
sameplace(vollstudby,voll_studentby). 
sameplace(vollstudby,voll_studentby). 
sameplace(vollstudentby,voll_studentby). 
sameplace(v�danvn,v�danv_5). 
sameplace(v�ddanveien,v�danv_5). 
sameplace(v�retr�a,v�restr�a). %% new official name  e.g. v�retr�a. 
sameplace(v�rness,v�rnes).  %%(not genitive!)

sameplace(vullumsg�rden,by�sen_butikksenter). %% vyllumsg�rden.
sameplace(wullumsgaard,by�sen_butikksenter). 
sameplace(wullumsgaaren,by�sen_butikksenter). 
sameplace(wullumsgaren,by�sen_butikksenter). 



sameplace(wullumsg�rd,by�sen_butikksenter). 


sameplace(�sheimskole,�sheim_skole). 
sameplace(�sv,�sveien_skole).  %%Troublespot
sameplace(�sveienskole,�sveien_skole).  %%�sveieskole


sameplace(�streberg,�stre_berg). %% �steberg 

sameplace(�stmarkneset,�stmarkveien).  %%nesset
sameplace(�vreromolslia,romolslia_�vre). 
sameplace(kattemsentret,kattemsenteret). 

short_specname(ranheim_stasjon,'Ranheim st. '). 
short_specname(d1,'Dronn. gt D1'). 
short_specname(d2,'Dronn. gt D2'). 
short_specname(d3,'Dronn. gt D3'). 
short_specname(d4,'Dronn. gt D4'). 

short_specname(dronningens_gate,'Dronn. gt').
 
short_specname(dronningens_gate_d1,'Dronn. gt D1'). %% AtB
short_specname(dronningens_gate_d2,'Dronn. gt D2'). 
short_specname(dronningens_gate_d3,'Dronn. gt D3'). 
short_specname(dronningens_gate_d4,'Dronn. gt D4'). 

short_specname(dronningens_gate,'Dronn. gt'). 
short_specname(dronningens_gate_d1,'Dronn. gt D1'). 
short_specname(dronningens_gate_d2,'Dronn. gt D2'). 
short_specname(dronningens_gate_d3,'Dronn. gt D3'). 
short_specname(dronningens_gate_d4,'Dronn. gt D4'). 

short_specname(dronningensgate_d1,'Dronn. gt D1'). 
short_specname(dronningensgate_d2,'Dronn. gt D2'). 
short_specname(dronningensgate_d3,'Dronn. gt D3'). 
short_specname(dronningensgate_d4,'Dronn. gt D4'). 


short_specname(einar_tambarskjelves_gt,'Einar Tambarskj. gt'). 
short_specname(haakon_vii_gate_17,'Haakon7. gate 17'). 
short_specname(haakon_vii_gate_25,'Haakon7. gate 25'). 
short_specname(haakon_vii_gate_29,'Haakon7. gate 29'). 
short_specname(haakon_vii_gate_9,'Haakon7. gate 9'). 
short_specname(heimdal_stasjon,'Heimdal st. ').  %% Extra sp
short_specname(hovedterminalen,'Sentrumsterminalen'). 
short_specname(johan_falkbergets_vei,'J Falkbergets v'). 
short_specname(j�rgen_b_lysholms_vei,'J. B. Lysholmsv'). 
%% short_specname(lerkendal_stadion,'Lerkendal st. ').  %% %% Extra sp

short_specname(munkegata_m1,'Munkegt M1'). %% AtB
short_specname(munkegata_m2,'Munkegt M2'). 
short_specname(munkegata_m3,'Munkegt M3'). 
short_specname(munkegata_m4,'Munkegt M4'). 
short_specname(m41,'Munkegt M41'). 
short_specname(munkegata_m5,'Munkegt M5'). 

short_specname(m1,'Munkegt M1'). 
short_specname(m2,'Munkegt M2'). 
short_specname(m3,'Munkegt M3'). 
short_specname(m4,'Munkegt M4'). 
short_specname(m41,'Munkegt M41'). 
short_specname(m5,'Munkegt M5'). 

short_specname(moholt_studentby,'Moholt stud. by'). 
short_specname(munkegata,'Munkegt'). 
short_specname(prinsen_kinosenter,'Prinsen kinos. '). 
short_specname(prof_brochs_gate,'Prof. Brochs gt'). 
short_specname(studentersamfundet_1,'Stud. samf. 1'). 
short_specname(studentersamfundet_2,'Stud. samf. 2'). 
short_specname(ts,'Trondheim S'). 

short_specname(ts_10,'Trondheim S 10').  %% old names
short_specname(ts_11,'Trondheim S 11').  %% (avoid list of identical names)
short_specname(ts_13,'Trondheim S 13').  %%

short_specname(ts10,'Trondheim S 10'). 
short_specname(ts11,'Trondheim S 11').  %% (avoid list of identical names)
short_specname(ts13,'Trondheim S 13').  %%

short_specname(universitetet_lade,'Univ. Lade'). 

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
specname(adolf_�ien,'Adolf �ien').  %%school/street
specname(alf_godagers_vei,'Alf Godagers vei'). 
specname(amo_senteret,'AMO senteret'). 
specname(anders_buens_gate,'Anders Buensgate').  %% EH-031017
specname(angelltr�veien,'Angelltr�veien'). 
specname(ankers_gt,'Ankersgate').  %% EH-030616
specname(arilds_gt,'Arildsgate').  %% EH-030616
specname(arnt_smistads_vei,'Arnt Smistads vei').  %%\+smistad(correction)
specname(asbj�rn_over�s_veg,'Asbj�rn �ver�s veg'). 

specname(asbj�rnsens_gate,'Asbj�rnsens gate'). %% old ?
specname(asbj�rnsensgt,'Asbj�rnsens gate').  %% EH-030616

specname(asbj�rnsens_gt,'Asbj�rnsens gate'). 
specname(atb,'AtB').  %% TA-101108

specname(bakkegata,'Bakkegate').  %% EH-030616
specname(bakkebru,'Bakkebru'). 
specname(balders_street,'Balders veg').  %%Syndrome/not regstr
specname(bekkasinv,'Bekkasinvegen').  %% EH-031017
specname(bergstudentby,'Berg studentby'). 
specname(bi,'BI'). 
specname(biskop_sigurdsgt,'Biskop Sigurds gate').  %% EH-031017
specname(bjarne_ness_veg,'Bjarne ness vei'). 
%% specname(bj�ra,'Bj�ra'). 
specname(bj�rkmyr,'Bj�rkmyr'). 
specname(blusuvoll_alle,'Blusuvoll all�'). 
specname(brannstasjon_�st,'Brannstasjon �st'). 
specname(bratt�rbrua,'Bratt�rbrua'). 
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
specname(br�set_hageby,'Br�set hageby'). 
specname(br�setflata,'Br�setflata'). 
specname(br�setv,'Br�setvegen'). 
specname(br�setvegen_168,'Br�setvegen 168').  %% vei-> veg for konsistens EH-031017
specname(br�setvegen_186,'Br�setvegen 186').  %% NB. vei->veg EH-031017
specname(br�setvegen,'Br�setvegen'). 
specname(br�setvegen_119,'Br�setvegen 119'). 
specname(busstuc,'BussTUC'). 
specname(bybro,'Gamle bybro').
specname(byen,byen). 
specname(by�sen_butikksenter,'By�sen butikksenter'). 
specname(by�sen_sk,'By�sen skole'). 
specname(by�sen_videreg�ende_skole,'By�sen videreg�ende skole'). 

%% specname(b�ckmansveien,'B�ckmans veg'). %% Nix %% TA-110314

%% specname(c_j_hambros_vei,'C J Hambros vei').  %% unnec TA-101111

specname(carl_schjetnans_vei,'Carl Schjetnans vei'). %% TA-110322
%% specname(c_schjetnans_v,'C Schjetnansvei').       %% 

specname(charlottenlund_kirke,'Charlottenlund kirke'). %% unnec
specname(charlottenlund_kirke,'Charlottenlund kirke'). 

specname(charlottenlund_skole,'Charlottenlund skole'). 
specname(charlottenlund_vdereg�en,'Charlottenlund videreg�ende'). 
specname(charlottenlund_videreg�ende,'Charlottenlund videreg�ende'). 
specname(chr_eggens_veg,'Christian Eggens veg').  %% EH-030616
specname(chr_monsensgt,'Christian Monsens gate').  %% EH-031017
specname(christian_jelstrups_v,'Christian Jelstrups vei').  %% EH-030616
specname(churchills_v,'Churchills vei').  %% EH-030616

specname(dmmh,'DMMH'). %% TA-110323

%% drop holdeplass %% TA-110531

specname(dronningens_gate_d1,'Dronningens gate D1').  
specname(dronningens_gate_d2,'Dronningens gate D2'). 
specname(dronningens_gate_d3,'Dronningens gate D3'). 
specname(dronningens_gate_d4,'Dronningens gate D4'). 

specname(d1,'Dronningens gate D1').  %% EH-031120
specname(d2,'Dronningens gate D2').  %% 
specname(d3,'Dronningens gate D3').  %%
specname(d4,'Dronningens gate D4').  %%

specname(den,'den'). %% M .. den godes gate ... 

specname(devle_g�rd,'Devleg�rd'). 
specname(dist_lege_�vrelids_v,'Distriktslege �vrelid svei').    %% EH-030616
specname(distriktslege_�verlidsv,'Distriktlege �vrelids vei').  %% EH-030616
specname(dps,'DPS'). 
specname(dragvoll_alle,'Dragvoll all�'). 
specname(dronningens_gate,'Dronningens gate'). 
specname(dv,'Dragvoll').  %% Small letters/not Endstation
%% specname(dybdals_veg,'Dybdals veg'). %% TA-100830 unnec
specname(e_a_smith,'E A Smith').  %% EH-031017 
specname(e_b_schieldropsv,'E B Schieldropsvei').  %% EH-030616
specname(einar_tambarskjelves_gt,'Einar Tambarskjelves gate').  %% EH-030616
specname(einar_�fstis_veg,'Einar �fstis veg'). 
specname(engels�s_endeholdeplass,'Engels�s endeholdeplass'). 
specname(f_rambech,'F Rambech').  %% EH-031017
specname(fagerheim_all,'Fagerheim all�'). 
specname(fagerheim_alle,'Fagerheim all�').  %% EH-030616
specname(fagerliv,'Fagerliveien').  %% EH-031017
specname(festningsgt,'Festningsgata'). 			 %% EH-031002 gaten->gata
 %% specname(festningsgt,'Festningsgaten'). 
specname(fj�slia,'Fj�slia'). 
specname(fj�svollan,'Fj�svollan'). 
specname(fors�ket,'Fors�ket'). 
specname(gl�shaugen_nord,'Gl�shaugen Nord'). 
specname(gl�shaugen_syd,'Gl�shaugen Syd'). 
specname(godsterminalen_nsb,'Godsterminalen NSB').  %%(dontprintwhatisnot accepted)EH-030616
specname(gran�sen_g�rd,'Gran�sen g�rd'). 
specname(gran�sen_vm_anlegget,'Gran�sen VM-anlegget'). 
specname(gudes_gt,'Gudes gate'). 			 %% EH-030616
specname(gudruns_gate,'Gudruns gate'). 			 %% EH-030616
specname(haakon_vii_gt,'Haakon VII gate'). 
specname(haakon_vii_gate_17,'Haakon den sjuendes gate 17'). 
specname(haakon_vii_gate_25,'Haakon den sjuendes gate 25'). 
specname(haakon_vii_gate_29,'Haakon den sjuendes gate 29'). 
specname(haakon_vii_gate_9,'Haakon den sjuendes gate 9'). 
specname(hallfred_h�yems_vei,'Hallfred H�yems vei'). 
specname(halstein_g�rd,'Halstein g�rd'). 
specname(harald_bothnersv,'Harald Bothners vei'). 	 %% EH-030616
specname(harald_h�rfagres_gt,'Harald H�rfagres gate'). 
specname(heggstadmoen_4,'Heggstadmoen 4').  %% slight error in busroute
%%%  specname(heimdal_st,'Heimdal stasjon').  
specname(heimdalsveien,'Heimdalsvegen').  %% (not . ) EH-030616. vei-> veg EH-031017
%% specname(heimdalsv,'Heimdalsveien').  %% (not . ) EH-030616
specname(heimdal_sentrum,'Heimdal sentrum'). %%  week 33/34?

%% specname(henrik_ourens_vei,'Henrik Ourens vei').  %% (extra dot in reghpl) EH-030616
specname(hist,'HIST').  %% (IKKE Hist!)
specname(hjalmar_johansens_vei,'Hjalmar Johansens vei'). 
specname(hospitalkirka,'Hospitalskirka').  %%(Rutehefte)
specname(hotel,'Hotel'). 
specname(hotell,'Hotell'). 
specname(hovedterminalen,'Sentrumsterminalen').  %% // Political decision
specname(h�greina_�vre,'H�greina �vre'). 
specname(h�yset,'H�yset'). 
specname(idi,'IDI').  %% TA-110401
specname(ingeborg_ofstadsv,'Ingeborg Ofstads veg').  %% EH-031017
specname(jakobslivegen_�vre,'Jakobsliveien �vre').  %%jakobsliv
specname(jakobsliveien_nedre,'Jakobsliveien nedre').  %%jakobslivn!!
specname(johan_falkbergets_vei,'Johan Falkbergets veg').  %%Talsmann
specname(johan_p_kroglundsv,'Johan P Kroglunds vei'). 
specname(johan_tillers_vei,'Johan Tillers vei').  %% EH-031017
specname(johannes_minsaas_veg,'Johannes Minsaas veg'). 
specname(john_aaes_veg,'John Aaes veg').  %% (avoid, Aae`s in return)
specname(j�rgen_b_lysholms_vei,'J�rgen B Lysholms vei'). 
specname(k_jonssons_veg,'Karl Jonssons vei'). 
specname(k_o_thorn�s_vei,'K O Thorn�s vei').  %% EH-030616
specname(kbs,'KBS').
specname(kbs_senteret,'KBS-senteret'). 
specname(kino,'"kino"'). 
specname(klett_m�bel,'Klett M�bel'). 
specname(kl�bu_skysstasjon,'Kl�bu skysstasjon'). 
specname(kong_�ysteins_veg,'Kong �ysteins veg'). 
specname(kronprins_olavs_alle,'Kronprins Olavs all�'). 
%% specname(kroppanmarka_endehpl,'Kroppanmarka endeholdeplass'). 
specname(kuset_g�rd,'Kuset g�rd'). 
specname(kvt,'KVT'). 
specname(kystad_alle,'Kystad all�'). 
specname(k�ff,'K�FF'). 


specname(lade_all,'Lade all�'). %% 'Lade all�').  AtB
specname(lade_alle_80,'Lade all� 80'). 


specname(lade_alle,'Lade all�'). %% 'Lade all�').  AtB
specname(lade_alle_80,'Lade all� 80'). 


specname(lade_kirke,'Lade kirke'). 
specname(ladejarlen_v_g_s,'Ladejarlen skole'). %% realspeak 
specname(lademoen_kirke,'Lademoen kirke'). 
specname(lademoen_skole,'Lademoen skole'). 
specname(leangen_all,'Leangen all�'). 
specname(leangen_alle,'Leangen all�'). 
specname(leira_sk,'Leira skole').
specname(leirfossveien,'Leirfossveien'). 
specname(leir�ya,'Leir�ya'). 
specname(lerchendal_g�rd,'Lerchendal g�rd'). 
specname(lingit,'LingIT'). 
specname(loholt_alle,'Loholt all�'). 
specname(los_angeles,'Los Angeles').  %% for American queries
specname(lund�sen_n,'Lund�sen nedre').  %% Talsmann
%% specname(l�vaasveien,'L�vaasveien').  %% TA-110530  unnec


specname(munkegata_m0, 'Munkegata M0').  
specname(munkegata_m1, 'Munkegata M1'). 
specname(munkegata_m2, 'Munkegata M2'). 
specname(munkegata_m3, 'Munkegata M3'). 
specname(munkegata_m4, 'Munkegata M4'). 
specname(munkegata_m5, 'Munkegata M5'). 
specname(munkegata_m41, 'Munkegata M41').%% TA-110107
specname(m41, 'Munkegata M41'). %% SIC (in route data) %% TA-110107

specname(m0, 'Munkegata M0').  %% keep old names also 
specname(m1, 'Munkegata M1').  %%
specname(m2, 'Munkegata M2').  %%
specname(m3, 'Munkegata M3').  %%
specname(m4, 'Munkegata M4').  %%
specname(m5, 'Munkegata M5').  %%

specname(magnus_berf�ttsvei,'Magnus Berf�tts vei').  %% EH-031017
specname(magnus_blindesv,'Magnus Blindes vei'). 	  %% EH-030616
specname(marcus_thranesv,'Marcus Thranes vei'). 	  %% EH-030616
specname(margretes_gt,'Margretes gate'). 
specname(marie_s�rdals_veg,'Marie S�rdals veg'). 
specname(markaplassen_vest,'Markaplassen Vest'). 
specname(markaplassen_�st,'Markaplassen �st'). 
specname(markaplassen_skole,'Markaplassen skole').   
specname(mauritz_hansens_gt,'Mauritz Hansens gate'). 	%% EH-030616
 %% specname(mellomv_5,'Mellomveien 5'). 	
specname(mentz_skjetnes_v,'Mentz Skjetnes vei'). 	   %% EH-030616
specname(moltmyra_�st,'Moltmyra �st'). 


specname(munkvoll_g�rd,'Munkvoll g�rd'). 
specname(m�llebakken,'M�llebakken'). 
specname(m�ller_bil,'M�ller bil'). 
specname(n_g_u,'NGU'). 
specname(n_t_h,'NTH'). 
specname(naf,'NAF'). 
specname(nedre_alle,'Nedre all�'). 
specname(nedre_alle,'Nedre all�'). 
specname(nedre_elvehavn,'Nedre elvehavn'). 
specname(nedre_m�llenberg,'Nedre M�llenberg'). 
specname(nidarvoll_sk,'Nidarvoll skole'). 
specname(nidarvoll_skole,'Nidarvoll skole'). %% old
specname(nkl,'NKL'). 
specname(nordre_halset,'Nordre Hallset'). 
specname(nordre_hoem,'Nordre Hoem'). 
specname(nordslettveien_snuplass,'Nordslettveien snuplass'). 
specname(norske_meierier,'Norske meierier'). 
specname(nova_kinosenter,'Nova kinosenter').  %%k
specname(nrk,'NRK'). 
specname(nth,'NTH'). 
specname(ntnu,'NTNU'). 
specname(ntnu_lade,'NTNU Lade').  %%Outdated
specname(obs,'OBS'). %not offic. 
specname(city_syd,'City Syd').    %% NEC, CS no longer station %% TA-110624
specname(city_lade,'City Lade').  %%Changedname,not inRouteData
%% specname(odensev,'Odenseveien').  %% EH-031017
specname(okstad�y,'Okstad�y'). 
specname(ola_setroms_vei,'Ola Setroms vei'). 
specname(olaf_bulls_vei,'Olaf Bulls vei'). 	
specname(olav_engelbrektssons_all,'Olav Engelbrektssons all�').   %% AtB %% TA-101018
specname(olav_engelbrektssons_alle,'Olav Engelbrektssons all�').  %% EH-031017
specname(olav_nyg�rdsv,'Olav Nyg�rds vei'). 
specname(olav_trygvassons_gt,'Olav Tryggvasons gate').  %% AtB MISSPELLEDINDATABASE
specname(olav_tryggvasons_gt,'Olav Tryggvasons gate').  %%Default

specname(omkj�ringsv_kl�buvveien,'Omkj�ringsveien Kl�buveien').  %% EH-031121
specname(omkj�ringsveien_moholt,'Omkj�ringsveien Moholt'). 
specname(omkj�ringsveien_nardo,'Omkj�ringsveien Nardo'). 
specname(oscar_wistingsv,'Oscar Wistings vei').  %% EH-031017
specname(otto_nielsens_veg,'Otto Nielsens vei'). 
specname(paul_skolemesters_veg,'Paul skolemesters veg').%% TA-110803

specname(peder_kroghs_v,'Peder Kroghs vei'). 
specname(peder_morsets_vei,'Peder Morsets vei'). 	
specname(persaunet_leir,'Persaunet leir'). 
specname(persaunev,'Persauneveien'). %% outdated?
specname(presteg�rdsjordet,'Presteg�rdsjordet').  %% (error)
specname(prinsen_kinosenter,'Prinsen kinosenter').  
specname(prinsens_gate,'Prinsens gate'). 
specname(r_i_t_hovedporten,'St Olavs hospital'). 
specname(ranheim_kirke,'Ranheim kirke').  %% k 
specname(reppe_endehlp,'Reppe endeholdeplass'). 
specname(ringve_skole,'Ringve skole'). 
specname(risvollan_senter,'Risvollan senter').
specname(rit,'RIT'). 
specname(roial_garden,'Royal Garden').  %% Nattbuss Spell
specname(rormyra,'R�rmyra'). 
specname(rosenborg_gt,'Rosenborg gate'). 	
specname(rosenborg_sk,'Rosenborg skole'). 

specname(rosenborg_skole,'Rosenborg skole'). %% AtB

specname(rotvoll_all,'Rotvoll all�'). 
specname(royal_garden,'Royal Garden'). 
specname(royal_garden_hotell,'Royal Garden hotell'). %% airbus

specname(rye_skole,'Rye skole').
specname(santa_barbara,'Santa Barbara'). 
specname(sas,'SAS'). 
specname(saxenborg_all,'Saxenborg all�'). 
specname(esso_motorhotell,'Esso Motorhotell').  %% ??? (Old station name)
specname(senter,senter). 
specname(sentrum,sentrum). 

%% specname(sig_berg_alle,'Sigurd Bergs all�').   
                                               
specname(singsaker_studenthjem,'Singsaker studenthjem'). 
specname(sivert_thonstadsv,'Sivert Thonstads vei'). 	 %% EH-030616
specname(sk,skole). %% nohelp?
specname(skavlans_vei,'Skavlands vei'). 
specname(smstuc,'SMSTUC'). 
specname(solbakken_skole,'Solbakken skole'). 
specname(solberg_mek_verksted,'Solbergmekaniskeverksted'). 	 %% EH-030616
specname(sondre_hoem_sporvogn,'S�ndre Hoems porvogn'). 
specname(st_olavs_hospital_vest,'St Olavs hospital vest'). 
specname(st_olavs_hospital_�st,'St Olavs hospital �st'). 

%%% specname(st_olavs_hospital,'St Olavs hospital hovedporten').
%% TA-100827
specname(st_olavs_street,'St Olavs     gate'). 
specname(st_olavs_gate,'St Olavs gate'). 
specname(st_olavs_hospital,'St Olavs hospital'). 
specname(statens_hus,'Statens hus'). 
specname(stavset_senter_2,'Stavset senter 2').  %%, holdeplass 2'). 
specname(steinanstudentby,'Steinan studentby'). 
specname(strinda_kirke,'Strinda kirke'). 
specname(strindheim_sk,'Strindheim skole'). 
specname(studentersamfundet_1,'Studentersamfundet 1'). 
specname(studentersamfundet_2,'Studentersamfundet 2'). 
specname(st�ren_st,'St�ren stasjon'). 
specname(sverresborg_alle,'Sverresborg all�'). 
specname(sverresborg_folkemuseum,'Sverresborg folkemuseum'). 
specname(s�terbakken_bratsberg,'S�terbakken Bratsberg'). 
specname(s�ndre_gate_22,'S�ndre gate 22'). 
specname(s�ndre_gate_23,'S�ndre gate 23'). 
specname(s�ndre_hoem,'S�ndre Hoem'). 
specname(s�ndregate,'S�ndre gate').  %% The neighbourhood (22/23)

specname(tagore,'Tagore'). 

specname(tbane,'T-bane'). 
specname(tempevegen_11,'Tempevegen 11'). 
specname(tempe_kirke,'Tempe kirke').   
specname(tempe_kirke,'Tempe kirke').  %% Airbus name
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

specname(ts10,'Trondheim Sentralstasjon ') :- myflags(airbusflag,true),!. 
specname(ts11,'Trondheim Sentralstasjon ' ):- myflags(airbusflag,true),!.  
specname(ts13,'Trondheim Sentralstasjon')  :- myflags(airbusflag,true),!. 

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
specname(tyholt_alle,'Tyholt all�'). 
specname(tyholtv,'Tyholtvegen').  %%Talsmann
specname(tyholtv,'Tyholtveien').  %% EH-031017
specname(t�h,'T�H'). 
specname(ullins_vei,'Ullins vei'). 
specname(universitetet_lade,'Universitetet Lade'). 
specname(utsikten_alle,'Utsikten all�'). 
specname(valentinlystv,'Valentinlystvegen'). 
specname(valset_g�rd,'Valset g�rd').  %% outdated 
specname(val�yvegen,'Val�yvegen'). 
specname(val�yvegen,'Val�yvegen').  %% EH-031017 vei->veg. Korrekt/entydig skrivem�te
specname(veisletten_alle,'Veisletten all�'). 
specname(vestlia_endeholdeplass,'Vestlia endeholdeplass'). 
specname(vik�sen_skole,'Vik�sen skole'). 
specname(vollgt,'VOLLGATEN'). 
specname(v�danv_5,'V�danveien 5'). 
specname(v�re_�stre,'V�re �stre'). 
specname(v�retroa,'V�restr�a'). 
specname(v�restroa,'V�restr�a'). 
specname(v�restr�a,'V�restr�a'). %% Off name  
specname(�vre_alle,'�vre all�'). 
specname(�vre_flat�sv,'�vre Flat�sveg'). 
specname(�ya_helsehus,'�ya Helsehus').		%RS-110926


%% Trapez -> Hastus synplaces 

%%%%%%%%% synplace(tveregga,tvereggen).
%%%%%%%%% synplace(tverregga,tvereggen).

synplace(rosa,ross). %% ? %% TA-110415 Ole Ross veg
synplace(rosta,rosten). %% / 
synplace(ostmarka,�stmarka). 
%% synplace(ola,ila). %% Haz? %% TA-110328

synplace(olavtrygvasonsgate,olav_tryggvasons_gate). %% CORREC %% TA-101203 %% AtB

synplace(berf,berg). %% ?
synplace(bert,berg). %% ?

synplace(berf�ttsvei,berrf�ttsveg).   
synplace(berrf�ttsvei,magnus_berrf�ttsveg). 

synplace(easmith,e_a_smith). 

synplace(mobilt,moholt). %% ???

%%%% synplace(engelbrektssons,engelbrektsons).
%%%% synplace(morsets,morsetts).
%%%% synplace(morset,morsett).

synplace(morseths,morsets). %% NEC

synplace(sta�ren,st�ren). %% TA-101221

%% synplace(stein�sen,sein�sen). 

%% synplace(stiklestadveien,stiklastadveien). %% fixed 
synplace(stiklesveien,stiklestadveien). %% ?

synplace(polishuset,ts). %% AtB. %%  ts is neib). 

synplace(reppekrysset,reppevegen). %%  reppevegen is not in the routes


synplace('va|retra�a',v�restr�a).
synplace(val,valentinlyst).
synplace(valgrindveien,valgrindsveien). 
synplace(v�retr�a,v�restr�a). %% NB v�res
synplace(v�ret�a,v�restr�a).   %%
synplace(skj�ness,sj�ness).
synplace(toming,thonning). 
synplace(tornes,thorn�s). %% TA-110203
synplace(torpsvei,torps_vei).
synplace(oppland,opland).
synplace(presteg�rsjordet,presteg�rdsjordet).
synplace(endeholdepl,endehpl).
synplace(tyholt�rnet,tyholtt�rnet).   %% NB 1 t

synplace('by''n',sentrum).  %%By'n==>'by''n'
synplace('la''moen',lademoen). 
synplace(aaer,aaes). 
synplace(aamfundet,samfundet).  %%?
synplace(aasheim,�sheim). 
synplace(aasn,aaes). 
synplace(aasveienskole,�sveien_skole). 
synplace(adgenes,agdenes). 
synplace(adressa,adresseavisen). 
synplace(aentralstasjonen,ts). %% AtB. 
synplace(aila,ila).  %% ?
synplace(akobsli,jakobsli). 
synplace(alcatraz,munkholmen). %% :-)
synplace(alentinlyst,valentinlyst).  %% ?
synplace(alesund,�lesund). 
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
synplace(ambj�rnsensgate,asbj�rnsens_gate).  %%(nospellc)
synplace(amfundet,samfundet).  %%neib
synplace(amfunnet,samfundet).  %%
synplace(amigosenteret,migosenteret). %% TA-100519
synplace(amunkegata,munkegata). 
synplace(andersbuensgate,anders_buens_gate). 
synplace(andersbuesgate,anders_buens_gate). 
synplace(angelltr�vegen,angelltr�veien). 
synplace(ankererveien,ankerveien). 
synplace(anlegg,anlegget). 
synplace(anleggene,anlegget). 
synplace(anrdo,nardo).  %% ? 
synplace(antongrevskottsgate,anton_grevskotts_vei). 
synplace(antongrevskottsgt,anton_grevskotts_vei). 
synplace(antongrevskottsvei,anton_grevskotts_vei).
synplace(ardo,nardo).  %%?
synplace(arnebergg�rdsv,arne_bergsg�rds_vei). 
synplace(arnebergg�rdsvei,arne_bergsg�rds_vei). 
synplace(arnebergsg�rdsvei,arne_bergsg�rds_street).  %%(systemat?)
synplace(arnebergsg�rdsvei,arne_bergsg�rds_vei).  
synplace(arntsmistadsv,arnt_smistads_vei).  
synplace(asbj�rnsgate,asbj�rnsens_gate). 
synplace(asbj�rnsveien,asbj�rnsens_gate). 
synplace(asbj�rn�ver�sveg,asbj�rn_�ver�s_street). 
synplace(asentrum,sentrum). 
synplace(askeladenveien,askeladdvegen). 
synplace(astronautveien,astronom_street). 
synplace(astt,tt). 
synplace(astudentersamfundet,studentersamfundet). 
synplace(asveien,�sveien). 
synplace(atrindheim,strindheim). 
synplace(atudentersamfundet,studentersamfundet). 
synplace(auran,buran).  %% ?
synplace(austmarka,�stmarka). 
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
synplace(balg�rd,dalg�rdd). 
synplace(baneg�rden,jernbanestasjonen). 
synplace(banestasjon,jernbanestasjonen). 
synplace(banestasjonen,jernbanestasjonen). 
synplace(bardo,nardo). 
synplace(barfots,berrf�tts). 
synplace(barneavd,barneklinikken).  %%synname
synplace(barneskole,skole). 
synplace(barneskole,skole). 
%% synplace(barnhage,barnehage). 
synplace(bartlamoen,svartlamon). 
synplace(bartlamon,svartlamon). 
synplace(bbyen,byen). 
synplace(bbyn,byen).
synplace(beg,berg).  %% nohash<4
synplace(beldevere,belvedere). 
synplace(belverede,belvedere). 
synplace(berfoettsvei,berf�ttsvei). 
synplace(berg,bergs).  %%nohashbecausenot unknown
synplace(bergkirke,berg_presteg�rd). 
synplace(berg�rdsvei,bergsg�rdsvei). 
synplace(bestlia,vestlia). 
synplace(beunge,buenget). 
synplace(bharlottenlund,charlottenlund).  %%?
synplace(bidtbyen,sentrum). 
synplace(bik�sen,vik�sen). 
synplace(bilioteket,biblioteket). 
synplace(billettkontoret,servicekontoret). 
synplace(birbadet,pirbadet). 
synplace(birchs,brochs). 
synplace(biskopsigurdsgate,biskop_sigurds_gate). 
synplace(bispegaten,bispegata). 
synplace(biyosen,by�sen). 
synplace(bj�rdalsrua,bj�rndalsbrua). 
synplace(bj�rndalbru,bj�rndalsbrua).  
synplace(bj�rndalbua,bj�rndalsbrua). 
synplace(bj�rndalen,bj�rndalsbrua). 
synplace(bj�rndalsbroen,bj�rndalsbrua). 
synplace(bj�rndalsbroen,bj�rndalsbrua). 
synplace(bj�rndalsbruen,bj�rndalsbrua). 
synplace(bj�rndalsbua,bj�rndalsbrua). 
synplace(bj�rndalstopnne,bj�rndalstoppen). 
%% synplace(bj�rndas,bj�rndals). %%  (nec?)

synplace(bj�rnebru,bj�rndalsbrua). 
synplace(bj�rnebrua,bj�rndalsbrua). 
synplace(bj�rnsdalsbura,bj�rndalsbrua). 
synplace(bj�rnstadbrua,bj�rndalsbrua). 
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
synplace(borsa,b�rsa). %% Trlag

synplace(bowling,bowling_1). 
synplace(bowlingen,bowling_1). 
% synplace(bran,buran). %% confus? 
synplace(brannstasjon,brannstasjonen). 
synplace(bratbegsvegen,bratsbergveien). 
synplace(bratsbeg,bratsberg).  %% \+brattsveg 
synplace(bratsbergkirke,bratsberg_kirke). 
synplace(brattbergsveien,bratsbergveien). 
synplace(brattoera,bratt�ra). 
synplace(bratt�rtveita,bratt�rveita). %%  SIC bratt�/err in regstr
synplace(brattsbergeveien,brattsbergveien). 
synplace(brattsbergsveien,bratsbergveien). 
synplace(brattsbergvegen,bratsbergveien). 
synplace(brattsperg,bratsberg). 
synplace(bredablikkskole,breidablikk_skole). 
synplace(bredablitt,breidablikk).  %%Dbl
synplace(breidablikk,breidablik).  %%breidablikkveien->breidablikveien
synplace(breidablikkskole,breidablikk_skole). 
synplace(broch,brochs).  %% \+ spc because known
synplace(brochs,prof_brochs_gate).  %%?
synplace(brochsgate,prof_brochs_gate). 
synplace(brochsvei,prof_brochs_gate).
synplace(brogs,brochs). 
synplace(bromsdat,bromstad). 
synplace(bromsetsvingen,bromstadsvingen). 
synplace(brundal,brundalen). 
synplace(brundalenskole,brundalen_skole).   
synplace(brundalensykehjem,brundalen_sykehjem).
synplace(brundarn,brundalen). 
synplace(brygen,bryggen). 
synplace(brygga,pirbadet).  
synplace(br�dsettveien,br�setv).  %%v. ! %%  \tsx br�dsettveien brotsetv
synplace(br�setflatata,br�setflata). %?
synplace(br�seth,br�set). 
synplace(br�sethvegen,br�setv).  %%
synplace(br�sethveien,br�setv).  %% station is preferred %%  Touchy
synplace(br�setvegen168,br�setvegen_168). 
%% synplace(br�setvegen186,br�setvegen_186). 
synplace(br�setvn168,br�setvegen_168). 
%% synplace(br�setvn186,br�setvegen_186). 
synplace(br�sterveien,br�setvegen). 
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
synplace(bura,buran). 
synplace(burn,buran). 
synplace(bur�k,brurok).  %% \+ buran
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

synplace(byen,sentrum).  %% TA-110120 * byen H�nefoss 

synplace(byasveien,by�s_street).  %% problem
synplace(byasvei,by�s_street).    %%  TSX <--- byåsveien //nohelp
synplace(byaysveien,by�s_street). 
synplace(byaysveien,by�s_street).

synplace(byaas,by�s). %% nec for by�s_street (< 5 chars)
synplace(byaasen,by�sen). 
synplace(byaysen,by�sen).  %%byåsen
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
%%  synplace(bysn).  byen | by�sen ?
synplace(byterminalen,hovedterminalen). 
synplace(byterminal,hovedterminalen).  
synplace(byt�rnet,tyholtt�rnet).  
synplace(by�s,by�sen). 
synplace(by�se,by�sen). 
synplace(by�senhallen,by�sen_skole).   
synplace(by�sensenter,by�sen_butikksenter).
synplace(by�senvgs, by�sen_skole). %% migosenteret). %%  by�sen_skole). 
synplace(by�skole,by�sen_skole).        
synplace(by�sskole,by�sen_skole).       %% . . . 
synplace(b�retr�a,v�restr�a). %% off name 
synplace(b�rf�tsvei,berf�ttsvei).  %% Doesn'thelp
synplace(b�rrf�tsvei,berf�ttsvei). 
synplace(b�chmannsvn,b�ckmans_street). 
synplace(b�chmannsvn,b�ckmansveien). 
synplace(b�ckmannsveg,b�ckmans_street). 
synplace(b�ckmannsveg,b�ckmansveien). 
synplace(b�ckmannsvegen,b�ckmans_street). 
synplace(b�ckmannsvegen,b�ckmansveien). 
synplace(b�ckmannsvei,b�ckmans_street).  %% (discr>1). . . 
synplace(b�ckmannsvei,b�ckmansveien).  %% (discr>1). . . 
synplace(b�ckmannsveien,b�ckmans_street). 
synplace(b�ckmannsveien,b�ckmansveien). 
synplace(b�ckmansvei,b�ckmans_street). 
synplace(b�ckmansvei,b�ckmansveien). 
synplace(b�rds�ns,b�rds�ns).  %% actual

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
synplace(cisilienborg,cecilienborg). 
synplace(citi,city).  %% not nec syd (Eng)
%% synplace(cityn,city_syd). %%  confuse
synplace(citilade,city_lade). 
%% synplace(city,hovedterminalen). %% confuse city syd %% TA-110627
synplace(citylade,city_lade). 
synplace(cytisyd,city_syd). 


synplace(d1,dronningens_gate_d1). 
synplace(d2,dronningens_gate_d2).
synplace(d3,dronningens_gate_d3).
synplace(d4,dronningens_gate_d4).


synplace(dagevoll,dragvoll). 
synplace(dalenhage,dalen_hageby). 
synplace(dalgaard,dalg�rd). 
synplace(dalg�rden,dalg�rd). 


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
synplace(dr�ningensgate,dronningens_gate).  
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
synplace(d�densdal,h�gskoleringen).  
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
synplace(engels�sen,engels�s_street). 
synplace(enrumveien,enerom_street). 
synplace(erlingh�viksvei,erling_h�viks_street). 
synplace(esp,esp_meieri). 
synplace(estnestadveien,estenstadveien).  %%NOT synplaceandspellcor
synplace(fagerheimalle,fagerheim_alle).  %%automatic %%
synplace(fagerheimallee,fagerheim_alle). 
synplace(fagerli,fagerliveien).  %%redundant
synplace(fagerlibakken,fagerliveien).  %%?
synplace(falg�rd,dalg�rd). 
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
synplace(fjellseter,fjells�ter). 
synplace(fjordsvingen,fiolsvingen).  %%fjol

synplace(fjosli,fj�slia). 

synplace(flak,flakk). 

synplace(flatssentere,flat�sen_senter). 
synplace(flat�s,flat�sen). 
synplace(flat�sensentrum,flat�sen_senter). 
synplace(flat�senter,flat�sen_senter). 
synplace(flat�sentere,flat�sen_senter). 
synplace(flat�ssenter,flat�sen_senter). 
synplace(flat�ssentre,flat�sen_senter). 
synplace(flat�ssentrum,flat�sen_senter). 
synplace(flybussholdeplass,flybussterminalen). 
synplace(flybussholdeplassen,flybussterminalen). 
synplace(flybussstasjon,flybussterminalen). 
synplace(flybusstasjon,flybussterminalen). 
synplace(flybusstermial,flybussterminalen). 
synplace(flybussterminal,flybussterminalen). 
synplace(flybusstopp,flybussterminalen). 
synplace(fl�tasen,flat�sen). 
synplace(fl�tasveg,�vre_flat�sveg). 
synplace(fl�shaugen,gl�shaugen). 
synplace(folketmuseet,folkemuseum). 
synplace(fossestua,fossestu_street).  %%
synplace(fossestua,fossestuv). 
synplace(fossestuen,fossestuv). 
synplace(fragvoll,dragvoll). 
synplace(fremstad,fjermstads). 
synplace(fremstads,fjermstads). 

synplace(frostadveien,frosta_street). %% \+ ferstadveien

synplace(f�nningsbakken,r�nningsbakken). 
synplace(gadenwist,stj�rdals_street).  %%!stj�rdals_streetNOT station!
synplace(gamlekongevei,gamle_konge_street). 
synplace(gamle�svei,gamle_�s_street). 
synplace(gamle�sveien,gamle_�s_street). 
synplace(gardermoens,gardemoens). 
synplace(gartneriet,gartnerhallen). 

synplace(generalvibesvei,general_wibes_street). 

synplace(gerg,berg). 
synplace(ghaugen,gl�shaugen). 
synplace(gh�s,gl�shaugen).  %%slip
synplace(gildheimen,gildheim). 
synplace(gja�shaugen,gl�shaugen).  
synplace(gjernbanestasjon,jernbanestasjon). 
synplace(gjernbanestasjonen,jernbanestasjonen). 

synplace(gj�dselhaugen,gl�shaugen).  %% :-)
synplace(gj�s,gl�shaugen). 
synplace(gkls,gl�shaugen).  %% dbl neib
synplace(gk�s,gl�shaugen). 
synplace(glas,gl�shaugen).  %% :-) 
synplace(glis,gl�shaugen).  %% :-) 
synplace(gl�a,gl�shaugen). 
synplace('gla|s',gl�shaugen).  %% glæs  %% =<5  
synplace('gla�s',gl�shaugen).  %% 

synplace(glashagen,gl�shaugen). 
synplace(glashogan,gl�shaugen).
synplace(glashogen,gl�shaugen).
synplace(glashogenan,gl�shaugen).
synplace(glashougen,gl�shaugen). 
synplace(glashuagen,gl�shaugen).
synplace(glashuange,gl�shaugen).
synplace(glash�gen,gl�shaugen). 

synplace(glauhogen,gl�shaugen). 
synplace(glauhogene,gl�shaugen). 
synplace(glaushagen,gl�shaugen). 
synplace(glaushaugen,gl�shaugen). 
synplace(glaushogen,gl�shaugen). 
synplace(glaush�gen,gl�shaugen). 
synplace(gla�s,gl�shaugen).       %% gløs  �-tr�bbel
synplace(gla�sgaugen,gl�shaugen).
synplace(gla�shaugne,gl�shaugen). %% gløshaugne 
synplace(glhaugen,gl�shaugen).  
synplace(glodhaugen,gl�shaugen). 
synplace(gloes,gl�shaugen). 
synplace(gloeshaugen,gl�shaugen). 
synplace(glohaugen,gl�shaugen). %% langlohaugen?
synplace(glohogen,gl�shaugen). 
synplace(glos,gl�shaugen). 
synplace(glosaugen,gl�shaugen).  
synplace(glosh,gl�shaugen). 
synplace(gloshagen,gl�shaugen).  
synplace(gloshauegn,gl�shaugen). 
synplace(gloshaug,gl�shaugen). 
synplace(gloshaugen,gl�shaugen). 
synplace(gloshauen,gl�shaugen). 
synplace(gloshogen,gl�shaugen). 
synplace(gloshougen,gl�shaugen). 
synplace(gloshugen,gl�shaugen). 
synplace(gloushagen,gl�shaugen).
%% synplace(gls,gl�shaugen).  %% limit 
synplace(gls�,gl�shaugen). 
synplace(gls�aughne,gl�shaugen).
synplace(gl�s,gl�shaugen). 

synplace(gl�d,gl�shaugen). 
synplace(gl�eshaugen,gl�shaugen). 
synplace(gl�os,gl�shaugen). 
synplace(gl�s,gl�shaugen). % \+ glis/gls/
synplace(gl�sh,gl�shaugen). 
synplace(gl�sha,gl�shaugen).
synplace(gl�shagen,gl�shaugen). 

synplace(gl�shaugane,gl�shaugen). 
synplace(gl�shaugennord,gl�shaugen_nord). 
synplace(gl�shaugensyd,gl�shaugen_syd). 
synplace(gl�shaugens�r,gl�shaugen_syd). 
synplace(gl�shaun,gl�shaugen). 
synplace(gl�shogen,gl�shaugen). 
synplace(gl�shuagne,gl�shaugen). 
synplace(gl�sh�vven,gl�shaugen). 
synplace(gl�shgen,gl�shaugen).
synplace(gl�sh�yen,gl�shaugen). 
synplace(gl�snord,gl�shaugen_nord). 
synplace(gl�ss,gl�shaugen). 
synplace(gl�sshaggen,gl�shaugen). 
synplace(gl�st,gl�shaugen). 
synplace(gl��s,gl�shaugen).  %% Gløs
synplace(gl�s,gl�shaugen).  
    synplace(l�shaugen,gl�shaugen).

synplace(godsnsb,terminalen). 
synplace(graaem�lla,graaem�lna).  
synplace(graakaillbanen,gr�kallbanen). 
synplace(graakalbanen,gr�kallbanen). 
synplace(graakallen,gr�kallen). 
synplace(graakollen,gr�kallen). 
synplace(graem�lne,graaem�lna). 
synplace(gragvoll,dragvoll). 
synplace(granaasen,gran�sen). 
synplace(granasen,gran�sen).  %% doesnt help for partnames 
synplace(gran�senanlegget,gran�sen_vm_anlegget). 
synplace(gran�seng�rd,gran�sen_g�rd). 
synplace(gran�sens,gran�sen). %% granåsens skole?  *sivilforsvarets skole, gran�sen
             
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
synplace(grushaugen,gl�shaugen).  %%  :-)

synplace(gra�nnlnd,gr�nnland). %% avoid gr�nlia %% TA-101118

synplace(gr�nnlien,gr�nnlia). %% \+ granlia %% amble#
synplace(gr�kaillbanen,gr�kallbanen). %% not stat/neib
synplace(gr�kalen,gr�kallen). 
synplace(gr�kall,gr�kallen). 
synplace(gr�kolen,gr�kallen). 
synplace(gr�m�lla,graaem�lna). 
synplace(gr�m�llen,graaem�lna). 
synplace(gr�nem�lna,graaem�lna). 
synplace(guenget,buenget). 
synplace(gulashogan,gl�shaugen). 
synplace(gyda,gina). % krog 
synplace(g�ls,gl�shaugen). 
synplace(g�lshaguen,gl�shaugen). 
synplace(g�s,gl�shaugen). 

synplace(haakon,h�kon).  %%OK,norecursion
synplace(haakon7gt,haakon_vii_gate_25). 
synplace(haakonviigt,haakon_vii_gate_25). 
synplace(haarfagres,h�rfagres). 
synplace(hagnesvingen,haugnessvingen). %% naer miss

synplace(hakobsli,jakobsli). 
synplace(hallfredh�yemsvei,hallfred_h�yems_vei). 
synplace(halseth,halset). 

synplace(hansfinnesgt,hans_finnes_street). 
synplace(hanskebakken,hanskemakerbakken). 
synplace(hanskemakerveien,hanskemakerbakken). 
synplace(hansmakerbakken,hanskemakerbakken). 
synplace(haraldbothnersvei,harald_bothners_veg). 
synplace(haraldh�rfagresgate,harald_h�rfagres_street).  
synplace(haraldh�rfagresgt,harald_h�rfagres_street).  
synplace(haraldh�rfagresvei,harald_h�rfagres_street).  
synplace(hasselvika,hasselbakken). 
synplace(haugnessveien,haugnessvingen). 
synplace(haugnesveien,haugnessvingen). 
synplace(hauk�s,hauk�sen). 
synplace(haulowbakken,thaulowbakken). 
synplace(havnegata,pirbadet).   %%???(case)
synplace(havstads,havstadsenteret).  %%destroyshavstadsenteret?
synplace(havstadsenter,havstadsenteret). 
synplace(havstadtunet,havstadsenteret). 
synplace(havstasenter,havstadsenteret). 
synplace(ha�gskoleparken,h�yskoleparken). %%  høgskoleparken? 

synplace(hofstads,ofstads). %%  ingeborg nohelp
synplace(hogskoleparken,h�yskoleparken). 

synplace(ha�yskoleparken,h�yskoleparken). %%   Nec 

synplace(heimdalsbyen,heimdal_sentrum). 
synplace(heimdalsentralstasjon,heimdal_stasjon). 
synplace(heimdalst,heimdal_stasjon). 
synplace(helhus,melhus). 
synplace(hembres,hambros). %% TA-101111
synplace(hemidla,heimdal). 
synplace(hemnskjell,hemnskjel). 
synplace(henry,henrik). 

synplace(herl�fs,herlofsons) . %% ? 

synplace(herlofsenl�ypa,herlofsonsl�ypa). 
synplace(hestehaven,prof_brochs_gate). 
synplace(hesthaven,prof_brochs_gate). 
%% synplace(himmelen,v�rnes).  %% -> airplane 
synplace(himmelportalen,perleporten). 
synplace(hjelstrupsvei,christian_jelstrups_v).  %%
synplace(hjernbanen,ts). %% AtB. 
synplace(hjernbanestasjon,ts). %% AtB. 
synplace(hj�rtlerveien,gj�rtler_street). 
synplace(hoegga,hoeggen). 
synplace(hoeggenskole,hoeggen_skole). 
synplace(hogskolering,h�gskoleringen). 
synplace(hogsk�leringen,h�yskoleringen). 
synplace(hogsk�lringen,h�yskoleringen). 
synplace(hoholt,moholt). %parasitictypo
synplace(hoieflata,koieflata).  
synplace(holocks,h�rl�cks). 
synplace(holtemansv,holtermanns_street). 
synplace(holtemansveien,holtermansveien). 
synplace(holtermanveg,holtermanns_street).  %%HMV17
synplace(horlocks,h�rl�cks). 
synplace(hornbergvegen,hornebergveien).  %%
synplace(hornbergvegen,hornebergveien).  %%Thestreet
synplace(hornbergveien,hornebergveien).  %%
synplace(hornbergveien,hornebergveien).  %%Thestation
synplace(hornberveien,hornbergveien). 
synplace(hornebergvegen,hornebergveien).  %%
synplace(hornebergveien,hornebergveien).  %%
synplace(hornebyvegen,hornebergveien).  %%
synplace(hornebyveien,hornebergveien).  %% ?
synplace(horn�s,thorn�s). 
synplace(hosp,hospital). 
%% synplace(hospital,regionsykehuset).  %% (anglicism) 
synplace(hospitalskyrkan,hospitalkirka). 
synplace(hospitalsl�kkan,hospitall�kkan). 
synplace(hostipall�kka,hospitall�kkan). 
synplace(hostipalsl�kka,hospitall�kkan). 
synplace(hotrelmannsvei,holtermanns_street). 
synplace(hovebergveien,hornbergveien). 
synplace(hovedbanestasjonen,ts). %% AtB.  
synplace(hovedjernbanestasjon,ts). %% AtB. 
synplace(hovedpostterimalen,postterminalen).  %% ?
synplace(hovedstasjon,ts). %% AtB. 
synplace(hsopitall�kkan,hospitall�kkan). 
synplace(hsopitall�kkan,hospitall�kkan). 
synplace(ht,hovedterminalen).  %%hovedterminalen?
synplace(hurloks,h�rl�cks). 
synplace(humlehaugen,humlehaug_street).  
synplace(hundhamaren,hundhammeren). 
synplace(hunnhammern,hunhammeren). 

synplace(husdaytunet,husebytunet).  %%  dbl sms feil %%?
%% synplace(huseby,husebytunet). 
synplace(husebyhalle,husebyhallen). 
synplace(husebytun,husebytunet). 

synplace(hval�yv,val�yvegen). 
synplace(hval�yveien,val�yvegen). 
synplace(hvilhaugen,kvilhaugen). 
synplace(h�kon,haakon).  %% OK, no recursion
synplace(h�rstadreina,h�rstad). 
synplace(h�gstadmoen,heggstadmoen). 
synplace(h�glieveien,h�ili_street).  
synplace(h�gskolebakken,h�yskoleringen). 
synplace(h�gskolering,h�gskoleringen). 
synplace(h�gskolring,h�yskoleringen). 
synplace(h�gskoleringens,h�yskoleringens). %% allow h�gskoleringens adresse 
                                         
synplace(ha�rlocksvei,h�rl�cks_street). %% TA-101123
synplace(h�ili,h�ili_street).  %%
synplace(h�iskole,h�gskole). 
synplace(h�iskolen,h�gskolen). 
synplace(h�lock,h�rl�cks). 
synplace(h�rlocs,h�rl�cks). 
synplace(h�rl�c,h�rl�cks). 

synplace(h�yskolring,h�yskoleringen). 
synplace(h�ysteh,h�iset). 
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
synplace(idrettsanlegget,idrettsplassen). 
synplace(idrettsbanen,idrettsbygget). 
synplace(idrettsbygg,idrettssenter). 
synplace(idrettsbygningen,idrettsbygget). 
synplace(idrettsenter,idrettssenter). 
synplace(idrettsp,idrettsplassen). 
synplace(idrettspark,idrettplass). 
synplace(idrettspl,idrettsplassen).  %%
synplace(idrettssenter,idrettsbygg). 
synplace(idrettssenter,idrettsbygg). 
synplace(idrettssenteret,idrettsbygget). 
synplace(idrettssentret,idrettsbygget). 
synplace(ihla,ila). 
%% synplace(ika,ikea). 
%% synplace(ike,ikea).    %% ikke
 synplace(ikae,ikea).  %%
synplace(ilakirka,ila). 
synplace(ilakrysset,ila). 
synplace(ilas,ila). 
synplace(ile,ila). 
synplace(ilen,ila). 
synplace(illa,ila). 
synplace(iloa,ila). 
synplace(ils,ila).   
synplace(ils�ra,ila). 
synplace(ilta,ila). 
synplace(indusrvegen,industri_street).  
synplace(ind�retsveien,innherredsveien). 
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
synplace(istg�rds,ystg�rd). 
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
synplace(jakobsliidrettsplassen,idrettsplassen). 

synplace(jakobsliveiennedre,jakobsliveien_nedre). %% vn 

synplace(jakobslivegen,jakobsliveien). %% nec diff names station/street
synplace(jakobsliveien,jakobslivegen).
synplace(jalsteing�rd,halstein_g�rd). 
synplace(jaobsli,jakobsli).  %%
synplace(jarlsveien,jarleveien).  %% Collides H�kon Jarls gate
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
synplace(k_johnssonsveg,karl_jonssons_veg). 
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
synplace(katt�msentret,kattemsenteret). 
synplace(kb,kbs). %% ?
%% synplace(kinoen,kino).  %%subtle, u n d e r specified
%% synplace(kinoene,kino). %% cinema 
synplace(kinos,kinosenter). 
synplace(kjerka,kirken). 
synplace(kj�pesenter,senter). 
synplace(klabu,kl�bu).  %%-kabul
synplace(klaebu,kl�bu). 
synplace(klaeburuta,kl�buruten). 
synplace(klaebuveien,kl�bu_street). 
synplace(klaebuveien,kl�buveien). 
synplace(kleet,klett). 
synplace(klet,klett).  
synplace(klefstadhaug,klefstadhaugen). 
synplace(kleisgate,kleists_street). 
synplace(klestaghaugen,klefstadhaugen). 
synplace(klettkrysset,klett). 
synplace(klivhaugen,kvilhaugen).  %% only neib key swap
synplace(klokkerg�rden,klokkerplassen). 
synplace(klokkerpl,klokkerplassen). 
synplace(klostergt,klostergata). 
synplace(kl�burute,kl�buruten). 
synplace(kl�buruten,kl�buruten). 
synplace(kl�buveien,kl�buvveien).  %%Databaseerror
synplace(kl�fstahaugen,klefstadhaugen). 
synplace(kl�t,klett). 
synplace(kl�tt,klett).
synplace(knudzonsgt,knudss�ns_street). 
synplace(koeflat,koieflata). 
synplace(koieflaten,koieflata). 
synplace(kolstadtoppen,kolstadhaugen). 
synplace(komunesenter,kommunesenter). 
synplace(komunesenteret,kommunesenter). 
synplace(kongevegen,kongsvegen). 
synplace(kongleien,kongleveien).  
synplace(koppan,kroppan). 
synplace(kopparmarka,kroppanmarka). 
synplace(koppermarka,kroppanmarka). 
synplace(korppamarka,kroppanmarka). 
synplace(korppanmrka,kroppanmarka). 
synplace(kps,kbs). 
synplace(kretsfengsel,tunga_kretsfengsel). 
synplace(krigsh�yskolen,luftkrigsskolen). 
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
synplace(kulsaas,kols�s). 
synplace(kulls�s,kols�s). 
synplace(kund�sen,lund�sen_n). 
synplace(kvamshaug,kvamshaugen). 
synplace(kvannhaugen,kvamshaugen). 
synplace(kvannshaugen,kvamshaugen). 
synplace(kvilhagne,kvilhaugen). 
synplace(kvilhaugeng�rd,kvilhaugen). 
synplace(kvilh�gden,kvilhaugen). 
synplace(kysstasjon,skysstasjon). 
synplace(kyststad,kystad). 
synplace(kyvann,kyvatnet). 
synplace(kyvannet,kyvatnet).  %% (No help really,see comment)
synplace(kyvatn,kyvatnet). 
synplace(k�gleveien,kongleveien). 
synplace(k�lsta,kolstad). 
synplace(k�lstad,kolstad). 
synplace(k�bu,kl�bu). 
synplace(k�pmansgata,kj�pmanns_street). 
synplace(lad,lade). 
synplace(lada,lade). 
synplace(ladd,lade).  
synplace(ladealle,lade_alle_80). 
synplace(ladecity,city_lade). 
synplace(ladehalv�ya,lade). 
synplace(ladejarlen,ladejarlen_v_g_s).
synplace(ladejarlenvgs,ladejarlen_v_g_s). 
synplace(ladejarlenvidereg�ende,ladejarlen_v_g_s). 
synplace(ladekirka,lade_kirke). 
synplace(ladekirke,lade_kirke). 
synplace(lademoens,lademoen).  %%kirkealle
synplace(laden,lade).
synplace(ladeomr�det,lade). 
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
synplace(lerchendal,lerchendal_g�rd).  %% NB lerch, ikke same/cmpl
synplace(lerkdal,lerkendal). 
synplace(lerkedalstudentby,presteg�rdsjordet). 
synplace(lerkedel,lerkendal). 
synplace(lerkend,lerkendal). 
synplace(lerkendalomr�det,lerkendal). 
synplace(lerkendalsomr�det,lerkendal). 
synplace(lerkendalst,lerkendal_stadion). 
synplace(lerkendalstadium,lerkendal_stadion). 
synplace(lerkendalstudentby,presteg�rdsjordet). 
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
synplace(lufthavnv�rnes,v�rnes). 
synplace(luftkrigenskole,luftkrigsskolen). 
synplace(lund,lundes). 

synplace(lundaasen,lund�sen_n). 

synplace(lunder�sen,lund�sen_n). % NB ogs� foreign 

synplace(lundemobk,lundemobakken). 
synplace(lund�awn,lund�sen_n).  %%dblneib
synplace(luthenhaven,leuthenhaven). 
synplace(lykkensportal,bybro). 
synplace(lykkesv,ivar_lykkes_street).  %%Lastnameoption
synplace(lysholmsv,j�rgen_b_lysholms_vei). 
synplace(lysholms_vei,j�rgen_b_lysholms_vei). 
synplace(lythenhaven,leuthenhaven). 
synplace(l�rekendal,lerkendal). 
synplace(l�vaasen,l�vaasveien). 
synplace(l�vaasvegen,l�vaasveien). 
synplace(l�vaasveien,l�vaasveien). 
synplace(l�v�sen,l�vaasveien). 
synplace(l�v�svegen,l�vaasveien). 
synplace(l�v�sveien,l�vaasveien).  %% Prefer station
synplace(l�ytenhaven,leuthenhaven). 
synplace(l�ytnanthagen,leuthenhaven). 

synplace(m0,hovedterminalen). 
synplace(m1,munkegata_m1).  %%
synplace(m2,munkegata_m2).  %%
synplace(m3,munkegata_m3).  %%
synplace(m4,munkegata_m4).  %%
synplace(m5,munkegata_m5).  %%

synplace(m0,hovedterminalen). 
synplace(m1,munkegata_m1).  %%
synplace(m2,munkegata_m2).  %%
synplace(m3,munkegata_m3).  %%
synplace(m4,munkegata_m4).  %%
synplace(m5,munkegata_m5).  %%

synplace(magnusblindes,magnusblindes). 
synplace(malhus,melhus). 
synplace(malkvik,malvik). 
synplace(mardo,nardo). 
synplace(mardo,nardo). 
synplace(mardosenter,nardosenteret). 
synplace(mardosenteret,nardosenteret). 
synplace(marienberg,marienborg).  %% ? (\+marienbergveien)
synplace(marienenborg,marienborg). %% amble# doesnt make it 
synplace(marienlyst,marienborg).  %% ?Oslo?
synplace(maries�rdalsv,marie_s�rdals_veg). 
synplace(maries�rdalsvei,marie_s�rdals_veg). 
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
synplace(meraker,mer�ker). 
synplace(mgata,munkegata). 
synplace(mgt,munkegata). 
synplace(michael,michel). 
synplace(midarvoll,nidarvoll). %% ? 
synplace(midtgen,midteggen). 
synplace(midtsandan,midtsanden). 
synplace(migo,migosenteret).   %% TA-100519
synplace(migosenter,migosenteret). 
synplace(migosentre,migosenteret). %% TA-101004
synplace(mikael,michel).  %% grendahlsvei N�ddef
synplace(minkegaten,munkegata). %% nec 
synplace(mins�s,minsaas). 
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
synplace(moltmyra�st,moltmyra_�st). 
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
synplace(munkvollg�rd,munkvoll_g�rd). 
synplace(murens,ourens). 
synplace(murevik,muruvik). 
synplace(museet,museum). 
synplace(musikmuseum,museum). 
synplace(myen,byen). 
synplace(m�lleballen,m�llebakken). 
synplace(m�llergate,m�llebakken).  %% (?)
synplace(nado,nardo). 
synplace(nadrocentere,nardosenteret). 
synplace(nadrocentret,nardosenteret). 
synplace(nard,nardo). 
synplace(nardobrua,nardokrysset). 
synplace(nardokr,nardokrysset). 
synplace(nardoomr�det,nardo). 
synplace(nardos,nardosenteret). 
synplace(nardosent,nardosenteret). 
synplace(nardosentereret,nardosenteret). 
synplace(nard�hallen,trondheim_spektrum). 
synplace(naro,nardo).  %%own
synplace(naskinagentur,maskinagentur). 
synplace(nedrebakklandet,bakkegata). 
synplace(nedreelvehanv,nedre_elvehavn). 
synplace(nedreflat�sen,s�ndre_flat�sen). 
synplace(nedrejakobsliveg,jakobsliveien_nedre). 
synplace(nedrejakobslivei,jakobsliveien_nedre). 
synplace(nedreleirfoss,nedre_leirfoss).  %% (automatic*)
synplace(nerg�rdsvei,nordgaardsvei). 
synplace(ngu,n_g_u). 
synplace(niar�hallen,trondheim_spektrum). 
synplace(nidarhalen,trondheim_spektrum). 
synplace(nidarhallen,trondheim_spektrum). 
synplace(nidrehallen,trondheim_spektrum). 
synplace(nilsens,nielsens).  %% Otto nilsens vei/Aksel nilsens vei
synplace(nnherredsveien,innherredsveien). 
synplace(noa,nova). 
synplace(noholdttun,moholttun). 
synplace(noholt,moholt). synplace(omholt,moholt). 
synplace(noll,voll). 
synplace(nordg�rds,nordgaards). 
synplace(nordo,nardo). 
synplace(nordg�rdsvei,nordgaardsvei). 
synplace(nordrehallset,nordre_halset). %% migosenteret). 
synplace(nordrehalset,nordre_halset). %% migosenteret). 



synplace(noreg,norge). 
synplace(norg�rds,nordgaards). 
synplace(novakinosenter,nova_kinosenter). 
synplace(nove,nova_kinosenter). 
synplace(npva,nova_kinosenter). 
synplace(nrdo,nardo). 
synplace(nsb,ts). %% AtB.  %%(=tog?)
synplace(ntnt,ntnu). %%  sperr
synplace(ntnudragvoll,ntnu_dragvoll). 
synplace(nunkegata,munkegata). 
synplace(nunkvoll,munkvoll).  %% <
synplace(nuseum,museum).  %%OWNsp
synplace(nybakkeveien,nybakkveien). 
synplace(nybakkveien,nyveibakken). 
synplace(nyb�rdsveien,nyg�rd_street). 
synplace(nydal,nydalen). 
synplace(nyenget,buenget).  %%Neib?
synplace(nygaardsvei,nyg�rds_vei). 
synplace(nygaardsvei,olav_nyg�rds_vei). 
synplace(nyg�rden,nyg�rd). 

%%%%%%%%%%%%%%%%  different names in/out synplace(nyg�rds,nygards).  %%street/station/misspellconfusion
%% TA-110803

synplace(nyg�rdsvei,nyg�rds_vei).  %%nec,alas
synplace(nyg�rdsvei,olav_nyg�rds_vei). 
synplace(nyg�rdsvolds,nygaardsvolds). 
synplace(nyg�rdsvoll,nygaardsvolds). 
synplace(nynu,ntnu).  
synplace(nyorg,nyborg). 
synplace(nyveibk,nyveibakken). 
synplace(ny�sen,by�sen). 
synplace(n�va,nova_kinosenter). 
synplace(oeveraas,�ver�s). 
synplace(ofstisv,�fstis_vei).  %%einarofstisv. 
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
synplace(olavnigardsvei,olav_nyg�rds_vei).   
synplace(olavnygaardsvei,olav_nyg�rds_vei). 
synplace(olavnyg�rdsvei,olav_nyg�rds_vei). 
synplace(olavnyg�rdsvei,olav_nyg�rds_vei). 
synplace(olavnygrdsvei,olav_nyg�rds_vei).  

synplace(olavs,olav). 
synplace(olavtryggvasonsgt,olav_tryggvasons_gate). %% CORREC %% TA-101203 %% AtB
synplace(olavtrygvasonsgate,olav_tryggvasons_gate). %% CORREC %% TA-101203 %% AtB
synplace(olderdal,olderdalen). 
synplace(oldredal,olderdalen). 
synplace(ole,ola). 
synplace(ole,olaf). 
synplace(ole,olav). 
synplace(olovhospital,st_olavs_hospital). 
synplace(omholt,moholt). 
synplace(omkj�ringsv,omkj�ringsveien). 
synplace(omkj�ringsveg,omkj�ringsveien). %% generic TSX 
synplace(omkj�ringsvei,omkj�ringsveien). 
synplace(omkja�ringsvegen,omkj�ringsveien). %% �-tr�bbel


synplace(oops,city_lade). 
synplace(opland,oppland).  %%bus 10 skistua down
synplace(oppland,opland).  %%bus1 0 up skistua
synplace(ops,city_lade). 
synplace(orkander,orkanger). 
synplace(orkangar,orkanger). 
synplace(osb,city_lade).  %% (not spell # < 4)
synplace(ostersund,�stersund). 
synplace(ostmarkveien,�stmark_street). %% no spell 1. letter 
synplace(ostre,�stre). 
synplace(otb,othilienborg). 
synplace(otelieborg,othilienborg). 
synplace(otelienborg,othilienborg). 
synplace(othb,othilienborg). 
synplace(othborg,othilienborg). 
synplace(othelieborg,othilienborg). 
synplace(othilb,othilienborg). 
synplace(othilienlenborg,othilienborg). 
synplace(othilielinborg,othilienborg).
synplace(otelieborg,othilienborg). 
synplace(othelieborg,othilienborg). 
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
synplace(oya,�ya). 
synplace(owesensgate,thonning_owesens_street).  %% $Generic
synplace(pedermorsetsv,peder_morsets_vei). 
synplace(pedermorsetsvei,peder_morsets_vei).
synplace(peppe,reppe). 
synplace(peraunetveien,persaun_street).  %%aun(Help?)
synplace(peraunetveien,persauneveien). %% TA-110415 
synplace(peribadet,pirbadet). 

synplace(persaun,persaune). 
synplace(persaun,persaunet). %% Persaun leir %% TA-110519
synplace(persaunetleir,persaunet_leir). 
synplace(persaunetlier,persaunet_leir). 
synplace(persaunetv,persaun_street). 

synplace(persaunetvegen,persauneveien). %% TA-110415
synplace(persaunetveien,persauneveien). %% TA-110415
synplace(persaunevegen,persauneveien).  %% TA-110415  
synplace(persauneveien,persauneveien).  %% TA-110415

synplace(persautunet,persaunet). 
synplace(persetunet,persaunet). 
synplace(persuanevegen,persaun_street). 
synplace(persunet,persaunet). 
synplace(pier,pirbadet).  
synplace(pierbadet,pirbadet). 
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
synplace(presteg�rdsbakken,presteg�rdsjordet).  %%  ?
synplace(presteg�rdsgjerdet,presteg�rdsjordet). %%  ?
synplace(presteg�rdsj,presteg�rdsjordet). 
synplace(prestejordjordet,presteg�rdsjordet). %% \+ dsj
synplace(presthuset,presthus_street). 
synplace(presthushagen,presthus_street).  
synplace(pribadet,pirbadet). 
synplace(prinsegate,prinsens_gate). 
synplace(prinsengata,prinsens_gate).  %% (actual)
synplace(prinsengate,prinsens_gate). 
synplace(prinsenkryss,prinsenkrysset). 
synplace(prinsgade,prinsens_gate).  %% (actual)
synplace(prisentret,pirsenteret).  
%% synplace(prisenteret,pirsenteret).  %% unnec
synplace(prochs,brochs). 
synplace(profbroch,prof_brochs_gate). 

synplace(profbrochsgt,prof_brochs_gate). 
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
synplace(ranheimskole,ranheim_skole). %% Hastus
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
synplace(reppevik�sen,reppevegen). 
synplace(ridevoldsgate,riddervolds_street). 
synplace(ringe,ringve). 
synplace(ringsaker,singsaker). 
synplace(ringv,ringve).  %%?
synplace(ringvaal,ringv�l). 
synplace(ringvedskole,ringved_skole). 
synplace(ringvemuseet,ringve_museum). 

synplace(ringveskole,ringve_skole). 
synplace(ringveskolen,ringve_skole). 
synplace(ringvevidreg�endeskole,ringve_skole). 
synplace(ringvold,ringv�l). 
synplace(ringvoll,ringv�l). 
synplace(ringvollgrind,ringv�l_grind). 
synplace(ringv�lgrind,ringv�l_grind). 
synplace(rinveskole,ringve_skole). 
synplace(rinvoll,ringv�l). 
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
synplace(risv�lan,risvollan). 
synplace(risv�llan,risvollan). 
synplace(rlgeseter,elgeseter). 
synplace(robuslia,romolslia). 
synplace(roenningsbakken,r�nningsbakken). 
synplace(roeros,r�ros). 
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
synplace(rom�slia,romolslia). 
synplace(roros,r�ros). 
synplace(rosedal,rosendal).  %%IKKE Romsdal (wrong preference)
synplace(rosenborgpark,rosenborg_skole).  
synplace(rosenborgparken,rosenborg_skole).   
synplace(rosenborgs,rosenborg). 
synplace(rosenborgskolen,rosenborg_skole).   
synplace(rosenb�rr,rosenborg). 
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
synplace(r�m�lla,graaem�lna). 

synplace(r�nnebakken,r�nningsbakken).

%% synplace(r�nningensbakke,r�nningsbakken). %% sameplace 
%% synplace(r�nningensbakken,r�nningsbakken).%% 

synplace(r�nningsbakk,r�nningsbakken). 
synplace(r�nningsbakkenst,r�nningsbakken). 
synplace(r�nningsgabkken,r�nningsbakken). 

synplace(r�r�s,r�ros). 
synplace(r�vik,r�rvik). 
synplace(sakseborgveien,saxenborg_alle). 
synplace(sakseborgvn,saxenborg_alle). 
synplace(saksenborg,saxenborg). 
synplace(saksevigs,saksviks). 
synplace(saksvig,saksviks). 
synplace(saksvigs,saksviks). 

synplace(saksevik,saksvik). %% foreign

synplace(saland,s�lands). 
synplace(salgskontore,servicekontoret). 
synplace(salgskontorene,servicekontoret). 
synplace(salgskontoret,servicekontoret). 
synplace(samf1,studentersamfundet_1). 
synplace(samf2,studentersamfundet_2). 
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
synplace(saupstakrysset,saupstadsenteret). 
synplace(saupstasenteret,saupstadsentret). 
synplace(saupstasentre,saupstadsenteret). 
synplace(saupstasentret,saupstadsenteret). 
synplace(saupstseneret,saupstadsenteret). 
synplace(saustadsentret,saupstadsentret). 
synplace(saustaringen,saupstadringen_109). 
synplace(saxeborgveien,saxenborg_alle). 
synplace(saxeborgvn,saxenborg_alle). 
synplace(saxenborgale,saxenborg_alle). 
synplace(saxenborgen,saxenborg). 
synplace(sa�ndre,s�ndre). %% søndre halset? %% //u n d e r s p_place
synplace(sa�rborgen,s�rborgen). %% NB \+ s�rberg %% TA-101108
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

synplace(sciotz,schi�tz).  %% TA-101214
synplace(schiots,schi�tz). 
synplace(sc�yts,schi�tz).  
synplace(sh�ts,schi�tz). 
synplace(schi�tsvwj,schi�tz_vei). 

synplace(schjethmans,schjetnans).  
synplace(schjetnemarka,sjetnmarka). 
synplace(schjetnes,schjetnans). 
synplace(sch�tsvei,schi�tz_vei). 
synplace(sdressavisa,adresseavisa). 
synplace(sdresseavisa,adresseavisa). 
synplace(seland,s�lands).  
synplace(selands,s�lands). 
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
synplace(sentrumsomr�det,sentrum). 
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
synplace(sh�itzsvei,schi�tz_vei). 
synplace(sigurdbergsalle,sig_berg_alle). 
synplace(silddr�vegen,silddr�vegen). 
%% synplace(simen,siemens).  
synplace(singsakerkrysset,jonsvannsveien). 
synplace(singsakerstudentby,singsaker_studenthjem). 
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
synplace(sj�dalen,stj�rdal). 
synplace(skandik,scandic). 
synplace(skippersenteret,fossegrenda). 
synplace(skiskistua,skistua). 
synplace(skistadion,gran�sen_vm_anlegget).  
synplace(skistova,skistua). 
synplace(skiststua,skistua). 
synplace(skistuen,skistua). 
synplace(skjetemarka,sjetnmarka). 
synplace(skjetlien,sjetlein). 
synplace(skjetnan,schjetnans). 
synplace(skjetne,sjetnmarka). 
synplace(skjetnemarka,sjetnmarka). 
synplace(skjettnemarka,sjetnmarka). 
synplace(skoleringen,h�yskoleringen).  %% ?
synplace(skovgaard,skovg�rd). 
synplace(skovgors,skovg�rd). 
synplace(skovg�rde,skovg�rd). 
synplace(skule,skole). 

synplace(skyssstasjon,kl�bu_skysstasjon).  
synplace(skysstasjonen,kl�bu_skysstasjon). 

synplace(skysta,kystad). 
synplace(skystad,kystad). 
synplace(skyttrerveien,skytterveien). 
synplace(sk�g�rd,skovg�rd). 
synplace(sk�rvolds,skaarvolds). 
synplace(sk�rvoldsvei,skaarvolds_street). 
synplace(sk�vg�r,skovg�rd). 
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
synplace(stadingeni�r,stadsing).  %%(forstreet)
synplace(stadingeni�r,stadsingeni�r).  %%(forstreet)
synplace(stadionen,stadion). 
synplace(stadsing,stadsingeni�r). 
synplace(stadsingeni�r,stadsing). 
synplace(stasion,stasjon). 
synplace(stasion,station). 
synplace(stasjon,ts). %% AtB. 
 
synplace(staten,stadsing_dahls_street). %% AH-080401

synplace(station,stasjon). %% ang sel ?

synplace(statoilhydro,statoil_rotvoll). %% Obs. %% TA-110624

synplace(stationen,ts). %% AtB. 
synplace(statsing,stadsing). 
synplace(statsingeni�r,stadsingeni�r). 
synplace(statsingeni�rs,stadsingeni�r). 
synplace(stavet,stavset).  %%-stavne
synplace(stavneg�rd,stavnebrua). 
synplace(stavnrbroa,stavnebrua). 
synplace(std,student). 
synplace(steinen,steinan).  
synplace(steinaasen,stein�sen). 
synplace(steinanhaugen,steinhaugen). 
synplace(steinan�sen,stein�sen). 
synplace(steinberg,steinberget). 
synplace(steinsbakken,ny_steinsbakken). 
synplace(steintr�a,steintr�veien). 
synplace(stensbakken,ny_steinsbakken). 
synplace(stiftsg�rn,stiftsg�rden). 
synplace(stikkelstad,stiklestad).  %%
synplace(stikkelstadveien,stiklestadveien). 
synplace(stikklestadvegen,stiklestadveien). 
synplace(stj�rdaln,stj�rdalen). 
synplace(stj�rdarn,stj�rdalen). 
synplace(stmarka,�stmarka). %% � tr�bbel 
synplace(stokkes,stokkens).  %% Martin
synplace(stolav,st_olavs_hospital). 
synplace(stolavs,st_olavs_hospital). 
synplace(stolavsgata,st_olavs_gate). 
synplace(stolavsgate,st_olavs_gate). 
synplace(stolavsgaten,st_olavs_gate). 
synplace(stolavsgt,st_olavs_gate). 
synplace(stolavssykehus,st_olavs_hospital). 
synplace(storlin,storlien). 
synplace(storen,st�ren). 
synplace(storsenter,senter). 
synplace(stortorget,torget). 
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
synplace(strjoerdal,stj�rdalen). 
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
synplace(sverige,sweden). %nec?
synplace(sverresg�rd,sverresborg). 
synplace(sykeheim,sykehjem). 
synplace(sykehj,sykehjem). 
synplace(sykehjem,sykeheim). 
%% synplace(sykehuset,st_olavs_hospital).  %% sykehuset Br�set
synplace(s�beg,s�berg). 
synplace(s�bstadringen,saupstadringen_109). 
synplace(s�bstadsenteret,saupstadsenteret). 
synplace(s�ndemoen,sandmoen).  %%contag


synplace(s�ndregate,s�ndre_street). %% Nec %% TA-110526
synplace(s�ndregate_22,s�ndre_gate_22). 
synplace(s�ndregate_23,s�ndre_gate_23). 
synplace(s�ndregt,s�ndregate).  %%NBsynSyndrome



synplace(s�ndrehoem,s�ndre_hoem). %% ? Tram st
synplace(s�nningsbakken,r�nningsbakken).  %% ? sms
synplace(s�pstadsenteret,saupstadsenteret). 
synplace(s�tmarka,�stmarka). 
synplace(s�upstamyra,saupstadmyra). 
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

synplace(ta�h,t�h). %% TA-110411   %% tøh 

synplace(tanemskrysset,tanemskrysset_1). 
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
synplace(tegleg�rden,teglg�rden). 
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
%%  Tempeveien 11 street -> val�yvegen

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
synplace(thorsplassen,torplassen).  %%
synplace(thouwlowbakken,thauwlowbakken). 
synplace(thrheim,trondheim). 
synplace(thonheim,trondheim). 
synplace(tikker,tiller). 
synplace(tillerbruen,tiller_bru). 
synplace(tilleringen,tiller_ringen). 
synplace(tillerkirka,'Tiller kirke'). 
synplace(tillerkirke,'Tiller kirke').
synplace(tilleromr�det,tiller). 
synplace(tillerringen,tiller_ringen).  %% street
synplace(tisvollan,risvollan). 
synplace(tjyvatnet,kyvatnet). 
synplace(tlh,l�rerh�gskolen). 
synplace(tnga,tunga). 
synplace(togbanestasjon,ts). %% AtB.
% synplace(toget,ts). %% AtB // no torget ? %% 
synplace(togsentral,ts). %% AtB. 
synplace(togsentralen,ts). %% AtB. 
synplace(toholdtt�rnet,tyholtt�rnet). 
synplace(tonstad,thonstad). 
synplace(tonstad,thonstad).  %%Nec???
synplace(tonstadbrinken,tonstad). 

synplace(tonstads,thonstads). 
synplace(tonstadsvei,thonstadsvei). 
synplace(tonstagrena,tonstadgrenda). 
synplace(tonstagrenna,tonstadgrenda). 
synplace(toorvplassen,torget). 
synplace(tordenskjol,tordenskiolds). 
synplace(tordenskjoldsgate,tordenskiolds_gate).  %%Problems
synplace(tordenskjoldsgt,tordenskiolds_gate). %inregtrikketc. 
synplace(tordenskjols,tordenskiolds).  %%NBio
synplace(torg,torget). 
synplace(torge,torget).  %%nospellbecausetorg|torget
synplace(torndheimtorg,torget). 
synplace(torne,thorn�s). 
synplace(tornesvei,k_o_thorn�s_vei). 
synplace(torsplass,torplassen).  %%
synplace(torsvei,tors_veg). 
synplace(torsvn,tors_veg). 
synplace(torv,torg). 
synplace(torvet,torget). 
synplace(torvet,torget). 
synplace(torvoll,rotvoll). 
synplace(torvtakeket,torvtaket). 
synplace(tovet,torget). 
synplace(tprvet,torget). 
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
%% synplace(trikk1,1).  %%? 
synplace(troendelag,tr�ndelag). 
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
synplace(trondheitorg,torget). 
synplace(trondhjemsdistriktet,trondheim). 
synplace(trondsentrum,hovedterminalen). 
synplace(tronheim,trondheim). 
synplace(tronhem,trondheim). 
synplace(tronheom,trondheim). 
synplace(tronj�m,trondheim). 
synplace(trovet,torget).  %% trofet-vegen ?
synplace(trtorg,torget). 
synplace(trudvengveien,trudevang_street).  %% dev. . 
synplace(tryggvassons,trygvassons).  %% local misspell
synplace(trygvason,tryggvason). 
synplace(trygvason,tryggvasons). 
synplace(trygvasonsgt,olav_tryggvasons_gate). %% CORREC %% TA-101203 %% AtB
synplace(tr�j�m,trondheim). 
synplace(tr�dheim,trondheim). 
synplace(tsrindheim,strindheim). 
synplace(tuga,tunga).  
synplace(tungafengsel,tunga_kretsfengsel). 
synplace(tungafengslet,tunga_kretsfengsel). 
synplace(tungafengselet,tunga_kretsfengsel). 
synplace(tungakretsfengsel,tunga_kretsfengsel). 
synplace(tungakrysset,iskremfabrikken).  %% (?)
synplace(tunge,tunga). 
synplace(turge,torget). 
synplace(tvestien,tvetestien). %% TA100107
synplace(tvedesiten,tvetestien). 
synplace(tveitanstien,tvetestien). 
synplace(tydalen,tydal).  %% (ikke Nydalen)
synplace(tyhikt,tyholt).  %% dbl neib
synplace(tyholttaarnet,tyholtt�rnet). 
synplace(tyholtt�rn,tyholtt�rnet). 
synplace(tyholt�rndt,tyholtt�rnet). 
synplace(t�rnet,tyholtt�rnet). %% <- 
synplace(t�gleg�rden,teglg�rden). 
synplace(t�retr�a,v�restr�a). %% off name  %% ?
synplace(uantinlyst,valentinlyst).  %% ?
synplace(udbergs,udbyes). %% gt
synplace(uglaholdplass,ugla).  %% ?
synplace(uglastasjon,ugla). 
synplace(uglastien,uglahaugstien). 
synplace(ugle,ugla).  %%nospellif=<4ch
synplace(ugls,ugla). 
synplace(uik�sen,vik�sen). 
synplace(uka,studentersamfundet). 
synplace(ulga,ugla).
synplace(ullstadl�kka,ulstadl�kkveien). % sameplace doesn'twork
synplace(ullumsg�rden,by�sen_butikksenter).   %% ? 
synplace(ulstadl�kka,ulstadl�kkveien).  %%(?)Road
synplace(ungdomsskole,skole). 
synplace(unherredsvei,inherredsveien). 
synplace(unit,ntnu). 
synplace(universitetssenter,universitet). 
synplace(unkegata,munkegata). 
synplace(urtigruta,hurtigruta). % ?
synplace(utla,ugla). 
synplace(utleiramarka,utleirmark). 
synplace(utsikt,utsikten_alle). 
synplace(u�retr�a,v�restr�a). %% off name %%  ? (sms)
synplace(vaadan,v�danv_5).    % ?
synplace(vaerestroa,v�restr�a). %% TA100110
synplace(vaeretroa,v�restr�a). %% off name 
synplace(vaeretroea,v�restr�a). %% off name
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
synplace(valervegen,val�yvegen). 
synplace(valerveien,val�yvegen). %% ?
synplace(valer�yveien,val�yvegen). 
synplace(valetinenlyst,valentinlyst). 
synplace(valetinerlyst,valentinlyst). 
synplace(valin,valentinlyst). 
synplace(valinlyst,valentinlyst). 
synplace(valkbergets,falkbergets). 
synplace(vallentin,valentinlyst). 
synplace(valtenlyst,valentinlyst). 
synplace(valtinlyst,valentinlyst). 
synplace(valtninlyst,valentinlyst). 
synplace(val�iveien,val�yvegen). 
synplace(val�yvegen,val�y_street). 
synplace(vaneltynlyst,valentinlyst). 
synplace(vanetelyst,valentinlyst). 
synplace(vanetinlyst,valentinlyst). 
synplace(vanlentynlyst,valentinlyst). 
synplace(vantelyst,valentinlyst). 
synplace(vantinlyst,valentinlyst). 
synplace(varetroa,v�restr�a). %% off name
synplace(varetroea,v�restr�a). %% off name 
synplace(vassfjell,vassfjellet). 
synplace(vassfjelt,vassfjellet).

synplace(vblakli,blakli). 
synplace(vearnas,v�rnes). 
synplace(velntinlyst,valentinlyst).
synplace(veratr�a,v�restr�a). %% off name 
synplace(verdaln,verdalen). 
synplace(vertr�a,v�restr�a). %% off name 
synplace(vesterlia,vestlia). 
synplace(vestli,vestlia). 
synplace(vestliaendeholdeplass,vestlia_endeholdeplass). 
synplace(vestlias,vestlia). 
synplace(vestlien,vestlia). 
synplace(vey,veg). 
synplace(vey,vei). 
synplace(vg,skole).  %% collides with veg???
%% synplace(vgs,skole). %% no jfr by�sen skole \= by�sen vgs 
synplace(vharlottenlund,charlottenlund).  %%
synplace(videreg�ende,skole). 
synplace(videreg�endeskole,skole).  %%etc
synplace(viderg�ende,videreg�ende). 
synplace(viderg�endeskole,skole). 
synplace(vidreg,videreg�ende). 
synplace(vidreg�ende,skole). 
synplace(vidreg�ende,videreg�ende). 
synplace(vikaasen,vik�sen). 
synplace(vikahammer,vikhammer). 
synplace(vikahmmer,vikhammer). 
synplace(vikamer,vikhammer). 
synplace(vikelv,vikelvveien).  %%Complicated
synplace(vikhamar�sen,vikhammer�sen).
synplace(vikhamer�sen,vikhammer�sen). 
synplace(vikhmmer,vikhammer). 
synplace(vik�s,vik�sen). 
synplace(vik�shallen,vik�senhallen). 

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
synplace(vollumsg�rden,by�sen_butikksenter). 
synplace(vstla,vestlia). 
synplace(vull,voll). 
synplace(vullumsg�rden,by�sen_butikksenter). 
synplace(v�dan,v�danv_5).  %%?
synplace(v�ll,voll). 
synplace(v�restr�ya,v�restr�a).
synplace(v�retr�en,v�restr�a). 
synplace(v�retr�ene,v�restr�a).
synplace(v�rnesflyplass,v�rnes). 
synplace(v�r�tra,v�restr�a). 
synplace(v�tertr�a,v�restr�a). 
synplace(wist,stj�rdals_street).  %% \+ placestat
synplace(woll,voll). 
synplace(ygla,ugla). 
synplace(yiller,tiller). %?
synplace(ystergaardsvei,ystgaardsvei). 
synplace(ysterg�rdsvei,ystgaardsvei). 
synplace(ystgaardsvei,ingvald_ystgaards_street).  %% //Confus? Notanymore 
synplace(ystg�rds,ystgaards). 
synplace(ystg�rdsvei,ystgaardsvei). 
synplace(y�sen,by�sen). 
synplace(zentral,sentral). 
synplace(�lges�tergt,elgeseter). 
synplace(�sheim,�sheim). 
synplace(�svang,�svang). 
synplace(�sveien,�sveien). 

synplace(�eangen,leangen).  %%1. 
synplace(�erkendal,lerkendal).
synplace(�st,�stre). 
synplace(�sterberg,�stre_berg). 
synplace(�stg�rds,ystgaards). 


synplace(�strerosten,�stre_rosten). 
synplace(�ver,�vre). 
synplace(�veraas,�ver�s). 
synplace(�vreflat�svegen,�vre_flat�s_street).  %% problem
synplace(�vreflat�svegen,�vre_flat�sveg).  
synplace(�vrejakobsli,jakobslivegen_�vre).  
synplace(�vreromulslia,romolslia_�vre).  %% (SICromol)//redundant eventually
synplace(�vretvereggen,�vre_tvereggen).  %% street?
synplace(�aveienskole,�sveien_skole). 
synplace(�irbadet,pirbadet). 
synplace(�iren,pirbadet).   %%?
synplace(�irterminalen,pirbadet).  
synplace(�lderdalen,olderdalen). 
synplace(�pirterminalen,pirbadet).   %%1. letter
synplace(�rinsen,prinsen). 
synplace(�sns,aaes).  %%strangename
synplace(�svangskole,�svang_skole). 
synplace(�svei,�sveien). 
synplace(�sveienskolen,�sveien_skole). 
synplace(�sveiskolen,�sveien_skole). 
synplace(�veienskole,�sveien_skole). 
synplace(��stmarka,�stmarka). 

%%% synplace(atb,kongens_street-34). %%  %% <----- AtB Funk // hva er atb
synplace(ts,ts).   %% <----- AtB
synplace(ts10,ts). %% 
synplace(ts11,ts). %%

underspecified_place(adolf_�ien).  %%
underspecified_place(alpinanlegget). 
underspecified_place(alpinbakken). 
underspecified_place(badestranda). 
underspecified_place(bakke). 
%% underspecified_place(bakli). 
%% underspecified_place(barnehage). %% --> noinfo
%% underspecified_place(barnehave).
underspecified_place(berg). 
%% underspecified_place(bibliotek). %% TA-101116 generic
%% underspecified_place(biblioteket).  Biblioteket p� Moholt
underspecified_place(blussuvold). 
underspecified_place(bomringen). 
%% underspecified_place(bratsberg). %% TA-110325
%    hpl(16010046,bratsberg_�stre,bratsberg_�stre,'Bratsberg �stre').
%    hpl(16010609,bratsbergflata,bratsbergflata,'Bratsbergflata').
%    hpl(16010763,bratsberg_kirke,bratsberg_kirke,'Bratsberg kirke

underspecified_place(brygge).  
underspecified_place(butikken).
underspecified_place(butikksenteret).  
underspecified_place(bygda). 
underspecified_place(bygden).  

underspecified_place(by�sen). 

underspecified_place(b�thavna). 
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

%%   underspecified_place(g�rd). %% Stavne g�rd is not U

underspecified_place(g�rden). 
underspecified_place(haakon_vii_gate).  %% Despair 
underspecified_place(hageby). 
underspecified_place(hageby). 
underspecified_place(hist). 
underspecified_place(hotell). 
underspecified_place(hotellet).  %%
underspecified_place(hovedinngangen). %% ( slightly odd) hovedinngangen til st.olavshospital?
underspecified_place(hovedstasjonen).  %% TS|ST ?
underspecified_place(huseby).     %% Husebyst//Husebysentret 
underspecified_place(h�gskolen).  %% HIST or NTH?
underspecified_place(h�yskolesenteret). 
%% underspecified_place(idrettsbygg).  -> generic_place 
underspecified_place(idrettsparken). 
%% underspecified_place(idrettsplassen).  %% TA-100828  ipl jakobsli
underspecified_place(ingeni�rh�gskolen). 
underspecified_place(innlandet). 
underspecified_place(jakobslivegen).  %% nedre/�vre vegen official road name
underspecified_place(jordet). 
%% underspecified_place(kafe).  %% generic
underspecified_place(kafeen). 
underspecified_place(kino). 
underspecified_place(kirka). 
%% underspecified_place(kirke). %% "nardo kirke" 
underspecified_place(kirken). 
underspecified_place(kirkeg�rden).
%% underspecified_place(kj�pesenter). %% unk
underspecified_place(kj�pesenteret). 
underspecified_place(kj�pesentra). 
underspecified_place(kj�pesentret). 
%% underspecified_place(klinikk).  
%% underspecified_place(klinikken). %% noinfoaboutnoun
underspecified_place(kommunehuset). 
underspecified_place(kommunesenteret). 
underspecified_place(kroghsvei).  %%peder/gina
underspecified_place(lilleby).  %% (? whereisit)
underspecified_place(l�rerskolen). 
underspecified_place(malvikmarka). 
underspecified_place(mellomveien).  %% Mellomveien 5 st. ,nearestBuran
underspecified_place(markedet). %% torget ? 
underspecified_place(mo).  %% Mo i Rana?
underspecified_place(motorveien). 
underspecified_place(museum). 
underspecified_place(myra).  
underspecified_place(m�llenbergveien).  %% �vre/Nedre M. gt
underspecified_place(nidaros). %% Th, sjokol domen, 
underspecified_place(nidelva). 
underspecified_place(nidelven). 
underspecified_place(nordre). %% TA-110418
underspecified_place(ntnu).   %%
underspecified_place(oasen).  %% \+ Osen 
underspecified_place(obs).    %% Obs Lade,Heimdal,City Syd
underspecified_place(omkj�ringsveg).  %% something missing
underspecified_place(omkj�ringsvei).  
underspecified_place(omkj�ringsveien). 
%% underspecified_place(omkj�ringsvegen).  %% something missing
%% underspecified_place(omkj�ringsveien). 
underspecified_place(parken). 
underspecified_place(presteg�rden). 
underspecified_place(rutebilstasjonen).  %% Sentralstasjonen,
underspecified_place(samfunnshuset).  %% %% slightly misplaced error message
underspecified_place(sanatoriet).  
underspecified_place(scandic_hotel).
%%  underspecified_place(senter). %% Try without %% TA-101228
underspecified_place(sintef). 
underspecified_place(sj�en). 
underspecified_place(skauen).  
underspecified_place(skibakken). 
underspecified_place(skogen). 
%% underspecified_place(skole).  %% ? destroys by�sen videreg�ende
underspecified_place(skolen). %% nidarvoll skolen \+ flertydig %% TA-100903
underspecified_place(skytebanen). 
underspecified_place(solbakken). 
underspecified_place(sorgendal). 
underspecified_place(storsenteret). %% TA-110125
underspecified_place(stranden).  %% TA-101108
underspecified_place(strinda). 
underspecified_place(strindamarka). 
underspecified_place(studentby). 
underspecified_place(studentbyen). 
underspecified_place(sykehuset). 
underspecified_place(svingen).  
underspecified_place(sv�mmehallen). 
underspecified_place(sv�mmehaller). 
%% underspecified_place(sykehus). %% -> noinfoabout %%  Br�set sykehus= more precise *
underspecified_place(s�ndre).  %% confusing
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

underspecified_place(tr�ndelag).       %% // not foreign (spchk)
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
underspecified_place(voldsminde).  %% mellomv_5|�vreM�llenberggt 40->Bakkegate
underspecified_place(vollan). 

underspecified_place(�demarka). 
underspecified_place(�demarken).  %%
underspecified_place(�ra). 
underspecified_place(�stbyen). 
underspecified_place(�stkanten). 
underspecified_place(�ya).  %% or nobuses ?
underspecified_place(�sen). 


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
unwanted_place(bj�rn).  %% \+  Bj�ra
unwanted_place(bja�rn).  %% \+  Bj�ra  ..Bjørn 
unwanted_place(blakk).  %% \+  Flakk
unwanted_place(blinker).  %%  \+ bleiker
%%  unwanted_place(bombingen).  %%  \+ bomringen // Experiment
unwanted_place(brage).   %% name, \+ berge 
unwanted_place(brenne).  %%  \+ Br�nne
unwanted_place(brus).  %% \+  bru
unwanted_place(br�).  %%  Hvor var du da Br� brakk staven
unwanted_place(bush). 
%% unwanted_place(bye).  %%  \+ byen -  eng good bye 
unwanted_place(by�se).  %% By�sen/By�sv(eien)
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
unwanted_place(d�den).  %% (mend�densdalOK)
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
unwanted_place(fj�rta). 
unwanted_place(fjerta). %%
unwanted_place(fl�tten). %% \+ Flaten
unwanted_place(foo).     %%  \+ Foto
unwanted_place(forget).  %% \+ Forset 
unwanted_place(fra).  %% \+  Fram
unwanted_place(fram).  %% \+  framveien
unwanted_place(fre).  %% \+  frue
unwanted_place(fresk).  %%  \+ frues
unwanted_place(from).  %% \+  fram
unwanted_place(fy).  %% \+  by
unwanted_place(fylla).  %% \+  folla
unwanted_place(f�re).  %% (not M�re)
unwanted_place(f�rte).  %% (not F�rde)
unwanted_place(g).  %% Mysterious internal station,\+ g�
unwanted_place(gang).  %%  gang-> gan-g-> grabvegen 
unwanted_place(gave).  %%  \+ gate
unwanted_place(gay).  %% (not May).  %% NBnot actuallyplace
unwanted_place(ger).  %% \+  Ler,probablyg�r
unwanted_place(gj�k).  %% \+  Gj�a
unwanted_place(glede). %% \+ Gilde
unwanted_place(goes).  %%  \+ godes,destroyslanguagedetection
unwanted_place(gp).  %% probablygo,butbecomesgt
unwanted_place(grade). %% \+ graae
unwanted_place(graaem�lla).  %% ?
unwanted_place(gral).  %% gran?
unwanted_place(grille).  %%  \+ Gilles
unwanted_place(gro).  %% \+  bro
unwanted_place(guide).  %% \+Gudesgt
unwanted_place(guten).  %% \+gaten
unwanted_place(g�r).  %% NBMunkvoldg�r
unwanted_place(g�t).  %% probablyg�r,butbecomesgt
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
unwanted_place(henger). %% \+ Hanger(�sen) 
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
unwanted_place(h�ns).  %% \+  Hans
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
unwanted_place(kj�rest).  %%  \+ kj�rems
unwanted_place(kj�nn). 
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
unwanted_place(kr�ke). 
unwanted_place(ku).  %%  \+ KO. . . . 
unwanted_place(kuk).  %%  (not krk)(badwordsshallberepelled)
unwanted_place(kunst).  %%  \+ kuset
unwanted_place(kyr).  %%  \+  kor(korsvegen???)
unwanted_place(k�t).  %%  (Not KVT)
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
unwanted_place(lykke).  %% L�kke
unwanted_place(l�re).  %% (not V�re)
unwanted_place(l�gn).  %%  \+ L�nn(vei)
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
unwanted_place(m�).  %% mo,m1
unwanted_place(m�r).  %% \+  v�r(fruekirke)
unwanted_place(m�kka).  %%  \+ mekka
unwanted_place(m�llen).  %% M�llrnberg/M�ller
unwanted_place(narko).  %% \+nardo(?)
unwanted_place(nek).  %% \+  nrk
unwanted_place(ner).  %% \+  Ler,probablyn�r
unwanted_place(nerd).  %% (not nord)
%% unwanted_place(nissen).  %%  \+ Nissens. . . %% TA-110328
unwanted_place(nr). 
unwanted_place(nr1).  %% (not nrk)
unwanted_place(nr�). 
%%  unwanted_place(ntnui).  %% idrettsbygget? \+ ntnu?
unwanted_place(nuss).  %% buss/N�ss
unwanted_place(n�re).  %% \+  �re
unwanted_place(n�t).  %% (not nt)
unwanted_place(n�r).  %% \+  s�r,probablyn�r. 

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
unwanted_place(pi).  %% (not p�,pir,ii etc)
unwanted_place(pinsen). 
unwanted_place(plage).  %% \+  place
unwanted_place(prins).  %%  \+ paris###
unwanted_place(pul).  %% \+  Paul%NB all dirty words shall be repelled
unwanted_place(pule).  %% \+  Paul
unwanted_place(pult).  %% \+  Paul
unwanted_place(p�l).  %% avoid p�l=p�,give message
unwanted_place(radmann).  %%  \+ r�dmann
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
unwanted_place(sirkus). %%  \+ sirius
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
unwanted_place(str�m).   %% \+storm
unwanted_place(stut).    %% \+ stud
unwanted_place(st�ende). %% \+ Stene 
unwanted_place(sug).     %% \+ Sig. 
unwanted_place(sum). 
unwanted_place(suppen).  %%  \+ sluppen
unwanted_place(syklen).  %%  \+ skolen
unwanted_place(s�).      %%  \+ st
%% unwanted_place(s�tre).   %% \+ s�tres/stare %% foreign 
unwanted_place(s�ren).   %% \+ st�ren
unwanted_place(s�t).     %% \+  s�r
unwanted_place(s�vn). 
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
unwanted_place(tra).    %%  \+ fra/-tr�a
%% unwanted_place(trade).  %%  \+ trane 
unwanted_place(tram).   %%  \+ Tr�a (SIC)
unwanted_place(transe).  %%  \+ tranev
unwanted_place(trynet).  %%  \+ Tynset(SIC)
unwanted_place(tr�ng).  %%  \+ tr�a-vegen(tr�(n)a-g) %% amble#
%% unwanted_place(tuller).  %%  \+ Tiller %% nein 
unwanted_place(ture).   %% \+ Tiur-vegen
unwanted_place(tviler).%%  \+ Tiller
unwanted_place(twin).  %%  \+ Tine
unwanted_place(t�sk).  %%  \+ tysk
unwanted_place(t�ff).  %%  \+ K�FF
unwanted_place(urdu).  %%  \+ Urds vei
unwanted_place('va|ret').  %% \+ V�re  
unwanted_place('va�ret').  %%
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
unwanted_place(vre).    %%  \+ V�re
unwanted_place(world).  %%  \+ wolds
unwanted_place(yrke).   %%  \+ York
unwanted_place(�re).    %%  \+ �vre



%% NOSTATION 
%% places in Trondheim without station (not foreign)

%% TRAM  stations
%%  Experiment Only if not properstation

nostation(arbeidsbuss). %% SIC  endstation bus 100 

nostation(bygrensen):- \+main:myflags(tmnflag,true).    

nostation(ferstad):-   \+main:myflags(tmnflag,true). %% Ferstads vei

nostation(fr�set). 



nostation(herlofsonsl�ypa) :- \+main:myflags(tmnflag,true). 
 nostation(heggsnipen). %% fins ikke i rdata(barei hefte). %%fikset 5.307
nostation(lian):-      \+main:myflags(tmnflag,true).  
nostation(nordre_hoem) :- \+main:myflags(tmnflag,true). 
nostation(rognheim) :- \+main:myflags(tmnflag,true). 
nostation(s�ndre_hoem):- \+main:myflags(tmnflag,true). 


%%%% Nostation  no bus to place ever

nostation(lian). 

nostation(baklidammen). 
nostation(bj�rnebyen).    %% (langs trikkelinjen mot Lian)
nostation(benjaminbyen).  %%
nostation(benjaminsbyen). 

nostation(bybrua).
nostation(bybruen). 
nostation(bybroen). %%  (gamle bybro)
nostation(bybro).  

nostation(byneset_kirke).  

 nostation(by�sveien).              %%   On Map, not on Route 
nostation(devlebukta). 
nostation(devlebukten). 

nostation(elgsethytta). 
nostation(elgsethytten).  
nostation(elgsetshytta).  

nostation(estenestaddammen). 
nostation(estenstadhytta). 
  nostation(fjellseter).  
nostation(fjordgata). %% as street, OK , but underspecified
nostation(flaktveit). %% i Th??? Foreign

nostation(graaem�lna). nostation(graaem�lna). %% nedlagt f.o.m. h�st 2008

nostation(grankollen). 
nostation(gr�kallen). 



 nostation(kj�pmannsgata).          %%  (m. var.)  STREET  
 nostation(leuthenhaven).           %% NOT as such


 % % %

 nostation(arbeidsbuss). %% spurious Reg stations %% fikset 5.3.07
nostation(g).  

nostation(gr�nningen). 

 nostation(heggstadmyra).  %% -> heggstadmoen
 nostation(hornebergveien).         %%  OK (ONLY in WINTER)
 nostation(haakon_vii_gate). %% Not in summer 

 nostation(h�rstad).        %% hpl 503 Non Existent -> Krgeness
nostation(h�rstadstien). %% 

nostation(lavoll). 
nostation(lavollen). 
nostation(geitfjellet). 

nostation(gr�nnlia). 
nostation(lilleg�rdsbakken).    
nostation(munkholm).  
nostation(munkholmen).  
  nostation(m�ller_bil).        %% not in summer 
nostation(nardoskrenten). 

%  nostation(nidelv_bru). %% nedlagt 22. mars %% TA-110822

% nostation(nidar�).    %% Trondheim spektrum 
 nostation(nordre_ilevollen).  
 nostation(omkj�ringsveien_nardo). %% Not in summer 
nostation(olsborg).   %%  Trlag ???
 nostation(royal_garden).   
  nostation(skistua). 

 nostation(roial_garden). %% only 1 departure with nightbus 
                            %% However, hotell royal garden neighbourhood                     
nostation(sommerseter). 
nostation(sommers�ter). 
nostation(sommers�tra).  
nostation(sommersetra).


nostation(stokkmarka).
 nostation(storgata).    %%  foreign 

 nostation(steinaunet).

 nostation(studenterhytta). 
nostation(sundalsveien). 
nostation(sundlandsskrenten). 
nostation(sunnlandsskrenten).      %%  (no spellc)
nostation(sundlandsveien). 
    nostation(sundlandsvn). %% NO SPELLCORR to NOSTATION 
 nostation(sundlandsskrenten). 
  nostation(st_olavs_gate). 

nostation(teisendammen).  
nostation(theisendammen). 

nostation(teisendamen).   %% X
nostation(theisendamen).  %% X

nostation(ullins_vei). %% abandoned 2006 
                       %% street remains

nostation(varden). %% i TH?  
nostation(vollmarka). 
nostation(v�ddan).        %%

nostation('�vre Alle'). 

%%%%%% Conversion  Team Station names > 100822
    %%             AtB Station names  < 100823

aliasteamatb(16010001,munkegata_m1,munkegata_m1). %% just 1 for safety

%%%%%%%  9940 %%%%

%% CMPL 

cmpl(st,[o,hospital],st_olavs_hospital).         %% Fronted for test 


cmpl(3,[t,rosten],maskinagentur).  %%  \+  l�rdag kl.  0300 ." Vetrse Rosten 80
                                                        
cmpl(a,[s,trondheim,trafikkselskap],tt). 
cmpl(aalmos,gate,o_j_aalmos_street). 
cmpl(aalmos,veg,o_j_aalmos_street). 
cmpl(aalmos,vei,o_j_aalmos_street). 
cmpl(aasveien,[skole],�sveien_skole). 
cmpl(abra,hallen,abrahallen). 
cmpl(adm,rit,adm_rit).  %% unvisited station
cmpl(adolf,[�ien,skole],'Adolf �iens skole').   %% NEC????
cmpl(adolf,[�iens,skole],'Adolf �iens skole').  %% EH-041004
cmpl(adolf,�ien,adolf_�ien). 
cmpl(adressa,[p�,heimdal],adresseavisen). 
cmpl(adresseavisen,[heimdal],adresseavisen). 
cmpl(adresseavisen,[p�,heimdal],adresseavisen).
cmpl(alfgodagers,vei,alf_godagers_vei). 

cmpl(alfred,[h�yems,vei],hallfred_h�yems_vei). 
cmpl(alfred,[h�yemsv],hallfred_h�yems_vei). 
cmpl(alfred,[h�yemsveg],hallfred_h�yems_vei). 
cmpl(alfred,[h�yemsvei],hallfred_h�yems_vei). 
cmpl(alfredh�yems,[veg],hallfred_h�yems_vei). 

cmpl(alt,['/',statoil],'ALT/Statoil'). %% extra dep bus 6

cmpl(amo,['-',senteret],amo_senteret). 
cmpl(amo,['-',sentret],henrik_ourens_vei). 
cmpl(amo,senteret,amo_senteret). 
cmpl(amundsens,vei,roald_amundsens_street). 
cmpl(anders,[bu�s,vei],anders_buens_gate). 
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
cmpl(arne,berg�rdsvei,arne_bergsg�rds_street). 
cmpl(arne,berg�rdsvei,arne_bergsg�rds_vei).  %% Trouble
cmpl(arnebergsg�rds,vei,arne_bergsg�rds_vei). 
cmpl(arnt,smestadsvei,arnt_smistads_vei).  %% ?
cmpl(arntsmistads,vei,arnt_smistads_vei).  
cmpl(arntsmistadsvei,[],arnt_smistads_vei). %% TA-110329

cmpl(as,[trondheim,trafikkselskap],tt). 
cmpl(asbj,gate,asbj�rnsens_gate). 
cmpl(asbj�rn,�veraasv,asbj�rn_�ver�s_street). 
cmpl(asbj�rn,�veraasveg,asbj�rn_�ver�s_street). 
cmpl(asbj�rn,�veraasvei,asbj�rn_�ver�s_street). 
cmpl(asbj�rnover�s,veg,asbj�rn_�ver�s_street). 
cmpl(asbj�rns,[ens,gate],asbj�rnsens_gate).  %% ?act
cmpl(asbj�rns,[gate],asbj�rnsens_gate). 
cmpl(asbj�rnsens,[],asbj�rnsens_gate).  %% Haz ? 
cmpl(asbj�rn�ver�s,veg,asbj�rn_�ver�s_street). 
cmpl(asveien,[skole],�sveien_skole). 
cmpl(auto,[2000],fossegrenda). 
cmpl(avishuset,[p�,heimdal],adresseavisen). 
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
cmpl(bedrifts�konomisk,institutt,bi). 
cmpl(ber,studentby,berg_studentby).  %% < 4 bokst
cmpl(berg,skole,bergsbakken). %%   BERGSBAKKEN 17 , Harald Gilles veg .?
cmpl(berg,[skole,p�,tyholt],bergsbakken). 
cmpl(berg,[st,by],berg_studentby).  %%
cmpl(berg,[student,by],bugges_veg). 

cmpl(berg,arbeiderkirke,'Berg arbeidskirke'). %% \= berg_presteg�rd). 
cmpl(berg,arbeidskirke,'Berg arbeidskirke'). 
cmpl(berg,arbeidskyrkje,'Berg arbeidskirke'). 
cmpl(berg,bedehus,'Berg arbeidskirke'). 
cmpl(berg,kirke,'Berg arbeidskirke'). 

cmpl(berg,skole,bergsbakken). 
cmpl(berg,student,berg_studentby).  %% ?
cmpl(bergstudent,by,berg_studentby).
cmpl(berg,�stre,�stre_berg). 
cmpl(bergheim,amfi,bergheim). 
cmpl(bergheim,terrasse,bergheim). 
cmpl(bergs,alle,sig_berg_alle).  %% \+ sig bergs
cmpl(bergsg�rds,[vei],arne_bergsg�rds_vei). 
cmpl(bi,tiller,�stre_rosten). 
cmpl(bi,trondheim,bi). 
cmpl(billett,kontoret,servicekontoret). 
cmpl(bilsakkyndig,sluppen,e_verket). 
cmpl(bilsakkyndige,sluppen,e_verket). 
cmpl(biologisk,stasjon,biologen). 

cmpl(birkelands,gt,richard_birkelands_street).  
cmpl(birkelands,vei,richard_birkelands_street). 

cmpl(biskop,[gunnerus,gate],gunnerus_street). 
cmpl(biskop,[sigeruds,gate],biskop_sigurds_gate). 
cmpl(biskop,[syrs,gate],biskop_sigurds_gate). %% sigurd syr \= biskop sigurd 
cmpl(biskop,[sigurdsons,gate],biskop_sigurds_gate). 
cmpl(biskopsigurds,gate,biskop_sigurds_gate). 

cmpl(bispehaugen,skole,bakkegata).  %% Nonnegt 19
cmpl(bjarne,[naess,vei],bjarne_ness_veg). 
cmpl(bjarne,wist,stj�rdals_street). 
cmpl(bj�rndals,brua,bj�rndalsbrua). 
cmpl(bj�rndals,toppen,bj�rndalstoppen). 
cmpl(blindes,hus,churchills_veg). 
cmpl(blussuvold,skole,tyholtt�rnet). 
cmpl(blussuvoll,skole,tyholtt�rnet). 
cmpl(boat,pier,pirbadet).


cmpl(bothners,v,harald_bothners_veg). 
cmpl(bothners,vei,harald_bothners_veg). 
cmpl(bragstads,[plass],o_s_bragstads_plass). 
%%%% cmpl(brit,[grytbakks,vei],brit_grytbakks_street). %% Ad Hoc (Ny veg,ikke nr)
cmpl(bratsberg,skole,bratsberg).   

cmpl(britannia,hotell,britannia_hotell). %% Flybussen 
cmpl(hotell,britannia,britannia_hotell). %% Flybussen 

cmpl(broch,[s,gate],prof_brochs_gate).  %%broch'sgate
cmpl(brochs,gata,prof_brochs_gate). 
cmpl(brochs,gate,prof_brochs_gate). 
cmpl(brochs,gt,prof_brochs_gate). 
cmpl(brochs,vei,prof_brochs_gate). 
cmpl(bromstad,svingen,bromstadsvingen). 
cmpl(brun,dalen,brundalen). 
cmpl(brundalen,[sykeheim],brundalen_sykehjem). 
cmpl(brundalen,[sykehjem],brundalen_sykehjem). 
cmpl(brundalen,[v,g,s],brundalen_skole).
cmpl(brundalen,[v,g,skole],brundalen_skole).
cmpl(brundalen,[vg,skole],brundalen_skole). 
cmpl(brundalen,[videreg�ende,skole],brundalen_skole). 
cmpl(brundalen,[videreg�ende,skolesenter],brundalen_skole). 
cmpl(brundalen,skolesenter,brundalen_skole).
cmpl(brundalen,videreg�ende,brundalen_skole).
cmpl(brundalen,yrkesskole,brundalen_skole).
cmpl(br�set,hageby,br�set_hageby). 
cmpl(br�set,sykehus,'Br�set sykehus'). 
cmpl(br�setv,[168],br�setvegen_168). 
cmpl(br�setvegen,[168],br�setvegen_168).  %% nec ?. . . 
cmpl(br�setvegen,[168],br�setvegen_168). 
cmpl(br�setvn,[168],br�setvegen_168). 
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
cmpl(by�,['+',sen],by�sen). 
cmpl(by�,sen,by�sen).  %%by�+senslip
cmpl(by�sen,[butikk,senter],by�sen_butikksenter). 
cmpl(by�sen,kj�pesenter,by�sen_butikksenter). %% TA-101123

cmpl(by�sen,skole, by�sen_skole).      
cmpl(by�sen,barneskole, by�sen_skole).  
cmpl(by�sen,ungdomsskole,  by�sen_skole).

cmpl(by�sen,vgs,       by�sen_videreg�ende_skole). 

cmpl(by�sen,[v,g,skole], by�sen_videreg�ende_skole).     %% TA-110610  byåsen v.g skole 
cmpl(by�sen,[v,'.',g,skole], by�sen_videreg�ende_skole). %% nec ? 


cmpl(by�sen,[vgs,skole],   by�sen_videreg�ende_skole). %% 
cmpl(by�sen,videreg�ende,  migosenteret). %% by�sen_videreg�ende_skole). %% neib gets lower priority than by�sen skole
cmpl(by�sen,[videreg�ende,skole],   by�sen_videreg�ende_skole). %%

cmpl(by�sen,butikksenter,by�sen_butikksenter). 
cmpl(by�sen,senter,by�sen_butikksenter). 
cmpl(by�sen,senteret,by�sen_butikksenter). 
cmpl(by�sen,ugla,ugla). 
cmpl(by�sen,vei,by�sveien). %% ?
cmpl(by�sen,veien,by�s_street).  %%
cmpl(by�senbutikk,senter,by�sen_butikksenter). 
cmpl(by�senvidereg�ende,skole,by�sen_skole). %% migosenteret). %% 

cmpl(boechmans,vei,b�ckmansveien). % n
cmpl(b�ckmannsv,[],b�ckmansveien). %% TA-110314
cmpl(bockmannsv,[],b�ckmansveien). %% ad hoc 
cmpl(b�chmanns,vei,b�ckmansveien). 
cmpl(b�ckmans,veg,b�ckmansveien). 
cmpl(b�ckmans,vei,b�ckmansveien). 
cmpl(b�kmans,vei,b�ckmansveien). 

cmpl(b�ndernes,salgslag,gartnerhallen). 

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
cmpl(charlottenlund,[ung,skole],charlottenlund_videreg�ende). %?
cmpl(charlottenlund,[videreg�ende,skole],charlottenlund_videreg�ende). 
cmpl(charlottenlund,[�vre],skovg�rd). 
cmpl(charlottenlund,hallen,charlottenlundhallen). 
cmpl(charlottenlund,n,charlottenlund_nedre). 
cmpl(charlottenlund,skole,charlottenlund_skole). 
cmpl(charlottenlund,ungdomsskole,charlottenlund_skole). 
cmpl(charlottenlund,videreg�ende,charlottenlund_videreg�ende). 
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


cmpl(city,syd,city_syd). %% TA-110627 %% NB city syd no longer aut. generated
cmpl(citi,syd,city_syd). 
cmpl(city,['-',syd],city_syd). 
cmpl(city,['/',syd],city_syd). 

cmpl(city,ade,city_lade). 

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
cmpl(city,lade,city_lade).  %% station
cmpl(city,sydp�,city_syd). 
cmpl(cj,[hambros,veg],c_j_hambros_vei). 
cmpl(cj,[hambros,vei],c_j_hambros_vei). %nec??
cmpl(cj,hambros,c_j_hambros_vei). 
cmpl(cj,hambrosv,c_j_hambros_vei). 
cmpl(cj,hambrosvei,c_j_hambros_vei). 
cmpl(cl,[lund,kirke],charlottenlund_kirke). 

cmpl(comfort,[hotel,park],'Comfort Hotel Park'). 

cmpl(cruise,pier,pirbadet).
cmpl(cruise,port,pirbadet). 
cmpl(curtshill,gate,churchills_veg). 
cmpl(cyti,syd,city_syd). 
cmpl(d,[1],dronningens_gate_d1). 
cmpl(d,[2],dronningens_gate_d2). 
cmpl(d,[3],dronningens_gate_d3). 
cmpl(d,[4],dronningens_gate_d4). 
cmpl(d,[l,�verlidsv],distriktslege_�verlids_vei). 
cmpl(d,[l,�vrelidsv],distriktslege_�verlids_vei). 
cmpl(d,gt,dronningens_gate).  %% \+ dv(dragvoll)aliasdv_street
cmpl(dagen,hageby,dalen_hageby). 
cmpl(dahls,bryggeri,strandveikaia). 
cmpl(dalen,['/',hageby],dalen_hageby). 
cmpl(dalen,[hage,by],dalen_hageby). 
cmpl(dalenhage,[by],dalen_hageby). 
cmpl(dalg�rd,skole,'Dalg�rd skole'). 
cmpl(dalg�rd,stien,dalg�rdstien). 
cmpl(dals,[aune,veien],dalsauneveien).  %%  
cmpl(den,[sjuendes],vii).  %% Ad Hoc H7
cmpl(devle,g�rd,devleg�rd). 
cmpl(din,bil,'Din bil'). 
cmpl(diplom,is,iskremfabrikken). 
cmpl(dist,[lege,�vrelids,v],distriktslege_�verlids_vei).  %%in catalog
cmpl(distr,[lege,�vrelids,vei],distriktslege_�verlids_vei). % etc. 
cmpl(distriktslege,[�verlids,veg],distriktslege_�verlids_vei). 
cmpl(distriktslege,[�verlids,vei],distriktslege_�verlids_vei). 
cmpl(distriktslege,[�vrelids,vei],distriktslege_�verlids_vei). 
cmpl(distriktslege,�verlidsv,distriktslege_�verlids_vei). %etc. 
cmpl(disttriktlege,[�verlids,veg],distriktslege_�verlids_vei).  %% (2 spells)
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
cmpl(dragvo,ll,dragvoll).    %% dragvo�ll?

cmpl(dragvoll,campus,dragvoll).
cmpl(dragvoll,g�rd,lohove).  %% (?)
cmpl(dragvoll,h�gskole,dragvoll). 
cmpl(dragvoll,h�yskole,dragvoll).  %%. . . AVH. . . 
cmpl(dragvoll,idrettssenter,dragvoll).  %%?
cmpl(dragvoll,ntnu,dragvoll). 
cmpl(dragvoll,universitet,dragvoll).  %% universitetet_dragvoll???
cmpl(dronn,[gt,d1],dronningens_gate_d1).  %% Because it is your abbrev. 
cmpl(dronn,[gt,d2],dronningens_gate_d2). 
cmpl(dronn,[gt,d3],dronningens_gate_d3). 
cmpl(dronn,[gt,d4],dronningens_gate_d4). 
cmpl(dronn,gt,dronningens_gate).  %%Asyouspeak,

cmpl(dronning,[mauds,h�gskole],dalen_hageby). 
cmpl(dronning,[mauds,institutt],dalen_hageby). 
cmpl(dronning,[mauds,minne,h�gskole],dalen_hageby). 
cmpl(dronning,[mauds,minne],dalen_hageby). 
cmpl(dronning,[maudsminne,h�gskole],dalen_hageby). 
cmpl(dronning,[maudsminne,h�yskole],dalen_hageby). 
cmpl(dronning,[maud,minne,skole],dalen_hageby). 

cmpl(dronning,gt,dronningens_gate). 
cmpl(dronning,maud,dalen_hageby). 
cmpl(dronning,[s,gate],dronningens_gate).


cmpl(dronningens,[gate,holdeplass,d,1],dronningens_gate_d1). 
cmpl(dronningens,[gate,holdeplass,d,2],dronningens_gate_d2). 
cmpl(dronningens,[gate,holdeplass,d,3],dronningens_gate_d3). 
cmpl(dronningens,[gate,holdeplass,d,4],dronningens_gate_d4). 

cmpl(dronningens,[gate,holdeplass,d1],dronningens_gate_d1). %% d 1 -> d1 is prelexed
cmpl(dronningens,[gate,holdeplass,d2],dronningens_gate_d2). %% ugly ?
cmpl(dronningens,[gate,holdeplass,d3],dronningens_gate_d3).
cmpl(dronningens,[gate,holdeplass,d4],dronningens_gate_d4). 


cmpl(dronningens,[gate,d,1],dronningens_gate_d1). 
cmpl(dronningens,[gate,d,2],dronningens_gate_d2). 
cmpl(dronningens,[gate,d,3],dronningens_gate_d3). 
cmpl(dronningens,[gate,d,4],dronningens_gate_d4). 

cmpl(dronningens,[gate,d,1],dronningens_gate_d1). 
cmpl(dronningens,[gate,d,2],dronningens_gate_d2). 
cmpl(dronningens,[gate,d,3],dronningens_gate_d3). 
cmpl(dronningens,[gate,d,4],dronningens_gate_d4). 

cmpl(dronningens,[gate,d1],dronningens_gate_d1). %% if not split
cmpl(dronningens,[gate,d2],dronningens_gate_d2). 
cmpl(dronningens,[gate,d3],dronningens_gate_d3). 
cmpl(dronningens,[gate,d4],dronningens_gate_d4). 

cmpl(dronningens,[gt,d,1],dronningens_gate_d1). 
cmpl(dronningens,[gt,d,2],dronningens_gate_d2). 
cmpl(dronningens,[gt,d,3],dronningens_gate_d3). 
cmpl(dronningens,[gt,d,4],dronningens_gate_d4). 

cmpl(dronningens,[gt,d1],dronningens_gate_d1). 
cmpl(dronningens,[gt,d2],dronningens_gate_d2).  
cmpl(dronningens,[gt,d3],dronningens_gate_d3). 
cmpl(dronningens,[gt,d4],dronningens_gate_d4). 

cmpl(dronningens,gata,dronningens_gate). 
cmpl(dronningens,gate,dronningens_gate). 
cmpl(dronningens,gate,hovedterminalen). 
cmpl(dronningens,gt,dronningens_gate). 

cmpl(dronningensgate,[d,1],dronningens_gate_d1). %% TA-101026
cmpl(dronningensgate,[d,2],dronningens_gate_d2). 
cmpl(dronningensgate,[d,3],dronningens_gate_d3). 
cmpl(dronningensgate,[d,4],dronningens_gate_d4). 

cmpl(dronningensgate,[holdeplass,d,1],dronningens_gate_d1). 
cmpl(dronningensgate,[holdeplass,d,2],dronningens_gate_d2). 
cmpl(dronningensgate,[holdeplass,d,3],dronningens_gate_d3). 
cmpl(dronningensgate,[holdeplass,d,4],dronningens_gate_d4). 

cmpl(dronningensgate,[d1],dronningens_gate_d1). %% if not split
cmpl(dronningensgate,[d2],dronningens_gate_d2). 
cmpl(dronningensgate,[d3],dronningens_gate_d3). 
cmpl(dronningensgate,[d4],dronningens_gate_d4). 

cmpl(dronningensgate,[holdeplass,d1],dronningens_gate_d1). 
cmpl(dronningensgate,[holdeplass,d2],dronningens_gate_d2). 
cmpl(dronningensgate,[holdeplass,d3],dronningens_gate_d3). 
cmpl(dronningensgate,[holdeplass,d4],dronningens_gate_d4). 

cmpl(dronningmauds,[minne,h�yskole],dalen_hageby). 
cmpl(dronningmauds,[minne,h�yskole],dalen_hageby). 
cmpl(dronnings,gate,dronningens_gate). 
cmpl(dv,dragvoll,dv).        %% presented as DV(Dragvoll)

cmpl(dybdahls,v,dybdahls_veg).  %% summer/ vinter: dybdals_veg %% TA-110704
cmpl(dybdahls,veg,dybdahls_veg).  %%
cmpl(dybdahls,vegen,dybdahls_veg).  %%

cmpl(dyre,[halses,gate],nidelv_bru).  %% ? ad hoc
cmpl(dyre,[halses,gt],nidelv_bru).    %%
cmpl(dyre,halsesgate,nidelv_bru).   

cmpl(d�dens,dal,h�yskoleringen). 
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

cmpl(e,[c,dahls,bryggeri],strandveikaia).  %%
cmpl(e,[c,dahls,gate],e_c_dahls_street).   %% central


cmpl(e,berg,berg). 

cmpl(e,[brochs,gate],prof_brochs_gate).

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


cmpl(einar,�fstisv,einar_�fstis_veg). 

cmpl(elgeseter,bru,studentersamfundet). 
% cmpl(elgeseter,gata,elgeseter).  %% (no spell on gata)

cmpl(elgeseter,gate,prof_brochs_gate). 
%% cmpl(elgeseter,gt,elgeseter). 
%% cmpl(elgseter,[gt],elgeseter). 
cmpl(elgseter,bru,studentersamfundet). 
cmpl(elgs�ter,bru,studentersamfundet). 
cmpl(elgs�ter,gata,prof_brochs_gate). 
cmpl(elgs�ter,gt,prof_brochs_gate). 
cmpl(endeholdeplass,vestlia,vestlia_endeholdeplass). 
cmpl(engelbrektssons,alle,olav_engelbrektssons_alle). %% AtB 
cmpl(engelbretsons,alle,olav_engelbrektssons_alle).  %% egt/ekt
cmpl(esso,motorhotell,esso_motorhotell).  %% Lazy complex

cmpl(europavei,6,e6). 
cmpl(e6,nardo,omkj�ringsveien_nardo).


cmpl(erlingskakkes,gate,erling_skakkes_street). 
cmpl(erlingskakkes,[],erling_skakkes_street). 

cmpl(f,[b,wallems,vei],fredrik_b_wallems_street). 
cmpl(f,[nansens,vei],fritjof_nansens_street). 
cmpl(f,[nissens,v],fernanda_nissens_street).  %% Syndrome
cmpl(fagerheim,alle,fagerheim_alle). 
cmpl(fagerheim,all�,fagerheim_alle).  %% Necessary, because all� is a partname
cmpl(falkbergets,veg,johan_falkbergets_veg). 
cmpl(falkbergets,vei,johan_falkbergets_veg). 
cmpl(falkenborg,studentby,falkenborg). 
cmpl(fb,[wallems,vei],fredrik_b_wallems_street). 
cmpl(fengselet,[p�,tunga],tunga_kretsfengsel). 
cmpl(fengselet,tunga,tunga_kretsfengsel). 

cmpl(ferjeleiet,[p�,flakk],flakk). 
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
cmpl(flakk,r�rvik,flakk).  %% Ferja
cmpl(flakkfergekai,[],flakk).
cmpl(flakkfergekaien,[],flakk).

cmpl(ferstad,street,nedre_ferstad_street).  %%  NB ferstad
cmpl(ferstad,street,�vre_ferstad_street).   %%
cmpl(festningens,gate,festningsgata).  %%
cmpl(festnings,parken,festningsparken).  
cmpl(fiol,svingen,fiolsvingen). 
cmpl(fla,t�sen,flat�sen).     %% �-tr�bbel
cmpl(flat,['?',sen],flat�sen). 

cmpl(flatasen,[],flat�sen). %% e.g. fltasen %% TA-110331

cmpl(flat,�sen,flat�sen). 
%% cmpl(flat�,['+'],sen,flat�sen).  %% T-110310
cmpl(flat�,sen,flat�sen).  
cmpl(flat�s,[toppen],flat�stoppen). 
cmpl(flat�s,senteret,flat�sen_senter). 
cmpl(flat�sen,butikksenter,flat�sen_senter). 
cmpl(flat�sen,s,flat�sen_senter). 
cmpl(flat�sen,senteret,flat�sen_senter). 
cmpl(flat�sen,sentrum,flat�sen_senter).  %%(amb)
cmpl(flat�sen,skole,flat�sen_senter).  %%??2. choice
cmpl(flybuss,holdeplass,flybussterminalen). 
cmpl(fokus,hallen,vestre_rosten). 
cmpl(folkemuseet,sverresborg,tr�ndelag_folkemuseum). 
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
cmpl(g,l�shaugen,gl�shaugen). 
cmpl(gaden,[og,larsen],stiklestadveien). 
cmpl(gaden,larsen,stj�rdals_street). 
cmpl(gaden,wist,stj�rdals_street). 
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
cmpl(gamle,nth,gl�shaugen_syd). 
cmpl(gamle,�svei,gamle_�s_street).  %%Street!
cmpl(gamle,�sveien,gamle_�s_street). 
cmpl(gamlekonge,vei,kongsvegen). 
cmpl(gammel,lena,gammel_lina). 
cmpl(gammel,lian,gammel_lina). 
cmpl(gammel,line,gammel_lina). 
cmpl(gartner,hallen,gartnerhallen). 
cmpl(gartnerhallen,[p�,tunga],gartnerhallen). 
cmpl(gartnerhallen,[tunga],gartnerhallen). 
cmpl(landbrukssenteret,[tunga],gartnerhallen). 
cmpl(gauldal,billag,gauldal_billag). 
cmpl(generalwibes,v,general_wibes_street). 
cmpl(gerhard,[sch�nings,skole],torget). 
   cmpl(sch�ning,[videreg�ende,skole],torget). 
cmpl(gildevangen,hotell,s�ndregate). 
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
cmpl(gina,kroghsv,gina_krogs_veg). 

cmpl(gl,['&',248,shaugen],gl�shaugen). 
cmpl(gl,shaugen,gl�shaugen).  %% ���trouble %%Gl;haugen

cmpl(gloeshaugen,[],gl�shaugen). 
cmpl(gloeshaugen,ntnu,gl�shaugen_nord). 
cmpl(gl�s,haugen,gl�shaugen). 
cmpl(gl�shaugen,campus,gl�shaugen). 

cmpl(gl�shaugen,idrettssenter,h�yskoleringen). 
cmpl(gl�shaugen,[idretts,senter],h�yskoleringen). %% nec %% TA-101110
cmpl(gl�shaugen,n,gl�shaugen_nord). 
cmpl(gl�shaugen,nord,gl�shaugen_nord). 
cmpl(gl�shaugen,ntnu,gl�shaugen_nord). 
cmpl(gl�shaugen,s,gl�shaugen_syd). 
cmpl(gl�shaugen,s�r,gl�shaugen_syd). 
cmpl(godagers,[vei],alf_godagers_vei). 

cmpl(gods,nsb,terminalen).  %% godsterminalen_nsb -> terminalen (AtB)
cmpl(godsstasjonen,nsb,terminalen). 
cmpl(godst,nsb,terminalen). 
cmpl(gr,m�lna,graaem�lna). 
cmpl(graae,m�lna,graaem�lna). 
cmpl(granskogen,skole, kolstadhaugen). 
cmpl(granasen,vm,gran�sen_vm_anlegget). 
cmpl(gran�sen,[alpinsenter],gran�sen_vm_anlegget).  %% \+ alpine though
cmpl(gran�sen,[ski,anlegg],gran�sen_vm_anlegget). 
cmpl(gran�sen,[ski,arena],gran�sen_vm_anlegget). 
cmpl(gran�sen,[ski,senter],gran�sen_vm_anlegget). 
cmpl(gran�sen,[vm,anlegg],gran�sen_vm_anlegget). 
cmpl(gran�sen,[vm,anlegg],gran�sen_vm_anlegget).  %%needshash
cmpl(gran�sen,skianlegg,gran�sen_vm_anlegget). 
cmpl(gran�sen,skisenter,gran�sen_vm_anlegget). 
cmpl(gran�sen,skistadion,gran�sen_vm_anlegget). 
cmpl(gran�sen,skistadium,gran�sen_vm_anlegget).
cmpl(gran�sen,vm,gran�sen_vm_anlegget). 
cmpl(gran�sen,vmanlegg,gran�sen_vm_anlegget). 
cmpl(gran�sen,vmanlegget,gran�sen_vm_anlegget). 
cmpl(gran�sen,vmarena,gran�sen_vm_anlegget). 
cmpl(grevskotts,vei,anton_grevskotts_vei).  %%Rulehere?
cmpl(grilstad,fj�ra,grilstadfj�ra). 
cmpl(gr�e,m�lle,graaem�lna). 
cmpl(gr�kall,banen,gr�kallbanen). 
cmpl(gr�kallen,skisenter,skistua).  %%?
cmpl(gudes,[gate],gudes_gate). 
cmpl(gudes,[vei],gudes_gate). 
cmpl(gudesgate,[],gudes_gate). 

cmpl(h,[botners,v],harald_bothners_veg). 

cmpl(haakon,['7',gate,25],haakon_vii_gate_25). 
cmpl(haakon,['7s',gate,25],haakon_vii_gate_25). 
cmpl(haakon,['7s',gate],haakon_vii_gate_25). 
cmpl(haakon,[7,g],haakon_vii_gt). 
cmpl(haakon,[7,gate],haakon_vii_gt). 
cmpl(haakon,[7,gate],haakon_vii_gt). 
cmpl(haakon,[7,gt],haakon_vii_gt).  %% a. s. o. . . . 
cmpl(haakon,[7,s,gate,25],haakon_vii_gate_25). 
cmpl(haakon,[7,s,gate],haakon_viis_street).  %% haakon7. s gate 8
cmpl(haakon,[den,'7s',gate],haakon_vii_gate_25). 
cmpl(haakon,[den,7,gate],haakon_vii_gt). 
cmpl(haakon,[den,7,gt],haakon_vii_gt). 
cmpl(haakon,[den,sjuendes,gate,25],haakon_vii_gate_25). 
cmpl(haakon,[den,sjuendes,gate],haakon_vii_gt). 
cmpl(haakon,[den,vii,gate],haakon_vii_gt). 
cmpl(haakon,[den,vii,gt],haakon_vii_gt). 
cmpl(haakon,[den,vii,s,gate],haakon_vii_gt). 
cmpl(haakon,[gate,vii],haakon_vii_gt). 
cmpl(haakon,[sjuendes,gate,25],haakon_vii_gate_25). 
cmpl(haakon,[sjuendes,gate],haakon_vii_gt). 
cmpl(haakon,[vii,gate],haakon_vii_gt). 
cmpl(haakon,[vii,gt],haakon_vii_gt). 
cmpl(haakon,[vii,s,g],haakon_vii_gt). 
cmpl(haakon,[vii,s,gate],haakon_vii_gt). 
cmpl(haakon,[vii,s,gate],haakon_vii_gt). 
cmpl(haakon,[vii,s,gate],haakon_vii_gt).  %% Experiment
cmpl(haakon,[vii,s,gt],haakon_vii_gt). 
cmpl(haakon,[vii,s,gt],haakon_vii_gt). 
cmpl(haakon,[vii,s,gt],haakon_vii_gt). 
cmpl(haakon,[vii,s,vei],haakon_vii_gt). 
cmpl(haakon,[vii,vei],haakon_vii_gt). 
cmpl(haakon,[vii,vei],haakon_vii_gt). 
cmpl(haakon,[viis,gate],haakon_vii_gt). 
cmpl(haakon,sjuendes,haakon_vii_gt). 
cmpl(haakon,viigt,haakon_vii_gt). 
cmpl(haakon7,gate,haakon_vii_gt). 
cmpl(haakon7gt,25,haakon_vii_gate_25). 
cmpl(haakonvii,[gate],haakon_vii_gate_25). 
cmpl(haakonvii,[s,gate],haakon_vii_gt). 
cmpl(haakonviigt,25,haakon_vii_gate_25). 

cmpl(hallfred,[h,veg],hallfred_h�yems_vei). 
cmpl(hallfred,[h�yems,veg],hallfred_h�yems_vei).  %%vei
cmpl(hallfredh�yems,vei,hallfred_h�yems_vei). 
cmpl(hallgrim,[h�yems,vei],hallfred_h�yems_vei). 
    cmpl(harald,[h�yems,vei],hallfred_h�yems_vei). 
cmpl(hallset,[videreg�ende,skole],s�ndre_halset). 
cmpl(hallset,kirke,hallset).  %%???
cmpl(hallset,skole,s�ndre_halset).  %%�strehallsetvangen8
cmpl(hallstein,g�rd,halstein_g�rd). 
cmpl(hallstein,g�rden,halstein_g�rd). 
cmpl(halset,kirke,migosenteret). 
cmpl(halvor,[h�yems,vei],hallfred_h�yems_vei).  %% Extraservice
cmpl(hambros,v,c_j_hambros_vei).   %%  #-> unnec
cmpl(hambros,veg,c_j_hambros_vei). %%
cmpl(hambros,vei,c_j_hambros_vei). %%
cmpl(hans,[finnes,gate],hans_finnes_street). %% nec, ambig 
cmpl(hansfinnes,gate,hans_finnes_street). 
cmpl(hansfinnes,gt,hans_finnes_street). 
cmpl(hanskemakergata,[],hanskemakerbakken). %% TA-101013
cmpl(hanskemaker,bakken,hanskemakerbakken). 
cmpl(hanskemakker,bakken,hanskemakerbakken). 
cmpl(harald,[bothners,vei],harald_bothners_veg). 
cmpl(harald,bothnersvei,harald_bothners_veg). 
cmpl(harald,[botners,vei],harald_bothners_veg). 
cmpl(harald,[ourens,vei],henrik_ourens_vei). 
cmpl(harald,h�rfagres,harald_h�rfagres_street). 

cmpl(harald,[hardr�des,plass],harald_hardr�des_street). %% ? 
cmpl(harald,[h�rdr�des,plass],harald_hardr�des_street). %%

cmpl(haugnes,[svingen],haugnessvingen).
cmpl(hauk�sen,[psykiatriske,sykehus],hauk�sen). 
cmpl(hauk�sen,sykehus,hauk�sen). 
cmpl(havstad,senter,havstadsenteret). %% TA-110316
cmpl(havstad,senteret,havstadsenteret).
cmpl(havstein,[i,by�sen],havstein). 
cmpl(havstein,kirke,havstadsenteret).  %% better than "u nderspecified kirke"
cmpl(heggstadmoen,[14],heggstadmoen_4).  %%(actual)
cmpl(heim,[dal],heimdal). 
cmpl(heimdal,['/',kolstad],kolstad).
cmpl(heimdal,[v,g,skole],saupstadsenteret). 
cmpl(heimdal,[videreg�ende,skole],saupstadsenteret). 
cmpl(heimdal,kirke,heimdal_stasjon).  %% Kirkeringen
cmpl(heimdal,politistasjon,'Heimdal politistasjon').  %% EH-041004
cmpl(heimdal,sentralstasjon,heimdal_stasjon). 
%% cmpl(heimdal,sentrum,heimdal_stasjon). %% station 
cmpl(heimdal,skole,saupstadsenteret).  %% ( barneskole??? )
cmpl(heimdal,st,heimdal_stasjon). 
cmpl(heimdal,vdg,saupstadsenteret). 
cmpl(heimdal,vgs,saupstadsenteret). 

%%%  cmpl(heimdal,[videreg�ende,skole],hvs). %% ? %% TA-110502


%% cmpl(heimdals,sentrum,heimdal_stasjon).   %% station  %% ( \+  spellc of legal names)
cmpl(hell,[bil,lade],j�rgen_b_lysholms_vei). 
cmpl(hell,[bil],j�rgen_b_lysholms_vei). 
cmpl(hell,togstasjon,hell). 
cmpl(hell,t�gstasjon,hell).  %% no spc
cmpl(helse,[og,sosialh�gskolen],gildheim). % ?
cmpl(hemne,[og,orkdal,billag],hob). 
cmpl(henrik,[matisens,vei],henrik_mathiesens_street). 
cmpl(henrikourens,vei,henrik_ourens_vei).  
cmpl(hermankrags,vei,herman_krags_street). 
cmpl(hest,sj�en,hestsj�en). 
cmpl(hist,ahs,gildheim). 
cmpl(hist,aitel,torget).        %%
cmpl(hist,alt,rotvoll_alle).    %% AtB
cmpl(hist,alu,rotvoll_nedre).   %% Avdelingfor L�rerutdanning
cmpl(hist,ammt,gartnerhallen).  %%
cmpl(hist,asp,rotvoll_nedre).   %%
cmpl(hist,rotvoll,rotvoll_nedre). 
cmpl(hist,tekn,torget).  %%
cmpl(hist,t�h,�stre_berg).  %%
cmpl(hoeggen,kirke,sollia). 
cmpl(holtermanns,gate,holtermannsveien). 
cmpl(holtermanns,veg,holtermannsveien). 
cmpl(holtermanns,vei,holtermannsveien). 
cmpl(hospital,kirka,hospitalkirka).  %% NB hospital<> i rutedb 
cmpl(hospital,kirken,hospitalkirka). 
cmpl(hospitals,kirka,hospitalkirka). 
cmpl(hospitals,kirken,hospitalkirka). 
cmpl(hospitals,l�kkan,hospitalsl�kkan). 
cmpl(hospitalsl�kkan,kirke,hospitalkirka).

cmpl(royal,[garden,hotell],royal_garden).   %% Flybuss 
  cmpl(hotell,[royal,garden],royal_garden). 
  cmpl(hotel,[royal,garden],royal_garden).   

cmpl(hotell,[scandic,ved,moholt],esso_motorhotell). 
cmpl(hotell,augustin,'Hotell Augustin'). 

cmpl(hotell,britannia,britannia_hotell).  %% flybuss 
cmpl(hotell,britannia,britannia_hotell). 

%% cmpl(hotell,scandic,esso_motorhotell). 
cmpl(hourens,vei,henrik_ourens_vei). 
cmpl(husbys,vei,odd_husbys_street). 
cmpl(huseby,[videreg�ende,skole],saupstadsenteret). 
cmpl(huseby,bad,saupstadsenteret). 
cmpl(huseby,badet,saupstadsenteret). 
cmpl(huseby,hallen,husebyhallen). 
cmpl(huseby,skole,saupstadsenteret). 
cmpl(huseby,tunet,husebytunet). 
cmpl(huseby,videreg�ende,saupstadsenteret). 
cmpl(h�kon,['7',gate,25],haakon_vii_gate_25). 
cmpl(h�kon,[7,s,gate],haakon_vii_gt). 
cmpl(h�kon,[den,7,gate],haakon_viis_street).  %% <-- 
cmpl(h�rstad,skole,koieflata).  %% H�lbekkveien 62
cmpl(h�g,skoleringen,h�yskoleringen). 
cmpl(h�gskolen,[i,s�r,tr�ndelag],hist). 
cmpl(h�y,skoleringen,h�yskoleringen). 
cmpl(h�yems,[vei],hallfred_h�yems_vei). 
cmpl(h�yskole,ringen,h�yskoleringen). 
cmpl(h�yskolen,[i,s�rtr�ndelag],hist).      %%. . . p� lade|rotvoll
%%cmpl(idr,plassen,idrettsplassen).  %% I rutehefte

cmpl(idrettsparken,jakobsli,idrettsplassen).
cmpl(idrettsplassen,jakobsli,idrettsplassen).
cmpl(idr,plassen,idrettsplassen).  %% I rutehefte
cmpl(idrettsparken,jakobsli,idrettsplassen). 

cmpl(idretts,[senter],idrettssenter).  %% TA-101110 //nohelp

cmpl(idretts,[plass],idrettsplass).  %%  // nohelp
cmpl(idrettsbygget,[p�,dragvoll],dragvoll). 
cmpl(idrettsbygget,[p�,gl�shaugen],h�yskoleringen). 
cmpl(idrettsbygget,[ved,gl�shaugen],h�yskoleringen). 
cmpl(idrettsbygget,gl�shaugen,h�yskoleringen). 
cmpl(idrettsbygget,nth,h�yskoleringen). 
cmpl(idrettsplass,jakobsli,idrettsplassen). 
cmpl(idrettsplassen,[p�,ranheim],ranheim_idrettsplass). 

cmpl(ikea,[p�,leangen],ikea). 
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
cmpl(ingvald,ysterg�rdsvei,ingvald_ystgaards_street). 
cmpl(ingvald,ystg�rdsvei,ingvald_ystgaards_street). 
cmpl(inn,herredsveien,innherredsveien). 
cmpl(inner,city,hovedterminalen). %% TA-110106 E: innen ?
cmpl(innherreds,veg,innherredsveien). 
cmpl(innherreds,veien,innherredsveien). 
cmpl(iskrem,fabrikken,iskremfabrikken). 
cmpl(it,bygget,itbygget). 
cmpl(ivar,[lykkes,vei,1],melkekartongen). 
cmpl(ivar,[lykkesvei,1],melkekartongen). 

cmpl(j,[aaesvei],john_aaes_veg). 
cmpl(j,[aaes,gate],john_aaes_veg). 
cmpl(j,[aaes,v],john_aaes_veg). 
cmpl(j,[aaes,vei],john_aaes_veg). 
cmpl(j,[b,lysholmersv],j�rgen_b_lysholms_vei). 
cmpl(j,[b,lysholms,vei],j�rgen_b_lysholms_vei). 
cmpl(j,[b,lysholmsv],j�rgen_b_lysholms_vei). 
cmpl(j,[b,lysholms_vei],j�rgen_b_lysholms_vei). 
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
cmpl(j,tillersv,johan_tillers_vei).  %%N�ddef
cmpl(jakobsli,idrettsplass,idrettsplassen). 
cmpl(jakobsli,idrettsplassen,idrettsplassen). %% nec?

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



cmpl(jakobsli,�vre,jakobslivegen_�vre). 
cmpl(jakobsliveien,�vre,jakobslivegen_�vre). 
cmpl(jakobslivegen,�vre,jakobslivegen_�vre). 
cmpl(jakobslivn,�vre,jakobslivegen_�vre).  %% nec 

cmpl(jakobli,�vre,jakobslivegen_�vre). 
cmpl(jakobliveien,�vre,jakobslivegen_�vre). 
cmpl(jakoblivegen,�vre,jakobslivegen_�vre). 
cmpl(jakoblivn,�vre,jakobslivegen_�vre).  %% nec


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
cmpl(johan,[aaes,v],john_aaes_veg). 
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
cmpl(john,[aae,s,veg],john_aaes_veg). 
cmpl(john,[aae,s,veg],john_aaes_veg). 
cmpl(john,[aae,s,vei],john_aaes_veg).  %%(mapindex)
cmpl(john,[aaes,veg],john_aaes_veg). 
cmpl(john,[aaesv],john_aaes_veg).  %%(map)
cmpl(john,[aaesvei],john_aaes_veg). 
cmpl(john,[aas,v],john_aaes_veg). 
cmpl(john,[aas,veg],john_aaes_veg). 
cmpl(john,[aas,vei],john_aaes_veg). 
cmpl(john,[aasv],john_aaes_veg). 
cmpl(john,[aasveg],john_aaes_veg). 
cmpl(john,[aasvei],john_aaes_veg).  %%(mapindex)
cmpl(john,[p,kroglunds,veg], johan_p_kroglunds_veg). 
cmpl(john,[p,kroglundsvei], johan_p_kroglunds_veg). 
cmpl(john,[�es,vei],john_aaes_veg). 
cmpl(john,[�svei],john_aaes_veg). 
cmpl(john,aasensvei,john_aaes_veg). 
cmpl(johnssons,vei,karl_jonssons_veg). %% k_jonssons_vei -> karl_jonssons_vei 
cmpl(jon,[aaens,vei],john_aaes_veg). 
cmpl(jon,[aaes,vei],john_aaes_veg). 
cmpl(jon,[aaesgt],john_aaes_veg). 
cmpl(jon,[aas,vei],john_aaes_veg). 
cmpl(jonssons,vei,karl_jonssons_veg). 
cmpl(jonsvann,vei,jonsvanns_street).  %%problem
cmpl(jonsvanns,vei,jonsvanns_street). 
cmpl(jonsvanns,vei,jonsvannsveien). 
cmpl(jp,[kroglunds,veg], johan_p_kroglunds_veg). 
cmpl(jp,[kroglunds,vei], johan_p_kroglunds_veg). 
cmpl(jp,[kroglundsv], johan_p_kroglunds_veg). 
cmpl(jp,[kroglundsveg], johan_p_kroglunds_veg). 
cmpl(jp,[kroglundsvei], johan_p_kroglunds_veg). 
cmpl(j�rgen,[b,lysholmersvei],j�rgen_b_lysholms_vei).
cmpl(j�rgen,[lysholms,v],j�rgen_b_lysholms_vei). 
cmpl(j�rgen,[lysholms,veg],j�rgen_b_lysholms_street).  %%
cmpl(j�rgen,[lysholms,vei],j�rgen_b_lysholms_vei). 
cmpl(j�rgen,[lysholms_vei],j�rgen_b_lysholms_street).  %% Problem
cmpl(k,[jonsons,veg],karl_jonssons_veg). 
cmpl(k,[o,thorn�s,veg],k_o_thorn�s_vei). 
cmpl(k,[o,thorn�s_vei],k_o_thorn�s_vei). 
cmpl(k,[o,thorn�s_veieg],k_o_thorn�s_vei). 
cmpl(k,[v,t],kvt). 
cmpl(k,attem,kattem).  %% ?
cmpl(kalvskinnet,skole,prinsen_kinosenter).
cmpl(kaptein,roosen,kaptein_roosens_street). 
cmpl(kaptein,roosens,kaptein_roosens_street). 

cmpl(karinelund,studentby,strinda_kirke). %% Br�setv 149
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
cmpl(kattem,lund�sen,lund�sen_n). 
cmpl(kattem,s,kattemsenteret). 
cmpl(kattem,senter,kattemsenteret). 
cmpl(kattem,senteret,kattemsenteret). 
cmpl(kattem,skogen,kattemskogen).
cmpl(kattem,skole,kattemsenteret).  %%Ust�sen6
cmpl(kbs,[kj�pe,senter],kbs_senteret). 
cmpl(kbs,[leangen],kbs_senteret). 
cmpl(kbs,[p�,leangen],kbs_senteret). 
cmpl(kbs,kj�pesenter,kbs_senteret). 
cmpl(kbs,senter,kbs_senteret). 
cmpl(kbs,senteret,kbs_senteret). 
cmpl(kbs,sentret,kbs_senteret). 
cmpl(kiellands,gate,alexander_kiellands_street). 
cmpl(kino,[p�,nova],nova_kinosenter). 
cmpl(kino,nova,nova_kinosenter). 
cmpl(kinoene,[i,prinsengata],prinsen_kinosenter). 
cmpl(kinoene,[i,prinsengate],prinsen_kinosenter). 
cmpl(kinoene,[i,prinsens,gate],prinsen_kinosenter). 
cmpl(kinoene,[i,prinsensgate],prinsen_kinosenter). 
cmpl(kinosenteret,prinsen,prinsen_kinosenter). 
cmpl(kj�pe,[senter],kj�pesenter).  %%(KBS)kj�pesenter
cmpl(kl,bu,kl�bu).  %%kl'bu
cmpl(kl�bu,[ruta],kl�buruten). 
cmpl(kl�bu,[ruten],kl�buruten). 
cmpl(kl�bu,kommunesenter,kommunesenteret). 
cmpl(kl�bu,r�dhus,kommunesenteret). %% is it a station ? 
cmpl(kl�busentrum,[],kl�bu_sentrum). %% TA-101025
cmpl(kl�bu,sentrum,kl�bu_sentrum).%% AtB %% ? where 
cmpl(kl�bu,skysstasjon,kl�bu_skysstasjon). 
cmpl(ko,[thorn�s,veg],k_o_thorn�s_vei). 
cmpl(ko,thornesv,k_o_thorn�s_vei). 
cmpl(ko,thornsensvei,k_o_thorn�s_vei). 
cmpl(koie,flata,koieflata).  
cmpl(kolstad,['/',heimdal],kolstad).  %% names on bus 4
cmpl(kolstad,dalen,kolstaddalen). 
cmpl(kolstad,senter,torplassen). 
cmpl(kolstad,skole,saupstadsenteret). 
cmpl(kolstad,toppen,kolstadhaugen). 
cmpl(kolstad,tunet,kolstadtunet). 
cmpl(kong,[haakon,7,gt],haakon_vii_gt).  %%a. s. o. . . . 
cmpl(kong,[inge,s,gate],kong_inges_street). 
cmpl(kong,[inges,gate],kong_inges_street). 
cmpl(kong,ingesgate,kong_inges_street).  

cmpl(kong,[sverres,gate],sverres_street). 
cmpl(kong,[�isteins,gt],kong_�ysteins_veg). 
cmpl(kong,[�ysteins,gate],kong_�ysteins_veg). 
cmpl(kong,[�ysteins,gt],kong_�ysteins_veg). 
cmpl(kong,[�ysteins,veg],kong_�ysteins_veg). 
cmpl(kong�ysteins,v,kong_�ysteins_veg). 
cmpl(kong�ysteins,veg,kong_�ysteins_veg).  %%
cmpl(kong�ysteins,vei,kong_�ysteins_veg).  %%
cmpl(korsvika,alle,lade_kirke).    
% cmpl(kr,[himmel,farts,dag],ascension_day).  %% -> dictn
cmpl(kr,marka,kroppanmarka). 
cmpl(kr,sand,kristiansand). 
cmpl(kr,sund,kristiansund). 
cmpl(kretsfengselet,tunga,tunga_kretsfengsel). 
% cmpl(kristelig,[himmelfarts,dag],ascension_day).  %%-> dictn
% cmpl(kristelig,himmelfartsdag,ascension_day). %%-> dictn
cmpl(kristen,[videreg�ende,skole],kvt). 
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
cmpl(kvilhaugen,g�rd,kvilhaugen). 
cmpl(kvt,[city,syd],kvt). 
cmpl(kvt,vgs,kvt). 

cmpl(lade,[arena],haakon_vii_gate_9). 
cmpl(lade,80,lade_alle_80). 
%%%%%% cmpl(lade,[all,e],lade_alle_80). 
cmpl(lade,[jarlen,vgs],ladejarlen_v_g_s). 
cmpl(lade,[v,g,skole],lade_kirke). 
cmpl(lade,[vg,skole],lade_kirke). 
cmpl(lade,[videreg�ende],lade_kirke). 

%% cmpl(lade,alle,lade_alle_80).  %% By request from M. Erichsen,27. 2. 2002
cmpl(lade,alle,lade_alle). %% AtB      



cmpl(lade,alle80,lade_alle_80). %% AtB 
cmpl(lade,city,city_lade). 
cmpl(lade,senter,city_lade).
cmpl(lade,torg,city_lade). %% ? 
cmpl(lade,gaard,lade_g�rd). 
cmpl(lade,g�r,lade_g�rd).  
cmpl(lade,hammeren,ladehammeren). 
cmpl(lade,jarlen,ladejarlen_v_g_s). 
cmpl(lade,kapell,lade_kirke). 
cmpl(lade,ntnu,ntnu_lade). 
cmpl(lade,obs,city_lade). 
cmpl(lade,skole,lade_kirke). 
cmpl(lade,teknopark,stiklestadveien). 
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
cmpl(ladejarlen,[videreg�ende,skole],ladejarlen_v_g_s). 
cmpl(ladejarlen,[videreg�ende],ladejarlen_v_g_s). 
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
cmpl(leangen,postkontor,leangen_alle). %% AtB 
cmpl(leangen,sk�ytebane,bromstadsvingen). 
cmpl(leangen,stadion,bromstadsvingen). 
cmpl(leangen,travbane,travbanen). 
cmpl(leangen,travbanen,travbanen). 
cmpl(leif,[erickson,senter],pirbadet). 
cmpl(leif,[erikson,senter],pirbadet).
cmpl(leiftronstads,vei,leif_tronstads_street). 
cmpl(nedre,[leir,foss],nedre_leirfoss). 
cmpl(leira,fengsel,leira_skole).  %% Bratsbergveien 189
cmpl(leira,gartneri,leira_skole). 
cmpl(leirbrua,g�r,leirbrua_g�rd).
cmpl(leirnua,g�rd,leirbrua_g�rd). 

cmpl(leiv,[erikson,senter],pirbadet). 
cmpl(leiv,[erikson,senteret],pirbadet).

cmpl(lerchendal,gaard,lerchendal_g�rd). 
cmpl(lerchendal,stadion,lerkendal_stadion). 
cmpl(lerken,[dal,stadion],lerkendal_stadion). 
cmpl(lerken,dal,lerkendal_stadion). 
cmpl(lerkendal,gaard,lerchendal_g�rd). 
cmpl(lerkendal,g�r,lerchendal_g�rd). 
cmpl(lerkendal,g�rd,lerchendal_g�rd). 
cmpl(lerkendal,st,lerkendal_stadion). 
cmpl(lerkendal,stadium,lerkendal_stadion). 
cmpl(lerkendal,stasjon,lerkendal_stadion). 
cmpl(lerkendal,station,lerkendal_stadion).   %% staTion
%% cmpl(lerkendal,staton,lerkendal_stadion).    %% stasjon=TS %% TA-110406 names
cmpl(lerkendal,studentby,presteg�rsjordet).  %% (ikkeg�rds)
cmpl(lerkendals,veien,lerkendalsvegen). 
cmpl(lille,rydningen,lillerydningen). 
cmpl(lilleby,skole,'Lilleby skole').
cmpl(lillebyskole,[],'Lilleby skole').
 


cmpl(loholt,alle,loholt_alle). 
cmpl(louisenlyst,g�rd,louisenlyst). 
cmpl(luftkrigs,skolen,luftkrigsskolen). 
cmpl(lundamo,auto,harald_h�rfagres_gate). 
cmpl(lund�,sen,lund�sen_n).  %% ?

cmpl(lund�sen,[n],lund�sen_n). 
cmpl(lund�sen,[nedre],lund�sen_n). 
cmpl(lund�sen,[nord],lund�sen_n).  
cmpl(lund�sen,[nordre],lund�sen_n). 

cmpl(lykkens,portal,bybro). 
cmpl(lysholms,street,j�rgen_b_lysholms_vei). 
cmpl(l�rerh�gskolen,[p�,rotvoll],rotvoll_nedre). 
cmpl(l�rerskolen,[p�,rotvoll],rotvoll_nedre). 
cmpl(l�kken,verk,l�kken). 

cmpl(m,[0,holt],moholt). %% TA-100824   Tricky

cmpl(m,0,hovedterminalen). 
cmpl(m,[1],munkegata_m1). 
cmpl(m,[2],munkegata_m2). 
cmpl(m,[3],munkegata_m3). 
cmpl(m,[4],munkegata_m4). 
cmpl(m,[5],munkegata_m5). 
cmpl(m,[berrf�tts,vei],magnus_berrf�tts_veg). %% NB changed Hastus <- magnus_berf�ttsvei
cmpl(m,[gt],munkegata). 
cmpl(m,[kregnes,veg],martin_kregnes_veg). 
cmpl(m,berf�ttsvei,magnus_berrf�tts_veg). 
cmpl(m,thranesvei,marcus_thranes_vei).  %%N�ddef
cmpl(m,tranesgt,marcus_thranes_vei).  %%adhoc
cmpl(m,unkegt,munkegata). 
cmpl(magnus,[barfots,veg],magnus_berrf�tts_veg). 
cmpl(magnus,[berrfots,veg],magnus_berrf�tts_veg). 
cmpl(magnus,[berrf�tts,veg],magnus_berrf�tts_veg). 
cmpl(magnus,[blindes],magnus_blindes_vei). 
cmpl(magnus,[den,blinde],magnus_blindes_vei). 
cmpl(magnus,[den,blindes,gt],magnus_blindes_vei).  %%etc
cmpl(magnus,[den,blindes,vei],magnus_blindes_vei). 
cmpl(magnus,barfotsvei,magnus_berrf�tts_veg). 
cmpl(magnus,barf�tesveg,magnus_berrf�tts_veg). 
cmpl(magnus,berrf�ttsv,magnus_berrf�tts_veg). 
cmpl(magnus,b�rf�tsvei,magnus_berrf�tts_veg). 
cmpl(magnus,b�rf�ttsvei,magnus_berrf�tts_veg). 
cmpl(magnus,b�rrf�tsv,magnus_berrf�tts_veg). 
cmpl(magnus,b�rrf�tsvei,magnus_berrf�tts_veg). 
cmpl(magnus,b�rrf�ttsvei,magnus_berrf�tts_veg). 

cmpl(magnus,[godes,gate],magnus_den_godes_street). 

cmpl(magnusberrf�tts,vei,magnus_berrf�tts_veg). 
cmpl(main,station,hovedterminalen). 
cmpl(malvik,kommune,malvik). 
cmpl(marien,[borg],marienborg). 
cmpl(maries�rdals,veg,marie_s�rdals_veg). 
cmpl(marin,[teknisk,senter,tyholt],magnus_berrf�tts_veg). 
cmpl(marin,[teknisk,senter],magnus_berrf�tts_veg). 
cmpl(marintek,[],magnus_berrf�tts_veg). 
cmpl(marinteknisk,[senter,tyholt],magnus_berrf�tts_veg). 
cmpl(marinteknisk,senter,magnus_berrf�tts_veg). 
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
cmpl(migo,senteret,migosenteret).  %%Lazy
cmpl(mnk,gata,munkegata). 
cmpl(mnk,gate,munkegata). 
cmpl(mnk,gaten,munkegata). 
cmpl(mnk,gt,munkegata). 
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
cmpl(moholt,kj�pesenter,moholt_storsenter). 
cmpl(moholt,senter,moholt_storsenter). 
cmpl(moholt,senteret,moholt_storsenter). 
cmpl(moholt,storsenter,moholt_storsenter). 

cmpl(moholt,terasse,moholt). 
cmpl(moholt,tun,moholttun). 
cmpl(moholt,tunet,moholttun). 
cmpl(moholts,studentby,moholt_studentby). 
cmpl(moholtsenter,[],moholt_storsenter). 
cmpl(moholtstudent,by,moholt_studentby). 
cmpl(molte,myra,moltmyra). 
cmpl(motor,trade,'Motor Trade'). %% (Bil verksted) Nardo
cmpl(monsens,gt,chr_monsensgt). 
cmpl(morsets,vei,peder_morsets_vei). 
cmpl(munk,[voll,g�rd],munkvoll_g�rd). 
cmpl(munk,gt,munkegata). 
cmpl(munke,gata,munkegata).  %% Touchy
cmpl(munke,gate,munkegata). 
cmpl(munke,gaten,munkegata).  %% Street Sentrum-> m0
cmpl(munke,gt,munkegata). 
cmpl(munkega,ta,munkegata). 

cmpl(munkegata,[holdeplass,m1],munkegata_m1).
cmpl(munkegata,[holdeplass,m2],munkegata_m2). 
cmpl(munkegata,[holdeplass,m3],munkegata_m3). 
cmpl(munkegata,[holdeplass,m4],munkegata_m4).
cmpl(munkegata,[holdeplass,m4],munkegata_m4). 
cmpl(munkegata,[holdeplass,m5],munkegata_m5). 
cmpl(munkegata,[holdeplass,m,41],munkegata_m41).

cmpl(munkegata,[holdeplass,m,1],munkegata_m1). %% TA-101022 
cmpl(munkegata,[holdeplass,m,2],munkegata_m2). 
cmpl(munkegata,[holdeplass,m,3],munkegata_m3). 
cmpl(munkegata,[holdeplass,m,4],munkegata_m4). 
cmpl(munkegata,[holdeplass,m,5],munkegata_m5). 
cmpl(munkegata,[holdeplass,m,41],munkegata_m41). 

cmpl(munkegata,[m,1],munkegata_m1). 
cmpl(munkegata,[m,2],munkegata_m2). 
cmpl(munkegata,[m,3],munkegata_m3). 
cmpl(munkegata,[m,4],munkegata_m4). 
cmpl(munkegata,[m,5],munkegata_m5). 

cmpl(munkegata,[m1],munkegata_m1). 
cmpl(munkegata,[m2],munkegata_m2). 
cmpl(munkegata,[m3],munkegata_m3). 
cmpl(munkegata,[m4],munkegata_m4). 
cmpl(munkegata,[m5],munkegata_m5). 
cmpl(munkegatam,[1],munkegata_m1). 
cmpl(munkegatam,[2],munkegata_m2).
cmpl(munkegatam,[3],munkegata_m3).
cmpl(munkegatam,[4],munkegata_m4).
cmpl(munkegatam,[5],munkegata_m5).
cmpl(munkvoll,g�r,munkvoll_g�rd). 
cmpl(munkvoll,g�rd,munkvoll_g�rd). 
cmpl(munkvoll,sykehjem,migosenteret).  %% selsbakkveien 28
cmpl(music,[museum],ringve_museum). 
cmpl(musikk,[museum],ringve_museum). 
cmpl(m�llenberg,nedre,nedre_m�llenberg). 
cmpl(m�llenberg,�vre,sig_berg_alle). %% \+ sig bergs
cmpl(m�ller,[bil,as],m�ller_bil). 
%%%%% cmpl(m�ller,bil,gran�sveien).  %% haakon_vii_gate_25). 
cmpl(m�ller,bil,m�ller_bil). 
cmpl(m�ller,trondheim,m�ller_bil). 
cmpl(m�re,[og,romsdal],m�re_og_romsdal). 
cmpl(n,[elvehavn],nedre_elvehavn). 
cmpl(n,[ilevollen],nordre_ilevolden). 
cmpl(n,[t,h],gl�shaugen_syd). 
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

cmpl(nedre,[charlotten,lund],charlottenlund_nedre). 
cmpl(nedre,[charlotten,lund],charlottenlund_nedre). 
cmpl(nedre,[elve,havn],nedre_elvehavn). 
cmpl(nedre,[elvehavn],nedre_elvehavn). 
cmpl(nedre,[elvehavnen],nedre_elvehavn). 
cmpl(nedre,[jakobsli,veg],jakobsliveien_nedre). 
cmpl(nedre,[jakobsli,vei],jakobsliveien_nedre). 
cmpl(nedre,[lund�sen],lund�sen_n). 
cmpl(nedre,[m�llenberg,gate],nedre_m�llenberg_street). 
cmpl(nedre,[m�llenbergs,gate],nedre_m�llenberg_street). 
cmpl(nedre,[m�llenbergsgate],nedre_m�llenberg_street). 
cmpl(nedre,bakklandet,bakkegata). 
cmpl(nedre,by�sen,by�sen). 
cmpl(nedre,charlottenlund,charlottenlund_nedre). 
cmpl(nedre,chlund,charlottenlund_nedre). 
cmpl(nedre,elvehavn,nedre_elvehavn).
cmpl(nedre,flat�sen,s�ndre_flat�sen).  %% ?
cmpl(nedre,flat�ssenteret,flat�sen_senter). 
cmpl(nedre,hallset,nordre_halset).
cmpl(nedre,hallsetvei,nordre_hallset_street). 
cmpl(nedre,hoem,nordre_hoem). 
cmpl(nedre,jakobsli,jakobsliveien_nedre). 
cmpl(nedre,jakobsliv,jakobsliveien_nedre). 
cmpl(nedre,jakobsliveg,jakobsliveien_nedre). 
cmpl(nedre,jakobslivei,jakobsliveien_nedre). 
cmpl(nedre,jakobsliveien,jakobsliveien_nedre). 
cmpl(nedre,leirfossen,nedre_leirfoss). 
cmpl(nedre,m�llenberg,nedre_m�llenberg). 
cmpl(nedre,m�llenberggate,nedre_m�llenberg_street). 
cmpl(nedre,m�llenberggt,nedre_m�llenberg_street). 
cmpl(nedre,romolslia,romolslia_nedre). 
cmpl(nedre,rotvoll,rotvoll_nedre). 
cmpl(nedre,singsaker,jonsvannsveien).  
cmpl(nedre,sjettenhaugen,nedre_sjetnhaugan).  %%->streetafter5. 3. 07
cmpl(nedre,sjettnhaugen,nedre_sjetnhaugan).  %%
%% cmpl(nedre,tverreggen,tverregga).  %% nordre=Nordre 
cmpl(nedre,vik�sen,vik�sen_nedre). 
%% cmpl(new,york,new_york). %% TA-110603
cmpl(ngu,[p�,lade],n_g_u). 

cmpl(9,muser,'Ni muser').  %% trouble
cmpl(ni,muser,'Ni muser'). %%

cmpl(nidar,as,sjokoladefabrikken). 
cmpl(nidar,bergene,strindheim). 
cmpl(nidar,fabrikker,strindheim). 
cmpl(nidar,hallen,trondheim_spektrum). 
cmpl(nidar,sjokoladefabrikk,sjokoladefabrikken). 
cmpl(nidaros,cathedral,domkirken).  %% (prins. kinos. un�dvendig)
cmpl(nidaros,domen,domkirken).  
cmpl(nidaros,kirke,domkirken). 
cmpl(nidarvoll,sykeheim,nyg�rd). 
cmpl(nidarvoll,sykehjem,nyg�rd). 
cmpl(nidar�,hallen,trondheim_spektrum). 
cmpl(nidelv,[hallen],nidelvhallen). 
cmpl(nidelven,bru,nidelv_bru). 
cmpl(nidelven,skole,prinsen_kinosenter).
cmpl(niels,[abels,gt],abels_street). 

cmpl(nord,california,california). %% rough ad hoc
cmpl(nord,norge,nordnorge). 
cmpl(nord,odal,odalen).   %% rough 

cmpl(nordre,halset,nordre_halset).

cmpl(nordre,[hoem],nordre_hoem).  %% Tramstation
cmpl(nordre,[lund�sen],lund�sen_n). 
cmpl(nordre,gl�shaugen,gl�shaugen_nord). 
cmpl(nordre,hallset,nordre_halset).  %% \+ spellc to halset
cmpl(nordre,leirfoss,nedre_leirfoss).  %% is actually north
cmpl(nordslettevegen,[],nordslettveien). 
cmpl(nordslettvegen,[],nordslettveien). 
%% cmpl(nordslettveien,snuplass,nordslettv_snuplass).  %% OBS sperrer nordslett vegen

cmpl(norges,[teknisk,naturvitenskapelige,universitet],ntnu). 
cmpl(norges,[tekniske,h�gskole],nth). 
cmpl(norges,[tekniske,universitet],nth). 


cmpl(nova,kino,nova_kinosenter). 
cmpl(nov,kino,nova_kinosenter). 
cmpl(nov,kinosenter,nova_kinosenter). %% avoid november %% TA-101012
cmpl(noa,kino,nova_kinosenter). 
cmpl(noa,kinosenter,nova_kinosenter). 

cmpl(norske,meierier,norske_meierier). %% no longer station %% TA-110705

cmpl(kino,novasenter,nova_kinosenter).  %% :-) 

cmpl(nr1,[],gr�kallbanen). 
cmpl(nrk,[p�,tyholt],tyholtt�rnet). 
cmpl(nrk,tyholt,nrk). 
cmpl(nsb,gods,terminalen). 
cmpl(nth,[p�,gl�shaugen],gl�shaugen_syd). 
cmpl(nth,gl�shaugen,gl�shaugen_syd). 
cmpl(nth,nord,gl�shaugen_nord). 
cmpl(nth,s�r,gl�shaugen_syd). 
cmpl(ntnu,[at,gl�shaugen],gl�shaugen_syd). 
cmpl(ntnu,[at,lade],ntnu_lade). 
cmpl(ntnu,[at,lade],ntnu_lade). 
cmpl(ntnu,[gl�shaugen,nord],gl�shaugen_nord). 
cmpl(ntnu,[gl�shaugen,s�r],gl�shaugen_syd). 
cmpl(ntnu,[p�,dragvoll],dragvoll). 
cmpl(ntnu,[p�,gl�shaugen],gl�shaugen_syd). 
cmpl(ntnu,[p�,lade],ntnu_lade). 
cmpl(ntnu,[p�,lade],ntnu_lade). 
cmpl(ntnu,dragvoll,ntnu_dragvoll). 
cmpl(ntnu,gloeshaugen,gl�shaugen_nord). 
cmpl(ntnu,gl�shaug,gl�shaugen_nord). 
cmpl(ntnu,gl�shaugen,gl�shaugen_nord). 
cmpl(ntnu,lade,ntnu_lade). 
cmpl(ntnu,n,gl�shaugen_nord). 
cmpl(ntnu,nord,gl�shaugen_nord). 
cmpl(ntnu,s,gl�shaugen_syd). 
cmpl(ntnu,s�r,gl�shaugen_syd). 
cmpl(nyborg,skole,nyborg). 
cmpl(nyg,�rd,nyg�rd).  %%Nyg�rd
cmpl(nygards,street,olav_nygards_street).  %% Streets must be tagged as street
cmpl(nypvang,skole,leinstrand). 
cmpl(nyvei,bakken,nyveibakken). 
cmpl(n�ringsakademiet,trondheim,bakkegata). %% 

cmpl(o,[almos,v],o_j_aalmos_street). 
cmpl(o,[almos,vei],o_j_aalmos_street). 
cmpl(o,[engebr,alle],olav_engelbrektssons_alle). 
cmpl(o,[j,almaasvei],o_j_aalmos_street). 
cmpl(o,[nygards,street],olav_nygards_street). 
cmpl(o,[trygvassons,gt],olav_tryggvasons_gate). %% changed from olav_trygvassons_gt 
%% cmpl(obs,'!',city_lade). %% confuse %% TA-110116
cmpl(obs,['!',lade],city_lade). 
cmpl(obs,lade,city_lade).  %% TA-100914
cmpl(obs,[p�,city,syd],city_syd). 
cmpl(obs,[p�,lade],city_lade).  %% (should avoid obs (and) on lade!)
cmpl(obs,[ved,lade],city_lade). 
cmpl(odense,vegen,odenseveien). 
cmpl(okstad,plassen,okstadplassen).  %% street
cmpl(okstad,skole,okstad).  %% Okstadvegen 6 = Okstad
cmpl(okstad,�stre,okstad_�stre). 

cmpl(okstad,�,okstad_�stre).  %% TA-110125 NB

cmpl(ola,[seterums,vei],ola_setroms_vei). 
cmpl(ola,[setroms,veg],ola_setroms_vei). 
cmpl(ola,[setroms,veg],ola_setroms_vei). 
cmpl(ola,[setrums,veg],ola_setroms_vei). 
cmpl(ola,[setrums,vei],ola_setroms_vei). 
cmpl(ola,[s�tres,veg],ola_setroms_vei). 
cmpl(ola,[s�tres,veg],ola_setroms_vei). 
cmpl(ola,[s�trums,veg],ola_setroms_vei).  %% (disc>1)
cmpl(ola,setrumsv,ola_setroms_vei). 
cmpl(olaf,[tryggvassonsgate],olav_tryggvasons_gate).  %% local mis

cmpl(olafbulls,veg,olaf_bulls_vei).
cmpl(olav,[bulls,v],olaf_bulls_vei).    %% (ErroronMap)
cmpl(olav,[bulls,vei],olaf_bulls_vei).  %% (ErroronMap)
cmpl(olav,[engel,brektssons,alle],olav_engelbrektssons_alle). 
cmpl(olav,[engelbregtsens,alle],olav_engelbrektssons_alle). 
cmpl(olav,[engelbregtsons,alle],olav_engelbrektssons_alle). 
cmpl(olav,[engelbrektsons,alle],olav_engelbrektssons_alle). 

cmpl(olav,[engelbrektsons,gate],olav_engelbrektssons_alle). 
/*
cmpl(olav,[engelbrektssons,gate],olav_engelbrektssons_alle).  %% Problem spot
cmpl(olav,[engelbrektssons,v],   olav_engelbrektssons_alle).  %% Problem spot
cmpl(olav,[engelbrektssons,veg],olav_engelbrektssons_alle). 
cmpl(olav,[engelbrektssons,vei],olav_engelbrektssons_alle). 
*/

cmpl(olav,[engelbretssons,alle],olav_engelbrektssons_alle). 
cmpl(olav,[tryggvas,onsgate],olav_tryggvasons_gate). 
cmpl(olav,[tryggvasons,gate],olav_tryggvasons_gate). 
cmpl(olav,engebrektsgate,olav_engelbrektssons_alle). 
cmpl(olav,engelbregtsalle,olav_engelbrektssons_alle). 
cmpl(olav,engelbrektssonsgate,olav_engelbrektssons_alle). 
cmpl(olav,kyrres,olav_kyrres_street). 
cmpl(olav,nygaardsvei,olav_nyg�rds_vei). 
cmpl(olav,nyg�rd,olav_nyg�rds_vei).
cmpl(olav,[t,gate],olav_tryggvasons_gate). 
cmpl(olav,tryggvasons,olav_tryggvasons_gate). 
cmpl(olav,tryggvasonsgt,olav_tryggvasons_gate). 
cmpl(olav,trygvasonsgate,olav_tryggvasons_gate). 
cmpl(olav,trygvasonsgt,olav_tryggvasons_gate). 
cmpl(olavengelbreksons,alle,olav_engelbrektssons_alle). 
cmpl(olavnyg�rds,vei,olav_nyg�rds_vei).
%% cmpl(olavs,gate,st_olavs_gate).  %% //confuse //irrelevant street
cmpl(olavs,gt,st_olavs_gate).    %%
cmpl(olavs,kvartalet,olavskvartalet). 
cmpl(olavs,hospital,st_olavs_hospital). 
cmpl(olavtryggvasons,gate,olav_tryggvasons_gate). 



cmpl(olavtrygvasonsgate,[],olav_tryggvasons_gate). 

cmpl(olavtryggvasons,gt,olav_tryggvasons_gate). 
cmpl(older,dalen,olderdalen).  
cmpl(olderdalen,ranheim,olderdalen). 
%%%% cmpl(ole,[aasveds,veg],ole_aasveds_street).  %% Ad Hoc (Ny veg,ikke nr)
cmpl(ole,[engelbrektssons,alle],olav_engelbrektssons_alle). 
cmpl(ole,bullsve,ole_bulls_street). 
cmpl(ole,nordg�rdsvei,ole_nordgaards_street). 
cmpl(ole,ross,ole_ross_veg). 
cmpl(ole,rossvei,ole_ross_veg). 
cmpl(omkj�ringsveien,[ved,moholt],omkj�ringsveien_moholt). 
cmpl(omkj�ringsveien,[ved,nardo],omkj�ringsveien_nardo). 
cmpl(omkj�ringsveien,kl�buveien,omkj�ringsv_kl�buvveien). 
cmpl(omkj�ringsveien,moholt,omkj�ringsveien_moholt). 
cmpl(omkj�ringsveien,nardo,omkj�ringsveien_nardo). 
cmpl(omkj�ringsveien,nardokrysset,omkj�ringsveien_nardo). 
cmpl(oops,lade,city_lade).  %%
cmpl(ops,lade,city_lade).  %%nec?
cmpl(orkdalsbussen,[],hob). 
cmpl(oskar,br�tensvei,oskar_braatens_street). 
cmpl(oslo,bussterminal,oslo). 
cmpl(oslo,s,oslo). 
cmpl(oslo,sentralbanestasjon,oslo).
%% cmpl(ostersund,sweden,�stersund). 
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
cmpl(ovre,flataasveien,�vre_flat�sveg). 
cmpl(owesens,gate,thonning_owesens_street).  %% $Generic
cmpl(p,kroghsv,peder_kroghs_v). 
cmpl(p,[morsets,vei],peder_morsets_veg). %% peder_morsetts_v %% (SIC) HASTUS 
cmpl(p,morsetsv,peder_morsets_veg). 
cmpl(p,[skole,mesters,vei],paul_skolemesters_veg). 
cmpl(p,[skolemesters,vei],paul_skolemesters_veg). 
cmpl(p,skolemestersv,paul_skolemesters_veg). 
cmpl(panorama,[quality,hotel],melkekartongen). 
cmpl(papirfabrikken,[p�,ranheim],ranheim_fabrikker).
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
cmpl(persaune,veien,persauneveien).   %% TA-110415
cmpl(persaunet,leier,persaunet_leir). %% TA-110615
cmpl(persaunet,leir,persaunet_leir).  %% SIC(errorinreghpl)
cmpl(persaunet,sykehjem,gina_krogs_veg).  %% persaunvn54->
cmpl(pinsen,kino,prinsen_kinosenter). 
cmpl(pinsen,kinos,prinsen_kinosenter). 
cmpl(pinsen,kinosenter,prinsen_kinosenter). 
cmpl(pinsens,kinosenter,prinsen_kinosenter). 

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
cmpl(posten,[p�,sluppen],postterminalen). 
cmpl(posten,sluppen,postterminalen). 
cmpl(pr,[brochs,gate],prof_brochs_gate). 
cmpl(presteg,jordet,presteg�rsjordet). 
cmpl(presteg�rds,jordet,presteg�rsjordet). 



cmpl(prinsen,[gate],prinsens_gate). 
cmpl(prinsen,hotell,prinsenkrysset). 
cmpl(prinsen,[kino,renter],prinsen_kinosenter). 
cmpl(prinsen,[kino,senter],prinsen_kinosenter). 
%% cmpl(prinsen,cinema,prinsen_kinosenter). %%  confuse
cmpl(prinsen,gt,prinsens_gate). 
cmpl(prinsen,kino,prinsen_kinosenter). 
cmpl(prinsen,kino,prinsen_kinosenter). 
cmpl(prinsen,kinos,prinsen_kinosenter). 
cmpl(prinsen,kryss,prinsenkrysset). 
cmpl(prinsen,krysset,prinsenkrysset). 
cmpl(prinsenkino,senter,prinsen_kinosenter). 
cmpl(prinsen,teater,prinsen_kinosenter). 



% cmpl(prinsens,[gata],prinsens_gate).  
% cmpl(prinsens,[gate],prinsens_gate). 
% cmpl(prinsens,[gt],prinsens_gate). 

cmpl(prinsens,[kinosenter],prinsen_kinosenter). 
cmpl(prinsens,gt,prinsen_kinosenter). 
cmpl(prinsens,kino,prinsen_kinosenter).  %%NOSPELL!
cmpl(prisen,kino,prinsen_kinosenter). 
cmpl(prisen,kinosenter,prinsen_kinosenter). 
cmpl(prof,['. '],professor).  %%?Doesnthelp
cmpl(prof,[b,gt],prof_brochs_gate). 
cmpl(prof,[br,gate],prof_brochs_gate). 
cmpl(prof,[broch,gate],prof_brochs_gate). 
cmpl(prof,[broch,gt],prof_brochs_gate). 
cmpl(prof,[broch,s,gate],prof_brochs_gate). 
cmpl(prof,[brochs,g],prof_brochs_gate). 
cmpl(prof,[brochs,gata],prof_brochs_gate). 
cmpl(prof,[brochs,gate],prof_brochs_gate). 
cmpl(prof,[brochs,gt],prof_brochs_gate). 
cmpl(prof,[brochs,v],prof_brochs_gate). 
cmpl(prof,[brochs,vei],prof_brochs_gate). 
cmpl(prof,[brox,gate],prof_brochs_gate). 
cmpl(prof,[brox,s,gate],prof_brochs_gate). 
cmpl(prof,[broxs,gate],prof_brochs_gate). 
cmpl(prof,broch,prof_brochs_gate). 
cmpl(prof,brochs,prof_brochs_gate). 
cmpl(prof,brochsgate,prof_brochs_gate). 
cmpl(prof,brochsgt,prof_brochs_gate). 
cmpl(prof,brochsv,prof_brochs_gate). 
cmpl(prof,brochsvei,prof_brochs_gate). 
cmpl(prof,brocksgate,prof_brochs_gate). 
cmpl(prof,brocksgt,prof_brochs_gate). 
cmpl(prof,brocksv,prof_brochs_gate). 
cmpl(prof,prochsgate,prof_brochs_gate).  %% Contag
cmpl(profbrochs,gate,prof_brochs_gate). 

cmpl(professor,[b,gate],prof_brochs_gate). 
cmpl(professor,[br,gate],prof_brochs_gate). 
cmpl(professor,[broch,gate],prof_brochs_gate). 
cmpl(professor,[broch,gt],prof_brochs_gate). 
cmpl(professor,[broch,s,gate],prof_brochs_gate). 
cmpl(professor,[broch],prof_brochs_gate).  %% Ekstraservice
cmpl(professor,[brochs,gt],prof_brochs_gate). 
cmpl(professor,[brochs,v],prof_brochs_gate). 
cmpl(professor,[brochs,vei],prof_brochs_gate). 
cmpl(professor,[brochs],prof_brochs_gate).  %% Confuses lex
cmpl(professor,brock,prof_brochs_gate). 
cmpl(professor,[brocks,gate],prof_brochs_gate). 
cmpl(professor,[brocksgt],prof_brochs_gate).  %% Confuses lex
cmpl(professor,[brocksv],prof_brochs_gate). 
cmpl(professor,[brogsgate],prof_brochs_gate).  %% (bergsgate#)
cmpl(professor,[brox,gate],prof_brochs_gate). 
cmpl(professor,[brox,gt],prof_brochs_gate). 
cmpl(professor,[brox,s,gate],prof_brochs_gate). 
cmpl(professor,[broxs,gate],prof_brochs_gate). 
cmpl(professor,[j,h,vogts,vei],professor_j_h_l_vogts_street). 
cmpl(professor,brochsgate,prof_brochs_gate). 
cmpl(professor,brochsgt,prof_brochs_gate). 
cmpl(professor,brochsveg,prof_brochs_gate). 
cmpl(professor,brochsvei,prof_brochs_gate). 
cmpl(professor,brocksgate,prof_brochs_gate). 
cmpl(professor,brocksgate,prof_brochs_gate). 
cmpl(professor,brocksvei,prof_brochs_gate). 
cmpl(professorbrochs,gate,prof_brochs_gate). 
cmpl(professorbrochs,gt,prof_brochs_gate). 

/* %% TA-110314
cmpl(proffessor,[brochs,gate],prof_brochs_gate).  %%Just for fun
cmpl(proffessor,[brochs,gt],prof_brochs_gate). 
cmpl(proffessor,[brochs,vei],prof_brochs_gate). 
cmpl(proffessor,[brocks,gate],prof_brochs_gate). 
cmpl(proffessor,[brox,gate],prof_brochs_gate). 
cmpl(proffessor,brochsgate,prof_brochs_gate). 
cmpl(proffessor,brochsgt,prof_brochs_gate). 
*/

cmpl(pr�ven,[bil],kroppan). %% TA-110520 ?

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
cmpl(reppe,['/',vik�sen],reppevegen). 
cmpl(reppe,[vei,kryss],reppevegen). 
cmpl(reppe,endeholdeplass,reppe). 
cmpl(reppe,vegkryss,reppevegen).  %%Discrepancy in Routeguide
cmpl(reppe,veikryss,reppevegen).  %%redundant after rehash
cmpl(reppe,vik�sen,reppevegen).   %%ambiguous on purpose
%%%%  cmpl(ringte,skole,ringve).  %% TA-110502
cmpl(ringve,[botaniske,hage],ringve_museum). 
cmpl(ringve,[g�rd],ringve_museum). 
cmpl(ringve,[v,g,s],ringve_skole). 
cmpl(ringve,[v,g],ringve_skole). 
cmpl(ringve,[vg,skole],ringve_skole). 
cmpl(ringve,[videreg�ende,skole],ringve_skole). 
cmpl(ringve,[videreg�ende],ringve_skole). 
cmpl(ringve,bugt,ringve_museum).  %% Da
cmpl(ringve,bukt,ringve_museum). 
cmpl(ringve,bukta,ringve_museum).  
cmpl(ringve,bukten,ringve_museum). 
cmpl(ringve,gymnas,ringve_skole). 
cmpl(ringve,[musikk,museum],ringve_museum). 
cmpl(ringve,musikkmuseum,ringve_museum).
cmpl(ringvebukten,[],ringve_museum). 
cmpl(ringvoll,skole,ringve_skole).  %% (obs. iHob�l)
cmpl(risvollan,senteret,risvollan_senter). 
cmpl(rit,adm,adm_rit). %
cmpl(rit,hovedport,st_olavs_hospital). 
cmpl(rit,hovedporten,st_olavs_hospital). 
cmpl(romols,lia,romolslia). 
cmpl(romolslia,skole,sk�rgangen).  %% romulslia is correct
cmpl(romolslia,�vre,romolslia_�vre). 
cmpl(romuls,lia,romolslia). 
cmpl(romulslia,skole,sk�rgangen).  %% tamburhaugen 1
cmpl(rosen,dal,rosendal). 

cmpl(rosenborg,park,rosenborg_skole). 
cmpl(rosenborg,stadion,lerkendal_stadion). 
cmpl(rosenborg,stadium,lerkendal_stadion).  %% (f o r e i g n e r s)
cmpl(rosenborg,ungdomsskole,rosenborg_skole).
cmpl(rosendal,kino,rosendal). 
cmpl(rosendal,skole,rosenborg_skole). %% ?
cmpl(rosendal,teater,rosendal). 
cmpl(rosten,[videreg�ende,skole],tonstadgrenda).
cmpl(rosten,grenda,rostengrenda). 
cmpl(rosten,hallen,rostenhallen). 
cmpl(rosten,skole,tonstadgrenda). 
cmpl(rot,voll,rotvoll). 
cmpl(rotvoll,[alt],statoil_rotvoll). %% ALT %% TA-110627
cmpl(rotvoll,[statoil],statoil_rotvoll).  %% TA-110627
cmpl(rotvoll,n,rotvoll_nedre). 
cmpl(royal,[garden,hotel],royal_garden). 
cmpl(royal,[garden,hotell],royal_garden). 
cmpl(royal,garden,royal_garden). 
cmpl(rundkj�ringen,[nardo],omkj�ringsveien_nardo). 
cmpl(rundkj�ringen,[p�,nardo],omkj�ringsveien_nardo). 
cmpl(rutebil,[stasjonen],rutebilstasjonen).  %%??
cmpl(r�nnings,bakken,r�nningsbakken). 
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
cmpl(samf,1,studentersamfundet_1).   %% nb split name
cmpl(samf,2,studentersamfundet_2). 
cmpl(samfun,[det],studentersamfundet). 
cmpl(samfundet,1,studentersamfundet_1). 
cmpl(samfundet,2,studentersamfundet_2). 
cmpl(samfundet,[1],studentersamfundet_1). 
cmpl(samfundet,[2],studentersamfundet_2). 
cmpl(samfundet,[l],studentersamfundet_1).  %% L
cmpl(samfunnet,[1],studentersamfundet_1).  %% AVOID 1300
cmpl(samfunnet,[2],studentersamfundet_2).  %% AVOID 1400
cmpl(samfunnet,[l],studentersamfundet_1).  %%
cmpl(sandmoen,[camping],sandmoen). 

cmpl(st,['.',o,'.',hospital],st_olavs_hospital). 


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
cmpl(sentrum,kino,nova_kinosenter). 
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
cmpl(sig,[bergs,alle],sig_berg_alle).  %% \+ sig bergs
cmpl(sigrid,[bergs,alle],sig_berg_alle). 
cmpl(sigrun,[bergs,alle],sig_berg_alle).  %% Sigrun ???
cmpl(sigurd,[bergs,all],sig_berg_alle).   %% Makter ikke
cmpl(sigurd,[bergs,alle],sig_berg_alle).  %% Sigrun ???
cmpl(sigurd,[bergs,gate],sig_berg_alle). 
cmpl(sigurd,bergsgate,sig_berg_alle).  
cmpl(sigurd,[bergsted,alle],sig_berg_alle). 
cmpl(sigurd,bergsalle,sig_berg_alle). 
cmpl(sigurdbergs,alle,sig_berg_alle).  
cmpl(sigurds,[berg,alle],sig_berg_alle). 

%% trouble spot
cmpl(sigurd,biskopsgate,biskop_sigurds_gate). %% etc :-)
cmpl(sigurd,[biskops,gate],biskop_sigurds_gate). 
cmpl(sigurd,[biskops,street],biskop_sigurds_gate). %% TA-110411
cmpl(sigurd,[biskop,street],biskop_sigurds_gate).  %%

cmpl(sigurds,gate,biskop_sigurds_gate). 
cmpl(sigurds,gt,biskop_sigurds_gate). 



cmpl(singsaker,skole,jonsvannsveien). 
cmpl(singsaker,sommerhotell,singsaker_studenthjem). 
cmpl(singsaker,studenterhjem,singsaker_studenthjem). 
cmpl(singsaker,studenthjem,singsaker_studenthjem). 
cmpl(singsaker,studenthotell,singsaker_studenthjem). 
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

cmpl(sivilforsvaret,[gran�sen],gran�sen_vm_anlegget).     %% etc 
cmpl(sivilforsvaret,[p�,gran�sen],gran�sen_vm_anlegget). 
cmpl(sivilforsvaret,[ved,gran�sen],gran�sen_vm_anlegget).

cmpl(sj,marka,sjetnmarka).  %%xservice
cmpl(sjetne,marka,sjetnmarka). 
cmpl(sjetne,skole,carl_schjetnans_veg). 
cmpl(sjetnemarka,skole,carl_schjetnans_veg).  %% no spell
cmpl(sjetnmarka,skole,carl_schjetnans_veg).  
cmpl(skavlands,veg,skavlans_veg). 
cmpl(skavlans,veg,skavlans_veg). 
cmpl(ski,stua,skistua). 
cmpl(skippy,senteret,fossegrenda).  %% schr�der
cmpl(skipsmodelltanken,tyholt,skipsmodelltanken).  %% (?)
cmpl(skjetlein,[v,g,skole],leinstrand). 
cmpl(skjetlein,[videreg�ende,skole],leinstrand). 
cmpl(skjetlein,skole,leinstrand). 
cmpl(skjetne,skole,carl_schjetnans_veg). 
cmpl(skjetnemarka,skole,carl_schjetnans_veg). 
cmpl(skj�ness,vei,ivar_skj�ness_vei). %% st
cmpl(skole,mesters,paul_skolemesters_veg).  %%AD HOC mesters
cmpl(skolemesters,vei,paul_skolemesters_veg). 
cmpl(skov,g�rd,skovg�rd). 
cmpl(sluppen,brua,sluppen_bru). 
cmpl(sluppen,postkontor,postterminalen). 
cmpl(sluppen,postsenter,postterminalen). 
cmpl(sluppen,postsentral,postterminalen). 
cmpl(sluppen,postterminal,postterminalen). 

cmpl(smistads,street,arnt_smistads_vei).  %% NB Street
cmpl(sol,siden,solsiden). 
cmpl(solsiden,dokkparken,solsiden).  
cmpl(solsiden,kj�pesenter,solsiden). 
cmpl(solsiden,senteret,solsiden). 
cmpl(sonans,privatgymnas,nova_kinosenter). 
cmpl(sonans,skole,nova_kinosenter). %% ? 
cmpl(sorte,[lade,moen],svartlamon). 
cmpl(sosial,h�gskolen,gildheim).  %%??
cmpl(sp,[andersens,vei],s_p_andersens_street). 
cmpl(sp,[andersensv],s_p_andersens_street). 
cmpl(sp,[andersensvei],s_p_andersens_street). 
cmpl(spongdal,skole,spongdal). 

cmpl(st,[0,lavs,gt],st_olavs_gate).  %% null
cmpl(st,[olav,s],st_olavs_hospital). 

cmpl(st,[elisabeth],ila).
cmpl(st,[elisabeth,hospital,ila],ila). 
cmpl(st,[elisabeth,hospital],ila). 
cmpl(st,[elisabeths,hospital],ila). 

cmpl(st,[ing,dahls,gate],sig_berg_alle). %% \+ sig bergs
cmpl(st,[ing,dahls,gt],sig_berg_alle). 
cmpl(st,[ing,dahlsgate],sig_berg_alle). 

cmpl(st,[olav,s,hospital],st_olavs_hospital). 
cmpl(st,[olav],st_olavs_hospital). 
cmpl(st,[olavs,gate],st_olavs_gate). 
cmpl(st,[olavs,gt],st_olavs_gate). 
cmpl(st,[olavs,h],st_olavs_hospital). 
cmpl(st,[olavs,hospital,vest],st_olavs_hospital_vest). 
cmpl(st,[olavs,hospital,�st],st_olavs_hospital). 
cmpl(st,[olavs,hospital],st_olavs_hospital). 
cmpl(st,[olavs,plass],st_olavs_gate). 
cmpl(st,[olavshospital],st_olavs_hospital). 
cmpl(st,elisabeth,ila).  %% ad hoc, make elisabeth known before hash
cmpl(st,elisabeths,ila). 
cmpl(st,hospital,st_olavs_hospital). 
cmpl(st,olav,st_olavs_hospital). 
cmpl(st,olavsgate,st_olavs_gate). 
cmpl(st,olavsgaten,st_olavs_gate). 
cmpl(st,olavsgt,st_olavs_gate). 
cmpl(st,olavsplass,st_olavs_gate). 
cmpl(st,olavssykehus,st_olavs_hospital). 
cmpl(st,olovhospital,st_olavs_hospital). 
cmpl(st,samf,studentersamfunnet). 
cmpl(stabbursmoen,skole,ditlev_bloms_veg).

cmpl(stads,[ing,dahls,gt],sig_berg_alle).  %% ++ sig_bergs
cmpl(stads,[ingeni�r,dahls,gate],sig_berg_alle). 
cmpl(stads,[ingeni�r,dahls,gt],sig_berg_alle). 

cmpl(stadsing,[dahls,alle],sig_berg_alle). %% TA-110530

cmpl(stadsing,[dahls,gt],sig_berg_alle).  
cmpl(stadsingdal,gate,sig_berg_alle).  
cmpl(stadsingdals,gate,sig_berg_alle). 
cmpl(stadsingeni�r,[dahls,gate],sig_berg_alle). 
cmpl(stadsingeni�r,[dahls,gate],sig_berg_alle).  %% \+ street,avoid rosendal
cmpl(stadsingeni�r,[dahls,gt],sig_berg_alle). 
cmpl(stadsingeni�r,[dahls,vei],sig_berg_alle). 
cmpl(stadsingeni�r,[dahlsgate],sig_berg_alle). 
cmpl(stadsingeni�r,[dahlsgt],sig_berg_alle). 
cmpl(stat,[ingeni�r,dahls,gate],sig_berg_alle). 

cmpl(stads,[ing,dahls,gate],stadsing_dahls_street).  %% Stads. ing. dahls gate  .
cmpl(stadsingdahlsgate,[],stadsing_dahls_street). 
cmpl(stadsing,[dahls,gate],stadsing_dahls_street). 
cmpl(stadsingeni�rs,gate,stadsing_dahls_street). 
cmpl(stat,[ing,dahl,gate],stadsing_dahls_street). 

cmpl(statens,hus,statens_hus). 
cmpl(statens,vegvesen,postterminalen). 
cmpl(stating,dahlsgt,sig_berg_alle). 
cmpl(statoil,[bygget],statoil_rotvoll). 
cmpl(statoil,[forskningssenter,p�,rotvoll],statoil_rotvoll). 
cmpl(statoil,[p�,lade],statoil_rotvoll). 

   cmpl(statoil,[p�,rotvoll],statoil_rotvoll). %% rotvoll).

cmpl(statoil,[research,center],statoil_rotvoll). 
cmpl(statoil,forskningssenter,statoil_rotvoll). 
%% cmpl(statoil,research,statoil_rotvoll).  %% trick to make research visible
cmpl(statoil,researchcenter,statoil_rotvoll). 
cmpl(statoil,rotvoll,rotvoll). 
cmpl(statoils,forskningssenter,statoil_rotvoll). 

cmpl(stats,ingeni�rsgate,sig_berg_alle). 
cmpl(stats,[ingen�rdals,gate],sig_berg_alle). 
cmpl(statsingdal,gate,sig_berg_alle). 
cmpl(statsingeni�r,[dahls,gt],sig_berg_alle). 
cmpl(statsingeni�rs,[gt],sig_berg_alle). 
cmpl(stav,gjesteg�rd,stav). 
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
cmpl(steinan,[veien,14],hegdalen). 

cmpl(steinan,[student,village],'Steinan studentby'). 

cmpl(steinan,studentby,'Steinan studentby'). 
%% cmpl(steinan,studentbyen,vestlia). %% destroys 'Steinan studentby'
cmpl(steinan,vestlia,vestlia). 
cmpl(steinanv,14,hegdalen). 
cmpl(steinanveien,14,steinanveien). 
cmpl(steindal,skole,hoeggen_skole). 
cmpl(steindalskole,[],hoeggen_skole).  %% TA-110121

cmpl(steinerskolen,[i,ila],skansen). 
cmpl(steinerskolen,[i,ila],skansen). 
cmpl(steinerskolen,[i,trondheim],prof_brochs_gate). 
cmpl(steinerskolen,[p�,ila],skansen). %%
cmpl(steinerskolen,[p�,rotvoll],rotvoll). 

cmpl(steintr�veien,endeholdeplass,steintr�veien). 
cmpl(stj�rdal,sentrum,stj�rdal). 
cmpl(stokkan,haugen,stokkanhaugen).
cmpl(stolavs,[hospital],st_olavs_hospital).  %%
cmpl(stolavs,gt,st_olavs_gate). 
cmpl(stor,['-',rosta],stor_rosta). 
cmpl(stor,['-',rosten],stor_rosta). 
cmpl(stor,rosta,stor_rosta). 
cmpl(stor,rosten,stor_rosta). 
cmpl(stps,br�set,br�setflata). 
cmpl(str,heim,strindheim).  %% Dots are skipped after names
cmpl(strandvei,kai,strandveikaia).
cmpl(strandveien,[auto],strandveien).  %% Bilverksted
cmpl(strandveien,auto,strandveien). 

cmpl(strinda,[skole],magnus_blindes_veg). %% TA-110708

cmpl(strinda,[vg,skole],valentinlystveien). 
cmpl(strinda,[videreg�ende,skole],valentinlystveien). 
cmpl(strinda,skole,valentinlystveien). 
cmpl(strinda,videreg�ende,valentinlystveien). 
cmpl(strinda,vgs,valentinlystveien). 

cmpl(strindheim,[hage,by],strindheim_hageby). 
cmpl(strindheim,[kbs],strindheim). 
cmpl(strindheim,[kbss,enteret],strindheim). 
cmpl(strindheim,kirke,valentinlyst).  %%  ?
cmpl(strindheim,bil,j�rgen_b_lysholms_vei).  %% lade alle 67a.  
cmpl(stud,[samf,1],studentersamfundet_1). 
cmpl(stud,[samf,2],studentersamfundet_2). 
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
cmpl(studentbyen,[p�,berg],berg_studentby). 
cmpl(studentbyen,[p�,moholt],moholt_studentby). 
cmpl(studentbyen,[p�,steinan],vestlia). 
cmpl(studentbyen,[p�,voll],voll_studentby). 
cmpl(studentbyen,berg,berg_studentby). 
cmpl(studentbyen,lerkendal,presteg�rsjordet).  %%(ikkeg�rds)
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
cmpl(sverresborg,[folke,museum],tr�ndelag_folkemuseum). 
cmpl(sverresborg,[folkemuseum],tr�ndelag_folkemuseum). 
cmpl(sverresborg,folkemuseum,tr�ndelag_folkemuseum). 
cmpl(sverresborg,museum,tr�ndelag_folkemuseum).  
cmpl(sverresborg,skole,framveien).  %%?????????????
cmpl(sverresborgmuseum,[],tr�ndelag_folkemuseum). 

cmpl(sykehuset,[st,olav],st_olavs_hospital). %% etc
cmpl(st,[olav,sykehuset],st_olavs_hospital). 

cmpl(sykepleier,h�gskolen,st_olavs_hospital). 
cmpl(sykepleier,skolen,st_olavs_hospital).  %%hvor???
cmpl(s�ter,bakken,s�terbakken).  

cmpl(s�ndregate,[22],s�ndre_gate_22). %% Problem %% TA-110526
cmpl(s�ndregate,[23],s�ndre_gate_23). %%

cmpl(s�ndre,[gate,22],s�ndre_gate_22). 
cmpl(s�ndre,[gate,23],s�ndre_gate_23). 
cmpl(s�ndre,[gt,22],s�ndre_gate_22). 
cmpl(s�ndre,[gt,23],s�ndre_gate_23). 
cmpl(s�ndre,hoem,s�ndre_hoem).  %%
cmpl(s�ndre,gate,s�ndregate). 
cmpl(s�ndre,gl�shaugen,gl�shaugen_syd).  %% (sydlige?)
cmpl(s�ndre,gt,s�ndregate). 
cmpl(s�ndre,hallset,s�ndre_halset).  %% \+ spellc to halset
cmpl(s�ndre,hoem,s�ndre_hoem). 
cmpl(s�ndre,hoem,s�ndre_hoem).  %% Tramstation

cmpl(s�ndregt,[],s�ndregate).   %% NB then neighbourhood 22/23
cmpl(sa�ndregt,[],s�ndregate).  %% nec?? søndregt %% TA-110419

cmpl(s�r,tr�ndelag,s�rtr�ndelag). 
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

cmpl(tr�ndelag,museum,tr�ndelag_folkemuseum).
cmpl(tr�ndelagfolkemuseum,[],tr�ndelag_folkemuseum). 
cmpl(tr�ndelag,teater,prinsen_kinosenter).   
cmpl(tr�ndelag,trafikk,tt).   

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
cmpl(telenor,[p�,tyholt],tf). 
cmpl(telenor,[tyholt],tf).  %% Extraservice
cmpl(telenorbygget,[],tf). 
cmpl(telenorbygget,[p�,tyholt],tf). 
cmpl(telenorhuset,[],tf). 
cmpl(telenorsenteret,[],tf). 
cmpl(telenorsentret,[],tf). 
cmpl(televerket,lade,televerket). 
cmpl(tempe,auto,bratsbergvegen ). 
cmpl(tempe,hallen,nidelvhallen). 
cmpl(tempe,sykehjem,val�yvegen).  %% NB veien

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
cmpl(thorn�s,veg,k_o_thorn�s_veg). 
cmpl(thorn�s,vei,k_o_thorn�s_veg). 
cmpl(thorn�s,veien,k_o_thorn�s_veg). 
cmpl(tilfredshet,kapell,studentersamfundet_1). 
cmpl(tilfredshet,kirkeg�rd,studentersamfundet_1). 
cmpl(tiller,byen,koieflata). 
cmpl(tiller,dps,tonstadgrenda). 

cmpl(tiller,kirke,'Tiller kirke').  %% avoid nearest to M� is M�
cmpl(tiller,skole,tonstadgrenda). 
cmpl(tiller,sykehjem,tonstadgrenda). %%  (?) 
cmpl(tiller,[videreg�ende,skole],tonstadgrenda).
cmpl(tiller,vgs,tiller_v_g_s). %% TA-100716

cmpl(time,ekspressen,timeekspressen). 
cmpl(tine,[midt,norge],norske_meierier). 
cmpl(tine,[p�,tunga],norske_meierier). 
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

cmpl(tor,plassen,torplassen). 
cmpl(tor,veg,tors_veg). 
cmpl(tor,vei,tors_veg). 
cmpl(torbj�rn,[brath,veg],'Torbj�rn Bratts veg'). 
cmpl(torbj�rn,[braths,veg],'Torbj�rn Bratts veg'). 
cmpl(torbj�rn,[bratts,veg],'Torbj�rn Bratts veg'). 
cmpl(torbj�rn,[brattsvei],'Torbj�rn Bratts veg'). 
cmpl(torp,holdeplass,torplassen).  %% misu nderstanding?
cmpl(tors,plass,torplassen). 
cmpl(torv,myra,torvmyra). 
%% cmpl(torve,t,torget).  %% destroys torve=torget%% TA-101122
cmpl(town,centre,hovedterminalen). 
cmpl(town,hall,r�dhuset). 
cmpl(town,square,torget). 
cmpl(toyota,[hell,bil],j�rgen_b_lysholms_vei).  %%
cmpl(toyota,hell,j�rgen_b_lysholms_vei). 
cmpl(tr,['. ',h,sentralstasjon],ts). %% AtB. 
cmpl(tr,[folkemuseum],tr�ndelag_folkemuseum).  %%textonstation
cmpl(tr,[hei,sentral],ts). %% AtB. 
cmpl(tr,[heim,s],ts). %% AtB.  %%???
cmpl(tr,[heim,sentralst],ts). %% AtB.  %% Etc
cmpl(tr,[heim,sentralstasjon],ts). %% AtB. 
cmpl(tr,[heim,sentrum],sentrum). 
cmpl(tr,[heim,st],ts). %% AtB. 
cmpl(tr,[heim,torg],torget). 
cmpl(tr,[lag,folkemuseum],tr�ndelag_folkemuseum). 
cmpl(tr,heim,trondheim).  %% ?
cmpl(tr,heimsentralstasjon,ts). %% AtB. 
cmpl(tr,sentralstasjon,ts). %% AtB. 
cmpl(tr,sentrum,sentrum). 
cmpl(tr,st,ts). %% AtB.  %% ?
cmpl(tr,torg,torget). 
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
cmpl(trondheim,[airport],v�rnes). 
cmpl(trondheim,[e,verk],e_verket).  %% NB'e-verk'
cmpl(trondheim,[energi,verk],e_verket). 
cmpl(trondheim,[fengsel],tunga_kretsfengsel). 
cmpl(trondheim,[folkemuseum],tr�ndelag_folkemuseum). 
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

cmpl(trondheim,[�konomiske,h�gskole],t�h).  
cmpl(trondheim,busselskap,tt). 
cmpl(trondheim,bussterminal,hovedterminalen). 
cmpl(trondheim,by,trondheim). 
cmpl(trondheim,centre,sentrum). 
cmpl(trondheim,centrum,sentrum). 
cmpl(trondheim,city,sentrum). 
cmpl(trondheim,enerigverk,e_verket). 
cmpl(trondheim,festning,ankers_gate). 
cmpl(trondheim,flygplats,v�rnes).  %%(Swe)
cmpl(trondheim,flyplass,v�rnes). 
cmpl(trondheim,havn,pirbadet). 
cmpl(trondheim,hovedjernbanestasjon,ts). %% AtB. 
cmpl(trondheim,hovedstasjon,ts). %% AtB. 
cmpl(trondheim,jernbanestasjon,ts). %% AtB. 
cmpl(trondheim,jernbanestation,ts). %% AtB. 
cmpl(trondheim,katedralskole,katedralskolen). 
cmpl(trondheim,kino,kino). 
cmpl(trondheim,kretsfengsel,tunga_kretsfengsel). 
cmpl(trondheim,lufthavn,v�rnes). 
cmpl(trondheim,l�rerh�gskole,rotvoll_nedre). 
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
cmpl(trondheim,teater,prinsen_kinosenter). 
cmpl(trondheim,togstasjon,ts). %% AtB. 
cmpl(trondheim,togstation,ts). %% AtB. 
cmpl(trondheim,torg,torget). 
cmpl(trondheim,torg,trondheim_torg). 
cmpl(trondheim,torget,trondheim_torg). 
cmpl(trondheim,torv,torget).  %%
cmpl(trondheim,trafikk,tt). 
cmpl(trondheim,trafikkselskap,tt).  %%Also for non-places
cmpl(trondheim,trafikkstasjon,ts). %% AtB. 
cmpl(trondheim,university,ntnu). 
cmpl(trondheim,vandrerhjem,sig_berg_alle). 
    cmpl(rosenborg,vandrerhjem,sig_berg_alle). 
cmpl(trondheim,verft,solsiden). 
cmpl(trondheim,vernes,v�rnes).  %% NO spell on parts (if too many)
cmpl(trondheim,v�rnes,v�rnes).  %% Flybuss trondheim v�rnes Align
cmpl(trondheims,flygplats,v�rnes).  %%(Swe)
cmpl(trondheims,flyplass,v�rnes). 
cmpl(trondheims,sentrum,sentrum). 
cmpl(trondheims,torg,torget). 
cmpl(trondhjems,sporveier,gr�kallbanen). 
cmpl(tryggvasons,gate,olav_tryggvasons_gate). 
cmpl(tryggvassons,gate,olav_tryggvasons_gate). 
cmpl(tryggvassons,gt,olav_tryggvasons_gate). 
cmpl(tr�ndelag,[folk,museum],tr�ndelag_folkemuseum).  %% Eng
cmpl(tr�ndelag,teater,prinsen_kinosenter).  %%(shortcut)
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
cmpl(tv,tower,tyholtt�rnet). 
cmpl(tv,t�rnet,tyholtt�rnet). 
cmpl(tyholt,sykehjem,tyholt). 
cmpl(tyholt,tower,tyholtt�rnet). 
cmpl(tyholt,t�rnet,tyholtt�rnet). 
cmpl(t�h,moholt,t�h). 
cmpl(ugla,[p�,by�sen],ugla). 
cmpl(ugla,skole,ugla). 
cmpl(ungdomsherberget,[],sig_berg_alle). 
cmpl(univ,dragvoll,dragvoll). 
cmpl(univ,dragvoll,dragvoll).  %%NBNB \+ universitetetdragvoll!!!
cmpl(univ,gl�shaugen,gl�shaugen). 
cmpl(univ,lade,ntnu_lade).  %%ChangeName
cmpl(universitet,[p�,lade],ntnu_lade). 
cmpl(universitet,[rosenborg],a_v_h). 
cmpl(universitetet,[i,lade],ntnu_lade). 
cmpl(universitetet,[p�,dragvoll],dragvoll). 
cmpl(universitetet,[p�,gl�shaugen],gl�shaugen_nord). 
cmpl(universitetet,[p�,lade],ntnu_lade). 
cmpl(universitetet,[p�,rosenborg],a_v_h). 
cmpl(universitetet,[rosenborg],a_v_h). 
cmpl(universitetet,[ved,dragvoll],dragvoll). 
cmpl(universitetet,[ved,lade],ntnu_lade). 
cmpl(universitetet,[ved,rosenborg],a_v_h). 
cmpl(universitetet,dragvoll,ntnu_dragvoll).  %%????
cmpl(universitetet,gl�shaugen,gl�shaugen). 
cmpl(universitetet,lade,ntnu_lade). 
cmpl(universitetssenteret,[dragvoll],ntnu_dragvoll). 
cmpl(university,[at,gl�shaugen],gl�shaugen).  %%Nec
cmpl(university,[at,lade],ntnu_lade). 
cmpl(university,[of,dragvoll],dragvoll). 
cmpl(university,[of,trondheim],ntnu). 
cmpl(university,gl�shaugen,nth). 
cmpl(utleira,skole,risvollan_senter). 
cmpl(v,rnes,v�rnes).  %%tov'rnes
cmpl(v,rosten,vestre_rosten). 
cmpl(valentien,lyst,valentinlyst). 
cmpl(valentin,lyst,valentinlyst). 
cmpl(valentin,senteret,valentinlyst). 
cmpl(valentinlyst,kj�pesenter,valentinlyst). 
cmpl(valentinlyst,senteret,valentinlyst). 
cmpl(vass,fjellet,vassfjellet). 
cmpl(vassfjellet,skisenter,vassfjellet). 
cmpl(veimesterkroghs,street,veimester_kroghs_street). 
cmpl(veimesterkrogs,street,veimester_kroghs_street). 
cmpl(veimesterkrohgs,street,veimester_kroghs_street). 
cmpl(verdens,ende,tj�me). 
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

cmpl(vik�sen,['/',reppe],reppevegen). 
cmpl(vik�sen,[n],vik�sen_nedre). 
cmpl(vik�sen,[s],vik�sen_skole).  %% NB skole
cmpl(vik�sen,endeholdeplass,vik�sen). 
cmpl(vik�sen,hallen,markaplassen_skole). 
cmpl(vik�sen,idrettshall,markaplassen_skole). 
cmpl(vik�sen,reppe,reppevegen). 
cmpl(vm,anlegget,gran�sen_vm_anlegget). 
cmpl(vm,arenaen,gran�sen_vm_anlegget). 

cmpl(vollstudent,[by],voll_studentby). 
cmpl(voll,['4h',g�rd],voll_g�rd).  %%
cmpl(voll,[gryta],gryta). 
cmpl(voll,[st,b],voll_studentby). 
cmpl(voll,[st,by],voll_studentby). 
cmpl(voll,[stud,by],voll_studentby). 
cmpl(voll,[student,by],voll_studentby). 
cmpl(voll,stud,voll_studentby). 
cmpl(voll,student,voll_studentby). 
cmpl(volla,bakken,vollabakken). 
cmpl(vollan,g�rd,voll_g�rd). 
cmpl(volls,studentby,voll_studentby). 
cmpl(volls,tudentby,voll_studentby). 
cmpl(v�r,[frue,kirke],torget). 
cmpl(v�r,[frues,kirke],torget).  %%spc<6
cmpl(v�re,tr�a,v�restr�a). %% off name 
cmpl(v�rnes,[airport],v�rnes). 
cmpl(v�rnes,[fly,havn],v�rnes). 
cmpl(v�rnes,[luft,havn],v�rnes). 
cmpl(v�rnes,flyhavn,v�rnes). 
cmpl(v�rnes,flyplass,v�rnes). 
cmpl(v�rnes,flystasjon,v�rnes). 
cmpl(v�rnes,lufthavn,v�rnes). 
cmpl(v�rnes,trondheim,v�rnes). 
cmpl(wistings,street,oscar_wistings_street). %% TA-101115 nec
cmpl(witro,bil,fossegrenda).

cmpl(wullums,g�rden,by�sen_butikksenter). 
cmpl(wullimsg�rden,[],by�sen_butikksenter). %% TA-101230

cmpl(youth,hostel,sig_berg_alle). 
cmpl(ystgaards,vei,ingvald_ystgaards_street). 
cmpl(zion,sykehjem,ole_hogstads_street-16).  %% Tegleverkskrysset
cmpl(�,[bergg�rdsvei],arne_bergsg�rds_vei). 
cmpl(�,grevskottsvei,anton_grevskotts_veg). 
cmpl(�s,skole,�sveien_skole).  %%?
cmpl(�sheim,[ungdom,skole],�sheim_skole). 
cmpl(�sheim,[videreg�ende,skole],�sheim_skole).  %% ? 
cmpl(�sheim,ungdomsskole,�sheim_skole). 
cmpl(�sv,skole,�sveien_skole). 
cmpl(�sveien,skolen,�sveien_skole). 
cmpl(�svenein,skole,�sveien_skole).  %% ?
 cmpl(�,[flat�s,v],�vre_flat�sveg).  %%Syndrome
 cmpl(�,[flat�s,vei],�vre_flat�sveg).  %% \+ direction
cmpl(�,[jakobsli],jakobslivegen_�vre). 
cmpl(�,berg,�stre_berg). 
cmpl(�,flat�sen,�vre_flat�sveg). 
cmpl(�,jakobsliv,jakobslivegen_�vre). 
cmpl(�,rosten,�stre_rosten). 
cmpl(�stmarka,[psykiatriske,sykehus],�stmarkveien). 
cmpl(�stmarka,psykiatriske,�stmarkveien). 
cmpl(�stmarka,sykehus,�stmarkveien). % (�stmarkveien15). Avoid u ndersp "sykehus"
cmpl(�stre,eberg,�stre_berg). 
cmpl(�stre,ber,�stre_berg). 
cmpl(�stre,berg,�stre_berg). %% AtB 
cmpl(�stre,v�re,v�re_�stre). 
cmpl(�verste,singsaker,singsaker).  %% EOB:-)
cmpl(�vre,[charlottenlund],skovg�rd). 
cmpl(�vre,[eberg],�stre_berg). 
cmpl(�vre,[flat�s,v],�vre_flat�sveg).  %%v=ved#sms
cmpl(�vre,[flat�s,veg],�vre_flat�sveg). 
cmpl(�vre,[flat�s,vei],�vre_flat�sveg). 
cmpl(�vre,[romolslia],romolslia_�vre). 
cmpl(�vre,alle,'�vre All�'). 
cmpl(�vre,berg,�stre_berg).  %% similar sound,rightplace?
cmpl(�vre,by�sen,ugla).  %% ???
cmpl(�vre,flat�s,�vre_flat�sveg). 
cmpl(�vre,flat�sen,�vre_flat�sveg). 
cmpl(�vre,flat�svei,�vre_flat�sveg). 
cmpl(�vre,h�greina,h�greina_�vre). 
cmpl(�vre,jakobsli,jakobslivegen_�vre).  %% iv_!#� %%changed?  %% feil rute 66
cmpl(�vre,jakobsli_street,jakobslivegen_�vre).  %% street ?
cmpl(�vre,m�llenberg,sig_berg_alle). 
cmpl(�vre,romolslia,romolslia_�vre). 
cmpl(�vre,rosten,�stre_rosten). 
cmpl(�vre,singsaker,singsaker). 
cmpl(�vreflat�s,veg,�vre_flat�sveg). 
cmpl(�vreflat�sen,veg,�vre_flat�sveg).
cmpl(�vrem�llenberg,gate,�vre_m�llenberg_street). 
cmpl(�ya,helsehus,�ya_helsehus). %RS-110926


%%% FOREIGN (to Trondheim) places


foreign(aalesund). 
foreign(aardal).  %% \+ aurdal
foreign(aare). 
foreign(abilds�).
foreign(abrahallen). 
foreign(adamstuen).
foreign(afjord).
foreign(agdenes). 
foreign(agder). 
foreign(ajer). 
foreign(aker). 
foreign(akershus). 
foreign(aksdal). 
%% foreign(alesund). %% -> synplace 
foreign(alna). 
foreign(alstad).
foreign(alsv�g). 
foreign(alta). 
foreign(alteren). 
foreign(alvdal). 
foreign(alversund).  
foreign(alvim).   
foreign(alv�rn). 
foreign(alv�en).  
foreign(amdal). 
foreign(ammerud). 
foreign(andalsnes). 
foreign(andebu). 
foreign(andenes).
foreign(andselv). 
foreign(and�y).  
foreign(and�ya). 
foreign(anglevik). 
foreign(ankenes).
foreign(arendal). 
foreign(arna).    
foreign(arnvika).
foreign(arn�y).  
foreign(arvika). 
foreign(asker). 
foreign(askim). 
foreign(ask�y). 
foreign(aspelund). 
foreign(aspmyra).  
    foreign(aspemyra).   %%  ?
foreign(asser�ya). 
foreign(augland). 
foreign(aukra). 
foreign(auli). 
foreign(aundalen). 
foreign(aurdal). 
foreign(aure). 
foreign(aurskog). 
foreign(austagder). 
foreign(austr�t). 
foreign(austr�tt). 
foreign(avaldsnes).
foreign(aver�y). 
foreign(avl�s). %% B�rum 

foreign(bagn).
%% foreign(balestrand). %%K 
foreign(ballangen). 
foreign(ballstad). 
foreign(bamble). 
foreign(bangsund). 
foreign(bardufoss).
foreign(bark�ker). 
foreign(begby).  
foreign(beisfjord).
foreign(beitstad). 
foreign(bekkelaget).
foreign(bekkestranda). 
foreign(bekkestua).  %% (bus center)
foreign(bergen). 
foreign(bergkrystallen). 
foreign(bergmo).  
foreign(bergseng).  
foreign(bergs�sen). 
foreign(berk�k).
foreign(berlev�g). 
%% foreign(berner).   %% carl
foreign(bessaker). 
foreign(bild�y).   
foreign(billingstad). 
foreign(biri).  
foreign(birkeland). 
foreign(birtavarre).
foreign(bislet).  
foreign(bislett). 
foreign(bjelland). 
foreign(bjerkaker).
foreign(bjerke). 
foreign(bjerkvik). 
foreign(bjerk�ya). 

foreign(bjordal). 
foreign(bjorli). 

foreign(bjugn). 
  foreign(bjung). 
foreign(bj�lsen). 
foreign(bj�lstad). 
foreign(bj�rbekk).
foreign(bj�rkelangen).  %% (toget p� NTH ?)
foreign(bj�rnevatn). 
foreign(bj�rnsletta). 
foreign(bj�rset). 
foreign(blakstad). 
foreign(blaker).
foreign(blefjell). 
foreign(bleiker). 
foreign(bleikemyr).
foreign(bleikmyr).
foreign(bleikvassli).
    foreign(bleikvasslia). %
foreign(blessom). 
foreign(blindern). 
foreign(blindheim). 
foreign(blommenholm).  
foreign(blystadlia). 
foreign(bod�). 
foreign(bogerud). 
foreign(bognes). 
foreign(bols�ya).
foreign(bommestad).
foreign(bones). 
foreign(borgen).    %% oslo
foreign(borgestad).
foreign(borkenes).
foreign(borre). 
foreign(borgund).  
foreign(borlaug).  
foreign(bosberg). 
foreign(bossekop). 
foreign(botngard). 
foreign(botng�rd). 
foreign(botnhamn). 
foreign(botter�sen).
foreign(bragenes). 
foreign(brandbu). 
foreign(brannfjell).
foreign(braskereidfoss). 
foreign(brattlikollen). 
foreign(brattholmen).
foreign(brattv�g). 
foreign(bratt�s).    %% TA-100828 ??? [name(bauta,n,0),name(bratts,n,0)]
foreign(breistein). 
foreign(breivang). 
foreign(brekken). 
foreign(brekker�d). 
foreign(brekktr�a). 
foreign(brekk�sen). 
foreign(brekstad). 
foreign(bremanger).  
foreign(bremsnes).
foreign(brenn�sen).
foreign(brevik). 
foreign(bragernes).
foreign(brakahaug).
foreign(briskeby).
foreign(bruhagen).  
foreign(brummunddal). %% off spel
   foreign(brumundal). 
   foreign(brumunddal). 
foreign(bruteig). 
foreign(bryn).  
foreign(bryne). 
foreign(br�holt). 
foreign(br�nn�ysund). 
foreign(br�ttem). 
foreign(br�n�sen). 
foreign(br�vann). %% ?
foreign(budal). 
foreign(budalen). 
foreign(bug�rden). 
foreign(buktamo).  
foreign(buktamoen).
foreign(buktelia).
foreign(burfjord). 
foreign(buskerud). 
foreign(buskerud). 
foreign(buvik). 
foreign(buvika). 
foreign(bu�s).  %% Hommelvik
foreign(bygdin). 
foreign(bygd�). 
foreign(bygd�y).  %% oslo
foreign(byrkjelo). 
foreign(b�rdshaug). 
foreign(b�smo). 
foreign(b�smoen).  %% Nordland 
foreign(b�tsfjord). 
foreign(b�rum). 
foreign(b�).  %% i Telemark 
foreign(b�dalen). 
foreign(b�ler).
foreign(b�ler�sen).
foreign(b�mlo). 
foreign(b�nes). 
foreign(b�rsa). 
foreign(b�rssa). 

foreign(carl_berners_plass). 

foreign(dalby). 
foreign(dalselv). 
foreign(dalsgrenda). 
foreign(dals�yra). 
foreign(darbu). 
foreign(davik). 
foreign(dikemark). 
foreign(dirdal). 
foreign(disen).    
foreign(djupdalen). 
foreign(djupvika). 
foreign(dokka). 
foreign(dolven). 
foreign(dombaas). 
foreign(dombas). 
foreign(domb�s). 
foreign(dovre). 
foreign(dovrefjell). 
foreign(drabl�s).  %%?
foreign(dragesten). 
foreign(dragsten). 
foreign(draksten). 
foreign(drammen). 
foreign(drammensveien). 
foreign(drange). 
foreign(drangedal).
foreign(drevsj�). %% ?  
foreign(drevvatn).
foreign(dr�bak). 
foreign(dvergsnes). 
foreign(dyrnes). 
foreign(dyrvik). 
foreign(ed�y). 
foreign(egersund). 
foreign(egge). 
foreign(eggemoen). 
foreign(eggkleiva). 
foreign(eid). 
foreign(eidanger). %% TA-100511
foreign(eide). 
foreign(eidfjord). 
foreign(eidsb�en).
foreign(eidsdal). 
foreign(eidsfjord). 
foreign(eidsmo).   
foreign(eidsvold). 
   foreign(eidsvoll). 
foreign(eidsv�g). 
foreign(eidsv�gneset).
foreign(eids�). 
foreign(eik). 
foreign(eikangerv�g).
foreign(eikelandsosen).
foreign(eikeli).   
foreign(eiker).   
foreign(eiksmarka).
foreign(eik�s).   
foreign(ekeberg). 
foreign(ekholt).   
foreign(ekne). 
foreign(eknes).  
foreign(ellingsrud). 
foreign(ellings�y).  
foreign(elnesv�gen). 
foreign(elsfjord).  
foreign(elton�sen).  
foreign(elvebakken). 
foreign(elvenes).  
foreign(elveneset). 
foreign(elverum). 
foreign(elvestad). 
foreign(elvran). 
foreign(enebakk). 
foreign(engdal). 
foreign(engerdal). 
foreign(engelsviken).
foreign(engervannet). %% Sandvika 
foreign(ensj�). 
foreign(erdal).  
foreign(espa). 
foreign(espeland).
foreign(etne). 
foreign(etterstad). 
foreign(evanger). 
foreign(evenes). 
foreign(evenskjer).
foreign(evenstad). 
foreign(evje). 
foreign(evjen). 
foreign(eydehavn). 

foreign(fagerborg).  %% oslo
foreign(fagernes). 
foreign(fagerstrand). 
%% foreign(falkeid). %% not place
foreign(falkum).
foreign(falstad). 
   foreign(falstadsenteret).
foreign(fana). 
foreign(fannerm). %%*
foreign(fannrem). 
foreign(fannremsmoen). 
foreign(fanrem). 
foreign(fanremmen). 
foreign(fantoft). 
foreign(farmandstredet). 
foreign(farsund). 
foreign(fauskanger). 
foreign(fauske). 
foreign(feda). 
foreign(fenes). 
foreign(fenstad).   %% (\+ferstad)
foreign(ferkingstad). 
foreign(fet).
foreign(fetsund). 
foreign(fevik). 
foreign(fev�g). 
foreign(figgjo). 
foreign(fillan). 
foreign(filtvedt). 
foreign(finmark). 
foreign(finnefjorden). 
foreign(finnfjordbotten).  %% botn ?
foreign(finnmark). 
foreign(finnmarksvidda). 
foreign(finnsnes). foreign(finsnes). 
foreign(finstad).  
foreign(fiskarstrand).
foreign(fiskeb�l).  
foreign(fitjar). 
foreign(firda).  
foreign(fjellhamar). 
    foreign(fjellhammer).
foreign(fjerdingby). 
foreign(fj�sanger).  

foreign(fjellv�r�y). 
foreign(fjordg�rd).
foreign(fj�remfossen). 
foreign(flatanger). 
foreign(flateby).
foreign(flaktveit).
foreign(flat�y).
foreign(flekke). 
foreign(flekkefjord). 
foreign(flekker�y). 
   foreign(flekker�ya).
foreign(fjertnes). %% :-) %% TA-101123
foreign(fleksnes). %% 
foreign(flesberg).  
foreign(fleskmo).
foreign(flesland). 
foreign(flisa). 
foreign(flisnes). 
foreign(flora). 
foreign(flornes). 
foreign(florv�g).
foreign(flor�). 
foreign(flotmyr).
foreign(fl�). 
foreign(fl�klypa). %%  :-)
foreign(fl�nes). 
foreign(folbu).  %%
foreign(foldr�y). 
foreign(folkvang). 
foreign(follafoss). 
foreign(follbu). 
foreign(follebu). 
foreign(folkestad). 
foreign(follese).   %% e 
foreign(fongen). 
foreign(fornebu). 
foreign(forus).  %% Stavanger
foreign(fosen).  %% ( \+ Osen)
foreign(fosenhalv�ya). 
foreign(fosnav�g). 
foreign(fossbrenna).
foreign(frafjord).  
foreign(framnes). 
foreign(fredrikstad). 
foreign(frei). 
foreign(frekhaug). 
foreign(frogn).   
foreign(frogner).  %% oslo
foreign(frognerparken).  %% oslo
foreign(frol). 
foreign(froland). 
foreign(fron). %% S�r Fron %% TA-110415
foreign(frosta). 
   foreign(frostad). %% sp %%  \= Ferstad
foreign(frydendal).
foreign(frysja). 
foreign(fr�ya).
foreign(fr�ya). foreign(fr�ja). 
foreign(furnes). 
foreign(furukollen). 
foreign(furuset). 
foreign(fusa). 
foreign(fyllingsdalen). 
foreign(f�rde). 
foreign(f�rre).
foreign(f�berg).
foreign(f�vang). %% TA-101228

foreign(galdh�piggen). 
foreign(galgeberg). 
foreign(ganddal). 
foreign(gangs�s).  %%~Harstad
foreign(gardemoen). 
foreign(gardermoen). 
foreign(garder�sen). 
foreign(garnes).  
foreign(gauldal). 
foreign(gaulosen). 
foreign(gausdal). 
foreign(gaustad).
foreign(gautefall). 
foreign(gauter�d) . 
foreign(geilo). 
foreign(geiranger). 
foreign(geithus). 
foreign(gibostad). 
foreign(gimle).  %% ?
foreign(gimlekollen). 
foreign(gimse).  %% ? = Gimle(veien)
foreign(gi�verbukta). 
foreign(giske).   %% �lesund
foreign(gjeller�sen).  %% oslo
foreign(gjemnes). 
foreign(gjende). 
foreign(gjendesheim). 
foreign(gjengst�). 
foreign(gjennestad).
foreign(gjerde). 
foreign(gjerdrum). 
foreign(gjerdsvika).
foreign(gjerpen).   %% TA-101201
foreign(gjettum).  
foreign(gj�lme). 
foreign(gj�ra). 
foreign(gj�vik). 
foreign(glesnes). 
foreign(glittertind). %% :-)
foreign(glomfjord).
foreign(glomma).  %% TA-110105 ?
foreign(gloppen). 
foreign(gluppe).
foreign(gl�mos). 
foreign(godalen). 
foreign(gokk). %% :-) 
foreign(gol). 
foreign(gomsrud).  
foreign(gotterud). 
foreign(gran). 
foreign(granholmen).
foreign(gravdal). 
foreign(grefsen).   %%  \+ Grensen 
foreign(grenland). 
foreign(gressvik). 
foreign(greverud). 
foreign(gre�ker). 
foreign(grimseid).
foreign(grimstad). 
foreign(grindaheim). 
foreign(grindal). 
foreign(grindbakken). 
foreign(grinde). 
foreign(grinder). 
foreign(grong). 
foreign(grorud). 
foreign(grotli).   
foreign(gruben).    
foreign(grua).
foreign(grunerl�kka).  %% yy
foreign(gryllefjord). 
foreign(grynerl�kka). 
foreign(gr�a).  %%?
foreign(gr�dem). 

foreign(gr�nnland).  %% Oslo       %% TA-101118 (nn)
%% foreign(gra�nnland). %% avoid gr�nlia %% 
%% foreign(gr�nlan).    %%

foreign(gr�nlund).  
foreign(gr�nn�sen).
foreign(gr�brekk). 
foreign(gr�kammen). 
foreign(gr�lum).  
foreign(gudvangen).
foreign(gulldalen). 
foreign(gullhaug). 
foreign(gulset).  
foreign(gulskogen). 
foreign(gulsvik). 
foreign(gutvik). 
foreign(gvarv). 
foreign(gyllenborg).
foreign(g�l�). 
foreign(g�sbu). 

foreign(haakonsvern). 
foreign(haddal).  
foreign(hadeland). 
foreign(hafrsfjord). 
foreign(hafslund).
foreign(hagafjell). 
foreign(hagavik). 

foreign(hafjell). 
foreign(hakadal). 
foreign(halden). 
foreign(hallagerbakken).
foreign(hallingby). 
foreign(hallingdal). 
foreign(halmstad). %% �stfold (+S)
foreign(halsa). 
foreign(hals�y). 
foreign(haltdal). 
foreign(haltdalen). 
foreign(hamar). 
foreign(hamar�y). 
foreign(hammarby). 
foreign(hammerfest). 
foreign(hamna). 
foreign(hamnvik). 
foreign(hamresanden). 

foreign(hanestad). 
foreign(hanevik).
foreign(hank�).     %% TA-101124
foreign(hannestad).
foreign(hannevika). 
foreign(han�y).   
foreign(heer).     %%  +her
foreign(heie).     %% TA-110429
foreign(helles�y).
foreign(hellvik).
  foreign(hetlevik). 
foreign(hen).      %%  nw ?
foreign(henningsv�r). 

foreign(hardanger). 
foreign(hareid). 
foreign(harestua). 
foreign(harstad).  %% \=Havstad
foreign(hasle).   
foreign(haslum).   %%  B�rum
foreign(hasselvika). 
foreign(hatlelia). 
foreign(hatlestad).
foreign(hattfjelldal). 
foreign(hattrem). 
foreign(haugaland).
foreign(haugast�l). %% TA-110803
foreign(hauge).     %% \+ hagen  
foreign(haugenstua). 
foreign(haugerud). 
foreign(haugesund). 
foreign(haugsbygd).  %% TA-110128
foreign(haugsbygda).
foreign(haukeland).  
foreign(haukelid). 
foreign(haukeliseter). 
foreign(hauketo). 
foreign(hauk�a). 
foreign(haus). 
foreign(havdal). 
foreign(havik). 
foreign(hav�ysund). 
foreign(hedmark). 
foreign(hegra). 
foreign(heiane). 
foreign(heimsj�en). 
foreign(heistad).
foreign(heistadmoen).
foreign(helgeland).    
foreign(helgelandsmoen). 
foreign(helgeroa). 
foreign(hell). 
foreign(hella). 
foreign(hellandsj�en). 
foreign(helleland).
foreign(hellemyr). 
foreign(hellerud). 
foreign(helleskaret).
foreign(hellesylt).
foreign(hell�sen).  %% ?
foreign(helsfyr). 
foreign(helsingborg). 
foreign(hembre). 
foreign(hemne). 
foreign(hemnekj�len). 
foreign(hemnes).    % ?
foreign(hemnesberget). 
foreign(hemnskjel). 
foreign(hemsedal). 
foreign(heradsbygda). 
foreign(herdla).   
foreign(hernes). 
foreign(herringen).  
foreign(her�y).   
    foreign(her�ya).
foreign(hessa). 
foreign(hessdalen). 
foreign(hesseng). 
foreign(hestvika). 
foreign(hillerbyen). 
foreign(hilles�y). 
foreign(hillev�g).
foreign(hinna).  %% Stvg
foreign(his�y). 
foreign(hitra). 
foreign(hjellestad). 
foreign(hjelmeland). 
foreign(hjelset). 
foreign(hjerkin). 
foreign(hjerkinn). 
foreign(hjukseb�). 
foreign(hokksund). 
foreign(hole). 
foreign(hollingen). 
foreign(holmenenga). 
foreign(holmenkollen). 
foreign(holmestrand). 
foreign(holmlia). 
foreign(holmsbu).
foreign(holt�len). 
foreign(holum).  
foreign(holvik). 
foreign(holvika). 
foreign(homborsund). 
foreign(homelvik). 
foreign(homelvika).  
foreign(hommelvik). 
foreign(hommelvika). 
foreign(hommelviken). 
foreign(hommers�k). 
foreign(honningsv�g). 
foreign(hordaland). 
foreign(hordvik). 
foreign(hordvikneset). 
foreign(horg). 
foreign(horstad).
foreign(horten). 
foreign(hosanger).
foreign(hosle).    %% TA-101021
foreign(hov). 
foreign(hovda).
foreign(hovdebygda). 
foreign(hovden). 
foreign(hovet). 
foreign(hovin). 
foreign(hovind). 
foreign(hovjordet).
foreign(hovseter). 
foreign(huk).  %% Oslo 
foreign(humelvik). 
foreign(hummelvik). 
foreign(hummelvika).
foreign(hunderfossen). %% TA-110228
foreign(hundhameren). 
foreign(hundhammer). 
foreign(hundhammeren). 
foreign(hundorp). 
foreign(hakkebakkeskogen).  %% :-)
foreign(hundremeterskogen). %% :-)
foreign(hunstad). 
foreign(hundv�g).  %% Stavanger
foreign(hurdal). 
foreign(hurum). 
foreign(hushovd). 
foreign(husnes).
foreign(husvik).
foreign(hvaler). 
foreign(hvalstad). 
foreign(hvalstrand). 
foreign(hvasser).    
foreign(hvittingfoss). 
foreign(hylkje). 
foreign(hysnes). 
foreign(h�geland).
foreign(h�g�sen). 
foreign(h�ietun).
foreign(h�land). 
foreign(h�le).  
foreign(h�len).  
foreign(h�llen). 
foreign(h�londa). 
foreign(h�nefoss). 
foreign(h�vik). foreign(h�vikodden). 
foreign(h�v�g). 
foreign(h�yanger). 
foreign(h�ybr�ten). 
foreign(h�ylandsbygd).
foreign(h�ysand). 
foreign(h�kvik). 
foreign(h�konsvern). 
foreign(h�nes). 
foreign(h�rberg). 
foreign(h�vik).  

foreign(ilseng).  
foreign(inder�y). 
    foreign(inner�ya).
foreign(ingeberg).
foreign(inndyr). 
foreign(isfjorden). 
foreign(jakobsnes). 
foreign(jar).  %% B�rum \+ Jarvegen
foreign(jaren). 
foreign(jektvik).
foreign(jelsnes).
foreign(jenserud). 
foreign(jerpestad). % foreign(jerpstad). 
foreign(jervan). 
foreign(jessheim). 
foreign(jessnes). 
foreign(jevnaker). 
foreign(jom�s).  
foreign(jotunheimen). 
foreign(julsundet). 
foreign(justvik). 
foreign(juvik).  
foreign(j�ren).
foreign(j�a). 
foreign(j�lster). 
foreign(j�mna). 
foreign(j�nsberg). 
foreign(j�rpeland). 
foreign(j�rstadmoen).
foreign(j�ss�sen). 
foreign(j�vik). %% sic 
foreign(j�tt�).

foreign(kalv�ya). 
foreign(kabelv�g). 
foreign(kalbakken). 
foreign(kaldbakken). 
foreign(kaljord).  
%% foreign(kalv�s).  %% Anton Kalvaas gate
foreign(kampen). %% Oslo \+ Kammen
%% foreign(kamset).     %% ? (sounds genuine) NO 
foreign(kapp). %% gj�vik 
foreign(karasjok). foreign(karasjokk). %% ? 
foreign(karihaugen).
foreign(karlsrud).   
foreign(karmsund).
foreign(karm�y).   
foreign(kasfjord). 
foreign(kastanjesletta). 
foreign(kattfjord).
foreign(kaupang). 
foreign(kaupanger). 
foreign(kautokeino). 
foreign(kila).  
foreign(kilbotn). %%
foreign(kilsund). 
foreign(kinsarvik). 
foreign(kippermoen). 
foreign(kirkenes). 
foreign(kirken�r). 
foreign(kirkerud).  
foreign(kistefjell). 
foreign(kjeller). 
foreign(kjels�s). 
foreign(kjerrgarden).  
foreign(kjerring�y).  
foreign(kjevik). 
foreign(kj�de). 
foreign(kj�psvik).
foreign(kj�sterud).  
foreign(klakegg).   
foreign(klekken).   
foreign(klevjerhagen).
foreign(kleive).  %% Molde
foreign(klepp).
foreign(kleppe). 
foreign(kleppekrossen). 
foreign(kleppest�). 
foreign(klinga). 
foreign(klyve). 
foreign(kl�fta). 
foreign(kl�vberget). 
foreign(knapstad).
foreign(knarberg). 
foreign(knarvik). 
foreign(kokstad). 
foreign(kolbotn). 
foreign(kolbu). %% �stre Toten  \+ Kl�bu %% TA-110629
foreign(kolvereid). 
foreign(kongsbakken).
foreign(kongsberg). 
foreign(kongsskog). %% ss %%  Nittedal
foreign(kongsskogen).
foreign(kongsvinger). 
foreign(kongsvoll). 
foreign(konnerud). 
foreign(kopervik). 
   foreign(koppervik). 
foreign(koppang). 
foreign(kopperud). 
foreign(korgen).  
foreign(korsvoll). 
foreign(krager�). 
foreign(kringlebotn).
foreign(kristiansand). 
foreign(kristiansund). 
foreign(krokeide). 
foreign(krokelvdalen). 
foreign(kroken).   
foreign(krokstadelva).
foreign(krokstad�ra). 
foreign(krokvolden).  
foreign(kronstad).  
foreign(kr�deren).  
foreign(kr�dsherad). 
foreign(kr�kenes). 
foreign(kr�ker�y).  
foreign(kr�kstad).  
foreign(kr�kv�g). 
foreign(kulstadlia). 
foreign(kurland). 
foreign(kvalvik). foreign(kvalvika). 
foreign(kvalsvik). 
foreign(kval�y). 
  foreign(kval�ya). 
foreign(kval�ysletta). 
foreign(kvalv�g).
foreign(kvam). 
foreign(kvamskogen). 
foreign(kvarstein). 
foreign(kvernaland). %%  the place
    foreign(kverneland). %%  na?
foreign(kvernevik). 
foreign(kvikne). 
foreign(kviltorp).  
foreign(kvina).     
foreign(kvinesdal). 
foreign(kvinherad). 
foreign(kvithamar). 
foreign(kvitland). 
foreign(kv�fjord).  
foreign(kv�rnerbyen).
foreign(kv�l).
foreign(kv�s). 
foreign(kyrkseter�ra). 
  foreign(kyks�ter�ra). 
  foreign(kyrkseterr�ra). 
  foreign(kyrkset�ra). 
  foreign(kyrks�ter�ra). 
  foreign(kyrks�tr�ra). 
  foreign(kyrseter�ra). 
  foreign(kyrs�ter�ra). 
foreign(k�rv�g). 

foreign(kyrkjeb�).
foreign(lahaugmoen).
foreign(lahelle). 
foreign(lakselv). 
foreign(laksev�g). 
foreign(lambertseter). 
foreign(landro).
foreign(landr�). 
foreign(land�s). 
foreign(land�ya). 
foreign(langdalen).  %%??
foreign(langesund). 
foreign(langev�g).  
foreign(langhus).  %% ? 
foreign(langmyra). 
foreign(langnes). 
foreign(lang�ya).
foreign(larkollen). 
foreign(larseng). 
foreign(larsnes).  
foreign(larvik). 
foreign(lauvsnes). 
foreign(lauvstad). 
foreign(lauv�ya). 
foreign(leikanger). 
foreign(leiknes).  %% TA-110125
foreign(leikvoll). 
foreign(lein�ra). 
foreign(leirsj�en).
foreign(leirsund).  
foreign(leirvik). 
foreign(leistad). 
foreign(leka). 
foreign(lekka).  %% namsos
foreign(leknes). 
foreign(leksnes).  %% ?
foreign(leksvik). 
    foreign(leksvika). 
foreign(lena). %% Toten 
foreign(lensvik). foreign(lensvika). 
foreign(leps�y). 
foreign(ler). 
foreign(lerstad). 
foreign(lervik). 
foreign(levanger). 
foreign(liab�).  %% ?
foreign(lier). 
foreign(lierberget). 
foreign(lierbyen). 
foreign(lierne). 
foreign(lierskogen). 
foreign(lierstranda).
foreign(liertoppen).
foreign(liknes). 
foreign(lilleaker).  %% Oslo 
foreign(lillehamer). 
foreign(lillehammer). 
foreign(lillesand). 
foreign(lillestr�m). 
foreign(lillo).   
foreign(lindeberg).  %% Oslo
foreign(lindern). 
foreign(linderud). 
foreign(linderudsletta). 
foreign(lindesnes). 
foreign(lines�ya).  %% ?
foreign(lisleby).   %% lilleby ?
foreign(lismarka). 
foreign(lista).    
foreign(ljabru). 
%% foreign(ljan). %% Oslo ??  -> Lian?
foreign(lodalen).
foreign(loddefjord). 
foreign(loen). 
foreign(lofoten). 
foreign(lom). 
foreign(lommedalen). 
foreign(lomundal). 
foreign(lonev�g). 
foreign(longum). 
foreign(lundamo). 
foreign(lundamoen). 
foreign(lundermoen). %% confuse lundamo ? 
foreign(lunder�sen). %% confuse lund�sen ? 
foreign(lundsv�gen).   
foreign(lunner).    
foreign(lura).   
foreign(lutvann). %% TA-101026
foreign(lye).  
foreign(lyngb�). 
foreign(lyngdal). 
foreign(lyngmoen). 
foreign(lyngseidet). 
foreign(lysaker).    %% Oslo 
foreign(lysejordet). 
foreign(lysekil). 
foreign(lys�ysund). 
foreign(l�nke). 
foreign(l�rdal). 
foreign(l�dingen). 
foreign(l�ken). 
foreign(l�kkemyra). 
foreign(l�kken). 
foreign(l�nset). 
foreign(l�psmark). 
foreign(l�psmarka).
foreign(l�renfallet). %%  ?
foreign(l�renskog). 
foreign(l�ten). %%  \+ L�ften
foreign(l�venstad).
foreign(l�vset). 
foreign(madla). 
foreign(magerholm).  
foreign(magnor). 
foreign(maihaugen).
foreign(majorstua). 
foreign(majorstuen). 
foreign(malm). 
foreign(malmefjorden). 
foreign(malm�ya). 
foreign(malvik). 
foreign(mandal). 
%% foreign(manger).  %% mange ? %% TA-110125
foreign(manglerud).
foreign(manndalen).
foreign(mannsverk).
foreign(manstad).
foreign(marikoven). 
foreign(mastemyr). 
foreign(matre).  
foreign(mebygda). 
foreign(medkila). 
foreign(mefjordv�r). 
foreign(meg�rd). 
foreign(mehamn). 
foreign(melbu). 
foreign(meldal). 
foreign(melhus). 
foreign(meling). 
foreign(melsom). 
foreign(melsomvik).
foreign(mer�ker). 
foreign(mesnali). 
foreign(midtbygda). 
foreign(midtsand). 
foreign(midtsanden). 
foreign(midtstuen).
foreign(midttun). 
foreign(milde).   %% Bergen/Fana?
foreign(minde). 
foreign(minnesund).
foreign(mj�land).   %% (?)
foreign(mj�mna).   
foreign(mj�ndalen). 
%% foreign(maridalsveien).  %% oslo 
foreign(mariero).  
foreign(moa). 
foreign(mo_i_rana). 
foreign(modalen). 
foreign(moelv). 
   foreign(moelven).  %% ?
foreign(moensletta).
foreign(moi).         %% Rogaland
foreign(moland). 
foreign(molde). 
foreign(molnes). 
foreign(momarka). 
foreign(momarken). 
foreign(momoen). 
foreign(mongstad).
foreign(montebello). %% TA-100519
foreign(mortensnes). 
foreign(mortensrud).
foreign(morvik). 
foreign(mosby).
foreign(mosj�en). 
foreign(moskog). 
foreign(moss). 
foreign(mosseporten). 
foreign(mosser�d).
foreign(mostadmarka). 
foreign(mosvik). 
foreign(mosvika). 
foreign(moum). 
foreign(movik).  
foreign(muruvik). 
foreign(muruvika). 
foreign(myre).   
foreign(myrland).
foreign(myrv�g). 
foreign(mysen). 
foreign(m�l�y). 
foreign(m�ndalen). 
foreign(m�re). 
foreign(m�re_og_romsdal). 
foreign(m�rkved).  %% (Bod�) 
foreign(m�vik).   

foreign(nabbetorp). 
foreign(nadderud). 
foreign(nadderudjordet). 
foreign(nakkerud). 
foreign(namdal). 
foreign(namdalen). 
foreign(namdalseid). 
foreign(namskogan). 
foreign(namsos). 
foreign(namsskogan). 
foreign(nannestad). 
foreign(nanset). 
foreign(narvik). 
foreign(nasjonalteateret). 
foreign(nationalteateret). 
foreign(nationaltheateret). 
foreign(nasjonalteatret). 
foreign(nationalteatret). 
foreign(nationaltheatret). 
foreign(naustdal). 
foreign(nenset).
foreign(nesbru). 
foreign(nesbyen). 
foreign(neshov). %% :-) %% BerlPop
foreign(neskollen). 
foreign(nesna). 
foreign(nesodden). 
foreign(nesoddtangen). 
foreign(nessane).  
foreign(nesset). 
foreign(nestun).  
foreign(nesttun). 
foreign(nes�ya). 
foreign(nipedalen). 
foreign(nittedal). 
foreign(nodeland). 
foreign(nodelandsheia). 
foreign(nordagutu).   %% TA-101206
foreign(nordby). 
foreign(nordbyen). 
foreign(nordfjord). 
foreign(nordfjordeid).
foreign(nordheimsund). 
foreign(nordkapp). 
foreign(nordkisa). 
foreign(nordkjosbotn).
foreign(nordland). 
foreign(nordlandet).
foreign(nordmarka).  %% (Oslo)
foreign(nordmela). 
foreign(nordnes). 
foreign(nordnorge). 
foreign(nordstrand). 
foreign(nordtr�ndelag). 
foreign(nordv�gen). 
foreign(nord�s).  
foreign(norefjell). 
foreign(noresund). 
foreign(norfjord).  %%
foreign(norge).  %% Force error message
foreign(norheim). 
foreign(norheimsund). 
foreign(norway). 
foreign(notodden). 
foreign(nybu).     
foreign(nyjordet). 
foreign(nykirke).  
foreign(nyland). %% \+ Nypan %% TA-110816
foreign(nummedal). 
foreign(nummedalen). foreign(numedalen). foreign(numedal). 
foreign(nybergsund). foreign(nybersund). 
foreign(nypvang). 
foreign(nystrand). 
foreign(n�rb�).  
foreign(n�rsnes).  
foreign(n�kkeland).
foreign(n�ste). 
foreign(n�tter�y).

foreign(odal). 
foreign(odalen). 
foreign(odda). 
foreign(oddevall). 
  foreign(oerland). 
  foreign(oeysand). 
foreign(ofoten).  %% TA-100905
foreign(ogndal). 
foreign(okkenhaug). 
foreign(oksvoll). 
foreign(olderfjord).
foreign(olrud).  
foreign(olso). %% oslo 
foreign(olsvik). 
foreign(olsvika).
foreign(oltedal). 
foreign(ons�y). 
foreign(omre).  
foreign(opaker).
foreign(opdal). 
foreign(oppdal). 
foreign(oppeg�rd). 
foreign(oppeid). 
foreign(oppsal). 
foreign(opstad).   %%  \+ okstad
foreign(opsund).   
foreign(oredalen).
foreign(orkanger). 
   foreign(organger). 
   foreign(orkager). 
foreign(orkdal). 
foreign(orkdalen). 
foreign(orker�d). 
foreign(orkganger). 
foreign(orm�sen). 
foreign(os). 
foreign(oslo). 
foreign(oster�y).  
foreign(os�yro). 
foreign(otta). 
foreign(otter�ya). 
foreign(ottestad).  %% (case)
foreign(overhalla). 
foreign(oysand). 

foreign(paradis). %% Bergen 
foreign(persbr�ten).  
foreign(pilestredet).  %% Oslo
foreign(polarsirkelen). 
foreign(porsgrunn). 
foreign(portland). 
foreign(prinsdal).
foreign(prostneset). 
foreign(radiumhospitalet). 
foreign(ragde).  %% Odda
foreign(raillkattlia).  %% :-)
foreign(rakkestad). 
foreign(rakv�g). 
foreign(r�kv�g). 
    foreign(r�kv�gen). 
foreign(ramberg). 
foreign(ramdal).
foreign(ramfjord). 
foreign(ramstein). 
foreign(rams�y). 
foreign(rana). 
foreign(ranavik).
foreign(randaberg). 
foreign(randesund). 
foreign(raufoss). 
foreign(ravnanger). 
foreign(ra�ros).  
foreign(refsnes). 
foreign(reinsvoll). 
foreign(rein�s). 
foreign(rein�ya). 
foreign(reistad). 
foreign(rena). 
foreign(rendalen). 
foreign(rennebu). 
foreign(rennes�y). 
foreign(rensvik). 
foreign(revetal). 
foreign(revheim).
foreign(revsnes). 
foreign(ridabu). 
foreign(rindal). 
foreign(rindalen). 
foreign(rindalsskogen). 
foreign(ringebu). 
foreign(ringsaker). 
foreign(ringstabekk).
foreign(rinndal). 
foreign(rinndalen). 
foreign(ris).  %% oslo, \+  RIT
foreign(risl�kka). 
foreign(rissa). 
foreign(ris�r). 
foreign(ris�y).  
foreign(rjukan). 
foreign(roa). 
foreign(roan). 
foreign(robergr�nningen). 
foreign(robru). 
foreign(rogaland). 
foreign(rognan). 
foreign(rolvsrud). 
foreign(rolvs�y).  
foreign(romedal).  
foreign(rommetveit). 
foreign(romsdal). 
foreign(romsdalen). 
foreign(roms�s). 
foreign(rondane). 
foreign(ropeid).  
foreign(roros).
foreign(rosseland). 
foreign(rosenhoff).
foreign(rossfjord). 
foreign(rotnes).    %%  Nittedal
foreign(roverud).  
foreign(rubbestadneset).  %% ?
foreign(rud). 
foreign(rudsh�gda). 
foreign(ruggevik). 
foreign(ruggevika). %% ? 
foreign(rugsund).   
foreign(rullestad). 
%% foreign(rye).    %% ? station 
foreign(ryen). %% TA-100828
foreign(ryfylke). %% TA-101101
foreign(rygge).
foreign(rykene). 
foreign(rykkin). 
foreign(rykkinn). 
foreign(rysjedalsvika). 
foreign(r�lingen).
foreign(r�a).  %% Oslo
foreign(r�bekk).  %% Molde?
foreign(r�dberg).
foreign(r�dde). 
foreign(r�dhammer).  %%?
foreign(r�dsj�). 
foreign(r�dsj�en). 
foreign(r�dtvedt). 
foreign(r�dtvet). 
foreign(r�nvik). 
   foreign(r�nvika). 
foreign(r�ren). 
foreign(r�ros). 
foreign(r�rvik). 
foreign(r�yken). 
foreign(r�yse).  
foreign(r�yslimoen).
foreign(r�de).  
foreign(r�dhusplassen).  %% Oslo
foreign(r�holt).  %% Eidsvoll 
foreign(r�n�sfoss). 

foreign(sagdalen). 
foreign(sagene). 
foreign(sagstua).  
foreign(sagv�g). 
foreign(saksvik). 
foreign(saksvikvollen). 
foreign(salhus).  
foreign(salten). 
foreign(saltnes). 
foreign(saltr�d).  
foreign(saltstraumen). 
foreign(samdal).  
foreign(samuelsberg). 
foreign(sandaker).
foreign(sandal).   
foreign(sandane). 
foreign(sande). 
foreign(sandefjord). 
foreign(sandeid). 
foreign(sanderud). 
foreign(sandnes). 
foreign(sandnesj�en). 
foreign(sandnessj�en). 
foreign(sandsli). 
foreign(sandstad). 
foreign(sandve). 
foreign(sandved). 
foreign(sandvika). 
foreign(sandviken).  %%?
foreign(sandviksberget). 
foreign(sandvikv�g).
foreign(sandvolden).
foreign(sandvollan).  %%?
foreign(sarpsborg). 
foreign(sauda). 
foreign(saudal).  %%?
foreign(savalen). %% ? 
foreign(seiersten).
foreign(sel). 
foreign(selbj�rn). 
foreign(selbu). 
foreign(selbusj�en). 
foreign(selbustrand). 
foreign(selfors). 
foreign(selje).  
foreign(seljestad). 
foreign(seljord). 
foreign(selli). 
foreign(selnes). 
foreign(sem). 
foreign(senjahopen). 
foreign(sessvollmoen). 
foreign(setemsdalen). 
foreign(setermoen). 
foreign(setesdal). foreign(s�tesdal). 
foreign(settemsdalen). 
foreign(sevland). 
foreign(siggerud).
foreign(silsand). 
foreign(sings�s). 
foreign(sinsen). foreign(sinsenkrysset). 
foreign(sira).  
foreign(sirdalen).
foreign(sistranda). 
foreign(sjoa). 
foreign(sjusj�en). 
foreign(sj�holt). 
foreign(sj�lyst). 
foreign(sj�lystveien).  %% (Oslo)
foreign(sj�rdal). 
foreign(sj�rdalen). 
foreign(sj�vold).  %% ?
foreign(sj�voll). 
%% foreign(sj�v�g).  
foreign(sj�stad).   
foreign(skage).       %% namsos
foreign(skallestad).
foreign(skallevold). 
foreign(skarb�vik). 
foreign(skarnes).  
foreign(skarnsund). 
foreign(skarpnes). 
foreign(skarpsno).
foreign(skattval). 
    foreign(skatval). 
foreign(skaug). 
foreign(skaugum). 
foreign(skaun). 
foreign(skedsmo). 
foreign(skedsmokorset). 
foreign(skei). 

    foreign(ski). %% comm Akershus  / luggage

foreign(skibotn). 
foreign(skien). 
foreign(skillebekk). 
foreign(skinst�). 
foreign(skivika). 
foreign(skjeberg). 
foreign(skjebstad). 
foreign(skjelsvik). 
foreign(skjerstad). 
foreign(skjerv�y). 
foreign(skjetten). 
foreign(skjold). 
foreign(skjolden). 
foreign(skj�rviken). 
foreign(skj�rhalden). 
foreign(skj�k).   
foreign(skodje).   %% kommune
foreign(skoger).   %% TA-110214 
foreign(skogly). 
foreign(skogn). 
foreign(skogsv�g). 
foreign(skonseng). 
foreign(skoppum). 
foreign(skorpa).   
foreign(skotfoss). 
foreign(skotselv). 
foreign(skotterud). 
foreign(skredder�sen). 
foreign(skreia).
foreign(skrimsletta). 

foreign(skudesnes). %
foreign(skudeneshavn). %
foreign(skudesneshavn). 
foreign(skui).  %% B�rum
foreign(skullerud). %% oslo 
foreign(sk�la). %% Molde
foreign(sk�levik). 
foreign(sk�rer). 
foreign(sk�yen).  %% oslo
foreign(slattum).
foreign(slemdal). 
foreign(slemmestad).
foreign(slependen). 
foreign(slettaelva).  
foreign(sletten).   
foreign(slettheia).  
foreign(slevik). 
foreign(slidre). 
foreign(slitu).  %% ?
foreign(slottet).  %% oslo
foreign(sl�stad).  
foreign(sl�ttaelva).
foreign(sl�ttnes). 
foreign(smeby).   
foreign(smedstua).  
foreign(smertu). 
foreign(smestad).  %% oslo
foreign(smiskaret).
foreign(sm�la). 
foreign(sm�r�s).  
foreign(snartemo). 
foreign(snarum).  %% ?
foreign(snar�ya). 
foreign(snillfjord). 
foreign(snippen). 
foreign(sn�sa). 
foreign(sofiemyr). %% TA-100902 ?
foreign(sofienberg).
foreign(sogn). 
foreign(sogn_og_fjordane). 
foreign(sogndal). 
foreign(sognefjord). 
foreign(sokna). 
foreign(soknadalen). 
foreign(sokndal). 
foreign(sokndalen). 
foreign(soknedal). 
foreign(soknedalen). 
foreign(sola).  %% (in Rogaland)
foreign(solheim). 
foreign(solheimsviken).
foreign(solum).  
foreign(solumstua).
foreign(solvollen). 
foreign(sol�r). 
foreign(sol�sen). 
foreign(sommerro). %% TA-100519
foreign(son).    
foreign(sortland). 
foreign(sotra). 
foreign(spanne).
foreign(sparbu). 
foreign(spikkestad). 
foreign(spjelkavik). 
foreign(spydeberg). 
foreign(stabbursmoen). 
foreign(stabekk). 
foreign(stadsbygd). 
foreign(stadsbygda). 
foreign(stadt). 
foreign(stakkevollan).  %% ?
foreign(stalheim).  
foreign(stamnan). 
foreign(stamsund). 
foreign(stange). 
foreign(stangeland). 
foreign(stangnes). 
foreign(stathelle).
foreign(statthelle).   
foreign(statsbygd). 
foreign(statsbygda). 
foreign(staub�). 
foreign(stav).  %% malvik/hommelvik
% foreign(stavanger). 
foreign(stavern). 
foreign(stavsj�). %% TA-110502
foreign(stavs�ra). 
% foreign(steigen). 

foreign(steinkjer). %% community
foreign(stenkjer).
foreign(steikjer). 
foreign(steinker). 
foreign(steinskjer). 

foreign(steinsland).  
foreign(steinsvik).  
foreign(steinsviken). 

foreign(steinkjersannan). 
foreign(steinrusten).  
foreign(steinvikholmen). 
foreign(steinviksholmen).  
foreign(stig).  %% TA-110520
foreign(stiklestad). 
% foreign(stj�rdal). 
   foreign(stjoerdal). 
   foreign(stjordal). 
   foreign(stj�rdalen). 
foreign(stj�rdalhalsen). 
foreign(stj�rdalshalsen). 
foreign(stokke). 
foreign(stokmarknes). %%  kk
foreign(stokksund). 
foreign(stokk�sen). 
foreign(stokk�ya). 
foreign(stord). 
foreign(stordal). 
foreign(stordalen).
foreign(storeb�). 
foreign(storelv). 
foreign(storelva).
foreign(storetveit).
foreign(storforshei). 
foreign(storfosna). 
foreign(storgata).  %% \+ (Thora) Storms_street 
foreign(storgaten). 
foreign(storhaug). 
foreign(storhove). 
foreign(storjord).  
foreign(storlia). 
foreign(storlien).  %% Almost Norwegian :-)
foreign(stormyr). 
foreign(stormyra). 
foreign(stornes).
foreign(storo).   %%  Oslo 
foreign(storoddan). 
foreign(storsand). 
foreign(storskogen).
foreign(storslett). 
foreign(storsteinnes). 
foreign(stortinget). 
foreign(stortorvet).  %% Oslo ???
foreign(stor�s). 
foreign(stovner). 
 foreign(strai). 

foreign(stranda). %% community // unwanted (strinda)
foreign(strandafjellet). 
foreign(strandebarm). 
foreign(straume). 
foreign(straumen). 
foreign(straumgjerde). 
foreign(straumsbukta). 
foreign(straumsnes). 
foreign(stridskleveien). 
foreign(strusshamn). 
foreign(stryn). 
foreign(str�mmen). 
foreign(str�msdalen).
foreign(str�msnes). 
foreign(str�msveien). 
foreign(str�ms�).   
foreign(str�tvet).   
foreign(stuer�d).   
foreign(stuggudal). 
foreign(stugudal). 
foreign(stugudalen). 

foreign(st�). 
foreign(st�botn). 
foreign(st�ren). 
    foreign(st�rn). 
foreign(st�rheim). 
foreign(sula). 
foreign(suldalen). 
foreign(sulesund).
foreign(sulitjelma). 
foreign(sundalsora). 
foreign(sundals�ra). 
foreign(sunde). 
foreign(sundvolden). %% TA-110113 hotels etc
foreign(sundvollen). %% place
foreign(sunnan).     %%-steinkjer
foreign(sunndal). 
foreign(sunndalen). 
foreign(sunndalsora). 
foreign(sunndals�ra). 
foreign(sunnfjord). 
foreign(sunnhordaland).
foreign(sunnm�re). 
foreign(surnadal). 
foreign(surnadalen). 
foreign(surnadaln). 
foreign(surndal). 
foreign(survika). 
foreign(svarttjern). 
foreign(svea).
foreign(sveberg). 
foreign(sveberget).
foreign(svebergkrysset). 
foreign(sveggen).
foreign(sveggesundet).
foreign(sveh�gda). 
foreign(sveio).   
foreign(svelgen).
foreign(svelvik). 
foreign(svensenga). 
foreign(svinesund). 
foreign(svolv�r). 
foreign(svorkmo). 
foreign(svortland). 
foreign(sykkylven). 
foreign(sylan).  
foreign(sylling). 
foreign(syrbekk).
foreign(syvde).
foreign(s�by). 
foreign(s�b�).  
foreign(s�lbu). 
foreign(s�tre).   
foreign(s�vollen). 
foreign(s�bakken).
foreign(s�berg).   %% ? i Th ?
foreign(s�fteland). 
foreign(s�gne). 
foreign(s�m). 
foreign(s�mna).
foreign(s�reide). 
foreign(s�rfron). 
foreign(s�rkedalen). %% Oslo 
foreign(s�rland). 
foreign(s�rlandet). 
foreign(s�rlandsparken).
foreign(s�rli).  
foreign(s�rreisa).
foreign(s�rrollnes).
foreign(s�rskogbygda). 
foreign(s�rum). 
foreign(s�rumsand).
foreign(s�rvik).   
foreign(s�rv�gen). 
foreign(s�r�ya).   
foreign(s�vassli). 
foreign(s�vasslia). 
foreign(s�vik). 
foreign(s�lsnes).



foreign(taft�ysundet).  %% ?
foreign(tambartun).  
foreign(tana). 
foreign(tananger). 
%% foreign(tanberg).  
foreign(tandberg).  %%
foreign(tanem).  %% ( Kl�bukomm. ) 
foreign(tangen). %% TA-110818
foreign(tangen�sen).
foreign(tangvall). 
foreign(tasta).
foreign(tau). 
foreign(tautra). 
foreign(teieh�yden). 
foreign(telav�g). %% TA-110311
foreign(telemark). 
foreign(tennfjord). 
foreign(tenvik). 
foreign(terningmoen).
foreign(terr�k). 
foreign(tertnes). 
foreign(tingvoll). foreign(tingvold). 
foreign(tinnheia). 
foreign(tistedal). 
foreign(titran). 
foreign(tjeldbergodden).  
foreign(tjelta).
foreign(tjensvoll). 
foreign(tj�me). 
foreign(tj�rv�g).
foreign(tj�tta). 
foreign(tofte). 
foreign(tolga). 
foreign(tollnes). %% \+ tone %% TA-110415
foreign(tomter). 
foreign(tonsenhagen). 
foreign(tons�sen).  %% TA-100519
foreign(tornes).
foreign(torp). 
foreign(torshov).  %% Oslo
foreign(torvastad). 
foreign(tor�d).
foreign(toten). 
foreign(tranby). 
foreign(trasop).
foreign(trastad). 
foreign(tresfjord). 
foreign(treungen). 
foreign(trofors). 
foreign(trollheimen). 
foreign(trollveggen).
foreign(trollvik). 
foreign(troms). 
foreign(tromsdalen). 
foreign(tromstun). 
foreign(troms�). 
foreign(trom�y).  
foreign(trom�ya). 
foreign(trondenes). 
foreign(trondheimsfjorden). 
foreign(trondheimsveien).  %% Oslo
foreign(trondhjemsfjorden). 
foreign(tronvik).
foreign(trosterud). 
foreign(trysil). 
foreign(tryvann). 
    foreign(t�gstad).  %% avoid -> toyaota amble#
%% foreign(tr�ndelag).  %% tr�ndealg folkemuseum (miss spellcorr) 
foreign(tr�stad). 
foreign(tsj�rdal). %% ?
foreign(tufsingdalen). 
foreign(tullinl�kka).
foreign(turtagr�). 
foreign(tusenfryd).  %% (OSL)
foreign(tustna). 
foreign(tvedestrand). 
foreign(tveit).  
foreign(tveita).  
foreign(tverlandet). 
foreign(tydal). 
foreign(tyin).  
foreign(tylldalen). 
foreign(tynset). 
foreign(tynseth). 
foreign(tyrifjord).
foreign(tyristrand). 
foreign(tysnes). 
foreign(t�mmerdalen). 
foreign(t�mmerst�). %% Kr.Sand %%
foreign(t�mmerv�g). 
foreign(t�mra).  %% (selbu)
foreign(t�nsberg). 
foreign(t�yen). 
foreign(t�rn�sen). 
foreign(t�rnelv). 
foreign(t�sen).   

foreign(udduvoll). 

foreign(uib). %% Universitetet i B
foreign(uio).
foreign(uis).

foreign(ulefoss). 
foreign(ullandhaug). 
foreign(ullevaal). 
foreign(ullev�l). 
foreign(ullset). 
foreign(ullstad). 
foreign(ulnes). 
  foreign(ullsberg). 
foreign(ulsberg). 
foreign(ulset). 
foreign(ulsetsanden).
foreign(ulsrud). 
foreign(ulstad). 
foreign(ulsteinvik). 
foreign(ullsteinvik). 
foreign(ulven). 
foreign(ulv�ya). 
foreign(underlia). 
foreign(uranienborg). 
foreign(uskedal).
    foreign(uskedalen).
foreign(utby). 
%% foreign(utg�rd). %% ? 
foreign(utg�rdskilen).
foreign(uthaug).
foreign(utne).  
foreign(utskarpen). 
foreign(ut�y). 
foreign(uvdal).
foreign(uvesund).

foreign(vadheim). 
foreign(vadmyra). 
foreign(vads�). 
foreign(vaker).  
foreign(vaksvik). 
foreign(valangen). 
foreign(valder�y).
foreign(valdres). 
foreign(valhall). %% TA-101005 :-)
foreign(valestrand). 
foreign(valldal). 
foreign(valle). 
foreign(valler). 
foreign(vallersund). 
foreign(vallerud).   
foreign(vallesverd). 
foreign(vals�y). 
foreign(vals�ybotn). 
foreign(vals�ybotten). 
foreign(vals�yfjord). 
foreign(vang). 
foreign(vannvikan). foreign(vanvikan). foreign(vanvika). 
foreign(vannv�g). 
foreign(vanse).   
foreign(vanvik). 
foreign(varanger).
foreign(varatun). 
foreign(vardenes). 
   foreign(vardeneset). 
foreign(vard�).   
foreign(vard�sen).
foreign(varingskollen).
foreign(varmdal). 
foreign(vartdal). 
foreign(varteig). 
foreign(vassdal). 
foreign(vassdalen). 
foreign(vassenden). 
foreign(vassfjellet). 
foreign(vassmyra). 
foreign(vatne). 
foreign(vats). 
foreign(vedav�gen). 
foreign(vefsn).  
foreign(veggli). 
foreign(vegsund). 
foreign(veg�rdshei). 
foreign(veitvedt). 
foreign(veitvet). 
foreign(vemestad). 
foreign(venjaneset). 
foreign(vennberg). 
foreign(vennersberg).
foreign(venner�d). %% TA-110411
foreign(vennesla). 
foreign(vennesland). 
foreign(vennesund). 
foreign(veldre).  
foreign(verdal). foreign(verdalen). foreign(v�rdal). 
foreign(verdals�ra). foreign(v�rdals�ra). 
foreign(verningen). 
foreign(vestagder). 
foreign(vestby). 
foreign(vester�y). 
foreign(vester�len). 
foreign(vestfold). 
foreign(vestfossen).
foreign(vestlandet). 
foreign(vestmarka).  %% (B�rum?)
foreign(vestnes). 
foreign(vestskogen). 
foreign(vettre). 
foreign(veum). %% Fr.stad 
foreign(vevik). 
foreign(viddalen).
foreign(vigeland). 
foreign(vigmostad). 
foreign(vigra). 
foreign(vigrestad). 
foreign(viggja). 
foreign(vika).  %% (?)
foreign(vikebukt). 
foreign(vikammer�sen). 
foreign(vikbygd). 
foreign(vikedal).
foreign(vikeland). 
foreign(vikersund). foreign(vikersundbakken). foreign(vikersundsbakken). 

foreign(vikhamar). 
foreign(vikhamaren).  
foreign(vikhamarn). 
foreign(vikhammar). 
foreign(vikhammaren). 
foreign(vikhammarn). 
foreign(vikhamer). 
foreign(vikhammer).
foreign(vikhammeren). 

foreign(vikhammer�sen). 
foreign(vikhov). 
foreign(vikvarvet). 
foreign(vikran).  
foreign(vilberg). 
foreign(vinderen). 
foreign(vindern).  
foreign(vindmyr).  
   foreign(vindsmyr). 
foreign(vind�la). 
foreign(vingesand). 
foreign(vingrom). 
foreign(vinje).    %% also company in trh
foreign(vinje�ra). 
foreign(vinstra). 
foreign(vinterbro).  
foreign(vippetangen). 
foreign(vivestad). 
foreign(voksenkollen). %% oslo 
foreign(volda). 
foreign(volden). 
foreign(vollebekk). 
foreign(volleberg). 
foreign(vollevannet). 
foreign(volvat). 
foreign(vormedal). 
foreign(vormstad). 
foreign(vormsund).  
foreign(voss). 
foreign(vr�liosen). 
foreign(v�rholmen). 
foreign(v�rran). %% Bodo+ dial verran 
foreign(v�gan). 
foreign(v�ge).  
foreign(v�gen).  %% \+ vegen
foreign(v�gland).  %% Halsa
foreign(v�gsbotn).
foreign(v�gsbygd). 
foreign(v�gsbygda). 
foreign(v�gstranda). 
foreign(v�g�). 
foreign(v�ler). 
foreign(v�lerenga). 
foreign(v�dal). 
foreign(v�rdal). 
foreign(v�rdalen). 
%% foreign(v�rnes). %% airport
foreign(v�yen). foreign(v�yenenga). 

foreign(ytteren).

foreign(�deg�rd). 
foreign(�deg�rdsh�gda). 
foreign(�isand). 
foreign(�kland). %% TA-110609
foreign(�kern). 
foreign(�ksnevad). 
foreign(�land). 
foreign(�len).  
foreign(�raker).  
foreign(�rje). 
foreign(�re�sen). 
    foreign(�r�sen). %% 
foreign(�rland). 
foreign(�rlandet). 
foreign(�rnes).
foreign(�rskog). 
foreign(�rsta). 
foreign(�stby).    
foreign(�stbyh�gda). 
foreign(�stensj�).  %% TA-110325
foreign(�sterdalen). 
foreign(�stskogen). 
foreign(�ster�s). %% B�rum 
foreign(�stfold). 
foreign(�stlandet). 
foreign(�stsiden). %% Also eastside 
foreign(�verbygd). 
foreign(�vrevoll). 
foreign(�yenkilen). 
foreign(�yer).
foreign(�ygarden). 
foreign(�ysand). 
foreign(�ysandan). 
foreign(�ysanden). 

foreign(�dland). 
foreign(�farnes). 
foreign(�fjor). 
foreign(�fjord). 
foreign(�fjorden). 
%% foreign(�fjoren). 
foreign(�foss). 
foreign(�gotnes). 
foreign(�knes). 
foreign(�kra). 
foreign(�krehamn). 
foreign(�l). 
foreign(�lefj�r). 
foreign(�len). 
foreign(�lesund). 
foreign(�lg�rd). 
foreign(�lsund). 
foreign(�lvik).
foreign(�lvundeid). 
foreign(�lvundfjord). 
foreign(�mdalen). 
foreign(�mli). 
foreign(�mot). 
foreign(�m�y). 
foreign(�ndalsnes). foreign(aandalsnes). 
foreign(�neby). %% \+ arneby %% Nittedal
foreign(�nes). 
foreign(�nesmyra).
foreign(�n�ya). 
foreign(�rdal). 
foreign(�rdalstangen). 
foreign(�re). 
foreign(�rnes). 
foreign(�ros). 
foreign(�rstad).
foreign(�rvoll). 
foreign(�r�). 
foreign(�s). 
foreign(�sbyen). 
foreign(�sbygda). 
foreign(�sane). 
foreign(�sen). 
foreign(�seral). 
foreign(�sg�rd). %% TA-110822
foreign(�sg�rdstrand). 
foreign(�sjordet). %% B�rum %% TA-101105
foreign(�skollen). 
foreign(�ssiden). 
foreign(�stad). 
foreign(�stun).
foreign(�stveit). 

%% ALIAS_NAME

alias_name('44a',44). 
alias_name('4a',4).
alias_name('5e',5). 
alias_name('6e',6). 
alias_name('7a',7). 
alias_name(dv,dragvoll). 
alias_name(kl�buruta,kl�buruten). 
alias_name(linje1,trikken). 
alias_name(team,tt). 
alias_name(teamtrafikk,tt). 

alias_station(lade_alle_80,lade). %% TA-100802 old station-> neib

alias_station(berg_�stre,�stre_berg). %% AtB


alias_station(dv,dragvoll). 

%%% PLACE_RESOLVE

place_resolve(badestranda,korsvika). 
place_resolve(badestranda,�ysand). 

%% place_resolve(bakli,baklia). 
%% place_resolve(bakli,blakli). 

place_resolve(berg,berg_presteg�rd).
place_resolve(berg,berg_studentby).
place_resolve(berg,�stre_berg).

place_resolve(charlottenlund,charlottenlund_kirke). 
place_resolve(charlottenlund,charlottenlund_nedre). 
place_resolve(charlottenlund,charlottenlund_skole). 
place_resolve(flybussterminalen,lerkendal_stadion). 
place_resolve(flybussterminalen,royal_garden). 
place_resolve(flybussterminalen,studentersamfundet). 
place_resolve(flybussterminalen,ts). %% AtB. 
place_resolve(hageby,br�set_hageby). 
place_resolve(hageby,dalen_hageby). 
place_resolve(hageby,strindheim_hageby). 
place_resolve(hist,�stre_berg).  %%T�H
place_resolve(hist,gartnerhallen).  %%AMT
place_resolve(hist,gildheim).  %%AHS
place_resolve(hist,rotvoll_alle).  %%ALT
place_resolve(hist,rotvoll_nedre).  %%ALU
place_resolve(hist,torget).  %%AiTel
place_resolve(kino,nova_kinosenter).  %%
place_resolve(kino,prinsen_kinosenter). 
place_resolve(kino,rosendal). 
place_resolve(ntnu,dragvoll). 
place_resolve(ntnu,gl�shaugen).  %% try without Gl�sS
place_resolve(presteg�rden,berg_presteg�rd). 
place_resolve(presteg�rden,presteg�rsjordet).  %%g�rdj
place_resolve(rutebilstasjonen,hovedterminalen). 
place_resolve(rutebilstasjonen,leuthenhaven). 
place_resolve(rutebilstasjonen,ts). %% AtB. 
place_resolve(solbakken,solbakken_bru). 
place_resolve(solbakken,solbakken_skole).  %%solbakken->solbakken_bruaftersummer06,

place_resolve(sorgendal,lerkendal). 
place_resolve(sorgendal,sorgenfri). 

place_resolve(strinda,strinda_kirke).   
place_resolve(strinda,valentinlystveien). 

place_resolve(studentbyen,berg_studentby). 
place_resolve(studentbyen,moholt_studentby). 
place_resolve(studentbyen,presteg�rdsjordet).  %% lerkendal studentby
place_resolve(studentbyen,vestlia).  %% steinan studentby
place_resolve(studentbyen,voll_studentby). 

/*  = godsterminalen_nsb
place_resolve(terminalen,terminalen). 
place_resolve(terminalen,hovedterminalen). 
place_resolve(terminalen,postterminalen). 
place_resolve(terminalen,ts). %% AtB. 
*/

place_resolve(universitetet,dragvoll). 
place_resolve(universitetet,gl�shaugen). 
place_resolve(university,dragvoll). 
place_resolve(university,gl�shaugen). 
place_resolve(vegmesterveien,vegmesterstien). 
place_resolve(vegmesterveien,veimester_kroghs_street). 


%%
