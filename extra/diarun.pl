%% FILE diarun.pl
%% SYSTEM BUSSTUC 
%% CREATED TO-970305
%% REVISED TO-970424 TA-980214

%
% Stores new context information from the users sentences
% Adds previously stored information to the sentences before invoking 
% Bustuc.

%%% %%%%%%%% RS-111118
 :- ['../declare.pl'].
    

dialogrun0 :-
	 dialogrun([]). %% TA-980214

dialogrun(State) :-
	 % copied from "go" and "process/1"
    doask_user(L),
    error_phase := 0,
	 translate2(L,TQL),
    nl,
	 dialogline(TQL,State).

dialogline(Q::R,State) :-
	 !,
	 copy_term(Q::R,QC::RC),  % strips TQL
	 nocols(R,RNC),
	 flatround((Q,RNC),RQ),
	 konstantify(RQ),
	 !,                       % Looks only at first try
	 evalline(QC::RC,RQ,State,NewState),       %% TA-970523
	 write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),
	 write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),nl,
    track(1,	                                       %% TA-970523
    (write('Context info: '), write(NewState), nl)), 
	 dialogrun(NewState),
	 !.                       % Only one program run

% handle commands

dialogline(TQL,_):- %% TA-970523
    (TQL=stop;TQL=end),
    !.

dialogline(TQL,State) :-
    exetuc(TQL),
	 dialogrun(State).  

%------------------------------------

evalline(new::_,QTL,State,NewState) :-
	 !,
    updatestate(QTL,State,NewState),   % only for new ? %% TA-970915
	 write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),
	 write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),nl,
	 write('OK.'), nl.              


evalline(OrigTQL,QTL,State,State) :- % No state updating
	 usestate(State,QTL,NewTQL),
	 answer(OrigTQL,NewTQL),
	 !.

evalline(_,_,_,[]). % evaluation failed, return the empty list



updatestate(QTL,State,NewState) :- !, %% Only new:: causes update %% TA-970715
	 pragma_init(updatestate,QTL,State,NewState).


usestate(State,TQL,NewTQL) :-
	 pragma_init(usestate,State,TQL,NewTQL).



answer(Q::_,NewTQL):-		
    track(2,  (nl, write(NewTQL), nl)),
	 write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),
	 write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),nl,
	 pragma(trans,NewTQL,Program),
	 writeprog(Program),
	 (Program),
	 !, % First try is right  %% TA-980123
    makeanswer(true,Q,Program,Panswer), %% TA-980122
	 writeanswer(Panswer).

%	 (Panswer).    %% TA-980123

pragma_init(M,State,Old,New) :-  %% TA-970523
    pragma_aux(M,State,Old,New).




