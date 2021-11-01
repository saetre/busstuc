/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE gram_e.pl  
%% SYSTEM TUC
%% CREATED TA-930310
%% REVISED TA-110823
%% REVISED RS-141122


:-module( gram_e ,[ (--->)/2 ] ).    %% RS-130330    Export consensical grammar rules to dcg_e.pl, via /tuc/metacomp.pl

%  Consensical Grammar for English

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- use_module( '../declare', [] ).  %:-op( 710,xfx, isa ).  % Move to tuc/facts?        %:-op( 1150, xfx, ---> ).
%:- use_module( '../utility/writeout', [ output/1 ] ).  %% RS-141122 Write with following nl (NewLine).

:- op(1150,xfx, ---> ).         %% RS-141026 For gram_n and gram_e
:- op(1150,xfx, ( ---> ) ).     %% RS-141026 For gram_n and gram_e

:- op( 731,xfy, ::: ).          %% sentence tag  %% TA-090514 
:- op( 730,xfy, :: ).           %% lambda infix      %% RS-131229 For dialog/frames2 and /virtuals (autofile)
:- op( 710,xfx, isa ).          % Move to tuc/facts

%% :- use_module( '../db/busdat', [ clock_delay/3 ] ). %%, named_date/2 ]). %% Moved to timedat.pl

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

wx(adj2(NIL,GOOD)) ---> w(adj2(GOOD,NIL)). %% Ad Hoc


%% Consensical Grammar   (Context Sensitive Categorial Attribute Logic Grammar)

%%   p \ q   Phrase p starting with q
%%
%%   p - q   Assume q, try p
%%
%%   p / q   p missing q within 
%%
%%   p = q   Phrase p as defined exactly by q 
%%
%%   
%%
%%   begin  
%%     ...    Prevents movement from store to text exactly
%%   end
%%
%%   lock  
%%       ....  Prevents movement from store to text temporarily
%%   unlock 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                       %
% Predicates are ordered by a top down calling order    %
%                                                       %
% Grammar Rules are arranged by a greedy heuristics:    %
%  trying the longest possible phrases                  %
%  in decreasing order of probability.                  %
%  If a phrase is analysed as a category,  then         %
%      no longer phrase for that category is possible   %
% The first syntactically and semantically satisfying   %
%   analysis is adopted.                                %
%                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Suffix Conventions 
%
%     Dummy          00
%     Optional       0        ?
%     One (complex)
%     One simple     1
%     One or more    s        +
%     Zero or more   s0       *
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% New Option: Read from Text 

sentence([S]) ---> 
   {value(textflag,true)},  
   !,
   sentence1(S), 
   terminator.


% New Regime. Several sentences on a line, but with decent error message.


sentence([new:::P]) --->  
    {value(queryflag,false)}, %%  Only in multi dialog system ( dialog,1)
    declaration(P),
    terminatore, 
    !,accept.

sentence([P]) ---> 
    {value(queryflag,true)}, 
    implicitq(P), %% only one on the outer level.
    terminatores0, 
    !,accept.


sentence(ListOfS)  --->  
    onesentence(S1),
    { S1 \== error}, 
    check_stop,  
    moresentences(S1,ListOfS).

moresentences(S1,Square) --->
    onesentence(S2),
    evenmore(S1,S2,Square).


evenmore(S1,[],[S1]) ---> []. %% Normal end of list


evenmore(S1,error,[S1,error]) ---> %% Erroneous end of list
    !,
    skip_rest.


evenmore(S1,S2,[S1|Square]) --->     
    moresentences(S2,Square).


onesentence([])    --->  endofline,!,accept.
onesentence(P)     --->  conf_statement(P),terminatore0,!,accept.
onesentence(S)     --->  sentence1(S), terminatore,!,accept.
onesentence(error) --->  skip_rest. 


conf_statement(confirm:::TF)   ---> confirm(TF).

confirm(true)  ---> [yes].
confirm(false) ---> [no].

endofline ---> terminator,endofline,!,accept.
endofline ---> end_of_line.  %%  runtime routine  (dagrun.pl)


terminatore0 ---> terminatore,!,accept.
terminatore0 ---> []. %% comma


terminatores0 ---> terminator,!,terminatores0. 
terminatores0 ---> check_stop,endofline,!,accept. %% Really end


terminatore ---> [and],!,accept. 
terminatore ---> [or],!,accept.    %% Incorrect, but better than errm

terminatore ---> terminator1.

terminator1 ---> terminator,!,accept. 
terminator1 ---> end_of_line,!,accept. 


sentence1(P) --->     %% Moved before question
    command(P).   %% gi meg bussene fra nth

 
sentence1(item:::P)  ---> 
    noun(_,sin,u,n,it:_,P),
    terminator1, %%  NOT and/or here
    !,accept.

sentence1(item:::P) --->  
    item(P),
    terminator1,  %%  NB NOT and/or! 
    !,accept.
 


sentence1(new:::P) --->
    greetings0, 
    statement(P).

sentence1(P) --->
    greetings0,
    question(P),
    optional(qtrailer). %% ... next. 

%%% ITEM SECTION

item(P) ---> 
     name_phrase(_IND,_,true,P). 


%%%% COMMAND SECTION


command(doit:::quit(Message)) ---> quit(Message),toyou0. 

command(doit:::reply(Ans)) ---> personal(Ans),!,accept. 


command(doit:::exists(S:Event)::Q) ---> %
    {type(event,Event)},
    dont(N), %% dont worry

    not_look_ahead(w(verb(be,_,_))), %% are you 

    lexv(_Vt1,V,pres,fin), 
    {\+ testmember(V,[be,be1,thank,do1,cost])}, %%  do[es] the bus stop.
    name_phrase(_IND,X,P1,P)
       \ w(name(tuc,n,savant)), 
%    !,                           % hazardous   show/list 
    worldcom(S,P1,ERS), 
    verb_phrase1(X,S,id,ERS) 
             \
                                            % capture clausal_complement
    lexv(_Vt2,V,pres,fin),
    {negate(N,P,Q)},

    addressat0. 


command(doit:::replyq('Hello')) --->  
    greetings.  


addressat0 --->  w(name(tuc,n,_)),!,accept.
addressat0 --->  w(name(busstuc,n,_)),!,accept.
addressat0 --->  w(name(bustuc,n,_)),!,accept.
addressat0 --->  w(name(hal,n,_)),!,accept. % my alias name
addressat0 --->  [].

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

statement(P) --->  
     statemen(real,P).  


%%   (Rule definition)


statemen(NewHere,P) ---> 
    {value(queryflag,false)},
    ifstatement(NewHere,P).


statemen(R,PQ) --->
    statemen1(R,P),
    statemens0(R,P,PQ).

statemens0(R,P,P and Q) --->
   and1,
   !,
   statemen(R,Q).

statemens0(_,P,P) ---> [].


% ......


statemenreal(P) ---> 
   statemen1(real,P).   

statemen1(R,P) ---> % simple version, with world
    statem(S,event/R/S,P).

ifstatement(R,forall(S)::(event/R/S and P => Q)) ---> 
    if1,                  
    statems(S, true,P),  % ands, no if
    then1,
    statemes(S, true,Q). % ands, if


statemen1(R,P) ---> % simple version, with world 
    statem(S,event/R/S,P).


statemes(S,Com,exists(S:Event):: (Com and Q)) --->
    {value(queryflag,false)},
    {type(event,Event)}, 
    {type(event,Event)},
    ifstatement(S,Q).


statemes(S,Com,P) --->
    statems(S,Com,P).


statems(S,Com,Q) --->          
    statem(S,Com,P),         
    statems0(S,Com,P,Q).


statems0(_,_,P,P) ---> [].   


%% Antecipatory Infinitivals

statem(S,Com,P) ---> %% Experiment
    thereit,        
    pvimodal(Cost,Money),    %% costs , takes, lasts
    {constrainit(IT,Money)},
    verb_phrase1(IT,S,id,Com:P) \
        w(verb(Cost,pres,fin)).  %   koster penger aa ta buss


statem(S,Com,Q) --->
    thereit,
    w(verb(Rain,_,fin)),
    {testmember(Rain,[rain,snow])},
    !,
    state(S, Com,Q) \ 
(   [something],  
    lexv(iv,Rain,pres,fin)).

statem(S,Com,P) ---> % to work on holidays is fun 
     {value(textflag,true)},
     infinitive,
     {constrainit(IT,agent)}, 
     verb_phrase1(IT,S,id,CVP),
     !,
     be,
     be_complements(IT,S,Com:P)  - 
        (infinitive, 
         verb_phrase1(IT,S,id,CVP)).


statem(S,Com,Q) --->  %% it is said  that the bus goes 
    {value(textflag,true)},
    thereit,
    be,
    w(verb(say,past,part)),
    [that],
    !,
    state(S,Com,Q) \ ([someone],w(verb(say,pres,fin)), [that]).


statem(S,Com,P) ---> % it is good to work // fronted temporarily
    {value(textflag,true)},
    thereit,        
    be,
    {constrainit(IT,agent)}, 
    be_complements(IT,S,Com:P).    


  

statem(S,Com,P) --->             
    it,
    be,        
    noun_phrase(X,X1,Q),
    rel(X),
    state(S,Com,P)  -  noun_phrase(X,X1,Q).

statem(S,Com,P) --->  
    it,
    be,
    verb_modifier1(Prep,Y,SC,P3),
    that,
    state(S,Com,P)  -  verb_modifier1(Prep,Y,SC,P3).

statem(S,Com,Q) --->
    state(S,Com,Q). 


statem(S,Com,P) ---> 
   {value(textflag,true)},
   adverbial3(Prep,Y,SC,P3),
   state(S,Com,P)  -  adverbial3(Prep,Y,SC,P3).    


statem(S,Com,Q) --->
    adverb(Day,Today,pre), 
    { Today \== (mode) }, %%  In we go ***
    state(S,Com,Q)  -                    
        adverb(Day,Today,_). 

statem(S,Com,Q) --->
    adverbial0(Prep,Y,SC,P3), 
    state(S,Com,Q)  -                    
       adverbial1(Prep,Y,SC,P3). 


statem(S,Com,P) ---> % it is good to work
    thereit,        
    be,
    negation0(_), %% Rhethoric 
    {constrainit(IT,thing)},
    w(adj2(Good,Nil)),
    !,accept,  
    be_complements(IT,S,Com:P)
       \ w(adj2(Good,Nil)). % It is dark tonight 



%-

descend00(Real,  S,event/Real/S:P,P) ---> [].

worldcom(S,P1,event/real/S:P1) ---> []. 
%%     {value_world(Real)}.                   


state(S,Com,Q) --->  
    stm(S,N,Com:P), 
    {negate(N,P,Q)}. 


state(S,Com,Q) --->  %% Jargon 
    [thats],
    !,accept,
    state(S,Com,Q)\([that],w(verb(be,pres,fin))). 


state(S,Com,Q) --->    
    it,
    be_truefalse(N),
    that,
    state(S,Com,P),
    {negate(N,P,Q)}.

state(S,Com,Q) --->    
    that,
    state(S,Com,P),
    be_truefalse(N),
    {negate(N,P,Q)}.

stm(_,_,_) ---> 
    [what],!,reject. %% relwhat is not allowed first

stm(_,_,_) ---> 
    [who],!,reject. %% relwhat/   who is your creator


stm(S,N,Com:P) --->    
    noun_phrase(X,P1,P), 
    verb_phrase(X,S,N,Com:P1).
    

stm(S,N,Com:P) --->      
    thereit,           
    be(N),
    stm(S,id,Com:P)
         -  w(verb(exist,_,fin)). 

stm(S,N,Com:P) --->  %% TA
    thereit,    
    lexv(iv,V,_,fin), %% intrans_verb(V,X,S1,Q,_,fin), 
    stm(S,N,Com:P) %% 
         -   lexv(iv,V,_,fin). %% intrans_verb(V,X,S1,Q,_,fin). 

stn(Real,exists(S:Event):: Q) ---> 
    stm(S,N,(event/Real/S):P), 
    {type(event,Event)}, 
    {negate(N,P,Q)}. 

st0(P) ---> 
   stn(real,P). 

%%%%%%%%%%% QUESTION SECTION %%%%%%%%%%%%%%%%

question(P) ---> whenq(P). % first (what time)

question(P) ---> whichq(P).
question(P) ---> whoq(P).

question(P) ---> whereq(P).
question(P) ---> wherefromq(P).
question(P) ---> whatq(P).
question(P) ---> howadjq(P).
question(P) ---> howmuchq(P).  
question(P) ---> whyq(P). %% TA-110215
question(P) ---> howq(P).
question(P) ---> ppq(P).
question(P) ---> whoseq(P).
question(P) ---> question1(P). 

question1(test:::P) ---> question0(P), addressat0.
 %% can you open the door, Hal

question0(P) ---> hasq(P).
question0(P) ---> isq(P).
question0(P) ---> ynq(P).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Implicit What IS 

%%%¤ IMPLICITQ 

implicitq(_) ---> 
    reject_implicitq, 
    !,reject.

reject_implicitq  --->  %% TA-110428
    [bye].

reject_implicitq  ---> 
    [i].

reject_implicitq  ---> %% ? dummy
    [if].

reject_implicitq  ---> 
    [that].


%% etc, not completed

implicitq(_) --->  % this afternoon  ==> causes oo
    this,
    !,reject.  

implicitq(_) --->  % this afternoon  ==> causes oo
    it,
    !,reject.  

%% Implicit Bus from  to

implicitq(_) ---> %%   at which ...
    prep1(_),
    which2,
    !,
    reject.

implicitq(_) ---> %%  where
    [where],
    !,
    reject.


implicitq(modifier(S)::: Com12 and P3) ---> %% now to Dalen Hageby
    [now],
    {\+ value(teleflag,true)},
    {\+ value(textflag,true)},
    {lex:no_unprotected_verb}, %% NEW AUXILLARY    tuc/lex.pl
    not_look_ahead(w(adj2(_,_))), %% raskeste 
    not_look_ahead(w(noun(_,_,_,_))), %% buss etc
    {setvartype(XB,vehicle)}, 
    worldcom(S,P3,ERS),  
    verb_modifiers(go,XB,S, Com12 :true, ERS) - [now],  %% TA-110105
    {traceprint(4,iq10)},
    !,accept. %%   ( don t waste time )



%% Next to  til  NTH...

implicitq(modifier(S)::: Com12 and P3) ---> %%   buss 5 i morgen
    flnp(Next),
    w(prep(To)),  
    !,accept,

    worldcom(S,P3,ERS), 
    verb_modifiers(go,X:vehicle,S, Com12  :X isa vehicle and adj/nil/Next/X/S, ERS) \ 
        w(prep(To)),
    !,accept. 


implicitq(_) --->  
    w(adj2(N,nil)),       %% good morning
    {\+ testmember(N,[direct,first,second,nearest,last,next,third,early,last,late,previous,central])}, 
    !,reject.   



implicitq(modifier(S)::: Com12 and P3) ---> 
    namep(_,X,P),
    {constrain(X,vehicle)},
    worldcom(S,P3,ERS),  
    verb_modifiers(go,X,S, Com12  :P,ERS),
    !,accept.


implicitq(new:::P ) --->     %% bus 5  \+ bus 5'o clock
    {\+ value(dialog,1)},   
    not_look_ahead(w(prep(_))),
    {lex:no_unprotected_verb},   
    np0(X,P1,P),    
    {\+ vartypeid(X,time)}, 
    {\+ vartypeid(X,clock)}, 
    constrainvehdep(X), 
    not_look_ahead([which]), 
    not_look_ahead([that]), 
    !,accept,                
    verb_phrase1(X,S,id,event/real/S:P1) \ w(verb(go,pres,fin)),
    endofline,     
    !,accept. 

implicitq(modifier(S)::: Com12 and P3) ---> %%   første buss i morgen
    np_kernel(0,X,W1,W1,true ,P),
    constrainvehdep(X), 
    not_look_ahead(w(verb(_,_,fin))), 
    worldcom(S,P3,ERS), 
    verb_modifiers(go,X,S, Com12  :P, ERS),
    !,accept. %%   ( don't waste time )


implicitq(modifier(S)::: Com12 and P3) ---> %% to nardo
    not_look_ahead_np, %% ad hoc    
    {setvartype(XB,vehicle)}, 
    worldcom(S,P3,ERS),
    verb_modifiers(go,XB,S, Com12  :true, ERS), 
    !,accept. %%   ( don't waste time )

implicitq(modifier(S)::: Com12 and P3) ---> %%  nardo
    look_ahead_np, %%  Nardo %% TA-110121
    {setvartype(XB,vehicle)}, 
    worldcom(S,P3,ERS),
    verb_modifiers(go,XB,S, Com12  :true, ERS), 
    !,accept. %%   ( don't waste time )





constrainvehdep(X) ---> {vartypeid(X,thing)},!,reject. 
constrainvehdep(X) ---> {constrain(X,vehicle)},!,accept.
constrainvehdep(X) ---> {constrain(X,departure)},!,accept.
constrainvehdep(X) ---> {constrain(X,time)},!,accept. 


%% Has question

hasq(P) --->  
    has,           
    statement(P)  / w(verb(have,pres,fin)). 


isq(P) --->   
    be,                
    statement(P)  /  be. 

ynq(P) --->
    (do),        
    negation0(_), %% Rhet %% TA-110316
    statement(P).      

ynq(P) --->          % not RP %%  Goes the bus to NTH// Norwagism
    lexv(iv,Go,A,B), 
    {testmember(Go,[go])}, 
    statement(P) /  lexv(iv,Go,A,B).  


%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%¤ PPQ

ppq(WhichX:::P) --->
    prep(Prep), 
    whx_phrase(X,WhichX,Q1,Q), 
    be,
    !,                                    %% !!!
    st0(P) / ( be , prep(Prep),np1_accept(X,Q1,Q)). %% TA-100908


ppq(WhichX:::P) ---> %% to which place goes the bus (Norwagism)
    prep(Prep), 
    whx_phrase(X,WhichX,Q1,Q), 
    lexv(iv,Go,A,B),  
    !,
    adverbial1(Prep,X,Subj,P3) = (prep(Prep),noun_phrase1(X,Q1,Q)), 

    st0(P) /
           (lexv(iv,Go,A,B),  
            adverbial1(Prep,X,Subj,P3)),    
    !,accept.          


ppq(WhichX:::P) --->   %% to which place does the bus go
    prep(Prep),
    whx_phrase(X,WhichX,Q1,Q), 
    do(id), % has  been
    !,accept,   
    adverbial1(Prep,X,Subj,P3) = (prep(Prep), noun_phrase1(X,Q1,Q)),
    !,
    st0(P) / adverbial1(Prep,X,Subj,P3).
          


whichq(WhichX:::P) ---> 
    whx_phrase(X,WhichX,Q2,P), 
    !, %% <--- !!! Reintroduced BUT  hvilke plasser ( seter/steder ???) *
    worldcom(S,Q1,ERS),  
    qverb_phrase(X,S,N, ERS), 
    {negate(N,Q1,Q2)}.

whx_phrase(X,WhichX,VP,P) ---> 
    whichf(X,WhichX),
    of,
    npa(X,VP,P).  % of his daughters


% which buses from nth ...
whx_phrase(X,WhichX,VP,P) ---> %% which thing  you do \=
    whichf(X,WhichX),          %% which thing that you do #
    np1(X,VP,P) \ 
           the(X). 

whichf(X,which(X)) ---> which2. 


%% What is questions %%%%%%%%%%%% 

whatq(WhichX:::P) --->  
    [what],
    whx_phrase(X,WhichX,Q2,P)=([which],w(noun(thing,sin,u,n))),  
    !, %% <--- !!!
    worldcom(S,Q1,ERS),  
    qverb_phrase(X,S,N, ERS), 
    {negate(N,Q1,Q2)}.



whatq(which(X):::Man ako X) --->   %% What is a man
     {\+ value(dialog,1)},  
     whatbe(1),
     a0,
     w(noun(Man,sin,u,n)),  % what is a bus
     endofline,
     !.


whatq(which(Y:thing):::Y isa thing and P) ---> %% hva er tagore -> which(X):   tagore is X
     whatbe(1),
     noun_phrase(X,VP,P),  %% allow telf and roomno of ...  
     endofline,
     !,
     stm(S,id,(event/real/S):P) = %% TA
        (noun_phrase(X,VP,P),  
         w(verb(be,pres,fin)),
         npgap(Y:thing)).


whatq(WhichX:::P) ---> 
    whatbe(1),
    whx_phrase(X,WhichX,Q2,P) \(which2,w(noun(thing,sin,u,n))), 
    worldcom(S,Q1,ERS),
    qverb_phrase(X,S,N,ERS)-be, 
    {negate(N,Q1,Q2)}.


whatq(P) --->  % hva er klokka nå ? 
     whatbe(1),
     the,
     w(noun(Cl,_,_,n)),
     !,
     whichq(P) \ (which2, w(noun(Cl,sin,u,n)), lexv(iv,be1,pres,fin)). 

   
%%%%%%% End What Is %%%%%%%%%%%%%%%%



whatq(P) ---> % what time is it now => when is it now  (OK)
    what,
    w(noun(time,_,_,n)),
    !,
    whenq(P) \ [when].



whatq(P) ---> % what do you do \= which thing that you do #
    what,
    do(id),
    whichq(P) \ (which2,w(noun(thing,sin,u,n)),(do)). 


whatq(which(X):::P) --->  %% Moved front
     whatbe(1),   %%   (ref implicit)
     noun_phrase1(X,true,P),  %% np1, but your name is npa, not np1         
     now0. 

%%%%%%%% End Whatq %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%% WHENQ %%%%%%%%%%%%%%%%%%%%%%%%%%%

whenq(P) --->  %%  when is easter
    when,
    becomesarrives, 
    not_look_ahead([it]), %% what time is it 
   % !,  %% when is bus 5 
    ppq(P) \
    (prep(in),which2,w(noun(time,sin,u,n)),w(verb(go,pres,fin))). 

becomesarrives ---> 
    w(verb(Be,_,fin)), {testmember(Be,[be,come,arrive,go])}.


whenq(Q) --->  %%  ad hoc when is line 2 =* route
    when,            %% when is ==> when does X go 
    w(verb(be,_,fin)),
    noun_phrase1(X,true,P), 
    !,accept,
    whenq(Q) \   ([when], [do], noun_phrase1(X,true,P),w(verb(go,pres,fin))).


whenq(which(Z):::Q) --->  %% when goes bus 5 %% Norwagism 
    when,            %% when is ==> when does X go 
    w(verb(go,_,fin)),
    noun_phrase1(A,B,C),
    !,
    adverbial1(Prep,Z,Subj,P3) = (prep(in),the(Z),w(noun(time,sin,u,n))), 
    question0(Q) - 
           ([do],
             np1(A,B,C),
             w(verb(go,pres,fin)),
             adverbial1(Prep,Z,Subj,P3)).    



whenq(which(Y):::P) --->
    when,
    adverbial1(_,Y,Subj,P3) \  
            (prep(in),the(Y),w(noun(time,sin,u,n))), 
    question0(P)  /  adverbial1(in,Y,Subj,P3). 



whenq(P) ---> % what time is it (now) => what is the time (now)
    what, 
    w(noun(time,_,_,n)),
    be,
    it,
    !,
    whatq(P) \ ([what],be,[the], w(noun(time,sin,u,n))). 



%%%¤ WHEREQ 
 

whereq(WhichY::: Q and Abra) ---> %% hvor er/har  john gått
    where,
    behave,  
    np1_accept(X,A,B),
    w(verb(Go,past,part)),
    !,
    whx_phrase(Y,WhichY,true,Q) -(which2,w(noun(place,sin,u,n))), 
    statement(Abra) -  
       ( np1(X,A,B),   w(verb(Go,pres,fin)), prep1(to), npgap(Y)).


behave ---> w(verb(be,_,fin)),!.
behave ---> w(verb(have,_,fin)),!.

whereq(P) --->  %%  where is you from
    where,
    be,
    % !,  %% where is bus 5 
    ppq(P) \ (prep(in),which2,w(noun(place,_,u,n)),w(verb(be1,pres,fin))). 



whereq(which(Y):::P) --->  %% where did john go (to)
    where,     
    do,
    adverbial1(nil,Y,Subj,P3) =  (the(Y),w(noun(place,_,_,n))),    
    !,
    question0(P) -      
         ([do],adverbial1(in,Y,Subj,P3)), 
    optional(w(prep(_))).
 


wherefromq(which(Y):::P) ---> 
    wherefrom,      %% Make it ADVERBIAL
    adverbial1(F,Y,Subj,P3) =  (prep(from),the(Y),w(noun(place,_,_,n))),    
    !,
    question0(P) -      
        adverbial1(F,Y,Subj,P3).
 


whoq(P) --->   
     relpron(agent), 
     whichq(P) \ (which2,w(noun(agent,_,u,n))).
 
whoseq(P) --->   % whose dog barked ?    
    whose,
    noun(_,Num,u,n, Y, R), %%
    whoq(P) \ (who,has,art,noun(_,Num,u,n, Y, R),that). 

%%%¤  WHYQ   %% TA-110215

whyq(explain:::P) --->
    [why],
    be,
    np0(X,VP,NP),
    statement(P) \
       (noun_phrase(X,VP,NP),
        w(verb(be,pres,fin))).


  


%%%¤  HOWQ 

howq(explain:::P) --->
    how,
    infinitive, %% prep1(to),
    !,
    statement(P) \ [i]. 


% why are we here ? 
howq(explain:::P) ---> %% hvordan er du laget / hvordan er du ?
    how,
    be,
    !,
    statement(P) / w(verb(exist,pres,fin)). 


howq(explain:::P) --->
    how,
    (do),  %% NOT empty !!! %% TA-100916

    negation0(_), %% Rhet Why didn't %% TA-110316
    statement(P).       


% %

howadjq(P) --->  % how far is it from A to B
    [how], 
    howadj(length), %% Only length, not frequency %% hvor often is it a bus 
    be,                %% be/take
    thereit,
    !,     %%  <----    !!!!!
    whatq(P) - ([what],w(verb(be,_,_)),[the],w(noun(length,sin,u,n))). 

howadjq(which(Y):::P) --->  
    how,  
    howadj(Frequency), % often -> frequency
    {testmember(Frequency,[frequency,speed])},
    !,
    adverbial1(_,Y,Subj,P3) - 
            (prep(with),the(Y),w(noun(Frequency,_,_,n))), 

    question0(P)  -  adverbial1(with,Y,Subj,P3).



howadjq(P) ---> 
    how,
    howadj(SIZE), % great -> size
    be,
    !,                    %% <--- !!!
    whichq(P) \ (which2,w(noun(SIZE,_,_,n)),w(verb(evah,pres,fin))). 



howadjq(howmany(X):::P) --->
    how,
    many,
    whichq(which(X):::P) - which .


howmuchq(P) ---> 
    how,much,of,
    whichq(P) \ (which2,of). 

howmuchq(P) --->
    how,
    howmuch(Noun), % how much time does
    whichq(P) \(which2,w(noun(Noun,sin,u,n))). 


howadj(age)        ---> wx(adj2(nil,old)). 
howadj(delay)     --->  optional(much),wx(adj2(nil,delayed)).
howadj(distance)   ---> [long].
howadj(duration)   ---> [many],w(noun(minute,plu,_,n)).
howadj(duration)   ---> [long]. 
howadj(duration)   ---> [long],w(noun(time,_,u,n)),!,accept. 
howadj(duration)   ---> much,w(noun(time,_,u,n)),!,accept. 

howadj(frequency)  ---> [often]. 
howadj(frequency)  ---> [many], w(noun(time_count,_,_,n)),inperiod0,!,accept.  

howadj(intelligence) ---> wx(adj2(nil,intelligent)).
howadj(intelligence) ---> wx(adj2(nil,stupid)).  %% Rhetorical
howadj(intelligence) ---> great,w(noun(intelligence,sin,_,n)). 

howadj(length)    ---> [far]. 
howadj(length)    ---> w(prep(near)).
howadj(length)    ---> wx(adj2(nil,long)). 
howadj(length)    ---> many,w(noun(Mile,_,u,n)), %%  meter sin/plu
   {member(Mile,[mil,mile,kilometer,meter])}.

howadj(price)     ---> wx(adj2(nil,expensive)).
howadj(size)      ---> great.             %% big 

howadj(speed)     ---> [fort].         %%           ??? adverb
howadj(speed)     --->  wx(adj2(nil,fast)).  %%  ??? adjective

howadj(weight)     ---> wx(adj2(nil,heavy)). 



% % % 

howmuch(duration)  ---> much, w(noun(time,sin,u,n)),!,accept. 
howmuch(duration)  ---> wx(adj2(nil,long)), w(noun(time,sin,u,n)),!,accept. 
howmuch(duration)  ---> wx(adj2(nil,long)). %% maybe also distance 
howmuch(distance)  ---> [far].  
howmuch(thing)     ---> much.


inperiod0 ---> w(prep(in)),a0,w(noun(hour,sin,_,_)),!. 
inperiod0 ---> w(prep(in)),a0,w(noun(day,sin,_,_)),!. %%
inperiod0 ---> []. 

% % % % % % % % % % % % % % % % % % % % % % % % % % % %



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  V E R B  - P H R A S E    S E C T I O N
%
  

% COM is an inherited attribute that shall be under 
% the scope of exists(S)::



verb_phrase(X,S,N,ComP12) --->                %% Complement Combination
    verb_phrase1(X,S,N,ComP1),
    verb_phrases0(X,S,ComP1,  ComP12).     

verb_phrases0(X,S,Com:P1,Com:(P1 and P3)) --->  %% Complement Combination
    andor(and), 
    verb_phrase1(X,S,id, ComP2), 
    verb_phrases0(X,S,ComP2, Com:P3).

verb_phrases0(_,_,ComP1,ComP1) ---> [].


verb_phrase1(X,S,id,ComP2) --->    % local negation of that_verb
    negation0(_),                   % indifferent 
    clausal_phrase(X,S,ComP2).     % makes it different from do_phrase
                            
verb_phrase1(X,S,N,ComP2) --->     % be1
    be(N),
    lexv(Iv,Sing,pres,part),       % going  / passing
    { Iv==iv;Iv == tv},  
    !,
    do_phrase(X,S,id,ComP2) \
        w(verb(Sing,pres,fin)).

verb_phrase1(X,S,N,ComP2) --->       %  (be at NTH)
    amble(X,N),                      %% be(N),            
    not_look_ahead([it]),
    be_complements(X,S,ComP2).   

%% Moved back:   Mary is big woman
verb_phrase1(X,S,N,ComP2) --->       % be1  
    amble(X,N),                      % am only if X is a self
    do_phrase(X,S,id,ComP2) \   
        be1.                         % artificial

verb_phrase1(X,S,M,ComP2) --->   
    do0(X,M,N),      % to check AM  %% M semantic, N syntactic Negation
    do_phrase(X,S,N,ComP2), 
    !,accept.  %%% <---  !!!               %% HAZARDOUS BUT ESSENTIAL 

amble(_:T,N) ---> [m],!,{type(self,T)},negation0(N). 
amble(_:T,N) ---> [am],!,{type(self,T)},negation0(N).
amble(_,N) ---> be(N).



do_phrase(X,S,id,ComP2) ---> %% Tore used a knife for killing John
    use,
    noun_phrase1(Y,P,Q), 
    prep1(for),
    !,
    w(verb(Kill,pres,part)), %% 
    verb_phrase(X,S,id,ComP2)
       -  ( w(verb(Kill,pres,fin)), %% 
          prep(with),
          noun_phrase(Y,P,Q)).

do_phrase(X,S,id,ComP2) --->
    use,
    noun_phrase(Y,P,Q),
    in_order_to,
    verb_phrase(X,S,id,ComP2)
       -  (prep(with),
          noun_phrase(Y,P,Q)).

do_phrase(X,S,N, Com3P3 ) --->    % Complement Combination % swapped Com3/Com1

%%%%%%%%% TA-100908    adverbx0,    %%  troglitazone -markedly- reduced the response .

%%    negation(_), %% Rhetoric %% Hazard ? %% why do you not answer that

    vp_kernel(V,X,S,N,  ComP1 ),    
    verb_modifiers0(V,X,S,ComP1, Com3P3 ).


%%%

vp_kernel(Give,X,S,id,  Com3:(P1 and Q1)) --->
%%     {value(textflag,true)},    %% not nec for buses ?
    lexv(dtv,Give,_Tense,fin), 
    noun_phrase1(Y, E1,P1),     
    noun_phrase1(Z,E1,Q1),     
    {dtv_template(Give,X, Y, Z, S,Code)},
    event00(S,Code,Com3,E1).         



vp_kernel(have,X,_S,N,  _:P )  ---> %% NB 
    lexv(tv,have,_,fin),  
    negation0(N), 
    np1(Y,P2,P),  %%  NOT name  bus has 9
    {has_template(X,Y,P2)},
    !,accept.



vp_kernel(V,X,S,N,  Com3:P1 ) --->
    lexv(tv,V,_Tense,fin), 
    reflexiv0(V), 
    negation0(N), 
    event00(S,P,Com3,E1),         
    noun_phrase2(X,Y1,E1,P1),     
    {tv_template(V,X,Y1,S,P)}.

vp_kernel(V,X,S,N,  Com3:E1) --->
    intrans_verb(V,X,S,P,_Tense,fin), 
    reflexiv0(V),  %% + there/it  what time is it 
    negation0(N),
    event00(S,P,Com3,E1). 

vp_kernel(have,X,S,N,Com:E1) --->  
    has,
    negation0(N),  
    noun_phrase2(X,Y,P1,P),
    {has_template(X,Y,P1)},
    event00(S,P,Com,E1). 

vp_kernel(evah,X,S,N,  Com3:P1 ) ---> 
    lexv(tv,evah,_,fin),  
    negation0(N), 
    noun_phrase2(X,Y,P2,P),
    {has_template(Y,X,P2)},         % swap
    event00(S,P,Com3,P1).

vp_kernel(V,X,S,N,Com:E1) ---> 
    negation0(N), 
    intrans_verb(V,X,S,P,_,fin),    %   (Greedy Heuristics)
    there0,    
    event00(S,P,Com,E1). 



% event(S,P,Q,exists(S)::P and Q).  %% fernando.pl

event00(S,P,Q,exists(S:Event)::(P and Q)) --->  
    {type(event,Event)}. 

%% Clausal Complements %%%%%%%  

%%%¤ CLAUSAL_PHRASE  

clausal_phrase(X,S,Com1:KA) ---> 
    {value(textflag,true)},
    rep_vp(W,TW,X,S,Com2,P2,NewS),   %% told
    {testmember(W,[tell,ask,propose])},
    noun_phrase(AA,BB,CC),           %% John
    infinitive,                      %% to
    !,
    clausal_phrase(X,S,Com1:KA) -   
        ( rep_vp(W,TW,X,S,Com2,P2,NewS), %% told(!)
          [that],                        %% that
          noun_phrase(AA,BB,CC)).                %% John

clausal_phrase(X,S,Com1:KA) ---> 
    rep_vp(W,TW,X,S,Com2,P2,NewS),   %% vet
    rep_complements0(W,X,S,Com2:P2, Com1:P4),     %% swapped Com1,Com2 000215
    thatto0(W,TW,X),                              % to ===> npgap(X)
    event00(NewS,P4,P3,KA), 
    statemen1(NewS,P3). 


thatto0(_W,that,X) ---> infinitive,[] - npgap(X). %%   infinitive first
thatto0(W,TW,_)   ---> that(TW),
    {W \== start}.        %% starte å OK starte at NO 

thatto0(ask,that,_) ---> []. 
thatto0(believe,that,_) ---> []. 
thatto0(let,that,_) ---> []. 

thatto0(W,that,_) ---> [], 
                       {\+ member(W,[cause,make])}. 

%%%¤ REP_VP

rep_vp(let,TW,X,S,Com,KA,NewS) ---> %% I let you go ===> I "let" that you go
     w(verb(let,_,fin)),
     !,
     noun_phrase1(Alfa,Beta,Gamma),
     {rv_template(id,let,TW,X,S,P,NewS)}, 
     event00(S,P,Com,KA),
     [] - noun_phrase(Alfa,Beta,Gamma).

rep_vp(Know,TW,X,S,Com,KA,NewS) ---> 
     do(N),
     lexv(rv,Know,_,_),
     ittobetrue0, 
     {rv_template(N,Know,TW,X,S,P,NewS)}, 
     event00(S,P,Com,KA). 

% % % % % 

rep_complements0(_Say,_X,_S,_Com1Subj,_Com2P2) ---> 
    w(prep(about)), %% not RP
    !,
    reject.

rep_complements0(Say,X,S,Com1Subj,Com2P2) ---> %% say to mary that john died
    { testmember(Say,[say,tell])},             %%  ( not will/shall)
    prep1(to), 
    verb_modifiers(Say,X,S,Com1Subj,Com2P2) \ prep(to).


rep_complements0(Say,X,S,Com1Subj,Com2P2) ---> %% tell mary that john died
    { testmember(Say,[tell,convince])},   
    verb_modifiers(Say,X,S,Com1Subj,Com2P2) \ prep(to).



rep_complements0(Say,X,S, ComSubj,Com3P3) --->  
    verb_modifiers0(Say,X,S, ComSubj, Com3P3).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

be_complements(A,B,C:D) --->  
    w(verb(be,pres,part)),     % being
    be_complements(A,B,C:D).     

be_complements(X,S,Com:P3) ---> 
    be_complement(X,S,Com:P1),          % er solgt
    be_complements2(X,S,Com,P1,P3).     % i oslo ?????
  

be_complements2(X,S,Com,P1,P1 and P3) ---> 
   and0,                           %% 
   be_compl(X,S,Com,P2),           %%  (not noun)
   be_complements2(X,S,Com,P2,P3).

be_complements2(_,_,_,P,P) ---> reductant0. 

be_compl(Y,S,Com,P) ---> 
    passive(Y,S,Com,P).

be_compl(X,S,Com,P2) ---> 
    the0, 
    ap(A,X,S,Com2,P1),
    verb_modifiers0(adj/nil/A,X,S,Com2:P1,Com:P2).   %% identical to Adj Compls NEW
                                                  
be_complement(X,B,C:D) ---> 
    be_compl(X,B,C,D).      %% in reduced_rel


be_complement(A,B,C:D) ---> %% 
    be_noun(A,B,C,D).       %% not in reduced_rel (lived a miner fortyniner *)


be_compl(X,S,Com,KA) ---> 
    comparisons(X,S,P2),
    event00(S,P2,Com,KA).

be_compl(X,S,Com,P2) ---> %%  (moved up)
    sure,
    do_phrase(X,S,id,Com:P2) \  w(verb(know,_,fin)). 



be_noun(X,S,Com,exists(S:event)::P2) --->  
    noun_phrase(Y,Com2,P1),
    {bealign(X,Y,S,P1,P11)}, 
    !,
    verb_modifiers0(exist ,X,S,Com2:P11,Com:P2). 


% .. that is big woman NOT postadj
ap(A,X,S,COM,exists(S:event)::P and COM) ---> 
     the0,                               %%  the nearest to Oslo
     adverb0(_Medium),  
     postadj1(A,X,S,P). 


% PASSIVE 


passive(Z,S,Com, P) --->           %%  (was)
    {value(textflag,true)},    
    lexv(rv,V,past,part),          %%  told
    whodidit(_,_,X,B,C),           %%  by someone   
    infinitive,                    %%  to
    !,
    stm(S,id,Com:P) \  %% TA
        (noun_phrase(X,B,C),  lexv(rv,V,past,fin)  ,npgap(Z),infinitive).


passive(Z,S,Com, Pli and Q) --->   %%  was 
    {value(textflag,true)},    
    lexv(dtv,V,past,part),         %%  given
    np1(Y,true,Q),                 %%  a kiss
    whodidit(_,_,X,B,C),   
    !,
    stm(S,id,Com:Pli) \ %% TA
       (noun_phrase(X,B,C),lexv(dtv,V,past,fin),npgap(Z),npgap(Y)).


passive(Y,S,Com, Pli) ---> 
    adverbx0,              %% a book was earlier studied. <--- %% EXPERIMENT
    lexv(tv,V,past,part),
    adverbx0,              %%  Changed to exclude prep 
    whodidit(_,_,X,B,C),   
    !,
    stm(S,id,Com:Pli) -  %% TA
      (noun_phrase(X,B,C),
       w(verb(V,pres,fin)), %% lexv(tv,V,pres,fin), % e.g. use -->
       npgap(Y)).


whodidit(_V,_Y,X,B,C)--->     %% tore ws killed
    by,
    !,accept,
    noun_phrase(X,B,C).   %% by john and mary


whodidit(_V,_Y,X,B,C)--->       %%
%    begin, %% tore killed john = tore , killed by agent john ###
       np1(X,B,C) = (w(noun(agent,sin,u,n))),
%    end,
    !,accept.



%% END PASSIVE


% clause after " noun that ... "

xverb_phrase(X,S,N,Com,P2) --->        
    verb_phrase(X,S,N,Com:P2).         

xverb_phrase(Y,S,N,Com,P2) --->
    noun_phrase(X,P,P1), 
    verb_phrase(X,S,N,Com:P2)
         -  noun_phrase(Y,P,P1).  

xverb_phrase(Y,S,N,Com,P2) --->        
    noun_phrase(X,P,P1),               
    be,                                 
    verb_phrase(X,S,N,Com:P2)
         -  (be , noun_phrase(Y,P,P1)).  


%%% QVERB-PHRASE
% clause after " which noun ... "


qverb_phrase(X,S,id,Com:P) --->  % (which crown) does it cost to
    (do), 
    it,
    pvimodal(Cost,Money),  
    {vartypeid(X,thing);constrain(X,Money)},    %% how much = which thing
    to,
    statem(S,Com,P) \        %% 
        ([it],
         w(verb(Cost,pres,fin)),
         npgap(X),
         [to]). %% \+ w(prep(to))).
         


qverb_phrase(Y,S,N,Com:Q) ---> % which question have you answered
    has,    
    noun_phrase1(X,P,P1),
    negation0(N),
    w(verb(Answer,past,part)),
    !,
    statem(S,Com,Q) \    
        (noun_phrase1(X,P,P1), w(verb(Answer,past,fin)), npgap(Y)).


qverb_phrase(Y,S,id,Com:P) --->  %% am I able to 
    be,
    noun_phrase1(X,Q,P),        
    [able],
    [to],
    !,
    statem(S,Com,P) -    
        (noun_phrase(X,Q,P), [can], npgap(Y)).



qverb_phrase(Y,S,id,Com:P) --->  %% (what) are you doing (now)
    be,
    np1(X,Q,P),
    w(verb(Do1,pres,part)),
    !,
    statem(S,Com,P) \ %% not -,  adverb causes adverbx0... 
        (np1(X,Q,P), w(verb(Do1,pres,fin)), npgap(Y)).




qverb_phrase(Y,S,N,ComP2) ---> %% which thing does Tagore do 
    (do),      
    noun_phrase(X,P,P1),          
    w(verb(Do1,inf,fin)),
    verb_phrase(X,S,N,ComP2) \ 
         ( w(verb(Do1,inf,fin)),noun_phrase1(Y,P,P1)).  %% noun_phrase 

qverb_phrase(X,S,N,Com:P2) --->  %% is it  
    be,
    thereit,  
    !,accept, %% ?
    verb_phrase1(X,S,N,Com:P2)  \  
        w(verb(exist,pres,fin)).  %% exist does not need a complement

qverb_phrase(X,S,N,ComP2) --->  
    verb_phrase(X,S,N,ComP2).    

qverb_phrase(Y,S,N,ComP2) --->  
    (do),                                 
    noun_phrase(X,P,P1),          
    hasto0, 
    verb_phrase(X,S,N,ComP2)  - 
         ( [do] , noun_phrase1(Y,P,P1)).  %% noun_phrase 

qverb_phrase(Y,S,N,ComP2) ---> 
    be,
    noun_phrase1(X,P,P1),
    verb_phrase(X,S,N,ComP2)
         -  (be , noun_phrase(Y,P,P1)).  



qverb_phrase(Y,S,N,ComP2) ---> % which colour has the bus
    has,
    noun_phrase1(X,P,P1),
    verb_phrase(X,S,N,ComP2)
        \ ( has, noun_phrase(Y,P,P1)). 

%% If several verb_modifiers, they are nested first innermost,
%%   and the state is existantiated innermost


verb_modifiers0(V,X,S,Com1P1,Com12P3) ---> % 1-n for be1, otherwise 0-n
    verb_modifiers(V,X,S,Com1P1,Com12P3). 

verb_modifiers0(V,_,_,CP,CP) ---> 
    {\+ V=be1}.

%%%¤  VERB_MODIFIERS

verb_modifiers(V,X,S,Com1P1,Com12P3) --->
    verb_modifier(V,X,S,Com1P1,Com12P2),
    verb_modifiers10(V,X,S,Com12P2,Com12P3).  % last dominates first


verb_modifiers10(V,X,S,Com1P1,Com12P3) ---> %% 0-n 
    and2, %% but.     Hazard:   I live in hell and tomorrow i die
    verb_modifiers(V,X,S,Com1P1,Com12P3). %% 1-n 

verb_modifiers10(V,X,S,Com1P1,Com12P3) ---> %% 0-n 
    verb_modifiers(V,X,S,Com1P1,Com12P3).   %% 1-n (not s0 in case be1)
                                          
verb_modifiers10(_,_,_,CP,CP) ---> []. % 0


%%  Try Last  %%  I leave now  and tonight I will.. Experiment

verb_modifiers10(V,X,S,Com1P1,Com12P3) ---> %% 0-n 
    and2,                                     %% but
    verb_modifiers(V,X,S,Com1P1,Com12P3).   %% 1-n


verb_modifier3(Sing,X,Y,SC, (exists(Y):: SC and P))  ---> % Y=T1:_
        st0(P) 
         -  (npgap(X),
           lexv(iv,Sing,pres,fin),
           prep(in) , the(Y) , w(noun(time,sin,u,n))). 


verb_modifier4(Take,X,Y,SC, (exists(Y):: SC and P))  --->
        adverbial1(In,Y,Subj,P3) =
            (prep(in),the(Y),w(noun(time,sin,u,n))),
        !,
        st0(P) 
         -  (npgap(X),
           lexv(tv,Take,pres,fin),
           adverbial1(In,Y,Subj,P3)). % NOT noun_modifier !

% NB %% there  = to this place 
verb_modifier(V,X,S,(Com1 and (  findexternal(Y:place)::(Y isa place and STO))):Subj,  Com1:Subj ) ---> 
    {value(dialog,1)},
    thisplace(To),   
    {verb_compl(V,To,X,Y:place,S,STO)}.


 
%% verb_modifier(_,_,_,CS,CS) ---> thereit. %%  particle (here)


% I take a bus in order to reach NTH

verb_modifier(V,X,S, (Com1 and Compl):Subj,Com1:KA) ---> % #swapped
    {\+ member(V,[want])},   %% i want (in order) TO 
    in_order_to(V,N), 
    subordinatex(nil,coevent,X,T1,Subord), 
    {negate(N,Subord,Subord1)},
    determiner00(T1,Subj,Subord1,KA), 
    {verb_compl(V,in_order_to,X,T1,S,Compl)}. 


verb_modifier(Die,X,S,(Com1 and Compl):Subj,Com1:NP3) --->  %% tv before iv
   while(Neg), 
   lexv(tv,Taking,pres,part),                    %% Taking
   verb_modifier4(Taking,X,Y,Subj,P3),
   {negate(Neg,P3,NP3)},
   {verb_compl(Die,during,X,Y,S,Compl)}.


verb_modifier(Die,X,S,(Com1 and Compl):Subj,Com1:NP3) ---> 
   while(Neg), 
   lexv(iv,Sing,pres,part),                    %% singing
   verb_modifier3(Sing,X,Y,Subj,P3),
   {negate(Neg,P3,NP3)},
   {verb_compl(Die,during,X,Y,S,Compl)}.



verb_modifier(V,X,S,(Com1 and Compl):Subj,Com1:P3) --->    % this afternoon #swap
   this, 
   adverbial(Prep,Y,Subj,P3)-(prep(in),this), 
   {verb_compl(V,Prep,X,Y,S,Compl)}.

verb_modifier(V,X,S,(Com1 and Compl):Subj,Com1:P3) ---> 
   {\+ member(V,[ask,tell,propose,know,know1])},  
   adverbial3(Prep,Y,Subj,P3),
   {verb_compl(V,Prep,X,Y,S,Compl)}.

verb_modifier(V,X,S,(Compl and Com1):Subj,Com1:P3) ---> 
   adverbial1(Prep,Y,Subj,P3),                               %% lexical order
   {verb_compl(V,Prep,X,Y,S,Compl)}.

verb_modifier(Live,X,S,(Com1 and Compl):Subj,Com1:Subj) ---> 
    adverb(Today,DayClass,_), 
    {adv_compl(Live,Today,X,DayClass,S,Compl)}.

                          %% keep order
verb_modifier(Tell,X,S,(Compl and Com1):Subj,Com1:P3) --->  %% Moved last (Greed)
   nil_compl(Tell), 
   adjunct1(nil,Y,Subj,P3),     %% depart from P before depart P
   {verb_compl(Tell,nil,X,Y,S,Compl)},
   !.  %%% <---!!!  Hazardous, but essential %% postponed



verb_modifier(Tell,X,S, ( Compl and Com1):Subj,Com1:P3    ) --->  
   dir_compl(Tell),  
   adjunct1(dir,Y,Subj,P3), 
   {verb_compl(Tell,dir,X,Y,S,Compl)}, 
   !,accept.  %%% <---!!!  Hazardous, but essential





verb_modifier1(Prep,Y,SC,P3) --->
    adjunct1(Prep,Y,SC,P3).   % not used as a noun_modifier

verb_modifier1(Prep,TX,SC,FI) ---> 
    verb_modifier2(Prep,TX,SC,FI).       %% " I go before 1200 am "




%% dir_compl     Transitive verb ala dir complement

dir_compl(Tell) ---> 
    {v_compl(Tell,_,dir,_)}, 
    !,accept. 






% check possible empty (no prep) complement

nil_compl(_) ---> 
    prep1(_),
    !,
    reject.

nil_compl(_) ---> 
    look_ahead(w(noun(hour,_,_,_))), %% hours NEVER complement
    !, 
    reject.

nil_compl(be/Present) --->
    {a_compl(Present,_,nil,_)},   %% filter %% semantic 
     !,accept.   
nil_compl(Tell) --->
    {v_compl(Tell,_,nil,_)},  
    !,accept. 


verb_modifier2(Prep,T1,SC, 
       (exists(T1):: SC and Subord))  ---> 
     subordinate(Prep,T1,Subord).

%%   adverbial   verb_modifiers with unknown verb

adverbial(Prep,TX,SC,FI) ---> 
    adverbial3(Prep,TX,SC,FI).

adverbial(Prep,Y,SC,P3) --->
    adverbial1(Prep,Y,SC,P3).

adverbial0(Prep,Y,SC,P3) ---> %% Once upon a time 
    adverbial1(Prep,Y,SC,P3).

adverbial0(nil,Y,SC,P3) ---> 
    adjunct1(nil,Y,SC,P3).



adverbial1(Prep,Y,SC,P3) ---> % JUST TO ASSURE complement1 is
    adjunct1(Prep,Y,SC,P3).   % not used as a noun_modifier


adverbial3(Prep,T1,SC,KA) ---> 
    subordinate(Prep,T1,Subord),
    determiner00(T1,SC,Subord,KA).


subordinate(Prep,T,P) --->
    subjunction(Prep,Category,In),  
    not_look_ahead_date(Prep), %% TA-100920
    subord_clause(In,Category,T,P). 

not_look_ahead_date(until) ---> %% Ad hoc (until Date not subord)
    date(_,_),                  %% TA-100920
    !,reject. 
not_look_ahead_date(_) ---> [].

not_look_ahead_np ---> [bye]. %% \+ name byen  %% TA-110428
not_look_ahead_np ---> look_ahead_np,!,reject. %% TA-110119

not_look_ahead_np ---> [].

look_ahead_np ---> [bye],!,reject. %% \+ name bye n %% TA-110428
look_ahead_np ---> look_ahead(w(noun(_,_,_,_))).
look_ahead_np ---> look_ahead(w(name(_,_,_))).
look_ahead_np ---> look_ahead(w(nb(_,_))).
look_ahead_np ---> look_ahead_lit([a,an,the,that,this,they]). %%etc

look_ahead_lit(List) ---> [E],{testmember(E,List)}.



%% in order to

subordinatex(Prep,Reason,X,T:_,P and srel/Prep/Reason/T/S) --->  
    {value(textflag,true)},  
    verb_phrase(X,S,N,ComP2),
    !,
    st0(P) 
         -  (npgap(X), verb_phrase(X,S,N,ComP2)).



subordinatex(Prep,Reason,X,T,P) --->  
%    begin, 
        adverbial1(Prep,Y,SC,P3)=
            (w(prep(Prep)),the(T),w(noun(Reason,_,_,n))), 
 %   end,
    !,
    st0(P) 
         -  (npgap(X),adverbial1(Prep,Y,SC,P3)),
    !,accept.  %% <-- Necessary  %% it is possible to travel on the day after tomorrow .



subord_clause(In,Category,T,P) ---> 
%    begin,

    adverbial1(Prep,Y,SC,P3) = (prep(In) , the(T) , w(noun(Category,_,_,n))),
%    end, 
    !, 
    st0(P) 
         -  adverbial1(Prep,Y,SC,P3).



reductant0 ---> []. %% redundant adverb 



adverb0(X)---> 
    adverb1(X),
    !,accept. %%% FOR GODS SAKE  
adverb0(_) ---> [].

adverb(there,place,post) ---> 
    [there],
    !,
    not_look_ahead(w(verb(_,_,_))).

adverb(Today,Day,P) ---> 
    particle(Today),        
    {particle(Today,Day,P)}.


adverbx0 ---> % what are you  doing -now- %% caveat 
      properadverb(X,Y,Z),
      !,
      [] - adverb(X,Y,Z).

adverbx0 ---> [].

properadverb(X,Y,Z) ---> 
    adverb(X,Y,Z),
    {\+ preposition(X)}. %% ad hoc %% RS-140921 From dict_e.pl
%   {\+ dict_e:preposition(X)}. %% ad hoc %% TA-111111



%%¤ ADJUNCT1 (Nil,Y,SC,P3) 



adjunct1(Nil,Y,SC,P3) ---> %%  ( Bus goes     09.12 => clock ) at -> nil
    {Nil == nil},
    dendagen0(_),     %% date more probable than clock 
    date(X,P),       %% Buss går lørdag den 09.12 => Date 
    np1(Y,SC,P3) - date(X,P).     



adjunct1(Nil,Y,SC,P3) ---> 
    {Nil == nil},
    time_phrase(Y,SC,P3), %% bus goes 5 
    !,accept. 

%% The bus goes a sunday %% Expensive ??? 

adjunct1(Nil,Y,SC,P3) ---> 
   {Nil == nil},
   np1(Y,SC,P3). %% noun_phrase1 



adjunct1(on,Y,SC,P3) ---> 
    on0,
    the0, 
    dendagen0(_),    %%  day(_), bus goes on friday(wrong) 24th december 
    plausibledate1(X,P),  %% TA-110516    
    !, 
    np1(Y,SC,P3) \ date(X,P).     


adjunct1(in,Y,SC,P3) ---> %% in 2009 = year 
    prep(in),     
    w(nb(YYYY,num)), 
       {1000 =< YYYY, YYYY =< 9999},
        not_look_ahead(w(noun(time,_,_,_))), %% tiden
     !,
     np1(Y,SC,P3) = (w(noun(year,sin,u,n)), w(nb(YYYY,num))).




adjunct1(Prep,Y,SC,P3) ---> %% for better syntax tree
    pp(Prep,Y,SC,P3).


adjunct1(Dir,Y,SC,P3) ---> 
    {Dir==dir},                %%  same as transitive object
    noun_phrase1(Y,SC,P3).   


%%%¤  PP (Prep,Y,SC,P3)

pp(Prep,Y,SC,P3) ---> 
    prep(Prep),
    noun_phrasenw(Y,SC,P3). %% not starting with what


%% %% %% 


noun_phrasenw(_Y,_SC,_P3)---> relwhat(_),!,reject. 
noun_phrasenw(Y,SC,P3)---> 
    noun_phrase(Y,SC,P3). 
                            
streetno ---> [one],!,reject. % one is not a street number 
streetno ---> a,!,reject. %% pure number, not article, not first etc.
streetno ---> w(nb(_,num)), colon, !,reject. % clock ?
streetno ---> num(N), {N < 500}.                              %% 

%%  what does  he see \= which thing that he sees * 


rel_clauses(X,Com,Com and  P) ---> %% Special treatment
    pronoun(I),     
    !,
    st0(P) / (pronoun(I),npgap(X)).  %% not \  


rel_clauses(X,P,Q) ---> %% that sings and that dances 
    rel_clause(X,P,P1),
    rel_clauses0(X,P1,Q).

rel_clauses0(X,P,Q) --->
    and1,
    rel_clauses(X,P,Q).

rel_clauses0(_,P,P) ---> [].


rel_clause(X,Com,Com and  P) ---> 
    rel(X),
                  %% NOT movement !
         st0(P) - npgap(X). 
     

rel_clause(Y,P1,P) --->   %% Internal OF without movement bingoing
    ofx,
        noun_phrase(X,P1 and P2,P),     
        {has_template(X,Y,P2)}. 
 

rel_clause(X,P1,P1 and P2) ---> 
    having,                     
     
       st0(P2) \ (npgap(X),has). 
     

%%    a way  to die ==> a way in which someone  die

rel_clause(X,P1,P1 and P2) --->  
    {value(textflag,true)},  %% a bus from vestlia to reach SENTRUM !
    infinitive,   %% to,
    w(verb(Die,pres,fin)),
    verb_modifier1(Prep,Y,SC,P3) \ 
          (prep(in),npgap(X)),
    stn(real,P2) -   
           (someone,w(verb(Die,pres,fin)),adverbial1(Prep,Y,SC,P3)).


rel_clause(X,P1,P1 and P2) --->  
    {constrain(X,way)},

    doing(Die),

    verb_modifier1(Prep,Y,SC,P3)-(prep(in),npgap(X)),

    stn(real,P2) -  
           (someone,w(verb(Die,pres,fin)),adverbial1(Prep,Y,SC,P3)).


rel_clause(X,P1, P1 and P2) ---> 
    whose_noun(Z,R),                     
    worldcom(S,P2,ERS),   
    xverb_phrase(X,S,id,true,ERS) \ 
        (has,art,noun(_,_,_,n, Z, R),that).  



rel_clause(X,P1,P2) --->   
    lexv(iv,Sing,pres,part),  %% What was the problem?
    worldcom(S,P1,ERS:P2), 
    verb_phrase(X,S,id,(ERS and P1):P2)
       \ lexv(iv,Sing,pres,fin). 


rel_clause(X,P1,P2) --->
    lexv(tv,Border,pres,part), 
    worldcom(S,P1,ERS:P2),  
    verb_phrase(X,S,id,(ERS and P1):P2)
       \ lexv(tv,Border,pres,fin). 


rel_clause(Y,P1,P1 and P2) ---> 
    where,
    %  {constrain(Y,place)}
      
        statement(P2)
         -  (prep(in) , the(Y) , w(noun(place,_,_,n))). 
     

rel_clause(Y,P1,P1 and P2) ---> 
    when,
    {constrain(Y,time)},
      
        statement(P2)
         -  (prep(in) , the(Y) , w(noun(time,sin,u,n))). 


                                
rel_clause(Y:T,P1,P1 and P2) ---> %% a method for killing john exists
    {value(textflag,true)},
    prep1(for),
    w(verb(Kill,pres,part)),      %% 
    { tv_templ(Kill,_,_)},

    % Rough test  Y can be a complement object of kill

    { stanprep(Prep,T)}, %% in way/in time/with method
    np1(AA,BB,CC),

    !,
    statement(P2)
         -  ([a],w(noun(agent,sin,u,n)), w(verb(Kill,pres,fin)),
            np1(AA,BB,CC),prep1(Prep),npgap(Y:T)).
                                
                                
rel_clause(Y:T,P1,P1 and P2) ---> %% (there is a) way to kiss mary
    {value(textflag,true)},
    infinitive, 
    w(verb(Kiss,_Inf,fin)),     %% 
    { tv_templ(Kiss,_,_)},

    % Rough test  Y can be a complement object of kiss

    { stanprep(Prep,T)}, %% in way/in time/with method
    np1(AA,BB,CC),

    !,
    statement(P2)
         -  ([a],w(noun(agent,sin,u,n)), w(verb(Kiss,pres,fin)),
            np1(AA,BB,CC),prep1(Prep),npgap(Y:T)).

                                
rel_clause(Y,P1,P1 and P2) ---> %% (mary is a) woman to kiss
    {value(textflag,true)},
    infinitive, 
    w(verb(Kiss,_Inf,fin)),
    % Rough test  Y can be object of kiss
    { tv_templ(kiss,_,Woman)},
    {constrain(Y,Woman)},
    !,
    statement(P2)
         -  ([a],w(noun(agent,sin,u,n)), w(verb(Kiss,pres,fin)),npgap(Y)).

       


doing(Die) --->    % to die
    to,
    w(verb(Die,pres,fin)).

doing(Die) --->     % in dying 
    prep1(in),
    w(verb(Die,pres,part)).

doing(Die) --->   % of dying 
    prep1(of),
    w(verb(Die,pres,part)).


% reduced rel   A man (that was) killed

reduced_rel(_,_,_) ---> w(verb(_,pres,fin)),!,reject.
reduced_rel(_,_,_) ---> w(verb(_,past,fin)),!,reject.
reduced_rel(_,_,_) ---> w(verb(be,_,_)),!,reject. 

reduced_rel(X,P1,P1P2) --->
    w(verb(Sing,pres,part)),
    !,
    rel_clause(X,P1,P1P2) \   
        (that, w(verb(Sing,pres,fin))).



whose_noun(Z,R) --->
    whose,
    noun(_,_,u,n, Z, R).  

% whose_noun(Z,R) --->     %% PIED PIPING
%    prep(in),
%    the0,
%    noun(_,_,u,n, Z, R),       
%    of,                   %% the concepts
%    rel(Z),               %% in (the) terms of which
%    the0.                 %% the theory was formulated

relwhat(X) ---> 
    [what],
    {constrain(X,thing)}.

relwhat(X) --->
    [who],
    {constrain(X,agent)}.



rel(X) ---> 
    relpron(P),
    {constrain(X,P)}.

%% METAGRAMMAR SECTION

%% Is this hazardous ???



begin ---> []. %% outdated
end ---> [].


accept  --->  [].     %% for emphasizing !, and for spy
reject  --->  {fail}. %%  METAPROGRAMMING 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

comparisons(X,S,P) ---> 
    comparison(X,S,P1),
    comparisons0(X,S,P1,P).

comparisons0(X,S,P1,P1 and P3) --->
    and1,
    comparison(X,S,P2),
    comparisons0(X,S,P2,P3).

comparisons0(_,_,P,P) ---> [].


comparison(X,_,P2) --->  %%  Direct comparison ( 23 > 20 )
    comparator1(REL),    
    noun_phrase1(Y,P1,P2),
    {compare(REL,number,X,Y,P1)}. %% Changed Format

comparison(X,_,P2) --->  %%  Indirect comparison ( John is older than Mary) 
    comparator2(REL,Age),    
    noun_phrase1(Y,P1,P2),
    {compare(REL,Age,X,Y,P1)}. %% %% Changed Format


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  N O U N  - P H R A S E    S E C T I O N
%

% The object is or is not identical to the subject

noun_phrase2(X,X,VP,P) --->
    resiproc(Him),                        % Himself
    noun_phrase1(X,VP,P) \ pronoun(Him).

noun_phrase2(X,Y,P,findalt(diff,X,Y)::(Q and P)) ---> 
    another,
    noun(_,sin,u,n, Y, Q). 

noun_phrase2(_X,Y,P1,P2) --->   %% Y may or may not
    noun_phrase(Y,P1,P2).       %% be qual to X    

%%%¤ NOUN_PHRASE 
                              
noun_phrase(X,P1,P) --->        
    noun_phrases(X,P1,P).


% % % % % % % % % % % % % 


noun_phrases(Z,VP,P2) --->          % 1...more
    both0, 
    noun_phrase1(X,VP,P1),          % 1
    noun_phrases0(X,Z,VP,P1,P2).    % 0...more


noun_phrases0(X,XZ,VP,P1,P1 and P3) ---> 
    andor(And),  
    noun_phrase1(Y,VP,P2), 
    noun_phrases20(Y,Z,VP,P2,P3),
    {latin(And,X,Z,XZ)}.   

noun_phrases0(X,XZ,VP,P1,P1 and P3) ---> 
    noun_phrase1(Y,VP,P2), 
    noun_phrases10(Y,Z,VP,P2,P3),
    {latin(and,X,Z,XZ)}.   


noun_phrases0(X,X,_,P,P) ---> []. 


%% list then and

noun_phrases10(X,XZ,VP,P1,P1 and P3) ---> %%  and
    andor(And),
    noun_phrase1(Y,VP,P2), 
    noun_phrases20(Y,Z,VP,P2,P3),
    {latin(And,X,Z,XZ)}.   

noun_phrases10(X,XZ,VP,P1,P1 and P3) ---> %% no and
    noun_phrase1(Y,VP,P2), 
    noun_phrases10(Y,Z,VP,P2,P3),
    {latin(and,X,Z,XZ)}.   

%% lists not allowed

noun_phrases20(X,XZ,VP,P1,P1 and P3) ---> 
    andor(And), 
    noun_phrase1(Y,VP,P2), 
    noun_phrases20(Y,Z,VP,P2,P3),
    {latin(And,X,Z,XZ)}.   

noun_phrases20(X,X,_,P1,P1) ---> [].


% % % % % % % % % % % % % 


no_phrase(X,P) ---> %% Pure Noun_phrase 
    noun_phrase1(_,true,P)-the(X). 



%%%¤ NOUN_PHRASE1


noun_phrase1(X,P,P and Q)---> 
    relwhat(X),                % I know what a bus is 
    st0(Q) -   
        npgap(X).


noun_phrase1(X,P,P) ---> npgap(X). 



noun_phrase1(X,VP,P) --->  
    np1(X,VP,P).           % "the car of" before "this car"


noun_phrase1(X,VP,P) --->  %%   bussen ( anaphoric)
    npa(X,VP,P).


noun_phrase1(X,VP,P) --->  
    np2(X,VP,P).           % some other specialties   


noun_phrase1(Z,P1, exists(Z)::(set_of(X,P,Z) and P1)) ---> 
    athe,
    setlist,
    of, 
    no_phrase(X,P). 



% % % % % % % % % % % % % % % % % % % % % % % %

%% np0    np without modifiers 

np0(X,VP,P) --->       %% np without modifiers
    athe0,             %%   a Buick
    aname_phrase(_IND,X,VP,P).

np0(X,VP,P) --->
    np_head(_, X,P1,P1,VP, P). 

np0(X,VP,P) --->
    npa(X,VP,P).

np0(X,P,P) --->
    npgap(X).

%%%¤ NP1

np1_accept(X,VP,P) ---> %  %% dont bt %% TA-100908
    np1(X,VP,P),
    !.



np1(X,VP,P) ---> %   Bussen passerer Buenget stasjon 
    np_kernel(Ind, X,P0,P1,VP, P), 
    noun_modifiers0(Ind,X,P0,P1).


np_kernel(Ind, X,P0,P1,VP ,P) ---> % #0
    np_head1(Ind, X,P0,P1,VP, P).  % adj/nil/prolog/  system
 

np_kernel(Ind,X,true,P1,VP ,P1 and Q) --->%  #1 buss 8
    the0,          %% the next 52 bus 
    aname_phrase(Ind,X,VP,Q).
    %%% !,accept. %% avoid backtracking    bus 9 \ bus (9)

np_kernel(Ind, X,P0,P1,VP ,P) ---> % #2
    np_head(Ind, X,P0,P1,VP, P).   %% oops bus| then 8=clock
 
np_head1(Cind, XT,Q0 and P0,P1,VP, P) ---> 
    determiner0(Num,Cind,XT,P1,VP,P),   
    w(name(TT,_n,_)),  
    noun(_Bus,Num,u,n,  XT, Q0),
    {adjname_template(TT,XT,_,P0)},
    !,accept.


% Pragmatix 

%% 8 next busses  \= bus 8  


aname_phrase(_IND,_,_,_) ---> % one bus \== (bus) 1 bus
    [one],
    w(noun(_,_,_,_)), 
    !,
    reject.



% dont return (bus) 3 when " 3 noun_plural" 
% unless  time measure

aname_phrase(_IND,_,_,_) ---> 
    number(_), 
    w(noun(Minutes,plu,_,_)), %% I have 3000 internet addresses
{ \+ measureclass(Minutes)}, 
    !,
    reject.


%% next 8 buses  \= bus 8  

aname_phrase(_IND,_,_,_) ---> 
    the0, 
    filanepr,  
    number(_),
    w(noun(_Noun,plu,_,_)),   % certain, the number was a count !
    !,
    reject. 


aname_phrase(_,_,_,_) ---> %% the station (nearest kolstad)
    wx(adj2(nil,Nearest)), 
    {member(Nearest,[nearest])},
    w(name(Kolstad,_,_)),
    {\+ number(Kolstad)}, 
    !,
    reject.

aname_phrase(Ind,XT,VP,P1) ---> 
    athe0,                      
    xpreadjs0(Alist), % empty if name is first 
    name_phrase(Ind,XT,VP,P0), 
    {preadjs_template(Alist,XT,P0,P1)}.

npa(_,_,_) ---> % Bloody hack, shall be translated 
    w(name(good_friday,n,date)),
    !,reject.


npa(Y,VP,findit(X)::P) ---> 
    its,
    determiner(Y,A and H,VP,P)-art,
    noun_compound(Y,A,_),
    {has_template(X,Y,H)}.


%% This (fine)  place must never relapse to pronoun(this)
npa(_X,_P,_F) ---> 
     this,         
     np_corner,
     !,reject. 

npa(X,P,findit(X)::P) --->    %% 'it' Works only under greedy order    
     this1,              %% it
    {it_template(X)}.


npa(X:T,VP,findpron(X:T):: (X isa Man) and VP) ---> 
    pronoun(Man),
    {type(Man,T)}.                


%% Your version exists 

npa(X,VP,P) ---> 
    determiner00(X,P1,VP,P),  %  no determiner
    name_complex(X,P1).       %  assume no determiner  


npa(X,VP,P) --->  %% Does it work ? 
    posspron(Man),
    np1(X,VP,P)  
        \ ( thispron , w(noun(Man,sin,u,gen))).

% % % %

%%%¤ NAME_PHRASE  (name,X,P,P and Q)  

name_phrase(name,X,P,P and Q) ---> 
%%%     {value(teleflag,true)}, %%  (OK if few names)
    person_name(X,Q).

name_phrase(Ind,X,P,Q and P) ---> %% keep order/isa first 
    namep(Ind,X,Q).



person_name((Tore,Berg,Hansen):person, ToreP  and BergP and HansenP) ---> 
    properfirstname(Tore,ToreP),
    properfirstname(Berg,BergP),   
    properlastname(Hansen,HansenP),
    !,accept.


person_name((Tore,Amble):person, ToreP  and  AmbleP) ---> 
    properfirstname(Tore,ToreP),
    properlastname(Amble,AmbleP),
    !,accept.
 

properfirstname(Rønning,RønningP) --->
   nameq1(Rønning:firstname,RønningP).

properlastname(Rønning,RønningP) ---> 
    nameq1(Rønning:lastname,RønningP).


% % % %


time_phrase(X,P,Q and P) ---> %% When clock is expected, number is a time
    timeq12(X,Q).             %%       bus goes  5 o clock

%npy(X,P,Q) ---> name_phrase(X,P,Q).    %% TA-111111
npy(X,P,Q) ---> namep(X,P,Q).           %% RS-140921
npy(X,P,Q) ---> np2(X,P,Q).


np_corner ---> wx(adj2(nil,_)). 
np_corner ---> w(noun(_,_,_,_)).
np_corner ---> w(nb(_,_)).



filanepr --->  wx(adj2(nil,first)). 
filanepr --->  wx(adj2(nil,last)). 
filanepr --->  wx(adj2(nil,next)). 
filanepr --->  wx(adj2(nil,previous)).


flnp(A) ---> wx(adj2(nil,A)), 
    {testmember(A,[first,last,next,previous])}.


% % % % % % % % % % % % % % % % % % % % %



np2(X,VP,P) ---> 
    the0,
    prep1(nearest), 
    np_head(0, X2,P02,P12,VP2, P2),
    prep1(_), %% to/for/... who cares
    np1(AA,BB,CC),
    !,
    np1_accept(X,VP,P) \ (np_head(0, X2,P02,P12,VP2, P2),prep1(near), np1(AA,BB,CC)).
%% TA-1011212
%  np1 calls noun_modifiers which lock0s



%% This mans wifes house =  man has wife and wife has house

np2(X,VP,P) ---> 
    number(1:_),
    ofthe,
    np_head(Ind, X,P0,P1,VP, P) \ a, 
    noun_modifiers0(Ind,X,P0,P1) \
         (prep(from),this,w(noun(set,_,_,n))).


np2(X,VP,P) --->
    the,
    same,
    noun(_,Num,_,n, Z, K), 
    as,
    np1(X,VP,P) - 
        (the,noun(_,Num,_,n, Z, K),ofx).

np2(X,VP,P)--->                  %% lacks complements !!!!
    quant_pron(Every,Person),
    np1(X,VP,P)
        \ ( [Every],w(noun(Person,_,_,n))). 
% Every is instantiated by now))).


%%%¤ NP_HEAD

% his father 
np_head(0, XT,P0,P1,VP, 
 findpron(Y)::( exists(XT) :: P0 and YisaP and P1 and HasYX and VP)) --->
    thispron,
    noun(_,_Num,_,gen,  Y, YisaP),     % program's 
    !,
    preadjs0(Alist),         %% my last question 
    noun_compound(XT,Q0,_Sin), 
 
    {preadjs_template(Alist,XT,Q0,P0)},
                                        % this mans daughter Mary
    {has_template(Y,XT,HasYX)}.



np_head(0, X,P0,P1,VP, find(Y)::( exists(X) :: P0 and YisaP and P1 and HasYX and VP)) --->
    this,  
    noun(_,_Num,_,gen,  Y, YisaP),  
%    !, %% this courses exists 
    preadjs0(Alist),   
    noun_compound(X,Q0,sin),
   {preadjs_template(Alist,X,Q0,P0)},
   {has_template(Y,X,HasYX)}.


np_head(Cind, XT,P0,P1,VP, P) --->  %% Cind = of ,of- complement required
    determiner0(Num,Cind,XT,P1,VP,P),   
    preadjs0(Alist),           %% "hele"
    noun_complex(XT,Q0,Num),  
    { Alist == true,!; \+ vartypeid(XT,friday)}, %% Ad Hoc Good Friday 
    {preadjs_template(Alist,XT,Q0,P0)}.
    
noun_complex(X,P,Num) ---> 
    noun_compound(X,P,Num).

noun_complex(X,P,Num) ---> % May return only one
    noun_list(X,P,Num).    % Moved after noun_compound


name_complex(X,P) ---> 
    name_compound(X,P).

this1(X,find(X))     --->  this1.
% thisx is artificial? RS-140921
% this1(X,findpron(X)) --->  thisx.



clock_number(N:T) ---> 
    number(N:T),
    { N >= 100}.

bus_number(N:T) --->
    number(N:T),
    { N =< 100 }.

road_number(N:T) ---> 
    number(N:T),
    { N =< 100 }.

%%%%%%%%%%%%  NOUN LIST:  separate single nouns

noun_list(X,Q,Num) --->
    noun(_,Num,u,n, Y, P),      %  first noun decides  Num    
    nlists0(Y,P,X,Q).
 
 
nlists0(X:TX,P, (X,Z):(TX,TZ),P and R) ---> 
     andor(_), 
     noun(_,_,_,n, Y, Q),
     nlists0(Y,Q,Z:TZ,R).

nlists0(X,P,X,P) ---> [].


%%%%%%%%%%%%% COMPOUND    left associative with genitive

name_compound(X,QP) ---> % Must begin with a name
    plausible_name(Y,P,GN1),  
    sine(u,GN1,GN2), 
    ncomps0(GN2,X,Y,P,QP).   % At least 1 more if genitive


%-----------

noun_compound(X,XisaBus and QP,Num1) ---> % ... TT bus
    w(name(TT,_n,_)),  
    noun(_Bus,Num1,u,n,  X, XisaBus),
    {adjname_template(TT,X,_,QP)}.    


noun_compound(X,QP,Num) ---> % X is the innermost
    noun2(Num,u,GN, Y, P),        %% gen or n
    ncomps0(GN,X,Y,P,QP).  


ncomps0(_,X,YT,P,QP) ---> %% days first departure 
    adjs10(X,_,P,P1),  
    ncomps(_,X,YT,P1,QP).  %% something wrotten 


ncomps0(n,X1,X2,P,P) ---> % if previous was n, then optionally no more.
    {compatvar(X1,X2)}. 

%%%¤ NCOMPS 

ncomps(_,X,Y,P,QP) ---> 
    not_look_ahead(w(verb(_End,_,_))), %% when will the world end %% TA-110608
    noun2(_,_,GN, Z, Q), %% tt's phone number
    {has_template(Y,Z,H )}, 
    determiner00(Y,P,exists(Z):: (Q and H),PQH),
    ncomps0(GN,X,Z,PQH,QP).



sine(_,n,gen) --->  [s].  
sine(u,n,n) --->     [].     %% bussen stopper \= bussens stopper
sine(_,gen,gen) ---> [].


% % % % % % % % % % % % % % % % % % %


%%¤ NOUN_MODIFIERS0 

%% noun_modifiers0(Ind,X,P,Q)  Ind = of/0    OF-complement/ No OF-compl.


noun_modifiers0(Ind,X,P,Q) ---> 
    { Ind=0;Ind=name},   
    rel_clauses(X,P,Q).           %% EXPENSIVE


noun_modifiers0(Ind,X,P,Q) ---> 
    { Ind=0;Ind=name},  
    reduced_rel(X,P,Q).           %% EXPENSIVE

noun_modifiers0(0,X,P,Q) --->  % not serial nonnested rel_clauses
    rel_clauses(X,P,Q).       

noun_modifiers0(Ind,X,P,R) --->  % last dominates first//0..n
   { Ind \== of,
     Ind \== name}, %% was too expensive  ...from NTNU to Lade  between ...  
     noun_modifiers(_,X,P,R) .  %% 1..n

/*  departures to lohove %% Haz %% TA-101015
noun_modifiers0(0,_,P, P) ---> 
    look_ahead(w(prep(to))),!. %% Last Hazard Rondane %% TA-101215
*/

noun_modifiers0(0,_,P,P) ---> [] . 

noun_modifiers0(name,_,P, P) ---> [] . 

noun_modifiers10(_,X,Q,R)---> %% TA-100908
    and2,  
    !,
    noun_modifiers(_,X,Q,R). 

noun_modifiers10(Ind,X,P,Q) --->  %% TA-101215
   noun_modifiers0(Ind,X,P,Q).

%%¤ NOUN_MODIFIERS 

noun_modifiers(_,X,P,R) ---> %% 1..n
   noun_modifier(X,P,Q),  
   noun_modifiers10(_,X,Q,R). 


%%%¤ NOUN_MODIFIER 

noun_modifier(X,P,P and Q) ---> 
    comparison(X,_,Q).            %%  comparisons (TWO KINDS OF LOOPS ?)


noun_modifier(X,P1,P1 and P3) ---> 
    negation0(N),        
    adjunct1(Prep,Y,NP2,P3),
    {noun_compl(Prep,X,Y,P2)},
    {negate(N,P2,NP2)}.


noun_modifier(X,P,P and Q) ---> 
    prep(Prep),      % to
    rel(X),                 % which
    st0(Q) -  
        ( prep(Prep),npgap(X)).


% complement without preposition is hazardous

noun_modifier(B,P,P and DayX) ---> % bus  friday 
     day(Saturday),
%     begin,                %% not bus 24.08.2000 = bus 24...
        np1(D,Day,DayX) = w(noun(Saturday,sin,u,n)),
%     end, 
    {noun_compl(nil,B,D,Day)},
     !,accept.


noun_modifier(B,P,P and R) ---> % bus now
     adverb(Fast,Q,_),
     !,
     {noun_adverb(B,Fast,Q,R)}. %% whatever that may be


 
%
% E N D  NOUN PHRASES
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

determiner0(plu,0, X,P1,P2, quant(eq/N,X)::(P1 and P2)) ---> 
    the0,

    wx(adj2(nil,FILANEPR)),
    {member(FILANEPR,[first,last,next,previous])},

    number(N:_),
    !,                 %% <--  !
    [] -   w(adj2(FILANEPR,nil)). %% free order

determiner0(Plu,0, X,P1,P2, quant(eq/N,X)::(P1 and P2)) --->
    the0,       
    number(N:_),
    {pluralis(Plu,N)}.  


determiner0(sin,0, X,P1,P2, P) --->    % try the file = this  file
    this1,                             % provided 0 of- complements 
    determiner(X,P1,P2,P) \  this.  


determiner0(_,0, X,P1,P2, P) --->    % try the file = a  file
    the,                               % provided 0 of- complements 
    determiner(X,P1,P2,P) \ art.


determiner0(_,0, X,P1,P2, P) ---> %%  _ ==> 0
    determiner(X,P1,P2,P).

determiner0(_,0, X,P1,P2, P) ---> %% _ ==> 0
    determiner00(X,P1,P2, P).     


determiner00(X,P1,P2, P) --->   
    determiner(X,P1,P2, P) \ art.


% % % % % % % % % % % % % % % % % % % % % % % 

determiner(X,P,Q,find(X)::( P and Q )) ---> 
     this.

determiner(X,P1,P2, P1 and P2) --->   
    the(X).

determiner(X,P1,P2, exists(X):: P1 and P2 ) ---> 
     only0, 
     art.

determiner(X,P1,P2, forall(X):: P1 => P2 ) --->
    every .

determiner(X,P1,P2, not (exists(X)::( P1 and P2 ))) ---> 
    no .

determiner(X,P1,P2, quant(eq/N,X):: (P1 and P2)) ---> 
    theonly0, 
    number(N:_).

determiner(X,P1,P2, quant(CR/N,X):: (P1 and P2)) --->
    comparator1(CR),
    number(N:_),
    ofthe0.    

determiner(X,P1,P2, quant(gt/2,X)::  (P1 and P2)) --->
    many.                                             

determiner(X,P1,P2, quant(ge/2,X)::  (P1 and P2)) --->
    several.                                             

determiner(X,P1,P2, quant(le/3,X) :: (P1 and  P2)) --->
    a0,
    few. 

%-------------------------------------------------------------------

nounp1(X,P,GN) --->  noun(_,_,_,GN, X, P).
nounp1(X,P,GN) --->  plausible_name(X,P,GN).


plausible_name(N:Type,N isa Class,GN) ---> 
    w(name(N,GN,Class)),
    {atom(N)},
    {type(Class,Type)}.


nounp(X,P) ---> noun(_,_,u,n,X,P).
nounp(X,P) ---> namep(0,X,P). 

noun(Country,Num,U,Gen, X:Country, X isa Country) --->
    w(noun(Country,Num,U,Gen)). 


noun(Homepage,Num,U,Gen, X:Homepage, X isa Homepage) ---> 
    w(name(WWW,n,_)),
    w(noun(Page,Num,U,Gen)),
    {adjnamecomp_template(WWW,Page,Homepage)}, 
    !,accept. 


% Name Noun expressions  (Complicated, and Pragmatic).

%%%¤  NAMEP  (Ind,NT,XP) 

namep(0,NT,XP) ---> %% NB 8 hours is also a clock (% fronted%)
    measure(NT,XP).  %% e.g. 5 minutes

namep(name,NT,XP) ---> 
    you,
    nameq(NT,XP) \ w(name(tuc,n,savant)). %% Experiment -


namep(0,NT,YP) --->             %% number 5 -> route 5
    nr,                         %% no. 5 bus
    nameq1(NT1T1,_),            %  dragvoll (not number !) % TYPE CHECK !
    noun(_,_,_,n, NT, XP),      %  bus(es)
    !,accept,        
    {align(NT,NT1T1,_,XP,YP)}.


namep(0,NT2,YP) ---> 
    athe0,                                 %
    noun2(SINPLU,BU,n, NT, XP),            %   retning *(en)*    buss  % ta bussen 30/4 
    suchas0, 
    nameq(N1T1,_),                         %     nth          5        % holdeplassen nth
    {compoundtest(SINPLU,BU,NT,N1T1)},     %   feasability  test 
    {align_noun_name(NT,N1T1,XP,NT2,YP)},  %
    !,accept.                                     %  Avoid multiple returns (e.g. 3)

namep(0,NT,XP) --->      % the 5 bus 
    {value(busflag,true)}, 
    the,   
    nameq(NT,_),
    noun(_,sin,_,n, NT, XP).

namep(0,NT,XP) --->      % the orkdal  buses 
    {\+ value(busflag,true)}, 
    the0,  
    nameq(NT,_),
    noun(_,_,_,n, NT, XP). 


namep(0,NT,YP) --->
    the0,
    nameq1(NT1T1,_),            %  dragvoll (not number !) % TYPE CHECK !
    noun(_,sin,_,n, NT, XP),      %  bus
    {align(NT,NT1T1,_,XP,YP)}.

namep(name,X,Y) ---> 
%%     the0,               %% the 1 \= the 1 oclock %% ad hoc 
    nameq(X,Y),         %% Danube
    not_look_ahead([am]), %% by 6 pm \= by (route) 6
    not_look_ahead([pm]). %% TA-100224

%%   noun1 noun2 noun3

noun2(Num,U2,Gen,  X:Plasmidtype, XPlasmid1 and XPlasmid2) ---> 

    w(noun(Cre_promoter,sin,u,n)), 
    w(noun(Reporter,sin,u,n)), 
    w(noun(Plasmid,Num,U2,Gen)), 

    {adjnoun_template(Cre_promoter,Plasmid, X:Plasmidtype, XPlasmid1)},
    {adjnoun_template(Reporter,    Plasmid ,X:Plasmidtype, XPlasmid2)},

    !,accept. 

noun2(Num,U,Gen, X:Stationtype, XStation2) ---> %%  buss rute/ buss stasjon etc
    w(noun(Bus,sin,u,n)),
    w(noun(Station,Num,U,Gen)), 
    {adjnoun_template(Bus,Station,X:Stationtype,XStation2)}, 
    !,accept.



noun2(Num,U,Gen, A,B) --->
    noun(_,Num,U,Gen, A,B). 


%% Measures

measure(NT1,YP) ---> 
    number(NU),                     %  5
    noun(M,_,_,n, NT, XP),          %  minutes, hours, days
   {\+ testmember(M,[noon,clock])},   %% 12 hours \===== clock
   {measureclass(M)}, 
   {align_measure(NT,NU,XP,NT1,YP)}.  




%%  Name Expressions


%%%¤  NAMEQ (C,Q)

nameq(C,Q) ---> nameq1(C,Q).

nameq(C,Q) ---> nameq2(C,Q).

%%%¤ PLAUSIBLEDATE1   %% TA-110516

plausibledate1(YDate:date, YDate isa date) ---> %% last with care Fredag 13
    w(nb(DD,num)),                                %% TA-110516
    {DD =<31},
    not_look_ahead([':']), 
    optional(['.']), 
     not_look_ahead(w(nb(_,_))), %% etc 
    {todaysdate(date(YYYY,MM,_)), 
     YDate =date(YYYY,MM,DD)}.



%%%¤ DATE


%%   påskeaften, pinseaften, nyttårsaften etc
date(Date:date,Date isa date) ---> %%  n'te pinsedag etc. some may change month 
     w(name(Whitsun_eve,n,date)),
     {testmember(Whitsun_eve,
          [whitsun_eve,whitsun_day,maundy_thursday,good_friday,
           easter_eve,easterday,christmas_eve,christmas_day,
           new_years_eve,new_years_day,midsummer_eve,midsummer_day])},
     !,
     {named_date(Whitsun_eve,Date)}.



date(Date:TD,Date isa date) --->
     monthday(MM,DD),  
     point0, %% Nov 25.  2009 
     xyear0(MM,YYYY),  
     !,
     {Date= date(YYYY,MM,DD)}, 
     {type(date,TD)},  
     !,accept.                            %% 1997 is not a time

date(Date:TD,Date isa date) --->
     dayno(DD),
     not_look_ahead([one]), %% the fifth one 
     ofslash0, %% of | / | |
     monthnumber(MM), 
     xyear0(MM,YYYY),  
     !,
     {Date= date(YYYY,MM,DD)}, 
     {type(date,TD)}, 
     !,accept.                            %% 1997 is not a time

  
monthday(MM,DD) ---> month(MM),point0,dayno(DD),!. %% TA-100203
monthday(MM,DD) ---> 
    dayno(DD),point0,
    ofslash0,
    month(MM),point0,
    !.


dayno(N) ---> w(nb(N,_Num_Ord)), %%  niende
    { N > 0, N =< 31}.


monthnumber(N) ---> number(N:_), 
    { N > 0, N =< 12}.


month(N) ---> 
    w(name(Jan,n,_)),
    {monthnumber(Jan,N)}. %% fernando.pl


day(D) --->   
    w(noun(D,_,_,_)),
    {dayname(D)}.       %% fernando.pl



xyear0(_M,Y) ---> aar0,year(Y),!,accept. 
xyear0(M,Y)  ---> {this_year(Y0)}, %% jan.1th ==> 2003 !
                  {adjust_year(M,Y0,Y)}. 

aar0 ---> w(noun(year,_,_,n)),!. 
aar0 ---> [].


year0(N) ---> year(N),!,accept.
year0(YYYY) ---> {this_year(YYYY)}. %% utility.pl


year(NN) ---> % Pragmatic  
   number(N:_),
  { N >= 90, N =< 99},
  { NN is 1900 + N}.


year(N) --->  
    number(N:_),
  { N >= 1900, N =< 9999},
    !,accept.

% % % %


timeq12(N:T,N isa clock) ---> 
%%     kl0,                      %% Norwagism 
    time12(N),
    !,                        %% <---   !
    {type(clock,T)}.

kl0 ---> [kl],!. 
kl0 ---> [].


%%%¤  NAMEQ1

nameq1(X,P) ---> %%  ( Buss går 09.12 => clock)
   date(X,P).    



nameq1(N:Type,N isa Class) ---> 
  
    w(name(N,_n,Class)), {_n \== gen},
    {  Class == unkn -> value(unknownflag,true);true}, 

    {type(Class,Type)}.      



nameq1(quote(N):T,quote(N) isa thing) --->  %% avoid quote(X) isa sentence. ???
    w(quote(N)), 
    !,
    {type(sentence,T)}.


nameq1(N:clock,N isa clock) ---> 
    time12(N).  


% Definitely a time  

nameq1(X,P) --->
    timeq12(X,P).    %%  clock Time Constant, known to be a time


% Only full dates allowed, try first

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
    look_ahead(w(name(_Lund,n,lastame))),
    !,accept.

%% nameq2  Unclassified number
              
nameq2(N:T,N isa number) ---> %% bus 1 becomes  bus (on) day 1
    number(N:T).


nameq2(N:TT,N isa clock) --->    %% time number formally disjoint
    {type(clock,TT)}, 
    number(N:_),
    {N >= 100,
     N =< 2500}.


time12(N) ---> time2(N).
time12(N) ---> time1(N). 

time1(_) ---> [one],!,reject. %% Avoid misunderstandings

time1(_) ---> num(_N),w(noun(time_count,plu,_,_)),!,reject. 

time1(N1) --->
    num(N1), %% w(nb(N1,num)),
    {N1 >= 100, 
    N1 < 2500},      %%  (heuristic)  
    not_look_ahead(w(noun(hour,plu,u,_))), %% hours means duration 
    clock0, 
    !,accept.

time1(N1) --->
    num(N),
    {N < 25, N >= 1},  %%  avoid the 1 = 100 qua clock 
    not_look_ahead(w(noun(hour,plu,u,_))), %% hours means duration 
    clock0,           %%  1pm     
    !,
    {N1 is N*100}.


time2(N) ---> 
     homi(N0),
     ampm(N0,N).

time2(N) --->      %% NB between 8 and 9 pm ==> (0800,2100) !!! 
     time1(N0),
     {N0 < 2500}, 
     ampm(N0,N).

time2(N) ---> 
    wx(adj2(nil,half)),prep1(past),hours(N1),
    {N is N1*100+30}.

time2(N) ---> 
    wx(adj2(nil,half)),prep1(past),
    time12(N1), %% half past 1610 = 1640
    {addtotime(N1,30,N)}. 


homi(N) --->  %%  6:00 
     hours(N1),
     hcolon,    %% 8h30
     minutes(N2),
     {N is N1*100 + N2},
     !.    


homi(N) ---> %%  6 00
     hours(N1),
     minutes(N2),
     {N is N1*100 + N2}.  



ampm(N,N1) ---> pmtime,  
    !,
    { N > 1200 -> N1 is N;
                  N1 is N+1200 }.

ampm(N,N) --->  amtime.  

ampm(N,N) --->  clock0. 





hours(N1) ---> 
    w(nb(N1,num)),
    {N1 < 25}.    

minutes(N1) ---> 
    w(nb(N1,num)),
    {N1 < 60}.    

nameq3(N:T,N isa number) ---> 
    only0,  
    number(N:T).


number(N:Type) --->  %% monday <> 28   
    num(N),
    {type(number,Type)}. 


number(N:Type) --->  %% a hundred ( also a 100)
    [a],             %% not composite  (a hundred thousand)
    num(N),
    {N=100;N=1000;N=1000000},
    !,
    {type(number,Type)}. 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

intrans_verb(be1,X,S,BXS,pres,fin) ---> 
     hasto0, 
     be1,
     {iv_template(be1,X,S,BXS)}.

intrans_verb(Live,X,S,EXS,P,Q) ---> 
    hasto0,
    lexv(iv,Live,P,Q),  
    {iv_template(Live,X,S,EXS)}.


intrans_verb(Live,X,S,EXS,past,fin) ---> % has lived -> did live
    has, 
    lexv(iv,Live,past,part),  
    {iv_template(Live,X,S,EXS)}.



trans_verbs(LM,X,Y,S,Love_and_Marry) --->
     trans_verb(Love,X,Y,S,_,_,_),
     trans_verbs0(Love,LM,X,Y,S,Love_and_Marry).


trans_verbs0(Love,LM,X,Y,S,Love_and_Marry) --->
     andor(and), 
     trans_verb(Marry,X,Y,S,_,_,_),
     trans_verbs0((Love,Marry),LM,X,Y,S,Love_and_Marry).


trans_verbs0(Love,Love,X:_,Y:_,S,Love/X/Y/S) ---> [].



trans_verb(equal,X,Y,S,BXYS,pres,fin) ---> % equal == be equal
     hasto0,
     be,
     {tv_template(equal,X,Y,S,BXYS)}.


trans_verb(Border,X,Y,S,BXYS,P,Q) --->
     hasto0,
     lexv(tv,Border,P,Q), 
     {tv_template(Border,X,Y,S,BXYS)}.


that_verb(Urge,X,S,UXS,P,Q) --->    
     hasto0,
     that_v(Urge,P,Q),
     {rv_template(id,Urge,_,X,S,UXS,_News)}.


that_v(Say,P,Q) ---> 
     lexv(rv,Say,P,Q).     %%   sv = > rn ( rep_verb )


lexv(iv,be1,pres,fin) --->
    be.


lexv(tv,be_named,pres,fin) ---> 
    be,
    lexv(_,call,past,part),
    !,accept.


lexv(tv,make,Pres,Fin) --->   %%   make up
    w(verb(make,Pres,Fin)),  
    up0,  
    !,accept.


lexv(T,Go,P,Q) ---> 
    w(verb(have,P,Q)),
    lexv(T,Go,past,part),
    {verbtype(Go,T)},    
    !,accept.


lexv(T,Live,P,Q)--->
     w(verb(Live,P,Q)),
     {verbtype(Live,T)}. 


be_modal(Seems) ---> be,modal(Seems).
be_modal(seem)  ---> w(verb(seem,_,fin)).

modal(Thought) ---> 
    that_v(Thought,past,part), % passive
    tobetrue(_N).    %% negation ?            

modal(Thought) ---> that_v(Thought,_,fin).     % active
modal(think)   ---> wx(adj2(nil,possible)). 

tobetrue(N)  ---> to,be_truefalse(N).          
tobetrue(id) ---> [].


pvimodal(Cost,Money) ---> 
    w(verb(Cost,_,fin)),
    { Cost \== be},   
    {pvi_templ(Cost,Money)}.  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    A D J E C T I V E   S E C T I O N
% 
%

%  Proper Adjectives before other prefixes    
%  'next 5 bus'  vs '5 next bus'

xpreadjs0(true) ---> look_ahead(w(name(_,_,_))). %%  Dont eat names
xpreadjs0(Z)    ---> preadjs0(Z).

preadjs0((A,Alist)) ---> 
    preadj1(A),
    preadjs0(Alist).

preadjs0(true)---> [].
 

preadj1(Nil/A) ---> 
   adverb0(_Medium), 
   wx(adj2(Nil,A)),
%   {\+ dict_e:noun(A)},    %%  user is sort of adjective 
   {\+ noun(A) },    %%  user is sort of adjective %% RS-140921 From dict_e.pl
   {\+ post_adjective(A)}, %% down (adj) town
   !.          %% 


postadj1(A,X,S, AP) ---> 
     so0,   
     adj12(A,X,S,AP), 
     !,accept,                            %% is big woman *
     not_look_ahead(w(noun(_,_,_,_))).       %% NOT postadj1


adjs10(X,S,OLD,OLD and NEWP) --->   % NOT start with and 
    adj1(_,X,S,NEW),
    adjs10a(X,S,NEW,NEWP).

adjs10(_,_,OLD,OLD) ---> [].

adjs10a(X,S,OLD,OLD and NEWP) ---> % MAY  start with and 
    and0,
    adj1(_,X,S,NEW),
    adjs10a(X,S,NEW,NEWP).

adjs10a(_,_,OLD,OLD) ---> []. 


adj12(A,X,S,P) ---> adj1(A,X,S,P).    %% Proper Adjective

adj12(A,X,S,P) ---> adj2(A,X,S,P).    %% Noun/Name Prefix

adj12(A,X,S,P) ---> adj3(A,X,S,P).    %% Adverbial Prefix 

adj1(previous,X,S,BIGX) ---> 
   [next],to,wx(adj2(nil,last)), 
   {adj_template(nil,previous,X,S,BIGX)}. 

adj1(Big,X,S,BIGX) --->   
    wx(adj2(nil,Big)), 
    {adj_template(nil,Big,X,S,BIGX)}. 


adj2(Buick,X,S,CarX) ---> 
    w(name(Buick,n,_)),   
    {adjname_template(Buick,X,S,CarX)}. 


adj3(Big,X,S,BIGX) ---> 
    adverb1(_Very),           %% NB Adjectival adverb
    wx(adj2(nil,Big)),
    {adj_template(nil,Big,X,S,BIGX)}. %% _Very/Big  Drop Distinction 

%% Adjective A treated like an intransitive verb be/A
                                           

adverb1(Very) ---> [Very],{gradv_templ(Very,_)}.
%% Adjectival adv 

%% adverb1(very) ---> [very].
%% adverb1(medium) ---> [medium].  %% made as an adjective (ad hoc)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prep0(P) ---> prep(P). 
% prep0(intime) ---> [].      %% John died 1645 

prep(P) ---> prep2(P).      % Prepositional Expressions  (1.)
prep(P) ---> prep1(P).      % Preposition                (2.)


prep1(P)---> w(prep(P)).



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

% subord_conj --> subjunction

subjunction(after,  time,  in)  --->  prep(after),
    not_look_ahead(w(nb(_,_))).    %% time?
subjunction(before, time,  in)  --->  prep(before),
    not_look_ahead(w(nb(_,_))).  

subjunction(during, time,  in)  --->  while. 
subjunction(in,     time,  in)  --->  when.  
subjunction(in,     place, in)  --->  where.
subjunction(in,     time,  ni)  --->  prep(without). 
subjunction(until,  time,  in)  --->  until.

%% subjunction(because_of,  reason, being_the)  --->   so_that.

subjunction(so_that,  coevent, nil)  --->   so_that.

%% subjunction(being_the,   reason, because_of) --->   because. 
subjunction(nil,   coevent, because_of) --->   because. 

%% Most typical: which bus... IF I SHALL .... == so_that
%% subjunction(being_the,   reason, because_of) --->  if1.    %%  Ambiguous!

subjunction(because_of,  coevent, nil)  ---> if1. %% jeg går hvis bussen står   



qtrailer ---> wx(adj2(nil,next)).


%%%%%%%%%%%%%%%% LEXICAL INTERFACE

a0  ---> a.
a0  ---> [].

a ---> [a].
a ---> [an]. 

art ---> [a].
art ---> [the]. %% <-- %% TA-100909


art ---> [an].   
art ---> [any]. 
art ---> [another]. 
art ---> [one],[or],[more]. 
art ---> [some].

art ---> all,ofthe0. %% Rough 

art ---> [this],look_ahead(w(noun(_,_,_,_))). 

%%%%%%%%%%%%%%%%%

all ---> [all].
all ---> the,set.


and0 ---> and1,then0.
and0 ---> [].

and1 ---> [and]. %%  and/2 is an operator, causes confusion
and1 ---> [but].

and2 ---> [but]. 

andor(butnot) ---> 
    and1,[not], 
    !,accept.

andor(and) ---> and1,do0. 
andor(or)---> [or].


%-
amtime ---> w(noun(noon,_,_,_)),!. 
amtime ---> [am],point0. 
amtime ---> [a],point0,[m],point0. 
%% amtime ---> [a],point0.  %% Hazard 
%-



anorder(a,N)   ---> a,  w(nb(N,ord)).
anorder(the,N) ---> the,w(nb(N,ord)).

another ---> [another].
another ---> [other]. %%  rough?

as ---> [as].

as0 ---> as.
as0 ---> [].

at ---> prep(at). 

athe ---> the.  
athe ---> a.

athe0 ---> athe.    % The book 'ABC'
athe0 ---> [].


%%% BE DO BE DO BE DO


% be ---> be. %%%%%%%   be(id).

be ---> w(verb(be,_,fin)).

be(N) ---> 
   (do),
   negation0(N),
   has,
   to,
   be.

be(N) --->      
   modal,
   negation0(N),
   be.

be(N) --->      
   be,
   negation0(N). 
   
be(N) --->
   has,
   negation0(N),
   [been].


be_truefalse(N) --->  
    be,
    truefalse(N). 

be_truefalse(not) --->  
    w(verb(reject,_,fin)),
    infinitive, %%prep(to),
    be,
    [true].

because ---> [because].


both0 ---> [both].
both0 ---> [].

by ---> [by].

clock0 ---> clock,!,accept.
clock0 ---> [].

clock ---> [o], [clock].
clock ---> [clock].     
clock ---> [oclock].
%% clock ---> [hours]. %% 3 hours is a duration (also)
%% clock ---> [hour]. 
clock ---> [h].  %% 1800 h.

colon0 ---> colon.
colon0 ---> [].    %% Experiment

hcolon ---> [h].   %% 8h30 
hcolon ---> colon. %%

colon ---> [':']. 
colon ---> ['.']. % if visible

%% Simple Comparators 

comparator1(eq) ---> [like]. 
comparator1(eq) ---> [equal],to0.
comparator1(eq) ---> [like].
comparator1(eq) ---> prep1(about). %% Rough 
comparator1(ge) ---> greater,than0,[or],[equal],to0. 
comparator1(ge) ---> [not],less,[than].
comparator1(ge) ---> at,[least].
comparator1(gt) ---> greater,[than].
comparator1(gt) ---> prep1(over). %% TA.001013
comparator1(le) ---> less,than0,[or],[equal],to0.
comparator1(le) ---> [no],[more],[than]. 
comparator1(le) ---> [not],greater,[than].
comparator1(le) ---> at,most.
comparator1(lt) ---> less,[than].
comparator1(ne) ---> [different],[from].
comparator1(ne) ---> [except].
comparator1(ne) ---> unequal,to0.
                                                        

%% Derived Comparators 

comparator2(gt,speed) ---> [faster],[than]. 

comparator2(gt,age) ---> older,[than]. 
comparator2(lt,age) ---> younger,[than].

comparator2(gt,size) ---> greater,[than].
comparator2(lt,size) ---> [smaller],[than].

comparator2(gt,complexity) ---> [more],[complex],[than].  
comparator2(lt,complexity) ---> [simpler],[than].

comparator2(gt,latitude) ---> [north],of.
comparator2(lt,latitude) ---> [south],of.

comparator2(gt,longitude) ---> [west],of.
comparator2(lt,longitude) ---> [east],of.

superlative(M,S) ---> superlat(M,S). %%   ( free order )
superlative(M,S) ---> superlat(M,S)-quant0(N),quant0(N).


superlat(max(N),size)      --->   quant0(N), greatest. 
superlat(max(N),latitude)  --->   quant0(N),most,[northern].
superlat(max(N),longitude) --->   quant0(N),most,[western].


superlat(min(N),size)      --->   quant0(N), [smallest]. %%
superlat(min(N),latitude)  --->   quant0(N),most,[southern].
superlat(min(N),longitude) --->   quant0(N),most,[eastern].

dendagen0(D)   ---> on0,               %% any problems here ?
                    dendagen(D),!,accept.
dendagen0(nil) ---> [].                %% 

dendagen(D)   --->  day(D),!,accept. 
dendagen(nil) ---> [],!,accept.       %% 

do0 ---> (do). 
do0 ---> []. 


do0(X,_,_) ---> [am],   %% Special test to avoid am being intransitive verb be1
    {\+ type(self,X)}, 
    !,reject.  


do0(_,not,id) ---> %% she had not had her breakfast 
    has,
    [not].
%     !,accept.   NB      % she had not a mother ???

do0(_,not,id) --->
    do(not), %% [cannot],
    !,accept.

do0(_,N,id) --->
     (do),!, 
     negation0(N).

do0(_,N,N) ---> [].  


do0(_,not,id) --->    %% you not take the bus ( not RP) 
     negation0(not), %% (når bussen) ikke (vil) ... gå 
     do0.            %% du ikke tar bussen (not RP)

% do(id) --->  use,to.

do(not) ---> [dont]. 
do(not) ---> [cannot],!,accept.
do(not) ---> [never],!,accept. 


do(N) --->  use,negation0(N),to.

do(N) ---> 
    (do),
    negation0(N),hasto0.

do(id )---> [] .  

do(N) --->      %%%  dont swallow verb have ! 
    has,
    negation0(N).

dox ---> [do]. %% TA-110823
dox ---> [does]. %% not syn do (....> does = inf) 

(do) ---> dox, not_look_ahead([it]).  %% Ad Hoc

(do) ---> [can].
(do) ---> may.
(do) ---> must.     %%
(do) ---> [will].    %  shall

% (do) ---> [does].  %% synword
% (do) ---> [did].   %% synword

dont(not) ---> [don],[t]. %% don't
dont(not) ---> [dont],!,accept.
dont(not) ---> [do],[not],!,accept.

dont(id) ---> [do],!,accept.
dont(id) ---> [].



each ---> [each].
each ---> [all],the.

either0 ---> [either].
either0 ---> [].
 
every ---> [all].
every ---> [every].
%% every ---> [all],of0,the. %% makes wrong code 
every ---> [each].    %% of each -/-> that every has
% every ---> [each],of,the.


few ---> [few].

from ---> [from].

great ---> wx(adj2(nil,great)).
great ---> [big]. % synonym
great ---> [great].
great ---> [high].
great ---> [large]. 
great ---> [tall].

greater ---> [after].
greater ---> [bigger]. % synonym
greater ---> [greater]. 
greater ---> [higher].
greater ---> [later]. 
greater ---> [more],great.
greater ---> [more]. 


greatest ---> [greatest]. % biggest
greatest ---> [biggest].  % biggest
greatest ---> [largest].

has ---> w(verb(have,_,fin)).  

hasto0 ---> has,to.
hasto0 ---> [].

having ---> w(verb(have,pres,part)). 
having ---> w(prep(with)).           


% ...

how ---> [how].
how ---> [why].  


i  ---> [i]. 

if1 ---> [if]. %% if/2 is an operator, causes confusion

in0 ---> [in].
in0 ---> [].

%% in_order_to(let,id) ---> [],!,accept. %% I let you go %% NO,object modifier

in_order_to(go,_) ---> prep1(to),!,reject. %% go to always preposition 

in_order_to(start,id) ---> infinitive,!,accept.
in_order_to(stop,id)  ---> infinitive,!,accept. 
in_order_to(_,not)    ---> prep1(without),infinitive. %% Norwagism
in_order_to(_,id)     ---> in_order_to.


in_order0 ---> in_order,!,accept.
in_order0 ---> [].                   %%

in_order ---> prep(in),[order].     %%

in_order_to ---> prep1(to),notverb,!,reject.

in_order_to ---> in_order0, %%  I go to lade \= I go in order to
                 infinitive.  

in_order_to ---> if1,i, w(verb(want,_,fin)),infinitive.

infinitive ---> [to]. %% not prep1(to). 

notverb ---> w(verb(_Answer,_,fin)),!,reject. 
notverb ---> art.
notverb ---> [the].  %% A man admitted to the hospital exists
notverb ---> wx(adj2(nil,_)).
notverb ---> w(noun(_,_,_,_)).
notverb ---> w(name(_,_,_)).



it ---> [it].

its ---> [its],own0.

ittobetrue0 ---> it,to,be,true,!. 
ittobetrue0 ---> [].

just0 ---> [just],!,accept. 
just0 ---> [right],!,accept.
just0 ---> []. 

latest ---> [last].   

less ---> [before].
less ---> [earlier].
less ---> [less].
less ---> [lower].
less ---> [smaller].

may  ---> [can].
may  ---> [may].

many ---> [many].

modal --->  may.
modal --->  must.
modal ---> [will].

most ---> [most].

much ---> [much].


must ---> [must].
must --->  has,to.


negation0(id) ---> [not],[only],!,accept. 
negation0(not) ---> [not].
%% negation0(id)  --->  [there] . 
negation0(id)  --->  [] .  

newyear ---> wx(adj2(nil,new)),w(noun(year,_,_,_)).
newyear ---> [newyear]. 
no ---> [no].

now0 ---> now,!,accept. 
now0 ---> [today],!,accept. 
now0 ---> []. 

now ---> just0,[now],!,accept. 


nr0 ---> nr,!,accept.
nr0 ---> [].

nr --->  w(noun(number,sin,u,n)),  %% route  no. 5
         point0.    

nr --->  [no],
         point0.    

of ---> prep1(of). 

of0 ---> of. 
of0 ---> []. 

offrom ---> of.
offrom ---> prep1(from).  

ofslash0 ---> ['.']. %% 31.12 
ofslash0 ---> ['/'].
ofslash0 ---> of0.

ofthe ---> of,the.

ofthe0 ---> ofthe.
ofthe0 ---> [other].  %% rough
ofthe0 ---> [].

older ---> [older].


one ---> [one].  
one ---> w(nb(1,num)). 

ones ---> [ones].  


on0 ---> prep1(on),!.
on0 ---> prep1(in),!. %% Norwagism ?? 
on0 ---> []. 


only0 ---> [only],!.
only0 ---> [].

ordinal(N) ---> 
    w(nb(N,ord)).

or1 --->  [or]. 

others ---> [others].

own0 ---> [own].
own0 ---> [].

%% Particles


particle(reductant) ---> reductant. 


particle(early) ---> amtime. %% keep information to avoid 8->20
                           
particle(now) ---> now.

particle(X) ---> [X], 
    {particle(X,_,_)}. %% semantic.pl  

particle(hereafter) ---> 
     prep1(from),
     [now],
     on0.

particle(hereafter) ---> 
     [as],
     soon, 
     [as],
     wx(adj2(nil,possible)).

particle(regularly) ---> 
    [as],
    [usual].


reductant ---> [not],[only]. %% Negation dummy ! 
reductant ---> [only].


pmtime ---> 
    prep1(in),[the],w(noun(Afternoon,sin,u,n)),
    {member(Afternoon,[afternoon,evening,night])},
    !,accept.

%-
pmtime ---> [pm],point0. 
pmtime ---> [p],point0,[m],point0. 
pmtime ---> [p],point0. 
pmtime ---> w(noun(afternoon,_,_,_)),!. 
%-
point0 ---> point,!,accept. %%   Always Optional
point0 ---> [].

pointNO ---> point,!,accept. %% Optional in case point is  removed 
pointNO ---> {value(nodotflag,true)}. 

point ---> ['.'].


posspron(self)   --->  [my],own0.  
posspron(man)    --->  [his],own0.
posspron(woman)  --->  [her],own0.
posspron(savant)  --->  [your]. %% your = tucs 
posspron(person) --->  their,own0.  %% thing

prep2(about)        ---> prep1(for),prep1(about).  
prep2(according_to) ---> [according],to. 
prep2(after)        ---> [just],prep1(after).   
prep2(around)       ---> prep1(at),prep1(about). 
prep2(around)       ---> prep1(at),prep1(around).
prep2(around)       ---> w(prep(near)),to. 
prep2(beside)       ---> [next],to.             
prep2(from)         ---> [out],offrom.
prep2(near)         ---> w(prep(near)),to.
prep2(near)         ---> w(adj2(nearest,nil)),to. %% TA-110116 ad hoc
prep2(near)         ---> w(prep(near)),by. 
prep2(near)         ---> w(prep(near)),at.  
prep2(nearest)      ---> w(prep(nearest)),to. 
prep2(of)           ---> [up],prep1(of). 
prep2(on)           ---> [as],prep1(of). %%   (as of date
%% prep2(over)         ---> [more],[than]. %%  // determiner
prep2(out_of)       ---> [out],offrom.
prep2(to)           ---> [bound],prep1(for). 
prep2(to)           ---> prep1(on),its0,w(noun(way,sin,u,n)),prep(to).
prep2(to)           ---> umpover,prep1(to). 
prep2(without)      ---> [free],of.
prep2(with)         ---> [by],[using]. 
prep2(with)         ---> [using].               
prep2(with)         ---> by,[use],of.       


its0 ---> [its]. 
its0 ---> [the]. 

umpover ---> [up]. 
umpover ---> [down].

pronoun(Man) ---> [He], 
    { pronoun(He,Man) }.        %% RS-140921 From dict_e.pl
%    {dict_e:pronoun(He,Man)}. 

reflexiv0(V) ---> reflexiv(V),!.
reflexiv0(_) ---> [].

reflexiv(ask)  ---> [you],!,accept. 
reflexiv(give) ---> [i],!,accept. %% give me   etc....
reflexiv(notify) ---> [i],!,accept. 
reflexiv(show) ---> [i],!,accept. %% show me   etc....  
reflexiv(tell) ---> [i],!,accept. %% tell me   etc....  

reflexiv(_)   ---> {\+ value(dialog,1)},[there]. 

quant_pron(every,person) ---> [all],number(_). 
quant_pron(every,person) ---> [each]. 

quant_pron(every,person) ---> [everybody].
quant_pron(every,person) ---> [everyone].
quant_pron(every,thing)  ---> [everything].

quant_pron(some,person)  ---> [somebody].
quant_pron(some,person)  ---> someone.
quant_pron(some,person)  ---> [one]. 
quant_pron(some,person)  ---> [anybody].
quant_pron(some,person)  ---> [anyone].

quant_pron(some,thing)   ---> [something].
quant_pron(some,thing)   ---> [anything].

quant_pron(no,person)    ---> [nobody].  % none ?
quant_pron(no,person)    ---> [noone].
quant_pron(no,thing)     ---> [nothing]. % none ?

quant_pron(some,vehicle)  ---> [it], 
    {value(busflag,true)}.  

quant0(+ 1) ---> [].
quant0(+ N) ---> num(N). 
quant0(- N) ---> ordinal(N).


% ... 

relpron(thing) --->  that.
relpron(thing) --->  which.
relpron(thing) --->  what. 
relpron(agent) ---> who.  % whom 


%% relpron(thing) ---> [].     %% (Too Expensive)


resiproc(man)    ---> [himself]. 
resiproc(person) ---> [themselves].
resiproc(woman)  ---> [herself]. 
resiproc(thing)  ---> [itself].  

same ---> [same].

set ---> w(noun(set,_,u,n)).

setlist ---> set.  
setlist ---> [list].

several ---> [several].
several ---> [more],[than],one.


so0 ---> [so],!. 
so0 ---> [].

so_that ---> [that]. 
so_that ---> [so],that.
so_that ---> [in],[order],that.
so_that ---> [so]. 

%% so_that ---> look_ahead([i]). %% I'm afraid I can't do that. 
                                 %% tonight, I must reach a train
someone ---> [someone].

soon ---> [soon].  
soon ---> wx(adj2(nil,fast)). 

suchas0  ---> [such],[as],!,accept.
suchas0  ---> [].

statics(avg)     ---> [average],ofthe0.
statics(max(+1)) ---> [maximum],ofthe0. 
statics(min(+1)) ---> [minimum],ofthe0. 
statics(sum)     ---> total,ofthe0.
statics(number)  ---> [number],ofthe0.

sure ---> [sure].


terminator ---> termchar.


termchar ---> ['.']. 
termchar ---> ['?'].
termchar ---> ['!'].

thanks ---> [thanks].  
thanks ---> [thank],[you]. 
thanks ---> [thankyou].
thanks ---> [thank],[s]. %%  thank's

than0 ---> [than].
than0 ---> [].    

that ---> [that].


that0(T)    ---> that(T),!,accept. 
that0(that) ---> []. 

% that(that)    ---> that0.

that(when)    ---> when. 
that(where)   ---> where. 
that(whether) ---> [whether].
that(whether) ---> if1.
that(how)     ---> how.
that(why)     ---> [why].
that(that)    ---> [that]. 

that0 ---> that.
that0 ---> [].

the ---> [the].
the ---> [this],look_ahead(w(noun,_,_,_)).

the0 --->  [the],!.
the0 --->  [this],!. %% TA-100208 who is this tagore
the0 --->  [].


their ---> [their].
their ---> [the],[others].

then0 ---> then1,!,accept.
then0 ---> [].

then1 ---> [then].


theonly0 ---> the0,only0.

there0 ---> [there].
there0 ---> [it]. 
there0 ---> [].

thereit ---> [there]. % preliminary subject 
thereit ---> [it].


this1 ---> {value(textflag,true)},[the]. 
this1 ---> that.  
this1 ---> [these]. % Anaphoric
this1 ---> [this],
   not_look_ahead(w(noun(_,_,_,_))). 
this1 ---> [those].

% thisx is artificial

to ---> prep(to).

to0 ---> to.
to0 ---> [].  

total ---> [total].
total ---> [sum],of.

true ---> [true].

truefalse(id)  --->  [true].
truefalse(id)  --->  [not],[false].
truefalse(not) --->  [false].
truefalse(not) --->  [not],[true].

up0 ---> [up],!,accept. 
up0 ---> []. 

unequal ---> [unequal].
unequal ---> [not],[equal].

until ---> [until].

use ---> w(verb(use,_,fin)).

very ---> [very].


what --->  [what]. 
what --->  which. % which is

whatbe(1) ---> whatbe1,!,accept. 
whatbe(0) ---> []. 

whatbe1 ---> what,be.
whatbe1 ---> [whats].
whatbe1 ---> w(verb(show,_,fin)),[me]. 
whatbe1 ---> w(verb(list,_,fin)). 

when ---> [when]. 
when ---> [which],w(noun(time,_,u,n)).
when ---> [what],w(noun(time,_,u,n)). 
when ---> [how],wx(adj2(nil,late)),!,accept. 
when ---> [how],wx(adj2(nil,early)),!,accept.  %% 

where ---> [where].
where ---> [how],[far].

wherefrom ---> prep1(from),[where],!,accept. 
wherefrom ---> [where],prep1(from),!,accept. 
wherefrom ---> [wherefrom]. 

while(not) ---> while0,[not],!,accept. 
while(not) ---> [without],!,accept.
while(id)  ---> while0,!,accept.

while0 ---> while,!,accept.
while0 ---> [].
 
while ---> [while].

who ---> [who].

which ---> [what],w(noun(kind,_,_,_)),of,!,accept. %% (kind only as phrase)
which ---> [which].

which2 ---> which,ofthe0. 
which2 ---> [what].         %%  what time is it ?

whose ---> [whose].      

you ---> [you].

younger ---> [younger].


num(N) ---> w(nb(N,num)). 




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% PERSONAL SECTION 


%% Statements  presuming BussTUC is human.
%% The answer is OK whenever adequate

personal('OK') ---> w(adj2(good,_)).   %% TA-110214      
personal('LAWL')    ---> [lol].           %% Laughing out loud :-)
personal('LMAO') ---> [lawl].    
personal('ROTFL') ---> [lmao].         %% Rollng on the floor laughing 
personal('ROTFLMAO') ---> [rofl].
personal('ROTFLMAO') ---> [rotfl].     %% Rollng on the floor laughing my ass off
personal('ROTFLMAO') ---> [roflmao].  
personal('OK')       ---> [rotflmao].                              %% 

personal('OK') ---> wx(adj2(nil,sorry)). %% ...

personal('OK') ---> w(verb(be,pres,fin)),[you],[ok]. %% TA-100902
personal('OK') ---> [never],w(noun(mind,sin,u,n)). 
personal(pong) ---> [ping]. %% Just kidding

personal(thanks) ---> [bravo].

personal(thanks) ---> [this],be,wx(adj2(nil,good)). % etc.  

personal('OK') --->  optional(hello), 
    [how],w(verb(be,pres,fin)),[you], feeling0, now0. %%  :-)


personal('OK') ---> optional(hello),
    [how],(do),[you], (do),now0. 

personal('OK') --->  optional(hello),
    [how],(do),[you], w(verb(feel,pres,fin)),now0. 

feeling0 ---> w(verb(feel,pres,part)). 
feeling0 ---> w(verb(do1,pres,part)). 
feeling0 ---> [].

now0 ---> [now],!,accept. 
now0 ---> particle(_),!,accept.
%now0 ---> [].  %% DUPLICATE

quit(bye) ---> [bye],[bye],!. 
quit(bye) ---> [bye].            %% TA-110428
quit(bye) ---> [regards].        %% TA-110428
quit(bye) ---> w(adj2(best,nil)),[regards]. %%  TA-110428
quit(bye) ---> wx(adj2(nil,good)),[bye].   
quit(bye) ---> wx(adj2(nil,good)),[night]. 
quit(bye) ---> wx(adj2(nil,good)),[day].  
%quit(bye) ---> [bye].   %% DUPLICATE
quit(bye) ---> [exit]. 
quit(bye) ---> [farewell].
quit(bye) ---> [stop].
quit(bye) ---> [goodbye].               
quit(bye) ---> w(verb(quit,pres,fin)).  
quit(bye) ---> w(verb(stop,pres,fin)).  

quit(bye) ---> w(verb(have,_,_)), 
              [a],wx(adj2(nil,Good)),w(noun(Day,sin,u,n)),
    {member(Good,[good,nice,happy])},
    {subclass0(Day,time)}.


quit(you_are_welcome) ---> optionalok,thanks,youverymuch0.
quit(merry_christmas) ---> wx(adj2(nil,good)),w(noun(christmas,_,_,_)).
quit(merry_christmas) ---> wx(adj2(nil,good)),w(name(christmas,_,_)).
quit(happy_new_year)  ---> wx(adj2(nil,good)),newyear. 
quit(happy_new_year)  ---> wx(adj2(nil,happy)),newyear. 

greetings0 ---> greetings,!,accept.
greetings0 ---> [].

%% greetings ---> w(name(tuc,n,_)). %% you have a life 
greetings ---> w(name(hal,n,computer)).  %% :-)

greetings ---> hello.
greetings ---> [hi],!,sludder.
greetings ---> [hello],!,sludder. 
greetings ---> [but].
greetings ---> [o],np0(_,_,_). %% :-)
greetings ---> [ok].  
greetings ---> [so].  
greetings ---> [yes]. 

hello ---> [hello]. 
hello ---> [hi]. 
hello ---> wx(adj2(nil,good)),helloday. 

helloday ---> w(noun(afternoon,_,_,_)). 
helloday ---> w(noun(evening,_,_,_)).   %%
helloday ---> w(noun(morning,_,_,_)).   %%

optionalok ---> [ok].
optionalok ---> [].

sludder ---> [there].
sludder ---> w(noun(world,sin,u,n)). %% Hello world 
sludder ---> []. % old chap


% thisplace(in) ---> [here]. 

thisplace(to) ---> [here]. 
thisplace(to) ---> [there]. 


toyou0 ---> prep1(to),[you],!,accept. 
toyou0 ---> [].


you0 ---> [you].
you0 ---> [].

very0 ---> [very]. %% if not noise
very0 ---> [].

much0 ---> [much].
much0 ---> [].


youverymuch0 ---> w(noun(friend,_,_,_)).
youverymuch0 ---> you0,very0,much0.
youverymuch0 ---> w(prep(for)),noun_phrase1(_,_,_),!.

%%%%%%%%%%% END OF LEXICAL INTERFACE %%%%%%%%%%%



%%%%%%%% END OF GRAMMAR %%%%%%%%%%%%%%%%%%%%%%%% 

%% EXPERIMENT %% RS-1411220
%file_date( filename ) :-
%        writeout:output( filename ).
%
%:- file_date( 'hei' ).

%makegram. %% RS-141130
%:- use_module( metacomp, [ compile_english/1 ] ).  %% RS-141122 Make the dcg_e.pl file, based on updates in this gram_e file.
%:- compile_english( '' ).        %% For quick recompilation

%%%%%%%%%%%%%%%%%%%%%%%THE END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

