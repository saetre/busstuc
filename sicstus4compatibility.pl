%% FILE sicstus4compatibility.pl
%% SYSTEM TUC
%% CREATED TA-071026
%% REVISED TA-080506

:-module(sicstus4compatibility, [ get0/1, get/1, put/1, remove_duplicates1/2, tab/1, ttyflush/0 ] ). %% RS-131227

%% Sicstus 4 compatibility

%% append/3  %% built-in Sicstus 4 (library.pl)

%% member/2  %% built-in Sicstus 4 (library.pl)   

%%built in Sicstus 4 (library.pl), but doesn't really work in sicstusProlog!!
%% remove_duplicates  Standard  -> library
remove_duplicates1(X,Y):-   % preserves order of first occurrence
    rem_dups(X,[],Y).

rem_dups([],_,[]):-!.

rem_dups([X|Y],Keep,[X|Z]):-
     \+ member(X,Keep),
    !,
    rem_dups(Y,[X|Keep],Z).
rem_dups([_|Y],Keep,Z):-
    rem_dups(Y,Keep,Z).


get(G) :- get_code(F),
          F = 10 -> get(G) %% CR
          ;
          G=10.

get0(G) :- get_code(G). %% TA-070809

put(G) :- put_code(G). %%

ttyflush :- flush_output(user).

tab(N):- write_blanks(N). %% ad hoc

write_blanks(N):-
     N > 0,
     !,
     write(' '),
     N1 is N-1,
     write_blanks(N1).
write_blanks(_).
