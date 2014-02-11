/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE extracoord.pl
%% SYSTEM AtB
%% CREATED TA-100221
%% REVISED TA-100223


%% Extract  GPS coordinte from table into a predicate

% assume all files are separated correctly with a Tab (ASCII 9)

%:- use_module( '../sicstus4compatibility', [ get0/1, tab/1 ] ).  %% Compatible with sicstus4, get0/1 etc.




extracoord :- 

   output('Please wait a minute'),
   extract(statcoord).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% template(filenamein,filenameut,predname,

%% template('koord1.txt','koord1.pl',coord,free). %% small test

template('koord.txt','koord.pl',statcoord,free). %% the real thing


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


extract(Coord):- 

    resetcount,

    template(File1,File2,Coord,Templ),


    see(File1),

    %%tell(File2),    %% RS-121121
    open( File2, write, Stream, [encoding('UTF-8')] ),
    set_output(Stream),

    repeat,

        initread(U),

        process(Coord,U,Templ),

        U == end_of_file,       
    !,
 
    told,
    write('Finish read '),nl,

    seen.


 


process(_,[],_):-!.  %% occasional blank line
process(_,end_of_file,_):-!.

process(Coord,U,_Templ) :-!,
    tablett(U,Ulist),     %% 10 = max
 %   count(N1),

    extractlist(Ulist,Vlist),

    Predx =.. [Coord|Vlist],
    convertpred(Coord,Predx,Predy),
    
     write(Predy),write('.'),nl. %% assertz(Predy). %% write(Predy),write('.'),nl. 
                                 %% Variable preds are stored in reverse order !


%% extractlist(Ulist,Ulist).


extractlist([Kommnr,Hlpnr,Holdeplassnavn,_Sonenr,_Kortnavn,_Merknader,X_koordinat,Y_koordinat,_Retning|_],
            [KommnrHlpnr,Holdeplassnavn,X_koordinat,Y_koordinat]):-
   
     composestatnr(Kommnr,Hlpnr,KommnrHlpnr).

composestatnr(Kommnr,Hlpnr,KommnrHlpnr):-
    Hlpnr==nil,
    !,
    append_atoms(Kommnr,'0000',KommnrHlpnr). %% ad hoc


%% This is a horrendous hack

composestatnr(Kommnr,Hlpnr,KommnrHlpnr):-
    Hlpnr >= 1000,
    !,
    append_atoms(Kommnr,Hlpnr,KommnrHlpnr). %% ad hoc // NB Hlpnr -> 4 DIGITS!

composestatnr(Kommnr,Hlpnr,KommnrHlpnr):-
    Hlpnr >= 100,
    !,
    Komm10 is Kommnr*10,
    append_atoms(Komm10,Hlpnr,KommnrHlpnr). 

composestatnr(Kommnr,Hlpnr,KommnrHlpnr):-
    Hlpnr >= 10,
    !,
    Komm100 is Kommnr*100,
    append_atoms(Komm100,Hlpnr,KommnrHlpnr). 


composestatnr(Kommnr,Hlpnr,KommnrHlpnr):-
    Komm1000 is Kommnr*1000,
    append_atoms(Komm1000,Hlpnr,KommnrHlpnr). 






%% Version: All Fields separated by Tab (9)

tablett([],[]):-!.

tablett(W,[Field1|FRest]):-
    scanfield(W,Flist1,WRest),
    convertf(Flist1,Field1),
    tablett(WRest,FRest).

scanfield([],[],[]).

scanfield([A1|Z],[A1|U],Krest) :-

    A1 \==9, % Tab
    A1 \==13, % Tab %% - name(G,[13]).  G = '\r' ? 
    !,
    scanfield(Z,U,Krest).
   
scanfield([A1|Z],[],Z) :-
    (A1 ==9;A1==13), % Tab
    !.



 
firstnonblank([Blank|Z],B ):- Blank=32,
    !,
    firstnonblank(Z,B).

firstnonblank([B|_],B).



convertf([],nil):-!.

convertf(Flist1,Field1):- %% Number   NNNN  | NNN NNNN | NNNN,NNNN

    firstnonblank(Flist1,B),    

    B >= 48,   %% 0
    B =< 57,    %% 9
    !,
    replblanks(Flist1,Flist2), %% 
    name(Field1,Flist2).





convertf(Flist1,Field1):- %% Name, Starting with big letter
    Flist1=[B|_],
    B >= 65,   %% A
    B =< 216,  %% Ø
    !,
    fnuttify(Flist1,Flist2),
    name(Field1,Flist2).

convertf(Flist1,Field1):- %% 
    name(Field1,Flist1).





replblanks([B|R],Z):- 
    B==32,
    !,
    replblanks(R,Z).  % leading blanks,ignore


replblanks([D|R],[E|Z]):-
    D==44, %% ','
    !,
    E=46, %% \+ ==
    replblanks(R,Z). %% period !


replblanks([D|R],[D|Z]):-
     D >=48, D =< 57,
     !,
     replblanks(R,Z). %% period?

replblanks([],[]).







fnuttify(K,L) :-
    append([39],K,K1), %% ''''
    append(K1,[39],L).


convchar(44,46):-!. %% In this context, , is decimal
convchar(X,X):-!. 




convertpred(_,X,X). %% Default



%%%%%%%%%%%%%


remblanks([32|A],B):-!,
    remblanks(A,B).
remblanks(A,A).

remchar([C|A],B):-
    C > 57, 
    remchar(A,B).

remchar([C|A],B):-
    C = 32, 
    remchar(A,B).

remchar(A,A):-!.


cleaniso([],[]).
cleaniso([A|B],[A1|B1]):-
    iso0(A,A1),
    cleaniso(B,B1).

iso0(X,Y):-iso(X,Y),!.
iso0(X,X).


blank(32). % bl
blank(45). % -
blank(46). % .
blank(95). % _

skipch(40). % (
skipch(41). % )

skipch(39). % '
skipch(96). % `

%% Obviously wrong coded characters appear

% ø and Ø seems yom be replaced by o and O,
% Big Æ does not occur

% Lower case character conversion


special(198,230). %% Æ-> æ
special(216,248). %% Ø-> ø
special(197,229). %% Å-> å


special(145,230).       %% \221 -> æ
special(146,230).       %% \222  ->    Æ -> æ

special(155,248).       %% \233 -> ø
special(157,248).       %% \235 -> ø

special(134,229).       %% \206 -> å
special(143,229).       %% \217 -> Å (197)  -> å

special(X,X).  %% Default



iso(145,230).           %% \221 -> æ
iso(146,198).           %% \222  ->    Æ -> æ

iso(155,248).           %% \233 -> ø
iso(157,216).           %% \235 -> Ø

iso(134,229).           %% \206 -> å
iso(143,197).           %% \217 -> Å (197)  -> å




%----------------------------------------

% Some utilities


append_atoms(A,B,C):-  
    name(A,AL),
    name(B,BL),
    append(AL,BL,CL),
    name(C,CL).


mini(X,999,X):-!.
mini(999,X,X):-!.
mini(X,_,X).


%member(X,[U|V]):-X=U;member(X,V).      %% RS-111212 Moved to sicstus4_compatibility.pl
%
%append([],A,A).
%append([X|Y],U,[X|V]):-
%    append(Y,U,V).
%   


for(P,Q):-
  P,Q,
  false;true.


% Prologs setof is baroque %% 

set_of(X,Y,Z):-           %% 
    setof(X,Y^Y,Z),!;     %% Trick to avoid alternatives
    Z=[].                 %% What is wrong with empty sets ?




initread(U):-
     get0(K1), 
	  (K1 == -1 -> % 
      U= end_of_file;
      readrestline(K1,U)).

readrestline(T,[]):- 
    T=10,  %% CR
    !.
	
readrestline(K,[K|U]):-
    get0(K1), % blanks, comments (evt returns CR)
    readrestline(K1,U).

firstlist(N,[K|Y],[K|Z],Rest):-
    N > 0,
    !,
    M is N-1,
    firstlist(M,Y,Z,Rest).

firstlist(_,L,[],L).

:-volatile val/1, val2/1, val3/1.
:-dynamic val/1, val2/1, val3/1.

resetcount :- retractall(val(_)),
              assert(val(0)),
		  retractall(val2(_)),
              assert(val2(0)),
		  retractall(val3(_)),
              assert(val3(0)).


%%%%%%%%%%%%% Utilities 

writefact(P):- 
    writeq(P),write('.'),nl.


reverse(L1,[]):-var(L1),!. %% Keine Experimente TA-970516
reverse(L1,L2):- 
    rev1(L1,[],L2),
    !. 

rev1([],L,L).
rev1([X|Y],L,Z):-
    rev1(Y,[X|L],Z).


listall(P):-P,write(P),nl,fail;true.

output(X):-write(X),nl.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
