/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE parseres.pl
%% SYSTEM TELEBUSTER
%% CREATED TLF-030402
%% REVISED TA-070413

%% Printing the result from database query 

%% RS-140914    UNIT: /dialog/
:-module( parseres, [ atomreplace/4, cleanup_name/3, convert_tucnf/3, field_is_equal/3, findfieldvalue1/3, get_chars_t/1,
                      ldap_addrefdialog/2,  listfields/2,  ldaptotuc/2,
                      onelist/1, otherfields/1, outputrecordlist/1,
                      parseresultdata/2, % ldaptotuc/2, listrequirements/1, 
                      parseresultdatacount/2, parseresultfile/2,
                      recordcount/2, removefromlist/3,    %% RS-140914 For dialog , writevaluelist2/2
                      removebackslashes/2, recordfieldvalue/3, 
                      teleconstraintlist/1, tuctoldap/2
] ).


:- op( 730,xfy, :: ).     %% lambda infix  %% RS-141026 For      tuc/ [ translat gram_x fernando  dcg_x anaphors ], app/interapp, dialog/ [checkitem/2 d_context d_dialogue frames/2 makeframe/2 parseres virtuals relax update2 usesstate2]


%:- use_module( library(varnumbers), [ numbervars/1 ] ). %% RS-140210.

%% RS-141026    UNIT: /
%:- ensure_loaded( user:'../declare' ).       %% RS-111212 traceprog/2, trackprog/2 %:- meta_predicate  trackprog(+,0) .
:- use_module( '../declare', [ trackprog/2 ] ).       %% RS-150111 trackprog/2 %:- meta_predicate  trackprog(+,0) .
%:- use_module( '../main.pl', [ value/2 ] ). %MISERY?!
%% RS-140208. %% UNIT: / and utility/ [ testmember/2, user:value/2  ]).   %% RS-131117 includes declare.pl ?

:- use_module( '../utility/utility', [  append_atoms/3, listlength/2, set_ops/3 ] ). % RS-140929 Made local: listall/1, LOOP? set_ops/3 append_atomlist/2, for/2,  
:- use_module( '../utility/writeout', [ writevaluelist/2 ] ).%% RS-140912 %% RS-141105 busanswer_sat/3, doubt/2, out/1, output/1, prettyprint/1, trackprog/2,

%:-use_module( library(aggregate), [ foral/2 ] ). %% KISS %% RS-140914   %% RS-141029  for-all Does NOT work like utility:for/2

%% RS-140914    UNIT: /app/
:- use_module( '../app/busanshp', [ addrefdialog/2 ] ). %bcp/1, bcpbc/1, colon/0, comma/0, space/0, writefield1/1, writename/1
%:- use_module( '../app/interapp', [ prettypr/2 ] ). % traceanswer/1, writeanswer/1 ] ). %% MOVED TO DIALOG  Localized %% RS-141026 because of meta_predicate ordering trouble

%% RS-140914    UNIT: /db/
:- use_module( '../db/teledat2', [ ldaptotucplace/2 ] ).

%% RS-140914    UNIT: /dialog/
%:- use_module( checkitem2, [  ] ). %% MOVED TO DIALOG  Localized: trackprog/2, writeanswer/1 
%:- use_module( frames2, [ frame_getvalue_rec/4, frame_setvalue_rec/4 ] ).

%% UNIT: /tagger/
:- use_module( '../tagger/xml', [ xml_parse/2, xml_subterm/2 ] ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%trackprog(X, Y) :- user:trackprog(X, Y).
%trackprog( N, P ) :-
%    value( traceprog, M ), number(M), M >= N,
%    !,
%    ( nl, call(P) )    %% TA-110130
%        ;
%    true. %% Finally, succeed anyway

%% ¤¤¤¤¤¤¤¤¤¤¤¤
%:- meta_predicate  traceanswer(0).
%traceanswer( _:Panswer ) :- 
%         value(traceans,L),
%         L>1,
%    !,
%         copy_term( Panswer, Pwr ),
%         numbervars(Pwr),         % utility.pl?
%         prettypr('Application answer program',Pwr),nl. 
%traceanswer(_). %% Otherwise
%
%%% ¤¤¤¤¤¤¤¤¤¤¤¤
%writeanswer( Panswer ) :- 
%    traceanswer( Panswer ),
%    Panswer,
%    !. 
%%% ¤¤¤¤¤¤¤¤¤¤¤¤
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

