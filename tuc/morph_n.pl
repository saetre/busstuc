/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE morph_n.pl
%% SYSTEM TUC
%% AUTHOR T.Amble
%% CREATED TA-961014
%% REVISED TA-110511
%% Extended with tallmorph  Norwegian textual numbers.

:- ensure_loaded('../declare').

%% Morphological Analyser for the language N.

:-module(morph_n,[]).


ends_with(X,Y,Z):-user:ends_with(X,Y,Z).

verb_form(X,Y,Z,U):-
    dict_n:verb_form(X,Y,Z,U).

noun_form(X,Y,Sin,Def,N):- 
    dict_n:noun_form(X,Y,Sin,Def,N).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Tranforms each word into a list of alternatives.


%%%%%% The coding conventions %%%%%%%%%%%%%%%%%%%%%

%  w(<word>,List of Interpretations)
%
%       Interpretation
%                                             
%       noun(root,{sin,plu},{def,u},{gen,n})   def bestemt form , u ubest (indef)
%       name(root,{gen,n},Class)  
%       verb(root,{pres,past,imp,inf},{fin,part,pass}) 
%       adj2(root,{nil,comp,sup}).  %% TA-091209 {sin,plu} is of no consequence
%       adv(root)    
%       prep(word)
%       nb(numeral,{ind,ord})
%       quote(text)
%       [word]                                  all others words 
%
%
% Underscore variables _  are used for
%
%       dont know   in the data and
%       dont care   in the grammar
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


lcode2(ADVN,adv(ADVE)):-   
    dict_n:adv2(ADVN,ADVE).      



lcode2(V,verb(VE,X,Y)):-  
    \+ dict_n:unwanted_verb(V), %%  ( mår \= må+r)
    lexv(V,VNO,X,Y),
    dict_n:verbroot2(VNO,VE).      

lcode2(M,noun(NE,X,Y,Z)):- %% TA-101207
   
    \+ dict_n:unwanted_noun(M), %% svar(er)
  
   lexn(M,NO,X,Y,Z),     
 
                                         
   ( dict_n:noun2(NO,NE)
     ;
     dict_n:noun3(NO,NE,_)),
 
  \+ dict_n:unwanted_interpretation(M,NE). %% bruker \+ plu bruk %% TA-101124

lcode2(MN,prep(ME)):-
    dict_n:preposition2(MN,ME).

%% avoid sen -> later by generalisation when later means something else


%% ADJECTIVE SECTION


lcode2(FLEKSIBLE,adj2(GOOD,nil)):- %% ekkle
     \+  dict_n:unwanted_adjective(FLEKSIBLE), %% TA-110812
    ends_with(FLEKSIBLE,FLEKSIB,le),
    ends_with(FLEKSIBEL,FLEKSIB,el),
    dict_n:adjective2(FLEKSIBEL,GOOD).



lcode2(SAKTERE,adj2(SLOW,comp)):-
   \+  dict_n:unwanted_adjective(SAKTERE), %% e.g. passere %% TA-110330
    ends_with(SAKTERE,SAKTE,re),
    ends_with(SAKTE,_SAKT,e),
    \+  dict_n:unwanted_adjective(SAKTE), %% e.g. slutt(e) 
    dict_n:adjective2(SAKTE,SLOW).



lcode2(SAKTEST,adj2(SLOW,sup)):- 
     \+  dict_n:unwanted_adjective(SAKTEST), %% 
    ends_with(SAKTEST,SAKTE,st),
    ends_with(SAKTE,_SAKT,e),
    \+  dict_n:unwanted_adjective(SAKTE), %% e.g. slutt(e) 
    dict_n:adjective2(SAKTE,SLOW).



lcode2(SENERE,adj2(LATE,Comp)):-
     \+  dict_n:unwanted_adjective(SENERE),
    dict_n:adjective3(SENERE,Comp,LATE).



lcode2(SENERE,adj2(LATE,Comp)):- 
    \+  dict_n:unwanted_adjective(SENERE), %% e.g. slutt(e) 
    adjflex(SENERE,SEN,Comp),
    dict_n:adjective2(SEN,LATE),
    (SENERE \== SEN -> \+  dict_n:adjective2(SENERE,_)
    ; true).


lcode2(TRYGT,adj2(SAFE,nil)):- %% trygt
    \+  dict_n:unwanted_adjective(TRYGT), 
    ends_with(TRYGT,TRY,gt),
    ends_with(TRYGG,TRY,gg),
    dict_n:adjective2(TRYGG,SAFE).   %% dict_n.pl


lcode2(TRYGT,adj2(SAFE,nil)):- %% rasjonelt
    \+  dict_n:unwanted_adjective(TRYGT), 
    ends_with(TRYGT,TRY,lt),
    ends_with(TRYGG,TRY,ll),
    dict_n:adjective2(TRYGG,SAFE).   %% dict_n.pl


lcode2(TRYGT,adj2(SAFE,nil)):- %% tøft 
    \+  dict_n:unwanted_adjective(TRYGT), 
    ends_with(TRYGT,TRY,ft),
    ends_with(TRYGG,TRY,ff),
    dict_n:adjective2(TRYGG,SAFE).   %% dict_n.pl


lcode2(TRYGT,adj2(SAFE,nil)):- %% frekt
    \+  dict_n:unwanted_adjective(TRYGT), 
    ends_with(TRYGT,TRY,kt),
    ends_with(TRYGG,TRY,kk),
    dict_n:adjective2(TRYGG,SAFE).   %% dict_n.pl






lcode2(M,nb(N,X)):-
    dict_n:numerid(M,N,X).

lcode2(N,nb(X,num)):-
   \+ dict_n:unwanted_number(N), %% ettet = etter %% NEW predicate 
   tall(N,X).

                          % cw Moved before known_name! 
lcode2(X,[X]):-           % Test on actual word
    dict_n:cw(X).         % closed set of known words

                         
lcode2(X,[X]):-           %%   not name(X,n,0) as before
    user:once1(user:part_word(X)).   

verbroot(W):- 
    be_verb(W);
    ditrans_verb(W);
    trans_verb(W);
    intrans_verb(W);
    dict_n:rep_verb(W); 
    pvimodal_verb(W). % cost

pvimodal_verb(W):-
    user:pvi_templ(W,_).

be_verb(be).

ditrans_verb(X):-
    user:dtv_templ(X,_,_,_). %% btv -> dtv

trans_verb(have). %% 
trans_verb(X):-
   user:tv_templ(X,_,_),
   !. %% >1 

intrans_verb(X):-
   user:iv_templ(X,_),
   !. %% >1 

adjective(X):-
    user:adj_templ(X,_),
    !. %% >1 
 

%% LEXV

lexv(X,be,Y,Z):- 
    verb_form(X,be,Y,Z), %% <-- ad hoc
    !.

lexv(LURAR,LURE,pres,fin):- %%  Nynorsk
    ends_with(LURAR,LUR,ar),
    ends_with(LURE,LUR,e).

lexv(ELSKER,ELSKE,pres,fin):- 
    ends_with(ELSKER,ELSKE,r).

lexv(TILSIER,TILSI,pres,fin):-  
    ends_with(TILSIER,TILSI,er),
    ends_with(TILSI,_,si).      %%  \+ TILGI TILGIER

lexv(ELSKE,ELSKE,inf,fin):- %% New tense  inf 
    ends_with(ELSKE,_,e).


/* være \== pres,fin 

lexv(ELSKE,ELSKE,pres,fin):- %% Dialect 
    ends_with(ELSKE,_,e).
*/

lexv(sende,sende,inf,fin):-!. %%  emphatic E  sEnde \= seende 
lexv(lande,lande,inf,fin):-!.

lexv(SEENDE,SE,pres,part):-   %% gående 
    ends_with(SEENDE,SE,ende).

lexv(ELSKENDE,ELSKE,pres,part):-     
    ends_with(ELSKENDE,ELSKE,nde).

lexv(KJORTE,KJORE,past,fin):-          
  \+  dict_n:unwanted_verb(KJORTE), %% oppdaterte
    ends_with(KJORTE,KJOR,te),
    ends_with(KJORE,KJOR,e).

lexv(KJORT,KJORE,past,part):-    

   \+  dict_n:unwanted_verb(KJORT), %% oppdatert

    ends_with(KJORT,KJOR,t),
    \+  ends_with(KJOR,_,t), %% test(e)t %% TA-101210
    ends_with(KJORE,KJOR,e),
    \+ ends_with(KJOR,_,i), %% tit \= tie-t 

    \+  dict_n:unwanted_verb(KJORT), %% e.g. leit 
        
    KJORE \== lage,  %% would make lagt = laget 
    KJORE \== se,    %% st \== sett
    KJORE \== hate.  %% Special   lete lett but hate hatet.
                     %% don't know how to avoid it

lexv(ELSKET,ELSKE,past,part):- 
    ends_with(ELSKET,ELSKE,t), % har elsket
    ends_with(ELSKE,_,e).  



lexv(ELSKET,ELSKE,past,fin):-      %% NB, viktig at Inf.formen opptrer (ELSKE)

    \+  dict_n:unwanted_verb(ELSKET), %% oppdatert

    ends_with(ELSKET,ELSKE,t),
    \+ user:testmember(ELSKE,[komme]),
    ends_with(ELSKE,_,e).     %% not gå --> gåt 




lexv(INNSETT,INNSE,past,part):-     %% se/sett innse/forutse
    ends_with(INNSETT,INNS,ett),
    ends_with(INNSE,INNS,e).    



lexv(GODKJENTE,GODKJENNE,past,fin) :-
    ends_with(GODKJENTE,GODKJE,nte),
    ends_with(GODKJENNE,GODKJE,nne).    


lexv(GODKJENT,GODKJENNE,past,part) :-
    ends_with(GODKJENT,GODKJE,nt),
    ends_with(GODKJENNE,GODKJE,nne).     


lexv(MISTA,MISTE,past,part):- 
      ends_with(MISTA,MIST,a),
      \+ user:testmember(MIST,[s,l]), %% se|le \= sa|la
      MIST \== l, %% LE=L+E, LA=L+A    %% TA-110330
      ends_with(MISTE,MIST,e).  


lexv(MISTET,MISTE,X,Y):-
    verb_form(MISTET,MISTE,X,Y).



lexv(VASKES,VASKE,pres,pass):-  
    ends_with(VASKES,VASKE,s).

lexv(VASKEST,VASKE,pres,pass):-  
    ends_with(VASKEST,VASKE,st).

lexv(SENDTES,SENDE,past,pass):- 
    ends_with(SENDTES,SEND,tes),
    ends_with(SENDE,SEND,e).


lexv(var,være,past,fin):-!. %% not imperative of vare

lexv(ELSK,ELSKE,imp,fin):-  %%  (or fin,imp ?)  %% vise = imp ???
    \+ dict_n:unwanted_verb(ELSK), %% e.g. lov
    ends_with(ELSKE,ELSK,e). %% NB reverse order
                            %% NB  komme ==> komm!   (OK ?)

lexv(X,X,inf,fin). %% NB was pres fin 
                   %% inf fin before imp fin (gå)

lexv(GI,GI,imp,fin):-  %% vil IKKE imp !!!
   GI \== nå, %% ikke nå!   %% AD Hoc 
   user:last_character(GI,Vok), %% New utility predicate
   user:member(Vok,[a,i,o,u,y,æ,ø,å]). %% e is dropped as a rule
                                       %% Reintroduced when necessary
                                  %%  Trykksterk e (kle,bre,gre,le,re,te)

lexv(GLEM,GLEMME,imp,fin):-  %%  (or fin,imp ?)
   ends_with(GLEM,GLE,m),
   ends_with(GLEMME,GLE,mme).


lexv(STEMTE,STEMME,past,fin):-  %% TA-110114
   ends_with(STEMTE,STE,mte),   %% TA-110511
   ends_with(STEMME,STE,mme).   %% \+ lite = lime


lexb(X,Y):-
    lexv(X,Y),
    lexb1(Y).     % dict.pl




% NOUN SECTION
%         

noun(thing).
noun(X) :- X ako _ .



lexn(KLOKKA,KLOKKE,sin,def,n):- %% NB  IDA = IDEA *  (ida unwanted_noun)
    ends_with(KLOKKA,KLOKK,a),  %%     TRA = TREA *
    ends_with(KLOKKE,KLOKK,e).

lexn(HELGA,HELG,sin,def,n):- 
    ends_with(HELGA,HELG,a).

%% NOUN3 section 


lexn(HUSA,HUS,plu,def,n):-      %%   IKKE INFO om Neutr
    ends_with(HUSA,HUS,a),      %% NB OGSÅ  FRAMTIDA, MORA
    dict_n:noun3(HUS,_,n).  % e.g. tid
 
lexn(HUS,HUS,plu,u,n):-  %%  2 hus 
   dict_n:noun3(HUS,_,n).


lexn(HUSET,HUS,sin,def,n):- 
    ends_with(HUSET,HUS,et),
    \+ dict_n:noun3(HUS,_,m). %% RETTET \+ = Retten 

lexn(RYKTET,RYKTE,sin,def,n):- 
    ends_with(RYKTET,RYKTE,t),
    ends_with(RYKTE,_RYKT,e).

lexn(BUSSEN,BUSS,sin,def,n):-  
    ends_with(BUSSEN,BUSS,en).

lexn(GAVEN,GAVE,sin,def,n):-   
    ends_with(GAVEN,GAVE,n),
    ends_with(GAVE,_GAV,e). 

lexn(NUMMRENE,NUMMER,plu,def,n):-   %% nummrene 
    ends_with(NUMMRENE,NUMM,rene), 
    ends_with(NUMMER,NUMM,er).

lexn(NUMRENE,NUMMER,plu,def,n):-   %% numrene 
    ends_with(NUMRENE,NUM,rene), 
    ends_with(NUMMER,NUM,mer).

lexn(ORAKLER,ORAKEL,plu,u,n):- 
    ends_with(ORAKLER,ORAK,ler),
    ends_with(ORAKEL,ORAK,el).

lexn(BUSSENE,BUSS,plu,def,n):- 
    ends_with(BUSSENE,BUSS,ene).

lexn(BUSSENE,BUSS,plu,def,n):- 
    ends_with(BUSSENE,BUSS,an). %% dialect



%% OOPS:  verne ==> ver plu def %% SIC  vernes = weather plu def

lexn(PROGRAMMERERNE,PROGRAMMERER,plu,def,n):- 
    ends_with(PROGRAMMERERNE,PROGRAMMER,erne),
    ends_with(PROGRAMMERER,PROGRAMMER,er).

lexn(TIMANE,TIME,plu,def,n):-  
    ends_with(TIMANE,TIM,ane),         %% Nynorsk       
    ends_with(TIME,TIM,e).   

lexn(BUSSANE,BUSS,plu,def,n):- 
    ends_with(BUSSANE,BUSS,ane).         %% Nynorsk

lexn(GAVENE,GAVE,plu,def,n):-    % trærne, o.l 
    ends_with(GAVENE,GAVE,ne),
    ends_with(GAVE,_GAV,e).              %% ikke by ne

lexn(PROGRAMMET,PROGRAM,sin,def,n):- 
     ends_with(PROGRAMMET,PROGRAM,met),
     ends_with(PROGRAM,_PROGRA,m).

lexn(DRAMMEN,DRAM,sin,def,n):-  
     ends_with(DRAMMEN,DRAM,men),
     ends_with(DRAM,_DRA,m).

lexn(PROGRAMMER,PROGRAM,plu,u,n):-  
     ends_with(PROGRAMMER,PROGRAM,mer),
     ends_with(PROGRAM,_PROGRA,m).

lexn(PROGRAMMENE,PROGRAM,plu,def,n):- 
     ends_with(PROGRAMMENE,PROGRAM,mene),
     ends_with(PROGRAM,_PROGRA,m).

lexn(PROGRAMMET,PROGRAM,sin,def,n):-
     ends_with(PROGRAMMET,PROGRAM,met),
     ends_with(PROGRAM,_PROGRA,m).

lexn(DAMMEN,DAM,sin,def,n):-
     ends_with(DAMMEN,DAM,men),
     ends_with(DAM,_,m).


lexn(FORMLENE,FORMEL,plu,def,n):-  
     ends_with(FORMLENE,FORM,lene),
     ends_with(FORMEL,FORM,el).

lexn(FORMLER,FORMEL,plu,u,n):-  
     ends_with(FORMLER,FORM,ler),
     ends_with(FORMEL,FORM,el).


lexn(ORAKLET,ORAKEL,sin,def,n) :- %% TA-101117
    ends_with(ORAKLET,EKSEM,klet),
    ends_with(ORAKEL,EKSEM,kel).



lexn(EKSEMPLET,EKSEMPEL,sin,def,n) :- 
    ends_with(EKSEMPLET,EKSEM,plet),
    ends_with(EKSEMPEL,EKSEM,pel).


lexn(LÆRERE,LÆRER,plu,u,n):- 
    ends_with(LÆRERE,LÆR,ere),
    ends_with(LÆRER,LÆR,er).



lexn(X,Y,Sin,Def,N):-         %%   Irregular singular
    noun_form(X,Y,Sin,Def,N). %%   New predicate  dict_n.pl  

lexn(X,X,sin,u,n).            %% Regular singular

/*
lexn(X,Y,sin,u,n):-  
    dict_n:lexnsingirr(X,Y).       % Irregular singular 

lexn(Menn,Mann,plu,u,n):- 
     dict_n:lexnpluirr(Menn,Mann).    % Irregular plural 
*/

lexn(GUTTER,GUTT,plu,u,n):-   %% % Regular plural
    lexnplureg(GUTTER,GUTT). 

lexn(MENNS,MANN,X,U,gen):-  
    ends_with(MENNS,MENN,s),  %% busss => buss's  (OK ?)
    \+ ends_with(MENN,_,s),   %% NO !
    lexn(MENN,MANN,X,U,N),
    N==n. %% Cut Error ?    



lexnplureg(GUTTER,GUTT):-
    ends_with(GUTTER,GUTT,er),
    \+ dict_n:noun3(GUTT,_,n). %% lager \= lag plu 

lexnplureg(GUTAR,GUT):-     %%  Nynorsk
    ends_with(GUTAR,GUT,ar).

lexnplureg(UNGAR,UNGE):-      %%  Nynorsk
    ends_with(UNGAR,UNG,ar), 
    ends_with(UNGE,UNG,e).


lexnplureg(BAKKAR,BAKK):-     %%  Nynorsk 
    ends_with(BAKKAR,BAKK,ar).

lexnplureg(GAVER,GAVE):-  %% gårr \-> går(er)
    ends_with(GAVER,GAVE,r),
    ends_with(GAVE,_,e).


%% ADJECTIVE SECTION  

adjflex(SULTEN,SULTEN,nil).   % Drop pedantic conformance test. %% SUSPENDED

adjflex(SULTENT,SULTEN,nil):-
    ends_with(SULTENT,SULTEN,t).

adjflex(FRITT,FRI,nil):- 
    ends_with(FRITT,FRI,tt), 
    user:last_character(FRI,Vok), 
    user:member(Vok,[i]). %% other ?


adjflex(GODE,GOD,nil):-
    ends_with(GODE,GOD,e),
    GODE \== neste,           %% avoid neste = nest = andre // " siste"
    \+ ends_with(GOD,_,e).    %%  ( nestee *)

adjflex(SULTNE,SULTEN,nil):- %% * sne -> sen 
    ends_with(SULTNE,SULT,ne),
    ends_with(SULTEN,SULT,en).

adjflex(DUMME,DUM,nil):- 
    ends_with(DUMME,_DU,mme),
    ends_with(DUMME,DUM,me).

%%% These are a bit rough 


adjflex(RASKERE,RASK,comp):-
    ends_with(RASKERE,RASK,ere). %% coarse 

adjflex(RASKARE,RASK,comp):-
    ends_with(RASKARE,RASK,are). %% coarse NN


adjflex(RASKEST,RASK,sup):-
    ends_with(RASKEST,RASK,est). %% coarse

adjflex(RASKAST,RASK,sup):-
    ends_with(RASKAST,RASK,ast). %% coarse NN

adjflex(RASKESTE,RASK,sup):-
    ends_with(RASKESTE,RASK,este). %% coarse

adjflex(BILLIGSTE,BILLIG,sup):-  %% \+ vis(e)ste %% TA-110114
    ends_with(BILLIGSTE,BILLIG,ste),
    \+ ends_with(BILLIG,_,s). 

adjflex(RASKASTE,RASK,sup):-
    ends_with(RASKASTE,RASK,aste). %% coarse NN



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% FILE tallmorph.pl
%% CREATED  JB-970630
%% REVISED  TA-060129


%%  Decodes numbers coded as contiguous text constants.

%%  Number strings must be contiguous ! 

%% etttusentohundreogtrettifire OK

%% only modern spelling  , NOT *femogtjue* 


tall(Const,Verdi) :-
	 name(Const,Str),
	 tokens(List,Str,[]),!, %% initial "" not allowed
	 tabtall(0,Verdi,List,[]).


tabtall(Left,Ut) --> 
	 sifre(S), faktorer(F),        %%  " attenti " = 1810 ( ikke 18*10)
    {S \== 5, S \== 6},          %% femti = 50
	 {F=10,N is (Left+S)*100+F},
    !,
	 tabtall(N,Ut).

tabtall(Left,Ut) --> 
	 sifre(S),faktorer(F),        %%  " femtitusen "
	 {F>Left,N is (Left+S)*F},
    !,  
	 tabtall(N,Ut).

tabtall(Left,Ut) -->             %%  " ( ... tusen ) tre hundre
	 og0,                         
    sifre(S),faktorer(F),
	 {F=<Left,N is S*F},
    !,  
    tabtall(N,SubUt),
	 {Ut is Left+SubUt}.

tabtall(Left,Ut) --> og0,sifre0(S),{Ut is Left+S}.   % tre (tretti)
tabtall(0,Ut)    --> faktorer(F),og0,tabtall(F,Ut).  % hundreogtre 
tabtall(T,T)     --> [].

og0 --> [&],!. 
og0 --> [].


sifre(F) -->
     siffer(N),
     [&],
     siffer(M),
    { N < 10, M > 10}, %% gml tellemåte
    { F is N+M}. 

sifre(F)  --> siffer(M),
              sifre(N), %% femtjue = 0520
              {(M >= 10, N < 10) ->  F is M+N 
                                     ; 
                                     F is M*100+N}.

sifre(F)  --> siffer(F).

sifre0(F) --> sifre(F).  %% & tre   
sifre0(F) --> faktor(F). %% & tretti  

siffer(F) --> [F],{issiffer(F)}.

faktorer(F) --> faktor(N),faktorer(M),{F is N*M}.
faktorer(F) --> faktor(F).
faktor(F)   --> [F],{isfaktor(F)}.

isfaktor(N) :- integer(N),R is N mod 100,R==0.  %%  100 %% tjueti \= 200

issiffer(N) :- integer(N),R is N mod 100,R\==0. %%  100 %% 

%% 

tokens([Verdi|RStr]) --> verdi(Verdi),tokens0(RStr).

tokens0(X)        --> tokens(X). 
tokens0([])       --> [].

verdi(10) --> "ti".  %% 50 før 5 10
verdi(11) --> "elve".
verdi(11) --> "elleve".
verdi(12) --> "tolv".
verdi(13) --> "tretten".
verdi(14) --> "fjorten".
verdi(15) --> "femten".
verdi(16) --> "seksten".
verdi(17) --> "sytten".
verdi(17) --> "søtten".
verdi(18) --> "atten".
verdi(19) --> "nitten".
verdi(20) --> "tjue".
verdi(20) --> "tyve".
verdi(30) --> "tretti".
verdi(30) --> "tredve".
verdi(40) --> "førti".
verdi(40) --> "førr".
verdi(50) --> "femti".  %% before 5 10
verdi(60) --> "seksti". %% before 6 10
verdi(70) --> "sytti".
verdi(70) --> "søtti".
verdi(80) --> "åtti".
verdi(90) --> "nitti".

verdi(0) --> "null".
verdi(1) --> "en".
verdi(1) --> "ein".
verdi(1) --> "ett".
verdi(1) --> "et".
verdi(2) --> "to".
verdi(3) --> "tre".
verdi(4) --> "fire".
verdi(4) --> "fira".
verdi(4) --> "fir".
verdi(5) --> "fem".
verdi(6) --> "seks".
verdi(7) --> "sju".
verdi(7) --> "syv".
verdi(8) --> "åtte".
verdi(8) --> "åtta".
%% verdi(8) --> "ått". %% åttet = 801 * 
verdi(9) --> "ni".

verdi(100) --> "hundre".
verdi(100) --> "hundrer".
verdi(100) --> "hondra".
verdi(100) --> "hundrede".
verdi(1000) --> "tusen".

verdi(&) --> "og".

