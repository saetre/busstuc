/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE pragma.pl
%% SYSTEM BUSTUC
%% AUTHOR J.S.Bratseth
%% CREATED JB-970113
%% REVISED TA-080612

% Tolker for Pragma-regler

:-module( pragma, [ pragma/3, pragma_aux/4, i2oddcond/3, i2oddprescond/3, ip2addto/4, %% i/0, iandrec/0, ip/0,
        ipragmaor/3, ipragmaor0/2, varalarm/1, pragma_complete/5 ] ).        %% RS-140102, ipragmaor0/0, set/2


%%meta_predicates: p0/1, test/1 ?       RS-140208 moved from utility.pl
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- meta_predicate  p0(:)  .  %% RS-140101    Declared in interapp.pl ? or p0(+) ? RS-140208
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:-meta_predicate  test(:).
%test(X):- \+ ( \+ ( X)).        %% Calls test(nostation(Y)) among other things, so: import nostation/1  Move to pragma.pl ?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% set( Flag, Value ) :- user:set( Flag, Value ). %% Called from bustrans -> interapp -> pragma...

%% RS-140101 Denne filen lastes inn i interapp-modulen!
% Predicates: pragma_aux/4, ...

%% Removed / to .. append ../   TA-080612
% pragma(RuleModule,Source,Dest) bygger Dest fra Source vha reglene i RuleModule

%UNIT: /        %UNIT: /utility/
:- ensure_loaded( user:'../declare' ). %% RS-131213 General Operators, Meta_Predicates: test/1
:- use_module( '../utility/utility' ). %%, [ follow_after/3, follow_sequence/3, match/2, out/1, roundappend/3,  roundmember/2,  roundrecmember/2, roundreverse/2, testmember/2 ] ). %% RS-131231 USED! in interapp
:- use_module( '../utility/datecalc' ).%%, [ add_days/3, addtotime/3, before_date1/2, difftime/3, sub_days/3, subfromtime/3, timenow/1, timenow2/2, today/1, todaysdate/1 ] ).
%% Already imported by telelog? % Contains the utility predicates that has to do with dates, call-ed below!

:- use_module( '../interfaceroute' ). %%, [ user:decide_period/2 ]). % Interface procedures for handling interface to route modules

%%% RS-111205, UNIT: /app/
:- use_module( busans, [  tracevalue/1  ]).
:- use_module( busanshp ). %%, [  tracevalue/1  ]).     %% RS-140102 Dangerous to get all?
:- use_module( buslog ). %%, [ airbus_module/1, bus/1, composite_stat/3, dayModSeqNo/2, departure/4, (not)/1, %% RS-140210   
:- use_module( dmeq ). %%, [  dmeq/2  ]). %% RS-140102, Really Used, in several  pragma.pl->interapp->bustrans rules
:- use_module( interapp ). %%, [ newfree/1, prettypr/2  ]).      %% RS-131230, Don't confuse with prettyprint/1 in utility.pl 
%:- use_module( negans, [ trytofool/3 ] ).
%:- ensure_loaded( user:negans ). %%, [ trytofool/3 ].
:- use_module( telelog ). %%, [  bound/1,  unbound/1 ]). %% Do this from tucbuses, before monobuss->compile(pragma!)

%UNIT: /db/
:- use_module( '../db/busdat' ). %% ,[ internal_airbus/1 ].
:- use_module( '../db/places' ). %% ,[ place_resolve/2 ]. % (PLACE,STATION).
:- use_module( '../db/teledat2' ). %%, [ has_att_val/4, teledbtagfile/1 ] ). %% RS-140101 Better get EVERYTHING, since you never know!
:- use_module( '../db/timedat' ). %%, [ morning_break/1 ] ). %% RS-140101 Better get EVERYTHING, since you never know!

%UNIT: /tuc/
:- use_module( '../tuc/facts' ). %%, [ isa/2 ] ).       %% RS-131225  isa/2 IS used by p0(X) :- call(X). %% X == isa/2, etc.
:- use_module( '../tuc/names' ). %%, [  compname/3,  generic_place/1,  samename/2,  streetsyn/1, synname/2,  unwanted_name/1  ] ).
:- use_module( '../tuc/semantic' ). %%, [ ordinal/2 ] ).       %% RS-140210  etc...
%% See: interapp:ieval( FQL ). First? Query Language?   %% RS-140210

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Operatorer for Pragma-regler
% is operator prefixed with rule RuleID

:- op(1150,xfy,rule).  

:- op(1120, fy,is).
:- op(1110,xfy,id).
:- op(1110,xfy,ip).

:- op( 715, fy,context).    %% similar to present, but doesnt mark as seen 
:- op( 715, fy,addfront).   %% (for messages etc) 
:- op( 725, fy,addcon).     %% add if not already present 

:-op( 725,xfy, or ).    %% From ../declare.pl   OPERATORS
:-op( 720,xfy, and ).
:-op( 715, fy, not ).   %% :- op( 715, fy,not).  % Already defined in TUC
:- op( 715, fy,removeall).  %% remove all of a list
:- op( 715, fy,removeif).   %% remove all if any , always succeed 
:- op( 715, fy,replaceall). %% replace iteratively all elements 
:- op( 715, fy,replaceif).  %% replace if occuring. 
:- op( 715, fy,replace).
:- op( 715, fy,replacelast).
:- op( 715,xfy,with).
%%  :- op( 715, fy,to). %% not used, interferes with SWI-Prolog /srel/to/--
%%  :- op( 715,xfy,append).
:- op( 715, fy,no).
:- op( 715, fy,exactly). 
:- op( 715, fy,add).
:- op( 715, fy,remove).
:- op( 715, fy,present).
:- op( 715, fy,assume). 

:- op( 714,xfy,seq).     %% directly sequence 
:- op( 714,xfy,cond).    %% new   not X isa place cond bound(X)
:- op( 714,xfy,when).    %% same as cond %% TA-081106
:- op( 712, fy,seen). % Lower than "not", higher than "isa"



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



pragma(RuleModule,Source,DestOut) :-
   pragma_aux(RuleModule,Source,[],DestOut).

pragma_aux(RuleModule,Source,DestIn,DestOut) :-
	writepragmastep(RuleModule,Source,DestIn),
	itr(RuleModule,Source,NewSource,DestIn,DestMiddle),
   !,                
	pragma_aux(RuleModule,NewSource,DestMiddle,DestOut).

pragma_aux(_,_,Dest,Dest).  % Succeeds and  stops recursion when no more
                            % rules are applicable


%% This allows makes it possible to use the changes in both source and
%% destination - ØF-991005

pragma_complete(RuleModule, SourceIn, SourceOut, DestIn, DestOut) :-
	writepragmastep(RuleModule,SourceIn,DestIn),
	itr(RuleModule,SourceIn,NewSource,DestIn,DestMiddle),
   !,                
	pragma_complete(RuleModule,NewSource,SourceOut ,DestMiddle,DestOut).

pragma_complete(_,Source,Source,Dest,Dest).  

itr(RuleModule,Source,NewSource,Dest,NewDest) :- 
	 RuleModule:(RuleID rule ( is InSource id InDest ip Cond)),
    wait_to_trace(RuleID), 
	 i0(InSource,Source,SourceMiddle),
	 d0(InDest,Dest,DestMiddle), 
	 p0(Cond),     %% RS-140101 existence error in user:mixopt/3 ([to], [from], X), place_station, place_station
	 writefoundrule(RuleID,RuleModule,InSource,InDest,Cond), 
	 flatroundre(DestMiddle,NewDest),
	 flatroundre(SourceMiddle,NewSource),
	 writenewdest(RuleModule,NewDest).

wait_to_trace(RuleID):- 
        tracevalue(L),L >=7,    %%  trans:  bustrans: ??
        !,
        out(RuleID). %% panic

wait_to_trace(RuleID):- 
    user:value(debugrule,RuleID),
    !,
    spy_me(RuleID).
wait_to_trace(_).

spy_me(_).
    


writepragmastep(RuleModule,Source,_DestIn) :-
    RuleModule:tracevalue(L),
    L >= 6, 
    !,   
	 nl,
    write(RuleModule),write('/'), 
    write('Source:------'),nl,
	 write(Source),nl,
    nl.
writepragmastep(_,_,_):-!.


writenewdest(RuleModule,Dest) :-
	 RuleModule:tracevalue(L),
	 L>= 5, 
    !,  
	 prettypr('New destination',Dest),nl, % swapped 1,2 %% Dropped : (N: collision)
    write('-------------------'),nl.
writenewdest(_,_). % Else

writefoundrule(RuleID,RuleModule,InSource,InDest,Cond) :- 
	 RuleModule:tracevalue(L),
	 L>= 3,
	 write(RuleModule),write('/'),write('Found rule:'), 
    write(RuleID),nl, 
    L >=4,
    write(InSource),nl,write(InDest),nl,write(Cond),nl,nl.

writefoundrule(_,_,_,_,_). % Else 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% :- meta_predicate  p0(:)  .  %% RS-140101    (see interapp.pl, bustrans) not needed as long as pragma is in user: ?
p0(X) :- call(X).  %% Just for trace

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% i(Inn,Out,Modifier)  (marks matched with seen )
%%
%% Changed to  i(Modifier,Inn,Out) 


i0(X,     Rinn,Rut) :- i(X,Rinn,Rut).
i0([],    R,R).





i([],       R,R) :-!.   

i((X,A), Rinn,Rut) :- !, %% changed from i0
    i(X,Rinn,Rmellom),   %% NB X may still be composite
    i(A,Rmellom,Rut).   

%%% operator assume 

i(assume  X,Rinn,Rinn)        :- !,call(X). %% General condition inside match

i({X},Rinn,Rinn)    :- !,call(X). %% alternative formulation


%%%

% X or Y both appears, no bindings/change  

% X or Y or ... 

i(X or  Y,Rinn,Rinn)  :-  ipragmaor(X,Y,Rinn).


i(X seq Y,Rinn,Rinn)  
    :- follow_sequence(X,Y,Rinn). %% directly follows



% X and Y both appears in this sequence


i(X and Y,Rinn,Rut) :- 
    iandrec(X and Y,Rinn,Rut).


i(context X,Rinn,Rinn)        :- allroundmember(X,Rinn). 

i(add X,    R,RX)             :- roundappend(R,X,RX).

i(present X,Rinn,Rut)         :- i2is(X,Rinn,Rut).   



i(not present X when { Y },    R,R)  :- varalarm(X), %% NEW, better syntax %% TA-081106
                                 !,
                                 \+ i2oddprescond(X,Y,R). 


i(not X when { Y},    R,R)       :- varalarm(X), %% NEW, better syntax %% TA-081106
                                 !,
                                 \+ i2oddcond(X,Y,R).


i(not X,    R,R)              :- varalarm(X),
                                 !,
                                 \+ i2odd(X,R).


i(replace X with NX,Rinn,Rut) :- ip2rep(X,NX,Rinn,Rut).
i(remove X, Rinn,Rut)         :- ip2rem(X,Rinn,Rut). 
i(removeall X, Rinn,Rut)      :- removeall(X,Rinn,Rut).  %% (iptore/3)

i(exactly X,Rinn,Rut)         :-  !,exactly(X,Rinn,Rut). 

i(replaceall X with Y, Rinn,Rut) :- 
     replaceall(X,Y,Rinn,Rut).


i(clear,_,[]). 

i(X,     Rinn,Rut)            :- i2(X,Rinn,Rut).

ipragmaor(X,Y,Rinn):- 
    test(

     (roundmember(X,Rinn)
      ;
      ipragmaor0(Y,Rinn))
).

ipragmaor0(Y or Z,Rinn):- !,
   ipragmaor(Y,Z,Rinn),
   !.
ipragmaor0(Y ,Rinn):- roundmember(Y,Rinn),!.


iandrec(X and Y and Z,Rinn,Rut):- !, %% slightly haz if   Y,Z,X,Y
    follow_after(X,Y,Rinn),
    iandrec(Y and Z,Rinn,Rut).

iandrec(X and Y ,Rinn,Rinn):- !,
    follow_after(X,Y,Rinn). %% indirectly

                                                         

varalarm(X):-var(X),%% write(alarm),nl,
           !,fail.
varalarm(_).


i2oddprescond(X,Y,Z):- 
    i2odd(present X,Z),
    call(Y),
    !.


i2oddcond(X,Y,Z):- 
    i2odd(X,Z),
    call(Y),
    !.


i2odd(present X,R) :- !,
   (
    roundrecmember(X,R)
 ;   
    roundrecmember(seen X,R)).  

i2odd(X,R):- roundrecmember(X,R).

i2(X,X,seen X).
i2(X,(X,Rest),(seen X,Rest)).
i2(Mod,(X,Rinn),(X,Rut)) :- i2(Mod,Rinn,Rut).


%% present X ... 
i2is(X,   seen X,seen X).
i2is(X,   X, X).  %% NOT  seen X :  present does not mark anything
i2is(X,   (seen X,Rest),(seen X,Rest)).
i2is(X,   (X,Rest),(X,Rest)).  %% NOT  seen X :  present does not mark anything
i2is(Mod, (X,Rinn),(X,Rut)) :- i2is(Mod,Rinn,Rut).


markseen((X,R),(seen X,Rny)) :- !,
    markseen(R,Rny).

markseen(X,seen X).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


d0(X,Rinn,Rut) :- ip(X,Rinn,Rut).

ip((X,A),Rinn,Rut) :- !,
    ip(X,Rinn,Rmellom),
    ip(A,Rmellom,Rut).


ip(assume  X,Rinn,Rinn)  :- !,call(X). %% assume for id %% TA-060617
ip({X},Rinn,Rinn)  :- !,call(X).       %% {X}

ip([],   R,R):-!. 
ip(clear,_,[]):-!. 
ip([],          R,R).
ip(add X,       R, RX)             :- roundappend(R,X,RX). 
ip(addcon X,   Rinn,Rut)           :- ip2addcon(X,Rinn,Rut). 
ip(addfront X,  R,(X,R)).
ip(remove X,    Rinn,Rut)          :- ip2rem(X,Rinn,Rut).
ip(removeif X,    Rinn,Rut)        :- ip2remif(X,Rinn,Rut).  
ip(removeall X,    Rinn,Rut)       :- removeall0(X,Rinn,Rut). %%  Unconditionally

ip(replace X with NX,Rinn,Rut)     :- ip2rep(X,NX,Rinn,Rut).
ip(replaceif X with NX,Rinn,Rut)     :- ip2repif(X,NX,Rinn,Rut).

%% ip(replaceall X with Y, Rinn,Rut) :-  replaceall(X,Y,Rinn,Rut). 

%%%  ip(to X append NX,Rinn,Rut)  :- ip2addto(X,NX,Rinn,Rut). %% TA-080612 NB


ip(replacelast X with NX,Rinn,Rut) :- ip2replast(X,NX,Rinn,Rut).

ip(not X when {Y},       R,R)  :- varalarm(X), %% TA-090316
    !,\+  i2oddcond(X,Y,R).

ip(not X,       R,R)               :- \+  i2odd(X,R).
ip(no X,        Rinn,Rut)          :- ip2none(X,Rinn,Rut).
ip(clear,       _, []).  
ip(exactly Rinn,Rinn,Rinn).
ip(X,           R,R)               :-  i2odd(X,R).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Remove    first if nonempty and present
%  Cuts are hazardous here, because matches are nondeterministic

ip2addcon(X , R,R) :- roundrecmember(X,R),!.  %%  RECURSIVE
ip2addcon(X , Rinn,Rut) :- roundappend(Rinn,X, Rut). 
                                       % added after  to not destroy  addfront 

ip2remif(X,XR,R):-ip2rem(X,XR,R),!. 
ip2remif(_X,R,R).

ip2rem(X, (X,R),R).
ip2rem(Mod,(R,U,V),(R,Rut)) :- ip2rem(Mod,(U,V),Rut). 
ip2rem(Mod,(R,Mod),R). %%  avoid [] if possible
ip2rem(X,  X,[]). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Remove all occurences

removeall0((X,Y),A,B):- !,
    ip2none0(X,A,C),removeall0(Y,C,B). 
removeall0(X,A,B):-ip2none0(X,A,B).


removeall((X,Y),A,B):- !,ip2rem(X,A,C),removeall(Y,C,B).
removeall(X,A,B):-ip2rem(X,A,B).

%% Replaceall  

% The substitute is placed contiguously at the
% location of the first substituend
% However, the matching is strictly in sequence

% replaceall(X,Y,Rinn,Rut). 

replaceall(X,Y,Rinn,Rut):-
    replaceall1(X,Y,Rinn,M),
    flatroundre(M,Rut).    

replaceall1((X1,X2),Y,Rinn,Rut):-
    !,
    ip2rep2(X1,'silly_mark',Rinn,Rinn1), % replace an atom
    removeall(X2,Rinn1,Rinn2),              % replace a sequence
    ip2rep2('silly_mark',Y,Rinn2,Rut).   % replace an atom

replaceall1(X1,Y,Rinn,Rut):-
    !,
    ip2rep2(X1,Y,Rinn,Rut).

%%%%%%%%%%%%%%%

exactly(X,Rinn,Rut):- %% NEW Definition, independent of order
    removeall(X,Rinn,[]),
    markseen(Rinn,Rut).





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Replace

% Multimatching...

ip2repif(X,NX,U,W):- %%  Remove  if any
   ip2rep1(X,NX,U,V),
   !,
   flatroundre(V,W). 
ip2repif(_,_,V,V). 


ip2rep(X,NX,U,W):-
   ip2rep1(X,NX,U,V),
   flatroundre(V,W). 

ip2rep1((X,XR),NX,Rinn,Rut) :- !,
	 ip2repmulti((X,XR),NX,Rinn,Rut).
% Simple matching
ip2rep1(X,NX,Rinn,Rut) :- 
  ip2rep2(X,NX,Rinn,Rut).


ip2rep2(X,NX, (X,R),(NX,R)). %% No !
ip2rep2(A,NA, (R,Rinn),(R,Rut)) :- 
    ip2rep2(A,NA,Rinn,Rut).
ip2rep2(X,NX, X,NX).  %% Last, no !



ip2repmulti((X,RX),NX,(X,R),(NX,RR)) :-  %  ! made nonsense of blank filling etc
    ip2repmultirest(RX,R,RR).

ip2repmulti(A,NA,(R,Rinn),(R,Rut)) :- 
    ip2repmulti(A,NA,Rinn,Rut).
ip2repmulti(X,NX,X,NX). %% Last, no !

ip2repmultirest((X,RX),(X,R),Rut) :- !,
    ip2repmultirest(RX,R,Rut).

ip2repmultirest(X,(X,Rut),Rut).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Addto

% Multimatching...
ip2addto((X,XR),NX,Rinn,Rut) :- 
	 !,                    % Do not try simple matching afterwards
	 ip2addtomulti((X,XR),NX,Rinn,Rut).

% Simple matching
ip2addto(X,NX,Rinn,Rut) :-
  ip2addto2(X,NX,Rinn,Rut).

ip2addto2(X,NX, X,(X,NX)).
ip2addto2(X,NX,(X,R),((X,NX),R)).
ip2addto2(A,NA,(R,Rinn),(R,Rut)) :- ip2addto2(A,NA,Rinn,Rut).

ip2addtomulti(X,NX,X,(X,NX)).

ip2addtomulti((X,RX),NX,(X,R),(X,RX,NX,RR)) :- ip2addtomultirest(RX,R,RR).
ip2addtomulti(A,NA,(R,Rinn),(R,Rut)) :- ip2addtomulti(A,NA,Rinn,Rut).

ip2addtomultirest((X,RX),(X,R),Rut) :- !,ip2addtomultirest(RX,R,Rut).
ip2addtomultirest(X,(X,Rut),Rut).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Replacelast

ip2replast(A,NA,  Rinn,Rut) :-
	 roundreverse(Rinn,Rev),
    ip3replast(A,NA,  Rev,Revut),
    roundreverse(Revut,Rut).

ip3replast(X,NX,  X,NX).
ip3replast(X,NX,  (X,R),(NX,R)).
ip3replast(A,NA,  (R,Rinn),(R,Rut)) :- ip3replast(A,NA,Rinn,Rut).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% None

ip2none(X, Rinn,Rut) :- ip2rem(X, Rinn,Rut),!.
ip2none(_, R,R).


ip2none0(X, Rinn,Rut) :-          %% remove all
    copy_term(X,X1),  
    ip2rem(X1, Rinn,Mid),         %% ONLY IF SUCCESS
    !,
    ip2none0(X, Mid,Rut).

ip2none0(_, R,R).



% Flater ut rund liste og tar bort []
flatroundre((X,Y),Z):-  
    match(X,(U,V)), % X nonvar
    !,
    flatroundre((U,(V,Y)),Z).
flatroundre(([],Y),(Z)):-
    !,
    flatroundre(Y,Z).
flatroundre((X,[]),(Z)):-
    !,
    flatroundre(X,Z).
flatroundre((X,Y),(X,Z)):-
    !,
    flatroundre(Y,Z).
flatroundre(X,X).

% Check if all elements of arg1 are members of R  (round)

allroundmember((X,Y),R):-!, 
    roundmember(X,R),
    allroundmember(Y,R).
allroundmember(X,R):-
    roundmember(X,R).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



