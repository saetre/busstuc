%% FILE utility.pl
%% SYSTEM TUC
%% CREATED TA-921106
%% REVISED TA-100225

%% Utility Routines that are not built in 

:- ensure_loaded( '../sicstus4compatibility' ). %, [ get0/1, tab/1 ] ).  %% Compatible with sicstus4, get0/1 etc.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% panic(_H). %% just for comment-predication

%% Character no Index in string String
charno(Index,String,Char) :- %% TA-090618
     atom(String), %% not 0  %% TA-090622
     atom_codes(String,XASC),
     nth(Index,XASC,Code),
     char_code(Char,Code).
     


fnuttify1(K,L) :- %% surround single %% TA-100225
    name(K,KS),
    append([39],KS,K1), %% ''''
    append(K1,[39],L1),
    name(L,L1).


fnuttify2(K,L) :- %% surround single %% TA-100225
    name(K,KS),
    append([34],KS,K1), %% ''''
    append(K1,[34],L1),
    name(L,L1).



number_to_string(X,XS):- %% (no preceding blanks)
      name(X,XL),
      atom_codes(XS,XL).


%write_blanks(N):-  %% RS-111212 Moved to sictus4_compatability.pl
%     N > 0,
%     !,
%     write(' '),
%     N1 is N-1,
%     write_blanks(N1).
%write_blanks(_).
%
spyon(_).

spyoncondition(Cond,Mess):-
    call(Cond),
    spy spyon,
    spyon(Mess). 



divmod(YYYYMMDD,N0000,YYYY,MMDD) :- 
    number(YYYYMMDD), 
    YYYYMMDD >= 0,
    YYYY is YYYYMMDD // N0000,
    MMDD is YYYYMMDD mod N0000.

numbervars(F):-
    numbervars(F,0,_).

starttimebatch :- %% TA-100111
    statistics(runtime,[T,_]),
    batchstart := T.

startbatch :- 
    statistics(runtime,[T,_]),
    batchstart := T.

stoptimebatch :-  %% TA-100111
   takebatch.
takebatch :-
   statistics(runtime,[T2,_]),
   batchstart =: T1,
   Elapse is (T2-T1),
   out('Total: '),out(Elapse),output(ms). %% TA-980115

starttime :-  
    statistics(runtime,_).

taketime :- 
   statistics(runtime,[_,T]), 
   out(T),output(ms).



timestring(Z):- %% creates a string of time-point YYYYMMDDHHMMSS
    datetime(X1,X2,X3,X4,X5,X6),
    coerce2d([X1,X2,X3,X4,X5,X6],[D1,D2,D3,D4,D5,D6]),
    concat_atomlist([D1,D2,D3,D4,D5,D6],Z),
    !.
timestring('00000000000000').
%           YYYYMMDDHHMMSS


datestring(Z):- %% creates a string of date  YYYYMMDD
    datetime(X1,X2,X3,_X4,_X5,_X6),
    coerce2d([X1,X2,X3],[D1,D2,D3]),
    concat_atomlist([D1,D2,D3],Z),
    !.
datestring('00000000').
%           YYYYMMDD



%% NEW PREDICATE

iso_atom_chars(X,Y):-
    atom(X),
    var(Y),
    atom_codes(X,XASC), %% common in S3/S4 
    convcodetocharacters(XASC,Y).

iso_atom_chars(X,Y):-
    var(X),
    nonvar(Y),
    convcodetocharacters(XASC,Y),
    atom_codes(X,XASC). %% common in S3/S4
  
convcodetocharacters([],[]). %% works both ways
convcodetocharacters([X|Y],[C|D]):-
    name(C,[X]),
    convcodetocharacters(Y,D).




coerce2d([X|Y],[X1|Z]):-
    coerc2d(X,X1),  
    coerce2d(Y,Z).
coerce2d([],[]).

%% Prolog is really stupid here

%% number to fixed length character sequence

coerc2d(D,DD)  :- 
    number(D),
    !,
    name(D,KLIST),
    code_chars2(KLIST,Clist),
    concat_atomlist(Clist,DD).

code_chars2(KLIST,Clist):-
   code_chars(KLIST,DD),
   (
   DD=[D1] -> Clist= ['0',D1];
              Clist=DD
   ).

code_chars([X|Y],[X1|Y1]):- %% ad hoc   8 -> 08, ellers likt
    char_code(X1,X), %% nb
    code_chars(Y,Y1).     

code_chars([],[]).




%% FOLLOW DIRECTLY AFTER

follow_sequence(_A,_B,V):-var(V),!,fail.

follow_sequence(A,B,(A,B)):-!.

follow_sequence(A,B,(A,B,_)):-!.

follow_sequence(A,B,(_X,Y)):- 
   follow_sequence(A,B,Y).   


%% FOLLOW SOMEWHERE  AFTER 


follow_after(AA,BB,V):-
    (var(V);var(AA);var(BB)),
    !,fail.

follow_after(A,B,(A1,C)):- 
    nonvar(A1),
    A=A1,
    !,
    sequence_member(B,C).

follow_after(A,B,(_X,Y)):- 
   follow_after(A,B,Y).   


shell_copyfile(S,D):- 

     append_atomlist(['cp ',S,' ',D],CMD),

     shell(CMD). 



sequence_write(X):-roundwrite(X). %% New name, more standard

roundwrite(nil):-!. %% catches var
roundwrite((X,Y)):-!, out(X),roundwrite(Y).
roundwrite(X):-!, out(X).



mergeavlists([A1|A],[V1|V],[A1=V1|Z]):-
   mergeavlists(A,V,Z).
mergeavlists([],[],[]).



featurematchlist([A=V1|Z1],AVS):-
    member(A=V,AVS),
    matchinitchars(1,V1,V),
    featurematchlist(Z1,AVS).

featurematchlist([],_).



featurematch(A,[A|_],[V|_],V).
featurematch(A1,[_|Attributes],[_|Values],V1):-
    featurematch(A1,Attributes,Values,V1).
  

matchinitchars(N,X,Y):- 
    atom(X), X \== [], % ''
    atom(Y), Y \== [], % ''
    atom_chars(X,XL),
    length(XL,N1),N1 >= N,
    atom_chars(Y,YL),
    append(XL,_,YL),
    !.


matchinitchars(X,Y):- %% match(amb,amble).
    atom(X), X \== [], % ''
    atom(Y), Y \== [], % ''
    atom_chars(X,XL),
    atom_chars(Y,YL),
    append(XL,_,YL),
    !.


measurecall(P,N):-
   statistics(runtime,[T1,_]),
   measurecall1(P,N),
   statistics(runtime,[T2,_]),  

   Avg is (T2-T1)/N,

   nl,
   out('Avg = '),out(Avg),output(' ms.').

measurecall1(P,N):-N >0,call(P),fail.
measurecall1(P,N):-N >0, M is N-1,measurecall1(P,M).
measurecall1(_,0):-!.




%% Sequence preserving filter 

set_difference(List1,List2,List):- 
    nonvar(List1),
    nonvar(List2),
    set_ops(X, (member(X,List1), 
             \+ member(X,List2)),List).



set_filter(X,Predicate,List1,List2):-
    set_ops(X,(member(X,List1),Predicate),List2).


set_eliminate(X,Predicate,List1,List2):- 
    set_ops(X,(member(X,List1),\+ Predicate),List2).

%% Sequence preserving  union

set_union(List1,List2,List3) :- 
     set_ops(X, (member(X,List1);member(X,List2)),List3).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Some predicates are moved to library.pl
% to ease compatibility with prologs where these are built in
%
%  append/3 , member/2 , reverse/2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% dif(X,Y)  DELAY DIFFER  (built-in)
% freeze(X,P) DELAY P until X fixed
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

X := Y :- 
    set(X,Y).

X =: Y :-  
    value(X,Y). 




all(X):- 
    output(X),
    fail.

ans(X):-
    output(X),
    fail.

aggregate(min(+ N),L,L1):-
    firstlist1(N,L,L1).

aggregate(min(- N),L,X):-
    !,
    nthval(N,L,X).

aggregate(max(+ N),L,X):-        %% not stable, original order swapped
    !,
    reverse(L,L1),             %% Advanced Reverse
    firstlist1(N,L1,X). 


aggregate(max(- N),L,X):-      
    !,
    reverse(L,L1),             
    nthval(N,L1,X). 


aggregate(sum,L,X):-  
    sumcount(L,X,_).

aggregate(avg,L,X):-  
    sumcount(L,S,N),
    (N =:= 0 -> X is 0.0; 
              X is S/N).

aggregate(number,L,X):- 
    length(L,X).


% append([],A,A). 
% append([X|Y],U,[X|V]):-
%    append(Y,U,V).


appendfiles(A,B,C):-
    tell(C),
    see(A),
    proclaim,
    seen,
    see(B),
    proclaim,
    seen,
    told.


proclaim:-
    repeat,
    get0(C), 
    (C = -1  -> true, ! ; %  end_of_file
                put_code(C),fail).



%

sumcount([],0,0.0).
sumcount([X- _Y|R],S,N):-
    sumcount(R,S1,N1),
    N is N1 +1,
    S is S1 +X.


% % % % % % % % % % % % % % 


concat_atomlist([X1|Y],Z):-
    concat_atomlist(Y,Y1),
    atom_concat(X1,Y1,Z).
concat_atomlist([],'').

concat_atomlist([A],A):-!. 
concat_atomlist([A,B],C):-!,
    atom_concat(A,B,C).
concat_atomlist([A|B],C):-
    concat_atomlist(B,B1),
    atom_concat(A,B1,C).


append_bl_atoms(A,B,C):-  %% append atoms with a blank
    atomname(A,AL),         
        name(' ',H), 
        append(AL,H,ALH),
    atomname(B,BL),
    append(ALH,BL,CL),
    name(C,CL).   %% <-


append_atomlist([A],A):-!.  
append_atomlist([A|B],AB):-
    append_atomlist(B,B1),
    append_atoms(A,B1,AB).



append_atoms(A,B,C):-  
    atomname(A,AL),
    atomname(B,BL),
    append(AL,BL,CL),
    name(C,CL).  %% <- %% name(94451, [32,57,52,52,53,49]). %% leading blanks


atomname(X,L):-atom(X),!,name(X,L).

atomname(X,L):-number(X), 
    !,
    name(X,L).


    

atomname(X,L):-  
    \+ atom(X),
    convert_expression_to_atom(X,Y),
    name(Y,L). 

convert_expression_to_atom(X,Y):- %% ad hoc 
   X= (Nardoveien - NR1),
   !,
   append_atomlist([Nardoveien,'-', NR1],Y).
    

convert_expression_to_atom(_,' ? ').






compar(after,X,Y) :-
   number(X),number(Y), X > Y .

compar(before,X,Y):- 
   number(X),number(Y), X < Y .


default(V,E):- 
    V=E,!;
    true.


%% avoid conflict with SWI (other parameter sequence)

delete1(X,[X|Y],Y).  
delete1(X,[U|V],[U|W]):-   
    delete1(X,V,W).

deleteall(X,Y,Z):- delall(X,Y,Z).

delall(_,[],[]):-!.
delall(X,[X|Y],Z):-!,delall(X,Y,Z).
delall(X,[U|Y],[U|Z]):-delall(X,Y,Z).

purge(_,[],[]):-!. 
purge(Dels,[X|Y],Z):- 
    member(X,Dels),
    !,
    purge(Dels,Y,Z).
purge(Dels,[U|Y],[U|Z]):-
    purge(Dels,Y,Z).


do(P):- \+ ( \+ P). 

doall(P):-  % P, then succeed 
    P,
    false;
    true.


do_count(F):- 
    F =: M,
    !,
    N is M+1,
    F := N.

do_count(F):- 
    F := 1 . 

begins_with(AS,A,S):- 
    atom(AS),
    atom_chars(AS,[A1|S1]),
    atom_chars(A,[A1]),
    atom_chars(S,S1).


ends_with(AS,A,S):- 
    atom(AS),
    atom(S),             %% Safety Check !!! 
    !,
    name(AS,ASL),
    name(S,SL),
    append(AL,SL,ASL),
    name(A,AL),
    !.

ends_with(AS,A,S):-  
    var(AS),
    !,
    atom(A),
    atom(S),
    name(A,AL),
    name(S,SL),
    append(AL,SL,ASL),
    name(AS,ASL),
    !.

last_character(AC,C):- 
    atom(AC),
    !,
    name(AC,ABS),
    append(_,[S],ABS),
    name(C,[S]),
    !.

equal(X,Y) :- atomic(X),atomic(Y),!,name(X,XN),name(Y,YN),XN==YN.
equal(X,Y) :- X==Y.

firstlist1(1,L,X1):- 
    !,
    L = [X|_Y],
    X = _Key - X1. %% Item may be reused, no key

firstlist1(N,K,X):-
    firstlist(N,K,X).

firstlist(N,[K-X|Y],[X-K|Z]):-
    N > 0,
    !,
    M is N-1,
    firstlist(M,Y,Z).

firstlist(_,_,[]).

%% flatten(Nested,Flat)    List

flatten([],[]):- !. %% capture var

flatten([X|Y],Z):-  
    nonvar(X),
    X=[U|V],
    !,
    flatten([U|[V|Y]],Z).
flatten([[]|Y],Z):-
    !,
    flatten(Y,Z).
flatten([X|Y],[X|Z]):-
    !,
    flatten(Y,Z).




%%% Convert an unflattened round list to a flat list 

flatlist(X,[X]):-
    \+match(X,(_,_)),
    !.
flatlist(X,Y):-  %% make a 
   flat1(X,Y).   %% flat square list


flat1((X,Y),Z):-  
    match(X,(U,V)), % X nonvar
    !,
    flat1((U,(V,Y)),Z).

flat1((X,Y),[X|Z]):-
    !,
    flat1(Y,Z).

flat1(X,[X]).



sequence_flatten(V,W) :- 
    flatround(V,W). %% new name, more standard

flatround((X,Y),Z):-  
    match(X,(U,V)), % X nonvar
    !,
    flatround((U,(V,Y)),Z).

flatround((X,Y),(X,Z)):-
    !,
    flatround(Y,Z).

flatround(X,X).



for(P,Q):-
  P,Q,
  false;true.

foralltest(P,Q):- \+ ( P, \+ Q). 

forget(X):- 
    retractall(X).

error(T,X):- 
    nl,
    write('*** '),write(T),write(' '),write(X),
    nl.

freshcopy(P,Q):-         
    copy_term(P,Q).  


ident_member(X,Z):-member(Y,Z),X==Y . 

%% New Predicate 

implies(X,Y):- \+ ((X , \+ Y)). 

%% ident_member(X,[Y|_]):- 
%%    X==Y ,!.  
%% ident_member(X,[_|Y]):-
%%     ident_member(X,Y).


identical(A,B):-   
    test((numbervars((A,B)),A=B)).


newconst(Y):- 
    do_count(const), % const := const+1
    const =: Y.




remove_duplicates1(X,Y):-   % preserves order of first occurrence
    rem_dups(X,[],Y).


rem_dups([],_,[]):-!.

rem_dups([X|Y],Keep,[X|Z]):-
     \+ member(X,Keep),
    !,
    rem_dups(Y,[X|Keep],Z).
rem_dups([_|Y],Keep,Z):-
    rem_dups(Y,Keep,Z).


firstmem([X|_],X). 

lastmem([X],X):-!.  
lastmem([_|L],X) :- lastmem(L,X).     %% last ==> lastmem


lastmems(N,_List,NLast):-
    N is 0,!,NLast=[].

lastmems(N,List,[X]):-
    N is 1,!,lastmem(List,X).

lastmems(N,List,NLast):-
    reverse(List,Rist),
    memberids(N,Rist,NRist),
    reverse(NRist,NLast).




listall(P):- for(P,output(P)). 

match(X,Y):- % unidirected unification
    nonvar(X),
    !,
    X=Y.

% member(X,[X|_]).  
% member(X,[_|Y]):-
%     member(X,Y).

makestring(L,Str):- 
    makeacc(L,Str).

makeacc([],' '):-!.

makeacc([U],U):-!.

makeacc([U|V],S):-
    makacc(U,V,S).

makacc(Acc,[],Acc):-!.

makacc(Acc,[U|V],Result):-
    append_bl_atoms(Acc,U,AccU),
    makacc(AccU,V,Result).



minimum([A],A):-!. 
minimum([A,B|C],R):-
    minimum([B|C],R1),minval(A,R1,R).
minimum([],10000):-!.

minval(A,B,C):- 
( A < B -> 
  C is A
  ;
  C is B
).


maximum([A],A):-!. 
maximum([A,B|C],R):-
    maximum([B|C],R1),maxval(A,R1,R).
maximum([],-10000):-!.

maxval(A,B,C):- 
( A < B -> 

  C is B
  ;
  C is A
).




nthval(N,L,X):-
    nth(N,L,Y),
    Y = _K - X.


%% nth(N,Set,Nth) %% -> Library (Standard) 
	

number_of(X,Y,N):- 
    set_of(X,Y,Z),
    length(Z,N).


sequence_member(X,Y):-
   occ(X,Y). %%

roundmember(X,Y):-
    occ(X,Y).

occ(_,B):-var(B),!.
occ(B,(B,_)).
occ(B,(_,D)):-occ(B,D).
occ(B,B):- \+ (B=(_,_)).
 
% round membership with recursion 
% i flatten + roundmember

roundrecmember(X,Y):-occrec(X,Y).

occrec(_,B):-var(B),!,fail. %% Serious
occrec(B,((C,D),E)):-!,
    occrec(B,(C,(D,E))).

occrec(B,(B,_)).
occrec(B,(_,D)):-occrec(B,D).
occrec(B,B):- \+ (B=(_,_)).


sequence_append(A,B,C):- 
    roundappend(A,B,C).

roundappend([],B,B):-!. 
roundappend(nil,B,B):-!. %% capture var
roundappend((A,B),C,(A,D)):-!,
    roundappend(B,C,D).
roundappend(Atom,B,(Atom,B)).

%% Moved from pragma.pl 

sequence_reverse(K,L):- 
     roundreverse(K,L).

roundreverse((A,B),L2):- 
    rourev1(B,A,L2),!. 
roundreverse(A,A). 

rourev1((X,Y),L,Z):-
    rourev1(Y,(X,L),Z).
rourev1(X,L,(X,L)).

%%%%%%%%%%%%%%%%%%%%%%%%%


textlength(C,N):-name(C,A),length(A,N). 

listlength(C,N):- %% length/2  backtracks 
    nonvar(C),
    length(C,M),!,
    N=M. 
listlength(_,0).

out(P):-write(P),tab(1).

output(P):-write(P),nl.


writepred(P):-writeq(P),write('.'),nl. 


prettyprint(P):-
    numbervars(P),
    writeq(P),nl,
    false; % release bindings
    true.


doubt(A,B):-  
    language(english) -> out(A);
    language(norsk) -> out(B);
    out(A).



% Lexical Parse of a String

psl(S,L):-    
    tell('tore_amble.e'),
    write(S),
    nl,
    write('.'),nl,
    told,
    see('tore_amble.e'),
    read_in(L),
    seen.


remember(F):-F,!;assert(F).

%% remove_duplicates  Standard  -> library


set(Counter,Value):- 
    retractall(value(Counter,_)),
    assert(value(Counter,Value)).


% Prologs setof is baroque %% 

set_of(X,Y,Z):-           %% 
    setof(X,Y^Y,Z),!;     %% Trick to avoid alternatives
    Z=[].                 %% What is wrong with empty sets ?


%% Sequence preserving setof, ( first occurrence stays)


set_ops(X,Y,Z):-
    findall(X,Y,Z1),
    remove_duplicates1(Z1,Z). %% order-preserving




% starttime :-  
%    statistics(runtime,_).

% taketime :- 
%   statistics(runtime,[_,T]), 
%   out(T),output(ms).


%% append the elements in Y that are not in X, preserve sequence

absorb(X,Y,Z):-
    set_ops(U,(member(U,X);member(U,Y)),Z).


union(X,Y,Z):- 
    set_of(U,(member(U,X);member(U,Y)),Z).


variant(X,Y):-   
    subsumes(X,Y),
    subsumes(Y,X).

subsumes(X,Y):-   % X at least as general
     test(subsum1(X,Y)).

subsum1(X,Y):-
     numbervars(Y),
     X=Y.

subcase(Y,X):-     
    subsumes(X,Y),  %% no variable is instantiated
    X=Y.            %% to a structure

test(X):- \+ ( \+ ( X)).


once1(P):-P,!. %% same as once, but version independent
               %% try once, otherwise FAIL

tryonce(P):-P,!. %% try once, otherwise SUCCESS
tryonce(_). 


unsquare([P],P):-!.
unsquare([P,Q|R],(P,QR)):-
    unsquare([Q|R],QR).
unsquare([],true).  

pront(L):-
    nl,
    for(member(X,L),output(X)),
    nl.

writelist(Z):-
    for(member(X,Z),out(X)).

outputlist(Z):-   
  for(member(X,Z),output(X)).

%%%%% THE END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%  Test Lips rate according to Naive Reverse

naive:-
   write('N = '),read(N),
   makelistn(N,X),
   !,
   statistics(runtime,[A,_]),
   nreverse(X,_),
   statistics(runtime,[B,_]),
   C is B-A,
   write('Time '),write(C),write(' ms '),nl,
   LIPS is integer(((N*(N+1)/2)/ (C+0.000001))*1000),
   write('LIPS = '),write(LIPS),nl.
   
makelistn(0,[]).
makelistn(N,[a|X]):-
   M is N-1,
   makelistn(M,X).

nreverse([X|U],Z):-
    nreverse(U,V),
    append(V,[X],Z). % 1+ #V

nreverse([],[]).


replace(P,X,X,P):- 
    var(P),!.

replace(P,X,Y,Q):- % AD HOC
    freshcopy(P/X,Q/Y).

replacelist([],_,_,[]).
replacelist([A|C],A,B,[B|C]):-!.
replacelist([X|C],A,B,[X|D]):-
    replacelist(C,A,B,D).

    

snipfirst([_|L1],L1). 

sniplast(L,L1):-     
    append(L1,[_],L).


splitlast(ABC,AB,C):-append(AB,[C],ABC).



testmember(_,V):-var(V),!,fail. 
testmember(X,Z) :-
     test(member(X,Z)).



%% split(N,List,FirstN,Rest)  
%% NB fails if #List < N

split(N,List,FirstN,Rest):-
    N > 0,
    !,
    List =   [X|Z],
    FirstN = [X|Res],
    N1 is N-1,
    split(N1,Z,Res,Rest).

split(0,List,[],List).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

debug(Prop,Text):- 
    value(trace,4) ->
    (call(Prop) -> output(Text);true)
    ;
    true.

pling(I):-output(pling(I)). %%  Debug


%% NEW PREDICATE

breakpoint(Pred,Prop):- %% New Predicate Delayed Dynamic set spypoint
    value(panic,true)->
    (call(Prop) -> spy Pred;true);
    true.



writenumber2(N,X):- %% write a number with exactly N digits
   power10(K,PN),
   X < PN,
   Z is N-K,
   writeN0(Z),
   writeZ(X),
   !.


writeZ(0):-!.
writeZ(X):-write(X).


power10(0,1).
power10(1,10).
power10(2,100).
power10(3,1000).
power10(4,10000).

writeN0(N):-
   N is  0 -> true;
   N is  1 -> write('0');
   N is  2 -> write('00');
   N is  3 -> write('000');
   N is  4 -> write('0000').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

