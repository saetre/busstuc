/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE ptbwrite.pl
%% SYSTEM TUC
%% CREATED  TA-061030
%% REVISED  TA-061127
%% REVISED  RS-140914


% Make a slender syntax tree comparable to Penn Tree Bank tagging

%%UNIT: / %% RS-111218, USAGE :-use_module( ptbwrite,[ ptbwrite/1 ] ).
:- module( ptbwrite, [ alle_args/2, drucke_baum/1, drucke_baum_list/1, ptbwrite/1, shrink_tree/2, tab/1 ] ). %% RS-140914

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- meta_predicate  ana(?,?,?,-).
:- meta_predicate  berechne_pos(?,-,?,?,?,?).

%% RS-131227    UNIT: / and /utility/
%:- ensure_loaded( 'declare' ).    %% :-op( 714,xfx, := ).  etc... , track/2, trackprog/2
:- use_module( '../declare', [ track/2 ] ).      %% RS-150111. Trying to sort out compile-order.

:- use_module( '../sicstus4compatibility', [ output/1 ] ).  %% Compatible with sicstus4, get0/1 etc.

%:- use_module( main, [ track/2 ] ). %% RS-140928 Moved (back) to declare.pl hei/0,   run/0 %track(X, Y) :- user:track(X, Y) .

%:- use_module( 'utility/utility', [ output/1, prettyprint/1 ] ).  %% Module util
%:- use_module( writeout, [ output/1 ] ).  %% Module util  , prettyprint/1   , track/2


/*
En tom produksjon er rekursivt
   []
   {}
   !
   accept
   nil

   [<token>,  <empty production>]

En videreføring er å eliminere topp-noden i alle subtrær som bare har en produksjon (unnatt POS).
*/

shrink_tree(K,M):- %% TA-110207
    rewfat(K,L),
    rewprune(L,M).  

ptbwrite(time_out):- 
   !.

ptbwrite(K):- %% TA-110207
  shrink_tree(K,M),

%%  rewfat(K,L),
%%  rewprune(L,M),

  track(2, ( nl,write(M),nl,nl)),     %% TA-061027

  track(1, ( nl,nl,ptbwrite:drucke_baum_list(M), output('    '),nl)). %% TA-061027 
 
  

rewfat([Token|Rest],L):-
    rewrats(Rest,K),
    rewfat0([Token|K],L),
    !.

rewfat(X,[]):-
    rewempty(X),
    !.

rewfat(X,X). % atom


rewrats(L,K):-
   rewrats(0,L,K).  %%  we dont now if we have 1

rewrats(N,[F|R],K):-
    rewfat(F,G),
    rewrats2(N,G,R,K).

rewrats(0,[],[[]]).
rewrats(1,[],[]):-!.

   
rewrats2(N,[],R,K):- % still dont know
    !,
    rewrats(N,R,K).

rewrats2(_,X,R,[X|K]):- X \== [],
    !,
    rewrats(1,R,K).  % know we hav one

 
rewfat0([[Token],[]],[Token]):-!.
rewfat0([_Token,[]],[]):-!. % still in ratmode
rewfat0(L,L).


rewempty([]).
rewempty({}).
rewempty(nil).
rewempty(accept).
rewempty('!').

/*
rewprune([Token1,[Lit]],[Token1,[Lit]]):-!.      %% TA-100924
rewprune([Token1,lit(Lit)],[Token1,lit(Lit)]):-!.%%
*/

rewprune([_Token1,Single],R):-
    rewprune(Single,R),
    !.

rewprune([_Token1,[Token2,Single]],R):-
    !,
    rewprune([Token2,Single],R).

rewprune([Token1|List2],[Token1|LR]):-
    !,
    rewprunerest(List2,LR).

rewprune(X,X).

rewprunerest([],[]).
rewprunerest([X|Y],[XX|YY]):-
    rewprune(X,XX),   
    rewprunerest(Y,YY).

%%%%%%%%%%%%%%%%


  
%% FILE drucke_baum_list
%% SYSTEM TUC
%% CREATED Christoph Lehner 1992
/*
NAMES   Dr. Christoph Lehner    mailto:chris@cl.uni-hildesheim.de
PHONES  +5121 88 33 77 ´ +89 260 37 54
WEB-ADR http://www.uni-hildesheim.de/~chlehn
*****************************************************************
All programs are freeware, but please be honest enough to
give clear references to where they came from.
*****************************************************************

© Christoph Lehner

*/
/* Program is taken from Prolog text book
Christoph Lehner: Prolog und Linguistik. Oldenbourg, München 1992, 2. Auflage.
Out of print, now */
%% REVISED TA-061022    For Rune og Håvard?
%% REVISED TA-100922

%% :- ensure_loaded( 'sicstus4compatibility' ). %, [ get0/1, tab/1 ] ).  %% Compatible with sicstus4, get0/1 etc.
%% RS-131117: Write the needed predicates here (only) instead of in sicstus4compatibility.pl
tab(N):- write_blanks(N). %% ad hoc
write_blanks(N):-
     N > 0,
     !,
     write(' '),
     N1 is N-1,
     write_blanks(N1).
write_blanks(_).
%%%

tabx(X) :- %% Sictus Doesn take tab(-1) 
    ( X <0 -> true ; tab(X) ). %% Sicstus 4


%% Convert lists to terms 


drucke_baum_list(F):-
   F=G, %%%%   atomize(F,G), %% TA
   nl,
   drucke_baum(G).
 
x_member(X,[X|_]).

x_member(X,[_|R]):-
        x_member(X,R).

x_append([],L,L).
x_append([K|R],L,[K|R1]):-
        x_append(R,L,R1).

islist( [] ).
islist( [_|_] ).


%%  P(a,b) -> [P,a]

ana(Compo,XX,L_aussen,R_aussen):-
      \+ atom(Compo),
      \+ islist(Compo),
      !,
      Compo=..Baum,

      firstwo(Baum,Baum2),

      ana(Baum2,XX,L_aussen,R_aussen).

ana(Baum,[k(Baum,Pos)],L_aussen,R_aussen):-
                      atomic(Baum),
                      !,
                      atomic_laenge(Baum,N),
                      R_aussen is L_aussen + N + 2,
                      Pos is (R_aussen + L_aussen ) // 2 .

ana(Baum,[k(F,Pos),[k(Nachfolger,Pos)]],L_aussen,R_aussen):-
            Baum = [F,Nachfolger], %%% TA =..
            atomic(Nachfolger),
            !,
            atomic_laenge(Nachfolger,N1),
            atomic_laenge(F,N2),
            max(N1,N2,N),
            R_aussen is L_aussen + N + 2,
            Pos is (R_aussen + L_aussen) // 2.

ana(Baum,[k(F,Pos),L],L_aussen,R_aussen):-
            Baum = [F|Nachfolger],   %%% TA =..
            atomic_laenge(F,N),
            M is L_aussen + N + 2,
            ana_nachfolger(Nachfolger,L_aussen,R,L),
            berechne_pos(L_aussen,Pos,L,R,M,R_aussen).


firstwo([lit,B],[lit,B]):-!. %%?
firstwo([A,B|_],[A,B]).


berechne_pos(_Links,Pos,L,R,M,R):- M =< R,
                            !,
                            erster_knoten(L,Pos1),
                            letzter_knoten(L,Pos2),
                            Pos is (Pos1 + Pos2) // 2.


berechne_pos(Links,Pos,_L,R,M,M):- M > R,
                            Pos is (M + Links) // 2.



ana_nachfolger([Baum|Rest],L_aussen,R_aussen,L):-
             Rest \= [],
             ana(Baum,L1,L_aussen,Mitte),
             ana_nachfolger(Rest,Mitte,R_aussen,L2),
             x_append(L1,L2,L).

ana_nachfolger([Baum],L_aussen,R_aussen,L):-
           ana(Baum,L,L_aussen,R_aussen).


max(X,Y,Z):- X >= Y, !, X=Z. %% TA-061030 !trap
max(_X,Y,Z):- Y=Z.





drucke_baum(S):-
                sv(S),
                ana(S,L,0,_R),
                dr_baum(L).



dr_baum(L):-
          L = [_|_],
          drucke_knoten(L,0),
          nl,
          drucke_aeste(L,0),
          nl,
          drucke_zweige(L,L1,0),
          nl,
          dr_baum(L1).

dr_baum([]).




drucke_knoten([X,Y|R],Spalte1):-
                 Y \= [_|_],
                 !,
                 dr_kn(X,Spalte1,Spalte2),
                 drucke_knoten([Y|R],Spalte2).


drucke_knoten([X,[_|_]|R],S1):-
              dr_kn(X,S1,S2),
              drucke_knoten(R,S2).

drucke_knoten([X],S):-
                dr_kn(X,S,_).

drucke_knoten([],_).

dr_kn(k(X,Pos),S1,S2):-
             atomic_laenge(X,N),


             tabx(Pos - N//2 - S1), %% TA-061030  -1 > 0

             S2 is Pos + N//2 + N mod 2,
             write(X).


/* Blaetter */
drucke_aeste([_X,Y|Rest],S):-
                Y \= [_|_],
                !,
                drucke_aeste([Y|Rest],S).

drucke_aeste([_X],_S):-
                !.

/* nicht-verzweigende, z.B. lexikalische Kategorien */
drucke_aeste([k(_X,Pos),L|Rest],S1):-
                knoten_zahl(L,1),
                !,
                tabx(Pos-S1),
                write('|'),
                S2 is Pos + 1 ,
                drucke_aeste(Rest,S2).

/* normale Kategorien */
drucke_aeste([X,[K|R]|Rest],S1):-
                !,
                dr_ae(X,[K|R],S1,S2),
                drucke_aeste(Rest,S2).

drucke_aeste([],_).


/* dr_ae(Dominierender_Knoten,[Tochter_links,L1,Tochter_rechts,L2]  */


dr_ae(k(_X,_Pos),L,S1,S2) :-
                        erster_knoten(L,Pos1),
                        letzter_knoten(L,Pos2),
                        Mitte is (Pos1 + Pos2) // 2,
                        tabx(Pos1-S1+1),
                        n_mal(Mitte-Pos1-1,'_'),
                        write('|'),
                        n_mal(Pos2-Mitte-2,'_'),
                        S2 is Pos2 - 1.

erster_knoten([k(_,Pos)|_L],Pos).


/* einen letzten Knoten gibt es nur dann, wenn
   es einen ersten Knoten gibt */
letzter_knoten([_|R],Pos):-
                         letzter_knoten(R,Pos).

/* 1. Fall: Blatt */
letzter_knoten([k(_,Pos)],Pos):- !.
/* 2. Fall: dominierender Knoten */
letzter_knoten([k(_,Pos),[_|_]],Pos).



/************************************************/
/* Blaetter */
drucke_zweige([_X,Y|Rest],Rest1,S1):-
                Y \= [_|_],
                !,
                drucke_zweige([Y|Rest],Rest1,S1).

drucke_zweige([X],[],_S):-
                X \= [_|_],
                !.


/* nicht-verzweigende, z.B. lexikalische Kategorien */
drucke_zweige([k(_,Pos),X|Rest],L,S1):-
                knoten_zahl(X,1),
                !,
                tabx(Pos-S1),
                write('|'),
                S2 is Pos + 1,
                drucke_zweige(Rest,L1,S2),
                x_append(X,L1,L).

/* normale Kategorien */
drucke_zweige([X,[K|R]|Rest],L,S1):-
                !,
                dr_zw(X,[K|R],S1,S2),
                drucke_zweige(Rest,L1,S2),
                x_append([K|R],L1,L).


drucke_zweige([],[],_).


/* dr_zw(Dominierender_Knoten,[Tochter_links,L1,Tochter_rechts,L2]  */

dr_zw(k(_X,_Pos),L,S1,S4) :-
                       erster_knoten(L,Pos1),
                       tabx(Pos1-S1),
                       write('/'),
                       S2 is Pos1+1,
                       knoten_dazwischen(L,S2,S3),
                       letzter_knoten(L,Pos2),
                       tabx(Pos2 - S3 - 1),
                       write('\\'),
                       S4 is Pos2 .


knoten_dazwischen([k(_,_)|R],S1,S2):-
                    drucke_zweige_fuer_knoten(R,S1,S2).


drucke_zweige_fuer_knoten([k(_,_)],S,S):- !.
drucke_zweige_fuer_knoten([k(_,_),[_Letzte|_Nachfolger]],S,S):- !.

drucke_zweige_fuer_knoten([k(_,Pos)|R],S1,S2):-
                           !,
                           tabx(Pos-S1),
                           write('|'),
                           S3 is Pos + 1,
                           drucke_zweige_fuer_knoten(R,S3,S2).

drucke_zweige_fuer_knoten([_|R],S1,S2):-
                           drucke_zweige_fuer_knoten(R,S1,S2).


knoten_zahl([k(_,_)|L],1):- \+ member_x(k(_,_),L).




n_mal(Arith,A):- X is Arith,
                 n_mal_x(X,A).

n_mal_x(N,A):- N > 0,
               !,
               write(A),
               M is N - 1,
               n_mal(M,A).
n_mal_x(N,_):- N =< 0.



atomic_laenge(A,N):- atom(A),
                     !,
                     name(A,L),
                     listen_laenge(L,N).

atomic_laenge(Nr,N):- numeric(Nr),
                     !,
                     name(Nr,L),
                     listen_laenge(L,N).

atomic_laenge(X,_N):- var(X),
                     !.

listen_laenge([_|R],N):- listen_laenge(R,M),
                         !,
                         N is M + 1.
listen_laenge([],0).


member_x(X,L):- x_member(X,L), !.



numeric(X):- number(X).


/*    instanziieren noch freier   variablen     */


 sv(X):- sv(X,1,_).


 sv(X, N, N1):-
    var(X),
    !,

    nextvar(X,N),
    N1 is N+1 .
 sv([X | Y], N, N2):-
    !,
    sv(X, N, N1),
    sv(Y, N1, N2).

 sv(S,N,N1):-
    compound(S),
    S =..[_F|A],
    !,
    sv(A,N,N1).

 sv(_X, N, N).


nextvar('X',1).
nextvar('Y',2).
nextvar('Z',3).
nextvar('U',4).
nextvar('V',5).
nextvar('W',6).
nextvar(X,N):- N > 6,
%%               number(N,L),
%%               x_append("X",L,Y),
               x_append("X",N,Y),
               name(X,Y).

atomic_length(X,5):- var(X), !.
atomic_length(X,N):-
                  name(X,L),
                  list_length(L,N).
list_length([],0).
list_length([_K|R],N):- list_length(R,M),
                       N is M + 1.

term_laenge(S,N):- atomic(S),
                   !,
                   atomic_length(S,N).
term_laenge(S,N):- S \= [_|_],
                   !,
                   S =..[F|A],
                   list_length(A,L),
                   atomic_length(F,X),
                   alle_args(A,Y),
                   N is X + Y + 2 + L - 1.

term_laenge(L,N):- L = [_|_],
                   alle_args(L,X),
                   list_length(L,Y),
                   N is X + 2 + Y - 1.
alle_args([],0).

alle_args([K|R],N):-
              term_laenge(K,X),
              alle_args(R,Y),
              N is X + Y.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






