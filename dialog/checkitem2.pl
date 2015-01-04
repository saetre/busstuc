/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE checkitem2.pl %% Common Version for checkitem bus/tele
%% SYSTEM BUSTER
%% CREATED TA-050927
%% REVISED TA-060707

%% Synthesis of old checkitem.pl and checkitemtele.pl    %:-module( checkitem, [] ) IS OBSOLETE!   %% RS-140914

%% UNIT /dialog/
:-module( checkitem2, [ checkitem/3, current_frame/1, remove_messages/2,  remtp/3, sysout_item/1, writeconstlist/1, writeconstlist1st/1 ] ). %execute_program/1, writeanswer/1,  

%:- meta_predicate  execute_program( 0 ).  %% Stay inside interapp? %% RS-140619
%:- meta_predicate  trackprog(+,0) .
%:- meta_predicate  writeanswer(0).
%:- meta_predicate  writeanswer2(+,0,+). %% RS-141026  writeanswer2 is in interapp...

:- volatile
           current_frame/1.    %%, last_answer/2. %% RS-131218
:- dynamic
           current_frame/1.    %%, last_answer/2. %% RS-131218 Trouble with multiple Modules?

%% User input terminals

%%% RS-141026, UNIT: /
%:- use_module( '../main', [ value/2 ] ).
%:- ensure_loaded( '../declare' ).       %% RS-111212  traceprog/2, trackprog/2
:- use_module( '../declare', [ value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .

%% UNIT: /utility/,     RS-140914
%:- use_module( '../utility/utility', [ ] ). %roundmember/2 ] ). %% RS-140208. := /2, listall/1, Includes user:declare, and GRUF (fernando) %% :-op( 714,xfx, := ).
:- use_module( '../utility/writeout', [ colon/0, trackprog/2, waves/0, writeprog/1, writeanswer/1 ] ).%% RS-141105 traceanswer/1,
:- use_module( '../utility/datecalc', [ daysucc/2, isday/1, today/1 ] ).
:- use_module( '../utility/writeout', [ bcp/1, bcpbc/1, bwrbc/1, busanswer_sat/3, doubt/2, listall/1, listrequirements/1,  output/1, period/0, space/0, teleanswer_sat/2,
        writetelebusteranswer_rep/1, writetelebusteranswer_saf/2, writetelebusteranswer_sqt/3, writetelebusteranswer4/4 ] ).%% RS-140912

%%% RS-140914, UNIT: /app/
:- use_module( '../app/busanshp', [ paraphrase/1, paraphrase2/2, paraphrase3/3, prent0/1, printmessage/1 ] ). % period/0, space/0, -> writeout 
:- use_module( '../app/interapp', [ execute_program/1, isuccess/1, makeanswer/4 ] ). %% LOOP!! writeanswer/1, traceanswer/1, waves/0, writeprog/1 was used in interapp (now writeout?)
:- use_module( '../app/negans', [ makenegative/3, trytofool/2 ] ).

%% RS-140914    UNIT: /dialog/

:- use_module( d_dialogue, [ last_answer/2, subst_tql/4 ] ).
%:- ensure_loaded( user:d_dialogue ). % , [ last_answer/2, subst_tql/4 ] ).

:- use_module( frames2, [ find_askfor/3, find_parentslot/3, frame_getsubslots/2, frame_getvalue_rec/4, frame_gettype_rec/3, frame_iscomplete/2,
                          frame_setexperience/4, frame_setvalue_rec/4 ] ).
%:-use_module( 'newcontext2', [ addref/3, getcontext/2, getcurrent/1 ] ).        %% FOR busanshp.pl AND checkitem2.pl
:- use_module( newcontext2, [ addref/3, commitref/3, getcontext/2, getcurrent/1, reset_context/0, setcontext/2 ] ). %% RS-140101
%:- use_module( parseres, [ busanswer_sat/3, listall/1, listrequirements/1, teleanswer_sat/2,
%        writetelebusteranswer_rep/1, writetelebusteranswer_saf/2, writetelebusteranswer_sqt/3, writetelebusteranswer4/4 ] ). %% Printing the result from database query 
:- use_module( update2, [ dorelax/3, getuserrefer/2, issubclass/2, istype/2, saturate/3, updateframe/3, updateframe_checkanswer/4, updateitems/2 ] ).

:- use_module( '../app/pragma', [ flatroundre/2, pragma/3, roundmember/2 ] ). %% roundmember must be declared meta_predicate early on!


%:- meta_predicate  trackprog(+,0) .
%trackprog( N, P ) :-
%    value( traceprog, M ), number(M), M >= N,
%    !,
%    ( nl, call(P) )    %% TA-110130
%        ;
%    true. %% Finally, succeed anyway



%% NB  checkteleitem   and checkitem  are mingled %% TA-051106%%%%%%%%%%%%%
%%     checkitem(tele,     checkitem(trans,




checkitem(Type, OldFocus, NewFocus) :-
	( value(teleflag,true) ),
	!,	
	checkitem(tele,Type,OldFocus,NewFocus). %% name of module

checkitem(Type, OldFocus, NewFocus) :-
  \+ 	( value(teleflag,true) ),
  checkitem(trans, Type,OldFocus, NewFocus).   %% name of module


checkitem(_,nil, X,X). 



%%% uati

checkitem(tele,uati, focus(OldFrame, OldRefer, slot(Slot)), focus(NewFrame, NewRefer, [])) :-
    getcurrent(Cid),
    getcontext(Cid, context((item, Item isa _), _, _, _)),
    frame_getsubslots(Slot, SubSlot),
    frame_gettype_rec(OldFrame, SubSlot, Type),
    istype(Item, Type),
    !,
    (addref(Cid, Item, Type) ; true),
    commitref(Cid, OldRefer, NewRefer),
    frame_setvalue_rec(OldFrame, SubSlot, Item, TmpFrame),

    updateitems(TmpFrame,NewFrame),
    trackprog(3, (output('uati, new frame: '),writeprog(NewFrame))).


checkitem(trans,uati, focus(OldFrame, OldRefer, slot(Slot)), focus(NewFrame, NewRefer, [])) :-
    getcurrent(Cid),
    getcontext(Cid, context((item, Item isa _), _, _, _)),
    frame_getsubslots(Slot, SubSlot),
    frame_gettype_rec(OldFrame, SubSlot, Type),
    istype(Item, Type),
    !,
    (addref(Cid, Item, Type) ; true),
    commitref(Cid, OldRefer, NewRefer),
    frame_setvalue_rec(OldFrame, SubSlot, Item, NewFrame),

    paraphrase(frame_setvalue(SubSlot,Item)). %% TA-030224 

%% ¤¤¤¤¤¤¤¤

%% uatc 
%% Both tele and bus %% TA-060321

checkitem(_Tele,uatc, focus(OldFrame, OldRefer, slot(Slot)), focus(NewFrame, NewRefer, [])) :-
	getcurrent(Cid),
	getcontext(Cid, context((confirm,false), _, _, _)),
	frame_setvalue_rec(OldFrame, Slot, dontknow, NewFrame),
	commitref(Cid, OldRefer, NewRefer).


checkitem(_Tele,uatc, focus(OldFrame, OldRefer, slot(Slot)), focus(NewFrame, NewRefer, [])) :-
	getcurrent(Cid),
	getcontext(Cid, context((confirm,true), _, _, _)),
	frame_setvalue_rec(OldFrame, Slot, doknow, NewFrame),
	commitref(Cid, OldRefer, NewRefer).

checkitem(_Tele,uatc, focus(OldFrame, OldRefer, slot(Slot)), focus(NewFrame, NewRefer, [])) :-
	getcurrent(Cid),
	getcontext(Cid, context((new, not (A isa _B,know1/A,event/real/A)), _, _, _)), %% TA-080929
	frame_setvalue_rec(OldFrame, Slot, dontknow, NewFrame),
	commitref(Cid, OldRefer, NewRefer).

%% ¤¤¤¤¤¤¤¤

%% uadi


checkitem(teletrans,uadi, focus(OldFrame, OldRefer, [Tql, _Prog]), focus(NewFrame, NewRefer, [NewTql, NewProg])) :-
    getcurrent(Cid),
    getcontext(Cid, context((item, Item isa ItemType), _, _, _)),
    roundmember( whichref(RefType, _) isa _, Tql),
    issubclass( ItemType, RefType),
    (addref( Cid, Item, ItemType) ; true),
    commitref( Cid, OldRefer, NewRefer),
    subst_tql( whichref(RefType, _), Item, Tql, NewTql),
    assert(current_frame(OldFrame)),
    pragma(teletrans, NewTql, NewProg),
    retractall(current_frame(_)),
    updateframe(NewProg, OldFrame, NewFrame).



%% ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤


%% uin

checkitem(teletrans,uin, focus(OldFrame, OldRefer, _Query), focus(NewFrame, NewRefer, [(new, Rest), Program])) :-
    trapvarframe(OldFrame),  %% TA-030108
    getcurrent(Cid),
    getcontext(Cid, context((New, Rest), _, TempRefer, NodeStack)),


    ( New=new;       %% Initially,  modifer accepted as uin
 
     New=modifier(_)), %% Til Lade./ [Jeg vil reise] fra nth til nardo
                                                             %%%%%%%%%  was ignored!
%%%       OldRefer==[])), %% initial modifier (?)%% TA-051214
%% TA-060707


    assert(current_frame(OldFrame)),
    pragma(teletrans, (New, Rest), Program),

    retractall(current_frame(_)),
    setcontext(Cid, context((New, Rest), Program, TempRefer, NodeStack)), %%
    updateframe(Program, OldFrame, NewFrame),

    getuserrefer(Cid, Rest),
    commitref(Cid, OldRefer, NewRefer)

%    ,true.
    ,!. %% Panic %% TA-060705


   

%% ¤¤¤¤¤¤¤¤¤¤


%% uim


checkitem(teletrans,uim, focus(OldFrame, OldRefer, [Tql, _OldProg]), focus(NewFrame, NewRefer, [Tql, NewProg])) :-

%%    \+ roundmember(nocontext,OldProg), %% Do not Modify nocontext 

%% hva er klokka ? //  fra  fra Lerkendal til Dragvoll nå.


    getcurrent(Cid),
    getcontext(Cid, context((modifier(X), Rest), _, _TempRefer, _NodeStack)),
    assert(current_frame(OldFrame)),
    pragma(teletrans, (modifier(X), Rest), ModProgram),
    retractall(current_frame(_)),
    updateframe(ModProgram, OldFrame, NewFrame),

    getuserrefer(Cid, Rest),
    commitref(Cid, OldRefer, NewRefer),

    NewProg = ModProgram. %%%%%  OldProg. %% Bloofy experiment. %% TA-051214

%%%    saturatemod(NewFrame, OldProg, NewProg). %% <--- copies old program!

%% ¤¤¤¤¤¤¤¤¤¤¤¤


%% uatm

checkitem(tele,uatm, focus(OldFrame, OldRefer, slot(Slot)), focus(NewFrame, NewRefer, slot(Slot))) :-
    getcurrent(Cid),
    getcontext(Cid, context((modifier(X), Rest), _, _TempRefer, _NodeStack)),
    assert(current_frame(OldFrame)),
    pragma(tele, (modifier(X), Rest), ModProgram),
    retractall(current_frame(_)),
    (
        updateframe_checkanswer(ModProgram, Slot, OldFrame, NewFrame) %% updateframe_checkteleanswer %% TA-051214
    ;
        (updateframe(ModProgram, OldFrame, TempFrame),
        frame_getsubslots(Slot, SubSlot),
        checkanswer((modifier(X), Rest), ModProgram, SubSlot, TempFrame, NewFrame))
    ),

    getuserrefer(Cid, Rest),
    commitref(Cid, OldRefer, NewRefer).


%% Modified, independent of focus slot
checkitem(trans,uatm, focus(OldFrame, OldRefer, slot(Slot)), focus(NewFrame, NewRefer, slot(Slot))) :-
    getcurrent(Cid),
    getcontext(Cid, context((modifier(X), Rest), _, _TempRefer, _NodeStack)),
    assert(current_frame(OldFrame)),
    pragma(trans, (modifier(X), Rest), ModProgram),
    retractall(current_frame(_)),
    (
        updateframe_checkanswer(ModProgram, Slot, OldFrame, NewFrame) %% updateframe_checkteleanswer %% TA-051214
    ;
        (updateframe(ModProgram, OldFrame, TempFrame),

         TempFrame = NewFrame %%%% <---- %% TA-060119

%%        frame_getsubslots(Slot, SubSlot),
%%        checkanswer((modifier(X), Rest), ModProgram, SubSlot, TempFrame, NewFrame)

    )),

    getuserrefer(Cid, Rest),
    commitref(Cid, OldRefer, NewRefer).


%%%%%%%%%


%% uiq


checkitem(teletrans,uiq, focus(OldFrame, OldRefer, _), focus(NewFrame, NewRefer, [(Type, Rest), Program])) :-
    getcurrent(Cid),
    getcontext(Cid, context((Type, Rest), _, _TempRefer, _NodeStack)),
    \+ member(Type, [new, modifier(_), item,confirm]), %%  do = test // (kan du) gjenta
    assert(current_frame(OldFrame)),        %% TA-051116
    pragma(teletrans, (Type, Rest), Program),
    retractall(current_frame(_)),
    updateframe(Program, OldFrame, NewFrame),

    getuserrefer(Cid, Rest),
    commitref(Cid, OldRefer, NewRefer). 

%%% ¤¤¤¤¤¤¤¤¤¤


%% uatg


checkitem(teletrans,uatg, focus(OldFrame, OldRefer, slot(Slot)), focus(NewFrame, NewRefer, [])) :-
    getcurrent(Cid),
    getcontext(Cid, context(Tql, _, _, _)),
    pragma(teletrans, Tql, Program),
    frame_getsubslots(Slot, SubSlot),
    checkanswer(Tql, Program, SubSlot, OldFrame, NewFrame),
    !,
    getuserrefer(Cid, Tql),
    commitref(Cid, OldRefer, NewRefer).


%% sant


checkitem( _, sant, focus(Frame, OldRefer, [Tql, Prog]), focus(Frame, NewRefer, [Tql, Prog]) ) :-
    getcurrent(Cid),
    roundmember(XFrog, Tql),      %% TA-980525
    trytofool(XFrog, Delphi),
    !,
    Panswer = ( bcp(Delphi), period), %% TA-980609   DELPHI answer
    waves,
    writeanswer(Panswer),
    commitref(Cid, OldRefer, NewRefer),

    writetelebusteranswer4(sant,Tql,nil,Frame). %% TA-060905 




%% ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

%% sat


checkitem(tele,sat, focus(Frame, OldRefer, [Tql, Prog]), focus(Frame, OldRefer, [Tql, Prog])) :-
    roundmember(quit(you_are_welcome),Tql),
    !,
    waves,  %% TA-050809 

    doubt('You are welcome.','Vær så god.'),nl, %% TA-061208 ad hoc

    invitemore. 


checkitem(tele,sat, focus(Frame, OldRefer, [Tql, Prog]), focus(Frame, OldRefer, [Tql, Prog])) :-
    roundmember(repeat/tuc/_,Tql),
    !,
    getcurrent(Cid),   
    get_last_answer(Cid,OldFrame),

    waves,  %% TA-050809 

    writetelebusteranswer_rep(OldFrame), %% recreates answer 

    invitemore. 


checkitem(trans,sat, focus(Frame, OldRefer, [Tql, Prog]), focus(Frame, OldRefer, [Tql, Prog])) :-
    roundmember(repeat/tuc/_,Tql),
    !,
    getcurrent(Cid),   
    get_last_answer(Cid,AnswerOut),

    waves,  %% TA-050809 

    writeanswer(AnswerOut),

    invitemore. 



checkitem(tele,sat, focus(Frame, OldRefer, [Tql, Prog]), focus(NewFrame, NewRefer, [Tql, Prog])) :-
	\+ frame_getvalue_rec(Frame, return, [unknown|_],_),
(
    frame_iscomplete(Frame, [])
    ;
    frame_getvalue_rec(Frame, return, [count|_],_)),
    !,
    getcurrent(Cid),
    waves,

    paraphrase(Frame),

    teleanswer_sat(Tql,Frame), %% TA-060428

    store_last_answer(Cid,Frame), %% => to regenerate answer from Old Frame
    !,
    (NewFrame=Frame),   

    commitref(Cid, OldRefer, NewRefer),
    invitemore.  %% TA-051218

checkitem(trans,sat, focus(Frame, OldRefer, [Tql, Prog]), focus(Frame, NewRefer, [Tql, NewProg])) :-
    saturate(Frame, Prog, NewProg),
    (roundmember(nocontext, NewProg) ; 
    frame_iscomplete(Frame, Miss),!,Miss==[] ), 
    !, %%% <-------- 
    copy_term(NewProg, NewProg2),
    getcurrent(Cid),
    isuccess(NewProg2),

    writeprog(NewProg2), 

    execute_program(NewProg2), %% TA-060705
 

    trackprog(2, output('BEGIN  answer')),  

    makeanswer(true, Tql, NewProg2 , AnswerOut),

    trackprog(2, output('END  answer')),  

    store_last_answer(Cid,AnswerOut),
    
    waves,

%%     writeanswer(AnswerOut), %% TA-060428

    busanswer_sat(Tql,AnswerOut,Frame),  %% TA-060428

    commitref(Cid, OldRefer, NewRefer),
    invitemore. 


%% ¤¤¤¤¤¤¤¤

%% saf


checkitem(TB,saf, focus(Frame, OldRefer, A), focus(Frame, NewRefer, A)) :-
	 A=[Tql,Prog],  %% TA-061214
	 frame_getvalue_rec(Frame, itemsfound::itemcount, 0, _),
	 !,   %% no records case %% TA-060706
    getcurrent(Cid),
	 waves,
	 paraphrase3(TB,Prog,Frame), %% TA-061214  Frame does not contain ACTUAL QUERY!
    writetelebusteranswer_saf(Tql,Frame), %% TA-060420 &<---- ???
    writeanswer((bcpbc(norecordsfound),period)),
    listrequirements(Frame),
    !,
    commitref(Cid, OldRefer, NewRefer).


checkitem(_,saf, focus(Frame, OldRefer, A), focus(Frame, NewRefer, A)) :-
    frame_getvalue_rec(Frame, return, [unknown|_],_),
    !,  %%  return unknown case %% TA-060706
	 getcurrent(Cid),
	 waves,
    paraphrase(Frame), %% søker etter ukjent felt %% TA-061009
    writeanswer((bcpbc(icannotfind),nl)),     %%
    !,
    commitref(Cid, OldRefer, NewRefer).

checkitem(_,saf, focus(Frame, OldRefer, [Tql, Prog]), focus(Frame, NewRefer, [Tql, NewProg])) :-
    saturate(Frame, Prog, NewProg),
    getcurrent(Cid),
    makenegative(Tql, NewProg, busanshp:AnswerOut),
%    makenegative(Tql, NewProg, AnswerOut),
    waves,
    paraphrase2(Prog,Frame), %% <--- suspect for tele ??? %% TA-060705
    writeanswer( busanshp:AnswerOut ),
    !,
    commitref(Cid, OldRefer, NewRefer).


%% ¤¤¤¤¤¤¤¤¤¤



%% sqt



checkitem(teletrans,sqt, focus(Frame, OldRefer, [Tql, Prog]), focus(Frame, NewRefer, slot(NewSlot))) :-

    saturate(Frame, Prog, NewProg), %%%%    Eggen, Fra NT til nardo // use Eggen program?
%                   %??% 

(
    roundmember(askfor(X, Slot, Y), NewProg),  
    \+ frame_getvalue_rec(Frame, Slot, _, _), !
;
    \+ roundmember(nocontext, NewProg),  %% TA-030223
    
    (frame_iscomplete(Frame, [Slot | RestSlots]), %% !! means frame is incomplete !

    \+ youhaveaskedformissingslot(NewProg,[Slot | RestSlots]))


),

    find_askfor2(teletrans,Frame, Slot, NewSlot),
    getcurrent(Cid),
    makenegative(Tql, askfor(X, NewSlot, Y), busanshp:AnswerOut),
    waves, %% TA-050809
    writeanswer(busanshp:AnswerOut),

    writetelebusteranswer_sqt(Tql,busanshp:AnswerOut,Frame), %% NEW  parseres.pl  %% TA-060825
    !, 
    commitref(Cid, OldRefer, NewRefer).



%% sal


%% Sys-out-items specified for telebuster  TLF-030505

checkitem(tele,sal, focus(Frame, OldRefer, A), focus(Frame, NewRefer, A)) :-
	frame_getvalue_rec(Frame, itemsfound::itemcount, Count, _),
	Count > 1,
	\+ frame_getvalue_rec(Frame, return, [unknown|_],_),
	getcurrent(Cid),
	waves,
	paraphrase(Frame),
    writeanswer( ( bcpbc( tellnumber(Count) ),  colon,nl,nl) ),!, %% was period) %% TA-050921
    (Count =< 3 ->   %% TA-060614

    listall(Frame); 

    bcpbc(tomanytolist),period),

    commitref(Cid, OldRefer, NewRefer).

%% ¤¤¤¤¤¤¤¤¤¤¤¤

%% sqd


checkitem(_,sqd, focus(Frame, Refer, [Tql, Prog]), focus(Frame, Refer, [Tql, Prog])) :-
    roundmember(askref(_Type, _List), Prog),
    makenegative(Tql, Prog, busanshp:AnswerOut),
    waves,
    writeanswer(busanshp:AnswerOut).

%% ¤¤¤¤¤¤¤¤¤¤¤


%% relax


checkitem(trans,relax, focus(Frame, Refer, [Tql, Prog]), focus(Frame, Refer, [Tql, NewProg2])) :-

    Prog = Prog2, %%    saturate(Frame, Prog, Prog2), %% dont reinstall constraints!
                  %% TA-060705
    dorelax(Prog2, NewProg, Results),  %% update2.pl
    flatroundre((nocontext, (Results, NewProg)), NewProg2).
 
%% ¤¤¤¤¤¤¤¤¤¤

%% uatf

checkitem(_,uatf, focus(OldFrame, Refer, slot(Slot)), focus(NewFrame, Refer, slot(Slot))) :-

%%%    OldFrame = NewFrame. %% shortcut %% TA-060119

    find_parentslot(OldFrame, Slot, PSlot),
    frame_setexperience(OldFrame, PSlot, 0, NewFrame).

%% ¤¤¤¤¤¤¤¤¤¤¤¤¤¤


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% no


checkitem(_,no, Focus, Focus) :-
    getcurrent(Cid),
    getcontext(Cid, context((confirm,false), _, _, _)).

%% ¤¤¤¤¤¤¤


checkitem(_,yes, Focus, Focus) :-
    getcurrent(Cid),
    getcontext(Cid, context((confirm,true), _, _, _)).


%% ¤¤¤¤¤¤¤


%% reset_context

checkitem(_,reset_context, X,X):- %% TA-030108
    printmessage(quit),  
    reset_context.


%%  ¤¤¤¤¤¤¤¤¤¤


%% uadm


checkitem(_,uadm, focus(OldFrame, OldRefer, [Tql, _Prog]), focus(NewFrame, NewRefer, [NewTql, NewProg])) :-
    getcurrent(Cid),
    getcontext(Cid, context(Osen, _, _, _)),

    Osen = (modifier(F77),Item isa ItemType,srel/nil/place/Item/F77,event/real/F77),
    !,
    roundmember(whichref(RefType, _) isa _, Tql),
    issubclass(ItemType, RefType), 
    (addref(Cid, Item, ItemType) ; true),
    commitref(Cid, OldRefer, NewRefer),
    subst_tql(whichref(RefType, _), Item, Tql, NewTql),
    assert(current_frame(OldFrame)),
    pragma(trans, NewTql, NewProg),
    retractall(current_frame(_)),
    updateframe(NewProg, OldFrame, NewFrame).

%% ¤¤¤¤¤¤¤¤¤¤¤¤¤


%% say

checkitem(_,say(Output), Focus, Focus) :-
    waves, %% TA-050809
    writeanswer(bcpbc(Output)), nl.

%% ¤¤¤¤¤¤¤¤¤¤¤¤¤


%% sayq
	
checkitem(_,sayq(Output), Focus, Focus) :- 
    waves, %% TA-050809
    writeanswer(bcpbc(Output)), nl.

%% ¤¤¤¤¤¤¤¤¤¤¤¤¤


remove_messages(Prog,Prog). %% e.g. howtuchelp %% TA-051214

remtp(tele,(teleprocess(_,_,_,_),B),B):-!.


sysout_item(sant).
sysout_item(sat).
sysout_item(saf).
sysout_item(sqt).
sysout_item(sal).
sysout_item(sqd).
sysout_item(say(_)).    
sysout_item(sayq(_)).

sysout_item(reset_context).



%%%%%%% END SECTION checkitem %%%%%%%%%%





%% ¤¤¤¤¤¤¤¤¤¤¤¤
%:- meta_predicate  writeanswer(0).
%writeanswer( Panswer ) :- 
%    traceanswer( Panswer ),
%    Panswer,
%    !. 
%


writeconstlist1st([]).

writeconstlist1st( [ Field=Val | Rest ] ) :-
	\+ Val = dontknow,
	\+ Val = doknow,
	bcp( field(Field) ), space, bwrbc(Val), %% write(Val), %% TA-061208
	writeconstlist(Rest).

writeconstlist1st([_=Val|Rest]) :-
	(	Val = dontknow
	;
		Val = doknow
	),
	writeconstlist1st(Rest).

writeconstlist([]).
writeconstlist([Field=Val|Rest]) :-
	\+ Val = dontknow,
	\+ Val = doknow,
	bcp(and),bcp(field(Field)),space,write(Val),
	writeconstlist(Rest).

writeconstlist([_=Val|Rest]) :-
	(
		Val = dontknow
	;
		Val = doknow
	),
	writeconstlist(Rest).

%%

invitemore :- 
    \+ value(directflag,true),      %% TA-060127
    \+ value(telebusterflag,true),  %% TA-060216
    nl,                             %% TA-051221
    prent0(invitemore),nl. 
invitemore.


%% These are  not declared as dynamic

store_last_answer(Cid,AnswerOut) :-
   retractall( last_answer(Cid,_) ),
   assert(last_answer(Cid,AnswerOut)).

get_last_answer(Cid,AnswerOut):-
    clause(last_answer(Cid,AnswerOut),true).
%% no Existence error in last_answer/0


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% checkanswer(TQL, Prog, Slot).

checkanswer(TQL, _, day, OldFrame, NewFrame) :-
    roundmember(_ isa Day, TQL),
    isday(Day),
    frame_setvalue_rec(OldFrame, day, Day, NewFrame).
 
checkanswer(TQL, _, day, OldFrame, NewFrame) :-
    roundmember(srel/tomorrow/_/_/_, TQL),
    today(Today), 
    daysucc(Today, Tomorrow),
    frame_setvalue_rec(OldFrame, day, Tomorrow, NewFrame).

checkanswer(TQL, _, day, OldFrame, NewFrame) :-
    roundmember(srel/today/_/_/_, TQL),
    today(Today), 
    frame_setvalue_rec(OldFrame, day, Today, NewFrame).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


trapvarframe(V):-var(V), 
    trackprog(2,write('**** Empty Focus  ***')),
    !;true.


youhaveaskedformissingslot(NewProg,MissingSlots):- %%%<--- %% TA-070201

    NewProg=teleprocess(DepSlot,_Katnavn,_John_Krogstie,_1114),
    DepSlot=[Department],
    MissingSlots = [attributes::Department],
    !.

%%%%%% testifyouhaveaskedformissingslot(NewProg,MissingSlots).



find_askfor2(tele,Frame, Slot, NewSlot):-
        \+ frame_getvalue_rec(Frame, return, [unknown|_],_),
        (Slot = knows(SlotTmp) -> NewSlot = SlotTmp; NewSlot=Slot).

find_askfor2(trans,Frame, Slot, NewSlot):-
    find_askfor(Frame, Slot, NewSlot). %% frames.pl

%% ¤¤¤¤¤¤¤¤¤¤

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MOVED BACK FROM  interapp.pl. Localized in checkitem2, interapp and update2, to avoid meta_predicate ordering conflicts. %% RS-141026
%:- meta_predicate  execute_program( 0 ).  %% Stay inside interapp? %% RS-140619
%execute_program( Prog ) :-
%
%    trackprog(2, output('BEGIN  program')), 
%(   call( Prog ) ->
%           trackprog(2, output('END  program'));
%           trackprog(2, output('FAIL  program')),
%           fail ).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

