/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE parseres.pl
%% SYSTEM TELEBUSTER
%% CREATED TLF-030402
%% REVISED TA-070413

%% Printing the result from database query 

%% RS-140914    UNIT: /dialog/
:-module( parseres, [ busanswer_sat/3, get_chars_t/1, ldaptotuc/2, listall/1,listrequirements/1, onelist/1, otherfields/1, parseresultdata/2,
        parseresultdatacount/2, parseresultfile/2, teleanswer_sat/2, teleconstraintlist/1, tuctoldap/2,
        writetelebusteranswer_rep/1, writetelebusteranswer_saf/2, writetelebusteranswer_sqt/3, writetelebusteranswer4/4, writetelebusteranswerfields/1, xwriteanswer/2,
      
        field_is_equal/3, listfields/2, outputrecordlist/1, recordcount/2, removefromlist/3, writevaluelist2/2    %% RS-140914 For dialog
] ).

:- op( 730,xfy, :: ).     %% lambda infix  %% RS-141026 For      tuc/ [ translat gram_x fernando  dcg_x anaphors ], app/interapp, dialog/ [checkitem/2 d_context d_dialogue frames/2 makeframe/2 parseres virtuals relax update2 usesstate2]

:- meta_predicate  listall( + ) .
:- meta_predicate  writeanswer(0).
:- meta_predicate  trackprog(+,0) .

:- use_module( library(varnumbers), [ numbervars/1 ] ). %% RS-140210.

%% RS-141026    UNIT: /
:- use_module( '../main.pl', [ value/2 ] ). %MISERY?!
%% RS-140208. %% UNIT: / and utility/ [ testmember/2, user:value/2  ]).   %% RS-131117 includes declare.pl ?
%:- ensure_loaded( user:'../declare' ).       %% RS-111212 traceprog/2, trackprog/2

:- use_module( '../utility/utility', [ append_atomlist/2, append_atoms/3, for/2, listlength/2, set_ops/3 ] ). % RS-140929 Made local: listall/1, LOOP? set_ops/3
:- use_module( '../utility/writeout', [ doubt/2, out/1, output/1, prettyprint/1 ] ).%% RS-140912

%:-use_module( library(aggregate), [ foral/2 ] ). %% KISS %% RS-140914   %% RS-141029  for-all Does NOT work like utility:for/2

%% RS-140914    UNIT: /app/
:- use_module( '../app/busanshp', [ addrefdialog/2, bcp/1, bcpbc/1, colon/0, comma/0, space/0, writefield1/1, writename/1 ] ).
:- use_module( '../app/interapp', [ prettypr/2 ] ). % traceanswer/1, writeanswer/1 ] ). %% MOVED TO DIALOG  Localized %% RS-141026 because of meta_predicate ordering trouble

%% RS-140914    UNIT: /db/
:- use_module( '../db/teledat2', [ ldaptotucplace/2 ] ).

%% RS-140914    UNIT: /dialog/
%:- use_module( checkitem2, [  ] ). %% MOVED TO DIALOG  Localized: trackprog/2, writeanswer/1 
:- use_module( frames2, [ frame_getvalue_rec/4, frame_setvalue_rec/4 ] ).

%% UNIT: /tagger/
:- use_module( '../tagger/xml', [ xml_parse/2, xml_subterm/2 ] ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%trackprog(X, Y) :- user:trackprog(X, Y).
trackprog( N, P ) :-
    value( traceprog, M ), number(M), M >= N,
    !,
    ( nl, call(P) )    %% TA-110130
        ;
    true. %% Finally, succeed anyway

%% ¤¤¤¤¤¤¤¤¤¤¤¤
%:- meta_predicate  traceanswer(0).
traceanswer( _:Panswer ) :- 
         value(traceans,L),
         L>1,
    !,
         copy_term( Panswer, Pwr ),
         numbervars(Pwr),         % utility.pl?
         prettypr('Application answer program',Pwr),nl. 
traceanswer(_). %% Otherwise
%% ¤¤¤¤¤¤¤¤¤¤¤¤
writeanswer( Panswer ) :- 
    traceanswer( Panswer ),
    Panswer,
    !. 
%% ¤¤¤¤¤¤¤¤¤¤¤¤
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

parseresultfile(File, Results) :-
    getresults(File,Input),
    parseresultdata(Input, Results).

parseresultdata(Input, Results) :-
    xml_parse(Input,XML),
    xml_subterm(XML, element(results,_,Data)),
    !,
    parseresults(Data, Results),
    trackprog(5, outputrecordlist(Results)).

parseresultdatacount(Input,Count) :-
	xml_parse(Input,XML),
	xml_subterm(XML, element(resultcount,_,[pcdata(CData)])),
	number_codes(Count,CData).

parseresults(Data, Results) :-
    parseresults(Data, [], Results).

parseresults([], Results, Results).
parseresults([Tag|Tags], InitRes, Res) :-
    xml_subterm(Tag, element(result, _, Data)),
    parseresult(Data, [], TmpRes),
    append(InitRes, [record(TmpRes)], NewRes),
    parseresults(Tags, NewRes, Res).

parseresult([], Result, Result).
parseresult([Tag|Tags], InitRes, Res) :-
    xml_subterm(Tag, element(ATag, _, [pcdata(Data)])),
    atom_codes(D, Data),
    append(InitRes, [ATag::D], R),
    parseresult(Tags, R, Res).
parseresult([Tag|Tags], InitRes, Res) :-
    xml_subterm(Tag, element(_, _, _)),
    parseresult(Tags, InitRes, Res).    %% keep going if element is empty or of other form


%% separates this in a predicate to be able to change the method later
getresults(File, Input) :-
    see(File),
    get_chars_t(Input),
    (seen).


outputrecordlist([]).
outputrecordlist([record(Data)|Rest]) :-
    write('*****  Record:  *****'),
    nl,
    outputrecorddata(Data),
    outputrecordlist(Rest).

outputrecorddata([]) :-
    write('*********************'), nl.
outputrecorddata([Tag::Value|Rest]) :-
    write(Tag), 
    write(': '),
    write(Value), nl,
    outputrecorddata(Rest).



recordfieldvalue(record(Fields), Field, Value) :-
    !,
    recordfieldvalue(Fields, Field, Value).

recordfieldvalue([record(Fields)|_], Field, Value) :-
    !,
    recordfieldvalue(Fields, Field, Value). 



recordfieldvalue([F::V|_], F, V). %% %% TA-060317 // only first !

%% NB discrepancy between returned fieldname and tuc fieldname
recordfieldvalue([TN::V|_], T, V):- 
   ldaptotuc(TN,T).  

recordfieldvalue([_|Rest], Field, Value) :-
    recordfieldvalue(Rest, Field, Value).


%% recordfieldvalue(_, _, []).  %% field is missing 






recordcount([], 0).
recordcount([record(_)|Rest], Count) :-
    recordcount(Rest, C),
    Count is C + 1.


hent_chars_t(4,I,I).    %% stop on EOT
hent_chars_t(C,I,L) :- at_end_of_stream, append(I,[C],L).
hent_chars_t(C,I,O) :- \+ at_end_of_stream, append(I,[C],L), get_code(T), hent_chars_t(T,L,O).

get_chars_t(L) :-
    get_code(C),
    hent_chars_t(C,[],L).

field_is_equal([Record], Field, Value) :-
    recordfieldvalue(Record, Field, Value).
field_is_equal([Record|Rest], Field, Value) :-
    recordfieldvalue(Record, Field, Value),
    field_is_equal(Rest, Field, Value).


listfields([Record|Rest], Fields) :-
	listfields(Record, Fields),
	nl,
	listfields(Rest, Fields).

listfields(record(Fields), [First|Rest]) :-
	set_ops(Value, recordfieldvalue(record(Fields), First, Value),Values),

	writevaluelist(First,Values),
	nl,
	listfields(record(Fields), Rest).

listfields(record(_), []).

listfields([], _).


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


writevaluelist2([Value],'-') :-
	removebackslashes(Value, Text),
	nl,
	writeroom(Text).

writevaluelist2([First|Rest],Int) :-
	writevaluelist2(Rest,TmpInt),
	nl,
	write(TmpInt),
	append_atomlist([TmpInt, '-'],Int),
   removebackslashes(First, NewText),
	writeroom(NewText).


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


ldap_addrefdialog(Field,Val):-  %% TA-060208 ...
    ldaptotuc_field(Field,Field1),    %% street -> address
    ldaptotuc_value(Field1,Val,Val1), %% 
    !,
    addrefdialog(Field1,Val1). %% succeds always once

ldaptotuc_field(Field,Field1):-  %% TA-060208 ...
     ldaptotuc(Field,Field1),
     !;
     Field=Field1.



ldaptotuc_value(street,Val,Val1):- %% TA-060208 ...
     !,
     convert_tucnf(street,Val,Val1).

ldaptotuc_value(address,Val,Val1):- %% TA-060208 ...
     !,
     convert_tucnf(street,Val,Val1).





ldaptotuc_value(_,Val,Val).




findfieldvalue1(Rec,Field,Val):-  
	recordfieldvalue(Rec, Field, Val).

cleanup_name(ou,Value,Val):- 
    !,
    removebackslashes(Value, Val).

cleanup_name(telephonenumber,Value,Val):- %% 94451 InterNal LDAP -> External 73594451
    atom(Value),        %% TA-070413
    name(Value,LL),
    listlength(LL,5),
    !,
    append_atoms('735',Value,Val).


cleanup_name(_,Val,Val).


convert_tucnf(street,Value,Val):-   %% 'Bragstads Pl 6' -> o_s_bragstas_plass-6 
    ldaptotucplace(Value,Val),      %% teledat2.pl %% Ad Hoc 
    !;
    Value=Val.

convert_tucnf(_,Val,Val).


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


writeroom(Room) :-
	atomreplace(Room,'*',': ',Repl),
	writename(Repl). %%  busanshp.pl


removebackslashes(Text,NewText) :-
	atom_chars(Text, AL),
	removefromlist(AL, 92, NAL), %% \
	removefromlist(NAL, 34, NALL), %% "   %% TA-051223
	atom_chars(NewText, NALL).

removefromlist([Remove|Rest], Remove, NewList) :-
	!, 
   removefromlist(Rest, Remove, NewList).

removefromlist([First|Rest], Remove, [First|RestMod]) :-
	removefromlist(Rest, Remove, RestMod).

removefromlist([],_,[]).


onelist([_]). %% redundant 

%% Search and replace in atoms
atomreplace(Haystack, Needle, ReplaceWith, Result) :-
	atom_codes(Haystack, H),
	atom_codes(Needle, N),
	atom_codes(ReplaceWith, RW),
	atomlistreplace(H,N,RW,R),
	atom_codes(Result, R).


atomlistreplace([], _N, _NN, []):-!.

atomlistreplace(H, [], _, H):-!. 

atomlistreplace([HF|HR], [HF|NR], RW, R) :-
	!, 
   atomlistreplace1(HR, NR, HRR),
	atomlistreplace(HRR,[HF|NR], RW, R1),
	append(RW, R1, R).

atomlistreplace([HF|HR], N, RW, R) :-
	atomlistreplace(HR, N, RW, R1),
	append([HF], R1, R).

atomlistreplace1([H1|HR],[H1|NR], HRR) :-
	atomlistreplace1(HR, NR,  HRR).

atomlistreplace1(H, [], H).


%% QUIT %% TA-070419
xwriteanswer(Fql,AnswerOut):-
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


writetelebusteranswer_rep(Frame) :- %% TA-060224
    writetelebusteranswer1(Frame).

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

teleanswer_sat(TQL,Frame) :-  %% TA-060224
    value(directflag,true),
    !,
%%    value(directoutputfile,Newans), %% TA-060825
%%    tell(Newans), %% ALREADY OPEN BY PARAPHRASE2

        nl,
        output('*** TQL  ***'),nl,
        prettyprint(TQL), nl,
        output('*** Answer ***'),nl,
        writetelebusteranswer1(Frame),
    true.  %% TA-060127 Keep Open

teleanswer_sat(_,Frame) :-
    writetelebusteranswer1(Frame). 


busanswer_sat(TQL,AnswerOut,_Frame) :-  %% TA-060224
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
       
        writetelebusteranswer1(Frame),

    true.  %% TA-060127 %% Keep open


writetelebusteranswer_saf(_,_Frame) :- %% TA-060420
    !. %% writetelebusteranswer1(_Frame). 



%:-meta_predicate listall( + ) .
listall( P ) :- for( P, output(P) ).  %% RS-141015 Always succeed even when no output?


%%

writetelebusteranswer1(Frame) :-
    frame_getvalue_rec(Frame, return, [count|_], _),!,
    !,
    frame_getvalue_rec(Frame, itemsfound::itemcount, C, _),
    bcpbc(numrecords(C)),
    colon,nl. %%%  period.

writetelebusteranswer1(Frame) :- 
    frame_getvalue_rec(Frame, return, [], _),
    !, 
    output('Fant ingen felt å finne verdien til.'),nl.  %% doubt


writetelebusteranswer1(Frame) :-		%% return not set,show standard (Marvin):
    value(telebusterflag,true),     %% Telebuster,  address is important
    \+ frame_getvalue_rec(Frame, return, _A,_B), %% TA-0605116

    frame_setvalue_rec(Frame,return,[roomnumber,address],Frame1),
    !,

    listall(Frame1). %% avdeling til odd pettersen
%%     writetelebusteranswerfields(Frame1). 



writetelebusteranswer1(Frame) :-		%% return not set,show standard (Marvin):
    value(teleflag,true),        %% DAter, telephone is important
    \+ frame_getvalue_rec(Frame, return,_A,_), %% TA-0605116
    !,
    frame_setvalue_rec(Frame,return,[telephonenumber],Frame1),


    listall(Frame1).

%%    writetelebusteranswerfields(Frame1). %% TA-060302


writetelebusteranswer1(Frame) :-		%% 
    value(teleflag,true),      
    frame_getvalue_rec(Frame, return,_A,_), 
    !,
    listall(Frame).



writetelebusteranswer1(Frame) :-		%% return not set, show a nice list of properties
    listall(Frame).                


writetelebusteranswerfields(Frame) :- %% TA-060306
    frame_getvalue_rec(Frame, return, RList, _),
    !, 
    frame_getvalue_rec(Frame, itemsfound::items, Recs, _),

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




%%%%%%%%%

writefieldverb([ou]) :-	%% ad hoc
   bcp(ison).

writefieldverb(ou) :-
	bcp(ison).

writefieldverb(_) :-
    bcp(has).

%%%%%%%%%%%%%%%%%%


%listall(Frame) :-
%
%   frame_getvalue_rec(Frame, return, [Field|Rest], _),!,
%	frame_getvalue_rec(Frame, itemsfound::items, Recs, _),
%
%   for(member(Rec,Recs),                %% TA-060614
%       tahasattval(Rec, [Field|Rest])). %% Speakable
%%% 	listfields(Recs, [cn,Field]).
%
%listall(Frame) :-
%	frame_getvalue_rec(Frame, itemsfound::items, Recs, _),
%
%   for(member(Rec,Recs),
%       tahasattval(Rec, [department,telephone])). %% Speakable
%
%%%	listfields(Recs, [cn,department,telephone]).
%
%
%
%%%%%	listfields(Recs, [cn,title,telephonenumber,mail,ou,roomnumber,street]).

listrequirements(Frame) :-
	set_ops(Field=Val,frame_getvalue_rec(Frame, attributes::Field,Val,_),List),

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
	bcpbc(field(Field)),colon,write(Value),nl,
	listreq2(Rest).

listreq2([]).

%%%%%%%%%%%%%%%%%%%%%%%%



%%% NB  VERY IMPORTANT CONVERSION %%%

ldaptotuc(place,          place). %% HVOR er ambles kontor %% TA-060906
ldaptotuc(ou,place).  %% Ad Hoc %% TA-060906

ldaptotuc(givenname,      firstname).
ldaptotuc(name,           name).       %% ? %% TA-060207
ldaptotuc(ou,             department).
ldaptotuc(title,          title).
ldaptotuc(sn,             lastname).

ldaptotuc(telephonenumber,telephone).
ldaptotuc(roomnumber,     room).       %% TA-060419
ldaptotuc(roomnumber,     roomnumber).
ldaptotuc(roomnumber,     office).   

ldaptotuc(mail,           mailaddress). %% TA-051031
ldaptotuc(cn,             pname).
ldaptotuc(department,     department).

ldaptotuc(cn,           name).         %% TA-051109
ldaptotuc(street,         address).    %% TA-051101
ldaptotuc(telephonenumber,number).     %% TA-051115


% --

tuctoldap(room, place). %% HVOR er ambles kontor %% TA-060906

tuctoldap( firstname,givenname     ).
tuctoldap(  name,name         ).       %% ? %% TA-060207
tuctoldap(  department,ou           ). %% TA-051101
tuctoldap(  title,title        ).
tuctoldap( lastname,sn            ).

tuctoldap(telephone, telephonenumber).
tuctoldap( room,roomnumber    ).       %% TA-060419
tuctoldap(  roomnumber,roomnumber   ).
tuctoldap(  office,roomnumber   ).      %% TA-051114

tuctoldap( mailaddress,mail          ). %% TA-051031
tuctoldap(  pname,cn           ).
tuctoldap( department,department    ).

tuctoldap(  name,cn         ).         %% TA-051109
tuctoldap(  address,street     ).    %% TA-051101
tuctoldap(number,telephonenumber).     %% TA-051115


% List of fields allowed to ask for


%% Otherfields fields  will be listed first, followed by teleconstraintlist  fields

otherfields([address,mailaddress,name,number,office,place, room, %% TA-060419
             tel,telephone,title,
             department]). %% TA-061211

teleconstraintlist([title,mail,roomnumber,telephone,department,pname,firstname,lastname]).


%% This option is arbitrary, and so far unused !

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

