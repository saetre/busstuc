%% FILE xmlparser.pl
%% SYSTEM TELETUC
%% CREATED  TA-020617
%% REVISED  TA-020624

%%% %%%%%%%% RS-111118
:- ensure_loaded( 'declare' ).
%:- use_module( 'declare.pl' ).

xmltaggerparse(F,Struct):-

                            output('scan'),output(F),
    
    scanfile(F,List),

                            output(List),

    skipstart(List,List1),


    xmltaggerparse1(Struct,List1,[]),

    !. %% TA-020624



xmlrowparse(F,Struct):-
    scanfile(F,List),

    skipstart(List,List1),
 
    xmlrowparse1(Struct,List1,[]),

    !. %% TA-020624
    



skipstart(['<'|Z],['<'|Z]):-!.
skipstart([_X|Y],K):-
    skipstart(Y,K).


%%% Parser rules

%% Tagger Parse

xmltaggerparse1(FH)    --> xmlbolks(FH).

xmlbolks([F|H])       --> xmlbolk(F),xmlbolks(H).

xmlbolks([])          --> [].

xmlbolk(K)            --> xmlresultbolk(K).

xmlrowparse1(Struct) --> 
    xmlquerybolk(query),
    xmlresrowsbolk(Struct).

xmlquerybolk(query) -->
    xmltag(query), 
    skip(query).
 
xmlresrowsbolk([result=RB]) -->
    xmltag(result),
    xmlrowsbolk(RB),
    xmluntag(result).



xmlrowsbolk([H|T]) -->
  xmlrowbolk(H),
  xmlrowsbolk(T).
     
xmlrowsbolk([]) --> [].


xmlrowbolk(K)   --> 
    xmltag(row), 
    xmlreslist(K),
    xmluntag(row).


%% Common Rules


skip(Query) -->  ['<','/',Query,'>'],!.

skip(Query) -->  [_],skip(Query).

xmlresultbolk([result=K])   --> 
    xmltag(result), 
    xmlreslist(K),
    xmluntag(result).

xmlreslist([F|H])  --> 
    xmltagitem(F),
    xmlreslist(H). 
xmlreslist([])  --> [].


xmltagitem([A=H])  --> 
    xmltag(A),
       firstonly(H), %% HELEN BEATE JOHANNE -> helen %% TA-020624
    xmluntag(A).


firstonly(H) --> [H], skiprestlist.  %% TA-020624

%skiprestlist --> [X],{X \== '<'},skiprestlist.
skiprestlist --> [].


xmltag(Result)   --> ['<',Result,'>'].
xmluntag(Result) --> ['<','/',Result,'>'].











