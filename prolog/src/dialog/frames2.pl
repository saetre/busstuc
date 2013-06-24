%% FILE  frames2.pl
%% SYSTEM BUSTER
%% CREATED TA-051016
%% REVISED TA-060419




%% Common version for frames and teleframes 

%frameval(Type, Value, Filled, Confirmed, Experience)
%subframe(Template, Id,)

:- use_module(library(system)).

:- assert(framecounter(1)).

:- ensure_loaded('../declare'). %% RS-111213 General (semantic) Operators


%% Frame Declarations


frametemplate(telebuster,               %% NEW, UNION OF tele and bustuc
    [   [where, ?, subframe(where), 1],
        [when, ?, subframe(when), 1],
        [day, ?, class(day), 0],    %% explicit, incomplete for when questions %% TA-051117
        [date, ?, class(date), 0],  
        [bus, ?, class(bus), 0],
 
        [attributes,  ?, subframe(attributes),    1],
        [itemsfound, ?, subframe(itemsfound),   1],
        [return, ?, class(attribute), 0],

        [language, ?, class(language), 0],  %% TA-060309
        [topic, ?, class(thing), 0]         %% remember last topic    %% TA-060328 

  ]).




frametemplate(bustuc,
    [   [where, ?, subframe(where), 1],
        [when, ?, subframe(when), 1],
        [day, ?, class(day), 0],  %% explicit, incomplete for when questions %% TA-051117
        [date, ?, class(date), 0],%% 
        [bus, ?, class(bus), 0]
    ]).

frametemplate(where,   % where do you want to go: nardo = to NARDO %% TA-030515
    [	[arrival, ?, class(place), 0],  %% more relevant for where questions
      [departure, ?, class(place), 0],
    	[direction, ?, class(direction), 0] 
    ]).


frametemplate(when,
    [   [departure, ?, subframe(time), 1],
        [arrival, ?, subframe(time), 1]
%%%          [day, ?, class(day), 0]    %% TA-051117incomplete if only day
    ]).

frametemplate(time,
    [   [after, ?, class(number), 0],
          [before, ?, class(number), 0]
    ]).

frametemplate(time2,
    [   [before, ?, class(number), 0],
          [after, ?, class(number), 0]
    ]).

%% Frames for the tele domain   TLF-030331

frametemplate(teletuc,
    [   [attributes,  ?, subframe(attributes),    1],
        [itemsfound, ?, subframe(itemsfound),   1],
        [return, ?, class(attribute), 0]
    ]).


frametemplate(attributes,                         %% TA-060419
    [   [spacename,       ?, class(spacename),0], %% non person room name name
        [givenname,       ?, class(firstname), 0],
        [sn,              ?, class(lastname), 0],
        [telephonenumber, ?, class(telephonenumber), 0],
        [cn,              ?, class(name), 0],
        [department,      ?, class(department), 0],
        [title,           ?, class(title), 0]  %% TA-051011

    ]).

frametemplate(itemsfound,
    [   [items,     ?, class(items), 0],
        [itemcount, ?, class(int),   0]
    ]).


%% Don't be dogmatic and ask  when::departure or when::arrival          '

completeframe(
    [

    [ partly(when), full(where::departure), full(where::arrival)],   %% TA-030224
    [ partly(when), full(where::departure), full(where::direction)], %%
    [ partly(when), full(where::arrival),   full(where::direction)]  %%

    ]
    ).


completeteleframe(
    [
        sn,
        givenname,
        department
    ]
    ).



completeteleframe( %%  hva er adressen til AITEL ?
    [              %% TA-051213
        department
    ]
    ).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Frame Service functions


resetframe :-    % unnec                           %% TLF-030402
    value(teleflag, true),!,
    getcurrent(Cid),
    frametemplate(telebuster, NewFrame),    %% TA-051018
    setframe(Cid, NewFrame).

resetframe :-
    getcurrent(Cid),
    frametemplate(telebuster, NewFrame),  %% TA-051018
    setframe(Cid, NewFrame).

%%%%%%%%%%%% %% DUBIOUS %% TA-060117 


frame_setexperience(Frame, Slot, Value, NewFrame) :-
        frame_setexperience_rec(Frame, Slot, Value, NewFrame).

frame_setexperience_rec(Frame, Super::Rest, Value, NewFrame) :-
        member([Super, ?, subframe(Type), X], Frame),
        frametemplate(Type, NewSubFrame),
        substitute([Super, ?, subframe(Type), X], Frame, [Super, NewSubFrame, subframe(Type), X], Frame1),
        frame_setexperience_rec(Frame1, Super::Rest, Value, NewFrame).

frame_setexperience_rec(Frame, Super::Rest, Value, NewFrame) :-
        member([Super, SubFrame, subframe(Type), X], Frame),
        frame_setexperience_rec(SubFrame, Rest, Value, NewSubFrame),
        substitute([Super, SubFrame, subframe(Type), X], Frame, [Super, NewSubFrame, subframe(Type), X], NewFrame).

frame_setexperience_rec(Frame, Slot, Value, NewFrame) :-
        member([Slot, X, subframe(Type), OldVal], Frame),
        substitute([Slot, X, subframe(Type), OldVal], Frame, [Slot, X, subframe(Type), Value], NewFrame).


frame_getexperience(Frame, Slot, Value, Type) :-
        frame_getexperience_rec(Frame, Slot, Value, Type).

frame_getexperience_rec(Frame, Super::Rest, Value, Type) :-
        member([Super, SubFrame, subframe(_), _], Frame),
        frame_getexperience_rec(SubFrame, Rest, Value, Type).

frame_getexperience_rec(Frame, Slot, Value, Type) :-
        member([Slot, _, subframe(Type), Value], Frame).


%%%%%%%%%%%

xframe_setvalue(Slot, Value) :-  %% TA-060328
    value(dialog,1),
    !,
    frame_setvalue(Slot, Value).
xframe_setvalue(_Slot, _Value).

xframe_getvalue(Slot, Value) :-  %% TA-060328
     value(dialog,1),
     frame_getvalue(Slot, Value,_Type).
xframe_getvalue(_Slot, nil). %% NB nil not []

%%%%%%%%%%%


frame_setvalue(Slot, Value) :-
    getcurrent(Cid),
    getframe(Cid, Frame),
    frame_setvalue_rec(Frame, Slot, Value, NewFrame),
    setframe(Cid, NewFrame).


frame_setvalue_rec(Frame, Super::Rest, Value, NewFrame) :-
    member([Super, ?, subframe(Type), X], Frame),
    frametemplate(Type, NewSubFrame),
    substitute([Super, ?, subframe(Type), X], Frame, [Super, NewSubFrame, subframe(Type), X], Frame1),
    frame_setvalue_rec(Frame1, Super::Rest, Value, NewFrame).

frame_setvalue_rec(Frame, Super::Rest, Value, NewFrame) :-
    member([Super, SubFrame, subframe(Type), X], Frame),
    frame_setvalue_rec(SubFrame, Rest, Value, NewSubFrame),
    substitute([Super, SubFrame, subframe(Type), X], Frame, [Super, NewSubFrame, subframe(Type), X], NewFrame).

frame_setvalue_rec(Frame, Slot, Value, NewFrame) :-
    member([Slot, OldVal, class(Type), XCount], Frame),
    linecounter(Count),
    substitute([Slot, OldVal, class(Type), XCount], Frame, [Slot, Value, class(Type), Count], NewFrame).

frame_getsubslots(StartSlot, Slot) :-           %% TLF 030402
    value(teleflag, true),!,
    frametemplate(telebuster, Frame),           %% TA-051018
    frame_getsubslots(Frame, StartSlot, Slot).

frame_getsubslots(StartSlot, Slot) :-
    frametemplate(telebuster, Frame),           %% TA-051018
    frame_getsubslots(Frame, StartSlot, Slot).

frame_getsubslots(Frame, Super::Rest, Super::Slot) :-
    member([Super, _, subframe(Type), _], Frame),
    frametemplate(Type, SubFrame),
    frame_getsubslots(SubFrame, Rest, Slot).

frame_getsubslots(Frame, StartSlot, StartSlot::Slot) :-
    member([StartSlot, _, subframe(Type), _], Frame),
    frametemplate(Type, SubFrame),
    frame_getsubslots_rec(SubFrame, Slot).

frame_getsubslots(Frame, Slot, Slot) :-
    member([Slot, _, class(_), _], Frame).

frame_getsubslots_rec(Frame, Slot) :-
    member([Slot, _, class(_), _], Frame).

frame_getsubslots_rec(Frame, Super::Slot) :-
    member([Super, _, subframe(Type), _], Frame),
    frametemplate(Type, SubFrame),
    frame_getsubslots_rec(SubFrame, Slot).

frame_getvalue(Slot, Value, Type) :-
    getcurrent(Cid),
    getframe(Cid, Frame),
    frame_getvalue_rec(Frame, Slot, Value, Type).

frame_getvalue_rec(Frame, Super::Rest, Value, Type) :-
    member([Super, SubFrame, subframe(_), _], Frame),
    frame_getvalue_rec(SubFrame, Rest, Value, Type).

frame_getvalue_rec(Frame, Slot, Value, Type) :-
    member([Slot, Value, class(Type), _], Frame),
    \+ Value == ? .

frame_gettype(Slot, Type) :-
    getcurrent(Cid),
    getframe(Cid, Frame),
    frame_gettype_rec(Frame, Slot, Type).

frame_gettype_rec(Frame, Super::Rest, Type) :-
    member([Super, _, subframe(SuperType), _], Frame),
    frametemplate(SuperType, NewSubFrame),
    frame_gettype_rec(NewSubFrame, Rest, Type).

frame_gettype_rec(Frame, Slot, Type) :-
    member([Slot, _, class(Type), _], Frame).

frame_getcount(Slot, Count) :-
    getcurrent(Cid),
    getframe(Cid, Frame),
    frame_getcount_rec(Frame, Slot, Count).

frame_getcount_rec(Frame, Super::Rest, Count) :-
    member([Super, SubFrame, subframe(_), _], Frame),
    frame_getcount_rec(SubFrame, Rest, Count).

frame_getcount_rec(Frame, Slot, Count) :-
    member([Slot, Value, class(_), Count], Frame),
    \+ Value == ? .

frame_getcount_rec(_, _, 0).

frame_isfull(Slot) :-
    getcurrent(Cid),
    getframe(Cid, Frame),
    frame_isfull_rec(Frame, Slot).

frame_isfull_rec(Frame, Super::Rest) :-
    !,
    member([Super, SubFrame, subframe(_), _], Frame),
    frame_isfull_rec(SubFrame, Rest).

frame_isfull_rec(Frame, Slot) :-
    member([Slot, SubFrame, subframe(_), _], Frame),
    !,
    frame_isfull_rec2(SubFrame).

frame_isfull_rec(Frame, Slot) :-
    member([Slot, Value, class(_), _], Frame),
    \+ Value = ? .

frame_isfull_rec2([ [_, SubFrame, subframe(_), _] | Rest]) :-
    !,
    \+ SubFrame = ? ,
    frame_isfull_rec2(SubFrame),
    frame_isfull_rec2(Rest).

frame_isfull_rec2([ [_, Value, class(_), _] | Rest]) :-
    !,
    \+ Value = ? ,
    frame_isfull_rec2(Rest).

frame_isfull_rec2([]).


frame_isempty(Slot) :-
    getcurrent(Cid),
    getframe(Cid, Frame),
    frame_isempty_rec(Frame, Slot).

frame_isempty_rec(Frame, Super::_) :-
   %% !,				%% TLF 030425
    member([Super, ?, subframe(_), _], Frame).

frame_isempty_rec(Frame, Super::Rest) :-
    !,
    member([Super, SubFrame, subframe(_), _], Frame),
    frame_isempty_rec(SubFrame, Rest).

frame_isempty_rec(Frame, Slot) :-
    member([Slot, ?, subframe(_), _], Frame).

frame_isempty_rec(Frame, Slot) :-
    member([Slot, SubFrame, subframe(_), _], Frame),
    !,
    frame_isempty_rec2(SubFrame).


frame_isempty_rec(Frame, Slot) :-
    member([Slot, ?, class(_), _], Frame).

frame_isempty_rec(Frame, Super::Rest) :-
    !,
    member([Super, SubFrame, subframe(_), _], Frame),
    frame_isempty_rec(SubFrame, Rest).


frame_isempty_rec([ [_, ?, subframe(_), _] | Rest], Slot) :-
    !,
    frame_isempty_rec(Rest, Slot).

frame_isempty_rec([ [_, SubFrame, subframe(_), _] | Rest], Slot) :-
    !,
    frame_isempty_rec(SubFrame, Slot),
    frame_isempty_rec(Rest, Slot).

frame_isempty_rec([ [_, ?, class(_), _] | Rest], Slot) :-
    !,
    frame_isempty_rec(Rest, Slot).

frame_isempty_rec([], _).

frame_isempty_rec2([ [_, ?, subframe(_), _] | Rest]) :-
    !,
    frame_isempty_rec2(Rest).
frame_isempty_rec2([ [_, SubFrame, subframe(_), _] | Rest]) :-
    !,
    frame_isempty_rec2(SubFrame),
    frame_isempty_rec2(Rest).

frame_isempty_rec2([ [_, ?, class(_), _] | Rest]) :-
    !,
    frame_isempty_rec2(Rest).

frame_isempty_rec2([]).



frame_iscomplete(Miss) :-
    getcurrent(Cid),
    getframe(Cid, Frame),
    frame_iscomplete(Frame, Miss).

frame_iscomplete(Frame, Miss) :-    %% TLF 030403
    value(teleflag, true),
    !,
    (
        frame_isconsistent_tele(Frame),!,
        Miss = []
    ;

        frame_iscomplete_telerec(Frame, Miss)
    ).

frame_iscomplete(Frame, Miss) :-
    completeframe(List),
    frame_iscomplete_rec(Frame, List, missing(999, []), missing(_, Miss)).

frame_isconsistent_tele(Frame) :-
	frame_getvalue_rec(Frame, return, [count|_], _). %% Asked for NO. of. records

frame_isconsistent_tele(Frame) :-                                   %% TLF 030409
    frame_getvalue_rec(Frame, itemsfound::itemcount, 1, _Type). %% FOUND 1 record

frame_isconsistent_tele(Frame) :-                                   %% TLF 030409
    frame_getvalue_rec(Frame, itemsfound::items, Recs, _Type),
    frame_getvalue_rec(Frame, return, [Field|_], _),
    field_is_equal(Recs, Field, _Val). %% -> parseres.pl // all equal (?)

frame_iscomplete_rec(Frame, [First | Rest], Old, New) :-
    frame_iscomplete_rec2(Frame, First, missing(0, []), This),
    smallest_missing_set(Old, This, Temp),
    frame_iscomplete_rec(Frame, Rest, Temp, New).

frame_iscomplete_rec(_, [], X, X).


frame_iscomplete_telerec(Frame, []) :-
	frame_getvalue_rec(Frame, return, [unknown], _),!.

frame_iscomplete_telerec(Frame, Miss) :-                             %% TLF 030409
    frame_getvalue_rec(Frame, itemsfound::itemcount, Count, _Type),
    Count > 1,
    !,
    completeteleframe(List),
    frame_iscomplete_telerec2(Frame, List, Miss).

frame_iscomplete_telerec(Frame, Miss) :-                             %% TLF 030606
	\+ frame_getvalue_rec(Frame, itemsfound::itemcount, _, _),
	completeteleframe(List),
	makeattrlist(List, Miss).

makeattrlist([Last], [attributes::Last]).

makeattrlist([First|Rest],M) :-
	makeattrlist(Rest, MR),
	M = [attributes::First|MR].

frame_iscomplete_telerec2(Frame, [First|Rest], Miss) :-
    frame_isempty_rec(Frame, attributes::First),
    frame_getvalue_rec(Frame, itemsfound::items, Recs, _Type),
    \+ field_is_equal(Recs, First, _Val),
    (frame_getvalue_rec(Frame, return, [Field|_], _) ->
    \+ Field = First; true),
    (
		frame_iscomplete_telerec2(Frame, Rest, MissRest),
		Miss = [attributes::First|MissRest]
	 ;
		Miss = [attributes::First]
	 ).

frame_iscomplete_telerec2(Frame, [First|Rest], Miss) :-
    frame_isempty_rec(Frame, attributes::First),
    frame_isempty_rec(Frame, itemsfound::items),
    (frame_getvalue_rec(Frame, return, [Field|_], _) ->
    \+ Field = First; true),
    (
		frame_iscomplete_telerec2(Frame, Rest, MissRest),
		Miss = [attributes::First|MissRest]
	 ;
		Miss = [attributes::First]
	 ).

frame_iscomplete_telerec2(Frame, [First|Rest], Miss) :-
    frame_getvalue_rec(Frame, attributes::First, doknow, _),
   % frame_isempty_rec(Frame, itemsfound::items),
    (frame_getvalue_rec(Frame, return, [Field|_], _) ->
    \+ Field = First;true),
    (
		frame_iscomplete_telerec2(Frame, Rest, MissRest),
		Miss = [knows(attributes::First)|MissRest]
	 ;
		Miss = [knows(attributes::First)]
	 ).


frame_iscomplete_telerec2(Frame, [_|Rest], Miss) :-
    frame_iscomplete_telerec2(Frame, Rest, Miss).



frame_iscomplete_rec2(Frame, [full(Slot) | Rest], Old, New) :-
    frame_isfull_rec(Frame, Slot),
    !,
    frame_iscomplete_rec2(Frame, Rest, Old, New).

frame_iscomplete_rec2(Frame, [partly(Slot) | Rest], Old, New) :-
    \+ frame_isempty_rec(Frame, Slot),
    !,
    frame_iscomplete_rec2(Frame, Rest, Old, New).

frame_iscomplete_rec2(Frame, [full(Slot) | Rest], missing(OldNum, OldList), New) :-
    NewNum is OldNum + 1,
    frame_iscomplete_rec2(Frame, Rest, missing(NewNum, [Slot | OldList]), New).

frame_iscomplete_rec2(Frame, [partly(Slot) | Rest], missing(OldNum, OldList), New) :-
    NewNum is OldNum + 1,
    frame_iscomplete_rec2(Frame, Rest, missing(NewNum, [Slot | OldList]), New).

frame_iscomplete_rec2(_, [], X, X).

smallest_missing_set(missing(X1, L1), missing(X2, _), missing(X1, L1)) :-
    X1 =< X2.

smallest_missing_set(missing(X1, _), missing(X2, L2), missing(X2, L2)) :-
    X1 > X2.



find_askfor(Frame, PSlot::_, PSlot) :-
    frame_isempty_rec(Frame, PSlot),
    frame_getexperience(Frame, PSlot, 1, _Type).

find_askfor(Frame, PSlot::Slot, NewSlot) :-
    find_askfor_rec(Frame, PSlot, Slot, NewSlot),
        frame_getexperience(Frame, PSlot, 1, _Type).

find_askfor(_, PSlot, PSlot).

find_askfor_rec(Frame, Head, PSlot::_, Head::PSlot) :-
    frame_isempty_rec(Frame, Head::PSlot).

find_askfor_rec(Frame, Head, PSlot::Slot, NewSlot) :-
    find_askfor_rec(Frame, Head::PSlot, Slot, NewSlot).


find_parentslot(Frame, PSlot::_, PSlot) :-
        frame_isempty_rec(Frame, PSlot).

find_parentslot(Frame, PSlot::Slot, NewSlot) :-
        find_parentslot_rec(Frame, PSlot, Slot, NewSlot).

find_parentslot(_, PSlot, PSlot).

find_parentslot_rec(Frame, Head, PSlot::_, Head::PSlot) :-
        frame_isempty_rec(Frame, Head::PSlot).

find_parentslot_rec(Frame, Head, PSlot::Slot, NewSlot) :-
        find_parentslot_rec(Frame, Head::PSlot, Slot, NewSlot).


is_subframe(Head::Rest1, Head::Rest2) :-
    is_subframe(Rest1, Rest2).
is_subframe(Head::_, Head).
is_subframe(Head, Head).



%%%%%%%%%%%%%%%5
