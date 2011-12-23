%% FILE library.pl
%% SYSTEM TUC
%% CREATED TA-931223
%% REVISED TA-071026

:- ensure_loaded('../declare').


% Contains some utility predicates
% that may not be redefined in some Prologs (e.g. SWI-Prolog)


/* -> sicstus4compatibility.pl %% TA-071026

%% Sicstus 4 compatibility

%% append/3  %% built in Sicstus 4 (library.pl)

%% member/2  %% built in Sicstus 4 (library.pl)   

get0(G) :-get_code(G). %% TA-070809

put(G) :- put_code(G). %%

ttyflush :- flush_output(user).

tab(N):- write_blanks(N). %% ad hoc

*/


%
%append([],A,A). %% built in Sicstus 4
%append([X|Y],U,[X|V]):-
%    append(Y,U,V).
%     
%
%member(X,[X|_]). %% built in Sicstus 4
%member(X,[_|Y]):-
%    member(X,Y).
%
%%

delete(X,[X|Y],Y). 
delete(X,[U|V],[U|W]):-
    delete(X,V,W).


%% Find nth element                           %% TA-030922

nth(N,Set,Nth) :- 
	 nth_aux(N,Set,Nth,1).

nth_aux(N,[Nth|_],Nth,N).
nth_aux(N,[_|R],Nth,C) :-
	 CN is C+1,
	 nth_aux(N,R,Nth,CN).

% intersection(X,Y,Z)  Z is intersection of sets X and Y
% Preserves order of first argument
% X should be a set. (Duplicates will be copied)


%% Remove duplicates  %% Standard %% TA-030922

%% Does standard preserve order of occurrence ?

remove_duplicates([],[]):-!.    
remove_duplicates([P],[P]):-!.  
remove_duplicates([X|Y],R):-
    member(U,Y),X==U,!,
    remove_duplicates(Y,R).
remove_duplicates([X|Y],[X|Z]):-
    remove_duplicates(Y,Z).



intersection([],_,[]):-!.
intersection([X|Y],Set,Z):-
   \+ member(X,Set),
   !,
   intersection(Y,Set,Z).
intersection([X|Y],Set,[X|Z]):-
    intersection(Y,Set,Z).

not X :- \+ X. 

%% once(P):- P,!. %% THIS IS BUILT-IN   Sicstus 3.8  %% TA-000414  
%% Gives warning message  in 3.8 ++ 
%% Will be removed

reverse(L1,[]):-var(L1),!. %% Keine Experimente TA-970516
reverse(L1,L2):- 
    rev1(L1,[],L2),
    !. 

rev1([],L,L).
rev1([X|Y],L,Z):-
    rev1(Y,[X|L],Z).

%%%%% THE END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



