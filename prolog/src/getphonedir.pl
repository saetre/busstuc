/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE  getphonedir.pl
%% SYSTEM TeleTUC
%% CREATED TA-020621
%% REVISED TA-070612


:- use_module(library(system)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


texec(A,B,C):-  
    exec(A,B,C).

tshell(A):-  
    shell(A).


getdbtagsdirect(TagSum, Result) :-   

   %append_atomlist(['javaw ldapconnection.LDAPSearcher tag ', TagSum], Expression),


  (value(windowsflag,true) ->  
        Expression = 'javaw ldapconnection.LDAPSearcher'
        ; 
        Expression = 'java ldapconnection.LDAPSearcher'
  ),


  open('theparam.txt',write,Stream),
      write(Stream,'tag '),
      write(Stream,TagSum),
      nl(Stream),
  close(Stream),


track(1, (write('*** Tag: '),out(Expression), write('tag '), write(TagSum), nl)),

   texec(Expression, [pipe(Instream), pipe(Outstream), std], _Pid),

   current_input(OldInput),
   set_input(Outstream),
   Instream = '$stream'(InputstreamNo),
   Outstream = '$stream'(OutputstreamNo),

   % store the streams for later use
   outstream := InputstreamNo,
   instream  := OutputstreamNo,

   get_chars_t(Result),
   set_input(OldInput).




getdbrowsdirect(Query, Result) :-

   %append_atomlist(['javaw ldapconnection.LDAPSearcher srch "', Query, '"'], Expression),


  (value(windowsflag,true) ->  
        Expression = 'javaw ldapconnection.LDAPSearcher'
        ; 
        Expression = 'java ldapconnection.LDAPSearcher'
   ),


   %write('java 3'), nl,
   %write(Expression), nl, 


  open('theparam.txt',write,Stream),
      write(Stream,'srch '),
      write(Stream,Query),
      nl(Stream),
  close(Stream),



track(2, (write('*** Db: '),out(Expression),
         write('srch '), write(''''),write(Query),write(''''), nl,nl)), 
   
   texec(Expression, [pipe(Outstream), pipe(Instream), std], _Pid),

   set_input(Instream),
   get_chars_t(Result),
   write(Outstream,quit),
   (seen).      %% Interferes with pragma-rule "seen"


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


emptytag :-
    tshell('cp empty tagsample0').


emptyrow :-
    tshell('cp empty rowsample0').


streamnoisopen(StreamNo) :-
	stream_property(Stream,type(_)),
	Stream = '$stream'(StreamNo).

reset_ldapcon :-
	%% Find and close old stream
	value(outstream, OutstreamNo),
	streamnoisopen(OutstreamNo),
	current_output(OldOutput),
	set_output('$stream'(OutstreamNo)),
	nl,		%% send empty line to java-prog to terminate it
	set_output(OldOutput),
	outstream := 0,
	instream := 0.



%%%% Moved from telebustermain.pl  

create_tags(L) :- % ,Tags):-  %% tags ... mostly for traceing
    %teledbtagfile(File),
    idiotpoint, %% idle spypoint
    create_taggercall(L,PAT),
    x_getdbtags(PAT,Tags,Compnames) ,

    prune_tags(Tags,Tags0),

    update_tags(Tags0),      %% Will cause lex to include these tags

    update_compnames(Compnames).                            %% MTK 021018

%% HitMark    X/Y    Exact hits/ All hits
%% Det er fordi deltreff også inkluderer de eksakte.
%% KUN deltreff = deltreff - eksakte


prune_tags(L,L4):- 

    remove_spurious_depnames(L,L1),  %% ntnu -> department

    remove_spurious_lastnames(L1,L2),  %% arne -> fornavn

    remove_spurious_firstnames(L2,L3),  %% bosted -> etternavn

    remove_hitmarks(L3,L4).


remove_spurious_lastnames(L,L1):-
    rem_spu_lastnames(L,L1).

%%  last names that appear 0 exact, and  as first names with >0  exact match
rem_spu_lastnames(L,[[Arne,firstname,EX1/PA1]|L3]):- 
    delete1([Arne,firstname, EX1/PA1],L,L1),
    EX1 > 0,
    !,
    set_eliminate(X,(X=[Arne,lastname,0/_]),L1,L2),
    rem_spu_lastnames(L2,L3).
rem_spu_lastnames(L,L).



remove_spurious_firstnames(L,L1):- %% bostad -> lastname
    rem_spu_firstnames(L,L1).

rem_spu_firstnames(L,[[Bostad,lastname,EX1/PA1]|L3]):- 
    delete1([Bostad,lastname, EX1/PA1],L,L1),
    EX1 > 0,
    !,
    set_eliminate(X,(X=[Bostad,firstname,0/_]),L1,L2),
    rem_spu_firstnames(L2,L3).
rem_spu_firstnames(L,L).





remove_spurious_depnames(L1,L2):-
    rem_spu_depnames(L1,L2).

rem_spu_depnames(L,[[NTNU,department,EX/PA]|L3]):-
    delete1([NTNU,department,EX/PA],L,L1),
    EX > 0,
    !,
    set_eliminate(X,(X=[NTNU,_,_]),L1,L2),
    rem_spu_depnames(L2,L3).
rem_spu_depnames(L,L).


remove_hitmarks(L2,L3):-
    set_ops([A,B],member([A,B,_HM],L2),L3). %% only 1





x_getdbtags(PAT,Tags,Compnames) :- %% TLF-030408
    value(useexternal,true),
    !,
    getdbtagsdirect(PAT,Input),
    xml_parse(Input,XML),
    xml_subterm(XML, element(result,_,Data)),
    !,
    parse_tags(Data,T,C),!,
    remove_duplicates(T,Tags),
    remove_duplicates(C,Compnames),
    nl,nl,
    track(2, ( 
        write('tags = '),output(Tags),
        write('compnames = '),output(Compnames),nl)
    ).


x_getdbtags(_,_) :- 
    \+ value(useexternal,true),
    !,
    output('useexternal flag is false -> no tagging performed').


x_receive_tags(Tags,Compnames,File) :-           %%
    value(useexternal,true),
    !,
    y_receive_tags(Tags,Compnames,File).            %% MTK 021018/TLF

x_receive_tags(_,_,_):-  %%
    \+value(useexternal,true).




idiotpoint. %%

send_taggercall(Taggercall):-  %% CRITICAL
     write_taggercall(Taggercall).

receive_tags(Struct):-
    teledbtagfile(Tagsample),
    xmltaggerparse(Tagsample,Struct),
    nl,nl,
    output(Struct).


y_receive_tags(Tags,Compnames,File) :-          %% MTK 021018/TLF
    see(File),
    get_chars(Input),
    (seen),
    xml_parse(Input,XML),
    xml_subterm(XML, element(result,_,Data)),
    !,
    parse_tags(Data,T,C),
    remove_duplicates(T,Tags),
    remove_duplicates(C,Compnames),
    nl,nl,
    trackprog(3, (
        write('tags = '),output(Tags),
        write('compnames = '),output(Compnames))
    ).


reset_tags :- %% TA-061009

   tags := [].


update_tags(K):-

   tags := K.

%update_compnames(Compnames) :-                  %% MTK 021018
%    remove_dummycomps(Compnames,Compnames2),
%    compnames := Compnames2.
%
%remove_dummycomps(Compnames,Compnames2):-
%    set_filter(X, \+(X = [Lehre,[],Lehre]),Compnames,Compnames2).
%
%
%
%
%create_taggercall(L2,PAT):-
%
%    append_synnames(L2,L3), %% add synnames (torbjorn=torbjørn)
%                            %%  BEFORE taggercall
%    
%    remove_hasardousnames(L3,L4), %% hvilken tittel har  per borgesen
%
%    listtoplus(L4,P2),
%    plustoatom1(P2,PAT).
%
%append_synnames(L2,L3):- 
%    value(busflag,true), %% TA-060613
%    \+ value(teleflag,true), %% TA-080407 (not bor -> bro(
%    !,
%    set_ops(Y,(member(X,L2),synname(X,Y)),Z), %% seq. pres 
%    append(L2,Z,L3).
%append_synnames(L,L).
%
%
%remove_hasardousnames(L3,L4):-
%   set_ops(X,( member(X,L3), \+ hazardous_tagname(X)),L4).   %% sequence preserving
%
%
%
hazardous_tagname(X):- %% TA-060213
 \+ legal_tagname(X),  %% db/teledat2

 (   
    number(X);         %% TA-060214

    value(language,N),dict_module(N,L),L:cw(X);             %% tuc/dict_ %% TA-070612

    hazard_tagname(X) %%  db/teledat2
 ).




%write_taggercall(Taggercall) :-
%    nl,
%    write('TAGGING:   '),output(Taggercall),
%    nl,nl.
%
%listtoplus(L2,P2):- %% tricky  + is left assoc
%    reverse(L2,R2),
%
%    skipmarks(R2,R3),
%
%    ltoplus(R3,P2).
%
%skipmarks(R2,R3):-
%   purge(['.','?','!'],R2,R3).
%
%ltoplus([Z,Y|X], ( UY+Z)):-
%    !,
%    ltoplus([Y|X],UY).
%
%ltoplus([X],X).
%ltoplus([],[]). 
%
%
%plustoatom(A+B,AB):- !,%% jævla hack
%    plustoatom(A,A1),
%    plustoatom(B,B1),
%    append_atomlist([A1,'+',B1],AB).
%plustoatom(X,X).
%
%plustoatom1(A+B,AB):- !,%% uses spaces instead of plus %% TLF-030218
%    plustoatom1(A,A1),
%    plustoatom1(B,B1),
%    append_atomlist([A1,' ',B1,' '],AB). %% EXTRA BLANK TO AVOID hvem har telefonnummer94451'
%plustoatom1(X,X).                        %% DEVIL
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
