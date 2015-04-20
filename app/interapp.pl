/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE interapp.pl
%% SYSTEM TUC
%% AUTHOR J.Bratseth
%% CREATED  JB-970305
%% REVISED  TA-110511

%% UNIT: /app/ (buslog)      %% RS-131230
% Bruker pragma til å bygge buslog-program fra TQL (bustrans.pl),
%       og senere til å bygge svar-program fra buslog-program (busans.pl)

%:- meta_predicate  % This area (before :-module ) belongs to pragma!! Why? Last import?

%% UNIT: /app/
:-module( interapp, [ avoidfool/1, decidewday/2, determine_application_period/1, determine_query_period/0, execute_program/1, execute_program2/2, % To checkitem2.pl  
                      ieval/1, invisible_mess/1, isuccess/1, konstantify/1, makeanswer/4, newfree/1, notbothfree/2, nocols/2, webstat/3 ] ).  % occ/2, roundmember/2, waves/0, % needed in pragma.pl?

:-op( 731,xfy, ::: ).    %% sentence tag  %% TA-090514 For main, tuc/ [ translat, gram_x, evaluate, dcg_x, anaphors ], dialog/d_dialogue, app/interapp
:-op( 730,xfy, :: ).     %% lambda infix  %% RS-141026 For      tuc/ [ translat gram_x fernando  dcg_x anaphors ], app/interapp, dialog/ [checkitem/2 d_context d_dialogue frames/2 makeframe/2 parseres virtuals relax update2 usesstate2]

%% META-PREDICATES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%:- meta_predicate  irun(+, ?, ?, 0).   %% irun/4. : means Stay inside interapp? Should the program be interpreted inside interapp? %% RS-140619
%:- meta_predicate  irun0(+, ?, ?, 0).  %% irun0/4. Stay inside interapp? %% RS-140619
%:- meta_predicate  irun1(+, ?, ?, 0).  %% irun1/4. Stay inside interapp? %% RS-140619
%:- meta_predicate  isuccess(0).  %% Stay inside interapp? %% RS-140210

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- meta_predicate  execute_program( 0 ).  %% Stay inside interapp? %% RS-140619
:- meta_predicate  execute_program2( 0, + ).  %% Stay inside interapp? %% RS-140619
:- meta_predicate  extractbing( +, 0, ?, ? ) .   %% RS-140617

:- meta_predicate  foralltest(0,0).  %% for/2. Stay inside interapp? %% RS-140619
:- meta_predicate  make_total_google( 0, ? ) .   %% RS-140927 Move up? Before busanshp?
:- meta_predicate  totaljsonprint( +, 0 ) .      %% RS-140927
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- volatile
           webstat/3.
:- dynamic 
           webstat/3.

% 

%%% RS-131225, UNIT: / and utility/
%:- ensure_loaded( user:'../declare' ). %% RS-111213 General (semantic) Operators
:- use_module( '../declare', [ ( := )/2, forget/1, set/2, trackprog/2, value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .
:- use_module( '../utility/meta_preds', [ writeanswer/1 ] ).  %% Compatible with sicstus4, get0/1 etc.
:- use_module( '../sicstus4compatibility', [ output/1 ] ).  %% Compatible with sicstus4, get0/1 etc.

%%% RS-131225, UNIT: /utility/
:- use_module( '../utility/utility', [ append_atoms/3, flatround/2, newconst/1, fnuttify2/2, for/2, once1/1, sequence_member/2 ] ). %forget/1,  
        % Made local:  occ/2, %% RS-140928 %% RS-140412 output/1  %% RS-131231, False Warning, SPIDER-bug. output/1 IS used !! when called from... bustrans?
:- use_module( '../utility/writeout', [ printdots/0, waves/0, writeprog/1 ] ). % traceanswer/1,  

%%% RS-140921, EXTERNAL LIBRARIES
%:- use_module( library( varnumbers ), [ numbervars/1 ] ). %% RS-140210.
%:- use_module( library( aggregate ), [ foral/2 ] ). %% RS-140210.   %% RS-141029  for-all Does NOT work like utility:for/2

%%% RS-131225, UNIT: /
%% RS-141026    UNIT: /
%:- use_module( '../main.pl', [ ( := )/2, set/2, value/2 ] ). %MISERY: trackprog/2, 
%:- use_module( '../main.pl', [ ] ). %% RS-111213 printdots/0, trackprog/2, 
:- use_module( '../interfaceroute', [ search_period_module/3 ] ). %%, 

%%% RS-131225, UNIT: app/
:- use_module( busanshp, [ empty_sms_message/1, printmessage/1, printmessageunconditionally/1 ] ).
                % make_total_google/2, startmark/0 %, og mange flere ] ). % bustrans calls ... space/0, ...
:- use_module( buslog, [ station_trace/4, veh_mod/1 ] ). %% message/1 used in call-back from xxx!??? xxx = busanshp?  trackprog/2, 
:- use_module( negans, [ makenegative/3, trytofool/3 ] ).       %% RS-140208
:- use_module( pragma, [ pragma/3, pragma_aux/3 ] ). % , sequence_member/2.   %%RS-131228  pragma/3 etc. Is using "user:" here the way to go? %% RS-140927

%:- use_module( busanshp, [  veh_mod/1 ] ).     %% RS-131230
%:- use_module( bustrans, [ flag/1 ] ). %% flag/1 and message/1 used in call-back from xxx!??? xxx = busanshp?

%%% RS-131225, UNIT: /db/
:- use_module( '../db/statcoord2', [ statcoord/4 ] ). %% RS-120816 statcoord/4
:- use_module( '../db/regstr', [ streetstat/5 ] ). %% RS-140928

%% RS-141026, UNIT; /dialog/
%:- use_module( '../dialog/checkitem2', [ trackprog/2 ] ).  %% RS-131117 includes declare.pl , writeanswer/1 localized
%:- use_module( '../dialog/update2', [ trackprog/2 ] ).  %% RS-141031

%%% RS-131225, UNIT: /tuc/
:- use_module( '../tuc/evaluate', [ evaluateq/1 ] ).  %% RS-131117 includes declare.pl

%%% RS-131225, UNIT: utility/
:- use_module( '../utility/datecalc', [ todaysdate/1 ] ).  %% RS-131231, SPIDER-bug. timenow2/2 IS used!!  ). %% timenow2/2, 
%% :- DependsOn = [  timenow2/2 ], use_module( '../utility/datecalc', DependsOn ).
:- use_module( '../utility/writeout', [ pay/0 ] ).  %% RS-131231, SPIDER-bug. timenow2/2 IS used!!

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

foralltest(P,Q) :- \+ ( P, \+ Q). 

%once1(P) :- P,!. %% same as once, but version independent % try once, otherwise FAIL

% Debug Exit: :(interapp,writeanswer(,(startmark,,(printmessage(date_isa_day(date(2014,4,13),sunday)),,(endline,,(printmessage(otherperiod(date(2014,4,13))),,(endline,,(google(dir(depnode(32,32,2,2,30,bus_0108_0007,108,2,dronningens_gate_d1),stavset)),,(bwrbusbc(nightbus,108),,(bcp(passes),,(bwr(dronningens_gate_d1),,(bcp(attime),,(bwt(32),,(nl,,(bcp(and),,(bcp(arrivesat),,(bwr(stavset),,(bcp(attime),,(bwt(54),,(period,,(output(...),,(bwrbusbc(nightbus,119),,(bcp(passes),,(bwr(munkegata_m1),,(bcp(attime),,(bwt(302),,(nl,,(bcp(and),,(bcp(arrivesat),,(bwr(stavset_senter),,(bcp(attime),,(bwt(325),,(period,earliesttimes))))))))))))))))))))))))))))))))) ?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%For tele!
ieval(TQL0) :- value(teleflag,true),    %% RS-131228    Exported through tuc/evaluate.pl!
    !,
	 copy_term(TQL0,TQL),

    be_prepared(TQL,FQL), 

%         pragma(tele,FQL,P),       % Builds program    %% RS-141006
         pragma(teletrans,FQL,P),       % Builds program
	 !,                        % Looks only at first try
	 writeprog(P),

    waves,  

    first_meat(FQL,FQL1),     % react to first FQL if negative message

	 irun(TQL,FQL,FQL1,P),     % Evaluates program, makes answer if success 
                              % TQL is only for tuc proper
	 !,                        % Only one program (P?) is run      %% RS-141006

	  
    waves.  

%For others
ieval(TQL0) :-
    copy_term(TQL0,TQL),

    be_prepared(TQL,FQL), 
%........               %%%%%%%%%    set(actual_domain,tt),   %% default %% TA-090827
    set(airbusflag,false),   %% set dynamically if airbus request   %% TA-090331 set is from declare.pl
    set(nightbusflag,false),  
    set(warning_sentence,false),  
    set(warningflag,false),

%%    determine_query_period, %% OUTDATED %% TA-110302
%%    determine_application_period(TQL), %% OUTDATED %% TA-110302

    forget( value(warningtime,_) ),  %% RS-131230-140928 forget is moved to utility
    forget( value(prewarningtime,_) ), %% (all values are relevant)
    forget( value(samedayflag,_) ), %% i.e. unknown 

%................

         pragma( bustrans, FQL, P ),      % Builds program // may set samedayflag
         !,                        % Looks only at first try
         writeprog(P),

    printdots,  %% TA-110204  %% RS-131230 from main.pl   ends visible web respons

    waves,

    first_meat( FQL, FQL1 ),     % react to first FQL if negative message (FQL = Flat Code?)

%         irun( TQL, FQL, FQL1, buslog:P ),     % Evaluates program (in buslog.pl), makes answer if success
        irun( TQL, FQL, FQL1, P ),     % Evaluates program (in busans.pl)?, makes answer if success
                              % TQL is only for tuc proper
         !,                        % Only one program run
                              % // May use  samedayflag

    update_webstat, %% --- 

    waves. 


determine_query_period :-
     
    veh_mod(H),

    (H=r1617_100621 -> ( query_period := team );
     H=r1611_100823 -> ( query_period := atb );
     ( query_period := nil )
    ).

determine_application_period( [ _ ::: TQL ] ) :-
    veh_mod(H),
    ( sequence_member( date(A,B,C) isa date, TQL ) -> %% date occurs
        search_period_module(tt, date(A,B,C), _J );   %% utility.pl? or topreg?
        _J=H),
     !,
    (H=r1617_100621 -> ( application_period := team );
     H=r1611_100823 -> ( application_period := atb );
     ( application_period := nil )
    ).

determine_application_period(_):-
    ( application_period := nil ).

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

first_meat( [(doit,replyq(_)),Y], Z ) :- !,
    first_meat(Y,Z).
first_meat( [confirm:::_|Y], Z ) :- !,
    first_meat(Y,Z).
first_meat( [T|_], T ) :- !.
first_meat( T, T ) .



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



% Check if TQL still contains elements that it does not know anything about
% Before Try TUC


%  IRUN irun( TucQueryLogic, FlatQueryLogic, FirstQueryLogic, PROG ) :-


irun( _A, _B, _C, _D ) :-    %% not interested in answer
    value(norsource,true),%% TA-110207
    !.

irun( _A, _B, _C, _D ) :-    %% not interested in answer
    value(traceprog,0),%% TA-110207
    !.


irun( A, B, C, D ) :-
    \+ value( busflag, true ), %% TA-110502 \+  !!!
    irun0( A, B, C, D ),      %% Test for dummy answers
    !.

irun( A, B, C, D ) :-
    irun1( A, B, C, D ).


% Check that it is worth trying the buslog program


% Not proper program.   May be something for standard tuc instead 

irun0( TQL, _FQL, _, PROG ) :-
    \+ value(busflag,true),  %%  Drop TRY TUC  if busflag 
    \+ isuccess( PROG ),
    \+ explain_query( TQL ),
    !,    
    trytuc( TQL ).


avoidfool( FQL1 ) :- %% moved into bustrans %% TA-101014
    find_tag( FQL1, NWTD ), %%  new | which | test | do  (NWTD)
    sequence_member( XFrog, FQL1 ),

    trytofool(NWTD,XFrog,Delphi),  %% negans.pl  %% new -> cant do | which -> cant answer
    !, 
    pay, %%%  nopay,  %% Change of policy 
    printmessage(Delphi).  


find_tag( (N,_R), N ).
find_tag( _, nil ).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% Successful program.  

irun1( _, _FlatCode, _FC1, Program ) :-
    value( teleflag, true ),
    !,
    isuccess( Program ),
    execute_program( buslog:Program ),         %% Just for debugging? %% RS-141012 Moved to checkitem2.pl
         !, 
    makeanswertele( Program ).


irun1( _, FlatCode, _FC1, Program ) :-
    isuccess( Program ),

    execute_program( buslog:Program ),         %% Make answer just for successful application program? %% RS-141030
    !,
    makeanswer( true, FlatCode, Program, Panswer ), %% true == successful program
	 !, 
    ( value( mapflag, true ) -> true ;  ( printpaytag(Program), writeanswer2( FlatCode, Program, Panswer ) ) ).

 
% Unsuccessful program	(No routes info, ...)


irun1( _, _FC, (item,_), Program ) :-   %% TA-110125    %% No messages
    \+ sequence_member( message(_), Program ),  %% RS-141018  sequence_member handles "module:"-prefixes
    !,
    writeanswer( busanshp:(bcpbc(ok),period) ). %% (if it comes that far)


irun1( _, _, FlatCode1, Program ) :-
     makeanswer( false, FlatCode1, Program, Panswer),   %% false == unsuccessful program
	  !, 
     printpaytag( Program ),
    
     printallmessagesprogram( Program ), %% TA-110511 avoid 2Xneverpasses
     
     writeanswer( Panswer ).             %%

                                     % Must check pay comes first
printpaytag( ProgIn ) :-
    payornotpay( ProgIn, PayNopay ),
    call(PayNopay).
 
 
%% payornotpay(ProgIn,nopay) :-           %% Removed: Let them pay !! NB
%%    test(sequence_member(flag(fail),(ProgIn))),
%%     !.
payornotpay(_ProgIn,pay).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%makeanswertele( teleprocess(_,_,_,P) ) :- %% RS-140619. For debugging teleprocess
makeanswertele( teledat2:teleprocessdirect(_,_,_,P) ) :- %% RS-140619. For debugging teleprocess
    nl,
    nl,
    write(P), %% DUMMY, JUST A FILE NAME
    nl,
    nl.

execute_program2( Program, true ) :- 
    call( Program ),
    !.
execute_program2(_Program,false). 
        

% MOVED TO CHECKITEM2.pl
execute_program( Module:Program ) :- %% For trace      %% RS-141012
    call( Module:Program ). %% Someone else MUST have used the correct use_modules in user: (message/1 etc.)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MOVED BACK FROM  interapp.pl. Localized in checkitem2, interapp and update2, to avoid meta_predicate ordering conflicts. %% RS-141026
%:- meta_predicate  execute_program( 0 ).  %% Stay inside interapp? %% RS-140619
execute_program( Prog ) :-

    trackprog(3, output('interapp BEGIN  program') ), 
(   call( Prog ) ->
           trackprog(3, output('END  program') ) ;
           trackprog(3, output('FAIL  program') ), fail 
).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

printallmessagesprogram( Program ) :-
    for( sequence_member( message(T), Program ),   %% Print all messages in program
        ( printmessageunconditionally(T) ) ).                  %% Unconditional print 

%---------------------------------


%% Problem:  if smsflag, the answer may accidentally be blank
%% Test this and print messages anyhow, otherwise some standard
%% AD Hoc

writeanswer2( FQL, Program, Panswer ) :-
    blankanswer( Panswer ),
    sequence_member( departure(_,_,_,_), Program ),
    !,
    printallmessagesanswer(FQL,Panswer,true). %% true means with departures

writeanswer2(FQL,Program,Panswer):- 
    blankanswer(Panswer),
    \+ sequence_member(departure(_,_,_,_),Program),
    !,
    printallmessagesanswer(FQL,Panswer,false). %% false means without departures

writeanswer2( _, _, Panswer ) :- %% RS-150403 Experiment??
    writeanswer( busanshp:Panswer ).


printallmessagesanswer( _FQL, _:Answer, false ) :- %% no deps, print even sms-invis
    sequence_member( printmessage(_), Answer ),    %%
    !,
%%    call(pay),       %% <--- Check %% TA-071214 Nec?
    %   for(sequence_member(printmessage(T),Answer),   %% Print all printmessages in answer
    for( sequence_member(printmessage(T),Answer),   %% Print all printmessages in answer
        ( printmessageunconditionally(T) ) ).


printallmessagesanswer([FQL|_],Answer,Dep):-
    \+ member(printmessage(_),Answer),
    !,
    standardemptysmsanswer(Dep,FQL,STAM),
%%     call(nopay),  %% bussen går kl 18 ->> OK + - 
    call(STAM),nl.  


%                      Dep
standardemptysmsanswer( true, (new,_),         busanshp:bcp(ok)).
standardemptysmsanswer( true, (which(_),_),    busanshp:bcpbc(nolongerperiod)). %% TA-070327
standardemptysmsanswer( true, (modifier(_),_), busanshp:bcpbc(nolongerperiod)). %%
standardemptysmsanswer( true, _,               busanshp:bcpbc(cannotanswer)). 

%                      NoDep
standardemptysmsanswer( false, (new,_),         busanshp:bcp(ok) ).
standardemptysmsanswer( false, (doit,_),        busanshp:bcpbc(sorrycannot) ).
standardemptysmsanswer( false, (which(_),_),    busanshp:bcpbc(cannotanswer) ).
standardemptysmsanswer( false, (modifier(_),_), busanshp:bcpbc(cannotanswer) ).
standardemptysmsanswer( false, _,               busanshp:bcpbc(cannotanswer) ).


blankanswer( _:Panswer ) :-
%%    value(smsflag,true),  %% <--- Hva skjer = [ ] (smsflag=false)
   foralltest( sequence_member( X, Panswer ),  interapp:invisible_mess(X) ). % utility

invisible_mess(Mess):- 
    member( Mess, [ startmark, endline, space, pay, nopay ] ). 

invisible_mess(printmessage(Mess)):-    
    empty_sms_message( Mess ). %% busanshp.pl
 

%%%%%%%%%%%%%%%%%%%%%%%%%%

% Test if Buslog Program is appropriate

isuccess(P) :-
    sequence_member(A,P),   
    A=flag(fail), %% New flag, force negans
    !,fail.                     

isuccess(P) :-
    sequence_member(A,P),   
    isc(A),                 %% is success (in source code). RS-140210
    !.                      %% For Gods sake 


explain_query( explain::: _).


trytuc(R) :- evaluateq(R).



%%%%%%%%%%%  GOOGLE MAP SECTION  %%%%%%%%%%%%%%%%%%%%%

convert_int_street(Y-N,EY9) :-

    once1(streetstat(Y,YY,_,_,_)),
    !,
    append_atoms(YY,' ',YYB), %% NB   append_atoms ' ' + 9 = 9
    append_atoms(YYB,N,EY9).    %% from utility.pl


convert_int_street(Y-N,EY9):- %% Unknown
    !,
    append_atoms(Y,' ',YYB),
    append_atoms(YYB,N,EY9).    

convert_int_street(Y,YY):- %% No Number
    once1(streetstat(Y,YY,_,_,_)),
    !.


convert_int_street(_,nil):- %% Missing/Unknown
    !.



totaljsonprint( TOTAL, AnswerOut ):-
    write('{'),nl,
    write('"route" :'),nl,
    prettyjsonprint( TOTAL ),
    write(','),nl,
    write('"busstuc" :'),nl,
    write('"'),
    call( AnswerOut ),
      write('"'),
    nl,
    write('}'),nl.


extractbing( U, _:V,  X, W ) :- sequence_member( U, V ), !, W=X .     %% sequence_member is from utility.pl
extractbing(_U,_:_V, nil,nil).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
make_total_google( AnswerOut,  TOTAL ):-

    extractbing( outstreetconn(start,Y9,_ND), AnswerOut, Y9,START ),   %% street coord unk
     
    extractbing( outstreetconn(stop,STAD,_RSK), AnswerOut,STAD,STOP ), %% street coord unk

    extractbing( google(U), AnswerOut,U,Bang ), %% google is just an executable mark in busans

    googlemaptrace( Bang,  BusTrace),

    convert_int_street(START,EY9),
    convert_int_street(STOP,ESTAD),

    makestreetelement('"streetaddress"','"start"',st(0,EY9),START1),

    makestreetelement('"streetaddress"','"stop"',st(0,ESTAD),STOP1),

    append([START1],BusTrace,SBANG),
    append(SBANG,[STOP1],TOTAL),

    (value(mapflag,true) -> totaljsonprint( TOTAL, AnswerOut ) ; true).


googlemaptrace(nil,[]):-!. %% no route


googlemaptrace( W, Bingo ) :-
     maptrace( W, dual( List1, List2 ) ),
     enterexit( List1, Bing1 ),
     enterexit( List2, Bing2 ),

     append( Bing1, Bing2, Bingo ),
     !.






prettyjsonprint( Bingo ) :-
    write('['),nl,
    jsonbody(Bingo),
    write(']'),nl.


jsonbody([X]):- !,write(X),nl. %% last
jsonbody([X|Y]):- !,write(X),write(','),nl, %% last
    jsonbody(Y).



enterexit([],[]):-!. %% direct

enterexit([X|Rest],[B1|Brest]):-!,
    makelement('"busstop"','"enter"',X,B1),
    enterexit1(Rest,Brest).


 enterexit1([X],[B1]):-
    !,
    makelement('"busstop"','"exit"',X,B1).


enterexit1([X|Rest],[B1|Bingrest]):-
    !,
    makelement('"busstop"','"pass"',X,B1),
    enterexit1(Rest,Bingrest).

enterexit1([],[]):-!. %% abnormal

makestreetelement(Type,Role,st(_STATNO,Intname),{'"name"':NIntname2,'"type"':Type,'"role"':Role}):-
     nullify(Intname,NIntname),
          !,
    fnuttify2(NIntname,NIntname2).      %% from utility.pl


makelement(Type,Role,st(STATNO,Intname),{'"name"':NExtname2,'"type"':Type,'"nr"':STATNO,'"role"':Role,'"xcoord"':NXcoord,'"ycoord"':NYcoord}):-

    xstatcoord(STATNO, Intname,Extname, Xcoord,Ycoord),


    nullify(Extname,NExtname),
    nullify(Xcoord,NXcoord),
    nullify(Ycoord,NYcoord),

    !,
    fnuttify2(NExtname,NExtname2). %% utility

nullify(0,'"null"'):-!.
nullify(nil,null):-!. %% will be fnuttified
nullify(X,X):-!.




xstatcoord(STATNO, _Intname,Extname, Xcoord,Ycoord):-
    statcoord(STATNO,Extname, Xcoord,Ycoord),
    !.


xstatcoord(_STATNO, Intname,Extname, Xcoord,Ycoord):- %% NB Missing station in direction,
    veh_mod(CurrMod),                            %% try other side of street
    CurrMod:hpl(STATNO,Intname,_,Extname),        %% e.g Bjarne Næss veg
    statcoord(STATNO,_Extname, Xcoord,Ycoord),
    !.


xstatcoord(_Num0, Intname,Intname, 0,0). %% NB Missing station in direction,



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

maptrace( dir( depnode(_,_,_,_,_,Rid,_,_,Gløshaugen_syd), Nardosenteret), dual( LIST, [] ) ) :-
    !,
    xstation_trace(Rid,Gløshaugen_syd,Nardosenteret,LIST).


maptrace( corr( depans( _, Rid1, _, Prinsen_kinosenter, _, _Rid2, _, Gløshaugen_nord ), %% Special, dummy corr-> direct
               nil ), dual( List1, [] ) ) :-
    !,
    xstation_trace(Rid1,Prinsen_kinosenter,Gløshaugen_nord,List1). %% TA-110323


maptrace( corr( depans( _, Rid1, _, Prinsen_kinosenter, _, Rid2, _, Gløshaugen_nord ),
               midans( _, _, Studentersamfundet_1, _, _, Studentersamfundet_2) ), dual( List1, List2 ) ) :-

    xstation_trace(Rid1,Prinsen_kinosenter,   Studentersamfundet_1, List1), %% TA-110323
    xstation_trace(Rid2,Studentersamfundet_2, Gløshaugen_nord,      List2). %%


xstation_trace(Rid,Gløshaugen_syd,Nardosenteret,LIST):-
    station_trace(Rid,Gløshaugen_syd,Nardosenteret,LIST),!.

xstation_trace(_Rid,_Gløshaugen_syd,_Nardosenteret,[]). %% error berg_studentby-> lerkendal_gård










% makeanswer( Success, +FlatCode , +Program, -AnswerOut ).

%%%%%%%%        makeanswer( true, _, [timeout], _) :- output('*** timeout ***'), !.


makeanswer( _, nil, _,  busanshp:(bcpbc(ok),nl)     ) :- !. 

makeanswer( true, _, ProgIn,  busanshp:(bcpbc(nopassages),nl)     ) :- 
    sequence_member( departure(_,_,_,[]), ProgIn ), %% Empty list of bus-departures, after execution
    !.

makeanswer( true, FlatCode, ProgIn,  busanshp:AnswerOut       ) :-
    makeinitanswer( true, FlatCode, ProgIn, InitAnswer ),
    pragma_aux( busans:ProgIn, InitAnswer, AnswerOut ),   % pragma.pl pragma_aux/3 %% RS-141012
    !,
    make_total_google( AnswerOut, _TOTAL) ; true. %% busanshp.pl  DON'T fail on missing GoogleMap functionality!


makeanswer( false, FlatCode, ProgIn, busanshp:AnswerOut ) :-
    makenegative( FlatCode, ProgIn, busanshp:AnswerOut ),  %% negans.pl OLD: user:makenegative/3
    !. %%  <---

%makeinitanswer( true, _Flatcode, _Progin, busanshp:(startmark) ):- !. %%%,STREETCONN):-
makeinitanswer( true, _Flatcode, _Progin, startmark ):- !. %%%,STREETCONN):-





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

konstantify( [] ):-!. 
konstantify( (A,B) ) :- !,
    konstantify1( A ),
    konstantify( B ).
konstantify( (not A) ):-!,
    konstantify( A ).  
konstantify( A ) :- 
    konstantify1( A ). 
konstantify( _ ).


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

newfree(free(C)) :- newconst(C).   % utility.pl

bind(A) :- nonvar(A).
bind(free(C)) :- newconst(C).



decidewday(Surday,M):- %% classical !trap 
    (Surday\==sunday , Surday\==saturday),
    !,
    M=monday.
decidewday(Wday,Wday).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Suksessregler (interapp success)
% The list of all proper buslog predicates

isc( listofall( _Entity, _) ).          % generalized list of entities
/*
  isc(allbuses(_)).                     % navnet på bussene 
  isc(allnightbuses(_)).                % navnet på nattbussene 
  isc(allstations(_)).                  % navnet på stasjonene 
*/
%% isc(atdate(_)).                       % Hvilken dato turen går

isc(notification(_Date,_Time)).         % notification independent of departures
isc(connections(_,_,_,_,_,_,_,_,_,_)).  % en rute mellom to steder (ingen overgang?)
isc(coupled(_,_,_,_,_,_,_,_)).          % en rute mellom to steder (overgang?)
isc(db_reply(_,_,_)).                   % answer from database
isc(dateis(_,_,_,_)).                   % datoen
% isc(daysucc(_,_)).                    % next day %% hva klokka i går 
% isc(diffdep(_,_,_,_,_)).              % tidsdifferanser
isc(diffdep4(_,_,_,_)).                 % tidsdifferanser 
isc(endstation(_,_)).                   % endestasjoner // old %%  /3 -> /3
isc(endstations(_,_)).                  % endestasjoner
isc(false).                             % Answer No 
isc(findprice(_,_,_,_)).                % en bussturpris
isc(message(X)):-                       % En beskjed %% avoid donotknow message 
   informative_message(X).
isc(flag(exit)).                        % RS-150403 Should this be success or fail?
isc(numberof(_,_,_)).                   % antall stasjoner/busser/...
isc(passesstations(_,_,_,_)).           % stasjonene en buss passerer
isc(passevent(_,_,_,_,_,_)).            % en busspassering
isc(departure(_,_,_,_)).                % a departure 
isc(properstation(_)).                  % er en busstasjon
isc(reply(_)). 
isc(replyq(_)).                         %
isc(station(_)).                        % er en stasjon
isc(stationsat(_,_,_)).                 % stasjoner på sted, implicit
isc(stationsnear(_,_,_)).               % stasjoner nært sted
isc(takestime(_,_,_)).                  % lag tidsforbruks liste 
isc(testanswer(_,_)).                   % yes or no test 
isc(ticketprice2(_,_)).                 % en billettpris specific 
isc(timeis(_)).                         % klokka
isc(tramstations(_)).                   % navnet på trikkestasjonene
isc(true).                              % Answer Yes

isc( teleprocess(_,_,_,_) ) :- value( teleflag,true ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Dont pay for noninformative messages %% Policy changed !!! 
%% Avoid don't know/OK  for informative messages


informative_message(answer(_)).   
informative_message(noroutesfor(_)). 
informative_message(howtuchelp).        %% avoid double vetikke
informative_message(mustknow(_)).       %% enough infromation 

%% etc 
                                        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
