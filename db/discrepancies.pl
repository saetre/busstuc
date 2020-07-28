/* -*- Mode:Prolog; coding:utf-8; -*- */
%% RS-130625    %% RS-131229 Compiled by monobus.pl

%%% RS-111205, UNIT: /app/
% Some predicates (like addcontext/0) are only to preserve information, no filtering..
:-module( discrepancies, [ alias_station2/3 ] ).

%%% db/discrepancies r1601_160815 r1601_160620 
%alias_station2(16010384,engstrømbakken,ranheim_skole).
%alias_station2(16011384,engstrømbakken,ranheim_skole).
%alias_station2(16533184,øye,øie_skole).
%alias_station2(16538544,øye,øie_skole).
%
%%% RS 2015.12.19
%%% db/discrepancies r1603_151012 r1611_151214
%alias_station2(16010006,dr_gate_d1,dronningens_gate_d1).
%alias_station2(16010007,dr_gate_d2,dronningens_gate_d2).
%alias_station2(16010111,grilstadveien,grilstadvegen).
%alias_station2(16010121,peder_myhres_vei,peder_myhres_veg).
%alias_station2(16010157,a_jenssens_veg,anton_jenssens_veg).
%alias_station2(16010186,hurtigbåtterm,hurtigbåtterminalen).
%%alias_station2(16010240,kvenilds_veg,kvenildvegen).
%alias_station2(16010240,kvenildvegen,kvenilds_veg).
%alias_station2(16010253,ladejarlen_v_g_s,ladejarlen_vgs).
%alias_station2(16010266,lohove,lohove_snuplass).
%alias_station2(16010309,j_minsaas_veg,johannes_minsaas_veg).
%alias_station2(16010357,osveien,osvegen).
%alias_station2(16010376,prof_brochs_gate,professor_brochs_gate).
%alias_station2(16010395,risvollveien,risvollvegen).
%alias_station2(16010420,ada_arnfinsens_v,ada_arnfinsens_veg).
%alias_station2(16010446,hvs,heimdal_vgs).
%alias_station2(16010495,tiller_v_g_s,tiller_vgs).
%alias_station2(16010517,isdamveien,isdamvegen).
%alias_station2(16010603,traneveien,tranevegen).
%alias_station2(16011111,grilstadveien,grilstadvegen).
%alias_station2(16011121,peder_myhres_vei,peder_myhres_veg).
%alias_station2(16011157,a_jenssens_veg,anton_jenssens_veg).
%alias_station2(16011240,kvenilds_veg,kvenildvegen).
%alias_station2(16011253,ladejarlen_v_g_s,ladejarlen_vgs).
%alias_station2(16011309,j_minsaas_veg,johannes_minsaas_veg).
%alias_station2(16011357,osveien,osvegen).
%alias_station2(16011376,prof_brochs_gate,professor_brochs_gate).
%alias_station2(16011446,hvs,heimdal_vgs).
%alias_station2(16011456,s_jorsalfars_v,sigurd_jorsalfars_vei).
%alias_station2(16011495,tiller_v_g_s,tiller_vgs).
%alias_station2(16011603,traneveien,tranevegen).
%alias_station2(16386168,orkanger_skyss,orkanger_skysstasjon).
%alias_station2(16386218,orkdal_barne_h,orkanger_barnehage).
%alias_station2(16389168,orkanger_skyss,orkanger_skysstasjon).
%alias_station2(16389218,orkdal_barne_h,orkanger_barnehage).
%alias_station2(16533040,brekkåsen_snpl,brekkåsen_snuplass).
%alias_station2(16574021,nygård,sanden).
%alias_station2(16574030,skaun_ungdomskole,skaun_ungdomsskole).
%alias_station2(16578721,nygård,sanden).
%alias_station2(16632033,hommelvik_bom_st,hommelvik_bomstasjon).
%alias_station2(16638333,hommelvik_bom_st,hommelvik_bomstasjon).
%alias_station2(17142086,tr_heim_lufthavn,trondheim_lufthavn).
%alias_station2(17142583,halsen_ung_skole,halsen_ungdomsskole).

%alias_station2(16010000,breidablikk_trikk,breidablikk).
%alias_station2(16010023,strindheim_2,brannstasjon_øst).
%alias_station2(16010254,ladeveien,ladevegen).
%alias_station2(16010272,lundåsen_nordre,lundåsen_n).
%alias_station2(16010309,j_minsaa_s_veg,johannes_minsaas_veg).
%alias_station2(16010482,søndre_hallset,søndre_halset).
%alias_station2(16010706,munkvoll_trikk,munkvoll).
%alias_station2(16010712,nyveibakken_trikk,nyveibakken).
%alias_station2(16011000,breidablikk_trikk,breidablikk).
%alias_station2(16011023,strindheim_2,brannstasjon_øst).
%alias_station2(16011196,bergheim_snuplass,bergheim_snpl).
%alias_station2(16011347,olav_tryggvasons_gate,olav_trygvassons_gate).
%alias_station2(16011482,søndre_hallset,søndre_halset).
%alias_station2(16011706,munkvoll_trikk,munkvoll).
%alias_station2(16011712,nyveibakken_trikk,nyveibakken).
%alias_station2(16011724,hospitalskirka_trikk,hospitalskirka).
%alias_station2(16533001,skottvoll,skottvold).
%alias_station2(16533003,brubakken,brubakk).
%alias_station2(16533004,gylle,kvitland).
%alias_station2(16533040,brekkåsen_snpl,brekkåsen_snuplass).
%alias_station2(16538501,skottvoll,skottvold).
%alias_station2(16538503,brubakken,brubakk).
%alias_station2(16538504,gylle,kvitland).
%alias_station2(16626007,ulset,ulseth).
%alias_station2(16632028,hommelvikhøgda,hommelvik_høgda).
%alias_station2(16638328,hommelvikhøgda,hommelvik_høgda).
%alias_station2(17142707,torvet,torvet_stjørdal).


%%% Discrepancies r1611_140331 r1613_130622 
%alias_station2(16010157,a_jenssens_veg,anton_jenssens_veg).
%alias_station2(16010272,lundåsen_nordre,lundåsen_n).
%alias_station2(16010546,edgar_b_schieldrops_veg,vestlia).
%alias_station2(16010752,leinstrand_samf_hus,leinstrand_samfunnshus).
%alias_station2(16011157,a_jenssens_veg,anton_jenssens_veg).
%alias_station2(16011309,j_minsaa_s_veg,johannes_minsaas_veg).
%alias_station2(16011347,olav_tryggvasons_gate,olav_trygvassons_gate).
%alias_station2(16011752,leinstrand_samf_hus,leinstrand_samfunnshus).
%alias_station2(16533203,gimsan,gimse).
%alias_station2(16538203,gimsan,gimse).
%alias_station2(16626030,sjøla,skjøla).
%alias_station2(16627030,sjøla,skjøla).
%alias_station2(16632013,storsand_1,storsand).
%alias_station2(16632014,storsand_2,storsand).
%alias_station2(16632028,hommelvik_høgda,hommelvikhøgda).
%alias_station2(16638313,storsand_1,storsand).
%alias_station2(16638314,storsand_2,storsand).
%alias_station2(16638328,hommelvik_høgda,hommelvikhøgda).
%alias_station2(16638335,vikhammeråsen_snuplass,vikhammeråsen_rundkjøring).
%
%%% Discrepancies r1611_110627 r1601_110822 
%alias_station2(16010246,kroppan_bru,kroppanbrua).
%alias_station2(16010348,olav_nygards_veg,olav_nygårds_veg).
%alias_station2(16010496,tegleverkskrysset,teglverkskrysset).
%alias_station2(16010505,tonstadkrysset,tonstadkrysset_2).
%alias_station2(16010536,tonstadkrysset,tonstadkrysset_3).
%alias_station2(16010537,tonstadkrysset,tonstadkrysset_4).
%alias_station2(16011246,kroppan_bru,kroppanbrua).
%alias_station2(16011496,tegleverkskrysset,teglverkskrysset).
%
%%% RS-130625
%%% Semi-automatically created by makeauxtables' Last section/predicate
%alias_station2(16011196,bergheim_snuplass,bergheim_snpl).
%alias_station2(16626030,sjøla,skjøla).
%alias_station2(16627030,sjøla,skjøla).
%
%%% Discrepancies r1613_130622 r1601_130930 
%alias_station2(16010403,rosenborg_skole,gyldenløves_gt).
%alias_station2(16010752,leinstrand_samfunnshus,leinstrand_samf_hus).
%alias_station2(16011752,leinstrand_samfunnshus,leinstrand_samf_hus).
%alias_station2(16533040,brekkåsen_snuplass,brekkåsen_snpl).
%alias_station2(16638335,vikhammeråsen_rundkjøring,vikhammeråsen).
%alias_station2(17142510,stjørdal_stasjon,stjørdal_st).

%% RS 2015.12.19
%alias_station2(16010006,dr_gate_d1,dronningens_gate_d1).
%alias_station2(16010007,dr_gate_d2,dronningens_gate_d2).
%alias_station2(16010121,peder_myhres_vei,peder_myhres_veg).
%alias_station2(16010157,a_jenssens_veg,anton_jenssens_veg).
%alias_station2(16010240,kvenilds_veg,kvenildvegen).
%alias_station2(16010253,ladejarlen_v_g_s,ladejarlen_vgs).
%alias_station2(16010266,lohove,lohove_snuplass).
%alias_station2(16010309,j_minsaa_s_veg,johannes_minsaas_veg).
%alias_station2(16010357,osveien,osvegen).
%alias_station2(16010376,prof_brochs_gate,professor_brochs_gate).
%alias_station2(16010395,risvollveien,risvollvegen).
%alias_station2(16010420,ada_arnfinsens_v,ada_arnfinsens_veg).
%alias_station2(16010446,hvs,heimdal_vgs).
%alias_station2(16010495,tiller_v_g_s,tiller_vgs).
%alias_station2(16010517,isdamveien,isdamvegen).
%alias_station2(16010603,traneveien,tranevegen).
%alias_station2(16010706,munkvoll_trikk,munkvoll).
%alias_station2(16011000,breidablikk_trikk,breidablikk).
%alias_station2(16011121,peder_myhres_vei,peder_myhres_veg).
%alias_station2(16011157,a_jenssens_veg,anton_jenssens_veg).
%alias_station2(16011240,kvenilds_veg,kvenildvegen).
%alias_station2(16011253,ladejarlen_v_g_s,ladejarlen_vgs).
%alias_station2(16011309,j_minsaa_s_veg,johannes_minsaas_veg).
%alias_station2(16011357,osveien,osvegen).
%alias_station2(16011376,prof_brochs_gate,professor_brochs_gate).
%alias_station2(16011446,hvs,heimdal_vgs).
%alias_station2(16011456,s_jorsalfars_v,sigurd_jorsalfars_vei).
%alias_station2(16011495,tiller_v_g_s,tiller_vgs).
%alias_station2(16011603,traneveien,tranevegen).
%alias_station2(16011616,granli,grandli).
%alias_station2(16011706,munkvoll_trikk,munkvoll).
%alias_station2(16533040,brekkåsen_snpl,brekkåsen_snuplass).

%alias_station2(16010190,jakobsli_idrettsplass,idrettsplassen). %% Not in August routes %% 2015.06.03, Works in Winter RS-2019.01.01
%alias_station2(16010190,idrettsplassen,jakobsli_idrettsplass). %% Not in August routes %% 2015.06.03, Works in Winter RS-2019.01.01 Doesn't need BOTH ways

%% db/discrepancies r1602_150810 r1611_140203 
%alias_station2(16010006,dr_gate_d1, dronningens_gate_d1).
%alias_station2(16010007,dr_gate_d2,dronningens_gate_d2).
%alias_station2(16010023,strindheim_2,brannstasjon_øst).
%alias_station2(16010254,ladeveien,ladevegen).
%alias_station2(16010272,lundåsen_nordre,lundåsen_n).
%alias_station2(16010309,j_minsaa_s_veg,johannes_minsaas_veg).
%%alias_station2(16010403,gyldenløves_gt,gyldenløves_gate).
%alias_station2(16010420,ada_arnfinsens_v,ada_arnfinsens_veg).
%alias_station2(16010482,søndre_hallset,søndre_halset).
%alias_station2(16010704,ugla,ugla_trikk).
%alias_station2(16010706,munkvoll_trikk,munkvoll).
%alias_station2(16010761,vestre_sætran,sæterbakken).
%alias_station2(16011000,breidablikk_trikk,breidablikk).
%alias_station2(16011023,strindheim_2,brannstasjon_øst).
%alias_station2(16011196,bergheim_snuplass,bergheim_snpl).
%alias_station2(16011347,olav_tryggvasons_gate,olav_trygvassons_gate).
%alias_station2(16011403,gyldenløves_gt,gyldenløves_gate).
%alias_station2(16011456,s_jorsalfars_v,sigurd_jorsalfars_veg).
%alias_station2(16011482,søndre_hallset,søndre_halset).
%alias_station2(16011704,ugla,ugla_trikk).
%alias_station2(16011706,munkvoll_trikk,munkvoll).
%alias_station2(16011761,vestre_sætran,sæterbakken).
%alias_station2(16533001,skottvoll,skottvold).
%alias_station2(16533003,brubakken,brubakk).
%alias_station2(16533004,gylle,kvitland).
%alias_station2(16533040,brekkåsen_snpl,brekkåsen_snuplass).
%alias_station2(16533190,gimseflata_ikke_i_bruk,gimseflata).
%alias_station2(16538501,skottvoll,skottvold).
%alias_station2(16538503,brubakken,brubakk).
%alias_station2(16538504,gylle,kvitland).
%alias_station2(16626007,ulset,ulseth).
%alias_station2(16632028,hommelvikhøgda,hommelvik_høgda).
%alias_station2(16638328,hommelvikhøgda,hommelvik_høgda).
%alias_station2(17142707,torvet,torvet_stjørdal).


%% db/discrepancies r160_190422 r160_200622 
alias_station2(71829,husebytunet_1,husebytunet).
alias_station2(71863,sandstad_hurtigbåtkai,hitra_hurtigbåtterminal).
alias_station2(77184,rønningen_kråkmoen,rønningen).
alias_station2(73571,søndre_gate_ørjaveita,olav_tryggvasons_gate_ot3).
alias_station2(73593,lohove_snuplass,loholtbakken).
alias_station2(71959,høiset,høyset).
alias_station2(71957,høiset,høyset).
alias_station2(73724,ntnu_dragvoll,edvard_bulls_veg).
alias_station2(73723,ntnu_dragvoll,edvard_bulls_veg).
alias_station2(73729,tempe_kirke,lerkendal).
alias_station2(75404,brundalen_skole,charlottenlund_vgs).
alias_station2(75405,brundalen_skole,charlottenlund_vgs).
alias_station2(74982,peder_myhres_veg,ranheim).
alias_station2(74983,peder_myhres_veg,ranheim).
alias_station2(101852,klettkrysset_e39,klettkrysset).
alias_station2(101855,klettkrysset_melhusvegen,klettkrysset).
alias_station2(101853,klettkrysset_e39,klettkrysset).
alias_station2(101854,klettkrysset_melhusvegen,klettkrysset).
alias_station2(72946,heimdal_sentrum,heimdal_stasjon).
alias_station2(75173,flakkråa,flakkråa_fv_715).
alias_station2(72969,kvenildmyra,kvenildsmyra).
alias_station2(98649,lade_alle_73,lade_allé_73).
alias_station2(74695,dyrøy_kai,dyrøy_ferjekai).
alias_station2(74692,dyrøy_kai,dyrøy).
alias_station2(101521,olav_tryggvasons_gate_ot,olav_tryggvasons_gate_ot1).
alias_station2(101523,ila,bergsli_gate).
alias_station2(101524,ila,bergsli_gate).
alias_station2(73421,lerkendal_stadion,lerkendal).
alias_station2(73420,lerkendal_stadion,lerkendal).
alias_station2(75203,blakli_snuplass,blakli).
alias_station2(21401,lade_alle_73,lade_allé_73).
alias_station2(75707,gløshaugen_syd,gløshaugen).
alias_station2(75708,gløshaugen_syd,gløshaugen).
alias_station2(73128,lade_alle_80,lade_allé_80).
alias_station2(73125,lade_alle_80,lade_allé_80).
alias_station2(76371,fosslia_innfartsparkering,fosslia_fjellhall).
alias_station2(75066,fagerheim_alle,jørgen_b_lysholms_vei).
alias_station2(75065,fagerheim_alle,jørgen_b_lysholms_vei).
alias_station2(74555,olav_engelbrektssons_alle,olav_engelbrektssons_allé).
alias_station2(74554,olav_engelbrektssons_alle,olav_engelbrektssons_allé).
alias_station2(110379,fagerli_vd,fagerli_vegdele).
alias_station2(110373,kråkmo_vd,kråkmo_vegdele).
alias_station2(73276,leangen_alle,leangen_allé).
alias_station2(73277,leangen_alle,leangen_allé).
alias_station2(73857,johan_tillers_vei_e6,hårstadkrysset).
alias_station2(71204,professor_brochs_gate,hesthagen).
alias_station2(73860,johan_tillers_vei_e6,hårstadkrysset).
alias_station2(71206,tonstadkrysset_kolstadvegen,tonstadkrysset).
alias_station2(71209,tonstadkrysset_kolstadvegen,tonstadkrysset).
alias_station2(71215,tonstadkrysset_vestre_rosten,tonstadkrysset).
alias_station2(71174,prinsen_kinosenter,nidarosdomen).
alias_station2(71175,prinsen_kinosenter,nidarosdomen).
alias_station2(74205,nova_kinosenter,olav_tryggvasons_gate_ot2).
alias_station2(73782,sluppen,sluppen_3).
alias_station2(73783,sluppen,sluppen_4).
alias_station2(72460,haakon_vii_gate_9,lade_idrettsanlegg).
alias_station2(72461,haakon_vii_gate_9,lade_idrettsanlegg).
alias_station2(71195,professor_brochs_gate,hesthagen).
alias_station2(75609,city_syd_e6_1,city_syd_e6).
alias_station2(75606,city_syd_sentervegen,tillerterminalen).
alias_station2(75607,city_syd_sentervegen,tillerterminalen).
alias_station2(75611,city_syd_østre_rosten,city_syd).
alias_station2(75612,city_syd_østre_rosten,city_syd).
alias_station2(75610,city_syd_e6_2,city_syd_e6).
alias_station2(73032,migosenteret,hallset).
alias_station2(73031,migosenteret,hallset).