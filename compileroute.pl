%% FILE compileroute.pl
%% SYSTEM BusTUC/REGTOP
%% CREATED TA-040421
%% REVISED TA-110302
%% REVISED RS-111220

%% Main Table for Route Modules %% RS-140210 Loaded from  interfaceroutes / busroute / compileroute

% Compiles the Busroute tables
:- module( compileroute, [  compile_route_set/1, consultbase/1, consult_periodset/1  ] ).   %% RS-131227    From compileroute

%% Unit: external
:-use_module( library(file_systems), [ file_property/3 ] ).

%% RS-150104
% Experiment: Create regcut.pl on the fly, only if missing or if regdep and regpas have been updated:
%  findOrCreateRegcut/3 ( depfile, pasfile, cutfile ) FAILS when an update is needed, e.g. (Module is r1611_141201)
%  findOrCreateRegcut( Regdep, Regpas, Regcut )  ->  true  ;  create_regcut( Module ).


%% Unit: /utility/
:-use_module( 'utility/extracut', [ create_regcut/1 ] ).     %% RS-140511 This file is imported INTO the busroute.pl module
:-use_module( 'utility/writeout', [ out/1, output/1 ] ).

%% Unit: DB
:- use_module( 'db/route_period.pl', [ route_period/4 ]). %% RS-140511
:- use_module( 'db/topreg.pl', [ compilerouteaux/2,  routedomain/1 ]). %% default_message/3,  default_period/3,  %% RS-140511


%% This is completely domain-independent
%% Data taken from topreg.pl
%%:-use_module('busroute.pl', [] ).     %%RS-140207 NO, This file is imported INto the busroute.pl-module

%%:-prolog_flag( discontiguous_warnings,_,off ). 


%%% Local Bootstrap predicates %%%
%%% Must come first            %%%

%% RS-140210 meta_predicates    : means use source module       + means use this( compileroute ) module  (used for module-expansion)
:- meta_predicate      ta_for(0,0) . %% ta_for/2

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


consult_route_set_list( [ Module | Modules ] ) :-
    !,
    compile_route_set( Module ),
    consult_route_set_list( Modules ).

consult_route_set_list( [] ).


compile_route_set( Module ) :-
     make_mod_file_list( Module, MF ),
     nonvar( MF ),      %% RS-150111. Only for real, given, ModuleFiles.
%     consult( Module:MF ).
     compile( Module:MF ).      %% RS-150111. Faster?


make_mod_file_list( Module, MF ) :-

    ta_append_atomlist( [ 'db/tables/', Module, '/', regcomp],Regcomp),
    ta_append_atomlist( [ 'db/tables/', Module, '/', regbus], Regbus),
    ta_append_atomlist( [ 'db/tables/', Module, '/', reghpl], Reghpl),
    ta_append_atomlist( [ 'db/tables/', Module, '/', regdko], Regdko),

    ta_append_atomlist( [ 'db/tables/', Module, '/', regdep], Regdep),
    ta_append_atomlist( [ 'db/tables/', Module, '/', regpas], Regpas),
    ta_append_atomlist( [ 'db/tables/', Module, '/', regcut], Regcut),

    MF = [ Regdko, Regbus, Reghpl, Regcomp, Regcut ], % . % ,

    %% RS-150103, if needed:  create_regcut(Module),
    %        !,      %% Only create max 1 new regcut without total re-compilation.
    % Check if regcut exists and is newer than regdep and regpas (base files), % and create_regcut if not...
    %  compileroute:compile_route_set( Module ) :-
    ( findOrCreateRegcut( Regdep, Regpas, Regcut )  ->  true  ;  create_regcut( Module ) ) % , output( ' Now is the time to recompile regcut!' )
    .  %% RS-150105. ->  true May not be necessary

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RS-150104
% List out all possible file properties
%:-use_module( 'utility/writeout', [ out/1, output/1 ] ).
%        ( file_property( AbsCutfile, P, V ),    out(P), out('='), output(V), fail ; true ),

% Check whether the regcut file exists with the extensions `.pl' (or `.prolog'), is readable, and newer than the dep and pas files,
% if this fails, someone has to create a new regcut file as soon as possible!
findOrCreateRegcut( RegdepFile, RegpasFile, RegcutFile ) :-
        absolute_file_name( RegdepFile, AbsDepfile,  [ extensions( ['.pl','.prolog'] ), access( [read] ), file_errors( fail ) ] ),
        file_property( AbsDepfile, modify_timestamp, TimeDep ),
        absolute_file_name( RegpasFile, AbsPasfile,  [ extensions( ['.pl','.prolog'] ), access( [read] ), file_errors( fail ) ] ),
        file_property( AbsPasfile, modify_timestamp, TimePas ),
        absolute_file_name( RegcutFile, AbsCutfile,  [ extensions( ['.pl','.prolog'] ), access( [read] ), file_errors( fail ) ] ),
        file_property( AbsCutfile, modify_timestamp, TimeCut ),

        TimeCut > TimeDep, TimeCut > TimePas,
        out( 'compileroute.pl~122: SKIP createCut for timestamp ' ),out( RegcutFile ),out( TimeCut ),out(' > '),output( TimeDep ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


periodset( TT, PZ ) :- setof(P, rp(TT,P) , PZ ). %% set_of/3  undefined yet

rp( TT, P ) :- route_period( TT, P, _X, _Y ), P \== nil.


consult_periodset( TT ) :-
     periodset( TT, PZ ), 
     consult_route_set_list( PZ ).


consultbase(TT) :- %% TA-110301

        %% RS-150111 Common files across modules!
   ta_for( compilerouteaux(TT,Z), 
          compile(Z) ), %% TA-110302

        %% RS-150111 Unique separate files for each separate module!
   ta_for( routedomain(X), 
          consult_periodset(X) ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
