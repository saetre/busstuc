%% FILE compileroute.pl 
%% SYSTEM BusTUC/REGTOP
%% CREATED TA-040421
%% REVISED TA-110302

% Compiles the Busroute tables

%% This is completely domain-independent

%% Data taken from topreg.pl

%:-prolog_flag(discontiguous_warnings,_,off). 

:- use_module( 'db/topreg', [ route_period/4 ] ).

%%% Local Bootstrap predicates %%%
%%% Must come first            %%%


ta_for(X,Y):-
    X,Y,fail;
    true. 

ta_append_atomlist([A],A):-!.  
ta_append_atomlist([A|B],AB):-
    ta_append_atomlist(B,B1),
    ta_append_atoms(A,B1,AB).


ta_append_atoms(A,B,C):-  
    ta_atomname(A,AL),
    ta_atomname(B,BL),
    ta_append(AL,BL,CL),
    name(C,CL).  %% <- %% name(94451, [32,57,52,52,53,49]). %% leading blanks


ta_atomname(X,L):-atom(X),!,name(X,L).

ta_atomname(X,L):-number(X),
    !,
    name(X,L).
  
ta_append([],X,X).
ta_append([X|Y],U,[X|V]) :-
    ta_append(Y,U,V).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


consult_route_set_list([Module|Modules]):-
    !,
    compile_route_set(Module),

    consult_route_set_list(Modules).
     
consult_route_set_list([]).


compile_route_set(Module):-
     make_mod_file_list(Module,MF),
     consult(Module:MF).


make_mod_file_list(Module,MF):-

    ta_append_atomlist(['db/tables/',Module,'/',regcomp],Regcomp),
    ta_append_atomlist(['db/tables/',Module,'/',regbus], Regbus),
    ta_append_atomlist(['db/tables/',Module,'/',reghpl], Reghpl),
    ta_append_atomlist(['db/tables/',Module,'/',regdko], Regdko),
    ta_append_atomlist(['db/tables/',Module,'/',regcut], Regcut),   

    MF = [Regdko,Regbus,Reghpl,Regcomp,Regcut]. 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


periodset(TT,PZ):- setof(P, rp(TT,P) ,PZ). %% set_of/3  undefined yet


rp(TT,P):- route_period(TT,P,_X,_Y),P \== nil. 


consult_periodset(TT):-
     periodset(TT,PZ), 
     consult_route_set_list(PZ).




consultbase(TT):- %% TA-110301

   ta_for(compilerouteaux(TT,Z), 
          compile(Z)), %% TA-110302

   ta_for(routedomain(X), 
          consult_periodset(X)).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
