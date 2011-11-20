%% FILE naive.pl
%% CREATED TA-921214
%% REVISED TA-980518

%  Test Lips rate according to Naive Reverse


% set(...  ==> aset( ...  %% TA-960730

take_time(A):-
    statistics(runtime,[A,_]). %%% SICSTUS 3.0


naive:-
   write('N = '),read(N),
   aset(N,X),
   !,
   take_time(A), 
   nreverse(X,_),
   take_time(B),
   C is B-A,
   write('Time '),write(C),write(' ms '),nl,
   LIPS is ((N*(N+1)/2)/ (C + 0.000001 ))*1000 // 1 ,
   write('LIPS = '),write(LIPS),nl.

aset(0,[]):-!.
aset(N,[a|X]):-
   M is N - 1,
   aset(M,X).




nreverse([X|U],Z):-
    nreverse(U,V),
    append(V,[X],Z). % 1+ #V

nreverse([],[]).

