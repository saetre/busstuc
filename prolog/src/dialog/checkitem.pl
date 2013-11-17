%% lche :- load_files('dialog/checkitem.pl').

:- ensure_loaded('../utility/utility'). %% [roundmember/2 etc.]
%% :- ensure_loaded('../declare').

:- volatile current_frame/1.
:- dynamic current_frame/1.


%% User input terminals

checkitem(uati, focus(OldFrame, OldRefer, slot(Slot)), focus(NewFrame, NewRefer, [])) :-
    getcurrent(Cid),
    getcontext(Cid, context((item, Item isa _), _, _, _)),
    frame_getsubslots(Slot, SubSlot),
    frame_gettype_rec(OldFrame, SubSlot, Type),
    istype(Item, Type),
    !,
    (addref(Cid, Item, Type) ; true),
    commitref(Cid, OldRefer, NewRefer),
    frame_setvalue_rec(OldFrame, SubSlot, Item, NewFrame).

checkitem(uadi, focus(OldFrame, OldRefer, [Tql, _Prog]), focus(NewFrame, NewRefer, [NewTql, NewProg])) :-
    getcurrent(Cid),
    getcontext(Cid, context((item, Item isa ItemType), _, _, _)),
    roundmember(whichref(RefType, _) isa _, Tql),
    issubclass(ItemType, RefType), 
    (addref(Cid, Item, ItemType) ; true),
    commitref(Cid, OldRefer, NewRefer),
    subst_tql(whichref(RefType, _), Item, Tql, NewTql),
    assert(current_frame(OldFrame)),
    pragma(trans, NewTql, NewProg),
    retractall(current_frame(_)),
    updateframe(NewProg, OldFrame, NewFrame).


checkitem(uin, focus(OldFrame, OldRefer, _Query), focus(NewFrame, NewRefer, [(new, Rest), Program])) :-
    getcurrent(Cid),
    getcontext(Cid, context((new, Rest), _, TempRefer, NodeStack)),
    assert(current_frame(OldFrame)),
    pragma(trans, (new, Rest), Program),
    nl, nl, nl, writeq(Program), nl, nl,
    retractall(current_frame(_)),
    setcontext(Cid, context((new, Rest), Program, TempRefer, NodeStack)),
    updateframe(Program, OldFrame, NewFrame),
    getuserrefer(Cid, Rest),
    commitref(Cid, OldRefer, NewRefer).
    


checkitem(uim, focus(OldFrame, OldRefer, [Tql, OldProg]), focus(NewFrame, NewRefer, [Tql, NewProg])) :-
    getcurrent(Cid),
    getcontext(Cid, context((modifier(X), Rest), _, _TempRefer, _NodeStack)),
    assert(current_frame(OldFrame)),
    pragma(trans, (modifier(X), Rest), ModProgram),
    retractall(current_frame(_)),
    updateframe(ModProgram, OldFrame, NewFrame),
    getuserrefer(Cid, Rest),
    commitref(Cid, OldRefer, NewRefer),
    saturatemod(NewFrame, OldProg, NewProg).

checkitem(uim, Focus, Focus) :-
    getcurrent(Cid),
    getcontext(Cid, context((confirm, false), _, _, _)).


checkitem(uatm, focus(OldFrame, OldRefer, slot(Slot)), focus(NewFrame, NewRefer, slot(Slot))) :-
    getcurrent(Cid),
    getcontext(Cid, context((modifier(X), Rest), _, _TempRefer, _NodeStack)),
    assert(current_frame(OldFrame)),
    pragma(trans, (modifier(X), Rest), ModProgram),
    retractall(current_frame(_)),
    (
     	updateframe_checkanswer(ModProgram, Slot, OldFrame, NewFrame) 
	;
    	(updateframe(ModProgram, OldFrame, TempFrame),
        frame_getsubslots(Slot, SubSlot),
    	checkanswer((modifier(X), Rest), ModProgram, SubSlot, TempFrame, NewFrame)) 
    ),
    getuserrefer(Cid, Rest),
    commitref(Cid, OldRefer, NewRefer).

checkitem(uiq, focus(OldFrame, OldRefer, _), focus(NewFrame, NewRefer, [(Type, Rest), Program])) :-
    getcurrent(Cid),
    getcontext(Cid, context((Type, Rest), _, _TempRefer, _NodeStack)),
    \+ member(Type, [new, modifier(_), item]),
    assert(current_frame(OldFrame)),
    pragma(trans, (Type, Rest), Program),
    retractall(current_frame(_)),
    updateframe(Program, OldFrame, NewFrame),
    getuserrefer(Cid, Rest),
    commitref(Cid, OldRefer, NewRefer). 

checkitem(uatg, focus(OldFrame, OldRefer, slot(Slot)), focus(NewFrame, NewRefer, [])) :-
    getcurrent(Cid),
    getcontext(Cid, context(Tql, _, _, _)),
    pragma(trans, Tql, Program),
    frame_getsubslots(Slot, SubSlot),
    checkanswer(Tql, Program, SubSlot, OldFrame, NewFrame),
    !,
    getuserrefer(Cid, Tql),
    commitref(Cid, OldRefer, NewRefer).


%% System output terminals

checkitem(sant, focus(Frame, OldRefer, [Tql, Prog]), focus(Frame, NewRefer, [Tql, Prog])) :-
    getcurrent(Cid),
    roundmember(XFrog, Tql),      %% TA-980525
    trytofool(XFrog, Delphi),
    !,
    Panswer = (bcp(Delphi), period), %% TA-980609   DELPHI answer
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'), nl,
    writeanswer(Panswer), 
    commitref(Cid, OldRefer, NewRefer).

checkitem(sant, focus(Frame, OldRefer, [Tql, Prog]), focus(Frame, NewRefer, [Tql, Prog])) :-
    getcurrent(Cid),
    roundmember(XFrog, Tql),      %% TA-980525
    totallyignorant(XFrog, Frog), %% TA-980525  Independant of answer
    !,
    Panswer = (bcp(noinformation), bcp(Frog), period), %% TA-980518
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'), nl,
    writeanswer(Panswer), 
    commitref(Cid, OldRefer, NewRefer).

checkitem(sat, focus(Frame, OldRefer, [Tql, Prog]), focus(Frame, NewRefer, [Tql, NewProg])) :-
    saturate(Frame, Prog, NewProg),
    (roundmember(nocontext, NewProg) ; frame_iscomplete(Frame, []) ),
    copy_term(NewProg, NewProg2),
    getcurrent(Cid),
    isuccess(NewProg2),
    (NewProg2), !, 
    makeanswer(true, Tql, NewProg2 , AnswerOut),
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'), nl,
    writeanswer(AnswerOut),
    commitref(Cid, OldRefer, NewRefer). 

checkitem(saf, focus(Frame, OldRefer, [Tql, Prog]), focus(Frame, NewRefer, [Tql, NewProg])) :-
    saturate(Frame, Prog, NewProg),
    getcurrent(Cid),
    test(roundmember(message(_), NewProg)), %% Test at least one message
    !,
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'), nl,
    for(roundmember(message(T), NewProg),   %% Print all messages
        (printmessage(T), nl)), %% NB, despite Busprogram failed
    commitref(Cid, OldRefer, NewRefer).


checkitem(saf, focus(Frame, OldRefer, [Tql, Prog]), focus(Frame, NewRefer, [Tql, NewProg])) :-
    saturate(Frame, Prog, NewProg),
    getcurrent(Cid),
    makenegative(Tql, NewProg, AnswerOut),
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'), nl,
    writeanswer(AnswerOut),
    !, 
    commitref(Cid, OldRefer, NewRefer).

checkitem(sqt, focus(Frame, OldRefer, [Tql, Prog]), focus(Frame, NewRefer, slot(NewSlot))) :-
    saturate(Frame, Prog, NewProg),
    getcurrent(Cid),
    roundmember(askfor(X, Slot, Y), NewProg),  
    \+ frame_getvalue_rec(Frame, Slot, _, _), !, 
    find_askfor(Frame, Slot, NewSlot),
    makenegative(Tql, askfor(X, NewSlot, Y), AnswerOut),
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'), nl,
    writeanswer(AnswerOut),
    !, 
    commitref(Cid, OldRefer, NewRefer).

checkitem(sqt, focus(Frame, OldRefer, [Tql, Prog]), focus(Frame, NewRefer, slot(Slot))) :-
    saturate(Frame, Prog, NewProg),
    \+ roundmember(nocontext, NewProg),
    frame_iscomplete(Frame, [Slot | _]),
    getcurrent(Cid),
    find_askfor(Frame, Slot, NewSlot),
    makenegative(Tql, (askfor([], NewSlot, _), NewProg), AnswerOut),
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'), nl,
    writeanswer(AnswerOut),
    !, 
    commitref(Cid, OldRefer, NewRefer).

checkitem(sqd, focus(Frame, Refer, [Tql, Prog]), focus(Frame, Refer, [Tql, Prog])) :-
%%    getcurrent(Cid),
    roundmember(askref(_Type, _List), Prog),  
    makenegative(Tql, Prog, AnswerOut),
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'), nl,
    writeanswer(AnswerOut).

checkitem(relax, focus(Frame, Refer, [Tql, Prog]), focus(Frame, Refer, [Tql, NewProg2])) :-
    saturate(Frame, Prog, Prog2),
    \+ roundmember(message(_), Prog2),  %% No use in relaxing constraints 
    dorelax(Prog2, NewProg, Results),
    flatroundre((nocontext, (Results, NewProg)), NewProg2).
    
checkitem(uatf, focus(OldFrame, Refer, slot(Slot)), focus(NewFrame, Refer, slot(Slot))) :-
    find_parentslot(OldFrame, Slot, PSlot),
    frame_setexperience(OldFrame, PSlot, 0, NewFrame).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


checkitem(no, Focus, Focus) :- 
    getcurrent(Cid),
    getcontext(Cid, context((confirm,false), _, _, _)).

checkitem(yes, Focus, Focus) :-  
    getcurrent(Cid),
    getcontext(Cid, context((confirm,true), _, _, _)).

checkitem(tbu_time, focus(Frame, Refer, _), focus(Frame, Refer, clock(Time))) :-
    getcurrent(Cid),
    getcontext(Cid, context(Tql, _, _, _)),
    roundmember(Time isa clock, Tql).

checkitem(tbu_arr, focus(OldFrame, Refer, clock(Time)), focus(NewFrame, Refer, [])) :-
    getcurrent(Cid),    
    getcontext(Cid, context(Tql, _, _, _)),    
    roundmember(_ isa arrival, Tql),
    frame_setvalue_rec(OldFrame,  when::arrival::after, ?, OldFrame2),
    frame_setvalue_rec(OldFrame2, when::departure::after, ?, OldFrame3),
    frame_setvalue_rec(OldFrame3, when::departure::before, ?, OldFrame4),    
    frame_setvalue_rec(OldFrame4, when::arrival::before, Time, NewFrame).

checkitem(tbu_dep, focus(OldFrame, Refer, clock(Time)), focus(NewFrame, Refer, [])) :-
    getcurrent(Cid),
    getcontext(Cid, context(Tql, _, _, _)),
    roundmember(_ isa departure, Tql),
    frame_setvalue_rec(OldFrame,  when::arrival::after, ?, OldFrame2),
    frame_setvalue_rec(OldFrame2, when::arrival::before, ?, OldFrame3),
    frame_setvalue_rec(OldFrame3, when::departure::before, ?, OldFrame4),    
    frame_setvalue_rec(OldFrame4, when::departure::after, Time, NewFrame).

checkitem(tbu_station, focus(OldFrame, OldRefer, slot(Slot)), focus(NewFrame, NewRefer, [])) :- 
    getcurrent(Cid),
    getcontext(Cid, context(Tql, _, _, _)),
    frame_gettype_rec(OldFrame, Slot, Type),
    roundmember(Item isa _, Tql),
    istype(Item, Type),
    (addref(Cid, Item, Type) ; true),
    commitref(Cid, OldRefer, NewRefer),
    frame_setvalue_rec(OldFrame, Slot, Item, NewFrame).

checkitem(tbu_station,  focus(Frame, Refer, slot(_Slot)), focus(Frame, Refer, [])) :-
    getcurrent(Cid),
    getcontext(Cid, context((confirm,true), _, _, _)).
% (yes/no)
  
checkitem(tbu_notAStation,  focus(OldFrame, Refer, slot(Slot)), focus(NewFrame, Refer, slot(Slot))) :-
    getcurrent(Cid),
    getcontext(Cid, context((confirm,false), _, _, _)),
    frame_setvalue_rec(OldFrame, Slot, ?, NewFrame).
	
   
checkitem(tbu_day, focus(OldFrame, Refer, X), focus(NewFrame, Refer, X)) :-
    getcurrent(Cid),
    getcontext(Cid, context(Tql, _, _, _)),
    roundmember(_ isa Day, Tql),
    isday(Day),
    frame_setvalue_rec(OldFrame, when::day, Day, NewFrame).

checkitem(tbu_day, focus(OldFrame, Refer, X), focus(NewFrame, Refer, X)) :-
    getcurrent(Cid),
    getcontext(Cid, context(Tql, _, _, _)),
    roundmember(srel/tomorrow/_/_/_, Tql),
    today(Today), 
    daysucc(Today, Tomorrow),
    frame_setvalue_rec(OldFrame, when::day, Tomorrow, NewFrame).

checkitem(tbu_day, focus(OldFrame, Refer, X), focus(NewFrame, Refer, X)) :-
    getcurrent(Cid),
    getcontext(Cid, context(Tql, _, _, _)),
    roundmember(srel/today/_/_/_, Tql),
    frame_setvalue_rec(OldFrame, when::day, ?, NewFrame).

checkitem(tbu_notaday, focus(OldFrame, Refer, X), focus(NewFrame, Refer, X)) :-
    getcurrent(Cid),
    getcontext(Cid, context((confirm,false), _, _, _)),
    frame_setvalue_rec(OldFrame, when::day, ?, NewFrame).
		
				
	
checkitem(sayq(Output), Focus, Focus) :- 
    checkitem(say(Output), Focus, Focus).
    
checkitem(say(Output), Focus, Focus) :-
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'), nl,
    writeanswer(bcpbc(Output)), nl.

checkitem(tbs_fromwhere, focus(Frame, Refer, _), focus(Frame, Refer, slot(where::departure))) :-
    frame_getvalue_rec(Frame, where::departure, Place, _Type),
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'), nl,
    writeanswer((bcpbc(tbs_askref_from), bwr(Place))), nl.

checkitem(tbs_fromwhere, focus(Frame, Refer, _), focus(Frame, Refer, slot(where::departure))) :-
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'), nl,
    writeanswer(bcpbc(tbs_fromwhere)), nl.

    
checkitem(tbs_towhere, focus(Frame, Refer, _), focus(Frame, Refer, slot(where::arrival))) :-
    frame_getvalue_rec(Frame, where::arrival, Place, _Type),
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'), nl,
    writeanswer((bcpbc(tbs_askref_to), bwr(Place))), nl.

checkitem(tbs_towhere, focus(Frame, Refer, _), focus(Frame, Refer, slot(where::arrival))) :-
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'), nl,
    writeanswer(bcpbc(tbs_towhere)), nl.

checkitem(tbs_whichday, focus(Frame, Refer, _), focus(Frame, Refer, slot(where::departure))) :-
    frame_getvalue_rec(Frame, when::day, Day, _Type),
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'), nl,
    writeanswer((bcpbc(tbs_askref_day), bwr(Day))), nl.

checkitem(tbs_whichday, focus(Frame, Refer, _), focus(Frame, Refer, slot(where::departure))) :-
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'), nl,
    writeanswer(bcpbc(askfor(when::day))), nl.

checkitem(tbs_dep, focus(Frame, Refer, clock(Time)), focus(Frame, Refer, clock(Time))) :-
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),
    write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'), nl,
    writeanswer((bcpbc(tbs_deporarr), bwt(Time))), nl.

checkitem(tbs_generate, focus(Frame, Refer, _), focus(Frame, Refer, [Tql, NewProg])) :-
    Tql = (which(A),B isa bus,A isa time,go/B/C,event/real/C,srel/in/time/A/C),
    saturate(Frame, (today(X),atday(X),addcontext), NewProg).

checkitem(tbs_sat, X, Y) :-
	checkitem(sat, X, Y).
		
checkitem(tbs_relax, X, Y) :-
	checkitem(relax, X, Y).


%% checkanswer(TQL, Prog, Slot).

checkanswer(TQL, _, when::day, OldFrame, NewFrame) :-
    roundmember(_ isa Day, TQL),
    isday(Day),
    frame_setvalue_rec(OldFrame, when::day, Day, NewFrame).
 
checkanswer(TQL, _, when::day, OldFrame, NewFrame) :-
    roundmember(srel/tomorrow/_/_/_, TQL),
    today(Today), 
    daysucc(Today, Tomorrow),
    frame_setvalue_rec(OldFrame, when::day, Tomorrow, NewFrame).

checkanswer(TQL, _, when::day, OldFrame, NewFrame) :-
    roundmember(srel/today/_/_/_, TQL),
    today(Today), 
    frame_setvalue_rec(OldFrame, when::day, Today, NewFrame).

sysout_item(sant).
sysout_item(sat).
sysout_item(saf).
sysout_item(sqt).
sysout_item(sqd).
sysout_item(sayq(_)).
sysout_item(tbs_fromwhere).
sysout_item(tbs_towhere).
sysout_item(tbs_whichday).
sysout_item(tbs_dep).
