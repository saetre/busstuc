/* -*- Mode:Prolog; coding:utf-8; -*- */
%% FILE teletrans.pl
%% SYSTEM NOTUC
%% CREATED TA-011101
%% REVISED TA-090502

% Transregler for teledomenet

:- module(tele,[]).


:- ensure_loaded('../declare'). %% RS-111213 General (semantic) Operators
:- ensure_loaded('../app/pragma'). %% RS-111213 Pragmatic (rule) Operators

%% Rule format

%   ruleID rule
%   is IS
%   id ID
%   ip IP.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Oversettingsregler
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% rules to handle list of TQL statements

listoftql0 rule
is  [(confirm,_)]
id  add message(answer(bcpbc(ok)))
ip  \+ user: value(dialog,1). 

listoftql1 rule
is  replaceall [(confirm,_)|Y]
    with Y
id  []
ip  \+ user: value(dialog,1).


listoftql2 rule
is  replaceall [X]
    with X
id  []
ip  \+ user: value(dialog,1).

listoftql3 rule
is  replaceall [(doit,replyq(X))|Rest]
    with Rest
id  addfront reply(X)          %% syndrome  Hei ! Jeg heter Tore
                      %% Jeg heter tore -> OK and failure -> negans on do
ip  \+ user: value(dialog,1).

listoftql4 rule
is  replaceall [X|_]
    with X
id  addfront message(onlyonesentence)
ip  \+ user: value(dialog,1).

error rule
is  error
id  add reply('?')
ip  [].

be2 rule  %% alternative formulations, not important here %% TA-060319
is   replaceall which(X),be2/A/X/_
     with       which(A)
id  []
ip  [].


qmess rule  %% TA-060609
is  doit,quit(Mess),
    clear 
id	 clear,
    add message(quit(Mess)),
    add flag(exit)
ip	 [].


givecommand  rule  %% TA-061211
is   replaceall (doit,tuc isa program,give/tuc/AB/_) % event/real/C
     with       (which(AB))
id  []
ip  [].




findcommand  rule  %% alternative formulations, not important here %% TA-060319
is   replaceall (doit,tuc isa program,find/tuc/A/_, A isa Address)
     with       (which(A),A isa Address)
id  []
ip  [].


caniget   rule  %% alternative formulations, not important here %% TA-060319
is   replaceall (test,I isa self,receive/I/A/_,  A isa Address)
     with       (which(A),A isa Address)
id  []
ip  [].



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


startquery rule
is  []
id  not flag(exit), %% TA-060609
    not teleprocess(_,Table,_,_),
    add teleprocess([],Table,[],_)
ip  tablename(Table).



findcity rule
is  X isa city
id  remove teleprocess(Att,Table,L,R),
    add teleprocess(Att,Table,LA,R)
ip  append(L,[city=X],LA).                 %% Keep in order


findstreetodd rule %% TA-020606 // Tors veg , tor first name
is  X isa street, Tor isa firstname,
    has/person/street/Tor/X
id  remove teleprocess(Att,Table,L,R),
    add teleprocess(Att,Table,LA,R)
ip  append(L,[street=Tor],LA).


findspacename1 rule %% hvor er utgangen  %% Ad Hoc %% TA-060419
is  _E isa exit
id  remove teleprocess(Att,Table,L,R),
    add teleprocess(Att,Table,LA,R)
ip  append(L,[spacename=exit],LA).

findspacename2 rule %% hvor er heisen  %% Ad Hoc %% TA-060419
is  _E isa lift
id  remove teleprocess(Att,Table,L,R),
    add teleprocess(Att,Table,LA,R)
ip  append(L,[spacename=lift],LA).

findspacename3 rule %% hvor er toilettet  %% Ad Hoc %% TA-060419
is  _E isa Toilet
id  remove teleprocess(Att,Table,L,R),
    add teleprocess(Att,Table,LA,R)
ip  subclass0(Toilet,toilet),  %% dame-herre %% TA-080818
    append(L,[spacename=Toilet],LA).

findspacename4 rule %% hvor er trappen  %% Ad Hoc %% TA-060420
is  _E isa stair %% ( pl. stairs)
id  remove teleprocess(Att,Table,L,R),
    add teleprocess(Att,Table,LA,R)
ip  append(L,[spacename=stair],LA).

findspacename5 rule %% hvor er inngangen  %% Ad Hoc %% TA-060421
is  _E isa entry
id  remove teleprocess(Att,Table,L,R),
    add teleprocess(Att,Table,LA,R)
ip  append(L,[spacename=entry],LA).





findcompname2 rule %% (tore,amble) isa person %% TA-060324 %% also 3
is  (Tore,Amble) isa person
id  remove teleprocess(Att,Table,L,R),
    add teleprocess(Att,Table,LA,R)
ip  bound(Tore),bound(Amble),                      
    append(L,[firstname=Tore,lastname=Amble],LA).

findfirstname rule
is  X isa firstname
id  remove teleprocess(Att,Table,L,R),
    add teleprocess(Att,Table,LA,R)
ip  bound(X),                                       %% TA-020912
     append(L,[firstname=X],LA).


findlastname rule
is  X isa lastname
id  remove teleprocess(Att,Table,L,R),
    add teleprocess(Att,Table,LA,R)
ip  bound(X),    %% TLF-020918
     append(L,[lastname=X],LA).

findname rule       %% TA-051115 
is  X isa name
id  remove teleprocess(Att,Table,L,R),
    add teleprocess(Att,Table,LA,R)
ip  bound(X),
    append(L,[pname=X],LA). 

findpname rule                                      %% TLF-021115
is  X isa pname
id  remove teleprocess(Att,Table,L,R),
    add teleprocess(Att,Table,LA,R)
ip  bound(X),
     append(L,[pname=X],LA). %%%%%%%%% ??? TA-051028

findtelephone rule                                  %% TLF-020926
is  X isa telephone
id  remove teleprocess(Att,Table,L,R),
    add teleprocess(Att,Table,LA,R)
ip  bound(X),
    append(L,[telephonenumber=X],LA).       %% TA-051031

findnumber rule       %% in Tele, number=telephone    %% TA-051115
is  X isa number
id  remove teleprocess(Att,Table,L,R),
    add teleprocess(Att,Table,LA,R)
ip  bound(X),
    append(L,[telephonenumber=X],LA).       %% TA-051031


finddepartment rule
is  X isa department
id  remove teleprocess(Att,Table,L,R),
    add teleprocess(Att,Table,LA,R)
ip  bound(X),
    expandkey(X,ExpX), %% teledat2 %% TA-061110
    append(L,[department=ExpX],LA).

findstreet rule
is  X isa street
id  remove teleprocess(Att,Table,L,R),
    add teleprocess(Att,Table,LA,R)
ip  bound(X), %% TA-040318
     append(L,[street=X],LA).

findirrelevantfield rule  %% ignore %% TA-060208
is  _ isa meeting,
    has/agent/meeting/_/_
id  []
ip  [].


postulatetitle rule  %%  Hva er Tore Amble -> Tittel %% TA-060209
is  which(X),
    present Tore isa firstname, 
    present Amble isa lastname,
    be2/(Tore,Amble)/X/_
id  remove teleprocess(Att,Table,L,R),
    add    teleprocess(Att1,Table,L,R)
ip  append(Att,[title],Att1).






findnotplacefield rule
is  which(A),B isa C, A isa place, lie1/B/D, srel/in/place/A/D
id  add message(donotknow)
ip	(C = self ; C = program).

findnotplacefield2 rule
is  which(A),present B isa _,A isa place,live/B/C,srel/in/place/A/C,event/real/C
id  add message(donotknow)
ip	[].



%%% For some reason, otherfields will appear first f.b. teleconstraintlist

find3otherfields rule %% Ad Hoc  
is  which((A,B,C)), A isa Title,B isa Address,C isa Room 
id  remove teleprocess(_Att,           Table,L,R),
    add    teleprocess([Title,Address,Room],Table,L,R)
ip  otherfields(List),
    member(Title,List),
    member(Address,List).


find2otherfields rule %% Ad Hoc  
is  which((A,B)), A isa Title,B isa Address 
id  remove teleprocess(_Att,           Table,L,R),
    add    teleprocess([Title,Address],Table,L,R)
ip  otherfields(List), %% parseres.pl
    member(Title,List),
    member(Address,List).

findotherfield rule
is  which(A),A isa B, 
    not  _ isa exit %% Utgangen %% Ad Hoc %% TA-060419
id  remove teleprocess(_Att,Table,L,R),
    add teleprocess([B],Table,L,R)
ip 
    otherfields(List),
	 member(B,List).

findotherfieldbe2 rule  %% new regime %% TA-060319
is  present which(X),   %% TA-060324
    be2/A/X/_,   A isa B,  

    not  _ isa exit %% Utgangen %% Ad Hoc %% TA-060419

id  remove teleprocess(_Att,Table,L,R),
    add teleprocess([B],Table,L,R)
ip  otherfields(List),
	member(B,List).

% which(X),Aisa address,event/real/free(17),be2/free(16)/X/free(17)



findfield rule
is  which(A),A isa B
id  remove teleprocess(_Att,Table,L,R),
    add teleprocess([B],Table,L,R)
ip  teleconstraintlist(List),
	member(B,List).



findotherfield2 rule
is  A isa B,give/_/A/_
id  remove teleprocess(_Att,Table,L,R),
    add teleprocess([B],Table,L,R)
ip  otherfields(List),
	member(B,List).

findfield2 rule
is 	A isa B,give/_/A/_						%% (kan du) gi meg nr til ...
id  remove teleprocess(_Att,Table,L,R),
    add teleprocess([B],Table,L,R)
ip  teleconstraintlist(List),
	member(B,List).

findotherfieldtell rule
is  A isa B,tell/_/A/_
id  remove teleprocess(_Att,Table,L,R),
    add teleprocess([B],Table,L,R)
ip  otherfields(List),
	member(B,List).

findfield3 rule
is 	A isa B,tell/_/A/_						%% (kan du) si meg nr til ...
id  remove teleprocess(_Att,Table,L,R),
    add teleprocess([B],Table,L,R)
ip  teleconstraintlist(List),
	member(B,List).

findotherfieldspace rule   %% hva er romnummeret til utgangen (Ad Hoc)
is  A isa B, F27 isa exit,has/space/B/F27/A     %% TA-060419
id  remove teleprocess(Att,Table,L,R),
    add teleprocess(AttB,Table,LE,R)
ip  otherfields(List),
	 member(B,List),
    append(Att,[B],AttB),
    append(L,[spacename=exit],LE). 


findotherfield3 rule
is  A isa B,has/_/B/_/A					%% har han epostadresse
id  remove teleprocess(Att,Table,L,R),
    add teleprocess(AttB,Table,L,R)
ip  otherfields(List),
	 member(B,List),
    append(Att,[B],AttB). %% TA-051030
   

findfield4 rule
is  A isa B,has/_/B/_/A
id  remove teleprocess(Att,Table,L,R), %% DONT drop it! %% TA-051030
    add teleprocess(AttB,Table,L,R)
ip  teleconstraintlist(List),
	 member(B,List),
    append(Att,[B],AttB).    %% TA-051030

istoreambleteacher rule %% TA-051010 Experiment
is  present Amble isa lastname,
    present Tore isa firstname,
    be2/(Tore,Amble)/T/_,
    T isa Teacher
id  remove teleprocess(Att, Table,L,R),
    add    teleprocess(AttA,Table,L,R)
ip  dmeq(teacher,Teacher), %% title = X ako teacher
    append(Att,[title],AttA).


countfield rule
is  howmany(A),A isa _B
id  remove teleprocess(_Att,Table,L,R),
    add teleprocess([count],Table,L,R)
ip  [].%append(Att,[count],NewAtt).


telf_wholename_city rule
is  which(Tore_amble),
    assume bound(Tore_amble),
    Tore_amble isa Man,
    Th isa city
id   remove teleprocess(Att,Table,L,R),
     add teleprocess(Att,Table,LA,R)
ip  dmeq([person,man,woman,child,boy,girl],Man),
    has_att_valx(person,city,telephone,Th,Tore_amble,_N), %% TA-020508
    append(L,[person=Tore_amble],LA).


telf_wholename rule
is  which(Tore_amble),
    assume bound(Tore_amble),
    Tore_amble isa Man
id  remove teleprocess(Att,Table,L,R),
    add teleprocess(Att,Table,LA,R)
ip  dmeq([person,man,woman,child,boy,girl],Man),
    has_att_val(person,telephone,Tore_amble,_N),
    append(L,[person=Tore_amble],LA).

%% Tore Amble

telf_lastname rule
is  which(Amble),
    assume bound(Amble),
    Amble isa lastname
id  remove teleprocess(Att,Table,L,R),
    add teleprocess(Att,Table,LA,R)
ip  has_att_valx(person,lastname,telephone,Amble,Tore_amble,_N),
    append(L,[person=Tore_amble],LA).


% Hva er nummeret til Tore Amble i Trondheim?
num_name_in_city rule
is  which(A),Th isa city,Tore_amble isa person,A isa telephone,
    nrel/in/person/city/Tore_amble/Th,
    has/person/telephone/Tore_amble/A
id  remove teleprocess(Att,Table,L,R),
    add teleprocess(Att,Table,LA,R)
ip  has_att_val(person,telephone,Tore_amble,_N), %%  TA has 1 phone in Th
    has_att_val(person,city,Tore_amble,Th),     %%         2 phone in Oslo
    append(L,[person=Tore_amble],LA).


names_tel_city  rule
is  which(A),Th isa city,Tore_amble isa person,A isa telephone,
    nrel/in/telephone/place/A/Th,has/person/telephone/Tore_amble/A
id  remove teleprocess(Att,Table,L,R),
    add teleprocess(Att,Table,LA,R)
ip  has_att_val(person,telephone,Tore_amble,_N),
    has_att_val(person,city,Tore_amble,Th),
    append(L,[person=Tore_amble],LA).


names_tel  rule
is  which(X),Tore_amble isa person,X isa telephone,has/person/telephone/Tore_amble/X
id  remove teleprocess(Att,Table,L,R),
    add teleprocess(Att,Table,LA,R)
ip  has_att_val(person,telephone,Tore_amble,_N),
    append(L,[person=Tore_amble],LA).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tracevalue(L) :- user:value(traceprog,L).  % Trace level 1-6



%%% Other rules (makes a buslog equivalent program, without bus handeling)


%%%% TA-060209

setexdate1 rule   %% Set date if another day 
is  not (YMD isa date) cond bound(YMD),  %% another date overrules  
    context(U isa Monday), assume dmeq(mtwtfss, Monday),
    not  comp/day/ne/_/U           %% not excluded ! 
id  not atdate(date(_,_,_)), 
    add atdate(date(X,Y,Z)),
    addcon atday(Monday)  %% <---------- %% TA-050808
ip  today(Thursday),
    Thursday \== Monday,
    user:number_of_days_between(Thursday,Monday,N),  
    user:finddate(N,date(X,Y,Z)).






%%%%% What time and date %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Hva er klokka?
whattime1 rule
is  exactly (which(Clock1),Clock2 isa clock)  %% TA-990215
id  add (timenow(T),timeis(T))
ip  Clock1==Clock2.          %% Alarm

% fortell hva klokka er
whattime2 rule
is  tuc isa program,Clock2 isa clock,tell/tuc/Clock2/_   %% TA-991028
id  add (timenow(T),timeis(T))
ip  [].

% vet du klokka  / vet du hva klokka er ?
whattime3 rule
is  tuc isa program,Clock2 isa clock,knowthing/tuc/Clock2/_   %% TA-991028
id  add (timenow(T),timeis(T))
ip  [].

% Hva er klokka?
210 rule
is  exactly (which(A),B isa clock,
             be1/A/C,event/real/C,srel/nil/time/B/C) %% TA-990305,A isa thing)
id   add (timenow(T),timeis(T))
ip   [].

% Hva er klokka?
211 rule
is  exactly (which(Time),Time isa Timeq)
id   add (timenow(T),timeis(T))
ip    dmeq([time,clock],Timeq). %% not duration   %% TA-990916

% Hva er klokka nå?
212 rule
is  exactly (which(A),B isa Timeq,be1/A/C,event/real/C,
             srel/nil/time/B/C,srel/now/time/nil/C)
id   add (timenow(T),timeis(T))
ip    dmeq(time,Timeq).

% What is the time?
214 rule
is  exactly (which(A),A isa Timeq,event/real/_)
id   add (timenow(T),timeis(T))
ip   dmeq(time,Timeq), unbound(A). %% TA-990503

% What is the time now?
215 rule
is  exactly (which(A),A isa Timeq,be1/A/B,event/real/B,srel/now/_/nil/B)
id   add (timenow(T),timeis(T))
ip    dmeq(time,Timeq).

% What time is it?
216 rule
is  exactly (which(A),A isa Timeq,be1/A/B,event/real/B)
id   add (timenow(T),timeis(T))
ip    dmeq(time,Timeq).

% What time is it now?
217 rule
is  exactly (which(A),A isa Timeq,be1/_/B,event/real/B,
                 srel/nil/time/A/B,srel/now/time/nil/B)
id   add (timenow(T),timeis(T))
ip   dmeq(time,Timeq).

% What is your clock .
whattime10  rule
is (tuc isa program,has/system/clock/tuc/A,A isa clock)
id   add (timenow(T),timeis(T))
ip  unbound(A).  %% avoid lunch syndrom



% What is the day/date? (no calculations !)
217 rule
is  exactly (which(A),A isa DayDate,be1/A/B,event/real/B,srel/today/day/nil/B)
id   atday(Day),
     add (datetime(Year,Month,DayNr,_,_,_),dateis(Year,Month,DayNr,Day))
ip   dmeq(dayordate,DayDate),today(Day).


% What is the day/date? (no calculations !)
218 rule
is  exactly (which(A),A isa DayDate,be1/A/B,event/real/B)
id   atday(Day),
     add (datetime(Year,Month,DayNr,_,_,_),dateis(Year,Month,DayNr,Day))
ip   dmeq(dayordate,DayDate),today(Day).


%%%%%%%%  SMALLTALK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Statements that obviously challenge the system
% Copied from bustrans


whoareyou1 rule
is  which(TUC),(TUC isa program,event/real/_)
id  add(message(answer((bcpbc(telebuster)))))
ip  dmeq(tuc,TUC).

whoareyou2 rule
is  %% which(A), %% TA-990908
    (has/agent/name/B/A,B isa program,A isa name)
id  add(message(answer((bcpbc(telebuster)))))
ip  [].

whoareyou3 rule
is  which(A),(be_named/tuc/A/_)
id  add(message(answer((bcpbc(telebuster)))))
ip  [].

whoareyou4 rule
is  which(tuc),(tuc isa program,event/real/_)
id  add(message(answer(bcpbc(telebuster))))      %% Special because tuc isa program is
ip  [].                                       %% a truncated doublette


whoareyou5 rule
is  which(A),(A isa oracle,event/real/_)      %% TA-990104
id  add(message(answer(bcpbc(telebuster))))       %%
ip  [].


whoareyou6 rule
is  (which(A),be_named/A/tuc/D,event/real/D) %% TA-990513
id   add(message(answer(bcpbc(telebuster))))
ip  [].

whoareyou7 rule
is  which(tuc),tuc isa program
id	add(message(answer((bcpbc(program)))))
ip  [].



%% What is the meaning of life




life42 rule
is  which(A),(has/life/meaning/B/A,A isa meaning,B isa life) % ,event/real/_)
id  add message(answer((bcp(42))))
ip [].


life43 rule
is  which(M),(be1/M/E, srel/_/thing/L/E, M isa meaning, L isa life) %% TA-990218
id  add message(answer((bcp(42))))
ip [].


life44 rule %% TA-990609
is  test,42 isa meaning,F1 isa life,be1/42/F2,event/real/F2,
    srel/(with)/thing/F1/F2
id  add true
ip [].




life45 rule %% TA-990208
is  exactly (which(A),(A isa meaning))
id  add  message(howtuchelp)
ip [].

life46 rule %% TA-991003 %% hvorfor finnes busstuc  %% TA-991003
is  explain,Bustuc isa program,be1/Bustuc/E,event/real/E
id  add  message(howtuchelp)
ip  dmeq(tuc,Bustuc).

life41 rule
is  which(A),A isa meaning,B isa life,nrel/(with)/meaning/thing/A/B
id  add message(answer((bcp(42))))
ip  [].

385 rule
is  explain,be1/tuc/A, srel/HOME/PLACE/nil/A %% why are you here
id  addfront message((howtuchelp))
ip  dmeq(where,HOME),dmeq([place],PLACE). %% TA-990615

386 rule
is  explain,adj/_/make/tuc/_ %% TA-991207  %% why are you made ?
id  addfront message((howtuchelp))
ip  [].


391 rule
is  be1/tuc/E, srel/to/purpose/_/E %% why are you here
id  addfront message((howtuchelp))
ip  [].


398 rule
is  explain,be1/tuc/_   %% why are you here
id  addfront message((howtuchelp))
ip  [].

399 rule
is  which(A),(tuc isa program,work/tuc/B,srel/(with)/thing/A/B)
id  addfront message((howtuchelp))
ip  [].

%% cards

cards rule  %% TA-990622
is _ isa card
id
   add (has_att_val(company,webaddress,tt,K), %% TT has info about cards %% TA-990609
        message(answer(db_reply(tt,webaddress,K)))),  %% will be executed in order
   addfront(message(noinfoabout(card)))               % add last to be first !
ip [].

%% special tickets

specuialticket rule  %% TA-990622
is _ isa special_ticket
id
   add (has_att_val(company,webaddress,tt,K), %% TT has info about cards %% TA-990609
        message(answer(db_reply(tt,webaddress,K)))),  %% will be executed in order
   addfront(message(noinfoabout(special_ticket)))     % % add last to be first !
ip [].


%% seats

seats rule  %% TA-990301
is  _ isa seat
id  addfront(message(noinfoabout(seat)))
ip  [].

accident rule
is  _ isa accident %% TA-991111
id  addfront(message(noinfoabout(accident)))
ip  [].




%% size

size rule
is B52 isa bus, S isa Size, has/object/Size/B52/S
id addfront(message(noinfoabout(Size)))
ip dmeq(measure,Size).


177 rule
is has/vehicle/size/_/_
id addfront(message(noinfoabout(size)))
ip [].


%  Internet
internet rule %% TA-990428
is  _internet isa network ,
    clear     %% no use in ask for specifications when that is the problem
id	 add message(noinfoabout(network))
ip	 [].


%  Weather
weather1 rule
is  _ isa weather % ,C isa Timeq,rain/D/E,srel/in/time/C/E
id	 add message(noinfoabout(weather))
ip	 [].

%  Weather
weather2 rule  %% TA-990504
is  adj/_/cold/_/_
id	 add message(noinfoabout(weather))
ip	 [].


%  Weather
weather3 rule  %% TA-990929
is  _ isa rain
id	 add message(noinfoabout(weather))
ip	 [].


thanks1 rule %% Acknowledge praise
is  (A isa self,adj/_/impressed/A/_)
id  add message(answer((bcpbc(thanks))))
ip  [].


% where am i?
3867 rule
is  which(A),B isa self,be1/B/C,event/real/C,srel/in/place/A/C
id	 add message(donotknow)
ip	 [].


gas rule
is  srel/on/gas/_/_
id  addfront(message(noinfoabout(gas)))
ip  [].


goddagmann rule
is  howmany(Bus),present Bus isa Frog % avoid GodDagMannØkseskaft answers (GDMØ)
id  not message(_Already), %% TA-991111
    addfront message(donotknow)
ip  \+ dmeq(busdeparr,Frog),
    \+ dmeq(place,Frog).

% Kan du tenke?
4013 rule
is  test,tuc isa program,think/tuc/_
id	 addfront message(donotknow)
ip	 [].                          %% " what do you think ? "


%%%%%END OF SMALLTALK%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


unknownfield rule
is  which(A),A isa T, {T \= thing}       %% Ad Hoc  hva er Telf til TA
id  remove teleprocess(_Att, Table, L,R), %% TA-100826
   	add teleprocess([*],Table, L,R) %% TA-050920 Reset attribute list
ip  [].

unknownfield2 rule
is  A isa _B,give/_/A/_
id  remove teleprocess(_Att, Table, L,R),
	add teleprocess([unknown],Table, L,R)
ip  [].

unknownfield3 rule
is  A isa _B,tell/_/A/_
id  remove teleprocess(_Att, Table, L,R),
	add teleprocess([unknown],Table, L,R)
ip  [].

unknownfield4 rule
is  A isa B,has/_/B/_/A
id  remove teleprocess(_Att, Table, L,R),
	add teleprocess([unknown],Table, L,R)
ip  [].


%%%%%%%%%%%%%%%%%%%%%%%%%%

/* %% dmeq is already supposed to be in module user

dmeq(A,B):-         %% TA-051011 Separated out from teletrans
    user:dmeq(A,B). %% File dmeq.pl

*/



