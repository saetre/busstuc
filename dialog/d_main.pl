%% FILE d_main.pl
%% SYSTEM DIALOGUE
%% Createad AM-980218
%% REVISED TA-060306

%% REMOVED DEPENDENCIES ON JAVA INTERFACE
:- module( d_main,  [ dialog2/0, direct_run/2, webrun_dialog/0  ] ).

:- use_module( '../declare', [ (:=)/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .
%:- ensure_loaded( '../utility/utility' ). %, [ := /2 etc. ] ).  %% RS-131117 includes declare.pl
:- use_module( '../utility/utility' ). % [ := ] etc. %% RS-131117 %% Includes user:declare.pl, 

%:- ensure_loaded( user:'../bustermain2' ).
%:- use_module( '../bustermain2', [ ] ). % Unused? RS-140913 Use just main.pl instead!
:- use_module( '../main', [ closefile/1, getfromport/1,  processorwait/1, reset_period/0, writepid/0 ] ). % Unused? RS-140913 Use just main.pl instead!

:- use_module( '../tuc/readin' ). %%, [  ask_file/1, ask_user/1, read_in/1, words/3  ]). %%  Read a sentence into a list of symbols

%:- use_module('../tuc/readin').

%:- ensure_loaded( 'd_dialogue' ).
:- use_module( 'd_dialogue', [ processinput/1 ] ).

%% This file is extras needed to run the dialogue system. 
%% The predicates here are similar to those in main.pl.

/*
:-  use_module(library(sockets)).
*/



%% Predicate for running the dialogue system in Prolog interpreter.

dialog2 :-                                     %%AM-980301

%%    language:=norsk, %% TA-060307

   ( dialog := 1 ),    %% Disable defaults. 

   ( world := real ), %% TA-021027

	ask_user( Q ),

   ( contextid := (id) ),   
   ( location := trondheim ),   

	processinput( Q ), %% d_dialogue.pl

	write('----------------------------------'),nl,
   dialog2.

dialog2:-!. %% stop





%% Predicate starting the web service.

webrun_dialog :- !, 

   ( contextflag := true ), %%% <--- Dialog context shown if Teknisk info

	writepid, 
	set_prolog_flag(fileerrors,off),
	( busflag:= true ),    %% Bustuc Application Program
	( queryflag := true ), %% Statements are implicit queries 
   ( dialog := 1 ),       
   ( world  := real ),   
   ( warningflag := false ), %% if applicable 

 (  repeat,              %% TA-050723
%%%     resetsmsflag,  %% TA-081218
        reset_period,       %%   ---> topreg.pl (Now, interfaceroute)
	getfromport(L),
	processorwait(L),
  fail , ! ; true ).   %% RS-141026  Should never get to true because of the repeat, ... , fail  LOOP.


	
% Below two processorwait_d copied from processorwait/1 AM-980220

%processorwait_d([]) :-
%	 sleep(1),
%	 !.
%
%processorwait_d(S) :-
%
%	 psl(S,L),
%         d_language(L,Q), 
%
%	 trytellans,   
%	 trytellans,
%  
% %% output('いいいいいいいいいいいいいい�'), %% TEST
%
%	 (processinput(Q);true), % AM-980220 %% d_dialogue.pl
%	 told,
%	 clearport,
%	 !.



direct_run(InputFile,OutputFile):- %% Direct execution

    reset_period,  %% !"#�%&/()=?\`@�$[]}+�

    ( trace := 1 ),

    ( contextflag  := true ), %% TA-060127

	(  directflag := true ),
    ( directinputfile  := InputFile ),
    ( directoutputfile := OutputFile ),

    closefile(InputFile), 
    closefile(OutputFile), 

    see(InputFile),
       read(X),
       X=query(Query), 
    (seen),

    psl(Query,L),


       d_language(L,Q), 
       (processinput(Q);true),

      ( directflag := false ).





%% NEW FORMAT

/* 
HIDDEN  lang
HIDDEN  contextid
        quest
*/     

%% Sets the appropriate language depending on parameters from client.


d_language([Lang,Contextid|Quest],Quest):- %% TA-050805
   !,   
   ( contextid := Contextid ),

  (Lang=eng -> Language=english;
   Lang=nor -> Language=norsk;
               Language=norsk),
					

   ( origlanguage:= Language ), 
   ( language:= Language ).




d_language([eng|T],T) :-
	!,
	( origlanguage:=english ),
	( language:=english ). 

d_language([nor|T],T) :- %% no -> nor
	!,
	( origlanguage:=norsk ),
	( language:=norsk ).

%% Just in case anyone tries to crash the server.
d_language(T,T):-
   !,
 	( origlanguage:=norsk ),
	( language:=norsk ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




