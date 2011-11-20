lgra:- load_files('dialog/grammar.pl'). 

% Dialog := UserQs
gram(dialog, [
        [sub(userQs), item(dialogerror), sub(dialog)]
        ],
        []).

% UserQs := UserQ UserQs
%         | []
gram(userQs, [
        [sub(userQ), sub(userQs)],
        []
        ],
        []).

% UserQ := uiq, UiqRepl
%        | uin, UinRepl
%        | []
gram(userQ, [
        [item(uin), sub(uiqRepl)],
        [item(uiq), sub(uiqRepl)]
        ],
        []).

% UiqRepl := sant
%          | Askrefs, Askfors, UiqRepl2
gram(uiqRepl, [
        [item(sant)],
        [sub(askrefs), sub(askfors), sub(uiqRepl2)]
        ],
        []).

% UiqRepl2 := sat, modify
%          | saf
gram(uiqRepl2, [
        [item(sat), sub(modify)],
        [item(relax), item(sat), sub(modify)],
        [item(saf)]
        ],
        []).

% Askrefs := Askref Askrefs
%          | []
gram(askrefs, [
        [sub(askref), sub(askrefs)],
        []
        ],
        [queryUp]).

% Askref := sqd, SqdRepl
gram(askref, [
        [item(sqd), sub(sqdRepl)]
        ],
        [queryUp]).

% SqdRepl := uadi
%         | uadm
%         | uadn
%         | uadq
gram(sqdRepl,[
        [item(uadi)],
        [item(uadm)],
        [item(uadn)],
        [item(uadq)]
        ],
        [queryUp]).


% Askfors := Askfor Askfors
%          | []
gram(askfors, [
        [sub(askfor), sub(askfors)],
        []
        ],
        []).

% Askfor := sqt, UserQs, SqtRepl
gram(askfor, [
        [item(sqt), sub(userQs), sub(sqtRepl)]
        ],
        []).

% SqtRepl := uati
%         | uatm
%         | uatn
%	  | uatg
gram(sqtRepl,[
        [item(uati)],
        [item(uatm)],
        [item(uatn)],
        [item(uatg)],
	[item(uatf)]
        ],
        []).

% Modify := uim, UiqRepl
%         | []
gram(modify,[
        [item(uim), sub(uiqRepl)],
        []
        ],
        []).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Tb_start := tbs_welcomegreeting, tbs_welcomequestion, Tb_start2 
%        | []
gram(tb_start, [
	[item(say(tbs_welcomegreeting)), item(sayq(tbs_welcomequestion)), sub(tb_start2)],
	[]
	],
	[]).

% Tb_start2 := no, tbs_userhelp, Tb_from
%            | yes, Tb_from
%            | []
gram(tb_start2, [
	[item(no), item(say(tbs_userhelp)), sub(tb_from)],
	[item(yes), sub(tb_from)],
	[]
	],
	[]).

% Tb_from := tbs_fromwhere, Tb_from2
%          | []
gram(tb_from, [
	[item(tbs_fromwhere), sub(tb_from2)],
	[]
	],
	[]).

% Tb_from2 := tbu_station, Tb_to
%	    | tbu_notAStation, Tb_from
%	    | []
gram(tb_from2, [
	[item(tbu_station), sub(tb_to)],
	[item(tbu_notAStation), sub(tb_from)],
	[]
	],
	[]).

% Tb_to := tbs_towhere, Tb_to2
%        | []
%gram(tb_to, [
%        [item(tbs_towhere), sub(tb_to2)],
%	[]
%	],
%	[]).
%
% Tb_to2 := tbu_station, Tb_whatTime
%         | tbu_notAStation, Tb_to

%gram(tb_to2, [
%	[item(tbu_station), sub(tb_whatTime)],
%	[item(tbu_notAStation), sub(tb_to)],
%	[]
%	],
%	[]).

gram(tb_to, [
        [item(tbs_towhere), sub(tb_to2)]
	],
	[]).

gram(tb_to2, [
	[item(tbu_station), sub(tb_timeOrNot)],
	[item(tbu_notAStation), sub(tb_to)],
	[]
	],
	[]).

gram(tb_timeOrNot, [
        [item(sayq(tbs_wishtime)), sub(tb_timeOrNot2)]
        ],
	[]).

gram(tb_timeOrNot2, [
        [item(yes), sub(tb_day)],
        [item(no), sub(tb_answer), sub(tb_otherBus)]
        ],
	[]).


gram(tb_day, [
        [item(tbs_whichday), sub(tb_day2)]
        ],
	[]).

gram(tb_day2, [
        [item(tbu_day), sub(tb_whatTime)],
	[item(tbu_notaday), sub(tb_day)]
        ],
	[]).

%gram(tb_listAllRoutes, [
%        [item(tbu_routeinfo), sub(tb_timeOrNot)]
%        ],
%        []).
% Tb_whatTime := tbs_whentotravel, Tb_whatTime2
%              | []

gram(tb_whatTime, [
        [item(sayq(tbs_whentotravel)), sub(tb_whatTime2)],
	[]
        ],
	[]).

% Tb_whatTime2 := tbu_time, Tb_depOrArr
%               | no, Tb_otherBus
gram(tb_whatTime2, [
        [item(tbu_time), sub(tb_depOrArr)],
        [item(no), sub(tb_otherBus)],
	[]
        ],
	[]).

% Tb_depOrArr := tbs_dep, Tb_depOrArr2
%              | []
gram(tb_depOrArr, [
        [item(tbs_dep), sub(tb_depOrArr2)],
	[]
        ],
	[]).

% Tb_depOrArr2 := tbu_dep, tb_answer, Tb_otherTime
%               | tbu_arr, tb_answer, Tb_otherTime
%               | []
gram(tb_depOrArr2, [
        [item(tbu_dep), sub(tb_answer), sub(tb_otherTime)],
        [item(tbu_arr), sub(tb_answer), sub(tb_otherTime)],
	[]
        ],
	[]).

% Tb_otherTime := tbs_asknewtime, Tb_otherTime2
%               | []
gram(tb_otherTime, [
        [item(sayq(tbs_asknewtime)), sub(tb_otherTime2)] ,
	[]	
        ],
	[]).

% Tb_otherTime2 := yes, Tb_whatTime
%                | no, Tb_otherBus
%                | []
gram(tb_otherTime2, [
        [item(yes), sub(tb_whatTime)],
        [item(no), sub(tb_otherBus)],
	[]
        ],
	[]).
%gram(tb_otherTime2, [
%        [item(yes), sub(tb_day)],
%        [item(no), sub(tb_otherBus)]
%        ],
%	[]).

% Tb_otherBus := tbs_asknewbusconnection, Tb_otherBus2
%              | []
gram(tb_otherBus, [
        [item(sayq(tbs_asknewbusconnection)), sub(tb_otherBus2)],
	[]
        ],
	[]).

% Tb_otherBus2 := yes, Tb_from
%               | no, tbs_endmsg 
gram(tb_otherBus2, [
        [item(yes), sub(tb_from)],
        [item(no), item(sayq(tbs_endmsg))],
	[]
        ],
	[]).

gram(tb_answer, [
	[item(tbs_generate), sub(tb_answer2)]
	],
	[]).

gram(tb_answer2, [
	[item(tbs_sat)],
	[item(tbs_relax), item(tbs_sat)]
	],
	[]).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% main :-
%%     retractall(myinput(_)),
%%     run([node(dialog, [], [[sub(userQs)]]) ], X),
%%     myinput([]).

g_select([node(Type, Focus, [ First | _]) | RestStack ], NewStack, Multi) :-
    g_execute([node(Type, Focus, First) | RestStack ], NewStack, Multi), !.

g_select([node(Type, Focus, [ _ | Rest]) | RestStack ], NewStack, Multi) :-
    g_select([node(Type, Focus, Rest) | RestStack ], NewStack, Multi).



g_execute([node(Type, Focus, [sub(SubType) | RestAct]) | RestStack ], 
    NewStack, Multi) :-
    gram(SubType, Actions, Options), 
    copydown(Options, Focus, SubFocus),
    g_select([node(SubType, SubFocus, Actions), node(Type, Focus, RestAct) | RestStack], 
	NewStack, Multi).

    
g_execute([node(Type, OldFocus, [item(ItemType) | RestAct]) | RestStack ], 
    NewStack, Multi) :-
    checkitem(ItemType, OldFocus, NewFocus),
    gram(Type, _, Options),
    copyright(Options, NewFocus, NextFocus),
    ((sysout_item(ItemType) ; Multi) -> 
       NewStack = [node(Type, NextFocus, RestAct) | RestStack ] ;
       g_execute([node(Type, NextFocus, RestAct) | RestStack ], NewStack, Multi)
    ).


g_execute([node(SubType, SubFocus, []), node(Type, Focus, RestAct) | RestStack ], NewStack, Multi) :-
    gram(SubType, _, Options),
    copyup(Options, SubFocus, Focus, NewFocus),
    g_execute([node(Type, NewFocus, RestAct) | RestStack], NewStack, Multi).

g_execute([node(_, _, [])], [], _).


copydown([], X, X).
copydown(_, X, X).


copyright([], X, X).
copyright(_, X, X).

copyup([], focus(Frame, Refer, _), focus(_, _, Query), focus(Frame, Refer, Query)).
copyup(List, focus(Frame, Refer, Query), focus(_, _, _), focus(Frame, Refer, Query)) :-
	member(queryUp, List).

	
