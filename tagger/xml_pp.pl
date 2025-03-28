/* xml_pp: "pretty print" an XML Document on the current output stream.
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
 * $Log: xml_pp.pl,v $
 * Revision 1.1  2002-01-31 21:13:10+00  john
 * Updated Copyright statements.
 *
 * Revision 1.0  2001-10-17 20:46:23+01  john
 * Initial revision
 *
 *
 *
 */


:- use_module( xml_utilities ).
:- use_module( '../sicstus4compatibility', [ put/1 ] ). %% RS-150119  progtrace/2, 

/* xml_pp( +XMLDocument ) "pretty prints" XMLDocument on the current
 * output stream.
 */

xml_pp( xml(Attributes, Document) ) :-
	write( 'xml( ' ), pp_attributes( Attributes, "" ),
   put_code(44),nl,  %%%%%%%%%%%%%%  put( 0', ), nl,

	xml_pp_list( Document,"   "), %NO TABS S4
                              
	format( ' ).~n', [] ).
xml_pp( malformed(Attributes, Document) ) :-
	write( 'malformed( ' ), pp_attributes( Attributes, "" ), 
   put_code(44),nl, %%%%%%%%% put( 0', ), nl,

	xml_pp_list( Document, "   " ),
	format( ' ).~n', [] ).

xml_pp_indented( [], Indent ) :-
	format( '~s[]', [Indent] ).
xml_pp_indented( List, Indent ) :-
	List = [_|_],
	format( '~s', [Indent] ),
	xml_pp_list( List, Indent ).
xml_pp_indented( comment(Text), Indent ) :-
	format( '~scomment(', [Indent] ), pp_string(Text), put( 0') ).
xml_pp_indented( namespace(URI,Prefix,Element), Indent ) :-
	format( '~snamespace( ~q, "~s",~n', [Indent,URI,Prefix] ),
	xml_pp_indented( Element, [32	|Indent] ),  %% "0' "
	format( '~n~s)', [[32|Indent]] ). %% "0' "
xml_pp_indented( element(Tag,Attributes,Contents), Indent ) :-
	format( '~selement( ~q,~n', [Indent,Tag] ),
	pp_attributes( Attributes, [32|Indent] ),  %% "0' "

        
        put_code(44),nl, %% put(0',), nl,

        
	xml_pp_list( Contents, [32|Indent] ), write( ' )' ).
xml_pp_indented( instructions(Target, Processing), Indent ) :-
	format( '~sinstructions( ~q, ', [Indent,Target] ),
	pp_string(Processing), put( 0') ).
xml_pp_indented( doctype(Name, DoctypeId), Indent ) :-
	format( '~sdoctype( ~q, ', [Indent,Name] ),
	xml_pp_indented( DoctypeId, [32|Indent] ),
	write( ' )' ).
xml_pp_indented( cdata(CData), Indent ) :-
	format( '~scdata(', [Indent] ), pp_string(CData), put( 0') ).
xml_pp_indented( pcdata(PCData), Indent ) :-
	format( '~spcdata(', [Indent] ), pp_string(PCData), put( 0') ).
xml_pp_indented( public(URN,URL), _Indent ) :-
	format( 'public( "~s", "~s" )', [URN,URL] ).
xml_pp_indented( system(URL), _Indent ) :-
	format( 'system( "~s" )', [URL] ).
xml_pp_indented( local, _Indent ) :-
	write( local ).
xml_pp_indented( out_of_context(Tag), Indent ) :-
	format( '~s/* SYNTAX ERROR */ out_of_context( ~q )', [Indent,Tag] ).
xml_pp_indented( unparsed(String), Indent ) :-
	format( '~s/* SYNTAX ERROR */ unparsed( ', [Indent] ),
	pp_string(String), put( 0') ).

xml_pp_list( [], Indent ) :-
	format( '~s[]', [Indent] ).
xml_pp_list( [H|T], Indent ) :-
	format( '~s[~n', [Indent] ),
	xml_pp_indented( H, Indent ),
	xml_pp_list1( T, Indent ),
	format( '~s]', [Indent] ).

xml_pp_list1( [], _Indent ) :-
	nl. 
xml_pp_list1( [H|T], Indent ) :-
	put_code(44),nl, %%%%%%%%%%%%%% put( 0', ), nl,
	xml_pp_indented( H, Indent ),
	xml_pp_list1( T, Indent ).

pp_attributes( [], Indent ) :-
	format( '~s[]', [Indent] ).
pp_attributes( [Attribute|Attributes], Indent ) :-
	format( '~s[', [Indent] ),
	pp_attributes1( Attributes, Attribute ),
	put( 0'] ).

pp_attributes1( [], Name=Value ) :-
	format( '~q=', [Name] ), pp_string( Value ).
pp_attributes1( [H|T], Name=Value ) :-
	format( '~q=', [Name] ), pp_string( Value ), write( ', ' ),
	pp_attributes1( T, H ).
