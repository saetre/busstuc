%% FILE dagrun_n.pl
%% SYSTEM TUC
%% AUTHOR T.Amble
%% CREATED TA-950728
%% REVISED TA-110127
%% REVISED RS-140921

:-module( dagrun_n, [ cc/5, check_stop/5, compute_gap_item/2, end_of_line/5, end_of_line0/5,
        lock/5, look_ahead/6, not_look_ahead/6, pushstack/7, skip_rest/5,
        unlock/4, virtual/6, w/6, word/5  ] ). %% RS-140209

%% RS-131227  dcg_e and dcg_n are both auto-generated from metacomp.pl! (Both CONTAINS dcg.pl)

% Norwegian  clone of runtime routines 
% - Loaded/Used in module dcg_n later...

%% RS-131227    UNIT: /
:- use_module( '../declare', [ set/2, value/2 ] ). %% RS-141105  General (semantic) Operators,
                                %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .
%% RS-131227    UNIT: tuc/
:-use_module( '../tuc/lex.pl', [ maxl/1, txt/3 ] ). %% RS-140207, extra?  maxl/1 is used where?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Consensical Grammar Runtime Predicates

% 'C'([C|Y],C,Y).  %% Standard DCG

% LITERALS

% Read literal constant from stack

cc(U,UW,W,X,Y) :-
    virtual([U],_,UW,W,X,Y). %% TA-060318

% Read  literal constant from text


cc(U,X,X,UW,W) :-
   \+ frontgap(X),
    txt(UW,w(_,[U]),W),    %% RS-160109. "A. Jenssens vei" m� ikke bli "� ...". Fiks i gram_n.pl
    upcur(W).          % UPDATE * position in any error message

word(U,X,X,UW,W):-        %% Reads the word as is
   txt(UW,w(U,_),W), 
   upcur(W).

% CODED WORDS

% Read from stack
% w( .. ) is not produced as virtual

w(U,T,UW,W,X,Y) :-
      virtual(w(U),T,UW,W,X,Y). %% TA-060318  Experiment  

% Read from text

w(U,U,X,X,UW,W):- 
   \+ frontgap(X), %%%%% \+ nogap(X),      %% TA-040809 
    txt(UW,w(_,U),W),    % Experiment (Dont advance pointer if fail)
    upcur(W).            % UPDATE * 
                         % An error message can never come too early

upcur(N) :-
        value( cursor, M ),
         N > M  ->
         set(cursor,N);  
         true.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

frontgap([gap(_,first)|_]). 
frontgap([gap(_,exact)|_]).



virtual(P,'< >'(Q),X,Y,V,V):- 
    popstack(P,X,Y),
    compute_gap_item(P,Q).



compute_gap_item(P,Q):-            %% put gap head into synt tree
   (P = w(Word) -> P1=Word;P1=P),
   (P1 = npgap(_V:T) -> P2=T; P2=P1),
   (var(P2) -> P21=var;P21=P2), %% hva er klokken // anomaly trap
   (P21 =..[P3|_],atom(P3) -> P4=P3;P4=P21),   
   (atom(P4) -> Q=P4;Q=nil).

popstack(V,[gap(V,_)|W],W). 


pushstack(Sign,BC,nil,X1,X3,T1,T1):-
    pushstack1(Sign,BC,X1,X3).       

pushstack1(Sign,(B,C),X1,X3):-!,      % , is right associative
    pushstack1(Sign,C,X1,X2),
    pushstack1(Sign,B,X2,X3).

pushstack1(Sign,B,OldX,[gap(B,Sign)|OldX]).


lock(Sign,GS,[gap(lock,Sign)|GS],X,X).

unlock([gap(lock,_)|GS],GS,X,X). 




%% Added argument for parse_tree

end_of_line(nil,[],[],Z,Z):-  %% Absolute end of line 
    maxl(Z).             %% empty stack

end_of_line0(nil,K,K,Z,Z):-  %% End of line, no empty-check
    maxl(Z).            %% TA-110127

skip_rest(nil,_,[],_,Z):-
    maxl(Z).  

check_stop(nil,[],[],X,X). %% True if nothing left on stack


%%  LOOK AHEAD WITHOUT READING

look_ahead(w(F),nil,X,X,Y,Y):- 
    \+ frontgap(X),      %% (text blocked also for look_ahead)
    txt(Y,w(_,F),_).    %% RS-140924 CHECK IT OUT!!!


look_ahead(w(F),nil,X,X,Y,Y):- 
     popstack(w(F),X,_).        %% look ahead also for stack



look_ahead([F],nil,X,X,Y,Y):- 
    \+ frontgap(X),      %% (text blocked also for look_ahead)
    txt(Y,w(_,[F]),_). 


look_ahead([F],nil,X,X,Y,Y):- 
     popstack([F],X,_).        %% look ahead also for stack


%% NEW PREDICATE  LOOK AHEAD and FAIL WITHOUT READING 

/* * * *
not_look_ahead(A,B,C,D,E,F) :- %% TA-081229
    \+ look_ahead(A,B,C,D,E,F).

* * * */

not_look_ahead(w(F),nil,X,X,Y,Y):- 
    \+ frontgap(X), 
    txt(Y,w(_,F),_),
    !,fail.


not_look_ahead(w(F),nil,X,X,Y,Y):- 
     popstack(w(F),X,_),        %% look ahead w also for stack
     !,fail.


not_look_ahead([F],nil,X,X,Y,Y):-  %% TA-081229
     popstack([F],X,_),        %% look ahead [ ]also for stack
     !,fail.


not_look_ahead([F],nil,X,X,Y,Y):- 
    \+ frontgap(X), 
    txt(Y,w(_,[F]),_),
    !,fail.

%%  unnec or wrong %% TA-081229
%% not_look_ahead([F],nil,X,X,Y,Y):- 
%%     txt(Y,w(_,[F]),_),
%%     !,fail.
%% 


not_look_ahead(_,nil,X,X,Y,Y). %%



%%%%% THE END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

