%% FILE utility.pl
%% SYSTEM TUC
%% CREATED TA-921106
%% REVISED TA-100225

%% Utility Routines that are (not?) built in 

%% USAGE: 
%:- use_module( '../utility/utility', [ ] ). %% RS-140208. Includes user:declare, and GRUF (fernando) %% :-op( 714,xfx, := ).

%%% RS-131225, UNIT: utility, %% FOR metacomp, makeauxtables.pl
:-module( utility, [ absorb/3, aggregate/3, all/1, ans/1, appendfiles/3, append_atomlist/2, append_atoms/3,  %% RS-141025 Move to main: (:=)/2, (=:)/2, 
        bag_of/3, begins_with/3, bound/1, breakpoint/2, charno/3, %% FOR busanshp.pl
        compar/3, debug/2, default/2, deleteall/3, divmod/4, (do)/1, doall/1, ends_with/3, equal/2, error/2, firstmem/2, flatlist/2, fnuttify1/2, fnuttify2/2, for/2,     
        
        delete1/3, featurematch/4, featurematchlist/2, flatten/2, maximum/2, mergeavlists/3, minimum/2,  
        do_count/1, freshcopy/2, subsumes/2,     %% RS-140927 For translat.pl
        foralltest/2, ident_member/2, implies/2, internalkonst/1, iso_atom_chars/2, last_character/2, lastmems/3, listlength/2, makestring/2, matchinitchars/2,
        flatround/2 /*interapp*/,  %% remove_duplicates/2 /*lex*/,
        lastmem/2, maxval/3, minval/3, nth/3, set_of/3, set_ops/3, test/1, 
        measurecall/2, members/3, naive/0, newconst/1, number_of/3, number_to_string/2, outputlist/1, pling/1, pront/1, psl/2, 
        occ/2, once1/1, match/2, matchinitchars/3, purge/3, roundreverse/2, sequence_member/2, unbound/1,
        replacelist/4,
        replace/4, roundrecmember/2, sequence_flatten/2, sequence_reverse/2, set_difference/3, set_eliminate/4,
        set_filter/4, set_union/3, shell_copyfile/2, snipfirst/2,  sniplast/2, splitlast/3, spyoncondition/2, split/4,
        startbatch/0, starttime/0, starttimebatch/0, stoptimebatch/0, subcase/2, taketime/0, testmember/2, textlength/2, timeout/3, tryonce/1,
        unsquare/2, union/3, writelist/1, writenumber2/2   ] ).    %% RS-140927 For busanshp.pl. Moved to declare.pl: set/2, value/2, ?

%% RS-140927 And then some unused?
%% RS-140927 For teledat2.pl transfix/2, variant/2,  append_atomlist/2, append_atoms/3, %code_chars/2, coerce2d/2, concat_atomlist/2, moved to datecalc! %% RS-140921
%       doubt/2 (main.pl, busanshp.pl)?, lastmem/2, match/2, %%listlength/2 (builtin?), maxval/3, minval/3, nth/3, %% RS-131227 ...main.pl out/1,
%       numbervrs/1 (interapp/pragma), subsum1/2, test/1, trace/2, traceprog/2, track/2, trackprog/2, writeZ/1,
%%RS-131228 for/2 is used by these: (Moved to writeout.pl) out/1, output/1, prettyprint/1, identical/2, sequence_write/1, roundwrite/1, writepred/1, %RS-140921 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%META-PREDICATES!
%% LIST OF ALL META_PREDICATES: (do)/1, bag_of/3, for/2, foralltest/2, implies/2,  number_of/3, once1/1, set_of/3, set_ops/3, , test/1, tryonce/1, ...?
%% META_PREDICATES SECTION, %% RS-140101 meta_predicates    : means use source module       + means use this (utility) module  for expansion %% RS-131231 %From utility.pl
%% RS-140101 meta_predicates expansion    : source module       + this(utility) module          0 source (zero supressed arguments)     ? in/out?

:- meta_predicate  bag_of(+,0,+) . %% EE-150209
:- meta_predicate  breakpoint(+,0).   %% RS-100101 ?  %% NEW PREDICATE
:- meta_predicate  debug(0,+).   %% RS-100101 ?  %% NEW PREDICATE
:- meta_predicate  do(0) .
:- meta_predicate  doall(0) .   %% RS-141019     doall/1 (Goal_0) . Zero input arguments for Goal_0 % doall(P): (P, then succeed)
:- meta_predicate  for(0,0).  %% for(0,:).  %% for/2. Stay inside interapp? %% RS-140619
:- meta_predicate  foralltest(0,0) .
:- meta_predicate  implies(0,0).
:- meta_predicate  measurecall(0,+) , measurecall1(0,+) .
:- meta_predicate  number_of(+,0,+) . %% RS-140211      % set_ops/3
:- meta_predicate  once1(0).
%:- meta_predicate  remember(0) .        %% RS-140928 Remember the facts IN THE MODULE THAT CALLS REMEMBER! Use  :  or  0
:- meta_predicate  set_ops(+,0,-).
:- meta_predicate  set_eliminate(+,0,-,-).
:- meta_predicate  set_filter(+,0,-,-).
:- meta_predicate  set_of(+,0,+) . %% RS-140211      % set_ops/3 
:- meta_predicate  spyoncondition(0,+) . %% RS-140211
:- meta_predicate  timeout( 0, +, ? ).
:- meta_predicate  test(0) . %% RS-140211
:- meta_predicate  tryonce( 0 ).

%:- meta_predicate  roundappend(0,0,?).          %% RS-141005   These two are moved back to pragma.pl
%:- meta_predicate  sequence_append(0,0,-).          %% RS-141005
%:- meta_predicate  sequence_member(?,0) .      %% RS-140617 -140927 -141018
%:- meta_predicate  occ(?,0) .      %% RS-140617 -140927 -141018

% test(+).  Moved to pragma... %% RS-140102 ??
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% RS-111205, UNIT: /

%(:=)/2, %% RS-131225 Set user:value  %(=:)/2 %% RS-131225 Get user:value  %set/2, user:value/2, %% RS-140101 Moved to declare for early compiling!
:- use_module( '../declare', [ ( := )/2, ( =: )/2, value/2 ] ). %% RS-111213  General (semantic) Operators remember/1, 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Utility-functions %RS-141019 Moved to main.pl (To be accessable for the scripts.n)
%X := Y :-
%        user:( X := Y ).
%X =: Y :-
%        user:( X =: Y ).

%set(X,Y) :-
%        user:set(X,Y).
%value(X,Y) :-
%        user:value(X,Y).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% RS-131225, UNIT: utility/
:- use_module( '../utility/library', [ reverse/2, shell/1 ] ).%% RS-131225 remove_duplicates/2, 
:- use_module( '../sicstus4compatibility', [ out/1, output/1, remove_duplicates1/2 ] ). %% RS-141207
%:- use_module( '../utility/writeout', [ output/1 ] ).%% RS-131225

:- use_module( library( timeout ), [ time_out/3 ] ). %% RS-140210.
%DEPENDENCIES: library.pl (remove_duplicates/2)
%:- use_module( '../utility/library', [ remove_duplicates/2 ] ).%% RS-131225 %% What's this for?
%
%%%%%%%%%%%%%%%%%%RS-131228      Compile-order Matters!
%
%% RS-131227, UNIT: EXTERNAL LIBRARY
%:- use_module( library(aggregate), [ foral/2 ] ). %% RS-140210.   %% RS-141029  for-all/2 Does NOT work like utility:for/2
%:-use_module( library(process), [exec/1, shell/1] ). %% , [exec/1,shell/1] ). %% RS-131227 Investigate this ;-)
:- use_module( library(varnumbers), [ numbervars/1 ] ). %% RS-140210.

%% RS-131225, UNIT: /
:- use_module( '../sicstus4compatibility', [ get0/1 ] ). % , tab/1 ] ).  %% Compatible with sicstus4, get0/1 etc.
%MISERY!!
%:- use_module( '../main', [ (:=)/2, (=:)/2, value/2 ] ). %% Loops back here in the for-predicates etc. e.g. for (A => B)
%% RS-130329 Make sure (gram/lang) modules are available before this point (e.g. dcg_modules),

%% RS-111205, UNIT: app/
%:- use_module( '../app/buslog', [ station/1 ] ).  %% RS-130210, 140210 called in for-predicate (bound/1, bus/1,...), set_filter/3, set_ops/4, etc... Maybe move them to buslog instead?

%:- use_module( '../app/busanshp.pl', [ memberids/3  ] ).  %% RS-140921 called in for-predicate     bound/1, bus/1,

%%  Read a sentence into a list of symbols      %% RS-140101, Compile danger?
:- use_module( '../tuc/readin', [ read_in/1 ]). %% ask_user/1, in user: prompt!


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

occ( _, B ) :- var( B ), ! .
occ( B, (B,_) ) .
occ( B, (_,D) ) :- occ( B, D ) .
occ( B, B ) :- \+ ( B = (_,_) ) .

%occ( _, _:B ) :- var( B ),!.
%occ( B, _:(B,_) ).
%occ( B, Module:(_,D) ) :- occ( B, Module:D ).
%occ( B, _:B ) :- \+ ( B = (_,_) ).
%
sequence_member( X, Y ) :-
   occ( X, Y ). %%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
breakpoint(Pred,Prop):- %% New Predicate Delayed Dynamic set spypoint
    value(panic,true)->
    (call(Prop) -> spy Pred;true);
    true.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
debug(Prop,Text):- 
    value(trace,4) ->
    (call(Prop) -> output(Text);true)
    ;
    true.
pling(I) :- output( pling(I) ). %%  Debug
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
do(P):- \+ ( \+ P). 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
doall( P ) :-  % P, then succeed
    P,
    false ;
    true.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% meta_predicate  for(0,0). % for/2. Stay inside the CALLING module? %% RS-141029
for( P, Q ) :- %% For all P, do Q (with part of P). Finally succeed
  P, Q, false ; true.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% meta_predicate
foralltest(P,Q):- \+ ( P, \+ Q). 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
measurecall(P,N):-
   statistics(runtime,[T1,_]),
   measurecall1(P,N),
   statistics(runtime,[T2,_]),  

   Avg is (T2-T1)/N,

   nl,
   out('Avg = '),out(Avg),output(' ms.').
%%%
measurecall1( P, N ) :- N >0, call( P ), fail.
measurecall1( P, N ) :- N >0, M is N-1, measurecall1( P, M ).
measurecall1( _, 0 ) :- ! .

% Prolog's bagof is baroque %%
bag_of( X, Y, Z ) :-
    bagof( X, Y^Y, Z ), ! ;
    Z = [].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% member(X,[X|_]). % member(X,[_|Y]):-member(X,Y).   %BUILT-IN?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prologs setof is baroque %% 
set_of( X, Y, Z ) :-           %%
    setof( X, Y^Y, Z ), ! ;     %% Trick to avoid alternatives
    Z=[].                 %% What is wrong with empty sets ?
number_of(X,Y,N):- 
    set_of(X,Y,Z),
    length(Z,N).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
once1(P) :- P, ! . %% same as once, but version independent
                   %% try once, otherwise FAIL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sequence preserving setof, ( first occurrence stays first)
set_ops(X,Y,Z):-
    findall(X,Y,Z1),
    remove_duplicates1(Z1,Z). %% order-preserving

set_eliminate(X,Predicate,List1,List2):- 
    set_ops( X, ( member(X,List1), \+ Predicate ), List2 ).

set_filter(X,Predicate,List1,List2):-
    set_ops( X, ( member(X,List1), Predicate ), List2 ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
spyon(_).
spyoncondition( Cond, Mess ):-
    call(Cond),
    spy spyon,
    spyon(Mess). 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
test(X):- \+ ( \+ ( X)).        %% Calls test(nostation(Y)), test("X ako Y"), among other things, so: make it local in metacomp-> dcg_?.pl
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% timeout WITHOUT _
timeout(     S, _L, success):-  %% If timeout doesn't work
    value(notimeoutflag,true), 
    !,
    call(S).
timeout(     S, L, Success) :-
    time_out(     S, L, Success).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tryonce(P):-P,!. %% try once, otherwise SUCCESS
tryonce(_).     %% SUCCESS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%:- use_module( '../app/buslog', [  internalkonst/1   ]).     %% RS-131225    For telelog.pl 'sk(_).'
% Hjelpepredikat
internalkonst( sk(_) ).

bound(X) :- \+ unbound(X).

unbound( X ) :- var(X),!.
unbound( free(_) ) :- !.
unbound( X ) :- internalkonst(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% panic(_H). %% just for comment-predication

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FOR SECTION
% RS-131228      Compile-order Matters!  "for" needs access to all the predicates it's called with? (use meta_predicate!) %% RS-140927

%% RS-111205, UNIT: db/
%:-use_module( '../db/timedat' ). %% , [ orig_named_date/2 ]). "for" Called from timedat!   %% Time data for bus routes (in general)
%:-use_module('../tuc/lex', [ blockmark/1, ctxt/3, exmatchcompword/2, matchcompword/2, txt/3 ] ). %assertnewtxt/3, lex.pl uses it!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% problematic for-loops?
%:- use_module( library(aggregate), [ forall/2 ] ).      %% RS-140928
%listall( P ) :- forall( call(P), output(P) ).

pront(L):-
    nl,
    for(member(X,L),output(X)),
    nl.

writelist(Z):-
    for(member(X,Z),out(X)).

outputlist(Z):-   
  for(member(X,Z),output(X)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Find nth element                           %% TA-030922
nth(N,Set,Nth) :- 
         nth_aux(N,Set,Nth,1).

nth_aux(N,[Nth|_],Nth,N).
nth_aux(N,[_|R],Nth,C) :-
         CN is C+1,
         nth_aux(N,R,Nth,CN).

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


divmod(YYYYMMDD,N0000,YYYY,MMDD) :- 
    number(YYYYMMDD), 
    YYYYMMDD >= 0,
    YYYY is YYYYMMDD // N0000,
    MMDD is YYYYMMDD mod N0000.

starttimebatch :- %% TA-100111
    statistics(runtime,[T,_]),
    ( batchstart := T ).

startbatch :- 
    statistics(runtime,[T,_]),
    ( batchstart := T ).

stoptimebatch :-  %% TA-100111
   takebatch.

takebatch :-
   statistics(runtime,[T2,_]),
   ( batchstart =: T1 ),
   Elapse is (T2-T1),
   out('Total: '),out(Elapse),output(ms). %% TA-980115
%   output('Total: '), output(Elapse), output(ms). %% TA-980115

starttime :-  
    statistics(runtime,_).

taketime :- 
   statistics(runtime,[_,T]), 
   out(T), output(ms).




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







shell_copyfile(S,D):- 

     append_atomlist(['cp ',S,' ',D],CMD),

     shell(CMD). 



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




%% Sequence preserving filter 

set_difference(List1,List2,List):- 
    nonvar(List1),
    nonvar(List2),
    set_ops(X, (member(X,List1), 
             \+ member(X,List2)),List).



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


% List all possible X, finally succeed
all(X) :- 
    output(X),
    fail ; true.

% List all possible X, finally succeed
ans(X) :-
    output(X),
    fail ; true.

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
    (N == 0 -> X is 0.0; 
              X is S/N).

aggregate(number,L,X):- 
    length(L,X).


% append([],A,A). 
% append([X|Y],U,[X|V]):-
%    append(Y,U,V).


appendfiles(A,B,C):-
    %%tell(C),  %% For other prologs than UTF-8 compatible Sicstus       %% RS-121121
    open( C, write, Stream, [encoding('UTF-8')] ),
    set_output(Stream),
    see(A),
    proclaim,
    (seen),
    see(B),
    proclaim,
    (seen),
    told.       %% RS-121121


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


%% ad hoc %% TA-11xxxx
convert_expression_to_atom(X,Y):- 
   X = (Nardoveien - NR1),
   !,
   append_atomlist([Nardoveien,'-', NR1],Y).
    
%% ad hoc %% RS-150815
convert_expression_to_atom(X,Y):-
   X = (date(Year,Month,Day)),
   !,
   append_atomlist( [ Year,'-',Month,'-',Day ], Y ).
    

convert_expression_to_atom( _, ' ?convert? ').






compar(after,X,Y) :-
   number(X),number(Y), X > Y .

compar(before,X,Y):- 
   number(X),number(Y), X < Y .


default(V,E):- 
    V=E,!;
    true.


%% avoid conflict with SWI (other parameter sequence)

delete1(X,[X|Y],Y).  
delete1( X, [U|V], [U|W] ) :-
    delete1( X, V, W ).

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


do_count(F):- 
    ( F =: M ),
    !,
    N is M+1,
    ( F := N ).

do_count(F):- 
    ( F := 1 ). 

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


%identical( A, B ) :-
%    test( (numbervars( (A,B) ), A=B) ).


newconst(Y):- 
    do_count(const), % const := const+1
    ( const =: Y ).


%% if N exceeds length, take what you have   (Pragmatix)

members(N,[A|RA],[A|RB]) :-
         N>0,
         M is N-1,
         members(M,RA,RB).

members(N,[],[]) :-
         N>0,
    !.

members(0,_,[]).


memberids( N, Deps1, Deps2 ) :-
    members( N, Deps1, Deps2 ).


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




match(X,Y):- % unidirected unification
    nonvar(X),
    !,
    X=Y.

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
        
% round membership with recursion % i flatten + roundmember

roundrecmember(X,Y):-occrec(X,Y).

occrec(_,B):-var(B),!,fail. %% Serious
occrec(B,((C,D),E)):-!,
    occrec(B,(C,(D,E))).

occrec(B,(B,_)).
occrec(B,(_,D)):-occrec(B,D).
occrec(B,B):- \+ (B=(_,_)).


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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Lexical Parse of a String (String to Token)

psl(S,L):-
    %%tell('tore_amble.e'),    %% RS-121121
    open( 'tore_amble.e', write, Stream, [encoding('UTF-8')] ),
    set_output(Stream),
    write(S),
    nl,
%%    write('.'),nl,
    told,
    see('tore_amble.e'),
    read_in(L),
    (seen).




%% append the elements in Y that are not in X, preserve sequence

absorb(X,Y,Z):-
    set_ops(U,(member(U,X);member(U,Y)),Z).


union(X,Y,Z):- 
    set_of(U,(member(U,X);member(U,Y)),Z).


%variant(X,Y):-   
%    subsumes(X,Y),
%    subsumes(Y,X).
%
subsumes(X,Y):-   % X at least as general
     test(subsum1(X,Y)).
%
subsum1(X,Y):-
     numbervars(Y),
     X=Y.
%
subcase(Y,X):-     
    subsumes(X,Y),  %% no variable is instantiated
    X=Y.            %% to a structure

unsquare([P],P):-!.
unsquare([P,Q|R],(P,QR)):-
    unsquare([Q|R],QR).
unsquare([],true).  

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


%%testmember(Member, Group/List) %%RS-130210
testmember( _, V) :- var( V ), !, fail. 
testmember( Member, List) :-
     test( member(Member, List) ).        %testmember(X,Z) :-  test(member(X,Z)).




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
%OLD STUFF, extra? 
%:- meta_predicate   for(0,0), once 1(:), set_ops(+,:,+), test(:), % doall(:) %% RS-131231 Moved to declare/evaluate etc.  
%do/1, foralltest/2, number_of/3, set_of/3, set_ops/3, tryonce/1  ] ).

