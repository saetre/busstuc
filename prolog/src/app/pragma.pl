/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE pragma.pl
%% SYSTEM BUSTUC
%% AUTHOR J.S.Bratseth
%% CREATED JB-970113
%% REVISED TA-080612

% Tolker for Pragma-regler (e.g. rule/2 from bustrans, or similar files)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Operatorer for Pragma-regler
% is operator is prefixed with "rule RuleID"

%:- op(1150,xfy,rule). Moved to declare.pl  
%

%%% RS-140914, UNIT: /app/
:-module( pragma, [ pragma/3, pragma_aux/3, pragma_complete/5,  flatroundre/2, roundmember/2, ip2addto/4 ] ). % RS-141015  , test_dependencies/0  Needed?

%FIXED META-PREDICATES?!?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- meta_predicate  i0(0,+,-)  . %% RS-140101    Declared in interapp.pl ? RS-140928 Just for trace-output
:- meta_predicate  i(0,+,-)  . %% RS-141018    % Shield what from meta-processing?
:- meta_predicate  i2(0,+,-)  .  %% RS-141005

:- meta_predicate  d0(0,+,-)  . %% RS-140101    Declared in interapp.pl ? RS-140928 Just for trace-output

%:- meta_predicate  ip(0,+,-)  . %% RS-141018    % Shield from meta-processing?

:- meta_predicate  i2oddcond(?,0,?).
:- meta_predicate  i2oddprescond( ?, 0, -). %% RS-141019  Oops, should match i2oddcond!

%:- meta_predicate  ipragmaor( 0, 0, 0).                %% RS-141005    %% Shield from meta-processing?
%:- meta_predicate  ipragmaor0(?,0).

%:- meta_predicate  follow_sequence(0,0,0).             %% RS-141005    %% Shield from meta-processing?
%:- meta_predicate  iandrec(?,0,-).          %% RS-141005
%:- meta_predicate  allroundmember(?,0).          %% RS-141005
%:- meta_predicate  roundmember(?,0) .    %% RS-140615  meta-predicate    LOOP!? %% RS-141018
%:- meta_predicate  roundappend(0,+,?).          %% RS-141005
%:- meta_predicate  i2is(0,?,?).          %% RS-141005

:- meta_predicate  p0(0) .  %% RS-140929    Declared in interapp.pl ? p0(+) p0(0) ? RS-140208 Just for trace-output
% Failed badly... ended up inside pragma instead of for example inside bustrans:rule (e.g. bustrans:today in p0)

:- meta_predicate  test(0).

%:- meta_predicate  pragma(+,0,-).      %RS-141018  Removed: Comes with interapp:[ TQL ] from interapp:ieaval !!!
%:- meta_predicate  pragma_aux(0,+,-).
%:- meta_predicate  itr( 0,-,0,-).
% --- OR ---
%:- meta_predicate  pragma_aux( +, ?, ? ).
%:- meta_predicate  pragma( +, +, - ).
%:- meta_predicate  pragma_complete(+,0,-,0,-).

:- meta_predicate  writepragmastep(+,+,?).

%%Local predicates
%%       i2oddcond/3, %% i/0, iandrec/0, ip/0,
%%       ipragmaor/3, ipragmaor0/2, % occ/2, sequence_member/2, % EXPERIMENT pragma/2, %%RS-141006 
%%       varalarm/1,             %% RS-140102, ipragmaor0/0, set/2

%%        i0/3, d0/3, p0/1        %% RS-141006 . FOR TESTING ?

%% RS-141026    UNIT: /
%:- ensure_loaded( user:'../declare' ).  %% RS-140928 or? and? not? %% Including...
:- use_module( '../declare', [ value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .
:- use_module( '../sicstus4compatibility', [ out/1, output/1, prettypr/2 ] ).  %% Compatible with sicstus4, get0/1 etc.

%:- use_module( '../main.pl', [ value/2 ] ). %MISERY?!
%% UNIT: /
%:- op( 715, fy, assume). %operator in pragma, but looks like assume(predicate) in bustrans... ? meta_predicate setting?


% set( Flag, Value ) :- user:set( Flag, Value ). %% Called from bustrans -> interapp -> pragma...

%% RS-140101 Denne filen lastes inn i interapp-modulen!         % Predicates: pragma_aux/3 (used to be pragma_aux/4, ...)

% pragma( RuleModule, Source, Dest ) bygger Dest fra Source vha reglene i RuleModule    %% Removed / to .. append ../   TA-080612

%% UNIT: /utility/*
%% RS-131213 General Operators, Meta_Predicates: test/1
:- use_module( '../utility/utility', [ match/2, occ/2, roundrecmember/2, roundreverse/2, sequence_member/2 ] ).
        %% RS-131231 bound/1, testmember/2, test/1, unbound/1  is used only in rules:
        %%   in interapp % follow_after/3, follow_sequence/3, roundmember/2,
%:- use_module( '../utility/writeout', [ prettypr/2 ] ).
:- use_module( '../utility/datecalc', [ ] ). % add_days/3, addtotime/3, before_date1/2, difftime/3, isday/1, sub_days/3, subfromtime/3, timenow/1, timenow2/2, today/1, todaysdate/1 ] ).
%% Already imported by telelog? % Contains the utility predicates that has to do with dates, call-ed below!

% :- use_module( '../interfaceroute', [ decide_period/2 ]). % Interface procedures for handling interface to route modules

%%% RS-111205, UNIT: /app/ rule-modules
:- use_module( busans, [  ] ). %% rule/2  w/ correct tracevalue/1 -> traceans
:- use_module( bustrans, [ ] ). % rule/2  w/ correct tracevalue/1 -> traceprog ]).
:- use_module( teletrans, [ ]).        %% RS-140210 , (not)/1   %% RS-141001 Moved to bustrans, tele et al. (rule/2)

%:- use_module( dmeq, [ dmeq/2 ]). %% RS-140102, Really Used, in several  pragma.pl->interapp->bustrans rules
%:- use_module( interapp, [ prettypr/2 ] ). % newfree/1 ]).  % %% RS-131230, Don't confuse with prettyprint/1 in utility.pl 
%:- use_module( interapp, [ prettypr/2 ]).  % %% RS-131230, Don't confuse with prettyprint/1 in utility.pl 
%:- use_module( negans, [ ] ). % trytofool/3 ] ).

%:- use_module( telelog, [  bound/1,  unbound/1 ]). %% Do this from tucbuses, before monobuss->compile(pragma!). %% Moved to utility.pl

%UNIT: /db/
:- use_module( '../db/busdat', [ ] ). % airbusstation/1, bus_dependent_station/3, central_fromstation/1, date_day_map/2, fromstationonly/1, home_town/1, internal_airbus/1, nostationfor/1, vehicletype/2, xforeign/1 ] ).
:- use_module( '../db/places', [ ] ). % place_resolve/2 ] ). % (PLACE,STATION).
:- use_module( '../db/teledat2', [ ] ). % has_att_val/4, teledbtagfile/1 ] ). %% RS-140101 Better get EVERYTHING, since you never know!
:- use_module( '../db/timedat', [ ] ). % morning_break/1 ] ). %% RS-140101 Better get EVERYTHING, since you never know!

%UNIT: /tuc/
:- use_module( '../tuc/facts', [ ] ). % isa/2 ] ).       %% RS-131225  isa/2 IS used by p0(X) :- call(X). %% X == isa/2, etc.
:- use_module( '../tuc/names', [ ] ). %  compname/3,  generic_place/1,  samename/2,  streetsyn/1, synname/2,  unwanted_name/1  ] ).
:- use_module( '../tuc/semantic', [ ] ). % ordinal/2 ] ).       %% RS-140210  etc...
%% See: interapp:ieval( FQL ). First? Query Language?   %% RS-140210

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
test(X):- \+ ( \+ ( X)).        %% Calls test(nostation(Y)) among other things, so: import nostation/1  Move to pragma.pl ?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% FOLLOW DIRECTLY AFTER
follow_sequence( _A, _B, _:V ) :- var( V ),!,fail.
follow_sequence( A, B, _:(A,B) ) :- !.
follow_sequence( A, B, _:(A,B,_) ) :- !.
follow_sequence( A, B, Module:(_X,Y) ) :-
   follow_sequence( A, B, Module:Y ). 

%% FOLLOW SOMEWHERE  AFTER 

follow_after( AA, BB, V ) :-
    ( var(V) ; var(AA) ; var(BB) ),
    !,fail.

follow_after(A,B,(A1,C)):- 
    nonvar(A1),
    A=A1,
    !,
    sequence_member(B,C).

follow_after(A,B,(_X,Y)):- 
   follow_after(A,B,Y).   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

roundmember( X, Y ) :- occ( X, Y ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Pragma RuleModules: bustrans, busans, teletrans, makeframe, ...
pragma( RuleModule, Source, DestOut ) :-
   pragma_aux( RuleModule:Source, [], DestOut ).

pragma( RuleModule, _Source, _DestOut ) :-
   %pragma_aux( RuleModule: Source, [], DestOut ).
        output( 'pragma.pl~140 BAD OR MISSING RULE MODULE: '), output( RuleModule ), nl,fail. %,trace



pragma_aux( RuleModule:Source,  DestIn,  DestOut ) :-
	writepragmastep( RuleModule, Source, DestIn ),
	itr( RuleModule:Source, NewSource, RuleModule:DestIn, DestMiddle ),
   !,                
	pragma_aux( RuleModule:NewSource, DestMiddle, DestOut ).

pragma_aux( _:_ , Dest,Dest ).  % Succeeds and  stops recursion when no more
                            % rules are applicable


%% This makes it possible to use the changes in both source and
%% destination - ØF-991005

pragma_complete( RuleModule, SourceIn, SourceOut, DestIn, DestOut ) :-
	writepragmastep( RuleModule, SourceIn, DestIn ),
	itr( RuleModule:SourceIn, NewSource, RuleModule:DestIn, DestMiddle ),
   !,                
	pragma_complete( RuleModule ,  NewSource, SourceOut ,  DestMiddle, DestOut ).

pragma_complete(_,Source,Source,Dest,Dest).


itr( RuleModule:Source, NewSource, RuleModule:Dest, NewDest ) :-
         RuleModule:( RuleID rule ( is InSource id InDest ip Cond ) ),
    wait_to_trace(RuleModule, RuleID),
         i0( RuleModule:InSource, Source, SourceMiddle ),      %% For *:rule/2 -> is (in source)
         d0( RuleModule:InDest,  Dest,  DestMiddle ),            %% For *:rule/2 -> id (in destination)
         p0( RuleModule:Cond ),     %% RS-140101 existence error in user:mixopt/3 ([to], [from], X), place_station, place_station         %% For *:rule/2 -> ip (in prolog)
         writefoundrule(RuleID,RuleModule,InSource,InDest,Cond), 
         flatroundre(DestMiddle,NewDest),
         flatroundre(SourceMiddle,NewSource),
         writenewdest(RuleModule,NewDest).

    %    d0( InDest,  Dest,  DestMiddle ),            %% For *:rule/2 -> id (in destination)
%itr( bustrans, Source, NewSource, Dest, NewDest ) :-
%         bustrans:( RuleID rule ( is InSource id InDest ip Cond ) ),
%    wait_to_trace(bustrans, RuleID),
%         i0( bustrans:InSource, Source, SourceMiddle ),      %% For *:rule/2 -> is (in source)
%         d0( InDest, Dest, DestMiddle ),            %% For *:rule/2 -> id (in destination)
%         p0( bustrans:Cond ),     %% RS-140101 existence error in user:mixopt/3 ([to], [from], X), place_station, place_station         %% For *:rule/2 -> ip (in prolog)
%         writefoundrule(RuleID,bustrans,InSource,InDest,Cond), 
%         flatroundre(DestMiddle,NewDest),
%         flatroundre(SourceMiddle,NewSource),
%         writenewdest(bustrans,NewDest).

wait_to_trace( RuleModule, RuleID ) :- 
        RuleModule:tracevalue(L),L >=7,    %%  trans:  bustrans: ??
        !,
        out( RuleID ). %% panic

wait_to_trace( _, RuleID ) :-
    value( debugrule, RuleID ),
    !,
    spy_me(RuleID).

wait_to_trace(_, _).

spy_me(_).
    


writepragmastep( RuleModule, Source, _DestIn ) :-
    RuleModule:tracevalue(L),  %% RS-140929
%    value(traceprog,L),    %% RS-140929 Use same trace-level for ALL rule-bases?
    L >= 6, 
    !,   
	 nl,
    write( RuleModule ),write( '/' ),
    write( 'Source:------' ), nl,
	 write( Source ), nl,
    nl.
writepragmastep( _, _, _ ) :- !.


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

%% Just for trace: p0, i0
%From top-of-file :- meta_predicate  p0(0) . % (see interapp.pl, bustrans) not needed as long as pragma is in user: ? %% RS-140927
p0(X) :- call(X).  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% i( Inn, Out, Modifier)  (marks matched with seen )
%%
%% Changed to  i( Modifier, Inn, Out ) 


i0( X,     Rinn, Rut ) :- i( X, Rinn, Rut ).
i0( _:[],    R, R ).

%:- i( [], 'abba', _X).        %% RS-141006    Testing... For any rule-module!

i( _:[],       R,R) :-!.   

i( Module:(X,A), Rinn, Rut ) :- !, %% changed from i0
    i( Module:X, Rinn, Rmellom ),   %% NB X may still be composite
    i( Module:A, Rmellom, Rut).

%%% operator assume 

i( Module: assume  X, Rinn, Rinn )        :- !, call( Module:X ). %% General condition inside match

i( Module: {X}, Rinn, Rinn )    :- !, call( Module:X ). %% alternative formulation


% X or Y both appears, no bindings/change  

% X or Y or ... 

i( _: X or  Y, Rinn, Rinn )  :-  ipragmaor( X, Y, Rinn ).


i( _: X seq Y, Rinn, Rinn )  :- follow_sequence( X, Y, Rinn ). %% directly follows



% X and Y both appears in this sequence


i( _: X and Y, Rinn, Rut ) :-
    iandrec( X and Y, Rinn, Rut ).


i( _: context X, Rinn, Rinn )        :- allroundmember(X,Rinn). 

i( _: add X,    R, RX )              :- roundappend(R,X,RX).

i( _: present X, Rinn, Rut )         :- i2is( X, Rinn, Rut ).



i( RuleModule: not present X when { Y },    R,R)  :- varalarm(X), %% NEW, better syntax %% TA-081106
                                 !,
                                 \+ i2oddprescond( X, RuleModule:Y, R ).


i( RuleModule: not X when { Y},    R,R)       :- varalarm(X), %% NEW, better syntax %% TA-081106  { Executed INSIDE rule-module }
                                 !,
                                 \+ i2oddcond( X, RuleModule:Y, R ).


i( _: not X,    R,R)              :- varalarm( X ),
                                 !,
                                 \+ i2odd(X,R).


i( _: replace X with NX, Rinn, Rut) :- ip2rep( X, NX, Rinn, Rut ).
i( _: remove X, Rinn, Rut )         :- ip2rem( X, Rinn, Rut ). 
i( _: removeall X, Rinn, Rut )      :- removeall( X, Rinn, Rut ).  %% (iptore/3)

i( _: exactly X, Rinn, Rut )         :-  !, exactly( X, Rinn, Rut ).

i( _: replaceall X with Y, Rinn, Rut) :-
     replaceall( X, Y, Rinn, Rut ).


i( _: clear, _, [] ).

i( _:X,     Rinn, Rut )            :- i2( X, Rinn, Rut ).


ipragmaor( X, Y, Rinn ) :-
    test(

      ( roundmember( X, Rinn )
      ;
      ipragmaor0( Y, Rinn ) )
).

ipragmaor0( Y or Z, _:Rinn ):- !,
   ipragmaor( Y, Z, Rinn ),
   !.

ipragmaor0( Y , Rinn ):- roundmember( Y, Rinn ), ! .


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


i2oddcond( X, Y, Z ) :-
    i2odd( X, Z ),
    call( Y ),
    !.


i2odd(present X,R) :- !,
   (
    roundrecmember(X,R)
 ;   
    roundrecmember(seen X,R)).  

i2odd(X,R):- roundrecmember(X,R).

i2( _: X, X, seen X ).
i2( _: X, (X,Rest), (seen X,Rest) ).
i2( Module: Modification, (X,Rinn), (X,Rut) ) :- i2( Module: Modification, Rinn, Rut ).


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


d0( Module:X, Rinn, Rut ) :- ip( Module:X, Rinn, Rut ).

ip( Module:(X,A), Rinn, Rut ) :- !,
    ip( Module:X, Rinn, Rmellom ),
    ip( Module:A, Rmellom, Rut ).


ip(Module: assume  X, Rinn, Rinn )  :- !,call( Module:X ). %% assume for id %% TA-060617
ip(Module:{X},Rinn,Rinn)  :- !,call( Module:X ).       %% {X}

ip( _:[],   R,R) :- !. 
ip( _:clear,_,[]):-!. 
ip( _:[],          R,R).
ip( _:add X,       R, RX)             :- roundappend(R,X,RX). 
ip( _:addcon X,   Rinn,Rut)           :- ip2addcon(X,Rinn,Rut). 
ip( _:addfront X,  R,(X,R)).
ip( _:remove X,    Rinn,Rut)          :- ip2rem(X,Rinn,Rut).
ip( _:removeif X,    Rinn,Rut)        :- ip2remif(X,Rinn,Rut).  
ip( _:removeall X,    Rinn,Rut)       :- removeall0(X,Rinn,Rut). %%  Unconditionally

ip( _:replace X with NX,Rinn,Rut)     :- ip2rep(X,NX,Rinn,Rut).
ip( _:replaceif X with NX,Rinn,Rut)     :- ip2repif(X,NX,Rinn,Rut).

%% ip(replaceall X with Y, Rinn,Rut) :-  replaceall(X,Y,Rinn,Rut). 

%%%  ip(to X append NX,Rinn,Rut)  :- ip2addto(X,NX,Rinn,Rut). %% TA-080612 NB


ip( _:replacelast X with NX,Rinn,Rut) :- ip2replast(X,NX,Rinn,Rut).

ip( RuleModule:not X when {Y},       R,R)  :- varalarm(X), %% TA-090316
    !,\+  i2oddcond(X, RuleModule:Y, R ).

ip( _:not X,       R,R)               :- \+  i2odd(X,R).
ip( _:no X,        Rinn,Rut)          :- ip2none(X,Rinn,Rut).
ip( _:clear,       _, []).  
ip( _:exactly Rinn,Rinn,Rinn).
ip( _:X,           R,R)               :-  i2odd(X,R).



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




roundappend( [], B, B ) :- ! .
roundappend( nil, B, B ) :- !. %% capture var
roundappend( (A,B), C,(A,D) ) :- !,
    roundappend( B, C, D ).
roundappend( Atom, B, (Atom,B) ).

%:- meta_predicate  sequence_append(0,0,-).          %% RS-141005
%sequence_append( A, B, C) :-
%    roundappend( A, B, C).



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


ip2rep2(X,NX, (X,R),(NX,R)). %% No ! (No cut)
ip2rep2(A,NA, (R,Rinn),(R,Rut)) :- 
    ip2rep2(A,NA,Rinn,Rut).
ip2rep2(X,NX, X,NX).  %% Last, no ! (No cut)



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
flatroundre( (X,Y), Z ) :-
    match(X,(U,V)), % X nonvar
    !,
    flatroundre((U,(V,Y)),Z).
flatroundre( ( [], Y ), (Z) ) :-
    !,
    flatroundre(Y,Z).
flatroundre( (X, [] ), (Z) ):-
    !,
    flatroundre(X,Z).
flatroundre( (X, Y), (X, Z) ) :-
    !,
    flatroundre(Y,Z).
flatroundre(X,X).

% Check if all elements of arg1 are members of R  (round)

allroundmember( (X,Y), R ) :- ! ,
    roundmember( X, R ),
    allroundmember( Y, R ).

allroundmember( X, R ) :-
    roundmember( X, R ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



