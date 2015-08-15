%% FILE sicstus4compatibility.pl
%% SYSTEM TUC
%% CREATED TA-071026
%% REVISED TA-080506

:-module( sicstus4compatibility, [ get0/1, get/1, out/1, output/1, prettypr/2, prompt/1, put/1, remove_duplicates1/2,
                                   tab/1, traceprog/2, ttyflush/0, 
                                   %writeanswer/1,
                                   writepred/1 ] ). %% RS-150119  progtrace/2, 

%% Sicstus 4 compatibility

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:-use_module( declare, [ language/1, value/2 ] ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% append/3  %% built-in Sicstus 4 (library.pl)

get(G) :- get_code(F),
          F = 10 -> get(G) %% CR
          ;
          G=10.

get0(G) :- get_code(G). %% TA-070809


%% member/2  %% built-in Sicstus 4 (library.pl)   

out(P) :- write(P), tab(1).     %% Moved to sicstus4compatibility!
output(P) :- write(P), nl.      %% Moved to sicstus4compatibility!

prompt( ' ' ) :-
   value(norsource,true). %% TA-110207

prompt(P):-
    language(L),
    prompt2(L,P),
    !.

prompt('?: '). % Undefined Prompt.


prompt2( english, 'E: ' ).
prompt2( norsk, 'N: ' ).

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


put(G) :- put_code(G). %%


prettypr(H,P) :- 
        write('*** '), %% drop ... %% TA-110204
   write(H),
   write(' ***'),
   nl,nl, 
   prettypr2(P).

prettypr2((X,R)) :-
        !,   
   write(X),nl,
   prettypr2(R).

prettypr2(X) :-
        write(X),nl.

%%% 


ttyflush :- flush_output(user).

tab(N):- write_blanks(N). %% ad hoc

%% same as traceprog
%progtrace( N, P ) :-
%    value(traceprog,M), number(M), M >= N, 
%    !,
%    write(P),nl
%;
%    true.

traceprog( N, P ) :- 
    value( traceprog, M ), number(M), M >= N, 
    !,
    write(P),nl
 ;
    true.


write_blanks(N):-
     N > 0,
     !,
     write(' '),
     N1 is N-1,
     write_blanks(N1).
write_blanks(_).

writepred(P) :- writeq(P),write('.'),nl. 

