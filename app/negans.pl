/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE negans.pl
%% SYSTEM BUSSTUC/BUSTER
%% CREATED  TA-990212
%% REVISED  TA-110706

%% Handle empty answer from buslog.
%% RS-150414. In other words, overrides the use of pragma to create answers from busans-rules...
%% Directly returns an *** Application answer program ***

%UNIT: /app/
:- module( negans, [ cannot/1, cannotanswer/1, makenegative/3, trytofool/2, trytofool/3 ] ).

%:-meta_predicate  makenegative( ?, +, 0 ).     %% RS-141025  To match notthenanswer 
:-meta_predicate  makenegative( ?, +, ? ).      %% RS-141105  Invalid Goal... busanshp:AnswerOut

:-meta_predicate  notthenanswer( ?, ?, ?, ?, 0 ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% RS-141026    UNIT: /
%:- ensure_loaded( user:'../declare' ).       %% RS-111212 :-op( 710,xfx, isa ). traceprog/2
:- use_module( '../declare', [ value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .
:- use_module( '../sicstus4compatibility', [ traceprog/2 ] ).  %% Compatible with sicstus4, get0/1 etc.
:- use_module( '../utility/utility', [ bound/1, sequence_member/2, testmember/2 ] ). %% RS-141012

% :- use_module( '../utility/utility', [  ] ).  %% RS-140209

:- use_module( '../app/busanshp', [ ] ). %% RS-111212 space0/0 
:- use_module( '../app/buslog', [ bus/1, neverpasses/2, place_station/2, station/1 ] ). %% RS-111212 
%:- use_module( '../app/telelog', [ bound/1 ] ).    %% RS-131225 %% To utility.pl

:- use_module( '../db/busdat', [ disallowed_night/1, vehicletype/2 ]). %, xforeign/1, nightbus/1 ]).

%UNIT: /tuc/
:- use_module( '../tuc/facts', [ isa/2 ] ).       %% RS-131225    Necessary?

:- use_module( '../utility/datecalc', [ days_between/3, daysucc/2, today/1  ]).

%%makenegative( FlatCode, ProgIn,  busanshp:AnswerOut ) :-
makenegative( (head,_TF_), _,  busanshp:nl ) :-
    traceprog(4,ne00),     %% from main.pl
    !.

makenegative( (confirm,_TF_), _,  busanshp:(bcpbc(ok), period) ):-
    traceprog(4,ne01),!.

makenegative( nil, _,  busanshp:(bcpbc(ok),nl) ):- 
    traceprog(4,ne02),!. %% queryflag = false, statements are not to be treated

%% Security Check, superfluous by test in interapp 

makenegative( (item,_), _ ,  busanshp:(space0) ) :-
    traceprog(4,ne03),!. 

makenegative( _, Q,  busanshp:(bcpbc(no),nl) ) :-
    sequence_member( false, Q ),
    traceprog(4,ne04),!.

makenegative( _,Q,  busanshp:space0 ):- %% drop idontknow message
    sequence_member( message(cannotanswer), Q ), %% = roundmember
     traceprog(4,ne05),!.

makenegative((new,not _),_,  busanshp:(bcpbc(ok),nl) ) :-
     traceprog(4,ne06),!.



%% From telebuster/app/negans.pl

makenegative(_,Q,  busanshp:(bcpbc(please_state),bcp(the(Slot)),exclamation) ) :-
	 value(teleflag,true),
	 value(dialog,1),
	 sequence_member(askfor(_, knows(Slot), _), Q),
	  traceprog(4,ne07),!.

makenegative(_,Q, busanshp:(bcpbc(doyouknow),bcp(the(Slot)),question) ) :-
	 value(teleflag,true),
	 value(dialog,1),
	 sequence_member(askfor(_, Slot, _), Q),
	 traceprog(4,ne07),!.

%% 

makenegative(_,Q, busanshp:(bcpbc(askfor(Slot)),nl) ) :-  
    value(dialog, 1),
    sequence_member(askfor(_, Slot, _), Q),
    traceprog(4,ne08),!.

makenegative(_,Q, busanshp:(bcpbc(which), bcp(Type), comma, bwr(or(List)), question)) :- 
    value(dialog, 1),
    sequence_member(askref(Type, List), Q),
    traceprog(4,ne09),!.


makenegative( (_,_), Q, Mess ):- %%  passesstation keepbetweenstat
    sequence_member(passesstations(Nine,_,_,_),Q),
    sequence_member(keepbetweenstat(Nine,Lade,Berg,_,_),Q),    
    bound(Nine),bus(Nine),
    vehicletype(Nine,Bus), 
    place_station(Lade,Lade1),
    place_station(Berg,Berg1),

   ( neverpasses(Nine,Lade1) -> 
	    (Mess = (busanshp:(bcpbc(Bus),bcp(Nine),bcp(neverpasses),bwr(Lade1),period)));

    neverpasses(Nine,Berg1) -> 
	      (Mess = (busanshp:(bcpbc(Bus),bcp(Nine),bcp(neverpasses),bwr(Berg1),period)))),
    traceprog(4,ne10),!.


makenegative((_,_),Q,Mess):- 
    sequence_member(passesstations(Nine,_,_,_),Q),
    bound(Nine),bus(Nine),
    vehicletype(Nine,Bus), 
    sequence_member(departure(Nine,Lade,_,_),Q),
    place_station(Lade,Lade1),

   ( neverpasses(Nine,Lade1) 
     -> 
	    (Mess = (busanshp:(bcpbc(Bus),bcp(Nine),bcp(neverpasses),bwr(Lade1),period)));

       (getactualday(Q,Day),
       (Mess = (busanshp:(bcpbc(notpossible),ondays(Day),period, standnight(Day))))) 

   ),traceprog(4,ne11),!.



makenegative( (which(_),_), Q, Ans )   :- 
    sequence_member( passesstations(_,_,_,_), Q ),
    traceprog(4,ne12),!,
    getactualday(Q,Day),
    (Ans = (busanshp:(bcpbc(notpossible),ondays(Day),period,standnight(Day)))). 



   %% You ask about at station at an illegal date.
   %% X is known at parsing time, but unknown at execution time

makenegative( (test,P), Q, Ans ) :- 
    \+ sequence_member(message(_),Q),  
    sequence_member(X isa station,P), 
    bound(X),
    \+ station(X),
    traceprog(4,ne13),!,
    Ans = (busanshp:( bcpbc(no),period)).



makenegative( (test,P), Q, Ans ) :-  %% Negative introspection
    sequence_member(dob/know1/_/_/_,P), 
    \+ sequence_member(message(_),Q), 
    traceprog(4,ne14),!,
    Ans = (busanshp:( bcpbc(no),nl)). 


makenegative( (test,P), Q, Ans ) :-  %% Negative introspection
    sequence_member(dob/know/_/_/_,P),
    \+ sequence_member(message(_),Q), 
    traceprog(4,ne14),!,
    Ans = (busanshp:( bcpbc(no),nl)). 

/* %% TA-101029 -> trytofool

%% CAN NOT ANSWER ,   This is after trying, not beforehand as trytofool
makenegative((_,P),_,Ans)  :- 
   roundmember(K,P),
   cannotanswer(K),
   traceprog(4,ne15),!,
   Ans=(bcpbc(cannotanswer),nl). 
*/



makenegative( (_W,_), Q, Mess ) :- %%  Never passes, negative message 

%   sequence_member(departure(Nine,Lade,_,_),Q), %% does not catch keepbus %%

    sequence_member(connections(_,_,Nine,Lade,_,_,_,_,_,_),Q), 
    bound(Nine),
    bus(Nine),
    vehicletype(Nine,_Bus),
    place_station(Lade,ABI),
    neverpasses(Nine,ABI),
    traceprog(4,ne16),!,
    Mess = (busanshp:( bcpbc(cannotfindanyroutes),period)). 
          %%,  bcpbc(Bus),bcp(Nine),bcp(neverpasses),bwr(Lade),period). %% given before



makenegative( (_When,_), Q,  busanshp:space0 ) :- %% any statement type, including "when"
    sequence_member( message(noroutesforthisdate), Q ),  
    traceprog(4,ne17), %% ad hoc, shouldn't have executed program at all
    !. 


makenegative( (_When,_), Q, busanshp:Mess ) :- %% any statement type, including "when"
    getactualtime( Q, Date, Day, Clock ),
    notthenanswer( Date, Day, Clock, Q, busanshp:Mess ),
    traceprog( 4, ne18 ), !.


/* %% TA-101029 -> trytofool

%% CAN NOT  (direct or indirect commands) %% After Not Then Answer
makenegative((_,P),Q,Ans)  :- 
   \+ sequence_member(message(_),Q), %% Not double answer 
   sequence_member(K,P),
   cannot(K),
   traceprog(4,ne19),!,
   Ans=(bcpbc(sorrycannot),nl). 
*/


makenegative((new,_),P,Ans)        :-
      sequence_member(departure(_,_,_,_),P),  
      traceprog(4,ne20),!,
      Ans = (busanshp:(%%% bcpbc(it),space,bcp(is), 
           bcp(notpossible),nl)). 

makenegative( (new,_), Prog, Ans )  :- 
      value(dialog,1),
      sequence_member(message(M),Prog),    %%
      traceprog(4,ne21),!, 
      Ans = (busanshp:(printmessage(M))) .


makenegative((new,_),Prog,Ans)  :- 
      sequence_member(message(_),Prog),    %%
      traceprog(4,ne22),!, %% only 1. messsage (?) 
      Ans = (busanshp:(space0)). 

/* SUSPENDED   kople sammen reiser med tidspunkt
makenegative((new,P),Q,Ans)  :-
   \+  sequence_member(message(_),Q),
    sequence_member(srel/together/_/_/_,P), %% vi gjør noe sammen
    Ans = (busanshp:((bcpbc(notpossible),nl),  
    traceprog(4,ne45together2),!)).
*/


makenegative((new,_),_,Ans)        :- 
    traceprog(4,ne23),!,      %%% Ans = (busanshp:(bcpbc(ok),period)). 
    Ans = (busanshp:( bcpbc(ok),nl)). %% NB negative ? Jeg er på dragvoll

% 1 ?
makenegative( (which(A),P), Q, busanshp:Ans )   :-   %% Hvilke busser må jeg ta
    sequence_member(srel/(with)/frequency/A/_,P),
    getactualtime(Q,Date,Day,Clock),                               
    notthenanswer(Date,Day,Clock,Q, busanshp:Ans ),
   !,traceprog(4,ne24).

% 2 ?
makenegative((which(_),P),Q,Ans) :- 
     sequence_member(srel/(with)/frequency/_/_,P), 
     getactualtime(Q,_Date,_Day,_Clock),
     Ans = (busanshp:(bcpbc(nodirectroutes),nl)),
    !,traceprog(4,ne25).

makenegative( (DoOrNew,P), Q, Ans ) :- 
    \+ member(DoOrNew,[doit,new]),   %% RS-150311. Forgot to rename all "do" to "doit" when sp4 introduced "do" as a new reserved word

    \+ sequence_member(dob/say/tuc/_/_,P), %% ad hoc-> cannot
    \+ sequence_member(message(_),Q), % if message, you know

    sequence_member( Frog,P ),
    partiallyignorant( Frog ),  %% if buslog program failed, e.g. I
    traceprog(4,ne26),!,
    Ans = (busanshp:( bcpbc(idonotknow),nl)). 

makenegative( (which(A),P), Q, busanshp:Ans )   :-  % awkard way of getting the actual day
    sequence_member(srel/in/place/A/_,P), 
 \+ sequence_member(stationsat(_,_,_),Q), %% Dirty  %% Time independent 
    getactualtime(Q,Date,Day,Clock),
    traceprog(4,ne27),!,
    notthenanswer(Date,Day,Clock,Q,busanshp:Ans).

makenegative((which(A),P),Q,busanshp:Ans)   :-      % awkard way of getting the actual day
  \+ sequence_member(message(idonotknow),Q), %% Avoid double

    sequence_member(srel/in/place/A/_,P),
    sequence_member(stationsat(Vestre,_,_),Q), %% Dirty  %% Time independent 
    getactualtime(Q,Date,Day,Clock), 
    traceprog(4,ne28),!,
    (station(Vestre) -> 
        Ans = ( bcpbc(idonotknow),nl ) ;
        notthenanswer(Date,Day,Clock,Q,busanshp:Ans)). 

makenegative((which(A),P),Q, busanshp:Ans)   :- 
    sequence_member(srel/in/time/A/_,P), 
    getactualtime(Q,Date,Day,Clock),                                 
    notthenanswer(Date,Day,Clock,Q, busanshp:Ans), 
    traceprog(4,ne29),!.

makenegative((which(A),P),Q, busanshp:Ans)   :- 
    sequence_member(A isa time,P),
    getactualtime(Q,Date,Day,Clock),                                
    notthenanswer(Date,Day,Clock,Q, busanshp:Ans),
    traceprog(4,ne30),!. 

makenegative((which(_),_),Q,busanshp:Ans)   :- 
    sequence_member(departure(_,_,_,_),Q),  % INCOMPLETE  % Know there is none test 
     traceprog(4,ne31),!,
    getactualtime(Q,Date,Day,Clock),                               
    notthenanswer(Date,Day,Clock,Q,busanshp:Ans).

makenegative((modifier(_),_),Q, busanshp:Ans)   :-
    sequence_member(departure(_,_,_,_),Q),  % INCOMPLETE  % Know there is none test 
     traceprog(4,ne32),!,
    getactualtime(Q,Date,Day,Clock),                               
    notthenanswer(Date,Day,Clock,Q, busanshp:Ans).


makenegative( _, Prog, busanshp:Ans ) :-
    value(smsflag,true),
    sequence_member(message(answer(db_reply(_,_,_))),Prog),
     traceprog(4,ne33),!,
    Ans = space0. %%% ??? 



%makenegative( (which(_Time),_), Prog, busanshp:Ans )  :- %% RS-150406 Handle by setting christmas to christmaseve, easter to easter_eve, etc.
%      sequence_member( whenis(Holiday), Prog ),    %%
%      traceprog(4,ne35),!, 
%      Ans = ( bcpbc(Holiday),out(is),bcpbc(Date) ).


makenegative( (which(_),_Q), Prog, busanshp:Ans )   :- 
        \+ sequence_member(message(_),Prog),     %%  avoid "Jeg vet ikke",  + message
         traceprog(4,ne36),!,
        Ans = ( bcpbc(idonotknow), nl ). %% Default


makenegative( (which(_),_), Prog, busanshp:Ans )   :- 
     sequence_member(message(_),Prog), 
     traceprog(4,ne37),!,
     Ans = space0.


makenegative( (explain,_), Q, busanshp:Ans )    :-
     getactualtime(Q,Date,Day,Clock), 
      traceprog(4,ne38),!,   %   filter out TODAY when stupid
     notthenanswer(Date,Day,Clock,Q, busanshp:Ans).  

%% TEST if you should know or not 

makenegative((explain,_),Q,Ans)    :- 
        sequence_member(departure(_,_,_,_),Q),
         traceprog(4,ne39),!,
        Ans = (busanshp:((bcpbc(it),space,bcp(is),bcp(notpossible),period))). 

makenegative((explain,_),Q,Ans)    :- 
   \+ sequence_member(message(idonotknow),Q),   %% Avoid double
   \+ sequence_member(message(cannotanswer),Q), %% Avoid double
   \+ sequence_member(message(mustknow(_)),Q), 
   traceprog(4,ne40),!,      
   Ans = (busanshp:( bcpbc(cannotanswer),nl)). %% ,period)). %% in addition to messages


makenegative((howmany(_),_),Q,Ans) :- 
  \+ sequence_member(message(webstatistics),Q), %% RS-150405
  \+ sequence_member(message(idonotknow),Q), %% Avoid double
   traceprog(4,ne41),!,  
     Ans = (busanshp:(bcpbc(idonotknow),nl)). %% honest  ( not none)) 

makenegative((test,P),Q,Ans)  :- 

 \+ sequence_member(message(_),Q), %% any message
 \+ sequence_member(dob/say/tuc/_/_,P), %% ad hoc-> cannot

    sequence_member(Frog,P),
    partiallyignorant(Frog),  %% if buslog program failed
     traceprog(4,ne42),!,                                      %% To know what you don't
    Ans = (busanshp:((bcpbc(idonotknow),nl))).   %% know is knowledge


makenegative((test,P),_,Ans)  :- 
    sequence_member(equal/A/B,P),
    A \== B, A \== it, B \== it, 
     traceprog(4,ne43),!,
    Ans = (busanshp:((bcpbc(no),period))).       %% To know what you don't

makenegative((test,P),_,Ans)  :-  
    sequence_member(be1/A/B/_,P),
    A \== B, A \== it, B \== it, 
     traceprog(4,ne44),!,
    Ans = (busanshp:((bcpbc(no),period))).       %% To know what you don't



makenegative((test,_),Q,Ans)  :- 
   \+  sequence_member(message(_),Q),
    Ans = (busanshp:((bcpbc(cannotanswer),nl),  
    traceprog(4,ne45),!)).


%% Negative in lieu of no pay


makenegative((doit,reply(_M)),_,Ans)  :-
   traceprog(4,ne46),!,
   Ans = (busanshp:(space0)). %% output(_M). %% avoids double



makenegative((doit,replyq(M)),_,Ans)  :-
   traceprog(4,ne47),!,
   Ans = (busanshp:(output(M))). 



makenegative((doit,quit(M)),_,Ans)  :- %% Why don't we output the actual Message here?
   traceprog(4,ne48),!,
%   Ans = (busanshp:(space0)). 
   Ans = (busanshp:( bcpbc(M),nl )). 


makenegative((doit,_),Q,Ans)  :- 
  \+  sequence_member(message(_),Q),
      traceprog(4,ne49),!, 
   Ans = ( busanshp:( bcpbc(sorrycannot),nl ) ).


makenegative( (new,_), _, Ans )  :- 
    traceprog(4,ne50),!,
    Ans = (busanshp:((%%% bcpbc(it),space,bcp(is), 
         bcp(notpossible),period))).  

makenegative( P, _, Ans )  :- 
     sequence_member(replyq(X),P),
     Ans = (busanshp:((write(X),nl),
     traceprog(4,ne51),!)). 



makenegative( _P, Q, Ans )  :-  %% never for new, do
     \+  sequence_member(message(_),Q),
     Ans = (busanshp:((bcpbc(cannotanswer),nl), %% TA-100915  hotell til IKEA 
     traceprog(4,ne52),!)).


makenegative( _, _, _:true ) :- %% no extra nl
%makenegative( _, _, (busanshp:(true) ) ) :- %% no extra nl
     traceprog(4,ne53),!.  %% Catch all
                         %% NB is executed -> "Jeg kan ikke svare på det"


%%%%%%%%%%%%%%%%%%%%%%%%%



 %% not standard nightbus message if following weekend is abnormal
notthenanswer( Date, _Wed, _, _Q,    busanshp:( bcpbc(generalnightbuseaster), period) ) :-
    value(nightbusflag,true),
    following_weekend_abnormal(Date),
    !,                         %%
    traceprog(4,nt0). 

notthenanswer( _Date, easterhol, _, _Q,   busanshp:( bcpbc(cannotfindanyroutes), period, bcpbc(generalnightbuseaster), period ) ) :-
    value(nightbusflag,true),
    !,  
    traceprog(4,nt1).

notthenanswer( _Date, Day, Clock, Q,  busanshp:( bcpbc(nolonger), nibcp(Day), AttimeClock, DirAns, standnight(Day) ) ) :- 
    sequence_member(keepafter(_,_,_),Q),  %% in case time+1200
    attimeclock(Clock,AttimeClock),  
    !,
    traceprog(4,nt2), 
    dirans(Q,DirAns).
                               
notthenanswer(_Date,Day,_,Q, busanshp:( bcpbc(cannotfindanyroutes), nibcp(Day), DirAns, standnight(Day) ) ) :- 
    sequence_member(keepafter(_,_,_),Q),
    \+ testmember(Day,[saturday,sunday]), 
    !,
    traceprog(4,nt3), 
    dirans(Q,DirAns).


notthenanswer(_Date,Day,Clock,Q, busanshp:(bcpbc(noroutes),nibcp(Day),bcp(before),bwt(Clock),DirAns) ) :-
    \+ value(nightbusflag,true), 
    Clock \== 9999,  
    sequence_member(keepbefore1(Clock,_,_),Q),
    \+ sequence_member(keepbetween(_,_,_,_),Q), %% avoid not 1100 (morning ?) when 
    !,                                          %% keepbetween was the restriction
    traceprog(4,nt4before), 
    dirans(Q,DirAns).

notthenanswer(_Date,Day,Clock,Q, busanshp:(bcpbc(noroutes),nibcp(Day),bcp(attime),bwt(Clock),DirAns) ) :-
    \+ value(nightbusflag,true), 
    Clock \== 9999,  
    \+ sequence_member(keepbetween(_,_,_,_),Q), %% avoid not 1100 (morning ?) when 
    !,                                       %% keepbetween was the restriction
    traceprog(4,nt4a), 
    dirans(Q,DirAns).


notthenanswer(_Date,Day,Clock,Q, busanshp:(bcpbc(noroutes),nibcp(Day),bcp(attime),bwt(Clock),DirAns,standnight(Day)) ):-
    Clock \== 9999,              %% time is indicated, may be the cause 
    \+ sequence_member(keepbetween(_,_,_,_),Q), %% avoid not 1100 (morning ?) when 
    !,                                       %% keepbetween was the restriction
    traceprog(4,nt4b), 
    dirans(Q,DirAns).


%% if route day mapped to other day
notthenanswer(_Date,Day,_,Q, busanshp:(bcpbc(nolonger),  DirAns,standnight(Day)) ) :- 
    sequence_member(connections(_,_,_,_,_,_,_,Options,_,_),Q), %% not test

 (  %%%%%%   value(smsflag,true);  %% Will "always" try solutions after now 
     member(next,Options);
     member(next(_),Options);
     member(nextaftertime(_),Options)
 ),

     sequence_member(today(Thursday),Q), %% not test
     sequence_member(atday(Saturday),Q),
     Thursday \== Saturday,   
     !,
     traceprog(4,nt5), 
     dirans(Q,DirAns).

%% if route day mapped to same day    
notthenanswer(_Date,Day,_,Q, busanshp:(       bcpbc(nolonger),nibcp(Day),DirAns,standnight(Day)) ) :- 
     sequence_member(connections(_,_,_,_,_,_,_,Options,_,_),Q),  %% not test 
 (    value(smsflag,true);  %% dubious, excludes nolonger message if smsflag false
     member(next,Options);
     member(next(_),Options)
 ),

     sequence_member(today(Thursday),Q), %% not test
     sequence_member(atday(Saturday),Q),
     Thursday == Saturday,   
     !,
     traceprog(4,nt6), 
     dirans(Q,DirAns).


%% no more, if route day mapped to same day, not nec sms
notthenanswer(_Date,Day,_,Q, busanshp:(bcpbc(nolonger),nibcp(Day),DirAns,standnight(Day)) ) :- 
     sequence_member(connections(_,_,_,_,_,_,_,Options,_,_),Q),  %% not test 

     testmember(nextaftertime(_),Options), %%  etc

     sequence_member(today(Day),Q),
     sequence_member(atday(Day),Q),
     traceprog(4,nt7), 
     dirans(Q,DirAns).



%% not any
notthenanswer(_Date,Day,_,Q, busanshp:(bcpbc(cannotfindanyroutes),nibcp(Day),DirAns,standnight(Day)) ) :- 
    \+ testmember(Day,[saturday,sunday]), 
     sequence_member(connections(_,_,_,_,_,_,_,Options,_,_),Q),
 (    member(next,Options) ;  member(next(_),Options) ),
     !,
     traceprog(4,nt8), 
     dirans(Q,DirAns).


%% not any ?  
notthenanswer(_Date,Day,_,Q, busanshp:(bcpbc(nolonger),nibcp(Day),DirAns,standnight(Day)) ) :- 
     sequence_member(connections(_,_,_,_,_,_,_,_Options,_,_),Q),   %% tests ?
     sequence_member(today(Day),Q),
     sequence_member(atday(Day),Q),
     traceprog(4,nt9), 
     dirans(Q,DirAns).


notthenanswer(_Date,Day,_,Q, busanshp:(bcpbc(notpossible),nibcp(Day),DirAns,standnight(Day)) ) :- 
    value(nightbusflag,true),
    !,
    traceprog(4,nt10night),  
    dirans(Q,DirAns).


notthenanswer(_Date,Day,_,Q,     busanshp:( bcpbc(nolonger), DirAns,standnight(Day) ) ) :-  %% no time, no other date
    \+ sequence_member(message(otherperiod(_)),Q),
    !,
    traceprog(4,nt10),  
    dirans(Q,DirAns).

notthenanswer(Date,Day,_,Q,  busanshp:( bcpbc(notpossible), ondate(Date),   DirAns,standnight(Day))) :- %% TA-110301
    !,
    traceprog(4,nt11),  
    dirans(Q,DirAns).

/* %% TA-110301
notthenanswer(_Date,Day,_,Q, 
    (bcpbc(notpossible), ondays(Day),%% misleading if very late (then nt2 No more)
                DirAns,standnight(Day))):- 
    !,
    traceprog(4,nt11),  
    dirans(Q,DirAns).
*/


% %

following_weekend_abnormal(Date) :-
    disallowed_night(Easter),
    days_between(Date,Easter,N),
    N>=1, N =< 6,
    !.




attimeclock(9999,true):-!.  %%  call true
attimeclock(Clock, (bcp(attime),bwt(Clock))).


%% RS-120727 AD HOC! nothing to dragvoll, try ntnu_dragvoll
dirans(Q,Answer):-
    sequence_member(keepto(HT,_,_),Q) ->   Answer= ( bcp(indirectiontowards),bwr(HT),period);
    sequence_member(keepfrom(HT,_,_),Q) -> Answer= ( bcp(indirectionfrom),bwr(HT),period);
    sequence_member(departure(_,dragvoll,_,_),Q) -> Answer= ( comma, bcp(try),bwr(ntnu_dragvoll),bcp(instead),period);
    Answer= period.   


dirans(Q,Answer):-
    sequence_member(keepto(HT,_,_),Q) ->   Answer= ( bcp(indirectiontowards),bwr(HT),period);
    sequence_member(keepfrom(HT,_,_),Q) -> Answer= ( bcp(indirectionfrom),bwr(HT),period);
    Answer= period.   


%% P = Program
%% Get Date, Day, Clock of desired travel
getactualtime(P,Date,Day,Clock) :- 
    getactualdate(P,Date), 
    getactualday(P,Day),
    getactualclock(P,Clock).


getactualdate(P,Date) :-
    sequence_member( atdate2(_N,Date), P ), 
    !.
getactualdate(_P,nil).



getactualday(P,Day) :- 
      ( sequence_member(departure(_,_,_,_), P ) ;      %% only relevant if departure
        sequence_member(passesstations(_,_,_,_), P ) ), %%              /passesstation
       !,

%% This is stupid, but we have to recompute the actual day
%% because   total program backtracks

      today(Day0),

	 (

    ( sequence_member(atday(Sunday),P),atom(Sunday)) -> Day=Sunday;


    ( sequence_member(today(Uday),P) ->

    (

    ( sequence_member(daysucc(Day1,_),P),Uday==Day1) -> daysucc(Day0,Day);

    ( sequence_member(daysucc(_,Day2),P),Uday==Day2) -> daysucc(Day,Day0);

                                                     Day=Day0
    ))).



getactualclock(P,Clock) :- 
       sequence_member(departure(_,_,_,_),P), %% only relevant if departure

     ( sequence_member(keepafter(X,_,_),P); 
       sequence_member(keepbetween(_,X,_,_),P); 
       sequence_member(keepbefore1(X,_,_),P); 
       sequence_member(keepat(X,_,_),P);
       sequence_member(keeparound(X,_,_),P);
       sequence_member(keepbefore(X,_,_),P)),  

       nonvar(X),  
       !,
       X=Clock.

getactualclock(_,9999) :- !.  %% Dummy, but > 0500

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Topics of which the system lacks information

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Message conditioned  on empty answer.

% ANSWER ==> CANNOT  

%% cannot(doit/live/tuc/_).    %% TA-110221 ...
cannot(dob/play/tuc/_/_).    %% skal vi spille sjakk 
cannot(dob/repeat/tuc/_/_).  
cannot(doit/repeat/tuc/_). 
cannot(doit/see/tuc/_). 
cannot(dob/see/tuc/_/_). 
cannot(dob/send/tuc/_/_). 
cannot(dob/send/tt/_/_). 
cannot(dob/show/tuc/_/_).  
cannot(doit/speak/tuc/_).    %%  Intransitivt=prate 
cannot(dob/wake/tuc/_/_).  
cannot(doit/write/tuc/_).  

% ANSWER ==> CANNOT ANSWER If fail, then give this message 

cannotanswer(_ isa god). %% leave 1 for compat
cannotanswer(_ isa language). 
cannotanswer(_ isa school). 
cannotanswer(cost/_/_/_). 

% IF EMPTY ==> DONT KNOW 
 
partiallyignorant(_ isa address). 
partiallyignorant(cost/_/_/_).  
partiallyignorant(bring/_/_/_).  
partiallyignorant(work/_/_). 
partiallyignorant(_ isa airport). 
partiallyignorant(_ isa man). %% is tore a horse ( triggers on man)
partiallyignorant(_ isa driver). 
partiallyignorant(nrel/beyond/station/place/_/_).  
partiallyignorant(tagore isa _).  


% ORACLE ANSWER to Try-to-fool question  ( e.g. vaske bussruter )
%
% Tested before answering process unconditionally  <-- no, tested if prag failed?
%
% Trytofool rules overides any other message or answer
% and are meaningless disgarding the logic of the question 
% (they are not even evaluated)
% Answer may be slightly odd, but  shows that the question was understood

trytofool(Tag,FOL, Ans) :-   
     trytofool2(Tag,FOL,Ans),
     !.
trytofool(_Tag,FOL, Ans) :-  
     trytofool(FOL,Ans).

%---
 

trytofool2(doit,  doit/think/tuc/_,sorrycannot).     %% TA-100823 Tenk!  
trytofool2(doit,  dob/call/tuc/_/_,sorrycannot).   %% TA-101228 ring noen
trytofool2(doit,  dob/talk/tuc/norwegian/_,ok).  
trytofool2(doit,  dob/talk/tuc/english/_,ok).    %% speak english!

trytofool2(doit,  doit/end/tuc/_,bye). %% TA-110609

%%% trytofool2(doit,   dob/_/tuc/_/_,sorrycannot).   %%  finn en slik buss. %% TA-100831



trytofool2(new, _ isa birthday, congratulations). 
trytofool2(new,  dob/do1/'I'/_/_,ok).              %%  I do something
trytofool2(new,  adj/_/intelligent/tuc/_, thanks). %% You are smart 

trytofool2(new,  dob/be_named/'I'/_/_, ok).        %% Jeg heter tore 
trytofool2(new,  dob/be/'I'/_/_, ok).              %% I am a girl %% TA-101228

trytofool2(test,  _ isa turing_test, cannotanswermyself). %% TA-100914
trytofool2(test,  doit/be1/'I'/_,cannotanswer).     %%   er jeg ...
trytofool2(test,  dob/like/_/tuc/_,cannotanswer). %% liker jeg deg ?

trytofool2(test,  dob/get/tuc/_/_,cannotanswer).   %%  har du fått... #1 

trytofool2(explain,  _ ,cannotanswer). %% hvorfor er du et system

trytofool2(test,dob/know1/tuc/_/_, sorrynot).    
trytofool2(test,dob/recognize/tuc/_/_, sorrynot). 

trytofool2(test,doit/live/tuc/_,       thatisimpossible). %% TA-101029
trytofool2(test,doit/live/_/_,         waddyathink).      %% TA-100921
%
% trytofool2(test,  dob/be/tuc/_/_,cannotanswer).      
%% ->    trytofool

trytofool2(which,dob/like/_/tuc/_, idonotknow). %% hvem liker deg %% TA-110221

trytofool2(new,doit/live/_/_,   waddyathink).   %% jeg antar det %% TA-110119

trytofool(dob/beat/_/_/_,      thatisimpossible). %% TA-101112

trytofool(doit/lie1/tuc/_,   thatisimpossible).  %%  .. med en dame

trytofool(doit/happen/_/_, cannotanswer).

trytofool(doit/hear/tuc/_,  thatisimpossible). %% TA-101126

trytofool(_ isa age, cannotanswer). %% TA-110520

trytofool(_ isa opinion,     thatisimpossible).  
trytofool(_X isa god,        cannotanswer). 

%% trytofool(_X isa food,   mustknowfood). % :-)

trytofool( turings_test isa test,cannotanswermyself).
                                          
trytofool(_X isa chip,      nofoodonbus).  % chips

%% trytofool(_X isa compliment, thanks). 

%% trytofool(_ isa friend,thatisimpossible). 
trytofool(_ isa enemy,thatisimpossible). 

trytofool(_X isa icecream,  nofoodonbus). 

trytofool(_X isa drink,     nodrinkonbus). 
trytofool(_X isa alcohol,   nodrinkonbus).   
trytofool(_X isa beer,      nodrinkonbus).   
trytofool(_X isa food,      nofoodonbus). 
trytofool(_X isa fool,      thatisimpossible).  

trytofool(_X isa error,     noinfo_error_report). 

trytofool(_X isa humour,      nosenseofhumour). %% :-) %% TA-110125
trytofool(_X isa fun,         nosenseofhumour). %% :-) %% TA-110427

trytofool(_X isa pizza,     nofoodonbus).  %
trytofool(_X isa sausage,   nofoodonbus).  %


trytofool(_X isa smoke,     nosmokeonbus).  
trytofool(_X isa smoking,   nosmokeonbus). 
trytofool(_X isa tobacco,   nosmokeonbus).  


trytofool(_X isa wine,      nodrinkonbus).        %% 

trytofool(_X isa nonsense,   thatisimpossible). 
%% trytofool(_X isa question,   thatisagoodquestion). %% :-) //only if question (about question)
                                                  
trytofool(_  isa success,    wonderful). % :-)  

trytofool(dor/ask/(id)/that/tuc/_B/_C, sorrycannot). 

trytofool(adj/_/at_home/tuc/_,   thatisimpossible).  
trytofool(adj/_/adult/tuc/_,     thatisimpossible). 
trytofool(adj/_/afraid/tuc/_,    thatisimpossible). 
trytofool(adj/_/alcoholic/_/_,   nodrinkonbus). 
trytofool(adj/_/alive/tuc/_,     thatisimpossible).  
trytofool(adj/_/angry/_/_,       thatisimpossible).  
trytofool(adj/_/bad/tt/_,        thatisimpossible).   %%  :-)
trytofool(adj/_/bad/tuc/_,       thatisimpossible). 
trytofool(adj/_/bad/'I'/_,       thatisimpossible).  
trytofool(adj/_/beautiful/tuc/_, thatisimpossible). 
trytofool(adj/_/bear2/tuc/_,     thatisimpossible).       %% BE born
trytofool(adj/_/closed/_/_,      cannotanswer).  
trytofool(adj/_/conscious/tuc/_,  thatisimpossible).   
trytofool(adj/_/dissatisfied/'I'/_,   noinfo_error_report).  
trytofool(adj/_/drunk/_/_,   thatisimpossible).  %% TA-110807
trytofool(adj/_/old/_/_, noinfoabout(age)). 
trytofool(adj/_/open/_/_,        cannotanswer).    
trytofool(adj/_/dead/_/_,        thatisimpossible). %% idonotunderstand). %% i want to be dead
trytofool(adj/_/dead/tuc/_,      thatisimpossible).  
trytofool(adj/_/depressed/_/_,   thatisimpossible). 
%% trytofool(adj/_/drunk/tuc/_,     thatisimpossible).  %% :-)  
%% trytofool(adj/_/drunk/'I'/_,     thatisnotgood). 
trytofool(adj/_/drunk/_/_,       nodrinkonbus). 
trytofool(adj/_/embarrassed/tuc/_,   thatisimpossible). 
trytofool(adj/_/false/_/_,       thatisimpossible). %% rough ?
trytofool(adj/_/female/tuc/_,    thatisimpossible). 
trytofool(adj/_/free/tuc/_,      thatisimpossible). %%  :-) 
trytofool(adj/_/full/tuc/_,      thatisimpossible). %%  :-) // generic drunk
trytofool(adj/_/funny/_/_,       cannotanswer). 
%% trytofool(adj/_/good/tuc/_,    thanks).   % vil du være så snill !!!
trytofool(adj/_/happy/tuc/_,     thatisimpossible). 
%% trytofool(adj/_/happy/'I'/_,     cannotanswer).  %% glad i// jeg er glad
trytofool(adj/_/humoristic/_/_,  nosenseofhumour). %% TA-11025 \* ou
trytofool(adj/_/hungry/tuc/_,    thatisimpossible). 
trytofool(adj/_/ill/tuc/_,       thatisimpossible). 

trytofool(adj/_/intelligent/tuc/_, cannotanswermyself). 
trytofool(adj/_/incomprehensible/tuc/_,noinfo_error_report).  

trytofool(adj/_/interested/tuc/_, thatisimpossible). 
trytofool(adj/_/impossible/tuc/_, thatisimpossible).
trytofool(adj/_/lucky/tuc/_,      thatisimpossible).
trytofool(adj/_/male/tuc/_,       thatisimpossible). 
trytofool(adj/_/married/tuc/_,    thatisimpossible). 
trytofool(adj/_/married/'I'/_,    cannotanswer).  
trytofool(adj/_/stupid/_Tuc/_,    thatisimpossible). 
trytofool(adj/_/tedious/_Tuc/_,   thatisimpossible).  

trytofool(adj/_/wrong/tuc/_,     thatisimpossible).   %% ( er du/jeg gal)
trytofool(adj/_/wrong/'I'/_,     thatisimpossible). 

trytofool(adj/_/sober/tuc/_,      cannotanswersuchquestions). %% ( yes|no|*) 
trytofool(adj/_/sour/_/_,         thatisimpossible).     %% :-)
trytofool(adj/_/ugly/_/_,         thatisimpossible). 
trytofool(adj/_/sad/_/_,          thatisimpossible). 
trytofool(adj/_/sick/tuc/_,       thatisimpossible). 
trytofool(adj/_/unhappy/_/_,      thatisimpossible).
trytofool(adj/_/unknown/_/_,      cannotanswer).  

% trytofool(adj/_/unhappy/tuc/_,    thatisimpossible). 
% trytofool(adj/_/ordinary/_/_,       cannotanswer).      %%  ( ordinary route/resp Xmas)
%   error message from spcific days

trytofool(adj/_/tired/tuc/_,   thatisimpossible).  
trytofool(adj/_/ugly/tuc/_,    thatisimpossible).   %% gå i stygt vær 
%% trytofool(adj/_/wrong/tore/_,  thatisimpossible). 

trytofool(srel/on/language/english/_, noneedtoanswer). %% TA-110331

trytofool(srel/wrongly/_/_/_,  noinfo_error_report).
trytofool(adj/_/wrong/_/_,       noinfo_error_report). %% 

trytofool(adj/_/Pink/_/_,  thatisimpossible):- testmember(Pink,[black,pink,white]). %% etc    
                                              

trytofool(nrel/beyond/station/place/_/_,  cannotanswer). %%

trytofool(nrel/on/lust/agent/_/_,  thatisimpossible).   %% prob. fool-question 
trytofool(nrel/on/pity/agent/_/tuc,  thatisimpossible).


trytofool(srel/badly/(mode)/_/_,  thatisimpossible). %% idonotunderstand). 
trytofool(srel/in/mail/_/_, thatisimpossible).  


trytofool(comp/language/_/_/_,   cannotanswer). 

trytofool(comp/quality/gt/bustuc/_, thanks).  
trytofool(comp/quality/gt/busstuc/_, thanks). 
trytofool(comp/quality/gt/tuc/_, thanks). 


trytofool(has/agent/health/tuc/_,thatisimpossible).  
trytofool(has/agent/family/tuc/_,thatisimpossible). 
trytofool(has/agent/brother/tuc/_,thatisimpossible). 
trytofool(has/agent/father/tuc/_,thatisimpossible). 
trytofool(has/agent/mother/tuc/_,thatisimpossible). 
trytofool(has/agent/sister/tuc/_,thatisimpossible). 

trytofool(has/agent/life/tuc/_,thatisimpossible). 

trytofool(has/agent/relative/tuc/_,thatisimpossible). %% søsken

trytofool(has/agent/vacation/tuc/_,thatisimpossible).   

trytofool(has/agent/money/tuc/_,thatisimpossible). 
trytofool(has/agent/job/tuc/_,howtuchelp).  
trytofool(has/agent/lust/T/_,thatisimpossible):- T \== 'I'. 

trytofool(has/agent/birthday/'I'/_,    congratulations).   %%  :-)
trytofool(has/agent/birthday/tuc/_,    thatisimpossible). %%  :-)


trytofool(has/agent/mind/tuc/_,thatisimpossible). 
trytofool(has/agent/consciousness/tuc/_,thatisimpossible). 
trytofool(has/agent/beer/tuc/_,         thatisimpossible). 
trytofool(has/agent/coffee/tuc/_,       thatisimpossible). 

% trytofool(has/agent/feeling/tuc/_, thatisimpossible). // ha det bra
trytofool(has/agent/feeling/bustuc/_,      thatisimpossible). %% AD HOC

trytofool(has/agent/aunt/tuc/_,     thatisimpossible).
trytofool(has/agent/brother/tuc/_,  thatisimpossible).
trytofool(has/agent/child/tuc/_,    thatisimpossible).
trytofool(has/agent/father/tuc/_,   thatisimpossible). 
trytofool(has/agent/brother/tuc/_,   thatisimpossible). 
trytofool(has/agent/sister/tuc/_,    thatisimpossible).
trytofool(has/agent/uncle/tuc/_,        thatisimpossible).
trytofool(has/agent/wife/tuc/_,         thatisimpossible).  

trytofool(has/agent/enemy/tuc/_,    thatisimpossible). 
trytofool(has/agent/enemy/_/tuc,    thatisimpossible). 

trytofool(has/agent/friend/tuc/_,   thatisimpossible). 
trytofool(has/agent/friend/_/tuc,   thatisimpossible). 

trytofool(has/agent/husband/tuc/_,      thatisimpossible). 
trytofool(has/agent/intelligence/tuc/_, cannotanswermyself). 
trytofool(has/agent/knowledge/tuc/_,    howtuchelp). 
trytofool(has/agent/lunch/tuc/_,        thatisimpossible). 

trytofool(has/agent/parent/tuc/_,       thatisimpossible). 
trytofool(has/agent/relative/tuc/_,     thatisimpossible). 


trytofool(has/agent/vacation/tuc/_,     thatisimpossible). 


% trytofool(has/agent/age/_/_,      idonotknow). %% -> noinfoabout(age)

%% Verbs

trytofool(dob/make/tuc/_/_,   thatisimpossible).    %% TA-110706

trytofool(dob/damage/_/tuc/_,     noinfo_error_report). %% TA-110117

trytofool(dob/bear2/_/tuc/_,       thatisimpossible).  
trytofool(dob/bear2/_/_/_,         idonotknow).  

trytofool(dob/believe/tuc/_B/_C,   cannotanswersuchquestions). 

trytofool(dob/discover/tuc/_B/_C,   thatisimpossible). %% TA-100905
trytofool(doit/drink/_/_,            nodrinkonbus).  
trytofool(dob/drink/_/nil/_,       nodrinkonbus).  

trytofool(doit/eat/tuc/_,            thatisimpossible). %% TA-100905
trytofool(doit/end/tuc/_,            cannotanswersuchquestions).

trytofool(doit/babble/tuc/_,         thatisimpossible). 

trytofool(dob/be_named/'I'/_/_,    cannotanswer).

trytofool(dob/believe/tuc/_/_,     cannotanswer). 
trytofool(dob/believe/bustuc/_/_,  thatisimpossible).  

trytofool(dob/bear2/_/tuc/_,       thatisimpossible). 
trytofool(dob/bear2/_/bustuc/_,    thatisimpossible). 

trytofool(dob/be/tuc/'I'/_,        thatisimpossible). 
trytofool(dob/be/'I'/tuc/_,        thatisimpossible). 

trytofool(dob/be/'I'/_/_,        cannotanswer). 
trytofool(dob/be/_/'I'/_,        cannotanswer). 

trytofool(dob/amuse/_/tuc/_,      thatisimpossible). %% :- jeg morer deg

trytofool(dob/bore/_/_/_,      thatisimpossible). %% :-)

trytofool(doit/bicycle/tuc/_,     thatisimpossible). 

trytofool(doit/   buy/tuc/_,           sorrycannot). %% ?
trytofool(dob/buy/tuc/_/_,         sorrycannot). 

trytofool(dob/change/tuc/_/_,       thatisimpossible). 
trytofool(dob/check/tuc/_/_,        sorrycannot).
trytofool(dob/clean/tuc/_/_,        thatisimpossible). 
trytofool(dob/clean/_/tuc/_,        thatisimpossible). 
trytofool(dob/close/_/_,            cannotanswer).  
trytofool(doit/die/_/_,              thatisimpossible). 
     %% idonotunderstand).    %% (  Avoid "I want to die" ==> OK)

trytofool(dob/delete/'I'/tuc/_, bye). %% :-)  // slette bokmerke 
trytofool(dob/(remove)/_/_/_,     bye). %% TA-101112

trytofool(dob/drink/tuc/_/_,     thatisimpossible).     
trytofool(doit/dream/tuc/_,       thatisimpossible). 
trytofool(doit/drink/tuc/_,       thatisimpossible).  
trytofool(doit/eat/tuc/_,         thatisimpossible).  
trytofool(dob/eat/tuc/_/_,       thatisimpossible). 

trytofool(doit/eat/_/_,           nofoodonbus).   %% TA-110105
trytofool(dob/eat/_/_/_,         nofoodonbus).  %% :-)

trytofool(dob/earn/tuc/_/_,      thatisimpossible).
trytofool(dob/enjoy/tuc/_/_,     thatisimpossible).  

trytofool(doit/feel/tuc/_,        thatisimpossible). 
trytofool(dob/feel/tuc/_/_,      thatisimpossible). 
trytofool(doit/feel/'I'/_,         ok). %% icannotanswer).
trytofool(dob/feel/'I'/_/_,      ok). %% icannotanswer).
trytofool(doit/fly/tuc/_,          thatisimpossible). 

trytofool(dob/fetch/tuc/_/_,     thatisimpossible). 
trytofool(dob/fool/tuc/_/_,      thatisimpossible). %% only test 
trytofool(dob/forget/tuc/_/_,    ok).  

trytofool(dob/forgive/tuc/_/_,    ok). %% thatisimpossible). 
trytofool(dob/forgive/_/tuc/_,    thanks).           %%

trytofool(dob/greet/'I'/_/_,     thanks). 

trytofool(doit/go/UNIX/_,        thatisimpossible) :- UNIX isa system.
trytofool(doit/greet/tuc/_,      sorrycannot). 
trytofool(dob/greet/tuc/_/_,      sorrycannot). 

trytofool(dob/hate/_/_/_,        thatisimpossible). 
trytofool(dob/hear/tuc/_/_,        thatisimpossible). %% strictly 

trytofool(dob/know1/tuc/tagore/_,     thatisimpossible). %%  :-) %% Ad Hoc
trytofool(dob/know1/tuc/(_Tore,_Amble)/_, thatisimpossible). 

trytofool(dob/know/tuc/tagore/_,     thatisimpossible). %%  :-)
trytofool(dob/know/tuc/(_Tore,_Amble)/_, thatisimpossible). 


trytofool(dob/lay/tuc/tuc/_,     thatisimpossible). 
trytofool(doit/learn/tuc/_,        thatisimpossible). 
trytofool(doit/look/tuc/_,         thatisimpossible). 
trytofool(doit/lie2/tuc/_,         thatisimpossible). 
trytofool(doit/lie2/bustuc/_,      thatisimpossible). 

trytofool(dob/like/tuc/_/_,      thatisimpossible). 

trytofool(dob/like/_/tuc/_,      thanks).  %% jeg liker deg  %%  :-)

trytofool(dob/like/_/bustuc/_,      ok).                     %%  (doit/tuc=you)
trytofool(dor/like/(id)/_/tuc/_/_, thatisimpossible).          %%   like to

trytofool(doit/live/tuc/_,        thatisimpossible). 
trytofool(doit/live/_/_,          idonotknow).   %%  TA-100916
trytofool(doit/live/bustuc/_,     thatisimpossible).  
trytofool(doit/learn/tuc/_,       thatisimpossible).  
trytofool(dob/learn/tuc/_/_,    thatisimpossible). 
trytofool(dob/let/tuc/_/_,      sorrycannot).      %% TA-100903     %% la meg leve
trytofool(dob/love/tuc/_/_,     thatisimpossible). 
trytofool(dob/love/_/tuc/_,     thanks).  
trytofool(doit/laugh/tuc/_,       thatisimpossible). 
trytofool(dob/own/tuc/_/_,      thatisimpossible). 
trytofool(doit/open/_/_,          idonotknow). 

trytofool(dob/play/tuc/_/_,      thatisimpossible). 

trytofool(dob/call/tuc/_/_,      sorrycannot).  
trytofool(dob/close/tuc/_/_,     sorrycannot). 
trytofool(doit/congratulate/'I'/_,  thanks).  

trytofool(dob/do1/'I'/_/_,    cannotanswer). 

trytofool(dob/do1/tuc/_/_,    howtuchelp).  

trytofool(dob/drive/tuc/_/_,     sorrycannot). 
trytofool(doit/drive/tuc/_,       sorrycannot).

trytofool(doit/end/'I'/_,         bye).   %% jeg slutter på jobb

%% trytofool(dob/get/tuc/_/_, thatisimpossible). 

trytofool(doit/help/tuc/_, howtuchelp). %% reflexiv0 -> intrans 
trytofool(dob/help/tuc/_/_, howtuchelp).

trytofool(dob/hurt/_/_/_, thatisimpossible). 

trytofool(doit/go/tuc/_,      thatisimpossible). 

trytofool(doit/listen/tuc/_,      thatisimpossible). 

trytofool(doit/meet/tuc/_/_,      thatisimpossible).%% ok in telebuster ? 
 
trytofool(dob/make/_/'I'/_,   cannotanswer). 
trytofool(dob/meet/_/tuc/_,      thatisimpossible). 


trytofool(dob/believe/tuc/_/_,   thatisimpossible).

trytofool(dob/mean/tuc/_/_,      thatisimpossible).  
trytofool(doit/meet2/'I'/_,       thatisimpossible).           %% kan vi(jeg) møteS 
%% trytofool(dob/modify/_/_/_,      cannotanswer).  %% -> no error report
trytofool(dob/move/_/_/_,   cannotanswer).  %%  transitive move   

trytofool(dob/open/tuc/_/_,      sorrycannot). 
trytofool(dob/order/_/_/_,        cannotanswer). %% * thatisimpossible|sorrycannot

%% trytofool(dob/read/tuc/_/_,       sorrycannot). %% yes you can %% TA-110105

%% trytofool(dob/recognize/tuc/_/_,  sorrydont).  %% not action
trytofool(dob/remember/tuc/_/_,   sorrycannot).   %%  remember=know1 ?

trytofool(dob/see/tuc/_/_,       sorrycannot). 
trytofool(doit/see/tuc/_,            sorrycannot). 
trytofool(dob/see/_/tuc/_,       sorrycannot).
trytofool(dob/pass/_/tuc/_,         thatisimpossible). 
trytofool(dob/visit/_/tuc/_,        thatisimpossible).

trytofool(dob/sing/tuc/_/_,     thatisimpossible).  
trytofool(doit/sing/tuc/_,        thatisimpossible).  
trytofool(doit/sit/tuc/_,         thatisimpossible).   
trytofool(doit/sleep/tuc/_,       thatisimpossible). 
trytofool(doit/smoke/_/_,         nosmokeonbus).  
trytofool(doit/smile/tuc/_,       thatisimpossible). 
trytofool(doit/sneak/_/_,         thatisimpossible). 
trytofool(doit/stand/tuc/_,       thatisimpossible). 
trytofool(dob/start/_/tuc/_,    thatisimpossible). 
trytofool(dob/stop/_/tuc/_,     thatisimpossible).  
trytofool(doit/swim/tuc/_,        thatisimpossible). 

trytofool(dob/thank/'I'/tuc/_,   you_are_welcome).  
trytofool(doit/think/tuc/_,        cannotanswermyself).  %% kan du tenke 
trytofool(dob/think/tuc/_/_,     thatisimpossible). %%?  

trytofool(doit/thrive/tuc/_,      thatisimpossible). 
trytofool(doit/throw/tuc/_/_,       thatisimpossible). 

trytofool(doit/translate/tuc/_,   thatisimpossible).    %% intrans 
trytofool(dob/translate/tuc/_/_, thatisimpossible).    %% trans 
trytofool(doit/trust/'I'/_,        waddyathink). 
trytofool(doit/live/'I'/_,         waddyathink). %% TA-100916

trytofool(doit/wait/tuc/_,        ok). 
trytofool(dob/want/tuc/_/_,        thatisimpossible). 
trytofool(dob/use/_/tuc/_,howtuchelp). 
%%% trytofool(doit/exist/tuc/_,  howtuchelp). %% hvorfor eksisterer du %% TA-110404 
trytofool(doit/work/tuc/_,  howtuchelp).  %% hva driver du med  %%  virker du dårlig? 
trytofool(dob/use/tuc/_/_,sorrycannot). %% bruk en fullstendig setning  
                             
%% trytofool(dob/be/tuc/_/_, thatisimpossible).   %% noaction ?%% tuc er oppe %% TA-101018
trytofool(dob/get/tuc/_/_, ok).     
trytofool(dob/say/tuc/_/_,ok).  
trytofool(dob/know1/tuc/_/_, cannotanswer).     %% TA-100828
trytofool(dob/recognize/tuc/_/_, cannotanswer). %% not action verb %% 

%% trytofool(dob/_/tuc/_/_,sorrycannot).   %% action catchall
%  hvilke busser tar du ...
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
