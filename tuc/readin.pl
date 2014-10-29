/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE readin.pl
%% SYSTEM TUC
%% CREATED  TA-910531   %% REVISED  TA-110725
%% REVISED  RS-140101 modularized

%%  Read a sentence into a list of symbols
:-module( readin, [ alpha/3, alphanum/2, alphanums/3, ask_file/1, ask_user/1, digits/3, norsource_postfix/0, norsource_prefix/0, 
                    read_in/1, readoneline/1, words/3, readrestquote/3 ] ).  %% RS-131227 For ...main.pl


%%  A sentence must be ended by a terminator ?.!  
%%    followed by a CR 

%% SCANDINAVIAN LETTERS [\] {|} NO LONGER

%% comma (',') is neglected 
%% content of parentheses is neglected (name) ?

%% RS-141026    UNIT: /
:- use_module( '../main.pl', [ ( := )/2, value/2 ] ). %MISERY?!
%% RS-131225, UNIT: /   and /utility/
%:- ensure_loaded( '../declare' ).  %% RS-140102 (:=)/2, user:value/2
%:- ensure_loaded( '../tucbuses' ). % , [ prompt/1 ] ). %% RS-131229-140928 NOT A MODULE (any more, after all...)
:- use_module( '../tucbuses', [ prompt/1 ] ). %% RS-131229-140928 NOT A MODULE (any more, after all...)

:- use_module( '../utility/library', [ ] ).    %% RS-131225 etc?
:- use_module( '../utility/utility', [ splitlast/3 ] ).  %% RS-131225 etc?
:- use_module( '../utility/writeout', [ output/1 ] ).  %% RS-140921

:- use_module( '../sicstus4compatibility', [ get0/1, ttyflush/0 ] ).  %% Compatible with sicstus4, get0/1 etc.

%:- use_module( '../main.pl', [ norsource_prefix/0 ] ). %% RS-140209 hei/0,   run/0     %% RS-141002 DON'T !! (LOOP!) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% NB 0015 \-> 2415

%% 
%%  
%% "Text"  =>  quote(Text)    %% she said " who is the responsible ?" .  ASCII 34
%% 'Text'  =>  literal(Text)  %% 'between' is a preposition .            ASCII 39
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


ask_user(P) :- !, 
   ttyflush,
   nl,
   prompt(E), %% Defined in Makefile  
   write_prompt(E), %% TA-110207
   read_in(P),
   write_from_user(P).

ask_file(P) :-      
   nl,
   prompt(E), %% Defined in Makefile  

   write_prompt(E), %% TA-110207
   read_in(P),
   write_from_file(P),
   nl.

write_prompt(_E):- %% TA-110207
    value(norsource,true),
    !.
write_prompt(E):-
     write(E).


%%% Miscellaneous for File Reading

write_from_user(P):-
    value(talk,1), 
    !,
%    opentalk(question),
        doing(P,0). %% out to \nat\scratch
%    closetalk(question).

write_from_user(_):-!.

norsource_prefix :- %% TA-110207
    value( norsource, true ) ->
    output( '<bustuc>' ) ; true.

norsource_postfix :- %% TA-110207
    value(norsource,true) ->
    (output('</bustuc>'),nl);true.


write_from_file( P ) :- %% TA-110207
   value(norsource,true),
   !,

   norsource_prefix,nl, %% bloody hack %% TA-110207

   output('<sentence> '),
   doing(P,0),
   nl,
   output('</sentence>').
 


write_from_file(P):-
    doing(P,0).

doing([],_) :- !.
doing([X|L],N0) :-
   out1(X),
   advance(X,N0,N),
   doing(L,N).

out1(nb(X)) :- !,
   write(X).
out1(quote(X)) :- !,
   write(''''),write(X),write('''').
out1(A) :-
   write(A).

advance(X,N0,N) :-
   uses(X,K),
   M is N0+K,
 ( M > 72, !,
      nl,
      N is 0;
   N is M+1,
      write(' ')) . %% put(" ")).

uses(nb(X),N) :- !,
   chars(X,N).

uses(quote(X),N) :-!,
   chars(X,M),
   N is M+2.

uses(X,N) :- 
   chars(X,N).



%%% Read a Sentence


read_in(P):- 
    initread(L),
    words(P,L,[]),
    !. %% ,to_nl.


initread(U):-
     getnextnb(K1),   % first non blank character

   (  member(K1,[37, 92])  % '%' '\'   %% '¤'=164

   -> ( commandflag := true ) 
           ;
      ( commandflag := false) 
   ),
           
     readrest0(K1,U).


   

readrest0(T,L):- 
    T=35,     %% # in first column  means skip
    !,
    skip_rest_of_line,
    initread(L).



readrest0(T,Comline):- 
    member(T,[37, 92]), % '%' '\' %% '¤' = 164
        %% Only First character is significant
    !,
    readrestline(T,Comline).   %% return with 1 line (NO  '.'. required) 

readrest0(T,Comline):- 
    readrest(T,Comline).


readrest(T,[]) :- T== -1, %%   EOF
    ( end_of_file := true ),

    seen.  


readrest(T,L):- %% (...) = ' ' 
    T=40,     %% ( 
    value(noparentflag,true), %% ignore content
    \+  value(gpsflag,true),  %% TA-110114
    !,
    skipuntil(41),  %% ) including CR
    readrest(32,L). 


readrest(T,Rest):- 
    term_char(T),       %% termchar '.','!'.'?'
    value(textflag,true),
    !,
    get0129(Z),  %% next character (blank or not)
    !,
    trick_or_treat(T,Z,Rest).

 
readrest(T,Rest):- 
    term_char(T),   %% .?! read outside quote
    getnext_bl(Z),  %%  (  space after final . is OK)
    !,
    trick_or_treat(T,Z,Rest).

readrest(K,[K|U]):-
    blank(K), %% K =< 32,  % blank, tabs, CR  etc
    !,
    getnextnb(K1), % skip more blanks
    readrest(K1,U).

readrest(K,[K|U]):- % A Proper Character
    getnext(K1),   
    readrest(K1,U).



skipuntil(CH):- 
    repeat,
    get0(C),
    (C=CH;C=10), %% stop at CR %% TA-101115
    !.



trick_or_treat(T,10,[T]):-!.   %% .CR => Return
trick_or_treat(T,B32,[T]):-blank_char(B32),!. 
   %% .Bl => Return (only called with 32 if textflag)

trick_or_treat(T,37,[T]):-     %% commentchar == CR 
    !,
    to_nl.

trick_or_treat(T,C,[T|R]):-
    readrest(C,R).


readrestquote(A,A,[A|U]):-
    !, %% found matching apostrophe
    getnext(K1),
    readrest(K1,U).

readrestquote(A,K1,[K1|U]):-
    !, %% still inside quotes
    get0129(K2),
    readrestquote(A,K2,U).    


to_nl:- 
     value(textflag,true),!.

to_nl :-
   repeat,
   get0129(10),
   !.

skip_rest_of_line :- 
   repeat,
   get0129(10).
   

%%%% Read One line   %%%%%%%%%%%%%%%%%%%%%%

readoneline(P):-
    initreadline(L),
    words(P,L,[]),
    !.

initreadline(U):-
     getnext_bl(K1),        % first non blank character
     readrestline(K1,U).


readrestline(T,[]):- 
    T=10,  %% CR
    !.

readrestline(K,[K|U]):-
    K==32, %% blank_char(K),
    !,
    getnext_bl_co(K1), % blanks, comments (evt returns CR)
    readrestline(K1,U).

readrestline(K,[K|U]):- % A Proper Character
    get0129(K1),           % next 
    readrestline(K1,U).


%% End Read One line %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% get next...  
  
%  _bl (non_blank)  _co (non_comment)  _cr (non_cr) _te (non_terminal)


getnext(X):-      %  - bl  - co  - cr
    get0129(C),      
    (comment_char(C) -> 
        (to_nl,getnextnb(X)); 
         X=C).

getnextnb(X):-   % - bl  - co
    getnext(C),  
    
  ( C = -1   -> X= -1;          %% end of file 
    blank(C) -> getnextnb(X);   %%   -bl -cr %% blank_char
                X=C).




getnext_bl_co(X):-  % -bl - co, returns CR
    getnext_bl(C),      
    (comment_char(C) -> 
              (to_nl,X=10);
               X=C).

getnext_bl(X):-  % _bl 
    get0129(C), 
    (blank_char(C) -> %% =32 -> 
         getnext_bl(X);
         X=C).

% get0   Built-in

get0129(C):-get0(K),       %% Avoid a  \201 ahead of every norwegian character
    (K=129 -> get0129(C);  %% Problem in emacs on linux for european display
    K=C).                  %% when running through shell
                           %% Probably remedied by (standard-display-european 1)
                           %% in the .emacs file

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

foreign_coding(195,182,97).      %%  Ã¶ -> a %% TA-110725
foreign_coding(195,188,117).     %%  Ã¼ -> u 

foreign_coding(195,184,248).     %%  Ã¸ -> ø
foreign_coding(195,169,101).     %%  Ã© -> e
foreign_coding(195,166,230).     %%  Ã¦ -> æ.
foreign_coding(195,165,229).     %%  Ã¥ -> å 
foreign_coding(195,182,248).     %%  Ã¶ -> ø ( ö )
foreign_coding(195,152,248).     %%  Ã -> ø
foreign_coding(195,164,230).     %%  Ã¤ -> æ ( ä )  %% TA-110512
foreign_coding(195,133,229).     %%  Ã ->  å    %% TA-110516

words([C|D], A, B) :-
        wordc(C, A, E), !,
        blanks(E, F),
        words(D, F, B).
words([], A, A) . 

wordc(A, B, C) :-
        word1(D, E, B, C),
        w01(D, E, A).


word1([D|E], number, B, C) :-
        numchar(D,B, F),
        !,
        wordnum(E, F, C).


word1([D|E], A, B, C) :- %% The first foreign
        B=[A1,A2|K],
        foreign_coding(A1,A2,A12),
        !,
        B1=[A12|K],
        idchar(D, A, B1, F),
        word01(E, A, F, C). %% TA-110502

word1([D|E], A, B, C) :-
        idchar(D, A, B, F),
        word01(E, A, F, C).


word1(A, quote, [D|E], C) :-
        apostrophe(D), !,
        charstring(A, E, [ D| C]).


word1([C], term,[ C| B], B) :-
        true. % not_apostrophe(C). 

idchar(A, alpha,[ D| C], C) :-
        lc(D, A).
idchar(A, alpha,  [A| C], C) :-
        underscore(A). 


idchar(A, alpha, [A| C], C) :- %%    buss5 -> BUSS 5 
     (value(dialog,1);       %% especially context id 
     value(commandflag,true)),  %% except for commands
     digit(A).




numchar(A, [A| C], C) :- 
        digit(A).



 /*  NOT at the end 
idchar(A, _, [A| C], C) :-
        apostrophe(A).
 */


stripoph(E,E1):-
    splitlast(E,E1,A), %% utility.pl
    apostrophe(A),!;
    E=E1.


word01([D|E], A, B, C) :- %% TA-110427  %% The following foreigns
        B=[A1,A2|K],
        foreign_coding(A1,A2,A12),
        !,
        B1=[A12|K],
        idchar(D, A, B1, F),
        word01(E, A, F, C).

word01([D|E], A, B, C) :-
        idchar(D, A, B, F),
        word01(E, A, F, C).
word01([], _, A, A).

%%  read a number, but stop before nondigit

wordnum([D|E], B, C) :-
        numchar(D, B, F),
        wordnum(E, F, C).
wordnum([], X, X).




blanks( [C|D], B) :-
        blank(C), !,
        blanks(D, B).
blanks(A, A). 


alpha(A,  [D| C], C) :-
        lc(D, A).

digits([C|D], [C|E], B) :-
        digsign(C), !,
        digits(D, E, B).
digits([], A, A). 


alphanums([C|D],[E|F], B) :-
        alphanum(E, C), !,
        alphanums(D, F, B).
alphanums([], A, A). 

charstring([C|D], [C|E], B) :-
        not_apostrophe(C),
        !, 
        charstring(D, E, B).
charstring([], A, A):-!.

charstring([] ,[],[_]):-!. %% missing appostrophe is inserted.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

apostrophe(96).  %% `
apostrophe(39).  %% '
apostrophe(34).  %% "
apostrophe(168). %% ¨  %% NB   \=  " 
apostrophe(180). %% ´ 

% apostrophe(171). %% '«' 
% apostrophe(187). %% '»'  %% balanced appostroph, redundant


%%% apostrophe(184). %% '¸'  ??  Dangerous, occurs only once

not_apostrophe(X) :- \+ apostrophe(X).

%   comment_char(37). %-) %%    % was comment in scripts

comment_char(257). %% completely impossible

term_char(33). %% !   
term_char(46). %% .
term_char(58). %% :   Experiment 
term_char(63). %% ?

%% blank_char(K) :- K =< 32 . %% blank 

alphanum(K,K1):-lc(K,K1).
alphanum(K,K):-digit(K).

alphanum(K,K):-underscore(K). 

underscore(95) :- %% _  
     value(commandflag,true). 

digsign(X):-digit(X).
digsign(X):-sign(X).

digit(K):-K>47,K<58.

% _ is treated as blank !!!
% sign(95) :- !. %% _    %%   "_" NOT treated as "-" because of COMMANDS
% sign(45) :- !. %% -    %%   NB NB  AMO-senteret ==> AMO '-' senteret

sign(10000).  %% Dummy  !




blank_char(B):- %% NOT CR !!!!
    B==32;
%%%         B==44; %% must be removed as noise 
    B==94;    %% '^' 
%%    B==95 ; %% '_' %% // NEEDED FOR COMMANDS
    B==160.

blank_char(95):- 
    \+ value(commandflag,true).


blank(K) :- K =< 32; %% Including CR !
%%            K=44 ;  %% must be removed as noise 
            K==94;    %% '^' 
%%             K=95 ; %% '_' %% NEEDED FOR COMMANDS
            K=160. %% (Invisible chracter)

blank(95):- 
    \+ value(commandflag,true).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% lc(original,official)   translates upper case to lower case
%                          in addition, some ad hoc normalisations



lc(X,Y):-  
   lc1(X,Y),
   value(teleflag,true),
   !.

lc(X,Y):- 
   lc1(_,X),
   value(teleflag,true),
   !,
   Y=X.


lc(152,248). %% ø Ãstre %% TA-101124 ???

lc(133,121). %% Ãsheim  %% TA-101129 ???


/*

          'æ   ø   å   Æ   Ø   Å   [  \  ]   {   |   ¦   }
          [230,248,229,198,216,197,91,92 93, 123,124,166,125]
 
*/

%% The use of [ | ] for ÆØÅ is now outdated

% lc(91,230).    % [ -> Æ -> æ
% lc(92,248).    % | -> Ø -> ø 
% lc(93,229).    % ] -> Å -> å

%% The use of { \ } for æøå is now outdated

% lc(123,230). %%  {  -> æ  
% lc(124,248). %%  |  -> ø  
% lc(166,248). %%  ¦  -> ø 
% lc(125,229). %%  }  -> å  

% % % %

% lc(102,32).  % ctrl - V ???

lc(165,121).  % ¥ -> y 


lc(166,124).  %  ¦ -> | (standard, but  keybord shows "¦" )
lc(124,124).  % ad hoc, 124 is a lc

%%    case character because of Æ trøbbel klÃ¦buveien  -> kla buveie


lc(169,248).  % © -> ø   %% l©ªrdag?

lc(170,170). % ª   løªrdag? 

%%%%% lc(172,45). % ¬  -> -  %%  N¬Ör g¬Ör=når går 

lc(176,248).  %  ° -> ø    gl°shaugen %% UNIX 7 
lc(178,114).  %  ² -> r    Nå² gå²bussen      ²-> r appearantly

lc(181,230).  % µ -> æ  %% UNIX 7 
lc(182,248).  % ¶ -> ø //  accent/apparently %% TA-110324
lc(184,248).  % ¸ -> ø //  accent/apparently 

lc(186,229).  % º ->  å // apparently

%% lc(188,117).  % fÃ¼r  fuer 

lc(189,189). %% ½  %% ? nï¿½r mï¿½ 

lc(190,230).     %  '¾' -> æ %%  v¾re 

lc(191,230).     %  ¿ -> æ    %% > ø  ?

lc(192,197).     % À-> a 

lc(193,97).     %  Á -> a 
lc(194,97).     %  Â -> a 
lc(195,97).     %  Ã -> a

lc(196,230).    %  Ä -> æ

lc(199,99).   % 'Ç' -> c

lc(200,101).  % È  -> e 
lc(201,101).  % É  -> e     %%
lc(202,101).  % Ê  -> e     %%
lc(203,101).  % Ë  -> e  

lc(204,105).  % Ì  -> i
lc(205,105).  % Í  -> i
lc(206,105).  % Î  -> i
lc(207,105).  % Ï  -> i

lc(208,100).  % Ð  -> d

lc(209,110).  % Ñ  -> n   

lc(210,111).  % Ò -> o 
lc(211,111).  % Ó -> o
lc(212,111).  % Ô -> o

lc(213,229).  % Õ -> å   %% UNIX 7 gÕr 

lc(214,248).  %  Ö -> ø  

lc(215,120).  % ×  -> x % * = 42 ?

lc(217, 117). % Ù -> u
lc(218, 117). % Ú -> u
lc(219, 117). % Û -> u

lc(220, 121). % Ü -> y % NB ?
lc(221, 121). % Ý -> y 

lc(223, 98).  % ß -> b (BB) or ss?

lc(224,229).  %% 97).   %  à -> å    %% 1. pàskedag"
lc(225,97).   %  á -> a    %% actual Lade  álle
lc(226,229).  %  â -> å    %% or a ?
lc(227, 97).  %  ã -> a  

lc(228,230).  % ä = 228 

lc(231,99).   % ç -> c

lc(232,101). % è  -> e  
lc(233,101). % é  -> e 
lc(234,101). % ê  -> e   
lc(235,101). % ë  -> e  

lc(236,105). % ì  -> i   
lc(237,105). % í  -> i   
lc(238,105). % î  -> i 
lc(239,105). % ï  -> i   

lc(240,229). % ð  -> å     %%  gðr nðr / når går  

lc(241,110).  % ñ  -> n   

lc(242,111).  % ò -> o  
lc(243,111).  % ó -> o 
lc(244,111).  % ô -> o 
lc(245,111).  % õ -> o
lc(246,248).  % ö -> ø  

lc(247,47).   % ÷  -> /


lc(249,117).  % ù -> u
lc(250,117).  % ú -> u
lc(251,117).  % û -> u

lc(252,121). %  ü -> y 
lc(253,121). %  ý -> y (Turkish) 
lc(255,121). %  ÿ -> y

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ISO-8859-1 (Latin 1) chars

lc(K,K)  :- K>223,K<256.               % Lower case
lc(K,K1) :- K>192,K<224,!,K1 is K+32. % Upper case -> Lower case

lc(K,K1) :- K>64,K<91,!,K1 is K\/32 . %% 8'40.
lc(K,K)  :- K>96,K<123. %% 126.  %% exclude {|} etc 


%% In tele-modus (teleflag), some foreign characters 
%% shall not be translated to Norwegian characters,
%% but just to their lower case counterparts.
/*

ÂÄÀÁ -> âäàá

ÊËÈÉ -> êëèé

ÔÖÒÓ -> ôöòó

ÛÜÙÚ -> ûüùú

Ñ -> ñ

*/


lc1(194,226).  % ÂÄÀÁ -> âäàá
lc1(196,230).  % Ä -> æ
lc1(192,224).
lc1(193,225). 

lc1(202,234).  % ÊËÈÉ -> êëèé
lc1(203,235).
lc1(200,232).
lc1(201,233). 

lc1(206,238). % ÎÏÌÍ -> îïìí
lc1(207,239).
lc1(204,236).
lc1(205,237).

lc1(212,244). % ÔÖÒÓ -> ôöòóÔ
lc1(214,246).
lc1(210,242).
lc1(211,243).

lc1(219,251). % ÛÜÙÚ -> ûüùú
lc1(220,252).
lc1(217,249).
lc1(218,250).

lc1(241,209). % Ñ -> ñ


% w01(CL,V,U):-var(V),!,name(U,CL). 

w01(CL,alpha,quote(U)):- 
    CL=[D|E],
    apostrophe(D),
    !,
    stripoph(E,F),
    name(U,F).

w01(CL,quote,quote(U)):-!,name(U,CL).

%% w01(CL,_,U):-!,atom_chars(U,CL). %%  0-> '9' NO

/**** Incompatible with  NIGHT BUS %% TA-101203
w01([48,48,D1,D2],number,U):- %% 0015 -> 2415  %% Rough Time, 0015 \== 15
    D1 >= 48,D1 =< 53,   % 0-5
    D2 >= 48,D2 =< 57,   % 0-9
    !,
    name(U,[50,52,D1,D2]).
***/

w01(CL,_,U):-!,name(U,CL).    %%


chars(X,N) :- 
   atomic(X), 
   !,
   name(X,L),
   length(L,N).
chars(_,2).


%%%%%%THE END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
