%% FILE: d_contextDB.pl
%% Created AM-980303 

:-op( 730,xfy, :: ).     %% lambda infix  %% RS-141026 For      tuc/ [ translat gram_x fernando  dcg_x anaphors ], app/interapp, dialog/ [checkitem/2 d_context d_dialogue frames/2 makeframe/2 parseres virtuals relax update2 usesstate2]

%%
%% This file contains implementation of the dialogue context database.
%% List implementation of database. 
%%

%% context record:
%% [context id,[state,State],
%%             [mode,Mode],
%%             [query,Query],
%%             [lastaxiom, Lastaxiom]]

:- module( d_context, [ context/1, dbDump/1, dropdb/1, dropident/0, getframe/1, getmode/1, getquery/1, getlastaxiom/1,
        setframe/1, setmode/1, setquery/1, setlastaxiom/1 ] ).
%	getstate/1, setstate/1,

:- volatile dbContent/2.
:- dynamic  dbContent/2.

:- volatile dbId/1.     %% RS-131223    TROUBLE WHEN NOT STORED TO FILE!?
:- dynamic  dbId/1.

%:- use_module( '../utility/writeout', [ track/2 ] ). %% RS-131227 Avoid loop?
%:- use_module( '../main', [ ( := )/2 ] ). %% RS-131227 Avoid loop?
:- use_module( '../declare', [ ( := )/2, track/2 ] ). %% RS-131227 Avoid loop?

:- use_module( library(lists) ).

context( Id ) :-                                    %% AM-980311
	dbIskey( state, Id ),
	!,
	context_id := Id,
	dbUpdate(dman, current, Id),
	track(1, 
	(nl,write('Old context'),nl)).

context( Id ) :-                                    %% AM-980311
	\+ dbIskey(state, Id),
	!,
	context_id := Id,
%	newframe(Id::frame, bustuc),          %% RS-140915 Gone?
	dbAdditem( state, 
	           Id, 
                   [[frame,Id::frame],
                    [mode,i_user],
                    [query, new],
                    [lastaxiom,[]]
                   ] ),
	dbUpdate(dman, current, Id),
	track(1,
	(nl,write('New context'),nl)).


%% Frame
getframe( Frame )  :-                               %% AM-980311
	getattribute( frame, Frame ).
		
setframe( Frame ) :-                                %% AM-980311
	setattribute( frame, Frame ).

%% Mode
getmode( Mode )  :-                                 %% AM-980311
	getattribute( mode, Mode ).
		
setmode( Mode ) :-                                  %% AM-980311
	setattribute( mode, Mode ).

%% Query
getquery( Query )  :-                               %% AM-980311
	getattribute( query, Query ).
		
setquery( Query ) :-                                %% AM-980311
	setattribute( query, Query ).
	
%% Lastaxiom
getlastaxiom( Axiom )  :-                           %% AM-980311
	getattribute( lastaxiom, Axiom ).
		
setlastaxiom( Axiom ) :-                            %% AM-980311
	setattribute( lastaxiom, Axiom ).

%% Help predicate
getattribute( Key, Value ) :-     %% AM-980311
	dbGetitem( dman, current, Id ),
	dbIskey( state, Id ),
	dbGetitem( state, Id, Context ),
	!,
	member([Key,Value],Context).

%% Just in case..
getattribute( _, nil ).                             %% AM-980423

setattribute(Key, Value ) :-                        %% AM-980311
	dbGetitem( dman, current, Id ),
	dbIskey( state, Id ),
	dbGetitem( state, Id, Context ),
	!,
	lsUpdate([Key,_], [Key,Value], Context, NewContext),
	dbUpdate( state, Id, NewContext ).

%% Application independent database implementation

dbContent( nil, [] ). 
%dbId( [] ). 

dbInit(DB) :-  %% AM-980303
	\+ dbId( DB ),
	assert(dbContent(DB,[])),
	assert(dbId( DB )).


dbGetitem( DB, Key, Value ) :-      %% AM-980303
	dbContent( DB, Content  ),   
	!,  %% Should not be necessary
	member([Key,Value],Content ).
	
dbAdditem( DB, Key, Value ) :- %% AM-980303
	dbContent( DB, Content ), 
	!,
	\+ member([Key,Value], Content),
	lsInsert([Key,Value],Content, Ncontent),
	retract(dbContent( DB, Content )),
	assert( dbContent( DB, Ncontent)).

dbUpdate( DB, Key, New ) :- %% AM-980303
	dbContent( DB, Content ),!,
	lsUpdate([Key,_],[Key,New],Content,Ncontent),
	retract(dbContent( DB, Content )),
	assert( dbContent( DB, Ncontent)).
	
dbIskey( DB, Key ) :-%% AM-980303
	dbContent( DB, Content ),!,
	member([Key,_],Content).

dbDump(DB)  :-%% AM-980303
	dbId(DB),
	dbContent(DB,Content),
	write( Content ).


%% List manipulation
%lsRemove( _, [], []).                  
%lsRemove( A, [A|T], T ) :- !.
%lsRemove( A, [B|T], Nt) :-
%	lsRemove(A,T,Tr),
%	append([B],Tr,Nt).

lsUpdate(_,_,[],[]).
lsUpdate(Old,New, [Old|T], [New|T]) :- !.
lsUpdate(Old,New,[H|T],Nl)  :-
	lsUpdate(Old, New, T, Tu),
	append([H],Tu,Nl).
	

lsInsert(E, L, Nl) :-
	append([E],L,Nl).

dropident :-
	retract(dbId(_)),
	assert(dbId([])).

dropdb(Id) :-
	retract(dbContent(Id, _)),
	assert(dbContent(Id,[])).

%% Init database, IMPORTANT!
:- retract(dbId(_)).
:- assert(dbId([])).
:- dbInit(state).

:- dbInit(dman).
:- dbAdditem(dman,current,nil).



