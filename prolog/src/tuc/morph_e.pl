%% FILE morph_e.pl
%% SYSTEM TUC
%% AUTHOR T.Amble
%% CREATED TA-961014
%% REVISED TA-100325


%% Morphological Analyser for the language E.

:-module( morph_e, [ %% lcode2/2, %% RS-140428 This breaks the lcode2/2 in user: (from lex.pl). All words end up "unknown"
        lexv/2,    %% RS-131225    Only /2 ? There is another lexv with /4
        verbroot/1 ] ).
%% ends_with(X,Y,Z):-ends_with(X,Y,Z).     %% RS-131225    Try to use dict_e & modules instead!
%%verb_form(X,Y,Z,U):-
%%    dict_e:verb_form(X,Y,Z,U).

%% (See Also morph_n.pl).

% Includes Common Predicates for Lexical Analysis
% that will be isolated into a file lex.pl
% Include spellcor.pl


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Tranforms each word into a list of alternatives.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% RS-111205, UNIT: tuc
:-use_module( dict_e, [ verb_form/4 ] ). %% Sometimes caused duplicates? %% RS-131228
:-use_module( lex, [ part_word/1 ] ). %% RS-140209.
:-use_module( semantic, [        %  TUCs  Lexical Semantic Knowledge Base        %% RS-131227
            dtv_templ/4,            iv_templ/2,            pvi_templ/2,            tv_templ/3 ]).

%% RS-111205, UNIT: utility
%:- ensure_loaded( user:'../utility/utility' ). %, [ := /2 etc. ] ).  %% RS-131117 includes declare.pl
:- use_module( '../utility/utility', [ ends_with/3 ] ).


%%%%%% The coding conventions %%%%%%%%%%%%%%%%%%%%%

%  w(<word>,List of Interpretations)
%
%       Interpretation
%                                             
%       noun(root,{sin,plu},{u},{gen,n})   (u ubest, best Norwegian)
%       name(root,{gen,n},Class) 
%       verb(root,{pres,past},{fin,part})       {sin,plu} is of no consequence
%       adj2(root,{nil,comp,sup})   %% TA-091209
%       prep(word)
%       nb(numeral,{ind,ord})
%       quote(text)
%       [word]                                  all others words 
%
%
% Underscore variables _  are used for
%
%       dont know   in the data and
%       dont care   in the grammar
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lcode2(V,verb(W,X,Y)):-  
    \+ dict_e:unwanted_verb(V),  % e.g. meaning
    lexv(V,W1,X,Y),
    dict_e:verbroot2(W1,W).  %% i.e. root  synonyms 

lcode2(M,noun(N,X,Y,Z)):- 
    \+ dict_e:unwanted_noun(M), 
    lexn(M,N1,X,Y,Z), 
    dict_e:noun2(N1,N). 

lcode2(M,prep(M)):-
    dict_e:preposition(M).

lcode2(HUNGRIER,adj2(HUNGRY,nil)):- 
    \+  dict_e:unwanted_adjective(HUNGRIER), 
    adjflex(HUNGRIER,HUNGRY1), %% TA-060310
    dict_e:adjective2(HUNGRY1,HUNGRY).   %% dict_e.pl


lcode2(M,nb(N,X)):-
    dict_e:numerid(M,N,X).

lcode2(X,[X]):-           % Test on actual word 
     dict_e:cw(X).               % closed set of known words

                         
lcode2(X,[X]):-           %% TA-071108  not name(X,n,0) as before
    part_word(X).    %% lex.   

%% 

verbroot(W):- 
    be_verb(W);
    ditrans_verb(W);
    trans_verb(W);
    intrans_verb(W);
    dict_e:rep_verb(W);
    pvimodal_verb(W). % cost 

pvimodal_verb(W):- 
    pvi_templ(W,_).

be_verb(be).

ditrans_verb(X):-
    dtv_templ(X,_,_,_).  %% btv -> dtv

trans_verb(have). %% 
trans_verb(X):-
   tv_templ(X,_,_),
   !. %% >1 

intrans_verb(X):-
   iv_templ(X,_),
   !. %% >1 


%% "Import" from utility: %% RS-131230
%ends_with(X,Y,Z):-user:ends_with(X,Y,Z).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                       
lexv(X,be,Y,Z):- 
    verb_form(X,be,Y,Z),
    !.

lexv(LOVE,LOVE,pres,fin).

lexv(KILLING,KILL,pres,part):-     
    ends_with(KILLING,KILL,ing).

lexv(TRAVELLING,TRAVEL,pres,part):-  
    ends_with(TRAVELLING,TRAVE,lling),
    ends_with(TRAVEL,TRAVE,l).

lexv(RUNNING,RUN,pres,part):-  
    ends_with(RUNNING,RUN,ning),
    ends_with(RUN,_,n).

lexv(SWIMMING,SWIM,pres,part):- 
    ends_with(SWIMMING,_SWI,mming),
    ends_with(SWIMMING,SWIM,ming).

lexv(LOVING,LOVE,pres,part):-     
    ends_with(LOVING,LOV,ing),
    ends_with(LOVE,LOV,e).

lexv(KILLED,KILL,past,fin):-    %%  avoid _    
    ends_with(KILLED,KILL,ed).

lexv(KILLED,KILL,past,part):-  
    ends_with(KILLED,KILL,ed).

lexv(TRAVELLED,TRAVEL,past,X):-  
    ends_with(TRAVELLED,TRAVE,lled),
    ends_with(TRAVEL,TRAVE,l),
    member(X,[part,fin]). 

lexv(LOVED,LOVE,past,X):-      
    ends_with(LOVED,LOVE,d),
    ends_with(LOVE,_,e),    
    member(X,[part,fin]).

lexv(LOGGED,LOG,past,X):- 
    ends_with(LOGGED,LOG,ged), 
    member(X,[part,fin]). 

lexv(SLAMMED,SLAM,past,X):-    
    ends_with(SLAMMED,SLAM,med), 
    member(X,[part,fin]). 




lexv(LOVES,LOVE,pres,fin):-            
    ends_with(LOVES,LOVE,s).

lexv(CATCHES,CATCH,pres,fin):-        
    ends_with(CATCHES,CATCH,es),
    (ends_with(CATCH,_CATC,s);   %% not cares = cars 
     ends_with(CATCH,_CATC,h);   %% catches
     ends_with(CATCH,_CATC,o)).  %% goes 

lexv(LOST,LOSE,X,Y):-
    verb_form(LOST,LOSE,X,Y).  %% dict.pl


lexv(APPLIED,APPLY,part,fin):-
    ends_with(APPLIED,APPL,ied),
    ends_with(APPLY,APPL,y).

lexv(APPLIED,APPLY,past,part):- 
    ends_with(APPLIED,APPL,ied),
    ends_with(APPLY,APPL,y).

lexv(APPLIES,APPLY,pres,fin):- 
    ends_with(APPLIES,APPL,ies),
    ends_with(APPLY,APPL,y).

lexv(X,X).            

%lexb(X,Y):-
%    lexv(X,Y),
%    dict:lexb1(Y).     % dict.pl       %% RS-131225    Obsolete?!

/* %% TA-020918  %% OBSOLETE
lexn(X,Y,sin,u,n):- 
    dict_e:lexnsingirr(X,Y).  % Irregular singular
*/

lexn(X,X,sin,u,n).   %%       % Regular singular

lexn(BOYS,BOY,Plu,U,N):-   
    dict_e:noun_form(BOYS,BOY,Plu,U,N).


/* OBSOLETE  %% TA-020918

lexn(Men,Man,plu,u,n):- %%
    dict_e:lexnpluirr(Men,Man).   % Irregular plural
    %% , !.   people 

*/

lexn(EKSEMPLET,EKSEMPEL,sin,def,n):- %% TA-100423
    ends_with(EKSEMPLET,EKSEMP,let),
    ends_with(EKSEMPEL,EKSEMP,el).


lexn(EKSEMPLER,EKSEMPEL,plu,u,n) :-  %% TA-100423
    ends_with(EKSEMPLER,EKSEMP,ler),
    ends_with(EKSEMPEL,EKSEMP,el).

lexn(EKSEMPLENE,EKSEMPEL,plu,def,n) :-  %% TA-100423
  ends_with(EKSEMPLENE,EKSEMP,lene),
    ends_with(EKSEMPEL,EKSEMP,el).


lexn(BOYS,BOY,plu,u,n):-   %% % Regular plural
    lexnplureg(BOYS,BOY).


lexn(MENS,MAN,X,U,gen):- 
    ends_with(MENS,MEN,s),
    lexn(MEN,MAN,X,U,n).     %% buss => bus'  OK


lexnplureg(BOXES,BOX):-    
    ends_with(BOXES,BOX,es).


lexnplureg(BOYS,BOY):-
    ends_with(BOYS,BOY,s),
   \+ ends_with(BOY,_,s).   %% buss =\=> buses  

lexnplureg(Babies,Baby):-  
    ends_with(Babies,Bab,ies),
    ends_with(Baby,Bab,y).

%% ADJECTIVE SECTION 

adjflex(CHEAP,CHEAP).
 
%% This is maybe a bit rough

adjflex(CHEAPER,CHEAP):-
    ends_with(CHEAPER,CHEAP,er).

adjflex(CHEAPEST,CHEAP):-
    ends_with(CHEAPEST,CHEAP,est).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
