%% FILE d_main.pl
%% SYSTEM DIALOGUE
%% Createad AM-980218
%% REVISED TA-060306

%% REMOVED DEPENDENCIES ON JAVA INTERFACE

%:-module( dialog, [  dialog2/0,      direct_run/2,    webrun_dialog/0   ]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- ensure_loaded( '../declare' ).  % :- use_module( '../declare.pl').
%:- op( 712, fy,seen). % Lower than "not", higher than "isa"

%% This file is extras needed to run the dialogue system. 
%% The predicates here are similar to those in main.pl.

/*

:-  use_module(library(sockets)).
*/

%% Predicate for running the dialogue system in Prolog interpreter.

%dialog2 :-                                     %%AM-980301
%
%%%    user:language := norsk, %% TA-060307
%
%   user:dialog := 1,    %% Disable defaults. 
%
%   user:world := real, %% TA-021027
%
%	ask_user( Q ),
%
%   user:contextid := myid,   
%   user:location := trondheim,   
%
%	processinput( Q ), %% d_dialogue.pl
%
%	write('----------------------------------'),nl,
%   dialog2.
%
%dialog2:-!. %% stop
%
%
%
%
%
%%% Predicate starting the web service.
%
%webrun_dialog :- !, 
%
%   user:contextflag := true, %%% <--- Dialog context shown if Teknisk info
%
%	writepid, 
%	nofileerrors,
%	user:busflag := true,    %% Bustuc Application Program
%	user:queryflag := true, %% Statements are implicit queries 
%   user:dialog := 1,       
%   user:world := real,   
%   user:warningflag := false, %% if applicable 
%
%  repeat,              %% TA-050723
%       resetsmsflag, 
%       reset_period,       %%   ---> topreg.pl
%	    getfromport(L),
%	    processorwait_d(L),
%
%  fail.
%
%
%	
%% Below two processorwait_d copied from processorwait/1 AM-980220
%
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
%%% output('¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤'), %% TEST
%
%	 (processinput(Q);true), % AM-980220 %% d_dialogue.pl
%	 told,
%	 clearport,
%	 !.
%
%
%
%direct_run(InputFile,OutputFile):- %% Direct execution
%
%    reset_period,  %% !"#¤%&/()=?\`@£$[]}+´
%
%    user:trace := 1,
%
%    user:contextflag := true, %% TA-060127
%
%	 user:directflag := true,
%    user:directinputfile := InputFile,
%    user:directoutputfile := OutputFile,
%
%    closefile(InputFile), 
%    closefile(OutputFile), 
%
%    see(InputFile),
%       read(X),
%       X=query(Query), 
%%    seen,
%
%    psl(Query,L),
%
%
%       d_language(L,Q), 
%       (processinput(Q);true),
%
%      user:directflag := false.
%
%



%% NEW FORMAT

/* 
HIDDEN  lang
HIDDEN  contextid
        quest
*/     

%% Sets the appropriate language depending on parameters from client.


%d_language([Lang,Contextid|Quest],Quest):- %% TA-050805
%   !,   
%   user:contextid := Contextid,
%
%  (Lang=eng -> Language=english;
%   Lang=nor -> Language=norsk;
%               Language=norsk),
%					
%
%   user:origlanguage := Language, 
%   user:language := Language.
%
%
%
%
%d_language([eng|T],T) :-
%	!,
%	(user:origlanguage := english),
%	(user:language := english). 
%
%d_language([nor|T],T) :- %% no -> nor
%	!,
%	(user:origlanguage := norsk),
%	(user:language := norsk).
%
%%% Just in case anyone tries to crash the server.
%d_language(T,T):-
%   !,
% 	(user:origlanguage := norsk),
%	(user:language := norsk).   
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




