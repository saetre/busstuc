
:- module( xml_diagnosis, [ xml_fault/5 ] ). %% , pp_string/1, xml_declaration_attributes_valid/1, xml_to_document/3,   ] ).

/* xml_diagnosis.pl : XML exception diagnosis.
 *
 * Copyright (C) 2001, 2002 Binding Time Limited
 * 
 * TERMS AND CONDITIONS:
 *
 * This program is offered free of charge, as unsupported source code. You may
 * use it, copy it, distribute it, modify it or sell it without restriction. 
 * 
 * We hope that it will be useful to you, but it is provided "as is" without
 * any warranty express or implied, including but not limited to the warranty
 * of non-infringement and the implied warranties of merchantability and fitness
 * for a particular purpose.
 * 
 * Binding Time Limited will not be liable for any damages suffered by you as
 * a result of using the Program. In no event will Binding Time Limited be
 * liable for any special, indirect or consequential damages or lost profits
 * even if Binding Time Limited has been advised of the possibility of their
 * occurrence. Binding Time Limited will not be liable for any third party
 * claims against you.
 *
 * History:
 * $Log: xml_diagnosis.pl,v $
 * Revision 1.3  2002-05-10 10:22:10+01  john
 * Diagnosing invalid character data.
 *
 * Revision 1.2  2002-04-21 19:39:03+01  john
 * Correcting format of explanatory strings.
 *
 * Revision 1.1  2002-01-31 21:04:45+00  john
 * Updated Copyright statements.
 *
 * Revision 1.0  2001-10-17 20:46:23+01  john
 * Initial revision
 *
 *
 *
 */

:-use_module( library(lists), [ is_list/1 ] ).

:-use_module( xml_acquisition, [ chars/3 ] ). %% , pp_string/1, xml_declaration_attributes_valid/1, xml_to_document/3,   ] ).
:-use_module( xml_generation, [ generation/7 ] ). %% , pp_string/1, xml_declaration_attributes_valid/1, xml_to_document/3,   ] ).

/* xml_fault( +Term, +Indentation, ?SubTerm, ?Path, ?Message ) identifies SubTerm
 * as a sub-term of Term which cannot be serialized after Indentation.
 * Message is an atom naming the type of error; Path is a string encoding a
 * list of SubTerm's ancestor elements in the form <tag>{(id)}* where <tag> is the
 * element tag and <id> is the value of any attribute _named_ id.
 */
xml_fault( Term, _Indent, Term, [], "Illegal Variable" ) :-
	var( Term ).
xml_fault( xml(Attributes,_Content), _Indent, Term, [], Message ) :-
	member( Attribute, Attributes ),
	attribute_fault( Attribute, Term, Message ).
xml_fault( xml(_Attributes,Content), Indent, Culprit, Path, Message ) :-
	xml_content_fault( Content, Indent, Culprit, Path, Message ).
xml_fault( Term, _Indent, Term, [], "Illegal Term" ).

xml_content_fault( Term, _Indent, Term, [], "Illegal Variable" ) :-
	var( Term ).
xml_content_fault( pcdata(Chars), _Indent, Chars, [], "Invalid Character Data" ) :-
	\+ is_chars( Chars ).
xml_content_fault( cdata(Chars), _Indent, Chars, [], "Invalid Character Data" ) :-
	\+ is_chars( Chars ).
xml_content_fault( [H|_T], Indent, Culprit, Path, Message ) :-
	xml_content_fault( H, Indent, Culprit, Path, Message ).
xml_content_fault( [_H|T], Indent, Culprit, Path, Message ) :-
	xml_content_fault( T, Indent, Culprit, Path, Message ).
xml_content_fault( namespace(_URI,_Prefix,Element), Indent, Culprit, Path, Message ) :-
	element_fault( Element, [0' |Indent], Culprit, Path, Message ).
xml_content_fault( Element, Indent, Culprit, Path, Message ) :-
	element_fault( Element, [0' |Indent], Culprit, Path, Message ).
xml_content_fault( Term, Indent, Term, [], "Illegal Term" ) :-
	\+ generation(Term, "", false, Indent, _Format, _Plus, _Minus ).

element_fault( element(Tag, _Attributes, _Contents), _Indent, Tag, [], "Tag must be an atom" ) :-
	\+ atom( Tag ).
element_fault( element(Tag, Attributes, _Contents), _Indent, Tag, [], "Attributes must be instantiated" ) :-
	var( Attributes ).
element_fault( element(Tag, Attributes, _Contents), _Indent, Faulty, Path, Message ) :-
	fault_path( Tag, Attributes, Path, [] ),
	member( Attribute, Attributes ),
	attribute_fault( Attribute, Faulty, Message ).
element_fault( element(Tag, Attributes, Contents), Indent, Culprit, Path, Message ) :-
	fault_path( Tag, Attributes, Path, Path1 ),
	xml_content_fault( Contents, Indent, Culprit, Path1, Message ).

attribute_fault( Attribute, Attribute, "Illegal Variable" ) :-
	var( Attribute ).
attribute_fault( Name=Value, Name=Value, "Attribute Name must be atom" ) :-
	\+ atom(Name).
attribute_fault( Name=Value, Name=Value, "Attribute Value must be chars" ) :-
	\+ is_chars( Value ).
attribute_fault( Attribute, Attribute, "Malformed Attribute" ) :-
	\+ Attribute = (_Name=_Value).

is_chars( Chars ) :-
	is_list( Chars ),
	\+ (member( Char, Chars ), \+ (integer(Char), Char >=0, Char =< 255)).

fault_path( Tag, Attributes ) -->
	{atom_codes( Tag, Chars )},
	chars( Chars ),
	fault_id( Attributes ),
	" ".

fault_id( Attributes ) -->
	{member( id=Chars, Attributes ), is_chars( Chars )},
	!,
	"(", chars(Chars), ")".
fault_id( _Attributes ) --> "".
