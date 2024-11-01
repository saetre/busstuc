/* -*- Mode:Prolog; coding:utf-8; -*- */

%% FILE gram_n.pl   NORSK GRAMMATIKK
%% SYSTEM BUSSTUC/BUSTER
%% CREATED TA-961017
%% REVISED TA-110825
%% REVISED RS-141122


%:-module( gram_n, [ sentence/3 ] ).  % ( --> )/2, sentence/3 ] ).
:-module( gram_n, [ ( ---> )/2 ] ).

%  T H E     J U L E K A L E N D E R, Trøngelsk! English/Norwegian mix
%  Consensical Grammar for Norwegian

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%:- use_module( '../utility/writeout', [ output/1 ] ).  %% RS-141122 Write with following nl (NewLine).

:- use_module( '../declare', [] ).  %:-op( 710,xfx, isa ).  % Move to tuc/facts?        %:-op( 1150, xfx, ---> ).
:- op( 731,xfy, ::: ).          %% sentence tag  %% TA-090514 
:- op( 730,xfy, :: ).           %% lambda infix      %% RS-131229 For dialog/frames2 and /virtuals (autofile)
:- op( 710,xfx, isa ).          % Move to tuc/facts?
%...

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Consensical Grammar  (Context Sensitive Categorial Attribute Logic Grammar)

%%   P \ Q   Phrase P using phrase Q from start
%%
%%   P / Q   Phrase P using  phrase Q late (as possible)
%%
%%   P = Q   Phrase P as defined exactly by phrase  Q 
%%
%%   P - Q   Phrase P using whole or parts of Q 
%%
%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                       %
% Predicates are ordered by a top down calling order.   %
% The first syntactically and semantically satisfying   %
%   analysis is adopted.                                %
% Grammar Rules are generally arranged by a greedy      %
% heuristics, trying the longest possible phrases       %
% in decreasing order of probability.                   %
% This is so because longer phrases means more context. %
% If a phrase is analysed as a category,  then          %
%      no longer phrase for that category is possible.  %
% This makes ! in the grammar safer                     %
%                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Suffix conventions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%     Empty                 00
%     Optional              0        ?
%     One (complex)
%     One simple            1
%     One or more           s        +
%     Zero or more          s0       *
%     Extended (lexical)    x
%
%%%%  Prefix conventions 
%
%     Only stacked phrase    x           
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Main layout 

% syntax_class(syntax_parameter* , code_parameter*, logic_code).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HOW TO DEBUG THIS FILE (after it's translated into dcg_n.pl)
%%
%% N: \set trace 4
%%  or
%% N: \spyg implicitq
%%
%% Most rules will then be marked, for example Implicit Question
%%  (the 26th of 40 such rules) will produce the following debug output: iq26
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Avoid error messages (because of spaces? No 4----> vs. 3--->   OR  same ---> in gram_e !)
%(A ---> B) :-
%        ( A ----> B ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%:- use_module( '../declare', [ (:=)/2, value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .


% UNIT:db
%:- use_module( '../db/busdat', [ clock_delay/3 ] ). %%, named_date/2 ] ).
%:- use_module( '../db/timedat', [ dedicated_date/1, named_date/2 ] ). %% RS-131228

% UNIT:tuc
%:- use_module( 'dagrun_n', [ ] ). %% RS-111213 What is DAG? 
%:- use_module( 'dict_n', [ ] ). %% RS-111213 What is DAG? 
%:- use_module( fernando, [ adj_compl/6, adjnamecomp_template/3, adjnoun_template/4, adjustprep/3, adjust_year/3, adj_template/5, adjustprepv/3, adv_compl/6, align_measure/5, align_noun_name/5, atom_templ/2, alignable/2, atv_template/6, bealign/5, bigno/3,
%         compare/5, clock_test/1, co_template/6, comparad/5, compatvar/2, compliancetest2/3, compoundtest/4, constrain/2, constrainit/2,     %%  constrain0/2, constrain2/3,  ctype/2,
%         dayname/1, decide_adjective/3, decide_quantifier/4, dtv_template/6, % defact/3, event/4,
%         has_template/3, it_template/1, iv_template/4, % hour_test/1, idvarx/3, isfaktor/1, issiffer/1, issifre/1,
%         joinclass/3,  joinclasses/2, latin/4, monthnumber/2, negate/3, % meetclass/3,
%         norpart/3, numberdate/2,  noun_adverb/4, noun_compl/4, plausible_busno/1, plausibleclocktest/3, % nil_noun_compl/1, 
%         preadjs_template/4, % rep_verb/1, pluralis/2, 
%         setvartype/2, subject_object_test/3, subtype0/2, testconstraint/2, thenwhat/3, tv_template/5, % type/2, subclass/2, subclass0/2, screenmeasure/2, rv_template/7, 
%         vartype/3, vartypeid/2, verb_compl/6, verbtype/2, which_thing/2 ] ). %% RS-140921 value_world/1, whodunnit/2
% adjname_template2/3, adjname_template/4, cat_templ/5, align/5,
%:- use_module( semantic, [ a_compl/4, abnormalverb/2, adjname_templ/2, ako/2, measureclass/1, post_adjective/1, pvi_templ/2, subclass/2, subclass0/2, tv_templ/3, v_compl/4, rv_templ/2 ] ). %% ] ). %% RS-140921


%:- use_module( '../main', [ assert_default_origins/1  ] ). %%RS-140209 , ( := )/2, traceprint/2, value/2

% UNIT: /utility/
%:- use_module( '../utility/utility', [ test/1, testmember/2 ] ).  %% RS-140914
%
%:- use_module( '../utility/datecalc', [ add_days/3, datetime/6, easterdate/2, subfromtime/3, this_year/1, timenow/1, today/1, todaysdate/1  ] ).  %% RS-131228, addtotime/3, days_between/3, 


%:- prolog_flag(discontiguous_warnings,_,off). %% RS-140921 Does this actually work?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% GPS SECTION

sentence( [gpsflag ::: Originlist|S] ) --->
    {value(gpsflag,true)},
    origin_phrase(Originlist),
    !,
    sentences(S).

sentence(S) --->
    {\+ value(gpsflag,true)},
    sentences(S).


origin_phrase([X|Z])   --->
    ['('],
    !,
    origin_element(X),

%   {user:set(new_origin, true) }, %% ugly.  actual origin detected %% TA-110206
    {( new_origin := true )},  %% ugly reset explicit  new_origin flag %% RS-140210

    origin_phrase0n(Z).

origin_phrase([])   ---> [].
  
origin_phrase0n([X|Z])---> 
    origin_element(X),
    !,
    origin_phrase0n(Z).

origin_phrase0n([])   --->
    [')'].





origin_element(gps_origin(A,T)) ---> 
    gps_origin(A),['+'],gps_time(T).

gps_origin(SBA) --->  name_phrase(name,SBA:_Station,_Pred),!.

gps_time(T) ---> w( nb(T,num) ).




 

%%  NOTIFY SECTION

%% varsle + ordinary sentence %% Defies all rules  

% varsle 10 minutter før buss [går] fra nth til risvollan. 

%% sentence ====> sentenceG


sentence01(S) ---> 
    implicitq(S). %% varsle neste 

sentence01(S) ---> sentence1(S).


%% END NOTIFY SECTION

%%¤ SENTENCES  

sentences([new:::P]) ---> 
    {value(queryflag,false)}, %%  Only in multi dialog system 
    declaration(P),
    terminatore,  
    !,accept.

sentences([P]) ---> 
    {\+ value(queryflag,false)},
%%     optional(grums),
    greetings0,   %% haz ? 
    implicitq(P), %% only one on the outer level.
    optional(itrailer),    %% rubbish after impl. q.
    terminatores, 
    !,accept.

sentences(ListOfS)  ---> 
    onesentence(S1),
    { S1 \== error},   
    check_stop,               %% RUNTIME PREDICATE (dagrun_n:check_stop/5), CHECK IF nothing left on stack
    moresentences0(S1,ListOfS).



moresentences0(S1,Square) --->
    onesentence(S2),
    check_stop,  %% CHECK IF nothing left on stack 
    !,accept,
    evenmore0(S1,S2,Square).

evenmore0(S1,error,[S1,error]) ---> %% Erroneous end of list
    !,
    skip_rest.

evenmore0(S1,[],[S1]) ---> [],     %% 1  %% Normal end of list
    !.
evenmore0(S1,S2,[S1|Square]) --->  %% 2   
    moresentences0(S2,Square).


%%%¤ ONESENTENCE 

onesentence([])    ---> endofline,!,accept.

onesentence(P) --->  conf_statement(P),endofline,!,accept. %%*  naturlivis vil
                                                        
onesentence(S) ---> 
     grums0,        %% feil: fikk ikke kontakt
     sentence1(S),
     sentence_delimiter, %%%%%%terminatore,!,
     accept. %% e.g. 'og' 

onesentence(error) --->  skip_rest. %% New Runtime predicate

 
notify ---> w(verb(notify,_,_)). 
notify ---> w(noun(notification,_,_,_)).

conf_statement(confirm:::TF)   ---> confirm(TF).

confirm(false) ---> [jeg],w(verb(know,pres,fin)), 
                    [ikke],endofline.            %% Rough

confirm(true)  ---> [ja], of_course0.
confirm(true)  ---> [jo], of_course0. 
confirm(false) ---> [nei],of_coursenot0.

confirm(true)  --->  of_course.
confirm(false) --->  of_course,[ikke].


%% SENTENCE DELIMITERS

sentence_delimiter ---> [for],look_ahead([hvis]). %% ad hoc 
%% sentence_delimiter ---> [og]. %% TA-110620
sentence_delimiter ---> [';']. 
sentence_delimiter ---> terminatore.

terminatore0 ---> terminatore,!,accept.

terminatore0 ---> []. %% comma

terminatores ---> terminator,!,terminatores. 
terminatores ---> check_stop,endofline,!,accept. %% Really end
                  %%%%%%%%%% TA-101212
%% terminatore --->  [og], not_look_ahead(w(verb(_,_,_))).  %% Bloody experiment 
                                                            %% og (å) få
terminatore ---> terminator1.

terminator1 ---> terminator,
    not_look_ahead(w(nb(_,num))), %% klokken er 09.04 %% sentences dont start with numbers
    not_look_ahead(w(name(_jan_,_,month))), %% buss 2. jan
    not_look_ahead(w(name(_jan_,_,day))),   %% buss 2 (.) nyttårsdag 
    not_look_ahead(w(name(_jan_,_,date))), 
   !,accept.                               
  
terminator1 ---> check_stop_locations,endofline,!,accept. %% Really end

look_ahead_endofline ---> look_ahead_lit(['.','?','!']),!. %% \+ :
look_ahead_endofline ---> end_of_line. %% TA-101006

endofline0 ---> terminator,!,endofline0. %% TA-110127
endofline0 ---> end_of_line0. %% NEW Runtime predicate


endofline ---> terminator,endofline,!,accept. 
endofline ---> [':'],end_of_line,!. 
              
endofline ---> ['+'],{value(busflag,true)},
               endofline,!,accept.        %% '+' = lower case '?' 
endofline ---> end_of_line.  %% checks empty stack

endofline1 --->  ['.'].  %% without check %% TA-100912
endofline1 --->  ['?']. 
endofline1 --->  ['!']. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

check_stop_locations ---> check_stop,!. %% ad hoc %% TA-101215 Just the first one?

% check_stop_locations --->
check_stop_locations --->
     w( end_of_query ), 
     assemble_stop_locations( Statlist ),
     !,
     { assert_default_origins( Statlist ) }.

%% Ad Hoc
% Assemble locations

assemble_stop_locations( [ Stat1+Min | _Rest ] ) --->
    w( name( Stat1, n, _Station ) ), ['+'], w( nb( Min, num ) ),
    !,
   % check_stop_locations( [ Rest ] ).
   check_stop_locations.

assemble_stop_locations( [] ) ---> end_of_line.


%%%%  INITIAL SENTENCES ONLY %%%%

%% Part: sentence is undecided

% ennå en gang ser det ut til at bussoraklet ikke er min venn.


%%%¤ SENTENCE1  (new:::P)


sentence1(new:::P) ---> %% fint at =(Det er) fint at %% TA-110518
    hellos0,
    w(adj2(Good,Nil)),     %%
    [at],
    !,
    clausal_object1(NewSCo,CNP),
    statreal(P) \  (xnp(NewSCo,CNP),w(verb(be,pres,fin)), w(adj2(Good,Nil))).



sentence1(new:::P) ---> %% (Det) å ta buss er  bra %% TA-110111
    detaa,        %%
    clausal_object1(NewSCo,CNP)\[noen],
    !,
    statreal(P)\ xnp(NewSCo,CNP).

detaa ---> [det],[å]. %% TA-110111
detaa ---> [å].  


sentence1(new:::P) ---> %% Hvorvidt bussen går er bra
    hvorvidt,        %% special, ad hoc
    clausal_object1(NewSCo,CNP),
    !,
    statreal(P)\ xnp(NewSCo,CNP).

hvorvidt ---> [hvorvidt].
hvorvidt ---> [det],[at].
hvorvidt ---> [at]. %% TA-110111


sentence1(new:::P)  --->   %% Da er det sant at
     redundant,        %% \+ 0
     be_it_tf_that(_N), %% phrase introducing main sentence with substatement ordering
     !,            %% ignore ad hoc
     statreal(P).


%% Sentences that are not questions


sentence1(new:::P) --->    %% er mye folk -> det er mye folk
    w(verb(be,_,fin)), 
    look_ahead_lit([mye]),    
    statement(P) \ 
       ([det], w(verb(be,pres,fin))).


sentence1(new:::P)  --->   %% tolkes (som) = noen tolker dette (som)
     w(verb(Interp,Pres,pass)),       %% tolkes dette = question!          
     redundant0,    
     [som],
     !,
     statreal(P) \
        ([noen],
         w(verb(Interp,Pres,fin)),    
         [dette],
         [som]).


                          %% bare et ord -> dette er et ord
sentence1(new:::P)  --->  %%  kanskje     ikke    i tråd med intensjonen
                          %%  -> dette er ikke    ...
     optional([kanskje]), %% if visible
     negation(N),         
     not_look_ahead([alle]), 
     statreal(P) \
        ([dette],
         w(verb(be,pres,fin)),
         negation(N)). %% NOT negtaion0 
 
  

%% Det er ofte slike spm brukere er interessert i å stille når man ikke
%% kjenner rutene...



%% Det spørsmålet er brukerne interessert i å stille
sentence1(new:::P)  --->  %%  
     one_of_lit([den,det,dette,disse,slike]), %%0 
     w(noun(Answer,S,U,n)), %1
     w(verb(be,Pres,fin)),  %2 
     subject(X, SNP),       %3
     w(adj2(Interes,nil)),  %4
     w(prep(In)),           %5
     [å],                   %6
     w(verb(Ask,inf,fin)),  %7
     !,
     statreal(P) \ 
       (xnp(X,SNP),             %3
        w(verb(be,Pres,fin)),   %2 %%
        w(adj2(Interes,nil)),   %4
        w(prep(In)),            %5
        [å],                    %6
        w(verb(Ask,inf,fin)),   %7
        w(noun(Answer,S,U,n))). %1


%% Topicalised prepostional object 
%% Det spørsmålet er brukerne interessert i

sentence1(new:::P)  --->  %%  det svaret er jeg interessert i
     one_of_lit([den,det,dette,disse,slike]), %% 
     w(noun(Answer,S,U,n)),
     w(verb(be,Pres,fin)), 
     subject(X, SNP),
     w(adj2(Interes,nil)),
     w(prep(In)),
     !,
     statreal(P) - 
       (xnp(X,SNP),
        w(verb(be,Pres,fin)), %% 
        w(adj2(Interes,nil)),
        w(prep(In)),
        w(noun(Answer,S,U,n))).


sentence1(new:::P)  --->  %%  det svaret har jeg bruk for
     one_of_lit([den,det,dette,disse,slike]), %% 
     w(noun(Answer,S,U,n)),
     w(verb(Have,Pres,fin)),
     subject(X, SNP),
     w(noun(Use,sin,u,n)),
     w(prep(For)),
     !,
     statreal(P)\
       (xnp(X,SNP),
        w(verb(Have,Pres,fin)),
        w(noun(Use,sin,u,n)),
        w(prep(For)),
        w(noun(Answer,S,U,n))).


%% Topicalised object %% Det svaret liker jeg

sentence1(new:::P)  --->  %%  
     one_of_lit([den,det,dette,disse,slike]), %% 
     w(noun(Answer,S,U,n)),
     w(verb(Like,Pres,fin)),
     {\+ testmember(Like,[have,get])}, %% har jeg besvart/ får et svar
                               
     subject(X, SNP),  
     !,
     statreal(P)\
       (xnp(X,SNP),
        w(verb(Like,Pres,fin)),
        w(noun(Answer,S,U,n))).

sentence1(new:::P) ---> %% Hvorvidt bussen går kan diskuteres
    [hvorvidt],        %% special, ad hoc
     clausal_object1(NewSCo,CNP),
    !,
    [kan],
    w(verb(Discuss,Pres,pass)),   
    !,
    statreal(P)\ ([dere], w(verb(Discuss,Pres,fin)),xnp(NewSCo,CNP)).



%% VERB ---> DU Verb %% TA-110504
sentence1(new:::P) ---> %%  Snakkes på bussen i morgen
    w(verb(Talk,_Pres,_FinPass)),  gmem(Talk,[talk,speak]),
    look_ahead(w(prep(_))),
    !,
    statreal(P)\ ([du],w(verb(Talk,pres))).

%% AUX = JEG AUX 

sentence1(new:::P) ---> %% TA-110518  må til byen
    aux1,
    not_look_ahead_np,  
    !,
    statreal(P)\ ([jeg],aux1).




%% VERB = JEG VERB

%% Verb past part = Jeg past fin %% TA-101102
sentence1(new:::P) ---> %%  %% Fått = jeg har fått= jeg fikk
    w(verb(See,past,part)), 
    !,
    statreal(P)\ ([jeg],w(verb(See,past,fin))).


%% VERB = JEG VERB
sentence1(new:::P) ---> %%  Har ikke vært i oslo
    [har],
    negation0(N),
    w(verb(See,past,part)), 
    !,
    statreal(P)\ ([jeg],w(verb(See,past,fin)),negation(N)).

%% VERB = JEG VERB
sentence1(new:::P) ---> %%  GÅR (til)---> JEG GÅR (til)
    not_look_ahead([så]),
    w(verb(Go,pres,fin)), %% tenk på en buss \= jeg tenker på ..%% TA-110824
        gmem(Go, [go,think]), %% TA-110624

        not_look_ahead_np, %% går bussen er Q // går lørdag ok
        not_look_ahead([ikke]), %%  går ikke = rhet q
        not_look_ahead_lit([jeg,meg,du]), 
    !,
    statreal(P)\ ([jeg],w(verb(Go,pres,fin))).

%% VERB = JEG VERB
sentence1(new:::P) ---> %%  VERB presens---> JEG VERB 
    not_look_ahead([så]),
    w(verb(Go,T,fin)), gmem(T,[pres]), 

        gmem(Go, [arrive,calculate,discover,give,hope,  %% expect, ambig: if stacked, no BT 
               pass,run,send, start,take,think,try,wait]), %% TA-110623
        particlev1(Go), %% regner med 
        
        not_look_ahead([ikke]), %%  går ikke = rhet q

        not_look_ahead_lit([jeg,meg,du,vi]), 
    !,
    statreal(P)\ ([jeg],w(verb(Go,pres,fin))).

%% VERB = JEG VERB
sentence1(new:::P) ---> 
    not_look_ahead([så]),
    w(verb(Go,T,fin)), gmem(T,[imp,inf]), 

        gmem(Go, [arrive,discover,  %% expect, ambig: if stacked, no BT 
               pass,run,send,start,take,try]), %% TA-100916 \+ wait  command
                                                                  %% regret beklager
        reflexiv0(Go), %% fortell meg det %% TA-110615
        not_look_ahead([ikke]), %%  går ikke = rhet q

        
        not_look_ahead_lit([jeg,meg,du,vi]), 
    !,
    statreal(P)\ ([jeg],w(verb(Go,pres,fin))).


%% VERB = JEG VERB
sentence1(new:::P) ---> %% Regner med det er en smal sak for Amble å endre dette
    not_look_ahead([så]), 
    w(verb(Hope,pres,fin)), 
        {testmember(Hope,[believe,calculate,think,see,know])}, %% TA-110504%% ,regret = beklager
    not_look_ahead([det]), %% ad hoc  regner det   
    not_look_ahead([du]),  %% ad hoc
    redundant0,
    optional([at]), 
    !,
    statreal(P)\ ([jeg],w(verb(Hope,pres,fin)),[at]). %% Very special

%% VERB = JEG VERB
sentence1(new:::P) ---> %% Tenkte bare jeg skulle 
    not_look_ahead([så]), 
    w(verb(Think,_,fin)),  
    redundant0,
    [jeg],
    aux1,
    !,    
    statement(P) \ 
       ( [jeg], w(verb(Think,pres,fin)),[å]).

%% VERB = JEG VERB
sentence1(new:::P) ---> %% kan se at det regner (not se! command)
    aux1,
    redundants0,   %% må vel nesten %% TA-110106
    negation0(Neg),
    w(verb(Think,inf,fin)),
    !,    
    statement(P) \ 
       ( [jeg], w(verb(Think,pres,fin)), negation(Neg)). 



sentence1(P) ---> %% Moved before question 
    command(P).   %% gi meg bussene fra nth

sentence1(P) --->
    greetings0, 
    question(P),
    qtrailer0. 



%% Panic-rule %% item virker ikke i Dialog

sentence1(modifier(A):::(C isa clock and srel/nil/time/C/A and event/real/A)) ---> 
    {value(dialog,1)}, 
    item(P),
    endofline, 
    {P = (C isa clock)},
    !,accept.


sentence1(item:::P) ---> 
    {value(dialog,1)}, 
    item(P),
    endofline, %%%  3 buss 5 nr . går //terminator1, 
    !,accept.

 
sentence1(item::: Now isa clock) ---> 
    {value(dialog,1)},
    [nå],                             %% now is also a time
    terminator1, 
    !,accept,
    {timenow(Now)}.


sentence1(item:::P)  --->   %% nr . ( 52 går)
    noun(_Man,_,_u,n,it:_,P),   %%  menn 
   {value(dialog,1)},
    endofline, 
    !,accept.

 
sentence1(item::: it isa Day) ---> 
    {value(dialog,1)},
    today, %% i dag etc
    terminator1, 
    !,accept,
    {today(Day)}.


sentence1(new:::P) ---> %%  ble  kanskje feil ...%% <-> ynq isq
    [ble],   %% Example
    look_ahead(w(adj2(F,nil))),
     !,    
    statement(P) \ 
       ([dette], w(verb(be,pres,fin)), w(adj2(F,nil))).  



sentence1(new:::P) --->    %% er på Kuset ---> jeg er på kuset
    w(verb(be,_,_)), %% er på/ (skulle ha) vært på / var på
    now0,   
    w(prep(Ion)), 
    {testmember(Ion,[in,on,at])},
    !,accept,
    statement(P) \ 
       ([jeg], w(verb(be,pres,fin)), w(prep(on))).


sentence1(new:::P) --->    %% har sendt -> jeg sendte
    has,
    w(verb(Send,past,part)), 
        {testmember(Send,[send,get,receive,lay])}, 
    now0,   
    statement(P) \ 
       ([jeg], w(verb(Send,past,fin))).



sentence1(new:::P) --->    %% sender -> jeg sender
    w(verb(Send,_,fin)), 
        {testmember(Send,[send,get,receive,lay,check])}, 
    now0,   
    statement(P) \ 
       ([jeg], w(verb(Send,pres,fin))).



%% Part:  sentence is ordinary statement


sentence1(new:::P) --->
    greetings0,
    statement(P),
    dtrailer0. 


sentence1(item:::P) ---> %% team. jeg vil ta buss after statement
    item(P),  
    terminator1,  %% ikke og/eller her
    !,accept.



%%%¤  ITEM 


item(N isa clock) ---> 
    {value(dialog,1)},
    time12(N),
    {N \== now},
    endofline. 


item(Nisadate) ---> 
    {value(dialog,1)},
    obviousdate1(_,Nisadate),
    endofline.  %% nec ?


item(P) ---> %% only simple one
     namep(_,_,P).



%%%% COMMAND (Code)


command(_) ---> [vil],!,reject.  
command(_) ---> [skal],!,reject.  


command(doit:::P) ---> %% du må slutte %% TA-110609
    [du],
    [må],
    not_look_ahead([ikke]),
    w(verb(V,inf,fin)), %% ** går bussen -> du går bussen
    !,  
    statreal(P)\ ([du],w(verb(V,pres,fin))).


command(doit:::quit(Message)) ---> 
    grums0,     %% så ha det bra 
    okeys0, %% optional([ok]),  optoken, 
    quit(Message),
    skip_rest.

command(doit:::reply(Ans)) ---> 
    personal(Ans),
    dtrailer0,
    endofline. %%  går det bra  ... i morgen 

command(doit:::replyq('Hei')) --->  %%  Literal answer %% Fronted due to a sick error
    hellos, %% \+ nei,  
    !.
    %%   skip_rest. %% hei og takk for sist  swallows all bactracks 


%% NOT   actually commands 

command(new:::P) ---> %%  ser ut til at %% TA-110309
    w(verb(See,pres,fin)), %% avoid så="sedde" 
    not_look_ahead([du]), %% ad hoc
    [ut],
        gmem(See,[see,look]), 
    tilat,
    !,
    substateme1(real,P).

tilat ---> [til],[at],!.
tilat ---> [som],[om],!.
tilat ---> [som].

command(new:::P) ---> %%  See you in hell  ---> VERB -> Jeg VERB .
    w(verb(See,pres,fin)), %% avoid så="sedde" 
    not_look_ahead([du]), %% ad hoc
    gmem(See,[expect,miss,need,get,receive,see,understand]),
    !,
    statreal(P)\ ([jeg],w(verb(See,pres,fin))).



command(new:::P) ---> %% not a command  INF/IMP ankomme Nardo
    not_look_ahead([nå]), %% command nå! *
    not_look_ahead(w(verb(come,imp,fin))), 
    w(verb(Go,Imp,fin)),
    {testmember(Go,[go,take,run,arrive,leave,leave2,depart,start,pass])}, %% \+ reach
     not_look_ahead([meg]), 
  
    {testmember(Imp,[imp,inf])}, 
    !,
    statreal(P)\ ([jeg],w(verb(Go,pres,fin))).

command(new:::P) ---> %%  tror jeg tar bussen
    w(verb(B,pres,fin)),
    not_look_ahead([du]), %% ad hoc
    {testmember(B,[believe])},     %% tror 
    that0(B,that),
    [jeg],
    not_look_ahead(w(prep(_Prep))), %% går bussen ... NOT command
    !,
    statreal(P)\ ([jeg]).

command(new:::P) ---> %%  ankommer NTH
    w(verb(Go,pres,fin)),
        gmem(Go,[arrive,leave2,depart]),  %% transitive verbs 
    look_ahead_place,
    !,
    statreal(P)\ ([jeg],w(verb(Go,pres,fin))).


%% Command    VERB -> Du VERB !

command(doit:::P) ---> %% ikke gjør en ting. 
    optional(grums), %%  "Team, ...
    please0,         %% vær så snill å 
    negation0(N), 
    w(verb(V,imp,fin)), %% ** går bussen -> du går bussen
    {verbtype(V,tv)}, %% se=look/see
    look_ahead_np,   %% must take xnp %% TA-110506
    !,  
    statreal(P)\ ([du],w(verb(V,pres,fin)),negation(N)).


 
command(doit:::P) ---> %% ikke gjør en ting. 
    optional(grums), %%  "Team, ...
    please0,         %% vær så snill å 
    negation0(N), 
    w(verb(V,imp,fin)), 
    particlev0(V,W), %% si fra %% TA-110523  vent! 
    %%   {\+ verbtype(V,tv)}, %% les (om) en bok 
    !,
    statreal(P)\ ([du],w(verb(W,pres,fin)),negation(N)),
 
ctrailer0. %% please0.   %% er du snill 





command(doit:::replyq('?')) ---> end_of_line.


%% Swapped parameters/modes

imp_phrase(Run) ---> %% La oss K = K!
    lexv(_,let,imp,fin), %% Norwagism 
    [oss],
    w(verb(Run,inf,fin)),
    !.

imp_phrase(let) ---> %% Let 
    lexv(rv,let,imp,fin),!,accept. %% Norwagism 


imp_phrase(list) --->
    faa,
    lexv(_Vt,see,imp,fin),!,accept. %% Norwagism , not pres



imp_phrase(wait) ---> 
     w(verb(wait,imp,fin)),  %% probl. wait|expect
     !.
 

imp_phrase(V) ---> 
     not_look_ahead([må]),   
     comeand0, 
     lexv(Vt,V,imp,fin),   {Vt \== rv},       %% show means transitive show 
     {\+ testmember(V,[have,expect])}. %% expect=wait, be OK 
        

imp_phrase(V) --->
     not_look_ahead([må]),  
     comeand0, 
     lexv(rv,V,imp,fin), %% Fortell meg 
     {V \== be},
     {V \== wonder},
     reflexiv0(V).


imp_phrase(V) --->  %   reise til nth NOT imp 
    not_look_ahead([må]),  
    comeand0, 
    lexv(_,V,inf,fin), 
    {testmember(V,[list,show,make])}, 
    {V \== be}.   

%%%%


comeand0 ---> w(verb(come,imp,fin)), [å],!.
comeand0 ---> [].


%%%%% DECLARATION SECTION

declaration(Tore isa self) ---> 
    i,   
    be,
    !,
    newatomid(Tore). 

declaration(P) ---> 
    newatom(X),  
    be,
    a,
    !,
    noun(_,sin,u,n, X, P). 


%%% STATEMENT SECTION    

% The set of predicates determine statement by gradual specificity
% 

% statement, statemen, statemen1, statems,
% statem, state, stm, st, stat, statreal, statreal1

% There are 4 different  signatures
   
    %  <st>(P)       P: statement predicate in world real
    %  <st>(W,P)     P: statement predicate in world W
    %  <st>(S,VP).   S: statevariable, VP:verb phrase semantics
    %  <st>(S,N,VP)  S: statevariable, N:negation,VP:verb phrase semantics


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%% INITIAL STATEMENT ONLY 

%%%%¤¤¤¤     STATEMENT (P)


statement(P) --->  %% det betyr at   
                   %% når jeg spør bussoraklet %%
       [det],
       be_truefalse(_N), %% Ignored  AD HOC
       [at],
       look_ahead_lit([før,etter,når]), %%

   adverbial3(Prep, Y,SCP3),  %%        %% før bussen kom
   comma0,
   !,accept,
   [] -  adverbial1(Prep, Y,SCP3),  %% ikke xadverbial1 ?
   substatement1(P).   %% was substatement1               %% gikk trikken



statement(P) --->  %% Hvis trikken står (så) tar jeg bussen
   look_ahead_lit([hvis,om,selvom  ,da]), %% TA-110112
   adverbial3(Prep, Y,SCP3),
   soredundant, %% look_ahead([så]),
   !,
   substatement1(P) / ([så], xadverbial1(Prep, Y,SCP3)).



statement(P) --->  %% Ad Hoc %% Hvis trikken står  lønner det (seg å ta  bussen) 
   look_ahead([hvis]),
   adverbial3(Prep, Y,SCP3),
   not_look_ahead([så]),
   w(verb(Take,Pres,fin)), %% lønner \= så (see,past,fin)!
   [det],
   !,accept,
   substatement1(P)/
        ([det],w(verb(Take,Pres,fin)),xadverbial1(Prep, Y,SCP3)).


statement(P) --->  %% Ad Hoc %% Hvis trikken står  vil det ikke lønne (seg å ta  bussen) 
   look_ahead([hvis]),
   adverbial3(Prep, Y,SCP3),
   not_look_ahead([så]),
   aux1,
   [det],
   negation0(N),
   !,accept,
   substatement1(P)/
        ([det],aux1,negation(N),xadverbial1(Prep, Y,SCP3)).


statement(P) --->  %% Ad Hoc %% Hvis trikken står  vil dere ikke ta trikken
   look_ahead([hvis]),
   adverbial3(Prep, Y,SCP3),
   not_look_ahead([så]), 
   aux1,
   subject(X,XNP),
   redundant0,    
   negation0(N),
   !,accept,
   substatement1(P)/
        (xnp(X,XNP),aux1,negation(N),xadverbial1(Prep, Y,SCP3)).

statement(P) --->  %% %% Hvis trikken står  lønner det seg å ta bussen 
   look_ahead([hvis]),  %% Ad Hoc
   adverbial3(Prep, Y,SCP3),
   not_look_ahead([så]), 
   w(verb(Take,Pres,fin)), %% Take \= så (see,past,fin)!
   !,
   subject(X,XNP),
   !,accept,
   substatement1(P)/
        (xnp(X,XNP),w(verb(Take,Pres,fin)),xadverbial1(Prep, Y,SCP3)).


%% før bussen går // AVOID før klokka 1234
%% NB  før  å = for å (sp) is trapped


statement(P) --->  %% før bussen stopper vil trikken gå.
                   %% når jeg spør bussoraklet %%

       look_ahead_lit([før,etter,når]), %% når det gjelder ... = hvis det gjelder%% Hazard ???

   adverbial3(Prep, Y,SCP3),  %%        %% før bussen kom    
   comma0,                               
   !,accept, 
   [] -  adverbial1(Prep, Y,SCP3),  %% ikke xadverbial1 ?
   substatement1(P).   %% was substatement1               %% gikk trikken




statement(P) --->     %%  Real Statement
    statemens(real,P).    



  
%%%¤¤¤¤  SUBSTATEMENT1 (P)


substatement1(P)  --->  %%  (bussen går selv om) det er nardo kunden * spør om . 

     dether,  

     w(verb(be,_Pres,fin)),
     optional([ofte]),  %% sent_adv
     np0_accept(Z,ZNP), %% slike spørsmål
     optional([som]),
     subject(X, XNP),     
     !,
     statreal(P) - 
       (xnp(X,XNP),  %% brukerne    
                       %% er interessert i å stille 
        xnp(Z,ZNP)).    %% spørsmål

 
dether ---> [det].  
dether ---> [det],[her].
dether ---> [dette].  

substatement1(P) --->    %% Single Real Statement
    statemen1(real,P). 

/* %% TA-101115

%%%¤¤¤¤  STATEMENREAL(P)


statemenreal(P) --->  
    statemen1(real,P).  
*/


%%%%¤¤¤    STATEMENS(R,P)


statemens(R,PQ) --->
    statemen1(R,P),
    statemens0(R,P,PQ).


%%%%¤¤¤ STATEMENS0  (R,P,Q)

statemens0(R,P,P and Q) ---> %% jeg skal til dragvoll men [jeg] vil sykle
   stm_conjunction,         
   aux1,
   !,
   statemens(R,Q)\[jeg].


statemens0(R,P,P and Q) ---> %% jeg går og så er jeg sikker 
   stm_conjunction, 
   look_ahead_lit([så,nå,da]), 
   !,
   statemens(R,Q).

statemens0(R,P,P and Q) ---> %% jeg går så er jeg sikker
   look_ahead([så]),
   !,
   statemens(R,Q).


statemens0(R,P,P and Q) ---> 
   stm_conjunction, %% and1, %% restriction. 
   not_look_ahead(w(verb(_,_,_))), %% og tar buss
   not_look_ahead_number, %% (w(nb(_,_))), %% side 2 og 3 // hvorav ett er ok
   !,
   statemens(R,Q).

statemens0(_,P,P) ---> [].


stm_conjunction ---> [hvorav]. %% TA-110617 jeg har flere vinduer hvorav  ett [vindu] er åpent .  
 
stm_conjunction ---> [å],look_ahead([så]). %% TA-110105
stm_conjunction ---> [å],look_ahead([nå]). %%

stm_conjunction ---> [og],look_ahead([nå]).

stm_conjunction ---> [og],[at]. 
stm_conjunction ---> [men],[at].  
stm_conjunction ---> [altså],[at].
stm_conjunction ---> and1. 
stm_conjunction ---> [men].
             
 
stm_conjunction  ---> look_ahead([så]). %% Haz? 

stm_conjunction  ---> 
     optional([',']), % if present
     look_ahead([ikke]). %% Haz?
stm_conjunction ---> [mens]. %%  (also subjunction with)


%%%%%¤¤¤  STATEMEN1 (R,Q)   %% initial statement of R

statemen1(R,Q) --->   %%  allowed initial
     stateme1(R,Q).   %%% statem1(S,event/R/S::Q). %% TA-101115


statemen1(R,P) ---> %% mulig at bussen går 
     w(adj2(Poss,nil)), {testmember(Poss,[possible,clear,ready])}, %% klart  du vet det
     optional([at]),                                
     !,
     substateme1(R,P)\ 
           ([det],w(verb(be,pres,fin)),  w(adj2(Poss,nil)),[at]).


statemen1(R,P) ---> % vedlagt ligger filen 
    w(adj2(Encl,nil)), {testmember(Encl,[enclosed])},
    w(verb(Lie,Pres,fin)), {\+ testmember(Lie,[])}, %% ad hoc
    {verbtype(Lie,iv)},
    subject(X,NP),
    !,
    substateme1(R,P)\ 
        (xnp(X,NP), w(verb(Lie,Pres,fin)),w(adj2(Encl,nil))),
    !,accept.


statemen1(R,P) ---> % ellers blir det snø  
    redundant, %% \+ 0 
    w(verb(Be,_Pres,fin)), {\+ testmember(Be,[])}, %% ad hoc
    [det],
    danow0,  %% ad hoc 
    substateme1(R,P)\ ([det],w(verb(Be,pres,fin))),
    !,accept.

 
statemen1(R,P) ---> % (det er) bra at 
    optional([meget]), %%
    w(adj2(Good,nil)), 
        {testmember(Good,[good,bad,interesting,nice])}, %% .. NOT SISTE 
    substateme1(R,P)\ ([det],w(verb(be,pres,fin)), w(adj2(Good,nil))),
    !,accept.

statemen1(R,P) ---> % simple version, with world %% TA-101027
                %% never Initially  HV-np  %% hva som kreves
     not_look_ahead_lit([hva,hvem,hvilke,hvilken,hvilket]),
         {unprotected_verb}, 
    substateme1(R,P).   


statemen1(R,P) ---> %% som du ser går bussen %% Ad Hoc, ignore init
     [som],
     [du],
     w(verb(Know1,_Pres,fin)),{testmember(Know1,[know,see,understand])}, %% etc
     w(verb(Go,_,fin)),
     subject(X,NP),
     substateme1(R,P)\ (xnp(X,NP), w(verb(Go,pres,fin))).


statemen1(R,P) --->  %% så er det bra (INITIALLY)
    soredundant,
    w(verb(Be,Pres,fin)), %% kommer det/er det
    [det],
    substateme1(R,P) \ ([noe], w(verb(Be,Pres,fin))),
    !.



%%%%  STM above are INITIAL PHRASES

stateme1(R,Q) --->  %% TA-101115 <--- only initial
    statem(S,event/R/S::Q).  %% RS-141029  Hvor går flybussen? Try this:
%       substatem1(S,event/R/S::Q).  %% RS-141029  Hvor går flybussen? Try this:


%%%%¤  SUBSTATEME1 (R, P).


substateme1(R,Q) --->   %% NOT INITIAL
     substatem1(S,event/R/S::Q). 
    

%%%%¤  SUBSTATEM (S,EQ)    subordinate statement


%%  %% jeg vet at bussen går og at trikken ikke står. 
%%  permutes the lexical sequence 

substatem(S,EQ) --->
    substatem1(S,EQ1),
    ogat(S,EQ1,EQ).


ogat(S,EQ::T1,EQ::(T1 and T2)) ---> 
    [og],[at],!,
    substatem1(S,EQ::T2).

ogat(_S,EST,EST) ---> [].




%%%%¤¤¤ SUBSTATEM1 (S,EQ)  also   called from clasual_object1 

%% jeg vet at det er slik %% TA-110309


substatem1(S,STM) ---> %% jeg vet at det (ikke)  er (ikke) nyttig
    [det],             %% TA-110629
    negation0(SubN),
    be(N),
    {bigno(SubN,N,Neg)},
     !,
    []- negation(Neg), %% no blocking
    statem(S,STM)\
      ([det],             %% (når) det går buss %% TA-110609
         w(verb(be,pres,fin))).


substatem1(S,STM) ---> %% det kommer fram i teksten
    [det],            
    negation0(SubN),
    hlexv(_Iv,Appear,_T,fin,N), %% det gir svar
    {bigno(SubN,N,Neg)},
     !,
    statem(S,STM)\
      ([det],             %% (når) det går buss %% TA-110609
         w(verb(Appear,pres,fin)),negation(Neg)).

   

substatem1(S,STM) ---> %% å sykle er det (som) jeg vil (gjøre).
    [å],
    !,
    clausal_object1(CO,ST)\[jeg], %% ad hoc, noen 
    !,
    statem(S,STM)/xnp(CO,ST). %%



substatem1(S,EQ) --->  %% for å komme til Lian må du ta trikk
     forå,
     w(verb(V,inf,fin)),
     clausal_object1(Y,true::NP)\([jeg], w(verb(V,pres,fin))),
     hvisaa0, %% [så], %% if not swallowed  
     !,
     statem(S,EQ) / ([så], subordinate(in_order_to,Y,NP)).


substatem1(S,EQ) --->  %%% hvis trikken står så hadde det sikert  vært til glede 
     look_ahead_lit([for,fordi,hvis,om,selv,siden,uansett,selvom ]), 
         
     subordinate(Prep,T,P),                                    
     []-subordinate(Prep,T,P),
     hvisaa0, %% [så], %% if not swallowed 
     has,
     [det],
     redundant0, 
     w(verb(be,past,part)),   
     !,
     itstatem(S,EQ) \ w(verb(be,past,fin)).



substatem1(S,EQ) --->  %%  Experiment
     look_ahead_lit([for,fordi,hvis,om,selv,siden,uansett,selvom,  da,
      når]), %% /når/ skal molde spille  %% TA-110503
     subordinate(Prep,T,P),     %%%                                %% TA-110112
     hvisaa0, %% [så], %% if not swallowed  
     !,
     statem(S,EQ) / ([så], subordinate(Prep,T,P)).

substatem1(S,STM) ---> substate(S,STM).

%%%%%%%%  substatem1(S,STM) ---> statem(S,STM).  %% <---> %% ? %% TA-101115

hvisaa0 ---> [så],!.
hvisaa0 ---> look_ahead_lit([ble]),!. %% siden bussoraklet  foreslår direkte ruter (så) ble det foreslått ringruter
hvisaa0 ---> look_ahead_lit([kan,får]),!. %% hvis bussen står kan du gå 
hvisaa0 ---> look_ahead(w(verb(Be,_,fin))),{testmember(Be,[avoid,be,come,have])}. %% etc with care 
hvisaa0 ---> []. 




%%%¤ SOSTATEM (S,ST)    Statement after så

sostatem(S,ST) --->  %% så kan bussen gå

    faux1,
    subject(X,NP),
    redundant0,  
    negation0(N),  
    w(verb(Go,inf,fin)),
    !,
    state(S, ST) \
        (xnp(X,NP),aux1,negation(N),w(verb(Go,inf,fin))),
    !.


sostatem(S,EQ) ---> %% desverre virker det rart at bussen går

    w(verb(Be,Pres,fin)),
    [det],          %% prelim
    negation0(N), 
    adj1(ABig,A:_,AS,ABIGX), 
    [at],
    !,
    clausal_object1(X,XNP),

    state(S,EQ)\
         (xnp(X,XNP),
          w(verb(Be,Pres,fin)),
          negation(N),  
          adj1(ABig,A:_,AS,ABIGX)). %% stacked as thing


sostatem(S,ST) --->  %% så har det kommet en buss 

    has,
    [det],
    preadverbials0, %%  i dag
    negation0(N),
    w(verb(Arrive,past,part)),
    subject(X,NP),  
    state(S, ST) \  
        (xnp(X,NP), w(verb(Arrive,past,fin)), negation(N)), 
    !.

%% TA-110112
sostatem(S,ST) --->  %% så betyr ikke dette at|betyr det ikke at

    lexvaccept(rv,Indicate,Pres,fin,N),
   
    negation0(N1),
    thereit,
    negation0(N2),
    {bigno(N1,N2,N)}, %%
    state(S, ST) \  
        ([noe], w(verb(Indicate,Pres,fin)), negation(N)), 
    !.


sostatem(S,ST) --->  %% så går ikke bussen | så går bussen ikke

    w(verb(Want,Pres,fin)),  
    negation0(N1),
    subject(X,NP),  
    negation0(N2),  
    {bigno(N1,N2,N)},
    state(S, ST) \  
        (xnp(X,NP), w(verb(Want,Pres,fin)), negation(N)), 
    !.


sostatem(S,ST) --->  %% så benyttes serveren 

    w(verb(Use,Pres,pass)),
    thereit0,  
    negation0(N),
    state(S, ST) \  
        ([noen], w(verb(Use,Pres,fin)), negation(N)), 
    !.


sostatem(S,ST) --->  %% så skal det gå bra 
 
    aux1,
    [det],
 
   w(verb(Ext,Inf,Part)),%% ad HOC   ... noe
   {Inf=inf; Part=part}, %% burde komme|kommet %% TA-110504
    !,
    state(S, ST) \  ([noe], w(verb(Ext,pres,fin))), %%  ... noe
    !.

sostatem(S,ST) --->  %% så må det gjøres noe 
 
    aux1,
    [det],
    w(verb(Ext,pres,pass)),%% ad HOC   ... noe
    !,
    state(S, ST) \  (someone, w(verb(Ext,pres,fin))), %%  ... noe
    !.


sostatem(S,ST) --->  %% egentlig kan dette gjøres 
 
    aux1, %% docan,  %% da må noe gjøres
    object(X,NP), %% allow dette
    w(verb(Ext,pres,pass)),%% ad HOC  
    !,
    state(S, ST) \  (someone, w(verb(Ext,pres,fin)),xnp(X,NP)),
    !.


sostatem(S,ST) --->  %% hvis trikken står (så) er det bra 
 
    not_look_ahead([så]), 
    w(verb(Be,PP,fin)), {PP \== inf}, %% AD-HACK-ING % ... kommer  det en buss
    [det],                            %% (jeg vil vente med å) legge det inn
    !,                               
    state(S, ST) -   w(verb(Be,pres,fin)),
    !.

sostatem(S,ST) --->  %% ellers kan ...busstuc utvides

    docan,  %% 
    subject(X,NP),
    w(verb(Ext,pres,pass)),%% ad HOC  
    !,
    state(S, ST) \  (someone, w(verb(Ext,pres,fin)),xnp(X,NP)),
    !.


%%%%¤¤¤¤  STATEM (S,STM)    
    
%%  Det  ønskes  %% Ad Hoc %% TA-110429
statem(S,STM) --->  
    [det],
    w(verb(Want,Pres,pass)),   gmem(Want,[want,wish,need]), 
    negation0(N),
    !, 
    state(S, STM) \ 
        ([noen],  w(verb(Want,Pres,fin)), negation(N),[dette]).





statem(S,STM) --->  %% TA-110310 Fronted 
   
     preadverbials, %% stacks adverbials, 1..n/ NOT adverbials0
     !,
     prestatem(S,STM).



%% den 21. mai  kjører vi vanlige ruter 
statem(S,STM) ---> 
    obviousdate1(Z,ZNP),
    w(verb(V,Pres,fin)),
    det0,      %% TA-110527  .. er det buss til helsfyr
    subject(X,XNP),
    !,
    []-obviousdate1(Z,ZNP), %% should not be first
    state(S, STM) \         %% TA-110310
        (  xnp(X,XNP),         
           w(verb(V,Pres,fin))).
           


%% den 21. mai  kjøres vanlige ruter
statem(S,STM) --->  %% den 21. mai  kjøres vanlige ruter
    obviousdate1(Z,ZNP),
    w(verb(V,Pres,pass)),
    optional([det]), 
    !,
    state(S, STM) - 
        ( [noen],                   
           w(verb(V,Pres,fin)),
           obviousdate1(Z,ZNP)).

%% Fronted PREDECT (Huff)

statem(S,ST) ---> %% TA-101020   %% dette bryr jeg meg ikke  om
    lit_of(_,[det,dette]),       %%  6     2    1   3   4    5
    w(verb(Worry,Pres,fin)), gmem(Worry,[worry]), %% etc ? 
    lit_of(Jeg,[jeg,du,man]),    %% etc
    reflexiv0(Worry),            %% (meg)
    negation0(N),
    [om],
    !,
         []-[dette],
       []-[om],

    state(S, ST) \
	    ([Jeg],
        w(verb(Worry,Pres,fin)),negation(N) ).



statem(S,ST) ---> %% TA-101020   %% dette vet jeg ingen ting om
    lit_of(_,[det,dette]),       %%  6    2   1    3    4    5
    w(verb(Know,Pres,fin)),
    lit_of(Jeg,[jeg,du,man]), %% etc
    np_kernel(0,Z,ZP),  %% ingen ting
    [om],
    !,
            []-[dette],
          []-[om],
        []- np_kernel(0,Z,ZP), 

    state(S, ST) \
	    ([Jeg],
        w(verb(Know,Pres,fin))).



statem(S,ST) --->                %% dette har jeg ingen informasjon om.
    lit_of(_,[det,dette]),       %%   6    2   1    3     4          5
    w(verb(have,Pres,fin)),
    lit_of(Jeg,[jeg,du,man]), %% etc
    np_kernel(0,Z,ZP),  %% ingen informasjon
    [om],
    !,
            []-[dette],
          []-[om],
        []- np_kernel(0,Z,ZP), 

    state(S, ST) \
	    ([Jeg],
       w(verb(have,Pres,fin))).

/*  %% Expensive ***
statem(S,ST) --->               %% det man ikke vet har man ingen anelse om
    np1_accept(Y,YNP),          %%  6   7   8    9   2   1   3     4     5
    w(verb(have,Pres,fin)),
    lit_of(Jeg,[jeg,du,man]), %% etc
    np_kernel(0,Z,ZP),  %% ingen informasjon
    [om],
    !,
            []-xnp(Y,YNP),
          []-[om],
        []- np_kernel(0,Z,ZP), 

    state(S, ST) \
	    ([Jeg],
       w(verb(have,Pres,fin))).
*/


%%%%%%%%%%%%


%% Pga et krav ble det satt opp en ekstravgang /// FRONTED TEST
statem(S,STM) ---> % er mora en mann = morgenen , en mann er

    preadverbial1(Prep,Z, APS), %% pga et krav
    blei,
    [det],
    preadverbial0(Prep2,Z2, APS2), %% i august  evt  redun
    w(verb(Arr,past,part)),
    object(Y,NPY),
    !,
    state(S,STM)\
        (xnp(Y,NPY),
         w(verb(be,pres,fin)),
         w(verb(Arr,past,part)),
         adverbial1(Prep,Z,APS),
         adverbial1(Prep2,Z2,APS2)).

statem(S,STM) --->  %% OBJECT MODAL  SUBJECT VERB   %% dette ønsker jeg å se
    not_look_ahead([det]), %% går det busser = det går busser
    obvious_object(Z,ZNP),  %% alt som du trenger å vite %% TA-110401
 %%    np0_accept(Z,ZNP),           %% ad hoc careful
    w(verb(Want,Pres,fin)),   gmem(Want,[want,wish,need]), 
    lit_of(Vi,[jeg,vi,han,hun,du]),  
    negation0(N),
    optional([å]), 
    w(verb(See,inf,fin)),
    !, 
    state(S, STM) \ 
        ([Vi],  w(verb(Want,Pres,fin)), negation(N),[å],w(verb(See,Pres,fin)),xnp(Z,ZNP)).

statem(S,STM) --->  %%   klippekort får  du kjøpt
    not_look_ahead([det]), 
%%     np0_accept(Z,ZNP),           %% ad hoc careful
    obvious_object(Z,ZNP),  %% alt som du trenger å vite %% TA-110401
    w(verb(H,Pres,fin)), gmem(H,[have,get]),
    lit_of(Vi,[jeg,vi,han,hun,du]), 
    w(verb(See,past,part)),
    !, 
    state(S, STM) \ ([Vi], w(verb(See,Pres,fin)), xnp(Z,ZNP)).


statem(S,STM) --->  %%   %% årsaken sjekker vi 
    not_look_ahead([det]), %% går det busser
    obvious_object(Z,ZNP), %% TA-110401
%% np0_accept(Z,ZNP),           %% ad hoc careful
    w(verb(See,Pres,fin)), 
        {\+ testmember(See,[give])}, %% ad hoc dette gir svar
    lit_of(Vi,[jeg,vi,han,hun,du]),  
    negation0(N), 
    !, 
    state(S, STM) \ 
        ([Vi], w(verb(See,Pres,fin)),negation(N), xnp(Z,ZNP)).

 
statem(S,STM) --->  %% OBJECT MODAL  SUBJECT VERB PREP     
                    %% dette ønsker jeg å se  på
                    %%    6     2    1  3  4  5
    not_look_ahead([det]), %% går det busser 

    obvious_object(Z,ZNP),       %% np0_accept( %% TA-110428   %% ad hoc careful
    w(verb(Want,Pres,fin)),   gmem(Want,[want,wish,need]), 
    lit_of(Vi,[jeg,vi,han,hun,du]), 
    optional([å]), 
    w(verb(See,inf,fin)),
    w(prep(On)),              %% NB * nærmere (på)
    !, 
    state(S, STM) \ ([Vi],  w(verb(Want,Pres,fin)),[å],w(verb(See,Pres,fin)), w(prep(On)), xnp(Z,ZNP)).

statem(S,STM) --->  %% dette kan du (gjøre) %% TA-101103
   
    obvious_object(Z,ZNP),     %% ad hoc careful
    [kan],
    lit_of(Vi,[jeg,vi,han,hun,du]), 
    not_look_ahead(w(verb(_,_,_))),
    !, 
    state(S, STM) \ ([Vi], w(verb(do1,pres,fin)), xnp(Z,ZNP)).


statem(S,STM) --->  %% OBJECT AUX SUBJECT  VERB      %% årsaken skal vi finne
    not_look_ahead([det]), %% går det busser 
    obvious_object(Z,ZNP),           %% ad hoc careful
    aux1,
    lit_of(Vi,[jeg,vi,han,hun,du]), 
    w(verb(Find,inf,fin)),
    !, 
    state(S, STM) \ ([Vi], w(verb(Find,pres,fin)), xnp(Z,ZNP)).

statem(S,STM) --->  %% OBJECT AUX SUBJECT  VERB      %% årsaken skal vi finne
    not_look_ahead([det]), %% går det busser 
    obvious_object(Z,ZNP),           %% ad hoc careful
    aux1,
    lit_of(Vi,[jeg,vi,han,hun,du]), 
    w(verb(Find,inf,fin)),
    !, 
    state(S, STM) \ ([Vi], w(verb(Find,pres,fin)), xnp(Z,ZNP)).


statem(S,ST) --->  %% det som er relevant  fins . 
    [det],
    [som],
    !,
    state(S,ST)\
       ([en],w(noun(thing,sin,u,n)),[som]).


statem(S,ST) --->  %% nå skulle det være riktig %% /DET preliminary
    one_of_lit([nå,så,da,redundant0]), %% om mulig 
    shoulditbe,
    w(adj2(Good,Nil)),
	 [å],
    !,
    itstatem(S,ST)\  (w(verb(be,pres,fin)),w(adj2(Good,Nil)), [å]). 


statem(S,ST) --->  %% nå skulle det være riktig %%  /DET subject
    one_of_lit([nå,så,da]), %% TA-110810
    shoulditbe,
    itstatem(S, ST) \  
        (w(verb(be,pres,fin))),
    !.

/* %% TA-110810
statem(S,ST) --->  %% nå skulle det være riktig %%  /DET subject
    one_of_lit([nå,så,da]),
    shoulditbe,
    state(S, ST) \  
        ([dette],w(verb(be,pres,fin))),
    !.
*/

shoulditbe ---> w(verb(be,_,fin)),redundant0,[det].          %% hvertfall det
shoulditbe ---> aux1,redundant0,[det],w(verb(be,inf,fin)). 

shoulditbe ---> one_of_lit([kan,kunne,får,fikk]),[det],vaere. %% 
                          %% touchy  aux/verb 


vaere --->  one_of_lit([være,vært,bli,blitt]). 

 
statem(S,STM) --->    %% det burde du vite
    [det],
    aux1,
    subject(X,XNP),
    w(verb(B,inf,fin)), {testmember(B,[believe,know])}, %% busstuc foreslår
        {verbtype(B,rv)},
    !,   
    state(S,STM)\
        (xnp(X,XNP),
         w(verb(B,pres,fin)),
         [dette]).


statem(S,STM) --->    %% dette tror jeg er farlig
    obvious_object(Y,YNP),  
    w(verb(B,T,fin)), {testmember(B,[believe,know])}, %% busstuc foreslår
        {verbtype(B,rv)},
    subject(X,XNP),
    !,   
    state(S,STM)\
        (xnp(X,XNP),
         w(verb(B,T,fin)),
         [at],
         xnp(Y,YNP)).



statem(S,STM) --->     %% spørsmålet har jeg svart på.
    obvious_object(Y,YNP),    %%  with care, not subject
    has,
    subject(X,XNP),
    w(verb(Ans,past,part)),
    !,   
    state(S,STM)\
        (xnp(X,XNP),
         w(verb(Ans,past,fin)),
         xnp(Y,YNP)).


statem(S,EQ) --->  %%  å komme til Lian er lett.
     [å],
     w(verb(V,inf,fin)),
     clausal_object1(Y, SC::NP)\
         ([noen], w(verb(V,pres,fin))),
     look_ahead(w(verb(be,pres,fin))), %% ad hoc
     !,
     state(S,EQ) \xnp(Y,SC::NP).


statem(S,ST) --->  %% dette lar seg ikke gjøre å 
    [det],
    w(verb(let,_Pres,fin)),  
    [seg],
    negation0(N),
    w(verb(do1,inf,fin)),
    [å],
    !,
    state(S, ST) \ 
        (w(noun(agent,sin,u,n)), aux1, negation(N)), %% not negation0 
    !.

%%% ... SÅ .. STATE


statem(S,T) ---> %% så,  da  
    soredundant, %% s
    sostatem(S,T). 


%% der helligdagene ... // det= adverbial place er allerede stakket, skal ikke poppes
%% helligdagene ved en feil kom med   .. Very restrictive
statem(S,STM) --->   
    w(noun(HD,Sin,Def,n)),  %% helligdagene
    look_ahead(w(prep(Prep))), {testmember(Prep,[at])},   %% ved en feil
    pp(Prep,Y, PP),                             %% #perioden fom . 6 / 4 t  
    state(S,STM)-                   
        ( w(noun(HD,Sin,Def,n)),
          pp(Prep,Y, PP)).


statem(S,ST) --->  %% dette løser jeg // Object Verb Subject
                   %% dette tar tid
    lit_of(Det,[dette]), %% NEW predicate // det may be prelim
    w(verb(Solve,Pres,fin)), 
           {\+ testmember(Solve,[be,give,take,cost])}, %% TA-110810 ad   hoc 
  
    subject(Su,SNP), 
    negation0(N),
    !,
    state(S, ST) \ ( xnp(Su,SNP),  w(verb(Solve,Pres,fin)), negation(N),[Det]),
    !.


%%%   PREADVERBIAL STATEM

/* moved up %% TA-110310 

statem(S,STM) --->  %%  experiment
   
     preadverbials, %% stacks advebials, 1..n/ NOT adverbials0
     !,
     prestatem(S,STM).
*/


statem(S,ST) ---> %% Bra for deg
    w(adj2(True,nil)), {testmember(True,[good,bad,correct,true,mild,hot,cold])}, %% ad hoc
    w(prep(For)),
    !,   
    state(S, ST) \  ([det],w(verb(be,pres,fin)), w(adj2(True,nil)),w(prep(For))).


statem(S,ST) ---> %% Bra for deg
    w(adj2(True,nil)), {testmember(True,[good,bad,correct,true,mild,hot,cold])}, %% ad hoc
    w(adv(Now)),
    !,   
    state(S, ST) \  ([det],w(verb(be,pres,fin)), w(adj2(True,nil)), w(adv(Now))).


statem(S, SEM) ---> 
    init, %%   thereit, Initial IT 
    negation(N),
    not_look_ahead(w(verb(_Solve,_,pass))), %% det løses -> dette løses 
    !,
    itstatem(S, SEM) - negation(N), %% \+ /
    !,accept.

statem(S, SEM) ---> %% TA-110114 %% det(te) kan du
    redundants0, %% jo           %%  3       2  1
    dette, %% pronoun = object
    aux1,  %% kan
    not_look_ahead([være]), %% TA-110624
    obvious_object(X,NPX),
    !,
    []-[dette],
    state(S, SEM)\(xnp(X,NPX),aux1).
        


statem(S, SEM) ---> 
    init, 
%%%%%%%%%    not_look_ahead(w(verb(_solve,_,pass))), %% det løses -> dette løses 
    !,
    itstatem(S, SEM),
    !,accept.


statem(S,Com::Q) --->  %% dont try state if thereit %% INITIL NP
    state(S, Com::Q),                               %% 
    !,accept.    %% Hazard 


%% Following very expensive if subject is hard

statem(S,Com::Q) --->  %% bussen er lett å ta
    subject(Y,SNP),
    be(N),
    so0,
    gradverb0(_Very),  
    w(adj2(Good,nil)),
    [å],
    {testmember(Good,
    [difficult,easy,expensive,free,funny,good,intelligent,sad,stupid,tedious  ])},  
        []-xnp(Y,SNP),
    {it_template(IT)},
    be_complements(IT,S, Com::P ) \ (w(adj2(Good,nil)) ,[å]), 
    {negate(N,P,Q)}.


statem(S,Com::Q) --->  %% jeg skal/vil på  byen  = til 
    np1_accept(X, NP), %% en venn     pronoun(X), %% [jeg],
    aux1,
    prepnof(Prep),
    {testmember(Prep,[on,to,towards])}, 
    !,accept,
    state(S, Com::Q) \  (np(X,NP),w(verb(go,pres,fin)),prep(to)).



statem(S,Com::Q) --->  %% jeg skal til  byen -> jeg går  %% Hazard Norwagism 
    not_look_ahead([dette]),
    not_look_ahead([det]),
    np1_accept(X, NP), %% pronoun(X), %% [jeg], 
    aux1,
    prepnof(Prep),
    {testmember(Prep,[to,from,near,in,on,past])}, %% Prag (not around)/ i  møte 
%    !,       fra = after/from   COMMIT error
    state(S, Com::Q) \  (np(X,NP),w(verb(go,pres,fin)),prep(Prep)).


statem(S,Com::Q) --->  %% /jeg) skal hjem 
    not_look_ahead([dette]),
    not_look_ahead([det]), 
    np1_accept(X, NP), 
    not_look_ahead([kan]), 
    aux1,
    look_ahead([hjem]), %% // Opps Jeg må ikveld*
    not_look_ahead([kunne]), %% AD HOC !!! 
    not_look_ahead(w(verb(_,_,_))), %% ta bussen ... 
    state(S, Com::Q) \  (np(X,NP),w(verb(go,pres,fin))).


statem(S,STM) --->       %% det(te) vil du like %% 
    dedette, 
    aux1,
    np1_accept(X,NP),
        []-[dette], %% used last
    state(S, STM) \ (xnp(X,NP),aux1).



dedette ---> [det].
dedette ---> [dette].
                                        %% Hvis du ...kan ...
soredundant0 ---> soredundant,!.
%% soredundant0 ---> []. %% er det torsdag \= så er det torsdag

soredundant ---> [når],!. %% hvor bussen står, NÅR går trikken %% TA-110418
                          %% capture hvis NÅR as hvis så
                 
soredundant ---> so,!.
soredundant ---> redundant.

so ---> [så],!.
so ---> [derfor],!. 
so ---> look_ahead_lit([kan,må,vil,skal,bør]). 
so ---> look_ahead(w(verb(know,_,fin))).  
   %% VERY careful hvis du vet hvor du skal, vet vi
%% so ---> look_ahead(w(verb(_Use,_,fin))).     %% TA-101207

%%...

statem(S,Com::Q) ---> %% for eksempel KAN  jeg  ...engelsk/ gå .
    adverbx(Day,DayClass,pre), 
    saa0, 
    [kan],     %% ad hoc,  know1???
    redundant0,
    np1_accept(X,NP),
    redundant0,
    state(S, Com::Q)  - 
        (noun_phrase1(X,NP),
         [kan],                  
         xadverb(Day,DayClass)). %% -x 

statem(S,Com::Q) ---> %% i morgen vil jeg hoppe fra bjørndalsbrua
    adverbx(Day,DayClass,pre), 
    saa0, 
    aux1,
    redundant0, %% jo 
    np1_accept(X,NP),
    redundant0, 
    state(S, Com::Q)  - 
        (noun_phrase1(X,NP),
         aux1,                  
         xadverb(Day,DayClass)). %% -x 

statem(S,Com::Q) ---> % idag skal jeg til NTH
    adverbx(Day,DayClass,pre), 
    saa0, 
    aux1,
    [jeg],
    redundant0, %% jo 
    !,accept,
    state(S, Com::Q)  -                    
        ( [jeg],[skal],xadverb(Day,DayClass)).  %% -x 



statem(S,Com::Q) --->  %% at bussen går er sant 
    [at], %% that, not "this"
    statem(S,Com::P),   %% ... det går en buss
    be_truefalse(N),
    {negate(N,P,Q)}.


statem(S,Com::Q) ---> % nå er jeg på nth %% Fronted 
    adverbx(Day,DayClass,pre), 
    saa0, 
    w(verb(BE,P,F)),
    negation0(N), %% Rhetoric Ad Hoc
    state(S, Com::Q)  /                    
        ( w(verb(BE,P,F)),  negation(N), xadverb(Day,DayClass) ). %% -x %% TA-101021

statem(S,Com::Q) ---> % nå er bussen kommet
    adverbx(Day,DayClass,pre), 
    w(verb(be,_,fin)),
    np1_accept(X,NP),
    w(verb(K,Past,part)), 
    !,
    state(S, Com::Q)  /                    
        (  np(X,NP), w(verb(K,Past,fin)), xadverb(Day,DayClass) ).  %% -x 


statem(S,Com::Q) ---> %%   Da er du ikke et orakel
    adverbx(Day,DayClass,pre), 
    be,
    specific_phrase(A, B::C),
    negation0(N),
    !,
    state(S, Com::Q)  -                    
        (  np(A,B::C), 
           be(N) ,
           xadverb(Day,DayClass)).   %% adverbx, not noun_compl  %% -x 
                                       %% nå må jeg kjøpe en bil
                                       %% -> jeg må kjøpe en (bil nå)                                       

statem(S,Com::Q) ---> %%  Da er ikke du  et orakel
    adverbx(Day,DayClass,pre), 
    w(verb(be,_,fin)), %%  ikke vil
    negation0(N),
    !,
    state(S, Com::Q)  -                    
        (be(N) ,xadverb(Day,DayClass)).%% -x 



statem(S,Com::Q) ---> %% Nå skal vi gå
    adverbx(Day,DayClass,pre), 
    saa0,
    (doit),
    state(S, Com::Q)  -                    
        (xadverb(Day,DayClass)). %% -x 


statem(S,ComQ) ---> %% da har du stoppet 
    adverbx(Day,DayClass,pre), 
    has,
    specific_phrase(A, BC),
    w(verb(V,past,part)),
    state(S, ComQ)  /                  
        (xnp(A,BC), w(verb(V,past,fin)) ,xadverb(Day,DayClass)). %% -x 



%% adverb prefixes moved after thereit prefixes of very subtle reasons
%% ///  jeg vet når det går buss


%% i en tid er den på dragvoll.
statem(S,SemSt) ---> 
    preadverbial1(Prep,Y, SemAdv), 
    w(verb(be,pres,fin)),
    state(S, SemSt)  -                    
        ( w(verb(be,pres,fin)),  
          adverbial1(Prep,Y,SemAdv )).

statem(S, SEM) ---> % i morgen kveld må %% EXPERIMENT 
    preadverbials0,      % are stored
    aux1, %% (doit),  må/skal 
    !,accept,
    state(S, SEM).               


statem(S,Com::Q) ---> %% I Trondheim er det en buss 
    adverbial1(Prep,Y, SC::P3), 
    be,
    
    !,
    statem(S,Com::Q)  -                    
        ( thereit, be,adverbial1(Prep,Y, SC::P3)).


statem(S,Com::Q) ---> %% på mandag skal jeg <dra> til nth 
    preadverbial1(Prep,Y, SC::P3),
    (doit),
    specific_phrase(A, B::C),
%   <dra>
    w(prep(TO)),
    !,
    state(S, Com::Q)  -                    
        (np(A,B::C),
         w(verb(go,pres,fin)),
         w(prep(TO)),
         adverbial1(Prep,Y, SC::P3)).


statem(S,Com::Q) ---> %% fronted %% I Trondheim vil/(ambig) vi ta buss
    preadverbial1(Prep,Y, SC::P3), 
    (doit),
    !,
    state(S, Com::Q)  -                    
        ( adverbial1(Prep,Y, SC::P3)).

%% For oss har bussen gått
statem(S,SEM) ---> 
    preadverbial1(Prep,Y, ADVSEM), 
    so0,  
    w(verb(have,Past,fin)), %% har/hadde
    subject(X,NP),
    !,
    state(S, SEM)  -           %% NB -         
        ( xnp(X,NP),
          w(verb(have,Past,fin)),
          adverbial1(Prep,Y, ADVSEM)).


statem(S,Com::Q) ---> % i morgen kveld går bussen 
    {value(dialog,1)}, %% expensive 
    preadverbial1(Prep1,Y1, SC1::P31), 
    preadverbial1(Prep2,Y2, SC2::P32), 
    lexv(Vcat,V,T,fin), 
    !,accept,
    state(S, Com::Q)  /                    
        ( lexv(Vcat,V,T,fin),    
          adverbial1(Prep1,Y1, SC1::P31),
          adverbial1(Prep2,Y2, SC2::P32)).


%%%%%%% End Statem

%%%¤ PRESTATEM  (S,STM)


prestatem(S,STM) ---> %% her er det godt

    w(verb(Be,T,fin)), gmem(Be,[be,stand]), 
    [det],
    w(adj2(Good,Nil)), 
    !,
    itstatem(S, STM) \                   
        (w(verb(be,T,fin)),w(adj2(Good,Nil))).
        

 


prestatem(S,STM) ---> %% da skal bussen kjøres av en sjåfør 
 
    so0, 
    aux1,
    negation0(N),      
    redundant0,    %%  alltid
    object(Y,NPY),
    redundant0,    %%  alltid
    w(verb(Take,Pres,pass)), {\+ testmember(Take,[be])}, 
    whodidit(X,BC), 
    !,                      %% av en voksen ? //// full passive
    state(S,STM)\
        (xnp(X,BC), 
         w(verb(Take,Pres,fin)),
         negation(N),
         xnp(Y,NPY)).
 

    

prestatem(S,STM) ---> %% til nardo er det på lørdag  en buss

    shoulditbe, %% TA-110810  ville det være
    % w(verb(be,T,fin)),
    % [det],
        not_look_ahead(w(adj2(_,_))), %% for meg er det bra |sikkert bra   
    adverbix0(Q,Z,QZ),                %% ad hoc
    !,
    itstatem(S, STM) -                   
        (w(verb(be,pres,fin)),
         xadverbial1(Q,Z,QZ)).


prestatem(S,STM) ---> %% i går var det slik at bussen sto

    w(verb(be,_,fin)),
    [det],
    slikat,
    !,
    state(S,STM).


prestatem(S,STM) ---> %% da hadde det sikkert vært en buss  (ad Hoc)

    w(verb(Have,_,fin)), gmem(Have,[have,be]), %% her ER det hendt noe 
    [det],
    redundant0,
    w(verb(Happen,past,part)),  
    look_ahead_np,       %% her har det hendt noe som jeg ikke * forstår . 
    !,
    subject(X,NP), 
    state(S, STM)  \                    
        ( xnp(X,NP),
          w(verb(Happen,past,fin))).

prestatem(S,STM) ---> %% i dag har jeg fått en ide %% TA-101117

    has,
    subject(X,XNP), 
    w(verb(Get,past,part)),
    object(Y,YNP),
    !,
    state(S, STM)  \                    
         (xnp(X,XNP),
          w(verb(Get,past,fin)),
          xnp(Y,YNP)).



prestatem(S,STM) ---> %% i dag har jeg en ide 

    w(verb(Run,_,fin)), {\+ member(Run,[])}, %% ad hoc
    subject(X,XNP), 
    not_look_ahead(w(verb(_,_,_Part))),
    object(Y,YNP),
    !,
    state(S, STM)  \                    
         (xnp(X,XNP),
          w(verb(Run,past,fin)),
          xnp(Y,YNP)).




prestatem(S,STM) --->  %% (idag) virker det ikke %% TA-110304

    not_look_ahead(w(verb(be,_,_))), %% her er bussen -> adverb
    not_look_ahead(w(verb(be1,_,_))), %%  når er jeg fremme %%
    so0,    
    w(verb(V,Pres,fin)),
    [det],
    not_look_ahead_np, %%  til nth går det en buss. %% TA-110426
    negation0(N),    
    !,
    state(S, STM)  \                   
        ( [dette],w(verb(V,Pres,fin)),negation(N)).



prestatem(S,STM) --->  %% i morgen går bussen. 

    not_look_ahead(w(verb(be,_,_))), %% her er bussen -> adverb
    not_look_ahead(w(verb(be1,_,_))), %%  når er jeg fremme %%
    so0,    
    w(verb(V,Pres,fin)),
    det0,             %% TA-110228
    particlev0(V,V1), %% opp 
    negation0(N), 
    !,
    state(S, STM)  -                    
        ( w(verb(V1,Pres,fin)),negation(N)). 





prestatem(S,STM) ---> %% ved streik  tas buss 

    so0, 
    w(verb(Take,Pres,pass)), {\+ testmember(Take,[be])}, 
    thereit0, 
    negation0(N),                                        %% for meg er  det bra
    !,
    object(Y,NPY),
    state(S,STM)\
        ([noen],
         w(verb(Take,Pres,fin)),
         negation(N),
         xnp(Y,NPY)).


prestatem(S,STM) ---> %% her er bussen %% TA-101008

    w(verb(be,Pres,fin)), 
    negation0(N),                       
    !,
    subject(X,NPX),
    state(S,STM)\
        (xnp(X,NPX),
         w(verb(be,Pres,fin)),
         negation(N)).
  



prestatem(S,STM) ---> % Nå kan man ikke det %% kan = verb| aux problem

    so0,
    [kan],
    subject(X,NP),
    redundant0, 
    not_look_ahead(w(verb(_,_,_))), %% ..gå
    not_look_ahead([ikke]), %% da kan du ikke hjelpe meg % ad hoc
    !,
    state(S, STM)  -                   
        (xnp(X,NP),
         w(verb(do1,pres,fin))). %% OR know1 ???


prestatem(S,STM) ---> %% i morgen skal  bussen gå

    so0,
    aux1,
    subject(X,NP),
    negation0(N), %% da kan du ikke hjelpe meg
    !,
    state(S, STM) -                   
        (xnp(X,NP),
         aux1,
         negation(N)).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%¤¤¤   ITSTATEM (S,SEM)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

itstatem(S,SEM) ---> %% Det er en løsning at  Bingo%% TA-110809
    be,
    np0_accept(XS,NPS),
    [at], 
    {traceprint(4,it00)},
    !,
    clausal_object1(OX,ONP),
    state(S,SEM) \
        (xnp(OX,ONP),w(verb(be,pres,fin)),xnp(XS,NPS)). %% Bingo er en løsning
       



itstatem(S,SEM) ---> %% Det er en buss %% TA-110809
    be,
    not_look_ahead(w(adj2(_,_))), %% rart %% TA-110819
    look_ahead_np,  
    {traceprint(4,it01)},
    !,
    state(S,SEM) -
        w(verb(exist,pres,fin)).



itstatem(S,SEM) ---> %% Det er|går en buss  %% TA-110809
    w(verb(Help,Tens,fin)), {Help \== be},
    look_ahead_np,  
    {traceprint(4,it02)},
    !,
    state(S,SEM) -
        w(verb(Help,Tens,fin)).





itstatem(S,SEM) ---> %% Det hjelper   -> Dette hjelper           #2%% TA-110426
    negation0(N1),   %% TA-110707
    hlexv(_,Help,Tens,fin,N2), 
      {bigno(N1,N2,N)},  
        gmem(Help,[help,give,make,create]),
      
      {traceprint(4,it0)},
    !,
    state(S,SEM)\
        ([dette], w(verb(Help,Tens,fin)), negation(N)).



itstatem(S,ISEM) --->     %% det har jeg // dette
    w(verb(V,Pres,fin)),  %% TA-110304
            gmem(V,[have]),
    subject(X,XNP),

    {traceprint(4,it1)},
    state(S, ISEM) \ 
        (xnp(X,XNP),w(verb(V,Pres,fin)),[dette]).




itstatem(S,ISEM) --->     %% TA-110112   det(=dette) betyr at
    lexvaccept(rv,V,Pres,fin,N),   
    [at],
    look_ahead_np,    
    {traceprint(4,it2)},
    !,             
    state(S, ISEM) \ 
        ([dette],w(verb(V,Pres,fin)),negation(N)). 


itstatem(S,SEM) ---> %% Det er ikke kartet som er feil//
                        %% = kartet er ikke feil         //
                        %% * det er ikke kartet som er feil som er feil
    be,    
    redundant0, 
    negation0(N),    
      not_look_ahead(w(nb(_,_))),  
      not_look_ahead_lit([jeg,du]),   

    np0_accept(A,SU), %% # any np where som is not included
              
    [som],
     w(verb(Be,Pres,fin)),   %% TA-101207
     {traceprint(4,it3)},
      !,  
    state(S, SEM) \  
        ( xnp(A,SU), 
          w(verb(Be,Pres,fin)),negation(N)),  
    !,accept. %% <--- !!!    

%% Sentence DET ... %%%

itstatem(S,ST) ---> %% det er jeg ikke sikker på %% TA-101025

    be,

    subject(X,NP),
    negation0(N), 

    not_look_ahead(noun(_,_,_,_)),  %% en del feil \= en del dom er feil
                                    %% TA-110527
    w(adj2(Certain,nil)),
    w(prep(On)),
    {traceprint(4,it4)},
    !,
    state(S, ST) \ 
        (xnp(X,NP),
         w(verb(be,pres,fin)),
         negation(N),
         w(adj2(Certain,nil)),
         w(prep(On)),
         [dette]).



itstatem(S,ST) ---> %% det vil jeg gjøre %% TA-100914

    aux1,
    subject(X,NP),
    negation0(N), 
    w(verb(See,_,fin)), 
    {traceprint(4,it5)},
    !,
    state(S, ST) \ 
        (xnp(X,NP),
         w(verb(See,pres,fin)),
         negation(N),
        [dette]).

/* ( det er  en løsning at  det) er en gjennomgang. %% TA-110808
itstatem(S,Com::Q) ---> %% Fronted %% TA-110122

    be_truefalse_that(N), %% slik at
    statem(S,Com::P), %% ... det går en buss %% Recursion
     {traceprint(4,it6)},
    !,
    {negate(N,P,Q)}.
*/




itstatem(S,EQ) ---> %% TA-100912 det er rart å ta bussen
    be(N),
    gradverb0(_Very),  
    w(adj2(Inc,NIL)), %% sant/feil ? veldig interessant 
    [å],
    {traceprint(4,it7)},
    !,
    clausal_object1(X,XNP)\([jeg],[vil]),  
       
    state(S,EQ)\
         (xnp(X,XNP),
          w(verb(be,pres,fin)),
          negation(N), 
          w(adj2(Inc,NIL))). %% stacked thing



itstatem(S,EQ) ---> %% FRONTEST det er nødvendig med opplæring
    be(N),
    ap(A,XT,S, AP ),
    pp(with,Y,NP), %% assembled by isq
 
    %%  w(prep(with)),
    %% np1_accept(X,NP),
    {traceprint(4,it8)},
    !, 
    state(S,EQ)\
         (xnp(Y,NP),
          w(verb(be,pres,fin)),
          negation(N), 
          ap(A,XT,S, AP )).

itstatem(S,EQ) ---> %% det er rart at bussen går
    be(N),
    gradverb0(_Very),  
    w(adj2(Inc,NIL)), %% adj1(ABig,AV,AS,ABIGX), %% veldig interessant 
    [at],
    {traceprint(4,it9)},
    !,
    clausal_object1(X,XNP),
       
    state(S,EQ)\
         (xnp(X,XNP),
          w(verb(be,pres,fin)),
          negation(N), 
          w(adj2(Inc,NIL))). %% stacked thing


itstatem(S,EQ) ---> %%  det er veldig lett for meg å ta buss
    be(N),         
    gradverb0(_), 
    w(adj2(Easy,Nil)),
    w(prep(for)),
    object(Z,ZNP),
  
    [å],
      {traceprint(4,it10)},
    !,accept,

    clausal_object1(X,XNP)\(xnp(Z,ZNP),[vil]), %% ta buss
        
    state(S,EQ)\
         (  xnp(X,XNP), % (at) jeg tar buss
            w(verb(be,pres,fin)), % er
            negation(N),          % ikke
            w(adj2(Easy,Nil))).   % lett
         

itstatem(S,EQ) ---> %%  det er veldig lett for noen å ta buss %% NEC ???
    be(N),          %% det er lett for meg at noen tar buss // ad hoc
    w(adj2(Easy,Nil)),
    pp(PP,Z,PPS),  %% for meg        (with care)
    [å],
      {traceprint(4,it11)},
    !,accept,

    clausal_object1(X,XNP)\[noen],
        
    state(S,EQ)\
         (  xnp(X,XNP),
            w(verb(be,pres,fin)),
            negation(N),  
            w(adj2(Easy,Nil)),
            pp(PP,Z,PPS)).



itstatem(S,EQ) ---> %%  det er lett å ta buss
    be(N),
    adj1(ABig,A:_,AS,ABIGX), %% veldig interessant 
    [å],
    w(verb(Take,inf,fin)), %% lexv(tv,Take,inf,fin), %% se=see (\+look)  
    reflexiv0(Take), %% seg 
      {traceprint(4,it12)},
    !,
    clausal_object1(X,XNP)\
        ([noen],
          w(verb(Take,pres,fin))),
    state(S,EQ)\
         (xnp(X,XNP),
          w(verb(be,pres,fin)),
          negation(N), 
          adj1(ABig,A:_,AS,ABIGX)). %% stacked thing




itstatem(S,EQ) ---> %%  det er nødvendig = dette er nødvendig
    be(N),
    adj1(ABig,AP,AS,ABIGX), 
    not_look_ahead_np, %% det er fin vær
    %% endofline, %% requires empty stack ????
      {traceprint(4,it13)},
    !,
    state(S,EQ)\
         ([dette],
          w(verb(be,pres,fin)),
          negation(N),  
          adj1(ABig,AP,AS,ABIGX)). %% stacked thing



itstatem(S,Com::P) ---> %% be ---> exist ?  // FRONTED // dubious
                        %% det er ikke kartet som er feil//
    be,                 %% -> *** kartet som er feil eksisterer ikke
    preadverbials0,  %% TA-110527
    redundant0,         %% det er vel ingen ...
    negation0(N),    
      not_look_ahead(w(nb(_,_))),     %% 1 time til 
      not_look_ahead_lit([jeg,du]),   %% det -er- du 
    not_look_ahead([det]), %% det er det ---> ooo %% TA-101012

    np1_accept(X,NP), %% feil på hjemmesiden %% TA-110527

    [som], %%% ?????  det er en del feil \= det er en del (som) er feil

      {traceprint(4,it14a)},
   % !,  
    state(S, Com::P) \  
        (xnp(X,NP),w(verb(be,pres,fin)),negation(N)),  %% *exists 
    !,accept. %% <--- !!!    


itstatem(S,ISEM) --->  %% TA-110122 after be_true_false_that
                       %%  det er relatert til  situasjonen .
    be,
    negation0(N),
    not_look_ahead_np,    
      {traceprint(4,it14b)},
    !,             
    state(S, ISEM) \ 
        ([dette],w(verb(be,pres,fin)),negation(N)). 


itstatem(S,SEM) ---> %% Det hjalp med restart 

    w(verb(Cost,Tense,fin)), gmem(Cost,[help,function]),
    [med],
    np0_accept(M,K),
      {traceprint(4,it15)},
    !,
    state(S, SEM) \
        (xnp(M,K),w(verb(Cost,Tense,fin))).



itstatem(S,SEM) ---> %% Det koster 30 kroner å ta buss %% preliminary clausal SUBJECT 

    w(verb(Cost,Tense,fin)), gmem(Cost,[cost,take]),
    np0_accept(M,K),
    [å],
      {traceprint(4,it16)},
    !,
    clausal_object1(XCO,COSEM)\([noen],[vil]), %% noen tar buss = dette
    state(S, SEM) \(xnp(XCO,COSEM),
    w(verb(Cost,Tense,fin)),xnp(M,K)). % dette koster 30 kroner



itstatem(S,Com::P1) ---> %% Det går an å ta buss #1 %% TA-110426
     
    w(verb(go,pres,fin)),
    redundants0,   %% TA-110426 sikkert
    negation0(N),    
    ann0,  %% [an],  hazard?
    infinitive,
      {traceprint(4,it17)},
    state(S,Com::P) \ someone,
    {negate(N,P,P1)}.

itstatem(S,ISEM) --->  %% det går (ikke)(an) = er (ikke) mulig
    negation0(N1),     %% TA-110803
    hlexv(_Iv,go,T,fin,N2),  
    {bigno(N1,N2,N)},    
    optional([an]),
    not_look_ahead_np, %% oops tog
       {traceprint(4,it17b)},
    !,             
    state(S, ISEM) \ 
        ([dette],w(verb(be,T,fin)),negation(N),w(adj2(possible,nil))). 



itstatem(S,ISEM) --->  %% det skjedde ikke noe som jeg likte    #2 

    negation0(N1),

    hlexv(_Iv,V,T,fin,N2),  %% det er ikke slik ut %% det gir svar 
                            %% TA-110706
        {bigno(N1,N2,N)},    
   {\+ testmember(V,[cost,take])}, %% be ??  %% TA-110808 Haz ?
   preadverbials0,   %% TA-110527            %% da vil  løsningen være at det blir en bus   
   look_ahead_np,    
      {traceprint(4,it18)},
    !,             
    subject(X,SNP),
    state(S, ISEM) \ 
        (xnp(X,SNP),w(verb(V,T,fin)),negation(N)). 




itstatem(S,SEM) ---> %% Det hjelper å ta buss %% preliminary clausal SUBJECT
    w(verb(Help,Tense,fin)),
    [å],
      {traceprint(4,it19)},
    !,
    clausal_object1(XCO,COSEM)\([noen],[vil]), %% noen tar buss = dette
    state(S, SEM) \
        (xnp(XCO,COSEM), w(verb(Help,Tense,fin))). % dette hjelper 


itstatem(S,STM) ---> %%  det ble sagt at bussen sto

    blei,
    redundant0,   %%  .. derfor
    negation0(N), 
    w(verb(Arr,past,part)),
    [at],
      {traceprint(4,it20)},
    !,accept,
    state(S,STM)\
        ([noen],
         w(verb(Arr,past,fin)),
         negation(N), %% sa at ikke <-> sa ikke at
         [at]).




itstatem(S,STM) --->   %% det er/ble arrangert et møte

    blei,
    preadverbial0(Prep,Z,APS),
    redundant0,  %% .. derfor
    negation0(N), 
    w(verb(Arr,past,part)),
    object(Y,NPY),
      {traceprint(4,it21)},
    !,accept,
    state(S,STM)\
        (xnp(Y,NPY),
         w(verb(be,pres,fin)), 
         negation(N), 
         w(verb(Arr,past,part)),
         adverbial1(Prep,Z,APS)).




itstatem(S,SEM) ---> %% Det kjøres ruter = Noen kjører ruter 

    w(verb(Run,Tense,pass)),
    negation0(N),
      {traceprint(4,it23)},
    !,
    state(S,SEM)\
        ([noen], w(verb(Run,Tense,fin)), negation(N)).


itstatem(S,EQ) ---> %% Det er sikkert at bussen går

    w(verb(be,Pres,fin)),
    redundant0, %% likevel  
    w(adj2(Easy,nil)), {testmember(Easy,[certain,uncertain,good,bad])},
    atom,            %% usikkert -> om
    {traceprint(4,it24)},
    !,
    clausal_object1(X,XNP)\
   
    state(S,EQ)\
         (xnp(X,XNP),
          w(verb(be,Pres,fin)),
          w(adj2(Easy,nil))).

atom ---> [at].
atom ---> [om].


itstatem(S,EQ) ---> %%  (Object) Det er lett å lage = Dette

    w(verb(be,Pres,fin)),
    redundant0, %% likevel   
    w(adj2(Easy,nil)),
    [å],
    w(verb(Make,inf,fin)),
    reflexiv0(Make), %% seg 
    not_look_ahead_np,
      {traceprint(4,it25)},
    !,
    clausal_object1(X,XNP)\
        ([noen],
          w(verb(Make,pres,fin)),
          [dette]),
    state(S,EQ)\
         (xnp(X,XNP),
          w(verb(be,Pres,fin)),
          w(adj2(Easy,nil))).




% Pronomial Subject

itstatem(S,EQ) ---> 

    w(verb(be,Pres,fin)),
    negation0(N),
    w(prep(In)),
      {traceprint(4,it26)},
    !,
    state(S,EQ)\
       ([dette],    
        w(verb(be,Pres,fin)),
        negation(N),
        w(prep(In))).


%% 

% Antecipatory Subject


itstatem(S,EQ) --->  %%  det er lett å komme til Lian 
 
     w(verb(be,pres,fin)),
     w(adj2(Easy,nil)),
     [å], 
     w(verb(V,inf,fin)),
       {traceprint(4,it27)},
     !,
     clausal_object1(Y, CONP)\
         ([jeg], w(verb(V,pres,fin))),
     !,
     state(S,EQ) \
        (xnp(Y,CONP), w(verb(be,pres,fin)), w(adj2(Easy,nil))).


itstatem(S,ST) ---> %% det forstår jeg (IT er object)

    w(verb(See,_,fin)), {verbtype(See,rv)},
    subject(X,NP),
    {traceprint(4,it28)},
    !,
    state(S, ST) \ 
        (xnp(X,NP),
         w(verb(See,pres,fin)),
         [dette]).


itstatem(S,STM) --->  %%  Det har jeg (vel strengt tatt) ikke sagt noe om

    w(verb(have,_Pres,fin)),
    subject(X,SNP),   
    redundant0,
    negation0(N),
    w(verb(Say,past,part)),
    {testmember(Say,[tell])}, %% etc
    [noe],
    [om],
      {traceprint(4,it29)},
    state(S,STM) \ 
      ( xnp(X,SNP),
        w(verb(Say,past,fin)),
        negation(N),
        [noe],
        [om],
        [det]).   %% -> ..np..


itstatem(S,ST) ---> %% det gjelder systemet

    w(verb(Go,_,fin)),
   {testmember(Go,[concern])},  %% etc gjelder
      {traceprint(4,it30)},
    !,
    state(S, ST) \ 
       (w(noun(thing,sin,u,n)), %% something ?
        w(verb(Go,pres,fin))).
   


itstatem(S,ST) ---> %% det går  bra i morgen %% -> ting går bra

    w(verb(Go,_,fin)),
   {testmember(Go,[go,look,see,function])}, %% etc  
    w(adv(Good)),%% bra 
    optional([ut]), %% for look 
      {traceprint(4,it31)},
    !,
    state(S, ST) \ 
       (w(noun(thing,sin,u,n)), %% something ?
        w(verb(Go,pres,fin)),
        w(adv(Good))). 


itstatem(S,Com::Q) ---> 
    w(verb(Rain,_,fin)),
    {testmember(Rain,[rain,snow,look,be_urgent])}, %% det ser ut
      {traceprint(4,it32)},
    !,
    state(S, Com::Q) \ 
(   something,
    lexv(iv,Rain,pres,fin)).

itstatem(S,Com::P) ---> %% Experiment
            
    pvimodal(Cost,_Money),    %% costs , takes, lasts
    {constrainit(IT,thing)}, %% ad hoc              %    {constrainit(IT,Money)},
      {traceprint(4,it32)},
    verb_phrase1(Cost,IT,id, S,Com::P) \ 
        w(verb(Cost,pres,fin)).  %   koster penger aa ta buss
                                 % = koster penger for å ta buss


itstatem(S,Com::P1) ---> %% Det begynner å gå en buss 
     
    beginverb(Go,N), 
    np1(A, NP1),
      {traceprint(4,it33)},
    state(S,Com::P) \  (np1(A, NP1), w(verb(Go,pres,fin))),
    {negate(N,P,P1)}.



itstatem(S,Com::P) --->  
     
    be,
    adverbial(Prep,Y, SC::P3),  %% - i kveld at
    that,
      {traceprint(4,it34)},
    state(S, Com::P)  /  adverbial(Prep,Y, SC::P3).


itstatem(S,Com::P) ---> %% Det er godt at jeg lever
            
    be,
    negation0(_N),
    saa0,
    not_look_ahead(w(verb(_Verify,past,part))), 
    w(adj2(_Good,nil)),
    one_of_lit([at,om]), %% that, 
      {traceprint(4,it35)},
    !,accept,           
    statem(S,Com::P). %% i.e.was substatem  IGNORE the adjective %% bussen ikke går

itstatem(S,Com::P) ---> %% Det er godt jeg lever
            
    be,
    negation0(_N),
    saa0,
    w(adj2(Good,nil)),
   {testmember(Good,[good])},  %%  Er det edru sjåfører

    not_look_ahead(w(noun(_,_,_,_))), %% det er gode svar ****
    {traceprint(4,it36)},

    statem(S,Com::P).           %% Recursion

%%   det er mørke kvelder #*** 
itstatem(S,Com::Q) --->  
            
    be(N),
    {it_template(IT)},
    so0,
    gradverb0(_Very),  
    w(adj2(Good,nil)),
    {testmember(Good,
        [difficult,easy,expensive,free,funny,good,intelligent,
         mild,hot,cold,wet,dark,bright,cloudy,
         sad,stupid,tedious  ])},  
    %% late is also adverb
      {traceprint(4,it37)},
    be_complements(IT,S, Com::P ) \ w(adj2(Good,nil)), % Det er mørkt i kveld. 
    {negate(N,P,Q)}.
 

itstatem(S,Com::P) --->
            
    lexv(iv,V,T,fin), 
    {\+ testmember(V,be)}, 
    negation0(N),
    adverb(X,Y,_),   %%  (snart)  late is both adjective and adverb
      {traceprint(4,it38)},
    !,
    state(S, Com::P) -  
        (lexv(iv,V,T,fin),negation(N),xadverb(X,Y)).


itstatem(S,ST) --->  %% det er = det fins %% Last 

    be(N),
    subject(Su,SNP), 
      {traceprint(4,it39)},
    !,
    state(S, ST) \
     ( xnp(Su,SNP),  w(verb(exist,pres,fin)), negation(N)),
    !.


%%%%¤¤¤¤  STATREAL  (P) 

%% statreal(_P) ---> which,!,reject. %% vet du hvilken -> du vet hvilken 
%% statreal(_P) ---> [hvilken],!,reject. %% 



statreal(P) ---> %%  without cut
    stat(real,P). 


%%%%¤¤¤¤  STAT(R,P) 

stat(Real,Q) ---> 
    state(S,  Com::P), %% without cut
    worldcomp(Real,  S,Com::P,Q).


%%%%¤¤¤¤  STATREAL1  (P) 

statreal1(Q) ---> %%  with cut
    state1(S, ComP), %% with cut
    worldcomp(real,  S,ComP,Q).
 

%%%%¤¤¤ STATE1 (S,EP)

state1(S, Com::P) ---> 
    np(X,NVP::P),       %% -> vet du ikke/vet ikke du
    negation0(M),
    redundant0,  
    !,
    vp(X,N ,S,Com::VP),
    {bigno(M,N,O)},
    {negate(O,VP,NVP)},
    !.

%%¤ SUBSTATE (Sm ComP)

substate(S, Com::P) --->  %% experiment   (at) jeg idag tar bussen
    subject(X,NVP::P),    %% jeg
    preadverbials0,          %% idag
    negation0(N0),        %% ikke
    !,
    vp(X,N, S,Com::VP), %% N must not be preset !!!
       {bigno(N0,N,N1)}, 
       {negate(N1,VP,NVP)}.



%%%%¤¤  STATE (S,EP)  - normal np vp


state(S, Com::P) --->  

    subject(X,NVP::P), 

    redundant0,    %% der hadde de bare ...
    negation0(N0), 

%%%%    !,   %% No Cut
             %% jeg tar bussen som  jeg tar|passerer NTH    
             %% np will return  bussen first

    vp(X,N, S,Com::VP), %% N must not be preset !!!
    
    {bigno(N0,N,N1)}, 
    {negate(N1,VP,NVP)}.


%%%%%%%%%% END OF STATEMENT SECTION %%%%%%%%%%



    
beginverb(Go,N) ---> 
	 w(verb(start,_,fin)), %% begynner
    negation0(N),         %% ikke
    infinitiveand,        %% å ( og)
    w(verb(Go,_,fin)).    %% gå


%%%¤ QUESTION  (P)

question(P) --->  %% klokka ? 
            
    w(noun(clock,sin,_,n)),
    terminator,
    !,
    whatq(P)  \  ([hva],w(verb(be,pres,fin)),w(noun(clock,sin,def,n))). 


question(P) ---> whichq(P).
question(P) ---> whoq(P).
question(P) ---> whenq(P).

question(P) ---> howadjq(P).    % hvor mange busser stopper
question(P) ---> whereq(P).     % hvor stopper mange busser
question(P) ---> wherefromq(P). %% (before ppq  (fra hvor))

question(P) ---> whatq(P). 
question(P) ---> howmuchq(P).  
question(P) ---> whyq(P). 
question(P) ---> howq(P).
question(P) ---> ppq(P).
question(P) ---> whoseq(P).




question(P) --->   %% Avoid ( Er klokka 23 === Ja)
    be,                
    w(noun(clock,_,_,_)),
    !,
    np1(_, __), %% 23 (ignore)
    danow0,     %% nå da 
    !,
    whatq(P)  \  ([hva],be,the,w(noun(clock,sin,def,n))). 

question(P) ---> question1(P). 



question1(test:::P) ---> % YES NO Questions %% Fronted 
    [får],
    specific_phrase(X,NP), %% was iman
    !,
    statement(P) \ (np(X,NP),[får]).      %% neutral wrt får aux | verb

question1(new:::P) ---> % har tenkt å ta buss 
    w(verb(have,pres,fin)),   
    w(verb(Want,past,part)),
    {testmember(Want,[want,think])}, 
    not_look_ahead([du]), 
    !,
    statement(P) \  ([jeg], w(verb(Want,pres,fin))).

question1(new:::P) ---> % YES NO Questions 
    w(verb(Want,pres,fin)),
    {testmember(Want,[want,think,hope])}, 
    particlev0(Want,W), %% håper på 
    not_look_ahead([du]), 
    !,
    statement(P) \  ([jeg], w(verb(W,pres,fin))).

question1(test:::P) ---> question0(P).


np_question(which(XT):::Z) ---> np1(XT, true::Z).


%%%%¤ QUESTION0  

% question with no quantifier

question0(P) ---> isq(P).   % Moved before  ynq 

question0(P) ---> ynqs(P). %%  Vil du ha buss eller vil du ha trikk.

question0(P) ---> hasq(P). %% har du en bussrute 

question0(P) ---> hoq,statement(P). % Er det slik at ...


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%¤ IMPLICITQ 

%% This is extreme
implicitq(new:::P ) --->     %%  fra sollia som ankommer samfundet 1730 . 
                            %% = buss <   > går
    w(prep(From)), {testmember(From,[from,to])},
    w(name(Sollia,n,Station)), {testmember(Station,[station,neighbourhood])},
    {no_unprotected_verb},   
    [som], 
    look_ahead_vp, %% protected by som

    np1_accept(X, P1::P) \ 
            (w(noun(bus,sin,u,n)),  
             w(prep(From)),
             w(name(Sollia,n,Station))),        
              
    {traceprint(4,iq00)},
    !,accept,    
    verb_phrase1(_V,X,id, S,event/real/S::P1),
  
    !,accept. 



implicitq(modifier(S)::: Com12 and P3) ---> %% Når går (neste) Nidarosdomen
     not_look_ahead([nr]), 
     [når],
     {\+ value(dialog,1)},  
     w(verb(go,_,fin)),
     optional([neste]),
     w(name(ND,n,Nei)), {testmember(Nei,[station,neighbourhood])},
     {traceprint(4,iq01)},
     !,
    {setvartype(XB,vehicle)}, 
     realcomp(S, ERS,P3),  
     verb_modifiers(go,XB,S, Com12 ::true, ERS) \ 
           w(name(ND,n,Nei)).



implicitq(WI) ---> %% når + //no verb// + station ->  %% når trollahaugen 
     not_look_ahead([nr]),
     [når],
     {\+ value(dialog,1)},  
     {no_unprotected_verb}, %
     look_ahead(w(name(_Th,_,P))), 
     {subclass0(P,place)},
     !,accept,
     {traceprint(4,iq2)}, 
     implicitq(WI)  \  w(prep(to)). %% Hazardous ????  


implicitq(test:::WI) ---> %% når nr 
     {\+ value(dialog,1)},  
     not_look_ahead([nr]), 
     [når],
     [nr],
     {no_unprotected_verb}, %
     !,accept,
     {traceprint(4,iq3)}, 
     ynq(WI)\ w(verb(go,pres,fin)).


implicitq(test:::WI) ---> %% når + //no verb// -> skip når
     not_look_ahead([nr]), 
     [når],
     {\+ value(dialog,1)},  
     {no_unprotected_verb}, %
     optional([det]), %%
     !,accept,
     {traceprint(4,iq4)}, 
     ynq(WI)\ w(verb(go,pres,fin)).


implicitq(_) --->
    reject_implicitq,
    !,reject.

% % %

 
implicitq(new:::P ) --->     %% buss .. som ankommer.. // with care.
    look_ahead(w(noun(Abus,sin,u,n))), 
        {subclass0(Abus,vehicle)}, 

    {no_unprotected_verb},   %% som ankommer protected
    np1_accept(X, P1::P),      
    {\+ vartypeid(X,time)}, %% tid "går ikke"
    {\+ vartypeid(X,clock)}, 
    constrainvehdep(X), 
    not_look_ahead([som]), %% not a new one
    not_look_ahead([om]),  %% om morgenen,... %% ad hoc 
    point0, 
    !,accept,                
    {traceprint(4,iq4b)},
    verb_phrase1(go,X,id, S,event/real/S::P1) \ w(verb(go,pres,fin)),
                 %% \+ _ 
    optional(itrailer),  %% buss 8 fra byen    når ?
    endofline,           %%  s.p. andersens veg = sentrum . ...
    !,accept.            %%% skummel %%%
  


%% Teleflag is a flag for database query mode 
%% avdeling erik harborg // special

implicitq(which(X):::Q) --->   %% teleflag avdeling erik harborg
    {value(teleflag,true)},
    w(noun(Dep,_,_,n)), 
    not_look_ahead(w(prep(_))),
    person_name(EH:person,PP,_),
    endofline, %% s.p.andersens veg = sentrum. ... 
    !,
    {traceprint(4,iq5)}, 
    no_phrases(X,Q) = 
        (w(noun(Dep,sin,u,n)),w(prep(to)),  nameq1(EH:person,PP)),
    !,accept. 


implicitq(which(X):::P) ---> %% teleflag  Nardo
    {value(teleflag,true)},
    no_phrases(X,P), 
    endofline, %% s.p.andersens veg = sentrum. 
    {traceprint(4,iq7)},
    !,accept.


implicitq(new:::P ) --->     %% tider fra dragvoll %% Ad Hoc Problem
    {\+ value(dialog,1)},   %% // buss til nth
    not_look_ahead(w(prep(_))),
    {no_unprotected_verb}, %% NEW AUXILLARY    tuc/lex.pl   
    w(noun(time,_,_,N)),
    look_ahead(w(prep(_))), 
    np0(X, P1::P)\  w(noun(departure,sin,u,N)),    %% ad hoc 
    {traceprint(4,iq8)}, 
    !,accept,  
    verb_phrase1(_V,X,id, S,event/real/S::P1) \ w(verb(go,pres,fin)),
    endofline, 
    !,accept.  



%% NSB GODS Syndrome: 
%%                         
%% buss dragvoll
%% buss TS
%% buss NSB
%% tog  NSB
%% NSB NSB

implicitq(new:::P ) --->     %% buss 5 Dragvoll 

    not_look_ahead(w(nb(_,num))), %% avoid 2 2 = bus 2 goes (with) route	 2
                                %% TA-101129, første ok
    not_look_ahead(w(prep(_))),
    {no_unprotected_verb},   
    np1_accept(X, P1::P), %% TA-101022 
                          %% NP with modifiers dont backtrack to shorter  (longest first)        

    {\+ vartypeid(X,time)}, %% tid "går ikke"
    {\+ vartypeid(X,clock)}, 
    constrainvehdep(X), 
    not_look_ahead([som]), 
    not_look_ahead([om]),  %% om morgenen,... %% ad hoc 
                               
    point0, 
    !,accept,                
    {traceprint(4,iq9)},
    verb_phrase1(_V,X,id, S,event/real/S::P1) \ w(verb(go,pres,fin)),
    optional(itrailer),  %% buss 8 fra byen    når ?
    endofline,           %%  s.p. andersens veg = sentrum . ...
    !,accept.            %%% skummel %%%




implicitq(modifier(S)::: Com12 and P3) ---> %% kl 1234 ...
      {value(dialog,1)}, 
      not_look_ahead([nå]), %% not intended
    time1(NI),  
%%    {number(NI)},
    endofline,
       {no_unprotected_verb}, %% NEW AUXILLARY    tuc/lex.pl
       no_harmful_adj,  
       no_harmful_noun, 
       {setvartype(XB,vehicle)}, 
       realcomp(S,  ERS,P3),   %%  etc
    deter0,   
    verb_modifiers(go,XB,S, Com12 ::true, ERS)\
            obviousclock1(NI:clock,NI isa clock), %% ad hoc
       {traceprint(4,iq10)}, 
       !,accept, %%   ( don t waste time )
       qtrailer0.  %% takk 


implicitq(new:::P ) --->     %% buss 5 Dragvoll ///  NOT neste buss
    {value(dialog,1)},      %%  buss til nth
    not_look_ahead(w(prep(_))),
    not_look_ahead_flnp,
    {no_unprotected_verb},  %% NEW AUXILLARY    tuc/lex.pl   
    np0(X, P1::P),            %% NP without modifiers
    {\+ vartypeid(X,time)}, %% tid "går ikke"
    {\+ vartypeid(X,clock)}, 
    constrainvehdep(X), 
    not_look_ahead([om]), %% morgenen %% ad hoc
    not_look_ahead([som]), 
    !,accept,  
    {traceprint(4,iq11)}, 
    verb_phrase1(_V,X,id, S,event/real/S::P1) \ w(verb(go,pres,fin)),
    endofline,          %% s.p. andersens veg = sentrum . ...
    !,accept.           %%% skummel %%%


implicitq(P) --->  % 4 neste til ... // Neste 4 = neste buss 4!
    the0, 
    w(nb(Number,num)), 
    flnp(Next),
    w(prep(To)),  
    !,accept,
    {traceprint(4,iq12)},
    implicitq(P) \ %% illegal recursion!
       ( w(nb(Number,num)),
         w(adj2(Next,nil)),
         w(noun(route,plu,u,n)),
         w(prep(To)) ).
  

%% Next to NTH...

implicitq(modifier(S)::: Com12 and P3) ---> %%  neste til // ikke
    flnp(Next),
    not_look_ahead([p]), %% s.p. andersens veg

    therightprep(From),  %% fra -> from  , not after %% Hack

    !,accept,
    {traceprint(4,iq13)},
    realcomp(S, ERS,P3), 
    verb_modifiers(go,X:vehicle,S, Com12  ::X isa vehicle and adj/nil/Next/X/S, ERS) \ 
        w(prep(From)),
    !,accept. 



implicitq(WI) --->  %% holdeplasser på risvollan
    {\+ value(dialog,1)}, %% siste buss -> modifier ! 
    w(noun(Station,X,Y,Z)), 
    not_look_ahead(w(name(_D3,_,_))), %% holdeplass D3 -> "Holdeplass" (SIC)
    {testmember(Station,[station])}, %% TA-110816
    look_ahead(w(prep(_))), %%  \+ endoffile // "station"    
    {no_unprotected_verb}, 
    !,accept,
    {traceprint(4,iq14)},
    whatq(WI) \ ( whatbe,w(noun(Station,X,Y,Z))).



implicitq(WI) ---> %% nærmeste holdeplass ...
    {\+ value(dialog,1)}, %% siste buss -> modifier ! 
    w(adj2(nearest,nil)), %%  special
    look_ahead(w(noun(Station,_,_,_))), 
    {testmember(Station,[station])},
    {no_unprotected_verb}, 
    !,accept,
    {traceprint(4,iq14b)},
    whatq(WI) \ ( whatbe ,w(adj2(nearest,nil))).



%% Protected verb:    (bussen ...) som går ...
%% Unrotected verb:    (bussen ...) går ...
%% {no_unprotected_verb},  


implicitq(modifier(S)::: Com12 and P3) ---> %% nå Dalen Hageby -> TIL Hageby
    [nå],
    {\+ value(teleflag,true)},
    {\+ value(textflag,true)},
    {no_unprotected_verb}, %% NEW AUXILLARY    tuc/lex.pl
    not_look_ahead(w(adj2(_,nil))), %% raskeste 
    not_look_ahead(w(noun(_,_,_,_))), %% buss etc

    not_fnlp, 

    {setvartype(XB,vehicle)}, 
    realcomp(S,  ERS,P3),  
    verb_modifiers(go,XB,S, Com12 ::true, ERS) - [nå],  
    {traceprint(4,iq15)},
    !,accept. %%   ( don t waste time )


implicitq(modifier(S)::: Com12 and P3) ---> %% klokken 17 fra nth til risvollan 
    {\+ value(teleflag,true)},
    {\+ value(textflag,true)},
    {no_unprotected_verb}, %% NEW AUXILLARY    tuc/lex.pl

    not_look_ahead(w(nb(_,_))), %% 151 til rykkinn \+ clock %% TA-100923
    obviousclock1(X,Colock), %%  % HH:MM 

    {setvartype(XB,vehicle)}, 
    realcomp(S,ERS,P3), 
    deter0,   
    verb_modifiers(go,XB,S, Com12 ::true, ERS)\ 
           (w(prep(after)), %% <--- default
            obviousclock1(X,Colock)),
    !,accept, %%  don t waste time
    {traceprint(4,iq17)}, 
    qtrailer0.  %% takk 



implicitq(modifier(S)::: Com12 and P3) ---> %%   (buss) 5 i morgen
    {\+ value(dialog,1)},
    {no_unprotected_verb}, %% NEW AUXILLARY    tuc/lex.pl
    namep(_,X,P),

%%%%%    not_adjective_only, %%

    no_harmful_adj, %%%% Gamle oslovei
 %%%    not_look_ahead(w(adj2(_,_))), %% => 3 is count 

    {constrain(X,vehicle)},
    not_look_ahead([om]), %% morgenen .. 

    not_look_ahead(w(nb(_,_))), %% avoid 2 2 = bus 2 goes (with) route    2
                              
    realcomp(S,ERS,P3), 
    verb_modifiers(go,X,S, Com12  ::P, ERS), %% At least one (Feature)
    {traceprint(4,iq18)},
    !,accept. 




implicitq(modifier(S)::: Com12 and P3) ---> %% ad hoc Tors(dag) veg 
    not_look_ahead(w(name(_,_,_))), 
    w(noun(Day,sin,u,n)),
    {test(Day ako day)},
    {setvartype(XB,vehicle)}, 
    realcomp(S,ERS,P3), 
    verb_modifiers(go,XB,S, Com12 ::true, ERS)\
         (w(prep(on)), w(noun(Day,sin,u,n))), 
    {traceprint(4,iq19)},
    !,accept. 




implicitq(new:::P ) --->     %% buss 5 til Dragvoll
    {no_unprotected_verb}, 

    not_look_ahead(w(nb(_,_))), %% TA-101006

    np1_accept(X, P1::P), 
    {\+ vartypeid(X,thing)}, %% noe
    {\+ vartypeid(X,time)}, %% tid "går ikke"
    {\+ vartypeid(X,clock)},
    {\+ vartypeid(X,arrival)}, %% ankomst 1300 # \+ 1300 go 
    {\+ vartypeid(X,departure)},     
    not_look_ahead([om]), %% 9 om morgenen %% ad hoc

    not_look_ahead(w(nb(_,_))), %% avoid 2 2 = bus 2 goes (with) route    2
                               
    constrainvehdep(X), 
    !,accept,  
    {traceprint(4,iq20)}, 
    verb_phrase1(_V,X,id, S,event/real/S::P1) \ w(verb(go,pres,fin)),
    endofline,          %% s.p. andersens veg = sentrum . ...
    !,accept.           %%% skummel %%%




implicitq(new:::P ) --->  %% når bussen = går bussen 
    [når], %% w(verb(reach,pres,fin)), 
    np_kernel(_Null0_,X, R1R2),        %% // returns of
    !,accept,   
    constrainvehdep(X),                    %% only vehicle
    !,                                    
    {traceprint(4,iq21)}, 
    np1(X, P1::P) \ np_kernel(0,X, R1R2), 
    verb_phrase1(_V,X,id, S,event/real/S::P1) \ w(verb(go,pres,fin)).


implicitq(modifier(S)::: Com12 and P3) ---> %%  neste  Nth til Risvollan
    athe0, %% de 
    flnp(Next),
    not_look_ahead(w(nb(_,_))), 
    not_look_ahead(w(name(_,_,route))), %%
    look_ahead(w(name(_,_,_))),      %%  NB place!
    !,accept,
    {traceprint(4,iq22)}, 
    realcomp(S,ERS,P3), 
    verb_modifiers(go,X:vehicle,S, Com12  ::X isa vehicle and adj/nil/Next/X/S, ERS),
    !,accept. 


%% NNN -> What is NNN


implicitq(WI) ---> %% billett til
        { \+ value(dialog,1)},  
        not_look_ahead(w(noun(clock,_,_,_))),
        not_look_ahead(w(noun(thing,_,_,_))), %% etc
        not_look_ahead(w(noun(answer,_,_,_))),
        not_look_ahead([det]),                %% d. 
        not_look_ahead(w(name(_Prinsen,n,_))), %% Prisen hotell 
        look_ahead(w(noun(Ticket,_,_,n))),   
       {testmember(Ticket,[ticket,price])}, %% etc etc
    np1_accept(A, NP),
        !,accept,
        {traceprint(4,iq23)},
    whatq(WI) \ ( whatbe,  xnp(A,NP)).



implicitq(WI) --->  %% klokka -> hva er klokka
    { \+ value(dialog,1)},  
    w(noun(Clock,_,_,_)),
    {testmember(Clock,[clock,date])},
    not_look_ahead(w(nb(_,_))), %%
    !,accept,
    {traceprint(4,iq24)}, 
    whatq(WI) \ ( whatbe,   w(noun(Clock,_,_,_))) .



implicitq(modifier(S)::: Com12 and P3) ---> %% NTH Risvollan
        {\+ value(teleflag,true)},
        {\+ value(textflag,true)},
        {no_unprotected_verb}, 

        w(name(NTH,n,P1)),   {subclass0(P1,place)},
        w(name(RISVOLLAN,n,P2)), {subclass0(P2,place)},
        
        {setvartype(XB,vehicle)}, 
        realcomp(S, ERS,P3),  
        
        not_look_ahead(w(nb(_,_))), %% 100 -> 01:00 -> go 01:100 ...
        {traceprint(4,iq25)},

    verb_modifiers(go,XB,S, Com12 ::true, ERS)\  %% At least one (Feature)

        (w(prep(from)), w(name(NTH,n,P1)),
         w(prep(to)),   w(name(RISVOLLAN,n,P2))),
    !,accept, %%   ( don t waste time )
    qtrailer0.  %% takk 




implicitq(modifier(S)::: Com12 and P3) ---> %% Dalen Hageby -> TIL Hageby

        {\+ value(teleflag,true)},
        {\+ value(textflag,true)},
        {no_unprotected_verb}, 
        no_harmful_adj,  
        no_harmful_noun, 
        not_look_ahead([du]), 
        {setvartype(XB,vehicle)}, 
        realcomp(S, ERS,P3),  
     deter0,   
        not_look_ahead(w(nb(_,_))), %% 100 -> 01:00 -> go 01:100 ...
        no_harmful_adj, %%%% Gamle oslovei
        redundants0, %% SIC selv. %% TA-110215
        {traceprint(4,iq26)},
     verb_modifiers(go,XB,S, Com12 ::true, ERS),  %% only1 ? ( ooo) %% TA-110106
        !,accept, %%   ( don t waste time )
        qtrailer0.  %% takk 


implicitq(WI) ---> %% handicap (based on iq23 (implicitq further up))
        { \+ value(dialog,1)},  
        not_look_ahead(w(noun(clock,_,_,_))),
        not_look_ahead(w(noun(thing,_,_,_))), %% etc
        not_look_ahead(w(noun(answer,_,_,_))),
        not_look_ahead([det]),                %% d. 
        not_look_ahead(w(name(_Prinsen,n,_))), %% Prisen hotell 
        look_ahead(w(noun(Handicap,_,_,n))),   
       {testmember(Handicap,[handicap,handicapped,wheelchair])}, %% etc etc
    np1_accept(A, NP),
        !,accept,
        {traceprint(4,iq27)},
    whatq(WI) \ ( whatbe,  xnp(A,NP)). % implicitq er samme som whatq uten whatbe,xnp
                                       % i praksis: omgjør til whatq ved å pushe whatbe,xnp til stack


%%%%¤¤ REJECT-IMPLICITQ     

reject_implicitq ---> [hvilke]. %% etc etc 

reject_implicitq ---> look_ahead(w(nb(1000,num))), %% tusen takk
                      not_look_ahead([en]),  
                      not_look_ahead([et]), 
                      not_look_ahead([to]),
                      not_look_ahead([tre]). %% etc

reject_implicitq ---> [at].

reject_implicitq ---> w(noun(error,_,_,_)).

reject_implicitq ---> 
     not_look_ahead(w(adj2(fast,_))), %% raskeste etc
     not_look_ahead(w(adj2(best,_))),
     w(adj2(good,nil)). %% nyttår

reject_implicitq --->  [kan].

reject_implicitq --->  
    not_look_ahead([e]), %%  e b schieldrops veg,e=er
    w(verb(When1,_,_)),
    
    {When1 \== reach}. %% når 

reject_implicitq ---> 
    w(noun(_,_,_,_)), %% bussen 
    w(verb(_,_,_)).   %% går

reject_implicitq ---> 
   not_look_ahead([de]),   % e.g. art 
   not_look_ahead([den]),
   not_look_ahead([det]),
   not_look_ahead([alle]), 
   not_look_ahead([en]),   %% Also quant_pron
   quant_pron(_,_). 


reject_implicitq ---> 
    w(noun(_,_,_,_)), %% bussen 
    posspron(_).      %% bussen din


reject_implicitq --->   %% AD HOC // ruteopplysninger til melhus ?
    w(noun(H,_,_,_)),
    {testmember(H,[possibility,necessity])}. %% ja/nei 


reject_implicitq --->  
    what.    %% (explicit what question is covered)% hva initierer verb_komplement


reject_implicitq ---> 
    [der].  

reject_implicitq ---> 
    [hvor].  %% (explicit hvor question is covered) %% hvor initierer verb_komplement

reject_implicitq ---> 
    [hvem].  %% (explicit hvem question is covered) %% hvem initierer verb_komplement

reject_implicitq ---> %% når bussen fra X til Y// når går bussen 
    not_look_ahead([nr]),
    not_look_ahead([n]), 
    [når],  %% ikke [n] som betyr neste 
    not_look_ahead(w(prep(from))). %% når fra ... 

reject_implicitq ---> 
    so.          %% så flink du er 

reject_implicitq ---> 
    w(nb(1000,num)),     %% første OK 
    look_ahead([takk]). %% tusen takk 

reject_implicitq --->  %%  Huff da *
    [da].

reject_implicitq --->  %%  og takk for det
    [og].

reject_implicitq --->   %%  men  takk allikevel
    [men].

reject_implicitq --->    %%  Hvis bussen starter kl 1234, når er ..   
    not_look_ahead([om]),  
    [hvis]. 

reject_implicitq ---> 
    [fordi]. 

/* unnec %% TA-101110
reject_implicitq ---> %% j falkbergets vei
    not_look_ahead([j]),
    [jeg].  %% j eller jeg ???
*/
 
reject_implicitq ---> 
    [ja].          

reject_implicitq ---> 
    [nei].         

%% Complex passover // det ---> [det], de ---> [det], de OK, det ikke OK

reject_implicitq ---> %% after the0 ...
    {value(notimeoutflag,true)},
    [det].  %% Prag.

reject_implicitq ---> %% after the0 ...
    [det],
    w(verb(be,_,_)).  %% Prag.


reject_implicitq ---> 
    w(adj2(good,nil)),       %% god morgen NOT implicitq 
    w(noun(M,_,_,_)),
   {testmember(M,[morrow,morning,day,night,evening,midnight,afternoon,prenoon,saturday,sunday])}.
 

reject_implicitq --->         %%      "Natta !"
    w(noun(Mid,_,def,_)),     %%  "Natt buss" OK
    {testmember(Mid,[midnight])}.

reject_implicitq ---> 
    [på],
    [forhånd],
    [takk].

reject_implicitq --->   %%   "avganger"
   w(noun(NB,_,_,_)), 
   {\+ testmember(NB,[nightbus,airplane,airbus])}, %% give message 
   endofline,
   {value(notimeoutflag,true)}, %% Hazard
   !,reject.


reject_implicitq --->   %% nå er jeg på nth
   [nå],
   endofline, 
   !,reject. %% sic

   
%%%%%%%%%
    

%% NB  halv er adjektiv !!! %% not any more 

no_harmful_adj   ---> 
    look_ahead(w(adj2(A,nil))),  
    {testmember(A,[nearest,good,next])}, %%%% TA-100905  direct, %% direkte fra nth til risvollan
    !,reject.      %%  Gamle Olsolvei
no_harmful_adj   --->  [].

no_harmful_noun --->  %% flyplass|bro  til nardo %% TA-110816
    look_ahead(w(noun(AP,_Sin,_u,n))), 
        gmem(AP,[airport,bridge]),
    !,accept.



%% {\+ testmember(P,[airport])}, %% ? %% TA-110815 %% RS-131229

no_harmful_noun --->  
    look_ahead(w(name(_Ts,_,P))),
    {subclass0(P,place)}, 
    !,accept.

no_harmful_noun ---> %% holdeplassen risvollansenteret  
    optional([alle]),  
    look_ahead(w(noun(Station,sin,_,_))), %% holdeplasser risvollan nth //###
    {testmember(Station,[station])}, %% clock])}, %% N: klokka?
    !.
 

no_harmful_noun --->  %% retning risvollan
    look_ahead(w(noun(Dir,sin,u,n))), %% retning(=mot)
    {testmember(Dir,[arrival,departure,station,student])}, %% TA-110314 studenter samfundet
    !.

no_harmful_noun --->  
    not_look_ahead(w(noun(Airport,_,_,_))), %% TA-110815
    {\+ testmember(Airport,airport)}.



therightprep(from)  ---> w(prep(from)),!. %% from is one of them 
therightprep(After) ---> w(prep(After)),!.


not_adjective_only ---> look_ahead(w(name(_GBB,n,_))),!.
not_adjective_only ---> look_ahead(w(adj2(_,_))). %% 3 neste => 3 count


not_fnlp ---> look_ahead(w(adj2(GGGG,nil))), 
    {testmember(GGGG,[first,next,last,previous])},
    !,reject.
not_fnlp ---> [].

% % % % % % % % % % % % % % % % % % % %

%%¤ CONSTRAINVEHDEP (X)

constrainvehdep(X) ---> {vartypeid(X,thing)},!,reject. %% Don't instantiate 
constrainvehdep(X) ---> {constrain(X,clock)},!,reject.

constrainvehdep(X:_) ---> {constrain(X:_,number)},  
                         {plausible_busno(X)}, 
                         !,accept.
                                                  

constrainvehdep(X) ---> {constrain(X,summerroute)},    !.
constrainvehdep(X) ---> {constrain(X,winterroute)},    !.
constrainvehdep(X) ---> {constrain(X,route)},          !.
constrainvehdep(X) ---> {constrain(X,route_plan)},     !. 
constrainvehdep(X) ---> {constrain(X,vehicle)},        !. 
constrainvehdep(X) ---> {constrain(X,departure)},      !. 
constrainvehdep(X) ---> {constrain(X,arrival)},        !.
constrainvehdep(X) ---> {constrain(X,connection)},     !. 
constrainvehdep(X) ---> {constrain(X,tram_route)},     !. 
constrainvehdep(X) ---> {constrain(X,tram_route_plan)},!.
constrainvehdep(X) ---> {constrain(X,trip)},           !. 

%% constrainvehdep(X) ---> {constrain(X,street)}, !,accept. %% raskeste  vei
%% constrainvehdep(X) ---> {constrain(X,time)}, !,accept. %%  tider for buss 60 fredag

%% Has question

%%%¤ HASQ (P)

hasq(P) --->  %% har det gått en buss 
    has,
    thereit(_Ikke), % Rhetorical
    w(verb(Go,past,part)), %% lexv ???
    !,accept,
    statement(P) -  ([det], w(verb(Go,pres,fin))). 



hasq(P) --->  %% har dere ikke (Rhet)
    w(verb(have,_,fin)), 
    negation0(_), %% rhetoric 
    so0,     
    subject(A, NP), %% TA-101115
    negation0(_), %% rhetoric
    adverbx0, 
    hatt0,
    negatino,  %% rhetoric  ikke/ingen
    sometimes0, 
    !,
    statement(P) \ (xnp(A, NP), w(verb(have,pres,fin))).

hasq(P) --->  %% har ikke = har dere  Rhet ???
    w(verb(have,Pres,fin)),  %%  ha en fin dag
    negation0(_),    %% Rhet
    statement(P)  /  w(verb(have,Pres,fin)).

%% OOPS    er det første buss til nth
%%     ==> (det er første) buss til nth
%%     ==> buss til nth  (er første)
%

%%%¤ ISQ (P)  IS-question

isq(P) --->   %% Er det mulig å 
    be,       % er det mulig at jeg ...      
    negation0(_), %% rhet
    thereit(_), % ignore neg 
    negation0(_), %% rhet
    so0, 
    w(adj2(True,nil)), gmem(True,[true,false,wrong,correct]),
    [å],
    !, 
    clausal_object1(COV,CNP)\[jeg],
    !,
    substatement1(P) \  (xnp(COV,CNP),w(verb(be,pres,fin)),
                      w(adj2(True,nil))).



isq(P) --->   %% Er det sant at du er et orakel 
    be,                
    negation0(_), %% rhet 
    thereit(_), % ignore neg 
    negation0(_), %% rhet 
    so0, 
    w(adj2(True,nil)), gmem(True,[true,false,wrong,correct]),
    [at], 
    !, 
    
    clausal_object1(COV,CNP),
    !,
    substatement1(P) \  (xnp(COV,CNP),w(verb(be,pres,fin)),
    w(adj2(True,nil))).



 
isq(P) --->  %% ER det hendt noe (special) 
    w(verb(be,Pres,fin)),
    negation0(_),    % Rhetorical 
    thereit(_Ikke),
    w(verb(Happen,past,part)), 
    !,
    []- w(verb(Happen,Pres,fin)),
    statement(P).



isq(P) --->   %% er du i trondeim 
    be,       %% avoid er (du i trondheim)
    negation0(_), %% Rhet %% TA-110309
    pronoun(Du),  %% Haz  ?  
    negation0(_), %% Rhet
    not_look_ahead_np, %% TA-110105
    not_look_ahead([som]), %% **  er han som skriver flink 
    !,
    substatement1(P)  \   (pronoun(Du),w(verb(be,pres,fin))).


isq(P) --->   %% Er det umulig for deg å være sur %% TA-101022
    be,                
    [det],
    negation0(_), %% rhet %% 
    so0, 
    w(adj2(Poss,nil)),
    w(prep(for)),
    object(Z,NPZ),
    [å],
    !,
    clausal_object1(COV,CONP)\(xnp(Z,NPZ),[vil]), %% .. være sur
    
    substatement1(P) \
       (xnp(COV,CONP), be,w(adj2(Poss,nil))).




isq(P) --->   %% Er det kaldt i Trondheim
    be,                

    thereit(_), % ignore neg 
    negation0(_), %% rhet %% 
    so0, 
    w(adj2(Cold,nil)),
    prepnog(Cold,In),  %% er det langt fra=after*/ til = of*
     !, %% er det lov med hund på bussen %% Hazardous
    substatement1(P) \  (something, be,w(adj2(Cold,nil)),w(prep(In))).


isq(P) --->   %% Er det gøy å være bussorakel 
    be,                
    negation0(_), %% rhet
    thereit(_),   %% ignore neg Rhetoric
    negation0(_), %% rhet 
    so0, 
    w(adj2(Good,nil)), 
       {\+ testmember(Good,[])}, %% ad hoc rough 
    [å],
    !,
    substatement1(P) \  ([det],w(verb(be,pres,fin)),w(adj2(Good,nil)),[å]).
        

isq(P) --->   %% Er det kaldt 
    be,                
    negation0(_), %% rhet 
    thereit(_), % ignore neg 
    negation0(_), %% rhet 
    so0, 
    w(adj2(Cold,nil)),
    !, 
    substatement1(P) \  
        ([noe], w(verb(be,pres,fin)),w(adj2(Cold,nil)) ).


isq(P) --->   %%  Er det i denne etsajen ? 
    be,
    dette,
    negation0(_), % ignore neg (rhetorical) 
    !,
    substatement1(P)  \ ( [dette], w(verb(be,pres,fin))).


isq(P) --->   %% er det ingen avganger til skistua ?
    be,                
    thereit, %% [det] | [de], 
    ikkeingen0,  %% ignore neg (rhetorical)
    !,
    substatement1(P)  -  ([det],w(verb(be,pres,fin))).  %% dont preselect

%%  er personen som jeg ser tøff  | * |/  personen som jeg er  ser tøff 



isq(P) --->   %%     er personen som jeg ser tøff  
    be,       %% \+  personen som jeg er  ser *tøff  
    negation0(_), 
    
    subject(X,XNP), %% personen som jeg ser

    negation0(_),  %% TA-110309 Rhet

    !,
    substatement1(P) \  
        (xnp(X,XNP),w(verb(be,pres,fin))).   



isq(P) --->   %%  Når er det første buss 
    be,
    det0,
    negation0(_), 
    !,
    substatement1(P)   
         -   w(verb(be,pres,fin)). 





ikkeingen0 ---> [ingen],!.
ikkeingen0 ---> negation0(_).


% % % % % % % % % % % % % %


ynqs(P) ---> isynq(P1), orwill(P1,P), 
    !,accept. 


isynq(P) ---> isq(P).
isynq(P) ---> ynq(P).

orwill(P,P) ---> %% (buss) eller trikk eller ...
    [eller],
    endofline,!,
    accept.

orwill(P,P or Q) ---> %% (buss) eller trikk eller tog 
    [eller],
    not_look_ahead(w(nb(_,_))), %% buss 3 eller 4  etc
    !,accept,
    isynq(P1),
    orwill(P1,Q).

orwill(P,P) ---> [].

%%

%%%%¤¤  YNQ (P)


ynq(P) --->  %% går det bra ?
    w(verb(Go,Pres,fin)),      %% nå
    {\+ testmember(Go,[be,have])}, %% er du = er du redundantly
    [det],
    negation0(_),
    look_ahead(w(adj2(_,_))),
     !,
    statreal(P) - ([dette],w(verb(Go,Pres,fin))).



ynq(P) ---> %%  koster det XX å ta bussen
 
    w(verb(V,_,fin)),
    {testmember(V,[cost])},
    [det],
    np0_accept(Y,YNP),
    [å],
    clausal_object1(COV,COST)\([noen],[vil]),     
    !,
    statreal1(P)  \ 
        (xnp(COV,COST),
         w(verb(V,pres,fin)),
         xnp(Y,YNP)). 
    

%% AUX Questions

ynq(P) --->    %% vil det skje en ulykke
    aux1,
    [det],
    negation0(_), %% Rhetoric
    w(verb(happen,inf,fin)),
    subject(A, NPS), %% ikke det
    not_look_ahead_vp, %% 
    statreal1(P) \  (xnp(A, NPS),w(verb(happen,pres,fin))), 
    !,accept. 



%% (i morgen) skal jeg til = gå til// FRONTED TEST


ynq(P) --->    %% Kan  as main verb
   [kan],
    negation0(_), %% Rhetoric
    subject(A, NPS), %% ikke det
    negation0(_), %% Rhetoric 
    not_look_ahead_vp, %% 
    statreal1(P) \  (xnp(A, NPS),w(verb(know1,pres,fin))), 
    !,accept. 


ynq(P) --->  %% får jeg (kjøpt) billett  
    [Får], {testmember(Får,[får,kan,kunne])}, 
    negation0(_),    %% rethoric 
    subject(A,BC),
    negation0(_),          
    !,
    statreal1(P) \ (xnp(A,BC),[Får]). %% delay decision

ynq(P) --->  %% vil bussen være gul = er bussen gul
    aux1,   
    subject(A,BC),
    w(verb(Verb,inf,fin)),  
        not_look_ahead(w(verb(_Borrow,_,_))), %% skal han få låne spillet
    {\+ verbtype(Verb,rv)}, %% wait=expect Ad Hoc
    negation0(_),          
    !,
    statreal1(P) \ (xnp(A,BC), w(verb(Verb,pres,fin))).


ynq(_) --->  %% \+ see,past,fin 
    [så],
    !,reject.


%% (i morgen) skal jeg av (på NTH) = gå av 
ynq(P) --->  
    aux1,   
    not_look_ahead(w(verb(go,_,_))), %% go = reise = noun(travel)
    subject(A,SNP),  
    [av],
    !,accept, 
    adverbx0,                   
    negation0(_), %% Rhetorical 
    statreal1(P) \ ( xnp(A,SNP),
               w(verb(go,pres,fin)),
               [av]).

%% (i morgen) skal jeg til = gå til
ynq(P) --->  
    aux1,  
    not_look_ahead(w(verb(go,_,_))), %% go = reise = noun(travel)
    subject(A,NP), 
    redundant0, 
    w(prep(TO)), 
               {TO \== av}, %% må jeg av på NTH 
    !,accept, 
    adverbx0,                   
    negation0(_), %% Rhetorical 
    statreal1(P) \ 
             ( xnp(A, NP),
               w(verb(go,pres,fin)),
               w(prep(TO))).


ynq(P) --->    %% Rhetorical negation (incomplete) 
    aux1(_,_), %% burde %%  % skal bussen ikke gå   % kan du sommerrutene
    negation0(_), %% rhetorical %% skal ikke du 

    not_look_ahead([man]), %% mandag
    not_look_ahead([jeg]), %% skal jeg til byen 
    not_look_ahead([du]), %

    subject(A, NP), 

    preadverbial0(Prep,Z,APS), %%  //OOPS, dont eat when-adverbial
                               %%  skal jeg (til byen)|
    negation0(_), %% rhetorical %% skal ikke du 
    !,accept, 
    adverbx0,                   
    negation0(_), %% Rhetorical 
    []-adverbial1(Prep,Z,APS), %% may be empty
    statreal1(P) \ ( noun_phrase1(A, NP),aux1), %% (i morgen) skal jeg til nth) 
    !,accept.



ynq(P) ---> % YES NO Questions  %% Kan du vise meg
    (doit),
    you,
    w(verb(V,_,fin)), %% imp/inf/pres 
    {testmember(V,[list,show])}, %% etc. 
    !,  %% <--- !!!   
    command(doit:::P) \ (w(verb(V,imp,fin))).     %% dirt



ynq(P) ---> % YES NO Questions
    (doit), 
    negation0(_), %% ignore negation
    statreal1(P).      
 
ynq(_) ---> aux1,prep(_),!,reject. %% skal til byen 


%% Verb Question


ynq(P) --->  %% koster det en krone å ta bussen 
    w(verb(Cost,_,fin)), gmem(Cost,[cost,take,be]),
    [det],
    np0_accept(M,K), 
    [å],
    !,
    clausal_object1(XCO,COSEM)\([noen],[vil]), %% noen vil ta buss = dette

    statreal1(P)\ (xnp(XCO,COSEM),w(verb(Cost,pres,fin)),xnp(M,K)).

ynq(P) --->  %% ambiguous  tv/rv 
    w(verb(Know,Tense,fin)),
       {testmember(Know,[know,find])},
    negation0(_), %% rhetoric %% TA-100916
     !,
    statreal1(P) - (w(verb(Know,Tense,fin))). 
                          


ynq(P) --->  %% passerer det nå en buss fiolsvingen ? 
    lexv(tv,Stop,Tense,fin), 

%%     {\+ rv_templ(Stop,_)}, %%   oops  find

    {Tense \== imp},                         %% not command here !
    {\+ testmember(Stop,[have,think])}, %% tenkte bare jeg skulle
    not_look_ahead(w(adj2(_,_))), %% tidlig adv+adj 
    anyadverb0,
    !,
    statreal1(P) - (w(verb(Stop,Tense,fin))). %% NB run tv/iv  etc %% delay decision 
%%              ** dont block xadverbial                        



ynq(P) --->  %% kommer jeg til å -> vil jeg 
    lexv(iv,come,_Tense,fin),
    subject(X,NP),
    [til],[å],
    !,
    statreal(P) \(xnp(X,NP),[vil]).
                                             

ynq(P) --->  %% Vet du hva billetten koster ? 
    lexv(rv,know,Tense,fin),
    subject(X,NP),
    negation0(_), %% rhet
    [hva],
    !,
    statreal(P) \(xnp(X,NP),w(verb(know,Tense,fin)),[hva]).


ynq(P) ---> 
    lexv(rv,Like,Tense,fin),
    subject(X,NP),
    infinitive,
    !,
    statreal(P) \ %% not infinitive  because of look_ahead later
       (xnp(X,NP),w(verb(Like,Tense,fin)),[å]).

                                                   %% evt redundantly
 
ynq(P) --->  %% kjenner du til bussavganger
    w(verb(Know,Pres,fin)),      %% nå
    {\+ testmember(Know,[be,have])}, %%  er du = er du redundantly
    not_look_ahead([det]), %% tar  (det lang tid) * 
    not_look_ahead(w(adj2(_,_))), %% tidlig adv+adj 
    adverb0(Jo,_,_), %% [] -> redundantly
    subject(A,BC),
    reflexiv0(Know), 
    negation0(_),  
    rep_particlev0(Know), %% if any, e.g (kjenne) til
    !,
    statreal(P) - (xnp(A,BC),w(verb(Know,Pres,fin)),w(adv(Jo))). %% svarer du ikke ...
                                                    %% evt redundantly
 

%% Special  rekker jeg å ta bussen
ynq(P) --->   
    w(verb(reach,pres,fin)), %% ønsker(?),nekter(?)
    np1_accept(A, B::C), 
    infinitive,        
    !,accept, 
    adverbx0,                   
    negation0(_), %% Rhetorical 
    statreal1(P) \ noun_phrase1(A, B::C), 
    !,accept.


ynq(_) ---> 
    not_look_ahead(w(verb(go,_,fin))), %% repair of repair / er går det
    be,!,reject. %% -> isq    


ynq(P) ---> 
    w(verb(V,pres,pass)), % vaskes  ( Passive (Norwagism))
    !,
    thereit0,
    isq(P)  -   (w(verb(be,pres,fin)),
               % bussene
               w(verb(V,past,part))).

ynq(_) ---> %% ønsker = jeg ønsker !
    w(verb(want,pres,fin)),
    not_look_ahead([du]),  
    not_look_ahead([jeg]),  %% trenger jeg
    !,reject.  


ynq(P) --->  
    w(verb(go,_,fin)),  %% Norwagism  Går det an å 
    thereit,
    negation0(_), %% Rhetoric

    anaa, %% TA-110331
%%    ann0, %% [an],  hazard?
%%    infinitive,
    !,
    statement(P) \ someone.

ynq(P) ---> %% regner det ???
    lexv(iv,Rain,Pres,fin),
    [det],
    {testmember(Rain,[rain,snow])}, 
    !,
    statement(P) \  ([det], w(verb(Rain,Pres,fin))).  


ynq(P) --->  %% (når) går det fra nth til risvollan ? 
    w(verb(Go,Pres,fin)),
    [det],
    look_ahead(w(prep(_Prep))),
    not_look_ahead([e]), %% e = en|etter
    !,
    statement(P) \ 
      (w(noun(vehicle,plu,u,n)), 
       w(verb(Go,Pres,fin))).
 
ynq(P) --->  %% går det en buss
    w(verb(Go,Pres,fin)),
    {\+ rv_templ(Go,_)},  %% Skjønner det.
    negation0(_),    % Rhetorical 
    thereit(_Ikke),
    !,
    statement(P) \  ([det], w(verb(Go,Pres,fin))).
    % det koster



ynq(P) --->  %% snakker du engelsk /jobber det kvinner
%%     not_look_ahead([når]), %%  når neste rosenborg skole til samfundet?
    w(verb(Speak,Pres,fin)),      %% nå
    not_look_ahead(w(verb,_,_)) , %% er (jeg på nth)* 
    not_look_ahead([det]), 
%%     thereit0,           %% Forstår det. 
    saa0,  
    {Speak \== have}, %% -> hasq
    negation0(_N),
    !,
    statreal(P) - w(verb(Speak,Pres,fin)). %% svarer du ikke ... 
%%     not / because whenq stacks adverbial which is needed i  statreal 


%% HVOR HAR BUSS 5 HOLDEPLASS // accidentally adequate 

%%  NB Fails on  ... har buss 6 gått ..., but ok

ynq(P) --->  %% har buss 5 til dragvoll = går (SMS feiltasting)
    {value(smsflag,true)},       %% very irregular 
    w(verb(have,pres,fin)),      %% har
    look_ahead_bus, 

    !,
    statreal(P) - w(verb(go,pres,fin)). %% går


ynq(P) --->  %% passerer det nå en buss fiolsvingen ? 
    not_look_ahead([vil]), %% skulle gjerne vært 
    lexv(iv,Stop,Tense,fin), %%  iv for efficiency  %% Unnnec
    {\+ rv_templ(Stop,_)}, %% Forstår det 
    saa0, 
    { Tense \== imp},                         %% not command here !
    anyadverb0,
    !,
    statreal1(P)/ (lexv(iv,Stop,Tense,fin)). 


%% end ynq


look_ahead_bus ---> look_ahead(w(noun(Bus,_,_,n))),
    {testmember(Bus,[bus,nightbus,number])}.  %% 
look_ahead_bus ---> look_ahead(w(adj2(next,nil))).

% 

%%¤ PPQ( W P)

ppq(WhichX:::P) --->     %% Fra hvilket sted  selges månedskort
    prep(Prep),
    whx_phrase(X,WhichX, Q1::Q), 
    w(verb(Sell,pres,pass)),
    !,
    noun_phrase1(N1, N2::N3),
    !,accept,   
    adverbial1(AA,BB, CC::DD) =  (prep(Prep),noun_phrase1(X, Q1::Q)),
    statreal(P) 
        \ ( someone, 
            w(verb(Sell,pres,fin)),
            noun_phrase1(N1, N2::N3),
            adverbial1(AA,BB, CC::DD)).

ppq(WhichX:::P) ---> %% fra hvilket sted  fra = after/from ??? 
    prepnof(After),    % 'til' = to , (not 'of') 
    whx_phrase(X,WhichX, Q1::Q), 
    {adjustprep(X,After,From)}, %%% Bloody hack 
    !,  % <--- !!!  
    forwq(P,From,X,Q1::Q), % not kan !!! 
    optionalprep(From),  %% hvor går bussen fra %% Hack
    !,accept.  % <--- !!! %% Wrong, but Necessary (TIME)


optionalprep(in) ---> prep1(_),!,accept. %% in stems from whereq
optionalprep(_)  ---> [].         %% 


% går 3 neste busser *         ( 3 = bus 3) 
% til hvilken stasjon går 5 *  ( til = of)  



forwq(P,Prep,X,Q1::Q) ---> %% HVOR ER = be1
    lexv(_,be1,_,fin),    %% Special case 
    !,
    thereit0, 
    statreal(P)                %% (hvor er) hovedterminalen
        - ( w(verb(be1,pres,fin)),   %%  <- ! - // was be 
            adverbial1(Prep,X, Q1::Q)).



forwq(P,Prep,X,Q1::Q) ---> %% before verb: kan,skal,vil er also "verbs"
    (doit),  
    !, 
    statreal(P)
        -  adverbial1(Prep,X, Q1::Q).


forwq(P,Prep,X,Q1::Q) --->
    w(verb(Go,A,B)), %%   lexv(_,Go,A,B), may yeld be2 
    {Go \== understand},  %% kan   (= understand ) Norwagism 
    thereit0,   
    statreal(P)                %% .. goes a bus from X which ...
        - ( w(verb(Go,A,B)),  %% Rats and Mice
            adverbial1(Prep,X, Q1::Q)).


%%¤  WHICHQ 


whichq(WhichX:::(P and Q)) ---> 
    whx_phrase(X,WhichX, true::P), 
    w(verb(recommend,T,pass)), %% anbefales det (å ta)
    det0,
    infinitive,
    w(verb(Take,inf,_)),
    !,accept,
    statreal(Q)\
       ([noen], w(verb(recommend,T,fin)),
        [å],  w(verb(Take,inf,_)),npgap(X)).
         %% low stack level                                

whichq(WhichY:::P and Q) --->  %% Hvilken ting må gjøres
     whx_phrase(Y,WhichY,true::P),   
     paux0,  
     w(verb(Do1,Pres,pass)),
     whodidit(X,BC), 
     !,
     statreal(Q) \ 
        (xnp(X, BC), w(verb(Do1,Pres,fin)), npgap(Y)).

%%% realcomp(        S,event/real/S::P,P ) ---> [].  %% MEMO
%%  realcomp(S,ERQ,Q), 
%%    qverb_phrase(X,id, S,ERQ). 


whichq(WhichX:::P) ---> 
    whx_phrase(X,WhichX, Q2::P), 
%%%%%%%%%%%%%%%    !,       %%        hvilke plasser ( seter/steder ???) *
    realcomp(S,ERQ,Q1), 
    qverb_phrase(X,N, S, ERQ), 
    {negate(N,Q1,Q2)}.

%%%¤  WHX_PHRASE (X,WhichX, SEM) 


whx_phrase(X,WhichX, VP::P) ---> %% hvilke () går
    {value(busflag,true)}, 
    whichf(X,WhichX), 
    look_ahead(w(verb(Go,_,fin))), %% 
    {testmember(Go,[go,pass,leave,depart,arrive])}, 
    !,
    noun_phrase1(X, VP::P)  =  (w(noun(vehicle,plu,u,n))),
    !,accept. 


whx_phrase(X,WhichX, VP::P) ---> %% hvilke andre busser enn buss 5 ...
    whichf(X,WhichX), 
    oter,
    w(noun(Bus,PL,u,n)),
    enn, %% [enn], 
    !,
    noun_phrase1(X, VP::P)  \  ( %% the(X),  try without
            w(noun(Bus,PL,u,n)),[ulik]).


whx_phrase(X,which(X), VP::P) ---> %% hvordan farge har bussen
    hvordan, %% hva ..
    not_look_ahead(w(verb(_Request,pres,fin))), %% ønsker
    w(noun(Colour,_,_,_)), % "går" is no longer noun 
    {Colour \== type},     % hvordan type = hvilken
    !,
    noun_phrase1(X, VP::P)  \  (%% the(X), try without 
           w(noun(Colour,sin,u,n))).

whx_phrase(X,which(X), VP::P) ---> %% hva buss
    [hva],
    not_look_ahead(w(verb(_Use,_,_))), %% NB bruker  %% TA-101004
    look_ahead(w(noun(A,_,_,_))), 
    {A \== type},     % hva  type = hvilken
    !,
    noun_phrase1(X, VP::P). 


whx_phrase(X,WhichX, VP::P) ---> %% which subject
    whichf(X,WhichX), 
    type0,                       %% typer 
    noun_phrase1(X, VP::P) , %%   \  the(X), unnec ?
    !,accept.  

whx_phrase(X,WhichX, VP::P) ---> %% hvilke 2 busser går
    whichf(X,WhichX), 
    w(nb(N,num)),
    !,
    noun_phrase1(X, VP::P)  \ ( w(nb(N,num))), 
    !,accept. 


%%¤ WHICHF (XT,which(XT))

whichf(XT,which(XT)) ---> which2. 

%%¤ WHICHG (Noun,Pred, Pex) %% TA-100908

whichg00(Noun,P,  X:Noun, which(X):::X isa Noun and P) ---> [].


%% Which-query with Main statement wording

qstatement(X,WhichX:::Q) --->
    {which_thing(X,WhichX)},        
    statreal(Q).



%% 

what_phrase(X:thing,which(X:thing),  X isa thing  ) ---> %% hva = hvilke ting
    [hva].    


%%%%%¤¤  WHATQ      QUESTIONS

whatq(WhichZQ) ---> %% hva bruker vi TVen til %% TA-101004
    [hva],
    w(verb(use,T,fin)), %% bruker
    subject(X,SNP),
    np1_accept(Y, YNP),
    prep1(To),
    not_look_ahead_np,
    !,accept,
    qstatement(Z,WhichZQ)\
       (xnp(X,SNP), w(verb(use,T,fin)), np(Y,YNP),
        w(prep(To)),npgap(Z)). 


%% WHAT  IS (MEANS) %% Fronted hva betyr gud =hva mener gud ?


whatq(which(X)::: Man ako X) --->   %%  Hva er en mann -> meaning
     {\+ value(dialog,1)}, 
     whatbemean, 
     art1,          %% * hva er bilettpriser
     w(noun(Man,_,u,n)), %% \+ hva er mannen (...  sterk...)
     endofline,
     !.

whatq(which(X):::Man ako X) --->   %% hva er buss -> buss liste
     {\+ value(dialog,1)}, 
     whatbemean, 
          %% hva er bilettpriser
     w(noun(Man,_,u,n)), 
    {\+ testmember(Man, 
          [clock,special_ticket,price,bus,station])}, %% <-- etc where a concise  question exists
     endofline.


whatq(D) ---> 
    {\+ value(dialog,1)}, 
     whatbemean,  %%  hva er/betyr  
     look_ahead(w(name(_Tuc,_,_))),
     redundant0, %% hva er du da 

     !, %%% <--- !!!!!
     command(D) \ w(verb(describe,imp,fin)).
               

/**
whatq(D) --->
    {\+ value(dialog,1)}, 
     whatbemean,  %%  hva er/betyr  
     specific_phrase(A, NP),     
     redundant0, %% hva er du da 
     endofline,
     !, %%% <--- !!!!!
     command(D) \ ( w(verb(describe,imp,fin)), 
                     xnp(A,NP)).             
				            %% hidden for look_ahead np
**/


%%  hva hadde du  ventet at  kunne gjøres.  // special

whatq(which(Y:thing):::P) ---> %% hva holder|deiver du på med 
    [hva],
    lexv(tv,Hold,_,fin), gmem(Hold,[hold,keep,drive,operate]),
    subject(X,NP),
    particlev2(Hold,Do1),  %% på med
    statreal(P) \ 
          (xnp(X,NP),w(verb(Do1,pres,fin)),npgap(Y:thing)).


whatq(WhichX:::P) ---> 
    {which_thing(X,WhichX)},      
    [hva],                      % hva
    has,                        % har
    subject(A, SNP),            % du
    w(verb(expect,past,part)),
    optional([at]),
    [kunne],
    w(verb(Do1,_,pass)),
    !,
    statreal(P)  \  
        ( xnp(A, SNP),
          w(verb(expect,past,fin)),
          [at],
          [noen],
           w(verb(Do1,pres,fin)),
           npgap(X)).


whatq(WhichY:::  P and Q) ---> %% hva må gjøres 
     what_phrase(Y,WhichY,P),  
     paux0,  
     w(verb(Do1,Pres,pass)),
     whodidit(X,BC), 
     !,
     statreal(Q) \ 
        (xnp(X, BC), w(verb(Do1,Pres,fin)), npgap(Y)).



whatq(WhichU:::  P and Q) ---> %% hva vet du at du vil gjøre 
    what_phrase(UT,WhichU,P),  
    lexv(rv,Know,_,fin), {\+ testmember(Know,[])}, %% ad hoc
    subject(Y,NPY),
    that0(Know,that), %% [at], hva tror du jeg heter
    subject(Z,NPZ),
    !,
    negation0(_),  
    []-npgap(UT),         %% free
    statreal(Q) \ 
              (xnp(Y,NPY),
               w(verb(Know,pres,fin)),
               [at],
               xnp(Z,NPZ)). %% first


whatq(WhichY:::Q and P) --->  %% hva er det (som) du gjør
    what_phrase(YT,WhichY,Q), %%     % hva 
    w(verb(be,_,fin)),
    [det],
    optional([som]),
    specific_phrase(X, NP),         % du
    !,
    statreal(P)-  
        (xnp(X, NP),npgap(YT)).


whatq(which(Y:thing):::P) ---> %% hva sier du til det ?
    [hva],
    lexv(rv,Speak,_,fin), %% rv !!!!
       look_ahead_subject,  %% subject is too expensive
       np0_accept(X,NP),  %% expensive
    negation0(_),   %% Rhetoric 
    prepnom(Prep),
    statreal(P) \  
          (xnp(X,NP),w(verb(Speak,pres,fin)),w(prep(Prep)),npgap(Y:thing)).


whatq(WhichY:::P and Q) ---> %% hva gjør du %% //hva betyr/mener
    what_phrase(YT,WhichY,P),
    lexv(tv,do,_,fin), 
    {\+ testmember(do,[cost,be2,have])}, 
    subject(XT,NP),
    not_look_ahead([at]), %% e.g. rv-sense
    not_look_ahead([å]),
    negation0(_),   %% Rhetoric 
    statreal(Q) \  
              (xnp(XT,NP),w(verb(do,pres,fin)),npgap(YT)).



%%% WHAT HAS  

whatq(WhichY:::P) ---> 
    {which_thing(Y,WhichY)},      
    [hva],                           % hva
    has,                             % har
    subject(X,XNP),         % du
    w(verb(Do1,past,part)), % gjort
    !,
    statreal(P)  \  
        ( xnp(X,XNP),
          w(verb(Do1,past,fin)), 
          npgap(Y)).


whatq(WhichX:::P) ---> %% hva har du informasjon om
    {which_thing(X,WhichX)},      
    [hva],                           % hva
    has,                             % har
    subject(A, BC),                  % du
    noun(Info,Num,U,Gen,Z,Infop),    % informasjon
    prepnom(Om),                     % om -> regarding, ikke om
    !,
    np1(Z,Q) =   
       ( noun(Info,Num,U,Gen,Z,Infop), w(prep(Om)),npgap(X)),   
    statreal(P)  \  
        ( xnp(A, BC),
          w(verb(have,pres,fin)), 
          xnp(Z,Q)).
  


%% WHAT COST QUESTIONS // hva koster/veier 


whatq(which(Y:thing):::P) ---> %% hvor mye koster det å ta bussen
    [hva],
    w(verb(V,_,fin)),
    {testmember(V,[cost])},
    [det],
    for0,  %% TA-110316
    [å],
    clausal_object1(COV,COST)\([noen],[vil]),     
    !,
    statreal1(P)  \ 
        (xnp(COV,COST),
         w(verb(V,pres,fin)),
         npgap(Y:thing)).      %% TA-110606
    
for0 ---> [for],!. %% TA-110316
for0 ---> [].      %%

whatq(WhichX:::P) ---> 
    [hva],
    w(verb(Cost,Tense,fin)), 
    {testmember(Cost,[cost,weigh])},  
    [det],
    look_ahead(w(prep(_))), % fra
    !,accept, %% 
    {which_thing(X,WhichX)},
    noun_phrase1(A, B::C)= w(noun(ticket,sin,u,n)),
    statreal(P)  \  
        ( noun_phrase1(A, B::C), %% 1
          lexv(tv,Cost,Tense,fin),
          npgap(X)).    


whatq(WhichX:::P and Q) ---> 
    what_phrase(XT,WhichX,P),  
    w(verb(Cost,Tense,fin)), 
       gmem(Cost,[cost,weigh]),  
    np1_accept(AT,NP),  %% en øl
    {\+ constrain(AT,place)}, %% Filthy hack,   toget = TS 
    !,
    statreal(Q)  \  
        ( xnp(AT, NP), 
          lexv(tv,Cost,Tense,fin),
          npgap(XT)).  


%% WHAT IS QUESTIONS 

whatq(WhichX:::P and Q) --->  %% Hva er det som skjer 
    what_phrase(X,WhichX, P), 
    realcomp(S,ERQ,Q), 
    qverb_phrase(X,id, S,ERQ). 

whatq(which(X:thing):::D) --->  %% hva er det du snakker om
     whatbe,  
     [det],
     not_look_ahead(w(adj2(_,nil))), %% det store spørsmålet
     subject(Y,NP),
     negation0(_),
     !,
     statement(D) -(xnp(Y,NP), npgap(X:thing)). %% xnp %% Experiment


whatq(P) ---> %% hva er ukjent %% Fronted for Test
     whatbe, 
     so0,           %%  <===  (Hvorfor er det så dyrt  å ta bussen)
     dent0,    
     not_look_ahead(w(nb(_,_))), %% fourth etc
     w(adj2(Poss,nil)),  
     {\+ testmember(Poss,[near,nearest,next])}, %% nærmeste hpl
     !,
     whichq(P)  \  
          (which,w(noun(thing,sin,u,n)),
           w(verb(be,pres,fin)), w(adj2(Poss,nil))). 


whatq(which(X):::P) ---> 
     whatbe,thereit,prep1(for), %% Norwagism
     !,
     noun_phrase1(X, true::P),  
     danow0. %% nå da 
                                      
whatq(which(Y):::Q) --->   %% hva er det [som] du kan gjøre 
     whatbe,           
     [det],                         
     [som], 
     !,accept, %% Hazard  if not som
     np(X,VP::P),  
     np(Y,YVP::YP)=w(noun(thing,sin,u,n)),
     statreal(Q) - 
        (np(X,VP::P),  
         np(Y,YVP::YP)).


whatq(which(X):::P) --->   %% hva er tid fra nth ( buss går kl (12 fra nth))
     whatbe,  
     w(noun(time,_,_,n)), 
     look_ahead(w(prep(_))), %% Ad Hoc Panic
     noun_phrase1(X, true::P) \    w(noun(departure,sin,u,n)),
     danow0,  
     !,accept.



whatq(WhichX:::D) --->  %% hva er det du vet
     {which_thing(X,WhichX)},    
     whatbe,  
     [det],
     not_look_ahead(w(adj2(_,nil))), %% det store spørsmålet
     noun_phrase1(A, B::C),
     negation0(_),
     !,
     statement(D) -(np(A,B::C), npgap(X)). %% [du]


whatq(which(Y:thing):::P) ---> %% hva er tagore -> which(X):   tagore is X
     whatbe,  
     not_look_ahead([det]),  
     not_look_ahead(w(name(_Tuc,n,_))), %% name => describe 
     np(X, NP),  %% allow telf and roomno of ...  
     danow0,
     endofline,
     !,
     statreal(P) =  
        (xnp(X,NP),   %% TA-101018
         w(verb(be,pres,fin)),
         npgap(Y:thing)).


whatq(which(X):::P) --->        
     whatbe,           
     not_look_ahead([det]),                               
     not_look_ahead(w(name(_Tuc,n,_))), %% name => describe
     np1_accept(X, true::P),    %% take the first 
     danow0.   


whatq(which(X:thing):::D) --->   
     whatbe,            
     noun_phrase1(A, NP), 
     w(verb(Write,past,part)), 
     prep(In),
     !,
     statement(D)  \  ( noun_phrase1(A, NP), 
              w(verb(be,pres,fin)),   %% not be 
              w(verb(Write,past,part)), w(prep(In)),npgap(X:thing)).



whatq(P) ---> %% Hvilken ting er (?)
    whatbe,
    whichq(P) \  
        (which,w(noun(thing,sin,u,n)),w(verb(be,pres,fin))).

%%%%%%% END WHAT IS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



whatq(WhichXQ) ---> %% hva vil  busstuc brukes til
    [hva],
    aux1,
    np1_accept(Y, VP::P),
    w(verb(use,T,pass)), %% brukes
    prep1(To),
    !,accept,
    qstatement(X,WhichXQ)\
       ([noen], w(verb(use,T,fin)), np(Y,VP::P),
        w(prep(To)),npgap(X)). 


whatq(WhichXQ) ---> %% hva brukes busstuc til
    [hva],
    w(verb(use,T,pass)), %% brukes
    np1_accept(Y, VP::P),
    prep1(To),
    !,accept,
    qstatement(X,WhichXQ)\
       ([noen], w(verb(use,T,fin)), np(Y,VP::P),
        w(prep(To)),npgap(X)). 



%% WHAT CAN QUESTIONS 

whatq( which(X:thing)  :::P) --->  %% hva kan du  hjelpe  med () ( Prepositional Gap)
    whatcan,
    subject(A,NP), 
    redundant0, %% egentlig 
    negation0(_), %% Ignore negation
    w(verb(V,Y,Z)),
    reflexiv0(V),              %% (hjelpe) meg    ad hoc 
    prepnom(U), %% om ==> regarding
 {  testmember(U,[regarding,with])}, %% gjøre for meg 
    !,
    statreal(P)  \   %%      hva kan du svare på 
        ( xnp(A,NP), %% noun_phrase1(A,NP), 
          w(verb(V,Y,Z)),
          w(prep(U)),npgap(X:thing)).  


whatq(WhichX:::P) ---> %% Hva kan du om busser %% Ad Hoc
    whatcan,
    {which_thing(X,WhichX)}, 
    specific_phrase(A, NP), 
    negation0(_), %% Ignore negation 
    [om],
    !,
    statreal(P)  \ 
        ( noun_phrase1(A, NP), 
          w(verb(know1,pres,fin)),
          npgap(X),
          [om]).  


whatq(WhichX:::P) --->  %% Hva kan du svare på
    whatcan,
    {which_thing(X,WhichX)}, 
    specific_phrase(A, B::C), 
    negation0(_), %% Ignore negation 
    w(verb(V,Y,Z)),  
    reflexiv0(V),   %% fortelle meg / avoid dtv 
    [OM], {testmember(OM,[på,om,til])},
    not_look_ahead(w(noun(_,_,_,_))), 
    !,
    statreal(P)  \   
        ( noun_phrase1(A, B::C), 
          w(verb(V,Y,Z)),
          npgap(X)).


whatq(WhichX:::P) --->   %% Hva kan du fortelle meg om busser
    whatcan,
    {which_thing(X,WhichX)}, 
    specific_phrase(A, B::C), 
    negation0(_), %% Ignore negation
    w(verb(V,Y,Z)),  
    reflexiv0(V),   %% fortelle meg / avoid dtv 
    [om], 
    noun_phrase1(D, NP), 
    !,
    statreal(P)  \   
        ( noun_phrase1(A, B::C), 
          w(verb(V,Y,Z)),
          npgap(X),
          w(prep(regarding)),
          np(D,NP) ).


whatq(WhichX:::P) --->  % hva kan jeg  bruke busstuc til 
    whatcan,
    {which_thing(X,WhichX)}, 
    specific_phrase(A, B::C), 
    negation0(_), %% Ignore negation
    lexv(tv,V,Y,Z),
    np1(D, E::F),
    prepnom(U), %% om ==> regarding
    !,
    statreal(P)  \   %%      hva kan du svare på 
        ( noun_phrase1(A, B::C), 
          w(verb(V,Y,Z)),
          np1(D, E::F), 
          w(prep(U)),npgap(X)).  

whatq(WhichX:::P) --->  % hva kan jeg  be deg om    ( Object gap)
    whatcan,
    specific_phrase(A, B::C), 
    negation0(_), %% Ignore negation 
    w(verb(V,Y,Z)),   
    noun_phrase1(D, E::F), %% deg 
    prepnom(U),          %% om
    !,
    {which_thing(X,WhichX)}, 
    statreal(P)  \   
        ( noun_phrase1(A, B::C), 
          w(verb(V,Y,Z)),
          npgap(X),
          w(prep(U)),   
          np(D,E::F)).  

whatq(WhichX:::P) ---> %% Hva kan du ? 
    whatcan,
    {which_thing(X,WhichX)}, 
    specific_phrase(A, B::C), 
    negation0(_), %% Ignore negation
    not_look_ahead(w(verb(_Gjøre_,_,_))), 
    !,
    statreal(P)  \   %%     hva kan du gjøre
        ( noun_phrase1(A, B::C), 
          w(verb(do1,pres,fin)), 
          npgap(X)).  



whatq(WhichX:::P) --->   % hva kan du gjøre
    whatcan, 
    {which_thing(X,WhichX)}, 
    specific_phrase(A, B::C), 
    negation0(_), %% Ignore negation 
    w(verb(V,Y,Z)),  
    reflexiv0(V),   %% fortelle meg / avoid dtv 
    !,
    statreal(P)  \   %%     hva kan du svare på 
        ( noun_phrase1(A, B::C), 
          w(verb(V,Y,Z)),
          npgap(X)).  


%%%% End WhatCan


whatq(WhichX:::P) ---> 
    [hva],
    {which_thing(X,WhichX)},
    w(verb(know,Tense,fin)), 
    specific_phrase(A, B::C), 
    !,
    statreal(P)  \  
        ( noun_phrase1(A, B::C), 
          lexv(tv,know1,Tense,fin),
          npgap(X)).                            % X is a free variable ! EXPERIMENT

whatq(P) --->
    [hva], 
    (doit), 
    whichq(P)  \  (which,w(noun(thing,sin,u,n)),(doit)). 


whatq(P) ---> %% * Hva skjer 
    [hva],
    lexv(iv,Happen,_,fin),%% bare opplagte subjekter
%%     {testmember(Happen,[happen])}, %% exists
    !,accept,
    negation0(_),   %% Rhetoric 
    whichq(P) \  
              (which,w(noun(thing,sin,u,n)),w(verb(Happen,pres,fin))).
                               

%%%%%%%%%%%%%%%%%%%%% 

%%%¤¤¤  WHENQ    When Questions


whenq(which(Y):::P) ---> %% Når er det  AT 
    when_adverbialq(In,Y, Subj::P3),
    be,
    [det],
    that0, %%% når er det første buss til nth ? # %% TA-110411
    !, 
    statreal(P) -  xadverbial1(In,Y, Subj::P3). %% stack syndrome %%
 

%% når buss -> buss // Haz?
whenq(which(Y):::P) ---> %% Når bussen går til nth
    when_adverbialq(In,Y, Subj::P3),
    look_ahead( w(noun(bus,_,_,n)) ),
    !,accept, 
    statreal(P) - 
                xadverbial1(In,Y, Subj::P3). 


whenq(which(Y):::P) ---> %% Når gå(r) fra 
    when_adverbialq(In,Y, Subj::P3),
    w(verb(go,PP,fin)),

    look_ahead(w(prep(From))),
    {testmember(From,[from,to])}, %% screen
    !, 
    statreal(P) -  %% stack syndrome 
     ( w(noun(bus,sin,u,n)), 
       w(verb(go,PP,fin)),
       xadverbial1(In,Y, Subj::P3)).  




whenq(which(Y):::P) ---> %% Når er det 
    when_adverbialq(In,Y, Subj::P3),
    be,

    detnexttime, %%  Rough "(det) (neste gang) (at)" 
                 %%        but not  " "
    np1(A, B::C),  %% første bussen
    !,accept,
    negation0(_), %% Rhetoric 
    whencomplex(A,B::C,In,Y,Subj::P3,P). 


 
%% Når fra  %% Short version
whenq(which(_):::_) ---> %% Når fra nth 
    when, %% pure q 
    look_ahead(w(prep(Prep))),
    {testmember(Prep,[from,to])},
    !,reject. %% Try something else



%% Double Pre Advp  
whenq(which(Y):::P) ---> %% Når i dag før kl 12 går bussen // AD HOC
    when, %% [når],  hvor tidlig 
    preadverbial1(A1,B1, C1::D1), % i dag  | etter 12 %%%%% 
    preadverbial1(A2,B2, C2::D2), % før 12 | fredag
    !,accept,
    adverbial1(_,Y, Subj::P3)  \                       %% =
            (prep(in), %%   the(Y),
             w(noun(time,sin,u,n))), 
    !,accept,  
    question0(P) / 
            (adverbial1(in,Y, Subj::P3), 
             adverbial1(A1,B1, C1::D1),
             adverbial1(A2,B2, C2::D2)).


whenq(which(Y):::P) ---> %% Når på lørdag går bussen ??? 
    when, %% [når],  hvor tidlig 
    not_look_ahead([e]), %% er/etter
    adverbial1(AA,BB, CC::DD), % i dag
    !,accept,  
    adverbial1(_,Y, Subj::P3)  \                       %% =
            (prep(in), w(noun(time,sin,u,n))), 
    !,accept,  

    question0(P) / 
            (xadverbial1(in,Y, Subj::P3),  
             xadverbial1(AA,BB, CC::DD)).



whenq(which(Y):::P) ---> %% Når i dag går bussen ??? 
    when, %% [når],  hvor tidlig 
    adverb(AA,BB,pre), % idag 
    !,
    adverbial1(_,Y, Subj::P3)  = 
            (prep(in), w(noun(time,sin,u,n))), 
    !,   
    question0(P) - 
            (xadverbial1(in,Y, Subj::P3), xadverb(AA,BB)).


whenq(which(Y):::P) ---> % når er det mulig å 
    howlongto(In,Y, Subj::P3),
    w(adj2(Poss,nil)),
    {testmember(Poss,[easy,possible,good])}, 
    infinitive,
    w(verb(V,inf,fin)),
    !,                %% Don't waste time
    statement(P)  / (someone,
                    w(verb(V,pres,fin)),
                     adverbial1(In,Y, Subj::P3)).


whenq(which(Y):::P) ---> % når er det AT  ( ... det går buss )
    howlongto(In,Y, Subj::P3),
%    [det], howlongto eats it 
    w(verb(V,_,fin)),
    !,                %% Don't waste time
    statement(P)  / (w(verb(V,pres,fin)),
                     adverbial1(In,Y, Subj::P3)).


% når er (det) neste buss til nth ? 
% når er neste avgang (=) buss 5  %% NB


whenq(which(Y):::P) ---> 
    when_adverbialq(In,Y, Subj::P3),
    !,   %%  når går  
    question0(P) - 
            xadverbial1(In,Y, Subj::P3), 
    
    not_look_ahead([a]), %% 5 a \= 5 av 
    prep0(_HOC).  %% ad hoc,   % Når gjelder bussrutene fra 
                               % Når passerer bussen  åsveien til (*)

% .............

% "(det) (neste gang) (at)"  but not "" 
                                   

detnexttime ---> [det],nexttime0,that0,!.
detnexttime ---> nexttime,that0,!.
detnexttime ---> [at],!.

nexttime0 ---> nexttime.
nexttime0 ---> [].

nexttime ---> w(adj2(next,nil)), optional([gang]). %% Haz?



whencomplex(A,B::C,In,Y,Subj::P3,P) ---> %% når er det første buss går .
    do0,   
    w(verb(Go,_,finy)),
    !,accept,
    statreal(P) - (np(A,B::C), %% stack syndrome 
               w(verb(Go,pres,fin)),adverbial1(In,Y, Subj::P3)).

whencomplex(A,B::C,In,Y,Subj::P3,P) ---> %% når er det første buss .
    statreal(P) -  
        (np(A,B::C),  %% stack syndrome 
         w(verb(be,pres,fin)), %% exist
         adverbial1(In,Y, Subj::P3)).

%%% 

% når er det .............. går   // Garden path
 
verb0(V)  ---> w(verb(V,_,_)),!,accept.
verb0(be1) ---> [].


%%%¤  WHEREQ (WH:::P)


%% Caveat
%% hvor finner jeg bussen =
%% et sted finner jeg bussen =
%% jeg finner et sted *

/** %% TA-110510

%%% *** hvor stopper buss 6 mellom samfundet og vestre rosten. 
        %% hvor henter du informasjonen (fra) %% TA-110121
whereq(which(Z):::P) ---> %% hvor tar jeg  bussen (fra) . * 
    {\+ value(dialog,1)},
    where_adverbial(_nil,Z,WAdv), %% hvor
 
    subjectverb(S,SNP,Take),  gmem(Take,[take,fetch]),

    !,
    np0_accept(O,ONP), %% bussen 

    prep0(From), %% (fra)    fra|til ... in
    [] -  adverbial1(From,Z,WAdv), %% fra sted

    substatement1(P) \ 
       (xnp(S,SNP),
        w(verb(Take,pres,fin)),
        xnp(O,ONP)). 
*/

subjectverb(S,SNP,Take) ---> % tar jeg %% TA-110121
                              % bør jeg kunne ta ...
     w(verb(Take,_,fin)),
     subject(S,SNP),
     !.

subjectverb(S,SNP,Take) ---> % bør jeg (kunne) ta ... %% TA-110121
     aux1, %% ad hoc
     subject(S,SNP),
     w(verb(Take,inf,fin)).

            %%   hvor drar rute 2 til på lørdag
whereq(which(Z):::P) ---> % prepositional complement  //NB NOMINAL WH
    dummyprep0,          %% til hvilke S går B fra 
    where_adverbial(Prep,Z,WAdv),
    w(verb(Find,Pres,fin)),
    thereit0, 
    not_look_ahead(w(nb(_,_))),  %% * hvor går 411=hvor går klokken
    subject(X,NP),
    !,accept,
    dummyprep0, %% hvor får bussen (fra) Haz ???
    !,accept,
    [] -  adverbial1(Prep,Z,WAdv),

    substatement1(P) \ 

      ( xnp(X,NP),    w(verb(Find,Pres,fin)) ),
 
    !,accept.



whereq(which(Y):::P) ---> %% hvor går bussen // fra 
    {\+ value(dialog,1)},
    where,
    w(verb(go,_,fin)), 
    !,
    adverbial1(nil,Y, Subj::P3) = (%% the(Y),
                                   w(noun(place,sin,u,n))), 
    !,
    ynq(P) - (w(verb(go,pres,fin)), adverbial1(nil,Y, Subj::P3) ),
    dummyprep0. %% Rough




whereq(which(Y):::P) ---> %% Hvor  i midtbyen går bussen ??? 
    where, 
    not_look_ahead(w(prep(after))), %% e = etter/ er // Kor e = hvor etter/er 
    adverbial1(AA,BB, CC::DD), % i midtbyen
    !,
    adverbial1(_,Y, Subj::P3) = (prep(in), %% the(Y),
                                w(noun(place,sin,u,n))), 
    !,   
    question0(P) - 
            (adverbial1(in,Y, Subj::P3), adverbial1(AA,BB, CC::DD)).




whereq(which(Y):::P) ---> %% Hvor er det   mulig å 
    where_adverbial(In,Y, Subj::P3),
    be,
    [det],
    w(adj2(Poss,Nil)), %% lettest %% TA-110510
    !, 
    [] - adverbial1(In,Y, Subj::P3),
    substatement1(P) \  ([det],be,  w(adj2(Poss,Nil))).


whereq(which(Y):::P) ---> %% Hvor er det    AT 
    where_adverbial(In,Y, Subj::P3),
    be,
    [det],
    that0, 
    !, 
    statreal(P) - adverbial1(In,Y, Subj::P3). %% stack syndrome 

whereq(P) --->  %%  hvor er du fra
    where,
    be,
    ppq(P) \ (prep(in),which,w(noun(place,sin,u,n)),w(verb(be1,pres,fin))). 
                                                           %% lie1 %%

 
whereq(which(_Y):::_P) ---> 
    where,
    many1,
    !,reject. %% hvor mange, not try



whereq(P) --->   %% hvor får jeg ta buss %% TA-100902
    where,
    aux1,         %% NB ikke får %% hvor får jeg buss
    ppq(P) \ (prep(in),which,w(noun(place,sin,u,n)),(doit)).


whereq(WP) ---> % object %% moved after pp
    where,
    look_ahead_vp, %% not hvor lenge 
    whichq(WP) \ (which,w(noun(place,sin,u,n))).

%%%

when_adverbial(in,T, P::Q) ---> %%   Hvilket år ble du født
    which,
    np1(T, P::Q),
    !,
    {testconstraint(T,time)}. %% not which thing !!


%%¤ WHEN_ADVERBIALQ 

when_adverbialq(in,T:time, P::(T isa time and P)) ---> %% pure q
    when. %%  når  jeg ==> når verb!!

when_adverbial(in,T:time, P::(T isa time and P)) ---> 
    whenx. %%  når  jeg ==> når verb!!

%%%%

%% nil also acts as an adverbial

%%%¤ WHERE_ADVERBIAL 

where_adverbial(nil,XT, PQ) ---> %%  hvilket sted drar rute  2 (til) på lørdag.
    which,
    np1(XT, PQ),
    !,
    {testconstraint(XT,place)}. 


where_adverbial(nil,XT, PQ) --->
    [hvor], 
    np00(place,XT,PQ), %% synt a place
    !.


%


dummyprep0  ---> dummyprep,!.
dummyprep0  ---> [].

dummyprep  ---> prep1(from),!,accept.
dummyprep  ---> prep1(to),!,accept.


wherefromq(P) ---> 
    wherefrom,  
    !,
    ppq(P)  \  
            (prep(from),which,w(noun(place,sin,u,n))). 

%%%¤ WHOQ 


whoq(P) --->   %% hvem laget deg  lag=make|team
     who, 
     look_ahead(w(noun(_Team,sin,def,n))), %% laget (RBK)
     w(verb(Make,Pres,fin)),
     !,
     whichq(P) \ 
            (which,w(noun(agent,sin,u,n)), w(verb(Make,Pres,fin))).


whoq(P) --->   
     who, 
     whichq(P) \ 
            (which,w(noun(agent,sin,u,n))). 
 
whoseq(P) --->   % whose dog barked ?    
    whose,
    noun(Noun,Num,u,n, Y, R),
    whoq(P) \ 
            (who,w(verb(have,pres,fin)),a,noun(Noun,Num,u,n, Y, R),that). 


%% WHYQ 

whyq(explain:::P) ---> 
    hvorfor,
    isq(P).

whyq(explain:::P) ---> 
    hvorfor,
    ynq(P).

whyq(explain:::P) ---> 
    hvorfor,
    hasq(P). 



%% HOWQ 

howq(doit:::reply('OK')) --->   %% hvordan går det 
    [hvordan],
    w(verb(go,_,fin)),
    [det],   
    !,
    skip_rest.  %% TA-110104 .. på jobben

howq(explain:::P) --->   %% NB skal = go %% After ynq
    [hvordan], 
    erdetaa0,   
    w(verb(Go,inf,fin)),   %%      %% komme/ta  
    mex0,                  %%     (seg/meg)
    !,    
    statreal1(P) \ ([jeg], w(verb(Go,pres,fin))).  


howq(explain:::P) --->   %% NB skal = go %% After ynq
    [hvorfor],
    w(verb(Go,inf,fin)),   %%  Hvorfor velge buss 
    !,    
    statreal1(P) \ ([jeg], w(verb(Go,pres,fin))).  


howq(explain:::P) ---> %% hvordan er bussen %% Experiment 
    [hvordan],
    look_ahead(w(verb(be,_,fin))),
 
    []-xadverbial1(how,nil, Q::Q),
    isq(P).


howq(explain:::P) --->  % Hvorfor er en buss rød ?
    how, %% [hvorfor]  % hvordan er Anna opptatt 
    be,
    np1_accept(A, NP), %% not np1 because of quant_pron etc.
    substatement1(P) \ (xnp(A,NP),w(verb(be,pres,fin))).


howq(explain:::P) ---> %% hvorfor er det ikke mulig at
    how,              %% hvordan 
    be,
    [det],
    negation0(_), %% ignore /rhetoric 
    !,
    substatement1(P) \ ([det],w(verb(be,pres,fin))). 

howq(explain:::P) --->
    lexv(iv,tell,imp,fin),      
    me0,
    how,
    !,
    statreal1(P).


howq(P) ---> %% hvorfor er det så få avganger
    how, %% [hvorfor],% hvordan er det mulig
    be,
    thereit,    %% hvorfor er du *
    !,
    whatq(P) \ whatbe.

howq(P) ---> %%  Hvordan er det med deg ? ( OK?)
    how,
    be,
    [det],prep1(with), 
    !,
    whatq(P) \ whatbe.



howq(explain:::P) ---> 
    how,
    ynq(P).

howq(explain:::P) ---> 
    how,
    hasq(P). 

erdetaa0 ---> be,[det],[å],!,accept.
erdetaa0 ---> [].

% % % % % % % % % % % % % % % % % % % % % %

%%%¤¤ ISITLONGTO (Prep, Y, SUBJ)



% hvor lenge er det til bussen går.%% NB NOT hvor lenge er det til jul
% NB  som info hvor lenge \= når necessary for application

howlongto(In,Y, Subj::P3) --->
     be,[det],[lenge],prep1(to),

        when_adverbial(In,Y, Subj::P3) = [når].
            

howlongto(In,Y, Subj::P3) --->
     [hvor],[lenge],be,[det],prep1(to),

        when_adverbial(In,Y, Subj::P3) = [når].


howlongto(In,Y, Subj::P3) --->
    when_adverbial(In,Y, Subj::P3),
    be,
    thereit,
    that0.




%%¤ HOWADJQ (P)

%%%%%%% FRONTEST
 
howadjq(P) ---> % hvor langt er det fra Trondheim til Alta %% TA-110225
    hvor,     
    howadj1(Noun), % hvor lang tid 
    {testmember(Noun,[duration])}, 
    w(verb(Bet,Pres,fin)), 
     {testmember(Bet,[take,be])}, 
    [det],  %% not thereit_not_pronoun
    not_look_ahead([å]), %% TA-110530 (-> qverb_phrase)
    redundant0, %% "normalt"
    not_look_ahead(w(prep(with))), %%
     whichq(P)  \  (which,w(noun(Noun,sin,u,n)),w(verb(Bet,Pres,fin))),
    !,accept.   


  
howadjq(P) ---> % moved forw
    hvor,  
    howadj1(FREQ), % often -> frequency 
    docan,    %% e.g. kan (= know) NOT få !!!
    {testmember(FREQ,
          [frequency,speed,lateness,earliness,duration,distance])},
    !,     %%  <----    !!!!!
    ppq(P)  \  (prep(with),which,w(noun(FREQ,sin,u,n)),(doit)). %% iv


howadjq(P) ---> 
    hvor, 
    howadj1(FREQ), % often -> frequency 
    {testmember(FREQ,[frequency,earliness,lateness])}, %% PP gap 
    w(verb(V,_,Pas)),        % gå/gikk/gå  passes // not kan = know 
    {\+ V=be}, 
     !,     %%  <----    !!!!!
    ppq(P)  \  (prep(with),which,w(noun(FREQ,sin,u,n)), 
              w(verb(V,pres,Pas))).


howadjq(P) ---> % hvor gammel/lang    er %% TA-100908
    hvor, 
    howadj1(Noun),            %%  hvor lenge/ er det fra nth til lade
       gmem(Noun,[distance]), %%  LANG  
    be, %% TA-100909
    whichq(P)  \
    (which,w(noun(Noun,sin,u,n)),w(verb(have,pres,fin))). %%% has).
    % => hvilken  alder har

howadjq(which(T:time):::T isa time and P) ---> % hvor lenge er det til påske|bussen går
    hvor,                      %% TA-100905
    howadj1(duration), % hvor lang tid 
    w(verb(be,Pres,fin)), %% 
    [det],[til],
    clausal_object0(X,NP),
    !,
    np00(time,T:time,NPT), %% create a time object
 
    statreal(P) \ (xnp(X,NP),w(verb(exist,Pres,fin)),xadverbial1(nil,T,NPT)). %% 
    %% TA-100907
                 
%% whichg00(Noun,P,  X:Noun, which(X):::X isa Noun and P) ---> []. %% memo
                    

howadjq( WP) ---> % hvor lenge er bussruten gyldig
    
    whichg00(duration, P, Z,WP),

    hvor, 
    howadj1(duration), % hvor lang tid 
    w(verb(be,Pres,fin)), %% 
     
    np1_accept(X,NP), %% bussen

    w(adj2(Valid,nil)), %%

    !,
    np00(duration,Z,NPU), %% create a duration NP
 
    statreal(P) \ (xnp(X,NP),
                  w(verb(be,Pres,fin)), w(adj2(Valid,nil)),
                  xadverbial1(nil,Z,NPU)). %% nil
 
howadjq( WP) ---> % hvor lenge har du jobbet i AtB ?
    
    whichg00(duration, P, Z,WP),

    hvor, 
    howadj1(duration), % hvor lang tid 
    w(verb(have,_Pres,fin)),  
    subject(X,NP), %%
    w(verb(W,past,part)),
    !,
    np00(duration,Z,NPZ), %% create a duration
 
    statreal(P) \ (xnp(X,NP),
                   w(verb(W,past,fin)),
                   xadverbial1(nil,Z,NPZ)). %% nil
 
               
 
howadjq(which(T):::T isa Noun and P) ---> % hvor lenge har jeg overgang
    hvor, 
    howadj1(Noun), % hvor lang tid 
    w(verb(have,Pres,fin)), %% 
    subject(X,NPX), %%
    object(Y,NPY),
    !,
    {Z = (T:Noun)}, 
    np00(Noun,Z,NPZ), %% create a duration NP
 
    statreal(P) \ (xnp(X,NPX),
                   w(verb(have,Pres,fin)),
                   xnp(Y,NPY),
                   xadverbial1(nil,Z,NPZ)). %% nil                  

howadjq(which(T):::T isa Noun and P) ---> % hvor lenge venter bussen %% TA-100907
    hvor, 
    howadj1(duration), % hvor lang tid 
    w(verb(Wait,Pres,fin)), %% 
    {\+ testmember(Wait,[expect,be])}, %% TA-100908
    not_look_ahead([det]),
    np1(X,NP), %% bussen
    !,
    {Y = (T:duration)},
    np00(Noun,Y,NPY), %% create a duration
 
    statreal(P) \ (xnp(X,NP),
                  w(verb(Wait,Pres,fin)),
                  xnp(Y,NPY)). %% xadverbial1(nil,Y,NPY)). %% nil
                              %% bruker bussen  = object %% TA-100930


howadjq(P) ---> 
    [hvor],[lenge],w(verb(be,pres,fin)),[det],w(prep(to)),
    !,
    clausal_object0(XC,NP), %% bussen .. bussen går
    whenq(P) \ 
       ( [når],w(verb(be,pres,fin)),xnp(XC,NP)).


howadjq(P) ---> %% Hvor mange minutter er det til (bussen går) %% ad hoc
    [hvor],
    [mange],w(noun(minute,plu,u,n)),w(verb(be,pres,fin)),[det],w(prep(to)),
    !,
    whenq(P) - 
       ( [når],w(verb(be,pres,fin)),[det],[at]). %% ugly


howadjq(P) ---> 
    hvor,  
    howadj1(FREQ), % often -> frequency 
    [blir],       % passive
    np1(X,NP),
    w(verb(UPD,past,part)), %% 
    !,   
    ppq(P)  \
        (prep(with),which,w(noun(FREQ,sin,u,n)),w(verb(UPD,pres,pass)),xnp(X,NP)).


howadjq(P) ---> % hvor ofte er bussen forsinket 
    hvor,       %  hvilken frekvens er bussen forsinket med
    howadj1(Noun), 
        {testmember(Noun,[frequency])}, 
    be,  
    subject(X,NX),
    w(adj2(A,nil)), {testmember(A,[delayed,tooearly])},

    np00(frequency,Z,Q),  %% <-- NB

    statreal1(P)  \  
        (xnp(X,NX),w(verb(be,pres,fin)),w(adj2(A,nil)),
        w(prep(with)),xnp(Z,Q)).



howadjq(P) ---> % hvor gammel/lang    er

    hvor, 
    howadj1(Noun),                %% hvor lenge/ er det fra nth til lade
    {\+ testmember(Noun,[duration,distance,time])}, 
    be,  
    whichq(P)  \
    (which,w(noun(Noun,sin,u,n)),w(verb(have,pres,fin))). %%% has). 
    % => hvilken  alder har


howadjq(P) ---> % hvor lang tid vil X  bruke /Nominal Front 
    hvor, 
    howadj1(Noun), % hvor lang tid 
    (doit),
    np(A,NP),
    w(verb(Use,_,_)), %% bruke/brukt
    {testmember(Use,[use,take])}, %% not use2
     whichq(P)  \  (which,w(noun(Noun,sin,u,n)),w(verb(Use,inf,fin)),xnp(A,NP)),
    !,accept. %% <-- !!!




                                               
howadjq(which(Y):::P) ---> % hvor fort går bussen

    hvor, 
    howadj1(Noun),         % hvor fort/langt 
    {testmember(Noun,[speed,distance])},%% etc 
    w(verb(Go,pres,fin)), % går/gikk/gå
    {\+ testmember(Go,[know,be])}, 
    np1(X, NP),           % bussen
    !,
    statreal(P) \
        (xnp(X, NP),
         w(verb(Go,pres,fin)),
         w(prep(with)),
          the(Y),    %% THE
         w(noun(Noun,sin,u,n))),
    !,accept.



%% Fronted 
howadjq(P) ---> % hvor lenge .. er kontoret åpent /  er det fra nth til lade 
    hvor,        
    [lenge],
    be,    
    not_look_ahead([det]), 
    !,
    ppq(P) \ 
      (w(prep(with)),
       which,w(noun(duration,sin,u,n)),
       w(verb(be,pres,fin))).


howadjq(P) ---> % hvor mye tid/lang tid/  tar det med bussen 
    hvor,     
    howadj1(Noun), % hvor lang tid 
    {testmember(Noun,[duration])}, 
    w(verb(Take,pres,fin)), 
     {testmember(Take,[take,be])}, 
    [det],  %% not thereit_not_pronoun
    redundant0, %% "normalt"
    prep(with),    
    !,accept,
     whichq(P)  \  (which,w(noun(Noun,sin,u,n)),w(verb(Take,pres,fin))),
    !,accept.  



howadjq(P) ---> % hvor mye tid/lang tid/  tar det(kjøretøyet) fra
    hvor,       %                            
    howadj1(Noun), % hvor lang tid 
    {testmember(Noun,[duration])}, 
    w(verb(Take,pres,fin)), 
   {testmember(Take,[take])}, %% hvor lenge er det siden 1.3.
    [det],  %% not thereit_not_pronoun 
    not_look_ahead([å]), %% TA-110530
    redundant0, %% "normalt"
    look_ahead(w(prep(_))),
    !,accept,
    whichq(P)  \  (which,w(noun(Noun,sin,u,n)),w(verb(Take,pres,fin)), w(noun(vehicle,sin,def,n ))),
    !,accept. 



howadjq(P) ---> % hvor mye tid/lang tid/  tar det å
    hvor,                                           %% Before 
    howadj1(Noun), % hvor lang tid  
    {testmember(Noun,[duration])}, 
    w(verb(Take,pres,fin)), 
    [det],    
    not_look_ahead([å]), 
    {testmember(Take,[take,be])}, 
    redundant0, %% "normalt"
    whichq(P)  \  (which,w(noun(Noun,sin,u,n)),w(verb(exist,pres,fin)) ),
    !,accept. 



howadjq(P) ---> % hvor mye tid/lang tid/ bruker  %% Moved back 
    
    ihvor, %% TA-110511
    howadj1(Noun), % hvor lang tid 
    whichq(P)  \  (which,w(noun(Noun,sin,u,n))). 


% after   hvor lang tid 
howadjq(P) ---> % hvor lenge er kontoret åpent 
                  %% hvor lenge er det fra nth til lade 
    hvor,           %% moved back 
    [lenge],
    be,    
    !,
    ppq(P) \ (w(prep(with)),which,w(noun(duration,sin,u,n)),be).



howadjq(P) ---> 
    hvor,
    meny, %%  (sic)
    be,
    w(noun(clock,_,_,_)),
    %    !, %% <--- !!!  % hvor mange er klokka i Mongolia ?
    whatq(P)  \  ([hva],be,the,w(noun(clock,sin,def,n))). %% time too general (technical)
                                         
                   
howadjq(P) ---> % hvor lang tid eksisterer/har   %% adverbialt
    hvor,  
    [lenge],  %% howadj(duration), ikke lang
    w(verb(Exist,pres,fin)),
    {Exist \== take}, %% lenge tar det
    !,     %%  <----    !!!!!
    ppq(P)  \  (prep(with),which,w(noun(duration,sin,u,n)), w(verb(Exist,pres,fin))).


howadjq(P) ---> % hvor lang tid bruker ==> go with duration 
    hvor, 
    howadj1(duration), 
    w(verb(use,pres,fin)),        % bruker / TAKE ???
    !,     %%  <----    !!!!!
    ppq(P)  \  (prep(with),which,w(noun(duration,sin,u,n)),w(verb(go,pres,fin))).

howadjq(P) ---> % hvor lenge må jeg
    hvor, 
    howadj1(Noun), % hvor lang tid  
    (doit),
    ppq(P)  \  (prep(with),which,w(noun(Noun,sin,u,n)),(doit)),
    !,accept. %% <-- !!!

howadjq(P) --->  
    hvor,
    howadj1(duration), 
    betake,                %% be/take
    thereit,
%     !,     %%  <----    !!!!!
    whatq(P)  \  ([hva],w(verb(be,pres,fin)),w(noun(duration,sin,def,n))). 


howadjq(P) ---> % hvor lang tid tar bussen fra nth /// hvor lang tid tar det å
    hvor, 
    howadj1(duration), 
    w(verb(take,pres,fin)), 
    not_look_ahead([det]), %% TA-110530
    !,     %%  <----    !!!!!
    ppq(P)  \  (prep(with),which,w(noun(duration,sin,u,n)),w(verb(go,pres,fin))).



%%%%¤¤ HOWMUCHQ  %% How much questions

howmuchq(which(X):::P) ---> %% hvor lenge er det til =
    hvor,                   %% hvilken varighet eksisterer før
    [lenge],
    w(verb(be,Pres,fin)),
    [det],
    !,
    whichq(which(X):::P)  \  
        (which,w(noun(duration,plu,u,n)),w(verb(be,Pres,fin)),[det]).


howmuchq(which(Y):::P) ---> %% hvor mye koster det å ta bussen
    hvor,much,
    w(verb(V,_,fin)),
    {testmember(V,[cost])},
    [det],
    [å],
    clausal_object1(COV,COST)\([noen],[vil]),     
    !,
    statreal1(P)  \ 
        (xnp(COV,COST),
         w(verb(V,pres,fin)),
         npgap(Y)).

%% hvor mye er bussen forsinket -> er bussen forsinket
howmuchq(test:::P) ---> %% ad hoc 
    hvor,much,
    w(verb(be,_,fin)),
    np0_accept(X,NP),
    w(adj2(Delayed,nil)),
    !,accept,
    statemen1(real,P) \ (xnp(X,NP), w(verb(be,pres,fin)), w(adj2(Delayed,nil))).

 
howmuchq(P) ---> %% hvor mange er klokka ?
    hvor, 
    many1,
    look_ahead(w(verb(be,_,fin))),
    !,
    whatq(P)\ [hva].
 

howmuchq(howmany(X):::P) --->
    hvor, 
    many1, %% Strict Many, not mye  ==> Hvor mye tid \== Hvor mange ganger
    whichq(which(X):::P)  \  which .







% hvor mange jobber er slitsomme
% hvor mange jobber på tt

howmuchq(howmany(X):::P) --->  %% NB last
    hvor, 
    manypersons, % mange () 
    whichq(which(X):::P)  \  (which,w(noun(person,plu,u,n))).


howmuchq(howmany(X):::P) --->  %% er det mange som 
    be,[det], 
    manypersons, 
    [som],
    whichq(which(X):::P)  \  (which,w(noun(person,plu,u,n))).




howmuchq(which(Y):::P) ---> %% hvor mye koster bussen 
    hvor,much,
    w(verb(Earn,_,fin)),
    {testmember(Earn,[earn,cost])},
    whattrans(Earn,Y,P).



howmuchq(P) ---> 
    hvor, 
    much,of,
    !,            %% !!! <---
    whichq(P) \ (which,of).  


howmuchq(P) ---> % hvor mye tid/lang tid/ bruker 
    hvor, 
    much,
    w(noun(Noun,_,u,n)),     
    whichq(P)  \  (which,w(noun(Noun,sin,u,n))), 
    !,accept. %% <-- !!!


howmuchq(P) ---> %  hvor mye koster
    hvor,  
    much,
    question(P) \ [hva]. %% not hvilken

% % % % % % % % % % % % 



whattrans(Earn,Y,P) --->  
    not_look_ahead([det]), 
    noun_phrase1(X, Q::Q1),          
    !,
    statreal1(P)  \ 
        (noun_phrase1(X, Q::Q1),        
         w(verb(Earn,pres,fin)),
         npgap(Y)).


%%%¤ HOWADJ (noun)
%%%¤ HOWADJ1 (noun)

howadj1(C) ---> howadj(C),!. %% tired of backtracking 

howadj(duration)    ---> [langt]. 

howadj(age)    ---> w(adj2(old,nil)). 
howadj(age)    ---> [mange],w(noun(year,plu,u,n)). 

howadj(delay)  ---> w(adj2(slow,nil)).  
howadj(delay)  ---> optional(much),w(adj2(delayed,nil)).
howadj(delay)   ---> w(adj2(punctual,nil)). %% rough

howadj(earliness)  ---> w(adj2(early,nil)).  %% artificil
howadj(lateness)   ---> w(adj2(late,nil)).   %% artificil
howadj(lateness)   ---> [sent]. %% TA-100914

howadj(distance)   ---> [langt]. 
%% howadj(distance) ---> w(adj2(long,nil)). %% lang er bussen %% TA-101013
%% howadj(distance) ---> w(adj2(short,nil)). %% :-)
howadj(distance)    ---> many,w(noun(Mile,_,u,n)), %%   meter sin/plu
   {testmember(Mile,[mil,mile,kilometer,meter])}.


howadj(duration)   ---> [mange],w(noun(minute,_,_,n)).
howadj(duration)   ---> [lenge].
howadj(duration)   ---> long,w(noun(time,_,u,n)),!.
howadj(duration)   ---> much,w(noun(time,_,u,n)),!.
%% howadj(duration)   ---> long. %%  hvor lang er sommeren/ lengde uaktuelt?
howadj(duration)   ---> w(adj2(short,nil)). %% :-)

howadj(frequency)  ---> often.
howadj(frequency)  ---> [mange], w(noun(time_count,_,_,n)),inperiod0,!,accept.  

howadj(intelligence) ---> w(adj2(intelligent,nil)). 
howadj(intelligence) ---> w(adj2(stupid,_)).  %% Rhetorical
howadj(intelligence) ---> 
    w(adj2(_,nil)),           %% small/great ...
    w(noun(intelligence,sin,_,n)).


howadj(price) ---> w(adj2(expensive,nil)).
howadj(price) ---> w(adj2(cheap,nil)). 

howadj(size)  ---> great.             %% big 

howadj(length)  ---> w(adj2(long,nil)).      %% long  
howadj(length)  ---> w(adj2(short,nil)).     %%  :-)


howadj(speed) ---> [fort].           %%  ??? adverb
howadj(speed) ---> w(adj2(fast,_)).  %%  ??? adjective
howadj(speed) ---> w(adj2(slow,_)). 

howadj(temperature) ---> w(adj2(cold,nil)). 
howadj(temperature) ---> w(adj2(hot,nil)). 

howadj(weather) ---> w(adj2(hot,nil)).  %%  temperature
howadj(weather) ---> w(adj2(cold,nil)). %% 

howadj(weight) ---> w(adj2(heavy,nil)). 

% howmuch(thing)  ---> much. %%


%%   hvor lenge har postkontoret åpent ?
%% hvor lenge er  postkontoret åpent ?


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  V E R B  - P H R A S E    S E C T I O N
%
  
%%%¤ VP (X,N, S,Com::P)

vp(_X,_N, _S,_::true) --->  %% NP: pure NP, no pred
    [':'],
    end_of_line,
    !.

vp(X,N,  S,ComP)  ---> 
     verb_phrase(X,N,  S,ComP) .
 


%% EXPERIMENT    at jeg i dag sender et brev


% Com is an inherited attribute that shall be under 
% the scope of exists(S)::

% Make identical event variable 

% I depart  and do not arrive  *

%%¤ VERB_PHRASE   (X,N,  S,ComP) 

/* everything exists except for syn/sem errors %% TA-101006
verb_phrase(X,N,  S,Com::P1) --->  %% før siste buss [går]
    look_ahead_endofline, %% TA-101006
%%%%%%%%%%%%%%    missingo,
    {value(busflag,true)},
    {\+ value(dialog,1)},   %% (Probably ellipsis)
    constrainvehdep(X),
    !,accept,
    verb_phrase1(exist,X,N, S,Com::P1)\w(verb(exist,pres,fin)), %% exist more     neutral
    !.
*/

%%%    første buss 43 fra ringvål til kvenild etter kl 2015

verb_phrase(X, N, S,VP) --->      %% jeg vil vite om haugesund ("eksisterer")

    endofline, %%% look_ahead_endofline,  %% dont eat '.' %% TA-101007
               %%% dos not work when phrase is stacked   når går bussen .             

    {value(busflag,true)},
    {\+ value(dialog,1)},       %% (Probably ellipsis)
    {vartypeid(X,H)},

    {testmember(H,   
     [neighbourhood,bus,tram,station,departure,arrival])}, %% etc ad hoc,\+  person
                                     %% TA-101018
    !,accept,
    verb_phrase1(exist,X,N, S,VP)\w(verb(exist,pres,fin)),
    !.



verb_phrase(X,N, S,Com::P12) --->   %% leser og korrigerer teksten
                                    %% ad hoc 
    w(verb(Read,_,fin)),
    {verbtype(Read,tv)},

    [og],

    w(verb(Correct,_,fin)),
    {verbtype(Correct,tv)},   
    object(Y,YNP),
    !,
    verb_phrase1(Read,X,N, S,Com::P1)=
          (w(verb(Read,_,fin)), xnp(Y,YNP)),
    !,
    verb_phrases0(Correct,X,S,P1,Com::P12)= 
          ([og],
           w(verb(Correct,_,fin)),
           npgap(Y)). %% ad hoc, xnp(O,NP) gets destroyed
                         




verb_phrase(X,N, S,Com::P12) --->  %% ønsker og sykle ***
    verb_phrase1(V,X,N, S,Com::P1),
    verb_phrases0(V,X,S,P1,Com::P12).   %% Local negation 



%% jeg er på dragvoll og skal til nth

%% jeg bruker global tid og ikke lokal tid
%% --->
%% jeg bruker global tid og (bruker) ikke lokal tid


%%%¤  VERB_PHRASES0 (V,X,S,P1,SEM) 

verb_phrases0(V,X,S,P1,Com::P1 and P) --->  
    vp_conjunction, %% andor(and), 
    [ikke],
    !,
    verb_phrase1(V,X,N, S,Com::P2)\w(verb(V,pres,fin)), %%
        {bigno(not,N,N1)},
        {negate(N1,P2,Q2)},   
    verb_phrases0(V,X,S,Q2,Com::P). 


verb_phrases0(_V,X,S,P1,Com::P1 and P) ---> 
    vp_conjunction, %% andor(and), 
    not_look_ahead([så]), %% most likely conj 
    verb_phrase1(_V1,X,N, S,Com::P2),
    {negate(N,P2,Q2)},            %% Local negation %% // SUSPECT NEGATION
    verb_phrases0(_V2,X,S,Q2,Com::P). 


verb_phrases0(be,X,S,P1,Com::P1 and P) ---> %% filene ligger vedlagt (adj)

     w(adj2(Enclosed,nil)), %% i.e. past part
         {testmember(Enclosed,[enclosed])}, %% .. ikke sist,  e.g. past part
     !,
     verb_phrase1(be,X,id, S,Com::P)\
             (      w(verb(be,pres,fin)),
                    w(adj2(Enclosed,nil))).

verb_phrases0(_V,_,_,P1, _::P1) ---> [].

%%%¤  VP_CONJUNCTION

vp_conjunction ---> [som],  %% du er dum som tar trikk %% AD HOC %% TA-110106
    look_ahead_vp. %% er det jeg som skal spørre deg %% TA-110329
    %%%%   look_ahead(w(verb(_skriver,_pres,fin))). % #-> dum fordi du


vp_conjunction ---> [å],  %% sitter å skriver %% \+ jeg tenker å ta bussen
     look_ahead(w(verb(_Skriver,pres,fin))).%% \+ inf %% TA-110623


vp_conjunction ---> [evt]. 

vp_conjunction ---> 
    and1,
    not_look_ahead([nå]), %% confutant %%  bussen går og nå stopper trikken
    not_look_ahead([så]), %% confutant
    not_look_ahead(w(adv(redundantly))), 
    !.

vp_conjunction --->  
    [men],
    not_look_ahead([så]),
    look_ahead_lit([skal,vil]),
    !.

vp_conjunction --->  
    [men],
    not_look_ahead([så]), %% confutant 
    look_ahead(w(verb(_Has,_,_Fin))), %% men markedsføres OK 
    !.

vp_conjunction ---> or1,  %%  EXPERIMENT  
    look_ahead(w(verb(_,_,fin))).

%%¤¤  VERB_PHRASE1 (V,X,N,S,VP) %% one single verb_phrase

/** %% TA-101103 tistille å -> jeg vil tistille for å ...***
verb_phrase1(V,X,N, S,ComP2 ) --->   %% (hvor) jeg vil. %% HAZARD %% TA-100912
    aux1,                            %% = reise gjøre
    endofline1, %% without check !.
    not_look_ahead(w(verb(_,_,_))), 
%%%     look_ahead(xadverbial1(_,_,_)), %% hvor|når %%nofunk
    !,accept, 
    do_phrase(V,X,N, S,ComP2) \
        (w(verb(go,pres,fin))). 
***/

 
verb_phrase1(V,X,N, S,ComP2 ) --->   %% hvis du vet hvor du skal [gå] så
    aux1,                            %% ad hoc with care 
    not_look_ahead(w(verb(_,_,_))),  %% se-dde
    look_ahead_lit([så, tilbake,fram]), %% jeg vil tilbake til byen
    !,accept, 
    do_phrase(V,X,N, S,ComP2) \
        w(verb(go,pres,fin)).


 
verb_phrase1(V,X,N, S,ComP2 ) --->   %% jeg vil hendelse ( å sykle)
    aux1,                           %% ad hoc with care 
    not_look_ahead(w(verb(_,_,_))), 

    np0_accept(Z,NPZ), {vartypeid(Z,A)},{testmember(A,[thing,coevent,activity])}, 

    !,accept, 
    do_phrase(V,X,N, S,ComP2) \
      (w(verb(do1,pres,fin)),xnp(Z,NPZ)).


 

 
verb_phrase1(V,X,N, S,ComP2 ) --->   %% jeg vil p? NTH 
    aux1,                           %% ad hoc with care 
    negation0(N), %% TA-110128
    redundant0, %% jeg vil egentlig til byen
    not_look_ahead(w(verb(_,_,_))), 
    w(prep(On)), 
        {testmember(On,[from,to,on,towards])}, 
    look_ahead_np, 
    np0_accept(Z,NPZ), 
    {constrain(Z,place)},
    !,accept, 
    do_phrase(V,X,N, S,ComP2) \
      (w(verb(go,pres,fin)),w(prep(On)),xnp(Z,NPZ)).
 

verb_phrase1(V,X,N, S,ComP2 ) --->   %% jeg vil i fremtiden ta buss
    aux1,                           
    not_look_ahead(w(verb(_,_,_))), 
    look_ahead(w(prep(On))), 
        {\+ testmember(On,[from,to,on,towards])}, 

    preadverbials0, %% ad hoc with care 
 
    !,accept, 

    do_phrase(V,X,N, S,ComP2).

 

verb_phrase1(V,X, N, S,ComP2 ) --->   %% jeg vil da vaske bussen
    aux1,                            
    not_look_ahead(w(verb(_,_,_))),   %% feiler på  NÅ
    one_of_lit([da,nå]), %% ad hoc
    !,accept,              
    do_phrase(V,X,N, S,ComP2).


verb_phrase1(V,X, N, S,ComP2 ) --->   %% jeg vil på lørdag ta buss
    aux1,                           %% ad hoc with care 
    not_look_ahead(w(verb(_,_,_))), 
    w(prep(On)),
    look_ahead_np,
    np0_accept(Z,NPZ),
    {constrain(Z,time)},
    !,accept,              
    do_phrase(V,X,N, S,ComP2) /(w(prep(On)),xnp(Z,NPZ)).

     
%% passasjeren skal med. -> pass. er  innenfor

verb_phrase1(be1,X,Neg, S,ComP) ---> 
    [skal],
     negation0(N1),       %%  være %% Elliptic
     optional(w(verb(be,inf,fin))), 
    [med],
    not_look_ahead_np,    %%
    do_phrase(be1,X,N2, S,ComP ) \ (w(verb(be1,inf,fin)), w(adv(inside))),
    {bigno(N1,N2,Neg)}.                    %%% fut


verb_phrase1(be,X,id, S,ComP) ---> %% filene ligger vedlagt (adj)
    w(adj2(Enclosed,nil)), %% i.e. past part
         {testmember(Enclosed,[enclosed])}, %% .. ikke sist,  e.g. past part
    be_pred(X,S, ComP ) \ w(adj2(Enclosed,nil)).



%% bussen er gått ( ikke passive) 
verb_phrase1(V,X, N, S,Com3P3) ---> 
    constrainvehdep(X), 
    w(verb(be,Pres,fin)),
    negation0(N1),
    w(verb(V,past,part)),
        {testmember(V,[go,run,pass])},	 %% etc
    !,
    vp_kernel(V,X,N2,  S,ComP1 )\   w(verb(V,Pres,fin)),
    verb_modifiers0(V,X,S,ComP1, Com3P3 ),
    {bigno(N1,N2,N)}.
	

%%%%%%%%   busstuc er siden utvidet til   å forstå tekst.

verb_phrase1(Sell,Y,Neg, S,VP1) ---> 
    blei, 
    one_of_lit([siden,derfor,dermed]), %% ad hoc 
    negation0(Neg),
    lexv(tv,Sell,past,part),  
    !,                         
    passive(Y,S,VP1)  \ 
        ( w(verb(Sell,past,part))).   
 

verb_phrase1(Sell,Y,Neg, S,VP1) ---> %% skal i så fall være
    aux1,
    redundant0, %
    negation0(Neg),
    blei, 
    lexv(tv,Sell,past,part),  %% lagt ned = stoppet 
    !,                         
    passive(Y,S, VP1 )  \ 
        ( w(verb(Sell,past,part))).  


verb_phrase1(Sell,Y,Neg, S,VP1) ---> %% bli solgt -> selges/ ble -> solgtes 
    redundant0, %% ad hoc
    blei(Neg), %% passive aux        %% ble jeg varslet BEFORE ville jeg varslet

    redundant0, %%%   adverbix0(Prep,Z, PPZ),  %%   .. siden
    lexv(Tv,Sell,past,part), 
         gmem(Tv,[tv,dtv]), %% lagt ned = stoppet 
    !,                         
    passive(Y,S, VP1 )  \ 
        ( w(verb(Sell,past,part))).   
          %%%%% adverbial1(Prep,Z, PPZ) ).

%% en buss er i byen  // må ha verb (eller adj)! %% TA-100905


verb_phrase1(be,X, N, S,ComP2) ---> %% Bussen er gul torsdag %% Fronted
    not_look_ahead(w(verb(go,_,fin))), %% går buss e kl 12 (Subtle)
 
    aux10, %% TA-110106 må vel nesten  være
    redundants0, %% danow0, 
    be(N),                          % be_complement before do_phrase
 
     not_look_ahead_verbx  , %% TA-110113
     
    danow0, 
    redundant0,                    % bussene er nå alltid forsinket   %% ? 

    not_look_ahead_prepx, %% allow FOR .. vanskelig  %% TA-110105
 %%     not_look_ahead(w(prep(_))),  %% not  jeg er i spania %% TA-100905

    be_complements(X,S,ComP2).      % Non-Empty complements to BE 

not_look_ahead_verbx ---> [så],!. %% TA-110113
not_look_ahead_verbx --->  not_look_ahead(w(verb(_,_,_))).


not_look_ahead_prepx ---> look_ahead(w(prep(F))),    %% TA-110105
                          {\+ testmember(F,[for])}, %% for    vanskelig
                          !,reject.
not_look_ahead_prepx ---> [].


verb_phrase1(V,X, N, S,ComP2) --->     %% Fronted du vil kunne svare 
     auxs0(N1,_), %%  skulle ikke ha villet ...

        not_look_ahead(w(verb(_Corr,_,pass))), %% dont destroy passive
     
     redundants0, %% TA-110106
     
%%      danow0, %% avoids NÅ=reach %% TA-110303


     negation0(N3), %% aldri??? 
     {bigno(N1,N3,N4)},

    do_phrase(V,X,N2, S,ComP2),   %% <->  // jeg ville varslet | jeg ble varslet
    {bigno(N4,N2,N)},              %% NEW ad hoc, combines:negations 


    !,accept.  %%% <---  !!!               %% HAZARDOUS BUT ESSENTIAL 


verb_phrase1(go,X,N, S,ComP2) --->   %% må (gå) av  
    aux1,
    not_look_ahead(w(verb(_,_,_))), 
    [av], %% Ad Hoc
    !,accept,                         % last chance for DO BE 
    do_phrase(go,X,N, S,ComP2)  \        % be as intransitive verb
        (w(verb(go,pres,fin)),[av]).  %% \be  ALWAYS LOWEST/LEAST COMMITTING
	


verb_phrase1(Sell,Y,id, S,Com::Pli) --->
    paux0,         %% kan,må?     %%
    redundant0, %% i prinsippet
    w(verb(Sell,_Pres,pass)),  %% skyldtes 
%     !,                          %% Vi snakkes / meet2
    passive(Y,S, (Com::Pli) )  \ 
         w(verb(Sell,past,part)).


verb_phrase1(live,X,id, S,ComP2) ---> 
    be,
    redundant0, %% " bare" 
    number(N),
    w(noun(year,_,u,n)), 
    optional(w(adj2(old,nil))), %% gammel 
    !,
    do_phrase(live,X,id, S,ComP2)  \  %% or has age ???
        (w(verb(live,pres,fin)),prep1(in), 
         number(N),w(noun(year,plu,u,n))).


verb_phrase1(be,X,N, S,ComP2) --->  
    be(N),  
    dudet,[som], %% Norwagism
    !,    
    do_phrase(be,X,N, S,ComP2).



% hvilken buss er den første som      ...                     
verb_phrase1(be,X,N, S,ComP2) --->        
    not_look_ahead(w(verb(go,_,fin))), %% repair of repair er går 
    w(verb(be,_,fin)), %% ikke aux1 
    not_look_ahead(w(verb(_Go_,_,part))), %% gående/ gått 
    !,accept,                       % last chance for DO BE 
    not_look_ahead(w(name(_,_,_))), %% tore (er) amble 
    negation0(N1),
    it0, 
    redundant0,                     % bussene er alltid på veien
    do_phrase(be,X,N2, S,ComP2)  \      % be as intransitive verb
        w(verb(be,pres,fin)),  %% \be  ALWAYS LOWEST/LEAST COMMITTING
    {bigno(N1,N2,N)}.  %% som har ikke 


verb_phrase1(Plage,X, id,S,ComP2) --->   % fronted  Jeg  plages  av en kvinne
    paux0,            % kan,må,
    w(verb(Plage,pres,pass)), 
    thereit0, 
    be_complements(X,S,ComP2) \   
         w(adj2(Plage,nil)).  %% passive verbs are adjectives


%%%¤¤¤  DO_PHRASE       (ACTIVE VERB_PHRASE)



do_phrase(V,X,N,S,BP) --->     %% klokka  går 7 minutter forsinket 
    w(verb(V,_T,fin)),  {testmember(V,[go,come])},
    negation0(N),    %%    ofte0,    %% grade adv

    morethan0, 

    w(nb(Sev,num)),
    w(noun(minute,_SP,u,n)),
 
    w(adj2(A,Nil)), {testmember(A,[delayed,tooearly,late])}, %% TA-101125
    !,accept, 
    ap(A,X,S, AP ) = w(adj2(A,Nil)),

    verb_modifiers0(adj/nil/A,X,S,AP, BP ) \ 
           ( w(prep(with)),   w(nb(Sev,num)),   w(noun(minute,plu,u,n))).           

morethan0 ---> [ca],!. 
morethan0 ---> [minst],!. 
morethan0 ---> [mer],[enn],!.
morethan0 ---> [].


                                            
do_phrase(V,X,id,S,SC::(EXS and KA)) --->          % (jeg ber) deg om å ta bussen  
    w(verb(ask,_,fin)),   %% lexv(rv,V,_tense,fin), // speedup
    not_look_ahead([om]), %% TA-110111
    object(Y,YNP), {constrain(Y,agent)}, %%  object control ad  hoc
    omaa0,
    w(verb(Take,inf,fin)),
    !,
    clausal_object1(SCO,SC::KA)\ (xnp(Y,YNP), w(verb(Take,pres,fin))),
    {co_template(V,that,X,SCO,S, EXS)}.



%% omaa0
%%omaa0 ---> omaa,!.     %% Bug?? RS-121118
omaa0 ---> omaa,!.
omaa0 ---> [].

omaa ---> [om],[å].
omaa ---> [om],[og]. 
omaa ---> [å].



do_phrase(V,X,N, S,Com3P3) --->   

    rvp_kernel(V,X,N, S,ComP1 ),  %% 

    verb_modifiers0(V,X,S,ComP1, Com3P3 ).


%% jeg har vanskelig for å ta buss -> jeg misliker å ta buss
do_phrase(have,X,id,  S,Com1::( P3  and  P1)) ---> 
     has,w(adj2(A,nil)), {testmember(A,[difficult])}, [for],
    [å],
    !,accept,  %% notify ?
    clausal_object1(NewS:coevent, Com1::P1) \ (npgap(X),aux1), %% jeg  vil ta bussen  
        {tv_template(dislike,X,NewS:coevent,S,P3)}. %% techn


do_phrase(V,X,N, S,Com3P3) ---> %% jeg tar bussen til nardo %% Normal Case
    vp_kernel(V,X,N0,  S,ComP1 ), 
%%     it0,  %%  destroys %  bussene  kjører det vil si 17. mai? 
    verb_modifiers0(V,X,S,ComP1, Com3P3 ),
    negation2(N0,N). %% ved søk tas buss 66 ikke. %% Haz? 



do_phrase(V,X,N, S, Com3P3) ---> %% ad hoc hva skal du [gjøre] i dag 
    not_look_ahead(w(verb(_,_,_))),
    look_ahead(w(prep(_))), 
    !,
    vp_kernel(V,X,N,  S,ComP1 )\ w(verb(do1,pres,fin)), 
    it0,  %%  destroys %  bussene  kjører det vil si 17. mai? 
    verb_modifiers0(V,X,S,ComP1, Com3P3 ). 

/*  Faren din er dum tenker jeg %% TA-110623

do_phrase(V,X,N, S, Com3P3) --->    %% ad hoc hvor skal du ?
    not_look_ahead(w(verb(_,_,_))), %% TA-101230
    terminator,

    {vartypeid(X,KKK)}, 
          {\+ testmember(KKK,[number])}, %%SIC 69

   %%%%    {constrain(X,agent)}, %%? %% TA-110128  tosk -> tosker fins
    !,
    vp_kernel(V,X,N,  S,ComP1 )\ 
            w(verb(exist,pres,fin)), %% Nardo -> go to nardo %% TA-110128  tosk 
                   %%%%% TA-110128
    verb_modifiers0(V,X,S,ComP1, Com3P3 ). 
*/




%%%%¤¤¤¤   RVP_KERNEL (V,X,N, S,SEM)


%% Spørre DEG om   bussen går 

rvp_kernel(V,X,N, S,Com3P3) ---> 
    hlexv(dtv,V,Pres,Fin,_Neg), %% FORTELLER
        {testmember(V,[ask,tell,answer,answer1])}, 
    not_look_ahead([om]),  %% TA-110111 speedup
    not_look_ahead([et]),  %% impossible indirect object ad hoc
    not_look_ahead([en]),  %% 
    not_look_ahead(w(nb(_,_))), 

    ind_object(Z,NPZ), %% short %% DEG * np0_accept(
    {constrain(Z,agent)}, %% (jeg påpeker) feilen 
    optional([om]),                       %% OM
    not_look_ahead([at]),   
    np1_accept(Y,NP),  %% BUSSEN
    !,
    vp_kernel(V,X,N, S,ComP1 )\
          (lexv(dtv,V,Pres,Fin),   %% FORTELLER
           xnp(Z,NPZ),            %% DEG
           [noe]),       %% noe
    verb_modifiers0(V,X,S,ComP1, Com3P3 ) \
           (w(prep(about)),        %% om
           xnp(Y,NP)).


rvp_kernel(V,X,Neg, S,SEM) --->  
    lexvaccept(rv,V,_Pres,_Fin,Neg),  %% TA-110111 speedup
    reflexiv0(V), %% tenke seg å      %% TA-100905

    rvpk(V,X,id, S,SEM),
    !.


%% VET  I hvilket .... // special fake 

%  si meg i hvilket format ruteinformasjonen må være for at BusTUC skal forstå den? 
% actually an ordinary transitive VP

rvp_kernel(V,X,id, S,event/real/S::( P  and  P3)) ---> 
    hlexv(rv,V,_Pres,_Fin,_Neg),      {testmember(V,[know,say])},
    reflexiv0(V),
    w(prep(In)), {\+ testmember(In,[])},
    which,
    !,accept, 
    ppstnp(Y,P)  \  (w(prep(In)),which),  
        {tv_template(V,X,Y,S,P3)}.


%% er redd for AT
rvp_kernel(adj/nil/Afraid,X,N, S,Com1:: ( P3  and  P1)) ---> 
    w(verb(be,_Pres,fin)),
    negation0(N),
    w(adj2(Afraid,nil)),
    forat, %% ad hoc  jeg er redd at 
    clausal_object1(NewS:Coevent, Com1::P1), %%  "at bussen går"   
                                            %% dette ...... er feil    
        {atv_template(Afraid,because_of,X,NewS:Coevent,S,P3)}. 


%% rvp_kernel(V,X,id, S,Com1::( P3  and  P1)) ---> 
%%    hlexv(rv,V,_Pres,_Fin,_Neg), 


%%%%¤¤¤ RVPK   Reporting Verb Normal Kernel 

%% Hvis du vet hvor du skal så vet vi hvordan. %% TA-110127
%%                                [ bussen går ].

rvpk(V,X,id, S,Com1::( P3  and  P1)) ---> %% vet HVORDAN  TA-110127 #1
        {testmember(V,[ask,answer,answer1,discuss,know,know1])},
    omut0,
    [hvordan],
    endofline0,   %% no check
  
    !,accept, 

    clausal_object1(NewS:Coevent, Com1::P1)\ %%  " bussen går"  
            (w(noun(bus,sin,def,n)),w(verb(go,pres,fin))),

      {co_template(V,how,X,NewS:Coevent,S,P3)}. %% clause object
                                                  %% co-event template
  
                                              

%% Vet HVORDAN   bussen går %% TA-110127 #2

rvpk(V,X,N, S,Com1::( P3  and  P1)) --->
        {testmember(V,[ask,answer,answer1,discuss,know,know1])}, %% 
    omut0,
    [hvordan],   
    !,
    negation0(N),
         {test(rv_templ(V,_))}, %% pretest
         %% {rv_template(id,V,that,X,S,_,NewS)}, 
    !,accept,  %% notify ?
    clausal_object1(NewS:Coevent, Com1::P1), %%  " bussen går"  

       {co_template(V,how,X,NewS:Coevent,S,P3)}. %% clause object
                                                  %% co-event template
                                                


%% vet at hvis bussen går så står trikken

rvpk(V,X,N, S,Com1::( P3  and  P1)) ---> %% Fortelle til Bussoraklet  AT bussen går
        gmem(V,[calculate,say,tell,know,decide,believe,doubt,think]), %% etc 
    negation0(N),
    [at],
    look_ahead_lit([hvis,når,selvom]), %% TA-110111
 
    !,  
    subordinate(Prep,PX,PO),
    clausal_object1(NewS:Coevent, Com1::P1)/ subordinate(Prep,PX,PO),
         {tv_template(V,X,NewS:Coevent,S,P3)}.
 


%% Vet   bussen (går) 

rvpk(V,X,N, S,Com1::( P3  and  P1)) ---> 
        gmem(V,[calculate,fear,hope,know,mean,recognize,think,understand]), %% ambiguous rv/tv %% TA-110624
    redundant0,   %% kanskje %% TA-110624
    negation0(N),
    not_look_ahead_lit([at,om]), %% TA-110113

    clausal_object0(NewS:Coevent, Com1::P1), %% bussen (går)
        {tv_template(V,X,NewS:Coevent,S,P3)}.



%% Gjør turen mer behagelig= Gjør at turen er mer behagelig 

rvpk(V,X,N, S,Com1::( P3  and  P1)) ---> 
        gmem(V,[do1,paint]), 
     negation0(N), 
    
     [at], %% TA-110114                                   %% hva gjør du orakel
 
     np0_accept(TU,NPTU), 

    !,accept,  %% notify ?
    clausal_object1(NewS:Coevent, Com1::P1)\
       (xnp(TU,NPTU),w(verb(be,pres,fin))),

    {tv_template(V,X,NewS:Coevent,S,P3)}.



%% du sa til meg i stad at trikken går

rvpk(V,X,N, S,Com1::( P3  and  P1)) ---> %% Fortelle til Bussoraklet  AT bussen går
        {testmember(V,[base,say,tell])}, %% TA-110708
    negation0(N),
    preadverbials0,  %% one or more adverbials are stacked, order is reversed
    [at],
    !,  
    clausal_object1(NewS:Coevent, Com1::P1),
         {tv_template(V,X,NewS:Coevent,S,P3)}.


 


%% mener du jeg er dum ?
rvpk(V,X,N, S,Com1::( P3  and  P1)) ---> 
         {testmember(V,[mean,think])}, 
    pronoun(G),
    negation0(N),
    !,accept, 
    clausal_object1(NewS:Coevent, Com1::P1)\ %%  
         pronoun(G),
        {tv_template(V,X,NewS:Coevent,S,P3)}.


%% Anser BusstUC for å være bra

rvpk(V,X,N, S,Com::(P3  and P1)) ---> 
         {testmember(V,[regard])},
    negation0(N),
    object1(Y,YNP),
    optional([for]), 
    [å],
    !,
    clausal_object1(NCO, Com::P1)\
       xnp(Y,YNP),
    {tv_template(V,X,NCO,S,P3)}.


rvpk(V,X,id, S,Com1::( P3  and  P1 )) --->  %% Jeg  lurer (på) (om) NÅR bussen går
       {testmember(V, [wonder] )},          %% TA-101124
    optional([på]),
    optional([om]), 
    [når],
    !,accept, 
    clausal_object1(NewS1:coevent, Com1::P1), 
        {co_template(V,when,X,NewS1:coevent,S,P3)}. 

rvpk(V,X,id, S,Com1::( P3  and  P1 )) --->  %% Jeg  lurer på om bussen går
       {testmember(V, [think,wonder] )}, 
    optional([på]), 
    [om],
    !,accept, 
    clausal_object1(NewS1:coevent, Com1::P1), 
        {co_template(V,whether,X,NewS1:coevent,S,P3)}. 

   
altsogå ---> [altså],[å].
altsogå ---> [og],[å]. 


ppstnp(Z,P) ---> %% Z : i hvilket format (Z) ruteinformasjonen må være
    w(prep(In)),
    which,
    np_kernel(0,Z,NPK),
    forwst(P,In,Z,NPK). 

forwst(P,Prep,Z,FVP) --->
   statreal(P)
      -  adverbial1(Prep,Z, FVP).%% i Z
    

forat ---> [at].
forat ---> [for],[at]. 
forat ---> [fordi].  
forat ---> [av],[at]. %% 
forat ---> [over],[at].
forat ---> [til],[at].
forat ---> [om].  %% det er best om


%% Vet HVOR viktig  bussen er

rvpk(V,X,id, S,Com1::( P3  and  P1)) ---> 
        {testmember(V,[ask,answer,answer1,discuss,know,know1])}, %% 
    omut0,
    [hvor],   
    w(adj2(_important,nil)),
    !,
    clausal_object1(NewS:Coevent, Com1::P1) -
          w(adj2(_important,nil)),

      {co_template(V,how,X,NewS:Coevent,S,P3)}. 
                                                 


%% Vet NÅR  bussen går

rvpk(V,X,N, S,Com1::( P3  and  P1)) ---> 
        gmem(V,[ask,answer,answer1,discover,discuss,know,know1,say]), 
    reflexiv0(V), %% si meg %%
    redundant0, %% jo %% TA-110609
    omut0,
    [når],   
    {test(rv_templ(V,_))}, %% pretest 
    !,
    negation0(N),
    !,accept,  %% notify ?
    clausal_object1(NewS:Coevent, Com1::P1), %%  "at bussen går"   <-- 1

       {co_template(V,when,X,NewS:Coevent,S,P3)}. %% clause object// WHEN
                                                  %% co-event template
                                                

%% Vet HVORFOR  bussen går

rvpk(V,X,N, S,Com1::( P3  and  P1)) ---> 
        {\+ testmember(V,[fail,help,let,lie2,slip,try])},
    {test(rv_templ(V,_))}, 
    [Hvorfor],   {testmember(Hvorfor,[hvorfor,hvordan])},
    !,
    negation0(N),
    !,accept,  
    clausal_object1(NewS:Coevent, Com1::P1), 
         {co_template(V,why,X,NewS:Coevent,S,P3)}.



%% Sier til bussoraklet at fredag er lørdag 
%% = Sier  (at fredag er lørdag) til bussoraklet.

rvpk(V,X,N, S,Com1::( P3  and  P1)) ---> %% Fortelle til Bussoraklet  AT bussen går
        {testmember(V,[say,tell])},
    negation0(N),
    pp(Prep,Z,NPZ), %% til bussoraklet %% <----    pps %%  sa til meg i stad
    [at],
    !,  
    clausal_object1(NewS:Coevent, Com1::P1),
         {tv_template(V,X,NewS:Coevent,S,P3)},
    []- adverbial1(Prep,Z,NPZ). %%  "at bussen går"   <-- 1




%% Vet (at)  bussen går

rvpk(V,X,N, S,Com1::( P3  and  P1)) ---> 
        {\+ testmember(V,[fail,help,let,lie2,slip,think,try,propose])}, %% ber om at
    reflexiv0(V), %% tenke seg
    omut0, %% sometimes odd
%% >at<
    negation0(N),
          {test(rv_templ(V,_))}, 
          {\+ verbtype(V,tv)}, %% propose ringroute 
    !,accept,  %% notify ?
    clausal_object0(NewS:Coevent, Com1::P1),  %% be om et svar %%  "at bussen går"   <-- 1
        {tv_template(V,X,NewS:Coevent,S,P3)}. %% TA-110111


at0 ---> [at],!.   
at0 ---> look_ahead_lit([jeg,du,han,hun,vi,dere,de ,det]).


omut0 ---> [om],!.
omut0 ---> [ut],!. %% finne (ut)
omut0 ---> [].

%% Si/spørre om   bussen går

rvpk(V,X,N, S,Com1::( P3  and  P1)) ---> 
        { testmember(V,[ask,say,know,know1,answer,answer1])},
    reflexiv0(V),
    [om], 
    not_look_ahead_lit([et,en]), %% ad hoc .. be om et svar
    !,                           %% TA-110111
    negation0(N),
    !,accept,  
    clausal_object1(NewS:Coevent, Com1::P1),  %% vite om ting (fins) 
        {co_template(V,whether,X, NewS:Coevent,S,P3)}.


%% Vet AT  bussen går

rvpk(V,X,N, S,Com1::( P3  and  P1)) ---> 
        {test(rv_templ(V,_))},
        {\+ testmember(V,[fail,help,let,lie2,slip,try])}, %% ber om
         %% TA-110629  allow tenker om at
    reflexiv0(V), %% tenke seg 
    omut0, %% sometimes odd 
    [at], %% speedup %% at0 %% TA-110111 .. ber om et svar
    !,
    negation0(N),

    !,accept,  %% notify ?
    clausal_object1(NewS:Coevent, Com1::P1), %%  "at bussen går"   <-- 1
        {tv_template(V,X,NewS:Coevent,S,P3)}.


% at0 ---> [at],!. %% Above   
at0 ---> look_ahead_lit([jeg,du,han,hun,vi,dere,de]). 
%%% Above
%omut0 ---> [om],!.
%omut0 ---> [ut],!. %% finne (ut)
%omut0 ---> [].

%% Spørre om hvilke  busser (SOM) går    

rvpk(V,X,N, S,Com3P3) --->
         {testmember(V,[ask,check,discuss,know,know1,tell])},
    optional([om]),
    hvilkemange,
    clausal_object0(Y,NP), %% busser går // busser som går %% <---
    !,
    do_phrase(V,X,N, S,Com3P3)\      
          (w(verb(V,pres,fin)),
           w(prep(about)), 
           xnp(Y,NP)).

hvilkemange ---> [hvilke].
hvilkemange ---> [hvor],[mange].



%% Å clausal_object %% jeg ønsker å ta bussen

%% ber om  Å synge i kirken

rvpk(V,X,id, S,Com1::( P3  and  P1)) --->
    [om],
    [å], 
        {testmember(V,
           [ask])},  %%  
          {test(rv_templ(V,_))}, 
    !,
    clausal_object1(NewS:coevent, Com1::P1) \ (npgap(X),aux1), %%  "at bussen går"      
        {tv_template(V,X,NewS:coevent,S,P3)}.


%% behøver (å) synge
rvpk(V,X,id, S,Com1::( P3  and  P1)) --->
   
        gmem(V, [need,start,stop,try,use2]),
        optional([å]),
      !,
      clausal_object1(NewS:coevent, Com1::P1) \ (npgap(X),aux1), %%  "at bussen går"      
        {tv_template(V,X,NewS:coevent,S,P3)}.


%% Unngå Å synge i kirken

rvpk(V,X,id, S,Com1::( P3  and  P1)) --->
    optional([på]), %% particlev? %% TA-110623
    [å], 
        {testmember(V,
           [avoid,choose,consider,deny,end,expect,forget,hate,hope,learn,like, %% TA-110429
            manage,need,postpone,promise,propose,
            reach,recommend,refuse,remember,resist,risk,
            seem,slip,start,think,try,use2,want,wish,wonder])},  %%
    %% TA-110623 tenkte å ta buss
         %%  {test(rv_templ(V,_))}, %% pretest ?? %% TA-110623

    !,accept,  %% notify ?
    clausal_object1(NewS:coevent, Com1::P1) \ (npgap(X),aux1), %%  "at bussen går"      
        {tv_template(V,X,NewS:coevent,S,P3)}.


%% Svare PÅ OM   bussen går 

rvpk(V,X,Neg, S,Com1::( P4  and  P1))  --->
        {testmember(V,[answer,answer1,say])},
    reflexiv0(V),                    
    optional([på]), %% generalize!
    [om],
    np1_accept(Y,NP), %% trikken
    negation0(IK), 
    look_ahead_vp, %% .. går  ad hoc
    !,accept,
    lexv(_Xv,Go,Pres,fin), %% be -> // possibly  lexv(cv,be,Pres,fin)
          {test(rv_templ(V,_))}, %% pretest 
    clausal_object1(NewS:coevent, Com1::P1)\ %%  "at bussen går"      
              (xnp(Y,NP),w(verb(Go,Pres,fin)),negation0(IK)),
        {tv_template(V,X,NewS:coevent,S,P3)},
    
     {negate(Neg,P3,P4)}.


%% Spørre om TING SOM (ad hoc/ avoid heavy clausal subject

rvpk(V,X,N, S,Com3P3) --->
         {testmember(V,[ask,worry,tell])}, 
    [om],
    np_kernel(0,Y,NP),
    look_ahead([som]), %% 
    !,
    do_phrase(V,X,N, S,Com3P3)\         
          (w(verb(V,pres,fin)),
           w(prep(about)), 
           np_kernel(0,Y,NP)).


%% Spørre om det går buss   // Alltid clausal

rvpk(V,X,id, S,Com1::( P3  and  P1)) --->
        {testmember(V,[ask,check,discuss,know,know1,see])}, 
    [om],
    clausal_object1(NewS:coevent, Com1::P1),      
        {tv_template(V,X,NewS:coevent,S,P3)}.


%% Spørre om TING.

rvpk(V,X,N, S,Com3P3) --->
         {testmember(V,[ask,worry,tell])}, 
    [om],
    np1_accept(Y,NP), 
    !,
    do_phrase(V,X,N, S,Com3P3)\         
          (w(verb(V,pres,fin)),
           w(prep(about)), 
           xnp(Y,NP)).


%% VET () bussen går  last

rvpk(V,X,N, S,Com1::( P3  and  P1)) ---> %% TA-
         {testmember(V,[believe,clculate,know,know1,mean,tell,say])}, %% not manage 
    negation0(N),
    reflexiv0(V), %% if relevant %% meg 
    not_look_ahead([om]), 
         {test(rv_templ(V,_))}, %% pretest
    !,accept,  %% notify ?
    clausal_object0(NewS:Coevent, Com1::P1), %%   bussen går"    <-- 0
        {tv_template(V,X,NewS:Coevent,S,P3)}.

%% SLIPPE (å) vente


%%rvpk(V,X,id, S,Com1::( P3  and  P1)) --->      %% Bug?? RS-121118
rvpk(V,X,id, S,Com1::( P3  and  P1)) --->
        {testmember(V,
           [avoid,manage,promise,recommend,remember,seem,
            slip,start,try,use2,want])},  %%   dont take at
          {test(rv_templ(V,_))}, %% pretest
    !,accept, 
    clausal_object1(NewS:coevent, Com1::P1) \ (npgap(X),aux1), %%  "at bussen går"      
        {tv_template(V,X,NewS:coevent,S,P3)}.


%%%%¤¤  CLAUSAL_OBJECT

%% Garden path    NP.. ST

%%¤  CLAUSAL_OBJECT0    

clausal_object0(X,NP) --->  %% til 1. mai       
    look_ahead(w(nb(_,_))),
    obviousdate(X,NP), %% NB \+  obviousdate1 %% TA-110125
    !,accept.

  

clausal_object0(OT,COB) --->         %% til bussen ..... går? 
    not_look_ahead(w(nb(_,_))), %% før 21 ¤¤ number %% TA-110107
    np(X,XNP),             %% (varsle) før jeg tar buss
 
%%%   object(X,XNP),  %% foreslå buss 20 og buss 36 
%%%   noun_phrase1(X,XNP),  %%_accept   // subject/object ambiguity    %% either bus or coevent 
                          %%  en agent som tror at du hater ham  fins. 
    cond_vp(X,XNP,OT,COB).

cond_vp(X,XNP,OT,COB) --->                     
    look_ahead([Du]), {testmember(Du,[du,jeg])}, %% du er hva jeg tror  du er . 
    clausal_object1(OT,COB)/ xnp(X,XNP),         %% Du NOT OBJECT
    !.                     % not \  ( du er hva jeg tror) du er 


cond_vp(X,XNP,OT,COB) --->
    not_look_ahead([så]), %%  here, så=so ,\+ see
%%%%     not_look_ahead(w(verb(have,_,fin))), %% ad hoc %% TA-110106
    look_ahead_vp,                    %% det som man ikke vet har man ingen anelse om.
    clausal_object1(OT,COB)\ xnp(X,XNP),
    !.
cond_vp(X,XNP,X,XNP) ---> [].


%%%¤  CLAUSAL_OBJECT1 (VAR,P)  %% at bussen går

clausal_object1(NewS:coevent, 
        P3::(exists(NewS:coevent)::(NewS isa coevent and event/NewS/S and  KA))) --->  
    substatem(S,P3::KA). %% allow hvis .. så


%%%¤  CLAUSAL_OBJECT2 (VAR,P) %% at i sommer (så)går bussen

clausal_object2(NewS:coevent, 
        P3::(exists(NewS:coevent)::(NewS isa coevent and event/NewS/S and  KA))) --->  
    sostatem(S,P3::KA).



%%%¤ VP_KERNEL (V,X,N, S,COM)


% DTV

%% månedskort gir overgang til buss | NOT dtv


vp_kernel(V,X,N,  S,Com3::P1 )  ---> %% jeg tillater deg å gå
    hlexv(dtv,V,_Tense,_Part,N1),  
       {testmember(V,[allow,let])},  

   ind_object(U, UNP), %% deg 

    optional([å]), %% tillater .. å gå /lar .. gå
    clausal_object1(Y1,E1::P1) \ (xnp(U,UNP),[vil]),
       {tv_template(V,X,Y1,S,P)},
    someevent00(S,P, (Com3::E1) ), 
    negation2(N1,N). 


vp_kernel(Give,X,N,  S,Com3::(P1 and Q1)) ---> %% TA-101207 FRONTEST
    lexv(dtv,Give,_Tense,fin),

        not_look_ahead(w(adj2(_Right,nil))), %% rett svar \= give (the right)  an answer
        not_look_ahead(w(nb(_,_))),     %% impossible ind obj 
        not_look_ahead_lit([en,et,den,det,han,hun,vi]), %% NOT ind object

    negation0(N1),
    ind_object(Y, E1::P1),  %%   månedskort gir overgang til buss |  NOT dtv 
    negation0(N2),
        not_look_ahead([så]), %% very ad hoc  sende ruter så snart rundene  er ferdig
    {bigno(N1,N2,N)},  
                       
    object(Z, E1::Q1), 
       {dtv_template(Give,X, Y, Z, S,Code)},

    optional([til]), %% ad hoc  Garden path %%   
                     %% hvilken dame fortalte sjåføren deg å  gi billetten (til) ?   
    someevent00(S,Code, (Com3::E1) ).         


vp_kernel(notify,X,N,  S,Com3::P1 )  --->  %% TA-110225 %%  du varsler [meg] 2 minutter før
                                     %%  special, 2 min not object
    hlexv(tv,notify,_Tense,_Part,N),   
 
    look_ahead(w(nb(_,_))),
    !,accept,
    np0_accept(Y1, E1::P1)=[meg],
    
   {tv_template(notify,X,Y1,S,P)}, %% TA-110225
    someevent00(S,P, (Com3::E1) ).


vp_kernel(V,X,N,  S,Com3::P1 )  ---> %%  jeg kjørte idag en buss
                                     %% Extreme care %% TA-110107
    lexvaccept(tv,V,_Tense,fin,N),    %% TA-110112  
    redundant0,   %% nok | dessverre %% TA-110411
    adverbx(AA,BB,CC),
    object2(X,Y1, E1::P1),    
    !,accept,
   {tv_template(V,X,Y1,S,P)},
    someevent00(S,P, (Com3::E1) ),
        [] - adverbx(AA,BB,CC). %% <-


%% vi kjørte 21 februar


vp_kernel(V,X,N,  S,Com3::P1 )  ---> %%  jeg har  brakt penger

    hlexv(tv,V,_Tense,_Part,N),    %% = brakte

    not_look_ahead_lit([om,hver]),  %% ad hoc hver søndag %% TA-110724

  %% AD HOC %% TA-110401 hvilken holdeplass vil tagore snakke om.
%%%%%%%%    not_look_ahead(w(prep(_to))),  %% .. change %% TA-110113
%% ser du en buss som vi tar til * nardo 

    object2(X,Y1, E1::P1),    

    {\+ constrain(Y1,date); V == have},  %% TA-110519 expensive ** jeg har en bursdag

    {\+ constrain(Y1,distance)},  %% kilometer
    {\+ constrain(Y1,minute)},    %% minutes
    {\+ constrain(Y1,hour)},      %% TA-110615 // jeg har en god dag OK
    {\+ constrain(Y1,clock)},      %% TA-110330

    !,accept,
   {tv_template(V,X,Y1,S,P)},
    someevent00(S,P, (Com3::E1) ).


vp_kernel(V,X,N, S,VPK )  ---> %% Have tried tv %% TA-110310

    hlexv(iv,V,Tense,fin,N), gmem(V,[run,pass]), %% iv|tv %% TA-110330

    {iv_template(V,X,S,EXS)},
    {Tense \== imp},  
    !,
    redundants0, 
    it0, 
    reflexiv0(V),  
    someevent00(S,EXS, VPK ). 


vp_kernel(have,X,N,  S,Com3::P1 )  --->  % ???? %% (et navn som) du har  informasjon om
    negation0(N1),
    has,                                 %% fronted prep. object
    negation0(N2),
    {bigno(N1,N2,N)},
    w(noun(information,sin,u,n)) ,       %% avoid   som du har (navn).
    [om],
     not_look_ahead_lit([når,å,at]), 
    !,
    np1(Y,E1::P1) \ 
        (w(noun(information,sin,u,n)),w(prep(regarding))), %% informasjon om busser
    {tv_template(have,X,Y,S,P)},
    someevent00(S,P, Com3::E1 ). 


vp_kernel(have,X,N,  S,Com3P1 )  --->  %% TT har åpent = er åpent 
    negation0(N),
    has,        
    w(adj2(Open,nil)), {testmember(Open,[open,closed])}, %% FOS
    !,
    be_complement(X, S,Com3P1 )\ w(adj2(Open,nil)).


vp_kernel(have,X,N,  S,Com3P1 )  --->  %% TT har det bra = er bra
    has,  
    [det],
    negation0(N),
    w(adj2(Open,nil)),
    optional([da]), %% ad hoc %% har du det bra da
    !,
    be_complement(X, S,Com3P1 )\ w(adj2(Open,nil)).



% TV

vp_kernel(V,X,N,  S,Com3::P1 )  ---> %% allow have taken as took

    not_look_ahead(w(verb(have,_,_))), %% speedup,hlex is expensive
    not_look_ahead(w(verb(be2,_,_))),  %% TA-101115

    hlexv(tv,V,_Tense,_Part,N1),    %% ville tatt OK

    not_look_ahead(w(prep(_To))), %% TA-110113 .. change
    {V \== have},
    {V \== be2}, 
    reflexiv0(V),  
    particle0(V), %% tell "regarding"

%%%%%%%    {compliancetest2(tv,V,X)}, %%  Garden Path Pruning !!! Unnec?

     redundant0, %% preadverbials0, %%      %% Haz ?? %% jeg får nå svar
                 %% funker ikke hvis objekt er stakket
                 %% hvilken buss må jeg ta fra vestlia
%%     not_look_ahead(w(nb(_,_))), %% TA-101116 %% NB not number (3 minutter)
    object2(X,Y1, E1::P1),         %% jeg kjøper 1 billett %% TA-101118
    !,accept, %% terrible haz ?   Overgangen tar utgangspunkt.
   {tv_template(V,X,Y1,S,P)},
    someevent00(S,P, (Com3::E1) ), 
    negation2(N1,N). 




menbare ---> [men]. 
menbare ---> [bare].


vp_kernel(V,X,N,  S,Com3::P1 )  ---> %% tok idag bussen // With care 
      not_look_ahead(w(verb(have,_,_))), %% speedup,hlex is expensive
      not_look_ahead(w(verb(be2,_,_))),  %% TA-101115
   hlexv(tv,V,_Tense,_Part,N1),  
    {V \== have},
    {V \== be2}, 
        {\+ verbtype(V,iv)}, %%  e.g.stop
    adverb(AA,BB,pre), %% idag er pre  %% bussen stoppet igår //stoppe =iv|tv
       not_look_ahead(w(noun(night,_,_,_))), %% horrendous ad hoc
    object2(X,Y1, E1::P1),             %% kveld (SIC)
%%        !,  
    {tv_template(V,X,Y1,S,P)},
    someevent00(S,P, (Com3::E1) ), 
    negation2(N1,N),
        []-  xadverb(AA,BB).

 
% be 

vp_kernel(be1,X, N, S,VPK )  ---> %% møtet er (på) torsdag
    be,
    negation0(N),
    look_ahead(w(noun(Thursday,_,_,_))), {subclass0(Thursday,time)}, %%
    {iv_template(be1,X,S,EXS)},
    someevent00(S,EXS, VPK ), 
       []-w(prep(on)). %% insert

vp_kernel(be1,X,id, S,VPK )  ---> %% jeg er () Munkegata // special repair
    be,        
        {vartypeid(X,self)},
        look_ahead(w(name(_Mkgt,n,Station))),
        {subclass0(Station,place)},
        {iv_template(be1,X,S,EXS)},
        someevent00(S,EXS, VPK ),
    []-w(prep(in)). 


vp_kernel(be1,X,N, S,VPK )  ---> %% er i byen
    be,
    negation0(N),
        not_look_ahead_np, %% eg adverbial1 
    {iv_template(be1,X,S,EXS)},
    redundant0, %% da 
    someevent00(S,EXS, VPK ). 


vp_kernel(be1,X,N, S,VPK )  ---> %% er inne  //  allow as kernel
    be,
    negation0(N),
    look_ahead(w(adv(Inside))),
        {testmember(Inside,[redundantly,inside,outside])}, %% ad hoc
    !,
    {iv_template(be1,X,S,EXS)},
    someevent00(S,EXS, VPK ). 


vp_kernel(be1,X, N, S,VPK )  ---> %% er her  //  allow as kernel
    be,
    negation0(N),
    look_ahead([Her]), {testmember(Her,[her,der,overalt])}, %% ad hoc (redundantly?)
    {iv_template(be1,X,S,EXS)},
    redundant0, %% da 
    someevent00(S,EXS, VPK ). 

/* %% TA-101125 har ikke brakt
%% hva skal vi ha til middag \= hva skal vi ha til ved middagstid
vp_kernel(have,X,N,  S,Com3::P1 )  ---> %% have %% after hlexv(tv   har  rettet en feil
    hlexv(tv,have,_Tense,_Part,N1),     %% jeg har en brus, not att
    reflexiv0(have),  
    preadverbials0, %% redundant0, %%  i sin tid en snutt 
    negation0(N2), %% mann som har ikke 
        {bigno(N1,N2,N0)},
    object2(X,Y1, E1::P1), %% NB not number (3 minutter)

    !,accept, %% hazardous   har du ost (øst) %% TA-101115

    {tv_template(have,X,Y1,S,P)},
    someevent00(S,P, Com3::E1 ), 
    negation0(N3),
        {bigno(N0,N3,N)},  
    !,accept.
*/



%% TVERB1 PARTICLE OBJECT -> TVERB2 OBJECT
vp_kernel(V,X,N, S,Com3::P1 )  ---> %% ha på (seg) 
    w(verb(Have,_,fin)),
    {testmember(Have,[have])}, 
    negation0(N1), 
    particlev2(Have,V), %% ha på = attend| finne ut av = finne
    reflexiv0(V),  
    redundant0,     

    not_look_ahead(w(verb(_Go,past,part))), %% har gått

    object2(X,Y1, E1::P1), 
    {tv_template(V,X,Y1,S,P)},
    someevent00(S,P, (Com3::E1) ), 
    negation2(N1,N),
    !,accept.
 

vp_kernel(V,X,N, S,Com3::P1 )  ---> %% jeg legger heretter ut en  versjon 
    lexv(tv,V,_Tense,_),    %% ville tatt OK
    {testmember(V,[lay])}, %% trans verbs with particles
    !, 
    negation0(N), %% ikke heretter | heretter ikke ?
    verb_mod1(V,Z,S,Compl,Subj::P3), %% heretter    
    particle(V), %% legge ut // ignored
    redundant0, 
    object2(X,Y1, E1::P1), 
    {tv_template(V,X,Y1,S,P)},
    someevent00(S,P, (Com3::E1) ), 
    !,accept,
%%       postpone for verb_modifiers
    []- (particle(V), verb_mod1(V,Z,S,Compl,Subj::P3)).
 



vp_kernel(evah,X,N,  S,Com3::P1 ) ---> 
    lexv(tv,evah,_,fin),   %% resiproc have (artificial)
    negation0(N), 
    subject2(X,Y, P2::P),
    {has_template(Y,X,P2)},         % swap
    someevent00(S,P, (Com3::P1) ).



vp_kernel(V,X,N,  S,Com3::P1 )  ---> 
    hlexv(tv,V,_Tense,_Part,N1),    %% ville tatt OK
    {V == be2}, 
    reflexiv0(V),  
    {compliancetest2(tv,V,X)}, %%  Garden Path Pruning !!!
    redundant0, 
    object2(X,Y1, E1::P1), %% NB not number (3 minutter)
    {tv_template(V,X,Y1,S,P)},
    someevent00(S,P, (Com3::E1) ), 
    negation2(N1,N). 


vp_kernel(V,X,N, S,VPK )  ---> %% har levet -> levde 

    hlexv(iv,V,Tense,fin,N),

    {iv_template(V,X,S,EXS)},
    {Tense \== imp},  %% jeg trenger hjelp 
    redundants0, %% da | trygt og godt 
    it0, %% finnes det %% \+ der 
    reflexiv0(V),  
    someevent00(S,EXS, VPK ). 



vp_kernel(V,X,N,  S,(Com3::P1)  )  ---> %% Jeg må hjem
    {constrain(X,person)}, %% ikke busstuc 
        not_look_ahead([kan]), 
    [Må], {testmember(Må,[må,skal,vil])}, %% Ad Hoc  
        not_look_ahead(w(verb(_,_,_))), 
    !,
    intrans_verb(V,X,N1, S,P,_Tense,_Fin)\ 
           w(verb(arrive,pres,fin)),  %% direction = TO 
    negation2(N1,N),
    someevent00(S,P, (Com3::P1)) . 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% CODE SEMANTIC SECTION 

%%%¤ WORLDCOMP 

worldcomp(Real,  S,event/Real/S::P,P) ---> []. 


%%%¤ REALCOMP 

realcomp(        S,event/real/S::P,P ) ---> [].  %%  // real

%%¤¤ SOMEEVENT00 

someevent00(S,P, Q::(exists(S:event)::P and Q) ) ---> []. 


%%   om  NP(exists)  %% Ambiguous, very ad hoc

thatto0(_W,that,X) ---> infinitive,!,[]-npgap(X). %% Å = AT JEG

thatto0(_Tell,_Whether,_) ---> 
     w(prep(on)), %% tenker på 
     !,reject.

thatto0(_Tell,_Whether,_) ---> [om], %% bussene ..... går 
     look_ahead(w(name(_,_,_))),           %% navn er objekt
     !,reject.

thatto0(_Tell,_Whether,_) ---> [om], %% bussen
    look_ahead(w(noun(departure,_,_,n))), %% bussavganger er objekt
    !,reject.       



%  Vet du |når går bussen -> når bussen  går 

%%% THAT0  


that0(_Think,that) ---> 
    [på],
    !,reject.


that0(Know,when) ---> 
        gmem(Know,[know,know1,think,ask,notify,tell]),
    [når],
    w(verb(Go,P,fin)),
    np1(A, NP1),%% TA-110314
        !,accept,
    [] - (xnp(A,NP1),  w(verb(Go,P,fin))),
        !,accept.


that0(ask,that) ---> look_ahead(w(verb(_,inf,_))). %% be (om å) gå 

that0(answer,whether) ---> on0,[om]. 

that0(ask,that) ---> [om],infinitive,!,accept.  %%  (ber deg om å gå)
that0(ask,whether) ---> [om],!,accept. 

that0(ask,that) ---> infinitive,!,accept. 
 
that0(believe,that) ---> [at],!. 
that0(believe,that) ---> []. 

that0(know,whether)    ---> [om],!. 
that0(know,that)    ---> [at],!.  
that0(know,that)    ---> 
    not_look_ahead([en]), %% jeg vet [*at] en vei
    not_look_ahead(w(noun(_,_,_,_))). 

that0(know1,whether)    ---> [om],!. 
that0(know1,that)    ---> [at],!.  
that0(know1,that)    ---> 
    not_look_ahead([en]), %% jeg vet [*at] en vei
    not_look_ahead(w(noun(_,_,_,_))). 


that0(let,that) ---> []. 

that0(mean,that)    ---> [at],!.
that0(mean,that)    ---> [].

that0(notify,that)  ---> [at].       %%
that0(notify,that)  ---> [om], [at],!,accept. 
that0(notify,_) ---> [om],!,reject.   %% varsle om = about

that0(say,that) ---> [at],!.
that0(say,that) ---> [].



that0(tell,that) ---> look_ahead([et]),!,reject.
that0(tell,that) ---> look_ahead([en]),!,reject.  %% oppgi et sted
that0(tell,that) ---> [at],!. 

%% that0(tell,that) ---> not_look_ahead([om]),!.  
%% tell requires that


that0(think,that)   ---> [at],!.  
that0(think,that)   ---> [].  

that0(understand,how)    ---> [hvordan].

that0(want,that)    ---> [at],!. 
that0(want,to)    ---> [og].  %%   Incorr. N ønsker og ta buss 

that0(wish,that)    ---> look_ahead(w(verb(_,_,_))). %% jeg ønsker reise

that0(_W,TW)    ---> that(TW),!,
    not_look_ahead(w(noun(departure,_,_,_))), %% ad hoc, bussavg objekt"
    accept. %%  * varsle om 
                                          
%%%%%%%%%%%%%%%%%%%%%%%%%




% % % 


rep_modifiers0(_Say,_X,_S,_Com1Subj,_Com2P2) ---> 
    [hvor],
    !,
    reject.

rep_modifiers0(_Say,_X,_S,_Com1Subj,_Com2P2) ---> 
    [hva],
    !,
    reject.


rep_modifiers0(See,X,S,Com1Subj,Com2P2) ---> %% ser i bussruta at 
        {testmember(See,[see])},  
        look_ahead(w(prep(To))), 
        {testmember(To,[in])},      
     verb_modifier(See,X,S,Com1Subj,Com2P2).


rep_modifiers0(Say,X,S,Com1Subj,Com2P2) ---> %% say to mary that john died
    { testmember(Say,[say,tell])},             %%  ( not will/shall)
    prep1(to), 
    verb_modifiers(Say,X,S,Com1Subj,Com2P2) \ prep(to).



rep_modifiers0(_Say,_X,_S,ComPis,ComPis) ---> [].



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Complements to be other than as intransitive verb be1  %%

%%¤  BE_COMPLEMENTS (X,S, VP)

be_complements(X,S,Com::(B and CNP)) ---> %% Feilen er at i sommer går bussen
    [at],                                 %% TA-110808, with care
    look_ahead(w(prep(_In))),
    !,
    preadverbials,
    clausal_object2(Y,Com::CNP),
    {bealign(X,Y,S,CNP,B)}. 



be_complements(X,S,Com::(B and CNP)) ---> %% Feilen er at bussen står
    [at],  
    !,accept,
  
    clausal_object1(Y,Com::CNP),
    {bealign(X,Y,S,CNP,B)}. 



be_complements(X,S,Com::(B and CNP)) ---> %% er å ta buss
    [å],  
    !,accept,
    clausal_object1(Y,Com::CNP)\ someone, %% rough
    {bealign(X,Y,S,CNP,B)}. 



be_complements(X,S, ComP3 ) ---> 
    be_complement(X,S, (Com::P1) ),          % er solgt
    be_complements20(X,S, (Com::P1), ComP3 ).    % i oslo ?????
  

%%%¤ BE_COMPLEMENTS_20 

be_complements20(X,S, Com::P1,  Com::(P1 or P3) ) ---> 
   [eller],                          %% ? Haz ?
   not_look_ahead_lit(['.','?']), %% er du dum eller ?
   !,
   be_complement(X,S, Com::P2 ),         
   be_complements20(X,S, Com::P2, Com::P3 ).


be_complements20(X,S, (Com::P1),  (Com::(P1 and P3) )) ---> 
   be_compl_conjunction, %% and0,                           %% 
   be_pred(X,S, ComP2 ),           %%  (not noun)
   be_complements20(X,S, ComP2, (Com::P3) ).

be_complements20(_,_,ComP,ComP) ---> redundant0. 

%%%¤ BE_COMPL_CONJUNCTION 

be_compl_conjunction ---> [og],!. %% Too careful ?? 
be_compl_conjunction ---> [men],look_ahead(w(verb(_Send,past,part))),!.
%% be_compl_conjunction ---> []. %% no, demands another be_pred %% TA-101108

% 1                                                 

%%%¤ BE_COMPLEMENT  


be_complement(X,B, CD ) ---> %% bussen er sen (* ikke en sen buss *) 
   not_look_ahead_lit([der,her]),        %%  er du der % -> do_phrase (be1)
   be_pred(X,B, CD ).       %% in reduced_rel

% 2
be_complement(A,B, CD ) ---> %% er den første som går 
    not_look_ahead_lit([der,her]), 
%%%     not_look_ahead([det]),  %% du er det beste orkaklet 
    be_noun(A,B, CD ).      %% not in reduced_rel (lived a miner fortyniner *)


%%%¤  BE_PRED         BE predication (not adverbial?)



% 5 %% FRONTED
be_pred(X,S, BP ) --->  %% after comparisons... smartere enn meg 

    ap(A,X,S,  AP ),

    {\+ testmember(A,[true,whole])}, %% den nærmeste // 

    not_look_ahead_nounx, %% // OOPS kl

    verb_modifiers0(adj/nil/A,X,S, AP, BP ).   %% identical to Adj Compls NEW



be_pred(X,S,COM2) ---> %% (fin og) uten feil 

    look_ahead(w(prep(_))),

    verb_mod1(be1,X,S,Compl,VM),

    {thenwhat(Compl, VM, COM2)}. %% Dont ask, it works




be_pred(X,S,BP) --->  %% 90 prosent sikker = %% sikker med 90 
    w(nb(M,num)),
    w(noun(percent,SP,u,n)),
    w(adj2(A,nil)), {testmember(A,[certain,safe])},

    ap(A,X,S, AP ) = w(adj2(A,nil)),

    verb_modifiers0(adj/nil/A,X,S,AP, BP ) \ 
           ( w(prep(with)),   w(nb(M,num)),   w(noun(percent,SP,u,n))).           
 


be_pred(X,S,BP) --->     %% 1 minutt forsinket = 
                         %% forsinket med  1 minutt

    ofte0,    %% grade adv
    mangenoen,
    w(noun(minute,_SP,u,n)),
    !,
    w(adj2(A,nil)), {testmember(A,[delayed,tooearly])},

    ap(A,X,S, AP ) = w(adj2(A,nil)),

    verb_modifiers0(adj/nil/A,X,S,AP, BP ) \ 
           ( w(prep(with)),     w(noun(minute,plu,u,n))).           



ofte0 ---> [ofte]. %% ad hoc 
ofte0 ---> [].
  
mangenoen ---> [mange]. 
mangenoen ---> [flere].
mangenoen ---> [noen].



be_pred(X,S,BP) --->     %% 1 minutt forsinket =
                         %% forsinket med  1 minutt

    w(nb(M,num)),
    w(noun(minute,SP,u,n)),
    w(adj2(A,nil)), {testmember(A,[delayed,tooearly])},

    ap(A,X,S, AP ) = w(adj2(A,nil)),

    verb_modifiers0(adj/nil/A,X,S,AP, BP ) \ 
           ( w(prep(with)),   w(nb(M,num)),   w(noun(minute,SP,u,n))).           
 



be_pred(X,S, BP ) --->  %% after comparisons... smartere enn meg 
    [mer],
    look_ahead([enn]), %% større enn
    ap(A,X,S, AP ) = w(adj2(great,nil)), %% Ad Hoc
    verb_modifiers0(adj/nil/A,X,S, AP, BP ).   



be_pred(Y,S, (Com::P) )---> 
    passive(Y,S, (Com::P) ).




% 3
be_pred(X,S, ComKA ) ---> 
    comparisons(X,S,P2),
    someevent00(S,P2, ComKA).

% 4
be_pred(X,S, (Com::P2) ) ---> %%  (moved up) % være sikker -> know -> know1
    sure,
    do_phrase(know,X,id, S,(Com::P2) )\  w(verb(know,pres,fin)). 

% 4B

be_pred(X,S, AP2 ) --->  %% usikker (på) hva %% Special
    ap(A,X,S, AP1 ),
    look_ahead([hva]), %%     
     {\+ testmember(A,[true,whole])}, %% / near .. nearest
    verb_modifiers0(adj/nil/A,X,S, AP1,AP2 )\ w(prep(on)).  


fordent0(Very)  ---> gradverb(Very),!. 
fordent0(nil)   ---> dent0.  


% bussen er ferdig kl 13
 
not_look_ahead_nounx ---> look_ahead(w(noun(clock,sin,def,n))),!. %% kl klokken
not_look_ahead_nounx ---> not_look_ahead(w(noun(_,_,_,_))).


 
%%%¤¤¤  BE_NOUN  (X,S, COMV)

be_noun(X,S, (Com::(exists(S:event)::P2)) ) ---> %% årsaken er at trikken står
    [at],
    clausal_object1(Y,Com::P1),
    {bealign(X,Y,S,P1,P2)}, 
    !.




be_noun(X,S, (Com::(exists(S:event)::P2)) ) ---> %% klokken er 18.
    look_ahead(w(nb(_,_))),                      %% TA-110218
    obviousclock(Y,Com2::P1)\w(noun(clock,sin,def,n)),
    {bealign(X,Y,S,P1,P11)}, 
    !,
    verb_modifiers0(exist ,X,S, (Com2::P11) ,(Com::P2) ).


be_noun(X,S, (Com::(exists(S:event)::P2)) ) ---> 

%%  hva er nærmeste holdeplass
                   %%  hvilken farge er neste buss *  
    
    redundant0, %%  optional([dermed]),

    object(Y,Com2::P1),   %% dete er jeg sikker på %% TA-101025
    {bealign(X,Y,S,P1,P11)}, 
    optional([bare]),
    !,
    verb_modifiers0(exist ,X,S, (Com2::P11) ,(Com::P2) ).


%%%%%¤¤¤ AP (A,X,S, Com )

ap(A,X,S, ComKA ) ---> 
    mthe10,            %% den raskeste
    adj1s(A,X,S,P), %% BARE ren adjektiv, ikke noun/name !!! 
    redundant0,     %% jeg er syk dessverre
    someevent00(S,P, ComKA ).



ap(Borne,X,S, ComKA ) ---> %% Pass  %% jeg er født
    w(verb(Borne,past,part)),
    {\+ testmember(Borne,[be,have])}, %% jeg er hatt * 
    {adj_template(nil,be/Borne,X,S,P)}, 
    someevent00(S,P, ComKA ).

mthe10 ---> [mye]. %% ad hoc
mthe10 ---> the0. 

%%%%¤¤¤   PASSIVE  (Y, S, STM) %% passive phrase after BE


passive(Y,S, STM ) ---> %% bussen er video-overvåket %% TA-110526
    w(noun(Video,sin,u,n)), gmem(Video,[video,camera]), %% etc
    lexv(tv,V,Tense,part),
    {\+ testmember(V,[be2,have])}, %% jeg er "hatt" 
    whodidit(X,BC),          
    !,                                    
    state(S, STM) \ (np(X,BC), %% X overvåker bussen med Video
                       w(verb(V,Tense,fin)), 
                        npgap(Y),
                        w(prep(by)),
                        w(noun(Video,sin,u,n))).

passive(Y,S, STM ) ---> %% jeg vil bli ilagt et gebyr 
    lexv(dtv,V,past,part), 
    
        {\+ testmember(V,[be2,have,wish,want])},
        not_look_ahead(w(adj2(_First,_))), %% (utviklet) første gang

    whodidit(X,BC),   
    !,
    state(S, STM) \ 
         (np(X,BC), %% noen
          w(verb(V,past,fin)),     %% ila
          npgap(Y)).       %% meg             
                   


passive(Y,S, STM ) ---> %% jeg er kalt tore 
    lexv(dtv,V,Tense,part), 
    
    {\+ testmember(V,[be2,have,wish,want])}, 

    not_look_ahead(w(adj2(_First,_))), %% (utviklet) første gang
    ind_object(Z,NPZ), %% IKKE jeg,du 

    whodidit(X,BC),   
    !,
    state(S, STM) - (np(X,BC), %% noen
                    w(verb(V,Tense,fin)), %% kalte
                    npgap(Y),       %% meg                   
                    noun_phrase1(Z,NPZ)).     %% tore// <--- Tricky \+ np(Z,NPZ)


passive(Y,S, (Com::Pli) ) ---> %% jeg vil bli varslet OM bussen
    lexv(tv,notify,past,part),
    [om],
    whodidit(X,BC),   
    !,
    state(S,Com::Pli) /(xnp(X,BC),
                        w(verb(notify,pres,fin)), 
                        w(prep(regarding)),
                        npgap(Y)).


passive(Y,S, STM ) ---> 
    adverbial1(Prep, Z,SCP3),       %% a book was earlier studied. 
    !,% expensive ?   
    lexv(tv,V,Tense,part),
    {\+ testmember(V,[be2,have])}, %% jeg er "hatt" 
    whodidit(X,BC),   
    !,
    state(S, STM) \ (np(X,BC),
                        w(verb(V,Tense,fin)), 
                        npgap(Y),
                        adverbial1(Prep, Z,SCP3)).     
                        

passive(Y,S, STM ) ---> 
    lexv(tv,V,Tense,part),
    {\+ testmember(V,[be2,have])}, %% jeg er "hatt" 
    particlev0(V,W), %% omdøpt til = kalt %% TA-110708

    redundant0, %% to make     not_look_ahead([og] work

%%     not_look_ahead([og]), %%  korrigert og lagt inn | systemet er  restartet og nå ...

    whodidit(X,BC),          
    !,                                    
    state(S, STM) \ (np(X,BC),  %%  NB \   Når det er verifisert ønsker  jeg bussen.
                        w(verb(W,Tense,fin)), 
                        npgap(Y)).


passive(Y,S, STM ) --->   %%  korrigert og lagt inn
    lexv(tv,V,past,part), %% korrigert
         {\+ testmember(V,[be2,have])}, 
    redundant0, %% NEC???? to make     not_look_ahead([og] work
    [og],
    hlexv(tv,W,past,part,id), %% hlexv   lagt inn
         {\+ testmember(V,[be2,have])}, 
    !,
    whodidit(X,BC),   
    !,                                        
    state(S, STM) \ 
        (np(X,BC),  
         w(verb(V,past,fin)),
         [og],
         w(verb(W,past,fin)),
         npgap(Y)).

 
%%¤ WHODIDIT (X,NP)



whodidit(X,BC)---> %% for?rsaket av at ..
    [av],
    [at],
    clausal_object1(X, BC),
    !,accept.



whodidit(X,BC)--->  %% tore was killed
    by,
    !,  
    np(X,BC).              %% by john and mary

whodidit(X,BC)--->  
    np1(X, BC) = (w(noun(agent,sin,u,n))),
    !,accept.


%% END PASSIVE




%%%¤ QVERB_PHRASE  ( X,N, S, ComP) 

qverb_phrase(Y,N, S, QNP) ---> % hvilken tid tar det å kjøre buss
    lexv(tv,V,Tense,fin),  
    [det],
    [å],

    clausal_object1(X,SNP)\[noen], %% i.e. clausal_subject

    {traceprint(4,qv0a)}, 
    !,
    verb_phrase(X,N, S, QNP) 
         \  ( lexv(tv,V,Tense,fin), xnp(Y,SNP)). 



 
%% (PREJECT) VERB SUBJECT OBJECT TIL %% TA-101004
qverb_phrase(Z,N, S, QNP) ---> % hvilken holdeplass tar jeg buss 52 til
    lexv(tv,V,_Tense,fin),  
    {V \== ask}, %% \+ rv?? 
    {V \== have}, %% ad hoc  har du besvart 
    subject(X ,SNP),  
    negation0(N),  
    not_look_ahead([om]), %% AD HOC %% TA-110401
    object(Y,OBJ),
       {subject_object_test(V,X,Y)}, %% TA-100905
    w(prep(TO)), 
    not_look_ahead_np,   
    {traceprint(4,qv0b)}, 
    !,
    state(S,QNP) \              
       ( xnp(X, SNP),  
         w(verb(V,pres,fin)),
         xnp(Y,OBJ),
         w(prep(TO)),
         npgap(Z)).



qverb_phrase(Z,N, S, QNP) --->   %% (Hvilken buss) kjører du med
    lexv(iv,V,Tense,fin),        %% TA-100915
    {\+ testmember(V,[think])}, 
    subject(X, NP),  
    negation0(N),
    w(prep(With)), 
 %%%        gmem(With,[to,from,with,past,as]), %% \+ for Å %% TA-110401
    not_look_ahead_np, %% fra sentrum ...   %% TA-101124
    {traceprint(4,qv1)}, 
    !,accept,                 
    {adjustprepv(V,With,OM)}, %% talk past ---> about %% NEW %% TA-110401
    state(S,QNP) \              
       ( xnp(X, NP),  
         w(verb(V,Tense,fin)),   %% TA-110401
         w(prep(OM)),
         npgap(Z)).        
           

qverb_phrase(Y,N, S, QNP ) ---> % Hvilke ting tenker du å gjøre
    lexv(rv,Think,pres,fin),
    subject(X, SNP),    % du
    infinitive,         % å
    w(verb(do,inf,fin)),
    []- xnp(Y,SNP), 
    {traceprint(4,qv2)}, 
    !,
    verb_phrase(X,N, S, QNP )
         \  ( w(verb(Think,pres,fin)),[å], w(verb(do,inf,fin))).


qverb_phrase(Y,N, S, QNP) --->  %% HV OBJECT VERB SUBJECT INDOBJECT
                                 %% hvilken dame 
    lexv(dtv,B,Tense,fin),       %% ba          
    subject(X ,SNP),             %% sjåføren
    ind_object(U,UNP),               %% deg
    omaa,                        %% (om)  å
    {traceprint(4,qv3)},                %% ... besøke
    !,
    []- xnp(Y,SNP),              %% ... hvilken dame
    verb_phrase(X,N, S, QNP) 
         \  ( w(verb(B,Tense,fin)),  %% ba  
              xnp(U,UNP),           %% deg
              [om],                 %% om
              [å]).                 %% å
                                    %% ... besøke


qverb_phrase(Y,N, S, QNP) ---> % hvilken buss tar jeg til dragvoll
    lexv(tv,V,Tense,fin),  
    {V \== ask}, %% \+ rv?? 
    {V \== have}, %% ad hoc  har du besvart 
    subject(X ,SNP),  

    particlev0(V,W), %% vet du om %% TA-110629

    {subject_object_test(V,X,Y)}, %% TA-100905

    {traceprint(4,qv4)}, 
    !,
    verb_phrase(X,N, S, QNP) 
         \  ( lexv(tv,W,Tense,fin), xnp(Y,SNP)). 


qverb_phrase(Y,N, S, QNP) ---> % hvilken buss vil jeg ta 
    aux1,
    negation0(NN), %% TA-110823
    subject(X ,SNP),  
    lexv(tv,V,inf,fin),    
    not_look_ahead([om]), %% AD HOC %% TA-110401 snakke iv|tv
    {V \== have}, %% ad hoc  har du besvart 
       {test(tv_template(V,X,Y,S,_))}, %% \+ hvilken buss passerer  holdeplass 
    {traceprint(4,qv5)},   %% take place ***-> cause fail
    !,                     %% find place -> accept
    verb_phrase(X,N1, S, QNP) 
         \  ( lexv(tv,V,pres,fin), xnp(Y,SNP)),

    {bigno(NN,N1,N)}.
 

qverb_phrase(Y,N, S, QNP) ---> % hvilken kvinne vil jeg bli gift med
    aux1,                 
    subject(X ,SNP),  
    w(verb(be,inf,fin)), %% bli/være
    w(adj2(A,G)),
    w(prep(W)),
    {traceprint(4,qv6)}, 
    !,
    verb_phrase(X,N, S, QNP) 
         \  (w(verb(be,pres,fin)), w(adj2(A,G)),w(prep(W)),xnp(Y ,SNP)).


qverb_phrase(Y,N, S, QVP ) --->   %% hvilken pris har du på bussen ?
    has,                          %% har 
    [du], %% np0_accept(X, NP),   %% du  
                              %*** hvem har bussruter i Ålesund
    negation0(N),        
    prepnom(Om),                   %% om (past) -> regarding
    {traceprint(4,qv7)}, 
    !,
    state(S, QVP ) \ 
        ([du],w(verb(have,pres,fin)), npgap(Y),  w(prep(Om))).


qverb_phrase(Y,N, S,ComP2 ) --->    %% % Hvilken buss har du informasjon om ? 
    has,                           %% har
    np1_accept(X, P::P1), %% du  
    w(noun(Info,_,_,n)),
    prepnom(Om),                   %% om (past) -> regarding
    {traceprint(4,qv8)}, 
    !,
    do_phrase(have,X,N, S,ComP2 ) - 
        (w(verb(have,pres,fin)),  w(noun(Info,sin,u,n)),  w(prep(Om)),  noun_phrase1(Y,P::P1)).



qverb_phrase(Y,N, S,QVP) --->  %% hvor lenge har bussen gått
    has,  
    subject(X, NP1),     
    negation0(N),
    w(verb(Go,Tense,part)), {testmember(Go,[go])}, %% etc 
    defaultprep(Go,Y,With), 
    {traceprint(4,qv9)}, 
    !,
    state(S,QVP) \   
       ( xnp(X, NP1),    
         w(verb(Go,Tense,fin)), 
         prep1(With),  
         npgap(Y)).


qverb_phrase(Y,N, S, QVP) --->  % (hvilke busser) har du kjørt ?
    has,
    subject(X,NP),
    negation0(N),
    w(verb(Run,past,part)), 
    {traceprint(4,qv10)}, 
    !,
    state(S,QVP) \   
       ( xnp(X,NP),    
         w(verb(Run,past,fin)), 
         npgap(Y)).


qverb_phrase(X,N, S, QVP) --->  % (hvor lenge) har bussen gått 
    has,
    np1_accept(Y,NP),
    negation0(N),
    w(verb(Go,Past,part)), 
    {traceprint(4,qv11)}, 
    !,
    verb_phrase(X,id, S,QVP) \  (xnp(Y,NP),w(verb(Go,Past,fin))).


qverb_phrase(Y,N, S, QVP)--->  %% Hvilke språk kan du
    [kan],
    subject(X, NP),             % du
    negation2(id,N),            % ikke 
    not_look_ahead(w(verb(_,_,_))),
    {traceprint(4,qv12)}, 
    !,
    do_phrase(_Do,  X,id, S,QVP)/  % 
        (w(verb(know1,pres,fin)),xnp(Y, NP)). 


qverb_phrase(Y,N, S, QVP)---> %% Hvilken ting  snakker du om (AD HOC)
    w(verb(Talk,Pres,fin)), gmem(Talk,[talk,speak]),   %% TA-110413
    subject(X, NP),             % du
    negation0(N),            % ikke 
    look_ahead(w(prep(_))),
    {traceprint(4,qv13a)}, 
    !,
    do_phrase(_Do,  X,id, S,QVP)/  % svare på
        ( xnp(Y, NP),w(verb(Talk,Pres,fin)),negation(N)).


qverb_phrase(Y,id, S,ComP2) ---> % Hvilken person  vil du være ? %% TA-110615
    aux1,
    subject(X, NPX),
    w(verb(be,_,fin)),

    {traceprint(4,qv15c)}, 
    !,
    state(S,ComP2) \   
       (xnp(X,NPX), w(verb(be,pres,fin)), npgap(Y)). 
       


qverb_phrase(Y,N, S, QVP)---> %% Hvilke språk kan du snakke 
    docan,                      % kan   
    subject(X, NP),             % du
    negation2(id,N),            % ikke 
    {traceprint(4,qv13b)}, 
    !,
    do_phrase(_Do,  X,id, S,QVP)/  % svare på
        xnp(Y, NP). 


qverb_phrase(Y,N, S, ComP2 ) ---> %% hvilke hpl må jeg av (på)
    {constrain(Y,place)}, %% hvilke busser går kl 21::30
    aux1,
    np1_accept(X, P::P1), % jeg
    negation0(N),
    [av],
    {traceprint(4,qv14)},  
    !,
    state(S,ComP2) \   
       ( noun_phrase1(X, P::P1),    
         w(verb(go,pres,fin)), 
         [av],  
        npgap(Y)).


qverb_phrase(Y,N, S, ComP2 ) ---> % Hvilket programmeringsspråk er du skrevet i
    w(verb(be,pres,_)),
    thereit0,
    np1_accept(Du, VP::P),
    negation0(N),
    w(verb(Skrive,Te,part)),
    prep(In),
    {traceprint(4,qv15)}, 
    !,
    state(S,ComP2) \   
      (someone,  w(verb(Skrive,Te,fin)),
       noun_phrase1(Du,VP::P),
    w(prep(In)),npgap(Y)).


qverb_phrase(Y,id, S,ComP2) ---> % Hvem er du sammen med? %% TA-110221
    w(verb(be,_,fin)),
 
    subject(X, NPX),

    w(adj2(Together,nil)),

    w(prep(With)),

    {traceprint(4,qv15a)}, 
    !,
    state(S,ComP2) \   
       (xnp(X,NPX), w(verb(be,pres,fin)), w(adj2(Together,nil)), w(prep(With)), npgap(Y)). 
       

qverb_phrase(Y,id, S,ComP2) ---> % Hvem er du ?
    w(verb(be,_,fin)),
 
    subject(X, NPX),
 
    {traceprint(4,qv15b)}, 
    !,
    state(S,ComP2) \   
       (xnp(X,NPX), w(verb(be,pres,fin)), npgap(Y)). 
       


qverb_phrase(Y,N, S,ComP2) ---> % Hvilket holdeplass er bussen ved ? 
    w(verb(be,_,fin)),
    thereit0,
    np1_accept(Du, NP),
    negation0(N),
    prep(In),
    not_look_ahead_np, %% hva er klokka i Th %% TA-101104
    { In \== towards}, %% = i retning %% Ad Hoc
    {traceprint(4,qv16)}, 
    !,
    state(S,ComP2) \   
       (xnp(Du,NP), w(verb(be1,pres,fin)), 
        prep(In),npgap(Y)).


%% Transitive Prepositional Complement


qverb_phrase(Y,N, S,ComP2) ---> %% Hva  bruker jeg  busstuc til
    lexv(tv,Use,Tense,fin),       % bruke
    {\+ testmember(Use,[pass,be1,be,be2,cost,have,know1])}, %%  Hva er hhh før kl 20 
    np1_accept(X, P::P1),       % tore 
    negation0(N),
    np1_accept(Y, Q::Q1), 
    prep1(With),
    endofline,   
    {traceprint(4,qv17)}, 
    !,
    {\+ testmember(With,[off,of])},       %%  (not AV)
    {test(verb_compl(Use,With,X,Y,_,_))}, 
    state(S,ComP2) \         
       ( noun_phrase1(X, P::P1),    
         lexv(tv,Use,Tense,fin), 
         noun_phrase1(Y, Q::Q1), 
         prep1(With),  
         npgap(Y)).
 

%% InTransitive Prepositional Complement   

qverb_phrase(Y,N, S, ComP2 ) --->  %% hvilken hp kjører buss til

    not_look_ahead([kan]),       %% also iv  know1 
    not_look_ahead(w(verb(be,_,_))), 
    lexv(IV,Go,Tense,fin),       % kjører
    {IV==iv;IV==rv}, 
    {\+ testmember(Go,[pass])}, 
    thereit0,  %% eksister det %% TA-100902
    np1_accept(X, P::P1),       % tore 
    negation0(N),
    defaultprep(Go,Y,With),
    {\+ testmember(With,[off,of])}, %% in? (not AV) %% fins det i Th 
    {test(verb_compl(Go,With,X,Y,_,_))},
    qtrailer0, 
    {traceprint(4,qv18)}, 
    !,
    state(S,  ComP2 )\         
       ( noun_phrase1(X, P::P1),    
         w(verb(Go,Tense,fin)), %% lexv(IV,Go,Tense,fin),  %% dont bind know to rv
         prep1(With),  
         npgap(Y)).


%% Default go nil             %% hvilken dato er dette i morgen ***
qverb_phrase(Y,N, S,ComP2) ---> %% hvilke steder går bussen til 
    {constrain(Y,place)}, %% hvilke busser går kl 21:30
    w(verb(Go,_,fin)),  
    {\+ testmember(Go,[be,take,pass])},
    not_look_ahead([det]), %% ad hoc %% TA-100902
    np1_accept(X, P::P1),       % buss 5
    negation0(N), 
    defaultprep(Go,Y,To),
    {traceprint(4,qv19)}, 
    !,
    state(S,ComP2) \         
       ( noun_phrase1(X, P:P1),    
         w(verb(Go,pres,fin)), 
         prep1(To),  
         npgap(Y)).


%% Hvilket sted går jeg (til) / -- Hvilken buss går 12. aug før --
qverb_phrase(Y,N, S,ComP2) ---> 
    lexv(iv,Go,_Tense,fin), {Go \== be1}, %%  hvilken buss tar jeg til NTH ....
    np1_accept(X, P::P1),       % buss 5
    negation0(N),
    {constrain(X,vehicle)},   
    prep1(To), 
   {testmember(To,[to,from,past,by,on])}, %% not before (1230)
    {traceprint(4,qv20)}, 
    !,
    state(S,ComP2) \         
       ( noun_phrase1(X, P::P1),    
         w(verb(Go,pres,fin)), 
         prep1(To),  
        npgap(Y)).

qverb_phrase(Y,N, S,ComP2) ---> %% hva vil du vite
    (doit),
    noun_phrase1(X, P::P1),
    lexv(Vcat,know1,Tense,fin),
    {traceprint(4,qv21)}, 
    !,  
    verb_phrase(X,N, S,ComP2)
         \  ( lexv(Vcat,know1,Tense,fin), np(Y,P::P1)). 


qverb_phrase(Y,N, S, Com::P2 ) --->  %%   bruker subjekt X (på Y)
    use,
    noun_phrase1(X, P3::P2),
    in_order_to,
    {traceprint(4,qv22)}, 
    !, 
    verb_phrase(X,N, S, (Com::P3) )- (prep(with),npgap(Y)).


qverb_phrase(X,N, S, ComP2 )--->  %% er det ?  
    be,
    thereit2(be), 
%%%     not_look_ahead([til]), %% hvor lenge er det til jul=
                               %% hvilken varighet eksisterer til jul

    not_look_ahead(w(noun(_,_,u,_))), %% ... plass til // siden <----
                                      %% ##¤¤ 
    {traceprint(4,qv23)}, 
    !,
    verb_phrase1(exist,X,N, S, ComP2 )  \  
        w(verb(exist,pres,fin)).  %% exist does not need a complement



qverb_phrase(Z,id, S, SNP ) ---> % hvilken rute går buss  (nil complement)
    {constrain(Z,route)}, %% ad hoc
    lexv(iv,V,Tense,fin), {testmember(V,[go])}, %% ad hoc
    subject(X ,NP1),  {constrain(X,vehicle)}, %% ad hoc
    {traceprint(4,qv24)}, 
    !,
    state( S, SNP ) 
         / (xnp(X,NP1), w(verb(V,Tense,fin)),npgap(Z)).
  

qverb_phrase(Y,N, S, QNP) ---> % hvilken holdeplass passerer buss

    lexv(tv,V,Tense,fin), 
    subject(X ,SNP), 
    {subject_object_test(V,X,Y)}, %% TA-100905
 
    not_look_ahead(w(prep(_))), %% kjører bussen til //not here 
    {traceprint(4,qv25)}, 
    !,
    verb_phrase(X,N, S, QNP) 
         \  ( lexv(tv,V,Tense,fin), xnp(Y,SNP)). 


qverb_phrase(X,N, S, ComP2 ) --->  % hvilket subjekt verb objekt
    look_ahead(w(verb(be,_,fin))),         % hva er rødt
    {traceprint(4,qv26)},   
    !,
    verb_phrase(X,N, S, ComP2 ).   % including be1  


qverb_phrase(X,N, S, QVP) --->  % hvilken ting (hva) skjer
    not_look_ahead(w(verb(be,_,fin))),
    {vartypeid(X,thing)},      
    look_ahead(w(verb(_Happens,_,fin))),
    {traceprint(4,qv27)},  
    !,
    verb_phrase(X,N, S, QVP).   % including be1  


qverb_phrase(Y,N, S, ComP2 )---> % tror du at jeg kan ta -> tar jeg
    w(verb(believe,pres,fin)),
    [du],
    that0,
    noun_phrase1(X, NP1), 
    negation2(id,N),  
    [kan],
    {traceprint(4,qv28)}, 
    !,
    do_phrase(believe,X,id,S,ComP2) - 
        xnp(Y, NP1). 


qverb_phrase(Y,N, S, ComP2 )---> 
    (doit),                         % kan       
    noun_phrase1(X, NP1),       % du
    negation2(id,N),            % ikke 
    redundant0x, %% så allowed here 
    {traceprint(4,qv29)}, 
    !,
    do_phrase(__Do, X,id, S, ComP2 )/  % svare på
        xnp(Y, NP1). 


qverb_phrase(Y,N, S, ComP2 ) ---> %% spurte jeg nettopp om
    lexv(iv,V,Tense,fin),       
{ \+ testmember(V,[know,know1,be1])},     %% hvilken versjon er du *** 
    thereit, %%  ( not hvilke stasjoner passerer bussen) 
    noun_phrase1(X, NP1),
    adverbx0,                     %% spurte jeg nettopp om
    prep0(Prep),                  %% Hvilke dager går det busser (på) ??? prep0
    {traceprint(4,qv30)}, 
    !,
    verb_phrase(X,N, S,ComP2)
         \  ( lexv(iv,V,Tense,fin),prep(Prep),xnp(Y,NP1)).  



% Hvilke spørsmål har du tenkt å  motta %% EXPENSIVE (Ad Hoc)
qverb_phrase(Y,N, S, ComP2 ) --->
    has,
    np1_accept(X, P::P1),    % du
    lexv(rv,_Thought,past,part),     % tenkt
    infinitive,                      % å
    lexv(tv,Take,inf,fin),  
    {traceprint(4,qv31)}, 
    !,
    verb_phrase(X,N, S, ComP2 )
         \  ( lexv(tv,Take,pres,fin),np(Y,P::P1)). 


% Hvilke spørsmål har du mottatt %% EXPENSIVE 
qverb_phrase(Y,N, S, ComP2 ) --->
    has,
    np1_accept(X, P::P1),  % du
    lexv(tv,V,past,part),         % mottatt
    {traceprint(4,qv32)}, 
    !,
    verb_phrase(X,N, S, ComP2 )
         \  ( lexv(tv,V,past,fin),np(Y,P::P1)). 



qverb_phrase(Y,N, S, ComP2  ) --->    %% Hvilken alder

    has,                           %% har
    np1_accept(X, NP1),   %% person
    {has_template(X,Y,_)},    
    {traceprint(4,qv33)}, 
    !,
    do_phrase(have,X,N,S, ComP2  ) - 
        (w(verb(have,pres,fin)),noun_phrase1(Y, NP1)). 


% Prepositional % hvilket språk %% VERY EXPENSIVE 
qverb_phrase(Y,N, S, ComP2 ) --->
    has,
    np1_accept(X, P::P1),  % jeg
    lexv(tv,V,past,part),         % skrevet
    noun_phrase1(Z, Q::Q1),         % deg   
    prep(In), 
    {traceprint(4,qv34)}, 
    !,
    verb_phrase(X,N, S, ComP2 )
         \  ( lexv(tv,V,past,fin), np(Z,Q::Q1),prep(In),np(Y,P::P1)). 

qverb_phrase(X,N, S, ComP2 ) --->  % hvilket subjekt verb objekt
    not_look_ahead(w(verb(be,_,fin))),
    {\+ vartypeid(X,thing)},         %  hva sier katten 
    {traceprint(4,qv35)}, 
    !,
    verb_phrase(X,N, S, ComP2 ).   % including be1  


qverb_phrase(X,N, S, QVP ) --->  % hvilket subjekt verb det ...
    {\+ vartypeid(X,thing)},         %  hva sier katten 
    w(verb(Fins,Pres,fin)),
    thereit0,
    {traceprint(4,qv36)}, 
    !,
    verb_phrase(X,N, S, QVP ) \w(verb(Fins,Pres,fin)).   % including be1  

qverb_phrase(Y,N, S, ComP2 ) ---> % (hvilken tid) %
    lexv(Vcat,V,Tense,fin),     % tar
    thereit,
    npa(X, NP1)=this,
    {traceprint(4,qv37)}, 
    !,
    verb_phrase(X,N, S, ComP2 )
         \  ( lexv(Vcat,V,Tense,fin), xnp(Y, NP1)). 


qverb_phrase(Y,N, S, ComP2 ) --->   % går jeg på bussen ved
    lexv(iv,V,Tense,fin),         % går  \+ mean
    {\+ testmember(V,[think])}, %% iv
    np1_accept(X, NP),  % jeg 
    negation0(N),
    adverbial1(On,Z, SC::P3),       % på bussen
    {traceprint(4,qv38)}, 
    !,accept,                 
    defaultprep(V,Y,At),          % ved (default)
    state(S,ComP2) \              
       ( xnp(X, NP),   % jeg 
         lexv(iv,V,Tense,fin),   % går
         adverbial1(On,Z, SC::P3), % på bussen  
         prep1(At),              % ved
         npgap(Y)).                % Y



%-------------------------------------------------------------------


%% If several verb_modifiers, they are nested first innermost,
%%   and the state is existantiated innermost

%%%¤ VERB_MODIFIERS0  (V,X,S,COMP1,COMP2)

verb_modifiers0(_V,_X,_S,_,_) ---> [hva],!,reject.


%% verb_modifiers0(_V,_,_,CP,CP) ---> look_ahead([så]),!. %% Experiment Hazard 
%%                                                      %% necessary for hvis... så 
%%  meets itself in the inner state (?!)

%%%%  Experimental

%% prep + adverb ==> adverb + prep
%% før i morgen kl 7 ==> i morgen før kl 7
%% "til i nærheten av " ???


verb_modifiers0(V,X,S,Com1P1,Com12P3) ---> % 1-n for be1, otherwise 0-n 
    verb_modifiers(V,X,S,Com1P1,Com12P3).


verb_modifiers0(V,X,S,Com1P1,Com12P3) ---> %% skip redundant adverbials! 
    redundant,
    !,
    verb_modifiers(V,X,S,Com1P1,Com12P3).


verb_modifiers0(V,_,_,CP,CP) ---> 
    {\+ V=be1}. %% be requires a complement.



%%¤  VERB_MODIFIERS  (V,X,S,Com1,Com2) 

verb_modifiers(V,X,S,Com1P1,Com12P3) --->
    verb_modifier(V,X,S,Com1P1,Com12P2),
%%    point0, %% til nth. etter kl 1235. 
              %% til nth. hvilken buss skal jeg ta 
    !,accept, %% <--- hazard fra mamma til klokken. 

    verb_modifiers10(V,X,S,Com12P2,Com12P3).  % last dominates first ?

%%%¤ VERB_MODIFIERS10  (V,X,S,Com1,Com2) 

verb_modifiers10(V,X,S,Com1P1,Com12P3) ---> %% 0-n 
    vmod_conjunction, %% HAZARD     Jeg bor på Nidarvoll og i ettermiddag ...
          %%            bussen går før 1300 men etter 0900
    look_ahead_prepadv, %% HAZARD  jeg bytter buss hvis  jeg skal til  pirbadet og  tar buss 8 
    verb_modifiers(V,X,S,Com1P1,Com12P3). %% 1-n 

verb_modifiers10(go,X,S,Com1P1,Com12P3) ---> %% til risvollan [med] buss 9 
    numberroute,
    look_ahead(w(nb(_,num))),
    !,accept,
    verb_modifiers(go,X,S,Com1P1,Com12P3)\(w(prep(with))).


verb_modifiers10(V,X,S,Com1P1,Com12P3) ---> %% 0-n 
    point,  %% haz ? (remove if trouble).  buenget.munkegaten 
    look_ahead(w(name(_,_,_))),  
    verb_modifiers0(V,X,S,Com1P1,Com12P3). 

verb_modifiers10(V,X,S,Com1P1,Com12P3) ---> %% 0-n 
    verb_modifiers0(V,X,S,Com1P1,Com12P3).  %% allows [] only if not be

verb_modifiers10(_Be,_,_,CP,CP) ---> [].      %% (also be) %% TA-110401

look_ahead_prepadv --->  look_ahead(w(prep(_))),!.
look_ahead_prepadv --->  look_ahead(w(adv(_))),!. 


%%%%¤  VERB_MODIFIER  (V,X,S,Com1,Com2)

%% Problem                    %% til nardosenteret 1730.  %% TA-101019
%%                            %% neste nardo nth          %% TA-100909

%%%%%%%%%%%%%%%%%%%%%% KEEP SEQUENCE!!  


% 5. %% dit = to this place / der = in this place 
verb_modifier(V,X,S,(FCompl and Com1)::Subj,  Com1::Subj ) ---> 
    thisplace(To),   
    not_look_ahead([jegdu]), %% der jeg skal være %% TA-110127
    {verb_compl(V,To,X,Y:place,S,STO)},
    {FCompl= (findexternal(Y:place)::(Y isa place and STO))}.



verb_modifier(V,X,S,  (Compl and Com1)::Subj,Com1::P3 ) ---> %% (Compl and Com1)
    verb_mod1(V,X,S,Compl,Subj::P3). %% TA-110105


             % 0A. i dag -> idag \+ i (en) dag
verb_modifier(V,X,S, (Compl and Com1)::Subj,Com1::Subj ) ---> 
    today,
    !,   
    {adv_compl(V,today,X,time,S,Compl)}. %% time <-> day


verb_modifier(V,_X,_S, VV,VV) ---> 
     particlev1(V), %% dummy effect
     !,accept.


verb_modifier(V,_X,_S, VV,VV) ---> %% ønsker meg
    {testmember(V,[want])}, %% ... 
     reflexiv(V).
                                         

verb_modifier(V,X,S, (Compl and Com1)::Subj,Com1::P3    ) --->    %% die
   {V \== be1},  %% handled elsewhere
   lexv(iv,Sing,pres,part),                    %% singing
   verb_modifier3(Sing,X,Y,Subj,P3),
   {verb_compl(V,during,X,Y,S,Compl)}.


verb_modifier(V,X,S, (Com1 and Compl)::Subj,Com1::P3    ) --->    % this afternoon
    this,
    adverbial(Prep,Y, Subj::P3) \ (prep(in),this), 
    {verb_compl(V,Prep,X,Y,S,Compl)}.


% 4.  (lørdag) kveld
verb_modifier(V,X,S, (Compl and Com1)::Subj,Com1::Subj    ) ---> 
    partday(Today,DayClass,_),                %% (lørdag)... kveld 
    {adv_compl(V,Today,X,DayClass,S,Compl)}.  %% not compl to adverb :-!

%% jeg tar bussen 10 \= jeg tar bussen kl 10
%% jeg tar bussen 24.10.06 -> 24:10 + 06:00
%% jeg tar bussen 25.10.06 -> date(2006,20,25)  // OK



%%% Bogus
verb_modifier(Tell,X,S, ( Compl and Com1)::Subj,Com1::P3    ) --->   %% Moved Last
   nil_compl(Tell),   %% Keep sequence, e.g.  gløshaugen sentrum
   adjunct1(nil,Y, Subj::P3), 
   %% !,  
   {verb_compl(Tell,nil,X,Y,S,Compl)},
   !,accept.  %%% <---!!!  Hazardous, but essential


verb_modifier(Tell,X,S, ( Compl and Com1)::Subj,Com1::P3    ) --->  
   dir_compl(Tell),            %% NEW !
   adjunct1(dir,Y, Subj::P3),
   %% !,
   {verb_compl(Tell,dir,X,Y,S,Compl)}, 
   !,accept.  %%% <---!!!  Hazardous, but essential


%% dyrt å  komme til Risvoillan
verb_modifier(adj/nil/Expensive,X,S,(Compl and Com1)::Subj,Com1 ::KA) ---> 
    infinitive,
    subordinateinfnosubj(nil,coevent,X,T1,Subord), 
    determiner00(T1,Subj, Subord::KA), 
    {verb_compl(adj/nil/Expensive,in_order_to,X,T1,S,Compl)}. 


%%%%%%%%%%%%%%%%

%%¤  VERB_MOD1 (V,X,S,Compl, SEM) 


verb_mod1(V,X,S,Compl,NP) --->  %% jeg er i hamar etter 6 %% TA-110228
         gmem(V,[be1,go,arrive,depart]),    
     w(prep(In)), { testmember(In,[before,after,between])}, 
     plausibleclock(Y,NP),
     !,accept,
     {verb_compl(V,In,X,Y,S,Compl)}.  %% NEW technical prep


verb_mod1(look,X,S,Compl,Subj::P3) --->  %% se gammel ut %% TA-110106
    w(adj2(Old,_Nil)),                   %% AD HOC
    [ut],
    !,
    adverbix(Prep,Y, Subj::P3)= w(adv(Old)),  
    {verb_compl(look,Prep,X,Y,S,Compl)}. %% Unified Function



verb_mod1(V,X,S,Compl,NP) --->  %% nardosenteret er i nardo
         gmem(V,[be1]),         %% TA-100914
     w(prep(In)), {\+ member(In,[between,for])}, %% TA-110104 for vanskelig
     !,
     np1_accept(Y,NP), %% dette  
     {verb_compl(V,In,X,Y,S,Compl)}.  %% NEW technical prep


verb_mod1(V,X,S,Compl,NP) --->  %% bussen kjører som i eksemplet
     [som],
     w(prep(in)),
     !,
     np1_accept(Y,NP), %% dette  
     {verb_compl(V,as_in,X,Y,S,Compl)}.  %% NEW technical prep


verb_mod1(V,X,S,Compl,NP) --->  %% bussen kjører som trikken
     [som],  
     !,
     np1_accept(Y,NP), %% dette  
     {verb_compl(V,as,X,Y,S,Compl)}.


verb_mod1(V,X,S,Compl,CO) ---> %% (lenge(\) er det siden  bussen gikk |  jul OBS
     gmem(V,[exist]),  
     one_of_lit([til,før]),   %% TA-110520
     {vartypeid(X,M), subclass0(M,duration)},
     not_look_ahead(w(name(_Alta,n,place))), %% lenge (langt) til Alta
                                   %%%%% TA-110426 %% til Arvid holme går av
      !,
     clausal_object0(Y,CO),    %% EXPERIMENT   (til) bussen .... går
     {verb_compl(V,until,X,Y,S,Compl)}. %% minutter ekisterer siden hendelse


verb_mod1(V,X,S,Compl,CO) ---> %% (lenge(\) er det siden  bussen gikk |  jul OBS
     {testmember(V,[exist])},  
     [Til], {testmember(Til,[siden])},
     {vartypeid(X,M), subclass0(M,duration)},
     !,
     clausal_object0(Y,CO),    %% EXPERIMENT   (til) bussen .... går
     {verb_compl(V,since,X,Y,S,Compl)}. %% minutter ekisterer siden hendelse


verb_mod1(V,X,S,Compl, VMod) ---> %% (mene noe) om at
     {testmember(V,[mean])},      %% etc 
     [med],[at],
     !,
     clausal_object1(Y, VMod),
     {verb_compl(V,with,X,Y,S,Compl)}.


verb_mod1(V,X,S,Compl,SC::KA) ---> %% be (T)   (om å) ta bussen
     {testmember(V,[ask])},    
     not_look_ahead([nå]),
     look_ahead(w(verb(_Take,inf,fin))),
     !,
     clausal_object1(Y,SC::KA)\ (npgap(X),[vil]), 
     {verb_compl(V,regarding,X,Y,S,Compl)}.


verb_mod1(V,X,S,Compl,CO) ---> %% varsle meg om feilen  ... vedvarer//Garden path
     {testmember(V,[notify,take])},    %% ad hoc (ta kontakt)
     [om],
     not_look_ahead([en]), %% ad hoc speed up 
     !,
     clausal_object0(Y,CO),   
     {verb_compl(V,regarding,X,Y,S,Compl)}.


verb_mod1(adj/nil/Delayed,X, S,Compl,NPZ) --->  %%   forsinket 1 minutt
    {testmember(Delayed,[delayed])},  
    w(nb(One,num)),
    !,
    pp(with,Z, NPZ) \(w(prep(with)), w(nb(One,num))),
    {adj_compl(Delayed,with,X,Z, S,Compl)}. 

%

utenå ---> [uten],ogå,måtte,!. 
utenå ---> [uten],ogå. 

måtte ---> 
    one_of_lit([måtte,ville,skulle,burde,kunne]). %% aux inf 


verb_mod1(adj/nil/Proud,X, S,Compl,NPZ) --->  %% jeg er redd (for at) jeg  må gå
    {testmember(Proud,[afraid,happy])},  %% redd fordi
    foratx0,
    !,
    clausal_object1(Z,NPZ), 
    {adj_compl(Proud,because_of,X,Z, S,Compl)}. 


foratx0 ---> [for],[at].
foratx0 ---> [at].
foratx0 ---> look_ahead_lit([jeg,du,han,hun,vi,dere,de]).


verb_mod1(V,X,S,Compl,NPZ) --->  %% bussen er merket 1
     {testmember(V,[label,be_named])},
     look_ahead_np,
     np0_accept(Z,NPZ),
     {verb_compl(V,with,X,Z,S,Compl)},
     !.

%% ENN    
verb_mod1(V,X,S,Compl,SC::P3) --->  %% (kjører fortere) enn trikken %% Ad Hack!
     { \+ testmember(V,[be,be1,be2])},  %% testmember(rain,snow,be_urgent]),
     [enn],[å],
     !,
     clausal_object1(Y,SC::P3)\[noen], 
     {verb_compl(V,than,X,Y,S,Compl)}.



verb_mod1(V,X,S,Compl,SC::P3) --->  %% enn at ?
     { \+ testmember(V,[be,be1,be2])},  
     [enn],[at],
     !,
     clausal_object1(Y,SC::P3), 
     {verb_compl(V,than,X,Y,S,Compl)}.


verb_mod1(V,X,S,Compl,SC::P3) --->  %% (kjører fortere) enn trikken %% Ad Hack!
     { \+ testmember(V,[be,be1,be2])},  
     [enn],
     np1(Y,SC::P3),
     {verb_compl(V,than,X,Y,S,Compl)}.


verb_mod1(V,X,S,Compl,CO) ---> %% varsle meg før buss xxx |går.
     {testmember(V,[notify,wait])},    %% ad hoc %% TA-110106
     w(prep(Before)), 
        {\+ testmember(Before,[for])}, %% for å.. %% TA-110107
     !, %% only for [notify,wait]
     clausal_object0(Y,CO),    %% EXPERIMENT   (til) bussen .... går
     {verb_compl(V,Before,X,Y,S,Compl)}.


/********* %% TA-110629  %% Experiment!
verb_mod1(adj/nil/Nice,X,S,Compl,SC::KA) ---> %% (dette er) enkelt å lage
     {testmember(Nice,[easy,difficult,nice,good,bad,interesting])}, %% ad hoc
     [å],
     w(verb(Make,inf,fin)),
%%%%%%%%%%%%     not_look_ahead_np, %% det er nyttig å ta buss %% TA-110629
      !,
     clausal_object1(Y,SC::KA)\
          ([noen], w(verb(Make,pres,fin)),npgap(X)),

     {verb_compl(adj/nil/Nice,because_of,X,Y,S,Compl)}.
******/



verb_mod1(adj/nil/Nice,X,S,Compl,SC::KA) ---> %% (det er) hyggelig å høre fra deg
     {testmember(Nice,[nice,good,bad,interested,interesting])}, %% ad hoc
     optional(w(prep(_))), %% i/for/over   ....
     [å],
      !,
     clausal_object1(Y,SC::KA)\ npgap(X), 
     {verb_compl(adj/nil/Nice,because_of,X,Y,S,Compl)}.




overat ---> [fordi].  
overat ---> [av],[at].
overat ---> [over],[at].
overat ---> [til],[at].



verb_mod1(adj/nil/Dep,X, S,Compl, NPZ) --->     %% avhengig av hvilken buss 
     {\+ testmember(Dep,[])}, %% ad hoc    %% som nevnes 
     [av],[hvilken],  %% buss som nevnes
      !,
     np1(Z,NPZ),
     {verb_compl(adj/nil/Dep,of,X,Z, S,Compl)}.



verb_mod1(adj/nil/Proud,X,S,Compl,SC::KA) ---> %% stolt av å 
     {\+ testmember(Proud,[])}, %% ad hoc
     overaa, %%  [av],[å],
      !,
     clausal_object1(Y,SC::KA)\ npgap(X), % hjelpe til
     {verb_compl(adj/nil/Proud,because_of,X,Y,S,Compl)}.


overaa ---> [av],[å]. 
overaa ---> [over],[å].
overaa ---> [til],[å].




verb_mod1(V,X,S,Compl,VM) ---> %% (tar bussen) istedenfor å gå
     {\+ testmember(V,[])},   
     instead_of,
     [å],
     !,
     clausal_object1(Y,VM)\npgap(X), 
     {verb_compl(V,instead_of,X,Y,S,Compl)}.



%%


verb_mod1(V,X,S,Compl,Subj::Subj) ---> %% raskere enn trikken %% ad hoc 
    gradverb0(_Very), %% lettere komisk 
    adverb(Slowly,DayClass,_),    %% = slowlier %% adverb
    {testmember(Slowly,[slowly,fast,thereafter])}, %% etc
    not_look_ahead([det]), %% siden det = subjunction
    {adv_compl(V,Slowly,X,DayClass,S,Compl)}.




verb_mod1(V,X,S,Compl,SC::KA) ---> %% spørre (T) om å
     {testmember(V,[ask])},
     [om],
     [å],  
     !,
     clausal_object1(Y,SC::KA)\npgap(X), 
     {verb_compl(V,regarding,X,Y,S,Compl)}.



verb_mod1(V,X,S,  Compl,SC:: KA) ---> %% hjelpe (til)  (med) å
     {testmember(V,[extend,help])},  
     optional([til]),
     optional([med]),
     [å],  
     !,
     clausal_object1(Y,SC::KA)\npgap(X), 
     {verb_compl(V,with,X,Y,S,Compl)}.


verb_mod1(V,X,S,Compl,Subj::P3) ---> %% WH adverbials 
     xadverbial1(IN,Y, Subj::P3),  
     !,
     {verb_compl(V,IN,X,Y,S,Compl)}. %% HÆ  IN= redundantly


verb_mod1(V,X,S,Compl,Subj::P3) ---> %% om + thing 
    {testmember(V,[talk,speak])},
    look_ahead( [om] ),
    !,accept,
    adverbial1(regarding,Y, Subj::P3),   %% not place 
    {verb_compl(V,regarding,X,Y,S,Compl)}.


verb_mod1(adj/_/Proud,X,S,Compl,Subj::P3) --->  % (jeg er stolt av) " at bussen går " 
    adverbial4(Prep,Y, Subj::P3),        
    {adj_compl(Proud,Prep,X,Y,S,Compl)}. 
  

verb_mod1(V,X,S,Compl,Subj::P3) --->
    {\+ testmember(V,[know,know1,speak,hope])}, %% \ask,\tell \propose 
                                %% TA-110106 %% think  ... tenk (på miljøet) før du skriver ut
    adverbial3(Prep,Y, Subj::P3),   %% subordinate clause %% tell story because
   {verb_compl(V,Prep,X,Y,S,Compl)}.%% NB  adverbial3 may be stacked!
                                    %% hvis trikken står  så foreslår    jeg en buss.



verb_mod1(V,X,S,Compl,Subj::P3) ---> %% vite om 
    {testmember(V,[know,know1,ask,tell,speak,think])},
    look_ahead( [om] ),
    !,accept,
    adverbial1(regarding,Y, Subj::P3),   
    {verb_compl(V,regarding,X,Y,S,Compl)}.



%%   Prep Adv , ADV regarded as time-object

verb_mod1(V,X,S,srel/Prep/time/Adv/S,SC::SC) ---> %% inntil imorgen 
    w(prep(Prep)),   {testmember(Prep,[to,until])}, %% ad hoc
    w(adv(Adv)),     {testmember(Adv,[tomorrow])}, %% ad hoc
    {verb_compl(V,Prep,X,_:time,S,_Anything)}, 
    !,accept.

verb_mod1(V,X,S,Compl,Subj::Subj) ---> %% stacked adverb
    xadverb(Today,DayClass),              
    {adv_compl(V,Today,X,DayClass,S,Compl)}.

verb_mod1(V,X,S,Compl,Subj::P3) --->
    adverbix(Prep,Y, Subj::P3),   
    {verb_compl(V,Prep,X,Y,S,Compl)}. %% Unified Function



verb_mod1(Tell,X,S,  Compl ,Subj::P3    ) ---> %% dette er gule busser|  bussene er gule torsdag

  {\+ testmember(Tell,[go])}, %% nattbuss går buss ???? %% TA-110311

   nil_compl(Tell),   
   adjunct1(nil,Y, Subj::P3), 

   {constrain(Y,time);
    constrain(Y,departure);
     constrain(Y,arrival);    %% ankomst flybuss
      constrain(Y,route);     %% går rute
        constrain(Y,number);  %% 
         constrain(Y,bus)},   %% etc 

   {verb_compl(Tell,nil,X,Y,S,Compl)},
   !,accept.  %%% <---!!!  Hazardous, but essential


%%% 

/* %% Bogus 
verb_mod1(Tell,X,S, ( Compl and Com1)::Subj,Com1::P3    ) --->  %% TA-110311
   nil_compl(Tell),   %% Keep sequence, e.g.  gløshaugen sentrum
   adjunct1(nil,Y, Subj::P3), 
   %% !,  
   {verb_compl(Tell,nil,X,Y,S,Compl)},
   !,accept.  %%% <---!!!  Hazardous, but essential
*/





%%%¤ DIR_COMPL      Transitive verb ala dir complement

dir_compl(Tell) ---> 
    {v_compl(Tell,_,dir,_)}, 
    !,accept. 


%%%%¤¤¤ NIL_COMPL  %% test if possible empty (no preposition) complement

nil_compl(Tell) ---> %% har spørsmål hver dag %% special 
    gmem(Tell,[have]),
    look_ahead_lit([hver]),
    !.

/*  hvilke (nil-) kilometer kjører du   PÅ  søndag %% TA-110429

nil_compl(_) --->  %% -> not_look_ahead(w(name(EBS,n,station) 
%%    not_look_ahead_lit([e,p,m,o]),   %%  (etter) e b schieldrops veg 
%% unnec %% TA-101126
    prep1(_),
    !,reject.
*/



nil_compl(be/Present) --->
    {a_compl(Present,_,nil,_)},  %% filter
    !,accept. 

nil_compl(adj/nil/Present) ---> %% framme onsdag
    {\+ testmember(Present,[])}, 
    !.


nil_compl(adj/nil/Nice) --->
    {\+ post_adjective(Nice)}, %% ad hoc  ferdig kl 13
    !,reject.

nil_compl(go) ---> 
    w(nb(N,num)), { N < 100}, %%   // Was 500   bussen går 0120
            %% til sandmoveien 22 30.7.2004 

    not_look_ahead(w(noun(time_count,plu,u,n))), %%  til Pirbadet 2 ganger 

    not_look_ahead(w(nb(_,num))), % 10 45 = clock // Bus går lørdag  28/5 

    not_look_ahead([':']),    %% i.e. obviousclock

    not_look_ahead(['?']),  
    not_look_ahead(['.']),    %% i.e. obviousclock/obviousdate %% 1 påskedag

    not_look_ahead(['/']),    %% i.e. obviousdate 
    not_look_ahead(['den']),  %% i.e. obviousdate 
    not_look_ahead(w(name(_,_,month))), %% i.e. obviousdate 

    not_look_ahead(w(name(new_years_day,_,date))),   %% nyttårsdag
    not_look_ahead(w(name(whitsun_day,_,date))),     %% pinsedag  
    not_look_ahead(w(name(christmas_day,_,date))),   %% juledag  
    not_look_ahead(w(name(easterday,_,date))),       %% påskedag: NB  no _
 
    not_look_ahead(w(prep(_To_))),  %% TA-110516  buss går (fredag) 13

       not_look_ahead(w(prep(over))),  %%  10 over  = clock 
       not_look_ahead(w(prep(on))),    %%  10 på
       not_look_ahead(w(prep(in))),    %% to i ettermiddag OK

%% except 2 minutes
    not_look_ahead(w(noun(day,_,_,_))),  
    not_look_ahead(w(noun(hour,_,_,_))),     %% not 10 hors
    not_look_ahead(w(noun(minute,_,_,_))),   %% not 10 minutes 
    not_look_ahead(w(noun(second,_,_,_))),   %% not 10 second

    not_look_ahead([om]),     %%  9 om morgenen 

    !,reject.  %% til Olav Nygårds vei 5 ***




nil_compl(Tell) ---> %%   not_look_ahead([e]), %% e b (schieldrops veg) = er buss ()

    {\+ abnormalverb(Tell,_)},  
    {\+ testmember(Tell,[have,be_named])}, %% #* jeg vil ha (buss) 17.mai

    {v_compl(Tell,_,nil,_)}, % almost every verb
    hver0, 
    !,accept. 




%


verb_modifier3(Sing,X,Y,SC, KA)  ---> % du kommer gående
        statreal(P) 
        - (npgap(X),
           lexv(iv,Sing,pres,fin),
           prep(in) , %% the(Y) ,
              w(noun(time,sin,u,n))),
        determiner00(Y,SC, P::KA). 




%%% ADVERBIAL SECTION  

%%%  Unified adverbial/adverb preparation, NOT STACKED


adverbix0(P,Z,ASP) --->
    adverbix(P,Z,ASP),
    !.

adverbix0(redundantly,nil:thing, Subj::Subj) --->
    [].


%%%¤  ADVERBIX (Prep,Y, Compl) %% simple adverbial


adverbix(Old,nil:Mode, Subj::Subj) ---> %% gammel ut %% TA-110506
    w(adv(Old)),                        %% nå går bussen
    {particle(Old,Mode,_Pre)}.


adverbix(redundantly,nil:thing, Subj::Subj) --->
    w(adv(redundantly)),
    !.

adverbix(Prep,Y, Subj::P3) ---> %% ligger NS på risvollan 
     adverbial1(Prep,Y, Subj::P3).     


adverbix(Today,nil:DayClass, Subj::Subj) --->
    gradverbs0(_Gradverb), %% rough, ignore adverb adverb 
    adverbx(Today,DayClass,_). %% <--- x 


adverbix(nil,Y,MSEM) ---> %% natten ( til 2/1)
    look_ahead(w(noun(Night,sin,u,n))),
    gmem(Night,[midnight]),  %% with care, test
    complement_nil(Y,MSEM).


adverbix(nil,Y,MSEM) ---> %% den 30.8 %% Haz %% TA-110531
    [den],
    look_ahead(w(nb(_,_))), 
    complement_nil(Y,MSEM).%% 


adverbial(Prep,TX, SC::FI) ---> 
    adverbial3(Prep,TX, SC::FI).

adverbial(Prep,Y, SC::P3) --->
    adverbial1(Prep,Y, SC::P3).





%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Does NOT  change to substatement word sequence (this is decided already)

%%%%¤¤ PREADVERBIAL


preadverbial0(Prep,X,APS) ---> 
    adverbial1(Prep,X,APS),
    !.
preadverbial0(redundantly,nil:thing, Subj::Subj)  ---> []. %% Ad Hoc 



%% Changes to substatement word sequence, no default





%% (16 minutter) før avgang %% special// SIMPLIFIED

preadverbial1(Prep,X,APS) --->
     w(nb(_N,num)),
     w(noun(minute,_,_,_)),
     look_ahead(w(prep(Before))), {testmember(Before,[before,after])},

     adverbial1(Prep,X,APS),     
     !.

preadverbial1(Prep,X, PQ) ---> 
    not_look_ahead([e]), %% er/ etter
    not_look_ahead_np, %% resten av livet 
    adverbix(Prep,X, PQ).


preadverbial1(nil,X, PQ) ---> %% Ad Hoc
     w(adj2(early,nil)),
     !,accept,
     adjunct1(nil,X, PQ)\
     w(noun(morning,sin,u,n)). %


preadverbial1(before,1200:clock, P::(P and 1200 isa clock)) --->    %% Ad Hoc
      w(noun(morning,sin,u,n)). %% i (morgen) morgen %% (SIC)

preadverbial1(before,1200:clock, P::(P and 1200 isa clock)) --->    %% Ad Hoc
     w(noun(prenoon,sin,u,n)).%% i (morgen) formiddag   

preadverbial1(after,1200:clock, P::(P and 1200 isa clock)) --->     %% Ad Hoc
     w(noun(afternoon,sin,u,n)).%% i (morgen) ettermiddag

preadverbial1(after,1800:clock, P::(P and 1800 isa clock)) --->     %% Ad Hoc
     w(noun(night,sin,u,n)).%% i (morgen) kveld    


%% Fronted nil_compl: Very expensive // kl 1234 skal jeg til NTH

preadverbial1(nil,X, PQ) --->  
    obviousclock1(X,PQ),
    !,accept.

preadverbial1(nil,X, PQ) --->  %%  den  30. mai er det buss .
    obviousdate1(X,PQ),        %%  TA-110527
    !,accept.



%%%¤¤¤  ADVERBIALS0 

%% du sa til meg i stad at du ikke kunne svare på spørsmålet.

preadverbials ---> %% stack advarbials %% TA-101117
    redundant,     %% dont stack redundant
    !,
    preadverbials.
 
preadverbials ---> %% stack advarbials 
    adverbix(Prep,Y, PP), %% 1..n
    !,
    []- xadverbial1(Prep,Y, PP), %% NB, stacked in reverse order
    adverbial_conjunction0, %% TA-110304
    preadverbials0.          %% 0..n


%% EXPERIMENT  Extreme Care 

preadverbials0 ---> 
    preadverbials,
    !.
preadverbials0 ---> [].

/*
adverbials0 ---> 
    adverbix(Prep,Y, PP), %% was adverbial1  %% Haz ?
    !,
    []- xadverbial1(Prep,Y, PP),
    adverbial_conjunction0, %% TA-110304   
    adverbials0.

adverbials0 ---> [].
*/


adverbial_conjunction0 ---> adverbial_conjunction,!. %% TA-110304   
adverbial_conjunction0 ---> [].                      %%

adverbial_conjunction ---> [og],look_ahead(w(prep(_))),!. %% TA-110304   


%%%¤¤¤  ADVERBIAL1 (Prep,Var,Pred)


adverbial1(Prep,Y,SCP) ---> 
    [slik],                 %% bussen går slik jeg ønsker
    !,                      %% = bussen går på måten som jeg ønsker
    adjunct1(Prep,Y, SCP)\
        (w(prep(in)),w(noun(way,sin,def,n)),[som]).
      
%% bussen går dit jeg vil. %% TA-110127
adverbial1(Prep,Y,SCP) --->
    [dit],
    lit_of(J,[jeg,du]), %% dit jeg vil
    !,
    adjunct1(Prep,Y, SCP)\
        (w(prep(to)),w(noun(place,sin,def,n)),[som],[J] ).

    



/** på torsdag kl 10 ...%% TA-101109  TEST
adverbial1(in,D:Day, P::(exists(D:Day)::D isa Day and P)) ---> %% also verb_modifier
    ompa, %% [om],
    w(noun(Day,_,_,n)),
    {testmember(Day,[day,night,evening,morning,afternoon,prenoon,midnight,
                     monday,tuesday,wednesday,thursday,friday,saturday,sunday])},
    !,accept.
*/


adverbial1(ago,X, SCP3) ---> %%  ago
     prep1(for),
     anumber(N), % 1 / en / et / ett
     w(noun(Minute,_,u,n)), %% hours/ 
     [siden],
     !,
     np1(X, SCP3) =  (number(N),w(noun(Minute,plu,u,n))).


adverbial1(in,D:day, P::(exists(D:morrow)::D isa morrow and P)) --->
    tomorrow, 
    !,accept.


adverbial1(Prep,Y, SCP3) --->   
    adjunct1(Prep,Y, SCP3).  


adverbial1(in,D:Day, P::(exists(D:Day)::D isa Day and P)) ---> %% lørdag går bussen
                                          %% after adjunct1 %% TA-110516
    w(noun(Day,_,_,n)),
    {testmember(Day,[monday,tuesday,wednesday,thursday,friday,saturday,sunday])},
    !,accept.

%%%%¤¤¤  ADVERBIAL3 


adverbial3(Nil,T:Cat, SC::KA) --->  %%  for å
    xsubjunction(Nil,Cat,In),
    adverbial_object00(T:Cat,AP1),
    []-adverbial1(In,T:Cat, AP1), %% nec  uten å bytte buss, bytte=transfer
    substatement1(P) 
        \([jeg],aux1),             %% uten å bytte buss, bytte=transfer
    determiner00(T:Cat,SC, P::KA). 


adverbial3(_Prep,_T1, _SCKA) ---> %% før halv 3 %% TA-110520
    [før],
    look_ahead_time, %% \+ halv 3 // not subordinate
    !,
    reject.


adverbial3(Prep,T1, SC::KA) ---> %% .. til=før jeg ...
    [til],
    not_look_ahead([j]), %% j. aees veg 
    look_ahead([jeg]), %% etc  
    !,
    subordinate(Prep,T1,Subord)\ w(prep(to)),
    determiner00(T1,SC ,Subord::KA).


adverbial3(Prep,T1, SC::KA) ---> 
    not_look_ahead([til]), %% most probably prep 
    subordinate(Prep,T1,Subord),
    determiner00(T1,SC, Subord::KA).





%%%%¤¤¤   ADVERBIAL4

adverbial4(Prep,Y,SC::SC and KA) ---> %% våken til bussen går %% TA-110106
    not_look_ahead([om]),
    prep(Prep1),                   
    clausal_object0(Y,true::KA),   %% 21= number
    {adjustprep(Y,Prep1,Prep)}.    %% (av) by -> of              


adverbial4(Prep,Y,SC::SC and KA) ---> %% stolt av at bussen går 
    not_look_ahead([om]),
    prep(Prep1),   
    [at],   
    clausal_object1(Y,true::KA), 
    {adjustprep(Y,Prep1,Prep)}.    %% (av) by -> of              


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%¤ SUBORDINATE   

subordinate(nil,T:coevent,P) --->  %% Special. 
    [de],[samme],[som],   %%     =  slik de er (på)
    adverbial_object00(T:coevent,AP1), %% imbed  = clauses
    substatement1(P) 
        /([de],
           w(verb(be,pres,fin)),   
           adverbial1(nil,T:coevent, AP1)). %% <-- på lørdag


subordinate(_,_,_) --->  %% i stedet for ruter / NOT subordinate
      w(prep(ISO)), {testmember(ISO,[instead_of])}, 
      not_look_ahead_lit([at,å]), 
       !,reject.

subordinate(_,_,_) --->  %% før jul gikk bussen \+ subord 
      not_look_ahead([siden]),
      w(prep(_)), %% prep and subjunc
      look_ahead(w(noun(Xmas,_,_,_))),
      {subclass0(Xmas,time)},
      !,reject.


subordinate(Prep,T,P) --->  
    subjunction(Prep,Category,In), 
    not_look_ahead(w(verb(_Be,_,_))), %% før var det slik at 
    subord_clause(In,Category,T,P). 


%%¤ SUBORD_CLAUSE (In,Cat,T:Cat,P )

subord_clause(In,Cat,T:Cat,P ) ---> 
    adverbial_object00(T:Cat,AP1), %%  imbed  = clauses
    !,  % trikken går når DET går busser 
    substatement1(P) 
        /xadverbial1(In,T:Cat, AP1). %%  x

%%%%

adverbial_object00(W:CO, P:: (exists(W:CO):: W  isa CO and P)) --->  []. 



subordinateinfnosubj(Prep,Reason,X,_T,P) ---> 
    {it_template(X)}, % Det er dyrt å ta buss

    np00(Reason,Y,SC::P3), %% <--- replace and check
    !,
    statreal(P) 
        - (npgap(X),adverbial1(Prep,Y, SC::P3)).

%% TUC er lett å hjelpe -> Noen hjelper TUC 
subordinateinfnosubj(Prep,Reason,X,_T,P) ---> 
    {\+ it_template(X)},
    lexv(tv,Take,_Inf,fin), 
    {testmember(Take,[take])}, %% Ad Hoc
    !, 
    np00(Reason,Y,SC::P3), %% <--- replace and check
    !,
    statreal(P) 
        - (someone,w(verb(Take,pres,fin)),npgap(X),
           adverbial1(Prep,Y, SC::P3)).


%% TUC er snill  å hjelpe -> TUC hjelper noen 
subordinateinfnosubj(Prep,Reason,X,_T,P) ---> 
    {\+ it_template(X)},      
    lexv(tv,Take,_Inf,fin), 
    {testmember(Take,[help])}, %% ad hoc 
    !, 
    np00(Reason,Y,SC::P3), 
    !,
    statreal(P) 
        - (npgap(X),w(verb(Take,pres,fin)),someone,
           adverbial1(Prep,Y, SC::P3)).

%%%%

%% problem if subject+verb lies on stack 
%%   adverbial1 + subject + verb


%%%¤ PARTDAY (part,class,Pred)

partday(Evening,Day,P) ---> %% Special Part day adverbial expressions
    w(noun(Evening,_,_,n)), %% (i morgen) kveld
    {particle(Evening,Day,P)},
    !.

partday(tomorrow,Day,P) ---> %%  I morgen = tomorrow
    to0, 
    prep1(in),
    not_look_ahead([formiddag]), 
    w(noun(morning,_,_,n)), %% I MORGEN
    !,
    {particle(tomorrow,Day,P)}.

partday(tomorrow,Day,P) ---> %%  I morgen = tomorrow
    to0, 
    prep1(in),
    w(noun(morrow,_,_,n)), %% I MORGEN
    !,
    {particle(tomorrow,Day,P)}.

partday(Yesterday,Day,P) ---> %% Special Part day adverbial expressions
    inom(InOm),
    w(noun(Yester,_,_,n)), %% om ettermiddagene 
    !,
    {norpart(InOm,Yester,Yesterday)}, 
    {particle(Yesterday,Day,P)}.




%%%¤  ADVERBX (A C PRE)


adverbx(with,mode,post) ---> %% very touchy %% ta med=bring
     [med],                  %% TA-110128
     not_look_ahead_np,
     !.

adverbx(thereafter,time,post) ---> %% very touchy
    [etter],
     terminatore,
     !.

adverbx(thereafter,time,post) ---> %% very touchy 
    [etter],
    [det],
     !.

adverbx(earlier,time,post) ---> %% very touchy 
    [før],
    [det],
    !.


adverbx(_,_,_) ---> 
    [slik],  %% redundant
    [at],
    !,
    reject. 


adverbx(Honestly,Y,Z) ---> 
    not_look_ahead_prepx , %%  not_look_ahead(w(prep(_før))), %% TA-110128
    w(adv(Honestly)), 
    !,
    {particle(Honestly,Y,Z)}.

not_look_ahead_prepx ---> [med],look_ahead_np,!.      %% TA-110128
not_look_ahead_prepx ---> not_look_ahead(w(prep(_))). %%


adverbx(X,Today,Z) ---> 
    adverb(X,Today,Z).

adverbx(X,Y,Z) ---> 
    partday(X,Y,Z).

adverbx(yesterday,Y,Z) ---> 
    prep1(in),
    [går],
    !,
    {particle(yesterday,Y,Z)}.



anyadverb0 ---> 
    therenot0,
    adverb(X,Y,Z),
    !,
    []- adverb(X,Y,Z).
anyadverb0 ---> 
    therenot0.

adverbx0 ---> w(adv(redundantly)),!. 
adverbx0 ---> 
    not_look_ahead(w(noun(_Error,sin,u,n))), %% har jeg feil = feilaktig
    not_look_ahead(w(prep(_))), %% før = earlier
    adverb(X,Y,Z),
    {\+ testmember(X,[home])}, %% går bussen hjem => hoq bussen hjem går 
   !,
    []-adverb(X,Y,Z).

adverbx0 ---> [].


%% ADVERBS ARE VERB MODIFIERS 

adverb0(Fast,Mode,P) --->
     adverb(Fast,Mode,P),
     !.
adverb0(redundantly,thing,post) ---> []. %% return redundantly if []


%%¤ ADVERB (NAME,CLASS,PREPOST)

adverb(delayed,time,post) ---> 
     w(adj2(delayed,nil)),          %% for sent
     !.

adverb(Fast,Mode,P) ---> 
    gradverb0(_),                     %% dummy   "so",  
    not_look_ahead([siste]), %% sist ok %% Problem 
    w(adj2(Fast,nil)),
    {particle(Fast,Mode,P)}.

adverb(now,Mode,P) ---> 
    prep1(with), 
    detsamme,  
    {particle(now,Mode,P)}.

adverb(first,time,_P) ---> [først]. 

adverb(today,day,pre) ---> % (i dag) 
    prep1(in),
    w(noun(day,sin,u,n)).

adverb(tomorrow,day,pre) ---> % (i morgen)
    prep1(in),
    [morgen].

adverb(day_after_tomorrow,day,pre) --->  % (i overimorgen)
    prep1(in),
    [overimorgen].

adverb(day_before_yesterday,day,pre) ---> % (i forgårs) 
    prep1(in),
    [forgårs].

adverb(tonight,daypart,pre) ---> %% i Natt
    prep1(in),
    w(noun(night,_,_,_)). 

adverb(today,day,pre) ---> %% i dag
    prep1(in),
    w(noun(day,_,_,_)).  

adverb(locally,place,post) ---> 
    [lokalt].

adverb(_,_,_) ---> 
    w(prep(_)),
    look_ahead_np,
    !,reject.


adverb(Today,Day,P) --->  %% LOOP   preadverbials stack adv... %% TA-101117
    particle(Today),        
    {particle(Today,Day,P)}. %%
%%     da0.      ... da jeg skulle til byen  %%   Norwagism (nå da')



adverb(Today,Day,P) ---> 
    particle(Today),   
    {testmember(Today,[on,off])},      %% i.e. prepositions
    not_look_ahead(w(noun(_,_,_,_))),  %% på kvelden
    not_look_ahead(w(name(_,_,_))),    %% på nth 
    {particle(Today,Day,P)},
    da0.                     %%   Norwagism (nå da')


%%% PARTICLES %%%


%% PARTICLES ARE NOT VERB MODIFIERS (AS ADVERBS ARE)
%% CHANGES  VERB, OR ARE MANDATORY BUT WITHOUT EFFECT

%% particlev1(Verb) ---> particle(<--->). %%  Dummy
%% particlev2(SyntVerb,SemVerb) ---> particle(<--->). %% Changes verb

%%%¤ PARTICLEV0 

particlev0(Give,Resign) ---> 
    particlev2(Give,Resign),
    !.
particlev0(List,List) ---> 
    particlev1(List).

particlev0(List,List) ---> [].


particle0(P) ---> particle(P),!. 
particle0(_) ---> [].

%%%¤ PARTICLEV1  (Verb) 


%% Dummy effect, but grammatically necessary 

particlev1(believe)  ---> [på].   %% tro på

particlev1(calculate) ---> [med]. %% regne med



particlev1(check)  ---> [opp]. 

particlev1(come)   ---> [med], not_look_ahead_np.   %%  ? Haz
particlev1(come) ---> [til],not_look_ahead_np.  
particlev1(come) ---> [opp]. 

particlev1(correct) ---> [opp].   %%  rette opp

particlev1(fetch) ---> [ned]. %% laste 
particlev1(fetch) ---> [opp]. %%

particlev1(find)    ---> [ut],[av]. %% TA-101112

particlev1(get) ---> [med].  
particlev1(get)  ---> [opp]. 

%% particlev1(go)  ---> [med].   %% HAZARD 
particlev1(have) ---> [på].      %% TA-110103

particlev1(help) ---> [til],[med].
particlev1(help) ---> [til]. 

%% particlev1(know1) ---> [om]. %% intressant å vite om bussen går 

particlev1(improve) ---> [inn]. %% skjerpe inn 

particlev1(indicte) ---> [på]. %% Norw tyde på
particlev1(lay) ---> [inn].    %% legge inn 
particlev1(lie1) ---> [med]. 

particlev1(name) ---> [til]. %% omdøpt til %% TA-110707

particlev1(reach) ---> [til]. %% TA-110419
particlev1(reach) ---> [fram],[til]. %% fram til=til Dict %% TA-110419

particlev1(read) ---> [gjennom].    %% TA-110105
particlev1(receive)  ---> [opp].    %%  (får opp (på skjerm))
%particlev1(get)  ---> [opp].   %% DUPLICATE  

particlev1(send)  ---> [med]. 
particlev1(send)  ---> [over].
particlev1(send)  ---> [ved]. 
particlev1(sing)  ---> [ut].   %% Example Synge ut

particlev1(take) ---> [ut].  %% TA-101124
particlev1(throw) ---> [av]. %% av ignored

particlev1(tell)   ---> [inn]. 
particlev1(tell)   ---> [om]. 
particlev1(tell)   ---> [fra],[om],!.  
particlev1(tell)   ---> [fra].%% si fra
particlev1(tell)   ---> [ifra]. %% TA-110724
particlev1(tell)   ---> w(prep(regarding)). 
                        %% stacked as such

%% particlev1(think)   ---> [på].  %% TA-110623// jeg tenkte på deg
           
particlev1(wonder)   ---> [på]. %%  NB particlev2(fool on) lure på

particlev1(write) ---> [inn].




%%%%¤¤ PARTICLEV2 (Verb, NewVerb)

%% particlev2(answer1,resemble) ---> [til]. %% jeg har svart tilbake til

particlev2(avoid,release) ---> [fri]. %% slippe fri %% TA-110330

particlev2(be,come) ---> [med]. %% være med

particlev2(belong,belong_to) ---> [til]. %% TA-110707 sogner til
particlev2(hear,belong_to) ---> [til].   %% TA-110707 hører til

particlev2(calculate,expect) ---> [med].

particlev2(care1,ensure) ---> [for]. %% sørge for 

particlev2(come,appear) ---> [fram]. %% TA-110504

particlev2(come,disappear) ---> [bort], %% Haz, bussen kom bort til
                      not_look_ahead(w(prep(to))). %% .. ved en feil
particlev2(comment,remove) ---> [ut]. %% kommentere ut=fjerne %% TA-101102

particlev2(do1,finish) ---> [ferdig].
particlev2(do1,make) ---> [meg]. %% gjøre meg tanker

particlev2(find,do1) ---> [på]. %% finne på %% TA-101112

particlev2(find,discover) ---> [ut]. %% TA-110309 


particlev2(fool,wonder) ---> [på]. %% lure på

particlev2(go,stop) ---> [ned]. %%  experiment  go,go

%% particlev2(get,receive) ---> [inn]. %%  get supersyn

particlev2(get,manage) ---> [til].   %%  får til

%% particlev2(have,use)  ---> [på].  %% ha på mobilen/frakken  
                                     %% har jeg feil på maskinen
particlev2(have,bring) ---> [med].   %% TA-101125

particlev2(hold,be)  ---> [deg]. %% TA-110104
particlev2(hold,be)  ---> [meg]. %%
particlev2(hold,be)  ---> [seg]. %%

particlev2(hold,do1)  ---> [på],[med]. 

particlev2(hold,be1)  ---> [til]. 

particlev2(hold,wait) ---> [ut]. 

particlev2(improve,ensure) ---> [inn]. %% "skjerpe inn"

% particlev2(lay,input)  ---> [inn].

particlev2(lay,include)  ---> [inn]. %% TA-110504

particlev2(lay,include)  ---> [på]. %% legger på  T:KORT Periode.   %% ad hoc

particlev2(lay,enclose) ---> [ved]. %% TA-110429                                  

particlev2(lay,stop)  ---> [ned].  %%  lagt ned
particlev2(lay,change)  ---> [om]. %% 

particlev2(lead,cause) ---> [til]. 

particlev2(lie1,belong_to) ---> [under]. %% TA-101102 ? admin

particlev2(list,list)    ---> [opp].

particlev2(long,want) ---> [etter]. %% lengte etter/ivre etter %% TA-110329

particlev2(look,appear)    ---> [ut]. %% TA-101210

particlev2(meet,meetup)    ---> [opp]. %%  Technical, \+ arrive (bus)

particlev2(negotiate,discuss) ---> [om]. %% TA-110707

particlev2(operate,do1) ---> optional([på]),[med]. %% TA-110309 drive på med

particlev2(pay,pay2)    ---> [seg]. %% lønne seg

particlev2(put,arrange)    ---> [opp]. %%  sette opp

%% particlev2(put,expel)    ---> [av] %%  no bli satt_av av sjåføren

particlev2(say,tell) ---> [fra]. 
particlev2(say,tell) ---> [ifra]. %% TA-110724

particlev2(see,appear)     ---> [ut]. %% TA-101210
%% particlev2(see,exist) ---> [ut].  %% Ad Hoc koden ser slik ut %% TA-101102

particlev2(stand,indicate) ---> [for]. %% hva står BussTUC for=bety %% TA-110112

particlev2(take,bring)    ---> [med]. %% TA-110128

particlev2(take,manage)    ---> [over]. %% tok over %% TA-100905

particlev2(take,get)    ---> [til],rfxpron. %% /jeg tar til seg /ok

particlev2(take,get)    ---> [mot].     %%  (+imot)
particlev2(take,get)    ---> [imot].  
particlev2(take,get)    ---> [i],[mot]. 

particlev2(take,treat)    ---> [opp]. %% ta opp = behandle 

particlev2(turn,stop) ---> [av].  
particlev2(turn,start) ---> [på]. 

particlev2(write,print) ---> [ut].

% 


rep_particlev0(V)   ---> rep_particlev(V),!.
rep_particlev0(_)  ---> []. %% 

rep_particlev(ask) --->     [':'],!. 
rep_particlev(deny) --->    [for]. 
rep_particlev(wonder) --->  [på],which0,!,accept.  %% Norwagism
rep_particlev(know) --->    prep1(to),!,accept. %% kjenne til
rep_particlev(find) --->    [ut]. 
rep_particlev(recognize) ---> [til]. %% kjenne til 
rep_particlev(think) --->   [på],not_look_ahead([om]),!,reject.  %% Norwagism
rep_particlev(think) --->   [på],not_look_ahead([at]),!,reject.
rep_particlev(think) --->   [på],!,accept.



%% particle(SemPart) ---> [<synpart>].

%%%¤¤  PARTICLE    (single adverb)

particle(redundantly) ---> redundant. %% Redundant except grammatically nec

particle(Badly) ---> w(adv(Badly)),!.


%% particle(at_home) --->   [hjemme]. %% adv
particle(back) --->      [tilbake]. 

particle(badly) --->     [dårlig]. 

particle(beforethat) ---> beforethat. 

particle(daily) --->     [daglig].  
particle(day_after_tomorrow) ---> [overimorgen]. 

particle(directly) --->  [direkte].  
particle(down) --->      [ned]. 
particle(down) --->      [under].  

particle(earlier) ---> earlier. 

particle(early) --->    
   [så],[tidlig],[som],w(adj2(possible,nil)),!,accept. 
particle(early) --->    
   [tidligst],w(adj2(possible,nil)),!,accept. 
particle(early) --->     [tidlig]. 
particle(early) --->     [am]. %% 820 am must be early

particle(eastward) --->  [østover]. 
particle(everywhere) ---> [overalt].

particle(far) ---> [langt]. 

particle(fast) --->      [fort].  
particle(fast) --->      w(adj2(fast,comp)). 

% particle(fast) --->      w(adj2(fast,sup)). %% ==> particle(hereafter) collision 

% particle(freely) ---> [gratis].   %% Er bussen som går til IKEA
                                     %% gratis (adj)? 
                                      
% particle(from) --->      [fra].   %% hvor går bussen fra i sentrum %% (Hazard)

particle(from) --->      [ifra].   %% NB Subtle  Jeg sier ifra 
particle(gratis) --->      [gratis]. %% Techn, also E
particle(home) --->     [hjem],prep1(to),!,reject.     %% Ad hoc
particle(home) --->      to0,[hjem]. 
particle(here) --->      to0,[hit].  
particle(here) --->      to0,[her].  

particle(hereafter) ---> hereafter.  %% before fast (fastest possible)

particle(in)  --->       [inn]. 
particle(in_morning) ---> [ommorgenen]. 
particle(late) --->       so0,   [sent]. 
particle(late) --->      too,[sent].
%   particle(last) --->      [sist].  %% not reduncant 

particle(lay)  --->      [ut].  %% legge ut 
particle(lay)  --->      [inn]. %%
particle(lay)  --->      [ved]. %%

particle(logically) ---> [logisk]. 

particle(much) ---> so,[mye]. %% // so0 
particle(normally) ---> [normalt]. 
particle(northward) ---> [nordover].  
particle(now) --->       now1.
particle(now) --->       prep1(for),[øyeblikket]. 
%% particle(now) --->       [da]. %% ( not now1) når skal jeg dra da 

particle(on) --->        prep1(on).  %% hazard ?
particle(off) --->       [av].       %% hazard ?
particle(offside) --->   and0,compassly. 
particle(often) --->     so0,  [ofte]. 
particle(recently)    ---> recently. 
particle(out) --->       [ut]. 

particle(past) --->      [forbi].          %% bussen går forbi på rosten
particle(present) --->   [framme].

particle(punctually) ---> [presis].         %% er bussen min presis 
particle(punctually) ---> w(adj2(punctual,nil)).

particle(punctually) --->  prep1(in), [tide].%%  i tide 

particle(regularly) ---> [som],[normalt]. %% NB not delay 

%% particle(regularly) ---> [som],w(adj2(ordinary,nil)). 
%% ble gjenkjent som vanlig navn   

particle(silent) ---> [stille]. %% stå/stille , gå/stille rough 

particle(simultaneously) ---> [samtidig]. 
particle(slowly)    ---> [langsomt]. 
particle(somewhere) ---> [noensted].  
particle(southward) ---> [sørover].

particle(there) --->     [dit]. %% telebuster %%? %% TA-110127

particle(there) --->     [der]. 
particle(there) --->     w(adj2(present,nil)). %% [fremme]

particle(thereafter) ---> thereafter. %% usually anaphoric

particle(this_midnight) ---> [inatt].
particle(today) --->     [idag]. 
particle(together) --->  [sammen]. 
particle(tomorrow) --->  [imorgen]. 
particle(tonight) --->   [ikveld].

particle(up)    ---> [opp]. 
particle(well)  ---> [bra]. 
particle(well)  ---> [best]. %%   (Roughly)
particle(well)  ---> [vel]. 
particle(westward) --->   [vestover]. 
particle(with1)    --->  [med], %% Norwagism 
    not_look_ahead(w(name(_TS,_,_))). %% med toget # 
          
particle(wrongly) --->  saa0,  [feil]. 
particle(yesterday) ---> [igår].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%¤¤¤  ADJUNCT1 (Prep, Var, Sem)  


adjunct1(Nil,Y, SC::P3) ---> %% Buss går   20. minutt
    {Nil == nil},            %% 20 minutter senere 
    w(nb(Five,_Ord)),
    point0,
    w(noun(Min,_,u,n)),  %% TA-101125
        {testmember(Min,[year,month,week,day,hour,minute,second , 
         mile,kilometer,meter])}, %% TA-110429
    !,
    np0_accept(Y,SC::P3) =   (w(nb(Five,num)),    w(noun(Min,sin,u,n))), 
    !,accept.

adjunct1(after,COX, CONP) ---> %% jeg klager etter å ha ventet
    w(prep(after)),  
    [å],                        
    !,
    clausal_object1(COX, CONP)/([noen],aux1). %% ad hoc


adjunct1(when,COX, CONP) ---> %% om når bussen går
    [om], 
    [når],
    !,
    clausal_object1(COX,CONP).


adjunct1(where,COX, CONP) ---> %% om hvor bussen går 
    [om], 
    [hvor],
    !,
    clausal_object1(COX,CONP).
 
adjunct1(regarding,COX, CONP) ---> %% om at bussen går
    [om], 
    [at],
    !,
    clausal_object1(COX,CONP).

 
adjunct1(with,Y,CO) ---> %% (med ) det å ta bussen
   [med], 
   [det],[å],
   !,
   clausal_object1(Y,CO)\(someone,aux1). %% 

                              

adjunct1(_,_, _) ---> 
    [hva],!,reject. 

%% Complex Passover Meningen ME livet   ME = med/meg/
%% jeg får besøk de neste dagene  OK

%% Moved before clock   buss lørdag 11.11 går 
%                       buss går lørdag 11.11

adjunct1(_,_,_) --->     %% i morgen \= in (a) morning !
     prep1(in),               %% Pragmatix  
	  w(noun(morning,_,_,_)),
     !,
     reject.


    

adjunct1(Nil,Y, SC::P3) ---> %% ( Buss går     09.12 => clock ) at -> nil
    {Nil == nil},
    !,
    complement_nil(Y, SC::P3).

adjunct1(ago,X, SC::P3) ---> %%  ago
     prep1(for),
     anumber(N), % 1 / en / et
     w(noun(Minute,_,u,n)), %% hours/ 
     [siden],
     !,
     np0_accept(X, SC::P3) =  (number(N),w(noun(Minute,plu,u,n))),
     !.


adjunct1(after,Y, SC::P3) --->  %% om en times tid
    [om], %% prep1(during2),             %% om 
    anumber(N),                 %% en (1)
    w(noun(Hour,_,u,gen)),      %% time(r)s (minutts/etc.)
    w(noun(time,sin,u,n)),      %% tid
    !,
    np1(Y, SC::P3) \  (number(N),w(noun(Hour,sin,u,n))).

adjunct1(in,Y, NP) ---> %% i 2009 %% most probably a year
    prep(in),        
    w(nb(YYYY,num)), 
       {1000 =< YYYY, YYYY =< 9999},
        not_look_ahead(w(noun(time,_,_,_))), %% tiden 
     !,
     np1(Y,NP) = (w(noun(year,sin,u,n)), w(nb(YYYY,num))).


adjunct1(around,XC, SCP3) --->
    prep1(In), {testmember(In,[in,at,around])}, %% to* til means before 
    ca0,  
    clock_kernel(XC,Eight), %% 08.00 tiden   % 5-
    point0,  
    not_look_ahead(w(noun(_,_,_,_))), %% i et sted 
    !,
    raise_object00(Eight,SCP3). 



adjunct1(_,_,_) ---> 
     [med],[en],[gang],   %% Adverbial
     !,
     reject.


adjunct1(between,(X1,X2):clock, SC::SC and P1 and P2 ) ---> % mellom 8 og 9
     prep1(between),                                          % Special
     clock0, 
     clock_kernel(X1:clock,P1),
     betwand0, %% og å 
     clock0,
     clock_kernel(X2:clock,P2),
     !,accept.


adjunct1(between,Y, SCP3) ---> 
    prep1(between),
    noun_phrases2(Y, SCP3),  
    !,accept. 


adjunct1(Prep,Y, SCP3) ---> %% om morgenen
    [om], %% not mix om=past= after
    not_look_ahead_subject, %% TA-101109 ([man,jeg,vi]),
    !,
    np(Y,SCP3), 
                          %% til dragvoll torsdag etter kl 1230.
   {adjustprep(Y,om,Prep)}. %% TA-110429 %% om <tid>=during2 %%  om saker=regarding
                                 %% om alder = regarding!

adjunct1(Prep,Y, SCP3) ---> 
    pp(Prep,Y, SCP3).

adjunct1(Dir,Y, SCP3) --->   %% tuc starter () sommerruter
    {Dir==dir},                %%  == same as transitive object
    noun_phrase1(Y, SCP3). 


%%%¤¤ PP   Prepositional Phrase
 
%% Jeg baserere bussoraklet på at

pp(on,Y, NPZ) ---> %% TA-110708
    prep(on),  
    [at],
    clausal_object1(Y,NPZ).
 
                           


pp(as,Y, YNP) ---> %% som meg 
    [som],
    look_ahead_lit([meg,deg,ham,henne,oss,dem]), 
    !,
    np(Y,YNP). 


pp(Prep,Y, SCP3) ---> %% om jeg \+ pp
    look_ahead([om]),
    prep(Prep),  
    not_look_ahead([jeg]), 
    np(Y,SCP3). 


pp(_Prep,_Y,_) ---> 
    [før], %% subjunction
    [det],
    !,reject.

%% Hva skal du ha til middag? = hva skal du ha til ved middagstid
pp(Prep,Y, NPZ) ---> 
    not_look_ahead_lit([om]),  %% TA-101022  ?
    prep(Prep1),  
    redundant0, %% videre 
    object(Y,NPZ), %% \+ jeg // NB xnp ? 
   {adjustprep(Y,Prep1,Prep)}. %%% after -> from if place 
                               %% not at 8 (route) 

%% after til 3T 
pp(Prep,Y, SC::SC and P3) ---> %% etter 17.10 ==> most probably clock 
    prep(Prep), 
   {testmember(Prep,
    [before,after,around,to,over,within])},  %% T  Rundt 4 (\=rute 4) 
    not_look_ahead([et]),                    %% \+ til (kl 1) 
    not_look_ahead([en]),                    %% 
    clock_kernel(Y,P3),                      %% før 12.10 
    not_look_ahead(w(noun(station,_,_,_))),  %% til 500 hpl 
    not_look_ahead(w(noun(hour,_,_,_))),     %% etter 2 timer
    not_look_ahead(w(noun(minute,_,_,_))),
    !,accept.


%%%¤¤ COMPLEMENT_NIL (FF, MM) 


complement_nil(FF, MM) ---> %% (bussen går) 10 minutter før trikken |stopper
    w(nb(N,num)),  
    w(noun(minute,_,_,_)),
%%    w(prep(Before)), 
    subjunction(Before,  time,_), %% før| etter at
    !,
    clausal_object0(Y,CNP),
    np1(FF,MM) =  
          (w(nb(N,num)), w(noun(minute,plu,u,n)),
           w(prep(Before)),xnp(Y,CNP)).


complement_nil(Y, CNP) ---> %% (bussen går) 10 minutter (etter)
    w(nb(N,num)),  
    w(noun(minute,_,_,_)),
    look_ahead(w(prep(_))), 
    !,
    noun_phrase1(Y, CNP) =  
         (w(nb(N,num)),w(noun(minute,_,_,_))).   


complement_nil(Y, VPP) ---> %%  til Brundalen kl 0930. 
    obviousclock(Y,VPP).    %% avoid  går klokken(et klokkeslett) + (kl) 0930.


complement_nil(Y, NP1) ---> 
    w(prep(nil)), %% ad hoc
    !,
    noun_phrase1(Y, NP1).  

complement_nil(Y, SC::P3) ---> %% sentrum risvollan nattbuss 
    w(noun(Nightbus,_,_,n)),
    {testmember(Nightbus,[nightbus,summerroute,winterroute])},
    !,accept,
    adjunct1(_,Y, SC::P3) =
    (w(prep(with)),w(noun(Nightbus,sin,u,n))).



complement_nil(_, __) --->  %% den = bussen, moved after obviousdate

%%  not_look_ahead([man]),  %%  w(noun(monday,sin,u,n))), 
%%  man =    mandag (abandoned) 

    not_look_ahead(w(noun(street,sin,u,n))), %% gå [singsaker] gate
    not_look_ahead([den]),  %% .. den neste timen
    not_look_ahead([det]),  %% d. l. øvrelidsv 
%%%%%%unnec    not_look_ahead([j]),    %% j \= jeg %% j falkbergets vei = jeg 
    not_look_ahead(w(prep(with))), %% me = med (dial)
    pronoun1(_),  
    !,reject. 


complement_nil(Y, VP::VP and P3) ---> 
    plausibleclock1(Y,P3).          %% 10.10

complement_nil(Y, SC::P3) ---> %% ( Buss går     09.12 date )
    obviousdate(Y, SC::P3),    %% moved after obviousclock 
    !.

complement_nil(Y,  SC:: SC and P3) ---> %% ( Buss går     09.10 => clock )
    plausibledate1(Y, P3).    %% moved after obviousclock 


complement_nil(Y, SC::P3) ---> 
    look_ahead(w(adj2(Adj,nil))), gmem(Adj,[short,long]),
    !,
    noun_phrase1(Y, SC::P3).  

complement_nil(M,T) ---> %% (til pirbadet) 2 ganger
    w(nb(N,num)), 
    w(noun(time_count,Sin,Def,Nog)), 
    !,
    np0(M,T)=  (w(nb(N,num)), w(noun(time_count,Sin,Def,Nog))).



complement_nil(_,_) ---> %% (bussen går) 10 minutter etter
    not_look_ahead(w(name(_TreT,_,_))), %% 3T Rosten 
    w(nb(_,num)),                 %%  første OK
        not_look_ahead([ganger]), 
        not_look_ahead(w(noun(hour,_,_,_))),
        not_look_ahead(w(noun(minute,_,_,_))),
        not_look_ahead(w(noun(second,_,_,_))),
    !,reject.

complement_nil(Y, NP) ---> %% expensive ? hazardous 
    not_look_ahead(w(nb(_,_))), %%  Bussen går 4 \= route 4
    not_look_ahead(w(_august,name(_august,_,month))), %% bus goes  august 

    not_look_ahead_lit([sin,sitt,sine]), 

    not_look_ahead(w(noun(hour,plu,u,n))),    %% gå (to) timer 
    not_look_ahead(w(noun(minute,plu,u,n))),  %% gå (to) minutter
    not_look_ahead(w(noun(second,plu,u,n))),  %% ..
    not_look_ahead(w(noun(room,_,u,n))),      %% sent rum 
    object(Y, NP),    
    !.

complement1_accept(Prep,Y, SEM) --->  
    [idag],
     !,
    complement1_accept(Prep,Y, SEM) \(prep(in),w(noun(day,sin,u,n))),
    !.

complement1_accept(Prep,Y, SC::P3) ---> 
    prep(Prep), %% om bussruter
    {\+ testmember(Prep,[of,between])}, 
    not_look_ahead([jeg]),    %% Ad Hoc   om jeg skal være ....
    not_look_ahead([man]),    %%
    noun_phrase_accept(Y, SC::P3),
    !,accept.   



%%%%%%%%%-------------------------------%%%%%%%%%%%%%%%%%%%%%%%%%

%%%¤ PLAUSIBLEDATE1   

plausibledate1(YDate:date, YDate isa date) ---> %% 2009-05-17
    num_na(YYYY),
    {YYYY >= 1000, YYYY =< 9999},
    dashpoint0,    
    num_na(MM),  
    {MM >=1, MM =< 12}, 
    dashpoint0,    
    num_na(DD),   
    {DD >=1,  DD=<31}, %% no legal check here
    !,accept,
    {YDate = date(YYYY,MM,DD)}.


plausibledate1(YDate:date, YDate isa date) ---> %%  17.5  TA-110406
    num_na(DD),   
    {DD =<31},
    slashpoint0,    
    num_na(MM),  
    {MM =< 12}, %% , mod(MM,5) \= 0}, %% 23.10 -> clock %% Hazard

    {this_year(YYYY)},
    !,accept,
    {adjust_year(MM,YYYY,YYY1),YDate =date(YYY1,MM,DD)}.

/*  buss går til sentrum 13 %% TA-110518
plausibledate1(YDate:date, YDate isa date) ---> %% last with care Fredag 13
    num_na(DD),                                 %% TA-110516
    {DD =<31},
    slashpoint0,  
    not_look_ahead(w(nb(_,_))), %% etc 
    {todaysdate(date(YYYY,MM,_)), 
     YDate =date(YYYY,MM,DD)}.
*/


%% N: bussen går (mandag) 22.  // after mandag/ 22 is a date


%% A date by its own syntax

%%%¤  OBVIOUSDATE   lambda level

obviousdate(DateT, SC::DateP and SC) ---> 
    obviousdate1(DateT,DateP).

%%  adjust_year(M01,YYYY,YYY1) :-

%%%¤ OBVIOUSDATE1   


obviousdate1(Date:date,Date isa date) --->   %% (til) 25. jan 2011
     point0,    %% slip %% TA-110527
     dayno(DD), 
     slashpoint0, 
     monthname(MM), %% Aug -> 08
     xyear0(MM,YYYY),
     !,accept,    
     {Date=date(YYYY,MM,DD)}. 


obviousdate1(YDate:date, YDate isa date) ---> %% 2009-05-17
    point0,    %% slip %% TA-110527
    num_na(YYYY),                             %% also plausibledate1
    {YYYY >= 1000, YYYY =< 9999},
    dashpoint0,    
    num_na(MM),  
    {MM >=1, MM =< 12}, 
    dashpoint0,    
    num_na(DD),   
    {DD >=1,  DD=<31}, %% no legal check here
    !,accept,
    {YDate = date(YYYY,MM,DD)}. 

obviousdate1(X, (T isa day) and  P) --->  %% tirsdag 3. mars (SIC) 
    dendagen(T),      %% date more probable than clock
   {dayname(T)},
    date(X,P),        %% Buss går lørdag den 09.12 => Date 
    !,accept.         %%  (don' try other nil complements)


obviousdate1(YDate:date, YDate isa date) ---> %% (natt til) 31.12   etc// Hazard 
    point0,    %% slip %% TA-110527
    num_na(DD),  
    {DD >= 25, DD =<31},  %% \+ 52/3 
    slash, %%  slashpoint0,  før 10.10 = clock
    num_na(MM), 
    {MM =< 12},
    xyear0(MM,YY), %% adjusts year
    !,accept,
    {YDate=date(YY,MM,DD)}. 


%%  1. påskedag (år) 2012

obviousdate1(Date:date,Date isa date) ---> %%  n'te pinsedag etc. some may change month 
     den0, 
     num_na(N), {N >=1,N =<7},     %% may change month
     point0,                       %% points mostly ignored    
     w(name(Whitsun_day,n,date)),
         {testmember(Whitsun_day,[easterday])},
     
     optional(w(noun(year,_,_,n))),
     w(nb(_y2013,num)),   %% not obvious year 
     !,
     {easterdate(_y2013,ED1),  _y2013 >= 1000,  _y2013 =<9999,
     N1 is N-1,
     add_days(ED1,N1,Date)}.


obviousdate1(Date:date,Date isa date) ---> %% nyttårsaften år 9999
    {Date=date(YYYY,MM,DD)},
    
    w(name(NY_eve,n,date)),
        {testmember(NY_eve,  %% only ith known dates
             [christmas_eve,christmas_day,
              new_years_eve,new_years_day,
              midsummer_eve,midsummer_day,may17])},
    year_expression(YYYY),
    !,
    {named_date(NY_eve,date(____,MM,DD))}.

obviousdate1(Date:date,Date isa date) ---> %%  n'te pinsedag etc. some may change month 
     den0, 
     num_na(N), {N >=1,N =<7},     %%   may change month
     point0,                       %% points mostly ignored    
     w(name(Whitsun_day,n,date)),
     {testmember(Whitsun_day,
           [whitsun_day,easterday,christmas_day,new_years_day])},
     not_look_ahead(w(noun(year,_,_,_))), %% not year 2000 
     not_look_ahead(w(nb(_Y2013,num))),   %% not obvious year
     !,
     {named_date(Whitsun_day,date(X,Y,Z)),
     N1 is N-1,
     add_days(date(X,Y,Z),N1,Date)}.


%%  påskeaften, pinseaften, nyttårsaften etc
obviousdate1(Date:date,Date isa date) ---> %%  pinsedag etc. some may change month 
     w(name(Whitsun_eve,n,date)),
     {testmember(Whitsun_eve,
        [whitsun_eve,whitsun_day,palm_sunday,maundy_thursday,good_friday, 
         easter_eve,easterday,christmas_eve,christmas_day,
         new_years_eve,new_years_day,midsummer_eve,midsummer_day])},
         
         not_look_ahead(w(prep(in))),         %%  i 2009
         not_look_ahead(w(noun(year,_,_,_))), %% not year 2000 
      !,
     {named_date(Whitsun_eve,Date)}.


%%  Dooms_day
obviousdate1(Date:date,Date isa date) ---> %%  pinsedag etc. some may change month 
     w(name(Dooms_day,n,date)),
     {named_date(Dooms_day,Date)},
      !.



% i morgen 7 \= i morgen 7.12

obviousdate1(YDate:date, YDate isa date) ---> %% den  280801  etc 
    dendagen(DD),   %% den 2808
    { DD \== nil},  %% imorgen etc    %% not 28
     num_na(DD),   
    {numberdate(DD,YDate)},
    !,accept.


obviousdate1(X,P) ---> 
    dendagen(_),      %% date more probable than clock
    date(X,P),        %% Buss går lørdag den 09.12 => Date 
    !.                %%  (don' try other nil complements)


obviousdate1(Date:date,Date isa date)  ---> %% den 10.10 %% TA-110221
    den,  %% den0     10.10 is not obvious %% TA-110221
    num_na(DD),      %% not article here
    {DD >=1, DD =<31}, %% \\\ 2009-05-17
    slashpoint0,     %% 
    monthname(MM),
    slashpoint0,     %% optional .
    xyear0(MM,YY), 
    !,
    {Date=date(YY,MM,DD)}.


obviousdate1(Date:date,Date isa date) ---> 
    den0,
    num_na(DD), {DD >=1, DD =<31}, %% \+ 2009**
    slashpoint0,       %% mandatory if dot 
    month(MM),  {MM >=1, MM =<12},
    slashpoint0,      %% optional .
    year(YY),
    !,
   {Date= date(YY,MM,DD)}.

%%%    21. august 10.00  <--- %% NB 

obviousdate1(Date:date,Date isa date) ---> %% august 4 
    not_look_ahead(w(nb(_,num))), %% \+ 8  6
    month(MM), %% name
    num_na(DD), 
    year0(YY),
%%     not_look_ahead(['.']),
    !,
    {Date= date(YY,MM,DD)}.


obviousdate1(Date:date,Date isa date) ---> %% 1. mai 2014 %% TA-110221
    den, %% 10.10 not obvious date
    num_na(DD), 
    slashpoint, %% TA-110121
    month(MM),  %% not nec named
    !,
   {this_year(YY),adjust_year(MM,YY,Y1), %% 1/1 future 
              Date= date(Y1,MM,DD)}.
 

%% NOT   den første (bussen) !!! 
obviousdate1(_,_) ---> 
    dendagen(_),  
    num_na(_),
    w(noun(_,plu,_,_)), %% den 2908 klokken (noun)
    !,
    reject.


%% NOT   den første  går/ til nth / !!! 
obviousdate1(_,_) ---> 
    [den],
    w(nb(_,ord)),
    !,reject.

obviousdate1(YDate:date, YDate isa date) ---> 
    {value(busflag,true)}, 
    num_na(DD),
    slashpoint0,
    num_na(MM),
    slashpoint0, 
    {dedicated_date(date(YYYY,MM,DD)), 
     YDate=date(YYYY,MM,DD)}.


obviousdate1(_YDate:date, _) ---> %% lørdag 10.30 // fail as date 
    dendagen(_), 
    num_na(DD),
    {DD >= 1, DD =< 31},  
    colemin(_),
    !,
    reject.


obviousdate1(YDate:date, YDate isa date) ---> %% mandag 8. (30*)
    dendagen(CC), { CC \== nil}, 
    num_na(DD),
    {DD >= 1, DD =< 31},  
    point,
    not_look_ahead(w(nb(_,_))),
    !,
    {todaysdate(date(YYYY,MM,_))},
    {YDate = date(YYYY,MM,DD)}.


obviousdate1(YDate:date, YDate isa date) ---> %%  Takes all
    [den], 
    num_na(DD), %% no test
    {numberdate(DD,YDate)},
    !,accept.


obviousdate1(YDate:date, YDate isa date) ---> %%  280801  etc
    num_na(DD),   
    {DD >= 10101},    %%  1.1.2001 obvious by its number
    not_look_ahead(w(noun(_,plu,_,_))), %%  10101 busser
    {numberdate(DD,YDate)},
    !,accept.


obviousdate1(YDate:date, YDate isa date) ---> %%  2808  etc// Hazard 
    num_na(DD),   
    {DD >= 2501},    %% 25.1 (lowest possible not clock)
    not_look_ahead(w(noun(_,plu,_,_))), 
    {numberdate(DD,YDate)},
    !,accept.

 
year_expression(YYYY) --->       
        optional(w(prep(in))), 
        optional(w(noun(year,sin,u,n))), 
        w(nb(YYYY,num)),
        {YYYY =< 9999},
        !. %% TA-101005

year_expression(YYYY) --->  lastyear,!,
    {this_year(YYY1),YYYY is YYY1 -1}.

year_expression(YYYY) --->   nextyear,!,
    {this_year(YYY1),YYYY is YYY1 +1}.

lastyear --->   optional([i]),[siste],w(noun(year,sin,_,n)).
lastyear --->   optional([i]),w(noun(lastyear,sin,_,n)). %%
lastyear --->   [ifjor],!.

nextyear --->   optional([i]),[neste],w(noun(year,sin,u,n)).


%%%%%%%-----------------------------------------%%%%%%%%%

plausibleclock(X, VP::VP and Colock) ---> % (etter)6 = clock %% TA-110228
    look_ahead(w(nb(_,_))),
    !,
    clock_sequel(X,Colock).


plausibleclock1(HM:clock,HM isa clock) --->  %% buss går 10.10 =clock ,10.12 = date
    w(nb(H,num)), { H >= 1, H =< 24},
    point0,
    w(nb(M,num)), 
    optional(['.']),
    not_look_ahead(w(nb(_T000,_))), %% \+ 2007
    not_look_ahead(w(name(_May,_,month))), 
    {plausibleclocktest(H,M,HM)}, %% fernando
    !. 

%%¤ OBVIOUSCLOCK (Var, Compl) 

obviousclock(_X, __) ---> %% 17.5 is a date 
     w(nb(DD,num)), % 17
     pointNO,       % . if present
     w(nb(MM,num)), % 5      
     {dedicated_date(date(_YYYY,MM,DD))}, 
     !,reject.

obviousclock(X, VP::VP and Colock) ---> 
    obviousclock1(X,Colock).

%%¤ OBVIOUSCLOCK1 (Var, Pred) 

obviousclock1(X,Colock) ---> % kl  whatever
    clock,
    !,
    clock_sequel(X,Colock).

obviousclock1(X,Colock) --->  % HH MM tida 
    clock_kernel(X,Colock),   %% colock0(X,Colock),
    w(noun(time,sin,def,n)),   %% tida, 
    !,accept. 


obviousclock1(N:clock,N isa clock) --->     %% (buss) 0930 
    not_look_ahead(w(name(_,n,route))),    %% ugly  
    not_look_ahead(w(name(_,n,nightbus))), %% ad hoc %%
    w(nb(N,num)), { N >= 100, clock_test(N)},  %% 1979* %% 101 not ok %% TA-101207 0800
      not_look_ahead(['-']), 
      not_look_ahead(w(nb(_,_))),
      not_look_ahead(w(noun(_,plu,_,_))),  
      not_look_ahead([tusen]), 
      not_look_ahead([millioner]),  %% 
    optional( w(noun(time,sin,def,n) )) ,     %% tida
    !,accept. 



obviousclock1(X:clock, X isa clock) --->  %% buss 10 minutter over 4
    time2(X). 



obviousclock1(X:clock,X isa clock) --->  %% buss 10 minutter over 4
    hours100(X),         %%  ad hoc
    look_ahead([om]).    %% 9 om morgenen.
 



%%%%%%%% i fra syndrom

% du sier når bussen går fra nth
% =
% du sier en tid; bussen går i (denne tiden) fra nth
% =
%                 bussen går i fra (denne tiden) nth *
%
%%%%%%%%

% begin end   :   block Stack below, block input
% lock unlock :   block Stack below, BUT don't block INPUT !!!


%%%¤¤ REL_CLAUSES (X,COM, COM2)


rel_clauses(_,_,_) ---> [hva],!,reject.


%% tester kan gi forskjellige resulateter [som er] avhengig * av belastning . rough 
                         

% bussen går dit jeg besøker 
rel_clauses(X,Com,Com and  P) --->  
    % X = stedet
    derhvor, 
    [det], %% prelim 

    adverbial1(A,B,C) = (w(prep(in)),npgap(X)),
                                                     
    substatement1(P) / %% der det er pent
        ([det],  xadverbial1(A,B,C)).


rel_clauses(X,Com,Com and  P) ---> %% den sonen tkort (SOM)  gjelder for 
   
    w(noun(Card,SP,Def,n)),  %% tkortet
    w(verb(apply,Pres,fin)), %% gjelder
    w(prep(For)),            %% for
    !,
    statreal(P) \ 
       (w(noun(Card,SP,Def,n)),
        w(verb(apply,Pres,fin)),
        w(prep(For)),
        npgap(X)).


rel_clauses(X,Com,CP) ---> %% den sonen (SOM) den første billetten   gjelder for 
    lit_of(Jeg,[jeg,hun,han,vi,  man,du]),   %% TA-110607 *jeg tar bussen DEN 28 februar/
    rel_clause(X,Com,CP)\([som],[Jeg]).   %% jeg visste bussen jeg skulle ta



% bussen er et sted der det står en trikk 
rel_clauses(X,Com,Com and  P) --->  
    % X = stedet
    derhvor, 
    [det], %% prelim 

    adverbial1(A,B,C) = (w(prep(in)),npgap(X)),
                                                     
    substatement1(P) / %% der det er pent 
        ([det],  xadverbial1(A,B,C)).


% bussen er et sted hvor trikken står. %% vet du hvor sandvika er ***
rel_clauses(X,Com,Com and  P) --->   % huset hvor jeg bor er fint
    % X = huset
    derhvor, 
    subject(SU,SUNP),      %% avoid collision  jeg/huset
    statreal(P) / 
        (xnp(SU,SUNP),w(prep(in)),npgap(X)). 


rel_clauses(X,P,Q) --->  %% varianten som av en merkelig grunn ligger inne
    [som],
    danow0, 
    look_ahead(w(prep(Of))), gmem(Of,[of]), %% with care 
    adverbix(Prep,Z,Sem),
    !,
    []-xadverbial1(Prep,Z,Sem),
    rel_clause(X,P,Q)\[som].


rel_clauses(X,P,Q) --->  %% fins*  bussen som skal * til DV %%  NOT begin
       rel_clause(X,P,P1), %% lock0 opphever tidligere nogap 
       rel_clauses0(X,P1,Q).


rel_clauses0(X,P,Q) --->
    and1x, 
    rel_clauses(X,P,Q).

rel_clauses0(_,P,P) ---> [].

derhvor ---> one_of_lit([der,hvor,dit]),!. 



and1x ---> and1. 
and1x ---> look_ahead([som]). 

dvs ---> [dvs].
dvs ---> [altså].
dvs ---> [a],[la]. 



%%%¤ REL_CLAUSE  (X,COM, COM2)

rel_clause(X,Com,Com and  P) ---> % jeg tar buss altså/dvs/ala  buss 5
    dvs, 
    !,
    statreal(P) / (npgap(X),w(verb(be,pres,fin))).


rel_clause(X,Com,Com and  P) ---> % busser merket 1 -> .. som er ..
    w(verb(Label,past,part)),
        gmem(Label,[adapt,label,be_named,register]), 
    !, %% ad hoc with care   
    statreal(P) / (w(noun(agent,sin,u,n)),  w(verb(Label,past,fin)),npgap(X)). 


rel_clause(X,Com,Com and  P) ---> % som du vil  %% moved up %% TA-110329
    rel(X),
    lit_of(Du,[du,jeg,de,han,hun,vi,dere, man]), 
    look_ahead_vp,
    !,
    statreal(P) / ([Du],npgap(X)).

 

rel_clause(X,Com,Com and  P) ---> % ( liker jeg en mann) som jeg misliker en buss ?
    rel(X),                   
    not_look_ahead([at]),
    statreal(P) - npgap(X). %% X is object for Jeg liker, subject for mislike

/* SUBSUMED %% TA-110329
rel_clause(X,Com,Com and  P) ---> % mannen som jeg ikke så *
    rel(X),                       % jeg ser en buss som det er mulig å ta ***
    not_look_ahead([at]),
    statreal(P) / npgap(X). %% general (object) 
*/


rel_clause(X,Com,Com and  P) ---> % bussen som det er mulig å ta
    rel(X),           
    [det],
    !,
    statreal(P) / ([det],npgap(X)).

%%%


relneg(Neg) --->  %% after rel()  som
    relblabla,
    negation0(Neg),
    !.

relneg(Neg) --->  %% after rel()  som
    negation0(Neg),
    relblabla,
    !.


relblabla ---> [nå],!.
relblabla ---> [bare],!.
relblabla ---> redundant0.



whose_noun(Z,R) --->
    whose,
    noun(_,_,u,n,Z,R).


%%   hvem hva hvor  

relwhat(X) ---> 
    hva, 
    som0,   %% bussen går til hva er klokken *
     {constrain(X,thing)},
    !,accept.  %% dont backtrack on subclasses 


relwhat(X) --->
    [hvem],
    som0, 
    {constrain(X,agent)},
    !,accept. %% dont backtrack on subclasses 


rel(X) ---> 
    relpron(P),
    not_look_ahead(w(quote(_))), %% = as 
    optional([nå]), %% ad hoc ... som nå ligger  
    {constrain(X,P)},
    !,accept.  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%¤¤¤ COMPARISONS

comparisons(X,S,P) ---> 
    comparison(X,S,P1),
    comparisons0(X,S,P1,P).

comparisons0(X,S,P1,P1 and P3) --->
    and1,
    comparison(X,S,P2),
    comparisons0(X,S,P2,P3).

comparisons0(_,_,P,P) ---> [].

%%%¤¤¤ COMPARISON


comparison(X,_,P2) --->  %%  hastighet (lik) 50 kmt/ pris 50 kroner 
    {vartypeid(X,H)},
    {testmember(H,[speed,price,name,description])}, %% ETC 
    np1_accept(Y, P1::P2),  
    !,
    {compare(eq,thing,X,Y,P1)}. 


comparison(X,_,_) --->  %%  information over/ minutes over
    comparator1(REL),    
    {REL== gt},
    {vartype(X,_,I)},
    {testmember(I,[information,minute])},
    !,reject.

comparison(X,_,P2) --->  %%  Direct comparison tore = anne 
    comparator1(REL),    
    {testmember(REL,[eq,ne])},
    noun_phrase1(Y, P1::P2),  %% # bortsett fra buss 8 og buss 9
    {compare(REL,thing,X,Y,P1)}. 


comparison(X,_,P2) --->  %%  Direct comparison ( 23 > 20 ) 
    comparator1(REL),    
    {testmember(REL,[gt,ge,le,lt])},
    noun_phrase1(Y, P1::P2),  %% # bortsett fra buss 8 og buss 9
    {compare(REL,number,X,Y,P1)}.

comparison(X,_,P2) --->  %%  Indirect comparison ( John is older than Mary) 
    comparator2(REL,Age),    
    noun_phrase1(Y, P1::P2),
    {compare(REL,Age,X,Y,P1)}. 

comparison(X,_,P2) --->  %%  Compare adjectives %% John is  as good as Mary
    comparator3(REL,Good),    
    noun_phrase1(Y, P1::P2),
    {comparad(REL,Good,X,Y,P1)}. %% New



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  NOUN-PHRASE SECTION
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%¤¤¤¤ NP (

np(X, NP) --->   %%  fronted (/ is last anyway)
     xnp(X,NP).  %% stacked np, accessible for all
                          

np(X, P1::P) --->        
    noun_phrases(X, P1::P).

%% Moved last
%% jeg vet hva bakgrunnen for dette er ("hva")

np(X, P::P) ---> npgap(X). %% last

  
%%%¤ NP0_ACCEPT


np0_accept(X, P1::P) ---> 
    np0(X, P1::P),
    !,accept.

%%%¤ NP00  invent a Class NP

np00(Class,X:Class, P::(exists(X:Class)::X isa Class and P)) ---> []. 

raise_object00(Pred, P::(P and Pred)) --->  [].



%%¤  SUBJECT (VAR, NPSEM) %% NP accept excluding obvious objects

subject(X, NPX) ---> %% subject noun phrase ( hvem laget -du-)
     not_look_ahead(w(name(være,n,_))), %% Være %% TA-110624
     not_look_ahead(w(name(norwegian,n,language))), %% ad hoc //adj+name
     
     not_look_ahead_lit(
         [meg,deg,ham,henne,seg,oss,dem,det]), %% dette,noe]), 
                                       
                                                           
     np(X, NPX). %% expensive?

   %%   noun_phrase_accept(X, VP::P). %% au,  %% state(X,VP::P,_,[gap(npgap(_8902:bus),free)],_17017,3,_17019) ? 
                                           %% en buss som jeg fikk en         billett til
                                           %% takes bus as subject,!



%%%¤  OBJECT1 %% simple object without mods 

object1(X,NP) ---> %% simple object without mods 
    not_look_ahead_lit([jeg,du,han,hun,vi]),
    np0(X,NP),
    !.

%%%¤ OBJECT   

/* unneccesary (moved to lex) %% TA-101110 %% RS-140616
object(X, NP) ---> %% Ad Hack 
    look_ahead([j]),  %% j aaes veg, også [jeg]
    w(name(JAV,NG,CL)), %% j aaes veg, j= jeg, dont select the j=jeg interpretation
    noun_phrase_accept(X, NP)\  w(name(JAV,NG,CL)),
    !.
*/


object(X, NP) ---> %% object noun phrase (hvem laget -deg-) 
    not_look_ahead_subject, %% Ad Hack  %% huset hvor jeg bor fins//   huset on  stack
    noun_phrase_accept(X, NP).  %% j aaes veg, j= jeg, dont select the j=jeg interpretation




%%%¤ IND_OBJECT 

ind_object(X, NP) ---> %% 
      not_look_ahead_subject, %% Ad Hack  %% huset hvor jeg bor fins//   huset on  stack

    noun_phrase_accept(X, NP). %%  np0_accept(X,NP). %% Problem???
                               %%   du gir turen fra ringvål en turtype 


not_look_ahead_time ---> look_ahead_time,!,reject. %% TA-110520

look_ahead_time ---> w(nb(_,_)).

look_ahead_time ---> one_of_lit([halv,kvart]).
look_ahead_time ---> w(noun(Sat,_,_,_)),{subclass0(Sat,time)},!.



not_look_ahead_subject ---> look_ahead_subject,!,reject.
not_look_ahead_subject ---> [].


%% unnec look_ahead_subject ---> look_ahead([j]),!,reject. %% - %% j aaes veg (not jeg)

look_ahead_subject ---> look_ahead_lit([jeg,du,han,hun,vi,man]). %% TA-101124




subject2(X,Y, NP) --->      %% not  meg,ham,henne,oss,dem // NOT en
    noun_phrase2(X,Y, NP),
    !,accept. %% <--- !!!   DONT ALLOW  " til en plonk ", og deretter backtracke til 'en'


object2hnn(_X,_Y, _NP) --->   %% have  // NOT name  bus has 9
    w(name(_,_,_)), %%  ha   MSN * 
    not_look_ahead(w(prep(on))), %% har Tagore på hjernen  :-) 
    not_look_ahead(w(noun(_,_,_,_))),
    not_look_ahead([deg]), 
    !,reject.



object2hnn(X,Y, NP) --->   %% have  // NOT name  bus has 9
    object2h(X,Y, NP),  
    !,accept.    


%%   object to have // digre busser, not digre as name
%% Complex passover
 
object2h(_X,_Y, __) ---> [dere], %% skjerp dere
    !,reject.


object2h(X,Y , NP) --->  
    object2(X,Y, NP).


%%%%¤¤¤  OBJECT2 Object with subject parameter

object2(_X,_Y, __) ---> [en],[gang],!,reject. %% (=nå) 

/* Hva gjør du %% TA-101130
object2(X,Y, ONP) --->   %% TA-101129 Ad Hoc, notify TV
    {vartypeid(X,savant)}, %% du varsler [meg].
    not_look_ahead_lit([meg,deg,seg]),
    noun_phrase1(Y, ONP)=[meg],
    !,accept.
*/


 
object2(_,Y, NP) --->    %% Moved from noun_phrase2
    which, %%   jeg vet hvilke busser jeg skal ta 
    np(Y, NP),   
    {\+ vartypeid(Y,place)},
    !,accept.



object2(X,X, VP::VP and P) --->  
    prep1(around),
    clock,
    !,
    clock_kernel(X,P).      %% ca kl |||| is confusing


object2(X,Y, VP::P) --->       %% not jeg,du,han,hun,vi,de
    not_look_ahead_lit([middag]), %% til middag also adverbial
    noun_phrase2(X,Y, VP::P).


object2(_X,_Y, __) ---> %% du|tu %% TA-110624 moved back
    one_of_lit([jeg,du,hun,vi]), %% jeg liker han ok
    not_look_ahead([som]),
    !,reject.


%%%¤¤¤  NOUN_PHRASE2 Object compared with the subject X 

% noun_phrase2(X,Y, VP::P)   % object Y compared with the subject X 

% The object Y is or is not identical to the subject X

% hvilken buss bør jeg ta når   jeg skal til dragvoll



noun_phrase2(_,X, VP::VP and P) --->  %% jeg forteller [et sted] hvor du er 
    look_ahead([hvor]),
    !,accept,
    adverbial_noun_phrase1(X, VP::P).


noun_phrase2(X,X, VP::P) ---> %% Reflexive pronoun 
    recipron(_),                        % Himself
    noun_phrase1(X, VP::P)  \  npgap(X).


noun_phrase2(X,Y, P::findalt(diff,X,Y)::(Q and P)) --->
    another,
    noun(_,sin,u,n, Y, Q0), 
    noun_modsx0(0,Y,Q0,Q). 


noun_phrase2(_,_,__) --->
    not_look_ahead(w(noun(_,_,_,_))), %%  hva heter stoppet ved risvollansenteret 
    not_look_ahead(w(adj2(_,_))), %% korrigert 
    w(verb(_Corrected,past,part)),
    !,
    reject. %% AD HAC  Elsket not adjectival partisipp


noun_phrase2(_X,Y, NP) --->    %%    jeg vet hvilke busser jeg skal ta 
    look_ahead([hva]), 
    !,
    np(Y, NP).       %% be qual to X     

noun_phrase2(_X,Y, NP) --->    
    not_look_ahead([hva]),  
    which0, %%   jeg vet hvilke busser jeg skal ta 
    np(Y, NP).       %% be qual to X     

%%%%

adverbial_noun_phrase1(U, VP::VP and P) --->
    [hvor],
    not_look_ahead([mye]), 
    (adverbial1(Prep,U, V::W) =  (w(prep(in)),w(noun(place,sin,u,n)))),
    !,
    statreal(P) /  adverbial1(Prep,U, V::W).




% % % % % % % % % % % % % 

%%%%¤¤¤  NOUN_PHRASE_ACCEPT

noun_phrase_accept(X, NP) ---> 
   np(X, NP),  %% buss (mellom 10) og 11
   !,accept.                 

%%%¤ NP1_ACCEPT   


np1_accept(X, NP) ---> %% Ad Hoc SpeedUp 
   noun_phrase1(X, NP), 
   !,accept.                 


noun_phrases2(YZ, VP::P2 and P3) --->         % exactly 2 NPs
    np1_accept(Y, VP::P2), 
    and0,                                   % optional
    np1_accept(Z, VP::P3),
    {latin(and,Y,Z,YZ)},   
    !,accept.

%%¤   NOUN_PHRASES (YZ, VP::P1 and P2 and P3) --


noun_phrases(YZ, VP::P1 and P2 and P3) --->          % strekningen A B 
    look_ahead(w(noun(distance,sin,def,n))),       % otherwise EXPENSIVE
    noun_phrase1(X, VP::P1),          % 1

    {vartypeid(X,SS)},              
    {testmember(SS,[distance])},        % "strekningen"
    noun_phrase1(Y, VP::P2), 
    noun_phrase1(Z, VP::P3),
    {latin(and,Y,Z,YZ)},   
    !,accept.



noun_phrases(Z, VP::P2) --->         % 1...more
    noun_phrase1(X, VP::P1),         %% not _accept
    noun_phrases0(X,Z,true::P1,P2), % 0...more // true <---> VP
    !,accept.  %% DONT backtrach to noun_phrase1 !!! %% TA-110429


%%¤   NOUN_PHRASES0 (X,XZ, ,VP::P1,P1 and P3) 

%% stop at some conditions

noun_phrases0(X,X,_::P,P) ---> %% TA-110429    2 kilometer \= (2,kilometer)
    {constrain(X,number)},
    !.                         %% If street etc, should be captured by lex
noun_phrases0(X,X,_::P,P) ---> %% TA-110202
    look_ahead(w(nb(_,_))),    %% Moholt to // Moholt 2
    !.                         %% If street etc, should be captured by lex
noun_phrases0(X,X,_::P,P) ---> %% TA-101013
    look_ahead_lit([etc,samme]),  %% etc gi turen samme turtype %% TA-101013
    !.  
noun_phrases0(X,X,_::P,P) ---> 
    look_ahead(w(verb(Be,inf,fin))),      %% Være "#%:/()=?
    {testmember(Be,[be,use])}, %% Ad Hoc  bruker
    !.  
noun_phrases0(X,X,_::P,P) --->
    look_ahead(w(verb(Be,pres,fin))),      %% Være "#%:/()=?
    {testmember(Be,[wish,want])}, %% ønsker
    !.  




noun_phrases0(X,XZ,VP::P1,P1 and P3) ---> 
    not_look_ahead([',']), %% if present
    np_conjunction(And), %% andor(And),    
        not_look_ahead(w(noun(_Owner,sin,def,n))), %% du er en pc og eieren er dum
    noun_phrase1(Y, VP::P2),
    noun_phrases20(Y,Z,VP,P2,P3),
    {latin(And,X,Z,XZ)}.   

noun_phrases0(X,XZ,VP::P1,P1 and P3) ---> 
   {\+ vartypeid(X,savant)}, %% ad hoc.. skjønner du noe 

   noun_phrase1(Y, VP::P2), 

   noun_phrases10(Y,Z,VP,P2,P3),
    {latin(and,X,Z,XZ)}.   

noun_phrases0(X,X,_::P,P) ---> [].

%% list then and

%%%¤ NOUN_PHRASES10 X0,X,V P,P1,SEM) 

noun_phrases10(X,XZ,VP,P1,P1 and P3) ---> %%  and
    andor(And),
    noun_phrase1(Y, VP::P2), 
    noun_phrases20(Y,Z,VP,P2,P3),
    {latin(And,X,Z,XZ)},   
    [etc].

noun_phrases10(X,XZ,VP,P1,P1 and P3) ---> %% no and
    not_look_ahead(w(nb(_,_))), %% caution  bus 80 to flaktveit. 
    noun_phrase1(Y, VP::P2), 
    noun_phrases10(Y,Z,VP,P2,P3),
    {latin(and,X,Z,XZ)}.   

noun_phrases10(X,X,_,P,P) ---> [etc].

%% and sequence, lists not allowed

noun_phrases20(X,XZ,VP,P1,P1 and P3) ---> 
    andor(And), 
    noun_phrase1(Y, VP::P2), 
    noun_phrases20(Y,Z,VP,P2,P3),

    {latin(And,X,Z,XZ)}.   

noun_phrases20(X,X,_,P1,P1) ---> [].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% NO_PHRASES 

no_phrases(X,P) ---> %% Pure Noun_phrase 
    {value(teleflag,true)},
    !,
    np(X,true::P). %%  \ the0.

no_phrases(X,P) ---> %% Pure Noun_phrase 
   the0, 
   np(X,true::P). 


no_phrase(X,P) ---> %% One Pure Noun_phrase 
  the0,    
  noun_phrase1(X, true::P).




%%%¤  NOUN_PHRASE1  (X,NP)


noun_phrase1(_,__) ---> [og],!,reject. %% går buss 3 OG 5 



noun_phrase1(X, NP) --->  
    np2(X, NP).           % some specialties   MOVED UP

noun_phrase1(X, NP) --->  % (de 2 neste bussene)
    np1(X, NP).           % calls name_phrase

noun_phrase1(X,NP1)---> 
    one_of_lit([noen,mange]), %% den]), * den er brun
    not_look_ahead([som]),
    not_look_ahead([av]),
    not_look_ahead_np,    
    np00(agent,X,NP1).

noun_phrase1(X,NP1)--->    %%  den er brun
    one_of_lit([den,det]), %% 
    not_look_ahead(w(verb(_Run,_,pass))), %% det kjøres 
    not_look_ahead_np, 
    np00(thing,X,NP1).


noun_phrase1(X, VP::P) --->  %% NOEN
    not_look_ahead([de]),     
    not_look_ahead([det]), %% ad hoc
    quant_pron(some,Person),
    not_look_ahead([som]), %% noe som -> 
    not_look_ahead(w(noun(_,_,_,_))), 

    !,accept,     
    np1(X, VP::P) =  %% ikke \
                   %% når går det buss fra X \= når går en ting fra X
        ( some,w(noun(Person,sin,u,n))). %% tar man buss \== tar man(s) buss


noun_phrase1(X, NP) --->  %% ALT 
    not_look_ahead([de]),     
    quant_pron(every,thing),
    not_look_ahead(w(noun(_,_,_,_))), 
    not_look_ahead(w(adj2(_,_))),
    !,accept,     
    np1(X, NP) \
        ( [alle],w(noun(thing,sin,u,n))). %% alle ting


noun_phrase1(X, NP) --->  %%   bussen ( anaphoric)
    npa(X, NP).           %%  han   AFTER quant_pron(some,person)
                          %%  mary liker han som lever

noun_phrase1(X, VP::P)--->  
    quant_pron(much,Time), 
    np1(X, VP::P) =
           (much,w(noun(Time,sin,u,n))).

noun_phrase1(X, VP::P)--->  
    quant_pron(little,Time), 
    np1(X, VP::P) = 
           (little,w(noun(Time,sin,u,n))). 


noun_phrase1(X, VP:: (not P))--->  %% Ad hoc  no person die --- every person does not die
    quant_pron(no,Person),  
    np1(X, VP::P) =
           (every ,w(noun(Person,sin,u,n))).


noun_phrase1(X, NP) --->  %% MOVED LAST 
    xnp(X,NP). %% Stacked NP

noun_phrase1(X, P::P) --->  %% MOVED LAST 
    npgap(X). %% jeg blir kalt tore// passive /
              %% needs noun_phrase1 syntax, but jeg og tore er stakket
                                  


%% SPECIFIC PHRASE     tt sommeruter*


specific_phrase(_X,_) --->  
   w(name(_,gen,_)),         %% avoid your (=tuc's) version
   !,
   reject.  

specific_phrase(_X,_) --->  
   w(name(_,_,_)),          %% avoid your (=tuc's) version
   sin,
   !,
   reject.  

specific_phrase(X, VP::P) ---> 
    sp1(X, VP::P). 


sp1(X:T,VP:: (findpron(X:T):: (X isa Man) and VP)) ---> 
    pronoun(Man),
    {type(Man,T)}.                

sp1(X, NP) ---> 
    name_phrase(name,X,NP),  %% tore amble 
    not_look_ahead(w(noun(_,_,_,_))). %% 2 busser





%%%%¤¤  NP0     np without modifiers

np0(X, NP) ---> %% koster det mye (å ta buss)
    [mye],
    not_look_ahead_np,
    not_look_ahead(w(adj(_,_))),
    np_kernel(0, X, NP)=w(noun(thing,sin,u,n)),
    !,accept.  



np0(X, VP::P) ---> %% Bus 8 \== bus at 8' 
    np_head1(_, X, VP::P), 
    !,accept.  

np0(X, VP::P) --->       %% np without modifiers
    the10,             % den/det (not de) 
    aname_phrase(_IND,X, VP::P).



np0(X, VP::P) --->
    np_kernel(_, X, VP::P). %% np_head (>> pronoun) 

np0(X, VP::P) --->
    npa(X, VP::P).

np0(X, P::P) ---> %% NB  NPGAP
    npgap(X).

%%%¤ OBVIOUS_OBJECT 

obvious_object(_X,_NP) ---> %% TA-110429
    [det],    %% ad hoc
    not_look_ahead(w(verb(_Want,_,pass))),
    !,reject.


obvious_object(X,NP) ---> %% TA-110401
    look_ahead([alt]),    %% ad hoc
    np1_accept(X,NP),
    !.
obvious_object(X,NP) ---> %% 
    not_look_ahead([noen]), %% etc etc %% TA-110428
    np0_accept(X,NP).


%

% NB np1 breaks the greedy heuristics rule, and
% may return shorter phrases before longer

% Bussen går til 2 steder     np_head først !!!
% Bussen går før klokken 10   aname_phrase først !!!


%-------------------------------------------------------------
  
% buss 5 går til 2 stasjoner før klokken 10 

%% Due to cut regime, both must be right at first try



%%%%¤¤  NP1 

/*

MEMO
whatq(which(Y):::P) ---> %% hvor mye koster det å ta bussen
    [hva],
    w(verb(V,_,fin)),
    {testmember(V,[cost])},
    [det],
    [å],
    clausal_object1(COV,COST)\([noen],[vil]),     
    !,
    statreal1(P)  \ 
        (xnp(COV,COST),
         w(verb(V,pres,fin)),
         npgap(Y)). 
*/    


%% EXPERIMENTAL

np1(X, P::P and Q ) ---> %   hvor mye  det koster å ta buss
    hvormye,     %% TA-110104 ..|hva
    [det], 
    w(verb(Cost,Pres,fin)),
    [å],
    !,
    clausal_object1(NewSCo,CNP) \ %% NewsCO: noen vil ta buss
      ( [noen],[vil]),
    !,
    statreal1(Q)= (xnp(NewSCo,CNP),w(verb(Cost,Pres,fin)),npgap(X)).





%% **rute 3  retning lade fins.

np1(X, NP1) ---> %   noe i bussen
    [noe],
    look_ahead(w(prep(_In))),
    !,
    np_kernel(0, X, NPK)=w(noun(thing,sin,u,n)), %% 
    noun_modifiers0(0,X,NPK,NP1).


 
%% Hazardous !
  
np1(X, NP) ---> %  en buss 6 ulykke -> en ulykke med buss 6
   a,                    %% en NOT a0
   w(noun(Veh,sin,u,n)), %% buss
   w(name(B6,n,Bus)),    %% 6

   w(noun(Acc,sin,u,n)), %% ulykke
       {\+ testmember(Acc,[minute,hour,direction,
           home,        %% bus 60 hjem  
           station])},  %% (passerere) buss 9 holdeplass 
        %% (på) rønningsbakken 16 minutter (etter avgang)

%% buss 60 hjem

   !,accept,
   np_kernel(_Ind, X, NP1)=  w(noun(Acc,sin,u,n)),
   noun_modifiers0(0,X,NP1,NP)=
         (w(prep(with)),     
          w(noun(Veh,sin,u,n)), 
          w(name(B6,n,Bus))).

np1(X, NP1) ---> %  (vet du)  hvem jeg er %% TA-100912
    [hvem],
    look_ahead_lit([man,jeg,du,vi]),
    !,
    np00(agent,X,NPK), 
    noun_modifiers0(0,X,NPK,NP1)\relpron(agent).


np1(X, NP1) ---> %   hvem som lever
    [hvem],
    [som],
    !,
    np00(agent,X,NPK), 
    noun_modifiers0(0,X,NPK,NP1)\relpron(agent).


np1(X, NP1) ---> %   hvor mye  det koster = hva dette koster
    hvormye,     %% TA-110104
    dette,       %% det + no_np
    !,
    
    np_kernel(0, X,NPK)=w(noun(thing,sin,u,n)), 

    noun_modifiers0(0,X,NPK,NP1) \ relpron(thing). % |  du skriver


np1(X, NP1) ---> %   hva du skriver ?
    [hva],
    [som],
    !,
    np00(thing,X,NPK), 
    noun_modifiers0(0,X,NPK,NP1)\relpron(thing) . %%*jeg tar hva som en rute.



np1(X, NP1) ---> %   hva du skriver ? 
    [hva],
    look_ahead_np, %%   klokken er | du heter
    !,
    
    np_kernel(0, X,NPK)=w(noun(thing,sin,u,n)), %% [det], 

    noun_modifiers0(0,X,NPK,NP1) \ relpron(thing). % |  du skriver



np1(X, NP) ---> %  (da sender) de meldingen
    [de],
    not_look_ahead(w(nb(_,_))), %%%%%% TI = TIME = NOUN 
    look_ahead(w(noun(_,sin,_,_))),
    !,
    np00(agent,X,NP). %% rough (bussene)



np1(X, NP1) ---> %  (X har)   noe med Z å gjøre= X har noe mwd  Z
    noemed,      %% ad hoc
    !,
    np0_accept(Err,ErrNP),
    [å],
    w(verb(do1,inf,fin)), %% gjøre
    !,
    np_kernel(Ind, X, NPK)=w(noun(thing,sin,u,n)),   %% noe

    noun_modifiers0(Ind,X,NPK,NP1) \ (w(prep(with)),xnp(Err,ErrNP)).


noemed ---> [noe],[med]. %% fast uttrykk

 
np1(X, NP1) ---> %   noe å gjøre = noe som X vil gjøre 
    noeå,
    !,
    np_kernel(0, X, NPK)=w(noun(thing,sin,u,n)),   %% 
    noun_modifiers0(0,X,NPK,NP1) \ ([som],[jeg]). %% ad hoc ...jeg
                                               %% not aux1 pga look_ahead
noeå ---> [noe],[å]. %% ad hoc (en stor oppgave ... å )


np1(X, NP1) ---> %   noe som  du skriver ? 
    noesom,
    !,
    np_kernel(0, X, NPK)=w(noun(thing,sin,u,n)), %% 
    noun_modifiers0(0,X,NPK,NP1) \ [som]. % |  du skriver 


noesom  ---> [det],look_ahead_lit([man,jeg,du,vi]). 
noesom  ---> [det],[som].
noesom  ---> [noe],[som].
noesom  ---> [noe],look_ahead_lit([jeg,du,han,hun]). 
noesom  ---> [hva],[som]. %% <--- jeg vi vite hva som skjer

noesom  ---> [det],look_ahead_lit([jeg,du]),!.


np1(X, NP1) ---> %  det de skriver 
    [det],
    look_ahead([de]),
    !,
    np00(agent,X,NPK), %% 
    noun_modifiers0(0,X,NPK,NP1) \ [som]. 


np1(X, NP1) ---> %   noen () de kjenner lever
    [noen],
    look_ahead([de]),
    !,
    np00(agent,X,NPK), %% 
    noun_modifiers0(0,X,NPK,NP1) \ [som]. 




np1(X, NP) ---> %  hvilke busser en kan ta %% NOT INITIALLY
    [hvilke],
    np_kernel(Ind, X, NPK),
    not_look_ahead([som]),
    look_ahead_np,
    !,
    noun_modifiers0(Ind,X, NPK,NP)\[som].  % |  du skriver

np1(X, NP) ---> %  hvilke N som fins %% NOT INITIALLY
    [hvilke],
    np_kernel(Ind, X, NPK),
    look_ahead([som]),
    !,
    noun_modifiers0(Ind,X, NPK,NP).  % |  du skriver

np1(X, NP1) --->  %%  de 5 neste fra %% Ad Hoc Hazardous
   {value(busflag,true)},
   [de],  w(nb(N,num)),flnp(Next),   
   not_look_ahead(w(noun(_,_,_,_))), 
   w(prep(From)),
   !,accept,
   []-w(prep(From)),
   np_kernel(Ind, X, NPK)\ 
      ( w(nb(N,num)),
        w(adj2(Next,nil)),
        w(noun(vehicle,sin,u,n))),
   noun_modifiers0(Ind,X,NPK,NP1).


np1(X, VP::P) ---> %   rutetide gjelder for 2 mai. %% EXPENSIVE ?
    obviousclock(X, VP::P), %% den 1208 
    !,accept.


np1(X, NP1) ---> % en 52  %% Ad Hoc Hazardous
   {value(busflag,true)},
   [en],  %% art,  \+ de (2 neste ...)
    w(nb(N,num)),
   {plausible_busno(N)},
    not_look_ahead(w(noun(_,_,_,_))), 
   !,accept,
   np_kernel(Ind, X, NPK)\ 
      ( w(noun(vehicle,sin,u,n)),
        w(nb(N,num))),
   noun_modifiers0(Ind,X,NPK,NP1). 


np1(X, VP::P) ---> %%  Golden Regime, last normal case
    np_kernel(Ind, X, VP0::P0), 
    noun_modifiers0(Ind,X, VP0::P0, VP::P).



%%% NP_KERNEL (0, X, NP) 

np_kernel(0, X:thing, Q::(findpron(X:thing):: X isa thing and Q)) --->
    dette,     
    not_look_ahead_np, %% TA-110808
    !.

np_kernel(0, X:agent, Q::(findpron(X:agent):: X isa agent and Q)) ---> %% de reiser
    [de],  
     not_look_ahead(w(nb(_,_))),
     not_look_ahead(w(adj2(_,_))), %% nå går de neste bussene. -> de .. går
    look_ahead(w(verb(_Reiser,pres,fin))),
    !.

np_kernel(0, X, VP::P) ---> %  1. mai som er en fredag 
    obviousdate(X, VP::P),
    !,accept.

        % en jeg liker  = en ting som jeg liker
np_kernel(0, X:thing, Q::(findpron(X:thing):: X isa thing and Q)) --->
    [en], 
    look_ahead_lit([jeg,du,han,hun,vi,dere,de]), 
    !.

/* en meget stor buss \= en &meget stor buss
np_kernel(0, X:agent, Q::(findpron(X:agent):: X isa agent and Q)) --->
    [en], 
    not_look_ahead_np,           %% disallows adj ?
    not_look_ahead(w(adj2(_,_))),
    not_look_ahead([nesten]), %% Ad Hoc en nesten opphissende tanke %% TA-110427
    !.
*/

%% NB  jeg|du funtion as names  vet du hvor sandvika er %% TA-110314
np_kernel(name, X:Man, Q::(findpron(X:Man):: X isa Man and Q)) --->
    not_look_ahead_lit([de,den,det,et]),      
 
    pronoun(Man), 
    !.

%% jeg liker alt som lever| har alt å tape
np_kernel(0, X:thing, Q::(exists(X:thing):: X isa thing and Q)) ---> 
   one_of_lit([alt,noe]),
   look_ahead_lit([som,å]),
   !.

np_kernel(Ind, X,  VP::P) ---> % #0
    np_head1(Ind, X,  VP::P).  % adj/nil/prolog/  system

%% Prisen kino // Price was tested first


np_kernel(Ind,XT, NP) --->%  # 0 
    look_ahead(w(name(_Prisen,n,_Station))), %% sola | prisen // Hastus dataene
    not_look_ahead(w(noun(_Busso,_,_,_))), %% bussoraklet  name|noun  %% TA-110511
    aname_phrase(Ind,XT, NP). %% til ranheim neste time    // adj-prefix

%%%  not_look_ahead(w(adj2(_new,nil))). %% to nye busser 
                                       %% til tempe senest=late kl

np_kernel(Ind, X,  VP::P) ---> % # 1  msn address -> longest first
    np_head(Ind, X, VP::P).

%%  nummer 9871

np_kernel(Ind,XT, VP::Q) ---> %  # 2
    not_look_ahead(w(name(_Prisen,n,_Station))),
    aname_phrase(Ind,XT, VP::Q). %% oops  returns msn ! [address] <----
    %% means   ADJ+NAME (somewhat special).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%% Tele-questions


np_head1(Cind, XT,   VP::P) ---> %% navn, telf og avd til tore amble  
    {value(teleflag,true)},     %% msn adresse 
    determiner0(_Num,Cind,XT,  P0 , VP::P),   
    preadjs0(Alist),   
    noun_list2(_,XT,Q0), 
   {preadjs_template(Alist,XT,Q0,P0)}.


%% Ordinary Bus Expressions


%% art  Quant  Next bussE NR Busno  // with subsets and permutations

np_head1(0, BusNo: BnounC,  VP::Bingo ) ---> 
    {value(busflag,true)},  
    optional([denne]), %%   denne 46 avgangen
    bus_head(_Def1,Number,FLNP,BnounC,_BnameC,BusNo),
    not_look_ahead_lit([sin,sitt,sine]),
    !,
    {decide_adjective(FLNP,BusNo,FTA)}, %%  adj/nil/nil/_/_ -> true
    {QP =  (BusNo  isa BnounC and FTA)},
    {decide_quantifier(Number,BusNo:BnounC,QP and VP,Bingo)}. %%  fernando


np_head1(0, XT,  VP::P) ---> %% neste [som] 
    {value(busflag,true)},
    [den],
    w(adj2(FILANEPR,nil)), 
    {testmember(FILANEPR,[first,last,next,previous])},
    look_ahead([som]),
    !,accept,
      np_head(0, XT, VP::P)  = (w(adj2(FILANEPR,nil)),w(noun(vehicle,sin,u,n))),
    !,accept. 
  

%% www address -> homepage  
np_head1(0, XT,   VP::(exists(XT):: P0 and Q0 and VP)) --->  
    not_look_ahead([dere]), %% har dere =tt buss 
    w(name(TT,_N,_)),  
    noun(_Bus,_Num,_Ub_,n,  XT, Q0), 
    {adjnamecomp_template(TT,XT,P0)}, 
    !,accept.



%% 8 neste busser  \= buss 8  

%% Check that a number is not a name
% dont return (bus) 3 when " 3 neste " 
%% OOPS   30 minutter over/på/før 1400 
% dont return (bus) 3 when " 3 noun_plural" 
% unless  time measure



%%%¤  BUS_HEAD (Def1,Number,FLNP,BnameC,BnameC,BusNo)  


% de to neste 11 
bus_head(Def1,Number,FLNP,BnameC,BnameC,BusNo)  ---> 
    {traceprint(5,bx01)},
    art0(Def1,_SINPLU1),         % (de) (5 \ neste) (nr) 3 busser
    quantnext(Number,FLNP),
         {FLNP \== nil}, %% avoid 5 2 = 5 route 2 
   { Number =< 5}, 
    busnumber(BusNo,BnameC),
    {traceprint(4,bh01)}.


bus_head(Def1,Number,FLNP,BnounC,BnameC,BusNo)  ---> 
    {traceprint(5,bx02)},
    art0(Def1,_SINPLU1),         % (de) (5 \ neste) (nr) 3 busser
    quantnext(Number,FLNP),
   { Number =< 5}, %% pragmatic 
    busseno(BusNo,BnounC,BnameC),
    {traceprint(4,bh02)}.


bus_head(Def1,Number,FLNP,BnameC,BnameC,BusNo)  ---> 
    {traceprint(5,bx03)},
    art0(Def1,_SINPLU1),         % (de) (5 \ neste) (nr) 3 
    quantnext(Number,FLNP),
   { Number =< 5}, %% maxnumberofindividualdepartures(4).
    not_look_ahead(w(nb(_,_))), %% not 4 6 = 4 X 6 
    nr0,  
    busnumber(BusNo,BnameC),
    {traceprint(4,bh03)}.


bus_head(Def1,Number,FLNP,BnameC,BnameC,BusNo)  ---> 
    {traceprint(5,bx04)},
    art0(Def1,_SINPLU1),         % (de) (5 \ neste) <> til
    quantnext(Number,FLNP),
   { Number =< 5}, 
    look_ahead(w(prep(_))),
    busnumber(BusNo,BnameC) = w(noun(bus,plu,def,n)),
    {traceprint(4,bh04)},
    !.


bus_head(Def1,1,FLNP,BnounC,BnameC,BusNo)  ---> % en neste nr 5 buss
    {traceprint(5,bx05)},
    art0(Def1,_SINPLU1),   % (de) 5 nr 3 (busser)
    flnp(FLNP),   
    nr1,
    busnumber(BusNo,BnameC), 
    busse0(BnameC,BnounC,_,_),    %% Optional
    {traceprint(4,bh05)}.


bus_head(Def1,Number,nil,BnounC,BnameC,BusNo)  ---> 
    {traceprint(5,bx06)},
    art0(Def1,_SINPLU1),   % (de) 5 nr 3 (busser)
    quant(Number),
    nr1,
    busnumber(BusNo,BnameC), 
    busse0(BnameC,BnounC,_,_),  %% Optional
    {traceprint(4,bh06)}.    


bus_head(Def1,Number,nil,BnounC,BnameC,BusNo)  ---> 
    {traceprint(5,bx07)},
    art0(Def1,_SINPLU1),  % (de) 5 busser (nr) 3
    quant(Number),
    busnoun(BnounC,_,_),    
    nr0,
    busnumber(BusNo,BnameC), 
    {traceprint(4,bh07)}. 


bus_head(Def1,Number,nil,BnounC,BnameC,BusNo)  ---> 
    {traceprint(5,bx08)},
    art0(Def1,_SINPLU1),  % (de) 5 3 busser
    quant(Number),
    busnumber(BusNo,BnameC), 
    busnoun(BnounC,_,_), 
    {traceprint(4,bh08)}.    


bus_head(Def1,1,FLNP,BnounC,BnameC,BusNo)  ---> 
    {traceprint(5,bx09)},
    art0(Def1,_SINPLU1),  % (de) neste nr 3 busser
    filanepr(FLNP),
    nr1, 
    busnumber(BusNo,BnameC), 
    busnoun(BnounC,_,_), 
    {traceprint(4,bh09)}.    


bus_head(Def1,1,FLNP,route,BnameC,BusNo)  ---> %% nr 7 -> route 7
    {traceprint(5,bx10)},
    art0(Def1,SN), {SN \== plu},  % den neste (nr) 3 buss
    filanepr(FLNP),
    nr1,
    busnumber(BusNo,BnameC), 
    {traceprint(4,bh10)}. 

bus_head(Def1,1,FLNP,BnounC,BnameC,BusNo)  ---> 
    {traceprint(5,bx11)},
    art0(Def1,SN), {SN \== plu},  % den neste (nr) 3 buss
    filanepr(FLNP),
    busnoun(BnounC,_U_,    _Sin),   %% bussen 5 \= bussen kl 5 %% ruter 9 ok?
    nr0,
    colon0, 
    busnumber(BusNo,BnameC), 
    not_look_ahead(w(noun(minute,_,_,_))), %% tar  bussen 10 minutter før %%  unnec?
    {traceprint(4,bh11)}. %% allow bus 331 

bus_head(Def1,Number,FLNP,BnounC,BnameC,BusNo)  ---> 
    {traceprint(5,bx12)},
    art0(Def1,_),   % (de) neste 3 buss 5
    quantnext(Number,FLNP),
    { Number < 10},  %% ridiculous?  %%  solves ti neste 
    busnoun(BnounC,_,plu),    
    busnumber(BusNo,BnameC), 
    {traceprint(4,bh12)}. 


bus_head(Def1,Number,FLNP,BnounC,nil,_BusNo)  ---> %%  BusNO Free
    {traceprint(5,bx13)},
    art0(Def1,plu),   % de neste 3 busser  -> Count
    quantnext(Number,FLNP), 
      { Number < 100},  %% ridiculous?  
    busnoun(BnounC,_,_Plu), 
    {traceprint(4,bh13)}.  %%  de fem neste buss //ok 


bus_head(Def1,Number,FLNP,BnounC,nil,_BusNo)  ---> %%  BusNO Free
    {traceprint(5,bx14)},
    art0(Def1,_),   %  neste 3 busser  -> Count
    quantnext(Number,FLNP),
    { Number =< 5}, %%  maxnumberofindividualdepartures(4)
    busnoun(BnounC,_,plu), 
    {traceprint(4,bh14)}.    



bus_head(Def1,1,FLNP,BnounC,BnameC,BusNo)  ---> 
    {traceprint(5,bx15)},
    art0(Def1,_),   %  neste 52 busser  -> BusNo
    filanepr(FLNP),
    busnumber(BusNo,BnameC), 
    {number(BusNo), BusNo > 5}, 
    busnoun(BnounC,_,_), 
    {traceprint(4,bh15)}.    


bus_head(Def1,1,FLNP,BnounC,BnameC,BusNo)  ---> 
    {traceprint(5,bx16)},
    art0(Def1,_),   %  (neste) 52 busser  -> BusNo
    filanepr(FLNP),
    busnumber(BusNo,BnameC), {BusNo \== 1}, %% 1 buss\=trikk
    busnoun(BnounC,_,sin), %% TA-101124
    {traceprint(4,bh16)}.    


%%  Vil 17 (SIC) bussen gå -> no such bus // EXPERIMENT
bus_head(u,1,nil,bus,number,BusNo)  --->  
    {traceprint(5,bx17)},
    not_look_ahead(w(name(_,n,route))), %% 17 not a route 
    w(nb(BusNo,num)), 
    {number(BusNo), BusNo > 5, BusNo =< 9999}, %% bus 9914 
    busnoun(bus,def,sin),     %% bussen 
    {traceprint(4,bh17)}. 

%% de neste 2 | de 2 neste 
bus_head(def,Number,FLNP,route,nil,_BusNo)  ---> %%  BusNO Free
    {traceprint(5,bx18)},
    [de],
    quantnext(Number,FLNP),
    { Number =< 5}, 
    not_look_ahead_np, 
    {traceprint(4,bh18)}.


bus_head(Def1,Number,FLNP,route,nil,_)  ---> %% 3 neste ()
    {traceprint(5,bx19)},
    art0(Def1,_),   
    quantnext(Number,FLNP),
    {FLNP \== nil}, %%  en ting er 4. ** 4 neste busser
    { Number > 0,Number =< 5}, %%  neste 0 = ingen 
    not_look_ahead_np, 
    {traceprint(4,bh19)},
    !.

bus_head(Def1,1,FLNP,BnounC,BnameC,BusNo)  ---> %% de neste buss 5 (SIC) 
    {traceprint(5,bx20)},
    art0(Def1,_), %% de/den
    filanepr(FLNP),
    busnoun(BnounC,_U_,    sin),   
    nr0,
    colon0, %% buss: 4
    busnumber(BusNo,BnameC), 
    not_look_ahead(w(noun(minute,_,_,_))), %% tar  bussen 10 minutter før ...
    {traceprint(4,bh20)}. %% allow bus 331 



% % 


art0(u,plu)   ---> [noen],look_ahead_np,!. 
art0(u,sin)   ---> [noe],!.  %% Hazard noe mat ? 

art0(D,S)   ---> art(D,S),!.
art0(u,nil) ---> [].

art(u,sin) ---> [en],!.
art(u,sin) ---> [et],!.
art(u,sin) ---> [ei],!. 

art(def,sin) ---> [den],!.
art(def,plu) ---> [det],!.
art(def,plu) ---> [de],!.


%%%¤  QUANTNEXT   3 neste| neste 3

quantnext(Number,FLNP) --->
    quant(Number),
    filanepr(FLNP),
    !.

quantnext(Number,FLNP) --->
    filanepr(FLNP),
    quant(Number),
    !.

quant00(1) ---> []. 


quant(Number) ---> w(nb(Number,num)).

filanepr(Next) ---> flnp(Next),!. %% flnp0 <--- better name 
filanepr(nil)  ---> [].

%%¤  BUSSENO (BusNo,BnounC,BnameC) 

busseno(BusNo,BnounC,BnameC) --->
    busnoun(BnounC,_,_),    
    nr0,
    colon0, %% buss: 4
    busnumber(BusNo,BnameC), 
    !.

busseno(BusNo,BnounC,BnameC) --->
    nr0,
    busnumber(BusNo,BnameC), 
    busnoun(BnounC,_,_),    
    !.

%%¤  BUSNO (BusNo,BnounC,BnameC) 

busnumber(BusNo,Class) ---> 
     optional(w(noun(route,sin,u,n))), %% assistansebuss rute 36 
     w(name(BusNo,n,Class)),
    {test(subclass0(Class,vehicle))},  
     not_look_ahead(w(noun(minute,_,_,_))), %% buss 10 minutter 
     not_look_ahead([':']), %% buss 11:15  
     point0, %% buss 6. mai \= buss 6
     not_look_ahead(w(name(_jan_,_,month))), %% buss 2 nyttårsdag 
     not_look_ahead(w(name(_jan_,_,day))),
     not_look_ahead(w(name(whitsun_day,_,date))), 
     not_look_ahead(w(name(christmas_day,_,date))),
     not_look_ahead(w(name(easterday,_,date))), 
     not_look_ahead(w(name(new_years_day,_,date))).

busnumber(BusNo,number) ---> %% hazard EXPERIMENT %% TA-101206 buss 118

     optional(w(noun(route,sin,u,n))), %% assistansebuss rute 36 
     w(nb(BusNo,num)), %% name(BusNo,n,Class)), %% //trap illegal busno

     not_look_ahead(w(noun(minute,_,_,_))), %% buss 10 minutter 
     not_look_ahead([':']), %% buss 11:15  
     point0, %% buss 6. mai \= buss 6
     not_look_ahead(w(name(_jan_,_,month))), %% buss 2 nyttårsdag 
     not_look_ahead(w(name(_jan_,_,day))),
     not_look_ahead(w(name(whitsun_day,_,date))), 
     not_look_ahead(w(name(christmas_day,_,date))),
     not_look_ahead(w(name(easterday,_,date))), 
     not_look_ahead(w(name(new_years_day,_,date))).




busse0(_C,Class,Def,SINPLU) --->
   busnoun(Class,Def,SINPLU),
   !.
busse0(C,C,u,sin) ---> [].%% optional, inherit class


%%¤ BUSSE  

busnoun(Class,Def,SINPLU) ---> 
    w(noun(Class,SINPLU,Def,n)),!,
   
       {test(subclass0(Class,vehicle))
      ; %% Class=departure;  %%*** 1 avgang 
        Class=number},
       %%           nr %%
    
    point0.  %% (buss nummer=buss) '.' 

  
%%%%%%%%%%%%%%%%%%%%


%% complex passover  går 52 neste gang

%%%¤ ANAME_PHRASE 


%% called if first item is  name,  make special treatment of

%% adjname_template


%% IKT-sjefen %% actually noun_phrase
aname_phrase(0,XT, P::P and Q) --->
    a0, 
    look_ahead(w(name(_IKT,n,_System))),
    preadjs(Alist), %% hastus = pre // no preadjs0  prisen kinosenter
	 %% TA-110510
 
    noun2(_Num2,_,n, XT, P0), 

    {preadjs_template(Alist,XT,P0,Q)},
    !.



aname_phrase(Ind,X, P::P and Q) ---> 
    w(name(N,n,route)), 
    w(adj2(next,nil)), %% Rough, skip next  default
    [gang],
    !,accept,
    namep(Ind,X,Q)\ w(name(N,n,route)). 
                   %% Rough, skip next  default
  


aname_phrase(_IND,_,__) ---> %% er sjåføren på 36  blid
    number(_),                %% 36
    not_look_ahead(w(prep(from))), %% e.g. [f]
    filanepr,  %% NB over = finished = adjective !!! (SIC)// 46 f = 46 fra
    !,
    reject.


% don't return  typed name unless vehicle

%% neste 8 busser  \= buss 8   /// neste 8 minutter OK

aname_phrase(_IND,_,__) ---> 
    dent0,  
    filanepr,  
    bus_number(_),    
    w(noun(Noun,plu,_,_)),   % certain, the number was a count
    {testmember(Noun,[bus])},         %  neste 3 timer 
    !,
    reject. 

%% OOPS halv åtte = "liten" buss 8
aname_phrase(_,_,__) ---> %% Hvilken holdeplass er nærmest Kolstad
    dent0,  
    w(adj2(Nearest,nil)), 
        gmem(Nearest,[nearest]), 
    %       etc
    w(name(Kolstad,_,_)),
    {\+ number(Kolstad)}, 
    !,
    reject.

%% en gps lokasjon -> backtract to en gps.
aname_phrase(Ind,XT, VP::P1) ---> %% oops  ferdig kl 14 #1 //returns msn (addresse)
    a0, %%  dent0,  %% includes "en"  %% nå var det 2 ulike busser  ->%% 2 var ulike busser  

%%     not_look_ahead(w(name(_odd_husbys_street,_,_))), %% TA-110103
%% odd(e) = funny

    preadjs0(Alist), %% 0   allow  en fin nyttårsaften %%
        not_look_ahead([jeg]), %% etc ad hoc
        not_look_ahead([du]),
    name_phrase(Ind,XT, VP::P0),

%%%% TEST    not_look_ahead_np, %% Longest first %% TA-110119 // * neste 52 samfundet
%%% Hazard ???
    {preadjs_template(Alist,XT,P0,P1)}.

aname_phrase(Ind,XT, VP::P1) --->    
    not_look_ahead([ett]), %% ett hotell = trikk *** 
    a0,        %% et amazon macine image %%  Haz?
    name_phrase(Ind,XT, VP::P1).


aname_phrase(name,XT, NSEM) --->  
    person_name(XT, NSEM,_).


%%¤  NAME_PHRASE (Ind,Var,NP)


name_phrase(0,NT2, P::Q) --->   % i tidsrommet  13.15 - 14.15  %%  13 15 14 15
    w(noun(time,sin,def,n)),  % difficult because - and '.' are missing
    w(nb(H1,num)),
    w(nb(M1,num)),
    to0,
    w(nb(H2,num)),
    w(nb(M2,num)),
    !,
    {N1 is H1*100+M1},   %% Ad Hoc
    {N2 is H2*100+M2},
    noun_phrases(NT2, P::Q) = (time1(N1),and1,time1(N2)). 


name_phrase(0,NT2, P::Q) --->  % i tidsrommet  1300 (til) 1400
    w(noun(time,sin,def,n)), % tidsrommet
    timexp(A), % expected clock
    to0,
    timexp(B),
    !,
    noun_phrases(NT2, P::Q)  \  (time1(A),and1,time1(B)). 


%% Problem : til risvollan området = risvollan [and to] området
%% name_complex before namep because of commit error
%% Hvor er TT webadressen NO / Hva er TT webadressen OK
%% hvor er tore ambles kontor  




%% Moholt stasjon -> stasjon moholt        %% busstuc serveren 
name_phrase(Ind,X, P:: ISA  and P ) --->   %% buenget stasjon 
    look_ahead(w(nb(_,_))),                %% 5 minutes <-  measure <- namep 
    namep(Ind,X,ISA),                      %% Preserve order of isa 
    not_look_ahead(w(noun(minute,_,_,_))). %% 5 (route)minutes  
  

name_phrase(Ind,X, P:: ISA  and P ) --->   %% buenget stasjon 
    look_ahead(w(nb(_,_))),                %% 5 minutes <-  measure <- namep 
    namep(Ind,X,ISA),                      %% Preserve order of isa 
    not_look_ahead(w(noun(minute,_,_,_))). %% 5 (route)minutes  


name_phrase(Ind,X, P::ISA and P) --->      %% yggdrasilveien 9c 7033 trondheim.
%%     not_look_ahead(w(nb(_,_))),
    namep(Ind,X,ISA).  


%%%¤  PERSON-NAME

person_name((Tore,Berg,Hansen):person, ToreP  and BergP and HansenP,GN) --->
    properfirstname(Tore,ToreP,_),
    properfirstname(Berg,BergP,_),   
    properlastname(Hansen,HansenP,GN),
    !,accept.


person_name((Tore,Amble):person, ToreP  and  AmbleP,GN) ---> 
    properfirstname(Tore,ToreP,_),
    properlastname(Amble,AmbleP,GN),
    !,accept.
 

properfirstname(Rønning,RønningP,GN) ---> 
   name1g(Rønning:firstname,RønningP,GN). %% 1g with genitive

properlastname(Rønning,RønningP,GN) ---> 
    name1g(Rønning:lastname,RønningP,GN). %% 1g with genitive



%%%%%¤¤  NP_HEAD (Ind, Var, Sem).

np_head(_,_,_) ---> %% ett tiden \= en tid %% Ad Hoc
    [ett],
     w(noun(time,_,def,_)),
    !,reject.


np_head(0, XT,  VP::P) --->  % de neste 5 gode dagene %% TA-101105
    the0,
    preadjs0(Alist),   
    quantifier(XT, P0 ,( P0 and VP):: P),  %% to første buss *
    !,
    preadjs0(Blist),   
    noun_complex(_Num,XT,Q0),         % but not 3 buss ( as 3 busser)
%%     {screenmeasure(Num,XT)},      %% mange minutter cant be measureclass
    {preadjs_template(Alist,XT,Q0,P01)}, 
    {preadjs_template(Blist,XT,P01,P0)}. %% TA-101105

np_head(Cind, XT,    NP) --->  
    determiner0(Num,Cind, XT,  P0 ,NP),  %% For Faen
    preadjs0(Alist), 
     {Alist=true -> Num1=Num;Num1= _}, 
    not_look_ahead(w(noun(crown,_,_,_))), %% kr 1 
    noun_complex(Num1,XT,Q0),    
%%     not_look_ahead(w(nb(_,_))), %% nummer 9871 DONT backtrack to  nummer 
                                   %% buss 17. mai <--- sorry/  hastighet 50 kmt
    {preadjs_template(Alist,XT,Q0,P0)}.   


% Våre 200 busser: -< DENNE AGENTS 200 BUSSER  ## 
np_head(0, XT, VP::(findpron(Y)::(exists(XT):: Q0 and YisaP  and VP))) --->
    thispron,
    noun(_,_Num,_,gen,  Y, YisaP),     % program's 
    look_ahead(w(nb(_N,num))),
    !,
    np0_accept(XT,HasYX::Q0), %% Peculiar
    {has_template(Y,XT,HasYX)}.


% his father =  this mans daughter Mary
np_head(0, XT, VP::(findpron(Y)::(exists(XT)::P0 and Q0 and YisaP and HasYX and VP))) --->
    thispron,
    noun(_,_Num,_,gen,  Y, YisaP),     % program's 
    !,
    preadjs0(Alist),         %% my last question 
    noun_compound(XT,Q0,_Sin), 

%%  våre kunder * bruker regtop .%% TA-110428
    not_look_aheadnounx , %% not_look_ahead(w(noun(_KMH,_,_,_))), %% TA-110128
                          %% // w(fører,noun(driver,sin,u,n)), 5).

    %% try longest possible

    {preadjs_template(Alist,XT,Q0,P0)},
    {has_template(Y,XT,HasYX)}.

not_look_aheadnounx ---> look_ahead(w(verb(_Use,_,fin))),!. %% bruker
not_look_aheadnounx ---> look_ahead(w(noun(clock,_,_,_))),!.   %% TA-110128
not_look_aheadnounx --->  not_look_ahead(w(noun(_KMH,_,_,_))). %%



%%%¤  NOUN_COMPLEX  (SINPLU, Var, Pred) 

%% Mars -planeten 

%%¤ NOUN_COMPLEX 

noun_complex(Sin,Mars:Place,Mars isa Place) --->  %% Mars planeten 
     not_look_ahead(w(nb(_,_))), %% 
     w(name(Mars,n,Neib)), 
     not_look_ahead(w(verb(_User,pres,fin))), %% Bruker noun|verb %% TA-110707
     w(noun(Planet,Sin,_Def,n)),     
     {joinclass(Planet,Neib,Place)},
     !.


noun_complex(sin,Mars:Planet,Mars isa Planet) --->  %% ruteperioden 'r1613_100329'
     w(noun(Planet,sin,_Def,n)),     
     w(quote(Mars)),
     !.

% airport nardo \= nardo isa neighbourhood

noun_complex(sin,Mars:Place,Mars isa Planet) --->  %%  TA-110816 Ambig: planeten Mars 
     w(noun(Planet,sin,_Def,n)),  
     not_look_ahead([du]), %% = name tuc  
     w(name(Mars,n,Neib)),                  %% RUTETILBUDET skjærtorsdag:
     not_look_ahead(w(noun(minute,_,_,_))), %%   unnec?
     point0,
     not_look_ahead(w(name(_Xmas,_,date))), %%  1. juledag  \== tram
     {joinclass(Planet,Neib,Place),Place \== nil}, %% buss munkegt=traffic
     !.


noun_complex(sin,NNNN:Year,NNNN isa Year) ---> %% år 1945 og 1946 %% ad hoc
     w(noun(Year,_,_,n)),                      %% fotnote 1
     w(nb(NNNN,num)),                          %% uke 42
     {testmember(Year,
         [footnote,page,sms,telephone,week,year])},  %% TA-101102
     and1,
     w(nb(_,_)), %% Ignore - ad hoc  
     !.

noun_complex(Sin,NNNN:Year,NNNN isa Year) --->  %% år(et) 1945 %% ad hoc
     w(noun(Year,Sin,_u,n)),                    %% fotnote 1
     w(nb(NNNN,num)),                           %% uke 42
     {testmember(Year,[footnote,page,sms,telephone,week,year,number])},  %% TA-101102
     !.

noun_complex(Sintef,N:Bus,N isa Bus) --->  %% buss no 5  \  AD HOC Når går de to neste buss no. 5
    w(noun(Bus,Sintef,_U,n)), %% bussen  6 
    {subtype0(Bus,vehicle)},  %% Not wednesday !!!
    plausibleno(Bus,N),
    not_look_ahead([ganger]),
    plausibleno(Bus,N),
    not_look_ahead_lit([sin,sitt,sine]), 
    not_look_ahead(w(name(_jan_,_,month))), %% Ad Hoc   buss 2    nyttårsdag.
    not_look_ahead(w(name(_jan_,_,date))),
    not_look_ahead(w(noun(_Kroner,plu,_,_))),
    !,accept.
  

noun_complex(plu,N:Bus,N isa Bus) --->  %% 5 buss(er/ene) %% AD HOC
    plausibleno(Bus,N),
    w(noun(Bus,sin,u,n)),     %% _sin   to neste 36 bussene  
    {subtype0(Bus,vehicle)}. 

noun_complex(Num,X,P) --->  % bus and tram 
    noun_list(Num, X,P),
    not_look_ahead_lit([sin,sitt,sine]),
    not_look_ahead(w(nb(_Eight8,_))). %% avganger rute 8 finnes. 
                                 %% hazard ?

noun_complex(Num,X,P) --->  
    not_look_ahead([noe]), %% går det noe tog
    not_look_ahead([min]), %%
    noun_compound(X,P,Num). %  mans daughter (Mary)


%%%%¤¤ PLAUSIBLENO  Plausible Bus number

plausibleno(_,_) ---> 
   num(_),
   point,    %% 1.mai
   monthnamex, 
   !,
   reject.

plausibleno(_,_) ---> 
   num(_),
   colon,    %% buss 14:15
   !,
   reject.



plausibleno(_,_) ---> 
   num(_),
   monthname(_),  %% går buss 5 påskedag 
   !,
   reject.

plausibleno(_Bus,N) ---> 
    nr0,  %% nr is dummy
    num(N),
    {N > 0, N < 1000}.  %% Plausible Bus no (Buss 777)

plausibleno(_Bus,N) ---> 
    nr0,  %% nr is dummy
    w(nb(N,alf)),  %% 4a is a plausible bus
    {N < 1000}.  %% Plausible Bus no (Buss 777)


%---------------------------------------------------------------

%% NPA  Noun Phrase Anaphoric


npa(X:T, VP::(findexternal(X:T):: (X isa T and VP))) ---> %% når er jeg fremme
    one_of_lit([det,dette]),  
    look_ahead(w(adv(_Sikkert))), %% NB also adjective  //riktig/bra/Haz 
    !,
    {T=thing}. 


npa(X:T, VP::(findexternal(X:T):: (X isa T and VP))) ---> %% når er jeg fremme
    [dette],  %% dette is never internal 
    not_look_ahead_np,%%  da er dette riktig // should forbid adj. def form
    {T=thing}. %% <--- NB   was coevent   


npa(X:T, VP::(findexternal(X:thing):: (X isa T and VP))) ---> %% det ønsker jeg
    [det],  %% NB Hazard ???  
    look_ahead(w(verb(_,_,fin))),
    not_look_ahead_np.


npa(Y, VP::(findit(X)::P))---> 
    its,
    determiner00(Y,A and H, VP::P), 
    noun_compound(Y,A,_),
    {has_template(X,Y,H)}.


%% This (fine)  place must never relapse to pronoun(this)
npa(_X, __) ---> %% er  

     this,         %% dette
     look_ahead_np,    %% dårlig  
     !,reject. 

npa(X, P::(find(X)::(Q and P))) --->  
    noun(_,_,def,n,X,Q).                %% bussen  (Only singular)


 
npa(X:T, VP::(findexternal(X:T):: (X isa Man) and VP)) ---> %% denne er fin
    [denne], 
     not_look_ahead(w(adj)), %%
     not_look_ahead(w(noun(_,_,_,_))),
    {Man=thing},
    {type(Man,T)}.                


npa(X:T, VP::(findpron(X:T):: (X isa thing) and VP)) ---> %% når er jeg fremme
    [det],
    endofline, %% hvor er det ?
    {type(thing,T)}.           


npa(X, VP::P) --->  
    allsome0, %% alle | noen av .. mine problemer %% TA-110428
    posspron(Man),
    w(nb(N,num)), %% alle våre 200 busser
    np1(X, VP::P)  
         \  ( thispron , w(noun(Man,sin,u,gen)), w(nb(N,num))). 


npa(X, VP::P) --->  
    allsome0, %% alle mine problemer 
    posspron(Man),

    np1(X, VP::P)  
         \  ( thispron , w(noun(Man,sin,u,gen))). 



npa(X, NP) ---> %%  når går de 5 neste til TS
    [de],
    w(nb(Five,num)),
    flnp(Adj),   
    not_look_ahead(w(name(_,_,_))), %%  1. nyttårsdag
    not_look_ahead(w(noun(_,_,_,_))), 
    !,
    np1(X, NP)  \  (w(nb(Five,num)),w(adj2(Adj,nil)),
                    w(noun(vehicle,sin,u,n))). 

npa(X, VP::P) ---> %%  når går (den/det)NEST siste til TS 
    dent0,

    not_look_ahead([først]), %% adverbs! 
    not_look_ahead([sist]),
    not_look_ahead([senest]),
    not_look_ahead([tidligst]),

    nest,     %%
    flnp(Adj),               %% flnpproper 
    not_look_ahead(w(noun(_,_,_,_))), 
    !,
    np1(X, VP::P)  \  
        (w(adj2(second,nil)), %% tricky
         w(adj2(Adj,nil)),
         w(noun(vehicle,sin,u,n))).



npa(X, VP::P) ---> %%  når går (den/det) neste til TS
    dent0,

    not_look_ahead([f,s,først,sist,senest,tidligst]), %% TA-101029
                   %% bare s:  ikke det siste kjøretøyet
    flnp(Adj),   
       not_look_ahead(w(name(_,_,_))), %% 1. nyttårsdag
       not_look_ahead(w(noun(_,_,_,_))), 
    !,
    np1(X, VP::P)  \ (a,w(adj2(Adj,nil)),
                     w(noun(vehicle,sin,u,n))), 
    optional(w(noun(bus,sin,_,_))). %% neste etter kl 1200 bussen (SIC)


npa(X, IT) ---> %%  når går DEN  = it 
    {value(busflag,true)}, 
    [den],
    not_look_ahead(w(adj2(_,nil))),
    not_look_ahead(w(noun(_,_,_,_))), 
    !,
    npit(X,IT).      %% unreslved, avoid går den til NTH (den := NTH)


npa(X, VP::P) ---> %%  \ busflag, den = thing 
    [den],
    not_look_ahead(w(adj2(_,nil))),
    not_look_ahead(w(noun(_,_,_,_))), 
    !,
    np1(X, VP::P) =  (this,w(noun(thing,sin,u,n))). %% anaphor



npit(X:T,VP::(X isa T and VP)) ---> 
    {it_template(X:T)}.



adjnoun ---> w(adj2(nil,nil)).
adjnoun ---> w(noun(_,plu,u,_)). % 3 buses

% Must be qualified " !!! %% not  1700 lørdag 


%%¤  NP2    some special constructions


np2(X, NP1) ---> %  noe spennende = (en) spennende ting
    [noe],
    w(adj2(Good,Nil)),
    not_look_ahead_np, %% TA-110725 \+ litt stor
    !,
    np_kernel(0, X, NP1)=
        (w(adj2(Good,Nil)),w(noun(thing,sin,u,n))). %% 
  

%% 1525 avgangen

/*  ** går noen ^~ noen går(vp) %% TA-110823

np2(X, NP1) ---> %  noen prøver å like deg 
    [noen],
    look_ahead_vp, %% ** går noen ^~ noen går(vp)
    !,
    np_kernel(0, X, NPK)=w(noun(thing,sin,u,n)), %% agent?
    noun_modifiers0(0,X,NPK,NP1).

*/

np2(X, NP1) ---> %  noe i forhold 
    [noe],
    look_ahead(w(prep(_In))),
    !,
    np_kernel(0, X, NPK)=w(noun(thing,sin,u,n)), %% 
    noun_modifiers0(0,X,NPK,NP1).


np2(X, NP) ---> 
    clock_kernel(N:clock,N isa clock),
    w(noun(Dep,sin,_Def,n)), 
        {testmember(Dep,[departure,arrival])},
    !,
    np1(X, NP)=  (w(noun(Dep,sin,def,n)),w(prep(at)), clock_kernel(N:clock,N isa clock)), 
    !.


% fra sentrum buss 5 \-> fra (sentrum buss) 5 

np2(X, NP) ---> %% andre busser enn = busser unntatt 
    anders,
    w(noun(Bus,SP,U,n)),
    [enn],
    !,
    np1(Y,NP1),
    !,
    np1(X, NP)=  (w(noun(Bus,SP,U,n)),w(prep(except)), xnp(Y,NP1)),
    !.                                 



anders ---> [andre],!.
anders ---> [en],[annen],!.

np2(X, NP) ---> %% samme A som B = A prep(equal) B
    [samme],
    w(noun(Bus,sin,u,n)),
    [som],
    !,
    np1(Y,NP1),
    !,
    np1(X, NP)=  (w(noun(Bus,sin,def,n)),w(prep(as)), xnp(Y,NP1)),
    !.                                   %%%%%%%%%%%%%

np2(X:Route, Y:: (Bing and Y)) ---> %% Fara bussruter
    w(name(Fara,n,Company)), gmem(Company,[company]),
    w(noun(Route,_,_,n)),     {subclass0(Route,vehicle)},
    {Bing= (exists(X):: (X isa Route and Fara isa Company and adj/nil/Fara/X/real))}. 

/*
np2(X, NP) ---> %% IKT-sjefen
    w(name(IKT,n,_)), 
    w(noun(Boss,_,_,n)), %% sjefen   
    {adjname_template(nil/IKT,X,real,NP)},
*/



 

np2(X, NP) ---> %% Ad Hoc    %% Tåsen bussen = Buss til Tåsen
    w(name(Tåsen,n,Neighbourhood)), 
        {testmember(Neighbourhood,[neighbourhood,station,street])},
        {\+ testmember(Tåsen,[sentrum])}, %% 
    w(noun(Bus,_,_,n)),
    not_look_ahead([nr]), %% til samfundet buss nr 5 %% TA-101206
    not_look_ahead(w(nb(_,_))),  %% NB til valgrindveien rute 9 =* til (valgrindveien rute) 9 
    {subclass0(Bus,vehicle)}, 
    !,accept,
    np1(X, NP)=  (w(noun(Bus,sin,def,n)),w(prep(to)),w(name(Tåsen,n,Neighbourhood))),
    !.


np2(X, NP) ---> %% Ad Hoc   2007 is year 2007
    w(nb(T2007,num)),
    {this_year(T2007)},

    not_look_ahead(['-']), %% 2009-05-17 ***
    not_look_ahead(w(nb(_,_))), %% 


    !,accept,
    np1(X, NP)= ( w(noun(year,sin,u,n)) ,w(nb(T2007,num))),
    !.


np2(X, NP) --->
    oter,
    w(noun(Bus,_,u,n)),
    [enn],
    !,
    np1(X, NP)\ (a,  w(noun(Bus,sin,u,n)),[ulik]).


% Meant to cover  Hva er den nærmeste stasjonen til
% Must be refined : går bussen til munkegate nærmeste time



%  np1 calls noun_mods which locks


np2(X, VP::P)--->                  %% lacks complements !!!!
    not_look_ahead([alle]),      %% Precaution  går alle bussene
%%     not_look_ahead([alt]),       %% er alt bra ??? 
    not_look_ahead(w(name(_ALT_Statoil,_,_))), %% ALT is a partname 
    quant_pron(every,Person), 
    np1(X, VP::P)
         \  ( every,w(noun(Person,sin,u,n))). %%
 

np2(X, NP)--->      %% lacks complements !!!!
    quant_pron(every,Person), 
    not_look_ahead([som]), 
    not_look_ahead_np,  
    np0_accept(X, NP)
         \  ( every,w(noun(Person,sin,u,n))). %%


np2(X, NP)--->      %% lacks complements !!!!
    quant_pron(some,Person), 
    rfxpron0, %% TA-110824 kommer en (seg)
    not_look_ahead([som]), 
    not_look_ahead_np,
    np00(Person,X,NP).


%% 

clock_number(N:T) ---> 
    number(N:T),
    {clock_test(N)},
    !.


bus_number(N:T) --->
    number(N:T),
    {plausible_busno(N)}.


road_number(N:T) ---> 
    number(N:T),
    { N =< 200 }.     %% Brøsetvegen 168 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%  NOUN LIST:  separate single nouns

%% they must have something in common

%%  jeg arbeider i påsken og bussen går.

noun_list2(Num, X,Q) --->    %% name [, address] and phonenumber  of 
    noun(_,Num,u,n, Y, P),      %  first noun decides  Num    
    nlists10(Y,P,X,Q).
 
 
nlists10(X:TX,P, (X,Z):(TX,TZ),P and R) ---> 
     comma,  %% rett svar \=  right and answer
     noun(_,_,_,n, Y, Q),
     nlists10(Y,Q,Z:TZ,R).

nlists10(X:TX,P, (X,Z):(TX,TZ),P and R) ---> 
     andor(_),
     noun(_,_,_,n, Z:TZ, R).


%%%¤ NOUN_LIST 

noun_list(Num, X,Q) --->
    not_look_ahead([noe]),  %% qua noun(thing)
    not_look_ahead([noen]), 
    not_look_ahead([min]), %% minutes %% mannen min
    not_look_ahead(w(adj2(_,nil))), %% kort 
    noun(C,Num,_,n, Y, P),   %%   Den neste timen
    {\+ testmember(C,[clock])}, 
    nlists0join(Y,P,X,Q).
 
nlists0join(Y,P,L:LJoin,Q) --->
   nlists0(Y,P,L:Clist,Q),

   {joinclasses(Clist,LJoin)}, 

   !,accept, %%  planeten mars, dont backtrack to planeten  ??? 

   {LJoin \== thing}.  %% jeg arbeider i (påsken og bussen) går. *


%%%¤ NLISTS0 

nlists0(X:TX,P, (X,Z):(TX,TZ),P and R) ---> 
     [og],   %% optional([og]),   %% når går bussen boss
     not_look_ahead_lit([da,så,min]), %% TA-110527 minutes

%%%     not_look_ahead(w(noun(_owner,sin,def,n))), %% du er bare en datamaskin og  eieren er dum
                          %% hva er meningen med livet og universet    
     noun(Ticket,_,_,n, Y, Q),            
         not_look_ahead(w(prep(_))), %% bussorakelet og busstidene til buss er * fe

     {joinclass(TX,Ticket,XXX)}, {XXX \== thing, XXX \== nil},
                                %% ad hoc 
     nlists0(Y,Q,Z:TZ,R).


nlists0(X,P,X,P) ---> [],
    not_look_ahead(w(noun(_,_,_,_))). %% try one more %%




postcode(X) --->
    w(nb(X,num)),                            %% 7041 Trondheim 
    { number(X), X >=1000 , X=<9999},
    look_ahead(w(name(_Th,n,Neib))),
      {testmember(Neib,[city,neighbourhood,station])}. %%  7082 Kattem


%------------------------


%% This mans wifes house =  man has wife and wife has house
%% Find man
%                               % er 42 meningen =\= 42 meninger
%                               % 5 de to første buss *

% rute opplysninger tidspunkt NO
% rute opplysninger           OK


%%%¤ NOUN_COMPOUND (X, QP, SIN)

noun_compound(X,QP,sin) --->  % Buss 6 sin avgang
    not_look_ahead([man]), %% one 
    namep(_Ind,Y,P),       %% buss 6
    sin,  
    ncomps0(gen,X,Y,P,QP,_). 


noun_compound(X,XisaBus and QP,Num1) ---> % ... TT bus 
    not_look_ahead([dere]), %%  =tt 
    w(name(TT,_N,_)),                     % May be unknown to DICT
    noun(_Bus,Num1,u,n,  X, XisaBus),
    {adjnamecomp_template(TT,X,QP)}.



noun_compound(X,QP,Num1) --->  % X is the innermost
    not_look_ahead([man]), %% one 
    noun2(Num2,U,GN1, Y, P),
    {Num1=Num2},             %% Number agreement  RELAX ??? 
    s0(Num2,U,GN1,GN2),           %% bussen sine stasjoner 
    ncomps0(GN2,X,Y,P,QP,_). 


morenames(X,(X,Z)) ---> 
    unplausible_name(Y), 
    morenames(Y,Z).

morenames(X,X)---> [].

unplausible_name(X) ---> w(name(X,unknown,_0)),!,accept.


                          
ncomps0(gen,X,YT,P,Q,0) ---> %% NB gen ( har ) team[s] dårlig service
                             %% dagens første avgang || NOT buss 8A 
%%  not_look_ahead(w(verb(_Reise,pres,_))), %% kan en voksen reise  %% be1 ok .. hvor er   %% Turings test
    preadjs0(Alist), 
    ncomps(X,YT,P1,Q),
    {preadjs_template(Alist,X,P,P1)}.  


                                       %% NB repair
ncomps0(n,X:Neib,X:Neib,P,P,0) ---> %% NB 0=noun 
                    %%  (til) risvollan området = risvollan if risvollan:neibourhood
     w(noun(Neib,_Sin,_Def,n)).        %%   erlendsveg vegen


ncomps0(n,X1,X2,P,P,name) ---> % if previous was n, then optionally no more.
    {compatvar(X1,X2)}.


ncomps(X,Y,P,QP) --->
    noun2(_,_,GN, Z, Q), %% tts billett priser
    {has_template(Y,Z,H )}, 

    ncomps0(GN,X,Z,P and Q and H,QP,_).



% hvilke agent(er)(en)(s) = (sine) = agent(s)%%
% s0(          X   Y   Z )          =  U

s0(_,_,n,gen) ---> sin.    %% NB NEW argument num
s0(_,_,n,gen) ---> [s]. 

s0(sin,u,n,n) --->   [].     %% bussen stopper \= bussens stopper

s0(sin,def,n,n) ---> [].  %% team tjenesten

%% s0(sin,def,n,n) ---> [].     %% morgen bussen // (passerer)
                                  %% bussen stasjonen * 

%% s0(sin,def,n,n) ---> [].  %% jeg skylder mannen penger 
                               %% \=          mannens penger

% mine problemer = dette selvets problemer 
s0(plu,u,n,n) --->   [].  %% agenter jobber \= agentenes jobber

%  (Har) studenter rabatt \= har studenters rabatt
%  Problem    rute opplysninger tidspunkt   :NO
%             rute opplysning tidspunkt     :OK

s0(plu,def,n,n) ---> [].     %%  bussene nummer \= bussene sine nummer
                               %% buss rutene

s0(_,_,gen,gen) ---> [].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%¤ NOUN_MODIFIERS0 

noun_modifiers0(OP,X, Q::NP,P::NP) ---> %% Paradox
        noun_modsx0(OP,X,P,Q).


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %


%%¤  NOUN_MODSX0 (0,X:T,P1, P)

noun_modsx0(0, X, P, Q) --->  % not serial nonnested rel_clauses  % not name
    rel_clauses(X,P,Q).     %% TA-110112      % avgang til 5 som går til nth  *

 
noun_modsx0(0,X:T,P1,    %% årsaken til at
        P1  and NewS isa coevent and BINGO and P2) ---> 
    {testmember(T,[cause])}, 
    [til],
    [at],
    !,
    clausal_object1(NewS:coevent,true::P2),
    {noun_compl(to,X:T,NewS:coevent,BINGO)}, %% of? 
    !,accept.  


noun_modsx0(0,X:T,P1,    %% måter for å  spørre
        P1  and NewS isa coevent and BINGO and P2) ---> 
    {testmember(T,[way])}, 
    [for],
    [å],
    !,
    clausal_object1(NewS:coevent,true::P2)\[noen],  
    {noun_compl(regarding,X:T,NewS:coevent,BINGO)},
    !,accept.  


noun_modsx0(0,X:T,P1,    %% måter for hvordan man kan spørre
        P1  and NewS isa coevent and BINGO and P2) ---> 
    {testmember(T,[way])}, 
    [for],
    [hvordan],
    !,
    clausal_object1(NewS:coevent,true::P2), 
    {noun_compl(regarding,X:T,NewS:coevent,BINGO)},
    !,accept.  


noun_modsx0(0,X:T,P1,        %% (spørsmål) om hvor viktig det er
        P1  and NewS isa coevent and BINGO and P2) ---> 
    {testmember(T,[question])}, 
    [om],
    [hvor],
    w(adj2(Important,nil)),
    !,
    clausal_object1(NewS:coevent,true::P2) 
         -  w(adj2(Important,nil)),
    {noun_compl(regarding,X:T,NewS:coevent,BINGO)},
    !,accept.  



noun_modsx0(0,X:T,P1,        %% ( eksempel) der bussen går
        P1  and NewS isa coevent and BINGO and P2) ---> 
    {testmember(T,[example])}, %%
    [der], %% hvor ...
    !,
    clausal_object1(NewS:coevent, true::P2), %% der bussen går 
    {noun_compl(on,X:T,NewS:coevent,BINGO)}, %% eksempel på 
    !,accept.  


noun_modsx0(0,X:T,P1,        %% et argument for å 
        P1  and NewS isa coevent and BINGO and P2) ---> 
    {testmember(T,[cause])}, %% argument
    optional([for]),
    [å],
    !,
    clausal_object1(NewS:coevent,true::P2) 
         \(someone,aux1), %% ad hoc., noen
    {noun_compl(for,X:T,NewS:coevent,BINGO)},
    !,accept.  



noun_modsx0(0,X:T,P1,        %% lov (til) å røyke 
        P1  and NewS isa coevent and BINGO and P2) ---> 
    {testmember(T,[permission,possibility])}, %% lov
    optional([til]),
    [å],
    !,
    clausal_object1(NewS:coevent,true::P2) 
         \(someone,aux1), %% ad hoc., noen
    {noun_compl(to,X:T,NewS:coevent,BINGO)}, %% to infinitive
    !,accept.  


noun_modsx0(0,X:T,P1,        %% beskjed om å løpe
        P1  and NewS isa coevent and BINGO and P2) ---> 
    {testmember(T,[notification,request,plan,wish])}, %% beskjed|ønske   
    [om],[å],                           %% TA-101124
    !,
    clausal_object1(NewS:coevent,true::P2) 
         \(someone,aux1), %% ad hoc., noen
    {noun_compl(about,X:T,NewS:coevent,BINGO)},
    !,accept.  


noun_modsx0(0,X:T,P1,   
        P1  and NewS isa coevent and BINGO and P2) ---> %% sammenheng med at
    {constrain(X:T,connection)},   
    w(prep(with)),
    [at],
    !,
    clausal_object1(NewS:coevent,true::P2), 
    {noun_compl(with,X:T,NewS:coevent,BINGO)},
    !,accept.  



noun_modsx0(0,X,P1,P1  and P2) ---> %% en måte til/for/med/av/ å
    {constrain(X,way)}, 
    in_order_tox, %% infinitive  
    lexv(tv,Take,inf,fin), %%   ta buss
    np1(A, B::C),
    fictitiousprep(way,In),
    !,
    statreal(P2)\ (someone, w(verb(Take,pres,fin)),
              np1(A, B::C),prep(In),npgap(X)).



noun_modsx0(0,X,P1,P1  and P2) ---> %% en måte til/for/med/av/ å
    {constrain(X,way)}, 
    in_order_tox, %% infinitive  
    lexv(iv,Come,inf,fin),  %%  komme  
    fictitiousprep(way,In),
    !,
    statreal(P2)\ (someone, w(verb(Come,pres,fin)),
             prep(In),npgap(X)).

%% TA-101025
noun_modsx0(_, _XT ,P, P) ---> %%  buss den 23.10 %% NB buss den 23.10
    look_ahead([den]), %% (Buss fra) sentrum den 23.10 
    !,accept.   


noun_modsx0(_, XT ,P, P) ---> %% (før) ettermiddagen kl 1800
   {vartypeid(XT,Afternoon),
    subclass(Afternoon,daypart)}, %% 5 min. før bussen ...
    not_look_ahead(w(prep(_To))), %% natt til 27.12. 
   !,accept.   



noun_modsx0(OP,X,P,Q) ---> 
        noun_mods(OP,X,P,Q),
        !. %% TA-110510

noun_modsx0(_OP,_X,P,P) ---> []. 



fictitiousprep(way,in) ---> [].
fictitiousprep(abstract,with) ---> []. %%  with possibility


%% TRICKY

%    lengden til meg * ikke qua possessive
%    lengden til man *
%    lengden til en *
%    lengden til en buss   OK


%%%%¤  NOUN_MODS0   noun modifiers


%% POSSESSIV TIL  %% adressen til Tagore

%%%¤ NOUN_MODS 

noun_mods(0,Y,P1,P1 and P2) ---> %% // should be def adressen Possesive 'til'

    {vartypeid(Y,M), 
     testmember(M,[address,email,mind,mailaddress,telephone,webaddress])}, %% Ad Hoc  \+  råd til
                           %% TA-110622
    prep1(to),                    %% but not adverbial
       {vartypeid(Y,N),
     \+ testmember(N,[name])}, %%%% ,address]) }, %% special treatment 

    not_look_ahead(w(nb(_,_))),   %%  til 09.30
    not_look_ahead(w(prep(_In))), %% et sted til i

    not_look_ahead_lit([deg,meg,seg]), 

    not_look_ahead(w(noun(station,_,_,_))),   %% fra holdeplassen (på A) |til holdeplassen på B
    not_look_ahead(w(name(_,_,station))),
    not_look_ahead(w(name(_,_,neighbourhood))), %% hpl til risvollan/buss til samfundet
    not_look_ahead(w(name(_,_,city))), %% buss til trondheim %% trondheim har buss
    statreal(P2)  \                                   
        (npgap(Y),w(verb(evah,pres,fin))).




noun_mods(0,Y,P1,P1 and P2) ---> %% email tore amble
    {value(teleflag,true)},
    not_look_ahead(w(prep(_))),
    {vartypeid(Y,EM)},  
    {\+ vartypeid(EM,[])}, %% ad hoc
%%%     look_ahead(w(name(_,_,_))),   %% jeg vet hva du heter
    statreal(P2)  \   
        (npgap(Y),w(verb(evah,pres,fin))).

         
noun_mods(0,X,P,R) --->    %% last dominates first
   noun_mod(X,P,Q),                %% not _ind = name  !!!!!  %% not and here
   !,accept,  
   noun_modsx0(0,X,Q,R).  %% x  fra brukere før bussen går
 

%% noun_mods(0, _ ,P, P) ---> []. %% MYST
%% noun_mods(name, _,P, P) ---> []. %% /buss/ 5 til nth fins *** 


%% noun mods0  following name ( (Bussavgang fra ) Værnes || etter en  flyankomst fins.

 
noun_mods(name,X,P,R) --->  %% 7 fra munkegata (til ikea) %% Haz?
   {vartypeid(X,C),subclass0(C,vehicle)},
   look_ahead(w(prep(On))), 
      {testmember(On,[to,from])},
   noun_mod(X,P,Q),      
   !,accept,  
   noun_mods(name,X,Q,R). 
 
noun_mods(name,X,P,R) --->  
   look_ahead(w(prep(On))), 
      {testmember(On,[on,towards])}, %% postterminalen på sluppen
                                     %% nova mot sentrum
   {vartypeid(X,C),subclass0(C,place)}, %%  jeg på NTH*
   noun_mod(X,P,Q),                %% not _ind = name  !!!!!  %% not and here
   !,accept,  
   noun_mods(name,X,Q,R). 

/*  vet tuc hvor sandvika er *** %% TA-110314
noun_mods(name, X, P, Q) --->  % fra munkegata som går 
         { vartypeid(X,Gumbo)}, 
         {\+ testmember(Gumbo,
             [station,neighbourhood,street])}, %% TA-110110 %% til buran  som ankommer
         rel_clauses(X,P,Q).            % avgang til 5 som går til nth  *   % RESTRICTION
*/

noun_mods(name,X,P,R) --->     %% last dominates first
   {value(textflag,true);
     value(teleflag,true)}, 
   noun_mod(X,P,Q),     
   noun_mods(name,X,Q,R). 

noun_mods(name,X,P,P and Q) --->  %%  Tore Amble Oslo
    {value(teleflag,true)},  
    {constrain(X,person)},
    w(name(Oslo,n,Place)),
    {subclass0(Place,place)},
    noun_mod(X,P,Q)\  
         (prep1(in), w(name(Oslo,n,Place))).
        

%%% noun_mods(name, _,P, P) ---> []. %% /buss/ 5 til nth fins *** 



%%%¤  NOUN_MOD (X:T,P1, P1   and BINGO and P2) 



noun_mod(X:T,P,  nrel/nil/day/clock/X/Y and P and YP ) --->  %% torsdag kl 10 %% TA-101109
    {constrain(X:T,day)},  %% Dirty, clock must come first (?) because usage
                           %% is that time appears first, otherwise verb_mod is used
    clock,                 
    clock_sequel(Y:_U,YP).


% hva er avgangstid nå

noun_mod(B,P,P and R) ---> % bus now %%  moved forward
     adverb(Fast,Q,_),     %% NB \+ av
     {noun_adverb(B,Fast,Q,R)}, %% whatever that may be
     !. %% TA-101108




noun_mod(X:T,P1, P1 and BINGO and P2) ---> %% forutsetningen for å ta buss
    [for],[å],                             %% TA-110427
        gmem(T,[condition]), %% etc 
    !,
    clausal_object1(NewS:coevent,true::P2)\[noen],
    {noun_compl(for,X:T,NewS:coevent,BINGO)},
    !,accept.  


noun_mod(X:T,P1, P1   and BINGO and P2) ---> %% melding (fra publikum) om at 
    [om],[at],
        {testmember(T,[information,message,notification,question])},
    !,
    clausal_object1(NewS:coevent,COM2::P2),  {COM2 = true}, %% bussen står
    {noun_compl(regarding,X:T,NewS:coevent,BINGO)},
    !,accept.  


noun_mod(Y,P,P and Q) --->  %% bussen din        %% TA-101206
       %%  not_look_ahead(w(name(_nissen,_,_))), %% hans Nissens gt %% UNNEC
    posspron(Self),  %% Norwagism min/din  
    statreal(Q)  =    %% er bussen min presis 
        (pronoun(Self),w(verb(have,pres,fin)),npgap(Y)).

 

noun_mod(X,P,P and Q) ---> 
    look_ahead(w(adj(_,comp))), % er (rutene forskjellig fra juleruter)*
    comparison(X,_,Q).     


noun_mod(X,P1,P1 and P3) ---> %% en mann ikke på bussen ???
    negation0(N),        
   {\+ vartypeid(X,self)}, %% skal (jeg på jobb) // vi i team %% 
                           %% vi gleder oss til veien videre %% TA-110128
    adjunct1(Prep,Y, NotP2::P3), %% _accept too Haz
    {noun_compl(Prep,X,Y,P2)},
    !,accept,  
    {negate(N,P2,NotP2)}.



noun_mod(X:T,P1,P1) --->  %% buss til nth nr 52 
    {constrain(X:T,vehicle)}, 
    numberroute, %% nummer/rute 
    num_na(N),
    {N=X}.

%%  complement without preposition is hazardous

%% These are special cases, only name complements


noun_mod(B,P,P and DayX) ---> % buss  fredag 
     day(Saturday),
            
        np1(D, Day::DayX) = w(noun(Saturday,sin,u,n)), %% not bus 24.08.2000 = bus 24...

    {noun_compl(nil,B,D,Day)},
     !,accept.


noun_mod(B,P,P and DayX) ---> % buss  natt (til 25.12)
     w(noun(midnight,_,_,n)),
     np1(D, Day::DayX) \ w(noun(midnight,sin,u,n)),
    {noun_compl(nil,B,D,Day)},
     !,accept.



noun_mod(B,P,P and DateX) ---> % buss julaften 
     obviousdate(D, Da::DateX),
    {noun_compl(nil,B,D,Da)},
     !,accept.


noun_mod(B,P,P and ClockX) ---> % buss 8:30 
     obviousclock(D, Da::ClockX), 
    {noun_compl(nil,B,D,Da)},
     !,accept.

noun_mod(B,P,PDIR) --->   % buss retning sentrum
     w(noun(direction,_,_,_)),  
     nameq1(Dest,Q),
     !,
     noun_mod(B,P,PDIR) \ %% NB RECURSION
       (  w(prep(towards)),
          nameq1(Dest,Q) ),
     !,accept.


noun_mod(B:T,P,P and DateX) ---> % pris voksen \+ buss tempe !!!

     {  test(semantic:n_compl(nil,T,_))   }, %% screening %% OOPS, \+ noun_compl
        %%%% otherwise, Prolog will try them all
     np1_accept(D, Da::DateX),
     {noun_compl(nil,B:T,D,Da)},
     !,accept.


% \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

% bus 8.10   is 8:10 o'clock
% bus 8 must not be  at 8 o'clock


% //////////////////////////

 
% E N D  NOUN PHRASE SECTION
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METAGRAMMAR SECTION

begin ---> []. %% ad hoc
end --->   []. %% ad hoc

accept  --->  [].     %%  JUST FOR EMPHASIS ! and SPY 
reject  --->  {fail}. %%  METAPROGRAMMING


%% hvilket land er oslo hovedstaden til ? ? ?

%% noun_mods(Ind, X,P, Q) 

%  Ind = Indicator of type of expected noun_mod

%    of     of expected
%    name   complements to a name
%    0      ordinary (noun)
%    1      at least one more

%  some restructuring of  noun_mods 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% LOOK-AHEAD SECTION %%%%%%%%%%%%


%%%%%%% 

look_ahead_place ---> 
    look_ahead(w(name(_,_,X))),
    {test(subclass0(X,place))}.


look_ahead_conjuction --->   %% ad hoc 
     look_ahead([før]).

look_ahead_conjuction --->   %% etc ad hoc
     look_ahead([etter]). % .. at

look_ahead_conjuction --->  
     look_ahead([når]).


not_look_ahead_flnp --->
   look_ahead(w(adj2(A,nil))),  
   {testmember(A,[first,last,next,previous])},
   !,reject.
not_look_ahead_flnp ---> [].

  
not_look_ahead_flnp --->  
    look_ahead(w(adj2(A,nil))),
    {testmember(A,[first,last,next,previous])},
    !,reject.
not_look_ahead_flnp ---> [].


not_look_ahead_vehicle --->
   look_ahead(w(noun(Bus,_,_,_))), 
   {test(subclass0(Bus,vehicle))},
   !,reject.

not_look_ahead_vehicle --->   
   look_ahead(w(noun(Dep,_,_,_))), 
   {testmember(Dep,[departure,arrival])},
   !,reject.

not_look_ahead_vehicle ---> [].

 
not_look_ahead_day --->    
    look_ahead(w(noun(Friday,_,_,_))), 
    {Friday ako day},
    !,reject.
not_look_ahead_day ---> [].



%% not_look_ahead_noun ---> w(noun(clock,_,_,_)),!. %% bussen er  gul klokken 15 OK
not_look_ahead_noun  --->  not_look_ahead(w(noun(_,_,_,_))).
      %%     not_look_ahead(w(name(_,_,_))). %%1=tram 
 

look_ahead_timeclause --->
     look_ahead(w(noun(clock,_,_,_))). %%  .. etc
     
look_ahead_timeclause --->
    look_ahead(w(noun(Monday,sin,u,n))), 
    {subclass(Monday,day)}.


look_ahead_clock ---> look_ahead_lit([kl,klokken]). 
look_ahead_clock ---> look_ahead(w(noun(clock,sin,def,n))).
look_ahead_clock ---> look_ahead(w(nb(_,_))).


not_look_ahead_vp ---> 
    look_ahead_vp,
    !,reject.
not_look_ahead_vp ---> []. %% 


look_ahead_vp ---> look_ahead(w(verb(_,_,_))).
look_ahead_vp ---> look_ahead([ikke]).
look_ahead_vp ---> look_ahead_aux.


%% look_ahead_aux ---> ... aux1 ... on stack NO

look_ahead_aux --->
    look_ahead_lit([vil,skal,bør,må,kan, 
                    ville,skulle,burde,måtte,kunne]). 

not_look_ahead_lit(List) ---> 
    look_ahead_lit(List),
    !,reject.
not_look_ahead_lit(_List) ---> [].


look_ahead_lit(List) --->
     look_ahead([L]), 
     {testmember(L,List)},
     !.

lit_of(Vi,List) --->  %%  Vi is used later
    [Vi],
    {member(Vi,List)},
    !.

one_of_lit(List) ---> %%  Vi is NOT used later
     [Vi], 
     {member(Vi,List)},
     !.

not_one_of_lit(List) ---> 
    one_of_lit(List),
    !,reject.  
not_one_of_lit(_List) ---> [].



%% noe godt svar OK 

not_look_ahead_number ---> [ett],!.                   %% TA-110617
%not_look_ahead_number ---> w(nb(_,_)),!,fail.          %% TA-111111
not_look_ahead_number ---> w(nb(_,_)),!, { fail }.      %% RS-140921 To ensure retry?
not_look_ahead_number ---> [].                        %% TA-110620

%%¤ LOOK_AHEAD_NP 

%%%¤ NOT_LOOK_AHEAD_NP 
not_look_ahead_np ---> look_ahead(w(adv(Directly))),
     gmem(Directly,

           [klokken,kloka,kl, %% TA-110126 (ala preposition)
            directly,     %% direkte adj
            correctly     %% riktig  adj
           %%% earlier    %% en tidligere feil
      ]),    

     !.
%%                     adv(well) = adj(good) %% <- NB  etc

not_look_ahead_np ---> look_ahead_np,!,reject. %% ad hoc
not_look_ahead_np ---> [].  

%%%¤ LOOK_AHEAD_NP 

/*
look_ahead_np ---> 
      gap(xnp(Na,NB))  
*/



look_ahead_np ---> 
    look_ahead_lit([den,det,de,denne,dere,dette,disse,du,en,et,ei,han,hun,jeg,noe,noen,vi,
                    meg,deg,seg,min,mine,din,dine,hans,hennes,seg,vår,våre,deres,
                    mange,noen,noe]). %% TA-110506
 
look_ahead_np ---> 
    look_ahead(w(adj2(A,_))), %% noen mindre detaljer
    {\+ testmember(A,[])}.

look_ahead_np ---> look_ahead(w(noun(_,_,_,_))).
look_ahead_np ---> look_ahead(w(nb(_,_))).

look_ahead_np ---> 
    look_ahead_lit([halv,kvart]). %%  før (halv 5) %% TA-110520


%% look_ahead_np ---> look_ahead([En]),
%%    {testmember(En,[du,jeg,han,hun,vi,dere,en,et,den,det,de,denne,dette,disse])}. %% etc


look_ahead_np --->
     look_ahead(w(name(Tagore,_,_))), 
     {\+ testmember(Tagore,[])}.


look_ahead_subject ---> [Jeg],
    {testmember(Jeg,[jeg,du,han,hun,vi])}. %% ,de])}. de også art 


look_ahead_pron ---> look_ahead_lit([jeg,vi,du,dere]). %% ad hoc

not_look_ahead_pron --->
    posspron(_),
    !,reject.
 
not_look_ahead_pron --->
    not_look_ahead_lit([jeg,du,han,hun]). %% bussen jeg må ta
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




% 5 bussen ==> bus 5

%% DETERMINER0   Optional determiner

determiner0(plu,0, X,P1, P2::(quant(approx/Twelve,X)::(P1 and P2))) --->
    [mellom],
    w(nb(Twelve,num)),                     %% weakest                           
    [og],
    w(nb(Fifteen,num)),       
    {Twelve < Fifteen}.


determiner0(plu,0, X,P1,  P2:: ( quant(eq/N,X)::(P1 and P2))) ---> 
    theplu0,
    w(adj2(FILANEPR,nil)),
    {testmember(FILANEPR,[first,last,next,previous])},
    number(N:_),
%%%     {N =< 5}, %% NB   første 301 buss ---> 301 X  første buss * %% siste 10 dagene
    look_ahead(w(noun(_,plu,_,_))),
    !,accept,
    []-  w(adj2(FILANEPR,nil)). %% free order

%%%% NB   første 301 buss ---> 301 *  første buss *** 


determiner0(sin,0, X,P1, P2::P) --->    % try the file = this  file 
    {value(dialog,1)},       %% creates problems if not in dialog mode 
    the,                               % provided 0 of- complements 
    determiner(X,P1, P2::P) \  this.


determiner0(_,_,_,_,_) ---> %% 5 kroner \= count
    theplu0,  
    number(_:_),
    w(noun(Crown,_,_,_)), 
    {measureclass(Crown)}, %% semantic.pl
    !,
    reject.

determiner0(plu,0, X,P1, P2::(quant(approx/N,X)::(P1 and P2))) ---> 
    approx,                                   
    !,
    number(N:_).


approx ---> [ca],!.
approx ---> [rundt],!.

determiner0(plu,0, X,P1, P2::(quant(ge/N,X)::(P1 and P2))) ---> 
                                                         %% ge is weaker than gt
    morethan,    
    number(N:_).
 
morethan ---> [minst].  
morethan ---> [over].  
morethan ---> [mer],[enn]. 


determiner0(plu,0, X,P1, P2::(quant(eq/N,X)::(P1 and P2))) ---> 
    theplu0,       
    number(N:_),
    not_look_ahead(w(noun(time,_,def,n))). %% ett tiden

determiner0(sin,0, X,P1,  P2:: (quant(eq/1,X)::(P1 and P2))) ---> %% last
    w(nb(1,num)),
    not_look_ahead(w(noun(time,_,def,n))), %% ett tiden
    !.

                                    
determiner0(sin,0, X,P1, P2::P) --->    % try the file = this  file 
    {value(dialog,1)},       %% creates problems if not in dialog mode 
    the,                               % provided 0 of- complements 
    determiner(X,P1, P2::P) \  this.

determiner0(plu,0,  X,P1,  P2::P) --->    % try the file = this  file
    the,                                % provided 0 of- complements 
    not_look_ahead(w(verb(_Travel,pres,fin))), %% de reiser: de pronoun  
    determiner00(X,P1, P2::P). 

determiner0(_,0, X,P1, P2::P) --->  %% _ ==> 0 
     determiner(X,P1, P2::P).

determiner0(_,0, X,P1, P2::P) --->   %%  _ ==> 0 (  sentrum til buvika)
    determiner00(X,P1, P2::P).     

determiner0(_,0, X,P1, P2::(exists(X):: P1 and P2)) ---> 
     the0.
%%%      not_look_ahead(w(verb(_travel,pres,fin))).
%% nå går de neste bussene  

%% DETERMINER00  (empty)

determiner00(X:T,P1, P2::(P1 and P2)) ---> %% Explicitly NO determiner %% THE
    the(X:T), %% swallow the().
    !.

determiner00(X,P1, P2:: (exists(X):: P1 and P2) ) --->  [].   %% Lørdag kveld den

                                           

% % % % % % % % % % % % % % % % % % % % % % % 

%%¤ DETERMINER  (X,P, NPSEM)

determiner(X,P1, P2:: (forall(X):: P1 => P2) ) ---> 
    [alle],
    look_ahead_np.  

determiner(X,P1, P2:: (forall(X):: P1 => P2 )) ---> 
    [hver].


determiner(X,P, Q:: (find(X)::( P and Q ))) ---> 
     this,
     look_ahead_np.  

determiner(X,P1, P2::P1 and P2) --->   
    the(X).


determiner(X,P1, P2::(exists(X):: P1 and P2) ) ---> 
     only0, 
     art,
     look_ahead(w(noun(_Teacher,sin,u,n))), %% reiser/lærer
     off0,
     !. 

determiner(X,P1, P2::(exists(X):: P1 and P2) ) ---> 
     only0, 
     art,
%%%%%%%     not_look_ahead(w(verb(_travel,pres,fin))), %% de (pron)  reiser  
     off0.                                             %% nå går de    neste 
  
     

determiner(X,P1, P2::(forall(X):: P1 => P2) ) ---> 
    every ,
    look_ahead_np. 

determiner(X,P1, P2:: (not (exists(X)::( P1 and P2 )))) ---> 
    no,     
    look_ahead_np.  

determiner(X,P1, P2::  (exists(X)::( P1 and (not P2) )) ) ---> 
    notall ,
    look_ahead_np. 


determiner(X,P1, P2:: (quant(all,X):: ( P1 and P2 ))) ---> %% not count(plu)
       [hele]. 


determiner(X,P1,  P2::QP) --->  
    quantifier(X,P1, P2::QP).
 

%%%¤  QUANTIFIER  (X,P1,  NP)

quantifier(X,P1, P2::(quant(eq/En,X)::(P1 and P2))) ---> %% bare 1
    [bare],                                              %% TA-101116
    w(nb(En,_)).



quantifier(X,P1,  P2::(quant(few,X)::(P1 and P2))) ---> 
    aso0,
    few,
    look_ahead_np.  

quantifier(X,P1,  P2::(quant(most,X):: ( P1 and P2 ))) ---> 
    [de],[fleste],
    look_ahead_np.

%% quantifier(X,P1, P2:: (quant(all,X):: ( P1 and P2 ))) ---> 
%%     [hele].


quantifier(X,P1,  P2::(quant(much,X):: ( P1 and P2 ))) ---> 
    much,
    not_look_ahead(w(adj2(_,nil))). 

quantifier(X,P1, P2::(quant(little,X):: ( P1 and P2 ))) ---> 
    little,
    not_look_ahead(w(adj2(_Late,nil))). 

quantifier(X,P1,  P2::(quant(many,X)::(P1 and P2))) --->
    aso0,
    many,   
    look_ahead_np.  

quantifier(X,P1,  P2::(quant(most,X)::(P1 and P2))) ---> %% TA-110825
    aso0,
    most,   
    look_ahead_np.  

quantifier(X,P1,  P2::(quant(all,X)::(P1 and P2))) --->
    [alle],
    look_ahead_np.  


quantifier(X,P1, P2::(quant(ge/2,X)::(P1 and P2))) ---> %% ok
    several,                                             
    look_ahead_np. 


quantifier(X,P1,  P2::(quant(count,X)::(P1 and P2)) ) ---> 
    w(noun(count,_,_,_)),                             %% antall busser
    optional([av]), 
    look_ahead_np. 


few ---> [få].  
few ---> [færre]. %% problem


%-------------------------------------------------------------------

% NO lambda notation (::) below this line

%-------------------------------------------------------------------



plausible_name(N:person, N isa person,GN) ---> %% tore amble sitt kontor 
    properfirstname(Tore,_,_),
    properlastname(Amble,_,GN),
    {N = (Tore,Amble)},
    !,accept.




plausible_name(N:Class,N isa Class,GN) ---> %% w(name(dalen_hageby-12,n,street))
    w(name(N,GN,Class)),
    {\+ Class=0,     %% unremoved partname (generic) 
     \+ Class=date}. %% Dates treated specially 



%%%¤¤  NAME_COMPOUND   left associative with genitive



name_compound(Ind,X,QP) --->    % Must begin with a name %% tt sommerruter
    not_look_ahead([dere]),     % = tt
    not_look_ahead([du]),
%%     not_look_ahead(w(name(tuc,n,_))), %% syn. du  
    not_look_ahead(w(nb(_,_))), %  2 avganger  \== (rute) 2 sine avganger
    plausible_name(Y,P,GN1), 
    s0(sin,u,GN1,GN2),        % singularis 
    ncomps0(GN2,X,Y,P,QP,Ind).  % At least 1 more if genitive



%%%¤¤¤  NAMEP 


% namep(Ind,NT,XP)      Ind=name  Pure name
%                       Ind=0     Contains a noun



%% Yggdrasilveien 9C, ( 7033 ) Trondheim
namep(name,X:street,X isa street) --->    %% was name_compound 
    w(name(X,n,street)),
    comma0,
    postcode(_), %% ignore  
    w(name(_Th,n,Neib)),
    {testmember(Neib,[neighbourhood,city,station])}, %%(Kattem)
    !,accept.


namep(Ind,X,QP) --->   %% teams ruteopplysning 
    not_look_ahead([dere]),     % = tt
    not_look_ahead([du]),

    not_look_ahead(w(nb(_,_))), %  2 avganger  \== (rute) 2 sine avganger
    plausible_name(Y,P,GN1), 
    s0(sin,u,GN1,GN2),        % singularis 
    ncomps0(GN2,X,Y,P,QP,Ind).  % At least 1 more if genitive



                                            
namep(name,Y:thing,Y isa unkn) --->   %% compound name list %% was name_compound 
    {value(unknownflag,true)},        %% unknown names allowed
     unplausible_name(X),
     morenames(X,Y).


%% 


namep(0,NT,XP) ---> 
    measure(NT,XP).  %% e.g. 5 minutes

namep(name,NT,XP) --->  
    you,
    nameq(NT,XP)  \  w(name(tuc,n,savant)). %% Technical 

namep(0,_NT2,_YP) --->   %% Ad Hoc  3 busser \= buss 3
    number(_),
    noun(_Veh,plu,_,n, _NT, _XP),   
    !,
    reject.


%% pris 30 kr fins

namep(0,NT2,YP) --->  %% jeg vet hva tagore  heter//hva=ting som
    athe0,                                 %
    noun2(SINPLU,BU,n, N:T, XP),            %   retning *(en)*    buss  % ta bussen 30/4 
   {\+ testmember(T,[thing])}, %% vise deg  ting %% TING er generisk
       not_look_ahead([jeg]),  %%  etc ad hoc
       not_look_ahead([du]),   
    nameq(N1T1,_),                         %     nth          5        % holdeplassen nth
        not_look_ahead([':']), %% buss 14:15  
%%         not_look_ahead(['.']), %% buss 14.15  %% may be last
    {compoundtest(SINPLU,BU,N:T,N1T1)},     %   feasability  test
    {align_noun_name(N:T,N1T1,XP,NT2,YP)}, 
    optional_suffix(N:T), %% buss 8 ruta
    not_look_ahead(w(name(_Xmas,_,date))), %% 1. juledag \= tram
    !,accept.                                     %  Avoid multiple returns (e.g. 3)


namep(0,NT2,YP) ---> 
    athe0,
    nr0, %% [nr],                         %% nr 8 buss
    nameq1(N1T1,_),                       %%      vestlia
    noun(Veh,sin,u,n, NT, XP),            %%   bussen 5 = bussen kl 5  
    {testmember(Veh,[bus,tram])},         %% 1700 saturday ### 
    !, %% en nr 8 buss
    {align_noun_name(NT,N1T1,XP,NT2,YP)}.



namep(0,NT2,YP) ---> 
    athe0,
    not_look_ahead([_]), %% jeg meg du deg han hun// not look_ahead_pronoun
    nameq1(N1T1,_),                       %     vestlia
    noun(T,sin,_,n, NT, XP),              %     endstation
    {\+ testmember(T,[thing])}, %% vise deg  ting
    {align_noun_name(NT,N1T1,XP,NT2,YP)}. 


namep(name,X,Y) --->    
     not_look_ahead([ett]), %% ett hotell = trikk *** 
     nameq(X,Y). 

%
optional_suffix(_:Bus) --->  %% hastighet 50 kmt
    w(noun(Route,_,_,n)),
    {alignable(Bus,Route)},
    !,accept.

optional_suffix(_:Bus) --->  %% buss 8 ruta 
    w(noun(Route,_,_,n)),
    {alignable(Bus,Route)},
    !,accept.
optional_suffix(_:_Bus) ---> point0. %% buss 66. til ... % []. 


%%%%¤¤  NOUN2 (PLU,DEF, GEN,Var, Pred)


noun2(sin,u,n, X:thing, X isa thing) ---> %% de som 
    [D],
    {testmember(D,[de,disse,dem])},
    look_ahead([som]). 


noun2(plu,u,n, X:thing, X isa thing) ---> %% dem  
    [D],
    {testmember(D,[de,disse,dem])},
    not_look_ahead_np. 


noun2(sin,u,n, X:agent,X isa agent) ---> %% allow relative clause
    agent_pronoun,   %% hun,...,vi   personal  /not likely vehicle 
    look_ahead([som]).  %% som


noun2(sin,u,n, X:thing,X isa thing) ---> %% allow relative clause
    [det],   %% det som fins  
    look_ahead([som]).  


noun2(Num,U,Gen, A,B) ---> %% til nth fre. kl 12. %% dot-trøbbel
    noun(Sat,Num,U,Gen, A,B),
    {testmember(Sat,[monday,tuesday,wednesday,thursday,friday,saturday,sunday,month])},
    point0,
    !,accept.
                    

noun2(Num,U2,Gen,  X:Stationtype, XStation2) ---> %% buss rute/ buss stasjon etc
    w(noun(Bus,_Sin,u,n)),  %% bussene nummer 3 ??? // bussen stasjonen*
    not_look_ahead(w(noun(number,sin,_,n))),
    not_look_ahead([nr]), %% qua route 
    not_look_ahead(w(verb(_Reise,_,_))),     %%  kan en voksen reise
    w(noun(Station,Num,U2,Gen)),  
    {adjnoun_template(Bus,Station,X:Stationtype,XStation2)},
    !,accept.


noun2(Num,U,Gen, A,B) --->
    noun(_NN,Num,U,Gen, A,B).


noun2(sin,u,n, X:thing,X isa thing) ---> %% den som er dum tar trikken
    someone,     %% not personal den
    look_ahead([som]),
    !.

agent_pronoun ---> [jeg].
agent_pronoun ---> [du]. %% er det du som er sjåfør 

agent_pronoun ---> [noen]. 
agent_pronoun ---> [mange].
agent_pronoun ---> [få].

agent_pronoun ---> [han].
agent_pronoun ---> [ham].
agent_pronoun ---> [hun].
agent_pronoun ---> [henne].

% agent_pronoun ---> [vi].
% agent_pronoun ---> [oss].
agent_pronoun ---> [dere].

agent_pronoun ---> [alle].

noun(Country,Num,U,Gen,  X:Country, X isa Country) --->
    w(noun(Country,Num,U,Gen)).


%%%¤  MEASURE 

measure(NT1,YP) ---> %%    kr. 1
    noun(M,_,_,n, NT, XP),        
   {measureclass(M)}, gmem(M,[crown]), 
    point0,    
    anumber(NU),  
    !,
    {align_measure(NT,NU,XP,NT1,YP)}. %% 5 isa number and X isa minute => 5 isa minute

measure(NT1,YP) ---> %%    NOT    two buses !!!!!
    anumber(NU),  %% en million 
    point0,          %% 5. 
    noun(M,_,_,n, NT, XP),              %  minutes, hours, days
    point0,                             %% min.
    not_overon_clock(M), %% 3 min PÅ 5
    {measureclass(M)}, 
    {align_measure(NT,NU,XP,NT1,YP)}. %% 5 isa number and X isa minute => 5 isa minute

not_overon_clock(Minute) ---> 
    {testmember(Minute,[hour,minute,second])},
     prep1(X),
    {testmember(X,[on,before, over,after])},

     look_ahead(w(nb(_,_))),

	 !,reject.
not_overon_clock(_) ---> []. 

%%%%¤¤  NAMEQ    Name Expressions

nameq(C,Q) ---> nameq1(C,Q),not_look_ahead(w(nb(_,_))). %% hva er 2 2 

nameq(C,Q) ---> nameq2(C,Q),not_look_ahead(w(nb(_,_))). %% hva er 2 2 



%% Ståle   Rønning       Fornavn Etternavn  
%% Tina    Rønning Lund  Fornavn Fornavn Etternavn

name1g(Rønning:lastname,Rønning isa lastname,GN) ---> %% (Ståle)  Rønnings
    {value(teleflag,true)},
    look_ahead(w(name(Rønning,_,firstname))), 
    w(name(Rønning,GN,lastname)), 
    not_look_ahead(w(name(_Lund,_,lastname))),
    !,accept.


name1g(Ståle:firstname,Ståle isa firstname,n) ---> %%  Ståle (Rønning)
    {value(teleflag,true)},
    look_ahead(w(name(Ståle,_,lastname))), 
    w(name(Ståle,n,firstname)), 
    look_ahead(w(name(_Lund,_,lastname))),
    !,accept.


name1g(Rønning:lastname,Rønning isa lastname,GN) ---> %% Ståle Rønnings
    {value(teleflag,true)},
        look_ahead(w(name(Rønning,_,firstname))), 
    w(name(Rønning,GN,lastname)), 
        not_look_ahead(w(name(_Lund,n,lastname))),
    !,accept.


name1g(Rønning:firstname,Rønning isa firstname,n) ---> %% (Tina) Rønning Lund 
    {value(teleflag,true)},
    look_ahead(w(name(Rønning,_,lastname))), 
    w(name(Rønning,n,firstname)), 
    look_ahead(w(name(_Lund,n,lastname))),
    !,accept.

name1g(X:F,X isa F,GN) ---> %%
    wnameg(X:F ,GN,F).      %%  Rønning sitt 


wnameg(X:F,gen,F) --->  w(name(X,n,F)), sin,!.   
wnameg(X:F,gen,F) --->  w(name(X,gen,F)), sin,!. % tores sitt OK
wnameg(X:F,gen,F) --->  w(name(X,gen,F)),!. % tores OK
wnameg(X:F,n,F)   --->  w(name(X,n,F)).



%%%¤¤ NAMEQ1   basic name or interpreted number


nameq1(Rønning:lastname,Rønning isa lastname) ---> %% Ståle Rønning
    {value(teleflag,true)},
    look_ahead(w(name(Rønning,n,firstname))), 
    w(name(Rønning,n,lastname)), 
    not_look_ahead(w(name(_Lund,n,lastname))),
    !,accept.


nameq1(Rønning:firstname,Rønning isa firstname) ---> %% Ståle Rønning
    {value(teleflag,true)},
    look_ahead(w(name(Rønning,n,lastname))), 
    w(name(Rønning,n,firstname)), 
    look_ahead(w(name(_Lund,n,lastname))),
    !,accept.


nameq1(quote(N):T,quote(N) isa thing) --->  %% avoid quote(X) isa sentence. ???
    w(quote(N)),  
    !,
    {type(thing,T)}. %% sentence



nameq1(_,_) ---> % normalt 1. mai
    number(_),
    point0,
    monthnamex, 
    !,
    reject. %%  


nameq1(_,_) ---> % 2 time(r)  aldri buss
    number(_),
    w(noun(hour,_,_,_)),
    !,
    reject. %%  


nameq1(_,_) ---> % 2 . etage 
    number(_),
    point,
    w(noun(_,_,_,_)),
    !,
    reject. %%  


nameq1(NT,NC) ---> 
    obviousclock1(NT,NC),
    !,accept.


nameq1(N:T,N isa clock) ---> 
    clock0, 
    time2(N),   %% obviously clock by its syntax 
    !,                        %% <---   !
    {type(clock,T)}.         %% NB



nameq1(N:T,N isa clock) --->
    plausibleclock1(N:T,N isa clock). %% before (possible) date



% Only full dates allowed, try last 

nameq1(X,P) ---> %%  ( Buss går 09.12 => clock)
   date(X,P).    %%    20 august should be tried before (bus) 20

nameq1(_N:_Type,_) --->  %% dont accept 1 zone as tram 
    one,
    w(noun(_,sin,u,n)),
    !,reject.

nameq1(N:_Type,N isa Class)  --->
    w(name(N,_,Class)),
    {atom(N)}, %% not nr qua route
    {testmember(Class,[language,colour])},
    look_ahead(w(noun(_Version_,_,_,_))),
    !,reject.   

nameq1(N:Type,N isa Class) --->  %% done = Dons,0 | Done unkn

    not_look_ahead(w(name,_Norge,gen,_)), %% norges = norge | norges  (name spell!)
 
    w(name(N,_n,Class)), %% non numeric names  %% passes trough without unk Word message
        { N \== 1},  %% 1 (alone) is not tram 
        { Class == unkn -> value(unknownflag,true);true}, %%  Syndrome  
        {_n \== gen},        %%  too late if double
                             %% norges=norge(spell)|norge gen
        {type(Class,Type)}.  %% 


nameq1(N:Type,N isa Class) --->  %% Try number as name as  Last Resort
    nr0,   
    w(name(N,n,Class)),
    point0, 
     not_look_ahead(w(name(_Christmas_day,_,date))), %% 1. juledag \== tram 
    { Class == unkn -> value(unknownflag,true)},
    {number(N)},                 %% Number as name Last
    {type(Class,Type)}. 


nameq1(X:T,P) --->   %% Finally, Try number as clock with care 
    timeq1(X:T,P),   %% 5 bussen går  After clock
    { number(X),X  >= 100}.     %% Pragmatic, avoid bus goes 50 


nameq1(X:year,X isa year) --->   %% or year 
    w(nb(X,num)),
    { number(X), X >=1900 , X=<2099}. %% 9999}.e.g 7491


%% DATE 

%% Special dates



date(Date:date,Date isa date) ---> %%  n'te nyttårsdag
     num_na(N), {N >=1,N =<7}, 
     slashpoint0,    %% pointNO,  %% points mostly ignored    
     w(name(new_years_day,n,date)), %% Special for new years day
     !,
     {datetime(YYYY,MM,_,_,_,_)}, % if month > 1, next year
     {MM > 1 -> YYY1 is YYYY+1;YYY1 is YYYY},
     {DD is N},
     {Date= date(YYY1,01,DD)}. 


date(Date:date,Date isa date) ---> 
     num_na(N), {N >=1,N =<7}, 
     slashpoint0,   %% pointNO,  %% points mostly ignored    
     w(name(Whitsun_day,n,date)),
     {testmember(Whitsun_day,
           [whitsun_day,easterday,christmas_day])}, %% not New Years Day
     !,
     {named_date(Whitsun_day,date(X,Y,Z)),
     N1 is N-1,
     add_days(date(X,Y,Z),N1,Date)}.


date(Date:date,Date isa date) ---> %%   with YYYY
     dayno(DD), 
     slashpoint0,    %% '.' is /is not removed, required for date
     month(MM),
     slashpoint0,     %% den 20.9 2000
     year(YYYY),  
     !,
     {Date= date(YYYY,MM,DD)}. 


%% Første 5 -> 1. may
date(Date:date,Date isa date) ---> %%  IS NOT A CLOCK
     dayno(DD),                    %% Last ditch test
     slashpoint,  %% // den 22 9  NOT OK hva er 1 1 
     month(MM),
     point0,  
     {DD > 24; MM > 0},
     !,
     xyear0(MM,YYYY),  
     {Date=date(YYYY,MM,DD)}. 


date(Date:date,Date isa date) --->   %% Try Date last
     dayno(DD), 
     slashpoint0, 
     monthname(MM), %% Aug -> 08
     xyear0(MM,YYYY),
     !,accept,    
     {Date=date(YYYY,MM,DD)}. 

date(Date:date,Date isa date) ---> %% TA 2000-09-28 (:-)
     year(YYYY),  
     month(MM),
     dayno(DD), 
     !,accept,    
     {Date= date(YYYY,MM,DD)}, 
     !,accept.                            %% 1997 is not a time




%%%%%% CLOCK SECTION %%%%%%%%%%

timeq1(N100:clock,N100 isa clock) --->    %%  clock Time Constant, known to be a time
    [halv],                     %% halv fire
    hours(N),                   %% i halv fire tiden
    {N100 is N*100-70},
    !,accept.



timeq1(N:clock,N isa clock) --->    %%  clock Time Constant, known to be a time
    time12(N), 
    !, accept.            

%%%¤  CLOCK_SEQUEL 

clock_sequel(N:clock,N isa clock) ---> %%  AFTER klokken
    clock_kernel(N:clock,N isa clock),
    !.

%% (klokka) 80.20)// %% shall be accepted as clock   %% even if wrong.
clock_sequel(N100:clock,N100 isa clock) ---> 
       w(nb(N1,num)),  
       {N1 < 100},
       not_look_ahead(['/']), %% -> date 1/12 
       point,
       w(nb(N2,num)),   
       {N2 < 100},
       !,
       {N100 is N1*100+N2}.


clock_sequel(N100:clock,N100 isa clock) ---> %% WILL BE DETECTED ELSEWHERE
        w(nb(N,num)),   %% allow  til kl 1
        not_look_ahead(['/']), %% -> date 1/12 
            {N > 0, N < 25 -> N100 is N*100
             ;
             N100 is N}. %% 0.613  will be detected



%%¤  CLOCK_KERNEL (var,Pred)

clock_kernel(N:clock,N isa clock) ---> %% WILL BE DETECTED ELSEWHERE
    number(N:_),                       %% 
    {N > 2500, \+ clock_test(N)},      %% Clock is prefixed, NO such clock
    !.

clock_kernel(_,_) --->  
    [nå], %% hva er klokken nå, now is def. as clock
    !,
    reject.


clock_kernel(_,_) --->  %% Ad Hoc
    [en], %% 
    !,
    reject.

clock_kernel(_,_) --->   %% Ad Hoc 
    [et], %%
    !,
    reject.


clock_kernel(N:clock,N isa clock) ---> 
    not_look_ahead(w(name(_,n,route))),  
    not_look_ahead(w(name(_,n,nightbus))),
    w(nb(N,num)), 
    { N >= 100, clock_test(N)}, 
    not_look_ahead(w(noun(_,plu,_,_))),  
    not_look_ahead([tusen]), 
    not_look_ahead([millioner]),  %% 
    optional( w(noun(time,sin,def,n) )) ,     %% tida
    !,accept. 


clock_kernel(_,_) --->   
    num_na(_),
    point0,
    monthname(_), %% skjærtorsdag OK *monthnamex  
    !,
    reject.
 
clock_kernel(N:clock,N isa clock) --->  %%  kl 8 17 mai
    {value(busflag,true)},
    hours(_),
    colemin0(_), 
    w(name(_May,_N,month)), 
    !,         
    reject.
 
clock_kernel(N:clock,N isa clock) --->   
    {value(busflag,true)},
    hours(N1),
    colemin0(N2), 
    {dedicated_date(date(_,N1,N2))}, %% 12.11 is a DATE
    !,         
    reject.
 
clock_kernel(_,_) --->   %% 15.1.2008 is date 
    hours(_N1),
    colemin2(_N2),  
    w(nb(_2008,num)), {_2008 >= 60}, %% not minutes 
    !,         
    reject.

 
clock_kernel(N:clock,N isa clock) --->   
    hours24(N1), %% TA-101126  00:36 -> 24:36 (ad hoc)
    colemin2(N2),  %% 17.10  => 17:10 %% require minute, with or without .
    !,         
    optional(w(noun(time,sin,def,n))), % tida
    {N is N1*100 + N2}. 
 
clock_kernel(N:clock,N isa clock) --->    %% Know clock, accept off limit values
    time012(N),
    !,accept.

 
%%  Allow kl 2900  ==>  -> recognize syntax, error message 
clock_kernel(N:clock,N isa clock) --->    %% Know clock, accept off limit values
    timeoff(N).   

 
clock_kernel(1300:clock,1300 isa clock) --->  %% Know clock, et as 1300(ett ok)
    [et]. 
 
clock_kernel(1300:clock,1300 isa clock) --->  %% Know clock, en as  1300 (ett ok)
    [en]. 


clock_kernel(N100:clock,N100 isa clock) ---> %% WILL BE DETECTED ELSEWHERE
        w(nb(N,num)),  {N > 9},  %% avoid til 1 // 3T 
        not_look_ahead(w(noun(minute,_,_,_))), 
        not_look_ahead(['/']), %% -> date 1/12 
        {N > 0, N < 25 -> N100 is N*100
          ;  fail }.   %% avoid 0.613 




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


namenb(1) ---> [ett],w(noun(_,_,_,_)),!,reject.
namenb(1) ---> [ett],!,accept.  
namenb(_) ---> a,!,reject. 
namenb(N) ---> w(name(N,n,_)). 
namenb(N) ---> w(nb(N,num)).    %% nummer "femtito" 

%%%¤ DAYNO

dayno(N) ---> 
    num_na(N),
    { N > 0, N =< 31}.
    
%%¤  MONTH  

month(N) ---> monthnamed(N),!. %% TA-110214
month(N) ---> monthnum(N).

monthnamed(N) --->  %% TA-110214
    monthname(N), 
    point0,   %% fre.
    !.

monthname(N) ---> % 2. januar
    w(name(Jan,n,_)),
    {monthnumber(Jan,N)}. %% fernando.pl

monthnum(N) ---> 
    number(N:_), 
    { N > 0, N =< 12}.


%% used for rejects
monthnamex --->  monthname(_). %% 2. jan 

monthnamex --->   %% 2. juledag
    w(name(XD,_,_)),
    {named_date(XD,_)}.       %% busdat.pl 
%% 


day(D) --->  
    w(noun(D,_,_,_)),
    {dayname(D)}.       %% fernando.pl

day(weekday) --->   %% buss hverdager kl 7.00 
    w(noun(weekday,_,_,_)).


%% Lookahead problem

% xyear(month,year). %% if year unmentioned, 
% find if current year or (e.g. 31.12)
% or next year            (e.g. 2.1)

xyear0(_M,YY) ---> aar0,year(YY),!,accept. 

xyear0(M,Y)  ---> {this_year(Y0)},
                  {adjust_year(M,Y0,Y)}. 

year0(N)    ---> aar0,year(N),!,accept. 
year0(YYYY) ---> {this_year(YYYY)}. %% utility.pl


aar0 ---> point0,w(noun(year,_,_,n)),!. 
aar0 ---> point0.


year(N) --->  
    {value(busflag,true)},
%%%%%%%    !, %% 26.6.  05
    number(N:_),
    { N >= 2000, N =< 9999},
    !,accept.

year(N) --->  
    number(N:_),
    { N >= 1000, N =< 9999},
    !,accept.

year(M) --->  
   number(N:_), 
   { N >=0, N =<99},
   !,accept,
   {M is N+2000}.



%%%%%%

timexp(T) --->  %% Time is expected, reject if not
    clock0,
    time2(T).

timexp(T) --->
    clock0,
    time1(T).


timenexp(T) --->  %% Time is not expected 
    clock,
    time2(T).

timenexp(T) --->
    clock,
    time1(T).



clock_time(1300) ---> %% We know it is after clock, allow en/et/ei
    a, 
    !,accept.

clock_time(1300) ---> %% We know it is after clock, allow en/et/ei
    [nå], 
    !,
    reject.

clock_time(N3) --->  %% kl  13.10  OK 
     hours(N1),  
     colemin0(N2),  
     {N is N1*100 + N2},  
     ampm0(N,N3).  

clock_time(N) ---> 
   time12(N). 



%%%%¤¤ TIME012  ??

%% know clock, accept off time values
time012(N) ---> time12(N) .    %% maybe reject wrong values
                               %% 3 t = 3 timer
                               %% 3 t = 3 timer

time012( N100) ---> % one  small number (avoid 47)
        w(nb(N,num)), {N >1}, %% avoid til 1
        not_look_ahead(w(noun(minute,_,_,_))),
        not_look_ahead(['/']), %% -> date 1/12
        {N > 0, N < 25 , N100 is N*100}.  %%  avoid 0.630 


time012( 100) ---> % 01  // extreme care 
        w(nb(1,num)), %% avoid til 1
        not_look_ahead(['/']), %% -> date 1/12 
        not_look_ahead_np,
        !.

time12(N) ---> 
    time2(N), %% with 2 number %% 10 45 tiden?"
    w(noun(time,sin,def,n)). % tida 


time12(N) ---> time2(N). %% with 2 numbers


time12(N) ---> time1(N), %% with 1 number
    point0,  
    w(noun(time,sin,def,n)). % tida

%% timeoff takes illegal times  kl 91:66

timeoff(N) ---> 
        w(nb(N1,num)), {N1 < 100},
        colon0,
        w(nb(N2,num)), {N2 < 100},
        {N is N1*100+N2}. %% Freak


%%%¤¤ TIME1  
%%%% time1   Time is given by 1 number


time1(_) --->    %% avoid 0.630 
     w(nb(0,_)),
     !,  reject.

time1(_) --->    %% or 100 ???  %% "ett"  qua time ( Pragmatix)
     [ett], 
     not_look_ahead(w(noun(time,_,def,_))) , %% tiden
     w(noun(_,_,_,_)), %% nasty lookahead
     !,
     reject.

time1(100) --->    %% or 100 ???  %% nattbuss etter ett
     [ett], 
     optional(w(noun(time,_,def,_))), %% tiden
     !,accept.

time1(_) ---> 
    a, 
    not_look_ahead(w(noun(time,_,def,_))), %% ett tiden 
    !,
    reject. %% en klokke \= klokken en 

time1(N2) --->
    time3(N1), 
    ampm0(N1,N2),  
    !,accept.

time1(N2) --->
    w(nb(N,num)),
    not_look_ahead(w(noun(hour,_,_,_))), %% timer
    not_look_ahead([t]),   %% TIMER
    { N < 25},        %%   (heuristic)
    !,
    {N1 is N*100},
    ampm0(N1,N2). 

time1(now) ---> [nå],[av],!,reject. 
time1(now) ---> [nå]. 


%%%%¤¤  TIME2  
% time2 is given by 2 numbers

time2(N) --->  %%  mandag (8.30) %% special case
    hours24(HH), { HH =< 25}, %% poss hour, 00-> 24 %% TA-101126
    point,
    num(MM), {MM > 12, MM < 60}, %% \+ month, poss min
    !,accept,
    {N is HH*100+MM}.
 

time2(N) --->  %%  Norwagism 5 over 20 // not 5 etter 20 
    num(Min), 
    w(prep(over)), %% 5 over is allowed
    !, 
  { Min < 60}, % after (trap nonsense) 
    hours30(N100), %% (halv) åtte
    {N is N100 + Min}. 
 
time2(N) --->  %%    fem minutter over/etter over
    num(Min), 
    minutes,   %% not minutes0
    overclock, 
    !, 
  { Min < 60}, % after (trap nonsense)
    hours30(N100), %% (halv) åtte
    {N is N100 + Min}. 

time2(N) ---> %%  Norwagism 5 på  20 // not 5 før 20 
    num(Min), { Min < 60}, 
    w(prep(on)),
    !,
    hours30(N100), %% (halv) åtte
    {subfromtime(N100,Min,N)}. %% {N is ((N100 -100 + 60-Min))}. 

time2(N) --->  %% F minutter før/på 
    num(Min),
    minutes, % not minutes0 
    onclock,
    !,             % etter 16 før 18 \= 16 på 18
    { Min < 60},  %% after (trap nonsense)
    clock0, 
    hours30(N100),  %% allow halv
    {subfromtime(N100,Min,N)}. 


time2(N) --->
    optional(w(prep(in))),
    [halv],       %%   
    hours100(N1), %% allow halv åttetiden = halv 800 
    {N is N1 -100 +30}, %% 800-100+30 = 730
    optional(w(noun(time,sin,def,n))). 

time2(N) ---> %% halv over ... 
    [halv],
    prep1(over),
    !,
    hours100(N1), 
    {N is N1 +30}. 


time2(N) --->
    [kvart], %%    kvart på, kvart over, N på  N over  etc.
    onclock,
    hours100(N1), %% kvart på ett
     {N is N1-100 + 45}.
   

time2(N) --->
    [kvart],   %%  kvart på, kvart over, N på  N over  etc.
    overclock, %%  prep1(over),  %% etter
    hours(N1), %%
     {N is N1*100 + 15}.
   


time2(_) ---> %% 23.11.1999 fails as clock (date) 
     hours(_),
     minutes(_),
     number(M:_), {M > 24}, % tidsrommet  15 10 (-) 24 13 \= 15.10.2024 
     !,
     reject.

time2(_) ---> %% 8 17 mai %% *
     hours(_),
     minutes(_),
     w(name(_May_,_,month)), 
     !,
     reject.


%%  bussen går 16 10  %% NB should noot be called from obviousclock1
time2(N3) --->     %% bussen går 3 9 ==> 3:09  NO
     hours24(N1),    %% bussen går 3.9 ==> 3:09  NO , date
     colemin(N2),        %% TA-101126
%      {0 is mod(N2,5)}, 
     {N is N1*100 + N2},  
     ampm0(N,N3). 


time2(_) ---> %%  17 18.00 %% NOT 17:18 
    hours(_N1), 
    minutes(_N),
    point,minutes(_),
    !,reject.

time2(N3) --->     %% Pragmatic Test:  16.50 OK 
     hours24(N1),   %% bussen går 3.13        clock %% TA-101126
     minutes(N2),
     {N2 > 12},   %% bussen går 3.12        Not clock (Date)
     {N is N1*100 + N2},
     ampm0(N,N3). 
 
%%%%%%%%%%%%

onclock ---> 
    w(prep(On)),
   {testmember(On,[on,before])},
    clock0.    
 
overclock ---> 
    w(prep(Over)),
    {testmember(Over,[over,after])}, 
    clock0.    



hours30(N100) ---> 
    [halv],
    hours(N),  
    {N100 is N*100-70},
    !,accept.

hours30(N100) ---> 
    hours100(N100).


hours100(N100) ---> %% 17 på 17 mai 
   num(N100),    
   monthname(_),
   !,
   reject.


hours100(N100) ---> 
    num(N100), 
    {N100 is N100//100*100, %% divisible by 100 * når går buss lørdag  46 etter 1130? 
     N100 > 100, N100 < 2500},
    !,accept.

hours100(N100) ---> 
    hours(N),
    {N100 is N*100}.


hours100(100) --->  %% Rough   1300 nattbuss etter ett
    [ett],
    !,accept.


hours100(1300) --->  %% Rough special case allow et
    [et],
    !,accept.



% time3  is maybe a number, but  probably a clock if >= 100

time3(N1) --->  
    w(nb(N1,num)),
    {N1 >= 60}.  %% avoid 23 = 0023, 26 
    
    %% is maybe a wrong clock, detected pragmat


ampm0(N,N) --->  amtime,!,accept. %% 1700 am (SIC) = 1700 ! <- overrule

ampm0(N,N1) ---> pmtime,!,  %% 1700  pm  = 1700 ! 
    { N > 1200 -> N1 is N;
                  N1 is N+1200 }.

ampm0(N,N) --->  [h],!.  %% anglic 

ampm0(N,N) --->  [].

amtime ---> [am].  
amtime ---> [a],[m].

pmtime ---> [pm].  
pmtime ---> [p],[m].

% % % % % % % % % % % % % % % %

/* %% Incompatible with NIGHTBUS %% TA-101203
hours24(N) --->   
    w(nb(0,num)), %% 0 | 00
    !,
    {N=24}.
*/

hours24(N) ---> hours(N).


hours(_) --->   
    not_look_ahead([ett]),
    not_look_ahead([et]), 
    a,
    !,           %% otherwise, DONT take an article as hours  (en 5 buss)
    reject.

hours(N1) --->  
%%%     optional(w(nb(0,num))), %% null ni tretti  %%  0 15 = 0:15
    w(nb(N1,num)),
    {N1 =< 25},  %% recognized syntactically as hours
    optional([h]).

smallhours(N1) --->  %% 25 -- 59 = 0025 -- 0059 
    w(nb(N1,num)),
    {N1 > 31,N1 =< 59}. %% >= 25 avoid confusion 31.12 



minutes0 ---> minutes,!,accept. 
minutes0 ---> [].                      %%

minutes ---> w(noun(minute,_,_,_)),!,accept.


colemin0(N) ---> colemin(N),!,accept. 
colemin0(N) ---> point0,
                 minutes0(N),!,accept. %%  swallow 12. november.


%% Know not date

colemin2(_) ---> %%  17 18.00 %% NOT 17:18 
    minutes(_N),
    point,minutes(_),
    !,reject.

colemin2(N) ---> colon,minutes(N),  
    colesec0, %% 11:27[:14] ->  ignore 
    !,accept.
colemin2(N) ---> colon,w(nb(N,num)),!,reject. %% 16:108 (nightbus)
colemin2(0) ---> colon,!,accept.

colemin2(N) ---> point0,minutes(N),point0,!. %%  kl 10.30. onsdag
colemin2(N) ---> minutes(N),point0,!.


%% Maybe date

colemin(_) ---> %%  17 18.00 %% NOT 17:18
    minutes(N),
    { N \== 0},  %% mellom 17.00 - 18.00
    point,minutes(_),
    !,reject.

colemin(N) ---> 
    colon,minutes(N),
    !, accept, 
    colesec0. %% 11:27[:14] -> ignore 

colemin(N) --->  %% 20.00  
    point,
    minutes(N), {N =0; N >12}, %% not month
    !,
    colesec0. %% 11:27[:14] -> ignore 

colemin(N) ---> colon,w(nb(N,num)),!,reject. %% 16:108 (nightbus)
colemin(0) ---> colon,!,accept.


%% colemin(N) ---> minutes(N),!,accept.  %% 1 4



colesec0 ---> [':'],minutes(_),!. %% seconds syntact = minutes
colesec0 ---> [].


minutes0(N) ---> minutes(N),!,accept. 
minutes0(0) ---> []. %%  Allow 21:  //  kl. 16:113 #* ikke 16:00 - 0113


minutes(_) ---> % ER 5 EN BUSS 
    a,
    !,
    reject.

minutes(N1) ---> 
    w(nb(N1,num)),
    {N1 < 100}.  %% gives error message   21.97 
    %% {N1 < 60}.    


%%% END OF CLOCK SECTION %%%%



              
nameq2(N:T,N isa number) ---> %% 17 mai  
    number(N:T), 
    point0,  
    monthnamex, 
    !,
    reject.
              
nameq2(_,_) ---> %% 1 sone 
    one,
    w(noun(_,sin,u,n)),
    !,
    reject.

              
nameq2(N:Floor,N isa Floor) ---> %% 3. etage = etage 3
    number(N:_), 
    point,

    {\+ N=1}, %% most likely first %% TA-110411

    w(noun(Floor,sin,u,n)),
    {alignable(Floor,number)},
    !.

nameq2(N:TT,N isa clock) ---> %% time -> clock 
    {type(clock,TT)},        %% NB
    number(N:_),
    {N >= 1000},   %% not obvious clock %% TA-101124
    {clock_test(N)},
    !. %% TA-101114 

              
nameq2(N:T,N isa number) ---> %% moved after clock // klokken er 09.04
    number(N:T).

%% NUMBER  (X)


number(NT:number) ---> %% 2.500 busser 
    num(M),  
    ['.'],
    num(N),  {N >=100,N < 1000}, %% 3 dig.
    !,
    {NT is M*1000+N}.
 

number(2:Type) ---> 
    a,
    w(noun(pair,_,_,_)),
    {type(number,Type)}. 


number(NT:Type) ---> 
    only0, 
    num(N),  
    {type(number,Type)}, %%  NB
    thousands0(T),        %% 101 tusen 
    {NT is N*T}.


number(_) ---> %% en million
    a, %  en,et,ei   %% Somwhat crude
    not_look_ahead(w(noun(time,_,def,_))), %% ett tiden OK
    !,  reject. 
   

%%%

thousands0(1000) ---> tusen,!.     
thousands0(1000000) ---> million,!. 
thousands0(1000000000) ---> milliard,!.
thousands0(1) ---> [].  

tusen ---> [tusen].
tusen ---> [tusener].
million ---> [million].
million ---> [millioner].
milliard ---> [milliard].
milliard ---> [milliarder].

%%%

anumber(X)---> 
    a0,               %% colloquial 
    number(X),
    !,accept.

anumber(1:Type)---> 
   art1,!,   %% \+ noen 
  {type(number,Type)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% VERB PARTICLE  SECTION

intrans_verb(work,X,  id, S,EXS,P,Q) --->   %% holde på = arbeide
    lexv(tv,hold,P,Q),               
    w(prep(on)),   %% particle
    {iv_template(work,X,S,EXS)}.

intrans_verb(be1,X,id, S,EXS,P,Q) --->   %% holde til = være
    lexv(tv,hold,P,Q),               
    w(prep(to)),   %% particle
    {iv_template(be1,X,S,EXS)}.


intrans_verb(Live,X,id, S,EXS,P,Q) ---> 
    lexv(iv,Live,P,Q),
    {iv_template(Live,X,S,EXS)}.


intrans_verb(be1,X,N, S,BXS,pres,fin) ---> %% er (i byen)
     not_look_ahead(w(verb(go,_,fin))),   %% går buss e kl 12 %% Syndrome
%%      not_look_ahead(w(verb(be,inf,fin))), %% være qua hovedverb=ankomme ? 
     be1(N),  
     not_look_ahead(w(verb(_,_,_))), 
     {iv_template(be1,X,S,BXS)}.


intrans_verb(Live,X,N, S,EXS,past,fin) ---> %% levet ikke =
     has(N),                               %% har  (ikke)
     now0,                                 %% // jeg har nå ventet
     lexv(iv,Live,past,part),              %% levet
     {iv_template(Live,X,S,EXS)}.

%%

trans_verbs(LM,X,Y,S,Love_and_Marry) --->
     trans_verb(Love,X,Y,id, S,_,_,_), 
     trans_verbs0(Love,LM,X,Y, S,Love_and_Marry).


trans_verbs0(Love,LM,X,Y,S,Love_and_Marry) --->
     andor, 
     trans_verb(Marry,X,Y,id, S,_,_,_), 
     trans_verbs0((Love,Marry),LM,X,Y, S,Love_and_Marry).


trans_verbs0(Love,Love,X:_,Y:_, S,Love/X/Y/S) ---> [].



%%% TRANS-VERB


%%  This rule must be refined, due to ambiguity in transitivity

% å komme  seg til NTH:   transitive
% å komme  til NTH:       intransitive
% å kjøre  til            intransitive
% å kjøre  buss til       transitive

% go1      komme seg 
% go2      kjøre rute     


trans_verb(tell,X,Y,id, S,EXS,Pres,fin) ---> %% fortelle (om) busser
     lexv(tv,tell,Pres,fin),    
     particle0(tell), %% om   
     {tv_template(tell,X,Y,S,EXS)}.

 
trans_verb(Love,X,Y,N, S,EXS,past,fin) ---> %% elsket ikke =
     has(N),                                 %% har  (ikke)
     lexv(tv,Love,past,part),                  %% elsket
     {tv_template(Love,X,Y,S,EXS)}.
 

trans_verb(Border,X,Y,id, S,BXYS,P,Q) --->  
     lexv(tv,Border,P,Q), 
     {tv_template(Border,X,Y,S,BXYS)}.

%%%%

rep_v(be_free,pres,fin) --->   %% Technical  BE FREE OF CHARGE 
    w(adj2(free,nil)).
      
rep_v(Say,P,Q) --->  
    aux0,    
    lexv(rv,Say,P,Q),
    reflexiv0(Say), %% spørre (deg)
    rep_particlev0(Say). %% spørre etter %%

rep_v(want,pres,fin) ---> %% ikke skal !!!
    [skal],
    !,reject.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Infinitive Complement Section

there_be_modal(think) ---> 
    thereit,
    w(verb(go,_,_)),           %%  Norwagism
    [an].           

there_be_modal(Thought) --->
    thereit,
    be_modal(Thought).

be_there_modal(Thought) ---> 
    be,
    thereit,
    be_modal(Thought).   

be_modal(Seems) ---> be,modal(Seems).
be_modal(seem)  ---> w(verb(seem,_,fin)).

modal(Thought) ---> 
    rep_v(Thought,past,part), % passive
    tobetrue(_N).    %% negation ?   

modal(Thought) ---> rep_v(Thought,_,fin).     % active
modal(think)   ---> w(adj2(possible,nil)).  
modal(think)   ---> w(adj2(best,nil)).              %% (far fetched)
modal(free)    ---> w(adj2(free,nil)). %% gratis 

tobetrue(N)  ---> infinitive,be_truefalse(N).  
tobetrue(id) ---> [].


pvimodal(Cost,Money) --->   %% Søkt
     lexv(tv,Cost,_,fin),
    { Cost \== be}, 
    {pvi_templ(Cost,Money)}. 

%%%¤ LEXVACCEPT 

lexvaccept(Type,Verb,Tense,FIN,Neg) ---> %% TA-110111
   hlexv(Type,Verb,Tense,FIN,Neg),
   !.


%%%%¤¤¤¤  HLEXV  (Type,Verb,Tense,FIN,Neg)   lexical verb expression 

         %% (distinguish have/får/get  as verb/aux) and negation


hlexv(Type,Verb2,Pres,Fin,Neg) ---> %% (det)( vil) ikke komme fram
    aux0,
    negation0(Neg1),
    w(verb(Verb1,Pres,Fin)),
    particlev0(Verb1,Verb2),
       {verbtype(Verb2,Type)},
    negation0(Neg2), %% surplus
    {bigno(Neg1,Neg2,Neg)}.


hlexv(iv,Verb,Pres,fin,Neg) --->  %% gudes gt er ikke med %% TA-110503
    w(verb(be,Pres,fin)),
    now0,   %% now is redundant here
    negation0(Neg),
    particlev2(be,Verb), %% gudes gt er ikke med %% TA-110503
    !.


hlexv(Type,Bring,past,fin,Neg) ---> %%  Norwagism har brakt
    has,
    danow0, %% har nå prøvd %% TA-110303
    negation0(Neg),
    lexv(Type,Bring,past,part),  %% Bring tv1dtv
    reflexiv0(Bring).     %% .. meg



hlexv(tv,bring,P,Q,id) ---> %%  Norwagism  Ha med seg
    w(verb(have,P,Q)),
    prep1(with),  %%    prep1(with).  %% BUG?? RS-121118
    reflexiv0(have).     %% .. meg



hlexv(Type,Verb2,past,fin,Neg) ---> %% Får ikke laget en feil 
    w(verb(get,_Pres,fin)), 
    negation0(Neg),
    w(verb(Verb2,past,part)),
       {verbtype(Verb2,Type)}. %% no cut


hlexv(Type,Verb,Pres,fin,Neg) ---> % får kjøre/kjørt 
    w(verb(get,Pres,fin)), %% får/fikk
    negation0(Neg),
    lexv(Type,Verb,Q,R), %% fikk kjøre/ fikk kjørt
    {Q \== imp, %% fikk kontakt \= kontaktet
     R \= fin},   %% * fikk kjører
     !.


%% Type is not anticipated: Bottom Up



hlexv(Type,Verb,past,fin,Neg) ---> % tiden er nå ikke kommet 
    w(verb(be,_Pres,fin)),
    now0,   %% now is redundant here
    negation0(Neg),
    lexv(Type,Verb,past,part),
    !.

hlexv(Type,Verb,past,fin,Neg) ---> % tenkt = tv/rv
    has,
    redundant0, %% now redundant here 
    negation0(Neg),
    lexv(Type,Verb,past,part).
    %%% !,accept.      % tenkt = tv/rv 


hlexv(Type,know1,P,Q,Neg) ---> %% vet (hva du heter) 
     w(verb(know,P,Q)),   
     negation0(Neg),
     look_ahead([Hva]),  {testmember(Hva,[hva,hvem,hvilken,hvilket,hvilke])},
     !,               %%         %%  når* *hvor* viktig
     {Type=tv}.  


hlexv(tv,know1,P,Q,Neg) ---> %% Tricky vite om = vite
     w(verb(know,P,Q)),    %% vite om
     negation0(Neg),
     [om].
     %% not !

%% Experiment fikk bussen kjørt \== fikk kjørt bussen %% Rough 
hlexv(tv,Do1,Pres,fin,Neg) ---> %% får dette gjort -> får gjort dette
     w(verb(get,Pres,fin)), %% får/fikk/        .. vil få?
     negation0(Neg),
     look_ahead_np,
     np1_accept(X,NP), %% [dette], %% very special
     w(verb(Do1,past,part)),
     !,
     []- xnp(X,NP).


hlexv(tv,get,pres,fin,Neg) ---> %% delayed decision får=aux/verb 
     [får],   
     not_look_ahead(w(verb(_,inf,_))), %% få synge/synger 
     negation0(Neg),
     optional([opp]), %% ad hoc 
     !.



hlexv(iv,Speak,P,Q,Neg) ---> %% Tricky snakke om = intransitive
     w(verb(Speak,P,Q)), 
     {rv_templ(Speak,_)},
     {semantic:tv_templ(Speak,_,nil)},%% Speak,tell
     negation0(Neg),
     look_ahead([om]). %% taken care of elsewhere ?? 
 


hlexv(RTV,U,P,Q,Neg) ---> %% Tricky
     w(verb(U,P,Q)), %% understand that|why|how
        {testmember(U,[understand,believe,know])},
     negation0(Neg),
     look_ahead_lit([at,hvordan,hvorfor,når]),
     !,
     {RTV=rv}. 


hlexv(RTV,U,P,Q,Neg) ---> %% understand something  %% Tricky
     w(verb(U,P,Q)), {testmember(U,[believe])},  
     negation0(Neg),  
     !,
     {RTV=rv}. 

hlexv(RTV,U,P,Q,Neg) ---> %% understand something  %% Tricky
     w(verb(U,P,Q)), {testmember(U,[understand])},  %% not believe: 
     negation0(Neg),                             %% jeg antar oraklet henter svarene
     !,
     {RTV=tv}. 



hlexv(rv,Verb,Time,Mode,Neg) ---> %% jeg vet ikke hva klokken er
    {value(textflag,true)},
    lexv(rv,Verb,Time,Mode),
    negation0(Neg),  %% dont ignore negation 
    not_look_ahead([det]),
    not_look_ahead([hva]),
    rep_particlev0(Verb), 
    !,accept.




hlexv(tv,know1,pres,fin,N) ---> 
    [kan],  %% kunne,etc 
    negation0(N),
    not_look_ahead([jeg]), %% not in initial questions!
    not_look_ahead([du]), %% ad hoc 
    not_look_ahead(w(verb(_,_,_))). 


hlexv(Type,Verb,Time,Mode,N) --->
    {nonvar(Type)},               %% subsumed by next 
    lexv(Type,Verb,Time,Mode),
    negation0(N),
    !.

hlexv(Type,Verb,Time,Mode,N) ---> 
    lexv(Type,Verb,Time,Mode),
    negation0(N).



%%%%%¤¤¤¤   LEXV 

%% lexical verb,   verb expression with subcategory

%% If subcategory is set, that interpretation is preferred and accepted

% har kommet

lexv(Type,Come,past,fin) ---> %% holde ut = vente| legge ned=stoppe 
     w(verb(have,_,fin)),    
     redundant0, %% ihvertfall 
     w(verb(Hold,past,part)),
     particlev2(Hold,Come),    %% TA-110401
     !,                        %%  har rettet, never vt
     {verbtype(Come,Type)},    
     !.



lexv(Type,Arrive,Pres,part) ---> %% møtt opp = arrived
    w(verb(Meet,Pres,part)),

    particlev2(Meet,Arrive), %% møtt opp
    {verbtype(Arrive,Type)},
    !.

lexv(iv,Go,past,fin) --->   %% (ville) gått -> gikk %% ad hoc, 
    w(verb(Go,past,part)),  %% ad hoc, dont kbow prefix aux 
    {verbtype(Go,iv)},
    !.

lexv(iv,Go,pres,part) ---> %% er/var  gående = går/gikk 
    w(verb(Go,pres,part)),
    {verbtype(Go,iv)},
    !.


lexv(dtv,Tell,Pres,Fin) --->
    w(verb(Tell,Pres,Fin)),
    {verbtype(Tell,dtv)}.


lexv(iv,be1,pres,fin) --->  %% (vil) være  %% ad Hoc
    w(verb(be,inf,fin)). %% after aux have been taken


lexv(tv,Lay,past,part) ---> %% er blitt lagt (inn) 
    w(verb(be,past,part)), 
    w(verb(Lay,past,part)),
    {verbtype(Lay,tv)},
    !.

lexv(Type,Lay,past,part) ---> %% lagt
    w(verb(Lay,past,part)),
    {verbtype(Lay,Type)},
    !.


lexv(tv,tell,P,Q) ---> %% fortelle om // etter clausal_phrase
     w(verb(tell,P,Q)),
     reflexiv0(tell),
     optional([om]),  %% assume clausal_phrase has been tried
     !,accept.    %% <---  !!!    %% Hazardous but time saving


lexv(rv,Want,Pres,Fin) ---> 
    w(verb(Want,Pres,Fin)),
    {rv_templ(Want,_)}, %% no cut
    not_look_ahead([hva]).  



lexv(iv,Go,Tense,fin) ---> %% er/var  gående = går/gikk
    w(verb(be,Tense,fin)),
    w(verb(Go,pres,part)),
    !.

lexv(iv,Go,past,fin) ---> %% er/var  gående = gikk
    w(verb(be,_Tense,fin)),
    w(verb(Go,pres,part)),
    !.


lexv(rv,Tell,P,Q) --->
     w(verb(Tell,P,Q)),
     {testmember(Tell,[tell,notify])}, %% Ad Hoc
     reflexiv0(Tell),
     not_look_ahead([hva]), 
     !,accept.    %% <---  !!!    %% Hazardous but time saving


lexv(rv,show,P,Q) ---> 
     w(verb(show,P,Q)),
     reflexiv0(show).    


lexv(rv,mean,P,Q) ---> %% Nec ?
     w(verb(mean,P,Q)),
     look_ahead([at]),
     !.

lexv(rv,mean,P,Q) ---> %%  Ugly %%  jeg mener du er dum
     w(verb(mean,P,Q)),
     not_look_ahead([hva]),  
     not_look_ahead([en]),  %% mene en ting
     not_look_ahead([noe]). %% mene noe





lexv(tv,know1,P,Q) ---> %% kjenne  
     w(verb(know,P,Q)),    
     not_look_ahead([når]),
     not_look_ahead([at]).


lexv(T,Live,P,Q)--->
    (doit), faa,
    w(verb(Live,P,Q)),
    {verbtype(Live,T)},    
    !,accept.

lexv(T,Live,P,Q)--->
    (doit),                   %% SUSPECT
    not_look_ahead([nå]), %% <--
    w(verb(Live,P,Q)),
    {verbtype(Live,T)},    
    !,accept.


lexv(T,KNOW,P,Q)--->
    faa,
    not_look_ahead([nå]), %% <-- 
    lexv(T,KNOW,P,Q), 
    {verbtype(KNOW,T)},  
    {\+  KNOW = manage}. %% få greie på 
    %% !,accept. Not "!" here

lexv(tv,run,P,Q) ---> %% IV before TV   run with 
    w(verb(run,P,Q)),
    prep1(with),
    !,reject.


lexv(tv,evah,pres,fin) --->  % inverse  of have (artificial)
    w(verb(evah,pres,fin)),
    !,accept.



lexv(cv,be,pres,fin) ---> %% possibly aux (auxilary) %% New verbtype (copula)!
    aux0, 
    be.

lexv(tv,wonder,P,Q) ---> %% lure (på)
     w(verb(wonder,P,Q)).    

lexv(tv,want,P,Q) ---> %% tenke meg = ønske 
     w(verb(think,P,Q)),
     rfxpron.  


lexv(VT,Speak,past,fin)--->   %% ville sett -> så
    aux1,  
    w(verb(Give,past,part)),
    not_look_ahead([om]), %% i am fed up 
    {Give \== have},     
    reflexiv0(Give),          %% meg
    particlev0(Give,Speak),  %% over
    {verbtype(Speak,VT)}.


lexv(TV,Speak,P,Q)--->      %%  *notify
   {TV== tv},                %% coerce to tv if possible
    w(verb(Speak,P,Q)),
    not_look_ahead([om]),  %% i am fed up 
    {Speak \== have},     
    reflexiv0(Speak),          %% meg
    {verbtype(Speak,TV)}.


lexv(VT,Speak,P,Q)--->       %% tv 
    {var(VT)},  
    w(verb(Give,P,Q)),
    {\+ rv_templ(Give,_)},   %%  e.g hope (agent,coevent) 
    not_look_ahead([om]),    %% i am fed up 
    {Give \== have},     
    reflexiv0(Give),         %% meg !
    particlev0(Give,Speak),  %% over
    {verbtype(Speak,VT)}.


lexv(iv,Resign,P,Q)--->  
    aux0,  
    w(verb(Give,P,Q)),
    {Q == fin}, %% experiment 
    {Give \== have},     
    reflexiv0(Give),          %% meg
    particlev0(Give,Resign),  %% over
    {verbtype(Resign,iv)}.


lexv(T,have,P,Q)---> 
    aux0,  
    w(verb(have,P,Q)),
    {verbtype(have,T)},
 %%    not_look_ahead(w(noun(departure,_,_,n))). %% EXPERIMENT
    not_look_ahead(w(noun(arrival,_,_,n))).   % have arrival


lexv(T,Live,past,fin)---> %%  skulle ha hatt -> hadde 
    has, 
    w(verb(Live,past,part)),
    {verbtype(Live,T)}.


%% Moved back:  hvilken øl kan jeg ta () med meg. %%
lexv(tv,bring,P,Q) ---> %% Norwagism  Ta med
    w(verb(take,P,Q)),  %% kjøre = take  OOPS
    prep1(with).        %% jeg kjører med bus
  

lexv(Type,Wait,Pres,Part) ---> %% holde ut = vente| legge ned=stoppe 
     w(verb(Hold,Pres,Part)),  
     redundant0, %% ihvertfall 
     particlev0(Hold,Wait),    %% e.g. ut 0 %% sende ut
    {verbtype(Wait,Type)},   
     !.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    A D J E C T I V E   S E C T I O N
% 
%



%%%¤ PREADJS0 (Seq) 

preadjs0(_) --->
    [s], %% s before kl does not mean "sist" last
    look_ahead_clock,
    !,reject.

preadjs0(AB) ---> 
    so,                 %% so-> for (too)
    preadjs(AB),        %% lengre = lang
    !.

preadjs0((A,B)) ---> 
    
    dent0, 
    preadj1(A),
    adj_conjunction, %% maybe stm-conjunction
 
   %% !,    %% allow backtrack  en feil  (n|a) og svakheten 
    preadj1(B).                      


preadjs0((A,Alist)) ---> 
     dent0, %% den gamle bybrua 
     preadj1(A),

     not_look_ahead(w(prep(_))), %% feil (n) på  

     %% !,    %% allow backtrack  en feil  (n|a) og svakheten 
     preadjs0(Alist).

     %% !. %% Allow  backtrack to [] %%  feil.   (noun|adj)

preadjs0(true)---> []. %% ?optional([av]). 





preadjs((PA,Blist)) --->
    preadj1(PA),

    not_look_ahead(w(prep(_))), %% feil (n) på  
 
    preadjs0(Blist).

%%%¤ PREADJ1 (gr/ADJ)


preadj1(nil/first) --->  %% 1. = first %% TA-110411
    w(nb(1,num)),
    point,
    !.
preadj1(nil/second) ---> %% 2. = second %% TA-110411
    w(nb(2,num)),
    point,
    !.
preadj1(nil/third) --->  %% 3. = third %% TA-110411
    w(nb(3,num)),
    point,
    !.
%% fin %%

     

preadj1(nil/PA) --->   
    w(name(PA,n,station)), %% Precaution Gammel-lina \= old line

    {\+ adjname_templ(PA,_)},
    !,reject.


preadj1(nil/PA) --->   
    w(name(PA,n,_Form)),
    {adjname_templ(PA,_)},
    !.

%% en meget stor * buss fins 

preadj1(VERY/PA) ---> %% TA-110427
    gradverb(VERY),
    w(adj2(PA,nil)). 

preadj1(NIL/PA) ---> 
    not_look_ahead_lit([først,senest,tidligst]), 
    not_look_ahead(w(prep(_))), %% feil (n) på  
    optional([mye]), %% mye lenger tid 
    w(adj2(PA,NIL)),  
    {\+ post_adjective(PA)}, %% fremme kl 17 # 
    !.

%%%
%% RS-141122 Optional adj_conjunction?
% adj_conjunction0 --->  adj_conjunction,!. 
% adj_conjunction0 ---> [].

adj_conjunction ---> [og]. 
adj_conjunction ---> [men].
adj_conjunction ---> [eller].
adj_conjunction ---> ['/'].


%%%%¤¤  ADJ1S    1 eller flere 

adj1s((Big;Blue),X,S,BIGX or BLUEY) --->   %% ad hoc
    adj1(Big,X,S,BIGX),
    [eller],
    adj1(Blue,X,S,BLUEY),
    !.

adj1s((Big,Blue),X,S,BIGX and BLUEY) --->   %% ad hoc
    adj1(Big,X,S,BIGX),
    [og],
    adj1(Blue,X,S,BLUEY),
    not_look_ahead(w(prep(_For))), %% konsis og forståelig for alle
    !.                             %% then separate be_pred

adj1s(Big,X,S,BIGX) --->   %% ad hoc
    adj1(Big,X,S,BIGX).


%%%¤¤¤ ADJ1 
 


adj1(Big,X,S,BIGX) --->  
    gradverbs0(Very),  
    w(adj2(Big,nil)),
    {adj_template(Very,Big,X,S,BIGX)}.  %% Very/Big   Drop distinction 


adj1(Big,X,S,BIGX) --->  
    w(adj2(Big,Comp)),
    {adj_template(Comp,Big,X,S,BIGX)}.  %% Størst=sup big


%% Adjective A treated like an intransitive verb be/A
                                           
%% gradverb1(Very) ---> [Very],{gradv_templ(Very,_)}.  %% SUSPENDED

%%%¤¤ GRADVERBS0 

gradverbs0(Very) --->  %% TA-110110
    gradverb(Very),
    !,
    gradverbs0(_).
gradverbs0(nil) ---> [].

%%%¤¤ GRADVERB0

% jeg forsket litt mer på dette

gradverb0(more) ---> 
    [mer],                %% also s-adverb
    look_ahead(w(adj2(_,nil))),
    !.

gradverb0(Gradverb) --->  
    gradverb(Gradverb), %% ,!. not 1  jeg forsker mer
    not_look_ahead(w(prep(_))),
    !.

gradverb0(nil) ---> [].           

%%%¤ GRADVERB 

gradverb(little) ---> [dårlig]. %% TA-110301
gradverb(more) --->[litt], [mer],!.
gradverb(more) --->[mye], [mer],!.

gradverb(more) ---> [mer].   % jeg forsker mer

gradverb(only) ---> [bare].
gradverb(too) ---> [for]. %% FOR TIDLIG 
gradverb(very) ---> [meget]. 
gradverb(very) ---> [veldig].
gradverb(little) ---> [litt]. 
gradverb(somewhat)---> [noe]. 
gradverb(often) ---> [ofte]. %%  " very delayed" not similar to "often delayed" ?

gradverb(nil) ---> [så].     %%   collides with så fort som mulig



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prepnom(P) ---> prep(P),{P==regarding},!,accept. %% hva kan jeg spørre om
prepnom(P) ---> prepnof(P). 

prepnog(long,from) ---> prep1(from),!,accept. %% Ugly  but fra = after/from ?*?*
prepnog(possible,_) ---> !,reject.
prepnog(_,In)  ---> prepnof(In),!,accept.         %% til = of/to

prepnof(P) ---> prep(P),     %%  Fix ( til => to) 
    {\+ ( P = of)}. 


% Hvor går bussen <> 
% Missing Preposition Repair
% Careful selection

defaultprep(Verb,Var,Prep) --->  
         {Verb \== be}, %% er dette i (morgen)
         {vartypeid(Var,ObjTID)},
     adjustprep0(Verb,ObjTID,Prep),
    !,accept.


adjustprep0(Verb,ObjTID,Prep) ---> 
   adjustprep(Verb,ObjTID,Prep),
   !.
adjustprep0(Verb,ObjTID,Prep) --->
   missingprep(Verb,ObjTID,Prep).  

% Preposition

adjustprep(ask,_,regarding)   --->   [om]. 
adjustprep(dream,_,regarding) --->   [om].
adjustprep(handle2,_,regarding)   --->   [om]. 
adjustprep(know,_,regarding)  --->   [om]. %% not during2 
adjustprep(know1,_,regarding) --->   [om]. %% not during2


adjustprep(go, _,from)    ---> prep(after). %% har du besvart etter påske****
adjustprep(go, _,to)      ---> prep(of).    %% Dirty hack

adjustprep(_, _,Prep)    ---> prep(Prep). %% correct


%% No preposition

missingprep(_,duration,with) ---> !. %% with duration

missingprep(pass,_,_) ---> !,reject. %%  Rough

missingprep(_,thing,_)   ---> !,reject. 

missingprep(go,direction,in) --->  [].

missingprep(arrive,_,at) ---> [].
missingprep(depart,_,from)   ---> [].
missingprep(go,direction,in) ---> []. %% go direction = go in direction
missingprep(go,_,at)     ---> []. 
missingprep(start, _, at)    ---> []. 
missingprep(stop, _, at) ---> [].



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%¤¤ PREP (WORD)


prep0(from) ---> prep(from),!,accept.  %% AD HAC   Hvor går bussen (i) fra

prep0(P) ---> prep(P), %% ,!,accept.  %%   hvor går buss 6 from (fra/etter)
    {P\==of}.                  %% hvor lang tid bruker bussen *på* 

prep0(in) ---> [].              %% hvor kommer bussen 


prep(_) ---> [m],w(nb(_,_)), !,reject. %% M1 = m 1 = med 1 = with 1 = with tram


%% prep(to) ---> [to], %% moholt studentby to studentersamfundet // in N: 
%%     look_ahead(w(name(_,n,_))). %% TA-110331


prep(from) ---> [dra], %% dra = fra SMS
    {value(smsflag,true)},
    look_ahead(w(name(_,n,_))).


prep(P) ---> % and0,  Bussen går (og i dag) skal jeg ...
             %  (i fra syndrom)
      prep2(P).      % Prepositional Expressions (moved (greed))


prep(P) ---> % and0
             prep1(P).  


%%%%¤¤ PREP1 (WORD)

prep1(after) ---> [e],not_look_ahead(['.']),!. %% til e. tambarskjelves gat e 1700

prep1(P) ---> w(prep(P)), not_look_ahead([å]). 

prep1(to) ---> [ti],look_ahead(w(name(_,_,_))). %% ti=til/10 Dial.

%%%%%%%%%%%%%%%%%%%%%% ATOMIC SECTION %%%%%%%%%%%%%%%%%%%%%%%%%%%


atom(XT) ---> 
    w(name(X,_NG,_)), 
    {atom_templ(X,XT)}.

atomlist(L) ---> 
      atom1(N1),
      atom1(N2),    
      atoms0(N1-N2,L).
    
    
atom1(N) ---> 
    w(name(N,n,Class)),  
    {Class \== unkn}.


atoms0(N1,L) ---> 
    atom1(N2),
    atoms0(N1-N2,L).

atoms0(N,N) ---> [].


newatom(XT) --->
    w(name(NN,_,_0)), 
    {atom_templ(NN,XT)}.


newatomid(NN) --->  
    w(name(NN,_,_0)). 



%%%% Subordinate elliptic clauses
%
% John died after Mary died
% 
% John died after the time that Mary died in
%           *****     ****                **

%%%%%¤¤¤¤¤    XSUBJUNCTION  


xsubjunction(nil, coevent, instead_of) ---> [fremfor]. %% E 

xsubjunction(nil, coevent, in_order_to) ---> in_order_to.  

xsubjunction(nil, coevent, without) ---> utenå.   

xsubjunction(nil, coevent, by) ---> [ved],[å]. 



%%%%¤¤¤  SUBJUNCTION 

subjunction(before,  time,  in)  ---> prep1(to), %% inntil 
                                      look_ahead_np. 

subjunction(after,  time,  in)  --->  prep1(after),that. 

subjunction(after,  time,  in)  ---> 
    prep1(after), %% (at) 
    not_look_ahead(w(noun(clock,sin,def,n))), %% prep  kl not subjunction
    not_look_ahead(w(nb(_,_))),  
    look_ahead([jeg]),!. %% etc


subjunction(before, time,  in)  --->  [før],  %% ! not prep 
    not_look_ahead(w(nb(_,_))),               %% før 20 means clock %% Ad Hoc
    not_look_ahead(w(noun(clock,sin,def,n))).  


subjunction(before, time,  in)  --->  [til],  % ... til jeg skal til DV
                                      not_look_ahead(w(name(_Dragvoll,_,_))). %% til dragvoll

%%    bussen som kjører til dragvoll finnes. // not inntil 

% subjunction(before, time,  in)  --->  prep1(to).  %% Norwagism
% buss som går idag til munkegata fins = før munkegata fins 


subjunction(not_withstanding,coevent,nil)  ---> uansett,[om]. 
subjunction(not_withstanding,coevent,nil)  ---> [selvom].  %% techn. 


%%          NB SEQ


uansett ---> [uansett].
uansett ---> [selv]. 

subjunction(unless,coevent,nil)  ---> [med],[mindre]. 


subjunction(nil, coevent, so_that) --->  because.  %%  NB



subjunction(nil, coevent, so_that) --->  if1.      %% hvis.. så .. <--  

subjunction(nil, coevent, despite_of)    --->  prep1(without),[at]. 

subjunction(nil, coevent, instead_of)    --->  instead_of. 

subjunction(nil, coevent, because_of) --->  [med],[at]. %%  behjelpelig med at

subjunction(nil, coevent, because_of) --->  so_that. 
subjunction(nil, coevent, because_of) ---> [slik]. %% john vant slik det var forventet 

subjunction(during, time,  in)  --->  while. 

subjunction(in,     time,  in)  --->  [om],when1. 
subjunction(in,     time,  in)  --->  when1.  
subjunction(in,     time,  in)  --->  [så],w(adv(fast)). %% raskt/snart/hurtig

subjunction(in,     time,  in)  --->  [om],[hvordan].
subjunction(in,     time,  in)  --->  [på],[hvordan]. 

subjunction(in,     time,  in)  --->  [da]. 

subjunction(in,     place,  in)  --->  [der]. 
subjunction(in,     place,  in)  --->  [hvor], %% \+ hvor lang tid
     not_look_ahead(w(adj2(_Long,_Nil))). %% etc %% TA-110530

subjunction(until,  time,  in)  --->  until.

subjunction(in,     time,  in)  --->  [i],[det]. %% Haz
       %% bussen startet i det jeg gikk 

because ---> [fordi].
because ---> [for], look_ahead_lit([da,den]),!. %% TA-110708 Haz?


because ---> [siden], w(noun(Monday,_,_,_)), %% siden mandag=etter mandag
    {constrain(Monday,time)},
    !,reject.
because ---> [siden].   

/* ruter for buss 60 %% TA-110622
because ---> [for],  %% TA-110105
    look_ahead_np.   %% Haz  for trikken står precaution, for is also prep
*/
    


%% because ---> notwithstanding. %% ROUGH uansett,

%%%%%%%%%%%%%%%%%%%%%%%%% END OF GRAMMAR %%%%%%%%%%%%%%%%%%%%%%%% 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% LEXICAL INTERFACE TO NORWEGIAN LEXICON %%%%%%%%%%%%%%%
                                   
%%%%           T H E    J U L E K A L E N D E R     %%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                  
erdetdet ---> be,[det],that0,det0.
 
be_it_tf_that(N) ---> %% TA-110106
    w(verb(see,_,fin)),[det], negation0(N),
   [ut],[til],[at]. %% etc etc etc ad hoc



omaa ---> [om],[å],!.
omaa ---> [å],!.

gadd ---> [vil]. %%

hvormye ---> [hvor],[mye].  
hvormye ---> [hvor],[mange].  %% ? %% TA-110104
hvormye ---> [hvor],[meget].
hvormye ---> [hva].


whatcan --->     [hva],    [kan].
whatcan --->     [hva],    aux1. %%  ?


% hva kan du fortelle OM NP / ikke subord 

ompa ---> [om].   
ompa ---> w(prep(on)).  %% norwagism
ompa ---> w(prep(for)). %% norwagism kvelden 

hver0 ---> [hvert],!.
hver0 ---> [hver],!.
hver0 ---> [].

detå --->  %% ad hoc
    [det],
    infinitive,
    !.
detå ---> 
    [det],
    [og],
    !.
detå --->  
    [det],
    [for],
    infinitive,
    !.
detå --->  
    [det],
    [for],
    [og],
    !.

 
%% buss til IKEA  >buss nr 25<  
 
numberroute ---> optionalbus,num1,!.
numberroute ---> bus1,!.
  
optionalbus ---> bus1,optional([nr]). %% TA-101206
optionalbus ---> num1.
optionalbus ---> [].

num1---> w(noun(number,sin,_,n)),point0,!. %%  nummeret 
num1---> [nr],point0,!.

bus1 ---> w(noun(route,sin,_,_)).
bus1 ---> w(noun(bus,sin,_,_)).


commas0 ---> comma,!,commas0.
commas0 ---> [].

comma0 ---> [','],!. %% if visible
comma0 ---> [].

comma ---> [','].

                            
streetno ---> a,!,reject.  %% pure number, not article, not first etc.
streetno ---> [veg].       %% most probable road, not direction (vei syn veg)
streetno ---> w(nb(N,num)), {N < 500}.

tilsiden ---> prep1(to).
tilsiden ---> prep1(before).
tilsiden ---> [siden].



hva ---> [hva],!,accept. 
hva ---> [hvor],meny,!,accept. 



addressat0 --->  w(name(tuc,n,_)),!,accept.
addressat0 --->  w(name(busstuc,n,_)),!,accept.
addressat0 --->  w(name(bustuc,n,_)),!,accept.
addressat0 --->  w(name(hal,n,_)),!,accept. % my alias name
addressat0 --->  [].


enn ---> [enn].
enn ---> [en].  %% Spell



hatt0 ---> w(verb(have,past,part)),!. 
hatt0 ---> [].        


% liste  ut/opp/ / 

out0 ---> [ut],!,accept.
out0 ---> [opp],!,accept.
out0 ---> [].


%%%%%%%%%%%%%%%%%%%%%%%%%%
%    Article  expressions

a0  ---> a.
a0  ---> [].

a ---> [ett], not_look_ahead(w(noun(time,_,def,_))). %% ett tiden 

a ---> [noen],[av],!.

a ---> [noen], 
    not_look_ahead([av]),  %% TA-110428
    not_look_ahead([de]),  
    look_ahead_np.

a ---> [noe],  not_look_ahead([de]),  %%   Går det noe tog 
               look_ahead_np.           
    %% jeg så noe de liket 

a ---> art1, optional([slik]).

art ---> a.
art ---> a,[eller],more.
art ---> [de].   %% why was this out ??? 
art ---> [all].   %%  Roughly
art ---> not_look_ahead(w(name(_,_,_))), [alt].   %% ALT/Statoil
art ---> every,
         {\+ value(textflag,true)}. 

 
art1 ---> [en].
art1 ---> [et].
art1 ---> [ei]. 

%%%%%%%%%%%%%%%%%%%%%%%%%

allsome0 ---> [noen],[av]. %% rough %% TA-110428
allsome0 ---> all,!.
allsome0 ---> [].    

all0 ---> all,!.
all0 ---> [].    

all ---> every. 

always ---> [alltid]. 
always ---> w(adj2(whole,nil)),w(noun(time,sin,def,n)). %% hele tiden 

and0 ---> and1,!,accept. 
and0 ---> [].

andor0 ---> andor,!,accept.
andor0 ---> [].

andor ---> [og],!. 

andor ---> [eller],!.

betwand0 ---> [å],!.  %% (between A) and (B)
betwand0 ---> [og],!.
betwand0 ---> w(prep(to)),!. %%  mellom A til B
betwand0 ---> [].


and1 ---> [og].

and1 ---> [men], %% statement conjunction  %% Haz %% TA-110725
    look_ahead_lit([en,et]). %% ikke en bil men en båt

%% and1 ---> [å]. %% Hazard ? er det gratis å ta buss 


%% vmod_conjunction is conjunction between verb complements !

vmod_conjunction ---> [mao]. %% TA-110107

vmod_conjunction ---> [men], %% Technicality  %% TA-101125
    not_look_ahead_lit([med,nå]). %% men med internett får
                 %% Jeg kjører etter kl 13 og før kl 16.
                 %% Jeg kjører etter kl 13  og  før kl 16  skal jeg ...
                 %% Jeg kjører etter kl 13 men før kl 16

%% Ad hoc:  dont allow  "til nidarvoll og <time clause>"

vmod_conjunction ---> one_of_lit([og,eller]), 

   optional([så]), 
   not_look_ahead_lit([da,så,nå]), %% TA-110724      %% og nå //stm stm 

   not_look_ahead(w(prep(in))),  %% og i kveld. Ad Hoc %% * bussen går i dag og i kveld
   not_look_ahead(w([ikveld])),  %%
   not_look_ahead(w([imorgen])), %% etc
   not_look_ahead(w(name(_,_,_))).
     

%% hvilken holdeplass vil  buss passere  mellom sentrum | og vestre rosten.


andwhen0 ---> and1,when,!,accept. %% when is ignored (?)
andwhen0 ---> [].                     %% Ignore presumption

andwhere0 ---> and1,prep1(from),where,!,accept. 
andwhere0 ---> and1,where,!,accept. 
andwhere0 ---> and1,[hvorfra],!,accept.
andwhere0 ---> [].  

%%%¤ NP_CONJUNCTION 

np_conjunction(_) ---> %% jeg tar bussen og det er bra
    andor(_), %% og|men
    [det],
    look_ahead_vp,
    !,reject.

np_conjunction(AO) ---> 
    andor(AO),
    not_look_ahead_lit([da,så]), %% TA-110725
    not_look_ahead(w(prep(_))),  %% TA-110304 .. og uten **
    not_look_ahead(['.']).       %% endofline=> også

%%%¤ ANDOR0


andor0(A) --->
    andor(A). 

andor0(and) ---> 
    {value(textflag,true)}.

%%%¤ ANDOR

andor(and) ---> and1, 
    not_look_ahead(['.']),   %% -> også 
    not_look_ahead_lit([jeg,mange,ikke,ingen,noen,disse,dette]). %% ad hoc 

andor(or)---> [eller],not_look_ahead(w(verb(_,_,_))). %% tar buss eller kjører trikk

andor(and) ---> %% er tore amble en lærer ?
    {value(teleflag,true)}, 
    art,
    !,reject.

andor(and) --->  {value(teleflag,true)}.

% andor(nil) ---> [].   %%  EXPENSIVE ???




also0 ---> [også],[samtidig],!. %% smalltalk 
also0 ---> [samtidig],[også],!.
also0 ---> [også],!.
also0 ---> [samtidig],!.
also0 ---> [deretter],!. 
also0 ---> [].

% % %

anaa ---> ann0,ogaa,!. %% TA-110331

ogaa ---> [å].  %% TA-110331
ogaa ---> [og]. %% spiw 

ann0 ---> [an],!,accept. %% Norwagism
ann0 ---> [].

anorder(a,N)   ---> a,  w(nb(N,ord)). 
anorder(the,N) ---> the,w(nb(N,ord)). 

another ---> a,other.

around0  --->     around1. 
around0  --->     [].

around1  --->     ca. %% [ca],point0. 
around1  --->     [om],[lag]. 
around1  --->     prep1(around).

as ---> [som]. %% some (SIC)

as0 ---> as.
as0 ---> [].

andsoon ---> [og], sovidere0. 

sovidere0 ---> sov0,videre0.
sov0  ---> [så].
sov0  ---> [].
videre0   ---> [videre].
videre0   ---> [].



aspossible0 --->  aspossible,!,accept.
aspossible0 --->  possible0.

aspossible --->
    as,
    w(adj2(possible,nil)).



aso0 ---> [så],!,accept. 
aso0 ---> too,!,accept.
aso0 ---> as.
aso0 ---> [].  

at ---> prep(at). 

athe ---> the.  
athe ---> a.
% athe ---> all. %% de første buss 5 -> np_head

athe0 ---> athe,!.    % The book 'ABC' // den 16. september
athe0 ---> [].




%%%  AUXILIARY SECTION %%%

%% Complete sequence of auxilaries 

% auxs(neg,tense).   %% at least 1
% auxs0(neg,tense).  %% 0 or more
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Forthcoming




%  skal få gå ==> gå
%  skal få    ==> få
%  skal    gå ==> gå
%       få gå ==> gå
%       få    ==> få
%  skal       ==> gå 
%          gå ==> gå


%% Passive aux   (..ble)  %% Ad Hoc

blei(N) --->  %% står listet
   
    w(verb(stand,pres,fin)),
    negation0(N),
    look_ahead(w(verb(_List,past,part))), %% parkert,listet,plassert ...
    !.

blei(N) --->  blei,negation0(N).


blei --->  %% står listet 
   
    w(verb(stand,pres,fin)),
    look_ahead(w(verb(_List,past,part))), %% parkert,listet,plassert ...
    !.


blei ---> 
    w(verb(be,_Tense,fin)), % bli/blir
    !.

blei --->  %% passive aux % har/hadde bare  blitt
    has,
    redundant0,
    w(verb(be,past,part)),
    !.

blei --->  %% passive aux %  vil/ville   blitt
    aux1,
    w(verb(be,past,part)),
    !.

blei --->  %% passive aux %  vil/ville  bli
    aux1,
    w(verb(be,inf,fin)),
    !.

%% fikk ikke laget 

%% New Category aux/2 

% aux(neg,tense).    %% complex auxiliary 

% aux1(neg,tense).    % single  auxiliary 

% aux0(neg,tense).    % single  auxiliary , or default


aux0(Neg,Tense) ---> aux1(Neg,Tense),!.
aux0(id,pres) --->   aux0. %% ad hoc  [].



%%%¤¤ AUXS0/2

auxs0(Neg,Tense) ---> %% Ad Hoc
    aux1(Neg,Tense),
    !.
auxs0(_,_) ---> [].



auxs ---> aux1,auxs0. %% <-- %%  introduce with care

auxs0 ---> aux1,!,auxs0.
auxs0 ---> [].


%%%¤¤ AUX1/2

aux1(Neg,pres) ---> [kan],
    redundant0,  
    negation0(Neg),
    look_ahead(w(verb(_,_,_))),
    !.

aux1(Neg,past) ---> [kunne],
    negation0(Neg),look_ahead(w(verb(_,_,_))),!.

aux1(N,past) ---> [burde],negation0(N),!. 
aux1(N,past) ---> [kunne],negation0(N),!. 
                                        
aux1(N,pres) ---> aux1,negation0(N). 
 

skalsaa ---> aux1,so0. 

%%%¤¤ AUX1/0 

faux1 ---> w(verb(get,_,fin)),!. %% faa as aux
faux1 ---> aux1.

aux1 ---> one_of_lit([kan,kunne,får,fikk]),
    not_look_ahead([nå]),
    look_ahead(w(verb(_,inf,_))),
    !. %% kan  være


%% jeg får nå : not i will reach !

%% så kunne dette gjøres | han kunne dette
aux1 ---> one_of_lit([kan,kunne]). %% kan oså verb 
%%    look_ahead_lit([man,du,jeg,vi,dere]), %% ad hoc %% TA-110330
aux1 ---> one_of_lit([bør,burde,må,måtte,skal,skulle,vil,ville]). 


aux10 ---> aux1,!. %% simple, no neg
aux10 ---> [].

aux0 ---> faa,look_ahead(w(verb(_Help,_,_))),!. %% få|r hj_lpe(t)
aux0 ---> [må]. %% Special case, jeg må til nth/ jeg må gå til nth
aux0 ---> be,[så], w(adj2(good,nil)),[å],!,accept. %% ( fronted)
aux0 ---> (doit). 
aux0 ---> [].


%%%%¤¤¤  PAUX0   aux before pres pass


paux0 ---> has,[blitt],!. %% skulle ha blitt %% ad hoc

paux0 ---> [vil],[bli],!. %% .. ilagt en bot


paux0 ---> [Skal],
        {testmember(Skal,
                         [skal,vil,bør,må,kan,
                          skulle,ville,burde,måtte,kunne])},!.

paux0 ---> []. 


%% Genuine Lookahead Problem:  

do(N) --->  use,negation0(N),infinitive.

do(N) ---> 
    (doit),
    negation0(N),hasto0.

do(id )---> [] .  

do0 ---> (doit).

do0 ---> []. 


docan ---> [kan].
docan ---> [må].
docan ---> [får]. %% .. får jeg ta ...
docan ---> (doit),!.

%%%%¤¤¤  DO   Basic active aux

(doit) ---> faa, 
    w(noun(information,_,_,_)), %% få greie på 
    !,
    reject.                          

(doit) ---> [vil],[vil],!,accept. %% e.g.  skulle ville 

(doit) ---> skalsaa. %% aux1 

(doit) ---> may.
(doit) ---> must.



may ---> [kan], look_ahead(w(verb(_,_,_))).  %% + kan synge, - kan  %% kan passeres  engelsk,  

may ---> [får],look_ahead(w(verb(_,_,_))).  

may ---> [bør].   %%  ??? 
may ---> [må].    %%   hvor må jeg vente

must ---> [må].
must ---> [skal]. 



%%% END AUXILIARY SECTION %%%




%%% BE DO BE DO BE DO

be(N) ---> w(verb(hold,_,fin)), %% TA-110106  %% holder meg våken
           negation0(N1),  %% stacked .. må holde meg våken
           rfxpron,
           !,
           negation0(N2),
           {bigno(N1,N2,N)}.


be(K) ---> be1(K),!,accept.  % If expect be and get be, accept be 

be(not) ---> (not),be. %% Stack
be(id)  ---> be.  %% Stack 


be0 ---> optional(be). 

%%%¤ BE 


be ---> aux1, 
        w(verb(be,inf,fin)),!.

be ---> w(verb(have,_,fin)),
        redundant0,   %% sikkert 
        w(verb(be,past,part)),!.

be ---> w(verb(be,_,part)),!. %% skulle vært

be ---> w(verb(be,_,fin)), %% be is basic uninterpreted be
        been0,!. %% er blitt


%% John er ikk død

%%%¤ BE1 

be1(N) --->  %% = be(N?)
    w(verb(be,_Pres,fin)),
    redundant0, %% likevel   
    negation0(N).

be1(N) --->  %% = be(N?) skulle ikke være
    aux1,
    redundant0, %% likevel 
    negation0(N),
    w(verb(be,inf,fin)).

be1(N) --->    %% vil ikke være/ ikke vil være
    negation0(M),
    aux1,
    negation2(M,N), %% not dbl neg 
    w(verb(be,inf,fin)),!.

be1(N) ---> 
    w(verb(have,_,fin)),
    negation0(N),
    w(verb(be,past,part)),!.

be1(N) --->   
    negation0(M),
    be,
    redundant0,      %% dog (ikke)
    negation2(M,N). 
   
be1(N) --->
    w(verb(have,_,fin)),
    negation0(N),
    [blitt].

be1(id) --->
    [blitt].   

be1(not) --->  
    w(verb(reject,_,fin)),
    prep(to),
    be.

%%% 

%%%¤ BE_TRUEFALSE_THAT (NEG)

be_truefalse_that(N) ---> %%  det ser (ikke) ut som at 
   w(verb(See,_,fin)), %% = det ser ut som
      {testmember(See,[look,see])}, %%
   negation0(N),
   [ut],
   somatom0,
   !.



be_truefalse_that(N) ---> %%  det ser (ikke) ut som at 
   w(verb(See,_,fin)), %% = det ser ut som
      {testmember(See,[look,see])}, %%
   negation0(N),
   [ut],
   somatom0,
   !.

be_truefalse_that(N) ---> %%  det virker som om
   w(verb(Be,_,fin)),     %% TA-110122
      {testmember(Be,[appear,be])}, %%
   negation0(N),
   somatom0,
   !.



somatom0 ---> somatom,!. %% TA-110122
somatom0 ---> [].

somatom ---> w(adj2(true,nil)),[at],!.
somatom ---> [som],[at],!.
somatom ---> [som],[om],!.
somatom ---> [som].

somatom ---> [at].
somatom ---> [til],[at],!.
somatom ---> [til].


be_truefalse_that(N) ---> %%  det ser ut som at
   w(verb(Agree,_,fin)), gmem(Agree,[agree,appear]), %%  = det ser ut som
   negation0(N),
   optional([at]),
   !.


be_truefalse_that(N) ---> %% det er så at 
   negation0(N),
   one_of_lit([så,slik]),
   optional([at]),
   !.

be_truefalse_that(id) ---> %% det viser seg at
   w(verb(show,_,fin)), 
   optional([seg]),
   [at],
   !.




be_truefalse_that(N) ---> %% det ser (ikke) ut som (om) 
   w(verb(See,_,fin)), {testmember(See,[see,look])},
   negation0(N),
   [ut],
   somatom,
   !.

be_truefalse_that(N) ---> %% det virker|er (ikke) ut som (om) 
   w(verb(See,_,fin)), {testmember(See,[be,appear])},
   negation0(N),
   somatom, %% TA-110122
   !.


be_truefalse_that(N) ---> %% det ser (ikke) ut som (om) 
   be_truefalse(N),
   optional([at]),
   !.

%%%¤ BE_TRUEFALSE 

be_truefalse(N) ---> %% det virker|er (ikke) ut som (om) 
   w(verb(See,_,fin)), {testmember(See,[be,appear])},
   negation0(N),
   somatom, %% TA-110122
   !.


be_truefalse(N) ---> %% det sto (at) %% TA-110112
    lexvaccept(rv,V,_Pres,fin,N),    %%     w(verb(Stand,_,fin)), 
        gmem(V,[stand,mean2,indicate]),  
    !.
 

be_truefalse(N) ---> %% det ser ut til (at) 
    w(verb(See,_,fin)), {testmember(See,[see,look])},
    negation0(N),
    [ut],[til],
    !.

be_truefalse(N) ---> %% det ser ut til (at) 
    w(verb(See,_,fin)), {testmember(See,[see,look])},
    negation0(N),
    [ut],[for], %%  ?
    !.

be_truefalse(N) ---> %% det ser ut til (at) 
    w(verb(See,_,fin)), {testmember(See,[see,look])},
    negation0(N),
    [ut],[som],
    !.

be_truefalse(N) ---> 
    w(verb(agree,_,fin)), %% stemmer
    !,
    negation0(N).

be_truefalse(N) --->
    be,
    truefalse(N). 

be_truefalse(not) ---> 
    w(verb(reject,_,fin)),
    infinitive,
    be,
    true.


been0 ---> been,!,accept.
been0 ---> [].


been ---> w(verb(be,past,part)). 



betake ---> be.
betake ---> w(verb(take,_,fin)).

both0 ---> [både].
both0 ---> [].

by ---> [av],not_look_ahead([hensyn]). 


ca0 ---> ca,!,accept.
ca0 ---> [].

ca ---> prep1(around), point0,!,accept. %% ca. 


clock0 ---> clock. 
clock0 ---> [].

%%%¤ CLOCK

clock ---> [k],look_ahead(w(nb(_,_))),!. %% K.Johnsens vei \+ kl 
clock ---> [k],point,look_ahead(w(nb(_,_))),!. 
clock ---> [kl],colon,!.
clock ---> point0,klokken,point0,ca0.   %% in case kl -> 
clock ---> point0,klokken,colon0.  %% .kl (= kl.)


klokken ---> [kl]. 
klokken ---> w(noun(clock,sin,_,n)).  %% klokke 
%% klokken ---> [klokken]. 
%% klokken ---> [klokka].  

colon0 ---> colon,!,accept.
colon0 ---> not_look_ahead(['.']). %% fre. = fra. not prep

colon ---> [':']. 
colon ---> [';'].  

%% colon ---> ['.']. % if visible  %% bussen går 20. august

%% Simple Comparators 

%%¤ COMPARATOR1 

comparator1(X)  ---> comparel(X),!.

comparel(eq) ---> equal,tomed0. 

comparel(ge) ---> greater,than0,or1,equal,to0. 
comparel(ge) ---> (not),less,than.
comparel(ge) ---> [minst].

comparel(gt) ---> greater,than.
comparel(gt) ---> [mer],than. 
comparel(gt) ---> prep1(over). %% Most probably clock 
comparel(le) ---> less,than0,or1,equal,to0. 
comparel(le) ---> (not),more,than. 
comparel(le) ---> (not),greater,than.
comparel(le) ---> at,most.
comparel(lt) ---> less,than.
comparel(ne) ---> [forskjellig],prep1(from). 
comparel(ne) ---> [annet],[enn]. 
comparel(ne) ---> [ulik].
comparel(ne) ---> [unntatt]. %% prep1(except).
comparel(ne) ---> unequal,to0.

%% comparel(ne) ---> [ikke].  
%% Hazard // et navn som  ikke du har info om

comparel(Adj) ---> w(adj2(Adj,comp)),[enn]. 

comparel(Adj) ---> [mer],w(adj2(Adj,nil)),[enn].

% comparel(ne) ---> [men],[ikke].  %% buss (til nth) men ikke risvollan * 
           
     

%% Derived Comparators 



comparator2(gt,intelligent) ---> w(adj2(intelligent,nil)),than. %% smartere
comparator2(lt,intelligent) ---> w(adj2(stupid,nil)),than.      %% dummere 


%% Compare sizes

comparator2(gt,quality) ---> w(adj2(good,comp)),than. %% goodness 


comparator2(gt,age) ---> older,than. 
comparator2(lt,age) ---> younger,than.

comparator2(gt,latitude) ---> [nord],[for].
comparator2(lt,latitude) ---> [sør],[for].

comparator2(gt,longitude) ---> [vest],[for].
comparator2(lt,longitude) ---> [øst],[for]. 

comparator2(gt,size) ---> greater,than.
comparator2(lt,size) ---> [mindre],than.


%% comparator2(gt,quality) ---> [bedre],than.


%% Compare adjectives 

comparator3(eq,Good) ---> [like],w(adj2(Good,nil)),[som]. 
comparator3(gt,Good) ---> [mer],w(adj2(Good,nil)),[enn]. 
comparator3(lt,Good) ---> [mindre],w(adj2(Good,nil)),[enn]. 
comparator3(lt,Good) ---> [ikke],[så],w(adj2(Good,nil)),[som]. 
comparator3(ge,Good) ---> [minst],[like],w(adj2(Good,nil)),[som].
comparator3(le,Good) ---> [høyst],[så],w(adj2(Good,nil)),[som].   %% etc etc


superlative(M,Q) ---> filanepr(M,N,Q),quant1(N),!,accept.
superlative(M,Q) ---> quant0(N),filanepr(M,N,Q).


%% Section FILANEPR    First Last Next Previous

%%%¤ FLNP

flnp(A) ---> w(adj2(A,nil)),
    gmem(A,[first,last,next,previous]). 
flnp(next) ---> [nest]. %%   Not syn
flnp(last) ---> w(adj2(late,sup)),!. %% seneste %% TA-101029

flnp(first) ---> w(nb(1,ord)). 

flnpproper(_) ---> [først],!,reject.
flnpproper(_) ---> [sist],!,reject. 
flnpproper(_) ---> [nest],!,reject. 

flnpproper(Adj) ---> flnp(Adj). 

filanepr --->  w(adj2(first,nil)),!. 
filanepr --->  w(adj2(last,nil)),!.
filanepr --->  w(adj2(next,nil)),!. 
filanepr --->  w(adj2(previous,nil)),!. 


filanepr(min(N),N,time) ---> first. 
filanepr(max(N),N,time) ---> latest.
filanepr(min(N),N,next) ---> next.  
filanepr(max(N),N,previous) ---> previous.

filanepr(max(N),N,size) ---> greatest.
filanepr(min(N),N,size) ---> [minste].


%% End FILANEPR


faaverb(V) ---> faa, w(verb(V,_Inf,_Fin)),!. %% kan jeg få vite 
faaverb(V) ---> w(verb(V,inf,fin)),!. %% kan jeg vite  


da0 ---> [da],!,accept.
da0 ---> []. 

de0 ---> [de],!,accept. %% alle (de) 
de0 ---> [].

dendagen(D)     --->  [om],day(D),den0,!,accept.
dendagen(nil)   --->  today,den0,!,accept.     %% idag den 25.10 (feil) ===> 25.10
dendagen(nil)   --->  yesterday,den0,!,accept.
dendagen(nil)   --->  tomorrow,den0,!,accept. 
dendagen(D)     --->  on0,day(D),den0,!,accept. 
dendagen(nil)   --->  on0,[den],!,accept. 
dendagen(nil)   --->  prep1(for),den0,!,accept.
dendagen(nil)   --->  prep1(on),!,accept.   


der0 ---> [der],qm0,!,accept. %% - den der bussen 
der0 ---> qm0.  

qm0 ---> ['?'].               %%
qm0 ---> [].                  %%



detsamme ---> [en],[gang].
detsamme ---> prep1(with),[det],[samme].

%%%¤ DEN0 %% TA-110221

den0 ---> den,!. %% TA-110221
den0 ---> [].

den ---> [den]. %% TA-110221

dendet0 ---> look_ahead([d]),!. %% d.l. øvrelids veg (dont eat)
dendet0 ---> [den],
    not_look_ahead(w(nb(_,_))), 
    !,accept. %% den 12. special

dendet0 ---> [det],!,accept.
dendet0  ---> [].


dent0 ---> [den],!.  %%   den neste (bussen) / det neste(toget)
dent0 ---> [det],!.  
dent0 ---> [de],!,accept.
dent0 ---> [noen],!. 
dent0 ---> [en],!. %% Hazard? .. fin nyttårsdag
dent0 ---> [].

det0 ---> thereit,thereit_not_pronoun,!,accept. 
det0 ---> []. 



dudet ---> [du].
dudet ---> [det].
dudet ---> pronoun(_).

% each ---> [hver].   %% hver time -> frequency 
% each ---> [hvert].  %% hvert minutt -> frequency  %% 
each ---> [alle],the.

earlier ---> [tidligere].
%% earlier ---> prep1(in),sta. %%  dict_n
earlier ---> prep1(on),[forhånd]. 
earlier ---> [derfør]. %% Technical

%% earlier ---> [før].  %% Too Hazardous %% buss går før ..

either0 ---> [enten],!,accept.
either0 ---> [].
 
equal ---> [lik]. 
equal ---> [likt]. 

iyou(du) ---> [du]. 
iyou(jeg) ---> [jeg].
iyou(vi) ---> [vi].

areyou ---> [erru],negation0(_).  %%  Rhetoric
areyou ---> w(verb(be,_,fin)),[du],negation0(_).
areyou ---> [vil],[du],negation0(_), w(verb(be,_,fin)). % vær(e)

every ---> [alle],de0. 
every ---> [en],[hver]. 

%% every ---> [hver]. %% frequency
%% every ---> [hver]. %%

false ---> [galt]. 
false ---> [usant].
false ---> [feil].
false ---> [uriktig].

few ---> [få].
few ---> [fåtallig]. %% avoid trouble få=verb|aux 

first ---> w(adj2(first,nil)). 
first ---> [tidligste].

faa  ---> [få]. 
faa  ---> [får]. 

faa0 ---> faa,!,accept. 
faa0 ---> []. 

fast ---> [fort]. 
fast ---> w(adj2(fast,nil)). 
fast ---> w(adj2(fast,nil)),[mulig]. %% snarest mulig
fast ---> hereafter. %%  (e.g.  snart) 

from ---> prep(from).

førnår ---> [når].
førnår ---> [før].


great ---> w(adj2(great,nil)). 
great ---> [høy].

greater ---> prep(after).
greater ---> [større]. 
greater ---> [høyere].
%% greater ---> [senere]. 
greater ---> [mer]. 

greater ---> great. 

greatest ---> [størst].
greatest ---> [største].  % biggest
% greatest ---> [largest].

halfhour ---> [halv],
    w(noun(hour,_,_,n)).

halfhour ---> [halvtime]. 

has(N) ---> has,negation0(N), % ha amkomst means ankomme
    not_look_ahead(w(noun(arrival,_,_,n))). 
 

has0 ---> has,!. 
has0 ---> []. 

has --->   w(verb(have,_,fin)),
     not_look_ahead(w(noun(arrival,_,_,n))).  
 

hashad0 ---> hashad,!. 
hashad0 ---> [].  

hashad ---> w(verb(have,_,_)), w(verb(have,_,_)),!,accept. %% ha | hatt |ha hatt
hashad ---> w(verb(have,_,_)). 

hasto0 ---> w(verb(have,_,fin)),infinitive.
hasto0 ---> [].

% having ---> w(verb(have,pres,part)). " havende "
% having ---> w(prep(with)).           

hereafter  ---> [om],[ikke],[så],[lenge]. 

hereafter ---> soonar,aspossible0. 
                                                           %% Bare fort = fast
hereafter ---> [så],soon,[som],w(adj2(possible,nil)),!. 
hereafter ---> prep1(in),near,w(noun(future,_,_,_)),!.
hereafter ---> [med],[en],[gang].  
hereafter ---> [heretter]. % snart
hereafter ---> prep1(from),  nowon.  %% fra = after => nowon must first
hereafter ---> prep1(in),w(adj2(nearest,nil)),w(noun(future,_,_,n)).
hereafter ---> prep1(on),w(adj2(_,nil)),w(noun(way,_,u,n)). 
hereafter ---> prep1(after), now1. 
hereafter ---> prep1(after),[dette].
hereafter ---> [raskest],[mulig].
hereafter ---> w(adj2(next,nil)),[gang]. 
hereafter ---> [raskest]. %%  hvilken buss er raskest til
                          %%  hvordan kommer jeg meg raskest til ???

herefrom ---> prep1(from),[her],!,accept. 
herefrom ---> [herfra].  
herefrom ---> [derfra].  %% derifra 


how ---> [hvordan],ialle0.

how ---> [hvorfor],ialle0. %% ad hoc ---> whyq

%% Hoq   Question with statement word order

hoq ---> [vil],[du],[at]. 
hoq ---> w(verb(mean,_,fin)),[det],[at]. %% betyr det at  
hoq ---> has,[det],[seg],redundant0,[at]. 
%% hoq ---> be,[det],w(adj2(true,nil)),[at]. 
hoq ---> be,[det],redundant0,[at].
hoq ---> w(verb(go,_,fin)),[det],[an],[at]. 
hoq ---> w(verb(agree,_,fin)), %% stemmer
         [det],
         negation0(_),          %% rhet
         [at].
%% hoq ---> be,[det],redundant0. %% er det noen som svarer %% TA-101207

%

ihvor ---> [i],[hvor],!. %% TA-110511
ihvor ---> [hvor].       %%

hvor ---> [hvor]. %% Norwegian, <> how



hvordan ---> [hvordan],!,accept.
hvordan ---> [hva],[slags],type0,!,accept.
hvordan ---> [hva],!,accept.         %%  (Only in this context, hazardous)
hvordan ---> [hvor],w(adj2(great,nil)),!,accept. 

hvorfor ---> [hvorfor],ialle0.


type0 ---> type,!,accept.
type0 ---> []. 

type ---> w(noun(type,_,u,n)),!,accept. 




i  ---> [jeg].
i  ---> [meg]. 
i  ---> [oss].  
% i --->  [en].   %% (Hazardous) Hvordan kommer en seg ...
% jeg tar en buss = jeg tar meg buss


ialle0 ---> [].  %% safeguard

if1 ---> [hvis]. %% if/2 is an operator 

if1 ---> [om],look_ahead(w(name(_,_,V))),  %% TA-110409
          {\+ subclass0(V,place)}. %% om nardo \= hvis

if1 ---> [om],look_ahead(w(noun(V,_,_,_))), %% TA-110409
          {\+ subclass0(V,place)}. %% 

if1 ---> [om],look_ahead([jeg]). 
if1 ---> [om],look_ahead([du]). 
if1 ---> [om],look_ahead([han]). 
if1 ---> [om],look_ahead([hun]). 
if1 ---> [om],look_ahead([man]).
if1 ---> [om],look_ahead([vi]).
if1 ---> [om],look_ahead([dere]).
if1 ---> [om],look_ahead([de]).

if1 ---> [om],look_ahead([en]).  %% ad hoc
if1 ---> [om],look_ahead([et]).  %% ad hoc

ifra ---> [fra]. 
ifra ---> [ifra]. 

iman ---> [jeg].
iman ---> [man].
iman ---> [en].  %%  HAZARDOUS  en = 1
iman ---> [du].  

inperiod0 ---> prep1(in),w(noun(hour,_,def,n)),!,accept. 
inperiod0 ---> [om],  w(noun(day,_,  def,n)),!,accept. 
inperiod0 ---> [hver],w(noun(day,sin,u,  n)),!,accept. 
inperiod0 ---> []. % not second, minute , week, month, year etc.



%%%% in_order_to/2

in_order_to(adj/nil/_Expensive,id) ---> infinitiveand. 

in_order_to(begin,id) ---> infinitive,!,accept. 
in_order_to(like,id)  ---> infinitive,!,accept. 

% in_order_to(let,id) ---> [],!,accept. %% Jeg lar deg gå %%  object mod

in_order_to(start,id) ---> infinitive,!,accept. 
in_order_to(stop,id)  ---> infinitive,!,accept.
in_order_to(use,id)   ---> prepnof(TO),
     {testmember(TO,[on,to,for,with])},infinitive,!,accept. 
in_order_to(use2,id)  ---> infinitive,!,accept. 
in_order_to(have,id)  ---> infinitive.   %% no cut

in_order_to(think,id) ---> []. %% jeg tenkte dra til Stryn ???

in_order_to(_,not) ---> [uten],infinitive. % NB not used as a preposotion
in_order_to(_,id) ---> in_order_to.



%%%%% in_order_to/0

in_order_tox ---> infinitive,!. 
in_order_tox ---> in_order_to.

in_order_to ---> forå. 
in_order_to ---> [får],infinitive,!. %% får å // spell
in_order_to ---> [for],infinitiveand,!. %% \+ prep 
in_order_to ---> [før],infinitive,!. %% Dialect før
in_order_to ---> prep1(on),infinitive,!. 
in_order_to ---> prep1(with),infinitive,!.
in_order_to ---> prep1(to),infinitiveand,!. 
in_order_to ---> [av],infinitive,!.
in_order_to ---> [for],[og],!.     %% \+ prep       
in_order_to ---> [får],[å],!.   %% får å 
in_order_to ---> [får],[og],!.  %% får og

%% in_order_to ---> infinitive,!. %% examples ? %% Hazard %% TA-101103


forå ---> [i],ogå. 
forå ---> [med],ogå.
forå ---> [mot],ogå. %% vegre seg mot 
forå ---> [for],ogå.
forå ---> [til],ogå.
forå ---> [over],ogå.
forå ---> [før],[å]. 
forå ---> [ved],[å]. %%   rough  ved å \== for å

%% forå ---> [å]. %% Haz ???

ogå ---> [å]. 
ogå ---> [og].





infinitiveand ---> [å].
infinitiveand ---> [og].

infinitive ---> [å],faa,look_ahead(w(verb(_,_,_))),!. %% .. få komme/få en billett no !
infinitive ---> [å]. 
infinitive ---> [til],[å].  %%  ?

%% infinitive ---> forto0,[å],!. 


inom(in) ---> prep1(in). %% i morgen \= om morgenen
inom(om) ---> [om].      %% om kvelden / i kveld  Norwagism
inom(om) ---> prep1(on). %% på kvelden/kveldstid

instead_of ---> [fremfor]. 
instead_of ---> prep1(in),w(noun(place,sin,def,n)),[for],!.
instead_of ---> [istedenfor].
instead_of ---> [heller],[enn].

% it ---> [det].  %% Hazardious  = there 

it0 ---> [det],not_look_ahead([vil]),!. %% det vil si
it0 ---> [].

it ---> [den].

its ---> [dens],own0.
its ---> [dets],own0.

later ---> [senere].
later ---> [siden], not_look_ahead_np. 
later ---> [deretter]. 

latest ---> w(adj2(sup,late)).
latest ---> w(adj2(last,nil)).

less ---> [før].
less ---> [tidligere].
less ---> [mindre].
less ---> [lavere].

let --->  w(verb(let,pres,fin)). 

little ---> [lite].

long ---> w(adj2(short,nil)). %% how short 
long ---> w(adj2(long,nil)).

%% long ---> much.  

longadj ---> w(adj2(long,nil)).

manypersons ---> [mange], adjnoun,!,reject. % mange () er 
manypersons ---> [mange].

many1 ---> [mange],off0.  
%% many1 ---> [få],off0.  % few (Rhetoric) 

many  ---> so0, [mange],off0.

%% many  ---> so0, [få],off0.% few (Rhetoric)
%% many ---> so0, [mye]. %% bussen bruker mye tid \= mange tider 

meny ---> [mange]. %% klokka
meny ---> [meget].
meny ---> [mye].



me0 ---> [jeg],!.
me0 ---> [meg],!. 
me0 ---> [oss],!. %% hvordan komme oss 
me0 ---> [seg],!. %% hvordan komme seg ...
me0 ---> [].

mineyour0 ---> posspron(_),!. 
mineyour0 ---> []. 

more ---> [mer].
more ---> [fler].
more ---> [flere].

most ---> [de],[fleste].
most ---> [flest]. %% TA-110825

much ---> [mye].   
much ---> [meget].


my ---> [min].
my ---> [mitt].
my ---> [mine].

when10 ---> when1. 
when10 ---> [].

when1 ---> [da]. %% confus? bussen gikk da du syklet 
when1 ---> [når].
when1 ---> [n], {value(smsflag,true)},!. %% AVOID REACH
when1 ---> [tid],look_ahead([går]). %% TA-110128

%%% when1 ---> [nær]. %% Swedish  synword(nær,når) gives nær = reach 
       %% hvilke hpl ligger nær ... %% TA-110510


%% SECTION NEGATION

%%   ikke  bare  []



%%%%¤¤ NEGATION2   % negation2( initial  final ).


negation2(only,only) ---> [],!. %%  %% id 
negation2(id,only) --->   negation(only). %% in case stack
negation2(id,only) --->   negation(only).
negation2(not,id) --->    negation(only). %% ikke bare buss = jo buss

negation2(not,id)  ---> negation(not),!,reject. %% TA-110130 is illegal syntax
negation2(not,not) ---> negation0(id). 

negation2(id,N) ---> negation0(N). 

negation2(often,often) ---> [].

%%%%¤¤ NEGATION0 

negation0(N) ---> {nonvar(N),N==(not)},!. %% vil ikke til trondheim %% TA-110128
negation0(N) ---> negation(N),!.
negation0(id) --->  [].         %% cut trap if negation0(id)

%%%%¤¤ NEGATION  

negation(id) ---> (not),[bare],!.  %%   ikke er redun
%% negation(not) ---> (not),[bare],!,reject. %% ?

%%% negation(not) ---> [umulig].  %% TA-101021 det er umulig for meg

negation(not) ---> [bare],(not).
negation(not) ---> (not). 
negation(only) ---> [bare].  
negation(atleast) ---> [minst].  %%
%% negation(except) ---> [unntatt]. %% Rough 

negation(often) ---> [ofte]. %% EXPERIMENT

%% negation(not) ---> [ingen], %%  quantifier
%%    look_ahead_np.


negatino ---> [ikke],!.
negatino ---> [ingen],!.
negatino ---> [].



near --->  w(adj2(near,nil)). 
near --->  the0,w(adj2(nearest,nil)).

nearest ---> w(adj2(near,sup)).
nearest ---> w(adj2(nearest,nil)). % Norwagism   Nærmeste stasjon til NTH
nearest ---> prep1(nearest) . % 


nest ---> [nest].       %% nest
nest ---> w(adj2(next,nil)). %% neste


next0 ---> next,!.
next0 ---> [].

next ---> w(adj2(next,nil)). 

no ---> [ingen],look_ahead_np.
notall ---> [ikke],[alle]. %% technical 


not0 ---> (not),!. 
not0 ---> [].

(not) ---> [ikke].
%% not ---> [ingen],look_ahead_np. %% quantifier 
(not) ---> [intet],look_ahead_np.


notwithstanding ---> [selv_om]. %% Technical 
notwithstanding ---> [selv],[om]. %
%               ---> på tross av

now0 ---> now1,!. 
now0 ---> today. 
now0 ---> [].

now1 ---> [ennå]. 
now1 ---> [nå].
now1 ---> [no]. %% NB  synword(no,nå) gives no -> nå -> reach 

nowon ---> now1,[av],!. 
nowon ---> now1.

nr0 ---> nr1,!.
nr0 ---> [].

nr1 ---> [nr],point0,!.  %% nr. ==> number .
nr1 ---> [n],point0,!.
nr1 ---> number1,point0,!.


number0 ---> num(_),!. %% DUMMY number !!! which 4 buses go
number0 ---> [].       %% OOPS not dummy num!

number1 ---> w(noun(number,sin,_,n)),   %% number 5 = 5  %% 
            colon0.    

of_course0 ---> of_course.     
of_course0 ---> not_look_ahead(w(verb(_,_,_))). %% []. ja gjør det

of_coursenot0 ---> of_course,[ikke].  
of_coursenot0 --->  not_look_ahead(w(verb(_,_,_))). %%[].nei gjør ikke det

of_course ---> [naturligvis]. 
of_course ---> [selvfølgelig].
of_course ---> [det],w(verb(agree,pres,fin)). %% det stemmer

of0 ---> of,!.
of0 ---> []. 

of ---> prep(of).
of ---> prep1(to). %%% EXPENSIVE

off0 ---> [av],!. 
off0 ---> [].


offrom ---> [av]. 
offrom ---> prep1(from).
offrom ---> [ifra].   %% ?

often ---> w(adj2(often,nil)). %% også sjelden, etc.
often ---> [ofte]. 
often ---> [sjelden]. %%  (SIC) how seldom
often ---> [jevnlig]. %% går bussen jevnlig

ofthe ---> of,the.

ofthe0 ---> ofthe.
ofthe0 ---> [].

older ---> [eldre].

on0 ---> prep1(on),!. 
on0 ---> []. 

newyear ---> w(adj2(new,nil)),w(noun(year,_,_,_)).
newyear ---> [nyttår]. 

om0 ---> [om],!. %% fortelle om bussen ... går
om0 ---> [].  

on0   ---> [på],!. %% En måte å reise (på)   Norwagism
on0   ---> []. 

one   ---> w(nb(1,num)). 
one   ---> a.  

only0 ---> [bare],!.
only0 ---> [hele],!.    %% TA-110427
only0 ---> [nesten],!.  %%
only0 ---> [].

or1 ---> [eller]. 

ordinal(N) ---> 
    w(nb(N,ord)).


oter ---> other.
oter ---> others.

other ---> [annen]. 
other ---> [annet].

others ---> [andre].

own0 ---> [egen].
own0 ---> [egne].
own0 ---> [].


possible0 ---> w(adj2(possible,nil)),!. %% (snarest) mulig
possible0 ---> [].


%%%¤  REFLEXIV0    reflexive pronoun is not taken as an object

reflexiv0(F) ---> reflexiv(F),!,accept. 

reflexiv0(Owe) ---> %% skylde MEG 40 kroner 
    {verbtype(Owe,dtv)},
     !,accept.
   
reflexiv0(_) ---> [].  

%%%¤ REFLEXIV 

reflexiv(ask) --->  rfxpron. %%  ( ## dtv ) %% Rough 
%
% reflexiv(ask) ---> w(prep(after)). %% Opps  particlev
%% spør etter nth og nard

reflexiv(befind) ---> rfxpron.   %% befinne  Norw
reflexiv(beworry) ---> rfxpron.  %% bekymre
reflexiv(buy) --->  rfxpron. 

reflexiv(change) --->  rfxpron. 
reflexiv(come)   --->  rfxpron. 
reflexiv(cost)   --->  rfxpron.
reflexiv(decide) --->  rfxpron.  %% bestemme seg/? avgjøre seg
reflexiv(feel)   --->  rfxpron. 
reflexiv(fit)    --->  rfxpron.  %% egne seg 
reflexiv(find)   --->  rfxpron.

reflexiv(give)  ---> rfxpron. 
reflexiv(go)    ---> rfxpron.  

%  reflexiv(go)   ---> [med].  %%  ( rough ) hvordan kommer jeg med (bussen) til

reflexiv(have) ---> [meg]. %% rfxpron.  
reflexiv(have) ---> [seg]. %% \+ deg   TA har deg på hjernen <--- only exception


%% reflexiv(help)  ---> rfxpron. %% no, object %% TA-101210
reflexiv(hurry) ---> rfxpron. 

reflexiv(learn) ---> rfxpron.   %% lære seg 
reflexiv(move)  ---> rfxpron.   %% flytte seg

%% reflexiv(notify) ---> rfxpron.  %% varsle seg (?) %% Haz, varsle 2 minutter...
%% TA-101126

reflexiv(pass)   ---> rfxpron.  %% passe meg

reflexiv(pay2)   ---> [seg].

reflexiv(promise) ---> rfxpron.

reflexiv(get) ---> rfxpron. %% få meg 
reflexiv(get) ---> [med]. 

reflexiv(receive) ---> rfxpron. %% få meg 
reflexiv(receive) ---> [med].   %% få med (rough) // particle <-----------

%% reflexiv(resist) ---> rfxpron. %% vegre seg 
%% ad hoc, tv_templ

reflexiv(retire) ---> rfxpron. %% pensjonere seg 

reflexiv(run) ---> rfxpron. 

reflexiv(say) --->  rfxpron.

reflexiv(send) --->  to0, rfxpron. %% send til meg ?
reflexiv(show) --->  rfxpron. 
reflexiv(sneak) ---> rfxpron. 

reflexiv(take) ---> [med],rfxpron. %% // particle <-----------
reflexiv(take) ---> [med].         %% 

reflexiv(take) ---> not_look_ahead([dere]), %% also subject
          rfxpron. %% TA-110215 ta meg en øl
          %% tar dere vare på hittegods

reflexiv(tell) --->  rfxpron. %% jeg/du  forteller deg/meg 

%%% reflexiv(tell) ---> [fra].  %% si fra?????
reflexiv(think) ---> rfxpron. 
reflexiv(turn) ---> rfxpron.

reflexiv(want) ---> rfxpron.
reflexiv(wish) ---> rfxpron.
reflexiv(worry) ---> rfxpron. 
reflexiv(write) ---> rfxpron. %% noteret meg %% TA-110113

rfxpron0 ---> rfxpron,!. %% TA-110824
rfxpron0 ---> [].

rfxpron ---> [meg]. %%  <- egegeg
rfxpron ---> [deg].
rfxpron ---> [seg].
rfxpron ---> [oss].
rfxpron ---> [dere]. %% Haz
%% rfxpron ---> [dem].%% Haz jeg tar dem

rfxpron ---> [selv], not_look_ahead([om]). 



%%%%

compassly ---> [nordfra].
compassly ---> [nordover].

compassly ---> [sydfra].
compassly ---> [sydover].
compassly ---> [sørfra].
compassly ---> [sørover].

compassly ---> [vestfra].
compassly ---> [vestover].

compassly ---> [østfra].
compassly ---> [østover].

  
%%%¤  REDUNDANT 

redundant0x ---> [så].
redundant0x ---> redundants0.

redundant0 ---> redundant,!.
redundant0 ---> [].

redundants0 ---> redundant,redundants0,!.
redundants0 ---> [].

redundantsx0 ---> redundant,!,redxxx0. %% trygt og godt %% TA-110106
redundantsx0 ---> [].

redxxx0  ---> [og],redundant,!.
redxxx0  ---> [].


%% TA-110215
redundant ---> w(adv(redundantly)),!.

%% List ad hoc, -> dict  adv2

redundant ---> prep1(in),w(noun(average,_,_,_)).
redundant ---> prep1(in),[allverden]. 
redundant ---> prep1(in),[det],w(adj2(whole,nil)),w(verb(take,past,part)). %% at all
redundant ---> prep1(in),[hvertfall].
redundant ---> prep1(in),[gjen]. 
redundant ---> prep1(for),w(noun(time,sin,def,n)). %%  ?r
redundant ---> prep1(from),a,w(noun(place,sin,u,n)),!,accept.
redundant ---> prep1(on),w(adj2(new,nil)).
redundant ---> prep1(on),[en],w(noun(time_count,sin,u,n)). %% på en g
redundant ---> prep1(to),slutt.
redundant ---> prep1(to),[sammen].
redundant ---> prep1(to),w(adj2(ordinary,nil)), %% til vanlig ( Norwagism)
                   not_look_ahead(w(noun(time,_,_,_))).   %% tid    ( => not    redundant )

redundant ---> always.  
redundant ---> aspossible.  

redundant ---> [altså],not_look_ahead_lit([at,å]).

redundant ---> [bare].    %%  problems ?
redundant ---> [da],not_look_ahead_np. %% Bussen gikk da jeg syklet  
redundant ---> [den],[gang]. 
redundant ---> [derfra]. 
redundant ---> [derfor]. 
redundant ---> [alene].  %% er du alene
redundant ---> [bort].      %% (= vekk) 
%% redundant ---> [du],[da]. %% ser om du da får feil 
redundant ---> [dessverre]. %% 2s 
redundant ---> [egentlig].
redundant ---> [ellers].  
redundant ---> [engang].  
redundant ---> [enklest],[mulig]. 
redundant ---> [enklest].
redundant ---> [ergo].              %%  (altså  noisew)
redundant ---> [farefritt]. %%  :-)
redundant ---> [faktisk]. 
redundant ---> [forøvrig]. 
redundant ---> [forøvrig]. 
redundant ---> [fram]. 
redundant ---> [gjerne]. 
redundant ---> [heller]. 
redundant ---> [helst]. 
redundant ---> [heldigvis].
redundant ---> [herfra].    
redundant ---> [jo]. 
redundant ---> [jovisst]. 
redundant ---> [ikke],[sant].
redundant ---> [ihvertfall].
redundant ---> [imens].
redundant ---> [inne].  %% cfr ute
redundant ---> [kanskje]. 
redundant ---> [langt],[bort]. 
redundant ---> [lenge].  %% Jeg venter lenge 
redundant ---> [likevel].   %% ( syn  allikevel)
%% redundant ---> [mer],[enn],!,reject. 
%% redundant ---> [mer].
redundant ---> [minst]. 
redundant ---> [mon],w(verb(believe,imp,fin)). %% mon tro 
redundant ---> [normalt]. 
redundant ---> [når],[som],[helst]. 
redundant ---> [også].
redundant ---> sometimes. 
redundant ---> [om],w(noun(time_count,sin,def,n)).  %%  om gangen
redundant ---> [ad],w(noun(time_count,sin,def,n)).  
redundant ---> [sikkert]. 
redundant ---> [straks].
%% redundant ---> [selv].  %% ... selv om
redundant ---> [selvsagt]. %% not noise/ influences word position 
redundant ---> [totalt]. 
redundant ---> [uansett]. %% TA-110426
%% redundant ---> [ut].   %% går ut av byen %% TA-110808
%% redundant ---> [ute].  %% været er fint ute | er du ute %% TA-110309
redundant ---> [vanligvis]. 
redundant ---> [vel].  
redundant ---> [videre].      %% (vidre?)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

slutt ---> [sist].
slutt ---> [slutt]. 

please0 ---> please,!,accept. 
please0 ---> [bare],!,accept. 
please0 ---> []. 

please ---> be,so,good,infinitive. %%  snill,good (pre)
please ---> [kan],you,be,so0,w(adj2(good,nil)),[å]. 
% please ---> be,[du],good.  %%  er du snill (post)
% please ---> [skal],[vi].   %%  in case vi =/=> jeg 

slashpoint0 --->   slashpoint,!.
slashpoint0 --->   [].

slashpoint ---> [ende],!. %%  7ende
slashpoint ---> ['/'],!.
slashpoint ---> [i],look_ahead(w(nb(_,_))),!.       %% 6. i 9
slashpoint ---> ['.'],[i],look_ahead(w(nb(_,_))),!. 
slashpoint ---> ['.'],!. 

slash      ---> ['/']. %% TA-110221

dashpoint0 --->  dashpoint,!. 
dashpoint0 ---> [].

dashpoint --->  ['-']. % if present
dashpoint --->  ['.'].




point0 ---> point,!,accept. %%  Always Optional
point0 ---> [].

pointNO ---> point,!,accept. 
%%%% pointNO ---> ['/'],!,accept. %% DATE ! 
pointNO ---> %% Optional in case point is  removed 
    {value(nodotflag,true)}. 

point ---> ['.'].


%% trailer after implicit question

% = dtrailer ?

itrailer ---> [n].  %% neste | bakke"n
itrailer ---> not_look_ahead([n]),[når]. %% lundåsen n
itrailer ---> not_look_ahead([n]),w(adj2(next,nil)).
itrailer ---> [takk].


%% trailer after question


qtrailer0 ---> ['?'],qtrailer,!. 
qtrailer0 ---> ['.'],qtrailer,!. 
qtrailer0 ---> [a],qtrailer,!. 
qtrailer0 ---> qtrailer,!.
qtrailer0 ---> [].


%% qtrailer ---> grums,!. %% grums is Intial noise

qtrailer ---> [a]. %% = da  hva skjer a
qtrailer ---> [takk]. 
qtrailer ---> be,[du],good. 
qtrailer ---> [ca]. 
qtrailer ---> [da].
% qtrailer ---> [du].              %%  hva kan du ? 
qtrailer ---> [eller],[ikke]. 
qtrailer ---> [eller].     

qtrailer ---> w(name(hal,_,_)),!.      %% :-) 
%% qtrailer ---> w(name(bustuc,_,_)),!.   %% :-) %% hva kan busstuc ?

qtrailer ---> optional(w(adj2(great,nil))), 
      w(noun(oracle,sin,u,n)),!. %% :-) 
  %% \+ oraklet 
qtrailer ---> w(noun(Program,sin,u,n)), %% \+ orakelet 
    {testmember(Program,[program,oracle,boss])},!. 

qtrailer ---> [og]. %% = også %%  Haz? 
 
qtrailer ---> [og],[når]. %%  ?

qtrailer ---> [lenger],!. %% går ikke bussen lenger ?   
qtrailer ---> [lengre],!. %% går ikke bussen lenger ?  (slight error) 
qtrailer ---> [så],w(verb(be,_,_)),[du],w(adj2(nice,nil)),!. 
qtrailer ---> w(verb(believe,inf,fin)). %% tro?
qtrailer ---> w(verb(believe,pres,fin)),[du]. %% tror du ?

%%% qtrailer ---> [n].  %% neste | bakke"n %% unnec
qtrailer ---> [ø].  %% mis for'.'
qtrailer ---> not_look_ahead([n]),[når]. %% Lundåsen n 

qtrailer ---> [din],optional(w(adj2(_,nil))),w(noun(_,sin,_,_)). %% din dust 
              %% din will be eaten. når går (bussen din) idiot

qtrailer ---> w(name(_Johanne,_,W)),{testmember(W,[man,woman])},!. 
qtrailer ---> [uansett]. 


%% trailer after command

ctrailer0 ---> ctrailer,!.
ctrailer0 ---> [].

ctrailer ---> please.
ctrailer ---> [takk].  
ctrailer ---> w(verb(be,pres,fin)),[du],w(adj2(nice,nil)). 
ctrailer ---> [da]. %% gjør det da! 
ctrailer ---> [din],optional(w(adj2(_,nil))),w(noun(_,sin,_,_)). %% din dust 


%% trailer after dcl

dtrailer0 ---> 
    {\+ value(dialog,1)},
    %% termchar0, %% bussen står. jeg går %% TA-110105
    dtrailer,
    !. 
dtrailer0 ---> [].

dtrailer --->  w(name(tore,n,firstname)). %% det er bra, tore %% TA-110707

dtrailer ---> w(verb(think,_,fin)),[jeg]. %% TA-110623
dtrailer ---> w(verb(mean,_,fin)),[jeg].  %% TA-101006
dtrailer ---> w(name(bustuc,_,_)).
%% dtrailer ---> [adjø].    %%  etc %% TA-110221 hei hade=hei ?
dtrailer ---> [ass]. %% altså 
dtrailer ---> [da]. %% TA-110504
dtrailer ---> [din],optional(w(adj2(_,nil))),w(noun(fool,sin,u,n)). 
dtrailer ---> [du].  
dtrailer ---> [eller],[hva]. %% TA-101018
dtrailer ---> [eller].
dtrailer ---> [gitt]. 
dtrailer ---> [hvordan]. 
dtrailer ---> [hei].     %%  etc 
dtrailer ---> [ja]. 
dtrailer ---> [jeg]. 
dtrailer ---> [men],[når]. %% TA-110824
dtrailer ---> [ok].  
dtrailer ---> [sjø].     %% Dial
%% dtrailer ---> [takk],forhjelpen0. %% not ignore, yawelcome
dtrailer ---> ['?'], [takk]. 

dtrailer ---> optional([med]),
             [hilsen], %% w(noun(greeting,_,_,_)),  %% hilsen tore 
              skip_rest.

posspron(self) --->  my,own0.  
posspron(man)  --->  [hans],own0.
posspron(woman)    --->  [hennes],own0.
posspron(savant)  --->  your.   %% tuc is a savant 
posspron(person)   --->  their,own0.  %% thing

posspron(thing)   --->  sin. %% oslo sin hovedstad 
 

previous ---> w(adj2(previous,nil)). 


%% therafter/beforethat are used in dialog

thereafter  ---> andor0,later.       %% ( kl 13 eller senere )
thereafter  ---> prep1(after),[det].
thereafter  ---> prep1(after),[dette].  
thereafter  ---> prep1(after),[der].        %%  (igjen)
thereafter  ---> [nest],prep1(after),[der]. %%  (igjen)
thereafter  ---> prep1(after),[hvert].  

beforethat  ---> [derfør]. %% Technical
beforethat  ---> andor0,earlier.       %% ( kl 13 eller senere )
beforethat  ---> prep1(before),[det].
beforethat  ---> prep1(after),[dette].  
beforethat  ---> prep1(after),[der].        %%  (igjen)
beforethat  ---> prep1(before),[dette].
beforethat  ---> [nest],prep1(before),[der]. %%  (igjen)



preperly ---> [en],[del]. 
preperly ---> [enda].
preperly ---> [ekte].
preperly ---> [litt].
preperly ---> [noe].
preperly ---> [reellt].  
preperly ---> [strengt].
preperly ---> [strikt].
preperly ---> [virkelig].



%%%¤¤  PREP2 

prep2(after)  ---> [avgang], not_look_ahead(w(prep(_))).   %% avgang kl 18
prep2(before) ---> [ankomst],not_look_ahead(w(prep(_))).    %% ankomst 18


prep2(after) ---> preperly,prep1(after).
prep2(after) ---> preperly,w(adj2(later,nil)),[enn].
%% prep2(after) ---> etter den som går 

prep2(before) ---> preperly,prep1(before).
prep2(before) ---> preperly,w(adj2(earlier,nil)),[enn].

prep2(according_to) ---> prep1(in),[følge]. 

prep2(after)    ---> clock,prep1(after). 
prep2(after)    ---> around1,prep1(after). 
prep2(after)    ---> [ca],prep1(after). 
prep2(after)    ---> prep1(after),around1. %%  (roughly)
prep2(after)    ---> prep1(from),prep1(after). 
prep2(after)    ---> prep1(to),not_look_ahead([e]), %% til e-verket 
                     prep1(after).  
prep2(after)     ---> prep1(from),[og],prep1(with). 
prep2(after)    ---> [like],prep1(after). 
prep2(after)    ---> (not), prep(before). 
prep2(after)    ---> [senere],[enn]. 
%% prep2(after)    ---> [senest],prep1(after). %%  (SIC)  %% senest not redundant
prep2(after)    ---> [resten],prep1(off).   %% resten av
% prep2(after)    ---> [tidligst].          %% dict synonym

prep2(around)   ---> around1,around0.       %%  rundt omkring

prep2(at)  ---> prep1(in),prep1(at). %% repair 
prep2(at)  ---> prep1(on),prep1(at). %% repair
prep2(at)   ---> prep1(at),w(noun(side,_,_,_)),[av].


prep2(before) ---> [for], look_ahead(w(nb(_,num))). %% for 12.30=før 12.30

prep2(before)   ---> w(noun(arrival,sin,u,n)),prep1(before),!. 
%%% prep2(before)   ---> w(noun(arrival,sin,u,n)),!. %% ankomst Buenget 
prep2(before)   ---> prep1(before),ca.
prep2(before)   ---> [like],prep1(before). 
prep2(before)   ---> (not),prep(after). 
prep2(before)   ---> [senest],prep1(before). %% redundant
prep2(before)   ---> [senest].  
prep2(before)   ---> w(adj2(present,nil)),prep1(before). 
prep2(before)   ---> prep1(to),prep1(before). % Norw
prep2(before)   ---> prep1(to),[ca]. 
% prep2(before)   ---> prep1(between),[nå],[og]. 

%% prep2(beside)   ---> [ved],[siden],[av]. 

prep2(between)  ---> prep1(from),prep1(between).
prep2(between)  ---> prep1(in),prep1(between). 
prep2(between)  ---> a0,w(noun(place,_,_,n)),prep1(between). 

prep2(during)   ---> prep1(in),[løpet],[av]. 
prep2(during2)  ---> [om],ca.

prep2(from)     ---> prep1(from),colon0.  
prep2(from)     ---> prep1(from),prep1(near). 
prep2(from)     ---> prep1(from),w(adj2(up,nil)),prep1(at),!,accept. % "fra oppe ved" ## 
prep2(from)     ---> prep1(from),prep1(from),!,accept.
prep2(from)     ---> [med],prep1(from).
prep2(from)     ---> prep1(in),prep1(from).    % i fra 
prep2(from)     ---> prep1(over),prep1(from).
prep2(from)     ---> [ifra]. %% rather adverb  %% Norwag
prep2(from)     ---> [inn],prep1(from).        % inn fra
prep2(from)     ---> [ut],offrom.  
prep2(from)     ---> prep1(with),w(noun(start,sin,_,_)),prep1(in). 
prep2(from)     ---> umpover,prep1(from). 
prep2(from)     ---> prep1(from),prep1(in),[nærheten],[av].
%  prep2(from)     ---> offrom.  % ut may be adv  
%% prep2(from)     ---> prep1(from),[og],prep1(with). %% after ?


%% prep2(in)   ---> [fra],prep1(in). % hvor går bussen fra i (Roughly)
prep2(in)       ---> prep1(around),prep1(in). 
prep2(in)       ---> [inne],prep1(in). 
prep2(in)       ---> [nede],prep1(in). 

prep2(instead_of) ---> [i],[stedet],[for]. 

prep2(near)     ---> so0,prep1(near),to0. 
prep2(near)     ---> prep1(in),[nærheten],[av].
%% prep2(near)     ---> [langt],prep1(from). %% Rough Nonlogic //
%%  Er det  langt fra A til B
prep2(near)     ---> [like],prep1(at).
prep2(near)     ---> and0,w(adj2(nearest,nil)),possible0,to0. 
prep2(near)     ---> w(adj2(near,nil)),prep1(at). %% nær ved Norw 
prep2(near)     ---> prep1(to),[eller],   w(adj2(near,nil)). 
prep2(near)     ---> prep1(past),[eller], w(adj2(near,nil)). 

prep2(on)       ---> prep1(in),prep1(on).       %%  repair
prep2(on)       ---> prep1(with),prep1(on).     %% NB on / med / med på
prep2(on)       ---> ca0,[midt],prep1(on),!,accept.  
prep2(on)       ---> [nede],prep1(on). 

prep2(out_of)   ---> prep1(to),prep1(outside). 

prep2(outside)  ---> [ikke],prep1(past). 
prep2(outside)  ---> [ikke],prep1(to).

prep2(over)     ---> [litt],prep1(over). 
prep2(over)     ---> prep1(over),[hvilke].       %%   oversikt over hvilke

prep2(past)     ---> [og],[ned]. 
prep2(past)     ---> [og],prep1(past). 
prep2(past)     ---> [ned].       %%
% prep2(past)     ---> [og],[opp]. %% og opp igjen 
prep2(past)     ---> prep1(past),['/'],  prep1(in),[nærheten],[av].  
prep2(past)     ---> prep1(past),[eller],prep1(in),[nærheten],[av]. 
prep2(past)     ---> prep1(to),['/'],prep1(from),!,accept. 
prep2(past)     ---> prep1(to),and0,prep1(from),!,accept.  %% and0 // Probl?
prep2(past)     ---> prep1(from),and1,prep1(to),!,accept.  %% fra til repair 
prep2(past)     ---> prep1(with),w(noun(departure,_,_,_)).
prep2(past)     ---> prep1(past), ['/'], prep1(past). %% forbi/inom
% prep2(past)     ---> prep1(at),w(noun(departure,_,_,_)). %%  ved passering ???                   



prep2(to)       ---> prep1(to),colon0. 
prep2(to)       ---> prep1(to),prep1(to),!,accept.
prep2(to)       ---> prep1(to),prep1(near). %%  + inærheten av ?
prep2(to)       ---> prep1(in),w(noun(connection,_,u,n)),prep1(with).
prep2(to)       ---> prep1(over),prep1(to). 
prep2(to)       ---> prep1(with),w(noun(arrival,_,_,_)).  
prep2(to)       ---> prep1(with),prep1(to).
prep2(to)       ---> andsoon,prep1(to). 
prep2(to)       ---> [hjem],prep1(to).           %% Here, home is dummy
prep2(to)       ---> [inn],prep1(to). %% into  
prep2(to)       ---> [ned],prep1(to). 
prep2(to)       ---> [opp],prep1(to). 
prep2(to)       ---> [tur],[retur]. 
prep2(to)       ---> umpover,prep1(to). 

prep2(towards)  ---> [inn],prep1(towards). 
prep2(towards)  ---> [ut],prep1(towards). 
prep2(towards)  ---> [ned],prep1(towards). 
prep2(towards)  ---> umpover,prep1(towards). 

prep2(until)    ---> until. 

prep2(with)     ---> prep1(with),prep1(on). 
prep2(with)     ---> prep1(with),prep1(in). %%  (first)
prep2(with)     ---> by,[bruk],of.       

prep2(within)   ---> prep1(on),prep1(under).   %%  ROUGH      means duration < 10 min
                                                   
prep2(without)  ---> [fri],[for].            

% % % % % % % % % % % % %

umpover ---> [opp],prep1(over). 
umpover ---> [bort].  
umpover ---> prep1(over). 
umpover ---> [bortover].
umpover ---> [utover].
umpover ---> [innover].
umpover ---> [oppover].
umpover ---> [nedover].
umpover ---> [hitover].
umpover ---> prep1(on),w(noun(route,sin,_,n)).     %%  Norw på vei
umpover ---> prep1(on),w(noun(direction,sin,_,n)). %%  Norw

%   umpover ---> [nordover]. %% -> warning direction
%   umpover ---> [sørover].
%   umpover ---> [vestover].
%   umpover ---> [østover].



pronoun1(_) ---> [de],!,reject. 
pronoun1(_) ---> [en],!,reject.  
pronoun1(X) --->  
    pronoun(X).


%%%¤¤ PRONOUN (word) 

pronoun(thing) ---> one_of_lit([noe,det]),  %% kofør jør du det %% TA-110228
    not_look_ahead_np,      %% TA-110114
    !,accept.


pronoun(thing) ---> [det],  
    look_ahead_vp,
    not_look_ahead(w(adj2(_,_))), 
    not_look_ahead(w(noun(_,_,_,_))), %% dette svaret
    !,accept.


pronoun(agent) ---> [man]. 

% pronoun(person) ---> [en].  %%  Hazardous
% pronoun(self) ---> [en].    % Hazardous jeg tar en buss = jeg tar meg buss 

pronoun(self) ---> [jeg],   %% also J
    not_look_ahead(['.']),  %%  j. aaes veg
    not_look_ahead(w(name(_,_,_))).



pronoun(self) ---> [meg]. 

pronoun(vehicle) ---> [den],  %% Ad Hoc, Elliptic no anaphor 
    not_look_ahead_np, %% TA-110105
    {value(busflag,true)}.


pronoun(thing) ---> [de],     %% de som tar buss 
    not_look_ahead_np, %% TA-110105
    {value(busflag,true)}.   


pronoun(thing) --->  %% dangerous
    [En], {testmember(En,[den,det,en,et])},
    look_ahead([som]),
    !. 


pronoun(Man) ---> [He], 
    {dict_n:pronoun(He,Man)},    %% de = thing
     not_look_ahead(w(nb(_,_))). %% de 2


pronoun(thing) ---> [dette],  %% NB was coevent
%%%     not_look_ahead_np, dette ET ok   %% da gir dette et svar
    not_look_ahead(w(adj2(_,_))), 
    not_look_ahead(w(noun(_,_,_,_))), %% dette svaret
    !,accept.


pronoun(thing) ---> [denne],  
    not_look_ahead_np, %% riktig er adverb
    !,accept.


pronoun(agent)  ---> [vi]. %%  NB jeg og Tom | Jeg og TUC ?

pronoun(savant) ---> [du]. 

pronoun(agent)  ---> [dere]. %% hva er den fineste bussen dere har

%% pronoun(self) ---> [i]. %% (Dialect for 'jeg', NOT SYNONYM !)
%% NO   jeg reiser for å være i Th. 


%%% QUANT_PRON (pron, class)      Quantified pronoun

quant_pron(some,person) --->  %%  hva kan en spørre om
    [en],
    look_ahead(w(verb(_Ask,_,_))), 
    !.

quant_pron(some,thing)  ---> [mye],not_look_ahead_np,!.

quant_pron(every,person) --->  
    not_look_ahead([hver]), %%  hver is not a pronoun!// hver er du
    [alle],
    not_look_ahead_np.

quant_pron(every,thing)  --->
     not_look_ahead(w(name(_,_,_))), %% ALT partname
    [alt],sammen0. 

quant_pron(some,person) --->  %% Experiment den som = den person som
    [den],
    look_ahead([som]),
    !.
quant_pron(some,thing) --->  %%  Experiment  det som ligger
    [det],
    look_ahead([som]),
    !.
 
quant_pron(some,person)  ---> [man].  
quant_pron(some,thing)   ---> [mer], not_look_ahead([enn]).  
quant_pron(some,thing)   ---> [noe]. 

%% quant_pron(some,thing)   ---> [noen]. %% /veh/person?

quant_pron(some,agent)   ---> [noen],   %% experiment 
     avdem0, %% especially   
     not_look_ahead(w(adj(_,_))).

avdem0 ---> [av],[våre],!,reject. %% Ad Hoc %% TA-110428
avdem0 ---> [av],[dem],!. 
avdem0 ---> [].          


quant_pron(some,vehicle)   ---> [noen], not_look_ahead([av]). %% TA-110428

quant_pron(some,agent)  ---> someone. %% WAS person

% quant_pron(some,place)   ---> [noensted]. 

quant_pron(some,thing)   ---> something,
    not_look_ahead(w(verb(_Run,_,pass))). %% det kjøres ruter

quant_pron(no,person)    ---> [ingen],not_look_ahead_np. 

quant_pron(no,thing)    ---> [intet], not_look_ahead(w(noun(_,_,_,_))). 
quant_pron(no,thing) ---> [ingen],[ting].
quant_pron(no,thing) ---> [ingenting]. 
%% quant_pron(no,thing) ---> [lite]. %% * jeg er lite god. 

quant_pron(much,thing)   ---> somuch,       %%  jeg vet mye 
                 not_look_ahead(w(adj2(_,nil))).

quant_pron(little,thing) ---> 
    not_look_ahead(w(adv(_Little))), %%  det hjelper lite  
    solittle,    %%  lite 
    not_look_ahead([å]),
    not_look_ahead(w(adj2(late,nil))). 

quant_pron(some,feeling) --->  somegood.   %% Freak  har du det bra?


%% 

denbussen ---> [den],w(adj2(_,nil)),!,reject. 
denbussen ---> [den].

%% 


sammen0 ---> [sammen],!.
sammen0 ---> w(adj2(possible,nil)),!.
sammen0 ---> [].

somuch ---> so0,much.
solittle ---> so0,little. 

quant0(M)   ---> quant1(M),!,accept.
quant0(+ 1) ---> [].

quant1(+ N) ---> w(nb(N,num)). 
quant1(- N) ---> ordinal(N).

recently ---> [nylig].
recently ---> prep1(in),[det],latest. 


everything   ---> not_look_ahead(w(name(_,_,_))),[alt]. %% partname 

something   ---> [noe],[mer],!,accept. 
something   ---> [noe],[som],[helst],!,accept.
something   ---> [noe].

something   ---> [det],endofline,!.

% something   ---> [mer].  %% du  er mer lang enn meg 
% something   ---> [mye]. 

%% something ---> [dette], %% see also pronoun(thing)// hva er dette
%%    endofline,!,  %% Precaution 
%%    accept.  

something   ---> [det], 

    not_look_ahead([å]),  %% det å 
    not_look_ahead(w(noun(_,_,_,_))).


somegood ---> [det],so0,w(adj2(good,nil)),!. %%  det bra Freak
somegood ---> [det],so0,w(adj2(bad,nil)),!.  %% Rough


sometimes0 ---> optional(sometimes).
sometimes ---> [noen],w(noun(time_count,_,_,_)),!,accept.
sometimes ---> [tidvis]. %% TA-110111 


%% nå og da
%% en og annen gang
%% etc  
sometimes0 ---> [].


notrel ---> look_ahead([som]),!,reject. 
notrel ---> [].

%%%¤¤ RELPRON 

relpron(thing)    ---> [som],also0. 
%% relpron(thing)    ---> so_that,it. %% grunnen til at den versjonen virker %% TA-110708
%% relpron(thing) ---> [].     %%   (Too Expensive)


%% Reciproc pronouns

recipron(man)    ---> [han],self. 
recipron(person) ---> [seg],self. 
recipron(woman)  ---> [henne],self.
recipron(thing)  ---> [seg],self0.
recipron(thing)  ---> [hverandre].


same ---> [samme].

self0 ---> self.
self0 ---> [].

self ---> [selv].

set ---> w(noun(set,_,_,n)). 

setlist ---> set.  
setlist ---> w(noun(list,_,_,n)).

several ---> [fler].  %% * more  les mer arkiv \+ flere arkiver
several ---> [flere]. 
several ---> [mer],[enn],one. 

sin ---> [sin].  %% genitive  
sin ---> [sine].
sin ---> [sitt].



% postadj prefix
saa0 ---> [bare],!,accept. 
saa0 ---> [så],optional([ofte]),!,accept.
saa0 ---> [mye],!,accept.
saa0 ---> [da],!,accept. 
saa0 ---> [].

% preadj prefix

so0 ---> so,!.
so0 ---> [].

so ---> [så].
so ---> too.
so ---> [heretter]. %% straks 
%%%% so ---> very.  

so_that ---> [forat]. 

so_that ---> [som],[at]. %% det virker som at
so_that ---> [slik],that,optional([bare]). %% ad hoc 
so_that ---> [så],that.  
so_that ---> [som],w(verb(do1,_,fin)),that.

so_that ---> [så],look_ahead_lit([jeg,da,den,det]),!. 

so_that ---> [så],look_ahead(w(noun(_Question,_,_,_))),!. %% Haz? 
                                           %% tore justerte klokka så
														 %% spørmål kunne besvares

so_that ---> [til],[at],!. %% rough  %% de får nok samvittighet til at 

so_that ---> prep1(for),[at].   


    %%%%  so_that ---> [så],        %% confuse hvis ... så ... 
    %%%%    not_look_ahead([skal]). %% // vil // verb 

%% so_that ---> [at].  %%  redd at %% jeg vet at // clausal, not subordinate
                       %% TA-110629

%% so_that ---> look_ahead([jeg]). %% jeg er redd jeg må gå %% //NOT in start !!!
%% bussen er på rønningsbakken  jeg leser 


som0 ---> som. 
som0 ---> [].   

som ---> [som].

%%%%%%%%% 

some ---> [noen],of0.

%% There was a point with someonex (not allowed with ?)

someonex ---> someone. %%   noen som 


someone ---> [dere].  %%   dere som           


someone ---> [noen],endofline. 
someone ---> [noen],look_ahead(w(verb(_,_,_))). 
someone ---> so0,[mange]. 
someone ---> [den],look_ahead([som]). %% ?

someone ---> [en],  %% HAZARDOUS destroys   en sjåfør
    look_ahead([som]).

%%%%%%%%%

soonar --->   [snart].      %% bare fort == hurtig
soonar --->   [snarest].  
soonar --->   [fort].       %% så fort som mulig 

soon ---> [fort].   
soon ---> w(adj2(fast,nil)). %% also snarest 
soon ---> [snart]. 
soon ---> [snarest].  

statics(avg)     ---> [gjennomsnittet],ofthe0.
statics(max(+1)) ---> [maksimum],ofthe0. 
statics(min(+1)) ---> [minimum],ofthe0. 
statics(sum)     ---> total,ofthe0.
statics(number)  ---> [antall],ofthe0.


sure ---> [sikker].
sure ---> [sikkert].
sure ---> [sikre].

terminator ---> termchar,!,accept. %% , skiprest. 

termchar0 ---> termchar,!. 
termchar0 ---> [].

termchar ---> ['.']. 
termchar ---> ['?'].
termchar ---> ['!'].
termchar ---> [':']. %%  ? 

% termchar ---> ['+']. %% lowercase '?'



than0 ---> than.
than0 ---> [].    

than ---> [enn].

that ---> [om],[at],!,accept. %%  si fra (om) at
that ---> [at].

that(that)    ---> that.     %% (last) First, capture om at 
that(how) ---> how.
that(when)    ---> when.  
that(where)   ---> where. 
that(whether) ---> paa0,[hvorvidt]. %% undrer på
that(whether) ---> paa0,[om].
%% that(whether) ---> [hvis]. %% du svarer hvis jeg spør 
that(why) ---> [hvorfor].

                             %% THAT0  jeg vil vite avgangen (= objekt!)
paa0 ---> [på],!,accept.
paa0 ---> [].


% that(what)    ---> [hva]. ==>  relhwat   (du vet hva klokka er)

that0 ---> that.
that0 ---> [].

the ---> [den].

the ---> [denne]. %% not as pronoun 

the ---> [det].
the ---> [de]. 

the ---> [dette]. %% not as pronoun 
the ---> [disse], look_ahead_np. 

themost ---> the, [mest].

the0 --->  the,der0,!,accept. 

% the0 --->  which,!,accept. %% jeg vet hvilken buss som går. %% Infernal Bloody Mess
%%% hvilke ruter dekker tyholt ***********

the0 ---> {value(textflag,true)},art. %%  A sweet Liebfraumilch

the0 --->  [].

the10 ---> [det].
the10 ---> [den].
the10 ---> [].

theplu0 ---> all0,theplu,!,accept.
theplu0 ---> [den]. %% actually wrong 
theplu0 ---> all0.

theplu ---> [de]. 


their ---> [deres].
their ---> [de],[andres].
%% their ---> [sine]. % More probably genitiv 
%% their ---> [sin].  %

then0 ---> then1,!,accept.
then0 ---> [].

then1 ---> [da].   %% then/2 is an operator ( dcg_n.pl)
then1 ---> [så].  

theonly0 ---> the0,only0. 

%% thereit0   just optional preliminary pronoun (ignorable)

thereit0 ---> thereit,!,accept.
thereit0 ---> [].

therenot0 ---> thereit,not0,!,accept.  %% Ignore negation
therenot0 ---> (not),thereit0,!,accept.  %% Ignore negation
therenot0 ---> []. 

thereit(N) ---> thereit,negation0(N),redundant0,been0,
                !,accept. 

% in subordinate sentences  % Hvis det ikke går

thereitN ---> thereit,look_ahead([ikke]),!.
thereitN ---> thereit.


% ¤¤¤¤ DET 

dette ---> [det],it_was_pronoun.
dette ---> [dette].  

thereit2(be) ---> [det],!. 
thereit2(_)  ---> thereit,!.
thereit2(be) ---> look_ahead([til]),!. %% .. er (det) til AH p...

init ---> [det]. %% Antecipatory bject  
init ---> [dette],look_ahead_vp. %% TA-110810 ?

thereit ---> [de],look_ahead([noe]). %% ad hoc dial 
thereit ---> [det],thereit_not_pronoun,!,accept. 
thereit ---> [der]. % old fashioned ?  bussen stopper der 
                    % finnes der en buss fra kinsarvik til geilo . (DK) 
thereit ---> [her]. 

thereit_not_pronoun ---> it_was_pronoun,!,reject.
thereit_not_pronoun ---> [].

it_was_pronoun  ---> endofline.
it_was_pronoun  ---> look_ahead_vp. %% TA-110114

%% it_was_pronoun  ---> w(prep(P)). %% hvilken dag  er det i dag 

%% ¤¤¤¤
 

this(X) ---> this,{it_template(X)}. 
this(X) ---> thereit,{it_template(X)}.


this ---> [denne].
this ---> [dette].
this ---> [disse],not_look_ahead_np. 

this ---> [det], look_ahead(['.']),accept.
this ---> [det], look_ahead(['?']),accept. 
this ---> [det],[da],!,accept. %%  Ad Hoc  det da
this ---> [det],end_of_line,!,accept.

this ---> [slik],not_look_ahead_lit([at,som]).

%%%¤ THISPLACE 

thisplace(in) ---> [her]. 
thisplace(to) ---> [hit]. 
thisplace(in) ---> [der]. 
thisplace(to) ---> [dit]. 


timepoint ---> w(noun(time,_,u,n)).   %% tid/tider
timepoint ---> w(noun(clock,sin,u,n)). %% - klokker 


to ---> prep(to).

forto0 ---> forto,!. 
forto0 ---> [].   

forto ---> [for]. 
forto ---> [til].  
forto ---> [om].   


slikat ---> [slik],[at].  
slikat ---> [sikkert],[at]. 


to0 ---> to,!.
to0 ---> [].  

tomed0 ---> [til],!.
tomed0 ---> [med],!.
tomed0 ---> [].

too ---> [for],  
    look_ahead(w(adj(_Long,nil))). %% for lang \? for lengre  

today0 ---> today. 
today0 ---> [].  

today ---> [idag]. 
today ---> prep(in),w(noun(day,sin,u,n)).

tomorrow ---> [imorgen].  %% tommorrow ### 
tomorrow  ---> prep1(in),[morgen]. 

total ---> [total].
total ---> [totalt].
total ---> [totale].
total ---> [sum],of.

true ---> [sann].
true ---> [sant].
true ---> [sanne].
true ---> [slik].   %% Norw. 

truefalse(id)  --->  true.
truefalse(id)  --->  (not),false.
truefalse(not) --->  false.
truefalse(not) --->  (not),true.

unequal ---> [ulik].
unequal ---> [ulikt].
unequal ---> [ulike].

unequal ---> (not),equal.


until ---> [inntil].
until ---> [fram],prep1(to). 


use ---> w(verb(use,_,fin)).
use ---> w(verb(want,_,fin)).  %% Norw.   trenge


%% WHAT

what --->  [hva]. 
%% what --->  which. % which is %% Not Norw.  %% Experiment 

whatbe ---> what,be,!,accept. 
whatbe ---> [hvilke],be,!,accept. 
whatbe ---> [hvilken],be,!,accept. 
whatbe ---> [hvilket],be,!,accept. 
%%%% whatbe ---> [hvordan],be,!,accept. %% ..været

% whatbe ---> be,[dette],!,accept. 

% whatbe ---> [hvem],be.    %%  EXPERIMENT  hvem er bussene til nth
%                           %%              hvem er USA ? *
% whatbe ---> [hvordan],be,!,accept.  %% To rough 

whatbemean ---> [hva],w(verb(be,pres,fin)).
%% whatbemean ---> [hva],w(verb(mean,pres,fin)).  %% bety? % hva mener gud
whatbemean ---> [hva],w(verb(mean2,pres,fin)).    %% hva betyr gud
whatbemean ---> [hva],w(verb(indicate,pres,fin)). %% TA-110112 

% WHEN 

when0 ---> when,!,accept. 
when0 ---> [].

whenx ---> when1,[jeg],!,reject. %% AD HOC. når is verb reach 
                 % etc.
whenx ---> when.


%% when   pure question

when ---> [når],timepoint,!,accept.   %% Dialect 
when ---> [når].

when ---> [hvordan],w(noun(time,_,u,n)),!,accept. 
when ---> [hvor],timepoint,!,accept.  %% Dialect 
when ---> [hva],timepoint,!,accept.   %% Dialect (kva tid)
when ---> which,timepoint,!,accept. 
when ---> prep1(to),which,timepoint,!,accept.  %% ppq is tricked by tid=departure
when ---> prep1(on),which,timepoint,!,accept. 
when ---> [så],[snart],!,accept. 
%% when ---> when1,andwhere0,!,accept. %% pure question
when ---> [hva],[ti].     %% Dialect
when ---> [hvordan],[ti]. %% Dialect %%  koss ti

when ---> [tid],look_ahead([går]). 



%% WHERE 

where ---> [hvor],not_look_ahead(w(prep(from))), 
           andwhen0,!,accept. 
where ---> which,w(noun(place,_,_,_)),!,accept. 

where1 ---> [der],[hvor],!,accept. 
where1 ---> [hvor],meny,!,reject. 
where1 ---> [hvor]. 
where1 ---> [der]. 

wherefrom ---> prep1(from),which,w(noun(place,_,_,_)),!,accept. %%  stations....
wherefrom ---> prep1(from),[hvor],!,accept.
wherefrom ---> [hvorfra].
wherefrom ---> [hvor],[fra]. 
wherefrom ---> [hvor],[ifra].

while ---> [mens].

which0 ---> which,!,accept.
which0 ---> [].


which ---> [hva],prep1(for),a0,!. 
which ---> [hva],[slags],!.          %%   not noisew
which ---> [hvilken],[slags],!.      %%   not noisew
which ---> [hvilken].
which ---> [hvilket].
which ---> [hvilke],off0. 

%%%¤ WHICH2  

which2 ---> which,
            numbertype0, %%  Dummy  which 3 buses ignored assumption
            ofthe0.

which2 ---> [hvem], look_ahead(w(noun(Bus,sin,u,n))), %% hvem buss går
    gmem(Bus,[bus,tram,day]),
    !.        %% etc

which2 ---> [hvordan], look_ahead(w(noun(Bus,sin,u,n))), %% hvem buss går
    gmem(Bus,[label,bus,tram,day]),
    !.        %% etc

%%% numbertype0 ---> num(_),!,accept. %% Hvilken 5 buss

numbertype0 ---> type,!,accept.
numbertype0 ---> [].

with0 ---> prep(with),!,accept.
with0 ---> [].

who ---> [hvem].

whose ---> [hvis].      

mex0 ---> look_ahead([jeg]),!,reject. %% Hvordan lage jeg
mex0 ---> look_ahead([du]),!,reject.  %% Hvordan lage du
mex0 ---> [seg],!,accept.
mex0 ---> [meg],!,accept.
mex0 ---> [oss],!,accept.
mex0 ---> [].

you ---> [du], not_look_ahead([jeg]). %% Freak,  du, jeg skal til nth 

%% you ---> [dere]. %% More probably company behind

yesterday ---> prep1(in),[går]. 
younger ---> [yngre].

your ---> [din]. %% yours ==> your 
your ---> [ditt].
your ---> [dine].
your ---> [di]. 

num_na(_) ---> art,!,reject. %% en 5 ===> 1.5.2000 *
num_na(N) --->  w(nb(N,_Num_ord)). %% første


num(N) ---> w(nb(N,num)),! .



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% PERSONAL (T)

personal('    ') ---> [hysj].  %% :-)

personal('RPGOLRAM') ---> [rpgol].   %% ruller på gulvet (og ler R av meg)                                        
personal('OK') ---> [rpgolram].      %% TA-110524       


personal('Takk') ---> [værsågod]. 
personal('Takk') ---> w(verb(be,imp,fin)),[så],w(adj2(good,nil)).
personal('Takk') ---> so,good,you,be. 
personal('Takk') ---> [bravo].
personal('Takk') ---> w(verb(congratulate,pres,fin)),with0,skip_rest. 

%% personal('Takk') ---> you,be,good. %% hides du er snill og god 

personal(pong)   ---> [ping]. %% Just kidding

personal(T)      ---> greetings(T).



%% Sentences  presuming BussTUC is human.

%% Family session :-)

greetings0 ---> w(verb(help,imp,fin)),optoken,!. 
greetings0 ---> optional(grums),greetings, optoken,!.
greetings0 ---> optional(grums).

greetings('OK') ---> okeys, endofline.
greetings('Hei på deg') ---> hello,daddy. %% :-) 
greetings('Hei') ---> greetings. 


daddy ---> w(noun(father,sin,u,n)),!.
daddy ---> w(noun(mother,sin,u,n)),!.
daddy ---> w(name(_Tore,n,man)),!.

% etc


%%%%%%%%%%%%%%%%%%%%

optoken ---> [':']. %% Kjære bussorakel: når går n b 
optoken ---> ['!']. 
optoken ---> ['.']. 
optoken ---> []. 

%%¤  greetings ---> jo/joda/ja %%  joda du er dum 

greetings ---> [Ja],
    {testmember(Ja,[ja,jo,joda,nei,neida])}. 

/* %% TA-110215
greetings --->   {nvalue(smsflag,true)},
     trafikk,
     !,accept. %% Team Trafikk ...
*/

%% greetings ---> [for]. %% ? -> grums
%% greetings ---> [og].  %% ? -> grums 
greetings ---> hellos.
greetings ---> [hva],[om].
%% greetings ---> [men]. %% ? -> grums 

greetings ---> [nei]. 
greetings ---> [o], adj0,np0(_, __).   %%  :-)
%% greetings ---> [velkommen]. %% -> Thanks

greetings ---> w(verb(say,inf,fin)), [meg]. %% si meg ... 

greetings  ---> w(noun(Oracle,sin,u,n)),
    {testmember(Oracle,[oracle,brother,
                               sister])}, %% etc Kvinnedagen :-)
    colon0,  
    look_ahead([når]), %% verb(reach
    !.
greetings  ---> w(noun(Oracle,sin,u,n)),
    {testmember(Oracle,[oracle,brother,sister])}, %% :-)
    colon0,  
    not_look_ahead(w(verb(_,_,fin))). %% bussoraklet er/var bra 

greetings  ---> w(name(bustuc,n,_)),
    not_look_ahead([som]), 
    not_look_ahead(w(prep(_))), %% TA-110426 bussoraklet for hedmark 
    colon0,   
    not_look_ahead(w(verb(_,_,_))), %% pass .. brukes
    not_look_ahead_vp,  %% busstuc kan brukes ... 
    not_look_ahead_np.  %% busstuc serveren går



trafikk ---> [trafikk].
trafikk ---> [t].          %% (if applicable)

  %% ikke kollektivtrafikk etc




%%%%¤¤¤ GRUMS   %% Intial noise (hawk,  "throat clearing")


%% grums0 ---> hellos0,grums. %% TA-110516 %% hei. -> ?
grums0 ---> [].


grums ---> [rute], {value(smsflag,true)}. %% TA-110303

%% grums ---> hello. %% hei busstuc
%% hei Tore , når går bussen. %% TA-110215
                  %% hei, ser ut som...
grums ---> ['.']. 
grums ---> ['?'].  
grums ---> [':'],!.
grums ---> ['/'],!. 
grums ---> ['!'],!. 
grums ---> ['-'],!. 

grums ---> [eksempelvis],[':'].

grums ---> redundant,[at]. %% likeledes at %% TA-110411 haz?


grums ---> w(noun(Error,sin,u,n)),[':'],
    gmem(Error,[error,thing,subject,example]), 
    !. 

/* c o m m a n d %% TA-110524
grums ---> w(verb(tell,imp,fin)),[meg],
    point0,
    not_look_ahead([om]), 
    !. 
*/



%% grums ---> [selv]. %%  du er ikke bedre
                      %% destroys Selv om
%% grums ---> w(adj2(good,nil)),[at],!. %% TA-110516
grums ---> w(adj2(good,nil)),[om],!. %% ad hoc 
grums ---> [bare]. %% bare serveren er operativ
grums ---> [eller].
%% grums ---> [for].   %% for denne dagen gjelder
%% grums ---> [forøvrig]. %% redindant0 \+ forøvrig fikk jeg \+ test
grums ---> [fyi],point0. 
grums ---> [grr].   
grums ---> [huff].     %% :-)
grums ---> [igjen]. 
grums ---> [jo]. 
grums ---> [og]. 

grums ---> [kort],[sagt].

grums ---> [men]. 

grums ---> [nei],[men]. %% neivel, men ... 

grums ---> [nb]. %% TA-110311 only initially (nightbus)

grums ---> [nei],look_ahead(w(verb(_,_,_))). 
grums ---> [ja],look_ahead(w(verb(_,_,_))). 

%% grums ---> okeys. %% [ok].    %% OK. = greeting 
grums ---> [typisk]. 
grums ---> [uff].   %%  :-)
grums ---> [vel].  
grums ---> [å],
           not_look_ahead_vp,  %% Å komme til Lian er lett
           not_look_ahead(['.']).  %% RS-160109. "A. Jenssens vei" må ikke bli "å ...".
                %% See dcg_n.pl, line 19814
                                  
grums ---> w(nb(1939,num)),point0.

grums ---> optional([for]), 
          w(noun(example,sin,u,n)),optional([':']).  

grums ---> w(noun(question,sin,u,n)),[':']. %%\+ opt.   %% \+ spørsmålet ...
grums ---> [svar],optional([':']). 

%% grums ---> w(noun(answer,sin,u,n)),optional([':']).    %% 

grums ---> [n],[':'].

grums ---> w(noun(traffic,sin,u,n)),colon,!. 
%% grums ---> w(noun(traffic,sin,u,n)),point0,!. % surplus prefix SMS


%% grums ---> w(noun(service,sin,_,n)),!. %% tjeneste koster 1 krone

grums ---> not_look_ahead([dere]), [tt].  

grums ---> [så],w(adj2(funny,nil)),!.

grums ---> [så],not_look_ahead_vp. %% (w(verb(_,_,_))). %% +\ så gikk bussen
grums ---> [ja],[så],not_look_ahead_vp. %% TA-110819

grums ---> [nb],one_of_lit(['.',':','!']).
grums ---> [obs],one_of_lit(['.',':','!']). %% also OBS 


%% Tenk! :-) 

grums ---> [unnskyld],[men]. %% men not optional

grums ---> [ok], look_ahead(w(verb(_,imp,fin))). %% OK, vent 

%% grums ---> [hei], look_ahead(w(verb(_,imp,fin))). %% hei, vent  etc
%% hei busstuc %% TA-110215


grums ---> [supert]. %% TA-101118
% surplus prefix SMS, also on web 

% % % 

%% team ---> w(name(atb,_,_)).
team ---> w(name(team,_,_)). 
team ---> [team].



hellos ---> hello,sludder0,hellos0. %% TA-110215

hellos0 ---> hellos.
hellos0 ---> [].


adj0 ---> w(adj2(_,_)),!,accept.
adj0 ---> [].

hei ---> [hei],der0. 
hei ---> [hallo],der0.  

sludder0 ---> sludder,!. %% TA-110215
sludder0 ---> [].

sludder   ---> [alle],[sammen],!. 
sludder   ---> [der],!.

sludder   ---> [du],
    not_look_ahead(w(verb(_,_,_))),  
    !.          %% hei | du er flink 
sludder   ---> w(name(tuc,n,_0)),
     not_look_ahead(w(verb(_,_,_))), 
    !. 

sludder   ---> w(name(bustuc,n,_0)),!. 

sludder   ---> w(name(tt,n,_0)),!. 
sludder   ---> w(name(tagore,n,_0)),!. %% rough
sludder   ---> w(name(tore,n,_0)),!.   %% ? 
sludder   ---> w(noun(computer,sin,u,n)),!.  
sludder   ---> w(noun(oracle,sin,_u,n)),!.  
sludder   ---> w(noun(man,sin,u,n)),!.          %% ? 
sludder   ---> w(noun(sweetheart,sin,u,n)),!.   %%


okeys0 ---> okeys. 
okeys0 ---> [].

okeys ---> [ok],optional([ja]),optional([men]),optoken. %% TA-101018

hello ---> [bra]. %% TA-101210 (grums?)
hello ---> okeys. 
hello ---> hei,optional(paadeg),sludder0. %% TA-110215


hello ---> [goddag]. 
hello ---> 
%%   optional(   %% 'kveld' in dialog means something 
     w(adj2(good,nil)),
      w(noun(Day,_,_,_)), 
     {testmember(Day,[day,morning,evening,night,afternoon])}. %% NB Norwegian conventions !

paadeg   ---> prep1(on),[deg],!,accept.
paadeg   ---> [og],[hå],!,accept. 


forhjelpen0 ---> 
     prep1(for), 
     [alt],
     !.

forhjelpen0 ---> prep1(for),  
     w(noun(_,sin,def,n)),   %% standard phrase ?  hjelpen/hjelpa/samtalen
%     !,           %% <--
     np1(_, __),             %% busstuc
     !.

forhjelpen0 ---> prep1(for), 
     w(noun(_,sin,def,n)),   %% standard phrase ?  hjelpen/hjelpa/samtalen
     !.

forhjelpen0 ---> prep1(for), 
     np1(_, __),
     !.

forhjelpen0 ---> [skal],[du],w(verb(have,imp,fin)). 

forhjelpen0 ---> [].

hadet ---> [ha],[de],paabadet0. %% TA-101101
hadet ---> [ha],[det],paabadet0. 
hadet ---> [hadet],paabadet0. 
hadet ---> [hade],paabadet0.  

kan ---> w(verb(know,_,fin)).
kan ---> [kan]. 

paabadet0 ---> prep1(on), [badet],!,accept. % :-)
paabadet0 ---> []. 

%%¤ QUIT 

%% quit(error) ---> w(noun(error,sin,u,_)). %% feil, \+ feilen 
%% -> greetings 

quit(thanks) ---> w(adj2(good,nil)),w(noun(trip,sin,u,n)),!. 

quit(bye) --->   w(verb(hear,pres,pass)),skip_rest. %% Sees
quit(bye) --->   w(verb(see,pres,pass)),skip_rest.  %% Høres
quit(bye) --->   w(verb(tals,pres,pass)),skip_rest. %% Snakkes

quit(bye) --->  [med],[vennlig],w(noun(greeting,_,_,_)),skip_rest. %% TA-110804

quit(bye) --->  [vennlig],w(noun(greeting,_,_,_)),skip_rest. %% TA-110428
quit(bye) --->  w(noun(greeting,_,_,_)),skip_rest.
quit(bye) --->  w(noun(midnight,plu,def,n)). %% Natta
quit(bye) --->  [jeg],[snakkes],skip_rest. %% vi snakkes 
quit(bye) --->  w(verb(stop,imp,_)). 
quit(bye) --->  [adjø].
quit(bye) --->  [på],[gjensyn]. 
quit(bye) --->  hadet.  
quit(bye) --->  hadet,godt.
quit(bye) --->  [hei],[da]. 
quit(bye) --->  [godnatt]. 

quit(bye) --->  haen0, 
       godt,
       w(noun(M,_,_,_)),
       {testmember(M,[midnight, %% night, = kveld
                      weekend,easter,summer])}.

quit(bye) ---> [takk],prep1(for),prep1(in),
               w(noun(day,sin,u,n)).

quit(bye) --->  %% vennlig hilsen NN 
    good0, w(noun(greeting,_,_,_)),w(name(_,_,_)).

quit(bye) --->  %% vennlig hilsen NN 
    good0, w(noun(greeting,_,_,_)),w(noun(_,_,_,_)). 

quit(bye) ---> [far],[vel].

quit(bye) --->
   optional(hello), w(verb(have,imp,_)),[en],godt,
    w(noun(_Whatever,_,_,_)).  %% (day,...)


quit(you_are_welcome) ---> [på],[forhånd],thanks,!. 
quit(you_are_welcome) ---> w(nb(1000,_)),thanks,!. 
quit(you_are_welcome) ---> thanks,alot. 
quit(you_are_welcome) ---> w(adj2(nice,nil)),[å],w(verb(speak,_,_)),prep1(with),[deg].

quit(merry_christmas) ---> godt,[jul]. %% :-)

quit(happy_new_year) --->  godt,newyear.

quit(bye) ---> [hilsen],skip_rest. %% if allowed UNK 

% Discourage insults and foul words by boring error mesages
% Do not invite to smalltalk unless you can respond adequately 

% quit(insult) ---> [din],[tosk]...

alot ---> [].  
alot ---> [så],[mye].
alot ---> [så],[meget].
alot ---> [skal],[du],w(verb(have,inf,fin)).

godt --->  w(adj2(good,nil)).          %% godt 
godt --->  w(verb(go,past,part)). %% gått
godt --->  w(adj2(good,nil)),w(noun(day,sin,u,n)). %% (ha en) god dag


deter0 ---> deter,!,accept.
deter0 ---> endofline,!,reject. %% 1800.
deter0 ---> []. 

deter  ---> [det],be,!,accept. %% det er bra
deter  ---> [dette],be,!,accept.

haen0 ---> [ha],[en],!,accept. 
haen0 ---> [].

%% The answer is OK whenever adequate

%% personal('ROTFL') ---> [lol].   %% Laughing out loudly :-)
%% personal('LOL')   ---> [rotfl]. %% Rollng on the floor laughing
   %% eng

personal('Takk') ---> [velkommen],[til],!,skip_rest.

personal('Takk') ---> [velkommen]. 

personal('Takk') ---> [god],w(noun(health,sin,u,n)). %% TA-101110 (bedring|helse)


personal('OK') ---> [ps]. %% Post Scriptum 

personal('OK') ---> optional(hello),
                  so0, 
                  persok.

persok ---> %% written verbatim 
    okeys. %% [ok].

persok ---> %% written verbatim 
    w(verb(test,imp,fin)).

persok ---> [bra],endofline. %% .. for  ...

persok ---> [sorry].

persok --->
    w(verb(be,imp,fin)),
    [så],
    w(adj2(good,nil)).

persok ---> 
    w(verb(forget,imp,fin)),[det].

persok ---> 
    w(verb(forget,imp,fin)), np(_,_:_). 

persok ---> 
    w(verb(be,_,fin)),[du],good,dadanow0. 

persok ---> [unnskyld].

persok ---> 
    [hvordan],w(verb(have,_,fin)),[du],[det],dadanow0. 
persok --->
    [hvordan],w(verb(stand,pres,fin)),[det],prep1(to),withyou0,dadanow0.
persok --->
    w(verb(stand,pres,fin)),[det],w(adj2(good,nil)),prep1(to),withyou0,dadanow0. 
persok --->
    w(verb(stand,pres,fin)),prep1(to). %% :-)
persok --->
    [hvordan],be,w(noun(situation,sin,def,n)). 
persok --->
    [hva],be,w(noun(situation,sin,def,n)). 
persok ---> 
    w(verb(have,_,fin)),[du],[det],w(adj2(_,nil)), %% bra/ kjedelig ...
    dadanow0.               %% har du dyr %% TA-101228

persok ---> 
    [jeg],w(verb(have,_,fin)),[det],negation0(_),so0,good,dadanow0. 

persok --->  [hvordan],w(verb(go,pres,fin)),[det],withyou0,dadanow0. 

persok ---> w(verb(go,pres,fin)),[det],optional([ikke]), 
            w(adj2(good,nil)),withyou0,dadanow0. 

persok ---> [greitt]. %%   etc. etc.

persok ---> w(adj2(good,nil)), endofline.

%% 

thanks ---> ogmen0,thousands0,takk,forhjelpen0.

takk ---> hellos0,[takk]. %% TA-110511 hei, takk for ...
takk --->  w(verb(thank,pres,fin)). %% not syn 
takk ---> [jeg],[vil],w(verb(thank,inf,_)).


ogmen0 ---> [og],!,accept.
ogmen0 ---> [men],!,accept.
ogmen0 ---> [].

thousands0 ---> thousand,!,thousands0. 
thousands0 --->  [].

thousand0 ---> thousand,!,accept.
thousand0 ---> [].

thousand ---> number(1000:_),!,accept.
thousand ---> many1.

withyou0 ---> prep1(with),[_],!,accept. %% henne 

%% withyou0 ---> prep1(with),[dere],!,accept. 

withyou0 ---> [].

%%%¤¤¤ DA DA NOW 0

% Informal, allow time 
dadanow0 ---> todax,danow0. %
dadanow0 ---> danow0.

% Hva er datoen i går (dont skip)

%% Complex passover (Deep Cut Fail)

danow0 ---> 
    look_ahead([nå]),
    notreachphrase, %% succeeds with []
    [nå],
    !.
danow0 ---> [].

notreachphrase ---> reachphrase,!,reject.
notreachphrase ---> [].

reachphrase ---> 
    w(verb(reach,inf,fin)), %% (å) nå (et tog)
    look_ahead_np,!. 


danow0 ---> danow,!.
danow0 ---> [].

danow ---> w(adv(now)),danow,!. %% nå da
danow ---> w(adv(now)).         %% nå
danow ---> [da],danow.   %% da da

% danow ---> w(name(bustuc,_,_)). 
% danow ---> w(name(hal,_,_)).    %%  :-)
% danow ---> [takk]. 


todax ---> today,!,accept.
todax ---> prep1(in),[går],!,accept. %% :-)

good0 ---> so0,good,!,accept.
good0 ---> [].

good ---> w(adj2(good,nil)).
good ---> w(adj2(clever,nil)).
good ---> w(adj2(fast,nil)).
good ---> w(adj2(funny,nil)). 
good ---> w(adj2(honest,nil)). 
good ---> w(adj2(nice,nil)). 
good ---> okeys. %% [ok]. %% may be noise


%% END PERSONAL SECTION

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%% END OF LEXICAL INTERFACE %%%%%%%%%%%

gmem(X,L) ---> {testmember(X,L)}. %% TA-110309 (memb

panic(H) ---> {write(H)}.  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%% END OF GRAMMAR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                 %
%  This file is already too big to maintain for any               %
%  sane person. It must under no circumstances exceed             %
%  19765 lines.                                                   %

%% EXPERIMENT %% RS-1411220
%file_date( filename ) :-
%        writeout:output( filename ).
%
%:- file_date( 'hei' ).

%makegram.
%:- use_module( metacomp, [ compile_norsk/1 ] ).  %% RS-141122 Make the dcg_n.pl file, based on updates in this gram_n file.
%:- compile_norsk( '' ).  %% For quick recompilation
