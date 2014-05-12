/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE metacomp.pl  EXPERIMENTAL
%% SYSTEM TUC
%% CREATED  TA-940128   %% REVISED  TA-090521
%% REVISED  RS-140101 modularized

%% metacomp.pl (english and norsk)

%% SYSTEM TUC
:-module( metacomp, [ genprod/2, genvirt/1, makegram/5, optiprod/1, virtf/2, virtx/1, make_predname_argscount/2, write_protected_preds/1 ] ).
%% OLD: makegram/1, e.g. makegram(norsk). %% RS-131223
%% for utility.pl! (During makegram)       makegram/0,    makegram/1, segram/0,     regram/0,

%%?-prolog_flag(unknown,_,fail). %% Don't crash on undefined predicates        %% RS-131227

%% Make META-PREDICATES internal in this file!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- meta_predicate  for(:, + ). %% RS-140101 from utility ( : means this module, + means source module )?

for( P, Q ) :- %% For all P, do Q (with part of P)
  P, Q,
  false;true.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% RS-131223   % UNIT: /
:- ensure_loaded( user:'../declare' ). %% RS-131228 "new syntax" defs, META-preds: for/2, remember/1, value/2, :=/2, =;/2
%:- use_module( '../sicstus4compatibility', [ remove_duplicates/2 ] ).

%% RS-131223   % UNIT: EXTERNAL  %:- use_module( library(lists3), [remove_duplicates/2] ).

%% RS-131223   % UNIT: /utility/     Get dynamic definition for value/2
:- use_module( '../utility/utility', [ appendfiles/3, variant/2 ] ). %%, ( := )/2 %% RS-131117 includes user:declare.pl
:- use_module( '../utility/datecalc', [ datetime/6 ] ).

%% Moved from tucbuses.pl
%% RS-131227 compile_english and compile_norsk are used IN tucbuses!  %% Avoid circles!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%:-ensure_lodaed( user:'../tucbuses' ). %% RS-131223  makegram/2, language/1 %% RS-131227 Avoid loop!!
%:- use_module( tucbuses:'../tucbuses', [  dagrun_file/2,  dcg_file/2, dcg_module/2,  dict_file/2, morph_file/2,
%        gram_file/2, gram_module/2,     style_check/1  ] ). %% RS-131227 Avoid loop?   language/1, 


%%% SMOKETEST    virtuals are added last

%% VIRTUAL PRODUCTIONS MUST COME FIRST

%%  dcg_x.pl = virtuals.pl + dcg.pl

:- volatile
           virtf/2, virtx/1, optiprod/1. %%, predheads/1.

:- dynamic virtf/2,     %% the virtual functor
           virtx/1,     %% the virtual expression
           optiprod/1.  %% meta clause   (meta(P))
           %%predheads/1. %% Collection of all predicate definitions found (for module header)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A / B     means   " A using all of B before success
% A - B     means   " A using (all of) B some time "
% A \ B     means   " A using (all of) B from the beginning " 
% A = B     means   " A using exactly B ( intentionally )

% Runtime routines are placed in utility.pl

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% RS-131228
%segram:- %% short %% norsource facilities %% TA-100207
%    nodebug, 
%    norsource := true,
%    consult(gramn),
%    makegram.

%regram:- %% short 
%    nodebug, 
%    consult(gramn),
%    makegram.



%%DEBUG
%%gram_module(norsk,   gram_n).
%%dcg_file(norsk,   'dcg_n.pl'). %% MAIN -> tucbuses

%% RS-131227 makegram/0 /1 /5 is used IN tucbuses!  %% Avoid circles!   % makegram :- ...
%makegram :-
%    nodebug, %% TA-001027      %% RS-131227 Verify that this work, and TURN OFF AGAIN!
%    language(Lang), %% RS-131228 NOT working when compiling just metacomp.pl (with makegram.)!
%    % (language(Lang) -> true ; Lang==norsk),
%    makegram(Lang).

makegram( DAGFILE, DICTFILE, DCGFILE, DCGMODULE, GRAMMODULE ):-
    retractall( virtf(_,_) ),
    retractall( virtx(_) ),
    retractall( optiprod(_) ), 
    %%retractall(predheads(_) ),

    told,       %% Close all current output streams
    write('%    .....metacomp.pl~100: making file.....: '), write(DCGFILE),nl,

    %% In other prologs than Sicstus: open is the same as  tell('dcg.pl'), plus UTF-8 encoding  %% RS-121121
    open( 'dcg.pl', write, DcgStream, [encoding('UTF-8')] ),
    set_output(DcgStream),
        writeheading,           %% write('%% '),write(dadatetimenl,
        write('%% FILE '),write(DCGFILE),nl,
        write('%% Automatically created by tuc/metacomp.pl, based on dict and tuc/gram_...'),nl, nl,
        write(':- ensure_loaded( user:declare ). %% RS-111213 General (semantic) Operators, ...'), nl,
        write(':- use_module( \'utility/utility\', [ testmember/2 ] ).  %% RS-131228'),nl, nl,
        write('%:- ensure_loaded( '), write(DCGMODULE),write(':\''),write(DAGFILE),write('\' ). %%, [ cc/5, w6 ] ). %% RS-140209 What is DAG?'), nl,
        write(':- use_module( \''),write( DAGFILE ),write('\', [  ] ). %% cc/5, w6, RS-111213 What is DAG? '),nl,
        write(':- prolog_flag(discontiguous_warnings,_,off).'),nl,nl,
        
        write(':- use_module( \'utility/datecalc\', [ add_days/3, addtotime/3, datetime/6, days_between/3, easterdate/2, subfromtime/3, this_year/1, timenow/1, today/1, todaysdate/1 ] ).  %% RS-131228'),nl,
        write(':- use_module( \'db/timedat\', [ dedicated_date/1, named_date/2 ] ). %% RS-131228' ),nl,
        write(':- use_module( \''), write(DICTFILE), write('\' , [] ). %%, [ preposition/1 ] ). %% RS-111213 Dictionary lookups'),nl,
        write(':- use_module( \'tuc/fernando\' ). %%, [ adj_compl/6, adjname_template2/3, adjnamecomp_template/3, adjnoun_template/4, adjustprep/3, adjust_year/3, adjustprepv/3, %% and many more...' ), nl,
%        write('         adj_template/5, adv_compl/6,  align_measure/5, align_noun_name/5,  alignable/2, atom_templ/2,  atv_template/6,  bealign/5, bigno/3, cat_templ/5,' ), nl,
%        write('         clock_test/1,   co_template/6, comparad/5,     compare/5,      compatvar/2,            compliancetest/2,       compliancetest2/3, %%' ), nl,
%        write('         compoundtest/4, constrain/2,    constrain0/2,  constrain2/3,   constrainit/2,  ctype/2,' ), nl,
%        write('         dayname/1,      decide_adjective/3,            decide_quantifier/4,    defact/3,       dtv_template/6, event/4,' ), nl,
%        write('         has_template/3, hour_test/1,    idvarx/3,      isfaktor/1,             issiffer/1,             issifre/1,     it_template/1,   iv_template/4,' ), nl,
%        write('         joinclass/3,  joinclasses/2,    latin/4,       meetclass/3,   monthnumber/2,  negate/3,' ), nl,
%        write('         nil_noun_compl/1,               norpart/3,     noun_adverb/4,          noun_compl/4,   numberdate/2,  plausible_busno/1,' ), nl,
%        write('         plausibleclocktest/3,           pluralis/2,    preadjs_template/4, rep_verb/1,' ), nl,
%        write('         rv_template/7,  screenmeasure/2,               setvartype/2,           subclass0/2,' ), nl,
%        write('         subject_object_test/3,  subtype0/2,    subclass/2,     teen/1,         testconstraint/2,       thenwhat/3,     tidvarp/3, tv_template/5, type/2,' ), nl,
%        write('         value_world/1,  vartype/3,      vartypeid/2,    verb_compl/6, verbtype/2,   which_thing/2, whodunnit/2 ] ). %% RS-140209' ),nl, %% fernando and dcg_n overlaps!
        write(':- use_module( \'tuc/semantic\', [ a_compl/4, abnormalverb/2, adj_templ/2, adjname_templ/2, adjnamecomp_templ/3, adjnoun_templ/2, adjnouncomp_templ/3 ] ). %% RS-131227' ),nl,
        write(':- use_module( \'tuc/semantic\', [ ako/2, aligen2/2, align1/2, coher_class/3, dtv_templ/4, gradv_templ/2, ( has_a )/2, iv_templ/2, jako/2 ] ). %% RS-131227' ),nl,
        write(':- use_module( \'tuc/semantic\', [ measureclass/1, n_compl/3, pai_templ/2, particle/3, post_adjective/1, pvi_templ/2, rv_templ/2, stanprep/2 ] ). %% RS-131227' ),nl,
        write(':- use_module( \'tuc/semantic\', [ testclass/1, tv_templ/3, v_compl/4, vako/2 ] ). %% RS-131227' ),nl,nl,

        write(':- use_module( \'main\', [ traceprint/2 ] ). %%RS-140209 '),nl,
        write(':- use_module( \'tuc/lex\', [ maxl/1, no_unprotected_verb/0, txt/3, unprotected_verb/0 ] ).    %% RS-140209' ),nl,nl,

        write('%% META-PREDICATES'), nl,
        write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'), nl,
        write('test(X):- \\+ ( \\+ ( X)).        %% Calls test(nostation(Y)), test("X ako Y"), among other things, so: make it local in metacomp-> dcg_?.pl'), nl,
        write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'), nl,

        for( ( GRAMMODULE: (X ---> Y) ), genprod(X,Y) ),       %% RS-140101 meta_predicate for/2
    told,
    %%close(DcgStream),     %% RS-121121

    %%tell('virtuals.pl'),      %% In other prologs than Sicstus:  %% RS-121121
    open( 'virtuals.pl', write, VirtualStream, [encoding('UTF-8')] ),
    set_output(VirtualStream),
        writeheading, %% Ends up in the middle of the dcg_e/n-file!
        write(':- ensure_loaded( user:declare ). %% RS-131228 "new syntax" definitions'),nl,nl,
        %% write('%% Automatically created by metacomp.pl, based on dict and tuc/gram_...'),nl,nl,
        for( metacomp:optiprod(MP), metacomp:genprod(optional(MP),(MP,!)) ),
        prite((optional(_,[],X,X) -->[])), 
        for( metacomp:virtx(B),    metacomp:genvirt(B) ),
    told,
    %% close(VirtualStream),     %% RS-121121

       %%  appendfiles('virtuals.pl','dcg.pl',DCG), %%% <--- NO! %%SEQUENCE MATTERS! below...
     appendfiles('dcg.pl','virtuals.pl',DCGFILE),  %% RS-131230 From utility.pl 

     compile(DCGMODULE:DCGFILE),

%    open( 'virtualheaders.pl', write, HeaderStream, [encoding('UTF-8')] ),
%      set_output(HeaderStream),
%        writeheading,           %% write('%% '),write(dadatetimenl,
%        write('%% Automatically created by tuc/metacomp.pl, based on dict and tuc/gram_...'),nl,
%        write('%% FILE '),write(DCGFILE),nl,
%        write(':- ensure_loaded( user:declare ). %% RS-111213 General (semantic) Operators'),nl,
%        write(':-module( \''),write(DCGMODULE),write('\', [ '),nl,    %   write(' \'\\\\\'/7, '), write('  sentence/6 '),
%        for( DCGMODULE:(X --> Y), (make_predname_argscount(X, Pred),write_protected_pred(Pred) ) ),
%
%            %remove_duplicates1(List, Preds),
%            %for(member(I,List),assert(predheads(I))),
%
%            %write_protected_preds(Preds), %% DIFFICULT: \ do (etc.)
%            write(' sentence/6 ] ). %% RS-131229'),nl,nl,
%            %%
%    told,
%    appendfiles('virtualheaders.pl','dcg.pl', DCGFILE), %% THE SEQUENCE MATTERS!

    style_check(+singleton). %% SWI only  

%        for((gram_n: (X ---> Y)), write_pred_argcount(X,Y)),
        %    findall(Pred, ( GRAMMODULE: (X ---> Y), make_predname_argscount(X, Pred) ), List),
        %    findall(Pred, ( DCGMODULE: (X --> Y), make_predname_argscount(X, Pred) ), List),
        %    for( DCGMODULE:(X --> Y), make_predname_argscount(X, Pred) ), List),

%%%%%%%%%%%%%%%%%%%%%
style_check(_).         %% Cheat for Sicstus Prolog (only used for SWI Prolog)
%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END makegram(Lang) %%%%%%%%%%%%%%%%%%%%%%%%%

%% MODULE CONSTRUCTION OF HEADERS %%
make_predname_argscount(X, Pred) :-
        phrase_head_body(X,H,_Body),
        %phrase_head_body(Y,_,Rest),
%        listlength(Body,Length),       %% utility?
%        write(H),write('/'),write(Length),nl,
        Pred = (H)/x. %%Length.

% This is clever: =.. is called the 'univ' predicate, to translate between list and predicate notation.
phrase_head_body(P,H,B) :-
        P =.. [H|B].

%listlength([], 0).     %% BuiltIn!!
%listlength([_ | Tail], Length) :-
%    listlength(Tail, TailLength),
%    Length is TailLength + 1.

write_protected_preds([Head|Tail]) :-
        write_protected_pred(Head),write(', '),nl,
        write_protected_preds(Tail).
write_protected_preds([Head]) :-
        write_protected_pred( Head ),nl.

write_protected_pred(Pred) :-
        Pred == (','/3) ->
                write(' \',\'/3')
                       ;
                write(Pred).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

genprod(X,Y):-
    prod(X,Y,C),
    prite(C).
  

genvirt(A):-
    genprod(A,virtual(A)).

prod(X,Y,(MAX  --> YL)):-
    expandmetahead(X,T,A,Z,MAX),
    expandlist(Y,T,A,Z,YL).

expandlist((Y1,Y2),[H|T],A,Z,(MAX,YL)):-
    !,
    expandmeta(Y1,H,A,B,MAX),
    expandlist(Y2,T,B,Z,YL).

expandlist(Y,[H],A,Z,MAX):-
    expandmeta(Y,H,A,Z,MAX).



%% See http://www.cse.unsw.edu.au/~billw/prologdict.html#univ

expandmetahead(X,T,A,Z,MAX):-
    X =..[H|LIST],
    Parse=[H|T],
    append([H|LIST],[Parse,A,Z],YLIST),
    MAX =.. YLIST.




expandmeta(X,P,Y,Z,MAX):-
    findmetavirts(X),
    em1(X,P,Y,Z,MAX).



em1(A-B,P,X,Y,(pushstack(free ,B,nil,X,BX),MAX)):-  
   !,
   expandmeta(A,P,BX,Y,MAX).

em1(A\B,P,X,Y,(pushstack(first ,B,nil,X,BX),MAX)):-
   !,
   expandmeta(A,P,BX,Y,MAX).

em1(A / B,P,X,Y,(  

   lock(last,X,X1),
   pushstack(last ,B,nil,X1,X2),
   MAX,
   unlock(X3,Y))):-  
   !,
   expandmeta(A,P,X2,X3,MAX).


em1(A = B,P,X,Y,(

   lock(exact,X,X1),
   pushstack(exact ,B,nil,X1,X2),
   MAX,
   unlock(X3,Y))):-  
   !,
   expandmeta(A,P,X2,X3,MAX).




%% em1( Symbol, Appearence, StackIn, StackOut, Code)

em1(Symbol, Appearence, StackIn, StackOut, Code) :-
    user:value(norsource,true),
    !,
    em2(Symbol, Appearence, StackIn, StackOut, Code).

em1(Symbol, Appearence, StackIn, StackOut, Code) :-

    em0(Symbol, Appearence, StackIn, StackOut, Code).

em0(!,!,X,X,!):-!.  %% Standard rendering
em0([],[],X,X,[]):-!.
em0([U],lit(U),X,Y,cc(U,X,Y)):-!.    %%  lit(jeg) 
em0({M:P},{},X,X,{M:P}):-!. 
em0({P},{},X,X,{P}):-!.  %%     NB NB write   {P,Q} as {P},{Q}

em0(X,Free,A,Z,MAX):-
    X =..[H|LIST],
    append([H|LIST],[Free,A,Z],YLIST),
    MAX =.. YLIST.


%% not implemented yet
em2(!,!,X,X,!):-!. %% Rendering with whistles
em2([],[],X,X,[]):-!.
em2([U],lit(U),X,Y,cc(U,X,Y)):-!.    %%  lit(jeg) 
em2({M:P},{},X,X,{M:P}):-!. 
em2({P},{},X,X,{P}):-!.  

em2(X,Free,A,Z,MAX):- %% e.g. noun(bus,sin,u,n) 
    X =..[H|LIST],
    append([H|LIST],[Free,A,Z],YLIST),
    MAX =.. YLIST.
%%%




findmetavirts( _ / Z):-
    !,
    findvirtuals(Z).

findmetavirts( _ \ Z):-
    !,
    findvirtuals(Z).

findmetavirts( _ - Z):-
    !,
    findvirtuals(Z).

findmetavirts( _  = Z):-
    !,
    findvirtuals(Z).

findmetavirts(C):- 
    findmeta(C).


findmeta(optional(X)):-!,foundmeta(X).
findmeta(_).


foundmeta(X):-  %% TA-100114
    var(X),
    !,
    told, %% make message appear online
    nl,
    tell(user),
    write('¤¤¤ CATASTROPHIC ERROR ¤¤¤'),nl,
    write('*** Attempt to make a Variable Meta Production ***'),nl,

    told,
    abort. %% would cut the error message before printing

foundmeta(X):-
    assert(optiprod(X)).
  
%--

findvirtuals((X,Y)):-
    !,
    findvirtual(X),
    findvirtuals(Y).

findvirtuals(X):-
    findvirtual(X).
    

findvirtual(X):- 
    var(X),
    !,
    told, %% make message appear online
    nl,
    tell(user),
    write('%%% CATASTROPHIC ERROR %%%'),nl,
    write('*** Attempt to make a Variable Virtual Production ***'),nl,

    told,

    abort.  %% will cut the error message before printing

    
findvirtual(X):-
   (X=[_];
    X=[];
    X={_};
    X=w(_)),
    !.

findvirtual(A):- 
    remembervirtx(A), %% Must not get variable binding !!!!!
    functor(A,F,N),
    user:remember( metacomp:virtf(F,N) ).  %% RS-131230 From declare.pl

remembervirtx(A) :-
    virtx(B),
    utility:variant(A,B),               %% RS-131230 from utility.pl
    !;
    assert(virtx(A)).
    




prite((X-->Y)):-
    writeq(X),write(' --> '),nl,
    prist(Y).

prist(Y):- var(Y),!,
    write(' *** Fatal error : variable right side ***'),nl,
    plink.

prist((X,Y)) :-
    !,
    write('    '),writeq(X),write(','),nl,
    prist(Y).

prist(X):-
    write('    '),writeq(X),write('.'),
    nl,nl.

% In a module system, runtime system is user.


%% DEBUG prist
plink :- trace.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%for(P,Q):-
%  P,Q,
%  false;true.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% RS-131227 Copied from makeauxtables!
writeheading:-
    datetime(A,B,C,D,E,F),
    write('/* -*- Mode:Prolog; coding:utf-8; -*- */'),        %% Make this work with open/4 and encoding %% RS-121118
    nl,
    write('% Grammar files transformed to dcg.pl '),
    nl,
    write('%%from writeheading in utility/metacomp.pl'),
    nl, write('%% '), write(datetime(A,B,C,D,E,F)),
    nl,nl.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RS-131229    When to do this?        HAS TO BE DONE FROM TUCBUSES!?
%?-tucbuses:compile_english.
%?-tucbuses:compile_norsk.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
