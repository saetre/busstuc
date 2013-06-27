%% FILE dagrun_n.pl
%% SYSTEM TUC
%% AUTHOR T.Amble
%% CREATED TA-950728
%% REVISED TA-110127




% English  clone of runtime routines in gram_n.pl

 :-module(dcg_e,[cc/5, check_stop/5, end_of_line/5, end_of_line0/5, lock/5, look_ahead/6, not_look_ahead/6, 
                 pushstack/7, pushstack1/4, skip_rest/5, unlock/4, w/6, word/5]).

 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Consensical Grammar Runtime Predicates

% 'C'([C|Y],C,Y).  %% Standard DCG

% LITERALS

% Read literal constant from stack

cc(U,UW,W,X,Y):-
    virtual([U],_,UW,W,X,Y). %% TA-060318

% Read  literal constant from text


cc(U,X,X,UW,W):- 
   \+ frontgap(X),
    user:txt(UW,w(_,[U]),W),
    upcur(W).             % UPDATE *  


word(U,X,X,UW,W):-        %% Reads the word as is
   user:txt(UW,w(U,_),W), 
   upcur(W).

% CODED WORDS

% Read from stack
% w( .. ) is not produced as virtual

w(U,T,UW,W,X,Y):- 
      virtual(w(U),T,UW,W,X,Y). %% TA-060318  Experiment  

% Read from text

w(U,U,X,X,UW,W):- 
   \+ frontgap(X), %%%%% \+ nogap(X),      %% TA-040809 
    user:txt(UW,w(_,U),W),    % Experiment (Dont advance pointer if fail)
    upcur(W).            % UPDATE * 
                         % An error message can never come too early

upcur(N):-
        (user:value(cursor,M),
         N > M  ->
         user:set(cursor,N);  
         true).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

frontgap([gap(_,first)|_]). 
frontgap([gap(_,exact)|_]).


virtual(P,'< >'(Q),X,Y,V,V):-  %% TA-080925
    popstack(P,X,Y),
    compute_gap_item(P,Q).


compute_gap_item(P,Q):-            %% put gap head into synt tree
   (P = w(Word) -> P1=Word;P1=P),
   (P1 = npgap(_V:T) -> P2=T; P2=P1),
   (var(P2) -> P21=var;P21=P2), %% hva er klokken // anomaly trap
   (P21 =..[P3|_],atom(P3) -> P4=P3;P4=P21),   
   (atom(P4) -> Q=P4;Q=nil).


%% virtual(P,gap,X,Y,V,V):-  %% TA-060318    
%%     popstack(P,X,Y).

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
    user:maxl(Z). 

end_of_line0(nil,K,K,Z,Z):-  %% End of line, no empty-check
    user:maxl(Z).            %% TA-110127

skip_rest(nil,_,[],_,Z):-
    user:maxl(Z).  

check_stop(nil,[],[],X,X).  %% True if nothing left on stack 

%%  LOOK AHEAD WITHOUT READING

look_ahead(w(F),nil,X,X,Y,Y):- 
    \+ frontgap(X),      %% (text blocked also for look_ahead)
    user:txt(Y,w(_,F),_). 


look_ahead(w(F),nil,X,X,Y,Y):- 
     popstack(w(F),X,_).        %% look ahead also for stack



look_ahead([F],nil,X,X,Y,Y):- 
    \+ frontgap(X),      %% (text blocked also for look_ahead)
    user:txt(Y,w(_,[F]),_). 


look_ahead([F],nil,X,X,Y,Y):- 
     popstack([F],X,_).        %% look ahead also for stack


%% NEW PREDICATE  LOOK AHEAD and FAIL WITHOUT READING 

not_look_ahead(w(F),nil,X,X,Y,Y):- 
    \+ frontgap(X), 
    user:txt(Y,w(_,F),_),
    !,fail.


not_look_ahead(w(F),nil,X,X,Y,Y):- 
     popstack(w(F),X,_),        %% look ahead w also for stack
     !,fail.


not_look_ahead([F],nil,X,X,Y,Y):-  %% TA-081229
     popstack([F],X,_),        %% look ahead [ ]also for stack
     !,fail.





not_look_ahead([F],nil,X,X,Y,Y):- 
    \+ frontgap(X), 
    user:txt(Y,w(_,[F]),_),
    !,fail.

/*  unnec or wrong %% TA-081229
not_look_ahead([F],nil,X,X,Y,Y):- 
    user:txt(Y,w(_,[F]),_),
    !,fail.
*/

not_look_ahead(_,nil,X,X,Y,Y). %%



%%%%% THE END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

