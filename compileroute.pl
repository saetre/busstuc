%% FILE compileroute.pl 
%% SYSTEM BusTUC/REGTOP
%% CREATED TA-040421
%% REVISED TA-110302
%% REVISED RS-111220

% Compiles the Busroute tables
:- module( compileroute, [  compile_route_set/1, consultbase/1, consult_periodset/1  ] ).   %% RS-131227    From compileroute

%% This is completely domain-independent

%% Data taken from topreg.pl
%%:-use_module('busroute.pl', [] ).     %%RS-140207 NO, This file is imported INto the busroute.pl-module

%Experiment: Try to create regcut on the fly, only if missing/needed: findOrCreateRegcut/2 (module, file)
%:- use_module( 'utility/extracut.pl', [ create_regcut/1 ] ).     %%RS-140511 This file is imported INTO THE busroute.pl-module

%% Unit: DB
%% Main Table for Route Modules %% RS-140210 Loaded from  interfaceroutes / busroute / compileroute


%%% Local Bootstrap predicates %%%
%%% Must come first            %%%

%% RS-140210 meta_predicates    : means use source module       + means use this( compileroute ) module  (used for module-expansion)
:- meta_predicate
           ta_for(0,0) . %% ta_for/2

%%:-prolog_flag( discontiguous_warnings,_,off ). 

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


consult_route_set_list( [Module|Modules] ) :-
    !,
    compile_route_set(Module),

    consult_route_set_list(Modules).
     
consult_route_set_list( [] ).


compile_route_set( Module ) :-
     make_mod_file_list( Module, MF ),
     consult( Module:MF ).   %% RS-111220 , create_regcut(Module).

make_mod_file_list( Module, MF ) :-

    ta_append_atomlist(['db/tables/',Module,'/',regcomp],Regcomp),
    ta_append_atomlist(['db/tables/',Module,'/',regbus], Regbus),
    ta_append_atomlist(['db/tables/',Module,'/',reghpl], Reghpl),
    ta_append_atomlist(['db/tables/',Module,'/',regdko], Regdko),
    ta_append_atomlist(['db/tables/',Module,'/',regcut], Regcut),   

    MF = [Regdko,Regbus,Reghpl,Regcomp,Regcut]. % , % .

%,    findOrCreateRegcut( Module, Regcut )%Check if regcut exists, and create_regcut if not... %% RS-140510
% Check whether the regcut file exists with the extensions `.pl' (or `.prolog'), and is readable, else create it
%findOrCreateRegcut( _Module, RegcutFile ) :-
%        absolute_file_name( RegcutFile, _AbsFile,
%                            [ extensions( ['.pl','.prolog'] ), access( [read] ), file_errors( fail ) ] ) .
%
%findOrCreateRegcut( Module, _RegcutFile ) :-
%        !,      %% Only create max 1 new regcut without total re-compilation.
%        create_regcut( Module ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


periodset( TT, PZ ) :- setof(P, rp(TT,P) ,PZ). %% set_of/3  undefined yet


% /2 and   routedomain/1  IS USED(!) in ta_for in consultbase
:- use_module( 'db/route_period.pl', [ route_period/4 ]). %% RS-140511
:- use_module( 'db/topreg.pl', [ compilerouteaux/2,  routedomain/1 ]). %% default_message/3,  default_period/3,  %% RS-140511

rp( TT, P ) :- route_period(TT,P,_X,_Y),P \== nil. 


consult_periodset(TT) :-
     periodset(TT,PZ), 
     consult_route_set_list(PZ).


consultbase(TT) :- %% TA-110301

   ta_for( compilerouteaux(TT,Z), 
          compile(Z) ), %% TA-110302

   ta_for( routedomain(X), 
          consult_periodset(X) ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
