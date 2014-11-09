/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE readin.pl
%% SYSTEM TUC
%% CREATED  TA-910531   %% REVISED  TA-110725
%% REVISED  RS-140101 modularized

%%%% OUTPUT     %% RS-140921 To split utility.pl into managable modules

:-module( writeout, [ colon/0, comma/0, dot/0, period/0, period0/0, space/0,  endline/0,  punkt/0,  question/0,  space0/0,
                      busanswer_sat/3, 
                      doubt/2, indentprint/2,
                      listall/1, listrequirements/1,
                      out/1, output/1, prettyprint/1, roundwrite/1, prettypr/2, print_parse_tree/1, printdots/0,
                      sequence_write/1, statistics/1, teleanswer_sat/2, traceanswer/1, traceprint/2, track/2, trackprog/2,
                      waves/0, writeanswer/1, writefields/1, writename/1, writepred/1, writeprog/1,
                      writetelebusteranswer_rep/1, writetelebusteranswer_saf/2, writetelebusteranswer_sqt/3, writetelebusteranswer4/4, writetelebusteranswerfields/1,
                      writevaluelist/2, xwriteanswer/2 ] ). %% RS-141105 Moved to main?: language/1,

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% META_PREDICATES SECTION, %% RS-140927 meta_predicates    : means use source module       + means use this (utility) module  for expansion %% RS-131231 %From utility.pl
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- meta_predicate  busanswer_sat( ?, 0, ? ) . %% RS-141105
:- meta_predicate listall( 0 ) .
%:-meta_predicate  output( + ) .   %% RS-100101 ?  %% NEW PREDICATE
%:-meta_predicate  output( 0 ) .   %% RS-140928 ?  %% NOT META PREDICATE: write/1
:- meta_predicate  teleanswer_sat( +, 0 ) .
:- meta_predicate  track( +, 0 ) .
:- meta_predicate  traceanswer( 0 ) .
:- meta_predicate  trackprog( +, 0 ) .
:- meta_predicate  writetelebusteranswer1( 0 ) .
:- meta_predicate  writetelebusteranswer_rep( 0 ) .
:- meta_predicate  writetelebusteranswer_saf( ?, 0 ) .
:-meta_predicate  writeanswer( 0 ) .
:- meta_predicate  xwriteanswer( ?, 0 ) .

%:- ensure_loaded( user:'../declare' ).  %% RS-140102 (:=)/2, user:value/2
:- use_module( '../declare', [ value/2 ] ). %% RS-141105  General (semantic) Operators, %helpers := /2, =: /2, set/2, value/2.  set( X, Y ) is X := Y .
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- use_module( library(varnumbers), [ numbervars/1 ] ). %% RS-140210.

%% RS-131225, UNIT: /utility/
:- use_module( ptbwrite, [ ptbwrite/1, shrink_tree/2 ] ). %% drucke_baum_list/1, drucke_baum/1,

:- use_module( utility, [ for/2, set_ops/3 ] ). %% drucke_baum_list/1, drucke_baum/1, append_atomlist/2,   TROUBLE RS-141105

%% RS-141026    UNIT: /
:- use_module( '../main.pl', [ language/1 ] ). %MISERY?!
:- use_module( '../sicstus4compatibility', [ tab/1 ] ).  %% Compatible with sicstus4, get0/1 etc.

%%% RS-140914, UNIT: /app/
:- use_module( '../app/busanshp', [ bcp/1, bcpbc/1, bwrbc/1 ] ). % , colon/0, space/0 

%%% RS-140914, UNIT: /db/
:- use_module( '../db/places', [ specname/2 ] ).

%% RS-141026    UNIT: /dialog/
:- use_module( '../dialog/frames2', [ frame_getvalue_rec/4, frame_setvalue_rec/4 ] ). %MISERY?!
:- use_module( '../dialog/parseres', [ atomreplace/4, cleanup_name/3, findfieldvalue1/3, convert_tucnf/3, ldap_addrefdialog/2, ldaptotuc/2,
                                       removebackslashes/2, recordfieldvalue/3 ] ). %MISERY?!

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
out(P) :- write(P), tab(1).
output(P) :- write(P), nl.
%language(L) :- value( language, L ). %% value(language,X) should have been set dynamically by now! In tucbuses
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

colon    :- write( ': ' ).
comma    :- write( ', ' ).
dot      :- write( '.' ).  %% No Space
endline.                       %% marker, nl
period0  :- write( '.' ).
period   :- write( '.' ),nl.
punkt    :- write( '. ' ). %%  Space
question :- write( '?' ),nl.
space    :- write( ' ' ).
space0.                 %% nothing


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

doubt(A,B) :-
    language( english ) -> out( A );
    language( norsk ) -> out( B );
    out(A).

%numbervars(F) :-
%    numbervars( F, 0, _ ).

prettyprint( P ) :-
    numbervars( P ),
    writeq( P ),nl,
    false; % release bindings
    true.

print_parse_tree(Parse1):- %% TA-110207
   value(norsource,true),
   !,
   shrink_tree(Parse1,Pa1),

   output('<tree> '),   prettyprint(Pa1),  output('</tree>'),nl.

   
print_parse_tree(Parse1):- %% TA-110207
   track(4, printparse(Parse1) ), %%  print proper parsetree
   track(2, writeout:output('*** Simplified parse tree ***') ),
   track(1, ptbwrite:ptbwrite(Parse1) ), %% -> ptbwrite.pl
   track(2, (writeout:output('*****************************'),nl) ).

printparse(X) :- 
    write('*** Parse Tree ***'),nl,nl,
    indentprint(0,X),nl,
    write('******************'),nl,nl.

indentprint(N,Y):-
     var(Y),
     !,
     tab(N),write(Y),nl.
    
indentprint(N,[H|T]):-
    !,
    tab(N),write(H),nl,
    M is N+2, 
    for( member(X,T), indentprint(M,X) ).

indentprint(N,Y):-
     tab(N),write(Y),nl.


%listall(Frame) :-
%
%   frame_getvalue_rec(Frame, return, [Field|Rest], _),!,
%       frame_getvalue_rec(Frame, itemsfound::items, Recs, _),
%
%   for(member(Rec,Recs),                %% TA-060614
%       tahasattval(Rec, [Field|Rest])). %% Speakable
%%%     listfields(Recs, [cn,Field]).
%
%listall(Frame) :-
%       frame_getvalue_rec(Frame, itemsfound::items, Recs, _),
%
%   for(member(Rec,Recs),
%       tahasattval(Rec, [department,telephone])). %% Speakable
%
%%%     listfields(Recs, [cn,department,telephone]).
%
%
%
%%%%%   listfields(Recs, [cn,title,telephonenumber,mail,ou,roomnumber,street]).

listrequirements( Frame ) :-
        set_ops( Field=Val, frame_getvalue_rec( Frame, attributes::Field,Val,_), List ),

        listrequirements2(List).



listrequirements2([_Field=dontknow|Rest]) :-
        listrequirements2(Rest).

listrequirements2([_Field=doknow|Rest]) :-
        listrequirements2(Rest).

listrequirements2([Field=Value|Rest]) :-
    value(traceprog,N), N >=2,
    !,
    listreq2([Field=Value|Rest]).

listrequirements2(_). 


listreq2([Field=Value|Rest]) :-
   !,
        bcpbc( field(Field) ), colon, write(Value),nl,
        listreq2(Rest).

listreq2([]).

%%%%%%%%%%%%%%%%%%%%%%%%


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


printdots :-  %% TA-110204
    dotline(DOTS),
    traceprint(1,DOTS).

dotline(''):-value(smsflag,true),!.
dotline('........................................................................').
   


roundwrite( nil ) :-!. %% catches var
roundwrite( (X,Y) ) :-!, out(X),roundwrite(Y).
roundwrite( X ) :- !, out(X).

sequence_write(X) :- roundwrite(X). %% New name, more standard

statistics(G) :- 
               statistics(G,K),
               output(K).

traceprint(N,P):- %% same as trace
    value(trace,M), number(M), M >= N, 
    !,
    write(P),nl
;
    true.

%///
track( N, P ) :- 
    value( trace, M ),  number(M), M >= N, 
    !,
    call(P)   %% TA-110130
;
    true.

%///
trackprog( N, P ) :-
    value( traceprog, M ), number(M), M >= N,
    !,
    ( nl, call(P) )    %% TA-110130
        ;
    true. %% Finally, succeed anyway

%///


%% ¤¤¤¤¤¤¤¤¤¤¤¤
traceanswer( _:Panswer ) :- 
         value(traceans,L),
         L>1,
    !,
         copy_term( Panswer, Pwr ),
         numbervars(Pwr),         % utility.pl?
         prettypr('Application answer program',Pwr),nl. 

traceanswer( _ ). %% Always Succeeds (Otherwise)


writeanswer( Panswer ) :- 
    traceanswer( Panswer ),
    Panswer,
    !. 

%% sant

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

%% ¤¤¤¤¤¤¤¤¤¤¤¤


writepred(P) :- writeq(P),write('.'),nl. 








writefieldvalues(_Rec, []) :- !,nl. %% 0 

writefieldvalues([record(Rec)],List) :-  %% TA-060324   
    !,
    writefieldvalues(Rec,List).

writefieldvalues(Rec,List) :-       %% >0 
    writefieldvalues2(Rec,List),
    !,  
    write('.').


%% writefieldvalues2   

writefieldvalues2(_Rec, []) :- !,nl. %% 0

writefieldvalues2(Rec,[R]) :-  %% 1
    !,
    writefieldvalue2(Rec, R). 

writefieldvalues2(Rec,[R,S]) :-  %% 2
    !,
    writefieldvalue2(Rec, R),
    !, 
    bcp(and),
    writefieldvalue2(Rec, S).

writefieldvalues2(Rec,[R,S|T]) :-  %% > 2
    writefieldvalue2(Rec, R),
    !, 
    write(', '),
    writefieldvalues2(Rec,[S|T]).


%% writefieldvalue2

writefieldvalue2([record(R)],L):- 
    !,
    writefieldvalue2(R,L).

writefieldvalue2(record(R),L):- 
    !,
    writefieldvalue2(R,L).

writefieldvalue2(Rec, R):- 
   writefieldvalue1(Rec, R).


%% dialog/parseres ???

writefields(F):- var(F),!,write('¤ variable ¤').


writefields([F]):-   % telf
   !,
   writefield1(F).

writefields([F,G]):-  % telf og email
   !,
   writefield1(F),
   bcp(and),write(' '),
   writefield1(G).

writefields([F,G|H]):- % telf, email and room
   writefield1(F),
   !,
   write(', '),
   writefields([G|H]).

writefields([]):-!.

writefields(_):- write(' ??? '). %% catchall

writefield1(unknown):-
    !,
    bcp(unknownfield).

writefield1(F):-
    ldaptotuc(F,G),!,
    bcp(G),write(' '),!.

writefield1(F):- bcp(F),write(' '),!. %% bcp(field(F))

writefield1(_):- write(' ??? '). %% catchall

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




writefieldvalue1(Rec,Field):- %% finds value, addref
    findfieldvalue1(Rec,Field,Val),
    !,
    writefield1(Field), 
    write(' '),
    
    cleanup_name(Field,Val,Val0),

    out(Val0), %% TA-070611

    convert_tucnf(Field,Val0,Val1), 
    
    !,
 
    ldap_addrefdialog(Field,Val1).
 
writefieldvalue1(_Rec,Field):- %% field not present %% TA-070112 ad hoc
    writefield1(Field),   
    doubt('unknown', ukjent).



writefieldvalue(Rec, roomnumber) :- %% adds street to the output
        recordfieldvalue(Rec, roomnumber, Room),
        recordfieldvalue(Rec, street, Street),
        !,  
   writeroom(Room), comma, space,
        write(Street).

writefieldvalue(Rec, ou) :-
        set_ops(Value, recordfieldvalue(Rec, ou, Value),Values),

   writevaluelist(_,Values).  %% RS-140914, where is writevaluelist/1 gone ?! 


writefieldvalue(Rec, Field) :-
        recordfieldvalue(Rec, Field, Value),
        removebackslashes(Value, Text),
        out(Text).    %% ****  Tore Amblehar



writename(TA):- var(TA),!,write('???').

writename(TA) :-
    specname(TA,TTAA),
    !,
    roundwrite(TTAA).   % utility.pl

writename((F,G)):-!,
    writename(F),
    roundwrite(G).

writename(TA):-bwrbc(TA).



writeroom(Room) :-
        atomreplace(Room,'*',': ',Repl),
        writename(Repl). %%  busanshp.pl


writevaluelist(Field,ValList) :-
        bcpbc(field(Field)),colon,
   wrfs(ValList).


wrfs([]):-!,write([]).

wrfs([X]) :- !,wrf1(X).


wrfs([Val|List]):-
    wrf1(Val), 
    for(member(X, List), (write(', '),wrf1(X))).


wrf1(X):-
       removebackslashes(X, NewText),
       writeroom(NewText).


%writevaluelist2([Value],'-') :-
%        removebackslashes(Value, Text),
%        nl,
%        writeroom(Text).
%
%writevaluelist2([First|Rest],Int) :-
%        writevaluelist2(Rest,TmpInt),
%        nl,
%        write(TmpInt),
%        append_atomlist([TmpInt, '-'],Int),
%   removebackslashes(First, NewText),
%        writeroom(NewText).





%% QUIT %% TA-070419
xwriteanswer( Fql, AnswerOut ) :-
    value(directflag,true),
    !,
    value(directoutputfile,Newans), 
    tell(Newans), 
       nl,

        output('*** TQL  ***'),nl,
        output(Fql),nl,

        output('*** Answer ***'),nl,
        output(' '),nl,

        call(AnswerOut),nl,

     told.


xwriteanswer(_Fql,AnswerOut):- %% TA-070608
   writeanswer( AnswerOut ).


%% WRITE TELEBUSTER ANSWER ...

writetelebusteranswer4(sant,TQL,_AnswerOut,_Frame):-%% TA-060905 
    value(directflag,true),
    !,
    nl,
    output('*** TQL  ***'),nl,
    prettyprint(TQL), nl,
    output('*** Answer ***'),nl,
    output(' '),nl.   %% no answer 

writetelebusteranswer4(sant,_Tql,_AnswerOut,_Frame). %% TA-060905 


writetelebusteranswer_rep( Frame ) :- %% TA-060224
    writetelebusteranswer1( Frame ).

%% sqt

writetelebusteranswer_sqt(TQL,_AnswerOut,_Frame) :-   %% TA-060224
    value(directflag,true),
    !,
%%     value(directoutputfile,Newans), %% TA-060825
%%     tell(Newans), %% ALREADY OPEN BY PARAPHRASE2

        nl,
        output('*** TQL  ***'),nl,
        prettyprint(TQL), nl,

        output('*** Answer ***'),nl,
        output(' '),nl.   %% no answer 
%%        writeanswer(AnswerOut),nl.  %% TA-060825  


writetelebusteranswer_sqt(_TQL,_,_Frame) :-  %% TA-060825  
   true.


%% sat

teleanswer_sat( TQL, Frame ) :-  %% TA-060224
    value(directflag,true),
    !,
%%    value(directoutputfile,Newans), %% TA-060825
%%    tell(Newans), %% ALREADY OPEN BY PARAPHRASE2

        nl,
        output('*** TQL  ***'),nl,
        prettyprint(TQL), nl,
        output('*** Answer ***'),nl,
        writetelebusteranswer1( Frame ),
    true.  %% TA-060127 Keep Open

teleanswer_sat(_,Frame) :-
    writetelebusteranswer1(Frame). 


busanswer_sat( TQL, AnswerOut, _Frame ) :-  %% TA-060224
    value(directflag,true),
    !,
%%    value(directoutputfile,Newans), %% TA-060825
%%     tell(Newans), %% Already open by PARAPHRASE2

        output('*** TQL  ***'),nl,
        prettyprint(TQL), nl,
        output('*** Answer ***'),nl,
        writeanswer(AnswerOut), %% TA-060428
    true.  %% TA-060127 Keep Open


busanswer_sat(_Tql,AnswerOut,_Frame):-  %% TA-060428
    writeanswer(AnswerOut).











writetelebusteranswer_saf(TQL,Frame) :-  %% TA-060420
    value(directflag,true),
    !,
%%  value(directoutputfile,Newans),  %% TA-060825
%%     tell(Newans),  %% Already OPEN by paraphrase2

        output('*** TQL  ***'),nl,
        prettyprint(TQL), nl,
       
        output('*** Answer ***'),nl,
       
        writetelebusteranswer1( Frame ),

    true.  %% TA-060127 %% Keep open


writetelebusteranswer_saf(_,_Frame) :- %% TA-060420
    !. %% writetelebusteranswer1(_Frame). 



listall( Module:P ) :- for( Module:P, output(Module:P) ).  %% RS-141015 Always succeed even when no output?


%%

writetelebusteranswer1( Module:Frame ) :-
    frame_getvalue_rec( Module:Frame, return, [count|_], _ ),!,
    !,
    frame_getvalue_rec( Module:Frame, itemsfound::itemcount, C, _),
    bcpbc(numrecords(C)),
    colon,nl. %%%  period.

writetelebusteranswer1( Module:Frame ) :- 
    frame_getvalue_rec( Module:Frame, return, [], _),
    !, 
    output('Fant ingen felt å finne verdien til.'),nl.  %% doubt


writetelebusteranswer1( Module:Frame ) :-                %% return not set,show standard (Marvin):
    value(telebusterflag,true),     %% Telebuster,  address is important
    \+ frame_getvalue_rec( Module:Frame, return, _A,_B ), %% TA-0605116

    frame_setvalue_rec( Module:Frame, return,[roomnumber,address], Frame1 ),
    !,

    listall( Frame1 ). %% avdeling til odd pettersen
%%     writetelebusteranswerfields(Frame1). 



writetelebusteranswer1( Module:Frame) :-                %% return not set,show standard (Marvin):
    value(teleflag,true),        %% DAter, telephone is important
    \+ frame_getvalue_rec( Module:Frame, return,_A,_), %% TA-0605116
    !,
    frame_setvalue_rec( Module:Frame,return,[telephonenumber],Frame1),


    listall(Frame1).

%%    writetelebusteranswerfields(Frame1). %% TA-060302


writetelebusteranswer1( Module:Frame ) :-                %% 
    value(teleflag,true),      
    frame_getvalue_rec( Module:Frame, return,_A,_),
    !,
    listall( Module:Frame ).



writetelebusteranswer1(Frame) :-                %% return not set, show a nice list of properties
    listall(Frame).                


writetelebusteranswerfields( Module:Frame) :- %% TA-060306
    frame_getvalue_rec( Module:Frame, return, RList, _),
    !, 
    frame_getvalue_rec( Module:Frame, itemsfound::items, Recs, _),

%% torea amble has phone 94451

   tahasattval(Recs,RList).

writetelebusteranswerfields(Frame) :- %% TA-060306

     output(Frame). %%%%%%%% Panic Dump %%%%%%

tahasattval(I,RList):-   

    writefieldvalue(I,cn),
    writefieldverb(RList),
    !, 
    writefieldvalues(I,RList),
    nl.



waves :-  value(norsource,true), %% TA-110207
    !.

waves :-  value(traceprog,0), %% TA-110207
          !.

waves :-  value(dialog,1),
          !.

waves :-        
         write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'), % 77 chars
         write('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),nl.


%%%%%%%%%

writefieldverb([ou]) :- %% ad hoc
   bcp(ison).

writefieldverb(ou) :-
        bcp(ison).

writefieldverb(_) :-
    bcp(has).

%%%%%%%%%%%%%%%%%%


