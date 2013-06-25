/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE interapp.pl
%% SYSTEM TUC
%% AUTHOR J.Bratseth
%% CREATED  JB-970305
%% REVISED  TA-110511


% Bruker pragma til å bygge buslog-program fra TQL og svar fra buslog-program
% 

:- ensure_loaded('../declare'). %% RS-111213 General (semantic) Operators

:- volatile
           webstat/3.
:- dynamic 
           webstat/3.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



ieval(TQL0) :- value(teleflag,true), 
    !,
	 copy_term(TQL0,TQL),

    be_prepared(TQL,FQL), 

	 pragma(tele,FQL,P),       % Builds program
	 !,                        % Looks only at first try
	 writeprog(P),

    waves,  

    first_meat(FQL,FQL1),     % react to first FQL if negative message

	 irun(TQL,FQL,FQL1,P),     % Evaluates program, makes answer if success 
                              % TQL is only for tuc proper
	 !,                        % Only one program run

	  
    waves.  

ieval(TQL0) :-
         copy_term(TQL0,TQL),

    be_prepared(TQL,FQL), 

%........

%%%%%%%%%    set(actual_domain,tt),   %% default %% TA-090827

    set(airbusflag,false),   %% set dynamically if airbus request
                             %% TA-090331
    set(nightbusflag,false),  

    set(warning_sentence,false),  

    set(warningflag,false),


%%    determine_query_period, %% OUTDATED %% TA-110302

%%    determine_application_period(TQL), %% OUTDATED %% TA-110302


    forget(value(warningtime,_)), 

    forget(value(prewarningtime,_)), %% (all values are relevant)

    forget(value(samedayflag,_)), %% i.e. unknown 

%................

         pragma(trans,FQL,P),      % Builds program // may set samedayflag
         !,                        % Looks only at first try
         writeprog(P),

    printdots,  %% TA-110204 .. main   ends visible web respons 

    waves,

    first_meat(FQL,FQL1),     % react to first FQL if negative message

         irun(TQL,FQL,FQL1,P),     % Evaluates program, makes answer if success 
                              % TQL is only for tuc proper
         !,                        % Only one program run
                              % // May use  samedayflag

    update_webstat, %% --- 

    waves. 


waves :-  value(norsource,true), %% TA-110207
    !.

waves :-  value(traceprog,0), %% TA-110207
          !.

waves :-  value(dialog,1),
          !.

waves :-	
         write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'), % 80 chars
	      write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),nl.

determine_query_period :-
     
    veh_mod(H),

    (H=r1617_100621 -> query_period :=team;
     H=r1611_100823 -> query_period :=atb;
     query_period := nil).

determine_application_period([_:::TQL]):-
    veh_mod(H),
    (sequence_member(date(A,B,C) isa date,TQL) -> %% date occurs
        search_period_module(tt,date(A,B,C),_J);
        _J=H),
     !,
    (H=r1617_100621 -> application_period :=team;
     H=r1611_100823 -> application_period :=atb;
     application_period :=nil).

determine_application_period(_):-
    application_period :=nil.

%¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤



update_webstat :-  %% TA-090430
    todaysdate(TODAY),
  
    retract(webstat(TODAY,SMS,TOT)), %% dynamic/ declare
    !,

   (value(smsflag,true)
           -> (SMS1 is SMS+1,TOT1 is TOT + 1)%% 
            ; (SMS1 is SMS,  TOT1 is TOT+1)),
    assert(webstat(TODAY,SMS1,TOT1)),
    !.

update_webstat :-  %% TA-090430
    todaysdate(TODAY),
  
    SMS=0, TOT=0,

   (value(smsflag,true)
           -> (SMS1 is SMS+1,TOT1 is TOT + 1)%% 
            ; (SMS1 is SMS,  TOT1 is TOT+1)),
    assert(webstat(TODAY,SMS1,TOT1)),
    !.
 



%% Need first sentence it should react to

first_meat([(doit,replyq(_)),Y],Z):-!,
    first_meat(Y,Z).
first_meat([confirm:::_|Y],Z):-!, 
    first_meat(Y,Z).
first_meat([T|_],T):-!. 
first_meat(T,T).



be_prepared([T1|T2],[F1|F2]):- 
   !,
   be_prep1(T1,F1),
   be_prepared(T2,F2).
be_prepared([],[]):-!.

be_prepared(T,U):-
    be_prep1(T,U). 


be_prep1(TQL,FQL):- 
	 nocols(TQL,TQL2),
	 flatround(TQL2,FQL), 
	 konstantify(FQL).         % Flat TQL

writeprog(P) :-
	 value(traceprog,L),
	 L>1,
	 !,
    copy_term(P,Pwr),
	 numbervars(Pwr),
 	 nl,  
    prettypr('Application program',Pwr), 
    nl, 
    !.

writeprog(_). % Otherwise


traceanswer(Panswer) :- 
	 value(traceans,L),
	 L>1,
    !,
	 copy_term(Panswer,Pwr),
	 numbervars(Pwr),
	 prettypr('Application answer program',Pwr),nl. 
traceanswer(_). %% Otherwise


% Check if TQL still contains elements that it does not know anything about
% Before Try TUC


%  IRUN


irun(_A,_B,_C,_D):-    %% not interested in answer
    value(norsource,true),%% TA-110207
    !.

irun(_A,_B,_C,_D):-    %% not interested in answer
    value(traceprog,0),%% TA-110207
    !.


irun(A,B,C,D):- 
    \+ value(busflag,true), %% TA-110502 \+  !!!
    irun0(A,B,C,D),      %% Test for dumy answers
    !.
irun(A,B,C,D):-
    irun1(A,B,C,D).


% Check that it is worth trying the buslog program


% Not proper program.   May be something for standard tuc instead 

irun0(TQL,_FQL,_,PROG):- 
    \+ value(busflag,true),  %%  Drop TRY TUC  if busflag 
    \+ isuccess(PROG),
    \+ explain_query(TQL),
    !,    
    trytuc(TQL).   


avoidfool(FQL1) :- %% moved into bustrans %% TA-101014
    find_tag(FQL1,NWTD), %% new | do | test | which 
    sequence_member(XFrog,FQL1), 

    trytofool(NWTD,XFrog,Delphi),  %% negans.pl  %% new -> cant do | which -> cant answer
    !, 
    pay, %%%  nopay,  %% Change of policy 
    printmessage(Delphi).  


find_tag( (N,_R),N). 
find_tag(_,nil).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Successful program.  



irun1(_,_FlatCode,_FC1,Program) :-
    value(teleflag,true),
    !,
    isuccess(Program),
    execute_program(Program),
         !, 
    makeanswertele(Program).


irun1(_,FlatCode,_FC1,Program) :-
    isuccess(Program),

    execute_program(Program),
    !, 
    makeanswer(true,FlatCode,Program,Panswer),
	 !, 
    (value(mapflag,true) -> true;
       (printpaytag(Program), 
        writeanswer2(FlatCode,Program,Panswer))). 

 
% Unsuccessful program	


irun1(_,_FC,(item,_),Program):-   %% TA-110125    %% No messages 
    \+ sequence_member(message(_),Program),
    !,
    writeanswer((bcpbc(ok),period)). %% (if it comes that far)


irun1(_,_,FlatCode1,Program)  :- 
     makeanswer(false,FlatCode1,Program,Panswer),
	  !, 
     printpaytag(Program),
    
     printallmessagesprogram(Program), %% TA-110511 avoid 2Xneverpasses
     
     writeanswer(Panswer).             %%

                                       % Must check pay comes first
printpaytag(ProgIn):-
    payornotpay(ProgIn,PayNopay),
    call(PayNopay).
 
 
%% payornotpay(ProgIn,nopay) :-           %% Let them pay !! NB
%%    test(sequence_member(flag(fail),(ProgIn))),
%%     !.
payornotpay(_ProgIn,pay).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


makeanswertele(teleprocess(_,_,_,P)):-
    nl,
    nl,
    write(P), %% DUMMY, JUST A FILE NAME
    nl,
    nl.


execute_program2(Program,true):- 
    call(Program),
    !.
execute_program2(_Program,false). 
        



execute_program(Program):- %% For trace 
    call(Program).

printallmessagesprogram(Program):-  
    for(sequence_member(message(T),Program),   %% Print all messages in program
        (printmessageunconditionally(T))).                  %% Unconditional print 

%---------------------------------

%% Problem:  if smsflag, the answer may accidentally be blank
%% Test this and print messages anyhow, otherwise some standard
%% AD Hoc

writeanswer2(FQL,Program,Panswer):- 
    blankanswer(Panswer),
    sequence_member(departure(_,_,_,_),Program),
    !,
    printallmessagesanswer(FQL,Panswer,true). %% true means with departures

writeanswer2(FQL,Program,Panswer):- 
    blankanswer(Panswer),
    \+ sequence_member(departure(_,_,_,_),Program),
    !,
    printallmessagesanswer(FQL,Panswer,false). %% without departures


writeanswer2(_,_,Panswer):- 
    writeanswer(Panswer).

printallmessagesanswer(_FQL,Answer,false):- %% no deps, print even sms-invis
    sequence_member(printmessage(_),Answer),    %%
    !,
%%    call(pay),       %% <--- Check %% TA-071214 Nec?
    for(sequence_member(printmessage(T),Answer),   %% Print all printmessages in answer
        (printmessageunconditionally(T))).  


printallmessagesanswer([FQL|_],Answer,Dep):-
    \+ member(printmessage(_),Answer),
    !,
    standardemptysmsanswer(Dep,FQL,STAM),
%%     call(nopay),  %% bussen går kl 18 ->> OK + - 
    call(STAM),nl.  


%                      Dep
standardemptysmsanswer(true,(new,_),         bcp(ok)).
standardemptysmsanswer(true,(which(_),_),    bcpbc(nolongerperiod)). %% TA-070327
standardemptysmsanswer(true,(modifier(_),_), bcpbc(nolongerperiod)). %%
standardemptysmsanswer(true,_,               bcpbc(cannotanswer)). 

%                      NoDep
standardemptysmsanswer(false,(new,_),         bcp(ok)).
standardemptysmsanswer(false,(doit,_),          bcpbc(sorrycannot)). 
standardemptysmsanswer(false,(which(_),_),    bcpbc(cannotanswer)). 
standardemptysmsanswer(false,(modifier(_),_), bcpbc(cannotanswer)). 
standardemptysmsanswer(false,_,               bcpbc(cannotanswer)). 


writeanswer(Panswer) :- 
    traceanswer(Panswer),
    Panswer,
    !. 


blankanswer(Panswer):- 
%%    value(smsflag,true),  %% <--- Hva skjer = [ ] (smsflag=false)
   foralltest(sequence_member(X,Panswer), % utility
                  invisible_mess(X)).

invisible_mess(Mess):- 
    member(Mess,[startmark,endline,space,pay,nopay]). 
invisible_mess(printmessage(Mess)):-    
    empty_sms_message(Mess). %% busanshp.pl
 

%%%%%%%%%%%%%%%%%%%%%%%%%%

% Test if Buslog Program is appropriate

isuccess(P) :-
    sequence_member(A,P),   
    A=flag(fail), %% Nw flag, force negans
    !,fail.                     

isuccess(P) :-
    sequence_member(A,P),   
    isc(A),                 %%
    !.                      %% For Gods sake 


explain_query( explain::: _).


trytuc(R) :- evaluateq(R).

% makeanswer(Success,+FlatCode ,+Program,-AnswerOut).


%%%%%%%%        makeanswer(true,_, [timeout],_):- output('*** timeout ***'),!.


makeanswer(_,nil,_,(bcpbc(ok),nl)     ):-!. 

makeanswer(true,_,ProgIn,(bcpbc(nopassages),nl)     ) :- 
    sequence_member(departure(_,_,_,[]),ProgIn), %% after execution
    !.

makeanswer(true,FlatCode,ProgIn,AnswerOut       ) :-
    makeinitanswer(true,FlatCode,ProgIn,InitAnswer),
    pragma_aux(ans,ProgIn,InitAnswer,AnswerOut),
    !,
    make_total_google(AnswerOut, _TOTAL). %% busanshp.pl


makeanswer(false,FlatCode,ProgIn, AnswerOut) :-
    makenegative(FlatCode,ProgIn,AnswerOut),  %% negans.pl
    !. %%  <---

makeinitanswer(true,_Flatcode,_Progin,(startmark)):- !. %%%,STREETCONN):-





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Erstatter ::: og => med , i rund liste 

nocols((A:::B),(A,C)) :- %% Sentence Tag %% TA-090528
    !,
    nocols(B,C).


nocols((A::B),(A,C)) :- %% Lambda variable
    !,
    nocols(B,C).

nocols((A=>B),(A,C)) :- %% Very Rough
    !,
    nocols(B,C).

nocols((A,B),(A1,C)) :- 
    !,
    nocols(A,A1),
    nocols(B,C).


nocols(not A,not A1):- 
    !,
    nocols(A,A1).

nocols(A,A).


% Instantiates all variables i TQL to free(n) where n is a unique number

konstantify([]):-!. 
konstantify((A,B)) :- !,
    konstantify1(A),
    konstantify(B).
konstantify((not A)):-!,
    konstantify(A).  
konstantify(A) :- 
    konstantify1(A). 
konstantify(_).


konstantify1(A/B/C/D/E/F) :- 
	 bind(A),bind(B),bind(C),bind(D),bind(E),bind(F).
konstantify1(A/B/C/D/E) :- 
	 bind(A),bind(B),bind(C),bind(D),bind(E).
konstantify1(A/B/C/D) :- 
	 bind(A),bind(B),bind(C),bind(D).
konstantify1(A/B/C) :- 
	 bind(A),bind(B),bind(C).
konstantify1(A/B) :- 
	 bind(A),bind(B).
konstantify1(A isa B) :- 
	 bind(A),bind(B).
konstantify1(A) :-
	 bind(A).


notbothfree(X,Y):-freet(X),freet(Y),!,fail.%% restrictions  on rules
notbothfree(_,_).                     %%  on rules

freet(free(_)).

newfree(free(C)) :- newconst(C).

bind(A) :- nonvar(A).
bind(free(C)) :- newconst(C).

prettypr(H,P) :- 
	write('*** '), %% drop ... %% TA-110204
   write(H),
   write(' ***'),
   nl,nl, 
   prettypr2(P).
prettypr2((X,R)) :-
	!,   
   write(X),nl,prettypr2(R).
prettypr2(X) :-
	write(X),nl.

%%% 


decidewday(Surday,M):- %% classical !trap 
    (Surday\==sunday , Surday\==saturday),
    !,
    M=monday.
decidewday(Wday,Wday).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Suksessregler

% The list of all proper buslog predicates

isc(listofall(_Entity,_)).                % generalized list of entities 

/*
  isc(allbuses(_)).                     % navnet på bussene 
  isc(allnightbuses(_)).                % navnet på nattbussene 
  isc(allstations(_)).                  % navnet på stasjonene 
*/

%% isc(atdate(_)).                       % Hvilken dato turen går

isc(notification(_Date,_Time)).       % notification independent of departures
isc(connections(_,_,_,_,_,_,_,_,_,_)).  % en rute mellom to steder
isc(coupled(_,_,_,_,_,_,_,_)).        % en rute mellom to steder
isc(db_reply(_,_,_)).                 % answer from database
isc(dateis(_,_,_,_)).                 % datoen
% isc(daysucc(_,_)).                    % next day %% hva klokka i går 
% isc(diffdep(_,_,_,_,_)).              % tidsdifferanser
isc(diffdep4(_,_,_,_)).               % tidsdifferanser 
isc(endstation(_,_)).                 % endestasjoner // old %%  /3 -> /3
isc(endstations(_,_)).                % endestasjoner
isc(false).                           % Answer No 
isc(findprice(_,_,_,_)).              % en bussturpris
isc(message(X)):-                     % En beskjed %% avoid donotknow message 
   informative_message(X).
isc(flag(exit)).  
isc(numberof(_,_,_)).                 % antall stasjoner/busser/...
isc(passesstations(_,_,_,_)).         % stasjonene en buss passerer
isc(passevent(_,_,_,_,_,_)).          % en busspassering
isc(departure(_,_,_,_)).              % a departure 
isc(properstation(_)).                % er en busstasjon
isc(reply(_)). 
isc(replyq(_)).                       %
isc(station(_)).                      % er en stasjon
isc(stationsat(_,_,_)).               % stasjoner på sted, implicit
isc(stationsnear(_,_,_)).             % stasjoner nært sted
isc(takestime(_,_,_)).                % lag tidsforbruks liste 
isc(testanswer(_,_)).                 % yes or no test 
isc(ticketprice2(_,_)).               % en billettpris specific 
isc(timeis(_)).                       % klokka
isc(tramstations(_)).                 % navnet på trikkestasjonene
isc(true).                            % Answer Yes

isc(teleprocess(_,_,_,_)) :- value(teleflag,true). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Dont pay for noninformative messages %% Policy changed !!! 
%% Avoid don't know/OK  for informative messages


informative_message(answer(_)).   
informative_message(noroutesfor(_)). 
informative_message(howtuchelp).        %% avoid double vetikke
informative_message(mustknow(_)).       %% enough infromation 

%% etc 
                                        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
