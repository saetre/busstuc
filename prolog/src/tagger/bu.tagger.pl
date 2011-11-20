%% FILE		tagger.pl
%% SYSTEM	StudTUC
%% CREATED	MTK-14-Oct-2002

hent_chars(C,I,L) :- at_end_of_stream, append(I,[C],L).
hent_chars(C,I,O) :- \+ at_end_of_stream, append(I,[C],L), get_code(T), hent_chars(T,L,O).

get_chars(L) :-
	get_code(C),
	hent_chars(C,[],L).

find_word([],_,Word,[],Word).
find_word([Code|Rest],Del,Word,Rest,Word) :- 
	Code == Del.
find_word([Code|Codes],Del,Past,Rest,Word) :-
	Code \== Del,
	append(Past,[Code],P),
	find_word(Codes,Del,P,Rest,Word).

split([],_,[]).
split(Codes,Del,List) :-
	find_word(Codes,Del,[],Rest,CW),
	atom_chars(Word,CW),
	split(Rest,Del,L),
	append([Word],L,List).

parse_data(Codes, First, Rest) :-
	!,
	split(Codes,32,[First|Rest]),
	!.

parse_class(_,apo,AData,[Tags],[Comp]) :- 
	xml_subterm(AData, element(concept,_,[pcdata(Concept)])),
	xml_subterm(AData, element(key,_,[pcdata(Key)])),
	xml_subterm(AData, element(data,_,[pcdata(Data)])),
	parse_data(Data,F,R),
	atom_chars(K,Key),
	atom_chars(C,Concept),
	Comp = [F,R,K],
	Tags = [K,C].

parse_class(Word,isa,[pcdata(C)],[Tags],[]) :- 
	atom_chars(Concept,C),
	atom_chars(Key,Word),
	Tags = [Key,Concept].

parse_classes(_,[],Tags,Tags,Comp,Comp).
parse_classes(Word,[Class|Classes],ITags,Tags,IComp,Comp) :-
	xml_subterm([Class], element(T,_,D)),
	parse_class(Word,T,D,TTags,TComp),
	append(ITags,TTags,NTags),
	append(IComp,TComp,NComp),
	parse_classes(Word,Classes,NTags,Tags,NComp,Comp).

parse_tag(XML,Tags,Compnames) :-
	xml_subterm(XML, element(word,_,[pcdata(Word)])),
	xml_subterm(XML, element(class,_,Class)),
	parse_classes(Word,Class,[],Tags,[],Compnames).

parse_tags1([],Isa,Isa,Cmpl,Cmpl).
parse_tags1([Tag|Tags],InitIsa,Isa,InitCmpl,Cmpl) :- 
	xml_subterm([Tag], element(tag,_,C)),
	parse_tag(C,TmpIsa,TmpCmpl),
	append(InitIsa,TmpIsa,NewIsa),
	append(InitCmpl,TmpCmpl,NewCmpl),
	parse_tags1(Tags,NewIsa,Isa,NewCmpl,Cmpl).

parse_tags(XML,Tags,Compnames) :-
	parse_tags1(XML,[],Tags,[],Compnames).

/*
test :-
	see('test.xml'),
	get_chars(Input),
	seen,
	xml_parse(Input,XML),
	xml_subterm(XML, element(result,_,Result)),
	parse_tags(Result,Tags,Compnames),
	write('     tags = '),write(Tags),nl,
	write('compnames = '),write(Compnames),nl.

*/
:- use_module(xml).
:- use_module(library(lists)).
