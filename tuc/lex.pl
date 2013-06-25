/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE lex.pl
%% SYSTEM TUC
%% AUTHOR T.Amble
%% CREATED TA-931217
%% REVISED TA-110803  RS-130330

%% Transforms each word into a list of alternatives.

%% Semi-tagger (quasi multitagger)

% % % % % % % % % % % % % % % % % % % % % % % % % % 

%%%%%% The coding conventions %%%%%%%%%%%%%%%%%%%%%

%  w(<word>,List of Interpretations)
%
%       Interpretation
%                                             
%       noun(root,{sin,plu},{def,u},{gen,n})  def  bestemt form , u ubest
%       name(root,{unknown,gen,n},{Class,0,unk}) 
%       verb(root,{pres,past,imp},{fin,part})   ( number/gender is of no consequence)
%       adj2(root,{nil,comp,sup}) %%            ( number/gender is of no consequence)
%       prep(word)
%       nb(numeral,{ind,ord,alf}) %%  9a -> 9,alf
%       quote(text) -> 'text'
%       [word]                                  all others words 
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RS-111205, UNIT: /
:- ensure_loaded( '../declare' ).  % :- use_module( userNOTME:'../declare.pl').


%:- use_module( '../interfaceroute', [ domain_module/2 ] ). %% HEAVY DB!
%:- use_module(    '../main', [ (:=)/2, (=:)/2, myflags/2,  set/2,  traceprint/2, track/2 ] ).
%:- use_module(    '../tucbuses', [  dict_module/1, dict_module/2, morph_module/1  ] ).
%
%%% RS-111205, UNIT: tuc
%:-use_module( dict_n, [
%        compword/3,   kw/1, %% TA-100902 %%%%%%%%%  All the words appearing as [ ] constants in grammar
%        noisew/1,     rewording/2,   synwordx/2,  xcompword/3
%    ] ).
%:- use_module( evaluate, [ fact/1, instant/2 ] ).
%:- use_module( facts, [ neighbourhood/1, (isa)/2  ] ).  %% RS-111204    isa/2 from facts.pl
%:- use_module( names, [
%        compname/3,  generic_place/1,  samename/2,  streetsyn/1, synname/2,  unwanted_name/1
%  ] ).
%
%%% RS-111205, UNIT: app
%:- use_module( '../app/buslog', [  bus/1, composite_stat/3, station/1 ] ).

%% RS-111205, UNIT: db/
:- use_module( '../db/busdat', [ 
        cmbus/3,
        explicit_part_name/1,      % (NAME)
        synbus/2,                  % (NAME,ROUTE)
        tramstation/1,             % (STATION)
        xforeign/1,                % (PLACE)
        xsynplace/2
  ] ).
%:- use_module( '../db/namehashtable' ).
%:- use_module( '../db/places', [
%        underspecified_place/1, unwanted_place/1,
%        alias_name/2,            % (NAME,NAME)
%        cmpl/3,                  % (NAME,NAME*,LIST)
%        sameplace/2,             % (PLACE,PLACE)
%        synplace/2,              % (NAME,PLACE)
%        underspecified_place/1,  % (PLACE)
%        unwanted_station/1
%   ]).
%:- use_module( '../db/regcompstr', [ composite_road/3 ] ).
% %:- use_module( '../db/regbusall', [ regbus/1 ] ). %% HEAVY DB! %% RS-120803
%:- use_module( '../db/regstr', [   streetstat/5 ] ). %% RS-111201 Remember to update source program, which is makeaux?
%:- use_module( '../db/teledat2', [   lookupdb2/3 ] ).
%:- use_module( '../db/timedat', [ named_date/2 ]).
%:- use_module( '../db/topreg', [     routedomain/1,        route_period/4    ] ).
%
%
%%% RS-111205, UNIT: dialog/
%
%:- use_module( '../dialog/frames2', [  xframe_getvalue/2 ] ).
%:- ensure_loaded( '../dialog/frames2' ). %% , [  xframe_getvalue/2 ] ).

%%% RS-111205, UNIT: utility
%:- use_module( '../utility/utility', [
%        append_atoms/3, begins_with/3, delete1/3, doall/1,  % P, then succeed
%        ends_with/3,    flatten/2, for/2, foralltest/2, iso_atom_chars/2,
%        once1/1,        out/1,    output/1,  set_of/3,   set_ops/3,    set_union/3,  test/1,
%        testmember/2,       textlength/2
%   ] ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:-volatile blockmark/1. %% used for bookkeeping of xcompword matching
:-dynamic blockmark/1. %% used for bookkeeping of xcompword matching

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%  LEXICAL ANALYSER %%%%%%%%%%%

% Flexible Bilingual version
%  analyse the input for selection of most probable language,
%  then answer in the same language

lexproc3(L1,AssumedLanguage,L3):-

    language  =: AssumedLanguage, %% AssumedLanguage := value$(language)

    \+ value(duallangflag,true),  %% without duallangflag, only 1 language
    !,                  
    lexproc2(L1,L3,_Nunks).


lexproc3(L1,AssumedLanguage,L3):- 
    language  =: OldLanguage,
    lexproc2(L1,L2Old,NunksOld),
    !,
    track(4,nl), 


(    NunksOld = 0 -> 
        (AssumedLanguage = OldLanguage,
         L3 = L2Old)
;

(   
    the_other_language(OldLanguage,NewLanguage),
    language := NewLanguage,
    lexproc2(L1,L2New,NunksNew),
    !,
    track(4,nl),  
    language := OldLanguage, % ad hoc, for safety

    decide_language(NunksOld,NunksNew,OldLanguage,NewLanguage,AssumedLanguage),

    (AssumedLanguage = OldLanguage -> L3 = L2Old;
                                      L3 = L2New)
)).


the_other_language(english,norsk).
the_other_language(norsk,english).



decide_language(NuOld,NuNew,_Old,New,New):- 
    NuNew < NuOld,  % there are fewer unknowns in the new language 
    !.

decide_language(_NuOld,_NuNew,Old,_New,Old).


lexproc2(L1,L3,Nunks):-
    lexproc(L1,L3),
    unknown_words(strict,L3,Unknowns), %% To decide language, 
                                       %% neglect misspelled part_names
    length(Unknowns,Nunks).


lexproc(L1,L3):-

    rewordreplace(L1,L0,1),  
    insert_splitwords(L0,LS),  
    lexps(LS,L2),              %% This
    remove_noise(L2,L3),       %% sequence ?
    !. 


insert_splitwords(LS,LT):- 
   insert_split(LS,LS1),
   flatten(LS1,LT).

insert_split([],[]). %%


insert_split([X|Y],[XL|Z]):- %%
    splitwordx(X,XL),        %%  x
    !,
    insert_split(Y,Z).

insert_split([X|Y],[X|Z]):- %%
%%    \+ splitword(X,_),
    !,
    insert_split(Y,Z).  

%%  Experimental  %%

splitwordx(X, YZ):-   
    splitword(X,YZ),
    !.


splitword(X,KL):-
    value(language,N),
    dict_module(N, Dict),
    Dict:splitword(X,KL).

%% REWORD REPLACE 

rewordreplace(XL,ZL,Max):-
    Max > 0, 
    Max1 is Max -1,
    rewordrepl1(XL,YL,Suc),
    Suc==1, %% 1 changed   
    !,
    traceprint(4, (XL -> YL)), 
    rewordreplace(YL,ZL,Max1).
   
rewordreplace(XL,XL,Max):-  
    Max >= 0.   %% If >= Max, FAIL, not Default        



rewordrepl1([A|XL],ÅR,1):- % only 1 replacement
   reword1d([A|AZ],XZ:ÅR),  %% dictn/e  
   rewordmatches(AZ,XL,XZ),
   !.

rewordrepl1([X|XL],[X|YL],Suc):- % 
   !,
   rewordrepl1(XL,YL,Suc).


rewordmatches([],X,X).
rewordmatches([X|Y],[X|Z],U):-
    rewordmatches(Y,Z,U).

reword1d([A|AZ],XZÅR):- %% TA-101006
    reword1([A|AZ],XZL),
    make_dlist(XZL,XZÅR).

make_dlist([A|AZ],X:[A|AX]):-
    mdlistrest(X,AZ,AX).

mdlistrest(X,[],X):-!.
mdlistrest(X,[A|B],[A|BX]):-
    mdlistrest(X,B,BX).
    
  

reword1(X,KL):-
    value(language,N),
    dict_module(N, Dict),
    Dict:rewording(X,KL).

 
%% reword1([for,æ,være],[for,å,være]). %%% <---- Special format


% ¤ 

lexps([],[]).
lexps([X|Y],[XL|YL]):-
    lcodes(X,XL),
    lexps(Y,YL).

lcodes(N,w(N,S2)):-

%% TRY SEQUENCE PRESERVING / prioritize table items
    set_ops(N1,lcode1(N,N1),S), 
    handle_unknown(N,S,S1),
    traceprint(4,handle_unknown(N,S,S1)), %% trace >= 4 -> write unknown list 
    squirtsurplus(N,S1,S2).

  
%% Levange = leangen/levanger Different names ==> just unknown
%% gårn = gran/gård  Different partnames, no mess


squirtsurplus(_,[name(Hare_street,n,street)|R],[name(Hare_street,n,street)]):- %% TA-100311
     \+ member(name(_tempev,n,station),R),
     \+ member(name(_tempev,n,0),R). %% Tempevegen 11 station/Tempeveien 11 street %% TA-101124

%%  squirtsurplus(brosetveien,
%%    [name(brøset_street,n,street),name(brøsetv,n,station),name(brøsetveien,n,0)],[name(brøset_street,n,street)]) ?
%%  dont drop if stations

%% IF one street, only the first 
%% Assume first is without spell correction hareveien -> havreveien
%% Rough ad hoc  hareveien -> hare_street \+ havre_street
            
 
squirtsurplus(Twang,[],[name(Twang,unknown,unk)]):-!.

squirtsurplus(_,S,S). % No unknowns


handle_unknown(_Forresten,[n_w],[n_w]):-!. %% \+ Forset

handle_unknown(_Name,List,List):- 
    \+ value(spellcheck,1),
    !. 

handle_unknown(_Name,List,List):- %% Hazard ???
    value(teleflag,true),
    !. %% dynamic, spell only for places anyway
                            
handle_unknown(Strandveien,L,L1):-
     dont_spell_check_test(Strandveien,L),
     !,
     L=L1.


handle_unknown(N,Taglist,Names):-  %% Only called if NO Tags (feature)

     set_ops(name(X,Gen,Class),    %% Sequence Preserve
           believed_name(N,X,Gen,Class,_U), 
           BelNames),
     set_union(Taglist,BelNames,Names). %% sequence preserving, originals first


              %% ferstads = neib + ferstad
              %% kroglund ->  kroglunds 
              %% eidsvoll ->  eidsvolls 
              %% avoid strand_street \+-> strind_street at all 

dont_spell_check_test(Strandveien,L):-  

(    test(station(Strandveien)) %% eg Blakli -> * Baklia 
     ;
%%%%     test(synname(Strandveien,_))    %% already a synname   **solem veien -> skole veien**
%%%%     ;                               %% bishops -> biskops %% TA-110411
     test(member(noun(_Weather,_,_,_),L)) %% Ad Hoc været \-> Være  
     ;
     test(nostation(Strandveien))   
     ;
     test(member(adj2(_,_),L))   %%  fremme -> Fremo *
).



%% NB   known_name has failed


believed_name(Brosetveien,Brøsetv,n,Class,1):-    %% Brosetveien %% Special
    value(spellcheck,1),  
    \+ value(textflag,true),  
    \+ unwanted_name(Brosetveien), 
    \+ unwanted_place(Brosetveien),  

    splitstreet0(Brosetveien,Broset,Street), 

    Street \== 'g', %% \+  frig g| rosenbor g %% TA-110401

    sameplace(Broset,Brøset),
 
    composite_stat(Brøset,[street],Brøsetv), 

    classify(Brøsetv,Class).
 %% !  NB  brosetveien 145 = street + station clock %% TA-100312 
 


  
believed_name(N,X,n,Class,1):-    %% 1 = spellcheck
    \+ value(textflag,true),  
    \+ unwanted_name(N), 

    \+ unwanted_place(N),  %% ONLY post check ???  Martin -> Marinen %% TA-100104

%%     \+ xforeign(N), %% Ad Hoc   Opstad -> Okstad * 
%%     \+ underspecified_place(N), 
%% Oasen ->  osen %%  /No  
%% Charolttenlund -> Charlottenlund / Yes 

    value(spellcheck,1), 
    lextoresearch(N,Z),  %% [haldens-street,hallen-nil]) \+-> haldens=Haldens gate

%%     avoid_spurious_street(Z), %% // issamveien -> isdamveien

    member(X1,Z),

    prepare_class(X1,X,Class), 

%%   \+ underspecified_place(X), %% kroken -> kirken /  Charolttenlund->Charlottenlund 

     \+ (X \== N, underspecified_place(N)), %% \+ spell correct to undersp place
     \+ (X \== N,  xforeign(N)), %% \+ spell correct to foreign

    \+ Class=number, %%  not 2 -> name(2,n,number)
    \+ (Class=station, unwanted_station(X)). 

                           
avoid_spurious_street(Z) :- %% avoid rosenborg -> rosenborg _street %% issamveien
    member(R-nil,Z), %% not testmember
    member(R-street,Z),
    !,fail.   

%%// avoid_spurious_street([rosenborg-nil,rosenborg-street]) // fails (OK)
%%// avoid_spurious_street([marienbor-nil,marienbor-street,marienborg-nil]) fails(NO)
%%//avoid_spurious_street([brøset-nil,brøset-street,brøseth-nil,brøseth-street, fails(NO)
%%      brøsethveien-nil,brøsetv-nil,brøsetveien-nil]) ? 


avoid_spurious_street(_).

   


% Utility ?
numberalfa(TenA,Ten):-
    name(TenA,List),
    append(Front,[Last],List),
    Front \== [],
    alphachar(Last),
    alldigits(Front),
    name(Ten,Front).


alldigits([]):-!.
alldigits([D|E]):-
    digch09(D),
    alldigits(E).


digch09(D):-  
    D >= 48, % 0
    D =< 57. % 9

alphachar(D):- 
    D >= 97,   % a
    D =< 113.  % q   PRAGMATIC,   1r is etter in SMS
%    D =< 122.  % z
    

% % % % % % % % %
 
target_name(X):-            % Candidate for auxillary table
    known_name(X),          % Contains duplicates !!!
    \+ irrelevant_name(X). 


irrelevant_name(X):-     %% DONT spellcheck towards these names !
    bus(X);

   unproperstation1(X); %% DONT spellcheck to spurious names ! 
%%  maybe empty 

    unwanted_name(X); 
    xunwanted_place(X);
    X isa man; 
    X isa woman.         %%
%   ....                 %% extendable

unproperstation1(_X):-
    fail.
 
%%    unproperstation(X), %% no bus passes %%  maybe empty
%%    \+ neighbourhood(X).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%% REMOVE NOISE FROM INPUT %%%%%%%%%%%%%%%%%%%
%%                                                       %
%%   All '.','!','?' except the last is removed as noise %


termchar('.'). 
termchar('?').
termchar('!'). 


lextermchar('.'). 
lextermchar('?'). 
lextermchar('!'). 


% Parentheses

/***
remove_noise([   w('(',_)   |Y],V):-  
   value(gpsflag,true), 
   extract_inter_pares(Y,U,  W), %% TA-10114 (U parenthesis content list)
   remove_noise(W,V),

   extract_origins(U). %% neib stations

 extract_origins(U):- %% Not implemented
    ¤¤¤ for(member(quote(O),_pluss,T),remember(gps_origin(O,T))).
***/




remove_noise([W|Y],Z):- 
    noisy(W),
    !,
    remove_noise(Y,Z).



%% Dots

%% Initial template //  Når går bussen ... 

remove_noise([w('.',_),w('.',_),w('.',_)|R],R1) :-
    !,                           
    remove_noise(R,R1).

remove_noise([w('.',_),w('.',_)|R],R1) :-
    !,                           
    remove_noise(R,R1).


remove_noise([w(PP1,_),w(PP2,K)|R],R1):-   %% Always remove duplicate term chars !?.
    lextermchar(PP1), 
    lextermchar(PP2), 
    !,                           
    remove_noise([w(PP2,K)|R],R1).


remove_noise([WN,w(PP,L)|R],[WN,w('.',L)|R1]):- %% KEEP 3. juledag
    lextermchar(PP), 
    \+ value(nodotflag,true), 
    WN=w(N,_), number(N),                        %% KEEP 10.12 
    !,
    remove_noise(R,R1).

remove_noise([w(PP,_),L|R],R1):-   %% DONT KEEP apr. 2001 
    lextermchar(PP),               %% DONT REMOVE LAST !!! 
    value(nodotflag,true),                           
    !,
    remove_noise([L|R],R1).


remove_noise([X|Y],[X|Z]):-!,
    remove_noise(Y,Z).

remove_noise([],[]):-!.

%%%%%%%%%%%%%

%% TA-101210
%% extract_inter_pares(Listwithpars,Listinsidepars,Restlist)  

extract_inter_pares([ w(')',_) |Y],[],Y):-!.

extract_inter_pares([X|Y],[X|Z],U):-!,
    extract_inter_pares(Y,Z,U).

 extract_inter_pares([],[],[]). %% unbalanced ? 




noisy(w(' ',[name(' ',_,_)])).
noisy(w(_,[n_w])).   

%%% noisy(w(')',[[')']])). %% unbalanced %% TA-110128 GPS

noisy(w(LTC,_)):- 
    lextermchar(LTC), 
    (\+ value(textflag,true),
        value(nodotflag,true)),!. 



% Saves a lot of misspellings with '.'


%% Individual Interpretations

synname0(X,Y) :-synname(X,Y). %% TA-110411
synname0(X,X) . %%.%%

synw0(X,Y):-synword(X,Y).
synw0(X,Y):- X=Y. 

synword(X,Y):-dict_module(L),L:synwordx(X,Y). 


%%% synword(X,Y):-synname(X,Y). %% Name synonymes, area independent %% busdat.pl
%%   no,  jernbanestasjon -> stasjon -> en holdeplass

%% synword(X,Y):-synplace(X,Y). %% place names, area dependent language independent %% busdat.pl
%% only synonym as name  (jernbanestasjon -> stasjon -> en holdeplass)


%% pr -synplace-> professor -> noun(professor, ***

%% synword(X,Y):-synbus(X,Y).   %% busdat.pl %% 9a -> 9 -> 9:00 


%% NB   lcode is done before removenoise
lcode1('(',['(']):-value(noparentflag,true),!. 
lcode1(')',[')']):-value(noparentflag,true),!. 


%% lcode1(quote(X),   Y  ):-  %% Du sier 'ok'.
%%    lcode2(X,Y),
%%     !.           



lcode1('.',['.']):-!.  
lcode1(X,n_w):-
    dict_module(L),L:noisew(X), % incl. ( ) if not noparentflag
    !.

lcode1(quote(X),   quote(X)):-!. %% TA-100209   by\'n . -> quote('n .')



lcode1(TenA,nb(Ten,Num)):-   %% T   9a -> 9,alf (not clock)
    value(spellcheck,1),
    \+ unwanted_name(TenA),  %% e.g. osv  
    \+ xunwanted_place(TenA), %% e.g. 3T 
    numberalfa(TenA,Ten),  %% Only 1 letter is allowed ("5bussen")
    (number(TenA) -> Num=num; Num=alf).


lcode1(N1,N2):- 
%     synw0(N0,N1), % if N0 unwanted name, dont apply lcode/name
    lcode2(N1,N2).


%%¤  LCODE2


lcode2(X,Y):-
    synw0(X,X1),
    morph_module(L),L:lcode2(X1,Y).  %% 1

lcode2(N,nb(N1,num)):-
     synw0(N,N1),
     number(N1).  

lcode2(M,nb(N,ord)):-            %% 3  
    synw0(M,M1),
    dict_module(D),  %% must be independent of busanshp 
    D:ordinal2(M1,_,N).           

lcode2(Vei,name(street,n,0)):- 
    streetsyn(Vei).       

lcode2(X,name(X1,n,Class)):-    % Known name or partname 
    \+ unwanted_name(X),        % unwanted_name means dont accept source
    synw0(X,X1),    
    \+ xunwanted_place(X1),   %%  unwanted_place means dont accept target 
    once1(known_name(X1)),
    moshe_class(X1,_,Class), 
    Class \== number.  %% 5 is name of route, 5 is of class number  not qua name   


lcode2(X,name(X1,n,station)):-    %% street is also station 
     \+ unwanted_name(X),         %%  Og
    streetstation2(X,X1). %% 



lcode2(BUSSTUCS,name(BUSTUC,gen,Class)):-  %% Busstucs = bustuc's
    \+ unwanted_name(BUSSTUCS), 
    ends_with(BUSSTUCS,BUSSTUC,s), 
    BUSSTUC \== '', 
    synname0(BUSSTUC,BUSTUC), %% TA-110411
    plausible_name(BUSTUC,Class). 


lcode2(JOHNS,name(JOHN,gen,Class)):- 
    \+ unwanted_name(JOHNS), %% e.g.oss \= os 's 
        %% døden unwanted, dødens OK
    ends_with(JOHNS,JOHN,s), 
    JOHN \== '', 
    plausible_name(JOHN,Class). 


%%%   test-alias_name er ikke TEST %% 

lcode2(X,name(Y,n,Class)):-    % Known name or partname //moved last 
    \+ unwanted_name(X),       % unwanted_name means dont accept source
    synw0(X,X1),  
    try_alias_name(X1,Y),     % PROPER %% (avoid lerkendal syndrome)
    \+ xunwanted_place(Y),       %% unwanted_place means dont accept target ???????
    moshe_class(Y,_,Class), 
    Class \== number.  %% 5 is name of route, 5 is of class number  not qua name   





lcode2(X,[]):- %% e.g. noe 
    synword(X,[]).


xunwanted_place(X):- %% "Roger (Midtstraum) "
   \+ value(teleflag,true),
    unwanted_place(X).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test_known_name(X,X):- %% munkegata -> neighbourhood
    once1(plausible_name(X)). %% = once, but Prolog version independent


 
try_alias_name(X,X):- 
    value(textflag,true),!.

try_alias_name(X,Official):-  
    try_alias_station(X,Official). %% bekasinvegen -> station! bekkasinv

try_alias_name(X,Official):-
    try_alias_street(X,Official).

try_alias_name(X,Y):-  
    xsynplace(X,Y).     %% external to TH 

try_alias_name(X,Y):-    %% area independent 
    synname(X,Y).
    %%% !. %% <--- !!!   st -> stasjon/ sentrumsterminalen

try_alias_name(X,Y):-    %% area independent 
    synplace(X,Y).        %% moved from synword
    %%% !. %% <--- !!!   st -> stasjon/ sentrumsterminalen 

try_alias_name(X,Y):-  %%  Hazardous (buslog ignores letter)
    synbus(X,Y).  
 
try_alias_name(X,Y):-   %% area specific 
    alias_name(X,Y),
    !. %% <--- !!!

try_alias_name(X,Y):- 
    sameloc(X,Y).  %% samename/sameplace

try_alias_name(X,Y):- 
    cmpl(X,[],Y). %% obsolete ? 

try_alias_name(X,Y):-   %% even if not hashed, not unknown 
    sameplace(X,Y).        


sameloc(W,W1) :-  
     sameplace(W,W1)
     ;
     samename(W,W1).

%%%%%%

try_alias_station(X,Official) :-
    splitstreet0(X,Y,_),
    try_alias_station1(X,Y,Official).

try_alias_station1(_X,Y,Official):- %% sveio
    toredef(Y,streetstat,Official), %%  Exit: toredef(s,streetstat,sve) ? 
    \+ station(Official).   


try_alias_station1(_,Bekasin,Bekkasinv) :-
    torehash(Bekasin,Bekkasin),
    toredef(Bekkasin,streetstat,Bekkasinv). %% NB streetstat

%¤

try_alias_street(X,Official):- 
    splitstreet0(X,Y,G),

    G \== 'g', %% frigg \= frig g(ate)  %% TA-110401
               %% rosenborg \=  rosenbor g

    try_alias_street1(X,Y,Official).

try_alias_street1(_X,Y,Official):-  %% sveio
    toredef(Y,streetstat,Official),  %%  Exit: toredef(s,streetstat,sve)
   \+ station(Official).   

try_alias_street1(_X,Y,Official):- 
    synname(Y,Y1),
    toredef(Y1,streetstat,Official).

try_alias_street1(_X,Y,Z):-
    toredef(Y,Street,_),
    testmember(Street,[street,streetstat]),
    append_atoms(Y,'_street',Z).

try_alias_street1(X,Y,Z):-    % innheredsveien, innhereds
    lextorehash0(Y,Y1),        % innhereds, innherreds
    Y1 \= X,   %% Avoid rosenborg = rosenbor+g = rosenborgveien
    toredef(Y1,Street,_),
    testmember(Street,[street,streetstat]), %% osveien 
    append_atoms(Y1,'_street',Z).

%%%%%%%%%%%%%%%%%%%%%%%


known_name(X):- 
    plausible_name(X).        %% fact(X  isa _).

known_name(X):- 
    part_name(X). 

known_name(X):- 
    street_part_name(X). 

known_name(X):- %% not synname (has its own spell)
     sameloc(X,_). %% sameplace/samename %% TA-071030


known_name(X):-
     cmpl(X,[],_). % Only if not spelled 

known_name(X):-        %% low priority
    value(tramflag,true), 
    tramstation(X).   %% Ad Hoc, tramstation is not a class !!!

known_name(X) :-   
    generic_place(X). %% e.g. helsestasjon



%% Part Name %%%%%%%%


part_name(X):- 
   xcomposite(X,Rest,_),
   Rest \== [].  

part_name(X):-  
    nonvar(X), 
    \+ value(tmnflag,true), 
    composite_stat(_First,Rest,_), 
    member(X,Rest). 

part_name(X):-
    cmpl(X,R,_),   %% Partname proper  
    R \== [].      %% dybdalsvei = dybdalsvei,[],dybdals_veg

part_name(street). %% technical

part_name(X):-
    cmpl(_,X,_), 
    atomic(X). 

part_name(X):- 
    explicit_part_name(X). %% busdat.pl

part_name(P) :-   
     compname(X,Y,_Z), %% new, names.pl
     (P==X 
     ; testmember(P,Y)). 

% % % % % % % % % % % % % % % % % % % % %

%%   (compword gives [xxx], not name(xxx,n,o) as before)

part_word(X):-  
  dict_module(L),
  L: rewording(R,_),
  member(X,R).


part_word(X):-  
    ylcompword(X,_Y,_).


part_word(X):- %% GENERATE 
    ylcompword(_,Rest,_), 
    member(X,Rest).


xlcompword(X,Y,Z):-
    dict_module(L),
    L:xcompword(X,Y,Z).


lcompword(X,Y,Z):-
    dict_module(L),
    L:compword(X,Y,Z).



ylcompword(X,Y,Z):-
    dict_module(L),
(
    L:xcompword(X,Y,Z)
    ;
    L:compword(X,Y,Z)

).

ylcompword(X,[],[]):-
    dict_module(L),
    L:synword(X,[]). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


street_part_name(X):-var(X),!,fail. 

street_part_name(X):- %% NB X may  not be a variable %% GENERATE
    composite_road(First,Rest,_), %% regcompstr.pl
    ( X=First;
      member(X,Rest)
    ).


%%%%%%%%%%%%%%%%%%%%%%%%%


plausible_atom(N):- 
    \+ kw(N).


plausible_name(N):- 
    N =='',
    !,
    fail.

plausible_name(N):- 
    !,
    plausible_name(N,_). 


plausible_name(X,C):-
    alias_name(X,Y),
    !,
    plausible_name(Y,C).

plausible_name(N,Class):-
    value(error_phase,0),
    fact(N isa Class),
    atomic(N),
     \+ member(Class,[word,number,time]). 

plausible_name(N,Class):-
    value(error_phase,1),   %% first line 
    plausible_atom(N),      
    \+ instant(N,word),     
    fact(N isa Class).



unknown(W):- 
    \+ lcode2(W,_),
    \+ fact(W isa _),
    \+ member(W,['.',',','!']),
    \+ synword(_,W),
    \+ kw(W).  %% known words 

unknown_words(L,Z):- %% called from main.pl
    unknown_words(unstrict,L,Z).


unknown_words(Strict,L,Z):- 
     set_ops(X,      %% keep list in original seq 
             completely_unknown(Strict,X,L), %% AD HOC
            Z).        

% Write an unknown word warning unless the name is a misspelled fullname. 


completely_unknown(_Strict,Nuss,L):- 
     member(w(Nuss,NameSet),L), 
     member(name(Nuss,unknown,_),NameSet). 


only_part_name(Jakobsli):-  
    part_name(Jakobsli),        % a part_name can also be
    \+ station(Jakobsli),       % a station name
    \+ neighbourhood(Jakobsli). 

%%%% UNUSED
full_name(X):- 
     \+ only_part_name(X). 

%%%%%%%%%%%%%%%  LAYOUT %%%%%%%%%%%%%%%%%%

spread(L):-
    retractall(txt(_,_,_)),
    retractall(ctxt(_,_,_)),
    retractall(maxl(_)),
    cursor := 0,
    sprea(0,L),
    composal.

sprea(M,[X|Y]):-
    N is M+1,
    spreall(M,X,N), %% assert(txt(M,X,N)), 
    sprea(N,Y).

sprea(N,[]):- 
    assert(maxl(N)).


spreall(M,w(X,Z),N):- 
    for(member(U,Z),assert(txt(M,w(X,U),N))).



%%%%%%%%%%  Write a * at position in list

mix(C,L):- %% used by main.pl
    nl,nl,
    star(C), %% * if C=0 
    mx(C,L),
    nl.

mx(C,[X|Y]):- !,
   D is C-1,
   outwx(X), 
   star(D), 
   mx(D,Y).

mx(_,[]):-nl.


star(0):- !,out('*').
star(_).

outwx(w(H,_)):-out(H).

%%%%%%%% Composite Lexical Analysis

%%% txt is initally only elementary steps
%   ctxt is temporarily the new texts
%   finally they are merged



composal :- 
    
     make_exclusive_compwords, %%    delete alternatives

     makecompwords, %% moved first   prof. ---> professor

     makecompnames,

     proxyclean, %% remove problem interpretations %% TA-101027

     cleantxt,

     removeblanks, %%  // NB Destructive

     removedots, %% Moved after cleantxt   

     emptyclosure,
     !.

%%  removeunconnected, %%  john aaens vei \== aaengv
    %% not necessary ???  
%%  Jeg forstår >st< det hjalp med noe restart ang responstiden på SMS igår. 
%%    ==> txt(0, w(jeg,[jeg]), 1).
%%  Destroys error message  
%% jeg forstår * st det hjalp med noe restart ang responstiden på sms igår . 



%% New Predicate

%% Decide Topic :  Decide what the sentence is about



decide_topic:- 
    value(busflag,true),
%%%%%    value(teleflag,true), %% dynamic
    !,
    teletopics(T),
    bustopics(B),

    decide_top(T,B, BT),
    set(topic,BT),
    
    track(1,  (out('* Topic: '),out(BT),nl,nl)). 


decide_topic. 



    
teletopics(T):- %% ad hoc
 

%%   set_of(X,(member(X,[address,firstname,lastname,mailaddress,office,telephone,work,hans,hennes,
%                        his,her,my,it]), 

    set_of(X,(teletopic1(X), %% teledat2

    occurs_in_txt(X)),T).

bustopics(T):- %% ad hoc 
     set_of(X,(bustopic1(X),  %% teledat2
               occurs_in_txt(X)),T).

occurs_in_txt(D):- 
    txt(_,w(_,Term),_),
    
  ( Term=noun(D,_,_,_)
    ;
    (Term=name(BB,_,D), \+ number(BB)) %% 3. etage 
    ;
    Term=verb(D,_,_) 
    ;
    Term=prep(D) %% to from  bus topics 
    ;
    Term=[D] ).

% Pragmatic test of choice of domain 

decide_top(T,B,TB):-
    set_of(U, (member(U,T),\+ member(U,B)),Ztele),
    set_of(U, (member(U,B),\+ member(U,T)),Zbus),
    decide_top1(Ztele,Zbus,TB).


decide_top1(X,Y,tele):-  X \== [], Y  == [],!.
decide_top1(X,Y,bus ):-  X  == [] , Y \== [],!. 
decide_top1(_X,Y,bus ):- testmember(bus,Y),!.  

decide_top1(T,B,K) :-
     length(T,TN),
     length(B,BN),

    (TN > BN -> K=tele
     ;
     TN < BN -> K=bus),
    !.
%else 

decide_top1(_X,_Y,BT):-  %% use the previous topic
    xframe_getvalue(topic,BT), 
    BT \== nil,
    !.

decide_top1(T,B,BT):-  %% no  previous topic, same length
    length(T,TN),  %% go to
    length(B,BN),  %% tore amble
    TN > 0, BN > 0, TN=BN, 

(   testmember(lastname,T);
    testmember(firstname,T);
    testmember(person,T)),
    !,
    BT=tele.



decide_top1(_X,_Y,nil):- !.




%% Decide Domain :  Decide which part of Norway is actual

decide_domain :- true. %% no change


/* %% TA-110208 FARA
decide_domain :- 
    \+ value(tmnflag,true),
    G = tt, % Ad hoc

    actual_domain := G.
*/



decide_domain :- 
 
    value(tmnflag,true),
    !,
 
    set_of_stations_advanced(ZD), 

    traceprint(2,'-domain names-'),

     traceprint(2,' '),
     traceprint(2,ZD),
     traceprint(2,' '),
 
     ( ZD=[U] -> G=U ;
       ZD=[]  -> G=tt ;
                 G=nil),

     actual_domain := G,

    remove_confusing_stations(G).
   
remove_confusing_stations(gb):- 
    !,
    retractall( txt(_, w(sentrum,name(tmn_sentrum,n,station)),_)   ).

    
remove_confusing_stations(tmn):- 
    !,
    retractall( txt(_, w(ts,name(ts,n,neighbourhood)),_)   ),
    retractall( txt(_, w(sentrum,name(sentrum,n,neighbourhood)),_)   ).

    
remove_confusing_stations(tt):- 
    !,
 
    retractall( txt(_, w(sentrum,name(gb_st_olavs_gt, n,station)),_)   ),
    retractall( txt(_, w(sentrum,name(tmn_sentrum,    n,station)),_)   ),
    retractall( txt(_, w(tmn_sentrum,name(tmn_sentrum,n,station)),_)   ).
% etc


remove_confusing_stations(_).  



  
set_of_stations_advanced(Z):-
    set_of_names_with_alts(ZZ),
    make_an_intelligent_decision(ZZ,Z).
   

set_of_names_with_alts(ZZ):-
    set_of(Name,txt(_, w(Name,name(_,n,station)), _),Names),
    set_of((N,Alts), 
             (member(N,Names),
              set_of( Alt, txt(_,w(N,name(Alt,n,station)), _),Alts) ),
           ZZ).

 
make_an_intelligent_decision(_ZZ,[tt]):-
    \+ value(tmnflag,true),
    !.


make_an_intelligent_decision(ZZ,TT):- % Probably subsumed by next rule
    value(tmnflag,true),
    routedomain(G), %% tt first
    uniqueinset(G,ZZ),
    memberinall(G,ZZ),
    !,
    TT=[G].

make_an_intelligent_decision(ZZ,TT):-
    value(tmnflag,true),
    routedomain(G), %% tt first
    memberinall(G,ZZ),
    !,
    TT=[G].


make_an_intelligent_decision(_,gb):-
    value(tmnflag,true),
    value(tramflag,true),  %% TRAM is mentioned
    !.


make_an_intelligent_decision(_,[]):-
    value(tmnflag,true).



make_an_intelligent_decision(_,tt):-
    \+ value(tmnflag,true).




uniqueinset(D,ZZ):-
    member((_,[GBL]),ZZ),  
    thedomainofthestation(GBL,D),
    !.

   
memberinall(G,ZZ):-
    foralltest(   
         member((_,LS),ZZ),
         
        (member(U,LS),
         thedomainofthestation(U,G))).


thedomainofthestation(X,D):-
    routedomain(D),
    route_period(D,M,_,_),
    M \== nil,  
    once1(M:hpl(_,_,X,_)).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

makecompnames :-  

     set_ops((N,W,X,NEXT),syntxt1(N,W,X,NEXT),SYNTSET),     %% sequence preserving tagore programmer/man
     for(member((N,W,X,NEXT),SYNTSET),    matchcomp3(N,X,NEXT)  ),  
  
     for(ctxt(M1,WWW,N1),  assertnewtxt(M1,WWW,N1)).



makecompwords :- %% Try every word
    for( txt(N1,w(Lap,_TAG),_), 
         matchcompword(N1,Lap)).

matchcompword(N1,Lap):-
    lcompword(Lap,TopComputer,Computer),
    N2 is N1+1,
    matchcompwrest(N2,TopComputer,N3),
    lcodew(Computer,WNoun),
    assertnewa(txt(N1,w(Computer,WNoun),N3)). %% first, but only new 


make_exclusive_compwords :- %% Try every word 

    retractall(blockmark(_)), 

    for(   (txt(N1,w(Lap,_TAG),_),\+ blockmark(N1)), 
   
        exmatchcompword(N1,Lap)). 

%% OOPS    mye de vil -> mye 
%%   mye. removes 'de' ' vil'
%%  but 'de' 'vil' are still on the list, and will be reintroduced


exmatchcompword(N1,Lap):- %% delete substituents afterwards 
    txt(N1,w(Lap,_),N2),  %% word is not removed earlier

    xlcompword(Lap,TopComputer,Computer), 

    matchcompwrest(N2,TopComputer,N3),

    for( (txt(Alpha,W,Omega),
         (Alpha >= N1,Omega =< N3)), 
          
          (retractall(txt(Alpha,W,Omega)), %% all presences
           remember(blockmark(Alpha)))),         %% not to be reintroduced

    lcodew(Computer,WNoun),
    assertnewa(txt(N1,w(Computer,WNoun),N3)).
 

matchcompwrest(N1,[Top|Computer],N3):-
    !,
    txt(N1,w(Top,_),N2),
    !,
    matchcompwrest(N2,Computer,N3).

matchcompwrest(N,[],N).

  
lcodew([],[]):-!. 
lcodew(Computer,WNoun) :-   %%
    lcode1(Computer,WNoun). %%   NB   downtown -> syn > hovedterminalen




% % % % % % % % % % % % % % % % % % % % 

emptyclosure :- %% remove all empty edges recursively
    movelasttofront,
    movefirsttoback.



%  move end towards back   

movelasttofront:-
   maxl(Maxl),
   for(txt(M2,w([],[]),Maxl), % dont remove this
       for(txt(M1,A,M2),
          (%% retract(txt(M1,A,M2)),  
           asserta(txt(M1,A,Maxl))))). %% Should be fronted 

% move start  towards front

 movefirsttoback:-
    for(txt(M2,w([],[]),M3),
       (
        for(txt(M3,A,M4),
           (asserta(txt(M2,A,M4)))), %% Should be fronted 
          retract(txt(M2,w([],[]),M3)) 
       )).



cleantxt :- 
      remove_subnames, 
      remove_other_subnames, %% same class, whatever 
      remove_other_nouns, %% TA-110223
      remove_partnames, 
      remove_streetsurp.


%%  When synonym complex names with same start
%%  the shorter versions are removed.

%% lerkendal studentby
%% lerkendal  --> out

%% vikåsen 31.5
%% vikåsen   --> out ###

%% dronningens -> out
%% dronningens gate

proxyclean :- %% TA-101027
     doall(clean1). %% failure driven loop (utility)


clean1 :-  %% hans finnes gate %% TA-110114 fronted
    txt(N0,w(hans,_),N1),
    txt(N0, w(John_aaes_veg,name(John_aaes_veg,_,_)),N2), 
        N2 > N1, 
        txtretract(txt(N0,w(hans,_),N1)). 


clean1 :- %% Odd husbys veg \+ wrong husbys veg %% TA-110105
    txt(N0, w(Odd,adj2(Wrong,nil)) ,N1),
    txt(N0, w(Odd_husbys_street,name(Odd_husbys_street,n,street)), N2),
        txtretract(txt(N0,w(Odd,adj2(Wrong,nil)),N1)), 
        N2 > N1.

clean1 :- %% sig (dk) = seg | Sig berg alle %% TA-101215
    txt(N0,w(sig,_),N1),
    txt(N0, w(_,name(_Sig_berg_alle,_,_)),_N2),
    txtretract(txt(N0,w(_,[seg]),N1)).


 % % % single letter
clean1 :-  %% j aaes veg \= jeg ...  p morsets veg \+ på
    txt(N0,w(J,_),N1), 
    single_letter(J), %% TA-101111
    txt(N0, w(John_aaes_veg,name(John_aaes_veg,_,_)),N2),
        N2 > N1, %% NB >  c.j.hambros vei
        txtretract(txt(N0,w(J,_),N1)). 

% % %

clean1 :-  %% feil retning = wrong retning %% TA-101115
    txt(N0,  w(feil,adj2(wrong,nil)), N1),
    txt(N1,  w(_,noun(_Retning,_,_,_)), _N2),
        txtretract( txt(N0, w(feil,noun(error,sin,u,n)), N1)). 


 
clean1 :-  %% k.o. thornæs \= kl 0 thornæs
    txt(_N0,w(k,[k]),N1),
    txt(N1,w('.',['.']),N2),
        txtretract(txt(N2,  w(o,nb(0,num)), _N3)).

clean1 :- %% fra vÃ¦re til sorgenfri 
    txt(_1, w(_Fra,prep(_From)), N2),
    txt(N2, w(være,name(være,n,station)), N3),
    txt(N2, w(være,verb(be,inf,fin)),N3), 
        txtretract( txt(N2, w(_,verb(be,inf,fin)),N3)).

clean1 :-  %% kan jeg reise == \+ kan jeg trip 
    txt(N2, w(reise,verb(go,inf,fin)), N3),
    txt(_1, w(Jeg,[Jeg]), N2),
    testmember(Jeg,[jeg,du,han,hun,vi]),
       txtretract( txt(N2, w(reise,noun(trip,sin,u,n)), N3) ).

clean1  :- %% si det nå
     txt(_,w(det, [det]), N3) ,
        txtretract( txt(N3, w(nå,verb(reach,inf,fin)),_)). 

clean1  :- %% er nå fin=now %% TA-101117
     txt(_,w(_Er,verb(_,pres,fin)), N3),
        txtretract( txt(N3, w(nå,verb(reach,inf,fin)),_)). 

clean1 :- %% bu = buss, \= bo! 
    txt(N0, w(BU,verb(live,imp,fin)), N1),
          txtretract( txt(N0, w(BU,verb(live,imp,fin)), N1) ).


%¤¤¤¤¤


% remove subsets of station names  %% dalen removed from dalen hageby !! (Rough)

%% remove txt(M1,..,M2) if text(M1,..,M3) and conditions are satisfied

remove_subnames :- 

 for( (txt(M1, w(_,name(_,n,C1 )),M3),  %% comparison
    
     (C1==station;C1==street;C1==neighbourhood)       ),     %%  dalen_hageby  station

      for( (txt(M1,w(Name2,name(NAME,n,C2)),M2), %% .. candidate for elimination

      (  (C2==station;C2==street;C2==neighbourhood;C2=city;
             C2=company;C2=man;C2=woman;C2=firstname;C2=lastname) ,                  
       ( 

        ( M2 =< M3, (C1 \== street,C2==street)); %% neighbourhood kills street
                                                 %% rosenbor g %% TA-110314
        ( M2 =< M3, (C1== street,C2==company)); %% AtB = Kongens gate 34
 
        ( M2 < M3))
        

        )),    
                                        
          txtretract(txt(M1,w(Name2,name(NAME,n,C2)),M2)) 

      )
   ).

remove_other_nouns :- %% rutebilstasjonen noun , also name %% TA-110223
                      %% hurtigruta     name|noun(boat)    %% TA-110614
 for( (txt(M1, w(RBS,name(RBS,n,Neib )),M3),   (Neib==neighbourhood;Neib==station)),
 

      for( (txt(M1,w(SOL,noun(RB,Sin,Def,n)),M2), %% remove this? %% TA-110627
      (             %sol     %sun                       
       
        ( M2  =< M3 )  %% (studenter) samfundet %% TA-110627
                       %% sol siden
      )),    
                                        
          txtretract(txt(M1,w(SOL,noun(RB,Sin,Def,n)),M2)) %% TA-110627

      )
   ).

remove_other_subnames :- %% Lingit A/S >>  Lingit (Same class)

 for( txt(M1, w(_,name(_,n,C1 )),M3),
 

      for( (txt(M1,w(Name2,name(NAME,n,C1)),M2), %% remove this?
      (                                         
       
        ( M2  < M3 )  

      )),    
                                        
          txtretract(txt(M1,w(Name2,name(NAME,n,C1)),M2)) 

      )
   ).


txtretract(X) :- retractall(X),!. %% TA-101110
txtretract(_). %% unnec

remove_partnames :- %% remove now redundant  part names
    for( (txt(M1,w(W,name(A,B,0)),N1),\+ generic_place(W)),
         retract(txt(M1,w(W,name(A,B,0)),N1))).
%%%      assert(txt(M1, w([],[]),N1))) ).       %% <--- NO


remove_streetsurp:- % Remove streetname (single) if also station/neighbourhood etc.
     for( (txt(M,w(A,name(_a1,_,street)),N),txt(M,w(A,name(A2,_,K)),N), K \== street, \+unproperstation1(A2)),
           retract(txt(M,w(A,name(_a1,_,street)),N))).

%% suspended  :   error marking becomes meaningless (too early) 
% når må jeg ta bussen * til heimdal sentral banestarsjon før kl 13 . 10 fra kystad ? 
% når må jeg ta bussen til heimdal sentral * banestarsjon før kl 13 . 10 fra kystad ? 

removeunconnected :-  removeunconnected1.

/*
removeunconnected :- 
    removeunconnected1,
    removeunconnected1. %% NB if last is removed, then the previous BECOMES unconnected
*/

 
removeunconnected1 :-

    for(   (txt(M1,w(W,NAMEABC),N1), unconnectedtxt(M1,N1)),
           retractall(txt(M1,w(W,NAMEABC),N1))). %% may be more !



/*
%%  prolong forwards  
removeblanks :- %% txt(0, w(noe,[]), 1). %% NB Destructive
   for(   (  txt(M1, w(_W,[]), N1),          %% noe mat
             txt(N1, Whatever, N2))
         ,
           
          (  %% retract( txt(M1,w(W,[]),N1)), // shall be reused  
             retract( txt(N1,Whatever,N2)),
             asserta( txt(M1,Whatever,N2))  %% assertz 
          )
        ).

*/

%%  prolong backwards 

removeblanks :- %% txt(0, w(noe,[]), 1). %% NB Destructive
   for(   (  (txt(M1, w(_W,Emp), N1),(Emp==[];Emp==['-']; Emp=n_w)),  
              txt(M0, Whatever, M1) )
         ,
           
          (  retract( txt(M0,Whatever,M1)),
             asserta( txt(M0,Whatever,N1))  %% assertz 
          )
        ).


%% strandv. 30 --->  strandveien   < strandveien 30 

removedots :- \+ value(nodotflag,true),!. %% Multiple sentences , keep dot

%% Jeg skal til S. Sælands vei      


removedots :- %% gløs. mot  dravoll %% NB swaps streets and neighbourhood
   for(   (  txt(M1,w(W,name(Gløs,GN,Stat)),N1),
             txt(N1,w('.',['.']),N2), 
             \+ maxl(N2),  %%<- not remove the last
             testmember(Stat,[station,neighbourhood])),
          (
             retract( txt(M1,w(W,name(Gløs,GN,Stat)),N1)),
             retract( txt(N1,w('.',['.']),N2)),

             assertz( txt(M1,w(W,name(Gløs,GN,Stat)),N2)) %% neib,stat  < street
%%                 % Last
          )).

 
unconnectedtxt(M1,_N1):- M1 > 0, \+ txt(_,w(_,_),M1).             
unconnectedtxt(_M1,N1):- maxl(MAX), N1 < MAX, \+ txt(N1,w(_,_),_).  

%  haldens is not street in itself, just a name prefix 

%%      erlends-street  means just   elendse is a street PREFIX 

prepare_class(CName,Officialname,Class):-
    moshe_prepare(CName,AName),
    moshe_class(AName,Officialname,Class).   


moshe_prepare(X-street,XYstreet):-!,
     append_atoms(X,'_street',XYstreet).  %% street   strandvegen = strand_street 

moshe_prepare(X-streetstat,XYstreet):-!,
     append_atoms(X,'_street',XYstreet).  %% station   strandvegen = strand_street 

moshe_prepare(V-nil,W):-!,
    (sameloc(V,W);      %% TA-071030
     V=W).

moshe_prepare(V,V).




moshe_class(W,W,Stat):-
    classify(W,Stat),
    \+ (Stat=station,unwanted_station(W)). 

/*  %% TA-100311   composite_stat(brøset_street,[],brøsetv) 
    %% does not make brøset_street isa station

moshe_class(Strand_street,Strandveien,station):- 
    composite_stat(Strand_street,[],Strandveien). 

*/


moshe_class(W,W,0):- once1(street_part_name(W)). 

moshe_class(W,W,0):- once1(part_name(W)). 

moshe_class(W,W1,0):-  %% lerkendal -> name(lerkendal,0) .. stadion
    sameloc(W,W1),
    once1(part_name(W1)). 

%% moshe_class(W,W,place) :-
%%    generic_place(W).

%% Non recursive

classify(W,C):-fact(W isa C).  

classify(W,place):- generic_place(W). 

% % % % % % % %



matchcomp3(N0,Prof,N1):-
    xcomposite(Prof,Brochsgate,Ident),
    Brochsgate \== [], %% sve = composite_stat(sve,[],sve). 
    skip_dotx(Brochsgate,N1,N2),   %%  N2=N1, %%  after 1. // test %%  prof. brochs gate
                                   %% dont skip if ['.'] in match list
    matchrestassert(N0,N2,Brochsgate,Ident).
    %% ! %% < multiple solutions > St Olavs gt

matchcomp3(N0,_,_):- 
    value(teleflag,true),
    matchcomp2(N0).


matchcomp3(N,Proff,N1):- 
    sameloc(Proff,Prof), 
    skip_dot(N1,N2),  
    moshe_class(Prof,_,Class),

    assertnewa(ctxt(N,w(Prof,name(Prof,n,Class)),N2)). %% TA-110520
     %% a => bynesveien -> bryns vei ?

           %% depends/if street hareveien 10 -> hare_street-10/ havre_street-10
 %% nb reorders sequence, error corrected names come before corrcet names

matchcomp3(N0,P,_):- 
    single_letter(P), 

    P \== d, %% Dora 1 %% Ad Hoc 
    P \== i, %% i bussen = ikea bussen *      %% Ad Hoc
    P \== g, %% g n = gløshaugen n/ går neste %% Ad Hoc
    P \== t, %% t(rondheim) sentrum    til    %% Ad Hoc

    skip_dot(N0,N1),
    xcomposite(Prof,Brochsgate,Ident), 
    begins_with(Prof,P,_),    %% utility.pl 

    Brochsgate \== [], 
    Brochsgate\==[street],    %% this case is covered elsewhere // r g = all streets r.
   \+ (Brochsgate=[Q],streetsyn( Q)), %% e.gate => elgeseter 

    N2 is N1+1,
    matchrestassert(N0,N2,Brochsgate,Ident).



%% ROADS

matchcomp3(N,Prof,N1):- % Prof Brochs gate 20 
	xcomposite_road(Prof,Brochsgate,Ident), %% street, composite or not

%%%    N1 is N+1,   
	skip_dot(N1,N2), %% s. p andersens vei 
   matchreststreet(N,N2,Brochsgate,N3), 
   skip_dot(N3,N4),
   anystreetnumberassert(N,Ident,N4). % whole with number



% Match forename initials on roads.  Expensive
matchcomp3(N0,P,_):- % P.  Brochs gate 20 
   single_letter(P), 
   skip_dot(N0,N1),
	xcomposite_road(Prof,Brochsgate,Ident),  
   Brochsgate \== [],    
   Brochsgate \==[street], %% this case is covered elsewhere // r g = all streets r.
   begins_with(Prof,P,_),   
	N2 is N1+1,
   matchreststreet(N0,N2,Brochsgate,N3), 
   anystreetnumberassert(N0,Ident,N3).  % whole with number






%%%  composite person names
   
matchcomp2(N0):-  %% Tore Ambles -> ToreAmbles
    N1 is N0+1,
    N2 is N1+1,
    txt(N0,w(_Tor,    name(Tor,n,firstname)),N1),
    txt(N1,w(_ambles,name(Ambl,gen,lastname)),N2),
    lookupdb2(Tor,Ambl,ToreAmble),
    moshe_class(ToreAmble,_,Class),
    assert( ctxt(N0, w(ToreAmble,name(ToreAmble,gen,Class)), N2)),
    retract( txt(N0,w(Tor,_),N1)), 
    retract( txt(N1,w(_ambles,name(Ambl,gen,lastname)),N2)).    %%

 
matchcomp2(N0):- %% Tore Amble
    N1 is N0+1,N2 is N1+1,
    txt(N0,w(_Tor,    name(Tor,n,firstname)),N1),
    txt(N1,w(_Ambles,name(Ambl,gen,lastname)),N2),
    lookupdb2(Tor,Ambl,ToreAmble),
    moshe_class(ToreAmble,_,Class),
    assert(ctxt(N0, w(ToreAmble,name(ToreAmble,n,Class)), N2)). 

%%%¤¤  MATCHRESTASSERT  

matchrestassert(N0,N1,[],Ident):- 
    value(tmnflag,true),          %% No streets as such
    !,
    moshe_class(Ident,_,Class),
    assertnewa(ctxt(N0,w(Ident,name(Ident,n,Class)),N1)).  %%  suspect


matchrestassert(N0,N1,Brochsgate,Ident):-
    matchreststreet(N0,N1,Brochsgate,N3), %% street if actual
    anystreetnumberassert(N0,Ident,N3).   



%%%¤¤  MATCHRESTSTREET  (stations or street)
   
matchreststreet(_,N,X,N1):- 
    X \== [], 
    atomic(X), 
    !,
    matchsyntxt(N,X,N1),
    !. 

matchreststreet(_,N,[],N):- 
    !,
    true.

 
matchreststreet(N0,N,[X|Z],N4):- %% First occurrence
    skip_dotx([X|Z],N,NN),  
    matchsyntxt(NN,X,N1),
    skip_dotx(Z,N1,N2),  %% K. O. Thornæsv. %% \+ skip '.' %% TA-100118
       (Z \== [] -> Opt=true;Opt=false), 
    matchreststreet5(N0,N2,Z,N4,Opt), 
    !. 


%

matchreststreet5(N0,N,[X|Z],N4,Opt):- 
    skip_dotx([X|Z],N,NN),  
    matchsyntxt(NN,X,N1),
    skip_dotx(Z,N1,N2),  %% K. O. Thornæsv. %% www.klaburuten.no %% \+ skip '.'
    matchreststreet5(N0,N2,Z,N4,Opt),   %% TA-100118
    !. 
 

matchreststreet5(_,N,[],N,_):- 
   !,
   true.


%% "street" can be omitted under certain conditions
%% 1. the name contains at least 2 items


matchreststreet5(_,N2,[Street],_,_):- %% skip vei allowed if not "vei" follows 
    streetsyn(Street), %% Street is to be matched
    txt(N2, VVV,_), %% Street exists in txt

(    
     VVV=w(V,_),streetsyn(V)  ;
 
%%     V=[alle]),       %% olav engelbrektssons alle 5
     VVV=[alle]),       %% olav engelbrektssons alle 5  %% RS-130624

    !,fail.            %% no skip


matchreststreet5(N0,N2,[Street],N2,true):- %% skip vei allowed if not "vei" follows  

    (Street==street;streetsyn(Street);Street=alle), 
  
 \+ txt(N2, w(_,[plass]),_),    %% Aleksander Kiellands plass 
 \+ (txt(N0,w(O,_),_n2), unwanted_place(O)), %% o -> osveien 
 \+ txt(N0,w(Vold,name(Voll,n,station)),N2), %%  vold -> voll, NOT vollgt
 \+ txt(N0,w(Vold,name(Voll,n,neighbourhood)),N2),
 \+ txt(N0,w(Reppe,name(Reppe,n,station)),_n2), %% not Reppevegen if Reppe is station
 \+ txt(N0,w(Reppe,name(Reppe,n,neighbourhood)),_n2).



% %

anystreetnumberassert(N1,Ident,N2) :- 
   nonvar(Ident),
%%    \+ Ident isa street,  % Tonstadgrenda isa street & station 
   assertstreetxt(N1,Ident,N2).    


anystreetnumberassert(N0,Ident,N1) :-
   Ident isa street, %%   make it safer for street stat 
   parsestreetnumber(N1,Num,N2),  %%   yggdrasilvn. nr. 9
   Num < 500,  %%%%%%%%   Pragmatic test for street numbers/ not clock !!!

   \+ monthnamenext(N2),     %% Vikåsen 17 . mai 
   \+ monthnumbernext(N2),   %% Vikåsen 17 .5  
   \+ nameddatenext(N2),     %% Vikåsen 2. juledag
   \+ colonnext(N2),         %% tonstadgrenda 8:13 
   \+ minutesnext(N2), 

%%%%%%   \+ numbernext(N2),  %% tonstadgrenda 8 13  // sandmoveien 22 30.7.2004

   !,  

	assertnewz(txt(N0,w(Ident-Num,name(Ident-Num,n,street)),N2)). %% TA-110509

%%       a!   Johan Bojers vei = Johan (Bojer)
%%       z!  hareveien < havreveien 
%%       z!  havrevegen < havnegata
                                                              
%% assertnewa //  Reverses order, strandveien -> strind_street , strand_street < 
%% yggdrasilv syndrome
%% before streetname only  %% Yggdrasilv 9 / Yggdrasilv 9:30


anystreetnumberassert(N1,Ident,_N2) :- 
    Ident isa street,
    txt(N1,w(_,name(Ident,_,_)),_), %% exists already <-- but not anywhere
    !.

anystreetnumberassert(N1,Ident,N2) :- 
   Ident isa street, %% street without street number
   assertstreetxt(N1,Ident,N2).     %% Last   



assertstreetxt(N,Ident,N2):- %% priority Station before STREET
    nonvar(Ident),
    set_of(C,(  classify(Ident,C), C \== street),Z),
    member(Class,Z), %% Ad Hoc, avoid stupid backtracking

    assertnewz(txt(N, w(Ident,name(Ident,n,Class)), N2)). %% TA-110520

    %% a!  -> bynesveien -> bryns vei ?
    %% a!  ->  hareveien -> havreveien
    %% z!  ->  Johan Bojers vei = Johan (Bojer) ...

assertstreetxt(N,Ident,N2):-  %% priority Station before STREET 
    Ident isa street,

    assertnewz( %% NOT FIRST because shadows station (Mikkelveien) 
    %%       a => bynesvien = bryns vei %% TA-110520 NB

                %% Johan Falkbergets vei , Johan = name, Falkberget gets unconnected
                %% Johan Falkbergets vei is last, John is taken, 
      txt(N, w(Ident,name(Ident,n,street)), N2)).  



%%

monthnamenext(N):-      %%  Vikåsen 17 mai
    skip_dot(N,N1), 
    txt(N1,w(_Mai,name(_May,n,month)),_),
    !.

monthnumbernext(N):-   %%  Vikåsen 17.5 
    skip_dot(N,N1),  
    txt(N1,w(Nu,nb(Nu,_)),_),
    Nu >=1, Nu =< 12, % nec?
    !.

nameddatenext(N):-  %%     Buss 2. juledag
    skip_dot(N,N1), 
    txt(N1,w(_,name(XD,_,_)),_),
    named_date(XD,_),         %%  busdat.pl
    !.


colonnext(N):-  %% tonstadgrenda 8:13 
    txt(N,w(':',_),_N1).


minutesnext(N):-  %% tonstadgrenda 8.13 
    txt(N,w('.',_),N1),
    txt(N1,w(MM,nb(MM,num)),_N2),
    MM >= 0, MM < 60.


numbernext(N):-  %% tonstadgrenda 8 13
    txt(N,w(MM,nb(MM,num)),_N2).

   
parsestreetnumber(N1,Num,N4) :-  %%  yggdrasilvn .  nr. 9
    skip_superf_street(N1,N11), %% TA-100114  garmannsvei vei 3 .
    skip_nr(N11,N2),
    txt(N2,w(_N,nb(Num,_Num)),N3), %% 9a -> nb(9,alf) 
    Num < 500,  %%  Pragmatic test for street numbers/ not clock 
    skip_letter(N3,N4).


skip_nr(N2,N4):-  
    txt(N2,w(N,_),N3), testmember(N,[n,nr,nummer]), 
    skip_dot(N3,N4),
    !. 
%% skip_nr(N2,N3):-  txt(N2,w(nummer,_),N3),!. %% unnec

skip_nr(N2,N2).

skip_superf_street(N1,N11) :- %% TA-100114  (garmannsvei) vei 3 
     txt(N1,w(_,noun(street,sin,u,n)),N11),
     !.
skip_superf_street(N1,N1).







skip_letter(N3,N4):-
    txt(N3,w(C,[C]),N4),
    testmember(C,[a,b,c,d,e,f,g,h,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z]), 
    !.

skip_letter(N,N). 
% g. after street names may be abbrev.   gt.  


skip_dotx(L,N1,N2):-  %% dont skip if '!' in matchlist
    (L='!';L=['!'|_]),!,N2=N1. %% TA-110116

skip_dotx(L,N1,N2):-  %% dont skip if '.' in matchlist
    (L='.';L=['.'|_]),!,N2=N1.

skip_dotx(L,N1,N2):-  %% dont skip if '-' in matchlist 
    (L=('-'); L=['-'|_]) , ! , N2=N1.

skip_dotx(L,N1,N2):-  %% dont skip if '-' in matchlist 
    (L=('-');L=['-'|_]),!,N2=N1.


skip_dotx(_,N1,N2):-
   skip_dot(N1,N2).

skip_dot(N2,N2):- value(textflag,true),!.    %% !!! 

skip_dot(N2,N3):-txt(N2, w('!',['!']), N3), \+ maxl(N3),!.  %% TA-110116 dora ! kl. 18:15 
skip_dot(N2,N3):-txt(N2, w(':',[':']), N3), \+ maxl(N3),!.  %% St:Olav:  %% TA-100208
skip_dot(N2,N3):-txt(N2, w('.',['.']), N3), \+ maxl(N3),!.  %% dont skip last 
skip_dot(N2,N3):-txt(N2, w('-',['-']), N3), \+ maxl(N3),!. 

skip_dot(N2,N2).


%%%¤¤ XCOMPOSITE

xcomposite(First,_Restlist,_Key) :- 
    var(First),
%%     value(teleflag,true), %% ???
    !,
    fail.
 
xcomposite(First,Restlist,Key) :-
    compname(First,Restlist,Key).   


xcomposite(First,Restlist,Key) :-  
    composite_stat(First,Restlist,Key).


xcomposite(First,Rest,Key) :- 
    cmplacebus(First,Rest,Key). %% 9,an


xcomposite(A,B,D):- 
    value(tmnflag,true),
    domain_module(_,Tram),
    Tram \== nil, 
    Tram:composite_stat(A,B,C),
    (C=D
    ;
    xsynplace(C,D)). 



xcomposite_road(ProfY,Brochsgate,Ident):-
	composite_road(ProfY,Brochsgate,Ident).

%%   osloveien %% osloveien etter 12 
xcomposite_road(Abels_gate,[],Abels_gate):-
	streetstat(Abels_gate,_,_,_,_).


cmplacebus(X,Y,Z) :- 
    cmpl(X,Y,Z).  
   

cmplacebus(X,Y,Z) :-
    cmbus(X,Y,Z).  %% busdat.pl
   

cmplacebus(X,Y,Z) :-
    member(Y,[an,eren,ern]), %% a is a bus mark %% NOT 'en' passerer buss 9 en holdeplass
    regbus(X),  
    X=Z.     


%%%%

syntxt1(N,Vei,Veg,N1):- % strict
    txt(N,Word,N1),     
    (Word = w(Vei,name(Veg,_N_,_));  %% havstads gen ok
     Word = w(Vei,[Veg])).


syntxt(N,Veg,N1):- %%   liberal
    txt(N,Word,N1),
    (Word = w(Veg,_);
     Word = w(_Vei,[Veg]);
     Word = w(_Vei,name(Veg,n,_))).


%%¤¤¤  MATCHSYNTXT

matchsyntxt(N,street,N1):- 
    syntxt(N,Vei,N1),
    streetsyn(Vei).       

matchsyntxt(N,Veh,N1):- %% match lexicals with hash
     syntxt(N,Veg,N1),
     lextorehash0(Veh,V),
     V == Veg.    %% Precaution 


assertnewtxt(M1,WWW,N1):-
        assertnewz( txt(M1,WWW ,N1)). %% TA-110520
     %% assertnewa NB  latecomers are spell corrected


assertnewa(P):-P,!;
    asserta(P).

assertnewz(P):-P,!; %% last, dont shadow stations
    assert(P).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Spell correction 
%% Moved out -> spellcorrpreds
%%
%%%%%%%%%%


substreet0(X,Y):- 
    substreet1(X,Y).
substreet0(X,X).


substreet(X,Y):-
    substreet1(X,Y),
    !.                    %% <--- !
substreet(X,X).


substreet1(Oslov,Oslostreet):-
    streetsyn(V),
    ends_with(Oslov,Oslo,V),
    (
     ends_with(Oslostreet,Oslo,'_street')). 


splitstreet0(Oslov,Oslo,V):- 
   streetsyn(V),
   ends_with(Oslov,Oslo,V).


%% A station ending with suffix gt shall also be a possible Station 

streetstation2(Gudrunsgt,Gudruns_gt):-
    splitstreet0(Gudrunsgt,Gudruns,_),
    composite_stat(Gudruns,[street],Gudruns_gt).
   
 

%% streetsyn is moved to busdat (common to N and E)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



lextoresearch(X,[X]):-number(X),!.

lextoresearch(X,_):- \+ atom(X),!,fail.


lextoresearch(X,[X]):-
    textlength(X,N), %% utility.pl
    N=< 4,     %% dont spellcheck NITH -> NTH
    !,         %% doesn't mean it is found
    toredef(X,_,_). 


lextoresearch(X,Z):-
    textlength(X,N), 
    N > 4,      %% dont spellcheck NITH -> NTH
    set_of(Y-Street,lexcandsearch(X,Y,Street),Z).


%%%%

teststr(U,Y) :- 
    (synname(U,Y);synplace(U,Y)), 
    \+ xforeign(Y), %% strans -> strand (even if komm) | avoid gøran -> gran 
    \+ streetsyn(Y).  %% avoid wigens -> vegen 


lexcandsearch(X,Y,Street):-   %% amblesgate  
    lexsplitroad(X,U,Street), %% _ ambles street 
    teststr(U,Y). 


lexcandsearch(X,Y,Street):-
    lexsplitroad(X,U,Street1), %% dalgård vegen |  stransvegen
    lexhash(U,Y,Street),       %%  strans -> sætran ..    
    
    subordstreet(Street1,Street), %% street < street | streetstat
                                  
    \+ (xforeign(Y), \+ part_name(Y)),      %% avoid gøran -> gran
    \+ streetsyn(Y).    %% avoid wigens -> vegen %% TA-071013 

%%  brannåsen -> buran      NO
%%  skovgården -> skovgård  YES
%%  dragviold -> dragvoll   YES (no loop)

%%%%

%%   subordstreet(street,nil) //NO strans_street \+  -> sætran

subordstreet(street,streetstat). %% no cut
subordstreet(X,X).
%%

lexhash(U,Y,Street):-    %% Hashtable
    lexhash1(U,Y,Street). 

lexhash(U,Y,Street):-    %% Lewin + Hashtable   %% Johan,Y
    lexdevcand(U,S),                            %% Johan,John
    lexhash1(S,Y,Street),
                  S \= U. %%  UNTESTED %% TA-110511

lexhash(X,Z,Street):-       %% Soundex + Hashtable 
    textlength(X,N), N > 5, %% mårra -> mara -> marka 
    tucsoundex(X,Y),     
    lexhash0(X,Y,Z,Street). 


lexhash0(_X,Y,Z,Street):- 
   lexhash1(Y,Z,Street). 

lexhash0(X,Y,Z,Street):-  %%  Soundex + Lewin with care
    \+toredef(X,_,_),     %% avoid  spurious slåss -> slas -> sas
    X \== Y,              %% skovgården -> skovgard %% slåss -> slas
    \+toredef(Y,_,_), 
    textlength(Y,M), M > 4, %% \+ sletten -> slet -> set  
    lexdevcand(Y,Y1),       % slas -> sas
    lexhash1(Y1,Z,Street).  % X=brattås, Z=bauta ??


lexhash1(X,Y,Street):-  %% Alternativ A Lewin distance
   lextorehash0(X,Y),
   toredef(Y,Street,_).

 
lexdevcand(U,Y):-
	 name(U,[F|V]),
    delete1(_,V,W),
    name(Y,[F|W]).


lexsplitroad(X,Y,Street):-
    streetsyn(V),       %% lex.pl
    ends_with(X,Y,V),
    V \== 'g', %% frig g, rosenbor g %% TA-110401

%%%%%%%%%%%    !,      issamveien
    Street=street. %% !trap %% braøsetveien \+ nil





lexsplitroad(X,X,nil).

lextorehash0(X,X).
lextorehash0(X,Y):-
    torehash(X,Y).   %% namehashtable.pl 



single_letter(X):- %% TA-101117
    atom(X),
    iso_atom_chars(X,[ASCII]),
    (X=='æ';X=='ø';X=='å';

     (ASCII >=97 ,ASCII =<122)), %% a--z
    !.
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% FILE tucsoundex.pl
%% CREATED TA-041020
%% REXVISED TA-100205

%% TUCsoundex // Replace in sequence recursively


%% Specific (longest first)

  rw1([a,i,l,l],       X:[a,l,l|X]).   %  aill -> all

  rw1([h,a,ø,y],       X:[h,ø,y|X]).   %  hÃ¸yskoleparken 
  rw1([m,a,n,d],       X:[m,a,n,n|X]). %  tiedemand %% TA-100204
  rw1([s,c,h,j],       X:[s,j|X]).     %  schj -> sj 
  rw1([s,c,h,i],       X:[s,j|X]).     %  schi -> sj 
  rw1([s,h,c,i],       X:[s,j|X]).     %  shci -> sj %% spell


  rw1([c,h,r],         X:[k,r|X]).     %  chr  -> kr
  rw1([c,h,i],         X:[s,j,i|X]).   %  chi  -> sji
  rw1([c,h,o],         X:[s,j,o|X]).   %  cho  -> sjo %% choice 
  rw1([c,h,u],         X:[s,j,u|X]).   %  chu  -> sju
  rw1([i,e,d],         X:[i,d|X]).     %  tiedeman -> tideman  
  rw1([i,æ,'½'],       X:[å|X]).       %  iæ½   -> å  %% flatiæ½stoppen
  rw1([o,c,h],         X:[o,k|X]).     %  och  -> ok
  rw1([o,i,l],         X:[o,l|X]).     %  oil  -> ol
  rw1([r,o,p],         X:[r,u,p|X]).   %  rop  -> rup   Most common
%%  rw1([r,s,k],       X:[s,k|X]).       %  rsk  -> sk  norsk
  rw1([s,c,e],         X:[s,j,e|X]).   %  sce  -> sje  scene/sceldrup 
  rw1([s,c,h],         X:[s,j|X]).     %  sch  -> sj 
  rw1([s,c,i],         X:[s,j,i|X]).   %  sci  -> sji  %% (science)
  rw1([s,h,c],         X:[s,j|X]).     %  shc  -> sj   %%  spell
  rw1([s,c,j],         X:[s,j|X]).     %  scj  -> sj   %% 
  rw1([s,h,e],         X:[s,j,e|X]).   %  she  -> sje 
%%   rw1([s,k,e],       X:[s,j,e|X]).  %  ske  -> sje  %% norske
  rw1([s,k,j],         X:[s,j|X]).     %  skj  -> sj 
  rw1([s,k,y],         X:[s,j,y|X]).   %  sky  -> sjy 
  rw1([s,t,j],         X:[s,j|X]).     %  stj  -> sj   %%  stjørdal ->
  rw1([t,i,e],         X:[t,i|X]).     %  matiesen -> matisen
  rw1([t,i,o],         X:[s,j,o|X]).   %  tio  -> sjo
  rw1([u,r,g],         X:[o,r,g|X]).   %  urg  -> org 
  rw1([v,i,o],         X:[f,i,o|X]).   %  vio  -> fio

  rw1([a,e],           X:[e|X]).       %  ae   -> e

  rw1([a,'¦'],         X:[e|X]).     %  ae   -> e  steinkjÃ¦r?
  rw1([a,'|'],         X:[e|X]).     %  ae   -> e  steinkjÃ|r?

%%  rw1([a,f],           X:[a,v|X]).     %  af   -> av  drafiol -> draviol ->drafiol ooooooooooo
%%  rw1([a,y],           X:[ø|X]).       %  ay   -> ø %%  graaemÃ¥lna -> graaemaylna 
  rw1([a,y],           X:[å|X]).       % PrestegÃ¥rdsjordet? 
  rw1([a,ø],           X:[ø|X]).       %  aø   -> ø [-> o] %%           rÃ¸ros ->  raøros 
  rw1([a,a],           X:[å|X]).       %  aa   -> å (å-trøbbel) %% TA-071217
  rw1([c,a],           X:[k,a|X]).     %  ca   -> ka
  rw1([c,e],           X:[s,e|X]).     %  ce   -> se
  rw1([c,i],           X:[s,j|X]).     %  ci   -> sj
  rw1([c,h],           X:[k|X]).       %  ch   -> k  %% chu -> sj ,
  rw1([c,k],           X:[k|X]).       %  ck   -> k  
%%   rw1([d,s],           X:[t,s|X]).    %  ds   -> ts  // sigurd
  rw1([d,t],           X:[t|X]).       %  dt   -> t  
%%  rw1([e,i],           X:[e|X]).       %  ei   -> e   %% Meierier <-- /veien->v->[]
  rw1([e,u],           X:[ø,y|X]).     %  eu   -> øy  
  rw1([g,h],           X:[g|X]).       %  gh   -> g
  rw1([g,j],           X:[j|X]).       %  gj   -> j  
  rw1([h,n],           X:[n|X]).       %  hn   -> n
  rw1([h,k],           X:[k|X]).       %  hk   -> k
  rw1([i,c],           X:[i,k|X]).     %  ic   -> ik
%%  rw1([i,e],           X:[i|X]).     %  ie   -> i %% Meierier
  rw1([k,h],           X:[k|X]).       %  kh   -> k
  rw1([k,y],           X:[s,j,y|X]).   %  ky   -> sjy %% Kystad/ Kyvann <-- 
  rw1([l,d],           X:[l|X]).       %  ld   -> l
  rw1([o,e],           X:[ø|X]).       %  oe   -> ø ( -> o) 
  rw1([o,u],           X:[a,u|X]).     %  ou   -> au
  rw1([o,y],           X:[ø,y|X]).     %  oy   -> øy 
  rw1([q,u],           X:[k,v|X]).     %  qu   -> kv
%%   rw1([r,s],           X:[s|X]).      %  rs   -> s %% norsk -> nosk
%%  rw1([s,h],           X:[s,j|X]).     %  sh   -> sj %% sammfunnshus -> samfunsjus *
  rw1([t,h],           X:[t|X]).       %  th   -> t 
%%   rw1([t,n],           X:[n|X]).       %  tn   -> n  %% schjetnan -> sjenan ?
  rw1([t,h],           X:[t|X]).       %  th   -> t  
  rw1([u,y],           X:[u|X]).       %  uy  -> u   ?
  rw1([ø,g],           X:[ø,y|X]).     %  øg   -> øy 
  rw1([ø,i],           X:[ø,y|X]).     %  øi   -> øy 
  rw1([ø,ª],           X:[ø|X]).       %  øª -> ø  %%   løªrdag %% TA-100131
  rw1([å,e],           X:[å|X]).       %  åesen -> åsen 


  rw1([q],             X:[k|X]).       %  q    -> k  
  rw1([x],             X:[k,s|X]).     %  x    -> ks 
%%  rw1([y],               X:[i|X]).        %  y    -> i ? statsbigd
  rw1([z],             X:[s|X]).       %  z    -> s
  rw1([w],             X:[v|X]).       %  w    -> v  
  rw1([æ],             X:[e|X]).       %  æ    -> e % sound
%%   rw1([ø],             X:[o|X]).       %  ø    -> o % sound hoyskoleringen 

    rw1([å],             X:[a|X]).       %  å    -> a % \+ sound // asvang -> åsvang 


%% General

  rw1([C,C],       X:[C|X]).  %%  CC -> C

%% Final

%% These are only  nonrecursive  final operation, otherwise,  jenssens -> j

%% $ = 36   @ = 64  

rw1([e,n,'$'],      X:['@'|X]).  %%  en$ ->  @ % ends with, only last// matisen -> matis
%% Rognbudal(en) etc %

%% rw1([e,t,'$'],     X:['@'|X]).  %%  et$ ->  @ Klett

  rw1([s,t,a,d,'$'],  X:[s,t,a,'@'|X]).  %  stad. -> sta.  %% stadion

  rw1([n,d,'$'],      X:[n,'@'|X]).     %  nd.   -> n.

  rw1([n,s,'$'],      X:[n,'@'|X]).   %  ns$  ->  n@   // not s$ -> @ plass -> pla 

  rw1([s,'$'],        X:['@'|X]).     % sigurd -> sigurds %% Hazard ? 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


tsx :-
   read(X),
   tsx(X).

tsx(X):-
   tucsoundex(X,Y),
   output(Y).


%% Max 20 iterations  to avoid LOOOP
tucsoundex(X,Y):-
    var(Y),             %% Precaution
    atom(X),           
    iso_atom_chars(X,XL),   %%  utility.pl
    append(XL,['$'],XLD),
    tsxreplace(XLD,YL,  20), %% 20 is max count
    append(YL0,[_],YL),      %% remove last, $ or @
    iso_atom_chars(Y,YL0),   %%  utility.pl
    !. 

tsxreplace(XL,ZL,Max):-
    Max > 0, 
    Max1 is Max -1,
    tsxrepl1(XL,YL,Suc),
    Suc==1, %% 1 changed   
    !,
    traceprint(4, (XL -> YL)), 
    tsxreplace(YL,ZL,Max1).
   
tsxreplace(XL,XL,Max):-  
    Max > 0,   %% If > Max, FAIL, not Default        
    traceprint(4, ' '). 


tsxrepl1([A|XL],ÅR,1):- % only 1 replacement
   rw1([A|AZ],XZ:ÅR),
   tsxmatches(AZ,XL,XZ),
   !.

tsxrepl1([X|XL],[X|YL],Suc):- % 
   !,
   tsxrepl1(XL,YL,Suc).

%% repl1([],[],_). %% Doubled up!
repl1([],[],_).



tsxmatches([],X,X).
tsxmatches([X|Y],[X|Z],U):-
    tsxmatches(Y,Z,U).

%%%%%%%%%%%%%%%%%%%%%%%


%% Unprotected verb 

%%% no_unprotected_verb :-!,fail. %% Turn Off EXPERIMENT

no_unprotected_verb :- 
    \+ unprotected_verb.


  
unprotected_verb :- 
  

% Være = inf,fin
 
    txt(X,w(_,VVV),Y), %%  <- !

 \+ txt(X, w(_,noun(meeting,sin,u,n)), Y), %% møte %% TA-110330

 \+ txt(X, w(g,_), Y),  %% Hazardous %% dronningen g - går | byåsen v g. skole
                             %% TA-110610
 \+ txt(X,w(_,[nå]),         Y), % nå (reach)

 \+ txt(X,w(_,[når]),        Y), % når (reach)  fra kong øysteinsvei når jeg må være i byen.

 \+ txt(X,w(_,[e]),          Y), % e = er %% du e dum  
                                 % til e verket*                   
   (  
    (VVV=verb(_F,_Pastpres,_Fin)) %% bildet finnes verb(show,pres,pass)
   ;
   (VVV=[Vil], %% hjelpeverb
        testmember(Vil,[kan,vil,må,bør,skal, %% kan også verb! 
                        kunne,ville,måtte,burde,skulle])) %% burde?
   ),

 % X not preceded by

 \+ txt(_,w(_,[å]),X),  
 \+ txt(_,w(_,[som]),X),         % that doesnt have a relpron ahead
 \+ txt(_,w(_,[that]),X), 
 \+ txt(_,w(_,[which]),X). 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

