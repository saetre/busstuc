/* -*- Mode:Prolog; coding:utf-8; -*- */
% FILE main.pl
%% SYSTEM TUC
%% CREATED RS-150119
%% REVISED 

%% GPS-handling for BussTUC

%% UNIT: /utility/

%% USAGE :-use_module( '../utility/gps' , [ ... ] ). %%RS-150119
:-module( gps, [ assert_default_origins/1, gps_origin/2, gorg/0, reset_origins/0, transfix/2 ] ).  %% RS-150119. transfix overriding translat:transfix/2 

%% RS-141015 Import gps_origin from where it is defined! Or get it from the user... E.g utility:gps_origin (stored in user:)?
:-volatile  gps_origin/2 . %% TA-110127   %% Set by user input: Station +minutes
:-dynamic   gps_origin/2 . %% TA-110127

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- use_module( '../declare', [ (:=)/2, remember/1, trackprog/2 ] ).     %, value/2
:- use_module( '../sicstus4compatibility', [ out/1, output/1 ] ).  %% Compatible with sicstus4, get0/1 etc.
:- use_module( '../utility/utility', [ for/2 ] ).     %, value/2
:-use_module( '../tuc/translat', [  transfix1/2  ] ).        %% RS-131227 -141026 clausifyq/2, clausifystm/1  , (=>)/2  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

gorg :- listing( main:gps_origin ). %% debug %% TA-110128

%%% FOR GPS %%%


%% Control Section

assert_default_origins( X ) :-
        output( 'GPS locations: '), out( X ), nl,nl,
        remember( gps_origin( 'Gløshaugen syd', 3 ) ). %% RS-141026    NOT properly implemented yet!!!


%Adding PRE-clause to parse GPS first!
transfix( [gpsflag:::Orgy | Rest], U ) :- !,

    %%( Orgy \== [] -> smartdepflag := true ; smartdepflag := true ), %% if gps, special output
     (smartdepflag := true), %% Quickfix to allow json output to all queries. %% TE-120206

    for( member( gps_origin(X,Y), Orgy ),
           remember( gps_origin(X,Y) ) ),       % remeber( main:gps_origin(X,Y) )
       transfix(Rest,U).

%% Several (old) statements
transfix([[]],[replyq('?')]):-!.  %% Avoid empty answers (by synonym)

transfix([X|Y],[X1|Y1]):- 
    !,
    transfix1(X,X1),
    transfix(Y,Y1).
transfix([],[]):-!.

transfix(P,Q):-transfix1(P,Q). %% PANIC

    

 
reset_origins :- %% TA-110128
    retractall( gps_origin(_,_) ),
 
%%%    traceprog( 3,reset_origins),
%%%    trackprog( 3, verify_empty_origins ). %% TA-110206
    trackprog( 3, verify_empty_origins ). %% TA-110206

verify_empty_origins :- %% all gps_origin should be gone !!!!!!
    gps_origin(X,Y) -> 
        ( write('***'),write( gps_origin(X,Y) ) )
         ;
         true.

%%%%%%%%%%%  THE END %%%%%%%%%%%%%%%%%%%%%%
